/**
 * @author Ormael
 * Demon area with lvl 26-36 demonic enemies. Each exploration will even slowly corrupt PC unless corruption is above 66.
 * Currently a Work in Progress.
 */

package classes.Scenes.Areas 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.Areas.BlightRidge.*;
import classes.Scenes.SceneLib;
import classes.Scenes.Monsters.ImpLord;

use namespace CoC;
	
	public class BlightRidge extends BaseContent
	{
		public function BlightRidge() 
		{
		}
		
		public function exploreBlightRidge():void {
			flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE]++;
			if (player.cor < 66) dynStats("cor", 1);
			
			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			choice[choice.length] = 0; //Imp enemies
			choice[choice.length] = 1; //Succubi/Incubu/Omnicubi enemies
			choice[choice.length] = 2; //Imp Food
			//choice[choice.length] = 3; //
			//if (rand(3) == 0) choice[choice.length] = 2; //Find Imp's Food ^^
			if (rand(4) == 0) choice[choice.length] = 3; //Find nothing! The rand will be removed from this once the Blight Ridge is populated with more encounters.
			
			//Ignis intro
			if (flags[kFLAGS.FACTORY_SHUTDOWN] > 0 && flags[kFLAGS.IGNIS_ARENA_SEER] < 1 && rand(5) == 0) {
				clearOutput();
				outputText("As you walk through blight ridge, you come across a small valley. An unremarkable locale, except for the fact that the moment you step foot in the valley, demons emerge from the ridges surrounding and swarming you from their vantage points.\n\n");
				outputText("\"<b>It’s an ambush!</b>\"\n\n");
				outputText("You raise your [weapon], only to feel a weight crushing down on you, pinning you to the floor. The line of demons surrounding you laugh and taunt you, but make no effort to approach.  You struggle, but your ");
				if (player.str > 50) outputText("considerable ");
				outputText("strength is not enough to overcome this unseen force! The line of demons parts in unison as a robed incubus walks towards you.  The incubus leers at you from above, a globe of crackling darkness floating above his outstretched hand. \"<i>Gravity magic.  Isn’t it marvelous?</i>\" The incubus laughs darkly. ");
				outputText("\"<i>Even Lethice’s court sorcerers don’t have this yet.  It hasn’t gone through enough...</i>\" He gestures towards you, speaking in a calm but superior tone, \"<i>...experimentation.  But i’m being rude!  You’re the so called ‘champion’ that destroyed the factory, are you not?  Heh...  Welcome to my territory.  My name is-</i>\"\n\n");
				outputText("Something flashes at the corner of your eye, and as you twist your head to look for the source, the demon mage collapses and the force holding you dissipates. You stand and raise your [weapon], much to the surprise of the demons watching from the circle they form around you. You glance at the incubus mage, seeing an ugly purple welt forming on his forehead. ");
				outputText("\"<i>Sorry to interrupt the party</i>\" comes a cheerful voice from behind you. You turn around to see a robed figure vaulting over the line of demons. The mysterious mage gestures, \"<i>You deal with your half, i’ll deal with mine!</i>\" You nod, turning to face the other demon mob.\n\n");
				startCombat(new DemonPackBlightRidge());
				return;
			}
			//Den of Desire
            if (SceneLib.dungeons.canFindDenOfDesire() && flags[kFLAGS.DEN_OF_DESIRE_BOSSES] < 1 && ((rand(10) == 0) || (flags[kFLAGS.DEN_OF_DESIRE_QUEST] > 0 && rand(2) == 0))) {
                clearOutput();
				outputText("You come across a set of old ruins, their grounds littered with statues, with an underground entrance leading deeper inside. ");
				if (flags[kFLAGS.DEN_OF_DESIRE_QUEST] > 0) outputText("This looks to be the lair of the golemancer Rathazul mentioned. ");
				outputText("Do you enter?");
				flags[kFLAGS.DEN_OF_DESIRE_BOSSES] = 1;
				menu();
                addButton(0, "Yes", SceneLib.dungeons.enterDenOfDesire);
                addButton(1, "No", camp.returnToCampUseOneHour);
				return;
			}
			//Alvina
			if (flags[kFLAGS.ALVINA_FOLLOWER] < 12 && player.hasKeyItem("Zetaz's Map") >= 0 && ((rand(10) == 0) || (flags[kFLAGS.LETHICE_DEFEATED] > 0 && rand(2) == 0))) {
				SceneLib.alvinaFollower.alvinaThirdEncounter();
				return;
			}
			if (((flags[kFLAGS.ALVINA_FOLLOWER] > 8 && flags[kFLAGS.ALVINA_FOLLOWER] < 12 && player.hasKeyItem("Zetaz's Map") >= 0) || player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 2) && rand(2) == 0) {
				SceneLib.alvinaFollower.alvinaThirdEncounter();
				return;
			}
			//Siegweird
			if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3 && rand(4) == 0) {
				if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] < 3) SceneLib.siegweirdFollower.siegweirdFirstEncounter();
				else SceneLib.siegweirdFollower.siegweirdRepeatEncounterPostFight();
				return;
			}
			if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] < 2 && rand(4) == 0) {
				SceneLib.siegweirdFollower.siegweirdFirstEncounter();
				return;
			}
			if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 2.5 && rand(4) == 0) {
				SceneLib.siegweirdFollower.siegweirdRepeatEncounterPostFight();
				return;
			}
			if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 2 && rand(2) == 0) {
				player.createStatusEffect(StatusEffects.SiegweirdImp,0,0,0,0);
				startCombat(new ImpLord());
				return;
			}
			
			select = choice[rand(choice.length)];
			switch(select) {
				case 0:
					SceneLib.exploration.genericImpEncounters2();
					break;
				case 1:
					SceneLib.exploration.genericDemonsEncounters1();
					break;
				case 2:
					clearOutput();
					outputText("You spot something on the ground. Taking a closer look, it's one of those imps food packages. ");
					inventory.takeItem(consumables.IMPFOOD, camp.returnToCampUseOneHour);
					break;
				default:
					clearOutput();
					outputText("You spend one hour exploring the tainted ridge but you don't manage to find anything interesting, unless feeling of becoming slight more horny counts.");
					dynStats("lib", .5);
					doNext(camp.returnToCampUseOneHour);
			}
		}
	}
}