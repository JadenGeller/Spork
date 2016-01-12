//
//  AnyForkableGenerator.swift
//  Spork
//
//  Created by Jaden Geller on 10/12/15.
//
//

public final class AnyForkableGenerator<Element> {
    private let _next: () -> Element?
    private let _fork: () -> AnyForkableGenerator
    
    internal init(next: () -> Element?, fork: () -> AnyForkableGenerator) {
        _next = next
        _fork = fork
    }
}

extension AnyForkableGenerator: ForkableGeneratorType {
    public func fork() -> AnyForkableGenerator<Element> {
        return _fork()
    }
    
    public func next() -> Element? {
        return _next()
    }
}

extension AnyForkableGenerator {
    public convenience init<G: ForkableGeneratorType where G.Element == Element>(_ base: G) {
        var base = base
        self.init(next: { base.next() }, fork: { AnyForkableGenerator(base.fork()) })
    }
    
    public convenience init<State>(_ state: State, duplicate: State -> State, next: inout State -> Element?) {
        var state = state
        self.init(next: { next(&state) }, fork: { AnyForkableGenerator(duplicate(state), duplicate: duplicate, next: next) })
    }
}