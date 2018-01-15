  $(document).ready(function(){
    $('.rating').rating();
    const rating_func = (value) => $("#rating-score").val(value)
    $('#user-rating').rating({ onRate: rating_func });
  });
