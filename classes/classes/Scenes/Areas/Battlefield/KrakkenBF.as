/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Battlefield 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.internals.*;

public class KrakkenBF extends Monster
	{
		
		public function KrakkenBF() 
		{
			this.a = "";
			this.short = "Krakken";
			this.imageName = "krakken";
			this.long = "You are currently fighting an 18-feet tall Krakken.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 200, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 18*12;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_NOTICEABLE;
			this.lowerBody = LowerBody.SCYLLA;
			this.skin.setBaseOnly({color:"slippery"});
			this.hairColor = "brown";
			this.hairLength = 5;
			initStrTouSpeInte(150, 100, 50, 100);
			initWisLibSensCor(50, 50, 50, 0);
			this.weaponName = "tentacle";
			this.weaponVerb="slash";
			this.weaponAttack = 60;
			this.armorName = "thick skin";
			this.armorDef = 30;
			this.armorMDef = 30;
			this.bonusHP = 150;
			this.bonusLust = 160;
			this.lust = 20;
			this.lustVuln = .2;
			this.level = 60;
			this.gems = 0;
			this.drop = new WeightedDrop(consumables.SPPEARL, 1);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}