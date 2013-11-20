
/*
Parser Syntax:

// Querying simple PC stat nouns:
	[noun]

Conditional statements:
// Simple if statement:
	[if (condition) OUTPUT_IF_TRUE]
// If-Else statement
	[if (condition) OUTPUT_IF_TRUE | OUTPUT_IF_FALSE]
	// Note - Implicit else indicated by presence of the "|"

// Object aspect descriptions
	[object aspect]
	// gets the description of aspect "aspect" of object/NPC/PC "object"
	// Eventually, I want this to be able to use introspection to access class attributes directly
	// Maybe even manipulate them, though I haven't thought that out much at the moment.

// Gender Pronoun Weirdness:
// PRONOUNS: The parser uses Elverson/Spivak Pronouns specifically to allow characters to be written with non-specific genders.
// http://en.wikipedia.org/wiki/Spivak_pronoun
//
// Cheat Table:
//           | Subject    | Object       | Possessive Adjective | Possessive Pronoun | Reflexive         |
// Agendered | ey laughs  | I hugged em  | eir heart warmed     | that is eirs       | ey loves emself   |
// Masculine | he laughs  | I hugged him | his heart warmed     | that is his        | he loves himself  |
// Feminine  | she laughs | I hugged her | her heart warmed     | that is hers       | she loves herself |



Planned, but not implemented yet:

	[screen (SCREEN_NAME) | screen text]
	// creates a new screen/page.

	[button (SCREEN_NAME)| button_text]
	// Creates a button which jumps to SCREEN_NAME when clicked

*/

// horrible, messy hack
// thisParserState is used to store the parser state.
// it is cleared every time recursiveParser is called.
// eventually, it should be properly refactored into this.parserState, but the parser would need to 
// be properly class-based at that point.

var thisParserState:Object = new Object();

// Lookup dictionary for converting any single argument brackets into it's corresponding string
// basically [armor] results in the "[armor]" segment of the string being replaced with the
// results of the corresponding anonymous function, in this case: function():* {return player.armorName;}
// tags not present in the singleArgConverters object return an error message.
//
var singleArgConverters:Object =
{
		// all the errors related to trying to parse stuff if not present are
		// already handled in the various *Descript() functions.
		// no need to duplicate them.

		// Note: all key strings MUST be ENTIRELY lowercase.

		"agility"					: function():* { return "[Agility]"; },
		"armor"						: function():* { return player.armorName;},
		"armorname"					: function():* { return player.armorName;},
		"ass"						: function():* { return buttDescript();},
		"asshole"					: function():* { return assholeDescript();},
		"balls"						: function():* { return ballsDescriptLight(); },
		"butt"						: function():* { return buttDescript();},
		"butthole"					: function():* { return assholeDescript();},
		"chest"						: function():* { return chestDesc(); },
		"clit"						: function():* { return clitDescript(); },
		"cock"						: function():* { return cockDescript(0);},
		"cockhead"					: function():* { return cockHead(0);},
		"cocks"						: function():* { return multiCockDescriptLight(); },
		"cunt"						: function():* { return vaginaDescript(); },
		"eachcock"					: function():* { return sMultiCockDesc();},
		"evade"						: function():* { return "[Evade]"; },
		"face"						: function():* { return player.face(); },
		"feet"						: function():* { return player.feet(); },
		"foot"						: function():* { return player.foot(); },
		"fullchest"					: function():* { return allChestDesc(); },
		"hair"						: function():* { return hairDescript(); },
		"hairorfur"					: function():* { return hairOrFur(); },
		"he"						: function():* { return player.mf("he","she"); },
		"him"						: function():* { return player.mf("him","her"); },
		"hips"						: function():* { return hipDescript();},
		"his"						: function():* { return player.mf("his","hers"); },
		"leg"						: function():* { return player.leg(); },
		"legs"						: function():* { return player.legs(); },
		"master"					: function():* { return player.mf("master","mistress"); },
		"misdirection"				: function():* { return "[Misdirection]"; },
		"multicockdescriptlight"	: function():* { return multiCockDescriptLight(); },
		"name"						: function():* { return player.short;},
		"nipple"					: function():* { return nippleDescript(0);},
		"nipples"					: function():* { return nippleDescript(0) + "s";},
		"onecock"					: function():* { return oMultiCockDesc();},
		"pg"						: function():* { return "\n\n";},
		"pussy"						: function():* { return vaginaDescript(); },
		"sack"						: function():* { return sackDescript(); },
		"sheath"					: function():* { return sheathDesc(); },
		"skin"						: function():* { return player.skin(); },
		"skinfurscales"				: function():* { return player.skinFurScales(); },
		"tongue"					: function():* { return tongueDescript();},
		"vag"						: function():* { return vaginaDescript(); },
		"vagina"					: function():* { return vaginaDescript(); },
		"vagorass"					: function():* { if (player.hasVagina())return vaginaDescript(); else assholeDescript();},
		"weapon"					: function():* { return player.weaponName;},
		"weaponname"				: function():* { return player.weaponName;}

}

// Does lookup of single argument tags ("[cock]", "[armor]", etc...)
// Supported variables are the options listed in the above
// singleArgConverters object. If the passed argument is found in the above object,
// the corresponding anonymous function is called, and it's return-value is returned.
// If the arg is not present in the singleArgConverters object, an error message is
// returned.
// ALWAYS returns a string
function convertSingleArg(arg:String):String
{
	var debug = false;
	var argResult:String;
	var capitalize:Boolean = isUpperCase(arg.charAt(0));
	arg = arg.toLowerCase()
	if (arg in singleArgConverters)
	{
		if (debug) trace("Found corresponding anonymous function");
		argResult = singleArgConverters[arg]();
		if (debug) trace("Called, return = ", argResult);
	}
	else
		return "<b>!Unknown tag \"" + arg + "\"!</b>";

	if (capitalize)
		argResult = capitalizeFirstWord(argResult);
	return argResult;
}

// PRONOUNS: The parser uses Elverson/Spivak Pronouns specifically to allow characters to be written with non-specific genders.
// http://en.wikipedia.org/wiki/Spivak_pronoun
//
// Cheat Table:
//           | Subject    | Object       | Possessive Adjective | Possessive Pronoun | Reflexive         |
// Agendered | ey laughs  | I hugged em  | eir heart warmed     | that is eirs       | ey loves emself   |
// Masculine | he laughs  | I hugged him | his heart warmed     | that is his        | he loves himself  |
// Feminine  | she laughs | I hugged her | her heart warmed     | that is hers       | she loves herself |

// (Is it bad that half my development time so far has been researching non-gendered nouns? ~~~~Fake-Name)


var arianLookups:Object = // For subject: "arian"
{
	"man"		: function():* {return arianMF("man","woman")},
	// argh! "Man" is the mass-noun for humanity, and I'm loathe to choose an even more esoteric variant.
	// Elverson/Spivak terminology is already esoteric enough, and it lacks a ungendered mass noun.

	"ey"		: function():* {return arianMF("he","she")},
	"em"		: function():* {return arianMF("him","her")},
	"eir"		: function():* {return arianMF("his","her")},
	"eirs"		: function():* {return arianMF("his","hers")},
	"emself"	: function():* {return arianMF("himself","herself")},

	"chestadj"	: function():* {return arianChestAdjective()},
	"chest"		: function():* {return arianChest()}
}
// Arian unhandled terms (I have not decided how to support them yet):
// arianMF("mas","mis")
// arianMF("master","mistress")
// arianMF("male","girly")



var rubiLookups:Object = // For subject: "rubi"
{
	"man"		: function():* {return rubiMF("man","woman")},

	"ey"		: function():* {return rubiMF("he","she")},
	"em"		: function():* {return rubiMF("him","her")},
	"eir"		: function():* {return rubiMF("his","her")},
	"eirs"		: function():* {return rubiMF("his","hers")},
	"emself"	: function():* {return rubiMF("himself","herself")},

	"cock"		: function():* {return rubiCock()},
	"breasts"	: function():* {return rubiBreasts()}

}
//Rubi unhandled terms :
// rubiMF("boy","girl")
// rubiMF("demon","demoness")
// rubiMF("gentleman","lady")


// PC ASCII Aspect lookups

var cockLookups:Object = // For subject: "cock"
{
	"all"		: function():*{ return multiCockDescriptLight(); },
	"each"		: function():*{ return sMultiCockDesc(); },
	"one"		: function():*{ return oMultiCockDesc(); },
	"largest"	: function():*{ return cockDescript(player.biggestCockIndex()); },
	"biggest"	: function():*{ return cockDescript(player.biggestCockIndex()); },
	"smallest"	: function():*{ return cockDescript(player.smallestCockIndex()); },
	"longest"	: function():*{ return cockDescript(player.longestCock()); },
	"shortest"	: function():*{ return cockDescript(player.shortestCockIndex()); }
}


var cockHeadLookups:Object = // For subject: "cockHead"
{
	"biggest"	: function():*{ return cockHead(player.biggestCockIndex()); },
	"largest"	: function():*{ return cockHead(player.biggestCockIndex()); },
	"smallest"	: function():*{ return cockHead(player.smallestCockIndex()); },
	"longest"	: function():*{ return cockHead(player.longestCock()); },			// the *head* of a cock has a length? Wut?
	"shortest"	: function():*{ return cockHead(player.shortestCockIndex()); }
}


// These tags take a two-word tag with a **numberic** attribute for lookup.
// [object NUMERIC-attribute]
// if "NUMERIC-attribute" can be cast to a Number, the parser looks for "object" in twoWordNumericTagsLookup.
// If it finds twoWordNumericTagsLookup["object"], it calls the anonymous function stored with said key "object"
// like so: twoWordNumericTagsLookup["object"](Number("NUMERIC-attribute"))
//
// if attribute cannot be case to a number, the parser looks for "object" in twoWordTagsLookup.
var twoWordNumericTagsLookup:Object =
{
		"cockfit":
			function(aspect):*
			{
				if(!player.hasCock()) return "<b>(Attempt to parse cock when none present.)</b>";
				else
				{
					if(player.cockThatFits(aspect) >= 0) return cockDescript(player.cockThatFits(aspect));
					else return cockDescript(player.smallestCockIndex());
				}
			},
		"cockfit2":
			function(aspect):*
			{
				if(!player.hasCock()) return "<b>(Attempt to parse cock when none present.)</b>";
				else {
					if(player.cockThatFits2(aspect) >= 0) return cockDescript(player.cockThatFits2(aspect));
					else return cockDescript(player.smallestCockIndex());
				}
			},
		"cockheadfit":
			function(aspect):*
			{

				if(!player.hasCock()) return "<b>(Attempt to parse cockhead when none present.)</b>";
				else {
					if(player.cockThatFits(aspect) >= 0) return cockHead(player.cockThatFits(aspect));
					else return cockHead(player.smallestCockIndex());
				}
			},
		"cockheadfit2":
			function(aspect):*
			{
				if(!player.hasCock()) return "<b>(Attempt to parse cockhead when none present.)</b>";
				else {
					if(player.cockThatFits2(aspect) >= 0) return cockHead(player.cockThatFits2(aspect));
					else return cockHead(player.smallestCockIndex());
				}
			},
		"cock":
			function(aspect):*
			{
				if(!player.hasCock()) return "<b>(Attempt to parse cock when none present.)</b>";
				else
				{
					if(aspect-1 >= 0 && aspect-1 < player.cockTotal()) return cockDescript(aspect - 1);
					else return "<b>(Attempt To Parse CockDescript for Invalid Cock)</b>";
				}
			},
		"cockhead":
			function(aspect):*
			{
				if(!player.hasCock()) return "<b>(Attempt to parse cockHead when none present.)</b>";
				else
				{
					if(aspect-1 >= 0 && aspect-1 < player.cockTotal()) return cockHead(aspect - 1);
					else return "<b>(Attempt To Parse CockHeadDescript for Invalid Cock)</b>";
				}
			}

}

// These tags take an ascii attribute for lookup.
// [object attribute]
// if attribute cannot be cast to a number, the parser looks for "object" in twoWordTagsLookup,
// and then uses the corresponding object to determine the value of "attribute", by looking for
// "attribute" twoWordTagsLookup["object"]["attribute"]
var twoWordTagsLookup:Object =
{
	// NPCs:
	"rubi"		: rubiLookups,
	"arian"		: arianLookups,

	// PC Attributes:

	"cock"		: cockLookups,
	"cockhead"	: cockHeadLookups
}


function convertDoubleArg(arg:String):String
{
	var debug = false;
	var argResult:String;


	var argTemp = arg.split(" ");
	if (argTemp.length != 2)
	{
		argResult = "<b>!Not actually a two-word tag!\"" + arg + "\"!</b>"
	}
	var subject = argTemp[0];
	var aspect = argTemp[1];

	// Figure out if we need to capitalize the resulting text
	var capitalize:Boolean = isUpperCase(aspect.charAt(0));

	subject = subject.toLowerCase()
	aspect = aspect.toLowerCase()

	var arg;

	// Only perform lookup in twoWordNumericTagsLookup if aspect can be cast to a valid number
	if (!isNaN(Number(aspect)))
	{

		if (subject in twoWordNumericTagsLookup)
		{
			aspect = Number(aspect);

			if (debug) trace("Found corresponding anonymous function");
			argResult = twoWordNumericTagsLookup[subject](aspect);
			if (debug) trace("Called, return = ", argResult);
		}
		else
			return "<b>!Unknown subject in two-word tag \"" + arg + "\"! Subject = \"" + subject + ", Numeric Aspect = " + aspect + "\</b>";
	}
	// aspect isn't a number. Look for subject in the normal twoWordTagsLookup
	else
	{
		if (subject in twoWordTagsLookup)
		{
			if (aspect in twoWordTagsLookup[subject])
			{

				if (debug) trace("Found corresponding anonymous function");
				argResult = twoWordTagsLookup[subject][aspect]();
				if (debug) trace("Called, return = ", argResult);
			}
			else
				return "<b>!Unknown aspect in two-word tag \"" + arg + "\"! ASCII Aspect = \"" + aspect + "\"</b>";

		}
		else
			return "<b>!Unknown subject in two-word tag \"" + arg + "\"! Subject = \"" + subject + ", ASCII Aspect = " + aspect + "\</b>";

	}




	if (capitalize)
		argResult = capitalizeFirstWord(argResult);
	return argResult;
}








// Possible text arguments in the conditional of a if statement
// First, there is an attempt to cast the argument to a Number. If that fails,
// a dictionary lookup is performed to see if the argument is in the conditionalOptions[]
// object. If that fails, we just fall back to returning 0
var conditionalOptions:Object =
{
		"strength"			: function():* {return  player.str;},
		"toughness"			: function():* {return  player.tou;},
		"speed"				: function():* {return  player.spe;},
		"intelligence"		: function():* {return  player.inte;},
		"libido"			: function():* {return  player.lib;},
		"sensitivity"		: function():* {return  player.sens;},
		"corruption"		: function():* {return  player.cor;},
		"fatigue"			: function():* {return  player.fatigue;},
		"hp"				: function():* {return  player.HP;},
		"hour"				: function():* {return  hours;},
		"days"				: function():* {return  days;},
		"tallness"			: function():* {return  player.tallness;},
		"hairlength"		: function():* {return  player.hairLength;},
		"femininity"		: function():* {return  player.femininity;},
		"masculinity"		: function():* {return  100 - player.femininity;},
		"cocks"				: function():* {return  player.cockTotal();},
		"breastrows"		: function():* {return  player.bRows();},
		"biggesttitsize"	: function():* {return  player.biggestTitSize();},
		"vagcapacity"		: function():* {return  player.vaginalCapacity();},
		"analcapacity"		: function():* {return  player.analCapacity();},
		"balls"				: function():* {return  player.balls;},
		"cumquantity"		: function():* {return  player.cumQ();},
		"biggesttitsize"	: function():* {return  player.biggestTitSize();},
		"milkquantity"		: function():* {return  player.lactationQ();},
		"hasvagina"			: function():* {return  player.hasVagina();},
		"istaur"			: function():* {return  player.isTaur();},
		"isnaga"			: function():* {return  player.isNaga();},
		"isgoo"				: function():* {return  player.isGoo();},
		"isbiped"			: function():* {return  player.isBiped();},
		"hasbreasts"		: function():* {return  (player.biggestTitSize() >= 1);},
		"hasballs"			: function():* {return  (player.balls > 0);},
		"hascock"			: function():* {return  player.hasCock();},
		"isherm"			: function():* {return  (player.gender == 3);},
		"cumnormal"			: function():* {return  (player.cumQ() <= 150);},
		"cummedium"			: function():* {return  (player.cumQ() > 150 && player.cumQ() <= 350);},
		"cumhigh"			: function():* {return  (player.cumQ() > 350 && player.cumQ() <= 1000);},
		"cumveryhigh"		: function():* {return  (player.cumQ() > 1000 && player.cumQ() <= 2500);},
		"cumextreme"		: function():* {return  (player.cumQ() > 2500);},
		"issquirter"		: function():* {return  (player.wetness() >= 4);},
		"ispregnant"		: function():* {return  (player.pregnancyIncubation > 0);},
		"isbuttpregnant"	: function():* {return  (player.buttPregnancyIncubation > 0);},
		"hasnipplecunts"	: function():* {return  player.hasFuckableNipples();},
		"canfly"			: function():* {return  player.canFly();},
		"islactating"		: function():* {return  (player.lactationQ() > 0);},
		"true"				: function():* {return  true;},
		"false"				: function():* {return  false;}
	}

// converts a single argument to a conditional to
// the relevant value, either by simply converting to a Number, or
// through lookup in the above conditionalOptions oject, and then calling the
// relevant function
// Realistally, should only return either boolean or numbers.
function convertConditionalArgumentFromStr(arg:String):*
{
	var debug = false;
	// convert the string contents of a conditional argument into a meaningful variable.
	arg = arg.toLowerCase()
	var argResult = 0;

	// Note: Case options MUST be ENTIRELY lower case. The comparaison string is converted to
	// lower case before the switch:case section

	// Try to cast to a number. If it fails, go on with the switch/case statement.
	if (!isNaN(Number(arg)))
	{
		if (debug) trace("Converted to float. Number = ", Number(arg))
		return Number(arg);
	}

	if (arg in conditionalOptions)
	{
		if (debug) trace("Found corresponding anonymous function");
		argResult = conditionalOptions[arg]();
		if (debug) trace("Called, return = ", argResult);

	}

	if (debug) trace("Could not convert to float. Evaluated ", arg, " as", argResult)
	return argResult;
}


// Evaluates the conditional section of an if-statement.
// Does the proper parsing and look-up of any of the special nouns
// which can be present in the conditional
function evalConditionalStatementStr(textCond:String):Boolean
{
	// Evaluates a conditional statement:
	// (varArg1 [conditional] varArg2)
	// varArg1 & varArg2 can be either numbers, or any of the
	// strings in the "conditionalOptions" object above.
	// numbers (which are in string format) are converted to a Number type
	// prior to comparison.

	// supports multiple comparison operators:
	// "=", "=="  - Both are Equals or equivalent-to operators
	// "<", ">    - Less-Than and Greater-Than
	// "<=", ">=" - Less-than or equal, greater-than or equal
	// "!="       - Not equal

	// proper, nested parsing of statements is a WIP
	// and not supported at this time.

	var debug = false;

	var isExp:RegExp = /(\w+)\s?(==|=|!=|<|>|<=|>=)\s?(\w+)/;
	var expressionResult:Object = isExp.exec(textCond);
	if (!expressionResult)
	{
		if (debug) trace("Invalid conditional!")
		return false
	}
	if (debug) trace("Expression = ", textCond, "Expression result = [", expressionResult, "], length of = ", expressionResult.length);

	var condArgStr1;
	var condArgStr2;
	var operator;

	condArgStr1 	= expressionResult[1];
	operator 		= expressionResult[2];
	condArgStr2 	= expressionResult[3];

	var retVal:Boolean = false;

	var condArg1;
	var condArg2;

	condArg1 = convertConditionalArgumentFromStr(condArgStr1);
	condArg2 = convertConditionalArgumentFromStr(condArgStr2);

	//Perform check
	if(operator == "=")
		retVal = (condArg1 == condArg2);
	else if(operator == ">")
		retVal = (condArg1 > condArg2);
	else if(operator == "==")
		retVal = (condArg1 == condArg2);
	else if(operator == "<")
		retVal = (condArg1 < condArg2);
	else if(operator == ">=")
		retVal = (condArg1 >= condArg2);
	else if(operator == "<=")
		retVal = (condArg1 <= condArg2);
	else if(operator == "!=")
		retVal = (condArg1 != condArg2);
	else
		retVal = (condArg1 != condArg2);


	if (debug) trace("Check: " + condArg1 + " " + operator + " " + condArg2 + " = " + retVal);

	return retVal;
}

// Splits the result from an if-statement.
// ALWAYS returns an array with two strings.
// if there is no else, the second string is empty.
function splitConditionalResult(textCtnt:String): Array
{
	// Splits the conditional section of an if-statemnt in to two results:
	// [if (condition) OUTPUT_IF_TRUE]
	//                 ^ This Bit   ^
	// [if (condition) OUTPUT_IF_TRUE | OUTPUT_IF_FALSE]
	//                 ^          This Bit            ^
	// If there is no OUTPUT_IF_FALSE, returns an empty string for the second option.

	var i:Number = 0;
	var tmp:Number = 0;

	var ret:Array;

	tmp = textCtnt.indexOf("[");

	if (tmp == -1)
	{
		ret = textCtnt.split("|")
		if (ret.length >=3)
			ret = ["<b>Error! Too many options in if statement!</b>",
					"<b>Error! Too many options in if statement!</b>"];

		// If there was no "else" condition, add a
		if (ret.length == 1)
			ret.push("");
		// No nested brackets, just split
	}
	else
	{
		// This *may* not be a problem, since IF statements should be evaluated depth-first.
		// Therefore, upper if statements shouldn't be able to tell they contained deeper
		// statements at all anyways, since the deeper statments will be evaluated to
		// plain text before the upper statements even are parsed at all
		// As always, more testing is needed.
		throw new Error("Nested IF statements still a WIP")
	}
	return ret;
}

// Called to evaluate a if statment string, and return the evaluated result.
// Returns an empty string ("") if the conditional rvaluates to false, and there is no else
// option.
function parseConditional(textCtnt:String, depth:int):String
{
	// NOTE: enclosing brackets are *not* included in the actual textCtnt string passed into this function
	// they're shown in the below examples simply for clarity's sake.
	// And because that's what the if-statements look like in the raw string passed into the parser
	// The brackets are actually removed earlier on by the recParser() step.

	// parseConditional():
	// Takes the contents of an if statement:
	// [if (condition) OUTPUT_IF_TRUE]
	// [if (condition) OUTPUT_IF_TRUE | OUTPUT_IF_FALSE]
	// and return the condition and output content as an array:
	// ["condition", "OUTPUT_IF_TRUE"]
	// ["condition", "OUTPUT_IF_TRUE | OUTPUT_IF_FALSE"]

	// (NOT YET) Allows nested condition parenthesis, because I'm masochistic

	var debug = false;

	var ret:Array = new Array("", "", "");	// first string is conditional, second string is the output

	var i:Number = 0;
	var tmp:Number = 0;
	var parenthesisCount:Number = 0;

	//var ifText;
	var conditional;
	var output;

	tmp = textCtnt.indexOf("(");

	if (tmp != -1)		// If we have any open parenthesis
	{
		for (i = tmp; i < textCtnt.length; i += 1)
		{
			if (textCtnt.charAt(i) == "(")
			{
				parenthesisCount += 1;
			}
			else if (textCtnt.charAt(i) == ")")
			{
				parenthesisCount -= 1;
			}
			if (parenthesisCount == 0)	// We've found the matching closing bracket for the opening bracket at textCtnt[tmp]
			{
				// why the fuck was I parsing the "if"?
				//ifText = recParser(textCtnt.substring(0, tmp));

				// Pull out the conditional, and then evaluate it.
				conditional = recParser(textCtnt.substring(tmp+1, i), depth);
				conditional = evalConditionalStatementStr(conditional);

				// Make sure the contents of the if-statement have been evaluated to a plain-text string before trying to
				// split the base-level if-statement on the "|"
				output = recParser(textCtnt.substring(i+1, textCtnt.length), depth);

				// And now do the actual splitting.
				output = splitConditionalResult(output);

				if (debug) trace("prefix = '", ret[0], "' conditional = ", conditional, " content = ", output);
				if (debug) trace("Content Item 1 = ", output[0], "Item 2 = ", output[1]);

				if (conditional)
					return output[0]
				else
					return output[1]

			}
		}
	}
	else
		throw new Error("Invalid if statement!", textCtnt);
	return "";
}


var buttonNum:Number;

function enterParserScene(sceneName:String):String
{

	trace("thisParserStateContents:")
	for (var prop in thisParserState) 
	{
		trace("thisParserState."+prop+" = "+thisParserState[prop]); 
	}


	//trace("Entering parser scene: \""+sceneName+"\"");
	//trace("Do we have the scene name? ", sceneName in thisParserState)
	if (sceneName == "exit")
	{
		doNextClear(debugPane);
	}
	if (sceneName in thisParserState)
	{	
		trace("Have scene \""+sceneName+"\". Parsing and setting up menu");
		menu();
		buttonNum = 0;
		var tmp1 = thisParserState[sceneName];
		var tmp2 = recParser(tmp1, 0);
		trace("Scene contents: \"" + tmp1 + "\" as parsed: \"" + tmp2 + "\"")
		rawOutputText(tmp2, true);  // we have to actually parse the scene now, and then stick it on the display
	}
	return tmp2

}


function parseSceneTag(textCtnt:String):void
{
	var sceneName:String;
	var sceneCont:String;
	
	sceneName = textCtnt.substring(textCtnt.indexOf(' ') ,textCtnt.indexOf('|'));
	sceneCont = textCtnt.substr(textCtnt.indexOf('|')+1);

	sceneName = stripStr(sceneName);

	trace("Adding scene with name \"" + sceneName + "\"")

	thisParserState[sceneName] = stripStr(sceneCont);

}
function parseButtonTag(textCtnt:String):void
{
	var arr;
	arr = textCtnt.split("|")
	if (arr.len > 2)
		throw new Error("Too many items in button")

	var buttonName:String = stripStr(arr[1]);
	var buttonFunc:String = stripStr(arr[0].substring(arr[0].indexOf(' ')));
	//trace("adding a button with name\"" + buttonName + "\" and function \"" + buttonFunc + "\"");
	addButton(buttonNum, buttonName, enterParserScene, buttonFunc);
	buttonNum += 1;
}

// pushes the contents of the passed string into the scene list object if it's a scene, or instantiates the named button if it's a button
// command and returns an empty string.
// if the contents are not a button or scene contents, returns the contents.
function evalForSceneControls(textCtnt:String):String
{

	var debug:Boolean = false;

	if (debug) trace("Checking for scene tags.");
	if (textCtnt.toLowerCase().indexOf("screen") == 0)
	{
		if (debug) trace("It's a scene");
		parseSceneTag(textCtnt);
		return "";
	}
	else if (textCtnt.toLowerCase().indexOf("button") == 0)
	{
		if (debug) trace("It's a button add statement");
		parseButtonTag(textCtnt);
		return "";
		
	}
	return textCtnt;
}

// Called to determine if the contents of a bracket are a parseable statement or not
// If the contents *are* a parseable, it calls the relevant function to evaluate it
// if not, it simply returns the contents as passed
function evalBracketContents(textCtnt:String, depth:int):String
{
	var debug = true;
	var retStr:String = "";
	if (debug) trace("Evaluating string: ", textCtnt);

	// POSSIBLE BUG: A actual statement starting with "if" could be misinterpreted as an if-statement
	// It's unlikely, but I *could* see it happening.
	// I need to do some testing ~~~~Fake-Name
	if (textCtnt.toLowerCase().indexOf("if") == 0)
	{
		if (debug) trace("It's an if-statement");
		retStr = parseConditional(textCtnt, depth);
		if (debug) trace("IF Evaluated to ", retStr);
	}
	else
	{
		if (debug) trace("Not an if statement")
			// Match a single word, with no leading or trailing space
		var singleWordTagRegExp:RegExp = /^\w+$/;
		var doubleWordTagRegExp:RegExp = /^\w+\s\w+$/;

		var singleWordExpRes:Object = singleWordTagRegExp.exec(textCtnt);
		var doubleWordExpRes:Object = doubleWordTagRegExp.exec(textCtnt);

		if (debug) trace("Checking if single word = [" + singleWordExpRes + "]", getQualifiedClassName(singleWordExpRes));
		if (debug) trace("string length = ", textCtnt.length);
		if (singleWordExpRes)
		{
			if (debug) trace("It's a single word!");
			retStr += convertSingleArg(textCtnt);
		}
		else if (doubleWordExpRes)
		{
			if (debug) trace("Two-word tag!")
			retStr += convertDoubleArg(textCtnt);
		}
		else
		{
			retStr += "<b>!Unknown multi-word tag \"" + retStr + "\"!</b>";
		}
	}
	return retStr;
}

import flash.utils.getQualifiedClassName;


// Actual internal parser function.
// textCtnt is the text you want parsed, depth is a number that reflects the current recursion depth
// You pass in the string you want parsed, and the parsed result is returned as a string.
function recParser(textCtnt:String, depth):String
{

	// Depth tracks our recursion depth
	// Basically, we need to handle things differently on the first execution, so we don't mistake single-word print-statements for
	// a tag. Therefore, every call of recParser increments depth by 1

	depth += 1;
	var debug = false;
	textCtnt = String(textCtnt);
	if (textCtnt.length == 0)	// Short circuit if we've been passed an empty string
		return "";

	var i:Number = 0;

	var bracketCnt:Number = 0;

	var tmp:Number = -1;

	var retStr:String = "";

	do
	{
		tmp = textCtnt.indexOf("[", tmp+1);
		if (textCtnt.charAt(tmp-1) == "\\")
		{
			// trace("bracket is escaped 1", tmp);
		}
		else if (tmp != -1)
		{
			// trace("need to parse bracket", tmp);
			break;
		}

	} while (tmp != -1)


	if (tmp != -1)		// If we have any open brackets
	{
		for (i = tmp; i < textCtnt.length; i += 1)
		{
			if (textCtnt.charAt(i) == "[")
			{
				if (textCtnt.charAt(i-1) != "\\")
				{
					//trace("bracket is not escaped - 2");
					bracketCnt += 1;
				}
			}
			else if (textCtnt.charAt(i) == "]")
			{
				if (textCtnt.charAt(i-1) != "\\")
				{
					//trace("bracket is not escaped - 3");
					bracketCnt -= 1;
				}
			}
			if (bracketCnt == 0)	// We've found the matching closing bracket for the opening bracket at textCtnt[tmp]
			{
				var prefixTmp, postfixTmp;

				// Only prepend the prefix if it actually has content.
				prefixTmp = textCtnt.substring(0, tmp);
				if (prefixTmp)
					retStr += prefixTmp
				// We know there aren't any brackets in the section before the first opening bracket.
				// therefore, we just add it to the returned string


				var tmpStr:String = textCtnt.substring(tmp+1, i);
				tmpStr = evalForSceneControls(tmpStr);		
				// evalForSceneControls swallows scene controls, so they won't get parsed further now.
				// therefore, you could *theoretically* have nested scene pages, though I don't know WHY you'd ever want that.
				if (tmpStr)
					retStr += evalBracketContents(recParser(tmpStr, depth), depth);
				
				// First parse into the text in the brackets (to resolve any nested brackets)
				// then, eval their contents, in case they're an if-statement or other control-flow thing
				// I haven't implemented yet

				// Only parse the trailing string if it has brackets in it.
				// if not, we need to just return the string as-is.
				// Parsing the trailing string if it doesn't have brackets could lead to it being
				// incorrectly interpreted as a multi-word tag (and shit would asplode and shit)

				postfixTmp = textCtnt.substring(i+1, textCtnt.length);
				if (postfixTmp.indexOf("[") != -1)
				{
					if (debug) trace("Need to parse trailing text", postfixTmp)
					retStr += recParser(postfixTmp, depth);	// Parse the trailing text (if any)
				}
				else
				{
					if (debug) trace("No brackets in trailing text", postfixTmp)
					retStr += postfixTmp;
				}

				return retStr;
				// and return the parsed string
			}
		}
	}
	else
	{
		// DERP. We should never have brackets around something that ISN'T a tag intended to be parsed. Therefore, we just need
		// to determine what type of parsing should be done do the tag.
		if (debug) trace("No brackets present", textCtnt);


		retStr += textCtnt;

	}

	return retStr;
}


// Main parser function.
// textCtnt is the text you want parsed, depth is a number, which should be 0
// or not passed at all.
// You pass in the string you want parsed, and the parsed result is returned as a string.



function recursiveParser(contents:String, parseAsMarkdown:Boolean = false):String
{
	// Eventually, when this goes properly class-based, we'll add a period, and have this.parserState.

	// Reset the parser's internal state, since we're parsing a new string:
	// trace("Purging scene parser contents")
	thisParserState = new Object();
	


	var ret:String = "";
	// Run through the parser
	contents = contents.replace(/\\n/g, "\n")
	ret = recParser(contents, 0);

	// Currently, not parsing text as markdown by default because it's fucking with the line-endings.
	import showdown.Showdown;
	if (parseAsMarkdown)
	{
		trace("markdownificating");
		ret = Showdown.makeHtml(ret);

		// stupid-as-fuck workarounds because the flash html support is broken.
		ret = ret.replace(/\n/g, "")
		// Remove all the explicit \n's in the content, because
		// flash is ridiculously stupid, and doesn't properly remove them like EVERY other html markup parser.

		var regexPCloseTag:RegExp = /<\/p>/gi;
		ret = ret.replace(regexPCloseTag,"</p>\n");
		// Finally, add a additional newline after each closing P tag, because flash only
		// outputs one newline per <p></p> tag, apparently flash again feels the need to be a special snowflake
	}

	// cleanup escaped brackets
	ret = ret.replace(/\\\]/g, "]")
	ret = ret.replace(/\\\[/g, "[")

	// Finally, if we have a parser-based scene. enter the "startup" scene.
	for (var prop in thisParserState) 
	{
		trace("thisParserState."+prop+" = "+thisParserState[prop]); 
	}

	if ("startup" in thisParserState)
	{
		ret = enterParserScene("startup");

		// HORRIBLE HACK
		// since we're initially called via a outputText command, the content of the first page's text will be overwritten
		// when we return. Therefore, in a horrible hack, we return the contents of mainTest.htmlText as the ret value, so 
		// the outputText call overwrites the window content with the exact same content.
		
		trace("Returning: ", ret);
		currentText = ret;


	}
	//trace(ret);
	// trace("Maintext content @ recursiveParser = ", mainText.htmlText.length)
	return ret

}

// Stupid string utility functions, because actionscript doesn't have them (WTF?)


function stripStr(str:String):String
{
	return trimStrBack(trimStrFront(str, " "), " ");
}

function trimStr(str:String, char:String = " "):String
{
	return trimStrBack(trimStrFront(str, char), char);
}

function trimStrFront(str:String, char:String = " "):String
{
	char = stringToCharacter(char);
	if (str.charAt(0) == char) {
		str = trimStrFront(str.substring(1), char);
	}
	return str;
}

function trimStrBack(str:String, char:String = " "):String
{
	char = stringToCharacter(char);
	if (str.charAt(str.length - 1) == char) {
		str = trimStrBack(str.substring(0, str.length - 1), char);
	}
	return str;
}
function stringToCharacter(str:String):String
{
	if (str.length == 1)
	{
		return str;
	}
	return str.slice(0, 1);
}


function isUpperCase(char:String):Boolean
{
	if (char == char.toUpperCase())
	{
		return true;
	}
	return false;
}

function capitalizeFirstWord(str:String):String
{

	str = str.charAt(0).toUpperCase()+str.slice(1);
	return str;
}