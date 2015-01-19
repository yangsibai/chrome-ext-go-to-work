filter =
    urls: [
        "*://*.zhihu.com/*"
        "*://*.v2ex.com/*"
        "*://*.weibo.com/*"
        "*://*.sina.com/*"
    ]

page = chrome.extension.getURL("index.html")

handler = (detail)->
    now = new Date()
    now_hour = now.getHours()
    day = now.getDay()
    if is_weekday(day) and is_work_hour(now_hour)
        return {
            redirectUrl: page
        }

is_weekday = (day)->
    return day > 0 and day < 6

is_work_hour = (hour)->
    return is_morning(hour) or is_afternoon(hour)

is_morning = (hour)->
    return hour >= 9 and hour < 12

is_afternoon = (hour)->
    return hour >= 14 and hour < 18

chrome.webRequest.onBeforeRequest.addListener handler, filter, ["blocking"]
