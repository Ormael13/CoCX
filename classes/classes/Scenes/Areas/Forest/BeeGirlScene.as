/**
 * Created by aimozg on 03.01.14.
 */
package classes.Scenes.Areas.Forest
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class BeeGirlScene extends BaseContent
	{
		private static const BEE_GIRL_CONVERSATION:int				= 0x7FFF0000; //Used to track conversations when the player is a female bee morph (Highest bit is for the bad end warning)
		private static const BEE_GIRL_ATTITUDE:int					= 0x0000FFFF;
		private static const BEE_GIRL_TALKED:int					=          1; //Replaces the old bee progress flag
		private static const BEE_GIRL_TALKED_AND_LEFT:int			=          2; //Refusing to take her eggs leads to conversation
		private static const BEE_GIRL_TALKED_AND_LEFT_TWICE:int		=          3;
		private static const BEE_GIRL_PLAYER_AFRAID:int				=          4;
		private static const BEE_GIRL_PLAYER_VOLUNTARY_EGGING:int	=          5; //End of the afraid chain, from now on player gets egged when they meet her
		private static const BEE_GIRL_PLAYER_DISGUSTED:int			=          6;
		private static const BEE_GIRL_PLAYER_DUTY:int				=          7;
		
		public function BeeGirlScene() {}
		
		public function setTalked():void { flags[kFLAGS.BEE_GIRL_STATUS] = BEE_GIRL_TALKED; }
		
		private function get attitude():int { return flags[kFLAGS.BEE_GIRL_STATUS] & BEE_GIRL_ATTITUDE; }
		
		private function set attitude(value:int):void { flags[kFLAGS.BEE_GIRL_STATUS] = (flags[kFLAGS.BEE_GIRL_STATUS] & BEE_GIRL_CONVERSATION) + value; }
		
		private function get badEndWarning():Boolean { return (flags[kFLAGS.BEE_GIRL_STATUS] & 0x80000000) != 0; }
		
		private function set badEndWarning(value:Boolean):void {
			flags[kFLAGS.BEE_GIRL_STATUS] = (flags[kFLAGS.BEE_GIRL_STATUS] & (BEE_GIRL_ATTITUDE | BEE_GIRL_CONVERSATION)) + (value ? 0x80000000: 0);
		}
		
		private function get conversation():int { return (flags[kFLAGS.BEE_GIRL_STATUS] & BEE_GIRL_CONVERSATION) >> 16; }
		
		private function set conversation(value:int):void { flags[kFLAGS.BEE_GIRL_STATUS] = (flags[kFLAGS.BEE_GIRL_STATUS] & BEE_GIRL_ATTITUDE) + (value << 16); }
		
		//The Queen Bee
		//location: Forest
		//add to exploreForest
		public function beeEncounter():void
		{
			clearOutput();
			spriteSelect(6);
			//Intro text...
			outputText("As you approach the edge of the forest, a sweet scent wafts into your nose. Tantalizing, teasing, alluring. As you sniff the air, you find yourself following it, as if an invisible hand is pulling you toward its origin.  Little do you know, that is essentially what's happening. The further and further you go, the more heavy the scent grows, as well as a sound. A sound of a buzz, but not in a maddening tone, as if someone is humming. It's a lovely tune, one that would stick in the back of the mind, but not in a bad way.\n\n");
			//Bee appears!
			if (flags[kFLAGS.CODEX_ENTRY_GIANTBEES] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_GIANTBEES] = 1;
				outputText("<b>New codex entry unlocked: Giant Bees!</b>\n\n")
			}
			//Chance to avoid the bee or not if smart enough...
			if (player.hasKeyItem("Traveler's Guide") >= 0 && player.inte / 2 > rand(40)) {
				outputText("You suddenly remember a passage from the Traveler's Guide about monstrous bees that lay eggs in unmentionable places.  Of course, a brave champion would face any danger.\n\n<b>Do you proceed?</b>");
				//Yes goes to beeEncounterLevel2(), no goes to camp
				simpleChoices("Yes", beeEncounterSelect, "", null, "", null, "", null, "Back", camp.returnToCampUseOneHour);
			}
			//If not smart enough, proceed.
			else beeEncounterSelect(false);
		}

		private function beeEncounterSelect(clearScreen:Boolean = true):void {
			if (clearScreen) clearOutput();
			spriteSelect(6);
			outputText("That's when she comes into view.  A great woman, yellow and black, a Bee-like handmaiden would be the best comparison.  She sits atop a great flower while humming her tune, happily picking the petals off of another flower.  Her body is thin, save her abdomen.  Her head is more humanoid than bee, with black eyes, antennae, and luscious black lips that glimmer wetly");
			if (player.statusEffectv1(StatusEffects.Exgartuan) == 1 && player.cockArea(0) > 100 && player.statusEffectv2(StatusEffects.Exgartuan) == 0) { //Exgartuan messes with things!
				beeEncounterWithExgartuan();
				return;
			}
			if (player.findStatusEffect(StatusEffects.Infested) >= 0 || player.findStatusEffect(StatusEffects.WormPlugged) >= 0) { //Worms now mess with things too!
				beeEncounterWithWorms();
				return;
			}
			var isBeeMorph:Boolean = player.race() == "bee-morph";
			if (player.hasCock() && (player.cockArea(0) >= 50 || player.cocks[0].cockType == CockTypesEnum.BEE || isBeeMorph)) {
				outputText(" in the light.\n\n");
				beeEncounterAsBeeMorphMaleOrGiantCock(isBeeMorph);
			}
			else if (isBeeMorph) { 
				outputText(" in the light.\n\n");
				beeEncounterAsBeeMorphFemale();
			}
			else if (flags[kFLAGS.BEE_GIRL_COMBAT_LOSSES] + flags[kFLAGS.BEE_GIRL_COMBAT_WINS_WITH_RAPE] + flags[kFLAGS.BEE_GIRL_COMBAT_WINS_WITHOUT_RAPE] >= 5) {
				if (flags[kFLAGS.BEE_GIRL_COMBAT_LOSSES] > flags[kFLAGS.BEE_GIRL_COMBAT_WINS_WITH_RAPE] + flags[kFLAGS.BEE_GIRL_COMBAT_WINS_WITHOUT_RAPE])
					beeEncounterSheBeatsYouRegularly();
				else if (flags[kFLAGS.BEE_GIRL_COMBAT_WINS_WITHOUT_RAPE] >= flags[kFLAGS.BEE_GIRL_COMBAT_WINS_WITH_RAPE])
					beeEncounterSheFearsYou();
				else beeEncounterSheDesiresYou();
			}
			else {
				switch (attitude) {
					case BEE_GIRL_PLAYER_AFRAID:
						beeEncounterAfraid();
						break;
					case BEE_GIRL_PLAYER_VOLUNTARY_EGGING:
						beeEncounterAfraidRepeat();
						break;
					case BEE_GIRL_PLAYER_DISGUSTED:
						beeEncounterDisgusted();
						break;
					case BEE_GIRL_PLAYER_DUTY:
						beeEncounterDuty();
						break;
					default: //Any other attitude options lead to the classic bee encounter
						outputText(", bending into a smile as she sees you approach.  Standing, she welcomes you in, her wings giving a small buzz as her arms spread open for a welcoming embrace.\n\n");
						//Chance to avoid raaaaeeeeep
						if ((player.lib + player.cor < 140) || rand(2) == 0) {
							outputText("You barely stop yourself from gleefully throwing yourself into her arms.  You realize the harmonic buzzing of her wings and the unearthly scent of her honey briefly robbed you of your reason.  Feeling momentarily more clear-headed, what do you do?");
							simpleChoices("Fight", fightTheBeeGirl, "Talk", beeTalk, "Seduce", null, "", null, "Leave", camp.returnToCampUseOneHour);
						}
						else beeEncounterClassic(false);
				}
			}
		}
		
		private function beeEncounterAsBeeMorphMaleOrGiantCock(isBeeMorph:Boolean):void {
			outputText("Her face opens into a wide smile at the sight of you.  <i>“Aww, hazzz a lonely one come seeking comfort?”</i>\n\n");
			outputText("Still in a daze from the smell and sound around you (or maybe just filled with your own need to be with her) you give her a dopey smile and nod your head.  It’s as best as your addled mind can do in response.  <i>“");
			if (player.longestCockLength() > 50 || player.cocks[0].cockType == CockTypesEnum.BEE)
				outputText("Come here boy, let me help that fine member of yourzzz get releazzze");
			else outputText("Come here little one, I’ll help you become a real bee boy");
			outputText(",”</i> she says opening her arms wide to accept you.");
			//Chance to avoid raaaaeeeeep
			if ((player.lib + player.cor < 140) || rand(2) == 0) {
				if (flags[kFLAGS.CODEX_ENTRY_GIANTBEES] <= 0) {
					flags[kFLAGS.CODEX_ENTRY_GIANTBEES] = 1;
					outputText("\n\n<b>New codex entry unlocked: Giant Bees!</b>")
				}
				outputText("\n\nYou just barely hold yourself back and shake your head to clear the smell and buzzing from your mind.  Something about your " + (isBeeMorph ? "new bee body seems to have drawn" : "massive member has attracted") + " her attention, and she is staring at your crotch in anticipation.  You steady yourself and decide what you should do next.");
				simpleChoices("Fight", fightTheBeeGirl, "Sex", beeSexForCocks, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
			}
			else beeSexForCocks(false);
		}
		
		private function beeEncounterAsBeeMorphFemale():void {
			outputText("Her face breaks into a huge grin and she claps her hands together.  <i>“Hello zzzizzzter!  Come here, let’s play together!”</i>  She stretches out on the flower, and gently beckons to you while running a finger along her moist honey pot.\n\n");
			outputText("You shake your head a little clearing away the buzzing and consider her.  ");
			if (player.cor <= 33)
				outputText("You’re not sure you really want to be spending more time with her, but she seems friendly enough right now.");
			else if (player.cor <= 66)
				outputText("You catch yourself staring at her for a few moments before you collect yourself.  She seems harmless enough, and it does seem like it will be fun to enjoy what she has to offer.");
			else outputText("You grin at the thought, it would certainly be fun fucking her, but maybe it would be even more fun to force yourself on her?");
			outputText("  What will you do?");
			simpleChoices("Fight", fightTheBeeGirl, "Play", beeMaidenPlay, "", null, "", null, "Leave", beeEncounterAsBeeMorphFemaleLeave);
		}
		
		private function beeEncounterAsBeeMorphFemaleLeave():void {
			spriteSelect(6);
			outputText("\n\nYou shake your head at her, and she gives you a look of disappointment.  You’re a little disappointed yourself, but you already decided to leave.  You turn away from the bee and resume your explorations.  Nothing else of note happens over the rest of the hour.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function beeEncounterAfraid():void {
			outputText(" in the light.\n\n");
			outputText("Her face breaks into a smile at the sight of you.  Her buzzing dies down and you notice that the mind numbing smell in the glade isn’t as strong as you were last here.  The handmaiden turns to the side and shows you that her bee abdomen is quite slender today; it doesn’t look like she has any eggs this time.  <i>“Zzzo, the queen hazzz zzzaid that we can try a little experiment with you, if thingzzz work out, maybe we won’t use zzzo much buzzzing and honey.”</i>  She giggles, <i>“Firzzzt time, no eggzzz, zzzo you don’t have to worry.  Are you ready to have zzzome fun?”</i>");
			simpleChoices("Fight", fightTheBeeGirl, "Have Sex", beeEncounterAfraidFirstTimeSex, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
		}
		
		private function beeEncounterAfraidFirstTimeSex():void {
			clearOutput();
			spriteSelect(6);
			attitude = BEE_GIRL_PLAYER_VOLUNTARY_EGGING;
			outputText("You smile and nod to her.  She crooks her finger towards you, inviting you to come closer as she spreads her legs wide.  You walk slowly towards her, wearing a " + (player.cor < 40 ? "somewhat nervous " : "") + "smile on your face.  You decide to take the opportunity to look over her body once more.  Starting at her unusual legs and feet, you marvel at how the alien woman’s exoskeleton legs looks so much like boots, spread wide and inviting towards you.  Your eyes move up her legs to her thighs, covered in an intriguing yellow fuzz.  You find yourself wondering what that fluff would feel like to touch.  At the same time, it’s almost as if it were leading the way to her honey pot; inevitably drawing your view to it.\n\n");
			outputText("Her cunny looks sort of like a human pussy, but is ringed with small bits of exoskeleton to grip down tightly.  However, the most notable part is how it seems to be an almost literal honey pot.  You can see small drips of yellow goo dripping out, and you guess that that must be the main source of the sweet smell that fills the clearing.  Your mind wanders back to the clearing and you look around for a moment and notice that a number of large red flowers have been strewn about.  While you don’t recognize the flowers, you guess that they’re probably the reason that the smell isn’t so overpowering this time around.  Now the bee’s scent is just at the back of your mind, making you aroused and calming your nerves a little; not unlike the gentle and calming, but not overpowering, buzzing of the handmaiden’s wings.\n\n");
			outputText("“You look back at the bee only to find that your legs have carried you right to an arm’s length away from her.  You hesitate for a moment, prompting the woman in front of you to give her ample breasts a little push together.  Then she brings your gaze up to her face.  You can see her luscious black lips part slightly, her eyes close, and suddenly she flies forward.  In an instant, your lips are with hers in a deep kiss.  The taste in her mouth is an incredibly sweet honey, it almost drives your thoughts out of your head right there, and you slump limply into her arms for a moment.  Realizing the state you’re in, the handmaiden puts her hand to her face in surprise.  <i>“Oh, zzzorry about that.”</i> she apologizes before gently lifting you up and taking off your " + player.armorName + " as you recover from the sensation overload of her kiss.\n\n");
			var cockIndex:int = player.cockThatFits(50);
			if (cockIndex >= 0) {
				if (player.hasVagina()) {
					outputText("You smile at her as she examines your " + player.multiCockDescriptLight() + " and your " + player.vaginaDescript(0) + " and ask her which of your toys she wants to play with.  She looks up at you and licks her luscious black lips before whispering to you, <i>“Both.”</i> and pushes you onto your back.  In a flash she is hovering over top of you, upside down.  She takes a firm hold of your " + player.multiCockDescriptLight() + " and gives it a few initial strokes while simultaneously using her long flexible tongue to probe and explore your " + player.vaginaDescript(0) + ".  Astounded by the talents of this bee girl, you can do nothing but push yourself up against her, desperate for more of this incredible stimulation.\n\n");
					outputText("The handmaiden seems to think that you need more stimulation too.  She promptly buries her face and tongue as far inside your " + player.vaginaDescript(0) + " as possible, while simultaneously bringing your " + player.cockDescript(0) + " to her exotic breasts and crushing it between them.  You cry out in dismay and grip the petals of the giant flower you’re spread eagle on.  You look up at your bee lover, who is now hovering at about a forty five degree angle above you while kicking her lower legs back and forth in amusement.  Soon she starts to pump her body up and down to stimulate your " + player.cockDescript(0) + " trapped between her love pillows, while also maneuvering her long insectoid tongue around inside your " + player.vaginaDescript(0) + ".\n\n");
					outputText("The dual sensations are far too much for you to handle, and you can’t even last a minute under the intense stimulation before quickly reaching an incredible orgasm.  When she feels your seed spray onto her stomach, she quickly pulls back from you giggling.  Your orgasm continues to wash over you, soon blocking out all else.  You do manage to hear her tell you that you should come back and visit soon before the feel of her wings blowing air down on you vanishes, indicating that she’s flown off.  You don’t even have a chance to finish your orgasm, and give a reply.  A few minutes later you manage to get yourself cleaned off and dressed, the only real though on your mind being <i>“How did she learn to be such a good lover?”</i>");
				}
				else {
					outputText("She begins gently rubbing her hand up and down your " + player.multiCockDescriptLight() + " while looking at you in uncertainty.  <i>“Where do you want thizzz?  I’m actually not zzzure what would be the mozzzt enjoyable for you...”</i> she asks.  You smile and indicate her honeypot, and say that you want to put your " + player.cockDescript(cockIndex) + " in there.  She looks at you confused for a few moments before saying, <i>“Really?  That doezzzn’t zzzound right, but ok.”</i>  She picks herself up with her wings and slowly lowers her honey pot onto your waiting shaft.  In short order, you’re fully engulfed by her.\n\n");
					outputText("Her cunny feels like a vice on your " + player.cockDescript(cockIndex) + ", but at the same time, her warm honey juices make it very slick.  The bee girl gasps from the sensations.  Clearly this feeling is almost unknown to her, and she has never willingly partaken before with an individual such as yourself.  You gently push her up your shaft, but are surprised when she slams your " + player.cockDescript(cockIndex) + " back home.  You look up at her face to see that her lips have formed into an 'O' shape.  She is clearly enjoying this immensely, and she continues to slam herself back down on you each time you push her even slightly off of your length.  Each time she impales herself, another excited moan of pleasure escapes her.\n\n");
					outputText("The rough slick texture of her honey pot is incredible.  Combine that with the wild abandon that the handmaiden is riding your member, it takes only a few minutes to push you over the edge.  Your bee lover seems to be having the same troubles as you, since she is in the process of letting out an excited buzz or squeal, it’s hard to tell which, that you're certain is an orgasm.  As your " + player.cockDescript(cockIndex) + " unleashes its contents, her honey pot gushes out an odd layer of unusually viscous honey onto your crotch.  The bee girl floats off of you slightly dizzed, gives an attempt at a bow at you before flying off.  Once you’ve had a chance to recover, you dress and return to camp.  After that experience, you’re very much looking forward to your next encounter with the bee handmaiden.");
				}
			}
			else if (player.hasVagina()) {
					outputText("The bee girl giggles and says, <i>“I’ve never tried thizzz before, but my zzzizzzterzzz have told me itzzz a lot of fun.”</i>  She lifts you up and settles her abdomen underneath you.  The handmaiden opens up by stroking an odd part of her carapace just underneath your " + player.vaginaDescript(0) + " moaning the whole while.  It does not take too much time before a long, knotted, and lubricated instrument emerges and rubs against your " + player.vaginaDescript(0) + ".  <i>“Thizzz izzz where I lay my queen’zzz eggzzz from.  Today, it goezzz in a place it dozzzen’t normally belong.”</i>  She giggles once more before lifting you up again before setting you down on her ovipositor.\n\n");
					outputText("You wrap your arms around your insectoid lover from the shock of the stimulation as each of the knots bumps against your " + player.clitDescript() + " and then run against the inner walls of your " + player.vaginaDescript(0) + ".");
					player.cuntChange(25, true);
					outputText("  Your unearthly partner proceeds to use one hand to massage and tweek your " + player.clitDescript() + ", while the other moves to play with your " + player.chestDesc() + ".  Not wanting to be left behind, you bring your own ministrations into the mix on the bee girl’s own chest, and her currently neglected honeypot.  In moments, she gasps from the multitude of different sensations, and grabs onto your body in the same way you just were holding onto hers.\n\n");
					outputText("You rub your abdomen, feeling her ovipositor deep inside you.  You smile, it’s time to pick up the pace and lift up your body, then drop it back down, impaling yourself on the intruder.  You love every second of it, but the sensations aren’t as overwhelming as the handmaiden seems to be finding them.  All she can do at this point is hold onto you as tightly as she can, unable to to do anything else at this point as she pants, moans, and screams from the sensation overload from her ovipositor.  Suddenly there is a sharp stinging feeling in your " + player.nippleDescript(0) + " as the bee girl bites down in orgasm, causing you to be pushed over the edge as well.  " + (player.vaginas[0].vaginalWetness >= CoC.VAGINA_WETNESS_WET ? "This leads to you liberally drenching your lower body and hers with" : "This brings out a small spray of") + " girl fluids from your " + player.vaginaDescript(0) + ".  A few minutes later, the bee girl finally recovers.  It seems that she is looking forward to the next meeting between you two as well.  Leaving you with <i>“Next time, we’re putting that to itzzz proper uzzze!”</i> and a happy wave.");
			}
			else {
				outputText("You brush her long hair out of her eyes and point out that you can’t actually have sex with her, since you don’t have any genitals.  She gently shushes you with a finger to your lips and says, <i>“That izzz for the bezzzt.  Thizzz way you don’t get dizzztracted by lezzzer partzzz.”</i>  She gently runs her fingers over your body, " + (player.beeScore() > 0 ? "paying special attention to your bee like alterations.  She seems to really like them, and you wonder if maybe she’ll do something special for you if you get more?" : "teasing every sensitive spot of your body that she can find.") + "  Your own fingers carefully explore her body.  It’s a unique sensation, the feel of her fine downy fuzz, and the slightly moist but almost rubbery texture of her exoskeleton.\n\n");
				outputText("After a few minutes, your insectoid lover has cupped her hands against your " + player.buttDescript() + ", squeezing and playing with it.  You squirm a bit under her sensations and her buzzing suddenly starts to intensify, causing you to relax back into her arms and let her turn you away from her.  She gasps and apologizes once again for trying to use her buzzing on you.  <i>“It juzzzt comezzz zzzo naturally to me, I think I need more practizzze at not doing that.”</i>  She gently lifts your hips up so you’re on your knees, causing you to inquire at what she is planning on doing.  <i>“I’m going to play with your egg hole zzzilly!”</i> she says, sticking her long flexible tube-like tongue out at you.  Before you have a chance to ask her what she means by that, her tongue finds its way to the entrance to your " + player.buttDescript() + ".\n\n");
				outputText("You shiver as this unearthly woman starts to probe your most private hole, running her tongue around the edge and up the crack.  The whole time she is giggling at the sensation of having her tongue on your ass.  <i>“You tazzzte really good, I wonder what the inzzzide izzz like....”</i>  You barely have time to register what she just said before inhaling sharply at the sensation of her tongue plunging into the entrance of your " + player.buttDescript() + ".  You fall forward onto your hands, and your mind starts to go on a rollercoaster ride from what you are now enduring.  The next few minutes pass in a blur to you as her tongue probes the recesses of your bowels, overwhelmed by the sensations, and the feeling of the honey that she is spreading into the insides with her tongue.\n\n");
				outputText("You aren’t able to regain your wits until she has pulled back out of you and sent you on your way back to camp.  The whole situation was very vivid now that you’ve had a chance to think about it.  You know you came at least 3 times from her tongue, that she told you to come back soon for the full experience next time, and that you actually feel better than you have in a long time!\n\n");
			}
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function beeEncounterAfraidRepeat():void {
			outputText(" in the light.\n\n");
			outputText("Her face breaks into a smile at the sight of you and her buzzing dies down.  Once again, the smell in the grove is much weaker than it was when you first came to this grove.  Those same flowers have been scattered around to ease off on the scent’s mind affecting powers.  She turns to the side to give you a full view of her now swollen abdomen and gives it a gentle pat.  <i>“Are you ready to carry zzzome eggzzz now?  I won’t hurt you, and I promizzzizz I won’t uzzze my buzzzing and honey to make you do it.  Thezzze where zzzaved zzzpecially for you, and I’ve got a little gift for you too if you zzzay yezzz.  Are you up for a little zzzex and eggzzz up your butt?”</i>");
			simpleChoices("Fight", fightTheBeeGirl, "Have Sex", beeEncounterAfraidRepeatSex, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
		}
		
		private function beeEncounterAfraidRepeatSex():void {
			clearOutput();
			spriteSelect(6);
			outputText("You give a nod and strip off your " + player.armorName + ".  The bee reclines back in her flower, continuing to pick away at the smaller flower in her hands while she waits for you.  The girl makes no moves until you’re right in front of her, then she gives you a smile and invites you into her embrace.  You take a deep breath to ready yourself for what is to come before falling into her arms.  She holds you close for a time, ");
			if (player.hasCock()) {
				outputText("gently running her fingers along your " + player.multiCockDescriptLight() + " bringing " + (player.cocks.length > 1 ? "them" : "it") + " to full hardness" + (player.hasVagina() ? ", " : " and "));
			}
			if (player.hasVagina()) {
				outputText("slipping her fingers about your " + player.vaginaDescript(0) + " and your " + player.assholeDescript() + " till you’re wet and ready");
			}
			else outputText("slipping her fingere inside your " + player.assholeDescript() + "till you’re ready");
			outputText(".  You give a slight shudder, knowing what will soon be inside there.  To reassure you, your insectoid lover gives you a gentle squeeze.\n\n");
			outputText("The bee girl pulls back from you after a few minutes and pulls her abdomen between her fuzzy legs, letting it rest wedged between them.  With a delicate hand, she gently rubs her finger along a differently textured part of her carapace close to the base of the stinger.  In a moment, a knotted appendage emerges from it, her ovipositor.  She lies down on her back, and indicates that you should mount her lubricated organ with your " + player.assholeDescript() + ".  You take another steadying breath and gently lower yourself onto the organ.  As you feel each knot pass inside you, your partner gives a gentle buzz of pleasure.\n\n");
			if (player.analCapacity() < 25) {
				outputText("Inserting the organ into your body is a slow but sure process.  The lubrication makes it much easier to get the organ inside you, but you can definitely feel it stretching your rear entrance out.  ");
				if (player.ass.analLooseness == CoC.ANAL_LOOSENESS_VIRGIN)
					outputText("<b>Well, at least you’re losing your anal virginity willingly.  That’s something to be said in this world.</b>");
				else outputText("<b>Your " + player.assholeDescript() + " has become looser thanks to the knotted appendage penetrating you.</b>");
				player.buttChange(25, true);
				outputText("  The pain of being stretched out soon gives way to sharing in the pleasure that your insectoid lover feels with each new bump passing into your body.\n\n");
			}
			else {
				outputText("Your experiance in this world has well prepared your " + player.assholeDescript() + " for the knotted appendage.  Its lubricated surface gives nothing but pleasure to your used rear, and both you and your insectoid lover give nothing but moans of pleasure as each new bump passes into your body.\n\n");
			}
			outputText("Once the ovipositor is all the way inside you, the bee girl pulls herself up and wraps her arms around you.  She rubs her large chest into yours, hugging ");
			if (player.tallness <= 50)
				outputText("your tiny body against her.  Clinging to you almost like a mother would cling to her child.  Considering that you’re being used as an egg sack, that might not be too far off.");
			else if (player.tallness <= 68)
				outputText("you tightly.  She gently blows into your ears, while whispering sweet nothings about how wonderful you will soon feel.");
			else outputText("her small body against yours.  She rubs her head against your chest, and you vaguely hear her whisper something about a strong carrier for strong eggs.");
			outputText("  Shortly after, you feel her bee seed start to flow inside your bowels.  Soon, lumps that must be her eggs accompany the seed.\n\n");
			var cockIndex:int = player.cockThatFits(50);
			if (cockIndex >= 0) {
				outputText("Left wanting a bit more pleasure, you lift up the bee girl, and gently lower her onto your waiting " + player.cockDescript(cockIndex) + " so that she can mount you in the same way you mounted her.  Well, almost, since you’re quite sure her rough slick interior is very different than the inside of your " + player.assDescript() + ".  While a bit surprised at first, she quickly gets really into bouncing on top of your " + player.cockDescript(cockIndex) + " while her egg layer keeps working its magic.\n\n");
			}
			if (player.hasVagina()) {
				outputText("Your " + player.vaginaDescript(0) + " is left a bit wanting, so you free up one of your hands to deal with the lack of attention.  No sooner had you started playing with your " + player.clitDescript() + ", you find that the bee girl has brought one of her hands into the fray to deal with the lack of attention herself, all the while grinning at you.  You return her smile and move your hand instead to her honey pot’s little button and start playing with that while she deals with your clit.\n\n");
			}
			outputText("The two of you remain connected to one another for the better part of an hour.  Despite all the other sources of pleasure available to you here, you find yourself focusing the most on the organ inserted into your rear end.  The handmaiden seems to catch onto this, and start to pull her organ in and out of your back entrance.  Each time the lowest knot on her passes through your hole, both of you let out great moans of pleasure.\n\n");
			outputText("Eventually, her supply of eggs runs out, and she thanks you for the time that you spent together.  With the amount of pleasure you experienced, there is no question in your mind that it was quite worth it.  She does hand you a gift as a final thank you for your service before flying off.\n\n");
			if (!player.isButtPregnant()) player.buttKnockUpForce(PregnancyStore.PREGNANCY_BEE_EGGS, PregnancyStore.INCUBATION_BEE);
			player.orgasm();
			player.slimeFeed();
			switch (rand(10)) {
				case  0: inventory.takeItem(consumables.W__BOOK, camp.returnToCampUseOneHour); break;
				case  1:
				case  2: inventory.takeItem(consumables.OVIELIX, camp.returnToCampUseOneHour); break;
				case  3:
				case  4: inventory.takeItem(useables.B_CHITN,    camp.returnToCampUseOneHour); break;
				default: inventory.takeItem(consumables.PURHONY, camp.returnToCampUseOneHour);
			}
		}
		
		private function beeEncounterDisgusted():void {
			outputText(" in the light.\n\n");
			outputText("Her face breaks into a frown at the sight of you.  At once her buzzing stops and she looks at you and says <i>“Oh, it’zzz you again, juzzzt go away; I need to find zzzomeone that actually will carry my queen’zzz eggzzz.”</i>  Your mind is pulled from its stupor, as she directs you out of the clearing with a dismissive look.");
			simpleChoices("Fight", fightTheBeeGirl, "", null, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
		}
		
		private function beeEncounterDuty():void {
			outputText(" in the light.\n\n");
			outputText("Her face breaks into a smile and her buzzing dies down.  You shake your head slightly to clear away the effect that you were under and look back at the smiling bee girl.");
			simpleChoices("Fight", fightTheBeeGirl, "Talk", beeEncounterDutyTalk, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
		}
		
		private function beeEncounterDutyTalk():void {
			clearOutput();
			spriteSelect(6);
			outputText("The handmaiden seems to be quite happy to talk to you for a little while.  She is quite interested in the tales you have to share, and you have a chance to hear a bit about the world from her.  After the two of you have been talking for awhile, you notice that she has been running her hand over her lady bits and you ask her about it.  <i>“Oh?  Well, I’m juzzzt zzzo horny right now, do you think you could help me out with that?  You can keep zzzome of the honey for later, and it could do zzzome incredible thingzzz to you.”</i>  Do you take her up on her offer?”</i>");
			if (player.inte < 50) dynStats("int", 0.5);
			doYesNo(freeHoneyEvent, beeEncounterDutyLeave);
		}
		
		private function beeEncounterDutyLeave():void {
			clearOutput();
			spriteSelect(6);
			outputText("You decline her offer, and shortly afterwards you take your leave to return to camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function beeEncounterSheFearsYou():void {
			outputText(" in the light.\n\n");
			outputText("Her mouth opens wide in panic as she catches sight of you.  She drops the flower and starts to draw back yelling <i>“Pleazzze don't hurt me again!  I won't try to lay eggzzz in you any more, just let me go!”</i>\n\n");
			outputText("What will you do with her?");
			simpleChoices("Fight", fightTheBeeGirl, "", null, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
		}
		
		private function beeEncounterSheDesiresYou():void {
			outputText(" in the light.\n\n");
			outputText("Her mouth opens wide in panic as she catches sight of you.  She drops the flower and starts to draw back yelling <i>“No!  I won't give in to the dezzzire!  Go away!”</i>\n\n");
			outputText("What will you do with her?");
			simpleChoices("Fight", fightTheBeeGirl, "", null, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
		}
		
		private function beeEncounterSheBeatsYouRegularly():void {
			outputText(" in the light.\n\n");
			outputText("Her mouth breaks out in a grin at the sight of you.  <i>“Hello again naughty " + player.mf("boy", "girl") + ",”</i> her buzzing really starting to get inside your head as she stands up and beckons to you.  <i>“Juzzzt make it eazzier on yourzzzelf and let me lay my eggzzz in you.  No fuzzzzz, no fighting.  Just let yourzzzelf be carried away.”</i>\n\n");
			if ((player.lib + player.cor < 70) || rand(4) == 0) { //Chance to avoid raaaaeeeeep
				outputText("With great difficulty you manage to stop yourself from throwing yourself into her arms.  Losing to this girl isn’t helping you resist her charms at all.  You’re finding It harder and harder to fight the call of her incredible song and unnatural scent, it may be wise to run now; but what will you do now that you have your senses again?");
				simpleChoices("Fight", fightTheBeeGirl, "Talk", beeEncounterSheBeatsYouRegularlyTalk, "", null, "", null, "Run", camp.returnToCampUseOneHour);
			}
			else {
				outputText("Unable to control yourself in her presence, you throw yourself into her arms and she lifts you up a little into the air before setting you face down onto the flower and landing on your back.  <i>“That’zzz the way it should be, it’zzz zzzo much easier when you juzzzt let go.  Are you ready?”</i>");
				beeEncounterSheBeatsYouRegularlyLastChance();
			}
		}
		
		private function beeEncounterSheBeatsYouRegularlyTalk():void {
			clearOutput();
			spriteSelect(6);
			outputText("<i>“Zzzo, you’re being nizzze today?”</i> she smiles as she gently floats over towards you.  <i>“I know what you’re really here for, you can’t fight it anymore.”</i> she gently slaps your " + player.buttDescript() + " and you find yourself start to walk towards the large flower, the bee girl gently floating behind you.  She giggles at you and says, <i>“Zzzee?  You really juzzzt want the eggzzz and honey.  You’re a zzzpecial one, made juzzzt for carrying the hive’zzz eggzzz.”</i>  You fall into the flower and feel the bee girl gently land on your back.  <i>“Are you ready?”</i> she asks you.");
			beeEncounterSheBeatsYouRegularlyLastChance();
		}
		
		private function beeEncounterSheBeatsYouRegularlyLastChance():void {
			if ((player.lib + player.cor < 70) || rand(4) == 0) { //Chance to avoid raaaaeeeeep
				doYesNo(beeEncounterSheBeatsYouRegularlyAndYouLetHerLaysEggs, beeEncounterSheBeatsYouRegularlyDontLetHer);
			}
			else {
				outputText("\n\nThanks to her wiles, you can’t think of any reason why you shouldn’t be.");
				beeEncounterSheBeatsYouRegularlyAndYouLetHerLaysEggs();
			}
		}
		
		private function beeEncounterSheBeatsYouRegularlyDontLetHer():void {
			clearOutput();
			spriteSelect(6);
			outputText("You barely manage to shake off her wiles and roll to the side.  You give her one last look before picking yourself up and running away from the clearing.  That really could have gone better.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function beeEncounterSheBeatsYouRegularlyAndYouLetHerLaysEggs(clearScreen:Boolean = true):void {
			if (clearScreen)
				clearOutput();
			else outputText("\n\n");
			spriteSelect(6);
			outputText("You almost breathlessly say <i>“Yes!”</i> just before you give yourself over to the siren call of the bee’s humming and the mind blowing effects of her scent.  <i>“Good " + player.mf("boy", "girl") + ".”</i> she coos and slips off your " + player.armorName + ".  Then she slowly wraps her arms around your " + player.chestDesc() + " and you feel something start to push against your " + player.buttDescript() + ".  You sigh with pleasure and relax, allowing your rear entrance to be penetrated by the intruder.  You hear the bee girl giggle and sigh above you, quite pleased with your decision to allow her to enter you.\n\n");
			if (player.hasBreasts()) {
				outputText("She starts to grip and squeeze your " + player.chestDesc() + " as the intruder to your anal passage continues its advance.  You can only gasp and cry out in pleasure with each motion.  You hear her say, <i>“Let’zzz make thizzz extra zzzpeacial,”</i> as one of her hands is removed from your chest; within moments something wet and sticky is placed on the vacated " + player.nippleDescript(0) + ".  You shudder as the bee rubs the honey into the sensitive tips, and squeal as she does the same treatment to the other " + player.nippleDescript(0) + ".\n\n");
			}
			else {
				outputText("One of her hands gets pulled back from your body, and you hear her say, <i>“Let’zzz make thizzz extra zzzpeacial.”</i>  You then find a sweet smelling finger in front of your face; you instinctively open your mouth and start to suck on the finger, delighted to find it covered in honey.  As you happily lick and suck away on the finger, the bee girl starts rocking against you more and more urgently, pushing her intruder further and further into your anal passage.\n\n");
			}
			outputText("The bee above you gives a happy buzz and you feel a warm viscous fluid start to fill the depths of your violated " + player.buttDescript() + ".  You gasp again and the bee girl says <i>“Now the real fun can zzztart.  Let me fill that hole of yourzzz with all thezzze eggzzz.  I’ll make zzzure you enjoy the whole thing.”</i>.  While still ensuring that your " + player.buttDescript() + " remains fully penetrated, the bee girl gently lifts you up onto her stinger.  You are vaguely aware of looking down and seeing it sticking between your legs.\n\n");
			if (player.hasCock()) {
				outputText("However, you quickly become far more interested in the feeling of her hands wrapping around your " + player.multiCockDescriptLight() + " and gently pumping them.  You give a giddy laugh as the bee girl continues her hand job, and in moments you release your load and spray the flower in front of you.\n\n");
				outputText("<i>“That’zzz one, but we’ll get many more by the time I’m finished with you,”</i> she whispers in your ear, and you give a nod while wearing a vacant smile on your face.  Her hands once again start to rub your " + player.multiCockDescriptLight() + " as you feel something solid start to pass into your " + player.buttDescript() + ".  The sensations overwhelm you, and you lose track of time.  You have no idea how many times the stimulation of your bowels being filled and her hands on your " + player.multiCockDescriptLight() + " bring you to wonderful release.\n\n");
			}
			else if (player.hasVagina()) {
				outputText("That’s not what really attracts your attention, as the feeling of fingers gently running over your " + player.vaginaDescript(0) + " quickly demonstrate.  You give a small cry as some of those fingers are soon inserted inside you, and others start to dance around your vulva and " + player.clitDescript() + ".  The combination of stimulation from one of your holes being filled as another is played with push you over the edge into an orgasm.\n\n");
				outputText("<i>“That’zzz one, but we’ll get many more before I’ve finished with you,”</i> she whispers in your ear, and give a nod while wearing a vacant smile on your face.  Her hands once again begin their dance across your girly lower lips as you feel something solid start to pass into your " + player.buttDescript() + ".  It doesn’t take long for the dual sensations to reduce you down to a moaning, orgasming, mess.  You have no idea how long you were there, or how many times you were pushed over the edge as egg after egg was pushed inside you.\n\n");
			}
			else {
				outputText("Soon her fingers are playing over your body, finding every place to stimulate you.  You giggle and laugh as she plays you like a fiddle, and cry out in orgasm as something solid starts to pass into your bowels.  <i>“That wazzz only the firzzzt one,”</i> the bee girl giggles, <i>“I know we’ll have zzzo much fun before I’m done filling you”</i>  You give her a vacant smile and feel another orgasm wash over you.\n\n");
				outputText("You have no idea for how long it goes on for, or how many times the bee girl managed to get you to orgasm despite your lack of endowments, but the whole time, you felt nothing but bliss and release.\n\n");
			}
			outputText("Once the last of the eggs are pushed deep inside your bowels, the bee girl sighs and slowly removes the knotted implement that was filling your " + player.buttDescript() + ".  She sets you back down on the flower and gives you a full mouth kiss before saying <i>“Zzzee you next time...”</i>  In a few moments, you drift off to sleep.  You wake up several hours later, feeling giddy, and you notice that something wet is leaking from your anus.\n\n");
			player.orgasm();
			dynStats("int", -.5);
			player.slimeFeed();
			if (rand(2) == 0) player.buttKnockUp(PregnancyStore.PREGNANCY_BEE_EGGS, PregnancyStore.INCUBATION_BEE, 1, 1); //Anal bee pregnancy!
			player.buttChange(25, true);
			doNext(camp.returnToCampUseFourHours);
		}
		
		private function beeEncounterWithExgartuan():void {
			outputText(", bending into a smile as she sees you approach.  Standing, she welcomes you in, her wings giving a small buzz as her arms spread open for a welcoming embrace.\n\n");
			if (rand(2) == 0) {
				outputText("Your " + player.cockDescript(0) + " wriggles free of your " + player.armorName + ", as you keep walking forward.  A bodiless voice yells, \"<i>Honeypot, honeypot, ME LOOOOVE HONEYPOOOOOT!</i>\"\n\n");
				outputText("The bee-girl's eyes widen at the sight, shocked by your over-endowed form being dragged towards her as if there were a magnet in your " + player.cockDescript(0) + ".  She presses herself against the flower's petals, terrified and afraid to put up any meaningful resistance.  The nagging voice pipes up, \"<i>So are we gonna rape her or what, " + player.short + "?  I need some honeyyy!</i>\"\n\n");
				outputText("She seems too surprised to resist.  Will you go along with Exgartuan and rape her?");
				doYesNo(getGame().exgartuan.exgartuanBeeRape, camp.returnToCampUseOneHour);
			}
			else {
				outputText("The bee-girl's eyes widen at the sight,  shocked by your over-endowed form being dragged towards her as if there were a magnet in your " + player.cockDescript(0) + ".   She flutters into the air and aims her stinger towards you, ready to fight!");
				//start combat
				startCombat(new BeeGirl());
			}
		}
		
		private function beeEncounterWithWorms():void { //If she won't fuck infested players after combat then she shouldn't fuck them here either
			clearOutput();
			spriteSelect(6);
			outputText("You slowly " + (player.isTaur() ? "trot" : "walk") + " toward the bee girl, your mind in a haze.  Her antennae wiggle in anticipation and she gives you a lusty smile, eager to fill your ass with her payload.  You start to take off your clothes, the last of your underwear falling to the forest floor as you reach her.\n\n");
			outputText("The bee maiden puts her hands on your shoulders.  She draws you gently into a kiss, but as her sweet saliva prepares you for what is to come you feel one of your annelid passengers slither down " + (player.findStatusEffect(StatusEffects.WormPlugged) >= 0 ? "from your cervix and poke out of your cunt" : "your urethra and wrap itself around the tip of your cock") + ".  The bee girl pulls back from the kiss, looks down and jumps back, the color draining from her face.\n\n");
			outputText("<i>“By my queen!  That izzz dizzzguzzting!  How can you zzztand it?  Ugh, no, I can't lay my queen'zzz preciouzzz eggzzz in a body with thozzze.”</i>  A few drips of fluid dribble from the tip of her ovipositor and she adds, <i>“and I zzzo wanted to.  I really have to find zzzomeone who can take thezzze and keep them zzzafe.”</i>\n\n");
			outputText("She lifts off, hovering a few feet off the ground.  <i>“Good luck getting rid of thozzze thingzzz.  When you do, come find me and I'll fill you zzzo full of lovely eggzzz,”</i> she promises, her fingers idly stroking her sex.  She shakes her head, deliberately getting control of herself and forcing her fingers away from her slit, then flies up through a hole in the canopy.\n\n");
			outputText("Alone and aroused, all you can do is put your clothes back on and travel back to your camp, hoping no imps ambush you on the way.");
			dynStats("lus", 0.5 * player.lib + 20);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function fightTheBeeGirl():void {
			clearOutput();
			outputText("You clear your head and resolve to defeat the monstrous bee-woman.");
			spriteSelect(6);
			startCombat(new BeeGirl());
		}
		
		private function beeEncounterClassic(clearScreen:Boolean = true):void {
			if (clearScreen) clearOutput();
			if (attitude == BEE_GIRL_TALKED_AND_LEFT || attitude == BEE_GIRL_TALKED_AND_LEFT_TWICE) attitude = BEE_GIRL_TALKED; //Reset your friendly conversation path if autorape or accepted
			beeEncounterClassicSex(false);
		}
		
		private function beeEncounterClassicSex(postCombat:Boolean = true):void {
			spriteSelect(6);
			//Give into the beeee
			if (attitude == BEE_GIRL_TALKED_AND_LEFT || attitude == BEE_GIRL_TALKED_AND_LEFT_TWICE) attitude = BEE_GIRL_TALKED; //Reset your friendly conversation path if autorape or accepted
			//TAUR SPECIAL!
			if (player.isTaur()) {
				outputText("As if you have lost control of your body, you trot up beside her, utterly entranced by the sweet smell pervading the area. She assesses your strange body, walking in circles around you while stroking you with her chitin covered hands. When she reaches your flank she lifts your tail and traces around your " + player.assholeDescript() + ", smearing a bit of honey inside and causing you to shiver. The sensation is mind numbing and you find yourself hugging a tree to support yourself. Evidently satisfied with what she's seen, the bee-girl walks in front of you and smears more honey all over the tree you're holding. You lick it without a second thought, the smell quickly overpowering whatever sense you had left. Seeing this, the bee-girl giggles and pats you, moving back toward your flank.\n\n", false);
				outputText("She beats her wings with a visible effort and drags herself onto your back, taking a moment to rest. The soft humming she emits seems to make her whole body vibrate and you delight in the oddness of the sensation. A stinger slowly emerges from her abdomen, as well as a thick knot-like organ, both covered in a sweet smelling lubricant. You don't protest as her stinger injects what feels like liquid lust into you, causing a rush of blood to your hindquarters and your anus to relax completely.\n\n", false);
				outputText("With no warning, she inserts the thick, lengthy appendage and knot inside of you. Her 'cock' slips in slowly, your relaxed sphincter easily taking the entirety while you continue to lap at the copious amounts of honey she so graciously smeared on the tree for you.\n\n", false);
				outputText("Her ovipositor begins to pump even more of the aphrodisiac-like fluid into your rectum as it works its way further and further inside you. She hums louder and the vibrations on your back grow stronger as large spherical objects begin injecting themselves into you.\n\n", false);
				//Route 2 
				if (player.longestCockLength() >= 100 || player.gender == 0) {
					//[Male (bypasses the bucking scene):
					if (player.gender == 1) {
						outputText("You grasp ", false);
						if (player.cockTotal() > 1) outputText("one of ", false);
						outputText("your engorged " + player.multiCockDescriptLight() + " and jerk it off violently, cumming again and again as the bee-girl violates your " + player.assholeDescript() + ".  ", false);
						//[Without testicles:
						if (player.balls == 0) outputText("With your cock quivering and spasming you continue to lap at the honey covered tree until the vibrating bee-girl finishes.  ", false);
						//[With testicles:
						else outputText("With your cock quivering and spasming semen erupts from the tip.  ", false);
						//[Little-normal cum amount:
						if (player.cumQ() < 100) outputText("You spurt out more cum than you thought your " + player.ballsDescriptLight() + " could hold. White speckles the base of the tree and tiny puddles form underneath you as you groan in satisfaction.\n\n", false);
						//[Huge cum amount:
						else outputText("Your " + player.ballsDescriptLight() + " goes off like a firehouse, coating the base of the tree along with a number of the ones behind it. Soon you're standing in a massive puddle of your own splooge, the scent threatening to overpower that of the honey. The bee-girl compensates by splashing more onto your back, causing you to release yet another burst of thick white cum.\n\n", false);
					}
					//[Herm (bypasses the bucking scene):
					else if (player.gender == 3) {
						outputText("You grasp your engorged " + player.multiCockDescriptLight() + " and jerk it off violently, cumming again and again as the bee-girl violates your " + player.assholeDescript() + " and your " + player.vaginaDescript(0) + " pumps out enough femcum to drench your hind legs.  ", false);
						//[Without testicles:
						if (player.balls == 0) outputText("With your cock quivering and spasming and your untended to " + player.vaginaDescript(0) + " squirting repeatedly, you continue to lap at the honey covered tree until the vibrating bee-girl finishes.  ", false);
						//[With testicles:
						else outputText("With your cock quivering and spasming semen erupts from the tip.  ", false);
						//[Little-normal cum amount:
						if (player.cumQ() < 100) outputText("You spurt out more cum than you thought your " + player.ballsDescriptLight() + " could hold. White speckles the base of the tree and tiny puddles form underneath you as you groan in satisfaction.\n\n", false);
						//[Huge cum amount:
						else outputText(player.SMultiCockDesc() + " goes off like a firehouse, coating the base of the tree along with a number of the ones behind it. Soon you're standing in a massive puddle of your own splooge, the scent threatening to overpower that of the honey. The bee-girl compensates by splashing more onto your back, causing you to release yet another burst of thick white cum.\n\n", false);
					}
					//[Genderless (if gender() = 0?):
					else {
						outputText("The pleasure from your ass is so great your legs buckle and you pass out. The bee maiden continues to pump her fluids inside you as the world goes black.\n\n", false);
					}
					outputText("After hours of her forcefully filling your hole, her stinger pumping what feels like gallons of her bee-seed into your bowels, she finally pulls out. She smiles and lies down on your back and your legs finally give out from exhaustion.\n\n", false);
					outputText("When you awaken, your hind end is covered in honey and what you can only assume is the lubrication from her ovipositor. You stand with a bit of a struggle and notice a thin trail of honey leading away into the undergrowth.", false);
				}
				//Route 1 
				else {
					//[Male:
					if (player.gender == 1) outputText("Your inability to reach your engorged " + player.multiCockDescriptLight() + " quickly becomes a problem as the pleasure from the bee-maiden's scent courses through you. You ache to be tended to, gushing out pre.", false);
					//[Female:
					else if (player.gender == 2) outputText("Your inability to reach your " + player.vaginaDescript(0) + " quickly becomes a problem as the pleasure from the bee maiden's scent courses through you, it starts reflexively rippling, trying to milk the cock it so desperately wants while your " + player.clitDescript() + " quivers.", false);
					//[Herm:
					else if (player.gender == 3) outputText("Your inability to reach your engorged " + player.multiCockDescriptLight() + " quickly becomes a problem as the pleasure from the bee maiden's scent courses through you. It aches to be tended to, gushing out pre. Your " + player.clitDescript() + " quivers, desperate for contact as your vagina starts reflexively rippling, trying to milk the cock it isn't going to get.", false);
					//[With breasts: 
					if (player.biggestTitSize() > 1) {
						outputText("  You begin pounding away at your " + kGAMECLASS.player.allBreastsDescript() + " in an attempt to alleviate the pressure in your inaccessible groin.", false);
						//[Fuckable breasts:
						if (player.hasFuckableNipples()) outputText("  Your fingers slip in and out of them, sending femcum flying everywhere. But the effects of the bee's honey appear to prevent you from getting off.", false);
						//[Other:
						else outputText("  No amount of stimulation seems to get you off though.", false);
					}
					outputText("\n\n", false);

					outputText("The stimulation grows too painful and you begin to buck wildly. The bee-girl holds on desperately, her stinger still lodged in your " + player.assholeDescript() + " and pumping fluids. She seems to realize the problem though and attempts to solve it.  ", false);
					//[Male:
					if (player.gender == 1) {
						outputText("Her legs wrap around your body and her 'feet' clasp onto your " + player.multiCockDescriptLight() + ". The strangeness of the sensation doesn't register though as just the contact is enough to send you over the edge.  ", false);
						//[Without testicles:
						if (player.balls == 0) outputText("You cum violently, your " + player.multiCockDescriptLight() + " quivering and spasming.  ", false);
						//[With testicles:
						else outputText("You cum violently, your " + player.multiCockDescriptLight() + " quivering and spasming while semen erupts from the tip.  ", false);
						//[Little-normal cum amount:
						if (player.cumQ() < 100) outputText("You spurt out more cum than you thought your " + player.ballsDescriptLight() + " could hold. White speckles your underside and tiny puddles form underneath you as you groan in satisfaction.\n\n", false);
						//[Huge cum amount:
						else outputText("Your " + player.ballsDescriptLight() + " goes off like a firehouse, coating your underside with white and dripping down your front legs. Soon you're standing in a massive puddle of your own splooge, the scent threatening to overpower that of the honey. The bee-girl compensates by splashing more onto your back, causing you to release yet another burst of thick white cum.\n\n", false);
					}
					//[Female:
					else if (player.gender == 2) {
						outputText("Her legs curl around your hind legs and her 'feet' begin rubbing your " + player.vaginaDescript(0) + ". The strangeness of the sensation doesn't register though as just the contact is enough to send you over the edge.  ", false);
						//[Tiny-normal clit:
						if (player.clitLength < 3) outputText("Her awkward ministrations to your " + player.clitDescript() + " cause a gush of fluids from your " + player.vaginaDescript(0) + " and you let out a lewd moan of satisfaction.  ", false);
						//[Cock-like clit:
						else outputText("She quickly finds your " + player.clitDescript() + " and begins to jerk it off like a cock.  The sensation is incredible and you moan lewdly as your " + player.vaginaDescript(0) + " gushes fluid.  ", false);
						outputText("Your hind legs are soon coated in the slick girlcum pouring out of you.\n\n", false);
					}
					//[Herm:
					else if (player.gender == 3) {
						//[Same as male followed by:]
						if (rand(2) == 0) {
							outputText("Her legs wrap around your body and her 'feet' clasp onto your " + player.multiCockDescriptLight() + ". The strangeness of the sensation doesn't register though as just the contact is enough to send you over the edge.  ", false);
							//[Without testicles:
							if (player.balls == 0) outputText("You cum violently, your " + player.multiCockDescriptLight() + " quivering and spasming.  ", false);
							//[With testicles:
							else outputText("You cum violently, your " + player.multiCockDescriptLight() + " quivering and spasming while semen erupts from the tip.  ", false);
							//[Little-normal cum amount:
							if (player.cumQ() < 100) outputText("You spurt out more cum than you thought your " + player.ballsDescriptLight() + " could hold. White speckles your underside and tiny puddles form underneath you as you groan in satisfaction.\n\n", false);
							//[Huge cum amount:
							else outputText("Your " + player.ballsDescriptLight() + " goes off like a firehouse, coating your underside with white and dripping down your front legs. Soon you're standing in a massive puddle of your own splooge, the scent threatening to overpower that of the honey. The bee-girl compensates by splashing more onto your back, causing you to release yet another burst of thick white cum.\n\n", false);

							outputText("Thinking you still not satisfied, she pulls her 'feet' up slightly and she begins to rub your " + player.vaginaDescript(0) + ".  ", false);
							// [Same as female without intro]
							//[Tiny-normal clit:
							if (player.clitLength < 3) outputText("Her awkward ministrations to your " + player.clitDescript() + " cause a gush of fluids from your " + player.vaginaDescript(0) + " and you let out a lewd moan of satisfaction.  ", false);
							//[Cock-like clit:
							else outputText("She quickly finds your " + player.clitDescript() + " and begins to jerk it off like a cock.  The sensation is incredible and you moan lewdly as your " + player.vaginaDescript(0) + " gushes fluid.  ", false);
							outputText("Your hind legs are soon coated in the slick girlcum pouring out of you.", false);
						}
						//- OR -
						//[Same as female followed by:]
						else {
							outputText("Her legs curl around your hind legs and her 'feet' begin rubbing your " + player.vaginaDescript(0) + ". The strangeness of the sensation doesn't register though as just the contact is enough to send you over the edge.  ", false);
							//[Tiny-normal clit:
							if (player.clitLength < 3) outputText("Her awkward ministrations to your " + player.clitDescript() + " cause a gush of fluids from your " + player.vaginaDescript(0) + " and you let out a lewd moan of satisfaction.  ", false);
							//[Cock-like clit:
							else outputText("She quickly finds your " + player.clitDescript() + " and begins to jerk it off like a cock.  The sensation is incredible and you moan lewdly as your " + player.vaginaDescript(0) + " gushes fluid.  ", false);
							outputText("Your hind legs are soon coated in the slick girlcum pouring out of you.\n\n", false);

							outputText("Thinking you're still not satisfied, she lowers her 'feet' slightly and she begins to rub your " + player.multiCockDescriptLight() + ".  ", false);
							//[Same as male without intro]
							//[Without testicles:
							if (player.balls == 0) outputText("You cum violently, your " + player.multiCockDescriptLight() + " quivering and spasming.  ", false);
							//[With testicles:
							else outputText("You cum violently, your " + player.multiCockDescriptLight() + " quivering and spasming while semen erupts from the tip.  ", false);
							//[Little-normal cum amount:
							if (player.cumQ() < 100) outputText("You spurt out more cum than you thought your " + player.ballsDescriptLight() + " could hold. White speckles your underside and tiny puddles form underneath you as you groan in satisfaction.\n\n", false);
							//[Huge cum amount:
							else outputText("Your " + player.ballsDescriptLight() + " goes off like a firehouse, coating your underside with white and dripping down your front legs. Soon you're standing in a massive puddle of your own splooge, the scent threatening to overpower that of the honey. The bee-girl compensates by splashing more onto your back, causing you to release yet another burst of thick white cum.\n\n", false);
						}
					}
					outputText("After hours of her forcefully filling your hole, her stinger pumping what feels like gallons of her bee-seed into your bowels while awkwardly dealing with your needs; she finally pulls out. She smiles and lies down on your back and your legs finally give out from exhaustion.\n\n", false);
					outputText("When you awaken, you're covered in honey and what you can only assume is the lubrication from her ovipositor. You stand with a bit of a struggle and notice that in your wild state you seem to have devastated the little clearing, as it's covered with broken trees and trampled plants. A thin trail of honey leads away from the devastation into the undergrowth.", false);
				}
				player.orgasm();
				dynStats("int", -.5);
				player.slimeFeed();
				//Anal bee pregnancy!
				if (rand(3) == 0) player.buttKnockUp(PregnancyStore.PREGNANCY_BEE_EGGS, PregnancyStore.INCUBATION_BEE, 1, 1);
				player.buttChange(25, true);
			}
			//NON TAURS
			//Dicked version...
			else if (player.cocks.length > 0) {
				outputText("As if you have lost control of your body, you fall into her arms, happy. As she holds you close, a stinger slowly emerges from her abdomen, as well as a thick knot-like organ, both covered in a sweet smelling lubricant. As your mind synaesthetically sees a myriad of colors and scents, you don't resist as she gently pushes you down to your ", false);
				if (player.isTaur()) outputText(" hocks and knees", false);
				else outputText("stomach", false);
				outputText(". Nor do you protest as she leans over you, her stinger- thank goodness it isn't poison- looming close to your anus.  With no more words she shoves the thick, lengthy stinger and knot inside of you. Her 'cock' slips in slowly, the lubricant keeping you from shaking out of your scent-induced pleasure coma. Your hand even ventures to your own engorged ", false);
				if (player.cockTotal() == 1) outputText("member", false);
				if (player.cockTotal() > 1) outputText("members", false);
				outputText(" as she rather forcefully rapes your once-tight hole, humming her tune all the while.\n\n", false);
				//blow load.
				outputText("After hours of her forcefully filling your hole, her stinger pumping what feels like gallons of her bee-seed into your very bowels, and of you stroking yourself to ejaculation, she finally pulls out. With her stinger still dripping seed onto your back, she smiles while watching you blow your last load into a pool of semen underneath you, before you collapse - exhausted.\n\n", false);
				player.slimeFeed();
				//epilogue
				outputText("You awaken, your nose full of a honey like scent, some strange fluid on your back, and the feeling of something leaking from you.", false);
				player.buttChange(25, true);
				player.orgasm();
				dynStats("int", -.5);
				//Anal bee pregnancy!
				if (rand(3) == 0) player.buttKnockUp(PregnancyStore.PREGNANCY_BEE_EGGS, PregnancyStore.INCUBATION_BEE, 1, 1);
			}
			//non-dicked version
			else {
				outputText("Blissfully, you throw yourself into the bee-maiden's arms, entranced by her humming and the sinfully sweet smell of honey that saturates the air around her.  She embraces you softly, humming softly but intently into your ear, vibrating your thoughts into a disjointed mess as you slump nervelessly in her arms.  You are aware of being moved, laying you out on a giant flower as she moves behind you, registering the feel of the smooth chitin that covers her arms as she tenderly rubs you down.   She turns you over, buzzing more of her thought-obliterating tune into your ear as she does.\n\n", false);
				outputText("You lay there, a giddy smile on your face, letting the bee-girl straddle and sink something sharp into your thigh.  Lust boils through your veins, ", false);
				//No cooch, talk about being horny, nipples if you got em!
				if (player.vaginas.length == 0) {
					outputText("and you writhe and moan with no source of relief", false);
					if (player.totalNipples() > 1) outputText(", your nipples swollen and red with desire.  ", false);
					else outputText(".", false);
				}
				//Coochie talk!
				else {
					if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_WET)outputText("centering around your now puffy vulva.  ", false);
					if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_WET && player.vaginas[0].vaginalWetness < VAGINA_WETNESS_DROOLING)outputText("growing more potent around your " + player.vaginaDescript(0) + " as it begins to leak with the honey of your desire.  ", false);
					if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) outputText("inflaming your " + player.vaginaDescript(0) + " with need, and allowing a river of your wetness to gush from between your puffy vulva.  ", false);
				}
				//Boobies!
				if (player.biggestTitSize() > 1) {
					outputText("The cool hardness of her hands startles you as she reaches around to massage your ample bosom, tweaking your hard nipples between her fingers", false);
					//if lactating
					if (player.biggestLactation() > 1) outputText(", humming in surprise as a squirt of milk splatters across the flower's petals.  ", false);
					else outputText(".  ", false);
				}
				//Multiboobs!
				if (player.breastRows.length > 1) {
					outputText("The cool hardness of her hands startles you as she begins running her hands over your many breasts, tweaking each hard nipple between her fingers, leaning around to lick them with her curving sinuous tongue, and humming softly", false);
					//Milk bit
					if (player.biggestLactation() > 1) outputText(" in surprise as a squirt of milk splashes across the flower's petals.  ", false);
					else outputText(".  ", false);
				}
				//Continue as normal!
				outputText("Instinctively, your butt clenches as a wet presence presses tightly against it.  You try to gather your thoughts, but a particularly forceful hum drives them away and totally relaxes you, allowing the bulbous thickness of her ovipositor to slip inside you.   Slowly at first, then with increasing urgency, the bee-girl rocks it further and further inside of you, humming happily and placing a handful of honey before you.   Your tongue darts forwards of its own accord, lapping at the honey", false);
				if (player.vaginas.length > 0) outputText(" as your hand is guided to your " + player.vaginaDescript(0), false);
				outputText(".\n\n", false);
				//Cum text
				if (player.vaginas.length > 0) outputText("Your fingers dance over your clit as you lap up her honey", false);
				else outputText("Your fingers explore every inch of both your bodies as you lap up her honey", false);
				outputText(", your hips writhing and squirming underneath your insectile lover.  A pressure builds in your ass as fluids begin flowing into your rectum, triggering a body-shaking orgasm that rolls your eyes back into your head.  You come down, but the lust in your veins hasn't dissipated – in fact between being pumped full of honey-spooge", false);
				if (player.vaginas.length > 0) outputText(", the constant aphrodisiac honey you're mindlessly devouring, and your fingers' instinctual ravaging of your " + player.vaginaDescript(0) + ", ", false);
				else outputText(" and the constant aphrodisiac honey you're mindlessly devouring, ", false);
				outputText("you drive yourself to orgasm after orgasm.  For hours you lie there, licking, masturbating, and allowing your backside to be slowly filled with sweet fluid and the occasional bump of what you can only assume is an egg.\n\n", false);
				//Recovery
				outputText("Eventually you realize she is no longer feeding you honey, and the bee-girl pulls her shriveled organ from your rectum.  She pats you on the head and begins to stagger away, honey dripping from between her thighs and her once bloated rear-abdomen now looking more appropriate for her thin frame.", false);
				player.orgasm();
				dynStats("int", -.5);
				player.slimeFeed();
				//Anal bee pregnancy!
				if (rand(3) == 0) player.buttKnockUp(PregnancyStore.PREGNANCY_BEE_EGGS, PregnancyStore.INCUBATION_BEE, 1, 1);
				player.buttChange(25, true);
			}
			if (postCombat)
				combat.cleanupAfterCombat(camp.returnToCampUseFourHours);
			else doNext(camp.returnToCampUseFourHours);
		}
		
		public function beeSexForCocks(clearScreen:Boolean = true):void {
			if (clearScreen) clearOutput();
			spriteSelect(6);
			if (badEndWarning == true && rand(2) == 0) {
				beeDroneBadEnd();
				return;
			}
			var giantCockIndex:int = -1;
			for (var x:int = 0; x < player.cocks.length; x++) {
				if (player.cocks[x].cockLength < 24 || player.cocks[x].cArea() < 100) continue;
				giantCockIndex = x;
				break;
			}
			if (giantCockIndex != -1) {
				outputText("You rush forward, your " + player.cockDescript(giantCockIndex) + " already flopping free of your " + player.armorName + " and growing hard at the prospect of her treatment of it.  When you reach her and wrap your arms around her, its mass is now quite erect and sandwiched tightly between your bodies.  You take a deep breath of the insect maiden’s sweet smell mixed in with the familiar smell of your giant manhood.  She giggles at your expression as you feel your strength drain from your body, and your thoughts fly from your mind.\n\n");
				outputText("She gently sets you down onto the flower onto your back, such that you can sit comfortably and your " + player.multiCockDescriptLight() + " can point straight up.  Your addled mind does notice that the bee seems to be constantly glancing at your massive erection and sneaking touches of it.  She seems incredibly eager for some reason, but is holding herself back.\n\n");
				outputText("She takes one more longing look at your flesh before going to her bag and rummaging around in it.  She takes out a small bottle and looks back at you for a moment, before slipping the bottle into her dripping honeypot.  She straightens up and looks at you once more, her breath coming in short gasps as she runs a finger over her black luscious lips.  <i>“You’re zzzuch a wonderfully big boy!”</i>  she exclaims, <i>“" + (player.cocks[0].cockType == CockTypesEnum.BEE ? "Keep drinking your zzzpezzzial honey and zzzoon you’ll be ready" : "With thizzz zzzpezzzial honey, you’ll zzzoon be even better") + ".”</i>  Given the state of your mind, you can’t do much else other than nod to her.\n\n");
				menu();
				addButton(0, "Next", beeSexForCocksPart2, giantCockIndex);
			}
			else {
				outputText("You throw yourself into her arms and take a deep breath of her sweet smelling honey.  Nothing else matters but the body that has you in its embrace.  Soon the whole of your " + player.skinDesc + " tastes the air around you as your " + player.armorName + " falls away from your body.  Your insectoid lover turns your body to the side in her arms, and sets you sideways atop her legs.\n\n");
				outputText("She gently runs her fingers over your " + player.multiCockDescriptLight() + " gently flicking the tip" + (player.cocks.length > 1 ? "s" : "") + " until you’re rock hard.  She seems to be oddly disappointed by what she sees, gently tapping her lips.  <i>“It lookzzz like you need zzzome zzzpecial honey to grow big and zzztrong.”</i>  It isn’t like you can be indignant at her words though, considering just how messed up in the head her smell and buzzing has made you.  While still absentmindedly stroking your member" + (player.cocks.length > 1 ? "s" : "") + ", she uses her free hand to reach into her bag and extract a small plain looking bottle that she then inserts into her honeypot.\n\n");
				outputText("<i>“Zzztill,”</i> she continues, <i>“you dezzzerve to feel good while I make your honey.”</i> before beginning a much more intense assult on your " + player.multiCockDescriptLight() + " with her dexterous hands.  You can’t help but start panting under her ministrations.  ");
				if (player.cocks.length == 1) {
					outputText("With one hand, she runs her fingers up and down the shaft of your " + player.cockDescript(0) + " while her other hand rubs the tip with the palm of her hand.  <i>“Ah, you like thizzz don’t you?  Juzzzt wait, when it getzzz bigger, it will feel even better,”</i> she whispers in your ear and starts to pump your shaft with her whole hand.  It almost feels like she is trying to force out more length through her pumping alone.  At the same time, her other hand starts to move in more and more rapid circles, quickly pushing you to your limit.\n\n");
				}
				else {
					outputText("Starting with your " + player.cockDescript(0) + ", the bee girl starts stroking your shaft with one hand, while her other hand runs in circles around the tip.  She doesn’t limit her attention to just your leading member though, she is quick eager to lavish the same treatment onto your " + player.cockDescript(1) + " too.  <i>“Hmm, it’zzz hard to get all of you when you’re like thizzz.  It’ll be zzzo much better when you juzzzt have one.”</i>  " + (player.cocks.length > 2 ? "This doesn’t stop her from performing the same treatment on the whole of your " + player.multiCockDescript() + ", alternating between each of your manhoods.  " : "") + "Her hands start to increase the rate of their stimulations, quickly pushing you to your limit.\n\n");
				}
				outputText("In moments, her hands are covered with your usual level of cum, though this gets not much more than a nod of approval from the giver of your pleasure.  She gently sets you to the side of her and pulls the bottle from her lower lips and puts a cork on the bottle before setting it down on your stomach.  <i>“Take thizzz after it hazzz had an hour to zzzet.”</i> she tells you before picking up her bag and flying away.  Thanks to the after effects of her scent, you don’t really have a chance to react before you drift off to sleep for several hours.\n\n");
				player.orgasm();
				dynStats("lib", 3, "cor", -2);
				inventory.takeItem(consumables.SPHONEY, camp.returnToCampUseFourHours);
			}
		}
		
		private function beeSexForCocksPart2(giantCockIndex:int):void {
			clearOutput();
			spriteSelect(6);
			outputText("This is all the encouragement the handmaiden needs, and she leaps forward and wraps her arms around your " + player.cockDescript(giantCockIndex) + ".  She eagerly starts rubbing her large chest up and down your length while using her hands to play with the tip, running them all over it.  Panting, she contiues to give your " + player.cockDescript(giantCockIndex) + " a full body massage, bringing you incredible stimulation.  " + (player.cocks[giantCockIndex].cockLength > 36 ? "Even rubbing her nether lips against the base of your massive member." : "") + "  Her body starts to feel a bit sticky and slick and sometimes catches in places, bringing you to even higher levels of pleasure.\n\n");
			outputText("After a time the bee peeks around your length to look at you, a mock serious look on her face.  <i>“Juzzzt what do you think you’re doing, going around and getting off without a bee?”</i> she says wagging her finger at you.  <i>“It’zzz not healthy, and you could die without proper releazzze.”</i>  She laughs and moves to the side of your member, scooping honey out of her bizarre bee vagina and spreads it onto your oversized prick.  <i>“I mean zzzeriouzzzly, nothing can actually take zzzomething this big but a queen bee,”</i> she continues while gently rubbing the honey into your skin.\n\n");
			if (player.cocks[0].cockType == CockTypesEnum.BEE) {
				outputText("It’s true, the pain in your giant bee cock never really goes away unless you’re feeling honey run over it.  You need the release that the bees offer you to actually escape the intense needs of your new member.  Unless you can find a way to get rid of it, you’re going to have to go to her queen.  It is the only way you’ll be able to survive.\n\n");
				badEndWarning = true; //Player has been warned about the bad end
			}
			else {
				outputText("The honey she spreads onto your " + player.cockDescript(giantCockIndex) + " feels very soothing, while still feeling really, really sexually stimulating.  You don’t think you’ve ever been able to feel anything with your manhood quite so clearly, or so wonderfully then while she is rubbing that honey into you.  <i>“Juzzzt think, zzzoon thizzz can become a real cock and you’ll know what true pleazzzure izzz,”</i> she says giving you a knowing wink.\n\n");
			}
			outputText("Satisfied that your massive member is sufficiently glazed with her sweet fluids, your insectoid dick aficionado moves back around and once again wraps her arms around your massive member.  This time when she starts to pump you, she uses her wings to move much farther up and down your huge length.  After a few minutes of this, you feel yourself reach your peak and let loose a ");
			if (player.cumQ() < 500)
				outputText("splash");
			else if (player.cumQ() < 1500)
				outputText("wave");
			else outputText("torrent");
			outputText(" of cum from the tip of your " + player.cockDescript(giantCockIndex) + ".  Since the bee was at the top of her ride up and down your member, she catches your load full in the face.\n\n");
			outputText("Your first orgasm does nothing to stop the handmaiden’s relentless pumping of your member, and her honey makes sure you’re ready to go again right away.  In fact, it only encourages her.  Next up, she starts to use her long tongue to lick at your fluids around the tip, and eventually slips it into the slit to taste your pre as it comes out.  At the same time, she continues to pump her body against one side of your shaft while letting her arms play across the other side.  This doesn’t let up for hours as she continues to pump you and bring out orgasm after orgasm.\n\n");
			outputText("Eventually the bee’s energy runs out and she lets go of your towering cock while panting.  <i>“You really are zzzomething, you know that?”</i>  she says while reaching down and extracting the bottle from her honeypot.  She puts a cork in the bottle while you feel your member" + (player.cocks.length > 1 ? "s" : "") + " finally start to " + (player.cocks.length == 1 && player.hasSheath() ? "retract into its sheath" : "go flaccid") + ".  <i>“");
			if (player.cocks[0].cockType == CockTypesEnum.BEE) {
				outputText("You know the deal by now,");
			}
			else if (player.race() == "bee-morph") {
				outputText("All you have to do izzz take thizzz after it hazzz had an hour to zzzet and you’ll be a real man!");
			}
			else {
				outputText("If you take lot’zzz of this zzzpecail honey, you’ll be able to become a real man!");
			}
			outputText("”</i> she says handing you the bottle with a wink.  Then she wipes off some of the dried cum from her face, takes her bag, and flies off.  Just before she is out of sight she calls back to you, <i>“I look forward to zzzeeing you again zzzoon!”</i>  After cumming so many times it's no surprise that you wake up hours later, having drifted off to sleep.\n\n");
			player.orgasm();
			dynStats("lib", 2, "sen", 2, "cor", -3);
			inventory.takeItem(consumables.SPHONEY, camp.returnToCampUseFourHours);
		}
		
		private function beeDroneBadEnd():void {
			outputText("Her face breaks into a wide knowing smile.  <i>“Hello again, my fine cocked friend,”</i> she says rising and gently hovering over to you.  <i>“You know, the queen izzz eagerly waiting to meet you.  Zzzhe will be able to take care of you much better than I ever could, but I think we can zzztill zzzpend zzzome time together if you’re up for it.”</i>\n\n");
			outputText("You look at her a bit confused, unsure exactly what she is telling you.  <i>“Zzzzilly boy, I’ve been telling the queen about our meetingzzz, and zzzhe is eager to aczzzzept you into the hive!”</i>  She moves forward and pulls your " + player.armorName + " from your body and gently rubs your " + player.cockDescript(0) + ".  <i>“I told you that only a queen bee could help you with zzzomething thizzz big, and you’ll be able to fill her with it and fertilize all her eggzzz.  Thizzz izzz the releazzze you’ve been craving all thizzz time, come on!”</i>\n\n");
			outputText("Her offer intrigues you incredibly, and you can’t imagine turning her down, not now.  Once, you might have been able to turn away from it, but now that you’ve got this bee prick and have felt the release that bee’s honey gives you, there's just no way.  You nod eagerly to the bee girl and \n\n");
			if (player.wingType == CoC.WING_TYPE_BEE_LIKE_LARGE) {
				outputText("spread your wings.  She takes your hand and before rising up into the air and leading you home.\n\n");
			}
			else {
				outputText("accept the bottle of special honey that she hands you which you down in an instant.  ");
				if (player.wingType == CoC.WING_TYPE_NONE) {
					outputText("At once your back starts to tingle, and a pair of bee wings erupt behind you, they quickly grow large and with a few experimental flaps you find that they can carry your weight.");
				}
				else if (player.wingType == CoC.WING_TYPE_BEE_LIKE_SMALL) {
					outputText("Your wings tingle before suddenly growing much larger.  You test them for a moment finding that they are now big enough to allow you to fly!");
				}
				else {
					outputText("Your " + player.wingDesc + " feel itchy for a moment before falling off entirely.  You don’t have much time to worry about that though, as almost immediately afterwards you sprout a large pair of bee wings that you use to lift yourself into the air.\n\n");
				}
				outputText("  Nodding in approval, the bee girl takes your hand and the two of you fly into the sky, the handmaiden leading you to your new home.\n\n");
			}
			outputText("She takes you high over the trees and for a brief while you get a chance to observe the twisting landscape of the forest below you.  Your observations of the forest don’t last too long, as thoughts of meeting the bee queen soon override your curiosity.  You don’t spare another thought to what might be your last time seeing the outside world.");
			doNext(beeDroneBadEndPart2);
		}
		
		private function beeDroneBadEndPart2():void {
			clearOutput();
			spriteSelect(6);
			outputText("Before too long you reach a large yellow structure that rises out of the trees, built like a layered wedding cake.  There is a strong buzzing sound all around the spire, with swarms of bees darting around, in and out of the it.  Along with the occasional bee girl as well.  <i>“Come on,”</i> your guide says to you after letting you survey the place for a time and leads you to the landing area.  As you set down, a pair of large muscular bee girls armed with spears made of chitin approach the two of you.  <i>“It’zzz okay guardianzzz, the queen azzzked me to bring thizzz boy,”</i> your guide says to them.  One of them sizes you up and looks at you closely while the other gives a few sniffs of the handmaiden’s honeypot.  She then gives a nod to the other one and the guards return to their posts.\n\n");
			outputText("Now free to move on, the two of you move deeper into the bee hive.  The whole place is a rush of activity.  None of the bees are ever seen at rest, humanoid or otherwise.  The small bees are constantly bringing in nectar for the hive, while the humanoid ones are busy turning the stuff into honey, storing it, or guarding the others.  The ones making the honey are really big bees, at least around the middle.  They gorge themselves on the nectar brought by the small bees, and the excrete honey in great quantities out of exaggerated bee womanhoods.  None of them spare you a glance now that you’re inside, they’re completely unlike the relaxed and loving handmaiden you’ve been spending your time with up until now.  Then again, none of them are quite as beautiful or as shapely as her either, so it isn’t like you’re complaining.\n\n");
			outputText("The most interesting thing you see as you continue deeper into the hive is what looks like a nursery of sorts.  Some of the smaller bees you saw flying all over the place before are being mixed into hexagonal tubs of a strange thick fluid being secreted by more bee girls.  These ones have much larger breasts than the other bees you’ve seen, while having almost nothing in the way of hips.  When you first saw the bees, you thought their chest accessories were only for show, but it seems that at least one type has a use for them as the caretakers are filling the tubs with whatever bee milk would be called.  Some of the tubs are being brought off to other parts of the hive.  <i>“They’re being taken off to become new partzzz of the hive,”</i> your companion explains, <i>“and in a few monthzzz, they’ll grow into adult beezzz like me.”</i>  She points at one of the tubs where a red fluid is being mixed in along with the thick stuff, <i>“Thozzze beezzz will become the queenzzz handmaidens. Thozzze onezzz will be guards, those caretakers, and those honeybrewers,”</i> she continues while pointing to other tubs in turn.\n\n");
			outputText("You listen in fascination, but the pain in your massive bee member starts to draw your attention again and you can’t help but put your hands to it.  Your guide gasps when she sees you do so and starts to apologize furiously to you, <i>“I’m zzzoo zzzorry, I got zzzo exzzzited about zhowing you around my home that I forgot why we came here in the firzzzt plazzze.  Come on, thizzz way.”</i>  She leads you to the back of the nursery room and into a sort of grand hallway, filled with bee guards.  The guards eye you uncomfortably, but the presence of your guide seems to keep them placated as you move down the hallway.\n\n");
			doNext(beeDroneBadEndPart3);
		}
		
		private function beeDroneBadEndPart3():void {
			clearOutput();
			spriteSelect(6);
			outputText("When you enter into the queen’s chamber, your senses are assaulted with a multitude of erotic images, sounds, and scents.  There are dozens of bees all in various states of debauchery and sexual escapades.  The females are all very much like your companion, with voluptuous thin bodies, while the males are built a bit different.  While their main bodies are still fairly thin, and they generally have cute androgynous faces, their main feature would be their massive manhoods, which are all easily three to four feet long, and at least five inches in diameter.\n\n");
			outputText("The females outnumber the males at least four to one, but they don’t let that get in the way of having fun.  Most of them are playing with each other in pairs, letting loose all sorts of sexual moans.  Some of the lucky ones have wrapped themselves around a male bee’s large member and are panting in pleasure as they cover those organs with their honey.  For their part, there isn’t a male bee who isn’t giving their own sexual moans of pleasure, either from the attention they’re getting from their handmaiden partner, or more often the queen herself.\n\n");
			outputText("Ah yes, the queen.  The centerpiece of all of this sexual diorama is the queen herself, and everything about her is simply huge.  She stands at least 12 feet tall, probably more.  She has a beautiful but not necessarily delicate build.  If you had to describe her, a slightly thicker scaled up version of your bee companion wouldn’t be too far off when describing everything but her face and abdomen.  Her face is, motherly but stern, regal but still kind.  Just looking into her deep black eyes is enough to set your mind at peace, and the sight of her luscious black lips smiling down at you sends your heart fluttering.  Atop her head is a massive amount of hair done up in an elaborate set of braids, bands, and knots.  Her luscious and beautifully styled black and yellow hair is probably the most beautiful hair you’ve ever seen.\n\n");
			outputText("Her other major feature is her abdomen, and it is probably the most notable part of her.  The thing is nearly as tall as the bee queen’s humanoid body, and just as wide.  It extends at least 30 feet out from the queen’s body.  There are two major factors about her abdomen.  First, is that it is ringed with numerous slits of varying sizes, and given that the majority of the male bees are eagerly and frantically thrusting their massive manhoods into these slits, you’d guess that they’re her vaginas.  Second, is the handmaiden that is currently being screwed by a fairly large phallic stinger on the end of it.  Though, admittedly the eighteen inch long by two and a half inch wide stinger pales in comparison to the phalluses that the male bees have.\n\n");
			outputText("The room is a fairly large dome with a shallow bowl built into the middle of the room.  At the bottom of which rests the queen.  The rest of the bees are scattered about the room.  The only other thing worth mentioning about the place is the smell.  You never noticed until now how most of the hive was free of the incredibly arousing and mind numbing smell of honey that usually surrounds your bee friend, it is back in force in this room.  Not only that, you also just realized that this is the only place you’ve seen male bees, all the workers in the rest of the hive were female.\n\n");
			doNext(beeDroneBadEndPart4);
		}
		
		private function beeDroneBadEndPart4():void {
			clearOutput();
			spriteSelect(6);
			outputText("<i>“Welcome, to my hive, beautiful one!  My daughter hazzz told me about you, and I am delighted to zzzee you before me,”</i> the queen says to you in a breathless voice, her massive breasts heaving as she pants in pleasure.  <i>“You are zzzertainly as pleazzzent to the eyes azzz zhe told me you were.”</i>  You can’t help but shiver in pleasure at her words, but it also brings another spike of pain to your massive member.  <i>“You are eager it zzzeemzzz, though I cannot zzzay that I am not azzz well,”</i> she says in response to your behaviour.  <i>“Come beautiful one, take your plazzze at my side and feel my honey cover your member and bring it zzzweet releazzze.”</i>\n\n");
			outputText("Her words are sweet, sweet honey to your ears, and you need no more encouragement to rush over to one of the free honey dripping slits on her abdomen, and start to push your member inside.  At once the walls contract around your member and start to liberally coat it with the wonderful honey that you needed so much.  The pain immediately leaves your body, and is replaced with a feeling of bliss as you slowly push your massive member further and further into her incredible massive honeypot.\n\n");
			outputText("With each inch you push inside her, the more overwhelming the feeling is of her walls contracting and relaxing around your length.  Along with the flow of her honey washing over you, there is only one answer you have for her next question for you: <i>“Izzz it all that you wanted?”</i>  You respond by pushing yourself in faster, earning a quick gasp of pleasure from your queen.  You can’t help but grin in response, both at the pleasure you brought yourself, and that which you gave your queen.\n\n");
			outputText("Your attention is drawn for a moment by the bee girl who was being screwed by the phallic stinger on the end of the queen’s abdomen.  She is screaming in orgasmic pleasure just as it retracts from her body.  She takes a few breaths to steady herself and then stands up, turning to the side and you get a chance to see that her abdomen has swollen to twice the size it was when you first noticed her.  You feel a hand on your shoulder and look the other way to see the handmaiden that brought you here.  <i>“I hope I get to have your firzzzt batch of eggzzz,”</i> she tells you before moving to the phallic stinger herself.\n\n");
			outputText("<i>“Well, my beautiful lover, you heard what zhe zzzaid.  I hope you come lotzzz for your friend,”</i> the queen says while the stinger moves towards the handmaiden’s honeypot and forces itself inside her.  As the phallus is inserted, a sudden shudder goes through the queens abdomen and finally pushes you over the edge.  Your bee prick erupts with pleasure and you feel your seed flow deep inside the queen’s abdomen, to fertilize her eggs." + (player.cumQ() < 500 ? "  You’re surprised to feel just how much flows out of you, you’ve never cum that much before." : "") + "\n\n");
			outputText("You can’t think anymore, you can only thrust into the wondrous slit in front of you and cum, again and again until you hear a voice cry out in orgasmic pleasure to your side.  You turn to see your handmaiden finish being filled.  She drifts over to you and takes your hand and places it on her swollen abdomen.  <i>“You did a good job, lover.  I hope you can zzztay with uzzz forever, helping the queen fertilize her eggzzz every day.”</i>\n\n");
			outputText("Of course you agree, nothing else in the world matters anymore to you, only this vagina in front of you and the bee whose abdomen you have your hand on can truly bring you the release you need.  You could never turn away from them, nor could you ever turn away from your duty to your queen.  <i>“I’m glad to hear that from you, lover.  Welcome to my hive,”</i> speaks the queen’s voice in your mind.\n\n");
			getGame().gameOver();
		}
		
		//Talk to the bee-girl
		private function beeTalk():void
		{
			clearOutput();
			spriteSelect(6);
			//The first time you only get the option to have eggs laid in your bum ;) BEE_GIRL_TALKED
			if (attitude < BEE_GIRL_TALKED) { //Replaced beeProgress
				outputText("She stops buzzing, taken aback by your resistance to her wiles.  <i>“Y-you zzzure you don't want to cuddle with me?”</i> she stammers, thrusting her exotic black and yellow breasts forwards enticingly.  With some difficulty you manage to pry your eyes back up to her face and ask her why she is trying to tempt you to embrace her.\n\n");
				outputText("She buzzes out a giggle, <i>“Well where elzzz would I lay eggzzz?  The coloniezzz alwayzzz need more workerzzz, and as one of the Queen'zzz handmaidenzzz I get zzzooooo full of eggzzz...  I promizzze to make it feel gooood if you come to me.”</i>\n\n");
				if (player.cor < 33) outputText("You are sure no good can come of this, but your body is ready to say yes.");
				if (player.cor >= 33 && player.cor <= 66) outputText("Her offer intrigues you, and the arousing sweetness of her scent makes it difficult to resist.");
				if (player.cor > 66) outputText("Looking at her through lust-tinted eyes, you're sure she can deliver on her offer.  Getting closer to her scent alone would be worth bearing a few eggs...");
				outputText("\n\nDo you accept her offer?");
				attitude = BEE_GIRL_TALKED; //Replaced beeProgress
				doYesNo(beeEncounterClassic, camp.returnToCampUseOneHour);
			}
			else {
				//If you get lucky, chance for free honey and -corruption in exchange for lust.
				if (rand(2) == 0) {
					outputText("\"<i>Awww, it zzzeemz you've caught me with my 'pants' down,</i>\" she giggles, \"<i>I'm all out of eggzzz.</i>\"  She pats her smaller-sized abdomen for a moment, thinking.\n\nHer eyes light up with inspiration, \"<i>Zzzince I'm ztill zzzo horny, would you like pure undiluted honey? Itzzz very good,</i>\" she says, spreading her legs and exposing the source of the scent – her puffy black vulva dripping with sticky amber fluid.\n\nDo you collect her honey?");
					doYesNo(freeHoneyEvent, camp.returnToCampUseOneHour);
				}
				//If you get unlucky you just get the choice of getting egg-laid.
				else {
					if (attitude == BEE_GIRL_TALKED_AND_LEFT)
						outputText("<i>“You’re back!  Surely you’re here to get eggzzz and honey, right?”</i>\n\n");
					else outputText("She cocks her head and asks, \"<i>You again?  Zzzzurely you've come for more of my honey and eggzzz, no?</i>\"  Lightly caressing her swollen abdomen, you see the dripping knotted appendage begin to drop out next to her stinger.\n\n");
					if (player.cor < 33) outputText("You are sure no good can come of this, but your body is urging you to agree.");
					if (player.cor >= 33 && player.cor <= 66) outputText("Her offer intrigues you, and the arousing sweetness of her scent makes it difficult to resist.");
					if (player.cor > 66) outputText("Looking at her through lust-tinted eyes, you're sure she can deliver on her offer.  Getting closer to her scent alone would be worth bearing a few eggs...");
					outputText("\n\nDo you accept her offer?");
					doYesNo(beeEncounterClassic, beeEncounterRefusedHerEggs);
				}
			}
		}
		
		private function beeEncounterRefusedHerEggs():void {
			spriteSelect(6);
			switch (attitude) {
				case BEE_GIRL_TALKED_AND_LEFT_TWICE:
					outputText("\n\nThe handmaiden stands up on the flower, and puts her hands on her hips.  <i>“Why not?  Thizzz will be abzzzolutly wonderful for you, I promizzze.  Why won’t you aczzzept me?”</i> she pouts through her glossy lips.\n\n");
					outputText("You stop for a moment and wonder exactly why you’ve refused her up until now.  Is it because you are afraid of her and the effect she has on your mind?  Is it because the idea of her eggs inside you is disgusting?  Is it because of your duty as a champion?  Or are you just going to leave her there wondering?");
					dynStats("lus", 5 + player.lib / 25);
					simpleChoices("Afraid", beeEncounterRefusedHerEggsAfraid, "Disgusted", beeEncounterRefusedHerEggsDisgusted, "Duty", beeEncounterRefusedHerEggsDuty, "", null, "Leave", beeEncounterRefusedHerEggsLeave);
					return;
				case BEE_GIRL_TALKED_AND_LEFT:
					attitude = BEE_GIRL_TALKED_AND_LEFT_TWICE; //Same text as for first time you talked and left, just update attitude
					break;
				default: //This handled the first refusal - only BEE_GIRL_TALKED should go to the default
					attitude = BEE_GIRL_TALKED_AND_LEFT;
			}
			outputText("\n\nHer face falls at your refusal, but she makes no move against you.  <i>“Okay, I won’t try to forzzze you, maybe you’ll be more willing next time?”</i>  You give a half hearted chuckle before going back to your camp.");
			dynStats("lus", 5 + player.lib / 25);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function beeEncounterRefusedHerEggsAfraid():void {
			spriteSelect(6);
			attitude = BEE_GIRL_PLAYER_AFRAID;
			outputText("\n\nYou move away from her and explain that it isn’t that you don’t like the idea of bearing the eggs, it’s that you’re afraid of the effect she has on your mind.  You’re uncomfortable that you can’t think clearly around her, and you really can’t agree to anything when you can’t remember it and thus can’t really enjoy it.  She tips her head to the side in surprise, before pursing her glossy lips in worry and saying, <i>“Really?  You mean there are people who don’t like it when they lozzze themzzzelvezzz?  Hmm, maybe I should tell my queen about thizzz.”</i>  She smiles back at you and starts to fly away, before stopping in midair and floating over to you and saying <i>“Come back another time, and maybe I can work out zzzomething you’ll be comfortable with, ok?”</i>");
			dynStats("lus", 5 + player.lib / 25);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function beeEncounterRefusedHerEggsDisgusted():void {
			spriteSelect(6);
			attitude = BEE_GIRL_PLAYER_DISGUSTED;
			outputText("\n\nYou tell her that you find the idea of her laying eggs in you repulsive, and that you’re tired of her trying to constantly tempt you into accepting against your will.  She gives you an annoyed look before stomping her foot down on the flower she is standing on, almost causing her to tumble over to the side while saying, <i>“Fine, ah!”</i> before righting herself with her wings.  <i>“If I ever zzzee you again, you can forget about getting a good time.”</i>  Before directing you away from the clearing.  You smile as you leave, now you don’t have to worry about her song getting to you anymore.");
			dynStats("lus", 5 + player.lib / 25);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function beeEncounterRefusedHerEggsDuty():void {
			spriteSelect(6);
			attitude = BEE_GIRL_PLAYER_DUTY;
			outputText("\n\nYou explain to her that you are a champion of your village, and what that means.  You explain your duty, and that you can’t do anything that might push you away from accomplishing that.\n\n");

			outputText("The bee girl nods and seems to smile in understanding.  <i>“I zzzee, I’m bound to a duty too.  I have to find people to lay my queen’zzz eggzzz.  If you have a duty too, I won’t get in your way, and I won’t forzzze you to carry them.”</i>  You thank the bee girl for her considerations and apologize that you can’t help her more directly.  She smiles at you and says, <i>“That’zzz ok champion; if you ever want to just talk, feel free to come vizzzit.  Our queen is againzzzt the demon, zzzo we will zzzuport you in our heartzzz.”</i>");
			dynStats("lus", 5 + player.lib / 25);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function beeEncounterRefusedHerEggsLeave():void {
			spriteSelect(6);
			outputText("\n\nYou aren’t going to deal with this girl right now, so you just turn and walk away.");
			dynStats("lus", 5 + player.lib / 25);
			doNext(camp.returnToCampUseOneHour);
		}
		
/* Not called anywhere
		private function declineBeeTalk():void
		{
			spriteSelect(6);
			outputText("She pouts and returns to her sing-song buzzing.  Her fingers trace circles between her thighs and the sweet scent intensifies.  You beat a hasty retreat before her efforts overcome your reason.", true);
			dynStats("lus", (20 + player.lib / 15));
			doNext(camp.returnToCampUseOneHour);
		}
*/
		
		private function beeMaidenPlay():void {
			clearOutput();
			spriteSelect(6);
			outputText("You nod to her and walk up to the flower.  She moves a bit to the side and pats the spot next to her.  You first slip out of your " + player.armorName + ", then sit your " + player.assDescript() + " next to her.  ");
			if (player.cor <= 33)
				outputText("You sit there a bit nervously and wonder what she plans to do.");
			else if (player.cor <= 66)
				outputText("You can’t help but feel anticipation at what is coming next.");
			else outputText("You barely keep yourself from jumping her in your excitement, but you manage to stay where you are so she can make the first move.");
			if (player.hasVagina()) {
				outputText("  <i>“Repeat after me.”</i>  She intones before giving a soft buzzing giggle and slips one of her hands into her honey pot and liberally covers it in her private sweetness.  You follow suit slipping your fingers to your " + player.vaginaDescript(0) + " and ");
				if (player.wetness() <= CoC.VAGINA_WETNESS_NORMAL)
					outputText("barely");
				else if (player.wetness() <= CoC.VAGINA_WETNESS_SLICK)
					outputText("easily");
				else outputText("liberally");
				outputText(" cover them with your own fluids.\n\n");
				outputText("She raises her drenched hand, gives it a playful lick, and moves it down to your " + player.vaginaDescript() + " while you do the same to hers.  You gasp as her honey covered lower fingers quickly slip inside your " + player.vaginaDescript(0) + " and start to wriggle around.  You try to focus on matching her stimulations.  While you can hear her gasp in enjoyment from your ministrations, you can barely keep your mind straight let alone match her expert movements.  Keeping your brain from becoming mush becomes especially difficult when she brings her thumb and index finger to your " + player.clitDescript() + ".\n\n");
				if (player.sens < 40)
					outputText("Still, you manage to hold on against the sensations and continue to run your fingers through her honey coated lower lips while hers plow through yours.  It is actually a pretty fun bonding experience, and you feel oddly close to the bee at the end when both of you cum over each others fingers together.");
				else
					outputText("It’s too much, you can’t take it anymore.  Your mind goes blank from the incredible feeling of her ministrations (the honey itself probably doesn’t help either) and you pull your hand out of the bee girl’s honey pot.  You don’t even register her brief disappointment, being too enraptured by your own pleasure.  All you can do is run your honey covered hand all over your body, trying to get as much stimulation as possible.  " + (player.hasBreasts() ? "Paying special attention to your " + player.allBreastsDescript() : "") + ".  In the end, you aren’t sure if it’s the insectoid girl who brings you to mind shattering orgasm or you.");
				dynStats("sens", 0.5);
			}
			else {
				outputText("Your partner seems to be confused for a few moments before letting out a laugh and putting a finger to her lips.  After a moment she starts running her finger around her lower lip while giggling.  <i>“Zzzome zzzilly bee is missing their playing partzzz!  Lookzzz like we’ll have to improvizzze.”</i>\n\n");
				outputText("After thinking for a few moments, you offer to take the lead.  A bit surprised at this, your buzzing friend nevertheless acquiesces.  You tell her to follow your lead and put your finger in your mouth to wet it down.  The bee simply starts swishing her finger inside her mouth instead of around it.  You lift up one of your legs and swing it on top of your partner’s and put your dry arm around her shoulder, while slowly walking your hand down her back.  She giggles again at the feel of your fingers while she brings her own wet hand down your back.  In a short time, your hand has reached her abdomen and is crawling around it to your goal.\n\n");
				outputText("Just having her chitin covered fingers playing around with your " + player.buttDescript() + " feels great, and it’s worth just staying there for a few moments.  Still, best to get to the main course you figure, and move your finger to the edge of her rear entrance.  You gently poke at the entrance to for a moment to help her get ready for your invasive activities.  Your insectoid lover gives no such time to prepare, and simply shoves her wet digit as deep as she can into your " + player.assholeDescript() + ".\n\n");
				outputText("The sudden stimulation is rather jarring, and makes you jam your finger inside her as well, eliciting a rather happy sound from your partner that is something between a buzz and a moan while you feel a spray of honey fly onto your bare crotch.  Fortunately you won’t be left disappointed in this love making session.  Her orgasm brings an odd buzz to her whole body and the feel of her vibrating finger in your depths pushes you well over the edge as well.");
			}
			player.orgasm();
			doNext(beeMaidenConversation);
		}
		
		private function beeMaidenConversation():void {
			clearOutput();
			spriteSelect(6);
			if (conversation > 2 && player.cor > 20) conversation = 2;
			switch (conversation) {
				case  0:
						conversation = 1;
						outputText("After giving you a chance to recover from the ordeal, your chitinous partner turns to you.  <i>“That wazzz fun, wazzzn’t it?  We zzzhoud do thizzz again zzzome time, maybe get to know each other too?”</i> she says before handing you a small bottle filled with honey.  <i>“Zzzome of mine for you, take it.”</i>  With that, she spreads her wings and flies off giving you one last wave.\n\n");
						inventory.takeItem(consumables.PURHONY, camp.returnToCampUseOneHour);
						break;
				case  1:
						conversation = 2;
						outputText("Once you’ve recovered, she gives a happy stretch.  <i>“It’zzz alwayzzz zzzo fun playing with zzzomeone more than onzzze.  Don’t you agree?”</i> she says as she puts one of her arms around your shoulders.  You don’t hesitate to tell her that it certainly was a fun experience.  <i>“Hey, what hive are you from?”</i> she asks you, <i>“Maybe I could come bring you a zzzurprise zzzome time?”</i>  You hesitate for a moment before telling her that you aren’t actually from a hive, you aren’t even actually a full bee girl.  Her eyes go wide before clapping her hand to her forehead in realization, <i>“Right!  Of course, no wonder you zzzeemed a bit off to me.”</i>  Suddenly she freezes, <i>“Zzzomeone is coming, they probably want my eggzzz and honey, let’zzz talk again zzzome other time.”</i>  She hands you another bottle of amber liquid before shooing you off.  You put your " + player.armorName + " back on before going too far.  You turn back just in time to see an imp jump into the bee’s arms.\n\n");
						inventory.takeItem(consumables.PURHONY, camp.returnToCampUseOneHour);
						break;
				case  2:
						conversation = 3;
						outputText("Awhile later your and your partner are leaning back on the flower, relaxing after your frantic lovemaking.  The bee has taken a small white straw out of her bag and offered it to you, but you declined.  She shrugs and takes a long deep breath through it, then exhales for just as long.  <i>“Izzz alwayzzz fun to play with you zzzizzzter.”</i>  You share the sentiment with her.\n\n");
						if (player.cor > 20) {
							outputText("<i>“Zzztill, I wish I could give you a plazzze to zzztay among the rezzzt of our zzzizzzters, but you’re too tainted to hear the zzzong of our great mother.  Maybe zzzome day,”</i> she says sadly.  You tell her not to worry about it too much, it isn’t like you aren’t able to have these rendezvous.  She perks back up and wishes you well as you get dressed, gather up your things, and head back to camp.  However, she doesn’t let you leave until you’ve taken a bottle of her honey.");
						}
						else {
							outputText("<i>“I’ve been thinking zzzizzzter, I feel zzzo bad that you don’t know the joy of hearing the mother’zzz voizzze.”</i>  You look at her confused and ask her what she means.  <i>“All uzzz beezzz can hear the voizzze of our mother, the queen.  It makezzz me feel zzzo bad when I think about how you can’t hear her voizzze.”</i>  She looks down with a sad expression on her face.  You wonder if maybe you should say something to her, but her feelings are so alien to you that you aren’t sure what exactly you should say.\n\n");
							outputText("She looks back up at you with an excited look on her face and hands you another bottle of her honey before saying, <i>“Don’t worry zzzizzzter, I’ll try to think of zzzomthing!”</i>   With that she spreads her wings and flies off.  You’re surprised to see she left so suddenly like that.  Her abdomen is still full of eggs and she left her bag behind (you take a look inside it, but all you find is a bottle of her honey)...  She’ll probably be back for that before too long.  You shrug your shoulders, get dressed, gather up your things, and head back towards camp.\n\n");
						}
						inventory.takeItem(consumables.PURHONY, camp.returnToCampUseOneHour);
						break;
				case  3:
						conversation = 4;
						outputText("After relaxing in a familiar scene once again, you turn to your partner and ask her why she ran off so fast last time that she left her things behind.  She lightly smacks her forehead with both hands before saying, <i>“Oh thatzzz right!  I got zzzomething for you to take.”</i>  She fishes around inside her pack for a moment before extracting something that looks like a soft candy.  A distinctive smell of honey comes off of it, different from the usual honey that comes out of this girl.  <i>“Take thizzz.  It’ll let you hear the voizzze of our mother, and then you won’t ever have to run around without being a part of a hive again.”</i>\n\n");
						outputText("Something about that sounded a bit ominous to you, but nevertheless, will you take the candy and do what she says?");
						doYesNo(beeMaidenFertileBeeBadEnd, beeMaidenConversationRejectCandy);
						break;
				default:
						outputText("You lie down on the flower relaxing after the now familiar feel of having sex with the bee girl.  You’ve done this so many times now, it you sometimes forget how different she is from you.  Predictably when you get back up, she once again presents the honey candy and asks you if you’ll join her hive again.  If you reject it, things are likely to turn out the exact same, but you’re certain that taking it will fundamentally change you.  Will you eat it and follow the bee’s instructions anyway?");
						doYesNo(beeMaidenFertileBeeBadEnd, beeMaidenConversationRejectCandy);
			}
		}
			
		private function beeMaidenFertileBeeBadEnd():void {
			clearOutput();
			spriteSelect(6);
			outputText("You take a deep breath before accepting the candy from your insectoid lover.  It is a small, round and shaped like a teardrop, about an inch long and half an inch thick.  You put it in your mouth.  It is soft and sweet, but has a bit of a sour aftertaste.  After a few moments you feel like your head is spinning, and you lie back down on the flower while the bee moves over you and gently caresses your face with her chitin covered arms.  Suddenly you whole body start to ache, then burn.  You look down at yourself to see what is happening, only to see a layer of black chitin slowly growing across your torso, in the same places as the bee above you!  Looks like you’re turning into a full bee now.\n\n");
			outputText("Your energy rapidly fades as more of your body changes.  <i>“Clozzze your eyezzz,”</i> you hear the girl say.  With the weariness in your body and the intense dizziness you’re feeling, you don’t hesitate to comply.  <i>“Relax, deep even breathzzz.”</i>  You try to steady your breathing while transformation progresses.  It isn’t easy, especially when " + (player.hasVagina() ? "something fundamental about your " + player.vaginaDescript(0) + " changes, and you" : "you feel something split open on your previously bare growing and") + " feel something viscous start to flow out of it.  Thankfully, it isn’t gasps of pain that are making it hard to take deep breaths anymore, but gasps of pleasure.  You can’t wait to feel another part of your body rearrange itself and the experience the rush of new feelings from them.  The sensations from your new honeypot (what else could you call it, really?) in particular are almost overwhelming and every few moments another torrent of honey sprays out.\n\n");
			outputText("Eventually the transformation ends, and you open your eyes again.  The handmaiden then helps you stand back up.  You consider both of your bodies, and find that you have indeed become almost mirror images of one another.  You pull out your lips a bit and find that yes, you now have luscious black lips.  Your whole body is now covered in chitin plating, in same way as the girl across from you.  Finally, you check your womanhood, and find that it is now secreting honey, not unlike the bee maiden’s.  You are a bit surprised to find that the honey’s scent doesn’t seem to be affecting you anymore.  At least not as strongly as before.\n\n");
			outputText("\”<i>Come on,”</i> the bee girl says in an excited voice while lifting into the air, <i>“it’zzz time to go meet the queen!”</i>  You spread your bee wings as well, and follow after her.  She takes you high over the trees and for a brief while you get a chance to observe the twisting landscape of the forest below you.  Your observations of the forest don’t last too long, as thoughts of meeting the bee queen soon override your curiosity.  The anticipation of getting to your new home is almost palpable.");
			doNext(beeMaidenFertileBeeBadEndPart2);
		}
		
		private function beeMaidenFertileBeeBadEndPart2():void {
			clearOutput();
			spriteSelect(6);
			outputText("Before too long you reach a large yellow structure that rises out of the trees, built like a layered wedding cake.  There is a strong buzzing sound all around the spire, with swarms of bees darting around, in and out of it.  Along with the occasional bee girl as well.  <i>“Come on,”</i> your guide says to you after letting you survey the place for a time and leads you to the landing area.  As you set down, a pair of large muscular bee girls armed with spears made of chitin approach the two of you.  <i>“It’zzz okay guardianzzz, thizzz one just took our queen’s honey,”</i> your guide says to them.  One of them sizes you up and then leans down to examine your genitals while the other gives a few sniffs of the handmaiden’s honeypot.  They nod to one another and return to their posts.\n\n");
			outputText("Now free to move on, the two of you move deeper into the bee hive.  The whole place is a rush of activity.  None of the bees are ever seen at rest, humanoid or otherwise.  The small bees are constantly bringing in nectar for the hive, while the humanoid ones are busy turning the stuff into honey, storing it, or guarding the others.  The ones making the honey are really big bees, at least around the middle.  They gorge themselves on the nectar brought by the small bees, and the excrete honey in great quantities out of exaggerated bee womanhoods.  None of them spare you a glance now that you’re inside, they’re completely unlike the relaxed and loving handmaiden you’ve been spending your time with up until now.  Then again, none of them are quite as beautiful or as shapely as her either, so it isn’t like you’re complaining.\n\n");
			outputText("The most interesting thing you see as you continue deeper into the hive is what looks like a nursery of sorts.  Some of the smaller bees you saw flying all over the place before are being mixed into hexagonal tubs of a strange thick fluid being secreted by more bee girls.  These ones have much larger breasts than the other bees you’ve seen, while having almost nothing in the way of hips.  When you first saw the bees, you thought their chest accessories were only for show, but it seems that at least one type has a use for them as the caretakers are filling the tubs with whatever bee milk would be called.  Some of the tubs are being brought off to other parts of the hive.  ”</i>They’re being taken off to become new partzzz of the hive,”</i> your companion explains, <i>“and in a few monthzzz, they’ll grow into adult beezzz like me.”</i>  She points at one of the tubs where a red fluid is being mixed in along with the thick stuff, <i>“Thozzze beezzz will become the queenzzz handmaidens.  Thozzze onezzz will be guards, those caretakers, and those honeybrewers.”</i> she continues while pointing to other tubs in turn.\n\n");
			outputText("You listen in fascination as she explains the inner workings of the hive, already feeling at home amongst the hustle and bustle within.  Eventually, your guide leads you to the back of the nursery room and into a sort of grand hallway, filled with bee guards.  The guards eye you uncomfortably, but the presence of your guide seems to keep them placated as you move down the hallway.  <i>“Thizzz izzz the lazzzt zzztop on our tour, and it’zzz my favorite part of the hive.”</i> she tells you as you reach the end of the hall, and you move into the room beyond.");
			doNext(beeMaidenFertileBeeBadEndPart3);
		}
		
		private function beeMaidenFertileBeeBadEndPart3():void {
			clearOutput();
			spriteSelect(6);
			outputText("When you enter into the queen’s chamber, your senses are assaulted with a multitude of erotic images, sounds, and scents.  There are dozens of bees all in various states of debauchery and sexual escapades.  The females are all very much like your companion, with voluptuous thin bodies, while the males are built a bit different.  While their main bodies are still fairly thin, and they generally have cute androgynous faces, their main feature would be their massive manhoods, which are all easily three to four feet long, and at least five inches in diameter.\n\n");
			outputText("The females outnumber the males at least four to one, but they don’t let that get in the way of having fun.  Most of them are playing with each other in pairs, letting loose all sorts of sexual moans.  Some of the lucky ones have wrapped themselves around a male bee’s large member and are panting in pleasure as they cover those organs with their honey.  For their part, there isn’t a male bee who isn’t giving their own sexual moans of pleasure, either from the attention they’re getting from their handmaiden partner, or more often the queen herself.\n\n");
			outputText("Ah yes, the queen.  The centerpiece of this sexual diorama is the queen herself, and everything about her is simply huge.  She stands at least 12 feet tall, probably more.  She has a beautiful but not necessarily delicate build.  If you had to describe her, a slightly thicker scaled up version of your bee companion wouldn’t be too far off when describing everything but her face and abdomen.  Her face is motherly but stern, regal but still kind.  Just looking into her deep black eyes is enough to set your mind at peace, and the sight of her luscious black lips smiling down at you sends your heart fluttering.  Atop her head is a massive amount of hair done up in an elaborate set of braids, bands, and knots.  Her luscious and beautifully styled black and yellow hair is probably the most beautiful hair you’ve ever seen.\n\n");
			outputText("Her other major feature is her abdomen, and it is probably the most notable part of her.  The thing is nearly as tall as the bee queen’s humanoid body, and just as wide.  It extends at least 30 feet out from the queen’s body.  There are two major factors about her abdomen.  First, it's ringed with numerous slits of varying sizes, and given that the majority of the male bees are eagerly and frantically thrusting their massive manhoods into these slits, you’d guess that they’re her vaginas.  Second, there is a handmaiden that is currently being screwed by a fairly large phallic stinger on the end of it.  Though, admittedly the eighteen inch long by two and a half inch wide stinger pales in comparison to the phalluses that the male bees have.\n\n");
			outputText("The room is a fairly large dome with a shallow bowl built into the middle of the room, at the bottom of which rests the queen.  The rest of the bees are scattered about the room.  The only other thing worth mentioning about the place is the smell.  You never noticed until now how most of the hive was free of the incredibly arousing and mind numbing smell of honey that usually surrounds your bee friend, but it is back in force in this room.  Not only that, you also just realized that this is the only place you’ve seen male bees, all the workers in the rest of the hive were female.");
			doNext(beeMaidenFertileBeeBadEndPart4);
		}
		
		private function beeMaidenFertileBeeBadEndPart4():void {
			clearOutput();
			spriteSelect(6);
			outputText("<i>“Welcome,”</i> an overwhelming voice speaks into your mind.  <i>“I’ve been waiting for you to arrive, child.”</i>  The queen looks down at you smiling.  <i>“You are confused, I see.  That candy that my daughter gave you was made from my honey.  It lets me connect our minds together, and make you a true member of our hive.”</i>  Her presence alone feels so powerful, like it could blow you away in an instant.\n\n");
			outputText("Some small part of you panics for a moment before her will does indeed sweep through you, and blasts away everything that you once were in almost an instant.  Her will wraps around you in a tight embrace, like that of a parent who is just seeing their child again after being away for a long time.  <i>“Welcome my new daughter.”</i>  Her voice calls out in both a comforting and commanding voice.  <i>“A a member of my hive, I promise you the same promise I give all my daughters: a safe life and a life full of satisfying work.”</i>\n\n");
			outputText("Your attention is drawn for a moment by the bee girl who was being screwed by the phallic stinger on the end of the queen’s abdomen.  She is screaming in orgasmic pleasure just as it retracts from her body.  She takes a few breaths to steady herself and then stands up, turning to the side and you get a chance to see that her abdomen has swollen to twice the size it was when you first noticed her.  You feel a hand on your shoulder and look the other way to see the handmaiden that brought you here.  <i>“Go on, it’zzz your turn to be filled.”</i>\n\n");
			outputText("You nod and walk over to the sizable tool, contemplating what it will be like to be filled by it.  You don’t get much chance to think about it, as the queen promptly takes it upon herself to jam the thing inside your honeypot.  You shrike in surprise and pleasure from the sudden intruder filling your body.  Your legs quickly fail you, and you topple over, thankfully your girlfriend catches you before you hit the floor.  You don’t pay much attention though, you’re too busy seeing white from the intense penetration going on between your legs.\n\n");
			outputText("The queen’s ovipositor soon starts to unload huge amounts of bee eggs deep into your womb, filling you up.  You cum at once, this is what you were meant to do.  This is what you want to spend your whole life doing.  It feels so damn good to be filled up by the queen, and her satisfaction at the sentiment within your mind only makes it better.\n\n");
			outputText("Another orgasm passes through your body, and you look down to see your filled up belly, and pat it proudly.  However, you find that your belly is unchanged, the eggs are missing!  You quickly share your panic with the girl holding you, and she just laughs.  <i>“Look zzzilly, the eggzzz are right here.”</i> she puts your hand to your abdomen, and you feel how bloated it has become.  In fact, when you feel that it is still growing, your body is pushed over the edge of another orgasm.\n\n");
			outputText("It doesn’t take much longer for the process of being filled with the queen’s eggs to finish, and the stinger is retracted from your body.  You pant, exhausted from the ordeal, and your companion leads you to the side of the room, just as another bee girl moves up to take your place.  You look at your friend and ask her what happens next.  <i>“Next?  We go out into the forezzzt, zzzo zzzomeone who wantzzz our eggzzz can come and be filled.  Then we come back for more.”</i>  She then indicates the other girls and drones fornicating around the room.  <i>“Though, I’ll tell you what, how about we zzzpend zzzome time playing around after I help you lay your firzzzt zzzet of eggzzz, okay?”</i>  That sounds pretty good to you, and you spend the rest of the day doing just that.");
			doNext(beeMaidenFertileBeeBadEndPart5);
		}
		
		private function beeMaidenFertileBeeBadEndPart5():void {
			clearOutput();
			spriteSelect(6);
			outputText("As a member of the fertile cast within the bee hive, the days run together, and the once-champion’s life is filled with nothing but eggs, and playing with the drones and other members of the fertile cast.  Just as her older sister, the young bee will one day tempt another champion to their embrace and fill them with the eggs of their hive.  They won’t even be able to comprehend that their latest incubator wouldn’t have been willing if it hadn’t been for her siren’s song.  Nor will they spare any head to the critical mission that they sent out to accomplish all those months ago.  Nothing of her old self remains now.\n\n");
			getGame().gameOver();
		}
		
		private function beeMaidenConversationRejectCandy():void {
			outputText("\n\nSomething about this whole thing just felt off to you, so you turn her down.  She almost bursts into tears.  <i>“But why?  Why do you want to be zzzo lonely?  I don’t underzzztand!”</i>  You try to offer up an explanation, but after a little while it’s clear that the two of you have fundamentally different mindsets.  To her, the most horrible thing imaginable is to not be a part of a hive, and it’s unlikely that you’ll be changing her opinion any time soon.  In the end all you can tell her that she’ll accept is that you don’t want this right now, but you hope you can continue your loving rendezvous if she’s feeling up to it.  She does perk up at this and gives you a nod, <i>“Okay, I’ll zzzee you around then.”</i>  Before you once again " + player.clothedOrNaked("put your " + player.armorName + " back on and ") + "head away from her flower.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function freeHoneyEvent():void
		{
			spriteSelect(6);
			player.slimeFeed();
			outputText("You mull her offer over for a moment before deciding to pursue the sweet nectar dripping from her exposed sex.  She leans back in her flower, spreading her legs obscenely and pulling an empty vial out from a tiny pack that sits on the ground.\n\n", true);
			outputText("\"<i>Here, take thizzz,</i>\" she says, handing you the crystal vial, \"<i>When I cum you will want to zzzave the excess honey... once it has cooled, it will be able to do amazzzing thingzzz to... for you.</i>\"\n\n", false);
			outputText("You take the vial absently as you kneel between her legs and take in deep breaths of the scent.  It fills your head and groin with its warmth and sticky sweetness.  You part your lips, leaning ever closer to her delicate flower, tensing with anticipation.  When your tongue finally meets the slickened surface of her vulva you swoon.  The taste is better than anything you've ever experienced - sweet, pure, and yet totally sexual.  You dart over her clit, and are rewarded with a burst of heavenly sweetness.  The maddening taste of her ambrosia gets in your veins – you NEED more and you attack her honeypot mercilessly, until at last she squeals in orgasm, clamping her fuzz-covered thighs around your head.\n\n", false);
			outputText("The force of her orgasm splatters you with the honey, far more than you could possibly try to lap up. You dimly remember the vial she gave to you, and steady it under the dripping fluid.  You catch as much of her sweetness as you can while still mashing your face against her quivering cunt.  You are in heaven, but after a time she pushes you back, smiling contentedly.  Her free hand offers you a small cork.   You reluctantly accept it and cap off the pure honey to save for later.\n\n", false);
			outputText("She waves and stretches, picking up her pack and buzzing her wings as she takes off.  She blows a kiss over her shoulder and flies away, leaving you to return to your camp...", false);
			inventory.takeItem(consumables.PURHONY, camp.returnToCampUseOneHour);
		}

		private function seduceBeeGirl():void
		{
			spriteSelect(6);
			//UNFINISHED - low priority male/female variants
			if (player.gender == 3) {
				outputText("Panting, your arousal evident, you stand defiant before the bee-girl. She looks at you quizzically, shifting her head ot the side. You feel the pheromones thicken in the air, the desire to surrender yourself to her rising. You bite it back and steel yourself, your willpower coming through.  Surprisingly, the bee-girl smiles.  Her stance becomes relaxed, and she begins to walk towards you.  You shift your guard slightly, on edge, yet losing a bit of tension.  ", false);
				outputText("As she draws near you see her smile at you and you feel the genuine warmth in it. She brings her hand to your cheek, gently caressing it before leaning in to kiss you. You relax fully, your hands resting on her hips as you return the kiss. She breaks it, still smiling. Her hand trails down your chest, cupping your breast briefly before ", false);
				if (player.isTaur()) outputText(" leaning between your knees to reach your bulging member.\n\nShe drops to her own knees, gazing at your " + player.cockDescript(0) + " before", false);
				else outputText(" continuing , sliding to the front of your pants to feel your bulging member.\n\nShe falls to her knees, sliding your cock free before", false);
				outputText(" running her tongue over the length. She slips her lips over the tip, gently sucking before sliding it entirely into her mouth. You can do little but moan, your hands gripping her head as she sucks and licks. Her hands squeeze the base of your shaft, stroking it", false);
				if (player.balls > 0) outputText(", sliding down and over your balls,", false);
				outputText(" until her fingers begin to play with the lips of your pussy. A groan escapes your open mouth as she slides a finger inside, your pussy clenching tightly and dribbling juices onto her hands.\n\n", false);
				outputText("Pulling back, she releases your " + player.cockDescript(0) + ", now slick with her saliva. She lies on her back, her legs spread wide with he abdomen laying flat against the ground. Her hands urge you forward, and you follow immediately. Her body is soft and accepting, and you quickly slide the head of your " + player.cockDescript(0) + " into her pussy lips, a mutual moan escaping from both of your lips. Pushing further in, the bee-girl wraps her arms around you, holding you against her as you begin to thrust. Each push makes her wetter, the slickness making your cock slide faster and faster. She arches her back and you feel the tip of her stinger against your " + player.vaginaDescript(0) + ". Before you can protest, it pushes in, gently but quickly, until it pierces your cervix.\n\n", false);
				outputText("You cry out as she releases her aphrodisiac venom directly into your deepest recess, flooding you with warmth. You kiss her, your tongues playing against each other as you increase the pace of your thrusts, pushing deeper and deeper inside of her. The bee-girl starts to grunt and groan, her body tensing as effort plays over her face.  ", false);
				//UNUSED OPTION VAG PREGGERS
				//outputText("You can feel pressure building against your pussy lips, her stinger bulging as something slips inside of you. Gasping, you feel it push deeper and deeper inside, until it finaly deposits itself into your womb, the heavy feeling oddly comforting.  ", false);
				//outputText("Each of your thrusts is coupled with pushing your hips down as you draw back, your pussy eagerly accepting the eggs as the bee-girl forces them inside you.  Your womb bulges from your stomach with the sheer number.  ", false);
				outputText("You can feel a pressure rising from the base of your cock. Thrusting deeply, you let out a howl as you cum, your cock spilling forth its sticky load into her, filling her pussy to the brim with your fluid.  ", false);
				outputText("Panting, you collapse onto her, as your cock finally stops twitching. Kissing you again, the bee-girl slides from beneath you and stands. She holds her stomach while a large smile plays on her face. You smile back at her as a feeling of contentment washes over you. You have no regrets as you part.", false);
				player.slimeFeed();
				player.orgasm();
			}
			doNext(camp.returnToCampUseOneHour);
		}

		public function beeRapesYou():void
		{
			spriteSelect(6);
			clearOutput();
			flags[kFLAGS.BEE_GIRL_COMBAT_LOSSES]++;
			if (doSFWloss()) return;

			var sexed:Boolean = false;
			//Centaur lost to giant bee:
			if (player.isTaur()) {
				//Damage:
				if (player.HP < 1) {
					outputText("The bee-girl smirks at you and approaches. Her chitin covered hand slides along your flank and you shiver with anticipation. She slaps your haunch, hard, and you reflexively buck. Displeased, she gives you a shove and you run into a tree. A honey covered hand is rammed inside your " + player.assholeDescript() + " and you grab the tree for support.\n\n", false);

					outputText("She tests the insides of your ass for a bit before pulling her arm out. She knocks out your hind legs and you land hard, your front ones not capable of holding the weight and your grip on the tree is too weak to provide much help.\n\n", false);

					outputText("With you thoroughly incapacitated, she walks up to your front and smears your " + player.chestDesc() + " with honey. The scent wafts up to your nose and your mind begins to go blank. Your tongue tries to reach for the sweet substance, but can't. You whimper at her, desperate for the taste of the mind altering honey. She obliges you by splashing some onto your face and you quickly begin lapping at it with your tongue.\n\n", false);
					//Male with testicles:
					if (player.gender == 1 && player.balls > 0) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing " + player.sMultiCockDesc() + " to go rock hard.\n\n", false);
						outputText("She can't see that, of course, and busies herself with something on your back. A loud unpleasant buzzing fills the air and you manage to break free of the control of the honey long enough to twist around.\n\n", false);

						outputText("Your stomach churns as you see four more bee maidens appear out of the undergrowth, stingers exposed and glistening with a clear fluid. The bee on your back stabs with her own stinger and you turn away again, desperately licking at the honey in an attempt to deal with the awful heat in your lower body.\n\n", false);

						outputText("Chitin covered arms begin stroking and scraping at you as you close your eyes as hard as possible, having exhausted your face of the mind numbing honey. Your pain and lust filled mind comes up with an idea and you quickly act; rubbing your sticky " + player.chestDesc() + " against the tree before swinging your head down violently and gnawing at it.\n\n", false);

						outputText("The sensation proves too much for your massively engorged " + Appearance.cockNoun(player.cocks[0].cockType) + " to take and you begin to shake violently, incapable of touching it as it's trapped underneath you and the weight of the bee-girls preventing you from getting the leverage needed to hump the hard ground.\n\n", false);

						outputText("They seem to understand your problem though and, more out of a desire to not get tossed off than to help you with your needs, begin to kick at your " + player.ballsDescriptLight() + " with their feet.\n\n", false);

						outputText("You shudder and shake as the painful beating continues, your balls burning with pent up seed and your cock writhing under the combined weight atop it. You sigh with relief as you feel your testicles release their load, but it can't escape: <b>your urethra is constricted too much</b>!\n\n", false);

						outputText("The pain and combined venom utterly overwhelms you, and you black out while the bees atop and around you continue to buzz with seemingly malicious intent.\n\n", false);
						//[If huge cum amount:
						if (player.cumQ() > 1500) {
							outputText("You awake in a massive puddle of cum, the scent so strong that it almost causes you to pass out again. You manage to stay conscious long enough to stagger to your hooves and wobbly walk away, grasping trees to steady yourself.\n\n", false);
							outputText("Despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						}
						//[All other cum amounts:
						else {
							outputText("You awake in a puddle of cum, the scent wafting up to you and making your stomach churn. You manage to settle it and stagger to your hooves, wobbly walking away using trees to steady yourself.\n\n", false);
							outputText("Despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						}
						player.orgasm();
						dynStats("int", -.5);
					}
					//[Male without testicles:
					else if (player.gender == 1 && player.balls == 0) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing " + player.sMultiCockDesc() + " to go rock hard.\n\n", false);

						outputText("She can't see that, of course, and busies herself with something on your back. A loud unpleasant buzzing fills the air and you manage to break free of the control of the honey long enough to twist around.\n\n", false);

						outputText("Your stomach churns as you see four more bee maidens appear out of the undergrowth, stingers exposed and glistening with a clear fluid. The bee on your back stabs with her own stinger and you turn away again, desperately licking at the honey in an attempt to deal with the awful heat in your lower body.\n\n", false);

						outputText("Chitin covered arms begin stroking and scraping at you as you close your eyes as hard as possible, having exhausted your face of the mind numbing honey. Your pain and lust filled mind comes up with an idea and you quickly act; rubbing your sticky " + player.chestDesc() + " against the tree before swinging your head down violently and gnawing at it.\n\n", false);

						outputText("The sensation proves too much for your massively engorged " + Appearance.cockNoun(player.cocks[0].cockType) + " to take and you begin to shake violently, incapable of touching it as it's trapped underneath you and the weight of the bee-girls preventing you from getting the leverage needed to hump the hard ground.\n\n", false);

						outputText("They seem to understand your problem though and, more out of a desire to not get tossed off than to help you with your needs, begin to kick at where your balls ought to be with their feet.\n\n", false);

						outputText("The combination of the lust filled poisons, pain and shame at your utter defeat and humiliation drive you to black out, welcoming the blissful darkness.\n\n", false);
						outputText("When you awake, despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						dynStats("int", -.5, "lus=", 100);
					}
					//[Female:
					else if (player.gender == 2) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing your " + player.vaginaDescript(0) + " to squirt fluid behind you.\n\n", false);

						outputText("She pays no attention to that though, and busies herself with something on your back. A loud unpleasant buzzing fills the air and you manage to break free of the control of the honey long enough to twist around.\n\n", false);

						outputText("Your stomach churns as you see four more bee maidens appear out of the undergrowth, stingers exposed and glistening with a clear fluid. The bee on your back stabs with her own stinger and you turn away again, desperately licking at the honey in an attempt to deal with the awful heat in your lower body.\n\n", false);

						outputText("Chitin covered arms begin stroking and scraping at you as you close your eyes as hard as possible, having exhausted your face of the mind numbing honey. Your pain and lust filled mind comes up with an idea and you quickly act; rubbing your sticky " + player.chestDesc() + " against the tree before swinging your head down violently and gnawing at it.\n\n", false);

						outputText("The sensation proves too much for your massively engorged " + player.clitDescript() + " to take and you begin to shake violently, incapable of touching it as it's trapped underneath you and the weight of the bee-girls preventing you from getting the leverage needed to hump the hard ground.\n\n", false);

						outputText("They seem to understand your problem though and, more out of a desire to not get tossed off than to help you with your needs, begin to kick at where your balls ought to be with their feet. A handful of blows land on your " + player.clitDescript() + " and you cum hard, squirting behind you with surprising force.\n\n", false);

						outputText("The malevolent bee-girls continue their ministrations though, delighting in the way your body is reacting. The combination of the lust filled poisons, pain and shame at your utter defeat and humiliation drive you to black out, welcoming the blissful darkness.\n\n", false);
						//[If huge cum amount:
						if (player.wetness() == 5) {
							outputText("You awake in a massive puddle of femcum, the scent so strong that it almost causes you to pass out again. You manage to stay conscious long enough to stagger to your hooves and wobbly walk away, grasping trees to steady yourself.\n\n", false);
							outputText("Despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						}
						//[All other cum amounts:
						else {
							outputText("You awake in a puddle of femcum, the scent wafting up to you and making your stomach churn. You manage to settle it and stagger to your hooves, wobbly walking away using trees to steady yourself.\n\n", false);
							outputText("Despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						}
						dynStats("int", -.5, "lus=", 100);
					}
					//[Herm:
					else if (player.gender == 3) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing " + player.sMultiCockDesc() + " to go rock hard and your " + player.vaginaDescript(0) + " to squirt fluid behind you.\n\n", false);

						outputText("She can't see your cock, of course, and pays no attention to your outbursts of fluid, instead busying herself with something on your back. A loud unpleasant buzzing fills the air and you manage to break free of the control of the honey long enough to twist around.\n\n", false);

						outputText("Your stomach churns as you see four more bee maidens appear out of the undergrowth, stingers exposed and glistening with a clear fluid. The bee on your back stabs with her own stinger and you turn away again, desperately licking at the honey in an attempt to deal with the awful heat in your lower body.\n\n", false);

						outputText("Chitin covered arms begin stroking and scraping at you as you close your eyes as hard as possible, having exhausted your face of the mind numbing honey. Your pain and lust filled mind comes up with an idea and you quickly act; rubbing your sticky " + player.chestDesc() + " against the tree before swinging your head down violently and gnawing at it.\n\n", false);

						outputText("The sensations prove too much for your massively engorged " + Appearance.cockNoun(player.cocks[0].cockType) + " and sopping " + player.vaginaDescript(0) + " to take and you begin to shake violently, incapable of touching it as one is trapped underneath you with the weight of the bee-girl preventing you from getting the leverage needed to hump the hard ground and the other is hopelessly out of reach.\n\n", false);

						outputText("They seem to understand your problem though and, more out of a desire to not get tossed off than to help you with your needs, begin to kick and punch at your " + player.vaginaDescript(0), false);
						if (player.balls > 0) outputText(" and " + player.ballsDescriptLight(), false);
						outputText(".\n\n", false);

						outputText("A handful of blows land on your " + player.clitDescript() + " and you cum hard, squirting behind you with surprising force and splattering your underside with jism. The malevolent bee-girls continue their ministrations though, delighting in the way your body is reacting. The combination of the lust filled poisons, pain and shame at your utter defeat and humiliation drive you to black out, welcoming the blissful darkness.\n\n", false);
						//[If huge cum amount:
						if (player.cumQ() > 1500 || player.wetness() >= 5) {
							outputText("You awake in a massive puddle of various sexual fluids, the scent so strong that it almost causes you to pass out again. You manage to stay conscious long enough to stagger to your hooves and wobbly walk away, grasping trees to steady yourself.\n\n", false);
							outputText("Despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						}
						//[All other cum amounts:
						else {
							outputText("You awake in a puddle of various sexual fluids, the scent wafting up to you and making your stomach churn. You manage to settle it and stagger to your hooves, wobbly walking away using trees to steady yourself.\n\n", false);
							outputText("Despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						}
						dynStats("int", -.5, "lus=", 100);
					}
					//[Genderless:
					else {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing your " + player.assholeDescript() + " to wink.\n\n", false);
						outputText("She can't see your " + player.assholeDescript() + ", of course, and pays no attention to your outbursts, instead busying herself with something on your back. A loud unpleasant buzzing fills the air and you manage to break free of the control of the honey long enough to twist around.\n\n", false);
						outputText("Your stomach churns as you see four more bee maidens appear out of the undergrowth, stingers exposed and glistening with a clear fluid. The bee on your back stabs with her own stinger and you turn away again, desperately licking at the honey in an attempt to deal with the awful heat in your lower body.\n\n", false);

						outputText("Chitin covered arms begin stroking and scraping at you as you close your eyes as hard as possible, having exhausted your face of the mind numbing honey. Your pain and lust filled mind comes up with an idea and you quickly act; rubbing your sticky " + player.chestDesc() + " against the tree before swinging your head down violently and gnawing at it.\n\n", false);

						outputText("The sensations prove too much for you to take and you begin to shake violently, incapable of alleviating the awful pressure in your rear.\n\n", false);

						outputText("They seem to understand your problem though and, more out of a desire to not get tossed off than to help you with your needs, begin to kick and punch at your " + player.assDescript() + ". The volley of blows is enough to stop you from shaking, but the pressure doesn't go away.\n\n", false);

						outputText("The malevolent bee-girls continue their ministrations though, delighting in the way your body is reacting. The combination of the lust filled poisons, pain and shame at your utter defeat and humiliation drive you to black out, welcoming the blissful darkness.\n\n", false);
						outputText("You awake in a couple of hours and stagger to your hooves, wobbly walking away using trees to steady yourself.  Despite everything, you realize that you feel oddly good; a warm tingling sensation ripples through your whole body every time you move and the pain from the stingers appears to have disappeared entirely. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
						dynStats("int", -.5, "lus=", 100);
					}
				}
				//Lust:
				else {
					outputText("The bee-girl smiles at you and sways her hips sensuously as she approaches. Her chitin covered hand slides along your flank and you shiver with anticipation. She slaps your haunch gently, and you feel your anticipation grow. Pleased, she guides you toward a tree before gently sliding a honey covered hand inside your " + player.assholeDescript() + ", causing you to grab the tree for support.\n\n", false);
					outputText("She tests the insides of your ass for a bit before pulling her arm out and your hind legs start to quake as your desires aren't satisfied. You feel her stroke your hindquarters, encouraging you to lie down. You happily do so, using the tree as support.  With you safely down, she walks up to your front and smears your " + player.chestDesc() + " with honey. The scent wafts up to your nose and your mind begins to go blank. Your tongue tries to reach for the sweet substance, but can't. You whimper at her, desperate for the taste of the mind altering honey. She obliges you by holding a handful of the thick elixir to your mouth and you lap at it eagerly. Once you've consumed a fair amount she spreads more onto your face and giggles cutely as you stretch your tongue to lick at it.\n\n", false);
					//[Male with testicles:
					if (player.gender == 1 && player.balls > 0) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing " + player.sMultiCockDesc() + " to go rock hard.\n\n", false);

						outputText("She can't see that, of course, and busies herself with inserting her ovipositor into your " + player.assholeDescript() + ". Its thick lubrication allows it quick entrance, and soon she's pumping her fluids into your bowels. The sensation proves too much for your massively engorged " + player.multiCockDescriptLight() + " to take and you begin to shake violently, incapable of touching ", false);
						if (player.cockTotal() == 1) outputText("it as it's ", false);
						else outputText("them as they're ", false);
						outputText("trapped underneath you, the weight of the bee-girl preventing you from getting the leverage needed to hump the hard ground.\n\n", false);

						outputText("She seems to understand your problem though and, wanting to help you with your needs, begins to massage your " + player.ballsDescriptLight() + " with her 'feet'. As she does this she starts to hum, a sound that obliterates what few thoughts you had left and which causes her entire body to vibrate.\n\n", false);

						outputText("The amazingly peculiar vibrations and surprisingly adept massage is more than enough to get you off and you cum hard, splattering your underside.\n\n", false);
						//[If huge cum amount:
						if (player.cumQ() >= 1500) outputText("Your massive cum amount soon causes you to be lying in a deep puddle of splooge, the scent so strong that it's almost enough to overwhelm that of the honey, despite it coating your face.\n\n", false);
						outputText("She continues pumping into you as you pass out, " + player.sMultiCockDesc() + " and " + player.ballsDescriptLight() + " aching.  The combined scent of cum and honey completely overwhelms you.", false);
					}
					//[Male without testicles:
					else if (player.gender == 1) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing " + player.sMultiCockDesc() + " to go rock hard.\n\n", false);
						outputText("She can't see that, of course, and busies herself with inserting her ovipositor into your " + player.assholeDescript() + ". Its thick lubrication allows it quick entrance, and soon she's pumping her fluids into your bowels. The sensation proves too much for your massively engorged " + Appearance.cockNoun(player.cocks[0].cockType) + " to take and you begin to shake violently, incapable of touching it as it's trapped underneath you, and the weight of the bee-girl prevents you from getting the leverage needed to hump the hard ground.\n\n", false);
						outputText("She seems to understand your problem though and, wanting to help you with your needs, begins to massage the area where your balls should be with her 'feet'. As she does this she starts to hum, a sound that obliterates what few thoughts you had left and which causes her entire body to vibrate, more than enough to get you to cum hard.\n\n", false);
						outputText("She continues pumping into you as you pass out, " + player.sMultiCockDesc() + " aching and the scent of honey overwhelming you.\n\n", false);
					}
					//[Female:
					else if (player.gender == 2) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing your " + player.vaginaDescript(0) + " to squirt fluid behind you.\n\n", false);
						outputText("She sees the spray and strokes your ass gently, but can do nothing to help as she busies herself with inserting her ovipositor into your " + player.assholeDescript() + ". Its thick lubrication allows it quick entrance, and soon she's pumping her fluids into your bowels. The sensation proves too much for your massively enflamed " + player.vaginaDescript(0) + " and you begin to shake violently, incapable of touching yourself and alleviating the dreadful pressure. Your " + player.clitDescript() + " begins to throb painfully as it swells larger than normal.\n\n", false);

						outputText("She seems to understand your problem though and, wanting to help you with your needs, begins to stroke your " + player.vaginaDescript(0) + " with her 'feet'. As she does this she starts to hum, a sound that obliterates what few thoughts you had left and which causes her entire body to vibrate. This combined with the handful of times her chitin covered appendages slide across your " + player.clitDescript() + " cause you to cum hard, squirting behind you with surprising force.\n\n", false);
						//[Huge cum amount:
						if (player.wetness() == 5) outputText("Your massive cum amount soon causes you to be lying in a deep puddle of femcum, the scent so strong that it's almost enough to overwhelm that of the honey, despite it coating your face.\n\n", false);
						outputText("She continues pumping into you as you pass out, your entire rear aching and the combined scent of cum and honey overwhelming you.", false);
					}
					//[Herm:
					else if (player.gender == 3) {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing " + player.sMultiCockDesc() + " to go rock hard and your " + player.vaginaDescript() + " to squirt fluid behind you.\n\n", false);

						outputText("She can't see your cock, of course, and while she sees the spray and strokes your ass gently, can do nothing to help as she busies herself with inserting her ovipositor into your " + player.assholeDescript() + ". Its thick lubrication allows it quick entrance, and soon she's pumping her fluids into your bowels.\n\n", false);

						outputText("The sensation proves too much for your massively engorged " + Appearance.cockNoun(player.cocks[0].cockType) + " and " + player.vaginaDescript(0) + " to take and you begin to shake violently, incapable of touching it as one is trapped underneath you with the weight of the bee-girl preventing you from getting the leverage needed to hump the hard ground and the other is hopelessly out of reach.\n\n", false);
						outputText("She seems to understand your problem though and, wanting to help you with your needs, begins to massage your " + player.vaginaDescript() + " with her 'feet' while periodically stroking the back of your " + player.cockDescript(0) + ".\n\n", false);
						outputText("As she does this she starts to hum, a sound that obliterates what few thoughts you had left and which causes her entire body to vibrate. This combined with the handful of times her chitin covered appendages slide across your " + player.clitDescript() + " cause you to cum hard, squirting behind you with surprising force and splattering your underside with jism.\n\n", false);
						//[If huge cum amount:
						if (player.cumQ() >= 1500) outputText("Your massive cum amount soon causes you to be lying in a deep puddle of splooge and femcum, the scent so strong that it's almost enough to overwhelm that of the honey, despite it coating your face.\n\n", false);
						outputText("She continues pumping into you as you pass out, your entire rear aching and the combined scent of cum and honey overwhelming you.", false);
					}
					//[Genderless:
					else {
						outputText("She returns to your rear end and assesses it some more. With an almost desperate scrabbling she climbs on top of you, jabbing you repeatedly with her outstretched stinger and causing your " + player.assholeDescript() + " to wink.\n\n", false);
						outputText("She pays no attention to that though, and busies herself with inserting her ovipositor inside it. The thick lubrication allows it quick entrance, and soon she's pumping her fluids into your bowels. The sensation proves too much for you and you begin to shake violently, incapable of touching yourself and alleviating the dreadful pressure.\n\n", false);
						outputText("She seems to understand your problem though and, wanting to help you with your needs, begins to stroke where your genitals should be with her 'feet'. As she does this she starts to hum, a sound that obliterates what few thoughts you had left and which causes her entire body to vibrate. The mix of sensations is enough to stop you from shaking, but the pressure doesn't go away and you pass out as she continues her task.\n\n", false);
					}
					dynStats("int", -.5, "lus=", 100);
					//Anal bee pregnancy!
					player.buttKnockUp(PregnancyStore.PREGNANCY_BEE_EGGS, PregnancyStore.INCUBATION_BEE, 1, 1);
				}
				player.slimeFeed();
				combat.cleanupAfterCombat();
			}
			else {
				//Male + venomz
				if ((player.findStatusEffect(StatusEffects.ParalyzeVenom) >= 0 || player.findStatusEffect(StatusEffects.lustvenom) >= 0) && !sexed && player.cockTotal() == 1) {
					outputText("The bee-girl stands directly over you, looking down at you with a triumphant cute smile across her face, her eyes surveying every millimeter of your body. All you can do is lay there looking up at her fine figure and a profile of her ample breasts with a knowing smile on your face. She crouches down on all fours, just out of your reach, and begins to rhythmically shake her extended abdomen like a child's toy.\n\n", false);

					outputText("Suddenly reality kicks in as you feel the venom coursing though your body, and your heart begins to race faster and faster by the minute. A dull pain swells deep inside your head as if it were about to explode; you try to lift your arms to cradle your head but can't, and slowly a new sensation takes over as your manhood begins to swell in size and length, trying to break through your clothes. A faint buzzing sound comes seemingly from nowhere, growing louder and getting closer every second. As the pain in your head decreases, you suddenly feel parched, your mouth as dry as the desert sands.  You try to let out a moan but all you can do is breathe rapidly, as if you are burning up inside.\n\n", false);

					outputText("Several more bee-girls appear and gracefully land all around you, apparently communicating with each other by vibrating their abdomens. She leans forward over you, brushing one of her breasts across the side of your face as she loosens your clothing to release your fully erect manhood. She forcefully grabs it with both hands and begins to squeeze it, as if trying to choke it. Your vision starts to blur; if she were to stroke your member right now, you could die happily knowing you had felt that kind of pleasure. The bee-girl continues to choke your member for several minutes, forcing the blood upwards.\n\n", false);

					outputText("Slowly she gets to her feet and stands directly over your manhood.  'At last,' you think to yourself, 'one final moment of pleasure.'  You close your eyes and allow yourself the fantasy of her lowering herself upon you. A few seconds pass before you open your eyes to see what she is doing. A sudden wave of panic comes over you as you watch her arch her abdomen down between her legs; a split second later you feel a sharp pain at the base of your member. Your eyes close as you try in vain to scream before you pass out.", false);
					combat.cleanupAfterCombat();
					outputText("\n\nSeveral hours later you wake up free of pain - if anything you feel great, a warm tingling sensation rippling through your whole body every time you move as you sit upright. As you look down you see you are still naked and covered in your own seed. With a smile you kind of hope the next time you meet a bee-girl you will be victorious, so you can show her how to please you properly.", false);
					sexed = true;
					player.orgasm();
					return;
				}
				//Generic male bee-rape
				if (player.gender == 1) {
					if (player.lust >= player.maxLust()) outputText("Overcome by lust, you throw yourself into her waiting arms.  ", true);
					else outputText("Overcome by your wounds, you are unable to resist as she lifts you into her arms and embraces you.  ", true);
					outputText("At first she holds you close, but as she does, a stinger slowly emerges from her abdomen, as well as a thick knot like organ, both covered in a sweet-smelling lubricant. Your mind synaesthetically sees a myriad of colors and scents, and you don't resist as she gently pushes you down to your stomach. Nor do you protest as she leans over you, her stinger - thank goodness it isn't poison - looming close to your anus. With no more words she shoves the thick, lengthy stinger and knot inside of you. Her 'cock' slipping in slowly, the lube keeping you from shaking out of your scent-induced pleasure coma. Your hand even ventures to your own engorged ", false);
					if (player.cockTotal() == 1) outputText("member", false);
					if (player.cockTotal() > 1) outputText("members", false);
					outputText(" as she rather forcefully rapes your once-tight hole, humming her tune all the while.\n\n", false);
					//blow load.
					outputText("After hours of her forcefully filling your hole, her stinger pumping almost gallons of her bee-seed into your very bowels, hours of you stroking yourself to ejaculation, she finally pulls out. With her stinger still dripping seed onto your back, she smiles, watching you blow your last load into a pool of semen underneath you, and collapse exhausted.\n\n", false);
					//epilogue
					outputText("You awaken, your nose full of a honey like scent, some strange fluid on your back, and the feeling of something leaking from you.", false);
					player.slimeFeed();
					player.orgasm();
					dynStats("int", -.5);
					//Anal bee pregnancy!
					if (rand(3) == 0) player.buttKnockUp(PregnancyStore.PREGNANCY_BEE_EGGS, PregnancyStore.INCUBATION_BEE, 1, 1);
					player.buttChange(25, true, true, false);

					combat.cleanupAfterCombat();
					return;
				}
				//FEMALES
				//Fan-submitted - female funtimes with a bit o' end breathplay
				if (player.gender == 2) {
					if (player.lust < 100) outputText("Barely conscious, you look up as the bee approaches.  ", true);
					else outputText("Overcome with desire, you look up as the bee approaches.  ", true);
					outputText("You feel weary and weak as your body begins to betray you to the pheromones of your foe.  You try and struggle as she moves over you, holding your hands against the ground as her chest pushes into your face, blocking sunlight and air as you protest. Your " + player.armorName + " are pulled from your body as the bee-girl moves on top of you.\n\n", false);
					outputText("A sharp pain hits your stomach as the bee-girl's stinger penetrates your flesh. Before you can cry out, a sickening warmth floods from the wound, washing away the pain and oozing through your body. Your " + player.vaginaDescript(0) + " juices flow between your ", false);
					if (player.isTaur()) outputText("rear legs", false);
					else outputText("legs", false);
					outputText(", making your thighs slick as your clit throbs almost painfully in the cold air. You begin to pant, your heart racing as the bee-girl slides back down your body, moaning as her breasts snag your nipples, rubbing them in a pleasurable way. She stops at head level, looking into your eyes with her own black orbs. She smiles at you and you realize that she is no longer pinning you with anything more than her own relatively light weight. You crease your brow with worry as you realize that running is the last thing on your mind, before the warm haze slips inside your skull.  The sexy bee leans in and kisses you softly, robbing you of your last shreds of resistance.\n\n", false);

					if (player.isTaur()) {
						outputText("She slips further down your chest, grabbing your " + player.allBreastsDescript() + " playfully. You feel her knee nudging against your " + player.vaginaDescript(0) + ", grinding roughly against it and sending shivers through your body. You yelp slightly as she bites one of your nipples, the sudden sensation giving way to moans of pleasure as she massages and pinches the other one. Her knee slides against your " + player.vaginaDescript(0) + ", flicking your " + player.clitDescript() + " and coating the bee-girl with your juices. You feel her straddle your legs, her feet deftly pulling your thigh into contact with her pussy, before she starts to rock against you.\n\n", false);
						outputText("Her juices mix with your own as you feel yourself working steadily to climax. Noticing your heavy breathing and sudden vigor, she pulls away.  ", false);
					}
					outputText("In one swift motion, she slides up your body until her pussy is jammed against your face. Her hands grip the back of your head, pulling you tightly into her snatch as she smears her honey over your face.  The smell is incredibly sweet, and you instinctively begin to pleasure her.  You slide your tongue inside her folds, drinking down the thick liquid that fills your mouth as you suckle. ", false);

					if (player.isTaur()) outputText("After a while, her hot and sweet pussy swiftly disappears from your sight, and you feel the bee-girl's weight on your butt, right before her stinger,", false);
					else outputText("You feel the bee-girl's stinger", false);
					outputText(" sliding against your nether-lips, pushing against them and parting the outer folds. Her abdomen shifts, shifting the stinger up and down, keeping your " + player.vaginaDescript(0) + " parted while rubbing your clit.\n\n", false);
					if (player.isTaur()) outputText("Suddenly, you feel a sharp pain right into your clit, followed by a sexual warmth so intense this time, that it engulfs you and turns you into a sex-craving slut.  Anticipating the effect, she repositions her honeyed pussy over your face.  You begin to lick, suck and kiss it frenetically, burying your tongue into her deepest recesses.  She giggles at first, but soon the only noises you hear from her are moans becoming more and more intense. As her arousal shoots through the roof, you feel her legs twitching, and she suddenly grabs your head and forces your face into her crotch. You continue eating her out voraciously, oblivious to secondary things like breathing.\n\n", false);
					else outputText("Your moans are muffled by the honeyed pussy on your face, and you hear her starting to squeal loudly. Her thighs clamp tightly around your ears, grinding harder into your face as her stinger picks up the pace.  ", false);
					outputText("It gets harder and harder to breathe, the thick flow of honey threatening to suffocate you as the bee-girl reaches her climax.  You feel your body finally succumbing to the pleasure and oxygen deprivation and cum HARD, the world going comfortably dark as you lose your grip on consciousness.", false);
					player.slimeFeed();
					player.orgasm();
					dynStats("int", -.5);
					combat.cleanupAfterCombat();
					return;
				}
				//Hermz/Genderless (Lazy way, unfinished?)
				if (player.gender == 3 || player.gender == 0) {
					outputText("Defeated, there is little you can do to stop the bee-girl as she approaches, buzzing and humming intently.  Cooing and humming into your ear, her pheromones filling the air, she rapidly overwhelms your mental resistance.\n\n", true);
					//Link to standard bee rape scene #3.
					doNext(beeEncounterClassicSex);
				}
			}
		}

		public function rapeTheBeeGirl():void
		{
			spriteSelect(6);
			flags[kFLAGS.BEE_GIRL_COMBAT_WINS_WITH_RAPE]++;
			var sexed:Boolean = false;
			outputText("With your mind made up, you approach the ", true);
			if (monster.HP <= 0) outputText("helpless ", false);
			else outputText("horny ", false);
			outputText("bee-girl with a devilish smile painted across your face.\n\nHow will you take her?\n\n", false);

			//OPTIONS HERE!
			var naga:Function =null;
			var multiCock:Function =null;
			var cock:Function =null;
			var vagina:Function =null;
			var herm:Function =null;
			var gentleman:Function =null;
			var eggs:Function =null;
			if (player.canOvipositSpider() && (player.faceType == FACE_SNAKE_FANGS || player.faceType == FACE_SPIDER_FANGS)) {
				eggs = layEggsInABeeSpiderLike;
				outputText("(You could dose her with venom and lay YOUR eggs in her.)\n");
			}
			if (player.hasCock()) {
				outputText("(You could fuck her with " + player.oMultiCockDesc() + ".)\n", false);
				cock = rapeTheBeeGirlWithADick;
			}
			if (player.cockTotal() > 1) {
				outputText("(You could use more than one of your " + player.multiCockDescriptLight() + " on her.)\n", false);
				multiCock = rapeTheBeeMultiCockStuff;
			}
			if (player.hasVagina()) {
				outputText("(You could make her get off your " + player.vaginaDescript() + ".)\n", false);
				vagina = rapeABeeGirlWithYourVagina;
			}
			if (player.gender == 3) {
				outputText("(You could try to please both your 'male' and 'female' halves on the bee.)\n", false);
				herm = futaRapesBeeGirl;
			}
			if (player.isNaga() && player.faceType == FACE_SNAKE_FANGS) {
				outputText("(You could focus on your snakelike, 'naga' attributes.)\n", false);
				naga = corruptNagaBitchesRapeABee;
			}
			if (player.cor >= 75 && player.str >= 60 && (player.tongueType == TONGUE_SNAKE || player.hasCock() || player.hasVagina() || player.biggestTitSize() >= 4)) {
				outputText("(You could play with her a bit and try to make her lay eggs into herself.)\n", false);
				gentleman = beeGirlRapeForTheDistinguishedGentleman;
			}
			choices("Use Cock", cock, "Use Cocks", multiCock, "Use Vagina", vagina, "Herm Style", herm, "Naga", naga,
				"Self-Egg", gentleman, "", null, "", null, "LayYourEggs", eggs, "", null);
		}


		private function rapeTheBeeMultiCockStuff():void
		{
			spriteSelect(6);
			clearOutput();
			//Doubledick special
			//HermCock supreme by mallowman
			if (player.cockTotal() >= 5 && player.biggestTitSize() > 2
					&& player.vaginas.length > 0 && rand(2) == 0) {
				outputText("As you approach, she starts to edge away, her battered wings flapping in a futile attempt to escape.  Reaching her, you grip her wrists before she can fight back, squeezing tightly as her struggling increases. Forcing her onto her back, you hold her wrists tightly in one hand to allow you to pull off your " + player.armorName + ", freeing your " + player.multiCockDescript() + " and " + player.vaginaDescript(0) + ".  She gasps at the alien sight of your multiple 'stingers', while you take a moment to decide what's going to go where.\n\n", false);
				outputText("You shift a bit upward, your brace of " + player.multiCockDescriptLight() + " sliding above the bee-girl's slick honey pot.  For a moment she breathes a sigh of relief, then gasps as two of your manhoods press against her front and back doors at once.\n\n", false);
				outputText("You begin to push forward, sliding your dickmeat against the soft folds of her pussy and pressing the tip of your prick firmly against her quivering hole, her whimpers punctuated by rhythmic gasps.  Your grin widens as you penetrate her roughly in one strong stroke, the bee-girl's body tensing underneath you as a squeal leaves her lips.  Your other cocks slide between her plump breasts, the soft pillows enveloping your shafts.  Defiance escapes her, her abdomen locking in place as she becomes unable to concentrate on moving her stinger without being overwhelmed by the feeling of your meat stuffing her ass.\n\n", false);
				outputText("Unhindered, you start to fuck her.  Her pussy tightens and convulses around your " + player.cockDescript(0) + ", her ample honey dribbling down onto your lowermost shaft and adding a little more lube on every thrust into the tight heat of her ass.  Her whimpers turn to moans, her scent shifting from fear to lust as the bee-girl discovers the unexpected pleasure of being reamed in both holes at once.  You keep your breathing steady, listening to her moans grow more lustful with every thrust and more needy every time you pull back in preparation for another.  Soon you've fucked all thought of resistance out of her, in favor of squealing with glee every time your mighty cock forces a little deeper into her tight honey pot.\n\n", false);
				outputText("Letting go of her arms, you grip the base of her abdomen for leverage and let her arms and legs slide around you as your pace increases.  You show her how to press her breasts together against your " + player.cockDescript(0) + ", and she obliges, rubbing them back and forth as you fuck her.  With your jiggling breasts added to the mix, it becomes even more enjoyable, your " + player.breastDescript(0) + " mashing against hers.  The milk leaking out of your immense jugs runs down your bodies and adds further to the ocean of fluids forming between your hips.\n\n", false);
				outputText("The heads of your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " rub back and forth against the bee-girl's lips and face, and finally curiosity leads her to begin tasting, her surprisingly long tongue lassoing and swirling around every tip she can reach in turn, darting from one to another as if tasting flowers to provide an experience almost as unique as her pussy.\n\n", false);
				outputText("You feel her abdomen pressing against your rear as you drive into her, the pressure in your groin building as her pussy and ass tighten around you. With a groan you cum, your hot seed gushing in alternating spurts out of each of your shafts into her eager little holes while your tight cunt juices itself with your own brand of honey. She clenches you tightly, her belly distending slightly as you empty your load into her pussy and ass while she squeals again at getting her face covered in seed.  Exhausted from the battle and the fuck, she relaxes and collapses on the ground, panting heavily and half-conscious.", false);
				player.orgasm();
				combat.cleanupAfterCombat();
				return;
			}
			if (player.cockTotal() == 2 && rand(2) == 0) {
				outputText("The bee-girl turns around, scampering across the floor to try to escape. As you close in to your prey you can feel your " + player.multiCockDescriptLight() + " harden and rise up at the sight of her form and you swiftly grab on to her abdomen and hold fast. She screams in futility as you flip her over and greedily look across her body.\n\n", false);
				outputText("Forcing her onto her back, you hold her wrists tightly in one hand to allow you to pull off your " + player.armorName + ", freeing your " + player.multiCockDescriptLight() + ". The bee-girl opens her eyes for a scant moment and realizes what's about to happen. She tries one more time to plead for you to let her escape as your " + player.multiCockDescriptLight() + " slide up and down against her nectar-drenched pussy lips. Your grin widens as you penetrate her roughly in one savage stroke, taking her with one of them. Screaming and squirming, the bee-girl struggles.  Your right hand braces against her flapping arms to settle them to the ground as you push in once again. Letting her know just how little control she has against your will, you lean forward, planting her hands against the ground and licking her cheek as your " + player.multiCockDescriptLight() + " push up deep inside her. Looking into her eyes, you see a faint glimmer of defiance, and under your body you feel her shifting slightly, muscles growing firm and tense. The realization hits you, and you manage to shift before her stinger comes into contact with you. Moving your knee, you pin her thick ", false);
				outputText("abdomen down and remove the threat. You smack her across the face for her defiance to reaffirm your dominance and you push forward back into her. She whimpers slightly, but then her face snaps back to a fierce visage although cracks begin to form as you continue pushing into her. As much as she wants to resist, the pleasure is mounting and you have it in mind to completely solidify your dominance over her.\n\n", false);
				outputText("You decide that it's time to bring your other gift into play. Atop the bee-girl you fire in one more stroke of your " + player.cockDescript(0) + " and then you run your free hand from her black lips across her breast and across her abdomen before you rest it on her clit. You tweak her sensitive spot along with the strokes from your intruding member and then when the rush of nectar and cum juices from her pussy seem up to the task you grab hold of your other " + player.cockDescript(1) + " and forcefully ram it into her pussy right below your first entry.\n\n", false);
				outputText("At this the bee-girl shrieks in utter bliss as her eyes roll back and she can't fight back the tingles coursing through her as you stretch her pussy lips.  You let go of her hands and watch with a satisfied grin as she tosses, turns, and clings to the dirt with a rich mix of pain and pleasure from the rough double-penetration. Suddenly you're caught off guard slightly as she pushes forward, almost tackling you. For an instant you're prepared to finish off the bee-girl, but the lust in her eyes is easy enough to read and she looks down, begging to be fucked and filled.  Grabbing onto her arms to brace against and suckling at her ample breast, you force your twin rods into her again and again while a pool of her sexual juices and sweet nectar form at your crotch from each slip in to her moist wetness. The bee-slut moans as you push your rock-hard cocks into her slick pussy, and you can just see the detectable bump of your cock head edging along her stomach, but strong as you are the tightness is overwhelming as her pussy muscles clench about your cocks.\n\n", false);
				outputText("Letting go of your hands the bee-girl leans back and her mouth opens in a powerful scream of ecstasy that you're sure will scatter any wild-life or imps who hear the noise. As she flings herself back, your body clenches and a torrential storm of white, warm cum soars from the tip of your members into her innermost spaces. Unable to cope with the feelings coursing through her, the bee-girl nearly faints as she comes to a rest on your chest.  You catch your breath and the last couple of cum shots is milked by her still clenching pussy. Rolling over, you free both of your cocks from her fuck-hole and watch with more than a bit of satisfaction.  The dam breaks and a sea of white escapes her stretched, well-lubricated pussy. Pleased with your latest jaunt through the forest, you collect your gear and settle off, leaving the cum-drenched bee-girl covered in your seed.", false);
				player.orgasm();
				combat.cleanupAfterCombat();
				return;
			}
			else beeAlternate();
			return;
		}

//MALE sometimes herm
		private function rapeTheBeeGirlWithADick():void
		{
			spriteSelect(6);
			clearOutput();
			var x:Number = player.cockThatFits(monster.vaginalCapacity());
			if (x < 0) x = 0;
			//TAURS GO!
			if (player.isTaur()) {
				if (monster.lust >= monster.eMaxLust()) outputText("The bee-girl plops onto her flower with her legs splayed out, letting you get a clear look at her dripping honeypot. She watches you nervously as you approach, letting her stinger slide out in a pointless threat. She seems taken aback when you smile down at her, but returns the gesture with a nervous smile of her own.\n\n", false);
				else outputText("The bee-girl plops onto her flower, barely conscious from the beating she's taken.  Her legs are splayed drunkenly, letting you get a clear look at her dripping honeypot. She watches through heavily, lidded eyes as you approach, letting her stinger slide out in a weak threat.  She seems taken aback when you smile down at her, but returns the gesture with a nervous, scared smile of her own.\n\n", false);

				outputText("You reach down and stroke her hair. She flinches from your hand at first before realizing that you genuinely mean her no harm. Her own hand reaches to slide up your arm as you pull yourself down to kiss her. She happily kisses you back, her long, thin, dexterous tongue wrapping around your own.\n\n", false);

				outputText("Pulling back, you consider her for a moment. She watches as you slip out of your " + player.armorName + ", licking her lips at the sight of your " + player.chestDesc() + ". Once your torso is free you reach down again and pick up the bee maiden. She's surprisingly light and you lift her with ease, feeling her legs wrap around you as you hug and kiss her.\n\n", false);

				outputText("It's not long before she's gently grinding her cunt against your body and you find your hand sliding down her front to slip gently inside her sticky folds. She moans into your mouth and vibrates as a little gush of honey squirts out of her. You bring your hand back up and the pair of you clean it off with your tongues.\n\n", false);

				outputText("The sweet substance causes your hindquarters to heat up. You feel your " + player.assholeDescript() + " pucker and " + player.sMultiCockDesc() + " grow, dripping pre onto the ground. At the same time, your thoughts start to get fuzzy and you have to fight off the sensation to throw the bee down and fuck her wildly.\n\n", false);

				outputText("The honey is gone relatively quickly, much to your disappointment. You reach down to fetch some more, but her hand stops you. \"<i>You don't want that, you want thezze.</i>\" she says, lifting your hand back up and placing it on her breast.\n\n", false);

				outputText("As you squeeze and massage the soft mounds, the effects of the honey start to wear off, at least in your head. Your rear is aching with desire and your tail flings about to try to tempt the non-existent mares with your scent. The bee maiden gets a whiff of your strong musk and you feel a fresh gush of fluids run down your forelegs.\n\n", false);

				//Cock short enough to penetrate her:
				if (player.cockArea(x) <= monster.vaginalCapacity()) {
					outputText("She looks under your arm toward your manhood and seems delighted by the sight of your " + player.cockDescript(x) + ". Her body swings about your torso with the help of her wings and she crawls down your back toward your rear. You lift your tail and allow the bee maiden to examine your " + player.assholeDescript() + ", sliding her fingers around the edge and teasing at it.", false);
					//Has testicles:
					if (player.balls > 0) outputText("  Her other hand slides down and begins to massage your " + player.ballsDescriptLight() + ", squeezing and tugging gently at your scrotum. Her tongue joins them, sliding in and out of your ass before wrapping around your sack. You feel incredible and your " + player.cockDescript(x) + " drips pre, forming a puddle on the ground.", false);
					//No testicles:\
					else outputText("Her other hand starts pulling it open and soon her tongue joins them, sliding in and out of your ass delicately. Your " + player.cockDescript(x) + " quivers with anticipation and you swish your tail happily.", false);
					outputText("\n\n", false);

					outputText("All of a sudden her ministrations stop, causing you to look over your shoulder to find out what's going on. She turns around on your back and gives you a look of complete innocence. Powerless to resist such a cute look, you turn your head back around as her legs swing down onto your flanks.\n\n", false);

					outputText("You think at first she's going to ride you like a horse, but she doesn't. Instead, you feel her whole body slide sideways as she flips around to grab onto your belly. You're surprised at her strength, managing to hold herself up fairly effectively with just her arms and legs gripping your body. She doesn't intend to rely on that alone though, as her abdomen is gently held in place between your rear legs. You feel something latch onto your " + player.assholeDescript() + ", but are unable to do anything about it or even see what it is. The sudden changes are surprising and you can't help but wonder what she intends.\n\n", false);

					outputText("You get your answer as a hot, wet, vice wraps around your " + player.cockDescript(x) + " and whatever is inside your ass pushes slightly further in. It feels good, but you know that even with her surprising strength she wouldn't be able to hold on if you tried driving into her. Thinking this defeats the purpose somewhat you're about to propose that some other arrangement be considered when she starts to buzz.\n\n", false);

					outputText("It's gentle at first, not much more than a regular bee to your ear, but it slowly builds, and builds, and builds; until eventually it's so loud you find it hard to think of anything but the strange noise. The noise isn't the only thing though, as the sound grows so too do the vibrations in the bee-girl's body. By the time the buzzing has reached its crescendo your entire belly feels like it's being vibrated off.\n\n", false);

					outputText("The sensation is incredible; her muscles spasm and milk your " + player.cockDescript(x) + " while the object in your " + player.assholeDescript() + " (which you think is probably her ovipositor) begins pumping fluids into you, all while your genitals are vibrated unceasingly.", false);
					//Has testicles:
					if (player.balls > 0) outputText("  Your " + player.ballsDescriptLight() + " really feel spectacular, the vibrations causing the hot spunk inside to roil about.", false);
					outputText("  Her hot cunt constricts around you as she cums repeatedly, coating your hind legs in sweet honey.\n\n", false);

					outputText("You find it increasingly difficult to control yourself as your equine body demands to hump something. The unusual ministrations are spectacular, but your " + player.cockDescript(x) + " is demanding a mare. With a supreme effort you overcome your bestial desires, reveling in the pleasure without feeling the overwhelming desire to inseminate. Just as you're celebrating this personal victory you feel the familiar pressure of your orgasm build in your groin", false);
					//has testicles: 
					if (player.balls > 0) outputText(", and your " + player.ballsDescriptLight() + " constrict", false);
					outputText(".\n\n", false);

					outputText("Your seed is propelled through your pulsating " + Appearance.cockNoun(player.cocks[x].cockType) + " with surprising force.", false);
					//No testicles: 
					if (player.balls == 0) outputText("  It dribbles into the bee-girl as her honey squirts out of her once again. Her body trembles as the extreme exertions take their toll, and she slides off of your member with a damp plop, splashing into a puddle of her own fluids.", false);
					else {
						//Normal cum amount: 
						if (player.cumQ() < 500) outputText("  It sprays inside the bee-girl as her honey squirts out of her once again. Her body trembles as the extreme exertions take their toll, and she slides off of your member with a damp plop, splashing into a puddle of her own fluids as your spunk dribbles onto her.", false);
						//Huge cum amount:
						else outputText("  It sprays inside the bee-girl, quickly overfilling her and causing her belly to expand. Her sudden increased girth and the extreme exertion cause her to lose her grip on you, and she is propelled off of you into a puddle of spunk and honey. You can't control yourself as your " + player.ballsDescriptLight() + " continue to pump out more and more fluid, spraying down the exhausted bee and coating her flower with enough gunk to cause it to wilt slightly. Eventually it stops, with only periodic gushes spraying out.", false);
					}
					outputText("\n\n", false);

					outputText("Once you've come down from your incredible orgasm your attention shifts to the exhausted bee maiden beneath you. You take pity on her and pick up the giant bee as gently as possible. She hums gently in your arms as you carry her over to her flower, sliding her onto it", false);
					//Huge cum amount:
					if (player.cumQ() >= 500) outputText(" and watching as her lower body sinks into your spunk like a thick white bath", false);
					outputText(". Once she looks comfortable you make your way back to camp, thoroughly satisfied.", false);
				}
				//Cock too long to penetrate her:
				else {
					outputText("She looks under your arm toward your manhood but seems disappointed at your " + player.cockDescript(x) + "'s large size. . Her body swings about your torso with the help of her wings and she crawls down your back toward your rear. You lift your tail and allow the bee maiden to examine your " + player.assholeDescript() + ", sliding her fingers around the edge and teasing at it. Her tongue licks at you but you can tell her mind is elsewhere and you wonder what the problem is.\n\n", false);

					outputText("She giggles all of a sudden and retracts her tongue, turning around atop you. Her chitin covered legs swing down to rest on your flanks and you wonder if she intends to ride you like a horse.\n\n", false);

					outputText("She doesn't though, as with a buzz her body swings about beneath you. As she slides sideways, one arm is pulled off for a moment, long enough to catch your " + player.cockDescript(x) + " between her body and your own, before catching onto your other flank. Her abdomen slides up behind your rear legs and you feel something latch onto your " + player.assholeDescript() + ", but are unable to do anything about it or even see what it is.\n\n", false);

					outputText("Her grip is surprisingly strong for such a frail looking creature but you don't think she'll be able to handle much movement. Thinking this defeats the purpose somewhat you're about to propose that some other arrangement be considered when she starts to buzz.\n\n", false);

					outputText("It's gentle at first, not much more than a regular bee to your ear, but it slowly builds, and builds, and builds; until eventually it's so loud you find it hard to think of anything but the strange noise. The noise isn't the only thing though, as the sound grows so too do the vibrations in the bee-girl's body. By the time the buzzing has reached its crescendo your entire belly feels like it's being vibrated off.\n\n", false);

					outputText("Your " + player.cockDescript(x) + " feels wonderful though, pumping out fluid and swelling with more and more blood.", false);
					//Has testicles: 
					if (player.balls > 0) outputText("  The vibrations do a number on your " + player.ballsDescriptLight() + " too, as the semen stored within starts to shake and dance about inside.", false);
					outputText("  The thing in your " + player.assholeDescript() + " (which you believe is her ovipositor) is vibrating along with her as it pumps fluid inside, and you feel yourself puckering in pleasure.", false);
					//Cock long enough to masturbate: 
					if (player.tallness * (5 / 6) < player.cocks[player.longestCock()].cockLength) {
						outputText("  Her tongue wraps around your " + player.cockDescript(x) + " and starts jerking off the small section it can reach. The wet ring feels amazing and you decide to help her efforts by gripping the head of your member and playing with it yourself. Soon though, your cock trembles as the familiar sensation of orgasm begins creeping up on you.", false);
					}
					//Other cocks: 
					else outputText("  Her tongue wraps around your " + player.cockDescript(x) + " and slides up and down the small area it can reach before flicking about at the tip of your urethra. Her expert licking feels amazing and it's not long before your feel the familiar sensation of orgasm creeping up on you.", false);
					outputText("\n\n", false);

					outputText("With all the combined sensations your " + player.cockDescript(x) + " begins to unload. ", false);
					//With testicles, masturbatable cock:
					if (player.balls > 0 && player.tallness * (5 / 6) < player.cocks[player.longestCock()].cockLength) {
						outputText("Your " + player.ballsDescriptLight() + " contract and propel your seed down your member toward the fresh air. It fires out of you and hits the bee's flower, splattering it in white.", false);
						//Huge cum amount: 
						if (player.cumQ() >= 750) outputText("  You don't stop there though, as your firehose of a cock sprays it down until it's sagging with the weight of your seed.", false);
					}
					//With testicles, other cocks:
					else if (player.balls > 0) {
						outputText("Your " + player.ballsDescriptLight() + " contract and propel your seed down your member toward the waiting bee-girl. It fires out of you and hits her face, splattering it in white.", false);
						//Huge cum amount: 
						if (player.cumQ() >= 750) outputText("  You don't stop there though, as your firehose of a cock sprays wildly, coating her head and her flower, hosing it down until it's sagging with the weight of your seed.", false);
					}
					//Without testicles: 
					else outputText("Your " + player.assholeDescript() + " tightens uncontrollably around its intruder, making the vibrations feel even stronger there. Your member jerks as you orgasm and a few droplets of semen land on the bee maiden.", false);

					outputText("\n\nShe releases you from her grasp and lands with a wet thud on the ground. Looking down, you see that her vibrating against your " + player.cockDescript(x) + " was enough to get her off, a lot. She's lying in a puddle of mixed sexual fluids and honey, unconscious after what must have been an extreme effort on her part.", false);

					outputText("You take pity on her and pick up the giant bee as gently as possible. She hums gently in your arms as you carry her over to her flower, sliding her onto it", false);
					//Huge cum amount: 
					if (player.cumQ() >= 750) outputText(" and watching as her lower body sinks into your spunk like a thick white bath", false);
					outputText(". Once she looks comfortable you make your way back to camp, thoroughly satisfied.", false);
				}
				player.orgasm();
				combat.cleanupAfterCombat();
			}
			else if (rand(2) == 0) {
				outputText("Firmly grasping her thighs at the joining of her smooth carapace and soft skin, you force them open, revealing the source of her irresistible scent.   She buzzes pitifully in protest ", false);
				if (player.isTaur()) outputText("as your " + player.cockDescript(x) + " hardens under your belly.", false);
				else outputText("as you disrobe, revealing your " + player.cockDescript(x) + " to her.", false);
				outputText("  Wasting no time, you get down to the business of ", false);
				if (player.cockTotal() == 1) outputText("penetrating her slick snatch, forcing in inch after inch.  ", false);
				if (player.cockTotal() == 2) outputText("cramming your " + player.multiCockDescript() + " into her, double-stuffing the poor bee-slut with your double dongs.  ", false);
				if (player.cockTotal() >= 3) outputText("cramming two out of your " + num2Text(player.cockTotal()) + " " + player.multiCockDescript() + "s into her, double-stuffing the poor bee-slut with double the dicks.  ", false);
				outputText("She swoons, flopping back and opening her legs completely, an expression of shock crossing her features, as if she can't comprehend why her body isn't listening to her.\n\n", false);
				//sex
				outputText("You begin pounding away at her, splattering honey over her thighs with your enthusiastic fucking.  Her passage is unlike anything you've ever had before.  It's tight, but overly slick and textured with small nubs and bumps that tease and caress in wonderful ways.   Her muscles clamp and squeeze her vaginal entrance tightly, turning it into an organic cock-ring.  You hold still while her cunt begins twitching and slightly rotating back and forth around your " + player.cockDescript(x) + ".    Her head is thrown back in what you assume is an orgasm, her arms mashing her tits together for even more pleasure.  The vacuum seal around your " + player.cockDescript(x) + " only gets tighter as her rippling, squeezing, twisting cunt stimulates your over-engorged " + player.cockDescript(x) + ".\n\n", false);
				//cum
				outputText("Taken beyond your limit, you lose control, feeling the tightness and warmth of your orgasm build at the base of your cock.   It builds and builds, held back by the bee's vice-like cunt, almost becoming painful with its intensity.   Just when you think you can't take any more pressure, you cum, HARD.   Your body clenches hard, spurting out each wave of fuck-juice with more force than the last.    Honey squirts from the bee-slut's fuck-hole, drenching the fuzz on her thighs and your legs with slippery sweetness.   Her cunt doesn't show any signs of slowing down, and your body obliges it, providing more cum than you thought yourself capable of.", false);
				if (player.gender == 3 && !player.isTaur()) outputText("  You reach down and finger your " + player.vaginaDescript(0) + " roughly, lost in the throes of your orgasm.", false);
				outputText("\n\n", false);
				//wind down
				outputText("At last her quivering quim releases your sore member", false);
				if (player.cockTotal() > 1) outputText("s", false);
				outputText(".   Staggering away, you marvel at the scene before you.  The bee-girl is just lying there, her shiny black fingers circling her sopping pussy and pinching a nipple.  Eyes closed, exhausted from her ordeal, the bee-maiden probably won't be getting up anytime soon.\n\n", false);
				//high cum variances
				if (player.cumQ() >= 250 && player.cumQ() < 500) outputText("You smile proudly at the steady stream of your cum that pours from her abused cunt, pooling underneath her.   Her abdomen even looks bloated with your seed.", false);
				if (player.cumQ() >= 500 && player.cumQ() < 1000) outputText("You smile proudly at your handy-work, noting how bloated and distended the bee's abdomen is.  It bulges obscenely, nearly double its previous size.  A sizable river of your spunk drools from between your legs, but amazingly she seems able to keep most of your over-sized orgasm in.", false);
				if (player.cumQ() >= 1000) outputText("You giggle at your poor victim's state.  She really is a mess.  Her abdomen and belly are both swollen, making her look pregnant in both her bee AND human halves.   A practical river of spunk drools from her glossy pussy-lips, pooling below her.  Even her ovipositor dangles down, dripping with your seed, forced out from her abdomen by the sheer amount of spunk she's carrying.  It twitches, bulges moving along its length, eventually dropping egg after egg on the ground, unable to keep in its cargo.", false);
				player.orgasm();
				combat.cleanupAfterCombat();
			}
			//Male 2
			else {
				outputText("As you approach she starts to edge away, her battered wings flapping in a futile attempt to escape.  Reaching her, you grip her wrists before she can fight back, squeezing tightly as her struggling increases. Forcing her onto her back, you hold her wrists tightly in one hand to allow you to pull off your " + player.armorName + ", freeing your erect member.  ", false);
				outputText("You begin to push forward, sliding your " + player.cockDescript(x) + " against the soft folds of her pussy, her whimpers shifting gently into moans. Your grin widens as you penetrate her roughly in one strong stroke, the bee-girl's body tensing underneath you as a squeal leaves her lips. Looking into her eyes, you see a faint glimmer of defiance, and under your body you feel her shifting slightly, muscles growing firm and tense. The realization hits you, and you manage to shift before her stinger comes into contact with you. Moving your knee, you pin her thick abdomen down and remove the threat.\n\n", false);
				outputText("Unhindered, you start to fuck her. Her pussy tightens and convulses around your cock, becoming slick with her juices and your pre-cum. You can smell the sickly combination of nectar, sweat and love juices hanging thickly in the air. Your breathing becomes heavy while her moans get deeper and lust-filled. Her reluctance evaporates, her struggling shifts into more receptive movements against your body, her hips rocking against yours with each thrust, forcing your " + player.cockDescript(x) + " deeper into her tight honeypot.\n\n", false);
				outputText("Letting go of her arms, you grip the base of her abdomen for leverage and let her arms and legs slide around you as your pace increases. You feel her abdomen pressing against your rear as you drive into her, the pressure in your " + player.ballsDescriptLight() + " building as her pussy tightens around you. With a groan you cum, your hot seed gushing inside of her. She clenches you tightly, her pussy milking your " + player.cockDescript(x) + " for every ounce, until the sticky white fluid is pouring from around your " + player.cockDescript(x) + ". Exhausted from the battle and the fuck, she relaxes and collapses on the ground, panting heavily and half-conscious.", false);
				player.orgasm();
				combat.cleanupAfterCombat();
			}
		}

//FEMALE sometimes herm
		private function rapeABeeGirlWithYourVagina():void
		{
			spriteSelect(6);
			clearOutput();
			if (player.isTaur()) {
				outputText("The bee-girl plops onto her flower with her legs splayed out, letting you get a clear look at her dripping honeypot. She watches you nervously as you approach, letting her stinger slide out in a pointless threat. She seems taken aback when you smile down at her, but returns the gesture with a nervous smile of her own.\n\n", false);

				outputText("You make your intentions clear by sliding the " + player.armorName + " from your torso and stroking your " + player.chestDesc() + ". As you slide your hands around your chest and play with your " + player.nippleDescript(0) + "s, you begin to moan sensually. Your own ministrations cause your " + player.vaginaDescript(0) + " to heat up and you feel small dribbles of femcum slowly slide down your hind legs. Responding to your arousal, your tail starts to wave about on its own to spread your musky scent and your " + player.assholeDescript() + " begins to open and close.\n\n", false);

				outputText("The bee maiden is at first confused by the unexpected display, but the combination of sight, sound and smell soon overrides her inhibitions. She spreads her legs wider, letting you see more of her honey-dripping cunt as she begins to finger herself. Her own moans come thick and fast, accompanied by small gushes of sticky fluid and a strong, sweet smell. It mixes with your musk and seems to become trapped in the little clearing, building and building until the pair of you are incapable of thinking of anything but sex.\n\n", false);

				outputText("But while she can reach herself, you can't. The puddle of fluid around your rear hooves continues to grow as your " + player.vaginaDescript(0) + " becomes more desperate for relief and the muscles in your " + player.assholeDescript() + " start to ache from the strength of their clenching. You mash your " + player.chestDesc() + " hard, desperate for release, but it's not enough.", false);
				//[Fuckable nipples: 
				if (player.hasFuckableNipples()) outputText("  Not even repeated penetration of your " + player.nippleDescript(0) + "s seems to bring the relief you need.", false);
				outputText("\n\n", false);

				outputText("Despite her ability to reach, the bee-girl seems to be having a similar trouble getting herself off. Her hands seem to blur with the speed of her rubbing as her back arcs. She cries out in frustration and begins beating her wings violently, lifting off from the flower.\n\n", false);

				outputText("In a haze of sexual frustration, you leap forward and grab the bee by the hips, dragging her sopping cunt to your lips and eating her out. Her entire body vibrates in your arms but she makes no attempt to stop you, going so far as to push your head further into her crotch and wrapping her legs around you. Your fingers find another hole and penetrate it, thinking it to be her anus. Whether it is or not, you're rewarded with a massive gush of honey coating your face as she cries out and goes limp.\n\n", false);

				//[Breasts >D: 
				if (player.biggestTitSize() > 4) outputText("Her legs release your head and she falls back, knocking into your " + player.allBreastsDescript() + " and causing them to jiggle lewdly. You grab her before she hits the ground, surprised at how light she is.", false);
				//[Breasts <=C: 
				else outputText("Her legs release and she falls back, but you catch her before she hits the ground and are surprised by how light she is.", false);
				outputText("  Her body stiffens as she realizes her situation and with your aid manages to right herself. By now the pressure in your loins is unbearable and you're breathing hard. Your " + player.nippleDescript(0) + "s ache just as badly as your " + player.assholeDescript(), false);
				//[Fuckable nipples and/or lactating: 
				if (player.hasFuckableNipples() || player.lactationQ() >= 20) outputText(" and ooze fluids in a constant stream down your front", false);
				outputText(". The bee-girl obviously understands your situation and almost as soon as she's upright buzzes onto your back.", false);

				outputText("The peculiar sensation of her chitin covered appendages climbing along your back is lost on your lust addled mind, but the sudden penetration of your " + player.assholeDescript() + " is most definitely not. You cry out as the weak contact is more than enough to make you cum, spraying hot femcum beneath you.  Meanwhile, your tongue lolls out of your mouth and you shiver with barely restrained pleasure.\n\n", false);

				outputText("She's not done yet though, as her finger is quickly replaced with a long, wet tongue. It writhes about inside you while cum continues to spray out of your " + player.vaginaDescript(), false);
				if (player.hasLongTail() > 0) outputText(" and your flailing tail is held firmly in place by her hand", false);
				outputText(". Her other hand slides into your " + player.vaginaDescript() + " and scrapes around inside, causing an explosion of pleasure inside you. Your love canal grabs her and pulls her arm deeper inside you, your equine muscles making her powerless to resist.", false);
				//[Asses other than tight: 
				if (player.ass.analLooseness >= 2) outputText("  Not wanting this, she attempts to brace her other hand between your " + player.assDescript() + "'s cheeks, but your " + player.assholeDescript() + " opens and she slides inside. With an immense effort she pulls out of your ass, nearly pushing you over the edge in the process, but the arm stuck on your vagina is stuck tight.", false);
				outputText("  It's not long before her hand finds your uterus and begin probing it, pushing you beyond your limit.\n\n", false);

				//[Huge cum amount: 
				if (player.wetness() >= 5) outputText("Your vagina ripples and squeezes with enough force to hurt most normal cocks. Her exoskeleton protects her from the harmful effects though, and with a massive gush of fluids the bee-girl's arm is propelled out of you.", false);
				//[All other cum amounts: 
				else outputText("Your vagina ripples and squeezes with enough force to hurt most normal cocks. Her exoskeleton protects her from the harmful effects though, and she slides her arm out of you as you cum.", false);
				outputText("  In the afterglow you feel the wonderful sensation of something thick and sticky dripping off your back. Craning your neck to look, you see that as she was pleasuring you the bee maiden had also been grinding her box against you. Her own orgasms combined with the effort needed to both fight and pleasure you have clearly taken their toll on the frail looking creature, as she's passed out on top of you.\n\n", false);

				outputText("You trot up to the flower and slide the exhausted creature off of you, then rearrange her to be more comfortable. With a final pat on the head and after collecting your things, you head back to camp on slightly wobbly legs.", false);
			}
			else {
				outputText("Firmly grasping her thighs at the joining of her smooth carapace and soft skin, you force them open, revealing the source of her irresistible scent.   She buzzes pitifully in protest as you disrobe, revealing your " + player.vaginaDescript(0), false);
				if (player.breastRows.length > 1) outputText(" and " + player.allBreastsDescript(), false);
				outputText(".  You waste no time, pushing her down and draping yourself across her body.  You let your ready sex bump her chin as you push her thighs further apart and drink in the scent of her woman-hood.   Mashing your " + player.vaginaDescript(0) + " against her face, you make it very clear what she is to do, and thankfully, the bee-bitch gets the idea and starts licking.  You coo in pleasure, delighted at the length and texture of her tongue as she goes to work.  ", false);
				if (!player.isTaur()) {
					outputText("You return the favor and dive into her muff, planting kisses and licks down as a reward for your victim's rather skilled efforts.\n\n", false);
					//new PG
					outputText("The taste is sweet and sexy all at once, and you quickly lose track of your reward scheme, simply licking and slurping to get as much of her nectar as possible.  ", false);
				}
				//new PG
				else outputText("\n\n", false);
				if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLICK) outputText("Thankfully her tongue keeps up its assault, curling 'round your clit and probing your depths in equal measure, keeping you slick and writhing in pleasure.  ", false);
				if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLICK && player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLAVERING) outputText("Your hips wiggle and writhe on the length of her tongue as it dives into your slippery depths and curls tightly around your clit, jacking it up and down like a cock.  Your girl-cum soaks her chin, drooling happily as she pleasures you.  ", false);
				if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLAVERING) outputText("Your hips quiver and grind against her face as her unusually long tongue simultaneously probes your depths and works your clit, wrapping around it and jerking it like a cock.   You squirt and drool constantly from her skilled assault, soaking her face and hair with your girl-cum.  ", false);
				if (player.clitLength > 3 && player.clitLength < 5) outputText("Your hips piston your huge clit into her mouth with no warning, forcing her to give your clit a blowjob.  Her slick black lips wrap around it immediately, sucking and licking, filling your body with lust and pleasure.  ", false);
				if (player.clitLength >= 5) outputText("Your hips shove your massive clit into her mouth without warning, stretching her slicked lips wide around your very un-womanly appendage.   She reacts immediately, sucking it into her mouth and throat.  Her tongue curls around it and begins to caress it sensually as she lets you hammer it in and out of her open throat.  Instinctively you mash your face into her sweetened cunt, losing all control of your lower body as it face-fucks her with reckless abandon.  ", false);
				//New PG - orgasm
				if (player.isTaur()) outputText("You orgasm in no time, coating her face with girl-cum the process.  You return the favor and dive into her muff, planting kisses and licks down as a reward for your victim's rather skilled efforts.  The taste is sweet and sexy all at once, and you quickly lose track of your reward scheme, simply licking and slurping to get as much of her nectar as possible until she is satisfied as well.", false);
				else outputText("In no time you both orgasm, sweet girl-cum coating both your faces as you work each other's cunt with desperation born of desire.  ", false);
			}
			player.orgasm();
			combat.cleanupAfterCombat();
		}

//FUTA Fallback
		private function futaRapesBeeGirl():void
		{
			spriteSelect(6);
			clearOutput();
			outputText("Firmly grasping her thighs at the joining of her smooth carapace and soft skin, you force them open, revealing the source of her irresistible scent.   She buzzes pitifully in protest ", false);

			if (player.isTaur()) outputText("as you idly fondle your " + player.allBreastsDescript() + " as you feel your blood-gorged " + player.multiCockDescriptLight() + " swaying under your belly.  ", false);
			else outputText("as you disrobe, revealing your " + player.allBreastsDescript() + ", " + player.vaginaDescript(0) + ", and " + player.multiCockDescriptLight() + ".  ", false);
			outputText("You step forwards, straddling her and rubbing your outer lips in preparation.  ", false);
			if (player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_NORMAL) outputText("Your " + player.vaginaDescript(0) + " becomes puffy and moist with excitement, ready for what you have planned.", false);
			if (player.vaginas[0].vaginalWetness > VAGINA_WETNESS_NORMAL && player.vaginas[0].vaginalWetness < VAGINA_WETNESS_DROOLING) outputText("Your " + player.vaginaDescript(0) + " squicks wetly from your gentle ministrations as your vulva become sensitive and engorged.", false);
			if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) outputText("Your " + player.vaginaDescript(0) + " gushes in response, dripping steadily over your victim's face, covering it with a spattering of girl-cum.", false);
			//New PG
			outputText("\n\nWithout warning, you plant your crotch onto her face, gyrating over her mouth as the defeated bee-maiden struggles against you.  ", false);
			//BALLZ
			if (player.balls >= 2) {
				if (player.ballSize < 5) outputText("Your " + player.ballsDescriptLight() + " droop into her eyes, blinding and humiliating her in equal measure.  ", false);
				else outputText("Your " + player.ballsDescriptLight() + " obscure most of her face, making it difficult to see her reactions, but her mouth gives you all the feedback you need.  It doesn't take more than a few moments for her struggles to cease, and soon, her long insectile tongue is worming its way into your " + player.vaginaDescript(0) + ".  ", false);
			}
			outputText("Happy with your victim's compliance, you grind harder into her face.  Allowing your hands a bit of freedom, you begin to stroke your already erect " + player.cockDescript(0), false);
			if (player.cumQ() < 75) outputText(", enjoying the chance to cut loose and explore your male half.  ", false);
			if (player.cumQ() >= 75 && player.cumQ() < 500) outputText(", smearing your hardness in copious pre-cum and reveling at the marvelous sensation it gives you.  ", false);
			if (player.cumQ() >= 500) outputText(".  A few drops of your pre manage to drip onto her face, mixing with the fluids from your cunt.  ", false);
			outputText("You nearly bounce off her in alarm as her tongue probes deep, pressing against and penetrating your cervix in one slippery stroke.  Being licked from the inside out makes you squeal with equal parts surprise and pleasure, and you mash your " + player.vaginaDescript(0) + " harder against her in response.  Your hands masturbate your " + player.multiCockDescriptLight() + " in time with her licks, the speed gradually increasing to keep pace with the fire of your ever-growing lust.  ", false);
			if (player.cumQ() >= 100) {
				outputText(" More and more pre begins to drip from your " + player.cockDescript(0) + ", soaking your ", false);
				if (player.balls >= 2) outputText(player.ballsDescriptLight() + " and ", false);
				outputText("the bee-bitch's face.  ", false);
			}
			if (player.breastRows.length > 0) {
				if (player.biggestTitSize() >= 2) outputText("You free a hand to tend to your " + player.allBreastsDescript() + " and aching nipples, alternating between squeezing your female flesh and tugging on your erect nipples.  ", false);
			}
			outputText("\n\n", false);
			//New PG
			outputText("You moan in ecstasy, your " + player.vaginaDescript(0) + " clamping against her tongue and lips like a vice.  She responds by pulling it from your uterus and swirling it around the inside of your " + player.vaginaDescript(0) + " to stimulate the walls of your trembling love-canal.  ", false);
			if (player.breastRows.length > 0) {
				if (player.biggestTitSize() >= 2) {
					outputText("You pinch a nipple hard", false);
					//Lactation junction!
					if (player.biggestLactation() > 1 && player.biggestLactation() <= 2) outputText(", squirting milk all over the bee-girl's midsection.  ", false);
					if (player.biggestLactation() > 2 && player.biggestLactation() <= 3) outputText(", spraying milk all over your bee-bitch, soaking her completely with your milky-white goodness.  ", false);
					if (player.biggestLactation() > 3) outputText(", hosing milk everywhere, soaking the bee-girl completely.  The force of your orgasm seems to echo through your breasts, making them produce far more milk than normal.  ", false);
					if (player.biggestLactation() <= 1) outputText(".  ", false);
				}
			}
			if (player.balls >= 2) outputText("The warmth and pleasurable pressure of your male orgasm builds in your " + player.ballsDescriptLight() + ", growing stronger as it migrates up your groin to the base of your pulsing member.  You squeeze your " + player.cockDescript(0) + " tightly, trying to hold on a bit longer, but the squirming tongue inside you is too much.  ", false);
			//Mmmmmmangasm!
			if (player.isTaur()) outputText("As you're going to explode, you smile evilly as an idea crosses your mind. You turn around swiftly, leaving her surprised and still in the position of licking your pussy, her slender and squirming tongue out, and her face covered in girl-cum.  ", false);
			if (player.cumQ() < 25) {
				outputText("You erupt, your " + player.cockDescript(0) + " pulsing and spraying ribbons of cum.  You milk your dick hard, pistoning your hand up and down mercilessly, trying to squeeze out every drop.  You watch each burst splatter into the bee-girl's hair and grin cruelly.  ", false);
				if (!player.isTaur()) outputText("Spent at last, you rise up off of her, shivering as her tongue retracts from your woman-hood.", false);
			}
			if (player.cumQ() >= 25 && player.cumQ() < 250) {
				outputText("You erupt, your " + player.cockDescript(0) + " pulsing in your hands and spraying out thick ribbons of cum.  You milk your dick hard, pistoning it relentlessly as it spurts more and more jism.  The orgasm drags on and on, your cum soaking your poor victim's hair and forehead with your sticky white juices.   Satisfied at last, ", false);
				if (player.balls >= 2) outputText("with empty balls, ", false);
				if (!player.isTaur()) outputText("you rise up off her, shivering as her slender and squirming tongue retracts from your " + player.vaginaDescript(0) + ".", false);
				else outputText("you walk away from her smiling, and sated.", false);
			}
			if (player.cumQ() >= 250 && player.cumQ() < 500) {
				outputText("Your " + player.cockDescript(0) + " erupts, writhing in your hands from the force of your orgasm as thick ropes of cum burst from you.   Each pulse of juice seems to drag on and on, each nearly as long as a normal man's orgasm.  Looking down, you see the bee's hair and face totally slimed with your cum, and a puddle forming below her.  ", false);
				if (!player.isTaur()) outputText("You rise up off of her in mid-orgasm, aiming lower and painting her with each blast of seed.  ", false);
				else outputText("You aim right at the oval of her face and paint her with each blast of seed.  ", false);
				outputText("Your " + player.cockDescript(0) + " flexes powerfully with each load, until your victim is soaked from the waist up, her breasts and face plastered with goo.  You sigh contentedly and step away, watching the bee scoop up your leavings in both hands, one going to her mouth, the other to her sweet wet snatch.  Giggling to yourself, you walk away, sated.", false);
			}
			if (player.cumQ() >= 500) {
				outputText("Your " + player.cockDescript(0) + " erupts like a volcano, shooting a constant thick stream of cum that pulses with each clench of your pelvic muscles.  The pressure only seems to increase as your urethra tries to deal with the huge load your body is producing.  ", false);
				if (!player.isTaur()) outputText("You stand up off your victim, letting her tongue slip free from your soaked folds, and", false);
				else outputText("You", false);
				outputText(" plunge your " + player.cockDescript(0) + " deep into the bee-girl's mouth and throat, pumping cum directly into her belly.  She writhes underneath you, her oxygen supply cut off as your spunk floods her belly.  The feeling of her inhuman lips wrapped tight around your base only makes it worse, intensifying the eruption of baby-batter that's pumping into her.  Her eyes roll back as cum begins leaking from her nose, her belly beginning to look distended and pregnant with the amount of jism you've pumped in.   Certain she's had enough, you pull free, marveling at how your last spurt made her look nearly nine months pregnant.   You note she's passed out, but your orgasm is far from over, so you resume jacking off, hosing her down from head to toe in thick white goop.  ", false);
				if (player.balls >= 2) outputText("Your balls eventually empty", false);
				else outputText("Your body's cum supply eventually empties", false);
				outputText(", and you turn your back on your soaked, cum-bloated conquest and the puddle of spooge that's rapidly wicking into the ground.", false);
			}
			player.orgasm();
			combat.cleanupAfterCombat();
		}

//(can replace normal rape victory scenes if corruption>75, and strength>60, and while player has naga tongue, dick, vagina, or d-cup or larger breasts)
		private function beeGirlRapeForTheDistinguishedGentleman():void
		{
			spriteSelect(6);
			clearOutput();
			//(if win via HP)
			if (monster.HP < 1) outputText("The bee-maiden staggers backward against her perch and wheezes.  Quickly, you launch yourself forward and pin her bodily against the giant flora, grabbing her feebly thrashing arms.  In a flash of inspiration, you pull a long supple leaf from the underside of the blossom, twisting it lengthwise and managing to bind her hands to the stem above her head with your makeshift cord before she can focus on what's happening.\n\n", false);
			//(if lust win)
			else outputText("The bee-girl's knees buckle together and she starts fingering her pussy desperately, too preoccupied to take any offensive posture.  You suavely stroll up to her with a toothy smile and, laying one arm around her waist, gently push her backwards against the giant flower she sat on before.  As she looks at you with interest and confusion displayed equally across her face, you pull a long supple leaf down from the underside of the flower and twist it lengthwise to make a sort of grass rope.  You guide her hands together above her head and tie them to the stem there, quite pleased with your own ingenuity.\n\n", false);
			//---------------------------------

			outputText("Momentarily lost in thought as to where you want to go from here, you don't notice the now-bound and irritated bee's last attempt to turn the tables as her stinger slowly slides free and her abdomen lifts into position to employ it.  ", false);
			//[(if spd<50)
			if (player.spe < 50) outputText("Bracing against the stem and lifting her legs, the bee snaps her stinger up and catches you in the arm, injecting a good amount of venom before you can twist your body away from her wickedly-tipped rear end.  With your other arm you grab hold of the thick fuzz on her bloated abdomen.  This bee bitch really doesn't know her place!  Staring down at the hateful stinger, your eyes drift upwards a bit to the soft area concealing her shriveled black ovipositor, and the anger and pain boiling in you mixes with your already-corrupt thoughts to give you an idea for revenge.", false);
			else outputText("Bracing against the stem and lifting her legs, the bee-maiden flips up her abdomen and the stinger darts towards your side.  Acting quickly, you roll away from it and down, bringing up your arm to hold the bee's abdomen in the air so she can't maneuver it into position for another stab.  What a poor loser this bee-girl is!  Your gaze tracks across the abdomen, taking in the angry little point and the soft spot next to it concealing the bee's ovipositor, and an idea starts to come together in your corrupted, novelty-crazed head.  Grinning even wider, you waggle one finger in reproof at the frightened bee.", false);
			outputText("\n\n", false);

			outputText("Gripping the abdomen firmly by the fuzz, your free hand parts the soft flesh and begins caressing the bee's diminutive black ovipositor, which responds eagerly by growing in size and peeking out.  Within moments your dexterous stimulation has rendered the organ into a knotted shaft and sent the bee herself into a happily-buzzing stupor.\n\n", false);

			//[random effects: roll for one
			var choices:Array = [];
			if (player.tongueType == TONGUE_SNAKE) choices[choices.length] = 0;
			if (player.hasCock()) choices[choices.length] = 1;
			if (player.hasVagina()) choices[choices.length] = 2;
			if (player.biggestTitSize() >= 4) choices[choices.length] = 3;
			var select:Number = choices[rand(choices.length)];

			//(if naga tongue)
			if (select == 0) {
				outputText("As you work your hand up and down the burgeoning black growth, the tip of it opens up roughly an inch and begins to secrete a honey-like fluid that smells of both sweetness and sex pheromones.  In fact, as your oversensitive elongated tongue flits between your lips tasting the air, you decide it's the most appealing smell you've noticed in years!  Almost unintentionally you follow the intoxicating, hypnotic aroma, moving your face closer and closer to the bee-girl's bumpy ovipositor until you're right on top of it.  Finally losing all restraint, you slip your snake-like tongue out of your mouth and down the hole, and you explode with a moan at the incredible taste as the bee-girl simultaneously squeals with rapture at the added stimulation.  Her cunt orgasms and squirts a gob of honeyed juice that hits you right in the side of the face, but you don't care as you're too busy licking up every drop you can find on the slick inner walls and around the mounting number of eggs themselves; bringing up mouthfuls of the amazing substance with your engorged tongue.  You lick for minutes that stretch on like hours and the pheromones in the stuff set off several orgasms of your own", false);
				//[(if penis then)
				if (player.hasCock()) outputText(", spraying the fuzzy side of the bee's abdomen with your sticky come,", false);
				outputText(" before you get enough.  Ahh, who knew that stuff would be this much better when it was still fresh in the bee?  You feel a strong urge to take the girl home with you and make her your 'pantry', but you groggily realize that she has to be fertilized with eggs by the queen bee before she produces your treat.  Shaking your head to clear the sugary haze, you take a firm grip on the bee's knob and decide to enact your original plan now; maybe you can capture the queen later.\n\n", false);
				//(gain 2 libido and 2 sensitivity)
				player.orgasm();
				dynStats("lib", 2, "sen", 2);
			}
			//(if penis)
			else if (select == 1) {
				outputText("Seeing the girl's resistance end in an eye-rolling gasp, you decide to get in on the fun too.  With some difficulty you unfasten and shed the bottoms of your " + player.armorName + " with your one free hand and maneuver your " + player.cockDescript(0) + " to her now-gushing honeypot.  Considering there's enough foreplay going on with her ovipositor to wet her enough for a minotaur, you unceremoniously slam your " + player.cockDescript(0) + " into her.", false);
				//[(if dicksize>beevagdepth)
				if (player.cockArea(0) > monster.vaginalCapacity()) outputText("  The bee-girl barely winces as the head of your shaft bumps up painfully against her cervix, quickly returning to a rictus of ecstasy as you continue jerking her ovipositor off with your now-sticky hand.", false);
				outputText("  You work up a solid rhythm of fucking the poor girl's sopping snatch and tugging on the grotesque black shaft, never taking your eyes off the bulges forming at the base of her tumescent organ.  Soon you see the telltale bumps of eggs starting to slide into position for a deposit and you grip down harder while jerking the bee-girl off to build up an even bigger load.  Despite her whimpering, she convulses in orgasm from the dual stimulation and her body obliges you, sending up another batch of ready eggs.  The increased pressure forces a squirt of her nectar through despite your tight grip, shooting it nearly a foot in the air before it falls back down and wets the soft fuzz of her abdomen.\n\n", false);
			}
			//(if vagina)
			else if (select == 2) {
				outputText("As the bee-maiden's tongue lolls out of her mouth and she buzzes weakly in pleasure you relax your grip on the downy fuzz of her abdomen and concentrate on the knotty stalk that's steadily growing in your hand.  Thinking to yourself that you might as well have a little extra fun before you go ahead with your idea, you manage to unfasten the bottom part of your " + player.armorName + " one-handed.  After you step out of your clothing, you raise your leg up and straddle the bee's abdomen, then slide your " + player.vaginaDescript(0) + " down the ticklish fuzzy surface.  The uneven rubbing sensation elicits a gasp of surprise from you.  You feel your " + player.clitDescript() + " poke out as the fuzz slowly rubs your labia enroute to your anticipated destination. Reaching the end containing the sting and the now-throbbing ovipositor, you lift up your body and position your " + player.vaginaDescript(0) + " over the latter, then plunge down as honey splashes out of the bee's business end and into your slick folds.  Using one hand wrapped around the stinger to keep it pointed away and the other to grasp a patch of fuzz not yet slicked-up by your pussy juices, you start pumping the black bulging shaft in and out of you.  The honey that escaped into you starts squishing out mixed with your own natural juices, and the increased slickness just makes every thrust that much hotter.  After several minutes of wet penetration you feel the bee-girl's erstwhile invader develop a bumpier pattern and recognize that her eggs must be getting ready to erupt; a few get pushed out by the twitching knob into your pussy, giving you a little shiver of extra pleasure.  You quickly rise up off the bee-girl and grasp the ovipositor firmly while the prematurely-released eggs slip out of your drenched slit and fall onto the ground.\n\n", false);
			}
			//(if D+ breastsize)
			else if (select == 3) {
				outputText("Noticing the bee abating her thrashing resistance in favor of buzzing pleasantly and fixing you with beseeching gazes, and seeking some way to get yourself closer to orgasm so you can climax at the same time as you bring your plan off, you absently stroke the bee's knob as you clumsily unfasten and remove the top part of your " + player.armorName + " with one hand.  Casting it aside, you give an involuntary shudder as a gobbet of warm fluid spattering from the engorged black shaft flies up and lands on your now-exposed " + player.breastDescript(0) + ".  With your free hand you smear the sensual pheromone-enhanced fluid around your chest, making sure the area between your cleavage is slick, and sending further shivers from your sensitive breast-flesh down your body.  Bending over the increasingly-knotty appendage, you trap it between your " + player.breastDescript(0) + " and start pushing them up and down its length, all the while tweaking your " + player.nippleDescript(0) + "s viciously.  The bee-bitch's black pseudo-cock develops new bumps as eggs move up the tunnel in response to your ministrations, rather resembling a far-fetched sex toy.  You pinch your nipples together in one hand and give a little moan while the other hand slides to the tip of the ovipositor and grabs firmly to hold the eggs in until you're ready for her to release them; and then you start sliding your pair of pinched and sensitive nipples up and down the far side of the girl's bumpy rod.  As the eggs backlog in the tool you hold your " + player.nippleDescript(0) + "s in place around the wet expanding stalk, letting the arriving spheres give you an irregular massage that pushes you to the verge of climax.\n\n", false);
			}

			outputText("You pull your body apart from hers; the bee-maiden's euphoric buzzing takes on a note of panic as her body tenses to release another load of her eggs, only to be prevented yet again by your firm grip on her member.  You make eye contact and smile diabolically, asking if she's ready to release all her pent-up eggs.  She nods vigorously at you and starts pumping her abdomen up and down of her own volition, working her tool into your slick fist and humming with renewed enthusiasm.  You bend her abdomen lightly upward towards your " + player.buttDescript() + " and her thrusting takes on a quicker pace as she imagines finally getting her load into your " + player.assholeDescript() + ".  Suddenly you spin around, moving your free hand under the bee's lower abdomen, and push upward and in, HARD.  The poor bewildered bee-girl, already in the middle of an eager upward thrust and directed by your hands' guidance, spears her own pucker with the tip of her ovipositor while the stinger lands directly in her glistening cunt.  Her harmonic humming instantly changes to an ear-splitting vibrato scream as the forceful anal penetration and the venom surging through her sensitive box combine with the agony you've inflicted by twisting her abdomen so severely; but the pain isn't enough to keep her now-massive black ovipositor from forcing out every egg it can now that its end is once again open.  The release of the pent-up eggs triggers another orgasm in the abused bee's body, increasing the sensitivity and therefore the pain of her envenomated cunt and spurring another load of eggs down her damaged abdomen to launch into her own rectum.  Her pained wail reaches an incredible intensity as she orgasms over and over inside herself and you busy the hand you're not using to hold her abdomen in place to ", false);
			//[(if dick)
			if (player.hasCock()) outputText("stroke your " + Appearance.cockNoun(CockTypesEnum.HUMAN), false);
			else if (player.hasVagina()) outputText("rub your " + player.vaginaDescript(0), false);
			else outputText("tweak your " + player.nippleDescript(0) + "s", false);
			outputText(", laughing as you climax", false);
			//[(if dick, squirter vag, or lactating)
			if (player.hasCock() || player.lactationQ() >= 100 || player.wetness() >= 5) outputText(" and spray your sticky fluids all over her tortured groin", false);
			outputText(".\n\n", false);

			outputText("Damn, that probably did some ear damage but was it ever worth it!  The bee-girl, having finally redirected every egg she had into her own swollen butthole and ceased climaxing, passes out.  You gather your things and leave her contorted and soaked body behind you as you head back to camp.", false);
			//(gain 20 fatigue if spd<50)
			if (player.spe < 50) player.changeFatigue(20);
			player.orgasm();
			combat.cleanupAfterCombat();
		}


		private function beeAlternate():void
		{
			spriteSelect(6);
			var x:Number = player.biggestCockIndex();
			var y:Number = player.biggestCockIndex2();
			//MULTIPLE MULTIPLE SCENES!
			if (rand(2) == 0) {
				outputText("The dazed bee-woman stumbles, and you grab her abdomen just above the stinger.  Lifting it high, you force her onto her knees, and then bend her over, lowering her antennae to the ground.  With a heroic effort, you force her stinger into her own shoulder.  The bee-girl thrashes wildly for a moment, then moans as the venom you've forced her to inject into herself begins to take effect.  Her motions become less frantic and more wanton, and thick honey begins to drool from her exposed pussy, some of it dribbling down her inner thighs.", true);
				//New PG
				outputText("\n\n", false);
				if (player.cocks[x].cockType == CockTypesEnum.TENTACLE) outputText("You loosen your " + player.armorName + " and unleash your cocks.  The largest cock - a tentacle - strains towards the bee-girl's pussy, clearly eager to sink itself into her warm, sticky confines.  Taking it in hand, you guide the mushroom-like glans against her pouting netherlips.  The bee-girl gasps and squirms, her motions clearly more in eagerness and humiliation than any serious attempt to escape.  You drag the broad head of your tentacle-cock up and down, gathering a thick coating of honey on it before releasing it.  Your cock strains against her folds, then sinks in slowly as you push your hips forward, and you sigh happily as you feel her warmth surround you.  She moans and arches her back even more, her antennae drooping submissively as your agile phallus squirms about inside her, stretching her tight little passage and leaving no nook or cranny unexplored.  ", false);
				if (player.hasKnot(x)) outputText("You loosen your " + player.armorName + " and unleash your cocks.  Taking the largest in hand, you stroke its knobby shape until it's sufficiently stiff, then press the pointed end against her clit, teasing the little nub.  The bee-girl gasps and squirms, pushing her now pouting clit back against you.  You drag the tip up, gathering honey as you go until you reach her opening, then thrust with your hips.  Her pussylips part eagerly, and you find her tight but welcoming.  Still, as tempting as it is to rut the girl with abandon, you hold back, never letting your knot sink inside her.  ", false);
				if (player.cocks[x].cockType == CockTypesEnum.HORSE) outputText("You loosen your " + player.armorName + " and unleash your cocks.  The equine flare of the largest is already drooling pre as you enjoy the sight of the helpless, squirming bee-girl.  Swinging it like a flogger, you spank her ass, making the girl yelp and leaving trails of sticky pre across the globes of her ass.  Grinning, you drag your shaft back and forth across her pussy, slicking it in her honey.  Finally, you press the tip against her opening.  She's a tight fit for you, and she squeals more loudly as your shaft spreads her little cunny inexorably.  ", false);
				//Catchall scenario
				if (player.cocks[x].cockType == CockTypesEnum.DEMON || player.cocks[x].cockType.Index > 4) outputText("You loosen your " + player.armorName + " and unleash your cocks.  The glans of the largest is already drooling pre as you enjoy the sight of the helpless, squirming bee-girl.  Guiding it forwards, you spank her ass, making the girl yelp and leaving trails of sticky pre across the globes of her ass.  Grinning, you drag your shaft back and forth across her pussy, slicking it in her honey.  Finally, you press the tip against her opening.  She's a tight fit for you, and she squeals more loudly as your shaft spreads her little cunny inexorably.  ", false);
				//CONTINUE
				outputText("You enjoy loosening the girl up and exploring the depths of her cunt, taking your time.  Eventually, you draw yourself out of her, your " + player.cockDescript(x) + " escaping with a wet, slurping sound, dragging a thick drool of honey in its wake.  Taking a moment to inspect your handiwork, you see her pussy gapes wantonly, stretched out of shape by your shaft.", false);
				//New PG
				outputText("\n\n", false);
				//2nd cock love
				outputText("Taking your slightly smaller " + player.cockDescript(y) + " in hand, you slip it in as a replacement.  She's not as tight as she was, poor dear, but just as warm and twice as slick as she was for your first " + player.cockDescript(x) + ".  Your larger " + player.cockDescript(x) + " slides along the side of her ass, painting the black-and-yellow fur there with her honey and matting it down.  But that's less than satisfying, and glancing down, you notice she has a hole back here that's not getting used.  ", false);
				outputText("Withdrawing from her once more, you set the tip of your largest " + player.cockDescript(x) + " against the pucker of her ass.  She squeals and bucks as you press against her sphincter, but it's not long before the ring of muscle surrenders and your honey-soaked " + player.cockDescript(x) + " slides into her body.  She whimpers in humiliation, hands clawing at the grass as she shifts her hips to try to get more comfortable around your thickness.  You root around in the exquisite tightness of her ass, enjoying the way she shifts and wriggles under and around you.", false);
				//New PG
				outputText("\n\n", false);
				outputText("Drawing nearly, but not entirely, out of her, you take up your next largest cock and set it back at the entrance of her pussy again, and then thrust with your hips, sinking your largest deep into her ass while spearing her once more, burying your " + player.cockDescript(y) + " in her pussy.  She squeals loudly, wings flapping wildly a moment, then goes utterly limp with a whimper of surrender.  Grinning broadly, you begin to piston in and out of her, the sweet perfume of her lust wreathing your nostrils.  The plundering of her nether-regions fills the air with wet, slurping sounds, and soon she is moaning in time with every thrust, antennae quivering with need.  ", false);
				outputText("You feel the pleasant quickening in your shafts and you redouble your efforts, fucking her harder with every thrust until, with a gasp of release you arch your back and nearly push her across the grass.  Your quivering cocks tremble in her depths, flooding her body with your seed.  The bee-girl lets out a trilling, buzzing shriek, then goes limp around you, her quivering muscles milking you of your seed.  Panting, you slip from her now-gaping holes.  The poor dear appears to have passed out; she slumps onto her side, your seed drooling out of her twitching body.  After wiping yourself clean on her fuzzy thigh, you arrange your clothing and search about for any loot the bee-girl may have had.", false);
			}
			else {
				outputText("After falling to the ground, the bee-girl looks up in dazed fear as you expose your " + player.multiCockDescriptLight() + ", her eyes watching as you throb with lust at the scared and helpless look on her face.", false);
				//New PG
				outputText("\n\n", false);
				outputText("Once you're close enough, you grab her by the arms and force yourself down against her, shifting your knees to spread her legs.  Your " + player.multiCockDescriptLight() + " slap down against her slightly slick " + Appearance.vaginaDescript(monster,0) + ". Her face lights up with a look trapped somewhere between apprehension and interest at the unexpected touch, although the interest doesn't stop her from struggling valiantly to try and get away from you.  Finally, you force her arms against the ground and spread her wide enough to impale her " + Appearance.vaginaDescript(monster,0) + " on one of your " + player.multiCockDescriptLight() + " while watching her face contort with an alluring mixture of enjoyment and pain.  Her struggles weaken as you start to pound into her, tight abdominal muscles relaxing under you as she throws back her head, releasing a whimper at the rough penetration.  ", false);
				outputText("At first, taking her more than satisfies you, but an idea strikes as you watch her face become distracted with each body-shaking thrusts of your hips.  Grabbing your remaining " + player.cockDescript(y) + " you push it against the already-impaled member, and on the next thrust you drive them both in.", false);
				if (player.averageCockThickness() > 2) outputText("  She stretches against you amazingly, squeezing down on you like a vice.  You theorize it's only because of her strange body and the copious amounts of honey she's leaking against you that you aren't ripping her apart.", false);
				//New PG
				outputText("\n\nThe bee-girl shakes violently and screams in equal parts buzz and moan as a thick torrent of honey splashes against your dual members, making the pair of them slide in that much easier.  Her arms move up, the free one grabbing at your shoulder and clutching hard enough to leave bruises while the other squirms under your hand, her body tense under you. Stretched to the brink by the pair of " + player.multiCockDescriptLight() + "s, her hole is like a vice against you and every thrust visibly stretches her. The more you thrust the wetter she gets and her eyes seem to be wildly fluttering underneath you as you take her, her struggles turning to her thrusting her lower body up against you appreciatively. Your " + player.multiCockDescriptLight() + "s slap and pound into her abused " + Appearance.vaginaDescript(monster,0), false);
				if (player.balls > 0) outputText(" with your " + player.ballsDescriptLight() + " hitting her abdomen hard enough to make smacking sounds ring out in the forest around you.", false);
				else outputText(".", false);
				//New PG
				outputText("\n\n", false);
				//Extra multicock text
				if (player.cocks.length >= 3) {
					outputText("As you pound into her, you realize that large amounts of her juices are leaking from her " + Appearance.vaginaDescript(monster,0) + " over her abdomen, against the hole near the base of her stinger.  Reaching down with wicked intent, you grab one of your free " + player.multiCockDescriptLight() + "s and force it against her tight asshole while you pull your hips back.  Her eyes widen as she looks up at you, renewing her struggles as she kicks her legs at you, her wings slapping the ground with fierce determination as she tries to wriggle away.  You hold her tightly, pushing your hips against her to bury your " + player.multiCockDescriptLight() + " inside her.  The flow of honey barely lessens the friction as your " + player.cockDescript(2) + " sinks into her ass inch by inch.  Her " + Appearance.vaginaDescript(monster,0) + " is stretched even wider and she screams out something that sounds like a humming moan as her asshole begins to gape a bit with each of your thrusts. It takes a minute or two, but finally you hit bottom with all three of your " + player.multiCockDescriptLight() + "s.\n\n", false);
				}
				//Orgasm PG
				outputText("After a while of fucking her, her buzzing complaints and wild struggles begin to melt as she cums against you, shuddering and forcing her hips up towards you, plunging your " + player.cockDescript(x) + " into her even deeper.  She begins to climax, her muscles becoming more and more relaxed with each time her stretched holes squeeze down on you.  Surges of pleasure begin to overwhelm you and soon you begin fucking her as hard as you can, honey splattering wetly over her body as she finally seems to collapse under your body's assault. Her eyes dim visibly, the buzzing cries of pleasure echoing faintly from her lips while her body goes completely limp underneath you.  Not to be stopped, you continue to take her, eventually feeling seed swell up inside ", false);
				if (player.balls > 0) outputText("your " + player.ballsDescriptLight() + " ", false);
				else outputText("your prostate ", false);
				outputText("as you plunge into her. Your release is very large, splattering her slick walls with thick loads of cum as you plunge as deep as you can thrust inside her.", false);
				//Lots of cocks bonus cum texts
				if (player.cocks.length >= 3) {
					outputText("  Her battered " + Appearance.vaginaDescript(monster,0) + " grips down on your dual " + player.multiCockDescriptLight() + "s tightly, draining you of every drop she can.  Rivers of white begin to leak from her abused holes and mingle with her own release as it trails down her abdomen and drips off it slowly onto the forest floor.", false);
					if (player.cocks.length == 4) outputText("  The " + player.cockDescript(3) + " not inside her shakes wildly as you cum; jets of your semen let loose over her abused frame, coating her in white.", false);
					if (player.cocks.length > 4) outputText("  The " + player.multiCockDescriptLight() + "s not inside her shake wildly as you cum; jets of your semen let loose over her abused frame, coating her in white.", false);
				}
				//New PG
				outputText("\n\n", false);
				outputText("The both of you smell like sex as you pull free of her with a groan.  You move to kneel over her and use her unstained lips to dry your " + player.multiCockDescriptLight() + " one by one.  Her lips part slightly on instinct and you can feel her swallow the globs of jism that coat you.  Once she's done you stand up quickly, ", false);
				if (!player.isTaur()) outputText("stuffing your " + player.multiCockDescriptLight() + " inside your " + player.armorName, false);
				else outputText("your glorious but spent " + player.multiCockDescriptLight() + " dangling under your belly,", false);
				outputText(" and leave the completely exhausted and drenched woman on the forest floor, wings and legs still twitching slightly, sending a fine mist of cum across the ground around her.", false);
			}
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
			combat.cleanupAfterCombat();
		}

//Naga on Bee Scene
		private function corruptNagaBitchesRapeABee():void
		{
			spriteSelect(6);
			clearOutput();

			outputText("Now that the bee-girl is unable to flit her wings and create that buzzing drone that seems to rob you of your senses, you can see her for what she truly is: Prey.\n\n", false);

			outputText("She struggles against the coil of your tail, but her thin limbs are nothing compared to the rippling cord of muscles that makes up your lower half. You can feel her abdomen pulsing as if trying in vain to sting you, but you have her completely immobilized. \"<i>Pleazzze,</i>\" she begs, \"<i>Don't hurt me... I juzzzt wanted to zzzerve my queen.</i>\"\n\n", false);

			outputText("You stare into her eyes with your reptilian gaze and flit your tongue in response, as much to increase her anxiety as to taste her heat and her fear with the vomeronasal organ in the roof of your mouth. Even from here, you can taste the fragrant liquid dripping out of her honeypot and coating your scales. Though it is divine, you know you are in complete control.\n\n", false);

			outputText("She shuts her eyes out of fear at first.  \"<i>Pleazzze,</i>\" she continues to plead for her life, \"<i>Don't eat me! I have children! Thousandzzz of them!</i>\" You ignore her cries and gaze mercilessly at her – savoring her desperation. As time passes, she comes to realize that she hasn't been eaten yet. The bee-girl opens her eyes slowly, one after the other – and that's when you know you have her.\n\n", false);

			outputText("\"<i>What...</i>\" she asks hazily, \"<i>What are you zzztaring... at...</i>\" Her words begin to trail off as your gaze locks with hers, hypnotizing her. You watch as her lids begin to droop, and you can feel her muscles becoming slack within your coils. The emotionless expression you're wearing hides the sheer delight you feel.\n\n", false);

			outputText("It takes a few minutes, but you relish every second of the bee-girl's conscious mind slipping away. You unwind your tail from around her, never breaking your gaze for even a second. To your pleasure, your captive continues to stand still on her own volition.", false);
			doNext(nagaRapesPt2TheExtremeContinuationOfAwesome);
		}

		private function nagaRapesPt2TheExtremeContinuationOfAwesome():void
		{
			spriteSelect(6);
			clearOutput();
			//[Player is male]
			if (player.gender == 1 || (player.gender == 3 && rand(3) == 0)) {
				outputText("By now ", false);
				if (player.cockTotal() > 1) outputText("each of ", false);
				outputText("your " + player.multiCockDescriptLight());
				if (player.cocks.length == 1) outputText(" is");
				else outputText(" are");
				outputText(" aching for release, and you tear off your " + player.armorName + " just in time as ", false);
				if (player.totalCocks() > 1) outputText("they free themselves from ", false);
				else outputText("it frees itself from ", false);
				outputText("the slit between your legs.  Without needing to say a word, the message is transferred across some unknown medium: Suck my cock", false);
				if (player.totalCocks() > 1) outputText("s", false);
				outputText(".\n\n", false);

				outputText("The bee-girl drops to her knees and stares up at you vacantly. Your eyes never break contact: not while she wraps her tongue around ", false);
				if (player.totalCocks() > 1) outputText("one of ", false);
				outputText("your " + player.multiCockDescriptLight() + ", slurping soundly and driving you wild; ", false);
				//[if player has testicles] 
				if (player.balls > 0) outputText("Not while her hands cup your " + player.sackDescript() + " and knead tenderly, infusing you with the craving for release; ", false);
				else outputText("not ", false);
				outputText("even when she takes your " + player.cockDescript(0) + " to the hilt, her eyes straining up in their sockets. You watch " + int(player.cocks[0].cockLength) + " inches of " + player.cockDescript(0) + " disappear inside her mouth, and the vibrations in her throat tell you that you'd hear her cooing if it wasn't packed tight.\n\n", false);

				outputText("Higher and higher you climb as your hypnotized handmaiden ceases stroking you with her lips and begins swallowing repeatedly, milking your hardness for all it's worth. Her chest begins to contract, and from the periphery of your vision you can tell that she's futilely trying to gulp in air. The contractions force her to milk you even more; ", false);
				//[if player has testicles]
				if (player.balls > 0) outputText("your " + player.sackDescript() + " clenches as ", false);
				outputText("you explode inside her chest, ", false);
				//[normal cum load]
				if (player.cumQ() < 50) outputText("a burst of cum settling itself in her belly.", false);
				//[medium cum load]
				else if (player.cumQ() < 1000) outputText("rope after rope of cum shooting into her belly.", false);
				//[large cum load]
				else if (player.cumQ() < 2500) outputText("waves of cum pumping into her belly and visibly bulging it out.", false);
				//[huge cum load] 
				else outputText("an unending stream of cum gushing into her belly and stretching it out significantly.", false);
				outputText("  Just as her eyes start to roll back into her head, you pull out to the sound of her desperate gasp for air.\n\n", false);

				outputText("You check her unconscious form – now lying on the ground – for signs of life. Relieved that she is breathing, you turn and leave her where she is.", false);
			}
			//[Player is female]
			else if (player.gender == 2 || (player.gender == 3 && rand(2) == 0)) {
				if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_WET) outputText("Damp", false);
				else if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_DROOLING) outputText("Wet", false);
				else if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLAVERING) outputText("Dripping", false);
				else outputText("Soaking", false);
				outputText(" with lubrication, you demand to be satisfied. With one hand you point to your " + player.vaginaDescript(0) + ", and you snap your fingers with the other. Your prey saunters up to you with a vacant, distant look in her eyes and begins to remove your " + player.armorName + " obediently. You tenderly caress her cheek as she finishes, and watch a rosy glow infuse her skin. Your captive handmaiden runs her hands tenderly up your body, smoothing the flesh of your " + player.biggestBreastSizeDescript() + " and making you pant. You allow yourself to enjoy the sensation for a brief while, and just before you can snap your fingers again, she goes down on her own.\n\n", false);

				outputText("Her eyelids flutter even as her gaze remains locked, and she deeply inhales your musky and arid scent. Deep inside, you feel a level of affection that isn't betrayed by your facial features. You gasp as the bee-girl's lengthy tongue shoots inside your snatch, and retracts as quickly as it came; once, twice, again and again, striking your cervix and twisting out again. Her hands grip your scaly " + player.hipDescript() + " as she thrusts her tongue in and out, threatening the fixation of your glare with pleasure. You are moaning and screaming in your mind, while your stony expression betrays nothing; nothing but the locking gaze that makes your will her own. The bee-maiden's mouth wraps around your " + player.clitDescript() + ", rubbing it through its hood with the inside of her upper lip until it protrudes its full length.", false);
				//[if clit size => 1"]: 
				if (player.clitLength > 1) outputText("  Emergent from its sheath, she uses the base of her tongue as a bottom lip and begins to suck you off like a cock, unceasing in her lingual assault on the inside of your canal.", false);
				outputText("\n\n", false);

				outputText("You cry out when her tongue finds your G-spot, barely maintaining focus. Sensing your approval, she begins probing the same area until she has you crying out again, and begins hammering at the spongy tissue.\n\n", false);

				outputText("A feeling like the urge to pee overwhelms you, and lost inside to your pleasure, you give in.  ", false);
				if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLICK) outputText("A few drops ", false);
				else if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_DROOLING) outputText("A gush ", false);
				else if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLAVERING) outputText("Wave after wave ", false);
				else outputText("Buckets ", false);
				outputText("of female ejaculate sluice down her cheeks and she coos happily. She retracts her tongue and presses her face into your tender flesh, pantomiming affection but still looking up at you blankly.\n\n", false);

				outputText("You let yourself blink and break the hypnotizing glare, watching as life returns to her features. You pet her head affectionately and thank her, leaving her to piece together what the hell just happened.", false);
			}
			//[Player is herm]
			else if (player.gender == 3) {
				outputText("Fantasies course through your mind as you remove your " + player.armorName + ", filling your thoughts with all the things you can do to your mind-slave using your particular... endowments. Licking your lips, you bring your hand to the bee-girl's chin, gently moving her pretty face from side to side and examining her in your peripheral vision. Her eyes stay glued to yours even as you move her around. You're going to enjoy this.\n\n", false);

				outputText("You place a hand on top of the bee-girl's head, and watch as she drops to her knees, craning her head to continue looking up at you. With a fistful of hair in one hand, you point to her wrist and crook your finger in a 'come hither' motion, and gesture towards your scaly snatch. Like clockwork, her arm reaches up and two fingers go inside you, seeking out and quickly finding that spot of spongy tissue up and behind your pubic bone. You begin to pant involuntarily as she starts to work it rhythmically. You let her settle into a steady pace before moving on to her next task.\n\n", false);

				outputText("Touching a single index finger to the underside of your captive's chin, you pull with the slightest of forces and watch as she is dutifully drawn to your " + player.multiCockDescriptLight() + ", running her lengthy prehensile tongue up and down ", false);
				if (player.cockTotal() > 1) outputText("each of your shafts", false);
				else outputText("your shaft", false);
				outputText(". As the pulsing movement inside your body draws you slowly closer to orgasm, the bee-bitch uses her other hand to draw your " + player.cockDescript(0) + " down to an angle so it slides neatly into her throat", false);
				//[if Player cock => 12\"]
				if (player.cocks[0].cockLength > 12) outputText(", surprising you with its elasticity", false);
				outputText(".", false);
				//[if Player has multiple cocks]
				if (player.totalCocks() > 1) {
					outputText("  Letting go once it is fitted neatly inside, she uses her free hand to stroke your other cock", false);
					//[three or more]
					if (player.cockTotal() > 2) outputText("s, giving each a few pumps before moving on to the next", false);
					outputText(", driving you closer and closer to the edge.", false);
				}
				outputText("\n\n", false);

				outputText("Gulping, slurping, ", false);
				//[if Player has multiple cocks]
				if (player.cockTotal() > 1) outputText("jacking, ", false);
				outputText("and finger-fucking in tandem, you can't help but admire the fragile creature giving you such unpronounceable pleasure. It isn't long before the tenacious beauty has you riding over the edge, and your transfixing gaze is almost broken as the orgasm explodes out of your orifices, drenching her and firing down her throat. As her chest starts to heave from lack of oxygen, you pull out, turn, and leave her there in a heap.\n\n", false);
			}
			//[Player is neutered]
			else {
				outputText("Trapped inside your gaze, you tower over your captive and figure out how to proceed. Your lack of genitals requires you to come up with some creative solutions, and you decide to put your right brain to the test. For a moment, the two of you remain motionless save for the occasional flick of your tail. That's when you get an idea.\n\n", false);

				outputText("You press the flat of your hand into her chest, indicating her to lie down. With some effort, she lowers herself awkwardly into a prone position, shimmying over her own abdomen and unable to look away. You position yourself between her legs and run your hands down the bulbous protrusion emanating from her tailbone; carefully, to avoid her stinger. Feeling your way around with your hands, you locate a fold of flesh just above the poisonous barb, and having found what you were looking for, unflinchingly insert a finger. It comes back out coated in a slick yellow goo that delights your senses of taste and smell. You return your hand; first with two fingers, and then three. An appendage textured with bumps and knots with an orifice at its tip begins to emerge, and you know you have found your target.\n\n", false);

				outputText("The bee-girl's expression is blank and vacant, but you can tell by the heat coming off of her, the fresh smell of her pheromones and the flush of her skin that she is getting off on it. You bunch your fingers together to form a point, tucking your thumb as close into your palm as it will get, and slide your fist inside her ovipositor.\n\n", false);

				outputText("Despite her hypnotic state, the bee-girl's mouth opens and her breathing becomes heavy. Her eyes remain fixated on yours in spite of the violation, devoid of consciousness. Warm wetness surrounds first your fingers, and you can feel the elastic flesh straining against your knuckles before giving way with a satisfying slurp. Displaced honey oozes out around your wrist, then your forearm, and finally your elbow. Something brushes against your fingers – an egg! Not wanting to push any deeper for fear of damaging your delicate host, you pull back a few inches and ball your hand into a fist.\n\n", false);

				outputText("You pull your arm back out to the wrist, coated with a thick layer of the bee-bitch's internal fluids, before punching back inside carefully to avoid damaging any eggs. Thinking this an amusing time to let her come back to reality, you break the glare that has been keeping your plaything rapt and attentive, and start thrusting with vigor. There is a brief moment of confusion before the stimulation catches up to her, and quickly you have her screaming and thrashing so much that you have to hold her stinger down with your other hand. You bend your head down towards her clit, and with a single flicker of your forked tongue, send her into a mind-shattering orgasm that scares away the birds for miles.\n\n", false);

				outputText("You pull your hand out and futilely try to wipe away the gunk on a nearby bush. The handmaiden is collapsed in a heap, excreting eggs from her dilated organ, mumbling blissfully delirious nonsense.  Gathering your things, you slither away.", false);
			}
			if (player.gender > 0){
				player.orgasm();
			}
			doNext(camp.returnToCampUseOneHour);
			combat.cleanupAfterCombat();
		}

		public function beeGirlsGetsDildoed():void {
			spriteSelect(6);
			clearOutput();
			flags[kFLAGS.BEE_GIRL_COMBAT_WINS_WITH_RAPE]++;
			outputText("You advance on your ", false);
			if (monster.HP < 1) outputText("hapless", false);
			else outputText("horny", false);
			outputText(" foe, pulling your new favorite toy from your pouch like a knight drawing a sword.  The only difference is, your \"sword\" jiggles and leaks pink fluid.   Rushing forward, you close the distance in a leap and gently slap her face.   She looks up at you, dazed and confused, opening her mouth in protest.   The artificial dong easily muffles her noise-hole. From the blush that colors her cheeks, you can tell its fluids are already starting to affect her.\n\n", false);
			
			outputText("The bee-bitch's eyes are lidded seductively when you yank out the offending implement.  She licks her lips, as if beckoning you to ram it back into her throat, but the toy is already beginning to swell and you have other plans for it.  You sit down on her chest, just under her exposed breasts and reach down past her honeypot for her abdomen.  Once she realizes where you're headed, she starts squirming mightily, but can't get anywhere from her current position.   Reaching down next to her stinger, you part the softer flesh there and find the organ you were looking for.\n\n", false);
			
			outputText("A little stimulation causes it to begin growing out, a messy black organ with numerous bulbs and knots along its length, open at the top and sloshing with honey and fluids.  Your captive stops struggling as it grows harder, a strange female parody of a penis.  Finally, this bitch will be taking something uncomfortable in a hole that wasn't meant to take it.\n\n", false);
			
			outputText("The dildo plugs her ovipositor nicely, though a gush of honey squirts over your hand as it's forced in the entire way.  The knots and bulges of her egg-dispenser look even more obscene, and the image only grows worse as the dildo inside it begins absorbing the honey and bee-seed, growing larger.    She cries out in mixed pleasure and pain, and you decide to see how it feels to jerk off such a strange phallic organ.  The slick honey it exudes immediately soaks your hand, bubbling around it as you begin jacking her ovipositor off.\n\n", false);
			
			outputText("It gets thicker and thicker as the dildo-plug continues to puff up.  Her cries grow louder and louder as you pick up the tempo, and they don't sound very pained anymore.  Judging by the trembling of her hips, she's quite enjoying herself.   You begin to feel tiny knots and bulges around the bottom of the ovi-prick, and the slick black flesh slowly starts to go transparent there as it's stretched wider and wider by the invader and the eggs backing up behind it.  Worried that you might seriously damage her, you grab the thick sex-toy and give it a gentle yank, unplugging the bee-girl at last.\n\n", false);
			
			outputText("She cries out in ecstasy, spurting yellowish-white goo all over herself from her gaping ovipositor.  Eggs begin tumbling from the quivering black tube, rolling off her belly and thighs into the puddle of goo on the ground as her orgasmic contractions force them out, one after another.  They come out in twos and threes, passing through the widened hole with ease.  She buzzes and hums behind you, in her own little world, probably imagining she's fertilizing someone's backdoor.  You shrug and return to stroking the ovipositor, giggling a bit as it hardens nearly as much as a dick and gives a few last mighty squirts, depositing the last egg into the massive pile.\n\n", false);
			
			outputText("You release it as she passes out, smiling when you realize she'll probably be leaking eggs with every step from now on.  ", false);
			if (player.cor < 50) outputText("You feel kind of bad for her, but y", false);
			else outputText("Y", false);
			outputText("ou really need to get back to camp and get off after such an intense experience.  Maybe you should give your honey-flavored dildo a shot?", false);
			dynStats("lus", (20+player.lib/5+player.cor/10));
			combat.cleanupAfterCombat();
		}
		
		public function milkAndHoneyAreKindaFunny():void
		{
			spriteSelect(6);
			clearOutput();
			flags[kFLAGS.BEE_GIRL_COMBAT_WINS_WITH_RAPE]++;
			player.slimeFeed();
			outputText("You sit the bee-girl up; she's a bit dazed from the fight as her head moves in circles.  You kiss her honey-flavored lips, sticking your tongue into her mouth and causing her to snap out of her daze.  She's surprised at this unexpected show of affection, but understanding her situation, she begins kissing you back.  Both of your tongues rub and slide against one another as you occasionally plunge into each other's mouth.  Your hand rubs up her thigh onto her honeypot.  You drive two fingers into it, circling them around.  Making sure they are covered in her sweet love-honey, you pull the two fingers out and raise them up.  The bee-girl sees your honey-covered fingers and slowly pulls back from the kiss.  You suck the honey off the index then you point the middle at her mouth and push forward.  Her lips wrap around the finger and suck it into her mouth as her tongue laps around it, cleaning all the honey off it.  You take the finger out of her mouth and examine the work she did.\n\n", false);

			outputText("\"<i>Do you know what goes great with honey?</i>\" you ask.\n\n", false);

			outputText("The bee-girl ponders your question.  \"<i>Izzz it zex?</i>\"\n\n", false);

			outputText("You chuckle at her answer.  \"<i>Yes, but milk is also great with honey.</i>\"\n\n", false);

			outputText("\"<i>What izzz milk?</i>\" she asks.\n\n", false);

			outputText("Your chuckling becomes louder.  ", false);

			outputText("\"<i>Why don't you suck on one of my tits and find out?</i>\" you ask as you remove the top part of your " + player.armorName + ".  Curiosity gets the better of her as she picks a nipple and sucks on it.  Her curiosity is rewarded with a gush of milk down her throat.  Surprised that something is coming out, she recoils back.\n\n", false);

			outputText("The bee-girl questions, \"<i>What wazzz that?</i>\"\n\n", false);

			outputText("\"<i>That was milk, was it good?</i>\" you tease.\n\n", false);

			outputText("She pleads, \"<i>Yezzz it wazz, may I have more?</i>\"\n\n", false);

			outputText("\"<i>Sure, if I can have more honey.</i>\" you offer.\n\n", false);

			outputText("The bee-girl nods her head and goes back to sucking on the nipple as you reach your hand down to rub honey off her flower. There isn't a lot on your fingers when you raise them up to be cleaned; you guess you'll have to stimulate the flower's bud if you want more honey. You reach back down, caressing her little clit as she lets out a muffled moan that sends vibrations through your nipple and " + player.breastDescript(0) + ".  More honey glistens on her flower; you rub what honey you can get onto your fingers and suck them off while the bee-girl is enjoying her easy meal.  She's getting the better end of the agreement, barely having to put any effort into her nursing.  You continue scraping up as much honey as you can, and though more honey leaks out as you go on, it's not enough to satisfy your sweet tooth or hunger.  She sees her honeypot isn't giving as much as your milk jugs.  Once she has her fill, she hands you a jar and stands up.\n\n", false);

			outputText("\"<i>Hold thiz jar cloze to my puzzzy and catch the honey with it.</i>\"\n\n", false);

			outputText("Her shiny black vulva is sticky and puffed with arousal, and she is desperate to cum.  She finds her little pleasure bud and rapidly strokes the already swollen button. She throws her head back and pushes her pelvis forward against the jar as she sprays hot honey into the jar.  It quickly fills the jar and the excess spills over onto her pussy and the ground.  She pulls back from the jar with an indentation of the jar's circle on her soft vulva.  She hands you a lid, shakes your hand and thanks you for the exchange in sweet fluids.  \"<i>Maybe we do thiz zome other time.</i>\"", false);
			//[You have found 1xBee Honey]
			flags[kFLAGS.FORCE_BEE_TO_PRODUCE_HONEY] = 1;
			//set lust to 0, increase sensitivity slightly
			dynStats("lib", .2, "lus", -50);
			//You've now been milked, reset the timer for that
			player.addStatusValue(StatusEffects.Feeder, 1, 1);
			player.changeStatusValue(StatusEffects.Feeder, 2, 0);
			combat.cleanupAfterCombat();
		}


//requires spiderbite or nagabite
//Play standard victory text
		private function layEggsInABeeSpiderLike():void
		{
			clearOutput();
			outputText("You stand over the defeated bee, sizing up your latest catch.  She watches you fearfully as your gaze slides down her prone form, taking in every inch of her body.  Your eyes stop over her abdomen as you notice the girl's dripping, barely concealed ovipositor.  A wide");
			if (player.faceType == FACE_SNAKE_FANGS || player.faceType == FACE_SPIDER_FANGS) outputText(", fanged");
			outputText("smile breaks across your face, and your captive quivers in response.  Her eyes flick from your mouth to your spider half, and she shivers again.");

			outputText("\n\nYou lower your torso toward her, leaning in close enough that she can feel each breath on her skin.  She's frozen in place now, every muscle clenched tight with terror, and you savor her fear as you run your tongue up her neck.  Picking the insect-girl up by her shoulders, you release a contented \"<i>Mmmm</i>\" into her ear before flipping her over and dropping her, leaving the  bee face down in the dirt.");

			outputText("\n\nYou reverse yourself above her, pinning her struggling hands down with your rearmost legs while your spinneret twitches once before expelling a thick glob of web, firmly anchoring her limbs to the ground.  Spinning back around, you cock your head to the side pensively, trying to decide the best 'pose' for the trembling bee-slut.  Deciding on one that would allow you the most access, you push and pull at her hips until she's raised her ass high into the air; another spurt of webbing ensures that she'll hold the pose until you get tired of it.  As you step back to admire your handiwork, she curls her striped abdomen between her legs, trying to conceal the source of the slick trail running down her thigh.");

			outputText("\n\nStepping closer once again, the frantic glances the trapped insect throws over her shoulder begin to stir something primal in you.  Gently prising her insectile half from around her bottom, you hold it overhead while you move in closer, holding yourself a few scant centimeters from her dripping sex.  A few more pointed comments about how delectable she looks has her struggling against her bonds as you lick and nip at her plush derriere.");

			outputText("\n\nYour eyes focus on her tight pucker, and idle wondering about how the bees deal with their eggs when no one else is available rapidly coalesces into a plan of action that brings an even greater smile to your face.  A few tentative prods with your finger reveals a crushing tightness; you are most certainly going to need some additional lubrication.  How lucky that you have a <i>willing</i> source...");

			outputText("\n\nSinking your fangs into the antennae-capped girl's cushiony cheek throws her into an immediate frenzy, her wings blurring frantically with a high-pitched buzz.  Her whole body shivers as your venom burns through her veins, setting her lust alight and turning the slow drip of her arousal into a steady stream of nectar.");

			outputText("\n\nLathering the bee's sweet-scented honey onto one hand, you work your fingers into her tight asshole one at a time, thoroughly lubing and leaving it gaping ever so slightly when you pull yourself free.  Pushing yourself back up, you maintain your hold on her chitinous posterior while you arrange your own, lining up your dripping egg-spike with her newly wet hole.  Catching sight of your growing ovipositor causes her to finally break her silence, but her pleas turn into a strangled moan as you force nearly a foot of yourself into her with your first push.  Her heavy panting accompanies the slapping noise of you thrusting your ovipositor in and out of her trembling hole, trying to fit as much of it into the bound bee-girl as you can.");

			outputText("\n\nWith a powerful wet-sounding slap, you bottom out inside her, and your moan of satisfaction mixes with her panicked gasp as your egg-tube flares deep inside her, filling her innards with its thick lube.");
			if (player.gender > 0) {
				outputText("  With another lewd groan,  you wrap your arms around her bee abdomen, grinding ");
				if (player.hasCock()) outputText("[eachCock]");
				else outputText("your [vagina]");
				outputText(" against her in bliss, leaving a sticky trail dripping down onto her gropable cheeks.");
			}
			outputText("  You shudder in ecstasy as you feel the first egg slide out of your abdomen, slowing to a halt just shy of her clenched ring.  More eggs file in behind it, piling up outside her rear entrance, and finally the muscular contractions of your shaft win over her exhausted sphincter, eggs rushing forward into her awaiting warmth.");

			outputText("\n\nThe bee's groans take on a decidedly orgasmic note as she shudders beneath you, arms and legs going slack against her bonds, while her stomach swells out with the burden of your ");
			if (player.fertilizedEggs() == 0) outputText("unfertilized");
			else outputText("fertilized");
			outputText(" eggs.  By the time the last one shifts through your swollen pole, her bloated gut is nearly scraping the ground, leaving her panting and twitching with the weight of your eggs.");

			outputText("\n\nYou pull yourself free on unsteady legs, her gaping hole gushing emerald lube while her chitinous abdomen flops listlessly over her egg-filled ass.  You cut her free from your sticky webbing and gather up your [armor], shuffling back to camp as she collapses exhausted on her side, both hands wrapped around her tremendously swollen midsection.");
			player.dumpEggs();
			player.orgasm();
			combat.cleanupAfterCombat();
		}
	}
}
