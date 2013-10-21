//CoC Creature.as
package classes
{
	import classes.cockClass;
	import classes.vaginaClass;
	import classes.breastRowClass;
	import classes.assClass;
	import classes.perkClass;
	import classes.statusAffectClass;
	import classes.keyItemClass;
	public class creature
	{
		//Constructor
		public function creature()
		{
			cocks = new Array();
			vaginas = new Array();
			breastRows = new Array();
			perks = new Array();
			statusAffects = new Array();
			keyItems = new Array();			
		}
		/*Cock types
		0 - human
		1 - horse
		2 - dog
		3 - demon
		4 - tentacle?
		5 - CAT
		6 - Lizard/Naga?
		7 - ANEMONE!
		8 - ugliest wang ever (kangaroo)
		9 - dragon
		10 - displacer
		*/	
		//Variables
		//AUTOSAVE
		public var slotName:String = "VOID";
		public var autoSave:Boolean = false;
		//For enemies
		public var bonusHP:Number = 0;
		public var short:String = "You";
		public var a:String = "a ";
		public var long:String = "An imp is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from his head, parted by two four inch long horns.  His eyes are solid black, save for tiny red irises that seem to glow with evil intent.  His skin is bright red, and unencumbered by clothing or armor, save for a small loincloth at his belt.  His feet are covered by tiny wooden sandles, and his hands tipped with sharp claws.";
		public var capitalA:String = "A ";
		//Is a creature a 'plural' encounter - mob, etc. 
		public var plural:Boolean = false;
		//Lust vulnerability
		public var lustVuln:Number = 1;
		
		//temperment - used for determining grapple behaviors
		//0 - avoid grapples/break grapple
		//1 - lust determines > 50 grapple
		//2 - random
		//3 - love grapples
		public var temperment:Number = 0;
		public var special1:Number = 0;
		public var special2:Number = 0;
		public var special3:Number = 0;
		//he
		public var pronoun1:String = "";
		//him
		public var pronoun2:String = "";
		//3: Possessive his 
		public var pronoun3:String = "";
		
		//Clothing/Armor
		public var armorName:String = "";
		public var weaponName:String = "";
		public var weaponVerb:String = "";
		public var armorDef:Number = 0;
		public var armorPerk:String = "";
		public var weaponAttack:Number = 0;
		public var weaponPerk:String = "";
		public var weaponValue:Number = 0;
		public var armorValue:Number = 0;
		//Primary stats
		public var str:Number = 0;
		public var tou:Number = 0;
		public var spe:Number = 0;
		public var inte:Number = 0;
		public var lib:Number = 0;
		public var sens:Number = 0;
		public var cor:Number = 0;
		public var fatigue:Number = 0;
		
		//Combat Stats
		public var HP:Number = 0;
		public var lust:Number = 0;
		public var teaseLevel:Number = 0;
		public var teaseXP:Number = 0;
		
		//Level Stats
		public var XP:Number = 0;
		public var level:Number = 0;
		public var gems:Number = 0;
		//Perks used to store 'queued' perk buys
		public var perkPoints:Number = 0;
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		public var gender:Number = 0;
		public var femininity:Number = 50;
		public var tallness:Number = 0;
		public var hairColor:String = "no";
		public var hairLength:Number = 0;
		//Hairtype
		//0- normal
		//1- feather
		//2- ghost
		//3- goo!
		//4- anemononeoenoeneo!
		public var hairType:Number = 0;
		//Eyetype
		//0 - normal
		//1 - spidah!
		//2 - sandtrap!
		public var eyeType:Number = 0;
		public var beardLength:Number = 0;
		public var beardStyle:Number = 0;
		public var thickness:Number = 0;
		public var tone:Number = 0;
		//Skintype
		//0 - skin
		//1 - furry
		//2 - scaley
		//3 - goopey
		public var skinType:Number = 0;
		public var skinTone:String = "albino";
		public var skinDesc:String = "skin";
		public var skinAdj:String = "";
		//Facetype:
		//0 - human
		//1 - horse
		//2 - dogface
		//3 - cowface
		//4 - sharkface-teeth
		//5 - Human w/Naga fangz
		//6 - kittah face
		//7 - lizard face (durned argonians!)
		//8 - bunnah faceahhh bunbun
		//9 - kangaface
		//10 - spidah-face (humanish)
		//11 - foxface!
		//12 - dragon face
		//13 - Halfcoon
		//14 - fullcoon
		//15 - halfmouse
		//16 - fullmouse
		public var faceType:Number = 0;
		//TongueType
		//0 - normal
		//1 - snakey
		//2 - demon
		//3 - dragon
		public var tongueType:Number = 0;
		//EarType
		//-1 - none!
		//0 - human
		//1 - horse
		//2 - dog
		//3 - cow
		//4 - elf
		//5 - catzilla
		//6 - Snakezilla
		//7 - Bunbunz
		//8 - Roo Ears
		//9 - fox ears
		//10 - dragon
		//11 - coon
		//12 - mouse
		public var earType:Number = 0;
		public var earValue:Number = 0;
		public var antennae:Number = 0;
		public var horns:Number = 0;
		//ArmType
		//0 - normal
		//1 - harpy feathered
		//2 - SPIDA
		public var armType:Number = 0;
		//Horntype
		//1 - demonic
		//2 - minotaur (cowlike)
		//3 - Draconic/Lizard
		//4 - Double draconic
		//5 - Antlers
		public var hornType:Number = 0;
		public var wingDesc:String = "non-existant";
		public var gills:Boolean = false;
		//Wingtype
		//0 - none
		//1 - bee
		//2 - large bee
		//3 - faerie?
		//4 - avian
		//5 - dragoooon?
		//6 - demon/bat
		//7 - large demon/bat
		//8 - shark wing lolololol
		//9 - harpy
		//10 - small dagron
		//11 - trogdor wings
		//12 - sandtrap wings
		public var wingType:Number = 0;
		//lowerBody:
		//0 - normal
		//1 - hooves
		//2 - paws
		//3 - snakelike body
		//4 - centaur!
		//5 - demonic heels
		//6 - demon foot-claws
		//7 - bee legs
		//8 - goo mound
		//9 - catfeet
		//10 - lizardfeet
		//11 - MLP.
		//12 - DAH BUNNY!
		//13 - Harpah Legz
		//14 - Roo feet!
		//15 - Spider Legz
		//16 - Drider Legs
		//17 - foxpaws
		//18 - dragonfeet
		//19 - raccoonfeet
		public var lowerBody:Number = 0;
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
		//15 - raccoon tail
		//16 - mousetail
		public var tailType:Number = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		public var tailVenom:Number = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		public var tailRecharge:Number = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		public var hipRating:Number = 0;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		public var buttRating:Number = 0;
		//Key items
		public var keyItems:Array;
		
		//Piercings
		public var nipplesPierced:Number = 0;
		public var nipplesPShort:String = "";
		public var nipplesPLong:String = "";
		public var lipPierced:Number = 0;
		public var lipPShort:String = "";
		public var lipPLong:String = "";
		public var tonguePierced:Number = 0;
		public var tonguePShort:String = "";
		public var tonguePLong:String = "";
		public var eyebrowPierced:Number = 0;
		public var eyebrowPShort:String = "";
		public var eyebrowPLong:String = "";
		public var earsPierced:Number = 0;
		public var earsPShort:String = "";
		public var earsPLong:String = "";
		public var nosePierced:Number = 0;
		public var nosePShort:String = "";
		public var nosePLong:String = "";
		
		//Sexual Stuff
		public var cocks:Array;
			//balls
			public var balls:Number = 0;
			public var cumMultiplier:Number = 1;
			public var ballSize:Number = 0;
			public var hoursSinceCum:Number = 0;
		public var vaginas:Array;
			//Fertility is a % out of 100. 
			public var fertility:Number = 10;
			public var clitLength:Number = .5;
			public var nippleLength:Number = .25;
		public var breastRows:Array;
		public var ass = new assClass();
		public var perks:Array;
		public var statusAffects:Array;
		
		//Preggos
		public var pregnancyIncubation = 0;
		//1 = imp
		//2 = minotaur
		//3 = tentacle
		//4 = mouse
		//5 = EGGZ
		//6 = hellhound
		//7 = centaur
		//8 = MARBLZ
		public var pregnancyType = 0;
		public var buttPregnancyIncubation = 0;
		//2 = bee
		public var buttPregnancyType = 0;
		
		//Number of times explored for new areas
		public var explored = 0;
			public var exploredForest = 0;
			public var exploredDesert = 0;
			public var exploredMountain = 0;
			public var exploredLake = 0;
		
		
		//Functions
		//Return bonus fertility
		public function bonusFertility():Number {
			var counter:Number = 0;
			if(hasPerk("heat") >= 0) counter += perks[hasPerk("heat")].value1;
			if(hasPerk("Fertility+") >= 0) counter+= 15;
			if(hasPerk("Marae's Gift - Fertility") >= 0) counter += 50;
			if(hasPerk("Fera's Boon - Breeding Bitch") >= 0) counter += 30;
			if(hasPerk("Magical Fertility") >= 0) counter += 10;
			counter += perkv2("Elven Bounty");
			counter += perkv1("Pierced: Fertite");
			return counter;
		}
		//return total fertility
		public function totalFertility():Number {
			return (bonusFertility() + fertility);
		}
		public function faceDesc():String {
			var faceo:String = "";
			//0-10
			if(femininity < 10) {
				faceo = "a square chin";
				if(!hasBeard()) faceo += " and chiseled jawline";
				else faceo += ", chiseled jawline, and " + beard();
			}
			//10+ -20
			else if(femininity < 20) {
				faceo = "a rugged looking " + face() + " ";
				if(hasBeard()) faceo += "and " + beard();
				faceo += "that's surely handsome";
			}
			//21-28
			else if(femininity < 28) faceo = "a well-defined jawline and a fairly masculine profile";
			//28+-35 
			else if(femininity < 35) faceo = "a somewhat masculine, angular jawline";
			//35-45
			else if(femininity < 45) faceo = "the barest hint of masculinity on its features";
			//45-55
			else if(femininity <= 55) faceo = "an androgynous set of features that would look normal on a male or female";
			//55+-65
			else if(femininity <= 65) faceo = "a tiny touch of femininity to it, with gentle curves";
			//65+-72
			else if(femininity <= 72) faceo = "a nice set of cheekbones and lips that have the barest hint of pout";
			//72+-80
			else if(femininity <= 80) faceo = "a beautiful, feminine shapeliness that's sure to draw the attention of males";
			//81-90
			else if(femininity <= 90) faceo = "a gorgeous profile with full lips, a button nose, and noticeable eyelashes";
			//91-100
			else faceo = "a jaw-droppingly feminine shape with full, pouting lips, an adorable nose, and long, beautiful eyelashes";
			return faceo;
		}
		//Modify femininity!
		public function modFem(goal:Number,strength:Number = 1):String {
			var output:String = "";
			var old:String = faceDesc();
			var oldN:Number = femininity;
			var Changed:Boolean = false;
			//If already perfect!
			if(goal == femininity) return "";
			//If turning MANLYMAN
			if(goal < femininity && goal <= 50) {
				femininity -= strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if(femininity < goal) femininity = goal;
				Changed = true;
			}
			//if turning GIRLGIRLY, like duh!
			if(goal > femininity && goal >= 50) {
				femininity += strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if(femininity > goal) femininity = goal;
				Changed = true;
			}
			//Fix if it went out of bounds!
			if(hasPerk("Androgyny") < 0) fixFemininity();
			//Abort if nothing changed!
			if(!Changed) return "";
			//See if a change happened!
			if(old != faceDesc()) {
				//Gain fem?
				if(goal > oldN) output = "\n\n<b>Your facial features soften as your body becomes more feminine. (+" + strength + ")</b>";
				if(goal < oldN) output = "\n\n<b>Your facial features harden as your body becomes more masculine. (+" + strength + ")</b>";
			}
			//Barely noticable change!
			else {
				if(goal > oldN) output = "\n\nThere's a tingling in your " + face() + " as it changes imperceptibly towards being more feminine. (+" + strength + ")";
				else if(goal < oldN) output = "\n\nThere's a tingling in your " + face() + " as it changes imperciptibly towards being more masculine. (+" + strength + ")";
			}
			return output;
		}
		public function modThickness(goal:Number,strength:Number = 1) {
			var oldN:Number = thickness;
			if(goal == thickness) return "";
			//Lose weight fatty!
			if(goal < thickness && goal < 50) {
				thickness -= strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if(thickness < goal) thickness = goal;
			}
			//Sup tubby!
			if(goal > thickness && goal > 50) {
				thickness += strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if(thickness > goal) thickness = goal;
			}
			trace("MOD THICKNESS FIRE");
			//DIsplay 'U GOT FAT'
			if(goal >= thickness && goal >= 50) return "\n\nYour center of balance changes a little bit as your body noticeably widens. (+" + strength + " body thickness)";
			//GET THIN BITCH
			else if(goal <= thickness && goal <= 50) return "\n\nEach movement feels a tiny bit easier than the last.  Did you just lose a little weight!? (+" + strength + " thin)";
			return "";
		}
		public function modTone(goal:Number,strength:Number = 1) {
			var oldN:Number = tone;
			if(goal == tone) return "";
			//Lose muscle visibility!
			if(goal < tone && goal < 50) {
				tone -= strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if(tone < goal) {
					tone = goal;
					return "\n\nYou've lost some tone, but can't lose any more this way. (-" + strength + " muscle tone)";
				}
			}
			//MOAR hulkness
			if(goal > tone && goal > 50) {
				tone += strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if(tone > goal) {
					tone = goal;
					return "\n\nYou've gained some muscle tone, but can't gain any more this way. (+" + strength + " muscle tone)";
				}
			}
			//DIsplay BITCH I WORK OUT
			if(goal >= tone && goal > 50) return "\n\nYour body feels a little more solid as you move, and your muscles look slightly more visible. (+" + strength + " muscle tone)";
			//Display DERP I HAVE GIRL MUSCLES
			else if(goal <= tone && goal < 50) return "\n\nMoving brings with it a little more jiggle than you're used to.  You don't seem to have gained weight, but your muscles look less visible. (-" + strength + " muscle tone)";
			return "";
		}
		//Run this every hour to 'fix' femininity.
		public function fixFemininity():String {
			var output:String = "";
			//Genderless/herms share the same bounds
			if(gender == 0 || gender == 3) {
				if(femininity < 20) {
					output += "\n<b>Your incredibly masculine, chiseled features become a little bit softer from your body's changing hormones.";
					if(hasBeard()) {
						output += "  As if that wasn't bad enough, your " + beard() + " falls out too!";
						beardLength = 0;
						beardStyle = 0;
					}
					output += "</b>\n";
					femininity = 20;
				}
				else if(femininity > 85) {
					output += "\n<b>You find your overly feminine face loses a little bit of its former female beauty due to your body's changing hormones.</b>\n";
					femininity = 85;
				}
			}
			//GURLS!
			else if(gender == 2) {
				if(femininity < 30) {
					output += "\n<b>Your incredibly masculine, chiseled features become a little bit softer from your body's changing hormones.";
					if(hasBeard()) {
						output += "  As if that wasn't bad enough, your " + beard() + " falls out too!";
						beardLength = 0;
						beardStyle = 0;
					}
					output += "</b>\n";
					femininity = 30;
				}
			}
			//BOIZ!
			else if(gender == 1) {
				if(femininity > 70) {
					output += "\n<b>You find your overly feminine face loses a little bit of its former female beauty due to your body's changing hormones.</b>\n";
					femininity = 70;
				}
				if(femininity > 40 && hasBeard()) {
					output += "\n<b>Your beard falls out, leaving you with " + faceDesc() + ".</b>\n";
					beardLength = 0;
					beardStyle = 0;
				}
			}
			if(gender != 1 && hasBeard()) {
				output += "\n<b>Your beard falls out, leaving you with " + faceDesc() + ".</b>\n";
				beardLength = 0;
				beardStyle = 0;
			}
			return output;
		}			
		public function hasBeard():Boolean {
			if(beardLength > 0) return true;
			else return false;
		}
		public function beard():String {
			if(hasBeard()) return "beard";
			else return "ERROR: NO BEARD! <b>YOU ARE NOT A VIKING AND SHOULD TELL FEN IMMEDIATELY.</b>";
		}
		public function skinFurScales():String {
			var skinzilla:String = "";
			//Adjectives first!
			if(skinAdj != "") skinzilla += skinAdj + ", ";
			//Fur handled a little differently since it uses
			//haircolor
			if(skinType == 1) skinzilla += hairColor + " ";
			else skinzilla += skinTone + " ";
			skinzilla += skinDesc;
			return skinzilla;
		}
		public function skin(noAdj:Boolean = false, noTone:Boolean = false):String {
			var skinzilla:String = "";
			//Only show stuff other than skinDesc if justSkin is false
			if(!noAdj) {
				//Adjectives first!
				if(skinAdj != "") {
					skinzilla += skinAdj;
					if(noTone) skinzilla += " ";
					else skinzilla += ", ";
				}
			}
			if(!noTone) skinzilla += skinTone + " ";
			//Fur handled a little differently since it uses
			//haircolor
			if(skinType == 1) skinzilla += "skin";
			else skinzilla += skinDesc;
			return skinzilla;
		}
		public function hasMuzzle():Boolean {
			if(faceType == 1 || faceType == 2 || faceType == 6 || faceType == 7 || faceType == 9 || faceType == 11 || faceType == 12) return true;
			return false;
		}
		public function face():String {
			var stringo:String = "";
			//0 - human
			//5 - Human w/Naga fangz
			//8 - bunnah faceahhh bunbun
			//10 - spidah-face (humanish)
			if(faceType == 0) return "face";
			//1 - horse
			//2 - dogface
			//6 - kittah face
			//9 - kangaface
			if(faceType == 9 || faceType == 6 || faceType == 2 || faceType == 1 || faceType == 11) {
				if(int(Math.random()*2) == 0) return "muzzle";
				if(int(Math.random()*3) == 0 && faceType == 1) stringo = "long ";
				if(int(Math.random()*3) == 0 && faceType == 6) stringo = "feline ";
				return stringo+"face";
			}
			//3 - cowface
			if(faceType == 3) {
				if(Math.floor(Math.random() * 4) == 0) stringo = "bovine ";
				if(int(Math.random()*2) == 0) return "muzzle";
				return stringo+"face";
			}
			//4 - sharkface-teeth
			if(faceType == 4) {
				if(Math.floor(Math.random() * 4) == 0) stringo = "angular ";
				return stringo + "face";
			}
			//7 - lizard face (durned argonians!)
			if(faceType == 7 || faceType == 12) {
				if(Math.floor(Math.random() * 4) == 0) stringo = "reptilian ";
				if(Math.floor(Math.random() * 4) == 0) return stringo + "muzzle";
				if(Math.floor(Math.random() * 4) == 0) return stringo + "snout";
				return stringo + "face";
			}
			return "face";
		}
		public function hasLongTail():Boolean {
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
			if(isNaga()) return true;
			if(tailType == 2 || tailType == 3 || tailType == 4 || tailType == 7 || tailType == 8 || tailType == 9 || tailType == 12 || tailType == 13 || tailType == 14) return true;
			return false;
		}
		public function isBiped():Boolean {
			//Naga/Centaur
			if(lowerBody == 3 || lowerBody == 4) return false;
			if(lowerBody == 8 || lowerBody == 11) return false;
			return true;
		}
		public function isNaga():Boolean {
			if(lowerBody == 3) return true;
			return false;
		}
		public function isTaur():Boolean {
			if(lowerBody == 4 || lowerBody == 11) return true;
			return false;
		}
		public function isDrider():Boolean {
			return (lowerBody == 16);
		}
		public function isGoo():Boolean {
			if(lowerBody == 8) return true;
			return false;
		}
		public function legs():String {
			var select:Number = 0;
			//lowerBody:
		//0 - normal
			if(lowerBody == 0) return "legs";
		//1 - hooves
			if(lowerBody == 1) return "legs";
		//2 - paws
			if(lowerBody == 2) return "legs";
		//3 - snakelike body
			if(lowerBody == 3) return "snake-like coils";
		//4 - centaur!
			if(lowerBody == 4) return "four legs";
		//8 - goo shit
			if(lowerBody == 8) return "mounds of goo";
		//PONY
			if(lowerBody == 11) return "cute pony-legs";
		//Bunnah!
			if(lowerBody == 12) {
				select = Math.floor(Math.random() * (5));
				if(select == 0) return "fuzzy, bunny legs";
				else if(select == 1) return "fur-covered legs";
				else if(select == 2) return "furry legs";
				else return "legs";
			}
			if(lowerBody == 13) {
				select = Math.floor(Math.random() * (5));
				if(select == 0) return "bird-like legs";
				else if(select == 1) return "feathered legs";
				else return "legs";
			}
			if(lowerBody == 17) {
				select = Math.floor(Math.random() * (4));
				if(select == 0) return "fox-like legs";
				else if(select == 1) return "legs";
				else if(select == 2) return "legs";
				else return "vulpine legs";
			}
			if(lowerBody == 19) {
				select = Math.floor(Math.random() * (4));
				if(select == 0) return "raccoon-like legs";
				else return "legs";				
			}
			
			return "legs";
		}
		public function leg():String {
			var select:Number = 0;
			//lowerBody:
		//0 - normal
			if(lowerBody == 0) return "leg";
		//1 - hooves
			if(lowerBody == 1) return "leg";
		//2 - paws
			if(lowerBody == 2) return "leg";
		//3 - snakelike body
			if(lowerBody == 3) return "snake-tail";
		//4 - centaur!
			if(lowerBody == 4) return "equine leg";
		//8 - goo shit
			if(lowerBody == 8) return "mound of goo";
					//PONY
			if(lowerBody == 11) return "cartoonish pony-leg";
			//BUNNAH
			if(lowerBody == 12) {
				select = Math.random() * (5);
				if(select == 0) return "fuzzy, bunny leg";
				else if(select == 1) return "fur-covered leg";
				else if(select == 2) return "furry leg";
				else return "leg";
			}
			if(lowerBody == 13) {
				select = Math.floor(Math.random() * (5));
				if(select == 0) return "bird-like leg";
				else if(select == 1) return "feathered leg";
				else return "leg";
			}
			if(lowerBody == 17) {
				select = Math.floor(Math.random() * (4));
				if(select == 0) return "fox-like leg";
				else if(select == 1) return "leg";
				else if(select == 2) return "leg";
				else return "vulpine leg";
			}
			if(lowerBody == 19) {
				select = Math.floor(Math.random() * (4));
				if(select == 0) return "raccoon-like leg";
				else return "leg";				
			}
			return "leg";
		}
		public function feet():String {
			var select:Number = 0;
			//lowerBody:
			//0 - normal
			if(lowerBody == 0) return "feet";
			//1 - hooves
			if(lowerBody == 1) return "hooves";
			//2 - paws
			if(lowerBody == 2) return "paws";
			//3 - snakelike body
			if(lowerBody == 3) return "coils";
			//4 - centaur!
			if(lowerBody == 4) return "hooves";
			//5 - demonic heels
			if(lowerBody == 5) return "demonic high-heels";
			//6 - demonic claws
			if(lowerBody == 6) return "demonic foot-claws";
			//8 - goo shit
			if(lowerBody == 8) return "slimey cillia";
			if(lowerBody == 11) return "flat pony-feet";
			//BUNNAH
			if(lowerBody == 12) {
				select = rand(5);
				if(select == 0) return "large bunny feet";
				else if(select == 1) return "rabbit feet";
				else if(select == 2) return "large feet";
				else return "feet";
			}
			if(lowerBody == 13) {
				select = Math.floor(Math.random() * (5));
				if(select == 0) return "taloned feet";
				else return "feet";
			}
			if(lowerBody == 14) return "foot-paws";
			if(lowerBody == 17) {
				select = rand(4);
				if(select == 0) return "paws";
				else if(select == 1) return "soft, padded paws";
				else if(select == 2) return "fox-like feet";
				else return "paws";
			}
			if(lowerBody == 19) {
				select = Math.floor(Math.random() * (3));
				if(select == 0) return "raccoon-like feet";
				else if(select == 1) return "long-toed paws";
				else if(select == 2) return "feet";
				else return "paws";
			}
			return "feet";
		}
		public function foot():String {
			var select:Number = 0;
			//lowerBody:
			//0 - normal
			if(lowerBody == 0) return "foot";
			//1 - hooves
			if(lowerBody == 1) return "hoof";
			//2 - paws
			if(lowerBody == 2) return "paw";
			//3 - snakelike body
			if(lowerBody == 3) return "coiled tail";
			//4 - centaur!
			if(lowerBody == 4) return "hoof";
			//8 - goo shit
			if(lowerBody == 8) return "slimey undercarriage";
			//PONY
			if(lowerBody == 11) return "flat pony-foot";
			//BUNNAH
			if(lowerBody == 12) {
				select = Math.random() * (5);
				if(select == 0) return "large bunny foot";
				else if(select == 1) return "rabbit foot";
				else if(select == 2) return "large foot";
				else return "foot";
			}
			if(lowerBody == 13) {
				select = Math.floor(Math.random() * (5));
				if(select == 0) return "taloned foot";
				else return "foot";
			}
			if(lowerBody == 17) {
				select = Math.floor(Math.random() * (4));
				if(select == 0) return "paw";
				else if(select == 1) return "soft, padded paw";
				else if(select == 2) return "fox-like foot";
				else return "paw";
			}
			if(lowerBody == 14) return "foot-paw";
			if(lowerBody == 19) {
				select = Math.floor(Math.random() * (3));
				if(select == 0) return "raccoon-like foot";
				else if(select == 1) return "long-toed paw";
				else if(select == 2) return "foot";
				else return "paw";
			}
			return "foot";
		}
		//Create a perk
		public function createPerk(keyName:String, value1:Number, value2:Number, value3:Number, value4:Number, desc:String = ""):void {
			var newKeyItem = new perkClass();
			//used to denote that the array has already had its new spot pushed on.
			var arrayed:Boolean = false;
			//used to store where the array goes
			var keySlot:Number = 0
			var counter:Number = 0
			//Start the array if its the first bit
			if(perks.length == 0) {
				//trace("New Perk Started Array! " + keyName);
				perks.push(newKeyItem);
				arrayed = true;
				keySlot = 0;
			}
			//If it belongs at the end, push it on
			if(perks[perks.length-1].perkName < keyName && !arrayed) {
				//trace("New Perk Belongs at the end!! " + keyName);
				perks.push(newKeyItem);
				arrayed = true;
				keySlot = perks.length-1;
			}
			//If it belongs in the beginning, splice it in
			if(perks[0].perkName > keyName && !arrayed) {
				//trace("New Perk Belongs at the beginning! " + keyName);
				perks.splice(0,0,newKeyItem);
				arrayed = true;
				keySlot = 0;
			}
			//Find the spot it needs to go in and splice it in.
			if(!arrayed){
				//trace("New Perk using alphabetizer! " + keyName);
				counter = perks.length;
				while(counter > 0 && !arrayed) {
					counter--;
					//If the current slot is later than new key
					if(perks[counter].perkName > keyName) {
						//If the earlier slot is earlier than new key && a real spot
						if(counter-1 >= 0)
						{
							//If the earlier slot is earlier slot in!
							if(perks[counter-1].perkName <= keyName) {
								arrayed = true;
								perks.splice(counter,0,newKeyItem);
								keySlot = counter;
							}
						}
						//If the item after 0 slot is later put here!
						else {
							//If the next slot is later we are go
							if(perks[counter].perkName <= keyName) {
								arrayed = true;
								perks.splice(counter,0,newKeyItem);
								keySlot = counter;
							}
						}
					}
				}
			}
			//Fallback
			if(!arrayed) {
				//trace("New Perk Belongs at the end!! " + keyName);
				perks.push(newKeyItem);
				arrayed = true;
				keySlot = perks.length-1;
			}
			
			perks[keySlot].perkName = keyName;
			perks[keySlot].value1 = value1;
			perks[keySlot].value2 = value2;
			perks[keySlot].value3 = value3;
			perks[keySlot].value4 = value4;
			perks[keySlot].perkDesc = desc;
			//trace("NEW PERK FOR PLAYER in slot " + keySlot + ": " + perks[keySlot].perkName);
		}
		//fertility must be >= random(0-beat)
		public function knockUp(type:int = 0,incubation:int = 0,beat:int = 100,arg:int = 0):void {
			//Contraceptives cancel!
			if(hasStatusAffect("Contraceptives") >= 0 && arg < 1) return;
			var bonus:int = 0;
			//If arg = 1 (always pregnant), bonus = 9000
			if(arg >= 1) bonus = 9000;
			if(arg <= -1) bonus = -9000;
			//If unpregnant and fertility wins out:
			if((arg == 2 || (pregnancyIncubation == 0)) && totalFertility() + bonus > Math.floor(Math.random() * beat) && hasVagina()) {
				pregnancyType = type;
				pregnancyIncubation = incubation;
				trace("PC Knocked up with pregnancy type: " + type + " for " + incubation + " incubation.");
			}
			//Chance for eggs fertilization - ovi elixir and imps excluded!
			if(type != 1 && type != 5 && type != 10) {
				if(hasPerk("Spider Ovipositor") >= 0 || hasPerk("Bee Ovipositor") >= 0) {
					if(totalFertility() + bonus > Math.floor(Math.random() * beat)) {
						fertilizeEggs();
					}
				}
			}
		}
		//fertility must be >= random(0-beat)
		public function buttKnockUp(type:int = 0,incubation:int = 0,beat:int = 100,arg:int = 0):void {
			//Contraceptives cancel!
			if(hasStatusAffect("Contraceptives") >= 0 && arg < 1) return;
			var bonus:int = 0;
			//If arg = 1 (always pregnant), bonus = 9000
			if(arg >= 1) bonus = 9000;
			if(arg <= -1) bonus = -9000;
			//If unpregnant and fertility wins out:
			if((arg == 2 || (buttPregnancyIncubation == 0)) && totalFertility() + bonus > Math.floor(Math.random() * beat)) {
				buttPregnancyType = type;
				buttPregnancyIncubation = incubation;
				trace("PC Knocked up with pregnancy type: " + type + " for " + incubation + " incubation.");
			}
		}
		public function canOvipositSpider():Boolean {
			if(eggs() >= 10 && hasPerk("Spider Ovipositor") >= 0 && isDrider() && tailType == 5) return true;
			return false;
		}
		public function canOvipositBee():Boolean {
			if(eggs() >= 10 && hasPerk("Bee Ovipositor") >= 0 && tailType == 6) return true;
			return false;
		}
		public function canOviposit():Boolean {
			if(canOvipositSpider() || canOvipositBee()) return true;
			return false;
		}
		public function eggs():int {
			if(hasPerk("Spider Ovipositor") < 0 && hasPerk("Bee Ovipositor") < 0) return -1;
			else if(hasPerk("Spider Ovipositor") >= 0) return perkv1("Spider Ovipositor");
			else return perkv1("Bee Ovipositor");
		}
		public function addEggs(arg:int = 0):int {
			if(hasPerk("Spider Ovipositor") < 0 && hasPerk("Bee Ovipositor") < 0) return -1;
			else {
				if(hasPerk("Spider Ovipositor") >= 0) {
					addPerkValue("Spider Ovipositor",1,arg);
					if(eggs() > 50) changePerkValue("Spider Ovipositor",1,50);
					return perkv1("Spider Ovipositor");
				}
				else {
					addPerkValue("Bee Ovipositor",1,arg);
					if(eggs() > 50) changePerkValue("Bee Ovipositor",1,50);
					return perkv1("Bee Ovipositor");
				}
			}
		}
		public function dumpEggs():void {
			if(hasPerk("Spider Ovipositor") < 0 && hasPerk("Bee Ovipositor") < 0) return;
			setEggs(0);
			//Sets fertile eggs = regular eggs (which are 0)
			fertilizeEggs();
		}
		public function setEggs(arg:int = 0):int {
			if(hasPerk("Spider Ovipositor") < 0 && hasPerk("Bee Ovipositor") < 0) return -1;
			else {
				if(hasPerk("Spider Ovipositor") >= 0) {
					changePerkValue("Spider Ovipositor",1,arg);
					if(eggs() > 50) changePerkValue("Spider Ovipositor",1,50);
					return perkv1("Spider Ovipositor");
				}
				else {
					changePerkValue("Bee Ovipositor",1,arg);
					if(eggs() > 50) changePerkValue("Bee Ovipositor",1,50);
					return perkv1("Bee Ovipositor");
				}
			}
		}
		public function fertilizedEggs():int {
			if(hasPerk("Spider Ovipositor") < 0 && hasPerk("Bee Ovipositor") < 0) return -1;
			else if(hasPerk("Spider Ovipositor") >= 0) return perkv2("Spider Ovipositor");
			else return perkv2("Bee Ovipositor");
		}
		public function fertilizeEggs():int {
			if(hasPerk("Spider Ovipositor") < 0 && hasPerk("Bee Ovipositor") < 0) return -1;
			else if(hasPerk("Spider Ovipositor") >= 0) changePerkValue("Spider Ovipositor",2,eggs());
			else changePerkValue("Bee Ovipositor",2,eggs());
			return fertilizedEggs();
		}
		//Remove perk
		public function removePerk(perkName:String):void {
			var counter:Number = perks.length;
			//Various Errors preventing action
			if(perks.length <= 0) {
				//trace("ERROR: Perk could not be removed because player has no perks.");
				return;
			}
			while(counter > 0) {
				counter--;
				if(perks[counter].perkName == perkName) {
					perks.splice(counter, 1);
					trace("Attempted to remove \"" + perkName + "\" perk.");
					counter = 0;
				}
			}			
		}
		
		//has perk?
		public function hasPerk(perkName:String):Number {
			var counter:Number = perks.length;
			if(perks.length <= 0) return -2;
			while(counter > 0) {
				counter--;
				if(perks[counter].perkName == perkName) return counter;
			}
			return -1;
		}
		//Duplicate perk
		public function perkDuplicated(perkName:String):Boolean {
			var counter:Number = perks.length;
			var timesFound:int = 0;
			if(perks.length <= 0) return false;
			while(counter > 0) {
				counter--;
				if(perks[counter].perkName == perkName) timesFound++;
			}
			return (timesFound > 1);
		}
		//remove all perks
		public function removePerks():void {
			var counter:Number = perks.length;
			while(counter > 0){
				counter--;
				perks.splice(counter, 1);
			}	
		}
		//Create a status
		public function createStatusAffect(statusName:String, value1:Number, value2:Number, value3:Number, value4:Number):void {
			var newStatusAffect = new statusAffectClass();
			statusAffects.push(newStatusAffect);
			statusAffects[statusAffects.length-1].statusAffectName = statusName;
			statusAffects[statusAffects.length-1].value1 = value1;
			statusAffects[statusAffects.length-1].value2 = value2;
			statusAffects[statusAffects.length-1].value3 = value3;
			statusAffects[statusAffects.length-1].value4 = value4;
			//trace("NEW STATUS APPLIED TO PLAYER!: " + statusName);
		}
		//Remove a status
		public function removeStatusAffect(statusName:String):void {
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if(statusAffects.length <= 0) {
				//trace("ERROR: Status Affect could not be removed because player has no statuses.");
				return;
			}
			while(counter > 0) {
				counter--;
				if(statusAffects[counter].statusAffectName == statusName) {
					statusAffects.splice(counter, 1);
					trace("Attempted to remove \"" + statusName + "\" status.");
					counter = 0;
				}
			}			
		}
		public function hasStatusAffect(statusName:String):Number {
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if(statusAffects.length <= 0) return -2;
			while(counter > 0) {
				counter--;
				if(statusAffects[counter].statusAffectName == statusName) return counter;
			}
			return -1;
		}
		public function changeStatusValue(statusName:String, statusValueNum:Number = 1, newNum:Number = 0) {
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if(statusAffects.length <= 0) {
				return;
				//trace("ERROR: Looking for status '" + statusName + "' to change value " + statusValueNum + ", and player has no status affects.");
			}
			while(counter > 0) {
				counter--;
				//Find it, change it, quit out
				if(statusAffects[counter].statusAffectName == statusName) {
					if(statusValueNum < 1 || statusValueNum > 4) {
						//trace("ERROR: ChangeStatusValue called with invalid status value number.");
						return;
					}
					if(statusValueNum == 1) statusAffects[counter].value1 = newNum;
					if(statusValueNum == 2) statusAffects[counter].value2 = newNum;
					if(statusValueNum == 3) statusAffects[counter].value3 = newNum;
					if(statusValueNum == 4) statusAffects[counter].value4 = newNum;
					return;
				}
			}
			//trace("ERROR: Looking for status '" + statusName + "' to change value " + statusValueNum + ", and player does not have the status affect.");
			return ;
		}
		public function addStatusValue(statusName:String, statusValueNum:Number = 1, newNum:Number = 0) {
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if(statusAffects.length <= 0) {
				return;
				//trace("ERROR: Looking for status '" + statusName + "' to change value " + statusValueNum + ", and player has no status affects.");
			}
			while(counter > 0) {
				counter--;
				//Find it, change it, quit out
				if(statusAffects[counter].statusAffectName == statusName) {
					if(statusValueNum < 1 || statusValueNum > 4) {
						//trace("ERROR: ChangeStatusValue called with invalid status value number.");
						return;
					}
					if(statusValueNum == 1) statusAffects[counter].value1 += newNum;
					if(statusValueNum == 2) statusAffects[counter].value2 += newNum;
					if(statusValueNum == 3) statusAffects[counter].value3 += newNum;
					if(statusValueNum == 4) statusAffects[counter].value4 += newNum;
					return;
				}
			}
			//trace("ERROR: Looking for status '" + statusName + "' to change value " + statusValueNum + ", and player does not have the status affect.");
			return ;
		}
		public function statusAffectv1(statusName:String):Number {
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if(statusAffects.length <= 0) {
				return 0;
				//trace("ERROR: Looking for status '" + statusName + "', and player has no status affects.");
			}
			while(counter > 0) {
				counter--;
				if(statusAffects[counter].statusAffectName == statusName) return statusAffects[counter].value1;
			}
			//trace("ERROR: Looking for status '" + statusName + "', but player does not have it.");
			return 0;
		}
		public function statusAffectv2(statusName:String):Number {
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if(statusAffects.length <= 0) {
				return 0;
				//trace("ERROR: Looking for status '" + statusName + "', and player has no status affects.");
			}
			while(counter > 0) {
				counter--;
				if(statusAffects[counter].statusAffectName == statusName) return statusAffects[counter].value2;
			}
			//trace("ERROR: Looking for status '" + statusName + "', but player does not have it.");
			return 0;
		}
		public function statusAffectv3(statusName:String):Number {
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if(statusAffects.length <= 0) {
				return 0;
				//trace("ERROR: Looking for status '" + statusName + "', and player has no status affects.");
			}
			while(counter > 0) {
				counter--;
				if(statusAffects[counter].statusAffectName == statusName) return statusAffects[counter].value3;
			}
			//trace("ERROR: Looking for status '" + statusName + "', but player does not have it.");
			return 0;
		}
		public function statusAffectv4(statusName:String):Number {
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if(statusAffects.length <= 0) {
				return 0;
				//trace("ERROR: Looking for status '" + statusName + "', and player has no status affects.");
			}
			while(counter > 0) {
				counter--;
				if(statusAffects[counter].statusAffectName == statusName) return statusAffects[counter].value4;
			}
			//trace("ERROR: Looking for status '" + statusName + "', but player does not have it.");
			return 0;
		}
		public function addPerkValue(statusName:String, statusValueNum:Number = 1, newNum:Number = 0) {
			var counter:Number = perks.length;
			//Various Errors preventing action
			if(perks.length <= 0) {
				return;
				//trace("ERROR: Looking for perk '" + statusName + "' to change value " + statusValueNum + ", and player has no perks.");
			}
			while(counter > 0) {
				counter--;
				//Find it, change it, quit out
				if(perks[counter].perkName == statusName) {
					if(statusValueNum < 1 || statusValueNum > 4) {
						//trace("ERROR: ChangePerkValue called with invalid perk value number.");
						return;
					}
					if(statusValueNum == 1) perks[counter].value1 += newNum;
					if(statusValueNum == 2) perks[counter].value2 += newNum;
					if(statusValueNum == 3) perks[counter].value3 += newNum;
					if(statusValueNum == 4) perks[counter].value4 += newNum;
					return;
				}
			}
			//trace("ERROR: Looking for perk '" + statusName + "' to change value " + statusValueNum + ", and player does not have the perk.");
			return ;
		}
		public function changePerkValue(statusName:String, statusValueNum:Number = 1, newNum:Number = 0) {
			var counter:Number = perks.length;
			//Various Errors preventing action
			if(perks.length <= 0) {
				return;
				//trace("ERROR: Looking for perk '" + statusName + "' to change value " + statusValueNum + ", and player has no perks.");
			}
			while(counter > 0) {
				counter--;
				//Find it, change it, quit out
				if(perks[counter].perkName == statusName) {
					if(statusValueNum < 1 || statusValueNum > 4) {
						//trace("ERROR: ChangePerkValue called with invalid perk value number.");
						return;
					}
					if(statusValueNum == 1) perks[counter].value1 = newNum;
					if(statusValueNum == 2) perks[counter].value2 = newNum;
					if(statusValueNum == 3) perks[counter].value3 = newNum;
					if(statusValueNum == 4) perks[counter].value4 = newNum;
					return;
				}
			}
			//trace("ERROR: Looking for perk '" + statusName + "' to change value " + statusValueNum + ", and player does not have the perk.");
			return ;
		}
		public function perkv1(statusName:String):Number {
			var counter:Number = perks.length;
			//Various Errors preventing action
			if(perks.length <= 0) {
				return 0;
				//trace("ERROR: Looking for perk '" + statusName + "', and player has no perks.");
			}
			while(counter > 0) {
				counter--;
				if(perks[counter].perkName == statusName) return perks[counter].value1;
			}
			//trace("ERROR: Looking for perk '" + statusName + "', but player does not have it.");
			return 0;
		}
		public function perkv2(statusName:String):Number {
			var counter:Number = perks.length;
			//Various Errors preventing action
			if(perks.length <= 0) {
				return 0;
				//trace("ERROR: Looking for perk '" + statusName + "', and player has no perks.");
			}
			while(counter > 0) {
				counter--;
				if(perks[counter].perkName == statusName) return perks[counter].value2;
			}
			//trace("ERROR: Looking for perk '" + statusName + "', but player does not have it.");
			return 0;
		}
		public function perkv3(statusName:String):Number {
			var counter:Number = perks.length;
			//Various Errors preventing action
			if(perks.length <= 0) {
				return 0;
				//trace("ERROR: Looking for perk '" + statusName + "', and player has no perks.");
			}
			while(counter > 0) {
				counter--;
				if(perks[counter].perkName == statusName) return perks[counter].value3;
			}
			//trace("ERROR: Looking for perk '" + statusName + "', but player does not have it.");
			return 0;
		}
		public function perkv4(statusName:String):Number {
			var counter:Number = perks.length;
			//Various Errors preventing action
			if(perks.length <= 0) {
				return 0;
				//trace("ERROR: Looking for perk '" + statusName + "', and player has no perks.");
			}
			while(counter > 0) {
				counter--;
				if(perks[counter].perkName == statusName) return perks[counter].value4;
			}
			//trace("ERROR: Looking for perk '" + statusName + "', but player does not have it.");
			return 0;
		}
		public function removeStatuses():void {
			var counter:Number = statusAffects.length;
			while(counter > 0){
				counter--;
				statusAffects.splice(counter, 1);
			}				
		}
		//Create a keyItem
		public function createKeyItem(keyName:String, value1:Number, value2:Number, value3:Number, value4:Number):void {
			var newKeyItem = new keyItemClass();
			//used to denote that the array has already had its new spot pushed on.
			var arrayed:Boolean = false;
			//used to store where the array goes
			var keySlot:Number = 0
			var counter:Number = 0
			//Start the array if its the first bit
			if(keyItems.length == 0) {
				//trace("New Key Item Started Array! " + keyName);
				keyItems.push(newKeyItem);
				arrayed = true;
				keySlot = 0;
			}
			//If it belongs at the end, push it on
			if(keyItems[keyItems.length-1].keyName < keyName && !arrayed) {
				//trace("New Key Item Belongs at the end!! " + keyName);
				keyItems.push(newKeyItem);
				arrayed = true;
				keySlot = keyItems.length-1;
			}
			//If it belongs in the beginning, splice it in
			if(keyItems[0].keyName > keyName && !arrayed) {
				//trace("New Key Item Belongs at the beginning! " + keyName);
				keyItems.splice(0,0,newKeyItem);
				arrayed = true;
				keySlot = 0;
			}
			//Find the spot it needs to go in and splice it in.
			if(!arrayed){
				//trace("New Key Item using alphabetizer! " + keyName);
				counter = keyItems.length;
				while(counter > 0 && !arrayed) {
					counter--;
					//If the current slot is later than new key
					if(keyItems[counter].keyName > keyName) {
						//If the earlier slot is earlier than new key && a real spot
						if(counter-1 >= 0)
						{
							//If the earlier slot is earlier slot in!
							if(keyItems[counter-1].keyName <= keyName) {
								arrayed = true;
								keyItems.splice(counter,0,newKeyItem);
								keySlot = counter;
							}
						}
						//If the item after 0 slot is later put here!
						else {
							//If the next slot is later we are go
							if(keyItems[counter].keyName <= keyName) {
								arrayed = true;
								keyItems.splice(counter,0,newKeyItem);
								keySlot = counter;
							}
						}
					}
				}
			}
			//Fallback
			if(!arrayed) {
				//trace("New Key Item Belongs at the end!! " + keyName);
				keyItems.push(newKeyItem);
				arrayed = true;
				keySlot = keyItems.length-1;
			}
			
			keyItems[keySlot].keyName = keyName;
			keyItems[keySlot].value1 = value1;
			keyItems[keySlot].value2 = value2;
			keyItems[keySlot].value3 = value3;
			keyItems[keySlot].value4 = value4;
			//trace("NEW KEYITEM FOR PLAYER in slot " + keySlot + ": " + keyItems[keySlot].keyName);
		}
		//Remove a key item
		public function removeKeyItem(itemName:String):void {
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if(keyItems.length <= 0) {
				//trace("ERROR: KeyItem could not be removed because player has no key items.");
				return;
			}
			while(counter > 0) {
				counter--;
				if(keyItems[counter].keyName == itemName) {
					keyItems.splice(counter, 1);
					trace("Attempted to remove \"" + itemName + "\" keyItem.");
					counter = 0;
				}
			}			
		}
		public function addKeyValue(statusName:String, statusValueNum:Number = 1, newNum:Number = 0) {
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if(keyItems.length <= 0) {
				return;
				//trace("ERROR: Looking for keyitem '" + statusName + "' to change value " + statusValueNum + ", and player has no key items.");
			}
			while(counter > 0) {
				counter--;
				//Find it, change it, quit out
				if(keyItems[counter].keyName == statusName) {
					if(statusValueNum < 1 || statusValueNum > 4) {
						//trace("ERROR: AddKeyValue called with invalid key value number.");
						return;
					}
					if(statusValueNum == 1) keyItems[counter].value1 += newNum;
					if(statusValueNum == 2) keyItems[counter].value2 += newNum;
					if(statusValueNum == 3) keyItems[counter].value3 += newNum;
					if(statusValueNum == 4) keyItems[counter].value4 += newNum;
					return;
				}
			}
			//trace("ERROR: Looking for keyitem '" + statusName + "' to change value " + statusValueNum + ", and player does not have the key item.");
			return ;
		}
		public function keyItemv1(statusName:String):Number {
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if(keyItems.length <= 0) {
				return 0;
				//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while(counter > 0) {
				counter--;
				if(keyItems[counter].keyName == statusName) return keyItems[counter].value1;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}
		public function keyItemv2(statusName:String):Number {
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if(keyItems.length <= 0) {
				return 0;
				//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while(counter > 0) {
				counter--;
				if(keyItems[counter].keyName == statusName) return keyItems[counter].value2;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}
		public function keyItemv3(statusName:String):Number {
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if(keyItems.length <= 0) {
				return 0;
				//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while(counter > 0) {
				counter--;
				if(keyItems[counter].keyName == statusName) return keyItems[counter].value3;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}
		public function keyItemv4(statusName:String):Number {
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if(keyItems.length <= 0) {
				return 0;
				//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while(counter > 0) {
				counter--;
				if(keyItems[counter].keyName == statusName) return keyItems[counter].value4;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}

		public function removeKeyItems():void {
			var counter:Number = keyItems.length;
			while(counter > 0){
				counter--;
				keyItems.splice(counter, 1);
			}				
		}
		public function hasKeyItem(keyName:String):Number {
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if(keyItems.length <= 0) return -2;
			while(counter > 0) {
				counter--;
				if(keyItems[counter].keyName == keyName) return counter;
			}
			return -1;
		}
		//Grow
		public function increaseCock(increase:Number, cockNum:Number):Number
		{
			if(hasPerk("Big Cock") >= 0) increase *= perks[hasPerk("Big Cock")].value1;
			if(hasPerk("Phallic Potential") >= 0) increase *= 1.5;
			if(hasPerk("Phallic Restraint") >= 0) increase *= .25;
			return cocks[cockNum].growCock(increase);
		}
		//BreastCup
		public function breastCup(rowNum:Number):String {
			if(breastRows[rowNum].breastRating < 1) return "flat, manly breast";
			else if(breastRows[rowNum].breastRating < 2) return "A-cup";
			else if(breastRows[rowNum].breastRating < 3) return "B-cup";
			else if(breastRows[rowNum].breastRating < 4) return "C-cup";
			else if(breastRows[rowNum].breastRating < 5) return "D-cup";
			else if(breastRows[rowNum].breastRating < 6) return "DD-cup";
			else if(breastRows[rowNum].breastRating < 7) return "big DD-cup";
			else if(breastRows[rowNum].breastRating < 8) return "E-cup";
			else if(breastRows[rowNum].breastRating < 9) return "big E-cup";
			else if(breastRows[rowNum].breastRating < 10) return "EE-cup";
			else if(breastRows[rowNum].breastRating < 11) return "big EE-cup";
			else if(breastRows[rowNum].breastRating < 12) return "F-cup";
			else if(breastRows[rowNum].breastRating < 13) return "big F-cup";
			else if(breastRows[rowNum].breastRating < 14) return "FF-cup";
			else if(breastRows[rowNum].breastRating < 15) return "big FF-cup";
			else if(breastRows[rowNum].breastRating < 16) return "G-cup";
			else if(breastRows[rowNum].breastRating < 17) return "big G-cup";
			else if(breastRows[rowNum].breastRating < 18) return "GG-cup";
			else if(breastRows[rowNum].breastRating < 19) return "big GG-cup";
			else if(breastRows[rowNum].breastRating < 20) return "H-cup";
			else if(breastRows[rowNum].breastRating < 21) return "big H-cup";
			else if(breastRows[rowNum].breastRating < 22) return "HH-cup";
			else if(breastRows[rowNum].breastRating < 23) return "big HH-cup";
			else if(breastRows[rowNum].breastRating < 24) return "HHH-cup";
			else if(breastRows[rowNum].breastRating < 25) return "I-cup";
			else if(breastRows[rowNum].breastRating < 26) return "big I-cup";
			else if(breastRows[rowNum].breastRating < 27) return "II-cup";
			else if(breastRows[rowNum].breastRating < 28) return "big II-cup";
			else if(breastRows[rowNum].breastRating < 29) return "J-cup";
			else if(breastRows[rowNum].breastRating < 30) return "big J-cup";
			else if(breastRows[rowNum].breastRating < 31) return "JJ-cup";
			else if(breastRows[rowNum].breastRating < 32) return "big JJ-cup";
			else if(breastRows[rowNum].breastRating < 33) return "K-cup";
			else if(breastRows[rowNum].breastRating < 34) return "big K-cup";
			else if(breastRows[rowNum].breastRating < 35) return "KK-cup";
			else if(breastRows[rowNum].breastRating < 36) return "big KK-cup";
			else if(breastRows[rowNum].breastRating < 37) return "L-cup";
			else if(breastRows[rowNum].breastRating < 38) return "big L-cup";
			else if(breastRows[rowNum].breastRating < 39) return "LL-cup";
			else if(breastRows[rowNum].breastRating < 40) return "big LL-cup";
			else if(breastRows[rowNum].breastRating < 41) return "M-cup";
			else if(breastRows[rowNum].breastRating < 42) return "big M-cup";
			else if(breastRows[rowNum].breastRating < 43) return "MM-cup";
			else if(breastRows[rowNum].breastRating < 44) return "big MM-cup";
			else if(breastRows[rowNum].breastRating < 45) return "MMM-cup";
			else if(breastRows[rowNum].breastRating < 46) return "large MMM-cup";
			else if(breastRows[rowNum].breastRating < 47) return "N-cup";
			else if(breastRows[rowNum].breastRating < 48) return "large N-cup";
			else if(breastRows[rowNum].breastRating < 49) return "NN-cup";
			else if(breastRows[rowNum].breastRating < 50) return "large NN-cup";
			else if(breastRows[rowNum].breastRating < 51) return "O-cup";
			else if(breastRows[rowNum].breastRating < 52) return "large O-cup";
			else if(breastRows[rowNum].breastRating < 53) return "OO-cup";
			else if(breastRows[rowNum].breastRating < 54) return "large OO-cup";
			else if(breastRows[rowNum].breastRating < 55) return "P-cup";
			else if(breastRows[rowNum].breastRating < 56) return "large P-cup";
			else if(breastRows[rowNum].breastRating < 57) return "PP-cup";
			else if(breastRows[rowNum].breastRating < 58) return "large PP-cup";
			else if(breastRows[rowNum].breastRating < 59) return "Q-cup";
			else if(breastRows[rowNum].breastRating < 60) return "large Q-cup";
			else if(breastRows[rowNum].breastRating < 61) return "QQ-cup";
			else if(breastRows[rowNum].breastRating < 62) return "large QQ-cup";
			else if(breastRows[rowNum].breastRating < 63) return "R-cup";
			else if(breastRows[rowNum].breastRating < 64) return "large R-cup";
			else if(breastRows[rowNum].breastRating < 65) return "RR-cup";
			else if(breastRows[rowNum].breastRating < 66) return "large RR-cup";
			else if(breastRows[rowNum].breastRating < 67) return "S-cup";
			else if(breastRows[rowNum].breastRating < 68) return "large S-cup";
			else if(breastRows[rowNum].breastRating < 69) return "SS-cup";
			else if(breastRows[rowNum].breastRating < 70) return "large SS-cup";
			else if(breastRows[rowNum].breastRating < 71) return "T-cup";
			else if(breastRows[rowNum].breastRating < 72) return "large T-cup";
			else if(breastRows[rowNum].breastRating < 73) return "TT-cup";
			else if(breastRows[rowNum].breastRating < 74) return "large TT-cup";
			else if(breastRows[rowNum].breastRating < 75) return "U-cup";
			else if(breastRows[rowNum].breastRating < 76) return "large U-cup";
			else if(breastRows[rowNum].breastRating < 77) return "UU-cup";
			else if(breastRows[rowNum].breastRating < 78) return "large UU-cup";
			else if(breastRows[rowNum].breastRating < 79) return "V-cup";
			else if(breastRows[rowNum].breastRating < 80) return "large V-cup";
			else if(breastRows[rowNum].breastRating < 81) return "VV-cup";
			else if(breastRows[rowNum].breastRating < 82) return "large VV-cup";
			else if(breastRows[rowNum].breastRating < 83) return "W-cup";
			else if(breastRows[rowNum].breastRating < 84) return "large W-cup";
			else if(breastRows[rowNum].breastRating < 85) return "WW-cup";
			else if(breastRows[rowNum].breastRating < 86) return "large WW-cup";
			else if(breastRows[rowNum].breastRating < 87) return "X-cup";
			else if(breastRows[rowNum].breastRating < 88) return "large X-cup";
			else if(breastRows[rowNum].breastRating < 89) return "XX-cup";
			else if(breastRows[rowNum].breastRating < 90) return "large XX-cup";
			else if(breastRows[rowNum].breastRating < 91) return "Y-cup";
			else if(breastRows[rowNum].breastRating < 92) return "large Y-cup";
			else if(breastRows[rowNum].breastRating < 93) return "YY-cup";
			else if(breastRows[rowNum].breastRating < 94) return "large YY-cup";
			else if(breastRows[rowNum].breastRating < 95) return "Z-cup";
			else if(breastRows[rowNum].breastRating < 96) return "large Z-cup";
			else if(breastRows[rowNum].breastRating < 97) return "ZZ-cup";
			else if(breastRows[rowNum].breastRating < 98) return "large ZZ-cup";
			else if(breastRows[rowNum].breastRating < 99) return "ZZZ-cup";
			else if(breastRows[rowNum].breastRating < 100) return "large ZZZ-cup";

			/*else if(breastRows[rowNum].breastRating < 20) return "watermelon-sized cup";
			else if(breastRows[rowNum].breastRating < 35) return "tent-sized cup";
			else if(breastRows[rowNum].breastRating < 60) return "truck-sized cup";
			else if(breastRows[rowNum].breastRating < 100) return "parachute-sized cup";*/
			else return "game-breaking cup";
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
		public function bRows():Number {
			return breastRows.length;
		}
		public function totalBreasts():Number {
			var counter:Number = breastRows.length;
			var total:Number = 0;
			while(counter > 0) {
				counter--;
				total += breastRows[counter].breasts;
			}
			return total;
		}
		public function totalNipples():Number {
			var counter:Number = breastRows.length;
			var total:Number = 0;
			while(counter > 0) {
				counter--;
				total += breastRows[counter].nipplesPerBreast * breastRows[counter].breasts;
			}
			return total;
		}
		public function biggestTitSize():Number {
			if(breastRows.length == 0) return -1;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(breastRows[index].breastRating < breastRows[counter].breastRating) index = counter;
			}
			return breastRows[index].breastRating;
		}
		public function smallestTitSize():Number {
			if(breastRows.length == 0) return -1;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(breastRows[index].breastRating > breastRows[counter].breastRating) index = counter;
			}
			return breastRows[index].breastRating;
		}
		public function smallestTitRow():Number {
			if(breastRows.length == 0) return -1;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(breastRows[index].breastRating > breastRows[counter].breastRating) index = counter;
			}
			return index;
		}
		public function biggestTitRow():Number {
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(breastRows[index].breastRating < breastRows[counter].breastRating) index = counter;
			}
			return index;
		}
		public function averageBreastSize():Number {
			var counter:Number = breastRows.length;
			var average:Number = 0;
			while(counter > 0) {
				counter--;
				average += breastRows[counter].breastRating;
			}
			if(breastRows.length == 0) return 0;
			return (average/breastRows.length);
		}
		public function averageCockThickness():Number {
			var counter:Number = cocks.length;
			var average:Number = 0;
			while(counter > 0) {
				counter--;
				average += cocks[counter].cockThickness;
			}
			if(cocks.length == 0) return 0;
			return (average/cocks.length);
		}
		public function averageNippleLength():Number {
			var counter:Number = breastRows.length;
			var average:Number = 0;
			while(counter > 0) {
				counter--;
				average += (breastRows[counter].breastRating/10 + .2);
			}
			return (average/breastRows.length);
		}
		public function averageVaginalLooseness():Number {
			var counter:Number = vaginas.length;
			var average:Number = 0;
			//If the player has no vaginas
			if(vaginas.length == 0) return 2;
			while(counter > 0) {
				counter--;
				average += vaginas[counter].vaginalLooseness;
			}
			return (average/vaginas.length);
		}
		public function averageVaginalWetness():Number {
			//If the player has no vaginas
			if(vaginas.length == 0) return 2;
			var counter:Number = vaginas.length;
			var average:Number = 0;
			while(counter > 0) {
				counter--;
				average += vaginas[counter].vaginalWetness;
			}
			return (average/vaginas.length);
		}
		public function averageCockLength():Number {
			var counter:Number = cocks.length;
			var average:Number = 0;
			while(counter > 0) {
				counter--;
				average += cocks[counter].cockLength;
			}
			if(cocks.length == 0) return 0;
			return (average/cocks.length);
		}
		public function canTitFuck():Boolean {
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(breastRows[index].breasts < breastRows[counter].breasts && breastRows[counter].breastRating > 3) index = counter;
			}
			if(breastRows[index].breasts >= 2 && breastRows[index].breastRating > 3) return true;
			return false;
		}
		public function mostBreastsPerRow():Number {
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(breastRows[index].breasts < breastRows[counter].breasts) index = counter;
			}
			return breastRows[index].breasts;
		}
		public function averageNipplesPerBreast():Number {
			var counter:Number = breastRows.length;
			var breasts:Number = 0;
			var nipples:Number = 0;
			while(counter > 0) {
				counter--;
				breasts += breastRows[counter].breasts;
				nipples += breastRows[counter].nipplesPerBreast * breastRows[counter].breasts;
			}
			if(breasts == 0) return 0;
			return Math.floor(nipples/breasts);
		}
		public function viridianChange():Boolean {
			var count:int = cockTotal();
			if(count == 0) return false;
			while(count > 0) {
				count--;
				if(cocks[count].sock == "amaranthine" && cocks[count].cockType != 10) 
					return true;
			}
			return false;
		}
		public function hasSheath():Boolean {
			if(dogCocks() > 0 || horseCocks() > 0 || catCocks() > 0 || kangaCocks() > 0 || displacerCocks() > 0) return true;
			return false;
		}
		public function hasKnot(arg:int = 0):Boolean {
			if(arg > cockTotal() - 1 || arg < 0) return false;
			return (cocks[arg].cockType == 2 || cocks[arg].cockType == 10);
		}
		public function cockArea(cockNum:Number):Number {
			if(cockNum >= cocks.length || cockNum < 0) return 0;
			return (cocks[cockNum].cockThickness * cocks[cockNum].cockLength);
		}
		public function biggestCockLength():Number {
			if(cocks.length == 0) return 0;
			return cocks[biggestCockIndex()].cockLength;
		}
		public function biggestCockArea():Number {
			if(cocks.length == 0) return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(cockArea(index) < cockArea(counter)) index = counter;
			}
			return cockArea(index);
		}
		//Find the second biggest dick and it's area.
		public function biggestCockArea2():Number {
			if(cocks.length <= 1) return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = -1;
			//Find the biggest
			while(counter > 0) {
				counter--;
				if(cockArea(index) < cockArea(counter)) index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while(counter > 0) {
				counter--;
				//Is this spot claimed by the biggest?
				if(counter != index) {
					//Not set yet?
					if(index2 == -1) index2 = counter;
					//Is the stored value less than the current one?
					if(cockArea(index2) < cockArea(counter)) {
						index2 = counter;
					}
				}
			}
			//If it couldn't find a second biggest...
			if(index == index2) return 0;
			return cockArea(index2);
		}
		public function longestCock():Number {
			if(cocks.length == 0) return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(cocks[index].cockLength < cocks[counter].cockLength) index = counter;
			}
			return index;
		}
		public function longestCockLength():Number {
			if(cocks.length == 0) return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(cocks[index].cockLength < cocks[counter].cockLength) index = counter;
			}
			return cocks[index].cockLength;
		}
		public function longestHorseCockLength():Number {
			if(cocks.length == 0) return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if((cocks[index].cockType != 1 && cocks[counter].cockType == 1) || (cocks[index].cockLength < cocks[counter].cockLength && cocks[counter].cockType == 1)) index = counter;
			}
			return cocks[index].cockLength;
		}
		public function twoDickRadarSpecial(width:int):Boolean {
			//No two dicks?  FUCK OFF
			if(cockTotal() < 2) return false;
			
			//Set up vars
			//Get thinnest, work done already
			var thinnest:int = thinnestCockIndex();
			var thinnest2:int = 0;
			//For ze loop
			var temp:int = 0;
			//Make sure they arent the same at initialization
			if(thinnest2 == thinnest) 
				thinnest2 = 1;
			//Loop through to find 2nd thinnest
			while(temp < cocks.length) {
				if(cocks[thinnest2].cockThickness > cocks[temp].cockThickness && temp != thinnest) thinnest2 = temp;
				temp++;
			}
			//If the two thicknesses added together are less than the arg, true, else false
			if(cocks[thinnest].cockThickness + cocks[thinnest2].cockThickness < width)
				return true;
			else
				return false;
		}
		public function totalCockThickness():Number {
			var thick:Number = 0;
			var counter:Number = cocks.length;
			while(counter > 0) {
				counter--;
				thick += cocks[counter].cockThickness;
			}
			return thick;
		}
		public function thickestCock():Number {
			if(cocks.length == 0) return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(cocks[index].cockThickness < cocks[counter].cockThickness) index = counter;
			}
			return index;
		}
		public function thickestCockThickness():Number {
			if(cocks.length == 0) return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(cocks[index].cockThickness < cocks[counter].cockThickness) index = counter;
			}
			return cocks[index].cockThickness;
		}
		public function thinnestCockIndex():Number {
			if(cocks.length == 0) return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(cocks[index].cockThickness > cocks[counter].cockThickness) index = counter;
			}
			return index;
		}
		public function smallestCockIndex():Number {
			if(cocks.length == 0) return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(cockArea(index) > cockArea(counter)) {
					index = counter;
				}
			}
			return index;
		}
		public function smallestCockLength():Number {
			if(cocks.length == 0) return 0;
			return cocks[smallestCockIndex()].cockLength;
		}
		public function shortestCockIndex():Number {
			if(cocks.length == 0) return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(cocks[index].cockLength > cocks[counter].cockLength) index = counter;
			}
			return index;
		}
		public function shortestCockLength():Number {
			if(cocks.length == 0) return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(cocks[index].cockLength > cocks[counter].cockLength) index = counter;
			}
			return cocks[index].cockLength;
		}
		//Find the biggest cock that fits inside a given value
		public function cockThatFits(fits:Number = 0, type:String = "area"):Number {
			if(cocks.length <= 0) return -1;
			var counter:Number = cocks.length;
			//Current largest fitter
			var index:Number = -1;
			while(counter > 0) {
				counter--;
				if(type == "area") {
					if(cockArea(counter) <= fits) {
						//If one already fits
						if(index >= 0) {
							//See if the newcomer beats the saved small guy
							if(cockArea(counter) > cockArea(index))
								index = counter;							
						}
						//Store the index of fitting dick
						else index = counter;
					}
				}
				else if(type == "length") {
					if(cocks[counter].cockLength <= fits) {
						//If one already fits
						if(index >= 0) {
							//See if the newcomer beats the saved small guy
							if(cocks[counter].cockLength > cocks[index].cockLength)
								index = counter;							
						}
						//Store the index of fitting dick
						else index = counter;
					}
				}
			}
			return index;
		}
		//Find the 2nd biggest cock that fits inside a given value
		public function cockThatFits2(fits:Number = 0):Number {
			if(cockTotal() == 1) return -1;
			var counter:Number = cocks.length;
			//Current largest fitter
			var index:Number = -1;
			var index2:Number = -1;
			while(counter > 0) {
				counter--;
				//Does this one fit?
				if(cockArea(counter) <= fits) {
					//If one already fits
					if(index >= 0) {
						//See if the newcomer beats the saved small guy
						if(cockArea(counter) > cockArea(index)) {
							//Save old wang
							if(index != -1) index2 = index;
							index = counter;
						}
						//If this one fits and is smaller than the other great
						else {
							if((cockArea(index2) < cockArea(counter)) && counter != index) {
								index2 = counter;
							}
						}
						if(index >= 0 && index == index2) trace("FUCK ERROR COCKTHATFITS2 SHIT IS BROKED!");
					}
					//Store the index of fitting dick
					else index = counter;
				}
			}
			return index2;
		}
		public function smallestCockArea():Number {
			if(cockTotal() == 0) return -1;
			return cockArea(smallestCockIndex());
		}
		public function smallestCock():Number {
			return cockArea(smallestCockIndex());
		}
		public function biggestCockIndex():Number {
			if(cocks.length == 0) return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(cockArea(index) < cockArea(counter)) index = counter;
			}
			return index;
		}
		//Find the second biggest dick's index.
		public function biggestCockIndex2():Number {
			if(cocks.length <= 1) return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = 0;
			//Find the biggest
			while(counter > 0) {
				counter--;
				if(cockArea(index) < cockArea(counter)) index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while(counter > 0) {
				counter--;
				//Make sure index2 doesn't get stuck
				//at the same value as index1 if the
				//initial location is biggest.
				if(index == index2 && counter != index) index2 = counter;
				//Is the stored value less than the current one?
				if(cockArea(index2) < cockArea(counter)) {
					//Make sure we don't set index2 to be the same
					//as the biggest dick.
					if(counter != index) index2 = counter;
				}
			}
			//If it couldn't find a second biggest...
			if(index == index2) return 0;
			return index2;
		}
		public function smallestCockIndex2():Number {
			if(cocks.length <= 1) return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = 0;
			//Find the smallest
			while(counter > 0) {
				counter--;
				if(cockArea(index) > cockArea(counter)) index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while(counter > 0) {
				counter--;
				//Make sure index2 doesn't get stuck
				//at the same value as index1 if the
				//initial location is biggest.
				if(index == index2 && counter != index) index2 = counter;
				//Is the stored value less than the current one?
				if(cockArea(index2) > cockArea(counter)) {
					//Make sure we don't set index2 to be the same
					//as the biggest dick.
					if(counter != index) index2 = counter;
				}
			}
			//If it couldn't find a second biggest...
			if(index == index2) return 0;
			return index2;
		}
		//Find the third biggest dick index.
		public function biggestCockIndex3():Number {
			if(cocks.length <= 2) return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = -1;
			var index3:Number = -1;
			//Find the biggest
			while(counter > 0) {
				counter--;
				if(cockArea(index) < cockArea(counter)) index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while(counter > 0) {
				counter--;
				//If this index isn't used already
				if(counter != index) {
					//Has index been set to anything yet?
					if(index2 == -1) index2 = counter;
					//Is the stored value less than the current one?
					else if(cockArea(index2) < cockArea(counter)) {
						index2 = counter;
					}
				}
			}
			//If it couldn't find a second biggest...
			if(index == index2 || index2 == -1) index2 = 0;
			//Reset counter and find the next biggest
			counter = cocks.length;
			while(counter > 0) {
				counter--;
				//If this index isn't used already
				if(counter != index && counter != index2) {
					//Has index been set to anything yet?
					if(index3 == -1) index3 = counter;
					//Is the stored value less than the current one?
					else if(cockArea(index3) < cockArea(counter)) {
						index3 = counter;
					}
				}
			}
			//If it fails for some reason.
			if(index3 == -1) index3 = 0;
			return index3;
		}
		private function rand(max:Number):Number
		{
			return int(Math.random()*max);
		}
		public function cockDescript(cockNum:Number):String {
			if(totalCocks() == 0) return "<b>ERROR: CockDescript Called But No Cock Present</b>";
			if(cockTotal() <= cockNum && cockNum != 99) return "<b>ERROR: CockDescript called with index of " + cockNum + " - out of BOUNDS</b>";
			//Cocknum 99 to default to boring descriptions!
			if(cockNum != 99) {
				if(rand(2) == 0) descript += cockAdjective(cockNum) + ", ";
				descript += cockNoun(cocks[cockNum].cockType);
			}
			else cockNum = 0;
			var descript:String = "";
			//50% of the time add a descriptor
			if(rand(2) == 0) descript += cockAdjective(cockNum) + " ";
			var rando:Number = 0;
			rando=int(Math.random()*10)
			if(rando >= 0 && rando <=4) descript += "cock";
			if(rando ==5 || rando == 6) descript += "prick";
			if(rando == 7) descript += "pecker";
			if(rando > 7) descript += "shaft";
			
			return descript;
		}
		//Used in multiCockDescript and potentiall elsewhere - barebones cock names
		function cockNoun(type:Number):String {
			var descript:String = "";
			var rando:Number = 0;
			if(type == 0) {
				rando = rand(10) + 1;
				if(rando >= 0 && rando <=4) descript += "cock";
				if(rando ==5 || rando == 6) descript += "prick";
				if(rando == 7) descript += "pecker";
				if(rando > 7) descript += "shaft";
			}
			if(type == 2) {
				if(dogScore() >= foxScore()) {
					rando=int(Math.random()*11);
					if(rando == 0) descript+="dog-shaped dong";
					if(rando == 1) descript+="canine shaft";
					if(rando == 2) descript+="pointed prick";
					if(rando == 3) descript+="knotty dog-shaft";
					if(rando == 4) descript+="bestial cock";
					if(rando == 5) descript+="animalistic puppy-pecker";
					if(rando == 6) descript+="pointed dog-dick";
					if(rando == 7) descript+="pointed shaft";
					if(rando == 8) descript+="canine member";
					if(rando == 9) descript+="canine cock";
					if(rando == 10) descript+="knotted dog-cock";
				}
				else {
					rando=int(Math.random()*11);
					if(rando == 0) descript+="fox-shaped dong";
					if(rando == 1) descript+="vulpine shaft";
					if(rando == 2) descript+="pointed prick";
					if(rando == 3) descript+="knotty fox-shaft";
					if(rando == 4) descript+="bestial cock";
					if(rando == 5) descript+="animalistic vixen-pricker";
					if(rando == 6) descript+="pointed fox-dick";
					if(rando == 7) descript+="pointed shaft";
					if(rando == 8) descript+="vulpine member";
					if(rando == 9) descript+="vulpine cock";
					if(rando == 10) descript+="knotted fox-cock";
				}
			}
			if(type == 1) {
				rando = rand(6);
				if(rando == 0) descript+="flared horse-cock";
				if(rando == 1) descript+="equine prick";
				if(rando == 2) descript+="bestial horse-shaft";
				if(rando == 3) descript+="flat-tipped horse-member";
				if(rando == 4) descript+="animalistic stallion-prick";
				if(rando == 5) descript+="equine dong";
				if(rando == 6) descript+="beast cock";
				if(rando == 7) descript+="flared stallion-cock";
			}
			if(type == 3) {
				rando=int(Math.random()*11);
				if(rando == 0) descript+="nub-covered demon-dick";
				if(rando == 1) descript+="nubby shaft";
				if(rando == 2) descript+="corrupted cock";
				if(rando == 3) descript+="perverse pecker";
				if(rando == 4) descript+="bumpy demon-dick";
				if(rando == 5) descript+="demonic cock";
				if(rando == 6) descript+="demonic dong";
				if(rando == 7) descript+="cursed cock";
				if(rando == 8) descript+="infernal prick";
				if(rando == 9) descript+="unholy cock";
				if(rando == 10) descript+="blighted cock";
			}
			if(type == 4) {
				rando=int(Math.random()*11);
				if(rando == 0) descript+="twisting tentacle-prick";
				if(rando == 1) descript+="wriggling plant-shaft";
				if(rando == 2) descript+="sinuous tentacle-cock";
				if(rando == 3) descript+="squirming cock-tendril";
				if(rando == 4) descript+="writhing tentacle-pecker";
				if(rando == 5) descript+="wriggling plant-prick";
				if(rando == 6) descript+="penile flora";
				if(rando == 7) descript+="smooth shaft";
				if(rando == 8) descript+="undulating tentacle-dick";
				if(rando == 9) descript+="slithering vine-prick";
				if(rando == 10) descript+="vine-shaped cock";
			}
			if(type == 5) {
				rando=int(Math.random()*11);
				if(rando == 0) descript+="feline dick";
				if(rando == 1) descript+="spined cat-cock";
				if(rando == 2) descript+="pink kitty-cock";
				if(rando == 3) descript+="spiny prick";
				if(rando == 4) descript+="animalistic kitty-prick";
				if(rando == 5) descript+="oddly-textured cat-penis";
				if(rando == 6) descript+="feline member";
				if(rando == 7) descript+="spined shaft";
				if(rando == 8) descript+="feline shaft";
				if(rando == 9) descript+="barbed dick";
				if(rando == 10) descript+="nubby kitten-prick";
			}
			if(type == 6) {
				rando=int(Math.random()*11);
				if(rando == 0) descript+="reptilian dick";
				if(rando == 1) descript+="purple cock";
				if(rando == 2) descript+="inhuman cock";
				if(rando == 3) descript+="reptilian prick";
				if(rando == 4) descript+="purple prick";
				if(rando == 5) descript+="purple member";
				if(rando == 6) descript+="serpentine member";
				if(rando == 7) descript+="serpentine shaft";
				if(rando == 8) descript+="reptilian shaft";
				if(rando == 9) descript+="bulbous snake-shaft";
				if(rando == 10) descript+="bulging snake-dick";
			}
			if(type == 7) {
				rando = rand(11);
				if(rando == 0) descript+="anemone dick";
				if(rando == 1) descript+="tentacle-ringed cock";
				if(rando == 2) descript+="blue member";
				if(rando == 3) descript+="stinger-laden shaft";
				if(rando == 4) descript+="pulsating prick";
				if(rando == 5) descript+="anemone prick";
				if(rando == 6) descript+="stinger-coated member";
				if(rando == 7) descript+="blue cock";
				if(rando == 8) descript+="tentacle-ringed dick";
				if(rando == 9) descript+="near-transparent shaft";
				if(rando == 10) descript+="squirming shaft";
			}
			if(type == 8) {
				rando = rand(11);
				if(rando == 0) descript+="kangaroo-like dick";
				if(rando == 1) descript+="pointed cock";
				if(rando == 2) descript+="marsupial member";
				if(rando == 3) descript+="tapered shaft";
				if(rando == 4) descript+="curved pecker";
				if(rando == 5) descript+="pointed prick";
				if(rando == 6) descript+="squirming kangaroo-cock";
				if(rando == 7) descript+="marsupial cock";
				if(rando == 8) descript+="tapered kangaroo-dick";
				if(rando == 9) descript+="curved kangaroo-cock";
				if(rando == 10) descript+="squirming shaft";
			}
			if(type == 9) {
				rando = rand(11);
				if(rando == 0) descript+="dragon-like dick";
				if(rando == 1) descript+="segmented shaft";
				if(rando == 2) descript+="pointed prick";
				if(rando == 3) descript+="knotted dragon-cock";
				if(rando == 4) descript+="mythical mast";
				if(rando == 5) descript+="segmented tool";
				if(rando == 6) descript+="draconic dick";
				if(rando == 7) descript+="draconic cock";
				if(rando == 8) descript+="tapered dick";
				if(rando == 9) descript+="unusual endowment";
				if(rando == 10) descript+="scaly shaft";
			}
			return descript;
		}

		//New cock adjectives.  The old one sucked dicks
		public function cockAdjective(cockNum:Number = -1) {
			var descript:String = "";
			var rando:Number = 0;
			var multi:Boolean = false;
			//If used for multiple cocks, set multi flag
			if(cockNum < 0) {
				//Since we have multi dicks lets talk about the biggest!
				cockNum = biggestCockIndex();
				multi = true;
			}
			//Pierced - 1/5 chance
			if(!multi && rand(5) == 0 && cocks[cockNum].pierced > 0) {
				descript += "pierced";
			}
			//Goo - 1/4 chance
			else if(skinType == 3 && rand(4) == 0) {
				rando = rand(3);
				if(rando == 0) descript += "goopey";
				else if(rando == 1) descript += "gooey";
				else descript += "slimy";
			}
			//Length 1/3 chance
			else if(rand(3) == 0) {
				if(cocks[cockNum].cockLength < 3) {
					rando = rand(4);
					if(rando == 0) descript = "little";
					else if(rando == 1) descript = "toy-sized";
					else if(rando == 2) descript = "mini";
					else if(rando == 3) descript = "budding";
					else descript = "tiny";
				}
				else if(cocks[cockNum].cockLength < 5) {
					rando = rand(2);
					if(rando == 0) descript = "short";
					else descript = "small";
				}
				else if(cocks[cockNum].cockLength < 7) {
					rando = rand(2);
					if(rando == 0) descript = "fair-sized";
					else descript = "nice";
				}
				else if(cocks[cockNum].cockLength < 9) {
					rando = rand(3);
					if(rando == 0) {
						if(cocks[cockNum].cockType == 1) descript = "pony-sized";
						else descript = "long";
					}
					else if(rando == 1) {
						if(cocks[cockNum].cockType == 1) descript = "colt-like";
						else descript = "lengthy";
					}
					else descript = "sizable";
				}
				else if(cocks[cockNum].cockLength < 13) {
					rando = rand(3);
					if(rando == 0) descript = "huge";
					else if(rando == 1) {
						if(cocks[cockNum].cockType == 2) descript = "mastiff-like";
						else descript = "cucumber-length";
					}
					else descript = "foot-long";
				}
				else if(cocks[cockNum].cockLength < 18) {
					rando = rand(3);
					if(rando == 0) descript = "massive";
					else if(rando == 1) descript = "knee-length";
					else descript = "forearm-length";
				}
				else if(cocks[cockNum].cockLength < 30) {
					rando = rand(3);
					if(rando == 0) descript = "enormous";
					else if(rando == 1) descript = "giant";
					else descript = "arm-like";
				}
				else {
					rando = rand(4);
					if(cocks[cockNum].cockType == 4 && rand(4) == 0) descript = "coiled ";
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
					if(cumQ() < 50){
						if(rand(2) == 0) descript += "throbbing";
						else descript += "pulsating";
					}
					//lots of cum? drippy.
					else if(cumQ() < 200) {
						rando = rand(3);
						if(rando == 0) descript += "dribbling";
						else if(rando == 1) descript += "drooling";
						else descript += "leaking";
					}
					//Tons of cum
					else {
						rando = rand(5);
						if(rando == 0) descript += "very drippy";
						else if(rando == 1) descript += "pre-gushing";
						else if(rando == 2) descript += "cum-bubbling";
						else if(rando == 3) descript += "pre-slicked";
						else descript += "pre-drooling";
					}
				}
				//A little less lusty, but still lusty.
				else if(lust > 75) {
					if(cumQ() < 50) {
						rando = rand(5);
						if(rando == 0) descript += "turgid";
						else if(rando == 1) descript += "blood-engorged";
						else if(rando == 2) descript += "rock-hard";
						else if(rando == 3) descript += "stiff";
						else descript += "eager";
					}
					//A little drippy
					else if(cumQ() < 200) {
						rando = rand(10);
						if(rando == 0) descript += "turgid";
						else if(rando == 1) descript += "blood-engorged";
						else if(rando == 2) descript += "rock-hard";
						else if(rando == 3) descript += "stiff";
		
						else if(rando == 4) descript += "eager";
						else if(rando < 7) descript += "fluid-beading";
						else descript += "slowly-oozing";
					}
					//uber drippy
					else {
						rando = rand(4);
						if(rando == 0) descript += "dribbling";
						else if(rando == 1) descript += "drooling";
						else if(rando == 2) descript += "fluid-leaking";
						else descript += "leaking";
					}
				}
			}
			//Girth - fallback
			else {
				if(cocks[cockNum].cockThickness <= .75) {
					rando = rand(3);
					if(rando == 0) descript += "thin";
					else if(rando == 1) descript += "slender";
					else descript += "narrow";
				}
				else if(cocks[cockNum].cockThickness <= 1.2) {
					descript += "ample";
				}
				else if(cocks[cockNum].cockThickness <= 1.4) {
					rando = rand(2);
					if(rando == 0) descript += "ample";
					else descript += "big";
				}
				else if(cocks[cockNum].cockThickness <= 2) {
					rando = rand(3);
					if(rando == 0) descript += "broad";
					else if(rando == 1) descript += "girthy";
					else descript += "meaty";
				}
				else if(cocks[cockNum].cockThickness <= 3.5) {
					rando = rand(3);
					if(rando == 0) descript += "fat";
					else if(rando == 1) descript += "wide";
					else descript += "distended";
				}
				else if(cocks[cockNum].cockThickness > 3.5) {
					rando = rand(3);
					if(rando == 0) descript += "inhumanly distended";
					else if(rando == 1) descript += "bloated";
					else descript += "monstrously thick";
				}
			}
			return descript;
		}

		public function wetness():Number {
			if(vaginas.length == 0) return 0;
			else return vaginas[0].vaginalWetness;
		}
		public function vaginaType(newType:int = -1):int {
			if(!hasVagina()) return -1;
			if(newType != -1) {
				vaginas[0].type = newType;
			}
			return vaginas[0].type;
		}
		public function looseness(vag:Boolean = true):Number {
			if(vag) {
				if(vaginas.length == 0) return 0;
				else return vaginas[0].vaginalLooseness;
			}
			else {
				return ass.analLooseness;
			}
		}
		public function vaginalCapacity():Number {
			//If the player has no vaginas
			if(vaginas.length == 0) return 0;
			var total:Number = 0;
			var bonus:Number = 0;
			//Centaurs = +50 capacity
			if(lowerBody == 4) bonus = 50;
			//Naga = +20 capacity
			else if(lowerBody == 3) bonus = 20;
			//Wet pussy provides 20 point boost
			if(hasPerk("Wet Pussy") >= 0) bonus += 20;
			if(hasPerk("History: Slut") >= 0) bonus += 20;
			if(hasPerk("One Track Mind") >= 0) bonus += 10;
			if(hasPerk("Cornucopia") >= 0) bonus += 30;
			total = (bonus + statusAffectv1("Bonus vCapacity") + 8*vaginas[0].vaginalLooseness*vaginas[0].vaginalLooseness) * (1 + vaginas[0].vaginalWetness/10);
			return total;
		}
		public function analCapacity():Number {
			var total:Number = 0;
			var bonus:Number = 0;
			//Centaurs = +30 capacity
			if(lowerBody == 4) bonus = 30;
			if(hasPerk("History: Slut") >= 0) bonus += 20;
			if(hasPerk("Cornucopia") >= 0) bonus += 30;
			if(hasPerk("One Track Mind") >= 0) bonus += 10;
			if(ass.analWetness > 0) bonus += 15;
			return ((bonus + statusAffectv1("Bonus aCapacity") + 6*ass.analLooseness*ass.analLooseness) * (1 + ass.analWetness/10));			
		}
		public function hasFuckableNipples():Boolean {
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(breastRows[counter].fuckable) index = counter;
			}
			if(breastRows[index].fuckable) return true;
			return false;
		}
		public function hasBreasts():Boolean {
			if(breastRows.length > 0) {
				if(biggestTitSize() >= 1) return true;
			}
			return false;
		}
		public function hasNipples():Boolean {
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(breastRows[counter].nipplesPerBreast > 0) index = counter;
			}
			if(breastRows[index].nipplesPerBreast > 0) return true;
			return false;
		}
		public function lactationSpeed():Number {
			//Lactation * breastSize x 10 (milkPerBreast) determines scene
			return biggestLactation() * biggestTitSize() * 10;
		}
		public function lactationQ():Number {
			if(biggestLactation() < 1) return 0;
			//(Milk production TOTAL= breastSize x 10 * lactationMultiplier * breast total * milking-endurance (1- default, maxes at 2.  Builds over time as milking as done)
			//(Small – 0.01 mLs – Size 1 + 1 Multi)
			//(Large – 0.8 - Size 10 + 4 Multi)
			//(HUGE – 2.4 - Size 12 + 5 Multi + 4 tits)
			var total:Number = 0;
			if(hasStatusAffect("Lactation Endurance") < 0) createStatusAffect("Lactation Endurance",1,0,0,0);
			total = biggestTitSize() * 10 * averageLactation() * statusAffectv1("Lactation Endurance") * totalBreasts();
			if(statusAffectv1("Lactation Reduction") >= 48) total = total * 1.5;
			return total;
		}
		public function biggestLactation():Number {
			if(breastRows.length == 0) return 0;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				if(breastRows[index].lactationMultiplier < breastRows[counter].lactationMultiplier) index = counter;
			}
			return breastRows[index].lactationMultiplier;
		}
		public function boostLactation(todo:Number):Number {
			if(breastRows.length == 0) return 0;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			var changes:Number = 0;
			var temp2:Number = 0;
			//Prevent lactation decrease if lactating.
			if(todo >= 0) {
				if(hasStatusAffect("Lactation Reduction") >= 0) changeStatusValue("Lactation Reduction",1,0);
				if(hasStatusAffect("Lactation Reduc0") >= 0) removeStatusAffect("Lactation Reduc0");
				if(hasStatusAffect("Lactation Reduc1") >= 0) removeStatusAffect("Lactation Reduc1");
				if(hasStatusAffect("Lactation Reduc2") >= 0) removeStatusAffect("Lactation Reduc2");
				if(hasStatusAffect("Lactation Reduc3") >= 0) removeStatusAffect("Lactation Reduc3");
			}
			if(todo > 0) {
				while(todo > 0) {
					counter = breastRows.length;
					todo-= .1;
					while(counter > 0) {
						counter--;
						if(breastRows[index].lactationMultiplier > breastRows[counter].lactationMultiplier) index = counter;
					}
					temp2 = .1;
					if(breastRows[index].lactationMultiplier > 1.5) temp2 /= 2;
					if(breastRows[index].lactationMultiplier > 2.5) temp2 /= 2;
					if(breastRows[index].lactationMultiplier > 3) temp2 /= 2;
					changes += temp2;
					breastRows[index].lactationMultiplier += temp2;
				}
			}
			else {
				while(todo < 0) {
					counter = breastRows.length;
					index = 0;
					if(todo > -.1) {
						while(counter > 0) {
							counter--;
							if(breastRows[index].lactationMultiplier < breastRows[counter].lactationMultiplier) index = counter;
						}
						trace(biggestLactation());
						breastRows[index].lactationMultiplier += todo;
						if(breastRows[index].lactationMultiplier < 0) breastRows[index].lactationMultiplier = 0;
						todo = 0;
					}
					else {
						todo+= .1;
						while(counter > 0) {
							counter--;
							if(breastRows[index].lactationMultiplier < breastRows[counter].lactationMultiplier) index = counter;
						}
						temp2 = todo;
						changes += temp2;
						breastRows[index].lactationMultiplier += temp2;
						if(breastRows[index].lactationMultiplier < 0) breastRows[index].lactationMultiplier = 0;
					}
				}
			}
			return changes;	
		}
		public function averageLactation():Number {
			if(breastRows.length == 0) return 0;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while(counter > 0) {
				counter--;
				index += breastRows[counter].lactationMultiplier;
			}
			return Math.floor(index/breastRows.length);
		}
		//Body Type
		public function bodyType():String {
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
			if(thickness < 10) {
				//SUPAH BUFF
				if(tone > 90) desc += "a lithe body covered in highly visible muscles";
				else if(tone > 75) desc += "an incredibly thin, well-muscled frame";
				else if(tone > 50) desc += "a very thin body that has a good bit of muscle definition";
				else if(tone > 25) desc += "a lithe body and only a little bit of muscle definition";
				else desc += "a waif-thin body, and soft, forgiving flesh";
			}
			//Pretty thin
			else if(thickness < 25) {
				if(tone > 90) desc += "a thin body and incredible muscle definition";
				else if(tone > 75) desc += "a narrow frame that shows off your muscles";
				else if(tone > 50) desc += "a somewhat lithe body and a fair amount of definition";
				else if(tone > 25) desc += "a narrow, soft body that still manages to show off a few muscles";
				else desc += "a thin, soft body";
			}
			//Somewhat thin
			else if(thickness < 40) {
				if(tone > 90) desc += "a fit, somewhat thin body and rippling muscles all over";
				else if(tone > 75) desc += "a thinner-than-average frame and great muscle definition";
				else if(tone > 50) desc += "a somewhat narrow body and a decent amount of visible muscle";
				else if(tone > 25) desc += "a moderately thin body, soft curves, and only a little bit of muscle";
				else desc += "a fairly thin form and soft, cuddle-able flesh";
			}
			//average
			else if(thickness < 60) {
				if(tone > 90) desc += "average thickness and a bevy of perfectly defined muscles";
				else if(tone > 75) desc += "an average-sized frame and great musculature";
				else if(tone > 50) desc += "a normal waistline and decently visible muscles";
				else if(tone > 25) desc += "an average body and soft, unremarkable flesh";
				else desc += "an average frame and soft, untoned flesh with a tendency for jiggle";
			}
			else if(thickness < 75) {
				if(tone > 90) desc += "a somewhat thick body that's covered in slabs of muscle";
				else if(tone > 75) desc += "a body that's a little bit wide and has some highly-visible muscles";
				else if(tone > 50) desc += "a solid build that displays a decent amount of muscle";
				else if(tone > 25) desc += "a slightly wide frame that displays your curves and has hints of muscle underneath";
				else desc += "a soft, plush body with plenty of jiggle";
			}
			else if(thickness < 90) {
				if(tone > 90) desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if(tone > 75) desc += "a burly form and plenty of muscle definition";
				else if(tone > 50) desc += "a solid, thick frame and a decent amount of muscles";
				else if(tone > 25) desc += "a wide-set body, some soft, forgiving flesh, and a hint of muscle underneath it";
				else {
					desc += "a wide, cushiony body";
					if(gender >= 2 || biggestTitSize() > 3 || hipRating > 7 || buttRating > 7) desc += " and plenty of jiggle on your curves";
				}
			}
			//Chunky monkey
			else {
				if(tone > 90) desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if(tone > 75) desc += "a very wide body and enough muscle to make you look like a tank";
				else if(tone > 50) desc += "an extremely substantial frame packing a decent amount of muscle";
				else if(tone > 25) {
					desc += "a very wide body";
					if(gender >= 2 || biggestTitSize() > 4 || hipRating > 10 || buttRating > 10) desc += ", lots of curvy jiggles,";
					desc += " and hints of muscle underneath";
				}
				else {
					desc += "a thick";
					if(gender >= 2 || biggestTitSize() > 4 || hipRating > 10 || buttRating > 10) desc += ", voluptuous";
					desc += " body and plush, ";
					if(gender >= 2 || biggestTitSize() > 4 || hipRating > 10 || buttRating > 10) desc += " jiggly curves";
					else desc += " soft flesh";   
				}
			}
			return desc;
		}
		//determine demon rating
		public function demonScore():Number {
			var demonCounter:Number = 0;
			if(hornType == 1 && horns > 0) demonCounter++;
			if(hornType == 1 && horns > 4) demonCounter++;
			if(tailType == 3) demonCounter++;
			if(wingType == 6 || wingType == 7) demonCounter++;
			if(skinType == 0 && cor > 50) demonCounter++;
			if(faceType == 0 && cor > 50) demonCounter++;
			if(lowerBody == 5 || lowerBody == 6) demonCounter++;
			if(demonCocks() > 0) demonCounter++
			return demonCounter;
		}
		//Determine Human Rating
		public function humanScore():Number {
			var humanCounter:Number = 0;
			if(faceType == 0) humanCounter++;
			if(skinType == 0) humanCounter++;
			if(horns == 0) humanCounter++;
			if(tailType == 0) humanCounter++;
			if(wingType == 0) humanCounter++;
			if(lowerBody == 0) humanCounter++;
			if(normalCocks() == 1 && totalCocks() == 1) humanCounter++;
			if(breastRows.length == 1 && skinType == 0) humanCounter++;
			return humanCounter;
		}
		//Determine minotaur rating
		public function minoScore():Number {
			var minoCounter:Number = 0;
			if(faceType == 3) minoCounter++;
			if(earType == 3) minoCounter++;
			if(tailType == 4) minoCounter++;
			if(hornType == 2) minoCounter++;
			if(lowerBody == 1 && minoCounter > 0) minoCounter++;
			if(tallness > 80 && minoCounter > 0) minoCounter++; 
			if(cocks.length > 0 && minoCounter > 0) {
				if(horseCocks() > 0) minoCounter++;
			}
			if(vaginas.length > 0) minoCounter--;
			return minoCounter;			
		}
		//Determine cow rating
		public function cowScore():Number {
			var minoCounter:Number = 0;
			if(faceType == 0) minoCounter++;
			if(faceType == 3) minoCounter--;
			if(earType == 3) minoCounter++;
			if(tailType == 4) minoCounter++;
			if(hornType == 2) minoCounter++;
			if(lowerBody == 1 && minoCounter > 0) minoCounter++;
			if(tallness >= 73 && minoCounter > 0) minoCounter++; 
			if(vaginas.length > 0) minoCounter++;
			if(biggestTitSize() > 4 && minoCounter > 0) minoCounter++;
			if(biggestLactation() > 2 && minoCounter > 0) minoCounter++;
			return minoCounter;			
		}
		public function sandTrapScore():int {
			var counter:int = 0;
			if(hasStatusAffect("Black Nipples") >= 0) counter++;
			if(hasVagina() && vaginaType() == 5) counter++;
			if(eyeType == 2) counter++;
			if(wingType == 12) counter++;
			return counter;
		}
		//Determine Bee Rating
		public function beeScore():Number {
			var beeCounter:Number = 0;
			if(hairColor == "shiny black") beeCounter++;
			if(hairColor == "black and yellow") beeCounter += 2;
			if(antennae > 0) {
				beeCounter++;
				if(faceType == 0) beeCounter++;
			}
			if(lowerBody == 7) {
				beeCounter++;
				if(vaginas.length == 1) beeCounter++;
			}
			if(tailType == 6) beeCounter++;
			if(wingType == 1) beeCounter++;
			if(wingType == 2) beeCounter++;
			return beeCounter;
		}
		//Determine Dog Rating
		public function dogScore():Number {
			var dogCounter:Number = 0;
			if(faceType == 2) dogCounter++;
			if(earType == 2) dogCounter++;
			if(tailType == 2) dogCounter++;
			if(lowerBody == 2) dogCounter++;
			if(dogCocks() > 0) dogCounter++;
			if(breastRows.length > 1) dogCounter++;
			if(breastRows.length == 3) dogCounter++;
			if(breastRows.length > 3) dogCounter--;
			//Fur only counts if some canine features are present
			if(skinType == 1 && dogCounter > 0) dogCounter++;
			return dogCounter;
		}
		public function mouseScore():Number {
			var coonCounter:Number = 0;
			if(earType == 12) coonCounter++;
			if(tailType == 16) coonCounter++;
			
			if(faceType == 15) coonCounter++;
			if(faceType == 16) coonCounter+=2;
			//Fur only counts if some canine features are present
			if(skinType == 1 && coonCounter > 0) coonCounter++;
			
			if(tallness < 55 && coonCounter > 0) coonCounter++;
			if(tallness < 45 && coonCounter > 0) coonCounter++;
			return coonCounter;
		}
		public function raccoonScore():Number {
			var coonCounter:Number = 0;
			if(faceType == 13) coonCounter++;
			if(faceType == 14) coonCounter+=2;
			if(earType == 11) coonCounter++;
			if(tailType == 15) coonCounter++;
			if(lowerBody == 19) coonCounter++;
			if(coonCounter > 0 && balls > 0) coonCounter++;
			//Fur only counts if some canine features are present
			if(skinType == 1 && coonCounter > 0) coonCounter++;
			return coonCounter;
		}
		//Determine Fox Rating
		public function foxScore():Number {
			var dogCounter:Number = 0;
			if(faceType == 11) dogCounter++;
			if(earType == 9) dogCounter++;
			if(tailType == 13) dogCounter++;
			if(lowerBody == 17) dogCounter++;
			if(dogCocks() > 0 && dogCounter > 0) dogCounter++;
			if(breastRows.length > 1 && dogCounter > 0) dogCounter++;
			if(breastRows.length == 3 && dogCounter > 0) dogCounter++;
			if(breastRows.length == 4 && dogCounter > 0) dogCounter++;
			//Fur only counts if some canine features are present
			if(skinType == 1 && dogCounter > 0) dogCounter++;
			return dogCounter;
		}
		//Determine cat Rating
		public function catScore():Number {
			var catCounter:Number = 0;
			if(faceType == 6) catCounter++;
			if(earType == 5) catCounter++;
			if(tailType == 8) catCounter++;
			if(lowerBody == 9) catCounter++;
			if(catCocks() > 0) catCounter++;
			if(breastRows.length > 1 && catCounter > 0) catCounter++;
			if(breastRows.length == 3 && catCounter > 0) catCounter++;
			if(breastRows.length > 3) catCounter-=2;
			//Fur only counts if some canine features are present
			if(skinType == 1 && catCounter > 0) catCounter++;
			return catCounter;
		}
		//Determine lizard rating
		public function lizardScore():Number {
			var lizardCounter:Number = 0;
			if(faceType == 7) lizardCounter++;
			if(earType == 6) lizardCounter++;
			if(tailType == 9) lizardCounter++;
			if(lowerBody == 10) lizardCounter++;
			if(lizardCocks() > 0) lizardCounter++;
			if(horns > 0 && (hornType == 3 || hornType == 4)) lizardCounter++;
			if(skinType == 2) lizardCounter++;
			return lizardCounter;
		}
		public function spiderScore():Number {
			var score:Number = 0;
			if(eyeType == 1) score += 2;
			if(faceType == 10) score ++;
			if(armType == 2) score ++;
			if(lowerBody == 15 || lowerBody == 16) score += 2;
			else if(score > 0) score--;
			if(tailType == 5) score += 2;
			if(skinType > 0 && score > 0) score--;
			return score;
		}
		//Determine Horse Rating
		public function horseScore():Number {
			var horseCounter:Number = 0;
			if(faceType == 1) horseCounter++;
			if(earType == 1) horseCounter++;
			if(tailType == 1) horseCounter++;
			if(horseCocks() > 0) horseCounter++;
			if(lowerBody == 1 || lowerBody == 4) horseCounter++;
			//Fur only counts if some equine features are present
			if(skinType == 1 && horseCounter > 0) horseCounter++;
			return horseCounter;
		}
		//Determine kitsune Rating
		public function kitsuneScore():Number {
			var kitsuneCounter:int = 0;
			//If the character has fox ears, +1
			if(earType == 9) kitsuneCounter++;
			//If the character has a fox tail, +1
			if(tailType == 13) kitsuneCounter++;
			//If the character has two or more fox tails, +2
			if(tailType == 13 && tailVenom >= 2) kitsuneCounter += 2;
			//If the character has tattooed skin, +1
			//9999
			//If the character has a 'vag of holding', +1
			if(vaginalCapacity() >= 8000) kitsuneCounter++;
			//If the character's kitsune score is greater than 0 and:
			//If the character has a normal face, +1
			if(kitsuneCounter > 0 && faceType == 0) kitsuneCounter++;
			//If the character's kitsune score is greater than 1 and:
			//If the character has "blonde","black","red","white", or "silver" hair, +1
			if(kitsuneCounter > 0 && (hairColor == "golden blonde" || hairColor == "black" || hairColor == "red" || hairColor == "white" || hairColor == "silver blonde")) kitsuneCounter++;
			//If the character's femininity is 40 or higher, +1
			if(kitsuneCounter > 0 && femininity >= 40) kitsuneCounter++;
			//If the character has fur, scales, or gooey skin, -1
			if(skinType > 1) kitsuneCounter -= 2;
			if(skinType == 1) kitsuneCounter--;
			//If the character has abnormal legs, -1
			if(lowerBody != 0) kitsuneCounter--;
			//If the character has a nonhuman face, -1
			if(faceType != 0) kitsuneCounter--;
			//If the character has ears other than fox ears, -1
			if(earType != 9) kitsuneCounter--;
			//If the character has tail(s) other than fox tails, -1
			if(tailType != 13) kitsuneCounter--;
			
			return kitsuneCounter;

		}
		//Determine Horse Rating
		public function dragonScore():Number {
			var dragonCounter:Number = 0;
			if(faceType == 12) dragonCounter++;
			if(earType == 10) dragonCounter++;
			if(tailType == 14) dragonCounter++;
			if(tongueType == 3) dragonCounter++;
			if(dragonCocks() > 0) dragonCounter++;
			if(wingType == 10) dragonCounter++;
			if(wingType == 11) dragonCounter += 2;
			if(lowerBody == 18) dragonCounter++;
			if(skinType == 2 && dragonCounter > 0) dragonCounter++;
			return dragonCounter;
		}
		//Goblinscore
		public function goblinScore():Number {
			var horseCounter:Number = 0;
			if(earType == 4) horseCounter++;
			if(skinTone == "pale yellow" || skinTone == "grayish-blue" || skinTone == "green" || skinTone == "dark green") horseCounter++;
			if(horseCounter > 0) {
				if(faceType == 0) horseCounter++;
				if(tallness < 48) horseCounter++;
				if(hasVagina()) horseCounter++;
				if(lowerBody == 0) horseCounter++;
			}				
			return horseCounter;
		}
		//Gooscore
		public function gooScore():Number {
			var gooCounter:Number = 0;
			if(hairType == 3) gooCounter++;
			if(skinAdj == "slimy") gooCounter++;
			if(lowerBody == 8) gooCounter++;
			if(vaginalCapacity() > 9000) gooCounter++;
			if(hasStatusAffect("Slime Craving") >= 0) gooCounter++;
			return gooCounter;
		}
		//Nagascore
		public function nagaScore():Number {
			var nagaCounter:Number = 0;
			if(faceType == 5) nagaCounter++;
			if(tongueType == 1) nagaCounter++;
			if(nagaCounter > 0 && antennae == 0) nagaCounter++;
			if(nagaCounter > 0 && wingType == 0) nagaCounter++;
			return nagaCounter;
		}
		//Bunnyscore
		public function bunnyScore():Number {
			var bunnyCounter:Number = 0;
			if(faceType == 8) bunnyCounter++;
			if(tailType == 10) bunnyCounter++;
			if(earType == 7) bunnyCounter++;
			if(lowerBody == 12) bunnyCounter++;
			//More than 2 balls reduces bunny score
			if(balls > 2 && bunnyCounter > 0) bunnyCounter--;
			//Human skin on bunmorph adds
			if(skinType == 0 && bunnyCounter > 1) bunnyCounter++;
			//No wings and antennae a plus
			if(bunnyCounter > 0 && antennae == 0) bunnyCounter++;
			if(bunnyCounter > 0 && wingType == 0) bunnyCounter++;
			return bunnyCounter;
		}
		//Harpyscore
		public function harpyScore():Number {
			var harpy:Number = 0;
			if(armType == 1) harpy++;
			if(hairType == 1) harpy++;
			if(wingType == 9) harpy++;
			if(tailType == 11) harpy++;
			if(lowerBody == 13) harpy++;
			if(harpy >= 2 && faceType == 0) harpy++;
			if(harpy >= 2 && (earType == 0 || earType == 4)) harpy++;
			return harpy;
		}
		//Kangascore
		public function kangaScore():Number {
			var kanga:Number = 0;
			if(kangaCocks() > 0) kanga++;
			if(earType == 8) kanga++;
			if(tailType == 12) kanga++;
			if(lowerBody == 14) kanga++;
			if(faceType == 9) kanga++;
			if(kanga >= 2 && skinType == 1) kanga++;
			return kanga;
		}
		//sharkscore
		public function sharkScore():Number {
			var sharkCounter:Number = 0;
			if(faceType == 4) sharkCounter++;
			if(wingType == 8) sharkCounter++;
			if(tailType == 7) sharkCounter++;
			return sharkCounter;
		}
		//Determine Mutant Rating
		public function mutantScore():Number {
			var mutantCounter:Number = 0;
			if(faceType > 0) mutantCounter++;
			if(skinType > 0) mutantCounter++;
			if(tailType > 0) mutantCounter++;
			if(cockTotal() > 1) mutantCounter++;
			if(hasCock() && hasVagina()) mutantCounter++;
			if(hasFuckableNipples()) mutantCounter++;
			if(breastRows.length > 1) mutantCounter++;
			if(faceType == 1) {
				if(skinType == 1) mutantCounter--;
				if(tailType == 1) mutantCounter--;
			}
			if(faceType == 2) {
				if(skinType == 1) mutantCounter--;
				if(tailType == 2) mutantCounter--;
			}
			return mutantCounter--;
		}
		//Calculate bonus virility rating!
		//anywhere from 5% to 100% of normal cum effectiveness thru herbs!
		public function virilityQ():Number {
			if(!hasCock()) return 0;
			var percent:Number = 0.01;
			if(cumQ() >= 250) percent += 0.01;
			if(cumQ() >= 800) percent += 0.01;
			if(cumQ() >= 1600) percent += 0.02;
			if(hasPerk("Bro Body") >= 0) percent += 0.05;
			if(hasPerk("Marae's Gift - Stud") >= 0) percent += 0.15;
			if(hasPerk("Fera's Boon - Alpha") >= 0) percent += 0.10;
			if(perkv1("Elven Bounty") > 0) percent += 0.05;
			if(hasPerk("Fertility+") >= 0) percent += 0.03;
			if(hasPerk("Pierced: Fertite") >= 0) percent += 0.03;
			if(hasPerk("One Track Mind") >= 0) percent += 0.03;
			if(hasPerk("Magical Virility") >= 0) percent += 5;
			//Messy Orgasms?
			if(hasPerk("Messy Orgasms") >= 0) percent += 0.03;
			if(percent > 1) percent = 1;
			return percent;
		}
		//Calculate cum return
		public function cumQ():Number {
			if(!hasCock()) return 0;
			var quantity:Number = 0;
			//Base value is ballsize*ballQ*cumefficiency by a factor of 2.
			//Other things that affect it: 
			//lust - 50% = normal output.  0 = half output. 100 = +50% output.
			//trace("CUM ESTIMATE: " + int(1.25*2*cumMultiplier*2*(lust + 50)/10 * (hoursSinceCum+10)/24)/10 + "(no balls), " + int(ballSize*balls*cumMultiplier*2*(lust + 50)/10 * (hoursSinceCum+10)/24)/10 + "(withballs)");
			var lustCoefficient:Number = (lust + 50)/10;
			//Pilgrim's bounty maxxes lust coefficient
			if(hasPerk("Pilgrim's Bounty") >= 0) lustCoefficient = 150/10;
			if(balls == 0) quantity = int(1.25*2*cumMultiplier*2* lustCoefficient * (hoursSinceCum+10)/24)/10;
			else quantity = int(ballSize*balls*cumMultiplier*2* lustCoefficient * (hoursSinceCum+10)/24)/10;
			if(hasPerk("Bro Body") >= 0) quantity *= 1.3;
			if(hasPerk("Fertility+") >= 0) quantity *= 1.5;
			if(hasPerk("Messy Orgasms") >= 0) quantity *= 1.5;
			if(hasPerk("One Track Mind") >= 0) quantity *= 1.1;
			if(hasPerk("Marae's Gift - Stud") >= 0) quantity += 350;
			if(hasPerk("Fera's Boon - Alpha") >= 0) quantity += 200;
			if(hasPerk("Magical Virility") >= 0) quantity += 200;
			//if(hasPerk("Elven Bounty") >= 0) quantity += 250;;
			quantity += perkv1("Elven Bounty");
			if(hasPerk("Bro Body") >= 0) quantity += 200;
			quantity += statusAffectv1("rut");
			quantity *= (1 + (2 * perkv1("Pierced: Fertite"))/100);
			trace("Final Cum Volume: " + int(quantity) + "mLs.");
			if(quantity < 0) trace("SOMETHING HORRIBLY WRONG WITH CUM CALCULATIONS");
			if(quantity < 2) quantity = 2;
			return quantity;
		}
		//How many tentaclecocks?
		public function tentacleCocks():Number {
			var tentacleCockC:Number = 0;
			var counter = cocks.length;
			while(counter > 0)
			{
				counter--;
				if(cocks[counter].cockType == 4) tentacleCockC++;
			}
			return tentacleCockC;
		}
		//How many demoncocks?
		public function demonCocks():Number {
			var demonCockC:Number = 0;
			var counter = cocks.length;
			while(counter > 0)
			{
				counter--;
				if(cocks[counter].cockType == 3) demonCockC++;
			}
			return demonCockC;
		}
		//How many cat-cocks?
		public function catCocks():Number {
			var catCockC:Number = 0;
			var counter = cocks.length;
			while(counter > 0)
			{
				counter--;
				if(cocks[counter].cockType == 5) catCockC++;
			}
			return catCockC;
		}
		//How many lizard/snake-cocks?
		public function lizardCocks():Number {
			var lizCockC:Number = 0;
			var counter = cocks.length;
			while(counter > 0)
			{
				counter--;
				if(cocks[counter].cockType == 6) lizCockC++;
			}
			return lizCockC;
		}
		public function findFirstCockType(type:Number = 0):Number {
			var index:Number = 0;
			if(cocks[index].cockType == type) return index;
			while(index < cocks.length) {
				index++;
				if(cocks[index].cockType == type) return index;
			}
			trace("creature.findFirstCockType ERROR - searched for cocktype: " + type + " and could not find it.");
			return 0;		
		}
		public function displacerCocks():Number {
			var displacerWang:Number = 0;
			var counter = cocks.length;
			while(counter > 0) {
				counter--;
				if(cocks[counter].cockType == 10) displacerWang++;
			}
			return displacerWang;
		}
		//How many kangawangs
		public function kangaCocks():Number {
			var kangaWang:Number = 0;
			var counter = cocks.length;
			while(counter > 0) {
				counter--;
				if(cocks[counter].cockType == 8) kangaWang++;
			}
			return kangaWang;
		}
		//How many horsecocks?
		public function horseCocks():Number {
			var horseCockC:Number = 0;
			var counter = cocks.length;
			while(counter > 0)
			{
				counter--;
				if(cocks[counter].cockType == 1) horseCockC++;
			}
			return horseCockC;
		}
		//How many anemonecocks?
		public function anemoneCocks():Number {
			var anemoneCockC:Number = 0;
			var counter = cocks.length;
			while(counter > 0)
			{
				counter--;
				if(cocks[counter].cockType == 7) anemoneCockC++;
			}
			return anemoneCockC;
		}
		//Change first normal cock to horsecock!
		//Return number of affected cock, otherwise -1
		public function addHorseCock():Number {
			var counter = cocks.length;
			while (counter > 0) {
				counter--;
				//Human - > horse
				if(cocks[counter].cockType == 0) {
					cocks[counter].cockType = 1;					
					return counter;
				}
				//Dog - > horse
				if(cocks[counter].cockType == 2) {
					cocks[counter].cockType = 1;
					return counter;
				}
				//Tentacle - > horse
				if(cocks[counter].cockType == 4) {
					cocks[counter].cockType = 1;
					return counter;
				}
				//Demon -> horse
				if(cocks[counter].cockType == 3) {
					cocks[counter].cockType = 1;
					return counter;
				}
				//Catch-all
				if(cocks[counter].cockType > 4) {
					cocks[counter].cockType = 1;
					return counter;
				}
			}
			return -1;
		}
		//How many dogCocks
		public function dogCocks():Number {
			var dogCockC:Number = 0;
			var counter = cocks.length;
			while(counter > 0)
			{
				counter--;
				if(cocks[counter].cockType == 2) dogCockC++;
			}
			return dogCockC;
		}
		//How many dragonCocks
		public function dragonCocks():Number {
			var dragonCockC:Number = 0;
			var counter = cocks.length;
			while(counter > 0)
			{
				counter--;
				if(cocks[counter].cockType == 9) dragonCockC++;
			}
			return dragonCockC;
		}
		//How many normalCocks
		public function normalCocks():Number {
			var normalCockC:Number = 0;
			var counter = cocks.length;
			while(counter > 0)
			{
				counter--;
				if(cocks[counter].cockType == 0) normalCockC++;
			}
			return normalCockC;
		}
		//How many cocks?
		public function cockTotal():Number {
			return (cocks.length);
		}
		//Alternate
		public function totalCocks():Number {
			return (cocks.length);
		}
		//BOolean alternate
		public function hasCock():Boolean {
			if(cocks.length >= 1) return true;
			return false;
		}
		public function hasSockRoom():Boolean {
			var index:int = cockTotal();
			while(index > 0) {
				index--;
				if(cocks[index].sock == "") return true;
			}
			return false
		}
		public function hasSock(arg:String = ""):Boolean {
			var index:int = cockTotal();
			while(index > 0) {
				index--;
				if(cocks[index].sock != "") {
					if(arg == "" || cocks[index].sock == arg) return true;
				}
			}
			return false
		}
		public function canAutoFellate():Boolean {
			if(!hasCock()) return false;
			return (cocks[0].cockLength >= 20);
		}
		public function canSelfSuck():Boolean {
			return canAutoFellate();
		}
		//PC can fly?
		public function canFly():Boolean {
			//web also makes false!
			if(hasStatusAffect("Web") >= 0) return false;
			if(wingType == 2 || wingType == 7 || wingType == 9 || wingType == 11 || wingType == 12) return true;
			return false;
		}
		//check for vagoo
		public function hasVagina():Boolean {
			if(vaginas.length > 0) return true;
			return false;
		}
		public function hasVirginVagina():Boolean {
			if(vaginas.length > 0) return vaginas[0].virgin;
			return false;
		}
		public function manWoman(caps:Boolean = false):String {
			//Dicks?
			if(totalCocks() > 0) {
				if(hasVagina()) {
					if(caps) return "Futa";
					else return "futa";
				}
				else {
					if(caps) return "Man";
					else return "man";
				}
			}
			else {
				if(hasVagina()) {
					if(caps) return "Woman";
					else return "woman";
				}
				else {
					if(caps) return "Eunuch";
					else return "eunuch";
				}
			}			
		}
		public function guyGirl(caps:Boolean = false):String {
			//Dicks?
			if(totalCocks() > 0) {
				if(hasVagina()) {
					if(caps) return "Girl";
					else return "girl";
				}
				else {
					if(caps) return "Guy";
					else return "guy";
				}
			}
			else {
				if(hasVagina()) {
					if(caps) return "Girl";
					else return "girl";
				}
				else {
					if(biggestTitSize() >= 3) {
						if(caps) return "Girl";
						else return "girl";
					}
					if(caps) return "Guy";
					else return "guy";
				}
			}			
		}
		public function mfn(male:String,female:String,neuter:String):String {
			if(gender == 0) return neuter;
			else return mf(male,female);
		}
		public function mf(male:String,female:String):String {
			//Dicks?
			if(totalCocks() > 0) {
				if(hasVagina()) return female;
				else return male;
			}
			else {
				if(hasVagina()) return female;
				else {
					if(biggestTitSize() >= 3) return female;
					else return male;
				}
			}			
		}
		public function boyGirl(caps:Boolean = false):String {
			//Dicks?
			if(totalCocks() > 0) {
				if(hasVagina()) {
					if(caps) return "Girl";
					else return "girl";
				}
				else {
					if(caps) return "Boy";
					else return "boy";
				}
			}
			else {
				if(hasVagina()) {
					if(caps) return "Girl";
					else return "girl";
				}
				else {
					if(biggestTitSize() >= 3) {
						if(caps) return "Girl";
						else return "girl";
					}
					if(caps) return "Boy";
					else return "boy";
				}
			}			
		}
		public function heShe(caps:Boolean = false):String {
			//Dicks?
			if(totalCocks() > 0) {
				if(hasVagina()) {
					if(caps) return "She";
					else return "she";
				}
				else {
					if(caps) return "He";
					else return "he";
				}
			}
			else {
				if(hasVagina()) {
					if(caps) return "She";
					else return "she";
				}
				else {
					if(biggestTitSize() >= 3) {
						if(caps) return "She";
						else return "she";
					}
					if(caps) return "it";
					else return "it";
				}
			}			
		}
		public function himHer(caps:Boolean = false):String {
			//Dicks?
			if(totalCocks() > 0) {
				if(hasVagina()) {
					if(caps) return "Her";
					else return "her";
				}
				else {
					if(caps) return "Him";
					else return "him";
				}
			}
			else {
				if(hasVagina()) {
					if(caps) return "Her";
					else return "her";
				}
				else {
					if(biggestTitSize() >= 3) {
						if(caps) return "Her";
						else return "her";
					}
					if(caps) return "Him";
					else return "him";
				}
			}			
		}
		public function maleFemale(caps:Boolean = false):String {
			//Dicks?
			if(totalCocks() > 0) {
				if(hasVagina()) {
					if(caps) return "Female";
					else return "female";
				}
				else {
					if(caps) return "Male";
					else return "male";
				}
			}
			else {
				if(hasVagina()) {
					if(caps) return "Female";
					else return "female";
				}
				else {
					if(biggestTitSize() >= 3) {
						if(caps) return "Female";
						else return "female";
					}
					if(caps) return "Male";
					else return "male";
				}
			}			
		}
		public function hisHer(caps:Boolean = false):String {
			//Dicks?
			if(totalCocks() > 0) {
				if(hasVagina()) {
					if(caps) return "Her";
					else return "her";
				}
				else {
					if(caps) return "Him";
					else return "him";
				}
			}
			else {
				if(hasVagina()) {
					if(caps) return "Her";
					else return "her";
				}
				else {
					if(biggestTitSize() >= 3) {
						if(caps) return "Her";
						else return "her";
					}
					if(caps) return "Him";
					else return "him";
				}
			}			
		}
		//sir/madam
		public function sirMadam(caps:Boolean = false):String {
			//Dicks?
			if(totalCocks() > 0) {
				//herm
				if(hasVagina()) {
					//Boy unless has tits!
					if(biggestTitSize() >= 2) {
						if(caps) return "Madam";
						else return "madam";
					}
					else {
						if(caps) return "Sir";
						else return "sir";
					}
				}
				//Dude
				else {
					if(caps) return "Sir";
					else return "sir";
				}
			}
			//No dicks
			else {
				//Girl
				if(hasVagina()) {
					if(caps) return "Madam";
					else return "madam";
				}
				//Eunuch!
				else {
					//Called girl if has tits!
					if(biggestTitSize() >= 2) {
						if(caps) return "Madam";
						else return "madam";
					}
					//Called dude with no tits
					else {
						if(caps) return "Sir";
						else return "sir";
					}
				}
			}			
		}
		//Create a cock
		public function createCock(clength:Number = 5.5, cthickness:Number = 1):Boolean {
			if(cocks.length >= 10) return false;
			var newCock = new cockClass();
			cocks.push(newCock);
			cocks[cocks.length-1].cockThickness = cthickness;
			cocks[cocks.length-1].cockLength = clength;
			return true;
		}
		//create vagoo
		public function createVagina():Boolean {
			if(vaginas.length >= 2) return false;
			var newVagina = new vaginaClass();
			vaginas.push(newVagina);
			return true;
		}
		//create a row of breasts
		public function createBreastRow():Boolean {
			if(breastRows.length >= 10) return false;
			var newBreastRow = new breastRowClass();
			breastRows.push(newBreastRow);
			return true;
		}
		public function genderCheck():void {
			if(hasCock() && hasVagina()) gender = 3;
			else if(hasCock()) gender = 1;
			else if(hasVagina()) gender = 2;
			else gender = 0;
		}
		//Remove cocks
		public function removeCock(arraySpot, totalRemoved):void {
			//Various Errors preventing action
			if(arraySpot < 0 || totalRemoved <= 0) {
				//trace("ERROR: removeCock called but arraySpot is negative or totalRemoved is 0.");
				return;
			}
			if(cocks.length == 0) {
				//trace("ERROR: removeCock called but cocks do not exist.");
			}
			else {
				if(arraySpot > cocks.length - 1) {
					//trace("ERROR: removeCock failed - array location is beyond the bounds of the array.");
				}
				else
				{
					cocks.splice(arraySpot, totalRemoved);
					trace("Attempted to remove " + totalRemoved + " cocks.");
				}
			}
			genderCheck();
		}
		//REmove vaginas
		public function removeVagina(arraySpot:int = 0, totalRemoved:int = 1):void {
			//Various Errors preventing action
			if(arraySpot < -1 || totalRemoved <= 0) {
				//trace("ERROR: removeVagina called but arraySpot is negative or totalRemoved is 0.");
				return;
			}
			if(vaginas.length == 0) {
				//trace("ERROR: removeVagina called but cocks do not exist.");
			}
			else {
				if(arraySpot > vaginas.length - 1) {
					//trace("ERROR: removeVagina failed - array location is beyond the bounds of the array.");
				}
				else
				{
					vaginas.splice(arraySpot, totalRemoved);
					trace("Attempted to remove " + totalRemoved + " vaginas.");
				}
			}
			genderCheck();
		}
		//Remove a breast row
		public function removeBreastRow(arraySpot, totalRemoved):void {
			//Various Errors preventing action
			if(arraySpot < -1 || totalRemoved <= 0) {
				//trace("ERROR: removeBreastRow called but arraySpot is negative or totalRemoved is 0.");
				return;
			}
			if(breastRows.length == 0) {
				//trace("ERROR: removeBreastRow called but cocks do not exist.");
			}
			else {
				if(arraySpot > breastRows.length - 1) {
					//trace("ERROR: removeBreastRow failed - array location is beyond the bounds of the array.");
				}
				else
				{
					breastRows.splice(arraySpot, totalRemoved);
					trace("Attempted to remove " + totalRemoved + " breastRows.");
				}
			}
		}
		public function race():String {
			//Temp vars
			var temp:Number = 0;
			var rando:Number = 0;
			//Determine race type:
			var race:String = "human";
			if(lowerBody == 4) race = "centaur";
			if(lowerBody == 11) race = "pony-kin";
			//determine sheath
			var sheath:Boolean = false;
			if(catScore() >= 4) race = "cat-" + mf("boy","girl");
			if(lizardScore() >= 4) {
				if(gender == 0) race = "lizan";
				else if(gender == 1) race = "male lizan";
				else if(gender == 2) race = "female lizan";
				else race = "hermaphrodite lizan";
			}
			if(dragonScore() >= 4) {
				race = "dragon-morph";
				if(faceType == 0) race = "dragon-" + mf("man","girl");
			}
			if(raccoonScore() >= 4) {
				race = "raccoon-morph";
				if(balls > 0 && ballSize > 5) race = "tanuki-morph";
			}
			if(dogScore() >= 4) race = "dog-morph";
			if(foxScore() >= 4) {
				if(skinType == 1) race = "fox-morph";
				else race = mf("fox-morph","fox-girl");
			}
			if(kitsuneScore() >= 4) {
				race = "kitsune";
			}
			if(horseScore() >= 3) {
				if(lowerBody == 4) race = "centaur-morph";
				else race = "equine-morph";
			}
			if(mutantScore() >= 5 && race == "human") race = "corrupted mutant";
			if(minoScore() >= 4) race = "minotaur-morph";
			if(cowScore() > 5) {
				race = "cow-";
				race += mf("morph","girl");
			}
			if(beeScore() >= 5) race = "bee-morph";
			if(goblinScore() >= 5) race = "goblin";
			if(humanScore() >= 5 && race == "corrupted mutant") race = "somewhat human mutant";
			if(demonScore() > 4) race = "demon-morph";
			if(sharkScore() >= 3) race = "shark-morph";
			if(bunnyScore() >= 4) race = "bunny-" + mf("boy","girl");
			if(harpyScore() >= 4) {
				if(gender >= 2) race = "harpy";
				else race = "avian";
			}
			if(spiderScore() >= 4) {
				race = "spider-morph";
				if(mf("no","yes") == "yes") race = "spider-girl";
				if(lowerBody == 16) race = "drider";
			}
			if(kangaScore() >= 4) race = "kangaroo-morph";
			if(mouseScore() >= 3) {
				if(faceType != 16) race = "mouse-" + mf("boy","girl");
				else race = "mouse-morph";
			}
			if(lowerBody == 3) race = "naga";
			if(lowerBody == 4) race = "centaur";

			if(gooScore() >= 3) {
				race = "goo-";
				race += mf("boi","girl");
			}
			return race;
		}
	}
}

