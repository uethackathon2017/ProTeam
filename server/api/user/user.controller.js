'use strict';

var User = require('./user.model');
var auth = require('../auth/auth.service');
var multer  =   require('multer');
var path = require('path');
var storage =   multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, './app/photos');
  },
  filename: function (req, file, callback) {
    callback(null, file.originalname.slice(0, file.originalname.indexOf('.')) + '_' +  Date.now() + file.originalname.slice(file.originalname.indexOf('.'), file.originalname.length));
  }
});
var upload = multer({ storage : storage}).single('file');


module.exports = {
  deleteUser: function (req, res) {
    User.findOne({username: req.params.username})
      .exec(function (err, data) {
        if (data) {
          data.remove(function (err) {
            if (err) {
              res.json({status: false, message: 'delete failed!!!'});
            } else {
              res.json({status: true, message: 'delete succeed!!!'});
            }
          })
        } else {
          res.json({status: false, message: 'delete failed!!!'});
        }
      })
  },

  edit: function (req, res) {
    if (req.body) {
      User.findOne({username: req.body.username}).exec(function (err, data) {
        if (data) {
          data.role = req.body.role;
          data.name = req.body.name;
        }
        data.save(function (err, newData) {
          if (err) {
            res.json({status: false, message: 'Update failed!!!'});
          }
          else {
            res.json({status: true, message: 'Update succeed!!!'});
          }
        });
      });
    }
    else {
      res.json({status: false, message: 'Update fail!!!'})
    }
  },

  addUser: function (req, res) {
    if (req.body) {
      User.findOne({username: req.body.username}).exec(function (err, data) {
        if (data) {
          res.json({status: false, message: 'User are already exist!'})
        } else {
          var newUser = {
            username: req.body.username,
            password: req.body.password,
            role: req.body.role,
            name: req.body.name
          };
          console.log(newUser);
          User.create(newUser, function (err, data) {
            res.json({status: true, message: 'Success'});
          });
        }
      });
    }
  },

  likeExercise: function (req, res) {
    User.findOneAndUpdate(
        { _id : req.user._id},
        {$addToSet : {like_exercises : req.params._id}},
        {upsert: true},
        function (err, ok) {
            if(err) res.json({code : 0, message: err});
            res.json({code : 1, message: 'Successful'});
        }
    );
  },

  unlikeExercise: function (req, res) {
        User.findOneAndUpdate(
            { _id : req.user._id},
            {$pull: {like_exercises : req.params._id}},
            {upsert: true},
            function (err, ok) {
                if(err) res.json({code : 0, message: err});
                res.json({code : 1, message: 'Successful'});
            }
        );
  },

  likeFood: function (req, res) {
      User.findOneAndUpdate(
          { _id : req.user._id},
          {$addToSet : {like_foods : req.params._id}},
          {upsert: true},
          function (err, ok) {
              if(err) res.json({code : 0, message: err});
              res.json({code : 1, message: 'Successful'});
          }
      );
  },

  unlikeFood: function (req, res) {
      User.findOneAndUpdate(
          { _id : req.user._id},
          {$pull: {like_foods : req.params._id}},
          {upsert: true},
          function (err, ok) {
              if(err) res.json({code : 0, message: err});
              res.json({code : 1, message: 'Successful'});
          }
      );
  },

  editUserSetting: function (req, res) {
      console.log(req.user);
      req.user.setting = req.body.setting;
      User.findOneAndUpdate(
          { _id : req.user._id},
          {setting: req.user.setting},
          {upsert: true},
          function (err, ok) {
              if(err) res.json({code : 0, message: err});
              res.json({code : 1, message: 'Successful'});
          }
      );
  },

  getSetting: function (req, res) {
      res.json({code: 1, result: req.user.setting});
  },

  getFavorite: function (req, res) {
      User.findOne({_id: req.user._id})
          .populate({
            path: 'like_exercises',
            select: '_id name thumnail youtube_id describe'
          })
          .populate({
              path: 'like_foods',
              select: '_id name img guide'
          })
          .exec(function (err, data) {
            if(err) res.json({code: 0, message: err});
            res.json({code: 1, result: {
                foods: data.like_foods,
                exercise: data.like_exercises
            }});

      });
  },

  login: function (req, res) {
    if (req.body.username) {
      User.findOne({username: req.body.username}).exec(function (err, data) {
        if (err) {
          console.error(err);
          res.json({code: 0, message: err});
        }
        else {
          if(data){
            if (data.authenticate(req.body.password)) {
              auth.signToken(data, function (token) {
                res.json({code: 1, message: 'login Success', result: {
                  name: data.name,
                  token: token
                }});

              });
            }
            else { //password is incorrect
              console.info('user ' + data._id + ' wrong password');
              res.json({code: 0, message: 'wrong password'});
            }
          } else {
            res.json({code: 0, message: 'username is wrong'});
          }
        }
      })
    } else {
      res.json({code: 0, message: 'No username'});
    }
  },

  confirm: function (req, res) {
    res.json({code: 1, message: 'u r admin'});
  },

  upload: function (req, res) {
    upload(req,res,function(err) {
      if(err) {
        res.json({code: 0, message: err});
      }
      else {

        if(req.file){
          res.json({code: 1, message: 'upload success', result: {url: 'http://localhost:6699/photos/' + req.file.filename}});
        }
        else {
          res.json({code: 0, message: 'No file sellected'});
        }
      }
    });

  }
};
