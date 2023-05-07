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
import classes.Scenes.API.Encounters;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.BlightRidge.*;
import classes.Scenes.Dungeons.DemonLab;
import classes.Scenes.SceneLib;
import classes.Scenes.Monsters.ImpLord;
import classes.Scenes.Monsters.CorruptedFleshGolemBasic;
import classes.Scenes.Monsters.CorruptedFleshGolemsBasic;

use namespace CoC;
	
	public class BlightRidge extends BaseContent
	{
		public function BlightRidge() {
			onGameInit(init);
		}

		private var _blightRidgeEncounter:GroupEncounter = null;
		public function get blightRidgeEncounter():GroupEncounter {
			return _blightRidgeEncounter;
		}

		private function init():void {
			_blightRidgeEncounter = Encounters.group("blightridge", {
				name: "discoverravine",
				when: function ():Boolean {
					return flags[kFLAGS.DISCOVERED_DEFILED_RAVINE] <= 0 && flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE] > 0 && (player.level + combat.playerLevelAdjustment()) >= 36
				},
				chance: 30,
				call: discoverDefiledRavine
			}, {
				name: "denofdesire",
				when: function ():Boolean {
					return flags[kFLAGS.DEN_OF_DESIRE_BOSSES] < 1
				},
				call: findDenOfDesire,
				chance: 0.1 + (flags[kFLAGS.DEN_OF_DESIRE_QUEST] > 0 ? 0.45:0) + (SceneLib.dungeons.canFindDenOfDesire() ? 0.45 : 0)
			}, {
				name: "gunpart",
				when: function ():Boolean {
					return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns1) && player.statusEffectv2(StatusEffects.TelAdreTripxiGuns1) == 0 && player.hasKeyItem("Dart pistol") < 0
				},
				chance: 30,
				call: partsofDartPistol
			}, {
				name: "ignis",
				night: false,
				when: function ():Boolean {
					return flags[kFLAGS.FACTORY_SHUTDOWN] > 0 && flags[kFLAGS.IGNIS_ARENA_SEER] < 1
				},
				call: ignisIntro
			}, {
				name: "sieg1",
				when: function ():Boolean {
					var v1: Number = flags[kFLAGS.SIEGWEIRD_FOLLOWER];
					var proc1a:Boolean = flags[kFLAGS.SIEGWEIRD_FOLLOWER] < 2;
					var proc1b:Boolean = !(player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3 && !SceneLib.alvinaFollower.AlvinaPurified);
					var v2: Number = player.statusEffectv1(StatusEffects.AlvinaTraining2);
					var proc2a:Boolean = flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 2.5;
					var proc2b:Boolean = (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3 && flags[kFLAGS.SIEGWEIRD_FOLLOWER] >= 3);
					var proc2c:Boolean = (flags[kFLAGS.SIEGWEIRD_FOLLOWER] > 2 && flags[kFLAGS.SIEGWEIRD_FOLLOWER] < 4 && SceneLib.alvinaFollower.AlvinaPurified);
					return flags[kFLAGS.SIEGWEIRD_FOLLOWER] < 2 && !(player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3 && !SceneLib.alvinaFollower.AlvinaPurified)
				},
				chance: blightRidgeChance,
				night: false,
				call: SceneLib.siegweirdFollower.siegweirdFirstEncounter
			}, {
				name: "sieg2",
				when: function ():Boolean {
					return flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 2.5
							|| (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3 && flags[kFLAGS.SIEGWEIRD_FOLLOWER] >= 3)
							|| (flags[kFLAGS.SIEGWEIRD_FOLLOWER] > 2 && flags[kFLAGS.SIEGWEIRD_FOLLOWER] < 4 && SceneLib.alvinaFollower.AlvinaPurified)
				},
				chance: blightRidgeChance,
				night: false,
				call: SceneLib.siegweirdFollower.siegweirdRepeatEncounterPostFight
			}, {
				name: "sieg3",
				when: function ():Boolean {
					return flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 2
				},
				chance: blightRidgeChance,
				night: false,
				call: function ():void {
					player.createStatusEffect(StatusEffects.SiegweirdImp,0,0,0,0);
					startCombat(new ImpLord());
				}
			}, {
				name: "imps",
				call: SceneLib.exploration.genericImpEncounters2
			}, {
				name: "demons",
				call: SceneLib.exploration.genericDemonsEncounters1
			}, {
				name: "golems",
				call: SceneLib.fleshGolemScenes.introCorruptedBasicFleshGolemS
			}, {
				name: "impfood",
				call: findImpFood
			}, {
				name: "findnothing",
				call: findNothing
			}/*, {
				name: "demonProjects",
				chance: 0.2,
				when: function ():Boolean {
					return DemonLab.MainAreaComplete >= 4;
				},
				call: SceneLib.exploration.demonLabProjectEncounters
			}*/);
		}

		public function isDiscovered():Boolean {
			return flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE] > 0;
		}
		public function timesExplored():int {
			return flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE];
		}
		
		public function exploreBlightRidge():void {
			clearOutput();
			flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE]++;
			if (player.cor < 66) dynStats("cor", 1);
			doNext(camp.returnToCampUseOneHour);
			blightRidgeEncounter.execEncounter();
			flushOutputTextToGUI();
		}
	
		public function blightRidgeChance():Number {
			var temp:Number = 0.5;
			if (flags[kFLAGS.SAMIRAH_FOLLOWER] < 10) temp *= player.npcChanceToEncounter();
			return temp;
		}

		private function findNothing():void {
			clearOutput();
			outputText("You spend one hour exploring the tainted ridge but you don't manage to find anything interesting, unless feeling like you are becoming slightly more horny counts.");
			dynStats("lib", .5);
			doNext(camp.returnToCampUseOneHour);
		}

		private function findImpFood():void {
			clearOutput();
			outputText("You spot something on the ground. Taking a closer look, it's one of those imps food packages. ");
			inventory.takeItem(consumables.IMPFOOD, camp.returnToCampUseOneHour);
		}

		private function ignisIntro():void {
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
		}

		private function findDenOfDesire():void {
			clearOutput();
			outputText("You come across a set of old ruins, their grounds littered with statues, with an underground entrance leading deeper inside. ");
			if (flags[kFLAGS.DEN_OF_DESIRE_QUEST] > 0) outputText("This looks to be the lair of the golemancer Rathazul mentioned. ");
			outputText("Do you enter?");
			flags[kFLAGS.DEN_OF_DESIRE_BOSSES] = 1;
			menu();
			addButton(0, "Yes", SceneLib.dungeons.denofdesire.enterDungeon);
			addButton(1, "No", camp.returnToCampUseOneHour);
		}

		private function discoverDefiledRavine():void {
			player.explored++;
			clearOutput();
			outputText("As you tread through Blight Ridge, you come across a small valley, one you've never noticed before. Where does this place go? How deep does the valley go? Judging by the usual inhabitants of this place, it's not implausible to assume that it would be nothing but more demons up to no good.\n\n");
			outputText("You pause for a moment, debating if you should go into the valley.\n\n");
			menu();
			addButton(1, "Venture forth", findDefiledRavineYes);
			addButton(3, "Fall back", findDefiledRavineNo);
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