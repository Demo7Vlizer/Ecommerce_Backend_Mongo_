const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

app.use(bodyParser.json());

mongoose.connect(process.env.MONGODB_URI)
  .then(() => console.log('Connected to Database'))
  .catch((error) => console.error('Database connection error:', error));

app.post('/', async (req, res) => {
    const {name, age, email} = req.body;
  try {
    const newUser = new User({ 
      name: name, 
      age: age, 
      email: email 
    });
    await newUser.save();
    res.json({ message: 'User created successfully', user: newUser });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});



app.get('/users', async (req, res) => {
    const users = await User.find();
    res.json(users);
  });

  
//-- This is for get all users 
// app.put('/users/:id', async (req, res) => {
//   try {
//     const id = req.params.id;
//     const { name, age, email } = req.body; // Get updated data from request body
    
//     const updatedUser = await User.findByIdAndUpdate(
//       id,
//       { 
//         name: name || "new name",  // Use provided name or fallback to "new name"
//         age: age,
//         email: email
//       },
//       { new: true }
//     );

//     if (!updatedUser) {
//       return res.status(404).json({ error: 'User not found' });
//     }

//     res.json({ message: 'Updated successfully', user: updatedUser });
//   } catch (error) {
//     res.status(500).json({ error: error.message });
//   }
// });

// THis is for delete   
app.delete('/users/:id', async (req, res) => {
    const id = req.params.id;
    await User.findByIdAndDelete(id);
    res.json('Delete successfully');
  });

  //-- The main difference between app.put() and app.delete() is:
  //-- app.put is meant for updating existing resources, while app.delete is for removing resources
  //-- In this code, using app.put for deletion is incorrect - it should use app.delete instead
  //-- The current implementation is mixing up HTTP methods which violates REST conventions
  //-- For better API design, delete operations should use app.delete() and updates should use app.put()


app.listen(port, () => {
  console.log(`Server is running on :${port}`);
});

const { Schema, model } = mongoose;
const userSchema = new Schema({
  name: String,
  age: Number,
  email: String
});

const User = model('User', userSchema);