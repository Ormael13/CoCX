package classes.Scenes.Areas.Desert {
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.ArmorLib;

	public class NagaScene extends BaseContent{
	public function NagaScene(){

	}
//NAGA STATUS
//v1 - players last fuck was as naga - 1 = true, 0 = false
//v2 - player has ever fucked as a naga.  1 = true, 0 = false
public function nagaEncounter():void {
	spriteSelect(45);
	//Create status if needed
	if (player.findStatusEffect(StatusEffects.Naga) < 0) player.createStatusEffect(StatusEffects.Naga,0,0,0,0);
	clearOutput();
	if (player.lowerBody == LOWER_BODY_TYPE_NAGA) {
		//Set 'last fuck as naga'
		player.changeStatusValue(StatusEffects.Naga,1,1);
		//Not met as naga before
		if (player.statusEffectv2(StatusEffects.Naga) == 0) {
			player.changeStatusValue(StatusEffects.Naga,2,1);
			outputText("You wander into the desert, noting how good the sand feels on your underbelly compared to rocks and dirt. You are wondering to yourself if maybe it wouldn't be a bad idea to come out here more often when you spot something moving a little farther ahead of you.\n\n", false);
			outputText("As you get closer, you see that it is the naga that inhabits this dry desert. You stop in your tracks, wondering if it isn't too late to turn and run, when she turns her head and looks straight at you. You slowly tense your hands, ready to raise your " + player.weaponName + " as the naga eyes your new snake-like body hungrily. Just before you can ready yourself, the naga opens her mouth. But instead of hissing, you find that you can understand her speech. \"<i>Your new body looks so much better than it did before,</i>\" she says, \"<i>It looks far more... delectable now.</i>\"\n\n", false);
			if (flags[kFLAGS.CODEX_ENTRY_NAGAS] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_NAGAS] = 1;
				outputText("<b>New codex entry unlocked: Nagas!</b>\n\n")
			}
			outputText("You wonder how it is that you can understand her now. Perhaps eating and drinking everything you find isn't the greatest idea after all, and as a result you're hallucinating? \"<i>It's been so long since I last saw another of my scaly kin,</i>\" she hisses softly, pulling you out of your introspection. \"<i>I had almost forgotten how good it is to be able to look at the sleek and powerful curves our kind possess. This place can make you forget, if you aren't too careful.</i>\" As strange as it sounds in your head, you are surprised at how she doesn't hold her s's. You aren't quite sure why you thought that would make sense.\n\n", false);
			outputText("You relax a little as she slithers over to you, though you're still wary of possibly being attacked despite the bright smile on her face. When she is close enough to you, she surprises you again by draping her arms around your shoulders in a friendly hug and pressing her chest firmly against you. You jump slightly at the sudden embrace, but slowly wrap your arms around her waist and pull her closer to you.\n\n", false);
		}
		//[If already encountered as a naga]
		else {
			outputText("You slide over the hot sand of the desert, enjoying the soft hiss that it makes as your scaled body slides over it. You see a strange yet familiar shape in the distance, and as you approach you realize that it is the naga from before. You quickly slither up behind her and wrap your arms around her. You can feel her tense up momentarily, before recognizing that it's you and turning herself to face you. \"<i>You came back!</i>\" She wraps her arms around your waist and you draw her closer to you.\n\n", false);
			if (flags[kFLAGS.CODEX_ENTRY_NAGAS] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_NAGAS] = 1;
				outputText("<b>New codex entry unlocked: Nagas!</b>\n\n")
			}	
		}
		outputText("She lets out a soft moan and leans her head forward, pressing her lips against yours. You squeeze her body even more firmly against yours in response, the tips of your tails wrapping around one another. You open your mouth slightly and press your tongue against her lips. She offers no resistance and you begin caressing the inside of her mouth with your tongue, circling her fangs as she uses her own tongue to gently stroke ", false);
		//[If player has fangs]
		if (player.faceType == FACE_SNAKE_FANGS) outputText("your own.", false);
		//[player has no fangs]
		else outputText("the inside of your mouth.", false);
		outputText("\n\n", false);
		//dude secks
		if (player.gender == 1 || (player.gender == 3 && rand(2) == 0)) {
			//[Player cock is too big]
			if (player.cockArea(0) > 35) {
				outputText("The kiss continues as both of your bodies rub together sensually, your tails continuing to wrap around one another. There is a pulsing in your " + player.cockDescript(0) + " as it starts to grow hard against the naga's soft belly. Feeling this, the naga gently pulls away, slowly letting your tongue out of her mouth as she does so. Her hands make their way over your shoulders, down your abs, and stop at your " + player.multiCockDescriptLight() +".\n\n", false); 
				outputText("\"<i>You're quite the big boy, aren't you?</i>\" she says as she wraps both of her hands around your now throbbing " + player.cockDescript(0) + ". She starts to slide her hands up and down your length. Sticking out her tongue, she wraps it around the tip and licks at the pre that is starting to leak out.\n\n", false);
				outputText("A hiss of pleasure escapes your lips as the naga strokes and licks at your " + player.cockDescript(0) + ", her talented fingers and tongue bringing you into a further state of arousal. The naga stops her caressing and brings your " + player.cockDescript(0) + " to her chest, pressing her breasts around it. She slowly starts to slide her body up and down your shaft, using her tongue to bring some of your pre and lubricate her body. Once she is satisfied with her body's slickness, she quickens her pace.\n\n", false);
				outputText("You moan in pleasure as the naga takes the tip of your member into her mouth and starts to suck. You can feel her deft tongue licking every inch of your cock head.\n\n", false);
				outputText("At your limit, you let out a yell as you cum into her mouth. ", false);
				//[lots of jizz]
				if (player.cumQ() > 250) outputText("Her cheeks bulge with the volume and she struggles to swallow as much of it as she can. ", false);
				//[JIZZOFTHEGODS]
				if (player.cumQ() > 1000) outputText("Her cheeks bulge out with the sheer volume of your cum and she is forced to release you from her mouth to avoid drowning in your seed. ", false);
				outputText("You collapse onto the sand and lay there, basking in the warm glow of your orgasm. The naga slides onto your chest and gives you a kiss. \"<i>I rather enjoyed that,</i>\" she hisses into your ear, \"<i>We should do this more often.</i>\"\n\n", false);
				outputText("She gives you one last kiss before slithering off into the desert. You watch as she leaves and blow her a kiss goodbye before she disappears from your sight.\n\n", false);
			}
			//[Cock isn't too big]
			else {
				outputText("The kiss continues and both of your bodies rub together sensually, your tails continuing to wrap around one another. There is a pulsing in your " + player.multiCockDescriptLight() + " as ", false);
				if (player.cockTotal() == 1) outputText("it starts ", false);
				else outputText("they start ", false);
				outputText("to grow hard against the naga's soft belly. Feeling this, the naga gently pulls away, slowly letting your tongue out of her mouth as she does so. Her hands make their way over your shoulders, down your abs, and stop at your " + player.multiCockDescriptLight() + ".\n\n", false);
				//[player has one dick]
				if (player.totalCocks() == 1) outputText("Gently she starts to stroke the length of your " + player.cockDescript(0) + " with one hand while circling the tip with the other. ", false);
				//[player has two dicks]
				if (player.totalCocks() == 2) outputText("She takes one in each of her hands and gently strokes them up and down. Every few seconds she stops at the tip to rub her palms over them. ", false);
				//[player has three or more dicks]
				if (player.totalCocks() >= 3) outputText("She takes one in each hand, stroking them slowly and making sure to pay attention to the tip. Every so often she switches to a different dick to make sure that each and every one of your throbbing cocks has some love given to them. ", false);
				outputText("A hiss of pleasure escapes your lips as the naga strokes your " + player.multiCockDescriptLight() + ", her talented fingers bringing you further into a state of arousal. She stops her caress and brings her hand to a scaly covering at her crotch, spreading it wide to reveal her soft pussy.\n\n", false);
				
				//[player has one dick] 
				if (player.totalCocks() == 1) outputText("She carefully lines it up with your member and starts to tease the tip before gently inserting the first few inches. ", false);
				//[player has two dicks]
				if (player.totalCocks() == 2) outputText("She carefully lines it up with both of your members and starts to tease their tips before gently inserting the first few inches. ", false);
				//[player has three or more dicks]
				if (player.totalCocks() >= 3) outputText("She carefully lines it up with one of your members and starts to tease the tip before gently inserting the first few inches. ", false);
				outputText("She pulls her hips back slightly before pushing them back down, swallowing a bit more of you into her.  As she pulls back the second time, she shifts her arms to rest on your shoulders and grips your back tightly as she pushes you deeper inside of her.\n\n", false);
				outputText("Every thrust brings you deeper inside of her pussy, its soft walls massaging you. It seems like her pussy managed to swallow your entire cock in no time at all. The naga pauses for a moment, your hips pressed together, panting. You shift your arms up a little higher to rest at her waist and lower your head to nuzzle at her neck. The naga leans her head into yours and wraps one of her arms around your head. Once more she pulls back her hips before thrusting them back onto your cock. No longer is she slowly bringing you inside her, now she thrusts herself onto you, going faster and faster. Your tails tighten around each other as you reach climax. A sudden yell escapes your throat as you cum inside of her, your tail squeezing hard enough to crush a lesser being. The naga shudders in your grip as she reaches her own climax. ", false);
				//[lots of jizz]
				if (player.cumQ() > 250) outputText("You quickly fill her with your seed to the point where she overflows, leaving her pussy dripping with semen afterwards.", false);
				//[JIZZ, JIZZ EVERYWHERE] 
				else if (player.cumQ() > 1000) outputText("Her stomach quickly swells from the sheer volume of seed pumped into her. The sperm that her womb is unable to hold starts to gush out from her stuffed cunt.", false);
				
				outputText("\n\nThe two of you lay there for a moment, basking in the warm glow of orgasm. Eventually the naga slowly unwraps her tail from your own and gives you a kiss on the forehead. \"<i>I look forward to our next encounter,</i>\" she whispers softly into your ear before slithering off into the desert.  You watch as she leaves and wave her a kiss goodbye before she disappears from your sight.\n\n", false);
			}
			player.orgasm();
		}
		//chick secks
		else if (player.hasVagina()) {
			outputText("The kiss continues and you can feel your " + player.breastDescript(0) + " pressing against her own. You kiss her harder, pressing your body as close to her as you can, enjoying the feeling of your two bodies entwined together. You wrap your tail around hers, trying to make every part of your body touch every part of hers.  The feeling of her scaled tail rubbing against your body sends shivers of ecstasy down your spine. You pull away from her mouth and move your head to kiss at her neck, ", false);
			//(if player has fangs)
			if (player.faceType == FACE_SNAKE_FANGS) outputText("carefully nibbling at it so as to not break the skin.  ", false);
			else outputText("nibbling gently at it.  ", false);
			outputText("Traveling down, you pause at her collarbone, letting go of her hips to bring your hands up to her perfectly rounded breasts. A moan escapes the naga's lips as you massage her erect nipples. Your mouth continues its trek down the naga's supple body and you make sure to pause on each breast, circling inward and stopping on each nipple to suck gently on them.\n\n", false);
 			outputText("Once more your hands move down the naga's body, making their way across her sides as your mouth simultaneously kisses at the smooth flesh of her exposed belly. Goose pimples slowly begin to appear, denoting how much she enjoys it. You pause at her hips, hovering over the slit at her crotch. One of your hands slide down to the slit and you start to stroke at it gently as you kiss at the area around it. Your partner shudders a bit, overcome by the sensations. Slowly you slide a finger into her, hearing a gasp of pleasure as you move it around inside her.  ", false);
			//(if never encountered as a naga)
			if (player.statusEffectv2(StatusEffects.Naga) == 0) {
				outputText("As you start to unveil her innermost recess, it appears to you that she must have lost the habit of such intimate contact after spending all these years deprived of any contact.  ", false);
			}
			outputText("You twist your fingers deeper inside of her, feeling the moist walls of her love canal press around your finger. Carefully you move your hand and push another of your fingers inside, then a third, moving them to massage her innermost depths. The naga's whole body is shuddering with arousal at your touch. It would be easy enough to bring her to a climax like this, but you decide that you want to make a slight change to the situation.\n\n", false);
    		outputText("You slide your fingers out of her and lift yourself up to look into her flushed face. \"<i>N-no,</i>\" she pants. \"<i>Don't stop... So close...</i>\"\n\n", false);
			outputText("You place a finger onto her luscious lips. \"<i>Shhhhh,</i>\" you say lovingly. \"<i>All good things must come to an end, but I'm not done yet.</i>\"\n\n", false);
			outputText("You untangle the end of your tail from hers and bring it up between the two of you, sliding it between your " + player.breastDescript(0) + " and inserting it sensually into your mouth. You suck on the end, making sure to coat it liberally before bringing it down to the naga's awaiting slit.\n\n", false);
			outputText("The tip of your tail slides into her soft folds, eliciting a gasp from her. You press further into her, feeling the walls of her pussy tighten over the length of your improvised shaft. Now that you are free of any length constraints, you decide you can now finish her off with the most intense orgasm she has ever had. Your scaly tail slowly crawls inside the depths of your friend, taking its time to tickle every lump, to tease all the sensitive bits while she grips you with all of her strength. Your friend pulls herself to your body, hugging you tight and squishing her breasts against your own. She wraps her arms around you, and begins to whisper things into your ear, \"<i>P-please... more... deeper...</i>\"\n\n", false);
			outputText("You simply run your tongue around her ear, gently nibbling on it as you slowly impale your naga lover on your thick, nimble tail. Her tail whips back and forth across the sand as she slowly succumbs to the intense pleasure of your deep, intimate penetration. You begin to wriggle your own tail inside your naga friend and her response is immediate. First, she shudders as a chill of excitement rushes up her spine. As the sensation overwhelms her, she lets out a wail of satisfaction followed by a series of loud moans in time with your tail's various jerks and twists inside her. As the naga girl begins to climax, driven over the edge by your tail's intense sensations, her tail begins to flick about wildly. In a stroke of genius, you manage to grab the end of her tail, holding it more or less steady against your own " + player.clitDescript() + ". As her tail wiggles back and forth, it drives your " + player.clitDescript() + " insane, rubbing it back and forth over and over again. You prolong your friend's climax by driving your wriggling tail ever deeper inside her and soon you find yourself close to orgasm. As you feel your own climax commence, you clench your teeth and lean against your partner, your breasts mashing together and your juices beginning to intermingle. As you both begin to calm down again, chests heaving, the only thing you can think to do is kiss your partner.\n\n", false);
    		outputText("She returns your kiss, but while you are distracted she prepares herself to help you in the same way you helped her. She begins to rub her tail along your " + player.vaginaDescript(0) + ", getting it wet. As you feel her scaly member begin to slide inside your own " + player.vaginaDescript(0) + ", the very thought gets you excited. Although somewhat jumpy, she is able to push at a modest rate, slowly inching her tail inside you, very much like the way you did to her. As you continue to passionately kiss each other, your tongues wrapping around one another and your arms wrapped around each other's warm bodies, you cannot think of a better place to be. Soon, you and your partner are tail-fucking each other in unison, your lips never parting, your bodies never separating. The both of you collapse upon the sand, too focused on one another to care about the surroundings.  That is how it carried on for what seemed like a beautiful, passionate eternity. You wake up several hours later, lying on the sand next to your friend, and you can't help but notice how cute she looks asleep. Your tails are still buried within one another, testament to the intensity of your lovemaking. You loved until the both of you collapsed, side by side, juices dripping out into the dry desert sands. You slowly remove your tail from inside her body, and simultaneously pull hers from your " + player.vaginaDescript(0) + ". You kiss her on the cheek, and are just close enough to hear her whisper, \"<i>Will we ever meet again?</i>\"  You lean in close, and whisper a simple \"<i>Yes.</i>\" Then, you leave her to her well-deserved rest, and slowly meander back to your camp, your brain still intoxicated with passion.\n\n", false);
			player.cuntChange(30,true,false,true);
			player.orgasm();
			outputText("You think it would be a very good idea to come to the desert more often.", false);
			doNext(camp.returnToCampUseFourHours);
			return;
		}
		//Genderleast
		else {
			outputText("The naga looks down and suddenly giggles at your stark lack of fun-bits. You turn away in embarrassment and start to head back to your camp.\n\n", false);
			outputText("\"<i>Wait,</i>\" the naga reaches out and places a hand on your shoulder. \"<i>I didn't mean to insult you. I've never seen anyone else quite like you.</i>\" She slides her hand down your body. \"<i>I wonder if you can show me just what a body like yours can do.</i>\"\n\n", false);
			outputText("Enjoying this new shift in the conversation, you coil around her and position your head over the scaly covering over her pussy. A soft hiss escapes the naga as you slide your tongue into her, twirling it around to caress every inch of her. Her hands make their way to your head and press you deeper into her.\n\n", false);
        	//(If tongue is forked)
			//9999 - BLAH!
			if (1 == 0) outputText("You move your tongue faster and deeper into her pussy, your forked tongue reaching deeper than any human tongue ever could.  ", false);
        	//(Otherwise)
			else outputText("You move your tongue faster and faster into her pussy, reaching as far in as you possibly can.  ", false);
			outputText("The naga grips your head tightly to her and suddenly thrusts her hips in orgasm, her girl cum coating your tongue and mouth.\n\n", false);
			outputText("You uncoil yourself and slowly gather your things, the naga lying on the sand panting.\n\n", false);
        	outputText("\"<i>We should do this more often,</i>\" she says before you head off.\n\n", false);
		}
		outputText("You think it would be a very good idea to come to the desert more often.", false);
		doNext(camp.returnToCampUseOneHour);
		dynStats("lus", player.lib/5);
		return;
	}
	//If player's last fight did not involve them being a naga
	if (player.statusEffectv1(StatusEffects.Naga) == 0) {
		if (player.findStatusEffect(StatusEffects.Naga) < 0) player.createStatusEffect(StatusEffects.Naga,0,0,0,0);
		outputText("You are walking through the shifting sands of the desert when you hear a sudden hiss behind you.  Expecting to be attacked by a snake, you quickly leap forward and turn around.\n\n", false);
		outputText("To your surprise, what you see is not exactly a snake; it's a naga - a half-human half-snake hybrid.  She surges up and hisses even louder than before, showing off a pair of formidable fangs dripping with venom. Gazing at her long and slender reptilian body swaying on the sand like quicksilver, you can only stand still in admiration of this terrible wonder.", false);
	}
	//If player was a naga during last encounter
	//And isnt now
	if (player.statusEffectv1(StatusEffects.Naga) > 0) {
		//No fight for this encounter, brings you back to the camp. Next time you see her, she will attack you unless you turn back into a naga in the meantime
		player.changeStatusValue(StatusEffects.Naga,1,0);
		outputText("You walk in the desert for what feels like an eternity, thinking of how much easier it was to move across the sand back when you had a tail, but then you're brought back to reality by a familiar hissing. The identity of your follower is no secret to you. As you open your mouth to greet your naga friend, you find yourself unable to pronounce any words. The girl comes towards you and slithers around in a confused way, trying to communicate. But the sounds that once formed words and phrases now seem to slip through you; all you can do is stand there, unable to grasp what she's trying to tell you. Realizing that you're not who you used to be anymore, she sadly looks down and turns around. The naga slithers away into the distance until she's nothing but a blink on the horizon.", false);
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	if (flags[kFLAGS.CODEX_ENTRY_NAGAS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_NAGAS] = 1;
		outputText("<b>New codex entry unlocked: Nagas!</b>\n\n")
	}
	startCombat(new Naga());
}

private function gooNagaRape():void {
	clearOutput();
	player.orgasm();
	outputText("You look over at the prone form of the naga lying in the sand, her ", false);
	if (monster.HP < 0) outputText("weak ", false);
	else outputText("flushed ", false);
	outputText("form only serving to arouse you further. You slide over to her, your gooey lower half leaving a wet trail behind you. As you stand over the defeated form of the snake woman, an idea pops into your head, ", false);
	if (player.cor > 50) {
		//(if corrupt male)
		if (player.gender == 1) {
			outputText("your " + player.cockDescript(0) + " growing harder at the thought.", false);
		}
		//(if corrupt female)
		else if (player.gender == 2) {
			outputText("your cunt grows moist at the thought.", false);
		} 
		else if (player.gender == 3) {
			outputText("your cock twitches and your pussy becomes moist from the thought.", false);
		}
		else outputText("you feel a tingle at your groin from the thought.", false);
	}
	//(if not corrupt)
	else {
		outputText("the thought is almost too horrible to consider, but still...", false);
	}
	outputText("  You slide your gooey form over her body, resting at her crotch. She tries to push you off, but you easily resist her.\n\n", false);
    outputText("Looking down, you see a scale covered slit at her crotch. Bringing a hand down to it, you stroke it gently and feel the naga twitch beneath you. You slowly open the slit to reveal the moist folds of her pussy. You start to tease her by stroking her netherlips, the naga moaning in response. You gradually slide your fingers in, moving them inside of her to see just how far her lips can spread. The naga continues to pant and moan under your touch, her tail thrashing in the sand.\n\n", false);
    outputText("You decide that you've played with her enough and withdraw your hand, now wet with her juices, from her pussy. A hiss escapes the naga's lips and she tries to bring your hand back to her needy cunt. You pull your hand out of her grip and instead shift your gooey form over her lips and start to push some of your lower half into her. She starts to coo as you shove the first few inches in, her hips thrusting into the air. You continue to push more of your slimy form into her, sliding deeper and deeper into her as her walls convulse around you.\n\n", false);
	outputText("Soon you feel yourself hit a wall as your body hits the opening of the naga's cervix. A stray thought crosses your mind as you think that maybe this is far enough, ", false);
	//(if corrupt)
	if (player.cor > 50) outputText("but immediately after, you decide that this is going to be too much fun to not push on.", false);
	//(if not corrupt)
	else outputText("but a nagging voice at the back of your head urges you to push further.", false);
	outputText("You grab the naga's shoulders and thrust yourself down, HARD. The naga screams as you push past her cervix and fill her womb with your gooey form. Her entire body writhes as you push more of yourself into her womb, her stomach starting to bulge out at the sheer amount filling her. The screams of the naga intensify as you push more and more of yourself into her, her stomach swelling enough to look pregnant. You finally stop pushing into her, almost your entire lower half inside of the naga.\n\n", false);
    
	outputText("You pause for a moment, enjoying the sensation of filling someone up with your body, surprised at just how good it feels. Grabbing the naga's hips you slowly push yourself in and out of her now full pussy, ", false);
	//(if male)
	if (player.totalCocks() > 0) {
		if (player.cockTotal() == 1) outputText("your " + player.cockDescript(0), false);
		else outputText("one of your " + player.multiCockDescriptLight(), false);
		outputText(" hitting the naga's pleasure buzzer with each downward thrust.", false);
	} 
	//(if female)
	else if (player.gender == 2) {
		outputText("your clit rubbing against the naga's pleasure buzzer with each downward thrust.", false);
	} 
	//(if herm) 
	else if (player.gender == 3) {
		if (player.cockTotal() == 1) outputText("your " + player.cockDescript(0), false);
		else outputText("your " + player.multiCockDescriptLight(), false);
		outputText(" and clit rubbing against the naga's pleasure buzzer with each downward thrust.", false);
	}
	//(if genderless)
	else {
		outputText("your bare crotch hitting the naga's pleasure buzzer with each downward thrust.", false);
	}
	
    outputText("\n\nYou continue to relentlessly push yourself into the naga, stretching her wide.  ", false);
	//(if male)
	if (player.gender == 1) {
		outputText("You let out a yell as ", false);
		//(normal) 
		if (player.cumQ() < 250) outputText("you come all over the naga's stomach.", false);
		else if (player.cumQ() < 1000) outputText("you come all over the naga's face and stomach.", false);
		//(if THE LEVEYS HAVE BROKE RUN FOR THE HILLS) 
		else outputText("you come violently, covering the naga in a layer of your sperm.", false);
	}
	//(if female)
	else if (player.gender == 2) {
		outputText("You shriek in delight as wave after wave of orgasms rush over you", false);
		//(if squirter)
		if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText(", your girlcum gushing out and pooling on the stomach of the naga", false);
		outputText(".", false);
	}
	//(if herm)
	if (player.gender == 3) {
		outputText("You scream in ecstasy as you hit your peak, your girlcum ", false);
		if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLAVERING) outputText("leaking out", false);
		else outputText("gushing out to form a pool on the naga's stomach", false);
		outputText(" and your " + player.multiCockDescriptLight(), false);
		//(normal)
		if (player.cumQ() < 250) outputText(" spurting onto her stomach as well.", false);
		//(lots of jizz)
		else if (player.cumQ() < 1000) outputText(" spurting onto her stomach and face.", false);
		else outputText(" completely covering the naga in a layer of your spooge.", false);
	}
	//(if genderless)
	if (player.gender == 0) {
		outputText("You cry out and shudder as you feel wave after wave of the naga's orgasm rushing over your body, bringing you to a strange orgasmic bliss of your own.", false);
	} 
	outputText("  For a moment you just sit there in post orgasmic bliss, the walls of the naga convulsing around your gooey half. You decide that the snake woman has had enough and slowly withdraw yourself from her abused love canal. You gather up your things and head back to your camp, leaving the naga lying in the sands.", false);
	combat.cleanupAfterCombat();
}

//3) Victory male
private function nagaVictoryMale():void {
	clearOutput();
	player.orgasm();
	//Male or 50% herms
	if (player.totalCocks() > 0) {
		//Centaur
		if (player.isTaur()) {
			outputText("As your massive bulk looms over the defeated naga, your eyes gleam with desire. Your heart pounds in your ears as lusty thoughts echo in your head. You lift the snakewoman up into your arms, bringing her close before licking her neck and tasting her smooth scaly skin as her tail dangles down to the sand. As you touch her, she recovers, and her tail slowly wraps around your lower half to support her own weight. She returns your attentions by running her long forked tongue down your chest. Her scaly tail rubs sensually over your flesh as she continues to wind around you, caressing your " + player.cockDescript(0) + "  with her tip, making you hard in a flash. The naga wriggles free from your embrace and coils behind you. Her entire length is now wrapped around various portions of both your humanoid and animalistic halves, and she uses her grip to dangle underneath you. Her hands reach out to take a firm hold of your " + player.cockDescript(0) + ".  You shiver as her tongue darts out and slides around your cock, pre-cum dripping from your head as she licks you. The agile naga lowers more of herself beneath you, spreading her pussy wide open before sliding onto your " + player.cockDescript(0) + " and letting out a hissy moan as you penetrate her. Your body tingles as her entire length quivers in pleasure, sending ripples over the flesh her tail is wrapped around.  Jolts of pleasure run through you as the naga woman grinds her hips against your " + player.cockDescript(0) + " , driving it into her as far as she can take.  With a loud and drawn-out moan, ", false);
			//[normal cum load]
			if (player.cumQ() < 250) outputText("you cum inside of her, ", false);
			//[extra cum]
			else if (player.cumQ() < 1000) outputText("you fill her insides with huge spurts of cum, ", false);
			//[SUPER CUM]
			else outputText("you explode with huge fountains of cum spurting from your " + player.cockDescript(0) + ", gushing out from where the two of you are joined to rain on the sands below, ", false);
			outputText("as she squeezes you tightly in a climax of her own that steals your breath away.\n\n", false);
			
			outputText("Exhausted from her gymnastics, the naga slowly unwinds from you and lies on the sand, cum dripping from her pussy onto the dry desert beneath her.\n\n", false);
		}	
		//Uncorrupted  
		else if (player.cor < 50) {
			outputText("You almost feel pity as you behold the defeated creature lying before you, but your growing arousal pushes the thought from your mind. Leaning forward to get a closer look, your thoughts wander, and you find yourself wondering what her flexible body could do. Unable to contain your lust, you remove your " + player.armorName + " and slowly lay on top of her, moving your hands across her scaly form in search of her pussy. As you rub your hands across the underside of her scaly belly, you notice that she is beginning to blush and moan softly. She is visibly trying to hold the feelings back, but whatever it is you're doing to her is definitely making that difficult. For the moment, you decide to abandon the search, content with simply running your hands along her tail's soft underside and watching her face as she tries in vain to hold her passion back. As you run your fingers up the center of her tail's underside, you notice a strange bump just a few inches below where her skin and scales meet. On further inspection, you realize that this is the thing you have been searching for - her warm, wet lovehole. Your touches seem to have had an effect on her; she is already rather moist, ready to take your " + player.cockDescript(0) + ". You gingerly slide one of your fingers inside her, feeling for depth as well as for wetness. The naga coos softly, unable to withhold her moans.\n\n", false);
			
			outputText("You slowly begin moving your fingers in and out of her wet snatch, petting her underbelly with your free hand. You can tell that she is still tense; the look on her face is a mix of passion and fear. She struggles weakly, terrified as you place your warm " + player.cockDescript(0) + " against her belly. You feel her grow still as your length rubs against her. You look deeply into her amber eyes as you wrap your arms around her, and after a moment's hesitation, kiss her passionately. Surprised at your own decision, your mind quickly conjures an image of her biting you. Instead, she relaxes in your arms and returns the kiss, abandoning herself to your will.\n\n", false);
			
			//[if cock fits] 
			if (player.cockArea(0) <= monster.vaginalCapacity()) {
				outputText("Chills run down your spine as her delicate forked tongue tangles with your own, and you gently press the tip of your " + player.cockDescript(0) + " against her moist pussy-lips. Her tail slowly wraps around your legs as she moans in a soft and mildly hissing voice. You sink your engorged member into her depths, pausing for a moment to let her adapt to your presence, before pumping away and kissing her passionately as you both get caught up in the wonderful sensations of your entwined bodies. Her tight passage massages your length, and her scaly body rubbing on your skin only encourages you to go further while you rock back and forth in her embrace. You gradually increase your pace, hearing her moans become louder as she moves her hips in time with yours. Your fingers dig into her smooth backside as you continue thrusting into her, pleasure building for what seems like a wonderful eternity. You finally reach your limit, thrusting frantically until you climax, ", false);
				//[normal cum load]
				if (player.cumQ() < 250) outputText("shooting thick ropes of sperm deep inside her as the both of you wail with excitement.", false);
				//[lots of cum]
				else if (player.cumQ() < 500) outputText("pumping large amounts of cum deep inside her as both your voices rise in screams of pleasure.", false);
				//[Spermageddon]
				else outputText("your " + player.cockDescript(0) + " erupting, blasting a violent torrent of semen deep inside her petite frame, filling her up completely as both your voices rise in screams of pleasure.", false);
			}
			//[If cock too large]
			else {
				outputText("You draw away from her lips and return to your upright posture. Relaxed as she is, the naga looks nervously at your " + player.cockDescript(0) + ", fully aware that it won't fit inside her small body. This occurs to you as well, and you begin to formulate a different plan. You move up onto her body so that you're straddling her stomach, fitting your " + player.cockDescript(0) + " neatly between her small C-cup breasts. You gently coax her hands to her breasts, and she begins to comprehend your intentions. She begins to squeeze your " + player.cockDescript(0) + " between her two warm mounds of flesh, doing her best to keep it snugly between them. Of her own accord, the naga begins to run her tongue across the " + player.cockHead() + ", obviously understanding what you want. She looks up at you with an unsure look, as if asking whether or not she is doing it right. You nod to her, and that's all the encouragement she needs. She begins to stroke your " + player.cockDescript(0) + " with her breasts as if it came naturally to her, covering as much of your " + player.cockHead() + " as she can with her warm and trembling mouth.\n\n", false);
				outputText("You lean back and sigh with pleasure as the naga's movements become bolder and bolder, fitting just a little bit more in her mouth here, or squeezing her breasts tighter there. It's not long before you are panting and slightly thrusting your hips in time to her strokes. As she quickens her pace, you cannot hold yourself back any longer. You begin to cum without much warning, ", false);
				//[normal cum load]
				if (player.cumQ() < 250) outputText("filling her mouth with your warm seed.", false);
				//[lots of cum]
				else if (player.cumQ() < 500) outputText("pumping her mouth full of your sticky seed, some of which she is forced to swallow to avoid choking.", false);
				//[Oh God, it just keeps coming out, help me!]
				else outputText("easily flooding her mouth with your seed. Your seed gushes from her nose, with still more rushing down her throat. She gags and chokes a bit, a large amount of your seed leaking out onto her chest.", false);
				outputText("  The naga removes your " + player.cockDescript(0) + " from her mouth", false);
				//[lots of cum OR more]
				if (player.cumQ() > 500) outputText(", the last sticky blasts of your semen splashing across her face,", false);
				outputText(" and looks to you for instruction. You simply nod and she understands, ", false);
				//[normal cum load]
				if (player.cumQ() < 250) outputText(" gulping down the warm sperm in her mouth.", false);
				//[lots of cum OR more]
				else outputText(" doing the best she can to swallow her mouthful of cum.", false);
			}
			outputText("\n\nYou slowly untangle yourself from the panting naga and leave her lying in the sand, basking in the warmth of sex and sun. You return to your camp, completely satisfied with your work.\n\n", false);
		}
		//Corrupted (event raises fatigue by 20)
		else {
			player.changeFatigue(20);
			outputText("Your mind fills with obscene and corrupted fantasies as you behold the defeated creature lying before you.  Leaning forward to get a closer look, your thoughts wander, and you find yourself wondering what you could do to her extremely flexible body.  Unable to contain your undying lust, you remove your " + player.armorName + " and lay on top of her, rapidly moving your hands across her scaly form in a hunt for her pussy.  The snakewoman struggles weakly beneath you, but you easily pin her to the ground. Her tail thrashes in the sand as you locate the mound of scales covering her nether-lips. You open it roughly and shove your fingers in, smiling at her cries of denial. To put an end to her complaints, you suddenly move forward and drive your " + player.cockDescript(0) + " inside her all at once, not caring whether it fits or not. The lack of lubrication couldn't bother you less. You can practically taste the incredible sensations of her love-canal as it begins to moisten. Hungering for more, you start to pound the snake woman mercilessly. Shoving your entire length in and out of her abused cunt causes her to whimper and moan in a mixture of pain and pleasure. She responds to your brutality in kind, biting at your shoulder. It takes a few seconds before your arm grows numb, and you realize too late that this little bitch is injecting you with her venom! You pry her off before she can finish, her fangs still dripping with lethal fluid. This fat little worm has gone way too far.\n\n", false);
	     	//[player has more than 1 dick]
			if (player.cockTotal() > 1) {
				outputText("You pause just long enough to force your " + player.cockDescript(1) + " inside, stretching her pussy wide and ramming into her cervix. You receive an immediate reaction as she screams in pain, as if pleading for you to stop. The desperate thrashing and squirming beneath you only serves to drive you onward. Your shoulder starts to burn as the venom seeps into your blood; you need to wrap this up soon, or else you might pass out before you've finished.", false);
	     	}
			//[player has 1 dick]
			else {
				outputText("You shove as much of yourself inside her as you can, ramming into her cervix and eliciting desperate, hissing screams that seem to plead for you to stop. You press on, pushing harder as the entrance to her womb slowly loosens from your abuse. Your shoulder starts to burn as the venom spreads into your blood; you need to wrap this up soon, or you might pass out before you've finished.", false);
			}
			outputText("\n\nYou try to maintain focus as her tight vagina continually presses around you, bringing you ever closer to orgasm. But your strength is deteriorating, and your erection begins to soften. No! You can't let that happen! In a magnificent feat of sexual rage, you force yourself to keep accelerating despite your fading consciousness. Just before passing out, you manage to finally cum in an ultimate thrust.", false);
			//[lots of jizz OR more]
			if (player.cumQ() > 250) outputText("  Your spooge explodes from the naga's abused cunt, flooding the desert sands as you black out.\n\n", false);
			else outputText("\n\n", false);
			
			outputText("When you awaken, the naga is long gone. All that remains of your encounter is a depression in the landscape", false);
			//[lots of jizz] 
			if (player.cumQ() > 250) outputText(" with traces of semen in it", false);
			//[if OMGWTFBBQGALLONSOFCUM]
			else if (player.cumQ() > 2000) outputText(" that's filled with your thick seed", false);
			outputText(".\n\n", false);
			outputText("As you retrieve your clothes, you notice red marks around your chest and arms. It seems that while the naga did have the opportunity to kill you while you were unconscious, she preferred to keep you alive.\n\n", false);
		}
	}
	outputText("You think it would be a very good idea to come to the desert more often.", false);
	player.orgasm();
	combat.cleanupAfterCombat();
	return;
}

private function nagaVictoryFemale():void {
	clearOutput();
	//4) Victory female
	if (player.hasVagina()) {
		//c) Centaur
		if (player.isTaur()) {
			//For inspiration in this noble venture: 
			//http://imagemacros.files.wordpress.com/2009/10/im_a_horse.jpg?w=402&h=604
   			//(Loss by HPs)
			//NO RAEP IF LOSS BY HPs, FUCK CENTAURS! SRSLY! GROW NORMAL LEGS!
   			//(Loss by Lust)
			if (monster.lust >= monster.eMaxLust()) {
				outputText("As your prey falls to the ground, her body too filled with sexual desire to fight, you step over her, your tall frame towering over her own quivering body. She instantly grabs your shoulders, lust burning in her eyes. You wrap your arms around her, drawing her back against your chest and lifting her off the ground. She is facing away from you, but you can tell by the way she's responding that she is ready for whatever you're going to do to her. You begin by shifting one of your arms to hold her around her stomach, while your other hand begins working on her small but tender breasts. You begin to nibble at her ear, occasionally kissing her neck. The naga responds by wrapping her tail around your lower body, gently rubbing her sensitive underbelly against your " + player.skin() + ".", false);
				//(If PC is Herm i.e. Has a cock(s))
				if (player.gender == 3) outputText("  As her tail gently squeezes your body, it draws your own " + player.multiCockDescriptLight() + " up against your body, her soft underbelly stimulating the sensitive skin.", false);
				outputText("  With the added support, you are able to move your arm away from her stomach, moving your hand down to her covered snatch. It isn't hard to find as there is practically a river of her juices dripping from it. You peel away the scaly covering, and reveal her soaking wet lovehole. As you begin to play with her engorged clit, her soft moans begin to become more pronounced and you can feel her tail begin to wrap more tightly around your body. You feel a strange sensation as her tail brushes past your own " + player.vaginaDescript(0) + ", causing you to tense up a bit. It seems that she noticed, because she does it again a few seconds later. As she begins to rub your " + player.vaginaDescript(0) + " with her tail, your body begins to betray your own lusts.\n\n", false);
				outputText("She begins to gently toy with your " + player.clitDescript() + " using the very end of her tail, flicking it back and forth. You can't help but start moaning softly yourself. You respond by slowly teasing two of your fingers inside her waiting pussy, slowly beginning to move them in and out. As you begin to accelerate the motion of your fingers, the naga steps it up as well, sliding the tip of her tail inside your " + player.vaginaDescript(0) + ".  ", false);
				player.cuntChange(20,true,false,true);
				outputText("You and the naga remain entwined like this for what seems like hours; your fingers buried inside her pussy, her tail buried inside yours", false);
				//(If PC is Herm i.e. Has a cock(s)){
				if (player.gender == 3) outputText(" and your " + player.multiCockDescriptLight() + " constantly stimulated by the tail wrapped around your body", false);
				outputText(". As you accelerate your finger-thrusts, you can feel her approaching climax, and she begins to accelerate her own motions in response. It only takes a few more minutes before you feel she's ready to cum. Suddenly she throws herself free from your grasp, turning her body one hundred and eighty degrees, and plants a kiss firmly on your lips. As she begins to passionately make out with you, your tongues intertwining and your lips interlocking in a heated show of lust for each other. She begins to climax, her muscles tensing and her tail beginning to writhe inside your " + player.vaginaDescript(0) + ". Soon, the both of you are experiencing wonderful, simultaneous orgasms, each driving the other onwards. Finally, after several minutes of bliss, the two of you finally separate, the sexually exhausted naga slumping to the sandy earth, her desires fulfilled. She looks up at you meekly, her eyes showing a sort of gratitude that words might never be able to describe. She turns her back, and slithers slowly away, a trail of her love juices tracing her path through the sand.\n\n", false);
			}
			else {
				outputText("No matter how hard you try, you can't think of a way to make this work.  You give up for now, disatisfied.\n\n", false);
			}
		}
		//a) Uncorrupted
		if (player.cor < 50) {
			outputText("The lust within you builds as you view the naga lying slumped on the ground in front of you, her coils twitching and tailtip marking the sand. Stepping forward, you gather her human half into your arms and she moans weakly as your breasts rub against hers. Smiling, you languidly lick her neck, her skin smooth and dry beneath your tongue.  Reaching down, you grab the end of her tail and bring it to your dripping pussy, rubbing it back and forth across your entrance.  Reviving under your caresses, the beautiful snake-lady rises, slowly circling you, winding herself around you again and again as you continue to use her tailtip to stimulate yourself. She comes to a stop, her coils now loosely around half your body, as she once again faces you, her tail twitching hungrily in your grasp.  You lean forward to kiss her, caught up in the moment, not caring of her fangs, as her tail twitches out of your grasp and suddenly spears upwards; you gasp and moan in pleasure as it dives into your moist pussy.  ", false);
			player.cuntChange(20,true,false,true);
			outputText("Once again grinding your body against hers, your stiff nipples rub against one another, eliciting more moans from the both of you.  Her coils tighten slowly, squeezing your body in a tight hug as her tail thrashes wildly inside you, driving you closer and closer to your limit.  With a scream of ecstasy, you climax, your juices spurting out and coating her tail, your arms squeeze her tightly as you continue to cum.  The naga slowly unwinds herself, smiling somewhat shyly at you as you stand there, panting, before slithering off into the sands, your moisture on her scales quickly drying in the arid desert heat.\n\n", false);
		}
		//b) Corrupted
		else {
			if (player.findStatusEffect(StatusEffects.MeanToNaga) < 0) player.createStatusEffect(StatusEffects.MeanToNaga,0,0,0,0);
			outputText("As you watch the writhing form of the defeated naga, you cannot help but feel turned on by it. You step forward, grabbing the naga by the shoulders and forcing her down against the sand, face up. Then, pinning her arms under your knees, you straddle her chest, crushing her modest breasts against her constricted ribcage. You can already see the panic in her face as you " + (player.armorDescript() != "gear" ? "begin to unfasten the lower part of your " + player.armorDescript() : "present your naked body to the naga.") + ". Once your dripping-wet pussy is exposed to the dry desert air, you pull up the naga's head by her hair and pull it close to your hot snatch. \"<i>C'mon, you horny little snake-tailed slut, what are you waiting for?</i>\" The naga remains frozen in a panic, not sure what to do. As encouragement you tug at her hair, pulling her head even closer to your " + player.vaginaDescript(0) + ". \"<i>I said LICK IT!</i>\" you shout, rubbing your " + player.vaginaDescript(0) + " into her face. Finally, the naga gets the message and her thin tongue darts from her mouth, making contact with your hot flesh. You shudder with excitement as the slick surface brushes past your " + player.clitDescript() + " and along your slit. As one hand manages the naga's head, you move your other hand to your breasts, beginning to squeeze and massage them with reckless abandon. As the naga continues to lick at your " + player.vaginaDescript(0) + ", you begin to gently buck your hips, bouncing up and down on her chest and forcing the air from her lungs. She squeaks every time this happens, in obvious discomfort.\n\n", false);
			outputText("Her face is beginning to turn red, and her breath is shortening by the second. Yet, you find all this very arousing. Instead of letting up, you force yourself onto her even more, pushing your " + player.vaginaDescript(0) + " up and grinding it against her face. You continue to moan and play with your breasts in the meantime, your climax drawing closer with every tongue stroke. The naga's tongue eventually finds its way inside your " + player.vaginaDescript(0) + ", its forked tip tickling your soft walls as it advances forwards. All the while the naga is desperately sucking at your " + player.clitDescript() + ", in an attempt to satisfy you, and possibly save herself. Your eyes roll back in your head and you throw your head back as an orgasm finally takes your body. You yell with delight as the naga's tongue tickles your insides, your girlcum splashing all over her face and dripping down into the dry sand below. As your climax slowly fades, you finally get up off the naga, which is met by a large gasp of relief. However, you are not done yet. You weren't going to suffocate your new fucktoy, now were you? After recovering from your first of hopefully many orgasms, you move back overtop the girl, this time straddling her face and facing the opposite direction. Your dripping snatch covers her face, situated directly above her mouth. The naga's arms are still pinned down by your legs at this point, and her tail is simply too weak after the fight to be of much help.\n\n", false);
			outputText("As you kneel over her face, you realize that if you bend forward enough, the naga's pussy is available to play with. After you manage to get the naga girl to begin licking and poking at your " + player.vaginaDescript(0) + ", you turn your focus to her semi-protected pussy. You peel away the thick covering, revealing her hot, moist fuckhole, and a thousand evil things jump to mind. Forming your hand into a spear shape, you begin to tease her tight slit. You can hear her as her muffled moans are drowned in your " + player.vaginaDescript(0) + ", and it brings a smile to your face. \"<i>Yeah, you like that, don't you? You scaly little...</i>\"  You begin to push your hand into her rather unprepared lovehole, to which she responds by flailing her tail about, trying in vain to shake you off. You keep pushing, until your arm is buried elbow-deep inside her. As you begin to fist-fuck her pussy, you can hear her wail into your " + player.vaginaDescript(0) + ", obviously complaining about the rough treatment. You continue like this for several minutes, with the naga's pussy becoming ever wetter and her moans becoming ever more earnest.\n\n", false);
			outputText("You stop after what you think is her third climax, pulling your arm almost all of the way out. You lean forward, lifting your " + player.vaginaDescript(0) + " from her face a little. You push even deeper, and are able to reach all the way to her cervix, your closed fist coming to rest against it. You slowly begin to move your fist in and out, getting faster as time progresses. After about a minute or two of this progressive increase, you're fist-fucking her so fast that you're practically punching her cervix, causing her to squeal and try to get away. As her mouth bashes against your " + player.clitDescript() + ", her forked tongue caressing you from inside your " + player.vaginaDescript(0) + ", you find yourself nearing your climax. You right yourself, putting one arm to the sand for balance, and moving the other to begin massaging your breasts.\n\n", false);
			outputText("It doesn't take much; soon your hips are bucking, bashing into the naga's face, your " + player.vaginaDescript(0) + " coating her face with your love juice. Your mission accomplished, you decide to wrap things up. As soon as you recover, you grab the poor naga's tail, and begin shoving it roughly into the naga's pussy. She wails in protest with each violent thrust, but at this point she is too weak to resist. You push inch after inch inside her, until you meet a sort of wall, what you can only assume is her cervix.", false);
			//(If str > 50)
			if (player.str > 50) {
				outputText("  You begin to push harder, trying to force your way through into her womb.  With a sudden surge forwards which prompts another loud wail from the naga, you finally enter her womb. However, you do not stop. You begin to push even more of her tail inside her, forcing so much in that it begins to cause her stomach to distend. Finally, after several feet of tail have disappeared inside her, you ease off. The naga is lying in the sand, bawling her eyes out at the immense discomfort of such an act.", false);
				//(If high corr)
				if (player.cor > 80) outputText("  As a parting gift, you kick sand in her face, and walk away without a care in the world.", false);
				//(If low corr )
				else outputText("  You think to yourself, \"<i>Was all that really necessary?</i>\"  But, in the end you decide that yes, it was.", false);
			}
			outputText("\n\nYou return to camp, satisfied with your actions.\n\n", false);
		}
	}
	outputText("You think it would be a very good idea to come to the desert more often.", false);
	player.orgasm();
	combat.cleanupAfterCombat();
	return;
}

private function nagaVictoryGenderless():void {
	clearOutput();
	//c)Centaur
	if (player.isTaur()) {
		outputText("You prance over to the prone form of the snake woman, plotting just what you will do to her body before realizing the severe lack of parts to use on her. You let loose a snort of frustration and paw at the ground. This complicates things, but you aren't going to let a little thing like having no genitalia stop you from having some fun.\n\n", false);
		outputText("You position yourself over the uppermost part of her tail and lower yourself down onto her, the lower half of your body resting on her tail. You reach down to the scaly covering over her pussy and open it to reveal the soft folds inside. Gently you slide your tongue into her, making small circles every so often.\n\n", false);
		outputText("A hiss of pleasure escapes from the naga's mouth as she brings her hands onto your head and grips you tightly. The lower portion of her tail wraps gently around you and she brings the tip of her tail up to your mouth. You shift your attention from her netherlips to start sucking on the tip of it, twirling your tongue around it sensually. After a moment, the naga takes her tongue out of your mouth and slides the now lubricated tail gently into your backside. You let out a slight gasp, but it is cut short as the naga brings your head back down to her pussy. You start licking again as the naga slides more of her tail into you, twitching the tip of it deep inside of you.\n\n", false);
		outputText("You speed up your licking and thrust your tongue deeper into her, her walls now slick. She presses your face deep into her pussy as her hips buck in orgasm.\n\n", false);
		outputText("The tail of the naga slides out of you as she lies back in the sand of the desert, exhausted from her orgasm. You stand up and gather your things, thinking that maybe it wouldn't be too bad of an idea to come back.\n\n", false);
	}
	//a)Uncorrupted
	else if (player.cor < 50) {
		outputText("You look down at the collapsed naga, feeling the blood pounding hotly through your veins. You stand above her fallen form and start to take off your pants when you remember that you have nothing down there. A soft curse escapes your lips; this will make things much more difficult, but there WILL be sex one way or another.\n\n", false);
		outputText("You straddle the naga, placing your bare, featureless crotch against the slit of her vagina. Slowly you rock your hips back and forth against her, drawing out a gasp of pleasure from her. Leaning over her you start to massage her breasts.\n\n", false);
        outputText("The naga's pussy starts to grow slick with her juices as you speed up your rocking. Her tail starts to curl around you, slowly inserting it into your ass as you continue to rock against her. You speed up your grinding, going faster and faster until a scream of pleasure erupts from the naga as she bucks her hips in orgasm.\n\n", false);
        outputText("You stand up over her, your crotch now wet from her girl cum. You pick up your things and put your clothes back on, leaving the naga lying there in bliss.\n\n", false);
    }
    //b)Corrupted
	else {
		if (player.findStatusEffect(StatusEffects.MeanToNaga) < 0) player.createStatusEffect(StatusEffects.MeanToNaga,0,0,0,0);
        outputText("An evil grin crosses your face as you stand over the fallen snake woman, the thrum of your heartbeat pounding against your ears. A myriad of the terrible things you are about to do to her cross your mind as you start to take off your pants when you remember that you have nothing to do those things with. Your cries of damnation are loud enough to be heard from miles away.\n\n", false);
  		outputText("But you can't give up now. You've gotten this far, now you need to finish the deed. At the end of this, there WILL be sex.\n\n", false);
        outputText("You thrust yourself on top of her and roughly open the scaly covering at her crotch, revealing her awaiting pussy. You bring your mouth over her opening and thrust your tongue deep inside. A mix between a whimper and a moan escapes the naga's lips as you twist your tongue deeper inside her, as though trying to taste every part of her.\n\n", false);
        //(If player has no fangs)
		if (player.faceType != FACE_SNAKE_FANGS) {
			outputText("You feel her start to thrust her hips into your face to try to gain more pleasure, but you won't be having ANY of that. You quickly take your tongue out of her and move your way up to her breasts, groping at them and biting at her nipples. The naga cries out in pain and tries to push your head away. You give her one last bite, hard enough to draw blood from her before getting up.\n\n", false);
	        outputText("The naga quickly slithers out from under you with an angry hiss, a hand pressed to her now bleeding breast. You chuckle at this and the naga turns to glare at you. There is a sudden pain on the back of your legs and your view shifts to looking at the sky above you. It takes a moment for you to realize that the scaly bitch has just tripped you with her tail before slithering away.\n\n", false);
		}
        //(if player has fangs)
		else 
       	{
			outputText("You reach up, pulling her head down to the ground by her hair. You then flip her body over, and straddle her, leaning in far enough to wrap your mouth around her neck. You hold her head steady as you slowly punch four neat holes in her neck with your fangs. She struggles; even with her innate poison resistance, there's no way she could take such a dose without feeling its effects. Her struggles become weaker and weaker, as well as her voice. This gives you a beautiful opportunity to try something new. You flip your body around, so your head is hanging above her hot snatch, and your feet pin her arms down. You spread her tight pussy lips with one hand and, forming a spear shape with your other hand, attempt to force all your fingers inside her at once. She tries to resist but, subdued by your venom, she is helpless as your hand and then your entire arm, disappears inside her. Tears begin to form in her eyes as she realizes you have complete control over her and that she is helpless to stop you. You fist-fuck her for several minutes before you begin to feel weak contractions squeeze your arm. Having brought her to a humiliating orgasm, you see little purpose in staying, leaving the helpless, sobbing naga on the sand, your fist soaked in naga love-juice. You return to camp, your sick fist-rape fantasy fulfilled.\n\n", false);
		}
	}
	outputText("You think it would be a very good idea to come to the desert more often.", false);
	player.orgasm();
	combat.cleanupAfterCombat();
	return;    	
}

internal function nagaFUCKSJOOOOOO():void {
	clearOutput();
	//BIMBO!  LIKE, TOTALLY AWESOME AND CUM!
	//[Naga-on-Female Bimbo Loss Scene]
	if ((player.findPerk(PerkLib.BimboBrains) >= 0 || player.findPerk(PerkLib.FutaFaculties) >= 0) && player.hasVagina()) {
		outputText("You fall to your knees, like usual, your sexy form shaking with desire.\n\n", false);

		outputText("The naga slowly approaches you with a smile of delight, devouring you with her eyes like the easy little thing you are. When she is close enough, she slides her tail under you and brings you closer to her. As she hisses in your ear, a chill goes down your spine: You don't understand a word she is saying. That seems to happen a lot with your tiny brain, but at least you can tell by the tones that she won't be going easy on you. Your nipples harden at the thought, and your " + player.vaginaDescript(0) + " agrees. Now astride the base of her tail and facing towards her, your eyes are directed to her crotch where a scaly covering rests where you would guess -- if you had the brains -- that a vagina should be. The naga brings a hand down and gently starts caressing this nether region. You know exactly what she is doing, and you, like, totally feel the need for sex with her burn inside you. You quickly strip yourself of your " + player.armorName + " and throw yourself brainlessly onto her awaiting pussy. Without any complaints whatsoever, you pull her lips apart and start licking, looking up at her wide-eyed and 'O'-lipped between licks.\n\n", false);

		outputText("Slowly you move your tongue around her folds, hearing her soft moans of arousal. Bringing your perky lips to the bottom of her slit, you gently kiss at it, carefully working your way up to the top. You pause a moment once at the top to plant a porn-star-like kiss on her clit and feel her twitch slightly before you make your way back down to her glistening cunt and lick at the moisture, savoring its taste as if it were your only food.\n\n", false);

		outputText("You continue your assault on her love canal as the naga's moans gradually become louder. Her hands make their way to your head and she curls her fingers through your " + player.hairDescript() + " to get a better grip on your air-filled head as you bring your mouth up to her clit. You give one final, slow lick up the length of her pussy and twirl your tongue around her now engorged bud. The naga involuntarily bucks her hips into your face as you start to suck on her " + player.clitDescript() + ". As you continue to play with her clit, she begins to lose control, grinding her soaking pussy against your face. She forces herself onto you so hard, it becomes hard to breathe, but thankfully you've had a bit of practice with this sort of thing, so the warm juices of her excited love-slit don't bother you. After a while, you attempt to pull away from her hot snatch, pulling your mouth from her swollen clit. She pushes you back down upon it. You roll your eyes and giggle lightly, sending vibrations through her clit that make her moan. The feeling of your warm, wet, bimbo lips as they rub against her clit is apparently just enough for her as it pushes her past her limit, sending her into a passionate orgasm. You finally pull away from her as her body is wracked with powerful contractions, wiping the excess ladycum from your face, which is stuck in a dumb-looking, open mouthed stare.\n\n", false);

		outputText("After the naga manages to calm herself, her breathing becoming regular and her muscles loosening up, she smiles a genuine grin and hisses something to you. She leans in close, her head only inches from your and suddenly shifts her tone, adopting a much more seductive one. She pulls you into an upright position, facing her, your " + player.allBreastsDescript() + " pushed up by her snake-like coils. Your " + player.vaginaDescript(0) + " rubs against her tail's scaly skin as she moves her own body closer to yours. She wraps the end of her tail around so that it stands erect between the two of you. The naga hisses something at you, and, seeing the brain-dead look on your face, begins to demonstrate what she means. She leans in close to her tail and begins to run her thin tongue along its length, as far as she can. Now THIS you are able to, like, understand! You run your tongue along her smooth, scaly, tail-tip.\n\n", false);

		outputText("You do your, like, very best to follow her lead, but you just, like, don't get why she's doing it! Eventually, she stops, and nudges you to do so as well. Like... whatever...\n\n", false);

		outputText("The naga then lies flat on the sandy ground, pulling you down with her. She lays you down on her body, face up, with your head resting on her soft breasts. She reaches around your body, placing her soft hands on your own " + player.allBreastsDescript() + ", gently holding you in place as her tail moves closer to your " + player.vaginaDescript(0) + ". Her now slick tail begins to rub against your clit and as the scaly skin runs along your " + player.clitDescript() + ", you begin to moan air-headedly. There is no holding it back, this feeling is one of the best you have experienced. Her tail continues to flick and rub your clit as you begin to buck your hips gently. The naga pokes and rubs at your hard clit for some time, eventually driving you to the first of many coming orgasms. After your breath has become even again and your muscles have relaxed, the naga resumes her advances. She begins to rub the tip of her tail up and down along your " + player.vaginaDescript(0) + ", and you FINALLY get what she is trying to do.\n\n", false);

		outputText("As the tail begins to penetrate you, you cannot help but let out another passionate, bimbo-like moan.", false);
		//Take virginity.  Proper stretching further down.
		player.cuntChange(1,true,true,false);
		outputText("  The scaly skin rubs at your soft vaginal walls like nothing else you have experienced, and the feeling begins to drive you mad with pleasure. It only takes a few minutes of this gentle tail-fucking to drive you to another climax. This time, however, the naga doesn't wait for your recovery. Instead, she responds by plunging deeper, forcing her ever-thickening tail deeper inside your " + player.vaginaDescript(0) + ". As she stuffs more and more of her scaly tail inside you, her hands begin to work on your " + player.nippleDescript(0) + "s, gently caressing and massaging them.\n\n", false); 

		//[If Lactating]
		if (player.lactationQ() >= 50 && player.biggestLactation() >= 1) outputText("Your warm milk is leaking from your " + player.nippleDescript(0) + "s the entire time, coating your skin and soaking her hands. At one point, she withdraws a hand and licks the milk from it. You can only assume that she liked it, as she begins to focus even more on your breasts.\n\n", false);
		//-------
		
		outputText("The naga lifts you from her body with her tail, placing you onto the warm sand where she had been laying. She moves her own body above yours, her tail buried deep inside your " + player.vaginaDescript(0) + " the entire time. She holds you in place with one hand, her other hand moving to resume playing with your " + player.allBreastsDescript() + ". She moves her head in, her hot breath washing over your neck, and looks up into your eyes for a moment. She smiles, giggles, and then wraps her mouth around your " + player.nippleDescript(0) + ", letting her slender tongue tickle your sensitive areola.\n\n", false);
		//-----
		
		//[If lactating] 
		if (player.lactationQ() >= 50 && player.biggestLactation() >= 1) outputText("As her mouth sucks and plays with your nipple, your warm, sweet milk begins to flow forth once again, filling her mouth with your delectable cream. Her hand is also absolutely covered by it, and the excess drips down to the dry sand below, absorbed in seconds by the thirsty earth.\n\n", false);
		//------

		outputText("All this time, her tail has been working its way slowly inside you, stretching you farther with every thrust. As you open your mouth wide to let out another passionate wail, she moves in, pushing her lips over yours and kissing you passionately.\n\n", false);

		//----
		//[If Lactating]
		if (player.lactationQ() >= 50 && player.biggestLactation() >= 1) outputText("She shares a mouthful of your delicious milk with you.\n\n", false);
		//------
		
		outputText("As the tip of her tail finally comes to rest against your cervix, you find yourself succumbing to another orgasm, your slutty wails of pleasure encouraging the naga to continue. As you begin to calm down again, you believe that this is the deepest the naga will go, although your brain works really hard and comes up with a desire for MORE depth...", false);
		//PROPER stretched.
		player.cuntChange((player.vaginalCapacity() + 5),true,true,false);
		outputText("\n\n", false);
		
		outputText("Then, like, your wish totally comes true! The naga's tail begins to bash itself against your cervix, searching for the weak point. Her hands hold you steady as her thrusts begin to increase in intensity. It's not long into this rough tail-fucking that you find yourself on the verge of orgasm again, totally turned on by the sight of your own " + player.allBreastsDescript() + " bouncing as she fucks you. The naga grits her teeth, and, with one last, powerful thrust, forces her tail inside of your womb, pushing through your well-pounded, well-used cervix. She manages to stuff enough tail inside you to cause a visible bulge in your stomach. This combination of sensations is too much for your tiny brain, and sends your head spinning as your climax reaches its peak. Your already weak mind slips even further, your vision fading. The last thing you see is the naga's smiling face, her cheeks flushed and her eyes full of passion.", false);
	}
	//a) male (slightly modified could be good for centaurs 
	//too)
	else if (player.gender == 1 || (player.gender == 3 && rand(2) == 0)) {
		//(If defeated by lust)
		if (player.lust >= player.maxLust()) outputText("You fall to your knees, your body shaking with desire.\n\n", false);
		//(If defeated by KO)
		else outputText("You fall to your knees, your battered body unable to hold itself up any longer.\n\n", false);
		outputText("You hear the hiss of the naga's laughter as she slithers over to your prone form. Her long tail twists around you and tightens suddenly, pinning your arms to your sides", false);
		//(if centaur)
		if (player.isTaur()) 
		{ 
			outputText(" and clamping your legs to your stomach", false);
		}
		outputText(". You struggle weakly against her grip, but ", false);
		//(if defeated by lust)
		if (player.lust >= player.maxLust()) outputText("all your resistance seems to do is make your " + player.cockDescript(0) + " harder.", false);
		//if defeated by KO)
		else outputText("you are too weak to do anything to stop her squeezing.", false);
		outputText("  She leans towards you, gripping your shoulders as she brings her face to your ear. You can feel her serpentine tongue flicking over your ear as she hisses coldly into it.\n\n", false);
		
		outputText("The only thing running through your mind is a memory from your childhood. A memory of a snake you once saw with a bird wrapped in its tail, squeezing it more and more as the pitiful trapped creature struggled just to breathe. You remember watching as it slowly stopped moving and the snake made its move, opening its maw to swallow the small morsel whole. This is not how you thought your time as champion would end; being eaten by a snake girl was very low on your list of ways to die.", false);
		//(if player is corrupt)
		if (player.cor > 75) outputText("  The thought somehow makes your " + player.cockDescript(0) + " throb even more.", false);
		outputText("\n\n", false);
		outputText("You close your eyes and ready yourself to meet your fate. Instead, you feel the hand of the naga at your crotch, sliding your " + player.armorName + " down to give her better access to your " + player.cockDescript(0) + ". A gasp of surprise escapes you as the naga grabs ahold of your " + player.cockDescript(0) + " and starts to stroke it, licking at the " + player.cockHead() + " with her serpentine tongue. You moan as she quickens her pace, causing a wave of heat to rise through your shaft.\n\n", false);
     
		//(Cock fits)
		if (player.cockArea(0) <= monster.vaginalCapacity()) {
			outputText("She stops suddenly and you look at her, a pleading look in your eyes despite yourself. The naga isn't done with you yet, and she makes this known by opening up the scaly slit at her crotch to reveal her moist cunt. She rubs the opening on to the " + player.cockHead() + " of your " + player.cockDescript(0) + ", teasing your throbbing member before slowly sliding it in. She carefully lowers herself onto you, swallowing up the first few inches of your " + player.cockDescript(0) + ". Her hips slide back, before bringing them back down and sliding more of your cock into her. She continues to gently swallow more of you inside of her, the folds of her love canal massaging you with each progressive thrust. Finally there is no more of you that she can push into her, her stomach presses against you in an attempt to try to bring more of you inside her.\n\n", false);
    		outputText("You feel the hands of the snake woman firmly grab your shoulders and watch as she pulls away from you, shouting with pleasure as she thrusts herself down on the full length of your shaft. Unable to move or do anything to help her, you watch helplessly as she manipulates your body, her slick netherlips completely enveloping your " + player.cockDescript(0) + ".  Again and again she thrusts her hips onto your " + player.cockDescript(0) + ", her pussy squeezing you almost as tightly as her tail. She continues to impale herself on your " + player.cockDescript(0) + ", her thrusts becoming more intense by the moment. Finally she gives one last squeeze and tilts her head back with a yell. Unable to hold back, her tight walls begin to convulse, squeezing your " + player.cockDescript(0) + " tighter than ever before. You can feel a pressure welling up inside as her soaking pussy attempts to milk your " + player.cockDescript(0) + " of its tasty seed. You try to hold back, but it's no use. As she continues to pump at your " + player.cockDescript(0) + ", a torrent of warm, sticky cum ", false);
			//Cum variants
			if (player.cumQ() < 250) outputText("pours", false);
			else if (player.cumQ() < 1000) outputText("spurts", false);
			else outputText("erupts", false);
			outputText(" into her body. She ", false);
			//(Normal)
			if (player.cumQ() < 250) outputText("moans and pants", false);
			//(Lots of cum)
			else if (player.cumQ() < 1000) outputText("squeals with joy", false);
			//(It's gonna take weeks to clean this up!)
			else outputText("screams in delight", false);
			outputText(" as your hot, gooey sperm ", false);
			//(Normal)
			if (player.cumQ() < 250) outputText("coats her womb.", false);
			//(Lots of cum)
			else if (player.cumQ() < 1000) outputText("completely fills her.", false);
			//(Indonesia called, they're flooded again)
			else outputText("absolutely engorges her, with the excess spurting out in torrents from her pussy.", false);
		}
		//(Cock too big)
		else {
			outputText("As she continues to stroke your " + player.cockDescript(0) + ", her nimble fingers doing their best to wrap around your prodigious girth, she moves her head in closer to wrap her lips around the tip of your " + player.cockDescript(0) + ". She begins to gently suck at the head of your " + player.cockDescript(0) + ", her thin, reptilian tongue dancing across the slick surface. ", false);
			//(if PC has balls)
			if (player.balls > 0) {
				outputText("She shifts one of her hands down from your " + player.cockDescript(0) + ", to your " + player.ballsDescriptLight() + ", cupping them in her slick palm.  ", false);
			}
			outputText("As her tongue continues to slide across the " + player.cockHead() + " of your " + player.cockDescript(0) + ", her slender tongue wanders ever so closely to the center. You feel a strange sensation as her tongue wanders inside the hole at the tip of your " + player.cockDescript(0) + ", just barely tickling the inside. You try to pull away, but her tail binds you too tightly to move much. The naga notices your reaction and begins to exploit it as much as she can. She begins to force the rest of her tongue inside of your urethra, her forked tip tickling you from the inside as she pushes deeper. The naga, now that her tongue is completely buried inside your " + player.cockDescript(0) + ", turns her attentions to the actual shaft, attempting to sandwich it between her modest C-cup breasts. She begins to stroke them up and down along your " + player.cockDescript(0) + ", sucking at the " + player.cockHead() + " and tickling your urethra at the same time.\n\n", false);
			outputText("As violated as you are at the moment, you cannot deny the wonderful sensation the naga is creating, and after only a short time of being subjected to this bizarre act do you feel that familiar pressure building up inside your groin. It is only moments before your sticky seed begins to flow forth into her mouth. ", false);
			//OH SHIT MOAR CUM
			//(Normal)
			if (player.cumQ() < 250) outputText("The naga manages to hold the warm cum within her mouth, only causing her cheeks to bulge a little.", false);
			//(Lots of cum)
			else if (player.cumQ() < 1000) outputText("The naga's cheeks balloon as her mouth is filled with your hot, gooey sperm, forced to swallow some of it as her cheeks reach their full capacity.", false);
			//(Cumception, we need to go deeper)
			else outputText("Hot semen blasts from the naga's nose as her mouth is completely filled in seconds. Much of your warm cum is forced down her throat and into her stomach, causing it to distend slightly within her thin frame.", false);
			outputText("  The naga pulls away, her tongue slowly sliding from your " + player.cockDescript(0) + " and dripping with cum, allowing the last few drops of cum to splash across her face and breasts. Her cheeks are still full of seed and  as she moves in closer, you wonder what she has planned. She grabs your shoulders with her still-slick hands, and leans in all the way for a final, passionate kiss. As your lips are pushed apart by her own, you feel a large amount of your still-warm sperm enter your mouth. You try to resist, but she begins to massage your throat, forcing you to swallow it all.\n\n", false);
    		//(If you've been a bad boy during victory scenes)
			if (player.findStatusEffect(StatusEffects.MeanToNaga) >= 0)
				outputText("As you gulp down a mouthful of your own seed, you notice something strange about it. The taste, there is something about it, it tastes almost like... POISON! You gag, but it's too late. The naga pulls away, wiping the last drips of cum from the corner of her mouth, and smiles mischievously as your vision begins to fade. The last thing you see is her face, with a look of complete satisfaction stretched across it.  With that last vision, the poison takes its effect, and you pass into unconsciousness.", false);
			//(If you've been nice to her: Default setting)
			else 
				outputText("You end up enjoying the whole thing. She then gets back up and leave you there, not without looking back. You stay there, lying on the sand for a few moments before you doze off in a nap.  After you wake, you finally decide to head back to your camp.", false);
		}
	}
	//b) female //http://nekomimichan.org/mg/src/12844585127.jpg
	else if (player.hasVagina()) {
		//(If defeated by lust) 
		if (player.lust >= player.maxLust()) 
		{
			outputText("You fall to your knees, your body shaking with desire.\n\n", false);
		}
		//If defeated by KO)
		else 
		{
			outputText("You fall to your knees, your battered body unable to hold itself up any longer.\n\n", false);
		}
		outputText("The naga slowly approaches you with a smile of delight, devouring you with her eyes like the helpless morsel you are. When she's close enough, she slides her tail under you and brings you closer to her. As she hisses in your ear, a chill goes down your spine: you don't understand a word she is saying, but you can tell just by the variations that this lovely lady won't be going easy on you, ", false);
		//(if corrupted)
		if (player.cor > 50) 
		{
			outputText("and the sheer thought of it is making you wet already.  ", false);
		}
		//(if uncorrupted)
		else outputText("and while you know you probably won't like it, your " + player.vaginaDescript(0) + " says otherwise.  ", false);
		outputText("Now astride the base of her tail and facing towards her, your eyes are drawn to the place on her scaly pelvis where a vagina should be. With one hand the naga begins gently caressing her nether regions, which begin to swell in her excitement into the outlines of a recognizable reptilian vulva. Her expectations are perfectly clear ", false);
		//(If defeated by lust) 
		if (player.lust >= player.maxLust()) 
		{
			outputText("and you can feel the need to have sex with her burn inside you. You quickly strip yourself of your " + player.armorName + " and throw yourself on her awaiting pussy.", false);
		} 
		//(If defeated by KO)
		else 
		{
			outputText("and you're too weak to resist anyway; you might as well just comply. You attempt to remove your " + player.armorName + " before the naga grabs you in pity and decides to help you with it. Now naked,  she lays you down on her tail and you let her guide you to her awaiting pussy.", false);
		}
		outputText("  Without any further complaints, you pull her lips apart and start licking. The creature lets out a sigh of pleasure as you move your tongue around the outside of her netherlips.\n\n", false);
		
		outputText("Slowly you move your tongue around her folds, hearing her soft moans of arousal. Bringing your lips to the bottom of her slit, you gently kiss at it, carefully working your way up to the top. You pause a moment once at the top to plant a gentle kiss on her love button and feel her twitch slightly before you make your way back down to her glistening cunt and lick at the moisture, savoring its taste.\n\n", false);
		
		outputText("You continue your loving assault on her love canal as the naga's moans gradually become louder. Her hands make their way to your head and she curls her fingers through your " + player.hairDescript() + " to get a better grip on your head as you bring your mouth up to her pleasure buzzer. You give one final, slow lick up the length of her pussy and twirl your tongue around her now engorged clit. The naga involuntarily bucks her hips into your face as you start to suck on her pleasure buzzer. As you continue to play with her clit, she begins to lose control, grinding her soaking pussy against your face, and vice-versa. She forces herself onto you so hard, it becomes hard to breathe, and the warm juices of her excited love-slit coat your face. ", false);
		//(If you are a naughty girl)
		if (player.cor > 80) {
			outputText("You attempt to bite at her clit, in an attempt to have her let off a bit, but instead of causing her to pull away, it drives her over the edge, sending her into a crushing climax. She squeals and her hips begin to buck with more ferocity than ever before. Her warm reptilian love juices fill your mouth and splash across your face and upper body, and she hisses something, which you can only assume is encouragement.", false);
		} 
		//(If you are a good girl)
		else {
			outputText("You attempt to pull away from her hot snatch, pulling your mouth from her swollen clit. She overpowers you, pulling your face back down upon her lovebuzzer. The feeling of your warm, wet lips as they rub against her clit is apparently just enough for her as it pushes her past her limit, sending her into a passionate orgasm.", false);
		} 
		outputText("  You finally pull away from her as her body is wracked with powerful contractions, wiping the excess ladycum from your face.\n\n", false);
   		
		outputText("After the naga manages to calm herself, her breathing becoming regular and her muscles loosening up, she smiles a genuine grin and hisses something to you. She leans in close, her head only inches from yours and suddenly shifts her tone, adopting a much more seductive one. She pulls you into an upright position, facing her. Your wet pussy rubs against her tail's scaly skin as she moves her own body closer to yours. She wraps the end of her tail around, so that it stands erect between the two of you. The naga hisses something at you, and, realizing that you don't understand a word she says, begins to demonstrate what she means. She leans in close to her tail, and begins to run her thin tongue along its length, as far as she can. Understanding what she means, you join her, your own tongue running across her smooth, scaly tail tip.\n\n", false);
		
		//(If you are a bad girl)
		if (player.cor > 50) {
			outputText("You close your eyes, and imagine that the tail is just another big cock to be sucked. You begin to suck at the tip, as well as run your tongue up and down along its length.  ", false);
		} 
		//(If you are a good girl)
		else {
			outputText("You do your best to follow the naga's example, but you are not sure why she is doing it.  ", false);
		} 
		outputText("Eventually, it appears that the naga is satisfied, and she stops, nudging you to do so as well.\n\n", false);
		
		outputText("Then the naga lies flat on the sandy ground, pulling your body down onto on hers, face up, with your head resting between her soft breasts. She reaches around your body, placing her hands on your own " + player.biggestBreastSizeDescript() + " gently holding you in place as her tail moves closer to your " + player.vaginaDescript(0) + ". As she begins to rub her presently-slick tail against your slit, the scaly tip brushes your " + player.clitDescript() + " and you moan with passion in response.  There is no holding it back; this feeling is one of the best you have experienced. Her tail continues to flick and rub your " + player.clitDescript() + " as you begin to buck your hips gently. The naga pokes and rubs at your " + player.clitDescript() + " for some time, eventually driving you to the first of many coming orgasms. After your breath has become even again and your muscles have become relaxed, the naga resumes her advances. She begins to rub the tip of her tail up and down along your " + player.vaginaDescript(0) + ", and you finally understand her intentions.\n\n", false);
		
		outputText("As the tail begins to penetrate you, you cannot help but let out another passionate moan. The scaly skin rubs at your tender vaginal walls like nothing else you have experienced, and the feeling begins to drive you mad with pleasure. It only takes a few minutes of this gentle tail-fucking to drive you to another climax. This time, however, the naga doesn't wait for your recovery. Instead, she responds by plunging deeper, forcing her ever-thickening tail further into your " + player.vaginaDescript(0) + ". As she stuffs more and more of her scaly tail inside you, her hands begin to work on your " + player.biggestBreastSizeDescript() + ", gently caressing and massaging them.", false);
		//(If fuckable nipples)
		if (player.hasFuckableNipples()) {
			outputText("  As her hands rub across your " + player.biggestBreastSizeDescript() + ", the naga takes notice of the size of your nipples. She begins to press on them with her fingers, and, to her surprise, her fingers begin to disappear inside your breasts. It doesn't take her long to figure it out, and before you know it she is finger-fucking both your " + player.nippleDescript(0) + " in sync with the thrusts of her tail.", false);
		}
		//(If lactating)
		if (player.biggestLactation() > 1) { 
			outputText("  Your warm milk is leaking from your " + player.nippleDescript(0) + " the entire time, coating your " + player.skinDesc + " and soaking her hands. At one point, she withdraws a hand and licks the milk from it. You can only assume that she liked it, as she begins to focus even more on your breasts.", false);
		}
		outputText("\n\n", false);
		
    	outputText("The naga lifts you from her body with her tail, placing you onto the warm sand where she had been laying. She moves her own body above yours, her tail buried deep inside your " + player.vaginaDescript(0) + " the entire time. She holds you in place with one hand, her other hand moving to resume playing with your " + player.biggestBreastSizeDescript() + ". She moves her head in, her hot breath washing over your other breast, and looks up into your eyes for a moment. She smiles, giggles, and then wraps her mouth around your " + player.nippleDescript(0) + ", letting her slender tongue tickle your sensitive skin there.", false);
		//(If fuckable nipples)
		if (player.hasFuckableNipples()) {
			outputText(  "It isn't long before she decides to take it one step further, pushing her tongue inside your " + player.nippleDescript(0) + " and wriggling it around inside. Meanwhile, her other hand begins to work its way into your other " + player.nippleDescript(0) + ", finger-fucking it for all it's worth.", false);
		} 
		//(If lactating)
		if (player.biggestLactation() > 1) {
			outputText("  As her mouth sucks at and plays with your " + player.nippleDescript(0) + ", your warm, sweet milk begins to flow forth once again, filling her mouth with your delectable cream. Her hand is also absolutely covered by it, and the excess drips down to the dry sand below, absorbed in seconds by the thirsty earth.", false);
		} 
		outputText("\n\n", false);
		outputText("All this time, her tail has been working its way slowly inside you, stretching you farther with every thrust. As you open your mouth to let out another passionate wail, she moves in, pushing her lips over yours and kissing you passionately", false);
		//(If lactating)
		if (player.biggestLactation() > 1) {
			outputText(", sharing with you some of your delicious milk", false);
		}
		outputText(".", false); 
    	//(If pregnant)
		if (player.pregnancyIncubation > 0) {
			outputText("  As you finally reach your next climax, the naga pokes her tongue a little bit deeper inside your mouth, reaching to the back of your throat.", false);
			//(If you have been a bad girl in past encounters)
			if (player.findStatusEffect(StatusEffects.MeanToNaga) >= 0)
			{
				outputText("  Down this slippery rope, she drops only a few drops of her potent poison, which completely bypass your gag reflex and drop straight down your throat. You hardly notice, too busy bucking your hips against the massive tail buried within your " + player.vaginaDescript(0) + ". It's only as your vision fades that you realize that the naga has done something. She pulls away from you and hisses something into your ear. The last thing you can make out is the naga giggling as she continues to play with your breasts before your vision clouds over and your head is filled with fuzzy feelings. You black out, now nothing more than a fuckdoll for the naga to explore. She has her fun with your limp body, and eventually leaves you there, lying on the warm sand, your " + player.vaginaDescript(0) + " horribly abused by the naga's thick tail, and dripping with your own juices.", false);
			}
			//(If you've been a good girl during past encounters)
			else { 
				outputText("  She tickles the back of your throat with her tongue, massaging your " + player.biggestBreastSizeDescript() + " with her hands and thrusting her tail in and out of your " + player.vaginaDescript(0) + ". Eventually, even she gets tired and with a pop, she pulls her massive tail from your " + player.vaginaDescript(0) + ", raising the tip to her mouth and sucking on it, savoring your juices. She slides off of you, laying on the sand next to you. Exhausted, it is not long before she is asleep, a big smile on her face and a finger in her snatch. You decide to rest as well, collapsing beside her. There's no way you could make it back to camp in this condition. As you doze off, her warm, scaly body gently wraps around your own, pulling you close.  When you eventually wake up, the naga is nowhere to be seen so you simply return to camp, still somewhat tired, but rather happy.", false);
			}
		}
		//(If not pregnant)
		else {
			outputText("  As the tip of her tail finally comes to rest against your cervix, you find yourself succumbing to another orgasm, your wails of pleasure encouraging the naga to continue. As you begin to calm down again, you believe that this is the deepest the naga will go. Then, as she reaches her hand to grab your other shoulder, you realize she still has plans. Her tail begins to bash itself against your cervix, the tip searching for the weak point. Her hands hold you steady, as her thrusts begin to increase in intensity, sometimes even shaking your entire body. It is not long into this rough tail-fuck that you find yourself on the verge of orgasm yet again, as the scaly surface of her tail rubs across the soft flesh of your " + player.vaginaDescript(0) + ".  The naga grits her teeth, and, with one last, powerful thrust, forces her tail inside your womb, forcing her way through your cervix. She manages to stuff enough tail inside you to cause a visible bulge in your stomach. This combination of sensations is enough to send your head spinning and as your climax reaches its peak, you feel your mind begin to weaken, your vision fading. The last thing you see is the naga's smiling face, her cheeks flushed and her eyes full of passion.", false);
		}
		outputText("  ", false);
		player.cuntChange(40,true);
	}
	//d) genderless
	else {
		//(If player loses because of lust) 
		if (player.lust >= player.maxLust()) 
			outputText("You fall to your knees, your body shaking with desire.\n\n", false);
		//(If player loses from HP loss)
		else outputText("You fall to your knees, your battered body unable to hold itself up any longer.\n\n", false);
     	outputText("A grin stretches across the naga's face as she slithers over to your collapsed form. She coils her tail tightly around your prone form, squeezing hard enough to make it difficult to breathe. She brings her hand down to the crotch of your " + player.armorName + " and a look of confusion crosses her face before she realizes that there is nothing down there.\n\n", false);
		outputText("After a moment of chuckling, the naga brings your face down to a scaly covering at her crotch and opens it to reveal her awaiting netherlips. ", false);
		//(If player not corrupted)
		if (player.cor < 50) outputText("You try to turn your head away, but she forcefully shoves it down into her soft folds.  ", false);
		//if player is corrupted) 
		else outputText("You eagerly bring your mouth to her glistening pussy. ", false);
		outputText("You start to work your tongue around her awaiting clit, the naga moaning at the pleasure. You continue your assault on her pleasure button as her pussy begins to glisten with moisture. You move your tongue to her soft netherlips, licking softly at the moisture that coats them, enjoying the moans of pleasure that erupt from the naga. The naga's hips start to twitch as you bring your tongue up the length of her glistening slit, stopping at the top to suck gently at her clit.\n\n", false);
		
		outputText("Her tail starts to squeeze you even tighter and you start having trouble breathing, causing you to pull your head back. The naga looks down at you, begging you to continue until she realizes what she was doing all along. Slowly, she unwraps you, giving you some time to catch your breath before finishing the job.\n\n", false);
		
		outputText("You bring your mouth back to her awaiting hole and redouble your efforts. You can feel that she is nearing her peak as you continue to lick at her pussy. With a final shudder the naga climaxes, squeezing you firmly against her, coating your chin and nose with her thick honey.  As the naga relaxes her grip you slide out from her loosened tail coils.  Exhausted, you lose consciousness, but when you awake, you grab your things and leave the moistened sands behind.", false);
	}
	player.orgasm();
	combat.cleanupAfterCombat();
}

internal function nagaRapeChoice():void {
	if (monster.HP < 1) outputText("You've defeated the naga!  ", true);
	else outputText("The naga writhes in the sand, masturbating feverishly!  She's completely forgotten about fighting you.  ", true);
	
	var eggs:Function = null;
	if (player.canOvipositSpider()) eggs = eggUpANagaSpiderLike;
	if (player.canOvipositBee() && player.gender > 0) eggs = beePositANagaPlease;
	if (player.lust >= 33 && flags[kFLAGS.SFW_MODE] <= 0) {
		outputText("Your body aches for further satisfaction - do you rape the snake woman?", false);
		if (player.lowerBody == LOWER_BODY_TYPE_GOO) {
			if (player.gender == 0) simpleChoices("Yes", nagaVictoryGenderless, "Gooey Rape", gooNagaRape, "Lay Eggs", eggs, "", null, "Leave", combat.cleanupAfterCombat);
			if (player.gender == 1) simpleChoices("Yes", nagaVictoryMale, "Gooey Rape", gooNagaRape, "Lay Eggs", eggs, "", null, "Leave", combat.cleanupAfterCombat);
			if (player.gender == 2) simpleChoices("Yes", nagaVictoryFemale, "Gooey Rape", gooNagaRape, "Lay Eggs", eggs, "", null, "Leave", combat.cleanupAfterCombat);
			if (player.gender == 3) simpleChoices("As Male", nagaVictoryMale, "As Female", nagaVictoryFemale, "Gooey Rape", gooNagaRape, "Lay Eggs", eggs, "Leave", combat.cleanupAfterCombat);
			return;
		}
		else {
			if (player.gender == 0) simpleChoices("Yes", nagaVictoryGenderless, "", null, "", null, "Lay Eggs", eggs, "No", combat.cleanupAfterCombat);
			if (player.gender == 1) simpleChoices("Yes", nagaVictoryMale, "", null, "", null, "Lay Eggs", eggs, "No", combat.cleanupAfterCombat);
			if (player.gender == 2) simpleChoices("Yes", nagaVictoryFemale, "", null, "", null, "Lay Eggs", eggs, "Leave", combat.cleanupAfterCombat);
			if (player.gender == 3) simpleChoices("As Male", nagaVictoryMale, "As Female", nagaVictoryFemale, "", null, "Lay Eggs", eggs, "Leave", combat.cleanupAfterCombat);
			return;	
		}
	}
	combat.cleanupAfterCombat();
}

public function nagaPlayerConstrict():void {
	clearOutput();
	if (player.fatigue + player.physicalCost(10) > 100) {
		outputText("You just don't have the energy to wrap yourself so tightly around someone right now...", true);
//Gone		menuLoc = 1;
		menu();
		addButton(0, "Next", combat.combatMenu, false);
		return;
	}
	//Cannot be used on plural enemies
	if (monster.plural) {
		outputText("You launch yourself at " + monster.a + monster.short + ", but with multiple enemies, wrapping one up would leave you completely open to attack.  You hastily slither backwards before you expose yourself to danger.", true);
		outputText("\n\n", false);
		monster.doAI();
		return;
	}
	if (monster.short == "pod") {
		outputText("You can't constrict something you're trapped inside of!", true);
//Gone		menuLoc = 1;
		menu();
		addButton(0, "Next", combat.combatMenu, false);
		return;
	}
	player.changeFatigue(10,2);
	//Amily!
	if (monster.findStatusEffect(StatusEffects.Concentration) >= 0) {
		outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.", true);
		monster.doAI();
		return;
	}
	//WRAP IT UPPP
	if (rand(player.spe + 40) > monster.spe) {
		if (monster.short == "demons") {
			outputText("You look at the crowd for a moment, wondering which of their number you should wrap up. Your glance lands upon a random demon amongst the crowd. You quickly slither through the demon crowd as it closes in around you and launch yourself towards your chosen prey. You grab him out of the sea of monsters, wrap your long snake tail around his form and squeeze tightly, grinning as you hear his roars of pleasure turn to cries of distress.", false);
		}
		//(Otherwise)
		else {
			outputText("You launch yourself at " + monster.a + monster.short + " and wrap yourself around " + monster.pronoun2+ ". You squeeze " + monster.pronoun2 + " tightly and hear " + monster.pronoun2 + " cry out in pain.", false);
		}
		monster.createStatusEffect(StatusEffects.Constricted,1+rand(4),0,0,0);
	}
	//Failure
	else {
		//Failure (-10 HPs) -
		outputText("You launch yourself at your opponent and attempt to wrap yourself around " + monster.pronoun2 + ". Before you can even get close enough, " +monster.a + monster.short + " jumps out of the way, causing you to fall flat on your face. You quickly pick yourself up and jump back. ", false);
		player.takeDamage(5, true);
		if (player.HP <= 0) {
			doNext(combat.endHpLoss);
			return;
		}
	}
	outputText("\n\n", false);
	monster.doAI();
}

public function naggaSqueeze():void {
	clearOutput();
	if (player.fatigue + player.physicalCost(20) > player.maxFatigue()) {
		outputText("You are too tired to squeeze " + monster.a + " " + monster.short + ".");
		addButton(0, "Next", combat.combatMenu, false);
		return;
	}
	//Squeeze -
	outputText("Your coils wrap tighter around your prey, leaving " + monster.pronoun2 + " short of breath. You can feel it in your tail as " + monster.pronoun3 + " struggles are briefly intensified. ", false);
	var damage:int = monster.eMaxHP() * (.10 + rand(15) / 100);
	combat.doDamage(damage, true, true);
	player.changeFatigue(20, 2);
	//Enemy faints -
	if (monster.HP < 1) {
		outputText("You can feel " + monster.a + monster.short + "'s life signs beginning to fade, and before you crush all the life from " + monster.pronoun2 + ", you let go, dropping " +monster.pronoun2 + " to the floor, unconscious but alive.  In no time, " + monster.pronoun3 + "'s eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.  ", false);
		if (monster.short == "demons")
			outputText("The others quickly back off, terrified at the idea of what you might do to them.", false);
		outputText("\n\n", false);
		doNext(combat.endHpVictory);
		return;
	}
	outputText("\n\n", false);
	monster.doAI();
}
//Tease
public function naggaTease():void {
	clearOutput();
	//(if poisoned)
	if (monster.findStatusEffect(StatusEffects.NagaVenom) >= 0)
	{
		outputText("You attempt to stimulate " + monster.a + monster.short + " by rubbing " + monster.pronoun3 + " nether regions, but " + monster.pronoun3 + " seems too affected by your poison to react.\n\n", false);
	}
	else if (monster.gender == 0)
	{
		outputText("You look over " + monster.a + monster.short + ", but can't figure out how to tease such an unusual foe.\n\n", false);
	}
	//(Otherwise)
	else {
		combat.fatigueRecovery();
		var damage:Number = 0;
		var chance:Number= 0;
		var bimbo:Boolean = false;
		var bro:Boolean = false;
		var futa:Boolean = false;
		var choices:Array = new Array();
		var select:Number = 0;
		//Tags used for bonus damage and chance later on
		var breasts:Boolean = false;
		var penis:Boolean = false;
		var balls:Boolean = false;
		var vagina:Boolean = false;
		var anus:Boolean = false;
		var ass:Boolean = false;
		//If auto = true, set up bonuses using above flags
		var auto:Boolean = true;
		//==============================
		//Determine basic success chance.
		//==============================
		chance = 60;
		//5% chance for each tease level.
		chance += player.teaseLevel * 5;
		//10% for seduction perk
		if (player.findPerk(PerkLib.Seduction) >= 0) chance += 10;
		//10% for sexy armor types
		if (player.findPerk(PerkLib.SluttySeduction) >= 0) chance += 10;
		//10% for bimbo shits
		if (player.findPerk(PerkLib.BimboBody) >= 0) {
			chance += 10;
			bimbo = true;
		}
		if (player.findPerk(PerkLib.BroBody) >= 0) {
			chance += 10;
			bro = true;
		}
		if (player.findPerk(PerkLib.FutaForm) >= 0) {
			chance += 10;
			futa = true;
		}
		//2 & 2 for seductive valentines!
		if (player.findPerk(PerkLib.SensualLover) >= 0) {
			chance += 2;
		}
		//==============================
		//Determine basic damage.
		//==============================
		damage = 6 + rand(3);
		if (player.findPerk(PerkLib.SensualLover) >= 0) {
			damage += 2;
		}
		if (player.findPerk(PerkLib.Seduction) >= 0) damage += 5;
		//+ slutty armor bonus
		if (player.findPerk(PerkLib.SluttySeduction) >= 0) damage += player.perkv1(PerkLib.SluttySeduction);
		//10% for bimbo shits
		if (bimbo || bro || futa) {
			damage += 5;
			bimbo = true;
		}
		damage += player.level;
		damage += player.teaseLevel*2;
		damage += rand(7);
		chance += 2;
    	//Specific cases for slimes and demons, as the normal ones would make no sense
        if (monster.short == "demons") {
			outputText("As you stimulate one of their brethren, the other demons can't help but to feel more aroused by this sight, all wishing to touch and feel the contact of your smooth, scaly body.", false);
		}
		else if (monster.short == "slime") {
			outputText("You attempt to stimulate the slime despite its lack of any sex organs. Somehow, it works!", false);
		}
		//Normal cases for other monsters
		else {
			if (monster.gender == 1)
			{
				outputText("Your nimble tail begins to gently stroke his " + monster.cockDescriptShort(0) + ", and you can see it on his face as he tries to hold back the fact that it feels good.", false);
			}
			if (monster.gender == 2)
			{
				outputText("Your nimble tail manages to work its way between her legs, grinding your tail's scaly skin against her clit. She appears to enjoy it, but it is obvious she is trying to hide it from you.", false);
			}
			if (monster.gender == 3)
			{
				outputText("Your nimble tail manages to work its way between " + monster.pronoun3 + " legs, gaining access to both sets of genitals. As your rough, scaly skin rubs past " + monster.pronoun3 + " clit, your tail gently begins to stroke " + monster.pronoun3 + " cock. The repressed expression on " + monster.pronoun3 + " face betrays " + monster.pronoun3 + " own enjoyment of this kind of treatment.", false); 
            }
		}
		//Land the hit!
		if (rand(100) <= chance) {
			//NERF TEASE DAMAGE
			damage *= .9;
			if (player.findPerk(PerkLib.HistoryWhore) >= 0) {
				damage *= 1.15;
			}
			monster.teased(damage);
			combat.combatTeases.teaseXP(1);
		}
		//Nuttin honey
		else {
			combat.combatTeases.teaseXP(5);
			outputText("\n" + monster.capitalA + monster.short + " seems unimpressed.", false);
		}
		outputText("\n\n", false);
		//OLD
		//monster.lust += 5 + rand(15);
		if (monster.lust >= monster.eMaxLust()) {
			doNext(combat.endLustVictory);
			return;
		}
	}
	monster.doAI();
}

public function nagaLeggoMyEggo():void {
	clearOutput();
	outputText("You release " + monster.a + monster.short + " from " + monster.pronoun3 + " bonds, and " + monster.pronoun1 + " drops to the ground, catching " + monster.pronoun3 + " breath before " + monster.pronoun1 + " stands back up, apparently prepared to fight some more.", false);
	outputText("\n\n", false);
	monster.removeStatusEffect(StatusEffects.Constricted);
	monster.doAI();
}


private function eggUpANagaSpiderLike():void {
	clearOutput();
	outputText("As the shiny-scaled girl collapses against the sand, you scramble forward, panting not so much with the exertion of the fight as with lust and excitement.  Surely a creature as large as her has enough room to fit all your eggs?  You feel so full, and it's been so long since you last had release.");
	
	outputText("\n\nThe naga raises herself onto her elbows as you bear down on her, making a half-assed attempt at a rebellious glare.  When she meets your lust-mad stare, her eyes go wide, and she struggles backwards, frantically trying to get out from under you.");
	
	outputText("\n\nYou're having none of that.  With your ovipositor already beginning to swing loose beneath you, your patience for your prey's shenanigans is nonexistent.  Catching her tanned shoulders with your hands, you push her down and pin her upper torso in place, though her massive tail continues to writhe beneath you.  Keeping one hand on the snake-woman's shoulder, you pat her down hastily, your fingers trailing across her stomach and hips in search of her slit.");
	
	outputText("\n\nJust below where her human skin fades into scales, you uncover the naga's slick hole.  Your breath quickens again as you try to line yourself up with it, your dripping egg-tube smearing its viridian lube across her scaly underside.  You manage to slip a few inches in, but she hasn't ceased her squirming, even for a moment.");
	
	outputText("\n\nWith nothing around you but sand for miles, there isn't anything to anchor her to while you tend to the matter of your burgeoning spider half.  Instead, you shuffle your chitinous legs into the sand beneath the two of you before curling them in and up, effectively pinning yourself to the naga and driving your ovipositor the rest of the way in.");
	
	outputText("\n\nThe tight sensation of the snake-lady's pussy wrapped around your egg-chute drives you even further into lust, and as your spidery limbs clasp her lower half tighter you throw your arms recklessly around her shoulders, smooshing her breasts into your [chest] as you lock lips and curl your tongue around hers.");
	
	outputText("\n\nHer squirming slows, and she begins to moan around your invading tongue, but you don't even notice, jackhammering your pole into her over and over, barely remembering to breathe as you rut against her.  You're all but whimpering into her mouth, clasping her against you in your frenzied attempt to relieve yourself.");
	
	outputText("\n\nFinally, muscles deep in your spider half seize and clench, and you shove her back against the sand as you arch your own, saliva dripping from both your mouths.  Your eggs flood through your ovipositor, the naga's stomach inflating near instantly with the weight of your unborn brood.  Her vagina clenches around your shaft in orgasm, dribbling femspunk around your swollen egg-chute.");
	
	outputText("\n\nAbove her, you groan in complete satisfaction, eyes rolling back as you find release");
	if (player.gender > 0) {
		outputText(", ");
		if (player.hasCock()) outputText("jizz");
		if (player.gender == 3) outputText(" and ");
		if (player.hasVagina()) outputText("femcum");
		outputText(" raining down on the prone naga");
	}
	outputText(".  You crumple into a heap on top of your reptilian lover, unconscious before you hit the sand.  Her eyes drift closed as well, as she coils around you, settling in for a well-deserved rest.");
	
	outputText("\n\nA while later, you awaken alone in the desert sand.  Getting your shaky legs under you and stifling a yawn, you head back to camp.  You should come to the desert more often.");
	player.dumpEggs();
	player.orgasm();
	combat.cleanupAfterCombat();
}

//Bee Naga Scene: Finished (Fenoxo) (edited)
private function beePositANagaPlease():void {
	clearOutput();
	outputText("You advance on the snake-woman before you with barely-concealed lust, a gradual trickle of your fluid drooling from the ovipositor slit behind you.  She recoils away in fear of your alien appearance, but in her current state she's unfit to put up more than a token resistance.  You round on her and help her up into a tender embrace, looking into her eyes as if to say, \"<i>It's okay, this won't hurt.</i>\"  She doesn't understand the words, but her searching, reptilian eyes slowly lose their fire at your reassuring gaze.");
	outputText("\n\nGingerly, you caress her sinuous, scaled body, exploring the curvy flow of muscle as scales down to the slight, almost imperceptible flare of her humanoid waist.  She squirms against you, her tail lashing in the sands to either side, thumping anxiously.  Soon, your curious fingers find her soft opening, hidden amongst the scales, and as you press inside, you find a second set of wet lips along with a harder, pill-shaped organ that can only be a clit.  The woman's fanged mouth parts in a wordless expression of pleasure, and as you have her distracted, you let your stinger slide through the scales on her underbelly.");
	outputText("\n\nThe naga winces, giving you a look of extreme betrayal while your venom pours through her defenses unhindered.  You study her face while your stinger works its magic.  The furrows in her eyebrows slowly relax and the naga's lips part, allowing her to pant.  Gradually, her skin flushes red with unrepentant lust, and as you empty the last of your stinger's reservoir into her vulnerable form, you take great pleasure in fingering her increasingly lubricated pussy.  The scales around her crotch-slit are so wet that they appear to be polished with oil, a shining stain of lust that spreads with each passing moment.  She's ready.");
	//{empty venom}
	player.tailVenom = 0;
	outputText("\n\nYou press your fingers in to get a feel for your future incubator's readiness, and to your satisfaction, she's practically gushing.  Her sizable box squishes with wetness as you tease the lips, then stuff four fingers inside.  The sloppy hole easily takes most of your hand, and encouraged by the progress, you push deeper, burrowing your arm to the elbow.  Clutching feebly around your shoulder, the snake woman hangs on to you for dear life, her pussy gushing and weakly squirting around your elbow as you plumb her depths.  Her serpentine cunt seems to go on forever, which is perfect for your purposes.  You unceremoniously remove your arm and smile at the naga's fresh contortions of pleasure.");
	outputText("\n\nWavering back and forth like a leaf in a storm, the naga seems besieged by her own lust, barely able to support herself.  Your ovipositor slides out of its internal compartment, drooling sweet amber slime behind you at the sight.  Utterly beholden to your lusts, you pounce on the naga and bear her to the ground with gentleness reminiscent of a drunken moose. She goes over like a house of cards, flat on her back with you atop her.  For all your lack of grace, you positioned her such that your egg-filled prong is hovering just above her entrance, soaking the snake-woman's exterior entrance with a thick flow of honey.");
	outputText("\n\nYou gently lower your insectoid abdomen until your egg-tube parts the naga's lips, then with a gentle push, you begin to slide it in.  Her entrance is surprisingly snug for something that could handle your whole arm, and you take your time pushing inside of it, not nestling your bug-butt's exoskeleton against her until you've taken the time to fully enjoy the penetration.  Once your organ has been sent home, your drugged-up partner surprises you by grabbing your head and pulling you into a kiss, her fangs pressing dangerously against your lips.");
	if (player.cor < 33) outputText("\n\nWith nothing to do but enjoy the tender moment,");
	else if (player.cor < 66) outputText("\n\nFiguring you may as well enjoy the extra stimulation,");
	else outputText("\n\nReluctantly kissing her back, if only because it makes your egg-spout throb,");
	outputText(" you relax against her, two bodies twined into one passionate shape.  The naga's tail circles one of your [legs] and your abdomen affectionately, and your ovipositor suddenly thickens, stretched a bit wider at the base as your first egg drops into the chute.  The scaly seductress wiggles a little at this, but her sultry gaze leaves no doubt as to her enjoyment of it.  You flex muscles you don't truly understand and force another egg in behind the first... and a third... and a fourth.");
	outputText("\n\nPOP!  The first egg exits your tubular psuedo-wang with a gush of honey to lubricate its passage, and like magic, it wicks away into the naga's body, beyond your feeling.  The snake's eyelashes flutter crazily, and her fingernails dig into your " + player.skinFurScales() + " brutally hard.  You find it difficult to notice any pain from it though; any discomfort is easily blunted by the pleasure of thick eggs sliding through your organ.  There really is no way to compare it to anything else - you have a tight cunt wrapped around your shaft, like a cock, but you also have hard objects sliding through your interior passage, like a vagina.  You can feel all of this along with the gentle stretching of your tube as each round orb squeezes out, accompanied by spurts of honey.  The alternately building and releasing tension repeats over and over, like a half-dozen tiny orgasms.  It is divine.");
	outputText("\n\nYour body, reacting to the mounting pleasure, begins to squeeze and push your remaining eggs out rapid fire.  The muscles you flexed to start the action seem entirely out of your control now, contracting crazily to fill your tube with heavy thickness.  Pressure builds up, and you try to relax, but you wind up arching your back and groping the naga's tits, crying out with orgasmic bliss.  Your prong twists and wiggles inside your partner, and then, with a triumphant pulsation, it opens wide, spraying out a string of eggs and honey with such rapidity that your eyes roll back and your [hips] begin to shake.  Splort, squish, splort!  Over and over, your body squirts eggs into the equally orgasming naga, sliding the eggs home into her roomy womb.");
	if (player.hasCock()) outputText("  [EachCock] erupts to splatter her with white");
	if (player.hasCock() && player.hasVagina()) outputText(" and y");
	else if (player.hasVagina()) outputText("  Y");
	if (player.hasVagina()) {
		outputText("our [vagina] ");
		if (player.wetness() < 3) outputText("drools");
		else if (player.wetness() < 5) outputText("gushes");
		else outputText("splatters");
		outputText(" clear femcum over the Naga's tight belly");
		if (player.hasCock()) outputText(" as well");
	}
	if (player.gender > 0) outputText(".");
	
	outputText("\n\nPanting softly, the confused, climax-addled snake weakly kisses you again, though it falls apart once you withdraw your spent egg-tube from the gushing, honey-scented snatch.  A small river of amber goo runs from her slightly-gaped pussy as you withdraw, though your eggs are pushed so deep as to be invisible");
	if (player.eggs() > 30) outputText(" from the outside at least.  You stuffed her so full that she looks positively pregnant, bulging to a picture of utter fertility");
	outputText(".  She idly runs her hands across her body, pinching her nipples and gasping in delight.  Your venom is clearly keeping her quite aroused, even with such a powerful orgasm.  After such a workout, you feel like you might have a little bit of venom left, so you give the new ");
	if (player.fertilizedEggs() == 0) outputText("egg-bearer");
	else outputText("mother");
	outputText(" a parting sting.  Her moans of excitement jump an octave, and you listen to them with a happy, almost gloating smile while you get dressed.");
	outputText("\n\nYou should definitely come to the desert more often.");
	player.dumpEggs();
	player.orgasm();
	combat.cleanupAfterCombat();
}
	}
}