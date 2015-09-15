//
//  CrosswordsGenerator.swift
//  crosswords_generator
//
//  Created by Maxim Bilan on 9/11/15.
//  Copyright © 2015 Maxim Bilan. All rights reserved.
//

import Foundation

class CrosswordsGenerator {

	var columns: Int = 0
	var rows: Int = 0
	var grid: Array2D<String>?
	
	var availableWords: Array<String> = Array()
	var currentWordList: Array<String> = Array()
	
	init() {
	}
	
	init(columns: Int, rows: Int, maxLoops: Int = 2000, words: Array<String>) {
		self.columns = columns
		self.rows = rows
		self.availableWords = words
		self.grid = Array2D(columns: columns, rows: rows, defaultValue: "-")
	}
	
	func generate() {
		
		var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
		array.shuffleInPlace()
		print(array)
		
		//print(availableWords)
		
		availableWords.sortInPlace({$0.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > $1.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)})
		
		//print("---")
		//print(availableWords)
		
		for word in availableWords {
			if !currentWordList.contains(word) {
				
			}
		}
	}
	
	func suggestCoord(word: String) -> Array<Array<Int>> {
		
		var coordlist = Array<Array<Int>>()
		var glc = -1
		
		for letter in word.characters {
			glc += 1
			var rowc = 0
			for (var row: Int = 0; row < self.rows; ++row) {
				rowc += 1
				var colc = 0
				for (var column: Int = 0; column < self.columns; ++column) {
					colc += 1
					
					let cell = self.grid![row, column]
					if String(letter) == cell {
						if rowc - glc > 0 {
							if ((rowc - glc) + word.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)) <= self.rows {
								coordlist.append([colc, rowc - glc, 1, colc + (rowc - glc), 0])
							}
						}
						
						if colc - glc > 0 {
							if ((colc - glc) + word.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)) <= self.columns {
								coordlist.append([colc - glc, rowc, 0, rowc + (colc - glc), 0])
							}
						}
					}
				}
			}
			
		}
		
		let nCoordlist = sortCoordlist(coordlist, word: word)
		
		return nCoordlist
	}
	
//	new_coordlist = []
//	for coord in coordlist:
//	col, row, vertical = coord[0], coord[1], coord[2]
//	coord[4] = self.check_fit_score(col, row, vertical, word) # checking scores
//	if coord[4]: # 0 scores are filtered
//	new_coordlist.append(coord)
//	random.shuffle(new_coordlist) # randomize coord list; why not?
//	new_coordlist.sort(key=lambda i: i[4], reverse=True) # put the best scores first
//	return new_coordlist
	
	func sortCoordlist(coordlist: Array<Array<Int>>, word: String) -> Array<Array<Int>> {
		
		var nCoordlist = Array<Array<Int>>()
		
		for var coord in coordlist {
			let col = coord[0]
			let row = coord[1]
			let vertical = coord[2]
			coord[4] = checkFitScore(col, row: row, vertical: vertical, word: word)
			if coord[4] > 0 {
				nCoordlist.append(coord)
			}
		}
		
		
		
		return nCoordlist
	}
	
	func fitAndAdd(word: String) {
		var fit = false
		var count = 0
	}
	
	func checkFitScore(col: Int, row: Int, vertical: Int, word: String) -> Int {
		return 0
	}
	
	func setWord(col: Int, row: Int, vertical: Int, word: String, force: Bool = false) {
		
	}
	
	func setCell(col: Int, row: Int, value: String) {
		
	}
 
	func getCell(col: Int, row: Int) {
		
	}
	
	func checkIfCellClear(col: Int, row: Int) -> Bool {
		return false
	}
	
}