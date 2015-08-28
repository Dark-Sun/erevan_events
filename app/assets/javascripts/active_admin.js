//= require active_admin/base
//= require just_datetime_picker/nested_form_workaround

$(document).load(function() {

	var map;
	function initMap() {
	  map = new google.maps.Map(document.getElementById('map'), {
	    center: {lat: -34.397, lng: 150.644},
	    zoom: 8
	  });
	}

});