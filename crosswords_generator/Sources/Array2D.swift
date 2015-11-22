//
//  Array2D.swift
//  crosswords_generator
//
//  Created by Maxim Bilan on 9/15/15.
//  Copyright © 2015 Maxim Bilan. All rights reserved.
//

import Foundation

public class Array2D<T> {
	
	public var columns: Int
	public var rows: Int
	public var matrix: [T]
	
	public init(columns: Int, rows: Int, defaultValue: T) {
		self.columns = columns
		self.rows = rows
		matrix = Array(count: columns * rows, repeatedValue: defaultValue)
	}
	
	public subscript(column: Int, row: Int) -> T {
		get {
			return matrix[columns * row + column]
		}
		set {
			matrix[columns * row + column] = newValue
		}
	}
	
	public func columnCount() -> Int {
		return self.columns
	}
	
	public func rowCount() -> Int {
		return self.rows
	}
}