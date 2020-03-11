//
//  DelayScheduler.swift
//

import Foundation

final class DelayScheduler {

    enum Delay {
        static let `default`: TimeInterval = 0.5
    }

    private let delay: TimeInterval
    private var item: DispatchWorkItem?
    
    init(delay: TimeInterval = Delay.default) {
        self.delay = delay
    }

    func schedule(block: @escaping () -> Void) {
        self.item?.cancel()
        
        let item = DispatchWorkItem(block: block)
        self.item = item
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: item)
    }

}
