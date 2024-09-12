/**
 * ...
 * @author Ormael
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

	public class Werespider extends Monster
	{
		
		public function Werespider() 
		{
			this.a = "the ";
			this.short = "gorgon";
			this.imageName = "gorgon";
			this.long = "You are fighting a gorgon. She resembles a slender woman from the waist up, with green scale covered hair hanging down to her neck. Her whole body is covered with shiny green scales, striped in a pattern reminiscent of the dunes around you. Instead of bifurcating into legs, her hips elongate into a snake's body which stretches far out behind her, leaving a long and curving trail in the sand.  She's completely naked, with her round D-cup breasts showing in plain sight. In her mouth you can see a pair of sharp, venomous fangs and a long forked tongue moving rapidly as she hisses at you.";
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
			initWisLibSensCor(75, 72, 55, -20);
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