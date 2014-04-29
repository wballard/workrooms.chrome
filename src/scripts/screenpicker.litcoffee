This sets up a content script to watch for tabs.

    EventEmitter = require('events').EventEmitter
    module.exports =
      class Screenpicker extends EventEmitter
        constructor: ->
          chrome.tabs.query {}, (tabs) =>
            tabs.forEach @inject
          chrome.tabs.onUpdated.addListener (tabid, change, tab) =>
            if change.status is 'complete'
              @inject tab

Inject into an individual tab. Nothing fancy here except pay
attention to the paths of the files.

        inject: (tab) ->
          console.log 'injecting', tab
          ret = chrome.tabs.executeScript tab.id,
            file: '/scripts/screenpicker-contentscript.js'
            allFrames: true
          chrome.tabs.insertCSS tab.id,
            file: '/scripts/screenpicker-contentscript.css'
            allFrames: true
