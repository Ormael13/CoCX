package classes.Parser
{
import classes.CoC;
import classes.CoC_Settings;

public class Parser
	{
		public static var mainParserDebug:Boolean = false;
		public static var lookupParserDebug:Boolean = false;
		public static var conditionalDebug:Boolean = false;
		public static var printCcntentDebug:Boolean = false;
		public static var printConditionalEvalDebug:Boolean = false;
		public static var printIntermediateParseStateDebug:Boolean = false;
		public static var logErrors:Boolean = true;

        /**
         * Does lookup of single argument tags ("[cock]", "[armor]", etc...) in singleArgConverters
         * Supported variables are the options listed in the above
         * singleArgConverters object. If the passed argument is found in the above object,
         * the corresponding anonymous function is called, and it's return-value is returned.
         * If the arg is not present in the singleArgConverters object, an error message is
         * returned.
         * ALWAYS returns a string
         */
		private static function convertSingleArg(arg:String):String
		{
			var argResult:String = null;
			var capitalize:Boolean = isUpperCase(arg.charAt(0));

			var argLower:String;
			argLower = arg.toLowerCase();
			if (argLower in ParserTags.singleArgConverters)
			{
				//if (logErrors) trace("WARNING: Found corresponding anonymous function");
				argResult = ParserTags.singleArgConverters[argLower]();

				if (lookupParserDebug) trace("WARNING: Called, return = ", argResult);

				if (capitalize)
					argResult = capitalizeFirstWord(argResult);

				return argResult;
			}
			else
			{

				// ---------------------------------------------------------------------------------
				// UGLY hack to patch legacy functionality in TiTS
				// This needs to go eventually

				var descriptorArray:Array = arg.split(".");

				obj = getObjectFromString(CoC.instance, descriptorArray[0]);
				if (obj == null)		// Completely bad tag
				{
					if (lookupParserDebug || logErrors) trace("WARNING: Unknown subject in " + arg);
					return "<b>!Unknown subject in \"" + arg + "\"!</b>";
				}
				if (obj.hasOwnProperty("getDescription") && arg.indexOf(".") > 0)
				{
					return obj.getDescription(descriptorArray[1], "");
				}
				// end hack
				// ---------------------------------------------------------------------------------


				if (lookupParserDebug) trace("WARNING: Lookup Arg = ", arg);
				var obj:*;
				obj = getObjectFromString(CoC.instance, arg);
				if (obj != null)
				{
					if (obj is Function)
					{
						if (lookupParserDebug) trace("WARNING: Found corresponding function in owner class");
						return obj();
					}
					else
					{
						if (lookupParserDebug) trace("WARNING: Found corresponding aspect in owner class");
						return String(obj); 	// explicit cast probably not needed
					}
				}
				else
				{
					if (lookupParserDebug || logErrors) trace("WARNING: No lookup found for", arg, " search result is: ", obj);
					return "<b>!Unknown tag \"" + arg + "\"!</b>";
				}
			}

		}

        private static function convertDoubleArg(inputArg:String):String
		{
			var argResult:String = null;

			var thing:*;

			var argTemp:Array = inputArg.split(" ");
			if (argTemp.length != 2)
			{
				if (logErrors) trace("WARNING: Not actually a two word tag! " + inputArg);
				return "<b>!Not actually a two-word tag!\"" + inputArg + "\"!</b>"
			}
			var subject:String = argTemp[0];
			var aspect:* = argTemp[1];
			var subjectLower:String = argTemp[0].toLowerCase();
			var aspectLower:* = argTemp[1].toLowerCase();

			if (lookupParserDebug) trace("WARNING: Doing lookup for subject", subject, " aspect ", aspect);

			// Figure out if we need to capitalize the resulting text
			var capitalize:Boolean = isUpperCase(subject.charAt(0)) || isUpperCase(aspect.charAt(0));


			// Only perform lookup in twoWordNumericTagsLookup if aspect can be cast to a valid number

			if ((subjectLower in ParserTags.twoWordNumericTagsLookup) && !isNaN(Number(aspect)))
			{
				aspectLower = Number(aspectLower);

				if (lookupParserDebug) trace("WARNING: Found corresponding anonymous function");
				argResult = ParserTags.twoWordNumericTagsLookup[subjectLower](aspectLower);
				if (capitalize)
					argResult = capitalizeFirstWord(argResult);
				if (lookupParserDebug) trace("WARNING: Called two word numeric lookup, return = ", argResult);
				return argResult;
			}

			// aspect isn't a number. Look for subject in the normal twoWordTagsLookup
			if (subjectLower in ParserTags.twoWordTagsLookup)
			{
				if (aspectLower in ParserTags.twoWordTagsLookup[subjectLower])
				{

					if (lookupParserDebug) trace("WARNING: Found corresponding anonymous function");
					argResult = ParserTags.twoWordTagsLookup[subjectLower][aspectLower]();
					if (capitalize)
						argResult = capitalizeFirstWord(argResult);
					if (lookupParserDebug) trace("WARNING: Called two word lookup, return = ", argResult);
					return argResult;
				}
				else
				{
					if (logErrors) trace("WARNING: Unknown aspect in two-word tag. Arg: " + inputArg + " Aspect: " + aspectLower);
					return "<b>!Unknown aspect in two-word tag \"" + inputArg + "\"! ASCII Aspect = \"" + aspectLower + "\"</b>";
				}

			}



			if (lookupParserDebug) trace("WARNING: trying to look-up two-word tag in parent");

			// ---------------------------------------------------------------------------------
			// UGLY hack to patch legacy functionality in TiTS
			// This needs to go eventually

			var descriptorArray:Array = subject.split(".");

			thing = getObjectFromString(CoC.instance, descriptorArray[0]);
			if (thing == null)		// Completely bad tag
			{
				if (logErrors) trace("WARNING: Unknown subject in " + inputArg);
				return "<b>!Unknown subject in \"" + inputArg + "\"!</b>";
			}
			if (thing.hasOwnProperty("getDescription") && subject.indexOf(".") > 0)
			{
				if(argTemp.length > 1) {
					return thing.getDescription(descriptorArray[1], aspect);
				}
				else {
					return thing.getDescription(descriptorArray[1], "");
				}
			}
			// end hack
			// ---------------------------------------------------------------------------------

			var aspectLookup:* = getObjectFromString(CoC.instance, aspect);

			if (thing != null)
			{
				if (thing is Function)
				{
					if (lookupParserDebug) trace("WARNING: Found corresponding function in owner class");
					return thing(aspect);
				}
				else if (thing is Array)
				{
					var indice:Number = Number(aspectLower);
					if (isNaN(indice))
					{
						if (logErrors) trace("WARNING: Cannot use non-number as indice to Array. Arg " + inputArg + " Subject: " + subject + " Aspect: " + aspect);
						return "<b>Cannot use non-number as indice to Array \"" + inputArg + "\"! Subject = \"" + subject + ", Aspect = " + aspect + "\"</b>";
					}
					else
						return thing[indice]
				}
				else if (thing is Object)
				{

					if (thing.hasOwnProperty(aspectLookup))
						return thing[aspectLookup];

					else if (thing.hasOwnProperty(aspect))
						return thing[aspect];
					else
					{
						if (logErrors) trace("WARNING: Object does not have aspect as a member. Arg: " + inputArg + " Subject: " + subject + " Aspect:" + aspect + " or " + aspectLookup);
						return "<b>Object does not have aspect as a member \"" + inputArg + "\"! Subject = \"" + subject + ", Aspect = " + aspect + " or " + aspectLookup + "\"</b>";
					}
				}
				else
				{
					// This will work, but I don't know why you'd want to
					// the aspect is just ignored
					if (lookupParserDebug) trace("WARNING: Found corresponding aspect in owner class");
					return String(thing);
				}
			}

			if (lookupParserDebug || logErrors) trace("WARNING: No lookup found for", inputArg, " search result is: ", thing);
			return "<b>!Unknown subject in two-word tag \"" + inputArg + "\"! Subject = \"" + subject + ", Aspect = " + aspect + "\"</b>";
		}




        /**
         * converts a single argument to a conditional to the relevant value,
         * either by simply converting to a Number, or
         * through lookup in the above conditionalOptions oject, and then calling the
         * relevant function
         * Realistally, should only return either boolean or numbers.
         *
         * @param arg
         * @return
         */
		private static function convertConditionalArgumentFromStr(arg:String):*
		{
			// convert the string contents of a conditional argument into a meaningful variable.
			var argLower:* = arg.toLowerCase();
			var argResult:* = -1;

			// Note: Case options MUST be ENTIRELY lower case. The comparaison string is converted to
			// lower case before the switch:case section

			// Try to cast to a number. If it fails, go on with the switch/case statement.
			if (!isNaN(Number(arg)))
			{
				if (printConditionalEvalDebug) trace("WARNING: Converted to float. Number = ", Number(arg));
				return Number(arg);
			}
			if (argLower in ParserTags.conditionalOptions)
			{
				if (printConditionalEvalDebug) trace("WARNING: Found corresponding anonymous function");
				argResult = ParserTags.conditionalOptions[argLower](CoC.instance);
				if (printConditionalEvalDebug) trace("WARNING: Called, return = ", argResult);
				return argResult;
			}


			var obj:* = getObjectFromString(CoC.instance, arg);

			if (printConditionalEvalDebug) trace("WARNING: Looked up ", arg, " in ", CoC.instance, "Result was:", obj);
			if (obj != null)
			{
				if (printConditionalEvalDebug) trace("WARNING: Found corresponding function for conditional argument lookup.");

				if (obj is Function)
				{
					if (printConditionalEvalDebug) trace("WARNING: Found corresponding function in owner class");
					argResult = Number(obj());
					return argResult;
				}
				else
				{
					if (printConditionalEvalDebug) trace("WARNING: Found corresponding aspect in owner class");
					argResult = Number(obj);
					return argResult;
				}
			}
			else
			{
				if (printConditionalEvalDebug || logErrors) trace("WARNING: No lookups found!");
				return null
			}
		}

        /**
         * Evaluates the conditional section of an if-statement.
         * Does the proper parsing and look-up of any of the special nouns
         * which can be present in the conditional
         *
         *  Evaluates a conditional statement:
         *  <pre>
         *      (varArg1 [conditional] varArg2)
         *  </pre>
         *
         *  varArg1 & varArg2 can be either numbers, or any of the
         *  strings in the "conditionalOptions" object above.
         *  numbers (which are in string format) are converted to a Number type
         *  prior to comparison.
         *
         *  Supports multiple comparison operators:
         *  <pre>
         *      "=" , "==" - Both are Equals or equivalent-to operators
         *      "<" , ">"  - Less-Than and Greater-Than
         *      "<=", ">=" - Less-than or equal, greater-than or equal
         *      "!="       - Not equal
         *  </pre>
         * proper, nested parsing of statements is a WIP
         * and not supported at this time.
         * @param textCond
         * @return
         */
		private static function evalConditionalStatementStr(textCond:String):Boolean
		{
			var isExp:RegExp = /([\w.]+)\s?(==|=|!=|<|>|<=|>=)\s?([\w.]+)/;
			var expressionResult:Object = isExp.exec(textCond);
			if (!expressionResult)
			{
				var condArg:* = convertConditionalArgumentFromStr(textCond);
				if (condArg != null)
				{
					if (printConditionalEvalDebug) trace("WARNING: Conditional \"", textCond, "\" Evalueated to: \"", condArg, "\"");
					return condArg
				}
				else
				{
                    if (logErrors) {
                        trace("WARNING: Invalid conditional! \"(", textCond, ")\" Conditionals must be in format:");
                        trace("WARNING:  \"({statment1} (==|=|!=|<|>|<=|>=) {statement2})\" or \"({valid variable/function name})\". ");
                    }
                    return false
				}
			}
			if (printConditionalEvalDebug) trace("WARNING: Expression = ", textCond, "Expression result = [", expressionResult, "], length of = ", expressionResult.length);

			var condArgStr1:String    = expressionResult[1];
			var operator:String       = expressionResult[2];
			var condArgStr2:String    = expressionResult[3];

			var retVal:Boolean = false;

			var condArg1:* = convertConditionalArgumentFromStr(condArgStr1);
			var condArg2:* = convertConditionalArgumentFromStr(condArgStr2);

			//Perform check
            switch (operator) {
                case "="  :	retVal = (condArg1 == condArg2); break;
                case ">"  :	retVal = (condArg1 >  condArg2); break;
                case "==" :	retVal = (condArg1 == condArg2); break;
                case "<"  :	retVal = (condArg1 <  condArg2); break;
                case ">=" :	retVal = (condArg1 >= condArg2); break;
                case "<=" :	retVal = (condArg1 <= condArg2); break;
                case "!=" :	retVal = (condArg1 != condArg2); break;
                default   :	retVal = (condArg1 != condArg2); break;
            }


			if (printConditionalEvalDebug) trace("WARNING: Check: " + condArg1 + " " + operator + " " + condArg2 + " result: " + retVal);

			return retVal;
		}

        /**
         * Splits the conditional section of an if-statemnt in to two results.
         *
         * @param textCtnt
         * @return an array with two strings. If there is no else, the second string is empty.
         */
		private static function splitConditionalResult(textCtnt:String): Array
		{
			// Splits the conditional section of an if-statemnt in to two results:
			// [if (condition) OUTPUT_IF_TRUE]
			//                 ^ This Bit   ^
			// [if (condition) OUTPUT_IF_TRUE | OUTPUT_IF_FALSE]
			//                 ^          This Bit            ^
			// If there is no OUTPUT_IF_FALSE, returns an empty string for the second option.
            if (conditionalDebug) {
                trace("WARNING: ------------------4444444444444444444444444444444444444444444444444444444444-----------------------");
                trace("WARNING: Split Conditional input string: ", textCtnt);
                trace("WARNING: ------------------4444444444444444444444444444444444444444444444444444444444-----------------------");
            }


            var ret:Array = ["", ""];


			var i:int;

			var sectionStart:int = 0;
			var section:int = 0;
			var nestLevel:int = 0;

			for (i = 0; i < textCtnt.length; i += 1)
			{
				switch (textCtnt.charAt(i))
				{
					case "[":    //Statement is nested one level deeper
						nestLevel += 1;
						break;

					case "]":    //exited one level of nesting.
						nestLevel -= 1;
						break;

					case "|":                  // At a conditional split
						if (nestLevel == 0)   // conditional split is only valid in this context if we're not in a nested bracket.
						{
							if (section == 1)  // barf if we hit a second "|" that's not in brackets
							{
								if (CoC_Settings.haltOnErrors) throw new Error("Nested IF statements still a WIP");
								ret = ["<b>Error! Too many options in if statement!</b>",
									"<b>Error! Too many options in if statement!</b>"];
							}
							else
							{
								ret[section] = textCtnt.substring(sectionStart, i);
								sectionStart = i + 1;
								section += 1
							}
						}
						break;

					default:
						break;
				}

			}
			ret[section] = textCtnt.substring(sectionStart, textCtnt.length);


            if (conditionalDebug) {
                trace("WARNING: ------------------5555555555555555555555555555555555555555555555555555555555-----------------------");
                trace("WARNING: Outputs: ", ret);
                trace("WARNING: ------------------5555555555555555555555555555555555555555555555555555555555-----------------------");
            }

            return ret;
		}


        /**
         * Called to evaluate a if statment string, and return the evaluated result.
         *
         * @param textCtnt statement without brackets
         * @param depth
         * @return an empty string ("") if the conditional rvaluates to false, and there is no else option.
         */
		private static function parseConditional(textCtnt:String, depth:int):String
		{
			// NOTE: enclosing brackets are *not* included in the actual textCtnt string passed into this function
			// they're shown in the below examples simply for clarity's sake.
			// And because that's what the if-statements look like in the raw string passed into the parser
			// The brackets are actually removed earlier on by the recParser() step.

			// parseConditional():
			// Takes the contents of an if statement:
			// [if (condition) OUTPUT_IF_TRUE]
			// [if (condition) OUTPUT_IF_TRUE | OUTPUT_IF_FALSE]
			// splits the contents into an array as such:
			// ["condition", "OUTPUT_IF_TRUE"]
			// ["condition", "OUTPUT_IF_TRUE | OUTPUT_IF_FALSE"]
			// Finally, evalConditionalStatementStr() is called on the "condition", the result
			// of which is used to determine which content-section is returned
			//




			// POSSIBLE BUG: A actual statement starting with "if" could be misinterpreted as an if-statement
			// It's unlikely, but I *could* see it happening.
			// I need to do some testing
			// ~~~~Fake-Name


            if (conditionalDebug) {
                trace("WARNING: ------------------2222222222222222222222222222222222222222222222222222222222-----------------------");
                trace("WARNING: If input string: ", textCtnt);
                trace("WARNING: ------------------2222222222222222222222222222222222222222222222222222222222-----------------------");
            }


            var ret:Array = ["", "", ""];	// first string is conditional, second string is the output

			var i:Number = 0;
			var parenthesisCount:Number = 0;

			//var ifText;
			var conditional:*;
			var output:*;

			var condStart:Number = textCtnt.indexOf("(");

            if (condStart == -1)		// If we don't have any open parenthesis
            {
                if (CoC_Settings.haltOnErrors) {
                    throw new Error("Invalid if statement!", textCtnt);
                }
                return "<b>Invalid IF Statement<b/>" + textCtnt;
            }
            else
			{
                for (i = condStart; i < textCtnt.length; i += 1) {
                    if (textCtnt.charAt(i) == "(") {
                        parenthesisCount += 1;
                    }
                    else if (textCtnt.charAt(i) == ")") {
                        parenthesisCount -= 1;
                    }
                    if (parenthesisCount == 0)	// We've found the matching closing bracket for the opening bracket at textCtnt[condStart]
                    {
                        // Pull out the conditional, and then evaluate it.
                        conditional = textCtnt.substring(condStart + 1, i);
                        conditional = evalConditionalStatementStr(conditional);

                        // Make sure the contents of the if-statement have been evaluated to a plain-text string before trying to
                        // split the base-level if-statement on the "|"
                        output = textCtnt.substring(i + 1, textCtnt.length);

                        // And now do the actual splitting.
                        output = splitConditionalResult(output);

                        // LOTS of debugging
                        if (conditionalDebug) {
                            trace("WARNING: prefix = '", ret[0], "' conditional = ", conditional, " content = ", output);
                            trace("WARNING: -0--------------------------------------------------");
                            trace("WARNING: Content Item 1 = ", output[0]);
                            trace("WARNING: -1--------------------------------------------------");
                            trace("WARNING: Item 2 = ", output[1]);
                            trace("WARNING: -2--------------------------------------------------");
                        }

                        if (conditional) {
                            return recParser(output[0], depth);
                        } else {
                            return recParser(output[1], depth);
                        }

                    }
                }
            }
            return "";
		}


		// ---------------------------------------------------------------------------------------------------------------------------------------
		// SCENE PARSING ---------------------------------------------------------------------------------------------------------------
		// ---------------------------------------------------------------------------------------------------------------------------------------

        /**
         * Attempt to return function inStr that is a member of localThis
		 *
         * Properly handles nested classes/objects, e.g. localThis.herp.derp
         * is returned by getFuncFromString(localThis, "herp.derp");
         * returns the relevant function if it exists, null if it does not.
		 *
         * @param localThis object or class to find property on
         * @param inStr property name as string
         * @return value of property, or null if not found
         */

		private static function getObjectFromString(localThis:Object, inStr:String):*
		{
			if (inStr in localThis)
			{
				if (lookupParserDebug) trace("WARNING: item: ", inStr, " in: ", localThis);
				return localThis[inStr];
			}

			if (inStr.indexOf('.') > 0) // *should* be > -1, but if the string starts with a dot, it can't be a valid reference to a nested class anyways.
			{
				var localReference:String;
				var itemName:String;
				localReference = inStr.substr(0, inStr.indexOf('.'));
				itemName = inStr.substr(inStr.indexOf('.')+1);

				// Debugging, what debugging?
                if (lookupParserDebug) {
                    trace("WARNING: localReference = ", localReference);
                    trace("WARNING: itemName = ", itemName);
                    trace("WARNING: localThis = \"", localThis, "\"");
                    trace("WARNING: dereferenced = ", localThis[localReference]);
                }

                // If we have the localReference as a member of the localThis, call this function again to further for
				// the item itemName in localThis[localReference]
				// This allows arbitrarily-nested data-structures, by recursing over the . structure in inStr
				if (localReference in localThis)
				{
					if (lookupParserDebug) trace("WARNING: have localReference:", localThis[localReference]);
					return getObjectFromString(localThis[localReference], itemName);
				}
				else
				{
					return null;
				}

			}

			if (lookupParserDebug) trace("WARNING: item: ", inStr, " NOT in: ", localThis);

			return null;

		}

		private static function isIfStatement(textCtnt:String):Boolean
		{
			return textCtnt.toLowerCase().indexOf("if") == 0;
		}

        /**
         *  Called to determine if the contents of a bracket are a parseable statement or not
         *  If the contents *are* a parseable, it calls the relevant function to evaluate it
         *  if not, it simply returns the contents as passed
         * @param textCtnt
         * @param depth
         * @return
         */
		private static function parseNonIfStatement(textCtnt:String, depth:int):String
		{

			var retStr:String = "";
			if (printCcntentDebug) trace("WARNING: Parsing content string: ", textCtnt);


			if (mainParserDebug) trace("WARNING: Not an if statement");
			// Match a single word, with no leading or trailing space
			var singleWordTagRegExp:RegExp = /^[\/\d\w-_.]+$/;
			var doubleWordTagRegExp:RegExp = /^[\/\d\w-_.]+\s[\w\d-_.]+$/;

			if (mainParserDebug) trace("WARNING: string length = ", textCtnt.length);

			else if (singleWordTagRegExp.exec(textCtnt))
			{
				if (mainParserDebug) trace("WARNING: It's a single word!");
				retStr += convertSingleArg(textCtnt);
			}
			else if (doubleWordTagRegExp.exec(textCtnt))
			{
				if (mainParserDebug) trace("WARNING: Two-word tag!");
				retStr += convertDoubleArg(textCtnt);
			}
			else
			{
				if (mainParserDebug) trace("WARNING: Cannot parse content. What?", textCtnt);
				retStr += "<b>!Unknown multi-word tag \"" + retStr + "\"!</b>";
			}

			return retStr;
		}

        /**
         * Actual internal parser function.
         *
         * @param textCtnt the text you want parsed
         * @param depth a number that reflects the current recursion depth
         * @return the parsed result is returned as a string.
         */
		private static function recParser(textCtnt:String, depth:Number):String
		{
			if (mainParserDebug) trace("WARNING: Recursion call", depth, "---------------------------------------------+++++++++++++++++++++");
			if (printIntermediateParseStateDebug) trace("WARNING: Parsing contents = ", textCtnt);
			// Depth tracks our recursion depth
			// Basically, we need to handle things differently on the first execution, so we don't mistake single-word print-statements for
			// a tag. Therefore, every call of recParser increments depth by 1

			depth += 1;
			if (textCtnt.length == 0) return "";// Short circuit if we've been passed an empty string

			var bracketCnt:int = 0;
			var lastBracket:int = -1;

			do
			{
				lastBracket = textCtnt.indexOf("[", lastBracket+1);
                if (textCtnt.charAt(lastBracket - 1) != "\\"){ break; }

            } while (lastBracket != -1);

			if (lastBracket == -1){
				return textCtnt; //no open brackets to parse
			}
			else { // If we have any open brackets
				for (var i:int = lastBracket; i < textCtnt.length; i++)
				{
					if (textCtnt.charAt(i) == "[" && textCtnt.charAt(i-1) != "\\")
					{
						bracketCnt += 1;
					}
					else if (textCtnt.charAt(i) == "]" && textCtnt.charAt(i-1) != "\\")
					{
						bracketCnt -= 1;
					}
					if (bracketCnt == 0)	// We've found the matching closing bracket for the opening bracket at textCtnt[lastBracket]
					{
                        var retStr:String = "";
						var prefixTmp:String, postfixTmp:String;

						// Only prepend the prefix if it actually has content.
						prefixTmp = textCtnt.substring(0, lastBracket);
						if (mainParserDebug) trace("WARNING: prefix content = ", prefixTmp);
						if (prefixTmp)
							retStr += prefixTmp;
						// We know there aren't any brackets in the section before the first opening bracket.
						// therefore, we just add it to the returned string

						var tmpStr:String = textCtnt.substring(lastBracket+1, i);

                        try {
                            if (isIfStatement(tmpStr)) {
                                if (conditionalDebug) {
                                    trace("WARNING: early eval as if");
                                }
                                retStr += parseConditional(tmpStr, depth);
                                if (conditionalDebug) {
                                    trace("WARNING: ------------------0000000000000000000000000000000000000000000000000000000000000000-----------------------");
                                }
                                //trace("WARNING: Parsed Ccnditional - ", retStr)
                            }
                            else if (tmpStr) {
                                if (printCcntentDebug) {
                                    trace("WARNING: Parsing bracket contents = ", tmpStr);
                                }
                                retStr += parseNonIfStatement(recParser(tmpStr, depth), depth);
                            }
                        } catch (e:Error) {
							retStr += "<b>!Cannot access: \""+tmpStr+"\"</b>";
                        }

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
							if (printCcntentDebug) trace("WARNING: Need to parse trailing text", postfixTmp);
							retStr += recParser(postfixTmp, depth);	// Parse the trailing text (if any)
							// Note: This leads to LOTS of recursion. Since we basically call recParser once per
							// tag, it means that if a body of text has 30 tags, we'll end up recursing at least
							// 29 times before finishing.
							// Making this tail-call reursive, or just parsing it flatly may be a much better option in
							// the future, if this does become an issue.
						}
						else
						{
							if (printCcntentDebug) trace("WARNING: No brackets in trailing text", postfixTmp);
							retStr += postfixTmp;
						}

						return retStr;
						// and return the parsed string
					}
				}
				return textCtnt; // Return original string if no closing brackets were found.
			}
		}

        /**
         * Main parser function.
		 *
         * textCtnt is the text you want parsed, depth is a number, which should be 0
         * or not passed at all.
         * You pass in the string you want parsed, and the parsed result is returned as a string.
		 *
         * @param contents String to parse
         * @param prettyQuotes true to convert "x" to \"x\" and -- to —
         * @return Parsed string
         */
		public static function recursiveParser(contents:String, prettyQuotes:Boolean = true):String
		{
			if (mainParserDebug) trace("WARNING: ------------------ Parser called on string -----------------------");

			// Run through the parser
			contents       = contents.replace(/\\n/g, "\n");
            var ret:String = recParser(contents, 0);
			if (printIntermediateParseStateDebug) trace("WARNING: Parser intermediate contents = ", ret);

			if (prettyQuotes)
			{
				// Convert quotes to prettyQuotes
				ret = makeQuotesPrettah(ret);
			}
			// cleanup escaped brackets
			ret = ret.replace(/\\]/g, "]");
			ret = ret.replace(/\\\[/g, "[");

			// And repeated spaces
			ret = ret.replace(/ {2}/g, " ");

			return ret

		}

		// ---------------------------------------------------------------------------------------------------------------------------------------
		// ---------------------------------------------------------------------------------------------------------------------------------------
		// ---------------------------------------------------------------------------------------------------------------------------------------

		private static function makeQuotesPrettah(inStr:String):String
		{

			inStr = inStr.replace(/(\w)'(\w)/g,										"$1\u2019$2")	// Apostrophes
			             .replace(/(^|[\r\n 	.!,?])"([a-zA-Z<>.!,?])/g,	"$1\u201c$2")	// Opening doubles
			             .replace(/([a-zA-Z<>.!,?])"([\r\n 	.!,?]|$)/g,		"$1\u201d$2")	// Closing doubles
			             .replace(/--/g,  											"\u2014");		// em-dashes
			return inStr;
		}


		// ---------------------------------------------------------------------------------------------------------------------------------------
		// ---------------------------------------------------------------------------------------------------------------------------------------
		// ---------------------------------------------------------------------------------------------------------------------------------------
		public static function isUpperCase(char:String):Boolean
		{
			if (!isNaN(Number(char)))
			{
				return false;
			}
			else if (char == char.toUpperCase())
			{
				return true;
			}
			return false;
		}

		public static function capitalizeFirstWord(str:String):String
		{
			str = str.charAt(0).toUpperCase()+str.slice(1);
			return str;
		}

	}
}
