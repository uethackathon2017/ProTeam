/**
 * Created by khanh on 10/03/2017.
 */
'use strict';

var express = require('express');
var controller = require('./exercise.controller.js');
var auth = require('../auth/auth.service');

var router = express.Router();

router.get('/category/all', controller.getAllCategory);
router.get('/category/:_id', controller.getExByCategory);
router.get('/exercise/:_id', controller.findExById);
router.post('/createCategory',auth.hasRole('admin'), controller.createCategory);
router.post('/createExercise',auth.hasRole('admin'), controller.createExercise);
router.put('/editExercise',auth.hasRole('admin'), controller.editExercise);
router.delete('/deleteExercise/:_id', auth.hasRole('admin'),  controller.deleteExercise);
router.put('/updateCategory/:_id',  controller.updateCategory);
router.delete('/deleteCategory/:_id',  controller.deleteCategory);


module.exports = router;
