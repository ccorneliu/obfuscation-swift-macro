import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct ObfuscatorPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ObfuscateMacro.self,
        SaltGenerationMacro.self
    ]
}
