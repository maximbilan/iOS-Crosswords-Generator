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
		var count = 0
		var coorlist = Array<Int>(arrayLiteral: 4)
		return Array<Array<Int>>()
	}
	
	func sortCoorlist(coordlist: Array<Array<Int>>, word: String) {
		
	}
	
	func fitAndAdd(word: String) {
		var fit = false
		var count = 0
	}
	
	func checkFitScore(col: Int, row: Int, vertical: Int, word: String) {
		
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