var conn = require('./connection.js');
const rimraf = require('rimraf');
const {PythonShell} = require('python-shell');

            
module.exports = function (req,res){
  if(req.query.date || req.query.time1 || req.body.time2){
    if(req.query.type=='1'){ //histo on date
      var cmd=require('node-cmd');
      cmd.get('python3 ./data_eval/hist.py ' + req.query.date,(err,data,stderr)=>{
        setTimeout(() => {
          console.log(data);
          console.log(stderr);
          
          res.sendFile('/Users/tirth/Codebreak/GGMS/Backend/data_eval/hist.png');
        }, 6000);
      });
    }
    if(req.query.type=='2'){ //histo on time
      var cmd=require('node-cmd');
      cmd.get('python3 ./data_eval/hist2.py '+req.query.time1+' '+req.body.time2,(err,data,stderr)=>{
        setTimeout(() => {
          res.sendFile('/Users/tirth/Codebreak/GGMS/Backend/data_eval/hist2.png');
        }, 6000);
      });
    }
    if(req.query.type=='3'){ //heatmap on date
      var cmd=require('node-cmd');
      cmd.get('python3 ./data_eval/heatmap_date.py '+req.query.date,(err,data,stderr)=>{
        console.log(data);
        console.log('python3 ./data_eval/heatmap_date.py '+req.query.date);
        
        setTimeout(() => {
          res.sendFile('/Users/tirth/Codebreak/GGMS/Backend/data_eval/heatmap_date.png');
        }, 6000);
      });
    }
    if(req.query.type=='4'){ //heatmap on time
      var cmd=require('node-cmd');
      cmd.get('python3 ./data_eval/heatmap_time.py '+req.query.time1+' '+req.body.time2,(err,data,stderr)=>{
        setTimeout(() => {
          res.sendFile('/Users/tirth/Codebreak/GGMS/Backend/data_eval/heatmap_time.png');
        }, 6000);
      });
    }
  }
}