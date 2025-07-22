const express = require('express');
const studentRouter = express.Router();
const bcrypt = require("bcrypt");
const db=require('../utils/databaseutil');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const JWT_SECRET = process.env.JWT_SECRET;

function authenticateStudent(req, res, next) {
  const token = req.cookies.studenttoken;

  if (!token) return res.status(401).json({ message: "No token provided" });

  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ message: "Invalid token" });

    req.user = user;
    next();
  });
}

studentRouter.get("/",async(req,res)=>{
  try{
    const [rows] = await db.query(
      `
      Select * from Students
      `
    )
    res.json(rows);
  }
  catch(err){
    console.log(err);
    res.status(400).send('Server End')
  }
});

studentRouter.post("/register",async(req,res)=>{
    const {
    username,
    password,
    rollNumber,
    firstName,
    lastName,
    dob,
    age,
    gender,
    contact,
    email,
    address,
    guardianName,
    guardianContact,
    guardianRelation,
    enrollmentDate,
    semester,
    program,
    department,
    } = req.body;

    try{

      const [userrows] = await db.query(`
        Select * from users where username=?`,[username]);
        if(userrows.length>0){
          return res.status(400).json({message:"Username already exists"});
        }

        const [rollrows]= await db.query(`
          Select * from students where rollnumber = ?`,[rollNumber]);
          if(rollrows.length>0){
            return res.status(400).json({message:"Roll Number already exists"});
          }

          const hashedpassword = await bcrypt.hash(password,10);

          const [userresult]= await db.query(`
            insert into users (username,passwordhash,role)
            values (?,?,?)
            `,
          [username,hashedpassword,"Student"]);

          const userid = userresult.insertId;

         const studentresult = await db.query(`
  INSERT INTO Students (
    userid, rollnumber, firstname, lastname, dateofbirth, age, gender, 
    contactnumber, email, address, guardianname, guardiancontact, 
    guardianrelation, enrollmentdate, currentsemester, program, department
  ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        userid,
        rollNumber,
        firstName,
        lastName,
        dob,
        age,
        gender,
        contact,
        email,
        address,
        guardianName,
        guardianContact,
        guardianRelation,
        enrollmentDate,
        semester,
        program,
        department,
      ]);
      res.status(200).json({message:"Student Registration Successfull"});
    }
    catch(err){
      console.error("Registration Error : ",err);
      res.status(500).json({message:"Server Error"})
    }
});


studentRouter.get("/getinfo", authenticateStudent, async (req, res) => {
  const userId = req.user.id;

  try {
    const [[studentRow]] = await db.query(`
      SELECT s.*
      FROM students s
      WHERE s.userid = ?`, [userId]);

    if (!studentRow) {
      return res.status(404).json({ message: "Student not found" });
    }

    res.json(studentRow);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Failed to get student info" });
  }
});

studentRouter.get("/getinfo/:id", async (req, res) => {
  const studentId = req.params.id;

  try {
    const [rows] = await db.query("SELECT * FROM students WHERE studentid = ?", [studentId]);

    if (rows.length === 0) {
      return res.status(404).json({ message: "Student not found" });
    }

    const student = rows[0];
    res.status(200).json(student);
  } catch (error) {
    console.error("Error fetching student info:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

studentRouter.get('/course/:courseid',async (req,res)=>{
  const courseid = req.params.courseid;
  try{
    const [rows] = await db.query(
     `
   SELECT s.studentid, s.firstname, s.lastname,s.rollnumber,s.currentsemester,YEAR(s.enrollmentdate) AS year
FROM Enrollments e
JOIN Students s ON s.studentid = e.studentid
WHERE e.courseid = ?`,[courseid]
    )
    res.json(rows);
  }
  catch(err){
    console.error(err);
    res.status(500).json({error:"Server Error"})
  }
})


module.exports= studentRouter;