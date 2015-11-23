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

	console.log(data)

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
		data.forEach(function (week, index) {
		var tcell = 
			tbody
				.append('tr').attr('class', 'cal-row')
				.selectAll('td')
				.data(data[index])
				.enter()
				.append('td')
				.attr('class', function (d) {
					return d.date > 0 ? 'cal-box' : '';	
				})
				.text(function (d) {
					return d.date > 0 ? d.date : '';
				});
			tcell
				.append('div')
				.attr('class', 'event')
				.text(function (d) {
					console.log(d['events'][0])
					if (d["events"].length > 0) {
						return d.date > 0 ? d["events"][0]["name"]: '';
					} else {
						return '';
					}
				})
		});	
});	