package classes
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.ArmorLib;
	import classes.Items.ConsumableLib;
	import classes.Items.JewelryLib;
	import classes.Items.UseableLib;
	import classes.Items.WeaponLib;
	import classes.Items.WeaponRangeLib;
	import classes.Items.ShieldLib;
	import classes.Items.UndergarmentLib;
	import classes.Scenes.Areas.Forest.Alraune;
	import classes.Scenes.Areas.Ocean.UnderwaterSharkGirl;
	import classes.Scenes.Areas.Ocean.UnderwaterTigersharkGirl;
	import classes.Scenes.Dungeons.Factory.OmnibusOverseer;
	import classes.Scenes.Dungeons.Factory.SecretarialSuccubus;
	import classes.Scenes.NPCs.Kiha;
	import classes.Scenes.Quests.UrtaQuest.MilkySuccubus;
	import classes.internals.ChainedDrop;
	import classes.internals.MonsterCounters;
	import classes.internals.RandomDrop;
	import classes.internals.Utils;
	import classes.internals.WeightedDrop;

	import flash.utils.getQualifiedClassName;

	/**
	 * ...
	 * @author Yoffy, Fake-Name, aimozg
	 */
	public class Monster extends Creature
	{

		protected final function get player():Player
		{
			return game.player;
		}
		protected final function outputText(text:String,clear:Boolean=false):void{
			if (clear) game.clearOutputTextOnly();
			game.outputText(text);
		}
		protected final function combatRoundOver():void{
			game.combatRoundOver();
		}
		protected final function cleanupAfterCombat():void
		{
			game.cleanupAfterCombat();
		}
		protected static function showStatDown(a:String):void{
			kGAMECLASS.mainView.statsView.showStatDown(a);
		}
		protected final function statScreenRefresh():void {
			game.statScreenRefresh();
		}
		protected final function doNext(eventNo:Function):void { //Now typesafe
			game.doNext(eventNo);
		}
		protected final function combatMiss():Boolean {
			return game.combat.combatMiss();
		}
		protected final function combatParry():Boolean {
			return game.combat.combatParry();
		}
		protected final function combatBlock(doFatigue:Boolean = false):Boolean {
			return game.combat.combatBlock(doFatigue);
		}
		protected function get consumables():ConsumableLib{
			return game.consumables;
		}
		protected function get useables():UseableLib{
			return game.useables;
		}
		protected function get weapons():WeaponLib{
			return game.weapons;
		}
		protected function get weaponsrange():WeaponRangeLib{
			return game.weaponsrange;
		}
		protected function get shields():ShieldLib{
			return game.shields;
		}
		protected function get armors():ArmorLib{
			return game.armors;
		}
		protected function get jewelries():JewelryLib{
			return game.jewelries;
		}
		protected function get undergarments():UndergarmentLib{
			return game.undergarments;
		}
		//For enemies
		public var bonusHP:Number = 0;
		public var bonusLust:Number = 0;
		public var monsterCounters:MonsterCounters = null;
		public var bonusStr:Number = 0;
		public var bonusTou:Number = 0;
		public var bonusSpe:Number = 0;
		public var bonusInte:Number = 0;
		public var bonusWis:Number = 0;
		public var bonusLib:Number = 0;
		public var newgamebonusHP:Number = 0;
		private var _long:String = "<b>You have encountered an unitialized  Please report this as a bug</b>.";
		public function get long():String
		{
			return _long;
		}
		public function set long(value:String):void
		{
			initsCalled.long = true;
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

		//Used for special attacks.
		public var special1:Function = null;
		public var special2:Function = null;
		public var special3:Function = null;

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

		private var _drop:RandomDrop = new ChainedDrop();
		public function get drop():RandomDrop { return _drop; }
		public function set drop(value:RandomDrop):void
		{
			_drop = value;
			initedDrop = true;
		}

		public function eMaxHP():Number
		{
			//Base HP
			var temp:Number = 100 + this.level * 15 + this.bonusHP;
			temp += (this.tou);
			if (this.tou >= 21) temp += (this.tou*2);
			if (this.tou >= 41) temp += (this.tou*3);
			if (this.tou >= 61) temp += (this.tou*4);
			if (this.tou >= 81) temp += (this.tou*5);
			if (this.tou >= 101) temp += (this.tou*6);
			if (this.tou >= 151) temp += (this.tou*8);
			if (this.tou >= 201) temp += (this.tou*10);
			if (this.tou >= 251) temp += (this.tou*12);
			if (this.tou >= 301) temp += (this.tou*14);
			if (this.tou >= 351) temp += (this.tou*16);
			if (this.tou >= 401) temp += (this.tou*18);
			if (this.tou >= 451) temp += (this.tou*20);
			if (this.tou >= 501) temp += (this.tou*22);
			if (this.tou >= 551) temp += (this.tou*24);
			if (this.tou >= 601) temp += (this.tou*26);
			if (this.tou >= 651) temp += (this.tou*28);
			if (this.tou >= 701) temp += (this.tou*30);
			if (this.tou >= 751) temp += (this.tou*32);
			if (this.tou >= 801) temp += (this.tou*34);
			if (this.tou >= 851) temp += (this.tou*36);
			if (this.tou >= 901) temp += (this.tou*38);
			if (this.tou >= 951) temp += (this.tou*40);
			//Apply NG+, NG++, NG+++, etc.
			temp += this.newgamebonusHP * player.newGamePlusMod();
			//Apply perks
			if (findPerk(PerkLib.RefinedBodyI) >= 0) temp += (50 * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.TankI) >= 0) temp += ((this.tou*3) * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.GoliathI) >= 0) temp += ((this.str*2) * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.CheetahI) >= 0) temp += (this.spe * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.JobGuardian) >= 0) temp += 30;
			if (findPerk(PerkLib.DeityJobMunchkin) >= 0) temp += 150;
			if (findPerk(PerkLib.BodyCultivator) >= 0) temp += (25 * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.FleshBodyApprenticeStage) >= 0) {
				if (findPerk(PerkLib.SoulApprentice) >= 0) temp += (50 * (1 + player.newGamePlusMod()));
				if (findPerk(PerkLib.SoulPersonage) >= 0) temp += (50 * (1 + player.newGamePlusMod()));
				if (findPerk(PerkLib.SoulWarrior) >= 0) temp += (50 * (1 + player.newGamePlusMod()));
			}
			if (findPerk(PerkLib.FleshBodyWarriorStage) >= 0) {
				if (findPerk(PerkLib.SoulSprite) >= 0) temp += (75 * (1 + player.newGamePlusMod()));
				if (findPerk(PerkLib.SoulScholar) >= 0) temp += (75 * (1 + player.newGamePlusMod()));
				if (findPerk(PerkLib.SoulElder) >= 0) temp += (75 * (1 + player.newGamePlusMod()));
			}
			if (findPerk(PerkLib.FleshBodyElderStage) >= 0) {
				if (findPerk(PerkLib.SoulExalt) >= 0) temp += (100 * (1 + player.newGamePlusMod()));
				if (findPerk(PerkLib.SoulOverlord) >= 0) temp += (100 * (1 + player.newGamePlusMod()));
				if (findPerk(PerkLib.SoulTyrant) >= 0) temp += (100 * (1 + player.newGamePlusMod()));
			}
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) temp += (150 * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) temp += (225 * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.ShieldWielder) >= 0) temp *= 1.5;
			if (findPerk(PerkLib.EnemyBossType) >= 0) temp *= 2;
			if (findPerk(PerkLib.EnemyGigantType) >= 0) temp *= 3;
			if (findPerk(PerkLib.EnemyGroupType) >= 0) temp *= 5;
			//Apply difficulty
			if (flags[kFLAGS.GAME_DIFFICULTY] <= 0) temp *= 1.0;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 1) temp *= 1.25;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) temp *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) temp *= 2.0;
			else temp *= 3.0;
			temp = Math.round(temp);
			return temp;
		}

		public function addHP(hp:Number):void{
			this.HP += hp;
			if (this.HP<0) this.HP = 0;
			else if (this.HP>eMaxHP()) this.HP = eMaxHP();
		}

		public function eMaxLust():Number
		{
			//Base lust
			var temp:Number = 100 + this.bonusLust;
			//Apply perks
			if (findPerk(PerkLib.BasicSelfControl) >= 0) temp += 15;
			if (findPerk(PerkLib.HalfStepToImprovedSelfControl) >= 0) temp += 25;
			if (findPerk(PerkLib.ImprovedSelfControl) >= 0) temp += 40;
			if (findPerk(PerkLib.HalfStepToAdvancedSelfControl) >= 0) temp += 60;
			if (findPerk(PerkLib.AdvancedSelfControl) >= 0) temp += 100;
			if (findPerk(PerkLib.HalfStepToSuperiorSelfControl) >= 0) temp += 160;
			if (findPerk(PerkLib.SuperiorSelfControl) >= 0) temp += 250;
			if (findPerk(PerkLib.HalfStepToPeerlessSelfControl) >= 0) temp += 350;
			if (findPerk(PerkLib.PeerlessSelfControl) >= 0) temp += 500;
			if (findPerk(PerkLib.InhumanDesireI) >= 0) temp += (20 * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.DemonicDesireI) >= 0) temp += Math.round(this.lib * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.JobCourtesan) >= 0) temp += 20;
			if (findPerk(PerkLib.JobSeducer) >= 0) temp += 10;
			if (findPerk(PerkLib.DeityJobMunchkin) >= 0) temp += 50;
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) temp += (50 * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) temp += (75 * (1 + player.newGamePlusMod()));
			//Apply NG+, NG++, NG+++, etc.
			temp += this.bonusLust * player.newGamePlusMod();
			return temp;
		}
		
		public function eMaxFatigue():Number
		{
			//Base fatigue
			var temp:Number = 100 + this.level * 5;
			//Apply perks
			if (findPerk(PerkLib.BasicEndurance) >= 0) temp += 30;
			if (findPerk(PerkLib.HalfStepToImprovedEndurance) >= 0) temp += 50;
			if (findPerk(PerkLib.ImprovedEndurance) >= 0) temp += 80;
			if (findPerk(PerkLib.HalfStepToAdvancedEndurance) >= 0) temp += 120;
			if (findPerk(PerkLib.AdvancedEndurance) >= 0) temp += 200;
			if (findPerk(PerkLib.HalfStepToSuperiorEndurance) >= 0) temp += 320;
			if (findPerk(PerkLib.SuperiorEndurance) >= 0) temp += 500;
			if (findPerk(PerkLib.HalfStepToPeerlessEndurance) >= 0) temp += 700;
			if (findPerk(PerkLib.PeerlessEndurance) >= 0) temp += 1000;
			if (findPerk(PerkLib.ArchersStaminaI) >= 0) temp += Math.round(this.spe * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.NaturesSpringI) >= 0) temp += (20 * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.JobHunter) >= 0) temp += 50;
			if (findPerk(PerkLib.JobRanger) >= 0) temp += 5;
			if (findPerk(PerkLib.DeityJobMunchkin) >= 0) temp += 100;
			if (findPerk(PerkLib.PrestigeJobArcaneArcher) >= 0) temp += 600;
			if (findPerk(PerkLib.PrestigeJobSoulArcher) >= 0) temp += 150;
			if (findPerk(PerkLib.PrestigeJobSeer) >= 0) temp += 900;
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) temp += (100 * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) temp += (150 * (1 + player.newGamePlusMod()));
			return temp;
		}
		
		public function eMaxSoulforce():Number
		{
			//Base soulforce
			var temp:Number = 50;
			if (findPerk(PerkLib.JobSoulCultivator) >= 0) {
				if (this.level >= 2) temp += 25;
				if (this.level >= 4) temp += 25;
			}
			if (findPerk(PerkLib.SoulApprentice) >= 0) {
				if (this.level >= 6) temp += 30;
				if (this.level >= 8) temp += 30;
				if (this.level >= 10) temp += 30;
			}
			if (findPerk(PerkLib.SoulPersonage) >= 0) {
				if (this.level >= 12) temp += 40;
				if (this.level >= 14) temp += 40;
				if (this.level >= 16) temp += 40;
			}
			if (findPerk(PerkLib.InsightfulResourcesI) >= 0) temp += Math.round((this.wis*5) * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.DeityJobMunchkin) >= 0) temp *= 1.1;
			return temp;
		}
		
		public function eMaxWrath():Number
		{
			//Base wrath
			var temp:Number = 100;
			if (findPerk(PerkLib.DoubleAttack) >= 0) temp += 10;
			if (findPerk(PerkLib.TripleAttack) >= 0) temp += 10;
			if (findPerk(PerkLib.QuadrupleAttack) >= 0) temp += 10;
			if (findPerk(PerkLib.PentaAttack) >= 0) temp += 10;
			if (findPerk(PerkLib.HexaAttack) >= 0) temp += 10;
			if (findPerk(PerkLib.DoubleAttackLarge) >= 0) temp += 20;
			if (findPerk(PerkLib.TripleAttackLarge) >= 0) temp += 20;
			if (findPerk(PerkLib.JobBarbarian) >= 0) temp += 20;
			if (findPerk(PerkLib.JobBeastWarrior) >= 0) temp += 50;
			if (findPerk(PerkLib.JobDervish) >= 0) temp += 20;
			if (findPerk(PerkLib.JobWarlord) >= 0) temp += 20;
			if (findPerk(PerkLib.JobWarrior) >= 0) temp += 10;
			if (findPerk(PerkLib.Berzerker) >= 0) temp += 100;
			if (findPerk(PerkLib.Lustzerker) >= 0) temp += 100;
			if (findPerk(PerkLib.PrestigeJobBerserker) >= 0) temp += 200;
			if (findPerk(PerkLib.Rage) >= 0) temp += 200;
			if (findPerk(PerkLib.Anger) >= 0) temp += 200;
			return temp;
		}
		
		public function eMaxMana():Number
		{
			//Base mana
			var temp:Number = 100 + this.level * 10;
			if (findPerk(PerkLib.BasicSpirituality) >= 0) temp += 45;
			if (findPerk(PerkLib.HalfStepToImprovedSpirituality) >= 0) temp += 75;
			if (findPerk(PerkLib.ImprovedSpirituality) >= 0) temp += 120;
			if (findPerk(PerkLib.HalfStepToAdvancedSpirituality) >= 0) temp += 180;
			if (findPerk(PerkLib.AdvancedSpirituality) >= 0) temp += 300;
			if (findPerk(PerkLib.HalfStepToSuperiorSpirituality) >= 0) temp += 480;
			if (findPerk(PerkLib.SuperiorSpirituality) >= 0) temp += 750;
			if (findPerk(PerkLib.HalfStepToPeerlessSpirituality) >= 0) temp += 1050;
			if (findPerk(PerkLib.PeerlessSpirituality) >= 0) temp += 1500;
			if (findPerk(PerkLib.ManaAffinityI) >= 0) temp += (35 * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.MindOverBodyI) >= 0) temp += Math.round((this.inte * 2) * (1 + player.newGamePlusMod()));
			if (findPerk(PerkLib.ArcanePoolI) >= 0) {
				temp += Math.round(this.inte * (1 + player.newGamePlusMod()));
				temp += Math.round(this.wis * (1 + player.newGamePlusMod()));
			}
			if (findPerk(PerkLib.Archmage) >= 0 && inte >= 75) temp += 45;
			if (findPerk(PerkLib.Channeling) >= 0 && inte >= 60) temp += 30;
			if (findPerk(PerkLib.GrandArchmage) >= 0 && inte >= 100) temp += 60;
			if (findPerk(PerkLib.GreyArchmage) >= 0 && inte >= 125) temp += 150;
			if (findPerk(PerkLib.GreyMage) >= 0 && inte >= 125) temp += 105;
			if (findPerk(PerkLib.Mage) >= 0 && inte >= 50) temp += 30;
			if (findPerk(PerkLib.Spellpower) >= 0 && inte >= 50) temp += 15;
			if (findPerk(PerkLib.JobSorcerer) >= 0) temp += 15;
			if (findPerk(PerkLib.ArcaneRegenerationMinor) >= 0) {
				var tempmulti:Number = 1;
				tempmulti += 0.1;
				if (findPerk(PerkLib.ArcaneRegenerationMajor) >= 0) tempmulti += 0.2;
				if (findPerk(PerkLib.ArcaneRegenerationEpic) >= 0) tempmulti += 0.3;
				if (findPerk(PerkLib.ArcaneRegenerationLegendary) >= 0) tempmulti += 0.4;
				temp *= tempmulti;
			}
			return temp;
		}

		/**
		 * @return HP/eMaxHP()
		 */
		public function HPRatio():Number{
			return HP/eMaxHP();
		}

		/**
		 * @return damage not reduced by player stats
		 */
		public function eBaseDamage():Number {
			var damage:Number = 0;
			damage += str;
			if (str >= 21) damage += ((str - 20) * 0.25);
			if (str >= 41) damage += ((str - 40) * 0.25);
			if (str >= 61) damage += ((str - 60) * 0.25);
			if (str >= 81) damage += ((str - 80) * 0.25);
			if (str >= 101) damage += ((str - 100) * 0.25);
			if (str >= 151) damage += ((str - 150) * 0.25);
			if (str >= 201) damage += ((str - 200) * 0.25);
			if (str >= 251) damage += ((str - 250) * 0.25);
			if (str >= 301) damage += ((str - 300) * 0.25);
			if (str >= 351) damage += ((str - 350) * 0.25);
			if (str >= 401) damage += ((str - 400) * 0.25);
			if (str >= 451) damage += ((str - 450) * 0.25);
			if (str >= 501) damage += ((str - 500) * 0.25);
			if (str >= 551) damage += ((str - 550) * 0.25);
			if (str >= 601) damage += ((str - 600) * 0.25);
			if (str >= 651) damage += ((str - 650) * 0.25);
			if (str >= 701) damage += ((str - 700) * 0.25);
			if (str >= 751) damage += ((str - 750) * 0.25);
			if (str >= 801) damage += ((str - 800) * 0.25);
			if (str >= 851) damage += ((str - 850) * 0.25);
			if (str >= 901) damage += ((str - 900) * 0.25);
			if (str >= 951) damage += ((str - 950) * 0.25);
			if (str >= 1001) damage += ((str - 1000) * 0.25);
			if (str >= 1051) damage += ((str - 1050) * 0.25);
			if (str >= 1101) damage += ((str - 1100) * 0.25);
			if (str >= 1151) damage += ((str - 1150) * 0.25);
			if (str >= 1201) damage += ((str - 1200) * 0.25);
			if (str < 10) damage = 10;
			//weapon bonus
			if (weaponAttack < 51) damage *= (1 + (weaponAttack * 0.03));
			else if (weaponAttack >= 51 && weaponAttack < 101) damage *= (2.5 + ((weaponAttack - 50) * 0.025));
			else if (weaponAttack >= 101 && weaponAttack < 151) damage *= (3.75 + ((weaponAttack - 100) * 0.02));
			else if (weaponAttack >= 151 && weaponAttack < 201) damage *= (4.75 + ((weaponAttack - 150) * 0.015));
			else damage *= (5.5 + ((weaponAttack - 200) * 0.01));
			//monster exclusive perks bonus
			if (findPerk(PerkLib.EnemyBossType) >= 0) damage *= 2;
			if (findPerk(PerkLib.EnemyGigantType) >= 0) damage *= 3;
			//other
			if (hasStatusEffect(StatusEffects.Bloodlust)) damage *= (1 + (0.1 * statusEffectv2(StatusEffects.Bloodlust)));
			damage = Math.round(damage);
			return damage;
		}

		public function eBaseStrengthDamage():Number {
			var damage:Number = 0;
			damage += str;
			if (str >= 21) damage += (str - 20);
			if (str >= 41) damage += (str - 40);
			if (str >= 61) damage += (str - 60);
			if (str >= 81) damage += (str - 80);
			if (str >= 101) damage += (str - 100);
			if (str >= 151) damage += (str - 150);
			if (str >= 201) damage += (str - 200);
			if (str >= 251) damage += (str - 250);
			if (str >= 301) damage += (str - 300);
			if (str >= 351) damage += (str - 350);
			if (str >= 401) damage += (str - 400);
			if (str >= 451) damage += (str - 450);
			if (str >= 501) damage += (str - 500);
			if (str >= 551) damage += (str - 550);
			if (str >= 601) damage += (str - 600);
			if (str >= 651) damage += (str - 650);
			if (str >= 701) damage += (str - 700);
			if (str >= 751) damage += (str - 750);
			if (str >= 801) damage += (str - 800);
			if (str >= 851) damage += (str - 850);
			if (str >= 901) damage += (str - 900);
			if (str >= 951) damage += (str - 950);
			if (str >= 1001) damage += (str - 1000);
			if (str >= 1051) damage += (str - 1050);
			if (str >= 1101) damage += (str - 1100);
			if (str >= 1151) damage += (str - 1150);
			if (str >= 1201) damage += (str - 1200);
			//monster exclusive perks bonus
			if (findPerk(PerkLib.EnemyBossType) >= 0) damage *= 2;
			if (findPerk(PerkLib.EnemyGigantType) >= 0) damage *= 3;
			damage = Math.round(damage);
			return damage;
		}

		public function eBaseToughnessDamage():Number {
			var damage:Number = 0;
			damage += tou;
			if (tou >= 21) damage += (tou - 20);
			if (tou >= 41) damage += (tou - 40);
			if (tou >= 61) damage += (tou - 60);
			if (tou >= 81) damage += (tou - 80);
			if (tou >= 101) damage += (tou - 100);
			if (tou >= 151) damage += (tou - 150);
			if (tou >= 201) damage += (tou - 200);
			if (tou >= 251) damage += (tou - 250);
			if (tou >= 301) damage += (tou - 300);
			if (tou >= 351) damage += (tou - 350);
			if (tou >= 401) damage += (tou - 400);
			if (tou >= 451) damage += (tou - 450);
			if (tou >= 501) damage += (tou - 500);
			if (tou >= 551) damage += (tou - 550);
			if (tou >= 601) damage += (tou - 600);
			if (tou >= 651) damage += (tou - 650);
			if (tou >= 701) damage += (tou - 700);
			if (tou >= 751) damage += (tou - 750);
			if (tou >= 801) damage += (tou - 800);
			if (tou >= 851) damage += (tou - 850);
			if (tou >= 901) damage += (tou - 900);
			if (tou >= 951) damage += (tou - 950);
			if (tou >= 1001) damage += (tou - 1000);
			if (tou >= 1051) damage += (tou - 1050);
			if (tou >= 1101) damage += (tou - 1100);
			if (tou >= 1151) damage += (tou - 1150);
			if (tou >= 1201) damage += (tou - 1200);
			//monster exclusive perks bonus
			if (findPerk(PerkLib.EnemyBossType) >= 0) damage *= 2;
			if (findPerk(PerkLib.EnemyGigantType) >= 0) damage *= 3;
			damage = Math.round(damage);
			return damage;
		}

		public function eBaseSpeedDamage():Number {
			var damage:Number = 0;
			damage += spe;
			if (spe >= 21) damage += (spe - 20);
			if (spe >= 41) damage += (spe - 40);
			if (spe >= 61) damage += (spe - 60);
			if (spe >= 81) damage += (spe - 80);
			if (spe >= 101) damage += (spe - 100);
			if (spe >= 151) damage += (spe - 150);
			if (spe >= 201) damage += (spe - 200);
			if (spe >= 251) damage += (spe - 250);
			if (spe >= 301) damage += (spe - 300);
			if (spe >= 351) damage += (spe - 350);
			if (spe >= 401) damage += (spe - 400);
			if (spe >= 451) damage += (spe - 450);
			if (spe >= 501) damage += (spe - 500);
			if (spe >= 551) damage += (spe - 550);
			if (spe >= 601) damage += (spe - 600);
			if (spe >= 651) damage += (spe - 650);
			if (spe >= 701) damage += (spe - 700);
			if (spe >= 751) damage += (spe - 750);
			if (spe >= 801) damage += (spe - 800);
			if (spe >= 851) damage += (spe - 850);
			if (spe >= 901) damage += (spe - 900);
			if (spe >= 951) damage += (spe - 950);
			if (spe >= 1001) damage += (spe - 1000);
			if (spe >= 1051) damage += (spe - 1050);
			if (spe >= 1101) damage += (spe - 1100);
			if (spe >= 1151) damage += (spe - 1150);
			if (spe >= 1201) damage += (spe - 1200);
			//monster exclusive perks bonus
			if (findPerk(PerkLib.EnemyBossType) >= 0) damage *= 2;
			if (findPerk(PerkLib.EnemyGigantType) >= 0) damage *= 3;
			damage = Math.round(damage);
			return damage;
		}

		/**
		 * @return randomized damage reduced by player stats
		 */
		public function calcDamage():int{
			return player.reduceDamage(eBaseDamage());
		}

		public function totalXP(playerLevel:Number=-1):Number
		{
			var multiplier:Number = 1;
			multiplier += game.player.perkv1(PerkLib.AscensionWisdom) * 0.1;
			if (playerLevel == -1) playerLevel = game.player.level;
			// 1) Nerf xp gains by 10% per level after first one level difference up to 90% at 10 lvl diff!
			// 2) Bonuses for underlevel all the way to 20 lvl's below enemy! Above 20 lvl diff bonus is fixed at 300%! With underdog it increase to 40 lvl diff and caps at 900%!
			// 3) Super high level folks (over 10 levels) only get 1 xp!
			var difference:Number = 1;
			var diff2:Number = this.level - playerLevel;
			if (game.player.findPerk(PerkLib.AscensionUnderdog) >= 0) {
				if (diff2 >= 40) difference += 8;
				if (diff2 >= 1 && diff2 < 40) difference += diff2 * 0.2;
			}
			else {
				if (diff2 >= 20) difference += 2;
				if (diff2 >= 1 && diff2 < 20) difference += diff2 * 0.1;
			}
			if (diff2 == -2) difference -= 0.1;
			if (diff2 == -3) difference -= 0.2;
			if (diff2 == -4) difference -= 0.3;
			if (diff2 == -5) difference -= 0.4;
			if (diff2 == -6) difference -= 0.5;
			if (diff2 == -7) difference -= 0.6;
			if (diff2 == -8) difference -= 0.7;
			if (diff2 == -9) difference -= 0.8;
			if (diff2 == -10) difference -= 0.9;
			if (diff2 < -10) {
				var minXP:Number = 1;
				if (findPerk(PerkLib.EnemyBossType) >= 0) minXP *= 2;
				if (findPerk(PerkLib.EnemyGigantType) >= 0) minXP *= 3;
				if (findPerk(PerkLib.EnemyGroupType) >= 0) minXP *= 5;
				return minXP;
			}
			return Math.round((this.additionalXP + this.baseXP()) * this.bonusXP() * difference * multiplier);
		}
		protected function baseXP():Number
		{
			var baseMonXP:Number = this.level * 5;
			if (this.level < 7) baseMonXP += (this.level * 5) + rand(this.level * 5);
			else baseMonXP += rand(this.level * 5);
			return baseMonXP;
		}
		protected function bonusXP():Number
		{
			var specENtypes:Number = 1;
			if (findPerk(PerkLib.ShieldWielder) >= 0) specENtypes *= 1.5;
			if (findPerk(PerkLib.EnemyBossType) >= 0) specENtypes *= 2;
			if (findPerk(PerkLib.EnemyGigantType) >= 0) specENtypes *= 3;
			if (findPerk(PerkLib.EnemyGroupType) >= 0) specENtypes *= 5;
			return specENtypes;
		}

		public function Monster()
		{
			// trace("Generic Monster Constructor!");

			//// INSTRUCTIONS
			//// Copy-paste remaining code to the new monster constructor
			//// Uncomment and replace placeholder values with your own
			//// See existing monsters for examples

			// super(mainClassPtr);

			//// INIITIALIZERS
			//// If you want to skip something that is REQUIRED, you shoud set corresponding
			//// this.initedXXX property to true, e.g. this.initedGenitals = true;

			//// 1. Names and plural/singular
			///*REQUIRED*/ this.a = "a";
			///*REQUIRED*/ this.short = "short";
			///*OPTIONAL*/ // this.imageName = "imageName"; // default ""
			///*REQUIRED*/ this.long = "long";
			///*OPTIONAL*/ //this.plural = true|false; // default false

			//// 2. Gender, genitals, and pronouns (also see "note for 2." below)
			//// 2.1. Male
			///*REQUIRED*/ this.createCock(length,thickness,type); // defaults 5.5,1,human; could be called multiple times
			///*OPTIONAL*/ //this.balls = numberOfBalls; // default 0
			///*OPTIONAL*/ //this.ballSize = ; // default 0. should be set if balls>0
			///*OPTIONAL*/ //this.cumMultiplier = ; // default 1
			///*OPTIONAL*/ //this.hoursSinceCum = ; // default 0
			//// 2.2. Female
			///*REQUIRED*/ this.createVagina(virgin=true|false,VAGINA_WETNESS_,VAGINA_LOOSENESS_); // default true,normal,tight
			///*OPTIONAL*/ //this.createStatusEffect(StatusEffects.BonusVCapacity, bonus, 0, 0, 0);
			//// 2.3. Hermaphrodite
			//// Just create cocks and vaginas. Last call determines pronouns.
			//// 2.4. Genderless
			///*REQUIRED*/ initGenderless(); // this functions removes genitals!

			//// Note for 2.: during initialization pronouns are set in:
			//// * createCock: he/him/his
			//// * createVagina: she/her/her
			//// * initGenderless: it/it/its
			//// If plural=true, they are replaced with: they/them/their
			//// If you want to customize pronouns:
			///*OPTIONAL*/ //this.pronoun1 = "he";
			///*OPTIONAL*/ //this.pronoun2 = "him";
			///*OPTIONAL*/ //this.pronoun3 = "his";
			//// Another note for 2.: gender is automatically calculated in createCock,
			//// createVagina, initGenderless. If you want to change it, set this.gender
			//// after these method calls.

			//// 3. Breasts
			///*REQUIRED*/ this.createBreastRow(size,nipplesPerBreast); // default 0,1
			//// Repeat for multiple breast rows
			//// You can call just `this.createBreastRow();` for flat breasts
			//// Note useful method: this.createBreastRow(Appearance.breastCupInverse("C")); // "C" -> 3

			//// 4. Ass
			///*OPTIONAL*/ //this.ass.analLooseness = ANAL_LOOSENESS_; // default TIGHT
			///*OPTIONAL*/ //this.ass.analWetness = ANAL_WETNESS_; // default DRY
			///*OPTIONAL*/ //this.createStatusEffect(StatusEffects.BonusACapacity, bonus, 0, 0, 0);
			//// 5. Body
			///*REQUIRED*/ this.tallness = ;
			///*OPTIONAL*/ //this.hipRating = HIP_RATING_; // default boyish
			///*OPTIONAL*/ //this.buttRating = BUTT_RATING_; // default buttless
			///*OPTIONAL*/ //this.lowerBody = LOWER_BODY_; //default human
			///*OPTIONAL*/ //this.armType = ARM_TYPE_; // default human

			//// 6. Skin
			///*OPTIONAL*/ //this.skinTone = "skinTone"; // default "albino"
			///*OPTIONAL*/ //this.skinType = SKIN_TYPE_; // default PLAIN
			///*OPTIONAL*/ //this.skinDesc = "skinDesc"; // default "skin" if this.skinType is not set, else Appearance.DEFAULT_SKIN_DESCS[skinType]
			///*OPTIONAL*/ //this.skinAdj = "skinAdj"; // default ""

			//// 7. Hair
			///*OPTIONAL*/ //this.hairColor = ; // default "no"
			///*OPTIONAL*/ //this.hairLength = ; // default 0
			///*OPTIONAL*/ //this.hairType = HAIR_; // default NORMAL

			//// 8. Face
			///*OPTIONAL*/ //this.faceType = FACE_; // default HUMAN
			///*OPTIONAL*/ //this.earType = EARS_; // default HUMAN
			///*OPTIONAL*/ //this.tongueType = TONGUE_; // default HUMAN
			///*OPTIONAL*/ //this.eyeType = EYES_; // default HUMAN

			//// 9. Primary stats.
			///*REQUIRED*/ initStrTouSpeInte(,,,);
			///*REQUIRED*/ initLibSensCor(,,);

			//// 10. Weapon
			///*REQUIRED*/ this.weaponName = "weaponName";
			///*REQUIRED*/ this.weaponVerb = "weaponVerb";
			///*OPTIONAL*/ //this.weaponAttack = ; // default 0
			///*OPTIONAL*/ //this.weaponPerk = "weaponPerk"; // default ""
			///*OPTIONAL*/ //this.weaponValue = ; // default 0

			//// 11. Armor
			///*REQUIRED*/ this.armorName = "armorName";
			///*OPTIONAL*/ //this.armorDef = ; // default 0
			///*OPTIONAL*/ //this.armorPerk = "armorPerk"; // default ""
			///*OPTIONAL*/ //this.armorValue = ; // default 0

			//// 12. Combat
			///*OPTIONAL*/ //this.bonusHP = ; // default 0
			///*OPTIONAL*/ //this.bonusLust = ; // default 0
			///*OPTIONAL*/ //this.lust = ; // default 0
			///*OPTIONAL*/ //this.lustVuln = ; // default 1
			///*OPTIONAL*/ //this.temperment = TEMPERMENT; // default AVOID_GRAPPLES
			///*OPTIONAL*/ //this.fatigue = ; // default 0

			//// 13. Level
			///*REQUIRED*/ this.level = ;
			///*REQUIRED*/ this.gems = ;
			///*OPTIONAL*/ //this.additionalXP = ; // default 0

			//// 14. Drop
			//// 14.1. No drop
			///*REQUIRED*/ this.drop = NO_DROP;
			//// 14.2. Fixed drop
			///*REQUIRED*/ this.drop = new WeightedDrop(dropItemType);
			//// 14.3. Random weighted drop
			///*REQUIRED*/ this.drop = new WeightedDrop()...
			//// Append with calls like:
			//// .add(itemType,itemWeight)
			//// .addMany(itemWeight,itemType1,itemType2,...)
			//// Example:
			//// this.drop = new WeightedDrop()
			//// 		.add(A,2)
			//// 		.add(B,10)
			//// 		.add(C,1)
			//// 	will drop B 10 times more often than C, and 5 times more often than A.
 			//// 	To be precise, \forall add(A_i,w_i): P(A_i)=w_i/\sum_j w_j
			//// 14.4. Random chained check drop
			///*REQUIRED*/ this.drop = new ChainedDrop(optional defaultDrop)...
			//// Append with calls like:
			//// .add(itemType,chance)
			//// .elseDrop(defaultDropItem)
			////
			//// Example 1:
			//// init14ChainedDrop(A)
			//// 		.add(B,0.01)
			//// 		.add(C,0.5)
			//// 	will FIRST check B vs 0.01 chance,
			//// 	if it fails, C vs 0.5 chance,
			//// 	else A
			////
			//// 	Example 2:
			//// 	init14ChainedDrop()
			//// 		.add(B,0.01)
			//// 		.add(C,0.5)
			//// 		.elseDrop(A)
			//// 	for same result

			//// 15. Special attacks. No need to set them if the monster has custom AI.
			//// Values are either combat event numbers (5000+) or function references
			///*OPTIONAL*/ //this.special1 = ; //default 0
			///*OPTIONAL*/ //this.special2 = ; //default 0
			///*OPTIONAL*/ //this.special3 = ; //default 0

			//// 16. Tail
			///*OPTIONAL*/ //this.tailType = TAIL_TYPE_; // default NONE
			///*OPTIONAL*/ //this.tailCount = ; // default 0
			///*OPTIONAL*/ //this.tailVenom = ; // default 0
			///*OPTIONAL*/ //this.tailRecharge = ; // default 5

			//// 17. Horns
			///*OPTIONAL*/ //this.hornType = HORNS_; // default NONE
			///*OPTIONAL*/ //this.horns = numberOfHorns; // default 0

			//// 18. Wings
			///*OPTIONAL*/ //this.wingType = WING_TYPE_; // default NONE
			///*OPTIONAL*/ //this.wingDesc = ; // default Appearance.DEFAULT_WING_DESCS[wingType]

			//// 19. Antennae
			///*OPTIONAL*/ //this.antennae = ANTENNAE_; // default NONE

			//// REQUIRED !!!
			//// In debug mode will throw an error for uninitialized monster
			//checkMonster();
		}

		private var _checkCalled:Boolean = false;
		public function get checkCalled():Boolean { return _checkCalled; }
		public var checkError:String = "";
		public var initsCalled:Object = {
			a:false,
			short:false,
			long:false,
			genitals:false,
			breasts:false,
			tallness:false,
			str_tou_spe_inte:false,
			lib_sens_cor:false,
			drop:false
		};
		// MONSTER INITIALIZATION HELPER FUNCTIONS
		protected function set initedGenitals(value:Boolean):void{
			initsCalled.genitals = value;
		}
		protected function set initedBreasts(value:Boolean):void{
			initsCalled.breasts = value;
		}
		protected function set initedDrop(value:Boolean):void{
			initsCalled.drop = value;
		}
		protected function set initedStrTouSpeInte(value:Boolean):void{
			initsCalled.str_tou_spe_inte = value;
		}
		protected function set initedLibSensCor(value:Boolean):void{
			initsCalled.lib_sens_cor = value;
		}
		protected const NO_DROP:WeightedDrop = new WeightedDrop();

		public function isFullyInit():Boolean {
			for each (var phase:Object in initsCalled) {
				if (phase is Boolean && phase == false) return false;
			}
			return true;
		}
		public function missingInits():String{
			var result:String = "";
			for (var phase:String in initsCalled){
				if (initsCalled[phase] is Boolean && initsCalled[phase] == false){
					if (result == "") result = phase;
					else result+=", "+phase;
				}
			}
			return result;
		}

		override public function set a(value:String):void {
			initsCalled.a = true;
			super.a = value;
		}

		override public function set short(value:String):void {
			initsCalled.short = true;
			super.short = value;
		}

		override public function createCock(clength:Number = 5.5, cthickness:Number = 1, ctype:CockTypesEnum = null):Boolean
		{
			initedGenitals = true;
			if (!_checkCalled) {
				if (plural) {
					this.pronoun1 = "they";
					this.pronoun2 = "them";
					this.pronoun3 = "their";
				} else {
					this.pronoun1 = "he";
					this.pronoun2 = "him";
					this.pronoun3 = "his";
				}
			}
			var result:Boolean = super.createCock(clength, cthickness, ctype);
			return result;
		}

		override public function createVagina(virgin:Boolean = true, vaginalWetness:Number = 1, vaginalLooseness:Number = 0):Boolean
		{
			initedGenitals = true;
			if (!_checkCalled) {
				if (plural) {
					this.pronoun1 = "they";
					this.pronoun2 = "them";
					this.pronoun3 = "their";
				} else {
					this.pronoun1 = "she";
					this.pronoun2 = "her";
					this.pronoun3 = "her";
				}
			}
			var result:Boolean = super.createVagina(virgin, vaginalWetness, vaginalLooseness);
			return result;
		}

		protected function initGenderless():void
		{
			this.cocks = [];
			this.vaginas = new <VaginaClass>[];
			initedGenitals = true;
			if (plural) {
				this.pronoun1 = "they";
				this.pronoun2 = "them";
				this.pronoun3 = "their";
			} else {
				this.pronoun1 = "it";
				this.pronoun2 = "it";
				this.pronoun3 = "its";
			}
		}

		override public function createBreastRow(size:Number = 0, nipplesPerBreast:Number = 1):Boolean
		{
			initedBreasts = true;
			return super.createBreastRow(size, nipplesPerBreast);
		}

		override public function set tallness(value:Number):void
		{
			initsCalled.tallness = true;
			super.tallness = value;
		}

		protected function initStrTouSpeInte(str:Number, tou:Number, spe:Number, inte:Number):void
		{
			this.str = str;
			this.tou = tou;
			this.spe = spe;
			this.inte = inte;
			initedStrTouSpeInte = true;
		}

		protected function initLibSensCor(lib:Number, sens:Number, cor:Number):void
		{
			this.lib = lib;
			this.sens = sens;
			this.cor = cor;
			initedLibSensCor = true;
		}


		override public function set wingType(value:Number):void
		{
			if (!_checkCalled) this.wingDesc = Appearance.DEFAULT_WING_DESCS[value];
			super.wingType = value;
		}

		override public function validate():String
		{
			var error:String = "";
			// 1. Required fields must be set
			if (!isFullyInit()) {
				error += "Missing phases: "+missingInits()+". ";
			}
			this.HP = eMaxHP();
			this.XP = totalXP();
			error += super.validate();
			error += Utils.validateNonNegativeNumberFields(this, "Monster.validate",[
					"lustVuln", "temperment"
			]);
			return error;
		}

		public function checkMonster():Boolean
		{
			_checkCalled = true;
			checkError = validate();
			if (checkError.length>0) CoC_Settings.error("Monster not initialized:"+checkError);
			return checkError.length == 0;
		}

		/**
		 * try to hit, apply damage
		 * @return damage
		 */
		public function eOneAttack():int
		{
			//Determine damage - str modified by enemy toughness!
			var damage:int = calcDamage();
			if (damage > 0) damage = player.takeDamage(damage);
			return damage;
		}

		/**
		 * return true if we land a hit
		 */
		protected function attackSucceeded():Boolean
		{
			var attack:Boolean = true;
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind)) {
				attack &&= handleBlind();
			}
			attack &&= !playerDodged();
			
			return attack;
		}

		public function eAttack():void {
			if (game.player.hasStatusEffect(StatusEffects.Hemorrhage)) {
				if (hasStatusEffect(StatusEffects.Bloodlust)) addStatusValue(StatusEffects.Bloodlust,1,10);
				else createStatusEffect(StatusEffects.Bloodlust,10,0,0,0);
			}
			if (hasStatusEffect(StatusEffects.Bloodlust) && !game.player.hasStatusEffect(StatusEffects.Hemorrhage)) {
				if (statusEffectv1(StatusEffects.Bloodlust) <= 10) {
					removeStatusEffect(StatusEffects.Bloodlust);
				}
				else {
					addStatusValue(StatusEffects.Bloodlust,1,-10);
				}
			}
			var attacks:int = statusEffectv1(StatusEffects.Attacks);
			if (attacks == 0) attacks = 1;
			while (attacks>0){
				if (attackSucceeded()){
				    var damage:int = eOneAttack();
					outputAttack(damage);
					postAttack(damage);
					game.statScreenRefresh();
					outputText("\n");
				}
				if (statusEffectv1(StatusEffects.Attacks) >= 0) {
					addStatusValue(StatusEffects.Attacks, 1, -1);
				}
				attacks--;
			}
			removeStatusEffect(StatusEffects.Attacks);
//			if (!game.combatRoundOver()) game.doNext(1);
			game.combatRoundOver(); //The doNext here was not required
		}

		/**
		 * Called no matter of success of the attack
		 * @param damage damage received by player
		 */
		protected function postAttack(damage:int):void
		{
			if (damage > 0) {
				if (lustVuln > 0 && player.armorName == "barely-decent bondage straps") {
					if (!plural) outputText("\n" + capitalA + short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed.");
					else outputText("\n" + capitalA + short + " brush against your exposed skin and jerk back in surprise, coloring slightly from seeing so much of you revealed.");
					lust += 5 * lustVuln;
				}
			}
		}

		public function outputAttack(damage:int):void
		{
			if (damage <= 0) {
				//Due to toughness or amor...
				if (rand(player.armorDef + player.tou) < player.armorDef) outputText("You absorb and deflect every " + weaponVerb + " with your " + (player.armor != ArmorLib.NOTHING ? player.armor.name : player.armorName) + ".");
				else {
					if (plural) outputText("You deflect and block every " + weaponVerb + " " + a + short + " throw at you. ");
					else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you. ");
				}
			}
			else if (damage < 6) outputText("You are struck a glancing blow by " + a + short + "! ");
			else if (damage < 11) {
				outputText(capitalA + short + " wound");
				if (!plural) outputText("s");
				outputText(" you! ");
			}
			else if (damage < 21) {
				outputText(capitalA + short + " stagger");
				if (!plural) outputText("s");
				outputText(" you with the force of " + pronoun3 + " " + weaponVerb + "! ");
			}
			else if (damage > 20) {
				outputText(capitalA + short + " <b>mutilate");
				if (!plural) outputText("s");
				outputText("</b> you with " + pronoun3 + " powerful " + weaponVerb + "! ");
			}
			if (damage > 0) {
				if (flags[kFLAGS.ENEMY_CRITICAL] > 0) outputText("<b>Critical hit! </b>");
				outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
		}

		/**
		 * @return true if continue with attack
		 */
		protected function handleBlind():Boolean
		{
			if (rand(3) < 2) {
				if (weaponVerb == "tongue-slap") outputText(capitalA + short + " completely misses you with a thrust from "+pronoun3+" tongue!\n");
				else outputText(capitalA + short + " completely misses you with a blind attack!\n");
				return false;
			}
			return true;
		}

		/**
		 * print something about how we miss the player
		 */
		protected function outputPlayerDodged(dodge:int):void
		{
			if (dodge==1) outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!\n");
			else if (dodge==2) outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!\n");
			else {
				outputText("You deftly avoid " + a + short);
				if (plural) outputText("'");
				else outputText("'s");
				outputText(" slow " + weaponVerb + ".\n");
			}
		}

		private function playerDodged():Boolean
		{
			//Determine if dodged!
			var dodge:int = player.speedDodge(this);
			if (dodge>0) {
				outputPlayerDodged(dodge);
				return true;
			}
			var evasionResult:String = player.getEvasionReason(false); // use separate function for speed dodge for expanded dodge description
			//Determine if evaded
			if (evasionResult == EVASION_EVADE) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'");
				if (!plural) outputText("s");
				outputText(" attack.\n");
				return true;
			}
			//("Misdirection"
			if (evasionResult == EVASION_MISDIRECTION) {
				outputText("Using Raphael's teachings, you anticipate and sidestep " + a + short + "' attacks.\n");
				return true;
			}
			//Determine if cat'ed
			if (evasionResult == EVASION_FLEXIBILITY) {
				outputText("With your incredible flexibility, you squeeze out of the way of " + a + short + "");
				if (plural) outputText("' attacks.\n");
				else outputText("'s attack.\n");
				return true;
			}
			if (evasionResult != null) { // Failsafe fur unhandled
				outputText("Using your superior combat skills you manage to avoid attack completely.\n");
				return true;
			}
			//Parry with weapon
			if (combatParry()) {
				outputText("You manage to block " + a + short + "");
				if (plural) outputText("' attacks ");
				else outputText("'s attack ");
				outputText("with your [weapon].\n");
				return true;
			}
			//Block with shield
			if (combatBlock(true)) {
				outputText("You block " + a + short + "'s " + weaponVerb + " with your [shield]! ");
				if (game.player.findPerk(PerkLib.ShieldCombat) >= 0) game.combat.pspecials.shieldBash();
				return true;
			}
			return false;
		}

		public function doAI():void
		{
			if (hasStatusEffect(StatusEffects.Stunned) || hasStatusEffect(StatusEffects.FreezingBreathStun)) {
				if (!handleStun()) return;
			}
			if (hasStatusEffect(StatusEffects.Fear)) {
				if (!handleFear()) return;
			}
			//Exgartuan gets to do stuff!
			if (game.player.hasStatusEffect(StatusEffects.Exgartuan) && game.player.statusEffectv2(StatusEffects.Exgartuan) == 0 && rand(3) == 0) {
				if (game.exgartuan.exgartuanCombatUpdate()) game.outputText("\n\n");
			}
			if (hasStatusEffect(StatusEffects.Constricted) || hasStatusEffect(StatusEffects.ConstrictedScylla) || hasStatusEffect(StatusEffects.GooEngulf)) {
				if (!handleConstricted()) return;
			}
			if (hasStatusEffect(StatusEffects.AbilityCooldown1) ) {
				if (statusEffectv1(StatusEffects.AbilityCooldown1) <= 0) {
					removeStatusEffect(StatusEffects.AbilityCooldown1);
				}
				else {
					addStatusValue(StatusEffects.AbilityCooldown1,1,-1);
				}
			}
			//If grappling... TODO implement grappling
//			if (game.gameState == 2) {
//				game.gameState = 1;
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
				 mainClassPtr.outputText("Lust Placeholder!!");
				 mainClassPtr.doNext(3);
				 return;*/
//			}
			performCombatAction();
		}

		/**
		 * Called if monster is constricted. Should return true if constriction is ignored and need to proceed with ai
		 */
		protected function handleConstricted():Boolean
		{
			if (player.lowerBody == 26) {
			game.outputText("Your prey pushes at your tentacles, twisting and writhing in an effort to escape from your tentacle's tight bonds.");
			if (statusEffectv1(StatusEffects.ConstrictedScylla) <= 0) {
				game.outputText("  " + capitalA + short + " proves to be too much for your tentacles to handle, breaking free of your tightly bound coils.");
				removeStatusEffect(StatusEffects.ConstrictedScylla);
			}
			addStatusValue(StatusEffects.ConstrictedScylla, 1, -1);
			game.combatRoundOver();
			return false;
			}
			else if (player.lowerBody == 8) {
			game.outputText("" + capitalA + short + " struggle in your fluid form kicking and screaming to try and get out.");
			if (statusEffectv1(StatusEffects.GooEngulf) <= 0) {
				game.outputText("  " + capitalA + short + " proves to be too much for your tentacles to handle, breaking free of your tightly bound coils.");
				removeStatusEffect(StatusEffects.GooEngulf);
			}
			addStatusValue(StatusEffects.GooEngulf, 1, -1);
			game.combatRoundOver();
			return false;
			}
			else {
			game.outputText("Your prey pushes at your tail, twisting and writhing in an effort to escape from your tail's tight bonds.");
			if (statusEffectv1(StatusEffects.Constricted) <= 0) {
				game.outputText("  " + capitalA + short + " proves to be too much for your tail to handle, breaking free of your tightly bound coils.");
				removeStatusEffect(StatusEffects.Constricted);
			}
			addStatusValue(StatusEffects.Constricted, 1, -1);
			game.combatRoundOver();
			return false;
			}
		}

		/**
		 * Called if monster is under fear. Should return true if fear ignored and need to proceed with ai
		 */
		protected function handleFear():Boolean
		{
			if (statusEffectv1(StatusEffects.Fear) == 0) {
				if (plural) {
					removeStatusEffect(StatusEffects.Fear);
					game.outputText("Your foes shake free of their fear and ready themselves for battle.");
				}
				else {
					removeStatusEffect(StatusEffects.Fear);
					game.outputText("Your foe shakes free of its fear and readies itself for battle.");
				}
			}
			else {
				addStatusValue(StatusEffects.Fear, 1, -1);
				if (plural) game.outputText(capitalA + short + " are too busy shivering with fear to fight.");
				else game.outputText(capitalA + short + " is too busy shivering with fear to fight.");
			}
			game.combatRoundOver();
			return false;
		}

		/**
		 * Called if monster is stunned. Should return true if stun is ignored and need to proceed with ai.
		 */
		protected function handleStun():Boolean
		{
			if (statusEffectv1(StatusEffects.Stunned) <= 0) removeStatusEffect(StatusEffects.Stunned);
			else addStatusValue(StatusEffects.Stunned, 1, -1);
			if (hasStatusEffect(StatusEffects.InkBlind)) game.outputText("Your foe is busy trying to remove the ink and therefore does no other action then flay its hand about its face.");
			else if (hasStatusEffect(StatusEffects.FreezingBreathStun)) game.outputText("Your foe is too busy trying to break out of his icy prison to fight back.");
			else if (hasStatusEffect(StatusEffects.MonsterAttacksDisabled)) game.outputText(capitalA + short + " try to hit you but is unable to reach you!");
			else {
			if (plural) game.outputText("Your foes are too dazed from your last hit to strike back!");
			else game.outputText("Your foe is too dazed from your last hit to strike back!");
			}
			game.combatRoundOver();
			return false;
		}

		/**
		 * This method is called after all stun/fear/constricted checks.
		 * Default: Equal chance to do physical or special (if any) attack
		 */
		protected function performCombatAction():void
		{
			var actions:Array = [eAttack,special1,special2,special3].filter(
					function(special:Function, idx:int, array:Array):Boolean {
						return special != null;
					}
			);
			var rando:int = int(Math.random() * (actions.length));
			var action:Function = actions[rando];
			action();
		}

		/**
		 * All branches of this method and all subsequent scenes should end either with
         * 'cleanupAfterCombat', 'awardPlayer' or 'finishCombat'. The latter also displays
		 * default message like "you defeat %s" or "%s falls and starts masturbating"
		 */
		public function defeated(hpVictory:Boolean):void
		{
			game.combat.finishCombat();
		}

		/**
		 * All branches of this method and all subsequent scenes should end with
         * 'cleanupAfterCombat'.
		 */
		public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (hpVictory){
				player.HP = 1;
				outputText("Your wounds are too great to bear, and you fall unconscious.", true);
			} else {
				outputText("Your desire reaches uncontrollable levels, and you end up openly masturbating.\n\nThe lust and pleasure cause you to black out for hours on end.", true);
				player.lust = 0;
			}
			game.inCombat = false;
			game.clearStatuses(false);
			var temp:Number = rand(10) + 1;
			if(temp > player.gems) temp = player.gems;
			outputText("\n\nYou'll probably wake up in eight hours or so, missing " + temp + " gems.");
			player.gems -= temp;
			game.doNext(game.camp.returnToCampUseEightHours);
		}

		/**
		 * Function(hpVictory) to call INSTEAD of default defeated(). Call it or finishCombat() manually
		 */
		public var onDefeated:Function = null;
		/**
		 * Function(hpVictory,pcCameWorms) to call INSTEAD of default won(). Call it or finishCombat() manually
		 */
		public var onWon:Function = null;
		/**
		 * Function() to call INSTEAD of common run attempt. Call runAway(false) to perform default run attempt
		 */
		public var onPcRunAttempt:Function = null;

		/**
		 * Final method to handle hooks before calling overriden method
		 */
		public final function defeated_(hpVictory:Boolean):void
		{
			if (monsterCounters!=null) {
				monsterCounters.lost_total++;
				if (hpVictory) monsterCounters.lost_hp++;
				else monsterCounters.lost_lust++;
			}
			if (onDefeated != null) onDefeated(hpVictory);
			else defeated(hpVictory);
		}

		/**
		 * Final method to handle hooks before calling overriden method
		 */
		public final function won_(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (monsterCounters!=null) {
				monsterCounters.won_total++;
				if (hpVictory) monsterCounters.won_hp++;
				else monsterCounters.won_lust++;
			}
			if (onWon != null) onWon(hpVictory,pcCameWorms);
			else won(hpVictory,pcCameWorms);
		}

		/**
		 * Display tease reaction message. Then call applyTease() to increase lust.
		 * @param lustDelta value to be added to lust (already modified by lustVuln etc)
		 */
		public function teased(lustDelta:Number):void
		{
			outputDefaultTeaseReaction(lustDelta);
			if(lustDelta > 0) {
				//Imp mob uber interrupt!
			  	if(hasStatusEffect(StatusEffects.ImpUber)) { // TODO move to proper class
					outputText("\nThe imps in the back stumble over their spell, their loincloths tenting obviously as your display interrupts their casting.  One of them spontaneously orgasms, having managed to have his spell backfire.  He falls over, weakly twitching as a growing puddle of whiteness surrounds his defeated form.");
					//(-5% of max enemy HP)
					HP -= bonusHP * .05;
					lust -= 15;
					removeStatusEffect(StatusEffects.ImpUber);
					createStatusEffect(StatusEffects.ImpSkip,0,0,0,0);
				}
			}
			applyTease(lustDelta);
		}

		protected function outputDefaultTeaseReaction(lustDelta:Number):void
		{
			if (plural) {
				if (lustDelta == 0) outputText("\n\n" + capitalA + short + " seem unimpressed.");
				if (lustDelta > 0 && lustDelta < 4) outputText("\n" + capitalA + short + " look intrigued by what " + pronoun1 + " see.");
				if (lustDelta >= 4 && lustDelta < 10) outputText("\n" + capitalA + short + " definitely seem to be enjoying the show.");
				if (lustDelta >= 10 && lustDelta < 15) outputText("\n" + capitalA + short + " openly stroke " + pronoun2 + "selves as " + pronoun1 + " watch you.");
				if (lustDelta >= 15 && lustDelta < 20) outputText("\n" + capitalA + short + " flush hotly with desire, " + pronoun3 + " eyes filled with longing.");
				if (lustDelta >= 20) outputText("\n" + capitalA + short + " lick " + pronoun3 + " lips in anticipation, " + pronoun3 + " hands idly stroking " + pronoun3 + " bodies.");
			}
			else {
				if (lustDelta == 0) outputText("\n" + capitalA + short + " seems unimpressed.");
				if (lustDelta > 0 && lustDelta < 4) {
					if (plural) outputText("\n" + capitalA + short + " looks intrigued by what " + pronoun1 + " see.");
					else outputText("\n" + capitalA + short + " looks intrigued by what " + pronoun1 + " sees.");
				}
				if (lustDelta >= 4 && lustDelta < 10) outputText("\n" + capitalA + short + " definitely seems to be enjoying the show.");
				if (lustDelta >= 10 && lustDelta < 15) {
					if (plural) outputText("\n" + capitalA + short + " openly strokes " + pronoun2 + "selves as " + pronoun1 + " watch you.");
					else outputText("\n" + capitalA + short + " openly strokes " + pronoun2 + "self as " + pronoun1 + " watches you.");
				}
				if (lustDelta >= 15 && lustDelta < 20) {
					if (plural) outputText("\n" + capitalA + short + " flush hotly with desire, " + pronoun3 + " eyes filling with longing.");
					else outputText("\n" + capitalA + short + " flushes hotly with desire, " + pronoun3 + " eyes filled with longing.");
				}
				if (lustDelta >= 20) {
					if (plural) outputText("\n" + capitalA + short + " licks " + pronoun3 + " lips in anticipation, " + pronoun3 + " hands idly stroking " + pronoun3 + " own bodies.");
					else outputText("\n" + capitalA + short + " licks " + pronoun3 + " lips in anticipation, " + pronoun3 + " hands idly stroking " + pronoun3 + " own body.");
				}
			}
		}

		protected function applyTease(lustDelta:Number):void{
			lust += lustDelta;
			lustDelta = Math.round(lustDelta * 10)/10;
			outputText(" <b>(<font color=\"#ff00ff\">" + lustDelta + "</font>)</b>");
		}

		public function generateDebugDescription():String{
			var result:String;
			var be:String =plural?"are":"is";
			var have:String = plural ? "have" : "has";
			var Heis:String = Pronoun1+" "+be+" ";
			var Hehas:String = Pronoun1 + " " + have + " ";
			result = "You are inspecting "+a+short+" (imageName='"+imageName+"', class='"+getQualifiedClassName(this)+"'). You are fighting "+pronoun2+".\n\n";
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
			result += ", "+pronoun1+" "+have+" "+skinTone+" "+skinAdj+" "+skinDesc+
					  " (base "+(Appearance.DEFAULT_SKIN_NAMES[skin.baseType()]||("skinType#"+skin.baseType()))+")." +
					  " (coat "+(Appearance.DEFAULT_SKIN_NAMES[skin.coatType()]||("skinType#"+skin.coatType()))+")." +
					  "\n";
			result += Hehas;
			if (hairLength>0){
				result += hairColor+" "+Appearance.inchesAndFeetsAndInches(hairLength)+" long "+(Appearance.DEFAULT_HAIR_NAMES[hairType]||("hairType#"+hairType))+" hair.\n";
			} else {
				result += "no hair.\n";
			}
			result += Hehas;
			if (beardLength>0){
				result += hairColor+" "+Appearance.inchesAndFeetsAndInches(beardLength)+" long "+(Appearance.DEFAULT_BEARD_NAMES[beardStyle]||("beardType#"+beardStyle))+".\n";
			} else {
				result += "no beard.\n";
			}
			result += Hehas
					+(Appearance.DEFAULT_FACE_NAMES[faceType]||("faceType#"+faceType))+" face, "
					+(Appearance.DEFAULT_EARS_NAMES[earType]||("earType#"+earType))+" ears, "
					+(Appearance.DEFAULT_TONGUE_NAMES[tongueType]||("tongueType#"+tongueType))+" tongue and "
					+(Appearance.DEFAULT_EYES_NAMES[eyeType]||("eyeType#"+eyeType))+" eyes.\n";
			result += Hehas;
			if (tailType == TAIL_TYPE_NONE) result += "no tail, ";
			else result+=(Appearance.DEFAULT_TAIL_NAMES[tailType]||("tailType#"+tailType))+" "+tailCount+" tails with venom="+tailVenom+" and recharge="+tailRecharge+", ";
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
				if (statusEffectv1(StatusEffects.BonusVCapacity) > 0){
					result+= "; vaginal capacity is increased by " + statusEffectv1(StatusEffects.BonusVCapacity);
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
			if (statusEffectv1(StatusEffects.BonusACapacity) > 0){
				result += "; anal capacity is increased by " + statusEffectv1(StatusEffects.BonusACapacity);
			}
			result +=".\n\n";

			// COMBAT AND OTHER STATS
			result += Hehas + "str=" + str + ", tou=" + tou + ", spe=" + spe+", inte=" + inte+", lib=" + lib + ", sens=" + sens + ", cor=" + cor + ".\n";
			result += Pronoun1 + " can " + weaponVerb + " you with  " + weaponPerk + " " + weaponName+" (attack " + weaponAttack + ", value " + weaponValue+").\n";
			result += Pronoun1 + " is guarded with " + armorPerk + " " + armorName+" (defense " + armorDef + ", value " + armorValue+").\n";
			result += Hehas + HP + "/" + eMaxHP() + " HP, " + lust + "/" + eMaxLust() + " lust, " + fatigue + "/" + eMaxFatigue() + " fatigue, " + mana + "/" + eMaxMana() + " mana. " + Pronoun3 + " bonus HP=" + bonusHP + ", bonus lust=" + bonusLust + ", and lust vulnerability=" + lustVuln + ".\n";
			result += Heis + "level " + level + " and " + have+" " + gems + " gems. You will be awarded " + XP + " XP.\n";		//, " + soulforce + "/" + eMaxSoulforce() + " soulforce
			
			var numSpec:int = (special1 != null ? 1 : 0) + (special2 != null ? 1 : 0) + (special3 != null ? 1 : 0);
			if (numSpec > 0) {
				result += Hehas + numSpec + " special attack" + (numSpec > 1 ? "s" : "") + ".\n";
			}
			else {
				result += Hehas + "no special attacks.\n";
			}

			return result;
		}

		protected function clearOutput():void
		{
			game.clearOutput();
		}

		public function dropLoot():ItemType
		{
			return _drop.roll() as ItemType;
		}

		public function combatRoundUpdate():void
		{
			if(hasStatusEffect(StatusEffects.MilkyUrta)) {
				game.urtaQuest.milkyUrtaTic();
			}
			//Countdown
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.TentacleCoolDown);
			if(sac) {
				sac.value1 -= 1;
				if (sac.value1 <= 0) {
					removeStatusEffect(StatusEffects.TentacleCoolDown);
				}
			}
			if(hasStatusEffect(StatusEffects.CoonWhip)) {
				if(statusEffectv2(StatusEffects.CoonWhip) <= 0) {
					armorDef += statusEffectv1(StatusEffects.CoonWhip);
					outputText("<b>Tail whip wears off!</b>\n\n");
					removeStatusEffect(StatusEffects.CoonWhip);
				}
				else {
					addStatusValue(StatusEffects.CoonWhip,2,-1);
					outputText("<b>Tail whip is currently reducing your foe");
					if(plural) outputText("s'");
					else outputText("'s");
					outputText(" armor by " + statusEffectv1(StatusEffects.CoonWhip) + ".</b>\n\n")
				}
			}
			if(hasStatusEffect(StatusEffects.TailSlamWhip)) {
				if(statusEffectv2(StatusEffects.TailSlamWhip) <= 0) {
					armorDef += statusEffectv1(StatusEffects.TailSlamWhip);
					outputText("<b>Tail slam wears off!</b>\n\n");
					removeStatusEffect(StatusEffects.TailSlamWhip);
				}
				else {
					addStatusValue(StatusEffects.TailSlamWhip,2,-1);
					outputText("<b>Tail slam is currently reducing your foe");
					if(plural) outputText("s'");
					else outputText("'s");
					outputText(" armor to 0.</b>\n\n")
				}
			}
			if(hasStatusEffect(StatusEffects.Blind)) {
				addStatusValue(StatusEffects.Blind,1,-1);
				if(statusEffectv1(StatusEffects.Blind) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer blind!</b>\n\n");
					removeStatusEffect(StatusEffects.Blind);
				}
				else outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " currently blind!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.InkBlind)) {
				addStatusValue(StatusEffects.InkBlind,1,-1);
				if(statusEffectv1(StatusEffects.InkBlind) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer blind!</b>\n\n");
					removeStatusEffect(StatusEffects.InkBlind);
				}
				else outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " currently blind!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.FreezingBreathStun)) {
				addStatusValue(StatusEffects.FreezingBreathStun,1,-1);
				if(statusEffectv1(StatusEffects.FreezingBreathStun) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer encased in the ice prison!</b>\n\n");
					removeStatusEffect(StatusEffects.FreezingBreathStun);
				}
				else outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " currently encased in the ice prison!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.Earthshield)) {
				outputText("<b>" + capitalA + short + " is protected by a shield of rocks!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.Flying)) {
				addStatusValue(StatusEffects.Flying,1,-1);
				if(statusEffectv1(StatusEffects.Flying) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer flying!</b>\n\n");
					removeStatusEffect(StatusEffects.Flying);
				}
			}
			if(hasStatusEffect(StatusEffects.Sandstorm)) {
				//Blinded:
				if(player.hasStatusEffect(StatusEffects.Blind)) {
					outputText("<b>You blink the sand from your eyes, but you're sure that more will get you if you don't end it soon!</b>\n\n");
					player.removeStatusEffect(StatusEffects.Blind);
				}
				else {
					if(statusEffectv1(StatusEffects.Sandstorm) == 0 || statusEffectv1(StatusEffects.Sandstorm) % 4 == 0) {
						player.createStatusEffect(StatusEffects.Blind,0,0,0,0);
						outputText("<b>The sand is in your eyes!  You're blinded this turn!</b>\n\n");
					}
					else {
						outputText("<b>The grainy mess cuts at any exposed flesh and gets into every crack and crevice of your armor. ");
						var temp:Number = player.takeDamage(1 + rand(2), true);
						outputText("</b>\n\n");
					}
				}
				addStatusValue(StatusEffects.Sandstorm,1,1);
			}
			if(hasStatusEffect(StatusEffects.Stunned)) {
				outputText("<b>" + capitalA + short + " is still stunned!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.Shell)) {
				if(statusEffectv1(StatusEffects.Shell) >= 0) {
					outputText("<b>A wall of many hues shimmers around " + a + short + ".</b>\n\n");
					addStatusValue(StatusEffects.Shell,1,-1);
				}
				else {
					outputText("<b>The magical barrier " + a + short + " erected fades away to nothing at last.</b>\n\n");
					removeStatusEffect(StatusEffects.Shell);
				}
			}
			if(hasStatusEffect(StatusEffects.IzmaBleed)) {
				//Countdown to heal
				addStatusValue(StatusEffects.IzmaBleed,1,-1);
				//Heal wounds
				if (statusEffectv1(StatusEffects.IzmaBleed) <= 0) {
					outputText("The wounds you left on " + a + short + " stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.IzmaBleed);
				}
				//Deal damage if still wounded.
				else {
					var store:Number = eMaxHP() * (4 + rand(7)) / 100;
					if (game.player.findPerk(PerkLib.ThirstForBlood) >= 0) store *= 1.5;
					store = game.doDamage(store);
					if (plural) outputText(capitalA + short + " bleed profusely from the jagged wounds your weapon left behind. <b>(<font color=\"#800000\">" + store + "</font>)</b>\n\n");
					else outputText(capitalA + short + " bleeds profusely from the jagged wounds your weapon left behind. <b>(<font color=\"#800000\">" + store + "</font>)</b>\n\n");
				}
			}
			if(hasStatusEffect(StatusEffects.SharkBiteBleed)) {
				//Countdown to heal
				addStatusValue(StatusEffects.SharkBiteBleed,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.SharkBiteBleed) <= 0) {
					outputText("The bite wounds you left on " + a + short + " stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.SharkBiteBleed);
				}
				//Deal damage if still wounded.
				else {
					var store3:Number = (player.str + player.spe) * 2;
					store3 = game.doDamage(store3);
					if(plural) outputText(capitalA + short + " bleed profusely from the jagged wounds your bite left behind. <b>(<font color=\"#800000\">" + store3 + "</font>)</b>\n\n");
					else outputText(capitalA + short + " bleeds profusely from the jagged wounds your bite left behind. <b>(<font color=\"#800000\">" + store3 + "</font>)</b>\n\n");
				}
			}
			if(hasStatusEffect(StatusEffects.GoreBleed)) {
				//Countdown to heal
				addStatusValue(StatusEffects.GoreBleed,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.GoreBleed) <= 0) {
					outputText("The ");
					if (player.hornType == HORNS_COW_MINOTAUR) outputText("horns wounds");
					else outputText("horn wound");
					outputText(" you left on " + a + short + " stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.GoreBleed);
				}
				//Deal damage if still wounded.
				else {
					var store5:Number = (player.str + player.spe) * 2;
					store5 = game.doDamage(store5);
					if (plural) {
						outputText(capitalA + short + " bleed profusely from the jagged ");
						if (player.hornType == HORNS_COW_MINOTAUR) outputText("wounds your horns");
						else outputText("wound your horn");
						outputText(" left behind. <b>(<font color=\"#800000\">" + store5 + "</font>)</b>\n\n");
					}
					else {
						outputText(capitalA + short + " bleeds profusely from the jagged ");
						if (player.hornType == HORNS_COW_MINOTAUR) outputText("wounds your horns");
						else outputText("wound your horn");
						outputText(" left behind. <b>(<font color=\"#800000\">" + store5 + "</font>)</b>\n\n");
					}
				}
			}
			if (hasStatusEffect(StatusEffects.Bloodlust)) {
				if (this is UnderwaterSharkGirl || this is UnderwaterTigersharkGirl) outputText("As blood flows through the water the shark girl grows increasingly vicious. ");
			}
			if(hasStatusEffect(StatusEffects.Timer)) {
				if(statusEffectv1(StatusEffects.Timer) <= 0)
					removeStatusEffect(StatusEffects.Timer);
				addStatusValue(StatusEffects.Timer,1,-1);
			}
			if(hasStatusEffect(StatusEffects.LustStick)) {
				//LoT Effect Messages:
				switch(statusEffectv1(StatusEffects.LustStick)) {
					//First:
					case 1:
						if(plural) outputText("One of " + a + short + " pants and crosses " + mf("his","her") + " eyes for a moment.  " + mf("His","Her") + " dick flexes and bulges, twitching as " + mf("he","she") + " loses himself in a lipstick-fueled fantasy.  When " + mf("he","she") + " recovers, you lick your lips and watch " + mf("his","her") + " blush spread.\n\n");
						else outputText(capitalA + short + " pants and crosses " + pronoun3 + " eyes for a moment.  " + mf("His","Her") + " dick flexes and bulges, twitching as " + pronoun1 + " loses " + mf("himself", "herself") + " in a lipstick-fueled fantasy.  When " + pronoun1 + " recovers, you lick your lips and watch " + mf("his","her") + " blush spread.\n\n");
						break;
					//Second:
					case 2:
						if(plural) outputText(capitalA + short + " moan out loud, " + pronoun3 + " dicks leaking and dribbling while " + pronoun1 + " struggle not to touch " + pronoun2 + ".\n\n");
						else outputText(capitalA + short + " moans out loud, " + pronoun3 + " dick leaking and dribbling while " + pronoun1 + " struggles not to touch it.\n\n");
						break;
					//Third:
					case 3:
						if(plural) outputText(capitalA + short + " pump " + pronoun3 + " hips futilely, air-humping non-existent partners.  Clearly your lipstick is getting to " + pronoun2 + ".\n\n");
						else outputText(capitalA + short + " pumps " + pronoun3 + " hips futilely, air-humping a non-existent partner.  Clearly your lipstick is getting to " + pronoun2 + ".\n\n");
						break;
					//Fourth:
					case 4:
						if(plural) outputText(capitalA + short + " close " + pronoun3 + " eyes and grunt, " + pronoun3 + " cocks twitching, bouncing, and leaking pre-cum.\n\n");
						else outputText(capitalA + short + " closes " + pronoun2 + " eyes and grunts, " + pronoun3 + " cock twitching, bouncing, and leaking pre-cum.\n\n");
						break;
					//Fifth and repeat:
					default:
						if(plural) outputText("Drops of pre-cum roll steadily out of their dicks.  It's a marvel " + pronoun1 + " haven't given in to " + pronoun3 + " lusts yet.\n\n");
						else outputText("Drops of pre-cum roll steadily out of " + a + short + "'s dick.  It's a marvel " + pronoun1 + " hasn't given in to " + pronoun3 + " lust yet.\n\n");
						break;
				}
				addStatusValue(StatusEffects.LustStick,1,1);
				//Damage = 5 + bonus score minus
				//Reduced by lust vuln of course
				lust += Math.round(lustVuln * (5 + statusEffectv2(StatusEffects.LustStick)));
			}
			if(hasStatusEffect(StatusEffects.PCTailTangle)) {
				//when Entwined
				outputText("You are bound tightly in the kitsune's tails.  <b>The only thing you can do is try to struggle free!</b>\n\n");
				outputText("Stimulated by the coils of fur, you find yourself growing more and more aroused...\n\n");
				game.dynStats("lus", 5+player.sens/10);
			}
			if(hasStatusEffect(StatusEffects.QueenBind)) {
				outputText("You're utterly restrained by the Harpy Queen's magical ropes!\n\n");
				if(flags[kFLAGS.PC_FETISH] >= 2) game.dynStats("lus", 3);
			}
			if(this is SecretarialSuccubus || this is MilkySuccubus) {
				if(player.lust < (player.maxLust() * 0.45)) outputText("There is something in the air around your opponent that makes you feel warm.\n\n");
				if(player.lust >= (player.maxLust() * 0.45) && player.lust < (player.maxLust() * 0.70)) outputText("You aren't sure why but you have difficulty keeping your eyes off your opponent's lewd form.\n\n");
				if(player.lust >= (player.maxLust() * 0.70) && player.lust < (player.maxLust() * 0.90)) outputText("You blush when you catch yourself staring at your foe's rack, watching it wobble with every step she takes.\n\n");
				if(player.lust >= (player.maxLust() * 0.90)) outputText("You have trouble keeping your greedy hands away from your groin.  It would be so easy to just lay down and masturbate to the sight of your curvy enemy.  The succubus looks at you with a sexy, knowing expression.\n\n");
				game.dynStats("lus", 1+rand(8));
			}
			//[LUST GAINED PER ROUND] - Omnibus
			if(hasStatusEffect(StatusEffects.LustAura)) {
				if(this is OmnibusOverseer) {
					if(player.lust < (player.maxLust() * 0.33)) outputText("Your groin tingles warmly.  The demon's aura is starting to get to you.\n\n");
					if(player.lust >= (player.maxLust() * 0.33) && player.lust < (player.maxLust() * 0.66)) outputText("You blush as the demon's aura seeps into you, arousing you more and more.\n\n");
					if(player.lust >= (player.maxLust() * 0.66)) {
						outputText("You flush bright red with desire as the lust in the air worms its way inside you.  ");
						temp = rand(4);
						if(temp == 0) outputText("You have a hard time not dropping to your knees to service her right now.\n\n");
						if(temp == 2) outputText("The urge to bury your face in her breasts and suckle her pink nipples nearly overwhelms you.\n\n");
						if(temp == 1) outputText("You swoon and lick your lips, tasting the scent of the demon's pussy in the air.\n\n");
						if(temp == 3) outputText("She winks at you and licks her lips, and you can't help but imagine her tongue sliding all over your body.  You regain composure moments before throwing yourself at her.  That was close.\n\n");
					}
				}
				if (this is Alraune) {
					if(player.lust < (player.maxLust() * 0.33)) outputText("The pollen in the air gradually increase your arousal.\n\n");
					if(player.lust >= (player.maxLust() * 0.33) && player.lust < (player.maxLust() * 0.66)) outputText("The pollen in the air is getting to you.\n\n");
					if(player.lust >= (player.maxLust() * 0.66)) outputText("You flush bright red with desire as the lust in the air worms its way inside you.\n\n");
				}
				game.dynStats("lus", (3 + int(player.lib/20 + player.cor/30)));
			}
			//immolation DoT
			if (hasStatusEffect(StatusEffects.ImmolationDoT)) {
				//Countdown to heal
				addStatusValue(StatusEffects.ImmolationDoT,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.ImmolationDoT) <= 0) {
					outputText("Flames left by immolation spell " + a + short + " finally stop burning.\n\n");
					removeStatusEffect(StatusEffects.ImmolationDoT);
				}
				//Deal damage if still wounded.
				else {
					var store2:Number = int(50+(player.inte/10));
					store2 = game.doDamage(store2);
					if(plural) outputText(capitalA + short + " burn from lingering immolination after-effect. <b>(<font color=\"#800000\">" + store2 + "</font>)</b>\n\n");
					else outputText(capitalA + short + " burns from lingering immolination after-effect. <b>(<font color=\"#800000\">" + store2 + "</font>)</b>\n\n");
				}
			}
			//Burn DoT
			if (hasStatusEffect(StatusEffects.BurnDoT)) {
				//Countdown to heal
				addStatusValue(StatusEffects.BurnDoT,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.BurnDoT) <= 0) {
					outputText("Flames left by Burn " + a + short + " finally stop burning.\n\n");
					removeStatusEffect(StatusEffects.BurnDoT);
				}
				//Deal damage if still wounded.
				else {
					var store4:Number = (player.str + player.spe) * 2.5;
					store4 = game.doDamage(store4);
					if(plural) outputText(capitalA + short + " burn from lingering Burn after-effect. <b>(<font color=\"#800000\">" + store4 + "</font>)</b>\n\n");
					else outputText(capitalA + short + " burns from lingering Burn after-effect. <b>(<font color=\"#800000\">" + store4 + "</font>)</b>\n\n");
				}
			}
			//regeneration perks for monsters
			if ((findPerk(PerkLib.Regeneration) >= 0 || findPerk(PerkLib.LizanRegeneration) >= 0 || findPerk(PerkLib.LizanMarrow) >= 0 || findPerk(PerkLib.EnemyGodType) >= 0 || findPerk(PerkLib.BodyCultivator) >= 0
			|| findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0 || findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) && (this.HP < eMaxHP()) && (this.HP > 0)) {
				var healingPercent:Number = 0;
				var temp2:Number = 0;
				if(findPerk(PerkLib.Regeneration) >= 0) healingPercent += (0.5 * (1 + player.newGamePlusMod()));
				if(findPerk(PerkLib.LizanRegeneration) >= 0) healingPercent += 1.5;
				if(findPerk(PerkLib.LizanMarrow) >= 0) healingPercent += 0.5;
				if(findPerk(PerkLib.BodyCultivator) >= 0) healingPercent += 0.5;
				if(findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) healingPercent += 1;
				if(findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) healingPercent += 1.5;
				if(findPerk(PerkLib.EnemyGodType) >= 0) healingPercent += 5;
				temp2 = Math.round(eMaxHP() * healingPercent / 100);
				outputText("Due to natural regeneration " + short + " recover");
				if (plural) outputText("s");
				else outputText("ed");
				outputText(" some HP! <b>(<font color=\"#008000\">+" + temp2 + "</font>)</b>.\n\n");
				addHP(temp2);
			}
		}
		
		public function handleAwardItemText(itype:ItemType):void
		{ //New Function, override this function in child classes if you want a monster to output special item drop text
			if (itype != null) outputText("\nThere is " + itype.longName + " on your defeated opponent.  ");
		}

		public function handleAwardText():void
		{ //New Function, override this function in child classes if you want a monster to output special gem and XP text
			//This function doesn’t add the gems or XP to the player, it just provides the output text
			if (this.gems == 1) outputText("\n\nYou snag a single gem and " + this.XP + " XP as you walk away from your victory.");
			else if (this.gems > 1) outputText("\n\nYou grab " + this.gems + " gems and " + this.XP + " XP from your victory.");
			else if (this.gems == 0) outputText("\n\nYou gain " + this.XP + " XP from the battle.");
		}
		
		public function handleCombatLossText(inDungeon:Boolean, gemsLost:int):int
		{ //New Function, override this function in child classes if you want a monster to output special text after the player loses in combat
			//This function doesn’t take the gems away from the player, it just provides the output text
			if (game.prison.inPrison) {
				game.prison.doPrisonEscapeFightLoss();
				return 8;
			}
			if (!inDungeon) {
				if (game.prison.trainingFeed.prisonCaptorFeedingQuestTrainingExists()) {
					if (short == "goblin" || short == "goblin assassin" || short == "goblin warrior" || short == "goblin shaman" || short == "imp" || short == "imp lord" || short == "imp warlord" || short == "imp overlord" || //Generic encounter
						short == "tentacle beast" || (short == "kitsune" && hairColor == "red") || short == "Akbal" || short == "Tamani" || //Forest, deepwoods
						short == "goo-girl" || short == "green slime" || short == "fetish cultist" || short == "fetish zealot" || //Lake
						short == "sandtrap" || short == "sand tarp" || short == "naga" || short == "demons" || short == "Cum Witch" || //Desert
						short == "hellhound" || short == "infested hellhound" || short == "minotaur" || short == "minotaur lord" || short == "minotaur gang" || short == "minotaur tribe" || short == "basilisk" || short == "phoenix" || //Mountain, high mountains
						short == "satyr" || short == "gnoll" || short == "gnoll spear-thrower" || short == "female spider-morph" || short == "male spider-morph" || short == "corrupted drider" || //Plains, swamp, bog
						short == "yeti" || short == "behemoth") { //Glacial rift, volcanic crag
						game.prison.trainingFeed.prisonCaptorFeedingQuestTrainingProgress(1, 1);
					}
				}
				outputText("\n\nYou'll probably come to your senses in eight hours or so");
				if (player.gems > 1)
					outputText(", missing " + gemsLost + " gems.");
				else if (player.gems == 1)
					outputText(", missing your only gem.");
				else outputText(".");
			}
			else {
				outputText("\n\nSomehow you came out of that alive");
				if (player.gems > 1)
					outputText(", but after checking your gem pouch, you realize you're missing " + gemsLost + " gems.");
				else if (player.gems == 1)
					outputText(", but after checking your gem pouch, you realize you're missing your only gem.");
				else outputText(".");
			}
			return 8; //This allows different monsters to delay the player by different amounts of time after a combat loss. Normal loss causes an eight hour blackout
		}

	}
}
