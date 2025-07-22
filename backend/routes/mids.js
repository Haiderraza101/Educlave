const express = require('express');
const midsRouter = express.Router();
const db = require('../utils/databaseutil');

midsRouter.get('/',async(req,res)=>{
  try{
    const [rows]=await db.query(
      `
      Select * from Midterms`
    );
    res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error"});
  }
});

midsRouter.post("/submit", async (req, res) => {
  const midRecords = req.body;

  try {
    for (const record of midRecords) {
      const { studentid, courseid, obtainedmarks, totalmarks, midnumber } = record;

      await db.query(
        `
        INSERT INTO midterms (studentid, courseid, midnumber, obtainedmarks, totalmarks)
        VALUES (?, ?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE 
          obtainedmarks = VALUES(obtainedmarks),
          totalmarks = VALUES(totalmarks),
          midnumber=values(midnumber)
        `,
        [studentid, courseid, midnumber, obtainedmarks, totalmarks]
      );
    }

    res.status(200).json({ message: "Marks submitted successfully." });
  } catch (err) {
    console.error("Error submitting marks:", err);
    res.status(500).json({ error: "Server error submitting marks." });
  }
});


midsRouter.get('/midmarks/:studentid/:courseid',async(req,res)=>{
  const studentid = req.params.studentid;
  const courseid = req.params.courseid;
  try{
     const [rows]=await db.query(`
    Select midnumber,obtainedmarks,totalmarks from midterms where studentid = ? and courseid =?`,[studentid,courseid]);
    res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error in getting Mid Marks"})
  }
});
module.exports = midsRouter;

