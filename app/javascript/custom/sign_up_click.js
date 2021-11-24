$(document).on('turbolinks:load', function () { 
  if ($("#sign_up_link.errors").length > 0)
  {
    $("#sign_up_link.errors")[0].click()
  }
});
