package classes.Scenes.Areas.Battlefield 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.internals.*;

	/**
	 * ...
	 * @author ...
	 */
	public class GhastlyDragon extends Monster
	{
		
		public function GhastlyDragon() 
		{
			this.a = "the ";
			this.short = "ghastly dragon";
			this.imageName = "ghastlydragon";
			this.long = "You are currently battling the ghastly dragon. Ocassionaly it fades away partialy but this only server to increase difficulty of predicting it attacks. It body covers translucent scales and lashes tail along the ground, with claws spread and teeth bared ferociously.";
			// this.plural = false;
			this.createCock(4,1);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 1;
			this.hoursSinceCum = 50;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 78;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.skinTone = "white";
			this.hairColor = "white";
			this.hairLength = 3;
			initStrTouSpeInte(55, 40, 10, 140);
			initWisLibSensCor(140, 120, 1, 33);
			this.weaponName = "fists";
			this.weaponVerb="punches";
			this.weaponAttack = 14;
			this.armorName = "translucent scales";
			this.armorDef = 1;
			this.armorMDef = 1;
			this.bonusHP = 30;
			this.bonusLust = 133;
			this.lust = 10;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 42;
			this.gems = 0;
			this.drop = new ChainedDrop().add(consumables.ECTOPLS, 1 / 3);
			this.createPerk(PerkLib.EnemyGhostType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}