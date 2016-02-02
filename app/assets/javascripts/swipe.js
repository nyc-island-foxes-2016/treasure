$(document).ready(function(){

  var nextItemObject;
  var match;

// Handle left or right swipes via clicking the respective buttons
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
            $("#item-container").html(buildSwipeItem(nextItemObject));
          } else {
            $('.available-items-container').html("No more swipes! Come back later.");
          }
        });
      });
    });

// $( ".swipe-action" ).submit(function() {
//   $( "#item-container" ).animate({ marginLeft: "15em", opacity: 0 },
//       { duration: 5000,
//       complete: function() {
//       $( this ).after( buildSwipeItem(nextItemObject) );
//     }
//   });
// });

// Handles left and right swipes via keyboard clicks on right and left arrows
    $(document).on("keyup", function(event) {
      event.preventDefault();
      if (event.keyCode == 37) {
        $.ajax({
          type: "POST",
          url: "/swipes",
          data: $("#swipe-left").serialize(),
          dataType: "JSON"
        }).done(function(firstResponse){
          match = firstResponse;
         $.ajax({
            url: "/available_items",
            dataType: "JSON"
          }).done(function(response){
            nextItemObject = response;
            $(".swipe-action input")[3].value = nextItemObject.id;
            $(".swipe-action input")[8].value = nextItemObject.id;
          }).then(function(event) {
            if (nextItemObject.message != "No More Items") {
              $( "#item-container" ).animate({ marginRight: "15em", opacity: 0 },
                    { duration: 400,
                    complete: function() {
                    $( "#item-container" ).remove();
                    $( ".available-items-container" ).prepend( buildSwipeItem(nextItemObject) );
                  }
                });
            } else {
              $('.available-items-container').html("No more swipes! Come back later.");
            }
          });
        });
      } else if (event.keyCode == 39) {
        $.ajax({
          type: "POST",
          url: "/swipes",
          data: $("#swipe-right").serialize(),
          dataType: "JSON"
        }).done(function(firstResponse){
          match = firstResponse;
         $.ajax({
            url: "/available_items",
            dataType: "JSON"
          }).done(function(response){
            nextItemObject = response;
            $(".swipe-action input")[3].value = nextItemObject.id;
            $(".swipe-action input")[8].value = nextItemObject.id;
          }).then(function(event) {
            if (nextItemObject.message != "No More Items") {
              $( "#item-container" ).animate({ marginLeft: "15em", opacity: 0 },
                    { duration: 400,
                    complete: function() {
                    $( "#item-container" ).remove();
                    $( ".available-items-container" ).prepend( buildSwipeItem(nextItemObject) );
                  }
                });
            } else {
              $('.available-items-container').html("No more swipes! Come back later.");
            }
          });
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

