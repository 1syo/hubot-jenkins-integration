# hubot-jenkins-integration
[![wercker status](https://app.wercker.com/status/add43f567e82d4d271dc36fb31c23c49/s/master "wercker status")](https://app.wercker.com/project/bykey/add43f567e82d4d271dc36fb31c23c49)
[![Coverage Status](http://img.shields.io/coveralls/1syo/hubot-jenkins-integration.svg?style=flat)](https://coveralls.io/r/1syo/hubot-jenkins-integration)
[![Dependencies Status](http://img.shields.io/david/1syo/hubot-jenkins-integration.svg?style=flat)](https://david-dm.org/1syo/hubot-jenkins-integration)

A hubot script that notify build status from jenkins notification plugin.

## Installation

In hubot project repo, run:

`npm install hubot-jenkins-integration --save`

Then add **hubot-jenkins-integration** to your `external-scripts.json`:

```json
["hubot-jenkins-integration"]
```

## Jenkins configuration

Install notification plugin to your Jenkins  
And add new endpoint in your project.
- Format: JSON
- Protcol: http
- URL: <hubot host>:<hubot port>/<hubot name>/jenkins/<room>

See also:  
https://wiki.jenkins-ci.org/display/JENKINS/Notification+Plugin  

## Message examples

If you use slack adapter then your message use Slack attachments.

### Slack

...

### Slack with IRC (fallback)

...

### Hipchat

...
