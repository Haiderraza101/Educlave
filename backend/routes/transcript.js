const express = require('express');
const transcriptRouter = express.Router();
const db = require('../utils/databaseutil');



transcriptRouter.get('/',async(req,res)=>{
  try{
    const [rows]= await db.query(
      `
      Select * from transcripts`
    )
    res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error"});
  }
});


transcriptRouter.get('/gettranscript/:studentid',async(req,res)=>{
  try{
    const studentid = req.params.studentid;
    const [rows]= await db.query(
      `
      Select * from transcripts where studentid = ?`
    ,[studentid]);
    res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error"});
  }
});


module.exports = transcriptRouter;