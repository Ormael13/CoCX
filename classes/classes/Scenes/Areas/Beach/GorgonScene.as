package classes.Scenes.Areas.Beach 
{
import classes.*;
import classes.BodyParts.Face;
import classes.BodyParts.LowerBody;

public class GorgonScene extends BaseContent
	{
		
		public function GorgonScene() 
		{
		}

public function gorgonEncounter():void {
	//spriteSelect(45);
	//Create status if needed
	if(!player.hasStatusEffect(StatusEffects.Naga)) player.createStatusEffect(StatusEffects.Naga,0,0,0,0);
	clearOutput();
	if(player.lowerBody == LowerBody.NAGA) {
		//Set 'last fuck as naga'
		player.changeStatusValue(StatusEffects.Naga,1,1);
		//Not met as naga before
		if(player.statusEffectv2(StatusEffects.Naga) == 0) {
			player.changeStatusValue(StatusEffects.Naga,2,1);
			outputText("You wander into the beach, noting how good the sand feels on your underbelly compared to rocks and dirt. You are wondering to yourself if maybe it wouldn't be a bad idea to come out here more often when you spot something moving a little farther ahead of you.\n\n");
			outputText("As you get closer, you see that it is the gorgon that inhabits this dry beach. You stop in your tracks, wondering if it isn't too late to turn and run, when she turns her head and looks straight at you. You slowly tense your hands, ready to raise your [weapon] as the gorgon eyes your new snake-like body hungrily. Just before you can ready yourself, the gorgon opens her mouth. But instead of hissing, you find that you can understand her speech. \"<i>Your new body looks so much better than it did before,</i>\" she says, \"<i>It looks far more... delectable now.</i>\"\n\n");
		//	if (flags[kFLAGS.CODEX_ENTRY_GORGONS] <= 0) {
		//		flags[kFLAGS.CODEX_ENTRY_GORGONS] = 1;
		//		outputText("<b>New codex entry unlocked: Gorgons!</b>\n\n")
		//	}
			outputText("You wonder how it is that you can understand her now. Perhaps eating and drinking everything you find isn't the greatest idea after all, and as a result you're hallucinating? \"<i>It's been so long since I last saw another of my scaly kin,</i>\" she hisses softly, pulling you out of your introspection. \"<i>I had almost forgotten how good it is to be able to look at the sleek and powerful curves our kind possess. This place can make you forget, if you aren't too careful.</i>\" As strange as it sounds in your head, you are surprised at how she doesn't hold her s's. You aren't quite sure why you thought that would make sense.\n\n");
			outputText("You relax a little as she slithers over to you, though you're still wary of possibly being attacked despite the bright smile on her face. When she is close enough to you, she surprises you again by draping her arms around your shoulders in a friendly hug and pressing her chest firmly against you. You jump slightly at the sudden embrace, but slowly wrap your arms around her waist and pull her closer to you.\n\n");
		}
		//[If already encountered as a naga]
		else {
			outputText("You slide over the hot sand of the beach, enjoying the soft hiss that it makes as your scaled body slides over it. You see a strange yet familiar shape in the distance, and as you approach you realize that it is the gorgon from before. You quickly slither up behind her and wrap your arms around her. You can feel her tense up momentarily, before recognizing that it's you and turning herself to face you. \"<i>You came back!</i>\" She wraps her arms around your waist and you draw her closer to you.\n\n");
		//	if (flags[kFLAGS.CODEX_ENTRY_GORGONS] <= 0) {
		//		flags[kFLAGS.CODEX_ENTRY_GORGONS] = 1;
		//		outputText("<b>New codex entry unlocked: Gorgons!</b>\n\n")
		//	}	
		}
		outputText("She lets out a soft moan and leans her head forward, pressing her lips against yours. You squeeze her body even more firmly against yours in response, the tips of your tails wrapping around one another. You open your mouth slightly and press your tongue against her lips. She offers no resistance and you begin caressing the inside of her mouth with your tongue, circling her fangs as she uses her own tongue to gently stroke ");
		//[If player has fangs]
		if(player.faceType == Face.SNAKE_FANGS) outputText("your own.");
		//[player has no fangs]
		else outputText("the inside of your mouth.");
		outputText("\n\n");
		//dude secks
		if(player.gender == 1 || (player.gender == 3 && rand(2) == 0)) {
			//[Player cock is too big]
			if(player.cockArea(0) > 35) {
				outputText("The kiss continues as both of your bodies rub together sensually, your tails continuing to wrap around one another. There is a pulsing in your [cock] as it starts to grow hard against the gorgon's soft belly. Feeling this, the gorgon gently pulls away, slowly letting your tongue out of her mouth as she does so. Her hands make their way over your shoulders, down your abs, and stop at your [cocks].\n\n"); 
				outputText("\"<i>You're quite the big boy, aren't you?</i>\" she says as she wraps both of her hands around your now throbbing [cock]. She starts to slide her hands up and down your length. Sticking out her tongue, she wraps it around the tip and licks at the pre that is starting to leak out.\n\n");
				outputText("A hiss of pleasure escapes your lips as the gorgon strokes and licks at your [cock], her talented fingers and tongue bringing you into a further state of arousal. The gorgon stops her caressing and brings your [cock] to her chest, pressing her breasts around it. She slowly starts to slide her body up and down your shaft, using her tongue to bring some of your pre and lubricate her body. Once she is satisfied with her body's slickness, she quickens her pace.\n\n");
				outputText("You moan in pleasure as the gorgon takes the tip of your member into her mouth and starts to suck. You can feel her deft tongue licking every inch of your cock head.\n\n");
				outputText("At your limit, you let out a yell as you cum into her mouth. ");
				//[lots of jizz]
				if(player.cumQ() > 250) outputText("Her cheeks bulge with the volume and she struggles to swallow as much of it as she can. ");
				//[JIZZOFTHEGODS]
				if(player.cumQ() > 1000) outputText("Her cheeks bulge out with the sheer volume of your cum and she is forced to release you from her mouth to avoid drowning in your seed. ");
				outputText("You collapse onto the sand and lay there, basking in the warm glow of your orgasm. The gorgon slides onto your chest and gives you a kiss. \"<i>I rather enjoyed that,</i>\" she hisses into your ear, \"<i>We should do this more often.</i>\"\n\n");
				outputText("She gives you one last kiss before slithering off into the beach. You watch as she leaves and blow her a kiss goodbye before she disappears from your sight.\n\n");
			}
			//[Cock isn't too big]
			else {
				outputText("The kiss continues and both of your bodies rub together sensually, your tails continuing to wrap around one another. There is a pulsing in your [cocks] as ");
				if(player.cockTotal() == 1) outputText("it starts ");
				else outputText("they start ");
				outputText("to grow hard against the gorgon's soft belly. Feeling this, the gorgon gently pulls away, slowly letting your tongue out of her mouth as she does so. Her hands make their way over your shoulders, down your abs, and stop at your [cocks].\n\n");
				//[player has one dick]
				if(player.cockTotal() == 1) outputText("Gently she starts to stroke the length of your [cock] with one hand while circling the tip with the other. ");
				//[player has two dicks]
				if(player.cockTotal() == 2) outputText("She takes one in each of her hands and gently strokes them up and down. Every few seconds she stops at the tip to rub her palms over them. ");
				//[player has three or more dicks]
				if(player.cockTotal() >= 3) outputText("She takes one in each hand, stroking them slowly and making sure to pay attention to the tip. Every so often she switches to a different dick to make sure that each and every one of your throbbing cocks has some love given to them. ");
				outputText("A hiss of pleasure escapes your lips as the gorgon strokes your [cocks], her talented fingers bringing you further into a state of arousal. She stops her caress and brings her hand to a scaly covering at her crotch, spreading it wide to reveal her soft pussy.\n\n");
				
				//[player has one dick] 
				if(player.cockTotal() == 1) outputText("She carefully lines it up with your member and starts to tease the tip before gently inserting the first few inches. ");
				//[player has two dicks]
				if(player.cockTotal() == 2) outputText("She carefully lines it up with both of your members and starts to tease their tips before gently inserting the first few inches. ");
				//[player has three or more dicks]
				if(player.cockTotal() >= 3) outputText("She carefully lines it up with one of your members and starts to tease the tip before gently inserting the first few inches. ");
				outputText("She pulls her hips back slightly before pushing them back down, swallowing a bit more of you into her.  As she pulls back the second time, she shifts her arms to rest on your shoulders and grips your back tightly as she pushes you deeper inside of her.\n\n");
				outputText("Every thrust brings you deeper inside of her pussy, its soft walls massaging you. It seems like her pussy managed to swallow your entire cock in no time at all. The gorgon pauses for a moment, your hips pressed together, panting. You shift your arms up a little higher to rest at her waist and lower your head to nuzzle at her neck. The gorgon leans her head into yours and wraps one of her arms around your head. Once more she pulls back her hips before thrusting them back onto your cock. No longer is she slowly bringing you inside her, now she thrusts herself onto you, going faster and faster. Your tails tighten around each other as you reach climax. A sudden yell escapes your throat as you cum inside of her, your tail squeezing hard enough to crush a lesser being. The gorgon shudders in your grip as she reaches her own climax. ");
				//[lots of jizz]
				if(player.cumQ() > 250) outputText("You quickly fill her with your seed to the point where she overflows, leaving her pussy dripping with semen afterwards.");
				//[JIZZ, JIZZ EVERYWHERE] 
				else if(player.cumQ() > 1000) outputText("Her stomach quickly swells from the sheer volume of seed pumped into her. The sperm that her womb is unable to hold starts to gush out from her stuffed cunt.");
				
				outputText("\n\nThe two of you lay there for a moment, basking in the warm glow of orgasm. Eventually the gorgon slowly unwraps her tail from your own and gives you a kiss on the forehead. \"<i>I look forward to our next encounter,</i>\" she whispers softly into your ear before slithering off into the beach.  You watch as she leaves and wave her a kiss goodbye before she disappears from your sight.\n\n");
			}
			player.sexReward("Default","Default",true,false);
		}
		//chick secks
		else if(player.hasVagina()) {
			outputText("The kiss continues and you can feel your " + breastDescript(0) + " pressing against her own. You kiss her harder, pressing your body as close to her as you can, enjoying the feeling of your two bodies entwined together. You wrap your tail around hers, trying to make every part of your body touch every part of hers.  The feeling of her scaled tail rubbing against your body sends shivers of ecstasy down your spine. You pull away from her mouth and move your head to kiss at her neck, ");
			//(if player has fangs)
			if(player.faceType == Face.SNAKE_FANGS) outputText("carefully nibbling at it so as to not break the skin.  ");
			else outputText("nibbling gently at it.  ");
			outputText("Traveling down, you pause at her collarbone, letting go of her hips to bring your hands up to her perfectly rounded breasts. A moan escapes the gorgon's lips as you massage her erect nipples. Your mouth continues its trek down the gorgon's supple body and you make sure to pause on each breast, circling inward and stopping on each nipple to suck gently on them.\n\n");
 			outputText("Once more your hands move down the gorgon's body, making their way across her sides as your mouth simultaneously kisses at the smooth flesh of her exposed belly. Goose pimples slowly begin to appear, denoting how much she enjoys it. You pause at her hips, hovering over the slit at her crotch. One of your hands slide down to the slit and you start to stroke at it gently as you kiss at the area around it. Your partner shudders a bit, overcome by the sensations. Slowly you slide a finger into her, hearing a gasp of pleasure as you move it around inside her.  ");
			//(if never encountered as a naga)
			if(player.statusEffectv2(StatusEffects.Naga) == 0) {
				outputText("As you start to unveil her innermost recess, it appears to you that she must have lost the habit of such intimate contact after spending all these years deprived of any contact.  ");
			}
			outputText("You twist your fingers deeper inside of her, feeling the moist walls of her love canal press around your finger. Carefully you move your hand and push another of your fingers inside, then a third, moving them to massage her innermost depths. The gorgon's whole body is shuddering with arousal at your touch. It would be easy enough to bring her to a climax like this, but you decide that you want to make a slight change to the situation.\n\n");
    		outputText("You slide your fingers out of her and lift yourself up to look into her flushed face. \"<i>N-no,</i>\" she pants. \"<i>Don't stop... So close...</i>\"\n\n");
			outputText("You place a finger onto her luscious lips. \"<i>Shhhhh,</i>\" you say lovingly. \"<i>All good things must come to an end, but I'm not done yet.</i>\"\n\n");
			outputText("You untangle the end of your tail from hers and bring it up between the two of you, sliding it between your " + breastDescript(0) + " and inserting it sensually into your mouth. You suck on the end, making sure to coat it liberally before bringing it down to the gorgon's awaiting slit.\n\n");
			outputText("The tip of your tail slides into her soft folds, eliciting a gasp from her. You press further into her, feeling the walls of her pussy tighten over the length of your improvised shaft. Now that you are free of any length constraints, you decide you can now finish her off with the most intense orgasm she has ever had. Your scaly tail slowly crawls inside the depths of your friend, taking its time to tickle every lump, to tease all the sensitive bits while she grips you with all of her strength. Your friend pulls herself to your body, hugging you tight and squishing her breasts against your own. She wraps her arms around you, and begins to whisper things into your ear, \"<i>P-please... more... deeper...</i>\"\n\n");
			outputText("You simply run your tongue around her ear, gently nibbling on it as you slowly impale your gorgon lover on your thick, nimble tail. Her tail whips back and forth across the sand as she slowly succumbs to the intense pleasure of your deep, intimate penetration. You begin to wriggle your own tail inside your gorgon friend and her response is immediate. First, she shudders as a chill of excitement rushes up her spine. As the sensation overwhelms her, she lets out a wail of satisfaction followed by a series of loud moans in time with your tail's various jerks and twists inside her. As the gorgon girl begins to climax, driven over the edge by your tail's intense sensations, her tail begins to flick about wildly. In a stroke of genius, you manage to grab the end of her tail, holding it more or less steady against your own " + clitDescript() + ". As her tail wiggles back and forth, it drives your " + clitDescript() + " insane, rubbing it back and forth over and over again. You prolong your friend's climax by driving your wriggling tail ever deeper inside her and soon you find yourself close to orgasm. As you feel your own climax commence, you clench your teeth and lean against your partner, your breasts mashing together and your juices beginning to intermingle. As you both begin to calm down again, chests heaving, the only thing you can think to do is kiss your partner.\n\n");
    		outputText("She returns your kiss, but while you are distracted she prepares herself to help you in the same way you helped her. She begins to rub her tail along your " + vaginaDescript(0) + ", getting it wet. As you feel her scaly member begin to slide inside your own " + vaginaDescript(0) + ", the very thought gets you excited. Although somewhat jumpy, she is able to push at a modest rate, slowly inching her tail inside you, very much like the way you did to her. As you continue to passionately kiss each other, your tongues wrapping around one another and your arms wrapped around each other's warm bodies, you cannot think of a better place to be. Soon, you and your partner are tail-fucking each other in unison, your lips never parting, your bodies never separating. The both of you collapse upon the sand, too focused on one another to care about the surroundings.  That is how it carried on for what seemed like a beautiful, passionate eternity. You wake up several hours later, lying on the sand next to your friend, and you can't help but notice how cute she looks asleep. Your tails are still buried within one another, testament to the intensity of your lovemaking. You loved until the both of you collapsed, side by side, juices dripping out into the dry beach sands. You slowly remove your tail from inside her body, and simultaneously pull hers from your " + vaginaDescript(0) + ". You kiss her on the cheek, and are just close enough to hear her whisper, \"<i>Will we ever meet again?</i>\"  You lean in close, and whisper a simple \"<i>Yes.</i>\" Then, you leave her to her well-deserved rest, and slowly meander back to your camp, your brain still intoxicated with passion.\n\n");
			player.cuntChange(30,true,false,true);
			player.sexReward("Default","Default",true,false);
			outputText("You think it would be a very good idea to come to the beach more often.");
			doNext(camp.returnToCampUseFourHours);
			return;
		}
		//Genderleast
		else {
			outputText("The gorgon looks down and suddenly giggles at your stark lack of fun-bits. You turn away in embarrassment and start to head back to your camp.\n\n");
			outputText("\"<i>Wait,</i>\" the gorgon reaches out and places a hand on your shoulder. \"<i>I didn't mean to insult you. I've never seen anyone else quite like you.</i>\" She slides her hand down your body. \"<i>I wonder if you can show me just what a body like yours can do.</i>\"\n\n");
			outputText("Enjoying this new shift in the conversation, you coil around her and position your head over the scaly covering over her pussy. A soft hiss escapes the gorgon as you slide your tongue into her, twirling it around to caress every inch of her. Her hands make their way to your head and press you deeper into her.\n\n");
        	//(If tongue is forked)
			//9999 - BLAH!
			if(1 == 0) outputText("You move your tongue faster and deeper into her pussy, your forked tongue reaching deeper than any human tongue ever could.  ");
        	//(Otherwise)
			else outputText("You move your tongue faster and faster into her pussy, reaching as far in as you possibly can.  ");
			outputText("The gorgon grips your head tightly to her and suddenly thrusts her hips in orgasm, her girl cum coating your tongue and mouth.\n\n");
			outputText("You uncoil yourself and slowly gather your things, the gorgon lying on the sand panting.\n\n");
        	outputText("\"<i>We should do this more often,</i>\" she says before you head off.\n\n");
		}
		outputText("You think it would be a very good idea to come to the beach more often.");
		doNext(camp.returnToCampUseOneHour);
		dynStats("lus", player.lib/5);
		return;
	}
	//If player's last fight did not involve them being a naga
	if(player.statusEffectv1(StatusEffects.Naga) == 0) {
		if(!player.hasStatusEffect(StatusEffects.Naga)) player.createStatusEffect(StatusEffects.Naga,0,0,0,0);
		outputText("You are walking through the shifting sands of the beach when you hear a sudden hiss behind you.  Expecting to be attacked by a snake, you quickly leap forward and turn around.\n\n");
		outputText("To your surprise, what you see is not exactly a snake; it's a gorgon - a half-human half-snake hybrid.  She surges up and hisses even louder than before, showing off a pair of formidable fangs dripping with venom. Gazing at her long and slender reptilian body swaying on the sand like quicksilver, you can only stand still in admiration of this terrible wonder.");
	}
	//If player was a naga during last encounter
	//And isnt now
	if(player.statusEffectv1(StatusEffects.Naga) > 0) {
		//No fight for this encounter, brings you back to the camp. Next time you see her, she will attack you unless you turn back into a naga in the meantime
		player.changeStatusValue(StatusEffects.Naga,1,0);
		outputText("You walk in the beach for what feels like an eternity, thinking of how much easier it was to move across the sand back when you had a tail, but then you're brought back to reality by a familiar hissing. The identity of your follower is no secret to you. As you open your mouth to greet your gorgon friend, you find yourself unable to pronounce any words. The girl comes towards you and slithers around in a confused way, trying to communicate. But the sounds that once formed words and phrases now seem to slip through you; all you can do is stand there, unable to grasp what she's trying to tell you. Realizing that you're not who you used to be anymore, she sadly looks down and turns around. The gorgon slithers away into the distance until she's nothing but a blink on the horizon.");
		doNext(camp.returnToCampUseOneHour);
		return;
	}
//	if (flags[kFLAGS.CODEX_ENTRY_GORGONS] <= 0) {
//		flags[kFLAGS.CODEX_ENTRY_GORGONS] = 1;
//		outputText("<b>New codex entry unlocked: Gorgons!</b>\n\n")
//	}
	startCombat(new Gorgon());
}

		
	}
}