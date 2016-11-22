//
//  Duration.swift
//  SwiftMoment
//
//  Created by Adrian on 19/01/15.
//  Copyright (c) 2015 Adrian Kosmaczewski. All rights reserved.
//

import Foundation


public struct Duration: Equatable {
    let interval: TimeInterval

    public init(value: TimeInterval) {
        self.interval = value
    }

    public init(value: Int) {
        self.interval = TimeInterval(value)
    }

    public var years: Double {
        return interval / 31536000 // 365 days
    }

    public var quarters: Double {
        return interval / 7776000 // 3 months
    }

    public var months: Double {
        return interval / 2592000 // 30 days
    }

    public var days: Double {
        return interval / 86400 // 24 hours
    }

    public var hours: Double {
        return interval / 3600 // 60 minutes
    }

    public var minutes: Double {
        return interval / 60
    }

    public var seconds: Double {
        return interval
    }

    public func ago() -> Moment {
        
        return moment().subtract(duration:self)
    }

    public func add(duration: Duration) -> Duration {
        return Duration(value: self.interval + duration.interval)
    }

    public func subtract(duration: Duration) -> Duration {
        return Duration(value: self.interval - duration.interval)
    }

    public func isEqualTo(duration: Duration) -> Bool {
        return self.interval == duration.interval
    }
}

extension Duration: CustomStringConvertible {
    public var description: String {
        let formatter = DateComponentsFormatter()
        formatter.calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian) as Calendar?
        formatter.calendar?.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]

        let referenceDate = NSDate(timeIntervalSinceReferenceDate: 0)
        let intervalDate = NSDate(timeInterval: self.interval, since: referenceDate as Date)
        return formatter.string(from: referenceDate as Date, to: intervalDate as Date)!
    }
}
