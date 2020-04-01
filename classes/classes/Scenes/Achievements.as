package classes.Scenes 
{
import classes.*;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.CoC;

public class Achievements extends BaseContent
	{
		public var achievementsEarned:int = 0;
		public var achievementsShadowEarned:int = 0;
		public var achievementsTotalCurrentlyUnlocked:int = 0;
		public var achievementsTotal:int = 0;
		
		public function Achievements() 
		{
			
		}
		
		public function addAchievement(title:String, achievement:*, descLocked:String, descUnlocked:String = "", isShadow:Boolean = false):void {
			//If not specified, default to the locked description.
			if (descUnlocked == "") descUnlocked = descLocked;
			if (isShadow && achievements[achievement] <= 0) return;
			//Set text.
			outputText("<li><b>" + title + ":</b> ");
			if (achievements[achievement] > 0) {
				outputText("<font color=\"#008000\">Unlocked</font> - " + descUnlocked);
				achievementsTotalCurrentlyUnlocked++;
				achievementsEarned++;
			}
			else outputText("<font color=\"#800000\">Locked</font> - " + descLocked);
			if (isShadow) {
				outputText(" - <font color=\"#660066\">Shadow Achievement</font>");
				achievementsTotalCurrentlyUnlocked++;
				achievementsShadowEarned++;
			}
			outputText("</li>");
			achievementsTotal++;
		}
		
		public function titleAchievementSection(title:String):void {
			outputText("\n<b><u>" + title + "</u></b>\n");
		}
		
		public function achievementsScreen():void {
			achievementsEarned = 0;
			achievementsShadowEarned = 0;
			achievementsTotalCurrentlyUnlocked = 0;
			achievementsTotal = 0;
			clearOutput();
			EngineCore.displayHeader("Achievements");
			outputText("Note: Some achievements are contradictory and may require multiple playthroughs to obtain every achievement.\n");
			titleAchievementSection("Storyline"); //4 achievements
			addAchievement("Newcomer", kACHIEVEMENTS.STORY_NEWCOMER, "Enter the realm of Mareth.");
			addAchievement("Marae's Savior", kACHIEVEMENTS.STORY_MARAE_SAVIOR, "Complete Marae's quest.");
			addAchievement("Revenge at Last", kACHIEVEMENTS.STORY_ZETAZ_REVENGE, "Defeat Zetaz and obtain the map.");
			addAchievement("Demon Slayer", kACHIEVEMENTS.STORY_FINALBOSS, "Defeat Lethice.");
			
			titleAchievementSection("Zones"); //23 achievements
			addAchievement("Explorer", kACHIEVEMENTS.ZONE_EXPLORER, "Discover every zone.");
			addAchievement("Sightseer", kACHIEVEMENTS.ZONE_SIGHTSEER, "Discover every place.");
			addAchievement("Where am I?", kACHIEVEMENTS.ZONE_WHERE_AM_I, "Explore for the first time.");
			addAchievement("Forest Ranger", kACHIEVEMENTS.ZONE_FOREST_RANGER, "Explore the forest 100 times.");
			addAchievement("Vacationer", kACHIEVEMENTS.ZONE_VACATIONER, "Explore the lake 100 times.");
			addAchievement("Dehydrated", kACHIEVEMENTS.ZONE_DEHYDRATED, "Explore the desert 100 times.");
			addAchievement("Rookie", kACHIEVEMENTS.ZONE_ROOKIE, "Explore the outer battlefield 100 times.");
			addAchievement("Mountaineer", kACHIEVEMENTS.ZONE_MOUNTAINEER, "Explore the mountains 100 times.");
			addAchievement("Rolling Hills", kACHIEVEMENTS.ZONE_ROLLING_HILLS, "Explore the plains 100 times.");
			addAchievement("Wet All Over", kACHIEVEMENTS.ZONE_WET_ALL_OVER, "Explore the swamp 100 times.");
			addAchievement("Tainted", kACHIEVEMENTS.ZONE_TAINTED, "Explore the blight ridge 100 times");
			addAchievement("We Need to Go Deeper", kACHIEVEMENTS.ZONE_WE_NEED_TO_GO_DEEPER, "Explore the deepwoods 100 times.");
			//addAchievement("Jumanji", kACHIEVEMENTS., "Explore the jungle 100 times.");
			addAchievement("Sunburned", kACHIEVEMENTS.ZONE_SUNBURNED, "Explore the beach 100 times.");
			addAchievement("Caveman", kACHIEVEMENTS.ZONE_CAVEMAN, "Explore the caves 100 times.");
			addAchievement("Light-headed", kACHIEVEMENTS.ZONE_LIGHT_HEADED, "Explore the high mountains 100 times.");
			addAchievement("All Murky", kACHIEVEMENTS.ZONE_ALL_MURKY, "Explore the bog 100 times.");
			addAchievement("Sea-Legs", kACHIEVEMENTS.ZONE_SAILOR, "Explore the ocean 100 times.");
			//addAchievement("Spelunker", kACHIEVEMENTS., "Explore the deep caves 100 times.");
			//addAchievement("", kACHIEVEMENTS., "Explore the tundra 100 times.");
			addAchievement("Frozen", kACHIEVEMENTS.ZONE_FROZEN, "Explore the glacial rift 100 times.");
			//addAchievement("Ashes to ashes, dust to dust", kACHIEVEMENTS.ZONE_ASHES_TO_ASHES_DUST_TO_DUST, "Explore the ashlands 100 times.");
			addAchievement("Roasted", kACHIEVEMENTS.ZONE_ROASTED, "Explore the volcanic crag 100 times.");
			addAchievement("Diver", kACHIEVEMENTS.ZONE_DIVER, "Explore the deep sea 100 times.");
			addAchievement("Archaeologist", kACHIEVEMENTS.ZONE_ARCHAEOLOGIST, "Explore the town ruins 15 times.");
			addAchievement("Farmer", kACHIEVEMENTS.ZONE_FARMER, "Visit Whitney's farm 30 times.");
			addAchievement("Sailor", kACHIEVEMENTS.ZONE_SEA_LEGS, "Use the lake boat 15 times.");
			
			titleAchievementSection("Levels"); //13 achievements
			addAchievement("Level up!", kACHIEVEMENTS.LEVEL_LEVEL_UP, "Get to level 2.");
			addAchievement("Novice", kACHIEVEMENTS.LEVEL_NOVICE, "Get to level 5.");
			addAchievement("Apprentice", kACHIEVEMENTS.LEVEL_APPRENTICE, "Get to level 10.");
			addAchievement("Journeyman", kACHIEVEMENTS.LEVEL_JOURNEYMAN, "Get to level 15.");
			addAchievement("Expert", kACHIEVEMENTS.LEVEL_EXPERT, "Get to level 20.");
			addAchievement("Master", kACHIEVEMENTS.LEVEL_MASTER, "Get to level 30.");
			addAchievement("Grandmaster", kACHIEVEMENTS.LEVEL_GRANDMASTER, "Get to level 45.");
			addAchievement("Illuistrous", kACHIEVEMENTS.LEVEL_ILLUSTRIOUS, "Get to level 60.");
			addAchievement("Overlord", kACHIEVEMENTS.LEVEL_OVERLORD, "Get to level 75.");
			addAchievement("Sovereign", kACHIEVEMENTS.LEVEL_SOVEREIGN, "Get to level 90.");
			addAchievement("Are you a god?", kACHIEVEMENTS.LEVEL_ARE_YOU_A_GOD, "Get to level 100.", "Get to level 100. (Your powers would have surpassed weakest god by now.)", true);
			addAchievement("Newb God(ess)", kACHIEVEMENTS.LEVEL_NEWB_GOD_ESS, "Get to level 120.", "Get to level 120. (You still new to all this 'god' stuff.)", true);
			addAchievement("Mid-tier God(ess)", kACHIEVEMENTS.LEVEL_MID_TIER_GOD_ESS, "Get to level 150.", "Get to level 150. (No more called newb god(ess) at least.)", true);
			//lvl 180// (Your powers would have surpassed Marae's by now.)
			
			titleAchievementSection("Population"); //21 achievements
			addAchievement("My First Companion", kACHIEVEMENTS.POPULATION_FIRST, "Have a camp population of 2.");
			addAchievement("Hamlet", kACHIEVEMENTS.POPULATION_HAMLET, "Have a camp population of 5.");
			addAchievement("Village", kACHIEVEMENTS.POPULATION_VILLAGE, "Have a camp population of 10.");
			addAchievement("Town", kACHIEVEMENTS.POPULATION_TOWN, "Have a camp population of 25.");
			addAchievement("City", kACHIEVEMENTS.POPULATION_CITY, "Have a camp population of 100.");
			addAchievement("Metropolis", kACHIEVEMENTS.POPULATION_METROPOLIS, "Have a camp population of 250.");
			addAchievement("Megalopolis", kACHIEVEMENTS.POPULATION_MEGALOPOLIS, "Have a camp population of 500.");
			addAchievement("City-State", kACHIEVEMENTS.POPULATION_CITY_STATE, "Have a camp population of 1,000.", "", true);
			addAchievement("Kingdom", kACHIEVEMENTS.POPULATION_KINGDOM, "Have a camp population of 2,500.", "", true);
			addAchievement("Empire", kACHIEVEMENTS.POPULATION_EMPIRE, "Have a camp population of 5,000.", "", true);
			addAchievement("Large Empire", kACHIEVEMENTS.POPULATION_LARGE_EMPIRE, "Have a camp population of 10,000.", "", true);
			addAchievement("My First Underground Companion", kACHIEVEMENTS.UNDERGROUND_POPULATION_FIRST, "Have an underground camp population of 1.");
			addAchievement("Underground Hamlet", kACHIEVEMENTS.UNDERGROUND_POPULATION_HAMLET, "Have an underground camp population of 20.");
			addAchievement("Underground Village", kACHIEVEMENTS.UNDERGROUND_POPULATION_VILLAGE, "Have an underground camp population of 50.");
			addAchievement("Underground Town", kACHIEVEMENTS.UNDERGROUND_POPULATION_TOWN, "Have an underground camp population of 100.");
			addAchievement("Underground City", kACHIEVEMENTS.UNDERGROUND_POPULATION_CITY, "Have an underground camp population of 250.");
			addAchievement("Underground Metropolis", kACHIEVEMENTS.UNDERGROUND_POPULATION_METROPOLIS, "Have an underground camp population of 500.");
			addAchievement("Underground Megalopolis", kACHIEVEMENTS.UNDERGROUND_POPULATION_MEGALOPOLIS, "Have an underground camp population of 1,000.");
			addAchievement("Underground Large Megalopolis", kACHIEVEMENTS.UNDERGROUND_POPULATION_LARGE_MEGALOPOLIS, "Have an underground camp population of 2,500.", "", true);
			addAchievement("Underground City-State", kACHIEVEMENTS.UNDERGROUND_POPULATION_CITY_STATE, "Have an underground camp population of 5,000.", "", true);
			addAchievement("Underground Kingdom", kACHIEVEMENTS.UNDERGROUND_POPULATION_KINGDOM, "Have an underground camp population of 10,000.", "", true);
			
			titleAchievementSection("Time"); //9 achievements
			addAchievement("It's been a month", kACHIEVEMENTS.TIME_MONTH, "Get to day 30.");
			addAchievement("Quarter", kACHIEVEMENTS.TIME_QUARTER, "Get to day 90.");
			addAchievement("Half-year", kACHIEVEMENTS.TIME_HALF_YEAR, "Get to day 180.");
			addAchievement("Annual", kACHIEVEMENTS.TIME_ANNUAL, "Get to day 365. (1 year)");
			addAchievement("Biennial", kACHIEVEMENTS.TIME_BIENNIAL, "Get to day 730. (2 years)");
			addAchievement("Triennial", kACHIEVEMENTS.TIME_TRIENNIAL, "Get to day 1,095. (3 years)");
			addAchievement("In for the long haul", kACHIEVEMENTS.TIME_LONG_HAUL, "Get to day 1,825. (5 years)");
			addAchievement("Decade", kACHIEVEMENTS.TIME_DECADE, "Get to day 3,650. (10 years)", "Get to day 3,650. (10 years | Okay, you can stop now.)", true);
			addAchievement("Century", kACHIEVEMENTS.TIME_CENTURY, "Get to day 36,500. (100 years)", "Get to day 36,500. (100 years | It's time to stop playing. Go outside.)", true);
			addAchievement("Time Traveller", kACHIEVEMENTS.TIME_TRAVELLER, "Get to day 36,500+ by tampering with save", "", true);
			
			titleAchievementSection("Dungeons"); //23 achievements
			addAchievement("Delver", kACHIEVEMENTS.DUNGEON_DELVER, "Clear any dungeon.");
			addAchievement("Delver Apprentice", kACHIEVEMENTS.DUNGEON_DELVER, "Clear 2 dungeons.");
			addAchievement("Delver Expert", kACHIEVEMENTS.DUNGEON_DELVER_MASTER, "Clear 4 dungeons.");
			addAchievement("Delver Master", kACHIEVEMENTS.DUNGEON_DELVER_EXPERT, "Clear 8 dungeons.");
			addAchievement("Delver Grand Master", kACHIEVEMENTS.DUNGEON_DELVER_GRAND_MASTER, "Clear 16 dungeons.");
			addAchievement("Shut Down Everything", kACHIEVEMENTS.DUNGEON_SHUT_DOWN_EVERYTHING, "Clear the Factory.");
			addAchievement("You're in Deep", kACHIEVEMENTS.DUNGEON_YOURE_IN_DEEP, "Fully clear the Deep Cave.");
			addAchievement("End of Reign", kACHIEVEMENTS.DUNGEON_END_OF_REIGN, "Fully clear the Lethice Stronghold.");
			addAchievement("Friend of the Sand Witches", kACHIEVEMENTS.DUNGEON_SAND_WITCH_FRIEND, "Fully clear the Desert Cave.");
			addAchievement("Fall of the Phoenix", kACHIEVEMENTS.DUNGEON_PHOENIX_FALL, "Clear the Tower of the Phoenix.");
			addAchievement("Accomplice", kACHIEVEMENTS.DUNGEON_ACCOMPLICE, "Watch Helia kill the Harpy Queen.", "", true);
			addAchievement("Extremely Celibate Delver", kACHIEVEMENTS.DUNGEON_EXTREMELY_CHASTE_DELVER, "Complete Phoenix Tower without ever orgasming from the beginning.", "", true);
			addAchievement("Tiger stalking the Dragon", kACHIEVEMENTS.DUNGEON_TIGER_STALKING_THE_DRAGON, "Fully clear the Hidden Cave.");
			addAchievement("Slain the Heroslayer", kACHIEVEMENTS.DUNGEON_SLAIN_THE_HEROSLAYER, "Fully clear the Den of Desire.");
			addAchievement("Mirror Flower, Water Moon", kACHIEVEMENTS.DUNGEON_MIRROR_FLOWER_WATER_MOON, "Clear the River Dungeon.");
			addAchievement("Dungeon Seeker (1st layer)", kACHIEVEMENTS.DUNGEON_DUNGEON_SEEKER_1ST_LAYER, "Clear 1st floor of the River Dungeon.");
			//addAchievement("Dungeon Seeker (2nd layer)", kACHIEVEMENTS., "Clear 2nd floor of the River Dungeon.");
			//addAchievement("Dungeon Seeker (3rd layer)", kACHIEVEMENTS., "Clear 3rd floor of the River Dungeon.");
			//addAchievement("Dungeon Seeker (4th layer)", kACHIEVEMENTS., "Clear 4th floor of the River Dungeon.");
			addAchievement("Honorary Minotaur", kACHIEVEMENTS.DUNGEON_HONORARY_MINOTAUR, "Reach 50th room of Ebon Labyrinth. Clear the Ebon Labyrinth.");
			addAchievement("Got lost?", kACHIEVEMENTS.DUNGEON_GOT_LOST, "Reach 100th room of Ebon Labyrinth.");
			addAchievement("Hug the left wall", kACHIEVEMENTS.DUNGEON_HUG_THE_LEFT_WALL, "Reach 150th room of Ebon Labyrinth.");
			addAchievement("Pan ain't got nothing on you", kACHIEVEMENTS.DUNGEON_PAN_AINT_GOT_NOTHING_ON_YOU, "Reach 200th room of Ebon Labyrinth.");
			addAchievement("Master of the labyrinth", kACHIEVEMENTS.DUNGEON_MASTER_OF_THE_LABYRINT, "Reach 250th room of Ebon Labyrinth.");
			addAchievement("Why are you here?", kACHIEVEMENTS.DUNGEON_WHY_ARE_YOU_HERE, "Reach 300th room of Ebon Labyrinth.");
			//addAchievement("", kACHIEVEMENTS., "Reach 350th room of Ebon Labyrinth.");
			//addAchievement("", kACHIEVEMENTS., "Reach 400th room of Ebon Labyrinth.");
			addAchievement("Four heads better then one", kACHIEVEMENTS.DUNGEON_DUNGEONMASTER, "Defeat the Chimera Boss in Ebon Labyrinth.");
			
			titleAchievementSection("Fashion"); //24 achievements
			addAchievement("Wannabe Wizard", kACHIEVEMENTS.FASHION_WANNABE_WIZARD, "Equip wizard robes and magic staff.");
			addAchievement("Cosplayer (Begginer)", kACHIEVEMENTS.FASHION_COSPLAYER, "Wear 10 different clothings/armors.");
			addAchievement("Cosplayer (Amateour)", kACHIEVEMENTS.FASHION_COSPLAYER_1, "Wear 30 different clothings/armors.");
			addAchievement("Cosplayer (Recognizable)", kACHIEVEMENTS.FASHION_COSPLAYER_2, "Wear 60 different clothings/armors.");
			addAchievement("Cosplayer (Seasonal)", kACHIEVEMENTS.FASHION_COSPLAYER_3, "Wear 100 different clothings/armors.");
			addAchievement("Cosplayer (Proffesional)", kACHIEVEMENTS.FASHION_COSPLAYER_4, "Wear 150 different clothings/armors.");
			//addAchievement("Jessica Nigri apprentice", kACHIEVEMENTS.FASHION_COSPLAYER_3, "Wear 135 different clothings/armors.");
			//addAchievement("Yaya Han apprentice", kACHIEVEMENTS.FASHION_COSPLAYER_4, "Wear 290 different clothings/armors.");
			addAchievement("Dominatrix", kACHIEVEMENTS.FASHION_DOMINATRIX, "Wear any form of kinky clothing and wield any form of whip.");
			addAchievement("Going Commando", kACHIEVEMENTS.FASHION_GOING_COMMANDO, "Wear no undergarments while wearing any clothes or armours.");
			addAchievement("Bling Bling", kACHIEVEMENTS.FASHION_BLING_BLING, "Wear ring that is valued at least 1,000 gems.");
			addAchievement("Ka-Ching!", kACHIEVEMENTS.FASHION_KA_CHING, "Wear necklace that is valued at least 5,000 gems.");
			addAchievement("Royalty", kACHIEVEMENTS.FASHION_ROYALTY, "Wear head accessory that is valued at least 4,000 gems.");
			addAchievement("Hellblazer", kACHIEVEMENTS.FASHION_HELLBLAZER, "Equip all fire protection accessories.");
			addAchievement("Less than Zero", kACHIEVEMENTS.FASHION_LESS_THAN_ZERO, "Equip all ice protection accessories.");
			addAchievement("Thunderstuck", kACHIEVEMENTS.FASHION_THUNDERSTUCK, "Equip all lightning protection accessories.");
			addAchievement("Darkness Within", kACHIEVEMENTS.FASHION_DARKNESS_WITHIN, "Equip all darkness protection accessories.");
			addAchievement("Poison Ivy", kACHIEVEMENTS.FASHION_POISON_IVY, "Equip all poison protection accessories.");
			addAchievement("Playboy Bunny", kACHIEVEMENTS.FASHION_POLAYBOY_BUNNY, "Equip all lust protection accessories.");
			addAchievement("Throne of Intelligence", kACHIEVEMENTS.FASHION_THRONE_OF_INTELLIGENCE, "Equip all intelligence boosting accessories.");
			addAchievement("Throne of Libido", kACHIEVEMENTS.FASHION_THRONE_OF_LIBIDO, "Equip all libido boosting accessories.");
			addAchievement("Throne of Sensitivity", kACHIEVEMENTS.FASHION_THRONE_OF_SENSITIVITY, "Equip all sensitivity boosting accessories.");
			addAchievement("Throne of Speed", kACHIEVEMENTS.FASHION_THRONE_OF_SPEED, "Equip all speed boosting accessories.");
			addAchievement("Throne of Strength", kACHIEVEMENTS.FASHION_THRONE_OF_STRENGTH, "Equip all strength boosting accessories.");
			addAchievement("Throne of Toughness", kACHIEVEMENTS.FASHION_THRONE_OF_TOUGHNESS, "Equip all toughness boosting accessories.");
			addAchievement("Throne of Wisdom", kACHIEVEMENTS.FASHION_THRONE_OF_WISDOM, "Equip all wisdom boosting accessories.");
			addAchievement("Suit Up!", kACHIEVEMENTS.FASHION_SUIT_UP, "Equip any vehicle.");
			addAchievement("Rollin'", kACHIEVEMENTS.FASHION_SUIT_UP, "Equip Goblin Mech Prime.", "", true);
			
			titleAchievementSection("Wealth"); //9 achievements
			addAchievement("Rich", kACHIEVEMENTS.WEALTH_RICH, "Have 1,000 gems.");
			addAchievement("Hoarder", kACHIEVEMENTS.WEALTH_HOARDER, "Have 10,000 gems.");
			addAchievement("Gem Vault", kACHIEVEMENTS.WEALTH_GEM_VAULT, "Have 100,000 gems.");
			addAchievement("Millionaire", kACHIEVEMENTS.WEALTH_MILLIONAIRE, "Have 1,000,000 gems.", "Have 1,000,000 gems. What are you going to spend these gems on?", true);
			addAchievement("Poor Daoist", kACHIEVEMENTS.WEALTH_POOR_DAOIST, "Have 200 spirit stones.");
			addAchievement("Sect's Conclave Student", kACHIEVEMENTS.WEALTH_SECTS_CONCLAVE_STUDENT, "Have 2,000 spirit stones.");
			addAchievement("Sect's Head Elder", kACHIEVEMENTS.WEALTH_SECTS_HEAD_ELDER, "Have 20,000 spirit stones.");
			addAchievement("Sect's Patriarch", kACHIEVEMENTS.WEALTH_SECTS_PATRIARCH, "Have 500,000 spirit stones.", "Have 500,000 spirit stones. Maybe it's time to retreat into a secluded cultivation?", true);
			addAchievement("Meng Hao", kACHIEVEMENTS.WEALTH_MENG_HAO, "Have 20,000,000 spirit stones.", "Have 20,000,000 spirit stones. You can now exchange tips on getting more spirit stones with Meng Hao himself.", true);
			//addAchievement("Item Vault", kACHIEVEMENTS.WEALTH_ITEM_VAULT, "Fill up your inventory, chest, jewelry box, weapon and armor racks.");
			
			titleAchievementSection("Combat"); //18 achievements
			addAchievement("Are you a Wizard?", kACHIEVEMENTS.COMBAT_ARE_YOU_A_WIZARD, "Cast your first spell.");
			addAchievement("Gandalf", kACHIEVEMENTS.COMBAT_GANDALF, "Learn all white spells.");
			addAchievement("Sauron", kACHIEVEMENTS.COMBAT_SAURON, "Learn all black spells.");
			addAchievement("Merlin", kACHIEVEMENTS.COMBAT_WIZARD, "Learn all black and white spells from spell books.");
			//learn all grey spells
			//learn all white/black/grey spells
			addAchievement("Cum Cannon", kACHIEVEMENTS.COMBAT_CUM_CANNON, "Cum in the middle of battle.");
			addAchievement("How Do I Shot Web?", kACHIEVEMENTS.COMBAT_SHOT_WEB, "Fire your webbings at your opponent.");
			addAchievement("Pain", kACHIEVEMENTS.COMBAT_PAIN, "Deal 50 damage in one hit.");
			addAchievement("Fractured Limbs", kACHIEVEMENTS.COMBAT_FRACTURED_LIMBS, "Deal 100 damage in one hit.");
			addAchievement("Broken Bones", kACHIEVEMENTS.COMBAT_BROKEN_BONES, "Deal 250 damage in one hit.");
			addAchievement("Overkill", kACHIEVEMENTS.COMBAT_OVERKILL, "Deal 500 damage in one hit.");
			addAchievement("Meat Pasty", kACHIEVEMENTS.COMBAT_MEAT_PASTY, "Deal 1,000 damage in one hit.", "", true);
			addAchievement("Pulverize", kACHIEVEMENTS.COMBAT_PULVERIZE, "Deal 2,500 damage in one hit.", "", true);
			addAchievement("Erase", kACHIEVEMENTS.COMBAT_ERASE, "Deal 5,000 damage in one hit.", "", true);
			//addAchievement("Damage Sponge", kACHIEVEMENTS.COMBAT_DAMAGE_SPONGE, "Take a total of 10,000 damage.");//ustawić na wiecej niż 10k np. 100k?
			addAchievement("Bloodletter", kACHIEVEMENTS.COMBAT_BLOOD_LETTER, "Deal a total of 50,000 damage.");
			addAchievement("Reiterpallasch", kACHIEVEMENTS.COMBAT_REITERPALLASCH, "Deal a total of 200,000 damage.");
			addAchievement("Uncanny Bloodletter", kACHIEVEMENTS.COMBAT_UNCANNY_BLOOD_LETTER, "Deal a total of 1,000,000 damage.", "", true);
			addAchievement("Uncanny Reiterpallasch", kACHIEVEMENTS.COMBAT_UNCANNY_REITERPALLASCH, "Deal a total of 5,000,000 damage.", "", true);
			addAchievement("Arrow to the Knee", kACHIEVEMENTS.COMBAT_ARROW_TO_THE_KNEE, "Use your bow/crossbow for a first time.");
			
			titleAchievementSection("Holiday Events"); //10 achievements
			addAchievement("Egg Hunter", kACHIEVEMENTS.HOLIDAY_EGG_HUNTER, "Find 10 eggs as random drops during Easter event.", "", true);
			addAchievement("Happy Birthday, Helia!", kACHIEVEMENTS.HOLIDAY_HELIA_BIRTHDAY, "Participate into Helia's birthday event. (August)", "", true);
			addAchievement("Thankslutting", kACHIEVEMENTS.HOLIDAY_THANKSGIVING_I, "Meet the Piggy-Slut (Thanksgiving)", "", true);
			addAchievement("Gobble Gobble", kACHIEVEMENTS.HOLIDAY_THANKSGIVING_II, "Meet the Cockgobbler (Thanksgiving)", "", true);
			addAchievement("Pump-kin-kin-kin", kACHIEVEMENTS.HOLIDAY_HALLOWEEN_I, "Find the pumpkin (Halloween)", "", true);
			addAchievement("Fera's Wonderland", kACHIEVEMENTS.HOLIDAY_HALLOWEEN_II, "Free Fera/Visit her wonderland (Halloween)", "", true);
			addAchievement("Naughty or Nice", kACHIEVEMENTS.HOLIDAY_CHRISTMAS_I, "Meet the X-mas Elf (Christmas)", "", true);
			addAchievement("A Christmas Carol", kACHIEVEMENTS.HOLIDAY_CHRISTMAS_II, "Complete Carol's mini-quest (Christmas)", "", true);
			addAchievement("The Lovable Snowman", kACHIEVEMENTS.HOLIDAY_CHRISTMAS_III, "Have Nieve as lover (Christmas/Winter)", "", true);
			addAchievement("Will You Be My Valentine?", kACHIEVEMENTS.HOLIDAY_VALENTINE, "Visit the Wet Bitch during Valentine's day. (Valentine)", "", true);
			
			titleAchievementSection("Survival/Realistic Mode"); //15 achievements
			addAchievement("Tastes Like Chicken", kACHIEVEMENTS.REALISTIC_TASTES_LIKE_CHICKEN, "Refill your hunger for the first time.");
			addAchievement("Champion Needs Food Badly (1)", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD, "Instantly refill your hunger from 0 to 100 in one go.");
			addAchievement("Champion Needs Food Badly (2)", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD_2, "Instantly refill your hunger from 0 to 250 in one go.");
			addAchievement("Champion Needs Food Badly (3)", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD_3, "Instantly refill your hunger from 0 to 500 in one go.");
			addAchievement("Champion Needs Food Badly (4)", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD_4, "Instantly refill your hunger from 0 to 1000 in one go.");
			//addAchievement("Champion Needs Food Badly (5)", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD, "Instantly refill your hunger from 0 to 2500 in one go.");
			//addAchievement("Champion Needs Food Badly (6)", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD, "Instantly refill your hunger from 0 to 5000 in one go.");
			//addAchievement("Gourmand", kACHIEVEMENTS.REALISTIC_GOURMAND, "Refill hunger from 5 different sources.");
			addAchievement("Glutton", kACHIEVEMENTS.REALISTIC_GLUTTON, "Eat while hunger is above 90.");
			addAchievement("Epic Glutton", kACHIEVEMENTS.REALISTIC_EPIC_GLUTTON, "Eat while hunger is above 240.");
			addAchievement("Legendary Glutton", kACHIEVEMENTS.REALISTIC_LEGENDARY_GLUTTON, "Eat while hunger is above 490.");
			addAchievement("Mythical Glutton", kACHIEVEMENTS.REALISTIC_MYTHICAL_GLUTTON, "Eat while hunger is above 990.");
			//addAchievement(" Glutton", kACHIEVEMENTS., "Eat while hunger is above 2490.", "", true);
			//addAchievement(" Glutton", kACHIEVEMENTS., "Eat while hunger is above 4990.", "", true);
			addAchievement("Fasting", kACHIEVEMENTS.REALISTIC_FASTING, "Keep hunger below 25 for a week but don't let it reach 0.");
			addAchievement("Lent", kACHIEVEMENTS.REALISTIC_LENT, "Keep hunger below 25 for fourty days but don't let it reach 0.", "Keep hunger below 25 for fourty days but don't let it reach 0. Now you're ready for Easter.", true);
			addAchievement("One more dish please", kACHIEVEMENTS.REALISTIC_ONE_MORE_DISH_PLEASE, "Increase your maximum hunger above 100.");
			addAchievement("You not gonna eat those ribs?", kACHIEVEMENTS.REALISTIC_YOU_NOT_GONNA_EAT_THOSE_RIBS, "Increase your maximum hunger above 250.");
			addAchievement("Dinner for Four", kACHIEVEMENTS.REALISTIC_DINNER_FOR_FOUR, "Increase your maximum hunger above 500.");
			addAchievement("Dinner for Obelix", kACHIEVEMENTS.REALISTIC_DINNER_FOR_OBELIX, "Increase your maximum hunger above 1000.");
			//HIDDEN ACHIEV - HUNGER OVER 2500 (feast for gluttons)
			//HIDDEN ACHIEV - HUNGER OVER 5000 (tang wuxlin eating buddy)
			//keep hunger above 0 with  5 internal mutation score
			//keep hunger above 0 with 10 internal mutation score
			//keep hunger above 0 with 20 internal mutation score
			//keep hunger above 0 with 40 internal mutation score
			//eat 15 pts over max hunger without gaining weight
			//eat 30 pts over max hunger without gaining weight
			//eat 50 pts over max hunger without gaining weight
			//eat 75 pts over max hunger without gaining weight (perki muszą dać zwiekszenie limitu przejedzenia sie bez przyrostu wagi ^^)
			
			titleAchievementSection("Epic"); //16 achievements
			addAchievement("xXx2: The Next Level", kACHIEVEMENTS.EPIC_XXX2_THE_NEXT_LEVEL, "Start NG+ (or higher) game.", "", true);
			addAchievement("xXx: The Return of Mareth Champion", kACHIEVEMENTS.EPIC_XXX_THE_RETURN_OF_MARETH_CHAMPION, "Start NG++ (or higher) game.", "", true);
			addAchievement("xXx 4", kACHIEVEMENTS.EPIC_XXX_4, "Start NG+++ (or higher) game.", "", true);
			addAchievement("xXx 5: Mareth's Judgment_Day", kACHIEVEMENTS.EPIC_XXX5_MARETHS_JUDGMENT_DAY, "Start NG 4+ (or higher) game.", "", true);
			addAchievement("xXx 6: Rise of the Demons", kACHIEVEMENTS.EPIC_XXX6_RISE_OF_THE_DEMONS, "Start NG 5+ (or higher) game.", "", true);
			//addAchievement("xXx 7: Salvation", kACHIEVEMENTS.EPIC_XXX7_SALVATION, "Start NG 6+ (or higher) game.", "", true);
			//addAchievement("xXx 8: Genisys", kACHIEVEMENTS.EPIC_XXX8_GENISYS, "Start NG 7+ (or higher) game.", "", true);
			//addAchievement("xXx 9: Dark Fate", kACHIEVEMENTS.EPIC_XXX9_DARK_FATE, "Start NG 8+ (or higher) game.", "", true);
			addAchievement("Guardian of Notre-Dame", kACHIEVEMENTS.EPIC_GUARDIAN_OF_NOTRE_DAME, "Become Gargoyle.", "", true);
			addAchievement("The Devil Wears Prada", kACHIEVEMENTS.EPIC_THE_DEVIL_WEARS_PRADA, "Became Devil.", "", true);
			addAchievement("Thriller", kACHIEVEMENTS.EPIC_THRILLER, "Became Jiangshi.", "", true);
			//odblokowanie pierwszego animal ancestory starting bonus at chara creation
			addAchievement("My own Demon Weapon", kACHIEVEMENTS.EPIC_MY_OWN_DEMON_WEAPON, "Find an evolving weapon.", "", true);
			//znalezienie ewolującą zbroje
			addAchievement("Me Evolve", kACHIEVEMENTS.EPIC_ME_EVOLVE, "Find one evolving items.", "", true);
			addAchievement("Us Evolve", kACHIEVEMENTS.EPIC_US_EVOLVE, "Find two evolving items.", "", true);
			//znalezienie 4 ewolujących przedmiotów
			//znalezienie 8 ewolujących przedmiotów
			//przeprowadzenie 1 ewolucji przedmiotu
			//przeprowadzenie 2 ewolucji przedmiotu
			//przeprowadzenie 4 ewolucji przedmiotu
			//przeprowadzenie 8 ewolucji przedmiotu
			addAchievement("Let's go fishing!", kACHIEVEMENTS.EPIC_LETS_GO_FISHING, "Beat down Kaiju type enemy in Mech.", "", true);
			addAchievement("Achievementception", kACHIEVEMENTS.EPIC_ACHIEVEMENTCEPTION, "Unlocking 10 achievements.", "", true);
			addAchievement("Achievement within Achievement", kACHIEVEMENTS.EPIC_ACHIEVEMENT_WITHIN_ACHIEVEMENT, "Unlocking 30 achievements.", "", true);
			addAchievement("Achievements - Going Deeper (1st layer)", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_GOING_DEEPER_1L, "Unlocking 60 achievements.", "", true);
			addAchievement("Achievements - Going Deeper (2nd layer)", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_GOING_DEEPER_2L, "Unlocking 100 achievements.", "", true);
			addAchievement("Achievements - Going Deeper (3rd layer)", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_GOING_DEEPER_3L, "Unlocking 300 achievements.", "", true);
			addAchievement("Achievements Limbo", kACHIEVEMENTS.EPIC_ACHIEVEMENTS_LIMBO, "Unlocking 600 achievements.", "", true);
			
			titleAchievementSection("Shadow Slave"); //5 achievements
			addAchievement("Shadow Initiate", kACHIEVEMENTS.SHADOW_INITIATE, "Unlock first shadow achievement.", "", true);
			addAchievement("Shadow Squire", kACHIEVEMENTS.SHADOW_SQUIRE, "Unlock 10 shadow achievements.", "", true);
			addAchievement("Shadow Knight", kACHIEVEMENTS.SHADOW_KNIGHT, "Unlock 25 shadow achievements.", "", true);
			addAchievement("Shadow Paladin", kACHIEVEMENTS.SHADOW_PALADIN, "Unlock 45 shadow achievements.", "", true);
			addAchievement("Shadow General", kACHIEVEMENTS.SHADOW_GENERAL, "Unlock 70 shadow achievements.", "", true);
			//addAchievement("Shadow ", kACHIEVEMENTS., "Unlock 100 shadow achievements.", "", true); 
			
			titleAchievementSection("General");
			addAchievement("Portal Defender", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER, "Defeat 20 demons and sleep 10 times.");
			addAchievement("Portal Defender 2: Defend Harder", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_2_DEFEND_HARDER, "Defeat 40 demons and sleep 25 times.");
			addAchievement("Portal Defender 3D: The Longest Night", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_3D_THE_LONGEST_NIGHT, "Defeat 100 demons and sleep 45 times.");
			addAchievement("Portal Defender 4.0: Die Hard", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_4_0_DIE_HARD, "Defeat 300 demons and sleep 70 times.");
			addAchievement("Portal Defender 5: A Good Day to Die Hard", kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER_5_A_GOOD_DAY_TO_DIE_HARD, "Defeat 1050 demons and sleep 100 times.", "", true);
			addAchievement("Just to Spite You", kACHIEVEMENTS.GENERAL_JUST_TO_SPITE_YOU, "Kill 25 imps during your time in Mareth.");
			addAchievement("Just to Spite You 2: Spite Harder", kACHIEVEMENTS.GENERAL_JUST_TO_SPITE_YOU_2_SPITE_HARDER, "Kill 125 imps during your time in Mareth.");
			addAchievement("Just to Spite You 3: I'm back", kACHIEVEMENTS.GENERAL_JUST_TO_SPITE_YOU_3_IM_BACK, "Kill 625 imps during your time in Mareth.");
			addAchievement("Goblin Slayer", kACHIEVEMENTS.GENERAL_GOBLIN_SLAYER, "Kill 25 goblins during your time in Mareth.");
			addAchievement("Goblin Slayer 2: Slay Harder", kACHIEVEMENTS.GENERAL_GOBLIN_SLAYER_2_SLAY_HARDER, "Kill 125 goblins during your time in Mareth.");
			addAchievement("Goblin Slayer 3: I'm back", kACHIEVEMENTS.GENERAL_GOBLIN_SLAYER_3_IM_BACK, "Kill 625 goblins during your time in Mareth.");
			addAchievement("Play dead Fido", kACHIEVEMENTS.GENERAL_PLAY_DEAD_FIDO, "Kill 10 hellhounds during your time in Mareth.");
			addAchievement("Play dead Fido 2: Play Harder", kACHIEVEMENTS.GENERAL_PLAY_DEAD_FIDO_2_PLAY_HARDER, "Kill 50 hellhounds during your time in Mareth.");
			addAchievement("Play dead Fido 3: I'm back", kACHIEVEMENTS.GENERAL_PLAY_DEAD_FIDO_3_IM_BACK, "Kill 250 hellhounds during your time in Mareth.");
			addAchievement("Killing the bull by the horns", kACHIEVEMENTS.GENERAL_KILLING_THE_BULL_BY_THE_HORNS, "Kill 10 minotaurs during your time in Mareth.");
			addAchievement("Killing the bull by the horns 2: Kill Harder", kACHIEVEMENTS.GENERAL_KILLING_THE_BULL_BY_THE_HORNS_2_KILL_HARDER, "Kill 50 minotaurs during your time in Mareth.");
			addAchievement("Killing the bull by the horns 3: I'm back", kACHIEVEMENTS.GENERAL_KILLING_THE_BULL_BY_THE_HORNS_3_IM_BACK, "Kill 250 minotaurs during your time in Mareth.");
			addAchievement("Body Count: Monty Python and the Holy Grail", kACHIEVEMENTS.GENERAL_BODY_COUNT_MPATHG, "Kill 47 enemies.");
			addAchievement("Body Count: Deadpool", kACHIEVEMENTS.GENERAL_BODY_COUNT_DEADPOOL, "Kill 80 enemies.");
			addAchievement("Body Count: Robocop", kACHIEVEMENTS.GENERAL_BODY_COUNT_ROBOCOP, "Kill 144 enemies.");
			addAchievement("Body Count: Total Recall", kACHIEVEMENTS.GENERAL_BODY_COUNT_TOTALRECALL, "Kill 191 enemies.");
			addAchievement("Body Count: Rambo", kACHIEVEMENTS.GENERAL_BODY_COUNT_RAMBO, "Kill 247 enemies.");
			addAchievement("Body Count: Titanic", kACHIEVEMENTS.GENERAL_BODY_COUNT_TITANIC, "Kill 307 enemies.");
			addAchievement("Body Count: The Lord of the Rings - Two Towers", kACHIEVEMENTS.GENERAL_BODY_COUNT_LOTR_TT, "Kill 468 enemies.");
			addAchievement("Body Count: 300", kACHIEVEMENTS.GENERAL_BODY_COUNT_300, "Kill 600 enemies.");
			addAchievement("Body Count: The Lord of the Rings - Return of the King", kACHIEVEMENTS.GENERAL_BODY_COUNT_LOTR_ROTK, "Kill 836 enemies.");
			//addAchievement("Body Count: Bloodiest Champion Ever", kACHIEVEMENTS.GENERAL_BODY_COUNT_BLOODIEST_CHAMPION_EVER, "Kill 1410 enemies.", "", true);
			addAchievement("Bad Ender", kACHIEVEMENTS.GENERAL_BAD_ENDER, "Cause or witness 2 Bad Ends to various NPCs.");
			addAchievement("Bad Ender 2: Electric Boogaloo", kACHIEVEMENTS.GENERAL_BAD_ENDER_2, "Cause or witness 4 Bad Ends to various NPCs.");
			addAchievement("Bad Ender 3: Serious Serial Slayer", kACHIEVEMENTS.GENERAL_BAD_ENDER_3, "Cause or witness 8 Bad Ends to various NPCs.");
			addAchievement("Bad Ender 4: The Prequel", kACHIEVEMENTS.GENERAL_BAD_ENDER_4, "Cause or witness 16 Bad Ends to various NPCs.");
			addAchievement("Game Over!", kACHIEVEMENTS.GENERAL_GAME_OVER, "Get a Bad End.");
			addAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE, "Urinate at least once in the realm of Mareth.");
			addAchievement("Smashed", kACHIEVEMENTS.GENERAL_SMASHED, "Get so drunk that you end up urinating.", "", true);
			addAchievement("What's Happening to Me?", kACHIEVEMENTS.GENERAL_WHATS_HAPPENING_TO_ME, "Transform for the first time.");
			addAchievement("Transformer", kACHIEVEMENTS.GENERAL_TRANSFORMER, "Transform 10 times.");
			addAchievement("Shapeshifty", kACHIEVEMENTS.GENERAL_SHAPESHIFTY, "Transform 25 times.");
			addAchievement("Lego-(Wo)Man", kACHIEVEMENTS.GENERAL_LEGO_WO_MAN, "Transform 100 times.");
			addAchievement("Transformer-o-holic", kACHIEVEMENTS.GENERAL_TRANSFORMER_O_HOLIC, "Transform 250 times.");
			addAchievement("Tzimisce Antediluvian", kACHIEVEMENTS.GENERAL_TZIMISCE_ANTEDILUVIAN, "Transform 1,000 times.");
			addAchievement("Just one last transformation item!!!", kACHIEVEMENTS.GENERAL_JUST_ONE_LAST_TRANSFORMATION_ITEM, "Transform 2,500 times.", "", true);
			addAchievement("Fapfapfap", kACHIEVEMENTS.GENERAL_FAPFAPFAP, "Masturbate for the first time.");
			addAchievement("Faptastic", kACHIEVEMENTS.GENERAL_FAPTASTIC, "Masturbate 10 times.");
			addAchievement("Master-bation", kACHIEVEMENTS.GENERAL_FAPSTER, "Masturbate 100 times.");
			addAchievement("Grand Master-bation", kACHIEVEMENTS.GENERAL_FAPSTER_2, "Masturbate 1,000 times.");
			addAchievement("Helspawn", kACHIEVEMENTS.GENERAL_HELSPAWN, "Have Helia give birth to Helspawn and raise her until adulthood.");
			addAchievement("Goo Armor", kACHIEVEMENTS.GENERAL_GOO_ARMOR, "Wear the goo armor.");
			addAchievement("Urta's True Lover", kACHIEVEMENTS.GENERAL_URTA_TRUE_LOVER, "Complete Urta's infertility quest then have her give birth to a baby fox.");
			addAchievement("Dress-tacular", kACHIEVEMENTS.GENERAL_DRESSTACULAR, "Give Rubi every outfit available.");
			addAchievement("Godslayer", kACHIEVEMENTS.GENERAL_GODSLAYER, "Defeat Marae.", "", true);
			addAchievement("Follow the Leader (1)", kACHIEVEMENTS.GENERAL_FOLLOW_THE_LEADER, "Get seven followers in the game.");
			addAchievement("Follow the Leader (2)", kACHIEVEMENTS.GENERAL_FOLLOW_THE_LEADER_2, "Get fourteen followers in the game.");
			addAchievement("Follow the Leader (3)", kACHIEVEMENTS.GENERAL_FOLLOW_THE_LEADER_3, "Get twenty one followers in the game.");//Get every follower in the game.
			addAchievement("Gotta Love 'Em All (1)", kACHIEVEMENTS.GENERAL_GOTTA_LOVE_THEM_ALL, "Get eight lovers in the game.");
			addAchievement("Gotta Love 'Em All (2)", kACHIEVEMENTS.GENERAL_GOTTA_LOVE_THEM_ALL_2, "Get sixteen lovers in the game.");//Get every lover in the game. (Nieve optional)
			addAchievement("Meet Your " + player.mf("Master", "Mistress") + " (1)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER, "Get four slaves in the game. (Corrupt Jojo & Amily, and Bimbo Sophie optional.)");
			addAchievement("Meet Your " + player.mf("Master", "Mistress") + " (2)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_2, "Get eight slaves in the game. (Corrupt Jojo & Amily, and Bimbo Sophie optional.)");
			//addAchievement("Meet Your " + player.mf("Master", "Mistress") + " (3)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_3, "Get twelve slaves in the game. (Corrupt Jojo & Amily, and Bimbo Sophie optional.)");//Get every slave in the game.
			addAchievement("Slaver (1)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_TRUE, "Get six slaves in the game, including two optional.", "", true);
			//addAchievement("Slaver (2)", kACHIEVEMENTS.GENERAL_MEET_YOUR_MASTER_TRUE_2, "Get twelve slaves in the game, including four optional.", "", true);//Get every slave in the game, including corrupt Jojo and Amily, and Bimbo Sophie.
			addAchievement("All Your People are Belong to Me (1)", kACHIEVEMENTS.GENERAL_ALL_UR_PPLZ_R_BLNG_2_ME, "Obtain in total nineteen followers, lovers, and slaves. (Excluding mutual exclusivity)");
			addAchievement("All Your People are Belong to Me (2)", kACHIEVEMENTS.GENERAL_ALL_UR_PPLZ_R_BLNG_2_ME_2, "Obtain in total thirty eight followers, lovers, and slaves. (Excluding mutual exclusivity)");//Obtain every follower, lover, and slave.
			addAchievement("Scholar (1)", kACHIEVEMENTS.GENERAL_SCHOLAR, "Fill out twenty codex entries available in the game.");
			addAchievement("Scholar (2)", kACHIEVEMENTS.GENERAL_SCHOLAR_2, "Fill out thirty codex entries available in the game.");
			//addAchievement("Scholar (3)", kACHIEVEMENTS.GENERAL_SCHOLAR_3, "Fill out fourty codex entries available in the game.");//Fill out all codex entries available in the game.
			addAchievement("Freeloader", kACHIEVEMENTS.GENERAL_FREELOADER, "Visit the Kitsune's mansion 3 times.");
			addAchievement("Schizophrenic", kACHIEVEMENTS.GENERAL_SCHIZO, "Go between pure and corrupt 4 times. (Threshold of 20 and 80 corruption)");
			addAchievement("Clean Slate", kACHIEVEMENTS.GENERAL_CLEAN_SLATE, "Go from 100 corruption to zero for the first time.");
			addAchievement("Perky", kACHIEVEMENTS.GENERAL_PERKY, "Have at least 25 perks.");
			addAchievement("Super Perky", kACHIEVEMENTS.GENERAL_SUPER_PERKY, "Have at least 50 perks.");
			addAchievement("Mega Perky", kACHIEVEMENTS.GENERAL_MEGA_PERKY, "Have at least 75 perks.");
			addAchievement("Ultra Perky", kACHIEVEMENTS.GENERAL_ULTRA_PERKY, "Have at least 100 perks.", "", true);
			addAchievement("Hyper Perky", kACHIEVEMENTS.GENERAL_HYPER_PERKY, "Have at least 200 perks.", "", true);
			addAchievement("Umber Perky", kACHIEVEMENTS.GENERAL_UMBER_PERKY, "Have at least 300 perks.", "", true);
			addAchievement("Perky Beast of Death", kACHIEVEMENTS.GENERAL_PERKY_BEAST_OF_DEATH, "Have at least 444 perks.", "", true);
			addAchievement("Perky King", kACHIEVEMENTS.GENERAL_PERKY_KING, "Have at least 600 perks.", "", true);
			addAchievement("Ridiculous Perky King", kACHIEVEMENTS.GENERAL_RIDICULOUS_PERKY_KING, "Have at least 800 perks.", "", true);
			addAchievement("Ludicrous Perky King", kACHIEVEMENTS.GENERAL_LUDICROUS_PERKY_KING, "Have at least 1000 perks.", "", true);
			addAchievement("Jack of All Trades", kACHIEVEMENTS.GENERAL_STATS_50, "Have at least 50 in str/tou/spe/int/wis, 40 in lib and 20 in sens.");
			addAchievement("Incredible Stats", kACHIEVEMENTS.GENERAL_STATS_100, "Have at least 100 in str/tou/spe/int/wis, 80 in lib and 40 in sens.");
			addAchievement("Amazing Stats", kACHIEVEMENTS.GENERAL_STATS_150, "Have at least 150 in str/tou/spe/int/wis, 120 in lib and 60 in sens.");
			addAchievement("Superhuman Stats", kACHIEVEMENTS.GENERAL_STATS_200, "Have at least 200 in str/tou/spe/int/wis, 160 in lib and 80 in sens.");
			addAchievement("Inhuman Stats", kACHIEVEMENTS.GENERAL_STATS_300, "Have at least 300 in str/tou/spe/int/wis, 240 in lib and 120 in sens.");
			addAchievement("Epic Stats", kACHIEVEMENTS.GENERAL_STATS_500, "Have at least 500 in str/tou/spe/int/wis, 400 in lib and 200 in sens.");
			addAchievement("Legendary Stats", kACHIEVEMENTS.GENERAL_STATS_1000, "Have at least 1,000 in str/tou/spe/int/wis, 800 in lib and 400 in sens.");
			addAchievement("Mythical Stats", kACHIEVEMENTS.GENERAL_STATS_2000, "Have at least 2,000 in str/tou/spe/int/wis, 1,600 in lib and 800 in sens.");
			addAchievement("Transcendental Stats", kACHIEVEMENTS.GENERAL_STATS_5000, "Have at least 5,000 in str/tou/spe/int/wis, 4,000 in lib and 2,000 in sens.", "", true);
			addAchievement("Divine Stats", kACHIEVEMENTS.GENERAL_STATS_15000, "Have at least 15,000 in str/tou/spe/int/wis, 12,000 in lib and 6,000 in sens.", "", true);
			addAchievement("OPK", kACHIEVEMENTS.GENERAL_STATS_OPK, "Have at least 268,445,279 in at least 5 stats... She's proud of you, you know?", "", true);
			addAchievement("Like Chuck Norris", kACHIEVEMENTS.GENERAL_LIKE_CHUCK_NORRIS, "Defeat the Frost Giant without any equipment.", "Defeat the Frost Giant without any equipment. Way to be a badass!");
			addAchievement("Texas Ranger", kACHIEVEMENTS.GENERAL_TEXAS_RANGER, "Defeat young Frost Giant without any equipment.", "Defeat young Frost Giant without any equipment. Way to make Walker be proud of you!");
			addAchievement("Tentacle Beast Slayer", kACHIEVEMENTS.GENERAL_TENTACLE_BEAST_SLAYER, "Slay your first Tentacle Beast.");
			addAchievement("Hammer Time", kACHIEVEMENTS.GENERAL_HAMMER_TIME, "Buy a total of 300 nails.");
			addAchievement("Nail Scavenger", kACHIEVEMENTS.GENERAL_NAIL_SCAVENGER, "Scavenge a total of 200 nails from the library wreckage");
			addAchievement("I'm No Lumberjack", kACHIEVEMENTS.GENERAL_IM_NO_LUMBERJACK, "Buy a total of 100 wood.");
			addAchievement("Deforester", kACHIEVEMENTS.GENERAL_DEFORESTER, "Cut down 100 wood pieces.");
			addAchievement("Yabba Dabba Doo", kACHIEVEMENTS.GENERAL_YABBA_DABBA_DOO, "Buy a total of 100 stones.");
			addAchievement("AntWorks", kACHIEVEMENTS.GENERAL_ANTWORKS, "Gather a total of 200 stones with Phylla help.");
			addAchievement("Ant-Kids and Phylla", kACHIEVEMENTS.GENERAL_ANT_KIDS_AND_PHYLLA, "Gather a total of 5000 stones with Phylla help.", "", true);
			addAchievement("Home Sweet Home", kACHIEVEMENTS.GENERAL_HOME_SWEET_HOME, "Finish the cabin and complete it with furnishings.");
			addAchievement("Getaway", kACHIEVEMENTS.GENERAL_GETAWAY, "Spend the night outside your camp.");
			addAchievement("My Tent's (not) Better Than Yours", kACHIEVEMENTS.GENERAL_MY_TENT_NOT_BETTER, "Sleep in Arian's tent.");
			addAchievement("Divine Intervention", kACHIEVEMENTS.GENERAL_MINERVA_PURIFICATION, "Complete Minerva's purification process.", "", true);
			addAchievement("Fencer", kACHIEVEMENTS.GENERAL_FENCER, "Complete rapier training from Raphael.", "", true);
			addAchievement("Now You're Fucking With Portals", kACHIEVEMENTS.GENERAL_FUCK_WITH_PORTALS, "Engage in portal sex with Ceraph.", "", true);
			addAchievement("Getting Wood", kACHIEVEMENTS.GENERAL_GETTING_WOOD, "Punch a tree until wood falls out... Wait, what?", "", true);
			addAchievement("Dick Banisher", kACHIEVEMENTS.GENERAL_DICK_BANISHER, "Remove cocks from at least three dedickable NPCs. Don't you think they'll miss having their own cocks?", "", true);
			addAchievement("You Bastard", kACHIEVEMENTS.GENERAL_YOU_BASTARD, "Remove cocks from at least seven dedickable NPCs. Take that, dedickers!", "", true);
			addAchievement("Up to Eleven", kACHIEVEMENTS.GENERAL_UP_TO_11, "Take your height up to 11 feet.");
			addAchievement("Lesser Chimera", kACHIEVEMENTS.GENERAL_LESSER_CHIMERA, "Have at least 4 racial internal mutation perks.");
			addAchievement("Normal Chimera", kACHIEVEMENTS.GENERAL_NORMAL_CHIMERA, "Have at least 8 racial internal mutation perks.");
			addAchievement("Greater Chimera", kACHIEVEMENTS.GENERAL_GREATER_CHIMERA, "Have at least 16 racial internal mutation perks.");
			addAchievement("Elder Chimera", kACHIEVEMENTS.GENERAL_ELDER_CHIMERA, "Have at least 32 racial internal mutation perks.");
			addAchievement("Legendary Chimera", kACHIEVEMENTS.GENERAL_LEGENDARY_CHIMERA, "Have at least 64 racial internal mutation perks.");
			addAchievement("Ultimate Lifeform", kACHIEVEMENTS.GENERAL_ULTIMATE_LIFEFORM, "Have at least 128 racial internal mutation perks.", "", true);
			
			if (achievementsTotal > 0) {
				player.createStatusEffect(StatusEffects.AchievementsNormalShadowTotal, achievementsEarned, achievementsShadowEarned, achievementsTotalCurrentlyUnlocked, 0);
			}
			menu();
			addButton(5, "" + achievementsShadowEarned + " shadow", EngineCore.doNothing);
			addButton(6, "achievements", EngineCore.doNothing);
			addButton(7, "unlocked", EngineCore.doNothing);
			addButton(10, "" + achievementsEarned + " of " + achievementsTotal + "", EngineCore.doNothing);
			addButton(11, "achievements", EngineCore.doNothing);
			addButton(12, "unlocked", EngineCore.doNothing);
			addButton(14, "Back", CoC.instance.mainMenu.mainMenu);
		}
		
	}

}
