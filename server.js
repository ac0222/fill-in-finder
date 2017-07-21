var mysql = require('mysql');
var express = require('express');
var bodyParser = require('body-parser');
var sprintf = require("sprintf-js").sprintf;
var db_functions =  require('./db_functions');
var sms_functions = require('./sms_functions');
var port_number = 6969;

// set up database connection
var con = mysql.createConnection({
	host: "db4free.net",
	port: 3306,
	user: "ttadmin69",
	password: "tabletennis",
	database: "rapidfireleague"
});

// set up express
var app = express();

app.use(bodyParser.urlencoded({extended: true}));

app.get('/', function(req, res) {
	res.sendFile(__dirname + '/index.html');
});

app.post('/msgs', function(req, res) {
	var parsed_sms = sms_functions.handle_sms(req);
	var player = null;
	//var action_summary = "";
	var pnum = parsed_sms[0];
	var msg = parsed_sms[1];

	console.log(pnum + "||" + msg);
	db_functions.verify_msg(con, pnum, msg, function(player) {
		if (player != null) {
			console.log(player);
			var msg_class = msg_classifier(msg);
			if (msg_class == "fir") {
				console.log("request");
				db_functions.handle_fill_in_request(con, player, function(result) {
					sms_functions.send_out_requests(result);
				});
			} else if (msg_class == "fio") {
				console.log("offer");
				db_functions.handle_fill_in_offer(con, player, function(fir, fill_in) {
					sms_functions.confirm_fill_in(fir, fill_in);
				});
			} else {
				console.log("unrecognized message");
			}
		} else {
			console.log("unrecoginzed pnum");
		}
		res.redirect('/');
	})
});

con.connect(function(err) {
	if (err) {
		throw err;
	}
	console.log("Connected!");
	// only start listening if we connect successfully
	app.listen(port_number, function() {
		console.log("listening on " + port_number);
	});
});

// miscellaneous
function msg_classifier(msg) {
	if (msg.indexOf("fill in request") != -1) {
		return "fir";
	} else if (msg.indexOf("fill in offer") != -1) {
		return "fio";
	} else {
		return null;
	}
}

