// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
// require turbolinks
//= require_tree .

$(function() {
  // Setup drop down menu
  $('.dropdown-toggle').dropdown();
 
  // Fix input element click problem
  $('.dropdown input, .dropdown label').click(function(e) {
    e.stopPropagation();
  });
});

if ($(window).width() >= 780) {
    jQuery('ul.nav li.dropdown').hover(function () {
        jQuery(this).find('.dropdown-menu').stop(true, true).delay(50).fadeIn();
    }, function () {
        jQuery(this).find('.dropdown-menu').stop(true, true).delay(50).fadeOut();
    });
}

$(function(){
  $('#profiletabs ul li a').on('click', function(e){
    e.preventDefault();
    var newcontent = $(this).attr('href');
     
    $('#profiletabs ul li a').removeClass('sel');
    $(this).addClass('sel');
     
    $('#content section').each(function(){
      if(!$(this).hasClass('hidden')) { $(this).addClass('hidden'); }
    });
     
    $(newcontent).removeClass('hidden');
  });
});

function CheckMaxlength(oInObj)
{
      var iMaxLen = parseInt(oInObj.getAttribute('maxlength'));
      var iCurLen = oInObj.value.length;

      if ( oInObj.getAttribute && iCurLen > iMaxLen )
      {
          oInObj.value = oInObj.value.substring(0, iMaxLen);
      }
}

jQuery (function ($)
{   // ready
    $(window).resize (function (event)
    {
        var minwidth = 1200;
        var minheight = 1024;

        var bodye = $('body');

        var bodywidth = bodye.width ();

        if (bodywidth < minwidth)
        {   // maintain minimum size
            bodye
                .css ('backgroundSize', minwidth + 'px' + ' ' + minheight + 'px')
            ;
        }
        else
        {   // expand
            bodye
                .css ('backgroundSize', '100% auto')
            ;
        }
    });
});
