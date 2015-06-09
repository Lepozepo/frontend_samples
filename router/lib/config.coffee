# Custom render function to avoid repetition
FlowRouter.render = (template_name) ->
	FlowLayout.render "layout",
		nav:"nav"
		content:template_name

# Show Not Found
FlowRouter.notFound =
	action: ->
		FlowRouter.render "not_found"


