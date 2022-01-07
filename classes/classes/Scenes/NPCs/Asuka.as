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

public class Asuka extends Monster
	{
		private function asukaAttack1():void {
			wrath -= 30;
			var damage:Number = eBaseStrengthDamage() * 2;
			outputText(capitalA + short + " swings her weapon with all her strength and slashes you. ");
			if (damage > 0) {
				if (hasStatusEffect(StatusEffects.FlameBlade)) {
					damage *= 1.1;
					damage = Math.round(damage);
					player.takeFireDamage(damage, true);
				}
				else player.takePhysDamage(damage, true);
			}
			statScreenRefresh();
			outputText("\n");
		}
		
		private function asukaAttack2():void {
			var damage:Number = ((str * 2) - rand(player.tou));
			outputText(capitalA + short + " whips at you with her tail, trying to sear you with her brilliant flames! ");
			if(damage <= 0 || player.getEvasionRoll()) outputText("You evade the strike.");
			else {
				outputText(capitalA + short + "'s tail catches you as you try to dodge.  Your [armor] sizzles, and you leap back with a yelp as she gives you a light burning. ");
				player.takeFireDamage(damage, true);
				if (player.hasStatusEffect(StatusEffects.BurnDoT)) player.addStatusValue(StatusEffects.BurnDoT, 1, 1);
				else {
					player.createStatusEffect(StatusEffects.BurnDoT,3,0.05,0,0);
					outputText(" Reeling in pain you begin to burn.");
				}
			}
		}
		/*
		private function asukaAttack3():void {
			
		}
		
		private function asukaAttack4():void {
			
		}
		
		private function asukaUltimateAttack1():void {
			
		}
		
		private function asukaUltimateAttack2():void {
			
		}
		*/
		private function asukaTripleThrust():void {
			outputText(capitalA + short + " ready " + weaponName + " and prepare to thrust it towards you.  ");
			if (player.getEvasionRoll()) outputText("You evade the strike.");
			else {
				soulforce -= 30;
				outputText(capitalA + short + weaponName + " hits you thrice.");
				asukaTripleThrust2();
				asukaTripleThrust2();
				asukaTripleThrust2();
			}
		}
		private function asukaTripleThrust2():void {
			var damage:Number = str;
			damage += eBaseStrengthDamage() * 0.5;
			if (weaponAttack < 51) damage *= (1 + (weaponAttack * 0.04));
			else if (weaponAttack >= 51 && weaponAttack < 101) damage *= (3 + ((weaponAttack - 50) * 0.035));
			else if (weaponAttack >= 101 && weaponAttack < 151) damage *= (4.75 + ((weaponAttack - 100) * 0.03));
			else if (weaponAttack >= 151 && weaponAttack < 201) damage *= (6.25 + ((weaponAttack - 150) * 0.025));
			else damage *= (7.5 + ((weaponAttack - 200) * 0.02));
			var d2:Number = 0.9;
			d2 += (rand(21) * 0.01);
			damage *= d2;
			var crit:Boolean = false;
			var critChance:int = 15;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			outputText(" ");
			if (hasStatusEffect(StatusEffects.FlameBlade)) player.takeFireDamage(damage, true);
			else player.takePhysDamage(damage, true);
			if (crit) outputText(" <b>*Critical Hit!*</b>");
		}
		
		private function asukaFlamesOfLove():void {
			var fireDMG:Number = Math.round(this.lust * 0.9);
			createStatusEffect(StatusEffects.AbilityCooldown1, 4, 0, 0, 0);
			this.lust -= fireDMG;
			fireDMG *= 2;
			outputText(capitalA + short + " starts concentrating on the lust flowing in her body, her veins, while imaging the joy of sharing her flames of love with you. Shortly after that, her lust starts to gather around her hands, getting hotter and hotter till it envelops her hands in flames.\n\n");
			outputText("And with almost orgasmic joy, she sends a wave of flames toward you while mumbling about 'sharing the flames of love'. ");
			player.takeFireDamage(fireDMG, true);
		}
		
		private function asukaBerserk():void {
			wrath -= 50;
			outputText(capitalA + short + " roars and unleashes her lustful fury in order to destroy you!\n\n");
			this.weaponAttack += (15 + (15 * (1 + player.newGamePlusMod())));
			createStatusEffect(StatusEffects.Lustzerking,10,0,0,0);
		}
		
		private function asukaFlameBlade():void {
			outputText(capitalA + short + " runs her tail across her weapon igniting it with raging flames.\n\n");
			createStatusEffect(StatusEffects.FlameBlade,10,0,0,0);
		}
		
		override protected function performCombatAction():void
		{
			wrath += 5;
			if (hasStatusEffect(StatusEffects.Lustzerking)) {
				wrath += 5;
				if (statusEffectv1(StatusEffects.Lustzerking) > 1) addStatusValue(StatusEffects.Lustzerking, 1, -1);
				else {
					this.weaponAttack -= (15 + (15 * (1 + player.newGamePlusMod())));
					removeStatusEffect(StatusEffects.Lustzerking);
				}
			}
			if (flags[kFLAGS.ASUKA_LVL_UP] < 1) {
				var choice1:Number = rand(4);
				if (choice1 == 0) {
					if (!hasStatusEffect(StatusEffects.Lustzerking) && wrath >= 50) asukaBerserk();
					else {
						if (wrath >= 30) asukaAttack1();
						else eAttack();
					}
				}
				if (choice1 >= 1) {
					if (!hasStatusEffect(StatusEffects.FlameBlade)) asukaFlameBlade();
					else {
						if (rand(2) == 0) asukaAttack2();
						else eAttack();
					}
				}
				if (choice1 == 2) {
					if (!hasStatusEffect(StatusEffects.AbilityCooldown1) && lust >= 50) asukaFlamesOfLove();
					else eAttack();
				}
				if (choice1 == 3) {
					if (soulforce >= 30) asukaTripleThrust();
					else eAttack();
				}
			}
		}
		
		override public function get long():String
		{
			var str:String = "";
			str += "You are fighting a salamander – a little over six foot tall woman with crimson scales covering her legs, back, and forearms, with a tail swishing menacingly behind her, ablaze with a red-hot fire.  Her auburn hair accents her deep blue eyes, while her body covers red bodysuit.  Her glaive is raised to her side, looking for any hole in your guard.";
			if (hasStatusEffect(StatusEffects.Lustzerking))
			{
				str += "\n\n<b>Looking at her posture and gaze indicates that she's currently under the effect of some sort of berserking state.</b>";
			}
			return str;
		}//po dorośnieciu nosi inne armory w czasie walki: pure - no change of armor beside making it look more durable so still red bodysuit,
		//balanced - skimpy bikini with cloth wrapped around chest instead of top and armor pieces at arms/legs/sides of torse or back in upper section (maybe smth liek that levitating heavy armor that only stick to body when you about to get hit), corrupted - Scandalous Succubus Clothing
		public function Asuka() 
		{
			if (flags[kFLAGS.ASUKA_LVL_UP] < 1) {
				initStrTouSpeInte(85, 85, 75, 90);
				initWisLibSensCor(90, 75, 50, 50);
				this.weaponAttack = 21;
				this.armorDef = 25;
				this.armorMDef = 5;
				this.bonusHP = 100;
				this.bonusLust = 140;
				this.level = 15;
			}/*
			if (flags[kFLAGS.ASUKA_LVL_UP] == 1) {
				initStrTouSpeInte(85, 85, 75, 90);
				initWisLibSensCor(90, 75, 50, 50);
				this.weaponAttack = 21;
				this.armorDef = 25;
				this.armorMDef = 5;
				this.bonusHP = 100;
				this.bonusLust = 140;
				this.level = 30;
			}
			if (flags[kFLAGS.ASUKA_LVL_UP] == 2) {
				initStrTouSpeInte(85, 85, 75, 90);
				initWisLibSensCor(90, 75, 50, 50);
				this.weaponAttack = 21;
				this.armorDef = 25;
				this.armorMDef = 5;
				this.bonusHP = 100;
				this.bonusLust = 140;
				this.level = 45;
			}
			if (flags[kFLAGS.ASUKA_LVL_UP] == 3) {
				initStrTouSpeInte(85, 85, 75, 90);
				initWisLibSensCor(90, 75, 50, 50);
				this.weaponAttack = 21;
				this.armorDef = 25;
				this.armorMDef = 5;
				this.bonusHP = 100;
				this.bonusLust = 140;
				this.level = 60;
			}
			if (flags[kFLAGS.ASUKA_LVL_UP] == 4) {
				initStrTouSpeInte(85, 85, 75, 90);
				initWisLibSensCor(90, 75, 50, 50);
				this.weaponAttack = 21;
				this.armorDef = 25;
				this.armorMDef = 5;
				this.bonusHP = 100;
				this.bonusLust = 140;
				this.level = 70;
			}*/
			{
				createBreastRow(Appearance.breastCupInverse("EE"));
				this.tallness = 75;
				this.hips.type = Hips.RATING_CURVY + 1;
				this.butt.type = Butt.RATING_LARGE;
				this.hairLength = 9;
				this.weaponName = "glaive";
				this.weaponVerb="cleave";
				this.armorName = "scales";
			}/*
			{ - jako dorosła salamandrzyca
				createBreastRow(Appearance.breastCupInverse("II"));
				this.tallness = 87;
				this.hips.type = Hips.RATING_CURVY + 3;
				this.butt.type = Butt.RATING_JIGGLY;
				this.hairLength = 39;
			}*/
			{
				this.a = "the ";
				this.short = "salamander";
			}
			this.imageName = "asuka";
			this.long = "";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_NORMAL);
			createStatusEffect(StatusEffects.BonusVCapacity,100,0,0,0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.skinTone = "light";
			this.hairColor = "auburn";
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
			this.createPerk(PerkLib.Lustzerker, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
			this.createPerk(PerkLib.BodyCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.FleshBodyApprenticeStage, 0, 0, 0, 0);
			//this.createPerk(PerkLib.Berzerker, 0, 0, 0, 0);
			checkMonster();
		}
	}
}