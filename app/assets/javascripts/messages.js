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
      console.log(response);
      $('#chat-sm').html(response);
      $('#btn-input').val("");
      $("html, body").animate({ scrollTop: $(document).height() }, "slow");
  return false;
    });
  });

});



