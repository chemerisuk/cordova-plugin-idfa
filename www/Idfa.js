var exec = require("cordova/exec");
var PLUGIN_NAME = "Idfa";

module.exports = {
    getInfo: function() {
        return new Promise(function(resolve, reject) {
            exec(resolve, reject, PLUGIN_NAME, "getInfo", []);
        });
    },

    requestTrackingAuthorization: function() {
        return new Promise(function(resolve, reject) {
            exec(resolve, reject, PLUGIN_NAME, "requestTrackingAuthorization", []);
        });
    }
};
