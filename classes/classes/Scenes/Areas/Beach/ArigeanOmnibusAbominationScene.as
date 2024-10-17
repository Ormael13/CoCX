/**
 * ...
 * @author Sylabt & Ohaxer
 */
package classes.Scenes.Areas.Beach 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Beach.ArigeanOmnibusAbomination;
import classes.Scenes.SceneLib;

public class ArigeanOmnibusAbominationScene extends BaseContent
	{
		
		public function ArigeanOmnibusAbominationScene() 
		{
			
		}

public function arigeanOmnibusAbominationEncounter():void {
	//spriteSelect(SpriteDb.s_grayda);
	clearOutput();
	outputText("Surely, finding your target shouldn’t be this hard? An Arigean would definitely stand out against the sand, and you’ve been at it for what’s felt like hours in this smoldering heat. It feels like your skin is effectively burning to a crisp, even a decent amount of shade to allow you a moment of respite would be enough to satisfy you. Hell, you wouldn’t even mind letting a cancer have her way with you if it meant even a moment of refreshment.\n\n");
	outputText("Suddenly, a tentacle bursts forth from the sand, and grabs your ankle, effectively tripping you before you're able to wrench your limb away, the attacker taking this moment to surface.\n\n");
	outputText("\"<i>Hahaha! You’ve certainly decided to make this much harder than it needs to be Onee-chan~</i>\" An Albino woman, supported and violated by many different tentacles and mouths, appears to be your aggressor. Judging from the various tentacles and mouths leaking sticky white fluids and violating every available orifice besides her face, as well as the unintelligible idle babbling she produces, this must be your target.\n\n");
	startCombat(new ArigeanOmnibusAbomination());
}
public function arigeanOmnibusAbominationEncounterWin():void {
	//spriteSelect(SpriteDb.s_grayda);
	clearOutput();
	outputText("You're barely able to stop yourself from touching your body as you finally give in to the heat.\n\n");
	outputText("\"<i>Finally, you’ve decided to submit, Onee-chan~ Now we’re gonna have lots of fun for the rest of eterni-</i>\" Her monologue is interrupted by a sudden explosion of sand from underneath her. It seems your fight somehow angered a nearby cancer."+(silly()?" All hail the holy Crab!":"")+"\n\n");
	outputText("You can see your target angrily retreating into the distance. Clearly, she’s in no condition to fight your mysterious savior after your battle. The cancer seems to be eyeing you carefully. Well, you did say you wouldn’t mind earlier…\n\n");
	SceneLib.beach.cancerScene.rape();
}
public function arigeanOmnibusAbominationEncounterLoss():void {
	//spriteSelect(SpriteDb.s_grayda);
	clearOutput();
	outputText("You walk over to your fallen target, now still and silent, and prepare one of your symbiotic partners to swiftly break her neck for a mercy kill.\n\n");
	outputText("\"<i>T-thank you..</i>\" her voice weakly calls out. It seems she knows your intention. Best to get this over with quickly before you lose the will to.\n\n");
	flags[kFLAGS.THE_TRENCH_ENTERED] = 10;
	cleanupAfterCombat();
}
	}
}