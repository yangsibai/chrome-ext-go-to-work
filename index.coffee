filter =
    urls: [
        "*://*.zhihu.com/*"
        "*://*.v2ex.com/*"
        "*://*.weibo.com/*"
    ]

page = chrome.extension.getURL("index.html")

handler = (detail)->
    now = new Date()
    now_hour = now.getHours()
    day = now.getDay()
    if (day > 0 and day < 6) and (now_hour >= 9 and now_hour < 12) or (now_hour >= 14 and now_hour < 18)
        return {
            redirectUrl: page
        }

chrome.webRequest.onBeforeRequest.addListener handler, filter, ["blocking"]
