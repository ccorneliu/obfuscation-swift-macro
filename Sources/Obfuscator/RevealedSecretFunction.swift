import Foundation

public func revealed(_ obfuscatedSecret: [UInt8], _ salt: String) -> String {
    let cipher = [UInt8](salt.utf8)
    let length = cipher.count

    var revealedStringBytes = [UInt8]()

    for byte in obfuscatedSecret.enumerated() {
        revealedStringBytes.append(byte.element ^ cipher[byte.offset % length])
    }

    return String(bytes: revealedStringBytes, encoding: .utf8)!
}
