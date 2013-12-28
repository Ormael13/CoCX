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
		private var _long:String = "<b>You have encountered an unitialized monster. Please report this as a bug</b>.";
		public function get long():String
		{
			return _long;
		}
		public function set long(value:String):void
		{
			_long = value;
		}

		//Is a creature a 'plural' encounter - mob, etc.
		public var plural:Boolean = false;
		public var imageName:String = "";
		
		//Lust vulnerability
		public var lustVuln:Number = 1;
		
		public static const TEMPERMENT_AVOID_GRAPPLES:int = 0;
		public static const TEMPERMENT_LUSTY_GRAPPLES:int = 1;
		public static const TEMPERMENT_RANDOM_GRAPPLES:int = 2;
		public static const TEMPERMENT_LOVE_GRAPPLES:int = 3;
		/**
		 * temperment - used for determining grapple behaviors
		 * 0 - avoid grapples/break grapple
		 * 1 - lust determines > 50 grapple
		 * 2 - random
		 * 3 - love grapples
		*/
		public var temperment:Number = TEMPERMENT_AVOID_GRAPPLES;
		
		//Used for special attacks. Event codes EVERYWHERE
		public var special1:Number = 0;
		public var special2:Number = 0;
		public var special3:Number = 0;
		
		//he
		public var pronoun1:String = "";
		public function get Pronoun1():String{
			if (pronoun1=="") return "";
			return pronoun1.substr(0,1).toUpperCase()+pronoun1.substr(1);
		}
		//him
		public var pronoun2:String = "";
		public function get Pronoun2():String{
			if (pronoun2=="") return "";
			return pronoun2.substr(0,1).toUpperCase()+pronoun2.substr(1);
		}
		//3: Possessive his
		public var pronoun3:String = "";
		public function get Pronoun3():String{
			if (pronoun3=="") return "";
			return pronoun3.substr(0,1).toUpperCase()+pronoun3.substr(1);
		}

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
			//// See following examples and args&docs for init* functions

			// super(mainClassPtr);

			//// REQUIRED INIITIALIZERS (01-13)

			//// 1. Names and plural/singular
			//init01Names("a", "short", "imageName", "long", plural=false);

			//// 2. Gender and genitals
			//// 2.1. Genderless with customizable pronouns
			//init02Genderless();
			//init02Genderless("he","him","his");
			//// 2.2. Male with 1-10 cocks, customizable balls, and cum
			//init02Male(new Cock(len=5.5,thickness=1,type=HUMAN));
			//init02Male([new Cock(),new Cock());
			//init02Male(cocks=[new Cock(),new Cock()],balls=0,ballSize=0,cumMultiplier=1,hoursSinceCum=0);
			//// 2.3. Female with customizable vagina. Call twice to create second vagina.
			//init02Female();
			//init02Female(virgin=true,vaginalWetness=VAGINA_WETNESS_NORMAL,vaginalLooseness=VAGINA_LOOSENESS_TIGHT,bonusVCapacity=0);
			//// 2.4. To create a hermaphrodite, call both init2Male and init2Female.
			////      Pronouns (he/she) will be taken from last call

			//// 3. Breasts
			//// Each row is array of [size=0,nipplesPerBreast=1]
			//// Size could be number, name (see BREAST_CUP_NAMES), or short name
			//init03BreastRows([0,0]); // flat chest, no nipples
			//init03BreastRows(["flat"]); // manly chest with nipples
			//init03BreastRows(["DD+"],["DD"],["D"]); // 3 rows of breasts
			//init03BreastRows([10,2]); // huge boobs with 2 nipples per breasts
			//init03BreastRows(); // no breast rows

			//// 4. Ass
			//init04Ass(looseness=0,wetness=0,bonusACapacity=0)

			//// 5. Body
			//init05Body(tallness,hipRating=HIP_RATING_BOYISH,buttRating=BUTT_RATING_BUTTLESS,lowerBody=LOWER_BODY_TYPE_HUMAN,armType=ARM_TYPE_HUMAN)

			//// 6. Skin
			//init06Skin(skinTone,skinType=SKIN_TYPE_PLAIN,skinDesc="type-dependant if not specified",skinAdj="");
			//init06Skin("ebony"); // skinDesc = "skin"
			//init06Skin("red",SKIN_TYPE_SCALES); // skinDesc = "scales"
			//init06Skin("blue",SKIN_TYPE_GOO); // will also set skinAdj to "goopey"
			//init06Skin("white",SKIN_TYPE_FUR,"fluffy fur","spotted"); // maximum customization

			//// 7. Hair
			//init7Hair(hairColor="no",hairLength=0,hairType=HAIR_NORMAL);

			//// 8. Face
			//init08Face(faceType=FACE_HUMAN,earType=EARS_HUMAN,tongueType=TONGUE_HUMAN,eyeType=EYES_HUMAN);

			//// 9. Primary stats. No default values
			//init09PrimaryStats(str, tou, spe, inte, lib, sens, cor)

			//// 10. Weapon
			//init10Weapon(weaponName,weaponVerb,weaponAttack=0,weaponPerk="",weaponValue=0);

			//// 11. Armor
			//init11Armor(armorName,armorDef,armorPerk="",armorValue=0);

			//// 12. Combat
			//init12Combat(bonusHP=0,lust=0,lustVuln=1,fatigue=0);

			//// 13. Level
			//init13Level(level,gems,additionalXP);

			//// OPTIONAL INITIALIZERS

			//// Special attacks
			//initX_Specials(special1=0,special2=0,special3=0);

			//// Tail
			//initX_Tail(tailType=TAIL_TYPE_NONE,tailVenom=0,tailRecharge=0);

			//// Horns
			//initX_Horns(hornType=HORNS_NONE,horns=0);

			//// Wings. wingDesc=null means default desc for type
			//initX_Wings(wingType=WING_TYPE_NONE,wingDesc=null);

			//// Antennae.
			//initX_Antennae(antennae=ANTENNAE_NONE);
		}


		public function eMaxHP():Number 
		{
			return this.tou * 2 + 50 + this.bonusHP;
		}

		public function addHP(hp:Number):void{
			this.HP += hp;
			if (this.HP<0) this.HP = 0;
			else if (this.HP>eMaxHP()) this.HP = eMaxHP();
		}

		/**
		 * @return HP/eMaxHP()
		 */
		public function HPRatio():Number{
			return HP/eMaxHP();
		}

		protected function totalXP(playerLevel:Number=-1):Number
		{
			if (playerLevel == -1) playerLevel = mainClassPtr.player.level;
			//
			// 1) Nerf xp gains by 20% per level after first two level difference
			// 2) No bonuses for underlevel!
			// 3) Super high level folks (over 10 levels) only get 1 xp!
			var difference:Number = playerLevel - this.level;
			if(difference <= 2) difference = 0;
			else difference -= 2;
			if(difference > 4) difference = 4;
			difference = (5 - difference) * 20.0 / 100.0;
			if(playerLevel - this.level > 10) return 1;
			return Math.round((this.baseXP() + this.bonusXP()) * difference);
		}
		protected function baseXP():Number 
		{
			return[200, 10, 20, 30, 40, 50, 55, 60, 66, 75,//0-9
				83, 85, 92, 100, 107, 115, 118, 121, 128, 135,//10-19
				145][Math.round(level)] || 200;
		}
		protected function bonusXP():Number 
		{
			return rand([200,10,20,30,40,50,55,58,66,75,
					83,85,85,86,92,94,96,98,99,101,
					107][Math.round(this.level)] || 130);
		}

		// MONSTER INITIALIZATION HELPER FUNCTIONS
		public var initsCalled:Array = new Array(13).map(function():*{return false});

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
		protected function init01Names(a:String, _short:String, imageName:String, _long:String, plural:Boolean = false):void
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
		protected function init02Genderless(pronoun1:String="it",pronoun2:String="it",pronoun3:String="its"):void
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
		protected function init02Male(cocks:*=null,balls:Number=0,ballSize:Number=0,cumMultiplier:Number=1,hoursSinceCum:Number=0):void
		{
			if (!this.plural){
				this.pronoun1 = "he";
				this.pronoun2 = "him";
				this.pronoun3 = "his";
			}
			if (cocks == null) cocks=[new Cock()];
			if (cocks is Cock) cocks=[cocks]
			else if (!(cocks is Array)) {
				trace(this.short+".init02Male("+typeof(c)+")");
				cocks = [new Cock()];
			}
			if (cocks.length==0){
				trace(this.short+".init02Male([])");
				cocks = [new Cock()];
			} else if (cocks.length>10){
				trace(this.short+".init02Male.cocks.length="+cocks.length);
				cocks = (cocks as Array).slice(10);
			}
			for (var i:int = 0; i<(cocks as Array).length; i++){
				var c:* = cocks[i];
				if (c is Cock) {
					createCock((c as Cock).cockLength, (c as Cock).cockThickness, (c as Cock).cockType);
				} else {
					trace(this.short+".init02Male.cocks["+i+"]="+typeof(c)+"");
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
		protected function init02Female(vaginalWetness:Number = VAGINA_WETNESS_NORMAL, vaginalLooseness:Number = VAGINA_LOOSENESS_TIGHT, bonusVCapacity:Number = 0, virgin:Boolean = false):void
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
		protected function init03BreastRows(... rows):void{
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
						trace("init03BreastRows.size is "+typeof(row[0]));
						size = 0;
					}
					if (!(row[1] is Number)) {
						trace("init03BreastRows.nipplesPerBreast is "+typeof(row[1]));
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
		protected function init04Ass(looseness:Number = 0, wetness:Number = 0, bonusACapacity:Number = 0):void{
			this.ass.analLooseness = looseness;
			this.ass.analWetness = wetness;
			if (bonusACapacity>0) this.createStatusAffect("Bonus aCapacity",bonusACapacity,0,0,0);
			skipInit(4);
		}

		/**
		 * Tallness is in inches or string like "5'6" or "5.5'". Usage of constants HIP_RATING_XXXX, BUTT_RATING_XXXX, LOWER_BODY_XXXX is preferable.
		 */
		protected function init05Body(tallness:*,hipRating:Number=HIP_RATING_BOYISH,buttRating:int=BUTT_RATING_BUTTLESS,lowerBody:int=LOWER_BODY_TYPE_HUMAN,armType:int=ARM_TYPE_HUMAN):void{
			if (tallness is String){
				tallness = tallness.split("'");
				if (tallness.length==1){
					trace("init05Body.tallness=\""+tallness[0]+"\". Interpreted as inches");
				} else if (tallness.length==2){
					tallness = parseFloat(tallness[0])*12+parseFloat(tallness[1]);
				} else {
					trace("init05Body.tallness=\""+tallness.join("'")+"\". Defaulting to 5'");
					tallness = 5*12;
				}
			} else if(!(tallness is Number)){
				trace("init05Body.tallness is "+typeof(tallness));
				tallness = 5*12;
			}
			this.tallness = tallness;
			this.hipRating = hipRating;
			this.buttRating = buttRating;
			this.lowerBody = lowerBody;
			this.armType = armType;
			skipInit(5);
		}

		/**
		 * if skinDesc == null, sets default name for type ("skin"/"fur"/...).
		 * Also, for SKIN_TYPE_GOO if skinAdj=="" sets skinAdj="goopey"
		 */
		protected function init06Skin(skinTone:String,skinType:int=SKIN_TYPE_PLAIN,skinDesc:String=null,skinAdj:String=""):void{
			this.skinTone = skinTone;
			this.skinType = skinType;
			this.skinDesc = skinDesc || Appearance.DEFAULT_SKIN_DESCS[skinType];
			if (skinAdj == "" && skinType == SKIN_TYPE_GOO ) this.skinAdj = "goopey";
			else this.skinAdj = skinAdj;
			skipInit(6);
		}

		protected function init07Hair(hairColor:String="no",hairLength:Number=0,hairType:int=HAIR_NORMAL):void{
			this.hairColor = hairColor;
			this.hairLength = hairLength;
			this.hairType = hairType;
			skipInit(7);
		}

		protected function init08Face(faceType:int=FACE_HUMAN,earType:int=EARS_HUMAN,tongueType:int=TONUGE_HUMAN,eyeType:int=EYES_HUMAN):void{
			this.faceType = faceType;
			this.earType = earType;
			this.tongueType = tongueType;
			this.eyeType = eyeType;
			skipInit(8);
		}

		protected function init09PrimaryStats(str:Number, tou:Number, spe:Number, inte:Number, lib:Number, sens:Number, cor:Number):void
		{
			this.str = str;
			this.tou = tou;
			this.spe = spe;
			this.inte = inte;
			this.lib = lib;
			this.sens = sens;
			this.cor = cor;
			skipInit(9);
		}

		protected function init10Weapon(weaponName:String,weaponVerb:String,weaponAttack:Number=0,weaponPerk:String="",weaponValue:Number=0):void
		{
			this.weaponName = weaponName;
			this.weaponVerb = weaponVerb;
			this.weaponAttack = weaponAttack;
			this.weaponPerk = weaponPerk;
			this.weaponValue = weaponValue;
			skipInit(10);
		}

		protected function init11Armor(armorName:String,armorDef:Number=0,armorPerk:String="",armorValue:Number=0):void
		{
			this.armorName = armorName;
			this.armorDef = armorDef;
			this.armorPerk = armorPerk;
			this.armorValue = armorValue;
			skipInit(11);
		}

		// also sets up HP=eMaxHP()
		protected function init12Combat(bonusHP:Number=0,lust:Number=0,lustVuln:Number=1,temperment:int=TEMPERMENT_AVOID_GRAPPLES,fatigue:Number=0):void
		{
			this.bonusHP = bonusHP;
			this.lust = lust;
			this.lustVuln = lustVuln;
			this.temperment = temperment;
			this.fatigue = fatigue;
			this.HP = eMaxHP();
			skipInit(12);
		}


		// also sets up XP=totalXP()+additionalXP
		protected function init13Level(level:int,gems:int,additionalXP:int=0):void{
			this.level = level;
			this.gems = gems;
			this.XP=totalXP()+additionalXP;
			skipInit(13);
		}

		protected function initX_Specials(special1:int=0,special2:int=0,special3:int=0):void
		{
			this.special1 = special1;
			this.special2 = special2;
			this.special3 = special3;
		}

		protected function initX_Tail(tailType:int=TAIL_TYPE_NONE,tailVenom:Number=0,tailRecharge:Number=5):void
		{
			this.tailType=tailType;
			this.tailVenom = tailVenom;
			this.tailRecharge = tailRecharge;
		}

		protected function initX_Horns(hornType:int=HORNS_NONE,horns:Number=0):void
		{
			this.hornType = hornType;
			this.horns = horns;
		}

		// wingDesc=null means default desc for type
		protected function initX_Wings(wingType:int=WING_TYPE_NONE,wingDesc:String=null):void
		{
			this.wingType = wingType;
			this.wingDesc = wingDesc || Appearance.DEFAULT_WING_DESCS[wingType];
		}

		//// Antennae.
		protected function initX_Antennae(antennae:int=ANTENNAE_NONE):void
		{
			this.antennae = antennae;
		}


		public function doAI():void
		{
			if (hasStatusAffect("Stunned") >= 0) {
				if (!handleStun()) return;
			}
			if (hasStatusAffect("Fear") >= 0) {
				if (!handleFear()) return;
			}
			//Exgartuan gets to do stuff!
			if (mainClassPtr.player.hasStatusAffect("Exgartuan") >= 0 && mainClassPtr.player.statusAffectv2("Exgartuan") == 0 && rand(3) == 0) {
				if (mainClassPtr.exgartuanCombatUpdate()) mainClassPtr.outputText("\n\n", false);
			}
			if (hasStatusAffect("Constricted") >= 0) {
				if (!handleConstricted()) return;
			}
			//If grappling... TODO implement grappling
			if (mainClassPtr.gameState == 2) {
				mainClassPtr.gameState = 1;
				//temperment - used for determining grapple behaviors
				//0 - avoid grapples/break grapple
				//1 - lust determines > 50 grapple
				//2 - random
				//3 - love grapples
				/*
				 //		if(temperment == 0) eGrappleRetreat();
				 if (temperment == 1) {
				 //			if(lust < 50) eGrappleRetreat();
				 mainClassPtr.doNext(3);
				 return;
				 }
				 mainClassPtr.outputText("Lust Placeholder!!", false);
				 mainClassPtr.doNext(3);
				 return;*/
			}
			performCombatAction();
		}

		/**
		 * Called if monster is constricted. Should return true if constriction is ignored and need to proceed with ai
		 */
		protected function handleConstricted():Boolean
		{
			//Enemy struggles -
			mainClassPtr.outputText("Your prey pushes at your tail, twisting and writhing in an effort to escape from your tail's tight bonds.", false);
			if (statusAffectv1("Constricted") <= 0) {
				mainClassPtr.outputText("  " + capitalA + short + " proves to be too much for your tail to handle, breaking free of your tightly bound coils.", false);
				removeStatusAffect("Constricted");
			}
			addStatusValue("Constricted", 1, -1);
			mainClassPtr.combatRoundOver();
			return false;
		}

		/**
		 * Called if monster is under fear. Should return true if fear ignored and need to proceed with ai
		 */
		protected function handleFear():Boolean
		{
			if (statusAffectv1("Fear") == 0) {
				if (plural) {
					removeStatusAffect("Fear");
					mainClassPtr.outputText("Your foes shake free of their fear and ready themselves for battle.", false);
				}
				else {
					removeStatusAffect("Fear");
					mainClassPtr.outputText("Your foe shakes free of its fear and readies itself for battle.", false);
				}
			}
			else {
				addStatusValue("Fear", 1, -1);
				if (plural) mainClassPtr.outputText(capitalA + short + " are too busy shivering with fear to fight.", false);
				else mainClassPtr.outputText(capitalA + short + " is too busy shivering with fear to fight.", false);
			}
			mainClassPtr.combatRoundOver();
			return false;
		}

		/**
		 * Called if monster is stunned. Should return true if stun is ignored and need to proceed with ai.
		 */
		protected function handleStun():Boolean
		{
			if (plural) mainClassPtr.outputText("Your foes are too dazed from your last hit to strike back!", false);
			else mainClassPtr.outputText("Your foe is too dazed from your last hit to strike back!", false);
			if (statusAffectv1("Stunned") <= 0) removeStatusAffect("Stunned");
			else addStatusValue("Stunned", 1, -1);
			mainClassPtr.combatRoundOver();
			return false;
		}

		/**
		 * This method is called after all stun/fear/constricted checks.
		 * Default: Equal chance to do physical or special (if any) attack
		 */
		protected function performCombatAction():void
		{
			var select:Number = 1;
			if (special1 > 0) select++;
			if (special2 > 0) select++;
			if (special3 > 0) select++;
			var rando:int = int(Math.random() * select);
			if (rando == 0) mainClassPtr.eAttack();
			if (rando == 1 && special1 > 0) mainClassPtr.eventParser(special1);
			if (rando == 2 && special2 > 0) mainClassPtr.eventParser(special2);
			if (rando == 3 && special3 > 0) mainClassPtr.eventParser(special3);
		}
		public function generateDebugDescription():String{
			var result:String;
			var be:String =plural?"are":"is";
			var have:String = plural ? "have" : "has";
			var Heis:String = Pronoun1+" "+be+" ";
			var Hehas:String = Pronoun1 + " " + have + " ";
			result = "You are inspecting "+a+short+" (imageName='"+imageName+"'). You are fighting "+pronoun2+".\n\n";
			result += Heis+(Appearance.DEFAULT_GENDER_NAMES[gender]||("gender#"+gender))+
					" with "+Appearance.numberOfThings(cocks.length,"cock") +
					", "+Appearance.numberOfThings(vaginas.length,"vagina")+
					" and "+Appearance.numberOfThings(breastRows.length,"breast row")+".\n\n";
			// APPEARANCE
			result +=Heis+Appearance.inchesAndFeetsAndInches(tallness)+" tall with "+
					Appearance.describeByScale(hipRating,Appearance.DEFAULT_HIP_RATING_SCALES,"thinner than","wider than")+" hips and "+
					Appearance.describeByScale(buttRating,Appearance.DEFAULT_BUTT_RATING_SCALES,"thinner than","wider than")+" butt.\n";
			result +=Pronoun3+" lower body is "+(Appearance.DEFAULT_LOWER_BODY_NAMES[lowerBody]||("lowerBody#"+lowerBody));
			result += ", "+pronoun3+" arms are "+(Appearance.DEFAULT_ARM_NAMES[armType]||("armType#"+armType));
			result += ", "+pronoun1+" "+have+" "+skinTone+" "+skinAdj+" "+skinDesc+" (type "+(Appearance.DEFAULT_SKIN_NAMES[skinType]||("skinType#"+skinType))+").\n";
			result += Hehas;
			if (hairLength>0){
				result += hairColor+" "+Appearance.inchesAndFeetsAndInches(hairLength)+" long "+(Appearance.DEFAULT_HAIR_NAMES[hairType]||("hairType#"+hairType))+" hair.\n";
			} else {
				result += "no hair.\n";
			}
			result += Hehas
					+(Appearance.DEFAULT_FACE_NAMES[faceType]||("faceType#"+faceType))+" face, "
					+(Appearance.DEFAULT_EARS_NAMES[earType]||("earType#"+earType))+" ears, "
					+(Appearance.DEFAULT_TONGUE_NAMES[tongueType]||("tongueType#"+tongueType))+" tongue and "
					+(Appearance.DEFAULT_EYES_NAMES[eyeType]||("eyeType#"+eyeType))+" eyes.\n";
			result += Hehas;
			if (tailType == TAIL_TYPE_NONE) result += "no tail, ";
			else result+=(Appearance.DEFAULT_TAIL_NAMES[tailType]||("tailType#"+tailType))+" tail with venom="+tailVenom+" and recharge="+tailRecharge+", ";
			if (hornType == HORNS_NONE) result += "no horns, ";
			else result += horns+" "+(Appearance.DEFAULT_HORNS_NAMES[hornType]||("hornType#"+hornType))+" horns, ";
			if (wingType == WING_TYPE_NONE) result += "no wings, ";
			else result += wingDesc+" wings (type "+(Appearance.DEFAULT_WING_NAMES[wingType]||("wingType#"+wingType))+"), ";
			if (antennae == ANTENNAE_NONE) result += "no antennae.\n\n";
			else result += (Appearance.DEFAULT_ANTENNAE_NAMES[antennae]||("antennaeType#"+antennae))+" antennae.\n\n";

			// GENITALS AND BREASTS
			for (var i:int = 0; i<cocks.length; i++){
				var cock:Cock = (cocks[i] as Cock);
				result += Pronoun3+(i>0?(" #"+(i+1)):"")+" "+cock.cockType.toString().toLowerCase()+" cock is ";
				result += Appearance.inchesAndFeetsAndInches(cock.cockLength)+" long and "+cock.cockThickness+"\" thick";
				if (cock.isPierced) result+= ", pierced with "+cock.pLongDesc;
				if (cock.knotMultiplier!=1) result += ", with knot of size "+cock.knotMultiplier;
				result+=".\n";
			}
			if (balls>0 || ballSize>0) result += Hehas+Appearance.numberOfThings(balls,"ball")+" of size "+ballSize+".\n";
			if (cumMultiplier!=1 || cocks.length>0) result += Pronoun1+" "+have+" cum multiplier "+cumMultiplier+". ";
			if (hoursSinceCum>0 || cocks.length>0) result += "It were "+hoursSinceCum+" hours since "+pronoun1+" came.\n\n";
			for (i = 0; i<vaginas.length; i++){
				var vagina:VaginaClass = (vaginas[i] as VaginaClass);
				result += Pronoun3+ (i>0?(" #"+(i+1)):"")+" "+(Appearance.DEFAULT_VAGINA_TYPE_NAMES[vagina.type]||("vaginaType#"+vagina.type))+(vagina.virgin?" ":" non-")+"virgin vagina is ";
				result += Appearance.describeByScale(vagina.vaginalLooseness,Appearance.DEFAULT_VAGINA_LOOSENESS_SCALES,"tighter than","looser than");
				result += ", "+Appearance.describeByScale(vagina.vaginalWetness,Appearance.DEFAULT_VAGINA_WETNESS_SCALES,"drier than","wetter than");
				if (vagina.labiaPierced) result += ". Labia are pierced with "+vagina.labiaPLong;
				if (vagina.clitPierced) result += ". Clit is pierced with "+vagina.clitPLong;
				if (statusAffectv1("Bonus vCapacity")>0){
					result+="; vaginal capacity is increased by "+statusAffectv1("Bonus vCapacity");
				}
				result+=".\n";
			}
			if (breastRows.length>0){
				var nipple:String = nippleLength+"\" ";
				if (nipplesPierced) nipple+="pierced by "+nipplesPLong;
				for (i = 0; i < breastRows.length; i++) {
					var row:BreastRowClass = (breastRows[i] as BreastRowClass);
					result += Pronoun3+(i>0?(" #"+(i+1)):"") + " breast row has " + row.breasts;
					result += " " + row.breastRating.toFixed(2) + "-size (" + Appearance.breastCup(row.breastRating) + ") breasts with ";
					result += Appearance.numberOfThings(row.nipplesPerBreast, nipple+(row.fuckable ? "fuckable nipple" : "unfuckable nipple")) + " on each.\n";
				}
			}
			result += Pronoun3+" ass is "+Appearance.describeByScale(ass.analLooseness,Appearance.DEFAULT_ANAL_LOOSENESS_SCALES,"tighter than","looser than")+", "+Appearance.describeByScale(ass.analWetness,Appearance.DEFAULT_ANAL_WETNESS_SCALES,"drier than","wetter than");
			if (statusAffectv1("Bonus aCapacity")>0){
				result += "; anal capacity is increased by "+statusAffectv1("Bonus aCapacity");
			}
			result +=".\n\n";

			// COMBAT AND OTHER STATS
			result+=Hehas+"str="+str+", tou="+tou+", spe="+spe+", inte="+inte+", lib="+lib+", sens="+sens+", cor="+cor+".\n";
			result += Pronoun1+" could "+weaponVerb+" you with  "+weaponPerk+" "+weaponName+" (attack "+weaponAttack+", value "+weaponValue+").\n";
			result += Pronoun1 +" is guarded with "+armorPerk+" "+armorName+" (defense "+armorDef+", value "+armorValue+").\n";
			result += Hehas+HP+"/"+eMaxHP()+" HP, "+lust+"/100 lust, "+fatigue+"/100 fatigue. "+Pronoun3+" bonus HP="+bonusHP+", and lust vulnerability="+lustVuln+".\n";
			result += Heis+"level "+level+" and "+have+" "+gems+" gems. You will be awarded "+XP+" XP.\n";
			if (special1 || special2 || special3){
				result+=Hehas+"special attacks with magical numbers "+
						[special1,special2,special3]
								.filter(function(x:int):Boolean{return x>0})
								.join(",")
						+".\n"
			} else {
				result+=Hehas+"no special attacks.\n";
			}

			return result;
		}
	}
}