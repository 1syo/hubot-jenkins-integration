require("blanket") {
  "data-cover-never": "node_modules"
  pattern: ["jenkins-notifier.coffee", "postman.coffee"]
  loader: "./node-loaders/coffee-script"
}
