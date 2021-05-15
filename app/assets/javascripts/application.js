// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
// require turbolinks
//= require_tree .

document.addEventListener('DOMContentLoaded', function() {
  const controllerName = document.getElementById('bodyid').dataset.controller;
  const actionName = document.getElementById('bodyid').dataset.action;
  const calendarEl = document.getElementById('calendar');

  // calecdarsのindexページの時のみfullcalendarを適応させる
  if (controllerName === 'calendars' && actionName === 'index') {
    const calendarEmployeeId = calendarEl.dataset.employeeId
    const currentEmployeeId = calendarEl.dataset.currentEmployeeId
    const calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
      },
      selectable: true,
      initialView: 'dayGridMonth',
      events: '/employees/' + calendarEmployeeId + '/calendars.json',
      navLinks: false,
      businessHours: true,
      locale: 'ja',
      nowIndicator: true,
      allDaySlot: false,
      scrollTime: '08:00:00',
      businessHours: {
        daysOfWeek: [ 1, 2, 3, 4, 5 ],
        startTime: '8:00',
        endTime: '20:00',
      },
      views: {
        timeGridWeek: {
          titleFormat: function (date) {
            const startMonth = date.start.month + 1;
            const endMonth = date.end.month + 1;
            // 1週間のうちに月をまたぐかどうかの分岐処理
            if (startMonth === endMonth) {
              return startMonth + '月';
            } else {
              return startMonth + '月～' + endMonth + '月'; 
            }
          },
          dayHeaderFormat: function (date) {
            const day = date.date.day;
            const weekNum = date.date.marker.getDay();
            const week = ['(日)', '(月)', '(火)', '(水)', '(木)', '(金)', '(土)'][weekNum];
            return day + ' ' + week;
          }
        }
      },
      buttonText: {
        today:    '今日',
        month:    '月',
        week:     '週',
        day:      '日',
        list:     'リスト'
      },
      dateClick: function(info) {
        if (calendarEmployeeId == currentEmployeeId) {
          let start_time = info.dateStr;
          let end_time = info.date;
          end_time.setHours(end_time.getHours() +1);
          if (info.dateStr.indexOf('+') != -1) {
            // "2021-04-30T14:00:00"の表記で保存
            start_time = start_time.substring(0, start_time.indexOf('+'));
            end_time = dateAndTimeShaping(end_time)
          } else {
            const nowDate = new Date();
            const laterDate = new Date();
            laterDate.setHours(laterDate.getHours() + 1);
            // "2021-04-30T14:00:00"の表記で保存
            start_time = info.dateStr + 'T' + ('0' + nowDate.getHours()).slice(-2) + ':00:00';
            if (laterDate.getHours() == 0) {
              end_time.setHours(end_time.getHours() +23);
              end_time = dateAndTimeShaping(end_time)
            } else {
              end_time = info.dateStr + 'T' + laterDate.getHours() + ':00:00';
            }
          }
          // 予定投稿モーダルの初期値
          $('#schedule_title').val('')
          $('#schedule_start_time').val(start_time)
          $('#schedule_end_time').val(end_time)
          $('#schedule_content').val('')
          // 予定投稿モーダルの表示
          $('#inputScheduleForm').modal("show");
        }
      }
    });
    calendar.render();
  }
});

function dateAndTimeShaping(dateAndTime) {
  const year = String(dateAndTime.getFullYear());
  const month = String(dateAndTime.getMonth() + 1).padStart(2, "0");
  const day = String(dateAndTime.getDate()).padStart(2, "0");
  const hour = String(dateAndTime.getHours()).padStart(2, "0");
  return  `${year}-${month}-${day}T${hour}:00:00`;
}