package classes.Scenes {
import classes.*;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Scenes.Dungeons.DungeonAbstractContent;
import classes.Scenes.NPCs.JojoScene;
import classes.display.SpriteDb;

import coc.view.CoCButton;

public class Masturbation extends BaseContent {
		public static function canMeditate():Boolean {
			var religious:Boolean = (player.hasPerk(PerkLib.HistoryReligious) || player.hasPerk(PerkLib.PastLifeReligious))
				&& player.cor <= 66 + player.corruptionTolerance;
			var enlightened:Boolean = player.hasPerk(PerkLib.Enlightened)
				&& player.cor <= 10 + player.corruptionTolerance;
			return (religious || enlightened) /*&& !SceneLib.exgartuan.anyAwake()*/; //Exgartuan handled separately
		}

		public function masturButton(pos:int):CoCButton {
			if (inDungeon || inRoomedDungeon || explorer.isActive) return addButton(pos, "Masturbate", masturbateGo)
				.hint("Attempt to masturbate in order to relieve your lust buildup.")
				.disableIf(player.lust < 33, "You're not horny enough to masturbate.");
			else if (canMeditate() && player.lust < 33) return addButton(pos, "Meditate", meditate)
				.hint("Meditate in order to reduce lust and corruption.")
				.disableIf(SceneLib.exgartuan.anyAwake(), "Your inner demon won't let you concentrate right now.");
			else return addButton(pos, "Masturbate", masturbateMenu)
				.hint("Attempt to manually masturbate in order to relieve your lust buildup."
					+ (canMeditate() ? "  You can also try to meditate instead of masturbating." : ""))
				.disableIf(player.lust < 33, "You're not horny enough to masturbate.");
		}

		private function masturGasm(...args):void {
			if (args.length == 0) {
				if (player.hasCock()) args.push("Dick");
				if (player.hasVagina()) args.push("Vaginal");
			}
			var i:int;
			if (player.hasPerk(PerkLib.ElectrifiedDesire) || player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
				player.orgasmRaijuStyle();
				for (i = 0; i < args.length; ++i)
					if (args[i] is String) player.orgasmRaijuStyle(args[i]);
				dynStats("sen", 0.5);
			}
			else {
				for (i = 0; i < args.length; ++i)
					if (args[i] is String) player.orgasm(args[i]);
				dynStats("sen", -0.5);
			}
		}

		public function masturbateMenu():void {
			menu();
			if (player.hasCock() && (player.cocks[0].cockType == CockTypesEnum.BEE)) {
				clearOutput();
				outputText("Although your bee cock aches, you know that there's no way for you to get relief on your own.  When you touch your shaft or think about cumming images of the bee girl and the sound of her hypnotic buzzing fill your mind.");
				addButton(14, "Back", playerMenu);
				if (player.hasItem(consumables.BEEHONY) || player.hasItem(consumables.PURHONY) || player.hasItem(consumables.SPHONEY)) {
					outputText("\n\nFortunately, you could smear honey all over your [cock] and relieve yourself if you want to.");
					addButton(0, "Use Honey", masturbateGo);
				}
				else {
					outputText("\n\nPehaps, if you had some honey, you could use it to relieve your needs?");
					addButtonDisabled(1, "Use Honey", "Requires any honey.");
				}
				if (canMeditate()) {
					outputText("\n\nYou still can meditate to cleanse your urges.");
					addButton(10, "Meditate", meditate)
						.disableIf(SceneLib.exgartuan.anyAwake(), "Your inner demon won't let you concentrate right now.");
				}
				return;
			}
			else sceneHunter.print("Check failed: bee-cock.");
			//normal menu
			menu();
			if (canMeditate()) addButton(10, "Meditate", meditate)
				.disableIf(SceneLib.exgartuan.anyAwake(), "Your inner demon won't let you concentrate right now.");
			addButton(0, "Masturbate", masturbateGo);
			addButton(1, "Special", specialOptions).hint("Try to think of something special... if your body allows you to, of course.");
			addButton(2, "Items", fappingItems).hint("Pleasure yourself with special items.");
			addButton(14, "Back", playerMenu);
		}

		private function specialOptions(page:int = 1):void {
			sceneHunter.print("Many scenes are repeatable. Use it.");
			menu();
			if (page == 1) {
				addButton(0, "Lick Cock", catAutoLick)
					.disableIf(!player.hasPerk(PerkLib.Flexibility) && flags[kFLAGS.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY] == 0,"<b>You're not flexible enough to try this.</b>" +
						"\n\nRequires 'Flexibility' (cat-morph) perk.")
					.disableIf(!player.hasCock(), "You can't suck lick cock without having one.");
				addButton(1, "Lick Pussy", lickYerGirlParts)
					.disableIf(!player.hasPerk(PerkLib.Flexibility) && flags[kFLAGS.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY] == 0,"<b>You're not flexible enough to try this.</b>" +
						"\n\nRequires 'Flexibility' (cat-morph) perk.")
					.disableIf(!player.hasVagina(), "You can't lick your vagina without having one.");
				addButton(2, "EggsInCock", getHugeEggsInCawk)
					.disableIf(player.findCock(1, 100, -1) < 0,
						"Req. a cock with area larger than 100")
					.disableIf(!player.canOvipositBee(), "Req. a bee ovipositor.");
				addButton(3, "EggsInTits", layEggsInYerTits)
					.disableIf(player.biggestTitSize() < 21, "You would need bigger tits for this.")
					.disableIf(!player.canOviposit(), "Req. an ovipositor.");
				addButton(4, "TentacleFun", tentacleSelfFuck2)
					.hint("Fuck yourself with your tentacle limbs!")
					.disableIf(!player.hasVagina(), "You need a vagina to 'have fun' with.")
					.disableIf(!player.isScylla() && !player.isKraken(), "Requires to have Scylla or Kraken lower body.");
				//TODO: make sure stamens also work!
				//TODO: stamens are copypasted... right?
				addButton(5, "TentInPussy", tentacleSelfFuck)
					.hint("Fuck your pussy with your tentacle cocks!")
					.disableIf(!player.hasVagina(), "You would need a pussy first.")
					.disableIf(player.countCocksWithType(CockTypesEnum.TENTACLE) == 0, "Req. tentacle cocks");
				addButton(6, "TentInButt", tentacleGoesUpYerPooperNewsAtEleven)
					.hint("Fuck your ass with your tentacle dicks!")
					.disableIf(player.countCocksWithType(CockTypesEnum.TENTACLE) == 0, "Req. tentacle cocks");
				addButton(13, "-2-", specialOptions, page + 1);
				addButton(14, "Back", masturbateMenu);
			}
			if (page == 2) {
				addButton(0, "LayBunnyEggs", EasterBunnyLayEggs)
					.disableIf(player.ballSize <= 3, "Your balls are too small for this.")
					.disableIf(player.balls < 2, "You would need at least two balls.")
					.disableIf(!player.hasCock(), "You also need a cock.")
					.disableIf(!player.hasPerk(PerkLib.EasterBunnyBalls), "Requires to have Easter Bunny balls.");
				addButton(1, "StamenPussy", stamenSelfFuck)
					.hint("Fuck your pussy with your stamens!")
					.disableIf(!player.hasVagina(), "You would need a vagina first.")
					.disableIf(player.countCocksWithType(CockTypesEnum.STAMEN) == 0, "Req. stamen cocks")
					.disableIf(!player.isAlraune(), "Req. to be an Alraune.");
				addButton(2, "StamenButt", stamenGoesUpYerPooperNewsAtEleven)
					.hint("Fuck your ass with your stamens!")
					.disableIf(player.countCocksWithType(CockTypesEnum.STAMEN) == 0, "Req. stamen cocks")
					.disableIf(!player.isAlraune(), "Req. to be an Alraune.");
				addButton(3, "TwinYuri", twinYuri)
					.hint("Fuck your vagina with your stamens!")
					.disableIf(!player.hasVagina(), "You would need a vagina first.")
					.disableIf(!player.isLiliraune(), "Req. to be a Liliraune.");
				addButton(4, "Impregnator", gobomechImpregnator1)
					.disableIf(player.keyItemvX("Cum Reservoir", 1) != 4, "Your cum reservoir is not full yet!")
					.disableIf(!player.isInGoblinMech(), "You need to be inside a goblin mech for this!")
					.disableIf(!player.hasVagina(), "First of all, you need a vagina.");
				addButton(5, "Fuck Machine", gobomechFuckingMachine)
					.disableIf(player.keyItemvX("Cum Reservoir", 1) != 4, "Your cum reservoir is not full yet!")
					.disableIf(!player.isInGoblinMech(), "You need to be inside a goblin mech for this!")
					.disableIf(!player.hasVagina(), "First of all, you need a vagina.");
				addButton(6, "Goo Sat", gooeySatisfaction)
					.hint("Play with your malleable body in a new way.", "Gooey Satisfaction")
					.disableIf(!player.isGoo(), "Req. goo body.");
				addButton(7, "Mummy Sex", mummySex)
					.disableIf(player.gender == 0, "Req. to not be genderless.")
					.disableIf(player.soulforce < Math.round(player.maxSoulforce() * 0.5), "Req. 50% of max soulforce.")
					.disableIf(player.racialScore(Races.ANUBIS) < 15, "Req. to be Anubi race.")
					.disableIf(player.perkv2(PerkLib.MummyLord) > 0, "Last mummy sex effect not yet wear off.")
					.disableIf((player.hasPerk(PerkLib.MummyLord) && player.perkv1(PerkLib.MummyLord) < 3), "Req. to have 3+ mummies.");
				addButton(13, "-1-", specialOptions, page - 1);
				addButton(14, "Back", masturbateMenu);
			}
		}

		private function fappingItems():void {
			var b:int; //for iteration
			function addKAbutton(btn:int, btnText:String, keyItem:String, fun:Function):CoCButton {
				return addButton(btn, btnText, fun).hint("", keyItem);
			}

			menu();
			//cock options
			addKAbutton(0, "Onahole", "Plain Onahole", onaholeUse);
			addKAbutton(5, "AN Onahole", "All-Natural Onahole", allNaturalOnaholeUse);
			addKAbutton(10, "D Onahole", "Deluxe Onahole", deluxeOnaholeUse);
			for (b = 0; b < 3; ++b) button(0 + b*5) //for dildos
				.disableIf(player.isTaur() && player.longestCockLength() < player.tallness * 5/6,
					"You can't reach your cock with your hands. Either change your lower body or grow a bigger dick.")
				.disableIf(!player.hasCock(), "Req. a cock!");
			//dildos
			addKAbutton(1, "Dildo (Vag)", "Dildo", stickADildoInYourVagooSlut)
				.disableIf(!player.hasVagina(), "Req. a vagina.");
			addKAbutton(6, "Dildo (Ass)", "Dildo", dildoButts);
			addKAbutton(11, "D. Dildo", "Deluxe Dildo", deluxeDildo)
				.disableIf(player.isTaur(), "")
				.disableIf(!player.hasVagina(), "Req. a vagina.");
			for (b = 0; b < 3; ++b) button(1 + b*5) //for belts
				.disableIf(player.isTaur(), "You can't reach your lower bits with your current body!");
			//belts
			addKAbutton(2, "Stim-Belt", "Self-Stimulation Belt", stimBeltUse);
			addKAbutton(7, "AN Stim-Belt", "All-Natural Self-Stimulation Belt", allNaturalStimBeltUse);
			addKAbutton(12, "Dual Belt", "Dual Belt", dualBeltMasturbation)
				.disableIf(!player.hasCock(), "Req. a cock too!"); //only for herms
			for (b = 0; b < 3; ++b) button(2 + b*5) //for belts
				.disableIf(!player.hasVagina(), "Req. a vagina.")
				.disableIf(player.isTaur(), "You can't put a belt on your taur-like body!");
			//taur tools
			addKAbutton(3, "Fake Mare", "Fake Mare", centaurDudesGetHorseAids)
				.disableIf(!player.hasCock(), "Req. a cock.");
			addKAbutton(8, "C. Pole", "Centaur Pole", centaurGirlsGetHorseAids)
				.disableIf(!player.hasVagina(), "Req. a vagina.");
			for (b = 0; b < 2; ++b) button(3 + b*5) //for belts
				.disableIf(!player.isTaur(), "You need to be a taur to use it!");
			//'no item' disables
			for (b = 0; b < 15; ++b) if (button(b).visible)
				button(b).disableIf(player.hasKeyItem(button(b).toolTipHeader) < 0, "Requires " + button(b).toolTipHeader + "!");
			addButton(14, "Back", masturbateMenu);
		}

		//Generic stripping check.
		public function doStripCheck():void
		{
			if (player.hasVagina() && player.isScylla()) {
				outputText("You take off your [armor] and sit on the ground.");
			}
			//In Ingnam or not in cabin.
			else if (flags[kFLAGS.IN_INGNAM] || flags[kFLAGS.CAMP_BUILT_CABIN] <= 0) {
				if (player.cor < 15) {
					outputText("You sheepishly find some rocks to hide in, where ");
					if (player.armor == armors.GOOARMR) {
						if (!player.lowerGarment.isNothing) outputText("you remove your goo-soaked [lowerGarment] then ");
						outputText("you reach your hand into your goo-covered groin.");
					}
					else if (player.armor == armors.LTHCARM && player.lowerGarment.name == "nothing") outputText("you reach for the intricately-decorated opening in your lethicite armor to access your groin.");
					else outputText("you remove your [armor]");
					outputText("\n\n");
				}
				if (player.cor >= 15 && player.cor < 30) {
					outputText("You make sure you are alone and ");
					if (player.armor == armors.GOOARMR) {
						if (!player.lowerGarment.isNothing) outputText("you remove your goo-soaked [lowerGarment] then ");
						outputText("you reach your hand into your goo-covered groin.");
					}
					else if (player.armor == armors.LTHCARM && player.lowerGarment.name == "nothing") outputText("you reach for the intricately-decorated opening in your lethicite armor to access your groin.");
					else outputText("strip naked.");
					outputText("\n\n");
				}
				if (player.cor >= 30 && player.cor < 60) {
					outputText("You happily ");
					if (player.armor == armors.GOOARMR) {
						if (!player.lowerGarment.isNothing) outputText("remove your goo-soaked [lowerGarment] and ");
						outputText("reach your hand into your goo-covered groin");
					}
					else if (player.armor == armors.LTHCARM && player.lowerGarment.name == "nothing") outputText("reach for the intricately-decorated opening in your lethicite armor to access your groin.");
					else outputText("remove your [armor]");
					outputText(", eager to pleasure yourself.\n\n");
				}
				if (player.cor >= 60 && player.cor < 80) {
					outputText("You ");
					if (player.armor == armors.GOOARMR) {
						if (!player.lowerGarment.isNothing) outputText("remove your goo-soaked [lowerGarment] and you ");
						outputText("reach your hand into your goo-covered groin");
					}
					else if (player.armor == armors.LTHCARM && player.lowerGarment.name == "nothing") outputText("reach for the intricately-decorated opening in your lethicite armor to access your groin");
					else outputText("strip naked in an exaggerated fashion");
					outputText(", hoping someone might be watching.\n\n");
				}
				if (player.cor >= 80) {
					outputText("You ");
					if (player.armor == armors.GOOARMR) {
						if (!player.lowerGarment.isNothing) outputText("remove your goo-soaked [lowerGarment] and you ");
						outputText("reach your hand into your goo-covered groin, ");
					}
					else if (player.armor == armors.LTHCARM && player.lowerGarment.name == "nothing") outputText("reach for the intricately-decorated opening in your lethicite armor to access your groin, ");
					else {
						outputText("strip naked, ");

					}
					if (player.hasCock() || player.hasVagina()) outputText("fondling your naughty bits as you do so and ");
					outputText("casting seductive looks around, hoping someone or something is nearby to fuck you.\n\n");
				}
			}
			else if (inDungeon && DungeonAbstractContent.dungeonLoc != DungeonAbstractContent.DUNGEON_CABIN && player.companionsInPCParty()) {
				outputText("You walk to a secluded corner" + player.clothedOrNakedLower(", remove your [lowergarment]") + " and sit down. ");
			}
			//In cabin
			else {
				if (player.cor < 15) {
					outputText("You sheepishly enter your cabin and make sure to close the cabin door and shutters of your window to ensure privacy. ");
					if (player.armor == armors.GOOARMR) {
						outputText("You ");
						if (!player.lowerGarment.isNothing) outputText("remove your goo-soaked [lowerGarment] and you ");
						outputText("reach your hand into your goo-covered groin");
					}
					else if (player.armor == armors.LTHCARM && player.lowerGarment.name == "nothing") outputText("You reach for the intricately-decorated opening in your lethicite armor to access your groin.");
					else outputText("You then proceed to remove your [armor].");
					outputText("\n\n");
				}
				if (player.cor >= 15 && player.cor < 30) {
					outputText("You enter your cabin and close the door, forgetting to close the shutters. ");
					if (player.armor == armors.GOOARMR) {
						outputText("You ");
						if (!player.lowerGarment.isNothing) outputText("remove your goo-soaked [lowerGarment] and you ");
						outputText("reach your hand into your goo-covered groin");
					}
					else if (player.armor == armors.LTHCARM && player.lowerGarment.name == "nothing") outputText("You reach for the intricately-decorated opening in your lethicite armor to access your groin.");
					else outputText("You then proceed to remove your [armor].");
					outputText("\n\n");
				}
				if (player.cor >= 30 && player.cor < 60) {
					outputText("You enter your cabin and leave the shutters open. ");
					if (player.armor == armors.GOOARMR) {
						outputText("You ");
						if (!player.lowerGarment.isNothing) outputText("remove your goo-soaked [lowerGarment] and you ");
						outputText("reach your hand into your goo-covered groin");
					}
					else if (player.armor == armors.LTHCARM && player.lowerGarment.name == "nothing") outputText("You reach for the intricately-decorated opening in your lethicite armor to access your groin.");
					else outputText("You happily remove your [armor].");
					outputText("\n\n");
				}
				if (player.cor >= 60 && player.cor < 80) {
					outputText("You enter your cabin and leave the shutters and door open, hoping someone might notice you. ");
					if (player.armor == armors.GOOARMR) {
						outputText("You ");
						if (!player.lowerGarment.isNothing) outputText("remove your goo-soaked [lowerGarment] and you ");
						outputText("reach your hand into your goo-covered groin");
					}
					else if (player.armor == armors.LTHCARM && player.lowerGarment.name == "nothing") outputText("You reach for the intricately-decorated opening in your lethicite armor to access your groin.");
					else outputText("You eagerly remove your [armor].");
					outputText("\n\n");
				}
				if (player.cor >= 80) {
					outputText("You enter your cabin and leave the shutters and door open. You move your bed so you're visible from the window, hopefully to draw someone's attention. ");
					if (player.armor == armors.GOOARMR) {
						outputText("You ");
						if (!player.lowerGarment.isNothing) outputText("remove your goo-soaked [lowerGarment] and you ");
						outputText("reach your hand into your goo-covered groin");
					}
					else if (player.armor == armors.LTHCARM && player.lowerGarment.name == "nothing") outputText("You reach for the intricately-decorated opening in your lethicite armor to access your groin.");
					else outputText("You eagerly remove your [armor] in an exaggerated fashion.");
					outputText("\n\n");
				}
			}
		}

		//Non-shitty masturbation
		public function masturbateGo():void {
			clearOutput();
			if (player.hasStatusEffect(StatusEffects.Dysfunction)) {
				outputText("You'd love to masturbate, but your sexual organs' numbness makes it impossible.  You'll have to find something to fuck to relieve your lust.");
				doNext(playerMenu);
				return;
			}
			if (player.hasCock() && (player.cocks[0].cockType == CockTypesEnum.BEE) && !inDungeon && !(player.hasItem(consumables.BEEHONY) || player.hasItem(consumables.PURHONY) || player.hasItem(consumables.SPHONEY))) {
				outputText("Although your bee cock aches you know that there's no way for you to get relief on your own.  When you touch your shaft or think about cumming images of the bee girl and the sound of her hypnotic buzzing fill your mind.");
				doNext(playerMenu);
				return;
			}
			if (inDungeon && DungeonAbstractContent.dungeonLoc != DungeonAbstractContent.DUNGEON_CABIN && flags[kFLAGS.PLAYER_COMPANION_1] == "" && flags[kFLAGS.PLAYER_COMPANION_2] == "" && flags[kFLAGS.PLAYER_COMPANION_3] == "") {
				outputText("There is no way you could get away with masturbating in a place like this!  You'd better find your way back to camp if you want to take care of that. Or find someone to guard you during the deed.");
				doNext(playerMenu);
				return;
			}
			if (player.isTaur() && !player.isScylla()) {
				if (centaurMasturbation()) {
					flags[kFLAGS.TIMES_MASTURBATED]++;
					endEncounter();
				}
				else doNext(playerMenu);
				return;
			} else sceneHunter.print("Check failed: Taur lower body.");
			if (player.gender == 0) {
				genderlessMasturbate();
				flags[kFLAGS.TIMES_MASTURBATED]++;
				dynStats("lus", -50, "scale", false);
				endEncounter();
				return;
			}
            if (SceneLib.exgartuan.dickAwake() && (!SceneLib.exgartuan.boobsAwake() || rand(2) == 0)) {
				flags[kFLAGS.TIMES_MASTURBATED]++;
                if (!player.isNaga()) sceneHunter.print("Check failed: Naga.");
				if (player.isNaga() && rand(2) == 0) SceneLib.exgartuan.exgartuanNagaStoleMyMasturbation();
                else SceneLib.exgartuan.exgartuanMasturbation_dick();
            } else sceneHunter.print("Check failed: Exgartuan.");
			if (SceneLib.exgartuan.boobsAwake()) {
				flags[kFLAGS.TIMES_MASTURBATED]++;
				SceneLib.exgartuan.exgartuanMasturbation_boobs();
                return;
			} else sceneHunter.print("Check failed: Xenora.");
			if (player.countCockSocks("gilded") > 0) {
				if (flags[kFLAGS.GILDED_JERKED] < player.countCockSocks("gilded")) {
					flags[kFLAGS.TIMES_MASTURBATED]++;
					gildedCockTurbate();
					return;
				}
			} else sceneHunter.print("Check failed: Gilded cock socks")
			if (inDungeon && DungeonAbstractContent.dungeonLoc != DungeonAbstractContent.DUNGEON_CABIN && player.companionsInPCParty()) {
				outputText("You go to the side, asking ");
				if (flags[kFLAGS.PLAYER_COMPANION_3] != "" && rand(2) == 0) outputText("" + flags[kFLAGS.PLAYER_COMPANION_3] + "");
				else if (flags[kFLAGS.PLAYER_COMPANION_2] != "" && rand(2) == 0) outputText("" + flags[kFLAGS.PLAYER_COMPANION_2] + "");
				else outputText("" + flags[kFLAGS.PLAYER_COMPANION_1] + "");
				outputText(" to guard you while taking some time off to relieve yourself.\n\n");
			}
			var autofellatio:Boolean = false;
			var nippleFuck:Boolean = false;
			//Early prep
			doStripCheck();
			//Tit foreplay
			titForeplay();
			//Touch our various junks
			if (player.cocks.length > 0) {
				if (player.cocks[0].cockType == CockTypesEnum.BEE && (player.hasItem(consumables.BEEHONY) || player.hasItem(consumables.PURHONY) || player.hasItem(consumables.SPHONEY))) {
					if (player.hasItem(consumables.BEEHONY)) player.consumeItem(consumables.BEEHONY, 1);
					else if (player.hasItem(consumables.PURHONY)) player.consumeItem(consumables.PURHONY, 1);
					else if (player.hasItem(consumables.SPHONEY)) player.consumeItem(consumables.SPHONEY, 1);
					outputText("You take out a vial of honey and smear it all over your bee cock. It feels great and the pain quickly recedes. ");
				}
				if (player.cocks.length == 1) {
					outputText("You stroke your " + player.cockDescript());
					if (player.lib < 45)
						outputText(" eagerly, quickly bringing yourself to a full, throbbing state.  ");
					else if (player.lib < 70)
						outputText(" languidly, reveling at its near-constant hardness.  ");
					else outputText(" teasingly, pre-cum running down your length from your constant state of arousal.  ");
				}
				else {
					outputText("You stroke your " + player.cockDescript());
					if (player.lib < 45)
						outputText(" eagerly, quickly bringing your cocks to a full, throbbing state.  ");
					else if (player.lib < 70)
						outputText(" languidly, reveling at their near-constant hardness.  ");
					else outputText(" teasingly, pre-cum running down your cocks from your constant state of arousal, pooling around you.  ");
				}
			}
			if (player.vaginas.length > 0) {
				if (player.vaginas.length == 1) {
					//0 = dry, 1 = wet, 2 = extra wet, 3 = always slick, 4 = drools constantly, 5 = female ejaculator
					if (player.lib < 45)
						outputText("You touch and play with your [vagina], ");
					else if (player.lib < 70)
						outputText("You slap your pussy softly, ");
					else outputText("You touch your enflamed and aroused [vagina], ");
					switch (player.vaginas[0].vaginalWetness) {
						case VaginaClass.WETNESS_DRY:
							outputText("expertly arousing your female parts.  "); break;
						case VaginaClass.WETNESS_NORMAL:
							outputText("sighing as it quickly becomes moist.  "); break;
						case VaginaClass.WETNESS_WET:
							outputText("giggling as your fingers get a little wet.  "); break;
						case VaginaClass.WETNESS_SLICK:
							outputText("smiling as your fingers become coated in your slick fluids.  "); break;
						case VaginaClass.WETNESS_DROOLING:
							outputText("slicking your fingers in the juices that constantly dribble from [vagina]  "); break;
						default:
							outputText("licking your lips as a small spurt of fluid squirts from your nethers.");
					}
				}
				if (player.vaginas.length > 1) {
					if (player.lib < 45)
						outputText("You touch and play with your many folds, ");
					else if (player.lib < 70)
						outputText("You slap your pussies softly, ");
					else outputText("Touch your enflamed and aroused [vagina]s, ");
					switch (player.vaginas[0].vaginalWetness) {
						case VaginaClass.WETNESS_DRY:
							outputText("expertly arousing your female parts.  "); break;
						case VaginaClass.WETNESS_NORMAL:
							outputText("sighing as they quickly becomes moist.  "); break;
						case VaginaClass.WETNESS_WET:
							outputText("giggling as your fingers get a little wet.  "); break;
						case VaginaClass.WETNESS_SLICK:
							outputText("smiling as your fingers become coated in your slick fluids.  "); break;
						case VaginaClass.WETNESS_DROOLING:
							outputText("slicking your fingers in the juices that constantly dribble from [vagina]s  "); break;
						default:
							outputText("licking your lips as small spurts of fluid squirt from your nethers.");
					}
				}
			}
			/*******************************
			||       MASTURBATION CORE    ||
			\\*****************************/
			if (player.hasCock()) sceneHunter.print("For dicks, there WILL be checks for nipplecunts.");
			sceneHunter.print("I'll explain the math. If you have nipplecunts, AND have one more big dick... magic will happen.")
			sceneHunter.selectGender(curry(sceneHunter.selectSingleMulti, singleF, player.cockTotal() > 2 ? moreF : twoF), vagF);

			//Cock masturbation!
			function singleF():void {
				//New lines for masturbation!
				outputText("\n\n");
				//1.8 thick enough to satisfy all women
				//3 hard time fucking women
				//5 lucky to find demon/animal
				if (player.cocks[0].cockThickness < 1.8)
					outputText("You easily wrap a hand around your [cock] and start masturbating.  ");
				else if (player.cocks[0].cockThickness < 3) {
					outputText("You have some difficulty fitting your hand around your [cock], relishing the feelings of your ");
					if (player.cocks[0].cockType == CockTypesEnum.HORSE)
						outputText("animalistic");
					else if (player.hasKnot())
						outputText("bulbous beast");
					else outputText("large");
					outputText(" endowment as you begin masturbating.  ");
				}
				else if (player.cocks[0].cockThickness < 5) {
					outputText("You use both hands to grip your [cock], feeling the throbbing of your " + (player.hasKnot() ? "knot" : "member") + " as you begin to masturbate.  ");
				}
				else outputText("You grasp onto your [cock] with both hands, but fail to encircle it fully as you begin to masturbate.  ");
				//If length > 12 proud
				//if length > 16 looong strokes (maybe tittyfucK?)
				//if length > 20 selfsuck
				if (player.cocks[0].cockLength < 12) {
					if (player.normalCocks() >= 1)
						outputText("You stroke quickly, pleasuring your sensitive dick, darting down to fondle the base of your cock.  ");
					else if (player.horseCocks() >= 1)
						outputText("You stroke quickly, reveling in your sensitive horseflesh, darting down to fondle your sensitive sheath.  ");
					else if (player.dogCocks() >= 1)
						outputText("You stroke quickly, pleasuring your sensitive, canine erection, darting down to fondle the sensitive sheath at the base of your cock.  ");
					else if (player.tentacleCocks() >= 1 || player.stamenCocks() > 0)
						outputText("You stroke quickly, pleasuring the supple length of your tentacular endowment, fondling every inhuman nodule as you slide along every inch of twisting length.  ");
					else if (player.demonCocks() >= 1)
						outputText("You stroke quickly, pleasuring the bumpy ridges of your demonic tool, fondling every inhuman nodule as you slide along the entire twitching length.  ");
					else if (player.catCocks() >= 1)
						outputText("You stroke quickly, feeling the tiny 'barbs' of your [cock] sliding through your fingers, even darting down to circle the sensitive skin around your sheath.  ");
					else if (player.lizardCocks() >= 1)
						outputText("You stroke quickly, pleasuring your sensitive [cock], sliding fingers over each ridge and bump that covers its knotty length.  ");
					else if (player.anemoneCocks() >= 1)
						outputText("You stroke quickly, gasping as your fingers are stung repeatedly with the aphrodisiac-laced tentacles around the base of your [cock] and under its crown.  ");
					else if (player.displacerCocks() >= 1)
						outputText("You stroke quickly, pleasuring your sensitive, alien endowment, darting down to fondle the sensitive sheath as your pointed tip opens into a wiggling, starfish-like shape.  ");
					else outputText("You stroke quickly, pleasuring your sensitive dick, darting down to fondle the base of your cock.  ");
				}
				else if (player.cocks[0].cockLength < 20) {
					if (player.normalCocks() >= 1)
						outputText("You delight in teasing the crown of your [cock], rubbing it at the end of each stroke, squeezing out dollops of pre to smear over it and tease yourself with.  It seems to pulse and twitch with each stroke, responding to every touch.  ");
					else if (player.horseCocks() >= 1)
						outputText("You delight in teasing the sensitive flared tip of your [cock], rubbing it at the end of each stroke, squeezing out dollops of pre to smear over it and tease yourself with.  It seems to pulse and ripple with each stroke, responding to every touch.  ");
					else if (player.dogCocks() >= 1)
						outputText("You delight in teasing the pointed tip of your [cock], rubbing it at the end of each stroke, squeezing out dollops of pre to smear over it and tease yourself with.  Your knot seems to pulse and twitch with each stroke, reacting to every touch.  ");
					else if (player.tentacleCocks() >= 1 || player.stamenCocks() > 0)
						outputText("You delight in teasing the over-sized mushroom-like tip of your [cock], caressing it after every stroke as you squeeze out dollops of pre to smear along its slimy length.  It writhes and twists in your hands of it's own volition, lengthening and shortening with each set of strokes.  ");
					else if (player.demonCocks() >= 1)
						outputText("You delight in teasing the larger bumps that form a ring around the crown of your [cock], watching as they twitch and spasm in time with the dollops of pre you're squeezing out and smearing over the entire length.  ");
					else if (player.catCocks() >= 1)
						outputText("You delight in teasing the sensitive nubs all along your [cock], circling the cock-tip at the end of each stroke to gather pre and slather it over your entire length.  Each of the tiny 'barbs' provides bursts of pleasure with each stroke, driving you on.  ");
					else if (player.lizardCocks() >= 1)
						outputText("You delight in teasing the rounded bulbs that cover your [cock], circling them with your fingertips before sliding up to the urethra and gathering a drop of pre.  You smear it over your sensitive reptile skin and revel in the pleasure radiating through you.  ");
					else if (player.anemoneCocks() >= 1)
						outputText("You delight in grabbing hold of the tiny, stinging tentacles around the base and squeezing them between your [cock] and hand.  Aphrodisiac pours into your blood as you release them and stroke along the length, gathering dollops of pre to coat yourself with and 'accidentally' bumping the other tentacles at the crown.  ");
					else if (player.displacerCocks() >= 1)
						outputText("You delight in teasing the opened tip of your [cock], rubbing it at the end of each stroke, watching it squeeze out dollops of pre that you smear over it to tease yourself with.  Your knot seems to pulse and twitch with each stroke, reacting to every touch.  ");
					else outputText("You delight in teasing the crown of your [cock], rubbing it at the end of each stroke, squeezing out dollops of pre to smear over it and tease yourself with.  It seems to pulse and twitch with each stroke, responding to every touch.  ");
				}
				else if (player.cocks[0].cockLength < 26) {
					if (player.normalCocks() >= 1)
						outputText("The head of your [cock] wobbles towards your face as you masturbate, a dollop of pre slowly growing atop it.  ");
					else if (player.horseCocks() >= 1)
						outputText("The flared tip of your [cock] wobbles towards your face as you masturbate, a dollop of pre slowly growing atop it.  ");
					else if (player.dogCocks() >= 1)
						outputText("The pointed tip of your [cock] angles towards your face as you masturbate, a dollop of pre slowly leaking from it.  ");
					else if (player.tentacleCocks() >= 1 || player.stamenCocks() > 0)
						outputText("The overly wide head of your [cock] bumps against your lips as you masturbate, waving back and forth like a snake as it searches for an orifice.  ");
					else if (player.demonCocks() >= 1)
						outputText("The purplish head of your [cock] bumps against your lips as you masturbate, flushing darkly with every beat of your heart.  ");
					else if (player.catCocks() >= 1)
						outputText("The slightly pointed tip of your [cock] bumps against your lips as you masturbate, flushing with blood as your spines grow thicker in your hand.  ");
					else if (player.lizardCocks() >= 1)
						outputText("The pointed, purple tip of your [cock] bumps against your lips while its knotted surface flushes near-purple and seems to grow thicker.  ");
					else if (player.anemoneCocks() >= 1)
						outputText("The tentacle-ringed tip of your [cock] brushes against your lips, making them tingle with artificial heat while you stroke it.  ");
					else if (player.displacerCocks() >= 1)
						outputText("The blooming tip of your [cock] angles towards your face as you masturbate, a dollop of pre slowly leaking out of the outstretched top.  ");
					else outputText("The head of your [cock] wobbles towards your face as you masturbate, a dollop of pre slowly growing atop it.  ");
					//try to stick it in a titty!
					if (player.hasFuckableNipples() && player.biggestTitSize() >= 3 && rand(2) == 0) {
						//UNFINISHED - TWEAK PENETRATION VALUES
						nippleFuck = true;
						titFuckSingle();
					}
					else {
						//autofellatio doesnt get to be true unless you keep it in your mouth instead of sticking it in your boob.
						outputText("You give in to temptation and swallow the tip, slurping greedily as you milk your [cock] of its pre-cum.  ");
						autofellatio = true;
					}
					if (player.canTitFuck() && player.biggestTitSize() > 3 && !nippleFuck) {
						outputText("Your hands migrate to your breasts of their own accord, wrapping your titflesh around your [cock], jacking it up and down in your pillowy tits.  ");
						if (player.biggestLactation() > 0) outputText("Jets of milk squirt out of your nipples with each thrust of your hips, adding to the already copious amounts of fluids coating your body. ");
					}
				}
				else {
					if (player.normalCocks() >= 1)
						outputText("The head of your [cock] wobbles over, bumping your face and smearing your lips with its copious pre-cum.  You are unable to resist opening your mouth and sucking it down, filling your mouth with your cock.  ");
					else if (player.horseCocks() >= 1)
						outputText("The flared tip of your [cock] wobbles over, bumping your face and smearing your lips with its copious pre-cum.  You are unable to resist opening your mouth and sucking it down, filling your mouth with horsemeat.  ");
					else if (player.dogCocks() >= 1)
						outputText("The head of your [cock] wobbles over, bumping your face and smearing your lips with its copious pre-cum.  You are unable to resist opening your mouth and sucking it down, filling your mouth with your [cock].  ");
					else if (player.tentacleCocks() >= 1 || player.stamenCocks() > 0)
						outputText("The bulbous, mushroom-like head of your [cock] pushes against your face eagerly, smearing pre-cum over your lips as it seeks entrance to the nearest orifice.  You're unable to resist opening your mouth to suck it down, filling your mouth with slick rubbery cock-tentacle.  ");
					else if (player.demonCocks() >= 1)
						outputText("The tainted swollen head of your [cock] pushes against your face, smearing sweet pre-cum over your lips.  You're unable to resist opening wide and taking in the demonic member, submitting wholly to the desire to pleasure your corrupted body-parts.  ");
					else if (player.catCocks() >= 1)
						outputText("The pointed tip of your [cock] pushes against your face, smearing pre-cum over your lips and tickling you with the many barbs.  You're unable to resist opening wide and taking in the [cock], half-humming half-purring in contentment.  ");
					else if (player.lizardCocks() >= 1)
						outputText("The slightly-pointed tip of your [cock] pushes against your face, smearing pre-cum over your eager lips.   You can't resist opening wide and slipping it inside as your hands caress the reptilian bulges along your length.  ");
					else if (player.anemoneCocks() >= 1)
						outputText("The rounded, tentacle-ringed tip of your [cock] slides against your face, smearing pre-cum over your lips and stinging them with aphrodisiacs that make you pant with lust.  You can't resist opening wide to greedily slurp it down, and in seconds tiny, tingling stings are erupting through your oral cavity, filling you with lust and pleasure.  ");
					else if (player.displacerCocks() >= 1)
						outputText("The head of your [cock] wobbles over, bumping your face and smearing your lips with its copious pre-cum.  Wiggling against your lips, the various protrusions of the 'star' at the tip smear you with your heady emissions.   You are unable to resist opening your mouth and sucking it down, filling your mouth with your [cock].  ");
					else outputText("The head of your [cock] wobbles over, bumping your face and smearing your lips with its copious pre-cum.  You are unable to resist opening your mouth and sucking it down, filling your mouth with your cock.  ");
					//try to stick it in a titty!
					if (player.hasFuckableNipples() && player.biggestTitSize() >= 3) {
						//In-between text
						//UNFINISHED
						//outputText("You gasp
						nippleFuck = true;
						//UNFINISHED
						titFuckSingle();
					}
					else {
						//autofellatio doesnt get to be true unless you keep it in your mouth instead of sticking it in your boob.
						if (player.cor > 60) {
							if (player.normalCocks() >= 1)
								outputText("The heady aroma of your cock fills your nostrils as you force inch after inch into your mouth, deepthroating as much of yourself as you can.  ");
							else if (player.horseCocks() >= 1)
								outputText("The thick animalistic scent fills your nostrils as you force inch after inch into your mouth, deepthroating as much of yourself as you can.  ");
							else if (player.dogCocks() >= 1)
								outputText("The strong animal scent of your cock fills your nostrils as you force inch after inch into your mouth, deepthroating as much of yourself as you can.  ");
							else if (player.tentacleCocks() >= 1 || player.stamenCocks() > 0)
								outputText("The sweet scent of your [cock] fills your nostrils as inch after inch of tentacle forces its way down your throat.  You struggle briefly with it, wrestling to keep it from pushing the whole way into your gut, swooning with the pleasure that fighting with your own cock induces.  ");
							else if (player.demonCocks() >= 1)
								outputText("The spicy demonic odor your [cock] radiates fills your nostrils as you force inch after inch of tainted meat down your throat.  You struggle briefly, but your [cock] quickly overwhelms your resistance and your gag reflex momentarily seems to disappear.  ");
							else if (player.catCocks() >= 1)
								outputText("The sweet, slightly tangy scent of your cock fills your nostrils as you force inch after inch into your mouth, deepthroating as much of the prickly shaft as you can.  The soft spines that coat its surface actually feel quite pleasant as you force it deeper, denying your gag reflex.  ");
							else if (player.lizardCocks() >= 1)
								outputText("The salty, dry odor of your [cock] fills your nostrils as you force inch after inch into your mouth, swallowing as much of the bulgy shaft as you can.  ");
							else if (player.anemoneCocks() >= 1)
								outputText("The stinging, aphrodisiac-laced [cock] slowly works its way down your throat as you swallow it deeper and deeper, gurgling happily as your throat grows more sensitive.  ");
							else if (player.displacerCocks() >= 1)
								outputText("The strong animal scent of your cock fills your nostrils as you force inch after inch into your mouth, deepthroating as much of yourself as you can.  ");
							else outputText("The heady aroma of your cock fills your nostrils as you force inch after inch into your mouth, deepthroating as much of yourself as you can.  ");
						}
						autofellatio = true;
					}
					if (player.canTitFuck() && player.biggestTitSize() > 3 && !nippleFuck) {
						outputText("Your hands reach up to your pillowy breasts, wrapping them around the shaft of your [cock], causing you to let out muffled moans of excitment. ");
						if (player.biggestLactation() > 0) outputText("Jets of milk squirt out of your nipples with each thrust of your hips, adding to the already copious amounts of fluids coating your body. ");
					}
				}
				orgazmo(autofellatio, nippleFuck);
				masturbEnding();
			}
			function twoF():void { //Pair of cocks
                sceneHunter.print("Check failed: you surely could use more cocks!");
				//Grab it
				//Play with sheath if has one
				if (player.hasSheath()) {
					outputText("Your fingers trace around your sheath, drawing involuntary spasms from your twin members.  ");
				}
				//Prep bit + variance based on thickness
				outputText("You grasp one of your [cocks] in each hand, ");
				if (player.averageCockThickness() <= 1.8)
					outputText("wrapping your fingers around each tool and just holding yourself, the feelings of two cocks almost too much to bear.  ");
				else outputText("squeezing as many of your tools as your fingers can encircle.  The feeling of squeezing your thick twin cocks is amazing and overwhelming at the same time.  ");
				//Get into it
				//Play with it if <= 10"
				if (player.averageCockLength() <= 10)
					outputText("Your hips twitch of their own volition, force-fucking your hands.  In moments you're fiercely masturbating,  pumping each shaft in turn, pleasure mounting at the base and growing more urgent with each pump.  You squeal softly, and increase the tempo of your masturbation, desperate for release.  ");
				//Tittyfuck if D cup+
				else if (player.averageCockLength() < 20) {
					//autofellatio only gets to be true if you have any dicks left to suck on after sticking them in your boobs
					outputText("You look down at your trembling members, mere inches away, and tentatively lick at a cocktip.  Both dicks begin oozing pre in response.  ");
					//Try to stick it in a titty!
					if (player.hasFuckableNipples()) {
						//check for dogcocks
						if (player.dogCocks() > 0) {
							//make sure that your cocks will fit in your tits if dogcocks
							if (player.hasFuckableNipples()) {
								nippleFuck = true;
								if (multiTitFuck()) autofellatio = true;
							}
							else if (player.dogCocks() != player.cocks.length) { //if you have something that will fit
								nippleFuck = true;
								autofellatio = true;
								//UNFINISHED
								if (player.normalCocks() > 0) titFuckSingle();
							} //if you only have dogcocks that are too big, no nipple fuck! Otherwise, run normal multiTitFuck
						}
						else {
							nippleFuck = true;
							if (multiTitFuck()) autofellatio = true;
						}
					}
					//Titfuck (squeeze em both in between 2!
					if (player.canTitFuck() && !nippleFuck) {
						outputText("You wrap your " + player.breastCup(0) + " tits around your [cocks], sandwiching them inside your pillowy mounds.  With delicious slowness you begin jacking yourself off with your tits, your shafts rubbing together between your luxurious breasts, tongue running figure eights across the tips. ");
						if (player.biggestLactation() > 0) outputText("Jets of milk squirt out of your nipples with each thrust of your hips, adding to the already copious amounts of fluids coating your body. ");
					}
					//Titfuck (enough breasts for both!)
					if (player.canTitFuck() && player.mostBreastsPerRow() > 2 && !nippleFuck) {
						outputText("You wrap your " + player.breastCup(0) + " tits around your [cocks], squeezing them between your " + player.totalBreasts() + " breasts.  With delicious slowness you begin jacking yourself off with your tits, smooth breastflesh massaging your members as you aggressively lick and suck at the tips.  ");
						if (player.biggestLactation() > 0) outputText("Jets of milk squirt out of your many nipples with each thrust of your hips, adding to the already copious amounts of fluids coating your body. ");
					}
					//No tits, jerk and lick!
					if (player.biggestTitSize() <= 3 && !nippleFuck) {
						outputText("You slowly stroke yourself, pausing every few strokes to smear the streaks of pre that leak from your [cocks] over yourself.  As you become more and more lubed and horny, you increase the tempo, until at last you are pumping yourself hard and fast, squeezing your cocks together in pleasure.  ");
					}
				}
				//Deepthroat yourself, maybe titfuck if equipped.
				else {
					//autofellatio only gets to be true if you have any dicks left to suck on after sticking them in your boobs
					outputText("Your [cocks] brush against your face, throbbing with need.   You open your mouth and suck one of your pricks into your mouth, taking as much of it as possible, running your tongue along the underside.  You smile and pop it free, then take a different shaft into your maw.  ");
					//Try to stick it in a titty!
					if (player.hasFuckableNipples()) {
						//check for dogcocks
						if (player.dogCocks() > 0) {
							//make sure that your cocks will fit in your tits if dogcocks
							if (player.hasFuckableNipples()) {
								nippleFuck = true;
								if (multiTitFuck()) autofellatio = true;
							}
							else if (player.dogCocks() != player.cocks.length) { //if you have something that will fit
								nippleFuck = true;
								autofellatio = true;
								if (player.normalCocks() > 0 || player.horseCocks() > 0) titFuckSingle();
							}  //if you only have dogcocks that are too big, no nipple fuck! Otherwise, run normal multiTitFuck
						}
						else {
							nippleFuck = true;
							if (multiTitFuck()) autofellatio = true;
						}
					}
					//Titfuck (squeeze em both in between 2!
					if (player.canTitFuck() && !nippleFuck) {
						outputText("You wrap your " + player.breastCup(0) + " tits around your [cocks], sandwiching them inside your pillowy mounds.  With delicious slowness you begin jacking yourself off with your tits, your shafts rubbing together between your luxurious breasts, mouthfucking yourself with each of your cocks in turn. ");
						if (player.biggestLactation() > 0) outputText("Jets of milk squirt out of your nipples with each thrust of your hips, adding to the already copious amounts of fluids coating your body. ");
					}
					//Titfuck (enough breasts for both!)
					if (player.mostBreastsPerRow() > 2 && player.biggestTitSize() > 3 && !nippleFuck) {
						outputText("You wrap your " + player.breastCup(0) + " tits around your [cocks], squeezing them between your " + player.totalBreasts() + " breasts.  With delicious slowness you begin jacking yourself off with your tits, smooth breastflesh massaging your members as you aggressively mouthfuck each of your cocks. ");
						if (player.biggestLactation() > 0) outputText("Jets of milk squirt out of your many nipples with each thrust of your hips, adding to the already copious amounts of fluids coating your body. ");
					}
					//No tits, jerk and lick!
					if (player.biggestTitSize() <= 3 && !nippleFuck) {
						outputText("You slowly stroke yourself, pausing every few strokes to smear the streaks of pre that leak from your [cocks] over yourself.  As you become more and more lubed and horny, you increase the tempo, until at last you are pumping yourself hard and fast, squeezing your cocks together in pleasure.  ");
					}
				}
				orgazmo(autofellatio, nippleFuck);
				masturbEnding();
			}
			function moreF():void { //Three or more cocks
				//Grab it
				//Play with sheath if has one
				if (player.hasSheath()) {
					outputText("Your fingers trace around your sheath, drawing involuntary spasms from your cocks.  ");
				}
				//Prep bit + variance based on thickness
				outputText("You grasp one of your [cocks] in each hand, ");
				if (player.averageCockThickness() <= 1.8)
					outputText("wrapping your fingers around each tool and just holding yourself, the feelings of your " + num2Text(player.cocks.length) + " cocks making you feel giddy.  ");
				else outputText("squeezing as many of your tools as your fingers can encircle.  The feeling of rubbing your bundle of cocks together is indescribable.  Your eyes roll back in uncontrollable pleasure.  ");
				//Get into it
				//Play with it if <= 10"
				if (player.averageCockLength() <= 10)
					outputText("Your hips twitch of their own volition, forcing you to fuck your hands.  In moments you're fiercely masturbating,  pumping each shaft in turn, pleasure mounting in your loins and growing more urgent with each pump.  You squeal softly, and increase the tempo of your masturbation, desperate for release.  ");
				//Tittyfuck if D cup+
				else if (player.averageCockLength() < 20) {
					//autofellatio only gets to be true if you have any dicks left to suck on after sticking them in your boobs
					outputText("You look down at your trembling members, mere inches away, and tentatively lick at a cocktip.  Your dicks begin oozing pre in response.  ");
					//Try to stick it in a titty!
					if (player.hasFuckableNipples()) {
						//check for dogcocks
						if (player.dogCocks() > 0) {
							//make sure that your cocks will fit in your tits if dogcocks
							if (player.hasFuckableNipples()) {
								nippleFuck = true;
								if (multiTitFuck()) autofellatio = true;
							}
							else if (player.dogCocks() != player.cocks.length) { //if you have something that will fit
								nippleFuck = true;
								autofellatio = true;
								if ((player.normalCocks() > 0 || player.horseCocks() > 0) && player.cocks.length - player.dogCocks() == 1) titFuckSingle();
								if (player.cocks.length - player.dogCocks() > 1) multiTitFuck();
							} //if you only have dogcocks that are too big, no nipple fuck! Otherwise, run normal multiTitFuck
						}
						else {
							nippleFuck = true;
							if (multiTitFuck()) autofellatio = true;
						}
					}
					//Titfuck (squeeze em both in between 2!
					if (player.canTitFuck() && !nippleFuck) {
						outputText("You wrap your " + player.breastCup(0) + " tits around your [cocks], sandwiching them inside your pillowy mounds.  With delicious slowness you begin jacking yourself off with your tits, your shafts rubbing together between your luxurious breasts, your tongue running figure eights across the tips. ");
						if (player.biggestLactation() > 0) outputText("Jets of milk squirt out of your nipples with each thrust of your hips, adding to the already copious amounts of fluids coating your body. ");
					}
					//Titfuck (enough breasts for both!)
					if (player.mostBreastsPerRow() > 2 && player.biggestTitSize() > 3 && !nippleFuck) {
						outputText("You wrap your " + player.breastCup(0) + " tits around your [cocks], squeezing them between your " + player.totalBreasts() + " breasts.  With delicious slowness you begin jacking yourself off with your tits, smooth breastflesh massaging your members as you aggressively lick and suck at the tips.  ");
						if (player.biggestLactation() > 0) outputText("Jets of milk squirt out of your many nipples with each thrust of your hips, adding to the already copious amounts of fluids coating your body. ");
					}
					//No tits, jerk and lick!
					if (player.biggestTitSize() <= 3 && !nippleFuck) {
						outputText("You slowly stroke yourself, pausing every few strokes to smear the streaks of pre that leak from your [cocks] over yourself.  As you become more and more lubed and horny, you increase the tempo, until at last you are pumping yourself hard and fast, squeezing your cocks together in pleasure.  ");
					}
				}
				//Deepthroat yourself, maybe titfuck if equipped.
				if (player.averageCockLength() >= 20) {
					//autofellatio only gets to be true if you have any dicks left to suck on after sticking them in your boobs
					outputText("Your [cocks] brush against your face, throbbing with need.   You open your mouth and suck one of your pricks into your mouth, taking as much of it in as possible, running your tongue along the underside.  You smile and pop it free, then take a different shaft into your maw.  ");
					//Try to stick it in a titty!
					if (player.hasFuckableNipples()) {
						//check for dogcocks
						if (player.dogCocks() > 0) {
							//make sure that your cocks will fit in your tits if dogcocks
							if (player.hasFuckableNipples()) {
								nippleFuck = true;
								if (multiTitFuck()) autofellatio = true;
							}
							else if (player.dogCocks() != player.cocks.length) { //if you have something that will fit
								nippleFuck = true;
								autofellatio = true;
								if ((player.normalCocks() > 0 || player.horseCocks() > 0) && player.cocks.length - player.dogCocks() == 1) titFuckSingle();
								if (player.cocks.length - player.dogCocks() > 1) multiTitFuck();
							} //if you only have dogcocks that are too big, no nipple fuck! Otherwise, run normal multiTitFuck
						}
						else {
							nippleFuck = true;
							if (multiTitFuck()) autofellatio = true;
						}
					}
					//Titfuck (squeeze em both in between 2!
					if (player.canTitFuck() && !nippleFuck) {
						outputText("You wrap your " + player.breastCup(0) + " tits around your [cocks], sandwiching them inside your pillowy mounds.  With delicious slowness you begin jacking yourself off with your tits, your shafts rubbing together between your luxurious breasts, mouthfucking yourself with each of your cocks in turn. ");
						if (player.biggestLactation() > 0) outputText("Jets of milk squirt out of your nipples with each thrust of your hips, adding to the already copious amounts of fluids coating your body. ");
					}
					//Titfuck (enough breasts for both!)
					if (player.mostBreastsPerRow() > 2 && player.biggestTitSize() > 3 && !nippleFuck) {
						outputText("You wrap your " + player.breastCup(0) + " tits around your [cocks], squeezing them between your " + player.totalBreasts() + " breasts.  With delicious slowness you begin jacking yourself off with your tits, smooth breastflesh massaging your members as you aggressively mouthfuck each of your cocks. ");
						if (player.biggestLactation() > 0) outputText("Jets of milk squirt out of your many nipples with each thrust of your hips, adding to the already copious amounts of fluids coating your body. ");
					}
					//No tits, jerk and lick!
					if (player.biggestTitSize() <= 3 && !nippleFuck) {
						outputText("You slowly stroke yourself, pausing every few strokes to smear the streaks of pre that leak from your [cocks] over yourself.  As you become more and more lubed and horny, you increase the tempo, until at last you are pumping yourself hard and fast, squeezing your cocks together in pleasure.  ");
					}
				}
				orgazmo(autofellatio, nippleFuck);
				masturbEnding();
			}
			//Vaginal Masturbation
			function vagF():void {
				outputText("\n\n");
				//Single cunt
				if (player.vaginas.length == 1) {
					outputText("You let your hand roam over your pussy-lips, slowly teasing yourself, diving deeper into your folds to arouse and expose your clit.  ");
					//Smaller clits
					if (player.clitLength < 1.5) {
						outputText("You stroke and tease around the sensitive little pleasure bud, letting your fingers plumb the depths below.  ");
					}
					//Big clits
					else if (player.clitLength < 4.5) {
						outputText("Your large clit is already poking out from your ");
						if (player.vaginas[0].vaginalWetness > VaginaClass.WETNESS_DRY) outputText("glistening ");
						outputText("lips.  You gently stroke and touch it until it grows as large as a tiny cock.  ");
					}
					//Cock-sized clits
					else {
						outputText("Your cock-sized clit is already fully engorged and deliciously sensitive.  You touch it softly, eliciting a quiet moan from your throat.  ");
					}
					switch (player.vaginas[0].vaginalWetness) {
						case VaginaClass.WETNESS_DRY:
							outputText("You have some difficulty with your relatively dry pussy, but you manage to gently and pleasurably masturbate by taking it slowly.  "); break;
						case VaginaClass.WETNESS_NORMAL:
							outputText("Your horny puss is aching for attention and you oblige it, dipping your fingers into the moist honeypot, and jilling yourself vigorously.  "); break;
						case VaginaClass.WETNESS_WET:
							outputText("The moistened cleft on your groin demands your full attention, drawing your fingers deep inside to explore the wet passage.  "); break;
						case VaginaClass.WETNESS_SLICK:
							outputText("The sweltering heat of your slick cunt aches for something to fill it, and you oblige, dipping your fingers into your slippery cunt.  "); break;
						case VaginaClass.WETNESS_DROOLING:
							outputText("Warm wetness runs down your legs in thick streams, pouring from your [vagina].  You smile sheepishly and stroke up your now slickened legs to your pussy-lips, parting them and letting your fingers dive inside the wet channel.  "); break;
						default:
							outputText("The heavy scent of female arousal fills the air as your steamy sexpot drizzles girl-lube everywhere.  You gasp in surprise as your fingers find their way inside, vigorously fingerfucking your passage, spurts of girlcum squirting out with each penetration.  ");
					}
				}
				orgazmo(autofellatio, nippleFuck);
				masturbEnding();
			}
		}

		private function masturbEnding():void {
			//ORGASM GOES HERE
			//POST MASTUBLATORY BLISS
			if (!player.hasPerk(PerkLib.ElectrifiedDesire) || !player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
				outputText("\n\n");
				if (player.cocks.length > 0) {
					//Single Cock
					if (player.cocks.length == 1) {
						if (player.lib < 30)
							outputText("You quickly fall asleep, spent. ");
						else if (player.lib < 55)
							outputText("You roll and begin to doze, your semi-erect [cock] flopping against you. ");
						else if (player.lib <= 80) {
							outputText("As you close your eyes and relax, your [cock] surges back to erectness, ensuring ");
							if (player.cor < 50)
								outputText("your dreams will be filled with sex.");
							else outputText("you dream in a depraved kinky fantasia.");
						}
						else outputText("You groan and drift to sleep, your rigid [cock] pulsing and throbbing with continual lust.");
					}
					//Multi Cock
					else {
						if (player.lib < 30)
							outputText("You quickly fall asleep, spent. ");
						else if (player.lib < 55)
							outputText("You roll and begin to doze for an hour, your semi-erect cocks flopping against you. ");
						else if (player.lib <= 80) {
							outputText("As you close your eyes and relax, your dicks surge back to erectness, ensuring ");
							if (player.cor < 50)
								outputText("your dreams will be filled with sex.");
							else outputText("you dream in a depraved kinky fantasia.");
						}
						else outputText("You groan and drift into a brief catnap, your rigid erections pulsing and throbbing with continual lust.");
					}
					if (player.perkv1(IMutationsLib.NukiNutsIM) >= 2){
						var cumAmmount:Number = player.cumQ();
						var payout:Number = 1;
						//Get rid of extra digits
						//cumAmmount = int(cumAmmount);
						//Calculate payout
						if(cumAmmount > 10) {
							payout += 2 + int(cumAmmount/100)*2;
						}
						//Reduce payout if it would push past
						if (player.perkv1(IMutationsLib.NukiNutsIM) >= 3){
							payout *= 2;
						}
						if(payout > 0) {
							player.gems += payout;
							outputText("\n\nWhen you wake up you find " + payout + " gems in the puddle of spunge your " + cockDescript(0) + " created.</b>\n\n");
						}
					}
				}
				//No cock ending
				else {
					if (player.vaginas.length > 0)
						outputText("You sigh softly and drift off into a quick nap, smelling of sex."); //Girl ending
					else outputText("You sigh and drift off to sleep."); //Genderless ending
				}
			}
			if (inDungeon && DungeonAbstractContent.dungeonLoc != DungeonAbstractContent.DUNGEON_CABIN && player.companionsInPCParty()) {
				advanceMinutes(60);
				doNext(playerMenu);
			}
			else endEncounter();
		}

		//Genderless people suck!
		private function genderlessMasturbate():void {
			clearOutput();
			//Early prep
			doStripCheck();
			//Tit foreplay
			titForeplay();
			if (!player.hasStatusEffect(StatusEffects.FappedGenderless)) { //first time as a genderless person
				outputText("Now this might be a problem. Here you are ready to get your rocks off and you have no idea how to do it. Nothing to do except some trial and error. You run your hands gently over where your genitals would be. Lightly you pet the skin and feel your finger tips tickle what was once your most pleasurable of places. While it feels incredibly nice, it just isn't getting you there. You teeter at the edge and it only frustrates you further. Unsure of what to do next, your body gives you a little nudge in an unexplored avenue and you decide to take the trip.\n\n");
				player.createStatusEffect(StatusEffects.FappedGenderless, 0, 0, 0, 0);
			}
			//All times as a genderless person (possibly written for all genders perhaps not herm (not enough hands)) -
			outputText("Your " + assholeDescript() + " begins to twitch. It's practically crying out for attention.\n\n");
			outputText("You lay down on your side and reach gingerly behind yourself.  The palm of your hand comes to rest on your [ass].  You slide your finger into your crack and find your " + assholeDescript() + ".  You run your finger slowly around the sensitive ring of your hole and feel a tingle emanating from it. A smile creeps across your lips as you begin to imagine what is about to happen.\n\n");
			//For all parts of scene penetration type changes based on anus size '''any (if you do not want to do more than one variable) or virgin pucker or tight/normal/loose/gaping'''-
			//If no BioLube perk -
			if (player.ass.analWetness < 2) {
				outputText("Bringing your hand up to your mouth, you coat your ");
				if (player.ass.analLooseness <= 2)
					outputText("middle finger");
				else if (player.ass.analLooseness == 3)
					outputText("first two fingers");
				else outputText("hand");
				outputText(" in a generous helping of saliva and head back for your " + assholeDescript() + ".\n\n");
			}
			//If BioLube or continuing from no biolube -
			else {
				outputText("The lubrication you have created allows you to easily sink your finger");
				if (player.ass.analLooseness >= 3) outputText("s");
				outputText(" into your asshole. A shiver runs up your spine as you plunge ");
				if (player.ass.analLooseness <= 2)
					outputText("in all the way to your knuckle");
				else if (player.ass.analLooseness == 3)
					outputText("all the way to the first two knuckles");
				else if (player.ass.analLooseness == 4)
					outputText("your three knuckles");
				else outputText("your four fingers in deep");
				outputText(". Slowly you begin to push and pull your finger");
				if (player.ass.analLooseness >= 3) outputText("s");
				outputText(" in and out of your anus. A slight moan escapes you as you begin to pick up pace.\n\n");
			}
			//If gaping -
			if (player.ass.analLooseness == 5) {
				outputText("A devilish thought crosses your mind. You have taken into yourself all manner of beasts and beings. There is only one real way to achieve the pleasure you have gotten from them on your own. You slowly force your whole hand into your " + assholeDescript() + " and are greeted with a fullness that you never thought you would achieve without assistance. As you move in and out you begin to slowly close your hand into a fist and open it up again over and over.\n\n");
			}
			//All scene types -
			outputText("Pleasure begins to fill your body with warmth. You deliberately start to twist your hand as you pump your pleasure hole with a deep desire. Your asshole begins to violently open and close around your invading ");
			if (player.ass.analLooseness <= 2)
				outputText("digit");
			else if (player.ass.analLooseness < 5)
				outputText("digits");
			else outputText("hand");
			outputText(" as your toes curl and an orgasm wracks your body.");
			//If BioLube perk -
			if (player.ass.analWetness >= 2) {
				outputText("  You withdraw your ");
				if (player.ass.analLooseness <= 2)
					outputText("finger");
				else if (player.ass.analLooseness < 5)
					outputText("fingers");
				else outputText("hand");
				outputText(" and see it coated in the warm lube you produce. The scent and ecstasy you are in drive you over the edge and you begin to lick what once was inside you clean. Another orgasm drills through you and your body shakes for several seconds.");
				//Still Horny -
				if (player.lib >= 75)
					outputText("\n\nRolling over, you fall to sleep while your hole drips and twitches, ensuring your dreams to be filled with the most erotic of thoughts.");
				else outputText("\n\nRolling over, you are completely spent and fall to sleep while your well-worked hole drips.");
			}
			//No BioLube perk -
			else {
				outputText("  You withdraw your ");
				if (player.ass.analLooseness <= 2)
					outputText("finger");
				else if (player.ass.analLooseness < 5)
					outputText("fingers");
				else outputText("hand");
				outputText(" and dry ");
				if (player.ass.analLooseness <= 2)
					outputText("it");
				else if (player.ass.analLooseness < 5)
					outputText("them");
				else outputText("it");
				outputText(" off.");
				//Still Horny -
				if (player.lib > 75)
					outputText("  Satisfied, you roll over and drift off to sleep. Your hole remains warm, ready for another round.");
				else outputText("  Satisfied, you roll over and drift off to sleep.");
			}
		}

		private function titForeplay():void {
			//Ok lets touch our boobies if we haz them and they are big enough
			if (player.breastRows.length == 1 && player.biggestTitSize() > 3) {
				if (player.lib < 45)
					outputText("You caress your [breasts] gently with your fingers");
				else if (player.lib < 70)
					outputText("You grope your [breasts] agressively with both hands");
				else outputText("You squeeze your [breasts] brutally with both hands");
			}
			else if (player.breastRows.length > 1 && player.biggestTitSize() > 3) {
				if (player.lib < 45)
					outputText("You hesitantly run your hands across your front, caressing each of your " + num2Text(player.totalBreasts()) + " breasts in turn. ");
				else if (player.lib < 70)
					outputText("You run your hands across your front, squeezing each of your " + num2Text(player.totalBreasts()) + " breasts in turn. ");
				else outputText("You aggressively run your hands across your front, groping each of your " + num2Text(player.totalBreasts()) + " breasts in turn. ");
				//different attitude based on player.corruption (ashamed/feels too good to care/reveling in how fucked up you are)
				if (player.cor <= 25)
					outputText("You blink back tears of shame as you experience the tactile proof of your abnormal endowments, unable to resist mashing your [allbreasts] together");
				else if (player.cor < 75)
					outputText("Though a small part of you is horrified by your abnormal endowments, it doesn't stop you from mashing your [allbreasts] together");
				else outputText("The tactile reminder of your abnormal endowments gives you a delicious thrill.  You sigh and mash your tits together");
			}
			//If nips are fuckable
			if (player.hasFuckableNipples() && player.biggestTitSize() > 3) {
				//more than one row?
				if (player.breastRows.length >= 1) outputText(" as you move your attention to your nipples");
				//Different attitude based on libido
				if (player.lib < 60)
					outputText(". Hesitantly, you rub your fingers across the ");
				else outputText(". Eagerly, you begin to roughly stroke the ");
				//Different description based on vag looseness
				if (player.averageVaginalLooseness() < 2)
					outputText("small, delicate openings at the tip of each nipple. ");
				else if (player.averageVaginalLooseness() < 4)
					outputText("puckered holes at the tip of each nipple. ");
				//add "many if lots of nips
				else if (player.averageNipplesPerBreast() > 1)
					outputText("many ");
				else outputText("swollen, cunt-like lips that top each breast. ");
				//Different noise based on sensitivity
				if (player.sens < 45)
					outputText("You sigh contentedly as ");
				else if (player.sens < 70)
					outputText("You moan lewdly as ");
				else outputText("You squeal with pleasure as ");
				//Different description based on wetness
				if (player.averageVaginalWetness() < 2)
					outputText("you feel your nipples loosen up. ");
				else if (player.averageVaginalWetness() < 4)
					outputText("you begin to slowly spread the slippery secretions leaking from your engorged nipples all over your [breasts]. ");
				else {
					outputText("little spurts of ");
					//Lactating?
					if (player.averageLactation() > 0) outputText(" milky ");
					outputText("girlcum squirt out of your engorged nipples. ");
				}
				//Special extras for lactation
				if (player.averageLactation() > 0 && player.averageLactation() < 2)
					outputText("Your freakish mammaries drip a sticky combination of cunt-juice and milk, spattering your [legs] and crotch.");
				else if (player.averageLactation() < 3)
					outputText("Your freakish mammaries leak thin streams of sticky girlcum mixed with milk all over your [legs] and crotch.");
				else outputText("Your freakish mammaries constantly drool a steady stream of milky cunt-juice, drenching your [legs] and crotch in milky goo.");
			}
			//If nipples aren't fuckable.
			else if (player.breastRows.length > 0 && player.biggestTitSize() > 3) {
				outputText(", emitting ");
				//different noises depending on sensitivity
				if (player.sens < 45)
					outputText("soft gasps of pleasure each time you flick one of your ");
				else if (player.sens < 70)
					outputText("loud moans of pleasure each time you flick one of your ");
				else outputText("squeals of pleasure each time you flick one of your ");
				//extra bit if you have LOTS of nipples
				if (player.totalNipples() > 2) outputText("many ");
				//different description based on size of nips
				if (player.lust >= 50) {
					if (player.biggestLactation() > 2)
						outputText("huge, swollen nipples. ");
					else if (player.biggestLactation() > 1)
						outputText("fat, puckered nipples. ");
					else outputText("erect nipples. ");
				}
				else outputText("nipples.  ");
				//Special extras if lactating
				if (player.biggestLactation() > 1 && player.biggestLactation() < 2)
					outputText("Droplets of milk dribble from each nipple, spattering milk onto your [legs] and crotch.  ");
				else if (player.biggestLactation() < 3 && player.biggestLactation() >= 2)
					outputText("Thin squirts of milk spray from each nipple, spattering milk onto your [legs] and crotch.  ");
				else if(player.biggestLactation() >= 3) outputText("A constant stream of milk drizzles from each teat, soaking your [legs] and crotch.  ");
			}
		}

		private function titFuckSingle():void
		{
			//different based on player.libido
			if (player.lib < 45)
				outputText("You grip your [cock] and begin cautiously guiding it towards ");
			else if (player.lib < 70) {
				outputText("Shivering with anticipation, you place the ");
				switch (player.cocks[0].cockType) { //Different way of choosing cock to use, results in consistent description of cock[0]
					case CockTypesEnum.ANEMONE:
					case CockTypesEnum.DISPLACER:
						outputText("wriggling ");
						break;
					case CockTypesEnum.DEMON:
						outputText("bump-encircled ");
						break;
					case CockTypesEnum.DOG:
					case CockTypesEnum.FOX:
						outputText("pointed ");
						break;
					case CockTypesEnum.HORSE:
						outputText("flared ");
						break;
					case CockTypesEnum.TENTACLE:
						outputText("bulbous ");
				}
				outputText("tip of your [cock] against the opening of ");
			}
			else {
				outputText("Without hesitation, you shove the ");
				switch (player.cocks[0].cockType) { //Different way of choosing cock to use, results in consistent description of cock[0]
					case CockTypesEnum.ANEMONE:
						outputText("tentacle-laden mushroom that is ");
						break;
					case CockTypesEnum.DEMON:
						outputText("bump-ringed monstrosity that is ");
						break;
					case CockTypesEnum.DISPLACER:
						outputText("opened top of ");
						break;
					case CockTypesEnum.DOG:
					case CockTypesEnum.FOX:
						outputText("pointed tip of ");
						break;
					case CockTypesEnum.HORSE:
						outputText("engorged flare of ");
						break;
					case CockTypesEnum.HUMAN:
						outputText("tip of ");
						break;
					case CockTypesEnum.TENTACLE:
						outputText("over-sized mushroom that is ");
						break;
					default:
						outputText(player.cockHead() + " of ");
				}
				outputText("your [cock] into ");
			}
			//More than one row?
			if (player.breastRows.length > 1)
				outputText("one of the ");
			else outputText("one of your ");
			//More than 1 nip per boob?
			if (player.averageNipplesPerBreast() > 1) outputText("many ");
			//Different based on looseness (again)
			if (player.averageVaginalLooseness() < 2)
				outputText("painfully stretched nipples");
			else if (player.averageVaginalLooseness() < 4)
				outputText("freakishly swollen nipples");
			else outputText("huge, bloated cunt-nipples");
			if (player.breastRows.length > 1) outputText(" on one of your lower breasts");
			outputText(". ");
			//How wet/milky is this procedure?
			if (player.averageLactation() == 0) {
				if (player.averageVaginalWetness() < 2)
					outputText("Y");
				else if (player.averageVaginalWetness() < 4) {
					outputText("Slick juices dribble ");
					switch (player.cocks[0].cockType) { //Different way of choosing cock to use, results in consistent description of cock[0]
						case CockTypesEnum.ANEMONE:
							outputText("over the nearly transparent skin of ");
							break;
						case CockTypesEnum.CAT:
							outputText("over the pink, spiny protrusions that cover ");
							break;
						case CockTypesEnum.DEMON:
							outputText("down the shiny purplish skin and nodules of ");
							break;
						case CockTypesEnum.DISPLACER:
							outputText("over the dusky purple of ");
							break;
						case CockTypesEnum.DOG:
						case CockTypesEnum.FOX:
							outputText("down the red, shiny skin of ");
							break;
						case CockTypesEnum.HORSE:
							outputText("down the mottled skin of ");
							break;
						case CockTypesEnum.LIZARD:
						case CockTypesEnum.CAVE_WYRM:
							outputText("down the bumpy purple skin of ");
							break;
						case CockTypesEnum.TENTACLE:
							outputText("down the rubbery skin of ");
							break;
						default:
							outputText("down the skin of ");
					}
					outputText("your [cock] and y");
				}
				else outputText("Slick juices squirt out from around your [cock] and y");
			}
			else {
				if (player.averageLactation() < 2) {
					outputText("Rivulets of milky girlcum drizzle ");
					switch (player.cocks[0].cockType) { //Different way of choosing cock to use, results in consistent description of cock[0]
						case CockTypesEnum.ANEMONE:
							outputText("and drip from the many tiny tentacles of ");
							break;
						case CockTypesEnum.CAT:
							outputText("down the spiny, pink flesh of ");
							break;
						case CockTypesEnum.DEMON:
							outputText("down the shiny purplish skin and nodules of ");
							break;
						case CockTypesEnum.DISPLACER:
							outputText("over the purplish, knotted flesh of ");
							break;
						case CockTypesEnum.DOG:
						case CockTypesEnum.FOX:
							outputText("down the red, shiny skin of ");
							break;
						case CockTypesEnum.HORSE:
							outputText("down the mottled skin of ");
							break;
						case CockTypesEnum.HUMAN:
							outputText("down the skin of ");
							break;
						case CockTypesEnum.LIZARD:
						case CockTypesEnum.CAVE_WYRM:
							outputText("over the purplish, bumpy flesh of ");
							break;
						case CockTypesEnum.TENTACLE:
							outputText("down the rubbery skin of ");
							break;
						default:
							outputText("over the sensitive skin of ");
					}
					outputText("your [cock] and y");
				}
				else {
					outputText("Milky girlcum squirts out from around your [cock], staining ");
					switch (player.cocks[0].cockType) { //Different way of choosing cock to use, results in consistent description of cock[0]
						case CockTypesEnum.ANEMONE:
							outputText("the odd aquatic shaft white.  Y");
							break;
						case CockTypesEnum.CAT:
							outputText("the pink kitty-skin white.  Y");
							break;
						case CockTypesEnum.DEMON:
							outputText("its purplish-skin white.  Y");
							break;
						case CockTypesEnum.DISPLACER:
							outputText("purple, knotty flesh white.  Y");
							break;
						case CockTypesEnum.DOG:
						case CockTypesEnum.FOX:
							outputText("its shiny skin white.  Y");
							break;
						case CockTypesEnum.HORSE:
							outputText("its mottled skin white.  Y");
							break;
						case CockTypesEnum.HUMAN:
							outputText("it white.  Y");
							break;
						case CockTypesEnum.LIZARD:
						case CockTypesEnum.CAVE_WYRM:
							outputText("purple, bumpy flesh white.  Y");
							break;
						case CockTypesEnum.TENTACLE:
							outputText("its rubbery skin white.  Y");
							break;
						default:
							outputText("its length white.  Y");
					}
				}
			}
			//Round and compare cock thickness to vag looseness
			if (Math.round(player.biggestCockArea()) >= player.vaginalCapacity()) {
				//Different noises based on sensitivity
				if (player.sens < 45)
					outputText("ou grunt with exertion as you attempt to stuff your [cock] into ");
				else if (player.sens < 70)
					outputText("ou blink back tears as you attempt to stuff your [cock] into ");
				else outputText("ou scream with a combination of pain and pleasure as you attempt to stuff your [cock] into ");
				//Different based on looseness
				if (player.averageVaginalLooseness() < 2)
					outputText("the small, over-stretched opening of your swollen nipple. ");
				else if (player.averageVaginalLooseness() < 4)
					outputText("the engorged and distended opening of your fat, swollen nipple. ");
				else outputText("the gaping fuck-mouth of your inhuman nipple-cunt. ");
				//Compare cockthickness and vaglooseness more specifically
				//if it barely fits
				if (Math.round(player.biggestCockArea()) == player.vaginalCapacity()) {
					if (player.averageVaginalLooseness() < 2)
						outputText("Your poor, tortured nipple is barely up to the task of accepting the [cock], but accept it it does. ");
					else if (player.averageVaginalLooseness() < 4)
						outputText("The engorged opening at the end of your swollen nipple is stretched to its limit as you shove your [cock] home. ");
					else {
						switch (player.cocks[0].cockType) { //Different way of choosing cock to use, results in consistent description of cock[0]
						case CockTypesEnum.ANEMONE:
							outputText("The swollen tips of your bloated nipple wrap around the stinging tentacles that surround your [cock]'s tip, convulsing with wet squishing sounds as they become red and enflamed with artificial lust.  ");
							break;
						case CockTypesEnum.CAT:
							outputText("The swollen tips of your bloated nipples stretch around the barbed tip of your [cock], swallowing it like an enormous mouth.  ");
							break;
						case CockTypesEnum.DEMON:
							outputText("The swollen lips of your bloated nipple stretch around the nodule-ringed tip of your [cock], swallowing it like an enormous mouth.  ");
							break;
						case CockTypesEnum.DISPLACER:
							outputText("The swollen tips of your bloated nipple wrap around the outstretched head of your [cock], convulsing with wet, squishing sounds as it wriggles inside you.  ");
							break;
						case CockTypesEnum.DOG:
						case CockTypesEnum.FOX:
							outputText("The swollen lips of your bloated nipple stretch around the pointed tip of your [cock] swallowing it like an enormous mouth.  ");
							break;
						case CockTypesEnum.HORSE:
							outputText("The swollen lips of your bloated nipple stretch around the flared tip of your [cock] swallowing it like an enormous mouth.  ");
							break;
						case CockTypesEnum.HUMAN:
							outputText("The swollen lips of your bloated nipple stretch around the tip of your [cock] swallowing it like an enormous mouth.  ");
							break;
						case CockTypesEnum.LIZARD:
						case CockTypesEnum.CAVE_WYRM:
							outputText("The swollen tips of your bloated nipple wrap around the pointed tip of your [cock], stretching oddly as it swallows the knot-covered appendage.  ");
							break;
						case CockTypesEnum.TENTACLE:
							outputText("The swollen lips of your bloated nipple stretch around the rounded tip of your [cock], swallowing it like an enormous mouth.  ");
							break;
							default:
								outputText("tips of your bloated nipples wrap around the [cockhead] of your [cock], swallowing it like an enormous mouth.  ");
						}
					}
					outputText("With each thrust, you bury your [cock] deeper into your greedy tit. Overwhelmed by the combined sensations, your mind is barely able to cope with the intense feeling of fullness where no such feeling should be possible.");
				}
				//if it doesnt really fit
				if (Math.round(player.biggestCockArea()) > player.vaginalCapacity()) {
					if (player.averageVaginalLooseness() < 2)
						outputText("Your poor, tortured nipple is woefully insufficient compared to your [cock], delerious with arousal, you keep trying anyway. ");
					else if (player.averageVaginalLooseness() < 4)
						outputText("The engorged opening at the end of your swollen nipple is stretched to its limits and beyond as you shove your [cock] home. ");
					else {
						switch (player.cocks[0].cockType) { //Different way of choosing cock to use, results in consistent description of cock[0]
						case CockTypesEnum.ANEMONE:
							outputText("The swollen lips of your bloated nipple gape wide, but the stinging tip of your [cock] spreads them wider and fills them with artificial lust.  ");
							break;
						case CockTypesEnum.CAT:
							outputText("The swollen lips of your bloated nipple gape wide, but the barbed tip of your [cock] spreads them even wider.  ");
							break;
						case CockTypesEnum.DEMON:
							outputText("The swollen lips of your bloated nipple gape wide, but the tip of your [cock] spreads them even wider.  ");
							break;
						case CockTypesEnum.DISPLACER:
							outputText("The swollen lips of your bloated nipple gape wide, but the wide head of your [cock] spreads them even wider.  ");
							break;
						case CockTypesEnum.DOG:
						case CockTypesEnum.FOX:
							outputText("The swollen lips of your bloated nipple gape wide, but the massive girth of your [cock] spreads them even wider.  ");
							break;
						case CockTypesEnum.HORSE:
							outputText("The swollen lips of your bloated nipple gape wide, but the flared tip of your [cock] spreads them even wider.  ");
							break;
						case CockTypesEnum.HUMAN:
							outputText("The swollen lips of your bloated nipple gape wide, but the tip of your [cock] spreads them even wider.  ");
							break;
						case CockTypesEnum.LIZARD:
						case CockTypesEnum.CAVE_WYRM:
							outputText("The swollen lips of your bloated nipple gape wide, but the pointed tip of your [cock] slowly spreads them even wider.  ");
							break;
						case CockTypesEnum.TENTACLE:
							outputText("The swollen lips of your bloated nipple gape wide, but the tip of your [cock] spreads them even wider.  ");
							break;
							default:
								outputText("The swollen lips of your bloated nipple gape wide, but the [cockhead] of your [cock] spreads them even wider.  ");
						}
					}
					outputText("Grunting and sweating with effort, you stuff as much of your [cock] into your overstretched nipple as you can fit. The feeling of incredible tightness around your [cock] combines with the pain of your distended nipple to form a mindbending sensation that makes your head spin. ");
				}
				if (player.averageLactation() > 0)
					outputText("Milky ");
				else outputText("Slick ");
				if (player.averageVaginalWetness() < 2) outputText("girl-lube quickly coats the whole length of your [cock] in a glistening layer of fuck juice. " );
				else if (player.averageVaginalWetness() < 4) {
					outputText("girl-lube drizzles down the length of your [cock] in thick streams, ");
					switch (player.cocks[0].cockType) { //Different way of choosing cock to use, results in consistent description of cock[0]
						case CockTypesEnum.ANEMONE:
							outputText("pooling around the wriggling tentacles near your base.  ");
							break;
						case CockTypesEnum.CAT:
							outputText("pooling around the spines near your base.  ");
							break;
						case CockTypesEnum.DEMON:
							outputText("pooling around the base of your member.  ");
							break;
						case CockTypesEnum.DISPLACER:
						case CockTypesEnum.DOG:
						case CockTypesEnum.FOX:
							outputText("pooling around the bulb near your base.  ");
							break;
						case CockTypesEnum.HORSE:
							outputText("pooling in and around your sheath.  ");
							break;
						case CockTypesEnum.LIZARD:
						case CockTypesEnum.CAVE_WYRM:
							outputText("pooling around the bulbs near your base.  ");
							break;
						case CockTypesEnum.TENTACLE:
							outputText("mixing with the tentacles own lubricants.  ");
							break;
						default:
							outputText("pooling at your crotch.  ");
					}
				}
				else outputText("girl-lube spurts out of your tortured nipple with each thrust of your [cock], spattering your arms and face with your secretions. ");
			}
			if (Math.round(player.biggestCockArea()) < player.vaginalCapacity()) {
				//Different noises based on sensitivity
				if (player.sens < 45)
					outputText("ou sigh with pleasure");
				else if (player.sens < 70)
					outputText("ou moan with pleasure");
				else outputText("ou scream with delight");
				outputText(" as your [cock] slides into ");
				//Different based on looseness
				if (player.averageVaginalLooseness() < 2)
					outputText("the small, over-stretched opening of your swollen nipple. Your [cock] penetrates your swollen nipple easily, sliding halfway in on your first thrust. ");
				else if (player.averageVaginalLooseness() < 4)
					outputText("the engorged and distended opening of your fat, swollen nipple. Your [cock] plunges deeply into your freakishly engorged nipple, penetrating it easily. ");
				else {
					outputText("the gaping fuck-mouth of your inhuman nipple-cunt.  The swollen lips of your bloated nipple engulf the ");
					if (player.cocks[0].cockType == CockTypesEnum.HORSE) outputText("flared ");
					outputText("tip of your [cock] and begin to slide down its length, ");
					switch (player.cocks[0].cockType) { //Different way of choosing cock to use, results in consistent description of cock[0]
						case CockTypesEnum.ANEMONE:
							outputText("swallowing it completely and leaving a searing trail of desire in its wake.  ");
							break;
						case CockTypesEnum.CAT:
							outputText("swallowing it completely as each springy barb makes you quiver with pleasure.  ");
							break;
						case CockTypesEnum.DEMON:
							outputText("swallowing it completely as each bump and nodule makes you quiver with unholy pleasures.  ");
							break;
						case CockTypesEnum.DISPLACER:
						case CockTypesEnum.DOG:
						case CockTypesEnum.FOX:
							outputText("even swallowing your bulging knot without difficulty.  ");
							break;
						case CockTypesEnum.LIZARD:
						case CockTypesEnum.CAVE_WYRM:
							outputText("swallowing it completely as each of the bulgy knots along its length stretch the orifice further.  ");
							break;
						case CockTypesEnum.TENTACLE:
							outputText("swallowing it completely as it twists and pulses on its own, fucking your nipple.  ");
							break;
						default:
							outputText("swallowing it completely.  ");
					}
				}
				outputText("You revel in the sensation as you slowly stroke your [cock] in and out of your distended nipple. Your shaft is enveloped in the warm, wet embrace of your freakish tit, and ");
				if (player.averageLactation() > 0)
					outputText("milky ");
				else outputText("slippery ");
				if (player.averageVaginalWetness() < 2)
					outputText("girl-lube quickly coats the whole length of your [cock] in a glistening layer of fuck juice. " );
				else if (player.averageVaginalWetness() < 4)
					outputText("girl-lube drizzles down the length of your [cock] in thick streams, pooling at your crotch. ");
				else {
					if (player.normalCocks() > 0)
						outputText("girl-lube pours out of your swollen nipple over your [cock] and hands, pooling on the ground below you. ");
					else if (player.hasSheath() > 0)
						outputText("girl-lube drizzles down the length of your [cock] in thick streams, pooling in and around your sheath. ");
					else if (player.tentacleCocks() > 0 || player.stamenCocks() > 0)
						outputText("girl-lube pours out of your swollen nipple over your [cock] and hands, pooling on the ground below you. ");
					else if (player.demonCocks() > 0)
						outputText("girl-lube pours out of your swollen nipple over your [cock] and hands, pooling on the ground below you. ");
					else outputText("girl-lube pours out of your swollen nipple over your [cock] and hands, pooling on the ground below you. ");
				}
			}
		}

		private function multiTitFuck():Boolean {
			var holeTotal:int = player.totalNipples();
			var fittableCocks:int = player.cocks.length;
			var doubleUp:Boolean = false;
			//randomize what kind of dick to start with
			var randomCock:int = rand(fittableCocks);
			multiNippleFuckPrep(randomCock);
			//Now deal with the rest of your dicks in more general terms
			//Just how many cocks are we dealing with here?
			if (holeTotal >= fittableCocks) {
				if (fittableCocks == 2) //only two dicks total
					outputText("Quickly, you move your other cock into position against ");
				else if (fittableCocks == 2 || holeTotal == 2) //more than two dicks but only two that fit, or if you have only two holes anyway
					outputText("Quickly, you move another cock into position against ");
				else if (holeTotal >= fittableCocks) //If you have more than two dicks to use, and enough nipples for all of them
					outputText("Quickly, you move your remaining shafts into position against your other nipples. ");
				//How many nips?
				if (holeTotal == 2)
					outputText("your other nipple. ");
				else if (fittableCocks <= 2)
					outputText("one of your other nipples. ");
			}
			//if you dont have enough nipples for all your dicks
			if (fittableCocks > 2 && holeTotal < fittableCocks) {
				outputText("You are momentarily stumped as you realize that you don't have enough nipples for all of your cocks. ");
				//can you fit more than one in each?
				if (player.vaginalCapacity() >= 2 * player.cockArea(randomCock)) {
					doubleUp = true;//WTF IS MULTIDIVISICATION?  SERIOUSLY?
					outputText("The words \"multiple insertions\" drifts through your lust-fogged brain, and you begin to position two dicks against a poor, unsuspecting nipple, preparing to double-penetrate.  ");
					//does this give enough space?
					if (2 * holeTotal >= fittableCocks)
						outputText("You giggle with glee as you realize that you will be able to jam every single one of your [cocks] into your abused nipples, thanks to double-penetration! ");
					else outputText("With a flash of irritation, you realize that even if you stick two cocks in each hole, you still won't be able to fit all " + num2Text(player.cocks.length) + " of your dicks into your abused tits. Deciding to make the best of it, you prepare to stuff in as many as you can. ");
				}
				else outputText("Accepting that you can't do anything about it, you start pushing. ");
			}
			//How wet/milky is this procedure?
			if (player.averageLactation() == 0) {
				if (player.averageVaginalWetness() < 2)
					outputText("Y");
				else if (player.averageVaginalWetness() < 4)
					outputText("Slick juices dribble down your shafts, and y");
				else outputText("Slick juices squirt out from around your shafts and y");
			}
			else {
				if (player.averageLactation() < 2)
					outputText("Rivulets of milky girlcum drizzle down your shafts and y");
				else outputText("Milky girlcum squirts out from around your shafts, staining them white. Y");
			}
			//Round and compare cock thickness to vag looseness
			if (Math.round(player.cockArea(randomCock)) >= player.vaginalCapacity()) {
				//Different noises based on sensitivity
				if (player.sens < 45)
					outputText("ou grunt with exertion as you attempt to stuff your cocks into ");
				else if (player.sens < 70)
					outputText("ou blink back tears as you attempt to stuff your cocks into ");
				else outputText("ou scream with a combination of pain and pleasure as you attempt to stuff your cocks into ");
				//Different based on looseness
				if (player.averageVaginalLooseness() < 2)
					outputText("the small, over-stretched openings of your swollen nipples. ");
				else if (player.averageVaginalLooseness() < 4)
					outputText("the engorged and distended openings of your fat, swollen nipples. ");
				else outputText("the gaping fuck-mouths of your inhuman nipple-cunts. ");
				//Compare cockthickness and vaglooseness more specifically
				//if it barely fits
				if (Math.round(player.cockArea(randomCock)) == player.vaginalCapacity()) {
					if (player.averageVaginalLooseness() < 2)
						outputText("Your poor, tortured nipples are barely up to the task of accepting your swollen rods, but accept them they do. ");
					else if (player.averageVaginalLooseness() < 4)
						outputText("The puckered openings that cap your engorged nipples are stretched to their limits as you shove your fat rods home. ");
					else outputText("The swollen lips of your bloated nipples stretch around your throbbing cocks, swallowing them whole. ");
					outputText("With each thrust, you bury your shafts deeper into your greedy tits. Overwhelmed by the combined sensations, your mind is barely able to cope with the intense feelings of fullness where no such feelings should be possible. ");
				}
				//if it doesnt really fit well
				if (Math.round(player.cockArea(randomCock)) > player.vaginalCapacity()) {
					if (player.averageVaginalLooseness() < 2)
						outputText("Your poor, tortured nipples are woefully insufficient compared to the width of your swollen rods. Delirious with arousal, you keep pushing them in anyway. ");
					else if (player.averageVaginalLooseness() < 4)
						outputText("The puckered openings that cap your engorged nipples are stretched to their limits and beyond as you shove your fat rods home. ");
					else outputText("The swollen lips of your bloated nipples gape wide, but the enormous girth of your throbbing members spread them even wider. ");
					outputText("Grunting and sweating with effort, you stuff as much cock into each of your overstretched nipples as you can fit. The feeling of incredible tightness around your tools combines with the pain of your distended nipples to form a blizzard of mindbending sensations that makes your head spin. ");
				}
				if (player.averageLactation() > 0)
					outputText("Milky ");
				else outputText("Slick ");
				if (player.averageVaginalWetness() < 2)
					outputText("girl-lube drizzles down your shafts, coating them in glistening layers of fuck juice. " );
				else if (player.averageVaginalWetness() < 4)
					outputText("girl-lube drools from your tortured nipples in thick streams, pooling beneath your ass. ");
				else outputText("girl-lube spurts out of your tortured nipples with each thrust of your hips, spattering your arms and face with your secretions. ");
			}
			if (Math.round(player.cockArea(randomCock)) < player.vaginalCapacity()) {
				if (!doubleUp) {
					//Different noises based on sensitivity
					if (player.sens < 45)
						outputText("ou sigh with pleasure as your stiff cocks slide into ");
					else if (player.sens < 70)
						outputText("ou moan with pleasure as your stiff cocks slide into ");
					else outputText("ou scream with delight as your stiff cocks slide into ");
					//Different based on looseness
					if (player.averageVaginalLooseness() < 2)
						outputText("the small, over-stretched openings on your swollen nipples. Your hard rods penetrate your engorged nipples easily, sliding halfway in on your first thrust. ");
					else if (player.averageVaginalLooseness() < 4)
						outputText("the engorged and distended openings on your fat, swollen nipples. Your hard rods plunge deeply into your freakishly engorged nipples, penetrating them easily. ");
					else outputText("the gaping fuck-mouths of your inhuman nipple-cunts. The swollen lips of your bloated nipples engulf your hard rods and begin to slide down their length, swallowing them completely. ");
					outputText("You revel in the sensation as you slowly stroke your shafts in and out of your distended nipples. Your cocks are enveloped in the warm, wet embrace of your freakish tits, and ");
					if (player.averageLactation() > 0)
						outputText("milky ");
					else outputText("slippery ");
					if (player.averageVaginalWetness() < 2)
						outputText("girl-lube drizzles down your shafts, coating them in glistening layers of fuck juice. " );
					else if (player.averageVaginalWetness() < 4)
						outputText("girl-lube drools from your fat nipples in thick streams, pooling beneath your ass. ");
					else outputText("girl-lube pours out of your swollen nipples in a constant deluge of sticky fluid, creating a large puddle beneath you. ");
				}
				else {
					//Different noises based on sensitivity
					if (player.sens < 45)
						outputText("ou sigh with pleasure as your stiff cocks slide into ");
					else if (player.sens < 70)
						outputText("ou moan with pleasure as your stiff cocks slide into ");
					else outputText("ou scream with delight as your stiff cocks slide into ");
					//if you have really small dicks or HUGE nipples - THIS I LIKE
					if (4 * Math.round(player.averageCockThickness()) < player.averageVaginalLooseness()) {
						if (player.averageVaginalLooseness() < 2)
							outputText("the over-stretched openings on your swollen nipples. Though they are reletively small and delicate, you can easily slide two of your tiny cocks into each of their slippery passages.");
						else if (player.averageVaginalLooseness() < 4)
							outputText("the engorged and distended openings on your fat, swollen nipples. Stretching easily, they can engulf two cocks each with surprising ease, stretching around your turgid rods with little difficulty. ");
						else outputText("the gaping fuck-mouths of your inhuman nipple-cunts. The swollen lips of your bloated nipples squish open as they swallow your fat dicks with little difficulty. ");
						outputText("With each thrust, you bury your shafts deeper into your greedy tits. The feeling of your cocks rubbing together inside the warm, wet embrace of your inhuman breasts pushes you towards the edge of insanity, and you are briefly unable to comprehend the world around you. ");
					}
					else { //otherwise, its a tight fit
						if (player.averageVaginalLooseness() < 2)
							outputText("the small, over-stretched openings on your swollen nipples. Your poor, tortured nipples are stretched painfully as you cram two of your throbbing cocks into one. ");
						else if (player.averageVaginalLooseness() < 4)
							outputText("the engorged and distended openings on your fat, swollen nipples. They are stretched to their limits as you shove two of your fat dicks into one. ");
						else outputText("the gaping fuck-mouths of your inhuman nipple-cunts. The swollen lips of your bloated nipples are stretched to their limits as you push two of your fat dicks into one. ");
						outputText("Grunting and sweating with effort, you stuff as much cock into each of your overstretched nipples as you can fit. The feeling of your cocks being crushed together inside the warm, wet embrace of your inhuman breasts pushes you towards the edge of insanity, and you are briefly unable to comprehend the world around you. ");
					}
					if (player.averageLactation() > 0)
						outputText("Milky ");
					else outputText("Slick ");
					if (player.averageVaginalWetness() < 2)
						outputText("girl-lube drizzles down your shafts, coating them in glistening layers of fuck juice. " );
					else if (player.averageVaginalWetness() < 4)
						outputText("girl-lube drools from your tortured nipples in thick streams, pooling beneath your ass. ");
					else outputText("girl-lube spurts out of your tortured nipples with each thrust of your hips, spattering your arms and face with your secretions. ");
				}
			}
			//if your dog cocks wouldnt fit, or you had enough holes for all your dicks (potentailly doubled up) then there are no dicks left for you to suck. Return false
			return !((!doubleUp && fittableCocks <= holeTotal) || (doubleUp && fittableCocks <= holeTotal * 2));
		}

		private function multiNippleFuckPrep(randomCock:Number):void {
			//Start with some detail on one random cock
			//different based on libido
			if (player.lib < 70)
				outputText("Shivering with anticipation, you place the ");
			else outputText("Without hesitation, you shove the ");
			//I love it when the new code makes things simpler.
			//Applying randomization - normal cocks
			if (player.cocks[randomCock].cockType == CockTypesEnum.HUMAN) {
				outputText("tip of ");
				//more than one?
				if (player.normalCocks() > 1)
					outputText("one of your " + num2Text(player.normalCocks()) + " " + player.cockDescript(randomCock) + "s ");
				else outputText("your " + player.cockDescript(randomCock) + " ");
			}
			//Applying randomization - horse cocks
			if (player.cocks[randomCock].cockType == CockTypesEnum.HORSE) {
				outputText("flared tip of ");
				//more than one?
				if (player.horseCocks() > 1)
					outputText("one of your " + num2Text(player.horseCocks()) + " " + player.cockDescript(randomCock) + "s ");
				else outputText("your " + player.cockDescript(randomCock) + " ");
			}
			//Applying randomization - dog cocks
			if (player.cocks[randomCock].cockType == CockTypesEnum.DOG)
			{
				outputText("pointed tip of ");
				//more than one?
				if (player.dogCocks() > 1)
					outputText("one of your " + num2Text(player.dogCocks()) + " " + player.cockDescript(randomCock) + "s ");
				else outputText("your " + player.cockDescript(randomCock) + " ");
			}
			//Applying randomization - everything else
			if (player.cocks[randomCock].cockType.Index >= 3)
			{
				outputText("tip of ");
				//more than one?
				if (player.normalCocks() > 1)
					outputText("one of your " + num2Text(player.normalCocks()) + " " + player.cockDescript(randomCock) + "s ");
				else outputText("your " + player.cockDescript(randomCock) + " ");
			}
			if (player.lib < 70)
				outputText("against the opening of ");
			else outputText("into ");
			//More than one row?
			if (player.breastRows.length > 1) {
				if (player.averageNipplesPerBreast() > 1)
					outputText("one of the ");
				else outputText("the ");
			}
			else outputText("one of your ");
			if (player.averageNipplesPerBreast() > 1) outputText("many ");
			//Different based on looseness (again)
			if (player.averageVaginalLooseness() < 2)
				outputText("painfully stretched nipple");
			else if (player.averageVaginalLooseness() < 4)
				outputText("freakishly swollen nipple");
			else outputText("huge, bloated cunt-nipple");
			if (player.breastRows.length > 1)
				outputText(" on one of your lower breasts");
			else if (player.averageNipplesPerBreast() > 1)
				outputText("s");
			outputText(". ");
		}

		//ORGASM COOOOAD
		private function orgazmo(selfSucking:Boolean, nippleFuck:Boolean):void {
			outputText("\n\n");
			if (player.cocks.length > 0) {
				if (player.cocks.length == 1) {
					outputText("The sensations prove too much for you, and you feel the tightness building in your ");
					if (player.horseCocks() == 1)
						outputText("swollen equine sheath, slowly beginning to work its way up your shaft.  Pre-cum begins pouring from your [cock], slicking your [cock] as you get ready to blow.  ");
					else if (player.tentacleCocks() == 1 || player.stamenCocks() == 1)
						outputText("wiggling vine-like cock, growing rapidly.  You feel the rubbery surface of your tentacle prick contracting as it nears release.  Thick bulges of fluids collect and travel along the length of your [cock], the first of which is almost to your oversized tip.  ");
					else if (player.demonCocks() == 1)
						outputText("tainted man-meat, growing rapidly.  You feel the nodules close to the base swell and pulse, starting a rippling wave of pleasure that migrates upwards.  The ring of bumps around your crown double in size, flaring out as your [cock] prepares to unload.  ");
					else if (player.catCocks() == 1)
						outputText("full, cat-like sheath.  You feel it tingling and throbbing as the spines pulsate with arousal.  You feel the barbs at the bottom thickening as bulges of fluid migrate through your [cock] towards the tip.  ");
					else if (player.lizardCocks() == 1)
						outputText("swollen member.  You can feel it tingling and bulging strangly as it begins to contract and pulse.  Pre-cum leaks from your [cock] in a steady stream as each 'bulb' nearly doubles in size, and then one at a time, they deflate while your urethra dilates wide.  ");
					else if (player.anemoneCocks() == 1)
						outputText("base.  The tentacles surrounding your [cock] go nuts, constricting around it, inadvertently firing aphrodisiacs into the orgasmic flesh as they wring a potent, hip-jerking climax from you.  ");
					else if (player.hasKnot())
						outputText("swelling, bulbous knot.  You feel it growing tighter and tighter until it's nearly twice the width of your [cock].  The pressure is an agonizing pleasure that only builds higher and higher as you come closer and closer to orgasm.  ");
					else outputText("twitching manhood, growing rapidly.  You stroke furiously, feeling the pressure of your cum as it nears release.  ");
					outputText("Pleasurable spasms overwhelm you as cum erupts from your " + player.cockDescript());
					outputText(".  Your hips jerk in the air in time with your eruptions, spraying cum ");
					if (selfSucking) outputText("into your eager mouth.  ");
					if (nippleFuck)
						outputText("deep inside your unnatural breast. ");
					else if (!selfSucking)
						outputText("in the air.  ");
					if (selfSucking) {
						if (player.cumQ() < 25)
							outputText("You manage to gulp down most of your cum as it bursts from your loins, the pleasure of orgasm goading you into compulsively swallowing.  ");
						else if (player.cumQ() < 250)
							outputText("You sputter jism from your mouth as your orgasm becomes too much to keep up with, cum filling your mouth to capacity as you swallow and dribble in equal measure.  ");
						else if (player.cumQ() < 500)
							outputText("Pulse after pulse of cum erupts from your [cock] into your mouth.  You swallow what you can but it's too much for you.  Cum runs down your cock to pool on you as your orgasm drags on.  ");
						else outputText("Your orgasm never seems to end, and your world dissolves into the feelings from your [cock] as it erupts jet after jet of cum into your mouth.  You nearly gag, cum overflowing to spray out in a river, pooling around you.  ");
						//Refill hunger!
						if (player.cumQ() < 1000) player.refillHunger(player.cumQ() / 15);
						else if (player.cumQ() < 3000) player.refillHunger(50 + ((player.cumQ() - 1000) / 30));
						else player.refillHunger(100 + ((player.cumQ() - 3000) / 45));
					}
					else if (nippleFuck) {
						if (player.cumQ() < 25)
							outputText("You feel multiple thick spurts of cum splash against the inside of your breast. ");
						else if (player.cumQ() < 250)
							outputText("Cum dribbles down the length of your shaft as your abused tit is filled to overflowing by spurt after spurt of gooey sperm. ");
						else if (player.cumQ() < 500)
							outputText("Pulse after pulse of cum splash deep within your breast, causing it to swell with pressure. Cum runs down your cock in a torrent to pool on you as your orgasm drags on.  ");
						else outputText("Your orgasm never seems to end, and your world dissolves into the feelings from your [cock] as it erupts jet after jet of cum into your abused tit.  With a *pop*, your cock is forced free by the pressure. It continues to squirt semen everywhere, while a river of cum pours out of your dialated nipple, pooling around you.  ");
					}
					else {
						if (player.cumQ() < 25)
							outputText("A few thick spurts of cum burst from your loins, splattering you liberally.  ");
						else if (player.cumQ() < 250)
							outputText("The orgasm drags on and on, spurt after spurt of jism coating you.  ");
						else if (player.cumQ() < 500)
							outputText("Your body spasms powerfully, each spurt making you twitch more powerfully than the last.  Rope after rope of jizz rains down.  ");
						else outputText("The orgasm never seems to end, and your world dissolves to little more than the feeling of each jet of cum erupting from your cock.  Your mind dimly processes the feeling of each burst splattering over you, but it only enhances the feeling.  ");
					}
					if (player.armor == armors.GOOARMR) outputText("Your seed gets absorbed into your gooey covering.  ");
				}
				//MULTICOCK
				if (player.cocks.length > 1) {
					outputText("The sensations prove too much for you, and you feel the tightness building in your loins.  ");
                    var multiTypedIndex:int;

					if ((multiTypedIndex = player.findCockWithType(CockTypesEnum.HORSE)) >= 0) { //Primary Horse
						outputText("You feel a pulsing in your sheath, slowly working its way up your " + player.cockDescript(multiTypedIndex) + "s.  Pre-cum pours from your " + player.cockDescript(multiTypedIndex) + "s, slicking the wobbly equine shafts as they get ready to blow.  ");
					}
                    else if ((multiTypedIndex = player.findCockWithType(CockTypesEnum.DOG, 1, -1, -1, "area", 1)) >= 0) { //Primary Dog
						outputText("Your feel your knots bulging and swelling, growing tighter and tighter until they're nearly double the width of a " + player.cockDescript(multiTypedIndex) + ".  The agonizing pressure builds higher and tighter with every passing second as you get closer and closer to orgasm.  ");
					}
					else { //Primary Normal
						outputText("Your manhoods twitch, growing to their full size.  You stroke them furiously, feeling the pressure of your cum as it nears release.  ");
					}
					//check if all dicks are stuck in tits.
					if (nippleFuck) {
						if (player.cumQ() < 25)
							outputText("You feel multiple thick spurts of cum splash inside of your breasts. As you buck and thrust with orgasm, your cocks begin to pop free of your abused tits. ");
						else if (player.cumQ() < 250)
							outputText("Cum dribbles down your shafts as your abused tits are filled to overflowing by spurt after spurt of gooey sperm. As you buck and thrust with orgasm, your cocks begin to pop free of your abused tits. ");
						else if (player.cumQ() < 500)
							outputText("Pulse after pulse of cum splash deep within your breasts, causing them to swell with pressure. Torrents of cum run down your cocks to pool around you. As you buck and thrust with orgasm, your cocks begin to pop free of your abused tits.  ");
						else outputText("With an explosive release, you finally cum.  Your orgasm never seems to end, and your world dissolves into the feelings from your [cocks] as they erupt jet after jet of cum into your abused tits.  With a series of wet *pops*, your cocks are forced free by the pressure. They continue to squirt semen everywhere, while rivers of cum pour out of your dilated nipples, pooling around you.  ");
					}

					//Doing the perverted sprinkler after dicks have popped out.
					outputText("Pleasure overwhelms your fragile mind as cum erupts from your [cocks].  Your hips jerk in the air in time with your eruptions, cum spraying from you as your body does its best impression of a perverted sprinkler.  ");
					if (selfSucking) {
						if (player.cumQ() < 25)
							outputText("You manage to swallow most of your cum as it bursts from your loins, the pleasure of orgasm goading you into compulsively swallowing.  ");
						else if (player.cumQ() < 250)
							outputText("You sputter jism from your mouth as your orgasm becomes too much to keep up with, cum filling your mouth to capacity as you swallow and dribble in equal measure.  Cum splatters on you from the rest of your equipment, making you a slimy mess.");
						else if (player.cumQ() < 500)
							outputText("Pulse after pulse of cum erupts from your [cock] into your mouth.  You swallow what you can but it's too much for you.  Cum runs down your [cock] to pool on you as your orgasm drags on.  Jizz rains over you the entire time from the rest of your \"equipment\".");
						else outputText("Your orgasm never seems to end, and your world dissolves into the feelings from your [cock] as it erupts jet after jet of cum into your mouth.  You nearly gag, cum overflowing to spray out in a river, pooling around you.  Your other 'equipment' rains jizz upon you the whole while, soaking you in a cum-puddle.");
						//Refill hunger!
						if (player.cumQ() < 1000) player.refillHunger(player.cumQ() / 15);
						else if (player.cumQ() < 3000) player.refillHunger(50 + ((player.cumQ() - 1000) / 30));
						else player.refillHunger(100 + ((player.cumQ() - 3000) / 45));
					}
					//These seem like they should always be displayed regardless of other factors.
					if (player.cumQ() < 25)
						outputText("A few thick spurts of cum burst from your cocks, splattering you liberally.  ");
					else if (player.cumQ() < 250)
						outputText("The orgasm drags on and on, spurt after spurt of jism coating you from each cock.  ");
					else if (player.cumQ() < 500)
						outputText("Your body spasms powerfully, each spurt making you twitch more powerfully than the last.  Rope after rope of jizz rains down as the orgasms from each of your members begin to overlap.  Your nearly black out in pleasure.  ");
					else outputText("The orgasm never seems to end, and your world dissolves to little more than the feeling of multiple cum eruptions spurting from your pricks.  Your mind dimly processes the feeling of each burst splattering over you, but it only enhances the feeling.  ");
				}
			}
			//Vaginal CUMMING
			if (player.vaginas.length > 0) {
				//Single vagina!
				if (player.vaginas.length == 1) {
					outputText("Your ");
					//Specify which sex for herms :3
					if (player.gender == 3) outputText("fem");
					outputText("sex quivers as the pleasure overwhelms you, robbing you of muscle control, your passage rippling and contracting around your fingers.  ");
					//Big clitty bonus!
					if (player.clitLength >= 4.5)
						outputText("A hand finds your cock-like clit, squeezing and caressing it as the cunt-wrenching orgasm wracks your body, the over-sized joy-buzzer nearly making you black out from the sensations it generates.  ");
					else if (player.clitLength > 1.5)
						outputText("Every muscle-twitch seems to stretch your big oversensitive clitty larger, causing you to squeal with delight at every bump and touch against it.  ");
					//Wet orgasms
					if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText("A veritable gush of fluid explodes from your nethers, pulsing in time with the ripples of your [vagina].  ");
				}
			}
			//Cumming time for TITS! Should only trigger if: you are lactating at level 2 or higher, you are a female/herm, or you have nipplecocks/cunts
			if (player.averageLactation() >= 2 || player.hasFuckableNipples()) {
				//FUCK ANOTHER SHODDILY WRITTEN FUNCTION TO DEBUG/PORT
				//WHYYYYY
				titCum(player.cumQ());
			}
			if (player.armor == armors.GOOARMR) {
				var valeriaFluids:int = 0;
				if (player.hasVagina()) {
					if (player.vaginas[0].vaginalWetness >= 3) valeriaFluids += player.vaginas[0].vaginalWetness * 3;
				}
				if (player.hasCock()) {
					if (player.cumQ() < 100) valeriaFluids += (player.cumQ() / 5);
					else if (player.cumQ() >= 100 && player.cumQ() < 500) valeriaFluids += 20 + (player.cumQ() / 20);
					else if (player.cumQ() >= 500 && player.cumQ() < 3500) valeriaFluids += 40 + (player.cumQ() / 50);
					else if (player.cumQ() >= 3500) valeriaFluids += 100;
				}
				valeriaFluids += Math.sqrt(player.lactationQ());
				SceneLib.valeria.feedValeria(valeriaFluids);
				if (valeriaFluids > 0) outputText("\"<i>Thanks for the fluids!</i>\" Valeria says.  ");
			}
			//DONE!
			flags[kFLAGS.TIMES_MASTURBATED]++;
			masturGasm();
		}

		private function titCum(cumQuantity:Number = 3):void {
			//var tempSize:Number = Math.round((nippleLength + baseCockLength/2)*100)/100;
			//var nippleCockDescript:String = nippleCockDescript(tempSize);
			//Normal Tits, only if lactating at at least level 2
			if (player.averageLactation() >=2 && !player.hasFuckableNipples()) {
				outputText("As orgasm after orgasm thunders through your body, you feel pressure build in your breasts and then suddenly release, as ");
				if (player.averageLactation() <= 2.6) outputText("thin streams of milk spray out of your ");
				if (player.averageLactation() > 2.6 && player.averageLactation() < 3) outputText("thick gouts of milk spurt out of your ");
				if (player.averageLactation() >= 3) outputText("huge torrents of milk blast out of your ");
				//different description based on size of nips
				if (player.averageNippleLength() <=1) outputText("erect nipples, ");
				if (player.averageNippleLength() > 1 && player.averageNippleLength() < 4) outputText("fat, puckered nipples, ");
				if (player.averageNippleLength() >= 4) outputText("huge, swollen teats, ");
				if (player.armor == armors.GOOARMR) {
					if (player.averageLactation() < 2.6) outputText("spattering milk into the goo.  ");
					if (player.averageLactation() >= 2.6) outputText("stuffing the goo with your milk.  ");
				}
				else {
					if (player.averageLactation() <= 2.6) outputText("spattering milk everywhere.  ");
					if (player.averageLactation() > 2.6 && player.averageLactation() < 3) outputText("covering everything nearby.  ");
					if (player.averageLactation() >= 3) outputText("drenching the entire area.  ");
				}
			}
			//Cumming with Nipplecunts!
			if (player.hasFuckableNipples()) {
				outputText("A strange feeling builds in your breasts as your nipples seem to tighten and quiver with anticipation. You ");
				//Different noise based on sensitivity
				if (player.sens < 70) outputText("moan with ecstacy as your freakishly swollen nipples ");
				if (player.sens >= 70) outputText("scream with ecstacy as your freakishly swollen nipples ");
				//Different description based on wetness
				if (player.averageVaginalWetness() < 2) outputText("dribble ");
				if (player.averageVaginalWetness() >= 2 && player.averageVaginalWetness() < 4) outputText("spray ");
				if (player.averageVaginalWetness() >= 4) outputText("gush ");
				//Lactating?
				if (player.averageLactation() > 0) outputText("milk and ");
				outputText("pussy juice ");
				if (player.armor == armors.GOOARMR) outputText("into the blue goo covering your body.  ");
				else outputText("everywhere.  ");
			}
		}

		//(D. Dildo) – a floppy pink dildo with aphrodisiac reservoir
		private function deluxeDildo():void {
			player.slimeFeed();
			clearOutput();
			//[USE FEMALE]
			if (player.hasVagina()) {
				//(highcor)
				if (player.cor > 66)
					outputText("You retrieve the floppy pink dildo from your possessions and strip down in the middle of your camp, shivering with the sexual thrill of your exhibitionism.");
				//(medcor)
				else if (player.cor > 33)
					outputText("You retrieve your floppy dildo and sigh happily as you squeeze it, feeling the spongy surface give a little bit.  Glancing around furtively, you find a secluded spot and strip down.");
				//(lowcor)
				else outputText("You blush feverishly as you grab your pink dildo.  It flops about lewdly as you run off behind some rocks and strip down to use it.  You feel like such a pervert.");
				outputText("\n\n");
				//(low cor)
				if (player.cor < 50)
					outputText("You hold the fake dong away from you, aroused but still somewhat disgusted by its lewd shape.");
				//high cor
				else outputText("You hold the fake dong, squeezing it and giggling at the realistic texture.  You can't wait to try it out.");
				outputText("  A drop of pink aphrodisiac leaks from the tip, offering you a hint of the pleasure you're in for.   You make sure to catch it on your crotch, letting the fluid seep into your [vagina].  Warmth radiates outwards, spreading to your thighs as your " + player.clitDescript());
				if (player.clitLength < .5)
					outputText(" becomes hard and sensitive");
				else if (player.clitLength < 3)
					outputText(" peeks through your folds");
				else if (player.clitLength < 6)
					outputText(" fills with blood, growing erect like a tiny cock");
				else outputText(" fills with blood, twitching and pulsating like a man's cock");
				outputText(".  You ");
				if (player.cor > 50) outputText("don't ");
				outputText("hesitate ");
				if (player.cor < 50)
					outputText("before slowly working it inside you, gasping at the enhanced sensitivity of your [vagina].");
				else outputText("ramming it deep inside you, moaning as it rubs your now over-sensitive walls.");
				outputText("  You splay your [legs] and lie there with it inside you, feeling it respond to your wetness, becoming more and more turned on by the second.\n\n");

				//(Kinda dry)
				if (player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_SLICK)
					outputText("The thickness of the toy gradually increases, filling you more and more effectively as it reacts to your bodily fluids.  You grab it two-handed and start slamming it into your [vagina], vigorously fucking yourself with the swelling dong.  The sensations just keep getting better and better as more and more of the goblin's sex-drug leaks into you.  Even your [clit] and cunt-lips tingle with need.  You answer that need by picking up the pace, pistoning faster and faster.\n\n");
				//(Pretty wet)
				else if (player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_SLAVERING) {
					outputText("The toy's girth seems to pulse and swell within you, spreading you wide open as it sops up your natural wetness and grows larger.  You grab it in a two-handed grip and begin working it in and out of your [vagina], gasping and twitching as every ridge and feature of the dildo rubs you just right.  Every inch of your nethers tingles with a desire to be touched, rubbed, and squeezed. ");
					if (player.cocks.length > 0) {
						outputText("Even your " + player.multiCockDescript() + " ache");
						if (player.cockTotal() == 1) outputText("s");
						outputText(" and pulse");
						if (player.cockTotal() == 1) outputText("s");
						outputText(", bouncing on your belly.  ");
					}
					outputText("You answer that need by pistoning the fat juicy dick even harder into your tightly stretched box, cooing as tiny squirts of fluid erupt with every thrust.\n\n");
				}
				//(Soaked)
				else outputText("You can feel the dildo growing inside you, reacting to gushing feminine fluids by stretching your [vagina] wide.  It doesn't seem to stop when you start fucking yourself with it.  If anything, it only seems to get thicker and thicker until there is barely room for your juices to squirt around it and your hips feel sore.  However, the tingling hotness of the dildo's aphrodisiac cum overwhelms the discomfort of the fattening fuck-tool, and you work it harder and harder, reveling in being stretched beyond your normal capacity.\n\n");

				//Sensitivity based orgasms.
				//(Low sensitivity)
				if (player.sens < 80) {
					outputText("Practically brutalizing your cunt with the swollen puss-plug, you bring yourself to orgasm.  Your " + hipDescript() + " leap off the ground, quivering in the air against your hands as you ram the toy into yourself as far as it will go.  You can feel it spurting inside you, just like a real man.  You wiggle and moan as the muscle spasms work their way through your [legs], leaving you drained and exhausted.  The pink dildo suddenly shrinks back to its original size and flops free, leaving your [vagina] stretched open to drool a puddle of pink cum.");
					//(+sensitivity by 5)
					dynStats("sen", 5);
				}
				//High sensitivity (80+)
				else {
					outputText("Brutalizing your stretched fuck-hole with the bloated toy, you manage to get yourself off.   Your body quakes and spasms while your " + hipDescript() + " buck into the air, fucking an imaginary lover.  The dildo sinks into your core, your arms instinctively fulfilling your desire for complete penetration.  A warm wetness suddenly soaks your womb as the fuck-stick erupts, filling you.  Just like that the orgasm you had seems like foreplay.  Your eyes roll back into your head and you begin convulsing, practically having a pleasure-seizure from the drugs and your already oversensitive twat.   You sprawl there, wiggling and cumming your brains out for what feels like an eternity, but it does eventually end, and when it does the dildo is back to its normal size, lying in a puddle of aphrodisiacs and girlcum.");
					//(+sensitivity by 3 & intellect -2 & libido +1	)
				}
				//Option Jojo veyeurism?
                if (JojoScene.monk >= 5 && flags[kFLAGS.JOJO_DEAD_OR_GONE] == 0) {
                    outputText("\n\nAs you stand and try to clean up you manage to spot Jojo off in the woods, ");
					if (player.hasStatusEffect(StatusEffects.TentacleJojo))
						outputText("his tentacles splattering mouse-jizz everywhere as he gets off from your show.");
					else outputText("splattering himself with mouse-spunk as he finishes enjoying your inadvertent show.  He runs off before you have a chance to react.");
				}
				masturGasm("Vaginal");
				flags[kFLAGS.TIMES_MASTURBATED]++;
				endEncounter();
				outputText("\n");
				player.cuntChange(player.vaginalCapacity() * 0.9, true);
			}
		}

		//onaHole use - game should already have checked if player has a cock! CHECK BEFORE CALLING
		private function onaholeUse():void {
			//Clear text for new stuff
			clearOutput();
			//Flag after first use!
			if (!player.hasStatusEffect(StatusEffects.PlainOnaholeUsed)) {
				player.createStatusEffect(StatusEffects.PlainOnaholeUsed, 0, 0, 0, 0);
				outputText("You get naked and settle down with your new toy. The device looks mildly unappealing and almost comical. However, you have never been one to slouch in the search for new forms of pleasure. ");
				if (player.cocks.length > 1)
					outputText("With your free hand, you slap your [cocks] to 'attention' and ease the onahole over your cocks.  ");
				else outputText("With your free hand, you slap your cock to 'attention' and ease the onahole over your cock.");
				outputText("\n\nMuch to your surprise, Giacomo failed to point out that the ugly rubber sheath was open-ended on the inside and is providing an impressive grip around your shaft. Without hesitation, you begin working your cock as if the world would die tomorrow. Stroke upon stroke, you demand your body to break itself in half with massive orgasmic pulses. Inside the toy, your member clenches and swells with pleasure, triggering floods of pre-cum into the tube, making it feel even sharper.");
				outputText("\n\nYour body is quick to respond to your demands and you pump impressive amounts of your seed into your toy. Savoring each shot, you relish the sensation of feeling the warmth of your cum radiate throughout and warm your cock even more.");
			}
			//If player is already flagged, show repeated use text!
			else if (player.cor > 66)
				onaholeRepeatUse(true);
			else onaholeRepeatUse(false);
			dynStats("sen", -.75);
			onaholeContinuation();
		}

		public function deluxeOnaholeUse():void {
			clearOutput();
			//Flag after first use!
			if (!player.hasStatusEffect(StatusEffects.DeluxeOnaholeUsed)) {
				player.createStatusEffect(StatusEffects.DeluxeOnaholeUsed, 0, 0, 0, 0);
				outputText("You get naked and settle down with your new toy. You are amazed at the level of care and detail in the craftsmanship of this toy. You wonder if it feels as good as it looks.\n\n");
				if (player.cocks.length > 1)
					outputText("With your free hand, you slap your [cocks] to 'attention' and ease the onahole over your cocks.  ");
				else outputText("With your free hand, you slap your cock to 'attention' and ease the onahole over your cock. ");
				outputText("As you 'deflower' the toy, you are floored by how realistic it REALLY does feel. Giacomo must use one of these himself, as it does feel damn close to a real twat. You especially enjoy how it manages to squeeze with just the right amount of pressure.");
				outputText("\n\nWithout hesitation, you begin working your cock as if the world would die tomorrow. Stroke upon stroke, you demand your body to break itself in half with massive orgasmic pulses. Inside the toy, your member clenches with pleasure, triggering floods of pre-cum into the tube, making it feel even sharper. As your pre-cum fills the nooks and crannies of the toy pussy, it begins warming up and feels like an actual lubricated cunt! Amazing!");
				outputText("\n\nYour body is quick to respond to your demands and you pump impressive amounts of your seed into your toy. Savoring each shot, you relish the sensation of feeling the warmth of your cum radiate throughout and warm your cock even more.");
			}
			//If player is already flagged, show repeated use text!
			else if (player.cor > 66)
				onaholeRepeatUse(true);
			else onaholeRepeatUse(false);
			dynStats("sen", -1.5);
			onaholeContinuation();
		}

		private function onaholeContinuation():void {
			flags[kFLAGS.TIMES_MASTURBATED]++;
			if (player.cocks.length > 1) {
				if (player.gender == 3 && rand(2) == 0)
					doNext(onaholeFutaContinuation);
				else doNext(onaholeMulticockContinuation);
			}
			else if (player.gender == 3)
				doNext(onaholeFutaContinuation);
			else {
				masturGasm("Dick");
				endEncounter();
			}
		}

		private function onaholeMulticockContinuation():void {
			outputText("You pull the sloppy toy from your dribbling dick and smile, shoving its slippery surface down on another of your [cocks].  You rapidly work it around your cocks, orgasming until ");
			if (player.hasBalls())
				outputText("you pass out with aching, empty balls.");
			else outputText("you pass out with [cocks] sore from exertion.");
			masturGasm("Dick");
			endEncounter();
		}

		private function onaholeFutaContinuation():void {
			outputText("\n\nThe blessing - or curse, depending on how you feel - of your gender catches up with you. As with all members of your gender, you are incapable of having just ONE orgasm. You feel the muscles deep in your crotch bear down hard. Your eyes widen as you realize you are about to blow a monumental load. The pressure works its way through you and towards your cock as, with one final push, you force a torrent of semen out of your body. Your grip was not sufficient on the onahole and you launch it ");
			outputText(String(int(((Math.random() * player.str / 12) + player.str / 6) * 10) / 10));
			outputText(" feet away from you. Delirious with pleasure, you continue your 'impression' of a semen volcano, covering yourself and the area with your seed. ");
			outputText(" As your orgasms fade, you find yourself a well-fucked mess, and pass out.");
			masturGasm("Dick", "Vaginal");
			endEncounter();
		}

		private function allNaturalOnaholeUse():void {
			clearOutput();
			//First use!
			if (!player.hasStatusEffect(StatusEffects.AllNaturalOnaholeUsed)) {
				player.createStatusEffect(StatusEffects.AllNaturalOnaholeUsed, 0, 0, 0, 0);
				outputText("Scratching your head, you wonder how such a goofy contraption can offer the extreme pleasures Giacomo was peddling. Shrugging your shoulders, you disrobe and quickly stir the she-cock for a nice quick fuck. With little difficulty, you push the two cushions aside as you penetrate the toy. It feels very warm, like the warmth of flesh. You push the onahole down on your cock until you bottom out. You feel some sort of soft protrusion in the base of the toy, pressing against the opening of your cock.");
				outputText("\n\nYou begin gently stroking yourself with the toy. You decide for a nice, leisurely pace over your usual hectic moods. The toy is warm and is very pleasurable. While hardly worthy of the sales pitch made by Giacomo, you feel that it was worth the money. If nothing else, it is different.");
				outputText("\n\nWithout warning, you feel immense pressure clamp down upon your cock. Shocked, you instinctively try to pull out. Your efforts only succeed in pulling the toy up your shaft for a moment before it crawls back down. Whatever went wrong, your cock is stuck. You feel a pulse from the two cushions inside the onahole. The thing lurches forward on your cock and it is now embedded deeper. Frustrated, you start thumping your trapped pecker against the ground, trying to shake the thing loose, to no avail. The thing lurches down on your cock. You now feel the annoying impression against the head of your cock as you bottom out.");
				outputText("\n\nBefore you can react, you feel the impression move. It shifts... adjusts. Utterly confused and revolted, you pause to figure out what is going on. You then feel the unmistakable sensation of something prodding at the opening in the head of your dick. The horrid reality crashes down upon you like a falling wall; this \"toy\" is a living creature!");
				outputText("\n\nAs the true reality of your plight buffets against your mind, you feel a slender tendril push past your opening and into your urethra! Unaccustomed to this kind of \"penetration\", your body convulses and bucks as you try to shake the thing off. You grab the creature and begin to pull it off, only to see needle-like growths come from the holes around the main opening. They push against the base of your pubic mound and you feel the needles prickling against your skin. As you try to pull, the needles react by trying to pierce your skin. When you stop, the needles retract. You come to the realization that you will not get this thing off your dick without tearing yourself apart.");
				outputText("\n\nThe tendril continues exploring your urethra until it settles inside your prostate. The tendril begins flicking its end around your inner sex as the muscular body begins humping and pumping your cock. Within minutes, the pace of the little creature is frenetic. Scream upon scream thunders from your lungs as the creature plunders your insides.  Pain and pleasure become the same sensation as you get the cock-milking of your life.");
				outputText("\n\nAs you feel your cum build, you feel a sharp suction inside you. The suction immediately triggers your orgasm and your muscles cramp and push to cum. Instead of shooting a load, you feel the sucking of the tendril vacuum up your cum! As it swells to feed, you feel your inner tube match its growth. The uncoordinated sensation of your urethra dilating against your own orgasm forces you to cum again, prompting the creature to suck the cum right out of you again.");
				outputText("\n\nThe more semen you produce, the harder the accursed thing sucks. Eventually, the pain subsides and only the unholy pleasure of such deep penetration and stimulation remains. THIS is what that crazy merchant was talking about. You have never cum so hard or as much as now. Your mind is polluted with lust and all you want is for this thing to keep milking you and leave you intoxicated with pleasure. The shock of this treatment sends you in and out of consciousness. You wake up only long enough to pump another load down its endless pipe. Each time you wake up to cum, you see the thing get fatter and fatter.");
				outputText("\n\nAwake... out... awake, out. The next minutes, hours or whatever, are a blur. You sense the need to cum. You feel your muscles squeeze to force your seed out. You feel the animal, or whatever it is, suck the very life-milk from you. It grows fatter. You want to feel your muscles squeeze again! You want to feel the semen surge again! You want the thing to work your shaft some more! Endless pleasure. Endless orgasm. You faint.");
				outputText("\n\nYou have no clue how much time has passed. However, you wake up with your sex organs sore from the inside out. There are small dribbles of cum on the ground and you see the thing has swelled up to twice its size. Horrified, you reach to grab the thing to kill it--but stop. After you got over being penetrated, they were THE best orgasms you have ever had.");
			}
			//If player is already flagged, show repeated use text!
			else {
				//High corruption variant!
				if (player.cor > 66) {
					outputText("Grinning from ear to ear, you grab your \"pet\" from your bag and bury your dick deep into its maw. Somewhat stunned by your zeal, the creature shifts about lethargically. You impatiently wobble your dong, shaking the creature with it, in an attempt to wake the little dick-milking bastard up. The beast eventually comes to life and begins doing the only thing it knows how to do. Securing itself to your erection and easily entering your well-stretched urethra, the creature inserts itself to begin another feeding session. Enjoying the creature's efforts to milk you of your fluids, you choose to up the ante a bit. You begin flexing your pelvic muscles to make your cock bob about. Along with the gentle pinch of pleasure your flexing gives you, the creature mistakes your self-pleasure for an attempt to dislodge it and stabs its tendril deeper into your prostate, creating an even sharper response. Throwing your head back as the pleasure washes over, you continuously flex yourself to make the beast plunder deeper inside you. Welling up with an impressive load, you grab the animal with both hands as you expertly control your ejaculation reflex. With an expertise borne from repeated self-exploration, you force feed the beast gout upon gout of your seed. The thing quickly bloats as your shots are more than a match for even its ravenous appetite. It swells quickly and releases itself from your body, obviously stuffed to the proverbial gills. Undaunted and unsatisfied, you launch the creature off your cock with another great eruption from your sex. The creature lands smartly on the ground where you quickly waddle over to unload the rest of your pent-up cum all over its shell. Satisfactorily drained and the beast covered completely in your lust, you wipe the sweat from your forehead and silently congratulate yourself on the impressive job you did on keeping your pet well fed. You check to make sure your vigor did not injure the creature and, satisfied that it was otherwise uninjured, set it aside to vegetate on the massive load of cum you fed it with.");
				}
				//low corruption variant!
				else {
					outputText("Part of you regretting the purchase, the other half longing for the intensity of pleasure, you reach into the bag to get the creature Giacomo laughingly labels an \"all-natural\" onahole. Telling yourself that the creature needs to feed and has every right to survive as any other animal, you reluctantly place the beast on your stiff, implacable erection. Springing to life, the animal immediately bears down upon your shaft and clamps itself in place. With a greater adroitness, the creature's feeding tube breaches your urethra and muscles its way deep into your sex. Undulating its mass and flicking its tentacle, the creature forces your body to make the sexual fluid it needs to survive. Biting your lip and groaning, you can only endure the painful pleasure of your sensitive genitalia being forced to produce. The unique sensation of sex juice building in your body inflames the abomination, forcing it to move faster. Moments later, an orgasmic wave cramps your body into knots as you force semen into the creature. Load after load shoots into the beast and it swells up as it fattens from your lust. Once you are spent, the creature retracts the tendril, prompting one last cumshot from you, and releases your used and mildly abused prick. Collapsing to the ground, you fall asleep before you can recover from the encounter.");
				}
			}
			dynStats("sen", .75, "cor", .5);
			flags[kFLAGS.TIMES_MASTURBATED]++;
			masturGasm("Dick");
			endEncounter();
		}

		private function stimBeltUse():void {
			clearOutput();
			//FIRST TIME USAGE
				//First use! Flag after first use!
				if (!player.hasStatusEffect(StatusEffects.used_self_dash_stim)) {
					player.createStatusEffect(StatusEffects.used_self_dash_stim, 0, 0, 0, 0);
					outputText("Brimming with anticipation, you wind up the small gearbox on the weird contraption. You place the machine down and strip yourself naked. Stepping through the straps of the garment, you pull it up. The dildo does not come out, so you take the time to ease the artificial phallus to rest deep in your womanhood. After nestling the false cock in your pussy, you finish pulling up the belt and you tighten the straps. You lay down and you flip the switch. The machine vibrates around and inside you vigorously. Immediately, waves and cramps of pleasure swirl around your cunt and shoot up and down your spine. The machine, free of human limitations and fatigue, ceaselessly rubs and caresses your insides at impossibly high speeds. Within minutes, you begin experiencing the tell-tale contractions of an impending orgasm. With your hands free, you are able to explore your breasts and body as the device hammers away. You squeeze your ");
					outputText(player.breastCup(0));
					outputText(" tits as your body convulses with multiple orgasms. Savoring every moment, you relish in the pangs of delight searing your body. Eventually, the belt moves slower and slower, until it comes to a stop, along with your fun. You realize that the gears have wound down and the box needs to be wound for your pleasure to continue. Deciding not to overwhelm yourself, you carefully remove your toy and save it for another time.");
				}
				//Repeated use!
				else {
					outputText("Your need for release causes you to fumble with the mechanical contraption. As you don the self-stimulation belt, you inadvertently drop the key used to crank the gearbox. Cursing in frustration, you awkwardly paw about for the key. After a few moments scraping about in a manner that would thoroughly amuse any onlookers, you locate the key and wind up the main spring.\n\n");
					outputText("Switching the belt on, it begins to immediately vibrate and rub every sensitive part of your [vagina]. You immediately glow with pleasure as the machine works its magic on your hungry pussy. Worried about the machine winding down, you re-crank the gear box occasionally to ensure that you get worked over by the tireless device as long as you can handle it.\n\n");
					outputText("Eventually, the machine tweaks your nerves and your [clit] just right, triggering a massive orgasm that leaves you bucking wildly like an untamed horse, screaming in mind-numbing pleasure. Your uncontrollable movement dislodges the key from the gear box and you have no choice but to wait for the machine and your still-orgasming body to wind down, and THEN find the goddamn thing. After about fifteen minutes, the machine expends the last of its energy, leaving you a twitching heap until you can move to find the meddlesome key.\n\n");
					outputText("Fortunately, you locate the key near your feet, saving you the money of having another made for the device. You put aside your machine, your lusts slaked, for now.");
				}
				flags[kFLAGS.TIMES_MASTURBATED]++;
				player.cuntChange(1, true, true, false);
				masturGasm("Vaginal");
				endEncounter();
		}

		private function allNaturalStimBeltUse():void {
			clearOutput();
				//First time!
				if (!player.hasStatusEffect(StatusEffects.UsedNaturalSelfStim)) {
					//Flag as used!
					player.createStatusEffect(StatusEffects.UsedNaturalSelfStim, 0, 0, 0, 0);
					outputText("Brimming with anticipation, you put on the gloves to avoid prematurely triggering the machine. You place the belt down and strip yourself completely. Stepping through the straps of the garment, you pull it up. You take the time to align the nodule with the opening of your womanhood. After settling the knob to the entrance to your pussy, you take off the gloves, lay back and touch the amber pads with your fingers.\n\n");
					outputText("You hear a distinctive squishing sound and you feel the belt tighten around your waist and pelvis. It becomes tighter and tighter until its removal is an impossibility because of your own bulk. While you are concerned, you maintain composure as the belt eventually stops tightening. There is a pause. A couple of minutes go by and little happens. You notice that the entire front of the belt is becoming warm. It is not the typical heat from a blanket or a piece of metal, but it feels like the warmth of flesh on flesh. You hear more squishing and you feel the nodule stir and rub against your opening. Your pleasure slowly begins to build and you are stimulated and amused by the teasing the apparatus seems to produce. Without warning, you feel your cunt stretch open as something thrusts inside you.\n\n");
					doNext(allNaturalSelfStimulationBeltContinuation);
				}
				//Multiple uses
				else {
					masturGasm("Vaginal");
					//Low corruption variant
					if (player.cor < 50) {
						outputText("Shamed by the depths of your sexual needs, you don the abominable stimulation belt and brace for its eventual ravaging of your needy womanhood. Without waiting for you to touch the activator, the organic portion of the device, sensing your needs, engorges and buries itself in your vagina, beginning to pump with furious speed. The shock of the sudden stimulation convulses you backwards, leaving you writhing on the ground as the horrid symbiote undulates in a luridly sordid manner. You distinctly feel a nodule growing about your clitoris, shifting and changing into a sucker. The suction begins furiously working your clitoris as if it were a miniature penis, slurping, sucking and jerking away, prompting another painfully pleasurable wave of multiple orgasms.\n\n");
						outputText("You cry in shock as the creature pushes past your cervix and begins injecting your womb with hot, thick cum... or whatever it is that it shoots inside you.  Unlike before, the very sensation of the fluid acts upon your brain and body strangely. The pain dulls and eventually filters from your mind and only the pleasure of the experience remains. The fluid continues pumping in until it overflows. The flooding of your insides leaves you paradoxically ecstatic and revolted. After an unknown amount of time, the thing stops fucking you and it releases its grip of your pelvis, leaving you a sticky, exhausted mess. A part of you wants to try the belt again, but you are too tired to bother cleaning yourself up.");
						dynStats("sen", .75, "cor", 1);
						endEncounter();
					}
					//High corruption variant
					else {
						outputText("Barely taking the time to strip yourself down, you quickly slide the belt-shaped beast onto your hips. It immediately clamps down and begins the all-too-familiar plundering of your opening. It barrels deep into your box and quickly latches on your [clit] and the relieving pleasure of its thundering movements quench your need for pleasure. The creature quickly begins streaming its fluids inside you. No longer sensing pain, as you did when you first used the belt, you lay in endless bliss as the warmth of the fluid fills you up. The creature, sensing how much of its juice is in you, stops squirting and begins stirring the jizm it left. The unique pleasure of the hot fluid literally stirring and swirling inside you coaxes a wave of orgasms from your body, which draw the milk even deeper into your womanhood. It almost feels as if your body is absorbing the milk into your deepest recesses with each pelvic contraction.\n\n");
						outputText("The creature lets out another torrent of cum and repeats the process. Drunk with lust, you are uncertain how you are containing so much spunk without it gushing out, as before. Every time you try to think about it, another orgasm destroys any attempt at rational thought. By the time the thing is done with you, hours and hours have already passed you by. You crash from your hours-long orgasm, exhausted, and can only think of the next opportunity to have the belt about your loins.");
						dynStats("sen", 1, "cor", 1.5);
						//Game over if fully corrupt!
						if (player.cor >= 100) doNext(allNaturalSelfStimulationBeltBadEnd);
						//Otherwise, 4 hours pass!
						else {
							outputText("Check passed - you're not fully corrupted... You don't want to check the other option... right?");
							doNext(camp.returnToCampUseFourHours);
						}
					}
				}
			flags[kFLAGS.TIMES_MASTURBATED]++;
			player.cuntChange(1, true);
			player.slimeFeed();
		}

		private function allNaturalSelfStimulationBeltContinuation():void {
			clearOutput();
			outputText("In shock, you scream as you realize the nodule has instantly grown into a massive, organic dildo. It bottoms out easily and rests against your cervix as you recover from the initial shock of its penetration. As the pangs subside, the infernal appendage begins working itself. It begins undulating in long, slow strokes. It takes great care to adjust itself to fit every curve of your womb. Overwhelmed, your body begins reacting against your conscious thought and slowly thrusts your pelvis in tune to the thing.\n\n");
			outputText("As suddenly as it penetrated you, it shifts into a different phase of operation. It buries itself as deep as it can and begins short, rapid strokes. The toy hammers your insides faster than any man could ever hope to do. You orgasm immediately and produce successive climaxes. Your body loses what motor control it had and bucks and undulates wildly as the device pistons your cunt without end. You scream at the top of your lungs. Each yell calls to creation the depth of your pleasure and lust.\n\n");
			outputText("The fiendish belt shifts again. It buries itself as deep as it can go and you feel pressure against the depths of your womanhood. You feel a hot fluid spray inside you. Reflexively, you shout, \"<b>IT'S CUMMING! IT'S CUMMING INSIDE ME!</b>\" Indeed, each push of the prodding member floods your box with juice. It cums... and cums... and cums... and cums...\n\n");
			outputText("An eternity passes, and your pussy is sore. It is stretched and filled completely with whatever this thing shoots for cum. It retracts itself from your hole and you feel one last pang of pressure as your body now has a chance to force out all of the spunk that it cannot handle. Ooze sprays out from the sides of the belt and leaves you in a smelly, sticky mess. You feel the belt's tension ease up as it loosens. The machine has run its course. You immediately pass out.");
			player.slimeFeed();
			masturGasm("Vaginal");
			dynStats("lib", 1, "sen", (-0.5));
			endEncounter();
		}

		private function allNaturalSelfStimulationBeltBadEnd():void {
			spriteSelect(SpriteDb.s_giacomo);
			clearOutput();
			outputText("Whatever the belt is, whatever it does, it no longer matters to you.  The only thing you want is to feel the belt and its creature fuck the hell out of you, day and night.  You quickly don the creature again and it begins working its usual lustful magic on your insatiable little box.  An endless wave of orgasms take you.  All you now know is the endless bliss of an eternal orgasm.\n\n");
			outputText("Your awareness hopelessly compromised by the belt and your pleasure, you fail to notice a familiar face approach your undulating form.  It is the very person who sold you this infernal toy.  The merchant, Giacomo.\n\n");
			outputText("\"<i>Well, well,</i>\" Giacomo says.  \"<i>The Libertines are right.  The creature's fluids are addictive. This poor woman is a total slave to the beast!</i>\"\n\n");
			outputText("Giacomo contemplates the situation as you writhe in backbreaking pleasure before him.  His sharp features brighten as an idea strikes him.\n\n");
			outputText("\"<i>AHA!</i>\" the hawkish purveyor cries.  \"<i>I have a new product to sell! I will call it the 'One Woman Show!'</i>\"\n\n");
			outputText("Giacomo cackles smugly at his idea.  \"<i>Who knows how much someone will pay me for a live woman who can't stop cumming!</i>\"\n\n");
			outputText("Giacomo loads you up onto his cart and sets off for his next sale.  You do not care.  You do not realize what has happened.  All you know is that the creature keeps cumming and it feels... sooooo GODDAMN GOOD!");
			EventParser.gameOver();
		}

		private function lickYerGirlParts():void { //Female cat masturbation
		clearOutput();
		if (!player.hasPerk(PerkLib.Flexibility)) {
			outputText("You undress from your [armor] and take a seat down on the ground. You spread your legs and look down at your sex. It's aching for something more than just your fingers, and you have a craving to taste the lustful juices leaking out. A very perverted idea of cats flashes through your brain, putting a naughty smile on your face. You lay on your side and spread your legs, giving you a perfect view of your [vagina] You lean your head down towards the pleasure-hole, only to be stopped half-way there. You stick your tongue out, trying to add a few more inches, but this doesn't do anything except increase your appetite and your lust as a drop of warm saliva falls onto your [vagina]. You stretch and wriggle your tongue out in a fruitless effort to taste your dripping wet cunt, craving the feeling of your tongue caressing your lips and penetrating into your depths... but it is not to be. You sit back up, frustrated and even more aroused than you were before.");
			dynStats("lus", 15, "scale", false);
			endEncounter();
			return;
		}
		//[1st time doing this]
		if (flags[kFLAGS.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY] == 0) {
			flags[kFLAGS.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY]++;
			outputText("You take off your [armor] and take a seat on the ground. You spread your legs and look down at your sex. It's aching for something more than just your fingers, and you have a craving to taste the lustful juices leaking out. A very perverted idea flashes through your brain, putting a smile on your face. You lay on your side and spread your legs again, giving you a perfect view of your [vagina]. You lean your head down with your tongue sticking out; closer and closer you come to your own cunt, feeling the heat from your puss flowing against your face as your own hot breath returns the warmth. You're only a small distance away from tasting it before you can't bend any farther.  Your cunny can almost feel your tongue wriggling its slimy warm wetness only a few centimeters away. You pull your head back and let out a frustrated sigh before you remember how the cats in your village got to those hard to reach places: they stretched one of their legs straight up. Following their example, you point one leg straight to the sky and close your eyes as you plunge your head down. You slowly open one eye to see that you're face to face with your [vagina]; you're amazed that you are actually able to do it. You begin lapping your tongue up and down the slutty snatch.\n\n");
			outputText("The feeling is amazing, as you flick your tongue across your swollen [clit]. Juices leak from your moist hole, filling your mouth with the sweet taste of girlcum. You can feel your entire sex pulsing and throbbing around your tongue as you plumb the depths of your [vagina].  The vibrations from your moans and screams of pleasure cause the intense feelings to increase, making you a slave to your own needs. Your juices flow down your chin as you try to swallow every last drop. You crane your neck, giving you deeper access to your wanting honey pot. You can feel yourself tightening around your tongue as it rams into your pussy, soaking up the juices as you slowly reach your peak.  You lick and suck hard around your [clit], using both your hands to spread your cunt farther open. You move your head in an up and down motion just like a cat when they groom themselves. Your lapping and tongue play continues until you can feel your body tense up, ready to cum.\n\n");
			outputText("You cover your entire pussy with your mouth and send a wave of hot air into it; suddenly, a powerful and erotic feeling washes over your entire body. Your pussy clenches hard around your tongue, as your juices release all over your face. You try as hard as you can to catch it all in your mouth, but you find it difficult; your entire body is shaking uncontrollably from the amazing orgasm you gave yourself, making it hard to catch your girlcum. Finally, the orgasm comes to a close as you swallow your juices with pride, giving a relaxed sigh. Still lying on the ground, you savor your own unique flavor with a lick across your lips and sigh of achievement. You feel like taking a cat nap right about now.");
		}
		//[Repeatable]
		else {
			outputText("You quickly undress from your [armor], both of your mouths drooling in anticipation for one another. You're going to do some stretches so you can be more nimble with your tongue work. You stand straight and spread your leg apart before leaning back and sticking your [vagina] out in front of you. After holding for a moment, you change positions, leaning your [allbreasts] forward and sticking your [ass] out for all to see.  You alternate leaning back and forth; it looks like you're teasingly thrusting at some unknown creature in the wilds, letting them know you're ready to get fucked. Soon, your spine is nice and limber - working on your legs is next. You stand up straight again, then lift and hold one knee up to your chest, pressing it against your [allbreasts]. This loosens it up a bit, but you know you can be more flexible than that. You support the underside of the leg with your hands and then lift the rest of your leg up, pointing your toes at the sky. You slowly take your hands off your leg, and are astonished that you're able to hold it up by itself.  Being naked in this position has allowed your funhole to be exposed to the elements, and you feel a cool breeze blow past your dripping wet sex.  It shakes and quivers, causing you to coo and moan at the sensation. Your leg feels as limber as your spine, so you switch to the other leg.  You immediately launch the other leg up next to your head, not needing the support of your hands to get your ankle behind your ear. You hold the pose for a few minutes, your cunt now drooling with pussy juice and eagerly waiting for you to kiss it. You soon put the leg down; now your back, legs and even your aching sluthole is stretched. You do some quick jaw stretches as you lay down on your bedroll.  Throwing one leg over your head, you easily bend your head down to your other pair of lips.\n\n");
			outputText("Your [vagina] is now right in front of your face, and you can't help but give it a lick with your tongue. The feeling is amazing as you flick your tongue across your swollen [clit]. Juices leak from your moist hole, filling your mouth with the sweet taste of girlcum. You can feel you entire sex pulsing and throbbing around your tongue as you plumb the depths of your [vagina].  The vibrations from your moans and screams of pleasure cause the intense feelings to increase, making you a slave to your own needs. Your juices flow down your chin as you try to swallow every last drop. You crane your neck, giving you deeper access to your wanting honey pot. You can feel yourself tightening around your tongue as it rams into your pussy and soaking up all the juices as you slowly reach your peak. You lick and suck hard around your [clit], using both your hands to spread your cunt farther open. You move your head in an up and down motion just like a cat when they groom themselves. Your lapping and tongue play continues until you can feel your body tense up, ready to cum.\n\n");
			outputText("You lap harder and faster with each second, coming closer and closer to tasting the girlcum about to squirt out of you. You feel your eager sex tighten one more time around your tongue before it releases its sweet nectar into your craving mouth. You guzzle as much as you can, but some leaks onto your [face].  You stick your tongue into your slick cunt to tease out the last few drops of cum. You tongue explores the depths once more, feeling its way around your [vagina] walls and gathering up everything that may not have come out. You wriggle it around for a while until you're satisfied that you got most of the girlcum. You pull away from your sex and spread out relaxed on your bedroll, letting out a sigh like you just drank a whole pitcher of ale in one chug. You stretch out your arms and legs and curl up, ready to take a catnap.");
		}
		//Stats & next event
		//DONE!
		flags[kFLAGS.TIMES_MASTURBATED]++;
		masturGasm("Vaginal");
		endEncounter();
	}

	private function EasterBunnyLayEggs():void { //Female cat masturbation
		clearOutput();
		outputText("You've been trying to relieve your need for days.. those eggs have grown so big now you need to shoot them out!\n\n");
		outputText("You begin by stroking your pulsating prick teasingly, pre-cum running down your length from your constant state of arousal. You stroke quickly, pleasuring your sensitive dick, darting a finger down to fondle beneath the base of your egg lidden balls.\n\n");
		outputText("The sensations prove too much for you, and you feel the tightness building in your twitching manhood, growing rapidly. You stroke furiously, feeling the pressure in your balls as you close in on your release. Pleasurable spasms overwhelm you as your pair of heavy eggs slides out from their bags and run through your [cock]. Your eyes cross as your hips jerk in the air in time with the eggs sliding out through your stretched urethra, a powerful burst of cum following through.\n\n");
		outputText("You gasp in relief, your rigid prick pulsing and throbbing with continual lust as the two eggs finally land safely on the ground before you. Unsure about what to do with those you decide to keep them in case off.\n\n");
		player.createStatusEffect(StatusEffects.EasterBunnyCame,0,0,0,0);
		//Stats & next event
		//DONE!
		flags[kFLAGS.TIMES_MASTURBATED]++;
		masturGasm("Dick");
		endEncounter();
	}

		private function gobomechImpregnator1():void {
			clearOutput();
			outputText("You take a look at your mech reservoir and smile gleefully noticing how it is about full, you're going to enjoy this!\n\n");
			outputText("You sit in your mech’s driver seat, open your personal compartment and draw out the tube taking your time to methodically plug it into the SPMK1 socket and use the fastener to lock it in place so it doesn't flail out wildly. That done you press the ON button and lay back to enjoy the fruit of your labor.\n\n");
			outputText("The mech beeps for a few seconds as the pump starts working, and soon freshly harvested cum flows up the tube straight into your thirsty goblin pussy. You moan from pleasure as the reversed strapon vibrates with the cum flow, hitting every side of your vaginal wall. Now this is how you like sex! Efficient, pleasurable and sure to end with a top tier bukake with a heavy pregnancy percentage rate!\n\n");
			outputText("The machine enters its second stage as the cable starts producing small jolts of electricity in your cunt, shocking your clitty in just the right way. Your eyes roll back in absolute bliss and you cum at once as your belly slowly inflates from the sheer amount of fluids your creation is pumping in, filling your addled mind with fireworks. You giggle in delight as the flow slowly ebbs, your SPMK1 holding the cum inside so no drops can leak out. Once it's over, you unfasten the tube and put it back in its compartment as you pat your belly in contentment. You really hope it took and if it didn’t, you will just have to harvest some more… hurray for progress!");
			player.cuntChange(8, true, true, false);
			player.knockUp(PregnancyStore.PREGNANCY_GOBLIN, PregnancyStore.INCUBATION_GOBLIN);
			player.addKeyValue("Cum Reservoir", 1, -4);
			endEncounter();
		}

		private function gobomechFuckingMachine():void {
			clearOutput();
			outputText("You launch the FUNTIME function and your mech’s structure opens out as gears and features align, the driver’s seat moving down to the ground for you to sit on.\n\n");
			outputText("You cheerfully sit on your seat, ready for a session. The screen before you quickly flickers to life, welcoming you and asking you to kindly place your feet in the appropriate safety straps and place your arms in the secure cuffs as to avoid injury. You grumble about the pointlessness of adding a set of safety measures but work your way into the tight-fitting straps anyways.\n\n");
			outputText("Within moments, the machine lifts you up, pulling your arms out and apart, away from your pleasure aching body. You don't bother to fight the strong pull of the mechanical assistant. It whirs to life, stating that it is beginning \"Phase 1: Preconditioning\".\n\n");
			outputText("You feel your mech begin to tug at your clothes with various mechanical clamps. It pulls your clothing free in moments, revealing your [breasts], [cunt], and your [ass] to the outside world’s air. It doesn’t take the machine but a couple of moments to place a metallic, phallic-shaped device against your labia and anus, the cold metal eliciting a pleasured gasp from you, allowing it to slip another cock into your mouth. The tip of the metal cock tastes salty, leaking some fluid slowly from the tip. You blush with arousal as your machine forcefeeds you cum.\n\n");
			outputText("Continuing its molestations, the machine attaches a small sucker hose to your clit, quickly suctioning it erect. The device follows suit with your perky nipples. You begin to moan, unable to hold back the delirious pleasure shooting through your body from the suctioning tubes. A mechanical arm with a syringe moves to your pussy and injects your clit with a chemical concoction of your design, causing your [pussy] lips to puff up and your throbbing clitoris to double in size"+(player.clitLength >= 3 ? " rivaling or perhaps even beating the length of a true penis":"")+". Distracted by the amazing feelings in your cunt you almost don’t notice the cum leaking from both phallic devices between your legs, lubing you further until they’re both starting to penetrate you at the same time, stuffing you full of mechanical cock from nearly every angle.\n\n");
			player.cuntChange(8, true, true, false);
			outputText("You gasp in pleasure, not bothering to move, fight, or even touch yourself as your machine begins to fuck you with its metallic cocks. The screen flashes, showing 'Phase one: Completed', and that it has begun 'Phase two, Implantation'. You smile in delight as it begins to fuck you harder and faster, your juices and arousal only lubing the machine's mechanism.\n\n");
			outputText("It doesn’t take long until the cock in your mouth cums, spraying a thicker, heavier load of the heavenly seed down your throat and into your stomach. You gasp, swallowing gleefully, as your eyes roll back in your head, the machine ramming its cock into your g-spot, pushing you almost instantly to orgasm. You moan out loud, the cock popping out of your mouth now that it's finished delivering its load. Your rippling vaginal walls milk the fake dick in your cunt, as it and the prick in your ass begin to cum heavily. Every hole is quickly filled with jizz, stuffing you completely.\n\n");
			outputText("Finally the machine slows down, beginning to lower you back onto the seat with jizz leaking from every hole on your body. You groan, sore and stiff from the brutal workout but happy with the afterglow as the screen before you displays ‘Saving data on your pleasure waves for future adjustment’.\n\n");
			outputText("Gosh if that didn't knock you up you will just use the linking tube next time.\n\n");
			player.knockUp(PregnancyStore.PREGNANCY_GOBLIN, PregnancyStore.INCUBATION_GOBLIN);
			player.addKeyValue("Cum Reservoir", 1, -4);
			endEncounter();
		}

		private function catAutoLick():void { //Male cat masturbation
			clearOutput();
			//NOT FLEXABLE
			if (!player.hasPerk(PerkLib.Flexibility)) {
				//Fails [Herm has a 50/50 chance of getting either.]
				//[Male]
				outputText("You undress from your [armor] and take a seat down on the ground, your [cock] pointing straight at your face. You stroke the erect member a few times, but then remember the cats back at the village. You stare at your [cock]; the more you look at the cock, the more your mouth craves to suck on it. You open your mouth as wide as you can and lean towards your cock, only to be stopped halfway to the tip. You stick your tongue out and try to lick the head. You pretend you're rolling your tongue around the head, but this only makes your cock harder in eagerness. You throw your head forward in an attempt to flick your tongue against it, but the [cock] is pulled back as you go forward. You slump your back onto the ground and let out a frustrated groan. The only thing you've managed to do is make yourself more aroused than when you started.");
				dynStats("lus", 15, "scale", false);
				endEncounter();
				return;
			}
			//1st time
			if (flags[kFLAGS.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY] == 0) {
				flags[kFLAGS.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY]++;
				outputText("You undress from your [armor] and take a seat on the ground. You take a look at your transformed body, making notes of things you haven't noticed before. Suddenly, an idea pops into your head: the cats back at the village could reach any place on their body with their tongues! You wonder... closing your eyes and slowly bending down, you try to get as close as possible to your [cock]. It only takes a moment before you feel warm breath blowing against your dick. You open your eyes, coming face to face with your erect member. Your body is twisted and bent in a way that only cats can manage. You huff a cloud of hot air on your pecker, and the resulting sensation causes your eyes to roll back in your head. That was incredible and it's about to get better as another thought passes through your head, giving you a dirty smile.\n\n");
				outputText("You lick the head of your throbbing man-meat and another bodyshaking shudder flows through you. You do it a few more times, enjoying the sensations running around inside of you. You bend down farther and lick from the base of your dick to the head. Slowly, you take the head inside of your mouth and begin sucking on it, trying to keep the drool in your mouth. The feeling is enough to make you cum, but you hold it in and move on. You take a few more inches inside your mouth as you begin pumping and thrusting, making lewd noises of moaning and sucking. The feeling is better than any blowjob you've ever had. You start to pump faster and faster, desperate to cum all over your own face. Just thinking about the fact that you're doing this to yourself turns you on even more. You take the rest of your [cock] inside of your mouth. You can smell the musty scent coming off of your [sack]. Your throat closes up on your member as you hum and flick your tongue across its head.\n\n");
				outputText("A very familiar feeling of pleasure rushes through your body, causing you to shudder. You pull your cock out and begin to stroke it as you suck on the tip, practically drinking your pre-cum. You can feel your cum building up as it gets ready to be released. After flicking your tongue against the tip of your [cock], you feel the flood of cum flowing up your dick");
				if (player.countCockSocks("gilded") > 0 && flags[kFLAGS.GILDED_JERKED] < player.countCockSocks("gilded")) {
					flags[kFLAGS.GILDED_JERKED]++;
					var gems:int = midasCockJackingGemsRoll();
					outputText(" along with a sudden chill from your Gilded cock sock causing you to reflexively pull off your [cock]'s tip just as the complete bliss of orgasm fills your body. Your face is less than an inch from your cock head as you watch your cum shoot up into the air. Caught in the light of the golden cocksock, it beads and twists in the light, crystallizing into a glittering shower. A ");
					if (player.cumQ() < 25)
						outputText("sprinkle of");
					else if (player.cumQ() < 250)
						outputText("rain of");
					else outputText("torrent of");
					outputText(" gems falls down upon your body instead of cum, bouncing off your " + player.skinFurScales() + " as you arc your back higher and higher until the only thing touching the ground is the top of your head and the tips of your toes! Your hips continue jerking in the air from the intense orgasm for a little while after the cum stops flowing.\n\n");
					outputText("<b>You take a few moments to collect all the glittering gems you just squirted all over the place, all " + gems + " of them</b>, before curling up and taking a short cat nap.");
					player.gems += gems;
				}
				else {
					outputText(". Suddenly, a feeling of complete bliss takes over your body, and you start to squirm and writhe as cum shoots down your throat. You pull off of the tip and let the next burst hit your face. Soon, the torrent of cum subsides, though your hips are still jerking in the air from the intense orgasm. You take a moment to lie down properly and decide to take a small cat nap.");
					if (player.cumQ() < 1000) player.refillHunger(player.cumQ() / 15);
					else if (player.cumQ() < 3000) player.refillHunger(50 + ((player.cumQ() - 1000) / 30));
					else player.refillHunger(100 + ((player.cumQ() - 3000) / 45));
				}
			}
			//[Repeatable]
			else {
				flags[kFLAGS.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY]++;
				outputText("You quickly undress from your [armor], your cock drooling with pre-cum in anticipation of your tongue's magic. You're going to do some stretches so you can be more nimble with your tongue work. You stand straight and spread your leg apart, before leaning back and sticking your erect [cock] forward. After holding for a moment, you switch positions, leaning your chest forward and sticking your [ass] out for all to see – if anyone was around. You alternate leaning back and forth; it looks like you're fucking some invisible bitch. Soon, your spine is nice and limber – working on your legs is next. You stand up straight again, then lift and hold one knee up to your chest, pressing it against your [allbreasts]. This loosens it up a bit, but you know you can be more flexible than that. You support the underside of the leg with your hands and then lift the rest of your leg up, pointing your toes at the sky. You slowly take your hands off your leg, and are astonished that you're able to hold it up by itself. Being naked in this position has allowed your man-meat to be exposed to the elements, and you feel a cool breeze brushing against your cock.  It throbs harder, causing you to coo and moan at the sensation. Your leg feels as limber as your spine, so you switch to the other leg. You immediately launch the other leg up next to your head, not needing the support of your hands to get your ankle behind your ear. You hold the pose for a few minutes, your cock throbbing and leaking pre-cum, eagerly waiting for you to lick and suck it. You soon put the leg down, hornier then you've ever been. You do some quick jaw stretches as you lay down on your bed roll. Throwing one leg over your head, you easily bend your head down to your member.\n\n");
				outputText("Your [cock] is now poking at the left cheek of your [face]; you miscalculated how much flexibility you needed. You use your tongue to guide the eager meat-rod into your dripping wet mouth. Your lips latch around the tip, sucking on it while your tongue rolls around the head. You begin leaning your head forward, bringing the [cock] further into your mouth. Your tongue massages the underside as you stick it out to cover as much cock as you can. Small bits of pre-cum shoot out, sending its salty taste down your throat. You lift your head off and your tongue follows close behind, leaving a trail of saliva and resulting in a slurp as you continue to lick the throbbing head. You take the cock down your throat once more, bobbing your head up and down the shaft while flicking your tongue from left to right. You begin moving your head faster and harder, making you let out lewd gagging sounds, but it feels too good to stop now. Your entire cock is soaked in saliva, dripping down your shaft and onto the ground. Soon you're moving your hips as much as you can; you are no longer giving yourself a blowjob – you're throat-fucking yourself. The lewd, gagging sound grows louder and more aggressive; anyone passing by would think you were choking a chicken.\n\n");
				outputText("Another shot of pre-cum is sent down your throat, followed by the building pressure of your release. You force your head down to the base of your [cock], sending it deeply down your throat, feeling the warm and smooth inside as it tightens around the invading member. Thank goodness you're holding your breath, or you would be suffocating right now. You hurry up before you choke on your cock,  moving your head back and forth while your hand caresses the base of your cock. ");
				if (player.countCockSocks("gilded") > 0 && flags[kFLAGS.GILDED_JERKED] < player.countCockSocks("gilded")) {
					flags[kFLAGS.GILDED_JERKED]++;
					var gemsCreated:int = midasCockJackingGemsRoll(); //Changed as gems caused a duplicate var warning
					outputText("You once again feel a slight chill as you reach the point-of-no-return and you let your [cock] pop free of your mouth. You watch in glee as your seed slit parts to begin the sparkling shower you know is coming. Your cum, caught in the light of the golden cocksock, beads and twists in the light, crystallizing into a glittering shower. A ");
					if (player.cumQ() < 25)
						outputText("sprinkle of");
					else if (player.cumQ() < 250)
						outputText("rain of");
					else outputText("torrent of");
					outputText(" gems falls down upon your body instead of cum, bouncing off your " + player.skinFurScales() + " as you arc your back higher and higher until the only thing touching the ground is the top of your head and the tips of your toes! Your hips continue jerking in the air from the intense orgasm for a little while after the cum stops flowing.\n\n<b>You take a few moments to collect all the glittering gems you just squirted all over the place, all " + gemsCreated + " of them</b>, before curling up and taking a short cat nap.");
					player.gems += gemsCreated;
				}
				else {
					if (flags[kFLAGS.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY] > 10 && player.balls > 1 && rand(5) == 0) {
						outputText("But it's not enough and you are forced to come up for air.");
						outputText("\n\nWhile gasping for air, you scowl at your [cock] in disapproval. That's when your [sack] catches your attention. It's gleaming with your sex sheen and you watch one of your balls slowly slide off to one side.");
						outputText("\n\nYou think you can make it! You throw your other leg over your head and both feet come to rest on your back. You push your mouth towards your [sack], slowly walking your toes down your back. You are only an inch from your [balls] now and your own aroma fills your nostrils, spurring your on. Then, finally, you are there! And it nearly knocks you out! The sensation of your own balls in your mouth is incredible--you can feel them churning in your mouth--and your [feet] start kneeding your back. You bring your hands up to massage your [balls] as well, making them take turns in your mouth. Completely intoxicated by your own scent you loose all track of time--there is only the bliss of sucking, licking, and massaging your own balls...");
						outputText("\n\nAbrubtly you realize that your [eachcock] have soaked your torso in precum--apparently you've been on the edge for some time. In one swift motion, you pick your head up and slam your mouth down over your [cock] leaving your hands to continue their ball massage.");
						//add cum quantity conditional text...
						outputText("\n\nThe release is immediate. You feel the contractions of your climax against your [face], your [feet] involuntarly start massaging your back, and you feel your [cock] expand and contract in your mouth as seed pumps through it into your stomach. It's more relaxing than anything else--each contraction makes you feel like you might be melting a little, like you might remain in this position forever.");
						outputText("\n\nYour [feet] and hands are still masagging their respective charges when you realize you are starting to go flaccid! You make an attempt to massage every last drop of cum from your [balls], sucking on your [cock] continuously as it goes down. It slowly slips from your mouth once it's completely deflated, causing you to frown slightly. Still feeling great in this position, you go down on your [sack] again--alternating between licking and sucking them with your mouth and massaging them with your hands.");
						outputText("\n\nFinally satiated, you begin untangling yourself and realize how sweaty and sticky you are. Again, remembering the cats from your village, you begin to lick ever square inch clean you can reach just like they do and you discover a new form of pleasure. After you lick yourself clean, you stretch out into the spread-eagle position to get a few small kinks out and to admire your naked body glistening in your spit. As you begin to doze off, <b>you think your balls feel a little denser.</b>");
						player.modCumMultiplier(0.3);
					}
					else outputText("This releases the pent - up pressure through your cock and down your throat. It's too much for you to handle; your cheeks fill up with cum and you pull your head back, making a loud popping sound when you finally free your mouth, as the cum pooled in your cheeks spills out all over your cock. Your cock spurts a few more lines of sperm onto your stomach. You stroke the exhausted member a few times, milking the last drops of cum out. Satisfying the final bits of lust, you lay down on the bedroll and fall into a short cat nap.");
					if (player.cumQ() < 1000) player.refillHunger(player.cumQ() / 15);
					else if (player.cumQ() < 3000) player.refillHunger(50 + ((player.cumQ() - 1000) / 30));
					else player.refillHunger(100 + ((player.cumQ() - 3000) / 45));
				}
			}
			//Stats & next event
			//DONE!
			flags[kFLAGS.TIMES_MASTURBATED]++;
			masturGasm("Dick");
			endEncounter();
		}

		public function meditate(description:String = "rock"):void {
			clearOutput();
			outputText("You find a flat, comfortable " + description + " to sit down on and meditate.  As always, meditation brings a sense of peace and calm to you, but it eats up one hour of the day.");
			dynStats("lus", -Math.round(player.maxLust()*0.2), "scale", false);
			dynStats("cor", -.3 - 0.3 * player.countCockSocks("alabaster"));
			if (player.hasPerk(PerkLib.Enlightened) && player.cor < 10) HPChange(50, true);
			fatigue( -10);
			endEncounter();
		}

		private function dualBeltMasturbation():void {
			clearOutput();
			outputText("You look at the thing in front of you and sigh, your [cocks] and [vagina] dripping with fluids. With a nervous sigh you step into the underwear looking device and slip it up your legs, the cold metal feeling so good on your [skin.type], sending a rush of feelings up your body. You slip your [cock] down and into a hole on the front of the belt, the extra length sticking out on the other side of it. Underneath the hole and right above your pussy is another metal square with what feels like a small nub on the inside rubbing against your clit. Shivering from the feeling of it, you stay there for a moment, waiting in anticipation. Finally, you reach down to the side of the belt and flick the switch to the on position.\n\n");
			outputText("The belt whirs to life, shaking on your waist, sending jolts of pleasure through your clit as the small inside nub hits it. \"<i>Ohh...</i>\" Suddenly, the ring around your cock vibrates and then tightens hard around your cock, the belt sinking onto your body and locking in place. Worry sets in instantly as you try to wiggle and take it off, but it is no use. You see something black bubble from the edges of the metal, worried even more that it might be some sort of acid. It begins to creep across your skin at a disturbing rate, going down your [legs] and encasing them in the blackness, wrapping your cock, ");
			if (player.tailType > Tail.NONE) outputText("covering up your tail, ");
			outputText("and then going up your body, covering your [allbreasts] and neck. The only part of your body unclad by the suit is your head. The blackness feels slick and smooth, almost cold, a strange type of feeling washes over you until you realize that it is a rubber suit.\n\n");
			outputText("Before you can do anything else, the belt activates again and the latex covering of your [cock] begins to tighten and pulse around the meat, warming up to feel like a virgin cunt. A moan is dragged from your lips as it begins to ripple and pulse, simulating the feeling of fucking a tight hole as the entire suit molds itself to your body. Before you can get too used to the feeling of the suit milking your cock, the nub that had been teasing your clit suddenly expands and pushes out, the slick feeling of the latex pushing into your pussy.  The hardened black latex splits your tunnel and spreads you wide as it goes in deep. Your eyes widen for a moment as both stop, and then your world explodes in a flash of pleasure. The hardened lump begins to piston in and out of your [vagina], vibrating wildly as a lump grows in on top in precisely the right spot to rub back and forth on your g-spot.\n\n");
			outputText("Meanwhile the latex around your [cock] begins to pulse and ripple faster than ever before. You quake and quiver, [legs] giving out as it teases and pulses around your [allbreasts]. Your hands go down your body helplessly and start stroking at your encased cock, rubbing up and down your length. Unfortunately, all things must come to an end as the pleasure gets to be way too much and you feel yourself cum. Your hips buck wildly as you feel cum spurt into the latex, the end swelling up and filling like a ");
			if (player.cumQ() > 200) outputText("massive ");
			outputText("balloon. ");
			if (player.cumQ() >= 1000) outputText("It grows larger and larger until you are sure it will pop, but it doesn't.  It just sloshes around - a huge bubble, nearly waist high. ");
			outputText("Your eyes close in shivered ecstasy as your cunt spasms and clutches down around the hardened section deep inside of you. ");
			//([If high lactation]
			if (player.biggestLactation() >= 2) outputText("Milk gushes out from your [breasts] as you orgasm, filling the inside of the suit with a slick layer of milk and forming milk bubbles that hang lewdly off your chest. ");
			outputText("However, the suit is far from over as it keeps up all of its actions, keeping you on an orgasmic plateau, making sure you never stop coming. Your hands fall to the side and your body falls down, unable to keep it up as your consciousness fades, the suit still filling with all your fluids.\n\n");
			outputText("When you wake, the black latex is no longer covering your body and the belt is silent around your waist. Cum drips from the tip of your cock and the top part of your [legs] are coated with your feminine juices. ");
			if (player.biggestLactation() >= 2) outputText("Thin streams of creamy milk flow from your [allbreasts], your torso and midsection dripping wet from the stuff. ");
			outputText("Completely sated, you take off the belt, finding it slides off easily, and put it away in your campsite, eagerly awaiting the time you can next use it and have the suit work you over once more.");
			flags[kFLAGS.TIMES_MASTURBATED]++;
			masturGasm("Dick", "Vaginal");
			if (player.lib < 30) dynStats("lib", .5);
			if (player.lib < 50) dynStats("lib", .5);
			if (player.lib < 60) dynStats("lib", .5);
			if (player.sens > 40) player.removeCurse('sens',1, 2)
			if (player.sens > 60) player.removeCurse('sens',1, 2)
			if (player.sens > 80) player.removeCurse('sens',1, 2)
			if (player.tou > 50) player.addCurse("tou", 1, 2);
			if (player.tou > 75) player.addCurse("tou", 1, 2);
			endEncounter();
		}

		private function centaurMasturbation():Boolean {
			clearOutput();
			var canMasturbateHugeCock:Boolean = player.hasCock() && (player.tallness * (5 / 6) < player.cocks[player.longestCock()].cockLength);
			if (player.hasFuckableNipples()) {
				if (canMasturbateHugeCock && rand(2) == 0) { //50/50 chance of either if you can do both
					centaurHugeCock();
					return true;
				}
				centaurNippleCunt();
				return true;
			}
			else if (canMasturbateHugeCock) {
				centaurHugeCock();
				return true;
			}
			sceneHunter.print("Grow a bigger dick :)");
			centaurCantMasturbate(); //Failsafe - you suck.
			return false;
		}

		private function centaurNippleCunt():void {
			outputText("You shrug out of your [armor], ");
			if (flags[kFLAGS.PC_FETISH] > 0)
				outputText("panting lustily as you envision being caught masturbating your [nipple]s.");
			else if (player.cor < 33)
				outputText("blushing a bit as you look down at your [nipple]s.");
			else if (player.cor < 66)
				outputText("shivering as the air hits your exposed [nipple]s.");
			else outputText("smiling to yourself as you blatantly oogle your [nipple]s.");
			outputText("  The openings are soft, sensitive, and slick as you ease a fingertip into ");
			if (player.totalNipples() > 2) outputText("two of ");
			outputText("them.");
			if (player.biggestTitSize() > 2)
				outputText("  The sudden displacement makes your [breasts] jiggle enticingly, and the sudden movement fires arcs of pleasure deep into your body.");
			else outputText("  They're shallow enough that you don't get much more than a fingertip inside them, but the flesh is extraordinarily sensitive, shooting arcs of pleasure deep into your body.");
			outputText("  Your free fingers slowly stroke around the outer edges of your [nipple]s' lips, pausing when you feel a tiny sensitive clit-like nub just inside the top of the opening.\n\n");

			outputText("Shivering with pleasure, you kneel down to prevent your legs from going out from underneath you.   Your [face] flushes hotter as you toy with the slippery nipple-cunts, feeling them growing hard and puffy as you turn yourself on more and more.  ");
			if (player.biggestLactation() > 1)
				outputText("Thick, milky lubricant races down the curvature of your breasts as your self-pleasure inadvertently lets your milk down.");
			else if (player.wetness() >= 3)
				outputText("Rivulets of lubricant race down the curvature of your breasts as your chest-pussies clench around your intruding fingers.");
			else outputText("Slick lubricant squishes around your fingers as you finger-fuck your chest-pussies.");
			outputText("  You moan and lean over, shoving a second finger inside each of them and rubbing your thumbs over the miniature clits as you near orgasm.\n\n");

			if (player.hasVagina() || player.hasCock()) {
				var plural:Boolean = false;
				outputText("Denied a single touch, your ");
				if (player.hasCock()) {
					if (player.hasVagina())
						outputText(player.multiCockDescriptLight() + " and [pussy]");
					else outputText(player.cockDescript());
					//Set as plural if multi dick or dick and vag.
					if (player.hasVagina() || player.cockTotal() > 1) plural = true;
				}
				else outputText("[pussy]");
				if (plural)
					outputText(" leak their own fluid, quivering with ache and need that you can't reach to satisfy.");
				else outputText(" leaks its own fluids, quivering with ache and need that you can't reach to satisfy.");
				if (player.cockTotal() > 1)
					outputText("  You feel each of your [cocks] tapping against your belly as your muscles clench, getting as much pleasure as possible from your male endowments.");
				else if (player.cockTotal() == 1)
					outputText("  You feel your [cocks] tapping against your belly as your muscles clench, getting as much pleasure as possible from your male endowment.");
				if (player.hasBalls()) outputText("  Rocking slightly inside your sack, your [balls] repeatedly clench up against your body, ready to release.");
				outputText("\n\n");
			}
			//(ORGAZMO)
			outputText("A slow wave of contractions starts deep inside each of your [nipple]s.  It intensifies as it rises towards the surface of your [breasts], reaching a crescendo that brings you to the peak of pleasure.  Your eyes roll back as you slump down in orgasmic bliss, fingers pumping relentlessly at you slippery nipple-holes.  Noisy wet squelches and incessant moaning rouse you from your pleasure-induced coma, eventually waking you back to reality.\n\n");
			//Optional post orgasm bits for dicks/pussies
			if (player.hasCock()) {
				if (player.cumQ() < 50) outputText("A small puddle of semen has formed under you, ");
				else if (player.cumQ() < 200) outputText("A decent sized puddle of white seed has formed under you, ");
				else if (player.cumQ() < 1000) outputText("A large puddle of white seed has formed underneath you and even splattered your underside, ");
				else if (player.cumQ() < 2000) outputText("A frothing puddle of thick cum has formed below you, soaking your legs and underbelly, ");
				else outputText("A small lake of semen surrounds you, ");
				outputText("released from your [cocks] by the intense climax.");
				if (player.hasVagina()) outputText("  ");
			}
			if (player.hasVagina()) {
				if (player.wetness() < 2)
					outputText("The scent of pussy hangs in the air, clinging to your moist, puffy cunt-lips.");
				else if (player.wetness() < 4)
					outputText("The air is full of the scent of horny horse-pussy.  If the moist feeling between your hind-legs is any indication, your back-half probably looks and smells like a mare in heat.");
				else if (player.wetness() < 5)
					outputText("The air is saturated with the heady scent of aroused horse-pussy, and if the wetness between your hind-legs is any indication, your hind-quarters would be a slip 'n slide of pleasure for any daring enough to penetrate you.");
				else outputText("The air is filled with the thick musk of your bestial horse-pussy.  If the rivulets of moisture dripping down to your hooves are any indication, you might need to get used to the smell.");
			}
			if (player.hasCock() || player.hasVagina()) outputText("\n\n");
			//Real aftermath
			outputText("Judging by the sky, at least an hour has passed.  You sigh and pry your cramped fingers from your aching [nipple]s, rubbing the sore entrances with your palm before you climb back up onto your [feet].  As you get dressed, you're very conscious of how much better you feel from the wonderful finger-fuck.  ");
			if (player.cor > 66)
				outputText("You can't wait to do it again.");
			else if (player.cor > 33)
				outputText("You're a bit confused by how much you enjoyed the perverse activity.");
			else outputText("You're horrified at what you're doing to deal with your inner perversions.");
			//DONE!
			masturGasm("Vaginal");
		}

		private function centaurHugeCock():void {
			//Set plurality and primary cock.
			var primary:int = player.longestCock();
			var plural:Boolean = (player.cocks.length > 1);
			outputText("You shrug out of your [armor], not that it does much to impede your [cocks] as a centaur.   ");
			if (player.cor < 33)
				outputText("Sighing in disappointment and shame, ");
			else if (player.cor < 66)
				outputText("Sighing in resignation, ");
			else outputText("Smiling with excitement, ");
			outputText("you blush as ");
			if (plural) outputText("each of ");
			outputText("your [cocks] swells out underneath you, hanging down from your equine hindquarters as ");
			if (!plural) outputText("it grows full and hard.");
			else outputText("they grow full and hard.");
			if (plural)
				outputText("  After a moment they peek out from under your forelegs, proudly displaying your [cocks].");
			else {
				outputText("  After a moment it peeks out from under your forelegs, proudly displaying your ");
				if (player.cocks[primary].cockType == CockTypesEnum.HORSE) outputText("flared tip");
				else if (player.cocks[primary].cockType == CockTypesEnum.DEMON) outputText("nodule-ringed head");
				else if (player.cocks[primary].cockType == CockTypesEnum.DOG) outputText("pointed erection");
				else if (player.cocks[primary].cockType == CockTypesEnum.TENTACLE) outputText("wriggling, mushroom-like tip");
				else if (player.cocks[primary].cockType == CockTypesEnum.CAT) outputText("spiny head");
				else if (player.cocks[primary].cockType == CockTypesEnum.LIZARD) outputText("pointed, purple tip");
				else if (player.cocks[primary].cockType == CockTypesEnum.ANEMONE) outputText("tentacle-ringed head");
				else outputText("dome-like head");
				outputText(".");
			}
			if (player.tallness * 1.5 < player.cocks[player.longestCock()].cockLength) {
				outputText("  In no time flat you're rendered virtually immobile by the length of ");
				if (plural) outputText("all ");
				outputText("your [cocks].");
			}
			outputText("\n\n");
			//Get started (not THAT long)
			if (player.tallness * 1.5 >= player.cocks[player.longestCock()].cockLength) {
				outputText("Bending down and grabbing hold with both hands, you take ");
				if (plural)
					outputText("a ");
				else outputText("your ");
				outputText(player.cockDescript(primary) + " and lift up, pressing it tightly against your belly as you begin to stroke along the sensitive underside.  ");
				if (player.cumQ() > 500)
					outputText("Thick streams of pre-cum start to drizzle from your tip, forced out due to your prodigious production of sexual fluid.");
				else if (player.cumQ() > 100)
					outputText("A dribble of pre-cum starts to leak from the tip as you get more into the act.");
				else outputText("A tiny dollop of pre-cum slowly builds on your tip as you get into the act.");
				if (player.hasVagina()) outputText("  Your neglected [vagina] aches for penetration, but there's no way you'll be able to reach it in your current state.");
				outputText("  You sigh, delighted that you're able to caress at least one of your sexual organs with this body");
				if (player.cor < 40) outputText(", but you're also worried that you're falling into the perversion that lurks in this strange world");
				outputText(".  It feels so good that you close your eyes and whinny with delight.\n\n");
				outputText("You smear your pre-cum over the tip, rolling your palm across the sensitive tip in a way that makes it hard to stand.  Meanwhile your other hand is busy fondling the underside, stroking what little of your length you can reach.  Even with the limited access, you can feel your " + player.cockDescript(primary) + " pulsing in your grip, growing harder with every touch and caress.");
				if (player.cockTotal() == 2)
					outputText("  Your other dick mimics its lucky brother's pleasure, even though it's been ignored in order for you to focus on your current 'toy'.");
				else if (player.cockTotal() > 2)
					outputText("  Your other [cocks] mimic their lucky brother's pleasure, even though they've been ignored in order for you to focus on your current 'toy'.");
				outputText("  You let your hind legs give out and slump down, locking your forelegs while you tremble with what can only be the approach of an orgasm.\n\n");
			}
			//Get started (long)
			else {
				outputText("Bending down and grabbing hold with both hands, you take ");
				if (plural)
					outputText("a ");
				else outputText("your ");
				outputText(player.cockDescript(primary) + " and lift it up, curving it slightly as you begin to stroke the underside with long, fluid caresses.  You even manage to bend down and give it a lick, forcing you into a pleasurable shudder.");
				if (player.cumQ() > 500)
					outputText("  Thick streams of pre-cum start to drizzle from your tip, forced out due to your prodigious production of sexual fluid.");
				else if (player.cumQ() > 100)
					outputText("  A dribble of pre-cum starts to leak from the tip as you get more into the act.");
				else outputText("  A tiny dollop of pre-cum slowly builds on your tip as you get into the act.");
				if (player.hasVagina()) outputText("  Your neglected [vagina] aches for penetration, but there's no way you'll be able to reach it in your current state.");
				outputText("  You sigh, delighted that you're able to caress your sexual organs with this body");
				if (player.cor < 33) outputText(", but you're also worried that you're falling into the perversion that lurks in this strange world");
				outputText(".  It feels so good that you close your eyes and whinny with delight as your hands fondle your massive length.\n\n");
				//STROKE (long)
				outputText("You smear your pre-cum over the tip, rolling your palm across the sensitive tip in a way that makes it hard to stand.  Meanwhile your other hand is making great use of your incredible length, jacking you off with long fluid strokes.  In no time flat, you can feel your [cock] pulsing in your grip, growing harder in time with your fevered stroking.");
				if (player.cockTotal() == 2)
					outputText("  Your other dick mimics its lucky brother's pleasure, even though it's been ignored in order for you to focus on your current 'toy'.");
				else if (player.cockTotal() > 2)
					outputText("  Your other [cocks] mimic their lucky brother's pleasure, even though they've been ignored in order for you to focus on your current 'toy'.");
				outputText("  You let your hind legs give out and slump down, locking your forelegs while you tremble with what can only be the approach of an orgasm.\n\n");
			}
			//Cumjaculation
			if (player.tallness * 1.5 >= player.cocks[player.longestCock()].cockLength)
				outputText("Squeezing tightly around your " + player.cockHead());
			else outputText("Pumping hard");
			outputText(", you orgasm, feeling relief flow through you with every pump of ");
			if (player.hasBalls())
				outputText("your " + player.ballsDescriptLight());
			else outputText("release");
			outputText(".  You arch your back as you blast out your seed, shuddering and spraying it into the air.  It splatters wetly against a rock, oozing down the now-slimy surface ");
			if (player.cumQ() < 50)
				outputText("as you finish unloading against it.");
			else if (player.cumQ() < 200)
				outputText("as you continue to pump more and more seed onto it.");
			else if (player.cumQ() < 500)
				outputText("as you continue to fountain more and more spooge over it.  By the time you finish there's a small puddle at the base and you've thoroughly glazed the rock in question.");
			else if (player.cumQ() < 1500)
				outputText("as you continue to blast it with cum.  Spooge puddles underneath it, slowly spreading while it soaks into the barren ground.");
			else {
				outputText("as you continue to erupt cum all over it.  The thick spooge forms a thick puddle at the base, spreading until your hooves are coated in it.");
				if (player.cumQ() > 3000) outputText("  As you finish cumming, the puddle deepens.  It's inches thick and splattering everywhere whenever you take a step.");
			}
			outputText("  You slump back, still shuddering from the pleasure as you feel your ");
			if (!plural)
				outputText("member");
			else outputText("members");
			if (player.hasSheath()) {
				if (plural)
					outputText(" slowly grow limp and slide back inside your sheath.");
				else outputText(" slowly growing limp and sliding back inside your sheath.");
			}
			else if (player.minLust() > 40 || player.lib > 50) {
				if (plural)
					outputText(" grow slightly less hard.  As much as you seem to need sex, that doesn't surprise you.");
				else outputText(" growing slightly less hard.  As much as you seem to need sex, that doesn't surprise you.");
			}
			else {
				if (plural)
					outputText(" slowly grow limp, shrinking.");
				else outputText(" slowly growing limp, shrinking.");
			}
			outputText("\n\n");
			//Cunt cums
			if (player.hasVagina()) {
				if (player.wetness() <= 1)
					outputText("A trickle of wetness oozes down your thighs, filling the air with the scent of centaur sex from your orgasm.");
				else if (player.wetness() == 2)
					outputText("Fluids leak down your thighs, filling the air with the scent of centaur sex as you orgasm.");
				else if (player.wetness() == 3)
					outputText("Thick, clear fluid soaks your thighs, filling the air with the scent of liquid centaur sex as you orgasm.");
				else if (player.wetness() == 4)
					outputText("Thick fluid coats your thighs and drips into a puddle on the ground, filling the air with the pungent aroma of liquid centaur sex as you orgasm.");
				else outputText("Spatters of fluids gush out from between your thighs, coating your upper legs in a thick coat of clear feminine lubricant as you orgasm.  The air is filled from the scent of your liquid centaur lust as more and more drips into a rapidly expanding puddle between your rear legs.");
				if (player.hasFuckableNipples()) {
					if (player.totalNipples() > 2)
						outputText("All");
					else outputText("Both");
					outputText(" of your " + num2Text(player.totalNipples()) + " [nipple]s quiver, ");
					if (player.wetness() < 4 && player.biggestLactation() < 2)
						outputText("leaking");
					else if (player.wetness() < 5 && player.biggestLactation() < 3)
						outputText("dripping");
					else outputText("squirting");
					outputText(" equal quantities of ");
					if (player.biggestLactation() < 1)
						outputText("clear");
					else outputText("milk-laced");
					outputText(" lubricant.  You pause to finger their entrances, shivering unconsciously as you slowly come down.");
				}
				outputText("\n\n");
			}
			outputText("Sated for now, you rest for an hour or so before climbing back atop your hooves.");
			//DONE!
			masturGasm("Dick");
		}

		private function centaurCantMasturbate():void {
			if (flags[kFLAGS.UNABLE_TO_MASTURBATE_BECAUSE_CENTAUR] == 0) {
				outputText("No matter how you twist and turn, you can't reach anywhere close to your ");
				if (player.hasCock() || player.hasVagina())
					outputText("genitalia");
				else outputText("anything remotely sexual");
				outputText("!  It seems that being a centaur has a rather crippling downside – you can't reach around to get yourself off and sate your lusts!\n\n");
				flags[kFLAGS.UNABLE_TO_MASTURBATE_BECAUSE_CENTAUR]++;
			}
			else {
				outputText("You still can't reach around to masturbate yourself.  Being half-horse sure is inconvenient!\n\n");
			}
			//(If Milker)
			if (player.hasKeyItem("Cock Milker - Installed At Whitney's Farm") >= 0 && player.cocks.length > 0)
				outputText("Perhaps you could visit the cock-milker you have set up at Whitney's farm and drain off the arousal?  Or maybe you'll just have to find a willing partner somewhere.");
			else outputText("It looks like you'll have to find a partner to relieve your pent up need, but in your current state you'll probably be on the receiving end of whatever you can get!");
		}

		//[Maturbate] -- [Fake Mare] (Cock Centaurs Only)
		private function centaurDudesGetHorseAids():void {
			var x:int = player.biggestCockIndex();
			clearOutput();
			if (player.keyItemvX("Fake Mare", 1) == 0) {
				if (player.cor < 50)
					outputText("Deciding to give the mare-like cocksleeve you got from Whitney a try, you spend a few awkward minutes dragging the lump of metal off to someplace secluded and setting it up.  When you're done, you stand behind a wood-and-iron replica of a mare, adjusted to the perfect height for you.  Looking \"<i>her</i>\" over, your eyes are drawn to the slick black lips of the Onahole between her legs, craftily shaped like a horsecunt, and what looks like a second, smaller one above it simulating an anus.\n\n");
				//[If Med-High Corruption:]
				else outputText("You decide to play with the mare-shaped cocksleeve Whitney gave you.  You pull it out of your stash and spend a few minutes setting it up in the heart of camp.  Once done, you stand behind a wood-and-iron replica of a mare, adjusted to the perfect height for you.  Looking \"<i>her</i>\" over, your eyes are drawn to the slick black lips of the Onahole between her legs, craftily shaped like a horsecunt, and what looks like a second, smaller one above it simulating an anus.\n\n");
			}
			outputText("Seeing the toy's exposed, gaping genitals, you feel a stirring in your [cocks].  You yearn to touch yourself, but your centaur lower body prevents you, as usual.  Grunting with annoyance, you trot up to the toy and give its wide cunt an experimental fisting.  ");
			//[If small cock:
			if (player.cockArea(x) < 30)
				outputText("Your hand slips in easily... since it's made for real horsecocks, it's a bit too big to give you any satisfaction.  Your gaze shifts upwards to the toy's fake anus, which seems a bit more your size.</i>\"");
			else outputText("Your fist slips in easily, and you give the toy a few preparatory thrusts to make sure it's nice and ready for your hefty cock.");
			outputText("\n\n");

			outputText("Satisfied the toy is ready for you, you clop back a few paces and surge forward.  You mount the toy easily, your belly running across its smooth, warm back until your chest bumps against the mare's head.  You grip her shoulders for support and start to buck your hips, your " + player.cockDescript(x) + " poking around in search of entrance.  Finally, you feel the tip of your prick ");
			if (player.cockArea(x) < 30)
				outputText("pressing against the tight ring of the toy's anus");
			else outputText("lining up with the toy's gaping cunt");
			outputText(".  You rear your " + hipDescript() + " and slam yourself into the mare's waiting hole.\n\n");

			outputText("The toy's passage seems to shift and contract around your " + player.cockDescript(x) + ", molding itself to perfectly sheathe you.  What a marvelous little toy!  You slide on up until you hilt yourself, your crotch pressed against the mare's wide ass as your [chest] squeezes against her back.  Now fully mounted, you begin to rut on the mare toy, slapping your hips");
			if (player.hasBalls())
				outputText(" and " + player.ballsDescriptLight());
			outputText(" hard against her rump as you pound into her tight, slick ");
			if (player.cockArea(x) >= 30)
				outputText("horsecunt");
			else outputText("asshole");
			outputText(".\n\n");

			outputText("Finally able to get the release you weren't able to give yourself, you feel an orgasm mounting deep within you.  You let out a loud, equine whinny as you hump the toy faster and faster, pounding her with your " + player.cockDescript(x) + " until the pleasure overwhelms you.  You cry out as you cum, squirting your centaur-cum as far into the toy as you can shoot it");

			if (player.countCockSocks("gilded") > 0 && flags[kFLAGS.GILDED_JERKED] < player.countCockSocks("gilded")) {

				flags[kFLAGS.GILDED_JERKED]++;

				var gems:int = midasCockJackingGemsRoll();

				outputText( ".\n\nSated, you spend a few blissful minutes enjoying the warmth and tightness of the mare-like onahole until your " + player.cockDescript(x) + " is soft inside it.  You scamper off of her, dropping back to your four equine feet.  <b>You are startled to see glittering gems pouring from her ");
				if (player.cockArea(x) >= 30)
					outputText("horsecunt");
				else outputText("asshole");
				outputText( " and you scramble to gather all " + gems + " of them up.</b> Satisfied you didn't miss any shinies, you disassemble the toy and haul it off back to your stash.");

				player.gems += gems;
			}
			else {
				outputText(", until she's full up and leaking onto the ground.\n\n");
				outputText("Sated, you spend a few blissful minutes enjoying the warmth and tightness of the mare-like onahole until your " + player.cockDescript(x) + " is soft inside it.  You scamper off of her, dropping back to your four equine feet.  With a contented yawn, you disassemble the toy and haul it off back to your stash, leaking your cum the entire way.");
			}
			masturGasm("Dick");
			endEncounter();
			player.addKeyValue("Fake Mare", 1, 1);
		}

		//[Masturbate] -- [CentaurPole] -- [Fem/Herm Centaurs]
		private function centaurGirlsGetHorseAids():void {
			clearOutput();
			if (player.keyItemvX("Centaur Pole", 1) == 0) {
				//[If low Corruption:]
				if (player.cor < 50)
					outputText("Feeling a bit antsy, you decide to give Whitney's so-called \"<i>Centaur Pole</i>\" a try.  You dig it out of your stash and spend a few awkward minutes dragging it off someplace secluded and setting it up.\n\n");
				//[If Med-High Corruption:]
				else outputText("Unable to sate your own lusts due to your centaur configuration, you decide to put one of Whitney's centaur toys to use.  You dig the Centaur Pole out of your stash and drag it to the middle of camp.\n\n");
			}
			outputText("When you've got it ready, the \"<i>Pole</i>\" is actually quite impressive.  It's a large metallic statue of what seems to be a particularly well-endowed imp, equipped with a huge, flared horsecock displayed proudly between his muscular legs.  You give the tremendous purple cock a few experimental strokes, and to your delight it inflates just like a real boner, becoming rock-hard in your grasp.  You lick your lips and, unable to resist, take the cock into your mouth.\n\n");

			outputText("Though it tastes rubbery, the heft and size of the prick feels... right... inside you.  You spend a few blissful minutes sucking off the horse dildo, getting it nice and wet and ready for you.  When you're satisfied the imp-statue's wang is sufficiently lubed up, you let it pop out of your mouth and, making sure it's still standing straight out of the statue, you turn around.\n\n");

			outputText("Your " + hipDescript() + " wiggle in anticipation as you work to get your ready [vagina] lined up with the horse dildo.  Unable to see the toy past your equine rump, it's a long, desperate minute until finally you feel its flared head against your horsecunt.  You shimmy back, gasping in delight as the meaty horsecock pushes into you.  It seems to inflate and expand inside you as you take it, until you're completely and utterly full of purple rubber -- and then some.  You grunt as the cock continues to grow, stretching your [vagina] until you let out a pained whimper.");
			player.cuntChange(player.vaginalCapacity() - 3, true, true, false);
			outputText("\n\n");

			outputText("Just then, though, the cock seems to stop.  You grunt and groan as it settles inside you, finally letting out a relieved sigh when it's only giving you a modest, pleasant stretching.  Now that you're stuffed full of fake horsecock, though, you're not sure what to do... \"<i>EEP!</i>\" you yelp as the imp-statue's hands suddenly reach out and grasp your " + hipDescript() + ".  Your eyes go wide as you feel the thick dildo withdraw from your cunt, the imp's hips pulling back.\n\n");

			outputText("You have time only to let out a desperate curse before the toy rams itself back into you.  You try to leap forward from the massive, yet mind-numbingly pleasurable, impact, but its strong hands hold you fast.  You yelp and scream as the statue begins to fuck you roughly, making forceful thrusts deep into your [vagina] until the dildo is battering your cervix.  Something inside the cock begins to contract and expand, altering the thickness and heft of the rod inside you, stretching the walls of your cunt even further until your tongue hangs out and your eyes roll back, overwhelmed with pleasure.\n\n");

			outputText("You sense your own orgasm coming as a hot, sticky fluid rushes into you.  You scream your pleasure as the statue unloads a load of hot faux-spunk into your womb, flooding your cunt with its strange seed.  So utterly and completely filled, you cannot hold back your orgasm.  You cum, your [vagina] clamping down hard on the fake cock buried inside you, milking it for more and more of its thick, creamy spooge.\n\n");

			outputText("When your climax finally passes, you've collapsed on all fours, swaying light-headed as the statue continues to leak a steady trickle of spooge onto your [ass].  You stagger to your legs and begin to disassemble the pole.  You drag it back to your stash, your hips making a lewd squishing noise with every step as globs of fake cum leak out of your horsecunt.");
			masturGasm("Vaginal");
			endEncounter();
			player.addKeyValue("Centaur Pole", 1, 1);
			trace("Times Ridden Pole" + player.keyItemvX("Centaur Pole", 1));
		}

		//Self/Exgartuan
		//Bee Eggs in Huge Cock: Finished (Slywyn) (edited)
		private function getHugeEggsInCawk():void {
			clearOutput();
            if (flags[kFLAGS.TIMES_EGGED_IN_EXGARTUAN] == 0) {
				if (SceneLib.exgartuan.dickAwake()) {
					eggExgartuan();
					return;
				}
				else sceneHunter.print("Check failed: Exgartuan in dick and awake.");
			}
            eggDickNormal();
        }


			//Bee Eggs in Huge Cock + Exgartuan: Finished (Slywyn)(edited)
			public function eggExgartuan():void {
                clearOutput();
				//requires Exgartuan awake
				outputText("You decide it's time for a little fun.");
				outputText("\n\nRemoving your [armor], you settle down ");
				if (player.cor >= 66) {
					outputText("in your bedroll");
					if (camp.hasCompanions()) outputText(", hoping one of your companions sees");
				}
				else if (player.cor >= 33)
					outputText("behind a rock to hide your sight if not sound");
				else outputText("in the wastes just outside of camp to be out of sight and mind");
				outputText(" while you take care of your endowments.");

				outputText("\n\nReaching up as you lay on your back, you take hold of your [cock biggest], beginning to stroke the length of it with both hands, marveling at the size.  You can feel Exgartuan stirring within, ready and eager for some action at last.  At the same time, you can feel the eggs shifting within your bee half, awakening your lust even further, and an amusing idea springs forth in your mind.  You flex muscles you can still barely control, and though it is difficult, you manage to curl your abdomen up, stinger pointing toward your own cock.  It is at this point that Exgartuan seems to realize that something's going on.");

				outputText("\n\n\"<i>Uh?  Champion... get that thing away from me.</i>\"");

				outputText("\n\nYou grin, flexing your muscles, and the slit next to your stinger opens; your ovipositor slides out freely, the flaccid tube hardening as your lust rises even further thanks to the visions of debauchery flowing through your mind.  You take your [cockHead 1] in hand and bend it toward your ovipositor, intending to bring the two together and see if it's really possible for you to lay your eggs down your own massive length.");

				outputText("\n\nThe demon within you, realizing just what's going on and wanting no part in it, begins to fight back.  Thus begins a struggle for your own body, as he attempts to both tug your [cock 1] away from your bee-half, and stimulate your length with his own magic and your hand so that you orgasm and feel no need to continue anyway.  You");
                if (SceneLib.shouldraFollower.followerShouldra() && !player.hasStatusEffect(StatusEffects.ShouldraOff)) outputText(", with Shouldra's assistance,");
                outputText(" manage to fight him, keeping your cock in place.  With his attention distracted, you're able to lower your ovipositor directly to the tip of your cock, and with a flex and a shove, you manage to force it in.");

				outputText("\n\nYou feel your slit stretching with a feeling unlike anything you've ever experienced, being both the penetrated and the penetrating at the same time.  A lewd moan rolls from your lungs, and your back arches from the sheer pleasure of the sensation; unbidden, an egg attempts to push down into your cock, spreading the slit further.");

				outputText("\n\n\"<i>This isn't happening!</i>\"");

				outputText("\n\nAgainst your will, you can feel the demon within your [cock biggest] beginning to push... something up through your urethra, as if to block the passage of the egg.  Creamy white leaks from your tip as the pressure builds within you, and you realize that he's using your own cum against you!  You haven't orgasmed, but the crafty demon seems to have more control over your body than you realized.  Fighting back, you thrust your ovipositor deeper, and with a mighty shove you actually force the next few inches within, egg and all.");

				outputText("\n\nThe sensation nearly causes you to black out, your girth stretching more than you can ever remember to accept this invader within you, and you curl up even further atop yourself, the anticipation goading you on.  You shove more of your egg-laying tube down your length, and now stimulating honey begins to seep from the hole of your bloated and bulging cock along with the remnants of the cum that Exgartuan was trying to use against you.  Perhaps now resigned to his 'fate', the demon seems to have gone silent - though knowing him he's merely planning something else.");

				outputText("\n\nMore eggs begin to rise up from your abdomen, one after the other beginning to shove its way down your poor stretched length.  The first is nearly halfway down your " + num2Text(player.cocks[player.biggestCockIndex()].cockLength) + " inches, and you feel another entering your slit.  Then you feel something else deep within, something that drops your jaw.  Your cock begins to lurch, as if beginning to orgasm, and you realize what Exartuan is doing. He's trying to make you climax to force the eggs out!");

				outputText("\n\nYou struggle, ");
                if (SceneLib.shouldraFollower.followerShouldra() && !player.hasStatusEffect(StatusEffects.ShouldraOff)) outputText("ghost-assisted ");
                outputText("will versus demon-induced orgasm, eggs versus cum, and you actually appear to be losing.  The base of your cock bulges out as you moan, rapidly filling and bloating with gathering seed, and you can feel orgasmic pressure rising as the demon turns the tide, so to speak.  Your eyes roll back up into your head, lids beginning to close, when you see your salvation.  Your stinger!  It hangs just above the tip of your cock, and though you dread what you're about to do, you hope that it will be able to give you the edge over your demon companion.  You steel yourself for what must be done.");

				outputText("\n\nFlexing and clenching up as you anticipate what's to come, you drive your stinger toward your own [cockHead].  You nearly cry out from the pain as your venomous needle stabs into your length, piercing it, but your bee parts autonomously drive their lust-and-pleasure-inducing venom directly into your cock.  The combined pleasure and pain draw a fog over your eyes, but within moments the pleasure begins to mask everything else, and you find yourself a panting heap, tongue hanging from your [face] as you pour all the venom you can manage directly into your poor abused cock.");

				outputText("\n\nThis sends your ovipositor into overdrive, and one after the other eggs are forced down your bulging length, pushing your cum further back down within you, and clinching your victory against the demon.  Barely coherent, you can feel egg after egg sliding down your length, and you watch as egg-shaped bulges slowly sink down your urethra, heading toward your ");
				if (player.hasBalls())
					outputText("[balls]");
				else outputText("[hips]");
				outputText(".");

				//[If balls:]
				if (player.hasBalls()) {
					outputText("\n\nThe eggs push toward your testicles; you begin to anticipate once again just what's going to happen when they reach those overfull orbs resting against the ground.  You feel one egg pushing against some kind of entrance and squint your eyes as pressure builds within your cock; the eggs are beginning to back up against one another.  You strain and push, and finally feel something give way.  The sensations are an exquisite mix of pleasure and sickness as one egg after another forces its way into your heavy sack");
					if (player.fertilizedEggs() > 0) outputText(", and you know beyond a doubt that they'll be fertilized before much longer and you'll be able to lay your own eggs");
					outputText(".");
				}
				//[If no balls:]
				else {
					outputText("\n\nAs the eggs push within you, you can feel pressure building somewhere within your abdomen as they meet some sort of blockage.  It feels incredibly strange, yet deliciously delightful at the same time, and you flex and strain to force them past whatever's keeping them in place.  You feel the blockage give way, and glorious, warm, sticky bliss fills you as egg after egg rubs past your prostate and drops down into whatever space inside you that they can find.");
				}
				if (player.hasBalls())
					outputText("\n\nYour sack begins to bulge with its knobbly load");
				else outputText("\n\nYour belly begins to bulge with an obvious, though strange, pregnancy");
				outputText(", egg after egg forcing its way into you until you have nothing left to give from your ovipositor, and it begins to withdraw from your length.  You finally pull it free with a loud 'schlick' sound, and go limp against the ground as you recover from your ordeals.");

				outputText("\n\nAs you begin to drop off into a brief nap, you can hear Exgartuan's voice in your head.  \"<i>That wasn't as bad as I thought...</i>\"");

				outputText("\n\nYou manage to laugh once or twice before your fatigue overtakes you and you drift off into sleep.");
			    if (!recalling) {
	                outputText("\n\n<b>New scene is unlocked in 'Recall' menu!</b>");
                    flags[kFLAGS.TIMES_EGGED_IN_EXGARTUAN]++;
                    eggDickEnding();
					SceneLib.exgartuan.dickSleep(48 + rand(24));
                } else doNext(recallWakeUp);
			}

			private function eggDickNormal():void {
				outputText("Feeling a little bit randy, you slip ");
				if (player.cor >= 66){
					outputText("into your bedroll");
					if (camp.hasCompanions()) outputText(", hoping one of your companions sees");
				}
				else if (player.cor >= 33)
					outputText("off behind a rock to hide your sight if not sound");
				else outputText("into the trees outside of camp to be out of sight and mind");
				outputText(" and  strip yourself out of your [armor].  You can feel  your abdomen swaying heavily behind you, reminding you that it's been some time since you laid any eggs.  This presents you with a problem. You'll continue to feel full of eggs until you get rid of them, but you want to masturbate right now; there are no able receptors anywhere nearby.");

				outputText("\n\nYou get yourself comfortable and begin to stroke your cock, eyes closing as you lose yourself to the pleasure.  Your length hardens further, feeling full in your hand, and an errant thought sparks through your mind.  What if you were the receptacle?  Your eyes open, and you look down at yourself.  Unbidden, your ovipositor has already extended from your bee-half, and is dripping golden-colored, sweet-smelling honey on the ground.  You begin examining yourself, pondering just where it might be possible to lay eggs within your own body to relieve your burden.");

				//[If herm:]
				if (player.gender == 3) {
					outputText("\n\nYou examine your cock");
					if (player.cocks.length > 1) outputText("s");
					outputText(" as well as your pussy, and decide to try the latter first.  You flex your still-unfamiliar muscles and curl your abdomen back across yourself, straining to pull it into place, but it just isn't flexible enough to curl that far. Even using your arms, ");
					if (player.str > 50) outputText("even with your considerable strength, ");
					outputText("you cannot manage to bend it far enough to get there.  You actually start to feel a pain where your abdomen connects to the rest of your body, and you disregard this as a bad idea.");
				}
				//[If male:]
				else outputText("\n\nYou look down at yourself, and suppose that you could try the one hole that you do have. You begin to flex your abdomen to curl it in upon your anus, but you quickly realize that without removing your abdomen from your body, a prospect you don't really want to entertain, that this will be impossible.");

				outputText("\n\nLeft with only the possibility of your cock, you look down at it curiously.  If you weren't as big as you are now, you'd dismiss this entirely out of hand.  However... you take your [cock biggest] into hand, and give it a few strokes to get it back to throbbing hardness.  Your abdomen is curled up over yourself, and one hand rests thoughtfully on your chin as you ponder the possibilities.  You suppose it couldn't hurt, and you are committed by now to at least trying to lay eggs within yourself.");

				outputText("\n\nYou curl your ovipositor inward just a bit farther, and you find that - yes, you actually can reach.  Overtaken with curiosity as well as lust, you extend the tubular organ toward yourself, and using your hands, help your cock and the honey-dripping thing to meet.  You're stymied with a momentary impasse as you realize that the ovipositor alone doesn't quite fit, much less the eggs you feel cramping your abdomen.  But desperation makes you think - looking at the hole, it's almost large enough.");

				outputText("\n\nDeciding to go for broke, you try it.  A push, a shove, a little straining, and... you groan out loud as your ovipositor neatly stretches your slit wide and slides on in, your own pre-cum and leaking honey doing wonders to lubricate the opening.  You rest for a moment to bask in the sensations of penetrating yourself with your own body, an act that you wouldn't have even been able to consider, much less perpetrate, before coming to this land.");
				outputText("\n\nYou rest for a moment to simply bask in the pleasure, but the insistent throbbing as well as the weight of eggs you're currently holding aloft in your abdomen quickly bring you back down to earth... in a manner of speaking.  You waste little time in beginning to thrust, made awkward by your positioning, but in no time flat you manage to create a rhythm that you're able to maintain without hurting several parts of your body.");

				outputText("\n\nPre flows freely up your cock; when it manages to burble up around your ovipositor, you can feel your lust growing as your warm fluid coats the black organ and the arousal-inducing honey from your bee-half begins to seep into the vacuum left and take hold.  You speed up your thrusts as much as you can, beginning to pant and moan in equal measure from the debaucherous machinations of your ");
				if (player.cor >= 75)
					outputText("corrupted ");
				else outputText("transformed ");
				outputText("body.  You thrust deeper, feeling an egg beginning to slide through your ovipositor, and by now you're aching to feel it push itself down your cock.");

				outputText("\n\nAs you thrust, you begin to feel something prick against your [cockHead], but you quickly dismiss it in favor of continuing to drive yourself further toward what you know is going to be one of the strangest, and best, orgasms you've ever felt.  This is a dubious move as within a moment, you feel something stab into your cockhead and your world nearly goes white with pain.");

				outputText("\n\nYour stinger!  You've forgotten all about it in your lust-addled state of mind, and now you've managed to sting yourself, directly in your cock.  Venom is already flowing into your prick, and you do nothing to stop it once you realize just how good things are going to feel in a moment. Sure enough, within a few seconds a haze of lust seems to settle down around you as your stinger withdraws, and you can feel several more eggs pushing their way toward your cock, the first nearly at your stretched cockhead.");

				outputText("\n\nAll it takes is a little more pushing, and you relax to enjoy what's coming.  An egg butts up against your tight slit, and for a moment you worry that it isn't going to fit.  Then, you feel yourself stretching further, drawing a long moan from between your lips as the orb forces through the opening and slides in.  Several more follow, nearly backed up within you at this point, and you lose yourself to the contractions as egg after egg is forced down your bulging cock, to the point that you can actually see them travelling down your distended urethra, sojourning toward your ");
				if (player.hasBalls())
					outputText("[balls]");
				else outputText("[hips]");
				outputText(".");

				//[If balls and unfertilized eggs:]
				if (player.hasBalls()) {
					outputText("\n\nYou begin to anticipate the ending of their journey, wanting to see your sack fill with your own eggs, knowing that they'll be immediately fertilized by your own cum.  You idly wonder if this would be considered masturbation, incest, or cloning, but those thoughts are lost as the first egg reaches the base of your cock and the end of its journey.  It disappears within you, and for a moment you wonder if it's gone the wrong way.  However, immediately after you feel it pressing against some sort of resistance within you that tightens your stomach, and you're forced to strain muscles to attempt to help it along.");
					outputText("\n\nSucceeding, you manage to force the egg deeper into your body, where after stroking your prostate, it deposits itself neatly into your sack.  ");
					if (!player.isTaur()) outputText("More begin to follow, and you massage your quickly-bloating balls as they fill with egg after egg after egg.  ");
					outputText("Your gut protests slightly, but with the tranquilizing effects of the honey and venom, the discomfort is nearly nonexistent.");
					//[endballs]
				}
				//[If no balls and unfertilized:]
				else {
					outputText("\n\nYou begin to anticipate the ending of their journey, wondering just where your eggs are going to end up; you can only imagine it'll be the same place your cum comes from, which means they'll be instantly fertilized by you.  Pondering briefly if this is some odd form of cloning, those thoughts are driven from your mind as the first egg pushes its way through the base of your cock and deeper into your body.  A groan escapes as you feel it push up against some kind of blockage within you, and you strain to force it deeper inside.");

					outputText("\n\nYour efforts pay off as the egg slips past the resistance and settles somewhere within you, triggering a small involuntary orgasm as it pushes by your prostate, and several more orbs quickly follow suit, fording the flow of semen that tries to push them the other way.");
				}
				outputText("\n\nYou bask in the sensations of filling yourself with eggs and narcotic honey for several more minutes as the pleasurable contractions continue, but as always seems to happen, the good times end as you run out of spheres to push within.  Withdrawing your ovipositor, you lie limp upon the ground, relaxing as you bask in the sensations of a job well done.  A quick nap claims you");
				if (!player.isTaur()) {
					outputText(" as you idly fondle your ");
					if (player.balls == 0)
						outputText("swollen belly");
					else outputText("bulging sack");
				}
				outputText(", and you dream of laying your own eggs some time in the future.");
                eggDickEnding();
			}

        private function eggDickEnding():void {
			if (player.fertilizedEggs() > 0 && flags[kFLAGS.DICK_EGG_INCUBATION] == 0) {
				flags[kFLAGS.DICK_EGG_INCUBATION] = 48;
			}
			player.dumpEggs();
			masturGasm("Dick");
			endEncounter();
		}

		//Birth Bee Eggs Out Your Wang: Finished (Slywyn)(edited)
		public function birthBeeEggsOutYourWang():void {
			outputText("\nYou feel more lusty and aroused than usual.  As you notice the feeling, it gets worse and worse; though you try to continue on with whatever it is that you're doing, by now you're far too distracted to continue.  All you can do is plop right down on the ground and prepare to masturbate, as it seems to be the only thing your body's going to allow you to do at this point.");

			outputText("\n\nQuickly shedding your [armor] and plopping down on your [ass], you make sure not to smash your abdomen in the process.  Your ");
			if (player.hasBalls())
				outputText("balls feel");
			else outputText("stomach feels");
			outputText(" heavy, and ");
			if (player.isTaur())
				outputText("y");
			else {
				outputText("you caress ");
				if (player.hasBalls())
					outputText("them");
				else outputText("it");
				outputText(" with the hand not already actively stroking your [cock biggest].  Y");
			}
			outputText("ou feel something within you shifting; it's time to lay your eggs!");

			outputText("\n\nYou lie back on the ground and groan as your [cock biggest] quickly grows to full hardness in your hand, feeling your ");
			if (player.balls == 0)
				outputText("stomach");
			else outputText("balls");
			outputText(" shift as your eggs begin to attempt their journey outward.  Your strokes speed up; your lust only rises while the eggs move, and before much longer you're arching your back and thrusting your hips, practically fucking your hand, losing yourself to the pleasure of the act.");

			outputText("\n\nYou begin to feel something pushing at the base of your cock, and all pre-flow from within you ceases as the first egg plugs up your length.  Redoubling your stroking to attempt to force the damn thing out fails... it seems stuck fast!  You begin to regret your decision to start this without some kind of prior stretching, but it's not like you had much of a choice in the matter in the first place.");

			outputText("\n\nNow panting with the effort of keeping up the furious pace you've been setting, you're struggling just to continue.  You rub as fast as you can, hoping that the pressure you can feel building within yourself will be enough to force the eggs out before you get too tired to continue, but to make matters worse you can feel yet more eggs descending within you. As the blockage slowly exacerbates, eggs pile up at the base of your cock; you can see the first one, the stuck one, slowly forced up your length by the pressure.");

			outputText("\n\nIt starts as a single bulge at the base of your cock, but it quickly begins to bloat further as all the pre, cum, and other eggs trapped inside you only add to the pileup.  This quickly makes the base of your cock look like the world's most perverted traffic jam.  You keep pulling, hoping that the pressure will continue to aid you, and you can feel an actual orgasm beginning to pile up on you as well, driving you to distraction and making your strokes more frantic and erratic.");

			outputText("\n\nAll these things seem to be ganging up on you, the building climax, the cum, the eggs, and the pre all stuck within your quickly bloating member.  Eventually it just all proves to be far too much,  and you cum, the pleasure driving you crazy.");

			outputText("\n\nThe base of your cock gets even worse for a moment, bloating out in a way that you're sure shouldn't be possible, and you can actually see multiple eggs stuck within your urethra, each one trying to barge past the others as the pressure quickly reaches the breaking point.");

			outputText("\n\nYou spasm, hard, and curl in on yourself as everything seems to come crashing down around you. Your cock flops over, leaning against your head, the heft of it far too much to keep aloft with the added weight of everything stuck within.  The pressure mounts until it's painful, and then suddenly it's released.");

			outputText("\n\nAn explosion of pleasure threatens to knock you out on the spot, as your body quickly pushes everything up and out of your sensitive slit with a force that you simply couldn't have managed on your own.  Eggs, cum, and honey all come spurting out of your length like bats out of hell, splattering and bumping across the ground.  You're thankful that insectile eggs seem to be rather pliant and resilient, as you're almost certain that any other kind might have broken with the force of your ejaculation.");

			outputText("\n\nYou lose count of how many eggs pass through your stretched and abused urethra, as well as how many times you cum from the amazing feeling of them leaving your body.  As the last few eggs slowly travel up your length, you pass out, your orgasmic contractions continuing long after they normally would have stopped.");

			outputText("\n\nA few minutes later you awaken, covered in cum, honey, and whatever might have been left of your pre, and feeling much lighter than you did before.  You look 'up' at the ground in front of you; a loose pile of bee eggs rests on the ground, covered in cum and even more honey.");

			outputText("\n\nYou smile a bit at your self-created children, and you can already hear a quiet buzzing starting from the eggs.  It seems you managed to fertilize them after all, and they must have attached within you somewhere so that they wouldn't come out until they'd completely gestated.");

			outputText("\n\nTurning over, you watch the little things hatch, and you don't have to wait long. The buzzing grows louder, and the first of the eggs burst open, revealing a very small, very wet, and very fuzzy, little bee.  You smile as your child takes its first tentative flight, and are ");
			if (player.cor < 50)
				outputText("amused");
			else outputText("somewhat annoyed");
			outputText(" as it manages to land directly on your nose.  When you helpfully pluck it off and place it on the ground, it looks up at you with a wave and a smile.");

			outputText("\n\nBy this time the others are beginning to hatch, and one by one they find their wings and take to the air, often waving or buzzing around you for a moment before they head off toward the forest to do bee things.");

			outputText("\n\nFeeling lighter and a bit happier than you have in a while, you pick yourself up and redress, quickly heading back to camp.\n");
			flags[kFLAGS.DICK_EGG_INCUBATION] = 0;
			masturGasm("Dick");
		}

		//I Regret Nothing/Exgartuan:
		//Don't know the formatting well, so going to make some mistakes I suppose.
		//Scene Requires Fuckable Nipples, I'm going to aim at breasts around HH Cup or higher, since Exgartuan will push you over that from the bare minimum breast size - I'm thinking that breast pregnancy chance without Exgartuan will be nil/low and with Exgartuan will be extant/reasonable
		private function layEggsInYerTits():void {
			clearOutput();
			if (SceneLib.exgartuan.boobsAwake()) {
				//Exgartuan; breasts should be HH or larger, fuckable nipples, only if Exgartuan is awake
				outputText("Smiling mischieviously to yourself, you look down to your possessed [chest] and tell Xenora that you have something you very much would like to do for her.");
				outputText("\n\n\"<i>Oi bitch, I know what you're on about.  You think you can just lay eggs inside me?  Well... I'm proud of you, that's the sort of attention these magnificent cans deserve.</i>\"");
				outputText("\n\nYour mischievous grin turns confused as you get the distinct impression that if Xenora had knuckles to crack and joints to pop, she would be.  Certainly, the uncanny jiggling of your [chest] implies some sort of activity.");
				outputText("\n\n\"<i>Alright.  You sure you want to do this?  Nah, I'm just fucking with you, you have to now.</i>\"");
				outputText("\n\nXenora's enthusiasm is boundless, and her arousal magnetic.  You find your hands groping your bosom without your control, and Xenora clearly revels in it.  In short order, Xenora's primed you enough that the ovipositor has exited its sheath, and now hangs beneath you.  Recognizing that the following procedure would be problematic at best, Xenora hurls her entire weight to the side, and you topple over instantly.  You begin to wonder how Xenora took control of your taking advantage of her, but suddenly find yourself in control of your arms.");
				outputText("\n\nYou know what to do, so you prop yourself up on an elbow without ceasing to caress and please your possessed knockers; teasing the [nipple] causes Xenora to tremble slightly.  Your other hand roams down between your [legs] as you snap your abdomen as close into you as you can.  You take hold of the ovipositor and begin to pull it up to meet your [chest][if (cocks > 0) , past your ][if (cocks > 2) forest of ][if (cocks > 0) cock][if (cocks > 1) s].");
				outputText("\n\nSuddenly, Xenora pipes up out of the [nipple] that isn't being squeezed, \"<i>Hold it champ, that one tube isn't going to be enough.</i>\"");
				outputText("\n\nYour hand draws your ovipositor between your [chest] unbidden. Xenora begins a weird chant that, while not actually audible, you can feel in your [chest], causing them to quake[if (isLactating = true)  and milk to spurt forth].  Then the pain starts.");
				outputText("\n\nYou next notice things when you feel your hands free again, and you pull the ovipositor out from its hiding place.  You mentally correct yourself, ovipositors.  Well, more precisely, near the base of your egg tube it's split into two columns from one trunk.  Xenora's purpose is made exceedingly clear, and you place one tip to each [nipple].");
				outputText("\n\n\"<i>Alright bitch, I've cleared out space for these bad boys, and now you're gonna make me a momma.  Treat me right, I may even let you keep the double tube one of these days.</i>\"");
				outputText("\n\nMight Xenora actually relish the idea of being pregnant?  You're not entirely sure how the demon works, beyond that she resides immovably in your [chest].  Xenora begins holding your... her - whatever - [nipples] open, and you plunge your ovipositor's tips in, pulling your knees up tight toward your chest to push your ovipositor into your [fullChest]... her.");
				outputText("\n\nNot only does it feel amazing to push your ovipositor into yourself for so many reasons, but Xenora is practically blissed out.  Quickly, on the heels of the lube[if (isLactating = true)  that is forcing milk out around the edges of your tubes], your eggs begin down your ovipositor.  Xenora's concentration snaps back, you guess, on the basis that your [chest] becomes slightly more pert and gravity-defying.");
				outputText("\n\nThe first egg goes down one tube, and the one that follows goes down the other.  You initially marvel at this, but then you realize Exgatuan is forcing this symmetry herself.  Later, you'll speculate to yourself that if Xenora put the sort of effort into other aspects of life that she's putting into this, both of you would be a lot further ahead than you are, but that time is not now.  Now is the moment when the first egg reaches your [nipple].");
				outputText("\n\nYou exert for a moment, and it begins to make headway into the [nipple], the feeling of the stretch causing you to moan in pleasure as your [chest] quakes in its own particular pleasure.  You delay its entry for a moment to match it with the egg that has begun pressing insistently into the other side of your [chest], before letting them both in simultaneously.");
				outputText("\n\nYou are rewarded with a keening, intense orgasm shared between yourself and Xenora, that falls off into waves as the eggs continue to inexorably push into your [chest].  You can see the shapes of the eggs begin to deform the pillowy expanse of your chest, and if it weren't that Xenora knows what's going on in your breasts better than you, you'd worry.");
				outputText("\n\nAs it is, Xenora is stifling all movement and protest you might be able to muster to be beholden to her moment.  You realize that you feel little to nothing outside of the euphoric release of depositing your eggs and the dual-persona'd orgasm going on in your [chest].");
				//[if (cocks > 1)
				if (player.cocks.length > 1)
					outputText("  Your cocks, while still erect, are doing little more than dribbling cum over your breasts and tubes, devoid of the force and power they usually have.");
				//[if (cocks = 1)]
				else if (player.cocks.length == 1)
					outputText("  Your [cock], while still erect, does little more than dribble cum over your breasts and tubes, devoid of the force and power that usually comes with orgasm.");
				//[if (hasVagina = true)]
				if (player.hasVagina()) outputText("  Your [vagina] lets sticky fluids out slowly around your thighs; you are only able to tell by the damp feel of your [legs].  It feels fantastic!");
				outputText("\n\nAll too soon, the eggs come to a stop, with your breasts feeling as if they've gained numerous cup sizes, at least in weight, from the orbs of your children.  You remove the ovipositors from your [nipples] with a gentle awe, both to the euphoria and to Xenora.");
				outputText("\n\nSeeming much more subdued, and slightly muffled, Xenora says \"<i>That was an interesting experience, even by my standards.  I'm not going to make the double ovipositor thing work for you whenever, so I'll just be taking that back.</i>\"");
				outputText("\n\nYour hands automatically pull your ovipositors between your mammaries, and the experience of it fusing back into itself is far less painful than the split.  You relax as your ovipositor withdraws back into your abdomen.");
				outputText("\n\n\"<i>You know, I think you and I could really get along, you keep treating me nice like this.</i>\" The thought crosses your mind that \"like this\" is essentially worshipful submission to her whim.  \"<i>Now go to sleep, I need some time to adjust.</i>\"");
				outputText("\n\nYou agree with that suggestion, too exhausted from the ordeal to do much else anyway. You pass out in a puddle of your own fluids, to wake up most of an hour later.");
				SceneLib.exgartuan.boobsSleep(48);
			}
			else {
                sceneHunter.print("Check failed: Xenora in boobs and awake.");
				outputText("Having decided to give in to your baser urges, you see no reason not to solve all your problems and lay the orbs that have been burdening you at the same time.  You look around a moment before beginning, [if (corruption < 50) concerned that you may be observed.][if (corruption > 50) hopeful for a target on which to unburden yourself instead.]");

				outputText("\n\nCertain that you will not be interrupted, you quickly remove your [armor] and lie on your side against a comfortable rock, having sorted out that being on your back will involve twisting your ovipositor uncomfortably and on all fours will risk your eggs.  Your [chest] squash softly down on the loam next to you, and you begin to tease and stretch your [nipples] in preparation for your insane plan.");

				outputText("\n\nWith mounting anticipation for the main event, your twisted body quickly reacts to your ministrations. [if (cocks > 1) Your cocks begin ][if (cocks = 1) Your cock begins ][if (cocks > 0) to harden and rise toward your [chest], a veritable promised land for male organs, but that is not your concern today.]");
				if (player.hasVagina()) {
					if (player.hasBalls())
						outputText("  Behind your [balls], y");
					else outputText("Y");
					outputText("our [vagina] begins to quietly drip and pull open slightly, and you wish for the flexibility to plant your eggs in it.");
				}
				outputText("\n\nFinally, your ovipositor begins to peek out from its hiding place, and you seize it with one hand, rapidly stroking it and encouraging it to elongate further, and then, tucking your abdomen tight against you, you pull it through your [legs] and up [if (cocks > 0) past your maleness] to your [chest].");

				outputText("\n\nWith your free hand, you pull your [nipple] open wide, painfully wide, and squeeze the tip of your ovipositor into it, simultaneously stretching your ovipositor to its maximum.  With a frustrated sigh, you attempt to coax more length out of it while doubling over, inadvertently pushing the ovipositor into your [nipple].  You spasm a moment, and [if (isLactating = true) a mixture of milk and ] ");
				if (player.canOvipositBee())
					outputText("honey ");
				else outputText("green fluid ");
				outputText("squirts out of you under the sudden pressure from your penetration.");

				outputText("\n\nOverwhelmed with a sexual glee, you begin to jackknife, driving your ovipositor from the tip to deep inside your breast.  Holding everything in place with one hand, your other begins to toy with a spare [nipple].  [if (cocks > 0)   [EachCock] hardens to the full extent, forcing you to take a moment to rearrange yourself, and leaving you jacking off [oneCock] with your spare hand instead.]");
				if (player.hasVagina()) {
					outputText("  Meanwhile, your [vagina] has fully parted and begun to drool ");
					if (player.wetness() >= 4) outputText("liberally ");
					outputText("onto your [legs] and abdomen.");
				}

				outputText("\n\nYour ovipositor has already begun its task.  You can see rounded distortions making their way up the tube.  As the leader of the pack begins nearing the end of its journey, you double over tightly, driving the ovipositor as deep into your chest as you can.  Your [nipple] aches delightfully as it is spread yet further open by the bulging intrusion, and just as the egg pops from the tip of the ovipositor, a low, gentle orgasm spreads through you, radiating out from your [chest].");

				//Stage 1 - low/no chance of pregnancy
				if (player.eggs() < 20) {
					outputText("\n\nWith a contented glow, you let your eggs go in, each time crashing into your consciousness like waves slowly eating away your mind, until you start to feel some discomfort in your breast. You let one more egg pass, and then you pull your ovipositor out, causing a small explosion of[if (isLactating = true)  milk and]");
					if (player.canOvipositBee())
						outputText("honey");
					else outputText("goo");
					outputText(".  Quickly, you thrust it into your other breast and let the egging continue.  Suddenly conscious of your situation, you hold your previous [nipple] closed.");
					if (player.hasCock()) outputText("  Your [chest] and ovipositor meanwhile are slowly being coated in white from your languid pleasure.");
					outputText("\n\nEventually, no more eggs come down the tube, and with a contented sigh, you release your ovipositor and, clutching your [chest] tightly to prevent the eggs' escape, pass out for the remainder of the hour.");
				}
				//Stage 2 no/moderate chance of pregnancy
				else if (player.eggs() < 40) {
					outputText("\n\nYour [chest] begins to tingle and your heart begins to race as the eggs continue to bring orgasmic waves with each transfer. Your breast rapidly begins to feel full, and your abdomen has only just begun to deflate. With a mixture of concern and desperation for every last egg, you hold the ovipositor until no more eggs could possibly fit. Your egg-laden tit has ballooned considerably in size, and you have to squeeze your [nipple] shut to keep the eggs in after you remove your ovipositor.[if (isLactating = true)   Under the sheer pressure, milk constantly streams out of your [nipple].]");
					outputText("\n\nDraping your arm tight over the newly egged tit, you use that hand to hold open your other [nipple] so that you can insert your egg tube.  You begin to giggle under the assault of the constant euphoria[if (cocks > 0) , and your tits and ovipositor have long since had their natural color obscured by your constant streams of cum, which has begun to pool underneath you].  Soon, even the second breast begins to feel uncomfortably full, and not for the first time you start to worry about the wisdom of this course of action.");
					outputText("\n\nAt long last, your egg sac has nothing more to feed into your [chest]. You pop out the shriveling organ and try to watch it shrivel back up, but your newly plumped [chest][if (cocks > 0)  and your diminishing erection][if (cocks > 1) s] make it impossible to see.  You spend several long moments caressing your swollen [chest], now dimpled slightly by the orbs inside them, and those long moments stretch into eternity as you pass out.");
				}
				//Stage Three no/high chance
				else {
					outputText("\n\nYour [chest] begins to tingle and your heart begins to race as the eggs continue to bring orgasmic waves with each transfer. Your breast rapidly begins to feel full, and your abdomen hasn't even begun to deflate.  With a mixture of concern and desperation for every last egg, you hold the ovipositor until no more eggs could possibly fit. Your egg-laden tit has ballooned considerably in size, and you have to squeeze your [nipple] shut to keep the eggs in after you remove your ovipositor.[if (isLactating = true)   Under the sheer pressure, milk constantly streams out of your [nipple].]");
					outputText("\n\nDraping your arm tight over the newly egged tit, you use that hand to hold open your other [nipple] so that you can insert your egg tube. You begin to giggle under the assault of the constant euphoria[if (cocks > 0) , and your tits and ovipositor have long since had their natural color obscured by your constant streams of cum, which has begun to pool underneath you]. Soon, even the second breast is absolutely egg-stuffed, and not for the first time you start to worry about the wisdom of this course of action.");
					//[if (breastRows > 1)
					if (player.bRows() > 1)
						outputText("\n\nQuickly you switch to another [nipple] and then another, until at long last, your egg sac has nothing more to feed into your [chest].  You pop out the shriveling organ and try to watch it shrivel back up, but your newly plumped [chest] make it impossible to see.  You spend several long moments caressing your swollen [chest], now dimpled slightly by the orbs inside them, and those long moments stretch into eternity as you pass out.");
					else outputText("\n\nYou realize that there is no way to finish laying your eggs, and release a moan that is half orgasm and half frustration. The glorious sensation of egg-laying is cut off as there's nowhere to lay your eggs.  Then you realize what you must do.");
					if (player.bRows() < 2) {
						outputText("\n\nHaving popped your ovipositor out, you spend a few moments contemplating the pulsating organ, which isn't even moving the eggs without the surety of a nice warm hole.  You feel stuck, trapped on the edge of orgasm with an egg half down the tube.  Finally, your arousal and desperation overcomes your better judgment again, and you open your mouth wide for your egg tube.  Immediately, you feel the until-then backed up lubricant of your ovipositor flowing down your gullet, and your mouth and throat begin to feel strange.");
						outputText("\n\nThe eggs quickly resume their advance, now aimed down your throat. All too soon, the egg reaches your teeth, and a new problem arises.  It's too big. Tears of frustration begin to sprout, and then suddenly you feel a massive convulsion in your ovipositor, and the egg is forced past your teeth with a horrible click of your jaw, which then proceeds to hang in its newly gaping state.  You then start to panic when you realize if the egg couldn't get into your jaw then there's no way to swallow it, when you feel it slip into your throat all the same, and realize that the entire structure has been numbed and widened to accomodate your needs.");
						outputText("\n\nEven your stomach is beginning to feel uncomfortably full when the final egg enters the ovipositor to begin its journey.  Once it pops into your gullet, you feel a great sense of relief wash over you accompanied by the last orgasm.  You pass out cradling your swollen stomach and [chest].");
					}
				}
			}
			if (!player.hasStatusEffect(StatusEffects.Eggchest))
				player.createStatusEffect(StatusEffects.Eggchest, 3 + rand(10), 1 + rand(4), 0, 0);
			masturGasm("Vaginal");
			dynStats("sen", 1);
			player.dumpEggs();
			endEncounter();
		}

		private function tentacleSelfFuck2():void {
			clearOutput();
			doStripCheck();
			outputText("You attempt to reach for your sex using your hand when suddenly a crazy idea fills your mind. You don't actually need your hand to fuck yourself you got way better than that...actually eight time better!\n\n");
			outputText("Positioning yourself so your " + vaginaDescript(0) + " point toward the sky you start to move your tentacles one by one toward your love hole.");
			outputText(" Once comfortable you start by inserting one tentacle into your snatch pushing it as deep as you can. Since there's enough space in there for more you add a second one then a third. Before long six of your tentacle are inside of your " + vaginaDescript(0) + " filling you perfectly.");
			outputText(" You proceed to grope your " + breastDescript(0) + " with the two remaining tentacle squeezing them until thin squirts of milk spray from each nipple, spattering milk around. Now this is nice but this needs movement.");
			outputText(" You start by squirting a little ink so to lube your limbs nicely then proceed to slowly fuck yourself squirming your tentacle inside your love canal in order to stimulate your clit and drive yourself completely nuts.");
			outputText(" Wow this is better than what any of those tentacle beast out there can do heck you know where to wriggle those tentacle just so to drive you to the edge ramming your clitty with perfect precision!");
			outputText(" Fucking yourself with abandon your black girlcum starts to rain on the ground until everywhere around you is entirely soaked but you don't care this feels way too good to stop.");
			outputText(" For hour your lock yourself in constant bliss until after a number of incalculable consecutive orgasm you collapse to the ground exhausted and entirely drenched in black ink.\n\n");
			outputText("You proceed to clean yourself up in the nearby stream then go lay down on the grass to dry drifting off into a quick nap.");
			masturGasm("Vaginal");
			endEncounter();
		}

		//Tentacle In Gina Faps.
		//Normal intro.
		//Segue into tentacle-faps.
		//Pick biggest tentacle that can possible fit into 'gina
		private function tentacleSelfFuck():void {
			var x:int = player.findCockWithType(CockTypesEnum.TENTACLE, 1);
			var y:int = player.findCockWithType(CockTypesEnum.TENTACLE, 2);
			clearOutput();
			doStripCheck();
			outputText("Almost immediately, your " + cockDescript(x) + " perks up like a pet expecting to be fed, and you have to admit that you plan to give that squirming tentacle exactly what it desires - a hot, slippery slit to nestle inside of.  Already, your [vagina] has grown ");
			if (player.wetness() <= 2)
				outputText("moist");
			else if (player.wetness() <= 3)
				outputText("wet");
			else if (player.wetness() <= 4)
				outputText("sloppy and wet");
			else outputText("beyond soaked");
			outputText(".  The slick slit is slowly parting as you reach to wrangle the wiggly cock");
			if (player.cocks.length > 1) {
				outputText(", brushing your hand against your other ");
				if (player.lust <= 70)
					outputText("half-hard");
				else outputText("erect");
				outputText(" penis");
				if (player.cocks.length > 2) outputText("es");
				outputText(" on the way");
			}
			outputText(".  Moaning out loud, you try your best to handle the flood of alien sensations, but the pleasure-sparking tendril in your grip feels so different from a human penis.  It's almost like you're compelled to thrust it inside of some orifice, any orifice, so long as it's somewhere warm and tight.");
			if (y >= 0) outputText("  It loops around your " + cockDescript(y) + " while you fight with it, strangling the other phallus in tight coils of squeezing, floral friction.");

			outputText("\n\nYou arch your back as you try to contain the unexpected waves of desire that flood your groin, but it's no use.  In the span of a few seconds, you decide to accept that you need to fuck something now.  Foreplay is no longer an option.");
			if (player.hasBalls())
				outputText("  You lift you [balls] out of the way and");
			else outputText("  You");
			outputText(" twist your wrist down.  That change in direction comes far easier than trying to stroke it.  Releasing sets of alien muscles that you had held instinctively, you let your " + cockDescript(x) + " do what it was made to do.  It slithers down sinuously, the purplish head pressing heavy and hot against your juicy mound just hard enough to encourage you to press back against it.  It slowly spreads your clinging tunnel around its obscene girth one fold at a time.");
			//Cunt change!
			player.cuntChange(player.cockArea(x), true, true, false);

			outputText("\n\nRipples of delight radiate along your " + cockDescript(x) + " as it buries itself as deeply into your velvet tunnel as possible.  The fat, purplish head stretches you out as it goes, just enough that the trailing stalk is comfortably ensconced in twat.  Tugging on the exposed portion, you find yourself pumping wildly on your length, squeezing it while paroxysms of ecstasy render your fine muscle control useless.  The dual sensations of being fucked and dishing out a hot dicking have overlapped into a tangled-up knot inside you.");
			if (y >= 0) {
				outputText("  Your " + cockDescript(y) + " is getting jacked off by the engorged cock-coil's motions and slowly leaks creamy pre over the jerking length.");
				if (player.cocks[y].cockType == CockTypesEnum.TENTACLE) {
					outputText("  In no time flat the second tendril has gotten the idea, and it elongates to reach for your unoccupied asshole.  There's a moment of token resistance before it violates your [asshole], but then, there's only the warm heat of a torrid butt-fuck.");
					//BUTTCHANGE IF APPROPRIATE
					player.buttChange(player.cockArea(y), true, true, false);
				}
			}
			outputText("\n\nDelirious with excitement, you grab hold of your [chest]");
			if (player.biggestTitSize() >= 1) outputText(", kneading the soft mammary");
			outputText(" and twisting your [nipple] as your body goes white-hot with pleasure");
			if (player.hasFuckableNipples()) outputText(", even stuffing a finger inside a sloppy, dripping nipplecunt");
			outputText(".");
			if (player.lactationQ() >= 250) outputText("  Milk squirts from your engorged teat almost immediately to fall in a moist, creamy rain across your writhing form.");
			//{no new PG}  Three + Tentalce fork - one in mouth
			if (player.tentacleCocks() >= 3 || player.stamenCocks() > 2) {
				outputText("  The pleasured noises that have been issuing forth from your 'O'-gaped lips are cut off by a sudden intrusion from another of your arboreal phalluses.   This one punches straight into your throat without pause, sliding so smoothly across your tongue that you barely care about gagging when it feels so good.  Trickles of your sweet pre-cum are dribbling out from [eachCock] into your holes");
				if ((player.tentacleCocks() || player.stamenCocks()) < player.cocks.length) outputText(" and the open air");
				outputText(".");
				if (player.biggestTitSize() >= 4) outputText("  Laying right between your boobs, it doesn't take long for the shaft to extend far enough to loop around each tit, sliding slowly encircling each curvy mound as it presses them together around itself, getting a titfuck while it plows your unresisting mouth.");
			}
			//No bonus cawks!
			else {
				outputText("  The pleasured noises issuing forth from your 'O'-gaped lips get higher and higher pitched with each passing second, and for a split second, you find yourself wishing you had a third tentacle so you could suck it while you fuck yourself.");
				if (y >= 0 && player.cocks[y].cockType == CockTypesEnum.TENTACLE && player.cocks[y].cockLength >= 20) {
					outputText("  Luckily, you're so big down there that a juicy cock-head is right there within reach, and you bend to slurp it up without thought, busily self-sucking with reckless abandon.");
				}
			}
			//MORE
			if (player.tentacleCocks() >= 6 || player.stamenCocks() > 5) {
				outputText("\n\nThe excess green tools rise up above you.  They survey the view before them in a crude approximation of a sentient surveyor, seeming to take in the shifting, squiggling view of your ardent masturbation.  In truth, you're just trying to think of where to stick them.  A few droplets of liquid lust leak from their tips in sympathetic pleasure, and it gives you an idea for just what to do with them.  They stretch out towards your torso, veering to the sides at the last second.  Dripping onto your shoulders, the pulsating plant-pricks slowly push into your armpit, lubricating your " + player.skinFurScales() + " with their amorous liquid.");
				if (player.tentacleCocks() >= 7 || player.stamenCocks() > 6) outputText("  They pile in there, really squirming against each other as much as you, frotting against your sweat-slick flesh.  ");
				outputText("  You're fucking your armpits, and it feels divine, so good that your pits are swampy pits of sex within moments.");
			}
			//One more:
			else if (player.tentacleCocks() >= 4 || player.stamenCocks() > 3) {
				outputText("\n\nThe last green tool rises up above you.  It surveys the view before it in a crude approximation of a sentient surveyor, seeming to take in the shifting, squiggling view of your ardent masturbation.  In truth, you're just trying to think of where to stick it.  A droplet of liquid lust leaks from the tip in sympathetic pleasure, and it gives you an idea for just what to do with it.  It stretches out towards your torso but veers left at the last second.  Dripping onto your shoulder, the pulsating plant-prick slowly pushes into your armpit, lubricating your " + player.skinFurScales() + " with its amorous liquid.  You're fucking your armpit and it feels divine, so good that you quickly slick your pit and twist the spare cock around yourself so that it can double-fuck both sides.");
			}

			//JIZZBOMB
			outputText("\n\nFamiliar twinges start down in your ");
			if (player.hasBalls())
				outputText("balls");
			else outputText("groin");
			outputText(".  Orgasm is rapidly closing in, and there's no slowing your frenzied flora at this point.  You ");
			if (player.tentacleCocks() >= 3 || player.stamenCocks() > 2)
				outputText("gurgle");
			else outputText("moan");
			outputText(" as your inner muscles begin to contract into tight knots, the pressure building to a turgid, throbbing peak.  Then, as you");
			if (player.tentacleCocks() >= 3 || player.stamenCocks() > 2)
				outputText("r multitude of penises");
			outputText(" thrust deep inside yourself, a volcano of pleasure erupts, pumping thick flows of white goo straight into your snatch");
			if (player.tentacleCocks() == 2 || player.stamenCocks() == 2)
				outputText(" and ass");
			else if (player.tentacleCocks() > 2 || player.stamenCocks() > 2)
				outputText(", ass, and mouth");
			outputText(".");
			if (player.tentacleCocks() >= 3 || player.stamenCocks() > 2) {
				outputText("  You gulp the salty flow down as best you are able");
				if (player.cumQ() >= 500) {
					outputText(".  That doesn't really count for much with how heavy your load is, ");
					if (player.cumQ() < 1000)
						outputText("and your cheeks bulge with the size of each squirt");
					else outputText("and the cum is soon squirting out the corners of your mouth while your cheeks bulge cartoonishly");
				}
				outputText(".");
			}
			outputText("  Your birth canal is quickly flooded with white spooge");
			if (player.tentacleCocks() >= 2 || player.stamenCocks() > 1) outputText(", while your [ass]'s interior is painted bright white");
			outputText(".");
			if (player.tentacleCocks() == 2 || player.stamenCocks() == 2) {
				outputText("  Your untended " + cockDescript(y) + " blows spunk over you ");
				if (player.cumQ() < 50)
					outputText("in small spurts");
				else if (player.cumQ() < 200)
					outputText("in thick ropes");
				else if (player.cumQ() < 500)
					outputText("in huge blobs");
				else outputText("like a virile sprinkler");
				outputText(".");
				if (player.cocks.length > 2) {
					outputText("  The other one");
					if (player.cocks.length > 3)
						outputText("s match");
					else outputText(" matches");
					outputText(" it in output, even though you haven't done anything to stimulate ");
					if (player.cocks.length == 3)
						outputText("it");
					else outputText("them");
					outputText(".  The sensations coming from your prehensile penises are just so overwhelming that it's like a whole-body-gasm.");
				}
			}
			else if (player.tentacleCocks() >= 4 || player.stamenCocks() > 3) {
				outputText("  Meanwhile, the purple tip");
				if (player.tentacleCocks() == 4 || player.stamenCocks() == 4)
					outputText("s swell");
				else outputText(" swells");
				outputText(" in your armpit");
				if (player.tentacleCocks() >= 5 || player.stamenCocks() > 4) outputText("s");
				outputText(", engorging immensely as they press right into the soft, concave flesh within, the semen squirting out in pressured, arm-soaking jets.");
			}

			outputText("\n\nAt once, your whole body sags back, limp and drained.  The elongated tentacle");
			if (player.tentacleCocks() > 1 || player.stamenCocks() > 1)
				outputText("s retract");
			else outputText(" retracts");
			outputText(" back to ");
			if (player.tentacleCocks() == 1 || player.stamenCocks() == 1)
				outputText("its");
			else outputText("their");
			outputText(" normal length, popping out of your vagina");
			if (player.tentacleCocks() == 2 || player.stamenCocks() == 2)
				outputText(" and ass");
			else if (player.tentacleCocks() > 2 || player.stamenCocks() > 2) outputText(", ass, and mouth");
			outputText(", leaving your orifice");
			if (player.tentacleCocks() > 1 || player.stamenCocks() > 1) outputText("s");
			outputText(" to dribble the spent passion on the ground.  Damn, that was satisfying.");
			//(-2 sens + 1 per tentacle dick, -100 lust)
			masturGasm("Dick", "Vaginal");
			endEncounter();
		}

		private function stamenSelfFuck():void {
			var x:int = player.findCockWithType(CockTypesEnum.STAMEN, 1);
			var y:int = player.findCockWithType(CockTypesEnum.STAMEN, 2);
			clearOutput();
			doStripCheck();

			if(player.isLiliraune())
			{
				outputText("\n\n\"<i>Hey sis feel in the mood for a ride?</i>\"\n\n");
				outputText("\"<i>I was about to suggest that very thing.</i>\"\n\n");
			}
			outputText("Aroused your twisting vine stamen perks up like a pet expecting to be fed, and you have to admit that you plan to give your vine exactly what it needs - a hot, slippery slit to nestle inside of. Already, your [vagina] has grown ");
			if (player.wetness() <= 2)
				outputText("moist");
			else if (player.wetness() <= 3)
				outputText("wet");
			else if (player.wetness() <= 4)
				outputText("sloppy and wet");
			else outputText("beyond soaked");
			outputText(" with your nectar.  The slick slit is slowly parting as you reach to wrangle the wiggly vine");
			if (player.cocks.length > 1) {
				outputText(", brushing your hand against your other ");
				if (player.lust <= 70)
					outputText("half-hard");
				else outputText("erect");
				outputText(" stamen");
				if (player.cocks.length > 2) outputText("es");
				outputText(" on the way");
			}
			outputText(".  Moaning out loud, you try your best to handle the flood of alien sensations, but the pleasure-sparking tendril in your grip feels so different from a human penis.  It’s almost like you’re compelled to thrust it inside of some orifice, any orifice, so long as it’s somewhere warm and tight.");
			if (y >= 0) outputText("  It loops around your distended, wriggling plant-shaft while you fight with it, strangling the other stamens in tight coils of squeezing, floral friction.");
			outputText("\n\nYou arch your back as you try to contain the unexpected waves of desire that flood your groin, but it’s no use. In the span of a few seconds, you decide to accept that you need to fuck something now. Foreplay is no longer an option.");
			outputText("  You twist your wrist down.  That change in direction comes far easier than trying to stroke it. Releasing sets of alien muscles that you had held instinctively, you let your sinuous stamen mounted vine do what it was made to do. You slither it down sinuously, the head pressing heavy and hot against your juicy mound as you press back against it. It slowly spreads your clinging tunnel around its delicious girth one fold at a time.");
			//Cunt change!
			player.cuntChange(player.cockArea(x), true, true, false);
			outputText("\n\nRipples of delight radiate along your " + cockDescript(x) + " as it buries itself as deeply into your velvet tunnel as possible. The stamen stretches you out as it goes, just enough that the trailing stalk is comfortably ensconced in twat. Tugging on the exposed portion, you find yourself pumping wildly on your vine, squeezing it while paroxysms of ecstasy render your fine muscle control useless. The dual sensations of being fucked and dishing out a hot dicking have overlapped into a tangled-up knot inside you. Your wide, squirming stamen mounted vine is getting jacked off by the engorged vine-coil’s motions and slowly leaks liquid pollen over the jerking length.");
			if (y >= 0) {
				outputText("  Still aroused, In no time flat you move your second tendril to reach for your unoccupied asshole. There’s a moment of token resistance before you violates your [asshole], but then, there’s only the warm heat of a torrid butt-fuck.");
				player.buttChange(player.cockArea(y), true, true, false);
			}
			outputText("\n\nDelirious with excitement, you grab hold of your [chest]");
			if (player.biggestTitSize() >= 1) outputText(", kneading the soft mammary");
			outputText(" and twisting your [nipple] as your body goes white-hot with pleasure");
			if (player.hasFuckableNipples()) outputText(", even stuffing a finger inside a sloppy, dripping nipplecunt");
			outputText(".");
			if (player.lactationQ() >= 250) outputText("  Milk squirts from your engorged teat almost immediately to fall in a moist, creamy rain across your writhing form.");
			outputText("  The pleasured noises that have been issuing forth from your 'O'-gaped lips are cut off by the sudden from another of your vine stamen. This one punches straight into your throat without pause, sliding so smoothly across your tongue that you barely care about gagging when it feels so good.  Trickles of your sweet pollen are dribbling out from one of your writhing stamen into your holes");
			if (player.stamenCocks() < player.cocks.length) outputText(" and the open air");
			outputText(".");
			if (player.biggestTitSize() >= 4) outputText("  Laying right between your boobs, it doesn't take long for the shaft to extend far enough to loop around each tit, sliding slowly encircling each curvy mound as it presses them together around itself, getting a titfuck while it plows your unresisting mouth.");
			outputText("\n\nFamiliar twinges start down in your pitcher. Orgasm is rapidly closing in, and there’s no slowing your frenzied vines at this point.  You gurgle as your inner muscles begin to contract into tight knots, the pressure building to a turgid, throbbing peak. Then, as your multitude of stamens thrust deep inside yourself, a volcano of pleasure erupts, pumping thick flows of liquid pollen straight into your snatch, ass, and mouth.  You gulp the flow down as best you are able. Your birth canal is quickly flooded with pollen, while your squeezable ass’s interior is painted with more plant juice.");
			outputText("\n\nAt once, your whole body sags back, limp and drained. You move your vines move back to their normal position, popping out of your vagina, ass, and mouth, leaving your orifices to dribble the spent passion. Damn, that was satisfying.");
			masturGasm("Dick", "Vaginal");
			player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
			endEncounter();
		}

	private function twinYuri():void {
		clearOutput();
		outputText("You realize how horny you are, your twin sister giving a silent nod.\n\n" +
				"\"<i>Hey sis feel in the mood for a ride?</i>\"\n\n" +
				"\"<i>Yeah, we can’t fight properly while aroused like this, close the curtain.</i>\"\n\n" +
				"She doesn’t need to say another word as you close your petals in order to give yourself some well-needed privacy. " +
				"You gently insert your finger in her nectar drenched [pussy] as your twin plays with your nectar-laden breast, suckling on your nipples. " +
				"The two of you moan in delight. Feeling both your [chest] and her [pussy], you can’t help but slip your finger deeper, " +
				"seeking more pleasure as she mashes and squeezes both of your tits together trying to make you leak that excess nectar out. " +
				"The connection between your senses is so perfect, it feels like having four sets of hands massaging your cunt and milking your tits at the same time, " +
				"and the best about it is you can pinpoint your own G spots! You scream together in perfect sync.\n\n" +
				"\"<i>I’m cummmmmming!!!!</i>\"\n\n" +
				"Both of you orgasm at the same time, your four breasts and two cunts gushing and filling the pitcher with pints of extra nectar. " +
				"You reopen your petals and the two of you chuckle.\n\n" +
				"\"<i>Who needs anyone else when we can just fuck ourselves?</i>\"\n\n" +
				"\"<i>I think we only do it for variety. Truthfully, I would get bored if it was just us two all the time… Plus, who says no to a threesome?</i>\"\n\n" +
				"The two of you giggle at this idea as you resume your journey, highly satisfied.");
		masturGasm("Dick", "Vaginal");
		endEncounter();
	}

		//Upon selecting the option to masturbate you should have the option to fuck your own ass if you have a tentacle dick
		//Replace n with the tentacle cock number
		private function tentacleGoesUpYerPooperNewsAtEleven():void {
			var tentacle:int = player.findCockWithType(CockTypesEnum.TENTACLE, 1);
			clearOutput();
			//[Standard text for stripping off goes here]
			doStripCheck();
			outputText("You eagerly reveal your flora pecker as it squirms and wriggles on its own, gently caressing the green surface here and there, its coloration changing as you tease yourself.  After toying with your tentacle dick for a while, you decide to get down to business; using your newly acquired shaft muscles, you expertly guide your ever-writhing " + player.cockDescript(tentacle) + " to your back, pointing it toward your buttocks.  You grind the tip against your [butt], making pre-cum flow from your mushroom-like head and smearing it against your " + player.skinFurScales() + ".  Using your own seminal fluid as a natural lube, you press the tip of your " + player.cockDescript(tentacle) + " in front of your own backdoor, stretching your anal opening little by little, careful not to tear your own insides.  This goes on for a while, until you suddenly lose all patience and roughly stuff your own " + player.cockDescript(tentacle) + " at full force inside your colon.");

			//[anal tightness check]
			player.buttChange(player.cockArea(tentacle), true, true, false);

			outputText("\n\nThe impetuousness of the act makes you cry in a mixture of pleasure and pain, your [asshole] being overloaded with intense sensations.  Fortunately the tender and rubbery texture of your " + player.cockDescript(tentacle) + " allows for more sensitivity, the subtle friction sending tingles from your crotch all the way up your spine.  You shiver from the sheer cocktail of raw pleasure you're inflicting on your own body.  Your " + player.cockDescript(tentacle) + " keeps squirming against your insides, making you quiver and giggle like a whore, until it lodges all the way inside your colon, adopting a more comfortable position.  You then proceed to ferociously fuck your own [asshole], stretching it a bit more at every thrust.");

			//[Standard text for stroking other cocks/vagina goes here; text between ()s should be removed if the PC doesn't have multicocks]

			outputText("\n\nThe conjugated friction of your " + player.cockDescript(tentacle) + " writhing inside your devastated interior (as well as the rough hanjdob you're giving yourself) eventually proves too much for your horny body, and [eachCock] releases a massive load, squirting sexual juices everywhere inside (and outside) your body.  Pressure builds in your ass (and your hands) as cum flows out of you");
			//[if cum production is massive]
			if (player.cumQ() >= 1000) outputText(", making [eachCock] bulge.  The extra feeling sends you over the edge and you quickly reach your climax as you cum and cum");
			outputText(".");
			//[if cum production is moderate]
			if (player.cumQ() >= 500) outputText("  Your belly swells a bit from all the semen being packed inside you.");
			//[if cum production is massive]
			if (player.cumQ() >= 1500) outputText("  Your poor insides cannot handle the enormous cumshot being unloaded in your [asshole] and a significant volume of spunk dribbles outside, carelessly polluting the floor.");
			//[Standard text for other cocks cumming goes here.]
			outputText("  You groan and lazily remove your " + player.cockDescript(tentacle) + " from your anus as you give in to your pleasure-induced drowsiness.");
			if (player.cocks.length > 0) {
				//Single Cock
				if (player.cocks.length == 1) {
					if (player.lib < 30)
						outputText("  You quickly fall asleep, spent. ");
					else if (player.lib < 55)
						outputText("  You roll and begin to doze, your semi-erect [cock] flopping against you. ");
					else if (player.lib <= 80) {
						outputText("  As you close your eyes and relax, your [cock] surges back to erectness, ensuring ");
						if (player.cor < 50)
							outputText("your dreams will be filled with sex.");
						else outputText("you dream in a depraved kinky fantasia.");
					}
					else outputText("  You groan and drift to sleep, your rigid [cock] pulsing and throbbing with continual lust.");
				}
				//Multi Cock
				if (player.cocks.length > 1) {
					if (player.lib < 30)
						outputText("  You quickly fall asleep, spent. ");
					else if (player.lib < 55)
						outputText("  You roll and begin to doze for an hour, your semi-erect cocks flopping against you. ");
					else if (player.lib <= 80) {
						outputText("  As you close your eyes and relax, your dicks surge back to erectness, ensuring ");
						if (player.cor < 50)
							outputText("your dreams will be filled with sex.");
						else outputText("you dream in a depraved kinky fantasia.");
					}
					else outputText("  You groan and drift into a brief catnap, your rigid erections pulsing and throbbing with continual lust.");
				}
				if (player.perkv1(IMutationsLib.NukiNutsIM) >= 2){
					var cumAmmount:Number = player.cumQ();
					var payout:Number = 1;
					//Get rid of extra digits
					//cumAmmount = int(cumAmmount);
					//Calculate payout
					if(cumAmmount > 10) {
						payout += 2 + int(cumAmmount/100)*2;
					}
					//Reduce payout if it would push past
					if (player.perkv1(IMutationsLib.NukiNutsIM) >= 3){
						payout *= 2;
					}
					if(payout > 0) {
						player.gems += payout;
						outputText("\n\nWhen you wake up you find " + payout + " gems in the puddle of spunge your " + cockDescript(0) + " created.</b>\n\n");
					}
				}
			}
			masturGasm("Dick", "Ass");
			if (player.perkv1(IMutationsLib.NukiNutsIM) >= 2){
				var cumAmmount1:Number = player.cumQ();
				var payout1:Number = 1;
				//Get rid of extra digits
				//cumAmmount = int(cumAmmount);
				//Calculate payout
				if(cumAmmount1 > 10) {
					payout1 += 2 + int(cumAmmount1/100)*2;
				}
				//Reduce payout if it would push past
				if (player.perkv1(IMutationsLib.NukiNutsIM) >= 3){
					payout1 *= 2;
				}
				if(payout1 > 0) {
					player.gems += payout1;
					outputText("\n\nWhen you wake up you find " + payout1 + " gems in the puddle of spunge your " + cockDescript(0) + " created.</b>\n\n");
				}
			}
			endEncounter();
		}

		private function stamenGoesUpYerPooperNewsAtEleven():void {
			var tentacle:int = player.findCockWithType(CockTypesEnum.STAMEN, 1);
			clearOutput();
			//[Standard text for stripping off goes here]
			doStripCheck();
			if(player.isLiliraune())
			{
				outputText("\"<i>Hey sis I’m in the mood for anal today what about you?</i>\"\n\n");
				outputText("\"<i>That works but don’t you go and pick the largest one for yourself.</i>\"\n\n");
			}
			outputText("You ");
			if(player.isLiliraune()) outputText("both ");
			outputText("grab one of your stamen mounted vine, gently caressing the green surface here and there, its coloration changing as you tease yourself. After toying with your vine for a while, you decide to get down to business; using your newly acquired shaft muscles, you expertly guide your stamen to your back, pointing it toward your buttocks. You grind the tip against your [butt], making liquid pollen flow from your stamen head and smearing it against your [skin]. Using your own seminal fluid as a natural lube, you");
			if(player.isLiliraune()) outputText(" and your sister both");
			outputText(" press the tip of your stamen in front of your backdoor, stretching your anal opening little by little, careful not to tear your own insides. This goes on for a while, until you suddenly lose all patience and roughly stuff your own stamen at full force inside your colon.");
			if(player.isLiliraune())
			{
				outputText("\n\n\"<i>EEEEep! Not so rough sister! you're going to break us apart!</i>\"\n\n");
				outputText("\"<i>Shut up! You have the stamen up to your bowel!</i>\"\n\n");
			}
			//[anal tightness check]
			player.buttChange(player.cockArea(tentacle), true, true, false);
			outputText("\n\nThe impetuousness of the act makes you ");
			if(player.isLiliraune()) outputText("both ");
			outputText("cry in a mixture of pleasure and pain, your moist tight butthole being overloaded with intense sensations. Fortunately the tender and rubbery texture of your vines allows them for more sensitivity, the subtle friction sending tingles from your pitcher all the way up your spine. You shiver from the sheer cocktail of raw pleasure you’re inflicting on your own body. Your vine keeps squirming against your insides, making you quiver and giggle like a whore, until it lodges all the way inside your colon, adopting a more comfortable position. You then proceed to ferociously fuck your own [asshole], stretching it a bit more at every thrust.");
			outputText("\n\nThe conjugated friction of your vine writhing inside your devastated interior (as well as the rough hanjdob you’re giving yourself) eventually proves too much for your horny body, and all of your stamens releases a massive load, squirting flower juices everywhere inside (and outside) your body. Pressure builds in your ass (and your hands) as pollen flows out of you. You groan and lazily remove your stamen from your anus as you give in to your pleasure-induced drowsiness. You drift into a brief catnap, your stamens mounted vines pulsing and throbbing with continual lust.");
			masturGasm("Dick", "Ass");
			endEncounter();
		}

		//Unique Masturbation Scene (by Frogapus)
		//Select [Gilded Sock] from Masturbation menu
		private function gildedCockTurbate():void {
			clearOutput();
			var gildedCock:int;
			for (gildedCock = 0; gildedCock < player.cocks.length; gildedCock++) {
				if (player.cocks[gildedCock].sock == "gilded") break;
			}
			for (var x:int = gildedCock + 1; x < player.cocks.length; x++) { //Find the biggest gilded cock you've got
				if (player.cocks[x].sock == "gilded" && player.cocks[x].cArea() > player.cocks[gildedCock].cArea()) gildedCock = x;
			}
			outputText("You disrobe, shivering softly.  Biting your lip, you look down, realizing that though the day is warm the gleaming metallic sleeve on your cock is cool, almost chill.");
			outputText("\n\nThe light catches the golden cock-sock, scattering light through the area.  You grin as you grasp it, rubbing your thumb against the smooth top of the sheath, with your fingers rubbing against the tight leather cords beneath.  Your cock swells against the metallic walls of the cocksock, and though you're clearly growing warmer, the gleaming sheath stays cool to the touch.");

			outputText("\n\nYour fingers slide easily over the smooth metallic fabric and you begin masturbating.  The gold sheath shifts up and down against your shaft as you stroke faster and faster.  The gold casing blocks the familiar feel of your hand, instead feeling like the hand of some eager stranger on your dick.");
			if (player.cocks[gildedCock].cArea() < 6)
				outputText("  Enveloped in the cocksock, you can barely see the tip of your tiny dick as your head peeks out on every downstroke.  The rounded edge of the metallic sleeve rubs maddeningly against the head of your cock, cool and smooth.");
			//[medium dicks]
			else if (player.cocks[gildedCock].cArea() < 20)
				outputText("  The head of your cock abuts against the edge of the cocksock, bumping against it with every stroke.  With your thickness, the cocksock is a perfect fit, tugging on your cock with every upstroke, stretching your dick lightly as you jack yourself.");
			//[large dicks]
			else outputText("  Clamped around your dick, the metal casing looks more like a gigantic cock ring. The golden sheath actually allows you a better grip on your massive member, a ring of coolness around your hot meat.");

			outputText("\n\nPressure builds, and tremors of pleasure run through your body as you stroke faster and faster.  You let out a small moan, as you pump the cocksleeve up and down your " + player.cockDescript(gildedCock) + ".  Your cock swells within the confines of the sleeve, throbbing against the metallic confines of the sheath.  You shudder, arching your back, as you climax, your " + Math.round(player.cumQ()) + "mLs of cum arcing up high into the air overhead.");

			outputText("\n\nPanting, you watch the jet of cum glittering in the air, caught in the light of the golden cocksock.  It beads and twists in the light, crystallizing.  In a glittering shower, ");
			if (player.cumQ() < 25)
				outputText("a sprinkle of");
			else if (player.cumQ() < 250)
				outputText("a rain of");
			else outputText("a torrent of");
			outputText(" gems falls down upon your body instead of cum, bouncing off your " + player.skinFurScales() + ".");

			var gems:int = midasCockJackingGemsRoll();

			outputText("\n\n<b>You have just enough wherewithal to gather up the spent " + num2Text(gems) + " gems before falling asleep for a quick nap.</b>");
			masturGasm("Dick");
			player.gems += gems;
			flags[kFLAGS.GILDED_JERKED]++;
			statScreenRefresh();
			endEncounter();
		}

		private function stickADildoInYourVagooSlut():void {
			clearOutput();
			if (player.hasVirginVagina()) { //LOW CORRUPTION DEFLOWER
				sceneHunter.print("Corruption fork.");
				if (player.cor <= 50) {
					outputText("You blush nervously as you grasp your phallic toy. The firm dildo bends slightly as you hold it in your hand. You feel perverse to consider doing this, and shakingly undo the bottom of your [armor].");
					outputText("\n\nSitting on your [butt], you begin to rub the length of the slender tube against your [vagina], the gentle stimulation calming your nerves and helping to relax the tension.  As you pick up the pace, moans begin to escape your lips.  Your [clit] fills with blood and twitches as the faux cock slides against it.  You tenderly caress your [chest] with your other hand, becoming more breathy as you do so. ");
					if (player.wetness() <= 2)
						outputText("The toy slides easier as your juices cover it.");
					else outputText("The toy slides effortlessly thanks to your copious, almost inhuman lubrication.");

					outputText("\n\nSwallowing, you lean back and position the dildo toward your [vagina], the entrance twitching as it yearns for penetration. With an experimental push, you prod at the hole, jumping at the realization of how large the object really is. It's not nearly as thin, short, and bendable as a finger. You think about why you'd do such a thing. Your virginity too precious to risk a demon stealing away, or perhaps you're simply grown more perverted in this corrupt world. Whatever the case, you bite your lip and press the toy into you. Your decision made, the pain of your splitting hymen shoots through you. You gasp, easing the pressure on the toy, letting it sink one more inch before letting go altogether.");
					player.cuntChange(8, true, true, false);
					//Cunt change text go here!
					outputText("\n\nBreathing heavily, you slowly pull the invasive, fake phallus from your stinging vagina. A light stain of blood now coats the first several inches of the dildo. Taking a deep breath, you push the toy back in, this time feeling less pain. The worst of the experience behind you, you gently pump in and out. Your once pure pussy is now accepting the intruder deeply. Your speed increases as you get used to it. Breathing heavier in between moans, you thrust your cherry-picker in towards unforeseen ecstasy. The tears in your eyes, accumulated from pain, well up even larger in pleasure. Using one hand to piston the imitation cock in your [vagina] and the other to massage around your [clit], the stimulation becomes almost unbearable. Even with the remnants of pain from your recent deflowering, you can't help but grind your [hips] and slide slowly onto your back in preparation for your first penetrative orgasm. Your moans becoming louder and more intense while vaginal juices drip down your buttcheeks. In one last screaming moan, your thighs lift, and you thrust the dildo as deeply into you as it will go, pushing you over the edge into orgasm.");
					outputText("\n\nYou rest your [butt] back onto the ground and your arms limply at your sides. After several minutes of catching your breath, you pull the toy out of you with a sigh of relief and pleasure. The experience has been quite draining; you decide to rest for some time longer before washing up.");
				}
				//50+ Corruption Shit
				else {
					outputText("\n\nYou blush perversely as you grasp your phallic toy. The firm dildo bends slightly as you hold it in your hand. A small jolt of giddiness runs through you as you remove your [armor].");
					outputText("\n\nPrancing nude to a comfortable spot, you proceed to rest on your [butt] and place the toy cock aside as you eagerly prepare your [vagina]. You rub your lips gently as you relax your vaginal muscles. Not wishing to leave your mouth out of the fun, you grasp this dildo and begin to lick and suckle it. The passion of the act urging you on, you push a finger inside your [vagina]. Its tight grip on your finger emphasizes the inexperience of the little hole - a problem you're soon to fix.");
					outputText("\n\nWith your faux phallus slick with saliva, you remove the digit from your virgin depths. You press the tip against your entrance, savouring your last moments of virginity. Your poor hymen was only an obstacle for cock, and you're the only one truly worthy of taking your virginity. You push the lust-driving object inside. Pain shoots through you, forcing a gasp from you, but failing to halt your beloved cherry-picker's progress. When you finally reach the greatest depth you can, you release the dildo, breathing deeply as the pain passes.");
					//CUNT CHANGE CALL
					player.cuntChange(8, true, true, false);
					outputText("\n\nYet to be satisfied, you regain composure and start pumping into your freshly plucked flower. Your other hand rushes to massage and caress your sensitive [chest]. The fantasies of all the monstrous cocks you'll have thrusted into you spur the rough piston motion, eager to train your [vagina] for its fated task. You slide onto your back as your body devotes itself to pleasure, moans and whimpers fleeting from your mouth. The stimulation builds, only enhanced by the mild pain of inexperience, and within minutes you tense up and scream in ecstasy. Fluids squirt from your [vagina], and you smile gleefully. When the orgasm has passed, you pull your well-used toy from your newly trained slutting-slot. You bring the dildo to your lips to give it an affectionate kiss and lick your virginal blood from it's surface.");
					outputText("\n\nAfter basking in the afterglow, you clean yourself up and redress.");
				}
			}
			//Repeat Dildo For Ladyboners
			else {
				sceneHunter.print("Check failed: virgin!")
				outputText("You remove your [armor] and sit yourself down behind a rock not far from camp, being sure to bring your toy with you.");
				outputText("\n\nSpreading your [legs], you rub two fingers between your lips, while also suckling your healthy-sized faux cock to lubricate it. Your [vagina] becomes slick with your juices in moments and you eagerly delve a finger into the thirsty hole. The digit goes in slowly and deeply, pleasuring your inner walls with tender stimulation. Your muscles begin to relax, and you feel ready to move onto the main event. Removing the saliva-slicked toy from your mouth, you trade it with your finger. The satisfying easing of the dildo into your nethers is matched by your feminine flavor pushing across your tongue. Muffled moans escape your plugged maw as the beloved toy sinks deep into your [vagina]. Using your free hand, you grope and caress your [chest].");
				player.cuntChange(8, true, true, false);
				outputText("\n\nThe erotic pumping of the phallic object picks up the pace as you gently build a rhythm with the beating of your heart and tensing of your vaginal walls. Your breathing heaves, and your moans become almost as desperate as they are lustful. Soon the pleasure is rising up into unstoppable tide of phallus-induced ecstasy, and you slide from against the rock to on your side, still fucking yourself with blissful joy. The constant thrusting of the toy begins to make you shake and lose rhythm, your body wanting only to fuck as hard and fast as possible.");
				outputText("\n\nYour orgasm arrives with supreme relief as you force the dildo to your furthest depths. Juices spurt from your genitals, and you roll onto your back to rest. When your breathing regulates, you pull the thoroughly used toy from your [vagina] and prepare to return to camp.");
			}
			masturGasm("Vaginal");
			statScreenRefresh();
			endEncounter();
		}

		//Dildo in the butt because why not?
		private function dildoButts():void {
			clearOutput();
			outputText("A kinky idea crosses your mind, and you grab your dildo. Finding a safe spot a short distance from camp, you undo your [armor] and rest on your [butt].");
			outputText("\n\nYou adjust your position as you spread your [legs], giving you the most comfortable access to your [asshole]. You sloppily lick an experimental finger and carry it down to the eager entrance between your cheeks. ");
			if (player.analCapacity() <= 8)
				outputText("Your tight hole offers resistance at first, but soon relaxes with a tender, lubricated fingering.");
			else outputText("Your experienced hole readily accepts your saliva-coated finger.");
			outputText(" As you gently rub your insides, you use your free hand and reach up to pinch and rub your [nipples]. As the motions become easier, you push a second finger inside as well. You soon find your sensitive anal entrance begging for something more appropriate, and you happily oblige.");
			outputText("\n\nGrabbing your toy, you give it several long wet licks before holding your [legs] up and sending the substitute cock to its true task. You rub the tip against your [asshole] momentarily before finally pushing it inside. Stuttering moans escape your lips as your butt gets its much-needed fill of firm faux phallus");
			if (silly()) outputText(", the alliteration of the experience further arousing you");
			outputText(". Your toes curl as you begin to pull in and out, pumping the dildo with smooth motions. Your tongue hangs from your mouth, your breathing becomes heavy, and your moans lewdly express pure lust as you increase your tempo. Before too long, you feel your pucker becoming more sensitive and know an orgasm is quickly approaching.");
			player.buttChange(8, true, true, false);
			if (player.hasCock() && player.hasVagina())
				outputText("\n\nYou moan in ecstasy while your [vagina] and [cocks] erupt with sex juices. ");
			else if (player.hasCock())
				outputText("\n\nYou moan in ecstasy while cum spurts from your [cocks]. ");
			else if (player.hasVagina()) {
				outputText("\n\nYou moan in ecstasy while juices ");
				if (player.wetness() >= 4)
					outputText("squirt");
				else outputText("trickle");
				outputText(" from your [vagina]. ");
			}
			else outputText("\n\n");
			outputText("Your body shakes and rocks from the anal orgasm before slumping onto your back. Happily tightening around the toy with each beat of your hammering heart, you rest.");
			outputText("\n\nSome time later, you gather your things and return to camp.");
			masturGasm("Anal");
			dynStats("sen", 0.5);
			statScreenRefresh();
			endEncounter();
		}

		private function midasCockJackingGemsRoll():int {
			var cockSocks:int = player.countCockSocks("gilded");
			var gems:int = 10 + rand(20);

			if (player.cumQ() < 1000 * cockSocks)
				gems += player.cumQ() / 10;
			else if (player.cumQ() < 2500 * cockSocks)
				gems += player.cumQ() / 50;
			else if (player.cumQ() < 5000 * cockSocks)
				gems += player.cumQ() / 150;
			else if (player.cumQ() < 10000 * cockSocks)
				gems += player.cumQ() / 450;
			else
				gems += player.cumQ() / 1350;

			if (gems > 200 * cockSocks)
				gems = 200 * cockSocks + rand(20);

			return gems;
		}

		private function onaholeRepeatUse(corrupted:Boolean):void {
			var gemsCreated:int = 0; //Changed as gems caused a duplicate var warning
			if (player.countCockSocks("gilded") > 0 && flags[kFLAGS.GILDED_JERKED] < player.countCockSocks("gilded")) {
				flags[kFLAGS.GILDED_JERKED]++;
				gemsCreated = midasCockJackingGemsRoll();
				player.gems += gemsCreated;
			}
			if (corrupted) {
				outputText("Amused, yet annoyed by the aching of your loins, you take out the well-used onahole to give yourself a good, old-fashioned cock milking. With singular purpose, you impale the toy on your [cock] and begin hammering away as if the world depended upon your orgasm. Your fist is but a blur as the toy pumps your [cock] beyond any degree of reason. Relishing in each cramp of pleasure as your cum builds, you flex your well-toned pelvic muscles to both heighten your pleasure and to prevent premature release of the impressive batch you are working on. As time passes, even your impressive physical control is no match for the need to unload your spunk. Waiting until the pressure mashes the base of your cock, you strip the toy away from your shaft and with a great squeeze of your crotch, let loose an impressive stream of cock juice that arcs several yards away. Impressed with your own orgasm, you smile, grit your teeth and continue clenching your crotch muscles in an attempt to repeat your massive distance in the orgasm. Lance upon lance of fuck-milk hoses the area down as you empty yourself of your overwhelming lust. After a few dozen shots, your body empties itself of its needs and fatigue strikes you. After cleaning yourself up and rearranging your area to avoid the massive cum puddle you made, ");

				if (gemsCreated > 0) {
					outputText("<b>you relize the puddle is shimmering strangly. Looking closer you see that your man milk is coalescing into gems! You start collecting them, counting them as you go. You end up with " + gemsCreated + " gems and very little cum.</b>");
				}
				else {
					outputText("you lay back to recuperate your strength knowing that your dick will demand more attention later.");
				}
			}
			else {
				outputText("Much to your annoyance and embarrassment, you feel the need to relieve yourself of your tension. Sighing in reservation, you remove the used onahole from your sack. Operating with a mind of its own, your [cock] springs to attention, anticipating the coming stimulation and release. Your member easily pushes past the opening in the toy and you begin working your penis with some vigor. Pleasure begins to pulse through your [cock] as you build yourself up. The force of the building fluids pushes against your inner organs, creating the paradoxical sensation of pain and pleasure. Pure instict takes over, and your hips begin to buck reflexively. With a sudden, sharp pinch at the base of your member, the need to cum takes over your body");

				if (gemsCreated > 0) {
					outputText(". You pop the toy from your rod and let your reflexes hump the sky.");

					outputText("\n\nPanting and humping hard, you watch the jet of cum shimmers through the air. Caught in the light of the golden cocksock, it beads and twists into small crystals.  In a glittering shower, a ");
					if (player.cumQ() < 25)
						outputText("sprinkle");
					else if (player.cumQ() < 250)
						outputText("rain");
					else outputText("torrent");
					outputText(" of gems falls down upon your body instead of cum, bouncing off your " + player.skinFurScales() + ".\n\n<b>You force yourself to pick up the " + gemsCreated + " gems before passing out.</b>");
				}
				else {
					outputText("as multiple streams of semen erupt from your dong, creating an impressive mess about you. Soaked in your own fluids, you take a moment to clean yourself up before replacing the toy in your bag and going to sleep, happy to be relieved of your urges.");
				}
			}
		}

		private function gooeySatisfaction():void {
			clearOutput();
			outputText("You are way too horny to hunt anything right now, and while you could just let the imp next door use you to empty his seed, you would rather be the one on top.\n"
				+ "\n"
				+ "With those facts clear, you" + player.clothedOrNaked(" ooze out of your equipment and") + " get ready to blow off some steam. That said, now that you think about it, you are literally made of goo. You could shape your body however you like in a thousand possible form and giggle at the idea of what your about to inflict yourself.\n"
				+ "\n"
				+ "Between your legs a pair of vagina’s with no less than 20 small squirming tentacle like clitorises lining their innerside has formed to replace your standard equipment at your command and heck, you know exactly how you will use them. Your first move is to solidify this part of yourself as you joyfully plow both holes with your hands, reshaping them into cocks and filling yourself entirely with big pulsing lengths. When it comes to it, your entire body is like a malleable sex toy and the only limit to how hard you can fuck yourself is that of your imagination.\n"
				+ "\n"
				+ "Your [breasts] pulse with gelatinous pleasure as you squeeze your orb with two newly formed gooey tentacles, small spurts of [skin color] slime drooping from your sensitive goo tits and drooling mouth as you slowly edge yourself toward orgasm. Obviously no fluids are lost in this process, this is only the result of you slowly losing cohesion and form. \n"
				+ "\n"
				+ "You finally fall into a puddle on the ground as you achieve release, [skin color] goo spewing everywhere from your cocks, breasts and cunts. Obviously, you take care to recover the fluid as you ready yourself back for adventure, thoroughly satisfied albeit not sated.\n");
			player.sexReward("no", "Default");
			endEncounter();
		}

		private function mummySex():void {
			clearOutput();
			outputText("Feeling antsy, you remove your clothes and order your slaves to do their jobs. The dim-witted mummies lumber toward your exposed genitals like a thirsty desert dweller toward an oasis.\n\n");
			if (player.hasCock()) outputText("One of the mummies grabs hold of your now fully erect [cock] and begins to lick the tip"+(player.hasBalls()?", while another daring zombie kneels beneath your legs and begins suckling on your balls, the mummy aphrodisiac-laden saliva causing them to churn and increase in size with a steadily growing reward for your pets. You're going to cum far more than usual, and your pets will take it to the last drop":"")+". You grab the meat slave’s head and pull it onto your needy prick, incentivizing it to deepthroat you. On cue, the mummy eagerly wraps its tongue around your cock and pulls you in, letting you enjoy the full deal of its throat massage as it attempts to milk you off your excess energy.\n\n");
			outputText((player.gender == 3?"While your cock is being taken care of, a":"A")+" mummy stretches backwards between your legs and grabs your tights to get easy access to your needy snatch, its black tongue slithering in to leech at your excess soul force. You gladly let the intruder in, savoring as it laps at your button to quench its insatiable thirst.\n\n");
			outputText((player.hasBreasts()?"You knead your own nipple, grabbing your breasts with both hands and pulling hard in order to maximize the crashing wave of pleasures as your servants’’ tingling touches drive you over the edge. ":"")+"You cum hard "+(player.gender == 3?"both ":"")+"from your "+(player.hasCock()?"overwhelmed cock "+(player.hasBalls()?"and nuts ":"")+"":"")+(player.gender == 3?", as well as ":"")+(player.hasVagina()?"drenched [pussy] ":"")+"feeding your servants with a torrent of soul force, albeit just enough to power them up and keep them well addicted to you. Now fed with energy they will be extra vicious for a while.\n\n");
			outputText("Satisfied, you order your pets off and redress, ready to go back to your adventures.");
			EngineCore.SoulforceChange( -Math.round(player.maxSoulforce() * 0.5));
			player.addPerkValue(PerkLib.MummyLord,2,24);
			flags[kFLAGS.TIMES_MASTURBATED]++;
			if (player.gender == 3) masturGasm("Dick", "Vaginal");
			if (player.gender == 2) masturGasm("Vaginal");
			else masturGasm("Dick");
			endEncounter();
		}
	}
}
