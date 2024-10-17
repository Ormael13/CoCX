package classes.Items.Consumables
{
import classes.AssClass;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumable;
import classes.PerkLib;
import classes.StatusEffects;
import classes.VaginaClass;

/**
	 * Lower lust significantly but has a chance of inducing the masturbation preventing effect from minotaur.
	 */
	public class NumbRocks extends Consumable
	{
		private static const ITEM_VALUE:int = 15;
		
		public function NumbRocks()
		{
			super("NumbRox","Numb Rox", "a strange packet of candy called 'Numb Rocks'", ITEM_VALUE, "This packet of innocuous looking 'candy' guarantees to reduce troublesome sensations and taste delicious.");
			refineableInto([], [], [[1, AlchemyLib.AR_SENS_DEC]]);
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
            //effects: stop heat, stop rut, dysfunction, int curse, thick skin perk, ass looseness, vag looseness.
            var choices:Array = [];
            //effects: heat, rut, anal, vag looseness
            if (player.inRut) choices.push(1);
            if (player.inHeat) choices.push(2);
            if (player.hasVagina() && player.vaginas[0].vaginalLooseness > VaginaClass.LOOSENESS_TIGHT) choices.push(3);
            if (player.ass.analLooseness > AssClass.LOOSENESS_VIRGIN) choices.push(4);
            if (!player.hasPerk(PerkLib.ThickSkin)) choices.push(7);
            if (rand(2) == 0) choices.push(5);
            else if (rand(2) == 0) choices.push(6); //add one debuff to the pool
            else choices.push(0); //no effects

            switch(choices[rand(choices.length)]) {
                case 1:
					outputText("  The numbing sensations not only affect your skin, but help you clean up your mind.  <b>Your rut has finally ended.</b>");
                    player.removeStatusEffect(StatusEffects.Rut);
                    break;
                case 2:
					outputText("  After some time, you notice that you don't constantly think about being impregnated anymore.  You feel at peace realising that <b>your heat has ended.</b>");
                    player.removeStatusEffect(StatusEffects.Heat);
                    break;
                case 3:
                    --player.vaginas[0].vaginalLooseness;
                    outputText("  After your feelings return to you, you notice that your vagina feels a bit tense. After trying to put your finger inside, you are sure - <b>your pussy has become tighter</b>!");
                    break;
                case 4:
                    --player.ass.analLooseness;
                    outputText("  The feeling lasts pretty long, and at some point your entire [butt] feels numb and tickling. ");
                    if (player.ass.analLooseness == AssClass.LOOSENESS_VIRGIN) outputText("You marvel at the odd feeling - <b>your [asshole] is as tight as if it has never been penetrated!</b>!");
                    else outputText("Touching it experimentally, you try to slip a finger inside and find out that <b>your [asshole] is tighter than before!</b>!");
                    break;
                case 5:
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
                        outputText("\n\nSadly, your groin becomes even more deadened to sensation.  You wonder how much longer you'll have to wait until you can please yourself again.");
                        player.addStatusValue(StatusEffects.Dysfunction, 1, 50 + rand(100));
                    }
                    break;
                case 6:
                    outputText("\n\nNumbness clouds your mind, making you feel slow witted and dull.  Maybe these candies weren't such a exceptio... fantas... good idea.");
                    player.addCurse("int", (1 + rand(5)),1);
                    break;
                case 7:
                    outputText("Slowly, ");
                    if (!player.hasCoat()) outputText("your [skin base]");
                    else outputText("the skin under your [skin coat]");
                    outputText(" begins to feel duller, almost... thicker.  You pinch yourself and find that your epidermis feels more resistant to damage, almost like natural armor!\n<b>(Thick Skin - Perk Gained!)</b>");
                    player.createPerk(PerkLib.ThickSkin, 0, 0, 0, 0);
                    break;
                default:
                    dynStats("lus-", 20, "scale", true); //MOAR
                    break;
            }
			outputText("\n\nAfter the sensations pass, your [skin.type] feels a little less receptive to touch.");
			player.removeCurse("sens", 5, 1);
			player.refillHunger(20);
			return false;
		}
	}
}
