/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class RyuBiDragon extends Monster
	{
		private function ryubiAttack():void {
			outputText("With a growl, the dragon lashes out in a ferocious splay-fingered slash, it claws poised to rip into your flesh.  ");
			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) {
				outputText(capitalA + short + " completely misses you with a blind attack!");
			}
			//Miss/dodge
			else if(player.getEvasionRoll()) outputText("You dodge aside at the last second and it's claws whistle past you.");
			else {
				var damage:Number = 0;
				if (wrath >= 100) {
					wrath -= 100;
					damage += (((str + weaponAttack) * 2) - rand(player.tou) - player.armorDef);
				}
				else damage += ((str + weaponAttack) - rand(player.tou) - player.armorDef);
				//if (flags[kFLAGS.RYUBI_LVL_UP] >= 1) damage += (1 + (flags[kFLAGS.RYUBI_LVL_UP] * 0.1));
				//if (flags[kFLAGS.RYUBI_LVL_UP] >= 8) damage += (1 + (flags[kFLAGS.RYUBI_LVL_UP] * 0.2));
				//if (flags[kFLAGS.RYUBI_LVL_UP] >= 13) damage *= (1 + (flags[kFLAGS.RYUBI_LVL_UP] * 0.2));
				if (damage <= 0) outputText("It's claws scrape noisily but harmlessly off your [armor].");
				else {
					outputText("It's claws rip into you, leaving stinging wounds. ");
					damage = player.takePhysDamage(damage, true);
				}
			}
		}
		
		override protected function performCombatAction():void {
			ryubiAttack();
		}
		
		override public function defeated(hpVictory:Boolean):void {
			SceneLib.ryubi.RyuBiLost();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
			SceneLib.ryubi.RyuBiWins();
		}
		
		override public function get long():String {
			var str:String = "";
			str += "You are currently battling the mighty dragon. It body covers brownish scales with exception of the ";
			if (flags[kFLAGS.RYUBI_LVL_UP] == 4) str += "head and neck which is covered by mismatching mix of red, blue, white, black and green scales.";
			else if (flags[kFLAGS.RYUBI_LVL_UP] == 3) str += "head and neck which is covered by mismatching mix of red, blue, white, black and green scales.";
			else if (flags[kFLAGS.RYUBI_LVL_UP] == 2) str += "head and neck which is covered by mismatching mix of red, blue, white, black and green scales.";
			else if (flags[kFLAGS.RYUBI_LVL_UP] == 1) str += "head and neck which is covered by mismatching mix of red, blue, white, black and green scales.";
			else str += "head and neck which is covered by mismatching mix of red, blue, white, black and green scales.";
			str += " It lashes it's tail along the ground, with claws spread and teeth bared ferociously.";
			return str;
		}
		
		public function RyuBiDragon() 
		{
			if (flags[kFLAGS.RYUBI_LVL_UP] == 0) {
				initStrTouSpeInte(100, 100, 100, 10);
				initWisLibSensCor(10, 10, 10, 50);
				this.tallness = 17*12;
				this.weaponAttack = 25;
				this.armorDef = 25;
				this.armorMDef = 25;
				this.lustVuln = .01;
				this.bonusHP = 50;
				this.bonusLust = 20;
				this.level = 0;
			}
			if (flags[kFLAGS.RYUBI_LVL_UP] == 1) {
				initStrTouSpeInte(100, 100, 20, 10);
				initWisLibSensCor(10, 50, 35, 50);
				this.tallness = 20*12;
				this.weaponAttack = 50;
				this.armorDef = 50;
				this.armorMDef = 50;
				this.lustVuln = .02;
				this.bonusHP = 50;
				this.bonusLust = 10;
				this.level = 3;
			}
			if (flags[kFLAGS.RYUBI_LVL_UP] == 2) {
				initStrTouSpeInte(110, 120, 30, 25);
				initWisLibSensCor(25, 50, 35, 50);
				this.tallness = 23*12;
				this.weaponAttack = 7;
				this.armorDef = 7;
				this.armorMDef = 7;
				this.lustVuln = .03;
				this.bonusHP = 100;
				this.bonusLust = 20;
				this.level = 6;
			}
			if (flags[kFLAGS.RYUBI_LVL_UP] == 3) {
				initStrTouSpeInte(120, 140, 40, 40);
				initWisLibSensCor(40, 50, 35, 50);
				this.tallness = 28*12;
				this.weaponAttack = 10;
				this.armorDef = 10;
				this.armorMDef = 10;
				this.lustVuln = .04;
				this.bonusHP = 150;
				this.bonusLust = 30;
				this.level = 9;
			}
			if (flags[kFLAGS.RYUBI_LVL_UP] == 4) {
				initStrTouSpeInte(130, 160, 50, 60);
				initWisLibSensCor(60, 50, 35, 50);
				this.tallness = 33*12;
				this.weaponAttack = 15;
				this.armorDef = 15;
				this.armorMDef = 15;
				this.lustVuln = .05;
				this.bonusHP = 200;
				this.bonusLust = 40;
				this.level = 12;
			}
			if (flags[kFLAGS.RYUBI_LVL_UP] == 5) {
				initStrTouSpeInte(140, 180, 60, 80);
				initWisLibSensCor(80, 50, 35, 50);
				this.tallness = 38*12;
				this.weaponAttack = 20;
				this.armorDef = 20;
				this.armorMDef = 20;
				this.lustVuln = .07;
				this.bonusHP = 250;
				this.bonusLust = 50;
				this.level = 15;
			}
			if (flags[kFLAGS.RYUBI_LVL_UP] == 6) {
				initStrTouSpeInte(150, 200, 70, 100);
				initWisLibSensCor(100, 50, 35, 50);
				this.tallness = 43*12;
				this.weaponAttack = 25;
				this.armorDef = 25;
				this.armorMDef = 25;
				this.bonusHP = 300;
				this.bonusLust = 60;
				this.level = 18;
			}
			if (flags[kFLAGS.RYUBI_LVL_UP] == 7) {
				initStrTouSpeInte(150, 200, 70, 100);
				initWisLibSensCor(100, 50, 35, 50);
				this.tallness = 48*12;
				this.weaponAttack = 36;
				this.armorDef = 54;
				this.armorMDef = 54;
				this.bonusHP = 300;
				this.bonusLust = 60;
				this.level = 24;
			}
			if (flags[kFLAGS.RYUBI_LVL_UP] == 8) {
				initStrTouSpeInte(150, 200, 70, 100);
				initWisLibSensCor(100, 50, 35, 50);
				this.tallness = 50*12;
				this.weaponAttack = 36;
				this.armorDef = 54;
				this.armorMDef = 54;
				this.bonusHP = 300;
				this.bonusLust = 60;
				this.level = 30;
			}
			if (flags[kFLAGS.RYUBI_LVL_UP] == 8) {
				initStrTouSpeInte(150, 200, 70, 100);
				initWisLibSensCor(100, 50, 35, 50);
				this.tallness = 52*12;
				this.weaponAttack = 36;
				this.armorDef = 54;
				this.armorMDef = 54;
				this.bonusHP = 300;
				this.bonusLust = 60;
				this.level = 36;
			}
			if (flags[kFLAGS.RYUBI_LVL_UP] == 8) {
				initStrTouSpeInte(150, 200, 70, 100);
				initWisLibSensCor(100, 50, 35, 50);
				this.tallness = 54*12;
				this.weaponAttack = 36;
				this.armorDef = 54;
				this.armorMDef = 54;
				this.bonusHP = 300;
				this.bonusLust = 60;
				this.level = 42;
			}
			this.a = "the ";
			this.short = "mighty dragon";
			this.imageName = "ryubidragon";
			this.long = "";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_NORMAL);
			createStatusEffect(StatusEffects.BonusVCapacity,10,0,0,0);
			createBreastRow(Appearance.breastCupInverse("A"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.skin.base.color = "white";
			this.hairColor = "black";
			this.hairLength = 1;
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.armorName = "scales";
			this.lust = 20;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.gems = 5 + rand(3);
			this.drop = new ChainedDrop().add(useables.D_SCALE, 0.1);
			this.faceType = Face.DRAGON;
			this.tongue.type = Tongue.DRACONIC;
			this.ears.type = Ears.DRAGON;
			this.horns.type = Horns.DRACONIC_X4_12_INCH_LONG;
			this.horns.count = 4;
			this.wings.type = Wings.DRACONIC_HUGE;
			this.lowerBody = LowerBody.DRAGON;
			this.tailType = Tail.DRACONIC;
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGodType, 0, 0, 0, 0);
			if (flags[kFLAGS.RYUBI_LVL_UP] < 2) this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			if (flags[kFLAGS.RYUBI_LVL_UP] >= 2 && flags[kFLAGS.RYUBI_LVL_UP] < 8) this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
			if (flags[kFLAGS.RYUBI_LVL_UP] >= 8) this.createPerk(PerkLib.EnemyColossalType, 0, 0, 0, 0);
			/*if (flags[kFLAGS.RYUBI_LVL_UP] >= 1) 
			if (flags[kFLAGS.RYUBI_LVL_UP] >= 2) 
			if (flags[kFLAGS.RYUBI_LVL_UP] >= 3) 
			if (flags[kFLAGS.RYUBI_LVL_UP] >= 4) 
			if (flags[kFLAGS.RYUBI_LVL_UP] >= 5) */
			if (flags[kFLAGS.RYUBI_LVL_UP] >= 6) this.lustVuln = .1;
			//if (flags[kFLAGS.RYUBI_LVL_UP] >= 7) 
			checkMonster();
		}
		
	}

}