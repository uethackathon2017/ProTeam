/**
 * Created by khanh on 10/03/2017.
 */
'use strict';

var mongoose = require('mongoose');
mongoose.Promise = require('bluebird');
var Schema = mongoose.Schema;

var Exercise = new Schema({
    name: {
        type: String,
        require: true
    },
    youtube_id: {
        type: String,
        require: true
    },
    thumnail: String,
    describe: String,
    category: { type: Schema.Types.ObjectId, ref: 'CategoryExercise' }
},{
    timestamps: true
});


Exercise.pre('save', function(next) {
    this.thumnail = 'https://img.youtube.com/vi/'+this.youtube_id+'/mqdefault.jpg';
    next();

});

module.exports = mongoose.model('Exercise', Exercise);
