var mysql = require('mysql');
var sprintf = require("sprintf-js").sprintf;

function verify_msg(con, pnum, msg, cb) {
	// find the player the number is linked to
	var verify_pnum_sql = sprintf("SELECT * FROM Player WHERE PhoneNumber='%s'", 
		pnum);
	var player = null;
	con.query(verify_pnum_sql, function(err, result, fields) {
		if (err) {
			throw err;
		}
		// found a player that matches the phone number, ok
		if (result.length > 0) {
			player = result[0];
		}
		cb(player);
	});
}

function handle_fill_in_request(con, player, cb) {
	// make a new fill in request
	var make_fir_sql = sprintf(
		"INSERT INTO FillInRequest (RequesterID, Active) VALUES (%s, %s)",
		player.PlayerID, 1);
	con.query(make_fir_sql, function(err, result) {
		if (err) {
			throw err;
		}
		var find_fillins_sql = sprintf(
			"SELECT * FROM Player WHERE " + 
			"Grade='%s' AND Availability='available' AND PlayerID != %s", 
			player.Grade, player.PlayerID);
		con.query(find_fillins_sql, function(err, result, fields) {
			if (err) {
				throw err;
			}
			// send everyone an sms
			cb(result);
		});
	});	
}

function handle_fill_in_offer(con, player, cb) {
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
				cb(fir, player);
			});
		} else {
			console.log("no requests match");
		}
	});
}

module.exports = {
	verify_msg: verify_msg,
	handle_fill_in_request: handle_fill_in_request,
	handle_fill_in_offer: handle_fill_in_offer
};
