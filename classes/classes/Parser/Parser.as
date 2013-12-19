
package classes.Parser
{
	// import classes.CoC;

	public class Parser
	{
		import showdown.Showdown;

		private var _ownerClass:*;			// main game class. Variables are looked-up in this class.
		private var _settingsClass:*;		// global static class used for shoving conf vars around

		public var sceneParserDebug:Boolean = false;

		public var mainParserDebug:Boolean = false;
		public var conditionalDebug:Boolean = false;
		public var printCcntentDebug:Boolean = false;
		public var printIntermediateParseStateDebug:Boolean = false;


		public function Parser(ownerClass:*, settingsClass:*)
		{
			this._ownerClass = ownerClass;
			this._settingsClass = settingsClass;
		}

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



		[screen (SCREEN_NAME) | screen text]
			// creates a new screen/page.

		[button (SCREEN_NAME)| button_text]
			// Creates a button which jumps to SCREEN_NAME when clicked

		*/


		// this.parserState is used to store the scene-parser state.
		// it is cleared every time recursiveParser is called, and then any scene tags are added 
		// as parserState["sceneName"] = "scene content"
		
		public var parserState:Object = new Object();

		// provides singleArgConverters
		include "./singleArgLookups.as";

		// Does lookup of single argument tags ("[cock]", "[armor]", etc...) in singleArgConverters
		// Supported variables are the options listed in the above
		// singleArgConverters object. If the passed argument is found in the above object,
		// the corresponding anonymous function is called, and it's return-value is returned.
		// If the arg is not present in the singleArgConverters object, an error message is
		// returned.
		// ALWAYS returns a string
		public function convertSingleArg(arg:String):String
		{
			var argResult:String;
			var capitalize:Boolean = isUpperCase(arg.charAt(0));
			arg = arg.toLowerCase()
			if (arg in singleArgConverters)
			{
				if (mainParserDebug) trace("Found corresponding anonymous function");
				argResult = singleArgConverters[arg](this._ownerClass);
				if (mainParserDebug) trace("Called, return = ", argResult);
			}
			else
				return "<b>!Unknown tag \"" + arg + "\"!</b>";

			if (capitalize)
				argResult = capitalizeFirstWord(argResult);
			return argResult;
		}

		// provides rubiLookups and arianLookups
		// note that these are only used in doubleArgLookups, not in Parser.as itself
		//
		// =!= NOTE: MUST BE IMPORTED BEFORE "./doubleArgLookups.as" =!=
		// 
		include "./npcLookups.as";

		// provides twoWordNumericTagsLookup and twoWordTagsLookup, which use 
		// cockLookups/cockHeadLookups, and rubiLookups/arianLookups respectively
		include "./doubleArgLookups.as";



		public function convertDoubleArg(inputArg:String):String
		{
			var argResult:String;

			var argTemp:Array = inputArg.split(" ");
			if (argTemp.length != 2)
			{
				argResult = "<b>!Not actually a two-word tag!\"" + inputArg + "\"!</b>"
			}
			var subject:* = argTemp[0];
			var aspect:* = argTemp[1];

			// Figure out if we need to capitalize the resulting text
			var capitalize:Boolean = isUpperCase(aspect.charAt(0));

			subject = subject.toLowerCase()
			aspect = aspect.toLowerCase()

			// Only perform lookup in twoWordNumericTagsLookup if aspect can be cast to a valid number
			if (!isNaN(Number(aspect)))
			{

				if (subject in twoWordNumericTagsLookup)
				{
					aspect = Number(aspect);

					if (mainParserDebug) trace("Found corresponding anonymous function");
					argResult = twoWordNumericTagsLookup[subject](this._ownerClass, aspect);
					if (mainParserDebug) trace("Called, return = ", argResult);
				}
				else
					return "<b>!Unknown subject in two-word tag \"" + inputArg + "\"! Subject = \"" + subject + ", Numeric Aspect = " + aspect + "\</b>";
			}
			// aspect isn't a number. Look for subject in the normal twoWordTagsLookup
			else
			{
				if (subject in twoWordTagsLookup)
				{
					if (aspect in twoWordTagsLookup[subject])
					{

						if (mainParserDebug) trace("Found corresponding anonymous function");
						argResult = twoWordTagsLookup[subject][aspect](this._ownerClass);
						if (mainParserDebug) trace("Called, return = ", argResult);
					}
					else
						return "<b>!Unknown aspect in two-word tag \"" + inputArg + "\"! ASCII Aspect = \"" + aspect + "\"</b>";

				}
				else
					return "<b>!Unknown subject in two-word tag \"" + inputArg + "\"! Subject = \"" + subject + ", ASCII Aspect = " + aspect + "\</b>";

			}




			if (capitalize)
				argResult = capitalizeFirstWord(argResult);
			return argResult;
		}





		// Provides the conditionalOptions object
		include "./conditionalConverters.as";	

		// converts a single argument to a conditional to
		// the relevant value, either by simply converting to a Number, or
		// through lookup in the above conditionalOptions oject, and then calling the
		// relevant function
		// Realistally, should only return either boolean or numbers.
		public function convertConditionalArgumentFromStr(arg:String):*
		{
			// convert the string contents of a conditional argument into a meaningful variable.
			arg = arg.toLowerCase()
			var argResult:* = 0;

			// Note: Case options MUST be ENTIRELY lower case. The comparaison string is converted to
			// lower case before the switch:case section

			// Try to cast to a number. If it fails, go on with the switch/case statement.
			if (!isNaN(Number(arg)))
			{
				if (mainParserDebug) trace("Converted to float. Number = ", Number(arg))
				return Number(arg);
			}

			if (arg in conditionalOptions)
			{
				if (mainParserDebug) trace("Found corresponding anonymous function");
				argResult = conditionalOptions[arg](this._ownerClass);
				if (mainParserDebug) trace("Called, return = ", argResult);

			}

			if (mainParserDebug) trace("Could not convert to float. Evaluated ", arg, " as", argResult)
			return argResult;
		}


		// Evaluates the conditional section of an if-statement.
		// Does the proper parsing and look-up of any of the special nouns
		// which can be present in the conditional
		public function evalConditionalStatementStr(textCond:String):Boolean
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


			var isExp:RegExp = /(\w+)\s?(==|=|!=|<|>|<=|>=)\s?(\w+)/;
			var expressionResult:Object = isExp.exec(textCond);
			if (!expressionResult)
			{
				if (mainParserDebug) trace("Invalid conditional!")
				return false
			}
			if (mainParserDebug) trace("Expression = ", textCond, "Expression result = [", expressionResult, "], length of = ", expressionResult.length);

			var condArgStr1:String;
			var condArgStr2:String;
			var operator:String;

			condArgStr1 	= expressionResult[1];
			operator 		= expressionResult[2];
			condArgStr2 	= expressionResult[3];

			var retVal:Boolean = false;

			var condArg1:*;
			var condArg2:*;

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


			if (mainParserDebug) trace("Check: " + condArg1 + " " + operator + " " + condArg2 + " result: " + retVal);

			return retVal;
		}

		// Splits the result from an if-statement.
		// ALWAYS returns an array with two strings.
		// if there is no else, the second string is empty.
		public function splitConditionalResult(textCtnt:String): Array
		{
			// Splits the conditional section of an if-statemnt in to two results:
			// [if (condition) OUTPUT_IF_TRUE]
			//                 ^ This Bit   ^
			// [if (condition) OUTPUT_IF_TRUE | OUTPUT_IF_FALSE]
			//                 ^          This Bit            ^
			// If there is no OUTPUT_IF_FALSE, returns an empty string for the second option.
			if (conditionalDebug) trace("------------------4444444444444444444444444444444444444444444444444444444444-----------------------")
			if (conditionalDebug) trace("Split Conditional input string: ", textCtnt)
			if (conditionalDebug) trace("------------------3333333333333333333333333333333333333333333333333333333333-----------------------")


			var ret:Array = new Array("", "");


			var i:int;

			var sectionStart:int = 0;
			var section:int = 0;
			var nestLevel:int = 0;

			for (i = 0; i < textCtnt.length; i += 1)
			{
				if (textCtnt.charAt(i) == "[")
					nestLevel += 1;
				else if (textCtnt.charAt(i) == "]")
					nestLevel -= 1;
				else if ((textCtnt.charAt(i) == "|") && (nestLevel == 0))
				{
					if (section == 1) // barf if we hit a second "|" that's not in brackets
					{
						if (this._settingsClass.haltOnErrors) throw new Error("Nested IF statements still a WIP")
						ret = ["<b>Error! Too many options in if statement!</b>",
							"<b>Error! Too many options in if statement!</b>"];
					}
					else
					{
						ret[section] = textCtnt.substring(sectionStart, i);
						sectionStart = i + 1
						section += 1
					}
				}

			}
			ret[section] = textCtnt.substring(sectionStart, textCtnt.length);


			if (conditionalDebug) trace("------------------5555555555555555555555555555555555555555555555555555555555-----------------------")
			if (conditionalDebug) trace("Outputs: ", ret)
			if (conditionalDebug) trace("------------------6666666666666666666666666666666666666666666666666666666666-----------------------")

			return ret;
		}

		private function splitConditionalContents(textCtnt:String):String
		{
			var ret:Array = new Array("", "")
			return "";
		}
		
		
		

		// Called to evaluate a if statment string, and return the evaluated result.
		// Returns an empty string ("") if the conditional rvaluates to false, and there is no else
		// option.
		public function parseConditional(textCtnt:String, depth:int):String
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


			// TODO: (NOT YET) Allows nested condition parenthesis, because I'm masochistic


			// POSSIBLE BUG: A actual statement starting with "if" could be misinterpreted as an if-statement
			// It's unlikely, but I *could* see it happening.
			// I need to do some testing 
			// ~~~~Fake-Name


			if (conditionalDebug) trace("------------------2222222222222222222222222222222222222222222222222222222222-----------------------")
			if (conditionalDebug) trace("If input string: ", textCtnt)
			if (conditionalDebug) trace("------------------1111111111111111111111111111111111111111111111111111111111-----------------------")


			var ret:Array = new Array("", "", "");	// first string is conditional, second string is the output

			var i:Number = 0;
			var tmp:Number = 0;
			var parenthesisCount:Number = 0;

			//var ifText;
			var conditional:*;
			var output:*;

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
						conditional = textCtnt.substring(tmp+1, i);
						conditional = evalConditionalStatementStr(conditional);

						// Make sure the contents of the if-statement have been evaluated to a plain-text string before trying to
						// split the base-level if-statement on the "|"
						output = textCtnt.substring(i+1, textCtnt.length)

						// And now do the actual splitting.
						output = splitConditionalResult(output);

						if (conditionalDebug) trace("prefix = '", ret[0], "' conditional = ", conditional, " content = ", output);
						
						if (conditionalDebug) trace("-0--------------------------------------------------");
						if (conditionalDebug) trace("Content Item 1 = ", output[0])
						if (conditionalDebug) trace("-1--------------------------------------------------");
						if (conditionalDebug) trace("Item 2 = ", output[1]);
						if (conditionalDebug) trace("-2--------------------------------------------------");

						if (conditional)
							return recParser(output[0], depth);
						else
							return recParser(output[1], depth);

					}
				}
			}
			else
			{
				if (this._settingsClass.haltOnErrors) throw new Error("");
				throw new Error("Invalid if statement!", textCtnt);
			}
			return "";
		}


		// ---------------------------------------------------------------------------------------------------------------------------------------
		// SCENE PARSING ---------------------------------------------------------------------------------------------------------------
		// ---------------------------------------------------------------------------------------------------------------------------------------


		// attempt to return function "inStr" that is a member of "localThis"
		// Properly handles nested classes/objects, e.g. localThis.herp.derp
		// is returned by getFuncFromString(localThis, "herp.derp");
		// returns the relevant function if it exists, null if it does not.
		private function getFuncFromString(localThis:Object, inStr:String):Function
		{
			if (inStr in localThis)
			{
				return localThis[inStr];
			}
			
			else if (inStr.indexOf('.') > 0) // *should* be > -1, but if the string starts with a dot, it can't be a valid reference to a nested class anyways.
			{
				var localReference:String;
				var itemName:String;
				localReference = inStr.substr(0, inStr.indexOf('.'));
				itemName = inStr.substr(inStr.indexOf('.')+1);
				if (sceneParserDebug) trace("localReference = ", localReference);
				if (sceneParserDebug) trace("itemName = ", itemName);
				if (sceneParserDebug) trace("localThis = ", localThis);
				if (sceneParserDebug) trace("dereferenced = ", localThis[localReference]);
				
				// If we have the localReference as a member of the localThis, call this function again to further for 
				// the item itemName in localThis[localReference]
				// This allows arbitrarily-nested data-structures, by recursing over the . structure in inStr
				if (localReference in localThis)
				{
					if (sceneParserDebug) trace("have localReference:", localThis[localReference]);
					return getFuncFromString(localThis[localReference], itemName);
				}
				else
				{
					return null;
				}

			}
			
			return null;

		}


		private var buttonNum:Number;


		// TODO: Make failed scene button lookups work properly!

		// Parser button event handler
		// This is the event bound to all button events, as well as the function called 
		// to enter the parser's cached scenes. If you pass recursiveParser a set of scenes including a scene named 
		// "startup", the parser will not exit normally, and will instead enter the "startup" scene at the completion of parsing the 
		// input string.
		//
		// the passed seneName string is preferentially looked-up in the cached scene array, and if there is not a cached scene of name sceneName
		// in the cache, it is then looked for as a member of _ownerClass.
		// if the function name is not found in either context, an error *should* be thrown, but at the moment,
		// it just returns to the debugPane
		//
		public function enterParserScene(sceneName:String):String
		{

			/*
			if (sceneParserDebug) trace("this.parserStateContents:")
			for (var prop in this.parserState) 
			{
				if (sceneParserDebug) trace("this.parserState."+prop+" = "+this.parserState[prop]); 
			}
			*/


			if (sceneParserDebug) trace("Entering parser scene: \""+sceneName+"\"");
			if (sceneParserDebug) trace("Do we have the scene name? ", sceneName in this.parserState)
			if (sceneName == "exit")
			{
				if (sceneParserDebug) trace("Enter scene called to exit");
				//doNextClear(debugPane);
				CONFIG::debug {
					_ownerClass.debugPane();
				}
			}
			else if (sceneName in this.parserState)
			{	
				if (sceneParserDebug) trace("Have scene \""+sceneName+"\". Parsing and setting up menu");
				_ownerClass.menu();
				
				buttonNum = 0;		// Clear the button number, so we start adding buttons from button 0

				var tmp1:String = this.parserState[sceneName];
				var tmp2:String = recParser(tmp1, 0);		// we have to actually parse the scene now
				var tmp3:String = Showdown.makeHtml(tmp2)

				

				_ownerClass.rawOutputText(tmp3, true);			// and then stick it on the display

				//if (sceneParserDebug) trace("Scene contents: \"" + tmp1 + "\" as parsed: \"" + tmp2 + "\"")
				if (sceneParserDebug) trace("Scene contents after markdown: \"" + tmp3 + "\"");
			}
			else if (this.getFuncFromString(_ownerClass, sceneName) != null)
			{
				if (sceneParserDebug) trace("Have function \""+sceneName+"\" in this!. Calling.");
				this.getFuncFromString(_ownerClass, sceneName)();
			}
			else
			{
				if (sceneParserDebug) trace("Enter scene called with unknown arg \""+sceneName+"\". falling back to the debug pane");
				CONFIG::debug {
					_ownerClass.doNext(_ownerClass.debugPane);
			}
			}
			return tmp2

		}

		// Parses the contents of a scene tag, shoves the unprocessed text in the scene object (this.parserState)
		// under the proper name.
		// Scenes tagged as such:
		// 
		// [sceneName | scene contents blaugh]
		// 
		// This gets placed in this.parserState so this.parserState["sceneName"] == "scene contents blaugh"
		// 
		// Note that parsing of the actual scene contents is deferred untill it's actually called for display.
		public function parseSceneTag(textCtnt:String):void
		{
			var sceneName:String;
			var sceneCont:String;
			
			sceneName = textCtnt.substring(textCtnt.indexOf(' ') ,textCtnt.indexOf('|'));
			sceneCont = textCtnt.substr(textCtnt.indexOf('|')+1);

			sceneName = stripStr(sceneName);
			if (sceneParserDebug) trace("Adding scene with name \"" + sceneName + "\"")

			// Cleanup the scene content from spurious leading and trailing space.
			sceneCont = trimStr(sceneCont, "\n");
			sceneCont = trimStr(sceneCont, "	");


			this.parserState[sceneName] = stripStr(sceneCont);

		}

		// Evaluates the contents of a button tag, and instantiates the relevant button
		// Current syntax:
		//
		// [button function_name | Button Name]
		// where "button" is a constant string, "function_name" is the name of the function pressing the button will call, 
		// and "Button Name" is the text that will be shown on the button.
		// Note that the function name cannot contain spaces (actionscript requires this), and is case-sensitive
		// "Button name" can contain arbitrary spaces or characters, excepting "]", "[" and "|"
		public function parseButtonTag(textCtnt:String):void
		{
			// TODO: Allow button positioning!
			var arr:Array;
			arr = textCtnt.split("|")
			if (arr.len > 2)
			{
				if (this._settingsClass.haltOnErrors) throw new Error("");
				throw new Error("Too many items in button")
			}

			var buttonName:String = stripStr(arr[1]);
			var buttonFunc:String = stripStr(arr[0].substring(arr[0].indexOf(' ')));
			//trace("adding a button with name\"" + buttonName + "\" and function \"" + buttonFunc + "\"");
			_ownerClass.addButton(buttonNum, buttonName, this.enterParserScene, buttonFunc);
			buttonNum += 1;
		}

		// pushes the contents of the passed string into the scene list object if it's a scene, or instantiates the named button if it's a button
		// command and returns an empty string.
		// if the contents are not a button or scene contents, returns the contents.
		public function evalForSceneControls(textCtnt:String):String
		{


			if (sceneParserDebug) trace("Checking for scene tags.");
			if (textCtnt.toLowerCase().indexOf("screen") == 0)
			{
				if (sceneParserDebug) trace("It's a scene");
				parseSceneTag(textCtnt);
				return "";
			}
			else if (textCtnt.toLowerCase().indexOf("button") == 0)
			{
				if (sceneParserDebug) trace("It's a button add statement");
				parseButtonTag(textCtnt);
				return "";	
			}
			return textCtnt;
		}


		public function isIfStatement(textCtnt:String):Boolean
		{
			if (textCtnt.toLowerCase().indexOf("if") == 0)
				return true;
			else
				return false;
		}

		// Called to determine if the contents of a bracket are a parseable statement or not
		// If the contents *are* a parseable, it calls the relevant function to evaluate it
		// if not, it simply returns the contents as passed
		public function parseNonIfStatement(textCtnt:String, depth:int):String
		{
			
			var retStr:String = "";
			if (printCcntentDebug) trace("Evaluating string: ", textCtnt);


			if (mainParserDebug) trace("Not an if statement")
				// Match a single word, with no leading or trailing space
			var singleWordTagRegExp:RegExp = /^\w+$/;
			var doubleWordTagRegExp:RegExp = /^\w+\s\w+$/;

			var singleWordExpRes:Object = singleWordTagRegExp.exec(textCtnt);
			var doubleWordExpRes:Object = doubleWordTagRegExp.exec(textCtnt);

			if (mainParserDebug) trace("Checking if single word = [" + singleWordExpRes + "]", getQualifiedClassName(singleWordExpRes));
			if (mainParserDebug) trace("string length = ", textCtnt.length);
			if (singleWordExpRes)
			{
				if (mainParserDebug) trace("It's a single word!");
				retStr += convertSingleArg(textCtnt);
			}
			else if (doubleWordExpRes)
			{
				if (mainParserDebug) trace("Two-word tag!")
				retStr += convertDoubleArg(textCtnt);
			}
			else
			{
				retStr += "<b>!Unknown multi-word tag \"" + retStr + "\"!</b>";
			}
		
			return retStr;
		}

		import flash.utils.getQualifiedClassName;


		// Actual internal parser function.
		// textCtnt is the text you want parsed, depth is a number that reflects the current recursion depth
		// You pass in the string you want parsed, and the parsed result is returned as a string.
		public function recParser(textCtnt:String, depth:Number):String
		{
			if (mainParserDebug) trace("Recursion call", depth, "---------------------------------------------+++++++++++++++++++++")
			if (printIntermediateParseStateDebug) trace("Parsing contents = ", textCtnt)
			// Depth tracks our recursion depth
			// Basically, we need to handle things differently on the first execution, so we don't mistake single-word print-statements for
			// a tag. Therefore, every call of recParser increments depth by 1

			depth += 1;
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
						var prefixTmp:String, postfixTmp:String;

						// Only prepend the prefix if it actually has content.
						prefixTmp = textCtnt.substring(0, tmp);
						if (mainParserDebug) trace("prefix content = ", prefixTmp);
						if (prefixTmp)
							retStr += prefixTmp
						// We know there aren't any brackets in the section before the first opening bracket.
						// therefore, we just add it to the returned string


						var tmpStr:String = textCtnt.substring(tmp+1, i);
						tmpStr = evalForSceneControls(tmpStr);		
						// evalForSceneControls swallows scene controls, so they won't get parsed further now.
						// therefore, you could *theoretically* have nested scene pages, though I don't know WHY you'd ever want that.

						if (isIfStatement(tmpStr))
						{
							if (conditionalDebug) trace("early eval as if")
							retStr += parseConditional(tmpStr, depth)
							if (conditionalDebug) trace("------------------0000000000000000000000000000000000000000000000000000000000000000-----------------------")
							//trace("Parsed Ccnditional - ", retStr)
						}
						else
						{
							
							if (tmpStr)
								retStr += parseNonIfStatement(recParser(tmpStr, depth), depth);
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
							if (printCcntentDebug) trace("Need to parse trailing text", postfixTmp)
							retStr += recParser(postfixTmp, depth);	// Parse the trailing text (if any)
							// Note: This leads to LOTS of recursion. Since we basically call recParser once per
							// tag, it means that if a body of text has 30 tags, we'll end up recursing at least 
							// 29 times before finishing.
							// Making this tail-call reursive, or just parsing it flatly may be a much better option in 
							// the future, if this does become an issue.
						}
						else
						{
							if (printCcntentDebug) trace("No brackets in trailing text", postfixTmp)
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
				if (printCcntentDebug) trace("No brackets present", textCtnt);


				retStr += textCtnt;

			}

			return retStr;
		}


		// Main parser function.
		// textCtnt is the text you want parsed, depth is a number, which should be 0
		// or not passed at all.
		// You pass in the string you want parsed, and the parsed result is returned as a string.
		public function recursiveParser(contents:String, parseAsMarkdown:Boolean = false):String
		{
			if (mainParserDebug) trace("------------------ Parser called on string -----------------------");
			// Eventually, when this goes properly class-based, we'll add a period, and have this.parserState.

			// Reset the parser's internal state, since we're parsing a new string:
			// trace("Purging scene parser contents")
			this.parserState = new Object();
			


			var ret:String = "";
			// Run through the parser
			contents = contents.replace(/\\n/g, "\n")
			ret = recParser(contents, 0);
			if (printIntermediateParseStateDebug) trace("Parser intermediate contents = ", ret)
			// Currently, not parsing text as markdown by default because it's fucking with the line-endings.
			
			if (parseAsMarkdown)
			{
				// trace("markdownificating");
				ret = Showdown.makeHtml(ret);


				var regexPCloseTag:RegExp = /<\/p>/gi;
				ret = ret.replace(regexPCloseTag,"</p>\n");
				// Finally, add a additional newline after each closing P tag, because flash only
				// outputs one newline per <p></p> tag, apparently flash again feels the need to be a special snowflake
			}

			// cleanup escaped brackets
			ret = ret.replace(/\\\]/g, "]")
			ret = ret.replace(/\\\[/g, "[")

			/*
			for (var prop in this.parserState) 
			{
				trace("this.parserState."+prop+" = "+this.parserState[prop]); 
			}
			*/

			// Finally, if we have a parser-based scene. enter the "startup" scene.
			if ("startup" in this.parserState)
			{
				ret = enterParserScene("startup");

				// HORRIBLE HACK
				// since we're initially called via a outputText command, the content of the first page's text will be overwritten
				// when we return. Therefore, in a horrible hack, we return the contents of mainTest.htmlText as the ret value, so 
				// the outputText call overwrites the window content with the exact same content.
				
				// trace("Returning: ", ret);
				_ownerClass.currentText = ret;


			}
			//trace(ret);
			// trace("Maintext content @ recursiveParser = ", mainText.htmlText.length)
			return ret

		}

		// ---------------------------------------------------------------------------------------------------------------------------------------
		// ---------------------------------------------------------------------------------------------------------------------------------------
		// ---------------------------------------------------------------------------------------------------------------------------------------

		// Stupid string utility functions, because actionscript doesn't have them (WTF?)

		public function stripStr(str:String):String
		{
			return trimStrBack(trimStrFront(str, " "), " ");
			return trimStrBack(trimStrFront(str, "	"), "	");
		}

		public function trimStr(str:String, char:String = " "):String
		{
			return trimStrBack(trimStrFront(str, char), char);
		}

		public function trimStrFront(str:String, char:String = " "):String
		{
			char = stringToCharacter(char);
			if (str.charAt(0) == char) {
				str = trimStrFront(str.substring(1), char);
			}
			return str;
		}

		public function trimStrBack(str:String, char:String = " "):String
		{
			char = stringToCharacter(char);
			if (str.charAt(str.length - 1) == char) {
				str = trimStrBack(str.substring(0, str.length - 1), char);
			}
			return str;
		}
		public function stringToCharacter(str:String):String
		{
			if (str.length == 1)
			{
				return str;
			}
			return str.slice(0, 1);
		}


		public function isUpperCase(char:String):Boolean
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

		public function capitalizeFirstWord(str:String):String
		{

			str = str.charAt(0).toUpperCase()+str.slice(1);
			return str;
		}

	}
}