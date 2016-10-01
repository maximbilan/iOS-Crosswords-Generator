//
//  ArrayShuffle.swift
//  crosswords_generator
//
//  Created by Maxim Bilan on 9/15/15.
//  Copyright © 2015 Maxim Bilan. All rights reserved.
//

import Foundation

extension MutableCollection where Indices.Iterator.Element == Index {
	
	/// Shuffles the contents of this collection.
	mutating func shuffle() {
		let c = count
		guard c > 1 else { return }
		
		for (unshuffledCount, firstUnshuffled) in zip(stride(from: c, to: 1, by: -1), indices) {
			let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
			guard d != 0 else { continue }
			let i = index(firstUnshuffled, offsetBy: d)
			swap(&self[firstUnshuffled], &self[i])
		}
	}
	
}

extension Sequence {
	
	/// Returns an array with the contents of this sequence, shuffled.
	func shuffled() -> [Iterator.Element] {
		var result = Array(self)
		result.shuffle()
		return result
	}
	
}
