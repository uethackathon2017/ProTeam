/**
 * Created by khanh on 10/03/2017.
 */
'use strict';

var Category = require('./categoryEat.model');
var Food = require('./food.model');

module.exports = {
    deleteFood: function(req, res){
        if(req.params._id){
            Food.findById(req.params._id, function(err, data){
                if(err) { // err function of mongoose
                    console.error(err);
                    res.json({code : 0, message: err});
                }
                else {
                    if (data){
                        data.remove(function(err){
                            if (err){
                                console.error(err);
                                res.json({code : 0, message: err});
                            }else{
                                res.json({code: 1, message:'delete succeed!!!'});
                            }
                        })
                    }
                    else{
                        res.json({code: 0, message: 'No data'})
                    }
                }
            });
        } else {
            res.json({code: 0, message: 'No id'})
        }
    },

    editFood: function(req,res){
        if(req.body){
            Food.findById(req.body._id, function(err, data){
                if(err) { // err function of mongoose
                    console.error(err);
                    res.json({code : 0, message: err});
                }
                else {
                    if (data){ //check find a obj by id
                        if(req.body.name) data.name = req.body.name;
                        if(req.body.img) data.img = req.body.img;
                        if(req.body.guide) data.guide = req.body.guide;
                        data.save(function(err, newData){
                            if (err){
                                console.error(err);
                                res.json({code : 0, message: err});
                            }
                            else{
                                res.json({code : 1, result: data._id});
                            }
                        });

                    }
                }
            });
        }
        else {
            res.json({code: 0, message: 'No data'})
        }
    },

    createCategory: function(req, res) {
        if (req.body) {
            var newCategory = {
                name : req.body.name,
                items: []
            };
            Category.create(newCategory , function(err, data) {
                if(err) {
                    console.error(err);
                    res.json({code : 0, message: err});
                }
                res.json({code : 1, result: data._id, message: 'Create successful'});
            });
        }
        else {
            res.json({code: 0, message: 'No data'})
        }
    },

    createFood: function (req, res) {
        if (req.body) {
            var newFood = {
                name : req.body.name,
                img: req.body.img,
                guide: req.body.guide,
                category: req.body.category
            };
            Food.create(newFood , function(err, data) {
                if(!err) {
                    Category.findOneAndUpdate(
                            { _id : newFood.category._id},
                            {$addToSet: {items: data._id}},
                            {upsert: true},
                            function (err, ok) {
                                if(err) res.json({code : 0, message: err});
                                res.json({code : 1, result: data._id, message: 'Create successful'});
                            }
                    )}
                else res.json({code : 0, message: err});
            });
        }
        else {
            res.json({code: 0, message: 'No data'})
        }
    },

    getAllCategory : function(req, res){
        Category
            .find()
            .select('_id name items guide')
            .populate({
                path: 'items',
                select: '_id name img'
            })
            .exec(function(err, data){
                if(err) {
                    console.error(err);
                    res.json({code : 0, message: err});
                }
                res.json({code : 1, result: data});
            });
    },

    getFoodByCategory : function(req, res){
        if (req.params._id) {
            Category
                .findOne({_id:  req.params._id})
                .populate({
                    path: 'items',
                    select: '-guide'
                })
                .exec(function(err, data){
                    if(err) {
                        console.error(err);
                        res.json({code : 0, message: err});
                    }
                    else {
                        res.json({code : 1, result: data.items});
                    }
                });
        } else {
            res.json({code : 0, message: 'Not found'});
        }

    },

    findFoodById : function(req, res){
        if (req.params._id) {
            Food
                .findOne({_id:  req.params._id})
                .select('_id name img guide')
                .exec(function(err, data){
                    if(err) {
                        console.error(err);
                        res.json({code : 0, message: err});
                    }
                    res.json({code : 1, result: data});
                });
        } else {
            res.json({code : 0, message: 'Not found'});
        }

    }
};
