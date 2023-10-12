import Foundation

@freestanding(expression)
public macro obfuscate<T: ExpressibleByArrayLiteral>(_ string: String) -> T = #externalMacro(module: "ObfuscatorMacros", type: "ObfuscateMacro")

@freestanding(expression)
public macro salt<T: ExpressibleByStringLiteral>() -> T = #externalMacro(module: "ObfuscatorMacros", type: "SaltGenerationMacro")


