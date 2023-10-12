import Obfuscator

let salt: String = #salt
let obfuscatedSecret: [UInt8] = #obfuscate("aStringToObfuscate")
let revealedSecret: String = revealed(obfuscatedSecret, salt)

print("The salt: \(salt)")
print("The obfuscated string: \(obfuscatedSecret)")
print("The revealed string: \(revealedSecret)")
