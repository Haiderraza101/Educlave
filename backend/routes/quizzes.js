const express = require('express');
const quizzesRouter = express.Router();
const db = require('../utils/databaseutil');

quizzesRouter.get('/',async(req,res)=>{
  try{
    const [rows]=await db.query(`
      Select * from quizzes`);
      res.json(rows)
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error"})
  }
})
quizzesRouter.get('/bycourse/:courseid', async (req, res) => {
  const courseid = req.params.courseid;
  try {
    const [rows] = await db.query('SELECT * FROM Quizzes WHERE courseid = ?', [courseid]);
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});


// quizzesRouter.post("/submit", async (req, res) => {
//   const quizzesRecords = req.body;

//   try {
//     for (const record of quizzesRecords) {
//       const { studentid, courseid, obtainedmarks, totalmarks } = record;
//       let { quizid } = record;

//       await db.query(
//         `
//         INSERT INTO quizzes (studentid, courseid, quizid, obtainedmarks, totalmarks)
//         VALUES (?, ?, ?, ?, ?)
//         ON DUPLICATE KEY UPDATE 
//           obtainedmarks = VALUES(obtainedmarks),
//           totalmarks = VALUES(totalmarks)
//         `,
//         [studentid, courseid, quizid, obtainedmarks, totalmarks]
//       );
//     }

//     res.status(200).json({ message: "Marks submitted successfully." });
//   } catch (err) {
//     console.error("Error submitting marks:", err);
//     res.status(500).json({ error: "Server error submitting marks." });
//   }
// });


quizzesRouter.post("/submit", async (req, res) => {
  const quizzesRecords = req.body;

  try {
    for (const record of quizzesRecords) {
      const { studentid, courseid, obtainedmarks, totalmarks, quiznumber } = record;

      await db.query(
        `
        INSERT INTO quizzes (studentid, courseid, quiznumber, obtainedmarks, totalmarks)
        VALUES (?, ?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE 
          obtainedmarks = VALUES(obtainedmarks),
          totalmarks = VALUES(totalmarks),
          quiznumber=values(quiznumber)
        `,
        [studentid, courseid, quiznumber, obtainedmarks, totalmarks]
      );
    }

    res.status(200).json({ message: "Marks submitted successfully." });
  } catch (err) {
    console.error("Error submitting marks:", err);
    res.status(500).json({ error: "Server error submitting marks." });
  }
});

quizzesRouter.get('/quizmarks/:studentid/:courseid',async(req,res)=>{
  const studentid = req.params.studentid;
  const courseid = req.params.courseid;
  try{
     const [rows]=await db.query(`
    Select quiznumber,obtainedmarks,totalmarks from quizzes where studentid = ? and courseid =?`,[studentid,courseid]);
    res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error in getting Quiz Marks"})
  }
 
});

module.exports=quizzesRouter;