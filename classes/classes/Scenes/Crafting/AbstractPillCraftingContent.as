package classes.Scenes.Crafting {
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Alchemy.AlchemyReagent;
import classes.Scenes.Crafting;
import classes.Scenes.SceneLib;
import classes.internals.EnumValue;

public class AbstractPillCraftingContent extends BaseContent {
	// Runtime state variables - not saved, must be cleared when you leave the scene
	protected var furnaceStones:int = 0;
	
	public function AbstractPillCraftingContent() {
	}
	protected function get crafting():Crafting {
		return SceneLib.crafting;
	}
	public function furnaceName():String {
		return crafting.alchemyFurnaceObject().name;
	}
	protected function furnaceObject():EnumValue {
		return crafting.alchemyFurnaceObject();
	}
	protected function stoneSafeLimit():int {
		return SceneLib.crafting.alchemyFurnaceStoneSafeLimit();
	}
	protected function stoneLimit():int {
		return 20
	}
	public function craftingMenu():void {
		// implement in subclass
	}
	
	protected function calcPillChances():/*Number*/Array {
		var result:/*Number*/Array = furnaceObject().refineChances.slice();
		normalizeArray(result, 100);
		// +25% to raise a level per spirit stone
		var raiseChance:Number = 0.25;
		raiseChance += 0.005 * player.alchemySkillLevel;
		for (var i:int = 0; i < furnaceStones; i++) {
			result = [
				/*                     */ result[0] * (1 - raiseChance),
				result[0] * raiseChance + result[1] * (1 - raiseChance),
				result[1] * raiseChance + result[2] * (1 - raiseChance),
				result[2] * raiseChance + result[3] * (1 - raiseChance),
				result[3] * raiseChance + result[4] * (1 - raiseChance),
				result[4] * raiseChance + result[5]
			];
		}
		// +20 chance to explode per extra SS
		if (furnaceStones > stoneSafeLimit()) result[0] += 20 * (furnaceStones - stoneSafeLimit());
		return normalizeArray(result, 100);
	}
	
	protected function printRefinementChances():void{
		outputText("\n<b>Refinement chances</b>:");
		outputText("<ul>");
		var chances:Array = calcPillChances();
		for (var i:int = 0; i < chances.length; i++) {
			if (chances[i] <= 0) continue;
			outputText("<li>");
			if (i == 0) outputText("<b>Explosion</b>");
			else outputText(capitalizeFirstLetter(AlchemyLib.PillPowerTiers[i].name + " pill"));
			outputText(": " + floor(chances[i]) + "%");
			outputText("</li>");
		}
		outputText("</ul>");
		if (furnaceStones == stoneLimit()) {
			outputText("\n\nYou can't fit more spirit stones in the furnace!");
			if (silly()) outputText(" The pile emits an eerie blue glow and you hear a chaotic, intermittent clicking noise.");
		}
	}

	protected function setAddSSButton(btn:int):void {
		button(btn).show("Add S.Stone", addSpiritStoneToFurnace)
				 .hint("Put spirit stone into furnace to improve the pill quality.\n\nShift+click to add maximum.")
				 .disableIf(flags[kFLAGS.SPIRIT_STONES] <= 0)
				 .disableIf(furnaceStones >= stoneLimit());
	}
	protected function setTakeSSButton(btn:int):void {
		button(btn).show("Take S.Stone", takeSpiritStoneFromFurnace)
				 .hint("Take spirit stone from.\n\nShift+click to take all.")
				 .disableIf(furnaceStones == 0);
	}
	protected function printStonesInFurnace():void {
		outputText("\n<b>Spirit Stones</b>: " + furnaceStones + "/" + stoneSafeLimit() + ". ");
		if (silly() && furnaceStones == stoneLimit()) {
			outputText("<b>WARNING: Prepare for unforeseen consequences. </b>");
		} else if (furnaceStones == stoneSafeLimit()) {
			outputText("This is maximum safe value.")
		} else if (furnaceStones > stoneSafeLimit()) {
			outputText("<b>WARNING: Too many spirit stones. </b>")
		}
	}
	
	protected function addSpiritStoneToFurnace():void {
		var n:int = 1;
		if (shiftKeyDown) {
			n = Math.min(flags[kFLAGS.SPIRIT_STONES], stoneSafeLimit());
		}
		flags[kFLAGS.SPIRIT_STONES] -= n;
		furnaceStones += n;
		statScreenRefresh();
		craftingMenu();
	}
	
	protected function takeSpiritStoneFromFurnace():void {
		var n:int = shiftKeyDown ? furnaceStones : 1;
		flags[kFLAGS.SPIRIT_STONES] += n;
		furnaceStones -= n;
		statScreenRefresh();
		craftingMenu();
	}
	protected function cleanTheFurnace():void {
		
		if (furnaceStones > 0) {
			outputText("\nYou take " + numberOfThings(furnaceStones, "spirit stone", "spirit stones") + " out and store them back in your pocket.")
			flags[kFLAGS.SPIRIT_STONES] += furnaceStones;
			furnaceStones = 0;
		}
		
		statScreenRefresh();
		doNext(craftingMenu);
	}
}
}
