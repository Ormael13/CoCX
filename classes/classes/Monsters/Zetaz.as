package classes.Monsters 
{
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Zetaz extends Monster 
	{
		
		public function Zetaz(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short = "Zetaz";
			this.imageName = "zetaz";
			this.long="Zetaz has gone from a pipsqueak to the biggest imp you've seen!  Though he has the familiar red skin, curving pointed horns, and wings you would expect to find on an imp, his feet now end in hooves, and his body is covered with thick layers of muscle.  If the dramatic change in appearance is any indication, he's had to toughen up nearly as much as yourself over the past ";
			if(mainClassPtr.model.time.days < 60) this.long += "weeks";
			else this.long += "months";
			this.long += ".  Zetaz still wears the trademark imp loincloth, though it bulges and shifts with his movements in a way that suggest a considerable flaccid size and large, full sack.  His shoulders are wrapped with studded leather and his wrists are covered with metallic bracers.  The imp has clearly invested in at least a little additional protection.  It does not look like he carries a weapon.";

			this.a ="";

			this.temperment = 1;

			this.pronoun1 = "he";
			this.pronoun2 = "him";
			this.pronoun3 = "his";

			//Clothing/Armor
			this.armorName = "leathery skin";
			this.weaponName = "claws";
			this.weaponVerb = "claw-slash";

			//Primary stats
			this.str = 65;
			this.tou = 60;
			this.spe = 45;
			this.inte = 52;
			this.lib = 55;
			this.sens = 35;
			this.cor = 100;

			this.lustVuln = .35;

			//Combat Stats
			//Combat Stats
			this.bonusHP = 350;
			this.HP = eMaxHP();
			this.lust = 40;

			//Level Stats
			this.level = 12;
			this.XP = totalXP() + 100;
			this.gems = rand(55) + 150;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 1;
			this.tallness = 49;
			this.hairColor = "black";
			this.hairLength = 5;

			this.skinTone = "red";
			this.skinDesc = "skin";

			this.wingDesc = "small";

			this.wingType = WING_TYPE_IMP;

			this.hipRating = 0;

			this.buttRating = 2;
			//Create imp sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 0;
			this.breastRows[0].nipplesPerBreast = 0;
			this.createCock();
			this.cocks[0].cockLength = rand(2) + 11;
			this.cocks[0].cockThickness = 2.5;
			this.cocks[0].cockType = CockTypesEnum.HUMAN;
			this.balls = 2;
			this.cumMultiplier = 3;
			this.ballSize = 1;
			this.hoursSinceCum = 20;
			this.ass.analLooseness = 1;
			this.ass.analWetness = 1;			
		}
		
	}

}