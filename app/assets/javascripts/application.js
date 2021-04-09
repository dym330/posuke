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
      businessHours: {
        daysOfWeek: [ 1, 2, 3, 4, 5 ],
        startTime: '8:00',
        endTime: '20:00',
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