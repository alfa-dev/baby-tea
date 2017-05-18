// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


$(document).on('turbolinks:load', function(){
	var form = document.querySelector("form");

	if(form) {
		var labels = document.querySelectorAll("form label");
		
		var detectFocus = function(e) {
			var label = this.previousElementSibling;

			if(e.type == "focusin"){
				label.classList.add("focus");
			}
			if(e.type == "focusout" && e.value == ""){
				
				label.classList.remove("focus");
			}
		}

		labels.forEach(function(e){
			var input = e.nextElementSibling;
			
			if ( input.type == "text" || input.type == "number" ){

				e.classList.add("withJs");

				input.addEventListener('focusin', detectFocus);
				input.addEventListener('focusout', detectFocus);
			}
		});	
	}


	var timeoutHandle = null;
	$(".empty-list a").on("mouseover", function(){
		$(".empty-list .emoji").html("😊");

		if(timeoutHandle){
		    clearTimeout(timeoutHandle);
		    timeoutHandle = null;
		}
		timeoutHandle = setTimeout(function () {
		    $(".empty-list .emoji").html("😴");
		}, 5000);
	});

	var $menu = $("#user .menu");
	$("#user .menu-button").on("click", function(){
		$menu.toggleClass("active");

		return false;
	});

	var lastScrollTop = 0;
	$(window).scroll(function(event){
	   var st = $(this).scrollTop();
	   if (st > lastScrollTop){
	       $("#user").slideUp("fast");
	   } else {
	       $("#user").slideDown("fast");
	   }
	   lastScrollTop = st;
	});
});