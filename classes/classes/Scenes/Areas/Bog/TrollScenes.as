/**
 * ...
 * @author Pyromania
 */
package classes.Scenes.Areas.Bog 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Armors.LustyMaidensArmor;
	import classes.Items.Armors.SuccubusArmor;
	import classes.Scenes.Areas.GlacialRift.GlacialFemaleTroll;
	import classes.Scenes.Areas.GlacialRift.GlacialMaleTroll;
	import classes.Scenes.SceneLib;
	
	public class TrollScenes extends BaseContent
	{
		
		public function TrollScenes() 
		{
		}
		//Corrupted Male Troll
		public function encounterAdultMaleTroll():void {
			clearOutput();
			outputText("As you are wandering through the bog you are suddenly halted by a noise very near. You turn around and see a large man leaping towards you. You barely have enough time to dodge him as he tumbles in front of you, quickly springing up to his feet. His physique is supported by a very muscular build and his face is adorned with tusks jutting from his mouth, he seems very agitated. ");
			outputText("It doesn’t take long before you notice his lusty gaze towards you and his manhood already fully erect. He is definitely corrupt and if you’re not careful you may be his next victim.");
			startCombat(new CorruptedMaleTroll());
		}
		public function encounterAdultMaleTrollLost():void {
			clearOutput();
			outputText("The troll falls to the ground, "+(monster.HP < 1 ? "wounded from combat and unable to fight any longer":"too turned on to fight as he falls to the ground, face on the ground and gently stroking his length")+".\n\n");
			outputText("You inspect the beefy troll, he’s tall, easily over 7 feet, with some noticeable definition and musculature, covered head to toe in soft fur. You consider if you want to take advantage of him right now.\n\n");
			player.removeStatusEffect(StatusEffects.TrollDefeatsCounter);
			menu();
			if (player.hasVagina()) addButton(1, "Female Rape", encounterAdultMaleTrollLostFemaleRape);
			else addButtonDisabled(1, "Female Rape", "You need a vagina for this scene.");
			if (player.hasCock()) addButton(2, "Anal Rape", encounterAdultMaleTrollLostAnalRape);
			else addButtonDisabled(2, "Anal Rape", "You need a penis for this scene.");
			addButton(14, "Leave", encounterAdultMaleTrollLostLeave);
			LustyMaidensArmor.addTitfuckButton(7);
		}
		public function encounterAdultMaleTrollLostFemaleRape():void {
			clearOutput();
			outputText("You look at the troll, his face is pressed against the ground, kneeling but not lying down. Something about him is so intriguing, you walk up to him and his ears twitch as you approach, but otherwise he does nothing.\n\n");
			outputText("His manhood is pressed against his stomach, fully erect. Seeing his length makes you crave him further, you decide that you want to give this hunk a joyride.\n\n");
			outputText("You stand in front of him, and he looks up at you. You instruct him to lie on his back and he follows your command. You take off your [armor], much to his pleasure and straddle him, his manhood is so inviting as you hover just above his length. The troll starts breathing heavily in anticipation, he grabs hold of your hips and tries to pull you down onto his length. Something about his warm, soft and fuzzy presence is comforting, so you let him, but you’re still the one in control.\n\n");
			outputText("You slowly move down his manhood as he fills up your vagina. So warm, so inviting, it’s almost addicting. Once you’ve reached the base of his shaft he bucks into you. The sudden intrusion causes you to yelp slightly. He continues bucking against you as you ride his length, bobbing up and down his shaft as he holds onto you. You press your hands on his manly pecs for support as you ride him. The scent of his musk starts to get to you and you begin to feel dizzy.\n\n");
			player.cuntChange(18,true,true,false);
			outputText("He grunts aggressively as you feel pressure building up, you’re so close now, you need more. You bounce up against him even more, but he stays at the same pace. You cry out as your orgasm hits, coating his manhood in girlcum"+(player.hasCock() ? " as you shoot ropes of cum on his chest":"")+".\n\n");
			outputText("You realise that you still have a little time before he cums, do you want to let him finish inside you?\n\n");
			menu();
			addButton(1, "Inside", encounterAdultMaleTrollLostFemaleRapeInside);
			addButton(3, "Outside", encounterAdultMaleTrollLostFemaleRapeOutside);
		}
		public function encounterAdultMaleTrollLostFemaleRapeInside():void {
			outputText("You couldn’t lift yourself up even if you wanted to, his presence is strong and you fall down closer to him. He wraps his hands around your back, locking you down onto his chest as he thrusts into you even harder. You moan softly as he groans loudly, shooting waves and waves of seed directly into your womb. He doesn’t stop, still pumping into you. You couldn’t hope to contain all the cum he’s unloading into you. After at least a minute of his continuous orgasm he finally slows down. His grasp on you relaxes as he passes out from exhaustion.\n\n");
			outputText("You could almost fall asleep within his soft, fuzzy embrace. The comfort of his warmth is soothing, especially having been filled. You know it’s unwise to stay with him, your legs are shaky but you manage.\n\n");
			outputText("You pick up your [armor] and head back to your camp.\n\n");
			player.sexReward("cum","Vaginal");
			doNext(cleanupAfterCombat);
		}
		public function encounterAdultMaleTrollLostFemaleRapeOutside():void {
			outputText("It takes a lot of inner strength, but you manage to break free from his grasp as you lift yourself from his length.\n\n");
			outputText("You can’t escape his grasp, so you just lie down on his soft chest. His heavy breathing lifts you up and down on his chest. His hands wrap around you, pulling you closer to him, hugging you tightly as he cums into the air. You feel yourself rock within his grasp as he desperately tries humping the air. After at least a minute of continuous orgasm he relaxes, his grasp on you relaxes as he passes out from exhaustion.\n\n");
			outputText("You stand up and inspect the mess, there is a large pool of seed below him, you’re not sure if you would’ve been able to take such a massive load.\n\n");
			outputText("You pick up your [armor] and head back to your camp.\n\n");
			doNext(cleanupAfterCombat);
		}
		public function encounterAdultMaleTrollLostAnalRape():void {
			clearOutput();
			outputText("You look down at the troll lying down, rear in the air. You can’t resist the opportunity to take such an amazing ass.\n\n");
			outputText("You strip out of your [armor], unveiling your [cock] as you kneel behind him. His ass is still in the air, almost as if he were inviting you to enter. You take a firm grasp on his muscular rear before you allow yourself to penetrate him.\n\n");
			outputText("You slowly begin pumping into him, he releases a soft moan as you press deeper into his backdoor. He reaches his hand to his length as he jerks himself off in tandem with your thrusts.\n\n");
			outputText("You can feel his sphincter clench around your shaft as you continue railing him. You feel your shaft begin to twitch as you near your own orgasm. His backdoor is desperately trying to coax you to finish, he is desperate for this. You moan loudly as you finally orgasm, shooting waves of spunk into him.\n\n");
			outputText("The troll groans as he slumps down, exhausted from the beating you gave him. You clean yourself up as you pick up your [armor] and take your leave.\n\n");
			player.sexReward("Default","Dick",true,false);
			doNext(cleanupAfterCombat);
		}
		public function encounterAdultMaleTrollLostLeave():void {
			clearOutput();
			outputText("You decide it’s best not to mess with him and take your business elsewhere.\n\n");
			doNext(cleanupAfterCombat);
		}
		public function encounterAdultMaleTrollWon():void {
			if (player.statusEffectv1(StatusEffects.TrollDefeatsCounter) > 9) {
				outputText("The troll gives you a smug grin, you lie helpless before him, as you should be. The big strong troll stands above you before grabbing onto you, he pulls you up towards his face before pressing his lips against yours, his tusks barely grazing your cheeks. He bites your lower lips softly before pressing his tongue past your lips. His presence is firm and aggressive, making sure to explore every inch of your mouth. You don’t fight back, this is what you want… this is what you <b>need</b>.\n\n");
				outputText("Once he’s done making out with you he drags you with him. You don’t resist, anywhere with him is better than wasting away on whatever dump that you used to reside in. Eventually you find yourself in a shallow cave, the interior has some furnishing with grass, twigs and leaves that make a relatively comfortable place to rest in.\n\n");
				outputText("He tosses you into the makeshift bedroll, you lie there submissively as he removes your [armor]. You won’t be needing that ever again.\n\n");
				outputText("Once he’s finished he kneels down above you, he holds your face with his strong, dense hands, rubbing you gently with his thumb. His thumb prods at your lips, gently inserting himself into your mouth. You suck on his thumb and he gives a satisfied grin. He stands up, moving closer to you as he hovers above you.\n\n");
				outputText("He kneels just above your face, his large balls pressed against your chin as he aligns his manhood with your mouth before forcing himself down your throat. You do your best to accept his gift, your lips are at the base of his shaft as you desperately do your best to satisfy your new mate. You gag slightly from his intrusion, but once you’re comfortable you make way with making sure to lick his cock to the rhythm of his slow strokes. He pumps slowly, testing your limits, seeing how much you can take. He is a bit gentler this time around, maybe he wants to make sure that you are comfortable as well?\n\n");
				outputText("He starts growling softly as you feel his length begin to twitch. You look up at him, but his pecs are blocking your view of his face. You figure that the only thing you need to do anyway is satisfy him.\n\n");
				outputText("He grunts loudly as you feel waves of his spunk shoot down your throat. You happily take in every last drop he has to offer. It feels like his orgasm never ends, not that you want it to, but there is so much cum.\n\n");
				outputText("Once he’s unloaded everything into you, he shifts down your body, picking you up and pulling you to his face. You are locked into his kiss as his tongue roams around your mouth. You moan into his embrace. This is your life now, this is all you need.\n\n");
				outputText("Your days are spent being his personal cock sleeve, he enjoys your mouth the most, but never fails to neglect your other needs. You are practically drenched in his cum daily. It doesn’t matter what time of the day it may be, because you’re only in the mood for one thing, and he makes sure to remind you what to live for every hour.\n\n");
				outputText("You can’t believe you never realised that subservience to such a large hunk was the only thing that you were missing in your life.\n\n");
				player.sexReward("cum","Lips");
				EventParser.gameOver();
                return;
			}
			else if (player.statusEffectv1(StatusEffects.TrollDefeatsCounter) > 4) {
				outputText("The troll looks at you closely, gritting his teeth. He looks almost strained, what’s going on..?\n\n");
				outputText("He clicks his tongue, \"<i>Tsk, tsk, tsk. You… You, you, you…</i>\" He slowly approaches with long pauses in between each word. \"<i>You’re… so... familia’...</i>\"\n\n");
				outputText("His height towers over you, you grow concerned with what he’s about to do, what does he want from you now? He rubs his tusks with his hands, seemingly lost in thought before staring at you intensely.\n\n");
				outputText("He gives a sly grin before his erection rises to full mast. \"<i>Up, now.</i>\" You try to stand up, but before you’re back on your feet he presses your head down, \"<i>Down.</i>\" You fall on your knees beneath him, his lengthy shaft pressed against your face. With one hand still at the top of your head, he grabs the base of his shaft with his free hand, gently prodding your face with his manhood. He growls softly at you before pressing the tip of his prick against your lips.\n\n");
				outputText("Seeing no other choice, you gently wrap your mouth over his length. He thrusts forward into you, you choke as he rams his 9 inches down your throat. He slowly humps into your mouth, trying to get as much out of you as possible. You do your best to keep up, once he’s slowed down you’re able to maintain a steady rhythm.\n\n");
				outputText("You spend several minutes blowing him before he puts both hands at the back of your head. He pulls you close to him as he thrusts even harder into you, you do your best not to choke from the sudden aggression.\n\n");
				outputText("He grunts loudly as you feel his length twitch inside your mouth. With a loud howl, he cums, shooting jets of seed directly down your throat. He groans softly before pulling out from your face. He gives you a gentle head rub before leaving you alone in the bog.\n\n");
				outputText("You somehow feel… empty without him. You can’t explain why, but you… miss him? Something is definitely wrong here, you should avoid submitting to him so frequently before he gets inside your head.\n\n");
				player.sexReward("cum","Lips");
			}
			else {
				if (player.hasVagina() && (!sceneHunter.uniHerms || rand(2) == 0)) {
					outputText("You look up as the troll approaches you, making quick work of your [armor], quickly tearing it off of you and inspecting your body. Upon seeing your vagina he gives you a taunting grin as he pins you to the ground, grabbing hold onto your wrists, keeping you locked within his grasp, unable to escape from beneath him.\n\n");
					outputText("He places his torso against your body, you squirm beneath him but to no avail, he’s far too strong. His prick has been erect for some time now, he wastes no time aligning himself with your sex before penetrating you. His manhood presses into your tight snatch, gently stretching out your walls. He feels so big inside you as he presses deeper, bucking into you.\n\n");
					player.cuntChange(18,true,true,false);
					outputText("You submit to his dominance, wrapping your [legs] around his waist. He continues grinding against you, your face smothered into his fuzzy chest. You spend several minutes trapped beneath him, it seems like there’s no end to his stamina. You’re ashamed that you’re getting off to him, but it doesn’t take long before you feel a familiar pressure build up within your loins. You tense up, trying to resist, but your body craves more. You moan softly and he responds with a low growl. ");
					outputText("Your [legs] squeeze onto him, holding on for dear life as your climax finally hits. You cry out in pleasure as you clench around his manhood, trying to coax him to cum as well, desperate for his seed.\n\n");
					outputText("You can feel his length begin to twitch as he thrusts into you with further aggression. His soft growls become a tremendous howl as he finally cums into you. He looks down at you with a satisfied grin before releasing his grip on you and standing back up, leaving you alone in the bog.\n\n");
					player.sexReward("cum","Vaginal");
				}
				else {
					outputText("You look up as the troll approaches you, making quick work of your [armor], quickly tearing it off of you and inspecting your body. Seeing your lack of a vagina, he clicks his tongue as he turns you around onto your back and positions himself behind you.\n\n");
					outputText("He kneels behind you, grabbing hold of your hips as he pulls your rear up to his throbbing manhood. He lines himself against your hole before unceremoniously thrusting himself into you. All 9 inches of him are thrusted into you again and again as he uses you like a cheap sleeve.\n\n");
					player.buttChange(18,true,true,false);
					outputText("You can’t help yourself, there’s something uncanny about him that makes you crave more. You groan beneath him as your body is rocked from his thrusts. You squirm in pleasure, but his dense hands keep you locked in place beneath him as he growls softly at you. His pounding becomes more frantic as he steadily reaches his climax, you can feel yourself reaching the edge as well.\n\n");
					outputText("The troll leans down further, his abs pressed against your back, completely wrapping you within his arms as he pumps into you with tremendous vigor, you cry in delight as you finally orgasm"+(player.hasCock() ? ", shooting ropes of cum all over the ground beneath you":"")+". He keeps pounding away at you, thrusting with firm strokes, letting loose a low growl. Finally, after what feels like hours he cums into you with a tremendous howl.\n\n");
					outputText("The troll sighs softly as he drops you to the ground, having lost most of his interest in you, getting what he wanted.\n\n");
					player.sexReward("cum","Anal");
				}
			}
			if (player.hasStatusEffect(StatusEffects.TrollDefeatsCounter)) player.addStatusValue(StatusEffects.TrollDefeatsCounter, 1, 1);
			else player.createStatusEffect(StatusEffects.TrollDefeatsCounter, 1, 0, 0, 0);
			cleanupAfterCombat();
		}
		//Corrupted Female Troll
		public function encounterAdultFemaleTroll():void {
			clearOutput();
			outputText("As you are wandering through the bog you are suddenly halted by a noise very near. You turn around and see a large woman leaping towards you. You barely have enough time to dodge her as she tumbles in front of you, quickly springing up to her feet. Her physique is supported by a very muscular build and her face is adorned with tusks jutting from her mouth, she seems very agitated. It doesn’t take long before you notice her lusty gaze towards you and her nether lips dripping beads of lubricant. She is definitely corrupt and if you’re not careful you may be her next victim.\n\n");
			startCombat(new CorruptedFemaleTroll());
		}
		public function encounterAdultFemaleTrollLost():void {
			clearOutput();
			outputText("The troll falls to the ground, "+(monster.HP < 1 ? "wounded from combat and unable to fight any longer":"too turned on to fight as she falls to the ground, face on the ground, rubbing her breasts slowly")+".\n\n");
			outputText("You look at her prone form and consider what you want to do with her.\n\n");
			menu();
			if (player.hasCock()) {
				addButton(1, "Rape", encounterAdultFemaleTrollLostRape);
				addButton(2, "Anal Rape", encounterAdultFemaleTrollLostAnalRape);
			}
			else {
				addButtonDisabled(1, "Rape", "You need a penis for this scene.");
				addButtonDisabled(2, "Anal Rape", "You need a penis for this scene.");
			}
			if (player.hasVagina()) addButton(3, "Female Rape", encounterAdultFemaleTrollLostFemaleRape);
			else addButtonDisabled(3, "Female Rape", "You need a vagina for this scene.");
			addButton(14, "Leave", encounterAdultFemaleTrollLostLeave);
		}
		public function encounterAdultFemaleTrollLostRape():void {
			clearOutput();
			outputText("You figure that if she wanted to have your dick, then you might as well give her exactly what she wants.\n\n");
			outputText("You disrobe your [armor] as you gently rub your length, getting it to full mast. The troll is still unaware of your current actions. Suddenly she takes a deep sniff, looking up toward you with renewed hope. She lies down, spreading her legs out for you, ready for your entry.\n\n");
			outputText("Her toned body is quite a sight, you figure that you better give her what she wants. You kneel down before her as you align your tip with her entry before finally thrusting in. She coos as you enter. Her legs wrap around your body as you position your arms by her side. You continue thrusting into her for a few minutes. She takes in a sharp breath as her grip around you tightens, her walls tighten as she keeps you close. She is getting close to the edge. You feel your length begin to throb within her as well. ");
			outputText("She takes in another breath as she cums, girlcum leaking over your manhood as you thrust away into her. You moan as you finally hit your limits. She tries to milk your dick of everything it has to offer as you unload your seed into her womb. She passes out from exhaustion from the act.\n\n");
			outputText("Once you’re done you stand up, picking up your [armor] before you rifle through her pockets.\n\n");
			player.sexReward("vaginalFluids","Dick");
			doNext(cleanupAfterCombat);
		}
		public function encounterAdultFemaleTrollLostAnalRape():void {
			clearOutput();
			outputText("You’re not letting her go that easily, you know she wanted your prick inside her twat, but you have different plans in mind.\n\n");
			outputText("You move behind her, unbeknownst to her, kneeling down and aligning your shaft with her backdoor. You waste no time forcing yourself into her tight year.\n\n");
			outputText("She yelps at your sudden intrusion before taking a sharp breath. She starts rocking her body, pressing her behind against your crotch, trying to fit more of you inside her. Her sphincter contracts around your length, testing your limits as she squeezes around you with everything she has. It doesn’t take long before you can feel yourself nearing the edge, your manhood starts throbbing as you get closer and you thrust inter her with greater force. Sensing your imending orgams, she bucks against you harder, desperate for your length. ");
			outputText("Finally you cum inside her, waves of spunk are shot into her rear as you calm down and clean yourself up. You let her drop to the ground, but she doesn’t seem satisfied. You shrug, it’s not your problem.\n\n");
			outputText("You pick up your [armor] and leave her alone in the bog.\n\n");
			player.sexReward("Default","Dick",true,false);
			doNext(cleanupAfterCombat);
		}
		public function encounterAdultFemaleTrollLostFemaleRape():void {
			clearOutput();
			outputText("You examine the muscular woman before you, she is completely exposed, lying prone on the bog ground. You can’t deny that something about her is quite attractive.\n\n");
			outputText(""+(player.isNaked() ? "":"You quickly disrobe yourself so that nothing stands between you and her. ")+"You quickly survey her, making sure she’s not armed or read to fight back. Judging by the stare in her eyes, she has nothing but malicious intent for you.\n\n");
			outputText("As you approach you can see she’s not going to relent, growling aggressively toward you. You feel something at your foot, within the mud of the bog you notice some VERY sturdy looking vines. This gives you a wicked through as you return your gaze to her.\n\n");
			outputText("You pick up some vines and approach her, despite her weakened state, she puts up a fight to her last breath. You wrestle around with her, feeling her soft fur brush against you, it nearly gives you carpet burn as you finally pin her down beneath you.\n\n");
			outputText("She hisses at you once more as you make sure to keep mindful of her tusks. You grip her wrists as she struggles against you, trying to buck you off of her, but you press more of your weight upon her torso, reminding her that you’re the one in charge now.\n\n");
			outputText("Eventually, through all of her wriggling, you manage to overpower her, tying her wrists together above her head so she cannot fight back. You wipe the mud off of your arms before reaching for her legs. She kicks and squirms, but you press your weight against her hips, locking her legs together before binding them up.\n\n");
			outputText("Satisfied with your victim’s trappings, you finally let yourself gaze upon her. The muscular woman is now at your utter mercy, unable to fight back if she wanted to. Your [vagina] moistens at the thought of being with the woman beneath you. You sink yourself on top of the muscular troll, rapid breaths slow down as her struggles relent.\n\n");
			outputText("You bring your crotch to hers, pressing more of your weight against her hips as you can feel her cunt moisten to the presence of yours. Beads of lubricant slowly drip as you hold onto her shoulders, slowly grinding yourself against her nethers.\n\n");
			outputText("You reach a [finger] down to your nethers, slowly digging past your lips before prodding at your clit. Allowing your hand to roam down her form, you bring your other [finger] to her clit, gently frigging her as well. You can feel a small stream of girlcum from her running along your nether lips as it flows down between her thighs.\n\n");
			outputText("She squirms softly as you continue rubbing your cunt against hers. You make sure she’s forced to enjoy it as much as you are, toying with her clit while not forgetting to give yours attention as well.\n\n");
			outputText("You can feel her try to rub against you with increased desire. Her eyes close as she tries to clench her legs together, pressing against you as her girlcum slowly dribbles against you.\n\n");
			outputText("You can feel the pressure build up within your loins as well, your clit eager for more attention as you try to match her rhythm, getting lost in the pleasure of the gentle friction between the two of you.\n\n");
			outputText("Her breathing staggers with her orgasm as you can feel her juices flow more, trickling down her legs. You probe at your clit before cumming as well, allowing your girlcum to spill onto her.\n\n");
			outputText("Relieved, you get off of her, not wanting to stay in the muddy bog for much longer. You clean yourself off"+(player.isNaked() ? "":", grabbing your armor,")+" before loosening her bindings. You make sure it’s not loose enough for her to attack you right now, but enough so she can wiggle out within time.\n\n");
			outputText("Her gaze averts from you, almost shamefully before you take your leave.\n\n");
			player.sexReward("Default","Default",true,false);
			doNext(cleanupAfterCombat);
		}
		public function encounterAdultFemaleTrollLostLeave():void {
			clearOutput();
			outputText("You decide not to mess with her and return to your [camp].\n\n");
			doNext(cleanupAfterCombat);
		}
		public function encounterAdultFemaleTrollWon():void {
			if (player.hasCock()) {
				outputText("She inspects your body, copping a feel from in between your legs. She smiles in satisfaction when her fingers grace your erection.\n\n");
				outputText("She quickly removes your [armor] before throwing you onto your back. You lie helplessly before her as she straddles you. She spends a moment aligning the tip of your length with her twat, gently fingering your tip. You try to hump her in desperation, she smiles, getting the reaction she wanted before slowly dropping herself onto your prick.\n\n");
				outputText("You squirm beneath her, but she leaves you locked in place underneath her strong legs. You can’t resist any longer and just succumb to her desires. Her pace is agonizingly slow. You try to buck into her, but when you move she grabs you by the neck, pinning you down until you get the idea that she’s the one in control. You struggle to breathe as she keeps a firm grasp over you.\n\n");
				outputText("You soon feel your length begin to twitch as you near your orgasm. Sensing your impending climax she bounces on you with a little more force, trying to fit every last inch of your manhood inside her.\n\n");
				outputText("She breathes sharply before you feel her girlcum splatter across your prick, further lubing you up. You groan as your orgasm finally hits, waves and waves of your spunk jet inside of her awaiting walls. She finally lets go of your neck and you pass out from exhaustion.\n\n");
				player.sexReward("vaginalFluids","Dick");
			}
			else outputText("She inspects your body, trying to cop a feel from in between your legs. She sighs dejectly when she finds your lack of a penis. She rifles through your gem pouch before leaving you alone in the bog.\n\n");
			cleanupAfterCombat();
		}
		//Glacial Male Troll
		public function encounterAdultGlacialMaleTroll():void {
			clearOutput();
			outputText("As you are wandering through the glacial rift you are suddenly halted by the sound of footsteps crunching in the snow. You turn around and see a large man leaping towards you. You barely have enough time to dodge her as he tumbles around the snow with you. The man gives you a hostile snarl as you shake him off before the both of you enter a combat stance.\n\n");
			SceneLib.glacialRift.GlacialRiftConditions();
			startCombat(new GlacialMaleTroll());
		}
		public function encounterAdultGlacialMaleTrollLost():void {
			clearOutput();
			outputText("The troll falls to the snow, "+(monster.HP < 1 ? "wounded from combat and unable to fight any longer":"too turned on to fight as he falls to the snow on his back, gently stroking his length")+".\n\n");
			outputText("You inspect the large troll, he’s tall, easily over 9 feet, with an intimidating physique. He is large and bearish, covered head to toe in soft fur. You consider if you want to take advantage of him right now.\n\n");
			menu();
			if (player.hasVagina()) addButton(1, "Female Rape", encounterAdultGlacialMaleTrollLostFemaleRape);
			else addButtonDisabled(1, "Female Rape", "You need a vagina for this scene.");
			if (player.hasCock()) addButton(2, "Anal Rape", encounterAdultGlacialMaleTrollLostAnalRape);
			else addButtonDisabled(2, "Anal Rape", "You need a penis for this scene.");
			addButton(14, "Leave", encounterAdultGlacialMaleTrollLostLeave);
			LustyMaidensArmor.addTitfuckButton(7);
		}
		public function encounterAdultGlacialMaleTrollLostFemaleRape():void {
			clearOutput();
			outputText("It sure is cold right now, and now you have a large, hunkish glacial troll to huddle against all to yourself. You get close to him before you remove your [armor]. You straddle him as the troll growls in disgust, but he is too weak to fight back. You spend a moment undressing him, allowing your [skin] to make contact with his warm body. His fur is so comforting, it’s a welcome respite from the cold.\n\n");
			outputText("You lie upon the burly troll as you align his length with your netherlips. His strong arms reflexively reach up and wrap around you, further protecting you from the cold. You gyrate your hips on him as he slowly bucks into you. You almost wish you could spend your time like this forever curled up with him.\n\n");
			outputText("You slowly move down his manhood as he fills up your vagina. So warm, so inviting, it’s almost addicting. His hands wrapped tightly against you suddenly take control, grabbing your hips and lifting you up and down his cock. You go with his actions, unable to resist his strength, he’s your only solace now from the bitter cold. You press yourself tighter against him, hugging him tightly as he pumps into you while pulling you down onto his length.\n\n");
			player.cuntChange(20,true,true,false);
			outputText("He grunts aggressively as you feel pressure building up, you’re so close now, you need more. You bounce up against him even more, but he stays at the same pace. You cry out as your orgasm hits, coating his manhood in girlcum"+(player.hasCock() ? " as you shoot ropes of cum on his chest":"")+".\n\n");
			outputText("He wraps his hands around your back, locking you down onto his chest as he thrusts into you even harder. You moan softly as he groans loudly, shooting waves and waves of seed directly into your womb. He doesn’t stop, still pumping into you. You couldn’t hope to contain all the cum he’s unloading into you. After at least a minute of his continuous orgasm he finally slows down. His grasp on you relaxes as he passes out from exhaustion.\n\n");
			outputText("You could almost fall asleep within his soft, fuzzy embrace, still safe from the cold. You know it’s unwise to stay with him, your legs are shaky, but you manage.\n\n");
			outputText("You pick up your [armor] and head back to your camp.\n\n");
			player.sexReward("cum","Vaginal");
			doNext(cleanupAfterCombat);
		}
		public function encounterAdultGlacialMaleTrollLostAnalRape():void {
			clearOutput();
			outputText("You look down at the burly troll lying down. You can’t resist the opportunity to take such an amazing ass.\n\n");
			outputText("You strip out of your [armor], just enough to unveil your [cock]. You tell him to bend over as you kneel behind him. He doesn’t even put up a fight after the beating you gave him. You take a firm grasp on his muscular rear before undressing him, giving you a full view of his firm ass. Once readied, you allow yourself to penetrate him.\n\n");
			outputText("You slowly begin pumping into him, holding him as tightly as possible, so that you’re warmed up by his fur. He releases a soft moan as you press deeper into his backdoor. He reaches his hand to his length as he jerks himself off in tandem with your thrusts.\n\n");
			outputText("You can feel his sphincter clench around your shaft as you continue railing him. You feel your shaft begin to twitch as you near your own orgasm. His backdoor is desperately trying to coax you to finish, he is desperate for this. You moan loudly as you finally orgasm, shooting waves of spunk into him.\n\n");
			outputText("The troll groans as he slumps down to the snow, exhausted from the beating you gave him. You quickly clean yourself up as you pick up your [armor] and take your leave.\n\n");
			player.sexReward("Default","Dick",true,false);
			doNext(cleanupAfterCombat);
		}
		public function encounterAdultGlacialMaleTrollLostLeave():void {
			clearOutput();
			outputText("You decide it’s best not to mess with him and take your business elsewhere.\n\n");
			doNext(cleanupAfterCombat);
		}
		public function encounterAdultGlacialMaleTrollWon():void {
			if (rand(4) == 0) {
				outputText("The troll eyes your form, narrowing his gaze as if he’s thinking about something.\n\n");
				if (player.hasVagina()) {
					outputText("You look up as the troll approaches you, making quick work of your [armor], quickly tearing it off of you and inspecting your body. Upon seeing your vagina he gives you a taunting grin as he pins you to the ground, grabbing hold onto your wrists, keeping you locked within his grasp, unable to escape from beneath him.\n\n");
					outputText("He places his torso against your body, you squirm beneath him but to no avail, he’s too strong for you. His length has been erect for some time now, he wastes no time aligning himself with your sex before penetrating you. His manhood presses into your tight snatch, gently stretching out your walls. He feels so big inside you as he presses deeper, bucking into you.\n\n");
					player.cuntChange(20,true,true,false);
					outputText("You submit to his dominance, wrapping your [legs] around his waist. He continues grinding against you, your face smothered into his fuzzy chest. You spend several minutes trapped beneath you, it seems like there’s no end to his stamina. You’re ashamed that you’re getting off to him, but it doesn’t take long before you feel a familiar pressure build up within your loins. You tense up, trying to resist, but your body craves more. You moan softly and he responds with a low growl. Your [legs] squeeze onto him, holding on for dear life as your climax finally hits. ");
					outputText("You cry out in pleasure as you clench around his manhood, trying to coax him to cum as well, desperate for his seed.\n\nYou can feel his length begin to twitch as he thrusts into you with further aggression. His soft growls become a tremendous howl as he finally cums into you. He looks down at you with a satisfied grin before releasing his grip on you and standing back up, leaving you alone in the snow.\n\n");
					player.sexReward("cum","Vaginal");
				}
				else {
					outputText("You look up as the burly troll approaches you, making quick work of your [armor], quickly tearing it off of you and inspecting your body. Seeing your lack of a vagina, he clicks his tongue as he turns you around onto your back and positions himself behind you.\n\n");
					outputText("He kneels behind you, grabbing hold of your hips as he pulls your rear up to his throbbing manhood. He lines himself against your hole before every so slowly thrusting himself into you. All 10 inches of him are thrusted into you again and again as he uses you like his personal toy.\n\n");
					player.buttChange(20,true,true,false);
					outputText("You can’t help yourself, there’s something uncanny about him that makes you crave more. You groan beneath him as your body is slowly rocked from his thrusts. You squirm in pleasure, but his dense hands keep you locked in place beneath him as he growls softly at you. His pounding becomes more frantic as he steadily reaches his climax, you can feel yourself reaching the edge as well.\n\n");
					outputText("The troll leans down further, his stomach pressed against your back, completely wrapping you within his arms as he pumps into you with tremendous vigor, you cry in delight as you finally orgasm"+(player.hasCock()?", shooting ropes of cum all over the ground beneath you":"")+". He keeps pounding away at you, thrusting with firm strokes, letting loose a low growl. Finally, after what feels like hours he cums into you with a tremendous howl.\n\n");
					outputText("The troll sighs softly as he drops you to the snow, having lost most of his interest in you, getting what he wanted.\n\n");
					player.sexReward("cum","Anal");
				}
			}
			else outputText("The troll scoffs.\n\n\"<i>Stay. out…</i>\" he grumbles before leaving.");
			cleanupAfterCombat();
		}
		//Glacial Female Troll
		public function encounterAdultGlacialFemaleTroll():void {
			clearOutput();
			outputText("As you are wandering through the glacial rift you are suddenly halted by the sound of footsteps crunching in the snow. You turn around and see a large woman leaping towards you. You barely have enough time to dodge her as she tumbles around the snow with you. The woman gives you a hostile snarl as you shake her off before the both of you enter a combat stance.\n\n");
			SceneLib.glacialRift.GlacialRiftConditions();
			startCombat(new GlacialFemaleTroll());
		}
		public function encounterAdultGlacialFemaleTrollLost():void {
			clearOutput();
			outputText("The troll falls to the ground, "+(monster.HP < 1 ? "wounded from combat and unable to fight any longer":"too turned on to fight as she falls to the ground, face on the ground, rubbing her breasts slowly")+".\n\n");
			outputText("You look at her prone form and consider what you want to do with her.\n\n");
			menu();
			if (player.hasCock()) {
				addButton(1, "Rape", encounterAdultGlacialFemaleTrollLostRape);
				addButton(2, "Anal Rape", encounterAdultGlacialFemaleTrollLostAnalRape);
			}
			else {
				addButtonDisabled(1, "Rape", "You need a penis for this scene.");
				addButtonDisabled(2, "Anal Rape", "You need a penis for this scene.");
			}
			addButton(14, "Leave", encounterAdultGlacialFemaleTrollLostLeave);
		}
		public function encounterAdultGlacialFemaleTrollLostRape():void {
			clearOutput();
			outputText("You approach the troll, slipping her armor off much to her dismay, but she’s too weak to fend you off. Eventually her entire body is on display for you"+(player.isNaked()?"":" as you take the time to disrobe yourself as well")+".\n\n");
			outputText("Her stout body is quite a sight, you figure that you better give her what she wants. You kneel down before her as you align your tip with her entry before finally thrusting in. She coos as you enter. Her legs wrap around your body as you position your arms by her side. You continue thrusting into her for a few minutes. She takes in a sharp breath as her grip around you tightens, her walls tighten as she keeps you close. She is getting close to the edge. You feel your length begin to throb within her as well. ");
			outputText("She takes in another breath as she cums, girlcum leaking over your manhood as you thrust away into her. You moan as you finally hit your limits. She tries to milk your dick of everything it has to offer as you unload your seed into her womb. She passes out from exhaustion from the act.\n\n");
			outputText("Once you’re done you stand up, picking up your [armor] before you rifle through her pockets.\n\n");
			player.sexReward("vaginalFluids","Dick");
			doNext(cleanupAfterCombat);
		}
		public function encounterAdultGlacialFemaleTrollLostAnalRape():void {
			clearOutput();
			outputText("You’re not letting her go that easily, perhaps a different course of action is in order here. You move beside her, undressing her much to her dismay, but she’s too weak to fight back."+(player.isNaked()?"":" You take the time to taunt her, slowly undressing yourself before her.")+"\n\n");
			outputText("She yelps at your sudden intrusion before taking a sharp breath. She starts rocking her body, pressing her behind against your crotch, trying to fit more of you inside her. Her sphincter contracts around your length, testing your limits as she squeezes around you with everything she has. It doesn’t take long before you can feel yourself nearing the edge, your manhood starts throbbing as you get closer and you thrust inter her with greater force. ");
			outputText("Sensing your imending orgams, she bucks against you harder, desperate for your length. Finally you cum inside her, waves of spunk are shot into her rear as you calm down and clean yourself up. You let her drop to the ground, but she doesn’t seem satisfied. You shrug, it’s not your problem.\n\n");
			outputText("You pick up your [armor] and leave her alone in the snow.\n\n");
			player.sexReward("Default","Dick",true,false);
			doNext(cleanupAfterCombat);
		}
		public function encounterAdultGlacialFemaleTrollLostLeave():void {
			clearOutput();
			outputText("You decide not to mess with her and return to your [camp].\n\n");
			doNext(cleanupAfterCombat);
		}
		public function encounterAdultGlacialFemaleTrollWon():void {
			if (rand(4) == 0) {
				if (player.hasCock()) {
					outputText("She inspects your body, copping a feel from in between your legs. She smiles in satisfaction when her fingers grace your erection.\n\n");
					outputText("She quickly removes your [armor] before throwing you onto your back. You lie helplessly before her as she straddles you. She spends a moment aligning the tip of your length with her twat, gently fingering your tip. You try to hump her in desperation, she smiles, getting the reaction she wanted before slowly dropping herself onto your prick.\n\n");
					outputText("You squirm beneath her, but she leaves you locked in place underneath her strong legs. You can’t resist any longer and just succumb to her desires. Her pace is agonizingly slow. You try to buck into her, but when you move she grabs you by the neck, pinning you down until you get the idea that she’s the one in control. You struggle to breathe as she keeps a firm grasp over you.\n\n");
					outputText("You soon feel your length begin to twitch as you near your orgasm. Sensing your impending climax she bounces on you with a little more force, trying to fit every last inch of your manhood inside her.\n\n");
					outputText("She breathes sharply before you feel her girlcum splatter across your prick, further lubing you up. You groan as your orgasm finally hits, waves and waves of your spunk jet inside of her awaiting walls. She finally lets go of your neck and you pass out from exhaustion.\n\n");
					player.sexReward("vaginalFluids","Dick");
				}
				else outputText("She inspects your body, trying to cop a feel from in between your legs. She sighs dejectly when she finds your lack of a penis. She rifles through your gem pouch before leaving you alone in the snow.\n\n");
			}
			else outputText("\"<i>Don’t come back,</i>\" she snarls before leaving.");
			cleanupAfterCombat();
		}
	}
}