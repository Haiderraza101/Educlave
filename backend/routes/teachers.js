const express = require('express');
const teacherRouter = express.Router();
const bcrypt = require("bcrypt");
const db=require('../utils/databaseutil');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const JWT_SECRET = process.env.JWT_SECRET;

function authenticateteacher(req, res, next) {
  const token = req.cookies.teachertoken;

  if (!token) return res.status(401).json({ message: "No token provided" });

  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ message: "Invalid token" });

    req.user = user;
    next();
  });
}


teacherRouter.get('/', async (req, res) => {
  try {
    const [rows] = await db.query(`SELECT * FROM teachers`);
    
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  }
});


teacherRouter.post("/register", async (req, res) => {
  const {
    username,
    password,
    firstName,
    lastName,
    dob,
    age,
    gender,
    contact,
    email,
    address,
    specialization,
    qualification,
    previousExperience,
    department,
  } = req.body;

  try {
    const [userRows] = await db.query(
      `SELECT * FROM users WHERE username = ?`,
      [username]
    );
    if (userRows.length > 0) {
      return res.status(400).json({ message: "Username already exists" });
    }

    const [contactRows] = await db.query(
      `SELECT * FROM teachers WHERE contactnumber = ? OR email = ?`,
      [contact, email]
    );
    if (contactRows.length > 0) {
      return res
        .status(400)
        .json({ message: "Contact number or email already exists" });
    }
    const hashedPassword = await bcrypt.hash(password, 10);

    const [userResult] = await db.query(
      `INSERT INTO users (username, passwordhash, role) VALUES (?, ?, ?)`,
      [username, hashedPassword, "Teacher"]
    );

    const userid = userResult.insertId;

  
    await db.query(
      `INSERT INTO teachers (
        userid, firstname, lastname, dateofbirth, age, gender, 
        contactnumber, email, address, specialization, qualification, 
        previousexperience, department
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        userid,
        firstName,
        lastName,
        dob,
        age,
        gender,
        contact,
        email,
        address,
        specialization,
        qualification,
        previousExperience,
        department,
      ]
    );

    return res.status(200).json({ message: "Teacher registered successfully" });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: "Server Error" });
  }
});

teacherRouter.get("/getinfo/:id", async (req, res) => {
  const teacherId = req.params.id;

  try {
    const [rows] = await db.query("SELECT * FROM teachers WHERE teacherid = ?", [teacherId]);

    if (rows.length === 0) {
      return res.status(404).json({ message: "Teacher not found" });
    }

    res.status(200).json(rows[0]);
  } catch (err) {
    console.error("Error fetching teacher info:", err);
    res.status(500).json({ message: "Internal server error" });
  }
});

module.exports = teacherRouter;
