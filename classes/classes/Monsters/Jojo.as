package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Jojo extends Monster
	{
		

		public function Jojo(mainClassPtr:*) 
		{
			
			trace("Jojo Constructor!");
			this.short="Jojo";
			this.imageName="jojo";
			this.plural = false;
			this.long = "Jojo is an anthropomorphic mouse with immaculate white fur.  Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed.  He wears loose white clothes wrapped in prayer beads and tattered prayer papers.";
			this.a ="";
			this.capitalA ="";
			this.temperment = 1;
			this.special1 = 5021;
			this.special2 = 0;
			this.special3 = 0;
			this.pronoun1 = "he";
			this.pronoun2 = "him";
			this.pronoun3 = "his";
			
			//Clothing/Armor
			this.armorName = "robes";
			this.weaponName = "paw";
			this.weaponVerb = "punch";
			this.armorDef = 0;
			this.armorPerk = "";
			this.weaponAttack = 0;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorValue = 0;
			//Primary stats
			this.str = 35;
			this.tou = 40;
			this.spe = 65;
			this.inte = 55;
			this.lib = 15;
			this.sens = 40;
			this.cor = 0;
			this.fatigue = 0;
			
			//Combat Stats
			this.HP = eMaxHP();
			this.lust = 15;
			this.lustVuln = .9;
			
			//Level Stats
			this.level = 4;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = rand(5) + 2;
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 1;
			this.tallness = 61;
			this.hairColor = "white";
			this.hairLength = 2;
			//Skintype
			//0 - skin
			//1 - furry
			//2 - scaley
			this.skinType = SKIN_TYPE_FUR;
			this.skinTone = "white";
			this.skinDesc = "fur";
			//Facetype:
			//0 - human
			//1 - horse
			//2 - dogface
			this.faceType = FACE_HUMAN;
			this.wingDesc = "";
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
			this.hipRating = 2;
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
			//Create jojo sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 0;
			this.breastRows[0].nipplesPerBreast = 1;
			this.createCock();
			this.cocks[0].cockLength = 7.5;
			this.cocks[0].cockThickness = 1.8;
			this.cumMultiplier = 1;
			this.hoursSinceCum = 1000;
			this.ass.analLooseness = 1;
			this.ass.analWetness = 1;
			//Variations based on jojo's corruption.
			if(mainClassPtr.monk == 3) {
				this.lust += 30;
				this.cocks[0].cockThickness += .2;
				this.cocks[0].cockLength += 1.5;
				if(mainClassPtr.player.gender == 1 || mainClassPtr.player.gender == 3) this.ass.analLooseness = 2;
			}
			if(mainClassPtr.monk == 4) {
				this.lust += 40;
				this.cocks[0].cockThickness += .5;
				this.cocks[0].cockLength += 3.5;
				if(mainClassPtr.player.gender == 1 || mainClassPtr.player.gender == 3) this.ass.analLooseness = 3;
			}
			if(mainClassPtr.monk == 5) {
				this.lust += 50;
				this.cocks[0].cockThickness += 1;
				this.cocks[0].cockLength += 5.5;
				this.str -= 20;
				this.tou += 30;
				this.HP += 60;
				if(mainClassPtr.player.gender == 1 || mainClassPtr.player.gender == 3) this.ass.analLooseness = 4;
				this.long = "Jojo is an anthropomorphic mouse with immaculate white fur.  Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed.  He's naked, with a large tainted throbbing member bouncing at attention.  A fuzzy sack with painfully large looking balls dangles between his legs.";
			}
			
			// possible issues accessing flags from this context. 
			
		}

	}

}