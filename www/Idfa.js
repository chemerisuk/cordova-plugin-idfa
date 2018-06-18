var exec = require("cordova/exec");
var PLUGIN_NAME = "Idfa";

module.exports = {
    getIdfa: function() {
        return new Promise(function(resolve, reject) {
            exec(resolve, reject, PLUGIN_NAME, "getIdfa", []);
        });
    }
};
