/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;
	
	public class Ceani extends Monster
	{
		
		public function Ceani() 
		{
			if (flags[kFLAGS.CEANI_LVL_UP] == 0) {
				this.level = 40;//-70
				initStrTouSpeInte(60, 110, 100, 150);
				initWisLibSensCor(150, 220, 80, 80);
			}
			this.a = "";
			this.short = "Ceani";
			this.long = "You are sparing with Ceani the orca morph. While she is normally smiling all the time this time around she looks like an angry beast about to tear you to shreds. You realise only now how scary her sharp teeth are let alone that massive harpoon she wields. Both strong and swift, she easily proves that underneath her friendly, and at time goofy, demeanor she still is a deadly fighter most people on mareth would rather avoid the wrath of.";
			createVagina(true,AppearanceDefs.VAGINA_WETNESS_NORMAL,AppearanceDefs.VAGINA_LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,60,0,0,0);
			createBreastRow(Appearance.breastCupInverse("JJ"));
			this.ass.analLooseness = AppearanceDefs.ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = AppearanceDefs.ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 132;
			this.hipRating = AppearanceDefs.HIP_RATING_CURVY+2;
			this.buttRating = AppearanceDefs.BUTT_RATING_LARGE+1;
			this.skinTone = "black with a white underside";
			this.hairColor = "blue";
			this.hairLength = 13;
			this.weaponName = "harpoon";
			this.weaponVerb="piercing stab";
			this.weaponAttack = 12;
			this.armorName = "pink bikini";
			this.armorDef = 12;
			this.bonusHP = 100;
			this.bonusLust = 50;
			this.lust = 30;
			this.lustVuln = .8;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = 50;
			this.drop = new ChainedDrop().
				//	add(armors.INDESSR,1/10).
				//	add(consumables.L_DRAFT,1/4).
					add(consumables.ORCASUN,0.7);
			this.rearBody = AppearanceDefs.REAR_BODY_ORCA_BLOWHOLE;
			this.armType = AppearanceDefs.ARM_TYPE_ORCA;
			this.lowerBody = AppearanceDefs.LOWER_BODY_TYPE_ORCA;
			this.tailType = AppearanceDefs.TAIL_TYPE_ORCA;
			this.tailRecharge = 0;
			//if (flags[kFLAGS.ETNA_FOLLOWER] > 1 || flags[kFLAGS.ETNA_TALKED_ABOUT_HER] > 1) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			//this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}