//
//  Timer.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 4/10/24.
//

extension RP2040Hardware {
  public var timer: Timer {
    Timer(unsafeAddress: 0x40054000)
  }

  public struct Timer {
    let unsafeAddress: UInt

    init(unsafeAddress: UInt) {
      self.unsafeAddress = unsafeAddress
    }

    public var awh: UInt32 {
      RP2040Hardware.read(UInt32.self, from: unsafeAddress, offset: 0x0024)
    }

    public var awl: UInt32 {
      RP2040Hardware.read(UInt32.self, from: unsafeAddress, offset: 0x0028)
    }
  }
}
