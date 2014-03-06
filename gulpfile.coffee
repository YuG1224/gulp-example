gulp = require('gulp')
coffee = require('gulp-coffee')
uglify = require('gulp-uglify')
stylus = require('gulp-stylus')
minify = require('gulp-minify-css')
clean = require('gulp-clean')
nodemon = require('gulp-nodemon')
src =
    app: './src/app.coffee'
    routes: './src/routes/*.coffee'
    coffee: './src/coffee/*.coffee'
    stylus: './src/stylus/*.styl'
    images: './src/images/*'
development =
    scripts: './public/javascripts/*.js'
    css: './public/stylesheets/*.css'
    images: './public/images/*'
production =
    scripts: './build/javascripts/*.js'
    css: './build/stylesheets/*.css'
    images: './build/images/*'
    

# CoffeScriptのコンパイルを行う。
gulp.task 'coffee', ->
    gulp.src src.app
        .pipe coffee()
        .pipe gulp.dest './'
    gulp.src src.routes
        .pipe coffee()
        .pipe gulp.dest './routes/'
    gulp.src src.coffee
        .pipe coffee()
        .pipe gulp.dest './public/javascripts/'
        .pipe uglify()
        .pipe gulp.dest './build/javascripts/'
    return

# Stylusのコンパイルを行う。
gulp.task 'stylus', ->
    gulp.src src.stylus
        .pipe stylus()
        .pipe gulp.dest './public/stylesheets'
        .pipe minify()
        .pipe gulp.dest './build/stylesheets/'
    return

# imageのコピーを行う。
gulp.task 'copy', ->
    gulp.src src.images
        .pipe gulp.dest './public/images/'
        .pipe gulp.dest './build/images/'
    return

# ファイルを監視して、変更が合った場合はコンパイルし直す。
gulp.task 'watch', ->
    gulp.watch [src.app, src.routes, src.coffee], (event) ->
        gulp.run 'coffee'
        return
    gulp.watch src.stylus, (event) ->
        gulp.run 'stylus'
        return
    gulp.watch './src/images', (event) ->
        gulp.run 'copy'
        return

# ディレクトリを空にする。
gulp.task 'clean', ->
    gulp.src ['app.js', './routes/*', './public/*/*', './build/*/*']
        .pipe clean()
    return

# node を実行する。
gulp.task 'nodemon', ->
    nodemon
        script: 'app.js'
        env:
            TZ: 'UTC'
            NODE_ENV: 'development'
    .on 'restart', ['coffee', 'stylus']
    return

gulp.task 'default', ->
    # place code for your default task here
    gulp.run 'clean', 'coffee', 'stylus', 'copy', 'watch', 'nodemon'
    return
