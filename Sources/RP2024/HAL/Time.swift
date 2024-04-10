//
//  Time.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 4/10/24.
//

import Support

extension RP2040 {
  var now: UInt64 {
    var high = hardware.timer.awh
    var low: UInt32
    repeat {
      low = hardware.timer.awl
      let nextHigh = hardware.timer.awh
      if high == nextHigh {
        break
      }
      high = nextHigh
    } while true
    return UInt64(high) << 32 | UInt64(low)
  }

  public func sleep(forMicroseconds microseconds: UInt64) {
    let start = now
    let deadline = start + microseconds

    let highDeadline = UInt32(deadline >> 32)
    let lowDeadline = UInt32(deadline & UInt64(UInt32.max))
    var high = hardware.timer.awh

    while high < highDeadline {
      high = hardware.timer.awh
    }

    while high == highDeadline && hardware.timer.awl < lowDeadline {
      high = hardware.timer.awh
    }
  }

  public func sleep(forMilliseconds milliseconds: Int) {
    for _ in 0 ..< milliseconds * 1000 {
      nop()
    }
  }

  public func sleep(for duration: Duration) {
    let (seconds, attoseconds) = duration.components
    let microseconds = attoseconds / 1000000000000 + seconds * 1000000
    if microseconds > 0 {
      sleep(forMicroseconds: UInt64(microseconds))
    }
  }
}
