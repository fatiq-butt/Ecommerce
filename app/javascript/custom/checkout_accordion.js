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

  $('#payment_checkout_cont_btn').on("click", function(){
    $('#payment_checkout_cont_btn').attr("disabled", true);
    $.ajax({
      url: '/checkout/confirmation',
      type:'POST',
      data: {
        country: $('#country_select_dropdown_checkout').val(),
        state: this.value
    }});

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
