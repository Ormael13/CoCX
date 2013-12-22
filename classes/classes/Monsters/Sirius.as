package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Sirius extends Monster 
	{
		
		public function Sirius(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("", "Sirius, a naga hypnotist", "sirius", "A strange being with the upper torso of a human man topped with the head of a giant serpent stands before you, hissing in anger and occasionally letting a long, fork-tipped tongue flicker out past his lips.  An imperial-featured masculine human face regards you with an indifferent expression.  A ponytail of deep orange - almost bright red - hair falls down between his shoulders, held together by snake-styled circlets of silver, and matching bracelets of the same material and design adorn his wrists. Scales begin at his lower waist, concealing his manhood from you; he's completely naked otherwise.  His snake body is long and slender, covered in finely meshing scales of a rich orange-red shade, the red broken by a pattern of randomly thick or thin stripes of black.  His burning yellow eyes stare directly into yours, vertical slits of pupils fixated on your own as he undulates and coils in an eerily seductive manner.");
			init2Male(new Cock(14,2));
			init3BreastRows(0);
			init4Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,10);
			init5Body("5'10",HIP_RATING_AMPLE+2,BUTT_RATING_LARGE,LOWER_BODY_TYPE_GOO);

			this.temperment = 2;
			//Lusty teases
			this.special1 = 5109;
			this.special2 = 5110;
			this.special3 = 5111;

			//Clothing/Armor
			this.armorName = "scales";
			this.weaponName = "fangs";
			this.weaponVerb = "bite";
			this.armorDef = 30;

			this.weaponAttack = 25;

			//Primary stats
			this.str = 75;
			this.tou = 70;
			this.spe = 75;
			this.inte = 92;
			this.lib = 45;
			this.sens = 35;
			this.cor = 40;

			//Combat Stats
			this.bonusHP = 400;
			this.HP = eMaxHP();

			this.lust = 30;

			//Level Stats
			this.level = 12;
			this.XP = totalXP();
			this.gems = rand(5) + 8;

			//Appearance Variables
			this.hairColor = "orange";
			this.hairLength = 16;

			this.skinTone = "mediterranean-toned";
			this.skinDesc = "skin";
		}
		
	}

}