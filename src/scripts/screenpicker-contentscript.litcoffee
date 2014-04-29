This is a content script that will detect and augment gravatars
with video calls.

    _ = require('lodash')
    ChromeEventEmitter = require('./chrome-event-emitter.litcoffee')

    backgroundChannel = new ChromeEventEmitter('background')
    screenChannel = new ChromeEventEmitter('screen')

    window.addEventListener "message", (evt) ->
      console.log 'screencapture', evt
