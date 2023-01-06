package classes
{
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
import classes.IMutations.IMutationsLib;
import classes.Items.ArmorLib;
import classes.Items.ConsumableLib;
import classes.Items.DynamicItems;
import classes.Items.HeadJewelryLib;
import classes.Items.ItemConstants;
import classes.Items.JewelryLib;
import classes.Items.NecklaceLib;
import classes.Items.ShieldLib;
import classes.Items.UndergarmentLib;
import classes.Items.UseableLib;
import classes.Items.WeaponLib;
import classes.Items.WeaponRangeLib;
import classes.Races.HumanRace;
import classes.Scenes.Areas.Forest.Alraune;
import classes.Scenes.Areas.Ocean.UnderwaterSharkGirl;
import classes.Scenes.Areas.Ocean.UnderwaterSharkGirlsPack;
import classes.Scenes.Areas.Ocean.UnderwaterTigersharkGirl;
import classes.Scenes.Combat.CombatAbility;
import classes.Scenes.Dungeons.DenOfDesire.HeroslayerOmnibus;
import classes.Scenes.Dungeons.DungeonAbstractContent;
import classes.Scenes.Dungeons.EbonLabyrinth.Hydra;
import classes.Scenes.Dungeons.Factory.OmnibusOverseer;
import classes.Scenes.Dungeons.Factory.SecretarialSuccubus;
import classes.Scenes.NPCs.ChiChi;
import classes.Scenes.Places.Boat.Marae;
import classes.Scenes.Quests.UrtaQuest.MilkySuccubus;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;
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
		protected function silly():Boolean {
			return EngineCore.silly();
		}
        protected function get sceneHunter():SceneHunter {
            return CoC.instance.gameSettings.sceneHunter_inst;
        }
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
		protected final function doNext(func:Function, ...args):void {
			EngineCore.doNext.apply(null, [func].concat(args));
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
		protected function get inDungeon():Boolean
		{
			return DungeonAbstractContent.inDungeon;
		}
		protected function set inDungeon(v:Boolean):void
		{
			DungeonAbstractContent.inDungeon = v;
		}
		//For enemies
		public var bonusHP:Number = 0;
		public var bonusLust:Number = 0;
		public var bonusSoulforce:Number = 0;
		public var bonusWrath:Number = 0;
		public var bonusMana:Number = 0;
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
		// No Ceraph fetish drop
		public var noFetishDrop:Boolean = false;
		// Chance (0..1) to drop generated random item
		public var randomDropChance:Number = 0;
		// Parameters for DynamicItems.randomItem. Default is { level: this.level }
		public var randomDropParams:Object;
		
		/**
		 * Called when monster is targeted with player's ability after it started to cast (used mana etc) but before any text output. Can interrupt ability usage (return true);
		 * @param ability
		 * @return true if ability was intercepted and should not apply its effect, false if it should proceed as usual
		 */
		public function interceptPlayerAbility(ability:CombatAbility):Boolean {
			// default - do nothing
			return false;
		}
		
		/**
		 * Called after monster was affected by player's ability.
		 * @param ability
		 */
		public function postPlayerAbility(ability:CombatAbility):void {
			// default - do nothing
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
			if (hasPerk(PerkLib.FleshBodyApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) temp += (400 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulPersonage)) temp += (400 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulWarrior)) temp += (400 * (1 + newGamePlusMod()));
			}
			if (hasPerk(PerkLib.FleshBodyWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) temp += (800 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulScholar)) temp += (800 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulGrandmaster)) temp += (800 * (1 + newGamePlusMod()));
			}
			if (hasPerk(PerkLib.FleshBodyElderStage)) {
				if (hasPerk(PerkLib.SoulElder)) temp += (1200 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulExalt)) temp += (1200 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulOverlord)) temp += (1200 * (1 + newGamePlusMod()));
			}
			if (hasPerk(PerkLib.FleshBodyOverlordStage)) {
				if (hasPerk(PerkLib.SoulTyrant)) temp += (1600 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulKing)) temp += (1600 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.SoulEmperor)) temp += (1600 * (1 + newGamePlusMod()));
			}
			if (hasPerk(PerkLib.FleshBodyTyrantStage)) {
				if (hasPerk(PerkLib.SoulAncestor)) temp += (2000 * (1 + newGamePlusMod()));
			}
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) temp += (150 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) temp += (225 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) temp += (300 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) temp += (375 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) temp += (450 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.ShieldWielder)) temp *= 1.2;
			if (hasPerk(PerkLib.EnemyHugeType)) temp *= 1.5;
			if (hasPerk(PerkLib.EnemyGigantType)) temp *= 2.25;
			if (hasPerk(PerkLib.EnemyColossalType)) temp *= 3;
			if (hasPerk(PerkLib.EnemyGroupType)) temp *= 5;
			if (hasPerk(PerkLib.EnemyLargeGroupType)) temp *= 10;
			if (hasPerk(PerkLib.Enemy300Type)) temp *= 15;
			temp *= stats_multi_based_on_misc();
			if (this.level < 6) {
				if (hasPerk(PerkLib.EnemyForBeginnersType)) temp *= 0.1;
				else temp *= 0.6;
			}
			temp = Math.round(temp);
			if (temp < (130 + 10 * this.level * (flags[kFLAGS.GAME_DIFFICULTY]+1) + (100 * newGamePlusMod()))) temp = (130 + 10 * this.level * (flags[kFLAGS.GAME_DIFFICULTY]+1) + (100 * newGamePlusMod()));
			return temp;
		}
		private function maxHPmult():Number {
			var maxHP_mult1:Number = 1;
			if (hasPerk(PerkLib.RefinedBodyI)) maxHP_mult1 += (0.05 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.LimitBreakerBody1stStage)) maxHP_mult1 += 0.05;
			if (hasPerk(PerkLib.LimitBreakerBody2ndStage)) maxHP_mult1 += 0.1;
			if (hasPerk(PerkLib.DeityJobMunchkin)) maxHP_mult1 += 0.2;
			if (statusEffectv2(StatusEffects.SaiyanNumber1a) > 0) maxHP_mult1 += statusEffectv2(StatusEffects.SaiyanNumber1a);
			if (statusEffectv2(StatusEffects.SaiyanNumber2a) > 0) maxHP_mult1 += statusEffectv2(StatusEffects.SaiyanNumber2a);
			if (statusEffectv2(StatusEffects.SaiyanNumber3a) > 0) maxHP_mult1 += statusEffectv2(StatusEffects.SaiyanNumber3a);
			return maxHP_mult1;
        }
		public override function maxHP():Number {
            return Math.round(maxHP_base()*maxHPmult());
        }
		public override function maxOverHP():Number {
			var maxOver:Number = maxHP();
			var maxOver2:Number = 1;
			if (hasPerk(PerkLib.HiddenJobBloodDemon)) maxOver2 += 0.1;
			if (hasPerk(PerkLib.WayOfTheBlood)) maxOver2 += 0.1;
			if (hasPerk(PerkLib.YourPainMyPower)) maxOver2 += 0.1;
			if (hasPerk(PerkLib.MyBloodForBloodPuppies)) maxOver2 += 0.1;
			if (hasPerk(PerkLib.BloodDemonToughness)) maxOver2 += 0.1;
			//
			if (hasPerk(PerkLib.BloodDemonWisdom)) maxOver2 += 0.1;
			//
			if (hasPerk(PerkLib.BloodDemonIntelligence)) maxOver2 += 0.1;
			if (hasPerk(PerkLib.MunchkinAtWork)) maxOver2 += 0.1;
			if (hasPerk(PerkLib.OverMaxHP)) {
				if (hasPerk(PerkLib.Enemy300Type)) maxOver2 += (0.15 * perkv1(PerkLib.OverMaxHP));
				else if (hasPerk(PerkLib.EnemyLargeGroupType)) maxOver2 += (0.1 * perkv1(PerkLib.OverMaxHP));
				else if (hasPerk(PerkLib.EnemyGroupType)) maxOver2 += (0.05 * perkv1(PerkLib.OverMaxHP));
				else maxOver2 += (0.01 * perkv1(PerkLib.OverMaxHP));
			}
			if (hasPerk(PerkLib.EnemyEliteType)) maxOver2 += 0.05;
			if (hasPerk(PerkLib.EnemyChampionType)) maxOver2 += 0.1;
			if (hasPerk(PerkLib.EnemyBossType)) maxOver2 += 0.15;
			maxOver *= maxOver2;//~180%
			if (hasStatusEffect(StatusEffects.CorpseExplosion)) maxOver *= (1 - (0.2 * statusEffectv1(StatusEffects.CorpseExplosion)));
			maxOver = Math.round(maxOver);
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
			if (perkv1(IMutationsLib.LizanMarrowIM) >= 3) min -= maxHP() * 0.05;
			if (perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 1) min -= maxHP() * 0.01;
			if (perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 2) min -= maxHP() * 0.02;
			if (hasPerk(PerkLib.Ferocity)) min -= maxHP() * 0.07;
			if (hasPerk(PerkLib.Rage)) min -= maxHP() * 0.05;
			if (hasPerk(PerkLib.TooAngryToDie)) min -= this.maxWrath();
			if (hasPerk(PerkLib.DeityJobMunchkin)) {
				min -= str;
				min -= tou;
				min -= spe;
				min -= inte;
				min -= wis;
				min -= lib;
				min -= sens;
			}
			if (hasPerk(PerkLib.DieHardHP)) {
				if (hasPerk(PerkLib.Enemy300Type)) min -= (maxHP() * 0.15 * perkv1(PerkLib.DieHardHP));
				else if (hasPerk(PerkLib.EnemyLargeGroupType)) min -= (maxHP() * 0.1 * perkv1(PerkLib.DieHardHP));
				else if (hasPerk(PerkLib.EnemyGroupType)) min -= (maxHP() * 0.05 * perkv1(PerkLib.DieHardHP));
				else min -= (maxHP() * 0.01 * perkv1(PerkLib.DieHardHP));
			}
			if (hasPerk(PerkLib.EnemyEliteType)) {
				min -= maxHP() * 0.025;
				min -= (750 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (hasPerk(PerkLib.EnemyChampionType)) {
				min -= maxHP() * 0.05;
				min -= (1500 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (hasPerk(PerkLib.EnemyBossType)) {
				min -= maxHP() * 0.075;
				min -= (2250 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (hasPerk(PerkLib.SPSurvivalTrainingX)) {
				var limit:Number = perkv1(PerkLib.SPSurvivalTrainingX) * 10;
				var bonus:Number = Math.round((level - 1) / 3);
				if (bonus > limit) bonus = limit;
				min -= (maxHP() * 0.01 * bonus);
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
			if (this.soulforce > maxOverSoulforce()) this.soulforce = maxOverSoulforce();
		}
		public function addMana(mana:Number):void {
			this.mana += mana;
			if (this.mana > maxOverMana()) this.mana = maxMana();
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
			if (hasPerk(PerkLib.GreyMageApprentice)) temp += 20;
			if (hasPerk(PerkLib.GreyMage)) temp += 40;
			if (hasPerk(PerkLib.GreyArchmage)) temp += 80;
			if (hasPerk(PerkLib.GrandGreyArchmage)) temp += 160;
			if (hasPerk(PerkLib.GrandGreyArchmage2ndCircle)) temp += 320;
			if (hasPerk(PerkLib.InhumanDesireI)) temp += Math.round(this.lib * 3 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.JobCourtesan)) temp += 60;
			if (hasPerk(PerkLib.JobSeducer)) temp += 30;
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) temp += (150 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) temp += (225 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) temp += (300 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) temp += (375 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) temp += (450 * (1 + newGamePlusMod()));
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
			if (this.level < 6) {
				if (hasPerk(PerkLib.EnemyForBeginnersType)) temp *= 0.1;
				else temp *= 0.6;
			}
			temp = Math.round(temp);
			if (temp < (100 + (30 * newGamePlusMod()))) temp = (100 + (30 * newGamePlusMod()));
			return temp;
		}
		public override function maxOverLust():Number {
			var max1:Number = Math.round(maxLust_base()*maxLust_mult());
			var max2:Number = 1;
			if (hasPerk(PerkLib.MunchkinAtWork)) max2 += 0.1;
			if (hasPerk(PerkLib.SPSurvivalTrainingX)) {
				var limit:Number = perkv1(PerkLib.SPSurvivalTrainingX) * 10;
				var bonus:Number = Math.round((level - 1) / 3);
				if (bonus > limit) bonus = limit;
				max2 += (0.01 * bonus);
			}
			max1 *= max2;//~150%
			max1 = Math.round(max1);
			return max1;
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
			if (hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) temp += (250 * (1 + newGamePlusMod()));
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) temp += (300 * (1 + newGamePlusMod()));
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
			var temp:Number = 50 + this.level * 5 + this.bonusSoulforce * 2;
			if (hasPerk(PerkLib.JobSoulCultivator)) temp += 50;
			if (hasPerk(PerkLib.SoulApprentice)) {
				temp += 30;
				if (this.level >= 3) temp += 30;
				if (this.level >= 6) temp += 30;
			}
			if (hasPerk(PerkLib.SoulPersonage)) {
				if (this.level >= 9) temp += 45;
				if (this.level >= 12) temp += 45;
				if (this.level >= 15) temp += 45;
			}
			if (hasPerk(PerkLib.SoulWarrior)) {
				if (this.level >= 18) temp += 60;
				if (this.level >= 21) temp += 60;
				if (this.level >= 24) temp += 60;
			}
			if (hasPerk(PerkLib.SoulSprite)) {
				if (this.level >= 27) temp += 90;
				if (this.level >= 30) temp += 90;
				if (this.level >= 33) temp += 90;
			}
			if (hasPerk(PerkLib.SoulScholar)) {
				if (this.level >= 36) temp += 120;
				if (this.level >= 39) temp += 120;
				if (this.level >= 42) temp += 120;
			}
			if (hasPerk(PerkLib.SoulGrandmaster)) {
				if (this.level >= 45) temp += 150;
				if (this.level >= 48) temp += 150;
				if (this.level >= 51) temp += 150;
			}
			if (hasPerk(PerkLib.SoulElder)) {
				if (this.level >= 54) temp += 210;
				if (this.level >= 57) temp += 210;
				if (this.level >= 60) temp += 210;
				if (this.level >= 63) temp += 210;
			}
			if (hasPerk(PerkLib.InsightfulResourcesI)) temp += Math.round((this.wis*5) * (1 + newGamePlusMod()));
			var multimax:Number = 1;
			if (hasPerk(PerkLib.DaoistApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) temp += 50;
				if (hasPerk(PerkLib.SoulPersonage)) temp += 50;
				if (hasPerk(PerkLib.SoulWarrior)) temp += 50;
				multimax += 0.05;
			}
			if (hasPerk(PerkLib.DaoistWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) temp += 100;
				if (hasPerk(PerkLib.SoulScholar)) temp += 100;
				if (hasPerk(PerkLib.SoulGrandmaster)) temp += 100;
				multimax += 0.05;
			}
			if (hasPerk(PerkLib.DaoistElderStage)) {
				if (hasPerk(PerkLib.SoulElder)) temp += 200;
				if (hasPerk(PerkLib.SoulExalt)) temp += 200;
				if (hasPerk(PerkLib.SoulOverlord)) temp += 200;
				multimax += 0.1;
			}
			if (hasPerk(PerkLib.DaoistOverlordStage)) {
				if (hasPerk(PerkLib.SoulTyrant)) temp += 300;
				if (hasPerk(PerkLib.SoulKing)) temp += 300;
				if (hasPerk(PerkLib.SoulEmperor)) temp += 300;
				//if (hasPerk(PerkLib.SoulAncestor)) temp += 300;
				multimax += 0.1;
			}
			if (hasPerk(PerkLib.DeityJobMunchkin)) multimax += 0.1;
			if (hasPerk(PerkLib.LimitBreakerSoul1stStage)) multimax += 0.05;
			if (hasPerk(PerkLib.LimitBreakerSoul2ndStage)) multimax += 0.1;
			temp *= multimax;
			temp *= stats_multi_based_on_misc();
			temp = Math.round(temp);
			if ((hasPerk(PerkLib.EnemyTrueDemon) && (!hasPerk(PerkLib.Phylactery) || !hasPerk(PerkLib.EnemyTrueAngel))) || (hasPerk(PerkLib.EnemyConstructType) && !hasPerk(PerkLib.Sentience))) temp = 0;
			return temp;
		}
		public override function maxOverSoulforce():Number {
			var max1:Number = maxSoulforce();
			var max2:Number = 1;
			if (hasPerk(PerkLib.MunchkinAtWork)) max2 += 0.1;
			max1 *= max2;//~110%
			max1 = Math.round(max1);
			return max1;
		}

		public override function maxWrath():Number {
			//Base wrath
			var temp:Number = 500 + this.level * 5 + this.bonusWrath * 5;
			if (hasPerk(PerkLib.WeaponNormalDoubleAttack)) temp += 50;
			if (hasPerk(PerkLib.WeaponNormalTripleAttack)) temp += 50;
			if (hasPerk(PerkLib.WeaponNormalQuadrupleAttack)) temp += 50;
			if (hasPerk(PerkLib.WeaponNormalPentaAttack)) temp += 50;
			if (hasPerk(PerkLib.WeaponNormalHexaAttack)) temp += 50;
			if (hasPerk(PerkLib.WeaponLargeDoubleAttack)) temp += 100;
			if (hasPerk(PerkLib.WeaponLargeTripleAttack)) temp += 100;
			if (hasPerk(PerkLib.FeralArmor)) temp += 100;
			if (hasPerk(PerkLib.WeaponClawsClawTraining)) temp += 100;
			if (hasPerk(PerkLib.WeaponClawsExtraClawAttack)) temp += 150;
			if (hasPerk(PerkLib.WeaponClawsMultiClawAttack)) temp += 200;
			if (hasPerk(PerkLib.WeaponClawsClawingFlurry)) temp += 250;
			if (hasPerk(PerkLib.WeaponClawsSavageRend)) temp += 300;
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
			if (hasPerk(PerkLib.FuelForTheFire)) temp += 1500;
			if (hasPerk(PerkLib.Rage)) temp += 2000;
			if (hasPerk(PerkLib.Anger)) temp += 2500;
			if (hasPerk(PerkLib.TooAngryToDie)) temp += 3000;
			if (hasPerk(PerkLib.EndlessRage)) temp += 3500;
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
			if (hasPerk(PerkLib.MunchkinAtWork)) temp2 += 0.1;
			temp1 *= temp2;
			temp1 = Math.round(temp1);
			return temp1;
		}

		public override function maxMana():Number {
			//Base mana
			var temp:Number = 300 + this.level * 10 + this.bonusMana * 3;
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
			if (hasPerk(PerkLib.GrandGreyArchmage) && inte >= 225) temp += 600;
			if (hasPerk(PerkLib.GrandGreyArchmage2ndCircle) && inte >= 275) temp += 900;
			if (hasPerk(PerkLib.GrandMage) && inte >= 75) temp += 135;
			if (hasPerk(PerkLib.GreyArchmage) && inte >= 175) temp += 450;
			if (hasPerk(PerkLib.GreyMage) && inte >= 125) temp += 300;
			if (hasPerk(PerkLib.GreyMageApprentice) && inte >= 75) temp += 150;
			if (hasPerk(PerkLib.Mage) && inte >= 50) temp += 90;
			if (hasPerk(PerkLib.Spellpower) && inte >= 50) temp += 45;
			if (hasPerk(PerkLib.JobSorcerer)) temp += 45;
			if (hasPerk(PerkLib.JobHealer)) temp += 90;
			if (hasPerk(PerkLib.SpellpowerGrey) && inte >= 50) temp += 75;
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
		public override function maxOverMana():Number {
			var max1:Number = maxMana();
			var max2:Number = 1;
			if (hasPerk(PerkLib.PrestigeJobGreySage)) max2 += 0.1;
			if (hasPerk(PerkLib.Equilibrium)) max2 += 0.1;
			if (hasPerk(PerkLib.MunchkinAtWork)) max2 += 0.1;
			max1 *= max2;//~130%
			max1 = Math.round(max1);
			return max1;
		}

		private function stats_multi_based_on_misc():Number {
			var temp:Number = 1;
			if (hasPerk(PerkLib.EnemyEliteType)) temp += 1;
			if (hasPerk(PerkLib.EnemyChampionType)) temp += 2;
			if (hasPerk(PerkLib.EnemyBossType)) temp += 3;
			if (this.level >= 25) temp *= 2;
			if (this.level >= 50) temp *= 3;
			if (this.level >= 75) temp *= 4;
			if (this.level >= 100) temp *= 5;
			if (this.level >= 125) temp *= 6;
			if (this.level >= 150) temp *= 7;
			if (this.level >= 175) temp *= 8;
			if (this.level >= 200) temp *= 9;
			if (hasPerk(PerkLib.EnemyForBeginnersType)) {
				if (flags[kFLAGS.GAME_DIFFICULTY] == 1) temp *= 1.1;
				if (flags[kFLAGS.GAME_DIFFICULTY] == 2) temp *= 1.25;
				if (flags[kFLAGS.GAME_DIFFICULTY] == 3) temp *= 1.5;
				if (flags[kFLAGS.GAME_DIFFICULTY] == 4) temp *= 2;
				if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 1) temp *= 1.5;
				if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 2) temp *= 2;
				if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 3) temp *= 3;
				if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 4) temp *= 5;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 1) temp *= 1.2;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 2) temp *= 1.4;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 3) temp *= 1.6;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 4) temp *= 1.8;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 5) temp *= 2;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 6) temp *= 2.2;//dla gier powyżej obecnego ostatniego NG+ posiadającego nowe perki dla graczy
			}
			else {
				if (flags[kFLAGS.GAME_DIFFICULTY] == 1) temp *= 2;
				if (flags[kFLAGS.GAME_DIFFICULTY] == 2) temp *= 5;
				if (flags[kFLAGS.GAME_DIFFICULTY] == 3) temp *= 10;
				if (flags[kFLAGS.GAME_DIFFICULTY] == 4) temp *= 25;
				if (hasPerk(PerkLib.EnemyBossType)) {
					if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 1) temp *= 10;
					if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 2) temp *= 40;
					if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 3) temp *= 200;
					if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 4) temp *= 1600;
				}
				else {
					if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 1) temp *= 5;
					if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 2) temp *= 10;
					if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 3) temp *= 25;
					if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 4) temp *= 100;
					
				}
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 1) temp *= 2;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 2) temp *= 3;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 3) temp *= 4;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 4) temp *= 5;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 5) temp *= 6;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 6) temp *= 7;//dla gier powyżej obecnego ostatniego NG+ posiadającego nowe perki dla graczy
			}
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) temp = 1;
			return temp;
		}

		public override function damagePercent():Number {
			var mult:Number = 100;
			var armorMod:Number = armorDef;
			//--BASE--
			//Modify armor rating based on melee weapons
			if ((game.player.weaponName.indexOf("staff") != -1 && game.player.hasPerk(PerkLib.StaffChanneling) )) {
				armorMod = 0;
			} else if (game.player.weapon.hasSpecial(ItemConstants.WP_AP10)) {
				if (armorMod < 100) armorMod -= 10;
				else armorMod *= 0.9;
			} else if (game.player.weapon.hasSpecial(ItemConstants.WP_AP30)) {
				armorMod *= 0.7;
			} else if (game.player.weapon.hasSpecial(ItemConstants.WP_AP40)) {
				armorMod *= 0.6;
			} else if (game.player.weapon.hasSpecial(ItemConstants.WP_AP45)) {
				armorMod *= 0.45;
			} else if (game.player.weapon.hasSpecial(ItemConstants.WP_AP60)) {
				armorMod *= 0.4;
			} else if (game.player.weapon.hasSpecial(ItemConstants.WP_AP100)) {
				armorMod = 0;
			}
			if (game.player.hasPerk(PerkLib.LungingAttacks)) armorMod *= 0.5;
			if (armorMod < 0) armorMod = 0;
			mult -= armorMod;
			mult -= resPhysicalStat.value;
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
			mult -= resPhysicalStat.value;
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
			if (hasPerk(PerkLib.NakedTruth) && spe >= 75 && lib >= 60) {
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
			mult -= resMagicStat.value;
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
			return !hasPerk(PerkLib.EnemyConstructType) || !hasPerk(PerkLib.EnemyPlantType) || !hasPerk(PerkLib.EnemyGooType) || !hasPerk(PerkLib.EnemyGhostType);
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
		public function calcLightningDamage():int{
			return player.reduceLightningDamage(eBaseDamage());
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
			//var diff2:Number = this.level - playerLevel; - odkomentować jak nie bedzie potrzebne rozwiązanie poniżej ^^
			var diff2:Number = this.level;
			if (playerLevel > 90) playerLevel = 90;
			diff2 -= playerLevel;
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
			if (diff2 < -19) {
				var minXP:Number = 1;
				if (hasPerk(PerkLib.ShieldWielder)) minXP *= 1.5;
				if (hasPerk(PerkLib.EnemyBossType)) minXP *= 2;
				if (hasPerk(PerkLib.EnemyHugeType)) minXP *= 2;
				if (hasPerk(PerkLib.EnemyTrueAngel)) minXP *= 3;
				if (hasPerk(PerkLib.EnemyGigantType)) minXP *= 4;
				if (hasPerk(PerkLib.EnemyColossalType)) minXP *= 6;
				if (hasPerk(PerkLib.EnemyGroupType)) minXP *= 5;
				if (hasPerk(PerkLib.EnemyLargeGroupType)) minXP *= 10;
				if (hasPerk(PerkLib.Enemy300Type)) minXP *= 15;
				if (this.humanityBoostExpValue() > 0) minXP += this.humanityBoostExpValue();
				return Math.round(minXP);
			}
			return Math.round(((this.additionalXP + this.baseXP()) * this.bonusXP() * player.XPMultiplier * difference * multiplier) + this.humanityBoostExpValue());
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
		public function humanityBoostExpValue():Number
		{
			return HumanRace.xpBoost(game.player, game.player.humanScore());
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
			///*OPTIONAL*/ //this.bodyColor = "bodyColor"; // default "albino"
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
				if (phase is Boolean && !phase) return false;
			}
			return true;
		}
		public function missingInits():String{
			var result:String = "";
			for (var phase:String in initsCalled){
				if (initsCalled[phase] is Boolean && !initsCalled[phase]){
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
			error += Utils.validateNonNegativeNumberFields(this, "Monster.validate", ["lustVuln"]);
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
		 * @param display Whether to print the number or not
		 * @return damage
		 */
		public function eOneAttack(display:Boolean = false):int
		{
			//Determine damage - str modified by enemy toughness!
			if (hasStatusEffect(StatusEffects.FlameBlade)) {
				var damageFlameBlade:int = calcFireDamage();
				if (damageFlameBlade > 0) player.takeFireDamage(damageFlameBlade);
			}
			if (hasStatusEffect(StatusEffects.ElectrifyWeapon)) {
				var damageElectrifyWeapon:int = calcLightningDamage();
				if (damageElectrifyWeapon > 0) player.takeLightningDamage(damageElectrifyWeapon);
			}
			else {
				var damage:int = calcDamage();
				if (damage > 0) damage = player.takePhysDamage(damage, display);
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
					if (!plural) outputText("\n[Themonster] brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed.");
					else outputText("\n[Themonster] brush against your exposed skin and jerk back in surprise, coloring slightly from seeing so much of you revealed.");
					lust += 5 * lustVuln;
				}
			}
		}

		public function outputAttack(damage:int):void
		{
			if (damage <= 0) {
				//Due to toughness or armor...
				if (rand(player.armorDef + player.tou) < player.armorDef) outputText("You absorb and deflect every " + weaponVerb + " with your " + (!player.armor.isNothing ? player.armor.name : player.armorName) + ".");
				else {
					if (plural) outputText("You deflect and block every " + weaponVerb + " [themonster] throw at you. ");
					else outputText("You deflect and block every " + weaponVerb + " [themonster] throws at you. ");
				}
			}
			else if (damage < 6) outputText("You are struck a glancing blow by [themonster]! ");
			else if (damage < 11) {
				outputText("[Themonster] wound");
				if (!plural) outputText("s");
				outputText(" you! ");
			}
			else if (damage < 21) {
				outputText("[Themonster] stagger");
				if (!plural) outputText("s");
				outputText(" you with the force of " + pronoun3 + " " + weaponVerb + "! ");
			}
			else if (damage > 20) {
				outputText("[Themonster] <b>mutilate");
				if (!plural) outputText("s");
				outputText("</b> you with " + pronoun3 + " powerful " + weaponVerb + "! ");
			}
			if (damage > 0) {
				if (flags[kFLAGS.ENEMY_CRITICAL] > 0) outputText("<b>Critical hit! </b>");
				SceneLib.combat.CommasForDigits(damage);
			}
			else outputText("<b>([font-miss]" + damage + "</font>)</b>");
		}

		/**
		 * @return true if continue with attack
		 */
		protected function handleBlind():Boolean
		{
			if (hasStatusEffect(StatusEffects.LoweredAccuracy) && rand(100) < statusEffectv1(StatusEffects.LoweredAccuracy)) {
				if (weaponVerb == "tongue-slap") outputText("[Themonster] completely misses you with a thrust from "+pronoun3+" tongue!\n");
				else outputText("[Themonster] completely misses you with an attack!\n");
				return false;
			}
			else if (rand(3) < 2) {
				if (weaponVerb == "tongue-slap") outputText("[Themonster] completely misses you with a thrust from "+pronoun3+" tongue!\n");
				else outputText("[Themonster] completely misses you with a blind attack!\n");
				return false;
			}
			return true;
		}

		/**
		 * print something about how we miss the player
		 */
		protected function outputPlayerDodged(dodge:int):void
		{
			if (dodge==1) outputText("You narrowly avoid [themonster]'s " + weaponVerb + "!\n");
			else if (dodge==2) outputText("You dodge [themonster]'s " + weaponVerb + " with superior quickness!\n");
			else {
				outputText("You deftly avoid " + a + short);
				if (plural) outputText("'");
				else outputText("'s");
				outputText(" slow " + weaponVerb + ".\n");
			}
		}

		private function playerDodged():Boolean
		{
			//Check if player has shadow clones or similar gimmick
			if (player.hasStatusEffect(StatusEffects.MirrorImage) && !hasPerk(PerkLib.TrueSeeing)) {
			}
			if (player.hasStatusEffect(StatusEffects.MirrorImage) && rand(1+player.statusEffectv1(StatusEffects.MirrorImage)) != 1){
				outputText("Unable to determine the real one from the fake");
				if (player.statusEffectv1(StatusEffects.MirrorImage) >= 2)outputText("s");
				outputText(", your opponent");
				if (plural)outputText("s");
				outputText(" targets");
				if (player.statusEffectv1(StatusEffects.MirrorImage) >= 2)outputText(" one of your many illusions");
				else outputText(" your remaining illusion");
				outputText(" instead causing the fake to vanish.");
				player.addStatusValue(StatusEffects.MirrorImage, 1,-1);
				if (player.statusEffectv1(StatusEffects.MirrorImage) >= 1) outputText(" You now have "+player.statusEffectv1(StatusEffects.MirrorImage)+" illusion left.")
				if (player.statusEffectv1(StatusEffects.MirrorImage) == 0) {
					player.removeStatusEffect(StatusEffects.MirrorImage);
					outputText(" Your last illusion now destroyed, you will now have to be cautious of your opponent attacks.");
				}
				return true;
			} else {
				//Determine if dodged!
				var dodge:int = player.speedDodge(this);
				if (dodge>0) {
					outputPlayerDodged(dodge);
					return true;
				}
				var evasionResult:String = player.getEvasionReason(false); // use separate function for speed dodge for expanded dodge description
				//Determine if evaded
				if (evasionResult == EVASION_EVADE) {
					outputText("Using your skills at evading attacks, you anticipate and sidestep [themonster]'");
					if (!plural) outputText("s");
					outputText(" attack.\n");
					return true;
				}
				//("Misdirection"
				if (evasionResult == EVASION_MISDIRECTION) {
					outputText("Using Raphael's teachings, you anticipate and sidestep [themonster]' attacks.\n");
					return true;
				}
				//Determine if cat'ed
				if (evasionResult == EVASION_FLEXIBILITY) {
					outputText("With your incredible flexibility, you squeeze out of the way of [themonster]");
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
						outputText("[Themonster] goes in for a strike, but Zenji is able to intervene, blocking any opening they have on you, leaving you safe behind him.\n\n");
						outputText("\"<i>You’re gonna have ta try harda dan dat!</i>\" Zenji shouts.");
						return true;
					}
				}

				//Parry with weapon
				if (combatParry()) {
					outputText("You manage to block [themonster]");
					if (plural) outputText("' attacks ");
					else outputText("'s attack ");
					outputText("with your [weapon].\n");
					if (game.player.hasPerk(PerkLib.TwinRiposte) && (game.player.weaponSpecials("Dual") || game.player.weaponSpecials("Dual Large")) && game.player.wrath >= 2) {
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
					outputText("You block [themonster]'s " + weaponVerb + " with your [shield]! ");
					if (game.player.hasPerk(PerkLib.ShieldCombat) && game.player.fatigue >= 20) {
						player.createStatusEffect(StatusEffects.CounterAction,1,0,0,0);
						SceneLib.combat.pspecials.shieldBash();
					}
					SceneLib.combat.ShieldsStatusProcs();
					return true;
				}
				return false;
			}
		}

		public function monsterIsStunned():Boolean {
			var effects:Array = [
				StatusEffects.Stunned,
				StatusEffects.FrozenSolid,
				StatusEffects.StunnedTornado,
				StatusEffects.Polymorphed,
				StatusEffects.HypnosisNaga,
				StatusEffects.Sleep,
				StatusEffects.InvisibleOrStealth,
				StatusEffects.Fascinated,
			]
			for each (var effect:StatusEffectType in effects) if (hasStatusEffect(effect)) return true;
			return false;
		}

		public function monsterIsConstricted():Boolean {
			var effects:Array = [
				StatusEffects.ConstrictedWhip,
				StatusEffects.Constricted,
				StatusEffects.ConstrictedScylla,
				StatusEffects.GooEngulf,
				StatusEffects.EmbraceVampire,
				StatusEffects.ManticorePlug,
				StatusEffects.Pounce,
				StatusEffects.PouncedByCompanion,
				StatusEffects.GrabBear,
				StatusEffects.CancerGrab,
				StatusEffects.MysticWeb,
				StatusEffects.Entangled,
			]
			for each (var effect:StatusEffectType in effects) if (hasStatusEffect(effect)) return true;
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
			if (SceneLib.exgartuan.exgartuanCombatUpdate()) EngineCore.outputText("\n\n");
			if (monsterIsConstricted()) {
				if (!handleConstricted()) return;
			}
			if (hasStatusEffect(StatusEffects.OrcaPlay)) {
				interruptAbility();
				return;
			}
			if (hasStatusEffect(StatusEffects.Straddle)) {
				interruptAbility();
				return;
			}
			if (hasStatusEffect(StatusEffects.Provoke)) {
				interruptAbility();
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
				interruptAbility();
				outputText("\n\nYour opponent is still stunned from the powerful blow of your tail.");
				createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
				return;
			}
			performCombatAction();
		}

		/**
		 * Called if monster is constricted. Should return true if constriction is ignored and need to proceed with ai
		 */
		protected function handleConstricted():Boolean
		{
			interruptAbility();
			if (hasStatusEffect(StatusEffects.Entangled)) {
				if (player.hasPerk(PerkLib.ControlFreak)) ControlFreakStacking();
				return false;
			}
			if (hasStatusEffect(StatusEffects.MysticWeb)) {
				EngineCore.outputText("[Themonster] struggle to get free from your web!");
				if (statusEffectv1(StatusEffects.MysticWeb) <= 0) {
					EngineCore.outputText("[Themonster] struggle to get free and manage to shove you break off your webbing.");
					if (player.hasStatusEffect(StatusEffects.ControlFreak)) removeStatusEffect(StatusEffects.ControlFreak);
					removeStatusEffect(StatusEffects.MysticWeb);
				}
				addStatusValue(StatusEffects.MysticWeb, 1, -1);
				if (player.hasPerk(PerkLib.ControlFreak)) ControlFreakStacking();
				return false;
			}
			if (hasStatusEffect(StatusEffects.Pounce)) {
				EngineCore.outputText("[Themonster] struggle to get free.");
				if (statusEffectv1(StatusEffects.Pounce) <= 0) {
					EngineCore.outputText("[Themonster] struggle to get free and manage to shove you off.");
					if (hasStatusEffect(StatusEffects.DisplacerPlug)) removeStatusEffect(StatusEffects.DisplacerPlug);
					removeStatusEffect(StatusEffects.Pounce);
				}
				addStatusValue(StatusEffects.Pounce, 1, -1);
				return false;
			}
			if (hasStatusEffect(StatusEffects.PouncedByCompanion)) {
				EngineCore.outputText("[Themonster] struggle to get free.");
				if (statusEffectv1(StatusEffects.PouncedByCompanion) <= 0) {
					EngineCore.outputText("[Themonster] struggle to get free and manage to shove your companion off.");
					removeStatusEffect(StatusEffects.PouncedByCompanion);
				}
				addStatusValue(StatusEffects.PouncedByCompanion, 1, -1);
				return false;
			}
			if (hasStatusEffect(StatusEffects.ManticorePlug)) {
				EngineCore.outputText("[Themonster] pulls to unplug your tail from [monster his] "+cockDescriptShort()+".");
				if (statusEffectv1(StatusEffects.ManticorePlug) <= 0) {
					EngineCore.outputText("[Themonster] pulls to unplug your tail from [monster his] "+cockDescriptShort()+" and manages with great efforts to get it off.");
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
				EngineCore.outputText("[Themonster] struggle to unplug your tentacles suckers.");
				if (statusEffectv1(StatusEffects.DisplacerPlug) <= 0) {
					EngineCore.outputText("[Themonster] struggle to unplug your tentacles suckers from [monster his] "+breastDescript(0)+" and manages with great efforts to get them off.");
					if (statusEffectv3(StatusEffects.DisplacerPlug) >= 1) {
						EngineCore.outputText("You lick your paws in delight still feeling the remains of the recent milk flow in your tentacles.");
					} else {
						EngineCore.outputText("You growl in annoyance at your denied meal.");
					}
					removeStatusEffect(StatusEffects.DisplacerPlug);
				}
				addStatusValue(StatusEffects.DisplacerPlug, 1, -1);
				return false;
			}
			if (hasStatusEffect(StatusEffects.SlimeInsert)) {
				EngineCore.outputText("[Themonster] struggle to force you out of [monster his] body.");
				if (statusEffectv1(StatusEffects.SlimeInsert) <= 0) {
					EngineCore.outputText("[Themonster] struggle to force you out of [monster his] body.");
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
			else if (LowerBody.hasTentacles(player)) {
			EngineCore.outputText("Your prey pushes at your tentacles, twisting and writhing in an effort to escape from your tentacle's tight bonds.");
			if (statusEffectv1(StatusEffects.ConstrictedScylla) <= 0) {
				EngineCore.outputText("  [Themonster] proves to be too much for your tentacles to handle, breaking free of your tightly bound coils.");
				if (player.hasStatusEffect(StatusEffects.ControlFreak)) removeStatusEffect(StatusEffects.ControlFreak);
				removeStatusEffect(StatusEffects.ConstrictedScylla);
			}
			addStatusValue(StatusEffects.ConstrictedScylla, 1, -1);
			if (player.hasPerk(PerkLib.ControlFreak)) ControlFreakStacking();
			return false;
			}
			else if (LowerBody.hasPincers(player)) {
				EngineCore.outputText("Your prey pushes at your pincer, twisting and writhing in an effort to escape from your iron grip.");
				if (statusEffectv1(StatusEffects.CancerGrab) <= 0) {
					EngineCore.outputText("  [Themonster] proves to be too much for your pincer to handle, breaking free of your iron grip.");
					removeStatusEffect(StatusEffects.CancerGrab);
				}
				addStatusValue(StatusEffects.CancerGrab, 1, -1);
				return false;
			}
			else if (LowerBody.isGoo(player)) {
			EngineCore.outputText("[Themonster] struggle in your fluid form kicking and screaming to try and get out.");
			if (statusEffectv1(StatusEffects.GooEngulf) <= 0) {
				EngineCore.outputText("  [Themonster] proves to be too much for your slimy body to handle, breaking free of your fluids.");
				if (player.hasStatusEffect(StatusEffects.ControlFreak)) removeStatusEffect(StatusEffects.ControlFreak);
				removeStatusEffect(StatusEffects.GooEngulf);
			}
			addStatusValue(StatusEffects.GooEngulf, 1, -1);
			if (player.hasPerk(PerkLib.ControlFreak)) ControlFreakStacking();
			return false;
			}
			else if (hasStatusEffect(StatusEffects.ConstrictedWhip)) {
			EngineCore.outputText("[Themonster] pushes, twisting and writhing in an effort to escape from your whip's tight bonds.");
			if (statusEffectv1(StatusEffects.ConstrictedWhip) <= 0) {
				EngineCore.outputText("  [Themonster] proves to be too much for your whip to handle, breaking free of your tightly bound whip coils.");
				if (player.hasStatusEffect(StatusEffects.ControlFreak)) removeStatusEffect(StatusEffects.ControlFreak);
				removeStatusEffect(StatusEffects.ConstrictedWhip);
			}
			addStatusValue(StatusEffects.ConstrictedWhip, 1, -1);
			if (player.hasPerk(PerkLib.ControlFreak)) ControlFreakStacking();
			return false;
			}
			else if (hasStatusEffect(StatusEffects.EmbraceVampire)) {
			if (statusEffectv1(StatusEffects.EmbraceVampire) <= 0) {
				EngineCore.outputText("You try to maintain your grip but [themonster] shove you off escaping your embrace!");
				removeStatusEffect(StatusEffects.EmbraceVampire);
			}
			else EngineCore.outputText("[Themonster] struggle but you manage to maintain the embrace.");
			addStatusValue(StatusEffects.EmbraceVampire, 1, -1);
			return false;
			}
			else if (hasStatusEffect(StatusEffects.GrabBear)) {
			if (statusEffectv1(StatusEffects.GrabBear) <= 0) {
				EngineCore.outputText("You try to maintain your grip but [themonster] shove you off escaping your grab!");
				removeStatusEffect(StatusEffects.GrabBear);
			}
			else EngineCore.outputText("[Themonster] struggle but you manage to maintain the grab.");
			addStatusValue(StatusEffects.GrabBear, 1, -1);
			return false;
			}
			else {
			EngineCore.outputText("Your prey pushes at your tail, twisting and writhing in an effort to escape from your tail's tight bonds.");
			if (statusEffectv1(StatusEffects.Constricted) <= 0) {
				EngineCore.outputText("  [Themonster] proves to be too much for your tail to handle, breaking free of your tightly bound coils.");
				if (player.hasStatusEffect(StatusEffects.ControlFreak)) removeStatusEffect(StatusEffects.ControlFreak);
				removeStatusEffect(StatusEffects.Constricted);
			}
			addStatusValue(StatusEffects.Constricted, 1, -1);
			if (player.hasPerk(PerkLib.ControlFreak)) ControlFreakStacking();
			return false;
			}
		}
		private function ControlFreakStacking():void {
			if (player.hasStatusEffect(StatusEffects.ControlFreak)) player.addStatusValue(StatusEffects.ControlFreak, 1, 0.5);
			else player.createStatusEffect(StatusEffects.ControlFreak, 1.5, 0, 0, 0);
		}

		/**
		 * Called if monster is under fear. Should return true if fear ignored and need to proceed with ai
		 */
		protected function handleFear():Boolean
		{
			interruptAbility();
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
				if (plural) EngineCore.outputText("[Themonster] are too busy shivering with fear to fight.");
				else EngineCore.outputText("[Themonster] is too busy shivering with fear to fight.");
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
				EngineCore.outputText("[Themonster] is still caught in the tornado.");
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
			else if (hasStatusEffect(StatusEffects.Polymorphed)) EngineCore.outputText("[Themonster] is fighting against the curse.");
			else if (hasStatusEffect(StatusEffects.MonsterAttacksDisabled)) EngineCore.outputText("[Themonster] try to hit you but is unable to reach you!");
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
			if (!abilities || abilities.length == 0) {
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
			outputText("\n\nYou'll probably wake up in six hours or so, missing " + temp + " gems.");
			player.gems -= temp;
			EngineCore.doNext(SceneLib.camp.returnToCampUseSixHours);
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
			  	if(hasStatusEffect(StatusEffects.ImpUber)) {
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
				if (lustDelta == 0) outputText("\n\n[Themonster] seem unimpressed.");
				if (lustDelta > 0 && lustDelta < 4) outputText("\n[Themonster] look intrigued by what " + pronoun1 + " see.");
				if (lustDelta >= 4 && lustDelta < 10) outputText("\n[Themonster] definitely seem to be enjoying the show.");
				if (lustDelta >= 10 && lustDelta < 15) outputText("\n[Themonster] openly stroke " + pronoun2 + "selves as " + pronoun1 + " watch you.");
				if (lustDelta >= 15 && lustDelta < 20) outputText("\n[Themonster] flush hotly with desire, " + pronoun3 + " eyes filled with longing.");
				if (lustDelta >= 20) outputText("\n[Themonster] lick " + pronoun3 + " lips in anticipation, " + pronoun3 + " hands idly stroking " + pronoun3 + " bodies.");
			}
			else {
				if (lustDelta == 0) outputText("\n[Themonster] seems unimpressed.");
				if (lustDelta > 0 && lustDelta < 4) {
					if (plural) outputText("\n[Themonster] looks intrigued by what " + pronoun1 + " see.");
					else outputText("\n[Themonster] looks intrigued by what " + pronoun1 + " sees.");
				}
				if (lustDelta >= 4 && lustDelta < 10) outputText("\n[Themonster] definitely seems to be enjoying the show.");
				if (lustDelta >= 10 && lustDelta < 15) {
					if (plural) outputText("\n[Themonster] openly strokes " + pronoun2 + "selves as " + pronoun1 + " watch you.");
					else outputText("\n[Themonster] openly strokes " + pronoun2 + "self as " + pronoun1 + " watches you.");
				}
				if (lustDelta >= 15 && lustDelta < 20) {
					if (plural) outputText("\n[Themonster] flush hotly with desire, " + pronoun3 + " eyes filling with longing.");
					else outputText("\n[Themonster] flushes hotly with desire, " + pronoun3 + " eyes filled with longing.");
				}
				if (lustDelta >= 20) {
					if (plural) outputText("\n[Themonster] licks " + pronoun3 + " lips in anticipation, " + pronoun3 + " hands idly stroking " + pronoun3 + " own bodies.");
					else outputText("\n[Themonster] licks " + pronoun3 + " lips in anticipation, " + pronoun3 + " hands idly stroking " + pronoun3 + " own body.");
				}
			}
		}

		protected function applyTease(lustDelta:Number):void{
			lust += lustDelta;
			lustDelta = Math.round(lustDelta * 10)/10;
			outputText(" <b>([font-lust]" + lustDelta + "</font>)</b>");
			if (player.armor == armors.ELFDRES && flags[kFLAGS.COMBAT_TEASE_HEALING] == 0) {
				outputText(" You cool down a little bit ");
				player.takeLustDamage(Math.round(-lustDelta)/20);
			}
		}

		public function generateDebugDescription():String {
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
			result += ", "+pronoun1+" "+have+" "+bodyColor+" "+skinAdj+" "+skinDesc+
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
			result += Hehas + "str=" + this.strStat.core.value + ", tou=" + /*this.touStat.core.value*/this.touStat.max + ", spe=" + this.speStat.core.value +", inte=" + this.intStat.core.value +", wis=" + this.wisStat.core.value +", lib=" + this.libStat.core.value + ", sens=" + sens + ", cor=" + cor + ".\n";
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
			//Chance of armor if at level 1 pierce fetish
			if (!CoC.instance.plotFight && !this.noFetishDrop && flags[kFLAGS.PC_FETISH] == 1 && rand(10) == 0 && !player.hasItem(armors.SEDUCTA, 1) && !SceneLib.ceraphFollowerScene.ceraphIsFollower()) {
				return armors.SEDUCTA;
			}
			if (!game.plotFight && rand(200) == 0 && player.level >= 7) return consumables.BROBREW;
			if (!game.plotFight && rand(200) == 0 && player.level >= 7) return consumables.BIMBOLQ;
			if (!game.plotFight && rand(1000) == 0 && player.level >= 7) return consumables.RAINDYE;
			//Chance of eggs if Easter!
			if (!game.plotFight && rand(6) == 0 && SceneLib.holidays.isEaster()) {
				return randomChoice(
						consumables.BROWNEG,
						consumables.L_BRNEG,
						consumables.PURPLEG,
						consumables.L_PRPEG,
						consumables.BLUEEGG,
						consumables.L_BLUEG,
						consumables.PINKEGG,
						consumables.NPNKEGG,
						consumables.L_PNKEG,
						consumables.L_WHTEG,
						consumables.WHITEEG,
						consumables.BLACKEG,
						consumables.L_BLKEG
				);
			}
			
			// Dynamic items
			if (randomDropChance > Math.random()) {
				randomDropParams ||= {};
				if (!("level" in randomDropParams)) randomDropParams.level = this.level;
				var itype:ItemType = DynamicItems.randomItem(randomDropParams);
				if (itype != null) return itype;
			}
			
			return _drop.roll() as ItemType;
		}

		public function isNightTime():Boolean{
			return (CoC.instance.model.time.hours <= 5 || CoC.instance.model.time.hours >= 21);
		}

		public function combatRoundUpdate():void
		{

			//regeneration perks for monsters
			if (((hasPerk(PerkLib.Regeneration) || hasPerk(PerkLib.LizanRegeneration) || perkv1(IMutationsLib.LizanMarrowIM) >= 1 || perkv1(IMutationsLib.DraconicHeartIM) >= 3 || hasPerk(PerkLib.EnemyPlantType) || hasPerk(PerkLib.FleshBodyApprenticeStage) || hasPerk(PerkLib.MonsterRegeneration)
			|| hasPerk(PerkLib.HydraRegeneration) || hasPerk(PerkLib.Lifeline) || hasPerk(PerkLib.ImprovedLifeline) || hasPerk(PerkLib.GreaterLifeline) || hasPerk(PerkLib.EpicLifeline) || hasPerk(PerkLib.IcyFlesh) || hasPerk(PerkLib.HclassHeavenTribulationSurvivor) || hasPerk(PerkLib.GclassHeavenTribulationSurvivor)
			|| hasPerk(PerkLib.FclassHeavenTribulationSurvivor) || hasPerk(PerkLib.FFclassHeavenTribulationSurvivor) || hasPerk(PerkLib.EclassHeavenTribulationSurvivor) || hasStatusEffect(StatusEffects.MonsterRegen) || hasStatusEffect(StatusEffects.MonsterRegen2) || hasPerk(PerkLib.EnemyTrueAngel)
			|| hasPerk(PerkLib.EnemyTrueDemon)) && this.HP < maxOverHP()) || (hasStatusEffect(StatusEffects.MonsterVPT) && (this.HP < maxOverHP()) && (this.HP > minHP()))) {
				var healingPercent:Number = 0;
				var temp2:Number = 0;
				var temp3:Number = 0;
				if (hasPerk(PerkLib.Regeneration)) healingPercent += (0.5 * (1 + newGamePlusMod()));
				if (hasPerk(PerkLib.IceQueenGown) && player.isRace(Races.YUKIONNA)) healingPercent += 5;
				if (hasPerk(PerkLib.VladimirRegalia) && !isNightTime()) healingPercent -= 5;
				if (hasPerk(PerkLib.VladimirRegalia) && isNightTime()) healingPercent += 5;
				if (hasPerk(PerkLib.LizanRegeneration) && !hasStatusEffect(StatusEffects.RegenInhibitor)) healingPercent += 1.5;
				if (perkv1(IMutationsLib.LizanMarrowIM) >= 1 && !hasStatusEffect(StatusEffects.RegenInhibitor)) healingPercent += 0.5;
				if (perkv1(IMutationsLib.LizanMarrowIM) >= 2 && !hasStatusEffect(StatusEffects.RegenInhibitor)) healingPercent += 1;
				if (perkv1(IMutationsLib.LizanMarrowIM) >= 3 && !hasStatusEffect(StatusEffects.RegenInhibitor)) {
					healingPercent += 1.5;
					if (this.HP < (this.maxHP() * 0.25)) healingPercent += 4.5;
				}
				if (perkv1(IMutationsLib.DraconicHeartIM) >= 3) healingPercent += 1;
				if (hasPerk(PerkLib.HydraRegeneration) && !hasStatusEffect(StatusEffects.HydraRegenerationDisabled)) healingPercent += 1 * perkv1(PerkLib.HydraRegeneration);
				if (hasPerk(PerkLib.IcyFlesh)) healingPercent += 1;
				if (hasPerk(PerkLib.FleshBodyApprenticeStage)) healingPercent += 0.5;
				if (hasPerk(PerkLib.FleshBodyWarriorStage)) healingPercent += 0.5;
				if (hasPerk(PerkLib.FleshBodyElderStage)) healingPercent += 0.5;
				if (hasPerk(PerkLib.FleshBodyOverlordStage)) healingPercent += 0.5;
				if (hasPerk(PerkLib.FleshBodyTyrantStage)) healingPercent += 0.5;
				if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) healingPercent += 0.5;
				if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) healingPercent += 0.5;
				if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) healingPercent += 0.5;
				if (hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) healingPercent += 0.5;
				if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) healingPercent += 0.5;
				if (hasPerk(PerkLib.Ferocity) && this.HP < 1) healingPercent -= 1;
				if (hasPerk(PerkLib.EnemyPlantType)) healingPercent += 1;
				if (hasPerk(PerkLib.MonsterRegeneration) && !hasStatusEffect(StatusEffects.RegenInhibitor)) healingPercent += perkv1(PerkLib.MonsterRegeneration);
				if (hasStatusEffect(StatusEffects.MonsterRegen)) healingPercent += statusEffectv2(StatusEffects.MonsterRegen);
				if (hasPerk(PerkLib.Diehard) && !hasPerk(PerkLib.EpicDiehard) && this.HP < 1) healingPercent -= 1;
				if (perkv1(IMutationsLib.LizanMarrowIM) >= 3 && this.HP < 1) healingPercent -= 1;
				if (hasStatusEffect(StatusEffects.BloodRequiem) && healingPercent > 0) {
					if (hasPerk(PerkLib.EnemyConstructType) || hasPerk(PerkLib.EnemyElementalType) || hasPerk(PerkLib.EnemyFleshConstructType) || hasPerk(PerkLib.EnemyGhostType)) healingPercent *= 0.8;
					else if (hasPerk(PerkLib.EnemyPlantType)) healingPercent *= 0.5;
					else healingPercent *= 0.2;
				}
				if (hasPerk(PerkLib.EnemyTrueAngel)) healingPercent += 2;
				if (hasPerk(PerkLib.EnemyTrueDemon)) healingPercent += 1;
				if (flags[kFLAGS.GAME_DIFFICULTY] == 1) temp3 += 0.55;
				if (flags[kFLAGS.GAME_DIFFICULTY] == 2) temp3 += 0.25;
				if (flags[kFLAGS.GAME_DIFFICULTY] == 3) temp3 += 0.15;
				if (flags[kFLAGS.GAME_DIFFICULTY] == 4) temp3 += 0.08;
				if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 1) temp3 += 0.3;
				if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 2) temp3 += 0.2;
				if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 3) temp3 += 0.12;
				if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 4) temp3 += 0.05;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 1) temp3 += 0.6;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 2) temp3 += 0.47;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 3) temp3 += 0.4;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 4) temp3 += 0.36;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 5) temp3 += 0.34;
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 6) temp3 += 0.32;
				if (temp3 > 0) healingPercent *= temp3;
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
						outputText("To your surprise, Chi Chi’s wounds start closing! <b>([font-heal]+" + temp2 + "</font>)</b>.\n\n");
					}
					else {
						outputText("Due to natural regeneration " + short + " recover");
						if (plural) outputText("s");
						else outputText("ed");
						outputText(" some HP! ");
						SceneLib.combat.CommasForDigits(-temp2);
						outputText(".\n\n")
					}
					addHP(temp2);
				}
			}
			//soulforce and mana regeneration for monsters
			if (hasPerk(PerkLib.JobSoulCultivator) && this.soulforce < maxOverSoulforce()) {
				var soulforceRecovery:Number = 0;
				var soulforceRecoveryMulti:Number = 1;
				if (hasPerk(PerkLib.JobSoulCultivator)) soulforceRecovery += 4;
				if (hasPerk(PerkLib.SoulApprentice)) soulforceRecovery += 2;
				if (hasPerk(PerkLib.SoulPersonage)) soulforceRecovery += 2;
				if (hasPerk(PerkLib.SoulWarrior)) soulforceRecovery += 2;
				if (hasPerk(PerkLib.SoulSprite)) soulforceRecovery += 3;
				if (hasPerk(PerkLib.SoulScholar)) soulforceRecovery += 3;
				if (hasPerk(PerkLib.SoulGrandmaster)) soulforceRecovery += 3;
				if (hasPerk(PerkLib.SoulElder)) soulforceRecovery += 4;
				if (hasPerk(PerkLib.SoulExalt)) soulforceRecovery += 4;
				if (hasPerk(PerkLib.SoulOverlord)) soulforceRecovery += 4;
				if (hasPerk(PerkLib.SoulTyrant)) soulforceRecovery += 5;
				if (hasPerk(PerkLib.SoulKing)) soulforceRecovery += 5;
				if (hasPerk(PerkLib.SoulEmperor)) soulforceRecovery += 5;
				if (hasPerk(PerkLib.SoulAncestor)) soulforceRecovery += 6;
				if (hasPerk(PerkLib.DaoistApprenticeStage)) soulforceRecoveryMulti += 0.5;
				if (hasPerk(PerkLib.DaoistWarriorStage)) soulforceRecoveryMulti += 0.5;
				if (hasPerk(PerkLib.DaoistElderStage)) soulforceRecoveryMulti += 1;
				if (hasPerk(PerkLib.DaoistOverlordStage)) soulforceRecoveryMulti += 1;
				if (perkv1(IMutationsLib.DraconicHeartIM) >= 1) soulforceRecovery += 4;
				if (perkv1(IMutationsLib.DraconicHeartIM) >= 2) soulforceRecovery += 4;
				if (perkv1(IMutationsLib.DraconicHeartIM) >= 3) soulforceRecovery += 4;
				soulforceRecovery *= soulforceRecoveryMulti;
				addSoulforce(soulforceRecovery);
			}
			if (hasPerk(PerkLib.JobSorcerer) && this.mana < maxOverMana()) {
				var manaRecovery:Number = 0;
				var manaRecoveryMulti:Number = 1;
				if (hasPerk(PerkLib.JobSorcerer)) manaRecovery += 10;
				if (hasPerk(PerkLib.ArcaneRegenerationMinor)) manaRecovery += 10;
				if (hasPerk(PerkLib.ArcaneRegenerationMajor)) manaRecovery += 20;
				if (hasPerk(PerkLib.ArcaneRegenerationEpic)) manaRecovery += 30;
				if (hasPerk(PerkLib.ArcaneRegenerationLegendary)) manaRecovery += 40;
				if (hasPerk(PerkLib.ArcaneRegenerationMythical)) manaRecovery += 50;
				if (perkv1(IMutationsLib.DraconicHeartIM) >= 1) manaRecovery += 5;
				if (perkv1(IMutationsLib.DraconicHeartIM) >= 2) manaRecovery += 5;
				if (perkv1(IMutationsLib.DraconicHeartIM) >= 3) manaRecovery += 5;
				if (hasPerk(PerkLib.WarMageApprentice)) manaRecovery += 10;
				if (hasPerk(PerkLib.WarMageAdept)) manaRecovery += 15;
				if (hasPerk(PerkLib.GreyMageApprentice)) manaRecoveryMulti += 0.25;
				if (hasPerk(PerkLib.GreyMage)) manaRecoveryMulti += 0.5;
				if (hasPerk(PerkLib.GreyArchmage)) manaRecoveryMulti += 0.75;
				if (hasPerk(PerkLib.GrandGreyArchmage)) manaRecoveryMulti += 1;
				if (hasPerk(PerkLib.GrandGreyArchmage2ndCircle)) manaRecoveryMulti += 1.5;
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
					statStore.removeBuffs("FrozenSolid");
					removeStatusEffect(StatusEffects.FrozenSolid);
				}
				else outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " currently encased in the ice prison!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.Polymorphed)) {
				addStatusValue(StatusEffects.Polymorphed,1,-1);
				if (hasPerk(PerkLib.EnemyResiliance)) addStatusValue(StatusEffects.Polymorphed,1,-5);
				if(statusEffectv1(StatusEffects.Polymorphed) <= 0) {
					outputText("<b>[Themonster] has freed " + pronoun2 + "self from the curse!</b>\n\n");
					removeStatusEffect(StatusEffects.Polymorphed);
				}
				else outputText("<b>[Themonster] is fighting against the curse.</b>\n\n");
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
				if (statusEffectv2(StatusEffects.InvisibleOrStealth) > 0) {
					if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] < SceneLib.combat.StealthModeMechCost() || player.soulforce < SceneLib.combat.StealthModeMechCost()) addStatusValue(StatusEffects.InvisibleOrStealth,1,-1);
					else {
						if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] >= SceneLib.combat.StealthModeMechCost()) flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] -= SceneLib.combat.StealthModeMechCost();
						else player.soulforce -= SceneLib.combat.StealthModeMechCost();
					}
				}
				else addStatusValue(StatusEffects.InvisibleOrStealth,1,-1);
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
					outputText("<b>You try to prolong the trance but [themonster] finally snaps out.</b>\n\n");
					removeStatusEffect(StatusEffects.HypnosisNaga);
				}
				else outputText("<b>[Themonster] is lost in your gaze unable to act.</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.Earthshield)) {
				outputText("<b>[Themonster] is protected by a shield of rocks!</b>\n\n");
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
				outputText("<b>[Themonster] is still stunned!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.Shell)) {
				if(statusEffectv1(StatusEffects.Shell) >= 0) {
					outputText("<b>A wall of many hues shimmers around [themonster].</b>\n\n");
					addStatusValue(StatusEffects.Shell,1,-1);
				}
				else {
					outputText("<b>The magical barrier [themonster] erected fades away to nothing at last.</b>\n\n");
					removeStatusEffect(StatusEffects.Shell);
				}
			}
			if(hasStatusEffect(StatusEffects.Hypermode)) {
				if (statusEffectv1(StatusEffects.Hypermode) <= 0) {
					outputText("<b>[Themonster] is no longer rampaging!</b>\n\n");
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
					outputText("The wounds you left on [themonster] stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.IzmaBleed);
				}
				//Deal damage if still wounded.
				else {
					var procentvalue:Number = (4 + rand(7));
					var procentvalue1:Number = 1;
					if (game.player.hasPerk(PerkLib.ThirstForBlood)) procentvalue1 += .25;
					if (game.player.hasPerk(PerkLib.KingOfTheJungle)) procentvalue1 += .2;
					if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 1) procentvalue1 += .25;
					if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 2) procentvalue1 += .25;
					if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 3) procentvalue1 += .25;
					if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 4) procentvalue1 += .25;
					if (statusEffectv2(StatusEffects.IzmaBleed) > 0) procentvalue += statusEffectv2(StatusEffects.IzmaBleed);
					procentvalue *= procentvalue1;
					procentvalue = Math.round(procentvalue);
					var store:Number = maxHP() * (procentvalue) / 100;
					store = SceneLib.combat.doDamage(store);
					if (plural) outputText("[Themonster] bleed profusely from the jagged wounds your weapon left behind. ");
					else outputText("[Themonster] bleeds profusely from the jagged wounds your weapon left behind. ");
					SceneLib.combat.CommasForDigits(store);
					outputText("[pg]");
				}
			}
			if(hasStatusEffect(StatusEffects.SharkBiteBleed)) {
				//Countdown to heal
				if (hasPerk(PerkLib.EnemyFleshConstructType)) addStatusValue(StatusEffects.SharkBiteBleed, 1, -2);
				else addStatusValue(StatusEffects.SharkBiteBleed,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.SharkBiteBleed) <= 0) {
					outputText("The bite wounds you left on [themonster] stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.SharkBiteBleed);
				}
				//Deal damage if still wounded.
				else {
					var store3:Number = (player.str + player.spe) * 2;
					var store3a:Number = 1;
					if (player.hasPerk(PerkLib.ThirstForBlood)) store3a += .25;
					if (game.player.hasPerk(PerkLib.KingOfTheJungle)) store3a += .2;
					if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 1) store3a += .25;
					if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 2) store3a += .25;
					if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 3) store3a += .25;
					if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 4) store3a += .25;
					if (player.hasPerk(PerkLib.RacialParagon)) store3a += .5;
					if (player.hasPerk(PerkLib.Apex)) store3a += .5;
					if (player.hasPerk(PerkLib.AlphaAndOmega)) store3a += .5;
					store3 *= store3a;
					store3 = Math.round(store3);
					if (statusEffectv2(StatusEffects.SharkBiteBleed) > 0) store3 *= statusEffectv2(StatusEffects.SharkBiteBleed);
					store3 = SceneLib.combat.doDamage(store3);
					if(plural) outputText("[Themonster] bleed profusely from the jagged wounds your bite left behind. ");
					else outputText("[Themonster] bleeds profusely from the jagged wounds your bite left behind. ");
					SceneLib.combat.CommasForDigits(store3);
					outputText("[pg]");
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
				if(plural) outputText("[Themonster] is violently struck by the ever intensifying windstorm. ");
				else outputText("[Themonster] are violently struck by the ever intensifying windstorm. ");
				SceneLib.combat.CommasForDigits(store14);
				outputText("[pg]");
				temp = rand(4);
				if(temp == 3) createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0); outputText("<b>A random flying object caught in the hurricane rams into your opponent, stunning it!</b>\n\n");
			}
			if(hasStatusEffect(StatusEffects.KamaitachiBleed)) {
				//This wounds never heals unless by magic
				//Deal damage if still wounded.
				var store13:Number = (player.str + player.spe) * 2;
				var store13a:Number = 1;
				if (game.player.hasPerk(PerkLib.ThirstForBlood)) store13a += .25;
				if (game.player.hasPerk(PerkLib.KingOfTheJungle)) store13a += .2;
				store13 *= store13a;
				store13 = Math.round(store13);
				if (statusEffectv2(StatusEffects.KamaitachiBleed) > 0) store13 *= statusEffectv2(StatusEffects.KamaitachiBleed);
				store13 += statusEffectv1(StatusEffects.KamaitachiBleed); //Kamaitachi bleed stacks on itself growing ever stronger
				store13 += maxHP()*0.02;
				store13 = SceneLib.combat.doDamage(store13);
				if(plural) outputText("[Themonster] bleed profusely from the deep wounds your scythes left behind. ");
				else outputText("[Themonster] bleeds profusely from the deep wounds your scythes left behind. ");
				SceneLib.combat.CommasForDigits(store13);
				outputText("[pg]");
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
					outputText(" you left on [themonster] stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.GoreBleed);
				}
				//Deal damage if still wounded.
				else {
					var store5:Number = (player.str + player.spe) * 2;
					var store5a:Number = 1;
					if (player.hasPerk(PerkLib.ThirstForBlood)) store5a += .25;
					if (game.player.hasPerk(PerkLib.KingOfTheJungle)) store5a += .2;
					if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 1) store5a += .25;
					if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 2) store5a += .25;
					if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 3) store5a += .25;
					if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 4) store5a += .25;
					if (player.hasPerk(PerkLib.RacialParagon)) store5a += .5;
					if (player.hasPerk(PerkLib.Apex)) store5a += .5;
					if (player.hasPerk(PerkLib.AlphaAndOmega)) store5a += .5;
					store5 *= store5a;
					store5 = Math.round(store5);
					store5 = SceneLib.combat.doDamage(store5);
					if (plural) outputText("[Themonster] bleed profusely from the jagged ");
					else outputText("[Themonster] bleeds profusely from the jagged ")
					if (player.horns.type == Horns.COW_MINOTAUR) outputText("wounds your horns");
					else outputText("wound your horns");
					outputText(" left behind. ");
					SceneLib.combat.CommasForDigits(store5);
					outputText("[pg]");
				}
			}
			if (hasStatusEffect(StatusEffects.Hemorrhage)) {
				if (hasPerk(PerkLib.EnemyFleshConstructType)) addStatusValue(StatusEffects.Hemorrhage, 1, -2);
				else addStatusValue(StatusEffects.Hemorrhage, 1, -1);
				if (statusEffectv1(StatusEffects.Hemorrhage) <= 0) {
					outputText("The wounds you left on [themonster] stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.Hemorrhage);
				}
				else {
					var hemorrhage1:Number = 0;
					hemorrhage1 += maxHP() * statusEffectv2(StatusEffects.Hemorrhage);
					if (game.player.hasPerk(PerkLib.KingOfTheJungle)) hemorrhage1 *= 1.2;
					hemorrhage1 = SceneLib.combat.fixPercentDamage(hemorrhage1);
					hemorrhage1 = SceneLib.combat.doDamage(hemorrhage1);
					if (plural) outputText("[Themonster] bleed profusely from the jagged wounds your attack left behind. ");
					else outputText("[Themonster] bleeds profusely from the jagged wounds your attack left behind. ");
					SceneLib.combat.CommasForDigits(hemorrhage1);
					outputText("[pg]");
				}
			}
			if (hasStatusEffect(StatusEffects.HemorrhageArmor)) {
				if (hasPerk(PerkLib.EnemyFleshConstructType)) addStatusValue(StatusEffects.HemorrhageArmor, 1, -2);
				else addStatusValue(StatusEffects.HemorrhageArmor, 1, -1);
				if (statusEffectv1(StatusEffects.HemorrhageArmor) <= 0) {
					outputText("The wounds your armor left on [themonster] stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.HemorrhageArmor);
				}
				else {
					var hemorrhage2:Number = 0;
					hemorrhage2 += maxHP() * statusEffectv2(StatusEffects.HemorrhageArmor);
					if (game.player.hasPerk(PerkLib.KingOfTheJungle)) hemorrhage2 *= 1.2;
					hemorrhage2 = SceneLib.combat.fixPercentDamage(hemorrhage2);
					hemorrhage2 = SceneLib.combat.doDamage(hemorrhage2);
					if (plural) outputText("[Themonster] bleed profusely from the jagged wounds that resulted from contact with your armor. ");
					else outputText("[Themonster] bleeds profusely from the jagged wounds that resulted from contact with your armor. ");
					SceneLib.combat.CommasForDigits(hemorrhage2);
					outputText("[pg]");
				}
			}
			if (hasStatusEffect(StatusEffects.HemorrhageShield)) {
				if (hasPerk(PerkLib.EnemyFleshConstructType)) addStatusValue(StatusEffects.HemorrhageShield, 1, -2);
				else addStatusValue(StatusEffects.HemorrhageShield, 1, -1);
				if (statusEffectv1(StatusEffects.HemorrhageShield) <= 0) {
					outputText("The wounds your shield left on [themonster] stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.HemorrhageShield);
				}
				else {
					var hemorrhage3:Number = 0;
					hemorrhage3 += maxHP() * statusEffectv2(StatusEffects.HemorrhageShield);
					if (game.player.hasPerk(PerkLib.KingOfTheJungle)) hemorrhage3 *= 1.2;
					hemorrhage3 = SceneLib.combat.fixPercentDamage(hemorrhage3);
					hemorrhage3 = SceneLib.combat.doDamage(hemorrhage3);
					if (plural) outputText("[Themonster] bleed profusely from the jagged wounds your shield left behind. ");
					else outputText("[Themonster] bleeds profusely from the jagged wounds your shield left behind. ");
					SceneLib.combat.CommasForDigits(hemorrhage3);
					outputText("[pg]");
				}
			}
			if(hasStatusEffect(StatusEffects.Hemorrhage2)) {
				if (hasPerk(PerkLib.EnemyFleshConstructType)) addStatusValue(StatusEffects.Hemorrhage2, 1, -2);
				else addStatusValue(StatusEffects.Hemorrhage2, 1, -1);
				if (statusEffectv1(StatusEffects.Hemorrhage2) <= 0) {
					outputText("The wounds your companion left on [themonster] stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.Hemorrhage2);
				}
				else {
					var hemorrhage4:Number = 0;
					hemorrhage4 += maxHP() * statusEffectv2(StatusEffects.Hemorrhage2);
					if (game.player.hasPerk(PerkLib.KingOfTheJungle)) hemorrhage4 *= 1.2;
					hemorrhage4 = SceneLib.combat.fixPercentDamage(hemorrhage4);
					hemorrhage4 = SceneLib.combat.doDamage(hemorrhage4);
					if (plural) outputText("[Themonster] bleed profusely from the jagged wounds your companion attack left behind. ");
					else outputText("[Themonster] bleeds profusely from the jagged wounds your companion attack left behind. ");
					SceneLib.combat.CommasForDigits(hemorrhage4);
					outputText("[pg]");
				}
			}
			if (hasStatusEffect(StatusEffects.Bloodlust)) {
				if (this is UnderwaterSharkGirl || this is UnderwaterTigersharkGirl || this is UnderwaterSharkGirlsPack) {
					outputText("As blood flows through the water the "+(this is UnderwaterTigersharkGirl ? "tiger ":"")+"shark girl"+(this is UnderwaterSharkGirlsPack ? "s":"")+" grows increasingly vicious. ");
				}
			}
			if (game.player.hasStatusEffect(StatusEffects.BloodField)) {
				game.player.addStatusValue(StatusEffects.BloodField, 1, -1);
				if (game.player.statusEffectv1(StatusEffects.BloodField) <= 0) game.player.removeStatusEffect(StatusEffects.BloodField);
				if (!game.player.hasStatusEffect(StatusEffects.MonsterDig) && !isFlying()) {
					var bloodfield:Number = statusEffectv2(StatusEffects.Hemorrhage);
					if (plural) bloodfield *= 5;
					if (hasPerk(PerkLib.EnemyLargeGroupType)) bloodfield *= 5;
					bloodfield = SceneLib.combat.doDamage(bloodfield);
					EngineCore.HPChange(bloodfield, false);
				}
			}
			if (hasStatusEffect(StatusEffects.BloodRequiem)) {
				addStatusValue(StatusEffects.BloodRequiem, 1, -1);
				if (statusEffectv1(StatusEffects.BloodRequiem) <= 0) removeStatusEffect(StatusEffects.BloodRequiem);
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
			if(hasStatusEffect(StatusEffects.Briarthorn)) {
				var store16:Number = (player.str + player.spe) * 2;
				var store16a:Number = 1;
				if (game.player.hasPerk(PerkLib.ThirstForBlood)) store16a += .25;
				if (game.player.hasPerk(PerkLib.KingOfTheJungle)) store16a += .2;
				store16 *= store16a;
				store16 += maxHP()*0.05;
				store16 = boundInt(1, store16, maxHP()/20);
				store16 = SceneLib.combat.doDamage(store16);
				if(plural) outputText("[Themonster] bleeds profusely from the deep wounds your vine thorns left behind. ");
				else outputText("[Themonster] bleeds profusely from the deep wounds your vine thorns left behind. ");
				SceneLib.combat.CommasForDigits(store16);
				outputText("[pg]");
			}
			if(hasStatusEffect(StatusEffects.Rosethorn)) {
				if (statusEffectv1(StatusEffects.Rosethorn) <= 0) {
					removeStatusEffect(StatusEffects.Rosethorn);
					outputText("<b>Bleeding cause by deep wounds your rose thorns left behind stopped!</b>[pg]");
				} else {
					var store17:Number = (player.str + player.spe);
					var store17a:Number = statusEffectv1(StatusEffects.Rosethorn)*0.1;
					if (game.player.hasPerk(PerkLib.ThirstForBlood)) store17a += .1;
					if (game.player.hasPerk(PerkLib.KingOfTheJungle)) store17a += .08;
					store17 *= store17a;
					store17 += maxHP()*0.01;
					store17 = boundInt(1, store17, maxHP()/20);
					store17 = SceneLib.combat.doDamage(store17);
					if(plural) outputText("[Themonster] bleed profusely from the deep wounds your rose thorns left behind. ");
					else outputText("[Themonster] bleeds profusely from the deep wounds your rose thorns left behind. ");
					SceneLib.combat.CommasForDigits(store17);
					outputText("[pg]");
					changeStatusValue(StatusEffects.Rosethorn, 1, 0);
				}
			}
			if (hasStatusEffect(StatusEffects.DeathBlossom)) {
				if (statusEffectv1(StatusEffects.DeathBlossom) <= 0) {
					removeStatusEffect(StatusEffects.DeathBlossom);
					outputText("<b>Death Blossom effect wore off!</b>[pg]");
				} else {
					addStatusValue(StatusEffects.DeathBlossom, 1, -1);
					addStatusValue(StatusEffects.DeathBlossom, 2, 0.2);
				}
			}
			if(hasStatusEffect(StatusEffects.LustStick)) {
				//LoT Effect Messages:
				switch(statusEffectv1(StatusEffects.LustStick)) {
					//First:
					case 1:
						if(plural) outputText("One of [themonster] pants and crosses " + mf("his","her") + " eyes for a moment.  " + mf("His","Her") + " dick flexes and bulges, twitching as " + mf("he","she") + " loses himself in a lipstick-fueled fantasy.  When " + mf("he","she") + " recovers, you lick your lips and watch " + mf("his","her") + " blush spread.\n\n");
						else outputText("[Themonster] pants and crosses " + pronoun3 + " eyes for a moment.  " + mf("His","Her") + " dick flexes and bulges, twitching as " + pronoun1 + " loses " + mf("himself", "herself") + " in a lipstick-fueled fantasy.  When " + pronoun1 + " recovers, you lick your lips and watch " + mf("his","her") + " blush spread.\n\n");
						break;
					//Second:
					case 2:
						if(plural) outputText("[Themonster] moan out loud, " + pronoun3 + " dicks leaking and dribbling while " + pronoun1 + " struggle not to touch " + pronoun2 + ".\n\n");
						else outputText("[Themonster] moans out loud, " + pronoun3 + " dick leaking and dribbling while " + pronoun1 + " struggles not to touch it.\n\n");
						break;
					//Third:
					case 3:
						if(plural) outputText("[Themonster] pump " + pronoun3 + " hips futilely, air-humping non-existent partners.  Clearly your lipstick is getting to " + pronoun2 + ".\n\n");
						else outputText("[Themonster] pumps " + pronoun3 + " hips futilely, air-humping a non-existent partner.  Clearly your lipstick is getting to " + pronoun2 + ".\n\n");
						break;
					//Fourth:
					case 4:
						if(plural) outputText("[Themonster] close " + pronoun3 + " eyes and grunt, " + pronoun3 + " cocks twitching, bouncing, and leaking pre-cum.\n\n");
						else outputText("[Themonster] closes " + pronoun2 + " eyes and grunts, " + pronoun3 + " cock twitching, bouncing, and leaking pre-cum.\n\n");
						break;
					//Fifth and repeat:
					default:
						if(plural) outputText("Drops of pre-cum roll steadily out of their dicks.  It's a marvel " + pronoun1 + " haven't given in to " + pronoun3 + " lusts yet.\n\n");
						else outputText("Drops of pre-cum roll steadily out of [themonster]'s dick.  It's a marvel " + pronoun1 + " hasn't given in to " + pronoun3 + " lust yet.\n\n");
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
				player.takeLustDamage(5+player.effectiveSensitivity()/10, true);
			}
			if(hasStatusEffect(StatusEffects.QueenBind)) {
				outputText("You're utterly restrained by the Harpy Queen's magical ropes!\n\n");
				if(flags[kFLAGS.PC_FETISH] >= 2) player.dynStats("lus", 3);
			}
			if(this is SecretarialSuccubus || this is MilkySuccubus) {
				if(player.lust < (player.maxLust() * 0.45)) outputText("There is something in the air around your opponent that makes you feel warm.\n\n");
				else if(player.lust < (player.maxLust() * 0.70)) outputText("You aren't sure why but you have difficulty keeping your eyes off your opponent's lewd form.\n\n");
				else if(player.lust < (player.maxLust() * 0.90)) outputText("You blush when you catch yourself staring at your foe's rack, watching it wobble with every step she takes.\n\n");
				else outputText("You have trouble keeping your greedy hands away from your groin.  It would be so easy to just lay down and masturbate to the sight of your curvy enemy.  The succubus looks at you with a sexy, knowing expression.\n\n");
				player.takeLustDamage(1+rand(8), true);
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
				player.takeLustDamage((3 + int(player.lib/20 + player.cor/25)), true);
			}
			//immolation DoT
			if (hasStatusEffect(StatusEffects.ImmolationDoT)) {
				//Countdown to heal
				addStatusValue(StatusEffects.ImmolationDoT,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.ImmolationDoT) <= 0) {
					outputText("Flames left by immolation spell on [themonster] finally stop burning.\n\n");
					removeStatusEffect(StatusEffects.ImmolationDoT);
				}
				//Deal damage if still wounded.
				else {
					var store2:Number = int(50 + (player.inte / 10));
					if (game.player.hasPerk(PerkLib.KingOfTheJungle)) store2 *= 1.2;
					store2 = Math.round(store2 * SceneLib.combat.fireDamageBoostedByDao());
					if(plural) outputText("[Themonster] burn from lingering immolination after-effect. ");
					else outputText("[Themonster] burns from lingering immolination after-effect. ");
					store2 = SceneLib.combat.doFireDamage(store2);
					outputText("\n\n");
				}
			}
			//Burn DoT
			if (hasStatusEffect(StatusEffects.BurnDoT)) {
				//Countdown to heal
				addStatusValue(StatusEffects.BurnDoT,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.BurnDoT) <= 0) {
					outputText("Flames left by Burn on [themonster] finally stop burning.\n\n");
					removeStatusEffect(StatusEffects.BurnDoT);
				}
				//Deal damage if still wounded.
				else {
					var store4:Number = (player.str + player.spe + player.tou) * 2.5;
					if (game.player.hasPerk(PerkLib.KingOfTheJungle)) store4 *= 1.2;
					store4 = Math.round(store4 * SceneLib.combat.fireDamageBoostedByDao());
					store4 += maxHP() * statusEffectv2(StatusEffects.BurnDoT);
					store4 = SceneLib.combat.fixPercentDamage(store4);
					if(plural) outputText("[Themonster] burn from lingering Burn after-effect. ");
					else outputText("[Themonster] burns from lingering Burn after-effect. ");
					store4 = SceneLib.combat.doFireDamage(store4, true, true);
					outputText("\n\n");
				}
			}
			//Formic Acid DoT
			if (hasStatusEffect(StatusEffects.AntAcid)) {
				//Countdown to heal
				addStatusValue(StatusEffects.AntAcid,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.AntAcid) <= 0) {
					outputText("The formic acid burning " + a + short + " finally wore out.\n\n");
					removeStatusEffect(StatusEffects.AntAcid);
				}
				//Deal damage if still wounded.
				else {
					var store15:Number = (player.str + player.tou) * 2.5;
					if (game.player.hasPerk(PerkLib.KingOfTheJungle)) store15 *= 1.2;
					if (player.racialScore(Races.ANT) <= 4) store15 *= 0.75
					store15 = Math.round(store15 * SceneLib.combat.poisonDamageBoostedByDao());
					store15 += maxHP() * statusEffectv2(StatusEffects.AntAcid);
					store15 = SceneLib.combat.fixPercentDamage(store15);
					store15 = SceneLib.combat.doAcidDamage(store15);
					if(plural) outputText(capitalA + short + " burn from lingering formic acid. <b>([font-red]" + store15 + "[/font])</b>\n\n");
					else outputText(capitalA + short + " burns from lingering formic acid. <b>([font-red]" + store15 + "[/font])</b>\n\n");
				}
			}
			//Burn DoT
			if (hasStatusEffect(StatusEffects.BurnDoT2)) {
				//Countdown to heal
				addStatusValue(StatusEffects.BurnDoT2,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.BurnDoT2) <= 0) {
					outputText("Flames left by Burn on [themonster] finally stop burning.\n\n");
					removeStatusEffect(StatusEffects.BurnDoT2);
				}
				//Deal damage if still wounded.
				else {
					var store8:Number = (player.str + player.spe + player.tou) * 2.5;
					if (game.player.hasPerk(PerkLib.KingOfTheJungle)) store8 *= 1.2;
					store8 = Math.round(store8 * SceneLib.combat.fireDamageBoostedByDao());
					store8 += maxHP() * statusEffectv2(StatusEffects.BurnDoT2);
					store8 = SceneLib.combat.fixPercentDamage(store8);
					if(plural) outputText("[Themonster] burn from lingering Burn after-effect. ");
					else outputText("[Themonster] burns from lingering Burn after-effect. ");
					store8 = SceneLib.combat.doFireDamage(store8, true, true);
					outputText("\n\n");
				}
			}
			//Fire Punch Burn DoT
			if (hasStatusEffect(StatusEffects.FirePunchBurnDoT)) {
				//Countdown to heal
				addStatusValue(StatusEffects.FirePunchBurnDoT,1,-1);
				//Heal wounds
				if(statusEffectv1(StatusEffects.FirePunchBurnDoT) <= 0) {
					outputText("Flames left by Fire Punch on [themonster] finally stop burning.\n\n");
					removeStatusEffect(StatusEffects.FirePunchBurnDoT);
				}
				//Deal damage if still wounded.
				else {
					var store6:Number = (player.spe + player.inte) * SceneLib.combat.soulskillMod() * 0.5;
					if (game.player.hasPerk(PerkLib.KingOfTheJungle)) store6 *= 1.2;
					store6 = Math.round(store6 * SceneLib.combat.fireDamageBoostedByDao());
					if(plural) outputText("[Themonster] burn from lingering Fire Punch after-effect. ");
					else outputText("[Themonster] burns from lingering Fire Punch after-effect. ");
					store6 = SceneLib.combat.doFireDamage(store6, true, true);
					outputText("\n\n");
				}
			}
			//Regen Inhibitor
			if (hasStatusEffect(StatusEffects.RegenInhibitor)) {
				//Countdown to heal
				addStatusValue(StatusEffects.RegenInhibitor,1,-1);
				//Heal wounds
				if (statusEffectv1(StatusEffects.RegenInhibitor) <= 0) {
					outputText("[Themonster] sighs in relief as " + pronoun3 + " wounds resume regenerating!\n\n");
					removeStatusEffect(StatusEffects.RegenInhibitor);
				}
			}
			//Regen Inhibitor
			if (hasStatusEffect(StatusEffects.HydraRegenerationDisabled)) {
				//Countdown to heal
				addStatusValue(StatusEffects.HydraRegenerationDisabled,1,-1);
				//Heal wounds
				if (statusEffectv1(StatusEffects.HydraRegenerationDisabled) <= 0) {
					if (this is Hydra) outputText("[Themonster] sighs in relief as " + pronoun3 + " wounds resume regenerating!\n\n");
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
						outputText("Wound left by frostburn on [themonster] finally close ups.\n\n");
						removeStatusEffect(StatusEffects.FrostburnDoT);
					}
					//Deal damage if still wounded.
					else {
						var store12:Number = (player.str + player.spe + player.tou) * 2.5;
						if (game.player.hasPerk(PerkLib.KingOfTheJungle)) store12 *= 1.2;
						store12 = Math.round(store12 * SceneLib.combat.iceDamageBoostedByDao());
						store12 += maxHP() * statusEffectv2(StatusEffects.FrostburnDoT);
						store12 = SceneLib.combat.fixPercentDamage(store12);
						if(plural) outputText("[Themonster] are hurt by lingering Frostburn after-effect. ");
						else outputText("[Themonster] is hurt by lingering Frostburn after-effect. ");
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
						outputText("Wound left by acid on [themonster] finally close ups.\n\n");
						removeStatusEffect(StatusEffects.AcidDoT);
					}
					//Deal damage if still wounded.
					else {
						var store7:Number = (player.str + player.spe + player.tou) * 2.5;
						if (game.player.hasPerk(PerkLib.KingOfTheJungle)) store7 *= 1.2;
						store7 += maxHP() * statusEffectv2(StatusEffects.AcidDoT);
						store7 = SceneLib.combat.fixPercentDamage(store7);
						if(plural) outputText("[Themonster] are hurt by lingering Acid after-effect. ");
						else outputText("[Themonster] is hurt by lingering Acid after-effect. ");
						store7 = SceneLib.combat.doAcidDamage(store7, true, true);
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
						outputText("Wound left by poison on [themonster] finally close ups.\n\n");
						removeStatusEffect(StatusEffects.PoisonDoT);
					}
					//Deal damage if still wounded.
					else {
						var store10:Number = (player.str + player.spe + player.tou) * 2.5;
						if (game.player.hasPerk(PerkLib.KingOfTheJungle)) store10 *= 1.2;
						store10 += maxHP() * statusEffectv2(StatusEffects.PoisonDoT);
						store10 = SceneLib.combat.fixPercentDamage(store10);
						if(plural) outputText("[Themonster] are hurt by lingering Poison after-effect. ");
						else outputText("[Themonster] is hurt by lingering Poison after-effect. ");
						store10 = SceneLib.combat.doPoisonDamage(store10, true, true);
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
						outputText("Wound left by poison on [themonster] finally close ups.\n\n");
						removeStatusEffect(StatusEffects.PoisonDoTH);
					}
					//Deal damage if still wounded.
					else {
						var store9:Number = 0;
						store9 += maxHP() * statusEffectv2(StatusEffects.PoisonDoTH);
						store9 = SceneLib.combat.fixPercentDamage(store9);
						if(plural) outputText("[Themonster] are hurt by lingering Poison after-effect. ");
						else outputText("[Themonster] is hurt by lingering Poison after-effect. ");
						store9 = SceneLib.combat.doPoisonDamage(store9, true, true);
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
						outputText("Lingering lust-induncing after-effect on [themonster] finally ends.\n\n");
						removeStatusEffect(StatusEffects.LustDoT);
					}
					//Deal damage if still wounded.
					else {
						var lustDmg1:Number = player.lib / 10;
						if (game.player.hasPerk(PerkLib.KingOfTheJungle)) lustDmg1 *= 1.2;
						lustDmg1 += maxLust() * statusEffectv2(StatusEffects.LustDoT);
						lustDmg1 = Math.round(lustDmg1);
						if(plural) outputText("[Themonster] are aroused by lingering lust-induncing after-effect. ");
						else outputText("[Themonster] is aroused by lingering lust-induncing after-effect. ");
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
						outputText("Lingering lust-induncing after-effect on [themonster] finally ends.\n\n");
						removeStatusEffect(StatusEffects.LustDoTH);
					}
					//Deal damage if still wounded.
					else {
						var lustDmg2:Number = 0;
						lustDmg2 += maxLust() * statusEffectv2(StatusEffects.LustDoTH);
						if(plural) outputText("[Themonster] are aroused by lingering lust-induncing after-effect. ");
						else outputText("[Themonster] is aroused by lingering lust-induncing after-effect. ");
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
					outputText("<b>[Themonster] ice armor has thawed out.</b>\n\n");
				}
				else addStatusValue(StatusEffects.IceArmor,1,-1);
			}

			//Flame Blade
			if (hasStatusEffect(StatusEffects.FlameBlade)) {
				if (statusEffectv1(StatusEffects.FlameBlade) <= 0) {
					removeStatusEffect(StatusEffects.FlameBlade);
					outputText("<b>[Themonster]'s Flame Blade effect wore off.</b>\n\n");
				}
				else addStatusValue(StatusEffects.FlameBlade,1,-1);
			}

			//lowered damage done by enemy attacks debuff
			if (hasStatusEffect(StatusEffects.EnemyLoweredDamageH)) {
				if (statusEffectv1(StatusEffects.EnemyLoweredDamageH) <= 0) removeStatusEffect(StatusEffects.EnemyLoweredDamageH);
				else addStatusValue(StatusEffects.EnemyLoweredDamageH,1,-1);
			}
		}

		public function handleAwardItemText(itype:ItemType):ItemType
		{ //New Function, override this function in child classes if you want a monster to output special item drop text
			if (itype != null) outputText("\nThere is " + itype.longName + " on your defeated opponent.  ");
			return itype;
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
			if (!inDungeon) {
				outputText("\n\nYou'll probably come to your senses in six hours or so");
				if ((player.gems > 1) && gemsLost > 0)
					outputText(", missing " + gemsLost + " gems.");
				else if ((player.gems == 1) && gemsLost > 0)
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
			return 6; //This allows different monsters to delay the player by different amounts of time after a combat loss. Normal loss causes an six hour blackout
		}
		public function prepareForCombat():void {
			var bonusStatsAmp:Number = 0.6;
			if (perkv1(IMutationsLib.MantislikeAgilityIM) >= 1) this.speStat.core.value += (10 * (1 + newGamePlusMod()));
			if (perkv1(IMutationsLib.MantislikeAgilityIM) >= 2) this.speStat.core.value += (20 * (1 + newGamePlusMod()));
			if (level > 25) bonusStatsAmp += 0.3*((int)(level-1)/25);
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
			if (level > 10) bonusAscMaxHP *= (int)((level / 10 + 1) * 3);
			weaponAttack += (1 + (int)(weaponAttack / 5)) * 3 * newGamePlusMod();
			if (weaponRangeAttack > 0) weaponRangeAttack += (1 + (int)(weaponRangeAttack / 5)) * 3 * newGamePlusMod();
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
					armorDef += (4 * (1 + newGamePlusMod()));
					armorMDef += (4 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulPersonage)) {
					armorDef += (4 * (1 + newGamePlusMod()));
					armorMDef += (4 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulWarrior)) {
					armorDef += (4 * (1 + newGamePlusMod()));
					armorMDef += (4 * (1 + newGamePlusMod()));
				}
			}
			if (hasPerk(PerkLib.FleshBodyWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) {
					armorDef += (6 * (1 + newGamePlusMod()));
					armorMDef += (6 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulScholar)) {
					armorDef += (6 * (1 + newGamePlusMod()));
					armorMDef += (6 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulGrandmaster)) {
					armorDef += (6 * (1 + newGamePlusMod()));
					armorMDef += (6 * (1 + newGamePlusMod()));
				}
			}
			if (hasPerk(PerkLib.FleshBodyElderStage)) {
				if (hasPerk(PerkLib.SoulElder)) {
					armorDef += (8 * (1 + newGamePlusMod()));
					armorMDef += (8 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulExalt)) {
					armorDef += (8 * (1 + newGamePlusMod()));
					armorMDef += (8 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulOverlord)) {
					armorDef += (8 * (1 + newGamePlusMod()));
					armorMDef += (8 * (1 + newGamePlusMod()));
				}
			}
			if (hasPerk(PerkLib.FleshBodyOverlordStage)) {
				if (hasPerk(PerkLib.SoulTyrant)) {
					armorDef += (10 * (1 + newGamePlusMod()));
					armorMDef += (10 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulKing)) {
					armorDef += (10 * (1 + newGamePlusMod()));
					armorMDef += (10 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.SoulEmperor)) {
					armorDef += (10 * (1 + newGamePlusMod()));
					armorMDef += (10 * (1 + newGamePlusMod()));
				}
			}
			if (hasPerk(PerkLib.FleshBodyTyrantStage)) {
				if (hasPerk(PerkLib.SoulAncestor)) {
					armorDef += (12 * (1 + newGamePlusMod()));
					armorMDef += (12 * (1 + newGamePlusMod()));
				}/*
				if (hasPerk(PerkLib.soul)) {
					armorDef += (12 * (1 + newGamePlusMod()));
					armorMDef += (12 * (1 + newGamePlusMod()));
				}
				if (hasPerk(PerkLib.)) {
					armorDef += (12 * (1 + newGamePlusMod()));
					armorMDef += (12 * (1 + newGamePlusMod()));
				}*/
			}
			armorDef += ((int)(1 + armorDef / 10)) * 3 * newGamePlusMod();
			armorMDef += ((int)(1 + armorMDef / 10)) * 3 * newGamePlusMod();
			if (hasPerk(PerkLib.EpicStrength)) this.strStat.core.value += Math.round(this.strStat.core.value * 0.35);
			if (hasPerk(PerkLib.LegendaryStrength)) this.strStat.core.value += Math.round(this.strStat.core.value * 0.5);
			if (hasPerk(PerkLib.MythicalStrength)) this.strStat.core.value += Math.round(this.strStat.core.value * 0.65);
			if (hasPerk(PerkLib.EpicToughness)) this.touStat.core.value += Math.round(this.touStat.core.value * 0.35);
			if (hasPerk(PerkLib.LegendaryToughness)) this.touStat.core.value += Math.round(this.touStat.core.value * 0.5);
			if (hasPerk(PerkLib.MythicalToughness)) this.touStat.core.value += Math.round(this.touStat.core.value * 0.65);
			if (hasPerk(PerkLib.EpicSpeed)) this.speStat.core.value += Math.round(this.speStat.core.value * 0.35);
			if (hasPerk(PerkLib.LegendarySpeed)) this.speStat.core.value += Math.round(this.speStat.core.value * 0.5);
			if (hasPerk(PerkLib.MythicalSpeed)) this.speStat.core.value += Math.round(this.speStat.core.value * 0.65);
			if (hasPerk(PerkLib.EpicIntelligence)) this.intStat.core.value += Math.round(this.intStat.core.value * 0.35);
			if (hasPerk(PerkLib.LegendaryIntelligence)) this.intStat.core.value += Math.round(this.intStat.core.value * 0.5);
			if (hasPerk(PerkLib.MythicalIntelligence)) this.intStat.core.value += Math.round(this.intStat.core.value * 0.65);
			if (hasPerk(PerkLib.EpicWisdom)) this.wisStat.core.value += Math.round(this.wisStat.core.value * 0.35);
			if (hasPerk(PerkLib.LegendaryWisdom)) this.wisStat.core.value += Math.round(this.wisStat.core.value * 0.5);
			if (hasPerk(PerkLib.MythicalWisdom)) this.wisStat.core.value += Math.round(this.wisStat.core.value * 0.65);
			if (hasPerk(PerkLib.EpicLibido)) this.libStat.core.value += Math.round(this.libStat.core.value * 0.35);
			if (hasPerk(PerkLib.LegendaryLibido)) this.libStat.core.value += Math.round(this.libStat.core.value * 0.5);
			if (hasPerk(PerkLib.MythicalLibido)) this.libStat.core.value += Math.round(this.libStat.core.value * 0.65);
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
				if (hasPerk(PerkLib.EnemyForBeginnersType)) this.lust *= 0.1;
				else this.lust *= 0.6;
				this.lust = Math.round(this.lust);
			}
		}
	}
}