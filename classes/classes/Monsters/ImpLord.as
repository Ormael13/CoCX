package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class ImpLord extends Monster 
	{
		
		public function ImpLord(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ", "imp lord", "implord", "The greater imp has an angular face, complete with curved nose and burnt red skin typical of imps.  He has no hair on his head, leaving his cold, lust-clouded, black eyes unobstructed.  Just above his long pointed ears are two curved bovine horns.  While still short, he's much taller then the average imp, being nearly four feet tall, and extremely well-muscled.  A pair of powerful wings extends out from his shoulders, however, you suspect he wouldn't be able to fly for long due to his extreme bulk.  A thick coating of fur starts at his well toned hips and works it's way down his powerful legs.  His legs end in a pair of oddly jointed, demonic hooves.  His demonic figure is completed by a thin tail that has an arrowhead shaped tip.\n\nThe greater imp, like most imps wears very little clothing, only a simple loincloth and satchel hang from his waist.  You also note that the imp has two barbell piercings in his nipples. The creature doesn't seem to have any weapons, aside from his sharp black finger nails.");
			// Imps now only have demon dicks.
			// Not sure if I agree with this, I can imagine the little fuckers abusing the
			// shit out of any potions they can get their hands on.
			init2Male(new Cock(rand(2)+11,2.5,CockTypesEnum.DEMON),2,1,3,20);
			init3BreastRows([0,0]);

			this.temperment = 1;
			this.special1 = 5019;


			//Clothing/Armor
			this.armorName = "leathery skin";
			this.weaponName = "fist";
			this.weaponVerb = "punch";
			this.armorDef = 5;

			this.weaponAttack = 10;

			//Primary stats
			this.str = 55;
			this.tou = 40;
			this.spe = 75;
			this.inte = 42;
			this.lib = 55;
			this.sens = 35;
			this.cor = 100;

			//Combat Stats
			this.bonusHP
			this.HP = eMaxHP();
			this.lust = 30;
			this.lustVuln = .65;

			//Level Stats
			this.level = 7;
			this.XP = totalXP();
			this.gems = rand(15) + 25;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 1;
			this.tallness = rand(14) + 40;
			this.hairColor = "black";
			this.hairLength = 0;

			this.skinTone = "red";
			this.skinDesc = "skin";

			this.wingDesc = "small";

			this.wingType = WING_TYPE_IMP;

			this.hipRating = 0;

			this.buttRating = 2;
			//Create imp sex attributes
			this.ass.analLooseness = 4;
			this.ass.analWetness = 1;			
		}
		
	}

}