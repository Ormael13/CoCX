//Quest Dungeon: Den of Desire (Gargoyle TF Quest)
package classes.Scenes.Dungeons
{
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Dungeons.DenOfDesire.*;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

//import classes.Scenes.NPCs.;
public class DenOfDesire extends DungeonAbstractContent
	{
		public function DenOfDesire() { }
		
		public function enterDungeon():void {
			inDungeon = true;
			dungeonLoc = DUNGEON_DEN_OF_DESIRE_ENTRANCE;
			playerMenu();
		}
		public function exitDungeon():void {
			inDungeon = false;
			clearOutput();
			outputText("You leave the den behind and take off through the ridge back towards camp.");
			endEncounter();
		}
		
		public function defeatedByObsidianGargoyle():void {
			clearOutput();
			spriteSelect(SpriteDb.s_obsidian_gargoyle);
			outputText("This abomination proves too much for you, and you fall unconscious. As you come to, you feel weirdly horny... horrifyingly so even. You look around yourself, and can only see crystalline walls. You try to punch them, but they won't open, stronger than any other substance you have encountered so far. Next to you are dozens of people locked in a perpetual orgy. One in particular stands out, she seems to be a herm. She walks to you with a sad expression.");
			outputText(" \"<i>Sorry, it seems I made yet another victim. It's ok though, you'll get to experience pleasure from the feelings of this body, while you’re here. Albeit you'll likely go mad from it before long, as they all have before you.</i>\" She laughs hysterically then jumps back right into the fray.\n\n");
			outputText("You scream in horror as you finally realize what's happening. The gargoyle didn't just rape you, she literally devoured your soul, and now you're stuck for eternity to be a part of the many victims powering this foul creature’s twisted core!\n\n");
			//[GAME OVER]
			EventParser.gameOver();
		}
		public function defeatedObsidianGargoyle():void {
			clearOutput();
			spriteSelect(SpriteDb.s_obsidian_gargoyle);
			outputText("Screaming in agony, the abominations body begins to fissure everywhere as she looks at you with a tearful expression of release and say a final \"thank you\". Her body breaks down, crumbling on the ground into a pile of stone rubble. What looks to be a good hundred or more different ghostly forms escape from the stony remains, moving upward to whatever place they are going, although you notice a few remain stuck in a gem like stone.\n\n");
			outputText("<b>(Key Item Acquired: Black Soul Gem!)</b>");
			player.createKeyItem("Black Soul Gem", 0, 0, 0, 0);
			flags[kFLAGS.DEN_OF_DESIRE_BOSSES] = 2;
			cleanupAfterCombat();
		}
		public function defeatedByHeroslayerOmnibus():void {
			clearOutput();
			outputText("The omnibus chuckles as you fall to the ground, utterly defeated. \"<i>You have a lot of potential, you know. A shame it's wasted in this body. Don’t worry, however, for I happen to have the perfect solution to this problem of yours. Since you came to me willingly and even went to the trouble of gathering the ingredients, I'm gonna remake you into the perfect fucktoy. A fucktoy who obeys only me, of course.</i>\"\n\n");
			outputText("She laughs manically as she unveils what looks like an incomplete obsidian gargoyle. Looking even lewder than the aberration you fought in the hall, not that you thought it's possible, its mace-like tail is shaped like a penis, and considering the 18-inch tool, ever slick vagina, and massive breasts, it is likely equipped for all situations.\n\n");
			outputText("\"<i>All it needed is a soul. Your soul that is.</i>\" She approaches you, grinning widely holding what looks to be a soul gem, black as midnight, in her left hand.\n\n");
			doNext(defeatedByHeroslayerOmnibusPage2);
		}
		public function defeatedByHeroslayerOmnibusPage2():void {
			clearOutput();
			outputText("<b>3 hour later</b>\n\n");
			outputText("If the ritual wasn’t a traumatising enough experience in itself, your awakening is even worse. Just as soon as you regain consciousness and see your ‘master’, your body automatically sits on its own. You begin to have a sensation of déjà vu...  this is exactly what happened when you awoke " + flags[kFLAGS.GAR_NAME] + " for the first time. Your mouth opens of its own accord, asking for what your ‘master’ wants of you.\n\n");
			outputText("\"<i>Start by masturbating in front of me like the whore you are.</i>\"\n\n");
			outputText("To your horror, you comply rolling over to stroke your penis and finger your oozing vagina. This is likely what " + flags[kFLAGS.GAR_NAME] + " meant when she said that she didn't have free will, except unlike her, you can actually feel the pleasure and start moaning at your own forced ministrations! Just as you're about to climax, however, you can't seem to reach a peak, your arousal and sensitivity only ramping up endlessly, constantly edging yourself.  Your master laugh at your inability to orgasm.\n\n");
			outputText("\"<i>One rule pet, there are only two ways you can cum. Either I order you to cum, or you rape someone. Also the sensation won't stop unless you cum, which means no matter if you're masturbating all day or not, your desire to fuck will always only increase. Soon you will be offering your body to me of your own free will. I've finally created the ultimate sex slave. I’m gonna get the science prize for this!</i>\"\n\n");
			doNext(defeatedByHeroslayerOmnibusPage3);
		}
		public function defeatedByHeroslayerOmnibusPage3():void {
			clearOutput();
			if (player.isAlraune())
			{
				SceneLib.uniqueSexScene.AlrauneDungeonBadEnd();
			}
			else {
				outputText("<b>Several years later</b>\n\n");
				outputText("Master is so good with you, allowing you to rape intruders is the best! You've been masturbating for several day on your pedestal just to make this one orgasm perfect, and just as this woman fell down to the devastating power of your assault, you felt the magic restraint on your orgasm shatter, just as you mounted both her ass and her pussy with your duo of penises penetrating her and filling her body with the oozing corruption coming out of your many Lethicite cores. ");
				outputText("Each woman or man you fuck becomes a new demon and each soul you steal fuels you with more power and desire. It is just so good and right to serve.\n\n");
				outputText("You've long forgotten everything about your past life. You are ‘master’s’ fuck toy and pet now, and your only duty and joy is as ‘master's’ tool, to thoroughly rape anyone who dares to enter these ruins.\n\n");
				//[GAME OVER]
				EventParser.gameOver();
			}
		}
		public function defeatedHeroslayerOmnibus():void {
			clearOutput();
			outputText("You stand triumphant before the omnibus and do the only thing suitable for such a foul being as her. A few seconds later, she finally lays dead at your feet, no longer a menace, and you have access to her somewhat large library of research. Her knowledge of golems is quite vast, maybe even horrifyingly so due to what she intended to use it for. This woman must have known about them when she was still human or at least must have taken a strong interest in them as a demon. ");
			if (player.hasKeyItem("Soul Gem Research") >= 0 && flags[kFLAGS.GARGOYLE_QUEST] > 0)
				outputText("Regardless of the reason, she had exactly whatever missing information you needed to finish the ritual. ");
			else
				outputText("You pick up her research, not wanting it to fall into the wrong hands, plus it may come in handy in the future.\n\n");
			outputText("<b>(Key Item Acquired: Gargoyle demonic researches!)</b>");
			player.createKeyItem("Gargoyle demonic researches", 0, 0, 0, 0);
			flags[kFLAGS.DEN_OF_DESIRE_BOSSES] = 3;
			cleanupAfterCombat();
		}
		
		//Rooms
		public function roomEntrance():void {
			dungeonLoc = DUNGEON_DEN_OF_DESIRE_ENTRANCE;
			clearOutput();
			outputText("<b><u>Entrance</u></b>\n");
			outputText("You stand in what looks like the entrance to some very old ruins, yet for some reason it's uncharacteristically tidy and clean. Likely something lives here, and not something friendly either.");
			dungeons.setDungeonButtons(roomGreatHallArea, null, null, null);
			addButton(11, "Leave", exitDungeon);
		}
		public function roomGreatHallArea():void {
			dungeonLoc = DUNGEON_DEN_OF_DESIRE_GREAT_HALL_AREA;
			clearOutput();
			outputText("<b><u>Great Hall</u></b>\n");
			if(flags[kFLAGS.DEN_OF_DESIRE_BOSSES] < 2) {
				spriteSelect(SpriteDb.s_obsidian_gargoyle);
				outputText("\n\nAs you set foot into a great hall, lined with obsidian statues depicting demons in various act of utter debauchery, one of the statues starts moving, turning its head toward you, as it slides off of the literally rock hard cock of the other statue on the pedestal representing a minor incubus.");
				outputText("\n\n\"<i>An intruder? Here? Please do me! Let me fuck your soul out! I've been starved for years, and I'm pent-up for a release. Master won't ever let me have release. I must.... FEED!</i>\"");
				outputText("\n\nThe lust crazed gargoyle, because it clearly is a gargoyle, is made out of carved obsidian and you can see the souls of dozens of people screaming for help within this abomination's sparkling body. She starts walking toward you, fingering herself all the while with a dreamy expression.");
				startCombat(new ObsidianGargoyle(), true);
				flags[kFLAGS.DEN_OF_DESIRE_BOSSES] = 2;
				doNext(playerMenu);
				return;
			}
			outputText("You stand in a great hall. Many statues line the walls here, giving the somewhat ominous feeling of being watched. The remains of the obsidian gargoyle still litter the floor.");
			dungeons.setDungeonButtons(roomLaboratory, roomEntrance, null, null);
		}
		public function roomLaboratory():void {
			dungeonLoc = DUNGEON_DEN_OF_DESIRE_LABORATORY;
			clearOutput();
			outputText("<b><u>Laboratory</u></b>\n");
			outputText("This room seems to have served as a laboratory used to perform magical experiments on not so willing test subjects. Many lifeless corpses are stockpiled in a container, likely the bodies of failed experiments.");
			dungeons.setDungeonButtons(roomHeroSlayerOmnibusRoom, roomGreatHallArea, null, null);
		}
		public function roomHeroSlayerOmnibusRoom():void {
			dungeonLoc = DUNGEON_DEN_OF_DESIRE_HERO_SLAYER_OMNIBUS;
			clearOutput();
			outputText("<b><u>Hero slayer omnibus room</u></b>\n");
			if(flags[kFLAGS.DEN_OF_DESIRE_BOSSES] < 3) {
				outputText("\n\nYou enter what looks like a wizard's laboratory. There are various statues, still uncarved lining the walls along with a veiled one in the back of the room. A demon seems to be working with what looks to be soulstones, Lethicite shards and books. As she notices that she is no longer alone, she turns around to face you. She isn't really the right term, she clearly is an omnibus as a very manly tool sits comfortably between her legs.");
				outputText("\n\nThe omnibus simply gives you an amused smirk. \"<i>It seems you've defeated my pet. I guess I should've expected as much from a failed experiment. No matter. This is only a setback and I'm about done... yes, you will do perfectly. Since that foolish mage I defeated at that ruined cathedral to obtain the rituals I needed, I couldn't find a suitable subject.</i>\"");
				outputText("\n\nShe unwinds a long blazing whip from her belt and smirks as she walks toward you.");
				startCombat(new HeroslayerOmnibus(), true);
				flags[kFLAGS.DEN_OF_DESIRE_BOSSES] = 3;
				doNext(playerMenu);
				return;
			}
			outputText("This is where the Omnibus was practicing her horrifying research to create demonic gargoyles. Her blood is still warm on the floor; there is nothing left to do here.");
			dungeons.setDungeonButtons(null, roomLaboratory, null, null);
		}
	}
}
