package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Anemone extends Monster 
	{
		
		public function Anemone(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ", "anemone", "anemone", "The anemone is a blue androgyne humanoid of medium height and slender build, with colorful tentacles sprouting on her head where hair would otherwise be.  Her feminine face contains two eyes of solid color, lighter than her skin.  Two feathery gills sprout from the middle of her chest, along the line of her spine and below her collarbone, and drape over her pair of small B-cup breasts.  Though you wouldn't describe her curves as generous, she sways her girly hips back and forth in a way that contrasts them to her slim waist quite attractively.  Protruding from her groin is a blue shaft with its head flanged by diminutive tentacles, and below that is a dark-blue pussy ringed by small feelers.  Further down are a pair of legs ending in flat sticky feet; proof of her aquatic heritage.  She smiles broadly and innocently as she regards you from her deep eyes.");
			init2Male(new Cock(7,1,CockTypesEnum.ANEMONE));
			init2Female(VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_LOOSE, 5);
			init3BreastRows("E");
			init4Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_DRY,10);

			this.temperment = 2;
			//Lusty teases


			//Clothing/Armor
			this.armorName = "clammy skin";
			this.weaponName = "tendrils";
			this.weaponVerb = "tentacle";

			this.weaponAttack = 5;

			//Primary stats
			this.str = 40;
			this.tou = 20;
			this.spe = 40;
			this.inte = 50;
			this.lib = 55;
			this.sens = 35;
			this.cor = 50;

			this.lustVuln = .6;

			//Combat Stats
			this.bonusHP = 120;
			this.HP = eMaxHP();
			this.lustVuln = .9;

			this.lust = 30;

			//Level Stats
			this.level = 4;
			this.XP = totalXP();
			this.gems = rand(5) + 1;

			//Appearance Variables
			this.tallness = 66;
			this.hairColor = "purplish-black";
			this.hairLength = 20;

			this.skinTone = "purple";
			this.skinDesc = "skin";

			this.lowerBody = LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS;

			this.hipRating = 10;

			this.buttRating = 6;
			//Create goblin sex attributes
		}
		
	}

}