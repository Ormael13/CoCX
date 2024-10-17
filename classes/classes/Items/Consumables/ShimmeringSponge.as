package classes.Items.Consumables {
import classes.AssClass;
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;
import classes.VaginaClass;

/**
 * Taken from unfinished Urta content and finally coded in.
 * Written by: CanadianSnas
 * @author Svalkash
 * */
public class ShimmeringSponge extends Consumable {
    public function ShimmeringSponge() {
        super("ShimSponge", "Shim.Sponge", "a shimmering sponge", 16, "");
    }

    //basically, SH workaround to get this shit earlier for me.
    override public function get description():String {
        var desc:String = "This spongy growth is bright yellow, shaped like a rectangle. Every time you touch it, the [skin] on your hands feels drier."
        if (EngineCore.silly()) desc += "You swear, every so often, you can hear faint laughter, like \"<i>Dalhahahaha!</i>\" Inside your head. You get the vague feeling that this sponge should have pants.";
        return desc + super.description;
    }

    override public function useItem():Boolean {
        clearOutput();
        outputText("You remove your [armor] and undergarments, looking down at your body. Which part do you want to use the sponge on?\n\n");
        EngineCore.menu();
        EngineCore.addButton(0, "Ass", useAss)
            .disableIf(player.ass.analWetness == AssClass.WETNESS_DRY, "It's completely dry!");
        if (player.hasVagina()) EngineCore.addButton(1, "Pussy", usePussy)
            .disableIf(player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY, "It's completely dry!");
        if (player.hasBalls()) EngineCore.addButton(2, "Balls", useBalls)
            .disableIf(player.cumMultiplier == 1, "Your production is at its minimum.\n<b>If it's still too high, please report this on Discord and I'll make it better.\n\n-Svalkash</b>");
        if (player.hasBreasts()) EngineCore.addButton(3, "Breasts", useBreasts)
            .disableIf(player.biggestLactation() == 0, "You don't lactate at all!");
		EngineCore.addButton(4, "Never mind", shimspongeCancel);
        return true;

        //==============================================================================================================

        function useAss():void {
            outputText("You decide that your ass could use a clean. Bringing the sponge to your ass, you begin to wipe. The yellow sponge seems to pull moisture from your [ass], and after a minute or so, you pull it away.\n");
            --player.ass.analWetness;
            if (player.ass.analWetness == AssClass.WETNESS_DRY) outputText("<b>Your ass is no longer lubricated.</b>");
            else outputText("<b>Your ass feels drier than before.</b>");
            SceneLib.inventory.itemGoNext();
        }

        function usePussy():void {
            outputText("You decide to rub your pussy with the sponge. As you bring the bright yellow to your [pussy], you feel a slight pull. As you make contact, the shimmering sponge clings slightly to your labia, and with each pull, you feel your fluid being sucked into the thing. You groan, the draining feeling... odd, and not particularly pleasant. After a few rubs, you pull the sponge away.\n"
                + "<b>Bringing your hand to your muff, you realise that not only is it drier, your pussy isn’t replacing the moisture as fast as before!</b>");
            --player.vaginas[0].vaginalWetness;
            if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) outputText("<b>Your pussy is completely dry!</b>\n");
            SceneLib.inventory.itemGoNext();
        }

        function useBalls():void {
            outputText("You decide that your [balls] could use some attention. As you bring the sponge to your sacks, the sponge moves, wrapping itself around your testes. Groaning, you can feel your balls getting smaller, the fluid somehow going straight through your skin and into the sponge. After a minute or so, you bring the sponge back.\n"
                + "<b>Your balls have shrunk noticeably, and you can feel that they’re not getting heavier as quickly as before.</b>");
            if (player.cumMultiplier >= 4) player.cumMultiplier *= 0.75;
            else player.cumMultiplier -= 1;
            if (player.cumMultiplier < 1) player.cumMultiplier = 1;
            if (player.cumMultiplier == 1) outputText("\n<b>You don't think you can reduce your cum production further.</b>");
            SceneLib.inventory.itemGoNext();
        }

        function useBreasts():void {
            outputText("You decide that your [breasts] need some attention from the sponge. You begin slowly rubbing your nipples, making them stand up. You moan, bringing the sponge to one nipple, moaning as your milk begins to flow into the yellow material. You switch breasts, the sponge pulling the milk from you with increasing force. As the sensation begins to become painful, you pull the sponge away, massaging your aching breasts.\n"
                + "<b>You feel lighter, and your lactation has slowed substantially.</b>");
            player.boostLactation(-1, true);
            SceneLib.inventory.itemGoNext();
        }
    }

	private function shimspongeCancel():void {
		clearOutput();
		outputText("You put the sponge away.\n\n");
		SceneLib.inventory.returnItemToInventory(this);
	}
}
}
