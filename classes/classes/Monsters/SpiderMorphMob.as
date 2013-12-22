package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class SpiderMorphMob extends Monster 
	{
		
		public function SpiderMorphMob(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ","mob of spiders-morphs","spidermorphmob","You are fighting a horde of spider-morphs!  A group of some two-dozen spiders and driders approaches you, all baring their teeth.  A pair of large, powerful driders lead the group, their corrupt, lusty stares sending shivers up your spine.  While "+(mainClassPtr.player.level <= 13?"you'd never face such a large horde on your own":"you could probably handle them alone")+", you have a powerful ally in this fight - the dragoness Kiha!",true);
			init2Male(new Cock(9,2,CockTypesEnum.HUMAN),0,1,3);
			init2Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_LOOSE);
			init4Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init5Body(rand(8) + 70,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);

			this.temperment = 3;
			//Regular attack
			this.special1 = 5043;
			//Lust attack
			this.special2 = 5044;

			//Clothing/Armor
			this.armorName = "chitin";
			this.weaponName = "claws";
			this.weaponVerb = "claws";

			//Primary stats
			this.str = 60;
			this.tou = 50;
			this.spe = 99;
			this.inte = 99;
			this.lib = 35;
			this.sens = 35;
			this.cor = 20;

			this.lustVuln = .2;

			//Combat Stats
			this.bonusHP = 1200;
			this.HP = eMaxHP();
			this.lust = 0;

			//Level Stats
			this.level = 18;
			this.XP = totalXP();
			this.gems = rand(25)+40;

			//Appearance Variables
			this.hairColor = "black";
			this.hairLength = 15;

			this.skinTone = "red";
			this.skinDesc = "skin";

			this.hornType = HORNS_DEMON;

			this.tailType = TAIL_TYPE_DEMONIC;
		}
		
	}

}