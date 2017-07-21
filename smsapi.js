// twilio credentials
var accountSid = "AC79f4453f1c21160ab31afecf4950ae0f";
var authToken = "6729dfaf9b101e565d727160b55349a0";

// require the Twilio module and create a REST client
var client = require('twilio')(accountSid, authToken);

function send_message(player) {
	client.messages.create({
		to: "+61423440445",
		from: "+61428094760",
		body: "TWILIO IS AMAZEBALLS!",
	}, function(err, message) {
		if (err) console.log(err.message);
		if (message) console.log(message.sid);
	});
}

send_message();
