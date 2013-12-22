package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GnollSpearThrower extends Monster 
	{
		
		public function GnollSpearThrower(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ", "gnoll spear-thrower", "gnollspearthrower", "You are fighting a gnoll.  An amalgam of voluptuous, sensual lady and snarly, pissed off hyena, she clearly intends to punish you for trespassing.  Her dark-tan, spotted hide blends into a soft cream-colored fur covering her belly and two D-cup breasts, leaving two black nipples poking through the fur.  A crude loincloth is tied around her waist, obscuring her groin from view.  A leather strap cuts between her heavy breasts, holding a basket of javelins on her back.  Large, dish-shaped ears focus on you, leaving no doubt that she can hear every move you make.  Sharp, dark eyes are locked on your body, filled with aggression and a hint of lust.");
			init2Female(VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_LOOSE);
			init3BreastRows("D");
			init4Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_DRY,25);
			init5Body(72,HIP_RATING_AMPLE,BUTT_RATING_TIGHT);
			init6Skin("tawny",SKIN_TYPE_FUR);
			init7Hair("black",22);

			this.temperment = 2;
			//Lusty teases
			this.special1 = 5147;
			this.special2 = 5146;
			this.special3 = 5145;

			//Clothing/Armor
			this.armorName = "skin";
			this.weaponName = "teeth";
			this.weaponVerb = "bite";
			this.armorDef = 2;

			this.weaponValue = 25;

			//Primary stats
			this.str = 85;
			this.tou = 60;
			this.spe = 100;
			this.inte = 50;
			this.lib = 65;
			this.sens = 45;
			this.cor = 60;

			this.lustVuln = .35;

			//Combat Stats
			this.bonusHP = 250;
			this.HP = eMaxHP();

			this.lust = 30;
		
			//Level Stats
			this.level = 10;
			this.XP = totalXP();
			this.gems = 10 + rand(5);


		}
	}
}