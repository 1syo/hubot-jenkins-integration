# hubot-jenkins-notification
[![wercker status](https://app.wercker.com/status/add43f567e82d4d271dc36fb31c23c49/s/master "wercker status")](https://app.wercker.com/project/bykey/add43f567e82d4d271dc36fb31c23c49)
[![Coverage Status](http://img.shields.io/coveralls/1syo/hubot-jenkins-notification.svg?style=flat)](https://coveralls.io/r/1syo/hubot-jenkins-notification)
[![Dependencies Status](http://img.shields.io/david/1syo/hubot-jenkins-notification.svg?style=flat)](https://david-dm.org/1syo/hubot-jenkins-notification)

hubot-jenkins-notification script notify build status form jenkins notification plugin.

See [`src/jenkins-notification.coffee`](src/jenkins-notification.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-jenkins-notification --save`

Then add **hubot-jenkins-notification** to your `external-scripts.json`:

```json
["hubot-jenkins-notification"]
```

## Note

If you use slack adapter then your message use Slack attachments.

### Slack

...

### Slack with IRC (fallback)

...

### Hipchat

...
