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

		/* ----------------------------------------------------------------------
			Generate one crossword
		   ---------------------------------------------------------------------- */
		
		/*let crosswordsGenerator = CrosswordsGenerator(columns: 13, rows: 13, words: ["saffron", "pumpernickel", "leaven", "coda", "paladin", "syncopation", "albatross", "harp", "piston", "caramel", "coral", "dawn", "pitch", "fjord", "lip", "lime", "mist", "plague", "yarn", "snicker"])
		crosswordsGenerator.generate()
		
		_ = crosswordsGenerator.result*/
		
		/* ---------------------------------------------------------------------- */
	
		
		
		/* ----------------------------------------------------------------------
			Generate the best crossword in 10 attempts
		   ---------------------------------------------------------------------- */
		
		/*let crosswordsGenerator = CrosswordsGenerator()
		crosswordsGenerator.words = ["saffron", "pumpernickel", "leaven", "coda", "paladin", "syncopation", "albatross", "harp", "piston", "caramel", "coral", "dawn", "pitch", "fjord", "lip", "lime", "mist", "plague", "yarn", "snicker"]
		crosswordsGenerator.columns = 10
		crosswordsGenerator.rows = 10
	
		var bestResult: Array<CrosswordsGenerator.Word> = Array()
		let attempts = 10
		
		for var i: Int = 0; i < attempts; ++i {
			crosswordsGenerator.generate()
			let result = crosswordsGenerator.result
			
			if result.count > bestResult.count {
				bestResult.removeAll()
				for word in result {
					bestResult.append(word)
				}
			}
		}*/
		
		/* ---------------------------------------------------------------------- */
		
		
		
		/* ----------------------------------------------------------------------
			Generate the best crossword in 60 seconds
		   ---------------------------------------------------------------------- */
		
		/*let crosswordsGenerator = CrosswordsGenerator()
		crosswordsGenerator.words = ["saffron", "pumpernickel", "leaven", "coda", "paladin", "syncopation", "albatross", "harp", "piston", "caramel", "coral", "dawn", "pitch", "fjord", "lip", "lime", "mist", "plague", "yarn", "snicker"]
		crosswordsGenerator.columns = 10
		crosswordsGenerator.rows = 10
		crosswordsGenerator.debug = true
		crosswordsGenerator.emptySymbol = "*"
		
		var bestResult: Array<CrosswordsGenerator.Word> = Array()
		let startTime = NSDate()
		let timeInterval: NSTimeInterval = 3
		
		while (fabs(startTime.timeIntervalSinceNow) < timeInterval) {
			crosswordsGenerator.generate()
			let result = crosswordsGenerator.result
			
			if result.count > bestResult.count {
				bestResult.removeAll()
				for word in result {
					bestResult.append(word)
				}
			}
		}*/
		
		/* ---------------------------------------------------------------------- */
		
		/* ----------------------------------------------------------------------
			Generate one crossword with 'fill all words' mode
			---------------------------------------------------------------------- */
		
		/*let crosswordsGenerator = CrosswordsGenerator(columns: 15, rows: 15, words: ["beijing", "havana", "rome", "paris", "amsterdam"])
		crosswordsGenerator.fillAllWords = true
		crosswordsGenerator.generate()
		
		let result = crosswordsGenerator.result
		print(result)*/
		
		/* ---------------------------------------------------------------------- */
		
		/* ----------------------------------------------------------------------
			Other tests with 'fill all words' mode
		---------------------------------------------------------------------- */
		
		let crosswordsGenerator = CrosswordsGenerator()
		crosswordsGenerator.words = ["van", "bat", "fan", "jug", "mug"]
		//crosswordsGenerator.words = ["saffron", "pumpernickel", "leaven", "coda", "paladin", "syncopation", "albatross", "harp", "piston", "caramel", "coral", "dawn", "pitch", "fjord", "lip", "lime", "mist", "plague", "yarn", "snicker"]
		crosswordsGenerator.columns = 15
		crosswordsGenerator.rows = 15
		crosswordsGenerator.fillAllWords = true
		
		var bestResult: Array<CrosswordsGenerator.Word> = Array()
		let attempts = 1
		
		for var i: Int = 0; i < attempts; ++i {
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

