var sprintf = require("sprintf-js").sprintf;

// SMS functions
function handle_sms(sms) {
	var pnum = sms.body.phone_number;
	var msg = sms.body.message.toLowerCase();
	return [pnum, msg];
}

function send_out_requests(players) {
	for (var i = 0; i < players.length; i++) {
		console.log("An sms was sent to: " + 
			players[i].FirstName + " " + players[i].LastName);
	}
}

function confirm_fill_in(fir, fill_in) {
	console.log(sprintf("%s %s will fill in for %s %s, in %s grade",
		fill_in.FirstName, fill_in.LastName, 
		fir.FirstName, fir.LastName, fir.Grade));
}

module.exports = {
	handle_sms: handle_sms,
	send_out_requests: send_out_requests,
	confirm_fill_in: confirm_fill_in
}