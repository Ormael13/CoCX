/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
//import classes.BodyParts.LowerBody;
//import classes.BodyParts.Skin;
import classes.Scenes.Areas.Desert.AnubisScene;
import classes.Stats.Buff;
import classes.internals.*;

	public class Wereshark extends Monster
	{
		
		public function Wereshark() 
		{
			this.a = "the ";
			this.short = "wereshark";
			this.imageName = "sharkgirl";
			this.long = "You are fighting a wereshark.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 60, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 6*12+2;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			//this.lowerBody = LowerBody.NAGA;
			//this.skin.growCoat(Skin.SCALES,{color:"green"});
			this.hairColor = "green";
			this.hairLength = 16;
			initStrTouSpeInte(91, 125, 110, 75);
			initWisLibSensCor(75, 72, 55, 40);
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.weaponAttack = 31;
			this.armorName = "scales";
			this.armorDef = 31;
			this.armorMDef = 10;
			this.bonusHP = 500;
			this.bonusLust = 151;
			this.lust = 30;
			this.level = 24;
			this.gems = rand(16) + 30;
			this.drop = new WeightedDrop().
					add(null,1).
					add(consumables.REPTLUM,2).
					add(consumables.GORGOIL,5);
			//this.faceType = Face.SNAKE_FANGS;
			checkMonster();
		}
		
	}

}