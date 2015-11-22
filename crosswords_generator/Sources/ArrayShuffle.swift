//
//  ArrayShuffle.swift
//  crosswords_generator
//
//  Created by Maxim Bilan on 9/15/15.
//  Copyright © 2015 Maxim Bilan. All rights reserved.
//

import Foundation

public extension CollectionType where Index == Int {
	public func shuffle() -> [Generator.Element] {
		var list = Array(self)
		list.shuffleInPlace()
		return list
	}
}

public extension MutableCollectionType where Index == Int {
	public mutating func shuffleInPlace() {
		if count < 2 {
			return
		}
		
		for i in 0..<count - 1 {
			let j = Int(arc4random_uniform(UInt32(count - i))) + i
			guard i != j else { continue }
			swap(&self[i], &self[j])
		}
	}
}