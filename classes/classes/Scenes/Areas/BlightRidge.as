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
import classes.Scenes.Monsters.CorruptedFleshGolemBasic;
import classes.Scenes.Monsters.CorruptedFleshGolemsBasic;

use namespace CoC;
	
	public class BlightRidge extends BaseContent
	{
		public function BlightRidge() 
		{
		}
		
		public function exploreBlightRidge():void {
			flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE]++;
			if (player.cor < 66) dynStats("cor", 1);
			
			//Discover Defiled Ravine
			if (flags[kFLAGS.DISCOVERED_DEFILED_RAVINE] <= 0 && flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE] > 0 && (player.level + combat.playerLevelAdjustment()) >= 36) {
				player.explored++;
				clearOutput();
				outputText("As you tread through Blight Ridge, you come across a small valley, one you've never noticed before. Where does this place go? How deep does the valley go? Judging by the usual inhabitants of this place, it's not implausible to assume that it would be nothing but more demons up to no good.\n\n");
				outputText("You pause for a moment, debating if you should go into the valley.\n\n");
				menu();
                addButton(1, "Venture forth", findDefiledRavineYes);
                addButton(3, "Fall back", findDefiledRavineNo);
				return;
			}

			var ChanceToFindTheDen:Number = 20;
			if (SceneLib.dungeons.canFindDenOfDesire()) ChanceToFindTheDen -= 9;
			if (flags[kFLAGS.DEN_OF_DESIRE_QUEST] > 0) ChanceToFindTheDen -= 9;
			//Den of Desire
			if (flags[kFLAGS.DEN_OF_DESIRE_BOSSES] < 1 && rand(ChanceToFindTheDen) == 0) {
				clearOutput();
				outputText("You come across a set of old ruins, their grounds littered with statues, with an underground entrance leading deeper inside. ");
				if (flags[kFLAGS.DEN_OF_DESIRE_QUEST] > 0) outputText("This looks to be the lair of the golemancer Rathazul mentioned. ");
				outputText("Do you enter?");
				flags[kFLAGS.DEN_OF_DESIRE_BOSSES] = 1;
				menu();
				addButton(0, "Yes", SceneLib.dungeons.denofdesire.enterDungeon);
				addButton(1, "No", camp.returnToCampUseOneHour);
				return;
			}
			
			//Dart pistol
			if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns1) && player.statusEffectv2(StatusEffects.TelAdreTripxiGuns1) == 0 && player.hasKeyItem("Dart pistol") < 0 && rand(2) == 0) {
				partsofDartPistol();
				return;
			}
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
			
			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			choice[choice.length] = 0; //Imp enemies
			choice[choice.length] = 1; //Succubi (lvl 26)/Incubu (lvl 26)/Omnicubi enemies (lvl 29)
			choice[choice.length] = 2; //Corrupted Basic Flesh Golem (lvl 35)/Corrupted Basic Flesh Golems(lvl 36)
			choice[choice.length] = 3; //Imp Food
			if (rand(4) == 0) choice[choice.length] = 4; //Find nothing! The rand will be removed from this once the Blight Ridge is populated with more encounters.
			
			select = choice[rand(choice.length)];
			switch(select) {
				case 0:
					SceneLib.exploration.genericImpEncounters2();
					break;
				case 1:
					SceneLib.exploration.genericDemonsEncounters1();
					break;
				case 2:
					SceneLib.fleshGolemScenes.introCorruptedBasicFleshGolemS();
					return;
				case 3:
					clearOutput();
					outputText("You spot something on the ground. Taking a closer look, it's one of those imps food packages. ");
					inventory.takeItem(consumables.IMPFOOD, camp.returnToCampUseOneHour);
					break;
				default:
					clearOutput();
					outputText("You spend one hour exploring the tainted ridge but you don't manage to find anything interesting, unless feeling like you are becoming slightly more horny counts.");
					dynStats("lib", .5);
					doNext(camp.returnToCampUseOneHour);
			}
		}
		
		public function findDefiledRavineYes():void {
			outputText("What's the worst that could happen? Treading through the valley, the faint sound of flowing water hits your ears. The sound is quickly followed by the scent of sweat, milk and semen. This is not unlike the usual smells you get in the Blight Ridge, but it's far more condensed and sour here. One step closer to the source.\n\n");
			outputText("<b>You've discovered the Defiled Ravine!</b>");
			flags[kFLAGS.DISCOVERED_DEFILED_RAVINE] = 1;
			doNext(camp.returnToCampUseTwoHours);
		}
		
		public function findDefiledRavineNo():void {
			outputText("Not everything needs to be your problem anyway. Who knows what could happen if you stick your face into somewhere it doesn't belong.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function partsofDartPistol():void {
			clearOutput();
			outputText("As you explore the blight ridge you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Dart pistol in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Dart pistol", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}
	}
}