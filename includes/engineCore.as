// import flash.events.MouseEvent;

//const DOUBLE_ATTACK_STYLE:int = 867;
//const SPELLS_CAST:int = 868;

//Fenoxo loves his temps
var temp:int = 0;

//Used to set what each action buttons displays and does.
var args:Array = new Array();
var funcs:Array = new Array();

//Used for stat tracking to keep up/down arrows correct.
var oldStr:Number = 0;
var oldTou:Number = 0;
var oldSpe:Number = 0;
var oldInte:Number = 0;
var oldSens:Number = 0;
var oldLib:Number = 0;
var oldCor:Number = 0;
var oldHP:Number = 0;
var oldLust:Number = 0;

function maxHP():Number {
	var max:Number = 0;
	max += int(player.tou*2 + 50);
	if(player.hasPerk("Tank") >= 0) max += 50;
	if(player.hasPerk("Tank 2") >= 0) max += Math.round(player.tou);
	if(player.level <= 20) max += player.level * 15;
	else max += 20 * 15;
	max = Math.round(max);
	if(max > 999) max = 999;
	return max;
}

function silly():Boolean {
	if(flags[SILLY_MODE_ENABLE_FLAG] == 1) return true;
	return false
}

function clearList():void {
	list = new Array();
}
var list:Array = new Array();
function addToList(arg):void {
	list[list.length] = arg;
}
function outputList():String {
	var stuff:String = "";
	for(var x:int = 0; x < list.length; x++) {
		stuff += list[x];
		if(list.length == 2 && x == 1) {
			stuff += " and ";
		}
		else if(x < list.length-2) {
			stuff += ", ";
		}
		else if(x < list.length-1) {
			stuff += ", and ";
		}
	}
	list = new Array();
	return stuff;	
}


function HPChange(changeNum:Number, display:Boolean) {
	if(changeNum == 0) return;
	if(changeNum > 0) {
		//Increase by 20%!
		if(player.hasPerk("History: Healer") >= 0) changeNum *= 1.2;
		if(player.HP + int(changeNum) > maxHP()) {
			if(player.HP >= maxHP()) {
				if(display) outputText("You're as healthy as you can be.\n", false);
				return;
			}
			if(display) outputText("Your HP maxes out at " + maxHP() + ".\n", false);
			player.HP = maxHP();
		}
		else
		{
			if(display) outputText("You gain " + int(changeNum) + " HP.\n", false);
			player.HP += int(changeNum);
			hpUp.visible = true;
		}
	}
	//Negative HP
	else
	{
		if(player.HP + changeNum <= 0) {
			if(display) outputText("You take " + int(changeNum*-1) + " damage, dropping your HP to 0.\n", false);
			player.HP = 0;
		}
		else {
			if(display) outputText("You take " + int(changeNum*-1) + " damage.\n", false);
			player.HP += changeNum;
		}
	}
	statScreenRefresh();
}
		
function clone(source:Object):* {
	var copier:ByteArray = new ByteArray();
	copier.writeObject(source);
	copier.position = 0;
	return(copier.readObject());
}

function speech(output:String, speaker:String):void {
	var speech:String = "";
	speech = speaker + " says, \"<i>" + output + "</i>\"\n";
	outputText(speech, false);
}

function checkCondition(variable:String, op:String, test:String):Boolean
{	
	//Regex to check if something is a number
	var isNumber:RegExp = new RegExp("[0-9]+");
	
	//Regex to check if something is a boolean
	var isBoolean:RegExp = new RegExp("[true|false]");
	
	var result:Boolean = false;
	
	var a, b;
	
	if (isNumber.test(test))
	{
		//Number variables are handled in here
		b = Number(test);
		
		//Case/Switch for the variable name
		switch(variable)
		{
		case "strength":
			a = player.str;
			break;
		case "toughness":
			a = player.tou;
			break;
		case "speed":
			a = player.spe;
			break;
		case "intelligence":
			a = player.inte;
			break;
		case "libido":
			a = player.lib;
			break;
		case "sensitivity":
			a = player.sens;
			break;
		case "corruption":
			a = player.cor;
			break;
		case "fatigue":
			a = player.fatigue;
			break;
		case "HP":
			a = player.HP;
			break;
		case "hour":
			a = hours;
			break;
		case "days":
			a = days;
			break;
		case "tallness":
			a = player.tallness;
			break;
		case "hairLength":
			a = player.hairLength;
			break;
		case "femininity":
			a = player.femininity;
			break;
		case "masculinity":
			a = 100 - player.femininity;
			break;
		case "cocks":
			a = player.cockTotal();
			break;
		case "breastRows":
			a = player.bRows();
			break;
		case "biggestTitSize":
			a = player.biggestTitSize();
			break;
		case "vagCapacity":
			a = player.vaginalCapacity();
			break;
		case "analCapacity":
			a = player.analCapacity();
			break;
		case "balls":
			a = player.balls;
			break;
		case "cumQuantity":
			a = player.cumQ();
			break;
		case "biggestTitSize":
			a = player.biggestTitSize();
			break;
		case "milkQuantity":
			a = player.lactationQ();
			break;
		default:
			a = 0;
			break;
		}
		
		//Perform check
		if(op == "=")
		{
			result = (a == b);
		}
		else if(op == ">")
		{
			result = (a > b);
		}
		else if(op == "<")
		{
			result = (a < b);
		}
		else if(op == ">=")
		{
			result = (a >= b);
		}
		else if(op == "<=")
		{
			result = (a <= b);
		}
		else if(op == "!=")
		{
			result = (a != b);
		}
		else
		{
			result = (a != b);
		}
	}
	else if(isBoolean.test(test))
	{
		//Boolean variables handled here
		//test = Boolean(result[3]);
		if (test == "true")
		{
			b = true;
		}
		else
		{
			b = false;
		}

		switch(variable)
		{
		case "hasVagina":
			a = player.hasVagina();
			break;
		case "isTaur":
			a = player.isTaur();
			break;
		case "isNaga":
			a = player.isNaga();
			break;
		case "isGoo":
			a = player.isGoo();
			break;
		case "isBiped":
			a = player.isBiped();
			break;
		case "hasBreasts":
			a = (player.biggestTitSize() >= 1);
			break;
		case "hasBalls":
			a = (player.balls > 0);
			break;
		case "hasCock":
			a = player.hasCock();
			break;
		case "isHerm":
			a = (player.gender == 3);
			break;
		case "cumNormal":
			a = (player.cumQ() <= 150);
			break;
		case "cumMedium":
			a = (player.cumQ() > 150 && player.cumQ() <= 350);
			break;
		case "cumHigh":
			a = (player.cumQ() > 350 && player.cumQ() <= 1000);
			break;
		case "cumVeryHigh":
			a = (player.cumQ() > 1000 && player.cumQ() <= 2500);
			break;
		case "cumExtreme":
			a = (player.cumQ() > 2500);
			break;
		case "isSquirter":
			a = (player.wetness() >= 4);
			break;
		case "isPregnant":
			a = (player.pregnancyIncubation > 0);
			break;
		case "isButtPregnant":
			a = (player.buttPregnancyIncubation > 0);
			break;
		case "hasNippleCunts":
			a = player.hasFuckableNipples();
			break;
		case "canFly":
			a = player.canFly();
			break;
		case "isLactating":
			a = (player.lactationQ() > 0);
			break;
		default:
			a = false;
			break;
		}
		
		if(op == "=")
		{
			result = (a == b);
		}
		else
		{
			result = (a != b);
		}
	}
	else
	{
		//String variables here
		
		switch(variable)
		{
		default:
			a = "";
			break;
		}
		
		if(op == "=")
		{
			result = (a == test);
		}
		else
		{
			result = (a != test);
		}
	}
	
	trace("Check: " + variable + " " + op + " " + test + " = " + result);
	
	return result;
}

function parseText(text:String):String
{
	//PARSE DAT TEXT!
	//Now with more awesome!
	
	//Regex to check if something is a number
	var isNumber:RegExp = new RegExp("[0-9]+");
	
	//Regex to check if something is a boolean
	var isBoolean:RegExp = new RegExp("[true|false]");
	
	//Regex to check if a string matches the expression format
	var isExp:RegExp = new RegExp("\\(([A-Za-z0-9]+)\\s(==|=|!=|<|>|<=|>=)\\s([A-Za-z0-9]+)\\)");
	
	//Regex to match non-branch, param-free tags - Tag names can contain any letters and numbers. No spaces or special characters.
	var basicTag:RegExp = new RegExp("\\[([a-zA-Z0-9]+)\\]");
	
	//Regex to match tags with a single parameter - Tag names can contain any letters and numbers. No spaces or special characters. Yes, I felt the need to repeat this.
	var paramTag:RegExp = new RegExp("\\[([a-zA-Z0-9]+)\\s(.*?)\\]");
	
	//Regex to match branch tags - You can't nest if's, and they MUST end with a space to make recursive parsing work
	//var branchTag:RegExp = new RegExp("\\[if\\s\\(([a-zA-Z]+)\\s(=|!=|>|<|<=|>=)\\s(.*?)\\)\\s\\\"(.*?)\\\"\\]");
	//var branchTag:RegExp = new RegExp("\\[if\\s\\((.*?)\\)\\s\\\"(.*?)\\\"\\]");
	var branchTag:RegExp = new RegExp("\\[if\\s(.*?)\\s\\\"(.*?)\\\"\\]");

	var branchTagElse:RegExp = new RegExp("\\[if\\s(.*?)\\s\\\"(.*?)\\\"\\selse\\s\\\"(.*?)\\\"\\]");

	var rep:String;
	//We parse the tags from most complex to most basic, as the basic tag has the most "greedy" regex
	
	//Grab the first branch tag
	var result:Object = branchTagElse.exec(text);
	
	while (result != null)
	{
		//result[2] is the text to be displayed. Also gets parsed for tags.
		rep = parseText(result[2]);
		
		var rep2:String = parseText(result[3]);
		
		var expTotal:String = result[1];
		
		var check;
		
		var exp:Object = isExp.exec(expTotal);
		
		while (exp != null)
		{
			var temp:Boolean = checkCondition(exp[1], exp[2], exp[3]);
			
			expTotal = expTotal.replace(isExp, "");
			
			expTotal = expTotal.replace(/^\s+|\s+$/g, "");
			
			if (check != undefined)
			{
				var oi = expTotal.indexOf("||");
				var ai = expTotal.indexOf("&&");
				
				if (oi == 0)
				{
					check = (check || temp);
				}
				else if(ai == 0)
				{
					check = (check && temp);
				}
				
				expTotal = expTotal.slice(2, expTotal.length);
			}
			else
			{
				check = temp;
			}
			
			exp = isExp.exec(expTotal);
		}
		
		//If comparison is true, add in the text
		if (check)
		{
			text = text.replace(branchTagElse, rep);
			//9999text = text.replace(branchTagElse, rep);
		}
		else
		{
			text = text.replace(branchTagElse, rep2);
			//9999text = text.replace(branchTagElse, rep2);
		}
		
		//Go to next result. If null, loop ends.
		check = undefined;
		result = branchTagElse.exec(text);
	}
	
	result = branchTag.exec(text);
	
	//While there are branch tags, parse them.
	while (result != null)
	{
		//result[2] is the text to be displayed. Also gets parsed for tags.
		rep = parseText(result[2]);
		
		expTotal = result[1];
		
		exp = isExp.exec(expTotal);
		
		while (exp != null)
		{
			var tempo:Boolean = checkCondition(exp[1], exp[2], exp[3]);
			
			expTotal = expTotal.replace(isExp, "");
			
			expTotal = expTotal.replace(/^\s+|\s+$/g, "");
			
			if (check != undefined)
			{
				oi = expTotal.indexOf("||");
				ai = expTotal.indexOf("&&");
				
				if (oi == 0)
				{
					check = (check || tempo);
				}
				else if(ai == 0)
				{
					check = (check && tempo);
				}
				
				expTotal = expTotal.slice(2, expTotal.length);
			}
			else
			{
				check = tempo;
			}
			
			exp = isExp.exec(expTotal);
		}
		
		//If comparison is true, add in the text
		if (check == true)
		{
			text = text.replace(branchTag, rep);
		}
		else
		{
			text = text.replace(branchTag, "");
		}
		
		//Go to next result. If null, loop ends.
		check = undefined;
		result = branchTag.exec(text);
	}
	
	//Find first single param tag
	result = paramTag.exec(text);
	
	//While we have single param tags, parse them
	while (result != null)
	{
		//Convert param to an actual value if needed
		var arg;
		
		if (isNumber.test(result[2]))
		{
			arg = Number(result[2]);
		}
		else
		{
			arg = result[2];
		}
		
		//Case/Switch for the tag name
		//result[1] is the tag name
		//rep is the text the tag is replaced with
		//The rest is pretty basic param checking
		switch(result[1])
		{
		case "cockFit":
			if(!player.hasCock()) rep = "<b>(Attempt to parse cock when none present.)</b>";
			else if(isNaN(arg)) rep = "<b>(Invalid argument for cockFit)</b>";
			else {
				if(player.cockThatFits(arg) >= 0) rep = cockDescript(player.cockThatFits(arg));
				else rep = cockDescript(player.smallestCockIndex());
			}
			break;
		case "cockFit2":
			if(!player.hasCock()) rep = "<b>(Attempt to parse cock when none present.)</b>";
			else if(isNaN(arg)) rep = "<b>(Invalid argument for cockFit2)</b>";
			else {
				if(player.cockThatFits2(arg) >= 0) rep = cockDescript(player.cockThatFits2(arg));
				else rep = cockDescript(player.smallestCockIndex());
			}
			break;
		case "cockHeadFit":
			if(!player.hasCock()) rep = "<b>(Attempt to parse cockhead when none present.)</b>";
			else if(isNaN(arg)) rep = "<b>(Invalid argument for cockHeadFit)</b>";
			else {
				if(player.cockThatFits(arg) >= 0) rep = cockHead(player.cockThatFits(arg));
				else rep = cockHead(player.smallestCockIndex());
			}
			break;
		case "cockHeadFit2":
			if(!player.hasCock()) rep = "<b>(Attempt to parse cockhead when none present.)</b>";
			else if(isNaN(arg)) rep = "<b>(Invalid argument for cockHeadFit2)</b>";
			else {
				if(player.cockThatFits2(arg) >= 0) rep = cockHead(player.cockThatFits2(arg));
				else rep = cockHead(player.smallestCockIndex());
			}
			break;
		case "cock":
			if(!player.hasCock()) rep = "<b>(Attempt to parse cock when none present.)</b>";
			else if (arg == "all")
			{
				rep = multiCockDescriptLight();
			}
			else if (arg == "each")
			{
				rep = sMultiCockDesc();
			}
			else if (arg == "one")
			{
				rep = oMultiCockDesc();
			}
			else if (arg == "largest" || arg == "biggest")
			{
				rep = cockDescript(player.biggestCockIndex())
			}
			else if (arg == "smallest")
			{
				rep = cockDescript(player.smallestCockIndex())
			}
			else if (arg == "longest")
			{
				rep = cockDescript(player.longestCock())
			}
			else if (arg == "shortest")
			{
				rep = cockDescript(player.shortestCockIndex())
			}
			else
			{
				if(arg-1 >= 0 && arg-1 < player.cockTotal()) rep = cockDescript(arg - 1);
				else rep = "<b>(Attempt To Parse CockDescript for Invalid Cock)</b>";
			}
			break;
		case "cockHead":
			if(!player.hasCock()) rep = "<b>(Attempt to parse cock when none present.)</b>";
			else if (arg == "largest" || arg == "biggest")
			{
				rep = cockHead(player.biggestCockIndex())
			}
			else if (arg == "smallest")
			{
				rep = cockHead(player.smallestCockIndex())
			}
			else if (arg == "longest")
			{
				rep = cockHead(player.longestCock())
			}
			else if (arg == "shortest")
			{
				rep = cockHead(player.shortestCockIndex())
			}
			else
			{
				if(arg-1 >= 0 && arg-1 < player.cockTotal()) rep = cockHead(arg - 1);
				else rep = "<b>(Attempt to parse cockhead when none present.)</b>";
			}
			break;
		default:
			rep = "<u><b>!Unknown tag \"" + result[1] + "\"!</b></u>";
			break;
		}
		
		//Add text, try and jump to next
		text = text.replace(paramTag, rep);
		
		result = paramTag.exec(text);
	}
	
	//Find first basic tag
	result = basicTag.exec(text);
	
	//While we have basic tags
	while (result != null)
	{
//		rep;
		
		//Same as param tags, but without the param
		switch(result[1])
		{
		case "armor":
		case "armorName":
			rep = player.armorName;
			break;
		case "weapon":
		case "weaponName":
			rep = player.weaponName;
			break;
		case "name":
			rep = player.short;
			break;
		case "pg":
			rep = "\n\n";
			break;
		case "asshole":
			rep = assholeDescript();
			break;
		case "butthole":
			rep = assholeDescript();
			break;
		case "cunt":
			if(player.hasVagina()) rep = vaginaDescript();
			else rep = "<b>(Attempt to parse vagina when none present.)</b>";
			break;
		case "cocks":
			if(player.hasCock()) rep = multiCockDescriptLight();
			else rep = "<b>(Attempt to parse cocks when none present.)</b>";
			break;
		case "pussy":
			if(player.hasVagina()) rep = vaginaDescript();
			else rep = "<b>(Attempt to parse vagina when none present.)</b>";
			break;
		case "vagina":
			if(player.hasVagina()) rep = vaginaDescript();
			else rep = "<b>(Attempt to parse vagina when none present.)</b>";
			break;
		case "vag":
			if(player.hasVagina()) rep = vaginaDescript();
			else rep = "<b>(Attempt to parse vagina when none present.)</b>";
			break;
		case "clit":
			if(player.hasVagina()) rep = clitDescript();
			else rep = "<b>(Attempt to parse clit when none present.)</b>";
			break;
		case "vagOrAss":
			if (player.hasVagina())
			{
				rep = vaginaDescript();
			}
			else
			{
				rep = assholeDescript();
			}
			break;
		case "hair":
			rep = hairDescript();
			break;
		case "face":
			rep = player.face();
			break;
		case "legs":
			rep = player.legs();
			break;
		case "leg":
			rep = player.leg();
			break;
		case "feet":
			rep = player.feet();
			break;
		case "foot":
			rep = player.foot();
			break;
		case "sack":
			rep = sackDescript();
			break;
		case "balls":
			rep = ballsDescriptLight();
			break;
		case "sheath":
			rep = sheathDesc();
			break;
		case "chest":
			rep = chestDesc();
			break;
		case "fullChest":
			rep = allChestDesc();
			break;
		case "hips":
			rep = hipDescript();
			break;
		case "butt":
			rep = buttDescript();
			break;
		case "ass":
			rep = buttDescript();
			break;
		case "nipple":
			rep = nippleDescript(0);
			break;
		case "nipples":
			rep = nippleDescript(0) + "s";
			break;
		case "tongue":
			rep = tongueDescript();
			break;
		case "cock":
			if(player.hasCock()) rep = cockDescript(0);
			else rep = "<b>(Attempt to parse cock when none present.)</b>";
			break;
		case "eachCock":
			if(player.hasCock()) rep = sMultiCockDesc();
			else rep = "<b>(Attempt to parse eachCock when none present.)</b>";
			break;
		case "EachCock":
			if(player.hasCock()) rep = SMultiCockDesc();
			else rep = "<b>(Attempt to parse eachCock when none present.)</b>";
			break;
		case "oneCock":
			if(player.hasCock()) rep = oMultiCockDesc();
			else rep = "<b>(Attempt to parse eachCock when none present.)</b>";
			break;
		case "OneCock":
			if(player.hasCock()) rep = OMultiCockDesc();
			else rep = "<b>(Attempt to parse eachCock when none present.)</b>";
			break;
		case "cockHead":
			if(player.hasCock()) rep = cockHead(0);
			else rep = "<b>(Attempt to parse cockhead when none present.)</b>";
			break;
		case "master":
			rep = player.mf("master","mistress");
			break;
		case "Master":
			rep = player.mf("Master","Mistress");
			break;
		case "his":
			rep = player.mf("his","her");
			break;
		case "His":
			rep = player.mf("His","Her");
			break;
		case "he":
			rep = player.mf("he","she");
			break;
		case "He":
			rep = player.mf("He","She");
			break;
		case "him":
			rep = player.mf("him","her");
			break;
		case "Him":
			rep = player.mf("Him","Her");
			break;
		case "Evade":
			rep = "[Evade]";
			break;
		case "Misdirection":
			rep = "[Misdirection]";
			break;
		case "Agility":
			rep = "[Agility]";
			break;
		default:
			rep = "<b>!Unknown tag \"" + result[1] + "\"!</b>";
			break;
		}
		
		//Standard replace & jump
		text = text.replace(basicTag, rep);
		
		result = basicTag.exec(text);
	}
	
	
	//Old stuff
	
	/*output = output.split("{").join("<b>BRACE {</b>");
	output = output.split("}").join("<b>} BRACE</b>");
	if(player.hasCock()) {
		output = output.split("[oneCock]").join(oMultiCockDesc());
		output = output.split("[OneCock]").join(OMultiCockDesc());
		output = output.split("[eachCock]").join(sMultiCockDesc());
		output = output.split("[eachCock]").join(SMultiCockDesc());
		output = output.split("[biggestCock]").join(cockDescript(player.biggestCockIndex()));
		output = output.split("[smallestCock]").join(cockDescript(player.smallestCockIndex()));
		output = output.split("[longestCock]").join(cockDescript(player.longestCock()));
		output = output.split("[shortestCock]").join(cockDescript(player.shortestCockIndex()));
		if(player.cockThatFits(monster.vaginalCapacity()) >= 0) output = output.split("[cockFitsVag]").join(cockDescript(player.cockThatFits(monster.vaginalCapacity())));
		else output = output.split("[cock]").join(cockDescript(player.smallestCockIndex()));
		if(player.cockThatFits2(monster.vaginalCapacity()) >= 0) output = output.split("[cockFitsVag2]").join(cockDescript(player.cockThatFits2(monster.vaginalCapacity())));
		else output = output.split("[cock]").join(cockDescript(player.smallestCockIndex()));
		if(player.cockThatFits(monster.analCapacity()) >= 0) output = output.split("[cockFitsAss]").join(cockDescript(player.cockThatFits(monster.analCapacity())));
		else output = output.split("[cock]").join(cockDescript(player.smallestCockIndex()));
		if(player.cockThatFits2(monster.analCapacity()) >= 0)output = output.split("[cockFitsAss2]").join(cockDescript(player.cockThatFits2(monster.analCapacity())));
		else output = output.split("[cock]").join(cockDescript(player.smallestCockIndex()));
		output = output.split("[cock]").join(cockDescript(0));
		output = output.split("[cock2]").join(cockDescript(1));
		output = output.split("[cock3]").join(cockDescript(2));
		output = output.split("[cock4]").join(cockDescript(3));
		output = output.split("[cock5]").join(cockDescript(4));
		output = output.split("[cock6]").join(cockDescript(5));
		output = output.split("[cock7]").join(cockDescript(6));
		output = output.split("[cock8]").join(cockDescript(7));
		output = output.split("[cock9]").join(cockDescript(8));
		output = output.split("[cock10]").join(cockDescript(9));
		output = output.split("[cockHead]").join(cockHead(0));
		output = output.split("[cockHead]2").join(cockHead(1));
		output = output.split("[cockHead]3").join(cockHead(2));
		output = output.split("[cockHead]4").join(cockHead(3));
		output = output.split("[cockHead]5").join(cockHead(4));
		output = output.split("[cockHead]6").join(cockHead(5));
		output = output.split("[cockHead]7").join(cockHead(6));
		output = output.split("[cockHead]8").join(cockHead(7));
		output = output.split("[cockHead]9").join(cockHead(8));
		output = output.split("[cockHead]10").join(cockHead(9));
	}
	output = output.split("[hair]").join(hairDescript());
	output = output.split("[face]").join(player.face());
	output = output.split("[legs]").join(player.legs());
	output = output.split("[leg]").join(player.leg());
	output = output.split("[feet]").join(player.feet());
	output = output.split("[foot]").join(player.foot());
	output = output.split("[balls]").join(ballsDescriptLight());
	output = output.split("[chest]").join(chestDesc());
	output = output.split("[fullChest]").join(allChestDesc());
	output = output.split("[hips]").join(hipDescript());
	output = output.split("[butt]").join(buttDescript());
	output = output.split("[ass]").join(buttDescript());
	output = output.split("[asshole]").join(assholeDescript());
	output = output.split("[butthole]").join(assholeDescript());
	if(player.hasVagina()) {
		output = output.split("[cunt]").join(vaginaDescript());
		output = output.split("[pussy]").join(vaginaDescript());
		output = output.split("[vagina]").join(vaginaDescript());
		output = output.split("[vag]").join(vaginaDescript());
		output = output.split("[vagOrAss]").join(vaginaDescript());
		output = output.split("[clit]").join(clitDescript());
	}
	else output = output.split("[vagOrAss]").join(assholeDescript());*/
	
	return text;
}
function clearOutput():void {
	currentText = "";
	mainText.htmlText = "";
	scrollBar.update();
}

function outputText(output:String, purgeText:Boolean = false, parse = true) {
	if(parse)
	{
		output = parseText(output);
	}
	//OUTPUT!
	if(purgeText) {
		//if(!debug) mainText.htmlText = output;
		clearOutput();
		currentText = output;
	}
	else {
		currentText += output;
		//if(!debug) mainText.htmlText = currentText;
	}
	if(debug) {
		mainText.htmlText = currentText;
		scrollBar.update();
	}
}
function perkLongDescription(perkName:String = ""):String {
	switch(perkName) {
		case "Pretend Strength Perk":
			return "Pretend I am telling you about how this works.";
		case "Resistance":
			return "You choose the 'Resistance' perk, reducing the rate at which your lust increases by 10%.";
		case "Arousing Aura":
			return "You choose the 'Arousing Aura' perk, causing you to radiate an aura of lust when your corruption is over 70.";
		case "Sadist":
			return "You choose the 'Sadist' perk, increasing damage by 20 percent but causing you to gain lust from dealing damage.";
		case "Masochist":
			return "You choose the 'Masochist' perk, reducing the damage you take but raising your lust each time!  This perk only functions while your libido is at or above 60!";
		case "Well Adjusted":
			return "You choose the 'Well Adjusted' perk, reducing the amount of lust you naturally gain over time while in this strange land!";
		case "Medicine":
			return "You choose the 'Medicine' perk, giving you a chance to remove debilitating poisons automatically!";
		case "Channeling":
			return "You choose the 'Channeling' perk, boosting the strength of your spellcasting!";
		case "Agility":
			return "You choose the 'Agility' perk, increasing the effectiveness of Light/Medium armors by a portion of your speed.";
		case "Speedy Recovery":
			return "You choose the 'Speedy Recovery' perk, boosting your fatigue recovery rate!";
		case "Regeneration 2":
			return "You choose the 'Regeneration 2' perk, giving an addition 2% of max HP per turn in combat and 4% of max HP per hour.";
		case "Fera's Boon - Seeder":
			return "Increases cum output by 1,000 mLs.";
		case "Fera's Boon - Wide Open":
			return "Keeps your pussy permanently gaped and increases pregnancy speed.";
		case "Fera's Boon - Milking Twat":
			return "Keeps your pussy from ever getting too loose and increases pregnancy speed.";
		case "Tank 2":
			return "You choose the 'Tank 2' perk, granting an extra maximum HP for each point of toughness.";
		case "Weapon Mastery":
			return "You choose the 'Weapon Mastery' perk, doubling the effectiveness of large weapons.";
		case "Thunderous Strikes":
			return "You choose the 'Thunderous Strikes' perk, increasing normal damage by 20% while your strength is over 80.";
		case "Acclimation":
			return "You choose the 'Acclimation' perk, making your body 15% more resistant to lust, up to a maximum of 75%.";
		case "Double Attack":
			return "You choose the 'Double Attack' perk.  This allows you to make two attacks so long as your strength is at 60 or below.  By default your effective strength will be reduced to 60 if it is too high when double attacking.  <b>You can enter the perks menu at any time to toggle options as to how you will use this perk.</b>";
		case "Mage":
			return "You choose the 'Mage' perk.  You are able to focus your magical abilities even more keenly, boosting your base spell effects by 50%.";
		case "Spellpower":
			return "You choose the 'Spellpower' perk.  Thanks to your sizeable intellect and willpower, you are able to more effectively use magic, boosting base spell effects by 50%.";
		case "Nymphomania":
			return "You've chosen the 'Nymphomania' perk.  Due to the incredible amount of corruption you've been exposed to, you've begun to live in a state of minor constant arousal.  Your minimum lust will be increased by as much as 30 (If you already have minimum lust, the increase is 10-15).";
		case "Precision":
			return "You've chosen the 'Precision' perk.  Thanks to your intelligence, you're now more adept at finding and striking an enemy's weak points, reducing their damage resistance from armor by 10.  If your intelligence ever drops below 25 you'll no longer be smart enough to benefit from this perk.";
		case "Seduction":
			return "You choose the 'Seduction' perk, upgrading the 'tease' attack with a more powerful damage and a higher chance of success.";
		case "Corrupted Libido":
			return "You choose the 'Corrupted Libido' perk.  As a result of your body's corruption, you've become a bit harder to turn on. (Lust gain reduced by 10%!)";
		case "Hot Blooded":
			return "You choose the 'Hot Blooded' perk.  As a result of your enhanced libido, your lust no longer drops below 20! (If you already have some minimum lust, it will be increased by 10)";
		case "Fertility+":
			return "You choose the 'Fertility+' perk, making it easier to get pregnant.  It also increases your cum volume by up to 50% (if appropriate)!";
		case "Magical Fertility":
			return "10% higher chance of pregnancy and increased pregnancy speed.";
		case "Magical Virility":
			return "200 mLs more cum per orgasm and enhanced virility.";
		case "Runner":
			return "You choose the 'Runner' perk, increasing your chances to escape from your foes when fleeing!";
		case "Evade":
			return "You choose the 'Evade' perk, allowing you to avoid enemy attacks more often!";
		case "Regeneration":
			return "You choose the 'Regeneration' perk, allowing you to heal 2% of max HP every hour and 1% of max HP every round of combat!";
		case "Iron Man":
			return "You choose the 'Iron Man' perk, reducing the fatigue cost of physical special attacks by 50%";
		case "Brawler":
			return "You choose the 'Brawler' perk, allowing you to make two unarmed attacks in a turn!";
		case "Tank":
			return "You choose the 'Tank' perk, giving you an additional 50 hp!";
		case "Strong Back 2: Strong Harder":
			return "You choose the 'Strong Back 2: Strong Harder' perk, enabling a fifth item slot."
		case "Strong Back":
			return "You choose the 'Strong Back' perk, enabling a fourth item slot.";
		case "Tactician":
			return "You choose the 'Tactician' perk, increasing critical hit chance by up to 10% (Intelligence-based).";
		case "Archmage":
			return "You choose the 'Archmage' perk, increasing base spell strength by 50%.";
		case "Lunging Attacks":
			return "You choose the 'Lunging Attacks' perk, granting 50% armor penetration for standard attacks.";
		case "Lightning Strikes":
			return "You choose the 'Lightning Strikes' perk, increasing the attack damage for non-heavy weapons.</b>";
		case "Immovable Object":
			return "You choose the 'Immovable Object' perk, granting 20% physical damage reduction.</b>";
		case "Resolute":
			return "You choose the 'Resolute' perk, granting immunity to stuns and some statuses.</b>";
		case "Berzerker":
			return "You choose the 'Berzerker' perk, which unlocks the 'Berzerk' magical ability.  Berzerking increases attack and lust resistance but reduces physical defenses.";
		case "Brutal Blows":
			return "You choose the 'Brutal Blows' perk, which reduces enemy armor with each hit.";
		default:
			return "An error occurred when loading the long perk description.  Please post a bug report on the bug report forums at forum.fenoxo.com.";
	}
	return "broken.";
}
function perkDescription(perkName:String = ""):String {
	switch(perkName) {
		case "History: Whore":
			return "Seductive experience causes your tease attacks to be 15% more effective.";
			break;
		case "History: Slut":
			return "Sexual experience has made you more able to handle large insertions and more resistant to stretching.";
		case "Pure and Loving":
			return "Your caring attitude towards love and romance makes you slightly more resistant to lust and corruption.";
		case "Sensual Lover":
			return "Your sensual attitude towards love and romance makes your tease ability slightly more effective.";
		case "One Track Mind":
			return "Your constant desire for sex causes your sexual organs to be able to take larger insertions and disgorge greater amounts of fluid.";
			break;
		case "Brawler":
			return "Brawling experience allows you to make two unarmed attacks in a turn.";
			break;
		case "Corrupted Nine-tails":
			return "The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells, but your method of attaining it has corrupted the transformation, preventing you from achieving true enlightenment.";
			break;
		case "Enlightened Nine-tails":
			return "The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells.";
			break;
		case "History: Alchemist":
			return "Alchemical experience makes items more reactive to your body.";
			break;
		case "History: Fighter":
			return "Past full of conflict increases physical damage dealt by 10%.";
			break;
		case "History: Healer":
			return "Healing experience increases HP gains by 20%.";
			break;
		case "History: Religious":
			return "Replaces masturbate with meditate when corruption less than or equal to 66.";
			break;
		case "History: Scholar":
			return "Time spent focusing your mind makes spellcasting 20% less fatiguing.";
			break;
		case "History: Smith":
			return "Knowledge of armor and fitting increases armor effectiveness by roughly 10%.";
			break;
		case "History: Slacker":
			return "Regenerate fatigue 20% faster.";
			break;
		case "Slime Core":
			return "Grants more control over your slimy body, allowing you to go twice as long without fluids.";
			break;
		case "Flexibility":
			return "Grants cat-like flexibility.  Useful for dodging and 'fun'.";
			break;
		case "Thick Skin":
			return "Toughens your dermis to provide 2 points of armor.";
			break;
		case "Bunny Eggs":
			return "Laying eggs has become a normal part of your bunny-body's routine.";
			break;
		case "Basilisk Womb":
			return "Enables your eggs to be properly fertilized into basilisks of both genders!";
			break;
		case "Oviposition":
			return "Causes you to regularly lay eggs when not otherwise pregnant.";
			break;
		case "Dragonfire":
			return "Allows access to a dragon breath attack.";
			break;
		case "Futa Form":
			return "Ensures that your body fits the Futa look (Tits DD+, Dick 8\"+, & Pussy).  Also keeps your lusts burning bright and improves the tease skill.";
			break;
		case "Futa Faculties":
			return "It's super hard to think about stuff that like, isn't working out or fucking!"
			break;
		case "Bulge Armor":
			return "Grants a 5 point damage bonus to dick-based tease attacks.";
			break;
		case "Slutty Seduction":
			return "Increases odds of successfully teasing and lust damage of successful teases by " + player.perkv1("Slutty Seduction") + " points.";
			break;
		case "Blood Mage":
			return "Spellcasting now consumes health instead of fatigue!";
			break;
		case "Purity Blessing":
			return "Reduces the rate at which your corruption, libido, and lust increase.";
			break;
		case "Wizard's Endurance":
			return "Reduces fatigue cost of spells by " + player.perkv1("Wizard's Endurance") + "%.";
			break;
		case "Wizard's Focus":
			return "Increases your spell effect modifier by " + player.perkv1("Wizard's Focus") * 100 + "%.";
			break;
		case "Strong":
			return "Gains strength 25% faster.";
			break;
		case "Tough":
			return "Gains toughness 25% faster.";
			break;
		case "Fast":
			return "Gains speed 25% faster.";
			break;
		case "Smart":
			return "Gains intelligence 25% faster.";
			break;
		case "Lusty":
			return "Gains lust 25% faster.";
			break;
		case "Sensitive":
			return "Gains sensitivity 25% faster.";
			break;
		case "Big Cock":
			return "Gains cock size 25% faster and with less limitations.";
			break;
		case "Messy Orgasms":
			return "Produces 50% more cum volume.";
			break;
		case "Big Tits":
			return "Makes your tits grow larger more easily.";
			break;
		case "Big Clit":
			return "Allows your clit to grow larger more easily and faster.";
			break;
		case "Fertile":
			return "Makes you 15% more likely to become pregnant.";
			break;
		case "Wet Pussy":
			return "Keeps your pussy wet and provides a bonus to capacity.";
			break;
		case "Marble Resistant":
			return "Provides resistance to the addictive effects of bottled LaBova milk.";
			break;
		case "Marble's Milk":
			return "Requires you to drink LaBova milk frequently or eventually die.  You cannot shake this addiction.";
			break;
		case "Minotaur Cum Addict":
			return "Causes you to crave minotaur cum frequently.  You cannot shake this addiction.";
			break;
		case "Misdirection":
			return "Grants additional evasion chances while wearing Raphael's red bodysuit.";
			break;
		case "Omnibus' Gift":
			return "Increases minimum lust but provides some lust resistance.";
			break;
		case "Pierced: Crimstone":
			return "Increases minimum lust by " + Math.round(player.perkv1("Pierced: Crimstone")) + ".";
		case "Pent Up":
			return "Increases minimum lust by " + Math.round(player.perkv1("Pent Up")) + " and makes you more vulnerable to seduction.";
			break;
		case "Midas Cock":
			return "Increases the gems awarded from victory in battle.";
			break;
		case "Phallic Potential":
			return "Increases the effects of penis-enlarging transformations.";
			break;
		case "Phallic Restraint":
			return "Reduces the effects of penis-enlarging transformations.";
			break;
		case "Lusty Regeneration":
			return "Regenerates 1% of HP per round in combat and 2% of HP per hour.";
			break;
		case "Pierced: Fertite":
			return "Increases cum production by " + Math.round(2*player.perkv1("Pierced: Fertite")) + "% and fertility by " + Math.round(player.perkv1("Pierced: Fertite")) + ".";
			break;
		case "Pierced: Furrite":
			return "Increases chances of encountering 'furry' foes.";
			break;
		case "Pierced: Lethite":
			return "Increases chances of encountering demonic foes.";
			break;
		case "Harpy Womb":
			return "Increases all laid eggs to large size so long as you have harpy legs and a harpy tail.";
			break;
		case "Hellfire":
			return "Grants a corrupted fire breath attack, like the hellhounds in the mountains.";
			break;
		case "Incorporeality":
			return "Allows you to fade into a ghost-like state and temporarily possess others.";
			break;
		case "Luststick Adapted":
			return "Grants immunity to the lust-increasing effects of lust-stick and allows its use.";
			break;
		case "Pilgrim's Bounty":
			return "Causes you to always cum as hard as if you had max lust.";
			break;
		case "Cornucopia":
			return "Vaginal and Anal capacities increased by 30.";
			break;
		case "Spider Ovipositor":
			return "Allows you to lay eggs through a special organ on your arachnid abdomen, though you need at least 10 eggs to lay.";
			break;
		case "Bee Ovipositor":
			return "Allows you to lay eggs through a special organ on your insect abdomen, though you need at least 10 eggs to lay.";
			break;
		case "Fera's Boon - Alpha":
			return "Increases the rate your cum builds up and cum production in general.";
			break;
		case "Fera's Boon - Breeding Bitch":
			return "Increases fertility and reduces the time it takes to birth young.";
			break;
		case "Marae's Gift - Stud":
			return "Increases your cum production and potency greatly.";
			break;
		case "Marae's Gift - Fertility":
			return "Greatly increases fertility and halves base pregnancy speed.";
			break;
		case "Marae's Gift - Profractory":
			return "Causes your cum to build up at 3x the normal rate.";
			break;
		case "Marae's Gift - Buttslut":
			return "Makes your anus provide lubrication when aroused.";
			break;
		case "Feeder":
			return "Lactation does not decrease and gives a compulsion to breastfeed others.";
			break;
		case "Fire Lord":
			return "Akbal's blessings grant the ability to breathe burning green flames.";
			break;
		case "Whispered":
			return "Akbal's blessings grant limited telepathy that can induce fear.";
			break;
		case "Bro Brains":
			return "Makes thou... thin... fuck, that shit's for nerds.";
			break;
		case "Bro Body":
			return "Grants an ubermasculine body that's sure to impress.";
			break;
		case "Bimbo Body":
			return "Gives the body of a bimbo.  Tits will never stay below a 'DD' cup, libido is raised, lust resistance is raised, and upgrades tease.";
			break;
		case "Bimbo Brains":
			return "Now that you've drank bimbo liquer, you'll never, like, have the attention span and intelligence you once did!  But it's okay, 'cause you get to be so horny an' stuff!";
			break;
		case "Brood Mother":
			return "Pregnancy moves twice as fast as a normal woman's.";
			break;
		case "Diapause":
			return "Pregnancy does not advance normally, but develops quickly after taking in fluids.";
			break;
		case "Elven Bounty":
			return "Increases fertility by " + player.perkv2("Elven Bounty") + "% and cum production by " + player.perkv1("Elven Bounty") + "mLs.";
			break;
		case "Androgyny":
			return "No gender limits on facial masculinity or femininity.";
			break;
		case "Pretend Strength Perk":
			return "Pretend I am telling you about how this works.";
			break;
		case "Resistance":
			return "Reduces lust gain by 10%.";
			break;
		case "Arousing Aura":
			return "Exude a lust-inducing aura (Req's corruption of 70 or more)";
			break;
		case "Sadist":
			return "Deal 20% more damage, but gain lust at the same time.";
			break;
		case "Masochist":
			return "Take 30% less physical damage but gain lust when damage.";
			break;
		case "Well Adjusted":
			return "You gain half as much lust as time passes in Mareth.";
			break;
		case "Medicine":
			return "Grants 15% chance per round of cleansing poisons/drugs from your body.";
			break;
		case "Channeling":
			return "Increases base spell strength by 50%.";
			break;
		case "Agility":
			return "Boosts armor points by a portion of your speed on light/medium armors.";
			break;
		case "Speedy Recovery":
			return "Regain fatigue 50% faster.";
			break;
		case "Regeneration 2":
			return "Gain 2% of max HP per round of combat and 4% of max HP per hour out of combat.";
			break;
		case "Fera's Boon - Seeder":
			return "Increases cum output by 1,000 mLs.";
		case "Fera's Boon - Wide Open":
			return "Keeps your pussy permanently gaped and increases pregnancy speed.";
		case "Fera's Boon - Milking Twat":
			return "Keeps your pussy from ever getting too loose and increases pregnancy speed.";
		case "Spellcasting Affinity":
			return "Reduces spell costs by " + player.perkv1("Spellcasting Affinity") + "%.";
			break;
		case "Tank 2":
			return "+1 extra HP per point of toughness.";
			break;
		case "Weapon Mastery":
			if(player.str > 60) return "Doubles damage bonus of weapons classified as 'Large'.";
			else return "<b>You aren't strong enough to benefit from this anymore.</b>";
			break;
		case "Thunderous Strikes":
			return "+20% 'Attack' damage while strength is at or above 80.";
			break;
		case "Acclimation":
			return "Reduces lust gain by 15%.";
			break;
		case "Double Attack":
			if(player.spe < 50) return "<b>You're too slow to double attack!</b>";
			else if(player.str < 61) return "Allows you to perform two melee attacks per round.";
			else return "<b>You are stronger than double attack allows.  Too choose between reduced strength double-attacks and a single strong attack, access \"Dbl Options\" in the perks menu.</b>";
			break;
		case "Mage":
			return "Increases base spell strength by 50%.";
			break;
		case "Spellpower":
			return "Increases base spell strength by 50%.";
			break;
		case "Nymphomania":
			return "Raises minimum lust by up to 30.";
			break;
		case "Precision":
			return "Reduces enemy armor by 10. (Req's 25+ Intelligence)";
			break;
		case "Seduction":
			return "Upgrades your tease attack, making it more effective.";
			break;
		case "Corrupted Libido":
			return "Reduces lust gain by 10%.";
			break;
		case "Hot Blooded":
			return "Raises minimum lust by up to 20.";
			break;
		case "Fertility+":
			return "Increases fertility rating by 15 and cum volume by up to 50%.";
			break;
		case "Magical Fertility":
			return "10% higher chance of pregnancy and increased pregnancy speed.";
			break;
		case "Magical Virility":
			return "200 mLs more cum per orgasm and enhanced virility.";
			break;
		case "Runner":
			return "Increases chances of escaping combat.";
			break;
		case "Evade":
			return "Increases chances of evading enemy attacks.";
			break;
		case "Regeneration":
			return "Regenerates 2% of max HP/hour and 1% of max HP/round.";
			break;
		case "Iron Man":
			return "Reduces the fatigue cost of physical specials by 50%.";
		case "Tank":
			return "Raises max HP by 50.";
			break;
		case "Strong Back 2: Strong Harder":
			return "Enables fifth item slot."
			break;
		case "Strong Back":
			return "Enables fourth item slot.";
			break;
		case "Tactician":
			if(player.inte >= 50) return "Increases critical hit chance by up to 10% (Intelligence-based).";
			else return "<b>You are too dumb to gain benefit from this perk.</b>";
			break;
		case "Archmage":
			if(player.inte >= 75) return "Increases base spell strength by 50%.";
			else return "<b>You are too dumb to gain benefit from this perk.</b>";
			break;
		case "Lunging Attacks":
			if(player.spe >= 75) return "Grants 50% armor penetration for standard attacks.";
			else return "<b>You are too slow to benefit from this perk.</b>";
			break;
		case "Lightning Strikes":
			if(player.spe >= 60) return "Increases the attack damage for non-heavy weapons.</b>";
			else return "<b>You are too slow to benefit from this perk.</b>";
			break;
		case "Immovable Object":
			if(player.tou >= 75) return "Grants 20% physical damage reduction.</b>";
			else return "<b>You aren't tough enough to benefit from this anymore.</b>";
			break;
		case "Resolute":
			if(player.tou >= 75) return "Grants immunity to stuns and some statuses.</b>";
			else return "<b>You aren't tough enough to benefit from this anymore.</b>";
			break;
		case "Berzerker":
			if(player.str >= 75) return "Grants 'Berzerk' ability.";
			else return "<b>You aren't strong enough to benefit from this anymore.</b>";
			break;
		case "Brutal Blows":
			if(player.str >= 75) return "Reduces enemy armor with each hit.";
			else return "<b>You aren't strong enough to benefit from this anymore.</b>";
			break;
		default:
			return "<u><i>This Perk does not have a stored description.  Please post a bug report on the bug report forums at forum.fenoxo.com.</i></u>";
			break;
	}
	return "broken.";
}
function displayPerks(e:MouseEvent):void {
	temp = 0;
	outputText("", true);
	while(temp < player.perks.length) {
		outputText("<b>" + player.perks[temp].perkName + "</b> - " + perkDescription(player.perks[temp].perkName) + "\n", false);
		temp++;
	}
	menu();
	if(player.perkPoints > 0) {
		outputText("\n<b>You have " + num2Text(player.perkPoints) + " perk point", false);
		if(player.perkPoints > 1) outputText("s", false);
		outputText(" to spend.</b>", false);
		addButton(1,"Perk Up",eventParser,116);
	}
	if(player.hasPerk("Double Attack") >= 0) {
		outputText("\n<b>You can adjust your double attack settings.</b>");
		addButton(2,"Dbl Options",doubleAttackOptions);
	}
	addButton(0,"Next",eventParser,1);
}

function doubleAttackOptions():void {
	clearOutput();
	menu();
	if(flags[DOUBLE_ATTACK_STYLE] == 0) {
		outputText("You will currently always double attack in combat.  If your strength exceeds sixty, your double-attacks will be done at sixty strength in order to double-attack.");
		outputText("\n\nYou can change it to double attack until sixty strength and then dynamicly switch to single attacks.");
		outputText("\nYou can change it to always single attack.");
		addButton(1,"Dynamic",doubleAttackDynamic);
		addButton(2,"Single",doubleAttackOff);
	}
	else if(flags[DOUBLE_ATTACK_STYLE] == 1) {
		outputText("You will currently double attack until your strength exceeds sixty, and then single attack.");
		outputText("\n\nYou can choose to force double attacks at reduced strength (when over sixty, it makes attacks at a strength of sixty.");
		outputText("\nYou can change it to always single attack.");
		addButton(0,"All Double",doubleAttackForce);
		addButton(2,"Single",doubleAttackOff);
	}
	else {
		outputText("You will always single attack your foes in combat.");
		outputText("\n\nYou can choose to force double attacks at reduced strength (when over sixty, it makes attacks at a strength of sixty.");
		outputText("\nYou can change it to double attack until sixty strength and then switch to single attacks.");
		addButton(0,"All Double",doubleAttackForce);
		addButton(1,"Dynamic",doubleAttackDynamic);
	}
	var e:MouseEvent
	addButton(4,"Back",displayPerks,e);
}

function doubleAttackForce():void {
	flags[DOUBLE_ATTACK_STYLE] = 0;
	doubleAttackOptions();
}
function doubleAttackDynamic():void {
	flags[DOUBLE_ATTACK_STYLE] = 1;
	doubleAttackOptions();
}
function doubleAttackOff():void {
	flags[DOUBLE_ATTACK_STYLE] = 2;
	doubleAttackOptions();
}

function levelUpGo(e:MouseEvent):void {
	hideMenus();
	newGameText.visible = false;
	newGameBG.visible = false;
	//Level up
	if(player.XP >= (player.level) * 100) {
		player.level++;
		player.perkPoints++;
		outputText("<b>You are now level " + player.level + "!</b>\n\nYou may now apply +5 to one attribute.  Which will you choose?", true);
		player.XP -= (player.level-1) * 100;
		simpleChoices("Strength", 44, "Toughness", 45, "Speed", 47, "Intelligence", 46, "", 0);		
	}
	//Spend perk points
	else if(player.perkPoints > 0) {
		perkBuyMenu();
	}
	else {
		outputText("<b>ERROR.  LEVEL UP PUSHED WHEN PC CANNOT LEVEL OR GAIN PERKS.  PLEASE REPORT THE STEPS TO REPRODUCE THIS BUG TO FENOXO@GMAIL.COM OR THE FENOXO.COM BUG REPORT FORUM.</b>", true);
		doNext(1);
	}
	/*OLD LEVEL UP CODE
	player.level++;
	levelText2.visible = false;
	levelBG.visible = false;
	dataText.visible = false;
	dataBG.visible = false;
	perksText.visible = false;
	perksBG.visible = false;
	appearanceText.visible = false;
	appearanceBG.visible = false;
	statsBG.visible = false;
	statsText.visible = false;
	outputText("<b>You are now level " + player.level + "!</b>\n\nYou may now apply +5 to one attribute.  Which will you choose?", true);
	player.XP -= (player.level-1) * 100;
	simpleChoices("Strength", 44, "Toughness", 45, "Speed", 47, "Intelligence", 46, "", 0);
	*/
}

function perkBuyMenu():void {
	outputText("", true);
	buildPerkList();
	if(perkList.length == 0) {
		outputText("<b>You do not qualify for any perks at present.  </b>In case you qualify for any in the future, you will keep your " + num2Text(player.perkPoints) + " perk point", false);
		if(player.perkPoints > 1) outputText("s", false);
		outputText(".", false);
		doNext(115);
		return;
	}
	outputText("Please select a perk from the drop-down list, then click 'Okay'.  You can press 'Skip' to save your perk point for later.\n\n", false);
	aCb.move(210, 108);
	aCb.visible = true;
	newGameText.visible = false;
	newGameBG.visible = false;
	simpleChoices("Okay",0,"Skip",115,"",0,"",0,"",0);
}
function buildPerkList():void {
	perkList = new Array();
	//STRENGTH PERKS
	if(player.hasPerk("Strong Back") < 0 && player.str >= 25) {
		perkList[perkList.length] = {label:"Strong Back"};
	}
	if(player.hasPerk("Strong Back") >= 0 && player.hasPerk("Strong Back 2: Strong Harder") < 0 && player.str >= 50) {
		perkList[perkList.length] = {label:"Strong Back 2: Strong Harder"};
	}
	//Tier 1 Strength Perks
	if(player.level >= 6) {
		//Thunderous Strikes - +20% basic attack damage while str > 80.
		if(player.hasPerk("Thunderous Strikes") < 0 && player.str >= 80) {
			perkList[perkList.length] = {label:"Thunderous Strikes"};
		}
		//Weapon Mastery - Doubles weapon damage bonus of 'large' type weapons. (Minotaur Axe, M. Hammer, etc)
		if(player.hasPerk("Weapon Mastery") < 0 && player.str > 60) {
			perkList[perkList.length] = {label:"Weapon Mastery"};
		}
		if(player.hasPerk("Brutal Blows") < 0 && player.str >= 75)
			perkList[perkList.length] = {label:"Brutal Blows"}
	}
	//Tier 2 Strength Perks
	if(player.level >= 12) {
		if(player.hasPerk("Berzerker") < 0 && player.str >= 75)
			perkList[perkList.length] = {label:"Berzerker"};
	}
	//slot 2 - toughness perk 1
	if(player.hasPerk("Tank") < 0 && player.tou >= 25) {
		perkList[perkList.length] = {label:"Tank"};
	}
	//slot 2 - regeneration perk
	if(player.hasPerk("Tank") >= 0 && player.hasPerk("Regeneration") < 0 && player.tou >= 50) {
		perkList[perkList.length] = {label:"Regeneration"};
	}
	//Tier 1 Toughness Perks
		if(player.level >= 6) {
		if(player.hasPerk("Tank 2") < 0 && player.hasPerk("Tank") >= 0 && player.tou >= 60) {
			perkList[perkList.length] = {label:"Tank 2"};
		}
		if(player.hasPerk("Regeneration 2") < 0 && player.hasPerk("Regeneration") >= 0 && player.tou >= 70) {
			perkList[perkList.length] = {label:"Regeneration 2"};
		}
		if(player.hasPerk("Immovable Object") < 0 && player.tou >= 75) {
			perkList[perkList.length] = {label:"Immovable Object"};
		}
	}
	//Tier 2 Toughness Perks
	if(player.level >= 12) {
		if(player.hasPerk("Resolute") < 0 && player.tou >= 75) {
			perkList[perkList.length] = {label:"Resolute"};
		}
		if(player.hasPerk("Iron Man") < 0 && player.tou >= 60) {
			perkList[perkList.length] = {label:"Iron Man"};
		}
	}
	//slot 3 - speed perk
	if(player.hasPerk("Evade") < 0 && player.spe >= 25) {
			perkList[perkList.length] = {label:"Evade"};
	}
	//slot 3 - run perk
	if(player.hasPerk("Runner") < 0 && player.spe >= 25) {
			perkList[perkList.length] = {label:"Runner"};
	}
	//slot 3 - Double Attack perk
	if(player.hasPerk("Evade") >= 0 && player.hasPerk("Runner") >= 0 && player.hasPerk("Double Attack") < 0 && player.spe >= 50) {
			perkList[perkList.length] = {label:"Double Attack"};
	}
	//Tier 1 Speed Perks
	if(player.level >= 6) {
		//Speedy Recovery - Regain Fatigue 50% faster speed.
		if(player.hasPerk("Evade") >= 0 && player.hasPerk("Speedy Recovery") < 0 && player.spe >= 60) {
			perkList[perkList.length] = {label:"Speedy Recovery"};
		}
		//Agility - A small portion of your speed is applied to your defense rating when wearing light armors.
		if(player.spe > 75 && player.hasPerk("Agility") < 0 && player.hasPerk("Runner") >= 0 && (player.armorPerk == "Light" || player.armorPerk == "Medium")) {
			perkList[perkList.length] = {label:"Agility"};
		}
		if(player.hasPerk("Lightning Strikes") < 0 && player.spe >= 60) {
			perkList[perkList.length] = {label:"Lightning Strikes"};
		}
	}
	//Tier 2 Speed Perks
	if(player.level >= 12) {
		if(player.hasPerk("Lunging Attacks") < 0 && player.spe >= 75) {
			perkList[perkList.length] = {label:"Lunging Attacks"};
		}
	}
	//Slot 4 - precision - -10 enemy toughness for damage calc
	if(player.hasPerk("Precision") < 0 && player.inte >= 25) {
			perkList[perkList.length] = {label:"Precision"};
	}
	//Spellpower - boosts spell power
	if(player.hasPerk("Spellpower") < 0 && player.inte >= 50) {
			perkList[perkList.length] = {label:"Spellpower"};
	}
	if(player.hasPerk("Spellpower") >= 0 && player.hasPerk("Mage") < 0 && player.inte >= 50) {
			perkList[perkList.length] = {label:"Mage"};
	}
	//Tier 1 Intelligence Perks
	if(player.level >= 6) {
		if(player.hasPerk("Tactician") < 0 && player.inte >= 50)
			perkList[perkList.length] = {label:"Tactician"};
		if(spellCount() > 0 && player.hasPerk("Channeling") < 0 && player.hasPerk("Spellpower") >= 0 && player.hasPerk("Mage") >= 0 && player.inte >= 60) {
			perkList[perkList.length] = {label:"Channeling"};
		}
		if(player.hasPerk("Medicine") < 0 && player.inte >= 60) {
			perkList[perkList.length] = {label:"Medicine"};
		}
	}
	//Tier 2 Intelligence perks
	if(player.level >= 12) {
		if(player.hasPerk("Mage") >= 0 && player.hasPerk("Archmage") < 0 && player.inte >= 75) {
			perkList[perkList.length] = {label:"Archmage"};
		}
	}
	//LIBIDO PERKZ
	//slot 5 - libido perks
	//Slot 5 - Fertile+ increases cum production and fertility (+15%)
	if(player.hasPerk("Fertility+") < 0 && player.lib >= 25) {
			perkList[perkList.length] = {label:"Fertility+"};
	}
	//Slot 5 - minimum libido
	if(player.hasPerk("Hot Blooded") < 0 && player.lib >= 50) {
			perkList[perkList.length] = {label:"Hot Blooded"};
	}
	//Tier 1 Libido Perks
	if(player.level >= 6) {
		//Slot 5 - minimum libido
		if(player.hasPerk("Well Adjusted") < 0 && player.lib >= 60) {
			perkList[perkList.length] = {label:"Well Adjusted"};
		}
		//Slot 5 - minimum libido
		if(player.hasPerk("Masochist") < 0 && player.lib >= 60 && player.cor >= 50) {
			perkList[perkList.length] = {label:"Masochist"};
		}
	}
	//Corruption Perks - slot 7
	//Slot 7 - Corrupted Libido - lust raises 10% slower.
	if(player.hasPerk("Corrupted Libido") < 0 && player.cor >= 25) {
			perkList[perkList.length] = {label:"Corrupted Libido"};
	}
	//Slot 7 - Seduction (Must have seduced Jojo
	if(player.hasPerk("Seduction") < 0 && player.cor >= 50 && monk >= 5) {
			perkList[perkList.length] = {label:"Seduction"};
	}
	//Slot 7 - Nymphomania
	else if(player.hasPerk("Corrupted Libido") >= 0 && player.cor >= 75 && player.hasPerk("Nymphomania") < 0) {
			perkList[perkList.length] = {label:"Nymphomania"};
	}
	//Slot 7 - UNFINISHED :3
	if(minLust() >= 20 && player.hasPerk("Acclimation") < 0 && player.hasPerk("Corrupted Libido") >= 0 && player.cor >= 50) {
			perkList[perkList.length] = {label:"Acclimation"};
	}
	//Tier 1 Corruption Perks - acclimation over-rides
	else if(player.level >= 6)
	{
		if(player.hasPerk("Sadist") < 0 && player.cor >= 60 && player.hasPerk("Corrupted Libido") >= 0) {
			perkList[perkList.length] = {label:"Sadist"};
		}
		if(player.hasPerk("Arousing Aura") < 0 && player.hasPerk("Corrupted Libido") >= 0 && player.cor >= 70) {
			perkList[perkList.length] = {label:"Arousing Aura"};
		}
	}
	//Tier 1 Misc Perks
	if(player.level >= 6) {
		if(player.hasPerk("Resistance") < 0) {
			perkList[perkList.length] = {label:"Resistance"};
		}
	}
	aCb.dataProvider = new DataProvider(perkList); 
}
function applyPerk(pName:String = ""):void {
	player.perkPoints--;
	//Apply perk here.
	outputText("<b>" + tempPerk + "</b> gained!", true);
	switch(tempPerk) {
		case "Strong Back 2: Strong Harder":
			player.createPerk("Strong Back 2: Strong Harder",0,0,0,0, "Enables fifth item slot.");
			itemSlot5.unlocked = true;
			break;
		case "Strong Back":
			player.createPerk("Strong Back",0,0,0,0, "Enables fourth item slot.");
			itemSlot4.unlocked = true;
			break;
		case "Tank":
			player.createPerk("Tank",0,0,0,0,"Raises max HP by 50.");
			break;
		case "Regeneration":
			player.createPerk("Regeneration",0,0,0,0,"Regenerates 2% of max HP/hour and 1% of max HP/round.");
			break;
		case "Iron Man":
			player.createPerk("Iron Man",0,0,0,0,"Now now, don't cheat.");
			break;
		case "Evade":
			player.createPerk("Evade",0,0,0,0,"Increases avoidance chances.");
			break;
		case "Runner":
			player.createPerk("Runner",0,0,0,0,"Increases chances of escaping combat.");
			break;
		case "Fertility+":
			player.createPerk("Fertility+",15,1.75,0,0,"Increases pregnancy chance by 15% and cum volume by up to 50%.");
			break;
		case "Hot Blooded":
			player.createPerk("Hot Blooded",20,0,0,0, "Raises minimum lust by up to 20.");
			break;
		case "Corrupted Libido":
			player.createPerk("Corrupted Libido",20,0,0,0, "Reduces lust gain by 10%.");
			break;
		case "Seduction":
			player.createPerk("Seduction",0,0,0,0,"Upgrades your tease attack, making it more effective.");
			break;
		case "Precision":
			player.createPerk("Precision",0,0,0,0,"Reduces enemy damage resistance by 10.");
			break;
		case "Nymphomania":
			player.createPerk("Nymphomania",0,0,0,0,"Raises minimum lust by up to 30.");
			break;
		case "Spellpower":
			player.createPerk("Spellpower",0,0,0,0,"Increases the effects of your spells by up to 50%.");
			break;
		case "Mage":
			player.createPerk("Mage",0,0,0,0,"Increases the strength of your spells even more than 'Spellpower', up to 100%.");
			break;
		case "Double Attack":
			player.createPerk("Double Attack",0,0,0,0,"Allows you to perform two melee attacks per round.");
			break;
		case "Acclimation":
			player.createPerk("Acclimation",0,0,0,0,"Reduces the rate at which your lust increases.");
			break;
		case "Thunderous Strikes":
			player.createPerk("Thunderous Strikes",0,0,0,0,"+20% 'Attack' damage while strength is at or above 80.");
			break;
		case "Weapon Mastery":
			player.createPerk("Weapon Mastery",0,0,0,0,"After getting so good at carrying large objects, you find large weapons much easier to handle (Double 'Large' weapon bonuses when equipped).");
			if(player.weaponPerk == "Large") player.weaponAttack *= 2;
			break;
		case "Tank 2":
			player.createPerk("Tank 2",0,0,0,0,"Your maximum HP is raised by an extra 1 point per point of toughness!");
			HPChange(player.tou, false);
			statScreenRefresh();
			break;
		case "Regeneration 2":
			player.createPerk("Regeneration 2",0,0,0,0,"You regenerate an additional 2% of max HP per round and heal faster out of combat (4% of max HP/hour)");
			break;
		case "Speedy Recovery":
			player.createPerk("Speedy Recovery",0,0,0,0,"Thanks to your impressive metabolism you regain fatigue 50% faster.");
			break;
		case "Agility":
			player.createPerk("Agility",0,0,0,0,"When wearing light or medium armor its effectiveness is increased by a portion of your speed.");
			if(player.armorPerk == "Light") player.armorDef += Math.round(player.spe/10);
			else if(player.armorPerk == "Medium") player.armorDef += Math.round(player.spe/15);
			break;
		case "Channeling":
			player.createPerk("Channeling",0,0,0,0,"You've gotten even better at spellcasting, gaining up to 50% more effectiveness!");
			break;
		case "Medicine":
			player.createPerk("Medicine",0,0,0,0,"You now have a 15% chance per round of cleansing poisons/drugs from your body.");
			break;
		case "Well Adjusted":
			player.createPerk("Well Adjusted",0,0,0,0,"You gain half as much lust as time passes in Mareth.");
			break;
		case "Masochist":
			player.createPerk("Masochist",0,0,0,0,"You have a masochism fetish and take 30 percent less damage, but your lust goes up when struck (Requires 60+ Libido).");
			break;
		case "Sadist":
			player.createPerk("Sadist",0,0,0,0,"You have a sadism fetish and strike harder, but become aroused by the act of dealing damage.");
			break;
		case "Arousing Aura":
			player.createPerk("Arousing Aura",0,0,0,0,"While your corruption is at or above 70, you exude an aura of lust.");
			break;
		case "Resistance":
			player.createPerk("Resistance",0,0,0,0,"You've become resistant to the myriad ways your lust can be increased.");
			break;
		case "Tactician":
			player.createPerk("Tactician",0,0,0,0,"");
			break;
		case "Archmage":
			player.createPerk("Archmage",0,0,0,0,"");
			break;
		case "Lunging Attacks":
			player.createPerk("Lunging Attacks",0,0,0,0,"");
			break;
		case "Lightning Strikes":
			player.createPerk("Lightning Strikes",0,0,0,0,"");
			break;
		case "Immovable Object":
			player.createPerk("Immovable Object",0,0,0,0,"");
			break;
		case "Resolute":
			player.createPerk("Resolute",0,0,0,0,"");
			break;
		case "Berzerker":
			player.createPerk("Berzerker",0,0,0,0,"");
			break;
		case "Brutal Blows":
			player.createPerk("Brutal Blows",0,0,0,0,"");
			break;
		default:
			outputText("\n\n<b>AN ERROR HAS OCCURRED: </b>Invalid tempPerk value!", false);
			player.perkPoints++;
			break;
	}
	doNext(1);
}
function buttonOn( e:MouseEvent)
{
/*    var transformer = new Transform(e.target.name);
    var colorTransformer:ColorTransform = transformer.colorTransform;
    /*colorTransformer.redMultiplier = redmul == undefined ? 1 : redmul;
    colorTransformer.greenMultiplier = greenmul == undefined ? 1 : greenmul;
    colorTransformer.alphaMultiplier = alphamul == undefined ? 1 : alphamul;
    colorTransformer.redOffset = red;
    colorTransformer.greenOffset = green;
    colorTransformer.alphaOffset = alphao == undefined ? 0 : alphao;
	*/
//    colorTransformer.blueMultiplier = 1.5;
//	colorTransformer.blueOffset = 5;
//    transformer.colorTransform = colorTransformer;
	if(e.target.name == "newGameText") newGameBG.alpha = .5;
	if(e.target.name == "appearanceText") appearanceBG.alpha = .5;
	if(e.target.name == "perksText") perksBG.alpha = .5;
	if(e.target.name == "dataText") dataBG.alpha = .5;
	if(e.target.name == "levelText2") levelBG.alpha = .5;
	if(e.target.name == "b1Text") gButtons[0].alpha = .5;
	if(e.target.name == "b2Text") gButtons[1].alpha = .5;
	if(e.target.name == "b3Text") gButtons[2].alpha= .5;
	if(e.target.name == "b4Text") gButtons[3].alpha = .5;
	if(e.target.name == "b5Text") gButtons[4].alpha = .5;
	if(e.target.name == "b6Text") gButtons[5].alpha = .5;
	if(e.target.name == "b7Text") gButtons[6].alpha = .5;
	if(e.target.name == "b8Text") gButtons[7].alpha = .5;
	if(e.target.name == "b9Text") gButtons[8].alpha = .5;
	if(e.target.name == "b0Text") gButtons[9].alpha = .5;
	if(e.target.name == "statsText") statsBG.alpha = .5;
	mouseOverTextin(e, buttonText(e.target.name));
	//e.target.alpha = .5;
}

function buttonOff(e:MouseEvent)
{
//    var transformer = new Transform(DisplayObject(e.target.name));
//    var colorTransformer:ColorTransform = transformer.colorTransform;
    /*colorTransformer.redMultiplier = redmul == undefined ? 1 : redmul;
    colorTransformer.greenMultiplier = greenmul == undefined ? 1 : greenmul;
    colorTransformer.blueMultiplier = bluemul == undefined ? 1 : bluemul;
    colorTransformer.alphaMultiplier = alphamul == undefined ? 1 : alphamul;
    colorTransformer.redOffset = red;
    colorTransformer.greenOffset = green;
    colorTransformer.blueOffset = blue;
    colorTransformer.alphaOffset = alphao == undefined ? 0 : alphao;
	*/
//    transformer.colorTransform = colorTransformer;
	if(e.target.name == "newGameText") newGameBG.alpha = 1;
	if(e.target.name == "appearanceText") appearanceBG.alpha = 1;
	if(e.target.name == "perksText") perksBG.alpha = 1;
	if(e.target.name == "dataText") dataBG.alpha = 1;
	if(e.target.name == "levelText2") levelBG.alpha = 1;
	if(e.target.name == "b1Text") gButtons[0].alpha = 1;
	if(e.target.name == "b2Text") gButtons[1].alpha = 1;
	if(e.target.name == "b3Text") gButtons[2].alpha = 1;
	if(e.target.name == "b4Text") gButtons[3].alpha = 1;
	if(e.target.name == "b5Text") gButtons[4].alpha = 1;
	if(e.target.name == "b6Text") gButtons[5].alpha = 1;
	if(e.target.name == "b7Text") gButtons[6].alpha = 1;
	if(e.target.name == "b8Text") gButtons[7].alpha = 1;
	if(e.target.name == "b9Text") gButtons[8].alpha = 1;
	if(e.target.name == "b0Text") gButtons[9].alpha = 1;
	if(e.target.name == "statsText") statsBG.alpha = 1;
	//Clear mouseover space
	mouseOverText.visible = false;
	popUpBG.visible = false;
	e.target.alpha = 1;
}
function buttonText(buttonName:String):String {
	if(buttonName == "buttons[0]") return b1Text.text;
	if(buttonName == "b1Text") return b1Text.text;
	if(buttonName == "buttons[1]") return b2Text.text;
	if(buttonName == "b2Text") return b2Text.text;
	if(buttonName == "buttons[2]") return b3Text.text;
	if(buttonName == "b3Text") return b3Text.text;
	if(buttonName == "buttons[3]") return b4Text.text;
	if(buttonName == "b4Text") return b4Text.text;
	if(buttonName == "buttons[4]") return b5Text.text;
	if(buttonName == "b5Text") return b5Text.text;
	if(buttonName == "buttons[5]") return b6Text.text;
	if(buttonName == "b6Text") return b6Text.text;
	if(buttonName == "buttons[6]") return b7Text.text;
	if(buttonName == "b7Text") return b7Text.text;
	if(buttonName == "buttons[7]") return b8Text.text;
	if(buttonName == "b8Text") return b8Text.text;	
	if(buttonName == "buttons[8]") return b9Text.text;
	if(buttonName == "b9Text") return b9Text.text;
	if(buttonName == "buttons[9]") return b0Text.text;
	if(buttonName == "b0Text") return b0Text.text;	
	return "NULL";
}
function mouseOverTextin(e:MouseEvent, texts:String)
{
	//Perkzzz
	if(texts.indexOf("Strong Back") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Strong Back perk unlocks an additional inventory space, allowing you to carry more.";
		return;
	}
	if(texts.indexOf("StrongBack2") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Strong Back 2 perk unlocks a fifth inventory location, allowing you to carry as much as possible.";
		return;
	}
	if(texts.indexOf("T.Strikes") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "You've gotten so good at putting your sizable strength behind your attacks that you deal 20% more damage with standard attacks while strength is 80 or higher.";
		return;
	}
	if(texts.indexOf("W.Mastery") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "After getting so good at carrying large objects, you find large weapons much easier to handle (Double 'Large' weapon bonuses when equipped).";
		return;
	}
	if(texts.indexOf("Tank 2") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Tank 2 raises your maximum HP by an additional 1 HP per point of toughness.";
		return;
	}
	if(texts.indexOf("Tank") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Tank perk adds an additional 50 HP to your maximum hitpoints, allowing you take more damage before losing a fight.";
		return;
	}
	if(texts.indexOf("Regenerate") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Regeneration perk makes your hit points come back faster, both in and out of combat.  In combat you gain 1 HP a round, outside of combat you'll get 2 HP an hour.";
		return;
	}
	if(texts.indexOf("Regen 2") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Regeneration 2 perk quadruples the effectiveness of your regeneration.";
		return;
	}
	if(texts.indexOf("Evade") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Evade perk gives you an additional 10% chance to avoid enemy attacks beyond the normal dodge chance.";
		return;
	}
	if(texts.indexOf("Agility") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The agility perk allows you to increase your armor defense by a portion of your speed when wearing light or medium armor.";
		return;
	}
	if(texts.indexOf("S.Recovery") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The speedy recovery perk increases the rate at which you regain fatigue.";
		return;
	}
	if(texts.indexOf("D.Attack") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Double Attack perk lets you take advantage of your incredible speed to attack twice in one round.  Requires high speed and strength at or below 60.";
		return;
	}
	if(texts.indexOf("Spellpower") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Spellpower perk increases the effects of your spells by up to 50% (dependant on the spell).";
		return;
	}
	if(texts.indexOf("Mage") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Mage perk increases the effects of your spells by up to 100% (dependant on the spell).";
		return;
	}
	if(texts.indexOf("Channeling") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The channeling perk increases the spell bonus by up to an additional 50%.";
		return;
	}
	if(texts.indexOf("Medicine") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The medicine perk gives you a 15% chance per round of removing all non-biological poisons in combat.";
		return;
	}
	if(texts.indexOf("Runner") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Runner perk increases your chances of escaping combat significantly, and may help with out of combat escapes as well.";
		return;
	}
	if(texts.indexOf("Fertility+") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Fertility+ perk increases your pregnancy chance by 15% and also increases any cum production by 50 percent!";
		return;
	}
	if(texts.indexOf("Hot Blooded") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Hot Blooded perk takes advantage of your enhanced libido, allowing your lust to never drop below 20.";
		return;
	}
	if(texts.indexOf("W.Adjusted") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Well Adjusted perk halves the lust you gain over time in Mareth.";
		return;
	}
	if(texts.indexOf("Masochist") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Masochism perk reduces damage taken by 30 percent but raises your lust from each hit.";
		return;
	}
	if(texts.indexOf("CorruptLibido") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Corrupted Libido perk lets you use your corruption to adapt to your heightened libido, making lust rise 10 percent slower.";
		return;
	}
	if(texts.indexOf("Seduction") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Seduction perk enhances your ability to tease and seduce, upgrading your tease attack significantly.";
		return;
	}
	if(texts.indexOf("Acclimation") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Acclimation perk allows your highly corrupted form to adapt to the constant lust it's subjected to, slowing additional lust gain.";
		return;
	}
	if(texts.indexOf("A. Aura") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Arousing Aura perk causes you to exude a lust-inducing aura whenever your corruption is 70 or above.";
		return;
	}
	if(texts.indexOf("Sadist") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Sadist perk increases the damage you do with some physical attacks by 20% but causes you to gain lust from it.";
		return;
	}
	if(texts.indexOf("Resistance") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Resistance perk gives you an additional reduction to lust gains.";
		return;
	}
	if(texts.indexOf("Precision") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Precision perk allows you to strike an enemy's weak points, reducing damage resistance by 10.  Requires you to keep intelligence above 25, or you'll lose the benefits of this perk.";
		return;
	}
	if(texts.indexOf("Nymphomania") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Nymphomania perk allows your corruption to have it's way with your lust, keeping you constantly aroused.  Your lust will never drop below 30 with this perk.";
		return;
	}
	//Items
	if(texts.indexOf("MinoBlo") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "You've got a scratched up looking vial full of bright red minotaur blood.  Any time you move it around it seems to froth up, as if eager to escape.";
		return;
	}
	if(texts.indexOf("GroPlus") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is a small needle with a resevoir full of blue liquid.  A faded label marks it as 'GroPlus'.  Its purpose seems obvious.";
		return;
	}
	if(texts.indexOf("ImpFood") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is a small parcel of reddish-brown bread stuffed with some kind of meat.  It smells delicious.";
		return;
	}
	if(texts.indexOf("Shark.T") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A glinting white tooth, very sharp and intimidating.";
		return;
	}
	if(texts.indexOf("ExtSerm") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is a bottle of foamy pink liquid, purported by the label to increase the speed at which the user's hair grows.";
		return;
	}
	if(texts.indexOf("ProBova") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This cloudy potion has been enhanced by the alchemist Lumi to imbue its drinker with cow-like attributes.";
		return;
	}
	if(texts.indexOf("MinoCum") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This bottle of minotaur cum looks thick and viscous.  You know it has narcotic properties, but aside from that its effects are relatively unknown.";
		return;
	}
	if(texts.indexOf("PurPeac") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is a peach from Minerva's spring, yellowy-orange with red stripes all over it.";
		return;
	}
	if(texts.indexOf("MouseCo") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A handful of rare aromatic beans with sharp creases in the middle, making them look like small mouse ears.  Allegedly very popular and plentiful before the mice-folk were wiped out.";
		return;
	}
	if(texts.indexOf("RingFig") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A dried fig with two lobes and thin dark rings just below its stem.  The skin is wrinkly and it looks vaguely like a bulging scrotum.";
		return;
	}
	if(texts.indexOf("Equinum") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is a long flared vial with a small label that reads, \"<i>Equinum</i>\".  It is likely this potion is tied to horses in some way.";
		return;
	}
	if(texts.indexOf("PrFruit") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This sweet-smelling produce looks like an eggplant, but feels almost squishy, and rubbery to the touch. Holding it to your ear, you think you can hear some fluid sloshing around inside.";
		return;
	}
	if(texts.indexOf("TrapOil") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A round, opaque glass vial filled with a clear, viscous fluid.  It has a symbol inscribed on it, a circle with a cross and arrow pointing out of it in opposite directions.  It looks and smells entirely innocuous.";
		return;
	}
	if(texts.indexOf("FishFil") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A perfectly cooked piece of fish.  You're not sure what type of fish is, since you're fairly certain \"delicious\" is not a valid species.";
		return;
	}
	if(texts.indexOf("Debimbo") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		if(player.hasPerk("Bimbo Brains") >= 0 || player.hasPerk("Futa Faculties") >= 0) mouseOverText.htmlText = "This should totally like, fix your brain and stuff.  You don't really think anything is wrong with your head - it feels all pink and giggly all the time.";
		else mouseOverText.htmlText = "This draft is concocted from five scholar's teas and who knows what else.  Supposedly it will correct the stupifying effects of Bimbo Liqueur.";
		return;
	}
	if(texts.indexOf("FoxJewl") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A shining teardrop-shaped jewel.  An eerie blue flame dances beneath the surface.";
		return;
	}
	if(texts.indexOf("MystJwl") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The flames within this jewel glow brighter than before, and have taken on a sinister purple hue.  It has been enhanced to increase its potency, allowing it to transform you more easily, but may have odd side-effects...";
		return;
	}
	if(texts.indexOf("KitGift") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A small square package given to you by a forest kitsune.  It is wrapped up in plain white paper and tied with a string.  Who knows what's inside?";
		return;
	}
	if(texts.indexOf("GldStat") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "An intricate golden idol of an androgynous humanoid figure with nine long tails.  It probably had some spiritual significance to its owner.";
		return;
	}
	if(texts.indexOf("DrgnEgg") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A large, solid egg, easily the size of your clenched fist.  Its shell color is reddish-white, with blue splotches.";
		return;
	}
	if(texts.indexOf("DrgnShl") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A durable shield that has been forged from the remains of the dragon egg you found in the swamp. Absorbs any fluid attacks you can catch, rendering them useless.";
		return;
	}
	if(texts.indexOf("SheepMk") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This bottle of sheep milk is said to have corruption-fighting properties.  It may be useful.";
		return;
	}
	if(texts.indexOf("E.Staff") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This eldritch staff once belonged to the Harpy Queen, who was killed after her defeat at your hands.  It fairly sizzles with magical power.";
		return;
	}
	if(texts.indexOf("FoxBery") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This large orange berry is heavy in your hands.  It may have gotten its name from its bright orange coloration.  You're certain it is no mere fruit.";
		return;
	}
	if(texts.indexOf("FoxBery") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This large orange berry is heavy in your hands.  It may have gotten its name from its bright orange coloration.  You're certain it is no mere fruit.";
		return;
	}
	if(texts.indexOf("VixVigr") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This small medicine bottle contains something called \"Vixen's Vigor\", supposedly distilled from common fox-berries.  It is supposed to be a great deal more potent, and a small warning label warns of \"extra boobs\", whatever that means.";
		return;
	}
	if(texts.indexOf("BC Beer") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A capped mug containing an alcoholic drink secreted from the breasts of Niamh.  It smells tasty.";
		return;
	}
	if(texts.indexOf("I.Robes") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "These foreboding red and gold robes are embroidered with the symbols of a lost kingdom.  Wearing them will cause spells to tax your health instead of exhausting you.";
		return;
	}
	if(texts.indexOf("I.Corst") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This sexualized and feminine red and gold ensemble carries with it the hopes of a shamed sorcerer.  Wearing it will cause spells to tax your health instead of exhausting you.";
		return;
	}
	if(texts.indexOf("S.Blade") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Forged not by a swordsmith but a sorceress, this arcane-infused blade amplifies your magic.  Unlike the wizard staves it is based on, this weapon also has a sharp edge, a technological innovation which has proven historically useful in battle.";
		return;
	}
	if(texts.indexOf("DryTent") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A dried tentacle from one of the lake anemones.  It's probably edible, but the stingers are still a little active.";
		return;
	}
	if(texts.indexOf("IzyMilk") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is a bottle of Isabella's milk.  Isabella seems fairly certain it will invigorate you.";
		return;
	}
	if(texts.indexOf("EctoPls") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The green-tinted, hardly corporeal substance flows like a liquid inside its container. It makes you feel... uncomfortable, as you observe it.";
		return;
	}
	if(texts.indexOf("T.SSilk") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This bundle of fibrous silk is incredibly tough and strong, though somehow not sticky in the slightest.  You have no idea how to work these tough little strands into anything usable.  Perhaps one of this land's natives might have an idea?";
		return;
	}
	if(texts.indexOf("SS.Robe") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This robe looks incredibly comfortable.  It's made from alchemically enhanced spider-silk, and embroidered with what looks like magical glyphs around the sleeves and hood.";
		return;
	}
	if(texts.indexOf("SSArmor") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This armor is as white as the driven snow.  It's crafted out of thousands of strands of spider-silk into an impenetrable protective suit.  The surface is slightly spongy, but so tough you wager most blows would bounce right off.";
		return;
	}
	if(texts.indexOf("S.Gossr") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "These strands of gooey pink gossamer seem quite unlike the normal silk that spider-morphs produce.  It smells sweet and is clearly edible, but who knows what it might do to you?";
		return;
	}
	if(texts.indexOf("B.Gossr") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "These strands of gooey black gossamer seem quite unlike the normal silk that driders produce.  It smells sweet and is clearly edible, but who knows what it might do to you?";
		return;
	}
	if(texts.indexOf("TSTooth") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This looks like a normal shark tooth, though with an odd purple glow.";
		return;
	}
	

	if(texts.indexOf("KangaFt") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A yellow, fibrous, tubular pod.  A split in the end reveals many lumpy, small seeds inside.  The smell of mild fermentation wafts from them.";
		return;
	}
	if(texts.indexOf("MghtyVg") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A yellow, fibrous, tubular pod.  A split in the end reveals many lumpy, small seeds inside.  The smell of mild fermentation wafts from them.  It glows slightly from Lumi's enhancements.";
		return;
	}
	if(texts.indexOf("GldSeed") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This seed looks and smells absolutely delicious.  Though it has an unusual color, the harpies prize these nuts as delicious treats.  Eating one might induce some physical transformations.";
		return;
	}
	if(texts.indexOf("MagSeed") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This seed glows with power.  It's been enhanced by Lumi to unlock its full potential, allowing it to transform you more easily.";
		return;
	}
	if(texts.indexOf("R.BdySt") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A high society bodysuit. It is as easy to mistake it for ballroom apparel as it is for boudoir lingerie. The thin transparent fabric is so light and airy that it makes avoiding blows a second nature.";
		return;
	}
	if(texts.indexOf("BroBrew") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This aluminum can is labelled as 'Bro Brew'.  It even has a picture of a muscly, bare-chested man flexing on it.  A small label in the corner displays: \"Demon General's Warning: Bro Brew's effects are as potent (and irreversible) as they are refreshing.\"";
		return;
	}
	if(texts.indexOf("BimboLq") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This small bottle of liqueur is labelled 'Bimbo Liqueur'.  There's a HUGE warning label about the effects being strong and usually permanent, so you should handle this with care.";
		return;
	}	
	if(texts.indexOf("H.Gaunt") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "These metal gauntlets are covered in nasty looking hooks that are sure to tear at your foes flesh and cause them harm.";
		return;
	}
	if(texts.indexOf("SensDrf") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This carefully labelled potion is a 'Sensitivity Draft', and if the diagrams are any indication, it will make your body more sensitive.";
		return;
	}
	if(texts.indexOf("NumbRox") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This packet of innocuous looking 'candy' guarantees to reduce troublesome sensations and taste delicious.";
		return;
	}
	if(texts.indexOf("BonStrp") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "These leather straps and well-placed hooks are actually designed in such a way as to be worn as clothing.  While they technically would cover your naughty bits, virtually every other inch of your body would be exposed.";
		return;
	}
	if(texts.indexOf("NurseCl") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This borderline obscene nurse's outfit would barely cover your hips and crotch.  The midriff is totally exposed, and the white top leaves plenty of room for cleavage.  A tiny white hat tops off the whole ensemble.";
		return;
	}
	if(texts.indexOf("GooArmr") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This shining suit of platemail is more than just platemail - it houses the goo-girl, Valeria!  Together, they provide one tough defense, but you had better be okay with having goo handling your junk while you fight if you wear this!";
		return;
	}
	if(texts.indexOf("LMArmor") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This skimpy chain bikini barely qualifies as armor.  Indeed, the chain is made from links much finer and lighter than normal, so fine that it feels almost silken under your fingertips.  A simple seal in the g-string-like undergarment states, \"Virgins only.\"";
		return;
	}
	if(texts.indexOf("JRapier") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This jeweled rapier is ancient but untarnished.  The hilt is wonderfully made, and fits your hand like a tailored glove.  The blade is shiny and perfectly designed for stabbing.";
		return;
	}
	if(texts.indexOf("RRapier") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "He's bound it with his red sash around the length like a ribbon, as though he has now gifted it to you.  Perhaps it is his way of congratulating you.";
		return;
	}
	if(texts.indexOf("SucWhip") != -1 || texts.indexOf("Demon Whip") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This coiled length of midnight-black leather practically exudes lust.  Though it looks like it could do a lot of damage, the feel of that slick leather impacting flesh is sure to inspire lust.";
		return;
	}
	if(texts.indexOf("Reptlum") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is a rounded bottle with a small label that reads, \"<i>Reptilum</i>\".  It is likely this potion is tied to reptiles in some way.";
		return;
	}
	if(texts.indexOf("W.Fruit") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This small, peach-sized fruit has tiny whisker-like protrusions growing from the sides.";
		return;
	}
	
	if(texts.indexOf("Gob.Ale") != -1 || texts == "GoblinAle") {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This sealed flagon of 'Goblin Ale' sloshes noisily with alcoholic brew.  Judging by the markings on the flagon, it's a VERY strong drink, and not to be trifled with.";
		return;
	}
	//"Hummus "
	if(texts.indexOf("Hummus ") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This pile of hummus doesn't look that clean, and you really don't remember where you got it from.  It looks bland.  So bland that you feel blander just by looking at it.";
		return;
	}
	
	if(texts.indexOf("LthrRob") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is a suit of flexible leather armor with a voluminous set of concealing black robes.";
		return;
	}
	if(texts.indexOf("ScaleMl") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This suit of scale-mail covers the entire body with layered steel scales, providing flexibility and protection.";
		return;
	}
	if(texts.indexOf("FullPlt") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A highly protective suit of steel platemail.  It would be hard to find better physical protection than this.";
		return;
	}
	if(texts.indexOf("BimboSk") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A tight, cleavage-inducing halter top and an extremely short miniskirt.  The sexual allure of this item is undoubtable.";
		return;
	}
	if(texts.indexOf("SeductA") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A complete suit of scalemail shaped to hug tightly against every curve, it has a solid steel chest-plate with obscenely large nipples molded into it.  The armor does nothing to cover the backside, exposing the wearer's cheeks to the world.";
		return;
	}
	if(texts.indexOf("IndecSt") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This suit of steel 'armor' has two round disks that barely cover the nipples, a tight chainmail bikini, and circular butt-plates.";
		return;
	}
	if(texts.indexOf("W.Robes") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "These robes appear to have once belonged to a female wizard.  They're long with a slit up the side and full billowing sleeves.  The top is surprisingly low cut.  Somehow you know wearing it would aid your spellcasting.";
		return;
	}
	if(texts.indexOf("W.Staff") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This staff is made of very old wood and seems to tingle to the touch.  The top has an odd zig-zag shape to it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use. (ATK: 3)";
		return;
	}
	if(texts.indexOf("W. Staff") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "An oddly bent piece of solid wood favored by spell-casters.  It is said to be made of from one of Marae's roots and allow for easier magic use. (ATK: 3) (Cost: 350)";
		return;
	}
	
	if(texts.indexOf("W.Stick") != -1 || texts.indexOf("Wingstick") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A tri-bladed throwing weapon.  Though good for only a single use, it's guaranteed to do high damage if it hits.  (Cost: 16) (DMG: 40-100)";
		return;
	}
	if(texts.indexOf("Claymor") != -1 || texts.indexOf("L.Claymore") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A massive sword that a very strong warrior might use. Requires 40 strength to use.  (ATK: 15) (Cost: 1000)";
		return;
	}
	if(texts.indexOf("Warhamr") != -1 || texts.indexOf("Warhammer") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A huge war-hammer made almost entirely of steel that only the strongest warriors could use.  Requires 80 strength to use.  Getting hit with this might stun the victim.  (ATK: 15) (Cost: 1600)";
		return;
	}
	if(texts.indexOf("Katana ") != -1 || texts.indexOf("Katana") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A curved bladed weapon that cuts through flesh with the greatest of ease. (ATK: 10) (Cost: 500)";
		return;
	}
	if(texts.indexOf("Spear  ") != -1 || texts.indexOf("Spear") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A staff with a sharp blade at the tip designed to pierce through the toughest armor.  This would ignore most armors.  (ATK: 8) (Cost: 450)";
		return;
	}
	if(texts.indexOf("Tail Whip") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Whip your foe with your tail to enrage them and lower their defense!";
		return;
	}
	if(texts.indexOf("Whip   ") != -1 || texts.indexOf("Whip") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A coiled length of leather designed to lash your foes into submission.  There's a chance the bondage inclined might enjoy it! (ATK: 5) (Cost: 500)";
		return;
	}
	if(texts.indexOf("S.Gaunt") != -1 || texts.indexOf("S.Gauntlet") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This single metal gauntlet has the knuckles tipped with metal spikes.  Though it lacks the damaging potential of other weapons, the sheer pain of its wounds has a chance of stunning your opponent. (ATK: 5) (Cost: 400)";
		return;
	}
	
	if(texts.indexOf("FullChn") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This full suit of chainmail armor covers its wearer from head to toe in protective steel rings.";
		return;
	}
	if(texts.indexOf("ChBikni") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A revealing chainmail bikini that barely covers anything.  The bottom half is little more than a triangle of metal and a leather thong.";
		return;
	}
	
	if(texts.indexOf("SnakOil") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A vial the size of your fist made of dark brown glass. It contains what appears to be an oily, yellowish liquid. The odor is abominable.";
		return;
	}
	if(texts.indexOf("L.Daggr") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A dagger with a short blade in a wavy pattern.  Its edge seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.";
		return;
	}
	if(texts.indexOf("KnottyP") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This knotted pepper is very swollen, with a massive, distended knot near the base.";
		return;
	}
	if(texts.indexOf("BulbyPp") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This bulbous pepper has a slightly different shape than the other canine peppers, with two large orb-like protrusions at the base.";
		return;
	}
	if(texts.indexOf("BlackPp") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This solid black canine pepper is smooth and shiny, but something about it doesn't seem quite right...";
		return;
	}
	if(texts.indexOf("DblPepp") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This canine pepper is actually two that have grown together due to some freak coincidence.";
		return;
	}
	if(texts.indexOf("LargePp") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This large canine pepper is much bigger than any normal peppers you've seen.";
		return;
	}
	if(texts.indexOf("WetClth") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Dripping with a viscous slime, you've no doubt rubbing this cloth on your body would have some kind of strange effect.";
		return;
	}
	if(texts.indexOf("B.Chitn") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A perfect piece of black chitin from a bee-girl.  It still has some fuzz on it.";
		return;
	}
	if(texts.indexOf("BeeArmr") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A suit of armor cleverly fashioned from giant bee chitin.";
		return;
	}
	if(texts.indexOf("Vital T") != -1 || texts.indexOf("Vitality T.") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This potent tea is supposedly good for the strengthening the body.";
		return;
	}
	if(texts.indexOf("Smart T") != -1 || texts.indexOf("Scholars T.") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This powerful brew supposedly has mind-strengthening effects.";
		return;
	}
	if(texts.indexOf("L.Hammr") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This two-handed warhammer looks pretty devastating.  You took it from Marble after she refused your advances.";
		return;
	}
	if(texts.indexOf("Dual Belt") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is a strange masturbation device, meant to work every available avenue of stimulation.";
		return;
	}
	if(texts.indexOf("C. Pole") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This 'centaur pole' as it's called appears to be a sex-toy designed for females of the equine persuasion.  Oddly, it's been sculpted to look like a giant imp, with an even bigger horse-cock.";
		return;
	}
	if(texts.indexOf("Fake Mare") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This fake mare is made of metal and wood, but the anatomically correct vagina looks as soft and wet as any female centaur's.";
		return;
	}
	if(texts.indexOf("P.LBova") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A bottle containing a misty fluid with a grainy texture; it has a long neck and a ball-like base.  The label has a stylized picture of a well-endowed cow-girl nursing two guys while they jerk themselves off. It has been purified by Rathazul.";
		return;
	}
	if(texts.indexOf("L.Draft") != -1 || texts == "LustDraft") {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This vial of bright pink fluid bubbles constantly inside the glass, as if eager to escape.  It smells very sweet, and has \"Lust\" inscribed on the side of the vial.";
		return;
	}
	if(texts.indexOf("F.Draft") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This vial of red fluid bubbles constantly inside the glass, as if eager to escape.  It smells very strongly, though its odor is difficult to identify.  The word \"Fuck\" is inscribed on the side of the vial.";
		return;
	}
	if(texts.indexOf("Pipe") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is a simple rusted pipe of unknown origins.  It's hefty and could probably be used as an effective bludgeoning tool. (ATK: +5) (Cost: 25)";
		return;
	}
	if(texts.indexOf("Lactaid") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Judging by the name printed on this bottle, 'Lactaid' probably has an effect on the ability to lactate, and you doubt that effect is a reduction.";
		return;
	}
	if(texts.indexOf("W. Book") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This white book is totally unmarked, and the cover is devoid of any lettering or title.  A shiny brass clasp keeps the covers closed until you are ready to read it.";
		return;
	}
	if(texts.indexOf("B. Book") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This solid black book is totally unmarked, saved for a blood red clasp that holds the covers closed until you are ready to read it.  The pages are edged with gold, like some of the fancy books in the monastary back home.";
		return;
	}
	if(texts.indexOf("LeathrA") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is a suit of well-made leather armor.  It looks fairly rugged. (+5 Defense)";
		return;
	}
	if(texts.indexOf("LaBova ") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A bottle containing a misty fluid with a grainy texture, it has a long neck and a ball-like base.  The label has a stylized picture of a well endowed cowgirl nursing two guys while they jerk themselves off.";
		return;
	}
	
	if(texts.indexOf("SDelite") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This precious fluid is often given to men a succubus intends to play with for a long time.";
		return;
	}
	if(texts.indexOf("S.Dream") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This precious fluid is often given to men a succubus intends to play with for a long time, though this batch has been enhanced by Lumi to have even greater potency.";
		return;
	}
	if(texts.indexOf("GreenGl") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This tough substance has no obvious use that you can discern.";
		return;
	}
	if(texts.indexOf("PSDelit") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This precious fluid is often given to men a succubus intends to play with for a long time.  It has been partially purified by Rathazul to prevent corruption.";
		return;
	}
	if(texts.indexOf("Reducto") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This container full of paste can be used to shrink a body part down by a significant amount.";
		return;
	}
	if(texts.indexOf("OviElix") != -1 || texts == "OviElixir") {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This hexagonal crystal bottle is filled with a strange green fluid.  A tag with a picture of an egg is tied to the neck of the bottle, indicating it is somehow connected to egg-laying.";
		return;
	}
	if(texts.indexOf("PurHony") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This fine crystal vial is filled with a thick amber liquid that glitters in the light.  You can smell a sweet scent, even though it is tightly corked.";
		return;
	}
	if(texts.indexOf("BeeHony") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This fine crystal vial is filled with a thick amber liquid that glitters dully in the light.  You can smell a sweet scent, even though it is tightly corked.";
		return;
	}
	if(texts.indexOf("CanineP") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The pepper is shiny and red, bulbous at the base but long and narrow at the tip.  It smells spicy.";
		return;
	}
	if(texts.indexOf("SucMilk") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This milk-bottle is filled to the brim with a creamy white milk of dubious origin.  A pink label proudly labels it as \"<i>Succubi Milk</i>\".  In small text at the bottom of the label it reads: \"<i>To bring out the succubus in YOU!</i>\"";
		return;
	}
	if(texts.indexOf("P.S.Mlk") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This milk-bottle is filled to the brim with a creamy white milk of dubious origin.  A pink label proudly labels it as \"<i>Succubi Milk</i>\".  In small text at the bottom of the label it reads: \"<i>To bring out the succubus in YOU!</i>\"  Purified by Rathazul to prevent corruption.";
		return;
	}
	if(texts.indexOf("Cerul P") != -1 || texts.indexOf("Cerulean P.") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is a mysterious bottle filled with a sky-blue liquid that sloshes gently inside.  Supposedly it will make you irresistible, though to what or who you cannot say.";
		return;
	}
	if(texts.indexOf("PeppWht") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This tightly corked glass bottle gives of a pepperminty smell and reminds you of the winter holidays.  How odd.";
		return;
	}
	if(texts.indexOf("IncubiD") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers.  A stylized picture of a humanoid with a huge penis is etched into the glass.";
		return;
	}
	//"M. Milk"
	if(texts.indexOf("M. Milk") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A clear bottle of milk from Marble's breasts. It smells delicious.";
		return;
	}
	if(texts.indexOf("P.Draft") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers.  A stylized picture of a humanoid with a huge penis is etched into the glass. Rathazul has purified this to prevent corruption upon use.";
		return;
	}
	if(texts.indexOf("TScroll") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This tattered scroll is written in strange symbols, yet you have the feeling that if you tried to, you could decipher it.";
		return;
	}
	if(texts.indexOf("BrownEg") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.";
		return;
	}
	if(texts.indexOf("L.BrnEg") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.";
		return;
	}
	if(texts.indexOf("PurplEg") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.";
		return;
	}
	if(texts.indexOf("L.PrpEg") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.";
		return;
	}
	if(texts.indexOf("BlueEgg") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.";
		return;
	}
	if(texts.indexOf("L.BluEg") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.";
		return;
	}
	if(texts.indexOf("PinkEgg") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.";
		return;
	}
	if(texts.indexOf("NPnkEgg") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is an oblong egg with an unnatural neon pink coloration.  It tingles in your hand with odd energies that make you feel as if you could jump straight into the sky.";
		return;
	}
	if(texts.indexOf("L.PnkEg") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.";
		return;
	}
	if(texts.indexOf("WhiteEg") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is an oblong egg, not much different from a chicken egg in appearance.  Something tells you it's more than just food.";
		return;
	}
	if(texts.indexOf("L.WhtEg") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is an oblong egg, not much different from an ostrich egg in appearance.  Something tells you it's more than just food.";
		return;
	}
	if(texts.indexOf("BlackEg") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.";
		return;
	}
	if(texts.indexOf("L.BlkEg") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.  For all you know, it could turn you into rubber!";
		return;
	}
	if(texts.indexOf("RidingC") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This riding crop appears to be made of black leather, and could be quite a painful (or exciting) weapon.  (ATK: +5) (Cost: 50)";
		return;
	}
	if(texts.indexOf("L. Axe ") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This massive axe once belonged to a minotaur.  It'd be hard for anyone smaller than a giant to wield effectively.  The axe is double-bladed and deadly-looking.  (ATK: +15) (Cost: 100)";
		return;
	}
	if(texts.indexOf("GelArmr") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This suit of interlocking plates is made from a strange green material.  It feels spongy to the touch but is amazingly resiliant.  (DEF: +10) (Cost: 150)";
		return;
	}
	if(texts.indexOf("B.Sword") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This beautiful sword shines brilliantly in the light, showing the flawless craftsmanship of its blade.  The pommel and guard are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into this blade.  (ATK: +Varies) (Cost: 400)";
		return;
	}
	if(texts.indexOf("C.Cloth") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "These loose fitting and comfortable clothes allow you to move freely while protecting you from the elements.  (DEF: +0) (Cost: 0)";
		return;
	}
	if(texts.indexOf("ClssyCl") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A set of classy suitclothes.";
		return;
	}
	if(texts.indexOf("RbbrClt") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A revealing set of fetish-wear.  Upgrades tease attack to seduce.";
		return;
	}
	if(texts.indexOf("FurLoin") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A pair of loincloths to cover your crotch and " + buttDescript() + ".  Typically worn by people named 'Conan'.";
		return;
	}
	if(texts.indexOf("AdvClth") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A set of comfortable green adventurer's clothes.  It even comes complete with a pointy hat!";
		return;
	}
	if(texts.indexOf("TubeTop") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A clingy tube top and VERY short shorts.";
		return;
	}
	if(texts.indexOf("Overall") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A simple white shirt and overalls.";
		return;
	}

	if(texts.indexOf("B.Dress") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A long ballroom dress patterned with sequins.  Perfect for important occassions.";
		return;
	}
	if(texts.indexOf("T.BSuit") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A semi-transparent bodysuit.";
		return;
	}
	if(texts.indexOf("M.Robes") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A set of modest robes, not dissimilar from what the monks back home would wear.";
		return;
	}
	if(texts.indexOf("LthrPnt") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "A flowing silk shirt and tight black leather pants.  Suave!";
		return;
	}
	if(texts.indexOf("S.Swmwr") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "An impossibly skimpy black bikini. You feel dirty just looking at it… and a little aroused, actually.";
		return;
	}
	if(texts.indexOf("Red Dye") != -1 || texts.indexOf("Blond D") != -1 || 
        texts.indexOf("Black D") != -1 || texts.indexOf("Brown D") != -1 || 
		texts.indexOf("AuburnD") != -1 || texts.indexOf("GrayDye") != -1 ||
		texts.indexOf("PinkDye") != -1 || texts.indexOf("BlueDye") != -1 ||
		texts.indexOf("OrangDy") != -1 || texts.indexOf("PurpDye") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This bottle of dye will allow you to change the color of your hair.  Of course if you don't have hair, using this would be a waste.";
		return;
	}
	//Combat
	//COMBAT
	//combat
	if(texts == "Attack") {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Attempt to attack the enemy with your " + player.weaponName + ".  Damage done is determined by your strength and weapon.";
		return;
	}
	if(texts == "Kiss") {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Attempt to kiss your foe on the lips with drugged lipstick.  It has no effect on those without a penis.";
		return;
	}
	if(texts.indexOf("LustStk") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This tube of golden lipstick is used by harpies to keep males aroused.  It has aphrodisiac properties on anyone with male genitalia and is most effective when applied to the lips or groin.";
		return;
	}
	if(texts == "Tease") {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Attempt to make an enemy more aroused by striking a seductive pose and exposing parts of your body.";
		return;
	}
	if(texts == "Kick") {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Attempt to kick an enemy using your powerful lower body.";
		return;
	}
	if(texts == "Combo") {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Make a three-hit combo.  Each attack has an extra 33% chance to miss, unless the target is blind. (25 Fatigue)";
		return;
	}
	if(texts == "Vault") {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Make a vaulting attack for an extra 25% damage.  Automatically crits stunned foes.  (20 Fatigue)";
		return;
	}
	if(texts == "Sidewinder") {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "An attack that hits for reduced damage but has a high chance of stunning. (10 Fatigue)";
		return;
	}
	if(texts == "Dirt Kick") {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Attempt to blind your foe with a spray of kicked dirt. (5 Fatigue)";
		return;
	}
	if(texts == "Metabolize") {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Convert 10% of your maximum HP into fatigue.";
		return;
	}
	if(texts == "SecondWind") {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Regain 50% of your HP, 50 fatigue, and reduce lust by 50 once per fight.";
		return;
	}
	if(texts.indexOf("AnemoneSting") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Attempt to strike an opponent with the stinging tentacles growing from your scalp.  Reduces enemy speed and increases enemy lust.";
		return;
	}
	if(texts.indexOf("P. Specials") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Physical special attack menu.";
		return;
	}
	if(texts.indexOf("M. Specials") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Mental and supernatural special attack menu.";
		return;
	}
	if(texts == "Berzerk") {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Throw yourself into a rage!  Greatly increases the strength of your weapon and increases lust resistance, but your armor defense is reduced to zero!";
		return;
	}
	if(texts.indexOf("Possess") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Attempt to temporarily possess a foe and force them to raise their own lusts.";
		return;
	}
	if(texts.indexOf("Constrict") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Attempt to bind an enemy in your long snake-tail.";
		return;
	}
	if(texts.indexOf("Gore") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Lower your head and charge your opponent, attempting to gore them on your horns.  This attack is stronger and easier to land with large horns.";
		return;
	}
	if(texts.indexOf("Fantasize") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Fantasize about your opponent in a sexual way.  Its probably a pretty bad idea to do this unless you want to end up getting raped.";
		return;
	}
	if(texts.indexOf("Charge W.") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Charge Weapon spell will surround your weapon in electrical energy, causing it to do even more damage.  The effect lasts for the entire combat.  (Fatigue Cost: " + spellCost(15) + ")";
		return;
	}
	if(texts.indexOf("Blind") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Blind is a fairly self-explanatory spell.  It will create a bright flash just in front of the victim's eyes, blinding them for a time.  However if they blink it will be wasted.  (Fatigue Cost: " + spellCost(20) + ")";
		return;
	}
	if(texts.indexOf("Whitefire") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Whitefire is a potent fire based attack that will burn your foe with flickering white flames, ignoring their physical toughness and most armors.  (Fatigue Cost: " + spellCost(30) + ")";
		return;
	}
	if(texts.indexOf("Aroused") != -1) {
		return;
	}
	if(texts.indexOf("Arouse") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The arouse spell draws on your own inner lust in order enflame the enemy's passions.  (Fatigue Cost: " + spellCost(15) + ")";
		return;
	}
	if(texts == "Heal") {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Heal will attempt to use black magic to close your wounds and restore your body, however like all black magic used on yourself, it has a chance of backfiring and greatly arousing you.  (Fatigue Cost: " + spellCost(20) + ")";
		return;
	}
	if(texts.indexOf("Might") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The Might spell draws upon your lust and uses it to fuel a temporary increase in muscle size and power.  It does carry the risk of backfiring and raising lust, like all black magic used on oneself.  (Fatigue Cost: " + spellCost(25) + ")";
		return;
	}
	//Wait
	if(texts.indexOf("Wait") != -1 && gameState > 0) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Take no action for this round.  Why would you do this.  This is a terrible idea.";
		return;
	}
	//Sting
	if(texts.indexOf("Sting") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Attempt to use your venomous bee stinger on an enemy.  Be aware it takes quite a while for your venom to build up, so depending on your abdomen's refractory period, you may have to wait quite a while between stings.  Venom: " + Math.floor(player.tailVenom) + "/100";
		return;
	}
	//Web
	if(texts.indexOf("Web") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Attempt to use your abdomen to spray sticky webs at an enemy and greatly slow them down.  Be aware it takes a while for your webbing to build up.  Web Amount: " + Math.floor(player.tailVenom) + "/100";
		return;
	}
	if(texts.indexOf("Infest") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The infest attack allows you to cum at will, launching a stream of semen and worms at your opponent in order to infest them.  Unless your foe is very aroused they are likely to simply avoid it.  Only works on males or herms.";
		return;
	}
	if(texts.indexOf("Spells") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Opens your spells menu, where you can cast any spells you have learned.  Beware, casting spells increases your fatigue, and if you become exhausted you will be easier to defeat.";
		return;
	}
	if(texts.indexOf("Defend") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Selecting defend will reduce the damage you take by 66 percent, but will not affect any lust incurred by your enemy's actions.";
		return;
	}
	if(texts == "Run") {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Choosing to run will let you try to escape from your enemy. However, it will be hard to escape enemies that are faster than you and if you fail, your enemy will get a free attack.";
		return;
	}
	if(texts.indexOf("Inventory") != -1) {
		positionMOB(e.target.x, e.target.y)		
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.";
		return;
	}
	if(texts.indexOf("AutoSav") != -1) {
		positionMOB(e.target.x, e.target.y)		
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "When autosave is on the game will automatically save your character each night at midnight to the last slot it was saved in.";
		if(texts.indexOf("ON") != -1) mouseOverText.htmlText += " Autosave is currently enabled.  Your game will be saved at midnight.";
		if(texts.indexOf("OFF") != -1) mouseOverText.htmlText += " Autosave is currently off.  Your game will NOT be saved.";
		return;
	}
	if(texts.indexOf("Retrieve") != -1) {
		positionMOB(e.target.x, e.target.y)		
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Retrieve allows you to take an item from one of the reserve stacks in your camp's additional storage.";
		return;
	}
	if(texts.indexOf("Storage") != -1) {
		positionMOB(e.target.x, e.target.y)		
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Storage will allow you to dump a stack of items from your inventory into your storage chest.";
		return;
	}
	if(texts.indexOf("Sand Facial") != -1) {
		positionMOB(e.target.x, e.target.y)		
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "The goblins promise this facial will give you a rough, handsome look thanks to their special, timeless sands.";
		return;
	}
	if(texts.indexOf("Mud Facial") != -1) {
		positionMOB(e.target.x, e.target.y)		
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This facial is supposed to enhance the softness of your face and enhance its femininity greatly.";
		return;
	}
	//Masturbation Toys
	if(texts == "Masturbate") {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Selecting this option will attempt to manually masturbate in order to relieve your lust buildup.";
		return;
	}
	if(texts == "Meditate") {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Selecting this option will attempt to meditate in order to reduce lust and corruption.";
		return;
	}
	if(texts.indexOf("AN Stim-Belt") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is an all-natural self-stimulation belt.  The methods used to create such a pleasure device are unknown.  It seems to be organic in nature.";
		return;
	}
	if(texts.indexOf("Stim-Belt") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is a self-stimulation belt.  Commonly referred to as stim-belts, these are clockwork devices designed to pleasure the female anatomy.";
		return;
	}
	if(texts.indexOf("AN Onahole") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "An all-natural onahole, this device looks more like a bulbous creature than a sex-toy.  Never-the-less, the slick orifice it presents looks very inviting.";
		return;
	}
	if(texts.indexOf("D Onahole") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is a deluxe onahole, made of exceptional materials and with the finest craftsmanship in order to bring its user to the height of pleasure.";
		return;
	}
	if(texts.indexOf("Onahole") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is what is called an 'onahole'.  This device is a simple textured sleeve designed to fit around the male anatomy in a pleasurable way.";
		return;
	}
	if(texts == "Jojo") {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		if(monk >= 5) mouseOverText.htmlText = "Call your corrupted pet into camp in order to relieve your desires in a variety of sexual positions?  He's ever so willing after your last encounter with him.";
		else mouseOverText.htmlText = "Go find Jojo around the edges of your camp and meditate with him or talk about watch duty.";
		return;
	}
	if(texts == "Marble") {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Go to Marble the cowgirl for talk and companionship.";
		return;
	}
	//Books
	if(texts.indexOf("Dangerous Plants") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This is a book titled 'Dangerous Plants'.  As explained by the title, this tome is filled with information on all manner of dangerous plants from this realm.";
		return;
	}
	if(texts.indexOf("Traveler's Guide") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This traveler's guide is more of a pamphlet than an actual book, but it still contains some useful information on avoiding local pitfalls.";
		return;
	}
	if(texts.indexOf("Yoga Guide") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This leather-bound book is titled 'Yoga for Non-Humanoids.' It contains numerous illustrations of centaurs, nagas and various other oddly-shaped beings in a variety of poses.";
		return;
	}
	if(texts.indexOf("Hentai Comic") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "This oddly drawn comic book is filled with images of fornication, sex, and overly large eyeballs.";
		return;
	}
	//CAMP STUFF
	if(texts.indexOf("Followers") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Check up on any followers or companions who are joining you in or around your camp.  You'll probably just end up sleeping with them.";
		return;
	}
	//Marble
	if(texts.indexOf("Marble (Sex)") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Get with marble for a quick cuddle and some sex.";
		return;
	}
	//Rathazul
	if(texts.indexOf("Rathazul") != -1) {
		positionMOB(e.target.x, e.target.y)
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Visit with Rathazul to see what alchemical supplies and services he has available at the moment.";
		return;
	}
	//Title screen
	if(texts.indexOf("Toggle Debug") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Turn on debug mode.  Debug mode is intended for testing purposes but can be thought of as a cheat mode.  Items are infinite and combat is easy to escape from.  Weirdness and bugs are to be expected.";
		return;
	}
	if(texts.indexOf("Credits") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "See a list of all the cool people who have contributed to content for this game!";
		return;
	}
	if(texts.indexOf("Instructions") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "How to play.  Starting tips.  And hotkeys for easy left-handed play...";
		return;
	}
	if(texts.indexOf("Settings") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "Configure game settings and enable cheats.";
		return;
	}
	if(texts.indexOf("ASPLODE") != -1) {
		positionMOB(e.target.x, e.target.y)			
		mouseOverText.visible = true;
		popUpBG.visible = true;
		mouseOverText.htmlText = "MAKE SHIT ASPLODE";
		return;
	}
	mouseOverText.visible = false;
	popUpBG.visible = false;
}
function positionMOB(Ex:Number, Why:Number):void {
	if(!mobile) {
		if(Ex >= 708) Ex = 700;
		mouseOverText.x = Ex+9;
		mouseOverText.y = Why-210;
		popUpBG.x = Ex-13;
		popUpBG.y = Why-232;
	} //(x difference = -22, y diff = -22)
	else {
		if(Ex >= 410) Ex = 405;
		mouseOverText.x = Ex+114;
		mouseOverText.y = Why-325;
		popUpBG.x = Ex+98;
		popUpBG.y = Why-347;
	}
}
function addButton(pos:int, text:String = "", func1:Function = null, arg1 = -9000):void {
	if(pos > 9) {
		trace("INVALID BUTTON");
		return;
	}
	//If the function/argument array isn't set up, fill it with blanks!
	if(funcs.length < 10 || args.length < 10) {
		funcs = new Array();
		args = new Array();
		var temp = 0;
		while(temp < 10) {
			funcs[funcs.length] = null;
			args[args.length] = -9000;
			temp++;
		}
	}
	//set dat shit up.
	funcs[pos] = func1;
	args[pos] = arg1;
	buttonSetup(pos,text);
	mainText.htmlText = currentText;
	scrollBar.update();
}

function buttonSetup(pos:int,text1:String = ""):void {
	if(pos == 0) {
		b1Text.visible = true;
		b1Text.text = text1;
		gButtons[0].visible = true;
	}
	if(pos == 1) {
		b2Text.visible = true;
		b2Text.text = text1;
		gButtons[1].visible = true;
	}
	if(pos == 2) {
		b3Text.visible = true;
		b3Text.text = text1;
		gButtons[2].visible = true;
	}
	if(pos == 3) {
		b4Text.visible = true;
		b4Text.text = text1;
		gButtons[3].visible = true;
	}
	if(pos == 4) {
		b5Text.visible = true;
		b5Text.text = text1;
		gButtons[4].visible = true;
	}
	if(pos == 5) {
		b6Text.visible = true;
		b6Text.text = text1;
		gButtons[5].visible = true;
	}
	if(pos == 6) {
		b7Text.visible = true;
		b7Text.text = text1;
		gButtons[6].visible = true;
	}
	if(pos == 7) {
		b8Text.visible = true;
		b8Text.text = text1;
		gButtons[7].visible = true;
	}
	if(pos == 8) {
		b9Text.visible = true;
		b9Text.text = text1;
		gButtons[8].visible = true;
	}
	if(pos == 9) {
		b0Text.visible = true;
		b0Text.text = text1;
		gButtons[9].visible = true;
	}
}

function hasButton(arg):Boolean {
	if(arg is String) {
		if(arg == b1Text.htmlText) {
			trace("HAS BUTTON: " + arg);
			return true;
		}
		else if(arg == b2Text.text) {
			trace("HAS BUTTON: " + arg);
			return true;
		}
		else if(arg == b3Text.text) {
			trace("HAS BUTTON: " + arg);
			return true;
		}
		else if(arg == b4Text.text) {
			trace("HAS BUTTON: " + arg);
			return true;
		}
		else if(arg == b5Text.text) {
			trace("HAS BUTTON: " + arg);
			return true;
		}
		else if(arg == b6Text.text) {
			trace("HAS BUTTON: " + arg);
			return true;
		}
		else if(arg == b7Text.text) {
			trace("HAS BUTTON: " + arg);
			return true;
		}
		else if(arg == b8Text.text) {
			trace("HAS BUTTON: " + arg);
			return true;
		}
		else if(arg == b9Text.text) {
			trace("HAS BUTTON: " + arg);
			return true;
		}
		else if(arg == b0Text.text) {
			trace("HAS BUTTON: " + arg);
			return true;
		}
	}
	trace("NO BUTTON: " + arg);
	return false;
}

function removeButton(arg):void {
	var buttonToRemove:int = 0;
	if(arg is String) {
		if(arg == b1Text.text) {
			buttonToRemove = 0;
		}
		else if(arg == b2Text.text) {
			buttonToRemove = 1;
		}
		else if(arg == b3Text.text) {
			buttonToRemove = 2;
		}
		else if(arg == b4Text.text) {
			buttonToRemove = 3;
		}
		else if(arg == b5Text.text) {
			buttonToRemove = 4;
		}
		else if(arg == b6Text.text) {
			buttonToRemove = 5;
		}
		else if(arg == b7Text.text) {
			buttonToRemove = 6;
		}
		else if(arg == b8Text.text) {
			buttonToRemove = 7;
		}
		else if(arg == b9Text.text) {
			buttonToRemove = 8;
		}
		else if(arg == b0Text.text) {
			buttonToRemove = 9;
		}
	}
	if(arg is Number) {
		if(arg < 0 || arg > 9) return;
		buttonToRemove = Math.round(arg);
	}
	if(buttonToRemove == 0) {
		b1Text.visible = false;
		gButtons[0].visible = false;
		funcs[0] = null;
		args[0] = -9000;
	}
	else if(buttonToRemove == 1) {
		b2Text.visible = false;
		gButtons[1].visible = false;
		funcs[1] = null;
		args[1] = -9000;
	}
	else if(buttonToRemove == 2) {
		b3Text.visible = false;
		gButtons[2].visible = false;
		funcs[2] = null;
		args[2] = -9000;
	}
	else if(buttonToRemove == 3) {
		b4Text.visible = false;
		gButtons[3].visible = false;
		funcs[3] = null;
		args[3] = -9000;
	}
	else if(buttonToRemove == 4) {
		b5Text.visible = false;
		gButtons[4].visible = false;
		funcs[4] = null;
		args[4] = -9000;
	}
	else if(buttonToRemove == 5) {
		b6Text.visible = false;
		gButtons[5].visible = false;
		funcs[5] = null;
		args[5] = -9000;
	}
	else if(buttonToRemove == 6) {
		b7Text.visible = false;
		gButtons[6].visible = false;
		funcs[6] = null;
		args[6] = -9000;
	}
	else if(buttonToRemove == 7) {
		b8Text.visible = false;
		gButtons[7].visible = false;
		funcs[7] = null;
		args[7] = -9000;
	}
	else if(buttonToRemove == 8) {
		b9Text.visible = false;
		gButtons[8].visible = false;
		funcs[8] = null;
		args[8] = -9000;
	}
	else if(buttonToRemove == 9) {
		b0Text.visible = false;
		gButtons[9].visible = false;
		funcs[9] = null;
		args[9] = -9000;
	}
}


function menu(text1:String = "", func1:Function = null, arg1:Number = -9000, text2:String = null, func2:Function = null, arg2:Number = -9000, text3:String = null, func3:Function = null, arg3:Number = -9000, text4:String = null, func4:Function = null, arg4:Number = -9000, text5:String = null, func5:Function = null, arg5:Number = -9000, text6:String = null, func6:Function = null, arg6:Number = -9000, text7:String = null, func7:Function = null, arg7:Number = -9000, text8:String = null, func8:Function = null, arg8:Number = -9000, text9:String = null, func9:Function = null, arg9:Number = -9000, text0:String = null, func0:Function = null, arg0 = null):void {
	//Clear funcs & args
	funcs = new Array();
	args = new Array();
	//populate em'
	funcs[funcs.length] = func1;
	funcs[funcs.length] = func2;
	funcs[funcs.length] = func3;
	funcs[funcs.length] = func4;
	funcs[funcs.length] = func5;
	funcs[funcs.length] = func6;
	funcs[funcs.length] = func7;
	funcs[funcs.length] = func8;
	funcs[funcs.length] = func9;
	funcs[funcs.length] = func0;
	args[args.length] = arg1;
	args[args.length] = arg2;
	args[args.length] = arg3;
	args[args.length] = arg4;
	args[args.length] = arg5;
	args[args.length] = arg6;
	args[args.length] = arg7;
	args[args.length] = arg8;
	args[args.length] = arg9;
	args[args.length] = arg0;
	
	//Set button texts
	if(text1 != null) b1Text.htmlText = text1;
	if(text2 != null) b2Text.htmlText = text2;
	if(text3 != null) b3Text.htmlText = text3;
	if(text4 != null) b4Text.htmlText = text4;
	if(text5 != null) b5Text.htmlText = text5;
	if(text6 != null) b6Text.htmlText = text6;
	if(text7 != null) b7Text.htmlText = text7;
	if(text8 != null) b8Text.htmlText = text8;
	if(text9 != null) b9Text.htmlText = text9;
	if(text0 != null) b0Text.htmlText = text0;
	if(func1 == null) {
		b1Text.visible = false;
		gButtons[0].visible = false;
	}
	else {
		b1Text.visible = true;
		gButtons[0].visible = true;
	}
	if(func2 == null) {
		b2Text.visible = false;
		gButtons[1].visible = false;
	}
	else {
		b2Text.visible = true;
		gButtons[1].visible = true;
	}
	if(func3 == null) {
		b3Text.visible = false;
		gButtons[2].visible = false;
	}
	else {
		b3Text.visible = true;
		gButtons[2].visible = true;
	}
	if(func4 == null) {
		b4Text.visible = false;
		gButtons[3].visible = false;
	}
	else {
		b4Text.visible = true;
		gButtons[3].visible = true;
	}
	if(func5 == null) {
		b5Text.visible = false;
		gButtons[4].visible = false;
	}
	else {
		b5Text.visible = true;
		gButtons[4].visible = true;
	}
	if(func6 == null) {
		b6Text.visible = false;
		gButtons[5].visible = false;
	}
	else {
		b6Text.visible = true;
		gButtons[5].visible = true;
	}
	if(func7 == null) {
		b7Text.visible = false;
		gButtons[6].visible = false;
	}
	else {
		b7Text.visible = true;
		gButtons[6].visible = true;
	}
	if(func8 == null) {
		b8Text.visible = false;
		gButtons[7].visible = false;
	}
	else {
		b8Text.visible = true;
		gButtons[7].visible = true;
	}
	if(func9 == null) {
		b9Text.visible = false;
		gButtons[8].visible = false;
	}
	else {
		b9Text.visible = true;
		gButtons[8].visible = true;
	}
	if(func0 == null) {
		b0Text.visible = false;
		gButtons[9].visible = false;
	}
	else {
		b0Text.visible = true;
		gButtons[9].visible = true;
	}
	mainText.htmlText = currentText;
	scrollBar.update();
}


function choices(text1:String, butt1:*, 
						text2:String, butt2:*, 
						text3:String, butt3:*, 
						text4:String, butt4:*, 
						text5:String, butt5:*, 
						text6:String, butt6:*, 
						text7:String, butt7:*, 
						text8:String, butt8:*, 
						text9:String, butt9:*, 
						text0:String, butt0:*):void 
{
	//Transfer event code to storage
	buttonEvents[0] = butt1;
	buttonEvents[1] = butt2;
	buttonEvents[2] = butt3;
	buttonEvents[3] = butt4;
	buttonEvents[4] = butt5;
	buttonEvents[5] = butt6;
	buttonEvents[6] = butt7;
	buttonEvents[7] = butt8;
	buttonEvents[8] = butt9;
	buttonEvents[9] = butt0;
	//Set button texts
	b1Text.htmlText = text1;
	b2Text.htmlText = text2;
	b3Text.htmlText = text3;
	b4Text.htmlText = text4;
	b5Text.htmlText = text5;
	b6Text.htmlText = text6;
	b7Text.htmlText = text7;
	b8Text.htmlText = text8;
	b9Text.htmlText = text9;
	b0Text.htmlText = text0;


	var bTextArr:Array = new Array( b1Text,
									b2Text,
									b3Text,
									b4Text,
									b5Text,
									b6Text,
									b7Text,
									b8Text,
									b9Text,
									b0Text);

	var j:int;

	// iterate over the button options, and only enable the ones which have a corresponding event number

	for (j = 0; j < 10; j += 1)
	{

		if(buttonEvents[j] == 0) {
			bTextArr[j].visible = false;
			gButtons[j].visible = false;
		}
		else {
			bTextArr[j].visible = true;
			gButtons[j].visible = true;
		}

	}


	funcs = new Array();
	args = new Array();
	mainText.htmlText = currentText;
	scrollBar.update();
}

// simpleChoices and doYesNo are convenience functions. They shouldn't re-implement code from choices()
function simpleChoices(text1:String, butt1:*, 
						text2:String, butt2:*, 
						text3:String, butt3:*, 
						text4:String, butt4:*, 
						text5:String, butt5:*):void 
{

	trace("SimpleChoices");
	choices(text1,butt1,
			text2,butt2,
			text3,butt3,
			text4,butt4,
			text5,butt5,
			"",0,
			"",0,
			"",0,
			"",0,
			"",0);
}

function doYesNo(eventYes:*, eventNo:*):void {
	//Make buttons 1-2 visible and hide the rest.

	trace("doYesNo");
	choices("Yes",eventYes,
			"No",eventNo,
			"",0,
			"",0,
			"",0,
			"",0,
			"",0,
			"",0,
			"",0,
			"",0);

}



function doNext(eventNo:*):void {
	//Prevent new events in combat from automatically overwriting a game over. 
	if(b1Text.text.indexOf("Game Over") != -1) {
		trace("Do next setup cancelled by game over");
		return;
	}
	
	trace("DoNext have item:", eventNo);
	choices("Next", eventNo, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0); 
}


function invertGo():void{ 
	if (blackBackground.visible == false){
		blackBackground.visible = true;
		
	//	statBox.textColor = 0xFFFFFF;
		/*statValuePane.textColor = 0xFFFFFF;
		levelPane.textColor = 0xFFFFFF;
		levelValuePane.textColor = 0xFFFFFF;
		DayPane.textColor = 0xFFFFFF;
		DayValuePane.textColor = 0xFFFFFF;
		clockPane.textColor = 0xFFFFFF;
		outputWindow.textColor = 0xFFFFFF;
		region.textColor = 0xFFFFFF;
		currentRegion.textColor = 0xFFFFFF;	*/
	}
	else {
		blackBackground.visible = false;
		//statBox.textColor = 0x000000;
		/*statValuePane.textColor = 0x000000;
		levelPane.textColor = 0x000000;
		levelValuePane.textColor = 0x000000;
		DayPane.textColor = 0x000000;
		DayValuePane.textColor = 0x000000;
		clockPane.textColor = 0x000000;
		outputWindow.textColor = 0x000000;
		currentRegion.textColor = 0x000000;	
		region.textColor = 0x000000;*/
	}
}



//Used to update the display of statistics
function statScreenRefresh():void {
	//Make sure it's all visible
	showStats();
	coreStatsText.htmlText = "<b><u>Name : " + player.short + "</u>\nCore Stats</b>";
	var temp:String = "";
	//Set number values:
	strNum.htmlText = String(int(player.str));
	touNum.htmlText = String(int(player.tou));
	speNum.htmlText = String(int(player.spe));
	inteNum.htmlText = String(int(player.inte));
	libNum.htmlText = String(int(player.lib));
	senNum.htmlText = String(int(player.sens));
	corNum.htmlText = String(int(player.cor));
	fatigueNum.htmlText = String(int(player.fatigue));
	HPNum.htmlText = String(int(player.HP));
	lustNum.htmlText = String(int(player.lust));
	levelNum.htmlText = String(int(player.level));
	if(player.XP > 9999) xpNum.htmlText = "++++";
	else xpNum.htmlText = String(int(player.XP));
	temp = "<b><u>Day #: " + days + "</u></b>\n<b>Time : " + hours + ":00</b>"
	timeText.htmlText = temp;
	//Set bar lengths
	strBar.width = int(player.str/100 * 115);
	touBar.width = int(player.tou/100 * 115);
	speBar.width = int(player.spe/100 * 115);
	inteBar.width = int(player.inte/100 * 115);
	libBar.width = int(player.lib/100 * 115);
	sensBar.width = int(player.sens/100 * 115);
	corBar.width = int(player.cor/100 * 115);
	fatigueBar.width = int(player.fatigue/100 * 115);
	HPBar.width = int(player.HP/maxHP() * 115);
	lustBar.width = int(player.lust/100 * 115);
	if(player.gems > 9999) gemsNum.htmlText = "++++";
	else gemsNum.htmlText = String(player.gems);
}

function showStats():void {
	strBar.visible = true;
	strText.visible = true;
	strNum.visible = true;
	touBar.visible = true;
	touText.visible = true;
	touNum.visible = true;
	sensBar.visible = true;
	senText.visible = true;
	senNum.visible = true;
	inteBar.visible = true;
	inteText.visible = true;
	inteNum.visible = true;
	speBar.visible = true;
	speText.visible = true;
	speNum.visible = true;
	libBar.visible = true;
	libText.visible = true;
	libNum.visible = true;
	corBar.visible = true;
	corText.visible = true;
	corNum.visible = true;
	fatigueBar.visible = true;
	fatigueText.visible = true;
	fatigueNum.visible = true;
	HPBar.visible = true;
	HPText.visible = true;
	HPNum.visible = true;
	lustBar.visible = true;
	lustText.visible = true;
	lustNum.visible = true;
	levelText.visible = true;
	levelNum.visible = true;
	xpNum.visible = true;
	xpText.visible = true;
	coreStatsText.visible = true;
	advancementText.visible = true;
	combatStatsText.visible = true;
	gemsText.visible = true;
	gemsNum.visible = true;
	timeText.visible = true;
	sideBarBG.visible = true;
	timeBG.visible = true;
}
function hideStats():void {
	strBar.visible = false;
	strText.visible = false;
	strNum.visible = false;
	touBar.visible = false;
	touText.visible = false;
	touNum.visible = false;
	sensBar.visible = false;
	senText.visible = false;
	senNum.visible = false;
	inteBar.visible = false;
	inteText.visible = false;
	inteNum.visible = false;
	speBar.visible = false;
	speText.visible = false;
	speNum.visible = false;
	libBar.visible = false;
	libText.visible = false;
	libNum.visible = false;
	corBar.visible = false;
	corText.visible = false;
	corNum.visible = false;
	fatigueBar.visible = false;
	fatigueText.visible = false;
	fatigueNum.visible = false;
	HPBar.visible = false;
	HPText.visible = false;
	HPNum.visible = false;
	lustBar.visible = false;
	lustText.visible = false;
	lustNum.visible = false;
	levelText.visible = false;
	levelNum.visible = false;
	xpNum.visible = false;
	xpText.visible = false;
	coreStatsText.visible = false;
	advancementText.visible = false;
	combatStatsText.visible = false;
	timeText.visible = false;
	gemsText.visible = false;
	gemsNum.visible = false;
	sideBarBG.visible = false;
	timeBG.visible = false;
}

function hideMenus():void {
	dataBG.visible = false;
	dataText.visible = false;
	appearanceText.visible = false;
	appearanceBG.visible = false;
	levelText2.visible = false;
	levelBG.visible = false;
	perksBG.visible = false;
	perksText.visible = false;
	statsText.visible = false;
	statsBG.visible = false;
}
//Hide the up/down indicators
function hideUpDown():void {
	strUp.visible = false;
	strDown.visible = false;
	touUp.visible = false;
	touDown.visible = false;
	speUp.visible = false;
	speDown.visible = false;
	inteUp.visible = false;
	inteDown.visible = false;
	libUp.visible = false;
	libDown.visible = false;
	sensUp.visible = false;
	sensDown.visible = false;
	corUp.visible = false;
	corDown.visible = false;
	hpUp.visible = false;
	hpDown.visible = false;
	lustUp.visible = false;
	lustDown.visible = false;
	levelUp.visible = false;
	xpUp.visible = false;
	xpDown.visible = false;
	fatigueUp.visible = false;
	fatigueDown.visible = false;
	//Clear storage values so up/down arrows can be properly displayed
	oldStr = 0;
	oldTou = 0;
	oldSpe = 0;
	oldInte = 0;
	oldLib = 0;
	oldSens = 0;
	oldLust = 0;
	oldCor = 0;	
}
function physicalCost(mod:Number):Number {
	var costPercent:Number = 100;
	if(player.hasPerk("Iron Man") >= 0) costPercent -= 50;
	mod *= costPercent/100;
	return mod;
}

function spellCost(mod:Number):Number {
	//Addiditive mods
	var costPercent:Number = 100;
	if(player.hasPerk("Spellcasting Affinity") >= 0) costPercent -= player.perkv1("Spellcasting Affinity");
	if(player.hasPerk("Wizard's Endurance") >= 0) costPercent -= player.perkv1("Wizard's Endurance");
	
	//Limiting it and multiplicative mods
	if(player.hasPerk("Blood Mage") >= 0 && costPercent < 50) costPercent = 50;
	
	mod *= costPercent/100;
	
	if(player.hasPerk("History: Scholar") >= 0) {
		if(mod > 2) mod *= .8;
	}
	if(player.hasPerk("Blood Mage") >= 0 && mod < 5) mod = 5;
	else if(mod < 2) mod = 2;
	
	mod = Math.round(mod * 100)/100;
	return mod;
}

//Modify fatigue
//types:
//	0 - normal
//	1 - magic
function fatigue(mod:Number,type:Number  = 0):void {
	//Spell reductions
	if(type == 1) {
		mod = spellCost(mod);
		
		//Blood mages use HP for spells
		if(player.hasPerk("Blood Mage") >= 0) {
			takeDamage(mod);
			statScreenRefresh();
			return;
		}		
	}
	//Physical special reductions
	if(type == 2) {
		mod = physicalCost(mod);
	}
	if(player.fatigue >= 100 && mod > 0) return;
	if(player.fatigue <= 0 && mod < 0) return;
	//Fatigue restoration buffs!
	if(mod < 0) {
		if(player.hasPerk("History: Slacker") >= 0) mod *= 1.2;
	}
	player.fatigue += mod;
	if(mod > 0) {
		fatigueUp.visible = true;
		fatigueDown.visible = false;
	}
	if(mod < 0) {
		fatigueDown.visible = true;
		fatigueUp.visible = false;
	}
	if(player.fatigue > 100) player.fatigue = 100;
	if(player.fatigue < 0) player.fatigue = 0;
	statScreenRefresh();
}
//function changeFatigue
function changeFatigue(changeF:Number):void {
	fatigue(changeF);
}
//Determine minimum lust
function minLust():Number {
	var min:Number = 0;
	//Bimbo body boosts minimum lust by 40
	if(player.hasStatusAffect("Bimbo Champagne") >= 0 || player.hasPerk("Bimbo Body") >= 0 || player.hasPerk("Bro Body") >= 0 || player.hasPerk("Futa Form") >= 0) {
		if(min > 40) min += 10;
		else if(min > 0) min += 20;
		else min += 40;
	}
	//Omnibus' Gift
	if(player.hasPerk("Omnibus' Gift") >= 0) {
		if(min > 40) min += 10;
		else if(min > 0) min += 20;
		else min += 35;		
	}
	//Nymph perk raises to 30
	if(player.hasPerk("Nymphomania") >= 0) {
		if(min >= 40) min += 10;
		else if(min > 0) min += 15;
		else min += 30;
	}
	//Oh noes anemone!
	if(player.hasStatusAffect("Anemone Arousal") >= 0) {
		if(min >= 40) min += 10;
		else if(min > 0) min += 20;
		else min += 30;
	}
	//Hot blooded perk raises min lust!
	if(player.hasPerk("Hot Blooded") >= 0) {
		if(min > 0) min += player.perks[player.hasPerk("Hot Blooded")].value1 / 2;
		else min += player.perks[player.hasPerk("Hot Blooded")].value1;
	}
	if(player.hasPerk("Luststick Adapted") > 0) {
		if(min < 50) min += 10;
		else min += 5;		
	}
	//Add points for Crimstone
	min += player.perkv1("Pierced: Crimstone");
	min += player.perkv1("Pent Up");
	//Harpy Lipstick status forces minimum lust to be at least 50.
	if(min < 50 && player.hasStatusAffect("Luststick") >= 0) min = 50;
	//SHOULDRA BOOSTS
	//+20
	if(flags[SHOULDRA_SLEEP_TIMER] <= -168) {
		min += 20;
		if(flags[SHOULDRA_SLEEP_TIMER] <= -216)
			min += 30;
	}
	//SPOIDAH BOOSTS
	if(player.eggs() >= 20) {
		min += 10;
		if(player.eggs() >= 40) min += 10;
	}
	if(min < 30 && player.armorName == "lusty maiden's armor") min = 30;
	return min;
}

function displayStats(e:MouseEvent) {
	spriteSelect(-1);
	outputText("", true);
	outputText("<b><u>Combat Stats</u></b>\n", false);
	if(player.hasKeyItem("Bow") >= 0) outputText("<b>Bow Skill: </b>" + Math.round(player.statusAffectv1("Kelt")) + "\n", false);
	outputText("<b>Lust Resistance: </b>" + (100-Math.round(lustPercent())) + "% (Higher is better.)\n", false);
	outputText("<b>Spell Effect Multiplier: </b>" + (100 * spellMod()) + "%\n");
	outputText("<b>Spell Cost: </b>" + spellCost(100) + "%\n");
	outputText("<b>Tease Skill Level (Out of 5): </b> " + player.teaseLevel + "\n", false);
	
	outputText("\n<b><u>Hidden Stats</u></b>\n", false);
	outputText("<b>Anal Capacity: </b>" + Math.round(player.analCapacity()) + "\n");
	outputText("<b>Anal Looseness: </b>" + Math.round(player.ass.analLooseness) + "\n");
	
	outputText("<b>Fertility (Base) Rating: </b>" + Math.round(player.fertility) + "\n", false);
	outputText("<b>Fertility (With Bonuses) Rating: </b>" + Math.round(player.totalFertility()) + "\n", false);
	if(player.hasStatusAffect("Feeder") >= 0) {
		outputText("<b>Hours Since Last Time Breastfed Someone: </b> " + player.statusAffectv2("Feeder"), false);
		if(player.statusAffectv2("Feeder") >= 72) outputText(" (Too long! Sensitivity Increasing!)", false);
		outputText("\n", false);
	}
	
	outputText("<b>Cum Production:</b> " + Math.round(player.cumQ()) + "mL\n", false);
	outputText("<b>Milk Production:</b> " + Math.round(player.lactationQ()) + "mL\n", false);
	//MARBLE
	if(player.statusAffectv3("Marble") > 0) {
		outputText("<b>Marble Milk Addiction: </b>", false);
		if(player.hasPerk("Marble Resistant") < 0 && player.hasPerk("Marble's Milk") < 0) outputText(Math.round(player.statusAffectv2("Marble")) + "%\n", false);
		else if(player.hasPerk("Marble Resistant") >= 0) outputText("0%\n", false);
		else outputText("100%\n", false);
	}
	//MINO!
	if(flags[UNKNOWN_FLAG_NUMBER_00340] > 0 || flags[MINOTAUR_CUM_ADDICTION_TRACKER] > 0 || player.hasPerk("Minotaur Cum Addict") >= 0) {
		if(player.hasPerk("Minotaur Cum Addict") < 0) outputText("<b>Minotaur Cum Addiction:</b> " + Math.round(flags[MINOTAUR_CUM_ADDICTION_TRACKER] * 10)/10 + "%\n", false);
		else outputText("<b>Minotaur Cum Addiction:</b> 100+%\n", false);
	}
	if(player.hasPerk("Spider Ovipositor") >= 0 || player.hasPerk("Bee Ovipositor") >= 0) outputText("<b>Ovipositor Total Egg Count: " + player.eggs() + "\nOvipositor Fertilized Egg Count: " + player.fertilizedEggs() + "</b>\n");
	outputText("<b>Pregnancy Speed Multiplier:</b> ", false);
	var preg:Number = 1;
	if(player.hasPerk("Diapause") >= 0) outputText("? (Variable due to Diapause)\n", false);
	else {
		if(player.hasPerk("Marae's Gift - Fertility") >= 0) preg++;
		if(player.hasPerk("Brood Mother") >= 0) preg++;
		if(player.hasPerk("Fera's Boon - Breeding Bitch") >= 0) preg++;
		if(player.hasPerk("Magical Fertility") >= 0) preg++;
		if(player.hasPerk("Fera's Boon - Wide Open") >= 0 || player.hasPerk("Fera's Boon - Milking Twat") >= 0) preg++;
		outputText(preg + "\n", false);
	}	
	if(player.hasStatusAffect("Slime Craving") >= 0) {
		if(player.statusAffectv1("Slime Craving") >= 18) outputText("<b>Slime Craving:  </b>Active! You are currently losing strength and speed.  You should find fluids.\n", false);
		else {
			if(player.hasPerk("Slime Core") >= 0) outputText("<b>Slime Stored:  </b>" + ((17 - player.statusAffectv1("Slime Craving")) * 2) + " hours until you start losing strength.\n", false);
			else outputText("<b>Slime Stored:  </b>" + (17 - player.statusAffectv1("Slime Craving")) + " hours until you start losing strength.\n", false);
		}
	}
	outputText("<b>Spells Cast: </b>" + flags[SPELLS_CAST] + "\n");
	if(player.hasVagina()) outputText("<b>Vaginal Capacity: </b>" + Math.round(player.vaginalCapacity()) + "\n");
	if(player.hasVagina()) outputText("<b>Vaginal Looseness: </b>" + Math.round(player.looseness()) + "\n");
	
	outputText("<b><u>\nInterpersonal Stats</u></b>\n", false);
	if(flags[ARIAN_PARK] > 0) outputText("<b>Arian's Health: </b>" + Math.round(arianHealth()) + "\n");
	if(flags[ARIAN_VIRGIN] > 0) outputText("<b>Arian Sex Counter: </b>" + Math.round(flags[ARIAN_VIRGIN]) + "\n");
	if(benoitAffection() > 0) outputText("<b>" + benoitMF("Benoit","Benoite") + " Affection: </b>" + Math.round(benoitAffection()) + "%\n");
	if(flags[BENOIT_EGGS] > 0) outputText("<b>Benoit Eggs Laid: </b>" + flags[BENOIT_EGGS] + "\n");
	if(flags[BROOKE_MET] > 0) outputText("<b>Brooke Affection: </b>" + Math.round(brookeAffection()) + "\n");
	if(flags[UNKNOWN_FLAG_NUMBER_00218]+flags[UNKNOWN_FLAG_NUMBER_00219]+flags[UNKNOWN_FLAG_NUMBER_00220] > 0) outputText("<b>Body Parts Taken By Ceraph: </b>" + (flags[UNKNOWN_FLAG_NUMBER_00218]+flags[UNKNOWN_FLAG_NUMBER_00219]+flags[UNKNOWN_FLAG_NUMBER_00220]) + "\n", false);
	if(flags[COTTON_KID_COUNT] > 0) outputText("<b>Children With Cotton: </b>" + flags[COTTON_KID_COUNT] + "\n");
	if(flags[UNKNOWN_FLAG_NUMBER_00069] > 0) outputText("<b>Children With Edryn: </b>" + flags[UNKNOWN_FLAG_NUMBER_00069] + "\n", false);
	if(flags[UNKNOWN_FLAG_NUMBER_00251]+flags[UNKNOWN_FLAG_NUMBER_00252] > 0) outputText("<b>Children With Izma: </b>" + (flags[UNKNOWN_FLAG_NUMBER_00251]+flags[UNKNOWN_FLAG_NUMBER_00252]) + "\n", false);
	if(flags[MARBLE_KIDS] > 0) outputText("<b>Children With Marble:</b> " + flags[MARBLE_KIDS] + "\n", false);
	if(flags[ANT_KIDS] > 0) outputText("<b>Ant Children With Phylla:</b> " + flags[ANT_KIDS] + "\n");
	if(flags[PHYLLA_DRIDER_BABIES_COUNT] > 0) outputText("<b>Drider Children With Phylla:</b> " + flags[PHYLLA_DRIDER_BABIES_COUNT] + "\n");
	if(flags[SHEILA_JOEYS] > 0) outputText("<b>Children With Sheila (Joeys):</b> " + flags[SHEILA_JOEYS] + "\n");
	if(flags[SHEILA_IMPS] > 0) outputText("<b>Children With Sheila (Imps):</b> " + flags[SHEILA_IMPS] + "\n");
	
	if(flags[SOPHIE_ADULT_KID_COUNT] > 0 || flags[SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) 
	{	
		outputText("<b>Children With Sophie:</b> ");
		var sophie:int = 0;
		if(flags[SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) sophie++;
		sophie += flags[SOPHIE_ADULT_KID_COUNT];
		if(flags[SOPHIE_EGG_COUNTER] > 0) sophie++;
		outputText(sophie + "\n");
	}
	if(player.statusAffectv2("Tamani") > 0) outputText("<b>Children With Tamani: </b>" + player.statusAffectv2("Tamani") + " (after all forms of natural selection)\n", false);
	if(urtaKids() > 0) outputText("<b>Children With Urta: </b>" + urtaKids() + "\n");
	if(flags[UNKNOWN_FLAG_NUMBER_00094] > 0) outputText("<b>Eggs Fertilized For Sophie: </b>" + (flags[UNKNOWN_FLAG_NUMBER_00094] + sophie) + "\n", false);
	if(emberAffection() > 0) outputText("<b>Ember Affection:</b> " + Math.round(emberAffection()) + "%\n");
	if(emberChildren() > 0) {
		outputText("<b>Ember Offspring (Males): </b>" + flags[EMBER_CHILDREN_MALES] + "\n");
		outputText("<b>Ember Offspring (Females): </b>" + flags[EMBER_CHILDREN_FEMALES] + "\n");
		outputText("<b>Ember Offspring (Herms): </b>" + flags[EMBER_CHILDREN_HERMS] + "\n");
	}
	if(flags[EMBER_EGGS] > 0) outputText("<b>Ember Eggs Produced:</b> " + flags[EMBER_EGGS] + "\n");
	if(helAffection() > 0) outputText("<b>Helia Affection: </b>" + Math.round(helAffection()) + "%\n");
	if(helAffection() >= 100) outputText("<b>Helia Bonus Points: </b>" + Math.round(flags[HEL_BONUS_POINTS]) + "\n");
	if(flags[ISABELLA_AFFECTION] > 0) {
		outputText("<b>Isabella Affection:</b> ", false);
		if(!isabellaFollower()) outputText(Math.round(flags[ISABELLA_AFFECTION]) + "%\n", false);
		else outputText("100%\n", false);
	}
	if(flags[ANEMONE_KID] > 0) {
		outputText("<b>Kid A's Confidence:</b> " + kidAXP() + "%\n");
	}
	if(flags[KIHA_AFFECTION_LEVEL] == 2) {
		if(followerKiha()) outputText("<b>Kiha Affection:</b> " + 100 + "%\n", false);
		else outputText("<b>Kiha Affection:</b> " + Math.round(flags[KIHA_AFFECTION]) + "%\n", false);
	}
	if(flags[AMILY_MET] > 0) outputText("<b>Litters With Amily: </b>" + (flags[AMILY_BIRTH_TOTAL]+ flags[PC_TIMES_BIRTHED_AMILYKIDS]) + "\n", false);
	//Lottie stuff
	if(flags[UNKNOWN_FLAG_NUMBER_00281] > 0) {
		outputText("<b>Lottie's Encouragement: </b>" + lottieMorale() + " (higher is better)\n", false);
		outputText("<b>Lottie's Figure: </b>" + lottieTone() + " (higher is better)\n", false);
	}
	//Mino sons
	if(flags[UNKNOWN_FLAG_NUMBER_00326] > 0) {
		outputText("<b>Number of Adult Minotaur Offspring: </b>" + flags[UNKNOWN_FLAG_NUMBER_00326] + "\n", false);
	}
	if(flags[OWCAS_ATTITUDE] > 0) outputText("<b>Owca's Attitude: </b>" + flags[OWCAS_ATTITUDE] + "\n");
	if(flags[SHEILA_XP] != 0) {
		outputText("<b>Sheila's Corruption: </b>" + sheilaCorruption());
		if(sheilaCorruption() > 100) outputText(" (Yes, it can go above 100)");
		outputText("\n");
	}
	if(player.hasStatusAffect("Kelt") >= 0 && flags[KELT_BREAK_LEVEL] == 0) {
		if(player.statusAffectv2("Kelt") >= 130) outputText("<b>Submissiveness To Kelt:</b> " + 100 + "%\n", false);
		else outputText("<b>Submissiveness To Kelt:</b> " + Math.round(player.statusAffectv2("Kelt")/130*100) + "%\n", false);
	}
	if(rubiAffection() > 0) outputText("<b>Rubi's Affection:</b> " + Math.round(rubiAffection()) + "%\n");
	if(rubiAffection() > 0) outputText("<b>Rubi's Orifice Capacity:</b> " + Math.round(rubiCapacity()) + "%\n");
	
	if(flags[URTA_COMFORTABLE_WITH_OWN_BODY] != 0) {
		if(urtaLove()) outputText("<b>Urta Status: </b>Lover\n");
		else if(flags[URTA_COMFORTABLE_WITH_OWN_BODY] == -1) outputText("<b>Urta Status: </b>Ashamed\n");
		else if(flags[URTA_PC_AFFECTION_COUNTER] < 30) outputText("<b>Urta Status: </b>" + Math.round(flags[URTA_PC_AFFECTION_COUNTER] * 3.3333) + "% Affection\n");
		else outputText("<b>Urta Status: </b>Ready To Confess Love\n");
	}
	
	outputText("\n<b><u>Ongoing Status Effects</u></b>\n", false);
	if(player.hasStatusAffect("heat") >= 0) outputText("Heat - " + Math.round(player.statusAffectv3("heat")) + " hours remaining.\n", false);
	if(player.hasStatusAffect("rut") >= 0) outputText("Rut - " + Math.round(player.statusAffectv3("rut")) + " hours remaining.\n", false);
	if(player.statusAffectv1("Luststick") > 0) outputText("Luststick - " + Math.round(player.statusAffectv1("Luststick")) + " hours remaining.\n", false);
	if(player.statusAffectv1("Black Cat Beer") > 0) outputText("Black Cat Beer - " + player.statusAffectv1("Black Cat Beer") + " hours remaining.  Lust resistance 20% lower, physical resistance 25% higher.\n");
	outputText("\n<b><u>Miscellaneous Stats</u></b>\n");
	outputText("<b>Eggs Traded For: </b>" + flags[EGGS_BOUGHT] + "\n");
	doNext(1);
}

function lustPercent():Number {
	var lust:Number = 100;
	//2.5% lust resistance per level - max 75.
	if(player.level < 21) lust -= (player.level - 1) * 3;
	else lust = 40;
	
	//++++++++++++++++++++++++++++++++++++++++++++++++++
	//ADDITIVE REDUCTIONS
	//THESE ARE FLAT BONUSES WITH LITTLE TO NO DOWNSIDE
	//TOTAL IS LIMITED TO 75%!
	//++++++++++++++++++++++++++++++++++++++++++++++++++
	//Corrupted Libido reduces lust gain by 10%!
	if(player.hasPerk("Corrupted Libido") >= 0) lust -= 10;
	//Acclimation reduces by 15%
	if(player.hasPerk("Acclimation") >= 0) lust -= 15;
	//Purity blessing reduces lust gain
	if(player.hasPerk("Purity Blessing") >= 0) lust -= 5;
	//Resistance = 10%
	if(player.hasPerk("Resistance") >= 0) lust -= 10;
	
	if(lust < 25) lust = 25;
	if(player.statusAffectv1("Black Cat Beer") > 0) {
		if(lust >= 80) lust = 100;
		else lust += 20;
	}
	lust += Math.round(player.perkv1("Pent Up")/2);
	//++++++++++++++++++++++++++++++++++++++++++++++++++
	//MULTIPLICATIVE REDUCTIONS
	//THESE PERKS ALSO RAISE MINIMUM LUST OR HAVE OTHER
	//DRAWBACKS TO JUSTIFY IT.
	//++++++++++++++++++++++++++++++++++++++++++++++++++
	//Bimbo body slows lust gains!
	if((player.hasStatusAffect("Bimbo Champagne") >= 0 || player.hasPerk("Bimbo Body") >= 0) && lust > 0) lust *= .75;
	if(player.hasPerk("Bro Body") >= 0 && lust > 0) lust *= .75;
	if(player.hasPerk("Futa Form") >= 0 && lust > 0) lust *= .75;
	//Omnibus' Gift reduces lust gain by 15%
	if(player.hasPerk("Omnibus' Gift") >= 0) lust *= .85;
	//Luststick reduces lust gain by 10% to match increased min lust
	if(player.hasPerk("Luststick Adapted") >= 0) lust *= 0.9;
	if(player.hasStatusAffect("Berzerking") >= 0) lust *= .6;
	if(player.hasPerk("Pure and Loving") >= 0) lust *= 0.95;
	lust = Math.round(lust);
	return lust;
}

//TODO stats function with dynamic arguments so you don't have to specify all those zeros each time.
//Modify stats
function stats(stre:Number, toug:Number, spee:Number, intel:Number, libi:Number, sens:Number, lust2:Number, corr:Number, resisted:Boolean = true) {
	//Easy mode cuts lust gains!
	if(flags[EASY_MODE_ENABLE_FLAG] == 1 && lust2 > 0 && resisted) lust2 /= 2;
	//Set original values to begin tracking for up/down values if
	//they aren't set yet.
	//These are reset when up/down arrows are hidden with 
	//hideUpDown();
	//Just check str because they are either all 0 or real values
	if(oldStr == 0) {
		oldStr = player.str;
		oldTou = player.tou;
		oldSpe = player.spe;
		oldInte = player.inte;
		oldLib = player.lib;
		oldSens = player.sens;
		oldLust = player.lust;
		oldCor = player.cor;
	}
	//MOD CHANGES FOR PERKS
	//Bimbos learn slower
	if(player.hasPerk("Futa Faculties") >= 0 || player.hasPerk("Bimbo Brains") >= 0  || player.hasPerk("Bro Brains") >= 0) {
		if(intel > 0) intel /= 2;
		if(intel < 0) intel *= 2;
	}
	if(player.hasPerk("Futa Form") >= 0 || player.hasPerk("Bimbo Body") >= 0  || player.hasPerk("Bro Body") >= 0) {
		if(libi > 0) libi *= 2;
		if(libi < 0) libi /= 2;
	}
	//If orgasm, set hours since cum to 0.
	if(lust2 <= -100) player.hoursSinceCum = 0;
	//lust resistance
	if(lust2 > 0 && resisted) lust2 *= lustPercent()/100;
	if(libi > 0 && player.hasPerk("Purity Blessing") >= 0) libi *= 0.75;
	if(corr > 0 && player.hasPerk("Purity Blessing") >= 0) corr *= 0.5;
	if(corr > 0 && player.hasPerk("Pure and Loving") >= 0) corr *= 0.75;
	//Change original stats
	player.str+=stre;
	player.tou+=toug;
	player.spe+=spee;
	player.inte+=intel;
	player.lib+=libi;
	if(player.sens > 50 && sens > 0) sens/=2;
	if(player.sens > 75 && sens > 0) sens/=2;
	if(player.sens > 90 && sens > 0) sens/=2;
	if(player.sens > 50 && sens < 0) sens*=2;
	if(player.sens > 75 && sens < 0) sens*=2;
	if(player.sens > 90 && sens < 0) sens*=2;
	player.sens+=sens;
	player.lust+=lust2;
	player.cor+=corr;
	//Bonus gain for perks!
	if(player.hasPerk("Strong") >= 0 && stre >= 0) player.str+=stre*player.perks[player.hasPerk("Strong")].value1;
	if(player.hasPerk("Tough") >= 0 && toug >= 0) player.tou+=toug*player.perks[player.hasPerk("Tough")].value1;
	if(player.hasPerk("Fast") >= 0 && spee >= 0) player.spe+=spee*player.perks[player.hasPerk("Fast")].value1;
	if(player.hasPerk("Smart") >= 0 && intel >= 0) player.inte+=intel*player.perks[player.hasPerk("Smart")].value1;
	if(player.hasPerk("Lusty") >= 0 && libi >= 0) player.lib+=libi*player.perks[player.hasPerk("Lusty")].value1;
	if(player.hasPerk("Sensitive") >= 0 && sens >= 0) player.sens+=sens*player.perks[player.hasPerk("Sensitive")].value1;
	//Keep stats in bounds
	if(player.cor < 0) player.cor = 0;
	if(player.cor > 100) player.cor= 100;
	if(player.str > 100) player.str = 100;
	if(player.str < 1) player.str = 1;
	if(player.tou > 100) player.tou = 100;
	if(player.tou < 1) player.tou = 1;
	if(player.spe > 100) player.spe = 100;
	if(player.spe < 1) player.spe = 1;
	if(player.inte > 100) player.inte= 100;
	if(player.inte < 1) player.inte = 1;
	if(player.lib > 100) player.lib = 100;
	//Minimum libido = 15.
	if(player.lib < 50 && player.armorName == "lusty maiden's armor") player.lib = 50;
	else if(player.lib < 15 && player.gender > 0) player.lib = 15;
	else if(player.lib < 10 && player.gender == 0) player.lib = 10;
	if(player.lib < minLust() * 2/3) player.lib = minLust() * 2/3;
	
	
	//Minimum sensitivity.
	if(player.sens > 100) player.sens = 100;
	if(player.sens < 10) player.sens = 10;
	
	//Add HP for toughness change.
	HPChange(toug*2, false);
	//Reduce hp if over max
	if(player.HP > maxHP()) player.HP = maxHP();
	
	//Combat bounds
	if(player.lust > 99) player.lust = 100;
	//if(player.lust < player.lib) {
	//	player.lust=player.lib;
	//
	//Update to minimum lust if lust falls below it.
	if(player.lust < minLust()) player.lust = minLust();
	//worms raise min lust!
	if(player.hasStatusAffect("infested") >= 0) {
		if(player.lust < 50) player.lust = 50;
	}
	if(player.lust > 100) player.lust = 100;
	if(player.lust < 0) player.lust = 0;
	//Display correct up/down arrow.
	if(player.cor < oldCor) {
		corDown.visible = true;
		corUp.visible = false;
	}
	if(player.cor > oldCor) {
		corUp.visible = true;
		corDown.visible = false;
	}
	if(player.lust < oldLust) {
		lustDown.visible = true;
		lustUp.visible = false;
	}
	if(player.lust > oldLust) {
		lustUp.visible = true;
		lustDown.visible = false;
	}
	if(player.sens < oldSens) {
		sensDown.visible = true;
		sensUp.visible = false;
	}
	if(player.sens > oldSens) {
		sensUp.visible = true;
		sensDown.visible = false;
	}
	if(player.lib < oldLib) {
		libDown.visible = true;
		libUp.visible = false;
	}
	if(player.lib > oldLib) {
		libUp.visible = true;
		libDown.visible = false;
	}
	if(player.inte < oldInte) {
		inteDown.visible = true;
		inteUp.visible = false;
	}
	if(player.inte > oldInte) {
		inteUp.visible = true;
		inteDown.visible = false;
	}
	if(player.spe < oldSpe) {
		speDown.visible = true;
		speUp.visible = false;
	}
	if(player.spe > oldSpe) {
		speUp.visible = true;
		speDown.visible = false;
	}
	if(player.tou < oldTou) {
		touDown.visible = true;
		touUp.visible = false;
	}
	if(player.tou > oldTou) {
		touUp.visible = true;
		touDown.visible = false;
	}
	if(player.str < oldStr) {
		strDown.visible = true;
		strUp.visible = false;
	}
	if(player.str > oldStr) {
		strUp.visible = true;
		strDown.visible = false;
	}
	//Refresh the stat pane with updated values
	statScreenRefresh();
}
function rand(max:Number):Number
{
	return int(Math.random()*max);
}
function range(min:Number, max:Number, round:Boolean = false):Number 
{
	var num:Number = (min + Math.random() * (max - min));

	if (round) return Math.round(num);
	return num;
}
function cuntChangeOld(cIndex:Number, vIndex:Number, display:Boolean):void {
	//Virginity check
	if(player.vaginas[vIndex].virgin) {
		if(display) outputText("\nYour " + vaginaDescript(vIndex) + " loses it's virginity!", false);
		player.vaginas[vIndex].virgin = false;
	}	
	//If cock is bigger than unmodified vagina can hold - 100% stretch!
	if(player.vaginas[vIndex].capacity() <= monster.cocks[cIndex].cArea()) {
		if(player.vaginas[vIndex] < 5) {
			trace("CUNT STRETCHED: By cock larger than it's total capacity.");
			if(display) {
				if(player.vaginas[vIndex].vaginalLooseness == 4) outputText("<b>Your " + vaginaDescript(0) + " is stretched even further, capable of taking even the largest of demons and beasts.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == 3) outputText("<b>Your " + vaginaDescript(0) + " painfully stretches, gaping wide-open.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == 2) outputText("<b>Your " + vaginaDescript(0) + " is now very loose.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == 1) outputText("<b>Your " + vaginaDescript(0) + " is now loose.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == 0) outputText("<b>Your " + vaginaDescript(0) + " looses its virgin-like tightness.</b>  ", false);
			}
			player.vaginas[vIndex].vaginalLooseness++;
		}
	}
	//If cock is within 75% of max, streeeeetch 33% of the time
	if(player.vaginas[vIndex].capacity() * .75 <= monster.cocks[cIndex].cArea()) {
		if(player.vaginas[vIndex] < 5) {
			trace("CUNT STRETCHED: By cock @ 75% of capacity.");
			if(display) {
				if(player.vaginas[vIndex].vaginalLooseness == 4) outputText("<b>Your " + vaginaDescript(0) + " is stretched even further, capable of taking even the largest of demons and beasts.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == 3) outputText("<b>Your " + vaginaDescript(0) + " painfully stretches, gaping wide-open.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == 2) outputText("<b>Your " + vaginaDescript(0) + " is now very loose.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == 1) outputText("<b>Your " + vaginaDescript(0) + " is now loose.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == 0) outputText("<b>Your " + vaginaDescript(0) + " looses its virgin-like tightness.</b>  ", false);
			}
			player.vaginas[vIndex].vaginalLooseness++;
		}
	}
}

function spriteSelect(choice:Number = 0):void {
	if(choice < 0 || flags[SHOW_SPRITES_FLAG]) sprite.visible = false;
	else {
		sprite.visible = true;
		sprite.gotoAndStop(choice);
		sprite.scaleX = 3;
		sprite.scaleY = 3;
	}
}

//DEPRECATED. Images are handled by ImageManager class in classes
/*loadImage("artPack/white_devil_urta.jpg");

function loadImage(imageURL:String) {
    var imageLoader:Loader = new Loader();
    imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, ImageLoaded); // event listener which is fired when loading is complete
    imageLoader.load(new URLRequest(imageURL));
	trace("Loading: " + imageURL);
}

function ImageLoaded(e:Event) {
    e.target.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, ImageLoaded);
    //this.addChild(e.target.loader.content); // loaded content is stored in e.target.loader.content variable
	images[images.length] = e.target.loader.content;
}
/*The stuff below is a stupid experiment, all except the following line:
<img src='artPack/white_devil_urta.jpg' width='400' height='514'/>
Drop that into the text in a scene and BLAMMO! You got an Urta pic. It looks like you need to 
have the width and height both specified to do it

//Deprecated. Using showImage from ImageManager now.
function showImage(arg:Number = 0):void {
	if(arg > images.length-1) {
		trace("Attempt to show invalid image!");
		return;
	}
	addChild(images[arg]);
	var ratio:Number = images[arg].width/images[arg].height;
	images[arg].x = 208.5;
	images[arg].y = 62;
	images[arg].width = 300;
	images[arg].height = images[arg].width/ratio;
	mainText.x += 305;
	mainText.width = 466.4;
}
function clearImages():void {
	for(var x:int = 0; x < images.length; x++) {
		if(stage.contains(images[x])) removeChild(images[x]);
	}
	mainText.x = 208.5;
	mainText.width = 771.4;
}*/