//
//  ViewController.swift
//  crosswords_generator
//
//  Created by Maxim Bilan on 9/11/15.
//  Copyright © 2015 Maxim Bilan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		/* ----------
			Generate one crossword
		   ----------
		let crosswordsGenerator = CrosswordsGenerator(columns: 13, rows: 13, words: ["saffron", "pumpernickel", "leaven", "coda", "paladin", "syncopation", "albatross", "harp", "piston", "caramel", "coral", "dawn", "pitch", "fjord", "lip", "lime", "mist", "plague", "yarn", "snicker"])
		crosswordsGenerator.generate()
		
		_ = crosswordsGenerator.result
		*/
	
		/* ----------
			Generate best crossword in 10 attempts
		   ----------
		*/
		let crosswordsGenerator = CrosswordsGenerator()
		crosswordsGenerator.words = ["saffron", "pumpernickel", "leaven", "coda", "paladin", "syncopation", "albatross", "harp", "piston", "caramel", "coral", "dawn", "pitch", "fjord", "lip", "lime", "mist", "plague", "yarn", "snicker"]
		crosswordsGenerator.columns = 13
		crosswordsGenerator.rows = 13
	
		var bestResult: Array<CrosswordsGenerator.Word> = Array()
		
		for var i: Int = 0; i < 10; ++i {
			crosswordsGenerator.generate()
			let result = crosswordsGenerator.result
			
			if result.count > bestResult.count {
				bestResult.removeAll()
				for word in result {
					bestResult.append(word)
				}
			}
		}
		
	}

}

