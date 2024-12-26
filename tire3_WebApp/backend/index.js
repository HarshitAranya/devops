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
const db = new Client({
    host: 'localhost',
    user: 'postgres',
    password: 'root@123',
    database: 'simpledb',
    port: 5432, // port should be a number
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