chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect

Postman = require '../src/postman'
valid_json = require './fixtures/valid.json'

describe 'Postman', ->
  beforeEach ->
    @req =
      body: valid_json
      params:
        room: "general"

  describe 'Common', ->
    beforeEach ->
      @robot =
        adapterName: "shell"
        send: sinon.spy()

      @postman = Postman.create(@req, @robot)

  describe 'Slack', ->
    beforeEach ->
      @robot =
        adapterName: "slack"
        emit: sinon.spy()

      @postman = Postman.create(@req, @robot)
