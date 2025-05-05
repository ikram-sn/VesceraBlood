const mysql=require("mysql2")
const connection = mysql.createConnection({
    host:'localhost',
    database:'simple_blood_donation',
    user:'root',
    password:'28111976'
  });
  
  connection.connect((err) => {
    if (err) {
      console.error('Error connecting to DB:', err);
      return;
    }
    console.log('Connected to MySQL DB');
  });
  
  module.exports = connection;