/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.internals.*;

public class Rangiku extends Monster
	{
		private function rangikuAttack1():void {
			wrath -= 30;
			var damage:Number = 0;
			damage += eBaseStrengthDamage();
			damage *= 2;
			outputText(capitalA + short + " lift it weapon with all his strenght and smash it on your head. ");
			if(damage > 0) damage = player.takePhysDamage(damage, true);
			statScreenRefresh();
			outputText("\n");
		}
		/*
		private function rangikuAttack2():void {
			
		}
		
		private function rangikuAttack3():void {
			
		}
		
		private function rangikuAttack4():void {
			
		}
		
		private function rangikuUltimateAttack1():void {
			
		}
		
		private function rangikuUltimateAttack2():void {
			
		}
		*/
		private function rangikuBerserk():void {
			wrath -= 50;
			outputText("Salamander roar and unleash her lustful fury in order to destroy you!\n\n");
			this.weaponAttack += (40 + (40 * (1 + player.newGamePlusMod)));
			createStatusEffect(StatusEffects.Lustzerking,10,0,0,0);
		}
		
		override protected function performCombatAction():void
		{
			wrath += 5;
			if (hasStatusEffect(StatusEffects.Lustzerking)) {
				wrath += 5;
				if (statusEffectv1(StatusEffects.Lustzerking) > 1) addStatusValue(StatusEffects.Lustzerking, 1, -1);
				else {
					this.weaponAttack -= (40 + (40 * (1 + player.newGamePlusMod)));
					removeStatusEffect(StatusEffects.Lustzerking);
				}
			}
			if (flags[kFLAGS.RANGIKU_LVL_UP] < 1) {
				var choice1:Number = rand(4);
				if (choice1 == 0) {
					if (!hasStatusEffect(StatusEffects.Lustzerking) && wrath >= 50) rangikuBerserk();
					else eAttack();
				}
				if (choice1 == 1) {
					if (wrath >= 30) rangikuAttack1();
					else eAttack();
				}
				if (choice1 >= 2) eAttack();
			}
		}
		
		override public function get long():String
		{
			var str:String = "";
			str += "You are fighting a salamander – a little over seven foot tall woman with crimson scales covering her legs, back, and forearms, with a tail swishing menacingly behind her, ablaze with a red-hot fire.  Her strawberry blonde hair accents her sapphire eyes, while her body covers black robe.  Her dual large axes are raised to her side, looking for any hole in your guard.";
			if (hasStatusEffect(StatusEffects.Lustzerking))
			{
				str += "\n\n<b>Looking at her posture and gaze indicates that she's currently under effect of some sort of berserking state.</b>";
			}
			return str;
		}
		
		public function Rangiku() 
		{
			this.a = "the ";
			this.short = "salamander";
			this.imageName = "rangiku";
			this.long = "";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_NORMAL);
			createStatusEffect(StatusEffects.BonusVCapacity,120,0,0,0);
			createBreastRow(Appearance.breastCupInverse("G"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 93;
			this.hips.type = Hips.RATING_CURVY + 3;
			this.butt.type = Butt.RATING_JIGGLY;
			this.skinTone = "light";
			this.hairColor = "strawberry blonde";
			this.hairLength = 39;
			if (flags[kFLAGS.RANGIKU_LVL_UP] < 1) {
				initStrTouSpeInte(110, 120, 100, 200);
				initWisLibSensCor(200, 250, 200, 50);
				this.weaponName = "dual large axes";
				this.weaponVerb="cleaves";
				this.weaponAttack = 26;
				this.armorName = "black robe";
				this.armorDef = 21;
				this.bonusHP = 100;
				this.level = 15;
			}/*
			if (flags[kFLAGS.RANGIKU_LVL_UP] == 1) {
				initStrTouSpeInte(110, 120, 100, 200);
				initWisLibSensCor(200, 250, 200, 50);
				this.weaponName = "dual large axes";
				this.weaponVerb="cleaves";
				this.weaponAttack = 26;
				this.armorName = "black robe";
				this.armorDef = 21;
				this.bonusHP = 100;
				this.level = 30;
			}
			if (flags[kFLAGS.RANGIKU_LVL_UP] == 2) {
				initStrTouSpeInte(110, 120, 100, 200);
				initWisLibSensCor(200, 250, 200, 50);
				this.weaponName = "dual large axes";
				this.weaponVerb="cleaves";
				this.weaponAttack = 26;
				this.armorName = "black robe";
				this.armorDef = 21;
				this.bonusHP = 100;
				this.level = 45;
			}
			if (flags[kFLAGS.RANGIKU_LVL_UP] == 3) {
				initStrTouSpeInte(110, 120, 100, 200);
				initWisLibSensCor(200, 250, 200, 50);
				this.weaponName = "dual large axes";
				this.weaponVerb="cleaves";
				this.weaponAttack = 26;
				this.armorName = "black robe";
				this.armorDef = 21;
				this.bonusHP = 100;
				this.level = 60;
			}
			if (flags[kFLAGS.RANGIKU_LVL_UP] == 4) {
				initStrTouSpeInte(110, 120, 100, 200);
				initWisLibSensCor(200, 250, 200, 50);
				this.weaponName = "dual large axes";
				this.weaponVerb="cleaves";
				this.weaponAttack = 26;
				this.armorName = "black robe";
				this.armorDef = 21;
				this.bonusHP = 100;
				this.level = 70;
			}*/
			this.bonusLust = 20;
			this.lust = 30;
			this.lustVuln = .35;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = 15 + rand(8);
			this.drop = new ChainedDrop().
					//add(armors.CHBIKNI,1/20).
					//add(weapons.SCIMITR,1/20).
					add(consumables.SALAMFW,0.7);
			this.arms.type = Arms.SALAMANDER;
			this.lowerBody = LowerBody.SALAMANDER;
			this.tailType = Tail.SALAMANDER;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Berzerker, 0, 0, 0, 0);
			this.createPerk(PerkLib.Lustzerker, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}