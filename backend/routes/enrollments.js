const express = require('express');
const enrollmentsRouter = express.Router();
const db = require('../utils/databaseutil');


enrollmentsRouter.get('/',async (req,res)=>{
  try{
    const [rows] = await db.query(`
      Select * from Enrollments`);
      res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error "})
  }
})

module.exports=enrollmentsRouter;