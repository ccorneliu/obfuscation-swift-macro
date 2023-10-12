import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct ObfuscateMacro: ExpressionMacro {
    
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let stringToObfuscateExpression = node.argumentList.first?.expression,
              let stringToObfuscateExpressionSegments = stringToObfuscateExpression.as(StringLiteralExprSyntax.self)?.segments,
              stringToObfuscateExpressionSegments.count == 1,
              case .stringSegment(let literalStringToObfuscateSegment)? = stringToObfuscateExpressionSegments.first else {
            throw ObfuscationError.staticStringNotProvided
        }
        let stringToObfuscate = literalStringToObfuscateSegment.content.text
        let obfuscatedStringBytes = obfuscatedBytes(of: stringToObfuscate, salt: randomSalt)
        return "\(raw: obfuscatedStringBytes)"
    }
}

private func obfuscatedBytes(of string: String, salt: String) -> [UInt8] {
    let stringToObfuscateBytes = [UInt8](string.utf8)
    let saltBytes = [UInt8](salt.utf8)
    let saltNumberOfBytes = saltBytes.count

    var obfuscatedStringBytes: [UInt8] = []

    for byteToObfuscate in stringToObfuscateBytes.enumerated() {
        let saltByte = saltBytes[byteToObfuscate.offset % saltNumberOfBytes]
        let obfuscatedByte = byteToObfuscate.element ^ saltByte
        obfuscatedStringBytes.append(obfuscatedByte)
    }
    return obfuscatedStringBytes
}
