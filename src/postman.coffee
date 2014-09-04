# Description
#   A hubot script that does the things
#
class Base
  constructor: (@req, @robot) ->
    @json = @req.body

  room: ->
    @req.params.room || ""

  name: ->
    @json.name

  build_url: ->
    @json.build.full_url

  build_number: ->
    @json.build.number

  build_status: ->
    @json.build.status.toLowerCase()

  message: ->
    "[Jenkins] #{@name()} build ##{@build_number()} #{@build_status()}"


class Common extends Base
  deliver: ->
    @robot.send {room: this.room()}, @message()

class Slack extends Base
  color: ->
    switch @build_status()
      when "success"
        "good"
      when "failure"
        "danger"
      else
        "#E3E4E6"

  text: ->
    "[Jenkins] #{@name()} build ##{@build_url()|@build_number()} #{@build_status()}"

  payload: ->
    message:
      room: @room()
    content:
      text: @text()
      color: @color()
      fallback: @message()
      pretext: ""

  deliver: ->
    @robot.emit 'slack-attachment', @payload()


class Postman
  @create: (req, robot) ->
    if robot.adapterName == 'slack'
      new Slack(req, robot)
    else
      new Common(req, robot)


module.exports = Postman
