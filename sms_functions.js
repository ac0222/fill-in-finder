var sprintf = require("sprintf-js").sprintf;

// SMS functions
function handle_sms(sms) {
	// TODO replace with actual sms parsing code
	var pnum = sms.body.phone_number;
	var msg = sms.body.message.toLowerCase();
	return [pnum, msg];
}

function send_out_requests(players) {
	for (var i = 0; i < players.length; i++) {
		send_sms(players[i].PhoneNumber, "ay can u fill in lol");
		console.log("An sms was sent to: " + 
			players[i].FirstName + " " + players[i].LastName);
	}
}

function confirm_fill_in(fir, fill_in) {
	send_sms(fir.PhoneNumber, "we found a fill in for you, ya scrub");
	send_sms(fill_in.PhoneNumber, "k ur filling in, be there or be square");
	console.log(sprintf("%s %s will fill in for %s %s, in %s grade",
		fill_in.FirstName, fill_in.LastName, 
		fir.FirstName, fir.LastName, fir.Grade));
}

function send_sms(pnum, msg) {
	// TODO replace with actual sms sending function here
	console.log("Phone number: " + pnum + "||" + "Message: " + msg);
}

module.exports = {
	handle_sms: handle_sms,
	send_out_requests: send_out_requests,
	confirm_fill_in: confirm_fill_in
}