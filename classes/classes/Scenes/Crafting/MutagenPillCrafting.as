package classes.Scenes.Crafting {
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.ItemType;
import classes.Items.Alchemy.AlchemyLib;
import classes.Scenes.Crafting;
import classes.Scenes.SceneLib;
import classes.Transformations.PossibleEffect;
import classes.Transformations.Transformation;
import classes.internals.EnumValue;

public class MutagenPillCrafting extends BaseContent {
	public function get furnaceLevel():int {
		return Crafting.furnaceLevel;
	}
	
	public function MutagenPillCrafting() {
	}
	public function furnaceName():String {
		return furnaceObject().name;
	}
	public function furnaceObject():EnumValue {
		return Crafting.FURNACE_LEVELS[furnaceLevel];
	}
	
	// Runtime state variables - not saved, must be cleared when you leave the scene
	private var furnaceSubstance:int = AlchemyLib.AE_NONE;
	private var furnaceEssence:int   = AlchemyLib.AS_NONE;
	private var furnaceStones:int    = 0;
	
	private function stoneSafeLimit():int {
		return furnaceObject().stoneLimit
	}
	private function stoneLimit():int {
		return 20
	}
	private function calcMutagenPillChances():/*Number*/Array {
		var result:Array = furnaceObject().refineChances.slice();
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
		// +20 chance to explore per extra SS
		if (furnaceStones > stoneSafeLimit()) result[0] += 20 * (furnaceStones - stoneSafeLimit());
		return normalizeArray(result, 100);
	}
	
	public function pillCraftingMenu():void {
		clearOutput();
		
		outputText("<b>Tool quality</b>: " + furnaceName());
		outputText("\n<b>Substance</b>: " + (furnaceSubstance ? AlchemyLib.Substances[furnaceSubstance].name : "<i>none</i>"));
		outputText("\n<b>Essence</b>: " + (furnaceEssence ? AlchemyLib.Essences[furnaceEssence].name : "<i>none</i>"));
		outputText("\n<b>Spirit Stones</b>: " + furnaceStones + "/" + stoneSafeLimit() + ". ");
		if (silly() && furnaceStones == stoneLimit()) {
			outputText("<b>WARNING: Prepare for unforeseen consequences. </b>");
		} else if (furnaceStones == stoneSafeLimit()) {
			outputText("This is maximum safe value.")
		} else if (furnaceStones > stoneSafeLimit()) {
			outputText("<b>WARNING: Too many spirit stones. </b>")
		}
		outputText("\n<b>Skill</b>: " + player.alchemySkillLevel);
		outputText("\n<b>Refinement chances</b>:");
		outputText("<ul>");
		var chances:Array = calcMutagenPillChances();
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
			outputText("\nYou can't fit more spirit stones in the furnace!");
			if (silly()) outputText(" The pile emits an eerie blue glow and you hear a chaotic, intermittent clicking noise.");
		}
		if (debug) {
			var tf:PossibleEffect = Transformation.findSETf(furnaceSubstance, furnaceEssence);
			if (tf) {
				outputText("\n<i>Result</i>: "+tf.alchemyLongName);
			} else {
				outputText("\n<i>Impossible combination!</i>")
			}
		}
		
		// [ Refine!] [Substanc] [Essence ] [        ] [        ]
		// [Add SS  ] [Take SS ] [        ] [        ] [        ]
		// [        ] [        ] [        ] [ Clean  ] [ Back   ]
		menu();
		button(0).show("Refine!", doRefinePill)
				 .hint("Refine the pill.")
				 .disableIf(furnaceSubstance == 0, "Select an alchemical substance.")
				 .disableIf(furnaceEssence == 0, "Select an alchemical essence.")
		button(1).show("Substance", curry(selectComponent, AlchemyLib.CT_SUBSTANCE));
		button(2).show("Essence", curry(selectComponent, AlchemyLib.CT_ESSENCE));
		button(5).show("Add S.Stone", addSpiritStone)
				 .hint("Put spirit stone into furnace to improve the pill quality.\n\nShift+click to add maximum.")
				 .disableIf(flags[kFLAGS.SPIRIT_STONES] <= 0)
				 .disableIf(furnaceStones >= stoneLimit());
		button(6).show("Take S.Stone", takeSpiritStone)
				 .hint("Take spirit stone from.\n\nShift+click to take all.")
				 .disableIf(furnaceStones == 0);
		button(13).show("Cancel", cleanTheFurnace)
				  .hint("Cancel refinement and take back the resources.")
				  .disableIf(furnaceSubstance == 0 && furnaceEssence == 0 && furnaceStones == 0);
		button(14).show("Back", SceneLib.crafting.craftingMain)
				  .icon("Back")
				  .disableIf(furnaceSubstance > 0 || furnaceEssence != 0 || furnaceStones != 0,
						  "Empty the furnace first!");
	}
	private function selectComponent(type:int):void {
		clearOutput();
		mainView.linkHandler = function (event:String):void {
			if (type == AlchemyLib.CT_SUBSTANCE) {
				furnaceSubstance = int(event);
				SceneLib.crafting.addSubstance(furnaceSubstance, -1);
			} else if (type == AlchemyLib.CT_ESSENCE) {
				furnaceEssence = int(event);
				SceneLib.crafting.addEssence(furnaceEssence, -1);
			}
			pillCraftingMenu();
		}
		if (type == AlchemyLib.CT_SUBSTANCE) {
			outputText("<b>Alchemical substances</b>:");
		} else if (type == AlchemyLib.CT_ESSENCE) {
			outputText("<b>Alchemical essences</b>:");
		}
		var list:Array = SceneLib.crafting.listAlchemyComponents(type);
		if (list.length == 0) {
			outputText("\nYou don't have any! Refine ingredients in the alembic.");
		} else {
			outputText("<ul>");
			for each (var element:Array in list) {
				outputText("<li>");
				outputText(mkLink(element[2] + " (" + element[1] + ")", String(element[3])));
				outputText("</li>")
			}
			outputText("</ul>");
		}
		
		menu();
		button(14).show("Back", pillCraftingMenu).icon("Back");
	}
	private function doRefinePill():void {
		clearOutput();
		
		outputText("The soulforce-powered furnace roars and dissolves the ingredients into tiny particles. They circle in complicated orbits, intertwine and recombine in seemingly chaotic ways until forming a turbulent cloud. ");
		if (furnaceStones > 0) {
			outputText("The " + (furnaceStones > 1 ? "spirit stones" : "spirit stone") + " crumble and release the soulforce, fueling the process and empowering the mixture. ");
		}
		var chances:/*Number*/Array = calcMutagenPillChances();
		var pillPower:int;
		if (SceneLib.crafting.isLuckyXianxiaMC()) {
			SceneLib.crafting.useXianxiaMCLuck();
			pillPower = AlchemyLib.PP_RADIANT;
		} else {
			pillPower = weightedRandom([
				[chances[0], 0],
				[chances[1], 1],
				[chances[2], 2],
				[chances[3], 3],
				[chances[4], 4],
				[chances[5], 5]
			]);
		}
		outputText("[pg]");
		if (pillPower == 0) {
			outputText("The cloud slows down then suddenly <b>collapses in violent implosion</b>, covering the area in smoke and soot. Unfortunately, the refining had failed.");
			outputText("\n\nCleaning this mess would take some time...");
			furnaceSubstance = 0;
			furnaceEssence   = 0;
			furnaceStones    = 0;
			player.giveAlchemyXP(AlchemyLib.PillPowerTiers[0].xp);
			doNext(camp.returnToCampUseOneHour);
		} else {
			// TODO @aimozg can craft multiple, depending on skill or other factors
			var npills:int = 1;
			outputText("The whirling cloud slows down, then shrinks into " +
					numberOfThings(npills, "cherry-sized orb", "cherry-sized orbs") +
					" at the bottom of the furnace.\n\n");
			if (Transformation.findSETf(furnaceSubstance, furnaceEssence)) {
				var pill:ItemType = itemTemplates.createMutagenPill(furnaceSubstance, furnaceEssence, pillPower);
				furnaceSubstance  = 0;
				furnaceEssence    = 0;
				furnaceStones     = 0;
				outputText("<b>You've successfully refined " + (npills > 1 ? npills + " x " : "a ") + pill.longNameBase + "!</b>");
				// TODO @aimozg support transfering multiple items
				player.giveAlchemyXP(AlchemyLib.PillPowerTiers[pillPower].xp);
				inventory.takeItem(pill, pillCraftingMenu);
			} else {
				outputText("However, " + (npills > 1 ? "they crumble" : "it crumbles") + " into gray dust due to incompatibility. <b>It seems that you can't refine " +
						AlchemyLib.Essences[furnaceEssence].name +
						" essence with " +
						AlchemyLib.Substances[furnaceSubstance].name + " substance!</b>");
				furnaceSubstance = 0;
				furnaceEssence   = 0;
				furnaceStones    = 0;
				player.giveAlchemyXP(AlchemyLib.PillPowerTiers[0].xp);
				doNext(pillCraftingMenu);
			}
		}
	}
	private function addSpiritStone():void {
		var n:int = 1;
		if (shiftKeyDown) {
			n = Math.min(flags[kFLAGS.SPIRIT_STONES], stoneSafeLimit());
		}
		flags[kFLAGS.SPIRIT_STONES] -= n;
		furnaceStones += n;
		statScreenRefresh();
		pillCraftingMenu();
	}
	private function takeSpiritStone():void {
		var n:int = shiftKeyDown ? furnaceStones : 1;
		flags[kFLAGS.SPIRIT_STONES] += n;
		furnaceStones -= n;
		statScreenRefresh();
		pillCraftingMenu();
	}
	private function cleanTheFurnace():void {
		if (furnaceStones > 0) {
			outputText("\nYou take " + numberOfThings(furnaceStones, "spirit stone", "spirit stones") + " out and store them back in your pocket.")
			flags[kFLAGS.SPIRIT_STONES] += furnaceStones;
			furnaceStones = 0;
		}
		if (furnaceSubstance != 0) {
			outputText("\nYou carefully collect the " + AlchemyLib.Substances[furnaceSubstance].name + " substance and put it back in into your alchemical storage.");
			SceneLib.crafting.addSubstance(furnaceSubstance);
			furnaceSubstance = 0;
		}
		if (furnaceEssence != 0) {
			outputText("\nYou carefully collect the " + AlchemyLib.Essences[furnaceEssence].name + " essence and put it back in into your alchemical storage.");
			SceneLib.crafting.addEssence(furnaceEssence);
			furnaceEssence = 0;
		}
		statScreenRefresh();
		doNext(pillCraftingMenu);
	}
	
}
}
