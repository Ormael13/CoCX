/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class Saiyan extends Monster
	{
		override public function defeated(hpVictory:Boolean):void {
			if (hpVictory) {
				
			}
			else {
				
			}
			SceneLib.combat.finishCombat();
		}
		
		public function Saiyan() 
		{
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 1) {//female
				this.long = "";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
				createBreastRow(Appearance.breastCupInverse("F"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
				this.tallness = 72;
				this.hips.type = Hips.RATING_CURVY + 3;
				this.butt.type = Butt.RATING_LARGE + 2;
				this.skinTone = "light";
				this.hairColor = "red";
				this.hairLength = 13;
				this.weaponName = "claw";
				this.weaponVerb="claw-slash";
				this.armorName = "skimpy black bikini";
				this.lust = 30;
				this.lustVuln = .8;
				if (statusEffectv1(StatusEffects.SaiyanNumber1a) == 1) {
					initStrTouSpeInte(130, 195, 330, 200);
					initWisLibSensCor(200, 230, 110, 80);
					this.weaponAttack = 54;
					this.armorDef = 16;
					this.armorMDef = 3;
					this.bonusHP = 200;
					this.bonusWrath = 100;
					this.bonusLust = 50;
					this.level = 18;
				}
				if (statusEffectv1(StatusEffects.SaiyanNumber1a) == 2) {
					
				}
				if (statusEffectv1(StatusEffects.SaiyanNumber1a) == 3) {
					
				}
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 2) {
				this.long = "";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
				createBreastRow(Appearance.breastCupInverse("F"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
				this.tallness = 72;
				this.hips.type = Hips.RATING_CURVY + 3;
				this.butt.type = Butt.RATING_LARGE + 2;
				this.skinTone = "light";
				this.hairColor = "red";
				this.hairLength = 13;
				initStrTouSpeInte(130, 195, 330, 200);
				initWisLibSensCor(200, 230, 110, 80);
				this.weaponAttack = 54;
				this.weaponName = "claw";
				this.weaponVerb="claw-slash";
				this.armorName = "skimpy black bikini";
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.bonusWrath = 100;
				this.bonusLust = 50;
				this.lust = 30;
				this.lustVuln = .8;
				this.level = 18;
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 3) {
				this.long = "";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
				createBreastRow(Appearance.breastCupInverse("F"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
				this.tallness = 72;
				this.hips.type = Hips.RATING_CURVY + 3;
				this.butt.type = Butt.RATING_LARGE + 2;
				this.skinTone = "light";
				this.hairColor = "red";
				this.hairLength = 13;
				initStrTouSpeInte(130, 195, 330, 200);
				initWisLibSensCor(200, 230, 110, 80);
				this.weaponAttack = 54;
				this.weaponName = "claw";
				this.weaponVerb="claw-slash";
				this.armorName = "skimpy black bikini";
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.bonusWrath = 100;
				this.bonusLust = 50;
				this.lust = 30;
				this.lustVuln = .8;
				this.level = 18;
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 4) {//female
				this.long = "";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
				createBreastRow(Appearance.breastCupInverse("F"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
				this.tallness = 72;
				this.hips.type = Hips.RATING_CURVY + 3;
				this.butt.type = Butt.RATING_LARGE + 2;
				this.skinTone = "light";
				this.hairColor = "red";
				this.hairLength = 13;
				initStrTouSpeInte(130, 195, 330, 200);
				initWisLibSensCor(200, 230, 110, 80);
				this.weaponAttack = 54;
				this.weaponName = "claw";
				this.weaponVerb="claw-slash";
				this.armorName = "skimpy black bikini";
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.bonusWrath = 100;
				this.bonusLust = 50;
				this.lust = 30;
				this.lustVuln = .8;
				this.level = 18;
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 5) {
				this.long = "";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
				createBreastRow(Appearance.breastCupInverse("F"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
				this.tallness = 72;
				this.hips.type = Hips.RATING_CURVY + 3;
				this.butt.type = Butt.RATING_LARGE + 2;
				this.skinTone = "light";
				this.hairColor = "red";
				this.hairLength = 13;
				initStrTouSpeInte(130, 195, 330, 200);
				initWisLibSensCor(200, 230, 110, 80);
				this.weaponAttack = 54;
				this.weaponName = "claw";
				this.weaponVerb="claw-slash";
				this.armorName = "skimpy black bikini";
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.bonusWrath = 100;
				this.bonusLust = 50;
				this.lust = 30;
				this.lustVuln = .8;
				this.level = 18;
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 6) {
				this.long = "";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
				createBreastRow(Appearance.breastCupInverse("F"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
				this.tallness = 72;
				this.hips.type = Hips.RATING_CURVY + 3;
				this.butt.type = Butt.RATING_LARGE + 2;
				this.skinTone = "light";
				this.hairColor = "red";
				this.hairLength = 13;
				initStrTouSpeInte(130, 195, 330, 200);
				initWisLibSensCor(200, 230, 110, 80);
				this.weaponAttack = 54;
				this.weaponName = "claw";
				this.weaponVerb="claw-slash";
				this.armorName = "skimpy black bikini";
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.bonusWrath = 100;
				this.bonusLust = 50;
				this.lust = 30;
				this.lustVuln = .8;
				this.level = 18;
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 7) {//female
				this.long = "";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
				createBreastRow(Appearance.breastCupInverse("F"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
				this.tallness = 72;
				this.hips.type = Hips.RATING_CURVY + 3;
				this.butt.type = Butt.RATING_LARGE + 2;
				this.skinTone = "light";
				this.hairColor = "red";
				this.hairLength = 13;
				initStrTouSpeInte(130, 195, 330, 200);
				initWisLibSensCor(200, 230, 110, 80);
				this.weaponAttack = 54;
				this.weaponName = "claw";
				this.weaponVerb="claw-slash";
				this.armorName = "skimpy black bikini";
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.bonusWrath = 100;
				this.bonusLust = 50;
				this.lust = 30;
				this.lustVuln = .8;
				this.level = 18;
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 8) {
				this.long = "";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
				createBreastRow(Appearance.breastCupInverse("F"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
				this.tallness = 72;
				this.hips.type = Hips.RATING_CURVY + 3;
				this.butt.type = Butt.RATING_LARGE + 2;
				this.skinTone = "light";
				this.hairColor = "red";
				this.hairLength = 13;
				initStrTouSpeInte(130, 195, 330, 200);
				initWisLibSensCor(200, 230, 110, 80);
				this.weaponAttack = 54;
				this.weaponName = "claw";
				this.weaponVerb="claw-slash";
				this.armorName = "skimpy black bikini";
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.bonusWrath = 100;
				this.bonusLust = 50;
				this.lust = 30;
				this.lustVuln = .8;
				this.level = 18;
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 9) {
				this.long = "";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
				createBreastRow(Appearance.breastCupInverse("F"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
				this.tallness = 72;
				this.hips.type = Hips.RATING_CURVY + 3;
				this.butt.type = Butt.RATING_LARGE + 2;
				this.skinTone = "light";
				this.hairColor = "red";
				this.hairLength = 13;
				initStrTouSpeInte(130, 195, 330, 200);
				initWisLibSensCor(200, 230, 110, 80);
				this.weaponAttack = 54;
				this.weaponName = "claw";
				this.weaponVerb="claw-slash";
				this.armorName = "skimpy black bikini";
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.bonusWrath = 100;
				this.bonusLust = 50;
				this.lust = 30;
				this.lustVuln = .8;
				this.level = 18;
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 10) {//female
				this.long = "";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
				createBreastRow(Appearance.breastCupInverse("F"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
				this.tallness = 72;
				this.hips.type = Hips.RATING_CURVY + 3;
				this.butt.type = Butt.RATING_LARGE + 2;
				this.skinTone = "light";
				this.hairColor = "red";
				this.hairLength = 13;
				initStrTouSpeInte(130, 195, 330, 200);
				initWisLibSensCor(200, 230, 110, 80);
				this.weaponAttack = 54;
				this.weaponName = "claw";
				this.weaponVerb="claw-slash";
				this.armorName = "skimpy black bikini";
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.bonusWrath = 100;
				this.bonusLust = 50;
				this.lust = 30;
				this.lustVuln = .8;
				this.level = 18;
			}
			this.a = "the ";
			this.short = "Saiyan";
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = 45 + rand(40);
			this.drop = new ChainedDrop().
					add(armors.S_SWMWR,1/12).
					add(consumables.L_DRAFT,1/4).
					add(consumables.MANTICV,0.7);
			//this.tailType = Tail.MANTICORE_PUSSYTAIL;
			this.tailRecharge = 0;
		}
		
	}

}