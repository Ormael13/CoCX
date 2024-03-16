/**
 * ...
 * @author Ormael
 */
package classes.Scenes
{
import classes.*;
import classes.BodyParts.*;
import classes.GeneticMemories.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.*;
import classes.Items.Dynamic.DynamicWeapon;
import classes.Scenes.Areas.DeepSea.Kraken;
import classes.Scenes.Areas.Mountain.Minotaur;
import classes.Scenes.Camp.CampStatsAndResources;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.D3.SuccubusGardener;
import classes.Scenes.Dungeons.DesertCave.SandMother;
import classes.Scenes.Dungeons.EbonLabyrinth.*;
import classes.Scenes.Explore.Pierce;
import classes.Scenes.Monsters.Malikore;
import classes.Scenes.NPCs.Alvina;
import classes.Scenes.NPCs.Aria;
import classes.Scenes.NPCs.Belisa;
import classes.Scenes.NPCs.BelisaFollower;
import classes.Scenes.NPCs.Carrera;
import classes.Scenes.NPCs.DivaScene;
import classes.Scenes.NPCs.DriderTown;
import classes.Scenes.NPCs.EvangelineFollower;
import classes.Scenes.NPCs.Galia;
import classes.Scenes.NPCs.Lilith;
import classes.Scenes.NPCs.LilyFollower;
import classes.Scenes.NPCs.RyuBiDragon;
import classes.Scenes.NPCs.Sonya;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.NPCs.WaizAbi;
import classes.Scenes.Places.Boat.Marae;
import classes.Scenes.Places.HeXinDao.AdventurerGuild;
import classes.Scenes.Dungeons.DeepCave.Zetaz;
import classes.Scenes.Dungeons.Factory.OmnibusOverseer;
import classes.Scenes.Dungeons.DemonLab.Incels;
import classes.Scenes.Dungeons.EbonLabyrinth.Draculina;
import classes.Stats.Buff;

import coc.view.ButtonDataList;

use namespace CoC;

public class TestMenu extends BaseContent
	{
	public function SoulforceCheats():void{
		clearOutput();
		outputText("Collection of different cheats that can be used by the players.");
		outputText("\n\nAscension points: " + player.ascensionPerkPoints + "");
		var bd:ButtonDataList = new ButtonDataList();
		bd.add("StatsAdj/Ascen", StatsAscensionMenu, "For more precisely adjusting each of the 8 main stats and Ascension related stuff.");
		bd.add("P/G/XP", PerksGemsEXP, "Adding/Removing perk points and adding gems/exp.");
		bd.add("LvL/DLvL", LevelDeLevel, "Adding/Substracting levels.");
		bd.add("Quick Flags", modFlagsMenu, "Menu to edit some some flags quickly for debugging");
		bd.add("Equip", EquipmentMenu, "For creating various equipment items for tests.");
		bd.add("NonEquip", NonEquipmentMenu, "For creating various non-equipment items for tests.");
		bd.add("Materials", MaterialMenu, "For creating various materials for tests.");
		bd.add("Enemies", enemiesMenu, "For spawning various enemies to test fight them.");
		bd.add("Camp NPC's", FasterOrInstantCampNPCRecruitment, "Menu to speed up recruitment of camp npc's due to testing needs.");
		bd.add("Body State", BodyStateMenu, "For more precisely adjusting a few other body values or parts than Stats Adj option.");
		bd.add("MetamorphFull", AllMetamorphOptionsUnlock, "Unlock all Metamorph options.").disableIf(!player.hasPerk(PerkLib.Metamorph));
		bd.add("BodyPartEditor", curry(SceneLib.debugMenu.bodyPartEditorRoot, SoulforceCheats), "");
		bd.add("Insta-house", instaHouse, "Instant-house + bed. No Mutant here.");
		bd.add("Learn Hexes", learnHexes, "Learn Prestige Job - Warlock and different hex spells");
		bd.add("WendigoTrigger", wendigoTrigger, "Trigger Wendigo transformation. (Without active Wendigo Psychosis will do nothing ;) )");
		bd.add("ChimeraBodyUlt", ChimeraBodyUltimateStage, "Ultimate Stage of Chimera Body for tests and lulz. Now with on/off switch for more lulz.");
		bd.add("All4HiddenPrestige", hiddenPJ, "A11 th4t H1dd3n Prestige is Y0urs to T4ke!!!");
		bd.add("PerkGalore1", PerkGalore1, "");
		bd.add("PerkGalore2", PerkGalore2, "");
		bd.add("RemoveRP", cheatRemoveRP, "Remove Racial Paragon perk");
		bd.add("Fix Shards", cheatFixShards, "Check the player's quests and give the deserved shards.");
		bd.add("Add Shard", cheatAddShard, "Add 1 radiant shard");
		bd.add("Remove Shard", cheatRemoveShard, "Remove 1 radiant shard");
		bd.add("Refill SF", refillSoulforce, "Refill your Soulforce.");
		bd.add("EvaMutateReq", mutateReqNope, "Turns on/off mutation requirements");
		bd.add("IdentifyAll", identifyAll, "Identify all items");
		bd.add("UncurseAll", uncurseAll, "Uncurse all items");
		bd.add("Gren Mag perks", FaeDragTest1, "Add gren magic boosting perks.").disableIf(player.hasPerk(PerkLib.ArcaneVenom));
		bd.add("FaeDragBParts", FaeDragTest2, "Add missing fairy dragon bodyparts.");
		bd.add("Handmaiden stripes", FaeDragTest3, "Add chitin and stripes to handmaiden.").disableIf(!player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden));
		bd.add("FixFJiasngshi", fixFormerJiangshi, "Removig leftover effects of cursed tag after curginh Jiangshi state.");
		//bd.add("DinCheatShop", curry(SceneLib.dinahScene.openShop, true), "Open Dinah shop with everything unlocked. Normally, you have to defeat a boss to unlock its TF; and all 'Roulette' items appear randomly.")
		bd.add("DebugMenu", SceneLib.debugMenu.accessDebugMenu, "The older debug menu. Who knows what it hides?");
		bd.add("Bugfixes", cheatBugfixes, "Buttons or fixing some rare old bugs that can't be fixd with save-updater.");
		bd.add("Testing", cheatTesting, "Buttons for testing some new stuff. May break your game if something is outdated.");
		bd.add("Bags expansion", SceneLib.garden.justForTestBuildsAdjustingBagsCapacityCuzINotWannaWasteSaveUpdateForThat, "Expand the bags. (If you not own any of them will not have any effect)");
		bd.add("NoMoreKillInst", FairyTest4, "Removing bonus 'Killing Intent' perks after first one.").disableIf(!player.hasPerk(PerkLib.KillingIntent));
		submenu(bd, playerMenu, 0, false);
	}

	private function cheatBugfixes():void {
		clearOutput();
		outputText("Cheats made for fixing some rare bugs that can't be fixed with save-updates. Do we even have them yet? Probably 90% of this stuff is outdated.");
		var bd:ButtonDataList = new ButtonDataList();
		bd.add("TyrantPF", FairyTest5, "Patching Tyrantia corrupted legendaries unlock").disableIf(TyrantiaFollower.TyrantiaFollowerStage == 5 && TyrantiaFollower.TyraniaCorrupteedLegendaries == 0);
		bd.add("LilyPregF", FairyTest3, "Curing Lily Infertility ^^").disableIf(DriderTown.LilyKidsPCPregnancy != 0 && LilyFollower.LilyFollowerState);
		bd.add("TheHangover4",hangoverS4, "Removes Hangover from the player (by leaving you on the roof of the hotel. Hope you brought a mattress and water!)");
		bd.add("QuestItBag", AddMaxBackpack2, "Giving missing Quest Items Bag as part of Adventure Guild welcome/promotion package.");
		bd.add("ClickItOnce", AddMaxBackpack3, "Fixing Lover Zenji missing one status effect needed for his sex scenes menu.").disableIf(!player.hasStatusEffect(StatusEffects.ZenjiZList));
		bd.add("BeliConfFix", belisatest2, "Belisa Confession Fix").disableIf(TyrantiaFollower.isLover() && BelisaFollower.BelisaFollowerStage >= 5 && BelisaFollower.BelisaEncounternum >= 5 && BelisaFollower.BelisaAffectionMeter >= 80 && !BelisaFollower.BelisaConfessed);
		bd.add("FixJiangshi", jiangshiBuggedItemsCleanUpCrew0, "Shit! Here we go Again! Fixing Jiangshi! (better use it only once or may be some bugs i not plan to account for in case of using this more than once - i not blocked using it more than once so belive ppl will be reasonable to not click like mad this)");
		bd.add("ClickItTwice", golemArmy, "Golem Army and Ascension: Additional Organ Mutation/Prestige perks correction pre global save upgrade on new public build.");
		bd.add("FixClones", fixClones, "If you have messed up clones or negative levels or related outdated data this will clear it all away.");
		submenu(bd, SoulforceCheats, 0, false);
	}
	
	private function cheatTesting():void {
		clearOutput();
		outputText("Cheats made specifically for the testing needs. Use only if you're sure what you're doing - outdated test-cheats may break something and nobody will look into such bugs.");
		var bd:ButtonDataList = new ButtonDataList();
		bd.add("LilyTest", lilytest, "Lily Trigger").disableIf(!LilyFollower.LilyFollowerState);
		bd.add("NY(S/NS)MA-D", anTrigger, "Now you see or not see me.\n\n<i><b>(Anty-Dexterity)</b></i>");
		bd.add("NewSoulCult", applyHangover, "Cripple your cultivation base to start anew (with a bit more milf fluff in your life).");
		bd.add("LustBreath", FairyTest, "Replacing 1 perk with another").disableIf(player.hasPerk(PerkLib.DragonPoisonBreath));
		bd.add(":Re", AddMaxBackpack5, "Rewind Evangeline.").disableIf(flags[kFLAGS.EVANGELINE_LVL_UP] > 0);
		bd.add("RevertCabin", RevertCabinProgress, "Revert cabin flag back to value 2 (for bug fix test)");
		bd.add("Gargoyle", GargoyleMenu, "To Be or Not To Be Gargoyle that is a question.");
		bd.add("BelisaTest", belisatest3, "Belisa Trigger").disableIf(BelisaFollower.BelisaInGame && BelisaFollower.BelisaFollowerStage < 3);
		bd.add("Test dynamic stat", TestDynamicStats, "Test Dynamic stats.");
		bd.add("Neko Items", giveNekoItems, "All new neko items from Nekobake Inn doc");
		bd.add("DantianPhylactery", dantianPhylacteryTest, "Getting or loosing Dantian Phylactery.");
		submenu(bd, SoulforceCheats, 0, false);
	}

	private function FaeDragTest2():void{
		clearOutput();
		player.tailType = Tail.FEY_DRACONIC;
		player.arms.type = Arms.FEY_DRACONIC;
		player.lowerBody = LowerBody.FEY_DRAGON;
		outputText("Faerie dragon bodyparts gained.");
		doNext(SoulforceCheats);
	}

	private function FaeDragTest1():void{
		clearOutput();
		if (!player.hasPerk(PerkLib.GreenMagic)) player.createPerk(PerkLib.GreenMagic, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.VerdantLeech)) player.createPerk(PerkLib.VerdantLeech, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.ArcaneVenom)) player.createPerk(PerkLib.ArcaneVenom, 0, 0, 0, 0);
		outputText("Green magic boosting perks gained.");
		doNext(SoulforceCheats);
	}
	
	private function FaeDragTest3():void {
		clearOutput();
		transformations.SkinPatternBeeStripes.applyEffect();
		outputText("Handmaiden chitin and bee stripes operationa...just fixed.");
		doNext(SoulforceCheats);
	}

	private function hangoverS4():void{
		clearOutput();
		if (player.statStore.hasBuff('Hangover')) {
			player.statStore.removeBuffs('Hangover');
			outputText("IVs have been inserted and fluids replenished.");
		}
		else{
			outputText("Stop messing about in the ICU and go away.");
		}
		doNext(SoulforceCheats);
	}
	
	private function identifyAll():void {
		clearOutput();
		if (player.weapon is DynamicWeapon && !(player.weapon as DynamicWeapon).identified) {
			player.setWeapon((player.weapon as DynamicWeapon).identifiedCopy() as DynamicWeapon);
			outputText("\nIdentified "+player.weapon.longName);
		}
		for (var i:int = 0; i < player.itemSlots.length; i++) {
			var item:ItemSlotClass = player.itemSlots[i];
			if (item.unlocked && item.quantity > 0) {
				if (item.itype is DynamicWeapon && !(item.itype as DynamicWeapon).identified) {
					player.itemSlots[i].setItemAndQty(
							(item.itype as DynamicWeapon).identifiedCopy(),
							item.quantity
					);
					outputText("\nIdentified "+item.itype.longName);
				}
			}
		}
		doNext(SoulforceCheats);
	}
	private function uncurseAll():void {
		clearOutput();
		if (player.weapon.cursed && player.weapon is DynamicWeapon) {
			player.setWeapon((player.weapon as DynamicWeapon).uncursedCopy() as DynamicWeapon);
			outputText("\nUncursed "+player.weapon.longName);
		}
		for (var i:int = 0; i < player.itemSlots.length; i++) {
			var item:ItemSlotClass = player.itemSlots[i];
			if (item.unlocked && item.quantity > 0 && item.itype.cursed) {
				if (item.itype is DynamicWeapon) {
					player.itemSlots[i].setItemAndQty(
							(item.itype as DynamicWeapon).uncursedCopy(),
							item.quantity
					);
					outputText("\nUncursed "+item.itype.longName);
				}
			}
		}
		doNext(SoulforceCheats);
	}
	
	private function fixFormerJiangshi():void {
		if (!player.hasPerk(PerkLib.CursedTag)) {
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll1)) player.removeStatusEffect(StatusEffects.AlterBindScroll1);
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll2)) player.removeStatusEffect(StatusEffects.AlterBindScroll2);
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll3)) player.removeStatusEffect(StatusEffects.AlterBindScroll3);
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll4)) player.removeStatusEffect(StatusEffects.AlterBindScroll4);
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll5)) player.removeStatusEffect(StatusEffects.AlterBindScroll5);
		}
		doNext(SoulforceCheats);
	}
	
	private function anTrigger():void {
		clearOutput();
		if (player.hasPerk(PerkLib.AntyDexterity)) {
			player.removePerk(PerkLib.AntyDexterity);
			outputText("Now you don't see me.\n\n<i><b>(Anty-Dexterity)</b></i>");
		}
		else {
			player.createPerk(PerkLib.AntyDexterity, 0, 0, 0, 0);
			outputText("Now you see me.\n\n<i><b>(Anty-Dexterity)</b></i>");
		}
		doNext(SoulforceCheats);
	}

	private function mutateReqNope():void{
		clearOutput();
		flags[kFLAGS.EVA_MUTATIONS_BYPASS] = !flags[kFLAGS.EVA_MUTATIONS_BYPASS];
		outputText("Mutation requirements are now " + (flags[kFLAGS.EVA_MUTATIONS_BYPASS] ? "off" : "on") + ".");
		doNext(SoulforceCheats);
	}

	private function refillSoulforce():void{
		clearOutput();
		player.soulforce = player.maxOverSoulforce();
		outputText("Soulforce filled up.");
		statScreenRefresh();
		doNext(SoulforceCheats);
	}

	private function applyHangover():void {
		if (player.hasPerk(PerkLib.JobSoulCultivator)) player.removePerk(PerkLib.JobSoulCultivator);
		if (player.hasKeyItem("Cultivation Manual: Duality") >= 0) player.removeKeyItem("Cultivation Manual: Duality");
		if (player.hasPerk(PerkLib.SoulApprentice)) player.removePerk(PerkLib.SoulApprentice);
		if (player.hasPerk(PerkLib.Dantain)) player.removePerk(PerkLib.Dantain);
		if (player.hasKeyItem("Cultivation Manual: My Dao Sticks are better than Yours") >= 0) player.removeKeyItem("Cultivation Manual: My Dao Sticks are better than Yours");
		if (player.hasPerk(PerkLib.DaoistCultivator)) player.removePerk(PerkLib.DaoistCultivator);
		if (player.hasPerk(PerkLib.DaoistApprenticeStage)) player.removePerk(PerkLib.DaoistApprenticeStage);
		if (player.hasPerk(PerkLib.DaoistWarriorStage)) player.removePerk(PerkLib.DaoistWarriorStage);
		if (player.hasPerk(PerkLib.DaoistElderStage)) player.removePerk(PerkLib.DaoistElderStage);
		if (player.hasPerk(PerkLib.DaoistOverlordStage)) player.removePerk(PerkLib.DaoistOverlordStage);
		if (player.hasKeyItem("Cultivation Manual: Body like a Coke Fiend") >= 0) player.removeKeyItem("Cultivation Manual: Body like a Coke Fiend");
		if (player.hasPerk(PerkLib.BodyCultivator)) player.removePerk(PerkLib.BodyCultivator);
		if (player.hasPerk(PerkLib.FleshBodyApprenticeStage)) player.removePerk(PerkLib.FleshBodyApprenticeStage);
		if (player.hasPerk(PerkLib.FleshBodyWarriorStage)) player.removePerk(PerkLib.FleshBodyWarriorStage);
		if (player.hasPerk(PerkLib.FleshBodyElderStage)) player.removePerk(PerkLib.FleshBodyElderStage);
		if (player.hasPerk(PerkLib.FleshBodyOverlordStage)) player.removePerk(PerkLib.FleshBodyOverlordStage);
		if (player.hasKeyItem("Cultivation Manual: Heart-shaped Eyed She-Devil") >= 0) player.removeKeyItem("Cultivation Manual: Heart-shaped Eyed She-Devil");
		if (player.hasPerk(PerkLib.SoulPersonage)) player.removePerk(PerkLib.SoulPersonage);
		if (player.hasKeyItem("'Soul Sense and You' Manual") >= 0) player.removeKeyItem("'Soul Sense and You' Manual");
		if (player.hasPerk(PerkLib.SoulSense)) player.removePerk(PerkLib.SoulSense);
		if (player.hasPerk(PerkLib.SoulWarrior)) player.removePerk(PerkLib.SoulWarrior);
		if (player.hasKeyItem("Heavenly Tribulation: Myths and Facts") >= 0) player.removeKeyItem("Heavenly Tribulation: Myths and Facts");
		if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) player.removePerk(PerkLib.HclassHeavenTribulationSurvivor);
		if (player.hasPerk(PerkLib.SoulSprite)) player.removePerk(PerkLib.SoulSprite);
		if (player.hasPerk(PerkLib.SoulScholar)) player.removePerk(PerkLib.SoulScholar);
		if (player.hasPerk(PerkLib.SoulGrandmaster)) player.removePerk(PerkLib.SoulGrandmaster);
		if (player.hasKeyItem("A summary of Marethian Sects") >= 0) player.removeKeyItem("A summary of Marethian Sects");
		if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) player.removePerk(PerkLib.GclassHeavenTribulationSurvivor);
		if (player.hasPerk(PerkLib.SoulElder)) player.removePerk(PerkLib.SoulElder);
		if (player.hasPerk(PerkLib.SoulExalt)) player.removePerk(PerkLib.SoulExalt);
		if (player.hasPerk(PerkLib.SoulOverlord)) player.removePerk(PerkLib.SoulOverlord);
		if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) player.removePerk(PerkLib.FclassHeavenTribulationSurvivor);
		if (player.hasPerk(PerkLib.SoulTyrant)) player.removePerk(PerkLib.SoulTyrant);
		if (player.hasPerk(PerkLib.SoulKing)) player.removePerk(PerkLib.SoulKing);
		if (player.hasPerk(PerkLib.SoulEmperor)) player.removePerk(PerkLib.SoulEmperor);
		if (player.hasPerk(PerkLib.SoulAncestor)) player.removePerk(PerkLib.SoulAncestor);
		if (player.hasPerk(PerkLib.BodyTempering)) player.removePerk(PerkLib.BodyTempering);
		if (player.hasPerk(PerkLib.SoulTempering)) player.removePerk(PerkLib.SoulTempering);
		if (flags[kFLAGS.SOUL_CULTIVATION] > 0) flags[kFLAGS.SOUL_CULTIVATION] = 0;
		doNext(SoulforceCheats);
	}
	public function FairyTest4():void {
		player.removePerk(PerkLib.KillingIntent);
		doNext(SoulforceCheats);
	}
	public function FairyTest3():void {
		DriderTown.LilyKidsPCPregnancy = 0;
		doNext(SoulforceCheats);
	}
	public function FairyTest5():void {
		TyrantiaFollower.TyrantiaFollowerStage = 4;
		TyrantiaFollower.TyraniaCorrupteedLegendaries = 1;
		doNext(SoulforceCheats);
	}
	public function FairyTest():void {
		player.removePerk(PerkLib.DragonPoisonBreath);
		player.createPerk(PerkLib.DragonLustPoisonBreath, 0, 0, 0, 0);
		doNext(SoulforceCheats);
	}
	public function belisatest2():void{
		BelisaFollower.BelisaConfessed = true;
		doNext(SoulforceCheats);
	}
	public function belisatest3():void {
		if (BelisaFollower.BelisaEncounternum >= 1) SceneLib.belisa.subsequentEncounters();
		else SceneLib.belisa.firstEncounter();
	}
    public function cheatFixShards():void { //wrapper for fixShards to use it in cheat menu
		clearOutput();
        fixShards();
		doNext(SoulforceCheats);
    }
	public function giveNekoItems():void {
		outputText("\n\n<b>(Gained " + weapons.CATGLOV.longName + "!)</b>\n\n");
		outputText("\n\n<b>(Gained " + shields.NEKONOM.longName + "!)</b>\n\n");
		outputText("\n\n<b>(Gained " + armors.FCLOAK.longName + "!)</b>\n\n");
		outputText("\n\n<b>(Gained " + undergarments.BN_TOP.longName + "!)</b>\n\n");
		outputText("\n\n<b>(Gained " + undergarments.BN_SKIRT.longName + "!)</b>\n\n");
		outputText("\n\n<b>(Gained " + necklaces.CATBELL.longName + "!)</b>\n\n");
		inventory.takeItem(weapons.CATGLOV, curry(NonEquipmentMenu, 2));
		inventory.takeItem(shields.NEKONOM, curry(NonEquipmentMenu, 2));
		inventory.takeItem(armors.FCLOAK, curry(NonEquipmentMenu, 2));
		inventory.takeItem(undergarments.BN_TOP, curry(NonEquipmentMenu, 2));
		inventory.takeItem(undergarments.BN_SKIRT, curry(NonEquipmentMenu, 2));
		inventory.takeItem(necklaces.CATBELL, curry(NonEquipmentMenu, 2));
	}
	public function dantianPhylacteryTest():void {
		if (player.hasPerk(PerkLib.DantianPhylactery)) player.removePerk(PerkLib.DantianPhylactery);
		else player.createPerk(PerkLib.DantianPhylactery,0,0,0,0);
		doNext(SoulforceCheats);
	}
	public function fixShards():void {
		var cnt:int = 0;
		player.removeKeyItem("Radiant shard");
		outputText("Received shards for: ");
		if (flags[kFLAGS.AYANE_FOLLOWER] == 2) {
			++cnt;
			outputText("\nP.Ayane");
		}
		if (flags[kFLAGS.AMILY_FOLLOWER] == 1) {
			++cnt;
			outputText("\nP.Amily");
		}
		if (flags[kFLAGS.AMILY_FOLLOWER] == 2) {
			++cnt;
			outputText("\nC.Amily");
		}
		if (DivaScene.instance.status == -1) {
			++cnt;
			outputText("\nDiva");
		}
		if (flags[kFLAGS.ELECTRA_FOLLOWER] == 2) {
			++cnt;
			outputText("\nElectra");
		}
		if (flags[kFLAGS.ETNA_FOLLOWER] == 2) {
			++cnt;
			outputText("\nEtna");
		}
		if (flags[kFLAGS.KIHA_FOLLOWER] == 1) {
			++cnt;
			outputText("\nKiha");
		}
		if (flags[kFLAGS.CERAPH_FOLLOWER_PIERCING] == 1 || flags[kFLAGS.CERAPH_FOLLOWER_CARRY] == 1) {
			++cnt;
			outputText("\nCeraph");
		}
		if (flags[kFLAGS.VAPULA_FOLLOWER] == 1) {
			++cnt;
			outputText("\nVapula");
		}
		if (cnt) {
			outputText("\nReceived " + cnt + " shards.");
			cheatAddShard(cnt);
		}
		else
			outputText("\nNo shards, go complete quests :(");
	}
	public function fixShards2nd():void {
		var cnt2:int = 0;
		outputText("Received shards for: ");
		if (flags[kFLAGS.ARIAN_FOLLOWER] == 1) {
			++cnt2;
			outputText("\nArian");
		}
		if (BelisaFollower.BelisaInCamp) {
			++cnt2;
			outputText("\nBelisa");
		}
		if (flags[kFLAGS.CEANI_FOLLOWER] > 0) {
			++cnt2;
			outputText("\nCeani");
		}
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5) {
			++cnt2;
			outputText("\nChi Chi");
		}
		if (flags[kFLAGS.NADIA_FOLLOWER] >= 6) {
			++cnt2;
			outputText("\nNadia");
		}
		if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1) {
			++cnt2;
			outputText("\nIzma");
		}
		if (LilyFollower.LilyFollowerState) {
			++cnt2;
			outputText("\nLily");
		}
		if (player.hasStatusEffect(StatusEffects.CampMarble)) {
			++cnt2;
			outputText("\nMarble");
		}
		if (flags[kFLAGS.ANT_WAIFU] > 0) {
			++cnt2;
			outputText("\nPhylla");
		}
		if (flags[kFLAGS.SAMIRAH_FOLLOWER] > 9) {
			++cnt2;
			outputText("\nSamirah");
		}
		if (TyrantiaFollower.isLover()) {
			++cnt2;
			outputText("\nTyrantia");
		}
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] >= 5) {
			++cnt2;
			outputText("\nPatchouli");
		}
		if (flags[kFLAGS.AURORA_LVL] >= 1) {
			++cnt2;
			outputText("\nAurora");
		}
		if (flags[kFLAGS.DINAH_LVL_UP] >= 1) {
			++cnt2;
			outputText("\nDinah");
		}
		if (flags[kFLAGS.EMBER_HATCHED] > 0) {
			++cnt2;
			outputText("\nEmber");
		}
		if (EvangelineFollower.EvangelineFollowerStage >= 1) {
			++cnt2;
			outputText("\nEvangeline");
		}
		if (flags[kFLAGS.LUNA_FOLLOWER] >= 4) {
			++cnt2;
			outputText("\nLuna");
		}
		if (flags[kFLAGS.KINDRA_FOLLOWER] >= 1) {
			++cnt2;
			outputText("\nKindra");
		}
		if (flags[kFLAGS.KONSTANTIN_FOLLOWER] >= 2) {
			++cnt2;
			outputText("\nKonstantin");
		}
		if (flags[kFLAGS.MICHIKO_FOLLOWER] >= 1) {
			++cnt2;
			outputText("\nMichiko");
		}
		if (flags[kFLAGS.SIDONIE_FOLLOWER] >= 1) {
			++cnt2;
			outputText("\nSidonie");
		}
		if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] > 3) {
			++cnt2;
			outputText("\nSiegweird");
		}
		if (cnt2) {
			outputText("\nReceived " + cnt2 + " shards.");
			if (player.hasKeyItem("Radiant shard") >= 0)
				player.addKeyValue("Radiant shard", 1, cnt2);
			else
				player.createKeyItem("Radiant shard", cnt2, 0, 0, 0);
			outputText("\n\n<b>You currently have "+ player.keyItemvX("Radiant shard", 1) + " radiant shards.</b>");
		}
		else
			outputText("\nNo shards, go complete quests :(");
	}
	public function cheatRemoveRP():void {
		clearOutput();
		if (player.removePerk(PerkLib.RacialParagon)) {
			++player.perkPoints;
			outputText("Done!");
		}
		else
			outputText("No such perk.");
		doNext(camp.doCamp);
	}
	public function cheatRemoveShard():void {
		if(player.keyItemvX("Radiant shard", 1) == 1)
			player.removeKeyItem("Radiant shard");
		else
			player.addKeyValue("Radiant shard", 1, -1);
		outputText("\n\n<b>You currently have "+ player.keyItemvX("Radiant shard", 1) +" radiant shards.</b>");
		doNext(SoulforceCheats);
	}
	public function cheatAddShard(cnt:int = 1):void {
		if (player.hasKeyItem("Radiant shard") >= 0)
			player.addKeyValue("Radiant shard", 1, cnt);
		else
			player.createKeyItem("Radiant shard", cnt, 0, 0, 0);
		outputText("\n\n<b>You currently have "+ player.keyItemvX("Radiant shard", 1) + " radiant shards.</b>");
		doNext(SoulforceCheats);
	}
	private function jiangshiBuggedItemsCleanUpCrew0():void {
		if (!player.weapon.isNothing) {
			if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 2) {
				flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 1;
				player.unequipWeapon(false,true);
				jiangshiBuggedItemsCleanUpCrew1();
			}
			else inventory.takeItem(player.unequipWeapon(false,true), jiangshiBuggedItemsCleanUpCrew1);
		}
		else doNext(jiangshiBuggedItemsCleanUpCrew1);
	}
	private function jiangshiBuggedItemsCleanUpCrew1():void {
		if (!player.weaponRange.isNothing) inventory.takeItem(player.unequipWeaponRange(false,true), jiangshiBuggedItemsCleanUpCrew2);
		else doNext(jiangshiBuggedItemsCleanUpCrew2);
	}
	private function jiangshiBuggedItemsCleanUpCrew2():void {
		if (!player.shield.isNothing) {
			if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 2) {
				flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 1;
				player.unequipShield(false,true);
				jiangshiBuggedItemsCleanUpCrew3();
			}
			else inventory.takeItem(player.unequipShield(false,true), jiangshiBuggedItemsCleanUpCrew3);
		}
		else doNext(jiangshiBuggedItemsCleanUpCrew3);
	}
	private function jiangshiBuggedItemsCleanUpCrew3():void {
		if (!player.armor.isNothing) {
			inventory.takeItem(player.setArmor(armors.TRADITC,false,true), jiangshiBuggedItemsCleanUpCrew4);
		}
		else doNext(jiangshiBuggedItemsCleanUpCrew4);
	}
	private function jiangshiBuggedItemsCleanUpCrew4():void {
		if (!player.lowerGarment.isNothing) {
			inventory.takeItem(player.unequipUnderBottom(false,true), jiangshiBuggedItemsCleanUpCrew5);
		}
		else doNext(jiangshiBuggedItemsCleanUpCrew5);
	}
	private function jiangshiBuggedItemsCleanUpCrew5():void {
		if (!player.upperGarment.isNothing) {
			inventory.takeItem(player.unequipUnderTop(false,true), jiangshiBuggedItemsCleanUpCrew6);
		}
		else doNext(jiangshiBuggedItemsCleanUpCrew6);
	}
	private function jiangshiBuggedItemsCleanUpCrew6():void {
		if (!player.headJewelry.isNothing) flags[kFLAGS.PLAYER_DISARMED_HEAD_ACCESORY_ID] = player.headJewelry.id;
		player.setHeadJewelry(headjewelries.JIANGCT, false, true);
		player.statStore.replaceBuffObject({'str.mult':0.2,'tou.mult':0.2,'lib.mult':0.2,'sens':80}, 'Jiangshi Curse Tag', { text: 'Jiangshi Curse Tag' });
		doNext(SoulforceCheats);
	}
	public function golemArmy():void {
		outputText("\n\nFix completed");
		if (player.hasPerk(PerkLib.GolemArmyLieutenant) && !player.hasPerk(PerkLib.GolemArmyJuniorLieutenant)) {
			if (player.hasPerk(PerkLib.GolemArmyLieutenant)) {
				player.removePerk(PerkLib.GolemArmyLieutenant);
				player.createPerk(PerkLib.GolemArmyJuniorLieutenant,0,0,0,0);
			}
			if (player.hasPerk(PerkLib.GolemArmyCaptain)) {
				player.removePerk(PerkLib.GolemArmyCaptain);
				player.createPerk(PerkLib.GolemArmyLieutenant,0,0,0,0);
			}
			if (player.hasPerk(PerkLib.GolemArmyMajor)) {
				player.removePerk(PerkLib.GolemArmyMajor);
				player.createPerk(PerkLib.GolemArmyCaptain,0,0,0,0);
			}
			if (player.hasPerk(PerkLib.GolemArmyColonel)) {
				player.removePerk(PerkLib.GolemArmyColonel);
				player.createPerk(PerkLib.GolemArmyMajor,0,0,0,0);
			}
			if (player.hasPerk(PerkLib.GolemArmyGeneral)) {
				player.removePerk(PerkLib.GolemArmyGeneral);
				player.createPerk(PerkLib.GolemArmyLieutenantColonel,0,0,0,0);
			}
		}
		if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation01)) {
			if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX)) player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1,1);
			else player.createPerk(PerkLib.AscensionAdditionalOrganMutationX, 1, 0, 0, 1);
			player.removePerk(PerkLib.AscensionAdditionalOrganMutation01);
		}
		if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation02)) {
			if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX)) player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1,2);
			else player.createPerk(PerkLib.AscensionAdditionalOrganMutationX,2,0,0,1);
			player.removePerk(PerkLib.AscensionAdditionalOrganMutation02);
		}
		if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation03)){
			if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX)) player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1,3);
			else player.createPerk(PerkLib.AscensionAdditionalOrganMutationX,3,0,0,1);
			player.removePerk(PerkLib.AscensionAdditionalOrganMutation03);
		}
		if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation04)){
			if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX)) player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1,4);
			else player.createPerk(PerkLib.AscensionAdditionalOrganMutationX,4,0,0,1);
			player.removePerk(PerkLib.AscensionAdditionalOrganMutation04);
		}
		if (player.hasPerk(PerkLib.AscensionBuildingPrestige01)) {
			if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1,1);
			else player.createPerk(PerkLib.AscensionBuildingPrestigeX, 1, 0, 0, 1);
			player.removePerk(PerkLib.AscensionBuildingPrestige01);
		}
		if (player.hasPerk(PerkLib.AscensionBuildingPrestige02)) {
			if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1,2);
			else player.createPerk(PerkLib.AscensionBuildingPrestigeX,2,0,0,1);
			player.removePerk(PerkLib.AscensionBuildingPrestige02);
		}
		if (player.hasPerk(PerkLib.AscensionBuildingPrestige03)){
			if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1,3);
			else player.createPerk(PerkLib.AscensionBuildingPrestigeX,3,0,0,1);
			player.removePerk(PerkLib.AscensionBuildingPrestige03);
		}
		if (player.hasPerk(PerkLib.AscensionBuildingPrestige04)){
			if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1,4);
			else player.createPerk(PerkLib.AscensionBuildingPrestigeX,4,0,0,1);
			player.removePerk(PerkLib.AscensionBuildingPrestige04);
		}
		if (player.hasPerk(PerkLib.AscensionBuildingPrestige05)) {
			if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1,5);
			else player.createPerk(PerkLib.AscensionBuildingPrestigeX, 5, 0, 0, 1);
			player.removePerk(PerkLib.AscensionBuildingPrestige05);
		}
		if (player.hasPerk(PerkLib.AscensionBuildingPrestige06)) {
			if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1,6);
			else player.createPerk(PerkLib.AscensionBuildingPrestigeX,6,0,0,1);
			player.removePerk(PerkLib.AscensionBuildingPrestige06);
		}
		if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] > 0) flags[kFLAGS.CHRISTMAS_TREE_LEVEL]++;
		doNext(SoulforceCheats);
	}
	public function fixClones():void {
		if (camp.gcc(true)) player.removeStatusEffect(StatusEffects.PCClone)
		if (player.hasStatusEffect(StatusEffects.NegativeLevel)) {
			player.removeStatusEffect(StatusEffects.NegativeLevel);
		}
		if (player.negativeLevel > 0) player.negativeLevel = 0;
		if (player.hasStatusEffect(StatusEffects.PCClone1st)) player.removeStatusEffect(StatusEffects.PCClone1st);
		if (player.hasStatusEffect(StatusEffects.PCClone2nd)) player.removeStatusEffect(StatusEffects.PCClone2nd);
		if (player.hasStatusEffect(StatusEffects.PCClone3rd)) player.removeStatusEffect(StatusEffects.PCClone3rd);
		if (player.hasStatusEffect(StatusEffects.PCClone4th)) player.removeStatusEffect(StatusEffects.PCClone4th);		
	}	
	public function hiddenPJ():void {
		outputText("\n\nA11 th4t H1dd3n Prestige is Y0urs to T4ke!!!");
		if (!player.hasPerk(PerkLib.PrestigeJobArcaneArcher)) player.createPerk(PerkLib.PrestigeJobArcaneArcher, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobArchpriest)) player.createPerk(PerkLib.PrestigeJobArchpriest, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobBard)) player.createPerk(PerkLib.PrestigeJobBard, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobBerserker)) player.createPerk(PerkLib.PrestigeJobBerserker, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobDruid)) player.createPerk(PerkLib.PrestigeJobDruid, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobNecromancer)) player.createPerk(PerkLib.PrestigeJobNecromancer, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobSentinel)) player.createPerk(PerkLib.PrestigeJobSentinel, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobSoulArtMaster)) player.createPerk(PerkLib.PrestigeJobSoulArtMaster, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobSpellKnight)) player.createPerk(PerkLib.PrestigeJobSpellKnight, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobStalker)) player.createPerk(PerkLib.PrestigeJobStalker, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobTempest)) player.createPerk(PerkLib.PrestigeJobTempest, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobWarlock)) player.createPerk(PerkLib.PrestigeJobWarlock, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.HiddenJobAsura)) player.createPerk(PerkLib.HiddenJobAsura, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.HiddenJobBloodDemon)) player.createPerk(PerkLib.HiddenJobBloodDemon, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.PrestigeJobGreySage)) player.createPerk(PerkLib.PrestigeJobGreySage, 0, 0, 0, 0);
		if (!player.hasPerk(PerkLib.HiddenJobSwordImmortal)) player.createPerk(PerkLib.HiddenJobSwordImmortal, 0, 0, 0, 0);
		doNext(SoulforceCheats);
	}
	public function learnHexes():void {
		if (!player.hasPerk(PerkLib.JobSorcerer)) player.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
		player.createPerk(PerkLib.PrestigeJobWarlock, 0, 0, 0, 0);
		player.createPerk(PerkLib.HexKnowledge, 0, 0, 0, 0);
		player.createPerk(PerkLib.DarkRitual, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.KnowsConsumingDarkness, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.KnowsCurseOfDesire, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.KnowsCurseOfWeeping, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.KnowsLifeSiphon, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.KnowsLifetap, 0, 0, 0, 0);
		doNext(SoulforceCheats);
	}
	public function instaHouse():void {
		flags[kFLAGS.CAMP_BUILT_CABIN] = 1;
		flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] = 1;
		doNext(SoulforceCheats);
	}
	public function AddMaxBackpack2():void {
		if (AdventurerGuild.playerGuildLevel > AdventurerGuild.RANK_COPPER && AdventurerGuild.lootBag.SlotCaps[0] < 10) {
			AdventurerGuild.unlockSlotsForRank(AdventurerGuild.RANK_IRON, 10);
		}
		if (AdventurerGuild.playerGuildLevel > AdventurerGuild.RANK_COPPER && AdventurerGuild.lootBag.SlotCaps[2] < 10) {
			AdventurerGuild.unlockSlotsForRank(AdventurerGuild.RANK_COPPER, 10);
			AdventurerGuild.unlockSlotsForRank(AdventurerGuild.RANK_IRON, 10);
		}
		doNext(SoulforceCheats);
	}
	public function AddMaxBackpack3():void {
		player.createStatusEffect(StatusEffects.ZenjiZList, 0, 0, 0, 0);
		doNext(SoulforceCheats);
	}
	public function wendigoTrigger():void {
		if (player.hasStatusEffect(StatusEffects.WendigoPsychosis)) SceneLib.glacialRift.wendigoScene.becomeWendigo();
		else {
			outputText("Get a Life... i mean Wendigo Psychosis...");
			doNext(SoulforceCheats);
		}
	}
	public function AddMaxBackpack5():void {
		if (flags[kFLAGS.EVANGELINE_LVL_UP] > 0) flags[kFLAGS.EVANGELINE_LVL_UP] = 0;
		if (flags[kFLAGS.EVANGELINE_DEFEATS_COUNTER] > 0) flags[kFLAGS.EVANGELINE_DEFEATS_COUNTER] = 0;
		if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] > 0) flags[kFLAGS.EVANGELINE_SPELLS_CASTED] = 0;
		if (flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] > 0) flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 0;
		if (flags[kFLAGS.EVANGELINE_02330] > 0) flags[kFLAGS.EVANGELINE_02330] = 0;
		if (flags[kFLAGS.EVANGELINE_02331] > 0) flags[kFLAGS.EVANGELINE_02331] = 0;
		if (flags[kFLAGS.EVANGELINE_02332] > 0) flags[kFLAGS.EVANGELINE_02332] = 0;
		if (flags[kFLAGS.EVANGELINE_02333] > 0) flags[kFLAGS.EVANGELINE_02333] = 0;
		outputText("Rewind Evangeline ^^");
		doNext(SoulforceCheats);
	}
	public function TestDynamicStats():void {
		player.statStore.addBuff('sens',+10,'tag',{text:'Debug buff!', rate: Buff.RATE_HOURS, tick: 1});
		statScreenRefresh();
		trace("Stop for debugging");
		doNext(SoulforceCheats);
	}
	public function FightAria():void {
		clearOutput();
		outputText("Entering battle with Melkie! Enjoy ^^");
		startCombat(new Aria());
	}
	public function FightLethice():void {
		clearOutput();
		outputText("Entering battle with Lethice! Enjoy ^^");
		startCombat(new Lethice());
	}
	public function FightGalia():void {
		clearOutput();
		outputText("Entering battle with Galia! Enjoy ^^");
		startCombat(new Galia());
	}
	public function FightChaosChimera():void {
		clearOutput();
		outputText("Entering battle with Chaos Chimera! Enjoy ^^");
		startCombat(new ChaosChimera());
	}
	public function ChimeraBodyUltimateStage():void {
		if (player.hasPerk(PerkLib.ChimericalBodyUltimateStage)) {
			player.removePerk(PerkLib.ChimericalBodyUltimateStage);
			outputText("\n\n<b>(Lost Perk: Chimerical Body: Ultimate Stage!)</b>");
		}
		else {
			player.createPerk(PerkLib.ChimericalBodyUltimateStage, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Chimerical Body: Ultimate Stage!)</b>");
		}
		doNext(SoulforceCheats);
	}
	public function AllMetamorphOptionsUnlock():void {
		for each (var raceMem: * in RaceMem.Memories) {
			Metamorph.GeneticMemoryStorage[raceMem.id] = true;
		}
		for each (var hairMem: * in HairMem.Memories) {
			Metamorph.GeneticMemoryStorage[hairMem.id] = true;
		}
		for each (var faceMem: * in FaceMem.Memories) {
			Metamorph.GeneticMemoryStorage[faceMem.id] = true;
		}
		for each (var eyesMem: * in EyesMem.Memories) {
			Metamorph.GeneticMemoryStorage[eyesMem.id] = true;
		}
		for each (var earsMem: * in EarsMem.Memories) {
			Metamorph.GeneticMemoryStorage[earsMem.id] = true;
		}
		for each (var armsMem: * in ArmsMem.Memories) {
			Metamorph.GeneticMemoryStorage[armsMem.id] = true;
		}
		for each (var hornsMem: * in HornsMem.Memories) {
			Metamorph.GeneticMemoryStorage[hornsMem.id] = true;
		}
		for each (var skinMem: * in SkinMem.Memories) {
			Metamorph.GeneticMemoryStorage[skinMem.id] = true;
		}
		for each (var skinPatternMem: * in SkinPatternMem.Memories) {
			Metamorph.GeneticMemoryStorage[skinPatternMem.id] = true;
		}
		for each (var tongueMem: * in TongueMem.Memories) {
			Metamorph.GeneticMemoryStorage[tongueMem.id] = true;
		}
		for each (var wingsMem: * in WingsMem.Memories) {
			Metamorph.GeneticMemoryStorage[wingsMem.id] = true;
		}
		for each (var antennaeMem: * in AntennaeMem.Memories) {
			Metamorph.GeneticMemoryStorage[antennaeMem.id] = true;
		}
		for each (var gillsMem: * in GillsMem.Memories) {
			Metamorph.GeneticMemoryStorage[gillsMem.id] = true;
		}
		for each (var rearBodyMem: * in RearBodyMem.Memories) {
			Metamorph.GeneticMemoryStorage[rearBodyMem.id] = true;
		}
		for each (var lowerBodyMem: * in LowerBodyMem.Memories) {
			Metamorph.GeneticMemoryStorage[lowerBodyMem.id] = true;
		}
		for each (var tailMem: * in TailMem.Memories) {
			Metamorph.GeneticMemoryStorage[tailMem.id] = true;
		}
		for each (var cockMem: * in CockMem.Memories) {
			Metamorph.GeneticMemoryStorage[cockMem.id] = true;
		}
		for each (var cockCountMem: * in CockCountMem.Memories) {
			Metamorph.GeneticMemoryStorage[cockCountMem.id] = true;
		}
		for each (var vaginaMem: * in VaginaMem.Memories) {
			Metamorph.GeneticMemoryStorage[vaginaMem.id] = true;
		}
		for each (var vaginaCountMem: * in VaginaCountMem.Memories) {
			//Filter out vagina after 1 //TODO:multiVag support? Will this break if 2nd vag unlocked?
			if (vaginaCountMem.id == "One Vagina")
				Metamorph.GeneticMemoryStorage["One Vagina"] = true;
		}
		for each (var ballsMem: * in BallsMem.Memories) {
			Metamorph.GeneticMemoryStorage[ballsMem.id] = true;
		}
		for each (var breastMem: * in BreastMem.Memories) {
			Metamorph.GeneticMemoryStorage[breastMem.id] = true;
		}
		for each (var specialMem: * in SpecialsMem.Memories) {
			Metamorph.GeneticMemoryStorage[specialMem.id] = true;
		}
		Metamorph.GeneticMemoryStorage["Taur Lower Body"] = true;
		clearOutput();
		outputText("All metamorph options unlocked.");
		doNext(SoulforceCheats);
	}
	public function PerkGalore1():void {
		if (!player.hasPerk(PerkLib.CorruptedKitsune)) {
			player.createPerk(PerkLib.CorruptedKitsune, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Corrupted Kitsune!)</b>");
		}
		if (!player.hasPerk(PerkLib.CorruptedNinetails)) {
			player.createPerk(PerkLib.CorruptedNinetails, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Corrupted Ninetails!)</b>");
		}
		if (!player.hasPerk(PerkLib.EnlightenedKitsune)) {
			player.createPerk(PerkLib.EnlightenedKitsune, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Enlightened Kitsune!)</b>");
		}
		if (!player.hasPerk(PerkLib.EnlightenedNinetails)) {
			player.createPerk(PerkLib.EnlightenedNinetails, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Enlightened Ninetails!)</b>");
		}
		if (!player.hasPerk(PerkLib.FerasBoonAlpha)) {
			player.createPerk(PerkLib.FerasBoonAlpha, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Feras Boon Alpha!)</b>");
		}
		if (!player.hasPerk(PerkLib.FerasBoonBreedingBitch)) {
			player.createPerk(PerkLib.FerasBoonBreedingBitch, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Feras Boon Breeding Bitch!)</b>");
		}
		if (!player.hasPerk(PerkLib.FerasBoonMilkingTwat)) {
			player.createPerk(PerkLib.FerasBoonMilkingTwat, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Feras Boon Milking Twat!)</b>");
		}
		if (!player.hasPerk(PerkLib.FerasBoonSeeder)) {
			player.createPerk(PerkLib.FerasBoonSeeder, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Feras Boon Seeder!)</b>");
		}
		if (!player.hasPerk(PerkLib.FireLord)) {
			player.createPerk(PerkLib.FireLord, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: FireLord!)</b>");
		}
		if (!player.hasPerk(PerkLib.Hellfire)) {
			player.createPerk(PerkLib.Hellfire, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Hellfire!)</b>");
		}
		if (!player.hasPerk(PerkLib.MagicalFertility)) {
			player.createPerk(PerkLib.MagicalFertility, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Magical Fertility!)</b>");
		}
		if (!player.hasPerk(PerkLib.MagicalVirility)) {
			player.createPerk(PerkLib.MagicalVirility, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Magical Virility!)</b>");
		}
		if (!player.hasPerk(PerkLib.MaraesGiftButtslut)) {
			player.createPerk(PerkLib.MaraesGiftButtslut, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Maraes Gift Buttslut!)</b>");
		}
		if (!player.hasPerk(PerkLib.MaraesGiftFertility)) {
			player.createPerk(PerkLib.MaraesGiftFertility, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Maraes Gift Fertility!)</b>");
		}
		if (!player.hasPerk(PerkLib.MaraesGiftProfractory)) {
			player.createPerk(PerkLib.MaraesGiftProfractory, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Maraes Gift Profractory!)</b>");
		}
		if (!player.hasPerk(PerkLib.MaraesGiftStud)) {
			player.createPerk(PerkLib.MaraesGiftStud, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Maraes Gift Stud!)</b>");
		}
		if (!player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) {
			player.createPerk(PerkLib.NinetailsKitsuneOfBalance, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: 9T Kitsune Of Balance!)</b>");
		}
		if (!player.hasPerk(PerkLib.MilkMaid)) {
			player.createPerk(PerkLib.MilkMaid, 1, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: MilkMaid!)</b>");
		}
		if (!player.hasPerk(PerkLib.OneTrackMind)) {
			player.createPerk(PerkLib.OneTrackMind, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: One Track Mind!)</b>");
		}
		if (!player.hasPerk(PerkLib.PureAndLoving)) {
			player.createPerk(PerkLib.PureAndLoving, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Pure And Loving!)</b>");
		}
		if (!player.hasPerk(PerkLib.PurityBlessing)) {
			player.createPerk(PerkLib.PurityBlessing, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Purity Blessing!)</b>");
		}
		if (!player.hasPerk(PerkLib.SensualLover)) {
			player.createPerk(PerkLib.SensualLover, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Sensual Lover!)</b>");
		}
		if (!player.hasPerk(PerkLib.ThickSkin)) {
			player.createPerk(PerkLib.ThickSkin, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Thick Skin!)</b>");
		}
		if (player.hasPerk(PerkLib.Perfection) && !player.hasPerk(PerkLib.Creationism)) {
			player.createPerk(PerkLib.Creationism, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Creationism!)</b>");
		}
		if (player.hasPerk(PerkLib.SoulPowered) && !player.hasPerk(PerkLib.AllSeeing)) {
			player.createPerk(PerkLib.AllSeeing, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: All-Seeing!)</b>");
		}
		if (player.hasPerk(PerkLib.SoulOfSteel) && !player.hasPerk(PerkLib.GodOfSteel)) {
			player.createPerk(PerkLib.GodOfSteel, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: God of Steel!)</b>");
		}
		if (player.hasPerk(PerkLib.BlessedByLadyGodiva) && !player.hasPerk(PerkLib.LadyGodivasFavoriteChild)) {
			player.createPerk(PerkLib.LadyGodivasFavoriteChild, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Lady Godiva's favorite Child!)</b>");
		}
		if (player.hasPerk(PerkLib.Surgeon) && !player.hasPerk(PerkLib.Medic)) {
			player.createPerk(PerkLib.Medic, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: MEDIC!!!!)</b>");
		}
		if (player.hasPerk(PerkLib.Cardinal) && !player.hasPerk(PerkLib.Pope)) {
			player.createPerk(PerkLib.Pope, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Pope!)</b>");
		}
		if (player.hasPerk(PerkLib.President) && !player.hasPerk(PerkLib.Nerd)) {
			player.createPerk(PerkLib.Nerd, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: NERD!!!!)</b>");
		}
		if (player.hasPerk(PerkLib.SpysEnemy) && !player.hasPerk(PerkLib.ShitYouTouchedSasha)) {
			player.createPerk(PerkLib.ShitYouTouchedSasha, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: SHIT YOU TOUCHED SASHA!!!)</b>");
		}
		if (player.hasPerk(PerkLib.ZZZ) && !player.hasPerk(PerkLib.Lazy)) {
			player.createPerk(PerkLib.Lazy, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: LAZY!!!!)</b>");
		}/*if (player.hasPerk(PerkLib.) && !player.hasPerk(PerkLib.)) {
			player.createPerk(PerkLib., 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: !)</b>");
		}*/
		if (player.hasPerk(PerkLib.PartyBoyGirl) && !player.hasPerk(PerkLib.MattressActressActor)) {
			player.createPerk(PerkLib.MattressActressActor, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Mattress Actress/Actor!)</b>");
		}
		if (player.hasPerk(PerkLib.Weap0n) && !player.hasPerk(PerkLib.Arm0r)) {
			player.createPerk(PerkLib.Arm0r, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Armor!)</b>");
		}
		if (player.hasPerk(PerkLib.Fellowship) && !player.hasPerk(PerkLib.Alliance)) {
			player.createPerk(PerkLib.Alliance, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Alliance!)</b>");
		}
		if (player.hasPerk(PerkLib.SexChampion) && !player.hasPerk(PerkLib.SexDeity)) {
			player.createPerk(PerkLib.SexDeity, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Sex Deity!)</b>");
		}
		if (flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE] == 0) flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE] = date.fullYear;
		doNext(SoulforceCheats);
	}
	public function PerkGalore2():void {
		if (!player.hasPerk(PerkLib.PrestigeJobSeer)) {
			player.createPerk(PerkLib.PrestigeJobSeer, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Prestige Job: Seer!)</b>");
		}
		if (!player.hasPerk(PerkLib.PrestigeJobSoulArcher)) {
			player.createPerk(PerkLib.PrestigeJobSoulArcher, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Prestige Job: Soul Archer!)</b>");
		}
		if (!player.hasPerk(PerkLib.PiercedCrimstone)) {
			player.createPerk(PerkLib.PiercedCrimstone, 5, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Pierced: Crimstone!)</b>");
		}
		if (!player.hasPerk(PerkLib.PiercedFertite)) {
			player.createPerk(PerkLib.PiercedFertite, 5, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Pierced: Fertite!)</b>");
		}
		if (!player.hasPerk(PerkLib.PiercedFurrite)) {
			player.createPerk(PerkLib.PiercedFurrite, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Pierced: Furrite!)</b>");
		}
		if (!player.hasPerk(PerkLib.PiercedLethite)) {
			player.createPerk(PerkLib.PiercedLethite, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Pierced: Lethite!)</b>");
		}
		if (!player.hasPerk(PerkLib.BroodMother)) {
			player.createPerk(PerkLib.BroodMother, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Brood Mother!)</b>");
		}
		if (!player.hasPerk(PerkLib.Androgyny)) {
			player.createPerk(PerkLib.Androgyny, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Androgyny!)</b>");
		}
		if (!player.hasPerk(PerkLib.BasiliskWomb)) {
			player.createPerk(PerkLib.BasiliskWomb, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Basilisk Womb!)</b>");
		}
		if (!player.hasPerk(PerkLib.BunnyEggs)) {
			player.createPerk(PerkLib.BunnyEggs, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Bunny Eggs!)</b>");
		}
		if (!player.hasPerk(PerkLib.DeityJobMunchkin)) {
			player.createPerk(PerkLib.DeityJobMunchkin, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Deity Job: Munchkin!)</b>");
		}
		if (!player.hasPerk(PerkLib.Diapause)) {
			player.createPerk(PerkLib.Diapause, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Diapause!)</b>");
		}
		if (!player.hasPerk(PerkLib.Feeder)) {
			player.createPerk(PerkLib.Feeder, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Feeder!)</b>");
		}
		if (!player.hasPerk(PerkLib.HarpyWomb)) {
			player.createPerk(PerkLib.HarpyWomb, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Harpy Womb!)</b>");
		}
		if (!player.hasPerk(PerkLib.ImprovedVenomGland)) {
			player.createPerk(PerkLib.ImprovedVenomGland, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Improved Venom Gland!)</b>");
		}
		if (!player.hasPerk(PerkLib.MinotaurCumResistance)) {
			player.createPerk(PerkLib.MinotaurCumResistance, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Minotaur Cum Resistance!)</b>");
		}
		if (!player.hasPerk(PerkLib.BasiliskResistance)) {
			player.createPerk(PerkLib.BasiliskResistance, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Basilisk Resistance!)</b>");
		}
		if (!player.hasPerk(PerkLib.Cornucopia)) {
			player.createPerk(PerkLib.Cornucopia, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Cornucopia!)</b>");
		}
		if (!player.hasPerk(PerkLib.DemonicLethicite)) {
			player.createPerk(PerkLib.DemonicLethicite, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Demonic Lethicite!)</b>");
		}
		if (!player.hasPerk(PerkLib.DemonSlayer)) {
			player.createPerk(PerkLib.DemonSlayer, 0.1, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Demon Slayer!)</b>");
		}
		if (!player.hasPerk(PerkLib.ElvenBounty)) {
			player.createPerk(PerkLib.ElvenBounty, 0, 15, 0, 0);
			outputText("\n\n<b>(Gained Perk: Elven Bounty!)</b>");
		}
		if (!player.hasPerk(PerkLib.FeralHunter)) {
			player.createPerk(PerkLib.FeralHunter, 0.1, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Feral Hunter!)</b>");
		}
		if (!player.hasPerk(PerkLib.MarbleResistant)) {
			player.createPerk(PerkLib.MarbleResistant, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Marble Resistant!)</b>");
		}
		if (!player.hasPerk(PerkLib.Misdirection)) {
			player.createPerk(PerkLib.Misdirection, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Misdirection!)</b>");
		}
		if (!player.hasPerk(PerkLib.OmnibusGift)) {
			player.createPerk(PerkLib.OmnibusGift, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Omnibus Gift!)</b>");
		}
		if (!player.hasPerk(PerkLib.PilgrimsBounty)) {
			player.createPerk(PerkLib.PilgrimsBounty, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Pilgrims Bounty!)</b>");
		}
		if (!player.hasPerk(PerkLib.ProductivityDrugs)) {
			player.createPerk(PerkLib.ProductivityDrugs,player.cor,10,player.lib,0);
			outputText("\n\n<b>(Gained Perk: Productivity Drugs!)</b>");
		}
		if (!player.hasPerk(PerkLib.SenseCorruption)) {
			player.createPerk(PerkLib.SenseCorruption, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Sense Corruption!)</b>");
		}
		if (!player.hasPerk(PerkLib.SenseWrath)) {
			player.createPerk(PerkLib.SenseWrath, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Sense Wrath!)</b>");
		}
		if (!player.hasPerk(PerkLib.Whispered)) {
			player.createPerk(PerkLib.Whispered, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Whispered!)</b>");
		}
		if (!player.hasPerk(PerkLib.ControlledBreath)) {
			player.createPerk(PerkLib.ControlledBreath, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Controlled Breath!)</b>");
		}
		if (!player.hasPerk(PerkLib.CleansingPalm)) {
			player.createPerk(PerkLib.CleansingPalm, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Cleansing Palm!)</b>");
		}
		if (!player.hasPerk(PerkLib.Enlightened)) {
			player.createPerk(PerkLib.Enlightened, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Enlightened!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryAlchemist) && !player.hasPerk(PerkLib.PastLifeAlchemist)) {
			player.createPerk(PerkLib.HistoryAlchemist, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Alchemist!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryCultivator) && !player.hasPerk(PerkLib.PastLifeCultivator)) {
			player.createPerk(PerkLib.HistoryCultivator, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Cultivator!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryFighter) && !player.hasPerk(PerkLib.PastLifeFighter)) {
			player.createPerk(PerkLib.HistoryFighter, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Fighter!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryFortune) && !player.hasPerk(PerkLib.PastLifeFortune)) {
			player.createPerk(PerkLib.HistoryFortune, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Fortune!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryHealer) && !player.hasPerk(PerkLib.PastLifeHealer)) {
			player.createPerk(PerkLib.HistoryHealer, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Healer!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryReligious) && !player.hasPerk(PerkLib.PastLifeReligious)) {
			player.createPerk(PerkLib.HistoryReligious, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Religious!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryScholar) && !player.hasPerk(PerkLib.PastLifeScholar)) {
			player.createPerk(PerkLib.HistoryScholar, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Scholar!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryScout) && !player.hasPerk(PerkLib.PastLifeScout)) {
			player.createPerk(PerkLib.HistoryScout, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Scout!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistorySlacker) && !player.hasPerk(PerkLib.PastLifeSlacker)) {
			player.createPerk(PerkLib.HistorySlacker, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Slacker!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistorySlut) && !player.hasPerk(PerkLib.PastLifeSlut)) {
			player.createPerk(PerkLib.HistorySlut, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Slut!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistorySmith) && !player.hasPerk(PerkLib.PastLifeSmith)) {
			player.createPerk(PerkLib.HistorySmith, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Smith!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryTactician) && !player.hasPerk(PerkLib.PastLifeTactician)) {
			player.createPerk(PerkLib.HistoryTactician, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Tactician!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryWhore) && !player.hasPerk(PerkLib.PastLifeWhore)) {
			player.createPerk(PerkLib.HistoryWhore, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Whore!)</b>");
		}
		if (!player.hasPerk(PerkLib.HistoryFeral) && !player.hasPerk(PerkLib.PastLifeFeral)) {
			player.createPerk(PerkLib.HistoryFeral, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: History: Feral!)</b>");
		}
		doNext(SoulforceCheats);
	}
	public function StatsAscensionMenu():void {
		menu();
		addButton(0, "Ascension", StatsAscensionMenu2);
		addButton(5, "Str", StatsMenuCore, "Str").hint("Adj Str.");
		addButton(6, "Tou", StatsMenuCore, "Tou").hint("Adj Tou.");
		addButton(7, "Spe", StatsMenuCore, "Spe").hint("Adj Spe.");
		addButton(8, "Int", StatsMenuCore, "Int").hint("Adj Int.");
		addButton(9,"Wis", StatsMenuCore, "Wis").hint("Adj Wis.");
		addButton(10, "Tone/Thicc/Fem", StatsMenuToneThicknessFeminity).hint("Adj Tone/Thickness/Feminity.");
		addButton(11,"Lib", StatsMenuCore, "Lib").hint("Adj Lib.");
		addButton(12,"Sen", StatsMenuCore, "Sen").hint("Adj Sens.");
		addButton(13,"Cor", StatsMenuCore, "Cor").hint("Adj Cor.");
		addButton(14, "Back", SoulforceCheats);
	}
	public function StatsAscensionMenu2():void {
		menu();
		addButton(0, "EarlyAscension", EarlyAscension).hint("Allowing to premature ascension.");
		addButton(1, "NG tier ++", IncreaseAscensionCounter).hint("Allowing to increase ascension counter.");
		if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0) addButton(2, "NG tier --", DecreaseAscensionCounter).hint("Allowing to decrease ascension counter.");
		addButton(5, "AscenPerks01", AddAscenionPerkPoints, 1).hint("Add 1 ascension perk point for use during ascending to the next NG+ tier.");
		addButton(6, "AscenPerks05", AddAscenionPerkPoints, 5).hint("Add 5 ascension perk points for use during ascending to the next NG+ tier.");
		addButton(7, "AscenPerks10", AddAscenionPerkPoints, 10).hint("Add 10 ascension perk points for use during ascending to the next NG+ tier.");
		addButton(8, "AscenPerks50", AddAscenionPerkPoints, 50).hint("Add 50 ascension perk points for use during ascending to the next NG+ tier.");
		addButton(9, "AscenPerks100", AddAscenionPerkPoints, 100).hint("Add 100 ascension perk points for use during ascending to the next NG+ tier.");
		addButton(14, "Back", StatsAscensionMenu);
	}
	public function modFlagsMenu():void
	{
		menu();
		clearOutput();
		outputText("A menu where you can edit some flags that are useful for debugging.");
		outputText("\n\nTotal Times Transformed: " + flags[kFLAGS.TIMES_TRANSFORMED] + "");
		addButton(0, "T Add 1", modStatFlags, "timesTransformed", 1).hint("Add 1 to times transformed");
		addButton(1, "T Add 10", modStatFlags, "timesTransformed", 10).hint("Add 10 to times transformed");
		addButton(5, "T Sub 1", modStatFlags, "timesTransformed", -1).hint("Subtract 1 from times transformed");
		addButton(6, "T Sub 10", modStatFlags, "timesTransformed", -10).hint("Subtract 10 from times transformed");
		addButton(14, "Back", SoulforceCheats);
	}
	public function StatsMenuCore(type:String = "Str"):void{
		menu();
		addButton(0, "Inc +1", ModCoreStats,type,1).hint("Add 1 to " + type +".");
		addButton(5, "Dec -1", ModCoreStats,type,-1).hint("Substract 1 from " + type +".");
		addButton(1, "Inc +10", ModCoreStats,type,10).hint("Add 10 to " + type +".");
		addButton(6, "Dec -10", ModCoreStats,type,-10).hint("Substract 10 from " + type +".");
		if (type != "Tone" || type != "Thicc" || type != "Fem") {
			addButton(2, "Inc +50", ModCoreStats,type,50).hint("Add 50 to " + type +".");
			addButton(7, "Dec -50", ModCoreStats,type,-50).hint("Substract 50 from " + type +".");
			addButton(3, "Inc +200", ModCoreStats,type,200).hint("Add 200 to " + type +".");
			addButton(8, "Dec -200", ModCoreStats,type,-200).hint("Substract 200 from " + type +".");
			addButton(4, "Inc +1000", ModCoreStats,type,1000).hint("Add 1000 to " + type +".");
			addButton(9, "Dec -1000", ModCoreStats,type,-1000).hint("Substract 1000 from " + type +".");
		}
		addButton(14, "Back", StatsAscensionMenu);
	}

	public function StatsMenuToneThicknessFeminity():void {
		menu();
		addButton(0, "Tone +1", ModCoreStats, "Tone", 1).hint("Add 1 to Tone.");
		addButton(1, "Tone +10", ModCoreStats, "Tone", 10).hint("Add 10 to Tone.");
		addButton(2, "Tone -1", ModCoreStats, "Tone", -1).hint("Substract 1 from Tone.");
		addButton(3, "Tone -10", ModCoreStats, "Tone", -10).hint("Substract 10 from Tone.");
		addButton(5, "Thicc +1", ModCoreStats, "Thickness", 1).hint("Add 1 to Thicc.");
		addButton(6, "Thicc +10", ModCoreStats, "Thickness", 10).hint("Add 10 to Thicc.");
		addButton(7, "Thicc -1", ModCoreStats, "Thickness", -1).hint("Substract 1 from Thicc.");
		addButton(8, "Thicc -10", ModCoreStats, "Thickness", -10).hint("Substract 10 from Thicc.");
		addButton(10, "Fem +1", ModCoreStats, "Feminity", 1).hint("Add 1 to Feminity.");
		addButton(11, "Fem +10", ModCoreStats, "Feminity", 10).hint("Add 10 to Feminity.");
		addButton(12, "Fem -1", ModCoreStats, "Feminity", -1).hint("Substract 1 from Feminity.");
		addButton(13, "Fem -10", ModCoreStats, "Feminity", -10).hint("Substract 10 from Feminity.");
		addButton(14, "Back", StatsAscensionMenu);
	}

	public function PerksGemsEXP():void {
		statScreenRefresh();
		menu();
		addButton(0, "Add 1 PerkP", perkPointsCheat, 1).hint("Add 1 perk point.");
		addButton(1, "Add 5 PerkP", perkPointsCheat, 5).hint("Add 5 perk points.");
		addButton(2, "Sub 10 PerkP", perkPointsCheat, -10).hint("Substract 10 perk points.");
		addButton(5, "Add Gems 1", addGemsXP, "Gems", 100).hint("Add 100 gems.");
		addButton(6, "Add Gems 2", addGemsXP, "Gems", 1000).hint("Add 1,000 gems.");
		addButton(7, "Add Gems 3", addGemsXP, "Gems", 10000).hint("Add 10,000 gems.");
		addButton(10, "Add EXP 1", addGemsXP, "XP", 100).hint("Add 100 EXP.");
		addButton(11, "Add EXP 2", addGemsXP, "XP", 1000).hint("Add 1,000 EXP.");
		addButton(12, "Add EXP 3", addGemsXP, "XP", 10000).hint("Add 10,000 EXP.");
		addButton(13, "Add EXP 4", addGemsXP, "XP", 100000).hint("Add 100,000 EXP.");
		if (player.hasPerk(PerkLib.SoulAncestor)) addButton(3, "10-12 St.", Stage10to12SoulPerks).hint("Remove all soul cultivator related perks for stages 10-12 of cultivation to keep save compatibility with public build saves.");
		if (!player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) addButton(8, "Trib Perk", TribulationPerks).hint("Add E class Tribulation survivor perk.");
		addButton(14, "Back", SoulforceCheats);
	}
	public function LevelDeLevel():void {
		statScreenRefresh();
		menu();
		if (player.level < CoC.instance.levelCap) addButton(0, "Add 1 LvL", addsubLvl, "Lvl", 1).hint("Add 1 Level (with stat and perk points).");
		if (player.level < CoC.instance.levelCap - 9) addButton(1, "Add 10 LvL's", addsubLvl, "Lvl", 10).hint("Add 10 Levels (with stat and perk points).");
		if (player.level > 0) addButton(2, "Sub 1 LvL", addsubLvl, "DLvl", 1).hint("Substract 1 Level (keeping stat and perk points).");
		if (player.level > 9) addButton(3, "Sub 10 LvL's", addsubLvl, "DLvl", 10).hint("Substract 10 Levels (keeping stat and perk points).");
		if (player.negativeLevel > 0) addButton(4, "-1 Neg LvL (" + player.negativeLevel + ")", function _():void{ player.negativeLevel -= 1; LevelDeLevel(); }).hint("Recover 1 negative level.");
		addButton(14, "Back", SoulforceCheats);
	}
	public function BodyStateMenu():void {
		menu();
		addButton(0, "Height U1", AddTallness1).hint("Add 2 to Height.");
		addButton(2, "Height D1", SubTallness1).hint("Substract 2 from Height.");
		addButton(1, "Height U2", AddTallness2).hint("Add 12 to Height.");
		addButton(3, "Height D2", SubTallness2).hint("Substract 12 from Height.");
		addButton(4, "Hair L. Up", AddHairLength).hint("Add 2 to Hair Length.");
		addButton(9, "Hair L. Down", SubHairLength).hint("Substract 2 from Hair Length.");
		addButton(5, "Cup Up", AddCupSize).hint("Add 1 to Cup Size.");
		addButton(6, "Cup Down", SubCupSize).hint("Substract 1 from Cup Size.");
		addButton(7, "Cock Up", AddCockLength).hint("Add 1 to Cock Length.");
		addButton(8, "Cock Down", SubCockLength).hint("Substract 1 from Cock Length.");
		addButton(10, "Add Pussy", AddPussy).hint("Add Vagina.");
		addButton(11, "Rem Pussy", RemovePussy).hint("Remove Vagina.");
		addButton(12, "Add C+B", AddCockBalls).hint("Add Cock+Balls.");
		addButton(13, "Rem C+B", RemoveCockBalls).hint("Remove Cock+Balls.");
		addButton(14, "Back", SoulforceCheats);
	}
	public function AddTallness1():void {
		player.tallness += 2;
		if (player.basetallness >= 132) player.tallness = 132;
		BodyStateMenu();
	}
	public function AddTallness2():void {
		player.tallness += 12;
		if (player.basetallness >= 132) player.tallness = 132;
		BodyStateMenu();
	}
	public function AddHairLength():void {
		player.hairLength += 2;
		BodyStateMenu();
	}
	public function AddCupSize():void {
		var growth:int = 1;
		if (player.breastRows[0].breastRating < 2) growth++;
		player.growTits(growth, player.breastRows.length, true, 3);
		BodyStateMenu();
	}
	public function AddCockLength():void {
		outputText("\n\n");
		player.cocks[0].cockLength += 1;
		player.lengthChange(1, 1);
		BodyStateMenu();
	}
	public function AddPussy():void {
		player.createVagina();
		player.clitLength = .25;
		if (player.fertility <= 5) player.fertility = 6;
		BodyStateMenu();
	}
	public function AddCockBalls():void {
		player.createCock(4);
		if (player.balls <= 1) {
			player.balls = 2;
			player.ballSize = 1;
		}
		BodyStateMenu();
	}
	public function SubTallness1():void {
		player.tallness -= 2;
		if (player.basetallness < 42) player.tallness = 42;
		BodyStateMenu();
	}
	public function SubTallness2():void {
		player.tallness -= 12;
		if (player.basetallness < 42) player.tallness = 42;
		BodyStateMenu();
	}
	public function SubHairLength():void {
		player.hairLength -= 2;
		if (player.hairLength < 0) player.hairLength = 0;
		BodyStateMenu();
	}
	public function SubCupSize():void {
		if (player.breastRows[0].breastRating >= 1) player.breastRows[0].breastRating--;
		BodyStateMenu();
	}
	public function SubCockLength():void {
		var index:int = 0;
		outputText("\n\n");
		player.cocks[0].cockLength -= 1;
		player.lengthChange(-1, 1);
		if (player.cocks[index].cockLength < 2) {
			outputText("  ");
			player.killCocks(1);
		}
		BodyStateMenu();
	}
	public function RemovePussy():void {
		player.clitLength = .25;
		player.removeVagina(0, 1);
		BodyStateMenu();
	}
	public function RemoveCockBalls():void {
		player.killCocks(1);
		if (player.balls > 1) {
			player.balls = 0;
			player.ballSize = 0;
		}
		BodyStateMenu();
	}

	/*if (player.breastRows.length == 0) {
					outputText("A perfect pair of B cup breasts, complete with tiny nipples, form on your chest.");
					player.createBreastRow();
					player.breastRows[0].breasts = 2;
					//player.breastRows[0].breastsPerRow = 2;
					player.breastRows[0].nipplesPerBreast = 1;
					player.breastRows[0].breastRating = 2;
					outputText("\n");
				}
			}*/
	public function FasterOrInstantCampNPCRecruitment():void {
		menu();
		addButton(0, "E.I.K.", EmberIsabellaKiha).hint("Ember / Isabella / Kiha (If PC have all 3 nothing will happen after choosing this option.)");
		if (flags[kFLAGS.ETNA_FOLLOWER] < 2) addButton(1, "Etna", SuccubusishMantioreOnLeash);
		if (flags[kFLAGS.KINDRA_FOLLOWER] < 1) addButton(2, "Kindra", KindraMemory5);
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KINDRA_LVL_UP] == 6) addButton(3, "Kindra 1UP", Kindra1stLvLUp);
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KINDRA_LVL_UP] == 7) addButton(3, "Kindra 2UP", Kindra2ndLvLUp);
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KINDRA_LVL_UP] == 8) addButton(3, "Kindra 3UP", Kindra3rdLvLUp);
		if (flags[kFLAGS.KINDRA_LVL_UP] >= 7) addButton(4, "Kindra DeLvL", KindraTestDeLvL);
		if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] < 1) addButton(5, "Ember 1UP", Ember1stLvLUp);
		if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 1) addButton(5, "Ember 2UP", Ember2ndLvLUp);
		if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 2) addButton(5, "Ember 3UP", Ember3rdLvLUp);
		if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 3) addButton(5, "Ember 4UP", Ember4thLvLUp);
		if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 4) addButton(5, "Ember 5UP", Ember5thLvLUp);
		if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 5) addButton(5, "Ember 6UP", Ember6thLvLUp);
		if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 6) addButton(5, "Ember 7UP", Ember7thLvLUp);
		if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] < 1) addButton(6, "Isabella 1UP", Isabella1stLvLUp);
		if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 1) addButton(6, "Isabella 2UP", Isabella2ndLvLUp);
		if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 2) addButton(6, "Isabella 3UP", Isabella3rdLvLUp);
		if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 3) addButton(6, "Isabella 4UP", Isabella4thLvLUp);
		if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 4) addButton(6, "Isabella 5UP", Isabella5thLvLUp);
		if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 5) addButton(6, "Isabella 6UP", Isabella6thLvLUp);
		if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 6) addButton(6, "Isabella 7UP", Isabella7thLvLUp);
		if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] < 1) addButton(7, "Kiha 1UP", Kiha1stLvLUp);
		if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 1) addButton(7, "Kiha 2UP", Kiha2ndLvLUp);
		if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 2) addButton(7, "Kiha 3UP", Kiha3rdLvLUp);
		if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 3) addButton(7, "Kiha 4UP", Kiha4thLvLUp);
		if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 4) addButton(7, "Kiha 5UP", Kiha5thLvLUp);
		if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 5) addButton(7, "Kiha 6UP", Kiha6thLvLUp);
		if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 6) addButton(7, "Kiha 7UP", Kiha7thLvLUp);
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] < 1) addButton(8, "Etna 1UP", Etna1stLvLUp);
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 1) addButton(8, "Etna 2UP", Etna2ndLvLUp);
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 2) addButton(8, "Etna 3UP", Etna3rdLvLUp);
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 3) addButton(8, "Etna 4UP", Etna4thLvLUp);
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 4) addButton(8, "Etna 5UP", Etna5thLvLUp);
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 5) addButton(8, "Etna 6UP", Etna6thLvLUp);
		if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 6) addButton(8, "Etna 7UP", Etna7thLvLUp);
		if (flags[kFLAGS.EMBER_LVL_UP] >= 1) addButton(10, "Ember DeLvL", EmberTestDeLvL);
		if (flags[kFLAGS.ISABELLA_LVL_UP] >= 1) addButton(11, "Isabella DeLvL", IsabellaTestDeLvL);
		if (flags[kFLAGS.KIHA_LVL_UP] >= 1) addButton(12, "Kiha DeLvL", KihaTestDeLvL);
		if (flags[kFLAGS.ETNA_LVL_UP] >= 1) addButton(13, "Etna DeLvL", EtnaTestDeLvL);
		addButton(14, "Back", SoulforceCheats);
	}
	public function EmberIsabellaKiha():void {
		if (flags[kFLAGS.EMBER_HATCHED] < 1 && flags[kFLAGS.TOOK_EMBER_EGG] < 1) InstaEmberEggInCamp();
		if (flags[kFLAGS.ISABELLA_FOLLOWER_ACCEPTED] < 1) LilCocksLoverSummoning();
		if (flags[kFLAGS.KIHA_FOLLOWER] < 1) ResidentCampDragonishTsundere();
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function InstaEmberEggInCamp():void {
		player.createKeyItem("Dragon Egg", 0, 0, 0, 0);
		flags[kFLAGS.TOOK_EMBER_EGG] = 1;
		flags[kFLAGS.EMBER_COR] = 50;
		outputText("\n\n<b>Ember Egg put in camp.</b>");
	}
	public function LilCocksLoverSummoning():void {
		flags[kFLAGS.ISABELLA_COUNTDOWN_TO_CONTRACEPTIONS] = 240;
		flags[kFLAGS.ISABELLA_AFFECTION] = 100;
		flags[kFLAGS.ISABELLA_FOLLOWER_ACCEPTED] = 1;
		flags[kFLAGS.ISABELLA_PLAINS_DISABLED] = 1;
		outputText("\n\n<b>I heard you love cows loving small cocks...so here you will get Isabella *wink wink*</b>");
	}
	public function ResidentCampDragonishTsundere():void {
		flags[kFLAGS.KIHA_AFFECTION_LEVEL] = 2;
		flags[kFLAGS.KIHA_AFFECTION] = 100;
		flags[kFLAGS.KIHA_MOVE_IN_OFFER] = 1;
		flags[kFLAGS.KIHA_FOLLOWER] = 1;
		outputText("\n\n<b>We need more...yandered dragon-like waifu. Or was it only more of Kiha?</b>");
	}
	public function KindraMemory5():void {
		flags[kFLAGS.KINDRA_LVL_UP] = 6;
		flags[kFLAGS.KINDRA_FOLLOWER] = 1;
		flags[kFLAGS.KINDRA_AFFECTION] = 5;
		outputText("\n\n<b>Kindra... and everything is clear.</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function SuccubusishMantioreOnLeash():void {
		flags[kFLAGS.ETNA_AFFECTION] = 80;
		flags[kFLAGS.ETNA_FOLLOWER] = 2;
		flags[kFLAGS.ETNA_DAILY_VENOM_VIAL] = 0;
		outputText("\n\n<b>Watch for Etna is in da hous... err camp.</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Ember1stLvLUp():void {
		flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.EMBER_LVL_UP] = 1;
		outputText("\n\n<b>Ember 1st LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Ember2ndLvLUp():void {
		flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.EMBER_LVL_UP] = 2;
		outputText("\n\n<b>Ember 2nd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Ember3rdLvLUp():void {
		flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.EMBER_LVL_UP] = 3;
		outputText("\n\n<b>Ember 3rd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Ember4thLvLUp():void {
		flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.EMBER_LVL_UP] = 4;
		outputText("\n\n<b>Ember 4th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Ember5thLvLUp():void {
		flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.EMBER_LVL_UP] = 5;
		outputText("\n\n<b>Ember 5th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Ember6thLvLUp():void {
		flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.EMBER_LVL_UP] = 6;
		outputText("\n\n<b>Ember 6th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Ember7thLvLUp():void {
		flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.EMBER_LVL_UP] = 7;
		outputText("\n\n<b>Ember 7th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function EmberTestDeLvL():void {
		flags[kFLAGS.EMBER_LVL_UP]--;
		outputText("\n\n<b>Ember been De-LvL'd!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Isabella1stLvLUp():void {
		flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ISABELLA_LVL_UP] = 1;
		outputText("\n\n<b>Isabella 1st LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Isabella2ndLvLUp():void {
		flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ISABELLA_LVL_UP] = 2;
		outputText("\n\n<b>Isabella 2nd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Isabella3rdLvLUp():void {
		flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ISABELLA_LVL_UP] = 3;
		outputText("\n\n<b>Isabella 3rd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Isabella4thLvLUp():void {
		flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ISABELLA_LVL_UP] = 4;
		outputText("\n\n<b>Isabella 4th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Isabella5thLvLUp():void {
		flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ISABELLA_LVL_UP] = 5;
		outputText("\n\n<b>Isabella 5th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Isabella6thLvLUp():void {
		flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ISABELLA_LVL_UP] = 6;
		outputText("\n\n<b>Isabella 6th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Isabella7thLvLUp():void {
		flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ISABELLA_LVL_UP] = 7;
		outputText("\n\n<b>Isabella 7th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function IsabellaTestDeLvL():void {
		flags[kFLAGS.ISABELLA_LVL_UP]--;
		outputText("\n\n<b>Isabella been De-LvL'd!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kiha1stLvLUp():void {
		flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KIHA_LVL_UP] = 1;
		outputText("\n\n<b>Kiha 1st LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kiha2ndLvLUp():void {
		flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KIHA_LVL_UP] = 2;
		outputText("\n\n<b>Kiha 2nd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kiha3rdLvLUp():void {
		flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KIHA_LVL_UP] = 3;
		outputText("\n\n<b>Kiha 3rd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kiha4thLvLUp():void {
		flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KIHA_LVL_UP] = 4;
		outputText("\n\n<b>Kiha 4th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kiha5thLvLUp():void {
		flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KIHA_LVL_UP] = 5;
		outputText("\n\n<b>Kiha 5th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kiha6thLvLUp():void {
		flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KIHA_LVL_UP] = 6;
		outputText("\n\n<b>Kiha 6th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kiha7thLvLUp():void {
		flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KIHA_LVL_UP] = 7;
		outputText("\n\n<b>Kiha 7th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function KihaTestDeLvL():void {
		flags[kFLAGS.KIHA_LVL_UP]--;
		outputText("\n\n<b>Kiha been De-LvL'd!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kindra1stLvLUp():void {
		flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KINDRA_LVL_UP] = 7;
		outputText("\n\n<b>Kindra 1st LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kindra2ndLvLUp():void {
		flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KINDRA_LVL_UP] = 8;
		outputText("\n\n<b>Kindra 2nd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Kindra3rdLvLUp():void {
		flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.KINDRA_LVL_UP] = 9;
		outputText("\n\n<b>Kindra 3rd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function KindraTestDeLvL():void {
		flags[kFLAGS.KINDRA_LVL_UP]--;
		outputText("\n\n<b>Kindra been De-LvL'd!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Etna1stLvLUp():void {
		flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ETNA_LVL_UP] = 1;
		outputText("\n\n<b>Etna 1st LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Etna2ndLvLUp():void {
		flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ETNA_LVL_UP] = 2;
		outputText("\n\n<b>Etna 2nd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Etna3rdLvLUp():void {
		flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ETNA_LVL_UP] = 3;
		outputText("\n\n<b>Etna 3rd LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Etna4thLvLUp():void {
		flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ETNA_LVL_UP] = 4;
		outputText("\n\n<b>Etna 4th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Etna5thLvLUp():void {
		flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ETNA_LVL_UP] = 5;
		outputText("\n\n<b>Etna 5th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Etna6thLvLUp():void {
		flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ETNA_LVL_UP] = 6;
		outputText("\n\n<b>Etna 6th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function Etna7thLvLUp():void {
		flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.ETNA_LVL_UP] = 7;
		outputText("\n\n<b>Etna 7th LvL-Up!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function EtnaTestDeLvL():void {
		flags[kFLAGS.ETNA_LVL_UP]--;
		outputText("\n\n<b>Etna been De-LvL'd!!!</b>");
		doNext(FasterOrInstantCampNPCRecruitment);
	}
	public function EquipmentMenu(page:int = 1):void {
		menu();
		if (page == 1) {
			addButton(0, "Rap. Perk", AddRapPerk).hint("Add Raphael Rapier Perk and 1 Dragon Rapier.  USE only ONCE to not break the game!");
			addButton(1, "Sky Pearl", AddSkyPoisonPearl).hint("Add 1 Sky Poison Pearl.");
			addButton(2, "CatONIneTWhip", AddCatONineTailWhip).hint("Add 1 Bastet Whip.");
			addButton(3, "NineTailWhip", AddNineTailWhip).hint("Add 1 Nine Tail Whip.");
			addButton(4, "DualLAxes", AddDualMinoAxes).hint("Add 1 pair of Large Axes.");
			addButton(5, "UH Ayo Arm", AddUltraHeavyAyoArmor).hint("Add 1 Ultra heavy Ayo Armor for testing purposes.");
			addButton(6, "AncientConduit", AddAncientConduit).hint("Add 1 Ancient Conduit.");
			addButton(7, "HB Mech", AddHBMech).hint("Add 1 Howling Banshee Mech for testing purposes.");
			addButton(8, "GobMechPrime", AddGoblinMechPrime).hint("Add 1 Goblin Mech Prime for testing purposes.");
			addButton(9, "GiantSlayerMech", AddGiantSlayerMech).hint("Add 1 Giant Slayer Mech for testing purposes.");
			addButton(10, "E. Tome", AddTheElementalistsTome).hint("Add 1 Elementalist’s Tome.");
			addButton(11, "Evelyn", AddTheEvelyn).hint("Add 1 Evelyn Crossbow.");
			addButton(12, "InqTome", AddTheInquisitorsTome).hint("Add 1 Inquisitor's Tome.");
			addButton(13, "-2-", EquipmentMenu, page + 1);
			addButton(14, "Back", SoulforceCheats);
		}
		if (page == 2)  {
			//0
			//1
			//2
			//3
			//4
			//5
			//6
			addButton(7, "BerserkerSet", AddTheBBS).hint("Add set of items for Berserker set.");//7
			addButton(8, "CheckWeapon", TestWeaponType).hint("Detect Weapon Type Equiped for sprite and battle testing.");
			addButton(9, "Ascensus", AddTheStaffs).hint("Add set of items for Ascensus.");
			addButton(10, "YODrops", AddYukiOnnaStuff).hint("Add both Yuki Onna equipment drops for testing purposes.");
			addButton(11, "SpikeShields", AddSpikedShields).hint("Add set of two spiked shields of various sizes and weight for testing purposes.");
			addButton(12, "MatrixArmory1", AddTheSeerHairpinAndCo).hint("Adds: 1 Eldritch Staff, 1 master Gloves, 1 Gnoll Throwing Axes, 1 Hodr's Bow, 1 Truestrike Sword, 1 Sceptre of Command, 1 Demonic Scythe, 1 Seer's Hairpin, Sakura Petal Kimono, Oni bead necklace");
			addButton(13, "-1-", EquipmentMenu, page - 1);
			addButton(14, "Back", SoulforceCheats);
		}
	}
	public function AddTheBBS():void {
		outputText("\n\n<b>(Gained set of items to make berseker set!)</b>\n\n");
		inventory.takeItem(armors.BESTBLA, AddTheBBS1);
	}
	public function AddTheBBS1():void {
		outputText("\n\n");
		inventory.takeItem(headjewelries.BESTBLAA, curry(EquipmentMenu, 2));
	}
	public function NonEquipmentMenu(page:int = 1):void {
		menu();
		if (page == 1) {
			addButton(0, "Fox Jewel", AddFoxJewel).hint("Add 1 Fox Jewel.");
			addButton(1, "CDI", AddCurrentDebugItem).hint("Add 1 Gun.");
			addButton(2, "TrollFig", AddTrollFig).hint("Add 1 Troll Fig.");
			addButton(3, "CyclopTF", AddEyedrop).hint("Add 1 cyclop TF.");
			//addButton(4, "", ).hint("Add 1  .");
			addButton(5, "ALICORN", AddAlicornium).hint("Add 1 Alicornium.");
			addButton(6, "D.Fruit", AddDisplacerFruit).hint("Add 1 Displacer Fruit.");
			addButton(7, "AbyssalSTooth", AddAbyssalSharkTooth).hint("Add 1 Abyssal Shark Tooth.");
			//addButton(8, "", ).hint("Add 1 .");
			//addButton(9, "", ).hint("Add 1 .");
			addButton(10, "SBMan", AddSoulBlastManual).hint("Add 1 Soul Blast manual.");
			//addButton(11, "", ).hint("Add 1 .");
			addButton(12, "-2-", NonEquipmentMenu, page + 1);
			addButton(13, "-3-", NonEquipmentMenu, page + 2);
			addButton(14, "Back", SoulforceCheats);
		}
		if (page == 2) {
			addButton(0, "SkybornSeed", AddSkybornSeed).hint("Add 1 Skyborn Seed.");
			addButton(1, "F.Fish", AddFreshFish).hint("Add 1 Fresh Fish.");
			addButton(2, "BehemothCum", AddBehemothCum).hint("Add 1 bottle of Behemoth Cum.");
			addButton(3, "TGOGossamer", AddThickGreenOnnaGossamer).hint("Add 1 Thick Green Onna Gossamer.");
			addButton(4, "Desert Berry", AddDesertBerry).hint("Add 1 werefox TF.");
			addButton(5, "Enigmanium", AddEnigmanium).hint("Add 1 vial of Enigmanium.");
			addButton(6, "dragonshit", AddDragonShit).hint("Add dragon stuff for jabberwocky test.");
			addButton(7, "Naga Oils", AddGorgonOil).hint("Add 1 vial of Gorgon, Vouivre and Couatl Oil.");
			addButton(8, "VT RV WF", AddVoltageTopaz).hint("Add 1 Voltage Topaz, 1 vial of Red Blood (Bat TF) and 1 Wonder Fruit.");
			addButton(9, "DSJ HS FSS", AddDarkSlimeJelly).hint("Add 1 Dark Slime Jelly, 1 Hydra Scale and 1 Fire Snail Saliva.");
			addButton(10, "Fafnir tear", AddFTear).hint("Add 1 Fafnir tear (Frost wyrm TF).");
			addButton(11, "Midnight gossamer", AddGossa).hint("Add 1 Midnight Gossamer.");
			addButton(12, "-1-", NonEquipmentMenu, page - 1);
			addButton(13, "-3-", NonEquipmentMenu, page + 1);
			addButton(14, "Back", SoulforceCheats);
		}
		if (page == 3) {
			addButton(0, "CrimsonJade", AddCrimsonJade).hint("Add 1 Crimson Jade.");
			addButton(1, "R.Manuscript", AddRedManuscript).hint("Add 1 Red Manuscript.");
			addButton(2, "White B.", AddWhiteBook).hint("Add 1 White Book.");
			addButton(3, "Black B.", AddBlackBook).hint("Add 1 Black Book.");
			addButton(4, "Grey B.", AddGreyBook).hint("Add 1 Grey Book.");
			addButton(5, "V.D.ARC", AddVeryDilutedArcaneRegenConcotion).hint("Add 1 very diluted Arcane Regen Concotion.");
			addButton(6, "D.ARC", AddDilutedArcaneRegenConcotion).hint("Add 1 diluted Arcane Regen Concotion.");
			addButton(7, "A.R.CON", AddArcaneRegenConcotion).hint("Add 1 Arcane Regen Concotion.");
			addButton(8, consumables.METHIRC.shortName, addConsumable, consumables.METHIRC).hint("Add 1 " + consumables.METHIRC.longName + ".");
			addButton(9, consumables.P_M_CUM.shortName, addConsumable, consumables.P_M_CUM).hint("Add 1 " + consumables.P_M_CUM.longName + ".");
			addButton(10, "E.Pearls", AddThePearls).hint("Add all three Elemental Pearls.");
			addButton(11, consumables.VAMPBLD.shortName, addConsumable, consumables.VAMPBLD).hint("Add 1 " + consumables.VAMPBLD.longName + ".");
			addButton(12, "-1-", NonEquipmentMenu, page - 2);
			addButton(13, "-2-", NonEquipmentMenu, page - 1);
			addButton(14, "Back", SoulforceCheats);
		}
	}

	private function addConsumable(consumable: Consumable): void {
		outputText("\n\n<b>(Gained 1 " + consumable.longName + "!)</b>\n\n");
		inventory.takeItem(consumable, curry(NonEquipmentMenu, 3));
	}

	public function MaterialMenu(page:int = 1):void {
		menu();
		if (page == 1) {
			addButton(0, "Wood", AddWood).hint("Add 100 Wood (game not check for limits so not go overboard with using this cheat).");
			addButton(1, "Nails", AddNail).hint("Add 50 Nails (game not check for limits so not go overboard with using this cheat).");
			addButton(2, "Stone", AddStone).hint("Add 100 Stone (game not check for limits so not go overboard with using this cheat).");
			addButton(3, "MetalPieces", AddMetalPieces).hint("Add 50 Metal Pieces (game not check for limits so not go overboard with using this cheat).");
			addButton(4, "SpiderSilk", AddSpiderSilk).hint("Add 1 Spider Silk.");
			addButton(5, "Ebonbloom", AddEbonbloom).hint("Add 1 Ebonbloom.");
			addButton(6, "WorldTreeB.", AddWorldTreeBranch).hint("Add 1 World Tree Branch.");
			addButton(7, "ChitinShard", AddBeeChitin).hint("Add 1 Chitin shard.");
			addButton(8, "GreenGel", AddGreenGel).hint("Add 1 Green Gel.");
			addButton(9, "DragonScale", AddDragonscale).hint("Add 1 Dragonscale.");
			addButton(10, "S.Shard", AddShard).hint("Add 1 S.Shard.");//addButton(10, "", ).hint("Add 1 .");
			addButton(11, "HEALHERB", AddHerb).hint("Add 1 HEALHERB.");
			addButton(12, "Copp/Tin/Iron", AddCooperTinIronOre).hint("Add 1 Cooper, Tin and Iron ore.");
			addButton(13, "-2-", MaterialMenu, page + 1);
			addButton(14, "Back", SoulforceCheats);
		}
		if (page == 2) {
			addButton(0, "Skymetal", AddSkymetalOre).hint("Add 1 Skymetal Ore.");
			addButton(1, "Moonstone", AddMoonstone).hint("Add 1 Moonstone.");
			//addButton(2, "", ).hint("Add 1 .");
			//addButton(3, "", ).hint("Add 1 .");
			//addButton(4, "", ).hint("Add 1 .");
			addButton(5, "E.Shard", AddElementalShard).hint("Add 1 E.Shard.");//addButton(5, "", ).hint("Add 1 .");
			addButton(6, "UnicornHair", AddUnicornHair).hint("Add 1 Unicorn Hair.");
			addButton(7, "GolemCore", AddGolemCore).hint("Add 1 Golem Core.");
			addButton(8, "Mechanism", AddMechanism).hint("Add 1 Mechanism.");
			addButton(9, "EnergyCore", AddEnergyCore).hint("Add 1 Energy Core.");
			addButton(10, "F.Imp S.", AddFeralImpSkull).hint("Add 1 Feral Imp Skull.");
			addButton(11, "MetShoTom", AddMeteorShowerTome).hint("Add 1 Meteor Shower tome.");
			addButton(12, "PolMidScr", AddPolarMidnightScroll).hint("Add 1 Polar Midnight scroll.");
			addButton(13, "-1-", MaterialMenu, page - 1);
			addButton(14, "Back", SoulforceCheats);
		}
	}
	public function enemiesMenu():void {
		var buttons:ButtonDataList = new ButtonDataList();
		menu();
		
		buttons.add("Overseer", curry(fightMonster, OmnibusOverseer), "Test Fight against Omnibus Overseer");
		buttons.add("Sand Mother", FightSandMother, "Test Fight against Sand Mother");
		buttons.add("Zetaz", curry(fightMonster, Zetaz), "Test Fight against Zetaz");
		buttons.add("Incels", curry(fightMonster, Incels), "Test Fight against Incels");
		buttons.add("SuccGard", FightSuccubusGardener, "Test fight with Succubus Gardener. (Also it will glitch right after fight so not start this fight if you got unsaved progress that you not wanna loose as only way to handle post fight glitch is restarting game)");
		buttons.add("Lethice", FightLethice, "Test Fight against Lethice");
		buttons.add("Marae", FightMarae, "Test fight with Marae (depending on game stage she can be buffed or unbuffed).");
		buttons.add("The Dummy", FightTheDummy, "Test Fight against The Dummy");
		buttons.add("FightForPearl", FightForPearl, "Test fight to get Sky Poison Pearl legally (aside we cheat to start fight)");
		buttons.add("B.Monke", FightWaizAbi, "You not even want to let the innocent bimbo monke free? <i>*sigh*</i>");
		if (player.level >= 45) buttons.add("Oculicorn", FightIridesian, "Test fight with Oculicorn.");
		buttons.add("Draculina", curry(fightMonster, Draculina), "Test Fight against Draculina");
		buttons.add("GothGirl", FightLilith, "Fight with devilish cute goth girl.");
		buttons.add("Sonya", FightSonya, "Test fight with Sonya.");
		buttons.add("RyuBi", FightRyuBi, "Test fight with RyuBi.");
		buttons.add("Galia", FightGalia, "Test fight with Galia.");
		buttons.add("ChaosChimera", FightChaosChimera, "Test fight with Chaos Chimera.");
		buttons.add("AnotSucc", FightCarrera, "Fight with probably another succubus out there...");
		buttons.add("Aria", FightAria, "Test fight with melkie huntress Aria.");
		buttons.add("SomeMalikore", FightRandomnMalikore, "Test fight with some malikore.");
		buttons.add("Pierce", FightPierce, "Test fight with Pierce.");
		buttons.add("LvLUP Eva", LvLUPEva, "LvL UP forcefully Evangeline for testing purpose up to the limit.");
		buttons.add("DELvL Eva", DELvLEva, "DE LvL forcefully Evangeline for testing purpose down toward the lvl 12.");
		buttons.add("LvLUP Aurora", LvLUPAurora, "LvL UP forcefully Aurora for testing purpose up to the limit.");
		buttons.add("DELvL Aurora", DELvLAurora, "DE LvL forcefully Aurora for testing purpose down toward the lvl 1.");
		submenu(buttons, SoulforceCheats, 0, false);
	}

	public function AddRapPerk():void {
		flags[kFLAGS.RAPHAEL_RAPIER_TRANING] = 4;
		player.createPerk(PerkLib.RapierTraining, 0, 0, 0, 0);
		outputText("\n\n<b>(Gained Perk: Rapier Training and 1 Dragon Rapier!)</b>\n\n");
		inventory.takeItem(weapons.DRAPIER, curry(EquipmentMenu, 1));
	}
	public function AddSkyPoisonPearl():void {
		outputText("\n\n<b>(Gained 1 Sky Poison Pearl!)</b>\n\n");
		inventory.takeItem(consumables.SPPEARL, curry(EquipmentMenu, 1));
	}
	public function AddCatONineTailWhip():void {
		outputText("\n\n<b>(Gained 1 Bastet Whip!)</b>\n\n");
		inventory.takeItem(weapons.CNTWHIP, curry(EquipmentMenu, 1));
	}
	public function AddNineTailWhip():void {
		outputText("\n\n<b>(Gained 1 Nine Tail Whip!)</b>\n\n");
		inventory.takeItem(weapons.NTWHIP, curry(EquipmentMenu, 1));
	}
	public function AddDualMinoAxes():void {
		outputText("\n\n<b>(Gained 1 pair of Large Axes!)</b>\n\n");
		inventory.takeItem(weapons.DL_AXE_, curry(EquipmentMenu, 1));
	}
	public function AddAncientConduit():void {
		outputText("\n\n<b>(Gained 1 Ancient Conduit!)</b>\n\n");
		inventory.takeItem(shields.ANC_CON, curry(EquipmentMenu, 1));
	}
	public function AddUltraHeavyAyoArmor():void {
		outputText("\n\n<b>(Gained 1 Ultra Heavy Ayo Armor!)</b>\n\n");
		inventory.takeItem(armors.UHAYOARM, curry(EquipmentMenu, 1));
	}
	public function AddHBMech():void {
		outputText("\n\n<b>(Gained 1 Howling Banshee Mech!)</b>\n\n");
		inventory.takeItem(vehicles.HB_MECH, curry(EquipmentMenu, 1));
	}
	public function AddGoblinMechPrime():void {
		outputText("\n\n<b>(Gained 1 Goblin Mech Prime!)</b>\n\n");
		inventory.takeItem(vehicles.GOBMPRI, curry(EquipmentMenu, 1));
	}
	public function AddGiantSlayerMech():void {
		outputText("\n\n<b>(Gained 1 Giant Slayer Mech!)</b>\n\n");
		inventory.takeItem(vehicles.GS_MECH, curry(EquipmentMenu, 1));
	}
	public function AddTheElementalistsTome():void {
		outputText("\n\n<b>(Gained 1 Elementalist’s Tome!)</b>\n\n");
		inventory.takeItem(weaponsrange.E_TOME_, curry(EquipmentMenu, 1));
	}
	public function AddTheEvelyn():void {
		outputText("\n\n<b>(Gained 1 Evelyn Crossbow!)</b>\n\n");
		inventory.takeItem(weaponsrange.EVELYN_, curry(EquipmentMenu, 1));
	}
	public function AddTheInquisitorsTome():void {
		outputText("\n\n<b>(Gained 1 Inquisitor's Tome!)</b>\n\n");
		inventory.takeItem(weaponsrange.I_TOME_, curry(EquipmentMenu, 1));
	}
	public function AddTheStaffs():void {
		outputText("\n\n<b>(Gained set of items to make Ascensus!)</b>\n\n");
		inventory.takeItem(useables.TBAPLAT, AddTheStaffs1);
	}
	public function AddTheStaffs1():void {
		outputText("\n\n");
		inventory.takeItem(useables.DBAPLAT, AddTheStaffs2);
	}
	public function AddTheStaffs2():void {
		outputText("\n\n");
		inventory.takeItem(weapons.W_STAFF, curry(EquipmentMenu, 2));
	}
	public function AddYukiOnnaStuff():void {
		outputText("\n\n<b>(Gained 1st Yuki Onna item!)</b>\n\n");
		inventory.takeItem(armors.BLIZZ_K, AddYukiOnnaStuff2);
	}
	public function AddYukiOnnaStuff2():void {
		outputText("\n\n<b>(Gained 2nd Yuki Onna item!)</b>\n\n");
		inventory.takeItem(headjewelries.SNOWFH, curry(EquipmentMenu, 2));
	}
	public function AddSpikedShields():void {
		outputText("\n\n<b>(Gained Heavy Spiked Shield!)</b>\n\n");
		inventory.takeItem(shields.SPIH_SH, AddSpikedShields2);
	}
	public function AddSpikedShields2():void {
		outputText("\n\n<b>(Gained Massive Spiked Shield!)</b>\n\n");
		inventory.takeItem(shields.SPIM_SH, curry(EquipmentMenu, 2));
	}
	public function AddTheSeerHairpinAndCo():void {
		outputText("\n\n<b>(Gained 1 Eldritch Staff!)</b>\n\n");
		inventory.takeItem(weapons.E_STAFF, AddTheSeerHairpinAndCo1);
	}
	public function AddTheSeerHairpinAndCo1():void {
		outputText("\n\n<b>(Gained 1 Master Gloves!)</b>\n\n");
		inventory.takeItem(weapons.MASTGLO, AddTheSeerHairpinAndCo2);
	}
	public function AddTheSeerHairpinAndCo2():void {
		outputText("\n\n<b>(Gained 1 Gnoll Throwing Axes!)</b>\n\n");
		inventory.takeItem(weaponsrange.GTHRAXE, AddTheSeerHairpinAndCo3);
	}
	public function AddTheSeerHairpinAndCo3():void {
		outputText("\n\n<b>(Gained 1 Hodr's Bow!)</b>\n\n");
		inventory.takeItem(weaponsrange.BOWHODR, AddTheSeerHairpinAndCo4);
	}
	public function AddTheSeerHairpinAndCo4():void {
		outputText("\n\n<b>(Gained 1 Sceptre of Command!)</b>\n\n");
		inventory.takeItem(weapons.SCECOMM, AddTheSeerHairpinAndCo5);
	}
	public function AddTheSeerHairpinAndCo5():void {
		outputText("\n\n<b>(Gained 1 Truestrike Sword!)</b>\n\n");
		inventory.takeItem(weapons.TRSTSWO, AddTheSeerHairpinAndCo6);
	}
	public function AddTheSeerHairpinAndCo6():void {
		outputText("\n\n<b>(Gained 1 Demonic Scythe!)</b>\n\n");
		inventory.takeItem(weapons.DEMSCYT, AddTheSeerHairpinAndCo7);
	}
	public function AddTheSeerHairpinAndCo7():void {
		outputText("\n\n<b>(Gained 1 Seer's Hairpin!)</b>\n\n");
		inventory.takeItem(headjewelries.SEERPIN, AddTheSeerHairpinAndCo8);
	}
	public function AddTheSeerHairpinAndCo8():void {
		outputText("\n\n<b>(Gained 1 Sakura Petal Kimono!)</b>\n\n");
		inventory.takeItem(armors.SPKIMO, AddTheSeerHairpinAndCo9);
	}
	public function AddTheSeerHairpinAndCo9():void {
		outputText("\n\n<b>(Gained 1 Oni bead necklace!)</b>\n\n");
		inventory.takeItem(necklaces.OBNECK, curry(EquipmentMenu, 2));
	}

	public function AddFoxJewel():void {
		outputText("\n\n<b>(Gained 1 Fox Jewel!)</b>\n\n");
		inventory.takeItem(consumables.FOXJEWL, curry(NonEquipmentMenu, 1));
	}
	public function AddFreshFish():void {
		outputText("\n\n<b>(Gained 1 Fresh Fish!)</b>\n\n");
		inventory.takeItem(consumables.FREFISH, curry(NonEquipmentMenu, 2));
	}
	public function AddTrollFig():void {
		outputText("\n\n<b>(Gained 1 Troll Fig!)</b>\n\n");
		inventory.takeItem(consumables.TROLFIG, curry(NonEquipmentMenu, 1));
	}
	public function AddEyedrop():void {
		outputText("\n\n<b>(Gained 1 Cyclop TF)</b>\n\n");
		inventory.takeItem(consumables.EYEDROP, curry(NonEquipmentMenu, 1));
	}
	public function AddDesertBerry():void {
		outputText("\n\n<b>(Gained 1 Werefox TF)</b>\n\n");
		inventory.takeItem(consumables.DESERTB, curry(NonEquipmentMenu, 2));
	}
	public function AddVoltageTopaz():void {
		outputText("\n\n<b>(Gained 1 Voltage Topaz!)</b>\n\n");
		inventory.takeItem(consumables.VOLTTOP, AddRedBlood);
	}
	public function AddDragonShit():void {
		outputText("\n\n<b>(Gained 1 dragon!)</b>\n\n");
		inventory.takeItem(consumables.DRAKHRT, AddJabbyShit);
	}
	public function AddJabbyShit():void {
		outputText("\n\n<b>(Gained 1 Jabby!)</b>\n\n");
		inventory.takeItem(consumables.JABBERS, curry(NonEquipmentMenu, 2));
	}
	public function AddRedBlood():void {
		outputText("\n\n<b>(Gained 1 vial of red blood!)</b>\n\n");
		inventory.takeItem(consumables.REDVIAL, AddWonderFruit);
	}
	public function AddWonderFruit():void {
		outputText("\n\n<b>(Gained 1 Wonder Fruit!)</b>\n\n");
		inventory.takeItem(consumables.WOFRUIT, curry(NonEquipmentMenu, 2));
	}
	public function AddDarkSlimeJelly():void {
		outputText("\n\n<b>(Gained 1 Dark Slime Jelly!)</b>\n\n");
		inventory.takeItem(consumables.DSLIMEJ, AddHydraScale);
	}
	public function AddHydraScale():void {
		outputText("\n\n<b>(Gained 1 Hydra Scale!)</b>\n\n");
		inventory.takeItem(consumables.HYDRASC, AddFireSnailSaliva);
	}
	public function AddFireSnailSaliva():void {
		outputText("\n\n<b>(Gained 1 Fire Snail Saliva!)</b>\n\n");
		inventory.takeItem(consumables.FSNAILS, curry(NonEquipmentMenu, 2));
	}
	public function AddGorgonOil():void {
		outputText("\n\n<b>(Gained 1 vial of Gorgon Oil!)</b>\n\n");
		inventory.takeItem(consumables.GORGOIL, AddVouivreOil);
	}
	public function AddVouivreOil():void {
		outputText("\n\n<b>(Gained 1 vial of Vouivre Oil!)</b>\n\n");
		inventory.takeItem(consumables.VOUIOIL, AddCouatlOil);
	}
	public function AddCouatlOil():void {
		outputText("\n\n<b>(Gained 1 vial of Couatl Oil!)</b>\n\n");
		inventory.takeItem(consumables.COUAOIL, curry(NonEquipmentMenu, 2));
	}
	public function AddEnigmanium():void {
		outputText("\n\n<b>(Gained 1 vial of Enigmanium!)</b>\n\n");
		inventory.takeItem(consumables.ENIGMANIUM, curry(NonEquipmentMenu, 2));
	}
	public function AddSkelp():void {
		outputText("\n\n<b>(Gained 1 Skelp!)</b>\n\n");
		inventory.takeItem(consumables.SKELP__, curry(NonEquipmentMenu, 2));
	}
	public function AddFTear():void {
		outputText("\n\n<b>(Gained 1 Fafnir Tear!)</b>\n\n");
		inventory.takeItem(consumables.F_TEAR, curry(NonEquipmentMenu, 2));
	}
	public function AddBubble():void {
		outputText("\n\n<b>(Gained 1 Bubblegum!)</b>\n\n");
		inventory.takeItem(consumables.BUBBLEG, curry(NonEquipmentMenu, 2));
	}

	public function AddGossa():void {
		outputText("\n\n<b>(Gained 1 Midnight gossamer!)</b>\n\n");
		inventory.takeItem(consumables.M_GOSSR, curry(NonEquipmentMenu, 2));
	}

	public function AddMetalPieces():void {
		outputText("\n\n<b>(Gained 50 Metal Pieces!)</b>\n\n");
		CampStatsAndResources.MetalPieces += 50;
		statScreenRefresh();
		curry(MaterialMenu, 1);
	}
	public function AddSpiderSilk():void {
		outputText("\n\n<b>(Gained 1 Spider Silk!)</b>\n\n");
		inventory.takeItem(useables.T_SSILK, curry(MaterialMenu, 1));
	}
	public function AddBeeChitin():void {
		outputText("\n\n<b>(Gained 1 Chitin Shard!)</b>\n\n");
		inventory.takeItem(useables.B_CHITN, curry(MaterialMenu, 1));
	}
	public function AddGreenGel():void {
		outputText("\n\n<b>(Gained 1 Green Gel!)</b>\n\n");
		inventory.takeItem(useables.GREENGL, curry(MaterialMenu, 1));
	}
	public function AddDragonscale():void {
		outputText("\n\n<b>(Gained 1 Dragonscale!)</b>\n\n");
		inventory.takeItem(useables.D_SCALE, curry(MaterialMenu, 1));
	}
	public function AddShard():void {
		outputText("\n\n<b>(Gained 1 Shard!)</b>\n\n");
		inventory.takeItem(useables.S_SHARD, curry(MaterialMenu, 1));
	}
	public function AddHerb():void {
		outputText("\n\n<b>(Gained 1 Healing Herb!)</b>\n\n");
		inventory.takeItem(consumables.HEALHERB, curry(MaterialMenu, 1));
	}
	public function AddCooperTinIronOre():void {
		outputText("\n\n<b>(Gained 1 Copper Ore!)</b>\n\n");
		inventory.takeItem(useables.COP_ORE, AddCooperTinIronOre1);
	}
	public function AddCooperTinIronOre1():void {
		outputText("\n\n<b>(Gained 1 Tin Ore!)</b>\n\n");
		inventory.takeItem(useables.TIN_ORE, AddCooperTinIronOre2);
	}
	public function AddCooperTinIronOre2():void {
		outputText("\n\n<b>(Gained 1 Irno Ore!)</b>\n\n");
		inventory.takeItem(useables.IRONORE, curry(MaterialMenu, 1));
	}
	public function AddEnergyCore():void {
		outputText("\n\n<b>(Gained 1 Energy Core!)</b>\n\n");
		CampStatsAndResources.EnergyCoreResc += 1;
		statScreenRefresh();
		curry(MaterialMenu, 2);
	}
	public function AddMechanism():void {
		outputText("\n\n<b>(Gained 1 Mechanism!)</b>\n\n");
		CampStatsAndResources.MechanismResc += 1;
		statScreenRefresh();
		curry(MaterialMenu, 2);
	}
	public function AddGolemCore():void {
		outputText("\n\n<b>(Gained 1 Golem Core!)</b>\n\n");
		inventory.takeItem(useables.GOLCORE, curry(MaterialMenu, 2));
	}
	public function AddSkymetalOre():void {
		outputText("\n\n<b>(Gained 1 Skymetal Ore!)</b>\n\n");
		inventory.takeItem(useables.SKYMETA, curry(MaterialMenu, 2));
	}
	public function AddMoonstone():void {
		outputText("\n\n<b>(Gained 1 Moonstone!)</b>\n\n");
		inventory.takeItem(useables.MOONSTO, curry(MaterialMenu, 2));
	}
	public function AddUnicornHair():void {
		outputText("\n\n<b>(Gained 1 Unicorn Hair!)</b>\n\n");
		inventory.takeItem(useables.UNICORNH, curry(MaterialMenu, 2));
	}
	public function AddElementalShard():void {
		outputText("\n\n<b>(Gained 1 Elemental Shard!)</b>\n\n");
		inventory.takeItem(useables.ELSHARD, curry(MaterialMenu, 2));
	}
	public function AddPolarMidnightScroll():void {
		outputText("\n\n<b>(Gained 1 Polar Midnight scroll!)</b>\n\n");
		inventory.takeItem(consumables.POL_MID, curry(MaterialMenu, 2));
	}
	public function AddMeteorShowerTome():void {
		outputText("\n\n<b>(Gained 1 Meteor Shower tome!)</b>\n\n");
		inventory.takeItem(consumables.MET_SHO, curry(MaterialMenu, 2));
	}
	public function AddFeralImpSkull():void {
		outputText("\n\n<b>(Gained 1 Feral Imp Skull!)</b>\n\n");
		inventory.takeItem(useables.FIMPSKL, curry(MaterialMenu, 2));
	}

	public function TestWeaponType():void {
		outputText("Weapon types: "+[player.isStaffTypeWeapon(),player.isSwordTypeWeapon(),player.isAxeTypeWeapon(),player.isMaceHammerTypeWeapon(),player.isSpearTypeWeapon(),player.isScytheTypeWeapon(),player.isDuelingTypeWeapon()].join());
	}

	public function FightTheDummy():void {
		clearOutput();
		//outputText("Entering battle with The Dummy! Enjoy ^^");
		//startCombat(new TheDummy());
		outputText("Entering battle with Minotaur! Enjoy ^^");
		startCombat(new Minotaur());
	}
	public function FightSuccubusGardener():void {
		clearOutput();
		outputText("Entering battle with Succubus Gardener! Enjoy ^^");
		startCombat(new SuccubusGardener());
	}

	public function AddThickGreenOnnaGossamer():void {
		outputText("\n\n<b>(Gained 1 Thick Green Onna Gossamer!)</b>\n\n");
		inventory.takeItem(consumables.WHITEIS, SoulforceCheats);
	}
	public function AddWhiteIceShard():void {
		outputText("\n\n<b>(Gained 1 White Ice Shard!)</b>\n\n");
		inventory.takeItem(consumables.WHITEIS, SoulforceCheats);
	}
	public function AddLeviathanSunscreen():void {
		outputText("\n\n<b>(Gained 1 Leviathan Sunscreen!)</b>\n\n");
		inventory.takeItem(consumables.LEVISUN, SoulforceCheats);
	}
	public function AddVeryDilutedArcaneRegenConcotion():void {
		outputText("\n\n<b>(Gained 1 very diluted Arcane Regen Concotion!)</b>\n\n");
		inventory.takeItem(consumables.VDARCON, curry(NonEquipmentMenu, 3));
	}
	public function AddDilutedArcaneRegenConcotion():void {
		outputText("\n\n<b>(Gained 1 diluted Arcane Regen Concotion!)</b>\n\n");
		inventory.takeItem(consumables.D_ARCON, curry(NonEquipmentMenu, 3));
	}
	public function AddArcaneRegenConcotion():void {
		outputText("\n\n<b>(Gained 1 Arcane Regen Concotion!)</b>\n\n");
		inventory.takeItem(consumables.AREGCON, curry(NonEquipmentMenu, 3));
	}
	public function AddSoulBlastManual():void {
		outputText("\n\n<b>(Gained 1 Soul Blast Manual!)</b>\n\n");
		inventory.takeItem(consumables.SOBLMAN, curry(NonEquipmentMenu, 1));
	}
	public function AddDisplacerFruit():void {
		outputText("\n\n<b>(Gained 1 Displacer Fruit!)</b>\n\n");
		inventory.takeItem(consumables.D_FRUIT, curry(NonEquipmentMenu, 1));
	}
	public function AddAbyssalSharkTooth():void {
		outputText("\n\n<b>(Gained 1 Abyssal Shark Tooth!)</b>\n\n");
		inventory.takeItem(consumables.ASTOOTH, curry(NonEquipmentMenu, 1));
	}
	public function AddAlicornium():void {
		outputText("\n\n<b>(Gained 1 Alicornium!)</b>\n\n");
		inventory.takeItem(consumables.ALICORN, curry(NonEquipmentMenu, 1));
	}
	public function AddMethir():void {
		outputText("\n\n<b>(Gained 1 Methir crystal!)</b>\n\n");
		inventory.takeItem(consumables.METHIRC, curry(NonEquipmentMenu, 1));
	}
	public function AddCurrentDebugItem():void {
		outputText("\n\n<b>(Gained 1 Testing gun!)</b>\n\n");
		inventory.takeItem(weaponsrange.M1CERBE, curry(NonEquipmentMenu, 1));
	}
	public function AddSkybornSeed():void {
		outputText("\n\n<b>(Gained 1 Skyborn Seed!)</b>\n\n");
		inventory.takeItem(consumables.SKYSEED, curry(NonEquipmentMenu, 2));
	}
	public function AddBehemothCum():void {
		outputText("\n\n<b>(Gained 1 vial of Behemoth Cum!)</b>\n\n");
		inventory.takeItem(consumables.BHMTCUM, curry(NonEquipmentMenu, 2));
	}
	public function AddEbonbloom():void {
		outputText("\n\n<b>(Gained 1 Ebonbloom!)</b>\n\n");
		inventory.takeItem(useables.EBONBLO, curry(MaterialMenu, 1));
	}
	public function AddWorldTreeBranch():void {
		outputText("\n\n<b>(Gained 1 Wold Tree branch!)</b>\n\n");
		inventory.takeItem(useables.WT_BRAN, curry(MaterialMenu, 1));
	}
	public function EarlyAscension():void {
		if (flags[kFLAGS.LETHICE_DEFEATED] == 1) {
			outputText("\n\n<b>You already used this cheat code!</b>");
		}
		else {
			flags[kFLAGS.LETHICE_DEFEATED] = 1;
			outputText("\n\n<b>You can Ascend now even if you not beaten Lethice yet!</b>");
		}
		doNext(StatsAscensionMenu2);
	}
	public function IncreaseAscensionCounter():void {
		outputText("\n\n<b>Your NG tier increased by 1!</b>");
		flags[kFLAGS.NEW_GAME_PLUS_LEVEL] += 1;
		doNext(StatsAscensionMenu2);
	}
	public function DecreaseAscensionCounter():void {
		outputText("\n\n<b>Your NG tier decreased by 1!</b>");
		flags[kFLAGS.NEW_GAME_PLUS_LEVEL] -= 1;
		doNext(StatsAscensionMenu2);
	}

	public function AddAscenionPerkPoints(incAmt:int):void{
		outputText("\n\n<b>You have gained " + incAmt + " Ascension perk points!</b>");
		player.ascensionPerkPoints += incAmt;
		doNext(StatsAscensionMenu2);
	}

	public function modStatFlags(flagName:String, changeAmt:int):void
	{
		switch(flagName)
		{
			case "timesTransformed":
					flags[kFLAGS.TIMES_TRANSFORMED] += changeAmt;
					break;
		}
		modFlagsMenu();
	}

	public function ModCoreStats(core:String, incAmt:int):void{
		switch(core){
			case "Str":
				player.strStat.core.value += incAmt;
				break;
			case "Tou":
				player.touStat.core.value += incAmt;
				break;
			case "Spe":
				player.speStat.core.value += incAmt;
				break;
			case "Int":
				player.intStat.core.value += incAmt;
				break;
			case "Wis":
				player.wisStat.core.value += incAmt;
				break;
			case "Lib":
				player.libStat.core.value += incAmt;
				break;
			case "Sen":
				dynStats("sen", incAmt);
				break;
			case "Cor":
				dynStats("cor", incAmt);
				break;
			case "Tone":
				player.tone += incAmt;
				break;
			case "Thickness":
				player.thickness += incAmt;
				break;
			case "Feminity":
				player.femininity += incAmt;
				break;
		}
		statScreenRefresh();
		StatsAscensionMenu();
	}

	public function perkPointsCheat(cAmt:int):void{
		clearOutput();
		player.perkPoints += cAmt;
		outputText("\n\n<b>You now have " + player.perkPoints + " perk points!</b>");
		doNext(PerksGemsEXP);
	}

	public function addGemsXP(type:String, cAmt:int):void{
		clearOutput();
		if (type == "Gems"){
			player.gems += cAmt;
			outputText("\n\n<b>You now have " + player.gems + " gems!</b>");
		}
		else if (type == "XP"){
			player.XP += cAmt;
			outputText("\n\n<b>You have gained " + cAmt + " XP!</b>");
		}
		doNext(PerksGemsEXP);
	}

	public function addsubLvl(type:String, cAmt:int):void{
		clearOutput();
		if (type == "Lvl"){
			CoC.instance.playerInfo.levelUpMultipleTimes(cAmt);
			outputText("\n\n<b>You now have " + player.level + " levels!</b>");
		}
		else if (type == "DLvl"){
			player.level -= cAmt;
			outputText("\n\n<b>You have lost " + cAmt + " levels and are now " + player.level + "!</b>");
		}
		doNext(LevelDeLevel);
	}

	public function Stage10to12SoulPerks():void {
		if (player.hasPerk(PerkLib.FleshBodyOverlordStage)) {
			player.removePerk(PerkLib.FleshBodyOverlordStage);
			outputText("\n\n<b>(Lost Perk: Flesh Body Overlord Stage!)</b>");
		}
		if (player.hasPerk(PerkLib.DaoistOverlordStage)) {
			player.removePerk(PerkLib.DaoistOverlordStage);
			outputText("\n\n<b>(Lost Perk: Daoist Overlord Stage!)</b>");
		}
		if (player.hasPerk(PerkLib.SoulKing)) {
			player.removePerk(PerkLib.SoulKing);
			outputText("\n\n<b>(Lost Perk: Soul King!)</b>");
		}
		if (player.hasPerk(PerkLib.SoulEmperor)) {
			player.removePerk(PerkLib.SoulEmperor);
			outputText("\n\n<b>(Lost Perk: Soul Emperor!)</b>");
		}
		if (player.hasPerk(PerkLib.SoulAncestor)) {
			player.removePerk(PerkLib.SoulAncestor);
			outputText("\n\n<b>(Lost Perk: Soul Ancestor!)</b>");
		}
		doNext(SoulforceCheats);
	}
	public function TribulationPerks():void {
		if (!player.hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) {
			player.createPerk(PerkLib.EclassHeavenTribulationSurvivor, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: E class Heaven Tribulation Survivor!)</b>");
		}
		doNext(SoulforceCheats);
	}
	public function AddWhiteBook():void {
		outputText("\n\n<b>(Gained 1 White Book!)</b>\n\n");
		inventory.takeItem(consumables.W__BOOK, curry(NonEquipmentMenu, 3));
	}
	public function AddBlackBook():void {
		outputText("\n\n<b>(Gained 1 Black Book!)</b>\n\n");
		inventory.takeItem(consumables.B__BOOK, curry(NonEquipmentMenu, 3));
	}
	public function AddGreyBook():void {
		outputText("\n\n<b>(Gained 1 Grey Book!)</b>\n\n");
		inventory.takeItem(consumables.G__BOOK, curry(NonEquipmentMenu, 3));
	}
	public function AddRedManuscript():void {
		outputText("\n\n<b>(Gained 1 Red Manuscript!)</b>\n\n");
		inventory.takeItem(consumables.RMANUSC, curry(NonEquipmentMenu, 3));
	}
	public function AddCrimsonJade():void {
		outputText("\n\n<b>(Gained 1 Crimson Jade!)</b>\n\n");
		inventory.takeItem(consumables.CRIMS_J, curry(NonEquipmentMenu, 3));
	}
	public function AddThePearls():void {
		outputText("\n\n<b>(Gained set of items to get all perks countering Elemental Conjuer perks negative effects on stat caps!)</b>\n\n");
		inventory.takeItem(consumables.E3PEARL, AddThePearls1);
	}
	public function AddThePearls1():void {
		outputText("\n\n");
		inventory.takeItem(consumables.E5PEARL, AddThePearls2);
	}
	public function AddThePearls2():void {
		outputText("\n\n");
		inventory.takeItem(consumables.E7PEARL, curry(NonEquipmentMenu, 3));
	}
	public function AddWood():void {
		outputText("\n\n<b>(Gained 100 Wood!)</b>");
		CampStatsAndResources.WoodResc += 100;
		statScreenRefresh();
		curry(MaterialMenu, 1);
	}
	public function AddNail():void {
		outputText("\n\n<b>(Gained 50 Nails!)</b>");
		CampStatsAndResources.NailsResc += 50;
		statScreenRefresh();
		curry(MaterialMenu, 1);
	}
	public function AddStone():void {
		outputText("\n\n<b>(Gained 100 Stones!)</b>");
		CampStatsAndResources.StonesResc += 100;
		statScreenRefresh();
		curry(MaterialMenu, 1);
	}
	public function fightMonster(monsterClass:Class, setupFunc:Function = null):void {
		clearOutput();
		var monster:Monster = new monsterClass();
		if (setupFunc != null) setupFunc(monster);
		outputText("Entering battle with " + monster.short + "! Enjoy ^^");
		startCombat(monster);
	}
	public function FightForPearl():void {
		clearOutput();
		outputText("Entering battle with Deep Sea Kraken Boss! Enjoy ^^");
		startCombat(new Kraken());
	}
	public function FightMarae():void {
		clearOutput();
		outputText("Entering battle with Marae Boss! Enjoy ^^");
		startCombat(new Marae());
	}
	public function FightPierce():void {
		clearOutput();
		outputText("Entering battle with Pierce! Enjoy ^^");
		startCombat(new Pierce());
	}
	public function FightIridesian():void {
		SceneLib.iridesianFollower.firstMeetingIridesian();
	}
	public function FightLilith():void {
		clearOutput();
		outputText("Entering battle with devilish cute goth girl! Enjoy ^^");
		startCombat(new Lilith());
	}
	public function FightCarrera():void {
		clearOutput();
		outputText("Entering battle with another succubus or maybe not your every succubus? Enjoy ^^");
		startCombat(new Carrera());
	}
	public function FightWaizAbi():void {
		clearOutput();
		outputText("So you cheating and skipping guardian angel gaze to beat poor Bimbo Monke? You're a Sexual Predator... <i>Start to dial local police number</i>");
		menu();
		addButton(1, "LvL18", FightWaizAbi18);
		addButton(2, "LvL24", FightWaizAbi24);
		addButton(3, "LvL30", FightWaizAbi30);
	}
	public function FightWaizAbi18():void {
		flags[kFLAGS.WAIZABI_LVL_UP] = 0;
		startCombat(new WaizAbi());
	}
	public function FightWaizAbi24():void {
		flags[kFLAGS.WAIZABI_LVL_UP] = 1;
		startCombat(new WaizAbi());
	}
	public function FightWaizAbi30():void {
		flags[kFLAGS.WAIZABI_LVL_UP] = 2;
		startCombat(new WaizAbi());
	}
	public function FightSandMother():void {
		clearOutput();
		outputText("Entering battle with Sand Mother! Enjoy ^^");
		startCombat(new SandMother(), true)
	}
	public function FightSonya():void {
		clearOutput();
		outputText("Entering battle with Sonya! Enjoy ^^");
		startCombat(new Sonya());
	}
	public function FightRyuBi():void {
		clearOutput();
		outputText("Entering battle with RyuBi! Enjoy ^^");
		startCombat(new RyuBiDragon());
	}
	public function FightRandomnMalikore():void {
		clearOutput();
		outputText("Entering battle with some malikore! Enjoy ^^");
		startCombat(new Malikore());
	}
	public function LvLUPAurora():void {
		outputText("\n\n<b>Aurora get stronger! (cheat stop working when she reach max possible lvl for now (atm it's lvl 73))</b>");
		if (flags[kFLAGS.AURORA_LVL] < 13) flags[kFLAGS.AURORA_LVL]++;
		enemiesMenu();
	}
	public function DELvLAurora():void {
		outputText("\n\n<b>Aurora get weaker! (cheat stop working when she reach lvl 1)</b>");
		if (flags[kFLAGS.AURORA_LVL] > 1) flags[kFLAGS.AURORA_LVL]--;
		enemiesMenu();
	}
	public function LvLUPEva():void {
		outputText("\n\n<b>Evangeline get stronger! (cheat stop working when she reach max possible lvl for now (atm it's lvl 42))</b>");
		if (flags[kFLAGS.EVANGELINE_LVL_UP] < 17) flags[kFLAGS.EVANGELINE_LVL_UP]++;
		enemiesMenu();
	}
	public function DELvLEva():void {
		outputText("\n\n<b>Evangeline get weaker! (cheat stop working when she reach lvl 12)</b>");
		if (flags[kFLAGS.EVANGELINE_LVL_UP] > 6) flags[kFLAGS.EVANGELINE_LVL_UP]--;
		enemiesMenu();
	}
	public function RevertCabinProgress():void {
		flags[kFLAGS.CAMP_CABIN_PROGRESS] = 2;
		doNext(SoulforceCheats);
	}
	public function GargoyleMenu():void {
		menu();
		addButton(0, "Human", BackToHumanForm).hint("Return to been fully human from gargoyle form test.");
		addButton(1, "Marble", MarbleGargoyleForm).hint("Turn into marble gargoyle form for tests.");
		addButton(2, "Alabaster", AlabasterGargoyleForm).hint("Turn into alabaster gargoyle form for tests.");
		addButton(14, "Back", SoulforceCheats);
	}
	public function BackToHumanForm():void {
		flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 0;
		player.skin.setBaseOnly({type:Skin.PLAIN});
		player.hairType = Hair.NORMAL;
		player.faceType = Face.HUMAN;
		player.tongue.type = Tongue.HUMAN;
		player.horns.type = Horns.NONE;
		player.beardLength = 0;
		player.beardStyle = 0;
		player.arms.type = Arms.HUMAN;
		player.tailType = Tail.NONE;
		player.tailRecharge = 0;
		player.wings.type = Wings.NONE;
		player.lowerBody = LowerBody.HUMAN;
		player.legCount = 2;
		player.eyes.type = Eyes.HUMAN;
		player.antennae.type = Antennae.NONE;
		player.ears.type = Ears.HUMAN;
		player.gills.type = Gills.NONE;
		player.rearBody.type = RearBody.NONE;
		player.skin.restore();
		if (player.hasPerk(PerkLib.GargoylePure)) player.removePerk(PerkLib.GargoylePure);
		if (player.hasPerk(PerkLib.GargoyleCorrupted)) player.removePerk(PerkLib.GargoyleCorrupted);
		player.removePerk(PerkLib.TransformationImmunity);
		clearOutput();
		outputText("You have become fully human again.");
		doNext(SoulforceCheats);
	}
	public function MarbleGargoyleForm():void {
		flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 1;
		player.skinColor                     = "light grey";
		player.hairColor                     = "light grey";
		clearOutput();
		outputText("You have become marble gargoyle. Now choose your wings shape.");
		doNext(WingShapeChoices);
	}
	public function AlabasterGargoyleForm():void {
		flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 2;
		player.skinColor                     = "quartz white";
		player.hairColor                     = "quartz white";
		clearOutput();
		outputText("You have become alabaster gargoyle. Now choose your wings shape.");
		doNext(WingShapeChoices);
	}
	public function WingShapeChoices():void {
		menu();
		addButton(0, "Bird", BirdWings);
		addButton(1, "Bat's", BatsWings);
	}
	public function BirdWings():void {
		flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 1;
		clearOutput();
		outputText("Now choose your arms shape.");
		doNext(ArmTypeChoices);
	}
	public function BatsWings():void {
		flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 2;
		clearOutput();
		outputText("Now choose your arms shape.");
		doNext(ArmTypeChoices);
	}
	public function ArmTypeChoices():void {
		menu();
		addButton(0, "Gargy", BirdArms);
		addButton(1, "Human", BatsWings);
	}
	public function BirdArms():void {
		player.arms.type = Arms.GARGOYLE;
		clearOutput();
		outputText("Now choose your tail shape.");
		doNext(TailTypeChoices);
	}
	public function BatsArms():void {
		player.arms.type = Arms.GARGOYLE_2;
		clearOutput();
		outputText("Now choose your tail shape.");
		doNext(TailTypeChoices);
	}
	public function TailTypeChoices():void {
		menu();
		addButton(0, "Whip-like", BirdTail);
		addButton(1, "Mace-like", BatsTail);
	}
	public function BirdTail():void {
		player.tailType = Tail.GARGOYLE;
		clearOutput();
		outputText("Now choose your legs shape.");
		doNext(LegsTypeChoices);
	}
	public function BatsTail():void {
		player.tailType = Tail.GARGOYLE_2;
		clearOutput();
		outputText("Now choose your legs shape.");
		doNext(LegsTypeChoices);
	}
	public function LegsTypeChoices():void {
		menu();
		addButton(0, "Gargy", BirdLegs);
		addButton(1, "Human", BatsLegs);
	}
	public function BirdLegs():void {
		player.lowerBody = LowerBody.GARGOYLE;
		clearOutput();
		outputText("Now choose your feeding style.");
		doNext(SustainTypeChoices);
	}
	public function BatsLegs():void {
		player.lowerBody = LowerBody.GARGOYLE_2;
		clearOutput();
		outputText("Now choose your feeding style.");
		doNext(SustainTypeChoices);
	}
	public function SustainTypeChoices():void {
		menu();
		addButton(0, "Soulforce", BirdSustain);
		addButton(1, "Milk & Cum", BatsSustain);
	}
	public function BirdSustain():void {
		player.createPerk(PerkLib.GargoylePure,0,0,0,0);
		player.createPerk(PerkLib.TransformationImmunity, 0, 0, 0, 0);
		clearOutput();
		outputText("Now your PC will became Prototype Gargoyle ^^");
		doNext(GargoyleBodyChanges);
	}
	public function BatsSustain():void {
		player.createPerk(PerkLib.GargoyleCorrupted,0,0,0,0);
		player.createPerk(PerkLib.TransformationImmunity,0,0,0,0);
		clearOutput();
		outputText("Now your PC will became Prototype Gargoyle ^^");
		doNext(GargoyleBodyChanges);
	}
	public function GargoyleBodyChanges():void {
		if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) {
			player.skinColor = "light grey";
			player.hairColor = "light grey";
		}
		if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) {
			player.skinColor = "quartz white";
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
		player.tailRecharge = 0;
		player.wings.type = Wings.GARGOYLE_LIKE_LARGE;
		player.legCount = 2;
		player.eyes.type = Eyes.GEMSTONES;
		player.antennae.type = Antennae.NONE;
		player.tongue.type = Tongue.DEMONIC;
		player.ears.type = Ears.ELFIN;
		player.gills.type = Gills.NONE;
		player.rearBody.type = RearBody.NONE;
		if (player.hasStatusEffect(StatusEffects.BlackNipples)) player.removeStatusEffect(StatusEffects.BlackNipples);
		//	if (player.averageNipplesPerBreast() > 1) player.breastRows[x].nipplesPerBreast = 1;
		if (player.hasStatusEffect(StatusEffects.Feeder)) {
			player.removeStatusEffect(StatusEffects.Feeder);
			player.removePerk(PerkLib.Feeder);
		}
		doNext(SoulforceCheats);
	}
	public function lilytest():void {
		SceneLib.lily.lilyEncounter();
	}
	}
}