// Lightbox for login

$(document).ready(function() {

    var form_login = $('.form_login');

    // open lightbox form
    $('.show_login').on('click', function(e){
        console.log("run");
        e.preventDefault();
        form_login.animate({
          top: 0
          }, {
          duration: 200
          
        });
    });

    // close lightbox form
    $('.close').on('click', function(){
       form_login.animate({
          top: -200
          }, {
          duration: 200
          
        });
    });



});  // end doc ready


$( "#go" ).click(function() {
  $( ".block:first" ).animate({
    left: 100
  }, {
    duration: 1000,
    step: function( now, fx ){
      $( ".block:gt(0)" ).css( "left", now );
    }
  });
});