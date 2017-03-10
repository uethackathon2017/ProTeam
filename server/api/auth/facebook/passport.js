var passport = require('passport');
var FacebookTokenStrategy = require('passport-facebook-token');

module.exports = function(User) {
    passport.serializeUser( function( user, cb ) {
        //nothing to do here as we use the username as it is
        cb( null, user );
    } );

    passport.deserializeUser( function( obj, cb ) {
        //again, we just pass the username forward
        cb( null, obj );
    } );

    passport.use(new FacebookTokenStrategy({
      clientID: '1327572307330779',
      clientSecret: 'c74489b41d88717c005bd3e840d56332'
    },
    function(accessToken, refreshToken, profile, cb) {
      // console.log(profile);
      User.findOneOrCreate(
        { username: profile.id, name: profile.displayName},
        { username: profile.id, name: profile.displayName },
        function (err, user) {
          return cb(err, user);
      });
    }
  ));
};
