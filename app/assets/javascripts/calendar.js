// カレンダーのデザインなどの設定
$('#calendar').fullCalendar({
  header: {
    left: 'prev,next today',
    center: 'title',
    right: 'month,agendaWeek,agendaDay'
  },
  navLinks: true,
  selectable: true,
  selectHelper: true,
  timezone: 'UTC',
  events: '/events.json',
  editable: true,
});
