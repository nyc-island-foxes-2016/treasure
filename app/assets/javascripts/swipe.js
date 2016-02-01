$(document).ready(function(){

  function swipeLeft() {
    $("#left-swipe").on("submit", function(event) {
      event.preventDefault();
    $.ajax({
          type: "POST",
          url: "/swipes",
          dataType: "JSON",
          data: $("#left-swipe").serialize()
        }).done(function(response){
          console.log("YAY");
        }).fail(function(response){
          console.log("NAH");
        });
    });
  };

  swipeLeft();

  $(document).on("keyup", function(event) {
    if(event.keyCode == 37) {
      $('#item-container').addClass('move-left');
      // Ajax get request to replace item with next item
     // Ajax post request to create swipe based on action

    } else if(event.keyCode == 39) {
       $('#item-container').addClass('move-right');

    };
  });




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
