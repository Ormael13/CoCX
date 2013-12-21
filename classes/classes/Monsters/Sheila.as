package classes.Monsters 
{
	import classes.Monster;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Sheila extends Monster 
	{
		
		public function Sheila(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="Sheila";
			this.imageName="sheila";
			this.plural = false;
			this.long = "Sheila is a slim, somewhat athletic woman, over six feet in height.  Most of her lightly-tanned skin is hidden, either by her vest and shorts or by the fuzzy fur that covers her legs from the thighs down to her prominent nails.  Her " + mainClassPtr.sheilaCup() + " breasts are briefly defined against the white of her shirt as she sways on her feet, ";
			//[(sheila corruption <=40)
			if(mainClassPtr.sheilaCorruption() <= 40) this.long += "small, round things that match her slender frame.";
			else this.long += "swollen, jiggling globes that stand in contrast to her slender body and tell a tale of all the corruption that has been pumped into her.";
			this.long += "  Her straight, jaw-length auburn hair hangs unrestrained, falling around the fuzzy ears that stick out sideways from her head.  The hat she usually wears is hanging on her back by a string, pushed off to prevent its being lost in the chaos.  Something about slipping a rope around her own neck just to keep a hat tells you that Sheila's mind isn't really staying in the fight - though it could also be the desperate, faraway look in her eyes.";
			this.a ="";
			
			this.temperment = 1;
			this.special1 = 0;
			this.special2 = 0;
			this.special3 = 0;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";
			
			//Clothing/Armor
			this.armorName = "clothes";
			this.weaponName = "foot";
			this.weaponVerb = "kick";
			this.armorDef = 4;
			this.armorPerk = "";
			this.weaponAttack = 10;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorValue = 0;
			//Primary stats
			this.str = 80;
			this.tou = 45;
			this.spe = 95;
			this.inte = 50;
			this.lib = 30;
			this.sens = 45;
			this.cor = 25;
			this.fatigue = 0;
			
			this.lust = 30;
			this.lustVuln = 0.4;
			//Combat Stats
			this.bonusHP = 200;
			this.HP = eMaxHP();
			//Level Stats
			this.level = 14;
			this.XP = totalXP();
			this.gems = rand(5) + 5;
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = 72;
			//randomly assign hair color
			this.hairColor = "auburn";
			this.hairLength = 11;
			//Skintype
			//0 - skin
			//1 - furry
			//2 - scaley
			this.skinType = SKIN_TYPE_PLAIN;
			this.skinTone = "tan";
			this.skinDesc = "skin";
			//Facetype:
			//0 - human
			//1 - horse
			//2 - dogface
			//3 - cowface
			this.faceType = FACE_HUMAN;
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
			this.tailType = TAIL_TYPE_HORSE;
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
			this.hipRating = 4;
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
			this.breastRows[0].breastRating = 0;
			this.breastRows[0].nipplesPerBreast = 1;
			this.createVagina();
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;
			this.ass.analLooseness = 1;
			this.ass.analWetness = 0;
			this.createStatusAffect("Bonus aCapacity",20,0,0,0);
			this.createStatusAffect("Bonus vCapacity",30,0,0,0);
			if(mainClassPtr.flags[kFLAGS.SHEILA_DEMON] == 1) {
				//-slightly slower, has much more stamina, intel, and HP now
				this.spe -= 15;
				this.tou += 30
				this.inte += 30;
				this.bonusHP += 200;
				this.HP = eMaxHP();
				this.lust = 50;
				this.lustVuln = .15;
				//-all special attacks are lust damage
				//-no normal attack
				//-starts with a high base lust(50%+), but also has high resistance to additional lust damage
				//-little higher difficulty than other plains fights, but not much
				//-now totally okay with taking gems and riding the player so hard he passes out for 8 hours regardless
				//-drops shitty kangaroo item and imp food
				this.long = "Sheila is a slim, somewhat athletic woman, over six feet in height.  Her smooth, dark skin is exposed from her head to her clawed feet, and she makes no effort to conceal anything your eyes might linger on.  The " + mainClassPtr.sheilaCup() + " breasts on her chest";
				if(mainClassPtr.sheilaCorruption() <= 40) 
					this.long += " are firm, squeezable teardrops; she runs a hand absently over one from time to time.";
				else 
					this.long += " jiggle as she moves, and she shoves them out to make sure you see just how lewd her body has become since your first meeting.";
				this.long += "  Straight, jaw-length auburn hair frames her face along with two long, smooth ears that stick out sideways.  Her only nods to civilization are a dangling purple earring and the finger rings that she wears on her hands, and the wild woman stares openly at you, touching herself.";
			}
			if(mainClassPtr.flags[kFLAGS.SHEILA_XP] > 3 || mainClassPtr.flags[kFLAGS.SHEILA_DEMON] > 0) {
				this.vaginas[0].virgin = false;
			}			
		}
		
	}

}