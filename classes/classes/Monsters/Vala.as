package classes.Monsters 
{
	import classes.Monster;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Vala extends Monster 
	{
		
		public function Vala(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="Vala";
			this.imageName="vala";
			this.plural = false;
			this.long = "While the fey girl is whip-thin, her breasts are disproportionately huge. They'd be at least a DD-cup on a normal human, but for her height and body type, they're practically as large as her head. They jiggle at her slow, uneven breathing, tiny drops of milk bubbling at her nipples with every heartbeat.  She seems fixated on mating with you, and won't take no for an answer.";
			this.a ="";
			this.capitalA ="";
			this.temperment = 2;
			//Lusty teases
			this.special1 = 0;
			this.special2 = 0;
			this.special3 = 0;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";
			
			//Clothing/Armor
			this.armorName = "skin";
			this.weaponName = "fists";
			this.weaponVerb = "caresses";
			this.armorDef = 0;
			this.armorPerk = "";
			this.weaponAttack = 0;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorValue = 0;
			//Primary stats
			this.str = 40;
			this.tou = 50;
			this.spe = 50;
			this.inte = 60;
			this.lib = 55;
			this.sens = 35;
			this.cor = 50;
			this.fatigue = 0;
			this.lustVuln = .5;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 0) this.lustVuln += .25;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 2) this.lustVuln += .5;
			
			//Combat Stats
			this.bonusHP = 350;
			this.HP = eMaxHP();
			
			this.lust = 30 + mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] * 10;
			if(this.lust > 80) this.lust = 80;
			
			
			//Level Stats
			this.level = 11;
			this.XP = totalXP() + 50;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 0) this.XP = 5;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 2) this.XP = 1;
			this.gems = 1;
			
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 3;
			this.tallness = 48;
			this.hairColor = "purple";
			this.hairLength = 22;
			//Skintype
			//0 - skin
			//1 - furry
			//2 - scaley
			this.skinType = SKIN_TYPE_PLAIN;
			this.skinTone = "fair";
			this.skinDesc = "skin";
			//Facetype:
			//0 - human
			//1 - horse
			//2 - dogface
			this.faceType = FACE_HUMAN;
			this.hornType = HORNS_NONE;
			this.wingDesc = "shimmering wings";
			//Wingtype
			//0 - none
			//1 - bee
			//2 - large bee
			//3 - faerie?
			//4 - avian
			//5 - dragoooon?
			this.wingType = WING_TYPE_BEE_LIKE_LARGE;
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
			this.breastRows[0].breastRating = 7;
			this.createVagina();
			this.createStatusAffect("Bonus vCapacity",25,0,0,0);
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_GAPING_WIDE;
			this.vaginas[0].virgin = false;
			this.ass.analLooseness = 4;
			this.createStatusAffect("Bonus aCapacity",10,0,0,0);
			this.ass.analWetness = 0;
			
		}
		
	}

}