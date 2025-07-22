const express = require("express");
const userRouter = express.Router();
const db = require("../utils/databaseutil");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const cookieParser = require("cookie-parser");
require("dotenv").config();
const JWT_SECRET = process.env.JWT_SECRET;


userRouter.get("/",async(req,res) => {
  try{
    const [rows]=await db.query(
      `
      Select * from users`
    );
    res.json(rows);
  }
  catch(err){
    console.log(err);
    res.status(500).send("Server End ");
  }
});



userRouter.post("/login", async (req, res) => {
  const { username, password } = req.body;
  try {
    const [rows] = await db.query(`SELECT * FROM users WHERE username = ?`, [
      username,
    ]);
    if (!rows.length)
      return res.status(401).json({ message: "Invalid credentials" });

    const user = rows[0];
    const isMatch = await bcrypt.compare(password, user.passwordhash);
    if (!isMatch)
      return res.status(401).json({ message: "Invalid credentials" });

    let id = null;

    if (user.role === 'Student'){
      const [studentrows] = await db.query(
        `
        Select studentid from students where userid = ?`,[user.userid]
      );
      if(studentrows.length>0){
        id = studentrows[0].studentid;
      }
    }
    else if (user.role === 'Teacher'){
      const [teacherrows] = await db.query(`
        
        Select teacherid from teachers where userid = ? `,[user.userid]);
        if (teacherrows.length>0){
          id=teacherrows[0].teacherid;
        }
    }

const token = jwt.sign(
  {
    id: user.userid,
    username: user.username,
    role: user.role,
  },
  JWT_SECRET,
  { expiresIn: "2h" }
);

const cookieName = user.role ==='Student'?'studenttoken':'teachertoken'

res
  .cookie(cookieName, token, {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "lax",
    maxAge:24*60*60*1000,
  })
  .json({ message: "Login successful", role: user.role,
    userid:user.userid,
    studentid:user.role==='Student'?id:null,
    teacherid:user.role === 'Teacher' ? id : null
  });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Login error" });
  }
});


module.exports=userRouter;