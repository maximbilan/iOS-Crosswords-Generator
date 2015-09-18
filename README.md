# Crosswords Generator

Simple algorithm for generating crosswords written on Swift. Based on <a href="http://bryanhelmig.com/python-crossword-puzzle-generator/"> Python Crossword Puzzle Generator.</a>

Using:

<pre>
let generator = CrosswordsGenerator(columns: 10, rows: 10, maxLoops: 2000, words: ["saffron", "pumpernickel", "leaven", "coda", "paladin", "syncopation", "albatross", "harp", "piston", "caramel", "coral", "dawn", "pitch", "fjord", "lip", "lime", "mist", "plague", "yarn", "snicker"])
generator.generate()
</pre>

To get result:

<pre>
let result = crosswordsGenerator.result
</pre>

Array of structures:
<pre>
public struct Word {
	var word = ""
	var column = 0
	var row = 0
	var direction: WordDirection = .Vertical
}
</pre>
