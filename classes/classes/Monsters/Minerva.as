package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Minerva extends Monster 
	{
		
		public function Minerva(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("", "Minerva", "minerva", "You're fighting the tainted siren, Minerva.  Standing around eight feet and wielding a weapon just as tall, she is a force to be reckoned with.  Her skin is a dark navy blue, though her belly, neck and inner thighs are as white as the clouds in the sky, and a golden piecing decorates her navel.  Orange and white stripes adorn her legs, tail and back.  Two large wings sprout from her back, their feathers an attention-grabbing red and orange mix.  She wears a tube-top that hold back her double d-cups, and short shorts around her wide waist that seem to be holding back a huge bulge.\n\nHer weapon is a halberd, made from a shiny, silvery metal, and seems to have an unnatural glow to it.");
			init2Male(new Cock(16,3),2,3,3);
			init2Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_NORMAL);
			init3BreastRows("DD");
			init4Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY);
			init5Body("8'4",HIP_RATING_CURVY,BUTT_RATING_LARGE+1);
			init6Skin("blue");
			init7Hair("red",25);

			this.temperment = 3;
			//Regular attack
			this.special1 = 11020;
			//Lust attack
			this.special2 = 11021;
			this.special3 = 11022;

			//Clothing/Armor
			this.armorName = "comfortable clothes";
			this.weaponName = "halberd";
			this.weaponVerb = "slash";
			this.armorDef = 1;

			this.weaponAttack = 30;

			this.weaponValue = 150;
			this.armorValue = 5;
			//Primary stats
			this.str = 50;
			this.tou = 65;
			this.spe = 95;
			this.inte = 75;
			this.lib = 30;
			this.sens = 25;
			this.cor = 45;

			//Combat Stats
			this.bonusHP = 470;
			this.HP = eMaxHP();
			this.lustVuln = .2;
			this.lust = 20;

			//Level Stats
			this.level = 16;
			this.XP = totalXP() + 50;
			this.gems = rand(25)+10;


			this.wingDesc = "fluffy feathery";

			this.wingType = WING_TYPE_HARPY;

			//Create succubus sex attributes
		}
		
	}

}