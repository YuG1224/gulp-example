
/*
Module dependencies.
 */

(function() {
  var app, express, http, path, routes, server;

  express = require('express');

  routes = require('./routes');

  http = require('http');

  path = require('path');

  app = express();

  server = http.createServer(app);

  app.set('port', process.env.PORT || 3000);

  app.set('views', path.join(__dirname, 'views'));

  app.set('view engine', 'jade');

  app.use(express.favicon());

  app.use(express.logger('dev'));

  app.use(express.json());

  app.use(express.urlencoded());

  app.use(express.methodOverride());

  app.use(app.router);

  if (app.get('env') === 'production') {
    app.use(express["static"](path.join(__dirname, 'build')));
  } else {
    app.use(express.errorHandler());
    app.use(express["static"](path.join(__dirname, 'public')));
  }

  app.get('/', routes.index);

  server.listen(app.get('port'), function() {
    console.log('Express server listening on port ' + app.get('port'));
  });

}).call(this);
