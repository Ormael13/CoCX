package classes.Scenes.Dungeons.D3 
{
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.PerkLib;
	import classes.StatusEffects;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class DopplegangerScenes extends BaseContent
	{
		
		public function DopplegangerScenes() 
		{
			
		}
		
		public function getDemGlasses():void
		{
			clearOutput();
			outputText("You step into the room and move across to the optician stand. The metal door clicks shut behind you. A feeling of unease grows in your gut as you walk further into the room; the place seems gloomier and larger than it did from the door. You almost jump out of your skin as somebody suddenly emerges to your right- but of course it’s just you, reflected in the intricately decorated, oval-shaped mirror which centers the room. You smile at your own silliness, before watching your expression change to a frown. You seem very sharply focused in it; the room behind you barely seems there at all. Some kind of enchantment to refine a demon’s appearance, you guess.");

			outputText("\n\nYou turn away and head over to the upright display of dark shades, pulling a pair out of their indents. They are completely reflective on the side facing away from your eyes, and the word 'Laybans' is engraved down one arm. Whatever they are used for, you know one thing for certain: you are going to look ice cool wearing them. Pleased, you turn back towards the door- and get a start. Was the standing mirror facing this way when you came in here? Maybe it is double sided, but... you grin uneasily at your own reflection. It grins back. It looks a great deal more confident than you think your smile should look, given the circumstances. You find it difficult to look away now you are confronted with a clear, full length image of what you look like; for so long now you’ve relied on the vague, faltering surface of the stream near your camp it’s almost startling to be given such a clear picture of yourself.");
			if (player.humanScore() > 4)  outputText("  It is honestly surprising, given everything you have encountered since you stepped through that portal what seems years ago, that you are still recognizably human. You wonder if your parents would be able to recognize the battle-hardened " + player.mf("man", "woman") +" clad in " + player.mf("his", "her") +" [armor] standing in front of you to be the wide-eyed youth they bade their heartfelt goodbyes to all that time ago, though.");
			else outputText("  The last time you looked into such a sharp reflection you were human; a pang of regret steals through you as you consider probably not even your parents would be able to recognize the strange "+ player.race() +" clad in "+ player.mf("his", "her") +" [armor] standing in front of you now.");

			outputText("\n\nYou continue to stare at yourself, transfixed. The image is so vivid, and yet you cannot shake the feeling that it isn’t really you - the more you look, the more you pick out details which don’t seem right. It has to be you, right? But do you really look that intense? Where did that wild look in your eye come from? Unreality washes over you as the mirror and the room seem to swim. Everything is vague except your image in the mirror, still staring back at you, seeming to move independently of you, perspective causing it to bend and distort bizarrely. When the image’s mouth splits into a grin, opens and speaks whilst yours remains shut, it is no longer surprising. It is not you.");

			outputText("\n\n“<i>I was expecting an imp,</i>” it says. The voice sounds like it is coming from some distance away, but a cold sensation spreads itself over your shoulders as you recognize it. It’s what you would sound like to someone standing a couple of rooms away from you. It looks down and clenches your... <i>" + player.mf("his", "her") + "</i> fists with an expression of wild wonder, before turning "+ player.mf("his", "her") +" eyes back to you. “<i>That would be the fitting thing, wouldn’t it? Robbed of my form by Lethice, bound to a glass prison for a decade, forced to seize and use the first thing stupid enough to be transfixed by it. It would have to be an imp, wouldn’t it? But this...</i>” The doppelganger walks slowly towards you, "+ player.mf("his", "her") +" voice, your voice heard through a bottleneck of madness, getting louder all the time. As "+ player.mf("he", "she") +" comes "+ player.mf("he", "she") +" stretches "+ player.mf("his", "her") +" limbs luxuriously, examining the form "+ player.mf("he", "she") +" has stolen, running "+ player.mf("his", "her") +" hands down your trunk to touch the top of your [hips], marvelling. You feel violated in a way you never thought possible. “<i>... This, I could get used to. This, I could use. Who are you?</i>”");

			outputText("\n\nRight at the front of the mirror now, "+ player.mf("he", "she") +" flicks "+ player.mf("his", "her") +" borrowed fingers at the air, as if coaxing the answer out of it. As "+ player.mf("he", "she") +" does so, "+ player.mf("he", "she") +" casually steps through the surface of the mirror, as if it were an open window. The feeling of unreality intensifies; you can’t shake the sensation of being mired in vagueness, at how vivid the mirror demon looks in comparison to how you feel.");

			outputText("\n\n“<i>[Name]. There we go. Not what I would choose to describe this business...</i>” " + player.mf("he", "she") +" pats " + player.mf("his", "her") +" [butt] mockingly, “<i>but then I’m not you, right? Not yet, anyway.</i>” " + player.mf("He", "She") +" laughs, suddenly, madly, and you cringe inwardly. It is what you would sound like if you were completely, utterly insane.");
			outputText("\n\n“<i>Do you know what it is like to spend ten years without a form? To spend ten years imitating an empty room? Well, don’t worry, [name]. When I have taken your place and bound you to this thing I’ll make sure to put it somewhere nice and busy, so you will never have to know that torment!</i>” " + player.mf("He", "She") +" draws the mirror image of your [weapon] and advances upon you, your own features hiked into a rictus of madness.");
			outputText("\n\nYou must fight yourself!");
			
			startCombat(new Doppleganger());
		}
		
		public function punchYourselfInTheBalls():void
		{
			flags[kFLAGS.D3_DOPPLEGANGER_DEFEATED] = 1;
			player.createKeyItem("Laybans", 0, 0, 0, 0);
			
			clearOutput();
			outputText("The doppelganger falls to the floor, sobbing and broken. For one long moment you feel the nagging pull to exactly replicate [his] actions... and then it’s gone. The world comes back sharply into focus. You have won.");

			outputText("\n\n“<i>No...</i>” your mirror image snivels in front of you. “<i>Ten years, ten years I waited for this. You can’t put me back in there, you can’t!</i>” You gaze down at what you look like when you are defeated: mouth open, eyes glazed, " + player.hairDescript() + " muddled, your flesh trembling and clenching, the very picture of a bitch awaiting further subjugation. No wonder 90% of Mareth is so keen on wanting to make this sight happen. The doppelganger chances a look up, catches your expression, and freezes. “<i>You... you wouldn’t.</i>”");
			
			menu();
			if (!player.isTaur() && (player.hasCock() || player.hasVagina())) addButton(0, "Oh Really?", fuckYourself);
			addButton(1, "End It", killYourself)
		}
		
		public function fuckYourself():void
		{
			clearOutput();
			outputText("This, you feel, is an opportunity which is not likely to arise again.");
			
			if (player.hasVirginVagina()) outputText("  You smile widely at your clone as you undress. Now neither of you will be virgins.");
			else outputText("  You smile widely at your clone as you begin to shake off your [armor].");
			outputText("  [He] moans lowly in miserable disbelief, but [he]’s not capable of resisting you as, butt naked, you sit yourself down and methodically repeat the action, sliding your hands over and into [his] replicated clothing, finding [his] warm flesh, clutching and testing it curiously. Obviously you’ve laid your fingers upon this many times before, but touching it now second hand causes an emotion you cannot name to rise in your breast. Is this getting you hot? Yes. In the strangest, most perverse way imaginable, it is.");
			
			if (player.vaginas.length == 0 && player.cocks.length == 0) 
			{
				outputText("\n\nStrangely, the more you think about fucking this strange creature, the hotter your groin becomes. In moments, you find your fingers pushing against a dampening slit with feather-light caresses. <b>Somehow this place's magic has given you a vagina to match your duplicate!</b> You pull away with a shuddering breath and marvel at the glittering wetness oozing down your fingertips. This is going to be fun.");
				player.createVagina();
			}
			if (player.cocks.length >= 1 && !player.hasVagina())
			{
				outputText("\n\nYou turn the mirror demon’s wild stare and ragged breath away from you, laying a comforting but firm hand upon [his] shoulder as, grinning, you lower your eyes to [his] [butt]. Nice.");
				if (player.isNaga()) outputText("  You sigh at the smooth, pleasurable feeling of your scales rubbing over each other as you sensuously wind yourself around [his] tail until you are tightly bound together. Twin lithe snake boys wound around each other- all you really need is a paying audience. Or a stick and a hospital. You laugh with a similar tinge of madness that your partner did a short while ago and [he] groans raggedly in response.");
				else if (player.isDrider()) outputText("  The tangle of spindly legs in front of you initially puts you off, but then your arachnid instincts take over and you find yourself eagerly clambering onto [his] bulging back before you know it, your hardening dick pressing against the human softness which rises above the gleaming chitin as your monstrous body presses heavily down onto its mirror counterpart, making [him] groan raggedly.");
				else if (player.skinType != SKIN_TYPE_FUR && player.tailType != TAIL_TYPE_NONE) outputText("  You clamber on top of [him], the rough mingling of your fur sparking deep urges within you, your animal half dreaming of frenzied, bestial mating in the wild. Your hardening dick presses against [his] [tail] and [he] groans raggedly in response.");
				else outputText("  You clamber on top of [him], enjoying the give and take of [his] "+ (player.isGoo() ? "gooey" : "smooth") +" flesh as you lock your [hips] around their mirror counterparts, making [him] groan raggedly in response.");

				outputText("\n\n“<i>I cannot believe you are doing this. There- there are demons who wouldn’t do this. What kind of sick bastard even are you?</i>“");

				outputText("\n\n“<i>Oh, shut up,</i>” you reply breezily. The movement of your [skin] against [his] has kindled your arousal, and you push your [cock] between [his] butt cheeks, hardening even further with the pleasurable motion. “<i>You’re the one who wouldn’t shut up about how much you wanted this body. I’m giving you exactly what you wished for.</i>” There’s no lubricant available at all.");
				if (player.ass.analWetness > 3) outputText("  No problem for a clone of you, though. You sigh as you push your bulging head against [his] rose, easily opening [him] and pushing deep into [his] oily, pliable depths.");
				else outputText("  Well, tough. [He] is a demon, after all. You sigh as you push your bulging head against [his] rose, slowly working it loose with the repetitive, pleasurable motion until [he] finally relaxes enough for you to push into [his] warm, tight depths.");

				outputText("\n\nYou go slowly, enjoying the warmth and syncopated clenching of the mirror demon’s tunnel at leisure. Although [he] is initially frozen with sheer disbelief the need to relax in order to take your insistent [cock] softens [him] up, moving [him] in time with your thrusting. [He] moans from a combination of misery and intensity of the sensation you’re pushing upon [him].");
				if (player.findPerk(PerkLib.Buttslut) >= 0 || player.findPerk(PerkLib.MaraesGiftButtslut) >= 0) outputText("  You glory in your own decision to transform into an eager butt slut; the doppelganger’s back passage is tight, warm butter, accepting and clenching around your bulging prick like the perfect little boypussy you know it to be.");
				outputText("  Now that you’re locked into your defeated clone you feel no real wish to cause [him] pain. Indeed, as you lose yourself to the rhythm to the slow, tight, gradual sex a desire to force [him] to feel pleasure grows. Where is the fun in seeing your mirror image suffer, after all?");
				
				outputText("\n\nYou hook an arm around [his] shoulder and let your fingers graze one of [his] nipples teasingly. [He] gasps, [his] sphincter tightening up around your [cock] delightfully.");

				outputText("\n\n“<i>Don’t- don’t do that,</i>” [he] rasps. “<i>Fuck me if you must, but please...</i>“ ignoring [him] with silent glee, you touch [his] other nipple, this time rubbing it gently in concentric circles until it is "+ (!player.hasFuckableNipples() ? "standing to a needy point" : "wetting itself needily") + ", before going to work on the other one, sliding in and out of [his] contracting warmth all the while. As you continue to tease [him] you let your other hand slide down [his] abdomen, remorselessly leading down until your fingertips touch [his] semi-erect [cock].");

				outputText("\n\nAs you do [he] makes a wordless, gasping noise which resonates right to your core. It’s the sound you yourself make when something that is being forced upon you has started to feel so good you’ve stopped caring. Gods, you want to hear it again....  There is a sharp cracking sound behind you. Turning your head, you see a paper-thin crack has appeared in the demon’s mirror, a small flaw veining across the perfect reflection.");

				outputText("\n\nYou wrap your hand around the mirror image of the girth which is currently wedged in your partner’s rear, gripping tight and then softening, slowly rolling your wrist as you repeat the motion, knowing exactly how to work the prick in your hand to make it bulging hard. [He] arches [his] back to the sensation, [his] smooth muscle pushing into your [chest] as [he] whimpers.");

				outputText("\n\n“<i>Stop, please stop. You don’t know... fuck, this body... it’s been so damn long...</i>” You hold [him] close, your fingers still on [his] [nipples] as you withdraw almost all the way out before thrusting your hips into [him] hard, holstering your whole length into [his] warmth, making [him] cry out with that same delicious cadence as you touch something deep. There is an ominous snap behind you as more cracks thread themselves over the mirror’s surface.");

				outputText("\n\n“<i>Let me guess,</i>” you breathe into [his] ear, as you make your hand go soft and hard, soft and hard around [his] urgently erect penis. “<i>Lethice made it so that even if you did manage to crawl out here, whichever poor soul you snatched a body off could banish you by making you cum. I guess it’s simple then, isn’t it? Just... don’t.</i>” You begin to pick up the pace, move smoothly at first as you enjoy [his] tight tunnel before finally unleashing your own urge, your [hips] clapping into [his] [butt] as you hold [his] hot, tautening body close, jerking [his] bulging prick with curt, cramped flicks of the wrist. You push into [his] prostate, milking [him] ruthlessly and [he] cries out, trying now to pull away from you but far too weak to do it. Your flesh imprisons [him] doubly and you force sensation upon [him] from every direction you can, your [cock] thrusting into the clenching passage you’ve made your own, one hand flicking at [his] needily erect/beading nipple, the other stroking [his] sensitive prick, relentlessly pulling [him] with you to a shared high. Behind you the sound of the mirror’s stress continues, accompanying your merciless pleasure with its baleful xylophone pangs. The doppelganger no longer struggles, can’t even find words anymore; [he] just barks and groans in helpless pleasure as you use every tight, warm inch of [him].");

				outputText("\n\n“<i>How did you think you were going to master this body, demon?</i>” you growl, blood pulsing in your ear, seed rising in your loins. “<i>Ten minutes after stealing it, and you’re its true owner’s boy-slut. Never mind- I know </i>exactly<i> how much you’re going to enjoy the last thing you’ll ever feel.</i>”");
 
				outputText("\n\nYou bury as much of yourself into [him] as you can, driving your bulging length over [his] prostate as you tense, open wide and surge line after line of cum into [his] tunnel. Your mirror image howls, finding a note you never knew your vocal chords could reach as [he] thrashes back into you, [his] [hair] flapping into your face as [he] orgasms in tandem.");
				if (player.cumQ() >= 1000) outputText(" You know exactly what to expect; [his] over-clocked physiology makes [him] a veritable cum fountain. As you ride your high, pumping [his] guts full of your warm seed [he] spurts geysers of jizz the length of [his] body onto the floor, wailing at the sheer size of the high owning your body forces [him] to feel. You sit astride [him], admiring and exulting in it at the same time.");
				else outputText("  You ride your high, pumping [his] guts full of your warm seed as you force [him] along with you, guttering jizz on the floor in front of you.");

				outputText("\n\nThere is an emphatic shattering sound behind you, the high noise mingling with the demon’s defeated wail, climbing together to an unbearable pitch. You squeeze your eyes shut as you bury yourself one last time into your defeated buttslut- and then stagger forward, the flesh you’re clenched into parting like smoke, almost falling straight into the mess you forced [him] to create. Except that’s not there anymore, either. All that you are suddenly left with is you, your oozing, gently aching [cock], and a great deal of broken glass lying in front of you. You slowly get to your feet and gaze at the shattered mirror. It’s difficult to believe looking at it now that it could be in any way an object of dread- indeed, standing here naked in this shabby storage room, you feel more than a little ridiculous. Was this all just a really weird fugue? Well, whatever just happened, there’s no mistaking the warm fuzz of deepest sexual satisfaction. Shaking your head you redress, make sure the protective glasses you came in here for are still in your pocket before heading to the door and leaving.");
			}
			else if (player.hasCock() && player.hasVagina())
			{
				outputText("\n\nYour gaze drops from the mirror demon’s wild stare, down to [his] [chest]. Nice. You lay a comforting but firm hand upon [his] shoulder as you sink down on top of your clone, your own [chest] pushing into " + player.mf("his", "hers") + ", your hardening [cock] pressing and rubbing impatiently against its supple, turgid clone. You find yourself intensely aware of every sensation- exactly how your perverse, hermaphroditic body feels to your own touch.");
				if (player.isNaga()) outputText("  You sigh at the smooth, pleasurable feeling of your scales rubbing over each other as you sensuously wind yourself around [his] tail until you are tightly bound together. Twin lithe snake futa wound around each other- all you really need is a paying audience. Or a stick and a hospital. You laugh with a similar tinge of madness that your partner did a short while ago and [he] groans raggedly in response.");
				if (player.isDrider()) outputText("  For a moment you consider mounting [him] from behind, allowing your monstrous instincts to take over and fuck [his] ovipositor in a deathly arachnid craze, but the tangle of spindly legs in front of you puts you off. Better to do it face-to-face. You want to drink in your mirror image’s every reaction. Your prick pressing against the human softness which rises above [his] gleaming chitin as your body presses heavily down onto its mirror counterpart, making [him] groan raggedly.");
				if (player.skinType == SKIN_TYPE_FUR) outputText("  You clamber on top of [him], the rough mingling of your fur sparking deep urges within you, your animal half dreaming of frenzied, bestial mating in the wild. Your dick presses into [his] digitigrade thigh and [he] groans raggedly in response.");
				else outputText(" You clamber on top of [him], enjoying the give and take of [his] "+ (player.isGoo() ? "gooey" : "smooth") + " flesh as you lock your [hips] around their mirror counterparts, making [him] groan raggedly in response.");

				outputText("\n\n“<i>I cannot believe you are doing this. There- there are demons who wouldn’t do this. What kind of sick bitch are you?</i>\"");

				outputText("\n\n“<i>Oh, shut up,</i>” you reply breezily. “<i>You’re the one who wouldn’t shut up about how much you wanted this body. I’m giving you exactly what you wished for.</i>” You roll [his] [hips], [his] cock");
				if (player.cocks.length > 1) outputText("s");
				outputText(" batting back into [his] stomach as you expose [his] [vagina], ");
				if (player.averageVaginalWetness() < 3) outputText(" gleaming invitingly");
				else outputText(" drooling lubricant eagerly");
				outputText("- as you knew it would be. You glory in your decision to transform yourself so that you could enjoy the best of both genders. If this isn’t clear vindication of being a hermaphrodite, what is? Your doppelganger wriggles and whines but can’t resist as you push your bulging head against [his] pussy, slowly pushing [his] oily lips wide and into [his] warm, tight depths.");

				outputText("\n\nYou go slowly, enjoying the warmth and syncopated clenching of the mirror demon’s juicy cunt at leisure.");
				if (player.hasVirginVagina()) outputText("  You grunt as something gives in front of your cock and the doppelganger gasps and tightens up in momentary pain. Looking down at your withdrawing cock, you see spots of blood mingling with the demon’s wet. Dreamily you consider that, having somehow managed to experience taking your own virginity, whether there’s anyone else in the world it’s worth gifting that sensation to.");
				outputText("  Although [he] is initially frozen with sheer disbelief the need to relax in order to take your insistent [cock] softens the doppelganger up, moving [him] in time with your thrusting. [He] moans in a combination of defeated misery and from the intensity of the sensation you’re pushing upon [him], your dick smoothing against [his] [clit] as you extend and recede. Now you’re locked into your defeated clone you feel no real wish to cause [him] pain; indeed, as you lose yourself to the rhythm of the slow, sensual missionary a desire to force [him] to feel pleasure grows. Where is the fun in seeing your mirror image suffer, after all?");

				outputText("\n\nYou place your palm upon [his] ribs, sliding slowly upwards, enjoying the give and take of [his] heaving flesh before letting your fingers graze across one of [his] nipples teasingly. [He] gasps, [his] pussy tightening up around your [cock] delightfully.");

				outputText("\n\n“<i>Don’t- don’t do that,</i>” [he] rasps. “<i>Take your satisfaction if you must, but please...</i>” ignoring [him] with silent glee, you touch [his] other nipple, this time rubbing it gently in concentric circles until it is "+ (!player.hasFuckableNipples() ? "standing to a needy point" : "wetting itself needily") + ", before going to work on the other one, sliding in and out of [his] contracting warmth all the while. As you continue to tease [him] you let your other hand slide down [his] abdomen, remorselessly leading down until your fingertips touch [his] semi-erect [cock].");

				outputText("\n\nAs you do [he] makes a wordless, gasping noise which resonates right to your core. It’s the sound you yourself make when something that is being forced upon you has started to feel so good you’ve stopped caring. Gods, you want to hear it again....  There is a sharp cracking sound behind you. Turning your head, you see a paper-thin crack has appeared in the demon’s mirror, a small flaw veining across the perfect reflection.");

				outputText("\n\nYour grin widening, you wrap your hand around the mirror image of the girth which is currently wedged in your partner’s sensitive cunt, gripping tight and then softening, slowly rolling your wrist as you repeat the motion, knowing exactly how to work the prick in your hand to make it bulging hard. [He] arches [his] back to the sensation, [his] [chest] pushing into your own flesh as [he] whimpers.");

				outputText("\n\n“<i>Stop, please stop. You don’t know... fuck, this body... it’s been so damn long...</i>” You hold [him] close, your fingers on one hand still on [his] [nipples] as you withdraw almost all the way out before thrusting your hips into [his] hard, holstering your whole length into [his] wet warmth, making [him] cry out with that same delicious cadence as you touch something deep. There is an ominous snap behind you as more cracks thread themselves over the mirror’s surface.");

				outputText("\n\n“<i>Let me guess,</i>” you breathe into [his] ear, as you make your hand go soft and hard, soft and hard around [his] urgently erect penis. “<i>Lethice made it so that even if you did manage to make it out, whichever poor soul you snatched a body off could banish you by making you cum. I guess it’s simple then, isn’t it? Just... don’t.</i>” You begin to pick up the pace, smoothly at first as you enjoy [his] long, soft tunnel, pushing deliberately into [his] bulging [clit] before finally unleashing your own urge, your [hips] clapping into hers as you hold [his] hot, tautening body close, jerking [his] bulging prick with curt, cramped flicks of the wrist. You push into [his] prostate, milking [him] ruthlessly, and [he] cries out, trying now to pull away from you but far too weak to do it. Your flesh imprisons [him] doubly and you force sensation upon [him] from every direction you can, your [cock] thrusting into the clenching passage you’ve made your own, one hand flicking at [his] " + (!player.hasFuckableNipples() ? "needily erect" : "beading nipple") + ", the other stroking [his] sensitive prick, relentlessly pulling [him] with you to a twin high. Behind you the sound of the mirror’s stress continues, accompanying your merciless pleasure with its baleful xylophone snaps. The doppelganger no longer struggles, can’t even find words anymore; [he] just squeals and groans in helpless pleasure as you use every tight, warm inch of [his].");

				outputText("\n\n“<i>How did you think you were going to master this body, demon?</i>” you growl, blood pulsing in your ear, seed rising in your loins. “<i>Ten minutes after stealing it you’re its true owner’s futa slut. Never mind- I know </i>exactly<i> how much you’re going to enjoy the last thing you’ll ever feel.</i>” You bury as much of yourself into [him] as you can, driving your bulging length across [his] prostate as it tenses, opens wide and surges line after line of cum into [his] womb. Your mirror image howls, finding a note you never knew your vocal chords could reach as [he] thrashes back into you, [his] " + player.hairColor + " flapping into your face as [he] orgasms in tandem, driven further beyond the edge of sanity with the force of a simultaneous male and female orgasm.");
				if (player.cumQ() >= 1000) outputText("  You know exactly what to expect; [his] over-clocked physiology makes [him] a veritable cum fountain. As you ride your high, pumping [him] full of your warm seed [he] spurts streams of jizz the length of [his] body on the floor, wailing at the sheer size of the high owning your body forces [him] to feel. You sit astride [him], exulting in and enjoying the sight of it at the same time.");
				else outputText("  You ride your high, pumping [him] full of your warm seed as you force [him] along with you, guttering jizz on the floor in front of you.");

				outputText("\n\nThere is an emphatic shattering sound behind you, the high noise mingling with the demon’s defeated wail, climbing together to an unbearable pitch. You squeeze your eyes shut as you thrust one last time into your defeated clone- and then stagger forward, the flesh you’re clenched into parting like smoke, almost falling straight into the mess you forced the doppelganger to create. Except that’s not there anymore, either- all that you are suddenly left with is you, your oozing, gently aching [cock], and a great deal of broken glass. You slowly get to your feet and gaze at the shattered mirror. It’s difficult to believe looking at it now that it could in any way be an object of dread- indeed, standing here naked in this shabby storage room, you feel faintly ridiculous. Was this all just a really weird fugue? There’s no mistaking the warm fuzz of deep sexual satisfaction at least. Shaking your head, you redress, make sure the protective glasses you came in here for are still in your pocket before heading to the door and leaving.");
			}
			else if (player.hasVagina() && !player.hasCock())
			{
				outputText("\n\nYour gaze drops from the mirror demon’s wild stare, down to her [chest]. Nice. You lay a comforting but firm hand upon her shoulder as you sit yourself down in front of your clone, your own [chest] pushing into hers as, almost mockingly, you cuddle her.");
				if (player.isNaga()) outputText("  You sigh at the smooth, pleasurable feeling of scales rubbing over each other as you sensuously wind yourself around her tail until you are tightly bound together. Twin lithe snake girls wound around each other- all you really need is a paying audience. Or a stick and a hospital. You laugh with a similar tinge of madness that your partner did a short while ago and she groans raggedly in response.");
				else if (player.isDrider()) outputText("  You are momentarily thrown by your sixteen spindly legs tangling together, a creepy twitching maze devolving across the floor- but this is definitely the way to do it. Face-to-face. You want to drink in your mirror image’s every reaction. Your [vagina] presses against the human softness which rises above her gleaming chitin as your body presses heavily into its mirror counterpart, eliciting a ragged groan.");
				else if (player.skinType == SKIN_TYPE_FUR) outputText("  You clamber on top of her, the rough mingling of your fur sparking deep urges within you, your animal half dreaming of frenzied, bestial mating in the wild. Your [vagina] presses into her digitigrade thigh and she groans raggedly in response.");
				else outputText("  You clamber on top of her, enjoying the give and take of her "+ (player.isGoo() ? "gooey" : "smooth") + " flesh as you lock your [hips] around their mirror counterparts, making her groan raggedly in response.");

				outputText("\n\n“<i>I cannot believe you are doing this. There- there are demons who wouldn’t do this. What kind of sick bitch are you?</i>”");

				outputText("\n\n“<i>Oh, shut up,</i>” you reply breezily. “<i>You’re the one who wouldn’t shut up about how much you wanted this body. I’m giving you exactly what you wished for.</i>” With your [hips] wrapped around hers she cannot stop you bending her open, exposing the mirror image of your [vagina],");
				if (player.averageVaginalWetness() < 3) outputText(" gleaming invitingly");
				else outputText(" drooling lubricant eagerly");
				outputText(" - as you knew it would be. Your doppelganger wriggles and whines but can’t resist as you push your pussy into hers, the mirrored sex meeting with a pleasingly wet sound.");

				outputText("\n\nYou go slowly, enjoying your abdomens smoothing across each other and the warm wetness of the mirror demon’s juicy cunt moving over your own [clit] and sensitive lips at leisure. Although she is initially frozen with sheer disbelief the need to relax in order to take your insistent sex softens the doppelganger up, moving her in time with your thrusting. She moans in a combination of defeated misery and from the intensity of the sensation you’re pushing upon her, your lips locking together and your clits gently colliding as you extend and recede. Now you’re locked againstinto your defeated clone you feel no real wish to cause her pain; indeed, as you lose yourself to the rhythm of the slow, sensual tribbing a desire to force her to feel pleasure grows. Where is the fun in seeing your mirror image suffer, after all?");

				outputText("\n\nYou place your palm upon her ribs, pushing slowly upwards, enjoying the give and take of her heaving flesh before letting your fingers graze across one of her nipples teasingly. She gasps, her pussy contracting around your [clit] delightfully.");

				outputText("\n\n“<i>Don’t- don’t do that,</i>” she rasps. “<i>Take your satisfaction if you must, but please...</i>“ ignoring her with silent glee, you touch her other nipple, this time rubbing it gently in concentric circles until it is " + (!player.hasFuckableNipples() ? "standing to a needy point" : "wetting itself needily") +", before going to work on the other one, revolving your hips into hers all the while. As you continue to tease her you let your other hand slide down her abdomen, remorselessly leading down until your fingertips touch her [clit].");

				outputText("\n\nAs you do she makes a wordless, gasping noise which resonates right to your core. It’s the sound you yourself make when something that is being forced upon you has started to feel so good you’ve stopped caring. Gods, you want to hear it again....  There is a sharp cracking sound behind you. Turning your head, you see a paper-thin crack has appeared in the demon’s mirror, a small flaw veining across the perfect reflection.");

				outputText("\n\nYour grin widening, you delicately place two of your fingers against her bulging clitoris, kneading it with the softest but most persistent of motions. She arches her back to the sensation, her [chest] pushing into your own flesh as she whimpers.");

				outputText("\n\n“<i>Stop, please stop. You don’t know... fuck, this body... it’s been so damn long...</i>” You hold her close, your fingers on one hand still on her [nipples] as you suddenly clap your hips into her hard,");
				if (player.thickness > 75 || player.tone < 25) outputText(" sending your shared jiggly flesh rippling in separate directions");
				else outputText(" your shared, muscled flesh barely moving");
				outputText(" as you push your clit into her wet opening, making her cry out with that same delicious cadence as she closes her eyes. There is an ominous snap behind you as more cracks thread themselves over the mirror’s surface.");

				outputText("\n\n“<i>Let me guess,</i>” you breathe into her ear, as you keep your fingers moving slowly over her button. “<i>Lethice made it so that even if you did manage to make it out, whichever poor soul you snatched a body off could banish you by making you cum. I guess it’s simple then, isn’t it? Just... don’t.</i>” You begin to pick up the pace, your [hips] clapping into hers insistently as you hold her hot, tautening body close, flicking her bulging clit with curt movements of the wrist, fem-jizz dampening your thighs. You push into her opening again, fucking her ruthlessly and she cries out, trying now to pull away from you but far too weak to do it; your flesh imprisons her doubly and you force sensation upon her from every direction you can, your [vagina] thrusting into its dominated mirror image, one hand squeezing her needily erect/beading nipple, the other stroking her sensitive clit, relentlessly pulling her with you to a twin high. Behind you the sound of the mirror’s stress continues, accompanying your merciless pleasure with its baleful xylophone snaps. The doppelganger no longer struggles, can’t even find words anymore; she just squeals and groans in helpless pleasure as you use every soft, warm inch of her.");

				outputText("\n\n“<i>How did you think you were going to master this body, demon?</i>” you growl, blood pulsing in your ear, orgasm closing. “<i>Ten minutes after stealing it you’re its true owner’s lesbian slut. Never mind- I know </i>exactly<i> how much you’re going to enjoy the last thing you’ll ever feel.</i>” You thrust as much of yourself into her as you can, pushing your clit against hers as your body tenses and flings itself into orgasm. Your mirror image howls, finding a note you never knew your vocal chords could reach as she thrashes back into you, her " + player.hairDescript() + " flapping into your face as she orgasms in tandem.");
				if (player.cumQ() > 1000) outputText("  You know exactly what to expect; her over-clocked physiology makes her a veritable fem-cum fountain. Your vaginas spurt and spatter against each other, rivulets of shared delirium dribbling onto the floor and dousing your abdomens, the doppelganger wailing at the sheer size of the high owning your body forces her to feel. You sit astride her, exulting in and enjoy the sight of it at the same time.");
				else outputText("  You ride your high, shared female delirium wetting your thighs as you force her to ride her high locked deep into you.");
				
				outputText("\n\nThere is an emphatic shattering sound behind you, the high noise mingling with the demon’s defeated wail, climbing together to an unbearable pitch. You squeeze your eyes shut as you thrust one last time into your defeated slut- and then jerk forward, the flesh you’re clenched into parting like smoke, almost falling straight into the mess you forced the doppelganger to create. Except that’s not there anymore, either- all that you are suddenly left with is you, your oozing, gently aching [vagina], and a great deal of broken glass. You slowly get to your feet and gaze at the shattered mirror. It’s difficult to believe looking at it now that it could in any way be an object of dread- indeed, standing here naked in this shabby storage room, you feel faintly ridiculous. Was this all just a really weird fugue? There’s no mistaking the warm fuzz of deep satisfaction at least. Shaking your head, you redress, make sure the protective glasses you came in here for are still in your pocket before heading to the door and leaving.");
			}
			
			outputText("\n\n<b>(Key Item Acquired: Laybans!)</b>");
			flags[kFLAGS.D3_MIRRORS_SHATTERED] = 1;
			player.orgasm();
			combat.cleanupAfterCombat(d3.resumeFromFight);
		}
		
		public function killYourself():void
		{
			clearOutput();
			outputText("You hold its gaze for a moment more, and then with a single, fluid movement turn and smash your [weapon] into the engraved mirror. A shrill scream mingles with the sound of breaking glass, but by the time the shards begin to tinkle and chime to the floor it’s keened away, and when you turn back the doppelganger is gone. The shrill sound could have been the sound of the mirror itself when you hit it, you suppose. This could all have been a very strange fugue. Certainly, standing here now in this dishevelled storage room, it’s difficult to believe what just happened. Shaking your head, you make sure the protective glasses you came here for are still in your pocket before heading to the door and leaving.");
			flags[kFLAGS.D3_MIRRORS_SHATTERED] = 1;
			combat.cleanupAfterCombat();
			menu();
			combat.cleanupAfterCombat(d3.resumeFromFight);
		}
		
		public function inSovietCoCSelfFucksYou():void
		{
			clearOutput();
			
			outputText("Everything feels so vague, so inconstent; your body and mind shimmer like a lake hit by rain, incapable of focusing, incapable of holding onto a shape, a slave to any force that wants to form you. Who are you? It is obvious, isn’t it. Your image floats in front of you, the only clear thing you can perceive. It grins triumphantly, and you grin back: it is all you can do. Its movements define you, dominate you utterly, within and without. When it steps forward and puts its hand out, it isn’t by choice you mimic the action - it is all you can do. Your fingers stretch out to meet their mirror image, but before they meet they touch a cold, invisible barrier. Glass. True understanding of your situation permeates you like spreading oil, but you cannot gasp, scream in horror, pull at your hair. You slowly pull away from the mirror’s surface, your grin widening, because that is what the demon who has taken your form is doing.");

			outputText("\n\n“<i>Beautiful,</i>” you and [he] breathe. “<i>I will do great things with this body, [name], things you couldn’t have imagined, poor soulful innocent that you were. I will take my revenge with it, but first...</i>” [He] stares at [his] reflection smoulderingly as [he] raises [his] hands to [his] armor. [He] forces you to take off your clothes with [him], and you feel it just as clearly as if you were controlling the actions; the way your underclothes whisper off you, the way your naked flesh goose bumps in the coolness of the room");
			if (player.hasCock()) outputText(", the way your turgid [cock] feels when you grasp it at the base.");
			else if (player.hasVagina()) outputText(", the way your [vagina] feels when you slide your fingers along its lips.");
			else 
			{
				outputText(", the way your");
				player.createVagina();
				outputText(" [vagina] feels when you slide your fingers against your... Wait, where did that come from? You push your fingers in more forcefully, determined to see through this illusion, but all you manage to do is arouse yourself beyond all reasonable measure. Somehow, <b>you've grown a tight, wet pussy to match your duplicate's!</b>");
			}
			if (player.hasCock() && !player.hasVagina())
			{
				outputText("\n\nYou masturbate with [him], forced to stand there and repeat [his] every pleasurable stroke, growing less gloating and more urgent with each jerk of the wrist as ten years of chastity step into the room and set their weight upon his groin. You feel that weight, terrible for an incubus to endure, and you cannot possibly last long against it. Your face contorts into one of unspeakable joy and release as you tap that urge, your cock contracting and then unleashing a font of cum, your body caught in orgasm for what seems like an eternity.");
				if (player.cocks.length > 1) outputText("  Your other cocks deliriously tighten and spurt their own loads at the same time, an uncontrollable storm of a high.");
			}
			else if (player.hasCock() && player.hasVagina())
			{
				outputText("\n\nYou masturbate with [him], forced to stand there and repeat [his] every pleasurable stroke, growing less gloating and more urgent with each jerk of the wrist as ten years of chastity step into the room and set their weight upon [his] groin. You feel that weight, terrible for an omnibus to endure, and you cannot possibly last long against it- your female sex, caught in the impetus, softens and drips to the movement of your hand. Your face contorts into one of unspeakable joy and release as you tap the urge, your cock contracting and then unleashing a font of cum. Your [vagina] quivers, tightens and wets itself at the same time, your whole body caught in orgasm for what seems like an eternity.");
				if (player.cocks.length > 1) outputText("  Your other cocks deliriously tighten and spurt their own loads at the same time, an uncontrollable storm of a high.");
			}
			else if (!player.hasCock() && player.hasVagina())
			{
				outputText("\n\nYou masturbate with her, forced to stand there and repeat her every pleasurable schlick, growing less gloating and more urgent with each flick of the finger as ten years of chastity step into the room and set their weight upon her groin. You feel that weight, terrible for a succubus to endure, and you cannot possibly last long against it. Your face contorts into one of unspeakable joy and release as you tap that urge, your [vagina] quivering, contracting and then wetting itself, your body caught in orgasm for what seems like an eternity. ");
			}
			
			outputText("\n\n“<i>Ahh...</i>” your mouth says finally, as you step back from the mirror, your eyes half-lidded with contentment. “<i>I really needed that.</i>” [Name] turns away from the surface you now embody to put [his] [armor] back on and you follow suit, gazing dumbly at the reflection of the room behind you. You want to shout and scream at [him] now, begging [him] to give you your body back, for [him] not to do what you know comes next, but you can’t- you can’t stop turning back around, you can’t stop yourself touching the surface of your mirror one last time and, smirking, stride out of the room. You mimic your body exiting out of sight of the mirror’s edge, and then... then you mimic a grey, empty room. Staring back at you hollowly, inert and empty. Listening to a metal door shutting behind you with a terrible finality.");

			outputText("\n\nWith your body and brain full of memory of how to defeat demons, coupled with [his] own knowledge and thirst for revenge, your impostor surprises Lethice and manages to destroy her, taking her place and ruling the mountains and beyond with a mania born of horizons and insanity she never knew. You know all this because [Name] is true to [his] promise not to inflict the same suffering [he] endured upon you, and you don’t have to stand in the mirror room for very long (although being a deserted storage chamber, you quickly learn, makes a mockery of concepts like “very long”). [He] has your glass prison brought to [his] lavish inner chambers and installs you there- nailed to the ceiling above [his] bed, specifically. From your vantage point you mimic [his] orgies, each more deranged than the last. You experience sensation even the doppelganger [him]self never knows, because you are forced to embody everything in the room. Not just every slave girl, boy and favored demon there, every bulging prick and tight, eager hole, not just your old body bucking, slithering and glorying in it all, but every dildo, butt-plug, whip, bead, chain, every satin sheet upon which soft flesh is urgently pressed. You encompass everyone’s thoughts, the slavering succulence of total submission, the coursing power and glory of [Name]’s maddened domineering, every mind-wiping orgasm and sensation bordering between screaming pain and ecstatic pleasure is yours to endure. ");

			outputText("\n\nYou quickly go completely insane, just like your bodysnatcher did, although not in a way [he] ever knew. You will never be able to express that insanity though. Every hour there is a new scene of complete depravity for you to reflect, personify and act out. A demon’s dearest wish - an eternity of constantly changing, mind-boggling sex - is your final fate.");

			getGame().gameOver();
		}
	}

}