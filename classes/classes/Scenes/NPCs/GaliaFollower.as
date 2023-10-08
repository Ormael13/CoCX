/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.Galia;

	public class GaliaFollower extends NPCAwareContent
	{
		
		public function GaliaFollower() 
		{}
		
		public function bringBackTheFemImp():void {
			clearOutput();
			outputText("You arrive back in camp just in time to spot Evangeline poking your recent impish acquisition with a stick taking swift notes on a paper with a semi manic smile.\n\n");
			outputText("\"<i>Oh my gosh! Oh my gosh!! Oh my GOSH!!! A female imp I never thought I’d see one of those! And it’s alive too!</i>\"\n\n");
			outputText("Evangeline suddenly realise you are staring awkwardly and rush to you.\n\n");
			outputText("\"<i>[name] you MUST allow me to do test on this thing I must study its ecology and function maybe I will even finish with a live dissection!</i>\"\n\n");
			outputText("Evangeline pout before turning back to you.");
			if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) {
				outputText("\n\nAmily annoyed reply right away.\n\n");
				outputText("\"<i>Get to the dissection already this thing is polluting our air! The sooner it's dead the better.</i>\"\n\n");
			}
			if (player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] != 3) outputText("\n\nJojo simply adds that killing it now is the merciful thing to do while.\n\n");
			if (CelessScene.instance.isCompanion()) outputText("\n\nCeless seems genuinely "+(CelessScene.instance.isCorrupt ? "curious" : "scared")+" of the imp.");
			//(If Alvina) outputText("\n\nWhile not physically present you can hear Alvina giggle in your mind replying that this thing would make an interesting lab rat for her black magic researches.\n\n");
			//(Siegweird) outputText("\n\nSiegweird propose to skip the dissection and simply kill it now.\n\n");
			outputText("Yea no one is going to perform any experiment or dissection on this imp until you authorize it. This much you make clear to Evangeline. She is disappointed at first but reply regardless.\n\n");
			outputText("\"<i>When you care enough about the progress of science tell me and we'll proceed with the tests.</i>\"\n\n");
			flags[kFLAGS.GALIA_TALKS] = 1;
			flags[kFLAGS.GALIA_LVL_UP] = 1;
			flags[kFLAGS.GALIA_AFFECTION] = 1;
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function GaliaCampMainMenuSlave():void {
			clearOutput();
			outputText("Galia glances at you, eyes dulled with boredom, but still slightly miffed.\n\n");
			outputText("She sighs before speaking curtly to you, \"<i>What?</i>\"");
			menu();
			addButton(0, "Appearance", GaliaCampMainMenuSlaveAppearance);
			//1 - talk
			addButton(2, "Spar", GaliaSparring).hint("Get into a quick battle with Galia!").disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 2, "You need a good sparring ring for that.");
			//3 - sex
			//4 v 9 - give items
			addButton(14, "Back", camp.campSlavesMenu);
		}
		
		public function GaliaCampMainMenuSlaveAppearance():void {
			clearOutput();
			outputText("Galia is a short, two-foot, three-inch tall feral imp. Her shaggy, unkempt mane still harbors some elegance to it, with the platinum blonde locks parted by the dual set of curved horns. To prevent her hair from dragging across the ground, she has braided it into twin tails for her stature to be taller than the length of her hair. Her eyes are a solid black, save for tiny red irises that peer toward you judgmentally, still in resentment from the transformation.\n\n");
			outputText("Her breasts are about DD cups, which, given her diminutive figure, makes them seem almost too large for her shape. Her once athletic, toned body has long been replaced by soft, pliable flesh, much to her chagrin. Her wide, womanly hips almost force a sluggish, swaying gait as she moves around, coupled with the difficulty of all the mass in her ass that jiggles slightly with each step.\n\n");
			outputText("A pair of tiny, yet functional wings flap occasionally from her back. Her skin is a bright red hue, unobstructed by clothing or armor, save for a small loincloth tied at her waist that wraps up to her chest. Her feet are protected by tiny wooden sandals, and her hands are tipped with a set of dangerous claws, even post-transformation.\n\n");
			menu();
			addButton(14, "Back", GaliaCampMainMenuSlave);
		}  
		
		public function GaliaSparring():void {
			clearOutput();
			outputText("She nods as you ask her to fight, \"<i>Good. I was feeling a bit itchy lately... You won't hold a grudge if I didn't hold back on you, right? It's going to get rough!</i>\"\n\n");
			outputText("Without your input, she rushes in, ready to start another fight.");
			startCombat(new Galia());
		}
		public function GaliaWonSparring():void {
			clearOutput();
			outputText("She hovers over you defiantly, \"<i>To the winners goes the spoils.</i>\"\n\n");
			outputText("Before you're offered a chance to recover, Galia begins another round of beating, albeit slightly less violent than before.");
			HPChange(player.maxHP() * 0.1, false);
			cleanupAfterCombat();
		}
		public function GaliaLostSparring():void {
			clearOutput();
			outputText("After some time, Galia calms down, her voice struggling not to break as she trods off to her resting place, \"<i>You... won this time... but I'll have the next... I swear...</i>\"");
			if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
				if (flags[kFLAGS.GALIA_DEFEATS_COUNTER] >= 1) flags[kFLAGS.GALIA_DEFEATS_COUNTER]++;
				else flags[kFLAGS.GALIA_DEFEATS_COUNTER] = 1;
				if (flags[kFLAGS.GALIA_DEFEATS_COUNTER] == 1 && flags[kFLAGS.GALIA_LVL_UP] == 1) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 0.5));
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 0.5), 0, 0);
					flags[kFLAGS.GALIA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.GALIA_LVL_UP] = 2;
				}
				if (flags[kFLAGS.GALIA_DEFEATS_COUNTER] == 1 && flags[kFLAGS.GALIA_LVL_UP] == 2) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 2, player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction));
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction), 0, 0);
					flags[kFLAGS.GALIA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.GALIA_LVL_UP] = 3;
				}
				if (flags[kFLAGS.GALIA_DEFEATS_COUNTER] == 2 && flags[kFLAGS.GALIA_LVL_UP] == 3) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2));
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2), 0, 0);
					flags[kFLAGS.GALIA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.GALIA_LVL_UP] = 4;
				}/*
				if (flags[kFLAGS.GALIA_DEFEATS_COUNTER] == 3 && flags[kFLAGS.GALIA_LVL_UP] == 4) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2));
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2), 0, 0);
					flags[kFLAGS.GALIA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.GALIA_LVL_UP] = 5
				}*/
			}
			cleanupAfterCombat();
		}
	}
}