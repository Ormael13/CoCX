/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;

use namespace CoC;
	
	public class Jinx extends Monster
	{
		private function jinxBaseAttack():void {
			jinxAyotechPistol();
			jinxAyotechPistol();
			jinxAyotechPistol();
		}
		
		private function jinxAyotechPistol():void {
			outputText("Ayotech maniac casually fire an ayotech pistol at you with high skill.");
			if (player.hasStatusEffect(StatusEffects.WindWall)) {
				outputText(" That is then stopped by wind wall.");
				player.addStatusValue(StatusEffects.WindWall,2,-1);
			}
			else {
				var damage:Number = 0;
				damage += this.weaponRangeAttack * 20;
				player.takePhysDamage(damage, true);
			}
			outputText("\n\n");
		}
		private function jinxAyotechCanon():void {
			outputText("Ayotech maniac casually fire an ayotech canon at you with high skill.");
			if (player.hasStatusEffect(StatusEffects.WindWall)) {
				outputText(" Still your wind wall manages to stops it.");
				player.addStatusValue(StatusEffects.WindWall,2,-1);
			}
			else {
				this.weaponRangeName = "ayotech canon";
				this.weaponRangeAttack *= 3;
				var damage:Number = 0;
				damage += this.weaponRangeAttack * 20;
				player.takePhysDamage(damage, true);
				this.weaponRangeName = "ayotech pistol";
				this.weaponRangeAttack /= 3;
			}
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
			this.createVagina(false, VaginaClass.WETNESS_DRY, VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,10,0,0,0);
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 120;
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_BUTTLESS;
			this.skin.setBaseOnly({color:"olive"});//zmienić?
			this.hairColor = "blue";//eyes: red
			this.hairLength = 20;
			initStrTouSpeInte(50, 50, 40, 40);
			initWisLibSensCor(40, 20, 10, 50);
			this.lustVuln = 0.85;
			this.drop = NO_DROP;
			//this.drop = new ChainedDrop()
			//		.add(useables.GOLCORE, 1/4);
			this.level = 15;
			//this.bonusHP = 200;
			this.weaponName = "ayotech gaunlets";
			this.weaponVerb = "smash";
			this.weaponAttack = 16;
			this.weaponRangeName = "ayotech pistol";
			this.weaponRangeVerb = "shoot";
			this.weaponRangeAttack = 12;
			this.armorName = "light ayo armor";//zamienić na coś innego?
			this.armorDef = 30;
			this.armorMDef = 5;
			//this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}