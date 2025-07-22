const express = require('express');
const finalsRouter = express.Router();
const db = require('../utils/databaseutil');

finalsRouter.get('/',async(req,res)=>{
  try{
    const [rows]=await db.query(
      `
      Select * from finals`
    );
    res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error"});
  }
});


finalsRouter.post("/submit", async (req, res) => {
  const finalRecords = req.body;

  try {
    for (const record of finalRecords) {
      const { studentid, courseid, obtainedmarks, totalmarks } = record;

      await db.query(
        `
        INSERT INTO finals (studentid, courseid, obtainedmarks, totalmarks)
        VALUES (?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE 
          obtainedmarks = VALUES(obtainedmarks),
          totalmarks = VALUES(totalmarks)
        `,
        [studentid, courseid, obtainedmarks, totalmarks]
      );
    }

    res.status(200).json({ message: "Marks submitted successfully." });
  } catch (err) {
    console.error("Error submitting marks:", err);
    res.status(500).json({ error: "Server error submitting marks." });
  }
});


finalsRouter.get('/finalmarks/:studentid/:courseid',async(req,res)=>{
  const studentid = req.params.studentid;
  const courseid = req.params.courseid;
  try{
     const [rows]=await db.query(`
    Select obtainedmarks,totalmarks from finals where studentid = ? and courseid =?`,[studentid,courseid]);
    res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error in getting Final Marks"})
  }
});

module.exports = finalsRouter;