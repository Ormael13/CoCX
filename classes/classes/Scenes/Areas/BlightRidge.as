/**
 * @author Ormael
 * Demon area with lvl 26-36 demonic enemies. Each exploration will even slowly corrupt PC unless corruption is above 66.
 * Currently a Work in Progress.
 */

package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.BlightRidge.*;
import classes.Scenes.Monsters.ImpLord;
import classes.Scenes.SceneLib;

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
				label : "New Area",
				kind  : 'place',
				unique: true,
				when: SceneLib.defiledravine.canDiscover,
				chance: 30,
				call: discoverDefiledRavine
			}, {
				name: "denofdesire",
				label : "Den of Desire",
				kind  : 'place',
				unique: true,
				when: function ():Boolean {
					return flags[kFLAGS.DEN_OF_DESIRE_BOSSES] < 1
				},
				call: findDenOfDesire,
				chance: 0.1 + (flags[kFLAGS.DEN_OF_DESIRE_QUEST] > 0 ? 0.45:0) + (SceneLib.dungeons.canFindDenOfDesire() ? 0.45 : 0)
			}, {
				name: "gunpart",
				label : "Gun Parts",
				kind  : 'item',
				unique: true,
				when: function ():Boolean {
					return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns1) && player.statusEffectv2(StatusEffects.TelAdreTripxiGuns1) == 0 && player.hasKeyItem("Dart pistol") < 0
				},
				chance: 30,
				call: partsofDartPistol
			}, {
				name: "ignis",
				label : "Ignis",
				kind  : 'npc',
				unique: true,
				night: false,
				when: function ():Boolean {
					return flags[kFLAGS.FACTORY_SHUTDOWN] > 0 && flags[kFLAGS.IGNIS_ARENA_SEER] < 1
				},
				call: ignisIntro
			}, {
				name: "sieg1",
				label : "Sieg",
				kind  : 'npc',
				unique: true,
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
				label : "Sieg",
				kind  : 'npc',
				unique: true,
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
				label : "Sieg",
				kind  : 'npc',
				unique: true,
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
				label : "Imps",
				kind : 'monster',
				call: SceneLib.exploration.genericImpEncounters2
			}, {
				name: "demons",
				label : "Demons",
				kind : 'monster',
				call: SceneLib.exploration.genericDemonsEncounters1
			}, {
				name: "golems",
				label : "Golems",
				kind : 'monster',
				call: SceneLib.fleshGolemScenes.introCorruptedBasicFleshGolemS
			}, {
				name: "impfood",
				label : "Imp Food",
				kind  : 'item',
				call: findImpFood
			}, {
				name: "findnothing",
				call: findNothing,
				label:'Walk',
				kind:'walk'
			}, {
				name: "demonProjects",
				label : "DemLab Subject",
				kind  : 'monster',
				chance: 0.2,
				when: function ():Boolean {
					return SceneLib.exploration.demonLabProjectEncountersEnabled();
				},
				call: SceneLib.exploration.demonLabProjectEncounters
			});
		}
		
		public const areaLevel:int = 21;
		public function isDiscovered():Boolean {
			return SceneLib.exploration.counters.blightRidge > 0;
		}
		public function canDiscover():Boolean {
			return !isDiscovered() && adjustedPlayerLevel() >= areaLevel && SceneLib.swamp.isDiscovered();
		}
		public function timesExplored():int {
			return SceneLib.exploration.counters.blightRidge;
		}
		public function discover():void {
			SceneLib.exploration.counters.blightRidge = 1;
			clearOutput();
			outputText("You wander around the mountain area thinking over this whole ‘demonic’ realm affair.  You're not sure how widespread this entire thing is, everything seems to be isolated to certain areas, you've only really seen the demons in small groups or alone, and even then it's usually comprised of imps.  As far as you know it IS a demonic realm so there should be some area where demons live normally, they can't all be hold up in lethice's stronghold right?  You question whether or not the demons could even hold together a city long enough before 'water' damage ruined the place.");
			if (flags[kFLAGS.BAZAAR_ENTERED] > 0) outputText("  Then again you have been to that Bizarre Bazaar, they seem to exist there to an extent without any trouble...");
			outputText("  As you think the random topic over in your head you spy a path you've never noticed before.\n\n");
			outputText("Being the adventurous champion you are you start down the path, as you walk down this sketchy path, carved through a section of the mountain a ridge comes into view.  Walking onwards until you're at the ridge a somewhat would-be beautiful sight lies before you.\n\n");
			if (player.cor < 66) {
				outputText("That would be if it wasn't corrupted to all hell, the scent of sweat, milk and semen invade your nose as you peer across the corrupted glade.  And you thought that the main forest was bad.");
				if (flags[kFLAGS.MET_MARAE] >= 1) outputText("  Gods... If Marae could see this.");
				outputText("\n\n");
			} else if (player.cor >= 66) {
				outputText("And it is!  Lush fields of corrupted glades consume the land, giving the heavy scent of sweat, milk and semen as you take a deep breath.  Taking it all in and relishing in the corruption.  Truly this is how the world should be.");
				if (flags[kFLAGS.MET_MARAE] >= 1) outputText("  Heh, if Marae could see this she'd flip her shit.");
				outputText("\n\n");
			}
			outputText("<b>You've discovered the Blight Ridge!</b>");
			endEncounter(60);
		}
		
		public function exploreBlightRidge():void {
			explorer.prepareArea(blightRidgeEncounter);
			explorer.setTags("blightRidge");
			explorer.prompt = "You explore the corrupted blight ridge.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				if (player.cor < 66) dynStats("cor", 1);
				SceneLib.exploration.counters.blightRidge++;
			}
			explorer.leave.hint("Leave the corrupted blight ridge");
			explorer.skillBasedReveal(areaLevel, timesExplored());
			explorer.doExplore();
		}
	
		public function blightRidgeChance():Number {
			var temp:Number = 0.5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}

		private function findNothing():void {
			clearOutput();
			outputText("You spend one hour exploring the tainted ridge but you don't manage to find anything interesting, unless feeling like you are becoming slightly more horny counts.");
			dynStats("lib", .5);
			endEncounter();
		}

		private function findImpFood():void {
			clearOutput();
			outputText("You spot something on the ground. Taking a closer look, it's one of those imps food packages. ");
			inventory.takeItem(consumables.IMPFOOD, explorer.done);
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
			addButton(1, "No", explorer.done);
		}

		private function discoverDefiledRavine():void {
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
			SceneLib.exploration.counters.defiledRavine = 1;
			endEncounter(60);
		}
		
		public function findDefiledRavineNo():void {
			outputText("Not everything needs to be your problem anyway. Who knows what could happen if you stick your face into somewhere it doesn't belong.\n\n");
			endEncounter();
		}
		
		public function partsofDartPistol():void {
			clearOutput();
			outputText("As you explore the blight ridge you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Dart pistol in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Dart pistol", 0, 0, 0, 0);
			endEncounter();
		}
	}
}

