package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
		
	public class IncubusMechanic extends Monster {
		public function IncubusMechanic(mainClassPtr:*) {
			super(mainClassPtr);
			this.short="incubus mechanic";
			this.imageName="incubusmechanic";

			this.long = "The demon before you is clad only in cut-off denim overalls.  Covered in stains of oil and other strange fluids, they appear to be in pretty rough shape.  There is a large hole ripped in the crotch, allowing the demon's foot-long member to hang free.  His skin is light purple and perfect, contrasting with the slovenly appearance of his clothing.  His face is rugged and handsome, topped with a simple black ponytail and two large horns that sprout from his forehead like twisted tree-trunks.  He wears a narrow goatee on his chin that is kept skillfully braided.  A cocky smile always seems to grace his features, giving him an air of supreme confidence.";
			this.a ="the ";
			this.temperment = 3;
			//Regular attack
			this.special1 = 11035;
			//Lust attack
			this.special2 = 11036;

			this.pronoun1 = "he";
			this.pronoun2 = "him";
			this.pronoun3 = "his";

			//Clothing/Armor
			this.armorName = "demonic skin";
			this.weaponName = "claws";
			this.weaponVerb = "claw";
			this.armorDef = 10;

			this.weaponAttack = 10;

			this.weaponValue = 150;

			//Primary stats
			this.str = 65;
			this.tou = 40;
			this.spe = 45;
			this.inte = 85;
			this.lib = 80;
			this.sens = 70;
			this.cor = 80;

			//Combat Stats
			this.bonusHP = 150;
			this.HP = eMaxHP();
			this.lustVuln = .5;
			this.lust = 50;

			//Level Stats
			this.level = 8;
			this.XP = totalXP();
			this.gems = rand(25)+10;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = rand(9) + 70;
			this.hairColor = "black";
			this.hairLength = 12;

			this.skinTone = "light purple";
			this.skinDesc = "skin";

			this.wingDesc = "tiny hidden";

			this.lowerBody = LOWER_BODY_TYPE_DEMONIC_CLAWS;

			this.tailType = TAIL_TYPE_DEMONIC;

			this.hipRating = 6;

			this.buttRating = 2;
			//Create succubus sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 0;
			this.balls = 2;
			this.cumMultiplier = 3;
			this.createCock();
			this.cocks[0].cockLength = 12;
			this.cocks[0].cockThickness = 1.75;
			this.ass.analLooseness = 4;
			this.ass.analWetness = 5;			
		}
	}
}