import classes.Cock;
import classes.CockTypesEnum;
import classes.Appearance;
import classes.Player;

function sackDescript():String
{
	return Appearance.sackDescription(player);
}

function cockClit(number:int = 0):String {
	if(player.hasCock() && number >= 0 && number < player.cockTotal()) return cockDescript(number);
	else return clitDescript();
}
function balls(balls,noballs):String {
	if(player.balls > 0) return balls;
	return noballs;
}
function sheathDesc():String {
	return Appearance.sheathDescription(player);
}
function chestDesc():String {
	if(player.biggestTitSize() < 1) return "chest";
	else return biggestBreastSizeDescript();
}
function allChestDesc():String {
	if(player.biggestTitSize() < 1) return "chest";
	else return allBreastsDescript();
}
function sMultiCockDesc():String {
	return Appearance.cockMultiDesc(player, false, false);
}
function SMultiCockDesc():String {
	return Appearance.cockMultiDesc(player, true, false);
}
function oMultiCockDesc():String {
	return Appearance.cockMultiDesc(player, false, true);
}
function OMultiCockDesc():String {
	return Appearance.cockMultiDesc(player, true, true);
}
function tongueDescript():String {
	return Appearance.tongueDescription(player);
}

function ballsDescriptLight(forcedSize:Boolean = true):String {
	return Appearance.ballsDescription(forcedSize, true, player);
}

function ballDescript():String {
	return Appearance.ballsDescription(false, false, player);
}

function eBallsDescriptLight():String {
	return Appearance.ballsDescription(true, true, monster);
}
function eBallsDescript():String {
	return Appearance.ballsDescription(true, true, monster, true);
}

function ballsDescript():String {
	return Appearance.ballsDescription(false, true, player, true);
}
function simpleBallsDescript():String {
	return Appearance.ballsDescription(false, true, player);
}

function assholeDescript():String {
	return Appearance.assholeDescription(player);
}
function eAssholeDescript():String {
	return Appearance.assholeDescription(monster);
}
		
function hipDescript():String {
	return Appearance.hipDescription(player);
}
function assDescript():String {
	return buttDescript();
}
function buttDescript():String {
	return Appearance.buttDescription(player);
}
function eButtDescript():String {
	return Appearance.buttDescriptionShort(monster);	
}

function num2TextBest(number:int, capitalised:Boolean = false, positional:Boolean = false):String
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

function num2Text(number:int):String {
	return num2TextBest(number);
}
function num2Text2(number:int):String {
	return num2TextBest(number, false, true);
}
function Num2Text(number:int):String {
	return num2TextBest(number, true);
}
function nippleDescript(rowNum:Number):String {
	return Appearance.nippleDescription(player, rowNum);
}

function hairDescript():String {
	return Appearance.hairDescription(player);
}

function hairOrFur():String {
	return Appearance.hairOrFur(player);
}

function clitDescript():String {
	return Appearance.clitDescription(player);
}

//Vaginas + Descript
function vaginaDescript(vaginaNum:Number = 0):String {
	return Appearance.vaginaDescription(player, vaginaNum);
}

//Allvagina descript
function allVaginaDescript():String {
	if (player.vaginas.length == 1) return vaginaDescript(rand(player.vaginas.length - 1));
	if (player.vaginas.length > 1) return (vaginaDescript(rand(player.vaginas.length - 1)) + "s");
	return "ERROR: allVaginaDescript called with no vaginas.";
}
function multiCockDescript():String {
	if(player.cocks.length < 1) return "<B>Error: multiCockDescript() called with no penises present.</B>";
	//Get cock counts
	var descript:String="";
	var currCock:Number = 0;
	var totCock:Number = player.cocks.length;
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
	//Count cocks & Prep average totals
	while(currCock <= totCock-1) {
		//trace("Counting cocks!");
		if(player.cocks[currCock].cockType == CockTypesEnum.HUMAN) 
		{
			normalCocks++;
			normalCockKey = currCock;
		}
		if(player.cocks[currCock].cockType == CockTypesEnum.HORSE) 
		{
			horseCocks++;
			horseCockKey = currCock;
		}
		if(player.cocks[currCock].cockType == CockTypesEnum.DOG) 
		{
			dogCocks++;
			dogCockKey = currCock;
		}
		averageLength += player.cocks[currCock].cockLength;
		averageThickness += player.cocks[currCock].cockThickness;
		//If cocks are matched make sure they still are
		if(same && currCock > 0 && player.cocks[currCock].cockType != player.cocks[currCock-1].cockType) same = false;
		currCock++;
	}
	//Crunch averages
	averageLength /= currCock;
	averageThickness /= currCock;
	//Quantity descriptors
	if(currCock == 1) {
		if(dogCocks == 1) return dogDescript(0);
		if(horseCocks == 1) return horseDescript(0);
		if(normalCocks == 1) return cockDescript(0)
		//Catch-all for when I add more cocks.  Let cock descript do the sorting.
		if(player.cocks.length == 1) return cockDescript(0);
	}
	if(currCock == 2) {
		//For cocks that are the same
		if(same) 
		{
			descript += randomChoice("a pair of ", "two ", "a brace of ", "matching ", "twin ");
			descript += Appearance.cockAdjectives(averageLength, averageThickness, player.cocks[0].cockType, player);
			if(normalCocks == 2) descript += " " + Appearance.cockNoun(CockTypesEnum.HUMAN) + "s";
			if(horseCocks == 2) descript += ", " + Appearance.cockNoun(CockTypesEnum.HORSE) + "s";
			if(dogCocks == 2) descript += ", " + Appearance.cockNoun(CockTypesEnum.DOG) + "s";
			//Tentacles
			if (player.cocks[0].cockType.Index > 2) 
				descript += ", " + Appearance.cockNoun(player.cocks[0].cockType) + "s";
		}
		//Nonidentical
		else 
		{
			descript += randomChoice("a pair of ", "two ", "a brace of ");
			descript += Appearance.cockAdjectives(averageLength, averageThickness, player.cocks[0].cockType, player) + ", ";
			descript += randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
		}
	}
	if(currCock == 3) 
	{
		//For samecocks
		if(same) 
		{
			descript += randomChoice("three ", "a group of ", "a menage a trois of ", "a triad of ", "a triumvirate of ");
			descript += Appearance.cockAdjectives(averageLength, averageThickness, player.cocks[currCock-1].cockType, player);
			if(normalCocks == 3) 
				descript += " " + Appearance.cockNoun(CockTypesEnum.HUMAN) + "s";
			if(horseCocks == 3) 
				descript += ", " + Appearance.cockNoun(CockTypesEnum.HORSE) + "s";
			if(dogCocks == 3) 
				descript += ", " + Appearance.cockNoun(CockTypesEnum.DOG) + "s";
			//Tentacles
			if(player.cocks[0].cockType.Index > 2) descript += ", " + Appearance.cockNoun(player.cocks[0].cockType) + "s";   // Not sure what's going on here, referencing index *may* be a bug.

		}
		else 
		{
			descript += randomChoice("three ", "a group of ");
			descript += Appearance.cockAdjectives(averageLength, averageThickness, player.cocks[0].cockType, player);
			descript += randomChoice(", mutated cocks", ", mutated dicks", ", mixed cocks", ", mismatched dicks");
		}
	}
	//Large numbers of cocks!
	if(currCock > 3)
	{
		descript += randomChoice("a bundle of ", "an obscene group of ", "a cluster of ", "a wriggling group of ");
		//Cock adjectives and nouns
		descripted = false;
		//If same types...
		if(same) {
			if(player.cocks[0].cockType == CockTypesEnum.HUMAN) {
				descript += Appearance.cockAdjectives(averageLength, averageThickness, CockTypesEnum.HUMAN, player) + " ";	
				descript += Appearance.cockNoun(CockTypesEnum.HUMAN) + "s";
				descripted = true;
			}
			if(player.cocks[0].cockType == CockTypesEnum.DOG) {
				descript += Appearance.cockAdjectives(averageLength, averageThickness, CockTypesEnum.DOG, player) + ", ";
				descript += Appearance.cockNoun(CockTypesEnum.DOG) + "s";
				descripted = true;
			}
			if(player.cocks[0].cockType == CockTypesEnum.HORSE) {
				descript += Appearance.cockAdjectives(averageLength, averageThickness, CockTypesEnum.HORSE, player) + ", ";
				descript += Appearance.cockNoun(CockTypesEnum.HORSE) + "s";
				descripted = true;			
			}
			//TODO More group cock type descriptions!
			if(player.cocks[0].cockType.Index > 2) {
				descript += Appearance.cockAdjectives(averageLength, averageThickness, CockTypesEnum.HUMAN, player) + ", ";
				descript += Appearance.cockNoun(player.cocks[0].cockType) + "s";
				descripted = true;			
			}
		}
		//If mixed
		if(!descripted) {
			descript += Appearance.cockAdjectives(averageLength, averageThickness, player.cocks[0].cockType, player) + ", ";
			rando = rand(4);
			descript += randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
		}
	}	
	return descript;
}

function multiCockDescriptLight():String {
	if(player.cocks.length < 1) return "<B>Error: multiCockDescriptLight() called with no penises present.</B>";
	//Get cock counts
	var descript:String="";
	var currCock:Number = 0;
	var totCock:Number = player.cocks.length;
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
	if(totCock == 1) return cockDescript(0);
	//Count cocks & Prep average totals
	while(currCock <= totCock-1) {
		if(player.cocks[currCock].cockType == CockTypesEnum.HUMAN) {
			normalCocks++;
			normalCockKey = currCock;
		}
		if(player.cocks[currCock].cockType == CockTypesEnum.HORSE) {
			horseCocks++;
			horseCockKey = currCock;
		}
		if(player.cocks[currCock].cockType == CockTypesEnum.DOG) {
			dogCocks++;
			dogCockKey = currCock;
		}
		averageLength += player.cocks[currCock].cockLength;
		averageThickness += player.cocks[currCock].cockThickness;
		//If cocks are matched make sure they still are
		if(same && currCock > 0 && player.cocks[currCock].cockType != player.cocks[currCock-1].cockType) same = false;
		currCock++;
	}
	//Crunch averages
	averageLength /= currCock;
	averageThickness /= currCock;
	//Quantity descriptors
	if(player.cockTotal() == 1) {
		if(dogCocks == 1) return dogDescript(0);
		if(horseCocks == 1) return horseDescript(0);
		if(normalCocks == 1) return cockDescript(0);
		//Failsafe
		return cockDescript(0);
	}
	if(currCock == 2) {
		//For cocks that are the same
		if(same) {
			descript += randomChoice("pair of ", "two ", "brace of ", "matching ", "twin ");
			descript += cockAdjective();
			if(normalCocks == 2) descript += " " + Appearance.cockNoun(CockTypesEnum.HUMAN) + "s";
			if(horseCocks == 2) descript += ", " + Appearance.cockNoun(CockTypesEnum.HORSE) + "s";
			if(dogCocks == 2) descript += ", " + Appearance.cockNoun(CockTypesEnum.DOG) + "s";
			//Failsafe
			if(player.cocks[0].cockType.Index > 2) descript += ", " + Appearance.cockNoun(player.cocks[0].cockType) + "s";
		}
		//Nonidentical
		else {
			descript += randomChoice("pair of ", "two ", "brace of ");
			descript += cockAdjective() + ", ";
			descript += randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
		}
	}
	if(currCock == 3) {
		//For samecocks
		if(same) {
			descript += randomChoice("three ", "group of ", "menage a trois of ", "triad of ", "triumvirate of ");
			descript += cockAdjective();
			if(normalCocks == 3) descript += " " + Appearance.cockNoun(CockTypesEnum.HUMAN) + "s";
			if(horseCocks == 3) descript += ", " + Appearance.cockNoun(CockTypesEnum.HORSE) + "s";
			if(dogCocks == 3) descript += ", " + Appearance.cockNoun(CockTypesEnum.DOG) + "s";
			//Tentacles
			if (player.cocks[0].cockType.Index > 2) descript += ", " + Appearance.cockNoun(player.cocks[0].cockType) + "s";
		}
		else {
			descript += randomChoice("three ", "group of ");
			descript += cockAdjective() + ", ";
			descript += randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
		}
	}
	//Large numbers of cocks!
	if(currCock > 3)
	{
		descript += randomChoice("bundle of ", "obscene group of ", "cluster of ", "wriggling bunch of ");
		//Cock adjectives and nouns
		descripted = false;
		//Same
		if(same) {
			if(currCock == normalCocks) {
				descript += cockAdjective() + " ";	
				descript += Appearance.cockNoun(CockTypesEnum.HUMAN) + "s";
				descripted = true;
			}
			if(currCock == dogCocks) {
				descript += cockAdjective() + ", ";
				descript += Appearance.cockNoun(CockTypesEnum.DOG) + "s";
				descripted = true;
			}
			if(currCock == horseCocks) {
				descript += cockAdjective() + ", ";
				descript += Appearance.cockNoun(CockTypesEnum.HORSE) + "s";
				descripted = true;			
			}
			if(player.cocks[0].cockType.Index > 2) {
				descript += cockAdjective() + ", ";
				descript += Appearance.cockNoun(player.cocks[0].cockType) + "s";
				descripted = true;			
			}
		}
		//If mixed
		if(!descripted) {
			descript += cockAdjective() + ", ";
			descript += randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
		}
	}	
	return descript;
}
function eMultiCockDescriptLight():String {
	if(monster.cocks.length < 1) return "<B>Error: eMultiCockDescriptLight() called with no penises present.</B>";
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
			descript += randomChoice("pair of ", "two ", "brace of ", "matching ", "twin ");
			descript += eCockAdjectives(averageLength, averageThickness, monster.cocks[0].cockType);
			if(normalCocks == 2) descript += eCockNoun(CockTypesEnum.HUMAN) + "s";
			if(horseCocks == 2) descript += eCockNoun(CockTypesEnum.HORSE) + "s";
			if(dogCocks == 2) descript += eCockNoun(CockTypesEnum.DOG) + "s";
			//Failsafe
			if(monster.cocks[0].cockType.Index > 2) descript += eCockNoun(monster.cocks[0].cockType) + "s";
		}
		//Nonidentical
		else {
			descript += randomChoice("pair of ", "two ", "brace of ");
			descript += eCockAdjectives(averageLength, averageThickness, monster.cocks[0].cockType);
			descript += randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
		}
	}
	if(currCock == 3) {
		//For samecocks
		if(same) {
			descript += randomChoice("three ", "group of ", "menage a trois of ", "triad of ", "triumvirate of ");
			descript += eCockAdjectives(averageLength, averageThickness, monster.cocks[currCock-1].cockType);
			if(normalCocks == 3) descript += eCockNoun(CockTypesEnum.HUMAN) + "s";
			if(horseCocks == 3) descript += eCockNoun(CockTypesEnum.HORSE) + "s";
			if(dogCocks == 3) descript += eCockNoun(CockTypesEnum.DOG) + "s";
			//Tentacles
			if(monster.cocks[0].cockType.Index > 2) descript += eCockNoun(monster.cocks[0].cockType) + "s";
		}
		else {
			descript += randomChoice("three ", "group of ");
			descript += eCockAdjectives(averageLength, averageThickness, monster.cocks[0].cockType);
			descript += randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
		}
	}
	//Large numbers of cocks!
	if(currCock > 3)
	{
		descript += randomChoice("bundle of ", "obscene group of ", "cluster of ", "wriggling bunch of ");
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
			descript += randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
		}
	}	
	return descript;
}

function eCockHead(cockNum:Number = 0):String {
	if(cockNum < 0) return "ERROR";
	if(cockNum > monster.cocks.length-1) return "ERROR";
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
function eCockNoun(i_cockType:CockTypesEnum):String {
	return Appearance.cockMultiNoun(i_cockType);
}
//Used in multiCockDescript to avoid duplicate code
function eCockAdjectives(cLength:Number, thickness:Number, type:CockTypesEnum):String {
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
function cockAdjective(cockNum:Number = -1) {
	return Appearance.cockAdjective(player, cockNum);
}

//Used in multiCockDescript to avoid duplicate code
function cockAdjectives(i_cockLength:Number, i_cockThickness:Number, i_cockType:Number):String 
{
	//Just in case...
	//TODO Remove if never called
	trace("ERROR: Someone is still calling cockAdjectives with an integer cock type");
	var cockType:CockTypesEnum = CockTypesEnum.ParseConstantByIndex(int(i_cockType));
	return Appearance.cockAdjectives(i_cockLength, i_cockThickness, cockType, player);
}


function cockDescript(cockNum:Number):String 
{
	return Appearance.cockDescription(player, cockNum);
}

function humanDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: humanDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to kangaDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to kangaDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}

function kangaDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: kangaDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to kangaDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to kangaDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}
function dogDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: CockDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to dogDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to dogDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(CockTypesEnum.DOG);
	return descript;
}
function foxDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: CockDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to foxDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to foxDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(CockTypesEnum.FOX);
	return descript;
}
function tentacleDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: CockDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to tentacleDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to tentacleDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) 
		descript += cockAdjective(cockNum) + ", ";

	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}
function demonDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) 
		return "<b>ERROR: CockDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) 
		return "<B>Error: Invalid cock number (" + cockNum + ") passed to demonDescript()</b>";
	if(cockNum < 0) 
		return "<B>Error: Invalid cockNum (" + cockNum + ") passed to demonDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) 
		descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);

	// trace("DemonDescript Output - ", descript);
	// trace("Appearance.CockNoun = ", Appearance.cockNoun(player.cocks[cockNum].cockType), "cockType", player.cocks[cockNum].cockType);
	return descript;
}


//Horsecock + Descript
function horseDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: CockDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to horseDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to horseDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(CockTypesEnum.HORSE);
	return descript;
}

function catDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: catDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to catDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to catDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}

function anemoneDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: anemoneDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to anemoneDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to anemoneDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}
function dragonDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: dragonDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to dragonDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to dragonDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}

function displacerDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: dragonDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to dragonDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to dragonDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}


function snakeDescript(cockNum:Number):String 
{
	var descript:String = "";
	if(player.totalCocks() == 0) return "<b>ERROR: snakeDescript Called But No Cock Present</b>";
	if(cockNum > (player.cocks.length - 1)) return "<B>Error: Invalid cock number (" + cockNum + ") passed to snakeDescript()</b>";
	if(cockNum < 0) return "<B>Error: Invalid cockNum (" + cockNum + ") passed to snakeDescript()</b>";
	//50% of the time add a descriptor
	if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
	descript += Appearance.cockNoun(player.cocks[cockNum].cockType);
	return descript;
}
//Vaginas + Descript
function eVaginaDescript(vaginaNum):String {
	var vag:String="";
	var keyNum:Number = monster.vaginas.length-1;
	var rand:Number = 0;
	//If no vaginas back the fuck out
	if(keyNum < 0) return "VAGINA ERROR";
	//tightness descript - 40% display rate
	if(monster.vaginas[vaginaNum].vaginalLooseness == 0) rand = 61;
	if(monster.vaginas[vaginaNum].vaginalLooseness == 4 || monster.vaginas[vaginaNum].vaginalLooseness == 5) rand = 10;
	if(int(Math.random()*100) + rand > 60) {
		if(monster.vaginas[vaginaNum].vaginalLooseness == 0 || monster.vaginas[vaginaNum].virgin) vag+="virgin ";
		if(monster.vaginas[vaginaNum].vaginalLooseness == 2) vag+="loose ";
		if(monster.vaginas[vaginaNum].vaginalLooseness == 3) vag+="very loose ";
		if(monster.vaginas[vaginaNum].vaginalLooseness == 4) vag+="gaping ";
		if(monster.vaginas[vaginaNum].vaginalLooseness == 5) vag+="gaping-wide ";
	}
	//wetness descript - 30% display rate
	if(int(Math.random()*100 > 70)) {
		if(monster.vaginas[vaginaNum].vaginalWetness == 0) vag+="dry ";
		if(monster.vaginas[vaginaNum].vaginalWetness == 2) vag+="wet ";
		if(monster.vaginas[vaginaNum].vaginalWetness == 3) vag+="slick ";
		if(monster.vaginas[vaginaNum].vaginalWetness == 4) vag+="drooling ";
		if(monster.vaginas[vaginaNum].vaginalWetness == 5) vag+="slavering ";
	}
	//cunt names
	rand = int(Math.random()*8);
	if(rand == 0) vag+="vagina";
	if(rand == 1 || rand == 2 || rand == 6) vag+="pussy";
	if(rand == 3 || rand == 4 || rand == 5) vag+="cunt";
	if(rand == 7)  vag+="fuck-hole";
	return vag;
}

//Enemy cock description - value of random cock or 1000 for normal, 1001 horse, 1002 dog.
function eCockDescript(cockIndex:Number):String {
	return Appearance.cockDescriptionShort(cockIndex, monster);
}
function allBreastsDescript():String {
	var storage:String = "";
	if(player.breastRows.length == 0) return "unremarkable chest muscles ";
	if(player.breastRows.length == 2) {
		//if(player.totalBreasts() == 4) storage += "quartet of ";
		storage += "two rows of ";
	}
	if(player.breastRows.length == 3) {
		if(rand(2) == 0) storage += "three rows of ";
		else storage += "multi-layered ";
	}
	if(player.breastRows.length == 4) {
		if(rand(2) == 0) storage += "four rows of ";
		else storage += "four-tiered ";
	}
	if(player.breastRows.length == 5) {
		if(rand(2) == 0) storage += "five rows of ";
		else storage += "five-tiered ";
	}	
	storage += biggestBreastSizeDescript();
	return storage;
}
	
function biggestBreastSizeDescript():String {
	var temp14:int = Math.random()*3;
	var descript:String = "";
	var temp142:int = player.biggestTitRow();
	//ERROR PREVENTION
	if(player.breastRows.length - 1 < temp142) return "<b>ERROR, biggestBreastSizeDescript() working with invalid breastRow</b>";
	else if(temp142 < 0) return "ERROR SHIT SON!  BIGGESTBREASTSIZEDESCRIPT PASSED NEGATIVE!";
	if(player.breastRows[temp142].breastRating < 1) return "flat breasts";
	//50% of the time size-descript them
	if(rand(2) == 0) descript += breastSize(player.breastRows[temp142].breastRating);
	//Nouns!
	temp14 = rand(10);
	if(temp14 == 0) descript += "breasts";
	if(temp14 == 1) {
		if(player.breastRows[temp142].lactationMultiplier > 2) descript += "milk-udders";
		else descript += "breasts";
	}
	if(temp14 == 2) {
		if(player.breastRows[temp142].lactationMultiplier > 1.5) descript += "milky ";
		if(player.breastRows[temp142].breastRating > 4) descript += "tits";
		else descript += "breasts";
	}
	if(temp14 == 3) {
		//if(player.breastRows[temp142].breastRating > 6) descript += "rack";
		descript += "breasts";
	}
	if(temp14 == 4) descript += "tits";
	if(temp14 == 5) descript += "tits";
	if(temp14 == 6) descript += "tits";
	if(temp14 == 7) {
		if(player.breastRows[temp142].lactationMultiplier >= 1 && player.breastRows[temp142].lactationMultiplier < 2.5) descript += "milk jugs";
		if(player.breastRows[temp142].lactationMultiplier >= 2.5) descript += "udders";
		if(player.breastRows[temp142].lactationMultiplier < 1) descript += "jugs";
	}
	if(temp14 == 8) {
		if(player.breastRows[temp142].breastRating > 6) descript += "love-pillows";
		else descript += "boobs";
	}
	if(temp14 == 9) {
		if(player.breastRows[temp142].breastRating > 6) descript += "tits";
		else descript += "breasts";
	}
	return descript;
}

function breastSize(val:Number):String {
	var descript:String = "";
	var choice:Number = 0;
	//Catch all for dudes.
	if(val < 1) return "manly ";
	//Small - A->B
	if(val <= 2)
	{
		descript += randomChoice("palmable ", "tight ", "perky ", "baseball-sized ");
	}
	//C-D
	else if(val <= 4)
	{
		descript += randomChoice("nice ", "hand-filling ", "well-rounded ", "supple ", "softball-sized ");
	}
	//DD->big EE
	else if(val < 11)
	{
		descript += randomChoice("big ", "large ", "pillowy ", "jiggly ", "volleyball-sized ");
	}
	//F->big FF
	else if(val < 15) 
	{
		descript += randomChoice("soccerball-sized ", "hand-overflowing ", "generous ", "jiggling ");
	}
	//G -> HHH
	else if(val < 24) {
		descript += randomChoice("basketball-sized ", "whorish ", "cushiony ", "wobbling ");
	}
	//I -> KK
	else if(val < 35) {
		descript += randomChoice("massive motherly ", "luscious ", "smothering ", "prodigious ");
	}
	//K- > MMM+
	else {
		descript += randomChoice("mountainous ", "monumental ", "back-breaking ", "exercise-ball-sized ", "immense ");
	}
	return descript;
}
function breastDescript(rowNum:Number):String
{
	//ERROR PREVENTION
	if(player.breastRows.length - 1 < rowNum) return "<b>ERROR, breastDescript() working with invalid breastRow</b>";
	if(player.breastRows.length == 0) return "<b>ERROR, breastDescript() called when no breasts are present.</b>";
	var temp14:int = Math.random()*3;
	var descript:String = "";
	if(player.breastRows[rowNum].breastRating == 0) return "flat breasts";
	//50% of the time size-descript them
	if(rand(2) == 0) descript += breastSize(player.breastRows[rowNum].breastRating);
	//Nouns!
	temp14 = rand(10);
	if(temp14 == 0) descript += "breasts";
	if(temp14 == 1) {
		if(player.breastRows[rowNum].lactationMultiplier > 2) descript += "milk-udders";
		else descript += "breasts";
	}
	if(temp14 == 2) {
		if(player.breastRows[rowNum].lactationMultiplier > 1.5) descript += "milky ";
		if(player.breastRows[rowNum].breastRating > 4) descript += "tits";
		else descript += "breasts";
	}
	if(temp14 == 3) {
		//if(player.breastRows[rowNum].breastRating > 6) descript += "rack";
		descript += "breasts";
	}
	if(temp14 == 4) descript += "tits";
	if(temp14 == 5) descript += "tits";
	if(temp14 == 6) descript += "tits";
	if(temp14 == 7) {
		if(player.breastRows[rowNum].lactationMultiplier >= 1 && player.breastRows[rowNum].lactationMultiplier < 2.5) descript += "milk jugs";
		if(player.breastRows[rowNum].lactationMultiplier >= 2.5) descript += "udders";
		if(player.breastRows[rowNum].lactationMultiplier < 1) descript += "jugs";
	}
	if(temp14 == 8) {
		if(player.breastRows[rowNum].breastRating > 6) descript += "love-pillows";
		else descript += "boobs";
	}
	if(temp14 == 9) {
		if(player.breastRows[rowNum].breastRating > 6) descript += "tits";
		else descript += "breasts";
	}
	return descript;
}
function cockHead(cockNum:Number = 0):String {
	var temp:int;
	if(cockNum < 0) return "ERROR";
	if(cockNum > player.cocks.length-1) return "ERROR";
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


function npcBreastDescript(size:Number):String
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

function breastCup(size:Number):String {
	if(size < 1) return "flat, manly breast";
	else if(size < 2) return "A-cup";
	else if(size < 3) return "B-cup";
	else if(size < 4) return "C-cup";
	else if(size < 5) return "D-cup";
	else if(size < 6) return "DD-cup";
	else if(size < 7) return "big DD-cup";
	else if(size < 8) return "E-cup";
	else if(size < 9) return "big E-cup";
	else if(size < 10) return "EE-cup";
	else if(size < 11) return "big EE-cup";
	else if(size < 12) return "F-cup";
	else if(size < 13) return "big F-cup";
	else if(size < 14) return "FF-cup";
	else if(size < 15) return "big FF-cup";
	else if(size < 16) return "G-cup";
	else if(size < 17) return "big G-cup";
	else if(size < 18) return "GG-cup";
	else if(size < 19) return "big GG-cup";
	else if(size < 20) return "H-cup";
	else if(size < 21) return "big H-cup";
	else if(size < 22) return "HH-cup";
	else if(size < 23) return "big HH-cup";
	else if(size < 24) return "HHH-cup";
	else if(size < 25) return "I-cup";
	else if(size < 26) return "big I-cup";
	else if(size < 27) return "II-cup";
	else if(size < 28) return "big II-cup";
	else if(size < 29) return "J-cup";
	else if(size < 30) return "big J-cup";
	else if(size < 31) return "JJ-cup";
	else if(size < 32) return "big JJ-cup";
	else if(size < 33) return "K-cup";
	else if(size < 34) return "big K-cup";
	else if(size < 35) return "KK-cup";
	else if(size < 36) return "big KK-cup";
	else if(size < 37) return "L-cup";
	else if(size < 38) return "big L-cup";
	else if(size < 39) return "LL-cup";
	else if(size < 40) return "big LL-cup";
	else if(size < 41) return "M-cup";
	else if(size < 42) return "big M-cup";
	else if(size < 43) return "MM-cup";
	else if(size < 44) return "big MM-cup";
	else if(size < 45) return "MMM-cup";
	else if(size < 46) return "large MMM-cup";
	else if(size < 47) return "N-cup";
	else if(size < 48) return "large N-cup";
	else if(size < 49) return "NN-cup";
	else if(size < 50) return "large NN-cup";
	else if(size < 51) return "O-cup";
	else if(size < 52) return "large O-cup";
	else if(size < 53) return "OO-cup";
	else if(size < 54) return "large OO-cup";
	else if(size < 55) return "P-cup";
	else if(size < 56) return "large P-cup";
	else if(size < 57) return "PP-cup";
	else if(size < 58) return "large PP-cup";
	else if(size < 59) return "Q-cup";
	else if(size < 60) return "large Q-cup";
	else if(size < 61) return "QQ-cup";
	else if(size < 62) return "large QQ-cup";
	else if(size < 63) return "R-cup";
	else if(size < 64) return "large R-cup";
	else if(size < 65) return "RR-cup";
	else if(size < 66) return "large RR-cup";
	else if(size < 67) return "S-cup";
	else if(size < 68) return "large S-cup";
	else if(size < 69) return "SS-cup";
	else if(size < 70) return "large SS-cup";
	else if(size < 71) return "T-cup";
	else if(size < 72) return "large T-cup";
	else if(size < 73) return "TT-cup";
	else if(size < 74) return "large TT-cup";
	else if(size < 75) return "U-cup";
	else if(size < 76) return "large U-cup";
	else if(size < 77) return "UU-cup";
	else if(size < 78) return "large UU-cup";
	else if(size < 79) return "V-cup";
	else if(size < 80) return "large V-cup";
	else if(size < 81) return "VV-cup";
	else if(size < 82) return "large VV-cup";
	else if(size < 83) return "W-cup";
	else if(size < 84) return "large W-cup";
	else if(size < 85) return "WW-cup";
	else if(size < 86) return "large WW-cup";
	else if(size < 87) return "X-cup";
	else if(size < 88) return "large X-cup";
	else if(size < 89) return "XX-cup";
	else if(size < 90) return "large XX-cup";
	else if(size < 91) return "Y-cup";
	else if(size < 92) return "large Y-cup";
	else if(size < 93) return "YY-cup";
	else if(size < 94) return "large YY-cup";
	else if(size < 95) return "Z-cup";
	else if(size < 96) return "large Z-cup";
	else if(size < 97) return "ZZ-cup";
	else if(size < 98) return "large ZZ-cup";
	else if(size < 99) return "ZZZ-cup";
	else return "large ZZZ-cup"
}


function NPCCockDescript(cockType:*, cockLength:Number = 0, lust:Number = 50):String 
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
function NPCCockNoun(i_cockType:CockTypesEnum):String
{
	return Appearance.cockNoun(i_cockType);
}

//Multipurpose NPC cock descs
function NPCCockAdjective(cockType:CockTypesEnum, cockLength:Number = 5, lust:Number = 50):String 
{	
	var descript:String = "";
	var rando:Number = 0;
	var multi:Boolean = false;
	//Length 1/3 chance
	if(rand(2) == 0) {
		if(cockLength < 3) {
			descript += randomChoice("little", "toy-sized", "mini", "budding", "tiny");
		}
		else if(cockLength < 5) {
			descript += randomChoice("short", "small");
		}
		else if(cockLength < 7) {
			descript += randomChoice("fair-sized", "nice");
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
			descript += randomChoice("massive", "knee-length", "forearm-length");
		}
		else if(cockLength < 30) {
			descript += randomChoice("enormous", "giant", "arm-like");
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
			descript += randomChoice("turgid", "blood-engorged", "rock-hard", "stiff", "eager");
		}
	}
	//Girth - fallback
	else {
		if(cockLength/6 <= .75) {
			descript += randomChoice("thin", "slender", "narrow");
		}
		else if(cockLength/6 <= 1.2) {
			descript += "ample";
		}
		else if(cockLength/6 <= 1.4) {
			descript += randomChoice("ample", "big");
		}
		else if(cockLength/6 <= 2) {
			descript += randomChoice("broad", "girthy", "meaty");
		}
		else if(cockLength/6 <= 3.5) {
			descript += randomChoice("fat", "wide", "distended");
		}
		else if(cockLength/6 > 3.5) {
			descript += randomChoice("inhumanly distended", "bloated", "monstrously thick");
		}
	}
	return descript;
}
