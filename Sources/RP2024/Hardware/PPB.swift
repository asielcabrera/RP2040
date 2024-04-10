//
//  PPB.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 4/10/24.
//

extension RP2040Hardware {
  public var ppb: PPB {
    PPB(unsafeAddress: 0xe0000000)
  }

  public struct PPB {
    let unsafeAddress: UInt

    init(unsafeAddress: UInt) {
      self.unsafeAddress = unsafeAddress
    }

    public var cpuID: CPUID {
      CPUID(unsafeAddress: unsafeAddress + 0xed00)
    }

    public struct CPUID {
      let unsafeAddress: UInt

      init(unsafeAddress: UInt) {
        self.unsafeAddress = unsafeAddress
      }
    }

    public var icsr: ICSR {
      ICSR(unsafeAddress: unsafeAddress + 0xed04)
    }

    public struct ICSR {
      let unsafeAddress: UInt

      init(unsafeAddress: UInt) {
        self.unsafeAddress = unsafeAddress
      }
    }

    public var vtor: VTOR {
      VTOR(unsafeAddress: unsafeAddress + 0xed08)
    }

    public struct VTOR {
      let unsafeAddress: UInt

      init(unsafeAddress: UInt) {
        self.unsafeAddress = unsafeAddress
      }

      public var tableOffset: UInt32 {
        get {
          RP2040Hardware.read(UInt32.self, from: unsafeAddress)
        }
        nonmutating set {
          RP2040Hardware.write(newValue & 0xffffff00, to: unsafeAddress)
        }
      }
    }
  }
}

