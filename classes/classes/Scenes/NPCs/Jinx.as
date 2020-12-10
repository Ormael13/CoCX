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
			outputText("Ayotech maniac casually fires "+this.weaponRangeName+" at you with high skill. ");
			if (player.hasStatusEffect(StatusEffects.WindWall)) {
				outputText("That is then stopped by wind wall.");
				player.addStatusValue(StatusEffects.WindWall,2,-1);
			}
			else {
				jinxBaseAttackDamage();
				jinxBaseAttackDamage();
				jinxBaseAttackDamage();
			}
			outputText("\n\n");
		}
		private function jinxBaseAttackDamage():void {
			var damage:Number = 0;
			damage += this.weaponRangeAttack * 20;
			player.takePhysDamage(damage, true);
		}
		private function jinxAyotechCanon():void {
			mana -= 50;
			if (EngineCore.silly()) this.weaponRangeName = "Fishbones";
			else this.weaponRangeName = "ayotech canon";
			outputText("Ayotech maniac casually fires "+this.weaponRangeName+" at you with high skill. ");
			if (player.hasStatusEffect(StatusEffects.WindWall)) {
				outputText("Still your wind wall manages to stops it.");
				player.addStatusValue(StatusEffects.WindWall,2,-3);
			}
			else {
				var damage:Number = 0;
				damage += this.weaponRangeAttack * 100;
				//jeśli pc ma team atak jest traktowany jako aoe ^^
				player.takePhysDamage(damage, true);
			}
			if (EngineCore.silly()) this.weaponRangeName = "Pow-Pow";
			else this.weaponRangeName = "ayotech minigun";
			outputText("\n\n");
		}
		
		private function jinxAyotechPistol():void {
			if (EngineCore.silly()) this.weaponRangeName = "Zapper";
			else this.weaponRangeName = "ayotech pistol";
			var damage:Number = 0;
			damage += this.weaponRangeAttack * 20;
			player.takePhysDamage(damage, true);
			if (EngineCore.silly()) this.weaponRangeName = "Pow-Pow";
			else this.weaponRangeName = "ayotech minigun";
			outputText("\n\n");//speed debuff on pc for few rounds
		}
		
		private function jinxAyotechGrenades():void {
			outputText("Ayotech maniac casually throws "+(EngineCore.silly()?"Flame Chompers":"ayotech grenades")+" at you with high skill. ");//stun for 1-2 turns
		}
		
		private function jinxAyotechSuperRocket():void {
			if (EngineCore.silly()) this.weaponRangeName = "Super Mega Death Rocket";
			else this.weaponRangeName = "ayotech rocket";
			var damage:Number = 0;
			damage += this.weaponRangeAttack * 20;
			player.takePhysDamage(damage, true);
			//jeśli pc ma team atak jest traktowany jako aoe ^^
			if (EngineCore.silly()) this.weaponRangeName = "Pow-Pow";
			else this.weaponRangeName = "ayotech minigun";
			outputText("\n\n");
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(2);
			if (choice == 0) jinxBaseAttack();
			if (choice == 1) {
				if ((mana - 50) >= 0) jinxAyotechCanon();
				else jinxBaseAttack();
			}
			//if (choice == 2) jinxAyotechPistol();
			//if (choice == 3) jinxAyotechGrenades();
			//if (choice == 4) jinxAyotechSuperRocket();
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
			this.weaponName = "ayotech gaunlets";
			this.weaponVerb = "smash";
			this.weaponAttack = 16;
			if (EngineCore.silly()) this.weaponRangeName = "Pow-Pow";
			else this.weaponRangeName = "ayotech minigun";
			this.weaponRangeVerb = "shoot";
			this.weaponRangeAttack = 12;
			this.armorName = "light ayo armor";//zamienić na coś innego?
			this.armorDef = 30;
			this.armorMDef = 5;
			//this.bonusHP = 200;
			this.bonusLust = 45;
			this.lustVuln = 0.85;
			this.drop = NO_DROP;
			//this.drop = new ChainedDrop()
			//		.add(useables.GOLCORE, 1/4);
			this.level = 15;
			//this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}