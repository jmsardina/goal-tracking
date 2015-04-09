// To mark activities as complete:
  // Add a listener on the activity status checkbox (prop checked)
  // When checked, the activity info should get crossed out
  // change value to "0"
  // Add class complete
function Activity(){
}

Activity.updateContent = function(e){
  e.preventDefault();

  var $form = $(this)
  var href = $form.attr("action");

  $.ajax(href, {
    "method": "PATCH",
    "data": $form.serialize(),
    "success": function(response){
      var newLabelValue = $("input.edit", $form).val();
      var $li = $form.parents("li:first");
      $("label", $li).html(newLabelValue)
      hideEditInPlace($li);
    }
  })
}

Activity.updateStatus = function(e){
  var $checkbox = $(this);
  var $form = $(this).parents("form:first");
  var href = $form.attr("action");

  $.ajax(href, {
    "method": "PATCH",
    "data": $form.serialize(),
    "success": function(response){
      $checkbox.parents("li:first").toggleClass("completed");
    }
  })
}

Activity.edit = function(e){
  e.preventDefault();
  var $li = $(this).parents("li:first");
  $li.addClass("editing");
  $("input.edit", $li).focus();
}

function hideEditInPlace($li){
  $li.removeClass("editing");
}

// Activity.clear = function(){
//   $("button.clear-completed").on("click", function(){console.log("cats")})
// }

Activity.clear = function(e){
  // $("button.clear-completed").parents().find($("li.completed")).fadeOut();
  // if($("button.clear-completed").html() === "Clear Completed Activities"){
  //   $("button.clear-completed").html("Show Completed Activities")}
  //   else {
  //     $("button.clear-completed").html("Clear Completed Activities")
  //   }
  $("button.clear-completed").parents().find($("li.completed").addClass("hidden"));
}

// Activity.updateRendering = function(e){
//   var $button = $(this);
//   var $form = $(this).parents("form:first");
//   var href = $form.attr("action");

//   $.ajax(href, {
//     "method": "PATCH",
//     "data": $form.serialize(),
//     "success": function(response){
//       $checkbox.parents("li:first").toggleClass("completed");
//     }
//   })
// }

Activity.show = function(e){
  $("button.show-completed").parents().find($("li.completed").removeClass("hidden"));
}

Activity.stopEdit = function(e){
  e.preventDefault();
  var $li = $(this).parents("li:first");
  hideEditInPlace($li);

  $("form.update", $li).trigger("submit")
}

function addActivityListener(){
  $("#show-activity-form").click(function(){
      $("form").show();
    });
}

function deleteActivity(e){
  e.preventDefault();
  var $li = $(this).parents("li");
  var href = $("form", $li).attr("action");
 // debugger
  $.ajax(href, {
    "method": "DELETE",
    "success": function(){
      $li.slideUp(function(){

        $(this).remove();
      });
    }
  })
}

$(function(){
  $("ul.list").on("change", "input:checkbox", Activity.updateStatus);
  $("ul.list").on("submit", "form.update", Activity.updateContent);
  $("ul.list").on("dblclick", "li label", Activity.edit);
  $("ul.list").on("blur", "li input.edit", Activity.stopEdit);
  $("button.clear-completed").on("click", Activity.clear);
  $("button.show-completed").on("click", Activity.show);
  $("ul.list").on("click", "button.destroy", deleteActivity);
  addActivityListener();
});
