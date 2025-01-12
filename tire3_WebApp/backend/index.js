// https://www.youtube.com/watch?v=jKwz1-G4gwc&t=0s

const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { Client } = require('pg');
const port = 3001;
const app = express();

app.use(cors());

// parse application/json
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// database connection
// const db = new Client({
//     host: 'localhost',
//     user: 'postgres',
//     password: 'root@123',
//     database: 'simpledb',
//     port: 5432, // port should be a number
// });

// let username;
// try {
//     // Attempt to read the password from the secret file
//     username = fs.readFileSync('/run/secrets/dockersecretusername', 'utf8').trim();
// } catch (err) {
//     console.error('Error reading secret file:', err.message);
//     // Fallback to environment variable or default value
//     username = process.env.USERNAME || 'Dummy_User';
// }

// let password;
// try {
//     // Attempt to read the password from the secret file
//     password = fs.readFileSync('/run/secrets/dockersecretpassword', 'utf8').trim();
// } catch (err) {
//     console.error('Error reading secret file:', err.message);
//     // Fallback to environment variable or default value
//     password = process.env.PASSWORD || 'Dummy_Password';
// }
const fs = require('fs');
let password, username;
try {
    // Read the secrets from the files
    password = fs.readFileSync('/run/secrets/dockersecretpassword', 'utf8').trim();
    username = fs.readFileSync('/run/secrets/dockersecretusername', 'utf8').trim();
} catch (err) {
    console.error('Error reading secret file:', err.message);
    // Fallback to environment variables if needed
    password = process.env.PASSWORD || 'Dummy_Password';
    username = process.env.USERNAME || 'Dummy_User';
}

const db = new Client({
    host: process.env.HOST || 'localhost',
    user: username,
    password: password,
    database: process.env.DATABASE || 'simpledb',
    port: process.env.PORT || 5432,
});

// check database connection

db.connect(err=>{
    if (err) {console.log(err, 'dberr');}
    console.log('database is connected...');
});

// get all data 
app.get('/user',(req,res)=>{
    let qr = 'select * FROM myuser;';
    db.query(qr,(err,result)=>{
        if (err) {
            console.error('Error executing query:', err);
            return res.status(500).send({
              message: 'Error fetching user data',
              error: err
            });
        }
        res.send({
            message:'all user data',
            data:result.rows
        });
    });
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});