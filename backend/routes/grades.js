const express =require('express');
const gradesRouter=express.Router();
const db = require('../utils/databaseutil');


gradesRouter.get('/',async(req,res)=>{
  try{
    const [rows]= await db.query(`
      Select * from grades`);
      res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error"});
  }
});


gradesRouter.post('/submit',async(req,res)=>{
   try{
    const{
     studentid,
     courseid,
     quiztotal,
     quizobtained,
     assignmenttotal,
     assignmentobtained,
     midtermtotal,
     midtermobtained,
     finaltotal,
     finalobtained,
     totalgrandtotal,
     obtainedgrandtotal,
     lettergrade
    }=req.body;

    await db.query(`
      Insert into grades (studentid,courseid,quiztotal,quizobtained,assignmenttotal,assignmentobtained,midtermtotal,midtermobtained,finaltotal,finalobtained,totalgrandtotal,obtainedgrandtotal,lettergrade)
      values(?,?,?,?,?,?,?,?,?,?,?,?,?)
      `,[
        studentid,
        courseid,
        quiztotal,
        quizobtained,
        assignmenttotal,
        assignmentobtained,
        midtermtotal,
        midtermobtained,
        finaltotal,
        finalobtained,
        totalgrandtotal,
        obtainedgrandtotal,
        lettergrade
      ])
          res.status(200).json({ message: "Grades submitted successfully." });
   }
   catch(err){ 
       console.error(err);
       res.status(500).json({error:"Server Error"});
   }
})

gradesRouter.get('/getgrades/:courseid', async (req, res) => {
  try {
    const courseid = req.params.courseid;

    const [rows] = await db.query(`
      SELECT studentid, obtainedgrandtotal, lettergrade 
      FROM grades 
      WHERE courseid = ?
    `, [courseid]);

    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server Error" });
  }
});


gradesRouter.post('/transcripts/submit', async (req, res) => {
  const transcripts = req.body;

  try {
    for (const t of transcripts) {
      await db.query(
        `INSERT INTO Transcripts 
         (studentid, courseid, coursecode, coursename, credithours, semester, year, lettergrade)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?)
          ON DUPLICATE KEY UPDATE 
           lettergrade = VALUES(lettergrade)`,
        [
          t.studentid,
          t.courseid,
          t.coursecode,
          t.coursename,
          t.credithours,
          t.semester,
          t.year,
          t.lettergrade,
        ]
      );
    }

    res.status(200).json({ message: "Transcripts submitted successfully" });
  } catch (err) {
    console.error("Error inserting transcripts:", err);
    res.status(500).json({ error: "Server error" });
  }
});


module.exports = gradesRouter;