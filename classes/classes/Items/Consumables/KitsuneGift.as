package classes.Items.Consumables
{
import classes.EngineCore;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

public final class KitsuneGift extends Consumable {
		
		public function KitsuneGift() {
			super("KitGift", "KitGift", "a kitsune's gift", 0, "A small square package given to you by a forest kitsune.  It is wrapped up in plain white paper and tied with a string.  Who knows what's inside?");
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("Curiosity gets the best of you, and you decide to open the package.  After all, what's the worst that could happen?\n\n");
			//Opening the gift randomly results in one of the following:
			switch (Utils.rand(16)) {
			//[Fox Jewel]
				case 0:
				case 12:
				case 13:
				case 14:
					outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and to your delight, sitting in the center is a small teardrop-shaped jewel!");
				outputText("\n\n<b>You've received a shining Fox Jewel from the kitsune's gift!  How generous!</b>  ");
				SceneLib.inventory.takeItem(game.consumables.FOXJEWL, SceneLib.inventory.inventoryMenu);
				return true;

			//[Fox Berries]
				case 1:
				case 15:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and to your delight, there is a small cluster of orange-colored berries sitting in the center!");
				outputText("\n\n<b>You've received a fox berry from the kitsune's gift!  How generous!</b>  ");
				//add Fox Berries to inventory
				SceneLib.inventory.takeItem(game.consumables.FOXBERY, SceneLib.inventory.inventoryMenu);
				return true;

			//[Gems]
				case 2:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and to your delight, it is filled to the brim with shining gems!");
				var gems:int = 20 + Utils.rand(10);
				outputText("\n\n<b>You've received " + Utils.num2Text(gems) + " shining gems from the kitsune's gift!  How generous!</b>");
				game.player.gems += gems;
				//add X gems to inventory
				EngineCore.statScreenRefresh();
				break;

			//[Kitsune Tea/Scholar's Tea] //Just use Scholar's Tea and drop the "trick" effect if you don't want to throw in another new item.
				case 3:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and to your delight, it contains a small bag of dried tea leaves!");
				outputText("\n\n<b>You've received a bag of tea from the kitsune's gift!  How thoughtful!</b>  ");
				//add Kitsune Tea/Scholar's Tea to inventory
				SceneLib.inventory.takeItem(game.consumables.SMART_T, SceneLib.inventory.inventoryMenu);
				return(true);

			//[Hair Dye]
				case 4:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and to your delight, it contains a small vial filled with hair dye!");
				var itype:Consumable = [
					game.consumables.RED_DYE,
					game.consumables.BLOND_D,
					game.consumables.BLACK_D,
					game.consumables.WHITEDY
				][Utils.rand(4)];

				outputText("\n\n<b>You've received " + itype.longName + " from the kitsune's gift!  How generous!</b>  ");
				//add <color> Dye to inventory
				SceneLib.inventory.takeItem(itype, SceneLib.inventory.inventoryMenu);
				return(true);

			//[Knowledge Spell]
				case 5:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, but it seems like there's nothing else inside.  As you peer into the box, a glowing circle filled with strange symbols suddenly flashes to life!  Light washes over you, and your mind is suddenly assaulted with new knowledge...  and the urge to use that knowledge for mischief!");

				outputText("\n\n<b>The kitsune has shared some of its knowledge with you!</b>  But in the process, you've gained some of the kitsune's promiscuous trickster nature...");
				//Increase INT and Libido, +10 LUST
				dynStats("lus", 50, "scale", false);
				player.addCurse("sen", 2, 1);
				player.KnowledgeBonus("int", 4);
				break;

			//[Thief!]
				case 6:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and sitting in the center is an artfully crafted paper doll.  Before your eyes, the doll springs to life, dancing about fancifully.  Without warning, it leaps into your item pouch, then hops away and gallivants into the woods, carting off a small fortune in gems.");

				outputText("\n\n<b>The kitsune's familiar has stolen your gems!</b>");
				// Lose X gems as though losing in battle to a kitsune
				var stolen:Number = 20 + Utils.rand(10);
				if (game.player.gems - stolen < 0) stolen = game.player.gems;
				game.player.gems -= stolen;
				EngineCore.statScreenRefresh();
				break;

			//[Prank]
				case 7:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and sitting in the center is an artfully crafted paper doll.  Before your eyes, the doll springs to life, dancing about fancifully.  Without warning, it pulls a large calligraphy brush from thin air and leaps up into your face, then hops away and gallavants off into the woods.  Touching your face experimentally, you come away with a fresh coat of black ink on your fingertips.");

				outputText("\n\n<b>The kitsune's familiar has drawn all over your face!</b>  The resilient marks take about an hour to completely scrub off in the nearby stream.  You could swear you heard some mirthful snickering among the trees while you were cleaning yourself off.");
				//Advance time 1 hour, -20 LUST
				dynStats("lus", -(player.maxLust() * 0.2), "scale", false);
				break;

			//[Aphrodisiac]
				case 8:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and sitting in the center is an artfully crafted paper doll.  Before your eyes, the doll springs to life, dancing about fancifully.  Without warning, it tosses a handful of sweet-smelling pink dust into your face, then hops over the rim of the box and gallavants off into the woods.  Before you know what has happened, you feel yourself growing hot and flushed, unable to keep your hands away from your groin.");
				outputText("\n\n<b>Oh no!  The kitsune's familiar has hit you with a powerful aphrodisiac!  You are debilitatingly aroused and can think of nothing other than masturbating.</b>");
				//+100 LUST
				dynStats("lus=", player.maxOverLust());
				break;

			//[Wither]
				case 9:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and sitting in the center is an artfully crafted paper doll.  Before your eyes, the doll springs to life, dancing about fancifully.  Without warning, it tosses a handful of sour-smelling orange powder into your face, then hops over the rim of the box and gallavants off into the woods.  Before you know what has happened, you feel the strength draining from your muscles, withering away before your eyes.");
				outputText("\n\n<b>Oh no!  The kitsune's familiar has hit you with a strength draining spell!  Hopefully, it's only temporary...</b>");
				player.addCurse("str", 5,2);
				player.addCurse("tou", 5,2);
				break;

			//[Dud]
				case 10:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, but to your disappointment, the only other contents appear to be nothing more than twigs, leaves, and other forest refuse.");
				outputText("\n\n<b>It seems the kitsune's gift was just a pile of useless junk!  What a ripoff!</b>");
				break;

			//[Dud...  Or is it?]
				case 11:
				outputText("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, but to your disappointment, the only other contents appear to be nothing more than twigs, leaves, and other forest refuse.  Upon further investigation, though, you find a shard of shiny black chitinous plating mixed in with the other useless junk.");
					outputText("\n\n<b>At least you managed to salvage a shard of black chitin from it...</b>  ");
				SceneLib.inventory.takeItem(game.useables.B_CHITN, SceneLib.inventory.inventoryMenu);
				return(true);

				default: trace("Kitsune's gift roll foobar...");
			}
			return(false); //Any other case does not have a sub-menu.
		}
	}
}
