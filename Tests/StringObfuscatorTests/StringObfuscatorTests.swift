import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(ObfuscatorMacros)
import ObfuscatorMacros

let testMacros: [String: Macro.Type] = [
    "obfuscate": ObfuscateMacro.self,
]
#endif

final class ObfuscatorTests: XCTestCase {
    
    func testMacro() throws {
        #if canImport(ObfuscatorMacros)
        assertMacroExpansion(
            """
            #obfuscate("abc")
            """,
            expandedSource: """
            [53, 7, 16]
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

//    func testMacroWithStringLiteral() throws {
//        #if canImport(ObfuscatorMacros)
//        assertMacroExpansion(
//            #"""
//            #stringify("Hello, \(name)")
//            """#,
//            expandedSource: #"""
//            ("Hello, \(name)", #""Hello, \(name)""#)
//            """#,
//            macros: testMacros
//        )
//        #else
//        throw XCTSkip("macros are only supported when running tests for the host platform")
//        #endif
//    }
}
