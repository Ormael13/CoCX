package classes.Scenes.NPCs
{
	import classes.CoC;
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


		override public function defeated(hpVictory:Boolean):void
		{
			if (player.lust > 33 && player.gender > 0) {
				outputText("You smile in satisfaction as " + a + short + (hpVictory?" collapses, unable to continue fighting":" collapses and begins masturbating feverishly")+".  Sadly you realize your own needs have not been met.  Of course, you could always rape the poor thing...\n\nDo you rape him?", true);
				game.doYesNo(5022, game.cleanupAfterCombat);
			} else {
				game.finishCombat();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.eventParser(5024);
		}

		public function Jojo()
		{
			trace("Jojo Constructor!");
			init01Names("", "Jojo", "jojo", "Jojo is an anthropomorphic mouse with immaculate white fur.  Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed.  He wears loose white clothes wrapped in prayer beads and tattered prayer papers.");
			init02Male(new Cock(7.5,1.8),2,1,1,1000);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_NORMAL);
			init05Body("4'",HIP_RATING_SLENDER,BUTT_RATING_TIGHT);
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
			if(game.monk == 3) {
				this.lust += 30;
				this.cocks[0].cockThickness += .2;
				this.cocks[0].cockLength += 1.5;
				if(player.gender == 1 || player.gender == 3) this.ass.analLooseness = 2;
			}
			if(game.monk == 4) {
				this.lust += 40;
				this.cocks[0].cockThickness += .5;
				this.cocks[0].cockLength += 3.5;
				if(player.gender == 1 || player.gender == 3) this.ass.analLooseness = 3;
			}
			if(game.monk == 5) {
				this.lust += 50;
				this.cocks[0].cockThickness += 1;
				this.cocks[0].cockLength += 5.5;
				this.str -= 20;
				this.tou += 30;
				this.HP += 60;
				if(player.gender == 1 || player.gender == 3) this.ass.analLooseness = 4;
				this.long = "Jojo is an anthropomorphic mouse with immaculate white fur.  Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed.  He's naked, with a large tainted throbbing member bouncing at attention.  A fuzzy sack with painfully large looking balls dangles between his legs.";
			}
		}

	}

}