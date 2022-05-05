			else player.addStatusValue(StatusEffects.TempleOfTheDivineTracker, 2, -1);
			inventory.takeItem(weapons.EXCALIB, templeMainMenu);
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
			outputText("\n\nAs you place the pearl on the altar, you feel the holy power radiating from the temple increase a step further. The place practically radiates purity now. A horde of imps, attracted by the aura emanating from the temple, attempts to enter the building with the intention to put out the offending light. You prepare yourself for a fight, but end up watching in stunned silence as the corrupt beings catch fire and are reduced to ashes as soon as they fly inside the temple’s boundaries. It would seem the temple's divine protections have increased.");
			player.destroyItems(consumables.P_PEARL, 1);
			if (player.hasStatusEffect(StatusEffects.TempleOfTheDivineTracker)) player.addStatusValue(StatusEffects.TempleOfTheDivineTracker, 3, 2);
			else player.createStatusEffect(StatusEffects.TempleOfTheDivineTracker, 0, 0, 2, 0);
			doNext(templeMainMenu);
		}
		public function puttingPurePearlOnAltairNo():void {
			outputText("\n\nWhile it seems a good idea at first, you think you would prefer to keep the pearl for now.");
			doNext(templeMainMenu);
		}
		public function takingPurePearlFromAltair():void {
			clearOutput();
			outputText("You recover the pearl from the Altar. The temple's power dimms slightly.");
			player.addStatusValue(StatusEffects.TempleOfTheDivineTracker, 3, -2);
			inventory.takeItem(consumables.P_PEARL, templeMainMenu);
		}
		public function templeBasement():void {
			clearOutput();
			if (flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] == 2) {
				outputText("You wander back into the Temple basement atelier.");
				menu();
				addButton(0, "Statue", playerBuilder.currentStateOfStatue).hint("Check on the statue.");
				addButton(1, "Strange Book", playerBuilder.strangeBookOfGolems).hint("Examine the strange book.");
			if (flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] == 1) {
				outputText("As you wander down into the basement of the temple, you find what looks like an old abandoned Atelier. Down there is a plinth, surrounded by various depictions of what looks like gargoyles. One could follow their examples and create a gargoyle of their own.\n\n");
				flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE]++;
				menu();
				addButton(0, "Begin", playerBuilder.chooseToWorkOnStoneStatue);
				addButton(4, "Back", templeMainMenu);
			}
		}
	}
}
