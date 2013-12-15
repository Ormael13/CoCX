package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class SharkGirl extends Monster
	{
		
		public function SharkGirl(mainClassPtr:*) 
		{

			trace("SharkGirl Constructor!");
			this.short="shark-girl";
			this.imageName="sharkgirl";
			this.plural = false;
			this.long = "The shark girl stands just over 5'5\", with grey skin shimmering from water droplets catching the sunlight and slender muscles built for swimming.  Her shoulder-length silver hair brushes past her pretty face and her eyes are a striking shade of red. She has rows of intimidating sharp teeth glinting in the light. A fish-like tail protrudes from her backside, wrapping around her toned legs at every opportunity. She's wearing a rather skimpy black bikini, strings done in such a way that they move around her fin; though the swimwear itself barely covers her perky breasts and tight snatch.";
			this.a ="the ";
			this.capitalA ="The ";
			this.temperment = 2;
			//Lusty teases
			this.special1 = 5097;
			this.special2 = 5097;
			this.special3 = 0;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";
			
			//Clothing/Armor
			this.armorName = "tough skin";
			this.weaponName = "shark teeth";
			this.weaponVerb = "bite";
			this.armorDef = 5;
			this.armorPerk = "";
			this.weaponAttack = 3;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorValue = 0;
			//Primary stats
			this.str = 40;
			this.tou = 40;
			this.spe = 55;
			this.inte = 42;
			this.lib = 75;
			this.sens = 35;
			this.cor = 40;
			this.fatigue = 0;
			
			//Combat Stats
			this.bonusHP = 20;
			this.HP = eMaxHP();
			this.lustVuln = .9;
			
			this.lust = 40;
			
			//Level Stats
			this.level = 4;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = rand(15) + 5;
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = 65;
			this.hairColor = "silver";
			this.hairLength = 16;
			//Skintype
			//0 - skin
			//1 - furry
			//2 - scaley
			this.skinType = SKIN_TYPE_PLAIN;
			this.skinTone = "gray";
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
			this.tailType = TAIL_TYPE_NONE;
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
			this.buttRating = 8;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 4;
			this.createVagina();
			this.createStatusAffect("Bonus vCapacity",15,0,0,0);
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_DROOLING;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;
			this.vaginas[0].virgin = false;
			this.ass.analLooseness = 1;
			this.createStatusAffect("Bonus aCapacity",40,0,0,0);
			this.ass.analWetness = 0;
			
		}

	}

}