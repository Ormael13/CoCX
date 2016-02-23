/**
 * Created by K.Quesom 11.06.14
 */
package classes.Items.Consumables
{
	import classes.GlobalFlags.kFLAGS;
    import classes.Player;
	import classes.PregnancyStore;
	import classes.StatusEffects;
    import classes.internals.Utils;
	import classes.Items.Consumable;

	public class PhoukaWhiskey extends Consumable {
		
		public function PhoukaWhiskey() {
			super("P_Whsky", "Ph. Whiskey", "a small bottle of whiskey", 20, "A small, corked glass bottle with a dark amber liquid inside.  The whiskey smells strongly of peat.");
		}
		
        override public function canUse():Boolean {
			switch (phoukaWhiskeyAcceptable(game.player)) {
				case -4:
					outputText("You stare at the bottle for a moment, but decide not to risk harming one of the children growing inside you.\n\n");
					return false;
				case -3:
					outputText("You stare at the bottle for a moment, but decide not to risk harming either of the children growing inside you.\n\n");
					return false;
				case -2:
					outputText("You stare at the bottle for a moment, but decide not to risk harming the child growing inside your colon.\n\n");
					return false;
				case -1:
					outputText("You stare at the bottle for a moment, but decide not to risk harming the child growing inside your womb.\n\n");
					return false;
				default:
			}
            return true; //Zero and up will return true
        }
		
		override public function useItem():Boolean {
			game.player.slimeFeed();
			switch (phoukaWhiskeyDrink(game.player)) {
				case 0: //Player isn't pregnant
					outputText("You uncork the bottle and drink some whiskey, hoping it will let you relax for a while.\n\nIt's strong stuff and afterwards you worry a bit less about the future.  Surely things will right themselves in the end.");
					game.dynStats("cor", Utils.rand(2) + 1, "lus", Utils.rand(8) + 1); //These gains are permanent
					break;
				case 1: //Child is a phouka or satyr, loves alcohol
					outputText("You uncork the bottle and drink some whiskey, hoping it will help with the gnawing hunger for alcohol you've had since this baby started growing inside you.\n\nYou down the booze in one shot and a wave of contentment washes over you.  It seems your passenger enjoyed the meal.");
					break;
				case 2: //Child is a faerie but will become a phouka with this drink
					outputText("At first you feel your baby struggle against the whiskey, then it seems to grow content and enjoy it.");
					break;
				case 3: //Child is a faerie, hates phouka whiskey
					outputText("You feel queasy and want to throw up.  There's a pain in your belly and you realize the baby you're carrying didn't like that at all.");
			}
			game.flags[kFLAGS.PREGNANCY_CORRUPTION]++; //Faerie or phouka babies become more corrupted, no effect if the player is not pregnant or on other types of babies
			phoukaWhiskeyAddStatus(game.player);
			return(false);
        }
        
		public function phoukaWhiskeyAcceptable(player:Player):int
		{ //This function provides a single common test that can be used both by this class and the PhoukaScene class
			//Returns:	0 = canUse (not pregnant), 1 = canUse (single pregnancy, womb), 2 = canUse (single pregnancy, colon), 3 = canUse (double pregnancy, both OK),
			//			-1 = No (single pregnancy, womb), -2 = No (single pregnancy, colon), -3 = No (double pregnancy, both not OK), -4 = No (double pregnancy, one OK, one not)
			if (player.pregnancyIncubation == 0) {				
				if (player.buttPregnancyIncubation == 0) return 0; //No baby. Simplest, most common case
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR) return 2;
				return -2;
			}
			if (player.buttPregnancyIncubation == 0) { //Single pregnancy, carried in the womb
				if (player.pregnancyType == PregnancyStore.PREGNANCY_SATYR) return 1;
				if (player.pregnancyType == PregnancyStore.PREGNANCY_FAERIE) return 1;
				return -1;
			}
			//Double pregnancy
			var wombBabyLikesAlcohol:Boolean = (player.pregnancyType == PregnancyStore.PREGNANCY_SATYR) || (player.pregnancyType == PregnancyStore.PREGNANCY_FAERIE);
			var colonBabyLikesAlcohol:Boolean = (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR);
			if (wombBabyLikesAlcohol && colonBabyLikesAlcohol) return 3;
			if (!wombBabyLikesAlcohol && !colonBabyLikesAlcohol) return -3;
			return -4;
		}
		
		public function phoukaWhiskeyDrink(player:Player):int
		{ //This function provides a single common test that can be used both by this class and the PhoukaScene class
			//Returns:	0 = Player is not pregnant, 1 = Player is pregnant with a satyr or phouka, 2 = Player is pregnant with a faerie that will become a phouka with this drink,
			//			3 = Player is pregnant with a faerie that will remain a faerie after this drink
			if ((player.pregnancyIncubation == 0) && (player.buttPregnancyIncubation == 0)) return 0;
			if (player.pregnancyType == PregnancyStore.PREGNANCY_FAERIE) {
				if (game.flags[kFLAGS.PREGNANCY_CORRUPTION] == 0) return 2;
				if (game.flags[kFLAGS.PREGNANCY_CORRUPTION] < 0) return 3;
			}
			return 1; //Pregnancy has to be either a satyr or a phouka
		}
        
        public function phoukaWhiskeyAddStatus(player:Player):void
        {
			var libidoChange:int = (player.lib + 25 > 100 ? 100 - player.lib : 25);
			var sensChange:int = (player.sens < 10 ? player.sens : 10);
			var speedChange:int = (player.spe < 20 ? player.spe : 20);
			var intChange:int = (player.inte < 20 ? player.inte : 20);
			if (player.findStatusEffect(StatusEffects.PhoukaWhiskeyAffect) >= 0) {
				var drinksSoFar:int = player.statusEffectv2(StatusEffects.PhoukaWhiskeyAffect);
				if (drinksSoFar < 4)
					player.addStatusValue(StatusEffects.PhoukaWhiskeyAffect, 1, 8 - (2 * drinksSoFar));
				else
					player.addStatusValue(StatusEffects.PhoukaWhiskeyAffect, 1, 1); //Always get at least one more hour of drunkenness
				player.addStatusValue(StatusEffects.PhoukaWhiskeyAffect, 2, 1);
				player.addStatusValue(StatusEffects.PhoukaWhiskeyAffect, 3, 256 * libidoChange + sensChange);
				player.addStatusValue(StatusEffects.PhoukaWhiskeyAffect, 4, 256 * speedChange + intChange);
				outputText("\n\nOh, it tastes so good.  This stuff just slides down your throat.");
				game.dynStats("lib", libidoChange, "sens", -sensChange, "spe", -speedChange, "int", -intChange);
			}
			else { //First time
				player.createStatusEffect(StatusEffects.PhoukaWhiskeyAffect, 8, 1, 256 * libidoChange + sensChange, 256 * speedChange + intChange);
					//The four stats we’re affecting get paired together to save space. This way we don’t need a second StatusEffect to store more info.
				game.dynStats("lib", libidoChange, "sens", -sensChange, "spe", -speedChange, "int", -intChange);
			}
			game.statScreenRefresh();
        }
		
		public function phoukaWhiskeyExpires(player:Player):void
		{
			var numDrunk:int = player.statusEffectv2(StatusEffects.PhoukaWhiskeyAffect);
			var libidoSensCombined:int = player.statusEffectv3(StatusEffects.PhoukaWhiskeyAffect);
			var intSpeedCombined:int = player.statusEffectv4(StatusEffects.PhoukaWhiskeyAffect);
			
			var sensChange:int = libidoSensCombined & 255;
			var libidoChange:int = (libidoSensCombined - sensChange) / 256;
			var intChange:int = intSpeedCombined & 255;
			var speedChange:int = (intSpeedCombined - intChange) / 256;
			game.dynStats("lib", -libidoChange , "sens", sensChange, "spe", speedChange, "int", intChange); //Get back all the stats you lost
			player.removeStatusEffect(StatusEffects.PhoukaWhiskeyAffect);
			if (numDrunk > 3)
				outputText("\n<b>The dizzy sensation dies away and is replaced by a throbbing pain that starts in your skull and then seems to run all through your body, seizing up your joints and making your stomach turn.  The world feels like it’s off kilter and you aren’t in any shape to face it.  You suppose you could down another whiskey, but right now that doesn’t seem like such a good idea.</b>\n");
			else if (numDrunk > 1)
				outputText("\n<b>The fuzzy, happy feeling ebbs away.  With it goes the warmth and carefree feelings.  Your head aches and you wonder if you should have another whiskey, just to tide you over</b>\n");
			else
				outputText("\n<b>The fuzzy, happy feeling ebbs away.  The weight of the world’s problems seems to settle on you once more.  It was nice while it lasted and you wouldn’t mind having another whiskey.</b>\n");
			game.statScreenRefresh();
		}
    }
}
