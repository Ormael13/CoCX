/**
 * Created by aimozg on 03.01.14.
 */
package classes.Scenes.Dungeons.HelDungeon
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;

	public class BrigidScene extends BaseContent
	{
		public function BrigidScene()
		{
		}


		//Brigid the Jailer -- PC Victorious
		public function pcDefeatsBrigid():void {
			clearOutput();
			outputText("The harpy jailer collapses, ");
			if (monster.lust >= monster.eMaxLust()) outputText("too turned on");
			else outputText("too badly beaten");
			outputText(" to continue the fight.  You quickly snatch the keys from inside her shield, and hook them onto your own belt.");
			//(New Key Item: Harpy Key A)
			player.createKeyItem("Harpy Key A",0,0,0,0);
			combat.cleanupAfterCombat();
			flags[kFLAGS.HEL_BRIGID_DEFEATED] = 1;
		}

		//Brigid the Jailer -- PC Defeated
		public function pcDefeatedByBrigid():void {
			clearOutput();
			if (flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED] == 0) {
				outputText("\"<i>Tsk tsk tsk,</i>\" the harpy jailer croons, looming over you as you slump to the ground. \"<i>You shouldn't have messed with me, bitch!</i>\" she snaps, giving you a rough kick to the side. \"<i>Now, let's see what Mother has to say about this...</i>\"");
				//(Go to \"<i>Harpy Breeding Slut</i>\" Bad End)
				doNext(getGame().dungeons.heltower.harpyQueenBeatsUpPCBadEnd);
			}
			else {
				outputText("\"<i>That's it?!</i>\" Brigid screams, as you collapse in front of her.  \"<i>A weak little piece of trash like you took out our queen?</i>\"");

				outputText("\n\n\"<i>[name]!</i>\" calls a voice from behind you.  Hel bounds down the stairs, summoned by the sound of the fight; when she spies your defeated form, she draws her sword and throws herself at the harpy jailer, completely clearing the ground in her rage.  The scene that plays out next passes through your dazed mind agonizingly, like a nightmare.");
				outputText("\n\nAs Hel launches herself over your body, weapon raised over her head, Brigid turns and raises a taloned foot.  It catches the salamander right in the stomach, bending her double, and the scimitar flies out of her hands to skitter across the stone floor.  You can see the light leave Hel's eyes as she coughs violently, and a small fan of blood and flame is ejected from her mouth.  The man on the table winces as Brigid lowers your partner to the ground.");
				outputText("\n\n\"<i>Completely PATHETIC!</i>\" rants the dyke jailer.  \"<i>Neither of you is anything more than garbage!</i>\"  She turns to her torture rack, holding it steady with one foot as she searches for and discards items from it.");

				outputText("\n\n\"<i>Where the fu- AHA!</i>\" she cries in triumph, tossing a dangerous-looking knife aside and claiming something from behind it.  Turning again, Brigid advances on you and Hel with a smouldering smile, carrying two small vials of thick, white liquid.  \"<i>Garbage you may be, but even garbage can be recycled.</i>\"");

				outputText("\n\nAn alarm blares in your mind and you reach out sluggishly to try and grab her slim ankle, but she kicks you in the head and your vision goes mazy.  The last thing you make out before slipping into unconsciousness is the harpy standing over Hel, pinning her fiery tail under a shield held down with one claw as she forces the contents of a vial down the salamander's gullet...");

				doNext(brigitPostQueenDeathBadEndII);
			}
		}

		//--Next--
		private function brigitPostQueenDeathBadEndII():void {
			clearOutput();
			//[(if M, U, or visibly pregnant F/H)
			if (player.gender <= 1 || player.pregnancyIncubation > 0) {
				outputText("A soft, ticklish feeling against your [chest] is the first thing to bring you back to reality.  Your eyes open slowly, revealing a confusing blur of orange.  \"<i>[name],</i>\" murmurs a familiar voice from the unfocused smear, \"<i>you're all right... thank god.</i>\"  As your head clears, the picture slowly resolves into the tear-streaked face of Kiri, the little harpy from before; she smiles as you recognize her, and wraps her arms around your neck.  You try to hold her back, but find you cannot move your hands - looking at them, you notice your wrists secured to the table you're lying on with metal clasps!");
				outputText("\n\n\"<i>S-sorry,</i>\" Kiri whispers, \"<i>Brigid won, remember...</i>\"  The results of the last fight return to you in a flash, explaining your current predicament.  Testing your whole body, you find all your limbs similarly bound to the stone table.");

				outputText("\n\n\"<i>The others?</i>\" you ask, blearily.");

				outputText("\n\nThe harpy girl atop you frowns unhappily, and darts her eyes to the left.  Turning your head to follow her glance, you see the captured salamander from before and, mounted atop his swollen prick, Hel!  Her face is covered by an iron mask, but the tits are the same familiar, jiggling orbs and you can't imagine there are any other female salamanders here... or rather, formerly female.  You revise your guess hurriedly as the captive grunts and thrusts into her, forcing her hips up and allowing the small cock now growing from her crotch to bob freely!  A drop of pre-cum glides down it, and Hel shivers; the skin on her new dick looks chafed and raw, flushed red where it's not spotted with orange scales.");

				outputText("\n\n\"<i>She's been first pick of the remaining women,</i>\" Kiri mumbles, gesturing toward several satisfied harpy and phoenix matrons dozing along the walls.  \"<i>They've spend equal time fighting over and fucking her, poor sis-</i>\"");

				outputText("\n\nA sharp crack sounds and Kiri's eyes widen as her chest jerks forward; Brigid stands behind her, holding a leather crop.  \"<i>You're here to fuck, not talk!</i>\" the torturer screams, shaking the whip at you.  \"<i>I don't care if it's salamanders, phoenixes, or just half-breed harpies, but you are going to help make me a new army to replace the one you wiped out!</i>\"  Kiri grimaces at the brutal woman, but begins shifting her hips against you, sending a wave of pleasure to the base of your spine.");

				//[(if F or U)
				if (!player.hasCock()) {
					outputText("\n\nYour eyes widen in shock at the sensation, and Kiri flinches at your expression.  \"<i>What,</i>\" Brigid asks, glowering at you, \"<i>did you think we'd let you go after what you did, just because we couldn't breed you?");
					if (player.pregnancyIncubation > 0) outputText("  Once this disgusting thing you're carrying falls out of you, we'll use you more traditionally, but...</i>\"  She pauses to press uncomfortably on your pregnant belly, then resumes speaking.  \"<i>I have no intention of letting you sit idle for however long that takes.");
					outputText("  For now, I've given you the most obvious modification - I can think of something else later.</i>\"");
					outputText("\n\nShe squeezes Kiri's ass firmly with one hand, and lifts the girl partway out of your lap.  A smooth, hot sensation separates from your crotch and glides along nerves you hadn't noticed until now as Kiri's pussy slides upward, partially revealing the erect, " + player.skinTone + " flesh of a brand new cock!  Brigid gloats at your confusion, laughing her delight to the roof of the chamber, then shoves Kiri's ass downward again, spearing her pussy on your new flesh and making the girl wince and grit her teeth.");
					player.createCock();
				}
				outputText("\n\nThe jailer slaps the small half-breed on the butt, sending a pleasing tremor through your cock, then withdraws to a stool in the corner.  \"<i>Fuck... or I'll make you fuck,</i>\" she declares ominously, casting her riding crop aside and beckoning another harpy over.  She picks up a worn journal as the other woman sits on her leg, then begins turning the pages with a thumb as she plays with the harpy's pussy.  \"<i>Watch them for me, sweet,</i>\" Brigid says, kissing the woman on the neck.  \"<i>Make sure they do their jobs while I'm studying mom's notes.</i>\"  Her lover shivers and nods nervously, fixing her eyes on you.");

				outputText("\n\nKiri strokes your prick with her body vigorously, pushing you toward your limit and keeping up appearances even as she whispers to you.  \"<i>Please, [name]... just endure it for now.  I'll think of a way to get you out of here, I promise.</i>\"  She shifts her hips downward, engulfing your shaft again, and rolls her head passionately as her cheeks flush.  \"<i>I-it may be a while, though,</i>\" she says, kissing your chest.  \"<i>I - ah! I'm not very much by myself, so... the only thing I can do is make lots of loyal, strong daughters with your seed... s-someday there'll be enough to make a break for it!  J-just hold on and... and... fertilize me!  </i>Fertilize me<i>, [name]!</i>\"");

				outputText("\n\nThe harpy's eyes roll back in her head as she moans and sinks down one last time in orgasm, sucking at your cock with her vagina; your throbbing prick obeys, ejaculating a load of semen into the open-mouthed bird-girl.  \"<i>Ohh god,</i>\" Kiri gasps, \"<i>YES!  Cover my eggs in your sticky cum!  Fill me up!</i>\"");
				if (player.cockTotal() > 1 || player.cumQ() > 1000) outputText("  " + player.SMultiCockDesc() + " holds forth for a while, until Kiri's ass, pussy, and tailfeathers are soaked with oozing, white cum.");
				outputText("  Next to you, the salamander on the other table climaxes as well, dumping a load into Hel that sizzles when it leaks onto his fiery, iron-bound tail.  Your former lover squirms and shivers as the scalding-hot load fills her cunt, and her own prick twitches weakly, depositing a small string of bubbling jism on the stone table.");

				outputText("\n\n\"<i>Oh dad... Hel... I'm sorry,</i>\" Kiri whimpers, unable to pull her eyes away from them as your cock dribbles the last of your seed into her.  The bound man's single eye widens as he hears the name of his partner, and his face deforms with rage as a roar pours out of him with enough volume to shake the room.  Kiri buries her face in your [chest] and shudders as the prisoner bellows his frustration; Hel simply looks left and right, confused and anxious as the echoing roar dies off; Brigid pushes her toy pussy away and rises from her stool.");

				outputText("\n\n\"<i>Not bad, old man,</i>\" the jailer quips.  \"<i>I didn't think you had that much life left in you.  Maybe I'll keep you with this woman for a while!</i>\"  The salamander's eye hardens, but he says nothing; Brigid looks from him to you and Kiri, but you both assume expressions of studied incomprehension.  \"<i>... Whatever.  You bitches get up; you've had your turns and I've got a lot more cunts to pack full.</i>\"  She begins pulling Hel's chains free of the iron ring at the end of the table.");

				outputText("\n\nKiri frowns unhappily as she slips your cock from her pussy, then kisses you.  \"<i>Remember, [name]... just hold on!  And... save some of your seed for me!</i>\"  She lingers for a while, looking in your eyes affectionately, but Brigid grabs her by the hair and, swearing filthily, pulls her away.  A sadistic-looking phoenix takes her place, straddling you and slipping your sore prick into her cunt... the last thing you manage to do before your head is filled with the agony and ecstasy of having your raw shaft ridden again right after orgasm is to wonder exactly how long salamander-harpy half-breeds gestate...");
				//[GAME THE FUCK OVER, SON; WHERE IS MY MONEY?]
				getGame().gameOver();
				if (flags[kFLAGS.HARDCORE_MODE] <= 0) addButton(1, "Retry", getGame().dungeons.heltower.retryDungeonFromBadEndPrompt);
			}
			//(else if not visibly pregnant F or H)
			else {
				//hymen check]
				player.cuntChange(15,false,false,false);
				outputText("The heat in your [vagina] is the first thing to stir you.  Your eyes open painfully, fluttering with each soft pulse of your head; it feels like an imp was set loose inside, covering your brain with thick jizz, but eventually you manage to focus and look down.  What greets you is the sight of ");
				if (player.hasCock()) outputText(player.sMultiCockDesc() + " bobbing up and down, drooling pre-cum, as ");
				outputText("your red, sore pussy is pounded viciously by a thick cock dotted with scales.  Below it dangles a pair of swollen balls, bouncing as the shaft is thrust into you; with an inkling of understanding, you look back to confirm your suspicion.  Sure enough, you're mounted atop the table-bound salamander from before, who grunts as he pushes into you.  The hot cock, hotter than your body, slides in with a sizzle, and some of your juices roll down the shaft, only to evaporate when they hit the salamander's flaming, iron-bound tail.  Your own limbs are chained to the table via a massive iron ring and Brigid stands in front of you, watching you expectantly; behind her are arranged a score of assorted harpies and surviving phoenixes in various stages of coitus.");

				outputText("\n\nIt takes you a while to realize that the gasps you're hearing aren't all coming from you and the rabble; you turn your head to the table next to you, upon which is strapped Hel.  The woman is restrained much the same way as your salamander, except her legs are spread wide open, displaying her pussy for all to see, and an additional iron mask completely covers her face.  Atop Hel sits Kiri, the little orange-feathered harpy from before, grinding her feathery pelvis into Hel's.  \"<i>S-sorry dad; [name],</i>\" Kiri says, wincing as she notices your stare.  \"<i>Just... try to... t-to hold on!</i>\"  She reclines and pulls away from Hel, and for the first time you can see what she's grinding on; a small, orange-scaled dick is jutting fron Hel's crotch!  Kiri moans as she stirs her pussy with it, throwing her hips upward to reveal that she, too, sports a brand-new, oozing penis.");

				outputText("\n\n\"<i>Talk less, fuck more!</i>\" howls Brigid, striking Kiri across the shoulders.  \"<i>Our queen is gone, and the burden falls on </i>us<i> to repopulate our ranks!  Be glad I consider you worthy enough to use your seed, little half-breed!  Whether it's salamanders, phoenixes, or weak fodder like you, you </i>WILL<i> reproduce!</i>\"");

				outputText("\n\nAs Brigid turns away, Kiri scowls and leans forward again, pressing her modest breasts against her lover's and whispering something to the masked Hel, who nods and begins thrusting vigorously.  The sight returns your attention to the cock in your own [vagina], and your head rolls back as the salamander under you fucks faster, drawing closer to orgasm.  His thick, rough prick scrapes your walls angrily, the little lubrication you can generate overtaxed as it tries to cope with his sweltering body heat and the blistering pace of the sex.");

				outputText("\n\nA muffled cry comes from the table beside you, as Hel achieves climax and buries her new dick as deeply into Kiri as she can.  As her body convulses, you can see her pussy squeezing out strings of white seed to drool between her legs - likely Kiri's, as the little harpy blushes when she notices the oozing mess over her shoulder.  The room is filled with the smell of semen as the goo hits Hel's tail and begins to bubble, and Kiri lets out a cry as well, falling backward onto her outstretched hands as her hips shake; a little squirt of cum lances from her cock, to land on Hel's tits.  \"<i>F-fuck yeah, fertilize me!  Paint my eggs with your sperm!</i>\" Kiri shouts in ecstasy, proving that she's still a harpy after all.");

				outputText("\n\nThe dick in you twitches and a flood of painful warmth in your own womb tenses your body; you slide partway off of the shaft in agony, and you can see the man's wrists straining against his bonds, trying to break free so he can pull you back down.  He roars in frustration as you expose more than half of his cock to the air trying to get away from the intensely hot seed, but there's not enough slack in your bonds, and he finishes inside you, leaving your [face] tear-stained and pinched.  Brigid takes your chin in her hands.");

				outputText("\n\n\"<i>Aww, didn't come yet?  Too bad.  There's only one use for a trash " + player.race() + " like you, anyway,</i>\" your jailer coos sweetly, caressing your " + player.skin() + ".  \"<i>You're going to make me more salamanders, so... better luck next time!</i>\"  She unfastens your chains from the loop on the table, violently dragging you clear and covering your [butt] in the scalding seed pouring out of you.  \"<i>I don't care what you bitches do with this one,</i>\" Brigid says, yanking you toward the ongoing harpy orgy, \"<i>just don't ruin her.  That breeding stock on the table won't last much longer once we start to make up for the soldiers we lost, and we might be able to get a replacement out of her womb.  And don't fucking bother me, I need to go over mom's notes and figure out how she was making the phoenixes!</i>\"");

				outputText("\n\nWith a shove from the pink-haired jailer, you're tumbled into a pair of lovers; the phoenix stops groping the harpy's tits to wrap her arm around you and pull you to the floor, and no sooner are you laid down than the harpy's stretched, semen-stuffed pussy is atop your mouth, grinding into your face and drooling warm phoenix seed down your throat");
				if (player.hasCock()) outputText(" as the phoenix's cunt slides onto your [cock smallest]");
				outputText(".  Brigid makes her way up the stairs, leaving you and the others at the mercy of the assorted horde.  The harpy rides your mouth greedily, knocking your head into the hard stone floor, and the last thing you can see around her feathery thighs before you slip into unconsciousness again is Kiri being pulled roughly from her resting place atop Hel by a mean-looking, wide-hipped harpy matron who takes her place, sitting sideways and drawing her talons sadistically across Hel's vulnerable chest to smear Kiri's seed around...");
				//[GAME OVER, MOTHERFUCKER]
				getGame().gameOver();
				if (flags[kFLAGS.HARDCORE_MODE] <= 0) addButton(1, "Retry", getGame().dungeons.heltower.retryDungeonFromBadEndPrompt);
			}
		}

	}
}
