$(document).ready(function() {

  $('#main-body').on('submit', '#new_message', function(event){
    var print =  event;
    event.preventDefault();
    var form = this;
    var request_url = $(this).attr('action');
    $.ajax({
      url: $(form).attr('action'),
      method: $(form).attr('method'),
      data: $(form).serialize(),
      dataType: 'json',
    }).done(function(response){
      $('#message').append('<br>' + response.content);
      $("#ajax").css("display", "block");
      $('#message').css("text-align", "left");
    });
  });

});