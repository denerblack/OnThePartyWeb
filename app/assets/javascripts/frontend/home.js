// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require ./cufon-yui
//= require ./cufon-replace
//= require ./NewsGoth_BT_400.font
//= require ./NewsGoth_BT_700.font
//= require ./jcarousellite
//= require ./jquery.easing.1.3
//= require ./jquery.mousewheel
//= require ./atooltip.jquery
//= require ./scripts
//= require ../rhinoslider/rhinoslider-1.05.min
//= require ../rhinoslider/mousewheel
//= require ../rhinoslider/easing

$(document).ready(function() {
  $('#slider').rhinoslider({
    effect: 'kick',
    controlsPlayPause: false,
    autoPlay: true,
    showCaptions: 'always',
    controlsMousewheel: false,
    controlsKeyboard: false
  });

  $('#slider .banner').click(function(e){
    window.open($(this).attr('banner_url'))
    e.preventDefault()
  })
});