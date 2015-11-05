//= require active_admin/base
//= require just_datetime_picker/nested_form_workaround

$(document).ready(function() {
	$('.user_category_all').change(function () {
		console.log("change");
	    if ($('.user_category_all').is(":checked")) {
	    	$('.user_category').each( function(i, el) {
	    		console.log("set false");
	    		console.log(el);
	    		$(this).prop('checked', true);
	    	});
	    } else {
	    	$('.user_category').each( function() {
	    		$(this).prop('checked', false);
	    	});
	    }
	});

	$('#notification_venue_id').change(function () {
		$('#notification_event_id').val('');
	});
	
	$('#notification_event_id').change(function () {
		$('#notification_venue_id').val('');
	});
	
});

$(document).load(function() {

	var map;
	function initMap() {
	  map = new google.maps.Map(document.getElementById('map'), {
	    center: {lat: -34.397, lng: 150.644},
	    zoom: 8
	  });
	}

	


});

