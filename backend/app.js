const express = require('express');
const cors = require('cors');
const cookieParser = require("cookie-parser");

const app = express();
app.use(cors({
  origin: "http://localhost:3000",
  credentials: true 
}));
app.use(express.json());
app.use(cookieParser()); 

const users = require('./routes/users');
const students = require('./routes/students');
const teachers = require('./routes/teachers');
const courses = require('./routes/courses');
const attendance = require('./routes/attendance');
const enrollments= require('./routes/enrollments');
const quizzes = require('./routes/quizzes');
const assignments  = require('./routes/assigments');
const mids=require('./routes/mids');
const finals = require('./routes/finals');
const grades = require('./routes/grades');
const transcript = require('./routes/transcript');

app.use('/users',users);
app.use('/students',students);
app.use('/teachers',teachers);
app.use('/courses',courses)
app.use('/attendance',attendance);
app.use('/enrollments',enrollments);
app.use('/quizzes',quizzes);
app.use('/assignments',assignments);
app.use('/mids',mids);
app.use('/finals',finals)
app.use('/grades',grades);
app.use('/transcript',transcript);

app.get('/',(req,res)=>{
  res.json({message:'Hello from backend'});
})

const PORT = 3001;
app.listen(PORT,()=>{
  console.log(`Server running on http://localhost:${PORT}`);
});