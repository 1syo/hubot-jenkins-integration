# Description
#   Postman build a message from json.
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

  build_phase: ->
    @json.build.phase.toLowerCase()

  finalized: ->
    (@build_phase() == 'finalized')

  deliverable: ->
    (@build_phase() != 'completed')

  status: ->
    if @finalized()
      " #{@build_status()}"
    else
      ""

  url: ->
    if @build_url()?
      "\n#{@build_url()}"
    else
      ""

  message: ->
    "[Jenkins] #{@name()} build #{@build_phase()} ##{@build_number()}#{@status()}#{@url()}"


class Common extends Base
  deliver: ->
    @robot.send {room: @room()}, @message()


class Slack extends Base
  color: ->
    switch @build_status()
      when "success"
        "good"
      when "failure"
        "danger"
      else
        "#E3E4E6"

  number: ->
    if @build_url()?
      "#{@build_url()}|##{@build_number()}"
    else
      "##{@build_number()}"

  text: ->
    "[Jenkins] #{@name()} build #{@build_phase()} #{@number()}#{@status()}"

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
