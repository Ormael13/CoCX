package classes.Monsters 
{
	import classes.Monster;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Hel extends Monster 
	{
		
		public function Hel(mainClassPtr:*) 
		{
			super(mainClassPtr);
			var met:Boolean = mainClassPtr.flags[kFLAGS.HEL_TALKED_ABOUT_HER] == 1;
			init1Names(met?"":"the ",met?"Hel":"salamander","hel","You are fighting a (literally) smoking hot salamander – a seven foot tall woman with crimson scales covering her legs, back, and forearms, with a tail swishing menacingly behind her, ablaze with a red-hot fire.  Her red hair whips wildly around her slender shoulders, occasionally flitting over her hefty E-cup breasts, only just concealed within a scale-covered bikini top.  Bright red eyes focus on you from an almost-human face as she circles you, ready to close in for the kill.  Her brutal, curved sword is raised to her side, feinting at you between genuine attacks.");

			this.temperment = 2;
			//Lusty teases

			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "scales";
			this.weaponName = "sword";
			this.weaponVerb = "slashing blade";
			this.armorDef = 14;

			this.weaponAttack = 20;
			this.createStatusAffect("keen",0,0,0,0);

			this.armorValue = 50;
			//Primary stats
			this.str = 80;
			this.tou = 70;
			this.spe = 75;
			this.inte = 60;
			this.lib = 65;
			this.sens = 25;
			this.cor = 30;

			this.lustVuln = .35;

			//Combat Stats
			this.bonusHP = 275;
			this.HP = eMaxHP();

			this.lust = 30;
		
			//Level Stats
			this.level = 16;
			this.XP = totalXP();
			this.gems = 10 + rand(5);

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
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