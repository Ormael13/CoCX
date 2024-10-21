package classes.Items.Consumables
{
    import classes.CoC;
    import classes.Items.Consumable;
    import classes.Player;
    import classes.Scenes.SceneLib;
    import classes.internals.Utils;

    /**
    *Non-Transformative pure bee honey. Reduces corruption, lust, libido.
    */
    public class Ambrosia extends Consumable
    {
        public function Ambrosia()
        {
            super("Ambrosa","Ambrosia", "a small crystal vial filled with a glittering amber fluid you got from the Sand Mother. You can smell a sweet scent, even though it is tightly corked");
        }

        override public function canUse():Boolean {
            if (SceneLib.exgartuan.dickPresent()) { //Exgartuan doesn't like the pure honey products
                outputText("You uncork the bottle only to hear Exgartuan suddenly speak up.  <i>\"Hey kid, this beautiful cock here doesn’t need any of that special bee shit.  Cork that bottle up right now or I’m going to make it so that you can’t drink anything but me.\"</i>  You give an exasperated sigh and put the cork back in the bottle.");
				return false;
			}
			return true;
        }

        override public function useItem():Boolean
        {
            var player:Player = CoC.instance.player;
            clearOutput();
            player.slimeFeed();
            //Drinking text
            outputText("You uncap the small crystal vial and are greeted by a super-concentrated wave of sweet honey scent. Tilting your head back, you pour the cold, sweet liquid down your throat. \n \n");
            player.refillHunger(15);
            //Special texts for corruption
            if (player.cor < 10){
                outputText("\nThe fluid tingles as it flows down your throat but quickly passes, leaving you more clear-headed");
            }

            if (player.cor >= 10 && player.cor < 20){
                outputText("\n\nA mildly unpleasant tingling follows the fluid, lingering and spreading through your skull.");
            }

            if (player.cor >= 20 && player.cor < 40){
                outputText("\n\nYou break out into a cold sweat as a prickling pain spreads from your skull down, flowing through your body.");
            }

            if (player.cor >= 40 && player.cor < 60){
                outputText("\n\nA wave of stininging pain slices through your body and head as the freezing liquid hits your stomach, you suddenly feel as if you were standing naked in a blizzard. Your arms and legs start to go numb, and even though you think you've never felt colder in your life, your body is covered in sweat.\n\nEventually, you begin to feel more normal, though your thoughts seem more clear now.");
            }

            if (player.cor >= 60 && player. cor < 80){
                outputText("\n\nAs you swallow the liquid you feel a sharp pain snap right before your eyes. In moments, you fall to your knees, gasping for breath. It feels as if somebody has turned your skin to ice. You break out in a cold sweat as the sensation grows more intense, and you feel as if your blood is freezing in your veins. As you start losing feeling in your extremities, you pass out. \n\nLater, when you wake up, the constant haze of lust that clouded your thoughts seems to have lightened.");
            }

            if (player.cor >= 80){
                outputText("\n\nNot long after the fluid touched your tongue did pain start to erupt through your body. You fall to your knees screaming as the numbing cold, yet burning hot sensation spreads through your body, nearly feeling as if somebody was ripping the skin from your form. Miraculously, you pass out. \n\nOnce you eventually regain consciousness, the mist that clouded your thoughts has lifted somewhat.");
            }

            //Remove corruption
            var corLoss:Number = 5 + Math.floor(player.cor / 10);
            dynStats("cor", -corLoss);

            //Libido Reduction
			if (player.cor > 0 && changes < changeLimit && Utils.rand(1.5) == 0 && player.lib > 40) {
				outputText(" and settling your overcharged sex-drive a bit.");
				dynStats("lus", -Math.round(20*player.postConsumptionMlt()), "scale", false);
				player.addCurse("lib", 3, 1);
				changes++;
			}

            //Intelligence Boost
			if (changes < changeLimit && Utils.rand(2) == 0 && player.MutagenBonus("int", 1)) {
				outputText("\n\nYou spend a few moments analyzing the taste and texture of the fluid residue, feeling awfully smart for it.");
				changes++;
			}
            return false;
        }
    }
}
