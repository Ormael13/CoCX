import classes.Appearance;
import classes.CockTypesEnum;
import classes.internals.Utils;

public function sackDescript():String
{
	return Appearance.sackDescript(player);
}

public function cockClit(number:int = 0):String {
	if(player.hasCock() && number >= 0 && number < player.cockTotal()) return cockDescript(number);
	else return clitDescript();
}
public function balls(balls:*,noballs:*):String {
	if(player.balls > 0) return balls;
	return noballs;
}
public function sheathDesc():String {
	return Appearance.sheathDescription(player);
}
public function chestDesc():String {
	return Appearance.chestDesc(player);
}
public function allChestDesc():String {
	if(player.biggestTitSize() < 1) return "chest";
	else return allBreastsDescript();
}
public function sMultiCockDesc():String {
	return Appearance.cockMultiDesc(player, false, false);
}
public function SMultiCockDesc():String {
	return Appearance.cockMultiDesc(player, true, false);
}
public function oMultiCockDesc():String {
	return Appearance.cockMultiDesc(player, false, true);
}
public function OMultiCockDesc():String {
	return Appearance.cockMultiDesc(player, true, true);
}
public function tongueDescript():String {
	return Appearance.tongueDescription(player);
}

public function ballsDescriptLight(forcedSize:Boolean = true):String {
	return Appearance.ballsDescription(forcedSize, true, player);
}

public function ballDescript():String {
	return Appearance.ballsDescription(false, false, player);
}

public function eBallsDescriptLight():String {
	return Appearance.ballsDescription(true, true, monster);
}
public function eBallsDescript():String {
	return Appearance.ballsDescription(true, true, monster, true);
}

public function ballsDescript():String {
	return Appearance.ballsDescription(false, true, player, true);
}
public function simpleBallsDescript():String {
	return Appearance.ballsDescription(false, true, player);
}

public function assholeDescript():String {
	return Appearance.assholeDescript(player);
}
public function eAssholeDescript():String {
	return Appearance.assholeDescript(monster);
}
		
public function hipDescript():String {
	return Appearance.hipDescription(player);
}
public function assDescript():String {
	return buttDescript();
}
public function buttDescript():String {
	return Appearance.buttDescription(player);
}
public function eButtDescript():String {
	return Appearance.buttDescriptionShort(monster);	
}

public function num2TextBest(number:int, capitalised:Boolean = false, positional:Boolean = false):String
{
	var returnVar:String = "";
	var numAsWords:Array; 
	if (positional)
		numAsWords = new Array("zeroth", "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth");
	else
		numAsWords = new Array("zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten");

	if (number > 10 || int(number) != number)
	{
		if (positional)
		{
			returnVar = number.toString();
			if (returnVar.charAt(returnVar.length - 1) == "1")
				returnVar += "st";
			else if (returnVar.charAt(returnVar.length - 1) == "2")
				returnVar += "nd";
			else if (returnVar.charAt(returnVar.length - 1) == "3")
				returnVar += "rd";
			else
				returnVar += "th";
		}
		else		
			returnVar = number.toString();
	} 
	else
	{
		returnVar = numAsWords[number];
	}
	
	if (capitalised)
	{
		var firstChar:String = returnVar.substr(0, 1);
		var restOfString:String = returnVar.substr(1, returnVar.length);		
		returnVar = firstChar.toUpperCase()+restOfString.toLowerCase(); 
	}
	return returnVar;
}

public function num2Text(number:int):String {
	return num2TextBest(number);
}
public function num2Text2(number:int):String {
	return num2TextBest(number, false, true);
}
public function Num2Text(number:int):String {
	return num2TextBest(number, true);
}
public function nippleDescript(rowNum:Number):String {
	return Appearance.nippleDescription(player, rowNum);
}

public function hairDescript():String {
	return Appearance.hairDescription(player);
}

public function hairOrFur():String {
	return Appearance.hairOrFur(player);
}

public function clitDescript():String {
	return Appearance.clitDescription(player);
}

//Vaginas + Descript
public function vaginaDescript(vaginaNum:Number = 0):String {
	return Appearance.vaginaDescript(player, vaginaNum);
}

//Allvagina descript
public function allVaginaDescript():String {
	if (player.vaginas.length == 1) return vaginaDescript(rand(player.vaginas.length - 1));
	if (player.vaginas.length > 1) return (vaginaDescript(rand(player.vaginas.length - 1)) + "s");
	
	CoC_Settings.error("ERROR: allVaginaDescript called with no vaginas.");
	return "ERROR: allVaginaDescript called with no vaginas.";
}
public function multiCockDescript():String {
	return Appearance.multiCockDescript(player);
}

public function multiCockDescriptLight():String {
	return Appearance.multiCockDescriptLight(player);
}
public function eMultiCockDescriptLight():String {
	if(monster.cocks.length < 1) 
	{
		CoC_Settings.error("");
		return "<B>Error: eMultiCockDescriptLight() called with no penises present.</B>";
	}
	//Get cock counts
	var descript:String="";
	var currCock:Number = 0;
	var totCock:Number = monster.cocks.length;
	var dogCocks:Number = 0;
	var horseCocks:Number = 0;
	var normalCocks:Number = 0;
	var normalCockKey:Number = 0;
	var dogCockKey:Number = 0;
	var horseCockKey:Number = 0;
	var averageLength:Number = 0;
	var averageThickness:Number = 0;
	var same:Boolean = true;
	//For temp14 random values
	var rando:Number = 0;
	var descripted:Boolean = false;
	//If one, return normal cock descript
	if(totCock == 1) return eCockDescript(0);
	//Count cocks & Prep average totals
	while(currCock <= totCock-1) {
		if(monster.cocks[currCock].cockType == CockTypesEnum.HUMAN) {
			normalCocks++;
			normalCockKey = currCock;
		}
		if(monster.cocks[currCock].cockType == CockTypesEnum.HORSE) {
			horseCocks++;
			horseCockKey = currCock;
		}
		if(monster.cocks[currCock].cockType == CockTypesEnum.DOG) {
			dogCocks++;
			dogCockKey = currCock;
		}
		averageLength += monster.cocks[currCock].cockLength;
		averageThickness += monster.cocks[currCock].cockThickness;
		//If cocks are matched make sure they still are
		if(same && currCock > 0 && monster.cocks[currCock].cockType != monster.cocks[currCock-1].cockType) same = false;
		currCock++;
	}
	//Crunch averages
	averageLength /= currCock;
	averageThickness /= currCock;
	//Quantity descriptors
	if(currCock == 1) {
		if(dogCocks == 1) return eCockDescript(0);
		if(horseCocks == 1) return eCockDescript(0);
		if(normalCocks == 1) return eCockDescript(0);
		//Failsafe
		return eCockDescript(0);
	}
	if(currCock == 2) {
		//For cocks that are the same
		if(same) {
			descript += Utils.randomChoice("pair of ", "two ", "brace of ", "matching ", "twin ");
			descript += eCockAdjectives(averageLength, averageThickness, monster.cocks[0].cockType);
			if(normalCocks == 2) descript += eCockNoun(CockTypesEnum.HUMAN) + "s";
			if(horseCocks == 2) descript += eCockNoun(CockTypesEnum.HORSE) + "s";
			if(dogCocks == 2) descript += eCockNoun(CockTypesEnum.DOG) + "s";
			//Failsafe
			if(monster.cocks[0].cockType.Index > 2) descript += eCockNoun(monster.cocks[0].cockType) + "s";
		}
		//Nonidentical
		else {
			descript += Utils.randomChoice("pair of ", "two ", "brace of ");
			descript += eCockAdjectives(averageLength, averageThickness, monster.cocks[0].cockType);
			descript += Utils.randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
		}
	}
	if(currCock == 3) {
		//For samecocks
		if(same) {
			descript += Utils.randomChoice("three ", "group of ", "menage a trois of ", "triad of ", "triumvirate of ");
			descript += eCockAdjectives(averageLength, averageThickness, monster.cocks[currCock-1].cockType);
			if(normalCocks == 3) descript += eCockNoun(CockTypesEnum.HUMAN) + "s";
			if(horseCocks == 3) descript += eCockNoun(CockTypesEnum.HORSE) + "s";
			if(dogCocks == 3) descript += eCockNoun(CockTypesEnum.DOG) + "s";
			//Tentacles
			if(monster.cocks[0].cockType.Index > 2) descript += eCockNoun(monster.cocks[0].cockType) + "s";
		}
		else {
			descript += Utils.randomChoice("three ", "group of ");
			descript += eCockAdjectives(averageLength, averageThickness, monster.cocks[0].cockType);
			descript += Utils.randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
		}
	}
	//Large numbers of cocks!
	if(currCock > 3)
	{
		descript += Utils.randomChoice("bundle of ", "obscene group of ", "cluster of ", "wriggling bunch of ");
		//Cock adjectives and nouns
		descripted = false;
		//Same
		if(same) {
			if(currCock == normalCocks) {
				descript += eCockAdjectives(averageLength, averageThickness, CockTypesEnum.HUMAN);	
				descript += eCockNoun(CockTypesEnum.HUMAN) + "s";
				descripted = true;
			}
			if(currCock == dogCocks) {
				descript += eCockAdjectives(averageLength, averageThickness, CockTypesEnum.DOG);
				descript += eCockNoun(CockTypesEnum.DOG) + "s";
				descripted = true;
			}
			if(currCock == horseCocks) {
				descript += eCockAdjectives(averageLength, averageThickness, CockTypesEnum.HORSE);
				descript += eCockNoun(CockTypesEnum.HORSE) + "s";
				descripted = true;			
			}
			if(monster.cocks[0].cockType.Index > 2) {
				descript += eCockAdjectives(averageLength, averageThickness, CockTypesEnum.HUMAN);
				descript += eCockNoun(monster.cocks[0].cockType) + "s";
				descripted = true;			
			}
		}
		//If mixed
		if(!descripted) {
			descript += eCockAdjectives(averageLength, averageThickness, monster.cocks[0].cockType);
			descript += Utils.randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
		}
	}	
	return descript;
}

public function eCockHead(cockNum:Number = 0):String {
	if(cockNum < 0) 
	{
		CoC_Settings.error("");
		return "ERROR";
	}
	if(cockNum > monster.cocks.length-1) 
	{
		CoC_Settings.error("");
		return "ERROR";
	}
	if(monster.cocks[cockNum].cockType == CockTypesEnum.HORSE) {
		if(rand(2) == 0) return "flare";
		else return "flat tip";
	}
	if(monster.cocks[cockNum].cockType == CockTypesEnum.DOG) {
		if(rand(2) == 0) return "pointed tip";
		else return "narrow tip";
	}
	if(monster.cocks[cockNum].cockType == CockTypesEnum.DEMON) {
		if(rand(2) == 0) return "tainted crown";
		else return "nub-ringed tip";
	}
	if(monster.cocks[cockNum].cockType == CockTypesEnum.TENTACLE) {
		if(rand(2) == 0) return "mushroom-like tip";
		else return "wide plant-like crown";
	}
	if(monster.cocks[cockNum].cockType == CockTypesEnum.CAT) {
		if(rand(2) == 0) return "point";
		else return "narrow tip";
	}
	if(monster.cocks[cockNum].cockType == CockTypesEnum.LIZARD) {
		if(rand(2) == 0) return "crown";
		else return "head";
	}
	if(monster.cocks[cockNum].cockType == CockTypesEnum.LIZARD) {
		if(rand(2) == 0) return "blue tip";
		else return "wiggling crown";
	}
	if(monster.cocks[cockNum].cockType == CockTypesEnum.KANGAROO) {
		if(rand(2) == 0) return "tip";
		else return "point";
	}
	if(rand(2) == 0) return "crown";
	if(rand(2) == 0) return "head";
	return "cock-head";
}

//Used in multiCockDescript and potentially elsewhere - barebones cock names
public function eCockNoun(i_cockType:CockTypesEnum):String {
	return Appearance.cockMultiNoun(i_cockType);
}
//Used in multiCockDescript to avoid duplicate code
public function eCockAdjectives(cLength:Number, thickness:Number, type:CockTypesEnum):String {
	var descript:String = "";
	var rando:Number = 0;
	var descripted:Boolean = false;
	//length or thickness, usually length. 
	if(rand(2) == 0) {
		if(cLength < 3) {
			if(rand(3) == 0) descript = "squat ";
			else descript = "tiny ";
		}
		if(cLength >= 3 && cLength < 5) {
			if(rand(2) == 0) descript = "short ";
			else descript = "small ";
		}
		if(cLength >= 5 && cLength < 7) {
			if(rand(2) == 0) descript = "average ";
			else descript = "ordinary ";
		}
		if(cLength >= 7 && cLength < 9) {
			if(rand(2) == 0) descript = "long ";
			else descript = "lengthy ";
		}
		if(cLength >= 10 && cLength < 13) {
			if(rand(2) == 0) descript = "huge ";
			else descript = "foot-long ";
		}
		if(cLength >= 13 && cLength < 18) {
			if(rand(2) == 0) descript = "massive ";
			else descript = "horse-length ";
		}
		if(cLength >= 18 && cLength < 30) {
			if(rand(2) == 0) descript = "enormous ";
			else descript = "monster-length ";
		}
		if(cLength >= 30) {
			if(rand(2) == 0) descript = "towering ";
			else descript = "freakish ";
		}
		descripted = true;
	}
	//thickness go!
	if(rand(3) == 0 && !descripted) {
		if(thickness <= .75) descript += "narrow "
		if(thickness > 1 && thickness <= 1.4) {
			if(rand(2) == 0) descript += "ample ";
			else descript += "big ";
		}
		if(thickness > 1.4 && thickness <= 2) {
			if(rand(2) == 0) descript += "broad ";
			else descript += "girthy ";
		}
		if(thickness > 2 && thickness <= 3.5) {
			if(rand(2) == 0) descript += "fat ";
			else descript += "distended ";
		}
		if(thickness > 3.5) {
			if(rand(2) == 0) descript += "inhumanly distended ";
			else descript += "monstrously thick ";
		}
		descripted = true;
	}
	//Length/Thickness done.  Moving on to special animal characters/lust stuff.
	//Only room for one of these adjectives.
	//Lust stuff
	if(monster.lust > 90 && rand(2) == 0) {
		//lots of cum? drippy.
		if(monster.cumQ() > 50 && monster.cumQ() < 200 && rand(2) == 0) {
			//for hroses and dogs
			if(type == CockTypesEnum.HORSE || type == CockTypesEnum.DOG || CockTypesEnum.CAT || CockTypesEnum.KANGAROO) descript += "animal-pre leaking ";
			else descript += "pre-slickened ";
			descripted = true;
		}
		//Tons of cum
		if(monster.cumQ() >= 200 && rand(2) == 0) {
			//for horses and dogs
			if(type == CockTypesEnum.HORSE || type == CockTypesEnum.DOG || CockTypesEnum.CAT || CockTypesEnum.KANGAROO) descript += "animal-spunk dripping ";
			else descript += "cum-drooling ";
			descripted = true;
		}
		//Not descripted? Pulsing and twitching
		if(!descripted){
			if(rand(2) == 0) descript += "throbbing ";
			else descript += "pulsating ";
			descripted = true;
		}
	}
	//A little less lusty, but still lusty.
	if(monster.lust > 75 && monster.lust <= 90 && rand(3) == 0) {
		if(!descripted && monster.cumQ() > 50 && monster.cumQ() < 200 && rand(2) == 0) {
			descript += "pre-leaking ";
			descripted = true;
		}
		if(!descripted && player.cumQ() >= 200 && rand(2) == 0) {
			descript += "pre-cum dripping ";
			descripted = true;
		}
		if(!descripted) {
			if(rand(2) == 0) descript += "rock-hard ";
			else descript += "eager ";
			descripted = true;
		}
	}
	//animal fillers
	if(type == CockTypesEnum.HORSE && !descripted && rand(2) == 0) {
		if(rand(2) == 0) descript += "flared ";
		else descript += "musky ";
		descripted = true;
	}
	if((type == CockTypesEnum.DOG || CockTypesEnum.CAT) && !descripted && rand(2) == 0) {
		if(rand(2) == 0) descript += "musky ";
		else descript += "pointed ";
		descripted = true;
	}
	return descript;
}


//New cock adjectives.  The old one sucked dicks
public function cockAdjective(cockNum:Number = -1) : String
{
	return Appearance.cockAdjective(player, cockNum);
}

//Used in multiCockDescript to avoid duplicate code
public function cockAdjectives(i_cockLength:Number, i_cockThickness:Number, i_cockType:Number):String 
{
	//Just in case...
	//TODO Remove if never called
	CoC_Settings.error("");
	trace("ERROR: Someone is still calling cockAdjectives with an integer cock type");
	var cockType:CockTypesEnum = CockTypesEnum.ParseConstantByIndex(int(i_cockType));
	return Appearance.cockAdjectives(i_cockLength, i_cockThickness, cockType, player);
}


public function cockDescript(cockNum:Number = 0):String 
{
	return Appearance.cockDescription(player, cockNum);
}

public function humanDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) 
	{
		CoC_Settings.error("");
		return "<b>ERROR: humanDescript Called But No Cock Present</b>";
	}
	if(cockNum > (player.cocks.length - 1)) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cock number (" + cockNum + ") passed to kangaDescript()</b>";
	}
	if(cockNum < 0) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cockNum (" + cockNum + ") passed to kangaDescript()</b>";
	}
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}

public function kangaDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) 
	{
		CoC_Settings.error("");
		return "<b>ERROR: kangaDescript Called But No Cock Present</b>";
	}
	if(cockNum > (player.cocks.length - 1)) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cock number (" + cockNum + ") passed to kangaDescript()</b>";
	}
	if(cockNum < 0) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cockNum (" + cockNum + ") passed to kangaDescript()</b>";
	}
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}
public function dogDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) 
	{
		CoC_Settings.error("");
		return "<b>ERROR: CockDescript Called But No Cock Present</b>";
	}
	if(cockNum > (player.cocks.length - 1)) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cock number (" + cockNum + ") passed to dogDescript()</b>";
	}
	if(cockNum < 0) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cockNum (" + cockNum + ") passed to dogDescript()</b>";
	}
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(CockTypesEnum.DOG);
	return descript;
}
public function foxDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) 
	{
		CoC_Settings.error("");
		return "<b>ERROR: CockDescript Called But No Cock Present</b>";
	}
	if(cockNum > (player.cocks.length - 1)) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cock number (" + cockNum + ") passed to foxDescript()</b>";
	}
	if(cockNum < 0) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cockNum (" + cockNum + ") passed to foxDescript()</b>";
	}
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(CockTypesEnum.FOX);
	return descript;
}
public function tentacleDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) 
	{
		CoC_Settings.error("");
		return "<b>ERROR: CockDescript Called But No Cock Present</b>";
	}
	if(cockNum > (player.cocks.length - 1)) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cock number (" + cockNum + ") passed to tentacleDescript()</b>";
	}
	if(cockNum < 0) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cockNum (" + cockNum + ") passed to tentacleDescript()</b>";
	}
	//50% of the time add a descriptor
	if(rand(2) == 0) 
		descript += cockAdjective(cockNum) + ", ";

	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}
public function demonDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) 
	{
		CoC_Settings.error("");
		return "<b>ERROR: CockDescript Called But No Cock Present</b>";
	}
	if(cockNum > (player.cocks.length - 1)) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cock number (" + cockNum + ") passed to demonDescript()</b>";
	}
	if(cockNum < 0) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cockNum (" + cockNum + ") passed to demonDescript()</b>";
	}
	//50% of the time add a descriptor
	if(rand(2) == 0) 
		descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);

	// trace("DemonDescript Output - ", descript);
	// trace("Appearance.CockNoun = ", Appearance.cockNoun(player.cocks[cockNum].cockType), "cockType", player.cocks[cockNum].cockType);
	return descript;
}


//Horsecock + Descript
public function horseDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) 
	{
		CoC_Settings.error("");
		return "<b>ERROR: CockDescript Called But No Cock Present</b>";
	}
	if(cockNum > (player.cocks.length - 1)) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cock number (" + cockNum + ") passed to horseDescript()</b>";
	}
	if(cockNum < 0) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cockNum (" + cockNum + ") passed to horseDescript()</b>";
	}
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(CockTypesEnum.HORSE);
	return descript;
}

public function catDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) 
	{
		CoC_Settings.error("");
		return "<b>ERROR: catDescript Called But No Cock Present</b>";
	}
	if(cockNum > (player.cocks.length - 1)) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cock number (" + cockNum + ") passed to catDescript()</b>";
	}
	if(cockNum < 0) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cockNum (" + cockNum + ") passed to catDescript()</b>";
	}
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}

public function anemoneDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) 
	{
		CoC_Settings.error("");
		return "<b>ERROR: anemoneDescript Called But No Cock Present</b>";
	}
	if(cockNum > (player.cocks.length - 1)) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cock number (" + cockNum + ") passed to anemoneDescript()</b>";
	}
	if(cockNum < 0) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cockNum (" + cockNum + ") passed to anemoneDescript()</b>";
	}
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}
public function dragonDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) 
	{
		CoC_Settings.error("");
		return "<b>ERROR: dragonDescript Called But No Cock Present</b>";
	}
	if(cockNum > (player.cocks.length - 1)) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cock number (" + cockNum + ") passed to dragonDescript()</b>";
	}
	if(cockNum < 0) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cockNum (" + cockNum + ") passed to dragonDescript()</b>";
	}
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}

public function displacerDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) 
	{
		CoC_Settings.error("");
		return "<b>ERROR: dragonDescript Called But No Cock Present</b>";
	}
	if(cockNum > (player.cocks.length - 1)) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cock number (" + cockNum + ") passed to dragonDescript()</b>";
	}
	if(cockNum < 0) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cockNum (" + cockNum + ") passed to dragonDescript()</b>";
	}
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}


public function snakeDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) 
	{
		CoC_Settings.error("");
		return "<b>ERROR: snakeDescript Called But No Cock Present</b>";
	}
	if(cockNum > (player.cocks.length - 1)) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cock number (" + cockNum + ") passed to snakeDescript()</b>";
	}
	if(cockNum < 0) 
	{
		CoC_Settings.error("");
		return "<B>Error: Invalid cockNum (" + cockNum + ") passed to snakeDescript()</b>";
	}
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}
//Vaginas + Descript
public function eVaginaDescript(vaginaNum:Number):String {
	return Appearance.vaginaDescript(monster,vaginaNum);
}

//Enemy cock description
public function eCockDescript(cockIndex:Number = 0):String {
	return Appearance.cockDescriptionShort(cockIndex, monster);
}
public function allBreastsDescript():String {
	return Appearance.allBreastsDescript(player);
}
	
public function biggestBreastSizeDescript():String {
	return Appearance.biggestBreastSizeDescript(player);
}

public function breastSize(val:Number):String {
	return Appearance.breastSize(val);
}
public function breastDescript(rowNum:Number):String
{
	return player.breastDescript(rowNum);
}
public function cockHead(cockNum:Number = 0):String {
	var temp:int;
	if(cockNum < 0) 
	{
		CoC_Settings.error("");
		return "ERROR";
	}
	if(cockNum > player.cocks.length-1) 
	{
		CoC_Settings.error("");
		return "ERROR";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.HORSE) {
		if(rand(2) == 0) return "flare";
		else return "flat tip";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.DOG) {
		if(rand(2) == 0) return "pointed tip";
		else return "narrow tip";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.DEMON) {
		if(rand(2) == 0) return "tainted crown";
		else return "nub-ringed tip";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.TENTACLE) {
		if(rand(2) == 0) return "mushroom-like tip";
		else return "wide plant-like crown";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.CAT) {
		if(rand(2) == 0) return "point";
		else return "narrow tip";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.LIZARD) {
		if(rand(2) == 0) return "crown";
		else return "head";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.LIZARD) {
		if(rand(2) == 0) return "blue tip";
		else return "wiggling crown";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.KANGAROO) {
		if(rand(2) == 0) return "tip";
		else return "point";
	}
	if(player.cocks[cockNum].cockType == CockTypesEnum.DISPLACER) {
		temp = rand(5);
		if(temp == 0) return "star tip";
		else if(temp == 1) return "blooming cock-head";
		else if(temp == 2) return "open crown";
		else if(temp == 3) return "alien tip";
		else return "bizarre head";
	}
	if(rand(2) == 0) return "crown";
	if(rand(2) == 0) return "head";
	return "cock-head";
}


public function npcBreastDescript(size:Number):String
{
	//ERROR PREVENTION
	var temp14:int = Math.random()*3;
	var descript:String = "";
	if(size == 0) return "flat breasts";
	//50% of the time size-descript them
	if(rand(2) == 0) descript += breastSize(size);
	//Nouns!
	temp14 = rand(10);
	if(temp14 == 0) descript += "breasts";
	if(temp14 == 1) descript += "breasts";
	if(temp14 == 2) {
		if(size > 4) descript += "tits";
		else descript += "breasts";
	}
	if(temp14 == 3) {
		//if(size > 6) descript += "rack";
		descript += "breasts";
	}
	if(temp14 == 4) descript += "tits";
	if(temp14 == 5) descript += "tits";
	if(temp14 == 6) descript += "tits";
	if(temp14 == 7) descript += "jugs";
	if(temp14 == 8) {
		if(size > 6) descript += "love-pillows";
		else descript += "boobs";
	}
	if(temp14 == 9) {
		if(size > 6) descript += "tits";
		else descript += "breasts";
	}
	return descript;
}

public function breastCup(size:Number):String {
	return Appearance.breastCup(size);
}
/**
Test event for the breastCupInverse(). Test passed so you can remove this.

 Produced output:
	 flat -> 0 (flat, manly breast), ok
	 A -> 1 (A-cup), ok
	 B -> 2 (B-cup), ok
	 C -> 3 (C-cup), ok
	 D -> 4 (D-cup), ok
	 DD -> 5 (DD-cup), ok
	 DD+ -> 6 (big DD-cup), ok
	 E -> 7 (E-cup), ok
	 E+ -> 8 (big E-cup), ok
	 EE -> 9 (EE-cup), ok
	 F -> 11 (F-cup), ok
	 HH+ -> 22 (big HH-cup), ok
	 K+ -> 33 (big K-cup), ok
	 MMM -> 44 (MMM-cup), ok
	 P+ -> 55 (large P-cup), ok
	 S -> 66 (S-cup), ok
	 UU+ -> 77 (large UU-cup), ok
	 XX -> 88 (XX-cup), ok
	 ZZZ+ -> 99 (large ZZZ-cup), ok
*/
/*public function breastCupInverseTest():void{
	//just test first row and the diagonal
	var inputs:Array = ["flat",	"A","B","C","D","DD",	"DD+",	"E","E+",	"EE",	"F","HH+",	"K+",	"MMM",	"P+",	"S","UU+",	"XX",	"ZZZ+"];
	var outputs:Array = [0,		1,	2,	3,	4,	5,		6,		7,	8,		9,		11,	22,		33,		44,		55,		66,	77,		88,		99];
	for (var i:int = 0; i<inputs.length; i++){
		var arg:String = inputs[i];
		var val:Number = outputs[i];
		var got:Number = Appearance.breastCupInverse(arg);
		outputText(arg+" -> "+got+" ("+breastCup(got)+"), ");
		if (val==got) outputText("ok\n");
		else outputText("expected "+val+" ("+breastCup(val)+").\n");
	}
	doNext(1);
}*/

public function NPCCockDescript(cockType:*, cockLength:Number = 0, lust:Number = 50):String 
{
	var descript:String = "";
	
	// TODO: remove in a few months
	// need to handle older saves where cockType is still a number
	if (cockType is Number)
	{
		cockType = CockTypesEnum.ParseConstantByIndex(cockType);
	}

	if(cockType != CockTypesEnum.HUMAN)
	{
		descript += NPCCockAdjective(cockType,cockLength,lust);
		descript += ", ";
		descript += NPCCockNoun(cockType);
	}
	else
	{
		descript += NPCCockAdjective(cockType,cockLength,lust);
		descript += " ";
		descript += NPCCockNoun(cockType);
	}
	return descript;
}
	
//Modular NPC dicks!
public function NPCCockNoun(i_cockType:CockTypesEnum):String
{
	return Appearance.cockNoun(i_cockType);
}

//Multipurpose NPC cock descs
public function NPCCockAdjective(cockType:CockTypesEnum, cockLength:Number = 5, lust:Number = 50):String 
{	
	var descript:String = "";
	var rando:Number = 0;
	var multi:Boolean = false;
	//Length 1/3 chance
	if(rand(2) == 0) {
		if(cockLength < 3) {
			descript += Utils.randomChoice("little", "toy-sized", "mini", "budding", "tiny");
		}
		else if(cockLength < 5) {
			descript += Utils.randomChoice("short", "small");
		}
		else if(cockLength < 7) {
			descript += Utils.randomChoice("fair-sized", "nice");
		}
		else if(cockLength < 9) {
			rando = rand(3);
			if(rando == 0) {
				if(cockType == CockTypesEnum.HORSE) descript = "pony-sized";
				else descript = "long";
			}
			else if(rando == 1) {
				if(cockType == CockTypesEnum.HORSE) descript = "colt-like";
				else descript = "lengthy";
			}
			else descript = "sizable";
		}
		else if(cockLength < 13) {
			rando = rand(3);
			if(rando == 0) descript = "huge";
			else if(rando == 1) {
				if(cockType == CockTypesEnum.DOG) 
					descript = "mastiff-like";
				else descript = "cucumber-length";
			}
			else descript = "foot-long";
		}
		else if(cockLength < 18) {
			descript += Utils.randomChoice("massive", "knee-length", "forearm-length");
		}
		else if(cockLength < 30) {
			descript += Utils.randomChoice("enormous", "giant", "arm-like");
		}
		else {
			rando = rand(4);
			if(cockType == CockTypesEnum.TENTACLE && rand(4) == 0) descript = "coiled ";
			else {
				if(rando == 0) descript = "towering";
				else if(rando == 1) descript = "freakish";
				else if(rando == 2) descript = "monstrous";
				else descript = "massive";
			}
		}
	}
	//Hornyness 1/2
	else if(lust > 75 && rand(2) == 0) {
		//Uber horny like a baws!
		if(lust > 90) {
			//Weak as shit cum
			if(rand(2) == 0) descript += "throbbing";
			else descript += "pulsating";
		}
		//A little less lusty, but still lusty.
		else if(lust > 75) {
			descript += Utils.randomChoice("turgid", "blood-engorged", "rock-hard", "stiff", "eager");
		}
	}
	//Girth - fallback
	else {
		if(cockLength/6 <= .75) {
			descript += Utils.randomChoice("thin", "slender", "narrow");
		}
		else if(cockLength/6 <= 1.2) {
			descript += "ample";
		}
		else if(cockLength/6 <= 1.4) {
			descript += Utils.randomChoice("ample", "big");
		}
		else if(cockLength/6 <= 2) {
			descript += Utils.randomChoice("broad", "girthy", "meaty");
		}
		else if(cockLength/6 <= 3.5) {
			descript += Utils.randomChoice("fat", "wide", "distended");
		}
		else if(cockLength/6 > 3.5) {
			descript += Utils.randomChoice("inhumanly distended", "bloated", "monstrously thick");
		}
	}
	return descript;
}
