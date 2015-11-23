$(document).ready(function() {
	var weeks0 = JSON.parse(gon.weeks0)
	var weeks1 = JSON.parse(gon.weeks1)
	var weeks2 = JSON.parse(gon.weeks2)
	var weeks3 = JSON.parse(gon.weeks3)
	var weeks4 = JSON.parse(gon.weeks4)
	var data = [];
	data.push(weeks0);
	data.push(weeks1);
	data.push(weeks2);
	data.push(weeks3);
	data.push(weeks4);

	// 	.selectAll('tr')
	// 	.data(data)
	// 	.enter()
	// 	.append('tr')
	// 	.attr('class', 'cal-row');

	var table = d3.select('#user-calendar');
	var header = table.append('thead')
	var dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

	header
		.append('tr')
		.attr('class', 'uc-header')
		.append('td')	
		.attr('colspan', 7)
		.text(gon.month)
		.append('small')
		.text(gon.year)

	header
		.append('tr')
		.selectAll('td')
		.data(dayNames)	
		.enter()
		.append('td')
		.attr('class', 'dayName')
		.text(function (d) {
			return d;
		})

	table.append('tbody')
	var tbody = d3.select('tbody')
		data.forEach(function (week) {
		var tcell = 
			tbody
				.append('tr').attr('class', 'cal-row')
				.selectAll('td')
				.data(week)
				.enter()
				.append('td')
				.attr('class', function (d) {
					return d.date > 0 ? 'cal-box' : '';	
				});
			tcell
				.text(function (d) {
					return d.date > 0 ? d.date : '';
				});

			var tdiv = tcell
						.append('div')
						// .attr('class', 'event')

			var links = tdiv.selectAll('p')
				.data(function (d) {
					return d["events"];
				})
				.enter()
				.append('p')
				.attr('class', 'event');
			links			
				.attr('data-toggle', 'modal');
			links
				.attr('data-target', '#event_info');
			links
				.attr('data-artist', function (event) {
					return event.artist;
				});
			links
				.attr('data-date', function (event) {
					return event.date;
				});
			links
				.attr('data-location', function (event) {
					return event.location;
				});
			links
				.text(function (event) {
					return event.artist;
				});
			

			// Working code
			// var tdiv = tcell
			// 	.append('div')
			// 	.attr('class', 'event');
			// tdiv
			// 	.attr('data-toggle', 'modal');
			// tdiv
			// 	.attr('data-target', '#event_info');

			// tdiv.text(function (d) {
			// 		if (d["events"].length > 0) {
			// 			return d.date > 0 ? d["events"][0]["name"]: '';
			// 		} else {
			// 			return '';
			// 		}
			// 	})
		});	


	$('#event_info').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var artist = button.data('artist') // Extract info from data-* attributes
	  var date = button.data('date')
	  var location = button.data('location')
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.event-artist').text(artist)
	  modal.find('.event-date').text(date)
	  modal.find('.event-location').text(location)
	});

});	

// artist
// date
// location
// if price (url)




