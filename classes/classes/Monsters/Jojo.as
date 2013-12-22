package classes.Monsters
{
	import classes.Cock;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Jojo extends Monster
	{
		

		public function Jojo(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("Jojo Constructor!");
			init1Names("", "Jojo", "jojo", "Jojo is an anthropomorphic mouse with immaculate white fur.  Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed.  He wears loose white clothes wrapped in prayer beads and tattered prayer papers.");
			init2Male(new Cock(7.5,1.8),0,0,1,1000);
			init3BreastRows(0);
			init4Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_NORMAL);
			init5Body("5'1",HIP_RATING_SLENDER,BUTT_RATING_TIGHT);
			init6Skin("white",SKIN_TYPE_FUR,"fur");
			init7Hair("white",2);
			this.temperment = 1;
			this.special1 = 5021;


			//Clothing/Armor
			this.armorName = "robes";
			this.weaponName = "paw";
			this.weaponVerb = "punch";

			//Primary stats
			this.str = 35;
			this.tou = 40;
			this.spe = 65;
			this.inte = 55;
			this.lib = 15;
			this.sens = 40;
			this.cor = 0;

			//Combat Stats
			this.HP = eMaxHP();
			this.lust = 15;
			this.lustVuln = .9;

			//Level Stats
			this.level = 4;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = rand(5) + 2;


			this.wingDesc = "";

			//Create jojo sex attributes
			//Variations based on jojo's corruption.
			if(mainClassPtr.monk == 3) {
				this.lust += 30;
				this.cocks[0].cockThickness += .2;
				this.cocks[0].cockLength += 1.5;
				if(mainClassPtr.player.gender == 1 || mainClassPtr.player.gender == 3) this.ass.analLooseness = 2;
			}
			if(mainClassPtr.monk == 4) {
				this.lust += 40;
				this.cocks[0].cockThickness += .5;
				this.cocks[0].cockLength += 3.5;
				if(mainClassPtr.player.gender == 1 || mainClassPtr.player.gender == 3) this.ass.analLooseness = 3;
			}
			if(mainClassPtr.monk == 5) {
				this.lust += 50;
				this.cocks[0].cockThickness += 1;
				this.cocks[0].cockLength += 5.5;
				this.str -= 20;
				this.tou += 30;
				this.HP += 60;
				if(mainClassPtr.player.gender == 1 || mainClassPtr.player.gender == 3) this.ass.analLooseness = 4;
				this.long = "Jojo is an anthropomorphic mouse with immaculate white fur.  Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed.  He's naked, with a large tainted throbbing member bouncing at attention.  A fuzzy sack with painfully large looking balls dangles between his legs.";
			}

			// possible issues accessing flags from this context.

		}

	}

}