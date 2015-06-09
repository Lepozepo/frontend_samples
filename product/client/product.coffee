Template.rendered "product", ->
	$(".first_fade")
		.removeClass "hidden"

	Meteor.setTimeout ->
			$(".second_fade")
				.removeClass "hidden"
		,1000



