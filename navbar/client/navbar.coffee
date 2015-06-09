Template.nav.helpers
	active: (route) ->
		FlowRouter.watchPathChange()
		current_route = FlowRouter.current().route.name
		if current_route and current_route is route
			return "active"

