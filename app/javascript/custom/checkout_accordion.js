$(document).on('turbolinks:load', function () { 
  $('#country_select_dropdown_checkout').on("change", function(){
    $.ajax({
      url: '/checkout',
      type:'GET',
      data: {
        country: this.value
    }});
  });

  $('#customer_state_dropdown_checkout').on("change", function(){
    $.ajax({
      url: '/checkout',
      type:'GET',
      data: {
        country: $('#country_select_dropdown_checkout').val(),
        state: this.value
    }});
  });

  $('#personal_info_checkout_btn').on("click", function(){
    $('#customer_info_collapse_btn').attr('data-bs-target','#collapseTwo');  
    $('#customer_info_collapse_btn').click(); 
  });

  $('#submit_btn_cust_info_update').on("click", function(){
    $('#payment_info_checout_btn_acordian').attr('data-bs-target','#collapseThree');  
    $('#payment_info_checout_btn_acordian').click();
  });

  $('#payment_info_cont_btn').on("click", function(){
    $('#confirmation_collapse_btn').attr('data-bs-target','#collapseFour');  
    $('#confirmation_collapse_btn').click();
  });

  $('#coupon_code_apply_btn').on("click", function(){
    $.ajax({
      url: '/checkout',
      type:'GET',
      data: {
        coupon_code: $('#coupon_code_input_value').val(),
    }});
  });
});
