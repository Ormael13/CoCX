package classes
{
import classes.GlobalFlags.kFLAGS;
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

		//Player pregnancy variables and functions
		override public function pregnancyUpdate():Boolean {
			return game.updatePregnancy(); //Returns true if we need to make sure pregnancy texts aren't hidden
		}

		// Inventory
		public var itemSlot1:ItemSlotClass;
		public var itemSlot2:ItemSlotClass;
		public var itemSlot3:ItemSlotClass;
		public var itemSlot4:ItemSlotClass;
		public var itemSlot5:ItemSlotClass;
		public var itemSlots:Array;

		private var _armor:Armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
		private var _modArmorName:String = "";

		override public function set armorValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorValue.");
		}

		override public function set armorName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorName.");
		}

		override public function set armorDef(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorDef.");
		}

		override public function set armorPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorPerk.");
		}


		override public function set weaponName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponName.");
		}

		override public function set weaponVerb(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponVerb.");
		}

		override public function set weaponAttack(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponAttack.");
		}

		override public function set weaponPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponPerk.");
		}

		override public function set weaponValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponValue.");
		}

		public function get modArmorName():String
		{
			if (_modArmorName == null) _modArmorName = "";
			return _modArmorName;
		}

		public function set modArmorName(value:String):void
		{
			if (value == null) value = "";
			_modArmorName = value;
		}

		override public function get armorName():String {
			if (_modArmorName.length > 0) return modArmorName;
			return _armor.name;
		}
		override public function get armorDef():Number {
			var armorDef:Number = _armor.def;
			//Blacksmith history!
			if(armorDef > 0 && findPerk(PerkLib.HistorySmith) >= 0) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			//Skin armor perk
			if(findPerk(PerkLib.ThickSkin) >= 0) {
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
			if(findPerk(PerkLib.Agility) >= 0) {
				if(armorPerk == "Light") armorDef += Math.round(spe/8);
				else if(armorPerk == "Medium") armorDef += Math.round(spe/13);
			}
			//Berzerking removes armor
			if(findStatusAffect(StatusAffects.Berzerking) >= 0) {
				armorDef = 0;
			}
			if(kGAMECLASS.monster.findStatusAffect(StatusAffects.TailWhip) >= 0) {
				armorDef -= kGAMECLASS.monster.statusAffectv1(StatusAffects.TailWhip);
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
			if(findPerk(PerkLib.WeaponMastery) >= 0 && weaponPerk == "Large" && str > 60)
				attack *= 2;
			if(findPerk(PerkLib.LightningStrikes) >= 0 && spe >= 60 && weaponPerk != "Large") {
				attack += Math.round((spe - 50) / 3);
			}
			if(findStatusAffect(StatusAffects.Berzerking) >= 0) attack += 30;
			attack += statusAffectv1(StatusAffects.ChargeWeapon);
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
			value.equip(this, false, false);
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
			value.equip(this, false, false);
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
			if (findStatusAffect(StatusAffects.Shielding) >= 0) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			//Black cat beer = 25% reduction!
			if (statusAffectv1(StatusAffects.BlackCatBeer) > 0)
				damage = Math.round(damage * .75);

			//Take damage you masochist!
			if (findPerk(PerkLib.Masochist) >= 0 && lib >= 60) {
				damage = Math.round(damage * .7);
				game.dynStats("lus", 2);
				//Dont let it round too far down!
				if (damage < 1) damage = 1;
			}
			if (findPerk(PerkLib.ImmovableObject) >= 0 && tou >= 75) {
				damage = Math.round(damage * .8);
				if (damage < 1) damage = 1;
			}

			// Uma's Massage bonuses
			var statIndex:int = findStatusAffect(StatusAffects.UmasMassage);
			if (statIndex >= 0) {
				if (statusAffect(statIndex).value1 == UmasShop.MASSAGE_RELAXATION) {
					damage = Math.round(damage * statusAffect(statIndex).value2);
				}
			}

			// Uma's Accupuncture Bonuses
			var modArmorDef:Number = 0;
			if (findPerk(PerkLib.ChiReflowDefense) >= 0) modArmorDef = ((armorDef * UmasShop.NEEDLEWORK_DEFENSE_DEFENSE_MULTI) - armorDef);
			if (findPerk(PerkLib.ChiReflowAttack) >= 0) modArmorDef = ((armorDef * UmasShop.NEEDLEWORK_ATTACK_DEFENSE_MULTI) - armorDef);
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
			//Determine race type:
			var race:String = "human";
			if (lowerBody == 4)
				race = "centaur";
			if (lowerBody == 11)
				race = "pony-kin";
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
					race = "fox-" + mf("morph", "girl");
			}
			if (ferretScore() >= 4)
			{
				if (skinType == 1)
					race = "ferret-morph";
				else
					race = "ferret-" + mf("morph", "girl");
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

		public function get minotaurScore():Number
		{
			return this.minoScore();
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
			if (findStatusAffect(StatusAffects.BlackNipples) >= 0)
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
		//Determine Ferret Rating!
		public function ferretScore():Number
		{
			var counter:int = 0;
			if (faceType == FACE_FERRET_MASK) counter++;
			if (faceType == FACE_FERRET) counter+=2;
			if (earType == EARS_FERRET) counter++;
			if (tailType == TAIL_TYPE_FERRET) counter++;
			if (lowerBody == LOWER_BODY_FERRET) counter++;
			if (skinType == SKIN_TYPE_FUR && counter > 0) counter++;
			return counter;
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
			if (findStatusAffect(StatusAffects.SlimeCraving) >= 0)
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
			var total:Number;
			if (findStatusAffect(StatusAffects.LactationEndurance) < 0)
				createStatusAffect(StatusAffects.LactationEndurance, 1, 0, 0, 0);
			total = biggestTitSize() * 10 * averageLactation() * statusAffectv1(StatusAffects.LactationEndurance) * totalBreasts();
			if (statusAffectv1(StatusAffects.LactationReduction) >= 48)
				total = total * 1.5;
			return total;
		}
		
		public function isLactating():Boolean
		{
			if (lactationQ() > 0) return true;
			return false;
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
			if(findStatusAffect(StatusAffects.SlimeCraving) >= 0) {
				//Reset craving value
				changeStatusValue(StatusAffects.SlimeCraving,1,0);
				//Flag to display feed update and restore stats in event parser
				if(findStatusAffect(StatusAffects.SlimeCravingFeed) < 0) {
					createStatusAffect(StatusAffects.SlimeCravingFeed,0,0,0,0);
				}
			}
			if(findPerk(PerkLib.Diapause) >= 0) {
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
			//PUT SOME CAPS ON DAT' SHIT
			if(raw > 50) raw = 50;
			if(raw < -50) raw = -50;
			flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] += raw;
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
			return [StatusAffects.KnowsArouse,StatusAffects.KnowsHeal,StatusAffects.KnowsMight,StatusAffects.KnowsCharge,StatusAffects.KnowsBlind,StatusAffects.KnowsWhitefire]
					.filter(function(item:StatusAffectType,index:int,array:Array):Boolean{
						return this.findStatusAffect(item)>=0;},this)
					.length;
		}

		public function hairDescript():String
		{
			return Appearance.hairDescription(this);
		}

		public function shrinkTits(ignore_hyper_happy:Boolean=false):void
		{
			if (flags[kFLAGS.HYPER_HAPPY] && !ignore_hyper_happy)
			{
				return;
			}
			if(breastRows.length == 1) {
				if(breastRows[0].breastRating > 0) {
					//Shrink if bigger than N/A cups
					var temp:Number;
					temp = 1;
					breastRows[0].breastRating--;
					//Shrink again 50% chance
					if(breastRows[0].breastRating >= 1 && rand(2) == 0 && findPerk(PerkLib.BigTits) < 0) {
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
			if(findPerk(PerkLib.BigTits) >= 0 && rand(3) == 0 && amount < 1) amount=1;

			// Needs to be a number, since uint will round down to 0 prevent growth beyond a certain point
			var temp:Number = breastRows.length;
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
					if (!flags[kFLAGS.HYPER_HAPPY])
					{
						//Diminishing returns!
						if(breastRows[temp2].breastRating > 3)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=1.5;
							else
								temp /=1.3;
						}

						// WHy are there three options here. They all have the same result.
						if(breastRows[temp2].breastRating > 7)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 9)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 12)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=2;
							else
								temp  /=1.5;
						}
					}

					//Grow!
					trace("Growing breasts by ", temp);
					breastRows[temp2].breastRating += temp;
					rowsGrown--;
				}
			}

			if (!flags[kFLAGS.HYPER_HAPPY])
			{
				//Diminishing returns!
				if(breastRows[0].breastRating > 3) {
					if(findPerk(PerkLib.BigTits) < 0) amount/=1.5;
					else amount/=1.3;
				}
				if(breastRows[0].breastRating > 7) {
					if(findPerk(PerkLib.BigTits) < 0) amount/=2;
					else amount /= 1.5;
				}
				if(breastRows[0].breastRating > 12) {
					if(findPerk(PerkLib.BigTits) < 0) amount/=2;
					else amount /= 1.5;
				}
			}
			/*if(breastRows[0].breastRating > 12) {
				if(hasPerk("Big Tits") < 0) amount/=2;
				else amount /= 1.5;
			}*/
			if(growthType == 2) {
				temp = 0;
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
			trace("Growth ammout = ", amount);
			if(display) {
				if(growthType < 3) {
					if(amount <= 2)
					{
						if(breastRows.length > 1) outputText("Your rows of " + breastDescript(0) + " jiggle with added weight, growing a bit larger.", false);
						if(breastRows.length == 1) outputText("Your " + breastDescript(0) + " jiggle with added weight as they expand, growing a bit larger.", false);
					}
					else if(amount <= 4)
					{
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your rows of " + breastDescript(0) + " expand significantly.", false);
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.", false);
					}
					else
					{
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your " + breastDescript(0) + " tingle strongly, growing disturbingly large.", false);
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.", false);
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5)
					{
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
			if(findStatusAffect(StatusAffects.BimboChampagne) >= 0 || findPerk(PerkLib.BimboBody) >= 0 || findPerk(PerkLib.BroBody) >= 0 || findPerk(PerkLib.FutaForm) >= 0) {
				if(min > 40) min += 10;
				else if(min >= 20) min += 20;
				else min += 40;
			}
			//Omnibus' Gift
			if(findPerk(PerkLib.OmnibusGift) >= 0) {
				if(min > 40) min += 10;
				else if(min >= 20) min += 20;
				else min += 35;
			}
			//Nymph perk raises to 30
			if(findPerk(PerkLib.Nymphomania) >= 0) {
				if(min >= 40) min += 10;
				else if(min >= 20) min += 15;
				else min += 30;
			}
			//Oh noes anemone!
			if(findStatusAffect(StatusAffects.AnemoneArousal) >= 0) {
				if(min >= 40) min += 10;
				else if(min >= 20) min += 20;
				else min += 30;
			}
			//Hot blooded perk raises min lust!
			if(findPerk(PerkLib.HotBlooded) >= 0) {
				if(min > 0) min += perk(findPerk(PerkLib.HotBlooded)).value1 / 2;
				else min += perk(findPerk(PerkLib.HotBlooded)).value1;
			}
			if(findPerk(PerkLib.LuststickAdapted) > 0) {
				if(min < 50) min += 10;
				else min += 5;
			}
			//Add points for Crimstone
			min += perkv1(PerkLib.PiercedCrimstone);
			min += perkv1(PerkLib.PentUp);
			//Harpy Lipstick status forces minimum lust to be at least 50.
			if(min < 50 && findStatusAffect(StatusAffects.Luststick) >= 0) min = 50;
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
			return findPerk(PerkLib.MinotaurCumAddict) >= 0 || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 1;
		}
		public function minotaurNeed():Boolean {
			return flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1;
		}

		public function clearStatuses(visibility:Boolean):void
		{
			while(findStatusAffect(StatusAffects.Web) >= 0) {
				spe += statusAffectv1(StatusAffects.Web);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				removeStatusAffect(StatusAffects.Web);
			}
			if(findStatusAffect(StatusAffects.Shielding) >= 0) removeStatusAffect(StatusAffects.Shielding);
			if(findStatusAffect(StatusAffects.HolliConstrict) >= 0) removeStatusAffect(StatusAffects.HolliConstrict);
			if(findStatusAffect(StatusAffects.LustStones) >= 0) removeStatusAffect(StatusAffects.LustStones);
			if(kGAMECLASS.monster.findStatusAffect(StatusAffects.Sandstorm) >= 0) kGAMECLASS.monster.removeStatusAffect(StatusAffects.Sandstorm);
			if(findStatusAffect(StatusAffects.Sealed) >= 0) {
				removeStatusAffect(StatusAffects.Sealed);
			}
			if(findStatusAffect(StatusAffects.Berzerking) >= 0) {
				removeStatusAffect(StatusAffects.Berzerking);
			}
			if(kGAMECLASS.monster.findStatusAffect(StatusAffects.TailWhip) >= 0) {
				kGAMECLASS.monster.removeStatusAffect(StatusAffects.TailWhip);
			}
			if(findStatusAffect(StatusAffects.UBERWEB) >= 0) removeStatusAffect(StatusAffects.UBERWEB);
			if(findStatusAffect(StatusAffects.DriderKiss) >= 0) removeStatusAffect(StatusAffects.DriderKiss);
			if(findStatusAffect(StatusAffects.WebSilence) >= 0) removeStatusAffect(StatusAffects.WebSilence);
			if(findStatusAffect(StatusAffects.GooArmorSilence) >= 0) removeStatusAffect(StatusAffects.GooArmorSilence);
			if(findStatusAffect(StatusAffects.Bound) >= 0) removeStatusAffect(StatusAffects.Bound);
			if(findStatusAffect(StatusAffects.GooArmorBind) >= 0) removeStatusAffect(StatusAffects.GooArmorBind);
			if(findStatusAffect(StatusAffects.Whispered) >= 0) removeStatusAffect(StatusAffects.Whispered);
			if(findStatusAffect(StatusAffects.AkbalSpeed) >= 0) {
				kGAMECLASS.dynStats("spe", statusAffectv1(StatusAffects.AkbalSpeed) * -1);
				removeStatusAffect(StatusAffects.AkbalSpeed);
			}
			if(findStatusAffect(StatusAffects.AmilyVenom) >= 0) {
				kGAMECLASS.dynStats("str", statusAffectv1(StatusAffects.AmilyVenom),"spe", statusAffectv2(StatusAffects.AmilyVenom));
				removeStatusAffect(StatusAffects.AmilyVenom);
			}
			while(findStatusAffect(StatusAffects.Blind) >= 0) {
				removeStatusAffect(StatusAffects.Blind);
			}
			if(findStatusAffect(StatusAffects.SheilaOil) >= 0) {
				removeStatusAffect(StatusAffects.SheilaOil);
			}
			if(kGAMECLASS.monster.findStatusAffect(StatusAffects.TwuWuv) >= 0) {
				inte += kGAMECLASS.monster.statusAffectv1(StatusAffects.TwuWuv);
				kGAMECLASS.statScreenRefresh();
				kGAMECLASS.mainView.statsView.showStatUp( 'inte' );
			}
			if(findStatusAffect(StatusAffects.NagaVenom) >= 0) {
				spe += statusAffectv1(StatusAffects.NagaVenom);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				//stats(0,0,statusAffectv1(StatusAffects.NagaVenom),0,0,0,0,0);
				removeStatusAffect(StatusAffects.NagaVenom);
			}
			if(findStatusAffect(StatusAffects.TentacleBind) >= 0) removeStatusAffect(StatusAffects.TentacleBind);
			if(findStatusAffect(StatusAffects.NagaBind) >= 0) removeStatusAffect(StatusAffects.NagaBind);
			if(findStatusAffect(StatusAffects.StoneLust) >= 0) {
				removeStatusAffect(StatusAffects.StoneLust);
			}
			removeStatusAffect(StatusAffects.FirstAttack);
			if(findStatusAffect(StatusAffects.TemporaryHeat) >= 0) removeStatusAffect(StatusAffects.TemporaryHeat);
			if(findStatusAffect(StatusAffects.NoFlee) >= 0) removeStatusAffect(StatusAffects.NoFlee);
			if(findStatusAffect(StatusAffects.Poison) >= 0) removeStatusAffect(StatusAffects.Poison);
			if(findStatusAffect(StatusAffects.IsabellaStunned) >= 0) removeStatusAffect(StatusAffects.IsabellaStunned);
			if(findStatusAffect(StatusAffects.Stunned) >= 0) removeStatusAffect(StatusAffects.Stunned);
			if(findStatusAffect(StatusAffects.Confusion) >= 0) removeStatusAffect(StatusAffects.Confusion);
			if(findStatusAffect(StatusAffects.ThroatPunch) >= 0) removeStatusAffect(StatusAffects.ThroatPunch);
			if(findStatusAffect(StatusAffects.KissOfDeath) >= 0) removeStatusAffect(StatusAffects.KissOfDeath);
			if(findStatusAffect(StatusAffects.AcidSlap) >= 0) removeStatusAffect(StatusAffects.AcidSlap);
			if(findStatusAffect(StatusAffects.GooBind) >= 0) removeStatusAffect(StatusAffects.GooBind);
			if(findStatusAffect(StatusAffects.HarpyBind) >= 0) removeStatusAffect(StatusAffects.HarpyBind);
			if(findStatusAffect(StatusAffects.CalledShot) >= 0) {
				spe += statusAffectv1(StatusAffects.CalledShot);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speDown.visible = false;
				// speUp.visible = true;
				removeStatusAffect(StatusAffects.CalledShot);
			}
			if(findStatusAffect(StatusAffects.DemonSeed) >= 0) {
				removeStatusAffect(StatusAffects.DemonSeed);
			}
			if(findStatusAffect(StatusAffects.ParalyzeVenom) >= 0) {
				str += statusAffect(findStatusAffect(StatusAffects.ParalyzeVenom)).value1;
				spe += statusAffect(findStatusAffect(StatusAffects.ParalyzeVenom)).value2;
				removeStatusAffect(StatusAffects.ParalyzeVenom);
			}
			if(findStatusAffect(StatusAffects.lustvenom) >= 0) {
				removeStatusAffect(StatusAffects.lustvenom);
			}
			if(findStatusAffect(StatusAffects.InfestAttempted) >= 0) {
				removeStatusAffect(StatusAffects.InfestAttempted);
			}
			if(findStatusAffect(StatusAffects.Might) >= 0) {
				kGAMECLASS.dynStats("str", -statusAffectv1(StatusAffects.Might),"tou", -statusAffectv2(StatusAffects.Might));
				removeStatusAffect(StatusAffects.Might);
			}
			if(findStatusAffect(StatusAffects.ChargeWeapon) >= 0) {
				removeStatusAffect(StatusAffects.ChargeWeapon);
			}
			if(findStatusAffect(StatusAffects.Disarmed) >= 0) {
				removeStatusAffect(StatusAffects.Disarmed);
				if(weapon == WeaponLib.FISTS) {
					weapon = ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon;
				}
				else {
					flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID];
				}
			}
			if(findStatusAffect(StatusAffects.AnemoneVenom) >= 0) {
				str += statusAffectv1(StatusAffects.AnemoneVenom);
				spe += statusAffectv2(StatusAffects.AnemoneVenom);
				//Make sure nothing got out of bounds
				kGAMECLASS.dynStats("cor", 0);

				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				kGAMECLASS.mainView.statsView.showStatUp( 'str' );
				// speUp.visible = true;
				// strUp.visible = true;
				removeStatusAffect(StatusAffects.AnemoneVenom);
			}
			if(findStatusAffect(StatusAffects.GnollSpear) >= 0) {
				spe += statusAffectv1(StatusAffects.GnollSpear);
				//Make sure nothing got out of bounds
				kGAMECLASS.dynStats("cor", 0);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				removeStatusAffect(StatusAffects.GnollSpear);
			}
			if(findStatusAffect(StatusAffects.BasiliskCompulsion) >= 0) removeStatusAffect(StatusAffects.BasiliskCompulsion);
			if(findStatusAffect(StatusAffects.BasiliskSlow) >= 0) {
				spe += statusAffectv1(StatusAffects.BasiliskSlow);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				removeStatusAffect(StatusAffects.BasiliskSlow);
			}
			while(findStatusAffect(StatusAffects.IzmaBleed) >= 0) removeStatusAffect(StatusAffects.IzmaBleed);
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

			if (temp2 < 0 && flags[kFLAGS.HYPER_HAPPY])  // Early return for hyper-happy cheat if the call was *supposed* to shrink a cock.
			{
				return;
			}
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
					if(cocks.length > 1) outputText("  <b>Your " + multiCockDescriptLight() + " are so long they nearly reach your knees when at full length.</b>", false);
				}
				if(cocks[0].cockLength >= 16 && cocks[0].cockLength-temp2 < 16) {
					if(cocks.length == 1) outputText("  <b>Your " + cockDescript(0) + " would look more at home on a large horse than you.</b>", false);
					if(cocks.length > 1) outputText("  <b>Your " + multiCockDescriptLight() + " would look more at home on a large horse than on your body.</b>", false);
					if(gender == 3){
						if(cocks.length == 1) outputText("  You could easily stuff your " + cockDescript(0) + " between your breasts and give yourself the titty-fuck of a lifetime.", false);
						if(cocks.length > 1) outputText("  They reach so far up your chest it would be easy to stuff a few cocks between your breasts and give yourself the titty-fuck of a lifetime.", false);
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
					if (findStatusAffect(StatusAffects.Infested) >= 0) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
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
					if (findStatusAffect(StatusAffects.Infested) >= 0) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
				}
				if (cocks.length == 1) {
					outputText("<b>You feel " + kGAMECLASS.num2Text(removed) + " cocks disappear into your groin, leaving you with just your " + cockDescript(0) + ".", false);
				}
				if (cocks.length > 1) {
					outputText("<b>You feel " + kGAMECLASS.num2Text(removed) + " cocks disappear into your groin, leaving you with " + multiCockDescriptLight() + ".", false);
				}
			}
			//remove infestation if cockless
			if (cocks.length == 0) removeStatusAffect(StatusAffects.Infested);
			if (cocks.length == 0 && balls > 0) {
				outputText("  <b>Your " + sackDescript() + " and " + ballsDescriptLight() + " shrink and disappear, vanishing into your groin.</b>", false);
				balls = 0;
				ballSize = 1;
			}
		}
		public function modCumMultiplier(delta:Number):Number
		{
			trace("modCumMultiplier called with: " + delta);
		
			if (delta == 0) {
				trace( "Whoops! modCumMuliplier called with 0... aborting..." );
				return delta;
			}
			else if (delta > 0) {
				trace("and increasing");
				if (findPerk(PerkLib.MessyOrgasms) >= 0) {
					trace("and MessyOrgasms found");
					delta *= 1.5
				}
			}
			else if (delta < 0) {
				trace("and decreasing");
				if (findPerk(PerkLib.MessyOrgasms) >= 0) {
					trace("and MessyOrgasms found");
					delta *= 0.5
				}
			}

			trace("and modifying by " + delta);
			cumMultiplier += delta;
			return delta;
		}

		public function increaseCock(cockNum:Number, lengthDelta:Number):Number
		{
			var bigCock:Boolean = false;
	
			if (findPerk(PerkLib.BigCock) >= 0)
				bigCock = true;

			return cocks[cockNum].growCock(lengthDelta, bigCock);
		}
		
		public function increaseEachCock(lengthDelta:Number):Number
		{
			var totalGrowth:Number = 0;
			
			for (var i:Number = 0; i < cocks.length; i++) {
				trace( "increaseEachCock at: " + i);
				totalGrowth += increaseCock(i as Number, lengthDelta);
			}
			
			return totalGrowth;
		}
		
		// Attempts to put the player in heat (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if she is already pregnant or is a he.
		// 
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the 
		// duration and intensity. Defaults to 1.
		public function goIntoHeat(output:Boolean, intensity:int = 1):Boolean {
			if(!hasVagina() || pregnancyIncubation != 0) {
				// No vagina or already pregnant, can't go into heat.
				return false;
			}
			
			//Already in heat, intensify further.
			if (inHeat) {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Despite already being in heat, the desire to copulate constantly grows even larger.", false);
				}
				var temp:Number = findStatusAffect(StatusAffects.Heat);
				statusAffect(temp).value1 += 5 * intensity;
				statusAffect(temp).value2 += 5 * intensity;
				statusAffect(temp).value3 += 48 * intensity;
				game.dynStats("lib", 5 * intensity, "resisted", false, "noBimbo", true);
			}
			//Go into heat.  Heats v1 is bonus fertility, v2 is bonus libido, v3 is hours till it's gone
			else {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Your hands begin stroking your body from top to bottom, your sensitive skin burning with desire.  Fantasies about bending over and presenting your needy pussy to a male overwhelm you as <b>you realize you have gone into heat!</b>", false);
				}
				createStatusAffect(StatusAffects.Heat, 10 * intensity, 15 * intensity, 48 * intensity, 0);
				game.dynStats("lib", 15 * intensity, "resisted", false, "noBimbo", true);
			}
			return true;
		}
		
		// Attempts to put the player in rut (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if he is a she.
		// 
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the 
		// duration and intensity. Defaults to 1.
		public function goIntoRut(output:Boolean, intensity:int = 1):Boolean {
			if (!hasCock()) {
				// No cocks, can't go into rut.
				return false;
			}
			
			//Has rut, intensify it!
			if (inRut) {
				if(output) {
					outputText("\n\nYour " + cockDescript(0) + " throbs and dribbles as your desire to mate intensifies.  You know that <b>you've sunken deeper into rut</b>, but all that really matters is unloading into a cum-hungry cunt.", false);
				}
				
				addStatusValue(StatusAffects.Rut, 1, 100 * intensity);
				addStatusValue(StatusAffects.Rut, 2, 5 * intensity);
				addStatusValue(StatusAffects.Rut, 3, 48 * intensity);
				game.dynStats("lib", 5 * intensity, "resisted", false, "noBimbo", true);
			}
			else {
				if(output) {
					outputText("\n\nYou stand up a bit straighter and look around, sniffing the air and searching for a mate.  Wait, what!?  It's hard to shake the thought from your head - you really could use a nice fertile hole to impregnate.  You slap your forehead and realize <b>you've gone into rut</b>!", false);
				}
				
				//v1 - bonus cum production
				//v2 - bonus libido
				//v3 - time remaining!
				createStatusAffect(StatusAffects.Rut, 150 * intensity, 5 * intensity, 100 * intensity, 0);
				game.dynStats("lib", 5 * intensity, "resisted", false, "noBimbo", true);
			}
			
			return true;
		}
	}
}
