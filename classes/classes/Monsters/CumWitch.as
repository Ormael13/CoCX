package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class CumWitch extends Monster 
	{
		
		public function CumWitch(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ", "Cum Witch", "cumwitch", "The Cum Witch is a moderately tall woman, almost six feet in height.  Her dark ebony skin is nearly as black as pitch, though it glitters with sweat from her recent sexual activities and the fight.  She has plump lips and long, smooth blonde hair, though much of it is hidden behind a pointed, wide-brimmed hat.  Her robes are even blacker than she is, but she wields an alabaster staff that fairly sizzles with magical might.  Of course, her garments don't do much to conceal her gigantic breasts.  Though there are only two, they're large enough to dwarf the four tits most sand witches are packing.");
			init2Male(new Cock(12,2,CockTypesEnum.HUMAN),0,0,3,20);
			init2Female(VAGINA_WETNESS_WET, VAGINA_LOOSENESS_LOOSE, 20);
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
			this.armorName = "robes";
			this.weaponName = "fists";
			this.weaponVerb = "punches";

			//Primary stats
			this.str = 35;
			this.tou = 35;
			this.spe = 35;
			this.inte = 85;
			this.lib = 55;
			this.sens = 40;
			this.cor = 30;

			//Combat Stats
			this.bonusHP = 100;
			this.HP = eMaxHP();
			this.lustVuln = .8;
			this.lust = 30;

			//Level Stats
			this.level = 6;
			this.XP = totalXP();
			this.gems = rand(15) + 5;


			this.wingDesc = "";

			//Create imp sex attributes
		}
		
	}

}