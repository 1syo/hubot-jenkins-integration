require("blanket") {
  "data-cover-never": "node_modules"
  pattern: ["jenkins-notification.coffee", "postman.coffee"]
  loader: "./node-loaders/coffee-script"
}
