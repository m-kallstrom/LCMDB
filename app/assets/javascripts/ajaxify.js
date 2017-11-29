$(document).ready(function(){

  //Update the word count as the user types a review
  $('#reviewtextarea').on("keyup", function(event){
    var $reviewbox = $(this);
    var currentText = $reviewbox.val();
    var wordCount = currentText.split(" ").length;
    var counter = 5 - wordCount;
    var plurals;

    if (counter === 1) {
      plurals = " word"
    } else {
      plurals = " words"
    };

    if (counter >= 1) {
      $('#ratingHelpBlock').text("You have " + counter + plurals + " remaining");

    } else if (counter === 0 ) {
      $('#ratingHelpBlock').text("That's the perfect number of words right there");

    } else {
      $('#ratingHelpBlock').text("Now you've gone too far. " + counter);
    };

  }); //type in review area

  //Submit the form and update the ratings list
  $('.bell-button').on("click", function(e){
    e.preventDefault();
    var $form = $('#ratings-form')
    var $button = $(this)
    var url = $form.attr('action')
    var movie_id = document.getElementById("movie_id").value;

    $request = $.ajax({
      url: url,
      method: "POST",
      data: $form.serialize() + "&rating[value]="+ $button.attr("value"),
    });//ajax request

    $request.done(function(response){
      $('#ratings-list div').remove();
      $('#ratings-list').append(response);
      $get_lr = $.ajax({
        url: "/movies/" + movie_id + "/rating",
        method: "GET",
      });// request inside successful response

      $get_lr.done(function(rating){
        console.log(rating)
        // $('#lorenzini_rating_partial').text(' ');
        $('#lorenzini_rating_partial').html(rating);
      }); //ratings response

    });//response

  });//on submitting the ratings form

  //highlight and animate bell ratings
  new BellRating();

}) //doc ready