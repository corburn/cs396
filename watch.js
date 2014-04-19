#!/usr/bin/env node

var async = require('async');
var gaze = require('gaze');
var sys = require('sys');
var exec = require('child_process').exec;

var prgname = __filename.split('/')[__filename.split('/').length - 1];
var srcDir = './src';
var binDir = './bin';
var package = 'aviationcontrolsystem';
var mainClass = 'AviationControlSystem';

function run() {
    console.log(prgname + ': running...');
    var cmd = 'java -classpath ' + binDir + ' ' + package + '.' + mainClass;
    var child = exec(cmd, function (err, stdout, stderr) {
        sys.print('STDOUT\n' + stdout);
        sys.print('STDERR\n' + stderr);
        if (err) {
            throw err;
        }
    });
}

gaze(['./watch.js', '**/*.ump'], function(err, watcher) {
    this.on('all', function(event, filepath) {
        console.log(prgname + ': ' + filepath + ' was modified');
        async.series({
            generate: function(cb) {
                var cmd = 'java -jar umple_1.20.0.3845.jar --generate Java --path ' + srcDir + ' *.ump';
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
                    cb(err);
                });
            },
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
            }
        }, function (err, results) {
            if (err) throw err;
            //console.log(results);
        });
    });
});

// http://nodejs.org/api.html#_child_processes

