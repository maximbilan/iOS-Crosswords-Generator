//
//  CrosswordsGenerator.swift
//  crosswords_generator
//
//  Created by Maxim Bilan on 9/11/15.
//  Copyright © 2015 Maxim Bilan. All rights reserved.
//

import UIKit

open class CrosswordsGenerator {

	// MARK: - Additional types
	
	public struct Word {
		public var word = ""
		public var column = 0
		public var row = 0
		public var direction: WordDirection = .vertical
	}
	
	public enum WordDirection {
		case vertical
		case horizontal
	}
	
	// MARK: - Public properties
	
	open var columns: Int = 0
	open var rows: Int = 0
	open var maxLoops: Int = 2000
	open var words: Array<String> = Array()
	
	open var result: Array<Word> {
		get {
			return resultData
		}
	}
	
	// MARK: - Public additional properties
	
	open var fillAllWords = false
	open var emptySymbol = "-"
	open var debug = true
	open var orientationOptimization = false
	
	// MARK: - Logic properties
	
	fileprivate var grid: Array2D<String>?
	fileprivate var currentWords: Array<String> = Array()
	fileprivate var resultData: Array<Word> = Array()
	
	// MARK: - Initialization
	
	public init() {
	}
	
	public init(columns: Int, rows: Int, maxLoops: Int = 2000, words: Array<String>) {
		self.columns = columns
		self.rows = rows
		self.maxLoops = maxLoops
		self.words = words
	}
	
	// MARK: - Crosswords generation
	
	open func generate() {
		
		self.grid = nil
		self.grid = Array2D(columns: columns, rows: rows, defaultValue: emptySymbol)
		
		currentWords.removeAll()
		resultData.removeAll()
		
		words.sort(by: {$0.lengthOfBytes(using: String.Encoding.utf8) > $1.lengthOfBytes(using: String.Encoding.utf8)})
		
		if debug {
			print("--- Words ---")
			print(words)
		}
		
		for word in words {
			if !currentWords.contains(word) {
				_ = fitAndAdd(word)
			}
		}
		
		if debug {
			print("--- Result ---")
			printGrid()
		}
		
		if fillAllWords {
			
			var remainingWords = Array<String>()
			for word in words {
				if !currentWords.contains(word) {
					remainingWords.append(word)
				}
			}
			
			var moreLikely = Set<String>()
			var lessLikely = Set<String>()
			for word in remainingWords {
				var hasSameLetters = false
				for comparingWord in remainingWords {
					if word != comparingWord {
						let letters = CharacterSet(charactersIn: comparingWord)
						let range = word.rangeOfCharacter(from: letters)
						
						if let _ = range {
							hasSameLetters = true
							break
						}
					}
				}
				
				if hasSameLetters {
					moreLikely.insert(word)
				}
				else {
					lessLikely.insert(word)
				}
			}
			
			remainingWords.removeAll()
			remainingWords.append(contentsOf: moreLikely)
			remainingWords.append(contentsOf: lessLikely)
			
			for word in remainingWords {
				if !fitAndAdd(word) {
					fitInRandomPlace(word)
				}
			}
			
			if debug {
				print("--- Fill All Words ---")
				printGrid()
			}
		}
	}
	
	fileprivate func suggestCoord(_ word: String) -> Array<(Int, Int, Int, Int, Int)> {
		
		var coordlist = Array<(Int, Int, Int, Int, Int)>()
		var glc = -1
		
		for letter in word.characters {
			glc += 1
			var rowc = 0
			for row: Int in 0 ..< rows {
				rowc += 1
				var colc = 0
				for column: Int in 0 ..< columns {
					colc += 1
					
					let cell = grid![row, column]
					if String(letter) == cell {
						if rowc - glc > 0 {
							if ((rowc - glc) + word.lengthOfBytes(using: String.Encoding.utf8)) <= rows {
								coordlist.append((colc, rowc - glc, 1, colc + (rowc - glc), 0))
							}
						}
						
						if colc - glc > 0 {
							if ((colc - glc) + word.lengthOfBytes(using: String.Encoding.utf8)) <= columns {
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
	
	fileprivate func sortCoordlist(_ coordlist: Array<(Int, Int, Int, Int, Int)>, word: String) -> Array<(Int, Int, Int, Int, Int)> {
		
		var newCoordlist = Array<(Int, Int, Int, Int, Int)>()
		
		for var coord in coordlist {
			let column = coord.0
			let row = coord.1
			let direction = coord.2
			coord.4 = checkFitScore(column, row: row, direction: direction, word: word)
			if coord.4 > 0 {
				newCoordlist.append(coord)
			}
		}
		
		newCoordlist.shuffle()
		newCoordlist.sort(by: {$0.4 > $1.4})
		
		return newCoordlist
	}
	
	fileprivate func fitAndAdd(_ word: String) -> Bool {
		
		var fit = false
		var count = 0
		var coordlist = suggestCoord(word)
		
		while !fit && count < maxLoops {
			
			if currentWords.count == 0 {
				let direction = randomValue()
				
				// +1 offset for the first word, so more likely intersections for short words
				let column = 1 + 1
				let row = 1 + 1

				if checkFitScore(column, row: row, direction: direction, word: word) > 0 {
					fit = true
					setWord(column, row: row, direction: direction, word: word, force: true)
				}
			}
			else {
				if count >= 0 && count < coordlist.count {
					let column = coordlist[count].0
					let row = coordlist[count].1
					let direction = coordlist[count].2

					if coordlist[count].4 > 0 {
						fit = true
						setWord(column, row: row, direction: direction, word: word, force: true)
					}
				}
				else {
					return false
				}
			}
			
			count += 1
		}
		
		return true
	}
	
	fileprivate func fitInRandomPlace(_ word: String) {
		
		let value = randomValue()
		let directions = [value, value == 0 ? 1 : 0]
		var bestScore = 0
		var bestColumn = 0
		var bestRow = 0
		var bestDirection = 0
		
		for direction in directions {
			for i: Int in 1 ..< rows - 1 {
				for j: Int in 1 ..< columns - 1 {
					if grid![i, j] == emptySymbol {
						let c = j + 1
						let r = i + 1
						let score = checkFitScore(c, row: r, direction: direction, word: word)
						if score > bestScore {
							bestScore = score
							bestColumn = c
							bestRow = r
							bestDirection = direction
						}
					}
				}
			}
		}
		
		if bestScore > 0 {
			setWord(bestColumn, row: bestRow, direction: bestDirection, word: word, force: true)
		}
	}
	
	fileprivate func checkFitScore(_ column: Int, row: Int, direction: Int, word: String) -> Int {
		
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
				
				if direction == 0 {
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
					
					if count == word.lengthOfBytes(using: String.Encoding.utf8) {
						if !checkIfCellClear(c + 1, row: row) {
							return 0
						}
					}
				}
				else {
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
					
					if count == word.lengthOfBytes(using: String.Encoding.utf8) {
						if !checkIfCellClear(c, row: r + 1) {
							return 0
						}
					}
				}
				
				if direction == 0 {
					c += 1
				}
				else {
					r += 1
				}

				if (c >= columns || r >= rows) {
					return 0
				}
				
				count += 1
			}
			else {
				return 0
			}
		}
		
		return score
	}
	
	func setCell(_ column: Int, row: Int, value: String) {
		grid![row - 1, column - 1] = value
	}
 
	func getCell(_ column: Int, row: Int) -> String{
		return grid![row - 1, column - 1]
	}
	
	func checkIfCellClear(_ column: Int, row: Int) -> Bool {
		if column > 0 && row > 0 && column < columns && row < rows {
			return getCell(column, row: row) == emptySymbol ? true : false
		}
		else {
			return true
		}
	}
	
	fileprivate func setWord(_ column: Int, row: Int, direction: Int, word: String, force: Bool = false) {
		
		if force {
			let w = Word(word: word, column: column, row: row, direction: (direction == 0 ? .horizontal : .vertical))
			resultData.append(w)
			
			currentWords.append(word)
			
			var c = column
			var r = row
			
			for letter in word.characters {
				setCell(c, row: r, value: String(letter))
				if direction == 0 {
					c += 1
				}
				else {
					r += 1
				}
			}
		}
	}
	
	// MARK: - Public info methods
	
	open func maxColumn() -> Int {
		var column = 0
		for i in 0 ..< rows {
			for j in 0 ..< columns {
				if grid![i, j] != emptySymbol {
					if j > column {
						column = j
					}
				}
			}
		}
		return column + 1
	}
	
	open func maxRow() -> Int {
		var row = 0
		for i in 0 ..< rows {
			for j in 0 ..< columns {
				if grid![i, j] != emptySymbol {
					if i > row {
						row = i
					}
				}
			}
		}
		return row + 1
	}
	
	open func lettersCount() -> Int {
		var count = 0
		for i in 0 ..< rows {
			for j in 0 ..< columns {
				if grid![i, j] != emptySymbol {
					count += 1
				}
			}
		}
		return count
	}
	
	// MARK: - Misc
	
	fileprivate func randomValue() -> Int {
		if orientationOptimization {
			return UIDevice.current.orientation.isLandscape ? 1 : 0
		}
		else {
			return randomInt(0, max: 1)
		}
	}
	
	fileprivate func randomInt(_ min: Int, max:Int) -> Int {
		return min + Int(arc4random_uniform(UInt32(max - min + 1)))
	}
	
	// MARK: - Debug
	
	func printGrid() {
		for i in 0 ..< rows {
			var s = ""
			for j in 0 ..< columns {
				s += grid![i, j]
			}
			print(s)
		}
	}
	
}
