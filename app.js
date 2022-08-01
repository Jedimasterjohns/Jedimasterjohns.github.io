

/*
    SETUP
*/
const util = require('util');
require('util.promisify').shim();

const fs = require('fs');
const readFileAsync = util.promisify(fs.readFile);
// Express
var express = require('express');   // We are using the express library for the web server
var app = express();            // We need to instantiate an express object to interact with the server in our code
app.use(express.json())
app.use(express.urlencoded({ extended: true }))
PORT        = 7364;                 // Set a port number at the top so it's easy to change in the future

// Database
var db = require('./database/db-connector.js')

// app.js

const { engine } = require('express-handlebars');
var exphbs = require('express-handlebars');     // Import express-handlebars
app.engine('.hbs', engine({ extname: ".hbs" }));  // Create an instance of the handlebars engine to process templates
app.set('view engine', '.hbs');                 // Tell express to use the handlebars engine whenever it encounters a *.hbs file.

/*
    ROUTES
*/

app.get('/', function (req, res) {
    
    console.log("hi")
    let query1 = "SELECT * FROM Customers;";               // Define our query

    db.pool.query(query1, function (error, rows, fields) {    // Execute the query

        res.render('customersH', { data: rows });                  // Render the index.hbs file, and also send the renderer
    })
    // Note the call to render() and not send(). Using render() ensures the templating engine
});                                         // will process this file, before sending the finished HTML to the client.

app.get('/donutsH', function (req, res) {
    console.log("hi")
    let query1 = "SELECT * FROM Donuts;";               // Define our query

    db.pool.query(query1, function (error, rows, fields) {    // Execute the query

        res.render('donutsH', { data: rows });                  // Render the index.hbs file, and also send the renderer
    })
    // Note the call to render() and not send(). Using render() ensures the templating engine
});

app.get('/customersH', function (req, res) {
    console.log("yo")
    let query1 = "SELECT * FROM Customers;";               // Define our query

    db.pool.query(query1, function (error, rows, fields) {    // Execute the query

        res.render('customersH', { data: rows });                  // Render the index.hbs file, and also send the renderer
    })
});

app.get('/suppliersStoresH', function (req, res) {
    console.log("ss")
    let query1 = "SELECT * FROM SupplierStoreInter"
    db.pool.query(query1, function (error, rows, fields) {    // Execute the query

        res.render('suppliersStoresH', { data: rows });                  // Render the index.hbs file, and also send the renderer
    })
});

app.post('/add-person-form', function (req, res) {

    let data = req.body;

    query1 = `INSERT INTO  Customers (customerFName, customerLName, customerEmail, customerAddress, customerPlanet)
                VALUES ('${data['insert-fname']}','${data['insert-lname']}','${data['insert-email']}','${data['insert-customer-address']}','${data['insert-customer-planet']}');`;

    db.pool.query(query1, function (error, rows, fields) {

        if (error) {
            console.log(error)
            res.sendStatus(400);
        }

        else {
            res.redirect('/customersH');
        }
    })
})

app.post('/delete-person-form', function (req, res) {

    let data = req.body;

    query2 = `DELETE FROM Customers WHERE customerID = ${data['deleteCustomerID']}`
    db.pool.query(query2, function (error, rows, fields) {

        if (error) {
            console.log(error)
            res.sendStatus(400);
        }

        else {
            res.redirect('/customersH');
        }
    })
});

app.post('/update-person-form', function (req, res) {

    let data = req.body;

    query1 = `UPDATE Customers SET customerFName = ${'\''+data['fname-update']+'\''
}, customerLName = ${ '\''+data['lname-update']+'\''}, customerEmail = ${ '\''+data['email-update']+'\''}, customerAddress = ${ '\''+data['address-update']+'\''}, customerPlanet = ${ '\''+data['planet-update']+'\''}
              WHERE customerID = ${data['id-update']};`;

    db.pool.query(query1, function (error, rows, fields) {

        if (error) {
            console.log(error)
            res.sendStatus(400);
        }

        else {
            res.redirect('/customersH');
        }
    })
})

app.post('/add-donut-form', function (req, res) {

    let data = req.body;

    query1 = `INSERT INTO Donuts (donutName, donutDescription, donutPrice)
                VALUES ('${data['insert-name']}','${data['insert-description']}','${data['insert-price']}');`;

    db.pool.query(query1, function (error, rows, fields) {

        if (error) {
            console.log(error)
            res.sendStatus(400);
        }

        else {
            res.redirect('/donutsH');
        }
    })
})
app.post('/delete-donut-form', function (req, res) {

    let data = req.body;

    query2 = `DELETE FROM Donuts WHERE donutID = ${data['deleteDonutID']};`
    db.pool.query(query2, function (error, rows, fields) {

        if (error) {
            console.log(error)
            res.sendStatus(400);
        }

        else {
            res.redirect('/donutsH');
        }
    })
});
app.post('/update-donut-form', function (req, res) {

    let data = req.body;

    query1 = `UPDATE Donuts SET donutName = ${'\'' + data['name-update'] + '\''
                }, donutDescription = ${'\'' + data['description-update'] + '\''}, donutPrice = ${'\'' + data['price-update'] + '\''}
                WHERE donutID = ${data['id-update']};`;

    db.pool.query(query1, function (error, rows, fields) {

        if (error) {
            console.log(error)
            res.sendStatus(400);
        }

        else {
            res.redirect('/donutsH');
        }
    })
})
/*
    LISTENER
*/
app.listen(PORT, function(){            // This is the basic syntax for what is called the 'listener' which receives incoming requests on the specified PORT.
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});


