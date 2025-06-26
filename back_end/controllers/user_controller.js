const User = require('../models/user_model');
const bcrypt = require('bcryptjs');


//Register the user to application
const registrationUser = async(req, res) =>{
    const {username, email, password} = req.body;
    try {
        const hashPassword = await bcrypt.hash(password, 10);
        const user = User({username, email, password:hashPassword});
        await user.save();
        res.status(201).json({message:"User register successfully", user});
    } catch (error) {
        res.status(500).json({error: 'Failed to register user'});
    }
};



//Login the user
const loginUser = async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await User.findOne({ email }); 

    if (!user) {
      return res.status(400).json({ error: "User not found" });
    }
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return res.status(400).json({ error: "Incorrect password" });
    }

    return res.status(200).json({
      message: "Login successfully",
      user: {
        username: user.username,
        email: user.email,
      },
    });
  } catch (error) {
    console.error("Login error:", error);
    return res.status(500).json({ error: "Login failed" });
  }
};

module.exports = {registrationUser,loginUser};