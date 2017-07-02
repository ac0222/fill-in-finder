var mysql = require('mysql');
var express = require('express');
var bodyParser = require('body-parser');
var sprintf = require("sprintf-js").sprintf;
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
	var pnum = req.body.phone_number;
	var msg = req.body.message.toLowerCase();
	var player = null;
	var action_summary = "";

	// first check if the phone number is in our database, and find the player
	// it is linked to
	var verify_pnum_sql = sprintf("SELECT * FROM Player WHERE PhoneNumber='%s'", 
		pnum);
	con.query(verify_pnum_sql, function(err, result, fields) {
		if (err) {
			throw err;
		}
		if (result.length > 0) {
			player = result[0];
			// check what the message says
			if (msg.indexOf("fill in request") != -1) {
				handle_fill_in_request(player, res, action_summary);
			} else if (msg.indexOf("fill in offer") != -1) {
				handle_fill_in_offer(player, res, action_summary);
			} else {
				console.log("unrecognized message");
				action_summary += "unrecognized message\n";
				res.send(action_summary);
			}
		} else {
			console.log("unrecognized phone number");
			action_summary += "unrecognized phone number\n";
			res.send(action_summary);
		}
	});
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

function handle_fill_in_request(player, res, action_summary) {
	// make a new fill in request
	var make_fir_sql = sprintf(
		"INSERT INTO FillInRequest (RequesterID, Active) VALUES (%s, %s)",
		player.PlayerID, 1);
	con.query(make_fir_sql, function(err, result) {
		if (err) {
			throw err;
		}
		console.log("new request added to db");
		action_summary += "new request added to db\n";
		// send a message to all players in the same grade as 
		// the requester, telling them a fill in is needed
		var find_fillins_sql = sprintf(
			"SELECT * FROM Player WHERE Grade='%s'", player.Grade);
		con.query(find_fillins_sql, function(err, result, fields) {
			if (err) {
				throw err;
			}
			// send everyone an sms
			for (var i = 0; i < result.length; i++) {
				console.log("An sms was sent to: " + 
					result[i].FirstName + " " + result[i].LastName);
				action_summary += "<p>An sms was sent to: " + 
					result[i].FirstName + " " + result[i].LastName + "</p>";
			}
			res.send(action_summary);
		});
	});	
}

function handle_fill_in_offer(player, res, action_summary) {
	// find active fill in requests from players of the same grade as the 
	// person offering to fill in
	var find_requests_sql = sprintf(
		"SELECT * FROM FillInRequest INNER JOIN Player " + 
		"ON FillInRequest.RequesterID = Player.PlayerID " + 
		"WHERE (Grade='%s' AND Active!=0)", 
		player.Grade);
	con.query(find_requests_sql, function(err, result, fields) {
		if (err) {
			throw err;
		}
		if (result.length > 0) {
			var fir = result[0];
			// accept the first fill in request that appears, and set it to 
			// inactive
			var complete_fir_sql = sprintf(
				"UPDATE FillInRequest " + 
				"SET Active = 0, FillInID = %s " +
				"WHERE RID=%s", player.PlayerID, fir.RID);
			con.query(complete_fir_sql, function(err, result) {
				if (err) {
					throw err;
				}
				// confirm with the fill in and the absent person
				console.log(sprintf("%s %s will fill in for %s %s, in %s grade",
					player.FirstName, player.LastName, 
					fir.FirstName, fir.LastName, fir.Grade));
				action_summary += sprintf("%s %s will fill in for %s %s, in %s grade",
					player.FirstName, player.LastName, 
					fir.FirstName, fir.LastName, fir.Grade);
				res.send(action_summary);
			});
		} else {
			console.log("no requests match");
			action_summary += "no requests match\n";
			res.send(action_summary);
		}
	});
}


