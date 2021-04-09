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
//= require moment
//= require fullcalendar
//= require_tree .

$(function () {
  var employee_id = $('#calendar').data("employee-id");
  $('#calendar').fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      events: '/employees/' + employee_id +'/calendars.json',
      defaultView: 'agendaWeek',             // 初期表示ビュー
      eventLimit: true,                      // allow "more" link when too many events
      firstDay: 0,                           // 最初の曜日, 0:日曜日
      weekends: true,                        // 土曜、日曜を表示
      weekMode: 'fixed',                     // 週モード (fixed, liquid, variable)
      weekNumbers: false,                    // 週数を表示
      slotDuration: '00:30:00',              // 表示する時間軸の細かさ
      snapDuration: '00:15:00',              // スケジュールをスナップするときの動かせる細かさ
      minTime: "00:00:00",                   // スケジュールの開始時間
      maxTime: "24:00:00",                   // スケジュールの最終時間
      defaultTimedEventDuration: '10:00:00', // 画面上に表示する初めの時間(スクロールされている場所)
      allDaySlot: false,                     // 終日スロットを非表示
      allDayText:'allday',                   // 終日スロットのタイトル
      slotMinutes: 15,                       // スロットの分
      snapMinutes: 15,                       // 選択する時間間隔
      firstHour: 9,  
  });
});