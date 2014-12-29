filter =
    urls: [
        "*://*.zhihu.com/*"
        "*://*.v2ex.com/*"
        "*://*.weibo.com/*"
    ]

page = chrome.extension.getURL("index.html")

handler = (detail)->
    now_hour = new Date().getHours()
    if (now_hour >= 9 and now_hour <= 12) or (now_hour >= 14 and now_hour <= 18)
        return {
            redirectUrl: page
        }

chrome.webRequest.onBeforeRequest.addListener handler, filter, ["blocking"]
