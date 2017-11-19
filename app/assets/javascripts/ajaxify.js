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

  //highlight and animate bell ratings
  new BellRating();

}) //doc ready