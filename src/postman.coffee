# Description
#   Postman build a notice from json.
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
    @json.build.status?.toLowerCase()

  build_phase: ->
    @json.build.phase.toLowerCase()

  finalized: ->
    (@build_phase() == 'finalized' || @build_phase() == 'finished')

  notifiable: ->
    (@build_phase() != 'completed')

  status: ->
    if @finalized()
      " #{@build_status()}"
    else
      ""

  url: ->
    if @build_url()?
      " (#{@build_url()})"
    else
      ""

  notice: ->
    "[Jenkins] #{@name()} build #{@build_phase()} ##{@build_number()}#{@status()}#{@url()}"


class Common extends Base
  notify: ->
    @robot.send {room: @room()}, @notice()


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
      fallback: @notice()
      pretext: ""

  notify: ->
    @robot.emit 'slack-attachment', @payload()


class Postman
  @create: (req, robot) ->
    if robot.adapterName == 'slack'
      new Slack(req, robot)
    else
      new Common(req, robot)


module.exports = Postman
