Number.prototype.between = (start, end)->
    return this >= start and this <= end

filter =
    urls: [
        "*://*.zhihu.com/*"
        "*://*.v2ex.com/*"
        "*://*.weibo.com/*"
        "*://*.sina.com/*"
        "*://*.taobao.com/*"
        "*://*.360buy.com/*"
        "*://*.jd.com/*"
        "*://*.dangdang.com/*"
        "*://*.vancl.com/*"
    ]

HOLIDAY_CONFIG =
    "2015":
        "holiday": "1.1-1.3,2.18-2.24,4.5-4.6,5.1,6.20,6.22,9.27,10.1-10.7"
        "workday": "1.4,2.15,2.28,10.10"

handler = (detail)->
    now = new Date()
    if is_workday(now) and is_work_hour(now.getHours())
        return {
            redirectUrl: chrome.extension.getURL("index.html")
        }

chrome.webRequest.onBeforeRequest.addListener handler, filter, ["blocking"]

###
    date is a workday
    1. not a holiday
    2. is a special workday
    3. or is Monday ~ Friday
###
is_workday = (date)->
    return false if is_holiday(date)
    return is_special_work_day(date) or is_weekday(date.getDay())

###
    get date time
###
get_date_time = (date)->
    d = new Date(date.getFullYear(), date.getMonth(), date.getDate())
    return d.getTime()

###
    date is holiday
###
is_holiday = (date)->
    year = date.getFullYear() + ""
    return false unless HOLIDAY_CONFIG[year]
    holiday_config = HOLIDAY_CONFIG[year].holiday
    holidays = holiday_config.split(',')
    current_date_time = get_date_time(date)
    for holiday in holidays
        if holiday.indexOf('-') is -1
            return current_date_time is new Date("#{year}.#{holiday}").getTime()
        else
            startTime = new Date("#{year}.#{holiday.split('-')[0]}").getTime()
            endDay = new Date("#{year}.#{holiday.split('-')[1]}")
            endDay.setDate(endDay.getDate() + 1)
            endTime = endDay.getTime()
            return current_date_time.between(startTime, endTime)
    return false

is_special_work_day = (date)->
    year = date.getFullYear() + ""
    return false unless HOLIDAY_CONFIG[year]
    workday_config = HOLIDAY_CONFIG[year].workday
    workdays = workday_config.split(',')
    current_date_time = get_date_time(date)
    for workday in workdays
        if workday.indexOf('-') is -1
            return current_date_time is new Date("#{year}.#{workday}").getTime()
        else
            startTime = new Date("#{year}.#{workday.split('-')[0]}").getTime()
            endTime = new Date("#{year}.#{workday.split('-')[1]}").getTime()
            return current_date_time.between(startTime, endTime)
    return false

parse_str_to_date = (year, date)->
    return new Date(year + "." + date)

is_weekday = (day)->
    return day > 0 and day < 6

is_work_hour = (hour)->
    return is_morning(hour) or is_afternoon(hour)

is_morning = (hour)->
    return hour >= 9 and hour < 12

is_afternoon = (hour)->
    return hour >= 14 and hour < 18
