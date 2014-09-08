chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect

Postman = require '../src/postman'

describe 'Postman', ->
  describe 'Common', ->
    describe '#status', ->
      beforeEach ->
        @robot = { adapterName: "shell" }

      it 'build_phase is finalized', ->
        @req = body: { build: { status: 'FAILURE',  phase: 'FINALIZED' } }
        @postman = Postman.create(@req, @robot)
        expect(@postman.status()).to.eq " failure"

      it 'build_phase is not finalized', ->
        @req = body: { build: { phase: 'STARTED' } }
        @postman = Postman.create(@req, @robot)
        expect(@postman.status()).to.eq ""

    describe '#url', ->
      beforeEach ->
        @robot = { adapterName: "shell" }

      it 'full_url defined', ->
        @req = body: { build: { full_url: 'http://jenkins.example.com/' } }
        @postman = Postman.create(@req, @robot)
        expect(@postman.url()).to.eq "\nhttp://jenkins.example.com/"

      it 'full_url undefined', ->
        @req = body: { build: { } }
        @postman = Postman.create(@req, @robot)
        expect(@postman.url()).to.eq ""

    describe '#finalized', ->
      beforeEach ->
        @robot = { adapterName: "shell" }

      it 'true', ->
        @req = body: { build: { phase: 'FINALIZED' } }
        @postman = Postman.create(@req, @robot)
        expect(@postman.finalized()).to.eq true

      it 'true with finished', ->
        @req = body: { build: { phase: 'FINISHED' } }
        @postman = Postman.create(@req, @robot)
        expect(@postman.finalized()).to.eq true

      it 'false', ->
        @req = body: { build: {  phase: 'STARTED' } }
        @postman = Postman.create(@req, @robot)
        expect(@postman.finalized()).to.eq false

    describe '#deliverable', ->
      beforeEach ->
        @robot = { adapterName: "shell" }

      it 'true', ->
        @req = body: { build: { phase: 'FINALIZED' } }
        @postman = Postman.create(@req, @robot)
        expect(@postman.deliverable()).to.eq true

      it 'false', ->
        @req = body: { build: {  phase: 'COMPLETED' } }
        @postman = Postman.create(@req, @robot)
        expect(@postman.deliverable()).to.eq false

    describe '#message', ->
      beforeEach ->
        @req =
          body:
            name: 'test-build'
            build: { full_url: 'http://jenkins.example.com/', number: 12, status: 'FAILURE',  phase: 'FINALIZED' }

        @robot = { adapterName: "shell" }
        @postman = Postman.create(@req, @robot)

      it 'return message', ->
        expect(@postman.message()).to.eq "[Jenkins] test-build build finalized #12 failure\nhttp://jenkins.example.com/"

    describe '#deliver', ->
      beforeEach ->
        @req =
          params:
            room: 'general'
          body:
            name: 'test-build'
            build: { full_url: 'http://jenkins.example.com/', number: 12, status: 'FAILURE',  phase: 'FINALIZED' }

        @robot = { adapterName: "shell", send: sinon.spy() }
        @postman = Postman.create(@req, @robot)
        @postman.deliver()

      it 'call #send with args', ->
        expect(@robot.send).to.have.been.calledWith(
          {room: @postman.room()}, @postman.message()
        )

  describe 'Slack', ->
    describe '#color', ->
      beforeEach ->
        @robot = { adapterName: "slack" }

      it 'failure status', ->
        @req = body: { build: { status: 'FAILURE' } }
        @postman = Postman.create(@req, @robot)
        expect(@postman.color()).to.eq 'danger'

      it 'success status', ->
        @req = body: { build: { status: 'SUCCESS' } }
        @postman = Postman.create(@req, @robot)
        expect(@postman.color()).to.eq 'good'

      it 'other status', ->
        @req = body: { build: { status: '' } }
        @postman = Postman.create(@req, @robot)
        expect(@postman.color()).to.eq '#E3E4E6'

    describe '#number', ->
      beforeEach ->
        @robot = { adapterName: "slack" }

      it 'full_url defined', ->
        @req = body: { build: { full_url: 'http://jenkins.example.com/',  phase: 'STARTED', number: 14 } }
        @postman = Postman.create(@req, @robot)
        expect(@postman.number()).to.eq "http://jenkins.example.com/|#14"

      it 'full_url undefined', ->
        @req = body: { build: { phase: 'STARTED', number: 14 } }
        @postman = Postman.create(@req, @robot)
        expect(@postman.number()).to.eq "#14"

    describe '#text', ->
      beforeEach ->
        @robot = { adapterName: "slack" }

      it 'finalized message', ->
        @req =
          body:
            name: 'test-build'
            build: { full_url: 'http://jenkins.example.com/', phase: 'FINALIZED', status: 'SUCCESS', number: 14 }

        @postman = Postman.create(@req, @robot)
        expect(@postman.text()).to.eq "[Jenkins] test-build build finalized http://jenkins.example.com/|#14 success"

      it 'started message', ->
        @req =
          body:
            name: 'test-build'
            build: { full_url: 'http://jenkins.example.com/', phase: 'STARTED', number: 14 }

        @postman = Postman.create(@req, @robot)
        expect(@postman.text()).to.eq "[Jenkins] test-build build started http://jenkins.example.com/|#14"

    describe '#deliver', ->
      beforeEach ->
        @req =
          params:
            room: "general"
          body:
            name: 'test-build'
            build: { full_url: 'http://jenkins.example.com/', number: 12, status: 'FAILURE',  phase: 'FINALIZED' }

        @robot = { adapterName: "slack", emit: sinon.spy() }
        @postman = Postman.create(@req, @robot)
        @postman.deliver()

      it 'call #emit with args', ->
        expect(@robot.emit).to.have.been.calledWith(
          'slack-attachment', @postman.payload()
        )

    describe '#payload', ->
      beforeEach ->
        @req =
          params:
            room: "general"
          body:
            name: 'test-build'
            build: { full_url: 'http://jenkins.example.com/', number: 12, status: 'FAILURE',  phase: 'FINALIZED' }

        @robot = { adapterName: "slack", emit: sinon.spy() }
        @postman = Postman.create(@req, @robot)

      it '.message.room', ->
        expect(@postman.payload().message.room).to.eq 'general'

      it '.content.text', ->
        expect(@postman.payload().content.text).to.eq @postman.text()

      it '.content.color', ->
        expect(@postman.payload().content.color).to.eq @postman.color()

      it '.content.fallback', ->
        expect(@postman.payload().content.fallback).to.eq @postman.message()

      it '.content.pretext', ->
        expect(@postman.payload().content.pretext).to.eq ""
