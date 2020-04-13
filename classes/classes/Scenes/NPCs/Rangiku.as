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
			outputText(capitalA + short + " lift it weapon with all her strenght and smash it on your head. ");
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
		private function rangikuRampage():void {
			if (hasStatusEffect(StatusEffects.AbilityChanneled)) {
				removeStatusEffect(StatusEffects.AbilityChanneled);
				if (hasStatusEffect(StatusEffects.Stunned) || hasStatusEffect(StatusEffects.FrozenSolid) || hasStatusEffect(StatusEffects.StunnedTornado) || hasStatusEffect(StatusEffects.Fear) || hasStatusEffect(StatusEffects.Constricted) || hasStatusEffect(StatusEffects.ConstrictedScylla) || hasStatusEffect(StatusEffects.GooEngulf) || hasStatusEffect(StatusEffects.EmbraceVampire) || hasStatusEffect(StatusEffects.Pounce)) {
					outputText(capitalA + short + " reels in frustration as her concentration breaks under your assaults.\n\n");
				}
				else {
					outputText("A terrifying red aura of power shroud her body as she shout a loud thundering war cry and enter a murderous rampage.\n\n");
					createStatusEffect(StatusEffects.OniRampage,12,0,0,0);
				}
			}
			else {
				fatigue += 50;
				outputText("She crouch and lift a leg then another in alternance, stomping the ground as she focus her anger.");
				createStatusEffect(StatusEffects.AbilityChanneled, 0, 0, 0, 0);
			}
		}
		
		override protected function performCombatAction():void
		{
			wrath += 5;
			if (hasStatusEffect(StatusEffects.AbilityChanneled)) rangikuRampage();
			else if (flags[kFLAGS.RANGIKU_LVL_UP] < 1) {
				var choice1:Number = rand(4);
				if (choice1 == 0) {
					if (!hasStatusEffect(StatusEffects.OniRampage) && fatigue + 50 <= maxFatigue()) rangikuRampage();
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
			str += "You are fighting an oni – a little over seven foot tall woman with pale skin.  Her strawberry blonde hair accents her sapphire eyes, while her body covers black robe.  Her dual large axes are raised to her side, looking for any hole in your guard.";
			if (hasStatusEffect(StatusEffects.Hypermode))
			{
				str += "\n\n<b>Looking at her posture and gaze indicates that she's currently under effect of some sort of rampage state.</b>";
			}
			return str;
		}
		
		public function Rangiku() 
		{
			this.a = "the ";
			this.short = "oni";
			this.imageName = "rangiku";
			this.long = "";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_NORMAL);
			createStatusEffect(StatusEffects.BonusVCapacity,100,0,0,0);
			createBreastRow(Appearance.breastCupInverse("K"));//all god(ess) of war heralds if female would end up with K cup and been bit taller than race standars i think xD
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 92;
			this.hips.type = Hips.RATING_CURVY + 4;
			this.butt.type = Butt.RATING_JIGGLY + 1;
			this.skinTone = "pale";
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
				this.armorMDef = 7;
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
				this.armorMDef = 7;
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
				this.armorMDef = 7;
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
				this.armorMDef = 7;
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
				this.armorMDef = 7;
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