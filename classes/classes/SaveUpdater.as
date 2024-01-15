package classes {
import classes.BodyParts.Arms;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.*;
import classes.Items.*;
import classes.Items.Alchemy.AlchemyLib;
import classes.Races.GargoyleRace;
import classes.Races.ImpRace;
import classes.Scenes.*;
import classes.Scenes.Camp.CampStatsAndResources;
import classes.Scenes.NPCs.*;
import classes.Scenes.Places.HeXinDao.AdventurerGuild;
import classes.Scenes.Places.HeXinDao.JourneyToTheEast;
import classes.Stats.Buff;
import classes.Stats.PrimaryStat;
import classes.Stats.BuffableStat;

use namespace CoC;

public class SaveUpdater extends NPCAwareContent {

	public function SaveUpdater() {}

	public function updateAchievements():void {
		//Dungeon counter
		var dungeonsList:Array = [
			SceneLib.dungeons.checkFactoryClear(),
			SceneLib.dungeons.checkDeepCaveClear(),
			SceneLib.dungeons.checkDemonLaboratoryClear(),
			SceneLib.dungeons.checkLethiceStrongholdClear(),
			SceneLib.dungeons.checkSandCaveClear(),
			SceneLib.dungeons.checkPhoenixTowerClear(),
			SceneLib.dungeons.checkBeeHiveClear(),
			SceneLib.dungeons.checkHiddenCaveHiddenStageClear(),
			SceneLib.dungeons.checkRiverDungeon1stFloorClear(),
			SceneLib.dungeons.checkRiverDungeon2ndFloorClear(),
			SceneLib.dungeons.checkRiverDungeon3rdFloorClear(),
			SceneLib.dungeons.checkDenOfDesireClear(),
			SceneLib.dungeons.checkEbonLabyrinthClear(),
		];
		var dungeonsCleared:int = 0;
		for each (var dung:Boolean in dungeonsList)
			if (dung) ++dungeonsCleared;
		//Kill count
		var totalKillCount:int = 0;
		if (flags[kFLAGS.IMPS_KILLED] > 0) totalKillCount += flags[kFLAGS.IMPS_KILLED];
		if (flags[kFLAGS.GOBLINS_KILLED] > 0) totalKillCount += flags[kFLAGS.GOBLINS_KILLED];
		if (flags[kFLAGS.HELLHOUNDS_KILLED] > 0) totalKillCount += flags[kFLAGS.HELLHOUNDS_KILLED];
		if (flags[kFLAGS.MINOTAURS_KILLED] > 0) totalKillCount += flags[kFLAGS.MINOTAURS_KILLED];
		if (flags[kFLAGS.TRUE_DEMONS_KILLED] > 0) totalKillCount += flags[kFLAGS.TRUE_DEMONS_KILLED];
		//Check how many NPCs got bad-ended.
		var badEndList:Array = [
			flags[kFLAGS.KELT_KILLED] > 0 || flags[kFLAGS.KELT_BREAK_LEVEL] >= 4,
			flags[kFLAGS.JOJO_DEAD_OR_GONE] == 2,
			flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0,
			flags[kFLAGS.FUCK_FLOWER_KILLED] > 0,
			flags[kFLAGS.CHI_CHI_FOLLOWER] == 2 || flags[kFLAGS.CHI_CHI_FOLLOWER] == 5,
			flags[kFLAGS.PATCHOULI_FOLLOWER] == 3,
			flags[kFLAGS.D1_OMNIBUS_KILLED] > 0,
			flags[kFLAGS.ZETAZ_DEFEATED_AND_KILLED] > 0,
			flags[kFLAGS.HARPY_QUEEN_EXECUTED] > 0,
			flags[kFLAGS.D3_GARDENER_DEFEATED] == 3,
			flags[kFLAGS.D3_CENTAUR_DEFEATED] == 1,
			flags[kFLAGS.D3_MECHANIC_FIGHT_RESULT] == 1,
			flags[kFLAGS.DRIDERINCUBUS_KILLED] > 0,
			flags[kFLAGS.MINOTAURKING_KILLED] > 0,
			flags[kFLAGS.LETHICE_KILLED] > 0,
		];
		var NPCsBadEnds:int = 0;
		for each (var bad:Boolean in badEndList)
			if (bad) ++NPCsBadEnds;
		//Aether twins stuff
		var EvolvingItems:int = 0;
		if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] > 0) EvolvingItems++;
		if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] > 0) EvolvingItems++;
		var EvolutionsCount:int = 0;
		if (AetherTwinsFollowers.AetherTwinsTalkMenu > 0) EvolutionsCount++;

		var dedickList:Array = [
			flags[kFLAGS.IZMA_NO_COCK] > 0,
			flags[kFLAGS.CERAPH_HIDING_DICK] > 0,
			flags[kFLAGS.RUBI_ADMITTED_GENDER] > 0 && flags[kFLAGS.RUBI_COCK_SIZE] <= 0,
			flags[kFLAGS.BENOIT_STATUS] == 1 || flags[kFLAGS.BENOIT_STATUS] == 2,
			flags[kFLAGS.ARIAN_HEALTH] > 0 && flags[kFLAGS.ARIAN_COCK_SIZE] <= 0,
			flags[kFLAGS.KATHERINE_UNLOCKED] > 0 && flags[kFLAGS.KATHERINE_DICK_COUNT] <= 0,
			flags[kFLAGS.MET_KITSUNES] > 0 && flags[kFLAGS.REDHEAD_IS_FUTA] == 0,
			flags[kFLAGS.KELT_BREAK_LEVEL] == 4,
		];
		var NPCsDedicked:int = 0; //Check how many NPCs are dedicked.
		for each (var ded:Boolean in dedickList)
			if (ded) ++NPCsDedicked;

		//achievement list to make everything simpler
		var achievementList:Array = [
			//Story
			["Newcomer", kACHIEVEMENTS.STORY_NEWCOMER, true],
			["Marae's Savior", kACHIEVEMENTS.STORY_MARAE_SAVIOR, flags[kFLAGS.MARAE_QUEST_COMPLETE] > 0],
			["Revenge at Last", kACHIEVEMENTS.STORY_ZETAZ_REVENGE, player.hasKeyItem("Zetaz's Map") >= 0],
			["Chimera Squad", kACHIEVEMENTS.STORY_CHIMERA_SQUAD, player.hasKeyItem("Map to the Lethice’s Fortress") >= 0],
			["Demon Slayer", kACHIEVEMENTS.STORY_FINALBOSS, flags[kFLAGS.LETHICE_DEFEATED] > 0],
			//Zones
			["Explorer", kACHIEVEMENTS.ZONE_EXPLORER,
				SceneLib.forest.timesExploredOuter() > 0
				&& SceneLib.forest.timesExploredInner() > 0
				&& SceneLib.forest.timesExploredDeepwoods() > 0
				&& SceneLib.lake.timesExplored() > 0
				&& SceneLib.desert.timesExploredOuter() > 0
				&& SceneLib.mountain.timesExploredMid() > 0
				&& SceneLib.plains.timesExplored() > 0
				&& SceneLib.swamp.timesExplored() > 0
				&& SceneLib.blightridge.timesExplored() > 0
				&& SceneLib.battlefiledouter.timesExplored() > 0
				&& SceneLib.caves.timesExplored() > 0
				&& SceneLib.highMountains.timesExplored() > 0
				&& SceneLib.bog.timesExplored() > 0
				&& SceneLib.tundra.timesExplored() > 0
				&& SceneLib.glacialRift.timesExplored() > 0
				&& SceneLib.ashlands.timesExplored() > 0
				&& SceneLib.volcanicCrag.timesExplored() > 0],
			["Sightseer", kACHIEVEMENTS.ZONE_SIGHTSEER, camp.placesCount() >= 10],
			["Where am I?", kACHIEVEMENTS.ZONE_WHERE_AM_I, SceneLib.exploration.counters.explore >= 1],
			["Forest Ranger", kACHIEVEMENTS.ZONE_FOREST_RANGER, SceneLib.forest.timesExploredOuter()+SceneLib.forest.timesExploredInner() >= 100],
			["We Need to Go Deeper", kACHIEVEMENTS.ZONE_WE_NEED_TO_GO_DEEPER, SceneLib.forest.timesExploredDeepwoods() >= 100],
			["Vacationer", kACHIEVEMENTS.ZONE_VACATIONER, SceneLib.lake.timesExplored() >= 100],
			["Dehydrated", kACHIEVEMENTS.ZONE_DEHYDRATED, SceneLib.desert.timesExploredOuter() >= 100],
			["Bedouin", kACHIEVEMENTS.ZONE_BEDOUIN, SceneLib.desert.timesExploredInner() >= 100],
			["Rookie", kACHIEVEMENTS.ZONE_ROOKIE, SceneLib.battlefiledboundary.timesExplored() >= 100],
			["Friggin' Golems!", kACHIEVEMENTS.ZONE_FRIGGIN_GOLEMS, SceneLib.battlefiledboundary.timesExplored() >= 100],
			["Hiking", kACHIEVEMENTS.ZONE_HIKING, SceneLib.mountain.timesExploredHills() >= 100],
			["Trekking", kACHIEVEMENTS.ZONE_TREKKING, SceneLib.mountain.timesExploredLow() >= 100],
			["Mountaineer", kACHIEVEMENTS.ZONE_MOUNTAINEER, SceneLib.mountain.timesExploredMid() >= 100],
			["Light-headed", kACHIEVEMENTS.ZONE_LIGHT_HEADED, SceneLib.highMountains.timesExplored() >= 100],
			["Rolling Hills", kACHIEVEMENTS.ZONE_ROLLING_HILLS, SceneLib.plains.timesExplored() >= 100],
			["Wet All Over", kACHIEVEMENTS.ZONE_WET_ALL_OVER, SceneLib.swamp.timesExplored() >= 100],
			["All murky", kACHIEVEMENTS.ZONE_ALL_MURKY, SceneLib.bog.timesExplored() >= 100],
			["Tainted", kACHIEVEMENTS.ZONE_TAINTED, SceneLib.blightridge.timesExplored() >= 100],
			["Defiled", kACHIEVEMENTS.ZONE_DEFILED, SceneLib.defiledravine.timesExplored() >= 100],
			["Sunburned", kACHIEVEMENTS.ZONE_SUNBURNED, SceneLib.beach.timesExplored() >= 100],
			["Sea-Legs", kACHIEVEMENTS.ZONE_SAILOR, SceneLib.ocean.timesExplored() >= 100],
			["Diver", kACHIEVEMENTS.ZONE_DIVER, SceneLib.exploration.counters.deepSea >= 100],
			["Caveman", kACHIEVEMENTS.ZONE_CAVEMAN, SceneLib.caves.timesExplored() >= 100],
			["Sub-Zero", kACHIEVEMENTS.ZONE_SUB_ZERO, SceneLib.tundra.timesExplored() >= 100],
			["Frozen", kACHIEVEMENTS.ZONE_FROZEN, SceneLib.glacialRift.timesExplored() >= 100],
			["Ashes to ashes, dust to dust", kACHIEVEMENTS.ZONE_ASHES_TO_ASHES_DUST_TO_DUST, SceneLib.ashlands.timesExplored() >= 100],
			["Roasted", kACHIEVEMENTS.ZONE_ROASTED, SceneLib.volcanicCrag.timesExplored() >= 100],
			["Sailor", kACHIEVEMENTS.ZONE_SEA_LEGS, SceneLib.boat.timesExplored() >= 15],
			["Farmer", kACHIEVEMENTS.ZONE_FARMER, player.statusEffectv1(StatusEffects.MetWhitney) >= 30],
			["Archaeologist", kACHIEVEMENTS.ZONE_ARCHAEOLOGIST, flags[kFLAGS.AMILY_VILLAGE_EXPLORED] >= 15],
			//Levels
			["Level up!", kACHIEVEMENTS.LEVEL_LEVEL_UP, player.level >= 1],
			["Novice", kACHIEVEMENTS.LEVEL_NOVICE, player.level >= 5],
			["Apprentice", kACHIEVEMENTS.LEVEL_APPRENTICE, player.level >= 10],
			["Journeyman", kACHIEVEMENTS.LEVEL_JOURNEYMAN, player.level >= 15],
			["Expert", kACHIEVEMENTS.LEVEL_EXPERT, player.level >= 20],
			["Master", kACHIEVEMENTS.LEVEL_MASTER, player.level >= 30],
			["Grandmaster", kACHIEVEMENTS.LEVEL_GRANDMASTER, player.level >= 45],
			["Illuistrous", kACHIEVEMENTS.LEVEL_ILLUSTRIOUS, player.level >= 60],
			["Overlord", kACHIEVEMENTS.LEVEL_OVERLORD, player.level >= 75],
			["Sovereign", kACHIEVEMENTS.LEVEL_SOVEREIGN, player.level >= 90],
			["Are you a god?", kACHIEVEMENTS.LEVEL_ARE_YOU_A_GOD, player.level >= 100],
			["Newb God(ess)", kACHIEVEMENTS.LEVEL_NEWB_GOD_ESS, player.level >= 120],
			["Lowest-tier God(ess)", kACHIEVEMENTS.LEVEL_MID_TIER_GOD_ESS, player.level >= 150],
			//["Low-tier God(ess)", kACHIEVEMENTS.LEVEL_MID_TIER_GOD_ESS, player.level >= ?180?],
			//["-tier God(ess)", kACHIEVEMENTS.LEVEL_MID_TIER_GOD_ESS, player.level >= ?210?],
			//Population
			["My First Companion", kACHIEVEMENTS.POPULATION_FIRST, camp.getCampPopulation() >= 2],
			["Hamlet", kACHIEVEMENTS.POPULATION_HAMLET, camp.getCampPopulation() >= 5],
			["Village", kACHIEVEMENTS.POPULATION_VILLAGE, camp.getCampPopulation() >= 10],
			["Town", kACHIEVEMENTS.POPULATION_TOWN, camp.getCampPopulation() >= 25],
			["City", kACHIEVEMENTS.POPULATION_CITY, camp.getCampPopulation() >= 100],
			["Metropolis", kACHIEVEMENTS.POPULATION_METROPOLIS, camp.getCampPopulation() >= 250],
			["Megalopolis", kACHIEVEMENTS.POPULATION_MEGALOPOLIS, camp.getCampPopulation() >= 500],
			["City-State", kACHIEVEMENTS.POPULATION_CITY_STATE, camp.getCampPopulation() >= 1000],
			["Kingdom", kACHIEVEMENTS.POPULATION_KINGDOM, camp.getCampPopulation() >= 2500],
			["Empire", kACHIEVEMENTS.POPULATION_EMPIRE, camp.getCampPopulation() >= 5000],
			["Large Empire", kACHIEVEMENTS.POPULATION_LARGE_EMPIRE, camp.getCampPopulation() >= 10000],
			["My First Underground Companion", kACHIEVEMENTS.UNDERGROUND_POPULATION_FIRST, camp.getCampUndergroundPopulation() >= 1],
			["Underground Hamlet", kACHIEVEMENTS.UNDERGROUND_POPULATION_HAMLET, camp.getCampUndergroundPopulation() >= 20],
			["Underground Village", kACHIEVEMENTS.UNDERGROUND_POPULATION_VILLAGE, camp.getCampUndergroundPopulation() >= 50],
			["Underground Town", kACHIEVEMENTS.UNDERGROUND_POPULATION_TOWN, camp.getCampUndergroundPopulation() >= 100],
			["Underground City", kACHIEVEMENTS.UNDERGROUND_POPULATION_CITY, camp.getCampUndergroundPopulation() >= 250],
			["Underground Metropolis", kACHIEVEMENTS.UNDERGROUND_POPULATION_METROPOLIS, camp.getCampUndergroundPopulation() >= 500],
			["Underground Megalopolis", kACHIEVEMENTS.UNDERGROUND_POPULATION_MEGALOPOLIS, camp.getCampUndergroundPopulation() >= 1000],
			["Underground Large Megalopolis", kACHIEVEMENTS.UNDERGROUND_POPULATION_LARGE_MEGALOPOLIS, camp.getCampUndergroundPopulation() >= 2500],
			["Underground City-State", kACHIEVEMENTS.UNDERGROUND_POPULATION_CITY_STATE, camp.getCampUndergroundPopulation() >= 5000],
			["Underground Kingdom", kACHIEVEMENTS.UNDERGROUND_POPULATION_KINGDOM, camp.getCampUndergroundPopulation() >= 10000],
			//Time
			["It's been a month", kACHIEVEMENTS.TIME_MONTH, model.time.days >= 30],
			["Quarter", kACHIEVEMENTS.TIME_QUARTER, model.time.days >= 90],
			["Half-year", kACHIEVEMENTS.TIME_HALF_YEAR, model.time.days >= 180],
			["Annual", kACHIEVEMENTS.TIME_ANNUAL, model.time.days >= 365],
			["Biennial", kACHIEVEMENTS.TIME_BIENNIAL, model.time.days >= 730],
			["Triennial", kACHIEVEMENTS.TIME_TRIENNIAL, model.time.days >= 1095],
			["In for the long haul", kACHIEVEMENTS.TIME_LONG_HAUL, model.time.days >= 1825],
			["Decade", kACHIEVEMENTS.TIME_DECADE, model.time.days >= 3650],
			["Century", kACHIEVEMENTS.TIME_CENTURY, model.time.days >= 36500],
			//Dungeon
			["Shut Down Everything", kACHIEVEMENTS.DUNGEON_SHUT_DOWN_EVERYTHING, SceneLib.dungeons.checkFactoryClear()],
			["You're in Deep", kACHIEVEMENTS.DUNGEON_YOURE_IN_DEEP, SceneLib.dungeons.checkDeepCaveClear()],
			["End of Reign", kACHIEVEMENTS.DUNGEON_END_OF_REIGN, SceneLib.dungeons.checkLethiceStrongholdClear()],
			["Friend of the Sand Witches", kACHIEVEMENTS.DUNGEON_SAND_WITCH_FRIEND, SceneLib.dungeons.checkSandCaveClear()],
			["Fall of the Phoenix", kACHIEVEMENTS.DUNGEON_PHOENIX_FALL, SceneLib.dungeons.checkPhoenixTowerClear()],
			["Extremely Chaste Delver", kACHIEVEMENTS.DUNGEON_EXTREMELY_CHASTE_DELVER, SceneLib.dungeons.checkPhoenixTowerClear() && flags[kFLAGS.TIMES_ORGASMED] <= 0],
			["Victory, Sweet like honey", kACHIEVEMENTS.DUNGEON_VICTORY_SWEET_LIKE_HONEY, SceneLib.dungeons.checkBeeHiveClear()],
			["Tiger stalking the Dragon", kACHIEVEMENTS.DUNGEON_TIGER_STALKING_THE_DRAGON, SceneLib.dungeons.checkHiddenCaveHiddenStageClear()],
			["Mirror Flower, Water Moon", kACHIEVEMENTS.DUNGEON_MIRROR_FLOWER_WATER_MOON, SceneLib.dungeons.checkRiverDungeon1stFloorClear()],
			["Dungeon Seeker (1st layer)", kACHIEVEMENTS.DUNGEON_DUNGEON_SEEKER_1ST_LAYER, SceneLib.dungeons.checkRiverDungeon1stFloorClear()],
			["Slain the Heroslayer", kACHIEVEMENTS.DUNGEON_SLAIN_THE_HEROSLAYER, SceneLib.dungeons.checkDenOfDesireClear()],
			//bee hive clear
			["Delver", kACHIEVEMENTS.DUNGEON_DELVER, dungeonsCleared >= 1],
			["Delver Apprentice", kACHIEVEMENTS.DUNGEON_DELVER_APPRENTICE, dungeonsCleared >= 2],
			["Delver Expert", kACHIEVEMENTS.DUNGEON_DELVER_MASTER, dungeonsCleared >= 4],
			["Delver Master", kACHIEVEMENTS.DUNGEON_DELVER_EXPERT, dungeonsCleared >= 8],
			["Delver Grand Master", kACHIEVEMENTS.DUNGEON_DELVER_GRAND_MASTER, dungeonsCleared >= 16],//obecnie max 10

			["Dungeon Seeker (2nd layer)", kACHIEVEMENTS.DUNGEON_DUNGEON_SEEKER_2ND_LAYER, SceneLib.dungeons.checkRiverDungeon2ndFloorClear()],
			["Dungeon Seeker (3rd layer)", kACHIEVEMENTS.DUNGEON_DUNGEON_SEEKER_3RD_LAYER, SceneLib.dungeons.checkRiverDungeon3rdFloorClear()],

			//Fashion
			["Wannabe Wizard", kACHIEVEMENTS.FASHION_WANNABE_WIZARD, player.armor == armors.W_ROBES && player.weapon == weapons.W_STAFF],
			["Cosplayer (Beginner)", kACHIEVEMENTS.FASHION_COSPLAYER, player.previouslyWornClothes.length >= 10],
			["Cosplayer (Amateour)", kACHIEVEMENTS.FASHION_COSPLAYER_1, player.previouslyWornClothes.length >= 30],
			["Cosplayer (Recognizable)", kACHIEVEMENTS.FASHION_COSPLAYER_2, player.previouslyWornClothes.length >= 60],
			["Cosplayer (Seasonal)", kACHIEVEMENTS.FASHION_COSPLAYER_3, player.previouslyWornClothes.length >= 100],
			["Cosplayer (Proffesional)", kACHIEVEMENTS.FASHION_COSPLAYER_4, player.previouslyWornClothes.length >= 150],
			//["Jessica Nigri apprentice", kACHIEVEMENTS.FASHION_COSPLAYER_5, player.previouslyWornClothes.length >= 300],
			//["Yaya Han apprentice", kACHIEVEMENTS.FASHION_COSPLAYER_6, player.previouslyWornClothes.length >= 600],
			["Dominatrix", kACHIEVEMENTS.FASHION_DOMINATRIX, (player.armor == armors.RBBRCLT || player.armor == armors.BONSTRP || player.armor == armors.NURSECL) && (player.weapon == weapons.RIDINGC || player.weapon == weapons.WHIP || player.weapon == weapons.SUCWHIP || player.weapon == weapons.L_WHIP || player.weapon == weapons.PSWHIP || player.weapon == weapons.PWHIP || player.weapon == weapons.BFWHIP || player.weapon == weapons.DBFWHIP || player.weapon == weapons.NTWHIP || player.weapon == weapons.CNTWHIP)],
			["Going Commando", kACHIEVEMENTS.FASHION_GOING_COMMANDO, !player.armor.isNothing && player.lowerGarment.isNothing && player.upperGarment.isNothing],
			["Hellblazer", kACHIEVEMENTS.FASHION_HELLBLAZER, player.headJewelry == headjewelries.FIRECRO && player.necklace == necklaces.FIRENEC && player.countRings(jewelries.FIRERNG) > 0],
			["Less than Zero", kACHIEVEMENTS.FASHION_LESS_THAN_ZERO, player.headJewelry == headjewelries.ICECROW && player.necklace == necklaces.ICENECK && player.countRings(jewelries.ICERNG) > 0],
			["Thunderstuck", kACHIEVEMENTS.FASHION_THUNDERSTUCK, player.headJewelry == headjewelries.LIGHCRO && player.necklace == necklaces.LIGHNEC && player.countRings(jewelries.LIGHRNG) > 0],
			["Darkness Within", kACHIEVEMENTS.FASHION_DARKNESS_WITHIN, player.headJewelry == headjewelries.DARKCRO && player.necklace == necklaces.DARKNEC && player.countRings(jewelries.DARKRNG) > 0],
			["Poison Ivy", kACHIEVEMENTS.FASHION_POISON_IVY, player.headJewelry == headjewelries.POISCRO && player.necklace == necklaces.POISNEC && player.countRings(jewelries.POISRNG) > 0],
			["Playboy Bunny", kACHIEVEMENTS.FASHION_POLAYBOY_BUNNY, player.headJewelry == headjewelries.LUSTCRO && player.necklace == necklaces.LUSTNEC && player.countRings(jewelries.LUSTRNG) > 0],
			["Throne of Intelligence", kACHIEVEMENTS.FASHION_THRONE_OF_INTELLIGENCE, player.headJewelry == headjewelries.CROWINT && player.necklace == necklaces.NECKINT && player.countRings(jewelries.RINGINT) > 0],
			["Throne of Libido", kACHIEVEMENTS.FASHION_THRONE_OF_LIBIDO, player.headJewelry == headjewelries.CROWLIB && player.necklace == necklaces.NECKLIB && player.countRings(jewelries.RINGLIB) > 0],
			["Throne of Sensitivity", kACHIEVEMENTS.FASHION_THRONE_OF_SENSITIVITY, player.headJewelry == headjewelries.CROWSEN && player.necklace == necklaces.NECKSEN && player.countRings(jewelries.RINGSEN) > 0],
			["Throne of Speed", kACHIEVEMENTS.FASHION_THRONE_OF_SPEED, player.headJewelry == headjewelries.CROWSPE && player.necklace == necklaces.NECKSPE && player.countRings(jewelries.RINGSPE) > 0],
			["Throne of Strength", kACHIEVEMENTS.FASHION_THRONE_OF_STRENGTH, player.headJewelry == headjewelries.CROWSTR && player.necklace == necklaces.NECKSTR && player.countRings(jewelries.RINGSTR) > 0],
			["Throne of Toughness", kACHIEVEMENTS.FASHION_THRONE_OF_TOUGHNESS, player.headJewelry == headjewelries.CROWTOU && player.necklace == necklaces.NECKTOU && player.countRings(jewelries.RINGTOU) > 0],
			["Throne of Wisdom", kACHIEVEMENTS.FASHION_THRONE_OF_WISDOM, player.headJewelry == headjewelries.CROWWIS && player.necklace == necklaces.NECKWIS && player.countRings(jewelries.RINGWIS) > 0],
			["Suit Up!", kACHIEVEMENTS.FASHION_SUIT_UP, player.isInGoblinMech() || player.isInNonGoblinMech()],
			["Rollin' Rollin'", kACHIEVEMENTS.FASHION_ROLLIN_ROLLIN, player.vehicles == vehicles.GOBMPRI],
			["Asura's Wrath", kACHIEVEMENTS.FASHION_ASURAS_WRATH, player.vehicles == vehicles.GS_MECH],
			["Howl of the Banshee", kACHIEVEMENTS.FASHION_HOWL_OF_THE_BANSHEE, player.vehicles == vehicles.HB_MECH],
			["Bling Bling", kACHIEVEMENTS.FASHION_BLING_BLING, player.jewelry1.value >= 1000],
			["Ka-Ching!", kACHIEVEMENTS.FASHION_KA_CHING, player.necklace.value >= 5000],
			["Royalty", kACHIEVEMENTS.FASHION_ROYALTY, player.headJewelry.value >= 4000],
			["Subject Delta", kACHIEVEMENTS.FASHION_SUBJECT_DELTA, player.armor == armors.G_DIVES && player.weapon == weapons.SDRILL && player.shield.isNothing && player.hasPerk(PerkLib.PrestigeJobSpellKnight)],
			["Bushido - the way of the warrior", kACHIEVEMENTS.FASHION_BUSHIDO_THE_WAY_OF_THE_WARRIOR, player.armor == armors.SAMUARM && player.weapon == weapons.DAISHO && player.headJewelry == headjewelries.KABUMEMP],
			//Wealth
			["Rich", kACHIEVEMENTS.WEALTH_RICH, player.gems >= 1000],
			["Hoarder", kACHIEVEMENTS.WEALTH_HOARDER, player.gems >= 10000],
			["Gem Vault", kACHIEVEMENTS.WEALTH_GEM_VAULT, player.gems >= 100000],
			["Millionaire", kACHIEVEMENTS.WEALTH_MILLIONAIRE, player.gems >= 1000000],
			["Poor Daoist", kACHIEVEMENTS.WEALTH_POOR_DAOIST, flags[kFLAGS.SPIRIT_STONES] >= 200],
			["Sect's Conclave Student", kACHIEVEMENTS.WEALTH_SECTS_CONCLAVE_STUDENT, flags[kFLAGS.SPIRIT_STONES] >= 2000],
			["Sect's Head Elder", kACHIEVEMENTS.WEALTH_SECTS_HEAD_ELDER, flags[kFLAGS.SPIRIT_STONES] >= 20000],
			["Sect's Patriarch", kACHIEVEMENTS.WEALTH_SECTS_PATRIARCH, flags[kFLAGS.SPIRIT_STONES] >= 500000],
			["Meng Hao", kACHIEVEMENTS.WEALTH_MENG_HAO, flags[kFLAGS.SPIRIT_STONES] >= 20000000],
			//Combat
			["Gandalf", kACHIEVEMENTS.COMBAT_GANDALF, player.hasStatusEffect(StatusEffects.KnowsCharge) && player.hasStatusEffect(StatusEffects.KnowsChargeA) && player.hasStatusEffect(StatusEffects.KnowsBlind) && player.hasStatusEffect(StatusEffects.KnowsHeal) && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && player.hasStatusEffect(StatusEffects.KnowsBlizzard) && player.hasStatusEffect(StatusEffects.KnowsLightningBolt) && player.hasStatusEffect(StatusEffects.KnowsChainLighting) && player.hasStatusEffect(StatusEffects.KnowsPyreBurst)],
			["Sauron", kACHIEVEMENTS.COMBAT_SAURON, player.hasStatusEffect(StatusEffects.KnowsArouse) && player.hasStatusEffect(StatusEffects.KnowsRegenerate) && player.hasStatusEffect(StatusEffects.KnowsMight) && player.hasStatusEffect(StatusEffects.KnowsBlink) && player.hasStatusEffect(StatusEffects.KnowsIceSpike) && player.hasStatusEffect(StatusEffects.KnowsDarknessShard) && player.hasStatusEffect(StatusEffects.KnowsDuskWave) && player.hasStatusEffect(StatusEffects.KnowsArcticGale)],
			["Merlin", kACHIEVEMENTS.COMBAT_WIZARD, player.hasStatusEffect(StatusEffects.KnowsCharge) && player.hasStatusEffect(StatusEffects.KnowsChargeA) && player.hasStatusEffect(StatusEffects.KnowsBlind) && player.hasStatusEffect(StatusEffects.KnowsHeal) && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && player.hasStatusEffect(StatusEffects.KnowsBlizzard) && player.hasStatusEffect(StatusEffects.KnowsArouse) && player.hasStatusEffect(StatusEffects.KnowsRegenerate) && player.hasStatusEffect(StatusEffects.KnowsMight) && player.hasStatusEffect(StatusEffects.KnowsBlink) && player.hasStatusEffect(StatusEffects.KnowsIceSpike) && player.hasStatusEffect(StatusEffects.KnowsLightningBolt) && player.hasStatusEffect(StatusEffects.KnowsDarknessShard) && player.hasStatusEffect(StatusEffects.KnowsChainLighting) && player.hasStatusEffect(StatusEffects.KnowsPyreBurst) && player.hasStatusEffect(StatusEffects.KnowsDuskWave) && player.hasStatusEffect(StatusEffects.KnowsArcticGale)],
			["Are you a Wizard?", kACHIEVEMENTS.COMBAT_ARE_YOU_A_WIZARD, flags[kFLAGS.SPELLS_CAST] >= 1],
			//Realistic
			["Fasting", kACHIEVEMENTS.REALISTIC_FASTING, flags[kFLAGS.ACHIEVEMENT_PROGRESS_FASTING] >= 168 && flags[kFLAGS.HUNGER_ENABLED] > 0],
			["Lent", kACHIEVEMENTS.REALISTIC_LENT, flags[kFLAGS.ACHIEVEMENT_PROGRESS_FASTING] >= 960 && flags[kFLAGS.HUNGER_ENABLED] > 0],
			["One more dish please", kACHIEVEMENTS.REALISTIC_ONE_MORE_DISH_PLEASE, player.maxHunger() > 100],
			["You not gonna eat those ribs?", kACHIEVEMENTS.REALISTIC_YOU_NOT_GONNA_EAT_THOSE_RIBS, player.maxHunger() > 250],
			["Dinner for Four", kACHIEVEMENTS.REALISTIC_DINNER_FOR_FOUR, player.maxHunger() > 500],
			["Dinner for Obelix", kACHIEVEMENTS.REALISTIC_DINNER_FOR_OBELIX, player.maxHunger() > 1000],
			//Holiday
			["The Lovable Snowman", kACHIEVEMENTS.HOLIDAY_CHRISTMAS_III, flags[kFLAGS.NIEVE_STAGE] == 5],
			//General
			["Portal Defender", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER, flags[kFLAGS.DEMONS_DEFEATED] >= 20 && model.time.days >= 10],
			["Portal Defender 2: Defend Harder", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_2_DEFEND_HARDER, flags[kFLAGS.DEMONS_DEFEATED] >= 40 && model.time.days >= 25],
			["Portal Defender 3D: The Longest Night", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_3D_THE_LONGEST_NIGHT, flags[kFLAGS.DEMONS_DEFEATED] >= 100 && model.time.days >= 45],
			["Portal Defender 4.0: Die Hard", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_4_0_DIE_HARD, flags[kFLAGS.DEMONS_DEFEATED] >= 300 && model.time.days >= 70],
			["Portal Defender 5: A Good Day to Die Hard", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_5_A_GOOD_DAY_TO_DIE_HARD, flags[kFLAGS.DEMONS_DEFEATED] >= 1050 && model.time.days >= 100],
			["Just to Spite You", kACHIEVEMENTS.GENERAL_JUST_TO_SPITE_YOU, flags[kFLAGS.IMPS_KILLED] >= 25],
			["Just to Spite You 2: Spite Harder", kACHIEVEMENTS.GENERAL_JUST_TO_SPITE_YOU_2_SPITE_HARDER, flags[kFLAGS.IMPS_KILLED] >= 125],
			["Just to Spite You 3: I'm Back", kACHIEVEMENTS.GENERAL_JUST_TO_SPITE_YOU_3_IM_BACK, flags[kFLAGS.IMPS_KILLED] >= 625],
			["Goblin Slayer", kACHIEVEMENTS.GENERAL_GOBLIN_SLAYER, flags[kFLAGS.GOBLINS_KILLED] >= 25],
			["Goblin Slayer 2: Slay Harder", kACHIEVEMENTS.GENERAL_GOBLIN_SLAYER_2_SLAY_HARDER, flags[kFLAGS.GOBLINS_KILLED] >= 125],
			["Goblin Slayer 3: I'm Back", kACHIEVEMENTS.GENERAL_GOBLIN_SLAYER_3_IM_BACK, flags[kFLAGS.GOBLINS_KILLED] >= 625],
			["Play dead Fido", kACHIEVEMENTS.GENERAL_PLAY_DEAD_FIDO, flags[kFLAGS.HELLHOUNDS_KILLED] >= 10],
			["Play dead Fido 2: Play Harder", kACHIEVEMENTS.GENERAL_PLAY_DEAD_FIDO_2_PLAY_HARDER, flags[kFLAGS.HELLHOUNDS_KILLED] >= 50],
			["Play dead Fido 3: I'm Back", kACHIEVEMENTS.GENERAL_PLAY_DEAD_FIDO_3_IM_BACK, flags[kFLAGS.HELLHOUNDS_KILLED] >= 250],
			["Killing the bull by the horns", kACHIEVEMENTS.GENERAL_KILLING_THE_BULL_BY_THE_HORNS, flags[kFLAGS.MINOTAURS_KILLED] >= 10],
			["Killing the bull by the horns 2: Kill Harder", kACHIEVEMENTS.GENERAL_KILLING_THE_BULL_BY_THE_HORNS_2_KILL_HARDER, flags[kFLAGS.MINOTAURS_KILLED] >= 50],
			["Killing the bull by the horns 3: I'm Back", kACHIEVEMENTS.GENERAL_KILLING_THE_BULL_BY_THE_HORNS_3_IM_BACK, flags[kFLAGS.MINOTAURS_KILLED] >= 250],

			["Body Count: Monty Python and the Holy Grail", kACHIEVEMENTS.GENERAL_BODY_COUNT_MPATHG, totalKillCount >= 47],
			["Body Count: Deadpool", kACHIEVEMENTS.GENERAL_BODY_COUNT_DEADPOOL, totalKillCount >= 80],
			["Body Count: Robocop", kACHIEVEMENTS.GENERAL_BODY_COUNT_ROBOCOP, totalKillCount >= 144],
			["Body Count: Total Recall", kACHIEVEMENTS.GENERAL_BODY_COUNT_TOTALRECALL, totalKillCount >= 191],
			["Body Count: Rambo", kACHIEVEMENTS.GENERAL_BODY_COUNT_RAMBO, totalKillCount >= 247],
			["Body Count: Titanic", kACHIEVEMENTS.GENERAL_BODY_COUNT_TITANIC, totalKillCount >= 307],
			["Body Count: The Lord of the Rings - Two Towers", kACHIEVEMENTS.GENERAL_BODY_COUNT_LOTR_TT, totalKillCount >= 468],
			["Body Count: 300", kACHIEVEMENTS.GENERAL_BODY_COUNT_300, totalKillCount >= 600],
			["Body Count: The Lord of the Rings - Return of the King", kACHIEVEMENTS.GENERAL_BODY_COUNT_LOTR_ROTK, totalKillCount >= 836],
			["Body Count: Bloodiest Champion Ever", kACHIEVEMENTS.GENERAL_BODY_COUNT_BLOODIEST_CHAMPION_EVER, totalKillCount >= 1410],
			["Bad Ender", kACHIEVEMENTS.GENERAL_BAD_ENDER, NPCsBadEnds >= 2],
			["Bad Ender 2: Electric Boogaloo", kACHIEVEMENTS.GENERAL_BAD_ENDER_2, NPCsBadEnds >= 4],
			["Bad Ender 3: Serious Serial Slayer", kACHIEVEMENTS.GENERAL_BAD_ENDER_3, NPCsBadEnds >= 8],
			["Bad Ender 4: The Prequel", kACHIEVEMENTS.GENERAL_BAD_ENDER_4, NPCsBadEnds >= 16],
			["What's Happening to Me?", kACHIEVEMENTS.GENERAL_WHATS_HAPPENING_TO_ME, flags[kFLAGS.TIMES_TRANSFORMED] >= 1],
			["Transformer", kACHIEVEMENTS.GENERAL_TRANSFORMER, flags[kFLAGS.TIMES_TRANSFORMED] >= 10],
			["Shapeshifty", kACHIEVEMENTS.GENERAL_SHAPESHIFTY, flags[kFLAGS.TIMES_TRANSFORMED] >= 25],
			["Lego-(Wo)Man", kACHIEVEMENTS.GENERAL_LEGO_WO_MAN, flags[kFLAGS.TIMES_TRANSFORMED] >= 100],
			["Transformer-o-holic", kACHIEVEMENTS.GENERAL_TRANSFORMER_O_HOLIC, flags[kFLAGS.TIMES_TRANSFORMED] >= 250],
			["Tzimisce Antediluvian", kACHIEVEMENTS.GENERAL_TZIMISCE_ANTEDILUVIAN, flags[kFLAGS.TIMES_TRANSFORMED] >= 1000],
			["Just one last transformation item!!!", kACHIEVEMENTS.GENERAL_JUST_ONE_LAST_TRANSFORMATION_ITEM, flags[kFLAGS.TIMES_TRANSFORMED] >= 2500],
			["Fapfapfap", kACHIEVEMENTS.GENERAL_FAPFAPFAP, flags[kFLAGS.TIMES_MASTURBATED] >= 1],
			["Faptastic", kACHIEVEMENTS.GENERAL_FAPTASTIC, flags[kFLAGS.TIMES_MASTURBATED] >= 10],
			["Master-bation", kACHIEVEMENTS.GENERAL_FAPSTER, flags[kFLAGS.TIMES_MASTURBATED] >= 100],
			["Grand Master-bation", kACHIEVEMENTS.GENERAL_FAPSTER_2, flags[kFLAGS.TIMES_MASTURBATED] >= 1000],
			["Goo Armor", kACHIEVEMENTS.GENERAL_GOO_ARMOR, player.armor == armors.GOOARMR],
			["Helspawn", kACHIEVEMENTS.GENERAL_HELSPAWN, helspawnFollower()],
			["Urta's True Lover", kACHIEVEMENTS.GENERAL_URTA_TRUE_LOVER, flags[kFLAGS.URTA_KIDS_MALES] + flags[kFLAGS.URTA_KIDS_FEMALES] + flags[kFLAGS.URTA_KIDS_HERMS] > 0],
			["Godslayer", kACHIEVEMENTS.GENERAL_GODSLAYER, flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0],
			["Follow the Leader (1)", kACHIEVEMENTS.GENERAL_FOLLOW_THE_LEADER, camp.followersCount() >= 7],//ponownie przeliczyć followers, lovers, slaves counter
			["Follow the Leader (2)", kACHIEVEMENTS.GENERAL_FOLLOW_THE_LEADER_2, camp.followersCount() >= 14],
			["Follow the Leader (3)", kACHIEVEMENTS.GENERAL_FOLLOW_THE_LEADER_3, camp.followersCount() >= 21],
			["Gotta Love 'Em All (1)", kACHIEVEMENTS.GENERAL_GOTTA_LOVE_THEM_ALL, camp.loversCount() >= 8],
			["Gotta Love 'Em All (2)", kACHIEVEMENTS.GENERAL_GOTTA_LOVE_THEM_ALL_2, camp.loversCount() >= 16],
			["Gotta Love 'Em All (3)", kACHIEVEMENTS.GENERAL_GOTTA_LOVE_THEM_ALL_3, camp.loversCount() >= 24],
			["Meet Your [Master] (1)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER, camp.slavesCount() >= 4],
			["Meet Your [Master] (2)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_2, camp.slavesCount() >= 8],
			["Meet Your [Master] (3)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_TRUE_3, camp.slavesCount() >= 12],
			["Slaver (1)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_TRUE, camp.slavesCount() >= 6 && camp.slavesOptionalCount() >= 2],
			["Slaver (2)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_TRUE_2, camp.slavesCount() >= 12 && camp.slavesOptionalCount() >= 4],
			["Slaver (3)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_TRUE_3, camp.slavesCount() >= 18 && camp.slavesOptionalCount() >= 6],
			["All Your People are Belong to Me (1)", kACHIEVEMENTS.GENERAL_ALL_UR_PPLZ_R_BLNG_2_ME, camp.followersCount() + camp.loversCount() + camp.slavesCount() >= 19],
			["All Your People are Belong to Me (2)", kACHIEVEMENTS.GENERAL_ALL_UR_PPLZ_R_BLNG_2_ME_2, camp.followersCount() + camp.loversCount() + camp.slavesCount() >= 38],
			["All Your People are Belong to Me (3)", kACHIEVEMENTS.GENERAL_ALL_UR_PPLZ_R_BLNG_2_ME_3, camp.followersCount() + camp.loversCount() + camp.slavesCount() >= 57],
			["Freeloader", kACHIEVEMENTS.GENERAL_FREELOADER, flags[kFLAGS.MANSION_VISITED] >= 3],
			["Perky", kACHIEVEMENTS.GENERAL_PERKY, player.perks.length + player.perksCountForMergedOnes() - player.hasMutationCount(true) >= 25],
			["Super Perky", kACHIEVEMENTS.GENERAL_SUPER_PERKY, player.perks.length + player.perksCountForMergedOnes() - player.hasMutationCount(true) >= 50],
			["Mega Perky", kACHIEVEMENTS.GENERAL_MEGA_PERKY, player.perks.length + player.perksCountForMergedOnes() - player.hasMutationCount(true) >= 75],
			["Ultra Perky", kACHIEVEMENTS.GENERAL_ULTRA_PERKY, player.perks.length + player.perksCountForMergedOnes() - player.hasMutationCount(true) >= 100],
			["Hyper Perky", kACHIEVEMENTS.GENERAL_HYPER_PERKY, player.perks.length + player.perksCountForMergedOnes() - player.hasMutationCount(true) >= 200],
			["Umber Perky", kACHIEVEMENTS.GENERAL_UMBER_PERKY, player.perks.length + player.perksCountForMergedOnes() - player.hasMutationCount(true) >= 300],
			["Perky Beast of Death", kACHIEVEMENTS.GENERAL_PERKY_BEAST_OF_DEATH, player.perks.length + player.perksCountForMergedOnes() - player.hasMutationCount(true) >= 444],
			["Perky King", kACHIEVEMENTS.GENERAL_PERKY_KING, player.perks.length + player.perksCountForMergedOnes() - player.hasMutationCount(true) >= 600],
			["Ridiculous Perky King", kACHIEVEMENTS.GENERAL_RIDICULOUS_PERKY_KING, player.perks.length + player.perksCountForMergedOnes() - player.hasMutationCount(true) >= 800],
			["Ludicrous Perky King", kACHIEVEMENTS.GENERAL_LUDICROUS_PERKY_KING, player.perks.length + player.perksCountForMergedOnes() - player.hasMutationCount(true) >= 1000],
			["Lesser Chimera", kACHIEVEMENTS.GENERAL_LESSER_CHIMERA, player.internalChimeraScore() >= 4],
			["Normal Chimera", kACHIEVEMENTS.GENERAL_NORMAL_CHIMERA, player.internalChimeraScore() >= 8],
			["Greater Chimera", kACHIEVEMENTS.GENERAL_GREATER_CHIMERA, player.internalChimeraScore() >= 16],
			["Elder Chimera", kACHIEVEMENTS.GENERAL_ELDER_CHIMERA, player.internalChimeraScore() >= 32],
			["Legendary Chimera", kACHIEVEMENTS.GENERAL_LEGENDARY_CHIMERA, player.internalChimeraScore() >= 64],
			["Ultimate Lifeform", kACHIEVEMENTS.GENERAL_ULTIMATE_LIFEFORM, player.internalChimeraScore() >= 128],
			["Jack of All Trades", kACHIEVEMENTS.GENERAL_STATS_50, player.str >= 50 && player.tou >= 50 && player.spe >= 50 && player.inte >= 50 && player.wis >= 50 && player.lib >= 40 && player.sens >= 5],
			["Incredible Stats", kACHIEVEMENTS.GENERAL_STATS_100, player.str >= 100 && player.tou >= 100 && player.spe >= 100 && player.inte >= 100 && player.wis >= 100 && player.lib >= 80 && player.sens >= 10],
			["Anmazing Stats", kACHIEVEMENTS.GENERAL_STATS_150, player.str >= 150 && player.tou >= 150 && player.spe >= 150 && player.inte >= 150 && player.wis >= 150 && player.lib >= 120 && player.sens >= 15],
			["Superhuman Stats", kACHIEVEMENTS.GENERAL_STATS_200, player.str >= 200 && player.tou >= 200 && player.spe >= 200 && player.inte >= 200 && player.wis >= 200 && player.lib >= 160 && player.sens >= 20],
			["Inhuman Stats", kACHIEVEMENTS.GENERAL_STATS_300, player.str >= 300 && player.tou >= 300 && player.spe >= 300 && player.inte >= 300 && player.wis >= 300 && player.lib >= 240 && player.sens >= 30],
			["Epic Stats", kACHIEVEMENTS.GENERAL_STATS_500, player.str >= 500 && player.tou >= 500 && player.spe >= 500 && player.inte >= 500 && player.wis >= 500 && player.lib >= 400 && player.sens >= 50],
			["Legendary Stats", kACHIEVEMENTS.GENERAL_STATS_1000, player.str >= 1000 && player.tou >= 1000 && player.spe >= 1000 && player.inte >= 1000 && player.wis >= 1000 && player.lib >= 800 && player.sens >= 100],
			["Mythical Stats", kACHIEVEMENTS.GENERAL_STATS_2000, player.str >= 2000 && player.tou >= 2000 && player.spe >= 2000 && player.inte >= 2000 && player.wis >= 2000 && player.lib >= 1600 && player.sens >= 200],
			["Transcendental Stats", kACHIEVEMENTS.GENERAL_STATS_5000, player.str >= 5000 && player.tou >= 5000 && player.spe >= 5000 && player.inte >= 5000 && player.wis >= 5000 && player.lib >= 4000 && player.sens >= 500],
			["Divine Stats", kACHIEVEMENTS.GENERAL_STATS_15000, player.str >= 15000 && player.tou >= 15000 && player.spe >= 15000 && player.inte >= 15000 && player.wis >= 15000 && player.lib >= 12000 && player.sens >= 1500],
			["OPK", kACHIEVEMENTS.GENERAL_STATS_OPK, player.str >= 268445279 && player.tou >= 268445279 && player.spe >= 268445279 && player.inte >= 268445279 && player.wis >= 268445279],
			["Schizophrenic", kACHIEVEMENTS.GENERAL_SCHIZO, flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCHIZOPHRENIA] >= 4],
			["Clean Slate", kACHIEVEMENTS.GENERAL_CLEAN_SLATE, flags[kFLAGS.ACHIEVEMENT_PROGRESS_CLEAN_SLATE] >= 2],
			["I'm No Lumberjack", kACHIEVEMENTS.GENERAL_IM_NO_LUMBERJACK, flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] >= 100],
			["Deforester", kACHIEVEMENTS.GENERAL_DEFORESTER, flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] >= 100],
			["Hammer Time", kACHIEVEMENTS.GENERAL_HAMMER_TIME, flags[kFLAGS.ACHIEVEMENT_PROGRESS_HAMMER_TIME] >= 300],
			["Nail Scavenger", kACHIEVEMENTS.GENERAL_NAIL_SCAVENGER, flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCAVENGER] >= 200],
			["Yabba Dabba Doo", kACHIEVEMENTS.GENERAL_YABBA_DABBA_DOO, flags[kFLAGS.ACHIEVEMENT_PROGRESS_YABBA_DABBA_DOO] >= 100],
			["AntWorks", kACHIEVEMENTS.GENERAL_ANTWORKS, flags[kFLAGS.ACHIEVEMENT_PROGRESS_ANTWORKS] >= 200],
			["Home Sweet Home", kACHIEVEMENTS.GENERAL_HOME_SWEET_HOME, flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESK] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESKCHAIR] >= 1],
			["Up to Eleven", kACHIEVEMENTS.GENERAL_UP_TO_11, player.tallness >= 132],
			["Dick Banisher", kACHIEVEMENTS.GENERAL_DICK_BANISHER, NPCsDedicked >= 3],
			["You Bastard", kACHIEVEMENTS.GENERAL_YOU_BASTARD, NPCsDedicked >= 7], //Take that, dedickers!
			["xXx2: The Next Level", kACHIEVEMENTS.EPIC_XXX2_THE_NEXT_LEVEL, player.newGamePlusMod() >= 1],
			["xXx: The Return of Mareth Champion", kACHIEVEMENTS.EPIC_XXX_THE_RETURN_OF_MARETH_CHAMPION, player.newGamePlusMod() >= 2],
			["xXx 4", kACHIEVEMENTS.EPIC_XXX_4, player.newGamePlusMod() >= 3],
			["xXx 5: Mareth's Judgment_Day", kACHIEVEMENTS.EPIC_XXX5_MARETHS_JUDGMENT_DAY, player.newGamePlusMod() >= 4],
			["xXx 6: Rise of the Demons", kACHIEVEMENTS.EPIC_XXX6_RISE_OF_THE_DEMONS, player.newGamePlusMod() >= 5],
			["xXx 7: Salvation", kACHIEVEMENTS.EPIC_XXX7_SALVATION, player.newGamePlusMod() >= 6],
			["xXx 8: Genisys", kACHIEVEMENTS.EPIC_XXX8_GENISYS, player.newGamePlusMod() >= 7],
			["xXx 9: Dark Fate", kACHIEVEMENTS.EPIC_XXX9_DARK_FATE, player.newGamePlusMod() >= 8],
			["My own Demon Weapon", kACHIEVEMENTS.EPIC_MY_OWN_DEMON_WEAPON, flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] > 0 || flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] > 0],
			["Me Evolve", kACHIEVEMENTS.EPIC_ME_EVOLVE, EvolvingItems >= 1],
			["Us Evolve", kACHIEVEMENTS.EPIC_US_EVOLVE, EvolvingItems >= 2],
			["They Evolve", kACHIEVEMENTS.EPIC_THEY_EVOLVE, EvolvingItems >= 4],
			["Everyone Evolve", kACHIEVEMENTS.EPIC_EVERYONE_EVOLVE, EvolvingItems >= 8],
			["Faster Harder Better Stronger Curvier!!! (1)", kACHIEVEMENTS.EPIC_F_H_B_S_CURVIER_1, EvolutionsCount >= 1],
			["Faster Harder Better Stronger Curvier!!! (2)", kACHIEVEMENTS.EPIC_F_H_B_S_CURVIER_2, EvolutionsCount >= 2],
			["Faster Harder Better Stronger Curvier!!! (3)", kACHIEVEMENTS.EPIC_F_H_B_S_CURVIER_3, EvolutionsCount >= 4],
			["Faster Harder Better Stronger Curvier!!! (4)", kACHIEVEMENTS.EPIC_F_H_B_S_CURVIER_4, EvolutionsCount >= 8],
			["Faster Harder Better Stronger Curvier!!! (5)", kACHIEVEMENTS.EPIC_F_H_B_S_CURVIER_5, EvolutionsCount >= 16],
			["Guardian of Notre-Dame", kACHIEVEMENTS.EPIC_GUARDIAN_OF_NOTRE_DAME, player.hasPerk(PerkLib.GargoylePure) || player.hasPerk(PerkLib.GargoyleCorrupted)],
			["The Devil Wears Prada", kACHIEVEMENTS.EPIC_THE_DEVIL_WEARS_PRADA, player.hasPerk(PerkLib.Phylactery)],
			["Thriller", kACHIEVEMENTS.EPIC_THRILLER, player.isRace(Races.JIANGSHI)],
			["Let It Go", kACHIEVEMENTS.EPIC_LET_IT_GO, player.isRace(Races.YUKIONNA)],
		];

		for each (var ach:Array in achievementList)
			if (ach[2]) awardAchievement(ach[0], ach[1]);

		//AFTER ALL. Check achievements counter!
		var achStat:Achievements = new Achievements();
		achStat.checkAll(true);
		//Shadow
		if (achStat.achievementsShadowEarned >= 1) awardAchievement("Shadow Initiate", kACHIEVEMENTS.SHADOW_INITIATE);
		if (achStat.achievementsShadowEarned >= 10) awardAchievement("Shadow Squire", kACHIEVEMENTS.SHADOW_SQUIRE);
		if (achStat.achievementsShadowEarned >= 25) awardAchievement("Shadow Knight", kACHIEVEMENTS.SHADOW_KNIGHT);
		if (achStat.achievementsShadowEarned >= 45) awardAchievement("Shadow Paladin", kACHIEVEMENTS.SHADOW_PALADIN);
		if (achStat.achievementsShadowEarned >= 70) awardAchievement("Shadow General", kACHIEVEMENTS.SHADOW_GENERAL);
		//Epic
		if (achStat.achievementsTotalCurrentlyUnlocked >= 10) awardAchievement("Achievementception", kACHIEVEMENTS.EPIC_ACHIEVEMENTCEPTION);
		if (achStat.achievementsTotalCurrentlyUnlocked >= 30) awardAchievement("Achievement within Achievement", kACHIEVEMENTS.EPIC_ACHIEVEMENT_WITHIN_ACHIEVEMENT);
		if (achStat.achievementsTotalCurrentlyUnlocked >= 60) awardAchievement("Achievements - Going Deeper (1st layer)", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_GOING_DEEPER_1L);
		if (achStat.achievementsTotalCurrentlyUnlocked >= 100) awardAchievement("Achievements - Going Deeper (2nd layer)", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_GOING_DEEPER_2L);
		if (achStat.achievementsTotalCurrentlyUnlocked >= 300) awardAchievement("Achievements - Going Deeper (3rd layer)", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_GOING_DEEPER_3L);
		if (achStat.achievementsTotalCurrentlyUnlocked >= 600) awardAchievement("Achievements Limbo", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_LIMBO);
	}
	
	public function bringBackEncoutersForSouless():void {
	}

	public function fixFlags():void {
		//Marae
		if (player.hasStatusEffect(StatusEffects.MetMarae)) {
			flags[kFLAGS.MET_MARAE] = 1;
			player.removeStatusEffect(StatusEffects.MetMarae);
		}
		if (player.hasStatusEffect(StatusEffects.MaraesQuestStart)) {
			flags[kFLAGS.MARAE_QUEST_START] = 1;
			player.removeStatusEffect(StatusEffects.MaraesQuestStart);
		}
		if (player.hasStatusEffect(StatusEffects.MaraeComplete)) {
			flags[kFLAGS.MARAE_QUEST_COMPLETE] = 1;
			player.removeStatusEffect(StatusEffects.MaraeComplete);
		}
		if (player.hasStatusEffect(StatusEffects.MaraesLethicite)) {
			player.createKeyItem("Marae's Lethicite", 3, 0, 0, 0);
			player.removeStatusEffect(StatusEffects.MaraesLethicite);
		}
		//Factory Demons
		if (player.hasStatusEffect(StatusEffects.FactorySuccubusDefeated)) {
			flags[kFLAGS.FACTORY_SUCCUBUS_DEFEATED] = 1;
			player.removeStatusEffect(StatusEffects.FactorySuccubusDefeated);
		}
		if (player.hasStatusEffect(StatusEffects.FactoryIncubusDefeated)) {
			flags[kFLAGS.FACTORY_INCUBUS_DEFEATED] = 1;
			player.removeStatusEffect(StatusEffects.FactoryIncubusDefeated);
		}
		if (player.hasStatusEffect(StatusEffects.FactoryOmnibusDefeated)) {
			flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] = 1;
			player.removeStatusEffect(StatusEffects.FactoryOmnibusDefeated);
		}
		//Factory Variables
		if (player.hasStatusEffect(StatusEffects.FoundFactory)) {
			flags[kFLAGS.FACTORY_FOUND] = 1;
			player.removeStatusEffect(StatusEffects.FoundFactory);
		}
		if (player.hasStatusEffect(StatusEffects.IncubusBribed)) {
			flags[kFLAGS.FACTORY_INCUBUS_BRIBED] = 1;
			player.removeStatusEffect(StatusEffects.IncubusBribed);
		}
		if (player.hasStatusEffect(StatusEffects.DungeonShutDown)) {
			flags[kFLAGS.FACTORY_SHUTDOWN] = 1;
			player.removeStatusEffect(StatusEffects.DungeonShutDown);
		}
		if (player.hasStatusEffect(StatusEffects.FactoryOverload)) {
			flags[kFLAGS.FACTORY_SHUTDOWN] = 2;
			player.removeStatusEffect(StatusEffects.FactoryOverload);
		}
		if (player.hasStatusEffect(StatusEffects.TakenLactaid)) {
			flags[kFLAGS.FACTORY_TAKEN_LACTAID] = 5 - (player.statusEffectv1(StatusEffects.TakenLactaid));
			player.removeStatusEffect(StatusEffects.TakenLactaid);
		}
		if (player.hasStatusEffect(StatusEffects.TakenGroPlus)) {
			flags[kFLAGS.FACTORY_TAKEN_GROPLUS] = 5 - (player.statusEffectv1(StatusEffects.TakenGroPlus));
			player.removeStatusEffect(StatusEffects.TakenGroPlus);
		}
		if (SceneLib.dungeons.checkPhoenixTowerClear() && flags[kFLAGS.CLEARED_HEL_TOWER] < 2) flags[kFLAGS.CLEARED_HEL_TOWER] = 1;
	}
	
	private var updateQueue:/*Function*/Array = [];
	public function onUnknownPerk(player:Player, savedata:Object, id:String, value1:Number,value2:Number, value3:Number,value4:Number):void {
		CoC_Settings.error("Unknown perk id: " + id);
	}
	public function onUnknownStatusEffect(player:Player, savedata:Object, id:String, value1:Number, value2:Number, value3:Number, value4:Number):void {
		switch (id) {
			case "exploredDeepwoods":
				// We can't set variable now because status effects are loaded before saveable states.
				// Schedule the update after SS are loaded, instead
				updateQueue.push(function ():void {
					SceneLib.exploration.counters.deepwoods = value1;
				});
				return;
			case "Boat Discovery":
				updateQueue.push(function ():void {
					SceneLib.exploration.counters.boat = 1 + value1;
				});
				return;
		}
		CoC_Settings.error("Cannot find status effect '" + id + "'");
	}
	public function onUnknownInventoryItem(player:Player, savedata:Object, itemId:String, savedShortName:String, quantity:Number, storageSlot:ItemSlotClass):void {
		storageSlot.emptySlot();
	}
	public function onUnknownEquipmentItem(player:Player, savedata:Object, slot:int, savedId:String, savedName:String, defaultValue:Equipable):Boolean {
		player.internalEquipItem(slot, defaultValue, false, true);
		return false;
	}
	/**
	 * This is called after everything was loaded, but before stat update
	 */
	public function postLoadSaveObject(player:Player, savedata:Object):void {
		if (!(savedata.ss && savedata.ss["Exploration"])) {
			SceneLib.exploration.counters.lake         = savedata.exploredLake;
			SceneLib.exploration.counters.mountainsMid = savedata.exploredMountain;
			SceneLib.exploration.counters.forestInner  = int(savedata.exploredForest/2);
			SceneLib.exploration.counters.forestOuter  = int(savedata.exploredForest/2);
			SceneLib.exploration.counters.desertOuter  = savedata.exploredDesert;
			SceneLib.exploration.counters.explore      = savedata.explored;
		}
		for each (var fn:Function in updateQueue) {
			fn();
		}
		updateQueue = [];
	}

	public function refundPerk(perk:PerkType):void {
		if (player.hasPerk(perk)) {
			player.removePerk(perk);
			player.perkPoints += 1;
		}
	}

	public function furColorSelection1():void {
		menu();
		addButton(0, "Brown", chooseFurColorSaveUpdate, "brown");
		addButton(1, "Chocolate", chooseFurColorSaveUpdate, "chocolate");
		addButton(2, "Auburn", chooseFurColorSaveUpdate, "auburn");
		addButton(3, "Orange", chooseFurColorSaveUpdate, "orange");

		addButton(5, "Caramel", chooseFurColorSaveUpdate, "caramel");
		addButton(6, "Peach", chooseFurColorSaveUpdate, "peach");
		addButton(7, "Sandy Brown", chooseFurColorSaveUpdate, "sandy brown");
		addButton(8, "Golden", chooseFurColorSaveUpdate, "golden");

		addButton(4, "Next", furColorSelection2);
	}

	private function furColorSelection2():void {
		menu();
		addButton(0, "Midnight black", chooseFurColorSaveUpdate, "midnight black");
		addButton(1, "Black", chooseFurColorSaveUpdate, "black");
		addButton(2, "Dark gray", chooseFurColorSaveUpdate, "dark gray");
		addButton(3, "Gray", chooseFurColorSaveUpdate, "gray");

		addButton(5, "Light gray", chooseFurColorSaveUpdate, "light gray");
		addButton(6, "Silver", chooseFurColorSaveUpdate, "silver");
		addButton(7, "White", chooseFurColorSaveUpdate, "white");

		addButton(10, "Orange&White", chooseFurColorSaveUpdate, "orange and white");
		addButton(11, "Brown&White", chooseFurColorSaveUpdate, "brown and white");
		addButton(12, "Black&White", chooseFurColorSaveUpdate, "black and white");
		addButton(13, "Gray&White", chooseFurColorSaveUpdate, "gray and white");

		addButton(9, "Previous", furColorSelection1);
	}

	private function chooseFurColorSaveUpdate(color:String):void {
		clearOutput();
		outputText("You now have " + color + " fur. You will be returned to your [camp] now and you can continue your usual gameplay.");
		player.furColor = color;
		doNext(camp.doCamp);
	}

	public function eyesColorSelection():void {
		menu();
		addButton(0, "Black", chooseEyesColorSaveUpdate, "black");
		addButton(1, "Green", chooseEyesColorSaveUpdate, "green");
		addButton(2, "Blue", chooseEyesColorSaveUpdate, "blue");
		addButton(3, "Red", chooseEyesColorSaveUpdate, "red");
		addButton(4, "White", chooseEyesColorSaveUpdate, "white");
		addButton(5, "Brown", chooseEyesColorSaveUpdate, "brown");
		addButton(6, "Yellow", chooseEyesColorSaveUpdate, "yellow");
		addButton(7, "Grey", chooseEyesColorSaveUpdate, "grey");
		addButton(8, "Purple", chooseEyesColorSaveUpdate, "purple");
		addButton(10, "Silver", chooseEyesColorSaveUpdate, "silver");
		addButton(11, "Golden", chooseEyesColorSaveUpdate, "golden");
	}

	private function chooseEyesColorSaveUpdate(color:String):void {
		clearOutput();
		CoC.instance.transformations.EyesChangeColor([color]).applyEffect(false);
		outputText("You now have [eyecolor] eyes. You will be returned to your [camp] now and you can continue your usual gameplay.");
		doNext(camp.doCamp);
	}

	public function jiangshiBuggedItemsCleanUpCrew():void {
		if (!player.weapon.isNothing) {
			if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 2) {
				flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 1;
				player.unequipWeapon(false,true);
				jiangshiBuggedItemsCleanUpCrew();
				return;
			}
			else {
				inventory.takeItem(player.unequipWeapon(false,true), jiangshiBuggedItemsCleanUpCrew);
				return;
			}
		}
		if (!player.weaponRange.isNothing) {
			inventory.takeItem(player.unequipWeaponRange(false,true), jiangshiBuggedItemsCleanUpCrew);
			return;
		}
		if (!player.shield.isNothing) {
			if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 2) {
				flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 1;
				player.unequipShield(false,true);
				jiangshiBuggedItemsCleanUpCrew();
				return;
			}
			else {
				inventory.takeItem(player.unequipShield(false,true), jiangshiBuggedItemsCleanUpCrew);
				return;
			}
		}
		if (!player.armor.isNothing) {
			inventory.takeItem(player.setArmor(armors.TRADITC,false,true), jiangshiBuggedItemsCleanUpCrew);
			return;
		}
		if (!player.lowerGarment.isNothing) {
			inventory.takeItem(player.unequipUnderBottom(false,true), jiangshiBuggedItemsCleanUpCrew);
			return;
		}
		if (!player.upperGarment.isNothing) {
			inventory.takeItem(player.unequipUnderTop(false,true), jiangshiBuggedItemsCleanUpCrew);
			return;
		}
		if (!player.headJewelry.isNothing) {
			flags[kFLAGS.PLAYER_DISARMED_HEAD_ACCESORY_ID] = player.headJewelry.id;
		}
		player.setHeadJewelry(headjewelries.JIANGCT, false, true);
		player.statStore.replaceBuffObject({'str.mult':0.2,'tou.mult':0.2,'lib.mult':0.2,'sens':80}, 'Jiangshi Curse Tag', { text: 'Jiangshi Curse Tag' });
	}

	public function promptSaveUpdate():void {
		clearOutput();
		doNext(camp.doCamp); //safeguard
		var initialVersion:Number = flags[kFLAGS.MOD_SAVE_VERSION];
		if (flags[kFLAGS.MOD_SAVE_VERSION] < 2) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 2;
			outputText("<b><u>CAUTION</u></b>\n");
			outputText("Looks like you are importing your save from vanilla CoC.");
			outputText("\n\nIf you're planning to save over your original save file, I not going to stop you but... If you overwrite the save file from original game, it will no longer be backwards compatible with the original CoC. So maybe create separate save files.");
			outputText("\n\nWithout sound any more cranky, enjoy everything CoC Wuxia Mod has to offer!");
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 2) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 3;
			outputText("Ups looks like you don't have achievements feature unlocked yet. So now you can get them.");
			outputText("\n\nDrill is as always. So not all achievements would be automaticaly gained but who of people playing this won't play again and again and...you get my drift right?");
			updateAchievements();
			outputText("\n\nAchievements are saved in a special savefile so no matter what savefile you're on, any earned achievements will be added to that special savefile. And now got catch them all traine...burp I mean fellow players ^^");
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 3) {
			//Reclaim flags for future use.
			flags[kFLAGS.GIACOMO_MET] = 0;
			flags[kFLAGS.GIACOMO_NOTICES_WORMS] = 0;
			flags[kFLAGS.PHOENIX_ENCOUNTERED] = 0;
			flags[kFLAGS.PHOENIX_WANKED_COUNTER] = 0;
			flags[kFLAGS.MOD_SAVE_VERSION] = 4;
			camp.doCamp();
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 4) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 5;
			if (flags[kFLAGS.KELT_KILLED] > 0 && player.statusEffectv1(StatusEffects.Kelt) <= 0) {
				clearOutput();
				outputText("Due to a bug where your bow skill got reset after you've slain Kelt, your bow skill got reset. Fortunately, this is now fixed. As a compensation, your bow skill is now instantly set to 100!");
				if (player.statusEffectv1(StatusEffects.Kelt) <= 0) player.createStatusEffect(StatusEffects.Kelt, 100, 0, 0, 0);
				doNext(camp.doCamp);
				return;
			}
			camp.doCamp();
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 5) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 6;
			if (player.armorName == "revealing fur loincloths" || player.armorName == "comfortable underclothes" || player.weaponName == "dragon-shell shield") {
				clearOutput();
				outputText("Due to a bit of restructing regarding equipment, any reclassified equipment (eggshell shield and fur loincloth) that was equipped are now unequipped.");
				if (player.armorName == "comfortable underclothes") player.unequipArmor();
				if (player.armorName == "revealing fur loincloths") inventory.takeItem(player.setArmor(ArmorLib.COMFORTABLE_UNDERCLOTHES), promptSaveUpdate);
				if (player.weaponName == "dragon-shell shield") inventory.takeItem(player.setWeapon(WeaponLib.FISTS), promptSaveUpdate);
				doNext(camp.doCamp);
				return;
			}
			camp.doCamp();
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 6) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 7;
			if (flags[kFLAGS.MOD_SAVE_VERSION] == 6) {
				flags[kFLAGS.D1_OMNIBUS_KILLED] = flags[kFLAGS.CORRUPTED_GLADES_DESTROYED];
				flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] = 0; //Reclaimed
			}
			if (player.armor == armors.GOOARMR) flags[kFLAGS.VALERIA_FLUIDS] = 100;
			camp.doCamp();
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 7) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 8;
			//Move and reclaim flag.
			flags[kFLAGS.LETHICITE_ARMOR_TAKEN] = flags[kFLAGS.JOJO_ANAL_CATCH_COUNTER];
			flags[kFLAGS.JOJO_ANAL_CATCH_COUNTER] = 0;
			camp.doCamp();
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 8) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 9;
			if (!player.isFurCovered()) {
				camp.doCamp();
				return; //No fur? Return to camp.
			}
			//Update fur
			clearOutput();
			outputText("You did it again don't ya? You went and get fur and now we got trouble to solve...err ok joking just fast pick color for your new shiny fur and nobody would notice ^^");
			furColorSelection1();
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 9) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 10;
			if (flags[kFLAGS.PRISCILLA_AFFECTION] > 0 && player.hasKeyItem("Marae's Lethicite") >= 0) {
				player.removeKeyItem("Marae's Lethicite");
				player.createKeyItem("Marae's Lethicite", flags[kFLAGS.PRISCILLA_AFFECTION], 0, 0, 0);
				flags[kFLAGS.PRISCILLA_AFFECTION] = 0;
			}
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 10) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 11;
			if (player.hasPerk(PerkLib.JobMonk)) {
				player.removePerk(PerkLib.JobMonk);
				player.createPerk(PerkLib.JobBrawler, 0, 0, 0, 0);
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 11) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 12;
			outputText("No worry it's not a bug it's an airplan...err ok your save is just upgraded to the next level ^^");
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] < 0) flags[kFLAGS.EVANGELINE_SPELLS_CASTED] = 0;
			if (flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] < 0) flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] = 0;
			if (flags[kFLAGS.CAMP_CABIN_PROGRESS] > 5) flags[kFLAGS.CAMP_CABIN_PROGRESS] -= 2;
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 12) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 13;
			clearOutput();
			outputText("And we do it again since game got more shiny then before so we would fast give additional polishing to your save. No worry it will be now +20% more shiny ;)");
			if (!player.hasPerk(PerkLib.JobSoulCultivator)) player.perkPoints += 1;
			var refund:int = 0;
			if (player.perkv1(PerkLib.AscensionTolerance) > 10) {
				refund += player.perkv1(PerkLib.AscensionTolerance) - 10;
				player.setPerkValue(PerkLib.AscensionTolerance, 1, 10);
				player.ascensionPerkPoints += refund;
			}
			if (player.hasPerk(PerkLib.JobArcher)) {
				player.removePerk(PerkLib.JobArcher);
				player.createPerk(PerkLib.JobRanger, 0, 0, 0, 0);
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 13) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 14;
			clearOutput();
			outputText("Attention! All Munchkins Kindly leave thou gate sixty and nine. As replacements there will be whole legion of All-Rounders commin in five, four, ...........aaaand they're here ^^");
			if (player.hasPerk(PerkLib.DeityJobMunchkin)) {
				player.removePerk(PerkLib.DeityJobMunchkin);
				player.createPerk(PerkLib.JobAllRounder, 0, 0, 0, 0);
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 14) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 15;
			clearOutput();
			outputText("Why only use an imitation of bow when you can have A REAL BOW?");
			if (player.hasKeyItem("Bow") >= 0) {
				player.removeKeyItem("Bow");
				player.setWeaponRange(weaponsrange.BOWOLD_);
			}
			if (player.hasKeyItem("Bow") >= 0 && player.hasKeyItem("Kelt's Bow") >= 0) {
				player.removeKeyItem("Bow");
				player.removeKeyItem("Kelt's Bow");
				player.gems = player.gems + 1;
				statScreenRefresh();
				player.setWeaponRange(weaponsrange.BOWKELT);
			}
			if (player.hasPerk(PerkLib.ImprovedEndurance)) {
				player.removePerk(PerkLib.ImprovedEndurance);
				player.createPerk(PerkLib.BasicEndurance, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.AdvancedEndurance)) {
				player.removePerk(PerkLib.AdvancedEndurance);
				player.createPerk(PerkLib.HalfStepToImprovedEndurance, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.SuperiorEndurance)) {
				player.removePerk(PerkLib.SuperiorEndurance);
				player.createPerk(PerkLib.ImprovedEndurance, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.ImprovedSelfControl)) {
				player.removePerk(PerkLib.ImprovedSelfControl);
				player.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.AdvancedSelfControl)) {
				player.removePerk(PerkLib.AdvancedSelfControl);
				player.createPerk(PerkLib.HalfStepToImprovedSelfControl, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.SuperiorSelfControl)) {
				player.removePerk(PerkLib.SuperiorSelfControl);
				player.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 15) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 16;
			clearOutput();
			outputText("Time for...save upgrade ^^");
			if (player.hasPerk(PerkLib.EnlightenedNinetails)) player.createPerk(PerkLib.EnlightenedKitsune, 0, 0, 0, 0);
			if (player.hasPerk(PerkLib.CorruptedNinetails)) player.createPerk(PerkLib.CorruptedKitsune, 0, 0, 0, 0);
			if (player.hasPerk(PerkLib.Manyshot) && !player.hasPerk(PerkLib.WeaponRangeTripleStrike)) {
				player.removePerk(PerkLib.Manyshot);
				player.createPerk(PerkLib.WeaponRangeTripleStrike, 0, 0, 0, 0);
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 16) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 17;
			clearOutput();
			outputText("Tentacled Barks, Divine Barks, Barks everywhere!!! No go back and beat Marae again if you had her bark unused yet");
			if (player.hasKeyItem("Tentacled Bark Plates") >= 0) {
				player.removeKeyItem("Tentacled Bark Plates");
				flags[kFLAGS.CORRUPTED_MARAE_KILLED] = 0;
			}
			if (player.hasKeyItem("Divine Bark Plates") >= 0) {
				player.removeKeyItem("Divine Bark Plates");
				flags[kFLAGS.PURE_MARAE_ENDGAME] = 1;
			}
			refundPerk(PerkLib.JobSoulArcher);
			//Update chitin
			if (player.hasCoatOfType(Skin.CHITIN)) {
				if (player.isRace(Races.MANTIS)) player.chitinColor = "green";
				if (player.isRace(Races.SPIDER)) player.chitinColor = "pale white";
				if (player.isRace(Races.MANTIS) && !player.isRace(Races.SPIDER)) {
					if (rand(2) == 1) player.chitinColor = "green";
					else player.chitinColor = "pale white";
				}
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 17) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 18;
			clearOutput();
			outputText("Multi tails get broken or was it venom in them...so we fixed that both will not gonna mess up other or so we think ^^");
			if (player.tailType == Tail.FOX) {
				player.tailCount = player.tailVenom;
				if (player.tailCount < 1) player.tailCount = 1;
				player.tailVenom = 0;
			}
			if (player.faceType == Face.SNAKE_FANGS) {
				if (player.tailRecharge < 5) player.tailRecharge = 5;
			}
			refundPerk(PerkLib.Cupid);
			refundPerk(PerkLib.ElementalArrows);
			if (player.hasPerk(PerkLib.JobArcaneArcher)) {
				player.removePerk(PerkLib.JobArcaneArcher);
				player.createPerk(PerkLib.JobHunter, 0, 0, 0, 0);
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 18) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 19;
			clearOutput();
			outputText("Small reorganizing of the house interiors...err I mean mod interiors so not mind it if you don't have Soul Cultivator PC. I heard you all likes colors, colors on EVERYTHING ever your belowed lil PC's eyes. So go ahead and pick them. Not much change from addition to appearance screen this small detail. But in future if scene will allow there will be addition of parser for using eyes color too.");
			if (player.hasPerk(PerkLib.SoulExalt)) {
				player.removePerk(PerkLib.SoulExalt);
				player.createPerk(PerkLib.SoulScholar, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.SoulOverlord)) {
				player.removePerk(PerkLib.SoulOverlord);
				player.createPerk(PerkLib.SoulElder, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KITSUNE_SHRINE_UNLOCKED] > 0 && flags[kFLAGS.AYANE_FOLLOWER] < 0) flags[kFLAGS.AYANE_FOLLOWER] = 0;
			if (flags[kFLAGS.GOTTEN_INQUISITOR_ARMOR] > 0) flags[kFLAGS.GOTTEN_INQUISITOR_ARMOR] = 2;
			eyesColorSelection();
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 19) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 20;
			if (player.hasPerk(PerkLib.JobBarbarian)) {
				player.removePerk(PerkLib.JobBarbarian);
				player.createPerk(PerkLib.JobSwordsman, 0, 0, 0, 0);
			}
			clearOutput();
			outputText("Switching one perk...if needed.");
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 20) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 21;
			if (player.hasPerk(PerkLib.Lycanthropy)) {
				player.skin.coverage = Skin.COVERAGE_LOW;
				player.furColor = player.hairColor;
				player.removePerk(PerkLib.Lycanthropy);
				var bonusStats:Number = 0;
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 3 || flags[kFLAGS.LUNA_MOON_CYCLE] == 5) bonusStats += 10;
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 2 || flags[kFLAGS.LUNA_MOON_CYCLE] == 6) bonusStats += 20;
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 1 || flags[kFLAGS.LUNA_MOON_CYCLE] == 7) bonusStats += 30;
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) bonusStats += 40;
				player.createPerk(PerkLib.Lycanthropy, bonusStats, 0, 0, 0);
			}
			if (flags[kFLAGS.LUNA_MOON_CYCLE] > 8) flags[kFLAGS.LUNA_MOON_CYCLE] = 1;
			clearOutput();
			outputText("Time to defur our werewolfs... no worry it will be only partial deffuring.");
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 21) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 22;
			clearOutput();
			outputText("Time to get from zero to Hero. Also some lil gift if PC is at least on lvl 1 ^^");
			outputText("\n\nThere was also minor reshuffle in chimera body (and some other) perks but let not talk about mutations.... remember kids: don't do mutations... become Mareth Champion and get them for free.");
			if (flags[kFLAGS.STAT_GAIN_MODE] == CoC.STAT_GAIN_CLASSIC) {
				player.statPoints += 5;
				if (player.level > 6) player.statPoints += 30;
				else player.statPoints += (5 * player.level);
			}
			if (player.level > 6) player.perkPoints += 7;
			else player.perkPoints += player.level + 1;
			if (flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] > 0) {
				if (flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] == 1) player.createStatusEffect(StatusEffects.SoulArenaGaunlets1, 2, 0, 0, 0);
				else player.createStatusEffect(StatusEffects.SoulArenaGaunlets1, 2, 2, 0, 0);
				flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] = 0;
			}
			refundPerk(PerkLib.SenseCorruption);
			refundPerk(PerkLib.SenseWrath);
			if (player.hasPerk(PerkLib.ChimericalBodyBasicStage)) {
				player.removePerk(PerkLib.ChimericalBodyBasicStage);
				player.createPerk(PerkLib.ChimericalBodySemiBasicStage, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.ChimericalBodyAdvancedStage)) {
				player.removePerk(PerkLib.ChimericalBodyAdvancedStage);
				player.createPerk(PerkLib.ChimericalBodyBasicStage, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.UnlockBody2ndStage)) {
				player.removePerk(PerkLib.UnlockBody2ndStage);
				player.createPerk(PerkLib.UnlockEndurance, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.UnlockId)) {
				player.removePerk(PerkLib.UnlockId);
				player.createPerk(PerkLib.UnlockArdor, 0, 0, 0, 0);
				if (player.hasPerk(PerkLib.UnlockId2ndStage)) {
					player.removePerk(PerkLib.UnlockId2ndStage);
					player.createPerk(PerkLib.UnlockId, 0, 0, 0, 0);
				}
			}
			if (player.hasPerk(PerkLib.UnlockMind)) {
				player.removePerk(PerkLib.UnlockMind);
				player.createPerk(PerkLib.UnlockForce, 0, 0, 0, 0);
				if (player.hasPerk(PerkLib.UnlockMind2ndStage)) {
					player.removePerk(PerkLib.UnlockMind2ndStage);
					player.createPerk(PerkLib.UnlockSpirit, 0, 0, 0, 0);
				}
			}
			if (player.hasPerk(PerkLib.HalfStepToMythicalEndurance)) {
				player.removePerk(PerkLib.HalfStepToMythicalEndurance);
				player.createPerk(PerkLib.HalfStepToLegendaryEndurance, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.MythicalEndurance)) {
				player.removePerk(PerkLib.MythicalEndurance);
				player.createPerk(PerkLib.LegendaryEndurance, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.HalfStepToMythicalSelfControl)) {
				player.removePerk(PerkLib.HalfStepToMythicalSelfControl);
				player.createPerk(PerkLib.HalfStepToLegendarySelfControl, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.MythicalSelfControl)) {
				player.removePerk(PerkLib.MythicalSelfControl);
				player.createPerk(PerkLib.LegendarySelfControl, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.HalfStepToMythicalSpirituality)) {
				player.removePerk(PerkLib.HalfStepToMythicalSpirituality);
				player.createPerk(PerkLib.HalfStepToLegendarySpirituality, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.MythicalSpirituality)) {
				player.removePerk(PerkLib.MythicalSpirituality);
				player.createPerk(PerkLib.LegendarySpirituality, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.HalfStepToMythicalTranquilness)) {
				player.removePerk(PerkLib.HalfStepToMythicalTranquilness);
				player.createPerk(PerkLib.HalfStepToLegendaryTranquilness, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.MythicalTranquilness)) {
				player.removePerk(PerkLib.MythicalTranquilness);
				player.createPerk(PerkLib.LegendaryTranquilness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.HIDDEN_CAVE_BOSSES] == 3) {
				flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] = 6;
				flags[kFLAGS.HIDDEN_CAVE_BOSSES] = 2;
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 22) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 23;
			clearOutput();
			outputText("Transcendenting Transcendental Genetic Memory by 50%, Catching Cowardly dragon-boys and refreshing dose of Productivity Drugs.");
			if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1)) player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 1, 5);
			if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage2)) player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 1, 10);
			if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage3)) player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 1, 15);
			if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage4)) player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 1, 20);
			if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage5)) player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 1, 25);
			if (flags[kFLAGS.HIDDEN_CAVE_BOSSES] >= 1) {
				flags[kFLAGS.TED_DEFEATS_COUNTER] = 1;
				flags[kFLAGS.TED_LVL_UP] = 1;
			}
			if (player.hasPerk(PerkLib.ProductivityDrugs)) {
				player.removePerk(PerkLib.ProductivityDrugs);
				player.createPerk(PerkLib.ProductivityDrugs, 0, 10, 0, 0);
				player.addPerkValue(PerkLib.ProductivityDrugs, 1, Math.round(player.cor / 2));
				player.addPerkValue(PerkLib.ProductivityDrugs, 3, player.lib);
				player.addPerkValue(PerkLib.ProductivityDrugs, 4, player.lib);
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 23) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 24;
			clearOutput();
			outputText("Reseting dream about... mechanical oranges i guess. And Drugs seems be so strong to stay at ascension. No worry PC just get detox therapy (again). But wait is it more to that all? Maybe some revolution silently started by mages?");
			flags[kFLAGS.AURORA_LVL] = 0;
			if (player.hasPerk(PerkLib.Archmage)) {
				player.removePerk(PerkLib.Archmage);
				player.createPerk(PerkLib.GrandMage, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.GrandArchmage)) {
				player.removePerk(PerkLib.GrandArchmage);
				player.createPerk(PerkLib.Archmage, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.GreyMage)) {
				player.removePerk(PerkLib.GreyMage);
				player.createPerk(PerkLib.GrandArchmage2ndCircle, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.GreyArchmage)) {
				player.removePerk(PerkLib.GreyArchmage);
				player.createPerk(PerkLib.GrandArchmage3rdCircle, 0, 0, 0, 0);
			}
			refundPerk(PerkLib.Convergence);
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 24) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 25;
			clearOutput();
			outputText("I know you all loved been with Neisa but she need to begone but not like begone thot but just begone. As bonus you all will see scene of her leaving that should played at leaving river dungeon assuming your PC already visited it once ^^");
			if (flags[kFLAGS.NEISA_FOLLOWER] == 3) {
				outputText("As the pair of you leave the dungeon Neisa waves off, heading back to town.\n\n");
				outputText("\"<i>Nice going along with you [name], this was worth it. I’m going to go and spend this bling on some well earned reward. See you around up there. If you ever need of my services again I will be at the bar.</i>\"\n\n");
				player.removeStatusEffect(StatusEffects.CombatFollowerNeisa);
				flags[kFLAGS.PLAYER_COMPANION_1] = "";
				flags[kFLAGS.NEISA_FOLLOWER] = 4;
				outputText("Working together with another person has taught you how to manage and plan with a group of people. <b>Gained Perk: Basic Leadership</b>");
				player.createPerk(PerkLib.BasicLeadership, 0, 0, 0, 0);
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 25) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 26;
			clearOutput();
			outputText("For all those poor Jiangshi. Go forth young zombie and be alive again... with a bit of recompesation ;) Also Adventure Guld Quest counters. I heard some of you likes to know how many times you brough those blood dripping imp skulls to our cute panda girl so... here you go.");
			if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] > 1) {
				player.setWeapon(weapons.BFTHSWORD);
				player.setWeaponRange(weaponsrange.AVELYNN);
				player.setShield(shields.DRGNSHL);
				player.setArmor(armors.LAYOARM);
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
				player.skinColor                                 = "light";
				player.faceType                                  = Face.HUMAN;
				player.eyes.type = Eyes.HUMAN;
				player.horns.type = Horns.NONE;
				player.horns.count = 0;
				player.arms.type = Arms.HUMAN;
				player.lowerBody = LowerBody.HUMAN;
				if (player.hasPerk(PerkLib.HaltedVitals)) player.removePerk(PerkLib.HaltedVitals);
				if (player.hasPerk(PerkLib.SuperStrength)) player.removePerk(PerkLib.SuperStrength);
				if (player.hasPerk(PerkLib.PoisonNails)) player.removePerk(PerkLib.PoisonNails);
				if (player.hasPerk(PerkLib.Rigidity)) player.removePerk(PerkLib.Rigidity);
				if (player.hasPerk(PerkLib.LifeLeech)) player.removePerk(PerkLib.LifeLeech);
				if (player.hasPerk(PerkLib.Undeath)) player.removePerk(PerkLib.Undeath);
				if (player.hasPerk(PerkLib.EnergyDependent)) player.removePerk(PerkLib.EnergyDependent);
				if (player.statStore.hasBuff("Energy Vampire")) player.statStore.removeBuffs("Energy Vampire");
				flags[kFLAGS.CURSE_OF_THE_JIANGSHI] = 0;
			}
			if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests1)) {
				player.createStatusEffect(StatusEffects.AdventureGuildQuestsCounter1, 0, 0, 0, 0);
				if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 2) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 1, 1);
				if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 4) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 1, 2);
				if (player.statusEffectv1(StatusEffects.AdventureGuildQuests1) == 7) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 1, 3);
				if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 2) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 2, 1);
				if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 4) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 2, 2);
				if (player.statusEffectv2(StatusEffects.AdventureGuildQuests1) == 7) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 2, 3);
				if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 2) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 3, 1);
				if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 4) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 3, 2);
				if (player.statusEffectv3(StatusEffects.AdventureGuildQuests1) == 7) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter1, 3, 3);
			}
			if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests2)) {
				player.createStatusEffect(StatusEffects.AdventureGuildQuestsCounter2, 0, 0, 0, 0);
				if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 2) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 1, 1);
				if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 4) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 1, 2);
				if (player.statusEffectv1(StatusEffects.AdventureGuildQuests2) == 7) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 1, 3);
				if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 2) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 2, 1);
				if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 4) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 2, 2);
				if (player.statusEffectv2(StatusEffects.AdventureGuildQuests2) == 7) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter2, 2, 3);
			}
			if (player.hasStatusEffect(StatusEffects.AdventureGuildQuests4)) {
				player.createStatusEffect(StatusEffects.AdventureGuildQuestsCounter4, 0, 0, 0, 0);
				if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) == 2) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter4, 1, 1);
				if (player.statusEffectv1(StatusEffects.AdventureGuildQuests4) == 5) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter4, 1, 2);
				if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) == 2) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter4, 2, 1);
				if (player.statusEffectv2(StatusEffects.AdventureGuildQuests4) == 5) player.addStatusValue(StatusEffects.AdventureGuildQuestsCounter4, 2, 2);
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 26) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 27;
			clearOutput();
			outputText("A little Backpack cleanup - nothing to worry about. Or maybe... what will you put into a new and larger inventory? Refound included if necessary.");
			if (player.hasKeyItem("Backpack") >= 0) {
				player.gems += 200 * player.keyItemvX("Backpack", 1);
				player.removeKeyItem("Backpack");
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 27) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 28;
			clearOutput();
			outputText("Titan's into Gigant's, Legends and Myths into Epics and short holidays for game engine ^^");
			if (player.hasPerk(PerkLib.TitanGrip)) {
				player.removePerk(PerkLib.TitanGrip);
				player.createPerk(PerkLib.GigantGrip, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.LegendaryGolemMaker)) {
				player.removePerk(PerkLib.LegendaryGolemMaker);
				player.createPerk(PerkLib.EpicGolemMaker2ndCircle, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.MythicalGolemMaker)) {
				player.removePerk(PerkLib.MythicalGolemMaker);
				player.createPerk(PerkLib.EpicGolemMaker3rdCircle, 0, 0, 0, 0);
			}
			player.updateRacialAndPerkBuffs();
			if (player.blockingBodyTransformations()) {
				if (player.hasPerk(PerkLib.BimboBody)) player.removePerk(PerkLib.BimboBody);
				if (player.hasPerk(PerkLib.BimboBrains)) player.removePerk(PerkLib.BimboBrains);
				if (player.hasPerk(PerkLib.BroBody)) player.removePerk(PerkLib.BroBody);
				if (player.hasPerk(PerkLib.BroBrains)) player.removePerk(PerkLib.BroBrains);
				if (player.hasPerk(PerkLib.FutaForm)) player.removePerk(PerkLib.FutaForm);
				if (player.hasPerk(PerkLib.FutaFaculties)) player.removePerk(PerkLib.FutaFaculties);
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 28) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 29;
			clearOutput();
			outputText("Obligatory save update cuz we not have one of those for... long time ^^ PS. Making Chimera (Mostly) Great Again (After You get New Chimera Perks Naturaly)");
			if (flags[kFLAGS.STAT_GAIN_MODE] == CoC.STAT_GAIN_CLASSIC) {
				if (player.level > 6) player.statPoints += ((5 * player.level) + 60);
				else player.statPoints += (10 * player.level);
			}
			if (player.hasPerk(PerkLib.ChimericalBodySemiAdvancedStage)) {
				player.removePerk(PerkLib.ChimericalBodySemiAdvancedStage);
				player.createPerk(PerkLib.ChimericalBodySemiImprovedStage, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.ChimericalBodyAdvancedStage)) {
				player.removePerk(PerkLib.ChimericalBodyAdvancedStage);
				player.createPerk(PerkLib.ChimericalBodyImprovedStage, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStage)) {
				player.removePerk(PerkLib.ChimericalBodySemiSuperiorStage);
				player.createPerk(PerkLib.ChimericalBodySemiAdvancedStage, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.ChimericalBodySuperiorStage)) {
				player.removePerk(PerkLib.ChimericalBodySuperiorStage);
				player.createPerk(PerkLib.ChimericalBodyAdvancedStage, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.ChimericalBodySemiPeerlessStage)) {
				player.removePerk(PerkLib.ChimericalBodySemiPeerlessStage);
				player.createPerk(PerkLib.ChimericalBodySemiSuperiorStage, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.ChimericalBodyPeerlessStage)) {
				player.removePerk(PerkLib.ChimericalBodyPeerlessStage);
				player.createPerk(PerkLib.ChimericalBodySuperiorStage, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.ChimericalBodySemiEpicStage)) {
				player.removePerk(PerkLib.ChimericalBodySemiEpicStage);
				player.createPerk(PerkLib.ChimericalBodySemiPeerlessStage, 0, 0, 0, 0);
			}
			if (player.perkv1(PerkLib.AscensionWisdom) > 50) {
				var refund1:int = 0;
				refund1 += player.perkv1(PerkLib.AscensionWisdom) - 50;
				player.setPerkValue(PerkLib.AscensionWisdom, 1, 50);
				player.ascensionPerkPoints += refund1;
			}
			var SphereMastery:Number = 10;
			if (player.perkv1(IMutationsLib.KitsuneThyroidGlandIM) >= 3) SphereMastery += 15;
			if (player.perkv1(PerkLib.StarSphereMastery) > SphereMastery) {
				player.gems += (1000 * (player.perkv1(PerkLib.StarSphereMastery) - SphereMastery));
				player.removePerk(PerkLib.StarSphereMastery);
				player.createPerk(PerkLib.StarSphereMastery, SphereMastery, 0, 0, 0);
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 29) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 30;
			clearOutput();
			outputText("Zenji going to town... HARD. Our loved/hated white mare getting bit of help to be what he wanted to be... or something like that. And Fruits... all loves fruits especialy if they giving even more juice, right? RIGHT?");
			if (!player.hasStatusEffect(StatusEffects.ZenjiZList)) player.createStatusEffect(StatusEffects.ZenjiZList, 0, 0, 0, 0);
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) player.createStatusEffect(StatusEffects.TrainingNPCsTimersReduction, 6, 0, 0, 0);
			player.statStore.addBuffObject({
				"str": 5,
				"tou": 5,
				"spe": 5,
				"int": 5,
				"wis": 5,
				"lib": 5
			}, 'EzekielBlessing', { text: 'Ezekiel Blessing' });
			if (flags[kFLAGS.DIANA_FOLLOWER] >= 6 && flags[kFLAGS.DIANA_LVL_UP] < 8) flags[kFLAGS.DIANA_LVL_UP] = 8;
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 30) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 31;
			clearOutput();
			outputText("What time is it? Time to get Re-Collared ^^ Unless you over been wolfy & godly emo collar user. Then no re-collaring for you. Also free bonus secondary stats for everyone. Everyones loves it? Or not? Also let bring Izmael from farm if he stuck there. Tripxi also getting fresh start ;)");
			if (player.hasKeyItem("Fenrir Collar") >= 0) {
				player.removeKeyItem("Fenrir Collar");
				player.createKeyItem("Gleipnir Collar", 0, 0, 0, 0);
			}
			if (player.level > 6) {
				player.HP += (15 * (6 + player.level));
				player.fatigue += (5 * (6 + player.level));
				player.mana += (10 * (6 + player.level));
				player.soulforce += (5 * (6 + player.level));
				player.wrath += (6 + player.level);
				player.lust += (6 + player.level);
			}
			else {
				player.HP += (15 * player.level);
				player.fatigue += (5 * player.level);
				player.mana += (10 * player.level);
				player.soulforce += (5 * player.level);
				player.wrath += player.level;
				player.lust += player.level;
			}
			if (flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 1 && flags[kFLAGS.IZMA_BROFIED] == 1) flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] = 0;
			if (flags[kFLAGS.MARAE_ISLAND] < 1 && flags[kFLAGS.MET_MARAE] == 1) flags[kFLAGS.MARAE_ISLAND] = 1;
			if (player.hasStatusEffect(StatusEffects.TelAdreTripxi)) {
				player.removeStatusEffect(StatusEffects.TelAdreTripxi);
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns1)) player.removeStatusEffect(StatusEffects.TelAdreTripxiGuns1);
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns2)) player.removeStatusEffect(StatusEffects.TelAdreTripxiGuns2);
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns3)) player.removeStatusEffect(StatusEffects.TelAdreTripxiGuns3);
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns4)) player.removeStatusEffect(StatusEffects.TelAdreTripxiGuns4);
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns5)) player.removeStatusEffect(StatusEffects.TelAdreTripxiGuns5);
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns6)) player.removeStatusEffect(StatusEffects.TelAdreTripxiGuns6);
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 31) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 32;
			clearOutput();
			outputText("Matters of heart are... complicated and tangled so we gonna pull them wide till they get all straight like string ^^");
			if (flags[kFLAGS.MARRIAGE_FLAG] == 1) {
				flags[kFLAGS.MARRIAGE_FLAG] = 0;
				flags[kFLAGS.MICHIKO_TALK_MARRIAGE] = 1;
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 32) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 33;
			clearOutput();
			outputText("Less harcore saves been taken out of protection of one save that get deleted on bad end. Metamorph and Transcedental Genetic Memory Perks have been updated. Ascension points for all players who bought Transcedental Genetic Memory Perks will be refunded.");
			if (flags[kFLAGS.GAME_DIFFICULTY] < 2 && flags[kFLAGS.HARDCORE_MODE] == 1) flags[kFLAGS.HARDCORE_MODE] = 0;
			if (player.hasStatusEffect(StatusEffects.RiverDungeonFloorRewards) && player.statusEffectv1(StatusEffects.RiverDungeonFloorRewards) > 2) {
				player.removeStatusEffect(StatusEffects.RiverDungeonFloorRewards);
				player.createStatusEffect(StatusEffects.RiverDungeonFloorRewards, 2, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.GargoylePure) || player.hasPerk(PerkLib.GargoyleCorrupted)) player.createPerk(PerkLib.StrengthOfStone, 0, 0, 0, 0);
			if (player.weapon == weapons.AETHERD && flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 1) flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 2;
			if (player.shield == shields.AETHERS && flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 1) flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 2;
			if (player.hasPerk(PerkLib.Rigidity) && (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 2 || flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 2)) {
				if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 2) {
					flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 1;
					if (player.weapon == weapons.AETHERD) player.unequipWeapon(false,true)
				}
				if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 2) {
					flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 1;
					if (player.shield == shields.AETHERS) player.unequipShield(false,true)
				}
			}
			if (flags[kFLAGS.EVANGELINE_LVL_UP] > 0) flags[kFLAGS.EVANGELINE_LVL_UP] = 0;
			if (flags[kFLAGS.EVANGELINE_DEFEATS_COUNTER] > 0) flags[kFLAGS.EVANGELINE_DEFEATS_COUNTER] = 0;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] > 0) flags[kFLAGS.EVANGELINE_SPELLS_CASTED] = 0;
			if (flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] > 0) flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 0;
			if (flags[kFLAGS.EVANGELINE_02330] > 0) flags[kFLAGS.EVANGELINE_02330] = 0;
			if (flags[kFLAGS.EVANGELINE_02331] > 0) flags[kFLAGS.EVANGELINE_02331] = 0;
			if (flags[kFLAGS.EVANGELINE_02332] > 0) flags[kFLAGS.EVANGELINE_02332] = 0;
			if (flags[kFLAGS.EVANGELINE_02333] > 0) flags[kFLAGS.EVANGELINE_02333] = 0;
			if (player.hasPerk(PerkLib.StrongerElementalBond)) {
				player.removePerk(PerkLib.StrongerElementalBond);
				player.createPerk(PerkLib.StrongElementalBondEx, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.StrongestElementalBond)) {
				player.removePerk(PerkLib.StrongestElementalBond);
				player.createPerk(PerkLib.StrongElementalBondSu, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.StrongestElementalBondEx)) {
				player.removePerk(PerkLib.StrongestElementalBondEx);
				player.createPerk(PerkLib.StrongerElementalBond, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.StrongestElementalBondSu)) {
				player.removePerk(PerkLib.StrongestElementalBondSu);
				player.createPerk(PerkLib.StrongerElementalBondEx, 0, 0, 0, 0);
			}
			// Non-human permanent Metamorphs cost 5 points each
			player.ascensionPerkPoints += player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) * 5;
			player.removeStatusEffect(StatusEffects.TranscendentalGeneticMemory);
			// Upgrade prices
			if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1)) {
				player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1);
				player.ascensionPerkPoints += 15;
			}
			if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage2)) {
				player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage2);
				player.ascensionPerkPoints += 30;
			}
			if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage3)) {
				player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage3);
				player.ascensionPerkPoints += 45;
			}
			if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage4)) {
				player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage4);
				player.ascensionPerkPoints += 60;
			}
			if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage5)) {
				player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage5);
				player.ascensionPerkPoints += 75;
			}
			if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage6)) {
				player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage6);
				player.ascensionPerkPoints += 90;
			}
			// Human permanent Metamorphs cost 25 each, but 5 was already refunded, leaving 20
			if (player.statusEffectv4(StatusEffects.UnlockedHumanHair) == 9000) player.ascensionPerkPoints += 20;
			player.removeStatusEffect(StatusEffects.UnlockedHumanHair);
			if (player.statusEffectv4(StatusEffects.UnlockedHumanFace) == 9000) player.ascensionPerkPoints += 20;
			player.removeStatusEffect(StatusEffects.UnlockedHumanFace);
			if (player.statusEffectv4(StatusEffects.UnlockedHumanEyes) == 9000) player.ascensionPerkPoints += 20;
			player.removeStatusEffect(StatusEffects.UnlockedHumanEyes);
			if (player.statusEffectv4(StatusEffects.UnlockedHumanTongue) == 9000) player.ascensionPerkPoints += 20;
			player.removeStatusEffect(StatusEffects.UnlockedHumanTongue);
			if (player.statusEffectv4(StatusEffects.UnlockedHumanEars) == 9000) player.ascensionPerkPoints += 20;
			player.removeStatusEffect(StatusEffects.UnlockedHumanEars);
			if (player.statusEffectv4(StatusEffects.UnlockedHumanArms) == 9000) player.ascensionPerkPoints += 20;
			player.removeStatusEffect(StatusEffects.UnlockedHumanArms);
			if (player.statusEffectv4(StatusEffects.UnlockedHumanLowerBody) == 9000) player.ascensionPerkPoints += 20;
			player.removeStatusEffect(StatusEffects.UnlockedHumanLowerBody);
			if (player.statusEffectv4(StatusEffects.UnlockedHumanNoHorns) == 9000) player.ascensionPerkPoints += 20;
			player.removeStatusEffect(StatusEffects.UnlockedHumanNoHorns);
			if (player.statusEffectv4(StatusEffects.UnlockedHumanNoWings) == 9000) player.ascensionPerkPoints += 20;
			player.removeStatusEffect(StatusEffects.UnlockedHumanNoWings);
			if (player.statusEffectv4(StatusEffects.UnlockedHumanSkin) == 9000) player.ascensionPerkPoints += 20;
			player.removeStatusEffect(StatusEffects.UnlockedHumanSkin);
			if (player.statusEffectv4(StatusEffects.UnlockedHumanNoSkinPattern) == 9000) player.ascensionPerkPoints += 20;
			player.removeStatusEffect(StatusEffects.UnlockedHumanNoSkinPattern);
			if (player.statusEffectv4(StatusEffects.UnlockedHumanNoAntennae) == 9000) player.ascensionPerkPoints += 20;
			player.removeStatusEffect(StatusEffects.UnlockedHumanNoAntennae);
			if (player.statusEffectv4(StatusEffects.UnlockedHumanNoGills) == 9000) player.ascensionPerkPoints += 20;
			player.removeStatusEffect(StatusEffects.UnlockedHumanNoGills);
			if (player.statusEffectv4(StatusEffects.UnlockedHumanNoRearBody) == 9000) player.ascensionPerkPoints += 20;
			player.removeStatusEffect(StatusEffects.UnlockedHumanNoRearBody);
			if (player.statusEffectv4(StatusEffects.UnlockedHumanNoTail) == 9000) player.ascensionPerkPoints += 20;
			player.removeStatusEffect(StatusEffects.UnlockedHumanNoTail);
			if (player.ascensionPerkPoints > 0) {
				outputText("\n\nYou'll be redirected to the Ascension menu to use your refunded points, then you can either go back to your current game or reincarnate.");
				doNext(CoC.instance.charCreation.updateAscension);
			}
			else {
				outputText("\n\nIt doesn't seem as though you qualify for a refund, though.");
				doNext(SceneLib.camp.campAfterMigration);
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 33) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 34;
			clearOutput();
			outputText("Grey Sage prestige really need to retire... please no cry blood tears it may return in some other form... maybe... Also all Evovlved/Final Form racial mutation perks been reassigned new tiers xD");
			refundPerk(PerkLib.PrestigeJobGreySage);
			if (flags[kFLAGS.DINAH_HIPS_ASS_SIZE] == 1) flags[kFLAGS.DINAH_ASS_HIPS_SIZE] = 1;
			if (flags[kFLAGS.TOUGHNESS_SCALING] != 0) flags[kFLAGS.TOUGHNESS_SCALING] = 0;
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 34) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 35;
			clearOutput();
			outputText("Jiangshi getting Tag'd and your backpack feel somehow cheaper (no worry will get back some gems for it if needed).");
			if (player.hasKeyItem("Backpack") >= 0) player.gems += (150 * player.keyItemvX("Backpack", 1));
			if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0 && AdventurerGuild.lootBag.SlotCaps[0] < 1) {
				outputText(" Very small present from Adventure Guild for having easier to manage all the loot ;)");
				AdventurerGuild.lootBag.SlotCaps[0] = 10;
				AdventurerGuild.lootBag.SlotCaps[1] = 10;
			}
			if (player.hasKeyItem("Adventurer Guild: Iron plate") >= 0 && AdventurerGuild.lootBag.SlotCaps[2] < 1) {
				outputText(" Small present from Adventure Guild for having easier to manage all the loot ;)");
				AdventurerGuild.lootBag.SlotCaps[0] = 10;
				AdventurerGuild.lootBag.SlotCaps[1] = 10;
				AdventurerGuild.lootBag.SlotCaps[2] = 10;
				AdventurerGuild.lootBag.SlotCaps[3] = 10;
			}
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] < 2 && player.hasPerk(PerkLib.NinetailsKitsuneOfBalance) && player.perkv4(PerkLib.NinetailsKitsuneOfBalance) > 0) {
				outputText(" Oops seems your PC get Nine-tails Kitsune of Balance ahead of time... no worry you will get points back and perk permanency will be nullified.");
				player.setPerkValue(PerkLib.NinetailsKitsuneOfBalance, 4, 0);
				player.ascensionPerkPoints += 5;
			}
			if (player.hasPerk(PerkLib.GolemArmyLieutenant) && !player.hasPerk(PerkLib.GolemArmyJuniorLieutenant)) {
				outputText(" We got even smth for all the golem army commnaders. No that just small degradation in ranks to have more glorious and longer reaching path in the future ;)");
				if (player.hasPerk(PerkLib.GolemArmyLieutenant)) {
					player.removePerk(PerkLib.GolemArmyLieutenant);
					player.createPerk(PerkLib.GolemArmyJuniorLieutenant, 0, 0, 0, 0);
				}
				if (player.hasPerk(PerkLib.GolemArmyCaptain)) {
					player.removePerk(PerkLib.GolemArmyCaptain);
					player.createPerk(PerkLib.GolemArmyLieutenant, 0, 0, 0, 0);
				}
				if (player.hasPerk(PerkLib.GolemArmyMajor)) {
					player.removePerk(PerkLib.GolemArmyMajor);
					player.createPerk(PerkLib.GolemArmyCaptain, 0, 0, 0, 0);
				}
				if (player.hasPerk(PerkLib.GolemArmyColonel)) {
					player.removePerk(PerkLib.GolemArmyColonel);
					player.createPerk(PerkLib.GolemArmyMajor, 0, 0, 0, 0);
				}
				if (player.hasPerk(PerkLib.GolemArmyGeneral)) {
					player.removePerk(PerkLib.GolemArmyGeneral);
					player.createPerk(PerkLib.GolemArmyLieutenantColonel, 0, 0, 0, 0);
				}
			}
			if (flags[kFLAGS.SOUL_CULTIVATION] == 1 || flags[kFLAGS.SOUL_CULTIVATION] == 2) flags[kFLAGS.SOUL_CULTIVATION] = 0;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 3) flags[kFLAGS.SOUL_CULTIVATION] -= 2;
			if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation01)) {
				if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX)) player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1, 1);
				else player.createPerk(PerkLib.AscensionAdditionalOrganMutationX, 1, 0, 0, 1);
				player.removePerk(PerkLib.AscensionAdditionalOrganMutation01);
			}
			if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation02)) {
				if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX)) player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1, 2);
				else player.createPerk(PerkLib.AscensionAdditionalOrganMutationX, 2, 0, 0, 1);
				player.removePerk(PerkLib.AscensionAdditionalOrganMutation02);
			}
			if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation03)) {
				if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX)) player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1, 3);
				else player.createPerk(PerkLib.AscensionAdditionalOrganMutationX, 3, 0, 0, 1);
				player.removePerk(PerkLib.AscensionAdditionalOrganMutation03);
			}
			if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutation04)) {
				if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX)) player.setPerkValue(PerkLib.AscensionAdditionalOrganMutationX, 1, 4);
				else player.createPerk(PerkLib.AscensionAdditionalOrganMutationX, 4, 0, 0, 1);
				player.removePerk(PerkLib.AscensionAdditionalOrganMutation04);
			}
			if (player.hasPerk(PerkLib.AscensionBuildingPrestige01)) {
				if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1, 1);
				else player.createPerk(PerkLib.AscensionBuildingPrestigeX, 1, 0, 0, 1);
				player.removePerk(PerkLib.AscensionBuildingPrestige01);
			}
			if (player.hasPerk(PerkLib.AscensionBuildingPrestige02)) {
				if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1, 2);
				else player.createPerk(PerkLib.AscensionBuildingPrestigeX, 2, 0, 0, 1);
				player.removePerk(PerkLib.AscensionBuildingPrestige02);
			}
			if (player.hasPerk(PerkLib.AscensionBuildingPrestige03)) {
				if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1, 3);
				else player.createPerk(PerkLib.AscensionBuildingPrestigeX, 3, 0, 0, 1);
				player.removePerk(PerkLib.AscensionBuildingPrestige03);
			}
			if (player.hasPerk(PerkLib.AscensionBuildingPrestige04)) {
				if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1, 4);
				else player.createPerk(PerkLib.AscensionBuildingPrestigeX, 4, 0, 0, 1);
				player.removePerk(PerkLib.AscensionBuildingPrestige04);
			}
			if (player.hasPerk(PerkLib.AscensionBuildingPrestige05)) {
				if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1, 5);
				else player.createPerk(PerkLib.AscensionBuildingPrestigeX, 5, 0, 0, 1);
				player.removePerk(PerkLib.AscensionBuildingPrestige05);
			}
			if (player.hasPerk(PerkLib.AscensionBuildingPrestige06)) {
				if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)) player.setPerkValue(PerkLib.AscensionBuildingPrestigeX, 1, 6);
				else player.createPerk(PerkLib.AscensionBuildingPrestigeX, 6, 0, 0, 1);
				player.removePerk(PerkLib.AscensionBuildingPrestige06);
			}
			if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] > 0) flags[kFLAGS.CHRISTMAS_TREE_LEVEL]++;
			if (player.hasPerk(PerkLib.Rigidity)) jiangshiBuggedItemsCleanUpCrew();//LAST THING TO DO IN THIS SAVE UPDATE
			doNext(camp.doCamp);
			return;
		}
		if (int(flags[kFLAGS.MOD_SAVE_VERSION]) == 35) { //now using float to store versions!
			clearOutput();
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.001) {
				//SH announcement
				outputText("\n\n<b>New settings page added: SceneHunter. Here, you can enable some flags, making some scenes easier to discover or select.</b>");
				outputText("\n\n<b>If you don't like the view of your armor, you can disable most armors with new button in Display settings.</b>");
				//Labyrinth reward fix
				if (flags[kFLAGS.EBON_LABYRINTH] >= 11)
					flags[kFLAGS.EBON_LABYRINTH] = 600;
				else if (flags[kFLAGS.EBON_LABYRINTH] >= 9)
					flags[kFLAGS.EBON_LABYRINTH] = 450;
				else if (flags[kFLAGS.EBON_LABYRINTH] >= 7)
					flags[kFLAGS.EBON_LABYRINTH] = 300;
				else if (flags[kFLAGS.EBON_LABYRINTH] >= 5)
					flags[kFLAGS.EBON_LABYRINTH] = 150;
				else if (flags[kFLAGS.EBON_LABYRINTH] >= 3)
					flags[kFLAGS.EBON_LABYRINTH] = 50;
				else if (flags[kFLAGS.EBON_LABYRINTH] > 0)
					flags[kFLAGS.EBON_LABYRINTH] = 1;
				//radiant shard fix - now for everyone!
				if (player.hasKeyItem("Radiant shard") < 0) {
					outputText("\n\nNow legendary weapon is crafted from radiant shards. You deserve these!\n");
					outputText("\n\n(If you already have some, please remove them, heh..)\n");
					camp.testmenu.fixShards();
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.001;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.002) {
				//If something needs a fix, abort - not ready to update the version yet!
				if (consumables.E3PEARL.fixSave()) return;
				if (consumables.E5PEARL.fixSave()) return;
				if (consumables.E7PEARL.fixSave()) return;
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.002;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.003) {
				celessScene.fixQuestFinished();
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.003;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.004) {
				if (player.hasPerk(PerkLib.PrestigeJobTempest)) {
					player.removePerk(PerkLib.JobDervish);
					player.perkPoints += 1;
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.004;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.005) {
				if (player.hasPerk(PerkLib.BlessingOfTheAncestorTree)) {
					if (!transformations.EyesElf.isPresent()) {
						outputText("\n\nThe elves couldn't even transform you properly! Fen'Harel blesses you with a pair of proper elven eyes. Now you're also gloomy most of the time as a side effect.")
						transformations.EyesElf.applyEffect(false);
					}
					if (player.skin.base.adj != "flawless") {
						outputText("\n\nYour flawless elves skin was not so flawless! But now it is.");
						player.skin.base.adj = "flawless";
					}
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.005;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.006) {
				flags[kFLAGS.PRISCILLA_THREESOME_COUNTER] = 0; //reset SFW mode flag just in case
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.006;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.007) {
				CoC.instance.inputManager.BindKeyToControl(187, "Font Size+");//Updating to set default keybindings for font zoom/shrink
				CoC.instance.inputManager.BindKeyToControl(189, "Font Size-");
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.007;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.008) { //Sapphire affection adjusted. Need some fixing.
				if (flags[kFLAGS.WEDDINGS_UNLOCKED] == 1) //checked sex before, now transformed to a wedding check.
					flags[kFLAGS.SAPPHIRE_AFFECTION] = 100;
				else if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 5)
					flags[kFLAGS.SAPPHIRE_AFFECTION] = 60;
				else flags[kFLAGS.SAPPHIRE_AFFECTION] *= 10; //should work.
				flags[kFLAGS.WEDDINGS_UNLOCKED] = 0; //was sex
				if (flags[kFLAGS.SAPPHIRE_TALKS] > 3)
					flags[kFLAGS.SAPPHIRE_TALKS] -= 4;
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.008;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.009) {
				if (player.lowerBody == LowerBody.GOO && player.arms.type == Arms.GOO && player.rearBody.type == RearBody.METAMORPHIC_GOO && player.skinAdj != "slimy") player.skinAdj = "slimy";
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.009;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.011) {
				flags[kFLAGS.SCENEHUNTER_LOSS_SELECT] = flags[kFLAGS.SCENEHUNTER_OTHER];
				outputText("\n\nSceneHunter update: new <b>Select Loss</b> feature. Set equal to the 'Other' flag by default. You can toggle its value in settings.");
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.011;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.012) {
				if (player.hasKeyItem("Old Pickaxe") >= 0 && Crafting.BagSlot01Cap < 1) {
					outputText("\n\nSmall present from unnamed person for those that missed precious bag at the time of picking Old Pickaxe ;)");
					Crafting.BagSlot01Cap = 5;
					Crafting.BagSlot02Cap = 5;
					Crafting.BagSlot03Cap = 5;
					Crafting.BagSlot04Cap = 5;
				}
				flags[kFLAGS.PRISCILLA_AFFECTION] = 0; // Reclaim lethicite flag AGAIN. Now used for Priscilla
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.012;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.013) {
				//resetting Sanura riddle flags (already reclaimed)
				flags[kFLAGS.PRISCILLA_WRESTLE_COUNTER] = 0;
				flags[kFLAGS.PRISCILLA_FOREPLAY_COUNTER] = 0;
				flags[kFLAGS.DESERT_CAVE_DISABLED] = 0;
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.013;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.014) {
				if (Crafting.BagSlot01Cap > 0) player.createKeyItem("Tarnished Ore Bag (Lowest grade)", 0, 0, 0, 0);
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.014;
			}
			//35.015 Removed, code is now handled in MutationLib for Mutations Migration.
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.016) {
				if (player.hasMutation(IMutationsLib.GorgonEyesIM)){
					player.HP = player.maxOverHP();
					player.fatigue = 0;
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.016;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.017) {
				//reset flags
				flags[kFLAGS.AYANE_CURE_COOLDOWN] = 0;
				flags[kFLAGS.DIANA_CURE_COOLDOWN] = 0;
				//autofix for old curse bug - AGAIN
				if (player.statStore.hasBuff("Tribulation Vestiges"))
					player.statStore.removeBuffs("Tribulation Vestiges");
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.017;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.018) {
				if (flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] != 0){
					player.setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
					flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = 0;
				}
				if(flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] != 0){
					player.setWeaponRange(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID]) as WeaponRange);
					flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] = 0;
				}
				outputText("\nWeapons duplication from woodelves hunting party should now be fixed.... again.");
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.018;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.019) {
				if (flags[kFLAGS.NEISA_FOLLOWER] >= 10 && flags[kFLAGS.NEISA_FOLLOWER] < 17) flags[kFLAGS.NEISA_FOLLOWER] -= 3;
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.019;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.020) {
				if (flags[kFLAGS.IZUMI_MET] > 0 && !TyrantiaFollower.TyraniaAndIzumi && TyrantiaFollower.TyrantiaFollowerStage > 0) TyrantiaFollower.TyraniaAndIzumi = true;
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.020;
			}
			//Flag cleanup. Add it to the next save update.
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.021) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_2033] = 0;
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_2032] = 0;
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.021;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.022) {
				if (AdventurerGuild.lootBag.SlotCaps[3] >= 5) AdventurerGuild.lootBag.SlotCaps[4] = 10;
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.022;
			}
			flags[kFLAGS.MOD_SAVE_VERSION] = 36.0;
			outputText("\n\n<i>Save</i> version updated to " + flags[kFLAGS.MOD_SAVE_VERSION] + "\n");
			doNext(camp.doCamp);
			return;
		}
		if (int(flags[kFLAGS.MOD_SAVE_VERSION]) == 36) {
			clearOutput();
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.001) {
				if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1)) {
					if (player.hasPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX)) player.setPerkValue(PerkLib.AscensionTrancendentalGeneticMemoryStageX, 1,1);
					else player.createPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX, 1, 0, 0, 1);
					player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1);
				}
				if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage2)) {
					if (player.hasPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX)) player.setPerkValue(PerkLib.AscensionTrancendentalGeneticMemoryStageX, 1,2);
					else player.createPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX,2,0,0,1);
					player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage2);
				}
				if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage3)){
					if (player.hasPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX)) player.setPerkValue(PerkLib.AscensionTrancendentalGeneticMemoryStageX, 1,3);
					else player.createPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX,3,0,0,1);
					player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage3);
				}
				if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage4)){
					if (player.hasPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX)) player.setPerkValue(PerkLib.AscensionTrancendentalGeneticMemoryStageX, 1,4);
					else player.createPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX,4,0,0,1);
					player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage4);
				}
				if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage5)) {
					if (player.hasPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX)) player.setPerkValue(PerkLib.AscensionTrancendentalGeneticMemoryStageX, 1,5);
					else player.createPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX, 5, 0, 0, 1);
					player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage5);
				}
				if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage6)) {
					if (player.hasPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX)) player.setPerkValue(PerkLib.AscensionTrancendentalGeneticMemoryStageX, 1,6);
					else player.createPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX,6,0,0,1);
					player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage6);
				}
				if (player.hasPerk(PerkLib.AscensionHerosLineage)) player.ascensionPerkPoints -= 5;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.001;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.002) {
				flags[kFLAGS.GARGOYLE_QUEST] = flags[kFLAGS.GARGOYLE_QUEST] > 0 ? 1 : 0;
				outputText("\nThe gargoyle quest tracker should be fixed by now. Otherwise, please report it again.");
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.002;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.003) {
				if (player.hasPerk(PerkLib.AscensionNaturalMetamorph) && !player.hasPerk(PerkLib.MetamorphEx)) player.createPerk(PerkLib.MetamorphEx, 0, 0, 0, 0);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.003;
			}
			/*
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.004) { //Cloning this down.
				if (player.hasPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX) && !player.hasStatusEffect(StatusEffects.TranscendentalGeneticMemory)){
					player.createStatusEffect(StatusEffects.TranscendentalGeneticMemory,15 * player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryStageX),0,0,0);
				}
				//trace("Player has "+ player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory) + " slots, and " + player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) + " used.");
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.004;
			}*/
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.005) {
				outputText("\n\nIt will hurt a tiny bit fellow daoists but it's for greater good to cripple our cultivations to start anew.\nPS. I LIED IT HURTS LIKE NINE HELLS AND FOUR HEAVEND... MUAHAHAHAHAHA");
				refundPerk(PerkLib.JobSoulCultivator);
				refundPerk(PerkLib.SoulApprentice);
				refundPerk(PerkLib.SoulPersonage);
				refundPerk(PerkLib.SoulWarrior);
				refundPerk(PerkLib.SoulSprite);
				refundPerk(PerkLib.SoulScholar);
				refundPerk(PerkLib.SoulElder);
				refundPerk(PerkLib.SoulExalt);
				refundPerk(PerkLib.SoulOverlord);
				refundPerk(PerkLib.SoulTyrant);
				refundPerk(PerkLib.SoulKing);
				refundPerk(PerkLib.SoulEmperor);
				refundPerk(PerkLib.SoulAncestor);
				if (flags[kFLAGS.SOUL_CULTIVATION] > 0) flags[kFLAGS.SOUL_CULTIVATION] = 0;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.005;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.006) { //Cloning this down.
				if (player.hasPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX) && !player.hasStatusEffect(StatusEffects.TranscendentalGeneticMemory)) {
					var permedMetamorphCount:int = Metamorph.PermanentMemoryStorage.length;
					player.createStatusEffect(StatusEffects.TranscendentalGeneticMemory, 15 * player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryStageX), permedMetamorphCount, 0, 0);
				}
				refundPerk(PerkLib.Dantain);
				refundPerk(PerkLib.DaoistCultivator);
				refundPerk(PerkLib.DaoistApprenticeStage);
				refundPerk(PerkLib.DaoistWarriorStage);
				refundPerk(PerkLib.DaoistElderStage);
				refundPerk(PerkLib.DaoistOverlordStage);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.006;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.007) { //Cloning this down.
				flags[kFLAGS.WHITNEY_ORAL_TRAINING_VAG] = flags[kFLAGS.WHITNEY_ORAL_TRAINING_COCK]; //new flag!
				camp.testmenu.fixShards2nd();
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.007;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.008) {
				if (flags[kFLAGS.APEX_SELECTED_RACE] >= 18) flags[kFLAGS.APEX_SELECTED_RACE] += 1;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.008;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.009) {
				if (player.furColor == "lilac and white striped") player.furColor = "lilac and white";
				if (player.hairColor == "lilac and white striped") player.hairColor = "lilac and white";
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.009;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.010) {
				flags[kFLAGS.FROSTY_TIMES_SPANKED] = 0; //reset the flag
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.010;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.011) {
				flags[kFLAGS.SCYLLA_CATS_RECALL_TRACKER] = 0; //new flag
				if (flags[kFLAGS.MINERVA_PURE_TALKED_CORRUPTION] == 1) flags[kFLAGS.SEX_MACHINE_STATUS] = -1; //sex machine disabled using its status now
				flags[kFLAGS.MINERVA_PURE_TALKED_CORRUPTION] = 0; //cleanup
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.011;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.012) {
				if (player.statStore.hasBuff("Drained")) player.statStore.removeBuffs("Drained");
				if (flags[kFLAGS.MALI_BLADE_STATUS] == 1) { //old status = 'MALI BLADE GIVEN'
					flags[kFLAGS.DOMINIKA_COVENANT] = 3; //stop Dominika encounters
					outputText("\n\nDominika 'quest' is kinda finished. No epic battle for you, but you can finally visit Mali and take your tiny reward for giving up the fellatrix.");
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.012;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.013) {
				//Reclaimed flag cleanup. Just leaving it here until the next save update.
				flags[kFLAGS.HELSPAWN_HADSEX] = 0;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.013;
				outputText("<b>SceneHunter - new feature, 'Mock Fights', allowing to replay win/lose rape scenes with camp NPCs. Also, Loss Select wasn't properly saving its value outside of the save - fixed now.</b>")
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.014) {
				// Reorder SPP (Old slot unlock order: 56-69, 0-55, 70-97; new is 0-97)
				var spp:/*ItemSlotClass*/Array = inventory.pearlStorageDirectGet();
				var n:int = 0, sz:int = inventory.pearlStorageSize(), nl:int = 0;
				if (sz > 0 && sz < 70) {
					for (var i:int = 56; i < 70; i++) {
						if (spp[i].quantity > 0) {
							for (var j:int = 0; j < i; j++) {
								if (spp[j].isEmpty()) {
									spp[j].setItemAndQty(spp[i].itype, spp[i].quantity)
									spp[i].emptySlot();
									if (j < sz) n++; // moved to unlocked slot
									else nl++; // moved to locked slot
								}
							}
						}
					}
					if (n>0) outputText("\n"+n+" item(s) moved from locked Sky Poison Pearl central section to the empty space at the beginning.");
					if (nl>0) outputText("\nCouldn't move "+nl+" item(s) from locked Sky Poison Pearl central section; they are moved to next section to be unlocked.");
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.014;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.015) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00390] = 0; //Cleaning some temporal Hel flags
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00392] = 0;
				if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) player.removePerk(PerkLib.HclassHeavenTribulationSurvivor);
				if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) player.removePerk(PerkLib.GclassHeavenTribulationSurvivor);
				if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) player.removePerk(PerkLib.FclassHeavenTribulationSurvivor);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.015;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.016) {
				flags[kFLAGS.MINERVA_CORRRUPTED_HARPY_COUNTER] = 0; //Isabella old flag cleanup.
				if (player.hasStatusEffect(StatusEffects.PCClone)) player.removeStatusEffect(StatusEffects.PCClone);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.016;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.017) {
				// convert old buff tags to new ("item_"+itemid)
				const ItemBuffsRename:Array = [
					["RingOfWisdom", jewelries.RINGWIS.tagForBuffs],
					["RingOfToughness", jewelries.RINGTOU.tagForBuffs],
					["RingOfStrength", jewelries.RINGSTR.tagForBuffs],
					["RingOfSpeed", jewelries.RINGSPE.tagForBuffs],
					["RingOfLibido", jewelries.RINGLIB.tagForBuffs],
					["RingOfSensitivity", jewelries.RINGSEN.tagForBuffs],
					["RingOfIntelligence", jewelries.RINGINT.tagForBuffs],
				];
				for each (var pair:Array in ItemBuffsRename) {
					// buffs are re-created on save load with afterEquip fn
					player.buff(pair[0]).remove();
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.017;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.018) {
				if (player.hasPerk(PerkLib.StaffChanneling)) flags[kFLAGS.STAFF_CHANNELING_MODE] = 1;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.018;
				outputText("\nStaff channeling can now be disabled!");
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.019) {
				dildoFix();
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.019;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.020) {
				if (Forgefather.refinement > 0) Forgefather.refinement -= 1;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.020;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.022) {
				// these buffs are recreated on save load
				const ItemBuffsRemove:Array = [
					jewelries.RINGWIS.tagForBuffs,
					jewelries.RINGTOU.tagForBuffs,
					jewelries.RINGSTR.tagForBuffs,
					jewelries.RINGSPE.tagForBuffs,
					jewelries.RINGLIB.tagForBuffs,
					jewelries.RINGSEN.tagForBuffs,
					jewelries.RINGINT.tagForBuffs,
					'CrownOfIntelligence',
					'CrownOfLibido',
					'CrownOfSensitivity',
					'CrownOfSpeed',
					'CrownOfStrength',
					'CrownOfToughness',
					'CrownOfWisdom',
					'NecklaceOfIntelligence',
					'NecklaceOfLibido',
					'NecklaceOfSensitivity',
					'NecklaceOfSpeed',
					'NecklaceOfStrength',
					'NecklaceOfToughness',
					'tag', // necklace of wisdom
					'DemonicMageTailOrnament',
					"Ayo Armor",
				];
				for each (var tag:String in ItemBuffsRemove) {
					for each (var buff:Buff in player.buff(tag).findAllBuffObjects()) {
						if (buff.save) {
							buff.stat.removeBuff(tag);
						} else if (initialVersion >= 36.017) {
							// if pc had a ring +20 sens (save=true)
							// after update ring afterEquip gave +20 sens (save=false)
							buff.stat.addOrIncreaseBuff(tag, -buff.value/2);
						}
					}
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.022;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.023) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_02591] = 0; //cleanup luna mooning flag
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.023;
				if (flags[kFLAGS.MET_MARAE_CORRUPTED] == 2) flags[kFLAGS.MET_MARAE_CORRUPTED] = 1; //revert Lethicite stuff
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.024) {
				refundPerk(PerkLib.BodyCultivator);
				refundPerk(PerkLib.FleshBodyApprenticeStage);
				refundPerk(PerkLib.FleshBodyWarriorStage);
				refundPerk(PerkLib.FleshBodyElderStage);
				refundPerk(PerkLib.FleshBodyOverlordStage);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.024;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.025) {
				// Split existing core stats into core + train
				// - Refund core points
				// - Compute how much total training pc did
				// - Try to re-allocate training, maintain the ratio between stats
				var primaryStats:/*PrimaryStat*/Array = [player.strStat,player.touStat,player.speStat,player.intStat,player.wisStat,player.libStat];
				var oldCoreTotal:int = 0;
				var oldCoreStats:/*int*/Array = [0,0,0,0,0,0];
				outputText("\n\nStat rework! Training is separated from level-up, <b>but benefits less from multipliers</b>.\nOld core stat values:")
				for (i = 0; i < primaryStats.length; i++) {
					var stat:PrimaryStat = primaryStats[i];
					oldCoreTotal += stat.core.value;
					oldCoreStats[i] = stat.core.value;
					outputText(" "+stat.core.value);
					stat.core.value = 0;
				}
				outputText(" = total "+oldCoreTotal+".");
				// Compute total stat points spent
				var statPointsPerLevel:int = 5 + (player.perkv1(PerkLib.AscensionAdvTrainingX));
				var statPoints:int = player.level*statPointsPerLevel;
				if (player.level <= 6) statPoints += player.level * statPointsPerLevel;
				else statPoints += 6*statPointsPerLevel;
				statPoints -= player.statPoints;
				statPoints -= JourneyToTheEast.AhriStatsToPerksConvertCounter*5;
				statPoints += JourneyToTheEast.EvelynnPerksToStatsConvertCounter * 5;
				if (flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] == 2) statPoints += 10;
				if (flags[kFLAGS.DEFEATED_ZETAZ] > 1) statPoints += 20;
				if (flags[kFLAGS.LETHICE_DEFEATED] > 1) statPoints += 30;
				if (flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] == 2) statPoints += 5;
				if (flags[kFLAGS.CLEARED_HEL_TOWER] == 2) statPoints += 10;
				if (flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] == 3) statPoints += 10;
				if (flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] == 6) statPoints += 5;
				if (flags[kFLAGS.HIDDEN_CAVE_BOSSES] == 3) statPoints += 5;
				if (flags[kFLAGS.DEN_OF_DESIRE_QUEST] == 2) statPoints += 15;
				if (player.hasStatusEffect(StatusEffects.RiverDungeonFloorRewards)) statPoints += 5 * player.statusEffectv1(StatusEffects.RiverDungeonFloorRewards);
				if (flags[kFLAGS.EBON_LABYRINTH] >= 50) statPoints += 5;
				statPoints += int(flags[kFLAGS.EBON_LABYRINTH]/150) * 5;
				var totalTrainPoints:int = oldCoreTotal - statPoints;
				var remainingTrainPoints:int = totalTrainPoints;
				// Re-allocate training stats, maintaining ratio
				for (i = 0; i < primaryStats.length; i++) {
					stat = primaryStats[i];
					// ratio
					var x:Number = (oldCoreStats[i] - 15) / (oldCoreTotal - 6 * 15);
					// don't train over max or old value
					x = Math.min(stat.train.max, 15 + int(x*(totalTrainPoints-6*15)), oldCoreStats[i]);
					remainingTrainPoints -= x;
					stat.train.value = x;
				}
				// Leftover points
				while (remainingTrainPoints > 0) {
					// Count trainable stats (not maxed, below old value) and split reamining points evenly
					n = 0;
					for (i = 0; i < primaryStats.length; i++) {
						stat = primaryStats[i];
						if (stat.train.value < stat.train.max && stat.train.value < oldCoreStats[i]) n++;
					}
					if (n == 0) break;
					for (i = 0; i < primaryStats.length; i++) {
						stat = primaryStats[i];
						if (stat.train.value < stat.train.max && stat.train.value < oldCoreStats[i]) {
							x = int(remainingTrainPoints/n+0.999); // round up
							// don't train over max or old value
							x = Math.min(x, stat.train.max - stat.train.value, oldCoreStats[i] - stat.train.value);
							if (x > 0) {
								stat.train.value += x;
								remainingTrainPoints -= x;
								n--;
							}
						}
					}
				}
				outputText("\nRe-allocated " + (totalTrainPoints - remainingTrainPoints) + " training points:");
				for (i = 0; i < primaryStats.length; i++) {
					outputText(" "+primaryStats[i].train.value);
				}
				player.statPoints += statPoints;
				outputText("\n\n<b>You have " + statPoints + " stat points refunded. Don't forget to allocate them</b>.");
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.025;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.026) {
				flags[kFLAGS.AMILY_CLOTHING] = flags[kFLAGS.AMILY_CLOTHING] == "comfortable clothes" ? 1 : 0;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.026;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.027) {
				if (player.hasStatusEffect(StatusEffects.Exgartuan)) {
					outputText("\n\nIf you don't like the way your PC date is checked for in-game events and holidays, you can now switch to another mode - in-game month and year will be calculated based on the days counter. Check the game settings.")
					outputText("\n\nHey, Exgartuan fans! You can now have demons in your dick and boobs at the same time!");
					if (player.statusEffectv1(StatusEffects.Exgartuan) == 1) player.changeStatusValue(StatusEffects.Exgartuan, 3, 0);
					else {
						outputText("\n... Ah, one more thing. Your breast demon is called Xenora now.");
						player.changeStatusValue(StatusEffects.Exgartuan, 3, player.statusEffectv2(StatusEffects.Exgartuan));
						player.changeStatusValue(StatusEffects.Exgartuan, 2, 0);
					}
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.027;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.028) {
				if (flags[kFLAGS.SHEILA_XP] == 4) {
					outputText("\n\nHey, did Sheila tell you her real name? If you haven't stayed with her... well, sorry for you. It's Harriet. Let's use it from now!");
					flags[kFLAGS.KNOWS_SHEILA_NAME] = 1; //free Damage Overhaul flag
				} else flags[kFLAGS.KNOWS_SHEILA_NAME] = 0;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.028;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.029) {
				if (flags[kFLAGS.MARRIAGE_FLAG] == "Zenji") flags[kFLAGS.ZENJI_PROGRESS] = 12; //SH Zenji tweak.
				flags[kFLAGS.SCENEHUNTER_POLYGAMY] = 0; //init, just in case
				if (flags[kFLAGS.MARRIAGE_FLAG]) sceneHunter.marry(flags[kFLAGS.MARRIAGE_FLAG]); //will add the current spouse to the flag
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.029;
				outputText("SceneHunter: new option, 'Polygamy'. Works only when a save is loaded. Ah, and don't worry about the status effect error, I removed it.");
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.030) {
				if (!player.hasPerk(PerkLib.CursedTag)) {
					if (player.hasStatusEffect(StatusEffects.AlterBindScroll1)) player.removeStatusEffect(StatusEffects.AlterBindScroll1);
					if (player.hasStatusEffect(StatusEffects.AlterBindScroll2)) player.removeStatusEffect(StatusEffects.AlterBindScroll2);
					if (player.hasStatusEffect(StatusEffects.AlterBindScroll3)) player.removeStatusEffect(StatusEffects.AlterBindScroll3);
					if (player.hasStatusEffect(StatusEffects.AlterBindScroll4)) player.removeStatusEffect(StatusEffects.AlterBindScroll4);
					if (player.hasStatusEffect(StatusEffects.AlterBindScroll5)) player.removeStatusEffect(StatusEffects.AlterBindScroll5);
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.030;
				outputText("\n\nPeacefull extractions of any Jiangshi remains.");
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.031) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00477] = 0;
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_01043] = 0;
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_02600] = 0;
				if (HelSpawnScene.incestEnabled() && flags[kFLAGS.HAD_FIRST_HELSPAWN_TALK]) { //printed only for "our" people in debug version
					flags[kFLAGS.HELSPAWN_INCEST] = 1;
					outputText("\n\nCheck on Helspawn - some cut content got restored.");
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.031;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.032) {
				refundPerk(PerkLib.WeaponClawsClawTraining);
				refundPerk(PerkLib.WeaponClawsExtraClawAttack);
				refundPerk(PerkLib.WeaponClawsMultiClawAttack);
				refundPerk(PerkLib.WeaponClawsClawingFlurry);
				refundPerk(PerkLib.WeaponClawsSavageRend);
				refundPerk(PerkLib.WeaponLargeDoubleAttack);
				refundPerk(PerkLib.WeaponLargeTripleAttack);
				refundPerk(PerkLib.WeaponNormalDoubleAttack);
				refundPerk(PerkLib.WeaponNormalTripleAttack);
				refundPerk(PerkLib.WeaponNormalQuadrupleAttack);
				refundPerk(PerkLib.WeaponNormalPentaAttack);
				refundPerk(PerkLib.WeaponNormalHexaAttack);
				refundPerk(PerkLib.WeaponNormalPentaAttack);
				refundPerk(PerkLib.WeaponSmallDoubleAttack);
				refundPerk(PerkLib.WeaponSmallTripleAttack);
				refundPerk(PerkLib.WeaponSmallQuadrupleAttack);
				refundPerk(PerkLib.WeaponSmallPentaAttack);
				refundPerk(PerkLib.WeaponSmallHexaAttack);
				refundPerk(PerkLib.WeaponSmallHectaAttack);
				refundPerk(PerkLib.WeaponSmallOctaAttack);
				refundPerk(PerkLib.WeaponSmallNonaAttack);
				refundPerk(PerkLib.WeaponSmallDecaAttack);
				outputText("\n\nMulti-attack perks have been refunded.");
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.032;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.033) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_02358] = 0; //reclaiming soulforce flag
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00773] = 1; //reclaiming essy flag
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_02973] = 1; //reclaiming no gore flag (wasn't used)
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.033;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.034) {
				// reclaiming prison flags just in case
				for (var prisonFlag:int = kFLAGS.UNKNOWN_FLAG_NUMBER_02141; prisonFlag <= kFLAGS.NADIA_FOLLOWER; ++prisonFlag)
					flags[prisonFlag] = 0;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.034;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.035) {
				// removing vags of holding
				if (player.statusEffectv1(StatusEffects.BonusVCapacity) >= 9000)
					player.addStatusValue(StatusEffects.BonusVCapacity, 1, -9000);
				if (player.statusEffectv1(StatusEffects.BonusVCapacity) >= 8000)
					player.addStatusValue(StatusEffects.BonusVCapacity, 1, -8000);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.035;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.036) {
				if (player.statusEffectv1(StatusEffects.Kelt) >= 100) player.changeStatusValue(StatusEffects.Kelt, 1, 100);
				if (player.statusEffectv1(StatusEffects.Kindra) >= 150) player.changeStatusValue(StatusEffects.Kindra,1,150);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.036;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.037) {
				// clones retroactive fix
				for (var cloneMax:int = Soulforce.clones.length - 1; cloneMax >= 0; --cloneMax) {
					if (player.hasStatusEffect(Soulforce.clones[cloneMax])) {
						for (var cloneNum:int = 0; cloneNum < cloneMax; ++cloneNum) {
							if (!player.hasStatusEffect(Soulforce.clones[cloneNum]))
								player.createStatusEffect(Soulforce.clones[cloneNum], 0, 0, 0, 0);
						}
					}
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.037;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.038) {
				if (flags[kFLAGS.IZUMI_LVL_UP] > 1) flags[kFLAGS.IZUMI_LVL_UP] -= 2;
				if (flags[kFLAGS.MINERVA_LVL_UP] > 1) flags[kFLAGS.MINERVA_LVL_UP] -= 2;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.038;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.039) {
				if (flags[kFLAGS.LOPPE_KIDS_LIMIT] == 0) flags[kFLAGS.LOPPE_KIDS_LIMIT] = 8;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.039;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.040) {
				if (flags[kFLAGS.LETHICE_DEFEATED] == 2) {
					player.perkPoints += 2;
					player.statPoints += 10;
					statScreenRefresh();
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.040;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.041) {
				if (player.isRace(Races.CERBERUS)) player.createPerk(PerkLib.TransformationImmunity2, 3, 0, 0, 0);
				if (player.hasPerk(PerkLib.TransformationImmunityAtlach)) {
					player.removePerk(PerkLib.TransformationImmunityAtlach);
					if (player.isRace(Races.ATLACH_NACHA)) player.createPerk(PerkLib.TransformationImmunity2, 1, 0, 0, 0);
					else player.createPerk(PerkLib.TransformationImmunity2, 2, 0, 0, 0);
				}
				if (player.hasPerk(PerkLib.TransformationImmunityFairy)) player.createPerk(PerkLib.TransformationImmunity2, 4, 0, 0, 0);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.041;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.042) {
				if (player.hasPerk(PerkLib.HellfireCoat) && !player.hasPerk(PerkLib.TransformationImmunity2)) player.createPerk(PerkLib.TransformationImmunity2, 3, 0, 0, 0);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.042;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.043) {
				if (player.hasPerk(PerkLib.Soulless)) bringBackEncoutersForSouless();
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.043;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.044) {
				if (player.hasPerk(PerkLib.Soulless)) player.skinColor2 = "midnight black";
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.044;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.045) {
				if (flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] == 2) player.superPerkPoints++;
				if (flags[kFLAGS.DEFEATED_ZETAZ] == 2) player.superPerkPoints++;
				if (flags[kFLAGS.DEMON_LABORATORY_DISCOVERED] == 2) player.superPerkPoints++;
				if (flags[kFLAGS.LETHICE_DEFEATED] == 2) player.superPerkPoints++;
				outputText("\n\nAdditional smol really smol bonus reward for those that not forget to progress main quest - 1 super perk per each finished main story dungeon ^^");
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.045;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.046) {
				if (flags[1320] > 0) {
					player.createStatusEffect(StatusEffects.TookImpTome, 0, 0, 0, 0);
					flags[1320] = 0;
				}
				if (!player.hasStatusEffect(StatusEffects.TookImpTome) && (player.hasItem(shields.IMPTOME) || player.shieldName == "cursed Tome of Imp"))
					player.createStatusEffect(StatusEffects.TookImpTome,  0, 0, 0, 0);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.046;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.047) {
				if (player.level > 0) {
					player.statPoints += 20;
					player.perkPoints += 4;
				}
				if (player.level > 6) {
					if (player.level < 9) {
						player.statPoints += (player.level - 6) * 5;
						player.perkPoints += (player.level - 6);
					}
					else {
						player.statPoints += 15;
						player.perkPoints += 3;
					}
				}
				outputText("\n\nAnother really smol bonus to spare stat/perk points for the starting phase of the adventure ^^");
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.047;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.048) {
				if (player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)) player.vaginaType(VaginaClass.BEE);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.048;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.049) {
				if (player.hasKeyItem("Pocket Watch") >= 0) {
					player.createStatusEffect(StatusEffects.MergedPerksCount, 0, 0, 0, 0);
					if (player.hasPerk(PerkLib.DaoOfTheElements)) player.addStatusValue(StatusEffects.MergedPerksCount, 1, 4);
					if (player.hasPerk(PerkLib.ElementalConjurerMindAndBodyResolveEx)) player.addStatusValue(StatusEffects.MergedPerksCount, 1, 1);
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.049;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.050) {
				if (player.hasPerk(PerkLib.ElementalContractRank2) || flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] > 0) {
					var acv:Number = 0;
					if (player.hasPerk(PerkLib.ElementalContractRank4) || (player.hasPerk(PerkLib.DaoOfTheElements))) acv += 1;
					if (player.hasPerk(PerkLib.ElementalContractRank8) || (player.hasPerk(PerkLib.DaoOfTheElements) && player.perkv1(PerkLib.DaoOfTheElements) == 2)) acv += 1;
					if (player.hasPerk(PerkLib.ElementalContractRank12)) acv += 1;
					if (player.hasPerk(PerkLib.ElementalContractRank16)) acv += 1;
					if (player.hasPerk(PerkLib.ElementalContractRank20)) acv += 1;
					if (player.hasPerk(PerkLib.ElementalContractRank24)) acv += 1;
					if (player.hasPerk(PerkLib.ElementalContractRank28)) acv += 1;
					player.createStatusEffect(StatusEffects.ArcaneCircle, acv, 0, 0, 0);
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.050;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.051) {
				if (player.hasStatusEffect(StatusEffects.ElementalEnergyConduits)) {
					var capacityIncrease:Number = player.statusEffectv2(StatusEffects.ElementalEnergyConduits) * 0.5;
					player.addStatusValue(StatusEffects.ElementalEnergyConduits, 2, capacityIncrease);
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.051;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.052) {
				if (flags[kFLAGS.ISABELLA_FOLLOWER_ACCEPTED] == 1) {
					if (player.hasKeyItem("Radiant shard") >= 0) player.addKeyValue("Radiant shard",1,+1);
					else player.createKeyItem("Radiant shard", 1,0,0,0);
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.052;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.053) {
				SceneLib.setItemsChecks.equipNecroItemsSet();
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.053;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.054) {
				if (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] > camp.campMake.maxPermanentImprovedStoneGolemsBagSize()) {
					var costback1:Number = (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] - camp.campMake.maxPermanentImprovedStoneGolemsBagSize());
					flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] -= costback1;
					flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] += (costback1 * 3);
					flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES] += costback1;
					flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += (costback1 * 50);
				}
				if (flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] > camp.campMake.maxPermanentSteelGolemsBagSize()) {
					var costback2:Number = (flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] - camp.campMake.maxPermanentSteelGolemsBagSize());
					flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] -= costback2;
					flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] += costback2;
					flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES] += (costback2 * 2);
					flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] += (costback2 * 10);
					flags[kFLAGS.CAMP_CABIN_MECHANISM_RESOURCES] += (costback2 * 4);
				}
				if (flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] > camp.campMake.maxPermanentImprovedSteelGolemsBagSize()) {
					var costback3:Number = (flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] - camp.campMake.maxPermanentImprovedSteelGolemsBagSize());
					flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] -= costback3;
					flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] += (costback3 * 3);
					flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES] += (costback3 * 6);
					flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] += (costback3 * 50);
					flags[kFLAGS.CAMP_CABIN_MECHANISM_RESOURCES] += (costback3 * 12);
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.054;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.055) {
				player.buff("Curse").remove();
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.055;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.056) {
				var refound:Number = 0;
				if (player.hasPerk(PerkLib.FleshBodyApprenticeStage)) {
					refound += 21;
				}
				if (player.hasPerk(PerkLib.FleshBodyWarriorStage)) {
					refound += 91;
				}
				if (player.hasPerk(PerkLib.FleshBodyElderStage)) {
					refound += 411;
				}
				if (player.hasPerk(PerkLib.FleshBodyOverlordStage)) {
					refound += 2231;
				}
				if (refound > 0) {
					player.flags[kFLAGS.SPIRIT_STONES] += refound;
					outputText("\n\nReally smol refound ("+refound+" SS) for those that went into body cultivation path. ^^");
				}
				if (player.hasPerk(PerkLib.ICastAsuraFist) && !player.hasPerk(PerkLib.AsuraStrength)) {
					player.removePerk(PerkLib.ICastAsuraFist);
					player.superPerkPoints += 1;
				}
				if (player.hasPerk(PerkLib.AsuraStrength)) {
					player.removePerk(PerkLib.AsuraStrength);
					player.superPerkPoints += 1;
				}
				if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) {
					player.removePerk(PerkLib.LikeAnAsuraBoss);
					player.superPerkPoints += 1;
				}
				if (player.hasPerk(PerkLib.YourPainMyPower)) {
					player.removePerk(PerkLib.YourPainMyPower);
					player.superPerkPoints += 1;
				}
				if (player.hasPerk(PerkLib.MyBloodForBloodPuppies)) {
					player.removePerk(PerkLib.MyBloodForBloodPuppies);
					player.superPerkPoints += 1;
				}
				if (player.hasPerk(PerkLib.BloodDemonToughness)) {
					player.removePerk(PerkLib.BloodDemonToughness);
					player.superPerkPoints += 1;
				}
				if (player.hasPerk(PerkLib.HyperCasting)) {
					player.removePerk(PerkLib.HyperCasting);
					player.superPerkPoints += 1;
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.056;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.057) {
				if (player.hasPerk(PerkLib.PiercedIcestone))
					player.buff("PiercedIcestone").setStat("minlustx", player.perkv1(PerkLib.PiercedIcestone)*-0.01).withText("Icestone piercing");
				if (player.hasPerk(PerkLib.PiercedCrimstone))
					player.buff("PiercedCrimstone").setStat("minlustx", player.perkv1(PerkLib.PiercedCrimstone)*0.01).withText("Crimstone piercing");
				if (player.hasPerk(PerkLib.PentUp))
					player.buff("PentUp").setStat("minlustx", player.perkv1(PerkLib.PentUp)*0.01).withText("Pent up");
				if (player.hasStatusEffect(StatusEffects.AnemoneArousal))
					player.buff("AnemoneArousal").setStat("minlustx", 0.3).withText("Anemone parasite");
				if (player.hasStatusEffect(StatusEffects.BlessingOfDivineFera))
					player.buff("FerasBlessing").setStat("minlustx", 0.15).forHours(player.statusEffectv1(StatusEffects.BlessingOfDivineFera)).withText("Fera's Blessing");
				if (player.hasStatusEffect(StatusEffects.BimboChampagne))
					player.buff("BimboChampagne").setStat("minlustx", 0.1).forHours(player.statusEffectv1(StatusEffects.BimboChampagne)).withText("Bimbo Champagne");
				if (player.hasStatusEffect(StatusEffects.Infested))
					player.buff("Infested").setStat("minlustx", 0.5).withText("Worm Infested");
				if (player.hasStatusEffect(StatusEffects.Luststick))
					player.buff("Luststick").setStat("minlustx", 0.5).forHours(player.statusEffectv1(StatusEffects.Luststick));
				if (player.hasPerk(PerkLib.Lycanthropy))
					player.buff("Lycanthropy").setStat("minlustx", player.perkv1(PerkLib.Lycanthropy)*0.01);
				if (player.statStore.hasBuff("DrunkenPowerEmpower"))
					player.buff("DrunkenPowerEmpower").setStat("minlust", 0.5).withText("Easter Bunny Balls");
				if(player.eggs() >= 40) player.buff("EggFever").setStat("minlust", 0.2).withText("Egg Fever");
				else if(player.eggs() >= 20) player.buff("EggFever").setStat("minlust", 0.1).withText("Egg Fever");
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.057;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.058) {
				// deepwoods, boat - handled by onUnknownStatusEffect()
				// explore, forestOuter, forestInner, lake, desertOuter - handled by postLoadSaveObject()
				SceneLib.exploration.counters.desertInner         = flags[kFLAGS.WEREFOX_EXTRAS];
				SceneLib.exploration.counters.battlefieldBoundary = flags[kFLAGS.DISCOVERED_BATTLEFIELD_BOUNDARY];
				SceneLib.exploration.counters.battlefieldOuter    = flags[kFLAGS.DISCOVERED_OUTER_BATTLEFIELD];
				// mountainsMid - handled by postLoadSaveObject()
				SceneLib.exploration.counters.hills               = flags[kFLAGS.DISCOVERED_HILLS];
				SceneLib.exploration.counters.mountainsLow        = flags[kFLAGS.DISCOVERED_LOW_MOUNTAIN];
				SceneLib.exploration.counters.highMountains       = flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN];
				SceneLib.exploration.counters.plains              = flags[kFLAGS.UNKNOWN_FLAG_NUMBER_0131];
				SceneLib.exploration.counters.swamp               = flags[kFLAGS.UNKNOWN_FLAG_NUMBER_0272];
				SceneLib.exploration.counters.bog                 = flags[kFLAGS.BOG_EXPLORED];
				SceneLib.exploration.counters.blightRidge         = flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE];
				SceneLib.exploration.counters.defiledRavine       = flags[kFLAGS.DISCOVERED_DEFILED_RAVINE];
				SceneLib.exploration.counters.beach               = flags[kFLAGS.DISCOVERED_BEACH];
				SceneLib.exploration.counters.ocean               = flags[kFLAGS.DISCOVERED_OCEAN];
				SceneLib.exploration.counters.caves               = flags[kFLAGS.DISCOVERED_CAVES];
				SceneLib.exploration.counters.tundra              = flags[kFLAGS.DISCOVERED_TUNDRA];
				SceneLib.exploration.counters.glacialRiftOuter    = flags[kFLAGS.UNKNOWN_FLAG_NUMBER_2059];
				SceneLib.exploration.counters.ashlands            = flags[kFLAGS.DISCOVERED_ASHLANDS];
				SceneLib.exploration.counters.volcanicCragOuter   = flags[kFLAGS.UNKNOWN_FLAG_NUMBER_2060];
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.058;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.059) {
				outputText("\n\nFree alchemy skill lvl-up's for pc's with alchemy background. Wohooo you're going into 5 lvl alchemy territory.");
				if ((player.hasPerk(PerkLib.HistoryAlchemist) || player.hasPerk(PerkLib.PastLifeAlchemist)) && player.alchemySkillStat.level < 5) {
					player.alchemySkillStat.level = 5;
					player.alchemySkillStat.xp = 0;
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.059;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.060) {
				outputText("\n\nSeparating 'white and brown'-like pigments in two.");
				// Fix "x and y" pigments in stock
				var pigmentStock:Object = Crafting.pigmentStock;
				for each (var s:String in keys(pigmentStock)) {
					if (s.indexOf(" and ") > 0) {
						var c1:String = s.substring(0, s.indexOf(" and "));
						var c2:String = s.substring(s.indexOf(" and ") + 5);
						SceneLib.crafting.addPigment(c1, pigmentStock[s]);
						SceneLib.crafting.addPigment(c2, pigmentStock[s]);
						delete pigmentStock[s];
					}
				}
				// Fix "x and y" pigments in knowledge
				var ingredientKnowledge:Object = Crafting.ingredientKnowledge;
				for each (var item:String in keys(ingredientKnowledge)) {
					var pigmentKnowledge:Object = ingredientKnowledge[item][AlchemyLib.RT_PIGMENT];
					if (!pigmentKnowledge) continue;
					for each (s in keys(pigmentKnowledge)) {
						if (s.indexOf(" and ") > 0) {
							c1 = s.substring(0, s.indexOf(" and "));
							c2 = s.substring(s.indexOf(" and ") + 5);
							pigmentKnowledge[c1] = true;
							pigmentKnowledge[c2] = true;
							delete pigmentKnowledge[s];
						}
					}
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.060;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.070) {
				outputText("\n\nIf you not werewolf nothing to worry here...");
				if (player.hasPerk(PerkLib.Lycanthropy)) {
					var ngM:Number = (player.newGamePlusMod() + 1);
					var bonusStats2:Number = 0;
					if (flags[kFLAGS.LUNA_MOON_CYCLE] == 3 || flags[kFLAGS.LUNA_MOON_CYCLE] == 5) bonusStats2 += 10;
					if (flags[kFLAGS.LUNA_MOON_CYCLE] == 2 || flags[kFLAGS.LUNA_MOON_CYCLE] == 6) bonusStats2 += 20;
					if (flags[kFLAGS.LUNA_MOON_CYCLE] == 1 || flags[kFLAGS.LUNA_MOON_CYCLE] == 7) bonusStats2 += 30;
					if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) bonusStats2 += 40;
					player.removePerk(PerkLib.Lycanthropy);
					player.createPerk(PerkLib.Lycanthropy,bonusStats2,0,0,0);
					player.statStore.replaceBuffObject({ 'str.mult': bonusStats2*ngM,'tou.mult': bonusStats2*0.6*ngM,'spe.mult': bonusStats2*0.4*ngM, 'minlustx': bonusStats2 * 0.01}, 'Lycanthropy', { text: 'Lycanthropy'});
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.070;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.080) {
				if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_2059] != 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_2059] = 0;
				if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_2060] != 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_2060] = 0;
				if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_0131] != 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_0131] = 0;
				if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_0272] != 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_0272] = 0;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.080;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.09) {
				if (SceneLib.vapula.vapulaSlave()) inventory.takeItem(weapons.D_FLAIL, promptSaveUpdate);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.09;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.10) {
				if (SceneLib.exploration.counters.explore > 0 && flags[kFLAGS.ALVINA_FOLLOWER] < 1) flags[kFLAGS.ALVINA_FOLLOWER] = 1;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.10;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.11) {
				outputText("\n\nIf you not have any clones nothing to worry here...");
				if (player.hasStatusEffect(StatusEffects.PCClone) && player.statusEffectv4(StatusEffects.PCClone) >= 1) {
					var a1:Number = player.statusEffectv4(StatusEffects.PCClone);
					var a2:Number = player.statusEffectv3(StatusEffects.PCClone);
					if (a2 > 0) player.addStatusValue(StatusEffects.PCClone, 3, -a2);
					player.addStatusValue(StatusEffects.PCClone, 4, -a1);
					player.addStatusValue(StatusEffects.PCClone, 3, a1);
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.11;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.12) {
				outputText("\n\nYou all thought it was Diana but it's Nadia!!! (her older twin sister)");
				if (player.hasStatusEffect(StatusEffects.DianaOff)) {
					player.removeStatusEffect(StatusEffects.DianaOff);
					player.createStatusEffect(StatusEffects.NadiaOff, 0, 0, 0, 0);
				}
				flags[kFLAGS.NADIA_FOLLOWER] = flags[kFLAGS.DIANA_FOLLOWER];
				flags[kFLAGS.DIANA_FOLLOWER] = 0;
				flags[kFLAGS.NADIA_LVL_UP] = flags[kFLAGS.DIANA_LVL_UP];
				flags[kFLAGS.DIANA_LVL_UP] = 0;
				flags[kFLAGS.NADIA_CURE_COOLDOWN] = flags[kFLAGS.DIANA_CURE_COOLDOWN];
				flags[kFLAGS.DIANA_CURE_COOLDOWN] = 0;
				flags[kFLAGS.DIANA_SPELLS_CASTED] = 0;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.12;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.13) {
				if (player.hasStatusEffect(StatusEffects.PCClone) || 
				player.hasStatusEffect(StatusEffects.PCClone1st) || 
				player.hasStatusEffect(StatusEffects.PCClone2nd) || 
				player.hasStatusEffect(StatusEffects.PCClone3rd) || 
				player.hasStatusEffect(StatusEffects.PCClone4th) || 
				player.hasStatusEffect(StatusEffects.NegativeLevel)) {
					outputText("\n\n Mysteriously your clones seem to have disappeared... you'll need to reform them in camp!");
				}
				player.removeStatusEffect(StatusEffects.PCClone); 
				player.removeStatusEffect(StatusEffects.PCClone1st); 
				player.removeStatusEffect(StatusEffects.PCClone2nd); 
				player.removeStatusEffect(StatusEffects.PCClone3rd); 
				player.removeStatusEffect(StatusEffects.PCClone4th); 
				player.removeStatusEffect(StatusEffects.NegativeLevel); 
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.13;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.14) {
				if (player.hasPerk(PerkLib.TransformationImmunity2) && player.perkv1(PerkLib.TransformationImmunity2) == 1 && player.hairColor !="midnight purple") player.hairColor = "midnight purple";
				if (player.hasPerk(PerkLib.TransformationImmunity2) && player.hasPerk(PerkLib.Immortality)) {
					player.addPerkValue(PerkLib.TransformationImmunity2, 1, 5);
					if (player.hairColor != "immaculate white") player.hairColor = "immaculate white";
				}
				if (player.hasPerk(PerkLib.TransformationImmunity2) && player.perkv1(PerkLib.TransformationImmunity2) == 3 && player.hairColor != "midnight black") player.hairColor = "midnight black";
				if (player.hasPerk(PerkLib.TransformationImmunity) && !InCollection(player.hairColor1, GargoyleRace.GargoyleHairColors)) transformations.HairChangeColor(GargoyleRace.GargoyleHairColors).applyEffect(false);
				if (player.hasPerk(PerkLib.TransformationImmunity2) && player.hasPerk(PerkLib.ImpNobility)) {
					player.addPerkValue(PerkLib.TransformationImmunity2, 1, 6);
					if (!InCollection(player.hairColor1, ImpRace.ImpHairColors)) transformations.HairChangeColor(ImpRace.ImpHairColors).applyEffect(false);
				}
				if (player.hasPerk(PerkLib.TransformationImmunity2) && player.perkv1(PerkLib.TransformationImmunity2) == 2 && player.hairColor != "purple") player.hairColor = "purple";
				if (player.hasPerk(PerkLib.TransformationImmunity2) && player.lowerBody == LowerBody.SANDWORM) {
					player.addPerkValue(PerkLib.TransformationImmunity2, 1, 7);
					if (player.hairColor != "pink") player.hairColor = "pink";
				}
				if (player.hasPerk(PerkLib.BlessingOfTheAncestorTree) && player.hairColor != "golden blonde") player.hairColor = "golden blonde";
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.14;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.16) {
				if (player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)) transformations.SkinPatternBeeStripes.applyEffect();
				var libStat:BuffableStat = player.statStore.findBuffableStat("lib");
				var currentWeakness:Number = libStat.valueOfBuff("Weakened");
				if (currentWeakness > 0) libStat.removeBuff("Weakened");
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.16;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.17) {
				if (player.statStore.hasBuff('Feeding Euphoria')) player.buff("Feeding Euphoria").remove();
				if (player.statStore.hasBuff('Milking Euphoria')) player.buff("Milking Euphoria").remove();
				outputText("\n\nMysteriously your Feeding Euphoria and/or Milking Euphoria you may have seem to have disappeared... you'll need to feed again to get them!");
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.17;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.18) {
				outputText("\n\nBeautiful items meant to be gathered not chosen one per game.");
				if (player.hasStatusEffect(StatusEffects.BlessedItemAtTheLake)) player.addStatusValue(StatusEffects.BlessedItemAtTheLake, 1 , 1);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.18;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.19) {
				outputText("\n\nPerks are no longer needed for ranged multi attacks");
				refundPerk(PerkLib.Multishot);
				refundPerk(PerkLib.WildQuiver);
				refundPerk(PerkLib.Manyshot);
				refundPerk(PerkLib.WeaponRangeTripleStrike);
				refundPerk(PerkLib.WeaponRangeDoubleStrike);
				refundPerk(PerkLib.MasterGunslinger);
				refundPerk(PerkLib.ExpertGunslinger);
				refundPerk(PerkLib.AmateurGunslinger);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.19;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.20) {
				outputText("\n\nFixing Kindra's training skills...");
				if (player.statusEffectv1(StatusEffects.Kindra) >= 140 && player.hasStatusEffect(StatusEffects.KnowsSidewinder)) {
					flags[kFLAGS.KINDRA_ADV_ARCHERY] = 6;
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.20;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.30) {
				outputText("\n\nMoved camp resources and stats to dedicated class");
				CampStatsAndResources.EnergyCoreResc = flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES];
				CampStatsAndResources.MetalPieces = flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES];
				CampStatsAndResources.MechanismResc = flags[kFLAGS.CAMP_CABIN_MECHANISM_RESOURCES];
				CampStatsAndResources.StonesResc = flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES];
				CampStatsAndResources.WoodResc = flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES];
				CampStatsAndResources.NailsResc = flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES];
				flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES] = 0;
				flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] = 0;
				flags[kFLAGS.CAMP_CABIN_MECHANISM_RESOURCES] = 0;
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] = 0;
				flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 0;
				flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] = 0;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.30;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.32) {
				outputText("\n\nMerged Autocast perks into new Enchanter perk");
				refundPerk(PerkLib.Battlemage);
				refundPerk(PerkLib.Spellsword);
				refundPerk(PerkLib.Spellbow);
				refundPerk(PerkLib.Battleflash);
				refundPerk(PerkLib.Spellarmor);
				refundPerk(PerkLib.Battleshield);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.32;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.36) {
				outputText("\n\nMadam/Tempress minor reorganizations");
				if (JourneyToTheEast.AhriStatsToPerksConvertCounter > 0) {
					if (JourneyToTheEast.AhriStatsToPerksConvertCounter == 1 || JourneyToTheEast.AhriStatsToPerksConvertCounter == 3 || JourneyToTheEast.AhriStatsToPerksConvertCounter == 5) JourneyToTheEast.AhriStatsToSuperPerksConvertCounter += 1;
					if (JourneyToTheEast.AhriStatsToPerksConvertCounter > 1) {
						if (JourneyToTheEast.AhriStatsToPerksConvertCounter > 3) player.superPerkPoints += 2;
						else player.superPerkPoints += 1;
					}
				}
				if (JourneyToTheEast.EvelynnPerksToStatsConvertCounter > 0) JourneyToTheEast.EvelynnCoreLimitBreakerCounter += JourneyToTheEast.EvelynnPerksToStatsConvertCounter;
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.36;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.40) {
				if (flags[kFLAGS.THE_TRENCH_ENTERED] >= 1 && player.tailType != Tail.ARIGEAN_RED && player.tailType != Tail.ARIGEAN_YELLOW) {
					flags[kFLAGS.THE_TRENCH_ENTERED] = 0;
					player.removePerk(PerkLib.MiracleMetal);
					player.tailType = Tail.NONE;
				}
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.40;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.42) {
				outputText("\n\nArigeans likes their eyes like their tails...in matching colors ;)");
				if (player.tailType == Tail.ARIGEAN_RED) player.eyes.colour = "red";
				if (player.tailType == Tail.ARIGEAN_YELLOW) player.eyes.colour = "yellow";
				if (player.tailType == Tail.ARIGEAN_PRINCESS) player.eyes.colour = "blue";
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.42;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.45) {
				outputText("\n\nFlying swords tree no longer will ask for perk points.");
				refundPerk(PerkLib.FlyingSwordPath);
				refundPerk(PerkLib.SoaringBlades);
				refundPerk(PerkLib.FirstAttackFlyingSword);
				refundPerk(PerkLib.KillingIntent);
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.45;
			}/*
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.50) {
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.50;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.60) {
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.60;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 36.63) {
				flags[kFLAGS.MOD_SAVE_VERSION] = 36.63;
			}*/
			outputText("\n\n<i>Save</i> version updated to " + flags[kFLAGS.MOD_SAVE_VERSION] + "\n");
			doNext(camp.doCamp);
		}
	}

	//Due to a bug, it's possible to get multiple Deluxe Dildos. This should clean off most of them
	public function dildoFix():void {
		var dildoId:int = -1;
		var counter:Number = player.keyItems.length;
		if (player.keyItems.length <= 0) return;
		while (counter > 0) {
			counter--;
			if (player.keyItems[counter].keyName == "Deluxe Dildo") {
				if (dildoId == -1) dildoId = counter;
				else player.keyItems.splice(counter, 1);
			}
		}
	}
}
}