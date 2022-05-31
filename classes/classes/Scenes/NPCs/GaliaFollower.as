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
			//outputText("(<b>Galia has been added to the Slaves menu!</b>)\n\n");w innej późniejszej scenie wspomnieć to
			flags[kFLAGS.GALIA_TALKS] = 1;
			flags[kFLAGS.GALIA_LVL_UP] = 1;
			flags[kFLAGS.GALIA_AFFECTION] = 1;
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function GaliaSparring():void {
			clearOutput();
			outputText("\"<i>Good. I was feeling a bit itchy lately. You won't hold grunge if I go a bit too 'rough' on you, right?</i>\" And without even waiting for your answer Galia starts to crack her fists.");
			startCombat(new Galia());
		}
		public function GaliaWonSparring():void {
			clearOutput();
			outputText("\"<i>To the winners goes the spoils,</i>\" and before you even have chance to protest Galia starts second round of beating. This time a bit shorter and less violent than the first one.");
			HPChange(player.maxHP() * 0.1, false);
			cleanupAfterCombat();
		}
		public function GaliaLostSparring():void {
			clearOutput();
			outputText("After a longer moment Galia calm down and only say few words with low voice before walking away to her resting place. \"<i>You won this time but I'll win next time.</i>\"");
			/*if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
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
				}
				if (flags[kFLAGS.GALIA_DEFEATS_COUNTER] == 3 && flags[kFLAGS.GALIA_LVL_UP] == 4) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2));
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2), 0, 0);
					flags[kFLAGS.GALIA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.GALIA_LVL_UP] = 5
				}
			}*/
			cleanupAfterCombat();
		}
	}
}