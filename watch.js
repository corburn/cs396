#!/usr/bin/env node

var async = require('async');
var exec = require('child_process').exec;
var gaze = require('gaze');
var path = require('path');
var rimraf = require('rimraf');
var sys = require('sys');

// trim path from __filename
var prgname = __filename.slice(__dirname.length+1,__filename.length);
var srcDir = './src';
var binDir = './bin';
var umple = 'umple_1.20.0.3845.jar';

gaze(['**/*.ump'], function(err, watcher) {
    this.on('all', function(event, filepath) {
        var package = filepath.split('/')[filepath.split('/').length - 1].replace(/\..+$/, '').toLowerCase();
        console.log(prgname + ': ' + filepath + ' was modified');
        if (!filepath.match(/\.ump$/)) {
            console.error(filepath + ' does not appear to be an umple file');
            return;
        }
        async.series({
            clean: function(cb) {
                async.parallel([
                    function(callback) {
                        var p = path.join(__dirname, srcDir, package);
                        console.log(prgname + ': rm -rf ' + p);
                        rimraf(p, function(err) {
                            callback(err);
                        });
                    },
                    function(callback) {
                        var p = path.join(__dirname, binDir, package);
                        console.log(prgname + ': rm -rf ' + p);
                        rimraf(p, function(err) {
                            callback(err);
                        });
                    }
                ], function(err, results) {
                    cb(err);
                });
            },
            generate: function(cb) {
                var cmd = 'java -jar ' + umple + ' --path ' + srcDir + ' --generate Java ' + filepath;
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

