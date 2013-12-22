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


	public class Akbal extends Monster
	{


		public function Akbal(mainClassPtr:*)
		{
			super(mainClassPtr);
			trace("Akbal Constructor!");
			init1Names("", "Akbal", "akbal", "Akbal, 'God of the Terrestrial Fire', circles around you. His sleek yet muscular body is covered in tan fur, with dark spots that seem to dance around as you look upon them.  His mouth holds two ivory incisors that glint in the sparse sunlight as his lips tremble to the sound of an unending growl.  Each paw conceals lethal claws capable of shredding men and demons to ribbons.  His large and sickeningly alluring bright green eyes promise unbearable agony as you look upon them.");
			init2Male([new Cock(15,2.5,CockTypesEnum.HUMAN)],2,4,6,400);
			init3BreastRows([0],[0],[0],[0]);
			init4Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_NORMAL);
			init5Body("4'",HIP_RATING_SLENDER,BUTT_RATING_TIGHT);

			this.temperment = 1;
			this.special1 = 5125;
			this.special2 = 5126;
			this.special3 = 5127;

			//Clothing/Armor
			this.armorName = "shimmering pelt";
			this.weaponName = "claws";
			this.weaponVerb = "claw-slash";
			this.armorDef = 5;

			this.weaponAttack = 5;

			//Primary stats
			this.str = 55;
			this.tou = 53;
			this.spe = 50;
			this.inte = 75;
			this.lib = 50;
			this.sens = 50;
			this.cor = 100;

			//Combat Stats
			this.bonusHP = 20;
			this.HP = eMaxHP();
			this.lust = 30;
			this.lustVuln = 0.8;

			//Level Stats
			this.level = 6;
			this.totalXP(mainClassPtr.player.level)
			this.gems = 15;

			this.hairColor = "black";
			this.hairLength = 5;
			this.skinTone = "spotted";

			this.skinDesc = "fur";
			this.tailType = TAIL_TYPE_DOG;

			this.XP = this.totalXP(mainClassPtr.player.level);
		}

	}

}