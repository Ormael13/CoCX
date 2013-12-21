package classes 
{
	/**
	 * ...
	 * @author Yoffy, Fake-Name
	 */
	public class Monster extends Creature 
	{
		
		protected var mainClassPtr:*;
		//For enemies
		public var bonusHP:Number = 0;
		public var long:String = "<b>You have encountered an unitialized monster. Please report this as a bug</b>.";
		//Is a creature a 'plural' encounter - mob, etc. 
		public var plural:Boolean = false;
		public var imageName:String = "";
		
		//Lust vulnerability
		public var lustVuln:Number = 1;
		
		//temperment - used for determining grapple behaviors
		//0 - avoid grapples/break grapple
		//1 - lust determines > 50 grapple
		//2 - random
		//3 - love grapples
		public var temperment:Number = 0;		
		
		//Used for special attacks. Event codes EVERYWHERE
		public var special1:Number = 0;
		public var special2:Number = 0;
		public var special3:Number = 0;
		
		//he
		public var pronoun1:String = "";
		//him
		public var pronoun2:String = "";
		//3: Possessive his 
		public var pronoun3:String = "";
		
		//Head ornaments. Definitely need to convert away from hard coded types.
		public var antennae:Number = 0;
		public var horns:Number = 0;		
		
		public function Monster(mainClassPtr:*) 
		{
			// trace("Generic Monster Constructor!");
			this.mainClassPtr = mainClassPtr;
			this.gender = GENDER_NONE;

			//// INSTRUCTIONS
			//// Copy-paste remaining code to the new monster constructor
			//// Uncomment and replace placeholder values with your own
			//// If you wish to do some stuff by hand and don't want to use init<idx>XXXX, call skipInit(idx)
			////   or it will be considered as a bug
			//// See following examples and args&docs for initXXXX functions

			//// super(mainClassPtr);
			trace("MONSTER Constructor!");

			//// 1. Names and plural/singular
			//init1Names("a", "short", "imageName", "long", plural=false);

			//// 2. Gender and genitals
			//// 2.1. Genderless with customizable pronouns
			//init2Genderless();
			//init2Genderless("he","him","his");
			//// 2.2. Male with 1-10 cocks, customizable balls, and cum
			//init2Male(new Cock(len=5.5,thickness=1,type=HUMAN));
			//init2Male([new Cock(),new Cock());
			//init2Male(cocks=[new Cock(),new Cock()],balls=0,ballSize=0,cumMultiplier=1,hoursSinceCum=0);
			//// 2.3. Female with customizable vagina. Call twice to create second vagina.
			//init2Female();
			//init2Female(virgin=true,vaginalWetness=VAGINA_WETNESS_NORMAL,vaginalLooseness=VAGINA_LOOSENESS_TIGHT,bonusVCapacity=0);
			//// 2.4. To create a hermaphrodite, call both init2Male and init2Female.
			////      Pronouns (he/she) will be taken from last call

			//// 3. Body features

			this.temperment = 2;
			//Lusty teases
			this.special1 = 5133;
			this.special2 = 5134;
			this.special3 = 5135;

			//Clothing/Armor
			this.armorName = "demon-skin";
			this.weaponName = "flaming whip";
			this.weaponVerb = "flame-whip";

			this.weaponAttack = 15;

			//Primary stats
			this.str = 65;
			this.tou = 40;
			this.spe = 80;
			this.inte = 80;
			this.lib = 75;
			this.sens = 15;
			this.cor = 100;

			//Combat Stats
			this.bonusHP = 200;
			this.HP = eMaxHP();
			this.lustVuln = 0.75;

			this.lust = 30;

			//Level Stats
			this.level = 9;
			this.XP = this.totalXP(mainClassPtr.player.level);;
			this.gems = rand(5) + 38;

			//Appearance Variables
			this.tallness = 66;
			this.hairColor = "black";
			this.hairLength = 20;

			this.skinTone = "purple";
			this.skinDesc = "skin";

			this.lowerBody = LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS;

			this.hipRating = 10;

			this.buttRating = 6;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 7;
			this.ass.analLooseness = 4;
			this.createStatusAffect("Bonus aCapacity",15,0,0,0);
			this.ass.analWetness = 0;

			this.XP = this.totalXP(mainClassPtr.player.level);
		}


		public function eMaxHP():Number 
		{
			return this.tou * 2 + 50 + this.bonusHP;
		}

		protected function totalXP(playerLevel:Number=-1):Number 
		{
			if (playerLevel == -1) return mainClassPtr.player.level;
			//Nerf xp gains by 20% per level over.
			var difference:Number = playerLevel - this.level;
			//No bonuses for underlevel!
			if(difference < 0) difference = 0;
			//No craziness for crazy over-level!
			if(difference > 6) difference = 6;
			//First two levels make no difference
			if(difference <= 2) difference = 0;
			else difference -= 2;
			//convert into something we can multiply by
			difference = (5 - difference) * 20 / 100;
			//Super high level folks only get 1 xp!
			if(playerLevel - this.level > 10) return 1;	
			
			return Math.round((this.baseXP() + this.bonusXP()) * difference);
		}
		protected function baseXP():Number 
		{
			var xp:Number = 0;
			var lev:Number = Math.round(this.level);
			switch(lev) {
				case 1:
					xp = 10;
					break;
				case 2:
					xp = 20;
					break;
				case 3:
					xp = 30;
					break;
				case 4:
					xp = 40;
					break;
				case 5:
					xp = 50;
					break;
				case 6:
					xp = 55;
					break;
				case 7:
					xp = 60;
					break;
				case 8:
					xp = 66;
					break;
				case 9:
					xp = 75;
					break;
				case 10:
					xp = 83;
					break;
				case 11:
					xp = 85;
					break;
				case 12:
					xp = 92;
					break;
				case 13:
					xp = 100;
					break;
				case 14:
					xp = 107;
					break;
				case 15:
					xp = 115;
					break;
				case 16:
					xp = 118;
					break;
				case 17:
					xp = 121;
					break;
				case 18:
					xp = 128;
					break;
				case 19:
					xp = 135;
					break;
				case 20:
					xp = 145;
					break;
				default:
					xp = 200;
					break;
			}
			return xp;
		}
		protected function bonusXP():Number 
		{
			var xp:Number = 0;
			var lev:Number = Math.round(this.level);
			switch(lev) {
				case 1:
					xp = 10;
					break;
				case 2:
					xp = 20;
					break;
				case 3:
					xp = 30;
					break;
				case 4:
					xp = 40;
					break;
				case 5:
					xp = 50;
					break;
				case 6:
					xp = 55;
					break;
				case 7:
					xp = 58;
					break;
				case 8:
					xp = 66;
					break;
				case 9:
					xp = 75;
					break;
				case 10:
					xp = 83;
					break;
				case 11:
					xp = 85;
					break;
				case 12:
					xp = 85;
					break;
				case 13:
					xp = 86;
					break;
				case 14:
					xp = 92;
					break;
				case 15:
					xp = 94;
					break;
				case 16:
					xp = 96;
					break;
				case 17:
					xp = 98;
					break;
				case 18:
					xp = 99;
					break;
				case 19:
					xp = 101;
					break;
				case 20:
					xp = 107;
					break;
				default:
					xp = 130;
					break;
			}
			return rand(xp);
		}

		// MONSTER INITIALIZATION HELPER FUNCTIONS
		public var initsCalled:Array = [false,false];

		public function fullyInit():Boolean {
			return initsCalled.indexOf(false)==-1;
		}

		/**
		 * Tells that skipping init<idx>Whatever is ok and you will initialize corresponding properties by hand
		 */
		protected function skipInit(idx:int){
			this.initsCalled[idx-1] = true;
		}

		/**
		 * Inits a, short, imageName, long, plural
		 */
		protected function init1Names(a:String, short:String, imageName:String, long:String, plural:Boolean = false):void
		{
			this.short = short;
			this.imageName = imageName;
			this.long = long;
			this.a = a;
			this.plural = plural;
			if (plural){
				this.pronoun1 = "they";
				this.pronoun2 = "them";
				this.pronoun3 = "their";
			}
			this.initsCalled[0]=true;
		}

		/**
		 * Inits gender, pronouns. Overrides gender and pronouns set by init2Male and init2Female
		 */
		protected function init2Genderless(pronoun1:String="it",pronoun2:String="it",pronoun3:String="its"):void
		{
			this.gender = GENDER_NONE;
			this.pronoun1 = pronoun1;
			this.pronoun2 = pronoun2;
			this.pronoun3 = pronoun3;
			this.initsCalled[1]=true;
		}

		/**
		 * Inits gender, pronouns. cocks, balls=0, ballSize=0, cumMultiplier=1, hoursSinceCum=0
		 * @param cocks new Cock(len,thick,type) or Array of new Cock(len,thick,type)
		 */
		protected function init2Male(cocks:*=null,balls:Number=0,ballSize:Number=0,cumMultiplier:Number=1,hoursSinceCum:Number=0):void
		{
			if (!this.plural){
				this.pronoun1 = "he";
				this.pronoun2 = "him";
				this.pronoun3 = "his";
			}
			if (cocks == null) cocks=[new Cock()];
			if (cocks is Cock) cocks=[cocks]
			else if (!(cocks is Array)) {
				trace(this.short+".init2Male("+typeof(c)+")");
				cocks = [new Cock()];
			}
			if (cocks.length==0){
				trace(this.short+".init2Male([])");
				cocks = [new Cock()];
			} else if (cocks.length>10){
				trace(this.short+".init2Male.cocks.length="+cocks.length);
				cocks = (cocks as Array).slice(10);
			}
			for (var i:int = 0; i<(cocks as Array).length; i++){
				var c:* = cocks[i];
				if (c is Cock) {
					createCock((c as Cock).cockLength, (c as Cock).cockThickness, (c as Cock).cockType);
				} else {
					trace(this.short+".init2Male.cocks["+i+"]="+typeof(c)+"");
				}
			}
			this.balls = balls;
			this.ballSize = ballSize;
			this.cumMultiplier = cumMultiplier;
			this.hoursSinceCum = hoursSinceCum;
			genderCheck();
			this.initsCalled[1]=true;
		}

		/**
		 * Inits gender, pronouns, 1 vagina
		 */
		protected function init2Female(vaginalWetness:Number = VAGINA_WETNESS_NORMAL, vaginalLooseness:Number = VAGINA_LOOSENESS_TIGHT, bonusVCapacity:Number = 0, virgin:Boolean = false):void
		{
			if (!this.plural){
				this.pronoun1 = "she";
				this.pronoun2 = "her";
				this.pronoun3 = "her";
			}
			if (this.vaginas.length<2) {
				createVagina(virgin,vaginalWetness,vaginalLooseness);
			} else {
				trace(this.short+".init2Female with "+this.vaginas.length+" vaginas");
			}
			if (bonusVCapacity >0){
				this.createStatusAffect("Bonus vCapacity",bonusVCapacity,0,0,0);
			}
			genderCheck();
			this.initsCalled[1]=true;
		}
	}
}