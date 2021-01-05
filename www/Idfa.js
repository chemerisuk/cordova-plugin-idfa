var exec = require("cordova/exec");
var PLUGIN_NAME = "Idfa";

module.exports = {
    TrackingPermission: Object.freeze({
        Authorized: "Authorized",
        Denied: "Denied",
        Restricted: "Restricted",
        NotDetermined: "NotDetermined",
    }),

    getInfo: function() {
        return new Promise(function(resolve, reject) {
            exec(resolve, reject, PLUGIN_NAME, "getInfo", []);
        });
    },

    requestPermission: function() {
        return new Promise(function(resolve, reject) {
            exec(resolve, reject, PLUGIN_NAME, "requestPermission", []);
        });
    }
};
