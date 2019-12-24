var mysql = require('mysql');
var conn = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'password',
  database : 'grievance_data',
  insecureAuth: true
});
module.exports = conn;