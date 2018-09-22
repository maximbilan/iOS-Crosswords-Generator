# Crosswords Generator

[![Version](https://img.shields.io/cocoapods/v/CrosswordsGenerator.svg?style=flat)](http://cocoadocs.org/docsets/CrosswordsGenerator)
[![License](https://img.shields.io/cocoapods/l/CrosswordsGenerator.svg?style=flat)](http://cocoadocs.org/docsets/CrosswordsGenerator)
[![Platform](https://img.shields.io/cocoapods/p/CrosswordsGenerator.svg?style=flat)](http://cocoadocs.org/docsets/CrosswordsGenerator)
[![CocoaPods](https://img.shields.io/cocoapods/dt/CrosswordsGenerator.svg)](https://cocoapods.org/pods/CrosswordsGenerator)
[![CocoaPods](https://img.shields.io/cocoapods/dm/CrosswordsGenerator.svg)](https://cocoapods.org/pods/CrosswordsGenerator)

A simple algorithm for generating crosswords with <i>Swift</i>.<br>
Based on <a href="http://bryanhelmig.com/python-crossword-puzzle-generator/"> Python Crossword Puzzle Generator.</a>

# Installation

<b>CocoaPods:</b>

<pre>
pod 'CrosswordsGenerator'
</pre>

<b>Manual:</b>

<pre>
Copy <i>CrosswordsGenerator.swift</i>, <i>Array2D.swift</i>, <i>ArrayShuffle.swift</i> files to your project.
</pre>

# Using

Initialization and crosswords generation:

<pre>
let generator = CrosswordsGenerator(columns: 10, rows: 10, maxLoops: 2000, words: ["saffron", "pumpernickel", "leaven", "coda", "paladin", "syncopation", "albatross", "harp", "piston", "caramel", "coral", "dawn", "pitch", "fjord", "lip", "lime", "mist", "plague", "yarn", "snicker"])
generator.generate()
</pre>

To get result:

<pre>
let result = crosswordsGenerator.result
</pre>

The result is an array of structures:
<pre>
public struct Word {
	public var word = ""
	public var column = 0
	public var row = 0
	public var direction: WordDirection = .Vertical
}
</pre>

The sample of working:

<pre>
--- Words ---
["pumpernickel", "syncopation", "albatross", "saffron", "paladin",
"caramel", "snicker", "leaven", "piston", "plague", "coral", "pitch",
"fjord", "coda", "harp", "dawn", "lime", "mist", "yarn", "lip"]

--- Result ---
pumpernickel-
---a-------e-
---l-------a-
caramel-f--v-
o--d----j--e-
r--i----o--n-
a-snicker----
l----o--dawn-
-----d-------
----harp-----
-------------
-------------
-------------
</pre>

To generate the best crosswords in 10 attempts:

<pre>
let crosswordsGenerator = CrosswordsGenerator()
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
}
</pre>

To generate the best crosswords in 60 seconds:

<pre>
let crosswordsGenerator = CrosswordsGenerator()
crosswordsGenerator.words = ["saffron", "pumpernickel", "leaven", "coda", "paladin", "syncopation", "albatross", "harp", "piston", "caramel", "coral", "dawn", "pitch", "fjord", "lip", "lime", "mist", "plague", "yarn", "snicker"]
crosswordsGenerator.columns = 10
crosswordsGenerator.rows = 10
		
var bestResult: Array<CrosswordsGenerator.Word> = Array()
let startTime = NSDate()
let timeInterval: NSTimeInterval = 10
		
while (fabs(startTime.timeIntervalSinceNow) < timeInterval) {
	crosswordsGenerator.generate()
	let result = crosswordsGenerator.result
			
	if result.count > bestResult.count {
		bestResult.removeAll()
		for word in result {
			bestResult.append(word)
		}
	}
}
</pre>

Also we have option <i>fillAllWords</i>. After generation of crosswords you can fill words to grid in random places that have not intersections. For example:

<pre>
let crosswordsGenerator = CrosswordsGenerator(columns: 15, rows: 15, words: ["beijing", "havana", "rome", "paris", "amsterdam"])
crosswordsGenerator.fillAllWords = true
crosswordsGenerator.generate()

amsterdam-b-h--
-----o----e-a--
-----m----i-v--
-----e----j-a--
paris-----i-n--
----------n-a--
----------g----
---------------
---------------
</pre>

In this repository you can find sample of working of this algorithm. Feel free. Happy coding! 
