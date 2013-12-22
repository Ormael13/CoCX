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
			init1Names("", "Sheila", "sheila",
					mainClassPtr.flags[kFLAGS.SHEILA_DEMON] == 1 ?
							("Sheila is a slim, somewhat athletic woman, over six feet in height.  Most of her lightly-tanned skin is hidden, either by her vest and shorts or by the fuzzy fur that covers her legs from the thighs down to her prominent nails.  Her " + mainClassPtr.sheilaCup() + " breasts are briefly defined against the white of her shirt as she sways on her feet, " + (mainClassPtr.sheilaCorruption() <= 40 ? "small, round things that match her slender frame." : "swollen, jiggling globes that stand in contrast to her slender body and tell a tale of all the corruption that has been pumped into her.") + "  Her straight, jaw-length auburn hair hangs unrestrained, falling around the fuzzy ears that stick out sideways from her head.  The hat she usually wears is hanging on her back by a string, pushed off to prevent its being lost in the chaos.  Something about slipping a rope around her own neck just to keep a hat tells you that Sheila's mind isn't really staying in the fight - though it could also be the desperate, faraway look in her eyes."):
							("Sheila is a slim, somewhat athletic woman, over six feet in height.  Her smooth, dark skin is exposed from her head to her clawed feet, and she makes no effort to conceal anything your eyes might linger on.  The " + mainClassPtr.sheilaCup() + " breasts on her chest" +(mainClassPtr.sheilaCorruption() <= 40 ? " are firm, squeezable teardrops; she runs a hand absently over one from time to time." :	" jiggle as she moves, and she shoves them out to make sure you see just how lewd her body has become since your first meeting.") +"  Straight, jaw-length auburn hair frames her face along with two long, smooth ears that stick out sideways.  Her only nods to civilization are a dangling purple earring and the finger rings that she wears on her hands, and the wild woman stares openly at you, touching herself."));
			init2Female(VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_NORMAL, 30, mainClassPtr.flags[kFLAGS.SHEILA_XP] <= 3 && mainClassPtr.flags[kFLAGS.SHEILA_DEMON] >= 0);
			init3BreastRows(0);
			init4Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,20);
			init5Body("6'",HIP_RATING_AVERAGE,BUTT_RATING_AVERAGE+1);

			this.temperment = 1;

			//Clothing/Armor
			this.armorName = "clothes";
			this.weaponName = "foot";
			this.weaponVerb = "kick";
			this.armorDef = 4;

			this.weaponAttack = 10;

			//Primary stats
			this.str = 80;
			this.tou = 45;
			this.spe = 95;
			this.inte = 50;
			this.lib = 30;
			this.sens = 45;
			this.cor = 25;

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
			//randomly assign hair color
			this.hairColor = "auburn";
			this.hairLength = 11;

			this.skinTone = "tan";
			this.skinDesc = "skin";

			//3 - cowface

			//7 - cow!
			this.tailType = TAIL_TYPE_HORSE;

			this.createStatusAffect("Bonus aCapacity", 20, 0, 0, 0);
			if (mainClassPtr.flags[kFLAGS.SHEILA_DEMON] == 1) {
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
			}
		}

	}

}