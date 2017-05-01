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


bodyOnReady(function(){
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
});



var bodyOnReadyAlreadyBeenCalled = false;
function bodyOnReady(func){
	//by Micox - based in jquery bindReady and Diego Perini IEContentLoaded
	//flag global para indicar que já rodou e function que roda realmente

	if ( !bodyOnReadyAlreadyBeenCalled ) {
		bodyOnReadyAlreadyBeenCalled = true;
	} else {
		return false;
		console.log("recall");
	}

	done = false
	init = function(){ if(!done) { done=true; func() } }
	var d=document; //apelido para o document
	//pra quem tem o DOMContent (FF)
	if(document.addEventListener){ d.addEventListener("DOMContentLoaded", init, false );}
	
	if( /msie/i.test( navigator.userAgent ) ){ //IE
		(function () {
			try { // throws errors until after ondocumentready				
				d.documentElement.doScroll("left");
			} catch (e) {
				setTimeout(arguments.callee, 10); return;
			}
			// no errors, fire
			init();
		})();
	}
	if ( window.opera ){
		d.addEventListener( "DOMContentLoaded", function () {
			if (done) return;
			//no opera, os estilos só são habilitados no fim do DOMready
			for (var i = 0; i < d.styleSheets.length; i++){
				if (d.styleSheets[i].disabled)
					setTimeout( arguments.callee, 10 ); return;
			}
			// fire
			init();
		}, false);
	}
	if (/webkit/i.test( navigator.userAgent )){ //safari's
		if(done) return;
		//testando o readyState igual a loaded ou complete
		if ( /loaded|complete/i.test(d.readyState)===false ) {
			setTimeout( arguments.callee, 10 );	return;
		}
		init();
	}
	//se nada funfou eu mando a velha window.onload lenta mesmo
	if(!done) window.onload = init
}