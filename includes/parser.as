
/*
syntax:

// Querying simple PC stat nouns:
	[noun]


Conditional statements:
// Simple if statement:
	[if (condition) OUTPUT_IF_TRUE]							
// If-Else statement
	[if (condition) OUTPUT_IF_TRUE | OUTPUT_IF_FALSE]		
	// Note - Implicit else indicated by presence of the "|"

Planned, but not implemented yet:
	
	[desc|DESC_NAME]										// queries a description parameter
	// Get specific attribute of item/char/whatever "desc"
	// Eventually, I want this to be able to use introspection to access class attributes directly
	// Maybe even manipulate them, though I haven't thought that wout much at the moment.

	[screen (SCREEN_NAME) | screen text]					
	// creates a new screen/page. 

	[change_screen (SCREEN_NAME)| button_text]
	// Creates a button which jumps to SCREEN_NAME when clicked


*/

// Lookup dictionary for converting any single argument brackets into it's corresponding string
// basically [armor] results in the "[armor]" segment of the string being replaced with the 
// results of the corresponding anonymous function, in this case: function():* {return player.armorName;}
// tags not present in the singleArgConverters object return an error message.
// 
var singleArgConverters:Object = 
{
		"armor"			: function():* {return player.armorName;},
		"armorname"		: function():* {return player.armorName;},
		"weapon"		: function():* {return player.weaponName;},
		"weaponname"	: function():* {return player.weaponName;},
		"name"			: function():* {return player.short;},
		"pg"			: function():* {return "\n\n";},
		"asshole"		: function():* {return assholeDescript();},
		"butthole"		: function():* {return assholeDescript();},
		"hair"			: function():* { return hairDescript(); },
		"face"			: function():* { return player.face(); },
		"legs"			: function():* { return player.legs(); },
		"leg"			: function():* { return player.leg(); },
		"feet"			: function():* { return player.feet(); },
		"foot"			: function():* { return player.foot(); },
		"sack"			: function():* { return sackDescript(); },
		"balls"			: function():* { return ballsDescriptLight(); },
		"sheath"		: function():* { return sheathDesc(); },
		"chest"			: function():* { return chestDesc(); },
		"fullchest"		: function():* { return allChestDesc(); },
		"hips"			: function():* {return hipDescript();},
		"butt"			: function():* { return buttDescript();},
		"ass"			: function():* { return buttDescript();},
		"nipple"		: function():* { return nippleDescript(0);},
		"nipples"		: function():* { return nippleDescript(0) + "s";},
		"tongue"		: function():* { return tongueDescript();},
		"evade"			: function():* { return "[Evade]"; },
		"misdirection"	: function():* { return "[Misdirection]"; },
		"agility"		: function():* { return "[Agility]"; },
		"master"		: function():* { return player.mf("master","mistress"); },
		"master"		: function():* { return player.mf("Master","Mistress"); },
		"his"			: function():* { return player.mf("his","her"); },
		"he"			: function():* { return player.mf("he","she"); },
		"him"			: function():* { return player.mf("him","her"); },

		// all the errors related to trying to parse stuff if not present are
		// already handled in the various *Descript() functions.
		// no need to duplicate them.
		"cunt"			: function():* { return vaginaDescript(); },
		"cocks"			: function():* { return multiCockDescriptLight(); },
		"pussy"			: function():* { return vaginaDescript(); },
		"vagina"		: function():* { return vaginaDescript(); },
		"vag"			: function():* { return vaginaDescript(); },
		"clit"			: function():* { return clitDescript(); },
		"cock"			: function():* {return cockDescript(0);},
		"eachcock"		: function():* {return sMultiCockDesc();},
		"eachcock"		: function():* {return SMultiCockDesc();},
		"onecock"		: function():* {return oMultiCockDesc();},
		"onecock"		: function():* {return OMultiCockDesc();},
		"cockhead"		: function():* {return cockHead(0);},
		"vagorass"		: function():* {if (player.hasVagina())return vaginaDescript(); else assholeDescript();}

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

// PRONOUNS: The parser uses Spivak Pronouns specifically to allow characters to be written with non-specific genders.
// http://en.wikipedia.org/wiki/Spivak_pronoun
//
// Cheat Table:
// Subject    | Object       | Possessive Adjective | Possessive Pronoun | Reflexive       |
// ey laughs  | I hugged em  | eir heart warmed     | that is eirs       | ey loves emself |

var arianLookups:Object = 
{
	"ey"		: function():* {return arianMF("he","she")},
	"em"		: function():* {return arianMF("him","her")},
	"eir"		: function():* {return arianMF("his","her")},
	"eirs"		: function():* {return arianMF("his","hers")},
	"emself"	: function():* {return arianMF("himself","herself")}
}

var rubiLookups:Object = 
{
	"ey"		: function():* {return rubiMF("he","she")},
	"em"		: function():* {return rubiMF("him","her")},
	"eir"		: function():* {return rubiMF("his","her")},
	"eirs"		: function():* {return rubiMF("his","hers")},
	"emself"	: function():* {return rubiMF("himself","herself")}
}

var charLookups:Object = 
{
	"rubi"		: rubiLookups,
	"arian"		: arianLookups


}

function convertDoubleArg(arg:String):String
{
	var debug = false;
	var argResult:String;

	var capitalize:Boolean = isUpperCase(arg.charAt(0));
	arg = arg.toLowerCase()

	var argTemp = arg.split(" ");
	trace("Argtemp = ", argTemp);

	/*
	if (arg in singleArgConverters)
	{
		if (debug) trace("Found corresponding anonymous function");
		argResult = singleArgConverters[arg]();
		if (debug) trace("Called, return = ", argResult);
	}
	else
		return "<b>!Unknown tag \"" + arg + "\"!</b>";
	*/

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
		"hour"				: function():* {return  this.model.time.hours;},
		"days"				: function():* {return  this.model.time.days;},
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
		trace("Not an if statement")
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


// Main parser function.
// textCtnt is the text you want parsed, depth is a number, which should be 0
// or not passed at all.
// You pass in the string you want parsed, and the parsed result is returned as a string.
function recParser(textCtnt:String, depth:int = 0):String
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
	var tmp:Number = 0;
	var bracketCnt:Number = 0;
	
	var retStr:String = "";

	tmp = textCtnt.indexOf("[");

	if (tmp != -1)		// If we have any open brackets
	{
		for (i = tmp; i < textCtnt.length; i += 1)
		{
			if (textCtnt.charAt(i) == "[")
			{
				bracketCnt += 1;
			}
			else if (textCtnt.charAt(i) == "]")
			{
				bracketCnt -= 1;
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

				retStr += evalBracketContents(recParser(textCtnt.substring(tmp+1, i), depth), depth);
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
					trace("Need to parse trailing text", postfixTmp)
					retStr += recParser(postfixTmp, depth);	// Parse the trailing text (if any)
				}
				else
				{
					trace("No brackets in trailing text", postfixTmp)
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

// Stupid string utility functions, because actionscript doesn't have them (WTF?)

function stripStr(str:String):String 
{
	return trimStrBack(trimStrFront(str, " "), " ");
}

function trimStr(str:String, char:String):String 
{
	return trimStrBack(trimStrFront(str, char), char);
}

function trimStrFront(str:String, char:String):String 
{
	char = stringToCharacter(char);
	if (str.charAt(0) == char) {
		str = trimStrFront(str.substring(1), char);
	}
	return str;
}

function trimStrBack(str:String, char:String):String 
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