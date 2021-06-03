package classes
{
import classes.BaseContent;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Beard;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Items.ArmorLib;
import classes.Items.ConsumableLib;
import classes.Items.HeadJewelryLib;
import classes.Items.JewelryLib;
import classes.Items.NecklaceLib;
import classes.Items.ShieldLib;
import classes.Items.UndergarmentLib;
import classes.Items.UseableLib;
import classes.Items.WeaponLib;
import classes.Items.WeaponRangeLib;
import classes.Scenes.Areas.Forest.Alraune;
import classes.Scenes.Areas.Ocean.UnderwaterSharkGirl;
import classes.Scenes.Areas.Ocean.UnderwaterSharkGirlsPack;
import classes.Scenes.Areas.Ocean.UnderwaterTigersharkGirl;
import classes.Scenes.Camp;
import classes.Scenes.Combat.Combat;
import classes.Scenes.Combat.CombatMagic;
import classes.Scenes.Dungeons.DenOfDesire.HeroslayerOmnibus;
import classes.Scenes.Dungeons.EbonLabyrinth.Hydra;
import classes.Scenes.Dungeons.Factory.OmnibusOverseer;
import classes.Scenes.Dungeons.Factory.SecretarialSuccubus;
import classes.Scenes.NPCs.ChiChi;
import classes.Scenes.Places.Boat.Marae;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.Quests.UrtaQuest.MilkySuccubus;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;
import classes.internals.EnumValue;
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
        public function newGamePlusMod():int {
            return player.newGamePlusMod();
        }
		protected final function outputText(text:String,clear:Boolean=false):void{
			if (clear) EngineCore.clearOutputTextOnly();
			EngineCore.outputText(text);
		}
		protected final function cleanupAfterCombat():void
		{
			SceneLib.combat.cleanupAfterCombatImpl();
		}
		protected static function showStatDown(a:String):void{
			CoC.instance.mainView.statsView.showStatDown(a);
		}
		protected final function statScreenRefresh():void {
			EngineCore.statScreenRefresh();
		}
		protected final function doNext(eventNo:Function):void { //Now typesafe
			EngineCore.doNext(eventNo);
		}
		protected final function combatMiss():Boolean {
			return SceneLib.combat.combatMiss();
		}
		protected final function combatParry():Boolean {
			return SceneLib.combat.combatParry();
		}
		protected final function combatParry2():Number {
			return SceneLib.combat.combatParry2();
		}
		protected final function combatBlock(doFatigue:Boolean = false):Boolean {
			return SceneLib.combat.combatBlock(doFatigue);
		}
		protected final function combatBlock2():Number {
			return SceneLib.combat.combatBlock2();
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
		protected function get headjewelries():HeadJewelryLib{
			return game.headjewelries;
		}
		protected function get necklaces():NecklaceLib{
			return game.necklaces;
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
		public var bonusSoulforce:Number = 0;
		public var bonusWrath:Number = 0;
		public var bonusMana:Number = 0;
		public var bonusStr:Number = 0;
		public var bonusTou:Number = 0;
		public var bonusSpe:Number = 0;
		public var bonusInte:Number = 0;
		public var bonusWis:Number = 0;
		public var bonusLib:Number = 0;
		protected var bonusAscStr:Number = 0;
		protected var bonusAscTou:Number = 0;
		protected var bonusAscSpe:Number = 0;
		protected var bonusAscInt:Number = 0;
		protected var bonusAscWis:Number = 0;
		protected var bonusAscLib:Number = 0;
		protected var bonusAscSen:Number = 0;
		protected var bonusAscMaxHP:Number = 0;
		private var _long:String = "<b>You have encountered something uninitialized. Please report this as a bug</b>.";
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

		/**
		 * Monster ability descriptors.
		 * Structure:
		 * {
		 *     call: Function - function():void to execute, required
		 *     type: String - either of ABILITY_XXX constants in Creature.as
		 *     range: int - either of RANGE_XXX constants in Creature.as
		 *     tags: String[] - array of extra tags, TAG_XXX in Creature.as
		 *     condition: Function - function():Boolean to check if monster wants to use the ability
		 *     weight: number - relative weight, default 1 (2: will use ability twice as often)
		 * }
		 *
		 * Default structure is:
		 * [
		 * 	{ call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE }
		 * 	{ call: special1, type: ABILITY_PHYSICAL, range: RANGE_MELEE }
		 * 	{ call: special2, type: ABILITY_PHYSICAL, range: RANGE_MELEE }
		 * 	{ call: special3, type: ABILITY_PHYSICAL, range: RANGE_MELEE }
		 * ]
		 */
		public var abilities:/*Object*/Array = [];

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

		protected override function maxHP_base():Number {
			//Base HP
			var temp:Number = 100 + this.level * 30 + this.bonusHP;
			var baseStat:Number = 0;
			if (hasPerk(PerkLib.IcyFlesh)) baseStat += this.inte;
			else if (hasPerk(PerkLib.HaltedVitals)) baseStat += this.lib;
			else baseStat += this.tou;
			temp += (baseStat);
			if (baseStat >= 21) temp += (baseStat*2);
			if (baseStat >= 41) temp += (baseStat*3);
			if (baseStat >= 61) temp += (baseStat*4);
			if (baseStat >= 81) temp += (baseStat*5);
			var multiplier:Number = 6;
			for (var threshold:Number = 101; threshold >= 4999951; threshold += 50) {
				if (baseStat >= threshold) {
					temp += baseStat*multiplier;
					multiplier += 2;
				} else break;
			}
			//Apply NG+, NG++, NG+++, etc.
			temp += this.bonusAscMaxHP * newGamePlusMod();
			//Apply perks
			if (hasPerk(PerkLib.TankI)) temp += ((baseStat*12) * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.GoliathI)) temp += ((this.str*8) * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.CheetahI)) temp += ((this.spe*4) * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.JobGuardian)) temp += 120;
			if (hasPerk(PerkLib.BodyCultivator)) temp += (100 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.FleshBodyApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) temp += (200 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulPersonage)) temp += (200 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulWarrior)) temp += (200 * (1 + newGamePlusMod()));
			}
			if (hasPerk(PerkLib.FleshBodyWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) temp += (300 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulScholar)) temp += (300 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulElder)) temp += (300 * (1 + newGamePlusMod()));
			}
			if (hasPerk(PerkLib.FleshBodyElderStage)) {
				if (hasPerk(PerkLib.SoulExalt)) temp += (400 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulOverlord)) temp += (400 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulTyrant)) temp += (400 * (1 + newGamePlusMod()));
			}
			if (hasPerk(PerkLib.FleshBodyOverlordStage)) {
				if (hasPerk(PerkLib.SoulKing)) temp += (500 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulEmperor)) temp += (500 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulAncestor)) temp += (500 * (1 + newGamePlusMod()));
			}
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) temp += (150 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) temp += (225 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) temp += (300 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) temp += (375 * (1 + newGamePlusMod()));
			var multimax:Number = 1;
			if (hasPerk(PerkLib.RefinedBodyI)) multimax += (0.05 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.LimitBreakerBody1stStage)) multimax += 0.05;
			if (hasPerk(PerkLib.LimitBreakerBody2ndStage)) multimax += 0.1;
			if (hasPerk(PerkLib.DeityJobMunchkin)) multimax += 0.2;
			if (statusEffectv2(StatusEffects.SaiyanNumber1a) > 0) multimax += statusEffectv2(StatusEffects.SaiyanNumber1a);
			if (statusEffectv2(StatusEffects.SaiyanNumber2a) > 0) multimax += statusEffectv2(StatusEffects.SaiyanNumber2a);
			if (statusEffectv2(StatusEffects.SaiyanNumber3a) > 0) multimax += statusEffectv2(StatusEffects.SaiyanNumber3a);
			temp *= multimax;
			if (hasPerk(PerkLib.ShieldWielder)) temp *= 1.2;
			if (hasPerk(PerkLib.EnemyHugeType)) temp *= 1.5;
			if (hasPerk(PerkLib.EnemyGigantType)) temp *= 2.25;
			if (hasPerk(PerkLib.EnemyColossalType)) temp *= 3;
			if (hasPerk(PerkLib.EnemyGroupType)) temp *= 5;
			if (hasPerk(PerkLib.EnemyLargeGroupType)) temp *= 10;
			if (hasPerk(PerkLib.Enemy300Type)) temp *= 15;
			temp *= stats_multi_based_on_misc();
			temp = Math.round(temp);
			return temp;
		}
		public override function maxHP():Number {
            return Math.round(maxHP_base()*maxHP_mult());
        }
		public override function maxOverHP():Number {
			var maxOver:Number = maxHP();
			if (hasPerk(PerkLib.HiddenJobBloodDemon)) {
				if (hasPerk(PerkLib.IcyFlesh)) maxOver += Math.round(this.inte * 10);
				else maxOver += Math.round(this.tou*10);
			}
			if (hasPerk(PerkLib.WayOfTheBlood)) {
				if (hasPerk(PerkLib.IcyFlesh)) maxOver += Math.round(this.inte * 10);
				else maxOver += Math.round(this.tou*10);
			}
			if (hasPerk(PerkLib.YourPainMyPower)) {
				if (hasPerk(PerkLib.IcyFlesh)) maxOver += Math.round(this.inte * 10);
				else maxOver += Math.round(this.tou*10);
			}
			if (hasPerk(PerkLib.MyBloodForBloodPuppies)) {
				if (hasPerk(PerkLib.IcyFlesh)) maxOver += Math.round(this.inte * 10);
				else maxOver += Math.round(this.tou*10);
			}
			if (hasPerk(PerkLib.BloodDemonToughness)) {
				if (hasPerk(PerkLib.IcyFlesh)) maxOver += Math.round(this.inte * 10);
				else maxOver += Math.round(this.tou*10);
			}
			//
			if (hasPerk(PerkLib.BloodDemonWisdom)) {
				if (hasPerk(PerkLib.IcyFlesh)) maxOver += Math.round(this.inte * 10);
				else maxOver += Math.round(this.tou*10);
			}
			//
			if (hasPerk(PerkLib.BloodDemonIntelligence)) {
				if (hasPerk(PerkLib.IcyFlesh)) maxOver += Math.round(this.inte * 10);
				else maxOver += Math.round(this.tou*10);
			}
			return maxOver;
		}
		public override function minHP():Number {
			var min:Number = 0;
			if (hasPerk(PerkLib.Diehard)) {
				min -= maxHP() * 0.02;
				min -= (600 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (hasPerk(PerkLib.ImprovedDiehard)) {
				min -= maxHP() * 0.04;
				min -= (1200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (hasPerk(PerkLib.GreaterDiehard)) {
				min -= maxHP() * 0.06;
				min -= (1800 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (hasPerk(PerkLib.EpicDiehard)) {
				min -= maxHP() * 0.08;
				min -= (2400 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}//nastepny diehard to 10% i 3000
			if (hasPerk(PerkLib.Ferocity)) min -= maxHP() * 0.07;
			if (hasPerk(PerkLib.LizanMarrowFinalForm)) min -= maxHP() * 0.05;
			if (hasPerk(PerkLib.OrcAdrenalGlands)) min -= maxHP() * 0.01;
			if (hasPerk(PerkLib.OrcAdrenalGlandsEvolved)) min -= maxHP() * 0.02;
			if (hasPerk(PerkLib.DeityJobMunchkin)) {
				min -= str;
				min -= tou;
				min -= spe;
				min -= inte;
				min -= wis;
				min -= lib;
				min -= sens;
			}
			min = Math.round(min);
			return min;
		}

		public function addHP(hp:Number):void {
			this.HP += hp;
			if (this.HP <= minHP()) this.HP = minHP();
			else if (this.HP > maxOverHP()) this.HP = maxOverHP();
		}
		public function addSoulforce(soulforce:Number):void {
			this.soulforce += soulforce;
			if (this.soulforce > maxSoulforce()) this.soulforce = maxSoulforce();
		}
		public function addMana(mana:Number):void {
			this.mana += mana;
			if (this.mana > maxMana()) this.mana = maxMana();
		}

		public override function maxLust():Number {
            return Math.round(maxLust_base()*maxLust_mult());
        }
		protected override function maxLust_base():Number {
			//Base lust
			var temp:Number = 100 + this.level * 4;
			if (this.level >= 24) temp += (this.level - 23) * 6;
			if (this.level >= 42) temp += (this.level - 42) * 10;
			if (this.level >= 72) temp += (this.level - 72) * 20;
			if (this.level >= 102) temp += (this.level - 102) * 40;
			//Apply perks
			if (hasPerk(PerkLib.BasicSelfControl)) temp += 45;
			if (hasPerk(PerkLib.HalfStepToImprovedSelfControl)) temp += 75;
			if (hasPerk(PerkLib.ImprovedSelfControl)) temp += 120;
			if (hasPerk(PerkLib.HalfStepToAdvancedSelfControl)) temp += 180;
			if (hasPerk(PerkLib.AdvancedSelfControl)) temp += 300;
			if (hasPerk(PerkLib.HalfStepToSuperiorSelfControl)) temp += 480;
			if (hasPerk(PerkLib.SuperiorSelfControl)) temp += 750;
			if (hasPerk(PerkLib.HalfStepToPeerlessSelfControl)) temp += 1050;
			if (hasPerk(PerkLib.PeerlessSelfControl)) temp += 1500;
			if (hasPerk(PerkLib.HalfStepToInhumanSelfControl)) temp += 2250;
			if (hasPerk(PerkLib.InhumanSelfControl)) temp += 3000;
			if (hasPerk(PerkLib.HalfStepToEpicSelfControl)) temp += 4500;
			if (hasPerk(PerkLib.EpicSelfControl)) temp += 6750;
			if (hasPerk(PerkLib.HalfStepToLegendarySelfControl)) temp += 10500;
			if (hasPerk(PerkLib.LegendarySelfControl)) temp += 15000;
			if (hasPerk(PerkLib.HalfStepToMythicalSelfControl)) temp += 22500;
			if (hasPerk(PerkLib.MythicalSelfControl)) temp += 30000;
			if (hasPerk(PerkLib.Mage)) temp += 15;
			if (hasPerk(PerkLib.GrandMage)) temp += 30;
			if (hasPerk(PerkLib.Archmage)) temp += 45;
			if (hasPerk(PerkLib.GrandArchmage)) temp += 60;
			if (hasPerk(PerkLib.GrandArchmage2ndCircle)) temp += 75;
			if (hasPerk(PerkLib.GrandArchmage3rdCircle)) temp += 90;
			if (hasPerk(PerkLib.GreyMage)) temp += 120;
			if (hasPerk(PerkLib.GreyArchmage)) temp += 150;
			if (hasPerk(PerkLib.InhumanDesireI)) temp += Math.round(this.lib * 3 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.JobCourtesan)) temp += 60;
			if (hasPerk(PerkLib.JobSeducer)) temp += 30;
			if (hasPerk(PerkLib.PrestigeJobGreySage)) temp += 300;
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) temp += (150 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) temp += (225 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) temp += (300 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) temp += (375 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.UnlockArdor)) temp += level * 3;
			if (hasPerk(PerkLib.UnlockArdor2ndStage)) temp += level * 3;
			if (hasPerk(PerkLib.UnlockArdor3rdStage)) temp += level * 3;
			if (hasPerk(PerkLib.UnlockArdor4thStage)) temp += level * 3;
			//Apply NG+, NG++, NG+++, etc.
			var anotherOne:Number = this.bonusLust;
			if (hasPerk(PerkLib.EnemyGroupType)) anotherOne *= 5;
			if (hasPerk(PerkLib.EnemyLargeGroupType)) anotherOne *= 10;
			if (hasPerk(PerkLib.Enemy300Type)) anotherOne *= 15;
			anotherOne *= (1 + newGamePlusMod());
			temp += anotherOne;
			var multimax:Number = 1;
			if (hasPerk(PerkLib.DemonicDesireI)) multimax += (0.05 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.LimitBreakerHeart1stStage)) multimax += 0.05;
			if (hasPerk(PerkLib.LimitBreakerHeart2ndStage)) multimax += 0.1;
			if (hasPerk(PerkLib.DeityJobMunchkin)) multimax += 0.2;
			if (statusEffectv3(StatusEffects.SaiyanNumber1a) > 0) multimax += statusEffectv3(StatusEffects.SaiyanNumber1a);
			if (statusEffectv3(StatusEffects.SaiyanNumber2a) > 0) multimax += statusEffectv3(StatusEffects.SaiyanNumber2a);
			if (statusEffectv3(StatusEffects.SaiyanNumber3a) > 0) multimax += statusEffectv3(StatusEffects.SaiyanNumber3a);
			temp *= multimax;
			temp *= stats_multi_based_on_misc();
			if (this.level < 6) temp *= 0.5;
			if (this.level < 3) temp *= 0.5;
			temp = Math.round(temp);
			return temp;
		}

		public override function maxFatigue():Number {
			//Base fatigue
			var temp:Number = 100 + this.level * 5;
			//Apply perks
			if (hasPerk(PerkLib.BasicEndurance)) temp += 30;
			if (hasPerk(PerkLib.HalfStepToImprovedEndurance)) temp += 50;
			if (hasPerk(PerkLib.ImprovedEndurance)) temp += 80;
			if (hasPerk(PerkLib.HalfStepToAdvancedEndurance)) temp += 120;
			if (hasPerk(PerkLib.AdvancedEndurance)) temp += 200;
			if (hasPerk(PerkLib.HalfStepToSuperiorEndurance)) temp += 320;
			if (hasPerk(PerkLib.SuperiorEndurance)) temp += 500;
			if (hasPerk(PerkLib.HalfStepToPeerlessEndurance)) temp += 700;
			if (hasPerk(PerkLib.PeerlessEndurance)) temp += 1000;
			if (hasPerk(PerkLib.HalfStepToInhumanEndurance)) temp += 1500;
			if (hasPerk(PerkLib.InhumanEndurance)) temp += 2000;
			if (hasPerk(PerkLib.HalfStepToEpicEndurance)) temp += 3000;
			if (hasPerk(PerkLib.EpicEndurance)) temp += 4500;
			if (hasPerk(PerkLib.HalfStepToLegendaryEndurance)) temp += 7000;
			if (hasPerk(PerkLib.LegendaryEndurance)) temp += 10000;
			if (hasPerk(PerkLib.HalfStepToMythicalEndurance)) temp += 15000;
			if (hasPerk(PerkLib.MythicalEndurance)) temp += 20000;
			if (hasPerk(PerkLib.ArchersStaminaI)) temp += Math.round(this.spe * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.NaturesSpringI)) temp += (20 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.JobHunter)) temp += 50;
			if (hasPerk(PerkLib.JobRanger)) temp += 5;
			if (hasPerk(PerkLib.PrestigeJobArcaneArcher)) temp += 600;
			if (hasPerk(PerkLib.PrestigeJobSoulArcher)) temp += 150;
			if (hasPerk(PerkLib.PrestigeJobSeer)) temp += 900;
			if (hasPerk(PerkLib.EromancyBeginner)) temp += Math.round(this.lib);
			if (hasPerk(PerkLib.EromancyExpert)) temp += Math.round(this.lib * 2);
			if (hasPerk(PerkLib.EromancyMaster)) temp += Math.round(this.lib * 2);
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) temp += (100 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) temp += (150 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) temp += (200 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) temp += (250 * (1 + newGamePlusMod()));
			var multimax:Number = 1;
			if (hasPerk(PerkLib.LimitBreakerHeart1stStage)) multimax += 0.05;
			if (hasPerk(PerkLib.LimitBreakerHeart2ndStage)) multimax += 0.1;
			if (hasPerk(PerkLib.DeityJobMunchkin)) multimax += 0.1;
			temp *= multimax;
			temp *= stats_multi_based_on_misc();
			temp = Math.round(temp);
			return temp;
		}

		public override function maxSoulforce():Number {
			//Base soulforce
			var temp:Number = 50 + this.bonusSoulforce;
			if (hasPerk(PerkLib.JobSoulCultivator)) {
				if (this.level >= 2) temp += 25;
				if (this.level >= 4) temp += 25;
			}
			if (hasPerk(PerkLib.SoulApprentice)) {
				if (this.level >= 6) temp += 30;
				if (this.level >= 8) temp += 30;
				if (this.level >= 10) temp += 30;
			}
			if (hasPerk(PerkLib.SoulPersonage)) {
				if (this.level >= 12) temp += 40;
				if (this.level >= 14) temp += 40;
				if (this.level >= 16) temp += 40;
			}
			if (hasPerk(PerkLib.SoulWarrior)) {
				if (this.level >= 18) temp += 50;
				if (this.level >= 20) temp += 50;
				if (this.level >= 22) temp += 50;
			}
			if (hasPerk(PerkLib.SoulSprite)) {
				if (this.level >= 24) temp += 60;
				if (this.level >= 26) temp += 60;
				if (this.level >= 28) temp += 60;
			}
			if (hasPerk(PerkLib.SoulScholar)) {
				if (this.level >= 30) temp += 70;
				if (this.level >= 32) temp += 70;
				if (this.level >= 34) temp += 70;
			}
			if (hasPerk(PerkLib.SoulElder)) {
				if (this.level >= 36) temp += 80;
				if (this.level >= 38) temp += 80;
				if (this.level >= 40) temp += 80;
			}
			if (hasPerk(PerkLib.InsightfulResourcesI)) temp += Math.round((this.wis*5) * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.DaoistApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) temp += 30;
				if (hasPerk(PerkLib.SoulPersonage)) temp += 30;
				if (hasPerk(PerkLib.SoulWarrior)) temp += 30;
			}
			if (hasPerk(PerkLib.DaoistWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) temp += 40;
				if (hasPerk(PerkLib.SoulScholar)) temp += 40;
				if (hasPerk(PerkLib.SoulElder)) temp += 40;
			}
			if (hasPerk(PerkLib.DaoistElderStage)) {
				if (hasPerk(PerkLib.SoulExalt)) temp += 50;
				if (hasPerk(PerkLib.SoulOverlord)) temp += 50;
				if (hasPerk(PerkLib.SoulTyrant)) temp += 50;
			}
			if (hasPerk(PerkLib.DaoistOverlordStage)) {
				if (hasPerk(PerkLib.SoulKing)) temp += 60;
				if (hasPerk(PerkLib.SoulEmperor)) temp += 60;
				if (hasPerk(PerkLib.SoulAncestor)) temp += 60;
			}
			var multimax:Number = 1;
			if (hasPerk(PerkLib.DeityJobMunchkin)) multimax += 0.1;
			if (hasPerk(PerkLib.LimitBreakerSoul1stStage)) multimax += 0.05;
			if (hasPerk(PerkLib.LimitBreakerSoul2ndStage)) multimax += 0.1;
			temp *= multimax;
			temp *= stats_multi_based_on_misc();
			temp = Math.round(temp);
			if ((hasPerk(PerkLib.EnemyTrueDemon) && !hasPerk(PerkLib.Phylactery)) || (hasPerk(PerkLib.EnemyConstructType) && !hasPerk(PerkLib.Sentience))) temp = 0;
			return temp;
		}

		public override function maxWrath():Number {
			//Base wrath
			var temp:Number = 500 + (this.bonusWrath * 5);
			if (hasPerk(PerkLib.DoubleAttack)) temp += 50;
			if (hasPerk(PerkLib.TripleAttack)) temp += 50;
			if (hasPerk(PerkLib.QuadrupleAttack)) temp += 50;
			if (hasPerk(PerkLib.PentaAttack)) temp += 50;
			if (hasPerk(PerkLib.HexaAttack)) temp += 50;
			if (hasPerk(PerkLib.DoubleAttackLarge)) temp += 100;
			if (hasPerk(PerkLib.TripleAttackLarge)) temp += 100;
			if (hasPerk(PerkLib.FeralArmor)) temp += 100;
			if (hasPerk(PerkLib.ClawTraining)) temp += 100;
			if (hasPerk(PerkLib.ExtraClawAttack)) temp += 150;
			if (hasPerk(PerkLib.MultiClawAttack)) temp += 200;
			if (hasPerk(PerkLib.ClawingFlurry)) temp += 250;
			if (hasPerk(PerkLib.BasicTranquilness)) temp += 75;
			if (hasPerk(PerkLib.HalfStepToImprovedTranquilness)) temp += 125;
			if (hasPerk(PerkLib.ImprovedTranquilness)) temp += 200;
			if (hasPerk(PerkLib.HalfStepToAdvancedTranquilness)) temp += 300;
			if (hasPerk(PerkLib.AdvancedTranquilness)) temp += 500;
			if (hasPerk(PerkLib.HalfStepToSuperiorTranquilness)) temp += 800;
			if (hasPerk(PerkLib.SuperiorTranquilness)) temp += 1250;
			if (hasPerk(PerkLib.HalfStepToPeerlessTranquilness)) temp += 1750;
			if (hasPerk(PerkLib.PeerlessTranquilness)) temp += 2500;
			if (hasPerk(PerkLib.HalfStepToInhumanTranquilness)) temp += 3750;
			if (hasPerk(PerkLib.InhumanTranquilness)) temp += 5000;
			if (hasPerk(PerkLib.HalfStepToEpicTranquilness)) temp += 7500;
			if (hasPerk(PerkLib.EpicTranquilness)) temp += 11250;
			if (hasPerk(PerkLib.HalfStepToLegendaryTranquilness)) temp += 17500;
			if (hasPerk(PerkLib.LegendaryTranquilness)) temp += 25000;
			if (hasPerk(PerkLib.HalfStepToMythicalTranquilness)) temp += 37500;
			if (hasPerk(PerkLib.MythicalTranquilness)) temp += 50000;
			if (hasPerk(PerkLib.JobSwordsman)) temp += 100;
			if (hasPerk(PerkLib.JobBeastWarrior)) temp += 100;
			if (hasPerk(PerkLib.JobDervish)) temp += 100;
			if (hasPerk(PerkLib.JobWarlord)) temp += 100;
			if (hasPerk(PerkLib.JobWarrior)) temp += 50;
			if (hasPerk(PerkLib.ImprovedCrinosShape)) temp += 200;
			if (hasPerk(PerkLib.GreaterCrinosShape)) temp += 400;
			if (hasPerk(PerkLib.MasterCrinosShape)) temp += 800;
			if (hasPerk(PerkLib.Berzerker)) temp += 500;
			if (hasPerk(PerkLib.ColdFury)) temp += 250;
			if (hasPerk(PerkLib.ColderFury)) temp += 375;
			if (hasPerk(PerkLib.Lustzerker)) temp += 500;
			if (hasPerk(PerkLib.ColdLust)) temp += 250;
			if (hasPerk(PerkLib.ColderLust)) temp += 375;
			if (hasPerk(PerkLib.PrestigeJobBerserker)) temp += 1000;
			if (hasPerk(PerkLib.Rage)) temp += 1500;
			if (hasPerk(PerkLib.Anger)) temp += 2000;
			if (hasPerk(PerkLib.FuelForTheFire)) temp += 2500;
			if (hasPerk(PerkLib.TooAngryToDie)) temp += 3000;
			if (hasPerk(PerkLib.PrestigeJobTempest)) temp += 500;
			if (hasPerk(PerkLib.WarMageNovice)) temp += 50;
			if (hasPerk(PerkLib.WarMageApprentice)) temp += 50;
			if (hasPerk(PerkLib.WarMageAdept)) temp += 150;
			if (hasPerk(PerkLib.EnemyFeralType)) {
				temp += 2500;
				if (hasPerk(PerkLib.EnemyGroupType)) temp += 10000;
				if (hasPerk(PerkLib.EnemyLargeGroupType)) temp += 20000;
				if (hasPerk(PerkLib.Enemy300Type)) temp += 300000;
			}
			temp += this.level * 5;
			var multimax:Number = 1;
			if (hasPerk(PerkLib.PrimalFuryI)) multimax += (0.05 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.LimitBreakerBody1stStage)) multimax += 0.05;
			if (hasPerk(PerkLib.LimitBreakerBody2ndStage)) multimax += 0.1;
			if (hasPerk(PerkLib.DeityJobMunchkin)) multimax += 0.2;
			if (hasPerk(PerkLib.ICastAsuraFist)) multimax += 0.5;
			if (statusEffectv4(StatusEffects.SaiyanNumber1a) > 0) multimax += statusEffectv4(StatusEffects.SaiyanNumber1a);
			if (statusEffectv4(StatusEffects.SaiyanNumber2a) > 0) multimax += statusEffectv4(StatusEffects.SaiyanNumber2a);
			if (statusEffectv4(StatusEffects.SaiyanNumber3a) > 0) multimax += statusEffectv4(StatusEffects.SaiyanNumber3a);
			temp *= multimax;
			temp *= stats_multi_based_on_misc();
			temp = Math.round(temp);
			if (hasPerk(PerkLib.EnemyConstructType) && !hasPerk(PerkLib.Sentience)) temp = 0;
			return temp;
		}
		public override function maxOverWrath():Number {
			var temp1:Number = this.maxWrath();
			var temp2:Number = 1;
			if (hasPerk(PerkLib.HiddenJobAsura)) temp2 += 0.1;
			if (hasPerk(PerkLib.AbsoluteStrength)) temp2 += 0.1;
			if (hasPerk(PerkLib.LikeAnAsuraBoss)) temp2 += 0.1;
			if (hasPerk(PerkLib.ICastAsuraFist)) temp2 += 0.1;
			if (hasPerk(PerkLib.AsuraStrength)) temp2 += 0.1;
			//
			if (hasPerk(PerkLib.AsuraToughness)) temp2 += 0.1;
			//
			if (hasPerk(PerkLib.AsuraSpeed)) temp2 += 0.1;
			temp1 *= temp2;
			return temp1;
		}

		public override function maxMana():Number {
			//Base mana
			var temp:Number = 300 + this.level * 10 + this.bonusMana;
			if (hasPerk(PerkLib.BasicSpirituality)) temp += 135;
			if (hasPerk(PerkLib.HalfStepToImprovedSpirituality)) temp += 225;
			if (hasPerk(PerkLib.ImprovedSpirituality)) temp += 360;
			if (hasPerk(PerkLib.HalfStepToAdvancedSpirituality)) temp += 540;
			if (hasPerk(PerkLib.AdvancedSpirituality)) temp += 900;
			if (hasPerk(PerkLib.HalfStepToSuperiorSpirituality)) temp += 1440;
			if (hasPerk(PerkLib.SuperiorSpirituality)) temp += 2250;
			if (hasPerk(PerkLib.HalfStepToPeerlessSpirituality)) temp += 3150;
			if (hasPerk(PerkLib.PeerlessSpirituality)) temp += 4500;
			if (hasPerk(PerkLib.HalfStepToInhumanSpirituality)) temp += 6750;
			if (hasPerk(PerkLib.InhumanSpirituality)) temp += 9000;
			if (hasPerk(PerkLib.HalfStepToEpicSpirituality)) temp += 13500;
			if (hasPerk(PerkLib.EpicSpirituality)) temp += 20250;
			if (hasPerk(PerkLib.HalfStepToLegendarySpirituality)) temp += 31500;
			if (hasPerk(PerkLib.LegendarySpirituality)) temp += 45000;
			if (hasPerk(PerkLib.HalfStepToMythicalSpirituality)) temp += 67500;
			if (hasPerk(PerkLib.MythicalSpirituality)) temp += 90000;
			if (hasPerk(PerkLib.MindOverBodyI)) temp += Math.round((this.inte * 6) * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.ArcanePoolI)) {
				temp += Math.round(this.inte * (3 + newGamePlusMod()));
				temp += Math.round(this.wis * (3 + newGamePlusMod()));
			}
			if (hasPerk(PerkLib.Archmage) && inte >= 100) temp += 180;
			if (hasPerk(PerkLib.Channeling) && inte >= 60) temp += 90;
			if (hasPerk(PerkLib.GrandArchmage) && inte >= 125) temp += 225;
			if (hasPerk(PerkLib.GrandArchmage2ndCircle) && inte >= 150) temp += 270;
			if (hasPerk(PerkLib.GrandArchmage3rdCircle) && inte >= 175) temp += 315;
			if (hasPerk(PerkLib.GrandMage) && inte >= 75) temp += 135;
			if (hasPerk(PerkLib.GreyArchmage) && inte >= 225) temp += 600;
			if (hasPerk(PerkLib.GreyMage) && inte >= 200) temp += 450;
			if (hasPerk(PerkLib.Mage) && inte >= 50) temp += 90;
			if (hasPerk(PerkLib.Spellpower) && inte >= 50) temp += 45;
			if (hasPerk(PerkLib.JobSorcerer)) temp += 45;
			if (hasPerk(PerkLib.JobHealer)) temp += 90;
			if (hasPerk(PerkLib.SpellpowerHealing) && wis >= 50) temp += 90;
			if (hasPerk(PerkLib.EromancyBeginner)) temp += Math.round(this.inte * 3);
			if (hasPerk(PerkLib.EromancyExpert)) temp += Math.round(this.inte * 3);
			if (hasPerk(PerkLib.EromancyMaster)) temp += Math.round(this.inte * 6);
			var tempmulti:Number = 1;
			if (hasPerk(PerkLib.ArcaneRegenerationMinor)) {
				tempmulti += 0.05;
				if (hasPerk(PerkLib.ArcaneRegenerationMajor)) tempmulti += 0.1;
				if (hasPerk(PerkLib.ArcaneRegenerationEpic)) tempmulti += 0.15;
				if (hasPerk(PerkLib.ArcaneRegenerationLegendary)) tempmulti += 0.2;
				if (hasPerk(PerkLib.ArcaneRegenerationMythical)) tempmulti += 0.25;
			}
			if (hasPerk(PerkLib.ManaAffinityI)) tempmulti += (0.03 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.LimitBreakerSoul1stStage)) tempmulti += 0.05;
			if (hasPerk(PerkLib.LimitBreakerSoul2ndStage)) tempmulti += 0.1;
			if (hasPerk(PerkLib.DeityJobMunchkin)) tempmulti += 0.1;
			temp *= tempmulti;
			temp *= stats_multi_based_on_misc();
			temp = Math.round(temp);
			if (hasPerk(PerkLib.EnemyConstructType) && !hasPerk(PerkLib.Sentience)) temp = 0;
			return temp;
		}

		private function stats_multi_based_on_misc():Number {
			var temp:Number = 1;
			if (hasPerk(PerkLib.EnemyEliteType)) temp += 1;
			if (hasPerk(PerkLib.EnemyChampionType)) temp += 2;
			if (hasPerk(PerkLib.EnemyBossType)) temp += 3;
			if (this.level >= 25) temp *= 2;
			if (this.level >= 50) temp *= 2.5;
			if (this.level >= 75) temp *= 3;
			if (this.level >= 100) temp *= 3.5;
			if (this.level >= 125) temp *= 4;
			if (this.level >= 150) temp *= 4.5;
			if (this.level >= 175) temp *= 5;
			if (this.level >= 200) temp *= 5.5;
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) temp *= 2;
			if (flags[kFLAGS.GAME_DIFFICULTY] == 2) temp *= 5;
			if (flags[kFLAGS.GAME_DIFFICULTY] == 3) temp *= 10;
			if (flags[kFLAGS.GAME_DIFFICULTY] == 4) temp *= 25;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 1) temp *= 2;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 2) temp *= 3;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 3) temp *= 4;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 4) temp *= 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 5) temp *= 6;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 6) temp *= 7;//dla gier powyżej obecnego ostatniego NG+ posiadającego nowe perki dla graczy
			if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 1) temp *= 5;
			if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 2) temp *= 10;
			if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 3) temp *= 25;
			if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 4) temp *= 100;
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) temp = 1;
			return temp;
		}

		public override function damagePercent():Number {
			var mult:Number = 100;
			var armorMod:Number = armorDef;
			//--BASE--
			//Modify armor rating based on melee weapons
			if (game.player.weapon == game.weapons.JRAPIER || game.player.weapon == game.weapons.Q_GUARD || game.player.weapon == game.weapons.B_WIDOW || game.player.weapon == game.weapons.SPEAR || game.player.weapon == game.weapons.SESPEAR || game.player.weapon == game.weapons.DSSPEAR || game.player.weapon == game.weapons.SKYPIER || game.player.weapon == game.weapons.LANCE
			 || game.player.weapon == game.weapons.NORTHIP || (game.player.weaponName.indexOf("staff") != -1 && game.player.hasPerk(PerkLib.StaffChanneling) )) armorMod = 0;
			if (game.player.weapon == game.weapons.KATANA) armorMod -= 5;
			if (game.player.weapon == game.weapons.HALBERD) armorMod *= 0.6;
			if (game.player.weapon == game.weapons.GUANDAO) armorMod *= 0.4;
			if (game.player.hasPerk(PerkLib.LungingAttacks)) armorMod *= 0.5;
			if (armorMod < 0) armorMod = 0;
			mult -= armorMod;
			mult -= damagePercentShared();
			//Caps damage reduction at 80/99%.
			//if (monster.hasStatusEffect(StatusEffects.DefendMonsterVer)) cap down to max 99%
			if (mult < 20) mult = 20;
			return mult;
		}
		public override function damageRangePercent():Number {
			var mult:Number = 100;
			var armorMod:Number = armorDef;
			//--BASE--
			//Modify armor rating based on range weapons
			if (game.player.weaponRange == game.weaponsrange.SHUNHAR || game.player.weaponRange == game.weaponsrange.KSLHARP || game.player.weaponRange == game.weaponsrange.LEVHARP) armorMod = 0;
			if (armorMod < 0) armorMod = 0;
			mult -= armorMod;
			mult -= damagePercentShared();
			//Caps damage reduction at 80/99%.
			//if (monster.hasStatusEffect(StatusEffects.DefendMonsterVer)) cap down to max 99%
			if (mult < 20) mult = 20;
			return mult;
		}
		private function damagePercentShared():Number {
			var multShared:Number = 0;
			//--PERKS--
			//Take damage you masochist!
			if (hasPerk(PerkLib.Masochist) && lib >= 60) {
				multShared += 20;
				lust += (2 * (1 + newGamePlusMod()));
				if(armorName == "Scandalous Succubus Clothing") {
					multShared += 20;
					lust += (2 * (1 + newGamePlusMod()));
				}
			}
			if (hasPerk(PerkLib.FenrirSpikedCollar)) {
				multShared += 15;
			}
			if (hasPerk(PerkLib.Juggernaut) && tou >= 100) {
				multShared += 10;
			}
			if (hasPerk(PerkLib.ImmovableObject) && tou >= 75) {
				multShared += 10;
			}
			if (hasPerk(PerkLib.AyoArmorProficiency) && tou >= 75) {
				multShared += 10;
			}
			if (hasPerk(PerkLib.HeavyArmorProficiency) && tou >= 75) {
				multShared += 10;
			}
			if (hasPerk(PerkLib.ShieldHarmony) && tou >= 100 && !hasStatusEffect(StatusEffects.Stunned)) {
				multShared += 10;
			}
			if (hasPerk(PerkLib.NakedTruth) && spe >= 75 && lib >= 60 && (armorName == "arcane bangles" || armorName == "practically indecent steel armor" || armorName == "revealing chainmail bikini" || armorName == "slutty swimwear" || armorName == "barely-decent bondage straps" || armorName == "Scandalous Succubus Clothing" || armorName == "Walpurgis Izalia Cloak" || armorName == "nothing")) {
				multShared += 10;
			}
			//--STATUS AFFECTS--
			if (statusEffectv1(StatusEffects.OniRampage) > 0) {
				multShared += 20;
			}
			if (statusEffectv1(StatusEffects.EarthStance) > 0) {
				multShared += 30;
			}
			//Misc
			if (hasPerk(PerkLib.EnemyGooType)) multShared += 80;
			return multShared;
		}

		public override function damageMagicalPercent():Number {
			var mult:Number = 100;
			var armorMMod:Number = armorMDef;
			//--BASE--
			mult -= armorMMod;
			//--PERKS--
			//--STATUS AFFECTS--
			if (statusEffectv1(StatusEffects.OniRampage) > 0) {
				mult -= 20;
			}
			//Caps damage reduction at 100%.
			if (mult < 0) mult = 0;
			return mult;
		}

		public function canMonsterBleed():Boolean
		{
			return !hasPerk(PerkLib.EnemyConstructType) || !hasPerk(PerkLib.EnemyPlantType) || !hasPerk(PerkLib.EnemyGooType);
		}

		/**
		 * @return HP/eMaxHP()
		 */
		public function HPRatio():Number{
			return HP / maxHP();
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
			if (str >= 101) damage += tieredBonus(str, 50, 100)*0.25;
			if (str < 10) damage = 10;
			//weapon bonus
			if (weaponAttack < 51) damage *= (1 + (weaponAttack * 0.03));
			else if (weaponAttack >= 51 && weaponAttack < 101) damage *= (2.5 + ((weaponAttack - 50) * 0.025));
			else if (weaponAttack >= 101 && weaponAttack < 151) damage *= (3.75 + ((weaponAttack - 100) * 0.02));
			else if (weaponAttack >= 151 && weaponAttack < 201) damage *= (4.75 + ((weaponAttack - 150) * 0.015));
			else damage *= (5.5 + ((weaponAttack - 200) * 0.01));
			if (hasStatusEffect(StatusEffects.PunishingKick)) damage *= 0.5;
			if (hasStatusEffect(StatusEffects.OniRampage)) damage *= 2;
			if (hasStatusEffect(StatusEffects.Hypermode)) damage *= 10;
			if (hasStatusEffect(StatusEffects.Provoke)) damage *= statusEffectv2(StatusEffects.Provoke);
			//monster exclusive perks bonus
			damage *= eBaseMultis();
			//other
			if (hasStatusEffect(StatusEffects.Bloodlust)) damage *= (1 + (0.1 * statusEffectv2(StatusEffects.Bloodlust)));
			if (!hasPerk(PerkLib.JobWarrior) && !hasPerk(PerkLib.JobBeastWarrior) && wrath >= 200) {
				wrath -= 200;
				damage *= 2;
			}
			if ((hasPerk(PerkLib.JobWarrior) || hasPerk(PerkLib.JobBeastWarrior) || hasPerk(PerkLib.EnemyFeralType)) && wrath >= 50) {
				if (this.level >= 36 && wrath >= 600 && rand(2) == 0) {
					wrath -= 600;
					damage *= 8;
				}
				else if (this.level >= 30 && wrath >= 500 && rand(2) == 0) {
					wrath -= 500;
					damage *= 7;
				}
				else if (this.level >= 24 && wrath >= 400 && rand(2) == 0) {
					wrath -= 400;
					damage *= 6;
				}
				else if (this.level >= 18 && wrath >= 300 && rand(2) == 0) {
					wrath -= 300;
					damage *= 5;
				}
				else if (this.level >= 12 && wrath >= 200 && rand(2) == 0) {
					wrath -= 200;
					damage *= 4;
				}
				else if (this.level >= 6 && wrath >= 100 && rand(2) == 0) {
					wrath -= 100;
					damage *= 3;
				}
				else {
					wrath -= 50;
					damage *= 2;
				}
			}
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
			if (str >= 101) damage += tieredBonus(str, 50, 100);
			if (str < 10) damage = 10;
			if (hasStatusEffect(StatusEffects.PunishingKick)) damage *= 0.5;
			if (hasStatusEffect(StatusEffects.Provoke)) damage *= statusEffectv2(StatusEffects.Provoke);
			//monster exclusive perks bonus
			damage *= eBaseMultis();
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
			if (tou >= 101) damage += tieredBonus(tou, 50, 100);
			if (tou < 10) damage = 10;
			if (hasStatusEffect(StatusEffects.PunishingKick)) damage *= 0.5;
			if (hasStatusEffect(StatusEffects.Provoke)) damage *= statusEffectv2(StatusEffects.Provoke);
			//monster exclusive perks bonus
			damage *= eBaseMultis();
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
			if (spe >= 101) damage += tieredBonus(spe, 50, 100);
			if (spe < 10) damage = 10;
			if (hasStatusEffect(StatusEffects.PunishingKick)) damage *= 0.5;
			if (hasStatusEffect(StatusEffects.Provoke)) damage *= statusEffectv2(StatusEffects.Provoke);
			//monster exclusive perks bonus
			damage *= eBaseMultis();
			damage = Math.round(damage);
			return damage;
		}

		public function eBaseIntelligenceDamage():Number {
			var damage:Number = 0;
			damage += inte;
			if (inte >= 21) damage += (inte - 20);
			if (inte >= 41) damage += (inte - 40);
			if (inte >= 61) damage += (inte - 60);
			if (inte >= 81) damage += (inte - 80);
			if (inte >= 101) damage += tieredBonus(inte, 50, 100);
			if (inte < 10) damage = 10;
			//monster exclusive perks bonus
			damage *= eBaseMultis();
			damage = Math.round(damage);
			return damage;
		}

		public function eBaseWisdomDamage():Number {
			var damage:Number = 0;
			damage += wis;
			if (wis >= 21) damage += (wis - 20);
			if (wis >= 41) damage += (wis - 40);
			if (wis >= 61) damage += (wis - 60);
			if (wis >= 81) damage += (wis - 80);
			if (wis >= 101) damage += tieredBonus(wis, 50, 100);
			if (wis < 10) damage = 10;
			//monster exclusive perks bonus
			damage *= eBaseMultis();
			damage = Math.round(damage);
			return damage;
		}

		private function inteligencescalingbonusMonster(stat:int):Number{
			var scale:Number = 250.75;
			var changeBy:Number = 0.50;
			if(stat <= 5000000){
				if(stat <= 100){
					scale = (2/6) + ((int(stat/100)/20) * (1/6));
					changeBy = 0.25;
				} else {
					scale = 1 + (int((stat - 100)/50) * 0.25);
				}
			}
			return Math.round((stat * scale) + rand(stat * (scale + changeBy)) * eBaseMultis());
		}
		public function inteligencescalingbonus():Number {
			return inteligencescalingbonusMonster(inte);
		}
		public function wisdomscalingbonus():Number {
			return inteligencescalingbonusMonster(wis);
		}

		private function eBaseMultis():Number {
			var datNumber:Number = 1;
			if (level >= 1) datNumber += 0.01;
			if (hasPerk(PerkLib.EnemyBossType)) datNumber *= 2;
			if (hasPerk(PerkLib.EnemyHugeType)) datNumber *= 2;
			if (hasPerk(PerkLib.EnemyGigantType)) datNumber *= 4;
			if (hasPerk(PerkLib.EnemyColossalType)) datNumber *= 6;
			if (hasPerk(PerkLib.Enemy300Type)) datNumber *= 15;
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) datNumber = 1;
			return datNumber;
		}

		/**
		 * @return randomized damage reduced by player stats
		 */
		public function calcDamage():int{
			return player.reducePhysDamage(eBaseDamage());
		}
		public function calcFireDamage():int{
			return player.reduceFireDamage(eBaseDamage());
		}

		public function totalXP(playerLevel:Number=-1):Number
		{
			var multiplier:Number = 1;
			multiplier += game.player.perkv1(PerkLib.AscensionWisdom) * 0.2;
			if (playerLevel == -1) playerLevel = game.player.level;
			// 1) Nerf xp gains by 5% per level after first one level difference up to 95% at 19 lvl diff!
			// 2) Bonuses for underlevel all the way to 20 lvl's below enemy! Above 20 lvl diff bonus is fixed at 300%! With underdog it increase to 40 lvl diff and caps at 900%!
			// 3) Super high level folks (over 10 levels) only get 1 xp!
			var difference:Number = 1;
			var diff2:Number = this.level - playerLevel;
			if (game.player.hasPerk(PerkLib.AscensionUnderdog)) {
				if (diff2 >= 40) difference += 8;
				if (diff2 >= 1 && diff2 < 40) difference += diff2 * 0.2;
			}
			else {
				if (diff2 >= 20) difference += 2;
				if (diff2 >= 1 && diff2 < 20) difference += diff2 * 0.1;
			}
			if (diff2 == -1) difference -= 0.05;
			if (diff2 == -2) difference -= 0.1;
			if (diff2 == -3) difference -= 0.15;
			if (diff2 == -4) difference -= 0.2;
			if (diff2 == -5) difference -= 0.25;
			if (diff2 == -6) difference -= 0.3;
			if (diff2 == -7) difference -= 0.35;
			if (diff2 == -8) difference -= 0.4;
			if (diff2 == -9) difference -= 0.45;
			if (diff2 == -10) difference -= 0.5;
			if (diff2 == -11) difference -= 0.55;
			if (diff2 == -12) difference -= 0.6;
			if (diff2 == -13) difference -= 0.65;
			if (diff2 == -14) difference -= 0.7;
			if (diff2 == -15) difference -= 0.75;
			if (diff2 == -16) difference -= 0.8;
			if (diff2 == -17) difference -= 0.85;
			if (diff2 == -18) difference -= 0.9;
			if (diff2 == -19) difference -= 0.99;
			if (diff2 < -20) {
				var minXP:Number = 1;
				if (hasPerk(PerkLib.ShieldWielder)) minXP *= 1.5;
				if (hasPerk(PerkLib.EnemyBossType)) minXP *= 2;
				if (hasPerk(PerkLib.EnemyHugeType)) minXP *= 2;
				if (hasPerk(PerkLib.EnemyGigantType)) minXP *= 4;
				if (hasPerk(PerkLib.EnemyColossalType)) minXP *= 6;
				if (hasPerk(PerkLib.EnemyGroupType)) minXP *= 5;
				if (hasPerk(PerkLib.EnemyLargeGroupType)) minXP *= 10;
				if (hasPerk(PerkLib.Enemy300Type)) minXP *= 15;
				if (this.humanityBoostExpValue() > 0) minXP += this.humanityBoostExpValue();
				return Math.round(minXP);
			}
			return Math.round(((this.additionalXP + this.baseXP()) * this.bonusXP() * difference * multiplier) + this.humanityBoostExpValue());
		}
		protected function baseXP():Number
		{
			var baseMonXP:Number = this.level * 5;
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) baseMonXP += this.level * 0.5;
			if (flags[kFLAGS.GAME_DIFFICULTY] == 2) baseMonXP += this.level * 1.5;
			if (flags[kFLAGS.GAME_DIFFICULTY] == 3) baseMonXP += this.level * 3;
			if (flags[kFLAGS.GAME_DIFFICULTY] == 4) baseMonXP += this.level * 5;
			if (this.level < 7) baseMonXP += (this.level * 5) + rand(this.level * 5);
			else baseMonXP += rand(this.level * 5);
			return baseMonXP;
		}
		protected function bonusXP():Number
		{
			var specENtypes:Number = 1;
			if (hasPerk(PerkLib.ShieldWielder)) specENtypes *= 1.5;
			if (hasPerk(PerkLib.EnemyBossType)) specENtypes *= 2;
			if (hasPerk(PerkLib.EnemyHugeType)) specENtypes *= 2;
			if (hasPerk(PerkLib.EnemyGigantType)) specENtypes *= 4;
			if (hasPerk(PerkLib.EnemyColossalType)) specENtypes *= 6;
			if (hasPerk(PerkLib.EnemyGroupType)) specENtypes *= 5;
			if (hasPerk(PerkLib.EnemyLargeGroupType)) specENtypes *= 10;
			if (hasPerk(PerkLib.Enemy300Type)) specENtypes *= 15;
			return specENtypes;
		}
		protected function humanity():Number
		{
			var baseHumBoost1:Number = 1;
			if (game.player.level >= 6) baseHumBoost1 += 1;
			if (game.player.level >= 24) baseHumBoost1 += 1;
			if (game.player.level >= 42) baseHumBoost1 += 1;
			if (game.player.level >= 72) baseHumBoost1 += 1;
			if (game.player.level >= 102) baseHumBoost1 += 1;
			if (game.player.level >= 141) baseHumBoost1 += 1;
			if (game.player.level >= 180) baseHumBoost1 += 1;
			//if (level >= 274)
			return baseHumBoost1;
		}
		public function humanityBoostExpValue():Number
		{
			var baseHumBoost:Number = 0;
			if (game.player.humanScore() == game.player.humanMaxScore()) baseHumBoost += this.humanity() * 10;
			if (game.player.humanScore() == game.player.humanMaxScore() - 1) baseHumBoost += this.humanity() * 9;
			if (game.player.humanScore() == game.player.humanMaxScore() - 2) baseHumBoost += this.humanity() * 8;
			if (game.player.humanScore() == game.player.humanMaxScore() - 3) baseHumBoost += this.humanity() * 7;
			if (game.player.humanScore() == game.player.humanMaxScore() - 4) baseHumBoost += this.humanity() * 6;
			if (game.player.humanScore() == game.player.humanMaxScore() - 5) baseHumBoost += this.humanity() * 5;
			if (game.player.humanScore() == game.player.humanMaxScore() - 6) baseHumBoost += this.humanity() * 4;
			if (game.player.humanScore() == game.player.humanMaxScore() - 7) baseHumBoost += this.humanity() * 3;
			if (game.player.humanScore() == game.player.humanMaxScore() - 8) baseHumBoost += this.humanity() * 2;
			if (game.player.humanScore() == game.player.humanMaxScore() - 9) baseHumBoost += this.humanity() * 1;
			return baseHumBoost;
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
			///*OPTIONAL*/ //this.hips.type = HIP_RATING_; // default boyish
			///*OPTIONAL*/ //this.butt.type = BUTT_RATING_; // default buttless
			///*OPTIONAL*/ //this.lowerBody = LOWER_BODY_; //default human
			///*OPTIONAL*/ //this.arms.type = ARM_TYPE_; // default human

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
			///*OPTIONAL*/ //this.tongue.type = TONGUE_; // default HUMAN
			///*OPTIONAL*/ //this.eyes.type = EYES_; // default HUMAN

			//// 9. Primary stats.
			///*REQUIRED*/ initStrTouSpeInte(,,,);
			///*REQUIRED*/ initWisLibSensCor(,,);

			//// 10. Weapon
			///*REQUIRED*/ this.weaponName = "weaponName";
			///*REQUIRED*/ this.weaponVerb = "weaponVerb";
			///*OPTIONAL*/ //this.weaponAttack = ; // default 0
			///*OPTIONAL*/ //this.weaponPerk = "weaponPerk"; // default ""
			///*OPTIONAL*/ //this.weaponValue = ; // default 0

			//// 11. Armor
			///*REQUIRED*/ this.armorName = "armorName";
			///*OPTIONAL*/ //this.armorDef = ; // default 0
			///*OPTIONAL*/ //this.armorMDef = ; // default 0
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
			///*OPTIONAL*/ //this.horns.type = HORNS_; // default NONE
			///*OPTIONAL*/ //this.horns = numberOfHorns; // default 0

			//// 18. Wings
			///*OPTIONAL*/ //this.wings.type = WING_TYPE_; // default NONE
			///*OPTIONAL*/ //this.wings.desc = ; // default Appearance.DEFAULT_WING_DESCS[wings.type]

			//// 19. Antennae
			///*OPTIONAL*/ //this.antennae.type = ANTENNAE_; // default NONE

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
			wis_lib_sens_cor:false,
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
		protected function set initedWisLibSensCor(value:Boolean):void{
			initsCalled.wis_lib_sens_cor = value;
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
			this.strStat.core.value = str;
			this.touStat.core.value = tou;
			this.speStat.core.value = spe;
			this.intStat.core.value = inte;

			initedStrTouSpeInte = true;
		}

		protected function initWisLibSensCor(wis:Number, lib:Number, sens:Number, cor:Number):void
		{
			this.wisStat.core.value = wis;
			this.libStat.core.value = lib;
			sensStat.redefine({base:sens});
			this.cor = cor;
			initedWisLibSensCor = true;
		}

		override public function validate():String
		{
			var error:String = "";
			// 1. Required fields must be set
			if (!isFullyInit()) {
				error += "Missing phases: "+missingInits()+". ";
			}
			this.HP = maxHP();
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
			if(this.wings.type != Wings.NONE && this.wings.desc == "non-existant"){
				this.wings.desc = Appearance.DEFAULT_WING_DESCS[this.wings.type]
			}
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
			if (hasStatusEffect(StatusEffects.FlameBlade)) {
				var damageF:int = calcFireDamage();
				if (damageF > 0) player.takeFireDamage(damageF);
			}
			else {
				var damage:int = calcDamage();
				if (damage > 0) player.takePhysDamage(damage);
			}
			return damage;
		}

		/**
		 * return true if we land a hit
		 */
		protected function attackSucceeded():Boolean
		{
			var attack:Boolean = true;
			if (hasStatusEffect(StatusEffects.LoweredAccuracy)) {
				attack &&= handleBlind();
			}
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
					EngineCore.statScreenRefresh();
					outputText("\n");
				}
				if (statusEffectv1(StatusEffects.Attacks) >= 0) {
					addStatusValue(StatusEffects.Attacks, 1, -1);
				}
				attacks--;
			}
			removeStatusEffect(StatusEffects.Attacks);
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
				//Due to toughness or armor...
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
			if (hasStatusEffect(StatusEffects.LoweredAccuracy) && rand(100) < statusEffectv1(StatusEffects.LoweredAccuracy)) {
				if (weaponVerb == "tongue-slap") outputText(capitalA + short + " completely misses you with a thrust from "+pronoun3+" tongue!\n");
				else outputText(capitalA + short + " completely misses you with an attack!\n");
				return false;
			}
			else if (rand(3) < 2) {
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
			//Zenji parry enemy attack
			if (player.hasStatusEffect(StatusEffects.CombatFollowerZenji)) {
				var parryChance:Number = 25;
				if (player.statusEffectv4(StatusEffects.CombatFollowerZenji) > 1) parryChance += 15;
				if (rand(100) > parryChance) {
					outputText("" + capitalA + short + " goes in for a strike, but Zenji is able to intervene, blocking any opening they have on you, leaving you safe behind him.\n\n");
					outputText("\"<i>You’re gonna have ta try harda dan dat!</i>\" Zenji shouts.");
					return true;
				}
			}
			//Parry with weapon
			if (combatParry()) {
				outputText("You manage to block " + a + short + "");
				if (plural) outputText("' attacks ");
				else outputText("'s attack ");
				outputText("with your [weapon].\n");
				if (game.player.hasPerk(PerkLib.TwinRiposte) && (game.player.weaponPerk == "Dual" || game.player.weaponPerk == "Dual Large") && game.player.wrath >= 2) {
					player.createStatusEffect(StatusEffects.CounterAction,1,0,0,0);
					SceneLib.combat.basemeleeattacks();
				}
				if (game.player.hasPerk(PerkLib.Backlash) && game.player.isFistOrFistWeapon()) {
					player.createStatusEffect(StatusEffects.CounterAction,1,0,0,0);
					outputText("As you block the blow you exploit the opening in your opponent’s guard to deliver a vicious kick.");
					SceneLib.combat.basemeleeattacks();
				}
				return true;
			}
			//Block with shield
			if (combatBlock(true)) {
				outputText("You block " + a + short + "'s " + weaponVerb + " with your [shield]! ");
				if (game.player.hasPerk(PerkLib.ShieldCombat) && game.player.fatigue >= 20) {
					player.createStatusEffect(StatusEffects.CounterAction,1,0,0,0);
					SceneLib.combat.pspecials.shieldBash();
				}
				SceneLib.combat.ShieldsStatusProcs();
				return true;
			}
			return false;
		}

		public function monsterIsStunned():Boolean {
			if (hasStatusEffect(StatusEffects.Stunned) || hasStatusEffect(StatusEffects.FrozenSolid) || hasStatusEffect(StatusEffects.StunnedTornado) || hasStatusEffect(StatusEffects.Polymorphed) || hasStatusEffect(StatusEffects.HypnosisNaga) || hasStatusEffect(StatusEffects.Sleep) || hasStatusEffect(StatusEffects.InvisibleOrStealth) || hasStatusEffect(StatusEffects.Fascinated)) return true;
			return false;
		}

		public function doAI():void
		{
			if (hasStatusEffect(StatusEffects.AbilityCooldown1) ) {
				if (statusEffectv1(StatusEffects.AbilityCooldown1) <= 0) {
					removeStatusEffect(StatusEffects.AbilityCooldown1);
				}
				else {
					addStatusValue(StatusEffects.AbilityCooldown1,1,-1);
				}
			}
			if (hasStatusEffect(StatusEffects.AbilityCooldown2) ) {
				if (statusEffectv1(StatusEffects.AbilityCooldown2) <= 0) {
					removeStatusEffect(StatusEffects.AbilityCooldown2);
				}
				else {
					addStatusValue(StatusEffects.AbilityCooldown2,1,-1);
				}
			}
			if (hasStatusEffect(StatusEffects.AbilityCooldown3) ) {
				if (statusEffectv1(StatusEffects.AbilityCooldown3) <= 0) {
					removeStatusEffect(StatusEffects.AbilityCooldown3);
				}
				else {
					addStatusValue(StatusEffects.AbilityCooldown3,1,-1);
				}
			}
			if (hasStatusEffect(StatusEffects.AbilityCooldown4) ) {
				if (statusEffectv1(StatusEffects.AbilityCooldown4) <= 0) {
					removeStatusEffect(StatusEffects.AbilityCooldown4);
				}
				else {
					addStatusValue(StatusEffects.AbilityCooldown4,1,-1);
				}
			}
			if (hasStatusEffect(StatusEffects.Lustzerking)) {
				this.wrath += 5;
				if (statusEffectv1(StatusEffects.Lustzerking) > 1) addStatusValue(StatusEffects.Lustzerking, 1, -1);
				else {
					weaponAttack -= statusEffectv2(StatusEffects.Lustzerking);
					removeStatusEffect(StatusEffects.Lustzerking);
				}
			}
			if (monsterIsStunned()) {
				if (!handleStun()) return;
			}
			if (hasStatusEffect(StatusEffects.Fear)) {
				if (this is Marae) {
					outputText("\n\n\"<i>You think I'm afraid of anything? Foolish mortal.</i>\" Marae snarls.");
					this.speStat.core.value += statusEffectv2(StatusEffects.Fear);
					removeStatusEffect(StatusEffects.Fear);
				}
				else {
					if (!handleFear()) return;
				}
			}
			//Exgartuan gets to do stuff!
			if (game.player.hasStatusEffect(StatusEffects.Exgartuan) && game.player.statusEffectv2(StatusEffects.Exgartuan) == 0 && rand(3) == 0) {
				if (SceneLib.exgartuan.exgartuanCombatUpdate()) EngineCore.outputText("\n\n");
			}
			if (player.hasPerk(PerkLib.DarkenedKitsune)>0) {//&& rand(4) ==0){
				if (SceneLib.darkenedKitsuneScene.darkKitsuneCombat()) EngineCore.outputText("\n\n")
			}
			if (hasStatusEffect(StatusEffects.Constricted) || hasStatusEffect(StatusEffects.ConstrictedScylla) || hasStatusEffect(StatusEffects.GooEngulf) || hasStatusEffect(StatusEffects.EmbraceVampire) || hasStatusEffect(StatusEffects.Pounce) || hasStatusEffect(StatusEffects.GrabBear) || hasStatusEffect(StatusEffects.CancerGrab) || hasStatusEffect(StatusEffects.ManticorePlug) || hasStatusEffect(StatusEffects.MysticWeb)) {
				if (!handleConstricted()) return;
			}
			if (hasStatusEffect(StatusEffects.OrcaPlay)) {
				return;
			}
			if (hasStatusEffect(StatusEffects.Straddle)) {
				return;
			}
			if (hasStatusEffect(StatusEffects.Provoke)) {
				addStatusValue(StatusEffects.Provoke, 1, -1);
				if (!hasPerk(PerkLib.EnemyConstructType) && !hasPerk(PerkLib.EnemyFleshConstructType)) {
					if (statusEffectv1(StatusEffects.Provoke) <= 0) armorDef += statusEffectv3(StatusEffects.Provoke);
					eAttack();
					return;
				}
			}
			if (hasStatusEffect(StatusEffects.Dig)) {
				outputText("\n\nYour opponent is still looking for you as you remain quietly hiding underground, away from view.");
				addStatusValue(StatusEffects.Dig, 1, -1);
				return;
			}
			if (hasStatusEffect(StatusEffects.OrcaHasWackedFinish)) {
				outputText("\n\nYour opponent is still stunned from the powerful blow of your tail.");
				createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
				return;
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
			if (hasStatusEffect(StatusEffects.MysticWeb)) {
				EngineCore.outputText("" + capitalA + short + " struggle to get free from your web!");
				if (statusEffectv1(StatusEffects.MysticWeb) <= 0) {
					EngineCore.outputText("" + capitalA + short + " struggle to get free and manage to shove you break off your webbing.");
					removeStatusEffect(StatusEffects.MysticWeb);
				}
				addStatusValue(StatusEffects.MysticWeb, 1, -1);
				return false;
			}
			if (hasStatusEffect(StatusEffects.Pounce)) {
				EngineCore.outputText("" + capitalA + short + " struggle to get free.");
				if (statusEffectv1(StatusEffects.Pounce) <= 0) {
					EngineCore.outputText("" + capitalA + short + " struggle to get free and manage to shove you off.");
					removeStatusEffect(StatusEffects.Pounce);
				}
				addStatusValue(StatusEffects.Pounce, 1, -1);
				return false;
			}
			if (hasStatusEffect(StatusEffects.ManticorePlug)) {
				EngineCore.outputText("" + capitalA + short + " pulls to unplug your tail from [monster his] "+cockDescriptShort()+".");
				if (statusEffectv1(StatusEffects.ManticorePlug) <= 0) {
					EngineCore.outputText("" + capitalA + short +" pulls to unplug your tail from [monster his] "+cockDescriptShort()+" and manages with great efforts to get it off.");
					if (statusEffectv3(StatusEffects.ManticorePlug) >= 1) {
						EngineCore.outputText("You lick your paws in delight still feeling the remains of your recent meal in your tail.");
					} else {
						EngineCore.outputText("You growl in annoyance at your denied meal.");
					}
					createStatusEffect(StatusEffects.Straddle, statusEffectv2(StatusEffects.ManticorePlug),0,0,0);
					removeStatusEffect(StatusEffects.ManticorePlug);
				}
				addStatusValue(StatusEffects.ManticorePlug, 1, -1);
				return false;
			}
			if (hasStatusEffect(StatusEffects.DisplacerPlug)) {
				EngineCore.outputText("" + capitalA + short + " struggle to unplug your tentacles suckers.");
				if (statusEffectv1(StatusEffects.DisplacerPlug) <= 0) {
					EngineCore.outputText("" + capitalA + short +" struggle to unplug your tentacles suckers from [monster his] "+breastDescript(0)+" and manages with great efforts to get them off.");
					if (statusEffectv3(StatusEffects.DisplacerPlug) >= 1) {
						EngineCore.outputText("You lick your paws in delight still feeling the remains of the recent milk flow in your tentacles.");
					} else {
						EngineCore.outputText("You growl in annoyance at your denied meal.");
					}
					createStatusEffect(StatusEffects.Straddle, statusEffectv2(StatusEffects.DisplacerPlug),0,0,0);
					removeStatusEffect(StatusEffects.DisplacerPlug);
				}
				addStatusValue(StatusEffects.DisplacerPlug, 1, -1);
				return false;
			}
			if (hasStatusEffect(StatusEffects.SlimeInsert)) {
				EngineCore.outputText("" + capitalA + short + " struggle to force you out of [monster his] body.");
				if (statusEffectv1(StatusEffects.SlimeInsert) <= 0) {
					EngineCore.outputText("" + capitalA + short +" struggle to force you out of [monster his] body.");
					if (statusEffectv3(StatusEffects.SlimeInsert) >= 1) {
						EngineCore.outputText("You drool in pleasure, your opponent fluids still floating within your body.");
					} else {
						EngineCore.outputText("You sigh in frustration as you couldn't extract anything from your unwilling partner.");
					}
					createStatusEffect(StatusEffects.Straddle, statusEffectv2(StatusEffects.SlimeInsert),0,0,0);
					removeStatusEffect(StatusEffects.SlimeInsert);
				}
				addStatusValue(StatusEffects.SlimeInsert, 1, -1);
				return false;
			}
			else if (player.lowerBody == LowerBody.SCYLLA || player.lowerBody == LowerBody.KRAKEN) {
			EngineCore.outputText("Your prey pushes at your tentacles, twisting and writhing in an effort to escape from your tentacle's tight bonds.");
			if (statusEffectv1(StatusEffects.ConstrictedScylla) <= 0) {
				EngineCore.outputText("  " + capitalA + short + " proves to be too much for your tentacles to handle, breaking free of your tightly bound coils.");
				removeStatusEffect(StatusEffects.ConstrictedScylla);
			}
			addStatusValue(StatusEffects.ConstrictedScylla, 1, -1);
			return false;
			}
			else if (player.lowerBody == LowerBody.CANCER) {
				EngineCore.outputText("Your prey pushes at your pincer, twisting and writhing in an effort to escape from your iron grip.");
				if (statusEffectv1(StatusEffects.CancerGrab) <= 0) {
					EngineCore.outputText("  " + capitalA + short + " proves to be too much for your pincer to handle, breaking free of your iron grip.");
					removeStatusEffect(StatusEffects.CancerGrab);
				}
				addStatusValue(StatusEffects.CancerGrab, 1, -1);
				return false;
			}
			else if (player.lowerBody == LowerBody.GOO) {
			EngineCore.outputText("" + capitalA + short + " struggle in your fluid form kicking and screaming to try and get out.");
			if (statusEffectv1(StatusEffects.GooEngulf) <= 0) {
				EngineCore.outputText("  " + capitalA + short + " proves to be too much for your slimy body to handle, breaking free of your fluids.");
				removeStatusEffect(StatusEffects.GooEngulf);
			}
			addStatusValue(StatusEffects.GooEngulf, 1, -1);
			return false;
			}
			else if (hasStatusEffect(StatusEffects.EmbraceVampire)) {
			if (statusEffectv1(StatusEffects.EmbraceVampire) <= 0) {
				EngineCore.outputText("You try to maintain your grip but " + a + short + " shove you off escaping your embrace!");
				removeStatusEffect(StatusEffects.EmbraceVampire);
			}
			else EngineCore.outputText("" + capitalA + short + " struggle but you manage to maintain the embrace.");
			addStatusValue(StatusEffects.EmbraceVampire, 1, -1);
			return false;
			}
			else if (hasStatusEffect(StatusEffects.GrabBear)) {
			if (statusEffectv1(StatusEffects.GrabBear) <= 0) {
				EngineCore.outputText("You try to maintain your grip but " + a + short + " shove you off escaping your grab!");
				removeStatusEffect(StatusEffects.GrabBear);
			}
			else EngineCore.outputText("" + capitalA + short + " struggle but you manage to maintain the grab.");
			addStatusValue(StatusEffects.GrabBear, 1, -1);
			return false;
			}
			else {
			EngineCore.outputText("Your prey pushes at your tail, twisting and writhing in an effort to escape from your tail's tight bonds.");
			if (statusEffectv1(StatusEffects.Constricted) <= 0) {
				EngineCore.outputText("  " + capitalA + short + " proves to be too much for your tail to handle, breaking free of your tightly bound coils.");
				removeStatusEffect(StatusEffects.Constricted);
			}
			addStatusValue(StatusEffects.Constricted, 1, -1);
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
					this.speStat.core.value += statusEffectv2(StatusEffects.Fear);
					removeStatusEffect(StatusEffects.Fear);
					EngineCore.outputText("Your foes shake free of their fear and ready themselves for battle.");
				}
				else {
					this.speStat.core.value += statusEffectv2(StatusEffects.Fear);
					removeStatusEffect(StatusEffects.Fear);
					EngineCore.outputText("Your foe shakes free of its fear and readies itself for battle.");
				}
			}
			else {
				addStatusValue(StatusEffects.Fear, 1, -1);
				if (plural) EngineCore.outputText(capitalA + short + " are too busy shivering with fear to fight.");
				else EngineCore.outputText(capitalA + short + " is too busy shivering with fear to fight.");
			}
			return false;
		}

		/**
		 * Called if monster is stunned. Should return true if stun is ignored and need to proceed with ai.
		 */

		protected function handleStun():Boolean
		{
			interruptAbility();
			if (statusEffectv1(StatusEffects.Stunned) <= 0) removeStatusEffect(StatusEffects.Stunned);
			else addStatusValue(StatusEffects.Stunned, 1, -1);
			if (hasPerk(PerkLib.EnemyResiliance)) addStatusValue(StatusEffects.Stunned,1,-5);
			if (statusEffectv1(StatusEffects.StunnedTornado) <= 0) removeStatusEffect(StatusEffects.StunnedTornado);
			else {
				EngineCore.outputText(capitalA + short + " is still caught in the tornado.");
				addStatusValue(StatusEffects.StunnedTornado, 1, -1);
				if (hasPerk(PerkLib.EnemyResiliance)) addStatusValue(StatusEffects.StunnedTornado,1,-5);
			}
			if (hasStatusEffect(StatusEffects.InkBlind)) {
				if (plural) EngineCore.outputText("Your foes are busy trying to remove the ink and therefore does no other action than flay their hand about its faces.");
				else EngineCore.outputText("Your foe is busy trying to remove the ink and therefore does no other action than flay its hand about its face.");
			}
			if (hasStatusEffect(StatusEffects.Fascinated)) {
				if (plural) EngineCore.outputText("Your opponents stares emptily in the space in front of [monster him] a dreamy expression on [monster his] face, totally entranced. A brief moment later [monster he] realises [monster he]'s been doing nothing for the past few seconds and snaps out of it.");
				else EngineCore.outputText("Your opponent stares emptily in the space in front of [monster him] a dreamy expression on [monster his] face, totally entranced. A brief moment later [monster he] realises [monster he]'s been doing nothing for the past few seconds and snaps out of it.");
				removeStatusEffect(StatusEffects.Fascinated);
			}
			else if (hasStatusEffect(StatusEffects.FrozenSolid)) {
				if (plural) EngineCore.outputText("Your foes are too busy trying to break out of their icy prison to fight back.");
				else EngineCore.outputText("Your foe is too busy trying to break out of his icy prison to fight back.");
			}
			else if (hasStatusEffect(StatusEffects.Sleep)) {
				if (plural) EngineCore.outputText("Your foes are fast asleep.");
				else EngineCore.outputText("Your foe is fast asleep.");
			}
			else if (hasStatusEffect(StatusEffects.InvisibleOrStealth)) {
				if (plural) EngineCore.outputText("Your foes are still looking for you, swearing in annoyance.");
				else EngineCore.outputText("Your foe is still looking for you, swearing in annoyance.");
			}
			else if (hasStatusEffect(StatusEffects.Polymorphed)) EngineCore.outputText(capitalA + short + " is fighting against the curse.");
			else if (hasStatusEffect(StatusEffects.MonsterAttacksDisabled)) EngineCore.outputText(capitalA + short + " try to hit you but is unable to reach you!");
			else {
				if (plural) EngineCore.outputText("Your foes are too dazed from your last hit to strike back!");
				else {
					EngineCore.outputText("Your foe is too dazed from your last hit to strike back!");
					if (hasStatusEffect(StatusEffects.Uber) && this is Marae) {
						EngineCore.outputText(" You've managed to interrupt her smite attack!");
						removeStatusEffect(StatusEffects.Uber);
					}
				}
			}
			return false;
		}

		/**
		 * This method is called after a stun interupted an ability.
		 * Default: Does nothing this is monster specific
		 */
		public function interruptAbility():void {
			// Generic monster does nothing (has no channelable abilities)
		}



		/**
		 * When monster cannot use any attack or ability
		 */
		protected function doNothing(useDefaultText:Boolean = true, customText:String = ""):void {
			if (useDefaultText)
			{
				outputText("Unable to do anything [monster a] [monster name] takes a defensive stance ready to prepare for your attacks");
				if (EngineCore.silly()) outputText(" screaming [race]phobic insults");
				outputText(".");
			}
			else outputText(""+customText+"");
		}

		/**
		 * This method is called after all stun/fear/constricted checks.
		 * Default: Equal chance to do physical or special (if any) attack
		 */
		protected function performCombatAction():void
		{
			if (!abilities) {
				// Old monster, has no tagged abilities configured
				abilities = [
					{call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[]},
					{call: special1, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[]},
					{call: special2, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[]},
					{call: special3, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[]}
				]
			}
			var roll:Object = pickRandomAbility(abilities, player);
			if (!roll) {
				doNothing();
				return;
			}
			roll.call();
		}

		/**
		 * All branches of this method and all subsequent scenes should end either with
         * 'cleanupAfterCombat', 'awardPlayer' or 'finishCombat'. The latter also displays
		 * default message like "you defeat %s" or "%s falls and starts masturbating"
		 */
		public function defeated(hpVictory:Boolean):void
		{
			SceneLib.combat.finishCombat();
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
            game.player.clearStatuses(false);
            var temp:Number = rand(10) + 1;
			if(temp > player.gems) temp = player.gems;
			outputText("\n\nYou'll probably wake up in eight hours or so, missing " + temp + " gems.");
			player.gems -= temp;
			EngineCore.doNext(SceneLib.camp.returnToCampUseEightHours);
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
			if (onDefeated != null) onDefeated(hpVictory);
			else defeated(hpVictory);
		}

		/**
		 * Final method to handle hooks before calling overriden method
		 */
		public final function won_(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (onWon != null) onWon(hpVictory,pcCameWorms);
			else won(hpVictory,pcCameWorms);
		}

		/**
		 * Display tease reaction message. Then call applyTease() to increase lust.
		 * @param lustDelta value to be added to lust (already modified by lustVuln etc)
		 */
		public function teased(lustDelta:Number, isNotSilent:Boolean = true):void
		{
			if(isNotSilent)
			{
				outputDefaultTeaseReaction(lustDelta);
			}
			if (lustDelta > 0) {
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
			if (hasStatusEffect(StatusEffects.BerzerkingSiegweird)) lustDelta *= 0.5;
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
			result += Heis + Appearance.inchesAndFeetsAndInches(tallness) + " tall with " +
			          Appearance.describeByScale(hips.type,Appearance.DEFAULT_HIP_RATING_SCALES,"thinner than","wider than") + " hips and " +
			          Appearance.describeByScale(butt.type,Appearance.DEFAULT_BUTT_RATING_SCALES,"thinner than","wider than") + " butt.\n";
			result += Pronoun3+" lower body is "+Object(LowerBody.Types[lowerBody]||{}).name;
			result += ", "+pronoun3+" arms are "+Object(Arms.Types[arms.type]||{}).name;
			result += ", "+pronoun1+" "+have+" "+skinTone+" "+skinAdj+" "+skinDesc+
					  " (base "+Object(Skin.SkinTypes[skin.baseType()]||{}).id+")." +
					  " (coat "+Object(Skin.SkinTypes[skin.coatType()]||{}).id+")." +
					  "\n";
			result += Hehas;
			if (hairLength>0){
				result += hairColor+" "+Appearance.inchesAndFeetsAndInches(hairLength)+" long "+Object(Hair.Types[hairType]||{}).name+" hair.\n";
			} else {
				result += "no hair.\n";
			}
			result += Hehas;
			if (beardLength>0){
				result += hairColor+" "+Appearance.inchesAndFeetsAndInches(beardLength)+" long "+Object(Beard.Types[beardStyle]||{}).name+" beard.\n";
			} else {
				result += "no beard.\n";
			}
			result += Hehas
			          + Object(Face.Types[faceType]||{}).name + " face, "
			          + Object(Ears.Types[ears.type]||{}).name + " ears, "
			          + Object(Tongue.Types[tongue.type]||{}).name + " tongue and "
			          + Object(Eyes.Types[eyes.type]||{}).name + " eyes.\n";
			result += Hehas;
			if (tailType == Tail.NONE) result += "no tail, ";
			else result+=Object(Tail.Types[tailType]||{}).name+" "+tailCount+" tails with venom="+tailVenom+" and recharge="+tailRecharge+", ";
			if (horns.type == Horns.NONE) result += "no horns, ";
			else result += horns.count + " " + Object(Horns.Types[horns.type]||{}).name + " horns, ";
			if (wings.type == Wings.NONE) result += "no wings, ";
			else result += wings.desc + " wings (type " + Object(Wings.Types[wings.type]||{}).name + "), ";
			if (antennae.type == Antennae.NONE) result += "no antennae.type.\n\n";
			else result += Object(Antennae.Types[antennae.type]||{}).name + " antennae.type.\n\n";

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
			result += Hehas + "str=" + str + ", tou=" + tou + ", spe=" + spe +", inte=" + inte +", wis=" + wis +", lib=" + lib + ", sens=" + sens + ", cor=" + cor + ".\n";
			result += Pronoun1 + " can " + weaponVerb + " you with  " + weaponPerk + " " + weaponName+" (attack " + weaponAttack + ", value " + weaponValue+").\n";
			result += Pronoun1 + " is guarded with " + armorPerk + " " + armorName+" (phys defense " + armorDef + ", mag defense " + armorMDef + ", value " + armorValue+").\n";
			result += Hehas + HP + "/" + maxHP() + " HP, " + lust + "/" + maxLust() + " lust, " + fatigue + "/" + maxFatigue() + " fatigue, " + wrath + "/" + maxWrath() + " wrath, " + soulforce + "/" + maxSoulforce() + " soulforce, " + mana + "/" + maxMana() + " mana. ";
			result += Pronoun3 + " bonus HP=" + bonusHP + ", bonus lust=" + bonusLust + ", bonus wrath=" + bonusWrath + ", bonus mana=" + bonusMana + ", bonus soulforce=" + bonusSoulforce + ", and lust vulnerability=" + lustVuln + ".\n"
			result += Heis + "level " + level + " and " + have+" " + gems + " gems. You will be awarded " + XP + " XP.\n";

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
			EngineCore.clearOutput();
		}

		public function dropLoot():ItemType
		{
			return _drop.roll() as ItemType;
		}

		public function isNightTime():Boolean{
			return (CoC.instance.model.time.hours <= 5 || CoC.instance.model.time.hours >= 21);
		}

		public function combatRoundUpdate():void
		{

			//regeneration perks for monsters
			if (((hasPerk(PerkLib.Regeneration) || hasPerk(PerkLib.LizanRegeneration) || hasPerk(PerkLib.LizanMarrow) || hasPerk(PerkLib.LizanMarrowEvolved) || hasPerk(PerkLib.LizanMarrowFinalForm) || hasPerk(PerkLib.DraconicHeartFinalForm) || hasPerk(PerkLib.EnemyPlantType) || hasPerk(PerkLib.BodyCultivator) || hasPerk(PerkLib.MonsterRegeneration)
			|| hasPerk(PerkLib.HydraRegeneration) || hasPerk(PerkLib.Lifeline) || hasPerk(PerkLib.ImprovedLifeline) || hasPerk(PerkLib.GreaterLifeline) || hasPerk(PerkLib.EpicLifeline) || hasPerk(PerkLib.IcyFlesh) || hasPerk(PerkLib.HclassHeavenTribulationSurvivor) || hasPerk(PerkLib.GclassHeavenTribulationSurvivor)
			|| hasPerk(PerkLib.FclassHeavenTribulationSurvivor) || hasPerk(PerkLib.EclassHeavenTribulationSurvivor) || hasStatusEffect(StatusEffects.MonsterRegen) || hasStatusEffect(StatusEffects.MonsterRegen2)) && this.HP < maxHP()) || (hasStatusEffect(StatusEffects.MonsterVPT) && (this.HP < maxOverHP()) && (this.HP > minHP()))) {
				var healingPercent:Number = 0;
				var temp2:Number = 0;
				if (hasPerk(PerkLib.Regeneration)) healingPercent += (0.5 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.IceQueenGown) && player.yukiOnnaScore() >= 14) healingPercent += 5;
				if (hasPerk(PerkLib.VladimirRegalia) && !isNightTime()) healingPercent -= 5;
				if (hasPerk(PerkLib.VladimirRegalia) && isNightTime()) healingPercent += 5;
				if (hasPerk(PerkLib.LizanRegeneration) && !hasStatusEffect(StatusEffects.RegenInhibitor)) healingPercent += 1.5;
				if (hasPerk(PerkLib.LizanMarrow) && !hasStatusEffect(StatusEffects.RegenInhibitor)) healingPercent += 0.5;
				if (hasPerk(PerkLib.LizanMarrowEvolved) && !hasStatusEffect(StatusEffects.RegenInhibitor)) healingPercent += 1;
				if (hasPerk(PerkLib.LizanMarrowFinalForm) && !hasStatusEffect(StatusEffects.RegenInhibitor)) {
					healingPercent += 1.5;
					if (this.HP < (this.maxHP() * 0.25)) healingPercent += 4.5;
				}
				if (hasPerk(PerkLib.DraconicHeartFinalForm)) healingPercent += 1;
				if (hasPerk(PerkLib.HydraRegeneration) && !hasStatusEffect(StatusEffects.HydraRegenerationDisabled)) healingPercent += 1 * perkv1(PerkLib.HydraRegeneration);
				if (hasPerk(PerkLib.IcyFlesh)) healingPercent += 1;
				if (hasPerk(PerkLib.BodyCultivator)) healingPercent += 0.5;
				if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) healingPercent += 0.5;
				if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) healingPercent += 0.5;
				if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) healingPercent += 0.5;
				if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) healingPercent += 0.5;
				if (hasPerk(PerkLib.Ferocity) && this.HP < 1) healingPercent -= 1;
				if (hasPerk(PerkLib.EnemyPlantType)) healingPercent += 1;
				if (hasPerk(PerkLib.MonsterRegeneration) && !hasStatusEffect(StatusEffects.RegenInhibitor)) healingPercent += perkv1(PerkLib.MonsterRegeneration);
				if (hasStatusEffect(StatusEffects.MonsterRegen)) healingPercent += statusEffectv2(StatusEffects.MonsterRegen);
				if (hasPerk(PerkLib.Diehard) && !hasPerk(PerkLib.EpicDiehard) && this.HP < 1) healingPercent -= 1;
				if (hasPerk(PerkLib.LizanMarrowFinalForm) && this.HP < 1) healingPercent -= 1;
				temp2 = Math.round(maxHP() * healingPercent / 100);
				if (hasPerk(PerkLib.Lifeline)) temp2 += (45 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.ImprovedLifeline)) temp2 += (60 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.GreaterLifeline)) temp2 += (90 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.EpicLifeline)) temp2 += (120 * (1 + newGamePlusMod()));
				if (hasStatusEffect(StatusEffects.MonsterRegen2)) temp2 += statusEffectv2(StatusEffects.MonsterRegen2);
				if (hasStatusEffect(StatusEffects.MonsterVPT)) temp2 += statusEffectv1(StatusEffects.MonsterVPT);
				if (temp2 > 0) {
					temp2 = Math.round(temp2);
					if (this is ChiChi && (flags[kFLAGS.CHI_CHI_SAM_TRAINING] < 2 || hasStatusEffect(StatusEffects.MonsterRegen))) {
						outputText("To your surprise, Chi Chi’s wounds start closing! <b>(<font color=\"#008000\">+" + temp2 + "</font>)</b>.\n\n");
					}
					else {
						outputText("Due to natural regeneration " + short + " recover");
						if (plural) outputText("s");
						else outputText("ed");
						outputText(" some HP! <b>(<font color=\"#008000\">+" + temp2 + "</font>)</b>.\n\n");
					}
					addHP(temp2);
				}
			}
			//soulforce and mana regeneration for monsters
			if (hasPerk(PerkLib.JobSoulCultivator) && this.soulforce < maxSoulforce()) {
				var soulforceRecovery:Number = 0;
				var soulforceRecoveryMulti:Number = 1;
				if (hasPerk(PerkLib.JobSoulCultivator)) soulforceRecovery += 4;
				if (hasPerk(PerkLib.SoulApprentice)) soulforceRecovery += 2;
				if (hasPerk(PerkLib.SoulPersonage)) soulforceRecovery += 2;
				if (hasPerk(PerkLib.SoulWarrior)) soulforceRecovery += 2;
				if (hasPerk(PerkLib.SoulSprite)) soulforceRecovery += 3;
				if (hasPerk(PerkLib.SoulScholar)) soulforceRecovery += 3;
				if (hasPerk(PerkLib.SoulElder)) soulforceRecovery += 3;
				if (hasPerk(PerkLib.SoulExalt)) soulforceRecovery += 4;
				if (hasPerk(PerkLib.SoulOverlord)) soulforceRecovery += 4;
				if (hasPerk(PerkLib.SoulTyrant)) soulforceRecovery += 4;
				if (hasPerk(PerkLib.SoulKing)) soulforceRecovery += 5;
				if (hasPerk(PerkLib.SoulEmperor)) soulforceRecovery += 5;
				if (hasPerk(PerkLib.SoulAncestor)) soulforceRecovery += 5;
				if (hasPerk(PerkLib.DaoistCultivator)) soulforceRecoveryMulti += 0.5;
				if (hasPerk(PerkLib.DraconicHeart)) manaRecovery += 4;
				if (hasPerk(PerkLib.DraconicHeartEvolved)) manaRecovery += 4;
				if (hasPerk(PerkLib.DraconicHeartFinalForm)) manaRecovery += 4;
				soulforceRecovery *= soulforceRecoveryMulti;
				addSoulforce(soulforceRecovery);
			}
			if (hasPerk(PerkLib.JobSorcerer) && this.mana < maxMana()) {
				var manaRecovery:Number = 0;
				var manaRecoveryMulti:Number = 1;
				if (hasPerk(PerkLib.JobSorcerer)) manaRecovery += 10;
				if (hasPerk(PerkLib.ArcaneRegenerationMinor)) manaRecovery += 10;
				if (hasPerk(PerkLib.ArcaneRegenerationMajor)) manaRecovery += 20;
				if (hasPerk(PerkLib.ArcaneRegenerationEpic)) manaRecovery += 30;
				if (hasPerk(PerkLib.ArcaneRegenerationLegendary)) manaRecovery += 40;
				if (hasPerk(PerkLib.ArcaneRegenerationMythical)) manaRecovery += 50;
				if (hasPerk(PerkLib.DraconicHeart)) manaRecovery += 5;
				if (hasPerk(PerkLib.DraconicHeartEvolved)) manaRecovery += 5;
				if (hasPerk(PerkLib.DraconicHeartFinalForm)) manaRecovery += 5;
				if (hasPerk(PerkLib.WarMageApprentice)) manaRecovery += 10;
				if (hasPerk(PerkLib.WarMageAdept)) manaRecovery += 15;
				if (hasPerk(PerkLib.GreyMage)) manaRecoveryMulti += 0.5;
				if (hasPerk(PerkLib.GreyArchmage)) manaRecoveryMulti += 1.5;
				if (hasPerk(PerkLib.ManaAffinityI)) manaRecoveryMulti += (0.2 * (1 + newGamePlusMod()));
				manaRecovery *= manaRecoveryMulti;
				addMana(manaRecovery);
			}

			if(hasStatusEffect(StatusEffects.MilkyUrta)) {
				SceneLib.urtaQuest.milkyUrtaTic();
			}
			if(hasStatusEffect(StatusEffects.UrtaSecondWinded)) {
				addStatusValue(StatusEffects.UrtaSecondWinded,1,-1);
				if(statusEffectv1(StatusEffects.UrtaSecondWinded) <= 0) removeStatusEffect(StatusEffects.UrtaSecondWinded);
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
				if (hasPerk(PerkLib.EnemyResiliance)) addStatusValue(StatusEffects.InkBlind,1,-5);
				if(statusEffectv1(StatusEffects.InkBlind) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer blind!</b>\n\n");
					removeStatusEffect(StatusEffects.InkBlind);
				}
				else outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " currently blind!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.LoweredAccuracy)) {
				addStatusValue(StatusEffects.LoweredAccuracy,1,-1);
				if(statusEffectv1(StatusEffects.LoweredAccuracy) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer having lowered accuracy!</b>\n\n");
					removeStatusEffect(StatusEffects.LoweredAccuracy);
				}
			}
			if(hasStatusEffect(StatusEffects.FrozenSolid)) {
				addStatusValue(StatusEffects.FrozenSolid,1,-1);
				if (hasPerk(PerkLib.EnemyResiliance)) addStatusValue(StatusEffects.FrozenSolid,1,-5);
				if(statusEffectv1(StatusEffects.FrozenSolid) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer encased in the ice prison!</b>\n\n");
					removeStatusEffect(StatusEffects.FrozenSolid);
				}
				else outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " currently encased in the ice prison!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.Polymorphed)) {
				addStatusValue(StatusEffects.Polymorphed,1,-1);
				if (hasPerk(PerkLib.EnemyResiliance)) addStatusValue(StatusEffects.Polymorphed,1,-5);
				if(statusEffectv1(StatusEffects.Polymorphed) <= 0) {
					outputText("<b>" + capitalA + short + " has freed " + pronoun2 + "self from the curse!</b>\n\n");
					removeStatusEffect(StatusEffects.Polymorphed);
				}
				else outputText("<b>" + capitalA + short + " is fighting against the curse.</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.Sleep)) {
				addStatusValue(StatusEffects.Sleep,1,-1);
				if (hasPerk(PerkLib.EnemyResiliance)) addStatusValue(StatusEffects.Sleep,1,-5);
				if(statusEffectv1(StatusEffects.Sleep) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer asleep!</b>\n\n");
					removeStatusEffect(StatusEffects.Sleep);
				}
				else outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " currently asleep!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.InvisibleOrStealth)) {
				addStatusValue(StatusEffects.InvisibleOrStealth,1,-1);
				if(statusEffectv1(StatusEffects.InvisibleOrStealth) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " have" : " has") + " found you!</b>\n\n");
					removeStatusEffect(StatusEffects.InvisibleOrStealth);
				}
				else outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " looking for you!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.Distracted)) {
				addStatusValue(StatusEffects.Distracted,1,-1);
				if (hasPerk(PerkLib.EnemyResiliance)) addStatusValue(StatusEffects.Distracted,1,-5);
				if(statusEffectv1(StatusEffects.Distracted) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer distracted!</b>\n\n");
					removeStatusEffect(StatusEffects.Distracted);
				}
				else outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " currently distracted!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.HypnosisNaga)) {
				addStatusValue(StatusEffects.HypnosisNaga,1,-1);
				if (hasPerk(PerkLib.EnemyResiliance)) addStatusValue(StatusEffects.HypnosisNaga,1,-5);
				if(statusEffectv1(StatusEffects.HypnosisNaga) <= 0) {
					outputText("<b>You try to prolong the trance but " + a + short + " finally snaps out.</b>\n\n");
					removeStatusEffect(StatusEffects.HypnosisNaga);
				}
				else outputText("<b>" + capitalA + short + " is lost in your gaze unable to act.</b>\n\n");
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
			if(hasStatusEffect(StatusEffects.PunishingKick)) {
				addStatusValue(StatusEffects.PunishingKick,1,-1);
				if(statusEffectv1(StatusEffects.PunishingKick) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer under Punishing Kick effect!</b>\n\n");
					removeStatusEffect(StatusEffects.PunishingKick);
				}
			}
			if(hasStatusEffect(StatusEffects.Sandstorm)) {
				//Blinded:
				if(player.hasStatusEffect(StatusEffects.Blind)) {
					outputText("<b>You blink the sand from your eyes, but you're sure that more will get you if you don't end it soon!</b>\n\n");
					player.removeStatusEffect(StatusEffects.Blind);
				}
				else {
					if((statusEffectv1(StatusEffects.Sandstorm) == 0 || statusEffectv1(StatusEffects.Sandstorm) % 4 == 0) && !player.hasPerk(PerkLib.BlindImmunity)) {
						player.createStatusEffect(StatusEffects.Blind,0,0,0,0);
						outputText("<b>The sand is in your eyes!  You're blinded this turn!</b>\n\n");
					}
					else {
						outputText("<b>The grainy mess cuts at any exposed flesh and gets into every crack and crevice of your armor. ");
						var temp:Number = player.takePhysDamage(1 + rand(2), true);
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
			if(hasStatusEffect(StatusEffects.Hypermode)) {
				if (statusEffectv1(StatusEffects.Hypermode) <= 0) {
					outputText("<b>" + capitalA + short + " is no longer rampaging!</b>\n\n");
					removeStatusEffect(StatusEffects.Hypermode);
				}
				addStatusValue(StatusEffects.Hypermode,1,-1);
			}
			if(hasStatusEffect(StatusEffects.IzmaBleed)) {
				//Countdown to heal
				if (hasPerk(PerkLib.EnemyFleshConstructType)) addStatusValue(StatusEffects.IzmaBleed, 1, -2);
				else addStatusValue(StatusEffects.IzmaBleed, 1, -1);
				if (statusEffectv2(StatusEffects.IzmaBleed) > 0) addStatusValue(StatusEffects.IzmaBleed, 2, -1);
				if (statusEffectv4(StatusEffects.IzmaBleed) == 1) addStatusValue(StatusEffects.IzmaBleed, 4, -1);
				//Heal wounds
				if (statusEffectv1(StatusEffects.IzmaBleed) <= 0) {
					outputText("The wounds you left on " + a + short + " stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.IzmaBleed);
				}
				//Deal damage if still wounded.
				else {
					var procentvalue:Number = (4 + rand(7));
					if (game.player.hasPerk(PerkLib.ThirstForBlood)) procentvalue *= 1.5;
					if (statusEffectv2(StatusEffects.IzmaBleed) > 0) procentvalue += statusEffectv2(StatusEffects.IzmaBleed);
					procentvalue = Math.round(procentvalue);
					var store:Number = maxHP() * (procentvalue) / 100;
					store = SceneLib.combat.doDamage(store);
					if (plural) outputText(capitalA + short + " bleed profusely from the jagged wounds your weapon left behind. <b>(<font color=\"#800000\">" + store + "</font>)</b>\n\n");
					else outputText(capitalA + short + " bleeds profusely from the jagged wounds your weapon left behind. <b>(<font color=\"#800000\">" + store + "</font>)</b>\n\n");
				}
			}
			if(hasStatusEffect(StatusEffects.SharkBiteBleed)) {
				//Countdown to heal
				if (hasPerk(PerkLib.EnemyFleshConstructType)) addStatusValue(StatusEffects.SharkBiteBleed, 1, -2);
				else addStatusValue(StatusEffects.SharkBiteBleed,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.SharkBiteBleed) <= 0) {
					outputText("The bite wounds you left on " + a + short + " stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.SharkBiteBleed);
				}
				//Deal damage if still wounded.
				else {
					var store3:Number = (player.str + player.spe) * 2;
					if (game.player.hasPerk(PerkLib.ThirstForBlood)) store3 *= 1.5;
					store3 = Math.round(store3);
					if (statusEffectv2(StatusEffects.SharkBiteBleed) > 0) store3 *= statusEffectv2(StatusEffects.SharkBiteBleed);
					store3 = SceneLib.combat.doDamage(store3);
					if(plural) outputText(capitalA + short + " bleed profusely from the jagged wounds your bite left behind. <b>(<font color=\"#800000\">" + store3 + "</font>)</b>\n\n");
					else outputText(capitalA + short + " bleeds profusely from the jagged wounds your bite left behind. <b>(<font color=\"#800000\">" + store3 + "</font>)</b>\n\n");
				}
			}
			if(hasStatusEffect(StatusEffects.CouatlHurricane)) {
				//Deal severe true damage each round
				var store14:Number = (player.inte + player.spe) * 2;
				createStatusEffect(StatusEffects.CouatlHurricane, (player.spe*5)+(player.inte*5), 1, 0, 0);
				store14 = Math.round(store14);
				if (statusEffectv2(StatusEffects.CouatlHurricane) > 0) store14 *= statusEffectv2(StatusEffects.CouatlHurricane);
				store14 += statusEffectv1(StatusEffects.CouatlHurricane); //Stacks on itself growing ever stronger
				store14 += maxHP()*0.02;
				store14 = SceneLib.combat.doDamage(store14);
				if(plural) outputText(capitalA + short + " is violently struck by the ever intensifying windstorm. <b>(<font color=\"#800000\">" + store14 + "</font>)</b>\n\n");
				else outputText(capitalA + short + " are violently struck by the ever intensifying windstorm. <b>(<font color=\"#800000\">" + store14 + "</font>)</b>\n\n");
				temp = rand(4);
				if(temp == 3) createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0); outputText("<b>A random flying object caught in the hurricane rams into your opponent, stunning it!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.KamaitachiBleed)) {
				//This wounds never heals unless by magic
				//Deal damage if still wounded.
				var store13:Number = (player.str + player.spe) * 2;
				if (game.player.hasPerk(PerkLib.ThirstForBlood)) store13 *= 1.5;
				store13 = Math.round(store13);
				if (statusEffectv2(StatusEffects.KamaitachiBleed) > 0) store13 *= statusEffectv2(StatusEffects.KamaitachiBleed);
				store13 += statusEffectv1(StatusEffects.KamaitachiBleed); //Kamaitachi bleed stacks on itself growing ever stronger
				store13 += maxHP()*0.02;
				store13 = SceneLib.combat.doDamage(store13);
				if(plural) outputText(capitalA + short + " bleed profusely from the deep wounds your scythes left behind. <b>(<font color=\"#800000\">" + store13 + "</font>)</b>\n\n");
				else outputText(capitalA + short + " bleeds profusely from the deep wounds your scythes left behind. <b>(<font color=\"#800000\">" + store13 + "</font>)</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.GoreBleed)) {
				//Countdown to heal
				if (hasPerk(PerkLib.EnemyFleshConstructType)) addStatusValue(StatusEffects.GoreBleed, 1, -2);
				else addStatusValue(StatusEffects.GoreBleed,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.GoreBleed) <= 0) {
					outputText("The ");
					if (player.horns.type == Horns.COW_MINOTAUR) outputText("horns wounds");
					else outputText("horns wound");
					outputText(" you left on " + a + short + " stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.GoreBleed);
				}
				//Deal damage if still wounded.
				else {
					var store5:Number = (player.str + player.spe) * 2;
					if (game.player.hasPerk(PerkLib.ThirstForBlood)) store5 *= 1.5;
					store5 = Math.round(store5);
					store5 = SceneLib.combat.doDamage(store5);
					if (plural) {
						outputText(capitalA + short + " bleed profusely from the jagged ");
						if (player.horns.type == Horns.COW_MINOTAUR) outputText("wounds your horns");
						else outputText("wound your horns");
						outputText(" left behind. <b>(<font color=\"#800000\">" + store5 + "</font>)</b>\n\n");
					}
					else {
						outputText(capitalA + short + " bleeds profusely from the jagged ");
						if (player.horns.type == Horns.COW_MINOTAUR) outputText("wounds your horns");
						else outputText("wound your horns");
						outputText(" left behind. <b>(<font color=\"#800000\">" + store5 + "</font>)</b>\n\n");
					}
				}
			}
			if(hasStatusEffect(StatusEffects.Hemorrhage) || hasStatusEffect(StatusEffects.HemorrhageArmor) || hasStatusEffect(StatusEffects.HemorrhageShield)) {
				//Countdown to heal
				if (hasStatusEffect(StatusEffects.Hemorrhage)) {
					if (hasPerk(PerkLib.EnemyFleshConstructType)) addStatusValue(StatusEffects.Hemorrhage, 1, -2);
					else addStatusValue(StatusEffects.Hemorrhage, 1, -1);
				}
				if (hasStatusEffect(StatusEffects.HemorrhageArmor)) {
					if (hasPerk(PerkLib.EnemyFleshConstructType)) addStatusValue(StatusEffects.HemorrhageArmor, 1, -2);
					else addStatusValue(StatusEffects.HemorrhageArmor, 1, -1);
				}
				if (hasStatusEffect(StatusEffects.HemorrhageShield)) {
					if (hasPerk(PerkLib.EnemyFleshConstructType)) addStatusValue(StatusEffects.HemorrhageShield, 1, -2);
					else addStatusValue(StatusEffects.HemorrhageShield, 1, -1);
				}
				//Heal wounds
				if (statusEffectv1(StatusEffects.Hemorrhage) <= 0 || statusEffectv1(StatusEffects.HemorrhageArmor) <= 0 || statusEffectv1(StatusEffects.HemorrhageShield) <= 0) {
					outputText("The wounds you left on " + a + short + " stop bleeding so profusely.\n\n");
					if (statusEffectv1(StatusEffects.Hemorrhage) <= 0) removeStatusEffect(StatusEffects.Hemorrhage);
					if (statusEffectv1(StatusEffects.HemorrhageArmor) <= 0) removeStatusEffect(StatusEffects.HemorrhageArmor);
					if (statusEffectv1(StatusEffects.HemorrhageShield) <= 0) removeStatusEffect(StatusEffects.HemorrhageShield);
				}
				//Deal damage if still wounded.
				else {
					var hemorrhage:Number = 0;
					if (statusEffectv1(StatusEffects.Hemorrhage) > 0) hemorrhage += maxHP() * statusEffectv2(StatusEffects.Hemorrhage);
					if (statusEffectv1(StatusEffects.HemorrhageArmor) > 0) hemorrhage += maxHP() * statusEffectv2(StatusEffects.HemorrhageArmor);
					if (statusEffectv1(StatusEffects.HemorrhageShield) > 0) hemorrhage += maxHP() * statusEffectv2(StatusEffects.HemorrhageShield);
					hemorrhage = SceneLib.combat.doDamage(hemorrhage);
					if (plural) outputText(capitalA + short + " bleed profusely from the jagged wounds your attack left behind. <b>(<font color=\"#800000\">" + hemorrhage + "</font>)</b>\n\n");
					else outputText(capitalA + short + " bleeds profusely from the jagged wounds your attack left behind. <b>(<font color=\"#800000\">" + hemorrhage + "</font>)</b>\n\n");
				}
			}
			if(hasStatusEffect(StatusEffects.Hemorrhage2)) {
				//Countdown to heal
				if (hasPerk(PerkLib.EnemyFleshConstructType)) addStatusValue(StatusEffects.Hemorrhage2, 1, -2);
				else addStatusValue(StatusEffects.Hemorrhage2, 1, -1);
				//Heal wounds
				if (statusEffectv1(StatusEffects.Hemorrhage2) <= 0) {
					outputText("The wounds your companion left on " + a + short + " stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.Hemorrhage2);
				}
				//Deal damage if still wounded.
				else {
					var hemorrhage2:Number = 0;
					hemorrhage2 += maxHP() * statusEffectv2(StatusEffects.Hemorrhage2);
					hemorrhage2 = SceneLib.combat.doDamage(hemorrhage2);
					if (plural) outputText(capitalA + short + " bleed profusely from the jagged wounds your companion attack left behind. <b>(<font color=\"#800000\">" + hemorrhage2 + "</font>)</b>\n\n");
					else outputText(capitalA + short + " bleeds profusely from the jagged wounds your companion attack left behind. <b>(<font color=\"#800000\">" + hemorrhage2 + "</font>)</b>\n\n");
				}
			}
			if (hasStatusEffect(StatusEffects.Bloodlust)) {
				if (this is UnderwaterSharkGirl || this is UnderwaterTigersharkGirl || this is UnderwaterSharkGirlsPack) {
					outputText("As blood flows through the water the "+(this is UnderwaterTigersharkGirl ? "tiger ":"")+"shark girl"+(this is UnderwaterSharkGirlsPack ? "s":"")+" grows increasingly vicious. ");
				}
			}
			if(hasStatusEffect(StatusEffects.MonsterRegen)) {
				if(statusEffectv1(StatusEffects.MonsterRegen) <= 0)
					removeStatusEffect(StatusEffects.MonsterRegen);
				addStatusValue(StatusEffects.MonsterRegen,1,-1);
			}
			if(hasStatusEffect(StatusEffects.MonsterRegen2)) {
				if(statusEffectv1(StatusEffects.MonsterRegen2) <= 0)
					removeStatusEffect(StatusEffects.MonsterRegen2);
				addStatusValue(StatusEffects.MonsterRegen2,1,-1);
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
				player.dynStats("lus", 5+player.effectiveSensitivity()/10);
			}
			if(hasStatusEffect(StatusEffects.QueenBind)) {
				outputText("You're utterly restrained by the Harpy Queen's magical ropes!\n\n");
				if(flags[kFLAGS.PC_FETISH] >= 2) player.dynStats("lus", 3);
			}
			if(this is SecretarialSuccubus || this is MilkySuccubus) {
				if(player.lust < (player.maxLust() * 0.45)) outputText("There is something in the air around your opponent that makes you feel warm.\n\n");
				if(player.lust >= (player.maxLust() * 0.45) && player.lust < (player.maxLust() * 0.70)) outputText("You aren't sure why but you have difficulty keeping your eyes off your opponent's lewd form.\n\n");
				if(player.lust >= (player.maxLust() * 0.70) && player.lust < (player.maxLust() * 0.90)) outputText("You blush when you catch yourself staring at your foe's rack, watching it wobble with every step she takes.\n\n");
				if(player.lust >= (player.maxLust() * 0.90)) outputText("You have trouble keeping your greedy hands away from your groin.  It would be so easy to just lay down and masturbate to the sight of your curvy enemy.  The succubus looks at you with a sexy, knowing expression.\n\n");
				player.dynStats("lus", 1+rand(8));
			}
			//[LUST GAINED PER ROUND] - Omnibus
			if(hasStatusEffect(StatusEffects.LustAura)) {
				if (this is OmnibusOverseer || this is HeroslayerOmnibus) {
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
				if (this is Alraune || this is Marae) {
					if(player.lust < (player.maxLust() * 0.33)) outputText("The pollen in the air gradually increase your arousal.\n\n");
					if(player.lust >= (player.maxLust() * 0.33) && player.lust < (player.maxLust() * 0.66)) outputText("The pollen in the air is getting to you.\n\n");
					if(player.lust >= (player.maxLust() * 0.66)) outputText("You flush bright red with desire as the lust in the air worms its way inside you.\n\n");
				}
				player.dynStats("lus", (3 + int(player.lib/20 + player.cor/25)));
			}
			//immolation DoT
			if (hasStatusEffect(StatusEffects.ImmolationDoT)) {
				//Countdown to heal
				addStatusValue(StatusEffects.ImmolationDoT,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.ImmolationDoT) <= 0) {
					outputText("Flames left by immolation spell on " + a + short + " finally stop burning.\n\n");
					removeStatusEffect(StatusEffects.ImmolationDoT);
				}
				//Deal damage if still wounded.
				else {
					var store2:Number = int(50+(player.inte/10));
					store2 = SceneLib.combat.doFireDamage(store2);
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
					outputText("Flames left by Burn on " + a + short + " finally stop burning.\n\n");
					removeStatusEffect(StatusEffects.BurnDoT);
				}
				//Deal damage if still wounded.
				else {
					var store4:Number = (player.str + player.spe + player.tou) * 2.5;
					store4 += maxHP() * statusEffectv2(StatusEffects.BurnDoT);
					store4 = SceneLib.combat.doFireDamage(store4);
					if(plural) outputText(capitalA + short + " burn from lingering Burn after-effect. <b>(<font color=\"#800000\">" + store4 + "</font>)</b>\n\n");
					else outputText(capitalA + short + " burns from lingering Burn after-effect. <b>(<font color=\"#800000\">" + store4 + "</font>)</b>\n\n");
				}
			}
			//Burn DoT
			if (hasStatusEffect(StatusEffects.BurnDoT2)) {
				//Countdown to heal
				addStatusValue(StatusEffects.BurnDoT2,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.BurnDoT2) <= 0) {
					outputText("Flames left by Burn on " + a + short + " finally stop burning.\n\n");
					removeStatusEffect(StatusEffects.BurnDoT2);
				}
				//Deal damage if still wounded.
				else {
					var store8:Number = (player.str + player.spe + player.tou) * 2.5;
					store8 += maxHP() * statusEffectv2(StatusEffects.BurnDoT2);
					store8 = SceneLib.combat.doFireDamage(store8);
					if(plural) outputText(capitalA + short + " burn from lingering Burn after-effect. <b>(<font color=\"#800000\">" + store8 + "</font>)</b>\n\n");
					else outputText(capitalA + short + " burns from lingering Burn after-effect. <b>(<font color=\"#800000\">" + store8 + "</font>)</b>\n\n");
				}
			}
			//Fire Punch Burn DoT
			if (hasStatusEffect(StatusEffects.FirePunchBurnDoT)) {
				//Countdown to heal
				addStatusValue(StatusEffects.FirePunchBurnDoT,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.FirePunchBurnDoT) <= 0) {
					outputText("Flames left by Fire Punch on " + a + short + " finally stop burning.\n\n");
					removeStatusEffect(StatusEffects.FirePunchBurnDoT);
				}
				//Deal damage if still wounded.
				else {
					var store6:Number = (player.spe + player.inte) * SceneLib.combat.soulskillMod() * 0.5;
					store6 = SceneLib.combat.doFireDamage(store6);
					if(plural) outputText(capitalA + short + " burn from lingering Fire Punch after-effect. <b>(<font color=\"#800000\">" + store6 + "</font>)</b>\n\n");
					else outputText(capitalA + short + " burns from lingering Fire Punch after-effect. <b>(<font color=\"#800000\">" + store6 + "</font>)</b>\n\n");
				}
			}
			//Regen Inhibitor
			if (hasStatusEffect(StatusEffects.RegenInhibitor)) {
				//Countdown to heal
				addStatusValue(StatusEffects.RegenInhibitor,1,-1);
				//Heal wounds
				if (statusEffectv1(StatusEffects.RegenInhibitor) <= 0) {
					outputText(capitalA + short + " sighs in relief as " + pronoun3 + " wounds resume regenerating!\n\n");
					removeStatusEffect(StatusEffects.RegenInhibitor);
				}
			}
			//Regen Inhibitor
			if (hasStatusEffect(StatusEffects.HydraRegenerationDisabled)) {
				//Countdown to heal
				addStatusValue(StatusEffects.HydraRegenerationDisabled,1,-1);
				//Heal wounds
				if (statusEffectv1(StatusEffects.HydraRegenerationDisabled) <= 0) {
					if (this is Hydra) outputText(capitalA + short + " sighs in relief as " + pronoun3 + " wounds resume regenerating!\n\n");
					removeStatusEffect(StatusEffects.HydraRegenerationDisabled);
				}
			}
			//Ice DoT
			if (hasStatusEffect(StatusEffects.FrostburnDoT)) {
				//Countdown to heal
				addStatusValue(StatusEffects.FrostburnDoT,1,-1);
				if (statusEffectv4(StatusEffects.FrostburnDoT) == 0) {
					if (statusEffectv1(StatusEffects.FrostburnDoT) > 1) addStatusValue(StatusEffects.FrostburnDoT, 1, -1);
					//Heal wounds
					if (statusEffectv1(StatusEffects.FrostburnDoT) <= 0) {
						outputText("Wound left by frostburn on " + a + short + " finally close ups.\n\n");
						removeStatusEffect(StatusEffects.FrostburnDoT);
					}
					//Deal damage if still wounded.
					else {
						var store12:Number = (player.str + player.spe + player.tou) * 2.5;
						store12 += maxHP() * statusEffectv2(StatusEffects.FrostburnDoT);
						if(plural) outputText(capitalA + short + " are hurt by lingering Frostburn after-effect. ");
						else outputText(capitalA + short + " is hurt by lingering Frostburn after-effect. ");
						store12 = SceneLib.combat.doIceDamage(store12, true, true);
						outputText("\n\n");
					}
				}
			}
			//Acid DoT
			if (hasStatusEffect(StatusEffects.AcidDoT)) {
				//Countdown to heal
				addStatusValue(StatusEffects.AcidDoT,1,-1);
				if (statusEffectv4(StatusEffects.AcidDoT) == 0) {
					if (statusEffectv1(StatusEffects.AcidDoT) > 1) addStatusValue(StatusEffects.AcidDoT, 1, -1);
					//Heal wounds
					if (statusEffectv1(StatusEffects.AcidDoT) <= 0) {
						outputText("Wound left by acid on " + a + short + " finally close ups.\n\n");
						removeStatusEffect(StatusEffects.AcidDoT);
					}
					//Deal damage if still wounded.
					else {
						var store7:Number = (player.str + player.spe + player.tou) * 2.5;
						store7 += maxHP() * statusEffectv2(StatusEffects.AcidDoT);
						if(plural) outputText(capitalA + short + " are hurt by lingering Acid after-effect. ");
						else outputText(capitalA + short + " is hurt by lingering Acid after-effect. ");
						store7 = SceneLib.combat.doMagicDamage(store7, true, true);
						outputText("\n\n");
					}
				}
			}
			//Poison Dot
			if (hasStatusEffect(StatusEffects.PoisonDoT)) {
				//Countdown to heal
				addStatusValue(StatusEffects.PoisonDoT,1,-1);
				if (statusEffectv4(StatusEffects.PoisonDoT) == 0) {
					if (statusEffectv1(StatusEffects.PoisonDoT) > 1) addStatusValue(StatusEffects.PoisonDoT, 1, -1);
					//Heal wounds
					if (statusEffectv1(StatusEffects.PoisonDoT) <= 0) {
						outputText("Wound left by poison on " + a + short + " finally close ups.\n\n");
						removeStatusEffect(StatusEffects.PoisonDoT);
					}
					//Deal damage if still wounded.
					else {
						var store10:Number = (player.str + player.spe + player.tou) * 2.5;
						store10 += maxHP() * statusEffectv2(StatusEffects.PoisonDoT);
						if(plural) outputText(capitalA + short + " are hurt by lingering Poison after-effect. ");
						else outputText(capitalA + short + " is hurt by lingering Poison after-effect. ");
						store10 = SceneLib.combat.doMagicDamage(store10, true, true);
						outputText("\n\n");
					}
				}
			}
			if (hasStatusEffect(StatusEffects.PoisonDoTH)) {
				//Countdown to heal
				addStatusValue(StatusEffects.PoisonDoTH,1,-1);
				if (statusEffectv4(StatusEffects.PoisonDoTH) == 0) {
					if (statusEffectv1(StatusEffects.PoisonDoTH) > 1) addStatusValue(StatusEffects.PoisonDoTH, 1, -1);
					//Heal wounds
					if (statusEffectv1(StatusEffects.PoisonDoTH) <= 0) {
						outputText("Wound left by poison on " + a + short + " finally close ups.\n\n");
						removeStatusEffect(StatusEffects.PoisonDoTH);
					}
					//Deal damage if still wounded.
					else {
						var store9:Number = 0;
						store9 += maxHP() * statusEffectv2(StatusEffects.PoisonDoTH);
						if(plural) outputText(capitalA + short + " are hurt by lingering Poison after-effect. ");
						else outputText(capitalA + short + " is hurt by lingering Poison after-effect. ");
						store9 = SceneLib.combat.doMagicDamage(store9, true, true);
						outputText("\n\n");
					}
				}
			}
			//Lust Dot
			if (hasStatusEffect(StatusEffects.LustDoT)) {
				//Countdown to heal
				addStatusValue(StatusEffects.LustDoT,1,-1);
				if (statusEffectv4(StatusEffects.LustDoT) == 0) {
					if (statusEffectv1(StatusEffects.LustDoT) > 1) addStatusValue(StatusEffects.LustDoT, 1, -1);
					//Heal wounds
					if (statusEffectv1(StatusEffects.LustDoT) <= 0) {
						outputText("Lingering lust-induncing after-effect on " + a + short + " finally ends.\n\n");
						removeStatusEffect(StatusEffects.LustDoT);
					}
					//Deal damage if still wounded.
					else {
						var lustDmg1:Number = Math.round(player.lib / 10);
						lustDmg1 += maxLust() * statusEffectv2(StatusEffects.LustDoT);
						if(plural) outputText(capitalA + short + " are aroused by lingering lust-induncing after-effect. ");
						else outputText(capitalA + short + " is aroused by lingering lust-induncing after-effect. ");
						teased(lustDmg1, false);
						outputText("\n\n");
					}
				}
			}
			if (hasStatusEffect(StatusEffects.LustDoTH)) {
				//Countdown to heal
				addStatusValue(StatusEffects.LustDoTH,1,-1);
				if (statusEffectv4(StatusEffects.LustDoTH) == 0) {
					if (statusEffectv1(StatusEffects.LustDoTH) > 1) addStatusValue(StatusEffects.LustDoTH, 1, -1);
					//Heal wounds
					if (statusEffectv1(StatusEffects.LustDoTH) <= 0) {
						outputText("Lingering lust-induncing after-effect on " + a + short + " finally ends.\n\n");
						removeStatusEffect(StatusEffects.LustDoTH);
					}
					//Deal damage if still wounded.
					else {
						var lustDmg2:Number = 0;
						lustDmg2 += maxLust() * statusEffectv2(StatusEffects.LustDoTH);
						if(plural) outputText(capitalA + short + " are aroused by lingering lust-induncing after-effect. ");
						else outputText(capitalA + short + " is aroused by lingering lust-induncing after-effect. ");
						teased(lustDmg2, false);
						outputText("\n\n");
					}
				}
			}
			if (hasStatusEffect(StatusEffects.Maleficium)) {
				if (statusEffectv1(StatusEffects.Maleficium) <= 0) {
					removeStatusEffect(StatusEffects.Maleficium);
					outputText("<b>Enemy Maleficium effect wore off!</b>\n\n");
				}
				else addStatusValue(StatusEffects.Maleficium,1,-1);
			}
			//Ice Armor
			if (hasStatusEffect(StatusEffects.IceArmor)) {
				if (statusEffectv1(StatusEffects.IceArmor) <= 0) {
					removeStatusEffect(StatusEffects.IceArmor);
					outputText("<b>" + capitalA + short + " ice armor has thawed out.</b>\n\n");
				}
				else addStatusValue(StatusEffects.IceArmor,1,-1);
			}

			//Flame Blade
			if (hasStatusEffect(StatusEffects.FlameBlade)) {
				if (statusEffectv1(StatusEffects.FlameBlade) <= 0) {
					removeStatusEffect(StatusEffects.FlameBlade);
					outputText("<b>" + capitalA + short + "'s Flame Blade effect wore off.</b>\n\n");
				}
				else addStatusValue(StatusEffects.FlameBlade,1,-1);
			}

			//Consuming darkness
			if (hasStatusEffect(StatusEffects.ConsumingDarkness)) {
				if (statusEffectv1(StatusEffects.ConsumingDarkness) <= 0) removeStatusEffect(StatusEffects.ConsumingDarkness);
				else {
					addStatusValue(StatusEffects.ConsumingDarkness, 1, -1);
					outputText("Hungry darkness gnaw at your foe for ");
					var store11:Number = 0;
					store11 += statusEffectv2(StatusEffects.ConsumingDarkness);
					store11 *= 0.2;
					store11 = Math.round(store11);
					store11 = SceneLib.combat.doDarknessDamage(store11, true, true);
					outputText("\n\n");
				}
			}
			//Curse of Desire
			if (hasStatusEffect(StatusEffects.CurseOfDesire)) {
				if (statusEffectv1(StatusEffects.CurseOfDesire) <= 0) {
					if (statusEffectv3(StatusEffects.CurseOfDesire) > 0) lustVuln += statusEffectv3(StatusEffects.CurseOfDesire);
					removeStatusEffect(StatusEffects.CurseOfDesire);
				}
				else {
					addStatusValue(StatusEffects.CurseOfDesire, 1, -1);
					var lustDmg3:Number = 0;
					lustDmg3 += statusEffectv2(StatusEffects.CurseOfDesire);
					lustDmg3 *= 0.2;
					if (lustDmg3 < 1) lustDmg3 = 1;
					else lustDmg3 = Math.round(lustDmg3);
					outputText("The curse of desire slowly sap at your victim's resolve and countenance. ");
					teased(lustDmg3, false);
					outputText("\n\n");
				}
			}

			//Curse of Weeping
			if (hasStatusEffect(StatusEffects.CurseOfWeeping)) {
				if (statusEffectv1(StatusEffects.CurseOfWeeping) <= 0) removeStatusEffect(StatusEffects.CurseOfWeeping);
				else {
					addStatusValue(StatusEffects.CurseOfWeeping, 1, -1);
					outputText("Your foe is bleeding due to your curse. ");
					var hemorrhage3Damage:Number = 0;
					hemorrhage3Damage += statusEffectv2(StatusEffects.CurseOfWeeping);
					hemorrhage3Damage *= 0.2;
					hemorrhage3Damage = Math.round(hemorrhage3Damage);
					hemorrhage3Damage = SceneLib.combat.doDamage(hemorrhage3Damage, true, true);
					outputText("\n\n");
				}
			}

			//lowered damage done by enemy attacks debuff
			if (hasStatusEffect(StatusEffects.EnemyLoweredDamageH)) {
				if (statusEffectv1(StatusEffects.EnemyLoweredDamageH) <= 0) removeStatusEffect(StatusEffects.EnemyLoweredDamageH);
				else addStatusValue(StatusEffects.EnemyLoweredDamageH,1,-1);
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
			if (SceneLib.prison.inPrison) {
				SceneLib.prison.doPrisonEscapeFightLoss();
				return 8;
			}
			if (!inDungeon) {
				if (SceneLib.prison.trainingFeed.prisonCaptorFeedingQuestTrainingExists()) {
					if (short == "goblin" || short == "goblin assassin" || short == "goblin warrior" || short == "goblin shaman" || short == "imp" || short == "imp lord" || short == "imp warlord" || short == "imp overlord" || //Generic encounter
						short == "tentacle beast" || (short == "kitsune" && hairColor == "red") || short == "Akbal" || short == "Tamani" || //Forest, deepwoods
						short == "goo-girl" || short == "green slime" || short == "fetish cultist" || short == "fetish zealot" || //Lake
						short == "sandtrap" || short == "sand tarp" || short == "naga" || short == "demons" || short == "Cum Witch" || //Desert
						short == "hellhound" || short == "infested hellhound" || short == "minotaur" || short == "minotaur lord" || short == "minotaur gang" || short == "minotaur tribe" || short == "basilisk" || short == "phoenix" || //Mountain, high mountains
						short == "satyr" || short == "gnoll" || short == "gnoll spear-thrower" || short == "female spider-morph" || short == "male spider-morph" || short == "corrupted drider" || //Plains, swamp, bog
						short == "yeti" || short == "behemoth") { //Glacial rift, volcanic crag
						SceneLib.prison.trainingFeed.prisonCaptorFeedingQuestTrainingProgress(1, 1);
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
		public function prepareForCombat():void {
			var bonusStatsAmp:Number = 0.2;
			if (hasPerk(PerkLib.MantislikeAgility)) this.speStat.core.value += (10 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.MantislikeAgilityEvolved)) this.speStat.core.value += (20 * (1 + newGamePlusMod()));
			if (level > 25) bonusStatsAmp += 0.1*((int)(level-1)/25);
			bonusAscStr += bonusStatsAmp * str * newGamePlusMod();
			bonusAscTou += bonusStatsAmp * tou * newGamePlusMod();
			bonusAscSpe += bonusStatsAmp * spe * newGamePlusMod();
			bonusAscInt += bonusStatsAmp * inte * newGamePlusMod();
			bonusAscWis += bonusStatsAmp * wis * newGamePlusMod();
			bonusAscLib += bonusStatsAmp * lib * newGamePlusMod();
			bonusAscSen += bonusStatsAmp * sens * newGamePlusMod();
			bonusAscStr = Math.round(bonusAscStr);
			bonusAscTou = Math.round(bonusAscTou);
			bonusAscSpe = Math.round(bonusAscSpe);
			bonusAscInt = Math.round(bonusAscInt);
			bonusAscWis = Math.round(bonusAscWis);
			bonusAscLib = Math.round(bonusAscLib);
			bonusAscSen = Math.round(bonusAscSen);
			this.strStat.core.value += bonusAscStr;
			this.touStat.core.value += bonusAscTou;
			this.speStat.core.value += bonusAscSpe;
			this.intStat.core.value += bonusAscInt;
			this.wisStat.core.value += bonusAscWis;
			this.libStat.core.value += bonusAscLib;
			statStore.addBuff("sens", bonusAscSen, "Ascension", {});
			var multiStatsAmp1:Number = 0;
			this.strStat.core.value += multiStatsAmp1;
			this.touStat.core.value += multiStatsAmp1;
			this.speStat.core.value += multiStatsAmp1;
			var multiStatsAmp2:Number = 0;
			this.intStat.core.value += multiStatsAmp2;
			this.wisStat.core.value += multiStatsAmp2;
			this.libStat.core.value += multiStatsAmp2;
			statStore.addBuff("sens", multiStatsAmp2, "AscensionMultiplier", {});
			bonusAscMaxHP += bonusAscStr + bonusAscTou + bonusAscSpe + bonusAscInt + bonusAscWis + bonusAscLib + bonusAscSen;
			if (level > 10) bonusAscMaxHP *= (int)(level / 10 + 1);
			weaponAttack += (1 + (int)(weaponAttack / 5)) * newGamePlusMod();
			if (weaponRangeAttack > 0) weaponRangeAttack += (1 + (int)(weaponRangeAttack / 5)) * newGamePlusMod();
			if (hasPerk(PerkLib.ToughHide)) {
				armorDef += (2 * (1 + newGamePlusMod()));
				armorMDef += (1 * (1 + newGamePlusMod()));
			}
			if (hasPerk(PerkLib.FeralArmor)) {
				armorDef += Math.round(tou / 20);
				armorMDef += Math.round(tou / 20);
			}
			if (hasPerk(PerkLib.FleshBodyApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) {
					armorDef += (2 * (1 + newGamePlusMod()));
					armorMDef += (1 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulPersonage)) {
					armorDef += (2 * (1 + newGamePlusMod()));
					armorMDef += (1 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulWarrior)) {
					armorDef += (2 * (1 + newGamePlusMod()));
					armorMDef += (1 * (1 + newGamePlusMod()));
				}
			}
			if (hasPerk(PerkLib.FleshBodyWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) {
					armorDef += (3 * (1 + newGamePlusMod()));
					armorMDef += (2 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulScholar)) {
					armorDef += (3 * (1 + newGamePlusMod()));
					armorMDef += (2 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulElder)) {
					armorDef += (3 * (1 + newGamePlusMod()));
					armorMDef += (2 * (1 + newGamePlusMod()));
				}
			}
			if (hasPerk(PerkLib.FleshBodyElderStage)) {
				if (hasPerk(PerkLib.SoulExalt)) {
					armorDef += (4 * (1 + newGamePlusMod()));
					armorMDef += (3 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulOverlord)) {
					armorDef += (4 * (1 + newGamePlusMod()));
					armorMDef += (3 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulTyrant)) {
					armorDef += (4 * (1 + newGamePlusMod()));
					armorMDef += (3 * (1 + newGamePlusMod()));
				}
			}
			if (hasPerk(PerkLib.FleshBodyOverlordStage)) {
				if (hasPerk(PerkLib.SoulKing)) {
					armorDef += (5 * (1 + newGamePlusMod()));
					armorMDef += (4 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulEmperor)) {
					armorDef += (5 * (1 + newGamePlusMod()));
					armorMDef += (4 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulAncestor)) {
					armorDef += (5 * (1 + newGamePlusMod()));
					armorMDef += (4 * (1 + newGamePlusMod()));
				}
			}/*
			if (hasPerk(PerkLib.FleshBodyTyrantStage)) {
				if (hasPerk(PerkLib.soul)) {
					armorDef += (2 * (1 + newGamePlusMod()));
					armorMDef += (1 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.)) {
					armorDef += (2 * (1 + newGamePlusMod()));
					armorMDef += (1 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.)) {
					armorDef += (2 * (1 + newGamePlusMod()));
					armorMDef += (1 * (1 + newGamePlusMod()));
				}
			}*/
			armorDef += ((int)(1 + armorDef / 10)) * newGamePlusMod();
			armorMDef += ((int)(1 + armorMDef / 10)) * newGamePlusMod();
			if (hasPerk(PerkLib.EnemyHugeType)) {
				this.strStat.core.value += Math.round(this.strStat.core.value * 0.1);
				this.touStat.core.value += Math.round(this.touStat.core.value * 0.1);
				this.speStat.core.value += Math.round(this.speStat.core.value * 0.05);
				weaponAttack += Math.round(weaponAttack * 0.05);
				if (weaponRangeAttack > 0) weaponRangeAttack += Math.round(weaponRangeAttack * 0.05);
				armorDef += Math.round(armorDef * 0.05);
				armorMDef += Math.round(armorMDef * 0.05);
			}
			if (hasPerk(PerkLib.EnemyGigantType)) {
				this.strStat.core.value += Math.round(this.strStat.core.value * 0.25);
				this.touStat.core.value += Math.round(this.touStat.core.value * 0.25);
				this.speStat.core.value += Math.round(this.speStat.core.value * 0.1);
				weaponAttack += Math.round(weaponAttack * 0.15);
				if (weaponRangeAttack > 0) weaponRangeAttack += Math.round(weaponRangeAttack * 0.15);
				armorDef += Math.round(armorDef * 0.15);
				armorMDef += Math.round(armorMDef * 0.15);
			}
			if (hasPerk(PerkLib.EnemyColossalType)) {
				this.strStat.core.value += Math.round(this.strStat.core.value * 0.75);
				this.touStat.core.value += Math.round(this.touStat.core.value * 0.75);
				this.speStat.core.value += Math.round(this.speStat.core.value * 0.15);
				weaponAttack += Math.round(weaponAttack * 0.5);
				if (weaponRangeAttack > 0) weaponRangeAttack += Math.round(weaponRangeAttack * 0.5);
				armorDef += Math.round(armorDef * 0.5);
				armorMDef += Math.round(armorMDef * 0.5);
			}
			if (level < 6) {
				if (level < 3) this.lust *= 0.25;
				else this.lust *= 0.5;
				this.lust = Math.round(this.lust);
			}
		}
	}
}
