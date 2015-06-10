#Create local collection and set up timezones, this will make searching easier to implement
@_timezones = new Mongo.Collection null
Meteor.startup ->
	timezones = moment.tz.names()

	_.each timezones, (timezone) ->
		_timezones.insert
			timezone:timezone

Template.created "complex_form", ->
	@timezone_search = new ReactiveVar ""
	@completed_form = new ReactiveVar {}

Template.complex_form.events
	"click input.highlight_on_click": (event) ->
		#iOS compatible
		$(event.currentTarget)[0].setSelectionRange 0, $(event.currentTarget).val().length

	"keyup input#timezone": _.throttle (event,i) ->
			value = $(event.currentTarget).val()

			i.timezone_search.set value
		,500

	"click .timezone": (event,i) ->
		event.preventDefault()
		form = i.completed_form.get()
		_.extend form,
			timezone:@timezone

		i.completed_form.set form
		i.timezone_search.set ""

	"click .identify_timezone": (event,i) ->
		current_timezone = tzdetect.matches()[0]

		if current_timezone
			form = i.completed_form.get()
			_.extend form,
				timezone:current_timezone

			i.completed_form.set form
			i.timezone_search.set ""

	"click .gender": (event,i) ->
		value = $(event.currentTarget).attr "value"

		form = i.completed_form.get()
		_.extend form,
			gender:value

		i.completed_form.set form

	"change #first": (event,i) ->
		value = $(event.currentTarget).val()

		form = i.completed_form.get()
		_.extend form,
			first:value

		i.completed_form.set form

	"change #last": (event,i) ->
		value = $(event.currentTarget).val()

		form = i.completed_form.get()
		_.extend form,
			last:value

		i.completed_form.set form

	"submit form.form": (event,i) ->
		event.preventDefault()

		console.log i.completed_form.get()


Template.complex_form.helpers
	"completed_form": ->
		Template.instance().completed_form.get()

	"timezones": ->
		search = Template.instance().timezone_search.get()

		if search and not _.isEmpty search
			_timezones.find
					timezone:
						$regex: search
						$options:"i"
				,
					limit:10





