(function () {
    "use strict";

    const gulp = require('gulp');
    const gulputil = require('./gulputil');
    const util = new gulputil.Util(gulp);

    util.watchTask('package', '*.*', function () {
        util.copy('package.json', 'build/server');
        util.copy('README.md', 'build/server');
    });
    
// ===================================================================
// Simple UI
// ===================================================================

    util.watchTask('simple-ui-script', 'simple-ui/**/**.coffee', function () {
        let srcPaths = util.relativePaths("simple-ui/", ["base.coffee", "event.coffee", "**/**.coffee"]);
        util.compileClientCoffee(srcPaths, 'simple-ui.js', "build");
    });

    util.watchTask('simple-ui-css', 'simple-ui/**/**.styl', function () {
        util.compileStylus("simple-ui/**/**.styl", 'simple-ui.css', "build");
    });

    util.watchTask('simple-ui-template', "simple-ui/**/**.jade", function () {
        util.jadeToClient(["simple-ui/**/**.jade"], 'FWT', 'simple-ui-template.js', 'build');
    });

// ===================================================================
// Admin UI
// ===================================================================

    util.watchTask('template', "admin-ui/**/**.jade", function () {
        util.jadeToClient(["admin-ui/**/**.jade", "!admin-ui/index.jade"], 'FT', 'template.js', 'build');
    });

    util.watchTask('html', "admin-ui/index.jade", function () {
        util.jadeToHtml("admin-ui/index.jade", 'build');
    });

    util.watchTask('css', 'admin-ui/**/**.styl', function () {
        util.compileStylus("admin-ui/**/**.styl", 'app.css', "build");
    });

    util.watchTask('setup-js', "admin-ui/setup.js", function () {
        util.copy("admin-ui/setup.js", 'build');
    });

    util.watchTask('script', 'admin-ui/**/**.coffee', function () {
        let srcPaths = util.relativePaths("admin-ui/", ["**/**.coffee", "main.coffee"]);
        util.compileClientCoffee(srcPaths, 'app.js', "build");
    });

    util.watchTask('img', "admin-ui/img/**", function () {
        util.copy("admin-ui/img/**", 'build/img');
    });

    util.watchTask('lib', "admin-ui-lib/**", function () {
        util.copy("admin-ui-lib/**/**", 'build/lib');
    });

    util.startWatchAndDefault();
})();