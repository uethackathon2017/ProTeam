'use strict';

var express = require('express');
var controller = require('./user.controller');
var auth = require('../auth/auth.service');

var router = express.Router();

// router.put('/edit',  auth.hasRole('admin'), controller.edit);
// router.delete('/delete/:username', auth.hasRole('admin'),controller.deleteUser);
// router.post('/create',controller.addUser);+
router.post('/login',controller.login);
router.get('/confirm', auth.hasRole('admin'), controller.confirm);
router.post('/upload', auth.hasRole('admin'), controller.upload);

router.post('/setting', auth.hasRole('user'), controller.editUserSetting);
router.get('/setting', auth.hasRole('user'), controller.getSetting);

router.post('/like/exercise/:_id', auth.hasRole('user'), controller.likeExercise);
router.post('/unlike/exercise/:_id', auth.hasRole('user'), controller.unlikeExercise);
router.post('/like/food/:_id', auth.hasRole('user'), controller.likeFood);
router.post('/unlike/food/:_id', auth.hasRole('user'), controller.unlikeFood);

router.get('/favorite', auth.hasRole('user'), controller.getFavorite);

module.exports = router;
