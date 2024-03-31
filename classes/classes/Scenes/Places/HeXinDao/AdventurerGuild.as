/**
 * ...
 * @author Ormael and others
 */
package classes.Scenes.Places.HeXinDao
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.ItemBag;
import classes.Scenes.SceneLib;
import classes.internals.EnumValue;
import classes.internals.SaveableState;

import coc.view.ButtonDataList;

public class AdventurerGuild extends HeXinDaoAbstractContent implements SaveableState
	{
		// Array of pairs [item type, guild rank]
		private static const slotDefs:Array = [
			//Copper plate 01-02
			[useables.IMPSKLL, RANK_COPPER], // 01 imp skulls
			[useables.FIMPSKL, RANK_COPPER], // 02 feral imp skulls
			//Iron plate 03-05
			[useables.MINOHOR, RANK_IRON],   // 03 minotaur horns
			[useables.DEMSKLL, RANK_IRON],   // 04 demon skulls
			[useables.SEVTENT, RANK_IRON],   // 05 feral tentacle beasts
			//Bronze plate 06-07
			[ItemType.NOTHING, RANK_BRONZE], // 06
			[ItemType.NOTHING, RANK_BRONZE]  // 07
			//Silver plate 08-09
			//Gold plate 10-12
			//Platinum plate 13-16
			//Mithril plate 17-20
			//Orichalcum plate 21-25
			//Adamantite plate 26-30
		];
		public static var lootBag:ItemBag = new ItemBag(
				// convert array of pairs to array of item types by picking each pair element 0
				mapOneProp(slotDefs,"0"),
				30
		);
		private static var itemIdToSlotIndex:Object = {};

		public function stateObjectName():String {
			return "AdventurerGuild";
		}

		public function resetState():void {
			lootBag.resetState();
		}

		public function saveToObject():Object {
			return lootBag.saveToObject();
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				if ("Slots" in o) {
					lootBag.loadFromObject(o,ignoreErrors);
				} else if ("Slot01" in o) {
					resetState();
					// old version: "Slot01".."Slot30", "Slot01Cap".."Slot30Cap"
					for (var i:int = 0; i < lootBag.SlotCount; i++) {
						var s:String = padStart(String(i + 1), 2, "0");
						lootBag.Slots[i]     = numberOr(o["Slot" + s], 0);
						lootBag.SlotCaps[i]  = numberOr(o["Slot" + s + "Cap"], 0);
					}
				} else {
					resetState();
				}
			} else {
				// loading from old save
				resetState();
			}
		}

		public function AdventurerGuild()
		{
			Saves.registerSaveableState(this);
			resetState();
		}
		
		public static const GuildRanks:/*EnumValue*/Array = [];
		public static const RANK_NONE:int                 = 0;
		EnumValue.add(GuildRanks, RANK_NONE, "NONE", {
			displayName: "None"
		});
		public static const RANK_COPPER:int = 1;
		EnumValue.add(GuildRanks, RANK_COPPER, "COPPER", {
			name: "Copper",
			keyItem: "Adventurer Guild: Copper plate"
		});
		public static const RANK_IRON:int = 2;
		EnumValue.add(GuildRanks, RANK_IRON, "IRON", {
			name: "Iron",
			keyItem: "Adventurer Guild: Iron plate"
		});
		public static const RANK_BRONZE:int = 3;
		EnumValue.add(GuildRanks, RANK_BRONZE, "BRONZE", {
			name: "Bronze",
			keyItem: "Adventurer Guild: Bronze plate"
		});
		// "Adventurer Guild: Silver plate"
		// "Adventurer Guild: Gold plate"
		// "Adventurer Guild: Platinum plate"
		// "Adventurer Guild: Mithril plate"
		// "Adventurer Guild: Orichalcum plate"
		// "Adventurer Guild: Adamantite plate"
		
		/** Set all SlotCaps for rank to cap */
		public static function unlockSlotsForRank(rank:int, cap:int):void {
			for (var slot:int = 0; slot < slotDefs.length; slot++) {
				if (slotDefs[slot][1] == rank) lootBag.SlotCaps[slot] = cap;
			}
		}
		public static function get playerGuildLevel():int {
			for (var i:int = GuildRanks.length-1; i>0; i--) {
				if (GuildRanks[i] && GuildRanks[i].keyItem && player.hasKeyItem(GuildRanks[i].keyItem) >= 0) return i;
			}
			return RANK_NONE;
		}
		public static function get playerInGuild():Boolean {
			return playerGuildLevel > 0;
		}
		
		public function BoardkeeperYangMain():void {
			clearOutput();
			if (playerInGuild) {
				outputText("Yang the job handler wait at you arm crossed. She looks bored like she has been there all day.\n\n");
				outputText("\"<i>So [name] how can I help you today? Here to talk jobs or something else?</i>\"");
				menu();
				addButton(0, "Quest", BoardkeeperYangQuest);
				addButton(1, "Talk", BoardkeeperYangTalk);
				if (player.keyItemvX("Adventurer Guild: Copper plate", 1) > 1 || player.keyItemvX("Adventurer Guild: Iron plate", 1) > 1) addButton(2, "Promotion", BoardkeeperYangPromotion).hint("Ask Yang for a promotion once you have achieved enough jobs.");
				else addButtonDisabled(2, "Promotion", "Not meet req.");
				addButton(3, "Sex", BoardkeeperYangSex);
				addButton(4, "Back", curry(SceneLib.journeyToTheEast.enteringInn, false));
				if (flags[kFLAGS.AURORA_LVL] == 0.3 || (flags[kFLAGS.AURORA_LVL] >= 0.6 && flags[kFLAGS.AURORA_LVL] < 0.75)) addButton(5, "GRJ", BoardkeeperYangGolemRetrievalJob).hint("Golem retrieval job");
			}
			else {
				outputText("You approach the board covered in colorful papers and the panda girl next to it smiles at you.\n\n");
				outputText("\"<i>Well hello there! Are you looking for a job? I represent the adventurer guild and my organization could use more able bodied men and women like you.</i>\"\n\n");
				outputText("An adventurer guild? What's the benefits?\n\n");
				outputText("\"<i>Mareth is filled with perils, lost treasures and people in need of heroic assistance. By paying a small membership fee I can let you in on local events that could use your assistance and give you pointers to unplundered ruins. It’s only 5 spirit stones to join. Fame and treasure? All within your reach to grab.</i>\"");
				menu();
				addButton(0, "Decline", No);
				addButton(1, "Join", Yes);
			}
		}
		private function No():void {
			clearOutput();
			outputText("You aren’t interested in dungeon delving at the time. It's barely worth it while you're overburdened with your regular activities.");
			doNext(SceneLib.journeyToTheEast.enteringInn,false);
		}
		private function Yes():void{
			clearOutput();
			if (flags[kFLAGS.SPIRIT_STONES] < 5) {
				outputText("Yeah sure, you will join. Or rather you would like to but you lack the required spirit stones for the membership fee.\n\n");
				outputText("\"<i>It's ok just go to Moga Hen, he should be able to exchange those gem of yours for the local currency.</i>\"");
				doNext(SceneLib.journeyToTheEast.enteringInn,false);
			}
			else {
				outputText("Yeah sure, you will join. You handle the ursine woman the spirit stones and sign the papers.\n\n");
				outputText("\"<i>Perfect, Just perfect. Let me hand you over your badge.</i>\"\n\n");
				outputText("She picks up a small Copper colored plate and gives it to you.\n\n");
				outputText("\"<i>Well as of now you are officially a member of the adventurer guild. Tell whenever you are ready ask for a quest and I will direct you to your target.</i>\"\n\n");
				flags[kFLAGS.SPIRIT_STONES] -= 5;
				statScreenRefresh();
				player.createKeyItem("Adventurer Guild: Copper plate", 0, 0, 0, 0);
				unlockSlotsForRank(RANK_COPPER, 10);
				doNext(BoardkeeperYangMain);
			}
		}
		public function BoardkeeperYangQuest():void {
			clearOutput();
			outputText("The panda girl nods and allows you to browse the board.\n\n");
			outputText("\"<i>Plenty of quest available. Which one will you take?</i>\"\n\n");
			menu();
			addButton(0, "Imps", BoardkeeperYangQuestImps1).hint("Copper tier Quest.");
			addButton(1, "Ferals(1)", BoardkeeperYangQuestFerals1).hint("(T.Beasts) Copper tier Quest.");
			addButton(2, "Ferals(2)", BoardkeeperYangQuestFerals2).hint("(Imps) Copper tier Quest.");
			addButton(3, "Minotaurs", BoardkeeperYangQuestMinotaurs).hint("Copper tier Quest.");
			if (player.hasKeyItem("Adventurer Guild: Iron plate") >= 0) {
				addButton(4, "Demons", BoardkeeperYangQuestDemons1).hint("Iron tier Quest.");
			}
			else {
				addButtonDisabled(4, "Demons", "Only for Iron tier Adventurer.");
			}
			addButton(5, "Gel", BoardkeeperYangQuestGel).hint("Copper tier Quest.");
			addButton(6, "Chitin", BoardkeeperYangQuestChitin).hint("Copper tier Quest.");
			if (flags[kFLAGS.GALIA_LVL_UP] == 0.53 || (flags[kFLAGS.GALIA_LVL_UP] >= 0.5 && flags[kFLAGS.GALIA_TALKS] > 0)) addButtonDisabled(10, "Ferals (C)", "You already finished this quest.");
			else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) >= 2) {
				if (flags[kFLAGS.GALIA_LVL_UP] >= 0.44 && flags[kFLAGS.GALIA_AFFECTION] == 10) addButton(10, "Ferals (C)", BoardkeeperYangQuestEzekiel1a);
				else addButton(10, "Ferals (C)", BoardkeeperYangQuestEzekiel1);
			}
			else addButtonDisabled(10, "Ferals (C)", "Req. finishing Ferals(2) quest first.");
			addButton(14, "Back", BoardkeeperYangMain);
		}
		public function BoardkeeperYangQuestImps1():void {
			clearOutput();
			if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests1)) {
				if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) > 6) {
					outputText("The panda declines the job request.\n\n");
					outputText("\"<i>Sorry [name], this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 6) {
					if (player.hasItem(useables.IMPSKLL, 5, true)) {
						outputText("Yang examines the skulls to make sure they are imps and then nods.\n\n");
						outputText("\"<i>Good job [name] here is your payment.</i>\"\n\n");
						outputText("(<b>Gained 7 Spirit Stones</b>)");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 1);
						player.destroyItems(useables.IMPSKLL, 5, true);
						flags[kFLAGS.SPIRIT_STONES] += 7;
						statScreenRefresh();
					}
					else {
						outputText("The panda taps her foot on the ground.\n\n");
						outputText("\"<i>I thought I had been clear the bounty require 5 imps skulls, [name]. Get back to hunting.</i>\"\n\n");
					}
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 4) {
					outputText("Yang eyes you with keen interest then asks,\n\n");
					outputText("\"<i>Would you actually be interested in something easier? Right now there's a bounty on imp slaying. Bring me back 5 imp skulls and I will see it through that you are properly rewarded.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 2);
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 3) {
					if (player.hasItem(useables.IMPSKLL, 4, true)) {
						outputText("Yang examines the skulls to make sure they are imps and then nods.\n\n");
						outputText("\"<i>Good job [name], here's your payment: a special training scroll for increasing your innate potential.</i>\"\n\n");
						outputText("(<b>Gained 1 Perk Point</b>)");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 1);
						player.destroyItems(useables.IMPSKLL, 4, true);
						player.perkPoints += 1;
					}
					else {
						outputText("The panda taps her foot on the ground.\n\n");
						outputText("\"<i>I thought I had been clear the bounty require 4 imps skulls, [name]. Get back to hunting.</i>\"\n\n");
					}
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 2) {
					outputText("Yang eyes you with keen interest then asks,\n\n");
					outputText("\"<i>Would you actually be interested in something easier? Right now there's a bounty on imp slaying. Bring me back 4 imp skulls and I will see it through that you are properly rewarded.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 1);
				}
				else {
					if (player.hasItem(useables.IMPSKLL, 3, true)) {
						outputText("Yang examines the skulls to make sure they are imps and then nods.\n\n");
						outputText("\"<i>Good job [name] here is your payment. By the way, I thought you may want to be able to sense corruption, can be useful to hunt demons. Here, have this amulet.</i>\"\n\n");
						outputText("(<b>Acquired Demon Hunter Amulet!</b>)\n\n");
						outputText("(<b>Gained New Perk: Sense Corruption</b>)");
						if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0) player.addKeyValue("Adventurer Guild: Copper plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 1);
						player.createKeyItem("Demon Hunter Amulet", 0, 0, 0, 0);
						player.createPerk(PerkLib.SenseCorruption, 0, 0, 0, 0);
						player.destroyItems(useables.IMPSKLL, 3, true);
					}
					else {
						outputText("The panda taps her foot on the ground.\n\n");
						outputText("\"<i>I thought I had been clear the bounty require 3 imps skulls, [name]. Get back to hunting.</i>\"\n\n");
					}
				}
			}
			else {
				outputText("Yang eyes you with keen interest then asks\n\n");
				outputText("\"<i>Would you actually be interested in something easier? Right now there's a bounty on imp slaying. Bring me back 3 imp skulls and I will see it through that you are properly rewarded.</i>\"\n\n");
				if (!player.hasStatusEffect(StatusEffects.AdventureGuildQuestsCounter1)) player.createStatusEffect(StatusEffects.AdventureGuildQuestsCounter1, 0, 0, 0, 0);
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests1)) player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 1);
				else player.createStatusEffect(StatusEffects.AdventureGuildQuests1, 1, 0, 0, 0);
			}
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangQuestFerals1():void {
			clearOutput();
			if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) > 0) {
				if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) > 6) {
					outputText("The panda declines the job request.\n\n");
					outputText("\"<i>Sorry [name], this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 6) {
					if (player.hasItem(useables.SEVTENT, 3, true)) {
						outputText("You turn in the quest and Yang nods in appreciation.\n\n");
						outputText("\"<i>Good job there. I hope those plants didn't prove too much trouble. Here's your payment.</i>\"\n\n");
						outputText("(<b>Gained 8 Spirit Stones</b>)");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 1);
						player.destroyItems(useables.SEVTENT, 3, true);
						flags[kFLAGS.SPIRIT_STONES] += 8;
						statScreenRefresh();
					}
					else outputText("You try to turn in the quest, but Yang tells you you don’t have enough tentacles yet.\n\n");
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 4) {
					outputText("\"<i>Someone put up a bounty for slaying tentacle beasts. I would need... let's say 3 tentacles from those mishapen creatures as proof of your deed. Of course, you will be rewarded for the job.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 2);
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 3) {
					if (player.hasItem(useables.SEVTENT, 2, true)) {
						outputText("You turn in the quest and Yang nods in appreciation.\n\n");
						outputText("\"<i>Good job [name], here's your payment: a special training scroll for increasing your innate potential.</i>\"\n\n");
						outputText("(<b>Gained 1 Perk Point</b>)");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 1);
						player.destroyItems(useables.SEVTENT, 2, true);
						player.perkPoints += 1;
					}
					else outputText("You try to turn in the quest, but Yang tells you you don’t have enough tentacles yet.\n\n");
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 2) {
					outputText("\"<i>Someone put up a bounty for slaying tentacle beasts. I would need... let's say 2 tentacles from those mishapen creatures as proof of your deed. Of course, you will be rewarded for the job.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 1);
				}
				else {
					if (player.hasItem(useables.SEVTENT, 1, true)) {
						outputText("You turn in the quest and Yang nods in appreciation.\n\n");
						outputText("\"<i>My my, I wasn’t sure I would ever see you back.</i>\"\n\n");
						outputText("Seems she misjudged you then?\n\n");
						outputText("\"<i>Everyone makes mistakes and plant assignments are way more dangerous than imps, you clearly outpaced expectation. Here's your payment. Some man told me to leave you this scroll as the reward... should help you sense the anger of your opponents, he said.</i>\"\n\n");
						outputText("(<b>Gained New Perk: Sense Wrath</b>)");
						if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0) player.addKeyValue("Adventurer Guild: Copper plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 1);
						player.createPerk(PerkLib.SenseWrath, 0, 0, 0, 0);
						player.destroyItems(useables.SEVTENT, 1, true);
					}
					else outputText("You try to turn in the quest, but Yang tells you you don’t have enough tentacles yet.\n\n");
				}
			}
			else {
				outputText("\"<i>Someone put up a bounty for slaying tentacle beast. I would need lets say 1 tentacle from those mishapen creature as proof of your deed. Of course you will be rewarded for the job.</i>\"\n\n");
				outputText("You shrug and accept the job. Plants... what could go wrong?\n\n");
				if (!player.hasStatusEffect(StatusEffects.AdventureGuildQuestsCounter2)) player.createStatusEffect(StatusEffects.AdventureGuildQuestsCounter2, 0, 0, 0, 0);
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests2)) player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 1);
				else player.createStatusEffect(StatusEffects.AdventureGuildQuests2, 1, 0, 0, 0);
			}
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangQuestDemons1():void {
			clearOutput();
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) > 0) {
				if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) > 6) {
					outputText("The panda declines the job request.\n\n");
					outputText("\"<i>Sorry [name], this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 6) {
					if (player.hasItem(useables.DEMSKLL, 3, true)) {
						outputText("You turn in the quest and Yang nods.\n\n");
						outputText("\"<i>Good job as usual. Here's your payment.</i>\"\n\n");
						outputText("(<b>Gained 8 Spirit Stones</b>)");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 2, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, 1);
						player.destroyItems(useables.DEMSKLL, 3, true);
						flags[kFLAGS.SPIRIT_STONES] += 8;
						statScreenRefresh();
					}
					else {
						outputText("The panda taps her foot on the ground.\n\n");
						outputText("\"<i>I thought I had been clear the bounty require 3 demon skulls, [name]. Get back to hunting.</i>\"\n\n");
					}
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 4) {
					outputText("\"<i>Hey, [name]. I happen to have a new higher grade job for you if you’re interested.</i>\"\n\n");
					outputText("Of course you're interested, what’s the job?\n\n");
					outputText("\"<i>See, it happens the town offers a generous sum for every demon slain. Bring me proof of the death of 3 demons.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, 2);
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 3) {
					if (player.hasItem(useables.DEMSKLL, 2, true)) {
						outputText("You turn in the quest and Yang nods.\n\n");
						outputText("\"<i>Good job [name], here's your payment: a special training scroll for increasing your innate potential.</i>\"\n\n");
						outputText("(<b>Gained 1 Perk Point</b>)");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 2, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, 1);
						player.destroyItems(useables.DEMSKLL, 2, true);
						player.perkPoints += 1;
					}
					else {
						outputText("The panda taps her foot on the ground.\n\n");
						outputText("\"<i>I thought I had been clear the bounty require 2 demon skulls, [name]. Get back to hunting.</i>\"\n\n");
					}
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 2) {
					outputText("\"<i>Hey, [name]. I happen to have a new higher grade job for you if you’re interested.</i>\"\n\n");
					outputText("Of course you're interested, what’s the job?\n\n");
					outputText("\"<i>See, it happens the town offers a generous sum for every demon slain. Bring me proof of the death of 2 demons.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, 1);
				}
				else {
					if (player.hasItem(useables.DEMSKLL, 1, true)) {
						outputText("You display the proof of your victory.\n\n");
						outputText("\"<i>Nice job, [name]. So about that special reward. It happens a traveling demon hunter has agreed to train whoever would kill demons in the art of slaying. Chika, would you please come over? [Name] cleared your bounty.</i>\"\n\n");
						outputText("Chika appears to be a rattel morph with an eyepatch. Rattel, or honey badgers, are known for their ferocity; the set of throwing daggers and poison flasks hanging from her belt, the pair of scimitars on her side and the crossbow on her back tells everything you need about her, ");
						outputText("she's clearly an expert killer. Chika's gaze goes through you and the inflexibility and sternness of it leaves you somewhat intimidated.\n\n");
						outputText("\"<i>Doesn’t look like much... Ye sure [he] smoked the targets?</i>\"\n\n");
						outputText("Yang goes by the affirmative.\n\n");
						outputText("\"<i>Ye and I are going to have a lot of dealings in the future. But first I want ya to follow me out in the town training area. I have a few things I would like to teach ye.</i>\"\n\n");
						outputText("You spend the four next hours with the rattel morph learning new demon killing tricks. By the end of your training you have accumulated a good bank of knowledge on demon weak points and how to exploit them. Chika leaves by the end, warning that you and her will eventually meet again.\n\n");
						outputText("(<b>Gained New Perk: Demon Slayer</b>)");
						if (player.hasKeyItem("Adventurer Guild: Iron plate") >= 0) player.addKeyValue("Adventurer Guild: Iron plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 2, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, 1);
						player.createPerk(PerkLib.DemonSlayer, 0.1, 0, 0, 0);
						player.destroyItems(useables.DEMSKLL, 1, true);
					}
					else {
						outputText("The panda taps her foot on the ground.\n\n");
						outputText("\"<i>I thought I had been clear the bounty require a demon skull, [name]. Get back to hunting.</i>\"\n\n");
					}
				}
			}
			else {
				outputText("\"<i>Hey, [name]. I happen to have a new higher grade job for you if you’re interested.</i>\"\n\n");
				outputText("Of course you're interested, what’s the job?\n\n");
				outputText("\"<i>See, it happens the town offers a generous sum for every demon slain if you can bring me back proof of the death. Should you come back I have a special reward for you, in addition to your pay.</i>\"\n\n");
				if (!player.hasStatusEffect(StatusEffects.AdventureGuildQuestsCounter1)) player.createStatusEffect(StatusEffects.AdventureGuildQuestsCounter1, 0, 0, 0, 0);
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests1)) player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, 1);
				else player.createStatusEffect(StatusEffects.AdventureGuildQuests1, 0, 1, 0, 0);
			}
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangQuestFerals2():void {
			clearOutput();
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) > 0) {
				if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) > 6) {
					outputText("The panda declines the job request.\n\n");
					outputText("\"<i>Sorry [name], this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 6) {
					if (player.hasItem(useables.FIMPSKL, 5, true)) {
						outputText("You turn in the quest and Yang nods in appreciation.\n\n");
						outputText("\"<i>Good job there. I heard those creatures are actually out there killing instead of raping, it’s quite chilling. Here's your payment.</i>\"\n\n");
						outputText("(<b>Gained 7 Spirit Stones</b>)");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 2, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 1);
						player.destroyItems(useables.FIMPSKL, 5, true);
						flags[kFLAGS.SPIRIT_STONES] += 7;
						statScreenRefresh();
					}
					else outputText("You try to turn in the quest, but Yang tells you you don’t have enough feral imp skulls yet.\n\n");
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 4) {
					outputText("\"<i>Someone put up a bounty for slaying feral imps. I would need... let's say 5 feral imp skulls from those mishapen creatures as proof of your deed. Of course you will be rewarded for the job.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 2);
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 3) {
					if (player.hasItem(useables.FIMPSKL, 4, true)) {
						outputText("You turn in the quest and Yang nods in appreciation.\n\n");
						outputText("\"<i>Good job there. I heard those creatures are actually out there killing instead of raping, it’s quite chilling. Here's your payment: a special training scroll for increasing your innate potential.</i>\"\n\n");
						outputText("(<b>Gained 1 Perk Point</b>)");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 2, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 1);
						player.destroyItems(useables.FIMPSKL, 4, true);
						player.perkPoints += 1;
					}
					else outputText("You try to turn in the quest but Yang tells you you don’t have enough feral imp skulls yet.\n\n");
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 2) {
					outputText("\"<i>Someone put up a bounty for slaying feral imps. I would need... let's say 4 feral imp skulls from those mishapen creature as proof of your deed. Of course you will be rewarded for the job.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 1);
				}
				else {
					if (player.hasItem(useables.FIMPSKL, 3, true)) {
						outputText("You turn in the quest and Yang nods in appreciation.\n\n");
						outputText("\"<i>My my, I wasn’t sure I would ever see you back.</i>\"\n\n");
						outputText("Seems she misjudged you then?\n\n");
						outputText("\"<i>Everyone makes mistakes and feral imp assignments are way more dangerous than normal imps, you clearly outpaced expectation. Here's your payment. Some man told me to leave you this scroll as the reward... should help you fight feral opponents he said.</i>\"\n\n");
						outputText("(<b>Gained New Perk: Feral Hunter</b>)");
						if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0) player.addKeyValue("Adventurer Guild: Copper plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 2, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 1);
						player.createPerk(PerkLib.FeralHunter, 0.1, 0, 0, 0);
						player.destroyItems(useables.FIMPSKL, 3, true);
					}
					else outputText("You try to turn in the quest but Yang tells you you don’t have enough feral imp skulls yet.\n\n");
				}
			}
			else {
				outputText("\"<i>Someone put up a bounty for slaying feral imps. I would need... let's say 3 feral imp skulls from those mishapen creature as proof of your deed. Of course you will be rewarded for the job.</i>\"\n\n");
				outputText("You shrug and accept the job. It's time to hunt some imps.\n\n");
				if (!player.hasStatusEffect(StatusEffects.AdventureGuildQuestsCounter2)) player.createStatusEffect(StatusEffects.AdventureGuildQuestsCounter2, 0, 0, 0, 0);
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests2)) player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 1);
				else player.createStatusEffect(StatusEffects.AdventureGuildQuests2, 0, 1, 0, 0);
			}
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangQuestMinotaurs():void {
			clearOutput();
			if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) > 0) {
				if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) > 6) {
					outputText("The panda declines the job request.\n\n");
					outputText("\"<i>Sorry [name], this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 6) {
					if (player.hasItem(useables.MINOHOR, 4, true)) {
						outputText("Yang counts the horns, then smiles.\n\n");
						outputText("\"<i>Well you did bag four out of four, nice job. The guild asked me to pay you this reward money as usual for slaying bulls. Do come and find me later on for a new job, or for something else...</i>\"\n\n");
						outputText("(<b>Gained 8 Spirit Stones</b>)");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 3, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 1);
						player.destroyItems(useables.MINOHOR, 4, true);
						flags[kFLAGS.SPIRIT_STONES] += 8;
						statScreenRefresh();
					}
					else outputText("\"<i>Hey [name], I counted those horns and clearly you forgot a few. Get out there and bring me the remaining ones.</i>\"\n\n");
				}
				else if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 4) {
					outputText("\"<i>Oh, so you wanna go out and hunt some extra minotaurs? Good! You make sure to kill four or as many as you can so we can breath fresh air safe from minotaur musk, got it?</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 2);
				}
				else if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 3) {
					if (player.hasItem(useables.MINOHOR, 3, true)) {
						outputText("Yang counts the horns, then smiles.\n\n");
						outputText("\"<i>Well you did bag three out of three. Nice job. The guild asked me to pay you with this special training scroll for slaying bulls. Do come and find me later on for a new job, or for something else...</i>\"\n\n");
						outputText("(<b>Gained 1 Perk Point</b>)");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 3, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 1);
						player.destroyItems(useables.MINOHOR, 3, true);
						player.perkPoints += 1;
					}
					else outputText("\"<i>Hey [name], I counted those horns and clearly you forgot a few. Get out there and bring me the remaining ones.</i>\"\n\n");
				}
				else if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 2) {
					outputText("\"<i>Oh so you wanna go out and hunt some extra minotaurs? Good! You make sure to kill three or as many as you can so we can breath fresh air safe from minotaur musk, got it?</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 1);
				}
				else {
					if (player.hasItem(useables.MINOHOR, 2, true)) {
						outputText("Yang counts the horns, then smiles.\n\n");
						outputText("\"<i>Well you indeed did bag two out of two. The guild asked me to pay you this specific tome. Betcha will find nice uses for this. Do come and find me later on for a new job, or for something else...</i>\"\n\n");
						outputText("Yang gives you a telltale wink before handing you over your reward.\n\n");
						if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0) player.addKeyValue("Adventurer Guild: Copper plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 3, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 1);
						player.destroyItems(useables.MINOHOR, 2, true);
						inventory.takeItem(consumables.TCLEAVE, BoardkeeperYangQuest);
						return;
					}
					else outputText("\"<i>Hey [name], I counted those horns and clearly you forgot a few. Get out there and bring me the remaining ones.</i>\"\n\n");
				}
			}
			else {
				outputText("Yang takes on a grave expression.\n\n");
				outputText("\"<i>Look [name], I won’t sugar coat it up for you. We’re buried knee deep into horsecocks, specificaly minotaur cocks. What the guild would like you to do is go out, kill some of the bulls out there, say two or so of them, and bring back their horns. You do that for us and we'll reward you accordingly.</i>\"\n\n");
				if (!player.hasStatusEffect(StatusEffects.AdventureGuildQuestsCounter1)) player.createStatusEffect(StatusEffects.AdventureGuildQuestsCounter1, 0, 0, 0, 0);
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests1)) player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 1);
				else player.createStatusEffect(StatusEffects.AdventureGuildQuests1, 0, 0, 1, 0);
			}
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangQuestGel():void {
			clearOutput();
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) > 0) {
				if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) > 4) {
					outputText("The panda declines the job request.\n\n");
					outputText("\"<i>Sorry [name], this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) == 4) {
					if (player.hasItem(useables.GREENGL, 5)) {
						outputText("You turn in the quest and Yang nods in appreciation.\n\n");
						outputText("\"<i>Good job there. I hope gathering these did not prove to much trouble. Here's your payment.</i>\"\n\n");
						outputText("(<b>Gained 3 Spirit Stones</b>)");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter4, 2, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests4, 2, 1);
						player.destroyItems(useables.GREENGL, 5);
						flags[kFLAGS.SPIRIT_STONES] += 3;
						statScreenRefresh();
					}
					else outputText("You try to turn in the quest but Yang tells you you don’t have enough gel yet.\n\n");
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) == 2) {
					outputText("\"<i>You may or may not like that one. The good news is you are going out to gather gels. The bad news is it primarily drops from goo girls, which is a friendly species so your morality may be put to the test. How you handle that is up to you. Regardless, bring us back 5 gels and your job will be done.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests4, 2, 2);
				}
				else {
					if (player.hasItem(useables.GREENGL, 5)) {
						outputText("You turn in the quest and Yang nods in appreciation.\n\n");
						outputText("\"<i>My my, nice job. I can only hope you kept that weapon clean of innocent blood. Regardless here is your payment. The client told me to leave you this scroll as a reward. You know what to do with it I suppose?</i>\"\n\n");
						if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0) player.addKeyValue("Adventurer Guild: Copper plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter4, 2, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests4, 2, 1);
						player.destroyItems(useables.GREENGL, 5);
						player.perkPoints += 1;
					}
					else outputText("You try to turn in the quest but Yang tells you you don’t have enough gel yet.\n\n");
				}
			}
			else {
				outputText("\"<i>You may or may not like that one. The good news is you are going out to gather gels. The bad news is it primarily drops from goo girls, which is a friendly species so your morality may be put to the test. How you handle that is up to you. Regardless, bring us back 5 gels and your job will be done.</i>\"\n\n");
				if (!player.hasStatusEffect(StatusEffects.AdventureGuildQuestsCounter4)) player.createStatusEffect(StatusEffects.AdventureGuildQuestsCounter4, 0, 0, 0, 0);
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests4)) player.addStatusValue(StatusEffects.AdventureGuildQuests4, 2, 1);
				else player.createStatusEffect(StatusEffects.AdventureGuildQuests4, 0, 1, 0, 0);
			}
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangQuestChitin():void {
			clearOutput();
			if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) > 0) {
				if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) > 4) {
					outputText("The panda declines the job request.\n\n");
					outputText("\"<i>Sorry [name], this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) == 4) {
					if (player.hasItem(useables.B_CHITN, 5)) {
						outputText("You turn in the quest and Yang nods in appreciation.\n\n");
						outputText("\"<i>Good job there. I hope gathering these did not prove to much trouble. Here's your payment.</i>\"\n\n");
						outputText("(<b>Gained 4 Spirit Stones</b>)");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter4, 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests4, 1, 1);
						player.destroyItems(useables.B_CHITN, 5);
						flags[kFLAGS.SPIRIT_STONES] += 4;
						statScreenRefresh();
					}
					else outputText("You try to turn in the quest but Yang tells you you don’t have enough chitin yet.\n\n");
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) == 2) {
					outputText("\"<i>You may or may not like that one. The good news is you are going out to gather chitin. The bad news is it primarily drop from bee girls, which is a friendly species so your morality may be put to the test. How you handle that is up to you, ");
					outputText("for all I know chitin is often found on the forest ground where bee girls thrives. Regardless, bring us back 5 chitin and your job will be done.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests4, 1, 2);
					if (player.statusEffectv3(StatusEffects.AdventureGuildQuests4) > 0) {
						player.removeStatusEffect(StatusEffects.AdventureGuildQuests4);
						player.createStatusEffect(StatusEffects.AdventureGuildQuests4, 4, 0, 0, 0);
					}
				}
				else {
					if (player.hasItem(useables.B_CHITN, 5)) {
						outputText("You turn in the quest and Yang nods in appreciation.\n\n");
						outputText("\"<i>My my, nice job. I can only hope you kept that weapon clean of innocent blood. Regardless, here is your payment. The client told me to leave you this scroll as a reward. You know what to do with it, I suppose?</i>\"\n\n");
						outputText("(<b>Gained 1 Perk Point</b>)");
						if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0) player.addKeyValue("Adventurer Guild: Copper plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter4, 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests4, 1, 1);
						if (player.statusEffectv3(StatusEffects.AdventureGuildQuests4) > 0) {
							player.removeStatusEffect(StatusEffects.AdventureGuildQuests4);
							player.createStatusEffect(StatusEffects.AdventureGuildQuests4, 2, 0, 0, 0);
						}
						player.destroyItems(useables.B_CHITN, 5);
						player.perkPoints += 1;
					}
					else outputText("You try to turn in the quest but Yang tells you you don’t have enough chitin yet.\n\n");
				}
			}
			else {
				outputText("\"<i>You may or may not like that one. The good news is you are going out to gather chitin. The bad news is it primarily drop from bee girls, which is a friendly species so your morality may be put to the test. How you handle that is up to you, ");
				outputText("for all I know chitin is often found on the forest ground where bee girls thrives. Regardless, bring us back 5 chitin and your job will be done.</i>\"\n\n");
				if (!player.hasStatusEffect(StatusEffects.AdventureGuildQuestsCounter4)) player.createStatusEffect(StatusEffects.AdventureGuildQuestsCounter4, 0, 0, 0, 0);
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests4)) player.addStatusValue(StatusEffects.AdventureGuildQuests4, 1, 1);
				else player.createStatusEffect(StatusEffects.AdventureGuildQuests4, 1, 0, 0, 0);
			}
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangQuestEzekiel1():void {
			clearOutput();
			if (flags[kFLAGS.GALIA_LVL_UP] > 0) {
				if (flags[kFLAGS.GALIA_AFFECTION] == 10) {
					outputText("You turn in the quest and Yang nods in appreciation. She verifies the imp, it literally trying to claw at her face before she closes the bag again.\n\n");
					outputText("\"<i>Looks feral, good job there. The imp will be delivered to the researcher's address and she will study it in order to perhaps develop a cure. As for you, I think you earned your reward.</i>\"\n\n");
					outputText("(<b>Gained 2 Spirit Stones</b>)");
					if (flags[kFLAGS.GALIA_LVL_UP] == 0.01) flags[kFLAGS.GALIA_LVL_UP] = 0.05;
					else flags[kFLAGS.GALIA_LVL_UP] += 0.05;
					flags[kFLAGS.GALIA_AFFECTION] = 0;
					flags[kFLAGS.SPIRIT_STONES] += 2;
					statScreenRefresh();
				}
				else outputText("You try to turn in the quest but looking inside your bag Yang tells you you cant turn an empty bag in and need to capture an imp first.\n\n");
			}
			else {
				outputText("\"<i>You remember that scholar studying the feral creatures? Happens to be this time around she needs you to capture feral imps alive. I understand this is a weird job but we need imps to study them and understand what is causing them to go mad. For this purpose, the guild prepared a special enchanted bag for you to stow an imp in. Of course, you will be paid for the job.</i>\"\n\n");
				outputText("You shrug and accept the job. Guess you are back fighting imps once again.\n\n");
				flags[kFLAGS.GALIA_LVL_UP] = 0.01;
			}
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangQuestEzekiel1a():void {
			clearOutput();
			outputText("You turn in the quest and Yang nods in appreciation. She verifies the imp, it literally trying to claw at her face before she close the bag again.\n\n");
			outputText("\"<i>Looks feral, good job there. The imp will be delivered to the researcher's address and she will study it in order to perhaps develop a cure. As for you, I think you earned your reward. By the way this imp is clearly a female, this is a rare find. If you hand it to us we will increase your reward accordingly. That is… unless you want to keep her?</i>\"\n\n");
			menu();
			addButton(1, "Don't want", BoardkeeperYangQuestEzekiel1NoWant);
			addButton(3, "Keep", BoardkeeperYangQuestEzekiel1Keep);
		}
		public function BoardkeeperYangQuestEzekiel1NoWant():void {
			outputText("You turn in the quest and Yang nods in appreciation. She verifies the imp, it literally trying to claw at her face before she close the bag again.\n\n");
			outputText("\"<i>Looks feral, good job there. The imp will be delivered to the researchers address and she will study it in order to perhaps develop a cure. As for you, I think you earned your reward.</i>\"\n\n");
			outputText("(<b>Gained 22 Spirit Stones</b>)");
			flags[kFLAGS.GALIA_LVL_UP] = 0.53;
			flags[kFLAGS.GALIA_AFFECTION] = 0;
			flags[kFLAGS.SPIRIT_STONES] += 22;
			statScreenRefresh();
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangQuestEzekiel1Keep():void {
			outputText("She sighs in disappointment before grabbing the female imp by the neck, putting her in an harness and handing her back to you fully hogtied.\n\n");
			outputText("\"<i>Guess there is no helping it then. Make sure she does not cause trouble.</i>\"\n\n");
			doNext(SceneLib.galiaFollower.bringBackTheFemImp);
		}
		/*
		public function BoardkeeperYangQuestEzekiel2():void {
			clearOutput();
			outputText("Placeholder for lazyLia writing ^^\n\n");//feral tentacle beasts capture
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangQuestFerals3():void {
			clearOutput();
			outputText("Placeholder for lazyLia writing ^^\n\n");//feral demons hunt
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangQuestGolems():void {
			clearOutput();//golem harvesting quest
			outputText("Placeholder for lazyLia writing ^^\n\n");
			outputText("Placeholder for lazyLia writing ^^\n\n");
			outputText("Placeholder for lazyLia writing ^^\n\n");
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangQuest2():void {
			clearOutput();
			outputText("Placeholder for lazyLia writing ^^\n\n");
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangQuest1():void {
			clearOutput();
			outputText("Placeholder for lazyLia writing ^^\n\n");
			doNext(BoardkeeperYangQuest);
		}
		*/
		public function BoardkeeperYangGolemRetrievalJob():void {
			clearOutput();
			if (flags[kFLAGS.AURORA_LVL] == 0.3) {
				outputText("You ask Yang if it would be possible for you to post a job. You happen to have a chained golem you want retrieved from the hidden cave and brought up back to your camp.\n\n");
				outputText("Yang nods \"<i>Yeah, sure we can do that. Just write a full job description and I will post it on the board. It will cost 10 spirit stones.</i>\"\n\n");
				if (flags[kFLAGS.SPIRIT_STONES] < 10) {
					outputText("You tell her you’ll be back with the stones the moment you have them.\n\n");
					doNext(SceneLib.journeyToTheEast.enteringInn,false);
				}
				else {
					menu();
					addButton(0, "Maybe later", BoardkeeperYangGolemRetrievalJob1);
					addButton(1, "Post the Req", BoardkeeperYangGolemRetrievalJob2);
				}
			}
			else SceneLib.auroraFollower.putInTheJadeTalismanEpilogue();
		}
		public function BoardkeeperYangGolemRetrievalJob1():void {
			outputText("You tell Yang you will come back later to post the request.\n\n");
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangGolemRetrievalJob2():void {
			outputText("Yang waits for you arms crossed. You write a full job description and hand it over to Yang along with the stones. This done, she then posts it on the board as an iron plate request.\n\n");
			flags[kFLAGS.SPIRIT_STONES] -= 10;
			flags[kFLAGS.AURORA_LVL] = 0.35;
			statScreenRefresh();
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangTalk():void {
			clearOutput();
			outputText("Yang waits for you arms crossed.\n\n");
			outputText("\"<i>Here to talk or something else?</i>\"");
			menu();
			addButton(0, "Her Job", BoardkeeperYangTalkHerJob);
			//addButton(1, "He'Xin'Dao", BoardkeeperYangTalkHeXinDao);
			addButton(2, "Requests", BoardkeeperYangTalkRequests);
			addButton(3, "Others", BoardkeeperYangTalkOthers);
			addButton(4, "Back", BoardkeeperYangMain);
		}
		public function BoardkeeperYangTalkHerJob():void {
			clearOutput();
			outputText("What’s her job exactly? Is she an adventurer herself?\n\n");
			outputText("\"<i>Me? No dear no I’m just the guild poster girl. I’m actually paid to stand there. That said there’s a few perk to it as I get to meet some of Mareth’s biggest badass face to face and sometime closer, if you catch my drift.</i>\"\n\n");
			doNext(BoardkeeperYangTalk);
		}
		/*
		public function BoardkeeperYangTalkHeXinDao():void {
			clearOutput();
			outputText("Placeholder for lazyLia writing ^^\n\n");
			doNext(BoardkeeperYangTalk);
		}
		*/
		public function BoardkeeperYangTalkRequests():void {
			clearOutput();
			outputText("Ok, you are a member now, how do you take on a job?\n\n");
			outputText("\"<i>First and foremost you come to me or any other board on mareth if you can find one. Then you choose a difficulty and I set you on a corresponding request.</i>\"\n\n");
			outputText("Difficulty? You thought you could pick on the highest request right away.\n\n");
			outputText("\"<i>No such thing " + player.mf("Mr.", "Mrs.") + " Hero. The guild has strict ruling to prevent people throwing their lives away on job they can’t handle. We have a difficulty system based on skill and rank. You cannot take on a request way above your ranking until you have qualified for it. The rank are determined by copper, bronze, silver, gold and platinum plates.</i>\"\n\n");
			doNext(BoardkeeperYangTalk);
		}
		public function BoardkeeperYangTalkOthers():void {
			clearOutput();
			outputText("If there is a guild there are bound to be many adventurers, who are they?\n\n");
			outputText("\"<i>Well now that you ask yes there are a few local adventurers however most of them aren’t worthy of mention. That said one stands out, her name is Chi Chi and she regularly go out on request involving battling the corrupt forces. One hell of a fighter to, I heard she is a veteran of the town arena.");
			if (flags[kFLAGS.CHI_CHI_AFFECTION] < 10) outputText(" If you want to get in on that action you may want to enlist in the arena gauntlet challenges to draw her attention.");
			outputText("</i>\"\n\n");
			doNext(BoardkeeperYangTalk);
		}
		public function BoardkeeperYangSex():void {
			clearOutput();
			outputText("She giggle before teasingly puffing her chest up, which only shows more cleavage than necessary.\n\n");
			outputText("\"<i>Well that’s cute " + player.mf("Mr.", "Mrs.") + " Hero but I don’t go for a ride with just anyone who ask. Complete at least a silver request for the guild and I will give you a shot.</i>\"");
			doNext(BoardkeeperYangMain);
		}
		public function BoardkeeperYangPromotion():void {
			clearOutput();
			if (player.keyItemvX("Adventurer Guild: Copper plate", 1) > 1) {
				if (flags[kFLAGS.SPIRIT_STONES] >= 10) {
					outputText("Yang nods, \"<i>Yep, it’s definitely time we promoted you. You pass from Copper plate to Iron, congratulations!</i>\"\n\n");
					outputText("She hands you a new necklace, which you proceed to don up.\n\n");
					player.removeKeyItem("Adventurer Guild: Copper plate");
					player.createKeyItem("Adventurer Guild: Iron plate", 0, 0, 0, 0);
					flags[kFLAGS.SPIRIT_STONES] -= 10;
					unlockSlotsForRank(RANK_IRON, 10);
				}
				else {
					outputText("Yeah sure, you will get promoted. Or rather, you would like to but you lack the required spirit stones for the promotion fee.\n\n");
					outputText("\"<i>Its ok just go to Moga Hen, he should be able to exchange those gem of yours for the local currency.</i>\"");
				}
			}
			if (player.keyItemvX("Adventurer Guild: Iron plate", 1) > 1) {
				if (flags[kFLAGS.SPIRIT_STONES] >= 15) {
					outputText("Yang nods. \"<i>Yep it’s definitely time we promoted hou. You pass from Iron plate to Bronze, congratulations!</i>\"\n\n");
					outputText("She hand you a new necklace, which you proceed to don up.\n\n");
					player.removeKeyItem("Adventurer Guild: Iron plate");
					player.createKeyItem("Adventurer Guild: Bronze plate", 0, 0, 0, 0);
					flags[kFLAGS.SPIRIT_STONES] -= 15;
					unlockSlotsForRank(RANK_IRON, 10);
				}
				else {
					outputText("Yeah sure, you will get promoted. Or rather you would like to but you lack the required spirit stones for the promotion fee.\n\n");
					outputText("\"<i>Its ok just go to Moga Hen, he should be able to exchange those gem of yours for the local currency.</i>\"");
				}
			}
			doNext(BoardkeeperYangMain);
		}

		public function questItemsBag(page:int = 0):void {
			clearOutput();
			outputText("Would you like to put some quest items into the bag, and if so, with ones?\n\n");
			// TODO @aimozg item transfer menu?
			var bdl:ButtonDataList = new ButtonDataList();
			for (var i:int = 0; i < lootBag.SlotCount; i++) {
				if (lootBag.SlotCaps[i] > 0) {
					var itemType:ItemType = lootBag.itemTypes[i];
					outputText("<b>"+itemType.shortName+":</b> "+lootBag.Slots[i] + " / "+lootBag.SlotCaps[i]+"\n");
					
					bdl.add("Store "+itemType.shortName, curry(storeItem, i, itemType))
							.disableIf(!player.hasItem(itemType) || lootBag.Slots[i] >= lootBag.SlotCaps[i]);
					bdl.add("Take "+itemType.shortName, curry(takeItem, i, itemType))
							.disableIf(lootBag.Slots[i] == 0);
				}
			}
			menu();
			submenu(bdl, camp.campActions, page, false);
		}
		private function storeItem(slot:int, itemType:ItemType):void {
			player.destroyItems(itemType, 1);
			lootBag.Slots[slot]++;
			questItemsBag(submenuPage);
		}
		public function takeItem(slot:int, itemType:ItemType):void {
			lootBag.Slots[slot]--;
			outputText("\n");
			inventory.takeItem(itemType, questItemsBag);
		}
	}
}
