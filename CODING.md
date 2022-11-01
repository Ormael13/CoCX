Coding style guideline
======================

Intro
-----
This guideline was created with the goal to keep the coding style consistent throughout the codebase. At its current state its **work in progress** and currently **nothing is to be considered final**.

**Important note:** Please avoid full file tidying as this creates a huge diff that may be a PITA to review. Especially not, when you're changing other things not related to code tidying and/or aren't 100% sure about what you're doing.

That said, let's start with the guideline.

Curly braces
------------
### Packages, classes and functions
Put the open curly brace into a new line:

```as3
package foo.bar.moo
{
	class FooBar extends Foo
	{
		public function foo(moo:int):void
		{
			// ...
		}

		public function bar():void
		{
			// ...
		}
	}
}
```

In addition to that use an empty line between function definitions like in the example above.

### Control structures (if/else if/else/while/for/switch/...)
Put the opening curly brace into **the same** line:

```as3
if (foobar === "moo") {
	expression;
	expression;
} else {
	expression;
	expression;
	expression;
	expression;
}

switch (foobar) {
	case "moo":
		//do this
		break;

	case "quack":
		//do that
		break;

	default:
		// do something else
}
```
If **both** the `if (expr)` and the `else`-branch contain a single expression you may omit the curly braces. But not, if at least one of them contains multiple expressions. The expressions should go into a new line. Not into the same line:

##### Do this
```as3

if (foo === "bar")
	outputText("foobar");
else
	outputText("moo");

if (foobar === "moo") {
	outputText("blah, blah");
} else {
	outputText("blah, blah");
	outputText("yadda, yadda");
}
```

##### But don't do this:
```as3
if (foo === "bar")
	outputText("foobar");
else outputText("moo");

if (foobar === "moo")
	outputText("blah, blah");
else {
	outputText("blah, blah");
	outputText("yadda, yadda");
}
```

**However:** If theres even the slightest possibility, that someone may add more expressions to it its recommended to add the curly braces anyway to avoid mistake like forgetting to add curly braces and to keep future diffs less noisy.

#### Good practice for the `else` in conditionals
Try keeping the `else`-part of a conditional as near as possible to the `if`

##### Avoid this:
```as3
if (foobar === "moo") {
	expression;
	expression;
	expression;
	expression;
	expression;
} else {
	expression;
}
```

##### Instead use this:
```as3
if (foobar !== "moo") {
	expression;
} else {
	expression;
	expression;
	expression;
	expression;
	expression;
}
```

As you can see there, I've changed the condition to the opposite. From `foobar === "moo"` to `foobar !== "moo"` in that case.

### Indenting and aligning code
Indent with single tabs (per indentation level) and align with spaces:
![Screenshot of aligned and indented code](https://user-images.githubusercontent.com/13157984/35690557-74b48ada-0776-11e8-860d-1e8a6787f7e6.png "Screenshot of aligned and indented code")

### Avoid extremely long lines of code
While mode IDEs and editors may have word wrapping, GitHub hasn't and not everyone likes word-wrapping. Look at the screenshot above how extremely long lines of code could be wrapped.
Many editors allow setting up a vertical line to assist you with that task. In FlashDevelop for example the settting for this is called 'Print Margin Column'. I have set mine to 150.

### Use of spaces
Operators should always be surrounded by spaces with the exception of `++` and `--`:

```as3
a = 1;
b += a;
c = a + b;
d = b + "something" + c;
e = d * b;
f = e / a;
g = (f + e) * b;
h++;
i--;
```

Function calls and definitions should not have a space before the opening parentheses:

```as3
outputText("blah, blah, yadda, yadda!");
player.arms.setType(Arms.SPIDER);
```

Function arguments should have a space after each comma:

```as3
player.skin.tone = randomChoice("red", "green", "blue");
```

Unnecessary spaces around parentheses **should not** be used.<br>
In other words: **Don't use:**

```as3
outputText( "blah, blah, yadda, yadda!" );
player.arms.setType( Arms.SPIDER );
```

Control structures, like if, else, switch and for should have a space before the opening parentheses.

```as3
for (var i = 0; i < 10; i++) {
	// do something
}

while (i < theArray.length) {
	// do something
}

if (condition !== "something") {
	// do something
} else {
	// do something
}
```

Curly braces (`{ }`) should be surrounded by a space as shown above.

### Commenting code
Use the `//` comment type for single-line or short comments, and the `/* .... */` syntax for large block comments.

```as3
// this is a single line comment

// this is a short comment that tells
// you something about the following code

/*
this is a long comment
and it
goes on
for several
lines...
*/
```

Comments should precede the code they describe, rather than following it.

Avoid this:

```as3
var itemCount:int = 0; // initialize itemCount

if (itemCount !== 0) // check itemCount
```

Instead use this:

```as3
// initialize itemCount
var itemCount:int = 0;

// check itemCount
if (itemCount !== 0)
```

When commenting loops and branches, it is acceptable to put the comment inside the braces.

```as3
if (text !== "") {
	// text is not empty so do the following code
	outputText(text);
}
```

Indent comments the same way as the code, that follows it:

Avoid this:

```as3
	if (text !== "") {
//		text is not empty so do the following code
		outputText(text);
	}
```

Instead use this:

```as3
	if (text !== "") {
		// text is not empty so do the following code
		outputText(text);
	}
```

### Naming conventions

| **What**                              | **Convention**                                                          | **Examples**                            |
|---------------------------------------|-------------------------------------------------------------------------|-----------------------------------------|
| class                                 | Use UpperCamelCase                                                      | `MinotaurScene`, `PlayerAppearance`     |
| interface                             | Use UpperCamelCase<br>**Note:** No `I` or `Interface` prefix or suffix! | `RandomNumberGenerator`, `Serializable` |
| function / method                     | Use lowerCamelCase                                                      | `setType`, `restoreLegs`                |
| variables (including class variables) | Use lowerCamelCase                                                      | `furColor`, `skinType`                  |
| constants                             | Use capital letters and words separated by underscores                  | `CAN_FLY_WINGS`, `RED_PANDA`            |
```

### Arrays and trailing commas
When adding elements to arrays where every array element is in it own line its common practice and recommended to add a trailing comma (`,`) to the new element, to reduce the noise of future diffs:
```as3
public static const DEFAULT_ARM_NAMES:Object = createMapFromPairs(
		[
			[Arms.HUMAN, "human"],
			[Arms.HARPY, "harpy"],
			[Arms.SPIDER, "spider"],
			[Arms.WOLF, "wolf"],
			[Arms.PREDATOR, "predator"],
			[Arms.SALAMANDER, "salamander"],
			[Arms.COCKATRICE, "cockatrice"],
			[Arms.RED_PANDA, "red-panda"],
			[Arms.OTTER, "otter"],
		]
);
```