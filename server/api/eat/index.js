/**
 * Created by khanh on 10/03/2017.
 */
'use strict';

var express = require('express');
var controller = require('./eat.controller.js');
var auth = require('../auth/auth.service');

var router = express.Router();

router.get('/category/all', controller.getAllCategory);
router.get('/category/:_id', controller.getFoodByCategory);
router.get('/food/:_id', controller.findFoodById);
router.post('/createCategory',auth.hasRole('admin'), controller.createCategory);
router.post('/createFood',auth.hasRole('admin'), controller.createFood);
// router.put('/editFood', auth.hasRole('admin'), controller.editFood);
// router.delete('/deleteFood/:_id', auth.hasRole('admin'),  controller.deleteFood);

module.exports = router;



