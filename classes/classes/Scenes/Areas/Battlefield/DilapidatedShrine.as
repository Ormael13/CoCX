/**
 * ...
 * @author ...
 */
package classes.Scenes.Areas.Battlefield
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.ItemConstants;
import classes.Items.Weapon;
import classes.Items.WeaponRange;

public class DilapidatedShrine extends BaseContent
	{
		
		public function DilapidatedShrine()
		{}
		
		public function firstvisitshrineintro():void {
			flags[kFLAGS.DILAPIDATED_SHRINE_UNLOCKED] = 2;
			clearOutput();
			outputText("As you explore the battlefield, you notice a gravel path, curiously well-maintained, unlike everything else in this crater-ridden wasteland. You decide to follow the path, and it leads to a decently sized green space. In the middle of this surprisingly calm place, a large square building stands. At first glance, it's a majestic old wooden structure, radiating old grandeur and spirituality. You cautiously approach, the sparse trees and ancient building still calming compared to the wasteland around it. \n\n");
			outputText("How could such a thing survive in such a war-torn place?\n\n You push open the chipped, charred wooden door as quietly as you can, but the soft scraping of the wood on the stone floor seems to carry throughout the place. ");
			outputText("The vermilion-hued gates, though damaged, still display remarkable craftsmanship. As you step in, you notice two statues of strange beings, on either side of you. They seem to be half-lion and half-dog, a creature the likes of which you've never seen. You marvel at their almost lifelike features. One stands with its jaw agape, the other with its lips sealed.\n\n");
			outputText("Deeper into the shrine is a large plaza with statues located on each of your cardinal directions. Between the statues, the stones of the floor are carved, inlaid with ceramic, each tile depicting two or more of the statues, locked in combat or ordering smaller, less defined stick figures into battle. \n\n");
			outputText("A voice echoes through the sanctum, breaking your thoughts, \"<i>What brings you here, young one?</i>\" Its voice is slightly raspy, clearly aged."+(silly()?" That or they seriously need to stop smoking.":"")+"\n\n");
			outputText("You turn to face an odd person. They stand a little less than six feet tall, slumped over slightly and leaning on an old, worn broom. You can't make out anything beyond their height. The monk shows no skin, everything is completely sealed within dark layers of fabric.\n\n");
			outputText("You stare for a moment, taken aback, and the old monk waves you off with one hand. \"<i>Oh, don't mind me, traveller. I'm merely cleaning up here and there. I can't let the shrine of the Four Gods grow dusty, can I?</i>\" They shuffle their feet, sending a small bit of Dust up from the floor.\n\n");
			outputText("You blink, and when you open your eyes, they've gone. An apparition? Illusion? You ready yourself for combat, backing away. Perhaps it's best to leave for now. \n\n");
			outputText("<b>You have discovered the Dilapidated Shrine. You can visit it from Places menu.</b>");
			mainmenu();
		}
		public function repeatvisitshrineintro():void {
			clearOutput();
			outputText("You decide to make a trip to the shrine. Entering the sacred grounds, you walk through the vermillion gates, passing the guardian statues.\n\n");
			if (shinshoku()) outputText("As you reach the yard, you hear a voice again, \"<i>Oh, is that you again? I apologize for the dust...This place isn't the easiest to care for.</i>\" As you notice them, the old person that greeted you returns to sweeping the shrine like you aren't even here.\n\n");
			outputText("Upon reaching the main plaza, you see four major sections located on each cardinal direction. There are three smaller rooms located between the major wings.\n\n");
			outputText("You consider where to go or what you should do.");
			mainmenu();
		}
		public function shrinemainmenu():void {
			clearOutput();
			outputText("You're at the open plaza, large statues situated at each cardinal direction watch over you. Behind each statue are several small buildings decorated with braded ropes, strips of paper and smaller lion-dog statues at the sides.");
			outputText("On the opposite side of the entrance, a path leads to a small building with several manuscripts stored.");
			outputText("To your left is a set of stairs that seem to lead into an underground chamber.");
			outputText("At your right, you can see a small garden area.");
			outputText("You consider what you should do or where to go.");
			mainmenu();
		}
		private function mainmenu():void {
			menu();
			//addButton(0, "Library", shrineLibrary);
			//addButtonDisabled(2, "North", "???");//magic god subshrine
			//addButtonDisabled(4, "Garden", "???");
			addButton(6, "West", westSection);
			//addButtonDisabled(7, "Shinshoku", "???");//mysterious old housekeeper
			//addButtonDisabled(8, "East", "???");//life god subshrine
			//addButtonDisabled(10, "Crypt", "???");//heavenly kings resting place
			addButton(12, "South", southSection);
			addButton(14, "Leave", explorer.done);
		}
		
		private function shinshoku():Boolean {
			return rand(5) == 0 && ((model.time.hours > 6 && model.time.hours < 10) || (model.time.hours > 18 && model.time.hours < 22));
		}

		/*
		private function shrineLibrary():void {
			clearOutput();
			outputText("As you walk toward the small building, you find yourself inside a room with countless shelves, many of which contain an assortment of books haphazardly strewn on them. Despite the cleanliness of the place, you can see the passage of time on the surrounding furniture. This place seems to have been untouched for months, if not years.\n\n");
			outputText("You notice in the corners of the room, and beneath a few shelves are cobwebs and dust bunnies, yet the floor is strangely pristine. Did someone recently sweep the place? There's not a speck of dust on the ground.\n\n");
			outputText("Aside from the books, there are scrawlings over the walls of what seems to be an ancient language. It's almost completely indecipherable. Perhaps you should bring someone who knows more about different languages next time?\n\n");
			menu();
			addButtonDisabled(2, "Spellcraft", "Placeholder button until one of the writers write something on this subject ^^");//story about god of magic			//addButtonDisabled(2, "The Fall", "Placeholder button until Lia write something on this subject ^^");//collection of propercies about gods fall on area later known as battlefield
			addButtonDisabled(6, "Reaper", "Placeholder button until one of the writers write something on this subject ^^");//story about god of death/transformation
			addButtonDisabled(8, "Lifegiver", "Placeholder button until one of the writers write write something on this subject ^^");//story about god of life				//addButtonDisabled(0, "Souless Ones", "Placeholder button until Lia write something on this subject ^^");//story about early days of demons/their uprising (here or other place in Mareth?)
			addButtonDisabled(12, "Warmonger", "Placeholder button until one of the writers write write something on this subject ^^");//story about god of war				//addButtonDisabled(1, "The Descent", "Placeholder button until Lia write something on this subject ^^");//orgin of soul cultivators in Mareth (here or other place in Mareth?)
			addButton(14, "Back", shrinemainmenu);
		}
		*/
		
		private function westSection():void {
			clearOutput();
			outputText("Westward within the building, you see a statue in an open clearing. The towering figure portrays a hideously mesmerizing creature frozen in an aggressive pose, eyes dark and lips curled into a frown. Each limb comes from a different animal you have seen in this realm, yet all together seems to create a harmonious whole despite the statues' chaotic nature.\n\n");
			outputText("Each arm extends into sharp points, much like a blade. Its left arm resembles what appears to be a mantis scythe, while the right arm is a kamaitachi blade. The statue brandishes each arm, ready to strike. You get a vague sense of impatience from the statue, like a sparring instructor waiting for a pupil to make the first move.\n\n");
			outputText("Its eyes seem oddly human-like, except for the pupils, which are x shaped.\n\n");
			outputText("At the base of the statue lies a metallic plaque. Given the rust coating it, the text is hard to decipher. You can only make out, 'E.e.ie.'.\n\n");
			outputText("Below the plaque lies two ornate wooden bowls, presumably used to put offerings in a time when this was a place people actively visited.\n\n");
            //The hint gives everything away. Remove it, and people won't understand what to do. Maybe no checks here?
			//if (shinshoku()) {
            outputText("A soft voice rings not far from behind you, \"<i>Sometimes all you need is a small token of goodwill. Chilly peppers were his favorite, in bunches of three...</i>\"\n\n");
            outputText("You turn around, expecting to see the old monk you've seen before. As you peer about, nobody is around. Are you hearing voices or was he truly here?\n\n");
			//}
			//outputText("\n\n");
			menu();
			if (player.hasItem(consumables.CHILLYP, 3)) addButton(0, "Offering", westSectionOffering);
			else addButtonDisabled(0, "???", "Perhaps if you came back with 3 Chilly peppers, like the voice said...");
			addButton(14, "Back", shrinemainmenu);
		}
		private function westSectionOffering():void {
			clearOutput();
			player.destroyItems(consumables.CHILLYP, 3);
			outputText("You place the peppers in one of the bowls, and wait for a bit. You hear a rasping sound, like steel on stone, and you turn to face the noise. When you turn back, the peppers are gone, ");
			if (flags[kFLAGS.E_ICHOR_PITY_SYSTEM] > 9) {
				flags[kFLAGS.E_ICHOR_PITY_SYSTEM] = 0;
				outputText("and in the other bowl sits a small, glowing syringe.");
				inventory.takeItem(useables.E_ICHOR, westSection);
			}
			else {
				switch(rand(10)) {
					case 1:
						flags[kFLAGS.E_ICHOR_PITY_SYSTEM] = 0;
						outputText("and in the other bowl sits a small, glowing syringe.");
						inventory.takeItem(useables.E_ICHOR, westSection);
						break;
					case 2:
						flags[kFLAGS.E_ICHOR_PITY_SYSTEM]++;
						outputText("and a single Desert Berry rests in the other bowl.");
						inventory.takeItem(consumables.DESERTB, westSection);
						break;
					case 3:
						flags[kFLAGS.E_ICHOR_PITY_SYSTEM]++;
						outputText("and a single Wolf Pepper rests in the other bowl.");
						inventory.takeItem(consumables.WOLF_PP, westSection);
						break;
					case 4:
						flags[kFLAGS.E_ICHOR_PITY_SYSTEM]++;
						outputText("replaced by a bottle of Nocello sitting in front of the statue.");
						inventory.takeItem(consumables.NOCELIQ, westSection);
						break;
					case 5:
						flags[kFLAGS.E_ICHOR_PITY_SYSTEM]++;
						outputText("and a single Storm Seed rests in the other bowl.");
						inventory.takeItem(consumables.SRMSEED, westSection);
						break;
					case 7:
						flags[kFLAGS.E_ICHOR_PITY_SYSTEM]++;
						outputText("replaced by a familiar looking bottle of Enigmanium.");
						inventory.takeItem(consumables.ENIGMANIUM, westSection);
						break;
					case 9:
						flags[kFLAGS.E_ICHOR_PITY_SYSTEM]++;
						outputText("instead, a bottle of Infernal Wine sits before the statue.");
						inventory.takeItem(consumables.INFWINE, westSection);
						break;
					default:
						flags[kFLAGS.E_ICHOR_PITY_SYSTEM]++;
						outputText("and the other bowl is empty. Disappointing.");
						break;
				}
			}
			outputText("\n\n")
			doNext(westSection);
			cheatTime(1/12);
		}
		
		private function southSection():void {
			clearOutput();
			outputText("Southward within the building, you see a group of statues in an open clearing. The largest one portrays a being with bulging muscles, wearing fine armor.\n\n");
			outputText("The marble statue shimmers, polished stone and chiseled muscle radiating power and strength. \n\n");
			outputText("The surrounding statuettes depict a wide variety of warriors of a wide variety of Marethian races. Each one holds a different pair of weapons. Axes, blades, warhammers...You could fill several armories with the blades in those statuettes' hands.\n\n");
			outputText("At the base of the largest statue lies a metallic plaque. Given the rust coating it, the text is hard to decipher. You can only make out 'Krat..' within the text.\n\n");
			outputText("Below the plaque lies an ornate wooden bowl, several rusted coins inside.\n\n");
			outputText("From behind, you hear a whisper of a voice, like rasping steel. <i>\"Every weapon is treasured by the God of War. Offer him your tools of destruction, and share in the battles they've seen.\"</i> You turn your head, to face the speaker...But there's nobody there. \n\n");
			menu();
			addButton(0, "Offering", weaponsXPtrader);//southSectionOffering
			addButton(14, "Back", shrinemainmenu);
		}

		public function weaponsXPtrader():void{
			clearOutput();
			//Firearms and Archery is not supported yet cause classification is a bit blurry still.
			var weaponClasses:Array = [ItemConstants.WT_GAUNTLET, ItemConstants.WT_SWORD, ItemConstants.WT_AXE, ItemConstants.WT_MACE_HAMMER, ItemConstants.WT_DUELING, ItemConstants.WT_POLEARM, ItemConstants.WT_SPEAR, ItemConstants.WT_DAGGER, ItemConstants.WT_WHIP, ItemConstants.WT_EXOTIC, ItemConstants.WT_THROWING, ItemConstants.WT_BOW, ItemConstants.WT_CROSSBOW, ItemConstants.WT_2H_FIREARM, ItemConstants.WT_RIFLE, ItemConstants.WT_PISTOL, ItemConstants.WT_DUAL_FIREARMS, ItemConstants.WT_EXOTIC, ItemConstants.WT_RIBBON]; // "Scythe", "Staff", "Tetsubo", "Ribbon", "Tome"
			var btnInt:int = 0;
			var tempAry:Array = [];
			outputText("Welcome. Here, you can offer your weapons to the god of war, consuming the weapon to gain knowledge of the battles it's seen.\n");
			for (var i:int = 0; i < inventory.getMaxSlots(); i++){
				var weaponType:String = "";
				var itemClassReplace:*;
				try{
					if (player.itemSlot(i).itype is Weapon){
						itemClassReplace = player.itemSlot(i).itype as Weapon;
						weaponType = itemClassReplace.type;
						//outputText(weaponType + "\n");
					}
					else if (player.itemSlot(i).itype is WeaponRange){
						itemClassReplace = player.itemSlot(i).itype as WeaponRange;
						weaponType = itemClassReplace['perk'].split(',')[0];
						//outputText(weaponType + "\n");
					}
					else{//I don't know why I decided to go with German with this. But it's funny.
						trace("ACHTUNG, ARTIKEL IM STECKPLATZ " + i + " IST NICHT KOMPATIBEL!\n");
						//Warning, Item in Slot i is not compatible.
					}
					if (weaponClasses.indexOf(weaponType) >= 0){
						tempAry.push([player.itemSlot(i).itype,weaponType])
					}
					else if (weaponType) outputText("\nYou cannot offer "+player.itemSlot(i).itype.longName +" to the shrine.");
				}
				catch (e:Error){
					outputText(e + "\n");
				}
			}
			menu();
			for each (var arr1:Array in tempAry){
				addButton(btnInt, arr1[0].shortName,conv2mastery,arr1);
				btnInt++;
			}
			addButton(14, "Back", southSection);


			function conv2mastery(wType:Array, conf:Boolean = false):void{
				clearOutput();
				if (!conf){
					outputText("You can convert your " + wType[0].shortName + " into mastery xp for " + wType[1] + ".\n");
					outputText("Would you like to do that?");
					doYesNo(curry(conv2mastery, wType, true),weaponsXPtrader);
				}
				else{//"Staff", "Tome", "Scythe", "Ribbon"
					switch (wType[1]){
						case ItemConstants.WT_GAUNTLET:
							combat.gauntletXP(40);
							break;
						case ItemConstants.WT_SWORD:
                            combat.swordXP(40, false);
							break;
						case ItemConstants.WT_AXE:
                            combat.axeXP(40, false);
							break;
						case ItemConstants.WT_MACE_HAMMER:
                            combat.macehammerXP(40, false);
							break;
						case ItemConstants.WT_DUELING:
                            combat.duelingswordXP(40, false);
							break;
						case ItemConstants.WT_POLEARM:
                            combat.polearmXP(40, false);
							break;
						case ItemConstants.WT_SPEAR:
                            combat.spearXP(40, false);
							break;
						case ItemConstants.WT_DAGGER:
                            combat.daggerXP(40, false);
							break;
						case ItemConstants.WT_WHIP:
                            combat.whipXP(40, false);
							break;
						case ItemConstants.WT_THROWING:
                            combat.throwingXP(40);
							break;
						case ItemConstants.WT_BOW:
                            combat.archeryXP(40);
							break;
						case ItemConstants.WT_CROSSBOW:
                            combat.archeryXP(40);
							break;
						case ItemConstants.WT_2H_FIREARM:
                            combat.firearmsXP(40);
							break;
						case ItemConstants.WT_RIFLE:
                            combat.firearmsXP(40);
							break;
						case ItemConstants.WT_PISTOL:
                            combat.firearmsXP(40);
							break;
						case ItemConstants.WT_DUAL_FIREARMS:
                            combat.firearmsXP(40);
                            combat.dualWieldFirearmsXP(40);
							break;
						case ItemConstants.WT_EXOTIC:
                            combat.exoticXP(40, false);
							break;
						case ItemConstants.WT_RIBBON:
                            combat.exoticXP(40, false);
							break;
						}
					player.destroyItems(wType[0],1);
					outputText("Item has been consumed.");
					doNext(southSection);
				}
			}
		}
	}
}
