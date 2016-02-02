$(document).ready(function() {

  $('#main-body').on('submit', '#new_message', function(event){
    var print =  event;
    event.preventDefault();

    var form = this;
    var request_url = $(this).attr('action');
    var ajaxRequest = $.ajax({
      url: $(form).attr('action'),
      method: $(form).attr('method'),
      data: $(form).serialize()
    })
    ajaxRequest.done(function(response){
      $('#chat-sm').html(response);
      $('#btn-input').val("");
      $("html, body").animate({ scrollTop: $(document).height() }, "slow");
      return false;
    });
  });

  function loadMessages() {
    var fragments = window.location.href.split('/');
    var matchId = fragments[fragments.length -1];
    var url = '/messages/' + matchId;
    $.get(url).done(function(response){
      $('#chat-sm').html(response);
    });
  }

  if ($('#chat-sm').length) {
    setInterval(loadMessages, 5000);
  }


});



