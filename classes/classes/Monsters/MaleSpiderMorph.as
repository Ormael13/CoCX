package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MaleSpiderMorph extends Monster 
	{
		
		public function MaleSpiderMorph(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ", "male spider-morph", "malespidermorph", "The male spider-morph is completely nude, save for his thigh-high stockings and forearm-length gloves, which upon closer inspection, appear to be actually be part of his body - his exoskeleton.  His exposed skin is pale as the full moon, save for the dusk of his nipples and a patch of jet-black that spreads out over his groin, glossing the male's foreskinned cock and dangling sack in glistening ebon.  His ass is small but well-rounded, with a weighty spider-abdomen hanging from just above.  The spider-man is currently eyeing you with a strange expression and his fangs bared.");
			init2Male(new Cock(6,2));

			this.temperment = 2;
			//Lusty teases

			//Clothing/Armor
			this.armorName = "exoskeleton";
			this.weaponName = "dagger";
			this.weaponVerb = "stab";
			this.armorDef = 14;

			this.weaponAttack = 15;

			this.armorValue = 70;
			//Primary stats
			this.str = 60;
			this.tou = 50;
			this.spe = 99;
			this.inte = 99;
			this.lib = 35;
			this.sens = 35;
			this.cor = 20;

			this.lustVuln = .6;

			//Combat Stats
			this.bonusHP = 200;
			this.HP = eMaxHP();

			this.lust = 20;

			//Level Stats
			this.level = 13;
			this.XP = totalXP();
			this.gems = rand(10) + 10;

			//Appearance Variables
			this.tallness = 90;
			this.hairColor = "red";
			this.hairLength = 13;

			this.skinTone = "dusky";
			this.skinDesc = "skin";

			this.tailType = TAIL_TYPE_COW;

			this.tailRecharge = 0;

			this.hipRating = 12;

			this.buttRating = 9;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 0;
			this.ass.analLooseness = 1;
			this.createStatusAffect("Bonus aCapacity",40,0,0,0);
			this.ass.analWetness = 0;			
		}
		
	}

}