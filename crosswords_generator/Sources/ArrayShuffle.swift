//
//  ArrayShuffle.swift
//  crosswords_generator
//
//  Created by Maxim Bilan on 9/15/15.
//  Copyright © 2015 Maxim Bilan. All rights reserved.
//

import Foundation

extension MutableCollection {
	
	/// Shuffles the contents of this collection.
	mutating func shuffle() {
		let c = count
		guard c > 1 else { return }
		
		for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
			let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
			let i = index(firstUnshuffled, offsetBy: d)
			swapAt(firstUnshuffled, i)
		}
	}
	
}

extension Sequence {
	
	/// Returns an array with the contents of this sequence, shuffled.
	func shuffled() -> [Element] {
		var result = Array(self)
		result.shuffle()
		return result
	}
	
}
