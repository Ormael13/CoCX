/**
 * ...
 * @author Coalsack
 */
package classes.Scenes.Dungeons 
{
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.Dungeons.AnzuPalace.AnzuScene;
//import classes.Scenes.Dungeons.DungeonAbstractContent;
//import classes.Scenes.Dungeons.DungeonCore;

use namespace CoC;
	
	public class AnzuPalace extends DungeonAbstractContent
	{
		public var anzuScene:AnzuScene = new AnzuScene();
		
		public function AnzuPalace() {}
		
		public function enterDungeon():void {
			clearOutput();
			if ((flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] < 2 && flags[kFLAGS.ANZU_AFFECTION] >= 25) || (flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] < 3 && flags[kFLAGS.ANZU_AFFECTION] >= 50) || (flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] < 4 && flags[kFLAGS.ANZU_AFFECTION] >= 75)) {
				anzuScene.anzuTransition();
				return;
			}
			//outputText(images.showImage("dungeon-entrance-palace"));
			inDungeon = true;
			outputText("You make your way through the frigid climates, and your memory takes you back to Anzu's palace.");
			doNext(roomEntrance);
		}
		
		private function exitDungeon():void {
			inDungeon = false;
			clearOutput();
			outputText("You leave the palace behind and take off through the glacial rift back towards camp.");
			doNext(camp.returnToCampUseOneHour);	
		}
		
		//ROOMS
		//Floor 1
		public function roomEntrance():void {
			dungeonLoc = DUNGEON_ANZU_OUTSIDE;
			clearOutput();
			outputText("<b><u>Palace Grounds</u></b>\n");
			outputText("The outsides of the palace look way different from how it was before Anzu’s arrival. Mostly covered in snow, but visible, instead of the original shape of a Norse castle made of stone, with the majolica tiles in a vibrant teal, and ornaments in gold covering the walls, and the new shape, looks more like a palace from ancient times. During the night, the lights from the inside contrast against the darkness of the Rift.");
			outputText("\n\nThe gate, in turquoise tiles, leads to a huge door made of solid iron which serves as the palace principal entrance. The area around the palace is mostly covered in snow and pines, except a small path made of stones, that lead to the bottom of the hill.");
			/*
			 * The exterior part of the Palaces exudes and otherworldly beauty. Now free of snow thanks to the more templated climate on this part of the Rift, you can appreciate better his magnificent architecture.
			 * The door, of double, reflects on itself the whiteness of silver. 
			 * */
			dungeons.setDungeonButtons(roomFoyer, null, null, null);
			addButton(11, "Leave", exitDungeon);
		}
		public function roomFoyer():void {
			dungeonLoc = DUNGEON_ANZU_HALL_FLOOR1;
			clearOutput();
			outputText("<b><u>Hall, Floor 1</u></b>\n");
			outputText("You’re standing inside the first floor of Anzu’s Palace. A long hall, marked with a beautiful red rug and flanked with two rows of columns in golden marble, connecting all the rooms in this floor. Immediately near the start of the hall, to the west, is the living room.");
			outputText("\n\nTo the east you can see a dining room, with two wooden tables and chairs. Connected to the dining room from the north is the kitchen. Near the end of the hall, a door leads to the baths.");
			outputText("\n\nThe hall has a staircase located not far from the entrance, leading to the second floor, and another at the end, leading to the basement.");
			dungeons.setDungeonButtons(null, roomEntrance, roomLivingRoom, roomDiningRoom);
			addButton(5, "Upstairs", roomHallFloor2);
			addButton(7, "Downstairs", roomBasement);
		}
		public function roomLivingRoom():void {
			dungeonLoc = DUNGEON_ANZU_LIVING_ROOM;
			clearOutput();
			outputText("<b><u>Living Room</u></b>\n");
			outputText("Like most of the house, the living room is richly decorated. Golden columns with ornamented chapiters surround the area, with very colorful patterned decorations in silk hanging from them. The walls are decorated with mosaics in the shape of flowers and stars, made of semiprecious stones. The floor is made of mosaics and covered with some rugs.");
			outputText("\n\nAncient looking statues made of alabaster and beautiful vases containing violets decorate the area. The entire room is illuminated by a lamp hanging from the ceiling, with an almost white flame, bright enough to enlighten all the room. In the center, a big fireplace brings warmth to the place.");
			outputText("\n\nComfortable armchairs, with soft cushions, covered in red velvet provide a good place to rest. On the left part of the room, are several shelves containing books about the story of Mittani and other similar things.");
			outputText("\n\nTo the east is the hall which connects the rest of the rooms in this floor. In a corner, on the end of the room, leading to the north, a door leads to the baths.");
			dungeons.setDungeonButtons(roomBathroom, null, null, roomFoyer);
			if (model.time.hours > 9 && model.time.hours < 13) addButton(0, "Anzu", anzuScene.anzuMenus).hint("Interact with Anzu the avian deity.");
		}
		public function roomBathroom():void {
			dungeonLoc = DUNGEON_ANZU_BATHROOM;
			clearOutput();
			if (model.time.hours == 19) {
				anzuScene.anzuBathTimeBeginning();
				return;
			}
			outputText("<b><u>Bathroom</u></b>\n");
			outputText("A central round pool, with almost thirty feet of diameter, dominates the center of the room. The warm water of the pool is so clear that you can see the light blue colored tiles of its bottom. Several columns in a light golden marble surround the pool, and give the room a cozy feeling. They’re eleven in total, now that you can count them well.");
			outputText("\n\nThe rest of the room is covered with light brown tiles on the floor and the lower part of the walls, and a pattern of golden tiles and gold inlaids on the upper walls, separated by a band of mosaics displaying fish in exotic colors, sea serpents and aquatic monsters of a kind that you can’t recognize.");
			outputText("\n\nSome lamps around the room keep the bath well illuminated, and a door to the south leads back to living room.");
			dungeons.setDungeonButtons(null, roomLivingRoom, null, null);
		}
		public function roomDiningRoom():void {
			dungeonLoc = DUNGEON_ANZU_DINING_ROOM;
			clearOutput();
			outputText("<b><u>Dining Room</u></b>\n");
			outputText("Two polished wooden tables, pretty large, occupy the center of the room. Surrounding them, between forty and fifty chairs give enough sitting room for a small army. Anzu must feel quite lonely when dining.");
			outputText("\n\nDecorating the corners are vases with violets, whose smell perfumes the air. The columns in golden marble and the colorful decorations in silk hanging from them complete the room atmosphere.");
			outputText("\n\nTo the north, there is a door that leads to the kitchen. Another, leading to the west, goes back to the principal hall.");
			dungeons.setDungeonButtons(roomKitchen, null, roomFoyer, null);
			if (model.time.hours == 9 || model.time.hours == 14) addButton(0, "Anzu", anzuScene.anzuMenus).hint("Interact with Anzu the avian deity.");
		}
		public function roomKitchen():void {
			dungeonLoc = DUNGEON_ANZU_KITCHEN;
			clearOutput();
			if (model.time.hours == 8 || model.time.hours == 13 || model.time.hours == 18) {
				anzuScene.dinnerWithAnzu();
				return;
			}
			outputText("<b><u>Kitchen</u></b>\n");
			outputText("A big oven made of iron dominates the kitchen. To the sides many drawers contain a wide variety of cooking utensils. Knives, spoons, forks, dishes, glasses, all stored in their respective place. A place for cleaning the utensils and a stove have a place too on opposite sides of the kitchen.");
			outputText("\n\nIn the back of the room, a wooden door leads to the place where Anzu stores food. Inside are grains, bread, cheese, several crates containing wine, and in some containers, wrapped inside snow and ice, are big pieces of meat.");
			outputText("\n\nThe constant heat from the oven and the stove makes this room as warm as the bedroom or the living room.");
			dungeons.setDungeonButtons(null, roomDiningRoom, null, null);
		}
		//Floor 2
		public function roomHallFloor2():void {
			dungeonLoc = DUNGEON_ANZU_HALL_FLOOR2;
			clearOutput();
			outputText("<b><u>Hall, Floor 2</u></b>\n");
			outputText("The second floor is in U-shaped, with two different rooms on each side and one at the end. The remaining space is occupied by the staircases, which go to the third floor and to the first floor, with the hall connecting the three rooms. This hall is decorated too with a red rug and golden columns.");
			outputText("\n\nThe room in the west is Anzu’s bedroom. A calm and peaceful sensation emanates from the door that leads to it.");
			outputText("\n\nThe room located at the end of the floor is the palace’s library and study. Judging by its size,  looks like Anzu brought with him half of books of Mittani.");
			outputText("\n\nAnzu has stated that the third room is not currently in use...");
			dungeons.setDungeonButtons(roomLibrary, null, roomBedroom, roomMultiuse);
			addButton(5, "Upstairs", roomHallFloor3);
			addButton(7, "Downstairs", roomFoyer);
		}
		public function roomBedroom():void {
			dungeonLoc = DUNGEON_ANZU_BEDROOM;
			clearOutput();
			if (model.time.hours >= 20) {
				anzuScene.sleepWithAnzuInvitation();
				return;
			}
			outputText("<b><u>Bedroom</u></b>\n");
			outputText("The golden columns decorate this room too. More silken colorful decorations cover them, with the mosaics doing the same to the bedroom walls. In a similar fashion of the living room, vases with violets and alabaster statues complete the room ornaments, with some armchairs giving place of rest.");
			outputText("\n\nAnzu’s bed is huge, even for Marethian standards. Soft cushions and linen sheets cover the mattress. The bed itself releases an aromatic smell. You have the temptation of climb in and sleep on it all day.");
			outputText("\n\nAnother fireplace, smaller than the one in the living room, warms the place atmosphere.");
			dungeons.setDungeonButtons(null, null, null, roomHallFloor2);
			if (model.time.hours <= 7)
				addButton(0, "Anzu", anzuScene.anzuMenus).hint("Interact with Anzu the avian deity.");
		}
		public function roomLibrary():void {
			dungeonLoc = DUNGEON_ANZU_LIBRARY;
			clearOutput();
			outputText("<b><u>Library</u></b>\n");
			outputText("Many bookshelves filled with at least one thousand books occupy most of the walls. The ambience inside is quiet and peaceful. Some armchairs give a comfortable place to read. This books must’ve been the only friendly company of your avian friend in many years. ");
			outputText("\n\nOn the end of the place, is Anzu’s private study. A desk, a chair, some bookcases next to it. Nothing extraordinary.");
			outputText("\n\nTo the south is the exit to the hall, that connects all rooms in the third floor.");
			dungeons.setDungeonButtons(null, roomHallFloor2, null, null);
			if (model.time.hours > 14 && model.time.hours < 18) addButton(0, "Anzu", anzuScene.anzuMenus).hint("Interact with Anzu the avian deity.");
		}
		public function roomMultiuse():void {
			dungeonLoc = DUNGEON_ANZU_MULTIUSE_ROOM;
			clearOutput();
			outputText("<b><u>Multi-use Room</u></b>\n");
			outputText("This room used to be the bedroom of most of the Valkyries that used to live there. Since he has his own bedroom now, Anzu has little use for this room, and given his word, it remains empty. Actually, you could peek inside if you want...");
			outputText("\n\nYeah, empty. There is nothing else to do there that look the corners.");
			outputText("\n\nTo the south is the exit to the hall, that connects all rooms in the third floor.");
			dungeons.setDungeonButtons(null, null, roomHallFloor2, null);
		}
		//Floor 3
		public function roomHallFloor3():void {
			dungeonLoc = DUNGEON_ANZU_HALL_FLOOR3;
			clearOutput();
			outputText("<b><u>Hall, Floor 3</u></b>\n");
			outputText("This floor has a disposition similar to the second, with the only difference being only two rooms and a huge window which gives a great view of the snow covered hills and the forest across the Rift. The usual staircase leads down to the second floor and up to the roof.");
			outputText("\n\nTo the left is the treasure room, the place when probably half of Mareth treasures are stored.");
			dungeons.setDungeonButtons(null, null, roomVault, roomAlchemyRoom);
			addButton(5, "Upstairs", roomRoof);
			addButton(7, "Downstairs", roomHallFloor2);
		}
		public function roomVault():void {
			dungeonLoc = DUNGEON_ANZU_PALACE_VAULTS;
			clearOutput();
			outputText("<b><u>Vault</u></b>\n");
			outputText("As expected from a treasure room, it's filled to the brim with boxes of golden coins and jewels. Diamonds, rubies, amethysts, sapphires, alexandrites, name a jewel and you probably could find here in insane quantities.");
			outputText("\n\nGold objects, like plates, coins, goblets, chains, rings and utensils are stored in crates. Rugs and carpets are folded in many heaps in one corner. Bottles with aromatic oils are stored in shelves in another side of the room.");
			outputText("\n\nThe sources of the wealth in the palace’s vault is a mix of things which Anzu brought with him from Mittani and the loot which the avian took from the valkyries and other monsters which wandered in the Rift.");
			outputText("\n\nTo the east is a door leading back to the hall.");
			dungeons.setDungeonButtons(null, null, null, roomHallFloor3);
		}
		public function roomAlchemyRoom():void {
			dungeonLoc = DUNGEON_ANZU_ALCHEMY_ROOM;
			clearOutput();
			outputText("<b><u>Alchemy Room</u></b>\n");
			outputText("In the north of the room is a kind of desk, with many alchemical devices. Currently, are some metals made liquid, in an attempt to made an alloy. This is probably the place where Anzu creates electrum. A bookshelf containing books of alchemy is located close.");
			outputText("\n\nThe center of the room has what looks like a scale map from Mareth, the transmutation table, and the drawers containing ingredients are in the south of the room. Many concoctions and liquid metals are saved in shelves next to it.");
			outputText("\n\nOn the right side of the room is the combination . A sort of drawings in the floor in a concentric shape, which Anzu uses to make energy flow inside living or organic things to combinate, extract or infuse energy on them");
			outputText("\n\nA door that leads back to the hall is on the west.");
			dungeons.setDungeonButtons(null, null, roomHallFloor3, null);
		}
		//Roof
		public function roomRoof():void {
			dungeonLoc = DUNGEON_ANZU_ROOF;
			clearOutput();
			outputText("<b><u>Roof</u></b>\n");
			outputText("The view here is amazing! This places offers a magnificent sight of the sky above and the hills and forest around.");
			outputText("\n\nThe forest and the snow covered hills extend as far as the eye can see. The fresh air, though cold, bring you a peace which takes you away from the corruption and the horrors of this land for a moment.");
			dungeons.setDungeonButtons(null, null, null, null);
			addButton(7, "Downstairs", roomHallFloor3);
			if (model.time.hours == 18) addButton(0, "Anzu", anzuScene.anzuMenus).hint("Interact with Anzu the avian deity.");
		}
		//Basement
		public function roomBasement():void {
			dungeonLoc = DUNGEON_ANZU_BASEMENT;
			clearOutput();
			outputText("<b><u>Basement</u></b>\n");
			outputText("A chariot dominates most of the open area of the basement. It's made of strong and sturdy wood, with a soft mattress and covered in silk. It doesn’t look like it’s designed to be pulled in a normal way, and judging by its nature and origin, probably moves by a magical force.");
			outputText("\n\nSome feet behind the chariot, a door leads to Anzu’s armory. Inside is a collection of swords, knives, spears, and blades big enough to equip a small army. ");
			dungeons.setDungeonButtons(null, null, roomArmory, null);
			addButton(5, "Upstairs", roomFoyer);
		}
		public function roomArmory():void {
			dungeonLoc = DUNGEON_ANZU_ARMORY;
			clearOutput();
			outputText("<b><u>Armory</u></b>\n");
			outputText("This room contains a collection of swords, knives, spears, and blades big enough to equip a small army. At the end is an ornate armor probably once worn by the elite valkyries. You don't think Anzu would like you taking it without his permission.");
			outputText("\n\nThere is a door leading back to the main basement room.");
			dungeons.setDungeonButtons(null, null, null, roomBasement);
		}
		
	}

}