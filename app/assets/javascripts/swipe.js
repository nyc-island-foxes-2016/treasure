$(document).ready(function(){

  var nextItemObject;
  var match;


    $(".swipe-action").on("submit", function(event) {
      event.preventDefault();
      var id = "#" + $(event.target).attr("id");
      $.ajax({
        type: "POST",
        url: "/swipes",
        data: $(id).serialize(),
        dataType: "JSON"
      }).done(function(firstResponse){
        match = firstResponse;
        $.ajax({
          url: "/available_items",
          dataType: "JSON"
        }).done(function(secondResponse){
            nextItemObject = secondResponse;
            $(".swipe-action input")[3].value = nextItemObject.id;
            $(".swipe-action input")[8].value = nextItemObject.id;
        }).then(function(event) {
          if (nextItemObject.message != "No More Items") {
            console.log("done", nextItemObject, match);
            $("#item-container").html(buildSwipeItem(nextItemObject));
          } else {
            $('.available-items-container').html("No more swipes! Come back later.");
          }
        });
      });
    });

    $(document).on("keyup", function(event) {
      event.preventDefault();
      if (event.keyCode == 37) {
        $.when($.ajax({
          type: "POST",
          url: "/swipes",
          data: $("#swipe-left").serialize(),
          dataType: "JSON"
        }).done(function(response){
          match = response;
        }).fail(function(response){
        }), $.ajax({
            url: "/available_items",
            dataType: "JSON"
          }).done(function(response){
            nextItemObject = response;
            $(".swipe-action input")[3].value = nextItemObject.id;
            $(".swipe-action input")[8].value = nextItemObject.id;
          }).fail(function(response){
          })).then(function(event) {
            if (nextItemObject.message != "No More Items") {
              console.log("done", nextItemObject, match);
              $("#item-container").html(buildSwipeItem(nextItemObject));
            } else {
              $('.available-items-container').html("No more swipes! Come back later.");
            }
          });
      } else if (event.keyCode == 39) {
        $.when($.ajax({
          type: "POST",
          url: "/swipes",
          data: $("#swipe-right").serialize(),
          dataType: "JSON"
        }).done(function(response){
          match = response;
        }).fail(function(response){
        }), $.ajax({
            url: "/available_items",
            dataType: "JSON"
          }).done(function(response){
            nextItemObject = response;
          }).fail(function(response){
          })).then(function(event) {
            console.log("done", nextItemObject, match);
            $(".swipe-action input")[3].value = nextItemObject.id;
            $(".swipe-action input")[8].value = nextItemObject.id;
            $("#item-container").html(buildSwipeItem(nextItemObject));
          });
      }
    });


function buildSwipeItem(item) {
  return ["<div id='item-container'>",
          "<img class='avatar' src='" + item.avatar_file_name + "' alt='" + item.name + "'>",
          "<h3>" + item.name + "</h3>",
          "<p>" + item.description + "</p>",
          "</div>"].join("");
  };
});




//   function swipeLeft() {
//     $("#left-swipe").on("submit", function(event) {
//       event.preventDefault();
//     $.ajax({
//           type: "POST",
//           url: "/swipes",
//           data: $("#left-swipe").serialize(),
//           dataType: "JSON"
//         }).done(function(response){
//           //Changing hidden value for item id on left swipe form
//           $("#left-swipe input")[3].value = response.item.id
//           $('#item-container').html(buildSwipeItem(response.item));
//         }).fail(function(response){
//           console.log("NAH", response);
//         });
//     });
//   };
//   swipeLeft();

// // another function talks to items controller to get next item and only is a get

// // once done, do jquery

//   function swipeRight() {
//     $("#right-swipe").on("submit", function(event) {
//       event.preventDefault();
//     $.ajax({
//           type: "POST",
//           url: "/swipes",
//           data: $("#right-swipe").serialize(),
//           dataType: "JSON"
//         }).done(function(response){
//           //Changing hidden value for item id on left swipe form
//           $("#right-swipe input")[3].value = response.item.id
//           $('#item-container').html(buildSwipeItem(response.item));
//         }).fail(function(response){
//           console.log("NAH", response);
//         });
//     });
//   };
//   swipeRight();

//   $(document).on("keyup", function(event) {
//     if(event.keyCode == 37) {
//       // $('#item-container').addClass('move-left');

//       event.preventDefault();
//       $.ajax({
//         type: "POST",
//         url: "/swipes",
//         data: $("#left-swipe").serialize(),
//         dataType: "JSON"
//               }).done(function(response){
//         $("#left-swipe input")[3].value = response.item.id
//         $('#item-container').html(buildSwipeItem(response.item));
//         $('#item-container').removeClass('move-left');
//       }).fail(function(response){
//         console.log("NAH", response);
//       });
//     } else if(event.keyCode == 39) {
//        $('#item-container').addClass('move-right');
//         event.preventDefault();
//         $.ajax({
//         type: "POST",
//         url: "/swipes",
//         data: $("#right-swipe").serialize(),
//         dataType: "JSON"
//               }).done(function(response){
//         $("#right-swipe input")[3].value = response.item.id
//         $('#item-container').html(buildSwipeItem(response.item));
//         $('#item-container').removeClass('move-right');
//       }).fail(function(response){
//         console.log("NAH", response);
//       });
//     };
//   });













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
