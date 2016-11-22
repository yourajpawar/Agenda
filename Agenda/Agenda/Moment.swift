//
//  Moment.swift
//  SwiftMoment
//
//  Created by Adrian on 19/01/15.
//  Copyright (c) 2015 Adrian Kosmaczewski. All rights reserved.
//

// Swift adaptation of Moment.js http://momentjs.com
// Github: https://github.com/moment/moment/

import Foundation

/**
Returns a moment representing the current instant in time
at the current timezone.

- returns: A Moment instance.
*/
public func moment(timeZone: NSTimeZone = NSTimeZone.default as NSTimeZone
    , locale: NSLocale = NSLocale.autoupdatingCurrent as NSLocale) -> Moment {
    return Moment(timeZone: timeZone, locale: locale)
}

public func utc() -> Moment {
    let zone = NSTimeZone(abbreviation: "UTC")!
    return moment(timeZone: zone)
}

/**
Returns an Optional wrapping a Moment structure, representing the
current instant in time. If the string passed as parameter cannot be
parsed by the function, the Optional wraps a nil value.

- parameter stringDate: A string with a date representation.
- parameter timeZone:   An NSTimeZone object

- returns: An optional Moment instance.
*/
public func moment(stringDate: String
    ,timeZone: NSTimeZone = NSTimeZone.default as NSTimeZone
    , locale: NSLocale = NSLocale.autoupdatingCurrent as NSLocale) -> Moment? {

    let formatter = DateFormatter()
    formatter.timeZone = timeZone as TimeZone!
    formatter.locale = locale as Locale!
    let isoFormat = "yyyy-MM-ddTHH:mm:ssZ"

    // The contents of the array below are borrowed
    // and adapted from the source code of Moment.js
    // https://github.com/moment/moment/blob/develop/moment.js
    let formats = [
        isoFormat,
        "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'",
        "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'",
        "yyyy-MM-dd",
        "h:mm:ss A",
        "h:mm A",
        "MM/dd/yyyy",
        "MMMM d, yyyy",
        "MMMM d, yyyy LT",
        "dddd, MMMM D, yyyy LT",
        "yyyyyy-MM-dd",
        "yyyy-MM-dd",
        "GGGG-[W]WW-E",
        "GGGG-[W]WW",
        "yyyy-ddd",
        "HH:mm:ss.SSSS",
        "HH:mm:ss",
        "HH:mm",
        "HH"
    ]

    for format in formats {
        formatter.dateFormat = format

        if let date = formatter.date(from: stringDate) {
            return Moment(date: date as NSDate, timeZone: timeZone, locale: locale)
        }
    }
    return nil
}

public func moment(stringDate: String
    , dateFormat: String
    ,timeZone: NSTimeZone = NSTimeZone.default as NSTimeZone
    , locale: NSLocale = NSLocale.autoupdatingCurrent as NSLocale) -> Moment? {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    formatter.timeZone = timeZone as TimeZone!
    formatter.locale = locale as Locale!
    if let date = formatter.date(from: stringDate) {
        return Moment(date: date as NSDate, timeZone: timeZone, locale: locale)
    }
    return nil
}

/**
Builds a new Moment instance using an array with the following components,
in the following order: [ year, month, day, hour, minute, second ]

- parameter dateComponents: An array of integer values
- parameter timeZone:   An NSTimeZone object

- returns: An optional wrapping a Moment instance
*/
public func moment(params: [Int]
    ,timeZone: NSTimeZone = NSTimeZone.default as NSTimeZone
    , locale: NSLocale = NSLocale.autoupdatingCurrent as NSLocale) -> Moment? {
    if params.count > 0 {
        var calendar = NSCalendar.current
        calendar.timeZone = timeZone as TimeZone
        let components = NSDateComponents()
        components.year = params[0]
        
        if params.count > 1 {
            components.month = params[1]
            if params.count > 2 {
                components.day = params[2]
                if params.count > 3 {
                    components.hour = params[3]
                    if params.count > 4 {
                        components.minute = params[4]
                        if params.count > 5 {
                            components.second = params[5]
                        }
                    }
                }
            }
        }
        
        if let date = calendar.date(from: components as DateComponents) {
            return moment( date: date as NSDate, timeZone: timeZone, locale: locale)
        }
    }
    return nil
}

public func moment(dict: [String: Int]
    ,timeZone: NSTimeZone = NSTimeZone.default as NSTimeZone
    , locale: NSLocale = NSLocale.autoupdatingCurrent as NSLocale) -> Moment? {
    if dict.count > 0 {
        var params = [Int]()
        if let year = dict["year"] {
            params.append(year)
        }
        if let month = dict["month"] {
            params.append(month)
        }
        if let day = dict["day"] {
            params.append(day)
        }
        if let hour = dict["hour"] {
            params.append(hour)
        }
        if let minute = dict["minute"] {
            params.append(minute)
        }
        if let second = dict["second"] {
            params.append(second)
        }
        return moment(params: params, timeZone: timeZone, locale: locale)
    }
    return nil
}

public func moment(milliseconds: Int) -> Moment {
    return moment(seconds: TimeInterval(milliseconds / 1000))
}

public func moment(seconds: TimeInterval) -> Moment {
    let interval = TimeInterval(seconds)
    let date = NSDate(timeIntervalSince1970: interval)
    return Moment(date: date)
}

public func moment(date: NSDate
    ,timeZone: NSTimeZone = NSTimeZone.default as NSTimeZone
    , locale: NSLocale = NSLocale.autoupdatingCurrent as NSLocale) -> Moment {
    return Moment(date: date, timeZone: timeZone, locale: locale)
}

public func moment(moment: Moment) -> Moment {
    let copy = moment.date.copy() as! NSDate
    let timeZone = moment.timeZone.copy() as! NSTimeZone
    let locale = moment.locale.copy() as! NSLocale
    return Moment(date: copy, timeZone: timeZone, locale: locale)
}

public func past() -> Moment {
    return Moment(date: NSDate.distantPast as NSDate )
}

public func future() -> Moment {
    return Moment(date: NSDate.distantFuture as NSDate )
}

public func since(past: Moment) -> Duration {
    return moment().intervalSince(moment: past)
}

public func maximum(moments: Moment...) -> Moment? {
    if moments.count > 0 {
        var max: Moment = moments[0]
        for moment in moments {
            if moment > max {
                max = moment
            }
        }
        return max
    }
    return nil
}

public func minimum(moments: Moment...) -> Moment? {
    if moments.count > 0 {
        var min: Moment = moments[0]
        for moment in moments {
            if moment < min {
                min = moment
            }
        }
        return min
    }
    return nil
}

/**
 Internal structure used by the family of moment() functions.
 Instead of modifying the native NSDate class, this is a
 wrapper for the NSDate object. To get this wrapper object, simply
 call moment() with one of the supported input types.
*/
public struct Moment: Comparable {
    let date: NSDate
    let timeZone: NSTimeZone
    let locale: NSLocale

    init(date: NSDate = NSDate()
        , timeZone: NSTimeZone = NSTimeZone.default as NSTimeZone
        , locale: NSLocale = NSLocale.autoupdatingCurrent as NSLocale) {
        self.date = date
        self.timeZone = timeZone
        self.locale = locale
    }

    /// Returns the year of the current instance.
    public var year: Int {
        var cal = NSCalendar.current
        cal.timeZone = timeZone as TimeZone
        cal.locale = locale as Locale
        let year = cal.component(.year, from: date as Date)
        return year
    }

    /// Returns the month (1-12) of the current instance.
    public var month: Int {
        var cal = NSCalendar.current
        cal.timeZone = timeZone as TimeZone
        cal.locale = locale as Locale

        let month = cal.component(.month, from: date as Date)
        return month
    }

    /// Returns the name of the month of the current instance, in the current locale.
    public var monthName: String {
        let formatter = DateFormatter()
        formatter.locale = locale as Locale!
        return formatter.monthSymbols[month - 1] 
    }

    public var day: Int {
        var cal = NSCalendar.current
        cal.timeZone = timeZone as TimeZone
        cal.locale = locale as Locale
        let day = cal.component(.day, from: date as Date)
        return day
    }

    public var hour: Int {
        var cal = NSCalendar.current
        cal.timeZone = timeZone as TimeZone
        cal.locale = locale as Locale
        let hour = cal.component(.hour, from: date as Date)
        return hour
    }

    public var minute: Int {
        var cal = NSCalendar.current
        cal.timeZone = timeZone as TimeZone
        cal.locale = locale as Locale
        let minute = cal.component(.minute, from: date as Date)
        return minute
    }

    public var second: Int {
        var cal = NSCalendar.current
        cal.timeZone = timeZone as TimeZone
        cal.locale = locale as Locale
        let second = cal.component(.second, from: date as Date)
        return second
    }

    public var weekday: Int {
        var cal = NSCalendar.current
        cal.timeZone = timeZone as TimeZone
        cal.locale = locale as Locale
        let weekday = cal.component(.weekday, from: date as Date)
        return weekday
    }

    public var weekdayName: String {
        let formatter = DateFormatter()
        formatter.locale = locale as Locale!
        formatter.dateFormat = "EEEE"
        formatter.timeZone = timeZone as TimeZone!
        return formatter.string(from: date as Date)
    }

    public var weekdayOrdinal: Int {
        var cal = NSCalendar.current
        cal.locale = locale as Locale
        cal.timeZone = timeZone as TimeZone
        let weekdayOrdinal = cal.component(.weekdayOrdinal, from: date as Date)
        return weekdayOrdinal
    }

    public var weekOfYear: Int {
        var cal = NSCalendar.current
        cal.locale = locale as Locale
        cal.timeZone = timeZone as TimeZone
        let weekOfYear = cal.component(.weekOfYear, from: date as Date)
        return weekOfYear
    }

    public var quarter: Int {
        var cal = NSCalendar.current
        cal.locale = locale as Locale
        cal.timeZone = timeZone as TimeZone
        let quarter = cal.component(.quarter, from: date as Date)
        return quarter
    }

    // Methods

    public func get(unit: TimeUnit) -> Int? {
        switch unit {
        case .Seconds:
            return second
        case .Minutes:
            return minute
        case .Hours:
            return hour
        case .Days:
            return day
        case .Months:
            return month
        case .Quarters:
            return quarter
        case .Years:
            return year
        }
    }

    public func get(unitName: String) -> Int? {
        if let unit = TimeUnit(rawValue: unitName) {
            return get(unit:unit)
        }
        return nil
    }

    public func format(dateFormat: String = "yyyy-MM-dd HH:mm:ss ZZZZ") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = timeZone as TimeZone!
        formatter.locale = locale as Locale!
        return formatter.string(from: date as Date)
    }

    public func isEqualTo(moment: Moment) -> Bool {
        return date.isEqual(to: moment.date as Date)
    }

    public func intervalSince(moment: Moment) -> Duration {
        let interval = date.timeIntervalSince(moment.date as Date)
        return Duration(value: Int(interval))
    }

    public func add(value: Int, _ unit: TimeUnit) -> Moment {
        let components = NSDateComponents()
        switch unit {
        case .Years:
            components.year = value
        case .Quarters:
            components.month = 3 * value
        case .Months:
            components.month = value
        case .Days:
            components.day = value
        case .Hours:
            components.hour = value
        case .Minutes:
            components.minute = value
        case .Seconds:
            components.second = value
        }
        let cal = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        cal.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        if let newDate = cal.date(byAdding: components as DateComponents, to: date as Date, options: NSCalendar.Options.init(rawValue: 0)) {
          return Moment(date: newDate as NSDate)
        }
        return self
    }

    public func add(value: TimeInterval, _ unit: TimeUnit) -> Moment {
        let seconds = convert(value:value, unit)
        let interval = TimeInterval(seconds)
        let newDate = date.addingTimeInterval(interval)
        return Moment(date: newDate)
    }

    public func add(value: Int, _ unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return add(value:value, unit)
        }
        return self
    }

    public func add(duration: Duration) -> Moment {
        return add(value:duration.interval, .Seconds)
    }

    public func subtract(value: TimeInterval, _ unit: TimeUnit) -> Moment {
        return add(value:-value, unit)
    }

    public func subtract(value: Int, _ unit: TimeUnit) -> Moment {
        return add(value:-value, unit)
    }

    public func subtract(value: Int, _ unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return subtract(value:value, unit)
        }
        return self
    }

    public func subtract(duration: Duration) -> Moment {
        return subtract(value:duration.interval, .Seconds)
    }

    public func isCloseTo(moment: Moment, precision: TimeInterval = 300) -> Bool {
        // "Being close" is measured using a precision argument
        // which is initialized a 300 seconds, or 5 minutes.
        let delta = intervalSince(moment:moment)
        return abs(delta.interval) < precision
    }

    public func startOf(unit: TimeUnit) -> Moment {
        let cal = NSCalendar.current
        var newDate: NSDate?
        var components = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date as Date)
        switch unit {
        case .Seconds:
            return self
        case .Years:
            components.month = 1
            fallthrough
        case .Quarters, .Months:
            components.day = 1
            fallthrough
        case .Days:
            components.hour = 0
            fallthrough
        case .Hours:
            components.minute = 0
            fallthrough
        case .Minutes:
            components.second = 0
        }
        
        newDate = cal.date(from:components)! as Date as NSDate?
        return newDate == nil ? self : Moment(date: newDate!)
    }

    public func startOf(unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return startOf(unit: unit)
        }
        return self
    }

    public func endOf(unit: TimeUnit) -> Moment {
        
        return startOf(unit: unit).add(value:1, unit).subtract(duration:1.seconds)
    }

    public func endOf(unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return endOf(unit: unit)
        }
        return self
    }

    public func epoch() -> TimeInterval {
        return date.timeIntervalSince1970
    }

    // Private methods

    func convert(value: Double, _ unit: TimeUnit) -> Double {
        switch unit {
        case .Seconds:
            return value
        case .Minutes:
            return value * 60
        case .Hours:
            return value * 3600 // 60 minutes
        case .Days:
            return value * 86400 // 24 hours
        case .Months:
            return value * 2592000 // 30 days
        case .Quarters:
            return value * 7776000 // 3 months
        case .Years:
            return value * 31536000 // 365 days
        }
    }
}

extension Moment: CustomStringConvertible {
    public var description: String {
        return format()
    }
}

extension Moment: CustomDebugStringConvertible {
    public var debugDescription: String {
        return description
    }
}

