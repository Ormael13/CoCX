package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	import classes.PerkLib;
	import classes.StatusEffects;
	
	/**
	 * Lower lust significantly but has a chance of inducing the masturbation preventing effect from minotaur.
	 */
	public class NumbRocks extends Consumable 
	{
		private static const ITEM_VALUE:int = 15;
		
		public function NumbRocks() 
		{
			super("NumbRox","Numb Rox", "a strange packet of candy called 'Numb Rocks'", ITEM_VALUE, "This packet of innocuous looking 'candy' guarantees to reduce troublesome sensations and taste delicious.");
		}
		
		override public function useItem():Boolean
		{
			clearOutput();
			//Numb rocks lower lust significantly but have a chance of inducing the masturbation preventing effect from minotaur.
			outputText("You pop open the package of numb rocks and dump it into your waiting mouth.  The strange candy fizzes and pops, leaving the nerves on your tongue feeling a bit deadened as you swallow the sweet mess.");
			if (player.lust >= 33) {
				outputText("\n\nThe numbness spreads through your body, bringing with it a sense of calm that seems to muffle your sexual urges.");
				player.lust -= 20 + rand(40);
			}
			if (rand(5) == 0) {
				if (!player.hasStatusEffect(StatusEffects.Dysfunction)) {
					outputText("\n\nUnfortunately, the skin of ");
					if (player.cockTotal() > 0) {
						outputText(player.sMultiCockDesc());
						if (player.hasVagina()) outputText(" and");
						outputText(" ");
					}
					if (player.hasVagina()) {
						if (!player.hasCock()) outputText("your ");
						outputText(player.vaginaDescript(0) + " ");
					}
					if (!(player.hasCock() || player.hasVagina())) outputText(player.assholeDescript() + " ");
					outputText(" numbs up too.  You give yourself a gentle touch, but are quite disturbed when you realize you can barely feel it.  You can probably still fuck something to get off, but regular masturbation is out of the question...");
					player.createStatusEffect(StatusEffects.Dysfunction, 50 + rand(100), 0, 0, 0);
				}
				else {
					outputText("\n\nSadly your groin becomes even more deadened to sensation.  You wonder how much longer you'll have to wait until you can please yourself again.");
					player.addStatusValue(StatusEffects.Dysfunction, 1, 50 + rand(100));
				}
			}
			else if (rand(4) == 0 && player.inte > 15) {
				outputText("\n\nNumbness clouds your mind, making you feel slow witted and dull.  Maybe these candies weren't such a exceptio... fantas... good idea.");
				player.addCurse("int", (1 + rand(5)),1);
			}
			if (!player.hasPerk(PerkLib.ThickSkin) && rand(5) == 0) {
				outputText("Slowly, ");
				if (!player.hasCoat()) outputText("your [skin base]");
				else outputText("the skin under your [skin coat]");
				outputText(" begins to feel duller, almost... thicker.  You pinch yourself and find that your epidermis feels more resistant to damage, almost like natural armor!\n<b>(Thick Skin - Perk Gained!)</b>");
				player.createPerk(PerkLib.ThickSkin, 0, 0, 0, 0);
			}
			outputText("\n\nAfter the sensations pass, your [skin.type] feels a little less receptive to touch.");
			player.removeCurse("sens", 5);
			player.refillHunger(20);
			
			return false;
		}
	}
}