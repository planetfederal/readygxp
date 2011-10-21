exports["test: proxy"] = require("./proxy_test");

if (require.main == module || require.main == module.id) {
    system.exit(require("test").run(exports));
}
