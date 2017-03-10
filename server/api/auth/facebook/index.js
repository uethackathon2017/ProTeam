'use strict';

var express = require('express');
var passport = require('passport');
var authService = require('../auth.service');

var router = express.Router();


router.post('/',
    passport.authenticate('facebook-token'),
    function (req, res) {

        if (req.user) {
            //you're authenticated! return sensitive secret information here.
            authService.signToken(req.user, function (token) {
                res.json({message: 'Login successful', result: req.user, access_token: token});
            });
        } else {
            // not authenticated. go away.
            res.json({code: 0, message: 'Login failed'})
        }
    }
);

module.exports = router;
