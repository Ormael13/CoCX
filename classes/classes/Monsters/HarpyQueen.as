package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class HarpyQueen extends Monster 
	{
		
		public function HarpyQueen(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ", "Harpy Queen", "harpyqueen", "You face the Harpy Queen, a broodmother of epic proportions - literally.  Her hips are amazingly wide, thrice her own width at the least, and the rest of her body is lushly voluptuous, with plush, soft thighs and a tremendous butt.  Her wide wings beat occasionally, sending ripples through her jiggly body.  She wields a towering whitewood staff in one hand, using the other to cast eldritch spells.");
			init2Female(VAGINA_WETNESS_SLAVERING,VAGINA_LOOSENESS_LOOSE);
			this.cumMultiplier = 3;
			this.ballSize = 1;
			this.gender = 3;

			this.temperment = 3;
			//Regular attack

			//Lust attack

			//Clothing/Armor
			this.armorName = "armor";
			this.weaponName = "eldritch staff";
			this.weaponVerb = "thwack";
			this.armorDef = 20;

			this.weaponAttack = 20;

			//Primary stats
			this.str = 70;
			this.tou = 60;
			this.spe = 120;
			this.inte = 40;
			this.lib = 40;
			this.sens = 45;
			this.cor = 50;

			this.lustVuln = .15;

			//Combat Stats
			this.bonusHP = 1000;
			this.HP = eMaxHP();
			this.lust = 20;

			//Level Stats
			this.level = 20;
			this.XP = totalXP() + 50;
			this.gems = rand(25)+160;

			//Appearance Variables
			this.tallness = rand(8) + 70;
			this.hairColor = "black";
			this.hairLength = 15;

			this.skinTone = "red";
			this.skinDesc = "skin";

			this.hornType = HORNS_DEMON;

			this.tailType = TAIL_TYPE_DEMONIC;

			this.hipRating = 8;

			this.buttRating = 8;
			//Create imp sex attributes
			this.ass.analLooseness = 4;
			this.ass.analWetness = 0;			
		}
		
	}

}