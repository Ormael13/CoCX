package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * Holli
	 * @author aimozg
	 */
	public class Holli extends Monster
	{
		
		public function Holli(mainClassPtr:*)
		{
			super(mainClassPtr);
			init1Names("", "Holli", "holli", "Marae's offshoot, Holli stands rooted in front of you.  Solid black eyes with golden pupils stare out at you.  Her normally-nude body is concealed inside her tree, though occasionally she will flash you the devilish grin of a sadistic temptress and the bark will split to reveal a pale, jiggling bit of flesh.  A pair of gnarled oak horns sprout from her forehead; leaves and flowers alternately bloom and wither on them as her face contorts with emotion.");
			init2Male(new Cock(12,2,CockTypesEnum.HUMAN));
			init2Female(VAGINA_WETNESS_WET,VAGINA_LOOSENESS_LOOSE,20);
			this.cumMultiplier = 3;
			this.hoursSinceCum = 20;
			this.gender = 2;
			init3BreastRows("E");
			init4Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_NORMAL);
			init5Body(rand(12) + 55,HIP_RATING_CURVY,BUTT_RATING_LARGE);
			init6Skin("black");
			init7Hair("sandy-blonde",15);

			this.temperment = 2;
			//Lusty teases
			this.special1 = 5133;
			this.special2 = 5134;
			this.special3 = 5135;

			//Clothing/Armor
			this.armorName = "bark";
			this.weaponName = "branches";
			this.weaponVerb = "branchy thwack";
			this.armorDef = 40;

			//Primary stats
			this.str = 150;
			this.tou = 80;
			this.spe = 80;
			this.inte = 85;
			this.lib = 75;
			this.sens = 40;
			this.cor = 80;

			//Combat Stats
			this.bonusHP = 1000;
			this.HP = eMaxHP();
			this.lustVuln = .2;
			this.lust = 20;

			//Level Stats
			this.level = 20;
			this.XP = totalXP();
			this.gems = 0;


			this.wingDesc = "";

			//Create imp sex attributes
		}
		
	}

}