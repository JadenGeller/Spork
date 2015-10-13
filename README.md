# Spork
Swift generator type that allows duplication of generators while maintaining independent state

Normally, some generators work this way...
```swift
let generator = [1,2,3].generate()
let copy = generator
print(generator.next()) // -> 1
print(copy.next())      // -> 1
```

But other generators work like this...
```swift
let generator = anyGenerator([1,2,3].generate())
let copy = generator
print(generator.next()) // -> 1
print(copy.next())      // -> 2
```

That's to say, there's nothing that guarentees that your generator copy won't share its state with the original generator. Spork defines a protocol `ForkableGeneratorType` with a method `fork` that guarentees unique state among forked copies.
