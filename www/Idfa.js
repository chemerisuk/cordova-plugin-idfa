var exec = require("cordova/exec");
var PLUGIN_NAME = "Idfa";

module.exports = {
    TRACKING_PERMISSION_NOT_DETERMINED: 0,
    TRACKING_PERMISSION_RESTRICTED: 1,
    TRACKING_PERMISSION_DENIED: 2,
    TRACKING_PERMISSION_AUTHORIZED: 3,

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
