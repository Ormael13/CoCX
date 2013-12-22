package classes.Monsters 
{
	import classes.Monster;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Vala extends Monster 
	{
		
		public function Vala(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("", "Vala", "vala", "While the fey girl is whip-thin, her breasts are disproportionately huge. They'd be at least a DD-cup on a normal human, but for her height and body type, they're practically as large as her head. They jiggle at her slow, uneven breathing, tiny drops of milk bubbling at her nipples with every heartbeat.  She seems fixated on mating with you, and won't take no for an answer.");
			init2Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_GAPING_WIDE,25);
			init3BreastRows("E");
			init4Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_DRY,10);
			init5Body("4'",HIP_RATING_CURVY,BUTT_RATING_LARGE);
			init6Skin("fair");
			init7Hair("purple",22);

			this.temperment = 2;
			//Lusty teases

			//Clothing/Armor
			this.armorName = "skin";
			this.weaponName = "fists";
			this.weaponVerb = "caresses";

			//Primary stats
			this.str = 40;
			this.tou = 50;
			this.spe = 50;
			this.inte = 60;
			this.lib = 55;
			this.sens = 35;
			this.cor = 50;

			this.lustVuln = .5;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 0) this.lustVuln += .25;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 2) this.lustVuln += .5;

			//Combat Stats
			this.bonusHP = 350;
			this.HP = eMaxHP();

			this.lust = 30 + mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] * 10;
			if(this.lust > 80) this.lust = 80;

			//Level Stats
			this.level = 11;
			this.XP = totalXP() + 50;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 0) this.XP = 5;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 2) this.XP = 1;
			this.gems = 1;


			this.wingDesc = "shimmering wings";

			this.wingType = WING_TYPE_BEE_LIKE_LARGE;


		}
		
	}

}