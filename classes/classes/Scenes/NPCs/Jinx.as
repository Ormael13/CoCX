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
	
	public class Jinx extends Monster
	{
		private function jinxBaseAttack():void {
			jinxAyotechPistol();
			jinxAyotechPistol();
			jinxAyotechPistol();
		}
		
		private function jinxAyotechPistol():void {
			outputText("Ayotech maniac casually fire an ayotech pistol at you with high skill.");
			var damage:Number = 0;
			damage += this.weaponRangeAttack * 20;
			player.takeDamage(damage, true);
			outputText("\n\n");
		}
		private function jinxAyotechCanon():void {
			outputText("Ayotech maniac casually fire an ayotech canon at you with high skill.");
			this.weaponRangeName = "ayotech canon";
			this.weaponRangeAttack = 36 + (8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			var damage:Number = 0;
			damage += this.weaponRangeAttack * 20;
			player.takeDamage(damage, true);
			this.weaponRangeName = "ayotech pistol";
			this.weaponRangeAttack = 12 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			outputText("\n\n");
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(2);
			if (choice == 0) jinxBaseAttack();
			if (choice == 1) jinxAyotechCanon();
			//if (choice == 2) sythAttack1();
		}
		
		public function Jinx() 
		{
			this.a = "the ";
			this.short = "ayotech maniac";
			this.imageName = "ayotech maniac";
			this.long = "You're currently fighting an ayotech maniac.";//change Jinx to Minx???
			this.plural = false;
			createBreastRow(Appearance.breastCupInverse("A"));
			this.createVagina(false, VAGINA_WETNESS_DRY, VAGINA_LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,10,0,0,0);
			this.ass.analLooseness = ANAL_LOOSENESS_VIRGIN;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 120;
			this.hipRating = HIP_RATING_BOYISH;
			this.buttRating = BUTT_RATING_BUTTLESS;
			this.skin.setBaseOnly({color:"olive"});//zmienić?
			this.hairColor = "blue";//eyes: red
			this.hairLength = 20;
			initStrTouSpeInte(50, 50, 40, 40);
			initLibSensCor(20, 10, 50);
			this.lustVuln = 0.85;
			this.drop = NO_DROP;
			//this.drop = new ChainedDrop()
			//		.add(useables.GOLCORE, 1/4);
			this.level = 15;
			//this.bonusHP = 200;
			this.weaponName = "ayotech gaunlets";
			this.weaponVerb = "smash";
			this.weaponAttack = 16 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.weaponRangeName = "ayotech pistol";
			this.weaponRangeVerb = "shoot";
			this.weaponRangeAttack = 12 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "light ayo armor";//zamienić na coś innego?
			this.armorDef = 30 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			//this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			this.str += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 800;//*20
			checkMonster();
		}
		
	}

}