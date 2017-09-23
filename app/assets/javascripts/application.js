// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require pusher.min
//= require chessboard-0.3.0.js
//= require_tree .

$(document).ready(function () {

	var CAN_SEARCH = true;


	$(window).bind('beforeunload', function(){
		if (!$('#loading').hasClass("hide")) {
			var data = $.ajax({
			   type: 'DELETE',
		       url: "/chess/cancel_search"
			})
		}
	});

	$('#create_game').submit(function(event) {
		event.preventDefault();


		find_players(get_find_players_form_data(true))

	});
});

var seconds,
	id_game;

function find_players(formData) {
	if (!CAN_SEARCH) {

		var data = $.ajax({
	       type: 'POST',
	       url: "/chess/create_game",
	       data: formData,
	       dataType: "json",
	       success: handle_find_players_data
		 });
	}
}

function cancel_search() {
	var data = $.ajax({
	   type: 'DELETE',
       url: "/chess/cancel_search",
       success: handle_cancel_search
	})
}

function handle_cancel_search() {
	$('select[name=time]')[0].disabled = false;
	$('#ranked')[0].disabled = false;
	$('select[name=player2')[0].disabled = false;
	$('select[name=player3')[0].disabled = false;
	$('select[name=player4')[0].disabled = false;
	$('#start')[0].disabled = false;

	$('#loading').attr('class', 'hide');
	CAN_SEARCH = true;
}

function get_find_players_form_data(first_call) {
	var time_select = $('select[name=time]')[0];
	time = time_select.options[time_select.selectedIndex].value

	var ranked = false;
	if ($('#ranked')[0].checked) {
		ranked = true;
	}

	var player2_select = $('select[name=player2')[0];
	var player2 = player2_select.options[player2_select.selectedIndex].value

	var player3_select = $('select[name=player3')[0];
	var player3 = player3_select.options[player3_select.selectedIndex].value

	var player4_select = $('select[name=player4')[0];
	var player4 = player4_select.options[player4_select.selectedIndex].value

	if (first_call == true) {
		$('#loading-player2')[0].innerHTML = player2;
		$('#loading-player3')[0].innerHTML = player3;
		$('#loading-player4')[0].innerHTML = player4;
		$('#start')[0].disabled = true;
		$('input[name=ranked')[0].disabled = true;
		$('input[name=ranked')[1].disabled = true;
		time_select.disabled = true;
		player2_select.disabled = true;
		player3_select.disabled = true;
		player4_select.disabled = true;
		CAN_SEARCH = false;

		$('#loading').attr('class', '');
	}

	return {"time": time, "ranked": ranked, "player2": player2, "player3": player3, "player4": player4}
}
function handle_find_players_data(data) {
	if (data["id_game"] == null) {
		var player2 = $('#loading-player2')[0];
		var player3 = $('#loading-player3')[0];
		var player4 = $('#loading-player4')[0];

		if (data["player2"] == null) {
			$(player2).attr('class', 'not-found');
		} else {
			$(player2).attr('class', 'found');
		}

		if (data["player3"] == null) {
			$(player3).attr('class', 'not-found');
		} else {
			$(player3).attr('class', 'found');
		}

		if (data["player4"] == null) {
			$(player4).attr('class', 'not-found');
		} else {
			$(player4).attr('class', 'found');
		}

		setTimeout(function() { find_players(get_find_players_form_data(false)); } , 3000);
	} else {
		seconds = 5;
		id_game = data["id_game"];
		count_down();
	}

}

function count_down(){
    var timer = document.getElementById("timer");
    if(seconds > 0){
        seconds--;
        timer.innerHTML = "Starting Game in "+ seconds;
        setTimeout("count_down()", 1000);
    } else {
		window.location.href = '/chess_game/index/' + id_game;
        window.location.href = redirect;
    }
}