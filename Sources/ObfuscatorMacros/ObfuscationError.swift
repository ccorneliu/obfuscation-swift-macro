import Foundation

public enum ObfuscationError: Error {
    case staticStringNotProvided
    case staticSaltNotProvided
}
