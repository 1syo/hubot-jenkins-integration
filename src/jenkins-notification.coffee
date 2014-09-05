# Description
#   A hubot script that notify build status from jenkins notification plugin.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# URLS:
#   POST /<hubot>/travisci/<room>
#
# Notes:
#   See also: https://wiki.jenkins-ci.org/display/JENKINS/Notification+Plugin
#
# Author:
#   TAKAHASHI Kazunari[takahashi@1syo.net]

Postman = require "./postman"
module.exports = (robot) ->
  robot.router.post "/#{robot.name}/jenkins/:room", (req, res) ->
    try
      postman = Postman.create(req, robot)
      if postman.deliverable()
        postman.deliver()
        res.end "[Jenkins] Sending message"
      else
        res.end ""
    catch e
      res.end "[Jenkins] #{e}"
