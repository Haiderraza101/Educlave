const express = require('express');
const coursesRouter = express.Router();
const db=require('../utils/databaseutil');

coursesRouter.get("/",async(req,res)=>{
  try{
    const [rows] = await db.query(
      `
      Select c.*, t.firstname,t.lastname from courses c join teachers t on c.teacherid = t.teacherid `
    );
    res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).send("Server Error")
  }

})

coursesRouter.get('/:studentId',async (req,res) => {
  const studentId = req.params.studentId;
  try{
    const [rows] = await db.query(
      `
      Select c.*, t.firstname,t.lastname from courses c join teachers t on c.teacherid = t.teacherid where c.studentid=? `,[studentId]
    );
    res.json(rows);
  }
  catch(err){
   console.error(err);
   res.status(500).json({error:"Failed to fetch Courses"});
  }
})

coursesRouter.put("/register", async (req, res) => {
  const { studentid, courseid } = req.body;

  try {
    await db.query(
      `UPDATE courses SET studentid = ? WHERE courseid = ?`,
      [studentid, courseid]
    );

    await db.query(
      `INSERT IGNORE INTO Enrollments (studentid, courseid) VALUES (?, ?)`,
      [studentid, courseid]
    );

    res.status(200).json({ message: "Student registered successfully." });
  } catch (error) {
    console.error("Registration failed:", error);
    res.status(500).json({ error: "Registration failed." });
  }
});

coursesRouter.put("/drop", async (req, res) => {
  const { studentid, courseid } = req.body;

  try {
    
    await db.query(
      `
      Update courses 
      set studentid=?
      where courseid =?
      ` ,
      [null, courseid]
    );

    res.status(200).json({ message: "Student registered successfully." });
  } catch (error) {
    console.error("Registration failed:", error);
    res.status(500).json({ error: "Registration failed." });
  }
});

coursesRouter.get('/teachercourses/:teacherid',async (req,res)=>{
  const teacherid = req.params.teacherid;

  try{
    const [rows]=await db.query(
    `
   Select c.*, t.firstname,t.lastname from courses c join teachers t on c.teacherid = t.teacherid where c.teacherid=? `,[teacherid]
    );
    res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error"})
  }
})

coursesRouter.post('/create', async (req, res) => {
  const {
    coursecode,
    coursename,
    description,
    credithours,
    teacherid,
  } = req.body;

  try {
    const result = await db.query(
      `INSERT INTO Courses (
        coursecode,
        coursename,
        description,
        credithours,
        teacherid
      ) VALUES (?, ?, ?, ?, ?)`,
      [coursecode, coursename, description, credithours,  teacherid]
    );

    res.status(201).json({ message: "Course created successfully" });
  } catch (err) {
    console.error("Error inserting course:", err);
    res.status(500).json({ error: "Failed to create course" });
  }
});

coursesRouter.delete('/delete/:courseid', async (req, res) => {
  const { courseid } = req.params;

  try {
    const result = await db.query(
      `DELETE FROM Courses WHERE courseid = ?`,
      [courseid]
    );

    res.status(200).json({ message: "Course deleted successfully" });
  } catch (error) {
    console.error("Error deleting course:", error);
    res.status(500).json({ error: "Failed to delete course" });
  }
});

coursesRouter.get('/studentcourses/:studentid',async (req,res)=>{
  const studentId = req.params.studentid;

  try{
    const [rows]= await db.query(`
      Select * from courses where studentid=?`,[studentId]);
      res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).send({error:"Server Error"})
  }
})
module.exports= coursesRouter;