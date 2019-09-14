//Quest Dungeon: The Ebon Labyrinth (for Alvina Black Rose Quest)
/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons 
{
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumables.MinotaurBlood;
import classes.Scenes.Areas.BlightRidge.Incubus;
import classes.Scenes.Areas.BlightRidge.Omnibus;
import classes.Scenes.Areas.BlightRidge.Succubus;
import classes.Scenes.Areas.Caves.DarkSlime;
import classes.Scenes.Areas.Caves.DisplacerBeast;
import classes.Scenes.Areas.Forest.TentacleBeast;
import classes.Scenes.Areas.Mountain.Minotaur;
import classes.CoC;
import classes.StatusEffects;

	public class EbonLabyrinth extends DungeonAbstractContent
	{
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_01:int	= 131;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_02:int	= 132;
		
		public function EbonLabyrinth() {}
		
		public function enterDungeon():void {
			inDungeon = true;
			dungeonLoc = 131;
			outputText("Should be some text here after Liadri decide what it would be.");
			player.createStatusEffect(StatusEffects.EbonLabyrinthA, 10, 0, 0, 0);
			player.createStatusEffect(StatusEffects.EbonLabyrinthB, 0, 0, 0, 0);
			playerMenu();
		}
		public function exitDungeon():void {
			inDungeon = false;
			clearOutput();
			outputText("You leave the Ebon Labyrinth behind and take off back towards the camp.");
			player.removeStatusEffect(StatusEffects.EbonLabyrinthA);
			player.removeStatusEffect(StatusEffects.EbonLabyrinthB);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function encountersRuletteEL():void {
			if (rand(100) < player.statusEffectv1(StatusEffects.EbonLabyrinthA)) {
				var reset:Number = 10;
				reset -= player.statusEffectv1(StatusEffects.EbonLabyrinthA);
				player.addStatusValue(StatusEffects.EbonLabyrinthA, 1, reset);
				var choice:Number = rand(8);
				if (choice == 0) {
					outputText("You turn around the corner and come face to face with a greyish six armed catgirl. She would be terrifying already even without the two tentacles on her back that writhe in excitation. Readying for battle is the best you can do as the beast woman charges you with a gleam of hunger in her feral eyes.");
					startCombat(new DisplacerBeast(), true);
				}
				if (choice == 1) {
					outputText("You turn around the corner and come face to face with a greyish six armed catgirl. She would be terrifying already even without the two tentacles on her back that writhe in excitation. Readying for battle is the best you can do as the beast woman charges you with a gleam of hunger in her feral eyes.");
					startCombat(new DisplacerBeast(), true);
					//spriteSelect(25);
					/*outputText("As you wander into a new corridor you come face to face with a purplish jelly-like woman. She giggles upon spotting you, her small, sphere-shaped core emitting an ominous light as she surges toward you with a gooey smile.\n\n");
					outputText("\"<i>Dinner is served! Your fluids are mine, so surrender them now intruder and I promise to make it very pleasurable for you!</i>\"\n\n");
					startCombat(new DarkSlime(), true);*/
				}
				if (choice == 2) {
					clearOutput();
					outputText("You run right into a demon. The fiend look at you confused, then attacks with glee.");
					if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Succubus!</b>")
					}
					startCombat(new Succubus(), true);
				}
				if (choice == 3) {
					clearOutput();
					outputText("You run right into a demon. The fiend look at you confused, then attacks with glee.");
					startCombat(new Incubus(), true);
				}
				if (choice == 4) {
					clearOutput();
					outputText("You run right into a demon. The fiend look at you confused, then attacks with glee.");
					startCombat(new Omnibus(), true);
				}
				if (choice == 5) {
					clearOutput();
					outputText("You’ve barely walked yourself into the corridor when you spot a tentacle beast of absurd size rushing right at you, it looks hungry!");
					startCombat(new TentacleBeast(), true);
				}
				if (choice == 6) {
					clearOutput();
					outputText("Just as you turn the corner, you come face to face with a towering minotaur armed with a pair of huge battle axes and equipped with a full plate armor. The beast smirks as his cock hardens in anticipation. It must’ve been months since he last fucked something!");
					startCombat(new Minotaur(), true);
				}
				if (choice == 7) {
					clearOutput();
					outputText("Just as you turn the corner, you come face to face with a towering minotaur armed with a pair of huge battle axes and equipped with a full plate armor. The beast smirks as his cock hardens in anticipation. It must’ve been months since he last fucked something!");
					startCombat(new Minotaur(), true);
				}
				//Dark Slime, Mindbreaker
				doNext(playerMenu);
			}
			else player.addStatusValue(StatusEffects.EbonLabyrinthA, 1, 10);
		}
		
		//Rooms
		public function roomAAA():void {
			dungeonLoc = 131;
			clearOutput();
			encountersRuletteEL();
			player.addStatusValue(StatusEffects.EbonLabyrinthA,1,1);
			if (CoC.instance.inCombat) return;
			outputText("<b><u>Corridor</u></b>\n");
			outputText("You walk into an empty corridor thankfully it seems to be void of monsters so far.");
			dungeons.setDungeonButtons(roomBBB, roomBBB, roomBBB, roomBBB);
			addButton(10, "Exit", exitDungeon);
		}
		public function roomBBB():void {
			dungeonLoc = 132;
			clearOutput();
			encountersRuletteEL();
			player.addStatusValue(StatusEffects.EbonLabyrinthA,1,1);
			if (CoC.instance.inCombat) return;
			outputText("<b><u></u>Corridor</b>\n");
			outputText("You turn the corner wandering into a new corridor which thankfully seems to be void of monsters so far.");
			dungeons.setDungeonButtons(roomAAA, roomAAA, roomAAA, roomAAA);
			addButton(10, "Exit", exitDungeon);
		}
	}
}