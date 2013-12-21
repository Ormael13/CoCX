package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class OmnibusOverseer extends Monster 
	{
		
		public function OmnibusOverseer(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="Omnibus Overseer";
			this.imageName="omnibusoverseer";
			this.plural = false;
			this.long = "The 'woman' before you is clothed only in a single strip of fabric that wraps around her bountiful chest.  She has striking red eyes that contrast visibly with her blue skin and dark make-up.  Shiny black gloss encapsulates her kissable bubbly black lips.  Her most striking feature is her crotch, which appears neither male nor female.  She has a puffy wet vulva, but a cock-shaped protrusion sprouts from where a clit should be.";
			this.a ="the ";
			this.temperment = 3;
			//Regular attack
			this.special1 = 11043;
			//Lust attack
			this.special2 = 11044;
			this.special3 = 0;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";
			
			//Clothing/Armor
			this.armorName = "demonic skin";
			this.weaponName = "claws";
			this.weaponVerb = "claw";
			this.armorDef = 15;
			this.armorPerk = "";
			this.weaponAttack = 10;
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorValue = 0;
			//Primary stats
			this.str = 65;
			this.tou = 45;
			this.spe = 45;
			this.inte = 85;
			this.lib = 80;
			this.sens = 70;
			this.cor = 80;
			this.fatigue = 0;
			
			//Combat Stats
			this.bonusHP = 200;
			this.HP = eMaxHP();
			
			this.lust = 20;
			this.lustVuln = 0.75;
			
			//Level Stats
			this.level = 8;
			this.XP = totalXP();
			this.gems = rand(25)+10;
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = rand(9) + 70;
			this.hairColor = "purple";
			this.hairLength = 42;
			//Skintype
			//0 - skin
			//1 - furry
			//2 - scaley
			this.skinType = SKIN_TYPE_PLAIN;
			this.skinTone = "light purple";
			this.skinDesc = "skin";
			//Facetype:
			//0 - human
			//1 - horse
			//2 - dogface
			this.faceType = FACE_HUMAN;
			this.hornType = HORNS_NONE;
			this.wingDesc = "tiny hidden";
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
			this.lowerBody = LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS;
			//tailType:
			//0 - none
			//1 - horse
			//2 - dog
			//3 - demon
			//4 - cow!
			//5 - spider!
			//6 - bee!
			this.tailType = TAIL_TYPE_DEMONIC;
			//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
			this.tailVenom = 0;
			//Tail recharge determines how fast venom/webs comes back per hour.
			this.tailRecharge = 5;
			//hipRating
			//0 - boyish
			//2 - slender
			//4 - average
			//6 - noticable/ample
			//10 - curvy//flaring
			//15 - child-bearing/fertile
			//20 - inhumanly wide
			this.hipRating = 8;
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
			this.buttRating = 2;
			//Create succubus sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 0;
			this.createVagina();
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_DROOLING;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;
			this.vaginas[0].virgin = false;
			this.cumMultiplier = 3;
			this.createCock();
			this.cocks[0].cockLength = 10;
			this.cocks[0].cockThickness = 1.5;
			this.ass.analLooseness = 1;
			this.ass.analWetness = 35;			
		}
		
	}

}