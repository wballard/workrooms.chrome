This is a content script that will detect and augment gravatars
with video calls.

    _ = require('lodash')
    ChromeEventEmitter = require('./chrome-event-emitter.litcoffee')

Connect to chrome, this talks to the background page on a per tab basis, which
is required to get the permissions correct to allow sharing the screen.

    channel = chrome.runtime.connect()
    channel.onMessage.addListener (message) ->
      console.log('content channel message', message)
      window.postMessage(message, '*')

Listen for window events, these will be coming in from the appication running
on page.

    if not document.getElementById('workrooms-extension-is-installed')
      window.addEventListener 'message', (evt) ->
        console.log 'content window message', evt
        channel.postMessage evt.data

Mark that the extension is available.

      isInstalledNode = document.createElement('div')
      isInstalledNode.id = 'workrooms-extension-is-installed'
      document.body.appendChild(isInstalledNode)
