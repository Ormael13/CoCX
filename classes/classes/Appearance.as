package classes
{
import classes.BodyParts.*;
import classes.BodyParts.Antennae;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.GlobalFlags.kFLAGS;
import classes.internals.Utils;
import classes.lists.Gender;

public class Appearance extends Utils
	{
		// Eventually, this should contain the entire char appearance.
		// At the moment, it's pretty piecemeal.
		public static function inverseMap(x:Object):Object
		{
			var result:Object = {};
			for (var i:String in x) {
				result[String(x[i])] = i;
			}
			return result;
		}

		public static function hairOrFur(i_creature:Creature):String
		{
			if (i_creature.hasCoatOfType(Skin.FUR))
				return "fur";
			else
				return "hair";
		}

		public static function hairDescription(i_creature:Creature, longDesc:Boolean = false):String
		{
			var description:String = "";
			var options:Array;
			var hairscale:Number;
			//
			// LENGTH ADJECTIVE!
			//
			if (i_creature.hairLength == 0) {
				options = ["shaved",
					"bald",
					"smooth",
					"hairless",
					"glabrous"];
				description = randomChoice(options) + " head";
				return description;
			}
			else {
				hairscale = int((i_creature.hairLength/i_creature.tallness)*100)/100
				if (hairscale <= 0.05){	//Values roughly based on actual human ratios.
					options = ["close-cropped, ",
						"trim, ",
						"very short, "];
					description += randomChoice(options);
				}
				else if (hairscale > 0.05 && hairscale <= 0.1){
					description += "short, ";
				}
				else if (hairscale > 0.1 && hairscale <= 0.14){
					description += "shaggy, ";
				}
				else if (hairscale > 0.14 && hairscale <= 0.17){
					description += "moderately long, ";
				}
				else if (hairscale > 0.17 && hairscale <= 0.2){
					if (rand(2) == 0) description += "long, ";
					else description += "shoulder-length, ";
				}
				else if (hairscale > 0.2 && hairscale <= 0.25){
					if (rand(2) == 0) description += "very long, ";
					else description += "flowing locks of ";
				}
				else if (hairscale > 0.25 && hairscale <= 0.4){
					description += "back-covering, ";
				}
				else if (hairscale > 0.4 && hairscale <= 0.5){
					description += "ass-length, ";
				}
				else if (hairscale > 0.5 && hairscale <= 1){
					description += "obscenely long, "
				}
				else if (hairscale > 1 ){
					if (rand(2) == 0) description += "floor-length, ";
					else description += "floor-dragging, ";
				}
			}
			//
			// COLORS
			//
			description += i_creature.hairColor + " ";
			//
			// HAIR WORDS
			//

			const hairObj: Object = Hair.Types[i_creature.hairType];

			var hair:String = "hair";

			//If furry and longish hair sometimes call it a mane (50%)
			if (i_creature.hasFur() == 1 && i_creature.hairLength > 3 && rand(2) == 0) {
				hair += "mane";
			}

			if (longDesc) {
				description += (hairObj.longDesc || hairObj.shortDesc || "hair").replace('{hair}', hair);
			} else {
				description += (hairObj.shortDesc || hairObj.longDesc || "hair").replace('{hair}', hair);
			}

			if (i_creature.hairType == Hair.SNOWY && i_creature.rearBody.type == RearBody.GLACIAL_AURA) {
				description += ", which might be related to your bone chilling aura";
			}

			return description;
		}

		public static function beardDescription(i_creature:Creature):String
		{
			var description:String = "";
			var options:Array;
			//
			// LENGTH ADJECTIVE!
			//
			if (i_creature.beardLength == 0) {
				options = ["shaved",
					"bald",
					"smooth",
					"hairless",
					"glabrous"];
				description = randomChoice(options) + " chin and cheeks";
				return description;
			}
			else if (i_creature.beardLength < 0.2) {
				options = ["close-cropped, ",
					"trim, ",
					"very short, "];
				description += randomChoice(options);
			}
			else if (i_creature.beardLength >= 0.2 && i_creature.beardLength < 0.5) description += "short, ";
			else if (i_creature.beardLength >= 0.5 && i_creature.beardLength < 1.5) description += "medium, ";
			else if (i_creature.beardLength >= 1.5 && i_creature.beardLength < 3) description += "moderately long, ";
			else if (i_creature.beardLength >= 3 && i_creature.beardLength < 6) {
				if (rand(2) == 0) description += "long, ";
				else description += "neck-length, ";
			}
			else if (i_creature.beardLength >= 6) {
				if (rand(2) == 0) description += "very long, ";
				description += "chest-length, ";
			}
			//
			// COLORS
			//
			description += i_creature.hairColor + " ";
			//
			// BEARD WORDS
			// Follows hair type.
			const hairObj: Object = Hair.Types[i_creature.hairType];

			description += hairObj.beardDesc || "";

			const beardStyles: Array = ["beard", "goatee", "clean-cut beard", "mountain-man beard"];

			description += beardStyles[i_creature.beardStyle];

			return description;
		}

		public static function hairStyleDescription(i_creature:Creature):String
		{
			var description:String = "";
			var options: Array = ["plain", "wild", "ponytail", "long tied up", "twin pigtail", "dwarven"];
			description += options[i_creature.hairStyle];

			return description;
		}

		/**
		 * Describe tongue. Monsters don't have tongues, apparently.
		 * @param    i_character Either Player or NonPlayer
		 * @return    A beautiful description of a tongue.
		 */
		public static function tongueDescription(i_character:Creature):String
		{
			if (i_character.tongue.type == 1) return "serpentine tongue";
			else if (i_character.tongue.type == 2) return "demonic tongue";
			else if (i_character.tongue.type == 3) return "draconic tongue";
			else if (i_character.tongue.type == 4) return "echidna tongue";
			else if (i_character.tongue.type == 5) return "feline tongue";
			else if (i_character.tongue.type == 6) return "elf tongue";
			else if (i_character.tongue.type == 7) return "canine tongue";
			else if (i_character.tongue.type == 8) return "draconic tongue that glow in the dark";
			else return "tongue";
		}

		public static function nippleDescription(i_creature:Creature, i_rowNum:Number):String
		{
			//DEBUG SHIT!
			if (i_rowNum > (i_creature.breastRows.length - 1)) {
				CoC_Settings.error("<B>Error: Invalid breastRows (" + i_rowNum + ") passed to nippleDescription()</b>");
				return "<B>Error: Invalid breastRows (" + i_rowNum + ") passed to nippleDescription()</b>";
			}
			if (i_rowNum < 0) {
				CoC_Settings.error("<B>Error: Invalid breastRows (" + i_rowNum + ") passed to nippleDescription()</b>");
				return "<B>Error: Invalid breastRows (" + i_rowNum + ") passed to nippleDescription()</b>";
			}
			var haveDescription:Boolean = false;
			var description:String = "";
			var options:Array;
			var rando:Number = 0;
			//Size descriptors 33% chance
			if (rand(4) == 0) {
				//TINAHHHH
				if (i_creature.nippleLength < .25) {
					options = ["tiny ",
						"itty-bitty ",
						"teeny-tiny ",
						"dainty "];
					description += randomChoice(options);
				}
				//Prominant
				if (i_creature.nippleLength >= .4 && i_creature.nippleLength < 1) {
					options = ["prominent ",
						"pencil eraser-sized ",
						"eye-catching ",
						"pronounced ",
						"striking "];
					description += randomChoice(options);
				}
				//Big 'uns
				if (i_creature.nippleLength >= 1 && i_creature.nippleLength < 2) {
					options = ["forwards-jutting ",
						"over-sized ",
						"fleshy ",
						"large protruding "];
					description += randomChoice(options);
				}
				//'Uge
				if (i_creature.nippleLength >= 2 && i_creature.nippleLength < 3.2) {
					options = ["elongated ",
						"massive ",
						"awkward ",
						"lavish ",
						"hefty "];
					description += randomChoice(options);
				}
				//Massive
				if (i_creature.nippleLength >= 3.2) {
					options = ["bulky ",
						"ponderous ",
						"thumb-sized ",
						"cock-sized ",
						"cow-like "];
					description += randomChoice(options);
				}
				haveDescription = true;
			}
			//Milkiness/Arousal/Wetness Descriptors 33% of the time
			if (rand(3) == 0 && !haveDescription) {
				//Fuckable chance first!
				if (i_creature.hasFuckableNipples()) {
					//Fuckable and lactating?
					if (i_creature.biggestLactation() > 1) {
						options = ["milk-lubricated ",
							"lactating ",
							"lactating ",
							"milk-slicked ",
							"milky "];
						description += randomChoice(options);
					}
					//Just fuckable
					else {
						options = ["wet ",
							"mutated ",
							"slimy ",
							"damp ",
							"moist ",
							"slippery ",
							"oozing ",
							"sloppy ",
							"dewy "];
						description += randomChoice(options);
					}
					haveDescription = true;
				}
				//Just lactating!
				else if (i_creature.biggestLactation() > 0) {
					//Light lactationf
					if (i_creature.biggestLactation() <= 1) {
						options = ["milk moistened ",
							"slightly lactating ",
							"milk-dampened "];
						description += randomChoice(options);
					}
					//Moderate lactation
					if (i_creature.biggestLactation() > 1 && i_creature.biggestLactation() <= 2) {
						options = ["lactating ",
							"milky ",
							"milk-seeping "];
						description += randomChoice(options);
					}
					//Heavy lactation
					if (i_creature.biggestLactation() > 2) {
						options = ["dripping ",
							"dribbling ",
							"milk-leaking ",
							"drooling "];
						description += randomChoice(options);
					}
					haveDescription = true;
				}
			}
			//Possible arousal descriptors
			else if (rand(3) == 0 && !haveDescription) {
				if (i_creature.lust > 50 && i_creature.lust < 75) {
					options = ["erect ",
						"perky ",
						"erect ",
						"firm ",
						"tender "];
					description += randomChoice(options);
					haveDescription = true;
				}
				if (i_creature.lust >= 75) {
					options = ["throbbing ",
						"trembling ",
						"needy ",
						"throbbing "];
					description += randomChoice(options);
					haveDescription = true;
				}
			}
			if (!haveDescription && rand(2) == 0 && i_creature.nipplesPierced > 0 && i_rowNum == 0) {
				if (i_creature.nipplesPierced == 5) description += "chained ";
				else description += "pierced ";
				haveDescription = true;
			}
			if (!haveDescription && i_creature.hasGooSkin()) {
				options = ["slime-slick ",
					"goopy ",
					"slippery "];
				description += randomChoice(options);
			}
			if (!haveDescription && i_creature.hasGhostSkin()) {
				options = ["transparent "];
				description += randomChoice(options);
			}
			if (!haveDescription && i_creature.hasStatusEffect(StatusEffects.BlackNipples)) {
				options = ["black ",
					"ebony ",
					"sable "];
				description += randomChoice(options);
			}
			if (!haveDescription && i_creature.hasStatusEffect(StatusEffects.GlowingNipples)) {
				description += "neon blue ";
				options = ["luminescent ",
					"glowing "];
				description += randomChoice(options);
			}

			//Nounsssssssss*BOOM*
			var choice:int = 0;
			choice = rand(5);
			if (choice == 0) description += "nipple";
			if (choice == 1) {
				if (i_creature.nippleLength < .5) description += "perky nipple";
				else description += "cherry-like nub";
			}
			if (choice == 2) {
				if (i_creature.hasFuckableNipples()) description += "fuckable nip";
				else {
					if (i_creature.biggestLactation() >= 1 && i_creature.nippleLength >= 1) description += "teat";
					else description += "nipple";
				}
			}
			if (choice == 3) {
				if (i_creature.hasFuckableNipples()) description += "nipple-hole";
				else {
					if (i_creature.biggestLactation() >= 1 && i_creature.nippleLength >= 1) description += "teat";
					else description += "nipple";
				}
			}
			if (choice == 4) {
				if (i_creature.hasFuckableNipples()) description += "nipple-cunt";
				else description += "nipple";
			}
			return description;
		}

		public static function hipDescription(i_creature:Creature):String
		{
			var description:String    = "";
			var options:Array;
			var i_character:Character = i_creature as Character;
			var hipRating:Number      = i_creature.hips.type;
			var thickness:Number      = i_character ? i_character.thickness : 50;
			if (hipRating <= 1) {
				options = ["tiny ",
					"narrow ",
					"boyish "];
				description = randomChoice(options);
			}
			else if (hipRating > 1 && hipRating < 4) {
				options = ["slender ",
					"narrow ",
					"thin "];
				description = randomChoice(options);
				if (thickness < 30) {
					if (rand(2) == 0) description = "slightly-flared ";
					else description = "curved ";
				}
			}
			else if (hipRating >= 4 && hipRating < 6) {
				options = ["well-formed ",
					"pleasant "];
				description = randomChoice(options);
				if (thickness < 30) {
					if (rand(2) == 0) description = "flared ";
					else description = "curvy ";
				}
			}
			else if (hipRating >= 6 && hipRating < 10) {
				options = ["ample ",
					"noticeable ",
					"girly "];
				description = randomChoice(options);
				if (thickness < 30) {
					if (rand(2) == 0) description = "flared ";
					else description = "waspish ";
				}
			}
			else if (hipRating >= 10 && hipRating < 15) {
				options = ["flared ",
					"curvy ",
					"wide "];
				description = randomChoice(options);
				if (thickness < 30) {
					if (rand(2) == 0) description = "flared ";
					else description = "waspish ";
				}
			}
			else if (hipRating >= 15 && hipRating < 20) {
				if (thickness < 40) {
					if (rand(2) == 0) description = "flared, ";
					else description = "waspish, ";
				}
				options = ["fertile ",
					"child-bearing ",
					"voluptuous "];
				description += randomChoice(options);
			}
			else if (hipRating >= 20) {
				if (thickness < 40) {
					if (rand(2) == 0) description = "flaring, ";
					else description = "incredibly waspish, ";
				}
				options = ["broodmother-sized ",
					"cow-like ",
					"inhumanly-wide "];
				description += randomChoice(options);
			}
			//Taurs
			if (i_creature.isTaur() && rand(3) == 0) description += "flanks";
			//Nagas have sides, right?
			else if (i_creature.isNaga() && rand(3) == 0) description += "sides";
			//Non taurs or taurs who didn't roll flanks
			else {
				options = ["hips",
					"thighs"];
				description += randomChoice(options);
			}

			return description;
		}

		public static function cockDescript(creature:Creature, cockIndex:Number = 0):String
		{
			if (creature.cocks.length == 0) return "<b>ERROR: CockDescript Called But No Cock Present</b>";
			var cockType:CockTypesEnum = CockTypesEnum.HUMAN;
			if (cockIndex != 99) { //CockIndex 99 forces a human cock description
				if (creature.cocks.length <= cockIndex) return "<b>ERROR: CockDescript called with index of " + cockIndex + " - out of BOUNDS</b>";
				cockType = creature.cocks[cockIndex].cockType;
			}
			var isPierced:Boolean = (creature.cocks.length == 1) && (creature.cocks[cockIndex].isPierced); //Only describe as pierced or sock covered if the creature has just one cock
			var hasSock:Boolean = (creature.cocks.length == 1) && (creature.cocks[cockIndex].sock != "");
			var isGooey:Boolean = (creature.skin.hasGooSkin());
			var isGhastly:Boolean = (creature.skin.hasGhostSkin());
			return cockDescription(cockType, creature.cocks[cockIndex].cockLength, creature.cocks[cockIndex].cockThickness, creature.lust, creature.cumQ(), isPierced, hasSock, isGooey, isGhastly);
		}

		//This function takes all the variables independently so that a creature object is not required for a cockDescription.
		//This allows a single cockDescription function to produce output for both cockDescript and the old NPCCockDescript.
		public static function cockDescription(cockType:CockTypesEnum, length:Number, girth:Number, lust:int = 50, cumQ:Number = 10, isPierced:Boolean = false, hasSock:Boolean = false, isGooey:Boolean = false, isGhastly:Boolean = false): String {
			if (rand(2) == 0) {
				if(cockType == CockTypesEnum.HUMAN) return cockAdjective(cockType, length, girth, lust, cumQ, isPierced, hasSock, isGooey, isGhastly) + " " + cockNoun(cockType);
				else return cockAdjective(cockType, length, girth, lust, cumQ, isPierced, hasSock, isGooey, isGhastly) + ", " + cockNoun(cockType);
			}
			return cockNoun(cockType);
		}

		public static function cockNoun(cockType:CockTypesEnum):String
		{
			/*
			if (cockType is int) {
				trace("Someone is still calling cockNoun with an integer cock type");
				trace("Fix this shit already, dammit!")
				cockType = CockTypesEnum.ParseConstantByIndex(cockType);
			}
			*/
			if (cockType == CockTypesEnum.HUMAN) {
				// Yeah, this is kind of messy
				// there is no other easy way to preserve the weighting fenoxo did
				return randomChoice("cock",
					"cock",
					"cock",
					"cock",
					"cock",
					"prick",
					"prick",
					"pecker",
					"shaft",
					"shaft",
					"shaft");
			}
			else if (cockType == CockTypesEnum.BEE) {
				return randomChoice("bee prick",
					"bee prick",
					"bee prick",
					"bee prick",
					"insectoid cock",
					"insectoid cock",
					"furred monster");
			}
			else if (cockType == CockTypesEnum.DOG) {
				return randomChoice("dog-shaped dong",
					"canine shaft",
					"pointed prick",
					"knotty dog-shaft",
					"bestial cock",
					"animalistic puppy-pecker",
					"pointed dog-dick",
					"pointed shaft",
					"canine member",
					"canine cock",
					"knotted dog-cock");
			}
			else if (cockType == CockTypesEnum.FOX) {
				return randomChoice("fox-shaped dong",
					"vulpine shaft",
					"pointed prick",
					"knotty fox-shaft",
					"bestial cock",
					"animalistic vixen-pricker",
					"pointed fox-dick",
					"pointed shaft",
					"vulpine member",
					"vulpine cock",
					"knotted fox-cock");
			}
			else if (cockType == CockTypesEnum.WOLF) {
				return randomChoice("wolf-shaped dong",
					"lupine shaft",
					"pointed prick",
					"knotty wolf-shaft",
					"bestial cock",
					"animalistic lupin-pecker",
					"pointed wolf-dick",
					"pointed shaft",
					"lupine member",
					"lupine cock",
					"knotted wolf-cock");
			}
			else if (cockType == CockTypesEnum.HORSE) {
				return randomChoice("flared horse-cock",
					"equine prick",
					"bestial horse-shaft",
					"flat-tipped horse-member",
					"animalistic stallion-prick",
					"equine dong",
					"beast cock",
					"flared stallion-cock");
			}
			else if (cockType == CockTypesEnum.DEMON) {
				return randomChoice("nub-covered demon-dick",
					"nubby shaft",
					"corrupted cock",
					"perverse pecker",
					"bumpy demon-dick",
					"demonic cock",
					"demonic dong",
					"cursed cock",
					"infernal prick",
					"unholy cock",
					"blighted cock");
			}
			else if (cockType == CockTypesEnum.TENTACLE) {
				return randomChoice("twisting tentacle-prick",
					"wriggling plant-shaft",
					"sinuous tentacle-cock",
					"squirming cock-tendril",
					"writhing tentacle-pecker",
					"wriggling plant-prick",
					"penile flora",
					"smooth shaft",
					"undulating tentacle-dick",
					"slithering vine-prick",
					"vine-shaped cock");
			}
			else if (cockType == CockTypesEnum.SCYLLATENTACLE) {
				return randomChoice("twisting tentacle-prick",
						"wriggling tentacle-shaft",
						"sinuous tentacle-cock",
						"squirming cock-tendril",
						"writhing tentacle-pecker",
						"wriggling tentacle-prick",
						"smooth shaft",
						"undulating tentacle-dick",
						"slithering tentacle-prick");
			}
			else if (cockType == CockTypesEnum.STAMEN) {
				return randomChoice("squirming cock-stamen",
					"plant-like stamen",
					"penile flora",
					"smooth shaft",
					"stamen-shaped cock");
			}
			else if (cockType == CockTypesEnum.CAT) {
				return randomChoice("feline dick",
					"spined cat-cock",
					"pink kitty-cock",
					"spiny prick",
					"animalistic kitty-prick",
					"oddly-textured cat-penis",
					"feline member",
					"spined shaft",
					"feline shaft",
					"barbed dick",
					"nubby kitten-prick");
			}
			else if (cockType == CockTypesEnum.LIZARD) {
				return randomChoice("reptilian dick",
					"purple cock",
					"inhuman cock",
					"reptilian prick",
					"purple prick",
					"purple member",
					"serpentine member",
					"serpentine shaft",
					"reptilian shaft",
					"bulbous snake-shaft",
					"bulging snake-dick");
			}
			else if (cockType == CockTypesEnum.CAVE_WYRM) {
				return randomChoice("glowing reptilian dick",
					"luminescent neon blue cock",
					"glowing inhuman cock",
					"luminescent reptilian prick",
					"luminescent neon blue prick",
					"glowing neon blue member",
					"glowing serpentine member",
					"luminescent serpentine shaft",
					"glowing reptilian shaft",
					"glowing bulbous snake-shaft",
					"luminescent bulging snake-dick");
			}
			else if (cockType == CockTypesEnum.ANEMONE) {
				return randomChoice("anemone dick",
					"tentacle-ringed cock",
					"blue member",
					"stinger-laden shaft",
					"pulsating prick",
					"anemone prick",
					"stinger-coated member",
					"blue cock",
					"tentacle-ringed dick",
					"near-transparent shaft",
					"squirming shaft");
			}
			else if (cockType == CockTypesEnum.KANGAROO) {
				return randomChoice("kangaroo-like dick",
					"pointed cock",
					"marsupial member",
					"tapered shaft",
					"curved pecker",
					"pointed prick",
					"squirming kangaroo-cock",
					"marsupial cock",
					"tapered kangaroo-dick",
					"curved kangaroo-cock",
					"squirming shaft");
			}
			else if (cockType == CockTypesEnum.DRAGON) {
				return randomChoice("dragon-like dick",
					"segmented shaft",
					"pointed prick",
					"knotted dragon-cock",
					"mythical mast",
					"segmented tool",
					"draconic dick",
					"draconic cock",
					"tapered dick",
					"unusual endowment",
					"scaly shaft");
			}
			else if (cockType == CockTypesEnum.DISPLACER) {
				return randomChoice("coerl cock",
					"tentacle-tipped phallus",
					"starfish-tipped shaft",
					"alien member",
					"almost-canine dick",
					"bizarre prick",
					"beastly cock",
					"cthulhu-tier cock",
					"coerl cock",
					"animal dong",
					"star-capped tool",
					"knotted erection");
			}
			else if (cockType == CockTypesEnum.AVIAN) {
				return randomChoice("bird cock",
					"bird dick",
					"bird pecker",
					"avian cock",
					"avian dick",
					"avian penis",
					"avian prick",
					"avian pecker",
					"tapered cock",
					"tapered prick");
			}
			else if (cockType == CockTypesEnum.PIG) {
				return randomChoice("pig cock",
					"pig dick",
					"pig penis",
					"pig-like cock",
					"pig-like dick",
					"swine cock",
					"swine penis",
					"corkscrew-tipped cock",
					"hoggish cock",
					"pink pig-cock",
					"pink pecker");
			}
			else if (cockType == CockTypesEnum.RHINO) {
				return randomChoice("oblong cock",
					"oblong dick",
					"oblong prick",
					"rhino cock",
					"rhino dick",
					"rhino penis",
					"rhino pecker",
					"rhino prick",
					"bulged rhino cock",
					"bulged rhino dick");
			}
			else if (cockType == CockTypesEnum.ECHIDNA) {
				return randomChoice("strange echidna dick",
					"strange echidna cock",
					"echidna dick",
					"echidna penis",
					"echidna cock",
					"exotic endowment",
					"four-headed prick",
					"four-headed penis",
					"four-headed cock",
					"four-headed dick");
			}
			else if (cockType == CockTypesEnum.USHI_ONI) {
				return randomChoice("starfish tipped shaft",
					"starfish tipped cock",
					"starfish tipped dick",
					"starfish tipped penis");
			}
			return randomChoice("cock",
				"prick",
				"pecker",
				"shaft");
		}

		//New cock adjectives.  The old one sucked dicks
		//This function handles all cockAdjectives. Previously there were separate functions for the player, monsters and NPCs.
		public static function cockAdjective(cockType:CockTypesEnum, length:Number, girth:Number, lust:int = 50, cumQ:Number = 10, isPierced:Boolean = false, hasSock:Boolean = false, isGooey:Boolean = false, isGhastly:Boolean = false):String {
			//First, the four possible special cases
			if (isPierced && rand(5) == 0) return "pierced";
			if (hasSock && rand(5) == 0) return randomChoice("sock-sheathed", "garment-wrapped", "smartly dressed", "cloth-shrouded", "fabric swaddled", "covered");
			if (isGooey && rand(4) == 0) return randomChoice("goopey", "gooey", "slimy");
			if (isGhastly && rand(4) == 0) return randomChoice("transparent", "ghostly");
			//Length 1/3 chance
			if (rand(3) == 0) {
				if (length < 3) return randomChoice("little", "toy-sized", "mini", "budding", "tiny");
				if (length < 5) return randomChoice("short", "small");
				if (length < 7) return randomChoice("fair-sized", "nice");
				if (length < 9) {
					if (cockType == CockTypesEnum.HORSE) return randomChoice("sizable", "pony-sized", "colt-like");
					return randomChoice("sizable", "long", "lengthy");
				}
				if (length < 13) {
					if (cockType == CockTypesEnum.DOG) return randomChoice("huge", "foot-long", "mastiff-like");
					return randomChoice("huge", "foot-long", "cucumber-length");
				}
				if (length < 18) return randomChoice("massive", "knee-length", "forearm-length");
				if (length < 30) return randomChoice("enormous", "giant", "arm-like");
				if (cockType == CockTypesEnum.TENTACLE && rand(2) == 0) return "coiled";
				return randomChoice("towering", "freakish", "monstrous", "massive")
			}
			//Hornyness 1/2
			else if (lust > 75 && rand(2) == 0) {
				if (lust > 90) { //Uber horny like a baws!
					if (cumQ < 50) return randomChoice("throbbing", "pulsating"); //Weak as shit cum
					if (cumQ < 200) return randomChoice("dribbling", "leaking", "drooling"); //lots of cum? drippy.
					return randomChoice("very drippy", "pre-gushing", "cum-bubbling", "pre-slicked", "pre-drooling"); //Tons of cum
				}
				else {//A little less lusty, but still lusty.
					if (cumQ < 50) return randomChoice("turgid", "blood-engorged", "rock-hard", "stiff", "eager"); //Weak as shit cum
					if (cumQ < 200) return randomChoice("turgid", "blood-engorged", "rock-hard", "stiff", "eager", "fluid-beading", "slowly-oozing"); //A little drippy
					return randomChoice("dribbling", "drooling", "fluid-leaking", "leaking"); //uber drippy
				}
			}
			//Girth - fallback
			if (girth <= 0.75) return randomChoice("thin", "slender", "narrow");
			if (girth <= 1.2) return "ample";
			if (girth <= 1.4) return randomChoice("ample", "big");
			if (girth <= 2) return randomChoice("broad", "meaty", "girthy");
			if (girth <= 3.5) return randomChoice("fat", "distended", "wide");
			return randomChoice("inhumanly distended", "monstrously thick", "bloated");
		}

		//Cock adjectives for single cock
		private static function cockAdjectives(i_cockLength:Number, i_cockThickness:Number, i_cockType:CockTypesEnum, i_creature:Creature):String
		{
			var description:String = "";
			var rando:Number = 0;
			var descripts:Number = 0;
			//length or thickness, usually length.
			if (rand(4) == 0) {
				if (i_cockLength < 3) {
					rando = rand(3);
					if (rando == 0) description = "little";
					else if (rando == 1) description = "toy-sized";
					else description = "tiny";
				}
				else if (i_cockLength < 5) {
					if (rand(2) == 0) description = "short";
					else description = "small";
				}
				else if (i_cockLength < 7) {
					if (rand(2) == 0) description = "fair-sized";
					else description = "nice";
				}
				else if (i_cockLength < 9) {
					rando = rand(3);
					if (rando == 0) description = "long";
					else if (rando == 1) description = "lengthy";
					else if (rando == 2) description = "sizable";
				}
				else if (i_cockLength < 13) {
					if (rand(2) == 0) description = "huge";
					else description = "foot-long";
				}
				else if (i_cockLength < 18) {
					if (rand(2) == 0) description = "massive";
					else description = "forearm-length";
				}
				else if (i_cockLength < 30) {
					if (rand(2) == 0) description = "enormous";
					else description = "monster-length";
				}
				else {
					rando = rand(3);
					if (rando == 0) description = "towering";
					else if (rando == 1) description = "freakish";
					else description = "massive";
				}
				descripts = 1;
			}
			//thickness go!
			else if (rand(4) == 0 && descripts == 0) {
				if (i_cockThickness <= .75) description += "narrow";
				else if (i_cockThickness <= 1.1) description += "nice";
				else if (i_cockThickness <= 1.4) {
					if (rand(2) == 0) description += "ample";
					else description += "big";
				}
				else if (i_cockThickness <= 2) {
					if (rand(2) == 0) description += "broad";
					else description += "girthy";
				}
				else if (i_cockThickness <= 3.5) {
					if (rand(2) == 0) description += "fat";
					else description += "distended";
				}
				else {
					if (rand(2) == 0) description += "inhumanly distended";
					else description += "monstrously thick";
				}
				descripts = 1;
			}
			//Length/Thickness done.  Moving on to special animal characters/lust stuff.
			/*Animal Fillers - turned off due to duplication in noun segment
			 else if(type == 1 && descripts == 0 && rand(2) == 0) {
			 if(rand(2) == 0) descript += "flared ";
			 else descript += "musky ";
			 }
			 else if(type == 2 && descripts == 0 && rand(2) == 0) {
			 descript += "musky ";
			 }*/
			//FINAL FALLBACKS - lust descriptors
			//Lust stuff
			else if (i_creature.lust > 90) {
				//lots of cum? drippy.
				if (i_creature.cumQ() > 50 && i_creature.cumQ() < 200 && rand(2) == 0) {
					//for hroses and dogs
					if (i_cockType.Group == "animal") description += "animal-pre leaking";
					else description += "pre-slickened";
					descripts = 1;
				}
				//Tons of cum
				if (i_creature.cumQ() >= 200 && rand(2) == 0) {
					//for horses and dogs
					if (i_cockType.Group == "animal") description += "animal-spunk dripping";
					else description += "cum-drooling";
					descripts = 1;
				}
				//Not descripted? Pulsing and twitching
				if (descripts == 0) {
					if (rand(2) == 0) description += "throbbing";
					else description += "pulsating";
					descripts = 1;
				}
			}
			//A little less lusty, but still lusty.
			else if (i_creature.lust > 75) {
				if (descripts == 0 && i_creature.cumQ() > 50 && i_creature.cumQ() < 200 && rand(2) == 0) {
					description += "pre-leaking";
					descripts = 1;
				}
				if (descripts == 0 && i_creature.cumQ() >= 200 && rand(2) == 0) {
					description += "pre-cum dripping";
					descripts = 1;
				}
				if (descripts == 0) {
					if (rand(2) == 0) description += "rock-hard";
					else description += "eager";
					descripts = 1;
				}
			}
			//Not lusty at all, fallback adjective
			else if (i_creature.lust > 50) description += "hard";
			else description += "ready";
			return description;
		}

		public static function cockMultiNoun(cockType:CockTypesEnum):String
		{
			/*
			if (cockType is int) {
				trace("Someone is still calling cockNoun with an integer cock type");
				trace("Fix this shit already, dammit!");
				cockType = CockTypesEnum.ParseConstantByIndex(cockType);
			}
			*/
			var options:Array;
			var description:String = "";
			if (cockType == CockTypesEnum.HUMAN) {
				options = ["cock",
					"cock",
					"cock",
					"cock",
					"cock",
					"prick",
					"prick",
					"pecker",
					"shaft",
					"shaft",
					"shaft"];
				description += randomChoice(options);
			}
			else if (cockType == CockTypesEnum.BEE) {
				options = ["bee prick",
					"bee prick",
					"bee prick",
					"bee prick",
					"insectoid cock",
					"insectoid cock",
					"furred monster"];
				description += randomChoice(options);
			}
			else if (cockType == CockTypesEnum.DOG) {
				options = ["doggie dong",
					"canine shaft",
					"pointed prick",
					"dog-shaft",
					"dog-cock",
					"puppy-pecker",
					"dog-dick",
					"pointed shaft",
					"canine cock",
					"canine cock",
					"dog cock"];
				description += randomChoice(options);
			}
			else if (cockType == CockTypesEnum.FOX) {
				options = ["fox-shaped dong",
					"vulpine shaft",
					"pointed prick",
					"knotty fox-shaft",
					"knotty fox-cock",
					"vulpine-pecker",
					"pointed fox-dick",
					"pointed shaft",
					"vulpine cock",
					"vulpine cock",
					"fox cock"];
				description += randomChoice(options);
			}
			else if (cockType == CockTypesEnum.WOLF) {
				options = ["wolfie dong",
					"lupine shaft",
					"pointed prick",
					"wolf-shaft",
					"wolf-cock",
					"lupin-pecker",
					"wolf-dick",
					"pointed shaft",
					"lupine cock",
					"lupine cock",
					"wolf cock"];
				description += randomChoice(options);
			}
			else if (cockType == CockTypesEnum.HORSE) {
				options = ["horsecock",
					"equine prick",
					"horse-shaft",
					"horse-prick",
					"stallion-prick",
					"equine dong"];
				description += randomChoice(options);
			}
			else if (cockType == CockTypesEnum.DEMON) {
				options = ["demon-dick",
					"nubby shaft",
					"corrupted cock",
					"perverse pecker",
					"bumpy demon-dick",
					"demonic cock",
					"demonic dong",
					"cursed cock",
					"infernal prick",
					"unholy cock",
					"blighted cock"];
				description += randomChoice(options);
			}
			else if (cockType == CockTypesEnum.TENTACLE) {
				options = ["tentacle prick",
					"plant-like shaft",
					"tentacle cock",
					"cock-tendril",
					"tentacle pecker",
					"plant prick",
					"penile flora",
					"smooth inhuman shaft",
					"tentacle dick",
					"vine prick",
					"vine-like cock"];
				description += randomChoice(options);
			}
			else if (cockType == CockTypesEnum.STAMEN) {
				options = ["squirming cock-stamen",
					"plant-like stamen",
					"penile flora",
					"smooth shaft",
					"stamen-shaped cock"];
				description += randomChoice(options);
			}
			else if (cockType == CockTypesEnum.CAT) {
				options = ["feline dick",
					"cat-cock",
					"kitty-cock",
					"spiny prick",
					"pussy-prick",
					"cat-penis",
					"feline member",
					"spined shaft",
					"feline shaft",
					"'barbed' dick",
					"kitten-prick"];
				description += randomChoice(options);
			}
			else if (cockType == CockTypesEnum.LIZARD) {
				options = ["reptile-dick",
					"purple cock",
					"inhuman cock",
					"reptilian prick",
					"purple prick",
					"purple member",
					"serpentine member",
					"serpentine shaft",
					"reptilian shaft",
					"snake-shaft",
					"snake dick"];
				description += randomChoice(options);
			}
			else if (cockType == CockTypesEnum.CAVE_WYRM) {
				options = ["glowing reptile-dick",
					"luminescent neon blue cock",
					"glowing inhuman cock",
					"luminescent reptilian prick",
					"luminescent neon blue prick",
					"glowing neon blue member",
					"glowing serpentine member",
					"luminescent serpentine shaft",
					"glowing reptilian shaft",
					"glowing snake-shaft",
					"luminescent snake dick"];
				description += randomChoice(options);
			}
			else if (cockType == CockTypesEnum.RHINO) {
				options = ["oblong cock",
					"rhino dick",
					"rhino cock",
					"bulged rhino cock",
					"rhino penis",
					"rhink dong",
					"oblong penis",
					"oblong dong",
					"oblong dick"];
				description += randomChoice(options);
			}
			else {
				description += randomChoice("cock", "prick", "pecker", "shaft");
			}
			return description;
		}

		/**
		 * Describe creatures balls.
		 * @param    i_forcedSize    Force a description of the size of the balls
		 * @param    i_plural        Show plural forms
		 * @param    i_creature        Monster, Player or NonPlayer
		 * @param    i_withArticle    Show description with article in front
		 * @return    Full description of balls
		 */
		public static function ballsDescription(i_forcedSize:Boolean, i_plural:Boolean, i_creature:Creature, i_withArticle:Boolean = false):String
		{
			if (i_creature.balls == 0) return "prostate";

			var haveDescription:Boolean = false;
			var rando:Number = 0;
			var description:String = "";
			var options:Array;

			if (i_plural && (!i_creature.hasStatusEffect(StatusEffects.Uniball))) {
				if (i_creature.balls == 1) {
					if (i_withArticle) {
						options = ["a single",
							"a solitary",
							"a lone",
							"an individual"];
					}
					else {
						options = ["single",
							"solitary",
							"lone",
							"individual"];
					}
					description += randomChoice(options);
				}
				else if (i_creature.balls == 2) {
					if (i_withArticle) {
						options = ["a pair of",
							"two",
							"a duo of"];
					}
					else {
						options = ["pair of",
							"two",
							"duo of"];
					}
					description += randomChoice(options);
				}
				else if (i_creature.balls == 3) {
					options = ["three",
						"triple"];
					(i_withArticle) ? options.push("a trio of") : options.push("trio of");
					description += randomChoice(options);
				}
				else if (i_creature.balls == 4) {
					options = ["four",
						"quadruple"];
					(i_withArticle) ? options.push("a quartette of") : options.push("quartette of");
					description += randomChoice(options);
				}
				else {
					if (i_withArticle) {
						options = ["a multitude of",
							"many",
							"a large handful of"];
					}
					else {
						options = ["multitude of",
							"many",
							"large handful of"];
					}
					description += randomChoice(options);
				}
			}
			//size!
			if (i_creature.ballSize > 1 && (rand(3) <= 1 || i_forcedSize)) {
				if (description) description += " ";

				if (i_creature.ballSize >= 18)
					description += "hideously swollen and oversized";
				else if (i_creature.ballSize >= 15)
					description += "beachball-sized";
				else if (i_creature.ballSize >= 12)
					description += "watermelon-sized";
				else if (i_creature.ballSize >= 9)
					description += "basketball-sized";
				else if (i_creature.ballSize >= 7)
					description += "soccerball-sized";
				else if (i_creature.ballSize >= 5)
					description += "cantaloupe-sized";
				else if (i_creature.ballSize >= 4)
					description += "grapefruit-sized";
				else if (i_creature.ballSize >= 3)
					description += "apple-sized";
				else if (i_creature.ballSize >= 2)
					description += "baseball-sized";
				else if (i_creature.ballSize > 1)
					description += "large";

			}
			//UNIBALL
			if (i_creature.hasStatusEffect(StatusEffects.Uniball)) {
				if (description) description += " ";
				options = ["tightly-compressed",
					"snug",
					"cute",
					"pleasantly squeezed",
					"compressed-together"];
				description += randomChoice(options);

			}
			//Descriptive
			if (i_creature.hoursSinceCum >= 48 && rand(2) == 0 && !i_forcedSize) {
				if (description) description += " ";
				options = ["overflowing",
					"swollen",
					"cum-engorged"];
				description += randomChoice(options);

			}
			//lusty
			if (i_creature.lust > 90 && (description == "") && rand(2) == 0 && !i_forcedSize) {
				options = ["eager",
					"full",
					"needy",
					"desperate",
					"throbbing",
					"heated",
					"trembling",
					"quivering",
					"quaking"];
				description += randomChoice(options);

			}
			//Slimy skin
			if (i_creature.hasGooSkin()) {
				if (description) description += " ";
				options = ["goopey",
					"gooey",
					"slimy"];
				description += randomChoice(options);
			}
			//Ghost skin
			if (i_creature.hasGhostSkin()) {
				if (description) description += " ";
				options = ["transparent"];
				description += randomChoice(options);
			}
			if (description) description += " ";

			options = ["nut",
				"gonad",
				"teste",
				"testicle",
				"testicle",
				"ball",
				"ball",
				"ball"];

			// I don't know how this was ever supposed to work.
			//if (i_creature.balls == 4 && i_plural) options.push("quads", "quads", "quads");

			description += randomChoice(options);
			if (i_plural) description += "s";

			if (i_creature.hasStatusEffect(StatusEffects.Uniball) && rand(2) == 0) {
				if (rand(3) == 0)
					description += " merged into a cute, spherical package";
				else if (rand(2) == 0)
					description += " combined into a round, girlish shape";
				else
					description += " squeezed together into a perky, rounded form";
			}
			return description;
		}

		//Returns random description of scrotum
		public static function sackDescript(i_creature:Creature):String
		{
			if (i_creature.balls == 0) return "prostate";

			var options:Array;
			var description:String = "";

			options = ["scrotum",
				"sack",
				"nutsack",
				"ballsack",
				"beanbag",
				"pouch"];

			description += randomChoice(options);

			return description;
		}

		public static function vaginaDescript(i_creature:Creature, i_vaginaIndex:Number = 0, forceDesc:Boolean=false):String
		{
			if (i_vaginaIndex > (i_creature.vaginas.length - 1)) {
				CoC_Settings.error("<B>Error: Invalid vagina number (" + i_vaginaIndex + ") passed to vaginaDescript()</b>");
				return "<B>Error: Invalid vagina number (" + i_vaginaIndex + ") passed to vaginaDescript()</b>";
			}
			if (i_vaginaIndex < 0) {
				CoC_Settings.error("<B>Error: Invalid vaginaNum (" + i_vaginaIndex + ") passed to vaginaDescript()</b>");
				return "<B>Error: Invalid vaginaNum (" + i_vaginaIndex + ") passed to vaginaDescript()</b>";
			}
			if (i_creature.vaginas.length <= 0) {
				CoC_Settings.error("ERROR: Called vaginaDescription with no vaginas");
				return "ERROR: Called vaginaDescription with no vaginas";
			}

			var description:String = "";
			var weighting:Number = 0;
			var haveDescription:Boolean = false;
			var options:Array;

			//Very confusing way to display values.
			if (i_creature.vaginas[i_vaginaIndex].vaginalLooseness == 0) weighting = 61;
			if (i_creature.vaginas[i_vaginaIndex].vaginalLooseness == 4 || i_creature.vaginas[i_vaginaIndex].vaginalLooseness == 5) weighting = 10;

			//tightness descript - 40% display rate
			if (forceDesc || rand(100) + weighting > 60) {
				if (i_creature.vaginas[i_vaginaIndex].vaginalLooseness == 0) {
					if (i_creature.vaginas[i_vaginaIndex].virgin) description += "virgin";
					else description += "tight";
				}
				if (i_creature.vaginas[i_vaginaIndex].vaginalLooseness == 2)
					description += "loose";
				if (i_creature.vaginas[i_vaginaIndex].vaginalLooseness == 3)
					description += "very loose";
				if (i_creature.vaginas[i_vaginaIndex].vaginalLooseness == 4)
					description += "gaping";
				if (i_creature.vaginas[i_vaginaIndex].vaginalLooseness == 5)
					description += "gaping-wide";

			}
			//wetness descript - 30% display rate
			if (forceDesc || rand(100) + weighting > 70) {
				if (description != "") description += ", ";
				if (i_creature.vaginas[i_vaginaIndex].vaginalWetness == 0)
					description += "dry";
				if (i_creature.vaginas[i_vaginaIndex].vaginalWetness == 1)
					description += "moist";
				if (i_creature.vaginas[i_vaginaIndex].vaginalWetness == 2)
					description += "wet";
				if (i_creature.vaginas[i_vaginaIndex].vaginalWetness == 3)
					description += "slick";
				if (i_creature.vaginas[i_vaginaIndex].vaginalWetness == 4)
					description += "drooling";
				if (i_creature.vaginas[i_vaginaIndex].vaginalWetness == 5)
					description += "slavering";
			}
			if (i_creature.vaginas[i_vaginaIndex].labiaPierced > 0 && (forceDesc || rand(3) == 0)) {
				if (description != "") description += ", ";
				description += "pierced";
			}
			if (description == "" && i_creature.hasGooSkin()) {
				if (description != "")
					description += ", ";
				if (rand(2) == 0)
					description += "gooey";
				else
					description += "slimy";
			}
			if (description == "" && i_creature.hasGhostSkin()) {
				if (description != "")
					description += ", ";
				description += "transparent";
			}
			if (i_creature.vaginaType() == 5 && (forceDesc || Math.floor(Math.random() * 2) == 0)) {
				if (description != "") description += ", ";
				options = ["black",
					"onyx",
					"ebony",
					"dusky",
					"sable",
					"obsidian",
					"midnight-hued",
					"jet black"];
				description += randomChoice(options);
			}
			if (i_creature.vaginaType() == 6 && (forceDesc || Math.floor(Math.random() * 2) == 0)) {
				if (description != "") description += ", ";
				options = ["neon blue luminescent",
					"neon blue glowing"];
				description += randomChoice(options);
			}

			if (description != "")
				description += " ";

			if (CoC.instance.flags[kFLAGS.SFW_MODE] > 0) { //Removes something that might offend sensitive people.
				options = ["vagina",
				"pussy",
				"cooter",
				"snatch",
				"muff"];
			}
			else {
				options = ["vagina",
				"pussy",
				"cooter",
				"twat",
				"cunt",
				"snatch",
				"fuck-hole",
				"muff"];
			}
			description += randomChoice(options);
			//Something that would be nice to have but needs a variable in Creature or Character.
			//if(i_creature.bunnyScore() >= 3) description += "rabbit hole";

			return description;
		}

		public static function clitDescription(i_creature:Creature):String
		{
			var description:String = "";
			var options:Array;
			var haveDescription:Boolean = false;
			//Length Adjective - 50% chance
			if (rand(2) == 0) {
				//small clits!
				if (i_creature.clitLength <= .5) {
					options = ["tiny ",
						"little ",
						"petite ",
						"diminutive ",
						"miniature "];
					description += randomChoice(options);
				}
				//"average".
				if (i_creature.clitLength > .5 && i_creature.clitLength < 1.5) {
					//no size comment
				}
				//Biggies!
				if (i_creature.clitLength >= 1.5 && i_creature.clitLength < 4) {
					options = ["large ",
						"large ",
						"substantial ",
						"substantial ",
						"considerable "];
					description += randomChoice(options);
				}
				//'Uge
				if (i_creature.clitLength >= 4) {
					options = ["monster ",
						"tremendous ",
						"colossal ",
						"enormous ",
						"bulky "];
					description += randomChoice(options);
				}
			}
			//Descriptive descriptions - 50% chance of being called
			if (rand(2) == 0) {
				//Doggie descriptors - 50%
				//TODO Conditionals don't make sense, need to introduce a class variable to keep of "something" or move race or Creature/Character
				if (i_creature.hasFur() > 2 && !haveDescription && rand(2) == 0) {
					description += "bitch-";
					haveDescription = true;
				}
				/*Horse descriptors - 50%
				 if(creature.skinType == 1 > 2 && !descripted && rand(2) == 0) {
				 descripted = true;
				 descript += "mare-";
				 }*/
				//Horny descriptors - 75% chance
				if (i_creature.lust > 70 && rand(4) < 3 && !haveDescription) {
					options = ["throbbing ",
						"pulsating ",
						"hard "];
					description += randomChoice(options);
					haveDescription = true;
				}
				//High libido - always use if no other descript
				if (i_creature.lib > 50 && rand(2) == 0 && !haveDescription) {
					options = ["insatiable ",
						"greedy ",
						"demanding ",
						"rapacious "];
					description += randomChoice(options);
					haveDescription = true;
				}
			}
			if (i_creature.hasVagina()) {
				if (!haveDescription && i_creature.vaginas[0].clitPierced > 0) {
					description += "pierced ";
					haveDescription = true;
				}
			}
			else {
				CoC_Settings.error("ERROR: CLITDESCRIPT WITH NO CLIT");
				return("ERROR: CLITDESCRIPT WITH NO CLIT");
			}

			//Clit nouns
			options = ["clit",
				"clitty",
				"button",
				"pleasure-buzzer",
				"clit",
				"clitty",
				"button",
				"clit",
				"clit",
				"button"];
			if (CoC.instance.flags[kFLAGS.SFW_MODE] > 0) {
				options = ["bump", "button"];
			}
			description += randomChoice(options);

			return description;
		}

		/**
		 * Gives a full description of a Character's butt.
		 * Be aware that it only supports Characters, not all Creatures.
		 * @param    i_creature
		 * @return    A full description of a Character's butt.
		 */
		public static function buttDescription(i_creature:Creature):String
		{
			var description:String    = "";
			var options:Array;
			var i_character:Character = i_creature as Character;
			var tone:Number           = i_character ? i_character.tone : 50;
			var buttRating:Number     = i_creature.butt.type;
			if (buttRating <= 1) {
				if (tone >= 60)
					description += "incredibly tight, perky ";
				else {
					options = ["tiny",
						"very small",
						"dainty"];
					description = randomChoice(options);
					//Soft PC's buns!
					if (tone <= 30 && rand(3) == 0) description += " yet soft";
					description += " ";
				}
			}
			if (buttRating > 1 && buttRating < 4) {
				if (tone >= 65) {
					options = ["perky, muscular ",
						"tight, toned ",
						"compact, muscular ",
						"tight ",
						"muscular, toned "];
					description = randomChoice(options);
				}
				//Nondescript
				else if (tone >= 30) {
					options = ["tight ",
						"firm ",
						"compact ",
						"petite "];
					description = randomChoice(options);
				}
				//FLABBAH
				else {
					options = ["small, heart-shaped ",
						"soft, compact ",
						"soft, heart-shaped ",
						"small, cushy ",
						"small ",
						"petite ",
						"snug ", ];
					description = randomChoice(options);
				}
			}
			if (buttRating >= 4 && buttRating < 6) {
				//TOIGHT LIKE A TIGER
				if (tone >= 65) {
					options = ["nicely muscled ",
						"nice, toned ",
						"muscly ",
						"nice toned ",
						"toned ",
						"fair "];
					description = randomChoice(options);
				}
				//Nondescript
				else if (tone >= 30) {
					options = ["nice ",
						"fair "];
					description = randomChoice(options);
				}
				//FLABBAH
				else {
					options = ["nice, cushiony ",
						"soft ",
						"nicely-rounded, heart-shaped ",
						"cushy ",
						"soft, squeezable "];
					description = randomChoice(options);
				}
			}
			if (buttRating >= 6 && buttRating < 8) {
				//TOIGHT LIKE A TIGER
				if (tone >= 65) {
					options = ["full, toned ",
								"muscly handful of ",
								"shapely, toned ",
								"muscular, hand-filling ",
								"shapely, chiseled ",
								"full ",
								"chiseled "];
					description = randomChoice(options);
				}
				//Nondescript
				else if (tone >= 30) {
					options = ["handful of ",
						"full ",
						"shapely ",
						"hand-filling "];
					description = randomChoice(options);
				}
				//FLABBAH
				else {
					if (rand(8) == 0) return "supple, handful of ass";
					options = ["somewhat jiggly ",
						"soft, hand-filling ",
						"cushiony, full ",
						"plush, shapely ",
						"full ",
						"soft, shapely ",
						"rounded, spongy "];
					description = randomChoice(options);
				}
			}
			if (buttRating >= 8 && buttRating < 10) {
				//TOIGHT LIKE A TIGER
				if (tone >= 65) {
					options = ["large, muscular ",
						"substantial, toned ",
						"big-but-tight ",
						"squeezable, toned ",
						"large, brawny ",
						"big-but-fit ",
						"powerful, squeezable ",
						"large "];
					description = randomChoice(options);
				}
				//Nondescript
				else if (tone >= 30) {
					options = ["squeezable ",
						"large ",
						"substantial "];
					description = randomChoice(options);
				}
				//FLABBAH
				else {
					options = ["large, bouncy ",
						"soft, eye-catching ",
						"big, slappable ",
						"soft, pinchable ",
						"large, plush ",
						"squeezable ",
						"cushiony ",
						"plush ",
						"pleasantly plump "];
					description = randomChoice(options);
				}
			}
			if (buttRating >= 10 && buttRating < 13) {
				//TOIGHT LIKE A TIGER
				if (tone >= 65) {
					options = ["thick, muscular ",
						"big, burly ",
						"heavy, powerful ",
						"spacious, muscular ",
						"toned, cloth-straining ",
						"thick ",
						"thick, strong "];
					description = randomChoice(options);
				}
				//Nondescript
				else if (tone >= 30) {
					options = ["jiggling ",
						"spacious ",
						"heavy ",
						"cloth-straining "];
					description = randomChoice(options);
				}
				//FLABBAH
				else {
					options = ["super-soft, jiggling ",
						"spacious, cushy ",
						"plush, cloth-straining ",
						"squeezable, over-sized ",
						"spacious ",
						"heavy, cushiony ",
						"slappable, thick ",
						"jiggling ",
						"spacious ",
						"soft, plump "];
					description = randomChoice(options);
				}
			}
			if (buttRating >= 13 && buttRating < 16) {
				//TOIGHT LIKE A TIGER
				if (tone >= 65) {
					options = ["expansive, muscled ",
						"voluminous, rippling ",
						"generous, powerful ",
						"big, burly ",
						"well-built, voluminous ",
						"powerful ",
						"muscular ",
						"powerful, expansive "];
					description = randomChoice(options);
				}
				//Nondescript
				else if (tone >= 30) {
					options = ["expansive ",
						"generous ",
						"voluminous ",
						"wide "];
					description = randomChoice(options);
				}
				//FLABBAH
				else {
					options = ["pillow-like ",
						"generous, cushiony ",
						"wide, plush ",
						"soft, generous ",
						"expansive, squeezable ",
						"slappable ",
						"thickly-padded ",
						"wide, jiggling ",
						"wide ",
						"voluminous ",
						"soft, padded "];
					description = randomChoice(options);
				}
			}
			if (buttRating >= 16 && buttRating < 20) {
				if (tone >= 65) {
					options = ["huge, toned ",
						"vast, muscular ",
						"vast, well-built ",
						"huge, muscular ",
						"strong, immense ",
						"muscle-bound "];
					description = randomChoice(options);
				}
				//Nondescript
				else if (tone >= 30) {
					if (rand(5) == 0) return "jiggling expanse of ass";
					if (rand(5) == 0) return "copious ass-flesh";
					options = ["huge ",
						"vast ",
						"giant "];
					description = randomChoice(options);
				}
				//FLABBAH
				else {
					options = ["vast, cushiony ",
						"huge, plump ",
						"expansive, jiggling ",
						"huge, cushiony ",
						"huge, slappable ",
						"seam-bursting ",
						"plush, vast ",
						"giant, slappable ",
						"giant ",
						"huge ",
						"swollen, pillow-like "];
					description = randomChoice(options);
				}
			}
			if (buttRating >= 20) {
				if (tone >= 65) {
					if (rand(7) == 0) return "colossal, muscly ass";
					options = ["ginormous, muscle-bound ",
						"colossal yet toned ",
						"strong, tremdously large ",
						"tremendous, muscled ",
						"ginormous, toned ",
						"colossal, well-defined "];
					description = randomChoice(options);
				}
				//Nondescript
				else if (tone >= 30) {
					options = ["ginormous ",
						"colossal ",
						"tremendous ",
						"gigantic "];
					description = randomChoice(options);
				}
				//FLABBAH
				else {
					options = ["ginormous, jiggly ",
						"plush, ginormous ",
						"seam-destroying ",
						"tremendous, rounded ",
						"bouncy, colossal ",
						"thong-devouring ",
						"tremendous, thickly padded ",
						"ginormous, slappable ",
						"gigantic, rippling ",
						"gigantic ",
						"ginormous ",
						"colossal ",
						"tremendous "];
					description = randomChoice(options);
				}
			}
			options = ["butt",
						"butt",
						"butt",
						"butt",
						"ass",
						"ass",
						"ass",
						"ass",
						"backside",
						"backside",
						"derriere",
						"rump",
						"bottom"];

			description += randomChoice(options);
			//if(rando == 2) desc += "cheeks";
			return description;
		}

		/**
		 * Gives a short description of a creature's butt.
		 * Different from buttDescription in that it supports all creatures, not just characters.
		 * Warning, very judgemental.
		 * @param    creature
		 * @return Short description of a butt.
		 */
		public static function buttDescriptionShort(i_creature:Creature):String
		{
			var description:String = "";
			var options:Array;
			if (i_creature.butt.type <= 1) {
				options = ["insignificant ",
					"very small "];
				description = randomChoice(options);
			}
			if (i_creature.butt.type > 1 && i_creature.butt.type < 4) {
				options = ["tight ",
					"firm ",
					"compact "];
				description = randomChoice(options);
			}
			if (i_creature.butt.type >= 4 && i_creature.butt.type < 6) {
				options = ["regular ",
					"unremarkable "];
				description = randomChoice(options);
			}
			if (i_creature.butt.type >= 6 && i_creature.butt.type < 8) {
				if (rand(3) == 0) return "handful of ass";
				options = ["full ",
					"shapely "];
				description = randomChoice(options);
			}
			if (i_creature.butt.type >= 8 && i_creature.butt.type < 10) {
				options = ["squeezable ",
					"large ",
					"substantial "];
				description = randomChoice(options);
			}
			if (i_creature.butt.type >= 10 && i_creature.butt.type < 13) {
				options = ["jiggling ",
					"spacious ",
					"heavy "];
				description = randomChoice(options);
			}
			if (i_creature.butt.type >= 13 && i_creature.butt.type < 16) {
				if (rand(3) == 0) return "generous amount of ass";
				options = ["expansive ",
					"voluminous "];
				description = randomChoice(options);
			}
			if (i_creature.butt.type >= 16 && i_creature.butt.type < 20) {
				if (rand(3) == 2) return "jiggling expanse of ass";
				options = ["huge ",
					"vast "];
				description = randomChoice(options);
			}
			if (i_creature.butt.type >= 20) {
				options = ["ginormous ",
					"colossal ",
					"tremendous "];
				description = randomChoice(options);
			}
			options = ["butt ",
				"ass "];
			description += randomChoice(options);
			if (rand(2) == 0) description += "cheeks";
			return description;
		}

		public static function assholeDescript(i_creature:Creature, forceDesc:Boolean=false):String
		{
			var description:String = "";

			// The way this was setup didn't work. Trying to inline-define object key-values wasn't looking up the variable *VALUES* it was using the string representation
			// of the variable name as the key.
			// ie, querying ANAL_WETNESS_DESCRIPTORS[0] would actually return "undefined" rather than "".
			// This is just fucking awful but I'm just making things work in the face of bugs I'm running into.

			// 66% Wetness Descript
			var ANAL_WETNESS_DESCRIPTORS:Object                       = new Object();
			ANAL_WETNESS_DESCRIPTORS[AssClass.WETNESS_DRY]            = "";
			ANAL_WETNESS_DESCRIPTORS[AssClass.WETNESS_NORMAL]         = "";
			ANAL_WETNESS_DESCRIPTORS[AssClass.WETNESS_MOIST]          = "moist ";
			ANAL_WETNESS_DESCRIPTORS[AssClass.WETNESS_SLIMY]          = "slimy ";
			ANAL_WETNESS_DESCRIPTORS[AssClass.WETNESS_DROOLING]       = "drooling ";
			ANAL_WETNESS_DESCRIPTORS[AssClass.WETNESS_SLIME_DROOLING] = "slime-drooling ";

			if (forceDesc || rand(3) <= 1)
			{
				description += ANAL_WETNESS_DESCRIPTORS[i_creature.ass.analWetness];
			}

			var ANAL_TIGHTNESS_DESCRIPTORS:Object                    = new Object();
			ANAL_TIGHTNESS_DESCRIPTORS[AssClass.LOOSENESS_VIRGIN]    = "virgin ";
			ANAL_TIGHTNESS_DESCRIPTORS[AssClass.LOOSENESS_TIGHT]     = "tight ";
			ANAL_TIGHTNESS_DESCRIPTORS[AssClass.LOOSENESS_NORMAL]    = "loose ";
			ANAL_TIGHTNESS_DESCRIPTORS[AssClass.LOOSENESS_LOOSE]     = "roomy ";
			ANAL_TIGHTNESS_DESCRIPTORS[AssClass.LOOSENESS_STRETCHED] = "stretched ";
			ANAL_TIGHTNESS_DESCRIPTORS[AssClass.LOOSENESS_GAPING]    = "gaping ";

			//25% tightness description
			if (forceDesc || rand(4) == 0 || (i_creature.ass.analLooseness <= 1 && rand(4) <= 2))
			{
				description += ANAL_TIGHTNESS_DESCRIPTORS[i_creature.ass.analLooseness];
			}

			//asshole descriptor
			if (CoC.instance.flags[kFLAGS.SFW_MODE] > 0) {
			description += randomChoice("rear end",
					"backdoor");
			}
			else {
			description += randomChoice("ass",
					"anus",
					"pucker",
					"backdoor",
					"asshole",
					"butthole");
			}
			return description;
		}

		public static function wingsDescript(i_creature:Creature):String
		{
			return Wings.Types[i_creature.wings.type].name + " wings";
		}
		public static function eyesDescript(i_creature:Creature):String
		{
			var description:String = "";
			description += i_creature.eyes.colour;
			description += " " + Eyes.Types[i_creature.eyes.type].name;
			if (i_creature.eyes.type == Eyes.CAVE_WYRM) description += " that glow in the dark"
			description += " eyes"
			return description;
		}
		public static function earsDescript(i_creature:Creature):String
		{
			return Ears.Types[i_creature.ears.type].name + " ears";
		}
		public static function antennaeDescript(i_creature:Creature):String
		{
			return Antennae.Types[i_creature.antennae.type].name + " antennae";
		}

		public static const BREAST_CUP_NAMES:Array = [
			"flat",//0
			//				1			2			3			4			5				6			7		8			9
			"A-cup", "B-cup", "C-cup", "D-cup", "DD-cup", "big DD-cup", "E-cup", "big E-cup", "EE-cup",// 1-9
			"big EE-cup", "F-cup", "big F-cup", "FF-cup", "big FF-cup", "G-cup", "big G-cup", "GG-cup", "big GG-cup", "H-cup",//10-19
			"big H-cup", "HH-cup", "big HH-cup", "HHH-cup", "I-cup", "big I-cup", "II-cup", "big II-cup", "J-cup", "big J-cup",//20-29
			"JJ-cup", "big JJ-cup", "K-cup", "big K-cup", "KK-cup", "big KK-cup", "L-cup", "big L-cup", "LL-cup", "big LL-cup",//30-39
			"M-cup", "big M-cup", "MM-cup", "big MM-cup", "MMM-cup", "large MMM-cup", "N-cup", "large N-cup", "NN-cup", "large NN-cup",//40-49
			"O-cup", "large O-cup", "OO-cup", "large OO-cup", "P-cup", "large P-cup", "PP-cup", "large PP-cup", "Q-cup", "large Q-cup",//50-59
			"QQ-cup", "large QQ-cup", "R-cup", "large R-cup", "RR-cup", "large RR-cup", "S-cup", "large S-cup", "SS-cup", "large SS-cup",//60-69
			"T-cup", "large T-cup", "TT-cup", "large TT-cup", "U-cup", "large U-cup", "UU-cup", "large UU-cup", "V-cup", "large V-cup",//70-79
			"VV-cup", "large VV-cup", "W-cup", "large W-cup", "WW-cup", "large WW-cup", "X-cup", "large X-cup", "XX-cup", "large XX-cup",//80-89
			"Y-cup", "large Y-cup", "YY-cup", "large YY-cup", "Z-cup", "large Z-cup", "ZZ-cup", "large ZZ-cup", "ZZZ-cup", "large ZZZ-cup",//90-99
			//HYPER ZONE
			"hyper A-cup", "hyper B-cup", "hyper C-cup", "hyper D-cup", "hyper DD-cup", "hyper big DD-cup", "hyper E-cup", "hyper big E-cup", "hyper EE-cup",//100-109
			"hyper big EE-cup", "hyper F-cup", "hyper big F-cup", "hyper FF-cup", "hyper big FF-cup", "hyper G-cup", "hyper big G-cup", "hyper GG-cup", "hyper big GG-cup", "hyper H-cup",//110-119
			"hyper big H-cup", "hyper HH-cup", "hyper big HH-cup", "hyper HHH-cup", "hyper I-cup", "hyper big I-cup", "hyper II-cup", "hyper big II-cup", "hyper J-cup", "hyper big J-cup",//120-129
			"hyper JJ-cup", "hyper big JJ-cup", "hyper K-cup", "hyper big K-cup", "hyper KK-cup", "hyper big KK-cup", "hyper L-cup", "hyper big L-cup", "hyper LL-cup", "hyper big LL-cup",//130-139
			"hyper M-cup", "hyper big M-cup", "hyper MM-cup", "hyper big MM-cup", "hyper MMM-cup", "hyper large MMM-cup", "hyper N-cup", "hyper large N-cup", "hyper NN-cup", "hyper large NN-cup",//140-149
			"hyper O-cup", "hyper large O-cup", "hyper OO-cup", "hyper large OO-cup", "hyper P-cup", "hyper large P-cup", "hyper PP-cup", "hyper large PP-cup", "hyper Q-cup", "hyper large Q-cup",//150-159
			"hyper QQ-cup", "hyper large QQ-cup", "hyper R-cup", "hyper large R-cup", "hyper RR-cup", "hyper large RR-cup", "hyper S-cup", "hyper large S-cup", "hyper SS-cup", "hyper large SS-cup",//160-169
			"hyper T-cup", "hyper large T-cup", "hyper TT-cup", "hyper large TT-cup", "hyper U-cup", "hyper large U-cup", "hyper UU-cup", "hyper large UU-cup", "hyper V-cup", "hyper large V-cup",//170-179
			"hyper VV-cup", "hyper large VV-cup", "hyper W-cup", "hyper large W-cup", "hyper WW-cup", "hyper large WW-cup", "hyper X-cup", "hyper large X-cup", "hyper XX-cup", "hyper large XX-cup",//180-189
			"hyper Y-cup", "hyper large Y-cup", "hyper YY-cup", "hyper large YY-cup", "hyper Z-cup", "hyper large Z-cup", "hyper ZZ-cup", "hyper large ZZ-cup", "hyper ZZZ-cup", "hyper large ZZZ-cup",//190-199
			"jacques00-cup", "lia-cup"
		];

		public static function breastCup(size:Number):String
		{
			return BREAST_CUP_NAMES[Math.min(Math.floor(size), BREAST_CUP_NAMES.length - 1)];
		}

		/**
		 * Returns breast size from cup name.
		 * Acceptable input: "flat","A","B","C","D","DD","DD+",... "ZZZ","ZZZ+" or exact match from BREAST_CUP_NAMES array
		 */
		public static function breastCupInverse(name:String, defaultValue:Number = 0):Number
		{
			if (name.length == 0) return defaultValue;
			if (name == "flat") return 0;
			var big:Boolean = name.charAt(name.length - 1) == "+";
			if (big) name = name.substr(0, name.length - 1);
			for (var i:int = 0; i < BREAST_CUP_NAMES.length; i++) {
				if (name == BREAST_CUP_NAMES[i]) return i;
				if (BREAST_CUP_NAMES[i].indexOf(name) == 0) return i + (big ? 1 : 0);
			}
			return defaultValue;
		}



		public static const DEFAULT_GENDER_NAMES:Object = createMapFromPairs(
				[
					[Gender.GENDER_NONE, "genderless"],
					[Gender.GENDER_MALE, "male"],
					[Gender.GENDER_FEMALE, "female"],
					[Gender.GENDER_HERM, "hermaphrodite"]
				]
		);
		public static const DEFAULT_WING_DESCS:Object = createMapFromPairs(
				[
					[Wings.NONE, "non-existant"],
					[Wings.BEE_LIKE_SMALL, "small bee-like"],
					[Wings.BEE_LIKE_LARGE, "large bee-like"],
					[Wings.HARPY, "large feathery"],
					[Wings.IMP, "small"],
					[Wings.BAT_LIKE_TINY, "tiny, bat-like"],
					[Wings.BAT_LIKE_LARGE, "large, bat-like"],
				//	[SHARK_FIN, ""],
					[Wings.FEATHERED_LARGE, "large, feathered"],
					[Wings.DRACONIC_SMALL, "small, draconic"],
					[Wings.DRACONIC_LARGE, "large, draconic"],
					[Wings.SEADRAGON, "large, aquatic"],
					[Wings.GIANT_DRAGONFLY, "giant dragonfly"],
					[Wings.BAT_LIKE_LARGE_2, "two large pairs of bat-like"],
					[Wings.DRACONIC_HUGE, "large, majestic draconic"],
					[Wings.FEATHERED_PHOENIX, "large crimson feathered"],
					[Wings.FEATHERED_ALICORN, "large white feathered"],
					[Wings.FEATHERED_SPHINX, "large feathered"],
					[Wings.MANTIS_LIKE_SMALL, "small mantis-like"],
					[Wings.MANTIS_LIKE_LARGE, "large mantis-like"],
					[Wings.MANTIS_LIKE_LARGE_2, "two large pairs of mantis-like"],
					[Wings.GARGOYLE_LIKE_LARGE, "large stony"],
					[Wings.PLANT, "three pairs of cockvines"],
					[Wings.MANTICORE_LIKE_SMALL, "small manticore-like"],
					[Wings.MANTICORE_LIKE_LARGE, "large manticore-like"],
					[Wings.FEY_DRAGON_WINGS, "large majestic fey draconic"],
					[Wings.FEATHERED_AVIAN, "large feathery"],
					[Wings.NIGHTMARE, "large leathery"],
					[Wings.ETHEREAL_WINGS, "etheral tendrils"],
					[Wings.THUNDEROUS_AURA, "thunderous aura"],
					[Wings.LEVITATION, "levitation"],
					[Wings.FAIRY, "butterfly"],
				]
		);
		// <mod name="Dragon patch" author="Stadler76">
		public static const DEFAULT_PIERCING_NAMES:Object = createMapFromPairs(
				[
					[Piercing.NONE, "none"],
					[Piercing.STUD, "stud"],
					[Piercing.RING, "ring"],
					[Piercing.LADDER, "ladder"],
					[Piercing.HOOP, "hoop"],
					[Piercing.CHAIN, "chain"]
				]
		);
		public static const DEFAULT_VAGINA_TYPE_NAMES:Object = createMapFromPairs(
				[
					[VaginaClass.HUMAN, "human"],
					[VaginaClass.EQUINE, "equine"],
					[VaginaClass.BLACK_SAND_TRAP, "black sandtrap"],
					[VaginaClass.CAVE_WYRM, "acidic"],
					[VaginaClass.VENOM_DRIPPING, "venom dripping"],
					[VaginaClass.MANTICORE, "ultrasensitive"],
					[VaginaClass.CANCER, "foaming"],
					[VaginaClass.DEMONIC, "fiendish"],
					[VaginaClass.ALRAUNE, "floral"],
					[VaginaClass.SCYLLA, "maw-like"],
					[VaginaClass.NAGA, "deep"]
				]
		);

		public static const DEFAULT_VAGINA_WETNESS_SCALES:Array = [
			[VaginaClass.WETNESS_DRY, "dry"],
			[VaginaClass.WETNESS_NORMAL, "normal"],
			[VaginaClass.WETNESS_WET, "wet"],
			[VaginaClass.WETNESS_SLICK, "slick"],
			[VaginaClass.WETNESS_DROOLING, "drooling"],
			[VaginaClass.WETNESS_SLAVERING, "slavering"],
		];
		public static const DEFAULT_VAGINA_LOOSENESS_SCALES:Array = [
			[VaginaClass.LOOSENESS_TIGHT, "tight"],
			[VaginaClass.LOOSENESS_NORMAL, "normal"],
			[VaginaClass.LOOSENESS_LOOSE, "loose"],
			[VaginaClass.LOOSENESS_GAPING, "gaping"],
			[VaginaClass.LOOSENESS_GAPING_WIDE, "gaping wide"],
			[VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR, "clown-car level"]
		];
		public static const DEFAULT_ANAL_WETNESS_SCALES:Array = [
			[AssClass.WETNESS_DRY, "dry"],
			[AssClass.WETNESS_NORMAL, "normal"],
			[AssClass.WETNESS_MOIST, "moist"],
			[AssClass.WETNESS_SLIMY, "slimym"],
			[AssClass.WETNESS_DROOLING, "drooling"],
			[AssClass.WETNESS_SLIME_DROOLING, "slime-drooling"],
		];
		public static const DEFAULT_ANAL_LOOSENESS_SCALES:Array = [
			[AssClass.LOOSENESS_VIRGIN, "virgin"],
			[AssClass.LOOSENESS_TIGHT, "tight"],
			[AssClass.LOOSENESS_NORMAL, "normal"],
			[AssClass.LOOSENESS_LOOSE, "loose"],
			[AssClass.LOOSENESS_STRETCHED, "stretched"],
			[AssClass.LOOSENESS_GAPING, "gaping"]
		];
		public static const DEFAULT_HIP_RATING_SCALES:Array = [
			[Hips.RATING_BOYISH, "boyish"],
			[Hips.RATING_SLENDER, "slender"],
			[Hips.RATING_AVERAGE, "average"],
			[Hips.RATING_AMPLE, "ample"],
			[Hips.RATING_CURVY, "curvy"],
			[Hips.RATING_FERTILE, "fertile"],
			[Hips.RATING_INHUMANLY_WIDE, "inhumanly wide"]
		];
		public static const DEFAULT_BUTT_RATING_SCALES:Array = [
			[Butt.RATING_BUTTLESS, "buttless"],
			[Butt.RATING_TIGHT, "tight"],
			[Butt.RATING_AVERAGE, "average"],
			[Butt.RATING_NOTICEABLE, "noticeable"],
			[Butt.RATING_LARGE, "large"],
			[Butt.RATING_JIGGLY, "jiggly"],
			[Butt.RATING_EXPANSIVE, "expansive"],
			[Butt.RATING_HUGE, "huge"],
			[Butt.RATING_INCONCEIVABLY_BIG, "inconceivably big"]
		];

		/**
		 * Assume scale = [[0,"small"],[5,"average"],[10,"big"]]
		 *      value < 0   ->   "less than small"
		 *      value = 0   ->   "small"
		 *  0 < value < 5   ->   "between small and average"
		 *      value = 5   ->   "average"
		 *  5 < value < 10  ->   "between average and big"
		 *      value = 10  ->   "big"
		 *      value > 10  ->   "more than big"
		 */
		public static function describeByScale(value:Number, scale:Array, lessThan:String = "less than", moreThan:String = "more than"):String
		{
			if (scale.length == 0) return "undescribeale";
			if (scale.length == 1) return "about " + scale[0][1];
			if (value < scale[0][0]) return lessThan + " " + scale[0][1];
			if (value == scale[0][0]) return scale[0][1];
			for (var i:int = 1; i < scale.length; i++) {
				if (value < scale[i][0]) return "between " + scale[i - 1][1] + " and " + scale[i][1];
				if (value == scale[i][0]) return scale[i][1];
			}
			return moreThan + " " + scale[scale.length - 1][1];
		}

		/**
		 * numberOfThings(0,"brain") = "no brains"
		 * numberOfThings(1,"head") = "one head"
		 * numberOfThings(2,"tail") = "2 tails"
		 * numberOfThings(3,"hoof","hooves") = "3 hooves"
		 */
		public static function numberOfThings(n:int, name:String, pluralForm:String = null):String
		{
			pluralForm = pluralForm || (name + "s");
			if (n == 0) return "no " + pluralForm;
			if (n == 1) return "one " + name;
			return n + " " + pluralForm;
		}

		/**
		 * 13 -> 2'1"
		 * 5.5 -> 5.5"
		 * Positive only!
		 */
		public static function feetsAndInches(n:Number):String
		{
			var feet:int = Math.floor(n / 12);
			var inches:Number = n - feet * 12;
			if (feet > 0) return feet + "'" + inches + "\"";
			else return inches + "\"";
		}

		/**
		 * 13 -> 13" (2'1")
		 */
		public static function inchesAndFeetsAndInches(n:Number):String
		{
			if (n < 12) return n + "\"";
			return n + "\" (" + feetsAndInches(n) + ")";
		}

		public static function allBreastsDescript(creature:Creature):String
		{
			var storage:String = "";
			if (creature.breastRows.length == 0) return "unremarkable chest muscles ";
			if (creature.breastRows.length == 2) {
				//if(creature.totalBreasts() == 4) storage += "quartet of ";
				storage += "two rows of ";
			}
			if (creature.breastRows.length == 3) {
				if (rand(2) == 0) storage += "three rows of ";
				else storage += "multi-layered ";
			}
			if (creature.breastRows.length == 4) {
				if (rand(2) == 0) storage += "four rows of ";
				else storage += "four-tiered ";
			}
			if (creature.breastRows.length == 5) {
				if (rand(2) == 0) storage += "five rows of ";
				else storage += "five-tiered ";
			}
			storage += biggestBreastSizeDescript(creature);
			return storage;

		}

		public static function tailDescript(i_creature:Creature):String
		{
			if (i_creature.tailType == Tail.NONE)
			{
				trace("WARNING: Creature has no tails to describe.");
				return "<b>!Creature has no tails to describe!</b>";
			}

			var descript:String = "";

			if (i_creature.tailType == Tail.FOX && i_creature.tailCount >= 1)
			{
				// Kitsune tails, we're using tailCount to track tail count
				if (i_creature.tailCount > 1)
				{
					if (i_creature.tailCount == 2) descript += "pair ";
					else if (i_creature.tailCount == 3) descript += "trio ";
					else if (i_creature.tailCount == 4) descript += "quartet ";
					else if (i_creature.tailCount == 5) descript += "quintet ";
					else if (i_creature.tailCount > 5) descript += "bundle ";

					descript += "of kitsune tails";
				}
				else descript += "kitsune tail";
			}
			else if (i_creature.tailType == Tail.CAT && i_creature.tailCount >= 1)
			{
				// Kitsune tails, we're using tailCount to track tail count
				if (i_creature.tailCount > 1) descript += "pair of cat tails";
				else descript += "cat tail";
			}
			else
			{
				descript += Tail.Types[i_creature.tailType].name;
				descript += " tail";
			}

			return descript;
		}

		public static function oneTailDescript(i_creature:Creature):String
		{
			if (i_creature.tailType == Tail.NONE)
			{
				trace("WARNING: Creature has no tails to describe.");
				return "<b>!Creature has no tails to describe!</b>";
			}

			var descript:String = "";

			if (i_creature.tailType == Tail.FOX && i_creature.tailCount >= 1)
			{
				if (i_creature.tailCount == 1)
				{
					descript += "your kitsune tail";
				}
				else
				{
					descript += "one of your kitsune tails";
				}
			}
			else if (i_creature.tailType == Tail.CAT && i_creature.tailCount >= 1)
			{
				if (i_creature.tailCount == 1)
				{
					descript += "your cat tail";
				}
				else
				{
					descript += "one of your cat tails";
				}
			}
			else
			{
				descript += "your " + Tail.Types[i_creature.tailType].name + " tail";
			}

			return descript;
		}

		public static function biggestBreastSizeDescript(creature:Creature):String
		{
			var temp14:int = Math.random() * 3;
			var descript:String = "";
			var temp142:int = creature.biggestTitRow();
			//ERROR PREVENTION
			if (creature.breastRows.length - 1 < temp142) {
				CoC_Settings.error("");
				return "<b>ERROR, biggestBreastSizeDescript() working with invalid breastRow</b>";
			}
			else if (temp142 < 0) {
				CoC_Settings.error("");
				return "ERROR SHIT SON!  BIGGESTBREASTSIZEDESCRIPT PASSED NEGATIVE!";
			}
			if (creature.breastRows[temp142].breastRating < 1) return "flat breasts";
			//50% of the time size-descript them
			if (rand(2) == 0) descript += breastSize(creature.breastRows[temp142].breastRating);
			//Nouns!
			temp14 = rand(10);
			if (temp14 == 0) descript += "breasts";
			if (temp14 == 1) {
				if (creature.breastRows[temp142].lactationMultiplier > 2) descript += "milk-udders";
				else descript += "breasts";
			}
			if (temp14 == 2) {
				if (creature.breastRows[temp142].lactationMultiplier > 1.5) descript += "milky ";
				if (creature.breastRows[temp142].breastRating > 4) descript += "tits";
				else descript += "breasts";
			}
			if (temp14 == 3) {
				//if(creature.breastRows[temp142].breastRating > 6) descript += "rack";
				descript += "breasts";
			}
			if (temp14 == 4) descript += "tits";
			if (temp14 == 5) descript += "tits";
			if (temp14 == 6) descript += "tits";
			if (temp14 == 7) {
				if (creature.breastRows[temp142].lactationMultiplier >= 1 && creature.breastRows[temp142].lactationMultiplier < 2.5) descript += "milk jugs";
				if (creature.breastRows[temp142].lactationMultiplier >= 2.5) descript += "udders";
				if (creature.breastRows[temp142].lactationMultiplier < 1) descript += "jugs";
			}
			if (temp14 == 8) {
				if (creature.breastRows[temp142].breastRating > 6) descript += "love-pillows";
				else descript += "boobs";
			}
			if (temp14 == 9) {
				if (creature.breastRows[temp142].breastRating > 6) descript += "tits";
				else descript += "breasts";
			}
			return descript;
		}

		public static function breastSize(val:Number):String
		{
			var descript:String = "";
			//Catch all for dudes.
			if (val < 1) return "manly ";
			//Small - A->B
			if (val <= 2) {
				descript += randomChoice("palmable ", "tight ", "perky ", "baseball-sized ");
			}
			//C-D
			else if (val <= 4) {
				descript += randomChoice("nice ", "hand-filling ", "well-rounded ", "supple ", "softball-sized ");
			}
			//DD->big EE
			else if (val < 11) {
				descript += randomChoice("big ", "large ", "pillowy ", "jiggly ", "volleyball-sized ");
			}
			//F->big FF
			else if (val < 15) {
				descript += randomChoice("soccerball-sized ", "hand-overflowing ", "generous ", "jiggling ");
			}
			//G -> HHH
			else if (val < 24) {
				descript += randomChoice("basketball-sized ", "whorish ", "cushiony ", "wobbling ");
			}
			//I -> KK
			else if (val < 35) {
				descript += randomChoice("massive motherly ", "luscious ", "smothering ", "prodigious ");
			}
			//K- > MMM+
			else if (val < 100) {
				descript += randomChoice("mountainous ", "monumental ", "back-breaking ", "exercise-ball-sized ", "immense ");
			}
			//Hyper sizes
			else {
				descript += randomChoice("ludicrously-sized ", "hideously large ", "absurdly large ", "back-breaking ", "colossal ", "immense ");
			}
			return descript;
		}

/* Moved to Creature.as
		public static function chestDesc(creature:Creature):String
		{
			if (creature.biggestTitSize() < 1) return "chest";
			else return biggestBreastSizeDescript(creature);
		}
*/

		public static function assholeOrPussy(creature:Creature):String
		{
			if (creature.hasVagina()) return vaginaDescript(creature, 0);
			return assholeDescript(creature);
		}


		public static function multiCockDescriptLight(creature:Creature):String
		{
			if (creature.cocks.length < 1) {

				CoC_Settings.error("");
				return "<B>Error: multiCockDescriptLight() called with no penises present.</B>";

			}
			//Get cock counts
			var descript:String = "";
			var currCock:Number = 0;
			var totCock:Number = creature.cocks.length;
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
			if (totCock == 1) return creature.cockDescript(0);
			//Count cocks & Prep average totals
			while (currCock <= totCock - 1) {
				if (creature.cocks[currCock].cockType == CockTypesEnum.HUMAN) {
					normalCocks++;
					normalCockKey = currCock;
				}
				if (creature.cocks[currCock].cockType == CockTypesEnum.HORSE) {
					horseCocks++;
					horseCockKey = currCock;
				}
				if (creature.cocks[currCock].cockType == CockTypesEnum.DOG) {
					dogCocks++;
					dogCockKey = currCock;
				}
				averageLength += creature.cocks[currCock].cockLength;
				averageThickness += creature.cocks[currCock].cockThickness;
				//If cocks are matched make sure they still are
				if (same && currCock > 0 && creature.cocks[currCock].cockType != creature.cocks[currCock - 1].cockType) same = false;
				currCock++;
			}
			//Crunch averages
			averageLength /= currCock;
			averageThickness /= currCock;
			//Quantity descriptors
			if (creature.cockTotal() == 1) {
				if (dogCocks == 1) return cockNoun(CockTypesEnum.DOG);
				if (horseCocks == 1) return cockNoun(CockTypesEnum.HORSE);
				if (normalCocks == 1) return creature.cockDescript(0);
				//Failsafe
				return creature.cockDescript(0);
			}
			if (currCock == 2) {
				//For cocks that are the same
				if (same) {
					descript += randomChoice("pair of ", "two ", "brace of ", "matching ", "twin ");
					descript += creature.cockAdjective();
					if (normalCocks == 2) descript += " " + cockNoun(CockTypesEnum.HUMAN) + "s";
					if (horseCocks == 2) descript += ", " + cockNoun(CockTypesEnum.HORSE) + "s";
					if (dogCocks == 2) descript += ", " + cockNoun(CockTypesEnum.DOG) + "s";
					//Failsafe
					if (creature.cocks[0].cockType.Index > 2) descript += ", " + cockNoun(creature.cocks[0].cockType) + "s";
				}
				//Nonidentical
				else {
					descript += randomChoice("pair of ", "two ", "brace of ");
					descript += creature.cockAdjective() + ", ";
					descript += randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
				}
			}
			if (currCock == 3) {
				//For samecocks
				if (same) {
					descript += randomChoice("three ", "group of ", "<i>ménage à trois</i> of ", "triad of ", "triumvirate of ");
					descript += creature.cockAdjective();
					if (normalCocks == 3) descript += " " + cockNoun(CockTypesEnum.HUMAN) + "s";
					if (horseCocks == 3) descript += ", " + cockNoun(CockTypesEnum.HORSE) + "s";
					if (dogCocks == 3) descript += ", " + cockNoun(CockTypesEnum.DOG) + "s";
					//Tentacles
					if (creature.cocks[0].cockType.Index > 2) descript += ", " + cockNoun(creature.cocks[0].cockType) + "s";
				}
				else {
					descript += randomChoice("three ", "group of ");
					descript += creature.cockAdjective() + ", ";
					descript += randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
				}
			}
			//Large numbers of cocks!
			if (currCock > 3) {
				descript += randomChoice("bundle of ", "obscene group of ", "cluster of ", "wriggling bunch of ");
				//Cock adjectives and nouns
				descripted = false;
				//Same
				if (same) {
					if (currCock == normalCocks) {
						descript += creature.cockAdjective() + " ";
						descript += cockNoun(CockTypesEnum.HUMAN) + "s";
						descripted = true;
					}
					if (currCock == dogCocks) {
						descript += creature.cockAdjective() + ", ";
						descript += cockNoun(CockTypesEnum.DOG) + "s";
						descripted = true;
					}
					if (currCock == horseCocks) {
						descript += creature.cockAdjective() + ", ";
						descript += cockNoun(CockTypesEnum.HORSE) + "s";
						descripted = true;
					}
					if (creature.cocks[0].cockType.Index > 2) {
						descript += creature.cockAdjective() + ", ";
						descript += cockNoun(creature.cocks[0].cockType) + "s";
						descripted = true;
					}
				}
				//If mixed
				if (!descripted) {
					descript += creature.cockAdjective() + ", ";
					descript += randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
				}
			}
			return descript;
		}

		public static function multiCockDescript(creature:Creature):String
		{
			if (creature.cocks.length < 1) {
				CoC_Settings.error("");
				return "<B>Error: multiCockDescript() called with no penises present.</B>";
			}
			//Get cock counts
			var descript:String = "";
			var currCock:Number = 0;
			var totCock:Number = creature.cocks.length;
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
			while (currCock <= totCock - 1) {
				//trace("Counting cocks!");
				if (creature.cocks[currCock].cockType == CockTypesEnum.HUMAN) {
					normalCocks++;
					normalCockKey = currCock;
				}
				if (creature.cocks[currCock].cockType == CockTypesEnum.HORSE) {
					horseCocks++;
					horseCockKey = currCock;
				}
				if (creature.cocks[currCock].cockType == CockTypesEnum.DOG) {
					dogCocks++;
					dogCockKey = currCock;
				}
				averageLength += creature.cocks[currCock].cockLength;
				averageThickness += creature.cocks[currCock].cockThickness;
				//If cocks are matched make sure they still are
				if (same && currCock > 0 && creature.cocks[currCock].cockType != creature.cocks[currCock - 1].cockType) same = false;
				currCock++;
			}
			//Crunch averages
			averageLength /= currCock;
			averageThickness /= currCock;
			//Quantity descriptors
			if (currCock == 1) {
				if (dogCocks == 1) return cockNoun(CockTypesEnum.DOG);
				if (horseCocks == 1) return cockNoun(CockTypesEnum.HORSE);
				if (normalCocks == 1) return cockDescript(creature,0);
				//Catch-all for when I add more cocks.  Let cock descript do the sorting.
				if (creature.cocks.length == 1) return cockDescript(creature,0);
			}
			if (currCock == 2) {
				//For cocks that are the same
				if (same) {
					descript += randomChoice("a pair of ", "two ", "a brace of ", "matching ", "twin ");
					descript += cockAdjectives(averageLength, averageThickness, creature.cocks[0].cockType, creature);
					if (normalCocks == 2) descript += " " + cockNoun(CockTypesEnum.HUMAN) + "s";
					if (horseCocks == 2) descript += ", " + cockNoun(CockTypesEnum.HORSE) + "s";
					if (dogCocks == 2) descript += ", " + cockNoun(CockTypesEnum.DOG) + "s";
					//Tentacles
					if (creature.cocks[0].cockType.Index > 2)
						descript += ", " + cockNoun(creature.cocks[0].cockType) + "s";
				}
				//Nonidentical
				else {
					descript += randomChoice("a pair of ", "two ", "a brace of ");
					descript += cockAdjectives(averageLength, averageThickness, creature.cocks[0].cockType, creature) + ", ";
					descript += randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
				}
			}
			if (currCock == 3) {
				//For samecocks
				if (same) {
					descript += randomChoice("three ", "a group of ", "a <i>ménage à trois</i> of ", "a triad of ", "a triumvirate of ");
					descript += cockAdjectives(averageLength, averageThickness, creature.cocks[currCock - 1].cockType, creature);
					if (normalCocks == 3)
						descript += " " + cockNoun(CockTypesEnum.HUMAN) + "s";
					if (horseCocks == 3)
						descript += ", " + cockNoun(CockTypesEnum.HORSE) + "s";
					if (dogCocks == 3)
						descript += ", " + cockNoun(CockTypesEnum.DOG) + "s";
					//Tentacles
					if (creature.cocks[0].cockType.Index > 2) descript += ", " + cockNoun(creature.cocks[0].cockType) + "s";   // Not sure what's going on here, referencing index *may* be a bug.

				}
				else {
					descript += randomChoice("three ", "a group of ");
					descript += cockAdjectives(averageLength, averageThickness, creature.cocks[0].cockType, creature);
					descript += randomChoice(", mutated cocks", ", mutated dicks", ", mixed cocks", ", mismatched dicks");
				}
			}
			//Large numbers of cocks!
			if (currCock > 3) {
				descript += randomChoice("a bundle of ", "an obscene group of ", "a cluster of ", "a wriggling group of ");
				//Cock adjectives and nouns
				descripted = false;
				//If same types...
				if (same) {
					if (creature.cocks[0].cockType == CockTypesEnum.HUMAN) {
						descript += cockAdjectives(averageLength, averageThickness, CockTypesEnum.HUMAN, creature) + " ";
						descript += cockNoun(CockTypesEnum.HUMAN) + "s";
						descripted = true;
					}
					if (creature.cocks[0].cockType == CockTypesEnum.DOG) {
						descript += cockAdjectives(averageLength, averageThickness, CockTypesEnum.DOG, creature) + ", ";
						descript += cockNoun(CockTypesEnum.DOG) + "s";
						descripted = true;
					}
					if (creature.cocks[0].cockType == CockTypesEnum.HORSE) {
						descript += cockAdjectives(averageLength, averageThickness, CockTypesEnum.HORSE, creature) + ", ";
						descript += cockNoun(CockTypesEnum.HORSE) + "s";
						descripted = true;
					}
					//TODO More group cock type descriptions!
					if (creature.cocks[0].cockType.Index > 2) {
						descript += cockAdjectives(averageLength, averageThickness, CockTypesEnum.HUMAN, creature) + ", ";
						descript += cockNoun(creature.cocks[0].cockType) + "s";
						descripted = true;
					}
				}
				//If mixed
				if (!descripted) {
					descript += cockAdjectives(averageLength, averageThickness, creature.cocks[0].cockType, creature) + ", ";
					rando = rand(4);
					descript += randomChoice("mutated cocks", "mutated dicks", "mixed cocks", "mismatched dicks");
				}
			}
			return descript;
		}
	}
}
