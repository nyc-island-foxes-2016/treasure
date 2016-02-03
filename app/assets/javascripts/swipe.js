$(document).ready(function(){

  var nextItemObject;
  var match;
  var swipeDirection;
  var currentObject;
  var matchResponse;

// Handle left or right swipes via clicking the respective buttons
    $(".swipe-action").on("submit", function(event) {
      event.preventDefault();
      var id = "#" + $(event.target).attr("id");
      swipeDirection = event.target.childNodes[3].value;
      $.ajax({
        type: "POST",
        url: "/swipes",
        data: $(id).serialize(),
        dataType: "JSON"
      }).done(function(firstResponse){
        matchResponse = firstResponse;
        $.ajax({
          url: "/available_items",
          dataType: "JSON"
        }).done(function(secondResponse){
            nextItemObject = secondResponse;
            $(".swipe-action input")[3].value = nextItemObject.id;
            $(".swipe-action input")[8].value = nextItemObject.id;
        }).then(function(event) {
          if (matchResponse.match){
            currentItemName = $("#item-container h3").html()
            updateMatchModal(currentItemName)
            $('#myModal').modal({show: true})
          }
          if (nextItemObject.message != "No More Items") {
            if (swipeDirection == "R") {
              $( "#item-container" ).animate({ marginLeft: "10em", opacity: 0 },
                      { duration: 400,
                      complete: function() {
                      $( "#item-container" ).remove();
                      $( ".available-items-container" ).prepend( buildSwipeItem(nextItemObject) );
                    }
                  });
            } else if (swipeDirection == "L") {
              $( "#item-container" ).animate({ marginRight: "10em", opacity: 0 },
                      { duration: 400,
                      complete: function() {
                      $( "#item-container" ).remove();
                      $( ".available-items-container" ).prepend( buildSwipeItem(nextItemObject) );
                    }
                  });
            }
          } else {
            $('.available-items-container').html("No more swipes! Come back later.");
          }
        });
      });
    });


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
         $.ajax({
            url: "/available_items",
            dataType: "JSON"
          }).done(function(secondResponse){
            nextItemObject = secondResponse;
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
          matchResponse = firstResponse;
         $.ajax({
            url: "/available_items",
            dataType: "JSON"
          }).done(function(response){
            nextItemObject = response;
            $(".swipe-action input")[3].value = nextItemObject.id;
            $(".swipe-action input")[8].value = nextItemObject.id;
          }).then(function(event) {
            if (matchResponse.match){
              currentItemName = $("#item-container h3").html()
              updateMatchModal(currentItemName)
              $('#myModal').modal({show: true})
            }
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

  function updateMatchModal(item_name) {
    $("#myModalLabel").html("You matched with " + item_name + "!")
  }
});

