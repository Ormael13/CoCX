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
			init01Names("", "Jojo", "jojo", "Jojo is an anthropomorphic mouse with immaculate white fur.  Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed.  He wears loose white clothes wrapped in prayer beads and tattered prayer papers.");
			init02Male(new Cock(7.5,1.8),2,1,1,1000);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_NORMAL);
			init05Body("5'1",HIP_RATING_SLENDER,BUTT_RATING_TIGHT);
			init06Skin("white",SKIN_TYPE_FUR,"fur");
			init07Hair("white",2);
			init08Face();
			init09PrimaryStats(35,40,65,55,15,40,0);
			init10Weapon("paw","punch");
			init11Armor("robes");
			init12Combat(0,15,.9,Monster.TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(4,rand(5) + 2);
			initX_Specials(5021);
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
		}

	}

}