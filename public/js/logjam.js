$(document).ready(function() {
  var socket = io.connect(window.location.href);
  var container = $('#log');

  socket.on('new-data', function(data) {
    var shouldScroll = scrolledToBottom();
    var newItem = $('<div>' + data.value + '</div>');
    container.append(newItem);
    if (shouldScroll) {
      window.scrollTo(0,document.body.scrollHeight);
    }
  });

  function scrolledToBottom() {
    var currentScroll = $(document).scrollTop(),
        totalHeight   = document.body.offsetHeight,
        visibleHeight = document.documentElement.clientHeight;

    return totalHeight <= currentScroll + visibleHeight;
  }
});
