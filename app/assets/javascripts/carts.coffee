# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ()->
	$('#use_billing_address').on 'change', ()->
		if $(this).is(':checked')
			$('#shipping_address').addClass 'hidden'
		else
			$('#shipping_address').removeClass 'hidden'
