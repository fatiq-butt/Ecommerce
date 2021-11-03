$(document).on('turbolinks:load', function () { 
  if ($(".errors").length > 0)
  {
    $('.errors')[0].click()
  }
});
