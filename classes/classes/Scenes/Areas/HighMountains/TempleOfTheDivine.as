/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.HighMountains 
{
import classes.*;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Items.WeaponLib;
import classes.Scenes.SceneLib;

use namespace CoC;
	
	public class TempleOfTheDivine extends BaseContent
	{
		
		public function TempleOfTheDivine() 
		{}
		
		public function sapphireAffection(changes:Number = 0):Number
		{
			flags[kFLAGS.SAPPHIRE_AFFECTION] += changes;
			if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 100) flags[kFLAGS.SAPPHIRE_AFFECTION] = 100;
			return flags[kFLAGS.SAPPHIRE_AFFECTION];
		}
		
		public function firstvisitintro():void {
			flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] = 1;
			flags[kFLAGS.SAPPHIRE_TALKS] = 0;
			clearOutput();
			outputText("As you wander the mountains, you eventually climb to the very top, something you never expected to do. Weirdly enough, sitting on a nearby peak is what appears to be a massive temple. You approach the intimidating doors of the building and open them wide. Instantly you’re taken aback by the sight in front of you. ");
			outputText("There are ancient bloodstains marking the stone floor and stained glass windows depicting various deities adorning each wall. At the end of the building that obviously once was a holy site, sits one depicting Marae. Under each window is a somewhat damaged altar, the light outside shining faintly upon it.");
			outputText("\n\nAs you walk towards Marae’s Altar, a threatening voice echoes through the temple. \"<i>No one will defile this sacred place! I will slay you before you can cause any further damage!</i>\"");
			outputText("\n\nYou realize that you were never alone in the room as a large and heavy object hits you from behind, sending you sprawling to the ground. As you try to stand up, something grabs you by the leg, lifting you upside down in the air with apparent ease. While uncomfortable, and most definitely a shock, this gives you enough time to take a good look at what, or more specifically who, grabbed you. ");
			outputText("It seems to be a 7 foot tall, stone-skinned gargoyle. She carries a huge halberd and appears to be about to impale you on it. Although you wriggle, you find no weakness in her grip, you can’t escape from this one. Knowing your death is near, you utter a swift ");
			if (player.cor > 66) outputText("and desperate ");
			outputText("prayer to whichever gods may be listening. This has a surprising effect on the gargoyle, stilling her almost instantly.");
			outputText("\n\n\"<i>Demons... do not pray, you clearly still have a soul. Perhaps I misjudged you.</i>\"");
			outputText("\n\nWith little ceremony, she roughly sets you back on the ground, caring little for your well being, merely in order to thoroughly examine you. You tell her that you ");
			if (SceneLib.dungeons.checkFactoryClear()) {
				if (player.humanScore() < 14) outputText("were");
				else outputText("are");
				outputText(" a human, a champion, sent by your village as tribute to the demons under the guise of being a hero.");
			}
			else {
				if (player.humanScore() < 14) outputText("were");
				else outputText("are");
				outputText(" a human, a champion, sent by your village to defeat the demons. However just what is this place and who is she?");
			}
			outputText("\n\n\"<i>There haven't been many humans in Mareth, especially since the demons took over, so it’s likely that you are the first to make it here in a long time. If you seek salvation, I’m afraid the temple will not provide any, as the gods and their powers have long since left their altars. As for who I am, my name is Sapphire. I am the last guardian of this sacred ground, and the last line of defense against the fiends that desecrate this land.</i>\"");
			outputText("\n\nHer name seems to be somewhat appropriate, her eyes glowing with a faint, azure hue. As you ponder these details, the gargoyle turns her back to you, taking flight towards one of the pillars in the room.\n\n\"<i>You are welcome to visit this place as often as you see fit. However, I will be watching you.</i>\"\n\n<b>You can now visit the Temple of the Divines!</b>");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function repeatvisitintro():void {
			clearOutput();
			outputText("You decide to make a trip to the temple. However as soon as you enter the sacred ground, Sapphire screeches and takes flight, spear at the ready. Luckily, she calms down once she recognizes you, assuming a relaxed pose in the middle of the temple.");			
			outputText("\n\n\"<i>Well, hello there! Nice to see you again [name]. You're welcome here, as usual... So are you here to pray?");
			if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 99) outputText(" Or perhaps you're here for something more... mutually agreeable, instead?");
			outputText("</i>\"");
			if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 99) outputText(" She says, winking with a lusty smile.");
			mainmenu();
		}
		public function templemainmenu():void {
			clearOutput();
			outputText("What would you like to do in the temple?");
			mainmenu();
		}
		private function mainmenu():void {
			outputText("\n\nGargoyle Quest progress: " + flags[kFLAGS.GARGOYLE_QUEST] + "");
			outputText("\n\nTemple Repair progress: " + flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] + "");
			menu();
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] >= 1) {
				addButton(0, "Pray", PlayerPrayAtTemple).hint("Offer your prayer to one of the temple altar.");
				addButton(1, "Repair", TempleAltairsRebuildMenu).hint("Do reparation to the temple.");
			}
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_MARAE] == 1) {
				if (havingOrUsingBSwordOrExcalibur()) addButton(2, "Put Sword", puttingBSwordOrExcaliburOnAltair);
				if (player.statusEffectv2(StatusEffects.TempleOfTheDivineTracker) == 2) addButton(2, "Take Sword", takingExcaliburFromAltair);
				if (player.hasItem(consumables.P_PEARL, 1)) addButton(3, "Pearl", puttingPurePearlOnAltair);
				if (player.statusEffectv3(StatusEffects.TempleOfTheDivineTracker) == 2) addButton(3, "Pearl", takingPurePearlFromAltair);
			}
			addButton(5, "Sapphire", sapphiremenu).hint("Have a chat with the gargoyle.");
			if (flags[kFLAGS.ONYX_PATH] > 0) addButton(6, "" + flags[kFLAGS.ONYX_NAME] + "", krystalonyxmenu).hint("Have a sex with " + flags[kFLAGS.ONYX_NAME] + ".");
			addButton(7, "Basement", templeBasement).hint("Visit the temple basement.");
			addButton(14,"Leave", camp.returnToCampUseOneHour);
		}
		
		public function PlayerPrayAtTemple():void {
			clearOutput();
			if (anyOfAltairsRepaired()) {
				outputText("Would you like to pray and if yes to who?");
				menu();
				if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_MARAE] == 1 && !player.hasStatusEffect(StatusEffects.BlessingOfDivineMarae)) addButton(0, "Marae", PlayerPrayAtTempleMaraeAltair).hint("Pray to Marae for empowered white magic.");
				if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_TAOTH] == 1 && !player.hasStatusEffect(StatusEffects.BlessingOfDivineTaoth)) addButton(1, "Taoth", PlayerPrayAtTempleTaothAltair).hint("Pray the trickster god for an increase to your Agility, (if kitsune)kitsune powers (end of cut) and guile.");
				if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_FENRIR] == 1 && !player.hasStatusEffect(StatusEffects.BlessingOfDivineFenrir)) addButton(2, "Fenrir", PlayerPrayAtTempleFenrirAltair).hint("Pray to the god sharing your body for an increase to your might.");
				if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_FERA] == 1 && !player.hasStatusEffect(StatusEffects.BlessingOfDivineFera)) addButton(3, "Fera", PlayerPrayAtTempleFeraAltair).hint("Pray the fallen goddess Fera for an increase to your innuendo and resilience to desire.");
				addButton(14, "Back", templemainmenu);
			}
			else {
				outputText("You attempt a prayer to a god of Mareth. Sadly, if this place ever housed the god’s divine power, its ruined state no longer can contain it. It seems you will get no benefit from praying here until you repair the altars, with the god simply unable to contact you while the building is in this sinful state.\n\n");
				doNext(camp.returnToCampUseOneHour);
			}
		}
		private function anyOfAltairsRepaired():Boolean {
			return flags[kFLAGS.TEMPLE_OF_THE_DIVINE_MARAE] == 1 || flags[kFLAGS.TEMPLE_OF_THE_DIVINE_TAOTH] == 1 || flags[kFLAGS.TEMPLE_OF_THE_DIVINE_FENRIR] == 1 || flags[kFLAGS.TEMPLE_OF_THE_DIVINE_FERA] == 1;

		}
		public function loosingMaraeBlessing():void {
			if (player.hasStatusEffect(StatusEffects.BlessingOfDivineMarae)) {
				outputText("You chose to pray a different Deity losing the favor of the first to gain the bonus of the other.\n");
				outputText("<b>You lost the Blessing of Divine Agency - Marae</b>\n");
				player.removeStatusEffect(StatusEffects.BlessingOfDivineMarae);
			}
		}
		public function loosingTaothBlessing():void {
			if (player.hasStatusEffect(StatusEffects.BlessingOfDivineTaoth)) {
				outputText("You chose to pray a different Deity losing the favor of the first to gain the bonus of the other.\n");
				outputText("<b>You lost the Blessing of Divine Agency - Taoth</b>\n");
				var tempSpe:int = player.statusEffectv2(StatusEffects.BlessingOfDivineTaoth);
				player.removeStatusEffect(StatusEffects.BlessingOfDivineTaoth);
				dynStats("spe", -tempSpe);
			}
		}
		public function loosingFenrirBlessing():void {
			if (player.hasStatusEffect(StatusEffects.BlessingOfDivineFenrir)) {
				outputText("You chose to pray a different Deity losing the favor of the first to gain the bonus of the other.\n");
				outputText("<b>You lost the Blessing of Divine Agency - Fenrir</b>\n");
				var tempStr:int = player.statusEffectv2(StatusEffects.BlessingOfDivineFenrir);
				var tempTou:int = player.statusEffectv3(StatusEffects.BlessingOfDivineFenrir);
				player.removeStatusEffect(StatusEffects.BlessingOfDivineFenrir);
				dynStats("str", -tempStr);
				dynStats("tou", -tempTou);
			}
		}
		public function loosingFeraBlessing():void {
			if (player.hasStatusEffect(StatusEffects.BlessingOfDivineFera)) {
				outputText("You chose to pray a different Deity losing the favor of the first to gain the bonus of the other.\n");
				outputText("<b>You lost the Blessing of Divine Agency - Fera</b>\n");
				player.removeStatusEffect(StatusEffects.BlessingOfDivineFera);
			}
		}
		public function loosing__Blessing():void {
			
		}
		public function PlayerPrayAtTempleMaraeAltair():void {
			clearOutput();
			outputText("You pray to Marae. As you speak your prayer, you feel the warmth of the goddess' serenity flow through you, her motherly love for this land swaddling you; healing your wounds and washing away corrupt thoughts. You also feel the blessing of the deity empowering your white magic.\n");
			loosingTaothBlessing();
			loosingFenrirBlessing();
			loosingFeraBlessing();
			outputText("<b>You gained the Blessing of Divine Agency - Marae for 7 days</b>");
			var blessingPower:Number = 0;
			blessingPower += 0.1;
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] >= 6) blessingPower += 0.1;
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] >= 8) blessingPower += 0.05;
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] >= 18) blessingPower += 0.05;
			if (player.statusEffectv2(StatusEffects.TempleOfTheDivineTracker) == 2) blessingPower += 0.05;
			if (player.statusEffectv3(StatusEffects.TempleOfTheDivineTracker) == 2) blessingPower += 0.05;
			player.createStatusEffect(StatusEffects.BlessingOfDivineMarae, 169, blessingPower, 0, 0);
			if (player.HP < player.maxHP()) player.HP = player.maxHP();
			var purifyingPower:Number = 0;
			purifyingPower += 10;
			if (player.statusEffectv3(StatusEffects.TempleOfTheDivineTracker) == 2) purifyingPower += 5;
			dynStats("cor", -purifyingPower);
			doNext(camp.returnToCampUseOneHour);
		}
		public function PlayerPrayAtTempleTaothAltair():void {
			clearOutput();
			outputText("You pray to the trickster patron Taoth. As you word out your prayer, suggestions of pranks flow into your mind, both playful and troublemaking, as you feel the laughter of the god cheer you up, healing your wounds and washing away corrupt thoughts. You also feel the blessing of the deity empowering your agility.\n");
			loosingMaraeBlessing();
			loosingFenrirBlessing();
			loosingFeraBlessing();
			outputText("<b>You gained the Blessing of Divine Agency - Taoth for 7 days</b>");
			var temp1:Number = 0;
			var tempSpe:Number = 0;
			temp1 += player.spe * 0.1;
			temp1 = Math.round(temp1);
			player.createStatusEffect(StatusEffects.BlessingOfDivineTaoth, 169, 0, 0, 0);
			tempSpe = temp1;
			player.changeStatusValue(StatusEffects.BlessingOfDivineTaoth,2,tempSpe);
			mainView.statsView.showStatUp('spe');
			player.spe += player.statusEffectv2(StatusEffects.BlessingOfDivineTaoth);
			if (player.HP < player.maxHP()) player.HP = player.maxHP();
			dynStats("cor", -10);
			statScreenRefresh();
			doNext(camp.returnToCampUseOneHour);
		}
		public function PlayerPrayAtTempleFenrirAltair():void {
			clearOutput();
			outputText("You pray to yourself. Truthfully, it's almost funny how you rebuilt your own altar just so you could be your own follower, but still, the altar functions as a catalyst for your power; and catalyze it, it does. As you word out your prayer, you feel the cold countenance of the magic of the god of winter filling you, healing your wounds and washing away corrupt thoughts. You also feel your boons empowering your might.\n");
			loosingMaraeBlessing();
			loosingTaothBlessing();
			loosingFeraBlessing();
			outputText("<b>You gained the Blessing of Divine Agency - Fenrir for 7 days</b>");
			var temp1:Number = 0;
			var temp2:Number = 0;
			var tempStr:Number = 0;
			var tempTou:Number = 0;
			temp1 += player.str * 0.1;
			temp2 += player.tou * 0.1;
			temp1 = Math.round(temp1);
			temp2 = Math.round(temp2);
			player.createStatusEffect(StatusEffects.BlessingOfDivineFenrir, 169, 0, 0, 0);
			tempStr = temp1;
			tempTou = temp2;
			player.changeStatusValue(StatusEffects.BlessingOfDivineFenrir,2,tempStr);
			player.changeStatusValue(StatusEffects.BlessingOfDivineFenrir,3,tempTou);
			mainView.statsView.showStatUp('str');
			mainView.statsView.showStatUp('tou');
			player.str += player.statusEffectv2(StatusEffects.BlessingOfDivineFenrir);
			player.tou += player.statusEffectv3(StatusEffects.BlessingOfDivineFenrir);
			if (player.HP < player.maxHP()) player.HP = player.maxHP();
			dynStats("cor", -10);
			statScreenRefresh();
			doNext(camp.returnToCampUseOneHour);
		}
		public function PlayerPrayAtTempleFeraAltair():void {
			clearOutput();
			outputText("You pray to the huntress patron Fera. As you word out your prayer, lewd fantasies of all kind flow into your mind. Fera delicious caress pleases you, healing your wounds and washing away your pure thoughts. You also feel the blessing of the deity empowering your “talents”.\n");
			loosingMaraeBlessing();
			loosingTaothBlessing();
			loosingFenrirBlessing();
			outputText("<b>You gained the Blessing of Divine Agency - Fera for 7 days</b>");
			player.createStatusEffect(StatusEffects.BlessingOfDivineFera, 169, 0, 0, 0);
			if (player.HP < player.maxHP()) player.HP = player.maxHP();
			dynStats("cor", 10);
			doNext(camp.returnToCampUseOneHour);
		}
		public function PlayerPrayAtTemple__Altair():void {
			clearOutput();
			outputText("I think Lia would write here nice text to let pick which Altair to use for prayer.\n");
			loosingMaraeBlessing();
			loosingTaothBlessing();
			loosingFenrirBlessing();
			loosingFeraBlessing();
			outputText("<b>You gained the Blessing of Divine Agency - __ for 7 days</b>");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function TempleAltairsRebuildMenu():void {
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] >= 2) {
				clearOutput();
				outputText("Would you like to repair something in the temple?\n\n");
				SceneLib.camp.cabinProgress.checkMaterials();
				menu();
				addButton(0, "Altars", rebuildGodsAltairs).hint("Repair the altar.");
				if ((flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] == 3 || flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] == 4) && flags[kFLAGS.TEMPLE_OF_THE_DIVINE_MARAE] == 1) {
					if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 150) addButton(1, "Statue of Marae", rebuildStatueOfMarae).hint("Repair the statue.");
					else addButtonDisabled(1, "Statue of Marae", "You not have enough stones.");
				}
				if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] >= 5 && flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] < 7) {
					if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 500) addButton(2, "Gargoyles", repairGargoylesOnTheWalls).hint("Repair some of the decorative gargoyles.");
					else addButtonDisabled(2, "Gargoyles", "You not have enough stones.");
				}
				if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] >= 7 && flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] < 17) {
					if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 50 && flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 10) addButton(3, "Prayer Bench", makeNewPrayerBenches).hint("Repair some of the temple banches.");
					else addButtonDisabled(3, "Prayer Bench", "You not have enough wood or/and nails.");
				}
				addButton(13, "CheckProgress", currentStateOfTemple).hint("I think I must ask Lia for fancy tooltip here.");
				addButton(14, "Back", templemainmenu);
			}
			else {
				clearOutput();
				outputText("You take your time to look the place over. After a few moments, you conclude that, while restoring it back to its former glory isn't impossible, it will be a long and arduous task. To make it back into the temple it was in its glory days, you estimate that you will need to repair the altars, all of the stone statues including the one depicting Marae, and the benches which should then make the temple fully functional again as a place of worship.");
				flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS]++;
				doNext(camp.returnToCampUseOneHour);
			}
		}
		public function rebuildGodsAltairs():void {
			menu();
			if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1 && flags[kFLAGS.TEMPLE_OF_THE_DIVINE_MARAE] < 1) {
				if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 50) addButton(0, "Marae", rebuildMaraeAltair);
				else addButtonDisabled(0, "Marae", "You not have enough stones.");
			}
			if (flags[kFLAGS.URTA_QUEST_STATUS] == 1 && flags[kFLAGS.TEMPLE_OF_THE_DIVINE_TAOTH] < 1) {
				if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 50) addButton(1, "Taoth", rebuildTaothAltair);
				else addButtonDisabled(1, "Taoth", "You not have enough stones.");
			}
			if (player.hasKeyItem("Fenrir Collar") >= 0 && flags[kFLAGS.TEMPLE_OF_THE_DIVINE_FENRIR] < 1) {
				if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 50) addButton(2, "Fenrir", rebuildFenrirAltair);
				else addButtonDisabled(2, "Fenrir", "You not have enough stones.");
			}
			if (flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE] != 0 && player.cor >= 80 && flags[kFLAGS.TEMPLE_OF_THE_DIVINE_FERA] < 1) {
				if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 100) addButton(3, "Fera", rebuildFeraAltair);
				else addButtonDisabled(3, "Fera", "You not have enough stones.");
			}
			//addButtonDisabled(4, "???", "Cummin Sooooon!");
			addButton(14, "Back", TempleAltairsRebuildMenu);
		}
		public function rebuildMaraeAltair():void {
			clearOutput();
			outputText("You work for 8 hours, sculpting stone and repairing the altar of Marae. By the time you're done you can feel divine power amass around it anew.");
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 50;
			flags[kFLAGS.TEMPLE_OF_THE_DIVINE_MARAE] = 1;
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] < 3) flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS]++;
			doNext(camp.returnToCampUseEightHours);
		}
		public function rebuildTaothAltair():void {
			clearOutput();
			outputText("You work for 8 hours, sculpting stone and repairing the altar of Taoth. By the time you're done you can feel divine power amass around it anew.");
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 50;
			flags[kFLAGS.TEMPLE_OF_THE_DIVINE_TAOTH] = 1;
			doNext(camp.returnToCampUseEightHours);
		}
		public function rebuildFenrirAltair():void {
			clearOutput();
			outputText("You work for 8 hours, sculpting stone and repairing the altar of Fenrir. By the time you're done you can feel a cold chilling aura amass around it. Was that really such a good idea?");
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 50;
			flags[kFLAGS.TEMPLE_OF_THE_DIVINE_FENRIR] = 1;
			doNext(camp.returnToCampUseEightHours);
		}
		public function rebuildFeraAltair():void {
			clearOutput();
			outputText("You work for the entire day sculpting stone and repairing the altar of Fera. By the time you're done you can feel divine power albeit tainted amass around it anew.");
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 100;
			flags[kFLAGS.TEMPLE_OF_THE_DIVINE_FERA] = 1;
			doNext(camp.returnToCampUseEightHours);
		}/*
		public function rebuild__Altair():void {
			clearOutput();
			outputText("The Altar of Marae ");
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 50;
			flags[kFLAGS.TEMPLE_OF_THE_DIVINE_] = 1;
			doNext(camp.returnToCampUseEightHours);
		}*/
		public function rebuildStatueOfMarae():void {
			clearOutput();
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] < 4) outputText("You work for the entire day sculpting stone and repairing the statue of Marae. It looks slightly better but it is far from finished.");
			else outputText("You work for the entire day sculpting stone and repairing the statue of Marae. By the time you're done you can feel divine power radiate from it empowering the entire temple.");
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 150;
			flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS]++;
			doNext(camp.returnToCampUseEightHours);
		}
		public function repairGargoylesOnTheWalls():void {
			clearOutput();
			outputText("You work for the entire day sculpting stone. By the time you're done a set of well carved statue decorate the walls again.");
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 500;
			flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS]++;
			doNext(camp.returnToCampUseEightHours);
		}
		public function makeNewPrayerBenches():void {
			clearOutput();
			outputText("You work for the entire day carving wood and hammering nails. By the time you're done the temple now has a set of brand new prayer bench.");
			if (player.hasStatusEffect(StatusEffects.TempleOfTheDivineTracker)) player.addStatusValue(StatusEffects.TempleOfTheDivineTracker,1,2);
			else player.createStatusEffect(StatusEffects.TempleOfTheDivineTracker, 2, 0, 0, 0);
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 50;
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 10;
			flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS]++;
			doNext(camp.returnToCampUseEightHours);
		}
		
		public function currentStateOfTemple():void {
			clearOutput();
			outputText("The Altar of Marae ");
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_MARAE] < 1) outputText("is broken, a large fissure running along its center. Crude graffiti litters the once pure stone with obscenities.");
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_MARAE] == 1) outputText("shines, illuminated by a ray of light as if beckoning the faithful. A single white flower trails its way up one side, assuring her divine presence is there.");
			outputText("\n\nTo the left of Marae's Altar, the Altar of Taoth");
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_TAOTH] < 1) outputText(" lies shattered into pieces. The trickster god can not even be visualised from the rubble that once made up his effigy.");
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_TAOTH] == 1) outputText(", the trickster god, has a mesmerising outlook, his effigy making a mocking smile. You swear you can hear faint laughter coming from its direction.");
			outputText("\n\nTo your right is the ");
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_FENRIR] < 1) outputText("damaged Altar of Fenrir. Even in this state its aura is ominous, promising eventual demise to everyone.You almost dare not approach, lest your journey ends here.");
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_FENRIR] == 1) outputText("Altar of Fenrir, an ominous aura radiates from it as it sits dark and foreboding.");
			outputText("\n\nOn the side is the ");
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_FENRIR] < 1) outputText("broken altar of Fera. You believe it was damaged way before the demons came in, likely by the priesthood tending the temple.");
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_FENRIR] == 1) outputText("Altar of Fera. An aura of depraved lust rise from it, inviting you to unknown pleasure. This altar radiate a clearly demonic aura and dims the sanctity of the temple like an idol.");
			outputText("\n\nMarae's statue ");
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] < 5) outputText("lies on the ground, its head shattered to pieces");
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] >= 5) outputText("in the background awaits the worshippers with its serene and compassionate expression");
			outputText(". Lining both walls");
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] < 7) outputText(" are the destroyed remains of the many gargoyles who fought to defend this place. Sadly, of all the guardians, only Sapphire remains now.");
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] >= 7) {
				outputText(", many decorative gargoyles are displayed.");
				if (flags[kFLAGS.ONYX_PATH] < 1) outputText(" While Sapphire is the last living stony guardian of the temple, this still gives off the illusion of a platoon of guardians watching faithfully over this divine place.");
				if (player.isGargoyle()) outputText(" Your own pedestal stands right next to Sapphire's, allowing you to keep close to her when you need to rest (using your pedestal allows you to sleep with Sapphire if your relation is high enough).");
				if (flags[kFLAGS.ONYX_PATH] > 0) {
					outputText(" On the opposite side stands " + flags[kFLAGS.ONYX_NAME] + "'s pedestal. ");
					if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("She");
					else outputText("He");
					outputText(" is looking at you expectantly.");
				}
			}
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] >= 8) {
				outputText(" There are " + player.statusEffectv1(StatusEffects.TempleOfTheDivineTracker) + " benches in the temple for the worshipers to sit upon.");
			}
			doNext(TempleAltairsRebuildMenu);
		}
		
		public function puttingBSwordOrExcaliburOnAltair():void {
			clearOutput();
			if (player.weapon == weapons.B_SWORD || player.hasItem(weapons.B_SWORD, 1)) {
				outputText("You feel a weird resonance engulf you, as the power of the Altar of Marae echos with an item on your person.\n\n");
				outputText("Pulling out the Beautiful Sword, you notice the weapon is now shining with a dim white light. Curious, you place the weapon on the altar, and watch as the sword surges with power, the light seeming to be absorbed into the blade. The altar feels way more potent with the sword resting upon it. However, it occurs to you, such a weapon likely is a powerful artifact, and that as such, it could be useful in your battles against the demons.");
				if (player.weapon == weapons.B_SWORD) player.setWeapon(WeaponLib.FISTS);
				else player.destroyItems(weapons.B_SWORD, 1);
				if (player.hasStatusEffect(StatusEffects.TempleOfTheDivineTracker)) player.addStatusValue(StatusEffects.TempleOfTheDivineTracker,2,2);
				else player.createStatusEffect(StatusEffects.TempleOfTheDivineTracker, 0, 2, 0, 0);
			}
			else {
				outputText("The altar radiates with increased potency as the sword is put back on display.");
				if (player.weapon == weapons.EXCALIB) player.setWeapon(WeaponLib.FISTS);
				else player.destroyItems(weapons.EXCALIB, 1);
				player.addStatusValue(StatusEffects.TempleOfTheDivineTracker,2,1);
			}
			doNext(templemainmenu);
		}
		public function takingExcaliburFromAltair():void {
			clearOutput();
			outputText("You feel the power of the altar diminishing, however the weapon is stronger than ever and likely ready for its primary use, demon slaying.\n\n");
			player.addStatusValue(StatusEffects.TempleOfTheDivineTracker,2,-1);
			inventory.takeItem(weapons.EXCALIB, templemainmenu);
		}
		private function havingOrUsingBSwordOrExcalibur():Boolean {
			return player.weapon == weapons.B_SWORD || player.weapon == weapons.EXCALIB || player.hasItem(weapons.B_SWORD, 1) || player.hasItem(weapons.EXCALIB, 1);

		}
		public function puttingPurePearlOnAltair():void {
			clearOutput();
			outputText("You pull out the Pure Pearl Marae gave you from your bag. Such a relic should rest in holy ground, and you indeed notice a slot in the altar for an orb like object such as the pearl. Will you place the Pure Pearl on the altar?");
			menu();
			addButton(0, "No", puttingPurePearlOnAltairNo);
			addButton(1, "Yes", puttingPurePearlOnAltairYes);
		}
		public function puttingPurePearlOnAltairYes():void {
			outputText("\n\nAs you place the pearl on the altar, you feel the holy power radiating from the temple increase a step further. The place practically radiates purity now. A horde of imps, attracted by the aura emanating from the temple, attempts to enter the building with the intention to put out the offending light. You prepare yourself for a fight, but end up watching in stunned silence as the corrupt beings catch fire and are reduced to ashes as soon as they fly inside the temple’s boundaries. It would seem the temple divine protections have increased.");
			player.destroyItems(consumables.P_PEARL, 1);
			if (player.hasStatusEffect(StatusEffects.TempleOfTheDivineTracker)) player.addStatusValue(StatusEffects.TempleOfTheDivineTracker,3,2);
			else player.createStatusEffect(StatusEffects.TempleOfTheDivineTracker, 0, 0, 2, 0);
			doNext(templemainmenu);
		}
		public function puttingPurePearlOnAltairNo():void {
			outputText("\n\nWhile it seems a good idea at first, you think you would prefer to keep the pearl for now.");
			doNext(templemainmenu);
		}
		public function takingPurePearlFromAltair():void {
			clearOutput();
			outputText("You recover the pearl from the Altar the temple power dimming slightly.");
			player.addStatusValue(StatusEffects.TempleOfTheDivineTracker,3,-2);
			inventory.takeItem(consumables.P_PEARL, templemainmenu);
		}
		
		public function sapphiremenu():void {
			clearOutput();
			outputText("You admit that you were actually looking for her, a response which she seems happy about, as she casually sits next to you and starts conversing.\n\n");
			outputText("\n\n\"<i>So [name] what did you want to talk about?</i>\"");
			menu();
			addButton(0,"This place", TalkThisPlace).hint("Learn about the temple.");
			addButton(1,"Her", TalkHer).hint("How about her?");
			if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 5) addButton(2,"Sex", TalkSex).hint("Have some sweet time with her.");
			addButton(4,"Back", templemainmenu);
		}
		public function TalkThisPlace():void {
			clearOutput();
			outputText(" You admit to being curious and Sapphire is glad to tell you about the history of the building. She starts to ");
			if (flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] >= 1) {
				outputText("explain again.\n\n");
			}
			else {
				outputText("explain.\n\n");
				flags[kFLAGS.TEMPLE_OF_THE_DIVINE_PROGRESS] = 1;
			}
			outputText("\"<i>This is the Temple of the Divines. While there are many churches and holy sites across Mareth, this one is the most important of them all. It was built by mortals for the worship of not one deity, but instead all the deities of Mareth. It serves as a neutral ground for everyone, including rival cults.</i>\"\n\n");
			outputText("Curious, you ask about the broken altars and the shattered gargoyles littering the floor. Why is the temple in ruins?\n\n");
			outputText("Sapphire's expression switches to one of anger.\n\n");
			outputText("\"<i>That is the demons doing... This temple is very close to the area were they first started appearing. Their queen's attention was drawn to this place and the first thing they did was to attempt to destroy and defile it. For the demons, gods are not beings to worship but rather huge sources of power, only good for corruption and then harvesting. Unfortunately, a god is only as strong as the collective belief of his or her adherents. The most direct way to weaken a deity is by attacking his or her followers and desecrating any consecrated altars.");
			outputText(" I managed to slay the fiends who invaded the place, but not before they did great damage to the temple; so much damage, that it is no longer able to house any divine power. I would repair the damage myself, but sadly as the sole guardian and caretaker I can't leave my post to gather materials like stone and wood, lest the demons use that opportunity to destroy what's left of the temple. Maybe if you were to bring materials and repair the temple's many features, the link to the various gods of Mareth would be restored.</i>\"\n\n");
			outputText("Repairing the temple eh? Well thats one thing you could do. You thank her for her time and proceed to head back to camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		public function TalkHer():void {
			clearOutput();
			if (flags[kFLAGS.SAPPHIRE_TALKS] == 2 || flags[kFLAGS.SAPPHIRE_TALKS] == 6) {
				outputText("Now that some time has passed you ask her if she is ready to tell you more about the events she foreshadowed in your previous discussion.\n\n");
				outputText("\"<i>It pains me to even think about the events of that day, the day the demons appeared. They poured into the cities below us like a tidal wave, devouring souls and corrupting everything in their path. Eventually they began climbing the mountain, and we knew they would be on our doorstep within hours. To prevent them from destroying this holy ground we devised a plan. No matter what the cost to us, the temple had to be protected. ");
				outputText("As such one by one, we sacrificed ourselves in a ritual to create from us everlasting guardians. I was the last one to be put on the altar. They finished the ritual just as the demons started pouring in. Many desperate enchantments and prayers were put into the creation of each of us, hoping to create a combination by chance that would correctly dispatch the demons. The other gargoyles didn't receive the protections required to face the demons as I did, thus they were destroyed one by one. ");
				outputText("Amidst the chaos, the altars were damaged extensively and rendered useless. As I kept killing more and more of them, they retreated. Satisfied with their dirty work, they just ran away, like the cowards they are, to prevent further casualties.</i>\"\n\n");
				outputText("What of her? Why did the demons spare her?\n\n");
				outputText("\"<i>Their work was done. The numerous altars in the church were no longer able to channel divine powers and the abbot was captured alive and brought inside the hell hole that is now Lethice's stronghold. I think they simply left because they had no interest in getting slaughtered by a being they could not corrupt or destroy. With everyone gone or dead, it feels so lonely in this place now.</i>\"\n\n");
				outputText("You thank her for her time and walk back to camp.");
				flags[kFLAGS.SAPPHIRE_TALKS]++;
			}
			if (flags[kFLAGS.SAPPHIRE_TALKS] == 1 || flags[kFLAGS.SAPPHIRE_TALKS] == 5) {
				outputText("Didn't she say that she was raised in the temple? Last time you checked Gargoyles were magically constructed creatures that do not age or die. How could she have been raised in the first place?\n\n");
				outputText("\"<i>This isn’t how I used to be. I was once of flesh and blood just like you. I was born in the former capital city which serves as the main demon base now. My mother was a priestess at the temple, so naturally I became one as well . My childhood was mostly spent learning holy texts and chanting in the chorus. I don't think it was a waste, these lands used to be beautiful before the demon outbreak. At 16, I was among many selected to work directly in the temple of the divine. It was a great privilege. ");
				outputText("I prayed, tended to the temple, and worked under the abbot for many years as a nun. I would have continued to do so had the demons not come. In the end I couldn’t save anyone... I'm sorry, I don't feel like talking about this any further, at least for now. Please, leave me be.</i>\"\n\n");
				outputText("You excuse yourself and leave, returning back to your camp.");
				flags[kFLAGS.SAPPHIRE_TALKS]++;
			}
			if (flags[kFLAGS.SAPPHIRE_TALKS] == 0 || flags[kFLAGS.SAPPHIRE_TALKS] == 4) {
				outputText("You're curious about her story and decide to ask her.\n\n");
				outputText("\"<i>My story? Well that's nothing special. I have been guarding this place for years, even before the demons came. I was raised here in this temple. I have always had a fascination with gods, Marae in particular. It was only natural for me to become a priestess of her cult. In recent years, I mostly dealt with the occasional thieves and demons that somehow manage to break through the ward. Even then, only a very powerful opponent could manage that.</i>\"\n\n");
				outputText("You ask her how she is able to contend with demons, especially the most dangerous ones.\n\n");
				outputText("\"<i>I understand that my body looks like something more fitting for a whore than a chaste being. My sexual desire is next to zero. As far as I know, I’m as cold as the stone I'm made from. Therefore, demons have a very difficult time getting me to even start being aroused. As arousal and black magic is their main weapon, I’m pretty much the worst opponent they could encounter.</i>\"\n\n");
				outputText("You thank her for her time and proceed to head back to your camp.");
				flags[kFLAGS.SAPPHIRE_TALKS]++;
			}
			sapphireAffection(2);
			if (flags[kFLAGS.SAPPHIRE_TALKS] > 6) flags[kFLAGS.SAPPHIRE_TALKS] = 4;
			if (flags[kFLAGS.SAPPHIRE_TALKS] == 3) flags[kFLAGS.SAPPHIRE_TALKS]++;
			doNext(camp.returnToCampUseOneHour);
		}
		public function TalkSex():void {
			clearOutput();
			if (flags[kFLAGS.SAPPHIRE_SEX] == 1) {
				outputText("Sapphire looks at you expectantly her tail agitated by the excitement of potential physical release.\n\n");
				outputText("\"<i>Feeling antsy? How would you like us to do it then?");
				if (player.isGargoyle()) outputText(" There’s even running water if we ever need... something slippery.");
				outputText("</i>\"\n\n");
				menu();
				if (player.lust > 33) {
					if (player.isGargoyle() && player.hasVagina()) addButton(0,"Gargoyle double tailfuck", SapphireGargoyleDoubleTailfuck).hint("Let's put these tails to use.");
					if ((player.isGargoyle() || player.isNaga() || player.tailType == Tail.LIZARD || player.tailType == Tail.DRACONIC || player.tailType == Tail.SALAMANDER) && flags[kFLAGS.ONYX_PATH] > 0) addButton(1,"Triple Tail Ouroboros", SapphireTripleTailOuroboros).hint("How about you all uses your tails to get eachother off?");
					addButton(2,"MutualMasturbarion", SapphireMutualMasturbation).hint("Help both you and her soothe that itch.");
					if (player.hasCock()) addButton(3,"FuckHer", SapphireFuckHer).hint("Let's plunder that stony cavern of hers.");
				}
				addButton(4,"Back", sapphiremenu);
			}
			else {
				outputText("She said that she is sexually dead. That’s something very rare on Mareth, considering the number of lunatics who spend their day fornicating even in the most pure pockets of the world.\n\n");
				outputText("\"<i>Don’t think of it that way, I never said I couldn't feel it, just that my desires are deadened. I don't actually feel the need at all, although, like just anyone, I can have a good time. My body won't feel it unless I desire it. And since i've never been in love before...</i>\"\n\n");
				outputText("Oh, so she can actually enjoy sex? What about you? Would she like to empty many years of sexual frustration on you?\n\n");
				outputText("\"<i>Look I haven’t played with myself in several years and unless you... wait what the hell are you doing!</i>\"\n\n");
				outputText("While she is distracted, you surprise her with a hug and start kissing her. Weirdly enough Sapphire doesn't seem to hate it, actually she reacts quite favorably to it, only breaking the kiss several seconds later. Perhaps she just needs a reminder of how it can feel?\n\n");
				outputText("\"<i>That... was not something I expected. I guess it's the result of many years living alone in this temple. I'm a person too, it’s just that I had forgotten how sweet it feels to indulge into a kiss let alone love. Maybe it's the fact that you’re the first living person to come here, listen to me and actually even care so much about my problems. Can we... can we continue further? I would like to...</i>\"\n\n");
				outputText("You silence her, placing your finger to her stone lips, pulling her to the cold stone floor, and saying \"<i>Shhh it will be alright...</i>\" as you slowly lower your other hand down to the former priestess’ pussy. She coos as you slowly insert a finger inside and gently massage her.\n\n");
				outputText("\"<i>Aaaah! It's been such a long time since I...I didn't get to enjoy.. such simple pleasures... please don’t stop!</i>\"\n\n");
				outputText("You proceed to masturbate her for several minutes. Her stone body hugging you tightly all the while, as she proceeds to get you off in the same way. The both of you toy with each others body until finally you reach your peak and climax, soaking the ground and your gargoyle partner with your fluids.\n\n");
				outputText("Sapphire would blush if she could however she’s frozen in a post orgasm rigor mortis, her expression seems to be as close to happiness as one can be. After a minute she recover mobility.\n\n");
				outputText("\"<i>Thanks for letting me discover again what it is to be a woman. Please come back more often, it feels empty in the temple without you around.</i>\"\n\n");
				outputText("You smile, leaving her embrace as you promise to come back and visit.\n\n");
				flags[kFLAGS.SAPPHIRE_SEX] = 1;
				sapphireAffection(5);
				doNext(camp.returnToCampUseOneHour);
			}
		}
		
		public function SapphireGargoyleDoubleTailfuck():void {
			clearOutput();
			outputText("You check Sapphire’s tail then look at yours. An idea sparks in your mind as you tell Sapphire to get on all fours.\n\n");
			outputText("\"<i>I don't know what’s on your mind but I'm very curious to try it now.</i>\"\n\n");
			outputText("She complies and you go to her backside, positioning yourself to have your [ass] facing hers. You tell her to entwine her tail around yours, then insert her tip in your pussy. She gets the hint as you proceed to do the same with hers. Now, having both of your tail tips in each others pussies, you tell her to move forward and backward. She yelps in surprise as you do the same, both of your tails sliding in and out of each other's pussies at a decent rhythm. Gosh truth be told you are enjoying your tail just as much as your pussy right now. It’s like discovering you had a ");
			if (player.gender == 2) outputText("second");
			if (player.gender == 3) outputText("third");
			outputText(" sexual organ all along. It feels very similar to a cock in a way");
			if (player.gender == 3) outputText(" maybe even better then a cock");
			outputText(", at this rate you will develop a tail fetish.\n\n");
			outputText("You fuck each other passionately, drawing closer then moving apart, making the both of you moan in delight at this intense mutual penetration. This is like fucking and getting fucked at the same time… simply perfect. By all means you don’t know anymore whether you will cum from your tail or from your pussy.\n\n");
			outputText("After a fair hour of constant sex, the pair of you finally orgasm and you both fall on the ground tails still tangled up and petrified in pleasure. You wake up a few minutes later tail still in each other pussy and completely satisfied. You get back your gear and wave a goodbye to Sapphire as you head back to camp.\n\n");
			sapphireAffection(5);
			player.sexReward("Default","Default",true,false);
			doNext(camp.returnToCampUseOneHour);
		}
		public function SapphireTripleTailOuroboros():void {
			clearOutput();
			outputText("You think it over then remember about " + flags[kFLAGS.ONYX_NAME] + " being there too. The third gargoyle must be starving for sex. Unable to decide which one you want to fuck or get fucked by you propose the lot of you tail fuck each other, something to which your two stony mates are more then happy to agree. You all sit in a perfect triangle, positioning your tails appropriately and smiling in anticipation for a threesome that will go down in history.\n\n");
			outputText("You begin by kissing Sapphire then exchanging with " + flags[kFLAGS.ONYX_NAME] + " the tree of you taking turns in order to feel each other's properly. You are not surprised to discover that out of the three of you " + flags[kFLAGS.ONYX_NAME] + " is the best kisser. Once you all are suitably aroused you playfully insert your tail in Sapphire’s pussy as she position hers over ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("Krystal’s waiting cunt");
			else outputText("Onyx’s rock hard dick");
			outputText(". Not to be left unstimulated you welcome " + flags[kFLAGS.ONYX_NAME] + "’s tail ");
			if (player.gender == 2 || player.gender == 3) outputText("in your ready snatch");
			if (player.gender == 3) outputText(" and ");
			if (player.gender == 1 || player.gender == 3) outputText("around your throbbing [cock]");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText(". Krystal giggle");
			else outputText(". Onyx chuckle");
			outputText(" at the anticipation of ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" privates being played with.\n\n\"<i>Oh [name] this is gunna be so much fun!</i>\"\n\n");
			outputText("You count to ten and the three of you begin tail teasing each other, making a chorus of moans sapphire tigh vagina gripping your tail.\n\n");
			outputText("\"<i>Oh my gosh [name]!!... this feeling is aaahh...Aaaaaaahhhn!!! Fuck meee fuck my brain out!</i>\"\n\n");
			outputText("This was an understatement, Sapphire’s cunt is pretty much eating your tail and although it does not produce any form of lubrication, her rough stone skin slides perfectly against yours, the friction creating heat ");
			if (player.isGargoyle()) outputText("and sparks ");
			outputText("inside her vagina like a wet stone and making you gasp at the caressing of your tail tip. Gosh your tail is feeling so good, you wouldn’t even mind it if the rest of your body was left unattended!");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText(" Krystal seems to be locked in a blissful dreamy expression of her own");
			else outputText(" Onyx seems to enjoy the feeling of his cock");
			outputText(" as ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			if (player.gender == 1 || player.gender == 3) outputText(" jerks");
			if (player.gender == 3) outputText(" and");
			if (player.gender == 2 || player.gender == 3) outputText(" penetrates");
			outputText(" you masterfully. Your ");
			if (player.gender == 2 || player.gender == 3) outputText("pussy is alight with pleasure");
			if (player.gender == 3) outputText(" and your ");
			if (player.gender == 1 || player.gender == 3) {
				outputText("rock hard cock is pulsing from ");
				if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("his");
				outputText(" ministration");
			}
			outputText(" making you moan in complete bliss. Truth be told, you don’t know how long you will hold out until you reach your peak and lose control. Your tail is not any less sensible than your ");
			if (player.gender == 2 || player.gender == 3) outputText("pussy");
			if (player.gender == 3) outputText("or your ");
			if (player.gender == 1 || player.gender == 3) outputText("cock");
			outputText(", it quakes in Sapphire hot cunt from the constant pleasure of penetration and touch, squirming and feeling for Sapphire every hot spots just like a cock, only increasing Sapphire own delight. The tempo accelerate as the sound of rock grinding against rock and heavy panting assisted with moans fills the temple. Soon the three of you lock in a silent scream as you all orgasm together, ");
			if (!player.isGargoyle()) outputText("Sapphire and " + flags[kFLAGS.ONYX_NAME] + " ");
			outputText("freezing in the characteristic immobilism related to a gargoyle's stone form as you all lose consciousness from the intense fuck. ");
			if (player.isGargoyle()) {
				outputText("Anybody finding the three of you right now would think the artists of the temple were serious perverts carving a trio of statues fucking");
				if (flags[kFLAGS.ONYX_GENDER] == 2 || flags[kFLAGS.ONYX_GENDER] == 3 || player.hasCock()) outputText("(if a male present) and jerking");
				outputText(" each other.\n\n");
			}
			else outputText("You regain your sense faster than your two stony friends. Mainly because you can’t petrify from pleasure like they do.\n\n");
			if (player.isGargoyle()) {
				outputText("The three of you come to way later, somewhat aware of having frozen for several hours. You proceed to break out from the other two as they do the same, still smiling after this incident. Sapphire and " + flags[kFLAGS.ONYX_NAME] + " nod as you propose that you should have that kind of bonding more often.\n\n");
				sapphireAffection(5);
				player.sexReward("Default","Default",true,false);
				doNext(camp.returnToCampUseFourHours);
			}
			else {
				outputText("You proceed to break out from the other two still locked in their stone form. Sapphire and " + flags[kFLAGS.ONYX_NAME] + " are still frozen in time but you guess from their looks that they will want to do this again.\n\n");
				sapphireAffection(5);
				player.sexReward("Default","Default",true,false);
				doNext(camp.returnToCampUseOneHour);
			}
		}
		public function SapphireMutualMasturbation():void {
			clearOutput();
			outputText("Unable to decide on a position you decide to help the temple guardian blow some steam by fingering her. The both of you sit down next to each other and you open the games by kissing Sapphire.");
			if (player.isGargoyle()) outputText(" While neither of you actually have Saliva the feeling of her stone rugged tongue against yours is quite good.");
			else outputText(" Her mouth lacking fluids is a weird experience at first but once her tongue is slick with your saliva it starts to feel like anyone else’s, albeit her tongue is slightly longer.");
			outputText("\n\n\"<i>I didn’t get to kiss anyone until you came so I never had any idea it felt this nice. Would you...</i>\"\n\n");
			outputText("You cut her short by inserting your fingers in her stone cunt making her moan appreciatively from your ministration. You notice her tail moving toward your nethers as she rewards you by");
			if (player.gender == 1 || player.gender == 3) outputText(" wrapping her long appendage around your [cock]");
			if (player.gender == 3) outputText(" and with the rest of her length");
			if (player.gender == 2 || player.gender == 3) outputText(" ramming her long prehensile but flattened macetail into your [cunt]");
			outputText(", slowly masturbating you to satisfaction. Her tail is oddly quite good at");
			if (player.gender == 2 || player.gender == 3) outputText(" hitting all of your spot");
			if (player.gender == 3) outputText(" and");
			if (player.gender == 1 || player.gender == 3) outputText(" teasing your pillar");
			outputText(". You both work each other off for a moment until you finally orgasm locking into a strong hug. ");
			if (player.isGargoyle()) outputText("The pleasure is so powerful your form petrify in rigor mortis for a few minute locking with that of Sapphire who also reached her peak.");
			else outputText(" Not so surprisingly Sapphire has no fluids of her own but you give her plenty as your genitals splash her nethers. Sapphire own orgasm cause her to petrify and harden into rigor mortis.");
			outputText(" It takes a few minute before ");
			if (player.isGargoyle()) outputText("you both");
			else outputText("she");
			outputText(" unfreeze and break the embrace as she remove her stony tail from your private.\n\n");
			outputText("You smile, leaving her embrace as you promise to come back and visit.\n\n");
			sapphireAffection(5);
			player.sexReward("Default","Default",true,false);
			doNext(camp.returnToCampUseOneHour);
		}
		public function SapphireFuckHer():void {
			clearOutput();
			outputText("Her pussy lips shine polished gems and you can’t stop your cock from hardening in prospect of the gargoyle waiting folds.\n\n");
			outputText("You begin to gently pull sapphire into a kiss as you lay her over the nearest altar. Sapphire tongue is actually quite skilled for someone who barely discovered the joy of sex. You entwine and seek each other's out for a few minute caressing the gargoyle smooth stone skin with your hand. Sapphire gasp as your fingers trace the outline of her perfectly sculpted curves.\n\n");
			outputText("\"<i>Ahhhn [name] I...mmm</i>\"\n\n");
			outputText("You tease her skin for a while then get down to business exposing your [cock] to the temple cold air. You shiver for a moment but this is only momentaneous as your tips finds the entrance to sapphire warm canal slowly pressing against it. Sapphire gasp as you gently press your tip near her tight folds not going in yet.\n\n");
			outputText("\"<i>P..please [name] do not make me wait anymore I...I can’t..</i>\"\n\n");
			outputText("You finally decide to oblige her, her eyes going wide as you plunge in as far as you can go burying your length into her tight pussy. As a creature made of living stone you should have guessed by now her cunt wouldn't be the most flexible. It squeeze on your cock like a vice. Sapphire long tongue is loling out and she pant slowly this must be quite the experience for her. ");
			outputText("You begin to slowly slide in and out of her your gargoyle lover arms and legs locking you in a tight grip as pleasure overtake her. You are unlikely to escape for as long as she is not satisfied. Her tight crazy cunt attempt to milks you for all its worth and soon you find yourself on the verge of orgasm.\n\n");
			if (player.isGargoyle()) {
				outputText("Sapphire and you makes a high pitched screech as she clamp on your [cock] her cunt pulsing as you fuck her with wild abandon pulling your penis in and out at high speed the sound of two wet rock sliding against each other echoing in the temple. Sapphire on her side keep mercilessly milking your cock forcing you both to pass through several orgasm until you reach your final peak petrifying together into a completely pleasure addled expression. ");
				outputText("The two of you stay somewhat unconscious a fair hour the pleasure echoing into the core of your very being before you regain mobility your cock sliding out of her cunt with the sound of grinding stone.\n\n");
				outputText("\"<i>Mmmm that sure was one hell of a ride to heaven [name] I hope we will do this again some other time.</i>\"\n\n");
				outputText("You nod still mouth gaping from the feeling of your cock and gear up as you head back to camp.\n\n");
			}
			else {
				outputText("Sapphire makes a high pitched screech as she clamp on your [cock] her cunt pulsing as you fill her with your load painting her stone insides with your cum. You try to slide out but she is far too gone to let you go and keep mercilessly milking your cock forcing you to pass through several orgasm until she reach her final peak petrifying into hard stone. ");
				outputText("To your dismay your cock is buried hilt deep into her and you wait a fair hour before she regain mobility cum flowing out of her cunt as she slide off.\n\n");
				outputText("\"<i>Oops... I got carried away. I hope you don’t mind [name].</i>\"\n\n");
				outputText("You nod absentmindedly and gear up as you head back to camp.\n\n");
			}
			sapphireAffection(5);
			player.sexReward("Default","Default",true,false);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function krystalonyxmenu():void {
			clearOutput();
			outputText("Waving over at " + flags[kFLAGS.ONYX_NAME] + ", you ask ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("him");
			outputText(" if ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" would feel like indulging in some quality time with you. ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("Her");
			else outputText("His");
			outputText(" eternal watch must get boring sometimes. ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("She");
			else outputText("He");
			outputText(" fawns over you, clearly showing ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" interest.\n\n");
			outputText("\n\n\"<i>You're my savior and hero! How could I refuse such a request?");
			if (player.isGargoyle()) outputText(" There’s even a water source nearby to use as lube if necessary.");
			outputText("</i>\"\n\n");
			outputText("Being sure of what you both want, you proceed to a private room in the temple. You undress under the lusty gaze of " + flags[kFLAGS.ONYX_NAME] + ", who seems to devour you with ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" eyes, glowing with an intense desire. Once you're done, " + flags[kFLAGS.ONYX_NAME] + " slowly proceeds to embrace you. Damn, ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" stone body is hot, and you can’t help but wonder if it's because ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText("'s horny, or if it's the sunshine under which ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" basks all day long. This only arouses you more, and ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" slowly proceeds to ");
			if ((flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) && player.breastRows[0].breastRating >= 1) outputText("mash her breasts with yours and gently push you");
			if ((flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) && player.breastRows[0].breastRating == 0) outputText("push her generous breasts on your chest and gently move you");
			if (flags[kFLAGS.ONYX_GENDER] == 3) outputText("gently push you");
			outputText(" to the stone floor as ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" lowers a hand to your ");
			if (player.gender == 2 || player.gender == 3) outputText("[cunt]");
			if (player.gender == 3) outputText(" and ");
			if (player.gender == 1 || player.gender == 3) outputText("[cock]");
			outputText(".\n\n");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("She");
			else outputText("He");
			outputText(" gently and slowly ");
			if (player.hasVagina()) outputText("fingers");
			else outputText("strokes");
			outputText(" you until you're quite aroused and nearly as hot as ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" is, fawning over you for some time, wanting you to feel ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" appreciation and affection while getting you ready for what comes next.\n\n");
			if (player.lust + 50 < player.maxLust()) player.lust += 50;
			else player.lust = player.maxLust();
			menu();
			if (player.hasVagina()) addButton(0, "Tail Fuck", KrystalOnyxTailFuck).hint("Let's put her/his lovely tail to good use.");
			if (player.hasVagina() && (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2)) addButton(1, "Tribadism", KrystalTribadism).hint("Why not grind yourself on that lovely stone pussy.");
			addButton(2, "69", KrystalOnyx69).hint("You wonder what her pussy/his cock tastes like, and if she/he will return the favor.");
			if (player.hasVagina() && (flags[kFLAGS.ONYX_GENDER] == 2 || flags[kFLAGS.ONYX_GENDER] == 3)) addButton(3, "Get fucked", KrystalOnyxGetFucked).hint("You’ve been eyeing that rock hard cock for a while.");
			if (player.hasCock() && (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2)) addButton(4, "Fuck Her", KrystalFuckHer).hint("How about a feel of that rocky hole?");
			addButton(14, "Back", templemainmenu);
		}
		
		public function KrystalOnyxTailFuck():void {
			clearOutput();
			outputText("Lying under ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("him");
			outputText(" you ask if ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" would like to penetrate you with that lovely tail of ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("hers. She");
			else outputText("his. He");
			outputText(" blushes for a moment, but agrees and slowly retracts ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" spikes until ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" tail is smooth and ready. ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("She");
			else outputText("He");
			outputText(" lies on you, ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her stone breasts mashing against your chest as she");
			else outputText("His rock hard cock across your chest as he");
			outputText(" looks behind you both and slowly moves ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" tail toward your [cunt]. ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("She");
			else outputText("He");
			outputText(" tickles your entrance for a moment with ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" tip, giving you a cute smile and making you gasp as ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" slowly inserts ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" tail into your snatch. You grow more aroused as ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" proceeds deeper and deeper until ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" reaches your cervix. You're filled so perfectly by ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" tail, despite the fact ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" is not moving the warmth and girth of ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" stone tail alone is enough to make you gasp.\n\n");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("She");
			else outputText("He");
			outputText(" starts to slide ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" tail in and out of you, taking ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" time to tickle every sensitive spot inside your moist depths. ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("She");
			else outputText("He");
			outputText(" seems to enjoy this as well since ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" moans lustily, and you assume that it's very likely in ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" former form ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" had developed a fetish for tail fucking to the point ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" tail is as responsive as a man's penis.\n\nSince ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" seems to be getting off on ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" own, you allow yourself to focus your mind on your own pleasure as ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" slowly but certainly brings you to the edge. A few seconds later you are both orgasming in perfect synchronization as you squirt all along ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" tail length. With a content smile you doze off next to ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("him");
			outputText(" in a scene of lovemaking fit for a master artist to paint in a fresco.\n\nYou wake up a while later and redress, heading back to camp.\n\n");
			player.sexReward("Default","Default",true,false);
			doNext(camp.returnToCampUseOneHour);
		}
		public function KrystalTribadism():void {
			clearOutput();
			outputText("Krystal's pussy looks like it could use some attention and so does yours. You slowly push the gargoyle down on her back as you begin to grind your pussy against her nether lips. With the lubrication of your feminine juices, her smooth stone pussy soon becomes as slippery as wet ice, and grinding yourself on it is even easier than it would be with a woman made of flesh. ");
			outputText("The both of you moan like cheap whores as your clits engorge from the repeated motions. You begin to grope Krystal's breasts, which are surprisingly malleable despite her stone skin, making her gasp in pleasure as she grabs your [breasts]. Seems she enjoys it just like any normal woman would, despite her stony body.\n\n");
			outputText("Soon you climax ");
			if (player.isGargoyle()) outputText("and petrify along with Krystal, both of your bodies frozen in place for some time. You regain consciousness a while later and give her still frozen form a parting kiss as you head back to camp.\n\n");
			else outputText("and cover Krystal's stone pussy with your girl cum. Krystal petrifies from the orgasm, frozen with an expression of extreme pleasure as you doze off on your statuesque lover. When you wake up, you give her still frozen form a parting kiss as you head back to camp.\n\n");
			player.sexReward("Default","Default",true,false);
			doNext(camp.returnToCampUseOneHour);
		}
		public function KrystalOnyx69():void {
			clearOutput();
			outputText("Your eyes zero in on ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("Krystal's smoothly shaped pussy");
			else outputText("Onyx's perfectly carved cock");
			outputText(" and you start to ponder what a gargoyle tastes like. Determined to get the answer to this very important question, you tell " + flags[kFLAGS.ONYX_NAME] + " to lay on ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her back. She");
			else outputText("his back. He");
			outputText(" is quick to comply and you take your time to position your genitals right above ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" face and ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("give her pussy a quick lick. She");
			else outputText("give his glans a quick lick. He");
			outputText(" moans in appreciation and responds by firmly grabbing your ass ");
			if (player.hasVagina()) {
				outputText("and filling your [cunt] with ");
				if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("his");
				outputText(" stony tongue");
			}
			if (player.hasCock()) outputText("and suckling on your cockhead.");
			outputText(" You moan in delight and proceed to reward ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" effort with");
			if (player.hasVagina()) outputText(" pussy juices.");
			if (player.hasCock()) outputText(" precum.");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("She");
			else outputText("He");
			outputText(" strangely doesn't have a bad taste, albeit very different from a creature of flesh and blood.\n\n");
			if (player.isGargoyle()) {
				outputText("You pleasure each other for several minutes, both of your stone tails flailing wildly from the impending orgasm. Your moans get louder and louder until you finally freeze in place at your shared climax, prolonging this perfect moment for what looks like a passionate eternity. When you come to your mouth is where you left it and you decide to pull it off " + flags[kFLAGS.ONYX_NAME] + "'s genitals. " + flags[kFLAGS.ONYX_NAME] + " is still petrified in pleasure, ");
				if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
				else outputText("he");
				outputText(" likely will come to later.");
			}
			else {
				outputText("You pleasure each other for several minutes as you try to match your tempo with that of your stony partner's. Soon you orgasm ");
				if (player.hasCock()) outputText("blowing your load in " + flags[kFLAGS.ONYX_NAME] + "'s waiting mouth");
				if (player.hasVagina()) outputText("" + flags[kFLAGS.ONYX_NAME] + " drinking the flood of your juices and licking your pussy clean");
			}
			outputText(" You doze off tired and wake up an hour later, your mouth still where you left it. You resolve to pull it off " + flags[kFLAGS.ONYX_NAME] + " who, still petrified in pleasure, will likely come to later.\n\n");
			outputText("For now you proceed to redress and head back to camp.\n\n");
			player.sexReward("Default","Default",true,false);
			doNext(camp.returnToCampUseOneHour);
		}
		public function KrystalOnyxGetFucked():void {
			clearOutput();
			outputText("The moment you made " + flags[kFLAGS.ONYX_NAME] + "'s perfectly defined shaft you knew you would use it! You begin to slide your hand against ");
			if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" perfect pillar of maleness in order to wake it up. " + flags[kFLAGS.ONYX_NAME] + "'s reaction is immediate as ");
			if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" cock grows erect within seconds, as hard as diamond and ready for your use");
			if (!player.isGargoyle()) outputText(". Well not so ready yet... there's still the need for lubrication");
			outputText(". You lower your head and proceed to suck on " + flags[kFLAGS.ONYX_NAME] + "'s perfect cock");
			if (!player.isGargoyle()) outputText(", liberally coating the entire length with your saliva");
			outputText(". " + flags[kFLAGS.ONYX_NAME] + " shivers in delight at your expert cocksucking but you’re not done yet. You move yourself into position and slowly begin to insert the hard tool inside your [cunt] ");
			if (player.isGargoyle()) {
				outputText(" moaning in delight at the perfect grinding of ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("his");
				outputText(" perfectly shaped stone dick in your stone pussy wich begins to heat up from the friction");
			}
			else outputText("gasping as the cold hard stone enters you");
			outputText(".\n\nIt’s obvious " + flags[kFLAGS.ONYX_NAME] + " had a lot of experience using a cock before, likely from ");
			if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" past life as the Obsidian Gargoyle. ");
			if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("Her");
			else outputText("His");
			outputText(" talent at fucking rivals that of the demons, and soon you find yourself at the mercy of ");
			if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" perfect gargoyle cock. ");
			if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("She");
			else outputText("He");
			outputText(" pushes you on your back and takes charge, fucking your pussy so well your eyes cross and your tongue falls out of your mouth as you pant in lust.");
			if (player.breastRows[0].breastRating >= 1) {
				outputText(" You barely register ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("him");
				outputText(" grabbing your breasts and caressing them with expertise as you are now entirely focused on the indescribable sensations coming from your pussy that threaten to break your mind.");
			}
			outputText("\n\n");
			if (player.isGargoyle()) {
				outputText("Soon ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("his");
				outputText(" skill proves to much for you, as you lose it entirely to pleasure. Your mind regressing to that of an animal in heat, reaching nirvana several times over, screeching your bliss to the heavens. Your mouth gapes wide open as " + flags[kFLAGS.ONYX_NAME] + " reaches ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("his");
				outputText(" peak, the both of you petrifying in a silent orgasmic scream. You stay there under ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("him");
				outputText(" for hours, untouched by time, until you recover mobility then push ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("his");
				outputText(" still frozen form off you. Wow, what a fuck! If you didn’t know any better, you think you might get addicted to ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("his");
				outputText(" dick.\n\n");
				outputText("You head back to camp, giving the unconscious gargoyle a parting kiss.\n\n");
			}
			else {
				outputText("Soon ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("his");
				outputText(" skill proves to much for you, as you lose it entirely to pleasure. Your mind regressing to that of an animal in heat, reaching nirvana several times over, you scream out your bliss, splattering Krystal's/Onyx's cock with a constant waterfall of girl cum which only serves to accelerate and ease ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("his");
				outputText(" pumping. You are still drooling on the ground as " + flags[kFLAGS.ONYX_NAME] + " reaches ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("his");
				outputText(" peak, petrifying in a silent orgasmic scream. You stay there under ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("him");
				outputText(" for several minutes as you calm down and recover your senses, then push ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("his");
				outputText(" still frozen form off of you. Wow, what a fuck! If you didn’t know any better, you think you might get addicted to ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("his");
				outputText(" dick.\n\n");
				outputText("You head back to camp, giving the unconscious gargoyle a parting kiss.\n\n");
			}
			player.sexReward("Default","Default",true,false);
			doNext(camp.returnToCampUseOneHour);
		}
		public function KrystalFuckHer():void {
			clearOutput();
			outputText("Krystal sure has a lovely body, you can’t deny that. Her breasts are perfectly shaped, her face could make any man fall for her and that pussy looks so inviting it would be impossible to say no. You slowly push Krystal to the ground ");
			if (player.isGargoyle()) {
				outputText("readying your [cock] for the smoking hot gargoyle ");
				if (flags[kFLAGS.ONYX_GENDER] == 1) outputText("girl");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("herm");
				outputText(" before you.");
			}
			else outputText("making sure to lube your [cock] liberally to compensate for the lack of lubricant.");
			outputText(" You kiss Krystal, tasting her tongue with yours as you caress her breasts. She coos in delight, her tail waving from side to side as you slowly insert yourself in her stony, yet very malleable and accommodating, pussy. It's like the thing was made with an imprint of your dick, it hugs your shaft perfectly. ");
			outputText(" You moan in pleasure as you start to fuck the lusty gargoyle, enjoying the ministrations of her perfect pussy on your cock. You both make for the perfect match, and soon you find yourself on the verge of climax.\n\n");
			if (player.isGargoyle()) {
				outputText("You orgasm together in a climax so perfect that you petrify and lose the ability to move or think straight. You realise you’re still bottomed out in her but you don’t care. You wish this perfect moment would last forever as you are kept at the peak of orgasm. Eventually the pleasure recedes and the both of you regain movement. ");
				outputText("If Krystal could blush she would, as she slowly removes herself from your now flaccid tool, looking like she had the orgasm of her life.\n\n");
				outputText("\"<i>Wow uh... [name] you sure do have excellent stamina.</i>\"\n\n");
				outputText("You redress and head back to camp utterly satisfied.\n\n");
			}
			else {
				outputText(" You cum, filling the gargoyle with creamy whiteness as the both of you orgasm, Krystal momentarily losing its ability to move, petrified by pleasure. You begin to remove your dick from the gargoyle pussy but discover to your annoyance that her frozen cunt is so tight you have to almost forcefully open her snatch to get yourself loose. ");
				outputText("Eventually, an hour later you manage to slide out, a massive trail of cum following suit as you kept fucking her in your attempt to get free from her stony snatch.\n\n");
				outputText("You proceed to redress and head back to camp.\n\n");
			}
			player.sexReward("Default","Default",true,false);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function templeBasement():void {
			clearOutput();
			if (flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] == 2) {
				outputText("You wander back into the Temple basement atelier.");
				menu();
				addButton(0, "Statue", currentStateOfStatue).hint("Check on the statue.");
				addButton(1, "Strange Book", strangeBookOfGolems).hint("Examine the strange book.");
				if (player.hasKeyItem("Black Soul Gem") >= 0 && flags[kFLAGS.ONYX_PATH] < 1) addButton(2, "Spare Statue", makingNewGargoyle).hint("Check on the spare statue.");
				addButton(4, "Back", templemainmenu);
			}
			if (flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] == 1) {
				outputText("As you wander down into the basement of the temple you find what looks like an old abandoned Atelier. Down there are two unfinished statues of what looks like a gargoyle. Either could be carved in any way you wish.\n\n");
				flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE]++;
				outputText("There are two statues, one looks to be made of alabaster and the other of marble. You're pretty much sure that alabaster would conduct and resist magic easier, although it is less resistant to physical blows, while one made out of marble would be a way stronger material for delivering strikes.");
				menu();
				addButton(0, "Marble", chooseToWorkOnMarbleStatue);
				addButton(1, "Alabaster", chooseToWorkOnAlabasterStatue);
			}
		}
		
		public function strangeBookOfGolems():void {
			clearOutput();
			outputText("This book seems to explain the process of crafting a Gargoyle in length. It seems to imply your friend up there may have been made out from the soul of a willing sacrifice or a long dead person. Will you read it?");
			menu();
			addButton(0, "Read", readStrangeBookOfGolems);
			addButton(1, "Back", templeBasement);
		}
		public function readStrangeBookOfGolems():void {
			clearOutput();
			outputText("You read the book with keen interest, perhaps you can learn something useful from it.\n\n");
			outputText("GOLEMANCY THE ART OF SOULCRAFT\n\n");
			outputText("By Aerin Fowl priest of Marae\n\n");
			outputText("Golemancy is the art of creating an artificial being from the combination of a statue and a soul. While any soul can give life to a golem, for the purpose of giving it at least minimal intelligence and autonomy, it is recommended to use the soul of a living or deceased humanoid. The most suiting and moral soul for such a purpose is generally the soul of a person near death’s door or a willing sacrifice. ");
			outputText("Most of the Gargoyle crafted in this way are infused with the soul of pious priests and nun willing to protect the church of Marae for all eternity. Golems knows no hunger or pain but can be destroyed thus freeing their soul back. To prevent such a thing most golem are given the ability to recover by eating raw stone in order to repair themselves magically. To create a golem start by sculpting a suitable vessel for the soul. ");
			outputText("Once this is done, place the body of the sacrifice or the captured soul of the being you wish to infuse your golem with on a sacred altar. Have the statue, still on its pedestal, carried over to face the altar but at a safe distance in case it accidentally lashes out at you in confusion upon awakening. It is often the case for already dead sacrifices, who are often snatched from the afterlife or have lounged in anguish for months inside the soul gem before being prepared.\n\n");
			outputText("Finally, bind the golem by making a magic circle with the enchantments you wish to place in order to limit its freedom to whatever purpose you want. Make a second and final magic circle below the pedestal in order to bind the soul to the vessel, but keep in mind blood is needed to craft such a circle. Any blood will do as it is essentially a symbol of life. Keep in mind using anything but blood will ruin the ritual entirely. ");
			outputText("You will need several additional ingredients: a drake heart flower, some pure honey, powdered coal mixed in the blood and finally a soul gem, ready to be filled with the soul of the sacrifice, if any, with them already touching the golem in a way or another. In the case where the sacrifice is already in the gem make sure the gem touches the statue. Once this is all done you're finally ready to transfer the soul to the golem. ");
			outputText("Should the sacrifice still be alive, it’s physical body will likely die as its soul is sucked into your creation. There is no turning back once it's done, so make sure the subject is ready physically and psychologically to welcome the change. Stand facing the statue but on the opposite side of the central altar and recite the following arcane word in order to proceed to the transfer.\n\n");
			outputText("Shira Khrim Almisry Ohm Ak Tar Marae Kann Tharr Shul Elysro An Siryr Ahn Ekatyr Evenar Sethe Omaris.\n\n");
			outputText("You think you could use this information to perhaps turn yourself into a living weapon in order to defeat the demons with relative ease. The question you should ask yourself however is... is this really what you want?");
			if (flags[kFLAGS.GARGOYLE_QUEST] == 1) {
				if (player.hasKeyItem("Soul Gem Research") >= 0) flags[kFLAGS.GARGOYLE_QUEST] = 3;
				flags[kFLAGS.GARGOYLE_QUEST]++;
			}
			doNext(templeBasement);
		}
		
		public function makingNewGargoyle():void {
			if (flags[kFLAGS.ONYX_GENDER] >= 1) makingNewGargoylePart4();
			else makingNewGargoylePart1();
		}
		public function makingNewGargoylePart1():void {
			clearOutput();
			outputText("Thinking about your lonely friend up there, you look at the spare gargoyle body and take the Black Soul Gem out of your pack. Maybe she could use the company of another gargoyle.\n\n");
			outputText("Everyone deserves a second chance, but you ponder if using the soul of a formerly sex starved aberration is a bright idea.");
			menu();
			addButton(0, "Yes", makingNewGargoylePart2);
			addButton(1, "No", templeBasement);
		}
		public function makingNewGargoylePart2():void {
			clearOutput();
			outputText("You work for six hours, sculpting the spare statue parts to your liking with an artist's passion, then head back to camp for a break.");
			menu();
			addButton(0, "Female", makingNewGargoyleFemale);
			addButton(1, "Herm", makingNewGargoyleHerm);
			addButton(2, "Male", makingNewGargoyleFMale);
		}
		public function makingNewGargoyleFemale():void {
			flags[kFLAGS.ONYX_GENDER] = 1;
			doNext(camp.returnToCampUseSixHours);
		}
		public function makingNewGargoyleHerm():void {
			flags[kFLAGS.ONYX_GENDER] = 2;
			doNext(camp.returnToCampUseSixHours);
		}
		public function makingNewGargoyleFMale():void {
			flags[kFLAGS.ONYX_GENDER] = 3;
			doNext(camp.returnToCampUseSixHours);
		}
		public function makingNewGargoylePart4():void {
			clearOutput();
			outputText("You conduct the ritual according to the book, carrying the statue to the altar and mixing your own blood with the ingredients as to carefully bind the new gargoyle to you, in case it’s soul is unstable. You draw the required arcane circles around the statue under the gaze of Sapphire. Once done, you place the Black Soul Gem on the altar and chant the arcane words.\n\n");
			outputText("\"<i>Shira Khrim Almisry Ohm Ak Tar Marae Kann Tharr Shul Elysro An Siryr Ahn Ekatyr Evenar Sethe Omaris!</i>\"\n\n");
			outputText("As you chant the last word, the gem seems to be assimilated directly into the alabaster/marble body, disappearing without a trace. The statue's eyes start to dimly glow with a pale purple light as the new gargoyle awakens with a surprised expression. \"<i>What happened...? I was dead, finally destroyed by your hands and at rest. But now I’m alive again. My thoughts free of the constant plague of sexual desires, and in a new body. Am I to be given a second chance?</i>\"\n\n");
			outputText("You start by asking the gargoyle for its name, not desiring to force it into the role of a slave again.\n\n");
			outputText("\"<i>My name?... While I used to be one soul, I am now many. Since I'm a living statue and I’m closer to a ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("Female");
			if (flags[kFLAGS.ONYX_GENDER] == 3) outputText("Male");
			outputText(" being, I guess I’ll name myself ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) {
				outputText("Krystal");
				flags[kFLAGS.ONYX_NAME] = "Krystal";
			}
			else {
				outputText("Onyx");
				flags[kFLAGS.ONYX_NAME] = "Onyx";
			}
			outputText(". Are you going to be my master from now on?</i>\"\n\n");
			outputText("You have no intention of being such a thing, and you clearly state to " + flags[kFLAGS.ONYX_NAME] + " that the only order you'll ever give ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("him");
			outputText(" is to help Sapphire guard this temple from potential corrupted influences such as demons and minotaurs. For the rest of ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
			else outputText("his");
			outputText(" time, ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" is officially free to act and live as ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
			else outputText("he");
			outputText(" wishes, without the constraints of obedience to a master. " + flags[kFLAGS.ONYX_NAME] + "'s face would shed tears if it could, after living for years as a slave to a demon master, the freedom you offer the gargoyle is something it only dared to dream of.\n\n");
			outputText("\"<i>If that's the condition, then I will do as you ask. Thank you so much for everything, and should you ever need anything special, I will be here in the temple for you. It feels so good to finally be able to make my own choices again.</i>\"\n\n");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("She gives you an affectionate kiss on the cheek, surprising you, then flies to perch on a nearby pedestal and begins her watch.");
			else outputText("He warmly hugs you to show his appreciation, then flies to perch on a nearby pedestal and begins his watch.");
			outputText("\n\n");
			flags[kFLAGS.ONYX_PATH] = 2;
			player.removeKeyItem("Black Soul Gem");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function currentStateOfStatue():void {
			clearOutput();
			outputText("This statue looks like ");
			if (flags[kFLAGS.GARGOYLE_BODY_SCULPTING_PROGRESS] >= 11) outputText("a finished");
			else outputText("an incomplete");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) outputText(" marble");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) outputText(" alabaster");
			outputText(" gargoyle. This statue looks like ");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 1) outputText("it has a gorgeous female face");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 2) outputText("it has a handsome male face");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 3) outputText("it has a face that would look good on a male or a female");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 0) outputText("its face is yet to be finished");
			outputText(" and its ");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) == 1) outputText("bald head looks great.");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) == 2) outputText("short hair looks great.");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) == 3) outputText("moderately long hair looks great.");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) == 4) outputText("long hair looks great.");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2) || player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) == 0) outputText("hair is yet to be sculpted.");
			if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) > 0) {
				outputText("\n\nStatue have ");
				if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 1)outputText("flat chest");
				if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 2)outputText("A-cup breasts");
				if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 3)outputText("B-cup breasts");
				if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 4)outputText("C-cup breasts");
				if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 5)outputText("D-cup breasts");
				if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 6)outputText("DD-cup breasts");
				if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 7)outputText("big DD-cup breasts");
				outputText(".\n\n");
			}
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2) || player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) == 0) outputText("\n\nThere's a block where its chest would be.\n\n");
			if ((!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2) || player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) < 1) && (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker3) || player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker3) < 1 || player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker3) < 1)) outputText("There's a block where its crotch would be.");
			else {
				outputText("At statue crotch ");
				if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) > 1) {
					outputText("there is ");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 2) outputText("4 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 3) outputText("4.5 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 4) outputText("5 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 5) outputText("5.5 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 6) outputText("6 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 7) outputText("6.5 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 8) outputText("7 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 9) outputText("7.5 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 10) outputText("8 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 11) outputText("8.5 inch");
					if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 12) outputText("9 inch");
					outputText(" long cock");
					if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker3) > 1) {
						outputText(" along with a pair of ");
						if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker3) == 2) outputText("large");
						if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker3) == 3) outputText("baseball-sized");
						if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker3) == 4) outputText("apple-sized");
						if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker3) == 5) outputText("grapefruit-sized");
						outputText(" balls");
					}
					outputText(".");
				}
				if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) == 1 && player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker3) < 2) outputText("there is no cock.");
				if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker3) > 0) {
					if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker3) == 2) {
						if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) > 1) outputText(" Beneath it");
						if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker3) > 1) outputText(" Beneath them");
						outputText(" there is a tight vagina, with a tiny clit.");
					}
					else outputText("");
				}
			}
			outputText("\n\nAll details in its");
			if (flags[kFLAGS.GARGOYLE_WINGS_TYPE] == 2) outputText(" bat");
			if (flags[kFLAGS.GARGOYLE_WINGS_TYPE] == 1) outputText(" feathered");
			outputText(" wings ");
			if (flags[kFLAGS.GARGOYLE_WINGS_TYPE] >= 1) outputText("are completed, wings folded behind its back");
			else outputText("have yet to be done");
			outputText(".\n\nIt's arms ");
			if (player.statusEffectv4(StatusEffects.GargoyleTFSettingTracker1) == 1) outputText("ends with a set of bestial four fingered sharp stone claws");
			if (player.statusEffectv4(StatusEffects.GargoyleTFSettingTracker1) == 2) outputText("ends with very human fist");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv4(StatusEffects.GargoyleTFSettingTracker1) == 0) outputText("have yet to be sculpted");
			outputText(". It's legs ");
			if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker1) == 1) outputText("ends with clawed bestial feets with three toe at the front and one at the back");
			if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker1) == 2) outputText("are human like");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker1) == 0) outputText("have yet to be defined");
			outputText(". Its ");
			if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker1) == 1) outputText("mace like");
			if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker1) == 2) outputText("axe like");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker1) == 0) outputText("unfinished");
			outputText(" tail seems to be there right above its ");
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 1 || player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 2 || player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 3) {
				outputText("perfectly made ");
				if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 1) outputText("feminine");
				if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 2) outputText("masculine");
				if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 3) outputText("androgynous");
			}
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1))outputText("unfinished");
			outputText(" body.");
			if (flags[kFLAGS.GARGOYLE_BODY_SCULPTING_PROGRESS] >= 1) outputText("\n\nProgress: " + flags[kFLAGS.GARGOYLE_BODY_SCULPTING_PROGRESS]);
			menu();
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) < 1) addButton(0, "Frame&Face", SculptFrameAndFace);
			else addButtonDisabled(0, "Frame&Face", "You already sculpted the Frame and Face.");
			if (flags[kFLAGS.GARGOYLE_WINGS_TYPE] < 1) addButton(1, "Wings", SculptWings);
			else addButtonDisabled(1, "Wings", "You already sculpted the Wings.");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker1) < 1) addButton(2, "Tail", SculptTail);
			else addButtonDisabled(2, "Tail", "You already sculpted the Tail.");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker1) < 1) addButton(3, "Legs", SculptLegs);
			else addButtonDisabled(3, "Legs", "You already sculpted the Legs.");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1) || player.statusEffectv4(StatusEffects.GargoyleTFSettingTracker1) < 1) addButton(4, "Arms", SculptArms);
			else addButtonDisabled(4, "Arms", "You already sculpted the Arms.");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2) || player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) < 1) addButton(5, "Hair", SculptHair);
			else addButtonDisabled(5, "Hair", "You already sculpted the Hair.");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2) || player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) < 1) addButton(6, "Chest", SculptChest);
			else addButtonDisabled(6, "Chest", "You already sculpted the Chest.");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker3) || player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker3) < 1) addButton(7, "Pussy", SculptPussy);
			else addButtonDisabled(7, "Pussy", "You already sculpted the Pussy Area.");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2) || player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) < 1) addButton(8, "Cock", SculptCock);
			else addButtonDisabled(8, "Cock", "You already sculpted the Cock Area.");
			if (!player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker3) || player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker3) < 1) addButton(9, "Balls", SculptBalls);
			else addButtonDisabled(9, "Balls", "You already sculpted the Balls Area.");
			if (flags[kFLAGS.GARGOYLE_BODY_SCULPTING_PROGRESS] >= 11 && flags[kFLAGS.GARGOYLE_QUEST] >= 3 && !player.isGargoyle()) addButton(13, "Ritual", becomingGargoyle);
			addButton(14, "Back", BackToSapphire);
		}
		public function BackToSapphire():void {
			clearOutput();
			outputText("You decide to come back later to finish the work.");
			doNext(templemainmenu);
		}
		
		public function chooseToWorkOnMarbleStatue():void {
			flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 1;
			flags[kFLAGS.GARGOYLE_BODY_SCULPTING_PROGRESS] = 1;
			flags[kFLAGS.GARGOYLE_QUEST] = 1;
			flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 0;
			currentStateOfStatue();
		}
		public function chooseToWorkOnAlabasterStatue():void {
			flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 2;
			flags[kFLAGS.GARGOYLE_BODY_SCULPTING_PROGRESS] = 1;
			flags[kFLAGS.GARGOYLE_QUEST] = 1;
			flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 0;
			currentStateOfStatue();
		}
		
		public function SculptFrameAndFace():void {
			menu();
			addButton(0, "Feminine", SculptFeminineFrameAndFace).hint("Sculpt a feminine frame and face.");
			addButton(1, "Masculine", SculptMasculineFrameAndFace).hint("Sculpt a masculine frame and face.");
			addButton(2, "Androgynous", SculptAndrogynousFrameAndFace).hint("Sculpt a androgynous frame and face.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptFeminineFrameAndFace():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 1, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 1, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptMasculineFrameAndFace():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 1, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 2, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptAndrogynousFrameAndFace():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 1, 3);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 3, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		
		public function SculptWings():void {
			menu();
			addButton(0, "Bat", SculptBatWings).hint("Sculpt bat wings.");
			addButton(1, "Feathered", SculptFeatheredWings).hint("Sculpt feathered wings.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptBatWings():void {
			flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 2;
			SecondPartOfSculptingText();
		}
		public function SculptFeatheredWings():void {
			flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 1;
			SecondPartOfSculptingText();
		}
		
		public function SculptTail():void {
			menu();
			addButton(0, "Mace", SculptMaceTail).hint("Sculpt mace shaped tail tip.");
			addButton(1, "Axe", SculptAxeTail).hint("Sculpt axe shaped tail tip.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptMaceTail():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 2, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 0, 1, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptAxeTail():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 2, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 0, 2, 0, 0);
			SecondPartOfSculptingText();
		}
		
		public function SculptLegs():void {
			menu();
			addButton(0, "Clawed", SculptClawedLegs).hint("Sculpt clawed legs.");
			addButton(1, "Humane", SculptHumaneLegs).hint("Sculpt humane legs.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptClawedLegs():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 3, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 0, 0, 1, 0);
			SecondPartOfSculptingText();
		}
		public function SculptHumaneLegs():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 3, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 0, 0, 2, 0);
			SecondPartOfSculptingText();
		}
		
		public function SculptArms():void {
			menu();
			addButton(0, "Clawed", SculptClawedArms).hint("Sculpt clawed arms.");
			addButton(1, "Humane", SculptHumaneArms).hint("Sculpt humane arms.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptClawedArms():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 4, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 0, 0, 0, 1);
			SecondPartOfSculptingText();
		}
		public function SculptHumaneArms():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker1)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker1, 4, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker1, 0, 0, 0, 2);
			SecondPartOfSculptingText();
		}
		
		public function SculptHair():void {
			menu();
			addButton(0, "Bald", SculptBald).hint("Sculpt bald head.");
			addButton(1, "Short", SculptShort).hint("Sculpt short hair on statue head.");
			addButton(2, "Medium", SculptMedium).hint("Sculpt medium long hair on statue head.");
			addButton(3, "Long", SculptLong).hint("Sculpt long hair on statue head.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptBald():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 1, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 1, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptShort():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 1, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 2, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptMedium():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 1, 3);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 3, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptLong():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 1, 4);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 4, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		
		public function SculptChest():void {
			menu();
			addButton(0, "Flat", SculptFlat).hint("Sculpt flat chest.");
			addButton(1, "A-cup", SculptACup).hint("Sculpt A-cup breasts.");
			addButton(2, "B-cup", SculptBCup).hint("Sculpt B-cup breasts.");
			addButton(3, "C-cup", SculptCCup).hint("Sculpt C-cup breasts.");
			addButton(4, "D-cup", SculptDCup).hint("Sculpt D-cup breasts.");
			addButton(5, "DD-cup", SculptDDCup).hint("Sculpt DD-cup breasts.");
			addButton(6, "Big DD-cup", SculptBigDDCup).hint("Sculpt Big DD-cup breasts.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptFlat():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 2, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 1, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptACup():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 2, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 2, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptBCup():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 2, 3);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 3, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCCup():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 2, 4);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 4, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptDCup():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 2, 5);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 5, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptDDCup():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 2, 6);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 6, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptBigDDCup():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 2, 7);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 7, 0, 0);
			SecondPartOfSculptingText();
		}
		
		public function SculptPussy():void {
			menu();
			if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) != 1) addButton(0, "No", SculptPussyNo).hint("Don't sculpt pussy.");
			addButton(1, "Yes", SculptPussyYes).hint("Sculpt pussy.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptPussyNo():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker3)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker3, 1, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker3, 1, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptPussyYes():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker3)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker3, 1, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker3, 2, 0, 0, 0);
			SecondPartOfSculptingText();
		}
		
		public function SculptCock():void {
			menu();
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker3) != 1) addButton(0, "None", SculptNoCock).hint("Don't sculpt cock.");
			addButton(1, "4\"", SculptCock1).hint("Sculpt 4' cock.");
			addButton(2, "4.5\"", SculptCock2).hint("Sculpt 4.5' cock.");
			addButton(3, "5\"", SculptCock3).hint("Sculpt 5' cock.");
			addButton(4, "5.5\"", SculptCock4).hint("Sculpt 5.5' cock.");
			addButton(5, "6\"", SculptCock5).hint("Sculpt 6' cock.");
			addButton(6, "6.5\"", SculptCock6).hint("Sculpt 6.5' cock.");
			addButton(7, "7\"", SculptCock7).hint("Sculpt 7' cock.");
			addButton(8, "7.5\"", SculptCock8).hint("Sculpt 7.5' cock.");
			addButton(9, "8\"", SculptCock9).hint("Sculpt 8' cock.");
			addButton(10, "8.5\"", SculptCock10).hint("Sculpt 8.5' cock.");
			addButton(11, "9\"", SculptCock11).hint("Sculpt 9' cock.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptNoCock():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 1, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock1():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 2, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock2():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 3);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 3, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock3():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 4);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 4, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock4():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 5);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 5, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock5():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 6);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 6, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock6():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 7);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 7, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock7():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 8);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 8, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock8():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 9);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 9, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock9():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 10);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 10, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock10():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 11);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 11, 0);
			SecondPartOfSculptingText();
		}
		public function SculptCock11():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker2)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker2, 3, 12);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker2, 0, 0, 12, 0);
			SecondPartOfSculptingText();
		}
		
		public function SculptBalls():void {
			menu();
			addButton(0, "No", SculptBallsNo).hint("Don't sculpt balls.");
			if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) >= 2)  {
				addButton(1, "Large", SculptBallsLarge).hint("Sculpt large balls.");
				addButton(2, "Baseball", SculptBallsBaseballSized).hint("Sculpt baseball-sized balls.");
				addButton(3, "Apple", SculptBallsAppleSized).hint("Sculpt apple-sized balls.");
				addButton(4, "Grapefruit", SculptBallsGrapefruitSized).hint("Sculpt grapefruit-sized balls.");
			}
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptBallsNo():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker3)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker3, 2, 1);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker3, 0, 1, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptBallsLarge():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker3)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker3, 2, 2);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker3, 0, 2, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptBallsBaseballSized():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker3)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker3, 2, 3);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker3, 0, 3, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptBallsAppleSized():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker3)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker3, 2, 4);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker3, 0, 4, 0, 0);
			SecondPartOfSculptingText();
		}
		public function SculptBallsGrapefruitSized():void {
			if (player.hasStatusEffect(StatusEffects.GargoyleTFSettingTracker3)) player.addStatusValue(StatusEffects.GargoyleTFSettingTracker3, 2, 5);
			else player.createStatusEffect(StatusEffects.GargoyleTFSettingTracker3, 0, 5, 0, 0);
			SecondPartOfSculptingText();
		}
		
		public function SecondPartOfSculptingText():void {
			clearOutput();
			outputText("You work for six hours, sculpting the statue part to your liking with an artist's passion, then head back to camp for a break.");
			flags[kFLAGS.GARGOYLE_BODY_SCULPTING_PROGRESS]++;
			doNext(camp.returnToCampUseSixHours);
		}
		
		public function becomingGargoyle():void {
			clearOutput();
			if (player.hasKeyItem("Gargoyle demonic researches") >= 0 && player.hasItem(useables.SOULGEM, 1) && flags[kFLAGS.GARGOYLE_QUEST] < 6) flags[kFLAGS.GARGOYLE_QUEST] = 6;
			if (player.hasKeyItem("Gargoyle demonic researches") >= 0 && player.hasItem(useables.SOULGEM, 1) && flags[kFLAGS.GARGOYLE_QUEST] == 6) {
				if (player.inte < 80) {
					outputText("While you do have all the ingredient required as it states in the formula you feel you don't understand magic well enough yet to risk the ritual. Who knows what fate awaits you should you fail it. You resolve to come back when you have enough arcane knowledge to attempt this.");
					doNext(templeBasement);
				}
				else if (player.isPregnant() || player.isButtPregnant()) {
					outputText("You can't become Gargoyle while pregnant. Come back after you give a birth.");
					doNext(templeBasement);
				}
				else {
					outputText("You think you’ve gathered all you need and proceed to move the statue up from the basement to the cathedral center next to the altar where it ought to be. You ask Sapphire to help you carry it, to which she complies, albeit she throws you several worried looks.");
					outputText("\n\n<b>Are you sure about this? There's no turning back past this point.</b>");
					menu();
					addButton(0, "No", becomingGargoyleNo);
					addButton(1, "Yes", becomingGargoyleYes);
					addButton(2, "Back", currentStateOfStatue);
				}
			}
			else {
				if (player.hasKeyItem("Gargoyle demonic researches") < 0 && player.hasItem(useables.SOULGEM, 1)) outputText("As you plan out the ritual you discover, to your utter annoyance, that the book doesn't describe at all what the magic circles look like. Without this information, you can’t risk your very soul in a spell that might fail entirely due to a wrong drawing. You will need to somehow find more information about golems and gargoyles first. ");
				if (player.hasKeyItem("Gargoyle demonic researches") >= 0 && !player.hasItem(useables.SOULGEM, 1)) outputText("While you do have the demonic researches in hand the ritual specifically ask for a soul gem. Guess you will have to craft one.");
				if (flags[kFLAGS.GARGOYLE_QUEST] == 4) flags[kFLAGS.GARGOYLE_QUEST]++;
				doNext(templeBasement);
			}
		}
		public function becomingGargoyleNo():void {
			clearOutput();
			outputText("This is something that is gonna change your entire life and while you're ready to do anything to stop the demons, you're not sure this is what you want yet. You resolve to come back and do the ritual once you truly are ready for it.");
			doNext(templeBasement);
		}
		public function becomingGargoyleYes():void {
			clearOutput();
			outputText("You proceed according to the ritual as described in the book, however a question poses itself. What kind of blood will you use?");
			menu();
			addButton(0, "OwnBlood", becomingGargoyleYesOwnBlood).hint("Your body would need regular intake of raw soulforce.");
			if (player.hasItem(consumables.MINOBLO, 1)) addButton(1, "Minotaur", becomingGargoyleYesMinotaurBlood).hint("Your body would need regular intake of sexual fluids.");
			else addButtonDisabled(1, "Minotaur", "Need Minotaur Blood vial for this option");
			addButton(2, "Back", templeBasement)
		}
		
		public function becomingGargoyleYesOwnBlood():void {
			clearOutput();
			player.createPerk(PerkLib.GargoylePure, 0, 0, 0, 0);
			becomingGargoyleYes2();
		}
		public function becomingGargoyleYesMinotaurBlood():void {
			clearOutput();
			player.createPerk(PerkLib.GargoyleCorrupted, 0, 0, 0, 0);
			becomingGargoyleYes2();
		}
		public function becomingGargoyleYes2():void {
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) {
				player.skinTone = "light grey";
				player.hairColor = "light grey";
			}
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) {
				player.skinTone = "quartz white";
				player.hairColor = "quartz white";
			}
			player.skin.setBaseOnly({type:Skin.STONE});
			player.hairType = Hair.NORMAL;
			player.faceType = Face.DEVIL_FANGS;
			player.tongue.type = Tongue.DEMONIC;
			player.horns.type = Horns.GARGOYLE;
			player.horns.count = 12 + rand(4);
			player.beardLength = 0;
			player.beardStyle = 0;
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 1) player.femininity = 100;
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 2) player.femininity = 0;
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker1) == 3) {
				player.femininity = 50;
				if (player.findPerk(PerkLib.Androgyny) < 0) player.createPerk(PerkLib.Androgyny,0,0,0,0);
			}
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) == 1) player.hairLength = 0;
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) == 2) player.hairLength = 2;
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) == 3) player.hairLength = 8;
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker2) == 4) player.hairLength = 14;
			if (player.statusEffectv4(StatusEffects.GargoyleTFSettingTracker1) == 1) player.arms.type = Arms.GARGOYLE;
			if (player.statusEffectv4(StatusEffects.GargoyleTFSettingTracker1) == 2) player.arms.type = Arms.GARGOYLE_2;
			if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker1) == 1) player.tailType = Tail.GARGOYLE;
			if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker1) == 2) player.tailType = Tail.GARGOYLE_2;
			player.tailRecharge = 0;
			player.wings.type = Wings.GARGOYLE_LIKE_LARGE;
			if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker1) == 1) player.lowerBody = LowerBody.GARGOYLE;
			if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker1) == 2) player.lowerBody = LowerBody.GARGOYLE_2;
			player.legCount = 2;
			player.eyes.type = Eyes.GEMSTONES;
			player.antennae.type = Antennae.NONE;
			player.tongue.type = Tongue.HUMAN;
			player.ears.type = Ears.ELFIN;
			player.gills.type = Gills.NONE;
			player.rearBody.type = RearBody.NONE;
			if (player.hasStatusEffect(StatusEffects.BlackNipples)) player.removeStatusEffect(StatusEffects.BlackNipples);
			if (player.averageNipplesPerBreast() > 1) player.breastRows[0].nipplesPerBreast = 1;
			if (player.breastRows.length > 1) player.breastRows.length = 1;
			var size:Number = 0;
			if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) >= 2) size += player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker2) - 1;
			player.breastRows[0].breastRating = size;
			if (player.hasStatusEffect(StatusEffects.Feeder)) {
				player.removeStatusEffect(StatusEffects.Feeder);
				player.removePerk(PerkLib.Feeder);
			}
			player.removeVagina(0, 1);
			if (player.hasStatusEffect(StatusEffects.Infested)) player.removeStatusEffect(StatusEffects.Infested);
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker3) == 1) player.clitLength = 0;
			if (player.statusEffectv1(StatusEffects.GargoyleTFSettingTracker3) == 2) {
				player.createVagina();
				player.clitLength = 0.5;
			}
			player.killCocks(-1);
			if (player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) >= 2) {
				player.createCock();
				var length:Number = 3;
				length += player.statusEffectv3(StatusEffects.GargoyleTFSettingTracker2) * 0.5;
				player.cocks[0].cockLength = length;
				player.cocks[0].cockThickness = Math.floor(((length / 5) - 0.1) * 10) / 10;
				player.cocks[0].cockType = CockTypesEnum.HUMAN;
				player.cocks[0].knotMultiplier = 1;
			}
			if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker3) == 1) {
				player.balls = 0;
				player.ballSize = 0;
			}
			if (player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker3) >= 2) {
				player.balls = 2;
				player.ballSize = player.statusEffectv2(StatusEffects.GargoyleTFSettingTracker3) - 1;
			}
			if (player.hasPerk(PerkLib.BlackHeart)) {
				player.removePerk(PerkLib.BlackHeart);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.BlackHeartEvolved)) {
				player.removePerk(PerkLib.BlackHeartEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.BlackHeartFinalForm)) {
				player.removePerk(PerkLib.BlackHeartFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.CatlikeNimbleness)) {
				player.removePerk(PerkLib.CatlikeNimbleness);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.CatlikeNimblenessEvolved)) {
				player.removePerk(PerkLib.CatlikeNimblenessEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.CaveWyrmLungs)) {
				player.removePerk(PerkLib.HinezumiBurningBlood);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.CaveWyrmLungsEvolved)) {
				player.removePerk(PerkLib.HinezumiBurningBloodEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.CaveWyrmLungsFinalForm)) {
				player.removePerk(PerkLib.HinezumiBurningBloodFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.DraconicLungs)) {
				player.removePerk(PerkLib.DraconicLungs);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.DraconicLungsEvolved)) {
				player.removePerk(PerkLib.DraconicLungsEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.DraconicLungsFinalForm)) {
				player.removePerk(PerkLib.DraconicLungsFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ElvishPeripheralNervSys)) {
				player.removePerk(PerkLib.ElvishPeripheralNervSys);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ElvishPeripheralNervSysEvolved)) {
				player.removePerk(PerkLib.ElvishPeripheralNervSysEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ElvishPeripheralNervSysFinalForm)) {
				player.removePerk(PerkLib.ElvishPeripheralNervSysFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.FrozenHeart)) {
				player.removePerk(PerkLib.FrozenHeart);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.FrozenHeartEvolved)) {
				player.removePerk(PerkLib.FrozenHeartEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.FrozenHeartFinalForm)) {
				player.removePerk(PerkLib.FrozenHeartFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.GorgonsEyes)) {
				player.removePerk(PerkLib.GorgonsEyes);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.GorgonsEyesEvolved)) {
				player.removePerk(PerkLib.GorgonsEyesEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.HellcatParathyroidGlands)) {
				player.removePerk(PerkLib.HinezumiBurningBlood);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.HellcatParathyroidGlandsEvolved)) {
				player.removePerk(PerkLib.HinezumiBurningBloodEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.HellcatParathyroidGlandsFinalForm)) {
				player.removePerk(PerkLib.HinezumiBurningBloodFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.HinezumiBurningBlood)) {
				player.removePerk(PerkLib.HinezumiBurningBlood);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.HinezumiBurningBloodEvolved)) {
				player.removePerk(PerkLib.HinezumiBurningBloodEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.HinezumiBurningBloodFinalForm)) {
				player.removePerk(PerkLib.HinezumiBurningBloodFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.HollowFangs)) {
				player.removePerk(PerkLib.HollowFangs);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.HollowFangsEvolved)) {
				player.removePerk(PerkLib.HollowFangsEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.HollowFangsFinalForm)) {
				player.removePerk(PerkLib.HollowFangsFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.KitsuneThyroidGland)) {
				player.removePerk(PerkLib.KitsuneThyroidGland);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved)) {
				player.removePerk(PerkLib.KitsuneThyroidGlandEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.KitsuneThyroidGlandFinalForm)) {
				player.removePerk(PerkLib.KitsuneThyroidGlandFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.LactaBovinaOvaries)) {
				player.removePerk(PerkLib.LactaBovinaOvaries);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.LactaBovinaOvariesEvolved)) {
				player.removePerk(PerkLib.LactaBovinaOvariesEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.LactaBovinaOvariesFinalForm)) {
				player.removePerk(PerkLib.LactaBovinaOvariesFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.LizanMarrow)) {
				player.removePerk(PerkLib.LizanMarrow);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.LizanMarrowEvolved)) {
				player.removePerk(PerkLib.LizanMarrowEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ManticoreMetabolism)) {
				player.removePerk(PerkLib.ManticoreMetabolism);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ManticoreMetabolismEvolved)) {
				player.removePerk(PerkLib.ManticoreMetabolismEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.MantislikeAgility)) {
				player.removePerk(PerkLib.MantislikeAgility);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.MantislikeAgilityEvolved)) {
				player.removePerk(PerkLib.MantislikeAgilityEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.MinotaurTesticles)) {
				player.removePerk(PerkLib.MinotaurTesticles);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.MinotaurTesticlesEvolved)) {
				player.removePerk(PerkLib.MinotaurTesticlesEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.MinotaurTesticlesFinalForm)) {
				player.removePerk(PerkLib.MinotaurTesticlesFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.NaturalPunchingBag)) {
				player.removePerk(PerkLib.NaturalPunchingBag);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.NaturalPunchingBagEvolved)) {
				player.removePerk(PerkLib.NaturalPunchingBagEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.NaturalPunchingBagFinalForm)) {
				player.removePerk(PerkLib.NaturalPunchingBagFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.NekomataThyroidGland)) {
				player.removePerk(PerkLib.HinezumiBurningBlood);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.NekomataThyroidGlandEvolved)) {
				player.removePerk(PerkLib.HinezumiBurningBloodEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.NekomataThyroidGlandFinalForm)) {
				player.removePerk(PerkLib.HinezumiBurningBloodFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ObsidianHeart)) {
				player.removePerk(PerkLib.ObsidianHeart);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ObsidianHeartEvolved)) {
				player.removePerk(PerkLib.ObsidianHeartEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ObsidianHeartFinalForm)) {
				player.removePerk(PerkLib.ObsidianHeartFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.OniMusculature)) {
				player.removePerk(PerkLib.OniMusculature);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.OniMusculatureEvolved)) {
				player.removePerk(PerkLib.OniMusculatureEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.OniMusculatureFinalForm)) {
				player.removePerk(PerkLib.OniMusculatureFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.OrcAdrenalGlands)) {
				player.removePerk(PerkLib.OrcAdrenalGlands);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.OrcAdrenalGlandsEvolved)) {
				player.removePerk(PerkLib.OrcAdrenalGlandsEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.OrcAdrenalGlandsFinalForm)) {
				player.removePerk(PerkLib.OrcAdrenalGlandsFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.PigBoarFat)) {
				player.removePerk(PerkLib.PigBoarFat);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.PigBoarFatEvolved)) {
				player.removePerk(PerkLib.PigBoarFatEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.PigBoarFatFinalForm)) {
				player.removePerk(PerkLib.PigBoarFatFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.SalamanderAdrenalGlands)) {
				player.removePerk(PerkLib.SalamanderAdrenalGlands);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.SalamanderAdrenalGlandsEvolved)) {
				player.removePerk(PerkLib.SalamanderAdrenalGlandsEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.SalamanderAdrenalGlandsFinalForm)) {
				player.removePerk(PerkLib.SalamanderAdrenalGlandsFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ScyllaInkGlands)) {
				player.removePerk(PerkLib.ScyllaInkGlands);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ScyllaInkGlandsEvolved)) {
				player.removePerk(PerkLib.ScyllaInkGlandsEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.TrachealSystem)) {
				player.removePerk(PerkLib.TrachealSystem);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.TrachealSystemEvolved)) {
				player.removePerk(PerkLib.TrachealSystemEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.TrachealSystemFinalForm)) {
				player.removePerk(PerkLib.TrachealSystemFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.VampiricBloodsteam)) {
				player.removePerk(PerkLib.VampiricBloodsteam);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.VampiricBloodsteamEvolved)) {
				player.removePerk(PerkLib.VampiricBloodsteamEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.VampiricBloodsteamFinalForm)) {
				player.removePerk(PerkLib.VampiricBloodsteamFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.VenomGlands)) {
				player.removePerk(PerkLib.VenomGlands);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.VenomGlandsEvolved)) {
				player.removePerk(PerkLib.VenomGlandsEvolved);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.VenomGlandsFinalForm)) {
				player.removePerk(PerkLib.VenomGlandsFinalForm);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ChimericalBodyInitialStage)){
				player.removePerk(PerkLib.ChimericalBodyInitialStage);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ChimericalBodySemiBasicStage)){
				player.removePerk(PerkLib.ChimericalBodySemiBasicStage);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ChimericalBodyBasicStage)){
				player.removePerk(PerkLib.ChimericalBodyBasicStage);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ChimericalBodySemiAdvancedStage)){
				player.removePerk(PerkLib.ChimericalBodySemiAdvancedStage);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ChimericalBodyAdvancedStage)){
				player.removePerk(PerkLib.ChimericalBodyAdvancedStage);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStage)){
				player.removePerk(PerkLib.ChimericalBodySemiSuperiorStage);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ChimericalBodySuperiorStage)){
				player.removePerk(PerkLib.ChimericalBodySuperiorStage);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ChimericalBodySemiPeerlessStage)){
				player.removePerk(PerkLib.ChimericalBodySemiPeerlessStage);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.ChimericalBodyPeerlessStage)) {
				player.removePerk(PerkLib.ChimericalBodyPeerlessStage);
				player.perkPoints += 1;
			}
			becomingGargoyleYes3();
		}
		public function becomingGargoyleYes3():void {
			outputText("You mix the blood with powdered coal, honey and drakeheart, creating the mixture required to paint the arcanic circles. You draw them around the statue under the worried gaze of Sapphire. Once done, you lay down on the altar, touching the statue with the soul gem and ask Sapphire to recite the words written in the book for you.\n\n");
			outputText("Sapphire protests for a few seconds, clearly upset by this \"<i>You can't be serious! You're planning to insert your own soul inside a gargoyle? Are you actually attempting suicide? This isn't something one should do so lightly!</i>\"\n\n");
			outputText("You reply that you will do whatever is needed to defeat the demons and if that means becoming an immortal artificial being, then so be it. Defeated by your determination, Sapphire finally complies as she chants \"<i>Shira Khrim Almisry Ohm Ak Tar Marae Kann Tharr Shul Elysro An Siryr Ahn Ekatyr Evenar Sethe Omaris!</i>\"\n\n");
			outputText("As she practically screams the last word, your vision fade to black and you lose consciousness.\n\n");
			outputText("You come to several seconds later and, as you open your eyes, it seems you're sitting on a pedestal, your pedestal. It looks like your previous body turned to ashes on the altar and is no more, so it will be extremely difficult going back to being human, if such a thing is even possible. You flex your arms for a few seconds admiring your perfectly defined form, majestic wings and ");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) outputText("marble");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) outputText("alabaster");
			outputText(" stone body, strong enough to shatter rocks and solid enough that the sharpest sword will leave you damageless as you’re suddenly rocked over by a terrifying hunger.\n\n");
			if (player.hasPerk(PerkLib.GargoylePure)) {
				outputText("Energy! You need energy to stay alive now. As you are masterless, while food used to be your main source of power, you are now a magical construct and Soulforce is what powers you now!\n\n");
				outputText("<b>Gain perk: Gargoyle - Need to gain sustenance from soulforce to stay alive.</b>\n\n");
			}
			else {
				outputText("Something went really wrong in the ritual. You're starting to crave fluids... any fluids and particularly cum and milk! Without an input of these, you feel you're gonna lose strength and eventually run out of energy, turning into an immobile ordinary statue! Worse yet, lust seems to creep up your mind like an uncontrollable wave. You need sex and you need it now!\n\n");
				outputText("<b>Gain perk: Corrupted Gargoyle - You need constant intakes of sexual fluids to stay alive.</b>\n\n");
				player.lust = player.maxLust();
			}
			if (flags[kFLAGS.HUNGER_ENABLED] == 0) flags[kFLAGS.HUNGER_ENABLED] = 0.5;
			player.createPerk(PerkLib.TransformationImmunity, 0, 0, 0, 0);
			player.destroyItems(useables.SOULGEM, 1);
			outputText("After the weird feelings subside, you pick up what is your actual pedestal and move it to your camp.\n\n");
			doNext(camp.returnToCampUseFourHours);
		}
	}
}