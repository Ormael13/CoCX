/**
 * ...
 * @author Ormael and others
 */
package classes.Scenes.Places.HeXinDao 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	import classes.BodyParts.Tail;
	
	public class JourneyToTheEast extends HeXinDaoAbstractContent
	{
		public function JourneyToTheEast() 
		{}
		
		public function enteringInn(first:Boolean = true):void {
			clearOutput();
			if(first){
				outputText("You enter the town local Inn ‘Journey to the East’ and look around. ");
			}
			outputText("You can see many people enjoying a meal or drink in the dining hall, a barman standing by ready to serve drinks.");
			if (model.time.hours >= 18 && rand(4) == 0) {
				ChiChiDrunkSex();
				return;
			}
			menu();
			addButton(0, "Drink", drinkAlcohol);
			addButton(4, "Adv.Guild", BoardkeeperYangMain);
			//addButtonDisabled(12, "???", "You see some suspicious looking squirrel in one of inn corners. (Liadri + Star should bring this npc to more completness)");
			addButton(14, "Leave", heXinDao.riverislandVillageStuff);
		}
		
		private function drinkAlcohol():void {
			clearOutput();
			outputText("You go sit at the counter and the barman comes over to take your order.\n\n");
			outputText("\"<i>Good ");
			if (model.time.hours >= 16) outputText("afternoon ");
			else outputText("morning");
			outputText("" + player.mf("mister", "miss") + ", what can I get you?</i>\"\n\n");
			menu();
			addButton(0, "ManUp B", buyDrink, consumables.MANUP_B);
			addButton(1, "Gob.Ale", buyDrink, consumables.GOB_ALE);
			addButton(2, "NoceLiq", buyDrink, consumables.NOCELIQ);
			addButton(3, "OniSake", buyDrink, consumables.ONISAKE);
			addButton(4, "SalamFW", buyDrink, consumables.SALAMFW);
			addButton(12, "BimboL", buyDrink, consumables.BIMBOLQ);
			addButton(13, "BroBrew", buyDrink, consumables.BROBREW);
			addButton(14, "Back", notThirsty);
		}
		//drink list (to be expanded)	fire mouse TF, some generic nonTF beers
		private function notThirsty():void {
			clearOutput();
			outputText("In the end you realise you are not thirsty after all and wave a goodbye before leaving.\n\n");
			doNext(curry(enteringInn,false));
		}
		
		private function buyDrink(drink:ItemType):void{
			var cost:int = drink.value * 3;
			if(player.gems < cost){
				outputText("\n\nBarman shakes his head, indicating you need " + String(cost - player.gems) + " more gems to purchase this drink.");
				doNext(drinkAlcohol);
				return;
			}
			player.gems -= cost;
			statScreenRefresh();
			outputText("\n\nThe barman hands over the drink you ordered.");
			inventory.takeItem(drink, drinkAlcohol);
		}
		
		public function BoardkeeperYangMain():void {
			clearOutput();
			if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0 || player.hasKeyItem("Adventurer Guild: Iron plate") >= 0) {// || player.hasKeyItem("Adventurer Guild: Bronze plate") >= 0 || player.hasKeyItem("Adventurer Guild: Silver plate") >= 0 || player.hasKeyItem("Adventurer Guild: Gold plate") >= 0 || player.hasKeyItem("Adventurer Guild: Platinum plate") >= 0
				outputText("Yang the job handler wait at you arm crossed. She looks bored like she has been there all day.\n\n");
				outputText("\"<i>So [name] how can I help you today? Here to talk jobs or something else?</i>\"");
				menu();
				addButton(0, "Quest", BoardkeeperYangQuest);
				addButton(1, "Talk", BoardkeeperYangTalk);
				if (player.keyItemv1("Adventurer Guild: Copper plate") > 1) addButton(2, "Promotion", BoardkeeperYangPromotion).hint("Ask Yang for a promotion once you have achieved enough jobs.");
				else addButtonDisabled(2, "Promotion", "Not meet req.");
				addButton(3, "Sex", BoardkeeperYangSex);
				addButton(4, "Back", curry(enteringInn,false));
			}
			else {
				outputText("You approach the board covered in colorful papers and the panda girl next to it smile at you.\n\n");
				outputText("\"<i>Well hello there! Are you looking for a job? I represent the adventurer guild and my organisation could use more able bodied men’s and women’s like you.</i>\"\n\n");
				outputText("An adventurer guild? What's the benefits?\n\n");
				outputText("\"<i>Mareth is both filled with perils, lost treasures and people in need of heroic assistance. By paying a small membership fee I can let you in on local events that could use your assistance and give you pointers to unplundered ruins. It’s only 5 spirit stones to join. Fame and treasure? All within your reach to grab.</i>\"");
				menu();
				addButton(0, "Decline", No);
				addButton(1, "Join", Yes);
			}
		}
		private function No():void {
			clearOutput();
			outputText("You aren’t interested into dungeon delving at the time. It's barely if you're not overburdened with your regular activities.");
			doNext(curry(enteringInn,false));
		}
		private function Yes():void{
			clearOutput();
			if (flags[kFLAGS.SPIRIT_STONES] < 5) {
				outputText("Yeah sure, you will join. Or rather you would like to but you lack the required spirit stones for the membership fee.\n\n");
				outputText("\"<i>Its ok just go to Moga Hen, he should be able to exchange those gem of yours for the local currency.</i>\"");
				doNext(curry(enteringInn,false));
			}
			else {
				outputText("Yeah sure, you will join. You handle the ursine woman the spirit stones and sign the papers.\n\n");
				outputText("\"<i>Perfect, Just perfect. Let me hand you over your badge.</i>\"\n\n");
				outputText("She picks up a small Copper colored plate and give it to you.\n\n");
				outputText("\"<i>Well as of now you are officially a member of the adventurer guild. Tell whenever you are ready ask for a quest and I will direct you to your target.</i>\"\n\n");
				flags[kFLAGS.SPIRIT_STONES] -= 5;
				statScreenRefresh();
				player.createKeyItem("Adventurer Guild: Copper plate", 0, 0, 0, 0);
				doNext(curry(enteringInn,false));
			}
		}
		public function BoardkeeperYangQuest():void {
			clearOutput();
			outputText("The panda girl nod and allow you to browse the board.\n\n");
			outputText("\"<i>Plenty of quest available. Which one will you take?</i>\"\n\n");
			menu();
			addButton(0, "Imps", BoardkeeperYangQuestImps1).hint("Cooper tier Quest.");
			addButton(1, "Ferals(1)", BoardkeeperYangQuestFerals1).hint("Cooper tier Quest.");
			addButton(2, "Ferals(2)", BoardkeeperYangQuestFerals2).hint("Cooper tier Quest.");
			addButton(3, "Minotaurs", BoardkeeperYangQuestMinotaurs).hint("Cooper tier Quest.");
			if (player.hasKeyItem("Adventurer Guild: Iron plate") >= 0) {
				addButton(4, "Demons", BoardkeeperYangQuestDemons1).hint("Iron tier Quest.");
			}
			addButton(14, "Back", BoardkeeperYangMain);
		}
		public function BoardkeeperYangQuestImps1():void {
			clearOutput();
			if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests1)) {
				if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) > 6) {
					outputText("The panda decline the job request.\n\n");
					outputText("\"<i>Sorry [name] this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 6) {
					if (player.hasItem(useables.IMPSKLL, 5)) {
						outputText("Yang examine the skulls to make sure those are imps then nods giving you your payment.\n\n");
						outputText("\"<i>Good job [name] here is your payment.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 1);
						player.destroyItems(useables.IMPSKLL, 5);
						flags[kFLAGS.SPIRIT_STONES] += 7;
						statScreenRefresh();
					}
					else {
						outputText("The panda tap her foot on the ground.\n\n");
						outputText("\"<i>I thought I had been clear the bounty require 5 imps skulls [name]. Get back to hunting.</i>\"\n\n");
					}
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 4) {
					outputText("Yang eyes you with keen interest then ask.\n\n");
					outputText("\"<i>Would you actually be interested into something easier? Right now there's a bounty on imp slaying. Bring me back 5 imp skulls and I will see it through that you are properly rewarded.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 2);
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 3) {
					if (player.hasItem(useables.IMPSKLL, 4)) {
						outputText("Yang examine the skulls to make sure those are imps then nods giving you your payment.\n\n");
						outputText("\"<i>Good job [name] here is your payment along with a special training scroll.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 1);
						player.destroyItems(useables.IMPSKLL, 4);
						player.perkPoints += 1;
					}
					else {
						outputText("The panda tap her foot on the ground.\n\n");
						outputText("\"<i>I thought I had been clear the bounty require 4 imps skulls [name]. Get back to hunting.</i>\"\n\n");
					}
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 2) {
					outputText("Yang eyes you with keen interest then ask.\n\n");
					outputText("\"<i>Would you actually be interested into something easier? Right now there's a bounty on imp slaying. Bring me back 4 imp skulls and I will see it through that you are properly rewarded.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 1);
				}
				else {
					if (player.hasItem(useables.IMPSKLL, 3)) {
						outputText("Yang examine the skulls to make sure those are imps then nods giving you your payment.\n\n");
						outputText("\"<i>Good job [name] here is your payment. By the way I though you may want to be able to sense corruption, can be useful to hunt demons here have this amulet.</i>\"\n\n");
						outputText("(<b>Acquired demon hunter amulet!</b>)\n\n");
						outputText("(<b>Gained New Perk: Sense Corruption</b>)");
						if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0) player.addKeyValue("Adventurer Guild: Copper plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 1);
						player.createKeyItem("Demon Hunter Amulet", 0, 0, 0, 0);
						player.createPerk(PerkLib.SenseCorruption, 0, 0, 0, 0);
						player.destroyItems(useables.IMPSKLL, 3);
					}
					else {
						outputText("The panda tap her foot on the ground.\n\n");
						outputText("\"<i>I thought I had been clear the bounty require 3 imps skulls [name]. Get back to hunting.</i>\"\n\n");
					}
				}
			}
			else {
				outputText("Yang eyes you with keen interest then ask.\n\n");
				outputText("\"<i>Would you actually be interested into something easier? Right now there's a bounty on imp slaying. Bring me back 3 imp skulls and I will see it through that you are properly rewarded.</i>\"\n\n");
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests1)) player.addStatusValue(StatusEffects.AdventureGuildQuests1, 1, 1);
				else player.createStatusEffect(StatusEffects.AdventureGuildQuests1, 1, 0, 0, 0);
			}
			doNext(curry(enteringInn,false));
		}
		public function BoardkeeperYangQuestFerals1():void {
			clearOutput();
			if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) > 0) {
				if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) > 6) {
					outputText("The panda decline the job request.\n\n");
					outputText("\"<i>Sorry [name] this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 6) {
					if (player.hasItem(useables.SEVTENT, 3)) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>Good job there. I hope those plants did not prove to much trouble. Here is your payment.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 1);
						player.destroyItems(useables.SEVTENT, 3);
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
					if (player.hasItem(useables.SEVTENT, 2)) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>Good job [name] here is your payment along with a special training scroll.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 1);
						player.destroyItems(useables.SEVTENT, 2);
						player.perkPoints += 1;
					}
					else outputText("You try turn in the quest but Yang tells you you don’t have enough tentacles yet.\n\n");
				}
				else if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 2) {
					outputText("\"<i>Someone put up a bounty for slaying tentacle beast. I would need lets say 2 tentacle from those mishapen creature as proof of your deed. Of course you will be rewarded for the job.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 1);
				}
				else {
					if (player.hasItem(useables.SEVTENT, 1)) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>My my, I wasn’t sure I would ever see you back.</i>\"\n\n");
						outputText("Seems she misjudged you then?\n\n");
						outputText("\"<i>Everyone makes mistakes and plants assignments are way more dangerous than imps, you clearly outpaced expectation. Here is your payment. This reminds me some man told me to leave you this scroll as a reward too... should help you sense the anger of your opponents he said.</i>\"\n\n");
						outputText("(<b>Gained New Perk: Sense Wrath</b>)");
						if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0) player.addKeyValue("Adventurer Guild: Copper plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 1);
						player.createPerk(PerkLib.SenseWrath, 0, 0, 0, 0);
						player.destroyItems(useables.SEVTENT, 1);
					}
					else outputText("You try turn in the quest but Yang tells you you don’t have enough tentacles yet.\n\n");
				}
			}
			else {
				outputText("\"<i>Someone put up a bounty for slaying tentacle beast. I would need lets say 1 tentacle from those mishapen creature as proof of your deed. Of course you will be rewarded for the job.</i>\"\n\n");
				outputText("You shrug and accept the job. Plants... what could go wrong?\n\n");
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests2)) player.addStatusValue(StatusEffects.AdventureGuildQuests2, 1, 1);
				else player.createStatusEffect(StatusEffects.AdventureGuildQuests2, 1, 0, 0, 0);
			}
			doNext(curry(enteringInn,false));
		}
		public function BoardkeeperYangQuestDemons1():void {
			clearOutput();
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) > 0) {
				if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) > 6) {
					outputText("The panda decline the job request.\n\n");
					outputText("\"<i>Sorry [name] this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 6) {
					if (player.hasItem(useables.DEMSKLL, 3)) {
						outputText("You turn in the quest and Yang nod.\n\n");
						outputText("\"<i>Good job as usual here is your payment.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, 1);
						player.destroyItems(useables.DEMSKLL, 3);
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
					if (player.hasItem(useables.DEMSKLL, 2)) {
						outputText("You turn in the quest and Yang nod.\n\n");
						outputText("\"<i>Good job [name] here is your payment along with a special training scroll.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, 1);
						player.destroyItems(useables.DEMSKLL, 2);
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
					if (player.hasItem(useables.DEMSKLL, 1)) {
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
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, 1);
						player.createPerk(PerkLib.DemonSlayer, 0.1, 0, 0, 0);
						player.destroyItems(useables.DEMSKLL, 1);
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
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests1)) player.addStatusValue(StatusEffects.AdventureGuildQuests1, 2, 1);
				else player.createStatusEffect(StatusEffects.AdventureGuildQuests1, 0, 1, 0, 0);
			}
			doNext(curry(enteringInn,false));
		}
		public function BoardkeeperYangQuestFerals2():void {
			clearOutput();
			if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) > 0) {
				if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) > 6) {
					outputText("The panda decline the job request.\n\n");
					outputText("\"<i>Sorry [name] this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 6) {
					if (player.hasItem(useables.FIMPSKL, 5)) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>Good job there. I heard those creatures are actually out there killing instead of raping, it’s quite chilling. Here is your payment.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 1);
						player.destroyItems(useables.FIMPSKL, 5);
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
					if (player.hasItem(useables.FIMPSKL, 4)) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>Good job there. I heard those creatures are actually out there killing instead of raping, it’s quite chilling. Here is your payment along with a special training scroll.</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 1);
						player.destroyItems(useables.FIMPSKL, 4);
						player.perkPoints += 1;
					}
					else outputText("You try turn in the quest but Yang tells you you don’t have enough feral imp skulls yet.\n\n");
				}
				else if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 2) {
					outputText("\"<i>Someone put up a bounty for slaying feral imps. I would need lets say 4 feral imps skulls from those mishapen creature as proof of your deed. Of course you will be rewarded for the job.</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 1);
				}
				else {
					if (player.hasItem(useables.FIMPSKL, 3)) {
						outputText("You turn in the quest and Yang nod in appreciation.\n\n");
						outputText("\"<i>My my, I wasn’t sure I would ever see you back.</i>\"\n\n");
						outputText("Seems she misjudged you then?\n\n");
						outputText("\"<i>Everyone makes mistakes and feral imps assignments are way more dangerous than normal imps, you clearly outpaced expectation. Here is your payment. This reminds me some man told me to leave you this scroll as a reward too... should help you fight feral opponents he said.</i>\"\n\n");
						outputText("(<b>Gained New Perk: Feral Hunter</b>)");
						if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0) player.addKeyValue("Adventurer Guild: Copper plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 1);
						player.createPerk(PerkLib.FeralHunter, 0.1, 0, 0, 0);
						player.destroyItems(useables.FIMPSKL, 3);
					}
					else outputText("You try turn in the quest but Yang tells you you don’t have enough feral imp skulls yet.\n\n");
				}
			}
			else {
				outputText("\"<i>Someone put up a bounty for slaying feral imps. I would need lets say 3 feral imps skulls from those mishapen creature as proof of your deed. Of course you will be rewarded for the job.</i>\"\n\n");
				outputText("You shrug and accept the job. It's time to hunt some imps.\n\n");
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests2)) player.addStatusValue(StatusEffects.AdventureGuildQuests2, 2, 1);
				else player.createStatusEffect(StatusEffects.AdventureGuildQuests2, 0, 1, 0, 0);
			}
			doNext(curry(enteringInn,false));
		}
		public function BoardkeeperYangQuestMinotaurs():void {
			clearOutput();
			if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) > 0) {
				if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) > 6) {
					outputText("The panda decline the job request.\n\n");
					outputText("\"<i>Sorry [name] this job is only once per day. Come back tomorrow.</i>\"\n\n");
				}
				else if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 6) {
					if (player.hasItem(useables.MINOHOR, 4)) {
						outputText("Yang count the horns then smile.\n\n");
						outputText("\"<i>Well you did bag four out of four nice job. The guild asked me to pay you this reward money as usual for slaying bulls. Do come and find me later on for a new job, or for something else...</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 1);
						player.destroyItems(useables.MINOHOR, 4);
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
					if (player.hasItem(useables.MINOHOR, 3)) {
						outputText("Yang count the horns then smile.\n\n");
						outputText("\"<i>Well you did bag three out of three nice job. The guild asked me to pay you with this special training scroll for slaying bulls. Do come and find me later on for a new job, or for something else...</i>\"\n\n");
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 1);
						player.destroyItems(useables.MINOHOR, 3);
						player.perkPoints += 1;
					}
					else outputText("\"<i>Hey [name], I counted those horns and clearly you forgot a few. Get out there and bring me the remaining ones.</i>\"\n\n");
				}
				else if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 2) {
					outputText("\"<i>Oh so you wanna go out and hunt some extra minotaurs? Good! You make sure to kill three or as many as you can so we can breath fresh air safe from minotaur musk, got it?</i>\"\n\n");
					player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 1);
				}
				else {
					if (player.hasItem(useables.MINOHOR, 2)) {
						outputText("Yang count the horns then smile.\n\n");
						outputText("\"<i>Well you indeed did bag two out of two. The guild asked me to pay you this specific tome. Betcha will find nice uses for these. Do come and find me later on for a new job, or for something else...</i>\"\n\n");
						outputText("Yang gives you a telltale wink before handing you over your reward.\n\n");
						if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0) player.addKeyValue("Adventurer Guild: Copper plate", 1, 1);
						player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 1);
						player.destroyItems(useables.MINOHOR, 2);
						inventory.takeItem(consumables.TCLEAVE, curry(enteringInn,false));
					}
					else outputText("\"<i>Hey [name], I counted those horns and clearly you forgot a few. Get out there and bring me the remaining ones.</i>\"\n\n");
				}
			}
			else {
				outputText("Yang takes on a grave expression.\n\n");
				outputText("\"<i>Look [name] I won’t sugar coat it up for you. We’re buried knee deep into horsecocks, specificaly minotaur cocks. What the guild would like you to do is go out, kill some of the bulls out there, say two or so of them, and bring back their horns. You do that for us and we'll reward you accordingly.</i>\"\n\n");
				if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests1)) player.addStatusValue(StatusEffects.AdventureGuildQuests1, 3, 1);
				else player.createStatusEffect(StatusEffects.AdventureGuildQuests1, 0, 0, 1, 0);
			}
			doNext(curry(enteringInn,false));
		}
		public function BoardkeeperYangQuestFerals3():void {
			clearOutput();
			outputText("Placeholder for lazyLia writing ^^\n\n");//feral demons hunt
			doNext(curry(enteringInn,false));
		}
		public function BoardkeeperYangQuest4():void {
			clearOutput();//feral imps research
			outputText("\"<i>The town schoolars put a bounty on some weird new variant of demon’s called feral, something about wanting to study the weird strait of unusually aggressive creatures. I would need lets say 10 feral imp skull so the scholar has enough material. Of course you will be rewarded for the job.</i>\"\n\n");
			doNext(curry(enteringInn,false));
		}
		public function BoardkeeperYangQuest3():void {
			clearOutput();
			outputText("Placeholder for lazyLia writing ^^\n\n");
			doNext(curry(enteringInn,false));
		}
		public function BoardkeeperYangQuest2():void {
			clearOutput();
			outputText("Placeholder for lazyLia writing ^^\n\n");
			doNext(curry(enteringInn,false));
		}
		public function BoardkeeperYangQuest1():void {
			clearOutput();
			outputText("Placeholder for lazyLia writing ^^\n\n");
			doNext(curry(enteringInn,false));
		}
		public function BoardkeeperYangTalk():void {
			clearOutput();
			outputText("Yang wait at you arm crossed.\n\n");
			outputText("\"<i>Here to talk or something else?</i>\"");
			menu();
			addButton(0, "Her Job", BoardkeeperYangTalkHerJob);
			addButton(1, "He'Xin'Dao", BoardkeeperYangTalkHeXinDao);
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
			doNext(curry(enteringInn,false));
		}
		public function BoardkeeperYangPromotion():void {
			clearOutput();
			if (player.keyItemv1("Adventurer Guild: Copper plate") > 1) {
				if (flags[kFLAGS.SPIRIT_STONES] >= 10) {
					outputText("Yang nod. \"<i>Yep it’s definitely time we promoted hou. You pass from Copper plate to Iron, congratulations!</i>\"\n\n");
					outputText("She hand you over a new necklace which you proceed to don up.\n\n");
					player.removeKeyItem("Adventurer Guild: Copper plate");
					player.createKeyItem("Adventurer Guild: Iron plate", 0, 0, 0, 0);
				}
				else {
					outputText("Yeah sure, you will get promoted. Or rather you would like to but you lack the required spirit stones for the promotion fee.\n\n");
					outputText("\"<i>Its ok just go to Moga Hen, he should be able to exchange those gem of yours for the local currency.</i>\"");
				}
			}
			if (player.keyItemv1("Adventurer Guild: Iron plate") > 1) {
				if (flags[kFLAGS.SPIRIT_STONES] >= 15) {
					outputText("Yang nod. \"<i>Yep it’s definitely time we promoted hou. You pass from Iron plate to Bronze, congratulations!</i>\"\n\n");
					outputText("She hand you over a new necklace which you proceed to don up.\n\n");
					player.removeKeyItem("Adventurer Guild: Iron plate");
					player.createKeyItem("Adventurer Guild: Bronze plate", 0, 0, 0, 0);
				}
				else {
					outputText("Yeah sure, you will get promoted. Or rather you would like to but you lack the required spirit stones for the promotion fee.\n\n");
					outputText("\"<i>Its ok just go to Moga Hen, he should be able to exchange those gem of yours for the local currency.</i>\"");
				}
			}
			doNext(BoardkeeperYangMain);
		}
		
		public function ChiChiDrunkSex():void {
			clearOutput();
			outputText("As you enter the bar you hear a feminine laughter swiftly spotting what seems to be ");
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] >= 1 && flags[kFLAGS.CHI_CHI_AFFECTION] >= 20) outputText("Chi Chi");
			else if (flags[kFLAGS.CHI_CHI_FOLLOWER] >= 1 && flags[kFLAGS.CHI_CHI_AFFECTION] < 20) outputText("Chi Chi the waitress from the exotic food restaurant");
			else outputText("a blazing mouse girl");
			outputText(" sitting on one of the stool drinking sake.\n\n");
			outputText("\"<i>Yeah, and after I told it I was the top girl here I punched it in the face, Woooooooo!</i>\" ");
			outputText("The barman sighs, pretending not to notice the drunken mouse, aside for when he has to serve her a new drink. Just as you are about to order something she realises you are there and engages in conversation.\n\n");
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2) outputText("\"<i>Gaaaaah, [name], why do you hang around all those girls. Worse why do you fuck with them and not me?! Its like you are a " + player.mf("go go boy","cheap whore") + " selling your body to everyone and thish drives me mad! Yeaaa, I’m going to prove them all I’m the top shlut!</i>\"");
			else if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 1) outputText("\"<i>Hey... you’re that so called champ who lost in the arena?! Well I like you. I like you so much I’d want you as my " + player.mf("boy","girl") + "friend but waaaah I’m way too shy to tell you that right! Well don’t go tell [name] I like " + player.mf("him","her") + " got it? Yeah who cares about that! Barman a round for [name] the best person I met woooo. Now let’s have sex!</i>\"");
			else outputText("\"<i>Hey you... yesh you, the tall person over there! Think you can fight?! Well I’m pretty sure nobody in this village hash the guts to anyway. If you dare show up in the arena I will beat you to death like I do everyone. Now that I think of it, there are other kinds of battle I can beat people in. Bet you're the kind who fucks every demon you meet. Well not tonight, letsh bang!</i>\"");
			outputText("Wait, what? You barely have the time to mutter a reply before the red cheeked mousette pushes you on the nearest table and climbs over you. The barman pulls a curtain around your table, he must be used to this.\n\n");
			outputText("\"<i>Yeshh you heard me you big idiot. I’m going to fuck with you here and now! So don’t you dare try to run away because I will get very mad if you do.</i>\"");
			outputText("Do you let her?\n\n");
			menu();
			addButton(0, "Let Her", drunksex,true);
			addButton(1, "Refuse", drunksex,false);
		}
		private function drunksex(selected:Boolean):void {
			if (!selected) {
				outputText("" + (flags[kFLAGS.CHI_CHI_FOLLOWER] > 0 ? "Chi Chi" : "The mouse") + " is clearly out of it. Better stop her now before she does something she will regret later. You shove her to the side and run for the exit of the bar. Hearing her swear in background. Once outside you head back to camp.");
				doNext(camp.returnToCampUseOneHour);
			}
			else {
				outputText("You would have to be an idiot indeed to refuse this free fuck. The drunken mouse girl licks her lips in anticipation, grabbing your clothes and begins to removing them one-by-one. Unsurprisingly, her own clothes barely takes a second to remove. She is so close now you can feel her breath on your neck.");
				if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 1) {
					outputText(" The mousette introduces herself.\n\n");
					outputText("\"<i>My name’s Chi Chi by the way, but... oh why does it matter? What's important is that we are about to have a lot of fun.</i>\"");
				}
				//post marriage
				if (player.hasCock()) {
					outputText("Chi Chi initiates with a wet but warm kiss; Her tongue dancing tango with yours. While small in stature, she displays an uncommon level of strength rarely seen even among animal morphs. What’s more concerning is that you aren't sure how her burning tail and fur isn't actually setting everything on fire around her, especially you. You inquire on this matter.\n\n");
					outputText("\"<i>That’sh because I’m burning with passion for you big idiot! My flamesh won’t burn anything I wish not to. Or maybe they will. I never recalled how that one inn caught fire. Just you wait, I'll set both of our body aflame with desire. Your cock will be as hot as my embers.</i>\"\n\n");
					outputText("Well it's too late to back down anyway and, even if you did, the drunken megamouse is clearly going to keep you pinned down. Not to make your partner wait anymore, you slowly tease the entrance of her warm canal with your [cock]. If anything, despite being wet you can already feel how hot her oven is from the outside and can’t help but hope you won’t end up burned. Chi Chi however has no such concern and out of impatience starts stroking your dick with her embery tail.\n\n");
					outputText("\"<i>Come on, I know you want to put it in. What are you waiting for dumbassh?! I’m positively burning here.</i>\"\n\n");
					outputText("You're surprised by the direct contact with her fiery tail, even more so by the fact that it didn’t leave your dick with a third degree burn. Deciding to give the hot mouse what she wants, you put it in. Her vagina immediately starts milking you as if it was a thirsty mouth seeking water, and the frantic moving of her hips up down doesn’t help it.\n\n");
					outputText("\"<i>Gah doushe me! Don’t you shee how much I’m burning! Put that fire out with your manwater!</i>\"\n\n");
					outputText("Her pussy starts heating even more and before you know it, it actually transfers to you. Wow, your urethra is indeed as if possessed by some kind of angry efreeti. It's so hot you can’t think straight anymore, only the cool passage of cum can free you from this heat! You begin to piston in and out of Chi Chi desperate for a cooling release.\n\n");
					outputText("Both desperate for a way to get rid of the heat, the two of you manage to cum together, your jizz filling Chi Chi to the brim before slowly dripping on the ground. Chi Chi sighs in relief and exhaustion falling limp on the table.\n\n");
					outputText("\"<i>" + (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 ? "You're the besht [name] you know that? Let'sh do thish again sometimes, I jusht can’t get enough of it." : "You're a good boyfriend you know that? Let'sh do thish again sometimes.") + "</i>\"\n\n");
					outputText("She finally passes out, which is a good thing because, even if you're as tired as her, you think it'd be wise if you headed back to camp before she came back to her senses" + (flags[kFLAGS.CHI_CHI_FOLLOWER] == 2 ? ", especially because you're pretty sure she will beat you to death if she discovers the two of you had sex while she was drunk" : "") + ". You exit the establishment under the somewhat relieved gaze of the barman who gently proceeds to also get the sleeping inferno-mouse out with the help of a bouncer.\n\n");
				}
				else {
					outputText("Chi Chi initiates with a wet but warm kiss her tongue dancing tango with yours. While small in stature she displays an uncommon level of strength rarely seen even among animal morphs. What’s more concerning is that you aren't sure how come her burning tail and fur isn't actually setting on fire everything around her starting with you. You inquire on this matter.\n\n");
					outputText("\"<i>Thatsh because I’m burning with passion for you, big idiot! My flamesh won’t burn anything I wish not to. Or maybe they will. I never recalled how that one inn caught fire. Just you wait I'll set both of our body aflame with desire. Your pussy will be as hot as my embers.</i>\"\n\n");
					outputText("Well it's too late to back down anyway and, even if you did, the drunken megamouse is clearly going to keep you pinned down. Not to make your partner wait anymore you begin to grind your pussy lips against hers making her gasp in surprise at your initiative.\n\n");
					outputText("\"<i>Oh?! Finally fighting back? Good I love a girl that tries.</i>\"\n\n");
					outputText("Chi Chi begins to grind herself in response, making you both coo. For a drunk she clearly knows what she’s doing, almost like if drunken sex was an expertise of hers. You’re swiftly forced out back to reality as your blazing partner accelerates the tempo, causing you to moan in pleasure. Well now there's no way you going to simply lose this! You get the mouse ears with your hands and start caressing them. Chi Chi has a positive reaction and you are clearly getting to her however ");
					outputText("that's counting without her hidden weapon. Her burning tail lashes out like a whip and slides between you, aiming for your cunt. Before you can stop it you already have 15 inch of hot mouse tail in your [pussy] and Chi Chi uses it to fuck your brain out. The fuck isn't all that happens it seems her very heat start to spread on to you. Wow your cunt is indeed as if possessed by some kind of angry efreeti. It's so hot you can’t think straight anymore, ");
					outputText("only the cool passage of your girl-juices can free you from this heat! Meanwhile she grinds against her own tail bump but you have decided not to let her get off at her own pace. You swiftly slide " + (player.tailType > Tail.NONE ? "your tail" : "a pair of finger") + " in the smoking hot hinezumi cunt and retaliate with a set of rapid movement of your own.\n\n");
					outputText("Both desperate for a way to get rid of the heat and unable to fully outpace her, the two of you still manage to cum together your girl juices melding together and staining the ground. Chi Chi sighs in relief and exhaustion falling limp on the table.\n\n");
					outputText("\"<i>" + (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 ? "You're the besht [name] you know that? Let'sh do thish again sometimes, I jusht can’t get enough of it." : "You're a good girlfriend you know that? Let'sh do thish again sometimes.") + "</i>\"\n\n");
					outputText("She finally pass out which is a good thing because, even if you're as tired as her, you think it'd be wise if you headed back to camp before she came back to her senses" + (flags[kFLAGS.CHI_CHI_FOLLOWER] == 2 ? ", especially because you're pretty sure she will beat you to death if she discovers the two of you had sex while she was drunk" : "") + ". You exit the establishment under the somewhat relieved gaze of the barman who gently proceeded to also get the sleeping mouse out with the help of a bouncer.\n\n");
				}
				player.orgasm();
				if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 1) flags[kFLAGS.CHI_CHI_FOLLOWER] = 1;
				doNext(camp.returnToCampUseOneHour);
			}
		}
	}
}