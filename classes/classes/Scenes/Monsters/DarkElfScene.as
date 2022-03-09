/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Scenes.Areas.Caves.DarkElfRangerCaves;
    import classes.display.SpriteDb;

public class DarkElfScene extends BaseContent
	{
		public function DarkElfScene() 
		{}
		
		public function introDarkELfScout():void {
			clearOutput();
			spriteSelect(SpriteDb.s_DarkElf);
			outputText("As you explore the area an arrow passes by your elbow, and misses you by a mere inch. You look for your aggressor and spot a dark-skinned woman with pointed ears, purple eyes, and a bow. Having realised her quarry spotted her, she jumps down from her hiding spot toward you and draws a few arrows, smiling malevolently.\n\n");
			outputText("\"<i>Let's see if you make for good slave material, maybe I can sell you for a nice price.</i>\"\n\n");
			startCombat(new DarkElfScout);
		}
		public function introDarkELfSlaver():void {
			clearOutput();
			spriteSelect(SpriteDb.s_DarkElf);
			outputText("As you explore the area an arrow passes by your elbow, and misses you by a mere inch. You look for your aggressor and spot a dark-skinned woman with pointed ears, purple eyes, and a bow. Having realised her quarry spotted her, she jumps down from her hiding spot toward you and draws a few arrows, smiling malevolently.\n\n");
			outputText("\"<i>Let's see if you make for good slave material, maybe I can sell you for a nice price.</i>\"\n\n");
			startCombat(new DarkElfSlaver);
		}
		public function introDarkELfRanger():void {
			clearOutput();
			spriteSelect(SpriteDb.s_DarkElf);
			outputText("As you explore the area an arrow passes by your elbow, and misses you by a mere inch. You look for your aggressor and spot a dark-skinned woman with pointed ears, purple eyes, and a bow. Having realised her quarry spotted her, she jumps down from her hiding spot toward you and draws a few arrows, smiling malevolently.\n\n");
			outputText("\"<i>Let's see if you make for good slave material, maybe I can sell you for a nice price.</i>\"\n\n");
			startCombat(new DarkElfRanger);
		}
		public function introDarkELfSniper():void {
			clearOutput();
			spriteSelect(SpriteDb.s_DarkElf);
			outputText("As you explore the area an arrow passes by your elbow, and misses you by a mere inch. You look for your aggressor and spot a dark-skinned woman with pointed ears, purple eyes, and a bow. Having realised her quarry spotted her, she jumps down from her hiding spot toward you and draws a few arrows, smiling malevolently.\n\n");
			outputText("\"<i>Let's see if you make for good slave material, maybe I can sell you for a nice price.</i>\"\n\n");
			startCombat(new DarkElfSniper);
		}
		public function introDarkELfRangerCaves():void {
			clearOutput();
			spriteSelect(SpriteDb.s_DarkElf);
			outputText("As you explore the tunnels an arrow flies out of the shadows and passes by your elbow, missing you by a mere inch. You look for your aggressor and spot a dark-skinned woman with pointed ears, purple eyes, and a bow. Having realised her quarry spotted her, she jumps down from her hiding spot toward you and draws a few arrows, smiling malevolently.\n\n");
			outputText("\"<i>Let's see if you make for good slave material, maybe I can sell you for a nice price.</i>\"\n\n");
			startCombat(new DarkElfRangerCaves);
		}
		
		public function lostToDarkElf():void {
			clearOutput();
			spriteSelect(SpriteDb.s_DarkElf);
		//	if () if PC been in Prison sent it there
		//	else {
				outputText("You fall to the ground defeated and the elf grabs you by the chin, examining you for a few seconds before declaring.\n\n");
				outputText("\"<i>Pah, worthless! Even for slavery that’s the lowest quality product. You really weren’t worth my time. You’re lucky my slave cart is already filled with prisoners more precious than you.</i>\"\n\n");
				outputText("She’s clearly as disappointed as you’re relieved. You look at her in stupor as she runs off and disappears in the nearby bushes, did you just escape slavery by a hair strand of luck?\n\n");
				cleanupAfterCombat();
		//	}
		}
		
		public function wonWithDarkElf():void {
			clearOutput();
			spriteSelect(SpriteDb.s_DarkElf);
			outputText("You manage to force the dark skinned bitch on her back, so she falls to the ground defeated, yet smirking. Just as you are about to grab her, she throws a smoke bomb on the ground and uses the screen to cover her escape. Blast! She’s fast, there is no way you will catch her now.\n\n");
			cleanupAfterCombat();
		}
	}
}