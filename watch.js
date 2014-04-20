#!/usr/bin/env node

var async = require('async');
var gaze = require('gaze');
var rimraf = require('rimraf');
var sys = require('sys');
var exec = require('child_process').exec;

var prgname = __filename.split('/')[__filename.split('/').length - 1];
var srcDir = './src';
var binDir = './bin';
var package = 'aviationcontrolsystem';
var mainClass = 'AviationControlSystem';

gaze(['./watch.js', '**/*.ump'], function(err, watcher) {
    this.on('all', function(event, filepath) {
        console.log(prgname + ': ' + filepath + ' was modified');
        async.series({
            clean: function(cb) {
                async.parallel([
                    function(callback) {
                        console.log(prgname + ': rm -rf ' + srcDir + '/' + package);
                        rimraf(srcDir + '/' + package, function(err) {
                            callback(err);
                        });
                    },
                    function(callback) {
                        console.log(prgname + ': rm -rf ' + binDir + '/' + package);
                        rimraf(binDir + '/' + package, function(err) {
                            callback(err);
                        });
                    }
                ], function(err, results) {
                    cb();
                });
            },
            generate: function(cb) {
                var cmd = 'java -jar umple_1.20.0.3845.jar --path ' + srcDir + ' --generate Java *.ump';
                console.log(prgname + ': generating Java...');
                console.log(prgname + ': ' + cmd);
                var child = exec(cmd, function (err, stdout, stderr) {
                    if (stdout) {
                        sys.print('STDOUT\n' + stdout);
                    }
                    if (stderr) {
                        sys.print('STDERR\n' + stderr);
                    }
                    cb(err);
                });
            },
            compile: function(cb) {
                var cmd = 'javac -classpath ' + srcDir + ' -d ' + binDir + ' ' + srcDir + '/' + package + '/*.java';
                console.log(prgname + ': compiling...');
                console.log(prgname + ': ' + cmd);
                var child = exec(cmd, function (err, stdout, stderr) {
                    if (stdout) {
                        sys.print('STDOUT\n' + stdout);
                    }
                    if (stderr) {
                        sys.print('STDERR\n' + stderr);
                    }
                    sys.print('DONE\n');
                    cb(err);
                });
            }/*,
            run: function(cb) {
                var cmd = 'java -classpath ' + binDir + ' ' + package + '.' + mainClass;
                console.log(prgname + ': running...');
                console.log(prgname + ': ' + cmd);
                var child = exec(cmd, function (err, stdout, stderr) {
                    if (stdout) {
                        sys.print('STDOUT\n' + stdout);
                    }
                    if (stderr) {
                        sys.print('STDERR\n' + stderr);
                    }
                    cb(err);
                });
            }*/
        }, function (err, results) {
            if (err) throw err;
            //console.log(results);
        });
    });
});

// http://nodejs.org/api.html#_child_processes

