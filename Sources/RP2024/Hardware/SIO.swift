//
//  SIO.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 4/10/24.
//

extension RP2040Hardware {
  public var sio: SIO {
    SIO(unsafeAddress: 0xd0000000)
  }

  public struct SIO {
    let unsafeAddress: UInt

    init(unsafeAddress: UInt) {
      self.unsafeAddress = unsafeAddress
    }

    public func setOutput(_ bits: UInt32) {
      RP2040Hardware.write(bits & 0x3FFFFFFF, to: unsafeAddress, offset: 0x0014)
    }

    public func clearOutput(_ bits: UInt32) {
      RP2040Hardware.write(bits & 0x3FFFFFFF, to: unsafeAddress, offset: 0x0018)
    }

    public func enableOutput(_ bits: UInt32) {
      RP2040Hardware.write(bits & 0x3FFFFFFF, to: unsafeAddress, offset: 0x0024)
    }

    public func disableOutput(_ bits: UInt32) {
      RP2040Hardware.write(bits & 0x3FFFFFFF, to: unsafeAddress, offset: 0x0028)
    }
  }
}
