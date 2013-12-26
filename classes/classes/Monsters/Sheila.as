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


		override protected function performCombatAction():void
		{
			mainClassPtr.sheilaAI();
		}

		public function Sheila(mainClassPtr:*)
		{
			super(mainClassPtr);
			var sheilaDemon:Boolean = mainClassPtr.flags[kFLAGS.SHEILA_DEMON] == 1;
			init01Names("", "Sheila", "sheila",
					sheilaDemon ?
							("Sheila is a slim, somewhat athletic woman, over six feet in height.  Most of her lightly-tanned skin is hidden, either by her vest and shorts or by the fuzzy fur that covers her legs from the thighs down to her prominent nails.  Her " + mainClassPtr.sheilaCup() + " breasts are briefly defined against the white of her shirt as she sways on her feet, " + (mainClassPtr.sheilaCorruption() <= 40 ? "small, round things that match her slender frame." : "swollen, jiggling globes that stand in contrast to her slender body and tell a tale of all the corruption that has been pumped into her.") + "  Her straight, jaw-length auburn hair hangs unrestrained, falling around the fuzzy ears that stick out sideways from her head.  The hat she usually wears is hanging on her back by a string, pushed off to prevent its being lost in the chaos.  Something about slipping a rope around her own neck just to keep a hat tells you that Sheila's mind isn't really staying in the fight - though it could also be the desperate, faraway look in her eyes."):
							("Sheila is a slim, somewhat athletic woman, over six feet in height.  Her smooth, dark skin is exposed from her head to her clawed feet, and she makes no effort to conceal anything your eyes might linger on.  The " + mainClassPtr.sheilaCup() + " breasts on her chest" +(mainClassPtr.sheilaCorruption() <= 40 ? " are firm, squeezable teardrops; she runs a hand absently over one from time to time." :	" jiggle as she moves, and she shoves them out to make sure you see just how lewd her body has become since your first meeting.") +"  Straight, jaw-length auburn hair frames her face along with two long, smooth ears that stick out sideways.  Her only nods to civilization are a dangling purple earring and the finger rings that she wears on her hands, and the wild woman stares openly at you, touching herself."));
			init02Female(VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_NORMAL, 30, mainClassPtr.flags[kFLAGS.SHEILA_XP] <= 3 && !sheilaDemon);
			init03BreastRows([mainClassPtr.flags[kFLAGS.SHEILA_CORRUPTION]/10]);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,20);
			init05Body("6'",HIP_RATING_AVERAGE,BUTT_RATING_AVERAGE+1,LOWER_BODY_TYPE_KANGAROO);
			init06Skin("tan");
			init07Hair("auburn",11);
			init08Face();
			init09PrimaryStats(80,45,95,50,30,45,25);
			var lust:Number = 30;
			var lustVuln:Number = 0.4;
			var bonusHP:Number = 200;
			if (sheilaDemon) {
				//-slightly slower, has much more stamina, intel, and HP now
				this.spe -= 15;
				this.tou += 30;
				this.inte += 30;
				bonusHP += 200;
				lust= 50;
				lustVuln= .15;
				//-all special attacks are lust damage
				//-no normal attack
				//-starts with a high base lust(50%+), but also has high resistance to additional lust damage
				//-little higher difficulty than other plains fights, but not much
				//-now totally okay with taking gems and riding the player so hard he passes out for 8 hours regardless
				//-drops shitty kangaroo item and imp food
			}
			init10Weapon("foot","kick",10);
			init11Armor("clothes",4);
			init12Combat(bonusHP,lust,lustVuln,Monster.TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(14,rand(5) + 5);
			initX_Tail(TAIL_TYPE_HORSE);

		}

	}

}