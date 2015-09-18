//
//  CrosswordsGenerator.swift
//  crosswords_generator
//
//  Created by Maxim Bilan on 9/11/15.
//  Copyright © 2015 Maxim Bilan. All rights reserved.
//

import Foundation

public class CrosswordsGenerator {

	private var columns: Int = 0
	private var rows: Int = 0
	private var maxLoops: Int = 0
	private var grid: Array2D<String>?
	private var words: Array<String> = Array()
	private var currentWords: Array<String> = Array()
	
	private let emptySymbol = "-"
	private let debug = true
	
	public struct Word {
		var word = ""
		var column = 0
		var row = 0
		var vertical = 0
	}
	
	public enum WordDirection {
		case Vertical
		case Horizontal
	}
	
	// MARK: - Initialization
	
	public init(columns: Int, rows: Int, maxLoops: Int = 2000, words: Array<String>) {
		self.columns = columns
		self.rows = rows
		self.maxLoops = maxLoops
		self.words = words
		self.grid = Array2D(columns: columns, rows: rows, defaultValue: emptySymbol)
	}
	
	// MARK: - Crosswords generation
	
	public func generate() {
		
		words.sortInPlace({$0.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > $1.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)})
		
		if debug {
			print("--- Words ---")
			print(words)
		}
		
		for word in words {
			if !currentWords.contains(word) {
				fitAndAdd(word)
			}
		}
		
		if debug {
			print("--- Result ---")
			printGrid()
		}
	}
	
	private func suggestCoord(word: String) -> Array<(Int, Int, Int, Int, Int)> {
		
		var coordlist = Array<(Int, Int, Int, Int, Int)>()
		var glc = -1
		
		for letter in word.characters {
			glc += 1
			var rowc = 0
			for (var row: Int = 0; row < rows; ++row) {
				rowc += 1
				var colc = 0
				for (var column: Int = 0; column < columns; ++column) {
					colc += 1
					
					let cell = grid![row, column]
					if String(letter) == cell {
						if rowc - glc > 0 {
							if ((rowc - glc) + word.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)) <= rows {
								coordlist.append((colc, rowc - glc, 1, colc + (rowc - glc), 0))
							}
						}
						
						if colc - glc > 0 {
							if ((colc - glc) + word.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)) <= columns {
								coordlist.append((colc - glc, rowc, 0, rowc + (colc - glc), 0))
							}
						}
					}
				}
			}
		}
		
		let newCoordlist = sortCoordlist(coordlist, word: word)
		return newCoordlist
	}
	
	private func sortCoordlist(coordlist: Array<(Int, Int, Int, Int, Int)>, word: String) -> Array<(Int, Int, Int, Int, Int)> {
		
		var newCoordlist = Array<(Int, Int, Int, Int, Int)>()
		
		for var coord in coordlist {
			let column = coord.0
			let row = coord.1
			let vertical = coord.2
			coord.4 = checkFitScore(column, row: row, vertical: vertical, word: word)
			if coord.4 > 0 {
				newCoordlist.append(coord)
			}
		}
		
		newCoordlist.shuffleInPlace()
		newCoordlist.sortInPlace({$0.4 > $1.4})
		
		return newCoordlist
	}
	
	private func fitAndAdd(word: String) {
		
		var fit = false
		var count = 0
		var coordlist = suggestCoord(word)
		
		while !fit && count < maxLoops {
			
			if currentWords.count == 0 {
				let vertical = randomInt(0, max: 1)
				let column = 1
				let row = 1

				if checkFitScore(column, row: row, vertical: vertical, word: word) > 0 {
					fit = true
					setWord(column, row: row, vertical: vertical, word: word, force: true)
				}
			}
			else {
				if count >= 0 && count < coordlist.count {
					let column = coordlist[count].0
					let row = coordlist[count].1
					let vertical = coordlist[count].2

					if coordlist[count].4 > 0 {
						fit = true
						setWord(column, row: row, vertical: vertical, word: word, force: true)
					}
				}
				else {
					return
				}
			}
			
			count += 1
		}
	}
	
	private func checkFitScore(column: Int, row: Int, vertical: Int, word: String) -> Int {
		
		var c = column
		var r = row
		
		if c < 1 || r < 1 || c >= columns || r >= rows {
			return 0
		}
		
		var count = 1
		var score = 1
		
		for letter in word.characters {
			let activeCell = getCell(c, row: r)
			if activeCell == emptySymbol || activeCell == String(letter) {
				
				if activeCell == String(letter) {
					score += 1
				}
				
				if vertical != 0 {
					if activeCell != String(letter) {
						if !checkIfCellClear(c + 1, row: r) {
							return 0
						}
						
						if !checkIfCellClear(c - 1, row: r) {
							return 0
						}
					}
					
					if count == 1 {
						if !checkIfCellClear(c, row: r - 1) {
							return 0
						}
					}
					
					if count == word.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) {
						if !checkIfCellClear(c, row: r + 1) {
							return 0
						}
					}
				}
				else {
					if activeCell != String(letter) {
						if !checkIfCellClear(c, row: r - 1) {
							return 0
						}
						
						if !checkIfCellClear(c, row: r + 1) {
							return 0
						}
					}
					
					if count == 1 {
						if !checkIfCellClear(c - 1, row: r) {
							return 0
						}
					}
					
					if count == word.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) {
						if !checkIfCellClear(c + 1, row: row) {
							return 0
						}
					}
				}
				
				if vertical != 0 {
					r += 1
				}
				else {
					c += 1
				}

				count += 1
			}
			else {
				return 0
			}
		}
		
		return score
	}
	
	func setCell(column: Int, row: Int, value: String) {
		grid![row - 1, column - 1] = value
	}
 
	func getCell(column: Int, row: Int) -> String{
		return grid![row - 1, column - 1]
	}
	
	func checkIfCellClear(column: Int, row: Int) -> Bool {
		if column > 0 && row > 0 && column < columns && row < rows {
			return getCell(column, row: row) == emptySymbol ? true : false
		}
		else {
			return true
		}
	}
	
	private func setWord(column: Int, row: Int, vertical: Int, word: String, force: Bool = false) {
		
		var c = column
		var r = row
		
		if force {
			//let word = Word(word: word, col: col, row: row, vertical: vertical)
			currentWords.append(word)
			
			for letter in word.characters {
				setCell(c, row: r, value: String(letter))
				if vertical != 0 {
					r += 1
				}
				else {
					c += 1
				}
			}
		}
	}
	
	// MARK: - Misc
	
	private func randomInt(min: Int, max:Int) -> Int {
		return min + Int(arc4random_uniform(UInt32(max - min + 1)))
	}
	
	// MARK: - Debug
	
	func printGrid() {
		for (var i = 0; i < rows; ++i) {
			var s = ""
			for (var j = 0; j < columns; ++j) {
				s += grid![i, j]
			}
			print(s)
		}
	}
	
}