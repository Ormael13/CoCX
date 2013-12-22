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

			//// 3. Breasts
			//// Each row is array of [size=0,nipplesPerBreast=1]
			//// Size could be number, name (see BREAST_CUP_NAMES), or short name
			//init3BreastRows([0,0]); // flat chest, no nipples
			//init3BreastRows(["flat"]); // manly chest with nipples
			//init3BreastRows(["DD+"],["DD"],["D"]); // 3 rows of breasts
			//init3BreastRows([10,2]); // huge boobs with 2 nipples per breasts
			//init3BreastRows(); // no breast rows

			//// 4. Ass
			//init4Ass(looseness=0,wetness=0,bonusACapacity=0)

			//// 5. Body
			//init5Body(tallness,hipRating=HIP_RATING_BOYISH,buttRating=BUTT_RATING_BUTTLESS,lowerBody=LOWER_BODY_TYPE_HUMAN)

			//// 6. Skin
			//init6Skin(skinTone,skinType=SKIN_TYPE_PLAIN,skinDesc="type-dependant if not specified",skinAdj="");
			//init6Skin("ebony"); // skinDesc = "skin"
			//init6Skin("red",SKIN_TYPE_SCALES); // skinDesc = "scales"
			//init6Skin("blue",SKIN_TYPE_GOO); // will also set skinAdj to "goopey"
			//init6Skin("white",SKIN_TYPE_FUR,"fluffy fur","spotted"); // maximum customization

			//// 7. Hair
			//init7Hair(hairColor="no",hairLength=0,hairType=HAIR_NORMAL);

			/*this.temperment = 2;
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
			this.XP = this.totalXP(mainClassPtr.player.level);   */
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
		//noinspection JSUntypedDeclaration
		public var initsCalled:Array =Array(6).map(function(){return false});

		public function isFullyInit():Boolean {
			return initsCalled.indexOf(false)==-1;
		}

		/**
		 * Tells that skipping init<idx>Whatever is ok and you will initialize corresponding properties by hand
		 */
		protected function skipInit(idx:int):void{
			this.initsCalled[idx-1] = true;
		}

		/**
		 * Inits a, short, imageName, long, plural
		 */
		protected function init1Names(a:String, _short:String, imageName:String, _long:String, plural:Boolean = false):void
		{
			this.short = _short;
			this.imageName = imageName;
			this.long = _long;
			this.a = a;
			this.plural = plural;
			if (plural){
				this.pronoun1 = "they";
				this.pronoun2 = "them";
				this.pronoun3 = "their";
			}
			skipInit(1);
		}

		/**
		 * Inits gender, pronouns. Overrides gender and pronouns set by init2Male and init2Female. Does not override pronouns if plural
		 */
		protected function init2Genderless(pronoun1:String="it",pronoun2:String="it",pronoun3:String="its"):void
		{
			this.gender = GENDER_NONE;
			if (!this.plural){
				this.pronoun1 = pronoun1;
				this.pronoun2 = pronoun2;
				this.pronoun3 = pronoun3;
			}
			skipInit(2);
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
			skipInit(2);
		}

		/**
		 * Inits gender, pronouns, 1 vagina. To add second vagina, call method twice. Usage of VAGINA_WETNESS_XXXX and VAGINA_LOOSENESS_XXXX constants is preferable
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
			skipInit(2);
		}

		/**
		 * Each row is [size=0,nipplesPerBreast=1]
		 * Size could be number, name (see BREAST_CUP_NAMES), or short name like "A", "DD+"
		 * To create single row with 1 nipples per breast, you can call init3BreastRows(size)
		 */
		protected function init3BreastRows(... rows):void{
			if (rows.length>0){
				if(! (rows[0] is Array)){
					rows = [rows];
				}
				for (var i:int = 0; i<rows.length; i++){
					var row:* = rows[i];
					if (!(row is Array)) row = [row,1];
					var size:Number;
					if (row[0] is Number) size = row[0];
					else if (row[0] is String) size = Appearance.breastCupInverse(row[0])
					else {
						trace("init3BreastRows.size is "+typeof(row[0]));
						size = 0;
					}
					if (!(row[1] is Number)) {
						trace("init3BreastRows.nipplesPerBreast is "+typeof(row[1]));
						row[1] = 1;
					}
					createBreastRow(size,row[1]);
				}
			}
			skipInit(3);
		}

		/**
		 * Usage of ANAL_LOOSENESS_XXXX and ANAL_WETNESS_XXXX constants is preferrable
		 */
		protected function init4Ass(looseness:Number = 0, wetness:Number = 0, bonusACapacity:Number = 0):void{
			this.ass.analLooseness = looseness;
			this.ass.analWetness = wetness;
			if (bonusACapacity>0) this.createStatusAffect("Bonus aCapacity",bonusACapacity,0,0,0);
			skipInit(4);
		}

		/**
		 * Tallness is in inches or string like "5'6" or "5.5'". Usage of constants HIP_RATING_XXXX, BUTT_RATING_XXXX, LOWER_BODY_XXXX is preferable.
		 */
		protected function init5Body(tallness:*,hipRating:Number=HIP_RATING_BOYISH,buttRating:Number=BUTT_RATING_BUTTLESS,lowerBody:Number=LOWER_BODY_TYPE_HUMAN):void{
			if (tallness is String){
				tallness = tallness.split("'");
				if (tallness.length==1){
					trace("init5Body.tallness=\""+tallness[0]+"\". Interpreted as inches");
				} else if (tallness.length==2){
					tallness = parseFloat(tallness[0])*12+parseFloat(tallness[1]);
				} else {
					trace("init5Body.tallness=\""+tallness.join("'")+"\". Defaulting to 5'");
					tallness = 5*12;
				}
			} else if(!(tallness is Number)){
				trace("init5Body.tallness is "+typeof(tallness));
				tallness = 5*12;
			}
			this.tallness = tallness;
			this.hipRating = hipRating;
			this.buttRating = buttRating;
			this.lowerBody = lowerBody;
			skipInit(5);
		}

		/**
		 * if skinDesc == null, sets default name for type ("skin"/"fur"/...).
		 * Also, for SKIN_TYPE_GOO if skinAdj=="" sets skinAdj="goopey"
		 */
		protected function init6Skin(skinTone:String,skinType:int=SKIN_TYPE_PLAIN,skinDesc:String=null,skinAdj:String=""):void{
			this.skinTone = skinTone;
			this.skinType = skinType;
			this.skinDesc = skinDesc || Appearance.DEFAULT_SKIN_DESCS[skinType];
			this.skinAdj = skinAdj;
			skipInit(6);
		}

		protected function init7Hair(hairColor:String="no",hairLength:Number=0,hairType:int=HAIR_NORMAL):void{
			this.hairColor = hairColor;
			this.hairLength = hairLength;
			this.hairType = hairType;
			skipInit(7);
		}
	}
}