/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.Tail;
	
	public class Diana extends Monster
	{
		
		public function Diana() 
		{
			this.a = "";
			this.short = "Diana";
			this.imageName = "diana";
			this.long = "";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
			createBreastRow(Appearance.breastCupInverse("F"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 6*12+4;
			this.hipRating = Hips.RATING_CURVY;
			this.buttRating = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.HOOFED;
			this.skinTone = "pale";
			this.hairColor = "brown";
			this.hairLength = 13;
			initStrTouSpeInte(57, 64, 35, 60);
			initWisLibSensCor(60, 25, 45, 40);
			this.weaponName = "mace";
			this.weaponVerb="smack";
			this.weaponAttack = 16;
			this.armorName = "tough hide";
			this.armorDef = 6;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 12;
			this.bonusHP = 30;
			this.bonusLust = 20;
			this.gems = rand(5) + 25;
			this.drop = NO_DROP;
			this.tailType = Tail.HORSE;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}