/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Places.TempleOfTheDivine
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.Scenes.NPCs.Forgefather;

use namespace CoC;

	public class PlayerGargoyleBuilder extends BaseContent {

		public function PlayerGargoyleBuilder() {
		}



		public function strangeBookOfGolems():void {
			clearOutput();
			outputText("This book seems to explain the process of crafting a Gargoyle in length. It seems to imply your friend up there may have been made out from the soul of a willing sacrifice or a long dead person. Will you read it?");
			menu();
			addButton(0, "Read", readStrangeBookOfGolems);
			addButton(1, "Back", SceneLib.templeofdivine.templeBasement);
		}
		public function readStrangeBookOfGolems():void {
			clearOutput();
			outputText("You read the book with keen interest, perhaps you can learn something useful from it.\n\n");
			outputText("GOLEMANCY THE ART OF SOULCRAFT\n\n");
			outputText("By Aerin Fowl priest of Marae\n\n");
			outputText("Golemancy is the art of creating an artificial being from the combination of a statue and a soul. While any soul can give life to a golem, for the purpose of giving it at least minimal intelligence and autonomy, it is recommended to use the soul of a living or deceased humanoid. The most suiting and moral soul for such a purpose is generally the soul of a person near death’s door or a willing sacrifice. ");
			outputText("Most of the Gargoyle crafted in this way are infused with the soul of pious priests and nun willing to protect the church of Marae for all eternity. Golems know no hunger or pain, but can be destroyed thus freeing their soul back. To prevent such a thing most golem are given the ability to recover by eating raw stone in order to repair themselves magically. To create a golem start by sculpting a suitable vessel for the soul. ");
			outputText("Once this is done, place the body of the sacrifice or the captured soul of the being you wish to infuse your golem with on a sacred altar. Have the statue, still on its pedestal, carried over to face the altar but at a safe distance in case it accidentally lashes out at you in confusion upon awakening. It is often the case for already dead sacrifices, who are often snatched from the afterlife or have lounged in anguish for months inside the soul gem before being prepared.\n\n");
			outputText("Finally, bind the golem by making a magic circle with the enchantments you wish to place in order to limit its freedom to whatever purpose you want. Make a second and final magic circle below the pedestal in order to bind the soul to the vessel, but keep in mind blood is needed to craft such a circle. Any blood will do as it is essentially a symbol of life. Keep in mind using anything but blood will ruin the ritual entirely. ");
			outputText("You will need several additional ingredients: a drake heart flower, some pure honey, powdered coal mixed in the blood and finally a soul gem, ready to be filled with the soul of the sacrifice, if any, with them already touching the golem in a way or another. In the case where the sacrifice is already in the gem make sure the gem touches the statue. Once this is all done, you're finally ready to transfer the soul to the golem. ");
			outputText("Should the sacrifice still be alive, it’s physical body will likely die as its soul is sucked into your creation. There is no turning back once it's done, so make sure the subject is ready physically and psychologically to welcome the change. Stand facing the statue but on the opposite side of the central altar and recite the following arcane word in order to proceed to the transfer.\n\n");
			outputText("Shira Khrim Almisry Ohm Ak Tar Marae Kann Tharr Shul Elysro An Siryr Ahn Ekatyr Evenar Sethe Omaris.\n\n");
			outputText("You think you could use this information to perhaps turn yourself into a living weapon in order to defeat the demons with relative ease. The question you should ask yourself however is... is this really what you want?");
			if (flags[kFLAGS.GARGOYLE_QUEST] == 1) {
				if (player.hasKeyItem("Soul Gem Research") >= 0) flags[kFLAGS.GARGOYLE_QUEST] = 3;
				flags[kFLAGS.GARGOYLE_QUEST]++;
			}
			doNext(SceneLib.templeofdivine.templeBasement);
		}

		public function currentStateOfStatue():void {
			clearOutput();
			outputText("This statue looks like ");
			if (Forgefather.statueProgress >= 11) outputText("a finished");
			else outputText("an incomplete stone gargoyle. This statue looks like ");
			if (Forgefather.gender == 1) outputText("it has a gorgeous female face");
			if (Forgefather.gender == 2) outputText("it has a handsome male face");
			if (Forgefather.gender == 3) outputText("it has a face that would look good on a male or a female");
			if (Forgefather.gender == 0) outputText("its face is yet to be finished");
			outputText(" and its ");
			if (Forgefather.hairLength == 1) outputText("bald head looks great.");
			if (Forgefather.hairLength == 2) outputText("short hair looks great.");
			if (Forgefather.hairLength == 3) outputText("moderately long hair looks great.");
			if (Forgefather.hairLength == 4) outputText("long hair looks great.");
			if (Forgefather.hairLength == 0) outputText("hair is yet to be sculpted.");
			if (Forgefather.chest > 0) {
				outputText("\n\nStatue have ");
				if (Forgefather.chest == 1)outputText("flat chest");
				else outputText(Appearance.breastCup(Forgefather.chest - 1) + " breasts");
				outputText(".\n\n");
			}
			if (Forgefather.chest == 0) outputText("\n\nThere's a block where its chest would be.\n\n");
			if ((Forgefather.cock < 1) && ((Forgefather.vagina) < 1 || Forgefather.balls < 1)) outputText("There's a block where its crotch would be.");
			else {
				outputText("At the statue crotch ");
				if (Forgefather.cock > 1) {
					outputText("hangs a ");
					outputText(String(4.0 + (Forgefather.cock - 2) * 0.5) + "-inch");
					outputText(" long cock");
					if (Forgefather.balls > 1) {
						outputText(" along with a pair of ");
						if (Forgefather.balls == 2) outputText("large");
						if (Forgefather.balls == 3) outputText("baseball-sized");
						if (Forgefather.balls == 4) outputText("apple-sized");
						if (Forgefather.balls == 5) outputText("grapefruit-sized");
						outputText(" balls");
					}
					outputText(".");
				}
				if (Forgefather.cock == 1 && Forgefather.balls > 1) {
					outputText(" rests a pair of ");
					if (Forgefather.balls == 2) outputText("large");
					if (Forgefather.balls == 3) outputText("baseball-sized");
					if (Forgefather.balls == 4) outputText("apple-sized");
					if (Forgefather.balls == 5) outputText("grapefruit-sized");
					outputText(" balls.");
				}
				if (Forgefather.vagina > 0) {
					if (Forgefather.vagina  == 2) {
						if (Forgefather.balls > 1) outputText(" Beneath them");
						else if (Forgefather.cock > 1) outputText(" Beneath it");
						outputText(" is a tight vagina, with a tiny clit.");
					}
					else outputText("");
				}
			}
			outputText("\n\nAll the details in its");
			if (Forgefather.wings == 1) outputText(" bat");
			if (Forgefather.wings == 2) outputText(" feathered");
			outputText(" wings ");
			if (Forgefather.wings >= 1) outputText("are completed, and the wings folded behind its back");
			else outputText("have yet to be done");
			outputText(".\n\nIt's arms ");
			if (Forgefather.arms == 1) outputText("ends with a set of bestial four fingered sharp stone claws");
			if (Forgefather.arms == 2) outputText("ends with very human fist");
			if (Forgefather.arms == 0) outputText("have yet to be sculpted");
			outputText(". It's legs ");
			if (Forgefather.lowerBody == 1) outputText("ends with clawed bestial feets with three toe at the front and one at the back");
			if (Forgefather.lowerBody == 2) outputText("are human like");
			if (Forgefather.lowerBody == 0) outputText("have yet to be defined");
			outputText(". Its ");
			if (Forgefather.tail == 1) outputText("mace like");
			if (Forgefather.tail == 2) outputText("axe like");
			if (Forgefather.tail == 0) outputText("unfinished");
			outputText(" tail seems to be there right above its ");
			if (Forgefather.gender != 0) {
				outputText("perfectly made ");
				if (Forgefather.gender == 1) outputText("feminine");
				if (Forgefather.gender == 2) outputText("masculine");
				if (Forgefather.gender == 3) outputText("androgynous");
			}
			if (Forgefather.gender == 0 )outputText("unfinished");
			outputText(" body.");
			if (Forgefather.statueProgress >= 1) outputText("\n\nProgress: " + Forgefather.statueProgress);
			menu();
			if (Forgefather.gender < 1) addButton(0, "Frame&Face", SculptFrameAndFace);
			else addButtonDisabled(0, "Frame&Face", "You already sculpted the Frame and Face.");
			if (Forgefather.wings < 1) addButton(1, "Wings", SculptWings);
			else addButtonDisabled(1, "Wings", "You already sculpted the Wings.");
			if (Forgefather.tail < 1) addButton(2, "Tail", SculptTail);
			else addButtonDisabled(2, "Tail", "You already sculpted the Tail.");
			if (Forgefather.lowerBody < 1) addButton(3, "Legs", SculptLegs);
			else addButtonDisabled(3, "Legs", "You already sculpted the Legs.");
			if (Forgefather.arms < 1) addButton(4, "Arms", SculptArms);
			else addButtonDisabled(4, "Arms", "You already sculpted the Arms.");
			if (Forgefather.hairLength < 1) addButton(5, "Hair", SculptHair);
			else addButtonDisabled(5, "Hair", "You already sculpted the Hair.");
			if (Forgefather.chest < 1) addButton(6, "Chest", SculptChest);
			else addButtonDisabled(6, "Chest", "You already sculpted the Chest.");
			if (Forgefather.vagina < 1) addButton(7, "Pussy", SculptPussy);
			else addButtonDisabled(7, "Pussy", "You already sculpted the Pussy Area.");
			if (Forgefather.cock < 1) addButton(8, "Cock", SculptCock);
			else addButtonDisabled(8, "Cock", "You already sculpted the Cock Area.");
			if (Forgefather.balls < 1) addButton(9, "Balls", SculptBalls);
			else addButtonDisabled(9, "Balls", "You already sculpted the Balls Area.");
			if (Forgefather.statueProgress >= 10 && flags[kFLAGS.GARGOYLE_QUEST] >= 3 && !player.isGargoyle()) addButton(13, "Ritual", becomingGargoyle);
			addButton(14, "Back", BackToSapphire);
		}
		public function BackToSapphire():void {
			clearOutput();
			outputText("You decide to come back later to finish the work.");
			doNext(SceneLib.templeofdivine.templeMainMenu);
		}

		public function chooseToWorkOnStoneStatue():void {
			//flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 1;
			flags[kFLAGS.GARGOYLE_BODY_SCULPTING_PROGRESS] = 1;
			flags[kFLAGS.GARGOYLE_QUEST] = 1;
			//flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 0;
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
			SceneLib.forgefatherScene.setGargoyleGender(1);
			SecondPartOfSculptingText();
		}
		public function SculptMasculineFrameAndFace():void {
			SceneLib.forgefatherScene.setGargoyleGender(2);
			SecondPartOfSculptingText();
		}
		public function SculptAndrogynousFrameAndFace():void {
			SceneLib.forgefatherScene.setGargoyleGender(3);
			SecondPartOfSculptingText();
		}

		public function SculptWings():void {
			menu();
			addButton(0, "Bat", SculptBatWings).hint("Sculpt bat wings.");
			addButton(1, "Feathered", SculptFeatheredWings).hint("Sculpt feathered wings.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptBatWings():void {
			SceneLib.forgefatherScene.setGargoyleWings(2);
			//flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 2;
			SecondPartOfSculptingText();
		}
		public function SculptFeatheredWings():void {
			SceneLib.forgefatherScene.setGargoyleWings(1);
			//flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 1;
			SecondPartOfSculptingText();
		}

		public function SculptTail():void {
			menu();
			addButton(0, "Mace", SculptMaceTail).hint("Sculpt mace shaped tail tip.");
			addButton(1, "Axe", SculptAxeTail).hint("Sculpt axe shaped tail tip.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptMaceTail():void {
			SceneLib.forgefatherScene.setGargoyleTail(1);
			SecondPartOfSculptingText();
		}
		public function SculptAxeTail():void {
			SceneLib.forgefatherScene.setGargoyleTail(2);
			SecondPartOfSculptingText();
		}

		public function SculptLegs():void {
			menu();
			addButton(0, "Clawed", SculptClawedLegs).hint("Sculpt clawed legs.");
			addButton(1, "Humane", SculptHumaneLegs).hint("Sculpt humane legs.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptClawedLegs():void {
			SceneLib.forgefatherScene.setGargoyleLowerBody(1);
			SecondPartOfSculptingText();
		}
		public function SculptHumaneLegs():void {
			SceneLib.forgefatherScene.setGargoyleLowerBody(2);
			SecondPartOfSculptingText();
		}

		public function SculptArms():void {
			menu();
			addButton(0, "Clawed", SculptClawedArms).hint("Sculpt clawed arms.");
			addButton(1, "Humane", SculptHumaneArms).hint("Sculpt humane arms.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptClawedArms():void {
			SceneLib.forgefatherScene.setGargoyleArms(1);
			SecondPartOfSculptingText();
		}
		public function SculptHumaneArms():void {
			SceneLib.forgefatherScene.setGargoyleArms(2);
			SecondPartOfSculptingText();
		}

		public function SculptHair():void {
			menu();
			addButton(0, "Bald", sculptHairSelected, 1).hint("Sculpt bald head.");
			addButton(1, "Short", sculptHairSelected, 2).hint("Sculpt short hair on statue head.");
			addButton(2, "Medium", sculptHairSelected, 3).hint("Sculpt medium long hair on statue head.");
			addButton(3, "Long", sculptHairSelected, 4).hint("Sculpt long hair on statue head.");
			addButton(14, "Back", currentStateOfStatue);
		}

		private function sculptHairSelected(setTo:int):void {
			SceneLib.forgefatherScene.setGargoyleHair(setTo);
			SecondPartOfSculptingText();
		}

		public function SculptChest():void {
			menu();
			addButton(0, "Flat", 	sculptChestSelected, 1).hint("Sculpt flat chest.");
			addButton(1, "A-cup", 	sculptChestSelected, 2).hint("Sculpt A-cup breasts.");
			addButton(2, "B-cup", 	sculptChestSelected, 3).hint("Sculpt B-cup breasts.");
			addButton(3, "C-cup", 	sculptChestSelected, 4).hint("Sculpt C-cup breasts.");
			addButton(4, "D-cup", 	sculptChestSelected, 5).hint("Sculpt D-cup breasts.");
			addButton(5, "DD-cup", sculptChestSelected, 6).hint("Sculpt DD-cup breasts.");
			addButton(6, "Big DD-cup", sculptChestSelected, 7).hint("Sculpt Big DD-cup breasts.");
			addButton(14, "Back", currentStateOfStatue);
		}

		private function sculptChestSelected(setTo:int):void {
			SceneLib.forgefatherScene.setGargoyleChest(setTo);
			SecondPartOfSculptingText();
		}

		public function SculptPussy():void {
			menu();
			if (Forgefather.cock != 1) addButton(0, "No", SculptPussyNo).hint("Don't sculpt pussy.");
			addButton(1, "Yes", SculptPussyYes).hint("Sculpt pussy.");
			addButton(14, "Back", currentStateOfStatue);
		}
		public function SculptPussyNo():void {
			SceneLib.forgefatherScene.setGargoyleVagina(1);
			SecondPartOfSculptingText();
		}
		public function SculptPussyYes():void {
			SceneLib.forgefatherScene.setGargoyleVagina(2);
			SecondPartOfSculptingText();
		}

		public function SculptCock():void {
			menu();
			if (Forgefather.vagina != 1) addButton(0, "None", sculptCockSelected, 1).hint("Don't sculpt cock.");
			addButton(1, "4\"", 	sculptCockSelected, 2).hint("Sculpt 4' cock.");
			addButton(2, "4.5\"", 	sculptCockSelected, 3).hint("Sculpt 4.5' cock.");
			addButton(3, "5\"", 	sculptCockSelected, 4).hint("Sculpt 5' cock.");
			addButton(4, "5.5\"", 	sculptCockSelected, 5).hint("Sculpt 5.5' cock.");
			addButton(5, "6\"", 	sculptCockSelected, 6).hint("Sculpt 6' cock.");
			addButton(6, "6.5\"", 	sculptCockSelected, 7).hint("Sculpt 6.5' cock.");
			addButton(7, "7\"", 	sculptCockSelected, 8).hint("Sculpt 7' cock.");
			addButton(8, "7.5\"", 	sculptCockSelected, 9).hint("Sculpt 7.5' cock.");
			addButton(9, "8\"", 	sculptCockSelected, 10).hint("Sculpt 8' cock.");
			addButton(10, "8.5\"", sculptCockSelected, 11).hint("Sculpt 8.5' cock.");
			addButton(11, "9\"", 	sculptCockSelected, 12).hint("Sculpt 9' cock.");
			addButton(14, "Back", currentStateOfStatue);
		}

		private function sculptCockSelected(setTo:int):void {
			SceneLib.forgefatherScene.setGargoyleCock(setTo);
			SecondPartOfSculptingText();
		}

		public function SculptBalls():void {
			menu();
			addButton(0, "No", sculptBallsSelected, 1).hint("Don't sculpt balls.");
			if (Forgefather.cock >= 2)  {
				addButton(1, "Large", 		sculptBallsSelected, 2).hint("Sculpt large balls.");
				addButton(2, "Baseball", 	sculptBallsSelected, 3).hint("Sculpt baseball-sized balls.");
				addButton(3, "Apple", 		sculptBallsSelected, 4).hint("Sculpt apple-sized balls.");
				addButton(4, "Grapefruit", sculptBallsSelected, 5).hint("Sculpt grapefruit-sized balls.");
			}
			addButton(14, "Back", currentStateOfStatue);
		}

		private function sculptBallsSelected(setTo:int):void {
			SceneLib.forgefatherScene.setGargoyleBalls(setTo);
			SecondPartOfSculptingText();
		}

		public function SecondPartOfSculptingText():void {
			clearOutput();
			outputText("You work for six hours, sculpting the statue part to your liking with an artist's passion, then head back to camp for a break.");
			if (Forgefather.statueProgress > 0) Forgefather.statueProgress++;
			else Forgefather.statueProgress = 1;
			doNext(camp.returnToCampUseSixHours);
		}

		public function becomingGargoyle():void {
			clearOutput();
			if (player.hasKeyItem("Gargoyle demonic researches") >= 0 && player.hasItem(useables.SOULGEM, 1) && flags[kFLAGS.GARGOYLE_QUEST] < 6) flags[kFLAGS.GARGOYLE_QUEST] = 6;
			if (player.hasKeyItem("Gargoyle demonic researches") >= 0 && player.hasItem(useables.SOULGEM, 1) && flags[kFLAGS.GARGOYLE_QUEST] == 6) {
				if (player.inte < 80) {
					outputText("While you do have all the ingredient required as it states in the formula you feel you don't understand magic well enough yet to risk the ritual. Who knows, what fate awaits you, should you fail it. You resolve to come back when you have enough arcane knowledge to attempt this.");
					doNext(SceneLib.templeofdivine.templeBasement);
				}
				else if (player.isPregnant() || player.isButtPregnant()) {
					outputText("You can't become Gargoyle while pregnant. Come back after you give a birth.");
					doNext(SceneLib.templeofdivine.templeBasement);
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
				doNext(SceneLib.templeofdivine.templeBasement);
			}
		}
		public function becomingGargoyleNo():void {
			clearOutput();
			outputText("This is something that is gonna change your entire life and while you're ready to do anything to stop the demons, you're not sure this is what you want yet. You resolve to come back and do the ritual once you truly are ready for it.");
			doNext(SceneLib.templeofdivine.templeBasement);
		}
		public function becomingGargoyleYes():void {
			clearOutput();
			outputText("You proceed according to the ritual as described in the book, however a question poses itself. What kind of blood will you use?");
			menu();
			addButton(0, "OwnBlood", becomingGargoyleYesOwnBlood).hint("Your body would need regular intake of raw soulforce.");
			if (player.hasItem(consumables.MINOBLO, 1)) addButton(1, "Minotaur", becomingGargoyleYesMinotaurBlood).hint("Your body would need regular intake of sexual fluids.");
			else addButtonDisabled(1, "Minotaur", "Need Minotaur Blood vial for this option");
			addButton(2, "Back", SceneLib.templeofdivine.templeBasement)
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
			SceneLib.forgefatherScene.createGargoyleState();
			outputText("You mix the blood with powdered coal, honey and drakeheart, creating the mixture required to paint the arcanic circles. You draw them around the statue under the worried gaze of Sapphire. Once done, you lay down on the altar, touching the statue with the soul gem and ask Sapphire to recite the words written in the book for you.\n\n");
			outputText("Sapphire protests for a few seconds, clearly upset by this \"<i>You can't be serious! You're planning to insert your own soul inside a gargoyle? Are you actually attempting suicide? This isn't something one should do so lightly!</i>\"\n\n");
			outputText("You reply that you will do whatever is needed to defeat the demons and if that means becoming an immortal artificial being, then so be it. Defeated by your determination, Sapphire finally complies as she chants \"<i>Shira Khrim Almisry Ohm Ak Tar Marae Kann Tharr Shul Elysro An Siryr Ahn Ekatyr Evenar Sethe Omaris!</i>\"\n\n");
			outputText("As she practically screams the last word, your vision fade to black, and you lose consciousness.\n\n");
			outputText("You come to several seconds later and, as you open your eyes, it seems you're sitting on a pedestal, your pedestal. It looks like your previous body turned to ashes on the altar and is no more, so it will be extremely difficult going back to being human, if such a thing is even possible. You flex your arms for a few seconds admiring your perfectly defined form, majestic wings and ");
			//if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) outputText("marble");
			//if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) outputText("alabaster");
			outputText("stone body, strong enough to shatter rocks and solid enough that the sharpest sword will leave you damageless as you’re suddenly rocked over by a terrifying hunger.\n\n");
			if (player.hasPerk(PerkLib.GargoylePure)) {
				outputText("Energy! You need energy to stay alive now. As you are masterless, while food used to be your main source of power, you are now a magical construct and Soulforce is what powers you now!\n\n");
				outputText("<b>Gain perk: Gargoyle - Need to gain sustenance from soulforce to stay alive.</b>\n\n");
			}
			else {
				outputText("Something went really wrong in the ritual. You're starting to crave fluids... any fluids and particularly cum and milk! Without an input of these, you feel you're gonna lose strength and eventually run out of energy, turning into an immobile ordinary statue! Worse yet, lust seems to creep up your mind like an uncontrollable wave. You need sex, and you need it now!\n\n");
				outputText("<b>Gain perk: Corrupted Gargoyle - You need constant intakes of sexual fluids to stay alive.</b>\n\n");
				player.lust = player.maxLust();
			}
			if (flags[kFLAGS.HUNGER_ENABLED] == 0) flags[kFLAGS.HUNGER_ENABLED] = 0.5;
			if (player.hasPerk(PerkLib.BimboBody)) player.removePerk(PerkLib.BimboBody);
			if (player.hasPerk(PerkLib.BimboBrains)) player.removePerk(PerkLib.BimboBrains);
			if (player.hasPerk(PerkLib.BroBody)) player.removePerk(PerkLib.BroBody);
			if (player.hasPerk(PerkLib.BroBrains)) player.removePerk(PerkLib.BroBrains);
			if (player.hasPerk(PerkLib.FutaForm)) player.removePerk(PerkLib.FutaForm);
			if (player.hasPerk(PerkLib.FutaFaculties)) player.removePerk(PerkLib.FutaFaculties);
			player.createPerk(PerkLib.TransformationImmunity, 0, 0, 0, 0);
			player.strtouspeintwislibsenCalculation2();
			player.destroyItems(useables.SOULGEM, 1);
			outputText("After the weird feelings subside, you pick up what is your actual pedestal and move it to your camp.\n\n");
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			doNext(camp.returnToCampUseFourHours);
		}
	}
}