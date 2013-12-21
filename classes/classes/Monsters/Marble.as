package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Marble extends Monster
	{
		

		public function Marble(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("Marble Constructor!");
			this.short="Marble";
			this.imageName="marble";
			this.plural = false;
			this.long = "Before you stands a female humanoid with numerous cow features, such as medium-sized cow horns, cow ears, and a cow tail.  She is very well endowed, with wide hips and a wide ass.  She stands over 6 feet tall.  She is using a large two handed hammer with practiced ease, making it clear she is much stronger then she may appear to be.";
			this.a ="";
			
			this.temperment = 2;
			//Regular attack
			this.special1 = 5092;
			//Lust attack
			this.special2 = 5093;
			this.special3 = 0;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";
			
			//Clothing/Armor
			this.armorName = "tough hide";
			this.weaponName = "large hammer";
			this.weaponVerb = "hammer-blow";
			this.armorDef = 5;
			this.armorPerk = "";
			this.weaponAttack = 10;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorValue = 0;
			//Primary stats
			this.str = 75;
			this.tou = 70;
			this.spe = 35;
			this.inte = 40;
			this.lib = 25;
			this.sens = 45;
			this.cor = 40;
			this.fatigue = 0;
			
			//Combat Stats
			this.bonusHP = 0;
			this.HP = eMaxHP();
			
			this.lust = 0;
			
			//Level Stats
			this.level = 7;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = rand(5) + 25;
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = 76;
			this.hairColor = "brown";
			this.hairLength = 13;
			//Skintype
			//0 - skin
			//1 - furry
			//2 - scaley
			this.skinType = SKIN_TYPE_PLAIN;
			this.skinTone = "pale";
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
			this.lowerBody = LOWER_BODY_TYPE_CENTAUR;
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
			this.tailRecharge = 5;
			//hipRating
			//0 - boyish
			//2 - slender
			//4 - average
			//6 - noticable/ample
			//10 - curvy//flaring
			//15 - child-bearing/fertile
			//20 - inhumanly wide
			this.hipRating = 10;
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
			this.buttRating = 8;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 11;
			this.createVagina();
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_NORMAL;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;
			this.vaginas[0].virgin = false;
			this.ass.analLooseness = 0;
			this.ass.analWetness = 0;
			
		}

	}

}