const express = require('express');
const assignmentsRouter = express.Router();
const db = require('../utils/databaseutil');


assignmentsRouter.get('/',async(req,res)=>{
  try{
    const[rows]=await db.query(`
      Select * from assignments`);

      res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error"});
  }
});

assignmentsRouter.get('/bycourse/:courseid', async (req, res) => {
  const courseid = req.params.courseid;
  try {
    const [rows] = await db.query('SELECT * from assignments WHERE courseid = ?', [courseid]);
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

assignmentsRouter.post("/submit", async (req, res) => {
  const assignmentRecords = req.body;

  try {
    for (const record of assignmentRecords) {
      const { studentid, courseid, obtainedmarks, totalmarks, assignmentnumber } = record;

      await db.query(
        `
        INSERT INTO assignments (studentid, courseid, assignmentnumber, obtainedmarks, totalmarks)
        VALUES (?, ?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE 
          obtainedmarks = VALUES(obtainedmarks),
          totalmarks = VALUES(totalmarks),
          assignmentnumber=values(assignmentnumber)
        `,
        [studentid, courseid, assignmentnumber, obtainedmarks, totalmarks]
      );
    }

    res.status(200).json({ message: "Marks submitted successfully." });
  } catch (err) {
    console.error("Error submitting marks:", err);
    res.status(500).json({ error: "Server error submitting marks." });
  }
});


assignmentsRouter.get('/assignmentmarks/:studentid/:courseid',async(req,res)=>{
  const studentid = req.params.studentid;
  const courseid = req.params.courseid;
  try{
     const [rows]=await db.query(`
    Select assignmentnumber,obtainedmarks,totalmarks from assignments where studentid = ? and courseid =?`,[studentid,courseid]);
    res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error in getting Assignment Marks"})
  }
});

module.exports=assignmentsRouter;