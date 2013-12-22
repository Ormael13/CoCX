package classes.Monsters 
{
	import classes.Monster;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class ChameleonGirl extends Monster 
	{
		/**
		 * Pairs of skinTone/skinAdj
		 */
		private const SKIN_VARIATIONS:Array = [
			"red","black",
			"green","yellowish",
			"blue","lighter blue",
			"purple","bright yellow",
			"orange","brown",
			"tan","white"];
		public function ChameleonGirl(mainClassPtr:*) 
		{
			super(mainClassPtr);
			var temp:int = rand(SKIN_VARIATIONS.length/2);
			this.skinTone = SKIN_VARIATIONS[temp*2];
			this.skinAdj = SKIN_VARIATIONS[temp*2+1];
			init1Names("the ", "chameleon girl", "chameleongirl", "You're faced with a tall lizard-like girl with smooth " + this.skinTone + " skin and long, " + this.skinAdj + " stripes that run along her body from ankle to shoulder.  An abnormally large tail swishes behind her, and her hands are massive for her frame, built for easily climbing the trees.  A pair of small, cute horns grow from her temples, and a pair of perky B-cups push out through her skimpy drapings.  Large, sharp claws cap her fingers, gesturing menacingly at you.");
			init2Female(VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_LOOSE);
			init4Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_DRY);
			init5Body(rand(2) + 68,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);

			this.temperment = 3;
			//Regular attack

			//Lust attack

			//Clothing/Armor
			this.armorName = "skin";
			this.weaponName = "claws";
			this.weaponVerb = "claw";
			this.armorDef = 20;

			this.weaponAttack = 30;

			//Primary stats
			this.str = 65;
			this.tou = 65;
			this.spe = 95;
			this.inte = 85;
			this.lib = 50;
			this.sens = 45;
			this.cor = mainClassPtr.flags[kFLAGS.EMBER_COR];

			this.lustVuln = .25;

			//Combat Stats
			this.bonusHP = 350;
			this.HP = eMaxHP();
			this.lust = 30;

			//Level Stats
			this.level = 14;
			this.XP = totalXP();
			this.gems = 10 + rand(50);

			//Appearance Variables
			this.hairColor = "black";
			this.hairLength = 15;

			this.skinDesc = "skin";

			this.tailRecharge = 0;
		}
		
	}

}