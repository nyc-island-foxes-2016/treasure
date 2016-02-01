$(document).ready(function(){

  function swipeLeft() {
    $("#left-swipe").on("submit", function(event) {
      event.preventDefault();
    $.ajax({
          type: "POST",
          url: "/swipes",
          data: $("#left-swipe").serialize(),
          dataType: "JSON"
        }).done(function(response){
          //Changing hidden value for item id on left swipe form
          $("#left-swipe input")[3].value = response.item.id
          $('#item-container').html(buildSwipeItem(response.item));
        }).fail(function(response){
          console.log("NAH", response);
        });
    });
  };

  swipeLeft();

  $(document).on("keyup", function(event) {
    if(event.keyCode == 37) {
      // $('#item-container').addClass('move-left');

      event.preventDefault();
      $.ajax({
        type: "POST",
        url: "/swipes",
        data: $("#left-swipe").serialize(),
        dataType: "JSON"
              }).done(function(response){
        $("#left-swipe input")[3].value = response.item.id
        $('#item-container').html(buildSwipeItem(response.item));
        $('#item-container').removeClass('move-left');
      }).fail(function(response){
        console.log("NAH", response);
      });
    } else if(event.keyCode == 39) {
       $('#item-container').addClass('move-right');
    };
  });



function buildSwipeItem(item) {
  return ["<div id='item-container'>",
          "<img class='avatar' src='" + item.avatar_file_name + "' alt='" + item.name + "'>",
          "<h3>" + item.name + "</h3>",
          "<p>" + item.description + "</p>",
          "</div>"].join("");
  };
});









// $(document).ready(function(){

//     $(".buddy").on("swiperight",function(){
//       $(this).addClass('rotate-left').delay(700).fadeOut(1);
//       $('.buddy').find('.status').remove();

//       $(this).append('<div class="status like">Like!</div>');
//       if ( $(this).is(':last-child') ) {
//         $('.buddy:nth-child(1)').removeClass ('rotate-left rotate-right').fadeIn(300);
//        } else {
//           $(this).next().removeClass('rotate-left rotate-right').fadeIn(400);
//        }
//     });

//    $(".buddy").on("swipeleft",function(){
//     $(this).addClass('rotate-right').delay(700).fadeOut(1);
//     $('.buddy').find('.status').remove();
//     $(this).append('<div class="status dislike">Dislike!</div>');

//     if ( $(this).is(':last-child') ) {
//      $('.buddy:nth-child(1)').removeClass ('rotate-left rotate-right').fadeIn(300);
//       alert('Na-na!');
//      } else {
//         $(this).next().removeClass('rotate-left rotate-right').fadeIn(400);
//     }
//   });

// });
