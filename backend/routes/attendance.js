const express = require('express');
const attendenceRouter = express.Router();
const db = require('../utils/databaseutil');


attendenceRouter.get("/",async(req,res)=>{
  try{

    const [rows] = await db.query(
      `
      Select * from attendance`
    );
    res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error"});
  }
});

attendenceRouter.post("/submit", async (req, res) => {


  const attendanceRecords = req.body; 
  try {
    for (const record of attendanceRecords) {
      const { studentid, courseid, date, status } = record;
        const correctedDate = new Date(date);
correctedDate.setDate(correctedDate.getDate() + 1);
      await db.query(
        `
        INSERT INTO Attendance (studentid, courseid, date, status)
        VALUES (?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE status = VALUES(status)
        `,
        [studentid, courseid, correctedDate, status]
      );
    }

    res.status(200).json({ message: "Attendance submitted successfully." });
  } catch (err) {
    console.error("Error submitting attendance:", err);
    res.status(500).json({ error: "Server error submitting attendance." });
  }
});

attendenceRouter.get('/student/:studentid/:courseid',async(req,res)=>{
  const studentId=req.params.studentid;
  const courseId = req.params.courseid;
  try{
    const [rows]=await db.query('Select date,status from attendance where studentid = ? and courseid=?',[studentId,courseId]);
    res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error"});
  }
})
module.exports = attendenceRouter;