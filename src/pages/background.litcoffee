This is the application -- the background page that ties it all together.

Originally, this was in Polymer, but 0.2.0 broke custom element support in background pages
which in some sense it no big deal as this isn't really a 'page' at all. So -- code it is!

    require('../scripts/chrome-devreloader.litcoffee')(reload: true)
    Screenpicker = require('../scripts/screenpicker.litcoffee')
    ChromeEventEmitter = require('../scripts/chrome-event-emitter.litcoffee')

    _ = require('lodash')

    console.log 'starting application'

    chrome.browserAction.setIcon path: '../images/tool_icon.png'

    screenpicker = new Screenpicker()
    backgroundChannel = new ChromeEventEmitter('background')
    screenChannel = new ChromeEventEmitter('screen')

Of course, chrome events don't follow the pattern for dom elements...

    chrome.browserAction.onClicked.addListener =>
      console.log 'OUCH!'
