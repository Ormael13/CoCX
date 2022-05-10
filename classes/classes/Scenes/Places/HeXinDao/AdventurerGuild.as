/**
 * ...
 * @author Ormael and others
 */
package classes.Scenes.Places.HeXinDao 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	import classes.internals.SaveableState;
	
	public class AdventurerGuild extends HeXinDaoAbstractContent implements SaveableState
	{
		public static var Slot01:Number;
		public static var Slot01Cap:Number;//imp skulls
		public static var Slot02:Number;
		public static var Slot02Cap:Number;//feral imp skulls
		//Copper plate
		public static var Slot03:Number;
		public static var Slot03Cap:Number;//minotaur horns
		public static var Slot04:Number;
		public static var Slot04Cap:Number;//demon skulls
		//Iron plate
		public static var Slot05:Number;
		public static var Slot05Cap:Number;//feral tentacle beasts
		public static var Slot06:Number;
		public static var Slot06Cap:Number;
		//Bronze plate
		public static var Slot07:Number;
		public static var Slot07Cap:Number;
		public static var Slot08:Number;
		public static var Slot08Cap:Number;
		public static var Slot09:Number;
		public static var Slot09Cap:Number;
		//Silver plate
		public static var Slot10:Number;
		public static var Slot10Cap:Number;
		public static var Slot11:Number;
		public static var Slot11Cap:Number;
		public static var Slot12:Number;
		public static var Slot12Cap:Number;
		//Gold plate
		public static var Slot13:Number;
		public static var Slot13Cap:Number;
		public static var Slot14:Number;
		public static var Slot14Cap:Number;
		public static var Slot15:Number;
		public static var Slot15Cap:Number;
		public static var Slot16:Number;
		public static var Slot16Cap:Number;
		//Platinum plate
		public static var Slot17:Number;
		public static var Slot17Cap:Number;
		public static var Slot18:Number;
		public static var Slot18Cap:Number;
		public static var Slot19:Number;
		public static var Slot19Cap:Number;
		public static var Slot20:Number;
		public static var Slot20Cap:Number;
		//Mithril plate
		public static var Slot21:Number;
		public static var Slot21Cap:Number;
		public static var Slot22:Number;
		public static var Slot22Cap:Number;
		public static var Slot23:Number;
		public static var Slot23Cap:Number;
		public static var Slot24:Number;
		public static var Slot24Cap:Number;
		public static var Slot25:Number;
		public static var Slot25Cap:Number;
		//Orichalcum plate
		public static var Slot26:Number;
		public static var Slot26Cap:Number;
		public static var Slot27:Number;
		public static var Slot27Cap:Number;
		public static var Slot28:Number;
		public static var Slot28Cap:Number;
		public static var Slot29:Number;
		public static var Slot29Cap:Number;
		public static var Slot30:Number;
		public static var Slot30Cap:Number;
		//Adamantite plate

		public function stateObjectName():String {
			return "AdventurerGuild";
		}

		public function resetState():void {
			Slot01 = 0;
			Slot01Cap = 0;
			Slot02 = 0;
			Slot02Cap = 0;
			Slot03 = 0;
			Slot03Cap = 0;
			Slot04 = 0;
			Slot04Cap = 0;
			Slot05 = 0;
			Slot05Cap = 0;
			Slot06 = 0;
			Slot06Cap = 0;
			Slot07 = 0;
			Slot07Cap = 0;
			Slot08 = 0;
			Slot08Cap = 0;
			Slot09 = 0;
			Slot09Cap = 0;
			Slot10 = 0;
			Slot10Cap = 0;
			Slot11 = 0;
			Slot11Cap = 0;
			Slot12 = 0;
			Slot12Cap = 0;
			Slot13 = 0;
			Slot13Cap = 0;
			Slot14 = 0;
			Slot14Cap = 0;
			Slot15 = 0;
			Slot15Cap = 0;
			Slot16 = 0;
			Slot16Cap = 0;
			Slot17 = 0;
			Slot17Cap = 0;
			Slot18 = 0;
			Slot18Cap = 0;
			Slot19 = 0;
			Slot19Cap = 0;
			Slot20 = 0;
			Slot20Cap = 0;
			Slot21 = 0;
			Slot21Cap = 0;
			Slot22 = 0;
			Slot22Cap = 0;
			Slot23 = 0;
			Slot23Cap = 0;
			Slot24 = 0;
			Slot24Cap = 0;
			Slot25 = 0;
			Slot25Cap = 0;
			Slot26 = 0;
			Slot26Cap = 0;
			Slot27 = 0;
			Slot27Cap = 0;
			Slot28 = 0;
			Slot28Cap = 0;
			Slot29 = 0;
			Slot29Cap = 0;
			Slot30 = 0;
			Slot30Cap = 0;
		}

		public function saveToObject():Object {
			return {
				"Slot01": Slot01,
				"Slot01Cap": Slot01Cap,
				"Slot02": Slot02,
				"Slot02Cap": Slot02Cap,
				"Slot03": Slot03,
				"Slot03Cap": Slot03Cap,
				"Slot04": Slot04,
				"Slot04Cap": Slot04Cap,
				"Slot05": Slot05,
				"Slot05Cap": Slot05Cap,
				"Slot06": Slot06,
				"Slot06Cap": Slot06Cap,
				"Slot07": Slot07,
				"Slot07Cap": Slot07Cap,
				"Slot08": Slot08,
				"Slot08Cap": Slot08Cap,
				"Slot09": Slot09,
				"Slot09Cap": Slot09Cap,
				"Slot10": Slot10,
				"Slot10Cap": Slot10Cap,
				"Slot11": Slot11,
				"Slot11Cap": Slot11Cap,
				"Slot12": Slot12,
				"Slot12Cap": Slot12Cap,
				"Slot13": Slot13,
				"Slot13Cap": Slot13Cap,
				"Slot14": Slot14,
				"Slot14Cap": Slot14Cap,
				"Slot15": Slot15,
				"Slot15Cap": Slot15Cap,
				"Slot16": Slot16,
				"Slot16Cap": Slot16Cap,
				"Slot17": Slot17,
				"Slot17Cap": Slot17Cap,
				"Slot18": Slot18,
				"Slot18Cap": Slot18Cap,
				"Slot19": Slot19,
				"Slot19Cap": Slot19Cap,
				"Slot20": Slot20,
				"Slot20Cap": Slot20Cap,
				"Slot21": Slot21,
				"Slot21Cap": Slot21Cap,
				"Slot22": Slot22,
				"Slot22Cap": Slot22Cap,
				"Slot23": Slot23,
				"Slot23Cap": Slot23Cap,
				"Slot24": Slot24,
				"Slot24Cap": Slot24Cap,
				"Slot25": Slot25,
				"Slot25Cap": Slot25Cap,
				"Slot26": Slot26,
				"Slot26Cap": Slot26Cap,
				"Slot27": Slot27,
				"Slot27Cap": Slot27Cap,
				"Slot28": Slot28,
				"Slot28Cap": Slot28Cap,
				"Slot29": Slot29,
				"Slot29Cap": Slot29Cap,
				"Slot30": Slot30,
				"Slot30Cap": Slot30Cap
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				Slot01 = o["Slot01"];
				Slot01Cap = o["Slot01Cap"];
				Slot02 = o["Slot02"];
				Slot02Cap = o["Slot02Cap"];
				Slot03 = o["Slot03"];
				Slot03Cap = o["Slot03Cap"];
				Slot04 = o["Slot04"];
				Slot04Cap = o["Slot04Cap"];
				Slot05 = o["Slot05"];
				Slot05Cap = o["Slot05Cap"];
				Slot06 = o["Slot06"];
				Slot06Cap = o["Slot06Cap"];
				Slot07 = o["Slot07"];
				Slot07Cap = o["Slot07Cap"];
				Slot08 = o["Slot08"];
				Slot08Cap = o["Slot08Cap"];
				Slot09 = o["Slot09"];
				Slot09Cap = o["Slot09Cap"];
				Slot10 = o["Slot10"];
				Slot10Cap = o["Slot10Cap"];
				Slot11 = o["Slot11"];
				Slot11Cap = o["Slot11Cap"];
				Slot12 = o["Slot12"];
				Slot12Cap = o["Slot12Cap"];
				Slot13 = o["Slot13"];
				Slot13Cap = o["Slot13Cap"];
				Slot14 = o["Slot14"];
				Slot14Cap = o["Slot14Cap"];
				Slot15 = o["Slot15"];
				Slot15Cap = o["Slot15Cap"];
				Slot16 = o["Slot16"];
				Slot16Cap = o["Slot16Cap"];
				Slot17 = o["Slot17"];
				Slot17Cap = o["Slot17Cap"];
				Slot18 = o["Slot18"];
				Slot18Cap = o["Slot18Cap"];
				Slot19 = o["Slot19"];
				Slot19Cap = o["Slot19Cap"];
				Slot20 = o["Slot20"];
				Slot20Cap = o["Slot20Cap"];
				Slot21 = o["Slot21"];
				Slot21Cap = o["Slot21Cap"];
				Slot22 = o["Slot22"];
				Slot22Cap = o["Slot22Cap"];
				Slot23 = o["Slot23"];
				Slot23Cap = o["Slot23Cap"];
				Slot24 = o["Slot24"];
				Slot24Cap = o["Slot24Cap"];
				Slot25 = o["Slot25"];
				Slot25Cap = o["Slot25Cap"];
				Slot26 = o["Slot26"];
				Slot26Cap = o["Slot26Cap"];
				Slot27 = o["Slot27"];
				Slot27Cap = o["Slot27Cap"];
				Slot28 = o["Slot28"];
				Slot28Cap = o["Slot28Cap"];
				Slot29 = o["Slot29"];
				Slot29Cap = o["Slot29Cap"];
				Slot30 = o["Slot30"];
				Slot30Cap = o["Slot30Cap"];
			} else {
				// loading from old save
				resetState();
			}
		}

		public function AdventurerGuild() 
		{
			Saves.registerSaveableState(this);
		}
		
		public function BoardkeeperYangMain():void {
			clearOutput();
			if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0 || player.hasKeyItem("Adventurer Guild: Iron plate") >= 0) {// || player.hasKeyItem("Adventurer Guild: Bronze plate") >= 0 || player.hasKeyItem("Adventurer Guild: Silver plate") >= 0 || player.hasKeyItem("Adventurer Guild: Gold plate") >= 0 || player.hasKeyItem("Adventurer Guild: Platinum plate") >= 0
				// || player.hasKeyItem("Adventurer Guild: Mithril plate") >= 0|| player.hasKeyItem("Adventurer Guild: Orichalcum plate") >= 0 || player.hasKeyItem("Adventurer Guild: Adamantite plate") >= 0
				outputText("Yang the handler looks at you, her arms crossed in front of her chest. She taps her foot impatiently. Has she been here all day?\n\n");
				outputText("\"<i>So [name], how can I help you today? Here to talk jobs or something else?</i>\"");
				if (player.hasKeyItem("Adventurer Guild: Iron plate") >= 0 && Slot05Cap < 10) Slot05Cap = 10;
				menu();
				addButton(0, "Quest", BoardkeeperYangQuest);
				addButton(1, "Talk", BoardkeeperYangTalk);
				if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0)
                    addButton(2, "Promotion", BoardkeeperYangPromotion).hint("Ask Yang for a promotion once you have completed enough jobs.");
                else if (player.hasKeyItem("Adventurer Guild: Iron plate") >= 0)
                    addButtonDisabled(2, "Promotion", "Max level (NYI)");
				else addButtonDisabled(2, "Promotion", "Not meet req.");
				//addButton(3, "Sex", BoardkeeperYangSex);
                addButtonDisabled(3, "Sex", "NYI");
				addButton(4, "Back", curry(SceneLib.journeyToTheEast.enteringInn, false));
				if (flags[kFLAGS.AURORA_LVL] == 0.3 || (flags[kFLAGS.AURORA_LVL] >= 0.6 && flags[kFLAGS.AURORA_LVL] < 0.75)) addButton(5, "GRJ", BoardkeeperYangGolemRetrievalJob).hint("Golem retrieval job");
			}
			else {
				outputText("You approach the board covered in colorful papers. The panda girl next to it sees you, walking over and giving you a winning smile.\n\n");
				outputText("\"<i>Well, hello there! Are you looking for a job? I represent the adventurer's guild. We could always use more able bodied men and women like you.</i>\"\n\n");
				outputText("An adventurer guild? What's the benefits?\n\n");
				outputText("\"<i>Mareth is both filled with perils, lost treasures and people in need of heroic assistance. By paying a small membership fee I can let you in on local events that could use your assistance and give you pointers to unplundered ruins. It’s only 5 spirit stones to join. Fame and treasure? All within your reach to grab.</i>\"");
				menu();
				addButton(0, "Decline", No);
				addButton(1, "Join", Yes);
			}
		}
		private function No():void {
			clearOutput();
			outputText("You aren’t interested into dungeon delving right now. Your regular activities are more than enough to keep you busy.");
			doNext(curry(SceneLib.journeyToTheEast.enteringInn,false));
		}
		private function Yes():void{
			clearOutput();
			if (flags[kFLAGS.SPIRIT_STONES] < 5) {
				outputText("This sounds like a good idea, and you nod, pulling out your money pouch. As you look inside, however, you realise that you don't have enough Spirit Stones.\n\n");
				outputText("\"<i>Its ok just go to Moga Hen, he should be able to exchange those gems of yours for the local currency.</i>\"");
				doNext(curry(SceneLib.journeyToTheEast.enteringInn,false));
			}
			else {
				outputText("Yeah sure, this sounds promising. You handle the ursine woman the spirit stones and sign the papers.\n\n");
				outputText("\"<i>Perfect, Just perfect. Let me hand you over your badge.</i>\"\n\n");
				outputText("She picks up a small Copper colored plate and give it to you.\n\n");
				outputText("\"<i>Well, now you are officially a member of the adventurer's guild. Whenever you are ready, ask for a quest. From there, I will direct you to your target.</i>\"\n\n");
				flags[kFLAGS.SPIRIT_STONES] -= 5;
				statScreenRefresh();
				player.createKeyItem("Adventurer Guild: Copper plate", 0, 0, 0, 0);
				Slot01Cap = 10;
				Slot02Cap = 10;
				doNext(BoardkeeperYangMain);
			}
		}
		public function BoardkeeperYangQuest():void {
			clearOutput();
			outputText("The panda girl nods, stepping aside as you view the board.\n\n");
			outputText("\"<i>There are a number of quests available. Which one will you take?</i>\"\n\n");
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
					outputText("The panda shakes her head.\n\n");
					outputText("\"<i>Sorry [name] this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 6) {
					if (player.hasItem(useables.IMPSKLL, 5) || Slot01 >= 5) {
						outputText("Yang examine the skulls to make sure those are imps then nods, counting out the spirit stones and handing them over.\n\n");
						outputText("\"<i>Good job [name], here is your payment.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 1);
						if (Slot01 >= 5) Slot01 -= 5;
						else player.destroyItems(useables.IMPSKLL, 5);
						flags[kFLAGS.SPIRIT_STONES] += 7;
						statScreenRefresh();
					}
					else {
						outputText("The panda tap her foot on the ground.\n\n");
						outputText("\"<i>Were my instructions not clear enough for you? The bounty require 5 imps skulls, [name]. Get back to hunting.</i>\"\n\n");
					}
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 4) {
					outputText("Yang eyes you with keen interest then ask.\n\n");
					outputText("\"<i>Would you be interested into something easier? Right now there's a bounty on imp slaying. Bring me back 5 imp skulls and I will see it through that you are properly rewarded.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 2);
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 3) {
					if (player.hasItem(useables.IMPSKLL, 4) || Slot01 >= 4) {
						outputText("Yang examines the skulls to make sure those are imps. She turns each one over a few times, then gives you a nod, counting out the stones and giving you your payment.\n\n");
						outputText("\"<i>Good job [name] here is your payment. </i>\" She brings a small scroll out, handing it to you as well. \"<i> This is for you. A scroll that'll help teach you some useful skills</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 1);
						if (Slot01 >= 4) Slot01 -= 4;
						else player.destroyItems(useables.IMPSKLL, 4);
						player.perkPoints += 1;
					}
					else {
						outputText("The panda tap her foot on the ground.\n\n");
						outputText("\"<i>I thought I had been clear, the bounty require 4 imp skulls [name]. Get back to hunting.</i>\"\n\n");
					}
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 2) {
					outputText("Yang eyes you with keen interest then ask.\n\n");
					outputText("\"<i>Would you actually be interested into something easier? Right now there's a bounty on imp slaying. Bring me back 4 imp skulls and I will see it through that you are properly rewarded.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 1);
				}
				else {
					if (player.hasItem(useables.IMPSKLL, 3) || Slot01 >= 3) {
						outputText("Yang examine the skulls to make sure those are imps then nods giving you your payment.\n\n");
						outputText("\"<i>Good job [name] here is your payment. Also, since you're moving up a bit, I can give you this.</i>\" She hands you a small amulet. \"<i> This neat little thing can sense corruption. When you're wearing it, you can as well. It's realy handy against demons. </i>\"\n\n");
						outputText("(<b>Acquired demon hunter amulet!</b>)\n\n");
						outputText("(<b>Gained New Perk: Sense Corruption</b>)");
						if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0) player.addKeyValue("Adventurer Guild: Copper plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 1);
						player.createKeyItem("Demon Hunter Amulet", 0, 0, 0, 0);
						player.createPerk(PerkLib.SenseCorruption, 0, 0, 0, 0);
						if (Slot01 >= 3) Slot01 -= 3;
						else player.destroyItems(useables.IMPSKLL, 3);
					}
					else {
						outputText("The panda tap her foot on the ground.\n\n");
						outputText("\"<i>I thought I had been clear, the bounty require 3 imp skulls [name]. Get back to hunting.</i>\"\n\n");
					}
				}
			}
			else {
				outputText("Yang eyes you with interest before opening her mouth to speak.\n\n");
				outputText("\"<i>Would you be interested into something easier? Right now there's a bounty on imp slaying. Bring me back 3 imp skulls and I will see it through that you are properly rewarded.</i>\"\n\n");
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
					outputText("The panda decline the job request.\n\n");
					outputText("\"<i>Sorry [name] this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 6) {
					if (player.hasItem(useables.SEVTENT, 3) || Slot05 >= 3) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>Good job there. I hope those plants did not prove to much trouble. Here is your payment.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 1);
						if (Slot05 >= 3) Slot05 -= 3;
						else player.destroyItems(useables.SEVTENT, 3);
						flags[kFLAGS.SPIRIT_STONES] += 8;
						statScreenRefresh();
					}
					else outputText("You try turn in the quest but Yang tells you you don’t have enough tentacles yet.\n\n");
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 4) {
					outputText("\"<i>Someone put up a bounty for slaying tentacle beast. I would need lets say 3 tentacle from those mishapen creature as proof of your deed. Of course you will be rewarded for the job.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 2);
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 3) {
					if (player.hasItem(useables.SEVTENT, 2) || Slot05 >= 2) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>Good job [name] here is your payment. along with a special training scroll.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 1);
						if (Slot05 >= 2) Slot05 -= 2;
						else player.destroyItems(useables.SEVTENT, 2);
						player.perkPoints += 1;
					}
					else outputText("You try turn in the quest, but Yang shakes her head. \"<i>You don't have enough tentacles, [name]. Why are you trying to turn this in? </i>\"\n\n");
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 2) {
					outputText("\"<i>Someone put up a bounty for slaying tentacle beast. I would need lets say 2 tentacle from those mishapen creature as proof of your deed. Of course you will be rewarded for the job.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 1);
				}
				else {
					if (player.hasItem(useables.SEVTENT, 1) || Slot05 >= 1) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>My my, I wasn’t sure I would ever see you back.</i>\"\n\n");
						outputText("Seems she misjudged you then?\n\n");
						outputText("\"<i>Everyone makes mistakes and plants assignments are way more dangerous than imps, you clearly outpaced expectation. Here is your payment. This reminds me some man told me to leave you this scroll as a reward too... should help you sense the anger of your opponents he said.</i>\"\n\n");
						outputText("(<b>Gained New Perk: Sense Wrath</b>)");
						if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0) player.addKeyValue("Adventurer Guild: Copper plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 1);
						player.createPerk(PerkLib.SenseWrath, 0, 0, 0, 0);
						if (Slot05 >= 1) Slot05 -= 1;
						else player.destroyItems(useables.SEVTENT, 1);
					}
					else outputText("You try turn in the quest but Yang tells you you don’t have enough tentacles yet.\n\n");
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
					outputText("The panda decline the job request.\n\n");
					outputText("\"<i>Sorry [name] this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 6) {
					if (player.hasItem(useables.DEMSKLL, 3) || Slot04 >= 3) {
						outputText("You turn in the quest and Yang nod.\n\n");
						outputText("\"<i>Good job as usual here is your payment.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 2, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, 1);
						if (Slot04 >= 3) Slot04 -= 3;
						else player.destroyItems(useables.DEMSKLL, 3);
						flags[kFLAGS.SPIRIT_STONES] += 8;
						statScreenRefresh();
					}
					else {
						outputText("The panda tap her foot on the ground.\n\n");
						outputText("\"<i>I thought I had been clear the bounty require 3 demon skulls [name]. Get back to hunting.</i>\"\n\n");
					}
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 4) {
					outputText("\"<i>Hey [name] happen I have a new higher grade job for you if you’re interested.</i>\"\n\n");
					outputText("Of course your interested what’s the job?\n\n");
					outputText("\"<i>See it happens the town offer a generous sum for every demon slain. If you can bring me proof of the death of 3 demons.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, 2);
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 3) {
					if (player.hasItem(useables.DEMSKLL, 2) || Slot04 >= 2) {
						outputText("You turn in the quest and Yang nod.\n\n");
						outputText("\"<i>Good job [name] here is your payment along with a special training scroll.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 2, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, 1);
						if (Slot04 >= 3) Slot04 -= 2;
						else player.destroyItems(useables.DEMSKLL, 2);
						player.perkPoints += 1;
					}
					else {
						outputText("The panda tap her foot on the ground.\n\n");
						outputText("\"<i>I thought I had been clear the bounty require 2 demon skulls [name]. Get back to hunting.</i>\"\n\n");
					}
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 2) {
					outputText("\"<i>Hey [name] happen I have a new higher grade job for you if you’re interested.</i>\"\n\n");
					outputText("Of course your interested what’s the job?\n\n");
					outputText("\"<i>See it happens the town offer a generous sum for every demon slain. If you can bring me proof of the death of 2 demons.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, 1);
				}
				else {
					if (player.hasItem(useables.DEMSKLL, 1) || Slot04 >= 1) {
						outputText("You display the proof of your victory.\n\n");
						outputText("\"<i>Nice job [name] so about that special reward, it happens a traveling demon hunter has agreed to train whoever would kill demons in the art of slaying. Chika would you please come over? [name] cleared your bounty.</i>\"\n\n");
						outputText("Chika which appears to be a rattel morph with an eyepatch. Rattel, or honey badgers, are known for their ferocity and the set of throwing dagger and poison flasks hanging from her belt, the pair of scimitar on her side and the crossbow on her back tells everything you need about her, ");
						outputText("she's clearly an expert killer. Chika gaze goes through you and the inflexibility and sternness of it leaves you somewhat intimidated.\n\n");
						outputText("\"<i>Doesn’t look like much... Ye sure " + player.mf("he", "she") + " smoked the targets?</i>\"\n\n");
						outputText("Yang goes by the affirmative.\n\n");
						outputText("\"<i>Ye and I are going to have a lot of dealings in the future. But first I want ya to follow me out in the town training area. I have a few things I would like to teach ye.</i>\"\n\n");
						outputText("You spend the four next hour with the rattel morph learning new demon killing tricks. By the end of your training you have accumulated a good bank of knowledge on demon weak points and how to exploit them. Chika leaves by the end warning that you and her will eventually meet again.\n\n");
						outputText("(<b>Gained New Perk: Demon Slayer</b>)");
						if (player.hasKeyItem("Adventurer Guild: Iron plate") >= 0) player.addKeyValue("Adventurer Guild: Iron plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 2, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, 1);
						player.createPerk(PerkLib.DemonSlayer, 0.1, 0, 0, 0);
						if (Slot04 >= 3) Slot04 -= 1;
						else player.destroyItems(useables.DEMSKLL, 1);
					}
					else {
						outputText("The panda tap her foot on the ground.\n\n");
						outputText("\"<i>I thought I had been clear the bounty require 1 demon skull [name]. Get back to hunting.</i>\"\n\n");
					}
				}
			}
			else {
				outputText("\"<i>Hey [name] happen I have a new higher grade job for you if you’re interested.</i>\"\n\n");
				outputText("Of course your interested what’s the job?\n\n");
				outputText("\"<i>See it happens the town offer a generous sum for every demon slain. If you can bring me proof of the death of demon. Should you come back I have a special reward for you in addition to your pay.</i>\"\n\n");
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
					outputText("The panda decline the job request.\n\n");
					outputText("\"<i>Sorry [name] this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 6) {
					if (player.hasItem(useables.FIMPSKL, 5) || Slot02 >= 5) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>Good job there. I heard those creatures are actually out there killing instead of raping, it’s quite chilling. Here is your payment.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 2, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 1);
						if (Slot02 >= 5) Slot02 -= 5;
						else player.destroyItems(useables.FIMPSKL, 5);
						flags[kFLAGS.SPIRIT_STONES] += 7;
						statScreenRefresh();
					}
					else outputText("You try turn in the quest but Yang tells you you don’t have enough feral imp skulls yet.\n\n");
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 4) {
					outputText("\"<i>Someone put up a bounty for slaying feral imps. I would need lets say 5 feral imps skulls from those mishapen creature as proof of your deed. Of course you will be rewarded for the job.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 2);
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 3) {
					if (player.hasItem(useables.FIMPSKL, 4) || Slot02 >= 4) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>Good job there. I heard those creatures are actually out there killing instead of raping, it’s quite chilling. Here is your payment along with a special training scroll.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 2, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 1);
						if (Slot02 >= 4) Slot02 -= 4;
						else player.destroyItems(useables.FIMPSKL, 4);
						player.perkPoints += 1;
					}
					else outputText("You try turn in the quest but Yang tells you you don’t have enough feral imp skulls yet.\n\n");
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 2) {
					outputText("\"<i>Someone put up a bounty for slaying feral imps. I would need lets say 4 feral imps skulls from those mishapen creature as proof of your deed. Of course you will be rewarded for the job.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 1);
				}
				else {
					if (player.hasItem(useables.FIMPSKL, 3) || Slot02 >= 3) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>My my, I wasn’t sure I would ever see you back.</i>\"\n\n");
						outputText("Seems she misjudged you then?\n\n");
						outputText("\"<i>Everyone makes mistakes and feral imps assignments are way more dangerous than normal imps, you clearly outpaced expectation. Here is your payment. This reminds me some man told me to leave you this scroll as a reward too... should help you fight feral opponents he said.</i>\"\n\n");
						outputText("(<b>Gained New Perk: Feral Hunter</b>)");
						if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0) player.addKeyValue("Adventurer Guild: Copper plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 2, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 1);
						player.createPerk(PerkLib.FeralHunter, 0.1, 0, 0, 0);
						if (Slot02 >= 3) Slot02 -= 3;
						else player.destroyItems(useables.FIMPSKL, 3);
					}
					else outputText("You try turn in the quest but Yang tells you you don’t have enough feral imp skulls yet.\n\n");
				}
			}
			else {
				outputText("\"<i>Someone put up a bounty for slaying feral imps. I would need lets say 3 feral imps skulls from those mishapen creature as proof of your deed. Of course you will be rewarded for the job.</i>\"\n\n");
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
					outputText("The panda decline the job request.\n\n");
					outputText("\"<i>Sorry [name] this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 6) {
					if (player.hasItem(useables.MINOHOR, 4) || Slot03 >= 4) {
						outputText("Yang count the horns then smile.\n\n");
						outputText("\"<i>Well you did bag four out of four nice job. The guild asked me to pay you this reward money as usual for slaying bulls. Do come and find me later on for a new job, or for something else...</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 3, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 1);
						if (Slot03 >= 4) Slot03 -= 4;
						else player.destroyItems(useables.MINOHOR, 4);
						flags[kFLAGS.SPIRIT_STONES] += 8;
						statScreenRefresh();
					}
					else outputText("\"<i>Hey [name], I counted those horns and clearly you forgot a few. Get out there and bring me the remaining ones.</i>\"\n\n");
				}
				else if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 4) {
					outputText("\"<i>Oh so you wanna go out and hunt some extra minotaurs? Good! You make sure to kill four or as many as you can so we can breath fresh air safe from minotaur musk, got it?</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 2);
				}
				else if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 3) {
					if (player.hasItem(useables.MINOHOR, 3) || Slot03 >= 3) {
						outputText("Yang count the horns then smile.\n\n");
						outputText("\"<i>Well you did bag three out of three nice job. The guild asked me to pay you with this special training scroll for slaying bulls. Do come and find me later on for a new job, or for something else...</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 3, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 1);
						if (Slot03 >= 3) Slot03 -= 3;
						else player.destroyItems(useables.MINOHOR, 3);
						player.perkPoints += 1;
					}
					else outputText("\"<i>Hey [name], I counted those horns and clearly you forgot a few. Get out there and bring me the remaining ones.</i>\"\n\n");
				}
				else if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 2) {
					outputText("\"<i>Oh so you wanna go out and hunt some extra minotaurs? Good! You make sure to kill three or as many as you can so we can breath fresh air safe from minotaur musk, got it?</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 1);
				}
				else {
					if (player.hasItem(useables.MINOHOR, 2) || Slot03 >= 2) {
						outputText("Yang count the horns then smile.\n\n");
						outputText("\"<i>Well you indeed did bag two out of two. The guild asked me to pay you this specific tome. Betcha will find nice uses for these. Do come and find me later on for a new job, or for something else...</i>\"\n\n");
						outputText("Yang gives you a telltale wink before handing you over your reward.\n\n");
						if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0) player.addKeyValue("Adventurer Guild: Copper plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 3, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 1);
						if (Slot03 >= 2) Slot03 -= 2;
						else player.destroyItems(useables.MINOHOR, 2);
						inventory.takeItem(consumables.TCLEAVE, BoardkeeperYangQuest);
					}
					else outputText("\"<i>Hey [name], I counted those horns and clearly you forgot a few. Get out there and bring me the remaining ones.</i>\"\n\n");
				}
			}
			else {
				outputText("Yang takes on a grave expression.\n\n");
				outputText("\"<i>Look [name] I won’t sugar coat it up for you. We’re buried knee deep into horsecocks, specificaly minotaur cocks. What the guild would like you to do is go out, kill some of the bulls out there, say two or so of them, and bring back their horns. You do that for us and we'll reward you accordingly.</i>\"\n\n");
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
					outputText("The panda decline the job request.\n\n");
					outputText("\"<i>Sorry [name] this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) == 4) {
					if (player.hasItem(useables.GREENGL, 5)) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>Good job there. I hope gathering these did not prove to much trouble. Here is your payment.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter4, 2, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests4, 2, 1);
						player.destroyItems(useables.GREENGL, 5);
						flags[kFLAGS.SPIRIT_STONES] += 3;
						statScreenRefresh();
					}
					else outputText("You try to turn in the quest but Yang tells you you don’t have enough gel yet.\n\n");
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) == 2) {
					outputText("\"<i>You may or may not like that one. The good news is you are going out to gather gel the bad news is it primarily drop from goo girls which is a friendly species so your morality may be put to the test. How you handle that is up to you. Regardless bring us back 5 gel and your job will be done.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests4, 2, 2);
				}
				else {
					if (player.hasItem(useables.GREENGL, 5)) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>My my, nice job. I can only hope you kept that weapon clean of innocent blood. Regardless here is your payment. This reminds me the client told me to leave you this scroll as a reward too you know what to do with it I suppose?</i>\"\n\n");
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
				outputText("\"<i>You may or may not like that one. The good news is you are going out to gather gel the bad news is it primarily drop from goo girls which is a friendly species so your morality may be put to the test. How you handle that is up to you. Regardless bring us back 5 gel and your job will be done.</i>\"\n\n");
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
					outputText("The panda decline the job request.\n\n");
					outputText("\"<i>Sorry [name] this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) == 4) {
					if (player.hasItem(useables.B_CHITN, 5)) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>Good job there. I hope gathering these did not prove to much trouble. Here is your payment.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter4, 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests4, 1, 1);
						player.destroyItems(useables.B_CHITN, 5);
						flags[kFLAGS.SPIRIT_STONES] += 4;
						statScreenRefresh();
					}
					else outputText("You try to turn in the quest but Yang tells you you don’t have enough chitin yet.\n\n");
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) == 2) {
					outputText("\"<i>You may or may not like that one. The good news is you are going out to gather chitin the bad news is it primarily drop from bee girls which is a friendly species so your morality may be put to the test. How you handle that is up to you, ");
					outputText("for all I know chitin is often found on the forest ground where bee girls trives. Regardless bring us back 5 chitin and your job will be done.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests4, 1, 2);
					if (player.statusEffectv3(StatusEffects.AdventureGuildQuests4) > 0) {
						player.removeStatusEffect(StatusEffects.AdventureGuildQuests4);
						player.createStatusEffect(StatusEffects.AdventureGuildQuests4, 4, 0, 0, 0);
					}
				}
				else {
					if (player.hasItem(useables.B_CHITN, 5)) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>My my, nice job. I can only hope you kept that weapon clean of innocent blood. Regardless here is your payment. This reminds me the client told me to leave you this scroll as a reward too you know what to do with it I suppose?</i>\"\n\n");
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
				outputText("\"<i>You may or may not like that one. The good news is you are going out to gather chitin the bad news is it primarily drop from bee girls which is a friendly species so your morality may be put to the test. How you handle that is up to you, ");
				outputText("for all I know chitin is often found on the forest ground where bee girls trives. Regardless bring us back 5 chitin and your job will be done.</i>\"\n\n");
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
					outputText("You turn in the quest and Yang nod in appreciation. She verify the imp, it literally trying to claw at her face before she close the bag again.\n\n");
					outputText("\"<i>Looks feral, good job there. The imp will be delivered to the researchers address and she will study it in order to perhaps develop a cure. As for you I think you earned your reward.</i>\"\n\n");
					if (flags[kFLAGS.GALIA_LVL_UP] == 0.01) flags[kFLAGS.GALIA_LVL_UP] = 0.05;
					else flags[kFLAGS.GALIA_LVL_UP] += 0.05;
					flags[kFLAGS.GALIA_AFFECTION] = 0;
					flags[kFLAGS.SPIRIT_STONES] += 2;
					statScreenRefresh();
				}
				else outputText("You try turn in the quest but looking inside your bag Yang tells you you cant turn an empty bag in and need to capture an imp first.\n\n");
			}
			else {
				outputText("\"<i>You remember that scholar studying the feral creatures? Happens to be this time around she needs you to capture feral imp alive. I understand this is a weird job but we need imps so to study them and understand what is causing them to go mad. For this purpose the guild prepared a special enchanted bag for you to stow an imp in. Of course you will be paid for the job.</i>\"\n\n");
				outputText("You shrug and accept the job. Guess you are back fighting imps once again.\n\n");
				flags[kFLAGS.GALIA_LVL_UP] = 0.01;
			}
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangQuestEzekiel1a():void {
			clearOutput();
			outputText("You turn in the quest and Yang nod in appreciation. She verify the imp, it literally trying to claw at her face before she close the bag again.\n\n");
			outputText("\"<i>Looks feral, good job there. The imp will be delivered to the researchers address and she will study it in order to perhaps develop a cure. As for you I think you earned your reward. By the way this imp is clearly a female, this is a rare find. If you hand it to us we will increase your reward accordingly that is… unless you want to keep her?</i>\"\n\n");
			menu();
			addButton(1, "No want", BoardkeeperYangQuestEzekiel1NoWant);
			addButton(3, "Keep", BoardkeeperYangQuestEzekiel1Keep);
		}
		public function BoardkeeperYangQuestEzekiel1NoWant():void {
			outputText("You turn in the quest and Yang nod in appreciation. She verify the imp, it literally trying to claw at her face before she close the bag again.\n\n");
			outputText("\"<i>Looks feral, good job there. The imp will be delivered to the researchers address and she will study it in order to perhaps develop a cure. As for you I think you earned your reward.</i>\"\n\n");
			flags[kFLAGS.GALIA_LVL_UP] = 0.53;
			flags[kFLAGS.GALIA_AFFECTION] = 0;
			flags[kFLAGS.SPIRIT_STONES] += 22;
			statScreenRefresh();
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangQuestEzekiel1Keep():void {
			outputText("She sigh in disappointment before grabbing the female imp by the neck, putting her in an harness and handing her back to you fully hogtied.\n\n");
			outputText("\"<i>Guess there is no helping it then make sure she does not cause trouble.</i>\"\n\n");
			doNext(SceneLib.galiaFollower.bringBackTheFemImp);
		}
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
		public function BoardkeeperYangGolemRetrievalJob():void {
			clearOutput();
			if (flags[kFLAGS.AURORA_LVL] == 0.3) {
				outputText("You ask Yang if it would be possible for you to post a job. You happen to have a chained golem you want retrieved from the hidden cave and brought up back to your camp.\n\n");
				outputText("Yang nods \"<i>Yeah, sure we can do that. Just write a full job description and I will post it on the board. It will cost 10 spirit stones.</i>\"\n\n");
				if (flags[kFLAGS.SPIRIT_STONES] < 10) {
					outputText("You tell her you’ll be back with the stones the moment you have them.\n\n");
					doNext(curry(SceneLib.journeyToTheEast.enteringInn,false));
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
			outputText("Yang wait at you arm crossed. You write a full job description and hand it over to Yang along with the stones. This done, she then posts it on the board as an iron plate request.\n\n");
			flags[kFLAGS.SPIRIT_STONES] -= 10;
			flags[kFLAGS.AURORA_LVL] = 0.35;
			statScreenRefresh();
			doNext(BoardkeeperYangQuest);
		}
		public function BoardkeeperYangTalk():void {
			clearOutput();
			outputText("Yang wait at you arm crossed.\n\n");
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
			outputText("What’s her job really. Is she an adventurer herself?\n\n");
			outputText("\"<i>Me? No dear no I’m just the guild poster girl. I’m actually paid to stand there. That said there’s a few perk to it as I get to meet some of Mareth’s biggest badass face to face and sometime closer, if you catch my drift.</i>\"\n\n");
			doNext(BoardkeeperYangTalk);
		}
		public function BoardkeeperYangTalkHeXinDao():void {
			clearOutput();
			outputText("Placeholder for lazyLia writing ^^\n\n");
			doNext(BoardkeeperYangTalk);
		}
		public function BoardkeeperYangTalkRequests():void {
			clearOutput();
			outputText("Ok you are a member now, how do you take on a job?\n\n");
			outputText("\"<i>First and foremost you come to me or any other board on mareth if you can find one. Then you choose a difficulty and I set you on a corresponding request.</i>\"\n\n");
			outputText("Difficulty? You thought you could pick on the highest request right away.\n\n");
			outputText("\"<i>No such thing " + player.mf("Mr", "Mrs") + " hero. The guild has strict ruling to prevent people throwing their lives away on job they can’t handle. We have a difficulty system based on skill and rank. You cannot take on a request way above your ranking until you have qualified for it. The rank are determined by copper, bronze, silver, gold and platinum plates.</i>\"\n\n");
			doNext(BoardkeeperYangTalk);
		}
		public function BoardkeeperYangTalkOthers():void {
			clearOutput();
			outputText("If there is a guild there is bound to be many adventurers, who are they?\n\n");
			outputText("\"<i>Well now that you ask yes there are a few local adventurers however most of them aren’t worthy of mention. That said one stands out, her name is Chi Chi and she regularly go out on request involving battling the corrupt forces. One hell of a fighter to, I heard she is a veteran of the town arena.");
			if (flags[kFLAGS.CHI_CHI_AFFECTION] < 10) outputText(" If you want to get in on that action you may want to enlist in the arena gauntlet challenges to draw her attention.");
			outputText("</i>\"\n\n");
			doNext(BoardkeeperYangTalk);
		}
		public function BoardkeeperYangSex():void {
			clearOutput();
			outputText("She giggle before teasingly puffing her chest up, which only shows more cleavage than necessary.\n\n");
			outputText("\"<i>Well that’s cute " + player.mf("Mr", "Mrs") + " hero but I don’t go for a ride with just anyone who ask. Complete at least a silver request for the guild and I will give you a shot.</i>\"");
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
					Slot03Cap = 10;
					Slot04Cap = 10;
					Slot05Cap = 10;
				}
				else {
					outputText("Yeah sure, you will get promoted. Or rather, you would like to but you lack the required spirit stones for the promotion fee.\n\n");
					outputText("\"<i>Its ok just go to Moga Hen, he should be able to exchange those gem of yours for the local currency.</i>\"");
				}
			}
			if (player.keyItemvX("Adventurer Guild: Iron plate", 1) > 1) {
				if (flags[kFLAGS.SPIRIT_STONES] >= 15) {
					outputText("Yang nod. \"<i>Yep it’s definitely time we promoted hou. You pass from Iron plate to Bronze, congratulations!</i>\"\n\n");
					outputText("She hand you over a new necklace which you proceed to don up.\n\n");
					player.removeKeyItem("Adventurer Guild: Iron plate");
					player.createKeyItem("Adventurer Guild: Bronze plate", 0, 0, 0, 0);
					flags[kFLAGS.SPIRIT_STONES] -= 15;
					Slot06Cap = 10;
					Slot07Cap = 10;
				}
				else {
					outputText("Yeah sure, you will get promoted. Or rather you would like to but you lack the required spirit stones for the promotion fee.\n\n");
					outputText("\"<i>Its ok just go to Moga Hen, he should be able to exchange those gem of yours for the local currency.</i>\"");
				}
			}
			doNext(BoardkeeperYangMain);
		}
	}
}
