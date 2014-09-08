Robot = require("hubot/src/robot")

chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
request = require 'supertest'

finalized = require './fixtures/finalized.json'
completed = require './fixtures/completed.json'
started = require './fixtures/started.json'
invalid = require './fixtures/invalid.json'

describe 'jenkins-integration', ->
  robot = null
  beforeEach (done) ->
    robot = new Robot null, 'mock-adapter', yes, 'hubot'
    robot.adapter.on 'connected', ->
      require("../src/jenkins-notifier")(robot)
      adapter = @robot.adapter
      done()
    robot.run()

  it 'should be finalized', (done) ->
    request(robot.router)
      .post('/hubot/jenkins/general')
      .set('Accept','application/json')
      .send(finalized)
      .expect(200)
      .end (err, res) ->
        expect(res.text).to.eq "[Jenkins] Sending message"
        throw err if err
        done()

  it 'should be completed', (done) ->
    request(robot.router)
      .post('/hubot/jenkins/general')
      .set('Accept','application/json')
      .send(completed)
      .expect(200)
      .end (err, res) ->
        expect(res.text).to.eq ""
        throw err if err
        done()

  it 'should be started', (done) ->
    request(robot.router)
      .post('/hubot/jenkins/general')
      .set('Accept','application/json')
      .send(started)
      .expect(200)
      .end (err, res) ->
        expect(res.text).to.eq "[Jenkins] Sending message"
        throw err if err
        done()

  it 'should be invalid', (done) ->
    request(robot.router)
      .post('/hubot/jenkins/general')
      .set('Accept','application/json')
      .send(invalid)
      .expect(200)
      .end (err, res) ->
        expect(res.text).match /\[Jenkins\] TypeError: Cannot read property 'phase' of undefined/
        throw err if err
        done()

  afterEach ->
    robot.server.close()
    robot.shutdown()
