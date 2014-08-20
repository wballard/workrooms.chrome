This is the application -- the background page that ties it all together.

Originally, this was in Polymer, but 0.2.0 broke custom element support in background pages
which in some sense it no big deal as this isn't really a 'page' at all. So -- code it is!

    Screenpicker = require('../scripts/screenpicker.litcoffee')

    _ = require('lodash')

    screenpicker = new Screenpicker()

Multiple channels will be coming from from multiple possible content page tabs.

    chrome.runtime.onConnect.addListener (channel) ->
      channel.onMessage.addListener (message) ->

In comes a request, `getScreen`, which you ack right away with `getScreenPending`
to let the caller know that the extension is on the case. A dialog is popped
for the user to do the actual picking, then `gotScreen` is sent back with a tab
specific identifier that lets you get the screen as a media stream

        switch message.type
          when 'getScreen'
            pending = chrome.desktopCapture.chooseDesktopMedia message.options || ['screen', 'window'],
              channel.sender.tab,
              (streamid) ->
                message.type = 'gotScreen'
                message.sourceId = streamid
                channel.postMessage message
            message.type = 'getScreenPending'
            message.request = pending
            channel.postMessage message

Goodbye, cruel dialog!

          when 'cancelGetScreen'
            chrome.desktopCapture.cancelChooseDesktopMedia(message.request)
            message.type = 'canceledGetScreen'
            channel.postMessage message

