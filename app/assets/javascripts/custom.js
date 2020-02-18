$(document).ready(function() {
  $('.ui.dropdown').dropdown();
  $('.ui.accordion').accordion();

  // bind "hide and show vertical menu" event to top right icon button
  $('.ui.toggle.button').click(function() {
    $('.ui.vertical.menu').toggle("250", "linear")
  });
});
