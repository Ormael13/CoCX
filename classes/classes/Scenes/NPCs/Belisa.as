package classes.Scenes.NPCs 
{
import classes.Appearance;
import classes.AssClass;
import classes.BodyParts.Butt;
import classes.BodyParts.Ears;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Monster;
import classes.PerkLib;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.internals.WeightedDrop;

/**
	 * ...
	 * @author ...Canadian Snas
	 */
	public class Belisa extends Monster
	{
		
		public function Belisa() 
		{
			this.a = "";
			this.short = "Belisa";
			this.imageName = "puredrider";
			this.long = "";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity,100,0,0,0);
			createBreastRow(Appearance.breastCupInverse("G"));
			createBreastRow(Appearance.breastCupInverse("G"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,100,0,0,0);
			this.tallness = 7*12;
			this.hips.type = Hips.RATING_CURVY + 3;
			this.butt.type = Butt.RATING_TIGHT;
			this.skinTone = "pale";
			this.hairColor = "black";
			this.hairLength = 24;
			initStrTouSpeInte(80, 90, 100, 250);
			initWisLibSensCor(100, 280, 100, 0);
			this.weaponName = "Daggers";
			this.weaponVerb="slash";
			this.weaponAttack = 60;
			this.armorName = "silken robe";
			this.armorDef = 60;
			this.armorMDef = 200;
			this.bonusHP = 500;
			this.bonusLust = 438;
			this.lustVuln = .2;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 24;
			this.gems = rand(10) + 20;
			this.drop = new WeightedDrop().add(consumables.B_GOSSR,1)
					.add(useables.T_SSILK,3)
					.add(null,5);
			this.ears.type = Ears.HUMAN;
			this.lowerBody = LowerBody.DRIDER;
			//this.createPerk(PerkLib.EnemyLargeType,0,0,0,0);
			this.createPerk(PerkLib.TankI,0,0,0,0);
			this.createPerk(PerkLib.GoliathI,0,0,0,0);
			this.createPerk(PerkLib.CheetahI,0,0,0,0);
			checkMonster();	
		}
		
	}

}
