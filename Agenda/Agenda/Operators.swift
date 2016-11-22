//
//  Operators.swift
//  SwiftMoment
//
//  Created by Adrian on 19/01/15.
//  Copyright (c) 2015 Adrian Kosmaczewski. All rights reserved.
//

public func == (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.isEqualTo(moment: rhs)
}

public func != (lhs: Moment, rhs: Moment) -> Bool {
    return !lhs.isEqualTo(moment: rhs)
}

public func ~= (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.isCloseTo(moment: rhs)
}

public func - (lhs: Moment, rhs: Moment) -> Duration {
    return lhs.intervalSince(moment: rhs)
}

public func > (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(moment: rhs).interval > 0
}

public func < (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(moment: rhs).interval < 0
}

public func >= (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(moment: rhs).interval >= 0
}

public func <= (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(moment: rhs).interval <= 0
}

public func + (lhs: Moment, rhs: Duration) -> Moment {
    return lhs.add(duration: rhs)
}

public func + (lhs: Duration, rhs: Moment) -> Moment {
    return rhs.add(duration: lhs)
}

public func - (lhs: Moment, rhs: Duration) -> Moment {
    return lhs.subtract(duration: rhs)
}

public func - (lhs: Duration, rhs: Moment) -> Moment {
    return rhs.subtract(duration: lhs)
}

public func == (lhs: Duration, rhs: Duration) -> Bool {
    return lhs.isEqualTo(duration: rhs)
}

public func + (lhs: Duration, rhs: Duration) -> Duration {
    return lhs.add(duration: rhs)
}

public func - (lhs: Duration, rhs: Duration) -> Duration {
    return lhs.subtract(duration: rhs)
}
