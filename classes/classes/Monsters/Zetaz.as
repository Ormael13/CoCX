package classes.Monsters 
{
	import classes.Cock;
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
			init1Names("","Zetaz","zetaz","Zetaz has gone from a pipsqueak to the biggest imp you've seen!  Though he has the familiar red skin, curving pointed horns, and wings you would expect to find on an imp, his feet now end in hooves, and his body is covered with thick layers of muscle.  If the dramatic change in appearance is any indication, he's had to toughen up nearly as much as yourself over the past "+(mainClassPtr.model.time.days < 60? "weeks":"months")+".  Zetaz still wears the trademark imp loincloth, though it bulges and shifts with his movements in a way that suggest a considerable flaccid size and large, full sack.  His shoulders are wrapped with studded leather and his wrists are covered with metallic bracers.  The imp has clearly invested in at least a little additional protection.  It does not look like he carries a weapon.");
			init2Male(new Cock(rand(2) + 11,2.5,CockTypesEnum.HUMAN),2,1,3,20);
			init3BreastRows();


			this.temperment = 1;

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
			this.ass.analLooseness = 1;
			this.ass.analWetness = 1;			
		}
		
	}

}