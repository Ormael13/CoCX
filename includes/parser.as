


/*
planned syntax:

[if (condition) OUTPUT_IF_TRUE]
[if (condition) OUTPUT_IF_TRUE | OUTPUT_IF_FALSE]		// Note - Implicit else indicated by presence of the "|"
[functionName|ButtonText]								// Jumps to a section with the label functionName
[desc|DESC_NAME]										// queries a description parameter


*/


function convertSingleArg(inStr:String):String
{

	var retStr:String;
	//Same as param tags, but without the param
	switch(inStr)
	{
		case "armor":
		case "armorName":
			retStr = player.armorName;
			break;
		case "weapon":
		case "weaponName":
			retStr = player.weaponName;
			break;
		case "name":
			retStr = player.short;
			break;
		case "pg":
			retStr = "\n\n";
			break;
		case "asshole":
			retStr = assholeDescript();
			break;
		case "butthole":
			retStr = assholeDescript();
			break;
		case "cunt":
			if(player.hasVagina()) 
				retStr = vaginaDescript();
			else 
				retStr = "<b>(Attempt to parse vagina when none present.)</b>";
			break;
		case "cocks":
			if(player.hasCock()) 
				retStr = multiCockDescriptLight();
			else 
				retStr = "<b>(Attempt to parse cocks when none present.)</b>";
			break;
		case "pussy":
			if(player.hasVagina()) 
				retStr = vaginaDescript();
			else 
				retStr = "<b>(Attempt to parse vagina when none present.)</b>";
			break;
		case "vagina":
			if(player.hasVagina()) 
				retStr = vaginaDescript();
			else 
				retStr = "<b>(Attempt to parse vagina when none present.)</b>";
			break;
		case "vag":
			if(player.hasVagina()) 
				retStr = vaginaDescript();
			else 
				retStr = "<b>(Attempt to parse vagina when none present.)</b>";
			break;
		case "clit":
			if(player.hasVagina()) 
				retStr = clitDescript();
			else 
				retStr = "<b>(Attempt to parse clit when none present.)</b>";
			break;
		case "vagOrAss":
			if (player.hasVagina())
				retStr = vaginaDescript();
			else
				retStr = assholeDescript();
			break;
		case "hair":
			retStr = hairDescript();
			break;
		case "face":
			retStr = player.face();
			break;
		case "legs":
			retStr = player.legs();
			break;
		case "leg":
			retStr = player.leg();
			break;
		case "feet":
			retStr = player.feet();
			break;
		case "foot":
			retStr = player.foot();
			break;
		case "sack":
			retStr = sackDescript();
			break;
		case "balls":
			retStr = ballsDescriptLight();
			break;
		case "sheath":
			retStr = sheathDesc();
			break;
		case "chest":
			retStr = chestDesc();
			break;
		case "fullChest":
			retStr = allChestDesc();
			break;
		case "hips":
			retStr = hipDescript();
			break;
		case "butt":
			retStr = buttDescript();
			break;
		case "ass":
			retStr = buttDescript();
			break;
		case "nipple":
			retStr = nippleDescript(0);
			break;
		case "nipples":
			retStr = nippleDescript(0) + "s";
			break;
		case "tongue":
			retStr = tongueDescript();
			break;
		case "cock":
			if(player.hasCock()) 
				retStr = cockDescript(0);
			else 
				retStr = "<b>(Attempt to parse cock when none present.)</b>";
			break;
		case "eachCock":
			if(player.hasCock()) 
				retStr = sMultiCockDesc();
			else 
				retStr = "<b>(Attempt to parse eachCock when none present.)</b>";
			break;
		case "EachCock":
			if(player.hasCock()) 
				retStr = SMultiCockDesc();
			else 
				retStr = "<b>(Attempt to parse eachCock when none present.)</b>";
			break;
		case "oneCock":
			if(player.hasCock()) 
				retStr = oMultiCockDesc();
			else 
				retStr = "<b>(Attempt to parse eachCock when none present.)</b>";
			break;
		case "OneCock":
			if(player.hasCock()) 
				retStr = OMultiCockDesc();
			else 
				retStr = "<b>(Attempt to parse eachCock when none present.)</b>";
			break;
		case "cockHead":
			if(player.hasCock()) 
				retStr = cockHead(0);
			else 
				retStr = "<b>(Attempt to parse cockhead when none present.)</b>";
			break;
		case "master":
			retStr = player.mf("master","mistress");
			break;
		case "Master":
			retStr = player.mf("Master","Mistress");
			break;
		case "his":
			retStr = player.mf("his","her");
			break;
		case "His":
			retStr = player.mf("His","Her");
			break;
		case "he":
			retStr = player.mf("he","she");
			break;
		case "He":
			retStr = player.mf("He","She");
			break;
		case "him":
			retStr = player.mf("him","her");
			break;
		case "Him":
			retStr = player.mf("Him","Her");
			break;
		case "Evade":
			retStr = "[Evade]";
			break;
		case "Misdirection":
			retStr = "[Misdirection]";
			break;
		case "Agility":
			retStr = "[Agility]";
			break;
		default:
			retStr = "<b>!Unknown tag \"" + inStr + "\"!</b>";
			break;
	}
	return retStr;
}	

function convertConditionalArgumentFromStr(arg:String):*
{
	var debug = true;
	// convert the string contents of a conditional argument into a meaningful variable.
	arg = arg.toLowerCase()
	var argResult;

	// Note: Case options MUST be ENTIRELY lower case. The comparaison string is converted to 
	// lower case before the switch:case section

	// Try to cast to a number. If it fails, go on with the switch/case statement.
	if (!isNaN(Number(arg)))
	{
		if (debug) trace("Converted to float. Number = ", Number(arg))
		return Number(arg);
	}
	
	switch(arg)	
	{
		case "strength":
			argResult = player.str;
			break;
		case "toughness":
			argResult = player.tou;
			break;
		case "speed":
			argResult = player.spe;
			break;
		case "intelligence":
			argResult = player.inte;
			break;
		case "libido":
			argResult = player.lib;
			break;
		case "sensitivity":
			argResult = player.sens;
			break;
		case "corruption":
			argResult = player.cor;
			break;
		case "fatigue":
			argResult = player.fatigue;
			break;
		case "hp":
			argResult = player.HP;
			break;
		case "hour":
			argResult = hours;
			break;
		case "days":
			argResult = days;
			break;
		case "tallness":
			argResult = player.tallness;
			break;
		case "hairlength":
			argResult = player.hairLength;
			break;
		case "femininity":
			argResult = player.femininity;
			break;
		case "masculinity":
			argResult = 100 - player.femininity;
			break;
		case "cocks":
			argResult = player.cockTotal();
			break;
		case "breastrows":
			argResult = player.bRows();
			break;
		case "biggesttitsize":
			argResult = player.biggestTitSize();
			break;
		case "vagcapacity":
			argResult = player.vaginalCapacity();
			break;
		case "analcapacity":
			argResult = player.analCapacity();
			break;
		case "balls":
			argResult = player.balls;
			break;
		case "cumquantity":
			argResult = player.cumQ();
			break;
		case "biggesttitsize":
			argResult = player.biggestTitSize();
			break;
		case "milkquantity":
			argResult = player.lactationQ();
			break;
		case "hasvagina":
			argResult = player.hasVagina();
			break;
		case "istaur":
			argResult = player.isTaur();
			break;
		case "isnaga":
			argResult = player.isNaga();
			break;
		case "isgoo":
			argResult = player.isGoo();
			break;
		case "isbiped":
			argResult = player.isBiped();
			break;
		case "hasbreasts":
			argResult = (player.biggestTitSize() >= 1);
			break;
		case "hasballs":
			argResult = (player.balls > 0);
			break;
		case "hascock":
			argResult = player.hasCock();
			break;
		case "isherm":
			argResult = (player.gender == 3);
			break;
		case "cumnormal":
			argResult = (player.cumQ() <= 150);
			break;
		case "cummedium":
			argResult = (player.cumQ() > 150 && player.cumQ() <= 350);
			break;
		case "cumhigh":
			argResult = (player.cumQ() > 350 && player.cumQ() <= 1000);
			break;
		case "cumveryhigh":
			argResult = (player.cumQ() > 1000 && player.cumQ() <= 2500);
			break;
		case "cumextreme":
			argResult = (player.cumQ() > 2500);
			break;
		case "issquirter":
			argResult = (player.wetness() >= 4);
			break;
		case "ispregnant":
			argResult = (player.pregnancyIncubation > 0);
			break;
		case "isbuttpregnant":
			argResult = (player.buttPregnancyIncubation > 0);
			break;
		case "hasnipplecunts":
			argResult = player.hasFuckableNipples();
			break;
		case "canfly":
			argResult = player.canFly();
			break;
		case "islactating":
			argResult = (player.lactationQ() > 0);
			break;
		case "true":
			argResult = true;
			break;
		case "false":
			argResult = false;
			break;

		default:
			argResult = 0;
			break;
	}
	if (debug) trace("Could not convert to float. Evaluated ", arg, " as", argResult)
	return argResult;
}



function evalConditionalStatementStr(textCond:String):Boolean
{	
	var debug = true;

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
	{
		retVal = (condArg1 == condArg2);
	}
	else if(operator == ">")
	{
		retVal = (condArg1 > condArg2);
	}
	else if(operator == "==")
	{
		retVal = (condArg1 == condArg2);
	}
	else if(operator == "<")
	{
		retVal = (condArg1 < condArg2);
	}
	else if(operator == ">=")
	{
		retVal = (condArg1 >= condArg2);
	}
	else if(operator == "<=")
	{
		retVal = (condArg1 <= condArg2);
	}
	else if(operator == "!=")
	{
		retVal = (condArg1 != condArg2);
	}
	else
	{
		retVal = (condArg1 != condArg2);
	}

	
	if (debug) trace("Check: " + condArg1 + " " + operator + " " + condArg2 + " = " + retVal);
	
	return retVal;
}


function splitConditionalResult(textCtnt:String): Array
{
	// Splits the conditional section of an if-statemnt in to two results:
	// [if (condition) OUTPUT_IF_TRUE]
	//                 ^ This Bit   ^
	// [if (condition) OUTPUT_IF_TRUE | OUTPUT_IF_FALSE]
	//                 ^          This Bit            ^
	// If there is no OUTPUT_IF_FALSE, returns an empty string for the second option.
	// It's aware of brackets, so it will not split on a | in brackets
	// This is necessary to allow nested ifs

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
		// statements at all anyways.
		throw new Error("Nested IF statements still a WIP")
	}
	return ret;
}

function parseConditional(textCtnt:String):String
{
	// take the contents of an if statement:
	// [if (condition) OUTPUT_IF_TRUE]
	// [if (condition) OUTPUT_IF_TRUE | OUTPUT_IF_FALSE]
	// and return the condition and output content as an array:
	// ["condition", "OUTPUT_IF_TRUE"]
	// ["condition", "OUTPUT_IF_TRUE | OUTPUT_IF_FALSE"]

	// Allows nested parenthesis, because I'm masochistic

	var ret:Array = new Array("", "", "");	// first string is conditional, second string is the output

	var i:Number = 0;
	var tmp:Number = 0;
	var parenthesisCount:Number = 0;
	
	var ifText;
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
				ifText = recParser(textCtnt.substring(0, tmp));
				conditional = recParser(textCtnt.substring(tmp+1, i));
				conditional = evalConditionalStatementStr(conditional);
				output = recParser(textCtnt.substring(i+1, textCtnt.length));	// Parse the trailing text (if any)
				output = splitConditionalResult(output);

				trace("prefix = '", ret[0], "' conditional = ", conditional, " content = ", output);
				trace("Content Item 1 = ", output[0], "Item 2 = ", output[1]);

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
function evalBracketContents(textCtnt:String):String
{
	var ret:String;
	trace("Evaluating string: ", textCtnt);

	if (textCtnt.toLowerCase().indexOf("if") == 0)
	{
		trace("It's an if-statement");
		ret = parseConditional(textCtnt);
		trace("IF Evaluated to ", ret);
	}
	else
	{
		ret = textCtnt;
	}

	return ret;
}
function recParser(textCtnt:String):String
{
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
				retStr += textCtnt.substring(0, tmp);
				retStr += evalBracketContents(recParser(textCtnt.substring(tmp+1, i)));
				retStr += recParser(textCtnt.substring(i+1, textCtnt.length));	// Parse the trailing text (if any)
				return retStr;
			}
		}
	}
	else
	{
		// Nothing to parse
		//trace("No brackets present", textCtnt);
		retStr = textCtnt;
	}
	return textCtnt;
}