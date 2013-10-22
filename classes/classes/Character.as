package classes 
{
	import classes.creature;
	
	/**
	 * Character class for player and NPCs. Has subclasses Player and NonPlayer.
	 * @author Yoffy
	 */
	public class Character extends creature 
	{
		
		public var femininity:Number = 50;
		
		//Eyetype
		//0 - normal
		//1 - spidah!
		//2 - sandtrap!
		public var eyeType:Number = 0;
		
		//BEARDS! Not used anywhere right now but WHO WANTS A BEARD?
		public var beardLength:Number = 0;
		public var beardStyle:Number = 0;
		
		//Used for hip ratings
		public var thickness:Number = 0;
		
		//Body tone i.e. Lithe, stocky, etc
		public var tone:Number = 0;
		
		//TongueType
		//0 - normal
		//1 - snakey
		//2 - demon
		//3 - dragon
		public var tongueType:Number = 0;
		
		//Head ornaments. Definitely need to convert away from hard coded types.
		public var antennae:Number = 0;
		public var horns:Number = 0;
		
		//ArmType
		//0 - normal
		//1 - harpy feathered
		//2 - SPIDA
		public var armType:Number = 0;
		
		//Gills
		public var gills:Boolean = false;		;
		
		//Preggos
		//TODO: Document pregancy types. Both butt and normal. Mainly butts though.
		//1 = imp
		//2 = minotaur
		//3 = tentacle
		//4 = mouse
		//5 = EGGZ
		//6 = hellhound
		//7 = centaur
		//8 = MARBLZ
		public var pregnancyType = 0;
		public var pregnancyIncubation = 0;
		
		//2 = bee
		public var buttPregnancyType = 0;
		public var buttPregnancyIncubation = 0;
		
		//Key items
		public var keyItems:Array;
		
		public function Character() 
		{
			
		}
		
		//Return bonus fertility
		public function bonusFertility():Number
		{
			var counter:Number = 0;
			if (hasPerk("heat") >= 0)
				counter += perks[hasPerk("heat")].value1;
			if (hasPerk("Fertility+") >= 0)
				counter += 15;
			if (hasPerk("Marae's Gift - Fertility") >= 0)
				counter += 50;
			if (hasPerk("Fera's Boon - Breeding Bitch") >= 0)
				counter += 30;
			if (hasPerk("Magical Fertility") >= 0)
				counter += 10;
			counter += perkv2("Elven Bounty");
			counter += perkv1("Pierced: Fertite");
			return counter;
		}
		
		//return total fertility
		public function totalFertility():Number
		{
			return (bonusFertility() + fertility);
		}
		
		public function faceDesc():String
		{
			var faceo:String = "";
			//0-10
			if (femininity < 10)
			{
				faceo = "a square chin";
				if (!hasBeard())
					faceo += " and chiseled jawline";
				else
					faceo += ", chiseled jawline, and " + beard();
			}
			//10+ -20
			else if (femininity < 20)
			{
				faceo = "a rugged looking " + face() + " ";
				if (hasBeard())
					faceo += "and " + beard();
				faceo += "that's surely handsome";
			}
			//21-28
			else if (femininity < 28)
				faceo = "a well-defined jawline and a fairly masculine profile";
			//28+-35 
			else if (femininity < 35)
				faceo = "a somewhat masculine, angular jawline";
			//35-45
			else if (femininity < 45)
				faceo = "the barest hint of masculinity on its features";
			//45-55
			else if (femininity <= 55)
				faceo = "an androgynous set of features that would look normal on a male or female";
			//55+-65
			else if (femininity <= 65)
				faceo = "a tiny touch of femininity to it, with gentle curves";
			//65+-72
			else if (femininity <= 72)
				faceo = "a nice set of cheekbones and lips that have the barest hint of pout";
			//72+-80
			else if (femininity <= 80)
				faceo = "a beautiful, feminine shapeliness that's sure to draw the attention of males";
			//81-90
			else if (femininity <= 90)
				faceo = "a gorgeous profile with full lips, a button nose, and noticeable eyelashes";
			//91-100
			else
				faceo = "a jaw-droppingly feminine shape with full, pouting lips, an adorable nose, and long, beautiful eyelashes";
			return faceo;
		}
		
		//Modify femininity!
		public function modFem(goal:Number, strength:Number = 1):String
		{
			var output:String = "";
			var old:String = faceDesc();
			var oldN:Number = femininity;
			var Changed:Boolean = false;
			//If already perfect!
			if (goal == femininity)
				return "";
			//If turning MANLYMAN
			if (goal < femininity && goal <= 50)
			{
				femininity -= strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (femininity < goal)
					femininity = goal;
				Changed = true;
			}
			//if turning GIRLGIRLY, like duh!
			if (goal > femininity && goal >= 50)
			{
				femininity += strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (femininity > goal)
					femininity = goal;
				Changed = true;
			}
			//Fix if it went out of bounds!
			if (hasPerk("Androgyny") < 0)
				fixFemininity();
			//Abort if nothing changed!
			if (!Changed)
				return "";
			//See if a change happened!
			if (old != faceDesc())
			{
				//Gain fem?
				if (goal > oldN)
					output = "\n\n<b>Your facial features soften as your body becomes more feminine. (+" + strength + ")</b>";
				if (goal < oldN)
					output = "\n\n<b>Your facial features harden as your body becomes more masculine. (+" + strength + ")</b>";
			}
			//Barely noticable change!
			else
			{
				if (goal > oldN)
					output = "\n\nThere's a tingling in your " + face() + " as it changes imperceptibly towards being more feminine. (+" + strength + ")";
				else if (goal < oldN)
					output = "\n\nThere's a tingling in your " + face() + " as it changes imperciptibly towards being more masculine. (+" + strength + ")";
			}
			return output;
		}
		
		public function modThickness(goal:Number, strength:Number = 1)
		{
			var oldN:Number = thickness;
			if (goal == thickness)
				return "";
			//Lose weight fatty!
			if (goal < thickness && goal < 50)
			{
				thickness -= strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (thickness < goal)
					thickness = goal;
			}
			//Sup tubby!
			if (goal > thickness && goal > 50)
			{
				thickness += strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (thickness > goal)
					thickness = goal;
			}
			trace("MOD THICKNESS FIRE");
			//DIsplay 'U GOT FAT'
			if (goal >= thickness && goal >= 50)
				return "\n\nYour center of balance changes a little bit as your body noticeably widens. (+" + strength + " body thickness)";
			//GET THIN BITCH
			else if (goal <= thickness && goal <= 50)
				return "\n\nEach movement feels a tiny bit easier than the last.  Did you just lose a little weight!? (+" + strength + " thin)";
			return "";
		}
		
		public function modTone(goal:Number, strength:Number = 1)
		{
			var oldN:Number = tone;
			if (goal == tone)
				return "";
			//Lose muscle visibility!
			if (goal < tone && goal < 50)
			{
				tone -= strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (tone < goal)
				{
					tone = goal;
					return "\n\nYou've lost some tone, but can't lose any more this way. (-" + strength + " muscle tone)";
				}
			}
			//MOAR hulkness
			if (goal > tone && goal > 50)
			{
				tone += strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (tone > goal)
				{
					tone = goal;
					return "\n\nYou've gained some muscle tone, but can't gain any more this way. (+" + strength + " muscle tone)";
				}
			}
			//DIsplay BITCH I WORK OUT
			if (goal >= tone && goal > 50)
				return "\n\nYour body feels a little more solid as you move, and your muscles look slightly more visible. (+" + strength + " muscle tone)";
			//Display DERP I HAVE GIRL MUSCLES
			else if (goal <= tone && goal < 50)
				return "\n\nMoving brings with it a little more jiggle than you're used to.  You don't seem to have gained weight, but your muscles look less visible. (-" + strength + " muscle tone)";
			return "";
		}
		
		//Run this every hour to 'fix' femininity.
		public function fixFemininity():String
		{
			var output:String = "";
			//Genderless/herms share the same bounds
			if (gender == 0 || gender == 3)
			{
				if (femininity < 20)
				{
					output += "\n<b>Your incredibly masculine, chiseled features become a little bit softer from your body's changing hormones.";
					if (hasBeard())
					{
						output += "  As if that wasn't bad enough, your " + beard() + " falls out too!";
						beardLength = 0;
						beardStyle = 0;
					}
					output += "</b>\n";
					femininity = 20;
				}
				else if (femininity > 85)
				{
					output += "\n<b>You find your overly feminine face loses a little bit of its former female beauty due to your body's changing hormones.</b>\n";
					femininity = 85;
				}
			}
			//GURLS!
			else if (gender == 2)
			{
				if (femininity < 30)
				{
					output += "\n<b>Your incredibly masculine, chiseled features become a little bit softer from your body's changing hormones.";
					if (hasBeard())
					{
						output += "  As if that wasn't bad enough, your " + beard() + " falls out too!";
						beardLength = 0;
						beardStyle = 0;
					}
					output += "</b>\n";
					femininity = 30;
				}
			}
			//BOIZ!
			else if (gender == 1)
			{
				if (femininity > 70)
				{
					output += "\n<b>You find your overly feminine face loses a little bit of its former female beauty due to your body's changing hormones.</b>\n";
					femininity = 70;
				}
				if (femininity > 40 && hasBeard())
				{
					output += "\n<b>Your beard falls out, leaving you with " + faceDesc() + ".</b>\n";
					beardLength = 0;
					beardStyle = 0;
				}
			}
			if (gender != 1 && hasBeard())
			{
				output += "\n<b>Your beard falls out, leaving you with " + faceDesc() + ".</b>\n";
				beardLength = 0;
				beardStyle = 0;
			}
			return output;
		}
		
		public function hasBeard():Boolean
		{
			if (beardLength > 0)
				return true;
			else
				return false;
		}
		
		public function beard():String
		{
			if (hasBeard())
				return "beard";
			else
				return "ERROR: NO BEARD! <b>YOU ARE NOT A VIKING AND SHOULD TELL FEN IMMEDIATELY.</b>";
		}
		
		public function skin(noAdj:Boolean = false, noTone:Boolean = false):String
		{
			var skinzilla:String = "";
			//Only show stuff other than skinDesc if justSkin is false
			if (!noAdj)
			{
				//Adjectives first!
				if (skinAdj != "")
				{
					skinzilla += skinAdj;
					if (noTone)
						skinzilla += " ";
					else
						skinzilla += ", ";
				}
			}
			if (!noTone)
				skinzilla += skinTone + " ";
			//Fur handled a little differently since it uses
			//haircolor
			if (skinType == 1)
				skinzilla += "skin";
			else
				skinzilla += skinDesc;
			return skinzilla;
		}
		
		public function hasMuzzle():Boolean
		{
			if (faceType == 1 || faceType == 2 || faceType == 6 || faceType == 7 || faceType == 9 || faceType == 11 || faceType == 12)
				return true;
			return false;
		}
		
		public function face():String
		{
			var stringo:String = "";
			//0 - human
			//5 - Human w/Naga fangz
			//8 - bunnah faceahhh bunbun
			//10 - spidah-face (humanish)
			if (faceType == 0)
				return "face";
			//1 - horse
			//2 - dogface
			//6 - kittah face
			//9 - kangaface
			if (faceType == 9 || faceType == 6 || faceType == 2 || faceType == 1 || faceType == 11)
			{
				if (int(Math.random() * 2) == 0)
					return "muzzle";
				if (int(Math.random() * 3) == 0 && faceType == 1)
					stringo = "long ";
				if (int(Math.random() * 3) == 0 && faceType == 6)
					stringo = "feline ";
				return stringo + "face";
			}
			//3 - cowface
			if (faceType == 3)
			{
				if (Math.floor(Math.random() * 4) == 0)
					stringo = "bovine ";
				if (int(Math.random() * 2) == 0)
					return "muzzle";
				return stringo + "face";
			}
			//4 - sharkface-teeth
			if (faceType == 4)
			{
				if (Math.floor(Math.random() * 4) == 0)
					stringo = "angular ";
				return stringo + "face";
			}
			//7 - lizard face (durned argonians!)
			if (faceType == 7 || faceType == 12)
			{
				if (Math.floor(Math.random() * 4) == 0)
					stringo = "reptilian ";
				if (Math.floor(Math.random() * 4) == 0)
					return stringo + "muzzle";
				if (Math.floor(Math.random() * 4) == 0)
					return stringo + "snout";
				return stringo + "face";
			}
			return "face";
		}
		
		public function hasLongTail():Boolean
		{
			//tailType:
			//0 - none
			//1 - horse
			//2 - dog
			//3 - demon
			//4 - cow!
			//5 - spider!
			//6 - bee!
			//7 - shark tail!
			//8 - catTAIIIIIL
			//9 - lizard tail
			//10 - bunbuntail
			//11 - harpybutt
			//12 - rootail
			//13 - foxtail
			//14 - dagron tail
			if (isNaga())
				return true;
			if (tailType == 2 || tailType == 3 || tailType == 4 || tailType == 7 || tailType == 8 || tailType == 9 || tailType == 12 || tailType == 13 || tailType == 14)
				return true;
			return false;
		}
		
		public function isBiped():Boolean
		{
			//Naga/Centaur
			if (lowerBody == 3 || lowerBody == 4)
				return false;
			if (lowerBody == 8 || lowerBody == 11)
				return false;
			return true;
		}
		
		public function isNaga():Boolean
		{
			if (lowerBody == 3)
				return true;
			return false;
		}
		
		public function isTaur():Boolean
		{
			if (lowerBody == 4 || lowerBody == 11)
				return true;
			return false;
		}
		
		public function isDrider():Boolean
		{
			return (lowerBody == 16);
		}
		
		public function isGoo():Boolean
		{
			if (lowerBody == 8)
				return true;
			return false;
		}
		
		public function legs():String
		{
			var select:Number = 0;
			//lowerBody:
			//0 - normal
			if (lowerBody == 0)
				return "legs";
			//1 - hooves
			if (lowerBody == 1)
				return "legs";
			//2 - paws
			if (lowerBody == 2)
				return "legs";
			//3 - snakelike body
			if (lowerBody == 3)
				return "snake-like coils";
			//4 - centaur!
			if (lowerBody == 4)
				return "four legs";
			//8 - goo shit
			if (lowerBody == 8)
				return "mounds of goo";
			//PONY
			if (lowerBody == 11)
				return "cute pony-legs";
			//Bunnah!
			if (lowerBody == 12)
			{
				select = Math.floor(Math.random() * (5));
				if (select == 0)
					return "fuzzy, bunny legs";
				else if (select == 1)
					return "fur-covered legs";
				else if (select == 2)
					return "furry legs";
				else
					return "legs";
			}
			if (lowerBody == 13)
			{
				select = Math.floor(Math.random() * (5));
				if (select == 0)
					return "bird-like legs";
				else if (select == 1)
					return "feathered legs";
				else
					return "legs";
			}
			if (lowerBody == 17)
			{
				select = Math.floor(Math.random() * (4));
				if (select == 0)
					return "fox-like legs";
				else if (select == 1)
					return "legs";
				else if (select == 2)
					return "legs";
				else
					return "vulpine legs";
			}
			if (lowerBody == 19)
			{
				select = Math.floor(Math.random() * (4));
				if (select == 0)
					return "raccoon-like legs";
				else
					return "legs";
			}
			
			return "legs";
		}
		
		public function skinFurScales():String
		{
			var skinzilla:String = "";
			//Adjectives first!
			if (skinAdj != "")
				skinzilla += skinAdj + ", ";
			//Fur handled a little differently since it uses
			//haircolor
			if (skinType == 1)
				skinzilla += hairColor + " ";
			else
				skinzilla += skinTone + " ";
			skinzilla += skinDesc;
			return skinzilla;
		}
		
		public function leg():String
		{
			var select:Number = 0;
			//lowerBody:
			//0 - normal
			if (lowerBody == 0)
				return "leg";
			//1 - hooves
			if (lowerBody == 1)
				return "leg";
			//2 - paws
			if (lowerBody == 2)
				return "leg";
			//3 - snakelike body
			if (lowerBody == 3)
				return "snake-tail";
			//4 - centaur!
			if (lowerBody == 4)
				return "equine leg";
			//8 - goo shit
			if (lowerBody == 8)
				return "mound of goo";
			//PONY
			if (lowerBody == 11)
				return "cartoonish pony-leg";
			//BUNNAH
			if (lowerBody == 12)
			{
				select = Math.random() * (5);
				if (select == 0)
					return "fuzzy, bunny leg";
				else if (select == 1)
					return "fur-covered leg";
				else if (select == 2)
					return "furry leg";
				else
					return "leg";
			}
			if (lowerBody == 13)
			{
				select = Math.floor(Math.random() * (5));
				if (select == 0)
					return "bird-like leg";
				else if (select == 1)
					return "feathered leg";
				else
					return "leg";
			}
			if (lowerBody == 17)
			{
				select = Math.floor(Math.random() * (4));
				if (select == 0)
					return "fox-like leg";
				else if (select == 1)
					return "leg";
				else if (select == 2)
					return "leg";
				else
					return "vulpine leg";
			}
			if (lowerBody == 19)
			{
				select = Math.floor(Math.random() * (4));
				if (select == 0)
					return "raccoon-like leg";
				else
					return "leg";
			}
			return "leg";
		}
		
		public function feet():String
		{
			var select:Number = 0;
			//lowerBody:
			//0 - normal
			if (lowerBody == 0)
				return "feet";
			//1 - hooves
			if (lowerBody == 1)
				return "hooves";
			//2 - paws
			if (lowerBody == 2)
				return "paws";
			//3 - snakelike body
			if (lowerBody == 3)
				return "coils";
			//4 - centaur!
			if (lowerBody == 4)
				return "hooves";
			//5 - demonic heels
			if (lowerBody == 5)
				return "demonic high-heels";
			//6 - demonic claws
			if (lowerBody == 6)
				return "demonic foot-claws";
			//8 - goo shit
			if (lowerBody == 8)
				return "slimey cillia";
			if (lowerBody == 11)
				return "flat pony-feet";
			//BUNNAH
			if (lowerBody == 12)
			{
				select = rand(5);
				if (select == 0)
					return "large bunny feet";
				else if (select == 1)
					return "rabbit feet";
				else if (select == 2)
					return "large feet";
				else
					return "feet";
			}
			if (lowerBody == 13)
			{
				select = Math.floor(Math.random() * (5));
				if (select == 0)
					return "taloned feet";
				else
					return "feet";
			}
			if (lowerBody == 14)
				return "foot-paws";
			if (lowerBody == 17)
			{
				select = rand(4);
				if (select == 0)
					return "paws";
				else if (select == 1)
					return "soft, padded paws";
				else if (select == 2)
					return "fox-like feet";
				else
					return "paws";
			}
			if (lowerBody == 19)
			{
				select = Math.floor(Math.random() * (3));
				if (select == 0)
					return "raccoon-like feet";
				else if (select == 1)
					return "long-toed paws";
				else if (select == 2)
					return "feet";
				else
					return "paws";
			}
			return "feet";
		}
		
		public function foot():String
		{
			var select:Number = 0;
			//lowerBody:
			//0 - normal
			if (lowerBody == 0)
				return "foot";
			//1 - hooves
			if (lowerBody == 1)
				return "hoof";
			//2 - paws
			if (lowerBody == 2)
				return "paw";
			//3 - snakelike body
			if (lowerBody == 3)
				return "coiled tail";
			//4 - centaur!
			if (lowerBody == 4)
				return "hoof";
			//8 - goo shit
			if (lowerBody == 8)
				return "slimey undercarriage";
			//PONY
			if (lowerBody == 11)
				return "flat pony-foot";
			//BUNNAH
			if (lowerBody == 12)
			{
				select = Math.random() * (5);
				if (select == 0)
					return "large bunny foot";
				else if (select == 1)
					return "rabbit foot";
				else if (select == 2)
					return "large foot";
				else
					return "foot";
			}
			if (lowerBody == 13)
			{
				select = Math.floor(Math.random() * (5));
				if (select == 0)
					return "taloned foot";
				else
					return "foot";
			}
			if (lowerBody == 17)
			{
				select = Math.floor(Math.random() * (4));
				if (select == 0)
					return "paw";
				else if (select == 1)
					return "soft, padded paw";
				else if (select == 2)
					return "fox-like foot";
				else
					return "paw";
			}
			if (lowerBody == 14)
				return "foot-paw";
			if (lowerBody == 19)
			{
				select = Math.floor(Math.random() * (3));
				if (select == 0)
					return "raccoon-like foot";
				else if (select == 1)
					return "long-toed paw";
				else if (select == 2)
					return "foot";
				else
					return "paw";
			}
			return "foot";
		}
		
		//fertility must be >= random(0-beat)
		public function knockUp(type:int = 0, incubation:int = 0, beat:int = 100, arg:int = 0):void
		{
			//Contraceptives cancel!
			if (hasStatusAffect("Contraceptives") >= 0 && arg < 1)
				return;
			var bonus:int = 0;
			//If arg = 1 (always pregnant), bonus = 9000
			if (arg >= 1)
				bonus = 9000;
			if (arg <= -1)
				bonus = -9000;
			//If unpregnant and fertility wins out:
			if ((arg == 2 || (pregnancyIncubation == 0)) && totalFertility() + bonus > Math.floor(Math.random() * beat) && hasVagina())
			{
				pregnancyType = type;
				pregnancyIncubation = incubation;
				trace("PC Knocked up with pregnancy type: " + type + " for " + incubation + " incubation.");
			}
			//Chance for eggs fertilization - ovi elixir and imps excluded!
			if (type != 1 && type != 5 && type != 10)
			{
				if (hasPerk("Spider Ovipositor") >= 0 || hasPerk("Bee Ovipositor") >= 0)
				{
					if (totalFertility() + bonus > Math.floor(Math.random() * beat))
					{
						fertilizeEggs();
					}
				}
			}
		}
		
		//fertility must be >= random(0-beat)
		public function buttKnockUp(type:int = 0, incubation:int = 0, beat:int = 100, arg:int = 0):void
		{
			//Contraceptives cancel!
			if (hasStatusAffect("Contraceptives") >= 0 && arg < 1)
				return;
			var bonus:int = 0;
			//If arg = 1 (always pregnant), bonus = 9000
			if (arg >= 1)
				bonus = 9000;
			if (arg <= -1)
				bonus = -9000;
			//If unpregnant and fertility wins out:
			if ((arg == 2 || (buttPregnancyIncubation == 0)) && totalFertility() + bonus > Math.floor(Math.random() * beat))
			{
				buttPregnancyType = type;
				buttPregnancyIncubation = incubation;
				trace("PC Knocked up with pregnancy type: " + type + " for " + incubation + " incubation.");
			}
		}
		
		public function canOvipositSpider():Boolean
		{
			if (eggs() >= 10 && hasPerk("Spider Ovipositor") >= 0 && isDrider() && tailType == 5)
				return true;
			return false;
		}
		
		public function canOvipositBee():Boolean
		{
			if (eggs() >= 10 && hasPerk("Bee Ovipositor") >= 0 && tailType == 6)
				return true;
			return false;
		}
		
		public function canOviposit():Boolean
		{
			if (canOvipositSpider() || canOvipositBee())
				return true;
			return false;
		}
		
		public function eggs():int
		{
			if (hasPerk("Spider Ovipositor") < 0 && hasPerk("Bee Ovipositor") < 0)
				return -1;
			else if (hasPerk("Spider Ovipositor") >= 0)
				return perkv1("Spider Ovipositor");
			else
				return perkv1("Bee Ovipositor");
		}
		
		public function addEggs(arg:int = 0):int
		{
			if (hasPerk("Spider Ovipositor") < 0 && hasPerk("Bee Ovipositor") < 0)
				return -1;
			else
			{
				if (hasPerk("Spider Ovipositor") >= 0)
				{
					addPerkValue("Spider Ovipositor", 1, arg);
					if (eggs() > 50)
						changePerkValue("Spider Ovipositor", 1, 50);
					return perkv1("Spider Ovipositor");
				}
				else
				{
					addPerkValue("Bee Ovipositor", 1, arg);
					if (eggs() > 50)
						changePerkValue("Bee Ovipositor", 1, 50);
					return perkv1("Bee Ovipositor");
				}
			}
		}
		
		public function dumpEggs():void
		{
			if (hasPerk("Spider Ovipositor") < 0 && hasPerk("Bee Ovipositor") < 0)
				return;
			setEggs(0);
			//Sets fertile eggs = regular eggs (which are 0)
			fertilizeEggs();
		}
		
		public function setEggs(arg:int = 0):int
		{
			if (hasPerk("Spider Ovipositor") < 0 && hasPerk("Bee Ovipositor") < 0)
				return -1;
			else
			{
				if (hasPerk("Spider Ovipositor") >= 0)
				{
					changePerkValue("Spider Ovipositor", 1, arg);
					if (eggs() > 50)
						changePerkValue("Spider Ovipositor", 1, 50);
					return perkv1("Spider Ovipositor");
				}
				else
				{
					changePerkValue("Bee Ovipositor", 1, arg);
					if (eggs() > 50)
						changePerkValue("Bee Ovipositor", 1, 50);
					return perkv1("Bee Ovipositor");
				}
			}
		}
		
		public function fertilizedEggs():int
		{
			if (hasPerk("Spider Ovipositor") < 0 && hasPerk("Bee Ovipositor") < 0)
				return -1;
			else if (hasPerk("Spider Ovipositor") >= 0)
				return perkv2("Spider Ovipositor");
			else
				return perkv2("Bee Ovipositor");
		}
		
		public function fertilizeEggs():int
		{
			if (hasPerk("Spider Ovipositor") < 0 && hasPerk("Bee Ovipositor") < 0)
				return -1;
			else if (hasPerk("Spider Ovipositor") >= 0)
				changePerkValue("Spider Ovipositor", 2, eggs());
			else
				changePerkValue("Bee Ovipositor", 2, eggs());
			return fertilizedEggs();
		}
		
		//Create a keyItem
		public function createKeyItem(keyName:String, value1:Number, value2:Number, value3:Number, value4:Number):void
		{
			var newKeyItem = new keyItemClass();
			//used to denote that the array has already had its new spot pushed on.
			var arrayed:Boolean = false;
			//used to store where the array goes
			var keySlot:Number = 0
			var counter:Number = 0
			//Start the array if its the first bit
			if (keyItems.length == 0)
			{
				trace("New Key Item Started Array! " + keyName);
				keyItems.push(newKeyItem);
				arrayed = true;
				keySlot = 0;
			}
			//If it belongs at the end, push it on
			if (keyItems[keyItems.length - 1].keyName < keyName && !arrayed)
			{
				trace("New Key Item Belongs at the end!! " + keyName);
				keyItems.push(newKeyItem);
				arrayed = true;
				keySlot = keyItems.length - 1;
			}
			//If it belongs in the beginning, splice it in
			if (keyItems[0].keyName > keyName && !arrayed)
			{
				trace("New Key Item Belongs at the beginning! " + keyName);
				keyItems.splice(0, 0, newKeyItem);
				arrayed = true;
				keySlot = 0;
			}
			//Find the spot it needs to go in and splice it in.
			if (!arrayed)
			{
				trace("New Key Item using alphabetizer! " + keyName);
				counter = keyItems.length;
				while (counter > 0 && !arrayed)
				{
					counter--;
					//If the current slot is later than new key
					if (keyItems[counter].keyName > keyName)
					{
						//If the earlier slot is earlier than new key && a real spot
						if (counter - 1 >= 0)
						{
							//If the earlier slot is earlier slot in!
							if (keyItems[counter - 1].keyName <= keyName)
							{
								arrayed = true;
								keyItems.splice(counter, 0, newKeyItem);
								keySlot = counter;
							}
						}
						//If the item after 0 slot is later put here!
						else
						{
							//If the next slot is later we are go
							if (keyItems[counter].keyName <= keyName)
							{
								arrayed = true;
								keyItems.splice(counter, 0, newKeyItem);
								keySlot = counter;
							}
						}
					}
				}
			}
			//Fallback
			if (!arrayed)
			{
				trace("New Key Item Belongs at the end!! " + keyName);
				keyItems.push(newKeyItem);
				arrayed = true;
				keySlot = keyItems.length - 1;
			}
			
			keyItems[keySlot].keyName = keyName;
			keyItems[keySlot].value1 = value1;
			keyItems[keySlot].value2 = value2;
			keyItems[keySlot].value3 = value3;
			keyItems[keySlot].value4 = value4;
			trace("NEW KEYITEM FOR PLAYER in slot " + keySlot + ": " + keyItems[keySlot].keyName);
		}
		
		//Remove a key item
		public function removeKeyItem(itemName:String):void
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				//trace("ERROR: KeyItem could not be removed because player has no key items.");
				return;
			}
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == itemName)
				{
					keyItems.splice(counter, 1);
					trace("Attempted to remove \"" + itemName + "\" keyItem.");
					counter = 0;
				}
			}
		}
		
		public function addKeyValue(statusName:String, statusValueNum:Number = 1, newNum:Number = 0)
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				return;
					//trace("ERROR: Looking for keyitem '" + statusName + "' to change value " + statusValueNum + ", and player has no key items.");
			}
			while (counter > 0)
			{
				counter--;
				//Find it, change it, quit out
				if (keyItems[counter].keyName == statusName)
				{
					if (statusValueNum < 1 || statusValueNum > 4)
					{
						//trace("ERROR: AddKeyValue called with invalid key value number.");
						return;
					}
					if (statusValueNum == 1)
						keyItems[counter].value1 += newNum;
					if (statusValueNum == 2)
						keyItems[counter].value2 += newNum;
					if (statusValueNum == 3)
						keyItems[counter].value3 += newNum;
					if (statusValueNum == 4)
						keyItems[counter].value4 += newNum;
					return;
				}
			}
			//trace("ERROR: Looking for keyitem '" + statusName + "' to change value " + statusValueNum + ", and player does not have the key item.");
			return;
		}
		
		public function keyItemv1(statusName:String):Number
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == statusName)
					return keyItems[counter].value1;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function keyItemv2(statusName:String):Number
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == statusName)
					return keyItems[counter].value2;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function keyItemv3(statusName:String):Number
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == statusName)
					return keyItems[counter].value3;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function keyItemv4(statusName:String):Number
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == statusName)
					return keyItems[counter].value4;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function removeKeyItems():void
		{
			var counter:Number = keyItems.length;
			while (counter > 0)
			{
				counter--;
				keyItems.splice(counter, 1);
			}
		}
		
		public function hasKeyItem(keyName:String):Number
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
				return -2;
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == keyName)
					return counter;
			}
			return -1;
		}
		
		//Grow
		public function increaseCock(increase:Number, cockNum:Number):Number
		{
			if (hasPerk("Big Cock") >= 0)
				increase *= perks[hasPerk("Big Cock")].value1;
			if (hasPerk("Phallic Potential") >= 0)
				increase *= 1.5;
			if (hasPerk("Phallic Restraint") >= 0)
				increase *= .25;
			return cocks[cockNum].growCock(increase);
		}
		
		//BreastCup
		public function breastCup(rowNum:Number):String
		{
			if (breastRows[rowNum].breastRating < 1)
				return "flat, manly breast";
			else if (breastRows[rowNum].breastRating < 2)
				return "A-cup";
			else if (breastRows[rowNum].breastRating < 3)
				return "B-cup";
			else if (breastRows[rowNum].breastRating < 4)
				return "C-cup";
			else if (breastRows[rowNum].breastRating < 5)
				return "D-cup";
			else if (breastRows[rowNum].breastRating < 6)
				return "DD-cup";
			else if (breastRows[rowNum].breastRating < 7)
				return "big DD-cup";
			else if (breastRows[rowNum].breastRating < 8)
				return "E-cup";
			else if (breastRows[rowNum].breastRating < 9)
				return "big E-cup";
			else if (breastRows[rowNum].breastRating < 10)
				return "EE-cup";
			else if (breastRows[rowNum].breastRating < 11)
				return "big EE-cup";
			else if (breastRows[rowNum].breastRating < 12)
				return "F-cup";
			else if (breastRows[rowNum].breastRating < 13)
				return "big F-cup";
			else if (breastRows[rowNum].breastRating < 14)
				return "FF-cup";
			else if (breastRows[rowNum].breastRating < 15)
				return "big FF-cup";
			else if (breastRows[rowNum].breastRating < 16)
				return "G-cup";
			else if (breastRows[rowNum].breastRating < 17)
				return "big G-cup";
			else if (breastRows[rowNum].breastRating < 18)
				return "GG-cup";
			else if (breastRows[rowNum].breastRating < 19)
				return "big GG-cup";
			else if (breastRows[rowNum].breastRating < 20)
				return "H-cup";
			else if (breastRows[rowNum].breastRating < 21)
				return "big H-cup";
			else if (breastRows[rowNum].breastRating < 22)
				return "HH-cup";
			else if (breastRows[rowNum].breastRating < 23)
				return "big HH-cup";
			else if (breastRows[rowNum].breastRating < 24)
				return "HHH-cup";
			else if (breastRows[rowNum].breastRating < 25)
				return "I-cup";
			else if (breastRows[rowNum].breastRating < 26)
				return "big I-cup";
			else if (breastRows[rowNum].breastRating < 27)
				return "II-cup";
			else if (breastRows[rowNum].breastRating < 28)
				return "big II-cup";
			else if (breastRows[rowNum].breastRating < 29)
				return "J-cup";
			else if (breastRows[rowNum].breastRating < 30)
				return "big J-cup";
			else if (breastRows[rowNum].breastRating < 31)
				return "JJ-cup";
			else if (breastRows[rowNum].breastRating < 32)
				return "big JJ-cup";
			else if (breastRows[rowNum].breastRating < 33)
				return "K-cup";
			else if (breastRows[rowNum].breastRating < 34)
				return "big K-cup";
			else if (breastRows[rowNum].breastRating < 35)
				return "KK-cup";
			else if (breastRows[rowNum].breastRating < 36)
				return "big KK-cup";
			else if (breastRows[rowNum].breastRating < 37)
				return "L-cup";
			else if (breastRows[rowNum].breastRating < 38)
				return "big L-cup";
			else if (breastRows[rowNum].breastRating < 39)
				return "LL-cup";
			else if (breastRows[rowNum].breastRating < 40)
				return "big LL-cup";
			else if (breastRows[rowNum].breastRating < 41)
				return "M-cup";
			else if (breastRows[rowNum].breastRating < 42)
				return "big M-cup";
			else if (breastRows[rowNum].breastRating < 43)
				return "MM-cup";
			else if (breastRows[rowNum].breastRating < 44)
				return "big MM-cup";
			else if (breastRows[rowNum].breastRating < 45)
				return "MMM-cup";
			else if (breastRows[rowNum].breastRating < 46)
				return "large MMM-cup";
			else if (breastRows[rowNum].breastRating < 47)
				return "N-cup";
			else if (breastRows[rowNum].breastRating < 48)
				return "large N-cup";
			else if (breastRows[rowNum].breastRating < 49)
				return "NN-cup";
			else if (breastRows[rowNum].breastRating < 50)
				return "large NN-cup";
			else if (breastRows[rowNum].breastRating < 51)
				return "O-cup";
			else if (breastRows[rowNum].breastRating < 52)
				return "large O-cup";
			else if (breastRows[rowNum].breastRating < 53)
				return "OO-cup";
			else if (breastRows[rowNum].breastRating < 54)
				return "large OO-cup";
			else if (breastRows[rowNum].breastRating < 55)
				return "P-cup";
			else if (breastRows[rowNum].breastRating < 56)
				return "large P-cup";
			else if (breastRows[rowNum].breastRating < 57)
				return "PP-cup";
			else if (breastRows[rowNum].breastRating < 58)
				return "large PP-cup";
			else if (breastRows[rowNum].breastRating < 59)
				return "Q-cup";
			else if (breastRows[rowNum].breastRating < 60)
				return "large Q-cup";
			else if (breastRows[rowNum].breastRating < 61)
				return "QQ-cup";
			else if (breastRows[rowNum].breastRating < 62)
				return "large QQ-cup";
			else if (breastRows[rowNum].breastRating < 63)
				return "R-cup";
			else if (breastRows[rowNum].breastRating < 64)
				return "large R-cup";
			else if (breastRows[rowNum].breastRating < 65)
				return "RR-cup";
			else if (breastRows[rowNum].breastRating < 66)
				return "large RR-cup";
			else if (breastRows[rowNum].breastRating < 67)
				return "S-cup";
			else if (breastRows[rowNum].breastRating < 68)
				return "large S-cup";
			else if (breastRows[rowNum].breastRating < 69)
				return "SS-cup";
			else if (breastRows[rowNum].breastRating < 70)
				return "large SS-cup";
			else if (breastRows[rowNum].breastRating < 71)
				return "T-cup";
			else if (breastRows[rowNum].breastRating < 72)
				return "large T-cup";
			else if (breastRows[rowNum].breastRating < 73)
				return "TT-cup";
			else if (breastRows[rowNum].breastRating < 74)
				return "large TT-cup";
			else if (breastRows[rowNum].breastRating < 75)
				return "U-cup";
			else if (breastRows[rowNum].breastRating < 76)
				return "large U-cup";
			else if (breastRows[rowNum].breastRating < 77)
				return "UU-cup";
			else if (breastRows[rowNum].breastRating < 78)
				return "large UU-cup";
			else if (breastRows[rowNum].breastRating < 79)
				return "V-cup";
			else if (breastRows[rowNum].breastRating < 80)
				return "large V-cup";
			else if (breastRows[rowNum].breastRating < 81)
				return "VV-cup";
			else if (breastRows[rowNum].breastRating < 82)
				return "large VV-cup";
			else if (breastRows[rowNum].breastRating < 83)
				return "W-cup";
			else if (breastRows[rowNum].breastRating < 84)
				return "large W-cup";
			else if (breastRows[rowNum].breastRating < 85)
				return "WW-cup";
			else if (breastRows[rowNum].breastRating < 86)
				return "large WW-cup";
			else if (breastRows[rowNum].breastRating < 87)
				return "X-cup";
			else if (breastRows[rowNum].breastRating < 88)
				return "large X-cup";
			else if (breastRows[rowNum].breastRating < 89)
				return "XX-cup";
			else if (breastRows[rowNum].breastRating < 90)
				return "large XX-cup";
			else if (breastRows[rowNum].breastRating < 91)
				return "Y-cup";
			else if (breastRows[rowNum].breastRating < 92)
				return "large Y-cup";
			else if (breastRows[rowNum].breastRating < 93)
				return "YY-cup";
			else if (breastRows[rowNum].breastRating < 94)
				return "large YY-cup";
			else if (breastRows[rowNum].breastRating < 95)
				return "Z-cup";
			else if (breastRows[rowNum].breastRating < 96)
				return "large Z-cup";
			else if (breastRows[rowNum].breastRating < 97)
				return "ZZ-cup";
			else if (breastRows[rowNum].breastRating < 98)
				return "large ZZ-cup";
			else if (breastRows[rowNum].breastRating < 99)
				return "ZZZ-cup";
			else if (breastRows[rowNum].breastRating < 100)
				return "large ZZZ-cup";
			
			/*else if(breastRows[rowNum].breastRating < 20) return "watermelon-sized cup";
			   else if(breastRows[rowNum].breastRating < 35) return "tent-sized cup";
			   else if(breastRows[rowNum].breastRating < 60) return "truck-sized cup";
			 else if(breastRows[rowNum].breastRating < 100) return "parachute-sized cup";*/
			else
				return "game-breaking cup";
			return "Error-Cup (breastSize Error Number: " + breastRows[rowNum].breastRating;
			//watermelon-sized
			//tent sized
			//truck sized
			//parachute sized
			//pool-sized
			//hanger-sized
			//town-sized
			//city-sized
			//state-sized
			//continent-sized
			//planet-sized
			//WTFISTHISWHYISNTITGAMEOVER?
		}
		
		/*OLD AND UNUSED
		   public function breastCupS(rowNum:Number):String {
		   if(breastRows[rowNum].breastRating < 1) return "tiny";
		   else if(breastRows[rowNum].breastRating < 2) return "A";
		   else if(breastRows[rowNum].breastRating < 3) return "B";
		   else if(breastRows[rowNum].breastRating < 4) return "C";
		   else if(breastRows[rowNum].breastRating < 5) return "D";
		   else if(breastRows[rowNum].breastRating < 6) return "DD";
		   else if(breastRows[rowNum].breastRating < 7) return "E";
		   else if(breastRows[rowNum].breastRating < 8) return "F";
		   else if(breastRows[rowNum].breastRating < 9) return "G";
		   else if(breastRows[rowNum].breastRating < 10) return "GG";
		   else if(breastRows[rowNum].breastRating < 11) return "H";
		   else if(breastRows[rowNum].breastRating < 12) return "HH";
		   else if(breastRows[rowNum].breastRating < 13) return "HHH";
		   return "massive custom-made";
		 }*/
		public function bRows():Number
		{
			return breastRows.length;
		}
		
		public function totalBreasts():Number
		{
			var counter:Number = breastRows.length;
			var total:Number = 0;
			while (counter > 0)
			{
				counter--;
				total += breastRows[counter].breasts;
			}
			return total;
		}
		
		public function totalNipples():Number
		{
			var counter:Number = breastRows.length;
			var total:Number = 0;
			while (counter > 0)
			{
				counter--;
				total += breastRows[counter].nipplesPerBreast * breastRows[counter].breasts;
			}
			return total;
		}
		
				public function smallestTitSize():Number
		{
			if (breastRows.length == 0)
				return -1;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (breastRows[index].breastRating > breastRows[counter].breastRating)
					index = counter;
			}
			return breastRows[index].breastRating;
		}
		
		public function smallestTitRow():Number
		{
			if (breastRows.length == 0)
				return -1;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (breastRows[index].breastRating > breastRows[counter].breastRating)
					index = counter;
			}
			return index;
		}
		
		public function biggestTitRow():Number
		{
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (breastRows[index].breastRating < breastRows[counter].breastRating)
					index = counter;
			}
			return index;
		}
		
		public function averageBreastSize():Number
		{
			var counter:Number = breastRows.length;
			var average:Number = 0;
			while (counter > 0)
			{
				counter--;
				average += breastRows[counter].breastRating;
			}
			if (breastRows.length == 0)
				return 0;
			return (average / breastRows.length);
		}
		
		public function averageCockThickness():Number
		{
			var counter:Number = cocks.length;
			var average:Number = 0;
			while (counter > 0)
			{
				counter--;
				average += cocks[counter].cockThickness;
			}
			if (cocks.length == 0)
				return 0;
			return (average / cocks.length);
		}
		
		public function averageNippleLength():Number
		{
			var counter:Number = breastRows.length;
			var average:Number = 0;
			while (counter > 0)
			{
				counter--;
				average += (breastRows[counter].breastRating / 10 + .2);
			}
			return (average / breastRows.length);
		}
		
		public function averageVaginalLooseness():Number
		{
			var counter:Number = vaginas.length;
			var average:Number = 0;
			//If the player has no vaginas
			if (vaginas.length == 0)
				return 2;
			while (counter > 0)
			{
				counter--;
				average += vaginas[counter].vaginalLooseness;
			}
			return (average / vaginas.length);
		}
		
		public function averageVaginalWetness():Number
		{
			//If the player has no vaginas
			if (vaginas.length == 0)
				return 2;
			var counter:Number = vaginas.length;
			var average:Number = 0;
			while (counter > 0)
			{
				counter--;
				average += vaginas[counter].vaginalWetness;
			}
			return (average / vaginas.length);
		}
		
		public function averageCockLength():Number
		{
			var counter:Number = cocks.length;
			var average:Number = 0;
			while (counter > 0)
			{
				counter--;
				average += cocks[counter].cockLength;
			}
			if (cocks.length == 0)
				return 0;
			return (average / cocks.length);
		}
		
		public function canTitFuck():Boolean
		{
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (breastRows[index].breasts < breastRows[counter].breasts && breastRows[counter].breastRating > 3)
					index = counter;
			}
			if (breastRows[index].breasts >= 2 && breastRows[index].breastRating > 3)
				return true;
			return false;
		}
		
		public function mostBreastsPerRow():Number
		{
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (breastRows[index].breasts < breastRows[counter].breasts)
					index = counter;
			}
			return breastRows[index].breasts;
		}
		
		public function averageNipplesPerBreast():Number
		{
			var counter:Number = breastRows.length;
			var breasts:Number = 0;
			var nipples:Number = 0;
			while (counter > 0)
			{
				counter--;
				breasts += breastRows[counter].breasts;
				nipples += breastRows[counter].nipplesPerBreast * breastRows[counter].breasts;
			}
			if (breasts == 0)
				return 0;
			return Math.floor(nipples / breasts);
		}
		
		public function viridianChange():Boolean
		{
			var count:int = cockTotal();
			if (count == 0)
				return false;
			while (count > 0)
			{
				count--;
				if (cocks[count].sock == "amaranthine" && cocks[count].cockType != CockTypesEnum.DISPLACER)
					return true;
			}
			return false;
		}
		
		public function hasSheath():Boolean
		{
			if (dogCocks() > 0 || horseCocks() > 0 || catCocks() > 0 || kangaCocks() > 0 || displacerCocks() > 0)
				return true;
			return false;
		}
		
		public function hasKnot(arg:int = 0):Boolean
		{
			if (arg > cockTotal() - 1 || arg < 0)
				return false;
			return (cocks[arg].cockType == CockTypesEnum.DOG || cocks[arg].cockType == CockTypesEnum.DISPLACER);
		}
		
		
	}

}