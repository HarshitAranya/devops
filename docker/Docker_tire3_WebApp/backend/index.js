// https://www.youtube.com/watch?v=jKwz1-G4gwc&t=0s

const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { Client } = require('pg');
// const port = 3001;
const port = process.env.TPORT || 3001; // for backend API only to create API URL like http://backend:3001/user
const apihost = process.env.APIHOST || 'localhost' //'192.168.150.128'; // ip address or host name of backend container
const password = process.env.DB_PASSWORD;
const username = process.env.DB_USER || 'Dummy_User';
const app = express();
//new code start
const allowedOrigins = [
    `http://${apihost}`,  // Dynamic API host
    'http://192.168.100.102',
    'http://172.28.176.1',
    'http://172.28.176.1:3001/user',
    'http://localhost:4200'
  ];

app.use(cors({
origin: function (origin, callback) {
    if (!origin || allowedOrigins.includes(origin)) {
    return callback(null, true);
    } else {
    return callback(new Error('Not allowed by CORS'));
    }
}
}));    
// new end
// app.use(cors({ origin: `http://${apihost}` })); // Allow requests from your frontend URL

// parse application/json
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const db = new Client({
    host: process.env.DB_HOST || 'databaseserver',
    user: username,
    password: password,
    database: process.env.DB_NAME || 'simpledb',
    // If not exposed
    // port: process.env.DB_PORT || 5432, 
});

// check database connection

db.connect(err=>{
    if (err) {console.log(err, 'dberr');}
    console.log('database is connected...');
});

// get all data 
app.get('/user',(req,res)=>{
    let qr = 'SELECT * FROM "myuser";';
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
    console.log(`Server is running on http://${apihost}:${port}`);
});
