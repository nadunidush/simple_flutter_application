const express = require('express');
const router = express.Router();
const{registrationUser, loginUser} = require('../controllers/user_controller');

router.post('/registration',registrationUser);
router.post('/login',loginUser);

module.exports = router;