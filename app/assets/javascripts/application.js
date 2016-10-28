// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require ckeditor/initgit
//= require_tree

$(document).ready(function($) {
  $(".btn-cat").on("click", function(event) {
    $("#categorization-form-div").show();
  });

  $(".col-sm-10").on("submit", "#categorization-form-div", function(event) {
    event.preventDefault();
    var form = $(this).find("form");
    console.log(form);
    $.ajax({
      url: '/categorizations',
      type: 'POST',
      data: form.serialize(),
    })
    .done(function(categorization) {
      console.log(categorization);
      $("#category-list").append(categorization);
      $("#categorization-form-div").hide();
    })
    .fail(function(categorization) {
      console.log("error");
      console.log(categorization);
    })
    .always(function() {
      console.log("complete");
    });

  })
});
