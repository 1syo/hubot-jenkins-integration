# hubot-jenkins-notifier
[![wercker status](https://app.wercker.com/status/26315fdf97b3e79f36cd855ec7bedf33/s/master "wercker status")](https://app.wercker.com/project/bykey/26315fdf97b3e79f36cd855ec7bedf33)
[![Coverage Status](http://img.shields.io/coveralls/1syo/hubot-jenkins-notifier.svg?style=flat)](https://coveralls.io/r/1syo/hubot-jenkins-notifier)
[![Dependencies Status](http://img.shields.io/david/1syo/hubot-jenkins-notifier.svg?style=flat)](https://david-dm.org/1syo/hubot-jenkins-notifier)

A hubot script that notify build status from jenkins notification plugin.

## Installation

In hubot project repo, run:

`npm install git://github.com/1syo/hubot-jenkins-notifier.git --save`

Then add **hubot-jenkins-notifier** to your `external-scripts.json`:

```json
["hubot-jenkins-notifier"]
```

## Jenkins configuration

Install notification plugin to your Jenkins  
And add new endpoint in your project.
- Format: ``JSON``
- Protcol: ``http``
- URL: ``<hubot host>:<hubot port>/<hubot name>/jenkins/<room>``

See also:  
https://wiki.jenkins-ci.org/display/JENKINS/Notification+Plugin  

## Notification examples

If you use slack adapter then your message use Slack attachments.

### Slack Adapter

![](https://raw.githubusercontent.com/wiki/1syo/hubot-jenkins-notifier/slack.png)

### Slack Adapter (fallback)

![](https://raw.githubusercontent.com/wiki/1syo/hubot-jenkins-notifier/slack-fallback.png)

### Shell Adapter

![](https://raw.githubusercontent.com/wiki/1syo/hubot-jenkins-notifier/shell.png)
