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
    });
    calendar.render();
  }
});