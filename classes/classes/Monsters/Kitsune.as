package classes.Monsters 
{
	import classes.Monster;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Kitsune extends Monster 
	{
		
		public function Kitsune(mainClassPtr:*,hairColor:String) 
		{
			super(mainClassPtr);
			this.hairColor = hairColor;
			this.short="kitsune";
			this.imageName="kitsune";
			this.plural = false;
			this.long = "A kitsune stands in front of you, about five and a half feet tall.  She has a head of ";
			
			if(hairColor == "blonde") this.long += "long flaxen";
			else if(hairColor == "black") this.long += "lustrous, ass-length black";
			else this.long += "unkempt, shoulder-length reddish";
			this.long += " hair.  She appears mostly human, except for a pair of large, furry ears poking through her hair and six luxurious silky tails swaying in the air behind her.  Her robes are revealing but comfortable-looking, hugging her voluptuous curves and exposing large swaths of tattooed skin.  A layer of ornate tattoos covers patches of her exposed flesh, accentuating her feminine curves nicely, and each movement brings a pleasant jiggle from her plump backside and large breasts.";
			if(rand(3) != 2) mainClassPtr.flags[kFLAGS.redheadIsFuta] = 1;
			this.a ="a ";
			
			this.temperment = 1;
			this.special1 = 5029;
			this.special2 = 0;
			this.special3 = 0;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";
			
			//Clothing/Armor
			this.armorName = "skin";
			this.weaponName = "claws";
			this.weaponVerb = "punch";
			this.armorDef = 0;
			this.armorPerk = "";
			this.weaponAttack = 0;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorValue = 0;
			//Primary stats
			this.str = 35;
			this.tou = 45;
			this.spe = 90;
			this.inte = 95;
			this.lib = 60;
			this.sens = 65;
			this.cor = 45;
			this.fatigue = 0;
			this.lust = 20;
			
			this.lustVuln = 0.9;
			//Combat Stats
			this.bonusHP = 120;
			this.HP = eMaxHP();
			
			//Level Stats
			this.level = 6;
			this.XP = totalXP();
			this.gems = rand(10) + 10;
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			if(mainClassPtr.flags[kFLAGS.redheadIsFuta] == 1) this.gender == 3;
			this.tallness = rand(24) + 60;
			
			this.hairLength = 13+rand(20);
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
			//3 - cowface
			this.faceType = FACE_COW_MINOTAUR;
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
			this.lowerBody = LOWER_BODY_TYPE_HUMAN;
			//tailType:
			//0 - none
			//1 - horse
			//2 - dog
			//3 - demon
			//4 - cow!
			//5 - spider!
			//6 - bee!
			//7 - cow!
			this.tailType = TAIL_TYPE_FOX;
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
			this.hipRating = 6;
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
			this.buttRating = 5;
			//Create imp sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 4;
			this.breastRows[0].nipplesPerBreast = 1;
			if(hairColor == "red") {
				this.createCock();
				this.cocks[0].cockLength = rand(13) + 14;
				this.cocks[0].cockThickness = 1.5 + rand(20)/2;
				this.cocks[0].cockType = CockTypesEnum.HUMAN;
				this.balls = 2;
				this.cumMultiplier = 1.5;
				this.ballSize = 2 + rand(13);
				this.hoursSinceCum = mainClassPtr.player.ballSize * 10;
			}
			this.ass.analLooseness = 1;
			this.ass.analWetness = 1;
			this.createVagina();
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;
			this.createStatusAffect("Bonus aCapacity",20,0,0,0);
			this.createStatusAffect("Bonus vCapacity",20,0,0,0);			
		}
		
	}

}