/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Battlefield 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Battlefield.*;
	
	public class BattlefieldEnemiesScenes extends BaseContent
	{
		
		public function BattlefieldEnemiesScenes() 
		{}
		
		public function encounterVengefulApparitions():void {
			clearOutput();
			outputText("You wander through the battlefield and into an ancient encampment of some sort, broken timbers and rusted weapons littering the ground. You feel a vague, crawling sensation making its way up your spine, and the air around you grows cold.\n\n");
			outputText("\"<i>Life…Begone…</i>\" You hear a hissing sound from below the ground, and you jump back as a violet spectre launches up from the ground, elongated claws slashing through where your groin had been. You ready your [weapon], tensing up, but you quickly notice another rise up beside the first.\n\n");
			outputText("\"<i>Leave…</i>\" The second spirit hisses, as several more rise. You back up, but they glide towards you, glowing eyes crackling with power.\n\n");
			outputText("\"<i>Kill…</i>\" More are rising, surrounding you. It seems these vengeful spirits won’t let you leave without a fight.");
			//outputText("As you wander in the battlefield, you find yourself passing through an area riddled with with debris. Ancient tents rot, wooden structures decay... you flinch at a sudden rattling, coming from behind a nearby pile of wood. You turn to face it, but another from behind, another rattle sounds. You watch as a half-rotten skeleton rises from the debris, a vague purple shadow flickering around it. From the corner of your eyes, you see more of the ghastly creatures rising, mismatched bones held together by a barely visible force.  \"<i>Liiivinnng....</i>\" The hissing, dry voice seems to echo, and the bones rattle, misshapen jaws opening wide as the malevolent spirits rush in.");
			startCombat(new VengefulApparitions());
			doNext(playerMenu);
		}
		
		public function defeatVengefulApparitions():void {
			clearOutput();
			outputText("Finally, it's over. With the last of the apparitions defeated, you finally catch your breath. But your victory seems hollow, as they all begin to disperse the same way they appeared. The only thing left behind is a bottle containing some green-tinted substance.");
			//outputText("Finally, it's over. As the last violet aura fades, the final skeleton down, you stop to catch your breath. With a hissing screech, the bones begin to crumble. A cold wind picks up, carrying the remains away...After a few moments, the only thing that's left of the vengeful spirits is a bottle with some bubbling, green-tinted substance.");
			inventory.takeItem(consumables.ECTOPLS, cleanupAfterCombat);
		}
		
		public function loseToAVengefulApparitions():void {
			clearOutput();
			outputText("You fall to your knees out of steam to keep fighting your adversaries. Without delay, they all pounce at you, ripping pieces of you apart. Surprisingly, it's not your flesh but something more ethereal, and before you can think further, you lose consciousness...");
			//outputText("You fall, [legs] giving way and dropping your face to the dusty ground. Without delay they all pounce, rattling bones steaming as they rip into you. With each gash, each rip in your body, you can feel less and less, blackness overtaking your vision...");
			//outputText("...You wake, still in the debris of the ancient battlefield...but you're not the same. Your flesh is gone, and in its place is pale, translucent...ectoplasm?");
			player.fatigue = player.maxOverFatigue();
			player.mana = 0;
			player.soulforce = 0;
			cleanupAfterCombat();
		}
		public function canEncounterZombies():Boolean {
			return !player.isRaceCached(Races.JIANGSHI);
		}
		public function encounterZombies():void {
			clearOutput();
			outputText("As you explore the battlefield you hear what sounds like pleading moans. Confused, you head toward the sound and find what appears to be several beautiful naked human men and women with pale blue skin. They slowly turn toward you revealing a strange paper tag stuck to their foreheads.\n\n");
			if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] > 3) outputText("You recognize these creatures...You used to be one of them, after all. But they've noticed you now.");
			else outputText("At first you ask one of them if it needs help, but the way it's salivating...You look into their eyes, and know they're not going to listen. You ready your [weapon]");
			outputText("\n\nWith a dim-witted moan, their eyes shining with a disturbing hunger, they slowly begin to hop toward you. They hold their hands out as if to embrace you, glowing purple nails shimmering with an odd, sinister light.");
			startCombat(new Zombies());
			doNext(playerMenu);
		}
		
		public function defeatZombies():void {
			clearOutput();
			outputText("The last of the undead creatures fall, unable to stand. Looking back, you see a variety of bodies...That still move faintly. You haven't killed them; they're just down for now. You decide to grab what loot you can and get out before they get back up.");
			inventory.takeItem(consumables.L_DRAFT, cleanupAfterCombat);
		}
		
		public function loseToZombies():void {
			clearOutput();
			outputText("You try to crawl away but, despite its innate slowness, the zombie moves at about the same speed you do. Inevitably, the thing grabs your leg and reels you back so it can have its way with you. With a dim-witted moan, the zombie shoves your defeated form to the ground and begins to pull your gear out of the way. Before you know it "+(rand(2)==0?"s":"")+"he's aggressively ");
			if (player.hasVagina()) {
				if (player.hasCock()) outputText("grabbing and sucking your cock");
				outputText("lapping at your exposed slit");
			}
			else outputText("forcing you into a kiss");
			outputText(".\n\nTry as you might, the thing is unbelievably strong and you just can't manage to push it off, something made harder by your involuntary growing pleasure. As the undead quite literally forces you toward your impending orgasm, you feel your life energy being sucked out by the ravenous dead, leaving you increasingly drained, which only drives you closer to orgasm as your will and ability to resist die out");
			if (player.hasCock() || player.hasVagina()) {
				outputText(". You spasm helplessly as you cum into the mouth of the zombie, your energy is being forcefully extracted along the way. Too weak to go on, you pass out as the zombie mouth and ravenous tongue unplug from your ");
				if (player.gender == 3) outputText("[cock] and [vagina]");
				else if (player.gender == 2) outputText("[vagina]");
				else outputText("[cock]");
			}
			outputText(".\n\nYou wake up several hours later, feeling empty and weak. Whatever the thing took from you, it left you worse for the wear.\n\n");
			player.addCurse("tou", 40, 1);
			player.HP = player.minHP() + 1;
			player.fatigue = player.maxOverFatigue();
			player.mana = 0;
			player.soulforce = 0;
			cleanupAfterCombat();
		}
	}
}
