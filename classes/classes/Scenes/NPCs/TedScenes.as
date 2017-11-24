/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;

public class TedScenes extends NPCAwareContent
	{
		
		public function TedScenes() 
		{
		}
		
		public function defeatedTed():void
		{
			outputText(". Despite situation he start to muttering seemly to himslef but with his voice volume it seems he want you to hear it.\n\n");
			outputText("\"<i>I lost? No...I just feel gratious today to not show this mortal my limitless divine powers and should...</i>\" he paused as if thinking over next words to say \"<i>make a grand strategical retreat for now.</i>\"\n\n");
			outputText("When you start to moving closer to him all of sudden he stands up and before you even react crushing some sort of talisman laughing loud. \"<i>I need to attend to other maters so I letting you off the hook today.</i>\" He utters when the brighting light blinds you for a long moment to let him make this 'grand stategical retreat'.");
			outputText("\"<i>Repent on your sins and worship me properly when we meet again or my bam hammer won't be so forgving then,</i>\" his last words echoes in room as your blindness receding. Seems he used some sort of teleport item to escape and it seems it may be not the last time you will meet this slight delusional dragon-boy.");
			flags[kFLAGS.HIDDEN_CAVE_BOSSES] = 1;
			cleanupAfterCombat();
			return;
		}
		
		public function lostToTed():void
		{
			clearOutput();
			outputText("After another swing of enemy hammer you loose consciousness.\n\n");
			outputText("<b>Few hours later...</b>\n\n");
			outputText("You wakes up with terrible headache just to find yourself tied up and guarded by... one of those loli bat golems you beaten. She slowly walk up to you smiling that due to her golem anture look very creepy and then she speaks, \"<i>Master after consideration evaluatied you as not good material to his evergrowing army of worshipers. But....</i>\"");
			outputText(" her smile become more wider (or maybe one would say more creppy), \"<i>he need also some examples to show how ends up thsoe that rejected his offer right away and forced him to send his faithfull minions to 'correct' those mortals. Of course there is always chance mortal can not survive 'corrections'...</i>\" ");
			outputText("And with that she close the distance divinding you both and without any more words start to pummel you that not stops even when you loose consciousness again. Only when she is sure that you not longer breathing she stopping.\n\n");
			outputText("\"<i>You're as reliable as always Aurora. If only other little sisters was as faithfull servants as you...</i>\".\n\n");
			EventParser.gameOver();
			removeButton(1);
		}
		
	}

}