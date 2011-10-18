var {Application} = require("stick");

var app = exports.app = Application();
app.configure("notfound", "error", "static", "params", "mount");
app.static(module.resolve("static"));
app.mount("/proxy", require("./proxy").app);

// debug mode loads unminified scripts
// assumes markup pulls in scripts under the path /servlet_name/script/
if (true || java.lang.System.getProperty("app.debug")) {
    var fs = require("fs");
    var config = fs.normal(fs.join(module.directory, "..", "buildjs.cfg"));
    app.mount("/script/", require("./autoloader").App(config));

    // proxy a remote geoserver on /geoserver by setting proxy.geoserver to remote URL
    // only recommended for debug mode
    var geoserver = java.lang.System.getProperty("app.proxy.geoserver");
    if (geoserver) {
        if (geoserver.charAt(geoserver.length-1) !== "/") {
            geoserver = geoserver + "/";
        }
        // debug specific proxy
        app.mount("/geoserver/", require("./proxy").pass({url: geoserver, preserveHost: true}));
    }
}

// main script to start application
if (require.main === module) {
    require("ringo/httpserver").main(module.id);
}
