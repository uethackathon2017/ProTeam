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
      clientSecret: '33a8833009b56348398d09333a582e06'
    },
    function(accessToken, refreshToken, profile, cb) {
      // console.log(profile);
      User.findOneOrCreate(
        { username: profile.id},
        { username: profile.id, name: profile.displayName },
        function (err, user) {
          return cb(err, user);
      });
    }
  ));
};
