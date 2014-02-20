package classes.Scenes.NPCs
{
	import classes.*;

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
			this.a = "";
			this.short = "Jojo";
			this.imageName = "jojo";
			this.long = "Jojo is an anthropomorphic mouse with immaculate white fur.  Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed.  He wears loose white clothes wrapped in prayer beads and tattered prayer papers.";
			// this.plural = false;
			this.createCock(7.5,1.8);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 1;
			this.hoursSinceCum = 1000;
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = 4*12;
			this.hipRating = HIP_RATING_SLENDER;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skinTone = "white";
			this.skinType = SKIN_TYPE_FUR;
			this.skinDesc = "fur";
			this.hairColor = "white";
			this.hairLength = 2;
			initStrTouSpeInte(35, 40, 65, 55);
			initLibSensCor(15, 40, 0);
			this.weaponName = "paw";
			this.weaponVerb="punch";
			this.armorName = "robes";
			this.lust = 15;
			this.lustVuln = .9;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 4;
			this.gems = rand(5) + 2;
			this.special1 = 5021;
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
			this.drop = NO_DROP;
			checkMonster();
		}

	}

}