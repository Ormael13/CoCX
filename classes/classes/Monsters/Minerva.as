package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Minerva extends Monster 
	{
		
		public function Minerva(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="Minerva";
			this.imageName="minerva";
			this.plural = false;
			this.long = "You're fighting the tainted siren, Minerva.  Standing around eight feet and wielding a weapon just as tall, she is a force to be reckoned with.  Her skin is a dark navy blue, though her belly, neck and inner thighs are as white as the clouds in the sky, and a golden piecing decorates her navel.  Orange and white stripes adorn her legs, tail and back.  Two large wings sprout from her back, their feathers an attention-grabbing red and orange mix.  She wears a tube-top that hold back her double d-cups, and short shorts around her wide waist that seem to be holding back a huge bulge.\n\nHer weapon is a halberd, made from a shiny, silvery metal, and seems to have an unnatural glow to it.";
			this.a ="";
			this.capitalA ="";
			this.temperment = 3;
			//Regular attack
			this.special1 = 11020;
			//Lust attack
			this.special2 = 11021;
			this.special3 = 11022;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";
			
			//Clothing/Armor
			this.armorName = "comfortable clothes";
			this.weaponName = "halberd";
			this.weaponVerb = "slash";
			this.armorDef = 1;
			this.armorPerk = "";
			this.weaponAttack = 30;
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorValue = 5;
			//Primary stats
			this.str = 50;
			this.tou = 65;
			this.spe = 95;
			this.inte = 75;
			this.lib = 30;
			this.sens = 25;
			this.cor = 45;
			this.fatigue = 0;
			
			//Combat Stats
			this.bonusHP = 470;
			this.HP = eMaxHP();
			this.lustVuln = .2;
			this.lust = 20;
			
			//Level Stats
			this.level = 16;
			this.XP = totalXP() + 50;
			this.gems = rand(25)+10;
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 3;
			this.tallness = 101;
			this.hairColor = "red";
			this.hairLength = 25;
			//Skintype
			//0 - skin
			//1 - furry
			//2 - scaley
			this.skinType = SKIN_TYPE_PLAIN;
			this.skinTone = "blue";
			this.skinDesc = "skin";
			//Facetype:
			//0 - human
			//1 - horse
			//2 - dogface
			this.faceType = FACE_HUMAN;
			this.hornType = HORNS_NONE;
			this.wingDesc = "fluffy feathery";
			//Wingtype
			//0 - none
			//1 - bee
			//2 - large bee
			//3 - faerie?
			//4 - avian
			//5 - dragoooon?
			this.wingType = WING_TYPE_HARPY;
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
			this.buttRating = 9;
			//Create succubus sex attributes
			this.createVagina();
			this.createCock();
			this.cocks[0].cockLength = 16;
			this.cocks[0].cockThickness = 3;
			this.createBreastRow();
			this.breastRows[0].breastRating = 5;
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;
			this.vaginas[0].virgin = false;
			this.balls = 2;
			this.cumMultiplier = 3;
			this.ballSize = 3;
			this.ass.analLooseness = 1;
			this.ass.analWetness = 0;			
		}
		
	}

}