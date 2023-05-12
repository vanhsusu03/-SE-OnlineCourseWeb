const express = require('express');
const studyController = require('../controllers/StudyController');
const { isAuth } = require('../middleware/Authentication');
const router = express.Router();

router.post('/courses/:courseId/students/:studentId/review', isAuth, studyController.addFeedback);
router.put('/courses/:courseId/students/:studentId/review/:feedbackId', isAuth, studyController.modifyFeedbackOfAStudent);
router.get('/courses/:courseId/students/:studentId/review', studyController.getFeedbackOfAStudent);
router.get('/courses/:courseId/reviews', studyController.getFeedbacksOfACourse);
router.put('/courses/:courseId/students/:studentId/lastTimeAccess', isAuth, studyController.updateLastTimeAccess);
router.get('/courses/:courseId/students/:studentId/lastTimeAccess', isAuth, studyController.getLastTimeAccess);
router.post('/courses/:courseId/students/contents', studyController.getContents);
router.get('/courses/:courseId/:chapterId/:contentId/study', isAuth, studyController.getContentLink);

module.exports = router;