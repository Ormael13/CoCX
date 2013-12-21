package classes.Monsters 
{
	import classes.Monster;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * Holli (combat id 69)
	 * @author ...
	 */
	public class Holli69 extends Monster 
	{
		
		public function Holli69(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("",mainClassPtr.flags[kFLAGS.HELSPAWN_NAME],"hollispawn","Marae's offshoot, Holli stands rooted in front of you.  Solid black eyes with golden pupils stare out at you.  Her normally-nude body is concealed inside her tree, though occasionally she will flash you the devilish grin of a sadistic temptress and the bark will split to reveal a pale, jiggling bit of flesh.  A pair of gnarled oak horns sprout from her forehead; leaves and flowers alternately bloom and wither on them as her face contorts with emotion.");
			mainClassPtr.helSpawnDesc(this);

			this.temperment = 2;
			//Lusty teases
			this.special1 = 5133;
			this.special2 = 5134;
			this.special3 = 5135;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			this.armorDef = 12;

			this.weaponAttack = 20;
			this.createStatusAffect("keen",0,0,0,0);

			this.armorValue = 50;
			//Primary stats
			this.str = 50;
			this.tou = 50;
			this.spe = 65;
			this.inte = 40;
			this.lib = 35;
			this.sens = 55;
			this.cor = 20;

			this.lustVuln = .55;

			//Combat Stats
			this.bonusHP = 175;
			this.HP = eMaxHP();

			this.lust = 30;
		
			//Level Stats
			this.level = 12;
			this.XP = totalXP();
			this.gems = 10 + rand(5);

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = 90;
			this.hairColor = "red";
			this.hairLength = 13;

			this.skinTone = "helspawn";
			this.skinDesc = "skin";

			this.tailType = TAIL_TYPE_COW;

			this.tailRecharge = 0;

			this.hipRating = 12;

			this.buttRating = 9;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 8;
			this.createVagina();
			this.createStatusAffect("Bonus vCapacity",85,0,0,0);
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_NORMAL;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;
			this.vaginas[0].virgin = false;
			this.ass.analLooseness = 0;
			this.createStatusAffect("Bonus aCapacity",85,0,0,0);
			this.ass.analWetness = 0;			
		}
		
	}

}