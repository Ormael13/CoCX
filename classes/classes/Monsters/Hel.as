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
			this.short = "salamander";
			this.imageName = "hel"
			this.plural = false;
			this.long = "You are fighting a (literally) smoking hot salamander – a seven foot tall woman with crimson scales covering her legs, back, and forearms, with a tail swishing menacingly behind her, ablaze with a red-hot fire.  Her red hair whips wildly around her slender shoulders, occasionally flitting over her hefty E-cup breasts, only just concealed within a scale-covered bikini top.  Bright red eyes focus on you from an almost-human face as she circles you, ready to close in for the kill.  Her brutal, curved sword is raised to her side, feinting at you between genuine attacks.";
			this.a ="the ";
			
			if(mainClassPtr.flags[kFLAGS.HEL_TALKED_ABOUT_HER] == 1) {
				this.short ="Hel";
				this.a = "";
				
			}
			
			this.temperment = 2;
			//Lusty teases
			this.special1 = 0;
			this.special2 = 0;
			this.special3 = 0;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";
			
			//Clothing/Armor
			this.armorName = "scales";
			this.weaponName = "sword";
			this.weaponVerb = "slashing blade";
			this.armorDef = 14;
			this.armorPerk = "";
			this.weaponAttack = 20;
			this.createStatusAffect("keen",0,0,0,0);
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorValue = 50;
			//Primary stats
			this.str = 80;
			this.tou = 70;
			this.spe = 75;
			this.inte = 60;
			this.lib = 65;
			this.sens = 25;
			this.cor = 30;
			this.fatigue = 0;
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
			//Skintype
			//0 - skin
			//1 - furry
			//2 - scaley
			this.skinType = SKIN_TYPE_PLAIN;
			this.skinTone = "dusky";
			this.skinDesc = "skin";
			//Facetype:
			//0 - human
			//1 - horse
			//2 - dogface
			this.faceType = FACE_HUMAN;
			this.hornType = HORNS_NONE;
			this.wingDesc = "non-existant";
			//Wingtype
			//0 - none
			//1 - bee
			//2 - large bee
			//3 - faerie?
			//4 - avian
			//5 - dragoooon?
			this.wingType = WING_TYPE_NONE;
			//lowerBody:
			//0 - normal
			//1 - hooves
			//2 - paws
			//3 - snakelike body
			//4 - centaur!
			//5 - demonic heels
			//6 - demon foot-claws
			this.lowerBody = LOWER_BODY_TYPE_HUMAN;
			//tailType:
			//0 - none
			//1 - horse
			//2 - dog
			//3 - demon
			//4 - cow!
			//5 - spider!
			//6 - bee!
			this.tailType = TAIL_TYPE_COW;
			//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
			this.tailVenom = 0;
			//Tail recharge determines how fast venom/webs comes back per hour.
			this.tailRecharge = 0;
			//hipRating
			//0 - boyish
			//2 - slender
			//4 - average
			//6 - noticable/ample
			//10 - curvy//flaring
			//15 - child-bearing/fertile
			//20 - inhumanly wide
			this.hipRating = 12;
			//buttRating
			//0 - buttless
			//2 - tight
			//4 - average
			//6 - noticable
			//8 - large
			//10 - jiggly
			//13 - expansive
			//16 - huge
			//20 - inconceivably large/big/huge etc
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