package classes.Scenes.Areas.Desert {
import classes.*;
import classes.BodyParts.Face;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

public class NagaScene extends BaseContent{
        private var gorgonOrNaga:String = "naga";
		private var isGorgon:Boolean=false;

    public function NagaScene(gorgon:Boolean = false) {
            if (gorgon) {
				isGorgon=gorgon;
                gorgonOrNaga = "gorgon";
            }
	}
//NAGA STATUS
//v1 - players last fuck was as naga - 1 = true, 0 = false
//v2 - player has ever fucked as a naga.  1 = true, 0 = false
public function nagaEncounter():void {
	spriteSelect(SpriteDb.s_naga);
	//Create status if needed
	if(!player.hasStatusEffect(StatusEffects.Naga)) player.createStatusEffect(StatusEffects.Naga,0,0,0,0);
	clearOutput();
    if (player.isNaga() && flags[kFLAGS.SAMIRAH_FOLLOWER] < 5) {
        nagaNaga();
        return;
    }
	if (player.isNaga() && (flags[kFLAGS.SAMIRAH_FOLLOWER] >= 5 && flags[kFLAGS.SAMIRAH_FOLLOWER] < 10)) {
		SceneLib.samirah.desertEncounters();
		return;
	}
	if (flags[kFLAGS.SAMIRAH_FOLLOWER] >= 10) {
		outputText("You are walking through the shifting sands of the desert when you hear a sudden hiss behind you. Not expecting to be attacked by a snake, you quickly leap forward and turn around.\n\n");
		outputText("To your surprise, what you see is not Samirah even thou she looks very similar - a half-human half-snake hybrid with some purple lines over her body. She surges up and hisses even louder than before, showing off a pair of formidable fangs dripping with venom and making purple lines on her body glowing faintly.");
	}
	//If player's last fight did not involve them being a naga
	if(player.statusEffectv1(StatusEffects.Naga) == 0) {
		if(!player.hasStatusEffect(StatusEffects.Naga)) player.createStatusEffect(StatusEffects.Naga,0,0,0,0);
		outputText("You are walking through the shifting sands of the desert when you hear a sudden hiss behind you. Expecting to be attacked by a snake, you quickly leap forward and turn around.\n\n");
		outputText("To your surprise, what you see is not exactly a snake; it's a naga - a half-human half-snake hybrid. She surges up and hisses even louder than before, showing off a pair of formidable fangs dripping with venom. Gazing at her long and slender reptilian body swaying on the sand like quicksilver, you can only stand still in admiration of this terrible wonder.");
	}
	//If player was a naga during last encounter
	//And isnt now
	if(player.statusEffectv1(StatusEffects.Naga) > 0 && flags[kFLAGS.SAMIRAH_FOLLOWER] < 8) {
		//No fight for this encounter, brings you back to the camp. Next time you see her, she will attack you unless you turn back into a naga in the meantime
		player.changeStatusValue(StatusEffects.Naga,1,0);
		outputText("You walk in the desert for what feels like an eternity, thinking of how much easier it was to move across the sand back when you had a tail, but then you're brought back to reality by a familiar hissing. The identity of your follower is no secret to you. As you open your mouth to greet your naga friend, you find yourself unable to pronounce any words. The girl comes towards you and slithers around in a confused way, trying to communicate. But the sounds that once formed words and phrases now seem to slip through you; all you can do is stand there, unable to grasp what she's trying to tell you. Realizing that you're not who you used to be anymore, she sadly looks down and turns around. The naga slithers away into the distance until she's nothing but a blink on the horizon.");
		doNext(explorer.done);
		return;
	}
    camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_NAGAS);
	startCombat(new Naga());
}

private function nagaNaga():void {
    player.removeStatusEffect(StatusEffects.MeanToNaga); //well, you're not a human anymore...
    if (flags[kFLAGS.SAMIRAH_FOLLOWER] < 5) {
        if (flags[kFLAGS.SAMIRAH_FOLLOWER] < 1) flags[kFLAGS.SAMIRAH_FOLLOWER] = 1;
        else flags[kFLAGS.SAMIRAH_FOLLOWER]++;
    }
    //Set 'last fuck as naga'
    player.changeStatusValue(StatusEffects.Naga,1,1);
    //Not met as naga before
    if(player.statusEffectv2(StatusEffects.Naga) == 0) {
        player.changeStatusValue(StatusEffects.Naga,2,1);
        outputText("You wander into the desert, noting how good the sand feels on your underbelly compared to rocks and dirt. You are wondering to yourself if maybe it wouldn't be a bad idea to come out here more often when you spot something moving a little farther ahead of you.\n\n");
        outputText("As you get closer, you see that it is the naga that inhabits this dry desert. You stop in your tracks, wondering if it isn't too late to turn and run, when she turns her head and looks straight at you. You slowly tense your hands, ready to raise your [weapon] as the naga eyes your new snake-like body hungrily. Just before you can ready yourself, the naga opens her mouth. But instead of hissing, you find that you can understand her speech. \"<i>Your new body looks so much better than it did before,</i>\" she says, \"<i>It looks far more... delectable now.</i>\"\n\n");
        camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_NAGAS);
        outputText("You wonder how it is that you can understand her now. Perhaps eating and drinking everything you find isn't the greatest idea after all, and as a result you're hallucinating? \"<i>It's been so long since I last saw another of my scaly kin,</i>\" she hisses softly, pulling you out of your introspection. \"<i>I had almost forgotten how good it is to be able to look at the sleek and powerful curves our kind possess. This place can make you forget, if you aren't too careful.</i>\" As strange as it sounds in your head, you are surprised at how she doesn't hold her s's. You aren't quite sure why you thought that would make sense.\n\n");
        outputText("You relax a little as she slithers over to you, though you're still wary of possibly being attacked despite the bright smile on her face. When she is close enough to you, she surprises you again by draping her arms around your shoulders in a friendly hug and pressing her chest firmly against you. You jump slightly at the sudden embrace, but slowly wrap your arms around her waist and pull her closer to you.\n\n");
    }
    //[If already encountered as a naga]
    else {
        outputText("You slide over the hot sand of the desert, enjoying the soft hiss that it makes as your scaled body slides over it. You see a strange yet familiar shape in the distance, and as you approach you realize that it is the naga from before. You quickly slither up behind her and wrap your arms around her. You can feel her tense up momentarily, before recognizing that it's you and turning herself to face you. \"<i>You came back!</i>\" She wraps her arms around your waist and you draw her closer to you.\n\n");
        camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_NAGAS);
    }
    outputText("She lets out a soft moan and leans her head forward, pressing her lips against yours. You squeeze her body even more firmly against yours in response, the tips of your tails wrapping around one another. You open your mouth slightly and press your tongue against her lips. She offers no resistance and you begin caressing the inside of her mouth with your tongue, circling her fangs as she uses her own tongue to gently stroke ");
    //[If player has fangs]
    if(player.faceType == Face.SNAKE_FANGS || player.faceType == Face.DRAGON_FANGS || player.faceType == Face.SALAMANDER_FANGS || player.faceType == Face.SPIDER_FANGS || player.faceType == Face.YETI_FANGS || player.faceType == Face.DEVIL_FANGS || player.faceType == Face.ORC_FANGS || player.faceType == Face.WOLF_FANGS) outputText("your own.");
    //[player has no fangs]
    else outputText("the inside of your mouth.");
    outputText("\n\n");
    //gender check
    SceneLib.samirah.nagaDefaultSexScene();
}

private function gooNagaRape():void {
	clearOutput();
	player.sexReward("vaginalFluids");
    outputText("You look over at the prone form of the " + gorgonOrNaga);
	outputText(" lying in the sand, her ");
	if(monster.HP < 0) outputText("weak ");
	else outputText("flushed ");
	outputText("form only serving to arouse you further. You slide over to her, your gooey lower half leaving a wet trail behind you. As you stand over the defeated form of the snake woman, an idea pops into your head, ");
	if(player.cor > 50) {
		//(if corrupt male)
		if(player.gender == 1) {
			outputText("your [cock] growing harder at the thought.");
		}
		//(if corrupt female)
		else if(player.gender == 2) {
			outputText("your cunt grows moist at the thought.");
		}
		else if(player.gender == 3) {
			outputText("your cock twitches and your pussy becomes moist from the thought.");
		}
		else outputText("you feel a tingle at your groin from the thought.");
	}
	//(if not corrupt)
	else {
		outputText("the thought is almost too horrible to consider, but still...");
	}
	outputText("  You slide your gooey form over her body, resting at her crotch. She tries to push you off, but you easily resist her.\n\n");
    outputText("Looking down, you see a scale covered slit at her crotch. Bringing a hand down to it, you stroke it gently and feel the " + gorgonOrNaga);
    outputText(" twitch beneath you. You slowly open the slit to reveal the moist folds of her pussy. You start to tease her by stroking her netherlips, the " + gorgonOrNaga);
    outputText(" moaning in response. You gradually slide your fingers in, moving them inside of her to see just how far her lips can spread. The " + gorgonOrNaga);
	outputText(" continues to pant and moan under your touch, her tail thrashing in the sand.\n\n");
    outputText("You decide that you've played with her enough and withdraw your hand, now wet with her juices, from her pussy. A hiss escapes the " + gorgonOrNaga);
	outputText("'s lips, and she tries to bring your hand back to her needy cunt. You pull your hand out of her grip and instead shift your gooey form over her lips and start to push some of your lower half into her. She starts to coo as you shove the first few inches in, her hips thrusting into the air. You continue to push more of your slimy form into her, sliding deeper and deeper into her as her walls convulse around you.\n\n");
    outputText("Soon you feel yourself hit a wall as your body hits the opening of the " + gorgonOrNaga);
	outputText("'s cervix. A stray thought crosses your mind as you think that maybe this is far enough, ");
	//(if corrupt)
	if(player.cor > 50) outputText("but immediately after, you decide that this is going to be too much fun to not push on.");
	//(if not corrupt)
	else outputText("but a nagging voice at the back of your head urges you to push further.");
    outputText("You grab the " + gorgonOrNaga);
    outputText("'s shoulders and thrust yourself down, HARD. The " + gorgonOrNaga);
    outputText(" screams as you push past her cervix and fill her womb with your gooey form. Her entire body writhes as you push more of yourself into her womb, her stomach starting to bulge out at the sheer amount filling her. The screams of the " + gorgonOrNaga);
    outputText(" intensify as you push more and more of yourself into her, her stomach swelling enough to look pregnant. You finally stop pushing into her, almost your entire lower half inside of the " + gorgonOrNaga);
	outputText(".\n\n");

    outputText("You pause for a moment, enjoying the sensation of filling someone up with your body, surprised at just how good it feels. Grabbing the " + gorgonOrNaga);
	outputText("'s hips you slowly push yourself in and out of her now full pussy, ");
	//(if male)
	if(player.cockTotal() > 0) {
		if(player.cockTotal() == 1) outputText("your " + cockDescript(0));
		else outputText("one of your " + multiCockDescriptLight());
        outputText(" hitting the " + gorgonOrNaga);
		outputText("'s pleasure buzzer with each downward thrust.");
	}
	//(if female)
	else if(player.gender == 2) {
        outputText("your clit rubbing against the " + gorgonOrNaga);
		outputText("'s pleasure buzzer with each downward thrust.");
	}
	//(if herm)
	else if(player.gender == 3) {
		if(player.cockTotal() == 1) outputText("your " + cockDescript(0));
		else outputText("your " + multiCockDescriptLight());
        outputText(" and clit rubbing against the " + gorgonOrNaga);
		outputText("'s pleasure buzzer with each downward thrust.");
	}
	//(if genderless)
	else {
        outputText("your bare crotch hitting the " + gorgonOrNaga);
		outputText("'s pleasure buzzer with each downward thrust.");
	}

    outputText("\n\nYou continue to relentlessly push yourself into the " + gorgonOrNaga);
	outputText(", stretching her wide.  ");
	//(if male)
	if(player.gender == 1) {
		outputText("You let out a yell as ");
		//(normal)
		if (player.cumQ() < 250) {
            outputText("you come all over the " + gorgonOrNaga);
		outputText("'s stomach.");
		}
		else if (player.cumQ() < 1000) {
            outputText("you come all over the " + gorgonOrNaga);
		outputText("'s face and stomach.");
		}
		//(if THE LEVEYS HAVE BROKE RUN FOR THE HILLS)
		else {
            outputText("you come violently, covering the " + gorgonOrNaga);
		outputText(" in a layer of your sperm.");
		}
	}
	//(if female)
	else if(player.gender == 2) {
		outputText("You shriek in delight as wave after wave of orgasms rush over you");
		//(if squirter)
		if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) {
            outputText(", your girlcum gushing out and pooling on the stomach of the " + gorgonOrNaga);
			outputText("");
		}
		outputText(".");
	}
	//(if herm)
	if(player.gender == 3) {
		outputText("You scream in ecstasy as you hit your peak, your girlcum ");
		if(player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_SLAVERING) outputText("leaking out");
		else {
            outputText("gushing out to form a pool on the " + gorgonOrNaga);
			outputText("'s stomach");
		}
		outputText(" and your " + multiCockDescriptLight());
		//(normal)
		if(player.cumQ() < 250) outputText(" spurting onto her stomach as well.");
		//(lots of jizz)
		else if(player.cumQ() < 1000) outputText(" spurting onto her stomach and face.");
		else {
            outputText(" completely covering the " + gorgonOrNaga);
			outputText(" in a layer of your spooge.");
		}
	}
	//(if genderless)
	if(player.gender == 0) {
        outputText("You cry out and shudder as you feel wave after wave of the " + gorgonOrNaga);
		outputText("'s orgasm rushing over your body, bringing you to a strange orgasmic bliss of your own.");
	}
    outputText("  For a moment you just sit there in post orgasmic bliss, the walls of the " + gorgonOrNaga);
    outputText(" convulsing around your gooey half. You decide that the snake woman has had enough and slowly withdraw yourself from her abused love canal. You gather up your things and head back to your camp, leaving the " + gorgonOrNaga);
	outputText(" lying in the sands.");
	cleanupAfterCombat();
}

private function victoryMale_taur():void {
	clearOutput();
    player.removeStatusEffect(StatusEffects.MeanToNaga); //oh, you're nice again!
    outputText("As your massive bulk looms over the defeated " + gorgonOrNaga);
    outputText(", your eyes gleam with desire. Your heart pounds in your ears as lusty thoughts echo in your head. You lift the snakewoman up into your arms, bringing her close before licking her neck and tasting her smooth scaly skin as her tail dangles down to the sand. As you touch her, she recovers, and her tail slowly wraps around your lower half to support her own weight. She returns your attentions by running her long forked tongue down your chest. Her scaly tail rubs sensually over your flesh as she continues to wind around you, caressing your [cock] with her tip, making you hard in a flash. The " + gorgonOrNaga);
    outputText(" wriggles free from your embrace and coils behind you. Her entire length is now wrapped around various portions of both your humanoid and animalistic halves, and she uses her grip to dangle underneath you. Her hands reach out to take a firm hold of your [cock]. You shiver as her tongue darts out andslides around your cock, pre-cum dripping from your head as she licks you. The agile " + gorgonOrNaga);
    outputText(" lowers more of herself beneath you, spreading her pussy wide open before sliding onto your [cock]and letting out a hissy moan as you penetrate her. Your body tingles as her entire length quivers in pleasure, sending ripples over the flesh her tail is wrapped around. Jolts of pleasure run through you as the " + gorgonOrNaga);
    outputText(" woman grinds her hips against your [cock] , driving it into her as far as she can take. With a loud and drawn-out moan, ");
    //[normal cum load]
    if(player.cumQ() < 250) outputText("you cum inside of her, ");
    //[extra cum]
    else if(player.cumQ() < 1000) outputText("you fill her insides with huge spurts of cum, ");
    //[SUPER CUM]
    else outputText("you explode with huge fountains of cum spurting from your [cock], gushing out from where the two of you are joined to rain on the sands below, ");
    outputText("as she squeezes you tightly in a climax of her own that steals your breath away.\n\n");
    outputText("Exhausted from her gymnastics, the " + gorgonOrNaga);
    outputText(" slowly unwinds from you and lies on the sand, cum dripping from her pussy onto the dry desert");
    outputText(" beneath her.\n\n");
    outputText("You think it would be a very good idea to come to the desert");
	outputText(" more often.");
	player.sexReward("vaginalFluids","Dick");
	cleanupAfterCombat();
}

//Low-corruption
private function victoryMale():void {
	clearOutput();
    player.removeStatusEffect(StatusEffects.MeanToNaga); //oh, you're nice again!
    sceneHunter.callFitNofit(scene, monster.vaginalCapacity());
    //==================================================================================================
    function scene(x:int):void {
        outputText("You almost feel pity as you behold the defeated creature lying before you, but your growing arousal pushes the thought from your mind. Leaning forward to get a closer look, your thoughts wander, and you find yourself wondering what her flexible body could do. Unable to contain your lust, you remove your [armor] and slowly lay on top of her, moving your hands across her scaly form in search of her pussy. As you rub your hands across the underside of her scaly belly, you notice that she is beginning to blush and moan softly. She is visibly trying to hold the feelings back, but whatever it is you're doing to her is definitely making that difficult. For the moment, you decide to abandon the search, content with simply running your hands along her tail's soft underside and watching her face as she tries in vain to hold her passion back. As you run your fingers up the center of her tail's underside, you notice a strange bump just a few inches below where her skin and scales meet. On further inspection, you realize that this is the thing you have been searching for - her warm, wet lovehole. Your touches seem to have had an effect on her; she is already rather moist, ready to take your " + player.cockDescript(x) + ". You gingerly slide one of your fingers inside her, feeling for depth as well as for wetness. The " + gorgonOrNaga);
        outputText(" coos softly, unable to withhold her moans.\n\n");
        outputText("You slowly begin moving your fingers in and out of her wet snatch, petting her underbelly with your free hand. You can tell that she is still tense; the look on her face is a mix of passion and fear. She struggles weakly, terrified as you place your warm " + player.cockDescript(x) + " against her belly. You feel her grow still as your length rubs against her. You look deeply into her amber eyes as you wrap your arms around her, and after a moment's hesitation, kiss her passionately. Surprised at your own decision, your mind quickly conjures an image of her biting you. Instead, she relaxes in your arms and returns the kiss, abandoning herself to your will.\n\n");
        //[if cock fits]
        if (player.cockArea(x) <= monster.vaginalCapacity()) {
            outputText("Chills run down your spine as her delicate forked tongue tangles with your own, and you gently press the tip of your " + player.cockDescript(x) + " against her moist pussy-lips. Her tail slowly wraps around your legs as she moans in a soft and mildly hissing voice. You sink your engorged member into her depths, pausing for a moment to let her adapt to your presence, before pumping away and kissing her passionately as you both get caught up in the wonderful sensations of your entwined bodies. Her tight passage massages your length, and her scaly body rubbing on your skin only encourages you to go further while you rock back and forth in her embrace. You gradually increase your pace, hearing her moans become louder as she moves her hips in time with yours. Your fingers dig into her smooth backside as you continue thrusting into her, pleasure building for what seems like a wonderful eternity. You finally reach your limit, thrusting frantically until you climax, ");
            //[normal cum load]
            if(player.cumQ() < 250) outputText("shooting thick ropes of sperm deep inside her as both of you wail with excitement.");
            //[lots of cum]
            else if(player.cumQ() < 500) outputText("pumping large amounts of cum deep inside her as both your voices rise in screams of pleasure.");
            //[Spermageddon]
            else outputText("your " + player.cockDescript(x) + " erupting, blasting a violent torrent of semen deep inside her petite frame, filling her up completely as both your voices rise in screams of pleasure.");
        }
        //[If cock too large]
        else {
            outputText("You draw away from her lips and return to your upright posture. Relaxed as she is, the " + gorgonOrNaga);
            outputText(" looks nervously at your " + player.cockDescript(x) + ", fully aware that it won't fit inside her small body. This occurs to you as well, and you begin to formulate a different plan. You move up onto her body so that you're straddling her stomach, fitting your " + player.cockDescript(x) + " neatly between her ");
            outputText((isGorgon)?"modest D":"small C");
            outputText("-cup breasts. You gently coax her hands to her breasts, and she begins to comprehend your intentions. She begins to squeeze your " + player.cockDescript(x) + " between her two warm mounds of flesh, doing her best to keep it snugly between them. Of her own accord, the " + gorgonOrNaga);
            outputText(" begins to run her tongue across the " + player.cockHead(x) + ", obviously understanding what you want. She looks up at you with an unsure look, as if asking whether or not she is doing it right. You nod to her, and that's all the encouragement she needs. She begins to stroke your " + player.cockDescript(x) + " with her breasts as if it came naturally to her, covering as much of your " + player.cockHead(x) + " as she can with her warm and trembling mouth.\n\n");
            outputText("You lean back and sigh with pleasure as the " + gorgonOrNaga);
            outputText("'s movements become bolder and bolder, fitting just a little bit more in her mouth here, or squeezing her breasts tighter there. It's not long before you are panting and slightly thrusting your hips in time to her strokes. As she quickens her pace, you cannot hold yourself back any longer. You begin to cum without much warning, ");
            //[normal cum load]
            if(player.cumQ() < 250) outputText("filling her mouth with your warm seed.");
            //[lots of cum]
            else if(player.cumQ() < 500) outputText("pumping her mouth full of your sticky seed, some of which she is forced to swallow to avoid choking.");
            //[Oh God, it just keeps coming out, help me!]
            else outputText("easily flooding her mouth with your seed. Your seed gushes from her nose, with still more rushing down her throat. She gags and chokes a bit, a large amount of your seed leaking out onto her chest.");
            outputText("  The " + gorgonOrNaga);
            outputText(" removes your " + player.cockDescript(x) + " from her mouth");
            //[lots of cum OR more]
            if(player.cumQ() > 500) outputText(", the last sticky blasts of your semen splashing across her face,");
            outputText(" and looks to you for instruction. You simply nod, and she understands, ");
            //[normal cum load]
            if(player.cumQ() < 250) outputText(" gulping down the warm sperm in her mouth.");
            //[lots of cum OR more]
            else outputText(" doing the best she can to swallow her mouthful of cum.");
        }
        outputText("\n\nYou slowly untangle yourself from the panting " + gorgonOrNaga);
        outputText(" and leave her lying in the sand, basking in the warmth of sex and sun. You return to your camp, completely satisfied with your work.\n\n");
        outputText("You think it would be a very good idea to come to the desert");
        outputText(" more often.");
        player.sexReward("vaginalFluids","Dick");
        cleanupAfterCombat();
    }
}

//3) Victory male
private function victoryMale_rough():void {
	//Male or 50% herms
    clearOutput();
    fatigue(20);
    outputText("Your mind fills with obscene and corrupted fantasies as you behold the defeated creature lying before you.  Leaning forward to get a closer look, your thoughts wander, and you find yourself wondering what you could do to her extremely flexible body. Unable to contain your undying lust, you remove your [armor] and lay on top of her, rapidly moving your hands across her scaly form in a hunt for her pussy. The snakewoman struggles weakly beneath you, but you easily pin her to the ground. Her tail thrashes in the sand as you locate the mound of scales covering her nether-lips. You open it roughly and shove yourfingers in, smiling at her cries of denial. To put an end to her complaints, you suddenly move forward and drive your [cock] inside her all at once, not caring whether it fits or not. The lack of lubrication couldn't bother you less. You can practically taste the incredible sensations of her love-canal as it begins to moisten. Hungering for more, you start to pound the snake woman mercilessly. Shoving your entire length in and out of her abused cunt causes her to whimper and moan in a mixture of pain and pleasure. She responds to your brutality in kind, biting at your shoulder. It takes a few seconds before your arm grows numb, and you realize too late that this little bitch is injecting you with her venom! You pry her off before she can finish, her fangs still dripping with lethal fluid. This fat little worm has gone way too far.\n\n");
 	//[player has more than 1 dick]
    if(player.cockTotal() > 1) {
        outputText("You pause just long enough to force your " + cockDescript(1) + "inside, stretching her pussy wide and ramming into her cervix. You receive an immediate reaction as she screams in pain, as if pleading for you to stop. The desperate thrashing and squirming beneath you only serves to drive you onward. Your shoulder starts to burn as the venom seeps into your blood; you need to wrap this up soon, or else you might pass out before you've finished.");
 	}
    //[player has 1 dick]
    else {
        outputText("You shove as much of yourself inside her as you can, ramming into her cervix and eliciting desperate, hissing screams that seem to plead for you to stop. You press on, pushing harder as the entrance to her womb slowly loosens from your abuse. Your shoulder starts to burn as the venom spreads into your blood; you need to wrap this up soon, or you might pass out before you've finished.");
    }
    outputText("\n\nYou try to maintain focus as her tight vagina continually presses around you, bringing you ever closer to orgasm. But your strength is deteriorating, and your erection begins to soften. No! You can't let that happen! In a magnificent feat of sexual rage, you force yourself to keep accelerating despite your fading consciousness. Just before passing out, you manage to finally cum in an ultimate thrust.");
    //[lots of jizz OR more]
    if (player.cumQ() > 250) {
        outputText("  Your spooge explodes from the " + gorgonOrNaga);
        outputText("'s abused cunt, flooding the desert");
        outputText(" sands as you black out.\n\n");
    }
    else outputText("\n\n");
    outputText("When you awaken, the " + gorgonOrNaga);
    outputText(" is long gone. All that remains of your encounter is a depression in the landscape");
    //[lots of jizz]
    if(player.cumQ() > 250) outputText(" with traces of semen in it");
    //[if OMGWTFBBQGALLONSOFCUM]
    else if(player.cumQ() > 2000) outputText(" that's filled with your thick seed");
    outputText(".\n\n");
    outputText("As you retrieve your clothes, you notice red marks around your chest and arms. It seems that while the " + gorgonOrNaga);
    outputText(" did have the opportunity to kill you while you were unconscious, she preferred to keep you alive.\n\n");
    //common
    outputText("You think it would be a very good idea to come to the desert");
	outputText(" more often, but you're confident that <i>she</i> will remember this. You'd better not lose to her next time...");
    if(!player.hasStatusEffect(StatusEffects.MeanToNaga)) player.createStatusEffect(StatusEffects.MeanToNaga,0,0,0,0);
	player.sexReward("vaginalFluids","Dick");
	cleanupAfterCombat();
}


private function victoryFemale_taur():void {
	clearOutput();
    player.removeStatusEffect(StatusEffects.MeanToNaga); //oh, you're nice again!
    //For inspiration in this noble venture:
    //http://imagemacros.files.wordpress.com/2009/10/im_a_horse.jpg?w=402&h=604
 			//(Loss by HPs)
    //NO RAEP IF LOSS BY HPs, FUCK CENTAURS! SRSLY! GROW NORMAL LEGS!
			//(Loss by Lust)
    if(monster.lust >= monster.maxOverLust()) {
        outputText("As your prey falls to the ground, her body too filled with sexual desire to fight, you step over her, your tall frame towering over her own quivering body. She instantly grabs your shoulders, lust burning in her eyes. You wrap your arms around her, drawing her back against your chest and lifting her off the ground. She is facing away from you, but you can tell by the way she's responding that she is ready for whatever you're going to do to her. You begin by shifting one of your arms to hold her around her stomach, while your other hand begins working on her small but tender breasts. You begin to nibble at her ear, occasionally kissing her neck. The " + gorgonOrNaga);
        outputText(" responds by wrapping her tail around your lower body, gently rubbing her sensitive underbelly against your [skin].");
        //(If PC is Herm i.e. Has a cock(s))
        if(player.gender == 3) outputText("  As her tail gently squeezes your body, it draws your own [cocks] up against your body, her soft underbelly stimulating the sensitive skin.");
        outputText("  With the added support, you are able to move your arm away from her stomach, moving your hand down to her covered snatch. It isn't hard to find as there is practically a river of her juices dripping from it. You peel away the scaly covering, and reveal her soaking wet lovehole. As you begin to play with her engorged clit, her soft moans begin to become more pronounced, and you can feel her tail begin to wrap more tightly around your body. You feel a strange sensation as her tail brushes past your own " + vaginaDescript(0) + ", causing you to tense up a bit. It seems that she noticed, because she does it again a few seconds later. As she begins to rub your " + vaginaDescript(0) + " with her tail, your body begins to betray your own lusts.\n\n");
        outputText("She begins to gently toy with your " + clitDescript() + " using the very end of her tail, flicking it back and forth. You can't help but start moaning softly yourself. You respond by slowly teasing two of your fingers inside her waiting pussy, slowly beginning to move them in and out. As you begin to accelerate the motion of your fingers, the " + gorgonOrNaga);
        outputText(" steps it up as well, sliding the tip of her tail inside your " + vaginaDescript(0) + ".  ");
        player.cuntChange(20,true,false,true);
        outputText("You and the " + gorgonOrNaga);
        outputText(" remain entwined like this for what seems like hours; your fingers buried inside her pussy, her tail buried inside yours");
        //(If PC is Herm i.e. Has a cock(s)){
        if(player.gender == 3) outputText(" and your [cocks] constantly stimulated by the tail wrapped around your body");
        outputText(". As you accelerate your finger-thrusts, you can feel her approaching climax, and she begins to accelerate her own motions in response. It only takes a few more minutes before you feel she's ready to cum. Suddenly she throws herself free from your grasp, turning her body one hundred and eighty degrees, and plants a kiss firmly on your lips. As she begins to passionately make out with you, your tongues intertwining, and your lips interlocking in a heated show of lust for each other. She begins to climax, her muscles tensing, and her tail beginning to writhe inside your " + vaginaDescript(0) + ". Soon, both of you are experiencing wonderful, simultaneous orgasms, each driving the other onwards. Finally, after several minutes of bliss, the two of you finally separate, the sexually exhausted " + gorgonOrNaga);
        outputText(" slumping to the sandy earth, her desires fulfilled. She looks up at you meekly, her eyes showing a sort of gratitude that words might never be able to describe. She turns her back, and slithers slowly away, a trail of her love juices tracing her path through the sand.\n\n");
    }
    else {
        outputText("No matter how hard you try, you can't think of a way to make this work.  You give up for now, disatisfied.\n\n");
        sceneHunter.print("Try to win by lust, you brute :)");
    }
    //
    outputText("You think it would be a very good idea to come to the desert");
	outputText(" more often.");
	player.sexReward("Default","Default",true,false);
	cleanupAfterCombat();
}
private function victoryFemale():void {
	clearOutput();
    //
    player.removeStatusEffect(StatusEffects.MeanToNaga); //oh, you're nice again!
    outputText("The lust within you builds as you view the " + gorgonOrNaga);
    outputText(" lying slumped on the ground in front of you, her coils twitching and tailtip marking the sand. Stepping forward, yougather her human half into your arms, and she moans weakly as your breasts rub against hers. Smiling, you languidly lick her neck, her skin smooth and dry beneath your tongue. Reaching down, you grab the end of her tail and bring it to your dripping pussy, rubbing it back and forth across your entrance. Reviving under your caresses, the beautiful snake-lady rises, slowly circling you, windingherself around you again and again as you continue to use her tailtip to stimulate yourself. She comes to a stop, her coils now looselyaroundhalf your body, as she once again faces you, her tail twitchinghungrily in your grasp. You lean forward to kiss her, caught up in the moment, not caring of her fangs, as her tail twitches out of your grasp and suddenly spears upwards; you gasp and moan inpleasure as it dives into your moist pussy.  ");
    player.cuntChange(20,true,false,true);
    outputText("Once again grinding your body against hers, your stiff nipples rub against one another, eliciting more moans from both of you. Her coils tighten slowly, squeezing your body in a tight hug as her tail thrashes wildly inside you, driving you closer and closer to your limit. With a scream of ecstasy, you climax, your juices spurting out and coating her tail, your arms squeeze her tightly as you continue to cum. The " + gorgonOrNaga);
    outputText(" slowly unwinds herself, smiling somewhat shyly at you as you stand there, panting, before slithering off into the sands, your moisture on her scales quickly drying in the arid desert");
    outputText(" heat.\n\n");
    //
    outputText("You think it would be a very good idea to come to the desert");
	outputText(" more often.");
	player.sexReward("Default","Default",true,false);
	cleanupAfterCombat();
}
private function victoryFemale_rough():void {
	clearOutput();
    //
    outputText("As you watch the writhing form of the defeated " + gorgonOrNaga);
    outputText(", you cannot help but feel turned on by it. You step forward, grabbing the " + gorgonOrNaga);
    outputText(" by the shoulders and forcing her down against the sand, face up. Then, pinning her arms under your knees, you straddle her chest, crushing her modest breasts against her constricted ribcage. You can already see the panic in her face as you " + (player.armorDescript() != "gear" ? "begin to unfasten the lower part of your " + player.armorDescript() : "present your naked body to the snake-woman.") + ". Once your dripping-wet pussy is exposed to the dry desert");
    outputText(" air, you pull up the " + gorgonOrNaga);
    outputText("'s head by her hair and pull it close to your hot snatch. \"<i>C'mon, you horny little snake-tailed slut, what are you waiting for?</i>\" The " + gorgonOrNaga);
    outputText(" remains frozen in a panic, not sure what to do. As encouragement you tug at her hair, pulling her head even closer to your " + vaginaDescript(0) + ". \"<i>I said LICK IT!</i>\" you shout, rubbing your " + vaginaDescript(0) + " into her face. Finally, the " + gorgonOrNaga);
    outputText(" gets the message and her thin tongue darts from her mouth, making contact with your hot flesh. You shudder with excitement as the slick surface brushes past your " + clitDescript() + " and along your slit. As one hand manages the " + gorgonOrNaga);
    outputText("'s head, you move your other hand to your breasts, beginning to squeeze and massage them with reckless abandon. As the " + gorgonOrNaga);
    outputText(" continues to lick at your " + vaginaDescript(0) + ", you begin to gently buck your hips, bouncing up and down on her chest and forcing the air from her lungs. She squeaks every time this happens, in obvious discomfort.\n\n");
    outputText("Her face is beginning to turn red, and her breath is shortening by the second. Yet, you find all this very arousing. Instead of letting up, you force yourself onto her even more, pushing your " + vaginaDescript(0) + " up and grinding it against her face. You continue to moan and play with your breasts in the meantime, your climax drawing closer with every tongue stroke. The " + gorgonOrNaga);
    outputText("'s tongue eventually finds its way inside your " + vaginaDescript(0) + ", its forked tip tickling your soft walls as it advances forwards. All the while the " + gorgonOrNaga);
    outputText("" + gorgonOrNaga);
    outputText(" is desperately sucking at your " + clitDescript() + ", in an attempt to satisfy you, and possibly save herself. Your eyes roll back in your head, and you throw your head back as an orgasm finally takes your body. You yell with delight as the " + gorgonOrNaga);
    outputText("'s tongue tickles your insides, your girlcum splashing all over her face and dripping down into the dry sand below. As your climax slowly fades, you finally get up off the " + gorgonOrNaga);
    outputText(", which is met by a large gasp of relief. However, you are not done yet. You weren't going to suffocate your new fucktoy, now were you? After recovering from your first of hopefully many orgasms, you move back overtop the girl, this time straddling her face and facing the opposite direction. Your dripping snatch covers her face, situated directly above her mouth. The " + gorgonOrNaga);
    outputText("'s arms are still pinned down by your legs at this point, and her tail is simply too weak after the fight to be of much help.\n\n");
    outputText("As you kneel over her face, you realize that if you bend forward enough, the " + gorgonOrNaga);
    outputText("'s pussy is available to play with. After you manage to get the " + gorgonOrNaga);
    outputText(" girl to begin licking and poking at your " + vaginaDescript(0) + ", you turn your focus to her semi-protected pussy. You peel away the thick covering, revealing her hot, moist fuckhole, and a thousand evil things jump to mind. Forming your hand into a spear shape, you begin to tease her tight slit. You can hear her as her muffled moans are drowned in your " + vaginaDescript(0) + ", and it brings a smile to your face. \"<i>Yeah, you like that, don't you? You scaly little...</i>\" You begin to push your hand into her rather unprepared lovehole, to which she responds by flailing her tail about, trying in vain to shake you off. You keep pushing, until your arm is buried elbow-deep inside her. As you begin to fist-fuck her pussy, you can hear her wail into your " + vaginaDescript(0) + ", obviously complaining about the rough treatment. You continue like this for several minutes, with the " + gorgonOrNaga);
    outputText("'s pussy becoming ever wetter and her moans becoming ever more earnest.\n\n");
    outputText("You stop after what you think is her third climax, pulling your arm almost all of the way out. You lean forward, lifting your " + vaginaDescript(0) + " from her face a little. You push even deeper, and are able to reach all the way to her cervix, your closed fist coming to rest against it. You slowly begin to move your fist in and out, getting faster as time progresses. After about a minute or two of this progressive increase, you're fist-fucking her so fast that you're practically punching her cervix, causing her to squeal and try to get away. As her mouth bashes against your " + clitDescript() + ", her forked tongue caressing you from inside your " + vaginaDescript(0) + ", you find yourself nearing your climax. You right yourself, putting one arm to the sand for balance, and moving the other to beginmassaging your breasts.\n\n");
    outputText("It doesn't take much; soon your hips are bucking, bashing into the " + gorgonOrNaga);
    outputText("'s face, your " + vaginaDescript(0) + " coating her face with your love juice. Your mission accomplished, you decide to wrap things up. As soon as you recover, you grab the poor " + gorgonOrNaga);
    outputText("'s tail, and begin shoving it roughly into the " + gorgonOrNaga);
    outputText("'s pussy. She wails in protest with each violent thrust, but at this point she is too weak to resist. You push inch after inch inside her, until you meet a sort of wall, what you can only assume is her cervix.");
    //(If str > 50)
    if(player.str > 50) {
        outputText("  You begin to push harder, trying to force your way through into her womb.  With a sudden surge forwards which prompts another loud wail from the " + gorgonOrNaga);
        outputText(", you finally enter her womb. However, you do not stop. You begin to push even more of her tail inside her, forcing so much in that it begins to cause her stomach to distend. Finally, after several feet of tail have disappeared inside her, you ease off. The " + gorgonOrNaga);
        outputText(" is lying in the sand, bawling her eyes out at the immense discomfort of such an act.");
        //(If high corr)
        if(player.cor > 80) outputText("  As a parting gift, you kick sand in her face, and walk away without a care in the world.");
        //(If low corr )
        else outputText("  You think to yourself, \"<i>Was all that really necessary?</i>\"  But, in the end you decide that yes, it was.");
    }
    else sceneHunter.print("Failed str check");
    outputText("\n\nYou return to camp, satisfied with your actions.\n\n");
    //
    outputText("You think it would be a very good idea to come to the desert");
	outputText(" more often, but you're confident that <i>she</i> will remember this. You'd better not lose to her next time...");
    if(!player.hasStatusEffect(StatusEffects.MeanToNaga)) player.createStatusEffect(StatusEffects.MeanToNaga,0,0,0,0);
	player.sexReward("Default","Default",true,false);
	cleanupAfterCombat();
}

//adapted for normies
private function victoryGless_taur():void {
	clearOutput();
    player.removeStatusEffect(StatusEffects.MeanToNaga); //oh, you're nice again!
    //
    if (player.gender == 0)
        outputText("You prance over to the prone form of the snake woman, plotting just what you will do to her body before realizing the severe lack of parts to use on her. You let loose a snort of frustration and paw at the ground. This complicates things, but you aren't going to let a little thing like having no genitalia stop you from having some fun.\n\n");
    outputText("You position yourself over the uppermost part of her tail and lower yourself down onto her, the lower half of your body resting on her tail. You reach down to the scaly covering over her pussy and open it to reveal the soft folds inside. Gently you slide your tongue into her, making small circles every so often.\n\n");
    outputText("A hiss of pleasure escapes from the " + gorgonOrNaga);
    outputText("'s mouth as she brings her hands onto your head and grips you tightly. The lower portion of her tail wraps gently around you, and she brings the tip of her tail up to your mouth. You shift your attention from her netherlips to start sucking on the tip of it, twirling your tongue around it sensually. After a moment, the " + gorgonOrNaga);
    outputText(" takes her tongue out of your mouth and slides the now lubricated tail gently into your backside. You let out a slight gasp, but it is cut short as the " + gorgonOrNaga);
    outputText(" brings your head back down to her pussy. You start licking again as the " + gorgonOrNaga);
    outputText(" slides more of her tail into you, twitching the tip of it deep inside of you.\n\n");
    outputText("You speed up your licking and thrust your tongue deeper into her, her walls now slick. She presses your face deep into her pussy as her hips buck in orgasm.\n\n");
    outputText("The tail of the " + gorgonOrNaga);
    outputText(" slides out of you as she lies back in the sand of the desert");
    outputText(", exhausted from her orgasm. You stand up and gather your things, thinking that maybe it wouldn't be too bad of an idea to come back.\n\n");
    //
	player.sexReward("Default","Default",true,false);
	cleanupAfterCombat();
}

//adapted to females?
private function victoryGless():void {
	clearOutput();
    player.removeStatusEffect(StatusEffects.MeanToNaga); //oh, you're nice again!
    //
    outputText("You look down at the collapsed " + gorgonOrNaga);
    outputText(", feeling the blood pounding hotly through your veins.");
    if (player.gender == 0)
        outputText(" You stand above her fallen form and start to take off your pants when you remember that you have nothing down there. A soft curse escapes your lips; this will make things much more difficult, but there WILL be sex one way or another.");
    outputText("\n\nYou straddle the " + gorgonOrNaga);
    outputText(", placing your " + (player.gender == 0 ? "bare, featureless crotch" : "pussy") + " against the slit of her vagina. Slowly you rock your hips back and forth against her, drawing out a gasp of pleasure from her. Leaning over her you start to massage her breasts.\n\n");
    outputText("The " + gorgonOrNaga);
    outputText("'s pussy starts to grow slick with her juices as you speed up your rocking. Her tail starts to curl around you, slowly inserting it into your ass as you continue to rock against her. You speed up your grinding, going faster and faster until a scream of pleasure erupts from the " + gorgonOrNaga);
    outputText(" as she bucks her hips in orgasm.\n\n");
    if (player.hasVagina())
        outputText("Soon, you too reach the point of no return, screaming loudly and squeezing her tail, trying to shove it even deeper into your hole" + (player.hasCock() ? " and splattering her tits and face with your seed." : "."));
    outputText("You stand up over her, your crotch now wet from " + (player.gender == 0 ? "her" : "your mixed") + " girl cum. You pick up your things and put your clothes back on, leaving the " + gorgonOrNaga);
    outputText(" lying there in bliss.\n\n");
    //
    outputText("You think it would be a very good idea to come to the desert");
	outputText(" more often.");
	player.sexReward("Default","Default",true,false);
	cleanupAfterCombat();
}

//adapted for normies
private function victoryGless_rough():void {
	clearOutput();
    //
    if(!player.hasStatusEffect(StatusEffects.MeanToNaga)) player.createStatusEffect(StatusEffects.MeanToNaga,0,0,0,0);
    if (player.gender == 0) {
        outputText("An evil grin crosses your face as you stand over the fallen snake woman, the thrum of your heartbeat pounding against your ears. A myriad of the terrible things you are about to do to her cross your mind as you start to take off your pants, when you remember that you have nothing to do those things with. Your cries of damnation are loud enough to be heard from miles away.\n\n");
        outputText("But you can't give up now. You've gotten this far, now you need to finish the deed. At the end of this, there WILL be sex.\n\n");
    }
    outputText("You thrust yourself on top of her and roughly open the scaly covering at her crotch, revealing her awaiting pussy. You bring your mouth over her opening and thrust your tongue deep inside. A mix between a whimper and a moan escapes the " + gorgonOrNaga);
    outputText("'s lips as you twist your tongue deeper inside her, as though trying to taste every part of her.\n\n");
    sceneHunter.print("Snake fangs check");
if(player.faceType != Face.SNAKE_FANGS) {
        outputText("You feel her start to thrust her hips into your face to try to gain more pleasure, but you won't be having ANY of that. You quickly take your tongue out of her and move your way up to her breasts, groping at them and biting at her nipples. The " + gorgonOrNaga);
        outputText(" cries out in pain and tries to push your head away. You give her one last bite, hard enough to draw blood from her before getting up.\n\n");
        outputText("The " + gorgonOrNaga);
        outputText(" quickly slithers out from under you with an angry hiss, a hand pressed to her now bleeding breast. You chuckle at this and the " + gorgonOrNaga);
        outputText(" turns to glare at you. There is a sudden pain on the back of your legs, and your view shifts to looking at the sky above you. It takes a moment for you to realize that the scaly bitch has just tripped you with her tail before slithering away.\n\n");
    }
    else {
        outputText("You reach up, pulling her head down to the ground by her hair. You then flip her body over, and straddle her, leaning in far enough to wrap your mouth around her neck. You hold her head steady as you slowly punch four neat holes in her neck with your fangs. She struggles; even with her innate poison resistance, there's no way she could take such a dose without feeling its effects. Her struggles become weaker and weaker, as well as her voice. This gives you a beautiful opportunity to try something new. You flip your body around, so your head is hanging above her hot snatch, and your feet pin her arms down. You spread her tight pussy lips with one hand and, forming a spear shape with your other hand, attempt to force all your fingers inside her at once. She tries to resist but, subdued by your venom, she is helpless as your hand and then your entire arm, disappears inside her. Tears begin to form in her eyes as she realizes you have complete control over her and that she is helpless to stop you. You fist-fuck her for several minutes before you begin to feel weak contractions squeeze your arm. Having brought her to a humiliating orgasm, you see little purpose in staying, leaving the helpless, sobbing " + gorgonOrNaga);
        outputText(" on the sand, your fist soaked in " + gorgonOrNaga);
        outputText(" love-juice. You return to camp, your sick fist-rape fantasy fulfilled.\n\n");
    }
    //
    outputText("You think it would be a very good idea to come to the desert");
	outputText(" more often, but you're confident that <i>she</i> will remember this. You'd better not lose to her next time...");
    if(!player.hasStatusEffect(StatusEffects.MeanToNaga)) player.createStatusEffect(StatusEffects.MeanToNaga,0,0,0,0);
	player.sexReward("Default","Default",true,false);
	cleanupAfterCombat();
}

//internal function nagaFUCKSJOOOOOO():void {
public function nagaFUCKSJOOOOOO():void {
	clearOutput();
	//BIMBO!  LIKE, TOTALLY AWESOME AND CUM!
	//[Naga-on-Female Bimbo Loss Scene]
    sceneHunter.print("Bimbo/Futa scene available.");
	if((player.hasPerk(PerkLib.BimboBrains) || player.hasPerk(PerkLib.FutaFaculties)) && player.hasVagina()) {
        sceneHunter.print("No, you won't get regular scenes anymore. Go debimbo yourself.");
		nagaRapesBimbo();
    }
    else {
        sceneHunter.print("Bimbo/Futa scene available.");
        if (player.gender == 1 || (player.gender == 3 && rand(2) == 0))
            nagaRapesMale();
        else if(player.hasVagina() && (!sceneHunter.uniHerms || rand(2) == 0))
            nagaRapesFemale();
        else
            nagaRapesGless();
    }
	cleanupAfterCombat();
    //SUB-FUNCTIONS
    //==================================================================================================
    function nagaRapesBimbo():void {
        outputText("You fall to your knees, like usual, your sexy form shaking with desire.\n\n");
        outputText("The " + gorgonOrNaga);
        outputText(" slowly approaches you with a smile of delight, devouring you with her eyes like the easy little thing you are. When she is close enough, she slides her tail under you and brings you closer to her. As she hisses in your ear, a chill goes down your spine: You don't understand a word she is saying. That seems to happen a lot with your tiny brain, but at least you can tell by the tones that she won't be going easy on you. Your nipples harden at the thought, and your " + vaginaDescript(0) + " agrees. Now astride the base of her tail and facing towards her, your eyes are directed to her crotch where a scaly covering rests where you would guess -- if you had the brains -- that a vagina should be. The " + gorgonOrNaga);
        outputText(" brings a hand down and gently starts caressing this nether region. You know exactly what she is doing, and you, like, totally feel the need for sex with her burn inside you. You quickly strip yourself of your [armor] and throw yourself brainlessly onto her awaiting pussy. Without any complaints whatsoever, you pull her lips apart and start licking, looking up at her wide-eyed and 'O'-lipped between licks.\n\n");
        outputText("Slowly you move your tongue around her folds, hearing her soft moans of arousal. Bringing your perky lips to the bottom of her slit, you gently kiss at it, carefully working your way up to the top. You pause a moment once at the top to plant a porn-star-like kiss on her clit and feel her twitch slightly before you make your way back down to her glistening cunt and lick at the moisture, savoring its taste as if it were your only food.\n\n");
        outputText("You continue your assault on her love canal as the " + gorgonOrNaga);
        outputText("'s moans gradually become louder. Her hands make their way to your head, and she curls her fingers through your " + hairDescript() + " to get a better grip on your air-filled head as you bring your mouth up to her clit. You give one final, slow lick up the length of her pussy and twirl your tongue around her now engorged bud. The " + gorgonOrNaga);
        outputText(" involuntarily bucks her hips into your face as you start to suck on her " + clitDescript() + ". As you continue to play with her clit, she begins to lose control, grinding her soaking pussy against your face. She forces herself onto you so hard, it becomes hard to breathe, but thankfully you've had a bit of practice with this sort of thing, so the warm juices of her excited love-slit don't bother you. After a while, you attempt to pull away from her hot snatch, pulling your mouth from her swollen clit. She pushes you back down upon it. You roll your eyes and giggle lightly, sending vibrations through her clit that make her moan. The feeling of your warm, wet, bimbo lips as they rub against her clit is apparently just enough for her as it pushes her past her limit, sending her into a passionate orgasm. You finally pull away from her as her body is wracked with powerful contractions, wiping the excess ladycum from your face, which is stuck in a dumb-looking, open mouthed stare.\n\n");
        outputText("After the " + gorgonOrNaga);
        outputText(" manages to calm herself, her breathing becoming regular and her muscles loosening up, she smiles a genuine grin and hisses something to you. She leans in close, her head only inches from your and suddenly shifts her tone, adopting a much more seductive one. She pulls you into an upright position, facing her, your [allbreasts] pushed up by her snake-like coils. Your " + vaginaDescript(0) + " rubs against her tail's scaly skin as she moves her own body closer to yours. She wraps the end of her tail around so that it stands erect between the two of you. The " + gorgonOrNaga);
        outputText(" hisses something at you, and, seeing the brain-dead look on your face, begins to demonstrate what she means. She leans in close to her tail and begins to run her thin tongue along its length, as far as she can. Now THIS you are able to, like, understand! You run your tongue along her smooth, scaly, tail-tip.\n\n");
        outputText("You do your, like, very best to follow her lead, but you just, like, don't get why she's doing it! Eventually, she stops, and nudges you to do so as well. Like... whatever...\n\n");
        outputText("The " + gorgonOrNaga);
        outputText(" then lies flat on the sandy ground, pulling you down with her. She lays you down on her body, face up, with your head resting on her soft breasts. She reaches around your body, placing her soft hands on your own [allbreasts], gently holding you in place as her tail moves closer to your " + vaginaDescript(0) + ". Her now slick tail begins to rub against your clit and as the scaly skin runs along your " + clitDescript() + ", you begin to moan air-headedly. There is no holding it back, this feeling is one of the best you have experienced. Her tail continues to flick and rub your clit as you begin to buck your hips gently. The " + gorgonOrNaga);
        outputText(" pokes and rubs at your hard clit for some time, eventually driving you to the first of many coming orgasms. After your breath has become even again, and your muscles have relaxed, the " + gorgonOrNaga);
        outputText(" resumes her advances. She begins to rub the tip of her tail up and down along your " + vaginaDescript(0) + ", and you FINALLY get what she is trying to do.\n\n");
        outputText("As the tail begins to penetrate you, you cannot help but let out another passionate, bimbo-like moan.");
        //Take virginity.  Proper stretching further down.
        player.cuntChange(1,true,true,false);
        outputText("  The scaly skin rubs at your soft vaginal walls like nothing else you have experienced, and the feeling begins to drive you mad with pleasure. It only takes a few minutes of this gentle tail-fucking to drive you to another climax. This time, however, the " + gorgonOrNaga);
        outputText(" doesn't wait for your recovery. Instead, she responds by plunging deeper, forcing her ever-thickening tail deeper inside your " + vaginaDescript(0) + ". As she stuffs more and more of her scaly tail inside you, her hands begin to work on your " + nippleDescript(0) + "s, gently caressing and massaging them.\n\n");
        //[If Lactating]
        if(player.lactationQ() >= 50 && player.biggestLactation() >= 1) outputText("Your warm milk is leaking from your " + nippleDescript(0) + "s the entire time, coating your skin and soaking her hands. At one point, she withdraws a hand and licks the milk from it. You can only assume that she liked it, as she begins to focus even more on your breasts.\n\n");
        //-------
        outputText("The " + gorgonOrNaga);
        outputText(" lifts you from her body with her tail, placing you onto the warm sand where she had been laying. She moves her own body above yours, her tail buried deep inside your " + vaginaDescript(0) + " the entire time. She holds you in place with one hand, her other hand moving to resume playing with your [allbreasts]. She moves her head in, her hot breath washing over your neck, and looks up into your eyes for a moment. She smiles, giggles, and then wraps her mouth around your " + nippleDescript(0) + ", letting her slender tongue tickle your sensitive areola.\n\n");
        //-----
        //[If lactating]
        if(player.lactationQ() >= 50 && player.biggestLactation() >= 1) outputText("As her mouth sucks and plays with your nipple, your warm, sweet milk begins to flow forth once again, filling her mouth with your delectable cream. Her hand is also absolutely covered by it, and the excess drips down to the dry sand below, absorbed in seconds by the thirsty earth.\n\n");
        //------
        outputText("All this time, her tail has been working its way slowly inside you, stretching you farther with every thrust. As you open your mouth wide to let out another passionate wail, she moves in, pushing her lips over yours and kissing you passionately.\n\n");
        //----
        //[If Lactating]
        if(player.lactationQ() >= 50 && player.biggestLactation() >= 1) outputText("She shares a mouthful of your delicious milk with you.\n\n");
        //------
        outputText("As the tip of her tail finally comes to rest against your cervix, you find yourself succumbing to another orgasm, your slutty wails of pleasure encouraging the " + gorgonOrNaga);
        outputText(" to continue. As you begin to calm down again, you believe that this is the deepest the " + gorgonOrNaga);
        outputText(" will go, although your brain works really hard and comes up with a desire for MORE depth...");
        //PROPER stretched.
        player.cuntChange((player.vaginalCapacity() + 5),true,true,false);
        outputText("\n\n");
        outputText("Then, like, your wish totally comes true! The " + gorgonOrNaga);
        outputText("'s tail begins to bash itself against your cervix, searching for the weak point. Her hands hold you steady as her thrusts begin to increase in intensity. It's not long into this rough tail-fucking that you find yourself on the verge of orgasm again, totally turned on by the sight of your own [allbreasts] bouncing as she fucks you. The " + gorgonOrNaga);
        outputText(" grits her teeth, and, with one last, powerful thrust, forces her tail inside of your womb, pushing through your well-pounded, well-used cervix. She manages to stuff enough tail inside you to cause a visible bulge in your stomach. This combination of sensations is too much for your tiny brain, and sends your head spinning as your climax reaches its peak. Your already weak mind slips even further, your vision fading. The last thing you see is the " + gorgonOrNaga);
        outputText("'s smiling face, her cheeks flushed and her eyes full of passion.");
        player.sexReward("Default","Default");
    }

    function nagaRapesMale():void {
        //select cock first
        var x:Number = player.cockThatFits(monster.vaginalCapacity()); //fit
        if (sceneHunter.dickSelect && rand(2))
            x = player.findCock(1, monster.vaginalCapacity(), -1); //select the biggest one (non-fitting)
        if (x < 0) x = player.biggestCockIndex(); //select overall biggest anyway
        //(If defeated by lust)
        if(player.lust >= player.maxOverLust()) outputText("You fall to your knees, your body shaking with desire.\n\n");
        //(If defeated by KO)
        else outputText("You fall to your knees, your battered body unable to hold itself up any longer.\n\n");
        outputText("You hear the hiss of the " + gorgonOrNaga);
        outputText("'s laughter as she slithers over to your prone form. Her long tail twists around you and tightens suddenly, pinning your arms to your sides");
        //(if centaur)
        if(player.isTaur())
            outputText(" and clamping your legs to your stomach");
        outputText(". You struggle weakly against her grip, but ");
        //(if defeated by lust)
        if(player.lust >= player.maxOverLust()) outputText("all your resistance seems to do is make your " + player.cockDescript(x) + " harder.");
        //if defeated by KO)
        else outputText("you are too weak to do anything to stop her squeezing.");
        outputText("  She leans towards you, gripping your shoulders as she brings her face to your ear. You can feel her serpentine tongue flicking over your ear as she hisses coldly into it.\n\n");
        outputText("The only thing running through your mind is a memory from your childhood. A memory of a snake you once saw with a bird wrapped in its tail, squeezing it more and more as the pitiful trapped creature struggled just to breathe. You remember watching as it slowly stopped moving and the snake made its move, opening its maw to swallow the small morsel whole. This is not how you thought your time as champion would end; being eaten by a snake girl was very low on your list of ways to die.");
        //(if player is corrupt)
        if(player.cor > 75) outputText("  The thought somehow makes your " + player.cockDescript(x) + " throb even more.");
        outputText("\n\n");
        outputText("You close your eyes and ready yourself to meet your fate. Instead, you feel the hand of the " + gorgonOrNaga);
        outputText(" at your crotch, sliding your [armor] down to give her better access to your " + player.cockDescript(x) + ". A gasp of surprise escapes you as the " + gorgonOrNaga);
        outputText(" grabs ahold of your " + player.cockDescript(x) + " and starts to stroke it, licking at the " + player.cockHead(x) + " with her serpentine tongue. You moan as she quickens her pace, causing a wave of heat to rise through your shaft.\n\n");

        //(Cock fits)
        if(player.cockArea(x) <= monster.vaginalCapacity()) {
            outputText("She stops suddenly, and you look at her, a pleading look in your eyes despite yourself. The " + gorgonOrNaga);
            outputText(" isn't done with you yet, and she makes this known by opening up the scaly slit at her crotch to reveal her moist cunt. She rubs the opening on to the " + player.cockHead(x) + " of your " + player.cockDescript(x) + ", teasing your throbbing member before slowly sliding it in. She carefully lowers herself onto you, swallowing up the first few inches of your " + player.cockDescript(x) + ". Her hips slide back, before bringing them back down and sliding more of your cock into her. She continues to gently swallow more of you inside of her, the folds of her love canal massaging you with each progressive thrust. Finally, there is no more of you that she can push into her, her stomach presses against you in an attempt to try to bring more of you inside her.\n\n");
            outputText("You feel the hands of the snake woman firmly grab your shoulders and watch as she pulls away from you, shouting with pleasure as she thrusts herself down on the full length of your shaft. Unable to move or do anything to help her, you watch helplessly as she manipulates your body, her slick netherlips completely enveloping your " + player.cockDescript(x) + ".  Again and again she thrusts her hips onto your " + player.cockDescript(x) + ", her pussy squeezing you almost as tightly as her tail. She continues to impale herself on your " + player.cockDescript(x) + ", her thrusts becoming more intense by the moment. Finally, she gives one last squeeze and tilts her head back with a yell. Unable to hold back, her tight walls begin to convulse, squeezing your " + player.cockDescript(x) + " tighter than ever before. You can feel a pressure welling up inside as her soaking pussy attempts to milk your " + player.cockDescript(x) + " of its tasty seed. You try to hold back, but it's no use. As she continues to pump at your " + player.cockDescript(x) + ", a torrent of warm, sticky cum ");
            //Cum variants
            if(player.cumQ() < 250) outputText("pours");
            else if(player.cumQ() < 1000) outputText("spurts");
            else outputText("erupts");
            outputText(" into her body. She ");
            //(Normal)
            if(player.cumQ() < 250) outputText("moans and pants");
            //(Lots of cum)
            else if(player.cumQ() < 1000) outputText("squeals with joy");
            //(It's gonna take weeks to clean this up!)
            else outputText("screams in delight");
            outputText(" as your hot, gooey sperm ");
            //(Normal)
            if(player.cumQ() < 250) outputText("coats her womb.");
            //(Lots of cum)
            else if(player.cumQ() < 1000) outputText("completely fills her.");
            //(Indonesia called, they're flooded again)
            else outputText("absolutely engorges her, with the excess spurting out in torrents from her pussy.");
            player.sexReward("vaginalFluids","Dick");
        }
        //(Cock too big)
        else {
            outputText("As she continues to stroke your " + player.cockDescript(x) + ", her nimble fingers doing their best to wrap around your prodigious girth, she moves her head in closer to wrap her lips around the tip of your " + player.cockDescript(x) + ". She begins to gently suck at the head of your " + player.cockDescript(x) + ", her thin, reptilian tongue dancing across the slick surface. ");
            //(if PC has balls)
            if(player.hasBalls()) {
                outputText("She shifts one of her hands down from your " + player.cockDescript(x) + ", to your [balls], cupping them in her slick palm.  ");
            }
            outputText("As her tongue continues to slide across the " + player.cockHead(x) + " of your " + player.cockDescript(x) + ", her slender tongue wanders ever so closely to the center. You feel a strange sensation as her tongue wanders inside the hole at the tip of your " + player.cockDescript(x) + ", just barely tickling the inside. You try to pull away, but her tail binds you too tightly to move much. The " + gorgonOrNaga);
            outputText(" notices your reaction and begins to exploit it as much as she can. She begins to force the rest of her tongue inside of your urethra, her forked tip tickling you from the inside as she pushes deeper. The " + gorgonOrNaga);
            outputText(", now that her tongue is completely buried inside your " + player.cockDescript(x) + ", turns her attentions to the actual shaft, attempting to sandwich it between her modest ");
            outputText((isGorgon)?"D":"C");
            outputText("-cup breasts. She begins to stroke them up and down along your " + player.cockDescript(x) + ", sucking at the " + player.cockHead(x) + " and tickling your urethra at the same time.\n\n");
            outputText("As violated as you are at the moment, you cannot deny the wonderful sensation the " + gorgonOrNaga);
            outputText(" is creating, and after only a short time of being subjected to this bizarre act do you feel that familiar pressure building up inside your groin. It is only moments before your sticky seed begins to flow forth into her mouth. ");
            //OH SHIT MOAR CUM
            //(Normal)
            if (player.cumQ() < 250) {
                outputText("The " + gorgonOrNaga);
                outputText(" manages to hold the warm cum within her mouth, only causing her cheeks to bulge a little.");
            }
            //(Lots of cum)
            else if (player.cumQ() < 1000) {
                outputText("The " + gorgonOrNaga);
                outputText("'s cheeks balloon as her mouth is filled with your hot, gooey sperm, forced to swallow some of it as her cheeks reach their full capacity.");
            }
            //(Cumception, we need to go deeper)
            else {
                outputText("Hot semen blasts from the " + gorgonOrNaga);
                outputText("'s nose as her mouth is completely filled in seconds. Much of your warm cum is forced down her throat and into her stomach, causing it to distend slightly within her thin frame.");
            }
            outputText("  The " + gorgonOrNaga);
            outputText(" pulls away, her tongue slowly sliding from your " + player.cockDescript(x) + " and dripping with cum, allowing the last few drops of cum to splash across her face and breasts. Her cheeks are still full of seed and  as she moves in closer, you wonder what she has planned. She grabs your shoulders with her still-slick hands, and leans in all the way for a final, passionate kiss. As your lips are pushed apart by her own, you feel a large amount of your still-warm sperm enter your mouth. You try to resist, but she begins to massage your throat, forcing you to swallow it all.\n\n");
     	//(If you've been a bad boy during victory scenes)
            if(player.hasStatusEffect(StatusEffects.MeanToNaga)) {
                outputText("As you gulp down a mouthful of your own seed, you notice something strange about it. The taste, there is something about it, it tastes almost like... POISON! You gag, but it's too late. The " + gorgonOrNaga);
                outputText(" pulls away, wiping the last drips of cum from the corner of her mouth, and smiles mischievously as your vision begins to fade. The last thing you see is her face, with a look of complete satisfaction stretched across it.  With that last vision, the poison takes its effect, and you pass into unconsciousness.");
            }
            //(If you've been nice to her: Default setting)
            else
                outputText("You end up enjoying the whole thing. She then gets back up and leave you there, not without looking back. You stay there, lying on the sand for a few moments before you doze off in a nap.  After you wake, you finally decide to head back to your camp.");
            player.sexReward("saliva","Dick");
        }
    }

    function nagaRapesFemale():void {
        sceneHunter.print("Corruption checks (50 and 80), F.Nipples, lactation. Pregnancy check (alt if you were mean to her)).");
        //(If defeated by lust)
        if(player.lust >= player.maxOverLust())
        {
            outputText("You fall to your knees, your body shaking with desire.\n\n");
        }
        //If defeated by KO)
        else
        {
            outputText("You fall to your knees, your battered body unable to hold itself up any longer.\n\n");
        }
        outputText("The " + gorgonOrNaga);
        outputText(" slowly approaches you with a smile of delight, devouring you with her eyes like the helpless morsel you are. When she's close enough, she slides her tail under you and brings you closer to her. As she hisses in your ear, a chill goes down your spine: you don't understand a word she is saying, but you can tell just by the variations that this lovely lady won't be going easy on you, ");
        //(if corrupted)
        if(player.cor > 50)
        {
            outputText("and the sheer thought of it is making you wet already.  ");
        }
        //(if uncorrupted)
        else outputText("and while you know you probably won't like it, your " + vaginaDescript(0) + " says otherwise.  ");
        outputText("Now astride the base of her tail and facing towards her, your eyes are drawn to the place on her scaly pelvis where a vagina should be. With one hand the " + gorgonOrNaga);
        outputText(" begins gently caressing her nether regions, which begin to swell in her excitement into the outlines of a recognizable reptilian vulva. Her expectations are perfectly clear ");
        //(If defeated by lust)
        if(player.lust >= player.maxOverLust())
        {
            outputText("and you can feel the need to have sex with her burn inside you. You quickly strip yourself of your [armor] and throw yourself on her awaiting pussy.");
        }
        //(If defeated by KO)
        else
        {
            outputText("and you're too weak to resist anyway; you might as well just comply. You attempt to remove your [armor] before the " + gorgonOrNaga);
            outputText(" grabs you in pity and decides to help you with it. Now naked,  she lays you down on her tail and you let her guide you to her awaiting pussy.");
        }
        outputText("  Without any further complaints, you pull her lips apart and start licking. The creature lets out a sigh of pleasure as you move your tongue around the outside of her netherlips.\n\n");
        outputText("Slowly you move your tongue around her folds, hearing her soft moans of arousal. Bringing your lips to the bottom of her slit, you gently kiss at it, carefully working your way up to the top. You pause a moment once at the top to plant a gentle kiss on her love button and feel her twitch slightly before you make your way back down to her glistening cunt and lick at the moisture, savoring its taste.\n\n");
        outputText("You continue your loving assault on her love canal as the " + gorgonOrNaga);
        outputText("'s moans gradually become louder. Her hands make their way to your head, and she curls her fingers through your " + hairDescript() + " to get a better grip on your head as you bring your mouth up to her pleasure buzzer. You give one final, slow lick up the length of her pussy and twirl your tongue around her now engorged clit. The " + gorgonOrNaga);
        outputText(" involuntarily bucks her hips into your face as you start to suck on her pleasure buzzer. As you continue to play with her clit, she begins to lose control, grinding her soaking pussy against your face, and vice-versa. She forces herself onto you so hard, it becomes hard to breathe, and the warm juices of her excited love-slit coat your face. ");
        //(If you are a naughty girl)
        if(player.cor > 80) {
            outputText("You attempt to bite at her clit, in an attempt to have her let off a bit, but instead of causing her to pull away, it drives her over the edge, sending her into a crushing climax. She squeals, and her hips begin to buck with more ferocity than ever before. Her warm reptilian love juices fill your mouth and splash across your face and upper body, and she hisses something, which you can only assume is encouragement.");
        }
        //(If you are a good girl)
        else {
            outputText("You attempt to pull away from her hot snatch, pulling your mouth from her swollen clit. She overpowers you, pulling your face back down upon her lovebuzzer. The feeling of your warm, wet lips as they rub against her clit is apparently just enough for her as it pushes her past her limit, sending her into a passionate orgasm.");
        }
        outputText("  You finally pull away from her as her body is wracked with powerful contractions, wiping the excess ladycum from your face.\n\n");
        outputText("After the " + gorgonOrNaga);
        outputText(" manages to calm herself, her breathing becoming regular and her muscles loosening up, she smiles a genuine grin and hisses something to you. She leans in close, her head only inches from yours and suddenly shifts her tone, adopting a much more seductive one. She pulls you into an upright position, facing her. Your wet pussy rubs against her tail's scaly skin as she moves her own body closer to yours. She wraps the end of her tail around, so that it stands erect between the two of you. The " + gorgonOrNaga);
        outputText(" hisses something at you, and, realizing that you don't understand a word she says, begins to demonstrate what she means. She leans in close to her tail, and begins to run her thin tongue along its length, as far as she can. Understanding what she means, you join her, your own tongue running across her smooth, scaly tail tip.\n\n");
        //(If you are a bad girl)
        if(player.cor > 50) {
            outputText("You close your eyes, and imagine that the tail is just another big cock to be sucked. You begin to suck at the tip, as well as run your tongue up and down along its length.  ");
        }
        //(If you are a good girl)
        else {
            outputText("You do your best to follow the " + gorgonOrNaga);
            outputText("'s example, but you are not sure why she is doing it.  ");
        }
        outputText("Eventually, it appears that the " + gorgonOrNaga);
        outputText(" is satisfied, and she stops, nudging you to do so as well.\n\n");
        outputText("Then the " + gorgonOrNaga);
        outputText(" lies flat on the sandy ground, pulling your body down onto on hers, face up, with your head resting between her soft breasts. She reaches around your body, placing her hands on your own " + biggestBreastSizeDescript() + " gently holding you in place as her tail moves closer to your " + vaginaDescript(0) + ". As she begins to rub her presently-slick tail against your slit, the scaly tip brushes your " + clitDescript() + " and you moan with passion in response.  There is no holding it back; this feeling is one of the best you have experienced. Her tail continues to flick and rub your " + clitDescript() + " as you begin to buck your hips gently. The " + gorgonOrNaga);
        outputText(" pokes and rubs at your " + clitDescript() + " for some time, eventually driving you to the first of many coming orgasms. After your breath has become even again, and your muscles have become relaxed, the " + gorgonOrNaga);
        outputText(" resumes her advances. She begins to rub the tip of her tail up and down along your " + vaginaDescript(0) + ", and you finally understand her intentions.\n\n");
        outputText("As the tail begins to penetrate you, you cannot help but let out another passionate moan. The scaly skin rubs at your tender vaginal walls like nothing else you have experienced, and the feeling begins to drive you mad with pleasure. It only takes a few minutes of this gentle tail-fucking to drive you to another climax. This time, however, the " + gorgonOrNaga);
        outputText(" doesn't wait for your recovery. Instead, she responds by plunging deeper, forcing her ever-thickening tail further into your " + vaginaDescript(0) + ". As she stuffs more and more of her scaly tail inside you, her hands begin to work on your " + biggestBreastSizeDescript() + ", gently caressing and massaging them.");
        //(If fuckable nipples)
        if(player.hasFuckableNipples()) {
            outputText("  As her hands rub across your " + biggestBreastSizeDescript() + ", the " + gorgonOrNaga);
            outputText(" takes notice of the size of your nipples. She begins to press on them with her fingers, and, to her surprise, her fingers begin to disappear inside your breasts. It doesn't take her long to figure it out, and before you know it she is finger-fucking both your " + nippleDescript(0) + " in sync with the thrusts of her tail.");
        }
        //(If lactating)
        if(player.biggestLactation() > 1) {
            outputText("  Your warm milk is leaking from your " + nippleDescript(0) + " the entire time, coating your [skin.type] and soaking her hands. At one point, she withdraws a hand and licks the milk from it. You can only assume that she liked it, as she begins to focus even more on your breasts.");
        }
        outputText("\n\n");
        outputText("The " + gorgonOrNaga);
        outputText(" lifts you from her body with her tail, placing you onto the warm sand where she had been laying. She moves her own body above yours, her tail buried deep inside your " + vaginaDescript(0) + " the entire time. She holds you in place with one hand, her other hand moving to resume playing with your " + biggestBreastSizeDescript() + ". She moves her head in, her hot breath washing over your other breast, and looks up into your eyes for a moment. She smiles, giggles, and then wraps her mouth around your " + nippleDescript(0) + ", letting her slender tongue tickle your sensitive skin there.");
        //(If fuckable nipples)
        if(player.hasFuckableNipples()) {
            outputText(  "It isn't long before she decides to take it one step further, pushing her tongue inside your " + nippleDescript(0) + " and wriggling it around inside. Meanwhile, her other hand begins to work its way into your other " + nippleDescript(0) + ", finger-fucking it for all it's worth.");
        }
        //(If lactating)
        if(player.biggestLactation() > 1) {
            outputText("  As her mouth sucks at and plays with your " + nippleDescript(0) + ", your warm, sweet milk begins to flow forth once again, filling her mouth with your delectable cream. Her hand is also absolutely covered by it, and the excess drips down to the dry sand below, absorbed in seconds by the thirsty earth.");
        }
        outputText("\n\n");
        outputText("All this time, her tail has been working its way slowly inside you, stretching you farther with every thrust. As you open your mouth to let out another passionate wail, she moves in, pushing her lips over yours and kissing you passionately");
        //(If lactating)
        if(player.biggestLactation() > 1) {
            outputText(", sharing with you some of your delicious milk");
        }
        outputText(".");//(If pregnant)
        if(!player.canGetPregnant()) {
            outputText("  As you finally reach your next climax, the " + gorgonOrNaga);
            outputText(" pokes her tongue a little bit deeper inside your mouth, reaching to the back of your throat.");
            //(If you have been a bad girl in past encounters)
            if(player.hasStatusEffect(StatusEffects.MeanToNaga))
            {
                outputText("  Down this slippery rope, she drops only a few drops of her potent poison, which completely bypass your gag reflex and drop straight down your throat. You hardly notice, too busy bucking your hips against the massive tail buried within your " + vaginaDescript(0) + ". It's only as your vision fades that you realize that the " + gorgonOrNaga);
                outputText(" has done something. She pulls away from you and hisses something into your ear. The last thing you can make out is the " + gorgonOrNaga);
                outputText(" giggling as she continues to play with your breasts before your vision clouds over and your head is filled with fuzzy feelings. You black out, now nothing more than a fuckdoll for the " + gorgonOrNaga);
                outputText(" to explore. She has her fun with your limp body, and eventually leaves you there, lying on the warm sand, your " + vaginaDescript(0) + " horribly abused by the " + gorgonOrNaga);
            outputText("'s thick tail, and dripping with your own juices.");
            }
            //(If you've been a good girl during past encounters)
            else {
                outputText("  She tickles the back of your throat with her tongue, massaging your " + biggestBreastSizeDescript() + " with her hands and thrusting her tail in and out of your " + vaginaDescript(0) + ". Eventually, even she gets tired and with a pop, she pulls her massive tail from your " + vaginaDescript(0) + ", raising the tip to her mouth and sucking on it, savoring your juices. She slides off of you, laying on the sand next to you. Exhausted, it is not long before she is asleep, a big smile on her face and a finger in her snatch. You decide to rest as well, collapsing beside her. There's no way you could make it back to camp in this condition. As you doze off, her warm, scaly body gently wraps around your own, pulling you close. When you eventually wake up, the " + gorgonOrNaga);
            outputText(" is nowhere to be seen, so you simply return to camp, still somewhat tired, but rather happy.");
            }
        }
        //(If not pregnant)
        else {
            outputText("  As the tip of her tail finally comes to rest against your cervix, you find yourselfsuccumbing to another orgasm, your wails of pleasure encouraging the " + gorgonOrNaga);
            outputText(" to continue. As you begin to calm down again, you believe that this is the deepest the " + gorgonOrNaga);
            outputText(" will go. Then, as she reaches her hand to grab your other shoulder, you realize she still has plans. Her tail begins to bash itself against your cervix, the tip searching for the weak point. Her hands hold you steady, as her thrusts begin to increase in intensity, sometimes even shaking your entire body. It is not long into this rough tail-fuck that you find yourself on the verge of orgasm yet again, as the scaly surface of her tail rubs across the soft flesh of your " + vaginaDescript(0) + ".  The " + gorgonOrNaga);
            outputText(" grits her teeth, and, with one last, powerful thrust, forces her tail inside your womb, forcing her way through your cervix. She manages to stuff enough tail inside you to cause a visible bulge in your stomach. This combination of sensations is enough to send your head spinning and as your climax reaches its peak, you feel your mind begin to weaken, your vision fading. The last thing you see is the " + gorgonOrNaga);
            outputText("'s smiling face, her cheeks flushed and her eyes full of passion.");
        }
        player.sexReward("Default","Default");
        outputText("  ");
        player.cuntChange(40,true);
    }

    function nagaRapesGless():void {
        //(If player loses because of lust)
        if(player.lust >= player.maxOverLust())
            outputText("You fall to your knees, your body shaking with desire.\n\n");
        //(If player loses from HP loss)
        else outputText("You fall to your knees, your battered body unable to hold itself up any longer.\n\n");
        outputText("A grin stretches across the " + gorgonOrNaga);
        outputText("'s face as she slithers over to your collapsed form. She coils her tail tightly around your prone form, squeezing hard enough to make it difficult to breathe.")
        if (player.gender == 0) {
            outputText(" She brings her hand down to the crotch of your [armor] and a look of confusion crosses her face before she realizes that there is nothing down there.\n\n");
            outputText("After a moment of chuckling, the " + gorgonOrNaga);
        }
        else outputText("The " + gorgonOrNaga);
        outputText(" brings your face down to a scaly covering at her crotch and opens it to reveal her awaiting netherlips. ");
        //(If player not corrupted)
        if(player.cor < 50) outputText("You try to turn your head away, but she forcefully shoves it down into her soft folds.  ");
        //if player is corrupted)
        else outputText("You eagerly bring your mouth to her glistening pussy. ");
        outputText("You start to work your tongue around her awaiting clit, the " + gorgonOrNaga);
        outputText(" moaning at the pleasure. You continue your assault on her pleasure button as her pussy begins to glisten with moisture. You move your tongue to her soft netherlips, licking softly at the moisture that coats them, enjoying the moans of pleasure that erupt from the " + gorgonOrNaga);
        outputText(". The " + gorgonOrNaga);
        outputText("'s hips start to twitch as you bring your tongue up the length of her glistening slit, stopping at the top to suck gently at her clit.\n\n");
        outputText("Her tail starts to squeeze you even tighter, and you start having trouble breathing, causing you to pull your head back. The " + gorgonOrNaga);
        outputText(" looks down at you, begging you to continue until she realizes what she was doing all along. Slowly, she unwraps you, giving you some time to catch your breath before finishing the job.\n\n");
        outputText("You bring your mouth back to her awaiting hole and redouble your efforts. You can feel that she is nearing her peak as you continue to lick at her pussy. With a final shudder the " + gorgonOrNaga);
        outputText(" climaxes, squeezing you firmly against her, coating your chin and nose with her thick honey. As the " + gorgonOrNaga);
        outputText(" relaxes her grip you slide out from her loosened tail coils.  Exhausted, you lose consciousness, but when you awake, you grab your things and leave the moistened sands behind.");
        player.sexReward("vaginalFluids","Lips");
    }
}

//internal function nagaRapeChoice():void {
public function nagaRapeChoice():void {
	if (monster.HP < 1) outputText("You've defeated the " + gorgonOrNaga + "!  ");
	else outputText("The " + gorgonOrNaga + " writhes in the sand, masturbating feverishly!  She's completely forgotten about fighting you.  ");
	if (player.lust < 33) {
		outputText("You aren't aroused enough to fuck her.");
		cleanupAfterCombat();
        return;
	}
    outputText("Your body aches for further satisfaction - do you rape the snake woman?");
    //Overhauled menu
    var lowCor:Boolean = player.cor < 66 + player.corruptionTolerance;
    var hiCor:Boolean = player.cor >= 66 - player.corruptionTolerance;
    menu();
    //male
    addButtonIfTrue(0, "Sex (Male)", victoryMale, "Req. cock, non-taur body and low corruption", !player.isTaur() && player.hasCock() && lowCor);
    addButtonIfTrue(5, "Rough (Male)", victoryMale_rough, "Req. cock, non-taur body and high corruption", !player.isTaur() && player.hasCock() && hiCor);
    addButtonIfTrue(10, "Taur (Male)", victoryMale_taur, "Req. cock and taur body", player.isTaur() && player.hasCock());
    //female
    addButtonIfTrue(1, "Sex (Female)", victoryFemale, "Req. vagina, non-taur body and low corruption", !player.isTaur() && player.hasVagina() && lowCor);
    addButtonIfTrue(6, "Rough (Female)", victoryFemale_rough, "Req. vagina, non-taur body and high corruption", !player.isTaur() && player.hasVagina() && hiCor);
    addButtonIfTrue(11, "Taur (Female)", victoryFemale_taur, "Req. vagina and taur body", player.isTaur() && player.hasVagina());
    //genderless - unique button names
    if (player.gender == 0) {
        addButtonIfTrue(2, "Sex", victoryGless, "Req. non-taur body and low corruption", !player.isTaur() && lowCor);
        addButtonIfTrue(7, "Rough", victoryGless_rough, "Req. non-taur body and high corruption", !player.isTaur() && hiCor);
        addButtonIfTrue(12, "Taur Sex", victoryGless_taur, "Req. taur body", player.isTaur());
    }
    else {
        addButtonIfTrue(2, "Scissor", victoryGless, "Req. vagina or genderless (not written for males), low corruption and non-taur body", !player.isTaur() && lowCor && (player.hasVagina() || player.gender == 0));
        addButtonIfTrue(7, "Rough (Lick)", victoryGless_rough, "Req. non-taur body and high corruption", !player.isTaur() && hiCor);
        addButtonIfTrue(12, "Taur (Lick)", victoryGless_taur, "Req. taur body", player.isTaur());
    }
    //uniques
    addButtonIfTrue(3, "Lay Eggs (D)", eggUpANagaSpiderLike, "Req. drider ovipositor", player.canOvipositSpider());
    addButtonIfTrue(8, "Lay Eggs (B)", beePositANagaPlease, "Req. bee ovipositor", player.canOvipositBee());
    addButtonIfTrue(4, "Gooey Rape", gooNagaRape, "Req. goo body", player.isGoo());
    //end
	addButton(14, "Leave", cleanupAfterCombat);
}

public function nagaRapeChoice2():void {
	if (monster.HP < 1) outputText("You've defeated the naga!  ");
	else outputText("The naga writhes in the sand, masturbating feverishly!  She's completely forgotten about fighting you.  ");
	outputText("When you think over the course of actions to take, her body, or rather the purple lines on her body, starts to glow more and more until it blinds you.  After the light subsides, she's gone.  ");
    outputText("<b>Rape scenes can be re-enabled in SceneHunter menu.</b>")
	cleanupAfterCombat();
}

public function nagaPlayerConstrict():void {
	flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
	clearOutput();
	if(player.fatigue + combat.physicalCost(10) > player.maxFatigue()) {
		outputText("You just don't have the energy to wrap yourself so tightly around someone right now...");
		//Gone		menuLoc = 1;
		menu();
		addButton(0, "Next", SceneLib.combat.combatMenu, false);
		return;
	}
	//Cannot be used on plural enemies
	if(monster.plural) {
		if (monster.hasStatusEffect(StatusEffects.Dig))
		{
			outputText("You begin to dig up toward [themonster], but with multiple enemies, wrapping one up would leave you completely open to attack.  You halt your progression and dig back down before you expose yourself to danger.");
			outputText("\n\n");
			SceneLib.combat.enemyAIImpl();
			return;
		}
		else {
			outputText("You launch yourself at [themonster], but with multiple enemies, wrapping one up would leave you completely open to attack.  You hastily slither backwards before you expose yourself to danger.");
			outputText("\n\n");
			SceneLib.combat.enemyAIImpl();
			return;
		}
	}
	if(monster.short == "pod") {
		outputText("You can't constrict something you're trapped inside of!");
		//Gone		menuLoc = 1;
		menu();
		addButton(0, "Next", SceneLib.combat.combatMenu, false);
		return;
	}
	fatigue(10, USEFATG_PHYSICAL);
	if (combat.checkConcentration("", true)) return; //Amily concentration... why(true) SceneLib.combat.enemyAIImpl(); and not enemyAI();? no idea
	//WRAP IT UPPP
	if (monster.hasStatusEffect(StatusEffects.Dig)) {
		if (rand(player.spe + 80) > monster.spe) {
			if (monster.short == "demons") {
				outputText("You feel for the crowd above you for a moment, wondering which of their number you should wrap up. Your sense an isolated demon amongst the crowd. You quickly dig your way up and underneath the demon crowd as it closes in around you and, as you break out of the ground, launch yourself towards your chosen prey. You grab him out of the sea of monsters, wrap your long snake tail around his form and squeeze tightly, grinning as you hear his roars of pleasure turn to cries of distress.");
			}
			//(Otherwise)
			else {
				outputText("You quickly dig your way up and underneath your opponent and, as you break out of the ground, launch yourself at [themonster] and wrap yourself around [monster him]. You squeeze [monster him] tightly and hear [monster him] cry out in pain.");
			}
			monster.createStatusEffect(StatusEffects.Constricted, 1 + rand(4), 0, 0, 0);
		}
		//Failure
		else {
			//Failure (-10 HPs) -
			outputText("You quickly dig your way up and underneath your opponent and, as you break out of the ground, launch yourself at your opponent and attempt to wrap yourself around [monster him]. Before you can even get close enough, [themonster] jumps out of the way, causing you to fall flat on your face. You quickly pick yourself up and jump back. ");
			player.takePhysDamage(5, true);
			if (player.HP <= player.minHP()) {
				doNext(SceneLib.combat.endHpLoss);
				if (monster.hasStatusEffect(StatusEffects.Dig)) monster.removeStatusEffect(StatusEffects.Dig);
				return;
			}
		}
	}
	else {
		if (rand(player.spe + 40) > monster.spe) {
			if (monster.short == "demons") {
				outputText("You look at the crowd for a moment, wondering which of their number you should wrap up. Your glance lands upon a random demon amongst the crowd. You quickly slither through the demon crowd as it closes in around you and launch yourself towards your chosen prey. You grab him out of the sea of monsters, wrap your long snake tail around his form and squeeze tightly, grinning as you hear his roars of pleasure turn to cries of distress.");
			}
			//(Otherwise)
			else {
				outputText("You launch yourself at [themonster] and wrap yourself around [monster him]. You squeeze [monster him] tightly and hear [monster him] cry out in pain.");
			}
			monster.createStatusEffect(StatusEffects.Constricted, 1 + rand(4), 0, 0, 0);
		}
		//Failure
		else {
			//Failure (-10 HPs) -
			outputText("You launch yourself at your opponent and attempt to wrap yourself around [monster him]. Before you can even get close enough, [themonster] jumps out of the way, causing you to fall flat on your face. You quickly pick yourself up and jump back. ");
			player.takePhysDamage(5, true);
			if (player.HP <= player.minHP()) {
				doNext(SceneLib.combat.endHpLoss);
				if (monster.hasStatusEffect(StatusEffects.Dig)) monster.removeStatusEffect(StatusEffects.Dig);
				return;
			}
		}
	}
	if (monster.hasStatusEffect(StatusEffects.Dig)) monster.removeStatusEffect(StatusEffects.Dig);
	outputText("\n\n");
    SceneLib.combat.enemyAIImpl();
}

public function nagaSqueeze():void {
	clearOutput();
	if (player.fatigue + combat.physicalCost(20) > player.maxFatigue()) {
		outputText("You are too tired to squeeze " + monster.a + " [monster name].");
		addButton(0, "Next", SceneLib.combat.combatMenu, false);
		return;
	}
	//Squeeze -
	outputText("Your coils wrap tighter around your prey, leaving [monster him] short of breath. You can feel it in your tail as [monster his] struggles are briefly intensified. ");
	var damageBonus:int = 0;
	var damage:int = monster.maxHP() * (.10 + rand(15) / 100);
    damage = combat.statusEffectBonusDamage(damage);
	if (player.hasPerk(PerkLib.VladimirRegalia)) damage *= 2;
	if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
	if (player.lowerBody == LowerBody.FROSTWYRM) {
		damageBonus = combat.unarmedAttack();
		damageBonus *= combat.scalingBonusStrength() * 2;
	}
	if (player.hasPerk(PerkLib.UnbreakableBind)) damage *= 2;
	if (player.hasStatusEffect(StatusEffects.ControlFreak)) damage *= player.statusEffectv1(StatusEffects.ControlFreak);
	if (player.hasPerk(PerkLib.Sadomasochism)) damage *= player.sadomasochismBoost();
	damage = damage+damageBonus;
	SceneLib.combat.doDamage(damage, true, true);
	fatigue(20, USEFATG_PHYSICAL);
	//Enemy faints -
	if(monster.HP <= monster.minHP()) {
		outputText("You can feel [themonster]'s life signs beginning to fade, and before you crush all the life from [monster him], you let go, dropping [monster him] to the floor, unconscious but alive.  In no time, [monster his]'s eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.  ");
		if(monster.short == "demons")
			outputText("The others quickly back off, terrified at the idea of what you might do to them.");
		outputText("\n\n");
		doNext(SceneLib.combat.endHpVictory);
		return;
	}
	outputText("\n\n");
	if (monster.hasStatusEffect(StatusEffects.HypnosisNaga)) monster.removeStatusEffect(StatusEffects.HypnosisNaga);
    SceneLib.combat.enemyAIImpl();
}
//Tease
public function nagaTease():void {
	clearOutput();
	//(if poisoned)
	if (monster.hasStatusEffect(StatusEffects.NagaVenom) || monster.gender == 0 || monster.lustVuln == 0) {
		if (monster.hasStatusEffect(StatusEffects.NagaVenom)) outputText("You attempt to stimulate [themonster] by rubbing [monster his] nether regions, but [monster he] seems too affected by your poison to react.\n\n");
		if (monster.gender == 0) outputText("You look over [themonster], but can't figure out how to tease such an unusual foe.\n\n");
		if (monster.lustVuln == 0) outputText("You attempt to stimulate [themonster] by rubbing [monster his] nether regions, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
        enemyAI();
        return;
	}
	var damage:Number;
    var chance:Number = 70;
    var bimbo:Boolean = false;
    var bro:Boolean = false;
    var futa:Boolean = false;
    //==============================
    //Determine basic success chance.
    //==============================
    //2% chance for each tease level.
    chance += player.teaseLevel * 2;
    //10% for seduction perk
    if (player.hasPerk(PerkLib.Seduction)) chance += 10;
    //10% for sexy armor types
    if (player.teaseDmgStat.value>0) chance += 10;
    //10% for bimbo shits
    if (player.hasPerk(PerkLib.BimboBody)) {
        chance += 10;
        bimbo = true;
    }
    if (player.hasPerk(PerkLib.BroBody)) {
        chance += 10;
        bro = true;
    }
    if (player.hasPerk(PerkLib.FutaForm)) {
        chance += 10;
        futa = true;
    }
    //2 & 2 for seductive valentines!
    if (player.hasPerk(PerkLib.SensualLover)) {
        chance += 2;
    }
    if (player.hasPerk(PerkLib.FlawlessBody)) chance += 10;
    //==============================
    //Determine basic damage.
    //==============================
    damage = combat.teases.teaseBaseLustDamage();
    chance += 2;
    //Specific cases for slimes and demons, as the normal ones would make no sense
    if (monster.short == "demons") {
        outputText("As you stimulate one of their brethren, the other demons can't help but to feel more aroused by this sight, all wishing to touch and feel the contact of your smooth, scaly body.");
    }
    else if (monster.short == "slime") {
        outputText("You attempt to stimulate the slime despite its lack of any sex organs. Somehow, it works!");
    }
    //Normal cases for other monsters
    else {
        if (monster.gender == 1) {
            outputText("Your nimble tail begins to gently stroke his [monster cockshort], and you can see it on his face as he tries to hold back the fact that it feels good.");
        }
        if (monster.gender == 2) {
            outputText("Your nimble tail manages to work its way between her legs, grinding your tail's scaly skin against her clit. She appears to enjoy it, but it is obvious she is trying to hide it from you.");
        }
        if (monster.gender == 3) {
            outputText("Your nimble tail manages to work its way between [monster his] legs, gaining access to both sets of genitals. As your rough, scaly skin rubs past [monster his] clit, your tail gently begins to stroke [monster his] cock. The repressed expression on [monster his] face betrays [monster his] own enjoyment of this kind of treatment.");
        }
    }
    //Land the hit!
    if (rand(100) <= chance) {
		var damagemultiplier:Number = 1;
		if (player.hasPerk(PerkLib.UnbreakableBind)) damagemultiplier += 1;
		if (player.hasStatusEffect(StatusEffects.ControlFreak)) damagemultiplier += (2 - player.statusEffectv1(StatusEffects.ControlFreak));
		damage *= damagemultiplier;
        if (player.hasPerk(PerkLib.Sadomasochism)) damage *= player.sadomasochismBoost();

        //Determine if critical tease!
        var crit:Boolean = false;
        var critChance:int = 5;
        critChance += combat.teases.combatTeaseCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        if (rand(100) < critChance) {
            crit = true;
            damage *= 1.75;
        }
		if (monster.hasStatusEffect(StatusEffects.HypnosisNaga)) damage *= 0.5;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		monster.teased(Math.round(monster.lustVuln * damage));
        if (crit) outputText(" <b>Critical!</b>");
        SceneLib.combat.teaseXP(1 + SceneLib.combat.bonusExpAfterSuccesfullTease());
    }
    //Nuttin honey
    else {
        SceneLib.combat.teaseXP(1);
        outputText("\n[Themonster] seems unimpressed.");
    }
    outputText("\n\n");
    if (monster.lust >= monster.maxOverLust()) {
        doNext(SceneLib.combat.endLustVictory);
        return;
    }
    SceneLib.combat.enemyAIImpl();
}

public function nagaLeggoMyEggo():void {
	clearOutput();
	outputText("You release [themonster] from [monster his] bonds, and [monster he] drops to the ground, catching [monster his] breath before [monster he] stands back up, apparently prepared to fight some more.");
	outputText("\n\n");
	monster.removeStatusEffect(StatusEffects.Constricted);
    SceneLib.combat.enemyAIImpl();
}


private function eggUpANagaSpiderLike():void {
	clearOutput();
	outputText("As the shiny-scaled girl collapses against the sand, you scramble forward, panting not so much with the exertion of the fight as with lust and excitement.  Surely a creature as large as her has enough room to fit all your eggs?  You feel so full, and it's been so long since you last had release.");
    outputText("\n\nThe " + gorgonOrNaga);
	outputText(" raises herself onto her elbows as you bear down on her, making a half-assed attempt at a rebellious glare.  When she meets your lust-mad stare, her eyes go wide, and she struggles backwards, frantically trying to get out from under you.");
	outputText("\n\nYou're having none of that.  With your ovipositor already beginning to swing loose beneath you, your patience for your prey's shenanigans is nonexistent.  Catching her tanned shoulders with your hands, you push her down and pin her upper torso in place, though her massive tail continues to writhe beneath you.  Keeping one hand on the snake-woman's shoulder, you pat her down hastily, your fingers trailing across her stomach and hips in search of her slit.");
    outputText("\n\nJust below where her human skin fades into scales, you uncover the " + gorgonOrNaga);
	outputText("'s slick hole.  Your breath quickens again as you try to line yourself up with it, your dripping egg-tube smearing its viridian lube across her scaly underside.  You manage to slip a few inches in, but she hasn't ceased her squirming, even for a moment.");
    outputText("\n\nWith nothing around you but sand for miles, there isn't anything to anchor her to while you tend to the matter of your burgeoning spider half.  Instead, you shuffle your chitinous legs into the sand beneath the two of you before curling them in and up, effectively pinning yourself to the " + gorgonOrNaga);
	outputText(" and driving your ovipositor the rest of the way in.");
	outputText("\n\nThe tight sensation of the snake-lady's pussy wrapped around your egg-chute drives you even further into lust, and as your spidery limbs clasp her lower half tighter you throw your arms recklessly around her shoulders, smooshing her breasts into your [chest] as you lock lips and curl your tongue around hers.");
	outputText("\n\nHer squirming slows, and she begins to moan around your invading tongue, but you don't even notice, jackhammering your pole into her over and over, barely remembering to breathe as you rut against her.  You're all but whimpering into her mouth, clasping her against you in your frenzied attempt to relieve yourself.");
    outputText("\n\nFinally, muscles deep in your spider half seize and clench, and you shove her back against the sand as you arch your own, saliva dripping from both your mouths.  Your eggs flood through your ovipositor, the " + gorgonOrNaga);
	outputText("'s stomach inflating near instantly with the weight of your unborn brood.  Her vagina clenches around your shaft in orgasm, dribbling femspunk around your swollen egg-chute.");
	outputText("\n\nAbove her, you groan in complete satisfaction, eyes rolling back as you find release");
	if(player.gender > 0) {
		outputText(", ");
		if(player.hasCock()) outputText("jizz");
		if(player.gender == 3) outputText(" and ");
		if(player.hasVagina()) outputText("femcum");
        outputText(" raining down on the prone " + gorgonOrNaga);
	}
	outputText(".  You crumple into a heap on top of your reptilian lover, unconscious before you hit the sand.  Her eyes drift closed as well, as she coils around you, settling in for a well-deserved rest.");
    outputText("\n\nA while later, you awaken alone in the desert");
    outputText(" sand.  Getting your shaky legs under you and stifling a yawn, you head back to camp.  You should come to the  desert");
	outputText(" more often.");
	player.dumpEggs();
	player.sexReward("Default","Default",true,false);
	cleanupAfterCombat();
}

//Bee Naga Scene: Finished (Fenoxo) (edited)
private function beePositANagaPlease():void {
	clearOutput();
	outputText("You advance on the snake-woman before you with barely-concealed lust, a gradual trickle of your fluid drooling from the ovipositor slit behind you.  She recoils away in fear of your alien appearance, but in her current state she's unfit to put up more than a token resistance.  You round on her and help her up into a tender embrace, looking into her eyes as if to say, \"<i>It's okay, this won't hurt.</i>\"  She doesn't understand the words, but her searching, reptilian eyes slowly lose their fire at your reassuring gaze.");
	outputText("\n\nGingerly, you caress her sinuous, scaled body, exploring the curvy flow of muscle as scales down to the slight, almost imperceptible flare of her humanoid waist.  She squirms against you, her tail lashing in the sands to either side, thumping anxiously.  Soon, your curious fingers find her soft opening, hidden amongst the scales, and as you press inside, you find a second set of wet lips along with a harder, pill-shaped organ that can only be a clit.  The woman's fanged mouth parts in a wordless expression of pleasure, and as you have her distracted, you let your stinger slide through the scales on her underbelly.");
    outputText("\n\nThe " + gorgonOrNaga);
    outputText(" winces, giving you a look of extreme betrayal while your venom pours through her defenses unhindered.  You study her face while your stinger works its magic.  The furrows in her eyebrows slowly relax and the " + gorgonOrNaga);
	outputText("'s lips part, allowing her to pant.  Gradually, her skin flushes red with unrepentant lust, and as you empty the last of your stinger's reservoir into her vulnerable form, you take great pleasure in fingering her increasingly lubricated pussy.  The scales around her crotch-slit are so wet that they appear to be polished with oil, a shining stain of lust that spreads with each passing moment.  She's ready.");
	//{empty venom}
	player.tailVenom = 0;
    outputText("\n\nYou press your fingers in to get a feel for your future incubator's readiness, and to your satisfaction, she's practically gushing.  Her sizable box squishes with wetness as you tease the lips, then stuff four fingers inside.  The sloppy hole easily takes most of your hand, and encouraged by the progress, you push deeper, burrowing your arm to the elbow.  Clutching feebly around your shoulder, the snake woman hangs on to you for dear life, her pussy gushing and weakly squirting around your elbow as you plumb her depths.  Her serpentine cunt seems to go on forever, which is perfect for your purposes.  You unceremoniously remove your arm and smile at the " + gorgonOrNaga);
	outputText("'s fresh contortions of pleasure.");
    outputText("\n\nWavering back and forth like a leaf in a storm, the " + gorgonOrNaga);
    outputText(" seems besieged by her own lust, barely able to support herself.  Your ovipositor slides out of its internal compartment, drooling sweet amber slime behind you at the sight.  Utterly beholden to your lusts, you pounce on the " + gorgonOrNaga);
	outputText(" and bear her to the ground with gentleness reminiscent of a drunken moose. She goes over like a house of cards, flat on her back with you atop her.  For all your lack of grace, you positioned her such that your egg-filled prong is hovering just above her entrance, soaking the snake-woman's exterior entrance with a thick flow of honey.");
    outputText("\n\nYou gently lower your insectoid abdomen until your egg-tube parts the " + gorgonOrNaga);
	outputText("'s lips, then with a gentle push, you begin to slide it in.  Her entrance is surprisingly snug for something that could handle your whole arm, and you take your time pushing inside of it, not nestling your bug-butt's exoskeleton against her until you've taken the time to fully enjoy the penetration.  Once your organ has been sent home, your drugged-up partner surprises you by grabbing your head and pulling you into a kiss, her fangs pressing dangerously against your lips.");
	if(player.cor < 33) outputText("\n\nWith nothing to do but enjoy the tender moment,");
	else if(player.cor < 66) outputText("\n\nFiguring you may as well enjoy the extra stimulation,");
	else outputText("\n\nReluctantly kissing her back, if only because it makes your egg-spout throb,");
    outputText(" you relax against her, two bodies twined into one passionate shape.  The " + gorgonOrNaga);
	outputText("'s tail circles one of your [legs] and your abdomen affectionately, and your ovipositor suddenly thickens, stretched a bit wider at the base as your first egg drops into the chute.  The scaly seductress wiggles a little at this, but her sultry gaze leaves no doubt as to her enjoyment of it.  You flex muscles you don't truly understand and force another egg in behind the first... and a third... and a fourth.");
    outputText("\n\nPOP!  The first egg exits your tubular psuedo-wang with a gush of honey to lubricate its passage, and like magic, it wicks away into the " + gorgonOrNaga);
	outputText("'s body, beyond your feeling.  The snake's eyelashes flutter crazily, and her fingernails dig into your " + player.skinFurScales() + " brutally hard.  You find it difficult to notice any pain from it though; any discomfort is easily blunted by the pleasure of thick eggs sliding through your organ.  There really is no way to compare it to anything else - you have a tight cunt wrapped around your shaft, like a cock, but you also have hard objects sliding through your interior passage, like a vagina.  You can feel all of this along with the gentle stretching of your tube as each round orb squeezes out, accompanied by spurts of honey.  The alternately building and releasing tension repeats over and over, like a half-dozen tiny orgasms.  It is divine.");
    outputText("\n\nYour body, reacting to the mounting pleasure, begins to squeeze and push your remaining eggs out rapid fire.  The muscles you flexed to start the action seem entirely out of your control now, contracting crazily to fill your tube with heavy thickness.  Pressure builds up, and you try to relax, but you wind up arching your back and groping the " + gorgonOrNaga);
    outputText("'s tits, crying out with orgasmic bliss.  Your prong twists and wiggles inside your partner, and then, with a triumphant pulsation, it opens wide, spraying out a string of eggs and honey with such rapidity that your eyes roll back and your [hips] begin to shake.  Splort, squish, splort!  Over and over, your body squirts eggs into the equally orgasming " + gorgonOrNaga);
	outputText(", sliding the eggs home into her roomy womb.");
	if(player.hasCock()) outputText("  [EachCock] erupts to splatter her with white");
	if(player.hasCock() && player.hasVagina()) outputText(" and y");
	else if(player.hasVagina()) outputText("  Y");
	if(player.hasVagina()) {
		outputText("our [vagina] ");
		if(player.wetness() < 3) outputText("drools");
		else if(player.wetness() < 5) outputText("gushes");
		else outputText("splatters");
        outputText(" clear femcum over the " + gorgonOrNaga);
		outputText("'s tight belly");
		if(player.hasCock()) outputText(" as well");
	}
	if(player.gender > 0) outputText(".");
	outputText("\n\nPanting softly, the confused, climax-addled snake weakly kisses you again, though it falls apart once you withdraw your spent egg-tube from the gushing, honey-scented snatch.  A small river of amber goo runs from her slightly-gaped pussy as you withdraw, though your eggs are pushed so deep as to be invisible");
	if(player.eggs() > 30) outputText(" from the outside at least.  You stuffed her so full that she looks positively pregnant, bulging to a picture of utter fertility");
	outputText(".  She idly runs her hands across her body, pinching her nipples and gasping in delight.  Your venom is clearly keeping her quite aroused, even with such a powerful orgasm.  After such a workout, you feel like you might have a little bit of venom left, so you give the new ");
	if(player.fertilizedEggs() == 0) outputText("egg-bearer");
	else outputText("mother");
	outputText(" a parting sting.  Her moans of excitement jump an octave, and you listen to them with a happy, almost gloating smile while you get dressed.");
    outputText("\n\nYou should definitely come to the desert");
	outputText(" more often.");
	player.dumpEggs();
	player.sexReward("Default","Default",true,false);
	cleanupAfterCombat();
}
	}
}
