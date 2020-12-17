/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	
	public class FleshGolemScene extends BaseContent
	{
		
		public function FleshGolemScene() 
		{}
		
		public function introBasicFleshGolemS():void {
			clearOutput();
			if (rand(2) == 0) {
				outputText("As you take a stroll, from behind of nearby combatants remains emerge group of golems. Looks like you have encountered improved dummy golems! You ready your [weapon] for a fight!");
				startCombat(new GolemsDummyImproved());
			}
			else {
				
			}
		}
		public function introImprovedFleshGolemS():void {
			clearOutput();
			if (rand(2) == 0) {
				outputText("As you take a stroll, from behind of nearby combatants remains emerge group of golems. Looks like you have encountered improved dummy golems! You ready your [weapon] for a fight!");
				startCombat(new GolemsDummyImproved());
			}
			else {
				
			}
		}
		public function introAdvancedFleshGolemS():void {
			clearOutput();
			if (rand(2) == 0) {
				outputText("As you take a stroll, from behind of nearby combatants remains emerge group of golems. Looks like you have encountered improved dummy golems! You ready your [weapon] for a fight!");
				startCombat(new GolemsDummyImproved());
			}
			else {
				
			}
		}
		public function introSuperiorFleshGolemS():void {
			clearOutput();
			if (rand(2) == 0) {
				outputText("As you take a stroll, from behind of nearby combatants remains emerge group of golems. Looks like you have encountered improved dummy golems! You ready your [weapon] for a fight!");
				startCombat(new GolemsDummyImproved());
			}
			else {
				
			}
		}
		
		public function introCorruptedBasicFleshGolemS():void {
			clearOutput();
			if (rand(2) == 0) {
				outputText("As you take a stroll, from behind of nearby remains emerge golem. It isn't typical one with what looks like skin seen between pieces of white armor she's wearing. Looks like you have encountered corrupted basic flesh golem! You ready your [weapon] for a fight!");
				startCombat(new CorruptedFleshGolemBasic());
			}
			else {
				outputText("As you take a stroll, from behind of nearby remains emerge group of golems. They aren't typical ones with what looks like skin seen between pieces of white armors they're wearing. Looks like you have encountered corrupted basic flesh golems! You ready your [weapon] for a fight!");
				startCombat(new CorruptedFleshGolemsBasic());
			}
		}
		public function introCorruptedImprovedFleshGolemS():void {
			clearOutput();
			if (rand(2) == 0) {
				outputText("As you take a stroll, from behind of nearby remains emerge golem. It isn't typical one with what looks like skin seen between pieces of white armor she's wearing. Looks like you have encountered corrupted improved flesh golem! You ready your [weapon] for a fight!");
				startCombat(new CorruptedFleshGolemImproved());
			}
			else {
				outputText("As you take a stroll, from behind of nearby remains emerge group of golems. They aren't typical ones with what looks like skin seen between pieces of white armors they're wearing. Looks like you have encountered corrupted improved flesh golems! You ready your [weapon] for a fight!");
				startCombat(new CorruptedFleshGolemsImproved());
			}
		}
		
		public function lostToFleshGolem():void {
			clearOutput();
			outputText("You fall to the ground defeated and the elf grabs you by the chin, examining you for a few seconds before declaring.\n\n");
			outputText("\"<i>Pah, worthless! Even for slavery that’s the lowest quality product. You really weren’t worth my time. You’re lucky my slave cart is already filled with prisoners more precious than you.</i>\"\n\n");
			outputText("She’s clearly as disappointed as you’re relieved. You look at her in stupor as she runs off and disappears in the nearby bushes, did you just escape slavery by a hair strand of luck?\n\n");
			cleanupAfterCombat();
		}
		
		public function wonWithFleshGolem():void {
			clearOutput();
			outputText("You manage to force the dark skinned bitch on her back, so she falls to the ground defeated, yet smirking. Just as you are about to grab her, she throws a smoke bomb on the ground and uses the screen to cover her escape. Blast! She’s fast, there is no way you will catch her now.\n\n");
			cleanupAfterCombat();
		}
	}
}