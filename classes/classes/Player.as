package classes
{
	
	/**
	 * ...
	 * @author Yoffy
	 */
	public class Player extends Character
	{
		//Autosave
		public var slotName:String = "VOID";
		public var autoSave:Boolean = false;
		
		//Lust vulnerability
		//TODO: Kept for backwards compatibility reasons but should be phased out.
		public var lustVuln:Number = 1;
		
		//Teasing attributes
		public var teaseLevel:Number = 0;
		public var teaseXP:Number = 0;
		
		//Perks used to store 'queued' perk buys
		public var perkPoints:Number = 0;
		
		//Number of times explored for new areas
		public var explored = 0;
		public var exploredForest = 0;
		public var exploredDesert = 0;
		public var exploredMountain = 0;
		public var exploredLake = 0;
		
		public function Player()
		{
			keyItems = new Array();
		}
		
		//Body Type
		public function bodyType():String
		{
			var desc:String = "";
			//OLD STUFF
			/*var strong:Number = 0;
			   var desc:String = "";
			   var lithe:Number = 0;
			   //strong points
			   if(str > 25) strong++;
			   if(str > 50) strong++;
			   if(str > 75) strong++;
			   if(str > 99) strong++;
			   //lithe points
			   if(spe > 25) lithe++;
			   if(spe > 50) lithe++;
			   if(spe > 75) lithe++;
			   if(spe > 99) lithe++;
			   if(strong == 0) desc += "small muscles ";
			   if(strong == 1) desc += "average muscles ";
			   if(strong == 2) desc += "strong muscles ";
			   if(strong == 3) desc += "obvious muscles ";
			   if(strong == 4) desc += "bodybuilder-like muscles ";
			   if(lithe == strong) desc += "as quick as they are strong";
			   if(lithe - 1 == strong) desc += "that look lean and quick";
			   if(lithe - 2 == strong) desc += "that stand out on your sinewy frame";
			   if(lithe - 3 == strong) desc += "that look lithe and quick";
			   if(lithe - 4 == strong) desc += "that don't betray their incredible speed";
			   if(lithe + 1 == strong) desc += "that aren't that quick";
			   if(lithe + 2 == strong) desc += "hidden under a small layer of fat";
			   if(lithe + 3 == strong) desc += "under some noticable pudge";
			   if(lithe + 4 == strong) desc += "buried under lots of fat";
			 */
			//SUPAH THIN
			if (thickness < 10)
			{
				//SUPAH BUFF
				if (tone > 90)
					desc += "a lithe body covered in highly visible muscles";
				else if (tone > 75)
					desc += "an incredibly thin, well-muscled frame";
				else if (tone > 50)
					desc += "a very thin body that has a good bit of muscle definition";
				else if (tone > 25)
					desc += "a lithe body and only a little bit of muscle definition";
				else
					desc += "a waif-thin body, and soft, forgiving flesh";
			}
			//Pretty thin
			else if (thickness < 25)
			{
				if (tone > 90)
					desc += "a thin body and incredible muscle definition";
				else if (tone > 75)
					desc += "a narrow frame that shows off your muscles";
				else if (tone > 50)
					desc += "a somewhat lithe body and a fair amount of definition";
				else if (tone > 25)
					desc += "a narrow, soft body that still manages to show off a few muscles";
				else
					desc += "a thin, soft body";
			}
			//Somewhat thin
			else if (thickness < 40)
			{
				if (tone > 90)
					desc += "a fit, somewhat thin body and rippling muscles all over";
				else if (tone > 75)
					desc += "a thinner-than-average frame and great muscle definition";
				else if (tone > 50)
					desc += "a somewhat narrow body and a decent amount of visible muscle";
				else if (tone > 25)
					desc += "a moderately thin body, soft curves, and only a little bit of muscle";
				else
					desc += "a fairly thin form and soft, cuddle-able flesh";
			}
			//average
			else if (thickness < 60)
			{
				if (tone > 90)
					desc += "average thickness and a bevy of perfectly defined muscles";
				else if (tone > 75)
					desc += "an average-sized frame and great musculature";
				else if (tone > 50)
					desc += "a normal waistline and decently visible muscles";
				else if (tone > 25)
					desc += "an average body and soft, unremarkable flesh";
				else
					desc += "an average frame and soft, untoned flesh with a tendency for jiggle";
			}
			else if (thickness < 75)
			{
				if (tone > 90)
					desc += "a somewhat thick body that's covered in slabs of muscle";
				else if (tone > 75)
					desc += "a body that's a little bit wide and has some highly-visible muscles";
				else if (tone > 50)
					desc += "a solid build that displays a decent amount of muscle";
				else if (tone > 25)
					desc += "a slightly wide frame that displays your curves and has hints of muscle underneath";
				else
					desc += "a soft, plush body with plenty of jiggle";
			}
			else if (thickness < 90)
			{
				if (tone > 90)
					desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if (tone > 75)
					desc += "a burly form and plenty of muscle definition";
				else if (tone > 50)
					desc += "a solid, thick frame and a decent amount of muscles";
				else if (tone > 25)
					desc += "a wide-set body, some soft, forgiving flesh, and a hint of muscle underneath it";
				else
				{
					desc += "a wide, cushiony body";
					if (gender >= 2 || biggestTitSize() > 3 || hipRating > 7 || buttRating > 7)
						desc += " and plenty of jiggle on your curves";
				}
			}
			//Chunky monkey
			else
			{
				if (tone > 90)
					desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 75)
					desc += "a very wide body and enough muscle to make you look like a tank";
				else if (tone > 50)
					desc += "an extremely substantial frame packing a decent amount of muscle";
				else if (tone > 25)
				{
					desc += "a very wide body";
					if (gender >= 2 || biggestTitSize() > 4 || hipRating > 10 || buttRating > 10)
						desc += ", lots of curvy jiggles,";
					desc += " and hints of muscle underneath";
				}
				else
				{
					desc += "a thick";
					if (gender >= 2 || biggestTitSize() > 4 || hipRating > 10 || buttRating > 10)
						desc += ", voluptuous";
					desc += " body and plush, ";
					if (gender >= 2 || biggestTitSize() > 4 || hipRating > 10 || buttRating > 10)
						desc += " jiggly curves";
					else
						desc += " soft flesh";
				}
			}
			return desc;
		}
		
		public function race():String
		{
			//Temp vars
			var temp:Number = 0;
			var rando:Number = 0;
			//Determine race type:
			var race:String = "human";
			if (lowerBody == 4)
				race = "centaur";
			if (lowerBody == 11)
				race = "pony-kin";
			//determine sheath
			var sheath:Boolean = false;
			if (catScore() >= 4)
				race = "cat-" + mf("boy", "girl");
			if (lizardScore() >= 4)
			{
				if (gender == 0)
					race = "lizan";
				else if (gender == 1)
					race = "male lizan";
				else if (gender == 2)
					race = "female lizan";
				else
					race = "hermaphrodite lizan";
			}
			if (dragonScore() >= 4)
			{
				race = "dragon-morph";
				if (faceType == 0)
					race = "dragon-" + mf("man", "girl");
			}
			if (raccoonScore() >= 4)
			{
				race = "raccoon-morph";
				if (balls > 0 && ballSize > 5)
					race = "tanuki-morph";
			}
			if (dogScore() >= 4)
				race = "dog-morph";
			if (foxScore() >= 4)
			{
				if (skinType == 1)
					race = "fox-morph";
				else
					race = mf("fox-morph", "fox-girl");
			}
			if (kitsuneScore() >= 4)
			{
				race = "kitsune";
			}
			if (horseScore() >= 3)
			{
				if (lowerBody == 4)
					race = "centaur-morph";
				else
					race = "equine-morph";
			}
			if (mutantScore() >= 5 && race == "human")
				race = "corrupted mutant";
			if (minoScore() >= 4)
				race = "minotaur-morph";
			if (cowScore() > 5)
			{
				race = "cow-";
				race += mf("morph", "girl");
			}
			if (beeScore() >= 5)
				race = "bee-morph";
			if (goblinScore() >= 5)
				race = "goblin";
			if (humanScore() >= 5 && race == "corrupted mutant")
				race = "somewhat human mutant";
			if (demonScore() > 4)
				race = "demon-morph";
			if (sharkScore() >= 3)
				race = "shark-morph";
			if (bunnyScore() >= 4)
				race = "bunny-" + mf("boy", "girl");
			if (harpyScore() >= 4)
			{
				if (gender >= 2)
					race = "harpy";
				else
					race = "avian";
			}
			if (spiderScore() >= 4)
			{
				race = "spider-morph";
				if (mf("no", "yes") == "yes")
					race = "spider-girl";
				if (lowerBody == 16)
					race = "drider";
			}
			if (kangaScore() >= 4)
				race = "kangaroo-morph";
			if (mouseScore() >= 3)
			{
				if (faceType != 16)
					race = "mouse-" + mf("boy", "girl");
				else
					race = "mouse-morph";
			}
			if (lowerBody == 3)
				race = "naga";
			if (lowerBody == 4)
				race = "centaur";
			
			if (gooScore() >= 3)
			{
				race = "goo-";
				race += mf("boi", "girl");
			}
			return race;
		}
		
		//determine demon rating
		public function demonScore():Number
		{
			var demonCounter:Number = 0;
			if (hornType == 1 && horns > 0)
				demonCounter++;
			if (hornType == 1 && horns > 4)
				demonCounter++;
			if (tailType == 3)
				demonCounter++;
			if (wingType == 6 || wingType == 7)
				demonCounter++;
			if (skinType == 0 && cor > 50)
				demonCounter++;
			if (faceType == 0 && cor > 50)
				demonCounter++;
			if (lowerBody == 5 || lowerBody == 6)
				demonCounter++;
			if (demonCocks() > 0)
				demonCounter++
			return demonCounter;
		}
		
		//Determine Human Rating
		public function humanScore():Number
		{
			var humanCounter:Number = 0;
			if (faceType == 0)
				humanCounter++;
			if (skinType == 0)
				humanCounter++;
			if (horns == 0)
				humanCounter++;
			if (tailType == 0)
				humanCounter++;
			if (wingType == 0)
				humanCounter++;
			if (lowerBody == 0)
				humanCounter++;
			if (normalCocks() == 1 && totalCocks() == 1)
				humanCounter++;
			if (breastRows.length == 1 && skinType == 0)
				humanCounter++;
			return humanCounter;
		}
		
		//Determine minotaur rating
		public function minoScore():Number
		{
			var minoCounter:Number = 0;
			if (faceType == 3)
				minoCounter++;
			if (earType == 3)
				minoCounter++;
			if (tailType == 4)
				minoCounter++;
			if (hornType == 2)
				minoCounter++;
			if (lowerBody == 1 && minoCounter > 0)
				minoCounter++;
			if (tallness > 80 && minoCounter > 0)
				minoCounter++;
			if (cocks.length > 0 && minoCounter > 0)
			{
				if (horseCocks() > 0)
					minoCounter++;
			}
			if (vaginas.length > 0)
				minoCounter--;
			return minoCounter;
		}
		
		//Determine cow rating
		public function cowScore():Number
		{
			var minoCounter:Number = 0;
			if (faceType == 0)
				minoCounter++;
			if (faceType == 3)
				minoCounter--;
			if (earType == 3)
				minoCounter++;
			if (tailType == 4)
				minoCounter++;
			if (hornType == 2)
				minoCounter++;
			if (lowerBody == 1 && minoCounter > 0)
				minoCounter++;
			if (tallness >= 73 && minoCounter > 0)
				minoCounter++;
			if (vaginas.length > 0)
				minoCounter++;
			if (biggestTitSize() > 4 && minoCounter > 0)
				minoCounter++;
			if (biggestLactation() > 2 && minoCounter > 0)
				minoCounter++;
			return minoCounter;
		}
		
		public function sandTrapScore():int
		{
			var counter:int = 0;
			if (hasStatusAffect("Black Nipples") >= 0)
				counter++;
			if (hasVagina() && vaginaType() == 5)
				counter++;
			if (eyeType == 2)
				counter++;
			if (wingType == 12)
				counter++;
			return counter;
		}
		
		//Determine Bee Rating
		public function beeScore():Number
		{
			var beeCounter:Number = 0;
			if (hairColor == "shiny black")
				beeCounter++;
			if (hairColor == "black and yellow")
				beeCounter += 2;
			if (antennae > 0)
			{
				beeCounter++;
				if (faceType == 0)
					beeCounter++;
			}
			if (lowerBody == 7)
			{
				beeCounter++;
				if (vaginas.length == 1)
					beeCounter++;
			}
			if (tailType == 6)
				beeCounter++;
			if (wingType == 1)
				beeCounter++;
			if (wingType == 2)
				beeCounter++;
			return beeCounter;
		}
		
		//Determine Dog Rating
		public override function dogScore():Number
		{
			var dogCounter:Number = 0;
			if (faceType == 2)
				dogCounter++;
			if (earType == 2)
				dogCounter++;
			if (tailType == 2)
				dogCounter++;
			if (lowerBody == 2)
				dogCounter++;
			if (dogCocks() > 0)
				dogCounter++;
			if (breastRows.length > 1)
				dogCounter++;
			if (breastRows.length == 3)
				dogCounter++;
			if (breastRows.length > 3)
				dogCounter--;
			//Fur only counts if some canine features are present
			if (skinType == 1 && dogCounter > 0)
				dogCounter++;
			return dogCounter;
		}
		
		public function mouseScore():Number
		{
			var coonCounter:Number = 0;
			if (earType == 12)
				coonCounter++;
			if (tailType == 16)
				coonCounter++;
			
			if (faceType == 15)
				coonCounter++;
			if (faceType == 16)
				coonCounter += 2;
			//Fur only counts if some canine features are present
			if (skinType == 1 && coonCounter > 0)
				coonCounter++;
			
			if (tallness < 55 && coonCounter > 0)
				coonCounter++;
			if (tallness < 45 && coonCounter > 0)
				coonCounter++;
			return coonCounter;
		}
		
		public function raccoonScore():Number
		{
			var coonCounter:Number = 0;
			if (faceType == 13)
				coonCounter++;
			if (faceType == 14)
				coonCounter += 2;
			if (earType == 11)
				coonCounter++;
			if (tailType == 15)
				coonCounter++;
			if (lowerBody == 19)
				coonCounter++;
			if (coonCounter > 0 && balls > 0)
				coonCounter++;
			//Fur only counts if some canine features are present
			if (skinType == 1 && coonCounter > 0)
				coonCounter++;
			return coonCounter;
		}
		
		//Determine Fox Rating
		public override function foxScore():Number
		{
			var foxCounter:Number = 0;
			if (faceType == 11)
				foxCounter++;
			if (earType == 9)
				foxCounter++;
			if (tailType == 13)
				foxCounter++;
			if (lowerBody == 17)
				foxCounter++;
			if (dogCocks() > 0 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length > 1 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length == 3 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length == 4 && foxCounter > 0)
				foxCounter++;
			//Fur only counts if some canine features are present
			if (skinType == 1 && foxCounter > 0)
				foxCounter++;
			return foxCounter;
		}
		
		//Determine cat Rating
		public function catScore():Number
		{
			var catCounter:Number = 0;
			if (faceType == 6)
				catCounter++;
			if (earType == 5)
				catCounter++;
			if (tailType == 8)
				catCounter++;
			if (lowerBody == 9)
				catCounter++;
			if (catCocks() > 0)
				catCounter++;
			if (breastRows.length > 1 && catCounter > 0)
				catCounter++;
			if (breastRows.length == 3 && catCounter > 0)
				catCounter++;
			if (breastRows.length > 3)
				catCounter -= 2;
			//Fur only counts if some canine features are present
			if (skinType == 1 && catCounter > 0)
				catCounter++;
			return catCounter;
		}
		
		//Determine lizard rating
		public function lizardScore():Number
		{
			var lizardCounter:Number = 0;
			if (faceType == 7)
				lizardCounter++;
			if (earType == 6)
				lizardCounter++;
			if (tailType == 9)
				lizardCounter++;
			if (lowerBody == 10)
				lizardCounter++;
			if (lizardCocks() > 0)
				lizardCounter++;
			if (horns > 0 && (hornType == 3 || hornType == 4))
				lizardCounter++;
			if (skinType == 2)
				lizardCounter++;
			return lizardCounter;
		}
		
		public function spiderScore():Number
		{
			var score:Number = 0;
			if (eyeType == 1)
				score += 2;
			if (faceType == 10)
				score++;
			if (armType == 2)
				score++;
			if (lowerBody == 15 || lowerBody == 16)
				score += 2;
			else if (score > 0)
				score--;
			if (tailType == 5)
				score += 2;
			if (skinType > 0 && score > 0)
				score--;
			return score;
		}
		
		//Determine Horse Rating
		public function horseScore():Number
		{
			var horseCounter:Number = 0;
			if (faceType == 1)
				horseCounter++;
			if (earType == 1)
				horseCounter++;
			if (tailType == 1)
				horseCounter++;
			if (horseCocks() > 0)
				horseCounter++;
			if (lowerBody == 1 || lowerBody == 4)
				horseCounter++;
			//Fur only counts if some equine features are present
			if (skinType == 1 && horseCounter > 0)
				horseCounter++;
			return horseCounter;
		}
		
		//Determine kitsune Rating
		public function kitsuneScore():Number
		{
			var kitsuneCounter:int = 0;
			//If the character has fox ears, +1
			if (earType == 9)
				kitsuneCounter++;
			//If the character has a fox tail, +1
			if (tailType == 13)
				kitsuneCounter++;
			//If the character has two or more fox tails, +2
			if (tailType == 13 && tailVenom >= 2)
				kitsuneCounter += 2;
			//If the character has tattooed skin, +1
			//9999
			//If the character has a 'vag of holding', +1
			if (vaginalCapacity() >= 8000)
				kitsuneCounter++;
			//If the character's kitsune score is greater than 0 and:
			//If the character has a normal face, +1
			if (kitsuneCounter > 0 && faceType == 0)
				kitsuneCounter++;
			//If the character's kitsune score is greater than 1 and:
			//If the character has "blonde","black","red","white", or "silver" hair, +1
			if (kitsuneCounter > 0 && (hairColor == "golden blonde" || hairColor == "black" || hairColor == "red" || hairColor == "white" || hairColor == "silver blonde"))
				kitsuneCounter++;
			//If the character's femininity is 40 or higher, +1
			if (kitsuneCounter > 0 && femininity >= 40)
				kitsuneCounter++;
			//If the character has fur, scales, or gooey skin, -1
			if (skinType > 1)
				kitsuneCounter -= 2;
			if (skinType == 1)
				kitsuneCounter--;
			//If the character has abnormal legs, -1
			if (lowerBody != 0)
				kitsuneCounter--;
			//If the character has a nonhuman face, -1
			if (faceType != 0)
				kitsuneCounter--;
			//If the character has ears other than fox ears, -1
			if (earType != 9)
				kitsuneCounter--;
			//If the character has tail(s) other than fox tails, -1
			if (tailType != 13)
				kitsuneCounter--;
			
			return kitsuneCounter;
		
		}
		
		//Determine Horse Rating
		public function dragonScore():Number
		{
			var dragonCounter:Number = 0;
			if (faceType == 12)
				dragonCounter++;
			if (earType == 10)
				dragonCounter++;
			if (tailType == 14)
				dragonCounter++;
			if (tongueType == 3)
				dragonCounter++;
			if (dragonCocks() > 0)
				dragonCounter++;
			if (wingType == 10)
				dragonCounter++;
			if (wingType == 11)
				dragonCounter += 2;
			if (lowerBody == 18)
				dragonCounter++;
			if (skinType == 2 && dragonCounter > 0)
				dragonCounter++;
			return dragonCounter;
		}
		
		//Goblinscore
		public function goblinScore():Number
		{
			var horseCounter:Number = 0;
			if (earType == 4)
				horseCounter++;
			if (skinTone == "pale yellow" || skinTone == "grayish-blue" || skinTone == "green" || skinTone == "dark green")
				horseCounter++;
			if (horseCounter > 0)
			{
				if (faceType == 0)
					horseCounter++;
				if (tallness < 48)
					horseCounter++;
				if (hasVagina())
					horseCounter++;
				if (lowerBody == 0)
					horseCounter++;
			}
			return horseCounter;
		}
		
		//Gooscore
		public function gooScore():Number
		{
			var gooCounter:Number = 0;
			if (hairType == 3)
				gooCounter++;
			if (skinAdj == "slimy")
				gooCounter++;
			if (lowerBody == 8)
				gooCounter++;
			if (vaginalCapacity() > 9000)
				gooCounter++;
			if (hasStatusAffect("Slime Craving") >= 0)
				gooCounter++;
			return gooCounter;
		}
		
		//Nagascore
		public function nagaScore():Number
		{
			var nagaCounter:Number = 0;
			if (faceType == 5)
				nagaCounter++;
			if (tongueType == 1)
				nagaCounter++;
			if (nagaCounter > 0 && antennae == 0)
				nagaCounter++;
			if (nagaCounter > 0 && wingType == 0)
				nagaCounter++;
			return nagaCounter;
		}
		
		//Bunnyscore
		public function bunnyScore():Number
		{
			var bunnyCounter:Number = 0;
			if (faceType == 8)
				bunnyCounter++;
			if (tailType == 10)
				bunnyCounter++;
			if (earType == 7)
				bunnyCounter++;
			if (lowerBody == 12)
				bunnyCounter++;
			//More than 2 balls reduces bunny score
			if (balls > 2 && bunnyCounter > 0)
				bunnyCounter--;
			//Human skin on bunmorph adds
			if (skinType == 0 && bunnyCounter > 1)
				bunnyCounter++;
			//No wings and antennae a plus
			if (bunnyCounter > 0 && antennae == 0)
				bunnyCounter++;
			if (bunnyCounter > 0 && wingType == 0)
				bunnyCounter++;
			return bunnyCounter;
		}
		
		//Harpyscore
		public function harpyScore():Number
		{
			var harpy:Number = 0;
			if (armType == 1)
				harpy++;
			if (hairType == 1)
				harpy++;
			if (wingType == 9)
				harpy++;
			if (tailType == 11)
				harpy++;
			if (lowerBody == 13)
				harpy++;
			if (harpy >= 2 && faceType == 0)
				harpy++;
			if (harpy >= 2 && (earType == 0 || earType == 4))
				harpy++;
			return harpy;
		}
		
		//Kangascore
		public function kangaScore():Number
		{
			var kanga:Number = 0;
			if (kangaCocks() > 0)
				kanga++;
			if (earType == 8)
				kanga++;
			if (tailType == 12)
				kanga++;
			if (lowerBody == 14)
				kanga++;
			if (faceType == 9)
				kanga++;
			if (kanga >= 2 && skinType == 1)
				kanga++;
			return kanga;
		}
		
		//sharkscore
		public function sharkScore():Number
		{
			var sharkCounter:Number = 0;
			if (faceType == 4)
				sharkCounter++;
			if (wingType == 8)
				sharkCounter++;
			if (tailType == 7)
				sharkCounter++;
			return sharkCounter;
		}
		
		//Determine Mutant Rating
		public function mutantScore():Number
		{
			var mutantCounter:Number = 0;
			if (faceType > 0)
				mutantCounter++;
			if (skinType > 0)
				mutantCounter++;
			if (tailType > 0)
				mutantCounter++;
			if (cockTotal() > 1)
				mutantCounter++;
			if (hasCock() && hasVagina())
				mutantCounter++;
			if (hasFuckableNipples())
				mutantCounter++;
			if (breastRows.length > 1)
				mutantCounter++;
			if (faceType == 1)
			{
				if (skinType == 1)
					mutantCounter--;
				if (tailType == 1)
					mutantCounter--;
			}
			if (faceType == 2)
			{
				if (skinType == 1)
					mutantCounter--;
				if (tailType == 2)
					mutantCounter--;
			}
			return mutantCounter--;
		}
		
		public function lactationQ():Number
		{
			if (biggestLactation() < 1)
				return 0;
			//(Milk production TOTAL= breastSize x 10 * lactationMultiplier * breast total * milking-endurance (1- default, maxes at 2.  Builds over time as milking as done)
			//(Small – 0.01 mLs – Size 1 + 1 Multi)
			//(Large – 0.8 - Size 10 + 4 Multi)
			//(HUGE – 2.4 - Size 12 + 5 Multi + 4 tits)
			var total:Number = 0;
			if (hasStatusAffect("Lactation Endurance") < 0)
				createStatusAffect("Lactation Endurance", 1, 0, 0, 0);
			total = biggestTitSize() * 10 * averageLactation() * statusAffectv1("Lactation Endurance") * totalBreasts();
			if (statusAffectv1("Lactation Reduction") >= 48)
				total = total * 1.5;
			return total;
		}
	}
}