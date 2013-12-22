package classes.Monsters
{
	import classes.Appearance;
	import classes.Cock;
	import classes.Monster;

	/**
	 * ...
	 * @author ...
	 */
	public class CorruptedDrider extends Monster
	{
		public function CorruptedDrider(mainClassPtr:*)
		{
			super(mainClassPtr);

			var hairColor:String = Appearance.randomChoice("red", "orange", "green");
			var skinTone:String = Appearance.randomChoice("yellow", "purple", "red", "turquoise");

			var pierced:Boolean = rand(2)==0;
			var _long:String = "This particular spider-woman is a drider - a creature with a humanoid top half and the lower body of a giant arachnid.  From a quick glance, you can tell that this one has fallen deeply to corruption.  She is utterly nude, exposing her four well-rounded, D-cup breasts with their shiny black nipples.  ";
			if (pierced) _long += "Gold piercings and chains link the curvy tits together, crossing in front of her four mounds in an 'x' pattern.  ";
			_long += "On her face and forehead, a quartet of lust-filled, " + skinTone + " eyes gaze back at you.  Behind her, the monster-girl's " + hairColor + " hair drapes down her back like a cloak.  The drider's lips seem to shine with a light all their own, and a steady trickle of purple, reflective fluid beads and drips from them.  At her waist, there's a juicy looking snatch with a large, highly visible clit.  From time to time it pulsates and grows, turning part-way into a demon-dick.  Her spider-half has eight spindly legs with black and " + hairColor + " stripes - a menacing display if ever you've seen one.";

			init1Names("the ", "corrupted drider", "corrupteddrider", _long);
			init2Male(new Cock(9,2));
			init2Female(VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_GAPING, 70, true);
			init3BreastRows("DD");
			init4Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,70);
			init5Body("10'",HIP_RATING_CURVY+2,BUTT_RATING_LARGE+1);
			init6Skin(skinTone,SKIN_TYPE_PLAIN,"scales");
			init7Hair(hairColor,24);

			if (pierced) {
				this.nipplesPierced = 1;
				this.lustVuln = .25;
				//Combat Stats
				this.bonusHP = 325;
				this.HP = eMaxHP();
				this.lust = 35;
				//Level Stats
				this.level = 15;
				this.XP = totalXP();
				this.gems = rand(10) + 30;
			}

			this.temperment = 2;
			//Lusty teases

			//Clothing/Armor
			this.armorName = "carapace";
			this.weaponName = "claws";
			this.weaponVerb = "claw";
			this.armorDef = 55;

			this.weaponAttack = 30;

			this.armorValue = 70;
			//Primary stats
			this.str = 100;
			this.tou = 50;
			this.spe = 70;
			this.inte = 100;
			this.lib = 80;
			this.sens = 50;
			this.cor = 90;

			this.lustVuln = .4;

			//Combat Stats
			this.bonusHP = 250;
			this.HP = eMaxHP();

			this.lust = 30;

			//Level Stats
			this.level = 14;
			this.XP = totalXP();
			this.gems = rand(10) + 20;

			//Appearance Variables


			//SKINTONE USED FOR EYES ON DRIDAH!


			this.tailRecharge = 0;

		}

	}

}