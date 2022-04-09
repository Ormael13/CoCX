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
import classes.Scenes.SceneLib;

	public class Neisa extends Monster
	{
		
		public function Neisa() 
		{//  She's snarling at you from behind her massive shield, stamping her hooves in irritation as she prepares to lay into you.  Her skin is dusky, nearly chocolate except for a few white spots spattered over her body.  She wears a tight silk shirt and a corset that barely supports her bountiful breasts, but it's hard to get a good look at them behind her giant shield.
			if (flags[kFLAGS.NEISA_LVL_UP] == 1) {
				initStrTouSpeInte(50, 80, 50, 44);
				initWisLibSensCor(44, 52, 25, 50);
				this.weaponAttack = 12;
				this.armorDef = 0;
				this.armorMDef = 0;
				this.bonusHP = 200;
				this.bonusLust = 80;
				this.level = 3;
			}
			if (flags[kFLAGS.NEISA_LVL_UP] == 2) {
				initStrTouSpeInte(65, 102, 60, 52);
				initWisLibSensCor(52, 58, 30, 50);
				this.weaponAttack = 15;
				this.armorDef = 8;
				this.armorMDef = 2;
				this.bonusHP = 400;
				this.bonusLust = 97;
				this.level = 9;
			}
			if (flags[kFLAGS.NEISA_LVL_UP] == 3) {
				initStrTouSpeInte(80, 124, 70, 60);
				initWisLibSensCor(60, 64, 35, 50);
				this.weaponAttack = 18;
				this.armorDef = 16;
				this.armorMDef = 4;
				this.bonusHP = 600;
				this.bonusLust = 114;
				this.level = 15;
			}
			if (flags[kFLAGS.NEISA_LVL_UP] == 4) {
				initStrTouSpeInte(95, 146, 80, 68);
				initWisLibSensCor(68, 70, 40, 50);
				this.weaponAttack = 21;
				this.armorDef = 24;
				this.armorMDef = 6;
				this.bonusHP = 800;
				this.bonusLust = 131;
				this.level = 21;
			}
			if (flags[kFLAGS.NEISA_LVL_UP] == 5) {
				initStrTouSpeInte(110, 168, 90, 76);
				initWisLibSensCor(76, 76, 45, 50);
				this.weaponAttack = 24;
				this.armorDef = 32;
				this.armorMDef = 8;
				this.bonusHP = 1000;
				this.bonusLust = 148;
				this.level = 27;
			}
			if (flags[kFLAGS.NEISA_LVL_UP] == 6) {
				initStrTouSpeInte(125, 190, 100, 84);
				initWisLibSensCor(84, 82, 50, 50);
				this.weaponAttack = 27;
				this.armorDef = 40;
				this.armorMDef = 10;
				this.bonusHP = 1200;
				this.bonusLust = 165;
				this.level = 33;
			}
			if (flags[kFLAGS.NEISA_LVL_UP] == 7) {
				initStrTouSpeInte(140, 212, 110, 92);
				initWisLibSensCor(92, 88, 55, 50);
				this.weaponAttack = 30;
				this.armorDef = 48;
				this.armorMDef = 12;
				this.bonusHP = 1400;
				this.bonusLust = 182;
				this.level = 39;
			}
			if (flags[kFLAGS.NEISA_LVL_UP] == 8) {
				initStrTouSpeInte(155, 234, 120, 100);
				initWisLibSensCor(100, 94, 60, 50);
				this.weaponAttack = 33;
				this.armorDef = 56;
				this.armorMDef = 14;
				this.bonusHP = 1600;
				this.bonusLust = 199;
				this.level = 45;
			}
			if (flags[kFLAGS.NEISA_LVL_UP] == 9) {
				initStrTouSpeInte(170, 256, 130, 108);
				initWisLibSensCor(108, 100, 65, 50);
				this.weaponAttack = 36;
				this.armorDef = 64;
				this.armorMDef = 16;
				this.bonusHP = 1800;
				this.bonusLust = 216;
				this.level = 51;
			}
			if (flags[kFLAGS.NEISA_LVL_UP] == 10) {
				initStrTouSpeInte(185, 278, 140, 116);
				initWisLibSensCor(116, 106, 70, 50);
				this.weaponAttack = 39;
				this.armorDef = 72;
				this.armorMDef = 18;
				this.bonusHP = 2000;
				this.bonusLust = 233;
				this.level = 57;
			}//level up giving 2x all growns and so follow next level ups's as long each npc break lvl 100 (also makes npc use new better gear) (also makes npc use new better gear)
			this.a = "";
			this.short = "Neisa";
			this.imageName = "Neisa";
			this.long = "Neisa is a seven foot tall, raven-haired shield maiden.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 45, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("I"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,38,0,0,0);
			this.tallness = 7*12+6;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.skinTone = "dusky";
			this.hairColor = "red";
			this.hairLength = 13;
			this.weaponName = "bastard sword and giant shield";
			this.weaponVerb="slash";
			this.armorName = "heavy plate armor";
			this.armorPerk = "";
			this.armorValue = 70;
			this.lust = 30;
			this.lustVuln = .35;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = rand(10) + 25;
			this.drop = NO_DROP;
			this.createPerk(MutationsLib.DraconicLungs, 0, 0, 0, 0);
			this.createPerk(MutationsLib.OniMusculature, 0, 0, 0, 0);
			this.createPerk(MutationsLib.PigBoarFat, 0, 0, 0, 0);
			this.createPerk(MutationsLib.OrcAdrenalGlands, 0, 0, 0, 0);
			this.createPerk(MutationsLib.LizanMarrow, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			this.createPerk(PerkLib.Ferocity, 0, 0, 0, 0);
			this.createPerk(PerkLib.LizanRegeneration, 0, 0, 0, 0);
			if (flags[kFLAGS.NEISA_LVL_UP] >= 2) {
				this.createPerk(PerkLib.Diehard, 0, 0, 0, 0);
				//this.createPerk(PerkLib., 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 3) {
				//this.createPerk(PerkLib., 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 4) {
				this.createPerk(PerkLib.ImprovedDiehard, 0, 0, 0, 0);
				//this.createPerk(PerkLib., 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 5) {
				//this.createPerk(PerkLib., 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 6) {
				this.createPerk(MutationsLib.CatlikeNimblenessPrimitive, 0, 0, 0, 0);
				this.createPerk(MutationsLib.GorgonsEyesPrimitive, 0, 0, 0, 0);
				this.createPerk(PerkLib.GreaterDiehard, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 7) {
				this.createPerk(MutationsLib.DraconicLungsPrimitive, 0, 0, 0, 0);
				this.createPerk(MutationsLib.LizanMarrowPrimitive, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 8) {
				this.createPerk(MutationsLib.OniMusculaturePrimitive, 0, 0, 0, 0);
				this.createPerk(MutationsLib.OrcAdrenalGlandsPrimitive, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicDiehard, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 9) {
				this.createPerk(MutationsLib.PigBoarFatPrimitive, 0, 0, 0, 0);
				this.createPerk(MutationsLib.LactaBovinaOvariesPrimitive, 0, 0, 0, 0);
				//this.createPerk(PerkLib., 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 10) {
				//this.createPerk(PerkLib., 0, 0, 0, 0);
				//this.createPerk(PerkLib., 0, 0, 0, 0);
				//this.createPerk(PerkLib., 0, 0, 0, 0);
			}
			if (flags[kFLAGS.NEISA_LVL_UP] >= 11) {
				this.createPerk(MutationsLib.DraconicLungsEvolved, 0, 0, 0, 0);
				this.createPerk(MutationsLib.OniMusculatureEvolved, 0, 0, 0, 0);
				this.createPerk(MutationsLib.OrcAdrenalGlandsEvolved, 0, 0, 0, 0);
				this.createPerk(MutationsLib.PigBoarFatEvolved, 0, 0, 0, 0);
			}
			checkMonster();//make her lvl 3 starting with internal mutation for: cat, dragon, gorgon, lacta bovina, lizard, oni, orc, pig/boar - plus job: guardian perk
		}
	}
}