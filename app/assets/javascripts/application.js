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
  controller_name = document.getElementById('bodyid').dataset.controller;
  action_name = document.getElementById('bodyid').dataset.action;

  // calecdarsのindexページの時のみfullcalendarを適応させる
  if (controller_name === 'calendars' && action_name === 'index') {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
      },
      selectable: true,
      initialView: 'dayGridMonth',
      events: '/employees/' + calendarEl.dataset.employeeId + '/calendars.json',
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
        let start_time = info.dateStr;
        let end_time = info.date;
        end_time.setHours(end_time.getHours() +1);
        if (info.dateStr.indexOf('+') != -1) {
          const year = end_time.getFullYear();
          let month = end_time.getMonth();
          let day = end_time.getDate();
          let hour = end_time.getHours();
          month = ('0' + month).slice(-2);
          day = ('0' + day).slice(-2);
          hour = ('0' + hour).slice(-2);
          start_time = start_time.substring(0, start_time.indexOf('+'));
          end_time = year + '-' + month + '-' + day + 'T' + hour + ':00:00';
        } else {
          const now_date = new Date();
          const later_date = new Date();
          later_date.setHours(later_date.getHours() + 1);
          start_time = info.dateStr + 'T' + now_date.getHours() + ':00:00';
          end_time = info.dateStr + 'T' + later_date.getHours() + ':00:00';
        }
        // 予定投稿モーダルの初期値
        $('#schedule_title').val('')
        $('#schedule_start_time').val(start_time)
        $('#schedule_end_time').val(end_time)
        $('#schedule_content').val('')
        // 予定投稿モーダルの表示
        $('#inputScheduleForm').modal("show");
      }
    });
    calendar.render();
  }
});