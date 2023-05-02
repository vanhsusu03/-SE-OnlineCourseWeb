const express = require('express');
const studentController = require('../controllers/StudentController');
const { isAlreadyLogin, isAuth } = require('../middleware/Authentication');
const router = express.Router();

router.post('/signup', isAlreadyLogin, studentController.signUp);
router.post('/login', studentController.logIn);
router.post("/logout",studentController.logOut);


module.exports = router;