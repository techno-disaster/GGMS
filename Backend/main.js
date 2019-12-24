var express = require('express');
var session = require('express-session');
var multer = require('multer');
var bodyParser = require('body-parser');
var path = require('path');
var PORT = process.env.PORT || 3000;
var cors = require('cors');
const rimraf = require('rimraf');
var conn = require('./connection.js');
const {PythonShell} = require('python-shell');

var auth = function(req,res,next){
  if(req.session.loggedin){  
    next();
  } else {
    res.send('Not logged in');
  }
}

var auth_admin = function(req,res,next){
  if(req.session.admin){  
    next();
  } else {
    res.send('Not logged in');
  }
}

conn.connect(function(err){
  if(!err) {
      console.log("Database is connected ... nn");
  } else {
      console.log(err);
  }
  });

var Storage = multer.diskStorage({

  destination: function(req, file, callback) {
      callback(null, path.join(__dirname + "/Images"));
  },

  filename: function(req, file, callback) {
      callback(null, '1');
  }

});

var upload = multer({
  storage: Storage
}).single("img1"); //Field name and max count'

var ul = multer().any();

var app = express();
app.use(bodyParser.urlencoded({extended : true}));
app.use(bodyParser.json());
app.use(cors());
app.use(session({
  secret: 'cat',
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false }
}));

function pointIsInPoly(p, polygon) {
  var isInside = false;
  var minX = polygon[0].x, maxX = polygon[0].x;
  var minY = polygon[0].y, maxY = polygon[0].y;
  for (var n = 1; n < polygon.length; n++) {
      var q = polygon[n];
      minX = Math.min(q.x, minX);
      maxX = Math.max(q.x, maxX);
      minY = Math.min(q.y, minY);
      maxY = Math.max(q.y, maxY);
  }

  if (p.x < minX || p.x > maxX || p.y < minY || p.y > maxY) {
      return false;
  }

  var i = 0, j = polygon.length - 1;
  for (i, j; i < polygon.length; j = i++) {
      if ( (polygon[i].y > p.y) != (polygon[j].y > p.y) &&
              p.x < (polygon[j].x - polygon[i].x) * (p.y - polygon[i].y) / (polygon[j].y - polygon[i].y) + polygon[i].x ) {
          isInside = !isInside;
      }
  }
  return true;
}

function validate(req){
  if(req.file){
    var locationx = req.body.locationx;
    var locationy = req.body.locationy;
    if(locationx == "0" || locationy == "0"){
      res.send("Geolocation not supported");
    }
    var p = {
      x:locationx,
      y:locationy
    }
    var pts = [
      [
        74.020146,
        18.4966997
      ],
      [
        74.0195862,
        18.4947965
      ],
      [
        74.0216032,
        18.4938401
      ],
      [
        74.0208093,
        18.4905841
      ],
      [
        74.0289632,
        18.4893835
      ],
      [
        74.0306369,
        18.4925581
      ],
      [
        74.0271178,
        18.4923953
      ],
      [
        74.0270535,
        18.4943488
      ],
      [
        74.020146,
        18.4966997
      ]
    ];
    var points = [];
    for (let index = 0; index < pts.length; index++) {
      const element = {
        x: pts[index][0],
        y: pts[index][1]
      }
      points.push(element);
    }
    if(!pointIsInPoly(p,points)){
      console.log("Location");
      return false;
    }
    return true;
  }
}

var bins = [
  [
    74.0227405,
    18.4943285
  ],
  [
    74.0222684,
    18.4922121
  ],
  [
    74.023749,
    18.4910522
  ],
  [
    74.0265599,
    18.4906655
  ],
  [
    74.0274397,
    18.4916423
  ],
  [
    74.0258089,
    18.493718
  ],
  [
    74.0249721,
    18.4939622
  ],
  [
    74.0243498,
    18.4943895
  ],
  [
    74.0244142,
    18.4928023
  ],
  [
    74.023749,
    18.4931075
  ],
  [
    74.0234486,
    18.4940639
  ],
  [
    74.0227405,
    18.4943285
  ]
];

app.post('/grievance', auth, upload, function(req, res) {
  if(validate(req)){
    var dst = [];
    for (let index = 0; index < bins.length; index++) {
      const element = bins[index];
      dst.push(Math.sqrt(Math.pow(element[0]-parseFloat(req.body.locationx),2)+Math.pow(element[1]-parseFloat(req.body.locationy),2)));
    }
    var idx = dst.indexOf(Math.min(dst));
    var thresh = 0.0001;
    console.log(__dirname);
        
    conn.query('SELECT * from grievances WHERE description = ? AND latitude < ? AND latitude > ? AND longitude < ? AND longitude > ?',[req.body.dsc,(parseFloat(req.body.locationx)+thresh).toString(),(parseFloat(req.body.locationx)-thresh).toString(),(parseFloat(req.body.locationy)+thresh).toString(),(parseFloat(req.body.locationy)-thresh).toString()],function(error,results,fields){
      if(error){
        console.log(error);
      } else {
        if(results.length>0){
          res.send("Duplicate query detected");
        } else {
          if(req.file){
            
            var cmd=require('node-cmd');

            cmd.get('python3 ./data_eval/predict.py',(err,data,stderr)=>{
              console.log("data");
              
              console.log(data);
              
              if(!err && parseFloat(data)>0.5){
                conn.query('INSERT INTO grievances(description,bin_num,weight,date,time,latitude,longitude) VALUES (?,?,?,?,?,?,?)',[req.body.dsc,idx,req.body.weight,req.body.date,req.body.time,req.body.locationx,req.body.locationy],function(err,results,fields){
                  if(err){
                    console.log(err);
                  } else {
                    res.send("Grievance reported successfully");
                  }
                });
              } else {
                console.log(err);
                
                res.send("Possible spam detected");
              }
            });

            setTimeout(() => {
              rimraf('./Images/*', function () { console.log('done'); });
            }, 10000);
          } else{
            console.log(1);
          }
        }
      }
    });
  } else{
      res.send('Non valid input');
  }
});
var data = require('./data.js');
app.get('/data', data);
app.get('/', function (req,res) {
  res.send('hello');
})
app.post('/auth', ul, function(req,res){  
  if(req.body.email && req.body.password){
    console.log(1111);
    
    conn.query('SELECT * FROM users where email=? and password=?',[req.body.email,req.body.password],function(error,results,fields){
      if(error){
        console.log(error);
      } else {
        if(results.length>0){
          if(req.body.email=='admin'){
            req.session.admin = true;
            res.send('ADMIN');
          } else {
            req.session.loggedin = true;
            res.send('USER');
          }
        } else {
          res.send('Incorrect username/password');
        }
      }
    });
  }
});
app.get('/auth', auth, function(req,res){
  res.send('HELLOOOO');
});
app.get('/auth_admin', auth_admin, function(req,res){
  res.send('HELLOOOO');
});
app.listen(PORT);
