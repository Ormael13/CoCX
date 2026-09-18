/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Plains 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Desert.Mummy;
import classes.Scenes.Areas.Plains.*;
import classes.Scenes.SceneLib;
	
	public class ZombieMummyScenes extends BaseContent
	{
		
		public function ZombieMummyScenes() 
		{}
		
		public function canEncounterZombie():Boolean {
			return !player.isRaceCached(Races.JIANGSHI);
		}
		public function encounterZombieOuter():void {
			clearOutput();
			flags[kFLAGS.ZOMBIE_MUMMY_GENDER] = rand(2);
			encounterZombie();
		}
		public function encounterZombieInner():void {
			clearOutput();
			flags[kFLAGS.ZOMBIE_MUMMY_GENDER] = 2 + rand(2);
			encounterZombie();
		}
		public function encounterZombie():void {
			camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_CORPSE_PUPPETS);
			outputText("As you explore the plains you hear what sounds like a pleading moan. Confused, you head toward the sound and find what appears to be a beautiful naked human " + ((flags[kFLAGS.ZOMBIE_MUMMY_GENDER] == 1 || flags[kFLAGS.ZOMBIE_MUMMY_GENDER] == 3)?"wo":"") + "man with pale blue skin.");
			outputText(" " + ((flags[kFLAGS.ZOMBIE_MUMMY_GENDER] == 1 || flags[kFLAGS.ZOMBIE_MUMMY_GENDER] == 3)?"Sh":"H") + "e slowly turns toward you revealing what appears to be a strange paper tag stuck to its forehead.\n\n");
			if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] > 3) outputText("Crap it's a zombie just like you used to be and it noticed you!");
			else outputText("At first you ask the person if it needs help but the way it's salivating at you now puts you on your guard.");
			outputText("\n\nWith a dim-witted moan and a look of yearning and hunger that shakes you to your core with fear, it slowly begins to hop toward you with its glowing purple nails pointing in your direction.");
			startCombat(new Zombie());
			doNext(playerMenu);
		}
		public function defeatZombieMummy():void {
			clearOutput();
			outputText("The undead falls to the ground, clearly in need of rest after taking so much punishment. You know better than to try and fuck something that might drain you dry and leave with whatever spoil this thing dropped.");
			menu();
			addButtonIfTrue(3, "Tame It", SceneLib.campMakeWinions.tamingAttempt, "Req. to have Job: Tamer", player.hasPerk(PerkLib.JobTamer));
			addButton(4, "Leave", defeatZombieMummyLeave);
		}
		private function defeatZombieMummyLeave():void {
			outputText(" You know better than to try and fuck something that might drain you dry and leave with whatever spoil this thing dropped.");
			inventory.takeItem(consumables.L_DRAFT, cleanupAfterCombat);
		}
		public function loseToZombie(female:Boolean = false):void {
			clearOutput();
			outputText("You try to crawl away but, despite its innate slowness, the zombie moves at about the same speed you do. Inevitably, the thing grabs your leg and reels you back so it can have its way with you. With a dim-witted moan, the zombie shoves your defeated form to the ground and begins to pull your gear out of the way. Before you know it "+(female == true?"s":"")+"he's aggressively ");
			if (player.hasVagina()) {
				if (player.hasCock()) outputText("grabbing and sucking your cock");
				outputText("lapping at your exposed slit");
			}
			else outputText("forcing you into a kiss");
			outputText(".\n\nTry as you might, the thing is unbelievably strong and you just can't manage to push it off, something your unrequited growing pleasure only makes harder. As the undead quite literally forces you toward your impending orgasm, you feel your life energy being sucked out by the ravenous dead, leaving you increasingly drained, which only drives you closer to orgasm as your will and ability to resist dies out");
			if (player.hasCock() || player.hasVagina()) {
				outputText(". You spasm helplessly as you cum into the mouth of the zombie, your energy being forcefully extracted along the way. Too weak to go on you pass out as the zombie mouth and ravenous tongue unplug from your ");
				if (player.gender == 3) outputText("[cock] and [vagina]");
				else if (player.gender == 2) outputText("[vagina]");
				else outputText("[cock]");
			}
			outputText(".");
			loseToZombieMummy();
		}
		
		public function encounterMummyOuterDesert():void {
			clearOutput();
			flags[kFLAGS.ZOMBIE_MUMMY_GENDER] = 4 + rand(2);
			encounterMummy();
		}
		public function encounterMummyInnerDesert():void {
			clearOutput();
			flags[kFLAGS.ZOMBIE_MUMMY_GENDER] = 6 + rand(2);
			encounterMummy();
		}
		public function encounterMummy():void {
			camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_CORPSE_PUPPETS);
			outputText("While traveling in the desert you run into what appears to be a " + ((flags[kFLAGS.ZOMBIE_MUMMY_GENDER] == 5 || flags[kFLAGS.ZOMBIE_MUMMY_GENDER] == 7)?"wo":"") + "man with red glowing eyes. H" + ((flags[kFLAGS.ZOMBIE_MUMMY_GENDER] == 5 || flags[kFLAGS.ZOMBIE_MUMMY_GENDER] == 7)?"er":"is") + " skin is partially covered in bandages. ");
			outputText("At first you wave to h" + ((flags[kFLAGS.ZOMBIE_MUMMY_GENDER] == 5 || flags[kFLAGS.ZOMBIE_MUMMY_GENDER] == 7)?"er":"im") + " but her dim witted moan and strange lumbering movement alarms you to her aggressive intention. ");
			outputText("This is no person, this thing is a mummy and it's starving for your lifeforce! The walking dead lunges toward you, its bandaged hand grasping forward for a chance to pull you into its cold loving embrace!");
			startCombat(new Mummy());
			doNext(playerMenu);
		}
		public function loseToMummy(female:Boolean = false):void {
			outputText("You try to crawl away but, despite its innate slowness, the mummy moves at about the same speed you do. Inevitably, the thing grabs your leg and reels you back so it can have its way with you. With a dim-witted moan, the mummy shoves your defeated form to the ground and begins to pull your gear out of the way. Before you know it "+(female == true?"s":"")+"he's aggressively ");
			if (player.hasVagina()) {
				if (player.hasCock()) outputText("grabbing and sucking your cock");
				outputText("lapping at your exposed slit");
			}
			else outputText("forcing you into a kiss");
			outputText(".\n\nTry as you might, the thing is unbelievably strong and you just can't manage to push it off, something your unrequited growing pleasure only makes harder. As the undead quite literally forces you toward your impending orgasm, you feel your life energy being sucked out by the ravenous dead, leaving you increasingly drained, which only drives you closer to orgasm as your will and ability to resist dies out");
			if (player.hasCock() || player.hasVagina()) {
				outputText(". You spasm helplessly as you cum into the mouth of the mummy, your energy being forcefully extracted along the way. Too weak to go on you pass out as the mummy mouth and ravenous tongue unplug from your ");
				if (player.gender == 3) outputText("[cock] and [vagina]");
				else if (player.gender == 2) outputText("[vagina]");
				else outputText("[cock]");
			}
			outputText(".");
			loseToZombieMummy();
		}
		
		public function loseToZombieMummy():void {
			outputText("\n\nYou wake up several hours later, feeling empty and weak. Whatever the thing took from you, it left you worse for the wear.\n\n");
			player.addCurse("tou", 40, 1);
			player.HP = player.minHP() + 1;
			player.fatigue = player.maxOverFatigue();
			player.mana = 0;
			player.soulforce = 0;
			cleanupAfterCombat();
		}
	}
}