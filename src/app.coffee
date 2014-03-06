###
Module dependencies.
###
express = require('express')
routes = require('./routes')
http = require('http')
path = require('path')
app = express()
server = http.createServer(app)

# all environments
app.set 'port', process.env.PORT or 3000
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'
app.use express.favicon()
app.use express.logger('dev')
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use app.router

if app.get('env') is 'production'
    # NODE_ENV=production 用の設定
    app.use express.static(path.join(__dirname, 'build'))
else
    # NODE_ENV=development 等の設定
    app.use express.errorHandler()
    app.use express.static(path.join(__dirname, 'public'))
    
app.get '/', routes.index
server.listen app.get('port'), ->
    console.log 'Express server listening on port ' + app.get('port')
    return
