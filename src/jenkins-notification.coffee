# Description
#   A hubot script that does the things
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   TAKAHASHI Kazunari[@<org>]
Postman = require "./postman"
module.exports = (robot) ->
  robot.router.post "/#{robot.name}/jenkins/:room", (req, res) ->
    try
      postman = Postman.create(req, robot)
      postman.deliver()
      res.end "[Jenkins] Sending message"
    catch e
      res.end "[Jenkins] #{e}"
