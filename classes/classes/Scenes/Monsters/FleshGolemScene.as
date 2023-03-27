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
				outputText("You pass several bodies, strewn throughout your path. You look away, but as you turn, several crude-looking figures rise, hidden among the bodies. They look too crude to be permanent, probably left behind by a depraved golemmancer. You ready your [weapon] for a fight!");
				startCombat(new GolemsDummyImproved());
			}
			else {
				
			}
		}
		public function introImprovedFleshGolemS():void {
			clearOutput();
			if (rand(2) == 0) {
				outputText("You pass several bodies, strewn throughout your path. You look away, but as you turn, several disgusting, fleshy figures rise, hidden among the bodies. They look rushed, probably left behind by a novice golemmancer. You ready your [weapon] for a fight!");
				startCombat(new GolemsDummyImproved());
			}
			else {
				
			}
		}
		public function introAdvancedFleshGolemS():void {
			clearOutput();
			if (rand(2) == 0) {
				outputText("You pass several bodies, strewn throughout your path. You look away, but as you turn, several fleshy figures rise, hidden among the bodies. These ones are more advanced, the work of a seasoned golemmancer. You ready your [weapon] for a fight!");
				startCombat(new GolemsDummyImproved());
			}
			else {
				
			}
		}
		public function introSuperiorFleshGolemS():void {
			clearOutput();
			if (rand(2) == 0) {
				outputText("You pass several bodies, strewn throughout your path. You look away, but as you turn, several lifelike figures rise, hidden among the bodies. They're reinforced with heavy bone and grafted muscle. Someone put effort into these monstrous creations. You ready your [weapon] for a fight!");
				startCombat(new GolemsDummyImproved());
			}
			else {
				
			}
		}
		
		public function introCorruptedBasicFleshGolemS():void {
			clearOutput();
			if (rand(2) == 0) {
				outputText("Your wanderings bring you past an old outpost. Several tents, canvas rotten and wood splintered, sit around a broken flagpole. As you stop, this sight catching your attention, a single mount of dirt erupts. A single golem claws its way out from the ground, odd-colored flesh partly covered by white shards, bits of armour either hanging from, or embedded into the creature's flesh. It looks straight at you, and to your disgust, the creation has genitalia, and functioning ones at that! You ready your [weapon] for a fight, as the creature lumbers towards you.");
				startCombat(new CorruptedFleshGolemBasic());
			}
			else {
				outputText("Your wanderings bring you past an old outpost. Several old wooden buildings, long-since broken, burnt or destroyed, sit inside what was once a trench. In the center, a broken flagpole stands, a tattered, half-burnt flag still waving in the breeze. As you stop, this sight catching your attention, several mounds nearby erupt, tossing dirt every which way. Golems force their way out from the ground, odd-colored flesh mostly covered by white shards, bits of what once had been armour either hanging from, or embedded into the creatures' flesh. They turn towards you, and to your disgust, they have genitalia, and functioning ones at that! They lumber towards you, and you ready your [weapon] for a fight!");
				startCombat(new CorruptedFleshGolemsBasic());
			}
		}
		public function introCorruptedImprovedFleshGolemS():void {
			clearOutput();
			if (rand(2) == 0) {
				outputText("Your wanderings bring you past an old outpost. Several old wooden buildings, long-since broken, burnt or destroyed, sit inside what was once a trench, lined with now-rotten stakes. There once was a small wooden wall, but there was a clear fight here, and most of the wall now sits in pieces, strewn throughout this former outpost. In the center, a broken flagpole stands, a tattered, half-burnt flag still waving in the breeze. As you stop, this sight catching your attention, several mounds nearby erupt, tossing dirt every which way. Golems force their way out from the ground, odd-colored flesh mostly covered by white shards, bits of what once had been armour either hanging from, or embedded into the creatures' flesh. They turn towards you, and to your disgust, they have genitalia, and functioning ones at that! They lumber towards you, and you ready your [weapon] for a fight!");
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
