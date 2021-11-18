import 'bootstrap'
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery");
global.$ = jQuery;
require("custom/sign_up_click");
require("custom/checkout_accordion")
import "select2";
import 'select2/dist/css/select2.css';

$(document).on('turbolinks:load', function () { 
  $( ".dropdown_select2" ).select2({
    theme: "bootstrap"
  });
});
