/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	use namespace kGAMECLASS;
	
	public class Kindra extends Monster
	{
		public var kindraScene:KindraFollower = new KindraFollower();
		
		public function bowShooting():Number {
			var cost:Number = 15;
			if (flags[kFLAGS.KINDRA_ARROWS_SHOT] >= 60) cost -= 5;
			if (flags[kFLAGS.KINDRA_ARROWS_SHOT] >= 240) cost -= 5;
			return cost;
		}
		
		public function KindraFireBow01():void {
			KindraFireBow();
		}
		
		public function KindraFireBow02():void {
			KindraFireBow();
			KindraFireBow();
		}
		
		public function KindraFireBow03():void {
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
		}
		
		public function KindraFireBow04():void {
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
		}
		
		public function KindraFireBow05():void {
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
		}
		
		public function KindraFireBow06():void {
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
		}
		
		public function KindraFireBow():void {
			if (flags[kFLAGS.KINDRA_AFFECTION] < 7) outputText("Sheep-morph archer");
			if (flags[kFLAGS.KINDRA_AFFECTION] >= 7) outputText("Kindra");
			outputText(" casually fire an arrow at you with supreme skill.");
			var damage:Number = 0;
			damage += this.spe;
			if (this.spe >= 21) damage += ((this.spe - 20) * 0.2);
			if (this.spe >= 41) damage += ((this.spe - 40) * 0.2);
			if (this.spe >= 61) damage += ((this.spe - 60) * 0.2);
			if (this.spe >= 81) damage += ((this.spe - 80) * 0.2);
			if (this.spe >= 101) damage += ((this.spe - 100) * 0.2);
			if (this.spe >= 151) damage += ((this.spe - 150) * 0.2);
			if (this.spe >= 201) damage += ((this.spe - 200) * 0.2);
			if (this.spe >= 251) damage += ((this.spe - 250) * 0.2);
			if (this.spe >= 301) damage += ((this.spe - 300) * 0.2);
			if (this.spe >= 351) damage += ((this.spe - 350) * 0.2);
			if (this.spe >= 401) damage += ((this.spe - 400) * 0.2);
			if (this.spe >= 451) damage += ((this.spe - 450) * 0.2);
			if (this.spe >= 501) damage += ((this.spe - 500) * 0.2);
			if (this.spe >= 551) damage += ((this.spe - 550) * 0.2);
			if (this.spe >= 601) damage += ((this.spe - 600) * 0.2);
			if (this.spe >= 651) damage += ((this.spe - 650) * 0.2);
			if (this.spe >= 701) damage += ((this.spe - 700) * 0.2);
			if (this.spe >= 751) damage += ((this.spe - 750) * 0.2);
			if (this.spe >= 801) damage += ((this.spe - 800) * 0.2);
			if (this.spe >= 851) damage += ((this.spe - 850) * 0.2);
			if (this.spe >= 901) damage += ((this.spe - 900) * 0.2);
			if (this.spe >= 951) damage += ((this.spe - 950) * 0.2);
			if (this.spe < 10) damage = 10;
			damage = player.reduceDamage(damage);
			if (damage < 10) damage = 10;
			//weapon bonus
			if (this.weaponRangeAttack < 51) damage *= (1 + (this.weaponRangeAttack * 0.03));
			else if (this.weaponRangeAttack >= 51 && this.weaponRangeAttack < 101) damage *= (2.5 + ((this.weaponRangeAttack - 50) * 0.025));
			else if (this.weaponRangeAttack >= 101 && this.weaponRangeAttack < 151) damage *= (3.75 + ((this.weaponRangeAttack - 100) * 0.02));
			else if (this.weaponRangeAttack >= 151 && this.weaponRangeAttack < 201) damage *= (4.75 + ((this.weaponRangeAttack - 150) * 0.015));
			else damage *= (5.5 + ((this.weaponRangeAttack - 200) * 0.01));
			player.takeDamage(damage, true);
			outputText("\n\n");
			fatigue += bowShooting();
			flags[kFLAGS.KINDRA_ARROWS_SHOT]++;
		}
		
		public function KindraDrinkSheepMilk():void {
			if (flags[kFLAGS.KINDRA_AFFECTION] < 5) outputText("Sheep-morph archer");
			if (flags[kFLAGS.KINDRA_AFFECTION] >= 5) outputText("Kindra");
			outputText(" gulps down a bottle of sheep milk.\n");
			fatigue -= 60;
			if (lust >= 21) lust -= 20;
			else lust = 0;
		}
		
		override protected function performCombatAction():void
		{
			if (flags[kFLAGS.KINDRA_LVL_UP] == 6) {
				if (fatigue < (eMaxFatigue() - (bowShooting() * 6))) KindraFireBow06();
				else {
					if (rand(3) == 0 && fatigue >= 60) KindraDrinkSheepMilk();
					else eAttack();
				}
				combatRoundOver();
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 5) {
				if (fatigue < (eMaxFatigue() - (bowShooting() * 5))) KindraFireBow05();
				else {
					if (rand(3) == 0 && fatigue >= 60) KindraDrinkSheepMilk();
					else eAttack();
				}
				combatRoundOver();
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 4) {
				if (fatigue < (eMaxFatigue() - (bowShooting() * 4))) KindraFireBow04();
				else {
					if (rand(3) == 0 && fatigue >= 60) KindraDrinkSheepMilk();
					else eAttack();
				}
				combatRoundOver();
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 3) {
				if (fatigue < (eMaxFatigue() - (bowShooting() * 3))) KindraFireBow03();
				else {
					if (rand(3) == 0 && fatigue >= 60) KindraDrinkSheepMilk();
					else eAttack();
				}
				combatRoundOver();
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 2) {
				if (fatigue < (eMaxFatigue() - (bowShooting() * 2))) KindraFireBow02();
				else {
					if (rand(3) == 0 && fatigue >= 60) KindraDrinkSheepMilk();
					else eAttack();
				}
				combatRoundOver();
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 1) {
				if (fatigue < (eMaxFatigue() - bowShooting())) KindraFireBow01();
				else {
					if (rand(3) == 0 && fatigue >= 60) KindraDrinkSheepMilk();
					else eAttack();
				}
				combatRoundOver();
			}
		}//używanie sheep milk w czasie walki czasami (daje -60 fat i -20 lust)
		//nie zapomnieć używać KINDRA_ARROWS_SHOT flagi do śledzenia ile już strzał wystrzeliła kindra w celu zmniejszania kosztu ich
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.KINDRA_FOLLOWER] == 1) kindraScene.wonFightWithKindra();
			else if (flags[kFLAGS.KINDRA_AFFECTION] >= 6) kindraScene.thirdWonFightWithKindra();
			else if (flags[kFLAGS.KINDRA_AFFECTION] >= 2 && flags[kFLAGS.KINDRA_AFFECTION] < 6) kindraScene.secondWonFightWithKindra();
			else kindraScene.firstWonFightWithKindra();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.KINDRA_FOLLOWER] == 1) kindraScene.lostFightWithKindra();
			else kindraScene.lostFightToKindra();
		}
		
		public function Kindra()
		{
			if (flags[kFLAGS.KINDRA_AFFECTION] < 7) {
				this.a = "the ";
				this.short = "sheep-morph archer";
				this.imageName = "kindra";
				this.long = "You fight against sheep-morph archer.";//6'4"
			}
			if (flags[kFLAGS.KINDRA_AFFECTION] >= 7) {
				this.a = "";
				this.short = "Kindra";
				this.imageName = "kindra";
				this.long = "You fight against Kindra.";//6'4"
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 1) {
				initStrTouSpeInte(30, 50, 100, 80);
				initLibSensCor(30, 40, 10);
				this.bonusHP = 50;
				this.level = 20;
				this.str += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 20 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 16 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 1740;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 2) {
				initStrTouSpeInte(40, 60, 120, 100);
				initLibSensCor(40, 40, 10);
				this.bonusHP = 100;
				this.level = 23;
				this.str += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 24 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 20 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 2160;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 3) {
				initStrTouSpeInte(50, 70, 140, 120);
				initLibSensCor(50, 40, 10);
				this.bonusHP = 150;
				this.level = 26;
				this.str += 15 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 42 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 36 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 15 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 3870;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 4) {
				initStrTouSpeInte(60, 80, 160, 140);
				initLibSensCor(70, 40, 10);
				this.bonusHP = 200;
				this.level = 29;
				this.str += 18 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 24 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 48 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 42 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 4590;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 5) {
				initStrTouSpeInte(70, 90, 180, 150);
				initLibSensCor(70, 40, 10);
				this.bonusHP = 250;
				this.level = 32;
				this.str += 21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 27 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 54 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 45 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 6720;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 6) {
				initStrTouSpeInte(70, 100, 200, 150);
				initLibSensCor(70, 40, 10);
				this.bonusHP = 300;
				this.level = 35;
				this.str += 21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 30 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 60 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 45 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 7080;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 7) {		//niedokończone
				initStrTouSpeInte(70, 100, 200, 150);
				initLibSensCor(70, 40, 10);
				this.bonusHP = 300;
				this.level = 35;
				this.str += 21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 30 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 60 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 45 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 177 * 40;
			}
			this.createVagina(false, VAGINA_WETNESS_NORMAL, VAGINA_LOOSENESS_TIGHT);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = ANAL_LOOSENESS_VIRGIN;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.tallness = 64;
			this.hipRating = HIP_RATING_BOYISH;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skinTone = "white";
			this.hairColor = "white";
			this.hairLength = 4;
			this.weaponName = "dagger";
			this.weaponVerb= "stab";
			this.weaponAttack = 10 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.weaponRangeName = "bow";//jak bedzie potem w camp to zrobić jej ulpszenie używanego łuku poza podnoszeniem lvl przez trening a potem jak stanie sie wiecej niż sheep-morph kolejna zmiana łuku
			this.weaponRangeVerb= "shoot";
			this.weaponRangeAttack = 20 + (5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "clothes";
			this.armorDef = 5 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusLust = 10;
			this.lust = 20;
			this.lustVuln = .95;
			this.gems = 0;
			this.drop = new ChainedDrop().
			//		add(armors.CHBIKNI,0.15).
					add(consumables.LG_SFRP,0.3).
					add(consumables.SHEEPMK,0.6);
			this.createPerk(PerkLib.JobRanger, 0, 0, 0, 0);
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 2) this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 3) this.createPerk(PerkLib.JobArcaneArcher, 0, 0, 0, 0);
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 4) this.createPerk(PerkLib.JobSoulArcher, 0, 0, 0, 0);
			this.createPerk(PerkLib.BasicEndurance, 0, 0, 0, 0);
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 2) this.createPerk(PerkLib.HalfStepToImprovedEndurance, 0, 0, 0, 0);
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 3) this.createPerk(PerkLib.ImprovedEndurance, 0, 0, 0, 0);
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 4) this.createPerk(PerkLib.HalfStepToAdvancedEndurance, 0, 0, 0, 0);
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 5) this.createPerk(PerkLib.AdvancedEndurance, 0, 0, 0, 0);
			this.createPerk(PerkLib.ArchersStaminaI, 0, 0, 0, 0);
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 4) this.createPerk(PerkLib.VitalShot, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}