/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Forest
{
import classes.*;
import classes.BodyParts.Horns;
import classes.BodyParts.Wings;
import classes.Scenes.NPCs.CelessScene;
import classes.display.SpriteDb;

public class NightmareScene extends BaseContent
	{

		public function nightmareIntro():void {
			spriteSelect(SpriteDb.s_celessBlack);
			clearOutput();
			outputText("As you explore the deepwoods, you come upon a particularly corrupted grove. At the center of it you see many demons busy fucking each other, some of them wearing armors and weapons. The demons could’ve been a concern if not for an even bigger threat looming at the epicenter of this scene of utter decadence. At the middle of a grove a centauress is busy fucking what seems to be a dog morph. ");
			if (sceneHunter.other) {
				outputText("\n\nSeems like it's the creature the unicorn told you about...\n\n<b>The events can take a sharp turn if you don't run away right now... do you still want to aproach?</b>\n\n");
				doYesNo(intro2, explorer.done);
			} else intro2();
		}

		public function intro2():void {
			outputText("Her massive horsecock bulges clearly visible in the woman’s stomach and each thrust rocks the adventurer’s body as her features begin to change. The dog woman is begging, but the centauress won’t stop, and you see the telltale sign of orgasm as her eyes roll, filling the woman with a massive amount of cum. The centauress screaming her delight.\n\n");
			outputText("<i>\"Yes this is it… abandon yourself to pleasure, feel it, live for it, Cum for me!\"</i>\n\n");
			outputText("Under your horrified gaze the dog morph’s fur falls apart, her nuzzle transforming into a more human face as her entire body shifts into that of a lascivious succubus. The woman body twitches on the ground, caught between the endless bliss of corruption and orgasm. The centauress pulls her massive horsecock out of her last victim, cum flooding out of the former dog morph pussy mixed with purple fluids, which swiftly crystallize into what is clearly a piece of lethicite!\n\n");
			outputText("She uses her recent cocksleeve body to whip away the excess cum from her horse meat then looks straight in your direction, noticing you and giving you a better look at her features. She has a pair of large bat wings as black as her fur, and her entire body exudes an unearthly grace and beauty that would make even the most beautiful woman jealous, however this creature, as beautiful as she is, clearly represents all that is lewd, corrupted and depraved. Beautiful yet corrupt like a fallen angel her entire body exudes an aura that would defile even the purest soul. If her outlook wasn’t enough the two parallel horn on her forehead clearly tells  everyone looking that she’s up to no good.\n\n");
			outputText("<i>\"Mmmm, I thought I took good care of all the adventurers, but I guess I forgot one. Don’t worry, I will show you the depth of depravity and pleasure just like I did all the others. Just give up all hopes and abandon yourself to your desires, it will be sweet. I assure you.\"</i>\n\n");
			outputText("She giggles then waves her hand seductively, her horsemeat hardening at the prospect of fucking again.\n\n");
			startCombat(new Nightmare());
		}

		public function nightmareDefeat():void {
			clearOutput();
			outputText("The nightmare falls over in incredulity as you stand above her victorious. She looks at you in awe and fear.\n\n");
			outputText("<i>\"You... curse you! This is impossible, nobody should be able to resist the call of corruption! Have mercy! My body is decadent and seductive how can you simply destroy such beauty! Allow me to serve you I can be useful I can...\"</i>\n\n");
			if (silly()) outputText("You step over her with clear intent to finish your work as all the demons turn to watch, and in a single voice, they cry out <b><i>FINISH HER!!!</i></b> Smirking at the vocal support, you declare sternly:");
			else outputText("You step over her with clear intent to finish your work, but not without a little beration.\n\n");
			outputText("Like a beautiful flower, a flora filled with vile poison. You know it's time to rid the forest of this pestilence ridden thing.\n\n");
			if (silly()) {
				outputText("You grab her by a single horn and jerk her head to the side, snapping it instantly. An x-ray allows the audience to see the vertebrae in her neck shatter from the force, and you grab the other horn for leverage. Planting a foot on the Nightmare's chest, you heave upwards with all your might, ");
				outputText("pulling not just her head off, but the entire spine as well. The demons once again speak, screaming out <b><i>FATALITY!!!</i></b> as you walk off with your new trophy.\n\n");
			}
			else outputText("You end her life swiftly and mercilessly, putting a definitive end to her influence in the forest. You can already feel the area breathe easier as the thick fog of corruption surrounding this creature vanishes. The demons pay you no heed as you leave the area holding your opponent two horns as a trophy.\n\n");
			player.createKeyItem("Nightmare Horns", 0, 0, 0, 0);
			player.addStatusValue(StatusEffects.CanMeetNightmare, 1, 1);
			cleanupAfterCombat();
		}

		public function nightmareVictory():void {
			clearOutput();
			if (!recalling) outputText("<b>New scene is unlocked in 'Recall' menu!</b>\n\n");
			if (silly()) {
				outputText("\"<i>That's it now give in..to your desire...</i>\"\n\n");
				outputText("You put on a pair of black shades and reply:\n\n");
				outputText("\"<i>D--D--DJ desiiiire!!!</i>\"\n\n");
				outputText("You start dancing as blue and red lights spin everywhere. A light projection ball on a string falls down from a tree and start spinning as some bumping music plays out of nowhere. A big screen shows the footstep to do the nightmare dance as you all get down to that party! In, out, in, out, in, out, up, up, down, down, left, right, left! You dance and fuck all night but ");
				outputText("sadly for you some scumbag spiked your drink. Just as you fall unconscious you wake up instead realizing all of this was a weird dream to escape your reality, the reality of that massive hardening horsecock in front of you.\n\n");
			}
			outputText("Defeated by your growing desire, you fall to the ground as the nightmare trots to your now prone form.\n\n");
			outputText("\"<i>It's all okay, I will help you become honest with yourself, big girl. By the time you cum out your soul, you will yearn for cock and thirst for cum, especially mine, or perhaps I will restrain myself? Lets see...</i>\"\n\n");
			outputText("With this said she weaves a sign, watching with glee as your clothes fly away from you to go pile up on the side.\n\n");
			outputText("\"<i>You won’t need these for what is to come next.</i>\"\n\n");
			sceneHunter.print("Fork: can TF / perm-TFed / gargoyle (special)");
			if (!player.blockingBodyTransformations()) {
				if (!player.hasVagina()) {
					outputText("You can’t help but weakly try and shove her away, but the nightmare proves too strong. She kicks you on all fours and aligns her unholy cock with your [asshole]. You try to crawl away, but she responds by jamming her entire length into your hole.\n\n");
					outputText("\"<i>Here we go for a ride! Ohhh yeaaaa!</i>\"\n\n");
					outputText("She neighs in pleasure as she violates your ass, thoroughly molding your hole after the shape of her cock. You scream at first from the stretching of your passage, her cock bulging in your belly, but pain slowly turns to pleasure as various things change about you.\n\n");
					outputText("Without knowing it, your ass shape begin to change, molding itself into a perfect heart to further accommodate the centauress desire.");
					if (player.biggestTitSize() < 7) {
						outputText("Your breasts follow suit, inflating up to an E cup and if you weren't forced down on all fours, you would be groping them yourself to savor their shape.");
						if (!recalling) {
							if (player.bRows() == 0) {
								player.createBreastRow(7);
								transformations.UnlockBreasts();
							}
							else player.breastRows[player.biggestTitRow()].breastRating = 7;
						}
					}
					outputText("If your voice was any less than womanly before, it's no longer the case as your moans turn increasingly feminine. Each thrust of the nightmare messes you up a little more and as you are about to finally reach anal orgasm, the flesh of your crotch");
					if (player.hasBalls()) outputText(" at the base of your balls");
					outputText(" begins to change revealing a pair of drooling lips that can only be your newly formed cunt englobing your male genitalia");
					outputText(". This final change is too much, and you cum at once from");
					if (player.hasCock()) outputText(" your [cock] and");
					outputText(" newly formed vagina, drenching the grass with your fluids.");
					if (player.hasCock()) {
						outputText(" The more you cum the more your cock");
						if (player.hasBalls()) outputText(" and balls");
						outputText(" shrink and before you know it you're left with a perfectly feminine set of assets, whatever is left of your cock vanishes entirely between your pussy lips with a final spurt of cum. Guess the nightmare was indeed calling you a girl on purpose before because now you fully look like one. You feel the nightmare slide her member out of your bitchy asshole and realign her monster for her true goal.");
					}
					outputText("\n\n\"<i>Here I go, girl, better be ready now! Because we going for the part two!</i>\"\n\n");
					if (!recalling) {
						if (player.hasCock()) player.killCocks(-1);
						if (player.hasBalls()) {
							player.balls = 0;
							player.ballSize = 0;
						}
						player.createVagina();
						player.clitLength = .25;
					}
				}
				sceneHunter.print("Fork: Taur lower body");
				if (player.isTaur()) {
					outputText("The nightmare licks her lip in anticipation as she examines your prone form.\n\n");
					outputText("\"<i>Mmmm it has been so long since last I had a mare. Tell me girl... do you yearn for me? Do you desire my tool?</i>\"\n\n");
					outputText("The more she speaks the more you realise she’s right.");
					if (player.statusEffectv2(StatusEffects.Kelt) > 0) outputText(" You have felt this attraction before while around Kelt, however her aura is infinitely stronger than that of the misogynic macho centaur.");
					outputText(" Her cock is spreading for you a scent that hypnotises and lures you like a moth to a flame.");
					if (!player.inHeat) outputText(" The more you focus on her, the more your mind clouds as your vagina begins to abundantly drool. You realize her presence alone was enough to send you into deep heat.");
					outputText(" There is no denial to your instincts anymore. Every fiber of your body desire this stallion, breaking any form of resistance you had, and so you submissively fawn to her desperate for her attentions. She nods at your attitude and gently pulls your head up by the chin so your gazes can meet.\n\n");
					outputText("\"<i>Don’t worry... I will treat you like the top breed mare you are and mark you as my own.</i>\"\n\n");
					outputText("She moves in position behind you and gets to work climbing on your back. You weiny in pleasure as her cock seamlessly slides in your [pussy] filling you in just the perfect way. Gosh, why have you been fighting against this? This cock, its like it was made for you to begin with! Its perfect flare and just about right size fills you like a key fits its specific keyhole.");
					outputText(" You fully sink into your breeding instincts and do your darndest best to respond to your lovers trust, milking her horsecock with your thirsty cunt.\n\n");
					outputText("\"<i>Wow, girl, you're taking charge now, are you? At this rate I won’t be able to hold any much longer.</i>\"\n\n");
					outputText("You moan in delight as the fiend corruption spreads from her cock to you, staining your body and soul as black as her own.");

					if (player.isFurCovered() && !InCollection(player.furColor, "black", "midnight black", "midnight")) {
						if (!recalling) player.furColor = randomChoice("black", "midnight black", "midnight");
						outputText(" Your pelt color swiftly change color to [fur color] as every single trust pushes you forward down into your breeding frenzy.");
					}
					if (player.horns.type != Horns.BICORN) {
						outputText(" Just as you are about to achieve orgasm a pair of small parallel nub begins forming on your forehead.");
						if (!recalling) CoC.instance.transformations.HornsBicorn.applyEffect(false);
					}
					outputText("\n\nThe nightmare herself seems to lose control as the two of you keep fucking like wild animals.\n\n");
					outputText("\"<i>Ahhhhh cummingggg!!!!</i>\"\n\n");
					outputText("You feel the bulge at the base of her cock travel all the way through her length before it explode right into your [pussy]. This is going to knock you up for sure.");
					if (player.horns.type != Horns.BICORN && player.horns.type != Horns.UNICORN) {
						outputText(" Reaching your own orgasm you scream in delight as the two nubs finally grow into a pair of sensible spiraling horns.");
						if (!recalling) CoC.instance.transformations.HornsBicorn.applyEffect(false);
					}
					if (player.horns.type != Horns.BICORN && player.horns.type == Horns.UNICORN) {
						outputText(" Reaching your own orgasm you scream in delight as your horn slit into a pair of sensible spiraling bicorn horns.");
						if (!recalling) CoC.instance.transformations.HornsBicorn.applyEffect(false);
					}
					outputText(" The pleasure of your transformation is so great your grab your twin horns with both hands and fiercely rub them like a pair of penis. Gosh, you see white, the pleasure too great for you to handle as you cum again, and again your pussy exploding around the horsecock still flooding your hole.");
					outputText(" The nightmare gently slide out of your cunt, leaving you with a feeling of emptiness as she guides you to the ground, where you lay down to catch your breath.\n\n");
					outputText("\"<i>Best mare I had in years. I’m definitely going to miss that one. That said, take care of our child, I won’t be there for her myself.</i>\"\n\n");
				} else {
					if (!recalling) {
						switch (rand(10)) {
							case 0:
								player.skinColor = "shiny black";
								break;
							case 1:
							case 2:
								player.skinColor = "indigo";
								break;
							case 3:
							case 4:
							case 5:
								player.skinColor = "purple";
								break;
							default:
								player.skinColor = "blue";
						}
					}
					outputText("\n\nYou try to meekly crawl away, but the centauress is too fast for you. She has you easily pinned to the ground by her hoof as she lowers herself on your prone body aligning her meat with your hole. You try to scream for help, but she cuts the air out with a swift blow now squeezing you between her horse body and the grass. You can only beg her as you feel her flare prod for the entrance of your cunt, smearing pre on your slit, she's clearly going to break you. ");
					outputText("You ready a scream as her cock forces your lips apart but to your complete surprise her massive monster seamlessly slide in without further resistance. She begins to buck in and out, filling you way past the cervix and, to your dismay, you actually realise you’re enjoying this.\n\n");
					outputText("\"<i>My horn can penetrate anything, from the tightest pussy to the loosest hole. Leave it to me, and I will turn you into a mess of pleasure.</i>\"\n\n");
					outputText("Your mind indeed reels as corruption floods your body with each thrust. Your cunt pulses in tandem with the nightmare’s ramming as your body gives in to her. You moan in pleasure as your spine extends into a long sinuous tail, ending with a heart shaped tip. Your lust-addled mind finds no better use for it other than wrapping the appendage around the nightmare's cock in an attempt to assist her thrusts. ");
					outputText("This is no longer rape you’re enjoying it too much. You arch your back to scream in pleasure as");
					if (player.wings.type == Wings.NONE) outputText(" a");
					outputText(" pair of demonic wings unfold from your back");
					if (player.wings.type > Wings.NONE) outputText(" replacing your old ones");
					outputText(". This is all too much pleasure for your mind to handle, you’re slowly turning into a demon, and you don’t even care. Your partner however is at her limit.\n\n");
					outputText("\"<i>Here it comes, girl... take it all!</i>\"\n\n");
					outputText("The nightmare’s cock begins to pulse violently as both of you finally reach climax, her horsecock flooding your womb to the brim with hot, tainted cum. Your body’s reaction is swift, your head growing a pair of large demonic horns and your skin pigmentation slowly shifting to a " + player.skinColor + " hue ");
					outputText("as you reach the end of your transformation but strangely, despite how defiled you are, your soul does not seem to be coming out. The nightmare pulls out of your body leaving you stranded on the ground trying to regain your composure.\n\n");
					outputText("\"<i>You are a lucky girl... I feel generous and since you're such a cutie I actually stopped only short of making you cum out your soul. Demons can only give births to imps anyway, and I need a strong body like yours to carry my offspring into the world. Do take care of her will you?</i>\"\n\n");
					if (!recalling) {
						CoC.instance.transformations.WingsDemonicLarge.applyEffect(false);
						CoC.instance.transformations.HornsDemonic.applyEffect(false);
					}
				}
				outputText("You nod weakly with a confused lust-addled expression. Yea, whatever she says... You don’t care, you're in nirvana, trying to reconnect with your body right now, and so your vision fades to black.\n\n");
				outputText("You wake up alone in the clearing. Seems everyone has left while you were sleeping. You feel horribly aroused by your newfound corruption and all the more by the powerful black magic your body is permeated with. Somehow the centauress permanently desecrated your body with her energy, and you can feel this \"blessing\" resonating with your newfound corruption.\n\n");
				if (!recalling) {
					if (player.butt.type < 6) player.butt.type = 6;
					if (player.hips.type < 6) player.hips.type = 6;
					if (player.hairLength < 10) player.hairLength += 10;
					if (player.thickness < 70) player.thickness = 70;
					if (player.tone > 30) player.tone = 30;
					player.fertility += 10;
					CelessScene.instance.nightmareDefeated();
					return;
				}
			}
			else if (player.blockingBodyTransformations() && player.hasVagina()){
				if (player.isGargoyle())
					outputText("The centauress trots around you then humph in frustration." +
					"\n\n\"<i>Doesn't matter if you have a cunt, with a body like that there's no way I could properly impregnate you!</i>\"\n\n" +
					"Can't impregnate a stone slab eh? though luck." +
					"\n\nAs if reading your thought the centaur ram a hoof into your stomach brutaly pinning you on the ground. \"<i>You think your womb is the only thing that matter here? I said I can't impregnate you, I never said I couldn't FUCK you silly, and fuck you silly I will!</i>\"\n\n");
				else
					outputText("The centauress trots around you then shrugs." +
					"\n\n\"<i>Immune to transformation are you? Doesn't matter to me, your body won't change from it but any contact with my cum will make you just right. Just because you can't be changed doesn't mean you can't be properly corrupted, and I need a corrupted vessel for bearing my offsprings. About that... you got a pussy already wich is very conveniant seeing as I wouldn't be able to grow you a new one if you didn't.</i>\"\n\n");
				outputText(" You try to meekly crawl away, but the centauress is too fast for you. She has you easily pinned to the ground by her hoof as she lowers herself on your prone body aligning her meat with your hole. You try to scream for help, but she cuts the air out with a swift blow now squeezing you between her horse body and the grass. You can only beg her as you feel her flare prod for the entrance of your cunt, smearing pre on your slit, she's clearly going to break you. ");
				outputText("You ready a scream as her cock forces your lips apart but to your complete surprise her massive monster seamlessly slide in without further resistance. She begins to buck in and out filling you way past the cervix and, to your dismay, you actually realise you’re enjoying this.\n\n");
				outputText("\"<i>My horn can penetrate anything, from the tightest pussy to the loosest hole. Leave it to me, and I will turn you into a mess of pleasure.</i>\"\n\n");
				outputText("Your mind indeed reels as corruption floods your body with each thrust. Your cunt pulses in tandem with the nightmare’s ramming as your body gives in to her. Your lust addled mind finds no better use for it other than wrapping the appendage around the nightmare's cock in an attempt to assist her thrusts. ");
				outputText("This is no longer rape you’re enjoying it too much. You arch your back to scream in pleasure as the centaur violate your stone cunt with all her might");
				outputText(". This is all too much pleasure for your mind to handle. Your partner however is mercifully at her limit.\n\n");
				outputText("\"<i>Here it comes girl... take it all!</i>\"\n\n");
				outputText("The nightmare’s cock begins to pulse violently as both of you finally reach climax, her horsecock flooding your stone womb to the brim with hot, tainted cum.");
				outputText("The nightmare pulls out of your body leaving you stranded on the ground trying to regain your composure.\n\n");
				if (player.isGargoyle())
					outputText("\"<i>Tsk if only you weren't a god-damned statue. Demons can only give births to imps anyway, and I need a strong body like yours to carry my offspring into the world. Shame that you ruined it before I could get to it!</i>\"\n\n");
				else
					outputText("\"<i>You are a lucky girl you know? Not many would have the chance to bear the offspring and while I can't fuck your damn soul out I can definitively fuck you pregnant. Demons can only give births to imps anyway, and I need a strong body like yours to carry my offspring into the world. Do take care of her will you?</i>\"\n\n");
				outputText("You nod weakly with a confused lust addled expression. Yea, whatever she says... You don’t care, you're in nirvana, trying to reconnect with your body right now, and so your vision fades to black.\n\n");
				if (player.isGargoyle()) {
					outputText("You wake up your alone in the clearing. Seems everyone left while you were sleeping. Guess you will have to try again.");
					if (!recalling) {
						explorer.stopExploring();
						doNext(camp.returnToCampUseFourHours);
					}
				}
				else {
					outputText("You wake up your alone in the clearing. Seems everyone left while you were sleeping. You feel horribly aroused by your defiled body and all the more by the powerful black magic you are permeated with. Somehow the centauress permanently desecrated your body with her energy, and you can feel this \"blessing\" resonating with your newfound corruption.\n\n");
					if (!recalling) {
						CelessScene.instance.nightmareDefeated();
						player.sexReward("cum", "Vaginal");
						return;
					}
				}
			}
			else {
				outputText("The centauress trots around you then humph in frustration." +
						"\n\n\"<i>Tsk just what the flying hell is that I can't fuck or corrupt this body its litteraly immune to transformations! In order to breed I need a pussy... and you have NO PUSSY!</i>\"\n\n" +
						"You chuckle to yourself, you knew locking your form to that of a standard male would save you someday." +
						"\n\nAs if reading your impertinent mind the centauress kicks you in the face out of frustration sending you to the safety of uncounciousness. Welp guess you gunna have to hunt down that fiend again now." +
						"\n\nYou wake up later with a headache and traces of fluid down your ass and mouth, while the taur didn't bother to use you the demons she created sure did. With a taste of salt to the mouth, and a need for vengeance you head back to camp ready to hunt down back that equine fiend!");
				if (!recalling) {
					player.sexReward("cum", "Oral");
					player.sexReward("cum", "Anal");
					explorer.stopExploring();
					doNext(camp.returnToCampUseFourHours);
					return;
				}
			}
			//should be reached ONLY with recall
			if (!recalling) throw new Error("Bruh, SH messed up the returns. Report this pls.");
			doNext(recallWakeUp);
		}
	}
}
