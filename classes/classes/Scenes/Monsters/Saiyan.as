/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
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
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 1) {//female (change her to diff female stats)
				this.long = "";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
				createBreastRow(Appearance.breastCupInverse("G"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
				this.tallness = 72;
				this.hips.type = Hips.RATING_CURVY + 3;
				this.butt.type = Butt.RATING_LARGE + 2;
				this.skinTone = "light";
				this.hairColor = "green";
				this.hairLength = 13;
				this.weaponName = "fist";
				this.weaponVerb="punch";
				this.armorName = "skimpy black bikini";
				this.lust = 30;
				this.lustVuln = .8;
				if (statusEffectv2(StatusEffects.SaiyanNumber1a) == 1) {
					initStrTouSpeInte(20, 20, 20, 50);
					initWisLibSensCor(50, 200, 100, 50);
					this.weaponAttack = 5;
					this.armorDef = 5;
					this.armorMDef = 5;
					this.bonusHP = 20;
					this.bonusWrath = 5;
					this.bonusLust = 318;
					this.level = 18;
				}
				if (statusEffectv2(StatusEffects.SaiyanNumber1a) == 2) {
					
				}
				if (statusEffectv2(StatusEffects.SaiyanNumber1a) == 3) {
					
				}
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 2) {
				this.long = "";
				this.createCock(5.5, 1, CockTypesEnum.HUMAN);
				this.balls = 2;
				this.ballSize = 2;
				this.cumMultiplier = 2;
				createBreastRow(Appearance.breastCupInverse("flat"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_NORMAL;
				this.tallness = 72;
				this.hips.type = Hips.RATING_BOYISH;
				this.butt.type = Butt.RATING_TIGHT;
				this.skinTone = "light";
				this.hairColor = "red";
				this.hairLength = 5;
				this.weaponAttack = 54;
				this.weaponName = "fist";
				this.weaponVerb="punch";
				this.armorName = "shorts";
				this.lust = 30;
				this.lustVuln = .8;
				if (statusEffectv2(StatusEffects.SaiyanNumber2a) == 1) {
					initStrTouSpeInte(130, 195, 330, 80);
					initWisLibSensCor(80, 30, 80, 50);
					this.weaponAttack = 54;
					this.armorDef = 16;
					this.armorMDef = 3;
					this.bonusHP = 200;
					this.bonusWrath = 100;
					this.bonusLust = 128;
					this.level = 18;
				}
				if (statusEffectv2(StatusEffects.SaiyanNumber2a) == 2) {
					
				}
				if (statusEffectv2(StatusEffects.SaiyanNumber2a) == 3) {
					
				}
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 3) {
				this.long = "";
				this.createCock(5.5, 1, CockTypesEnum.HUMAN);
				this.balls = 2;
				this.ballSize = 2;
				this.cumMultiplier = 2;
				createBreastRow(Appearance.breastCupInverse("flat"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_NORMAL;
				this.tallness = 72;
				this.hips.type = Hips.RATING_BOYISH;
				this.butt.type = Butt.RATING_TIGHT;
				this.skinTone = "light";
				this.hairColor = "red";
				this.hairLength = 13;
				initStrTouSpeInte(130, 195, 330, 200);
				initWisLibSensCor(200, 230, 110, 80);
				this.weaponAttack = 54;
				this.weaponName = "fist";
				this.weaponVerb="punch";
				this.armorName = "shorts";
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.bonusWrath = 100;
				this.bonusLust = 358;
				this.lust = 30;
				this.lustVuln = .8;
				this.level = 18;
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 4) {//female
				this.long = "";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
				createBreastRow(Appearance.breastCupInverse("E"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
				this.tallness = 72;
				this.hips.type = Hips.RATING_CURVY + 3;
				this.butt.type = Butt.RATING_LARGE + 2;
				this.skinTone = "light";
				this.hairColor = "green";
				this.hairLength = 13;
				this.weaponName = "fist";
				this.weaponVerb="punch";
				this.armorName = "skimpy black bikini";
				this.lust = 30;
				this.lustVuln = .8;
				if (statusEffectv2(StatusEffects.SaiyanNumber4a) == 1) {
					initStrTouSpeInte(130, 195, 330, 50);
					initWisLibSensCor(50, 200, 100, 50);
					this.weaponAttack = 54;
					this.armorDef = 16;
					this.armorMDef = 3;
					this.bonusHP = 200;
					this.bonusWrath = 100;
					this.bonusLust = 318;
					this.level = 18;
				}
				if (statusEffectv2(StatusEffects.SaiyanNumber4a) == 2) {
					
				}
				if (statusEffectv2(StatusEffects.SaiyanNumber4a) == 3) {
					
				}
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 5) {
				this.long = "";
				this.createCock(5.5, 1, CockTypesEnum.HUMAN);
				this.balls = 2;
				this.ballSize = 2;
				this.cumMultiplier = 2;
				createBreastRow(Appearance.breastCupInverse("flat"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_NORMAL;
				this.tallness = 72;
				this.hips.type = Hips.RATING_BOYISH;
				this.butt.type = Butt.RATING_TIGHT;
				this.skinTone = "light";
				this.hairColor = "red";
				this.hairLength = 13;
				initStrTouSpeInte(130, 195, 330, 200);
				initWisLibSensCor(200, 230, 110, 80);
				this.weaponAttack = 54;
				this.weaponName = "fist";
				this.weaponVerb="punch";
				this.armorName = "shorts";
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.bonusWrath = 100;
				this.bonusLust = 358;
				this.lust = 30;
				this.lustVuln = .8;
				this.level = 18;
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 6) {
				this.long = "";
				this.createCock(5.5, 1, CockTypesEnum.HUMAN);
				this.balls = 2;
				this.ballSize = 2;
				this.cumMultiplier = 2;
				createBreastRow(Appearance.breastCupInverse("flat"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_NORMAL;
				this.tallness = 72;
				this.hips.type = Hips.RATING_BOYISH;
				this.butt.type = Butt.RATING_TIGHT;
				this.skinTone = "light";
				this.hairColor = "red";
				this.hairLength = 13;
				initStrTouSpeInte(130, 195, 330, 200);
				initWisLibSensCor(200, 230, 110, 80);
				this.weaponAttack = 54;
				this.weaponName = "fist";
				this.weaponVerb="punch";
				this.armorName = "shorts";
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.bonusWrath = 100;
				this.bonusLust = 358;
				this.lust = 30;
				this.lustVuln = .8;
				this.level = 18;
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 7) {//female
				this.long = "";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
				createBreastRow(Appearance.breastCupInverse("C"));
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
				this.weaponName = "fist";
				this.weaponVerb="punch";
				this.armorName = "skimpy black bikini";
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.bonusWrath = 100;
				this.bonusLust = 358;
				this.lust = 30;
				this.lustVuln = .8;
				this.level = 18;
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 8) {
				this.long = "";
				this.createCock(5.5, 1, CockTypesEnum.HUMAN);
				this.balls = 2;
				this.ballSize = 2;
				this.cumMultiplier = 2;
				createBreastRow(Appearance.breastCupInverse("flat"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_NORMAL;
				this.tallness = 72;
				this.hips.type = Hips.RATING_BOYISH;
				this.butt.type = Butt.RATING_TIGHT;
				this.skinTone = "light";
				this.hairColor = "red";
				this.hairLength = 13;
				initStrTouSpeInte(130, 195, 330, 200);
				initWisLibSensCor(200, 230, 110, 80);
				this.weaponAttack = 54;
				this.weaponName = "fist";
				this.weaponVerb="punch";
				this.armorName = "shorts";
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.bonusWrath = 100;
				this.bonusLust = 358;
				this.lust = 30;
				this.lustVuln = .8;
				this.level = 18;
			}
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 9) {//female
				this.long = "";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
				createBreastRow(Appearance.breastCupInverse("A"));
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
				this.weaponName = "fist";
				this.weaponVerb="punch";
				this.armorName = "skimpy black bikini";
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.bonusWrath = 100;
				this.bonusLust = 358;
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
			this.tailType = Tail.MONKEY;
			this.tailRecharge = 0;
			checkMonster();
		}
		
	}

}