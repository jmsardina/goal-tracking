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

  $.ajaxSetup({
   headers: {
     'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
   }
  });

  $.ajax(href, {
    method: "PATCH",

    data: $form.serialize()
    // "success": function(response){
    //   $checkbox.parents("li:first").toggleClass("completed");
    // }
  })
}

Activity.edit = function(e){
  e.preventDefault();
  var $li = $(this).parents("li:first");
  $li.addClass("editing");
  $("input.edit", $li).focus();
  $('select', $li).focus();
}

function hideEditInPlace($li){
  $li.removeClass("editing");
}

Activity.clear = function(e){
  $("button.clear-completed").parents().find($("li.completed").addClass("hidden"));
}

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
  var $tr = $(this).parents("tr");
  var href = $("form", $tr).attr("action");
  debugger
  $.ajax({
    "url": href,
    "method": "DELETE",
    "success": function(){
      debugger
      $tr.slideUp(function(){
        $(this).remove();
      });
    }
  })
}

function showActivityForm(){
  // $(this).parents().find($("form#edit-activity.hidden").removeClass("hidden"));
  $(this).parents("div.view").children("div#edit-activity.hidden").removeClass("hidden")
}

$(function(){
  $("ul.list").on("change", "input:checkbox", Activity.updateStatus);
  $("ul.list").on("submit", "form.update", Activity.updateContent);
  $("ul.list").on("dblclick", "li form label", showActivityForm);
  // $("ul.list").on("dblclick", "li label", Activity.edit);
  // $("ul.list").on("dblclick", "span.act-frequency", Activity.edit);
  // $("ul.list").on("dblclick", "span.act-period", Activity.edit);
  // $("ul.list").on("blur", "li input.edit", Activity.stopEdit);
  $("button.clear-completed").on("click", Activity.clear);
  $("button.show-completed").on("click", Activity.show);
  $("ul.list").on("click", "button.destroy", deleteActivity);
  addActivityListener();
  $("form#new_activity").hide()
  $("button#show-activity-form").on("click", $("form#new-activity").toggle())
});
