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
			if (flags[kFLAGS.NEISA_LVL_UP] == 1) {
				initStrTouSpeInte(50, 80, 50, 44);
				initWisLibSensCor(44, 52, 25, 50);
				this.weaponAttack = 12;
				this.armorDef = 0;
				this.armorMDef = 0;
				this.bonusHP = 200;
				this.level = 3;
			}
			if (flags[kFLAGS.NEISA_LVL_UP] == 2) {
				initStrTouSpeInte(65, 102, 60, 52);
				initWisLibSensCor(52, 58, 30, 50);
				this.weaponAttack = 15;
				this.armorDef = 8;
				this.armorMDef = 2;
				this.bonusHP = 400;
				this.level = 9;
			}
			if (flags[kFLAGS.NEISA_LVL_UP] == 3) {
				initStrTouSpeInte(80, 124, 70, 60);
				initWisLibSensCor(60, 64, 35, 50);
				this.weaponAttack = 18;
				this.armorDef = 16;
				this.armorMDef = 4;
				this.bonusHP = 600;
				this.level = 15;
			}
			if (flags[kFLAGS.NEISA_LVL_UP] == 4) {
				initStrTouSpeInte(95, 146, 80, 68);
				initWisLibSensCor(68, 70, 40, 50);
				this.weaponAttack = 21;
				this.armorDef = 24;
				this.armorMDef = 6;
				this.bonusHP = 800;
				this.level = 21;
			}
			this.weaponName = "bastard sword and giant shield";
			this.weaponVerb="slash";
			this.armorName = "heavy plate armor";
			this.armorPerk = "";
			this.armorValue = 70;
			this.bonusLust = 20;
			this.lust = 30;
			this.lustVuln = .35;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = rand(10) + 25;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			checkMonster();
		}
	}
}