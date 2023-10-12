# Obfuscation Swift Macros

## Problem statement

Sometimes, you might need to add a secret inside your Swift project. Of course, this is not secure. Any secret should not stay inside your client-side build, even if obfuscated. However, some scenarios might require it.

Without Swift Macros it is hard to obfuscate those secrets.

## Solution
This library provides Swift Macros to help with:
1. Generating a random salt used for obfuscation, every time the project compiles (`#salt`)
2. Generating an obfuscated version of a string (`#obfuscate("YourSecretString")`)

It also provides a function that you can use at run time, for using the actual strings with the services that you need (`revealed(obfuscatedStringBytes, salt)`).

## Installation

Please use the Swift Package Manager to install this library and use the `Obfuscator` module inside your production code. You will need to allow using the package in your project before you're able to import and use it.

## Still, to be done
- Unit test the library properly

## Example use

```swift
import Obfuscator

// generated during compile time
let salt: String = #salt
let obfuscatedStringBytes: [UInt8] = #obfuscate("SecretString")

// revealed during run time
let secret = revealed(obfuscatedStringBytes, salt)
yourSecretRequiringService.use(secret)
```

## Macro expansions

### `#salt` 
Will expand to the same String througout your entire codebase, so you can use it in multiple places in the same project.

#### Examples

The following:

```swift
let salt: String = #salt
// ...
let anotherSaltInstance = #salt
```

will expand to something similar with the following code:

```swift
let salt: String = "lWDybHptk1dek40YhQSl0ZKdxPr7Wfsd"
// ...
let anotherSaltInstance: String = "lWDybHptk1dek40YhQSl0ZKdxPr7Wfsd"
```

### `#obfuscate` 

Will expand to a byte array.

#### Examples

```swift
let obfuscatedStringBytes: [UInt8] = #obfuscate("ABCD")
```

will expand to something similar with the following code:

```swift
let obfuscatedStringBytes: [UInt8] = [20, 39, 15, 1]
```
