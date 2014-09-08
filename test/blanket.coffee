require("blanket") {
  "data-cover-never": "node_modules"
  pattern: ["jenkins-integration.coffee", "postman.coffee"]
  loader: "./node-loaders/coffee-script"
}
