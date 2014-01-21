package classes
{
	import classes.Appearance;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Armor;
	import classes.Items.ArmorLib;
	import classes.Items.Weapon;
	import classes.Items.WeaponLib;
	import classes.Scenes.Places.TelAdre.UmasShop;

	use namespace kGAMECLASS;

	/**
	 * ...
	 * @author Yoffy
	 */
	public class Player extends Character
	{
		protected final function outputText(text:String, clear:Boolean = false):void
		{
			game.outputText(text, clear);
		}
		
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
		public var explored:Number = 0;
		public var exploredForest:Number = 0;
		public var exploredDesert:Number = 0;
		public var exploredMountain:Number = 0;
		public var exploredLake:Number = 0;

		// Inventory
		public var itemSlot1:ItemSlotClass;
		public var itemSlot2:ItemSlotClass;
		public var itemSlot3:ItemSlotClass;
		public var itemSlot4:ItemSlotClass;
		public var itemSlot5:ItemSlotClass;
		public var itemSlots:Array;

		private var _armor:Armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
		private var _modArmorName:String = null;

		public function get modArmorName():String
		{
			return _modArmorName;
		}

		public function set modArmorName(value:String):void
		{
			_modArmorName = value;
		}

		override public function get armorName():String {
			if (_modArmorName != null) return _modArmorName;
			return _armor.name;
		}
		override public function get armorDef():Number {
			var armorDef:Number = _armor.def;
			//Blacksmith history!
			if(armorDef > 0 && hasPerk("History: Smith") >= 0) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			//Skin armor perk
			if(hasPerk("Thick Skin") >= 0) {
				armorDef += 2;
				if(skinType > SKIN_TYPE_PLAIN) armorDef += 1;
			}
			//If no skin armor perk scales rock
			else {
				if(skinType == SKIN_TYPE_FUR) armorDef += 1;
				if(skinType == SKIN_TYPE_SCALES) armorDef += 3;
			}
			//'Thick' dermis descriptor adds 1!
			if(skinAdj == "smooth") armorDef += 1;
			//Agility boosts armor ratings!
			if(hasPerk("Agility") >= 0) {
				if(armorPerk == "Light") armorDef += Math.round(spe/8);
				else if(armorPerk == "Medium") armorDef += Math.round(spe/13);
			}
			//Berzerking removes armor
			if(hasStatusAffect("Berzerking") >= 0) {
				armorDef = 0;
			}
			if(kGAMECLASS.monster.hasStatusAffect("Tail Whip") >= 0) {
				armorDef -= kGAMECLASS.monster.statusAffectv1("Tail Whip");
				if(armorDef < 0) armorDef = 0;
			}
			return armorDef;
		}
		public function get armorBaseDef():Number {
			return _armor.def;
		}
		override public function get armorPerk():String {
			return _armor.perk;
		}
		override public function get armorValue():Number {
			return _armor.value;
		}
		private var _weapon:Weapon = WeaponLib.FISTS;
		override public function get weaponName():String {
			return _weapon.name;
		}
		override public function get weaponVerb():String {
			return _weapon.verb;
		}
		override public function get weaponAttack():Number {
			var attack:Number = _weapon.attack;
			if(hasPerk("Weapon Mastery") >= 0 && weaponPerk == "Large" && str > 60)
				attack *= 2;
			if(hasPerk("Lightning Strikes") >= 0 && spe >= 60 && weaponPerk != "Large") {
				attack += Math.round((spe - 50) / 3);
			}
			if(hasStatusAffect("Berzerking") >= 0) attack += 30;
			attack += statusAffectv1("Charge Weapon");
			return attack;
		}
		public function get weaponBaseAttack():Number {
			return _weapon.attack;
		}
		override public function get weaponPerk():String {
			return _weapon.perk || "";
		}
		override public function get weaponValue():Number {
			return _weapon.value;
		}

		public function get armor():Armor
		{
			return _armor;
		}

		public function set armor(value:Armor):void
		{
			if (value == null){
				CoC_Settings.error(short+".armor is set to null");
				value = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			}
			value.equip(this, false);
		}

		// in case you don't want to call the value.equip
		public function setArmorHiddenField(value:Armor):void
		{
			this._armor = value;
		}

		public function get weapon():Weapon
		{
			return _weapon;
		}

		public function set weapon(value:Weapon):void
		{
			if (value == null){
				CoC_Settings.error(short+".weapon is set to null");
				value = WeaponLib.FISTS;
			}
			value.equip(this,false);
		}

		// in case you don't want to call the value.equip
		public function setWeaponHiddenField(value:Weapon):void
		{
			this._weapon = value;
		}

		// Hacky workaround shit for ByteArray.readObject
		public function Player()
		{
			//Item things
			itemSlot1 = new ItemSlotClass();
			itemSlot2 = new ItemSlotClass();
			itemSlot3 = new ItemSlotClass();
			itemSlot4 = new ItemSlotClass();
			itemSlot5 = new ItemSlotClass();


			itemSlots = [itemSlot1, itemSlot2, itemSlot3, itemSlot4, itemSlot5];
		}

		public function reduceDamage(damage:Number):Number{
			damage = int(damage - rand(tou) - armorDef);
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) damage /= 2;
			if (hasStatusAffect("Shielding") >= 0) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			//Black cat beer = 25% reduction!
			if (statusAffectv1("Black Cat Beer") > 0)
				damage = Math.round(damage * .75);

			//Take damage you masochist!
			if (hasPerk("Masochist") >= 0 && lib >= 60) {
				damage = Math.round(damage * .7);
				game.dynStats("lus", 2);
				//Dont let it round too far down!
				if (damage < 1) damage = 1;
			}
			if (hasPerk("Immovable Object") >= 0 && tou >= 75) {
				damage = Math.round(damage * .8);
				if (damage < 1) damage = 1;
			}

			// Uma's Massage bonuses
			var statIndex:int = hasStatusAffect(UmasShop.MASSAGE_BONUS_NAME);
			if (statIndex >= 0) {
				if (statusAffects[statIndex].value1 == UmasShop.MASSAGE_RELAXATION) {
					damage = Math.round(damage * statusAffects[statIndex].value2);
				}
			}

			// Uma's Accupuncture Bonuses
			var modArmorDef:Number = 0;
			if (hasPerk(UmasShop.NEEDLEWORK_DEFENSE_PERK_NAME) >= 0) modArmorDef = ((armorDef * UmasShop.NEEDLEWORK_DEFENSE_DEFENSE_MULTI) - armorDef);
			if (hasPerk(UmasShop.NEEDLEWORK_ATTACK_PERK_NAME) >= 0) modArmorDef = ((armorDef * UmasShop.NEEDLEWORK_ATTACK_DEFENSE_MULTI) - armorDef);
			damage -= modArmorDef;
			if (damage<0) damage = 0;
			return damage;
		}

		public function takeDamage(damage:Number):Number{
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				HP -= damage;
				game.mainView.statsView.showStatDown('hp');
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					game.dynStats("lus", int(damage / 2));
				}
				//Prevent negatives
				if (HP<=0){
					HP = 0;
					if (game.gameState == 1 || game.gameState == 2) game.doNext(5010);
				}
			}
			return returnDamage;
		}

		/**
		 * @return 0: did not avoid; 1-3: avoid with varying difference between
		 * speeds (1: narrowly avoid, 3: deftly avoid)
		 */
		public function speedDodge(monster:Monster):int{
			var diff:Number = spe - monster.spe;
			var rnd:int = int(Math.random() * ((diff / 4) + 80));
			if (rnd<=80) return 0;
			else if (diff<8) return 1;
			else if (diff<20) return 2;
			else return 3;
		}
		
		//Body Type
		public function bodyType():String
		{
			var desc:String = "";
			//OLD STUFF
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
			{	
				race = "dog-morph";
				if (faceType == 0)
					race = "dog-" + mf("man", "girl");
			}
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
				demonCounter++;
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

		public function cuntChange(cArea:Number, display:Boolean, spacingsF:Boolean = false, spacingsB:Boolean = true):Boolean {
			if (vaginas.length==0) return false;
			var wasVirgin:Boolean = vaginas[0].virgin;
			var stretched:Boolean = cuntChangeNoDisplay(cArea);
			var devirgined:Boolean = wasVirgin && !vaginas[0].virgin;
			if (devirgined){
				if(spacingsF) outputText("  ");
				outputText("<b>Your hymen is torn, robbing you of your virginity.</b>", false);
				if(spacingsB) outputText("  ");
			}
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(display && stretched) {
				//Virgins get different formatting
				if(devirgined) {
					//If no spaces after virgin loss
					if(!spacingsB) outputText("  ");
				}
				//Non virgins as usual
				else if(spacingsF) outputText("  ");
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LEVEL_CLOWN_CAR) outputText("<b>Your " + Appearance.vaginaDescript(this,0)+ " is stretched painfully wide, large enough to accomodate most beasts and demons.</b>");
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched so wide that it gapes continually.</b>");
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " painfully stretches, the lips now wide enough to gape slightly.</b>");
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LOOSE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now very loose.</b>", false);
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_NORMAL) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now a little loose.</b>", false);
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_TIGHT) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched out to a more normal size.</b>");
				if(spacingsB) outputText("  ");
			}
			return stretched;
		}

		public function buttChange(cArea:Number, display:Boolean, spacingsF:Boolean = true, spacingsB:Boolean = true):Boolean
		{
			var stretched:Boolean = buttChangeNoDisplay(cArea);
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(stretched && display) {
				if(spacingsF) outputText("  ");
				if(ass.analLooseness == 5) outputText("<b>Your " + Appearance.assholeDescript(this) + " is stretched even wider, capable of taking even the largest of demons and beasts.</b>");
				if(ass.analLooseness == 4) outputText("<b>Your " + Appearance.assholeDescript(this) + " becomes so stretched that it gapes continually.</b>", false);
				if(ass.analLooseness == 3) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now very loose.</b>");
				if(ass.analLooseness == 2) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now a little loose.</b>");
				if(ass.analLooseness == 1) outputText("<b>You have lost your anal virginity.</b>", false);
				if(spacingsB) outputText("  ");
			}
			return stretched;
		}

		public function slimeFeed():void{
			if(hasStatusAffect("Slime Craving") >= 0) {
				//Reset craving value
				changeStatusValue("Slime Craving",1,0);
				//Flag to display feed update and restore stats in event parser
				if(hasStatusAffect("Slime Craving Feed") < 0) {
					createStatusAffect("Slime Craving Feed",0,0,0,0);
				}
			}
			if(hasPerk("Diapause") >= 0) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228] += 3 + rand(3);
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] = 1;
			}

		}
		
		public function minoCumAddiction(raw:Number = 10):void {
			//Increment minotaur cum intake count
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00340]++;
			//Fix if variables go out of range.
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;
			
			//Turn off withdrawal
			//if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 1;
			//Reset counter
			flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM] = 0;
			//If highly addicted, rises slower
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 60) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 80) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 90) raw /= 2;
			//If in withdrawl, readdiction is potent!
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) raw += 10;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2) raw += 5;
			raw = Math.round(raw * 100)/100;
			flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] += raw;
			//PUT SOME CAPS ON DAT' SHIT
			if(raw > 50) raw = 20;
			if(raw < -50) raw = -20;
			//Recheck to make sure shit didn't break
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;
		
		}

		public function hasSpells():Boolean
		{
			return spellCount()>0;
		}

		public function spellCount():Number
		{
			return ["Knows Arouse","Knows Heal","Knows Might","Knows Charge","Knows Blind","Knows Whitefire"]
					.filter(function(item:String,index:int,array:Array):Boolean{
						return this.hasStatusAffect(item)>0;},this)
					.length;
		}

		public function hairDescript():String
		{
			return Appearance.hairDescription(this);
		}

		public function shrinkTits():void
		{
			if(breastRows.length == 1) {
				if(breastRows[0].breastRating > 0) {
					//Shrink if bigger than N/A cups
					var temp:Number = 0;
					temp = 1;
					breastRows[0].breastRating--;
					//Shrink again 50% chance
					if(breastRows[0].breastRating >= 1 && rand(2) == 0 && hasPerk("Big Tits") < 0) {
						temp++;
						breastRows[0].breastRating--;
					}
					if(breastRows[0].breastRating < 0) breastRows[0].breastRating = 0;
					//Talk about shrinkage
					if(temp == 1) outputText("\n\nYou feel a weight lifted from you, and realize your breasts have shrunk!  With a quick measure, you determine they're now " + breastCup(0) + "s.", false);
					if(temp == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are much smaller!  With a quick measure, you determine they're now " + breastCup(0) + "s.", false);
				}
			}
			else if(breastRows.length > 1) {
				//multiple
				outputText("\n", false);
				//temp2 = amount changed
				//temp3 = counter
				var temp2:Number = 0;
				var temp3:Number = breastRows.length;
				while(temp3 > 0) {
					temp3--;
					if(breastRows[temp3].breastRating > 0) {
						breastRows[temp3].breastRating--;
						if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
						temp2++;
						outputText("\n", false);
						if(temp3 < breastRows.length - 1) outputText("...and y", false);
						else outputText("Y", false);
						outputText("our " + breastDescript(temp3) + " shrink, dropping to " + breastCup(temp3) + "s.", false);
					}
					if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
				}
				if(temp2 == 2) outputText("\nYou feel so much lighter after the change.", false);
				if(temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.", false);
				if(temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.", false);
			}
		}

		public function growTits(amount:Number, rowsGrown:Number, display:Boolean, growthType:Number):void
		{
			if(breastRows.length == 0) return;
			//GrowthType 1 = smallest grows
			//GrowthType 2 = Top Row working downward
			//GrowthType 3 = Only top row
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Chance for "big tits" perked characters to grow larger!
			if(hasPerk("Big Tits") >= 0 && rand(3) == 0 && amount < 1) amount=1;
			var temp:uint = breastRows.length;
			if(growthType == 1) {
				//Select smallest breast, grow it, move on
				while(rowsGrown > 0) {
					//Temp = counter
					temp = breastRows.length;
					//Temp2 = smallest tits index
					temp2 = 0;
					//Find smallest row
					while(temp > 0) {
						temp--;
						if(breastRows[temp].breastRating < breastRows[temp2].breastRating) temp2 = temp;
					}
					//Temp 3 tracks total amount grown
					temp3 += amount;
					trace("Breastrow chosen for growth: " + String(temp2) + ".");
					//Reuse temp to store growth amount for diminishing returns.
					temp = amount;
					//Diminishing returns!
					if(breastRows[temp2].breastRating > 3) {
						if(hasPerk("Big Tits") < 0) temp/=1.5;
						else temp/=1.3;
					}
					if(breastRows[temp2].breastRating > 7) { 
						if(hasPerk("Big Tits") < 0) temp/=2;
						else temp /= 1.5;
					}
					if(breastRows[temp2].breastRating > 9) { 
						if(hasPerk("Big Tits") < 0) temp/=2;
						else temp /= 1.5;
					}
					if(breastRows[temp2].breastRating > 12) { 
						if(hasPerk("Big Tits") < 0) temp/=2;
						else temp /= 1.5;
					}
					//Grow!
					breastRows[temp2].breastRating += temp;
					rowsGrown--;
				}
			}
			//Diminishing returns!
			if(breastRows[0].breastRating > 3) {
				if(hasPerk("Big Tits") < 0) amount/=1.5;
				else amount/=1.3;
			}
			if(breastRows[0].breastRating > 7) { 
				if(hasPerk("Big Tits") < 0) amount/=2;
				else amount /= 1.5;
			}
			if(breastRows[0].breastRating > 12) { 
				if(hasPerk("Big Tits") < 0) amount/=2;
				else amount /= 1.5;
			}
			/*if(breastRows[0].breastRating > 12) { 
				if(hasPerk("Big Tits") < 0) amount/=2;
				else amount /= 1.5;
			}*/
			if(growthType == 2) {
				temp = 0;
				temp2 = 0;
				//Start at top and keep growing down, back to top if hit bottom before done.
				while(rowsGrown > 0) {
					if(temp+1 > breastRows.length) temp = 0;
					breastRows[temp].breastRating += amount;
					trace("Breasts increased by " + amount + " on row " + temp);
					temp++;
					temp3 += amount;
					rowsGrown--;
				}
			}
			if(growthType == 3) {
				while(rowsGrown > 0) {
					rowsGrown--;
					breastRows[0].breastRating += amount;
					temp3 += amount;
				}
			}
			//Breast Growth Finished...talk about changes.
			if(display) {
				if(growthType < 3) {
					if(amount <= 2) {
						if(breastRows.length > 1) outputText("Your rows of " + breastDescript(0) + " jiggle with added weight, growing a bit larger.", false); 
						if(breastRows.length == 1) outputText("Your " + breastDescript(0) + " jiggle with added weight as they expand, growing a bit larger.", false);
					}
					if(amount > 2 && amount <= 4) {
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your rows of " + breastDescript(0) + " expand significantly.", false);
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.", false);
					}
					if(amount > 4) {
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your " + breastDescript(0) + " tingle strongly, growing disturbingly large.", false);
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.", false);
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .5;
					}
				}
				else
				{
					if(amount <= 2) {
						if(breastRows.length > 1) outputText("Your top row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.", false);
						if(breastRows.length == 1) outputText("Your row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.", false);
					}
					if(amount > 2 && amount <= 4) {
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your top row of " + breastDescript(0) + " expand significantly.", false);
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.", false);
					}
					if(amount > 4) {
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your top row of " + breastDescript(0) + " tingle strongly, growing disturbingly large.", false);
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tinglng in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.", false);
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .5;
					}
				}
			}
		}

		//Determine minimum lust
		public function minLust():Number
		{
			var min:Number = 0;
			//Bimbo body boosts minimum lust by 40
			if(hasStatusAffect("Bimbo Champagne") >= 0 || hasPerk("Bimbo Body") >= 0 || hasPerk("Bro Body") >= 0 || hasPerk("Futa Form") >= 0) {
				if(min > 40) min += 10;
				else if(min > 0) min += 20;
				else min += 40;
			}
			//Omnibus' Gift
			if(hasPerk("Omnibus' Gift") >= 0) {
				if(min > 40) min += 10;
				else if(min > 0) min += 20;
				else min += 35;                
			}
			//Nymph perk raises to 30
			if(hasPerk("Nymphomania") >= 0) {
				if(min >= 40) min += 10;
				else if(min > 0) min += 15;
				else min += 30;
			}
			//Oh noes anemone!
			if(hasStatusAffect("Anemone Arousal") >= 0) {
				if(min >= 40) min += 10;
				else if(min > 0) min += 20;
				else min += 30;
			}
			//Hot blooded perk raises min lust!
			if(hasPerk("Hot Blooded") >= 0) {
				if(min > 0) min += perks[hasPerk("Hot Blooded")].value1 / 2;
				else min += perks[hasPerk("Hot Blooded")].value1;
			}
			if(hasPerk("Luststick Adapted") > 0) {
				if(min < 50) min += 10;
				else min += 5;                
			}
			//Add points for Crimstone
			min += perkv1("Pierced: Crimstone");
			min += perkv1("Pent Up");
			//Harpy Lipstick status forces minimum lust to be at least 50.
			if(min < 50 && hasStatusAffect("Luststick") >= 0) min = 50;
			//SHOULDRA BOOSTS
			//+20
			if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -168) {
				min += 20;
				if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -216)
					min += 30;
			}
			//SPOIDAH BOOSTS
			if(eggs() >= 20) {
				min += 10;
				if(eggs() >= 40) min += 10;
			}
			if(min < 30 && armorName == "lusty maiden's armor") min = 30;
			return min;
		}

		public function minotaurAddicted():Boolean {
			return hasPerk("Minotaur Cum Addict") >= 0 || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 1;
		}
		public function minotaurNeed():Boolean {
			return flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1;
		}

		public function clearStatuses(visibility:Boolean):void
		{
			while(hasStatusAffect("Web") >= 0) {
				spe += statusAffectv1("Web");
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				removeStatusAffect("Web");
			}
			if(hasStatusAffect("Shielding") >= 0) removeStatusAffect("Shielding");
			if(hasStatusAffect("Holli Constrict") >= 0) removeStatusAffect("Holli Constrict");
			if(hasStatusAffect("lust stones") >= 0) removeStatusAffect("lust stones");
			if(kGAMECLASS.monster.hasStatusAffect("sandstorm") >= 0) kGAMECLASS.monster.removeStatusAffect("sandstorm");
			if(hasStatusAffect("Sealed") >= 0) {
				removeStatusAffect("Sealed");
			}
			if(hasStatusAffect("Berzerking") >= 0) {
				removeStatusAffect("Berzerking");
			}
			if(kGAMECLASS.monster.hasStatusAffect("Tail Whip") >= 0) {
				kGAMECLASS.monster.removeStatusAffect("Tail Whip");
			}
			if(hasStatusAffect("UBERWEB") >= 0) removeStatusAffect("UBERWEB");
			if(hasStatusAffect("Drider Kiss") >= 0) removeStatusAffect("Drider Kiss");
			if(hasStatusAffect("Web-Silence") >= 0) removeStatusAffect("Web-Silence");
			if(hasStatusAffect("GooArmorSilence") >= 0) removeStatusAffect("GooArmorSilence");
			if(hasStatusAffect("Bound") >= 0) removeStatusAffect("Bound");
			if(hasStatusAffect("GooArmorBind") >= 0) removeStatusAffect("GooArmorBind");
			if(hasStatusAffect("Whispered") >= 0) removeStatusAffect("Whispered");
			if(hasStatusAffect("Akbal Speed") >= 0) {
				kGAMECLASS.dynStats("spe", statusAffectv1("Akbal Speed") * -1);
				removeStatusAffect("Akbal Speed");
			}		
			if(hasStatusAffect("Amily Venom") >= 0) {
				kGAMECLASS.dynStats("str", statusAffectv1("Amily Venom"),"spe", statusAffectv2("Amily Venom"));
				removeStatusAffect("Amily Venom");
			}
			while(hasStatusAffect("Blind") >= 0) {
				removeStatusAffect("Blind");
			}
			if(hasStatusAffect("Sheila Oil") >= 0) {
				removeStatusAffect("Sheila Oil");
			}
			if(kGAMECLASS.monster.hasStatusAffect("Twu Wuv") >= 0) {
				inte += kGAMECLASS.monster.statusAffectv1("Twu Wuv");
				kGAMECLASS.statScreenRefresh();
				kGAMECLASS.mainView.statsView.showStatUp( 'inte' );
				// inteDown.visible = false;
				// inteUp.visible = true;		
			}
			if(hasStatusAffect("Naga Venom") >= 0) {
				spe += statusAffectv1("Naga Venom");
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				//stats(0,0,statusAffectv1("Naga Venom"),0,0,0,0,0);
				removeStatusAffect("Naga Venom");
			}
			if(hasStatusAffect("TentacleBind") >= 0) removeStatusAffect("TentacleBind");
			if(hasStatusAffect("Naga Bind") >= 0) removeStatusAffect("Naga Bind");
			if(hasStatusAffect("Stone Lust") >= 0) {
				removeStatusAffect("Stone Lust");
			}
			removeStatusAffect("FirstAttack");
			if(hasStatusAffect("Temporary Heat") >= 0) removeStatusAffect("Temporary Heat");
			if(hasStatusAffect("NoFlee") >= 0) removeStatusAffect("NoFlee");
			if(hasStatusAffect("Poison") >= 0) removeStatusAffect("Poison");
			if(hasStatusAffect("Isabella Stunned") >= 0) removeStatusAffect("Isabella Stunned");
			if(hasStatusAffect("Stunned") >= 0) removeStatusAffect("Stunned");
			if(hasStatusAffect("Confusion") >= 0) removeStatusAffect("Confusion");
			if(hasStatusAffect("Throat Punch") >= 0) removeStatusAffect("Throat Punch");
			if(hasStatusAffect("Kiss of Death") >= 0) removeStatusAffect("Kiss of Death");
			if(hasStatusAffect("Acid Slap") >= 0) removeStatusAffect("Acid Slap");
			if(hasStatusAffect("GooBind") >= 0) removeStatusAffect("GooBind");
			if(hasStatusAffect("HarpyBind") >= 0) removeStatusAffect("HarpyBind");
			if(hasStatusAffect("Called Shot") >= 0) {
				spe += statusAffectv1("Called Shot");
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speDown.visible = false;
				// speUp.visible = true;
				removeStatusAffect("Called Shot");
			}
			if(hasStatusAffect("DemonSeed") >= 0) {
				removeStatusAffect("DemonSeed");
			}
			if(hasStatusAffect("paralyze venom") >= 0) {
				str += statusAffects[hasStatusAffect("paralyze venom")].value1;
				spe += statusAffects[hasStatusAffect("paralyze venom")].value2;
				removeStatusAffect("paralyze venom");
			}
			if(hasStatusAffect("lust venom") >= 0) {
				removeStatusAffect("lust venom");
			}
			if(hasStatusAffect("infestAttempted") >= 0) {
				removeStatusAffect("infestAttempted");
			}
			if(hasStatusAffect("Might") >= 0) {
				kGAMECLASS.dynStats("str", -statusAffectv1("Might"),"tou", -statusAffectv2("Might"));
				removeStatusAffect("Might");
			}
			if(hasStatusAffect("Charge Weapon") >= 0) {
				removeStatusAffect("Charge Weapon");
			}
			if(hasStatusAffect("Disarmed") >= 0) {
				removeStatusAffect("Disarmed");
				if(weapon == WeaponLib.FISTS) {
					weapon = ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon;
				}
				else {
					flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID];
				}
			}
			if(hasStatusAffect("Anemone Venom") >= 0) {
				str += statusAffectv1("Anemone Venom");
				spe += statusAffectv2("Anemone Venom");
				//Make sure nothing got out of bounds
				kGAMECLASS.dynStats("cor", 0);
		
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				kGAMECLASS.mainView.statsView.showStatUp( 'str' );
				// speUp.visible = true;
				// strUp.visible = true;
				removeStatusAffect("Anemone Venom");
			}
			if(hasStatusAffect("Gnoll Spear") >= 0) {
				spe += statusAffectv1("Gnoll Spear");
				//Make sure nothing got out of bounds
				kGAMECLASS.dynStats("cor", 0);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				removeStatusAffect("Gnoll Spear");
			}
			if(hasStatusAffect("Basilisk Compulsion") >= 0) removeStatusAffect("Basilisk Compulsion");
			if(hasStatusAffect("BasiliskSlow") >= 0) {
				spe += statusAffectv1("BasiliskSlow");
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				removeStatusAffect("BasiliskSlow");
			}
			while(hasStatusAffect("Izma Bleed") >= 0) removeStatusAffect("Izma Bleed");
		}

		public function consumeItem(itype:ItemType, amount:int=1):Boolean
		{
			var consumed:Boolean = false;
			var slot:*;
			while (amount > 0)
			{
				if(!hasItem(itype,1))
				{
					CoC_Settings.error("ERROR: consumeItem in items.as attempting to find an item to remove when the has none.");
					break;
				}
				trace("FINDING A NEW SLOT! (ITEMS LEFT: " + amount + ")");
				slot = getLowestSlot(itype);
				while (slot != undefined && amount > 0 && slot.quantity > 0)
				{
					amount--;
					slot.quantity--;
					if(slot.quantity == 0) slot.emptySlot();
					trace("EATIN' AN ITEM");
				}
				//If on slot 5 and it doesn't have any more to take, break out!
				if(slot == undefined) amount = -1

			}
			if(amount == 0) consumed = true;
			return consumed;
		}

		public function getLowestSlot(itype:ItemType):ItemSlotClass
		{
			var minslot:ItemSlotClass = null;
			for each (var slot:ItemSlotClass in itemSlots){
				if (slot.itype == itype){
					if (minslot == null || slot.quantity<minslot.quantity){
						minslot = slot;
					}
				}
			}
			return minslot;
		}
		public function hasItem(itype:ItemType, minQuantity:Number=1):Boolean {
			return itemCount(itype)>=minQuantity;
		}
		public function itemCount(itype:ItemType):int {
			var count:int = 0;
			for each (var itemSlot:ItemSlotClass in itemSlots){
				if (itemSlot.itype == itype) count += itemSlot.quantity;
			}
			return count;
		}

		// 0..5 or -1 if no
		public function roomInExistingStack(itype:ItemType):Number {
			for (var i:int = 0; i<itemSlots.length; i++){
				if(itemSlot(i).itype == itype && itemSlot(i).quantity != 0 && itemSlot(i).quantity < 5)
					return i;
			}
			return -1;
		}

		public function itemSlot(idx:int):ItemSlotClass
		{
			return itemSlots[idx];
		}

		// 0..5 or -1 if no
		public function emptySlot():Number {
		    for (var i:int = 0; i<itemSlots.length;i++){
				if (itemSlot(i).isEmpty() && itemSlot(i).unlocked) return i;
			}
			return -1;
		}


		public function destroyItems(itype:ItemType, numOfItemToRemove:Number):Boolean
		{
			for (var slotNum:int = 0; slotNum < itemSlots.length; slotNum += 1)
			{
				if(itemSlot(slotNum).itype == itype)
				{
					while(itemSlot(slotNum).quantity > 0 && numOfItemToRemove > 0)
					{
						itemSlot(slotNum).removeOneItem();
						numOfItemToRemove--;
					}
				}
			}
			return numOfItemToRemove <= 0;
		}

		public function lengthChange(temp2:Number, ncocks:Number):void {
			//DIsplay the degree of length change.
			if(temp2 <= 1 && temp2 > 0) {
				if(cocks.length == 1) outputText("Your " + cockDescript(0) + " has grown slightly longer.", false);
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("One of your " + multiCockDescriptLight() + " grows slightly longer.", false);
					if(ncocks > 1 && ncocks < cocks.length) outputText("Some of your " + multiCockDescriptLight() + " grow slightly longer.", false);
					if(ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " seem to fill up... growing a little bit larger.", false);
				}
			}
			if(temp2 > 1 && temp2 < 3) {
				if(cocks.length == 1) outputText("A very pleasurable feeling spreads from your groin as your " + cockDescript(0) + " grows permanently longer - at least an inch - and leaks pre-cum from the pleasure of the change.", false);
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A very pleasurable feeling spreads from your groin as your " + multiCockDescriptLight() + " grow permanently longer - at least an inch - and leak plenty of pre-cum from the pleasure of the change.", false);
					if(ncocks == 1) outputText("A very pleasurable feeling spreads from your groin as one of your " + multiCockDescriptLight() + " grows permanently longer, by at least an inch, and leaks plenty of pre-cum from the pleasure of the change.", false);
					if(ncocks > 1 && ncocks < cocks.length) outputText("A very pleasurable feeling spreads from your groin as " + kGAMECLASS.num2Text(ncocks) + " of your " + multiCockDescriptLight() + " grow permanently longer, by at least an inch, and leak plenty of pre-cum from the pleasure of the change.", false);
				}
			}
			if(temp2 >=3){
				if(cocks.length == 1) outputText("Your " + cockDescript(0) + " feels incredibly tight as a few more inches of length seem to pour out from your crotch.", false);
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("Your " + multiCockDescriptLight() + " feel incredibly tight as one of their number begins to grow inch after inch of length.", false);
					if(ncocks > 1 && ncocks < cocks.length) outputText("Your " + multiCockDescriptLight() + " feel incredibly number as " + kGAMECLASS.num2Text(ncocks) + " of them begin to grow inch after inch of added length.", false);
					if(ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " feel incredibly tight as inch after inch of length pour out from your groin.", false);
				}
			}
			//Display LengthChange
			if(temp2 > 0) {
				if(cocks[0].cockLength >= 8 && cocks[0].cockLength-temp2 < 8){
					if(cocks.length == 1) outputText("  <b>Most men would be overly proud to have a tool as long as yours.</b>", false);
					if(cocks.length > 1) outputText("  <b>Most men would be overly proud to have one cock as long as yours, let alone " + multiCockDescript() + ".</b>", false);
				}	
				if(cocks[0].cockLength >= 12 && cocks[0].cockLength-temp2 < 12) {
					if(cocks.length == 1) outputText("  <b>Your " + cockDescript(0) + " is so long it nearly swings to your knee at its full length.</b>", false);
					if(cocks.length > 1) outputText("  <b>Your " + multiCockDescriptLight() + " are so long they nearly reach your knee when at full length.</b>", false);
				}
				if(cocks[0].cockLength >= 16 && cocks[0].cockLength-temp2 < 16) {
					if(cocks.length == 1) outputText("  <b>Your " + cockDescript(0) + " would look more at home on a large horse than you.</b>", false);
					if(cocks.length > 1) outputText("  <b>Your " + multiCockDescriptLight() + " would look more at home on a large horse than on your body.</b>", false);
					if(gender == 3){
						if(cocks.length == 1) outputText("  You could easily stuff your " + cockDescript(0) + " between your breasts and give the self-titty-fuck of a lifetime.", false);
						if(cocks.length > 1) outputText("  They reach so far up your chest it would be easy to stuff a few cocks between your breasts and give yourself the tittyfuck of a lifetime.", false);
					}
					if(gender == 1){
						if(cocks.length == 1) outputText("  Your " + cockDescript(0) + " is so long it easily reaches your chest.  The possibility of autofellatio is now a foregone conclusion.", false);
						if(cocks.length > 1) outputText("  Your " + multiCockDescriptLight() + " are so long they easily reach your chest.  Autofellatio would be about as hard as looking down.", false);
					}
				}
				if(cocks[0].cockLength >= 20 && cocks[0].cockLength-temp2 < 20) {
					if(cocks.length == 1) outputText("  <b>As if the pulsing heat of your " + cockDescript(0) + " wasn't enough, the tip of your " + cockDescript(0) + " keeps poking its way into your view every time you get hard.</b>", false);
					if(cocks.length > 1) outputText("  <b>As if the pulsing heat of your " + multiCockDescriptLight() + " wasn't bad enough, every time you get hard, the tips of your " + multiCockDescriptLight() + " wave before you, obscuring the lower portions of your vision.</b>", false);
					if(cor > 40 && cor <= 60) {
						if(cocks.length > 1) outputText("  You wonder if there is a demon or beast out there that could take the full length of one of your " + multiCockDescriptLight() + "?", false);
						if(cocks.length ==1) outputText("  You wonder if there is a demon or beast out there that could handle your full length.", false);
					}
					if(cor > 60 && cor <= 80) {
						if(cocks.length > 1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your " + multiCockDescriptLight() + " to their hilts, milking you dry.\n\nYou smile at the pleasant thought.", false);
						if(cocks.length ==1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your " + cockDescript(0) + " to the hilt, milking it of all your cum.\n\nYou smile at the pleasant thought.", false);
					}
					if(cor > 80) {
						if(cocks.length > 1) outputText("  You find yourself fantasizing about impaling nubile young champions on your " + multiCockDescriptLight() + " in a year's time.", false);
					}
				}
			}
			//Display the degree of length loss.
			if(temp2 < 0 && temp2 >= -1) {
				if(cocks.length == 1) outputText("Your " + multiCockDescriptLight() + " has shrunk to a slightly shorter length.", false);
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " have shrunk to a slightly shorter length.", false);
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + kGAMECLASS.num2Text(ncocks) + " of your " + multiCockDescriptLight() + " have shrunk to a slightly shorter length.", false);
					if(ncocks == 1) outputText("You feel " + kGAMECLASS.num2Text(ncocks) + " of your " + multiCockDescriptLight() + " has shrunk to a slightly shorter length.", false);
				}
			}
			if(temp2 < -1 && temp2 > -3) {
				if(cocks.length == 1) outputText("Your " + multiCockDescriptLight() + " shrinks smaller, flesh vanishing into your groin.", false);
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " shrink smaller, the flesh vanishing into your groin.", false);
					if(ncocks == 1) outputText("You feel " + kGAMECLASS.num2Text(ncocks) + " of your " + multiCockDescriptLight() + " shrink smaller, the flesh vanishing into your groin.", false);
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + kGAMECLASS.num2Text(ncocks) + " of your " + multiCockDescriptLight() + " shrink smaller, the flesh vanishing into your groin.", false);
				}
			}
			if(temp2 <= -3) {
				if(cocks.length == 1) outputText("A large portion of your " + multiCockDescriptLight() + "'s length shrinks and vanishes.", false);
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A large portion of your " + multiCockDescriptLight() + " receeds towards your groin, receding rapidly in length.", false);
					if(ncocks == 1) outputText("A single member of your " + multiCockDescriptLight() + " vanishes into your groin, receding rapidly in length.", false);
					if(ncocks > 1 && cocks.length > ncocks) outputText("Your " + multiCockDescriptLight() + " tingles as " + kGAMECLASS.num2Text(ncocks) + " of your members vanish into your groin, receding rapidly in length.", false);
				}
			}
		}

		public function killCocks(deadCock:Number):void
		{
			//Count removal for text bits
			var removed:Number = 0;
			var temp:Number;
			//Holds cock index
			var storedCock:Number = 0;
			//Less than 0 = PURGE ALL
			if (deadCock < 0) {
				deadCock = cocks.length;
			}
			//Double loop - outermost counts down cocks to remove, innermost counts down 
			while (deadCock > 0) {
				//Find shortest cock and prune it
				temp = cocks.length;
				while (temp > 0) {
					temp--;
					//If anything is out of bounds set to 0.
					if (storedCock > cocks.length - 1) storedCock = 0;
					//If temp index is shorter than stored index, store temp to stored index.
					if (cocks[temp].cockLength <= cocks[storedCock].cockLength) storedCock = temp;
				}
				//Smallest cock should be selected, now remove it!
				removeCock(storedCock, 1);
				removed++;
				deadCock--;
				if (cocks.length == 0) deadCock = 0;
			}
			//Texts
			if (removed == 1) {
				if (cocks.length == 0) {
					outputText("<b>Your manhood shrinks into your body, disappearing completely.</b>", false);
					if (hasStatusAffect("infested") >= 0) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
				}
				if (cocks.length == 1) {
					outputText("<b>Your smallest penis disappears, shrinking into your body and leaving you with just one " + cockDescript(0) + ".</b>", false);
				}
				if (cocks.length > 1) {
					outputText("<b>Your smallest penis disappears forever, leaving you with just your " + multiCockDescriptLight() + ".</b>", false);
				}
			}
			if (removed > 1) {
				if (cocks.length == 0) {
					outputText("<b>All your male endowments shrink smaller and smaller, disappearing one at a time.</b>", false);
					if (hasStatusAffect("infested") >= 0) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
				}
				if (cocks.length == 1) {
					outputText("<b>You feel " + kGAMECLASS.num2Text(removed) + " cocks disappear into your groin, leaving you with just your " + cockDescript(0) + ".", false);
				}
				if (cocks.length > 1) {
					outputText("<b>You feel " + kGAMECLASS.num2Text(removed) + " cocks disappear into your groin, leaving you with " + multiCockDescriptLight() + ".", false);
				}
			}
			//remove infestation if cockless
			if (cocks.length == 0) removeStatusAffect("infested");
			if (cocks.length == 0 && balls > 0) {
				outputText("  <b>Your " + sackDescript() + " and " + ballsDescriptLight() + " shrink and disappear, vanishing into your groin.</b>", false);
				balls = 0;
				ballSize = 1;
			}
		}
	}
}