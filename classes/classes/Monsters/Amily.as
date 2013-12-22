package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Amily extends Monster 
	{
		
		public function Amily(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("", "Amily", "amily", "You are currently fighting Amily. The mouse-morph is dressed in rags and glares at you in rage, knife in hand. She keeps herself close to the ground, ensuring she can quickly close the distance between you two or run away.");
			init2Female(VAGINA_WETNESS_NORMAL, VAGINA_LOOSENESS_NORMAL, 48);
			init3BreastRows("C");
			init4Ass(ANAL_LOOSENESS_VIRGIN,ANAL_WETNESS_DRY);
			init5Body("4'",HIP_RATING_AMPLE,BUTT_RATING_TIGHT);
			init6Skin("tawny",SKIN_TYPE_FUR);
			init7Hair("brown",5);

			this.temperment = 0;
			this.armorName = "rags";
			this.weaponName = "knife";
			this.weaponVerb = "slash";
			this.armorDef = 1;
			this.weaponAttack = 6;
			this.str = 30;
			this.tou = 30;
			this.spe = 85;
			this.inte = 60;
			this.lib = 45;
			this.sens = 45;
			this.cor = 10;
			this.lustVuln = .85;
			this.bonusHP = 20;
			this.HP = eMaxHP();
			this.lust = 20;
			this.level = 4;
			this.XP = totalXP();
			this.gems = 2 + rand(5);



			//Create goblin sex attributes
		}
		
	}

}