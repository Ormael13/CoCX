/**
 * Created by aimozg on 26.03.2017.
 */
package classes.Scenes {
import classes.Appearance;
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.PerkLib;
import classes.Scenes.API.Encounter;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.Monsters.Goblin;
import classes.Scenes.Monsters.Imp;

public class CommonEncounters extends BaseContent implements Encounter {

	// This could be moved to ImpScene class
	private var _impEncounter:Encounter = null;
	public function get impEncounter():Encounter {
		const fn:FnHelpers = Encounters.fn;
		return _impEncounter ||= Encounters.build({
			chance: impEncounterBaseChance,
			mods  : [lethiteMod],
			call  : Encounters.complex(1, "imps", {
				name  : "twoimpsclash",
				chance: fn.lineByLevel(1, 20, 0.1, 0.01), // x0.1 at level 1, x0.01 at level 20+
				call  : twoImpsClashing
			}, {
				name  : "imp",
				chance: fn.lineByLevel(1, 20, 1.0, 0.5), // x1 at level 1, x0.5 at level 20+
				call  : impCombatEncounter
			}, {
				name  : "implord",
				call  : kGAMECLASS.impScene.impLordEncounter,
				when  : fn.ifLevelMin(8),
				chance: fn.lineByLevel(8, 16, 0.5, 2.0) // x0.5 at level 8, x2 at level 16+
			}, {
				name  : "impwarlord",
				call  : kGAMECLASS.impScene.impWarlordEncounter,
				when  : fn.ifLevelMin(12),
				chance: fn.lineByLevel(12, 20, 0.5, 3.0) // x0.5 at level 12, x3 at level 20+
			}, {
				name  : "impoverlord",
				call  : kGAMECLASS.impScene.impOverlordEncounter,
				when  : fn.ifLevelMin(16),
				chance: fn.lineByLevel(16, 20, 0.5, 4.0) // x0.5 at level 16, x4 at level 20+
			})
		});
	}


	private var _goblinEncounter:Encounter = null;
	public function get goblinEncounter():Encounter {
		const fn:FnHelpers = Encounters.fn;
		return _goblinEncounter ||= Encounters.build({
			chance: 0.5,
			call  : Encounters.complex(1, "goblins", {
				name  : "goblin",
				chance: fn.lineByLevel(1, 20, 1.0, 0.5), // x1 at level 1, x0.5 at level 20+
				call  : goblinCombatEncounter
			}, {
				name  : "gobass",
				call  : kGAMECLASS.goblinAssassinScene.goblinAssassinEncounter,
				when  : fn.ifLevelMin(10),
				chance: fn.lineByLevel(10, 14, 0.5, 2.0) // x0.5 at level 10, x2 at level 16+
			}, {
				name  : "gobwar",
				call  : kGAMECLASS.goblinWarriorScene.goblinWarriorEncounter,
				when  : fn.ifLevelMin(12),
				chance: fn.lineByLevel(12, 18, 0.5, 3.0) // x0.5 at level 12, x3 at level 18+
			}, {
				name  : "gobsha",
				call  : kGAMECLASS.goblinShamanScene.goblinShamanEncounter,
				when  : fn.ifLevelMin(12),
				chance: fn.lineByLevel(12, 18, 0.5, 3.0) // x0.5 at level 12, x3 at level 18+
			}, {
				name  : "gobeld",
				call  : kGAMECLASS.goblinElderScene.goblinElderEncounter,
				when  : fn.ifLevelMin(16),
				chance: fn.lineByLevel(16, 20, 0.5, 4.0) // x0.5 at level 16, x4 at level 20+
			})
		})
	}

	public function encounterChance():Number {
		return theCommonEncounters.encounterChance();
	}

	public function execEncounter():void {
		theCommonEncounters.execEncounter();
	}

	public function encounterName():String {
		return "common";
	}

	/**
	 * Imp, Goblin, Helia sex ambush
	 */
	public function get withImpGob():Encounter {
		return _withImpGob ||= Encounters.group("common",
				impEncounter,
				goblinEncounter,
				theCommonEncounters);
	}

	private var _withImpGob:Encounter = null;
	/* Alternative version:
	 public const withImpGob2:Encounter = new LateinitEncounter(this,function():Encounter{
	 return Encounters.group("common",impEncounter,
	 goblinEncounter,
	 theCommonEncounters);
	 });*/

	/**
	 * Helia sex ambush
	 */
	public function get theCommonEncounters():Encounter {
		return _tce ||= Encounters.group("common",
				kGAMECLASS.helScene.helSexualAmbushEncounter);
	}

	private var _tce:Encounter = null;

	public function furriteMod():Number {
		return furriteFnGen()();
	}

	public function lethiteMod():Number {
		return lethiteFnGen()();
	}

	public function furriteFnGen(iftrue:Number = 3, iffalse:Number = 1):Function {
		return function ():Number {
			return player.findPerk(PerkLib.PiercedFurrite) >= 0 ? iftrue : iffalse;
		}
	}

	public function lethiteFnGen(iftrue:Number = 3, iffalse:Number = 1):Function {
		return function ():Number {
			return player.findPerk(PerkLib.PiercedLethite) >= 0 ? iftrue : iffalse;
		}
	}

	public function impEncounterBaseChance():Number {
		var impch:Number = 5;
		if (player.totalCocks() > 0) impch--;
		if (player.hasVagina()) impch++;
		if (player.totalFertility() >= 30) impch++;
		if (player.cumQ() >= 200) impch--;
		return impch / 10;
	}

	private function unlockCodexImps():void {
//Unlock if haven't already.
		if (flags[kFLAGS.CODEX_ENTRY_IMPS] <= 0) {
			flags[kFLAGS.CODEX_ENTRY_IMPS] = 1;
			outputText("\n\n<b>New codex entry unlocked: Imps!</b>");
		}
	}

	private function twoImpsClashing():void {
		//Two imps clashing, UTG stuff.
		clearOutput();
		outputText("A small imp bursts from behind a rock and buzzes towards you. You prepare for a fight, but it stays high and simply flies above you. Suddenly another imp appears from nowhere and attacks the first. In the tussle one of them drops an item, which you handily catch, as the scrapping demons fight their way out of sight. ");
		unlockCodexImps();
		inventory.takeItem(randomChoice(consumables.SUCMILK, consumables.INCUBID,
				consumables.IMPFOOD), camp.returnToCampUseOneHour);
	}

	private function impCombatEncounter():void {
		outputText("An imp wings out of the sky and attacks!", true);
		unlockCodexImps();
		doNext(playerMenu);
		startCombat(new Imp());
		spriteSelect(29);
	}

	public function goblinCombatEncounter():void {
		// counters.mGoblin.encountered++; <- call this on non-combat encounters
		if (player.gender > 0) {
			outputText("A goblin saunters out of the bushes with a dangerous glint in her eyes.\n\nShe says, \"<i>Time to get fucked, " + player.mf("stud", "slut") + ".</i>\"", true);
		} else {
			outputText("A goblin saunters out of the bushes with a dangerous glint in her eyes.\n\nShe says, \"<i>Time to get fuc-oh shit, you don't even have anything to play with!  This is for wasting my time!</i>\"", true);
		}
		if (flags[kFLAGS.CODEX_ENTRY_GOBLINS] <= 0) {
			flags[kFLAGS.CODEX_ENTRY_GOBLINS] = 1;
			outputText("\n\n<b>New codex entry unlocked: Goblins!</b>");
		}
		startCombat(new Goblin());
		spriteSelect(24);
	}


	public function bigJunkChance():Number {
		return (player.longestCockLength() >= player.tallness
				&& player.totalCockThickness() >= 12)
				? 1 + (player.longestCockLength() - player.tallness) / 24
				: 0;
	}

	// TODO merge
	//[RANDOM SCENE IF CHARACTER HAS AT LEAST ONE COCK LARGER THAN THEIR HEIGHT, AND THE TOTAL COMBINED WIDTH OF ALL THEIR COCKS IS TWELVE INCHES OR GREATER]
	public function bigJunkForestScene(lake:Boolean = false):void {
		clearOutput();
		var x:Number = player.longestCock();

		//PARAGRAPH 1
		outputText("Walking along the ", false);
		if (lake) outputText("grassy and muddy shores of the lake", false);
		else outputText("various paths of the forest", false);
		outputText(", you find yourself increasingly impeded by the bulk of your " + player.cockDescript(x) + " dragging along the ", false);
		if (lake) outputText("wet ground behind you.", false);
		else outputText("earth behind you.", false);
		if (player.cocks.length == 1) {
			if (lake) outputText("  As it drags through the lakeside mud, the sensation forces you to imagine the velvety folds of a monstrous pussy sliding along the head of your " + Appearance.cockNoun(player.cocks[x].cockType) + ", gently attempting to suck it off.", false);
			else outputText("  As it drags across the grass, twigs, and exposed tree roots, the sensation forces you to imagine the fingers of a giant hand sliding along the head of your " + Appearance.cockNoun(player.cocks[x].cockType) + ", gently jerking it off.", false);
		}
		else if (player.cocks.length >= 2) {
			if (lake) outputText("  With all of your " + player.multiCockDescriptLight() + " dragging through the mud, they begin feeling as if the lips of " + num2Text(player.cockTotal()) + " different cunts were slobbering over each one.", false);
			else outputText("  With all of your " + player.multiCockDescriptLight() + " dragging across the grass, twigs, and exposed tree roots, they begin feeling as if the rough fingers of " + num2Text(player.cockTotal()) + " different monstrous hands were sliding over each shaft, gently jerking them off.", false);
		}
		outputText("\n\n", false);

		//PARAGRAPH 2
		//FOR NON-CENTAURS]
		if (!player.isTaur()) {
			outputText("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your " + player.multiCockDescriptLight() + ", which forces your torso to the ground.  Normally your erection would merely raise itself skyward, but your genitals have grown too large and heavy for your " + player.hipDescript() + " to hold them aloft.  Instead, you feel your body forcibly pivoting at the hips until your torso is compelled to rest face down atop your " + player.multiCockDescriptLight() + ".", false);
			//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
			if (player.biggestTitSize() >= 35) {
				if (lake) outputText("  Your " + player.chestDesc() + " hang lewdly off your torso to rest in the lakeside mud, covering much of the ground to either side of you.  Their immense weight anchors your body, further preventing your torso from lifting itself up.  Mud cakes against their undersides and coats your " + player.nippleDescript(0) + "s.", false);
				else outputText("  Your " + player.chestDesc() + " hang lewdly off your torso to rest on the twings and dirt, covering up much of the ground to either side of you.  Their immense weight anchors your body, further preventing your torso from lifting itself up.  The rough texture of the bark on various tree roots teases your " + player.nippleDescript(0) + "s mercilessly.", false);
			}
			//IF CHARACTER HAS A BALLS ADD SENTENCE
			if (player.balls > 0) {
				outputText("  Your " + player.skinTone + " " + player.sackDescript() + " rests beneath your raised " + player.buttDescript() + ".  Your " + player.ballsDescriptLight() + " pulse with the need to release their sperm through your " + player.multiCockDescriptLight() + " and ", false);
				if (lake) outputText("into the waters of the nearby lake.", false);
				else outputText("onto the fertile soil of the forest.", false);
			}
			//IF CHARACTER HAS A VAGINA ADD SENTENCE
			if (player.vaginas.length >= 1) {
				outputText("  Your " + player.vaginaDescript() + " and " + player.clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + player.buttDescript() + " above.", false);
				//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
				if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) {
					outputText("  Juices stream from your womanhood and begin pooling on the dirt and twigs beneath you.  ", false);
					if (lake) outputText("The drooling fem-spunk only makes the ground more muddy.", false);
					else outputText("The sticky fem-spunk immediately soaks down into the rich soil.", false);
				}
			}
		}
		//FOR CENTAURS
		else if (player.isTaur()) {
			outputText("  The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your " + player.multiCockDescriptLight() + ", which forces the barrel of your bestial torso to the ground.  Normally your erection would merely hover above the ground in between your legs, but your genitals have grown too large and heavy for your " + player.hipDescript() + " to hold them aloft.  Instead, you feel your body being forcibly pulled down at your hind legs until your bestial body is resting on top of your " + player.multiCockDescriptLight() + ".", false);
			//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
			if (player.biggestTitSize() >= 35) {
				if (lake) outputText("  Your " + player.chestDesc() + " pull your human torso forward until it also is forced to face the ground, obscured as it is in boob-flesh.  Your tits rest on the wet earth to either side of you.  Their immense weight anchors you, further preventing any part of your equine body from lifting itself up.  Mud cakes their undersides and coats your " + player.nippleDescript(0) + "s.", false);
				else outputText("  Your " + player.chestDesc() + " pull your human torso forward until it also is forced to face the ground, obscured as it is in boob-flesh.  Your tits rest on the dirt and twigs to either side of you.  Their immense weight anchors you, further preventing any part of your equine body from lifting itself up.  The rough texture of the bark on various tree roots teases your " + player.nippleDescript(0) + "s mercilessly.", false);
			}
			//IF CHARACTER HAS A BALLS ADD SENTENCE
			if (player.balls > 0) {
				outputText("  Your " + player.skinTone + player.sackDescript() + " rests beneath your raised " + player.buttDescript() + ".  Your " + player.ballsDescriptLight() + " pulse with the need to release their sperm through your " + player.multiCockDescriptLight() + " and ", false);
				if (lake) outputText("into the waters of the nearby lake.", false);
				else outputText("onto the fertile soil of the forest floor.", false);
			}
			//IF CHARACTER HAS A VAGINA ADD SENTENCE
			if (player.vaginas.length >= 1) {
				outputText("  Your " + player.vaginaDescript() + " and " + player.clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + player.buttDescript() + " above.", false);
				//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
				if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) {
					if (lake) outputText("  A leaf falls from a tree and lands on the wet lips of your cunt, its light touch teasing your sensitive skin.  Like a mare or cow in heat, your juices stream from your womanhood and pool in the mud beneath you.  The sloppy fem-spunk only makes the ground more muddy.", false);
					else outputText("  A leaf falls from a tree and lands on the wet lips of your cunt, its light touch teasing your sensitive skin.  Like a mare or cow in heat, your juices stream from your womanhood and pool in the dirt and twigs beneath you.", false);
				}
			}
		}
		outputText("\n\n", false);
		//PARAGRAPH 3
		outputText("You realize you are effectively trapped here by your own body.", false);
		//CORRUPTION BASED CHARACTER'S VIEW OF SITUATION
		if (player.cor < 33) outputText("  Panic slips into your heart as you realize that if any dangerous predator were to find you in this state, you'd be completely defenseless.  You must find a way to regain your mobility immediately!", false);
		else if (player.cor < 66) outputText("  You realize that if any dangerous predator were to find you in this state, you'd be completely defenseless!  You must find a way to regain your mobility... yet there is a certain appeal to imagining how pleasurable it would be for a sexual predator to take advantage of your obscene body.", false);
		else outputText("  Your endowments have rendered you completely helpless should any predators find you.  Somewhere in your heart, you find this prospect almost exhilarating.  The idea of being a helpless fucktoy for a wandering beast is unusually inviting to you.  Were it not for the thought that you might starve to death, you'd be incredibly tempted to remain right where you are.", false);


		if (lake) {
			//SCENE END = IF CHARACTER HAS FULL WINGS ADD SENTENCE
			if (player.canFly()) outputText("  You extend your wings and flap as hard as you can until at last, you manage to lighten the bulk of your body.  It helps just enough to let you drag your genitals out of the mud and back to camp.  The ordeal takes nearly an hour for you to return and deal with.", false);
			//Taurs
			else if (player.isTaur()) outputText("  You struggle and work your multiple legs against the wet ground.  Your " + player.feet() + " have consistent trouble finding footing as the mud fails to provide enough leverage to lift your bulk.  You breath in deeply and lean side to side, trying to find some easier vertical leverage beneath your feet.  Eventually, with a crude crawl, your legs manages to push the bulk of your body onto more solid ground.  With great difficulty, you spend the next hour shuffling your genitals back to camp.", false);
			//SCENE END = FOR ALL OTHER CHARACTERS
			else outputText("  You struggle and push with your " + player.legs() + " as hard as you can, but it's no use.  You do the only thing you can and begin stroking your " + player.multiCockDescriptLight() + " with as much vigor as you can muster.  Eventually, your body tenses and a light load of jizz erupts from your body, but the orgasm is truly mild compared to what you need.  You're far too weary from struggling to give yourself the masturbation you truly need, but you continue to try.  Nearly an hour later, " + player.sMultiCockDesc() + " has softened enough to allow you to stand again, and you make your way back to camp, still dragging your genitals through the mud.", false);
		}
		else {
			//SCENE END = IF CHARACTER HAS FULL WINGS ADD SENTENCE
			if (player.canFly()) outputText("  You extend your wings and flap as hard as you can, until at last, you manage to lighten the bulk of your body.  It helps just enough to let you drag your genitals out of the forest and back to camp.  The ordeal takes nearly an hour for you to return and deal with.", false);
			//SCENE END IF CHARACTER HAS CENTAUR BODY
			else if (player.isTaur()) outputText("  You struggle and work your multiple legs against the soft dirt.  Your " + player.feet() + " have consistent trouble finding footing as the ground fails to provide enough leverage to lift your bulk.  You breath in deeply and lean side to side, until eventually, your feet brace against the various roots of the trees around you.  With a crude crawl, your legs manage to shuffle your body and genitals out of the forest and back to camp.", false);
			//SCENE END = FOR ALL OTHER CHARACTERS
			else outputText("  You struggle and push with your " + player.legs() + " as hard as you can, but it's no use.  You do the only thing you can and begin stroking your " + player.multiCockDescriptLight() + " with as much vigor as you can muster.  Eventually, your body tenses and a light load of jizz erupts from your loins, but the orgasm is truly mild compared to what you need.  You're far too weary from struggling to give yourself the masturbation you truly need, but you continue to try.  Nearly an hour later, " + player.sMultiCockDesc() + " has softened enough to allow you to stand again, and you make your way back to camp, still dragging your genitals across the forest floor.", false);
		}
		dynStats("lus", 25 + rand(player.cor / 5), "resisted", false);
		player.changeFatigue(5);
		doNext(camp.returnToCampUseOneHour);
	}

	//Massive bodyparts scene
	//[DESERT]
	//[RANDOM SCENE IF CHARACTER HAS AT LEAST ONE COCK LARGER THAN THEIR HEIGHT,
	//AND THE TOTAL COMBINED WIDTH OF ALL THEIR COCKS IS TWELVE INCHES OR GREATER]
	public function bigJunkDesertScene():void {
		clearOutput();
		var x:Number = player.longestCock();
		//PARAGRAPH 1
		outputText("Walking along the sandy dunes of the desert you find yourself increasingly impeded by the bulk of your " + player.cockDescript(x) + " dragging along the sandscape behind you.  The incredibly hot surface of the desert causes your loins to sweat heavily and fills them with relentless heat.", false);

		if (player.cocks.length == 1) outputText("  As it drags along the dunes, the sensation forces you to imagine the rough textured tongue of a monstrous animal sliding along the head of your " + Appearance.cockNoun(player.cocks[x].cockType) + ".", false);
		else if (player.cocks.length >= 2) outputText("  With all of your " + player.multiCockDescriptLight() + " dragging through the sands they begin feeling as if the rough textured tongues of " + num2Text(player.cockTotal()) + " different monstrous animals were slobbering over each one.", false);
		outputText("\n\n", false);

		//PARAGRAPH 2

		//FOR NON-CENTAURS]
		if (!player.isTaur()) {
			outputText("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your " + player.multiCockDescriptLight() + ", which forces your torso to the ground.  Normally your erection would merely raise itself skyward but your genitals have grown too large and heavy for your " + player.hipDescript() + " to hold them aloft.  Instead you feel your body forcibly pivoting at the hips until your torso is compelled to rest face down on top of your obscene " + player.multiCockDescriptLight() + ".", false);

			//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
			if (player.biggestTitSize() >= 35) outputText("  Your " + player.allBreastsDescript() + " hang lewdly off your torso to rest on the desert sands, seeming to bury the dunes on either side of you.  Their immense weight anchors your body, further preventing your torso from lifting itself up.  The burning heat of the desert teases your " + player.nippleDescript(0) + "s mercilessly as they grind in the sand.", false);
			//IF CHARACTER HAS A BALLS ADD SENTENCE
			if (player.balls > 0) outputText("  Your " + player.skinTone + player.sackDescript() + " rests beneath your raised " + player.buttDescript() + ".  The fiery warmth of the desert caresses it, causing your " + player.ballsDescriptLight() + " to pulse with the need to release their sperm through your " + player.multiCockDescriptLight() + ".", false);
			//IF CHARACTER HAS A VAGINA ADD SENTENCE
			if (player.vaginas.length >= 1) {
				outputText("  Your " + player.vaginaDescript() + " and " + player.clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + player.buttDescript() + " above.", false);
				//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
				if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) outputText("  Juices stream from your womanhood and begin pooling on the hot sand beneath you.  Wisps of steam rise up into the air only to tease your genitals further.  ", false);
			}
		}
		//FOR CENTAURS
		else {
			outputText("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your " + player.multiCockDescriptLight() + ", which forces the barrel of your horse-like torso to the ground.  Normally your erection would merely hover above the ground in between your centaurian legs, but your genitals have grown too large and heavy for your " + player.hipDescript() + " to hold them aloft.  Instead, you feel your body being forcibly pulled down at your hindquarters until you rest atop your " + player.multiCockDescriptLight() + ".", false);
			//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
			if (player.biggestTitSize() >= 35) outputText("  Your " + player.allBreastsDescript() + " pull your human torso forward until it also is forced to rest facedown, just like your horse half.  Your tits rest, pinned on the desert sand to either side of you.  Their immense weight anchors you, further preventing any part of your equine body from lifting itself up.  The burning heat of the desert teases your " + player.nippleDescript(0) + "s incessantly.", false);
			//IF CHARACTER HAS A BALLS ADD SENTENCE
			if (player.balls > 0) outputText("  Your " + player.skinTone + player.sackDescript() + " rests beneath your raised " + player.buttDescript() + ".  The airy warmth of the desert teases it, causing your " + player.ballsDescriptLight() + " pulse with the need to release their sperm through your " + player.multiCockDescriptLight() + ".", false);
			//IF CHARACTER HAS A VAGINA ADD SENTENCE
			if (player.vaginas.length >= 1) {
				outputText("  Your " + player.vaginaDescript() + " and " + player.clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + player.buttDescript() + " above.", false);
				//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
				if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) outputText("  The desert sun beats down on your body, its fiery heat inflaming the senses of your vaginal lips.  Juices stream from your womanhood and begin pooling on the hot sand beneath you.", false);
			}
		}
		outputText("\n\n", false);
		//PARAGRAPH 3
		outputText("You realize you are effectively trapped here by your own body.", false);
		//CORRUPTION BASED CHARACTER'S VIEW OF SITUATION
		if (player.cor < 33) outputText("  Panic slips into your heart as you realize that if any dangerous predator were to find you in this state, you'd be completely defenseless.  You must find a way to regain your mobility immediately!", false);
		else if (player.cor < 66) outputText("  You realize that if any dangerous predator were to find you in this state you'd be completely defenseless.  You must find a way to regain your mobility... yet there is a certain appeal to imagining how pleasurable it would be for a sexual predator to take advantage of your obscene body.", false);
		else outputText("  Your endowments have rendered you completely helpless should any predators find you.  Somewhere in your heart, you're exhilarated at the prospect.  The idea of being a helpless fucktoy for a wandering beast is unusually inviting to you.  Were it not for the thought that you might die of thirst in the desert, you'd be incredibly tempted to remain right where you are.", false);

		//SCENE END = IF CHARACTER HAS FULL WINGS ADD SENTENCE
		if (player.canFly()) outputText("  You extend your wings and flap as hard as you can, until at last you manage to lighten the bulk of your body somewhat - enough to allow yourself to drag your genitals across the hot sands and back to camp.  The ordeal takes nearly an hour.", false);
		//SCENE END IF CHARACTER HAS CENTAUR BODY
		else if (player.isTaur()) outputText("  You struggle and work your equine legs against the surface of the dune you are trapped on.  Your " + player.feet() + " have consistent trouble finding footing, the soft sand failing to provide enough leverage to lift your bulk.  You breath in deeply and lean from side to side, trying to find some easier vertical leverage.  Eventually, with a crude crawl, your legs manage to push the bulk of your body onto more solid ground.  With great difficulty, you spend the next hour shuffling your genitals across the sandscape and back to camp.", false);
		//SCENE END = FOR ALL OTHER CHARACTERS
		else outputText("  You struggle and push with your " + player.legs() + " as hard as you can, but it's no use.  You do the only thing you can and begin stroking your " + player.multiCockDescriptLight() + " with as much vigor as you can muster.  Eventually your body tenses and a light load of jizz erupts from your body, but the orgasm is truly mild compared to what you need.  You're simply too weary from struggling to give yourself the masturbation you truly need, but you continue to try.  Nearly an hour later " + player.sMultiCockDesc() + " softens enough to allow you to stand again, and you make your way back to camp, still dragging your genitals across the warm sand.", false);
		dynStats("lus", 25 + rand(player.cor / 5), "resisted", false);
		player.changeFatigue(5);
		doNext(camp.returnToCampUseOneHour);
	}

	public function CommonEncounters() {
	}
}
}
