package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class MinotaurLord extends Monster 
	{
		
		public function MinotaurLord(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ", "minotaur lord", "minotaurlord", "Across from you is the biggest minotaur you've ever seen.  Fully eleven feet tall, this shaggy monstrosity has muscles so thick that they stand even through his thick, obscuring fur.  A leather collar with a tag indicates his status as 'pet' though it seems completely out of place on the herculean minotaur.  His legs and arms are like thick tree trunks, imposing and implacable, flexing fiercely with every movement.  This can only be a minotaur lord, a minotaur of strength and virility far beyond his lesser brothers. In his hands, a massive chain swings, connected to his collar, but used as an impromptu weapon for now.  A simple loincloth girds his groin, though it does little to hide the massive, erect length that tents it.  It winds up looking more like a simple, cloth condom than any sort of clothing, and it drips long strings of musky pre-slime in ribbons onto the ground.  Below, heavy testes, each easily the size of a basketball, swing in a taut, sloshing sack.  You can almost smell the liquid bounty he has for you, and the musk he's giving off makes it seem like a good idea...");
			init2Male(new Cock(rand(13) + 24,2 + rand(3),CockTypesEnum.HORSE),2,2 + rand(13),1.5,mainClassPtr.player.ballSize * 10);
			this.temperment = 1;
			this.special1 = 5029;

			//Clothing/Armor
			this.armorName = "thick fur";
			this.weaponName = "chain";
			this.weaponVerb = "chain-whip";

			this.weaponAttack = 50;

			//Primary stats
			this.str = 125;
			this.tou = 90;
			this.spe = 30;
			this.inte = 30;
			this.lib = 70;
			this.sens = 25;
			this.cor = 85;

			this.lust = 50;
			this.lustVuln = 0.33;
			//Combat Stats
			this.bonusHP = 700;
			this.HP = eMaxHP();
			//Level Stats
			this.level = 15;
			this.XP = totalXP();
			this.gems = rand(5) + 5;

			//Appearance Variables
			this.tallness = rand(37) + 84;
			//randomly assign hair color
			if(rand(2) == 0) this.hairColor = "black";
			else this.hairColor = "brown";
			this.hairLength = 3;

			this.skinType = SKIN_TYPE_FUR;
			this.skinTone = "red";
			this.skinDesc = "shaggy fur";

			//3 - cowface
			this.faceType = FACE_COW_MINOTAUR;

			this.lowerBody = LOWER_BODY_TYPE_HOOFED;

			//7 - cow!
			this.tailType = TAIL_TYPE_SHARK;

			this.hipRating = 4;

			this.buttRating = 5;
			//Create imp sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 0;
			this.breastRows[0].nipplesPerBreast = 1;

			this.ass.analLooseness = 4;
			this.ass.analWetness = 1;
			this.createStatusAffect("Bonus aCapacity",50,0,0,0);			
		}
		
	}

}