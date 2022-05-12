package classes {
import classes.Scenes.*;
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
import classes.Items.*;
import classes.Scenes.Crafting;
import classes.Scenes.NPCs.*;
import classes.Scenes.Places.HeXinDao.AdventurerGuild;

use namespace CoC;

public class SaveUpdater extends NPCAwareContent {

	public function SaveUpdater() {}

	public function updateAchievements():void {
		//Story
		awardAchievement("Newcomer", kACHIEVEMENTS.STORY_NEWCOMER);
		if (flags[kFLAGS.MARAE_QUEST_COMPLETE] > 0) awardAchievement("Marae's Savior", kACHIEVEMENTS.STORY_MARAE_SAVIOR);
		if (player.hasKeyItem("Zetaz's Map") >= 0) awardAchievement("Revenge at Last", kACHIEVEMENTS.STORY_ZETAZ_REVENGE);
		if (flags[kFLAGS.LETHICE_DEFEATED] > 0) awardAchievement("Demon Slayer", kACHIEVEMENTS.STORY_FINALBOSS);

		//Zones
		if (player.exploredForest > 0 && player.exploredLake > 0 && player.exploredDesert > 0 && player.exploredMountain > 0 && flags[kFLAGS.TIMES_EXPLORED_PLAINS] > 0 && flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0 && flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE] > 0 && flags[kFLAGS.DISCOVERED_OUTER_BATTLEFIELD] > 0 && flags[kFLAGS.DISCOVERED_CAVES] > 0 && player.hasStatusEffect(StatusEffects.ExploredDeepwoods)
			&& flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] > 0 && flags[kFLAGS.BOG_EXPLORED] > 0 && flags[kFLAGS.DISCOVERED_TUNDRA] > 0 && flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] > 0 && flags[kFLAGS.DISCOVERED_ASHLANDS] > 0 && flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] > 0) awardAchievement("Explorer", kACHIEVEMENTS.ZONE_EXPLORER);
		if (camp.placesCount() >= 10) awardAchievement("Sightseer", kACHIEVEMENTS.ZONE_SIGHTSEER);
		if (player.explored >= 1) awardAchievement("Where am I?", kACHIEVEMENTS.ZONE_WHERE_AM_I);

		if (player.exploredForest >= 100) awardAchievement("Forest Ranger", kACHIEVEMENTS.ZONE_FOREST_RANGER);
		if (player.exploredLake >= 100) awardAchievement("Vacationer", kACHIEVEMENTS.ZONE_VACATIONER);
		if (player.exploredDesert >= 100) awardAchievement("Dehydrated", kACHIEVEMENTS.ZONE_DEHYDRATED);
		if (flags[kFLAGS.DISCOVERED_OUTER_BATTLEFIELD] >= 100) awardAchievement("Rookie", kACHIEVEMENTS.ZONE_ROOKIE);
		if (player.exploredMountain >= 100) awardAchievement("Mountaineer", kACHIEVEMENTS.ZONE_MOUNTAINEER);
		if (flags[kFLAGS.TIMES_EXPLORED_PLAINS] >= 100) awardAchievement("Rolling Hills", kACHIEVEMENTS.ZONE_ROLLING_HILLS);
		if (flags[kFLAGS.TIMES_EXPLORED_SWAMP] >= 100) awardAchievement("Wet All Over", kACHIEVEMENTS.ZONE_WET_ALL_OVER);
		if (flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE] >= 100) awardAchievement("Tainted", kACHIEVEMENTS.ZONE_TAINTED);
		if (flags[kFLAGS.DISCOVERED_BEACH] >= 100) awardAchievement("Sunburned", kACHIEVEMENTS.ZONE_SUNBURNED);
		if (flags[kFLAGS.DISCOVERED_CAVES] >= 100) awardAchievement("Caveman", kACHIEVEMENTS.ZONE_CAVEMAN);

		if (player.statusEffectv1(StatusEffects.ExploredDeepwoods) >= 100) awardAchievement("We Need to Go Deeper", kACHIEVEMENTS.ZONE_WE_NEED_TO_GO_DEEPER);
		if (flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] >= 100) awardAchievement("Light-headed", kACHIEVEMENTS.ZONE_LIGHT_HEADED);
		if (flags[kFLAGS.BOG_EXPLORED] >= 100) awardAchievement("All murky", kACHIEVEMENTS.ZONE_ALL_MURKY);
		if (flags[kFLAGS.DISCOVERED_DEFILED_RAVINE] >= 100) awardAchievement("Defiled", kACHIEVEMENTS.ZONE_DEFILED);
		if (flags[kFLAGS.DISCOVERED_OCEAN] >= 100) awardAchievement("Sea-Legs", kACHIEVEMENTS.ZONE_SAILOR);
		if (flags[kFLAGS.DISCOVERED_TUNDRA] >= 100) awardAchievement("Sub-Zero", kACHIEVEMENTS.ZONE_SUB_ZERO);
		if (flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] >= 100) awardAchievement("Frozen", kACHIEVEMENTS.ZONE_FROZEN);
		if (flags[kFLAGS.DISCOVERED_ASHLANDS] >= 100) awardAchievement("Ashes to ashes, dust to dust", kACHIEVEMENTS.ZONE_ASHES_TO_ASHES_DUST_TO_DUST);
		if (flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] >= 100) awardAchievement("Roasted", kACHIEVEMENTS.ZONE_ROASTED);
		if (flags[kFLAGS.DISCOVERED_DEEP_SEA] >= 100) awardAchievement("Diver", kACHIEVEMENTS.ZONE_DIVER);

		if (player.statusEffectv1(StatusEffects.BoatDiscovery) >= 15) awardAchievement("Sailor", kACHIEVEMENTS.ZONE_SEA_LEGS);
		if (player.statusEffectv1(StatusEffects.MetWhitney) >= 30) awardAchievement("Farmer", kACHIEVEMENTS.ZONE_FARMER);
		if (flags[kFLAGS.AMILY_VILLAGE_EXPLORED] >= 15) awardAchievement("Archaeologist", kACHIEVEMENTS.ZONE_ARCHAEOLOGIST);

		//Levels
		if (player.level >= 1) awardAchievement("Level up!", kACHIEVEMENTS.LEVEL_LEVEL_UP);
		if (player.level >= 5) awardAchievement("Novice", kACHIEVEMENTS.LEVEL_NOVICE);
		if (player.level >= 10) awardAchievement("Apprentice", kACHIEVEMENTS.LEVEL_APPRENTICE);
		if (player.level >= 15) awardAchievement("Journeyman", kACHIEVEMENTS.LEVEL_JOURNEYMAN);
		if (player.level >= 20) awardAchievement("Expert", kACHIEVEMENTS.LEVEL_EXPERT);
		if (player.level >= 30) awardAchievement("Master", kACHIEVEMENTS.LEVEL_MASTER);
		if (player.level >= 45) awardAchievement("Grandmaster", kACHIEVEMENTS.LEVEL_GRANDMASTER);
		if (player.level >= 60) awardAchievement("Illuistrous", kACHIEVEMENTS.LEVEL_ILLUSTRIOUS);
		if (player.level >= 75) awardAchievement("Overlord", kACHIEVEMENTS.LEVEL_OVERLORD);
		if (player.level >= 90) awardAchievement("Sovereign", kACHIEVEMENTS.LEVEL_SOVEREIGN);
		if (player.level >= 100) awardAchievement("Are you a god?", kACHIEVEMENTS.LEVEL_ARE_YOU_A_GOD);
		if (player.level >= 120) awardAchievement("Newb God(ess)", kACHIEVEMENTS.LEVEL_NEWB_GOD_ESS);
		if (player.level >= 150) awardAchievement("Lowest-tier God(ess)", kACHIEVEMENTS.LEVEL_MID_TIER_GOD_ESS);
		//if (player.level >= ?180?) awardAchievement("Low-tier God(ess)", kACHIEVEMENTS.LEVEL_MID_TIER_GOD_ESS);
		//if (player.level >= ?210?) awardAchievement("-tier God(ess)", kACHIEVEMENTS.LEVEL_MID_TIER_GOD_ESS);

		//Population
		if (camp.getCampPopulation() >= 2) awardAchievement("My First Companion", kACHIEVEMENTS.POPULATION_FIRST);
		if (camp.getCampPopulation() >= 5) awardAchievement("Hamlet", kACHIEVEMENTS.POPULATION_HAMLET);
		if (camp.getCampPopulation() >= 10) awardAchievement("Village", kACHIEVEMENTS.POPULATION_VILLAGE);
		if (camp.getCampPopulation() >= 25) awardAchievement("Town", kACHIEVEMENTS.POPULATION_TOWN);
		if (camp.getCampPopulation() >= 100) awardAchievement("City", kACHIEVEMENTS.POPULATION_CITY);
		if (camp.getCampPopulation() >= 250) awardAchievement("Metropolis", kACHIEVEMENTS.POPULATION_METROPOLIS);
		if (camp.getCampPopulation() >= 500) awardAchievement("Megalopolis", kACHIEVEMENTS.POPULATION_MEGALOPOLIS);
		if (camp.getCampPopulation() >= 1000) awardAchievement("City-State", kACHIEVEMENTS.POPULATION_CITY_STATE);
		if (camp.getCampPopulation() >= 2500) awardAchievement("Kingdom", kACHIEVEMENTS.POPULATION_KINGDOM);
		if (camp.getCampPopulation() >= 5000) awardAchievement("Empire", kACHIEVEMENTS.POPULATION_EMPIRE);
		if (camp.getCampPopulation() >= 10000) awardAchievement("Large Empire", kACHIEVEMENTS.POPULATION_LARGE_EMPIRE);
		if (camp.getCampUndergroundPopulation() >= 1) awardAchievement("My First Underground Companion", kACHIEVEMENTS.UNDERGROUND_POPULATION_FIRST);
		if (camp.getCampUndergroundPopulation() >= 20) awardAchievement("Underground Hamlet", kACHIEVEMENTS.UNDERGROUND_POPULATION_HAMLET);
		if (camp.getCampUndergroundPopulation() >= 50) awardAchievement("Underground Village", kACHIEVEMENTS.UNDERGROUND_POPULATION_VILLAGE);
		if (camp.getCampUndergroundPopulation() >= 100) awardAchievement("Underground Town", kACHIEVEMENTS.UNDERGROUND_POPULATION_TOWN);
		if (camp.getCampUndergroundPopulation() >= 250) awardAchievement("Underground City", kACHIEVEMENTS.UNDERGROUND_POPULATION_CITY);
		if (camp.getCampUndergroundPopulation() >= 500) awardAchievement("Underground Metropolis", kACHIEVEMENTS.UNDERGROUND_POPULATION_METROPOLIS);
		if (camp.getCampUndergroundPopulation() >= 1000) awardAchievement("Underground Megalopolis", kACHIEVEMENTS.UNDERGROUND_POPULATION_MEGALOPOLIS);
		if (camp.getCampUndergroundPopulation() >= 2500) awardAchievement("Underground Large Megalopolis", kACHIEVEMENTS.UNDERGROUND_POPULATION_LARGE_MEGALOPOLIS);
		if (camp.getCampUndergroundPopulation() >= 5000) awardAchievement("Underground City-State", kACHIEVEMENTS.UNDERGROUND_POPULATION_CITY_STATE);
		if (camp.getCampUndergroundPopulation() >= 10000) awardAchievement("Underground Kingdom", kACHIEVEMENTS.UNDERGROUND_POPULATION_KINGDOM);

		//Time
		if (model.time.days >= 30) awardAchievement("It's been a month", kACHIEVEMENTS.TIME_MONTH);
		if (model.time.days >= 90) awardAchievement("Quarter", kACHIEVEMENTS.TIME_QUARTER);
		if (model.time.days >= 180) awardAchievement("Half-year", kACHIEVEMENTS.TIME_HALF_YEAR);
		if (model.time.days >= 365) awardAchievement("Annual", kACHIEVEMENTS.TIME_ANNUAL);
		if (model.time.days >= 730) awardAchievement("Biennial", kACHIEVEMENTS.TIME_BIENNIAL);
		if (model.time.days >= 1095) awardAchievement("Triennial", kACHIEVEMENTS.TIME_TRIENNIAL);
		if (model.time.days >= 1825) awardAchievement("In for the long haul", kACHIEVEMENTS.TIME_LONG_HAUL);
		if (model.time.days >= 3650) awardAchievement("Decade", kACHIEVEMENTS.TIME_DECADE);
		if (model.time.days >= 36500) awardAchievement("Century", kACHIEVEMENTS.TIME_CENTURY);

		//Dungeon
		var dungeonsCleared:int = 0;
		if (SceneLib.dungeons.checkFactoryClear()) {
			awardAchievement("Shut Down Everything", kACHIEVEMENTS.DUNGEON_SHUT_DOWN_EVERYTHING);
			dungeonsCleared++;
		}
		if (SceneLib.dungeons.checkDeepCaveClear()) {
			awardAchievement("You're in Deep", kACHIEVEMENTS.DUNGEON_YOURE_IN_DEEP);
			dungeonsCleared++;
		}
		if (SceneLib.dungeons.checkLethiceStrongholdClear()) {
			awardAchievement("End of Reign", kACHIEVEMENTS.DUNGEON_END_OF_REIGN);
			dungeonsCleared++;
		}
		if (SceneLib.dungeons.checkSandCaveClear()) {
			awardAchievement("Friend of the Sand Witches", kACHIEVEMENTS.DUNGEON_SAND_WITCH_FRIEND);
			dungeonsCleared++;
		}
		if (SceneLib.dungeons.checkPhoenixTowerClear()) {
			awardAchievement("Fall of the Phoenix", kACHIEVEMENTS.DUNGEON_PHOENIX_FALL);
			dungeonsCleared++;
			if (flags[kFLAGS.TIMES_ORGASMED] <= 0) awardAchievement("Extremely Chaste Delver", kACHIEVEMENTS.DUNGEON_EXTREMELY_CHASTE_DELVER);
		}
		if (SceneLib.dungeons.checkBeeHiveClear()) {
			awardAchievement("Victory, Sweet like honey", kACHIEVEMENTS.DUNGEON_VICTORY_SWEET_LIKE_HONEY);
			dungeonsCleared++;
		}
		if (SceneLib.dungeons.checkHiddenCaveHiddenStageClear()) {
			awardAchievement("Tiger stalking the Dragon", kACHIEVEMENTS.DUNGEON_TIGER_STALKING_THE_DRAGON);
			dungeonsCleared++;
		}
		if (SceneLib.dungeons.checkRiverDungeon1stFloorClear()) {
			awardAchievement("Mirror Flower, Water Moon", kACHIEVEMENTS.DUNGEON_MIRROR_FLOWER_WATER_MOON);
			awardAchievement("Dungeon Seeker (1st layer)", kACHIEVEMENTS.DUNGEON_DUNGEON_SEEKER_1ST_LAYER);
			dungeonsCleared++;
		}
		if (SceneLib.dungeons.checkDenOfDesireClear()) {
			awardAchievement("Slain the Heroslayer", kACHIEVEMENTS.DUNGEON_SLAIN_THE_HEROSLAYER);
			dungeonsCleared++;
		}
		//bee hive clear
		if (SceneLib.dungeons.checkEbonLabyrinthClear()) dungeonsCleared++;
		if (dungeonsCleared >= 1) awardAchievement("Delver", kACHIEVEMENTS.DUNGEON_DELVER);
		if (dungeonsCleared >= 2) awardAchievement("Delver Apprentice", kACHIEVEMENTS.DUNGEON_DELVER_APPRENTICE);
		if (dungeonsCleared >= 4) awardAchievement("Delver Expert", kACHIEVEMENTS.DUNGEON_DELVER_MASTER);
		if (dungeonsCleared >= 8) awardAchievement("Delver Master", kACHIEVEMENTS.DUNGEON_DELVER_EXPERT);
		if (dungeonsCleared >= 16) awardAchievement("Delver Grand Master", kACHIEVEMENTS.DUNGEON_DELVER_GRAND_MASTER);//obecnie max 10

		if (SceneLib.dungeons.checkRiverDungeon2ndFloorClear()) awardAchievement("Dungeon Seeker (2nd layer)", kACHIEVEMENTS.DUNGEON_DUNGEON_SEEKER_2ND_LAYER);
		if (SceneLib.dungeons.checkRiverDungeon3rdFloorClear()) awardAchievement("Dungeon Seeker (3rd layer)", kACHIEVEMENTS.DUNGEON_DUNGEON_SEEKER_3RD_LAYER);

		//Fashion
		if (player.armor == armors.W_ROBES && player.weapon == weapons.W_STAFF) awardAchievement("Wannabe Wizard", kACHIEVEMENTS.FASHION_WANNABE_WIZARD);
		if (player.previouslyWornClothes.length >= 10) awardAchievement("Cosplayer (Beginner)", kACHIEVEMENTS.FASHION_COSPLAYER);
		if (player.previouslyWornClothes.length >= 30) awardAchievement("Cosplayer (Amateour)", kACHIEVEMENTS.FASHION_COSPLAYER_1);
		if (player.previouslyWornClothes.length >= 60) awardAchievement("Cosplayer (Recognizable)", kACHIEVEMENTS.FASHION_COSPLAYER_2);
		if (player.previouslyWornClothes.length >= 100) awardAchievement("Cosplayer (Seasonal)", kACHIEVEMENTS.FASHION_COSPLAYER_3);
		if (player.previouslyWornClothes.length >= 150) awardAchievement("Cosplayer (Proffesional)", kACHIEVEMENTS.FASHION_COSPLAYER_4);
		//if (player.previouslyWornClothes.length >= 300) awardAchievement("Jessica Nigri apprentice", kACHIEVEMENTS.FASHION_COSPLAYER_5);
		//if (player.previouslyWornClothes.length >= 600) awardAchievement("Yaya Han apprentice", kACHIEVEMENTS.FASHION_COSPLAYER_6);
		if ((player.armor == armors.RBBRCLT || player.armor == armors.BONSTRP || player.armor == armors.NURSECL) &&
			(player.weapon == weapons.RIDINGC || player.weapon == weapons.WHIP || player.weapon == weapons.SUCWHIP || player.weapon == weapons.L_WHIP || player.weapon == weapons.PSWHIP || player.weapon == weapons.PWHIP || player.weapon == weapons.BFWHIP || player.weapon == weapons.DBFWHIP || player.weapon == weapons.NTWHIP || player.weapon == weapons.CNTWHIP)) awardAchievement("Dominatrix", kACHIEVEMENTS.FASHION_DOMINATRIX);
		if (player.armor != ArmorLib.NOTHING && player.lowerGarment == UndergarmentLib.NOTHING && player.upperGarment == UndergarmentLib.NOTHING) awardAchievement("Going Commando", kACHIEVEMENTS.FASHION_GOING_COMMANDO);
		if (player.headJewelry == headjewelries.FIRECRO && player.necklace == necklaces.FIRENEC && player.jewelry == jewelries.FIRERNG && player.jewelry2 == jewelries.FIRERNG && player.jewelry3 == jewelries.FIRERNG && player.jewelry4 == jewelries.FIRERNG) awardAchievement("Hellblazer", kACHIEVEMENTS.FASHION_HELLBLAZER);
		if (player.headJewelry == headjewelries.ICECROW && player.necklace == necklaces.ICENECK && player.jewelry == jewelries.ICERNG && player.jewelry2 == jewelries.ICERNG && player.jewelry3 == jewelries.ICERNG && player.jewelry4 == jewelries.ICERNG) awardAchievement("Less than Zero", kACHIEVEMENTS.FASHION_LESS_THAN_ZERO);
		if (player.headJewelry == headjewelries.LIGHCRO && player.necklace == necklaces.LIGHNEC && player.jewelry == jewelries.LIGHRNG && player.jewelry2 == jewelries.LIGHRNG && player.jewelry3 == jewelries.LIGHRNG && player.jewelry4 == jewelries.LIGHRNG) awardAchievement("Thunderstuck", kACHIEVEMENTS.FASHION_THUNDERSTUCK);
		if (player.headJewelry == headjewelries.DARKCRO && player.necklace == necklaces.DARKNEC && player.jewelry == jewelries.DARKRNG && player.jewelry2 == jewelries.DARKRNG && player.jewelry3 == jewelries.DARKRNG && player.jewelry4 == jewelries.DARKRNG) awardAchievement("Darkness Within", kACHIEVEMENTS.FASHION_DARKNESS_WITHIN);
		if (player.headJewelry == headjewelries.POISCRO && player.necklace == necklaces.POISNEC && player.jewelry == jewelries.POISRNG && player.jewelry2 == jewelries.POISRNG && player.jewelry3 == jewelries.POISRNG && player.jewelry4 == jewelries.POISRNG) awardAchievement("Poison Ivy", kACHIEVEMENTS.FASHION_POISON_IVY);
		if (player.headJewelry == headjewelries.LUSTCRO && player.necklace == necklaces.LUSTNEC && player.jewelry == jewelries.LUSTRNG && player.jewelry2 == jewelries.LUSTRNG && player.jewelry3 == jewelries.LUSTRNG && player.jewelry4 == jewelries.LUSTRNG) awardAchievement("Playboy Bunny", kACHIEVEMENTS.FASHION_POLAYBOY_BUNNY);
		if (player.headJewelry == headjewelries.CROWINT && player.necklace == necklaces.NECKINT && player.jewelry == jewelries.RINGINT && player.jewelry2 == jewelries.RINGINT && player.jewelry3 == jewelries.RINGINT && player.jewelry4 == jewelries.RINGINT) awardAchievement("Throne of Intelligence", kACHIEVEMENTS.FASHION_THRONE_OF_INTELLIGENCE);
		if (player.headJewelry == headjewelries.CROWLIB && player.necklace == necklaces.NECKLIB && player.jewelry == jewelries.RINGLIB && player.jewelry2 == jewelries.RINGLIB && player.jewelry3 == jewelries.RINGLIB && player.jewelry4 == jewelries.RINGLIB) awardAchievement("Throne of Libido", kACHIEVEMENTS.FASHION_THRONE_OF_LIBIDO);
		if (player.headJewelry == headjewelries.CROWSEN && player.necklace == necklaces.NECKSEN && player.jewelry == jewelries.RINGSEN && player.jewelry2 == jewelries.RINGSEN && player.jewelry3 == jewelries.RINGSEN && player.jewelry4 == jewelries.RINGSEN) awardAchievement("Throne of Sensitivity", kACHIEVEMENTS.FASHION_THRONE_OF_SENSITIVITY);
		if (player.headJewelry == headjewelries.CROWSPE && player.necklace == necklaces.NECKSPE && player.jewelry == jewelries.RINGSPE && player.jewelry2 == jewelries.RINGSPE && player.jewelry3 == jewelries.RINGSPE && player.jewelry4 == jewelries.RINGSPE) awardAchievement("Throne of Speed", kACHIEVEMENTS.FASHION_THRONE_OF_SPEED);
		if (player.headJewelry == headjewelries.CROWSTR && player.necklace == necklaces.NECKSTR && player.jewelry == jewelries.RINGSTR && player.jewelry2 == jewelries.RINGSTR && player.jewelry3 == jewelries.RINGSTR && player.jewelry4 == jewelries.RINGSTR) awardAchievement("Throne of Strength", kACHIEVEMENTS.FASHION_THRONE_OF_STRENGTH);
		if (player.headJewelry == headjewelries.CROWTOU && player.necklace == necklaces.NECKTOU && player.jewelry == jewelries.RINGTOU && player.jewelry2 == jewelries.RINGTOU && player.jewelry3 == jewelries.RINGTOU && player.jewelry4 == jewelries.RINGTOU) awardAchievement("Throne of Toughness", kACHIEVEMENTS.FASHION_THRONE_OF_TOUGHNESS);
		if (player.headJewelry == headjewelries.CROWWIS && player.necklace == necklaces.NECKWIS && player.jewelry == jewelries.RINGWIS && player.jewelry2 == jewelries.RINGWIS && player.jewelry3 == jewelries.RINGWIS && player.jewelry4 == jewelries.RINGWIS) awardAchievement("Throne of Wisdom", kACHIEVEMENTS.FASHION_THRONE_OF_WISDOM);
		if (player.isInGoblinMech() || player.isInNonGoblinMech()) awardAchievement("Suit Up!", kACHIEVEMENTS.FASHION_SUIT_UP);
		if (player.vehicles == vehicles.GOBMPRI) awardAchievement("Rollin' Rollin'", kACHIEVEMENTS.FASHION_ROLLIN_ROLLIN);
		if (player.vehicles == vehicles.GS_MECH) awardAchievement("Asura's Wrath", kACHIEVEMENTS.FASHION_ASURAS_WRATH);
		if (player.vehicles == vehicles.HB_MECH) awardAchievement("Howl of the Banshee", kACHIEVEMENTS.FASHION_HOWL_OF_THE_BANSHEE);
		if (player.jewelry.value >= 1000) awardAchievement("Bling Bling", kACHIEVEMENTS.FASHION_BLING_BLING);
		if (player.necklace.value >= 5000) awardAchievement("Ka-Ching!", kACHIEVEMENTS.FASHION_KA_CHING);
		if (player.headJewelry.value >= 4000) awardAchievement("Royalty", kACHIEVEMENTS.FASHION_ROYALTY);
		if (player.armor == armors.G_DIVES && player.weapon == weapons.SDRILL && player.shield == ShieldLib.NOTHING && player.hasPerk(PerkLib.PrestigeJobSpellKnight)) awardAchievement("Subject Delta", kACHIEVEMENTS.FASHION_SUBJECT_DELTA);
		if (player.armor == armors.SAMUARM && player.weapon == weapons.DAISHO && player.headJewelry == headjewelries.KABUMEMP) awardAchievement("Bushido - the way of the warrior", kACHIEVEMENTS.FASHION_BUSHIDO_THE_WAY_OF_THE_WARRIOR);

		//Wealth
		if (player.gems >= 1000) awardAchievement("Rich", kACHIEVEMENTS.WEALTH_RICH);
		if (player.gems >= 10000) awardAchievement("Hoarder", kACHIEVEMENTS.WEALTH_HOARDER);
		if (player.gems >= 100000) awardAchievement("Gem Vault", kACHIEVEMENTS.WEALTH_GEM_VAULT);
		if (player.gems >= 1000000) awardAchievement("Millionaire", kACHIEVEMENTS.WEALTH_MILLIONAIRE);
		if (flags[kFLAGS.SPIRIT_STONES] >= 200) awardAchievement("Poor Daoist", kACHIEVEMENTS.WEALTH_POOR_DAOIST);
		if (flags[kFLAGS.SPIRIT_STONES] >= 2000) awardAchievement("Sect's Conclave Student", kACHIEVEMENTS.WEALTH_SECTS_CONCLAVE_STUDENT);
		if (flags[kFLAGS.SPIRIT_STONES] >= 20000) awardAchievement("Sect's Head Elder", kACHIEVEMENTS.WEALTH_SECTS_HEAD_ELDER);
		if (flags[kFLAGS.SPIRIT_STONES] >= 500000) awardAchievement("Sect's Patriarch", kACHIEVEMENTS.WEALTH_SECTS_PATRIARCH);
		if (flags[kFLAGS.SPIRIT_STONES] >= 20000000) awardAchievement("Meng Hao", kACHIEVEMENTS.WEALTH_MENG_HAO);

		//Combat
		if (player.hasStatusEffect(StatusEffects.KnowsCharge) && player.hasStatusEffect(StatusEffects.KnowsChargeA) && player.hasStatusEffect(StatusEffects.KnowsBlind) && player.hasStatusEffect(StatusEffects.KnowsHeal) && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && player.hasStatusEffect(StatusEffects.KnowsBlizzard) &&
			player.hasStatusEffect(StatusEffects.KnowsLightningBolt) && player.hasStatusEffect(StatusEffects.KnowsChainLighting) && player.hasStatusEffect(StatusEffects.KnowsPyreBurst)) awardAchievement("Gandalf", kACHIEVEMENTS.COMBAT_GANDALF);
		if (player.hasStatusEffect(StatusEffects.KnowsArouse) && player.hasStatusEffect(StatusEffects.KnowsRegenerate) && player.hasStatusEffect(StatusEffects.KnowsMight) && player.hasStatusEffect(StatusEffects.KnowsBlink) && player.hasStatusEffect(StatusEffects.KnowsIceSpike) && player.hasStatusEffect(StatusEffects.KnowsDarknessShard) &&
			player.hasStatusEffect(StatusEffects.KnowsDuskWave) && player.hasStatusEffect(StatusEffects.KnowsArcticGale)) awardAchievement("Sauron", kACHIEVEMENTS.COMBAT_SAURON);
		if (player.hasStatusEffect(StatusEffects.KnowsCharge) && player.hasStatusEffect(StatusEffects.KnowsChargeA) && player.hasStatusEffect(StatusEffects.KnowsBlind) && player.hasStatusEffect(StatusEffects.KnowsHeal) && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && player.hasStatusEffect(StatusEffects.KnowsBlizzard) &&
			player.hasStatusEffect(StatusEffects.KnowsArouse) && player.hasStatusEffect(StatusEffects.KnowsRegenerate) && player.hasStatusEffect(StatusEffects.KnowsMight) && player.hasStatusEffect(StatusEffects.KnowsBlink) && player.hasStatusEffect(StatusEffects.KnowsIceSpike) && player.hasStatusEffect(StatusEffects.KnowsLightningBolt) &&
			player.hasStatusEffect(StatusEffects.KnowsDarknessShard) && player.hasStatusEffect(StatusEffects.KnowsChainLighting) && player.hasStatusEffect(StatusEffects.KnowsPyreBurst) && player.hasStatusEffect(StatusEffects.KnowsDuskWave) && player.hasStatusEffect(StatusEffects.KnowsArcticGale)) awardAchievement("Merlin", kACHIEVEMENTS.COMBAT_WIZARD);
		if (flags[kFLAGS.SPELLS_CAST] >= 1) awardAchievement("Are you a Wizard?", kACHIEVEMENTS.COMBAT_ARE_YOU_A_WIZARD);

		//Realistic
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_FASTING] >= 168 && flags[kFLAGS.HUNGER_ENABLED] > 0) awardAchievement("Fasting", kACHIEVEMENTS.REALISTIC_FASTING);
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_FASTING] >= 960 && flags[kFLAGS.HUNGER_ENABLED] > 0) awardAchievement("Lent", kACHIEVEMENTS.REALISTIC_LENT);
		if (player.maxHunger() > 100) awardAchievement("One more dish please", kACHIEVEMENTS.REALISTIC_ONE_MORE_DISH_PLEASE);
		if (player.maxHunger() > 250) awardAchievement("You not gonna eat those ribs?", kACHIEVEMENTS.REALISTIC_YOU_NOT_GONNA_EAT_THOSE_RIBS);
		if (player.maxHunger() > 500) awardAchievement("Dinner for Four", kACHIEVEMENTS.REALISTIC_DINNER_FOR_FOUR);
		if (player.maxHunger() > 1000) awardAchievement("Dinner for Obelix", kACHIEVEMENTS.REALISTIC_DINNER_FOR_OBELIX);

		//Holiday
		if (flags[kFLAGS.NIEVE_STAGE] == 5) awardAchievement("The Lovable Snowman", kACHIEVEMENTS.HOLIDAY_CHRISTMAS_III);

		//General
		if (flags[kFLAGS.DEMONS_DEFEATED] >= 20 && model.time.days >= 10) awardAchievement("Portal Defender", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER);
		if (flags[kFLAGS.DEMONS_DEFEATED] >= 40 && model.time.days >= 25) awardAchievement("Portal Defender 2: Defend Harder", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_2_DEFEND_HARDER);
		if (flags[kFLAGS.DEMONS_DEFEATED] >= 100 && model.time.days >= 45) awardAchievement("Portal Defender 3D: The Longest Night", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_3D_THE_LONGEST_NIGHT);
		if (flags[kFLAGS.DEMONS_DEFEATED] >= 300 && model.time.days >= 70) awardAchievement("Portal Defender 4.0: Die Hard", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_4_0_DIE_HARD);
		if (flags[kFLAGS.DEMONS_DEFEATED] >= 1050 && model.time.days >= 100) awardAchievement("Portal Defender 5: A Good Day to Die Hard", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_5_A_GOOD_DAY_TO_DIE_HARD);
		if (flags[kFLAGS.IMPS_KILLED] >= 25) awardAchievement("Just to Spite You", kACHIEVEMENTS.GENERAL_JUST_TO_SPITE_YOU);
		if (flags[kFLAGS.IMPS_KILLED] >= 125) awardAchievement("Just to Spite You 2: Spite Harder", kACHIEVEMENTS.GENERAL_JUST_TO_SPITE_YOU_2_SPITE_HARDER);
		if (flags[kFLAGS.IMPS_KILLED] >= 625) awardAchievement("Just to Spite You 3: I'm Back", kACHIEVEMENTS.GENERAL_JUST_TO_SPITE_YOU_3_IM_BACK);
		if (flags[kFLAGS.GOBLINS_KILLED] >= 25) awardAchievement("Goblin Slayer", kACHIEVEMENTS.GENERAL_GOBLIN_SLAYER);
		if (flags[kFLAGS.GOBLINS_KILLED] >= 125) awardAchievement("Goblin Slayer 2: Slay Harder", kACHIEVEMENTS.GENERAL_GOBLIN_SLAYER_2_SLAY_HARDER);
		if (flags[kFLAGS.GOBLINS_KILLED] >= 625) awardAchievement("Goblin Slayer 3: I'm Back", kACHIEVEMENTS.GENERAL_GOBLIN_SLAYER_3_IM_BACK);
		if (flags[kFLAGS.HELLHOUNDS_KILLED] >= 10) awardAchievement("Play dead Fido", kACHIEVEMENTS.GENERAL_PLAY_DEAD_FIDO);
		if (flags[kFLAGS.HELLHOUNDS_KILLED] >= 50) awardAchievement("Play dead Fido 2: Play Harder", kACHIEVEMENTS.GENERAL_PLAY_DEAD_FIDO_2_PLAY_HARDER);
		if (flags[kFLAGS.HELLHOUNDS_KILLED] >= 250) awardAchievement("Play dead Fido 3: I'm Back", kACHIEVEMENTS.GENERAL_PLAY_DEAD_FIDO_3_IM_BACK);
		if (flags[kFLAGS.MINOTAURS_KILLED] >= 10) awardAchievement("Killing the bull by the horns", kACHIEVEMENTS.GENERAL_KILLING_THE_BULL_BY_THE_HORNS);
		if (flags[kFLAGS.MINOTAURS_KILLED] >= 50) awardAchievement("Killing the bull by the horns 2: Kill Harder", kACHIEVEMENTS.GENERAL_KILLING_THE_BULL_BY_THE_HORNS_2_KILL_HARDER);
		if (flags[kFLAGS.MINOTAURS_KILLED] >= 250) awardAchievement("Killing the bull by the horns 3: I'm Back", kACHIEVEMENTS.GENERAL_KILLING_THE_BULL_BY_THE_HORNS_3_IM_BACK);

		var TotalKillCount:int = 0;
		if (flags[kFLAGS.IMPS_KILLED] > 0) TotalKillCount += flags[kFLAGS.IMPS_KILLED];
		if (flags[kFLAGS.GOBLINS_KILLED] > 0) TotalKillCount += flags[kFLAGS.GOBLINS_KILLED];
		if (flags[kFLAGS.HELLHOUNDS_KILLED] > 0) TotalKillCount += flags[kFLAGS.HELLHOUNDS_KILLED];
		if (flags[kFLAGS.MINOTAURS_KILLED] > 0) TotalKillCount += flags[kFLAGS.MINOTAURS_KILLED];
		if (flags[kFLAGS.TRUE_DEMONS_KILLED] > 0) TotalKillCount += flags[kFLAGS.TRUE_DEMONS_KILLED];
		if (TotalKillCount >= 47) awardAchievement("Body Count: Monty Python and the Holy Grail", kACHIEVEMENTS.GENERAL_BODY_COUNT_MPATHG);
		if (TotalKillCount >= 80) awardAchievement("Body Count: Deadpool", kACHIEVEMENTS.GENERAL_BODY_COUNT_DEADPOOL);
		if (TotalKillCount >= 144) awardAchievement("Body Count: Robocop", kACHIEVEMENTS.GENERAL_BODY_COUNT_ROBOCOP);
		if (TotalKillCount >= 191) awardAchievement("Body Count: Total Recall", kACHIEVEMENTS.GENERAL_BODY_COUNT_TOTALRECALL);
		if (TotalKillCount >= 247) awardAchievement("Body Count: Rambo", kACHIEVEMENTS.GENERAL_BODY_COUNT_RAMBO);
		if (TotalKillCount >= 307) awardAchievement("Body Count: Titanic", kACHIEVEMENTS.GENERAL_BODY_COUNT_TITANIC);
		if (TotalKillCount >= 468) awardAchievement("Body Count: The Lord of the Rings - Two Towers", kACHIEVEMENTS.GENERAL_BODY_COUNT_LOTR_TT);
		if (TotalKillCount >= 600) awardAchievement("Body Count: 300", kACHIEVEMENTS.GENERAL_BODY_COUNT_300);
		if (TotalKillCount >= 836) awardAchievement("Body Count: The Lord of the Rings - Return of the King", kACHIEVEMENTS.GENERAL_BODY_COUNT_LOTR_ROTK);
		//if (TotalKillCount >= 1410) awardAchievement("Body Count: Bloodiest Champion Ever", kACHIEVEMENTS.GENERAL_BODY_COUNT_BLOODIEST_CHAMPION_EVER);

		var NPCsBadEnds:int = 0; //Check how many NPCs got bad-ended.
		if (flags[kFLAGS.KELT_KILLED] > 0 || flags[kFLAGS.KELT_BREAK_LEVEL] >= 4) NPCsBadEnds++;
		if (flags[kFLAGS.JOJO_DEAD_OR_GONE] == 2) NPCsBadEnds++;
		if (flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0) NPCsBadEnds++;
		if (flags[kFLAGS.FUCK_FLOWER_KILLED] > 0) NPCsBadEnds++;
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 2 || flags[kFLAGS.CHI_CHI_FOLLOWER] == 5) NPCsBadEnds++;
		if (flags[kFLAGS.PATCHOULI_FOLLOWER] == 3) NPCsBadEnds++;
		//Dungeons
		if (flags[kFLAGS.D1_OMNIBUS_KILLED] > 0) NPCsBadEnds++;
		if (flags[kFLAGS.ZETAZ_DEFEATED_AND_KILLED] > 0) NPCsBadEnds++;
		if (flags[kFLAGS.HARPY_QUEEN_EXECUTED] > 0) NPCsBadEnds++;
		if (flags[kFLAGS.D3_GARDENER_DEFEATED] == 3) NPCsBadEnds++;
		if (flags[kFLAGS.D3_CENTAUR_DEFEATED] == 1) NPCsBadEnds++;
		if (flags[kFLAGS.D3_MECHANIC_FIGHT_RESULT] == 1) NPCsBadEnds++;
		if (flags[kFLAGS.DRIDERINCUBUS_KILLED] > 0) NPCsBadEnds++;
		if (flags[kFLAGS.MINOTAURKING_KILLED] > 0) NPCsBadEnds++;
		if (flags[kFLAGS.LETHICE_KILLED] > 0) NPCsBadEnds++;

		if (NPCsBadEnds >= 2) awardAchievement("Bad Ender", kACHIEVEMENTS.GENERAL_BAD_ENDER);
		if (NPCsBadEnds >= 4) awardAchievement("Bad Ender 2: Electric Boogaloo", kACHIEVEMENTS.GENERAL_BAD_ENDER_2);
		if (NPCsBadEnds >= 8) awardAchievement("Bad Ender 3: Serious Serial Slayer", kACHIEVEMENTS.GENERAL_BAD_ENDER_3);
		//if (NPCsBadEnds >= 16) awardAchievement("Bad Ender 4: The Prequel", kACHIEVEMENTS.GENERAL_BAD_ENDER_4);

		if (flags[kFLAGS.TIMES_TRANSFORMED] >= 1) awardAchievement("What's Happening to Me?", kACHIEVEMENTS.GENERAL_WHATS_HAPPENING_TO_ME);
		if (flags[kFLAGS.TIMES_TRANSFORMED] >= 10) awardAchievement("Transformer", kACHIEVEMENTS.GENERAL_TRANSFORMER);
		if (flags[kFLAGS.TIMES_TRANSFORMED] >= 25) awardAchievement("Shapeshifty", kACHIEVEMENTS.GENERAL_SHAPESHIFTY);
		if (flags[kFLAGS.TIMES_TRANSFORMED] >= 100) awardAchievement("Lego-(Wo)Man", kACHIEVEMENTS.GENERAL_LEGO_WO_MAN);
		if (flags[kFLAGS.TIMES_TRANSFORMED] >= 250) awardAchievement("Transformer-o-holic", kACHIEVEMENTS.GENERAL_TRANSFORMER_O_HOLIC);
		if (flags[kFLAGS.TIMES_TRANSFORMED] >= 1000) awardAchievement("Tzimisce Antediluvian", kACHIEVEMENTS.GENERAL_TZIMISCE_ANTEDILUVIAN);
		if (flags[kFLAGS.TIMES_TRANSFORMED] >= 2500) awardAchievement("Just one last transformation item!!!", kACHIEVEMENTS.GENERAL_JUST_ONE_LAST_TRANSFORMATION_ITEM);
		if (flags[kFLAGS.TIMES_MASTURBATED] >= 1) awardAchievement("Fapfapfap", kACHIEVEMENTS.GENERAL_FAPFAPFAP);
		if (flags[kFLAGS.TIMES_MASTURBATED] >= 10) awardAchievement("Faptastic", kACHIEVEMENTS.GENERAL_FAPTASTIC);
		if (flags[kFLAGS.TIMES_MASTURBATED] >= 100) awardAchievement("Master-bation", kACHIEVEMENTS.GENERAL_FAPSTER);
		if (flags[kFLAGS.TIMES_MASTURBATED] >= 1000) awardAchievement("Grand Master-bation", kACHIEVEMENTS.GENERAL_FAPSTER_2);

		if (player.armor == armors.GOOARMR) awardAchievement("Goo Armor", kACHIEVEMENTS.GENERAL_GOO_ARMOR);
		if (helspawnFollower()) awardAchievement("Helspawn", kACHIEVEMENTS.GENERAL_HELSPAWN);
		if (flags[kFLAGS.URTA_KIDS_MALES] + flags[kFLAGS.URTA_KIDS_FEMALES] + flags[kFLAGS.URTA_KIDS_HERMS] > 0) awardAchievement("Urta's True Lover", kACHIEVEMENTS.GENERAL_URTA_TRUE_LOVER);
		if (flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0) awardAchievement("Godslayer", kACHIEVEMENTS.GENERAL_GODSLAYER);
		if (camp.followersCount() >= 7) awardAchievement("Follow the Leader (1)", kACHIEVEMENTS.GENERAL_FOLLOW_THE_LEADER);//ponownie przeliczyć followers, lovers, slaves counter
		if (camp.followersCount() >= 14) awardAchievement("Follow the Leader (2)", kACHIEVEMENTS.GENERAL_FOLLOW_THE_LEADER_2);
		if (camp.followersCount() >= 21) awardAchievement("Follow the Leader (3)", kACHIEVEMENTS.GENERAL_FOLLOW_THE_LEADER_3);
		if (camp.loversCount() >= 8) awardAchievement("Gotta Love 'Em All (1)", kACHIEVEMENTS.GENERAL_GOTTA_LOVE_THEM_ALL);
		if (camp.loversCount() >= 16) awardAchievement("Gotta Love 'Em All (2)", kACHIEVEMENTS.GENERAL_GOTTA_LOVE_THEM_ALL_2);
		//if (camp.loversCount() >= 24) awardAchievement("Gotta Love 'Em All (3)", kACHIEVEMENTS.GENERAL_GOTTA_LOVE_THEM_ALL_3);
		if (camp.slavesCount() >= 4) awardAchievement("Meet Your " + player.mf("Master", "Mistress") + " (1)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER);
		if (camp.slavesCount() >= 8) awardAchievement("Meet Your " + player.mf("Master", "Mistress") + " (2)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_2);
		//if (camp.slavesCount() >= 12) awardAchievement("Meet Your " + player.mf("Master", "Mistress") + " (3)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_3);
		if (camp.slavesCount() >= 6 && camp.slavesOptionalCount() >= 2) awardAchievement("Slaver (1)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_TRUE);
		//if (camp.slavesCount() >= 12 && camp.slavesOptionalCount() >= 4) awardAchievement("Slaver (2)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_TRUE_2);
		//if (camp.slavesCount() >= 18 && camp.slavesOptionalCount() >= 6) awardAchievement("Slaver (3)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_TRUE_3);//dodać dodatkowych opcjonalnych Slaves tutaj i dać licznik opcjonalnych z każdym achiev wymagającym wiecej np. 2-4-6?
		if (camp.followersCount() + camp.loversCount() + camp.slavesCount() >= 19) awardAchievement("All Your People are Belong to Me (1)", kACHIEVEMENTS.GENERAL_ALL_UR_PPLZ_R_BLNG_2_ME);
		if (camp.followersCount() + camp.loversCount() + camp.slavesCount() >= 38) awardAchievement("All Your People are Belong to Me (2)", kACHIEVEMENTS.GENERAL_ALL_UR_PPLZ_R_BLNG_2_ME_2);
		//if (camp.followersCount() + camp.loversCount() + camp.slavesCount() >= 57) awardAchievement("All Your People are Belong to Me (3)", kACHIEVEMENTS.GENERAL_ALL_UR_PPLZ_R_BLNG_2_ME_3);
		if (flags[kFLAGS.MANSION_VISITED] >= 3) awardAchievement("Freeloader", kACHIEVEMENTS.GENERAL_FREELOADER);
		if (player.perks.length >= 25) awardAchievement("Perky", kACHIEVEMENTS.GENERAL_PERKY);
		if (player.perks.length >= 50) awardAchievement("Super Perky", kACHIEVEMENTS.GENERAL_SUPER_PERKY);
		if (player.perks.length >= 75) awardAchievement("Mega Perky", kACHIEVEMENTS.GENERAL_MEGA_PERKY);
		if (player.perks.length >= 100) awardAchievement("Ultra Perky", kACHIEVEMENTS.GENERAL_ULTRA_PERKY);
		if (player.perks.length >= 200) awardAchievement("Hyper Perky", kACHIEVEMENTS.GENERAL_HYPER_PERKY);
		if (player.perks.length >= 300) awardAchievement("Umber Perky", kACHIEVEMENTS.GENERAL_UMBER_PERKY);
		if (player.perks.length >= 444) awardAchievement("Perky Beast of Death", kACHIEVEMENTS.GENERAL_PERKY_BEAST_OF_DEATH);
		if (player.perks.length >= 600) awardAchievement("Perky King", kACHIEVEMENTS.GENERAL_PERKY_KING);
		if (player.perks.length >= 800) awardAchievement("Ridiculous Perky King", kACHIEVEMENTS.GENERAL_RIDICULOUS_PERKY_KING);
		//if (player.perks.length >= 1000) awardAchievement("Ludicrous Perky King", kACHIEVEMENTS.GENERAL_LUDICROUS_PERKY_KING);
		if (player.internalChimeraScore() >= 4) awardAchievement("Lesser Chimera", kACHIEVEMENTS.GENERAL_LESSER_CHIMERA);
		if (player.internalChimeraScore() >= 8) awardAchievement("Normal Chimera", kACHIEVEMENTS.GENERAL_NORMAL_CHIMERA);
		if (player.internalChimeraScore() >= 16) awardAchievement("Greater Chimera", kACHIEVEMENTS.GENERAL_GREATER_CHIMERA);
		if (player.internalChimeraScore() >= 32) awardAchievement("Elder Chimera", kACHIEVEMENTS.GENERAL_ELDER_CHIMERA);
		if (player.internalChimeraScore() >= 64) awardAchievement("Legendary Chimera", kACHIEVEMENTS.GENERAL_LEGENDARY_CHIMERA);
		if (player.internalChimeraScore() >= 128) awardAchievement("Ultimate Lifeform", kACHIEVEMENTS.GENERAL_ULTIMATE_LIFEFORM);
		if (player.str >= 50 && player.tou >= 50 && player.spe >= 50 && player.inte >= 50 && player.wis >= 50 && player.lib >= 40 && player.sens >= 5) awardAchievement("Jack of All Trades", kACHIEVEMENTS.GENERAL_STATS_50);
		if (player.str >= 100 && player.tou >= 100 && player.spe >= 100 && player.inte >= 100 && player.wis >= 100 && player.lib >= 80 && player.sens >= 10) awardAchievement("Incredible Stats", kACHIEVEMENTS.GENERAL_STATS_100);
		if (player.str >= 150 && player.tou >= 150 && player.spe >= 150 && player.inte >= 150 && player.wis >= 150 && player.lib >= 120 && player.sens >= 15) awardAchievement("Anmazing Stats", kACHIEVEMENTS.GENERAL_STATS_150);
		if (player.str >= 200 && player.tou >= 200 && player.spe >= 200 && player.inte >= 200 && player.wis >= 200 && player.lib >= 160 && player.sens >= 20) awardAchievement("Superhuman Stats", kACHIEVEMENTS.GENERAL_STATS_200);
		if (player.str >= 300 && player.tou >= 300 && player.spe >= 300 && player.inte >= 300 && player.wis >= 300 && player.lib >= 240 && player.sens >= 30) awardAchievement("Inhuman Stats", kACHIEVEMENTS.GENERAL_STATS_300);
		if (player.str >= 500 && player.tou >= 500 && player.spe >= 500 && player.inte >= 500 && player.wis >= 500 && player.lib >= 400 && player.sens >= 50) awardAchievement("Epic Stats", kACHIEVEMENTS.GENERAL_STATS_500);
		if (player.str >= 1000 && player.tou >= 1000 && player.spe >= 1000 && player.inte >= 1000 && player.wis >= 1000 && player.lib >= 800 && player.sens >= 100) awardAchievement("Legendary Stats", kACHIEVEMENTS.GENERAL_STATS_1000);
		if (player.str >= 2000 && player.tou >= 2000 && player.spe >= 2000 && player.inte >= 2000 && player.wis >= 2000 && player.lib >= 1600 && player.sens >= 200) awardAchievement("Mythical Stats", kACHIEVEMENTS.GENERAL_STATS_2000);
		if (player.str >= 5000 && player.tou >= 5000 && player.spe >= 5000 && player.inte >= 5000 && player.wis >= 5000 && player.lib >= 4000 && player.sens >= 500) awardAchievement("Transcendental Stats", kACHIEVEMENTS.GENERAL_STATS_5000);
		if (player.str >= 15000 && player.tou >= 15000 && player.spe >= 15000 && player.inte >= 15000 && player.wis >= 15000 && player.lib >= 12000 && player.sens >= 1500) awardAchievement("Divine Stats", kACHIEVEMENTS.GENERAL_STATS_15000);
		if (player.str >= 268445279 && player.tou >= 268445279 && player.spe >= 268445279 && player.inte >= 268445279 && player.wis >= 268445279) awardAchievement("OPK", kACHIEVEMENTS.GENERAL_STATS_OPK);
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCHIZOPHRENIA] >= 4) awardAchievement("Schizophrenic", kACHIEVEMENTS.GENERAL_SCHIZO);
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_CLEAN_SLATE] >= 2) awardAchievement("Clean Slate", kACHIEVEMENTS.GENERAL_CLEAN_SLATE);
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] >= 100) awardAchievement("I'm No Lumberjack", kACHIEVEMENTS.GENERAL_IM_NO_LUMBERJACK);
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_DEFORESTER] >= 100) awardAchievement("Deforester", kACHIEVEMENTS.GENERAL_DEFORESTER);
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_HAMMER_TIME] >= 300) awardAchievement("Hammer Time", kACHIEVEMENTS.GENERAL_HAMMER_TIME);
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCAVENGER] >= 200) awardAchievement("Nail Scavenger", kACHIEVEMENTS.GENERAL_NAIL_SCAVENGER);
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_YABBA_DABBA_DOO] >= 100) awardAchievement("Yabba Dabba Doo", kACHIEVEMENTS.GENERAL_YABBA_DABBA_DOO);
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_ANTWORKS] >= 200) awardAchievement("AntWorks", kACHIEVEMENTS.GENERAL_ANTWORKS);
		if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_TABLE] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR1] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_CHAIR2] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BOOKSHELF] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESK] >= 1 && flags[kFLAGS.CAMP_CABIN_FURNITURE_DESKCHAIR] >= 1) awardAchievement("Home Sweet Home", kACHIEVEMENTS.GENERAL_HOME_SWEET_HOME);
		if (player.tallness >= 132) awardAchievement("Up to Eleven", kACHIEVEMENTS.GENERAL_UP_TO_11);

		var NPCsDedicked:int = 0; //Check how many NPCs are dedicked.
		if (flags[kFLAGS.IZMA_NO_COCK] > 0) NPCsDedicked++;
		if (flags[kFLAGS.CERAPH_HIDING_DICK] > 0) NPCsDedicked++;
		if (flags[kFLAGS.RUBI_ADMITTED_GENDER] > 0 && flags[kFLAGS.RUBI_COCK_SIZE] <= 0) NPCsDedicked++;
		if (flags[kFLAGS.BENOIT_STATUS] == 1 || flags[kFLAGS.BENOIT_STATUS] == 2) NPCsDedicked++;
		if (flags[kFLAGS.ARIAN_HEALTH] > 0 && flags[kFLAGS.ARIAN_COCK_SIZE] <= 0) NPCsDedicked++;
		if (flags[kFLAGS.KATHERINE_UNLOCKED] > 0 && flags[kFLAGS.KATHERINE_DICK_COUNT] <= 0) NPCsDedicked++;
		if (flags[kFLAGS.MET_KITSUNES] > 0 && flags[kFLAGS.REDHEAD_IS_FUTA] == 0) NPCsDedicked++;
		if (flags[kFLAGS.KELT_BREAK_LEVEL] == 4) NPCsDedicked++;
		if (NPCsDedicked >= 3) awardAchievement("Dick Banisher", kACHIEVEMENTS.GENERAL_DICK_BANISHER);
		if (NPCsDedicked >= 7) awardAchievement("You Bastard", kACHIEVEMENTS.GENERAL_YOU_BASTARD); //Take that, dedickers!

		if (player.newGamePlusMod() >= 1) awardAchievement("xXx2: The Next Level", kACHIEVEMENTS.EPIC_XXX2_THE_NEXT_LEVEL);
		if (player.newGamePlusMod() >= 2) awardAchievement("xXx: The Return of Mareth Champion", kACHIEVEMENTS.EPIC_XXX_THE_RETURN_OF_MARETH_CHAMPION);
		if (player.newGamePlusMod() >= 3) awardAchievement("xXx 4", kACHIEVEMENTS.EPIC_XXX_4);
		if (player.newGamePlusMod() >= 4) awardAchievement("xXx 5: Mareth's Judgment_Day", kACHIEVEMENTS.EPIC_XXX5_MARETHS_JUDGMENT_DAY);
		if (player.newGamePlusMod() >= 5) awardAchievement("xXx 6: Rise of the Demons", kACHIEVEMENTS.EPIC_XXX6_RISE_OF_THE_DEMONS);
		if (player.newGamePlusMod() >= 6) awardAchievement("xXx 7: Salvation", kACHIEVEMENTS.EPIC_XXX7_SALVATION);/*
	if (player.newGamePlusMod() >= 7) awardAchievement("xXx 8: Genisys", kACHIEVEMENTS.EPIC_XXX8_GENISYS);
	if (player.newGamePlusMod() >= 8) awardAchievement("xXx 9: Dark Fate", kACHIEVEMENTS.EPIC_XXX9_DARK_FATE);*/

		if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] > 0 || flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] > 0) awardAchievement("My own Demon Weapon", kACHIEVEMENTS.EPIC_MY_OWN_DEMON_WEAPON);
		var EvolvingItems:int = 0;
		if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] > 0) EvolvingItems++;
		if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] > 0) EvolvingItems++;
		if (EvolvingItems >= 1) awardAchievement("Me Evolve", kACHIEVEMENTS.EPIC_ME_EVOLVE);
		if (EvolvingItems >= 2) awardAchievement("Us Evolve", kACHIEVEMENTS.EPIC_US_EVOLVE);
		//if (EvolvingItems >= 4) awardAchievement("They Evolve", kACHIEVEMENTS.EPIC_THEY_EVOLVE);
		//if (EvolvingItems >= 8) awardAchievement("Everyone Evolve", kACHIEVEMENTS.EPIC_EVERYONE_EVOLVE);
		var EvolutionsCount:int = 0;
		if (AetherTwinsFollowers.AetherTwinsTalkMenu > 0) EvolutionsCount++;
		if (EvolutionsCount >= 1) awardAchievement("Faster Harder Better Stronger Curvier!!! (1)", kACHIEVEMENTS.EPIC_F_H_B_S_CURVIER_1);
		//if (EvolutionsCount >= 2) awardAchievement("Faster Harder Better Stronger Curvier!!! (2)", kACHIEVEMENTS.EPIC_F_H_B_S_CURVIER_2);
		//if (EvolutionsCount >= 4) awardAchievement("Faster Harder Better Stronger Curvier!!! (3)", kACHIEVEMENTS.EPIC_F_H_B_S_CURVIER_3);
		//if (EvolutionsCount >= 8) awardAchievement("Faster Harder Better Stronger Curvier!!! (4)", kACHIEVEMENTS.EPIC_F_H_B_S_CURVIER_4);
		//if (EvolutionsCount >= 16) awardAchievement("Faster Harder Better Stronger Curvier!!! (5)", kACHIEVEMENTS.EPIC_F_H_B_S_CURVIER_5);

		if (player.hasPerk(PerkLib.GargoylePure) || player.hasPerk(PerkLib.GargoyleCorrupted)) awardAchievement("Guardian of Notre-Dame", kACHIEVEMENTS.EPIC_GUARDIAN_OF_NOTRE_DAME);
		if (player.hasPerk(PerkLib.Phylactery)) awardAchievement("The Devil Wears Prada", kACHIEVEMENTS.EPIC_THE_DEVIL_WEARS_PRADA);
		//atlach nacha achiev
		//handmaiden achiev
		if (player.jiangshiScore() >= 20) awardAchievement("Thriller", kACHIEVEMENTS.EPIC_THRILLER);
		if (player.yukiOnnaScore() >= 14) awardAchievement("Let It Go", kACHIEVEMENTS.EPIC_LET_IT_GO);
		//wendigo achiev

		if (player.hasStatusEffect(StatusEffects.AchievementsNormalShadowTotal)) {
			//Shadow
			if (player.statusEffectv2(StatusEffects.AchievementsNormalShadowTotal) >= 1) awardAchievement("Shadow Initiate", kACHIEVEMENTS.SHADOW_INITIATE);
			if (player.statusEffectv2(StatusEffects.AchievementsNormalShadowTotal) >= 10) awardAchievement("Shadow Squire", kACHIEVEMENTS.SHADOW_SQUIRE);
			if (player.statusEffectv2(StatusEffects.AchievementsNormalShadowTotal) >= 25) awardAchievement("Shadow Knight", kACHIEVEMENTS.SHADOW_KNIGHT);
			if (player.statusEffectv2(StatusEffects.AchievementsNormalShadowTotal) >= 45) awardAchievement("Shadow Paladin", kACHIEVEMENTS.SHADOW_PALADIN);
			if (player.statusEffectv2(StatusEffects.AchievementsNormalShadowTotal) >= 70) awardAchievement("Shadow General", kACHIEVEMENTS.SHADOW_GENERAL);
			//Epic
			if (player.statusEffectv3(StatusEffects.AchievementsNormalShadowTotal) >= 10) awardAchievement("Achievementception", kACHIEVEMENTS.EPIC_ACHIEVEMENTCEPTION);
			if (player.statusEffectv3(StatusEffects.AchievementsNormalShadowTotal) >= 30) awardAchievement("Achievement within Achievement", kACHIEVEMENTS.EPIC_ACHIEVEMENT_WITHIN_ACHIEVEMENT);
			if (player.statusEffectv3(StatusEffects.AchievementsNormalShadowTotal) >= 60) awardAchievement("Achievements - Going Deeper (1st layer)", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_GOING_DEEPER_1L);
			if (player.statusEffectv3(StatusEffects.AchievementsNormalShadowTotal) >= 100) awardAchievement("Achievements - Going Deeper (2nd layer)", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_GOING_DEEPER_2L);
			if (player.statusEffectv3(StatusEffects.AchievementsNormalShadowTotal) >= 300) awardAchievement("Achievements - Going Deeper (3rd layer)", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_GOING_DEEPER_3L);
			if (player.statusEffectv3(StatusEffects.AchievementsNormalShadowTotal) >= 600) awardAchievement("Achievements Limbo", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_LIMBO);
			player.removeStatusEffect(StatusEffects.AchievementsNormalShadowTotal);
		}
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

	public function promptSaveUpdate():void {
		clearOutput();
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
			outputText("Ups looks like you not have achievements feature unlocked yet. So now you can get them.");
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
				if (player.armorName == "comfortable underclothes") player.setArmor(ArmorLib.NOTHING);
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
			if (!player.hasFur()) {
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
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_2019] > 0 && player.hasKeyItem("Marae's Lethicite") >= 0) {
				player.removeKeyItem("Marae's Lethicite"); //Remove the old.
				player.createKeyItem("Marae's Lethicite", flags[kFLAGS.UNKNOWN_FLAG_NUMBER_2019], 0, 0, 0);
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_2019] = 0; //Reclaim the flag.
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
			if (player.hasPerk(PerkLib.Manyshot) && !player.hasPerk(PerkLib.TripleStrike)) {
				player.removePerk(PerkLib.Manyshot);
				player.createPerk(PerkLib.TripleStrike, 0, 0, 0, 0);
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
			if (player.hasPerk(PerkLib.JobSoulArcher)) {
				player.removePerk(PerkLib.JobSoulArcher);
				player.perkPoints = player.perkPoints + 1;
			}
			//Update chitin
			if (player.hasCoatOfType(Skin.CHITIN)) {
				if (player.mantisScore() >= 5) player.skin.coat.color = "green";
				if (player.spiderScore() >= 5) player.skin.coat.color = "pale white";
				if (player.mantisScore() < 5 && player.spiderScore() < 5) {
					if (rand(2) == 1) player.skin.coat.color = "green";
					else player.skin.coat.color = "pale white";
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
			if (player.hasPerk(PerkLib.Cupid)) {
				player.removePerk(PerkLib.Cupid);
				player.perkPoints = player.perkPoints + 1;
			}
			if (player.hasPerk(PerkLib.ElementalArrows)) {
				player.removePerk(PerkLib.ElementalArrows);
				player.perkPoints = player.perkPoints + 1;
			}
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
			outputText("Small reorganizing of the house interiors...err I mean mod interiors so not mind it if you not have Soul Cultivator PC. I heard you all likes colors, colors on EVERYTHING ever your belowed lil PC's eyes. So go ahead and pick them. Not much change from addition to appearance screen this small detail. But in future if scene will allow there will be addition of parser for using eyes color too.");
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
				player.coatColor = player.hairColor;
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
			if (player.hasPerk(PerkLib.SenseCorruption)) {
				player.removePerk(PerkLib.SenseCorruption);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.SenseWrath)) {
				player.removePerk(PerkLib.SenseWrath);
				player.perkPoints += 1;
			}
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
			if (player.hasPerk(PerkLib.Convergence)) {
				player.removePerk(PerkLib.Convergence);
				player.perkPoints += 1;
			}
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
				player.skinTone = "light";
				player.faceType = Face.HUMAN;
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
			if (!player.hasStatusEffect(StatusEffects.StrTouSpeCounter1)) {
				player.createStatusEffect(StatusEffects.StrTouSpeCounter1, 0, 0, 0, 0);
				player.createStatusEffect(StatusEffects.StrTouSpeCounter2, 0, 0, 0, 0);
				player.createStatusEffect(StatusEffects.IntWisCounter1, 0, 0, 0, 0);
				player.createStatusEffect(StatusEffects.IntWisCounter2, 0, 0, 0, 0);
				player.createStatusEffect(StatusEffects.LibSensCounter1, 0, 0, 0, 0);
				player.createStatusEffect(StatusEffects.LibSensCounter2, 0, 0, 0, 0);
				player.strtouspeintwislibsenCalculation2();
			}
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
			if (player.hasPerk(MutationsLib.KitsuneThyroidGlandEvolved)) SphereMastery += 15;
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
					if (player.weapon == weapons.AETHERD) player.setWeapon(WeaponLib.FISTS);
				}
				if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 2) {
					flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 1;
					if (player.shield == shields.AETHERS) player.setShield(ShieldLib.NOTHING);
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
			outputText("Also, Mutations no longer are obtained via Level up perks, instead, find Evangeline for the mutations. Existing perks will have their costs refunded!");
			for each(var mutref:PerkType in MutationsLib.mutationsArray("", true)) {
				if (player.hasPerk(mutref)) {
					player.perkPoints++;
				}
			}
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 33) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 34;
			clearOutput();
			outputText("Grey Sage prestige really need to retire... please no cry blood tears it may return in some other form... maybe... Also all Evovlved/Final Form racial mutation perks been reassigned new tiers xD");
			if (player.hasPerk(PerkLib.PrestigeJobGreySage)) {
				player.removePerk(PerkLib.PrestigeJobGreySage);
				player.perkPoints += 1;
			}
			if (flags[kFLAGS.DINAH_HIPS_ASS_SIZE] == 1) flags[kFLAGS.DINAH_ASS_HIPS_SIZE] = 1;
			if (flags[kFLAGS.TOUGHNESS_SCALING] != 0) flags[kFLAGS.TOUGHNESS_SCALING] = 0;
			if (!player.hasPerk(MutationsLib.GorgonsEyesFinalForm)) {
				if (player.hasPerk(MutationsLib.ArachnidBookLungEvolved)) {
					player.removePerk(MutationsLib.ArachnidBookLungEvolved);
					player.createPerk(MutationsLib.ArachnidBookLungPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.ArachnidBookLungFinalForm)) {
					player.removePerk(MutationsLib.ArachnidBookLungFinalForm);
					player.createPerk(MutationsLib.ArachnidBookLungEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.BlackHeartEvolved)) {
					player.removePerk(MutationsLib.BlackHeartEvolved);
					player.createPerk(MutationsLib.BlackHeartPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.BlackHeartFinalForm)) {
					player.removePerk(MutationsLib.BlackHeartFinalForm);
					player.createPerk(MutationsLib.BlackHeartEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.DisplacerMetabolismEvolved)) {
					player.removePerk(MutationsLib.DisplacerMetabolismEvolved);
					player.createPerk(MutationsLib.DisplacerMetabolismPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.DraconicBonesEvolved)) {
					player.removePerk(MutationsLib.DraconicBonesEvolved);
					player.createPerk(MutationsLib.DraconicBonesPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.DraconicBonesFinalForm)) {
					player.removePerk(MutationsLib.DraconicBonesFinalForm);
					player.createPerk(MutationsLib.DraconicBonesEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.DraconicHeartEvolved)) {
					player.removePerk(MutationsLib.DraconicHeartEvolved);
					player.createPerk(MutationsLib.DraconicHeartPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.DraconicHeartFinalForm)) {
					player.removePerk(MutationsLib.DraconicHeartFinalForm);
					player.createPerk(MutationsLib.DraconicHeartEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.DraconicLungsEvolved)) {
					player.removePerk(MutationsLib.DraconicLungsEvolved);
					player.createPerk(MutationsLib.DraconicLungsPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.DraconicLungsFinalForm)) {
					player.removePerk(MutationsLib.DraconicLungsFinalForm);
					player.createPerk(MutationsLib.DraconicLungsEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.DrakeLungsEvolved)) {
					player.removePerk(MutationsLib.DrakeLungsEvolved);
					player.createPerk(MutationsLib.DrakeLungsPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.DrakeLungsFinalForm)) {
					player.removePerk(MutationsLib.DrakeLungsFinalForm);
					player.createPerk(MutationsLib.DrakeLungsEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.EasterBunnyEggBagEvolved)) {
					player.removePerk(MutationsLib.EasterBunnyEggBagEvolved);
					player.createPerk(MutationsLib.EasterBunnyEggBagPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.EasterBunnyEggBagFinalForm)) {
					player.removePerk(MutationsLib.EasterBunnyEggBagFinalForm);
					player.createPerk(MutationsLib.EasterBunnyEggBagEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.ElvishPeripheralNervSysEvolved)) {
					player.removePerk(MutationsLib.ElvishPeripheralNervSysEvolved);
					player.createPerk(MutationsLib.ElvishPeripheralNervSysPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.ElvishPeripheralNervSysFinalForm)) {
					player.removePerk(MutationsLib.ElvishPeripheralNervSysFinalForm);
					player.createPerk(MutationsLib.ElvishPeripheralNervSysEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.FeyArcaneBloodstreamEvolved)) {
					player.removePerk(MutationsLib.FeyArcaneBloodstreamEvolved);
					player.createPerk(MutationsLib.FeyArcaneBloodstreamPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.FeyArcaneBloodstreamFinalForm)) {
					player.removePerk(MutationsLib.FeyArcaneBloodstreamFinalForm);
					player.createPerk(MutationsLib.FeyArcaneBloodstreamEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.FloralOvariesEvolved)) {
					player.removePerk(MutationsLib.FloralOvariesEvolved);
					player.createPerk(MutationsLib.FloralOvariesPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.FloralOvariesFinalForm)) {
					player.removePerk(MutationsLib.FloralOvariesFinalForm);
					player.createPerk(MutationsLib.FloralOvariesEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.FrozenHeartEvolved)) {
					player.removePerk(MutationsLib.FrozenHeartEvolved);
					player.createPerk(MutationsLib.FrozenHeartPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.FrozenHeartFinalForm)) {
					player.removePerk(MutationsLib.FrozenHeartFinalForm);
					player.createPerk(MutationsLib.FrozenHeartEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.GazerEyeEvolved)) {
					player.removePerk(MutationsLib.GazerEyeEvolved);
					player.createPerk(MutationsLib.GazerEyePrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.GazerEyeFinalForm)) {
					player.removePerk(MutationsLib.GazerEyeFinalForm);
					player.createPerk(MutationsLib.GazerEyeEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.GorgonsEyesEvolved)) {
					player.removePerk(MutationsLib.GorgonsEyesEvolved);
					player.createPerk(MutationsLib.GorgonsEyesPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.HarpyHollowBonesEvolved)) {
					player.removePerk(MutationsLib.HarpyHollowBonesEvolved);
					player.createPerk(MutationsLib.HarpyHollowBonesPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.HarpyHollowBonesFinalForm)) {
					player.removePerk(MutationsLib.HarpyHollowBonesFinalForm);
					player.createPerk(MutationsLib.HarpyHollowBonesEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.HeartOfTheStormEvolved)) {
					player.removePerk(MutationsLib.HeartOfTheStormEvolved);
					player.createPerk(MutationsLib.HeartOfTheStormPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.HeartOfTheStormFinalForm)) {
					player.removePerk(MutationsLib.HeartOfTheStormFinalForm);
					player.createPerk(MutationsLib.HeartOfTheStormEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.HinezumiBurningBloodEvolved)) {
					player.removePerk(MutationsLib.HinezumiBurningBloodEvolved);
					player.createPerk(MutationsLib.HinezumiBurningBloodPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.HinezumiBurningBloodFinalForm)) {
					player.removePerk(MutationsLib.HinezumiBurningBloodFinalForm);
					player.createPerk(MutationsLib.HinezumiBurningBloodEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.HollowFangsEvolved)) {
					player.removePerk(MutationsLib.HollowFangsEvolved);
					player.createPerk(MutationsLib.HollowFangsPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.HollowFangsFinalForm)) {
					player.removePerk(MutationsLib.HollowFangsFinalForm);
					player.createPerk(MutationsLib.HollowFangsEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.KitsuneThyroidGlandEvolved)) {
					player.removePerk(MutationsLib.KitsuneThyroidGlandEvolved);
					player.createPerk(MutationsLib.KitsuneThyroidGlandPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.KitsuneThyroidGlandFinalForm)) {
					player.removePerk(MutationsLib.KitsuneThyroidGlandFinalForm);
					player.createPerk(MutationsLib.KitsuneThyroidGlandEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.LactaBovinaOvariesEvolved)) {
					player.removePerk(MutationsLib.LactaBovinaOvariesEvolved);
					player.createPerk(MutationsLib.LactaBovinaOvariesPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.LactaBovinaOvariesFinalForm)) {
					player.removePerk(MutationsLib.LactaBovinaOvariesFinalForm);
					player.createPerk(MutationsLib.LactaBovinaOvariesEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.LizanMarrowEvolved)) {
					player.removePerk(MutationsLib.LizanMarrowEvolved);
					player.createPerk(MutationsLib.LizanMarrowPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.LizanMarrowFinalForm)) {
					player.removePerk(MutationsLib.LizanMarrowFinalForm);
					player.createPerk(MutationsLib.LizanMarrowEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.ManticoreMetabolismEvolved)) {
					player.removePerk(MutationsLib.ManticoreMetabolismEvolved);
					player.createPerk(MutationsLib.ManticoreMetabolismPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.MantislikeAgilityEvolved)) {
					player.removePerk(MutationsLib.MantislikeAgilityEvolved);
					player.createPerk(MutationsLib.MantislikeAgilityPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.MantislikeAgilityFinalForm)) {
					player.removePerk(MutationsLib.MantislikeAgilityFinalForm);
					player.createPerk(MutationsLib.MantislikeAgilityEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.MelkieLungEvolved)) {
					player.removePerk(MutationsLib.MelkieLungEvolved);
					player.createPerk(MutationsLib.MelkieLungPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.MelkieLungFinalForm)) {
					player.removePerk(MutationsLib.MelkieLungFinalForm);
					player.createPerk(MutationsLib.MelkieLungEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.MinotaurTesticlesEvolved)) {
					player.removePerk(MutationsLib.MinotaurTesticlesEvolved);
					player.createPerk(MutationsLib.MinotaurTesticlesPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.MinotaurTesticlesFinalForm)) {
					player.removePerk(MutationsLib.MinotaurTesticlesFinalForm);
					player.createPerk(MutationsLib.MinotaurTesticlesEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.NaturalPunchingBagEvolved)) {
					player.removePerk(MutationsLib.NaturalPunchingBagEvolved);
					player.createPerk(MutationsLib.NaturalPunchingBagPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.NaturalPunchingBagFinalForm)) {
					player.removePerk(MutationsLib.NaturalPunchingBagFinalForm);
					player.createPerk(MutationsLib.NaturalPunchingBagEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.NukiNutsEvolved)) {
					player.removePerk(MutationsLib.NukiNutsEvolved);
					player.createPerk(MutationsLib.NukiNutsPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.NukiNutsFinalForm)) {
					player.removePerk(MutationsLib.NukiNutsFinalForm);
					player.createPerk(MutationsLib.NukiNutsEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.ObsidianHeartEvolved)) {
					player.removePerk(MutationsLib.ObsidianHeartEvolved);
					player.createPerk(MutationsLib.ObsidianHeartPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.ObsidianHeartFinalForm)) {
					player.removePerk(MutationsLib.ObsidianHeartFinalForm);
					player.createPerk(MutationsLib.ObsidianHeartEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.OniMusculatureEvolved)) {
					player.removePerk(MutationsLib.OniMusculatureEvolved);
					player.createPerk(MutationsLib.OniMusculaturePrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.OniMusculatureFinalForm)) {
					player.removePerk(MutationsLib.OniMusculatureFinalForm);
					player.createPerk(MutationsLib.OniMusculatureEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.OrcAdrenalGlandsEvolved)) {
					player.removePerk(MutationsLib.OrcAdrenalGlandsEvolved);
					player.createPerk(MutationsLib.OrcAdrenalGlandsPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.OrcAdrenalGlandsFinalForm)) {
					player.removePerk(MutationsLib.OrcAdrenalGlandsFinalForm);
					player.createPerk(MutationsLib.OrcAdrenalGlandsEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.PigBoarFatEvolved)) {
					player.removePerk(MutationsLib.PigBoarFatEvolved);
					player.createPerk(MutationsLib.PigBoarFatPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.PigBoarFatFinalForm)) {
					player.removePerk(MutationsLib.PigBoarFatFinalForm);
					player.createPerk(MutationsLib.PigBoarFatEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.SalamanderAdrenalGlandsEvolved)) {
					player.removePerk(MutationsLib.SalamanderAdrenalGlandsEvolved);
					player.createPerk(MutationsLib.SalamanderAdrenalGlandsPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.SalamanderAdrenalGlandsFinalForm)) {
					player.removePerk(MutationsLib.SalamanderAdrenalGlandsFinalForm);
					player.createPerk(MutationsLib.SalamanderAdrenalGlandsEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.TwinHeartEvolved)) {
					player.removePerk(MutationsLib.TwinHeartEvolved);
					player.createPerk(MutationsLib.TwinHeartPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.TwinHeartFinalForm)) {
					player.removePerk(MutationsLib.TwinHeartFinalForm);
					player.createPerk(MutationsLib.TwinHeartEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.VampiricBloodsteamEvolved)) {
					player.removePerk(MutationsLib.VampiricBloodsteamEvolved);
					player.createPerk(MutationsLib.VampiricBloodsteamPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.VampiricBloodsteamFinalForm)) {
					player.removePerk(MutationsLib.VampiricBloodsteamFinalForm);
					player.createPerk(MutationsLib.VampiricBloodsteamEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.VenomGlandsEvolved)) {
					player.removePerk(MutationsLib.VenomGlandsEvolved);
					player.createPerk(MutationsLib.VenomGlandsPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.VenomGlandsFinalForm)) {
					player.removePerk(MutationsLib.VenomGlandsFinalForm);
					player.createPerk(MutationsLib.VenomGlandsEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.WhaleFatEvolved)) {
					player.removePerk(MutationsLib.WhaleFatEvolved);
					player.createPerk(MutationsLib.WhaleFatPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.WhaleFatFinalForm)) {
					player.removePerk(MutationsLib.WhaleFatFinalForm);
					player.createPerk(MutationsLib.WhaleFatEvolved, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.YetiFatEvolved)) {
					player.removePerk(MutationsLib.YetiFatEvolved);
					player.createPerk(MutationsLib.YetiFatPrimitive, 0, 0, 0, 0);
				}
				if (player.hasPerk(MutationsLib.YetiFatFinalForm)) {
					player.removePerk(MutationsLib.YetiFatFinalForm);
					player.createPerk(MutationsLib.YetiFatEvolved, 0, 0, 0, 0);
				}
			}
			if (player.hasPerk(MutationsLib.GorgonsEyesFinalForm)) player.removePerk(MutationsLib.GorgonsEyesFinalForm);
			doNext(camp.doCamp);
			return;
		}
		if (flags[kFLAGS.MOD_SAVE_VERSION] == 34) {
			flags[kFLAGS.MOD_SAVE_VERSION] = 35;
			clearOutput();
			outputText("Jiangshi getting Tag'd and your backpack feel somehow cheaper (no worry will get back some gems for it if needed).");
			if (player.hasKeyItem("Backpack") >= 0) player.gems += (150 * player.keyItemvX("Backpack", 1));
			if (player.hasKeyItem("Adventurer Guild: Copper plate") >= 0 && AdventurerGuild.Slot01Cap < 1) {
				outputText(" Very small present from Adventure Guild for having easier to manage all the loot ;)");
				AdventurerGuild.Slot01Cap = 10;
				AdventurerGuild.Slot02Cap = 10;
			}
			if (player.hasKeyItem("Adventurer Guild: Iron plate") >= 0 && AdventurerGuild.Slot03Cap < 1) {
				outputText(" Small present from Adventure Guild for having easier to manage all the loot ;)");
				AdventurerGuild.Slot01Cap = 10;
				AdventurerGuild.Slot02Cap = 10;
				AdventurerGuild.Slot03Cap = 10;
				AdventurerGuild.Slot04Cap = 10;
			}
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] < 2 && player.hasPerk(PerkLib.NinetailsKitsuneOfBalance) && player.perkv4(PerkLib.NinetailsKitsuneOfBalance) > 0) {
				outputText(" Opps seems your PC get Nine-tails Kitsune of Balance ahead of time... no worry you will get points back and perk pernamency will be nullified.");
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
					camp.soulforce.fixShards();
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
				if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_02985] != 0) //reset SFW mode flag just in case
					flags[kFLAGS.UNKNOWN_FLAG_NUMBER_02985] = 0;
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
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.010) {
				if (Forgefather.gender > 0) Forgefather.statueProgress++;
				if (Forgefather.wings > 0) Forgefather.statueProgress++;
				if (Forgefather.tail > 0) Forgefather.statueProgress++;
				if (Forgefather.lowerBody > 0) Forgefather.statueProgress++;
				if (Forgefather.arms > 0) Forgefather.statueProgress++;
				if (Forgefather.hairLength > 0) Forgefather.statueProgress++;
				if (Forgefather.chest > 0) Forgefather.statueProgress++;
				if (Forgefather.vagina > 0) Forgefather.statueProgress++;
				if (Forgefather.cock > 0) Forgefather.statueProgress++;
				if (Forgefather.balls > 0) Forgefather.statueProgress++;
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.010;
			}
			//TODO: disable this before the next major update, public ver. players don't need to see this.
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
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_2019] = 0; // Reclaim lethicite flag AGAIN.
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.012;
			}
			if (flags[kFLAGS.MOD_SAVE_VERSION] < 35.013) {
				//resetting Sanura riddle flags
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_0842] = 0;
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_0843] = 0;
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_0844] = 0;
				//autofix
				if (player.statStore.hasBuff("Tribulation Vestiges"))
					player.statStore.removeBuffs("Tribulation Vestiges");
				flags[kFLAGS.MOD_SAVE_VERSION] = 35.013;
			}
			outputText("\n\n<i>Save</i> version updated to " + flags[kFLAGS.MOD_SAVE_VERSION] + "\n");
			doNext(camp.doCamp);
			return;
			/*
            flags[kFLAGS.MOD_SAVE_VERSION] = 36;
            clearOutput();
            outputText("Text.");
            //Jtecx fixes
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
            */
		}
		camp.doCamp();
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
		player.skin.coat.color = color;
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
		if (player.weapon != WeaponLib.FISTS) {
			if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 2) {
				flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 1;
				player.setWeapon(WeaponLib.FISTS);
				jiangshiBuggedItemsCleanUpCrew();
				return;
			}
			else {
				inventory.takeItem(player.setWeapon(WeaponLib.FISTS), jiangshiBuggedItemsCleanUpCrew);
				return;
			}
		}
		if (player.weaponRange != WeaponRangeLib.NOTHING) {
			inventory.takeItem(player.setWeaponRange(WeaponRangeLib.NOTHING), jiangshiBuggedItemsCleanUpCrew);
			return;
		}
		if (player.shield != ShieldLib.NOTHING) {
			if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 2) {
				flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 1;
				player.setShield(ShieldLib.NOTHING);
				jiangshiBuggedItemsCleanUpCrew();
				return;
			}
			else {
				inventory.takeItem(player.setShield(ShieldLib.NOTHING), jiangshiBuggedItemsCleanUpCrew);
				return;
			}
		}
		if (player.armor != ArmorLib.NOTHING) {
			if (player.armor == armors.GOOARMR) player.armor.removeText();
			inventory.takeItem(player.setArmor(armors.TRADITC), jiangshiBuggedItemsCleanUpCrew);
			return;
		}
		if (player.lowerGarment != UndergarmentLib.NOTHING) {
			inventory.takeItem(player.setUndergarment(UndergarmentLib.NOTHING, UndergarmentLib.TYPE_LOWERWEAR), jiangshiBuggedItemsCleanUpCrew);
			return;
		}
		if (player.upperGarment != UndergarmentLib.NOTHING) {
			inventory.takeItem(player.setUndergarment(UndergarmentLib.NOTHING, UndergarmentLib.TYPE_UPPERWEAR), jiangshiBuggedItemsCleanUpCrew);
			return;
		}
		if (player.headJewelry != HeadJewelryLib.NOTHING) flags[kFLAGS.PLAYER_DISARMED_HEAD_ACCESORY_ID] = player.headJewelry.id;
		player.setHeadJewelry(headjewelries.JIANGCT);
		player.statStore.replaceBuffObject({'str.mult':0.2,'tou.mult':0.2,'lib.mult':0.2,'sens':80}, 'Jiangshi Curse Tag', { text: 'Jiangshi Curse Tag' });
	}

}
}