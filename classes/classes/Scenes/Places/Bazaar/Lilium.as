package classes.Scenes.Places.Bazaar{
	import classes.GlobalFlags.kFLAGS;
	import classes.PregnancyStore;

	public class Lilium extends BazaarAbstractContent{

	public function Lilium()
	{
	}

//I dunno about the term 'satanic streetwalker', and it
//probably needs to increment your corruption if you're fucking
//a proper demon. -Z

//Notes: Requires just a penis, penis and long demonic tongue 
//or a vagina. There's a couple of small conditionals to stop 
//references to legs for nagas so it's ok for them, but it 
//doesn't really make sense for centaurs.

//Vars:
//267 Times Bought Smexin'

//#########AREA TEXT#########
public function LiliumText(output:Boolean = false):Function {
	if (output) {
		//Before paying:
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00267] == 0) outputText("\n\nYou can see a pale, scantily clad demon woman leaning casually against the wall of a building.", false);
		//After paying:
		else outputText("\n\nYou can see Lilium standing in her usual spot.", false);
	}
	if (model.time.hours >= 17) return approachLilium;
	return null;
}

private function approachLilium():void {
	clearOutput();
	spriteSelect(93);
	var pay:Function = null;
	//#########FIRST TIME INTRODUCTION#########
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00267] == 0) {
		outputText("As you approach the demon woman, her gaze shifts to you, and she runs her eyes down your body, scrutinizing you.  You respond in kind, taking in her form.  Two nearly foot-long horns grow up and out of her forehead, one of which is adorned with a shiny, silver band.  Her dark hair spills across her bare shoulders in loose coils and her black lipstick and heavy eyeshadow contrast with the paleness of her skin.  A black underbust corset wraps around her waist, leaving her breasts exposed, and long black gloves adorn her arms up to the shoulder.  She also wears a crinoline skirt with an opening at the front which reveals her smooth bare legs, a tail which wraps around her thigh like a garter, and her crotch, which sports an average cock curiously clad in a lacy sock in spite of her otherwise brazen exposure.\n\n", false);

		outputText("Her assessment of you seems to be positive, as a smile crosses her face and she says, \"<i>You look like you've got more than a few gems to rub together; looking for a little fun?</i>\"\n\n", false);

		outputText("Of <i>course</i> that would be why she's standing there dressed like that.\n\n", false);

		outputText("\"<i>200 gems and I'm all yours,</i>\" she continues, sweeping her arms out wide for emphasis.\n\n", false);
	}
	//#########REPEAT INTRODUCTION#########
	else {
		outputText("Lilium stands before you.  Her two nearly foot-long horns grow up and out of her forehead, one of which is adorned with a shiny, silver band.  Her dark hair spills across her bare shoulders in loose coils and her black lipstick and heavy eyeshadow contrast with the paleness of her skin.  A black underbust corset wraps around her waist, leaving her breasts exposed and long black gloves cling to her arms up to her shoulders.  She also wears a crinoline skirt with an opening at the front which reveals her smooth bare legs, a tail which wraps around her thigh like a garter, and her crotch which sports her average cock curiously clad in her lacy cock sock in spite of her otherwise brazen exposure.\n\n", false);

		outputText("\"<i>Back again?  I thought I was finally rid of you!</i>\"  Lilium teases, but you can see the eager smile on her face.  \"<i>Is this visit business or pleasure?  I'm hoping both.</i>\"\n\n", false);
	}
	if (player.gems < 200) outputText("<b>You remember that you haven't got the 200 gems for her services right now.  Maybe next time.</b>", false);
	else pay = payForLilium;
	simpleChoices("Pay", pay, "", null, "", null, "", null, "Leave", leaveLilium);
}


private function payForLilium():void {
	clearOutput();
	spriteSelect(93);
	//#########GENDERLESS SCENE######### REQUIRES unsexed (hah)
	if (player.gender == 0) {
		outputText("You follow Lilium to a secluded spot. With a grin on her face she squats before you and helps you remove your " + player.armorName + ".  The grin is quickly replaced by a look of surprise and confusion as she looks at your flat, featureless crotch.\n\n", false);

		outputText("She looks up at you and then back at your groin a few times before scratching her head and crossing her arms.  \"<i>Well,</i>\" she begins, breaking the awkward silence.  \"<i>That's not something you see every day.  Did you get in an accident or something?  I mean, I've seen people with missing parts before, but...</i>\"  The woman trails off as she lightly prods your bare mons with one gloved finger.  \"<i>Actually, you know what?  I really don't think I want to know what could have done this to you.</i>\" With that she stands back up, grabs one of your arms and drops the small pouch of gems containing your payment to her back in your hand.\n\n", false);

		outputText("\"<i>Look, I'm sorry, but I can't really do anything for you right now.  If your, uh, situation changes, come see me again.</i>\"  Lilium then walks off, leaving you alone and naked.\n\n", false);

		outputText("Bummer.", false);
		doNext(bazaar.enterTheBazaar);
		return;
	}
	//First time - Pay: 
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00267] == 0) {
		outputText("\"<i>Sounds good,</i>\" you answer while fishing for your gem stash.\n\n", false);
	
		outputText("\"<i>I'm Lilium, by the way,</i>\" she states, as you give the woman your name and your payment in return.\n\n", false);
	
		//(If player name is also Lilium)
		if (player.short == "Lilium") outputText("\"<i>No way!</i>\" she cries upon learning of your identical name.  \"<i>Well... I hope you're not going to ask me to scream your name during sex.  That might be a bit awkward.</i>\"\n\nHow do you want to have the whore?\n\n", false);
		
		outputText("What will you do with her?", false);
	}
	else {
		outputText("You toss the gems to the hooker and while she counts them, you wonder just what you want her to do this time.", false);
	}	
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00267]++;
	player.gems -= 200;
	statScreenRefresh();
	//Sex Menu here
	var buttFuck:Function = null;
	var nippleFuck:Function = null;
	var rideHer:Function = null;
	if (player.hasCock() && player.hasLongTongue()) buttFuck = buttFuckTongueJeorb;
	if (player.hasCock()) nippleFuck = liliumNippleFuck;
	if (player.hasVagina()) rideHer = liliumDickRidah;
	simpleChoices("Buttfuck", buttFuck, "Ride Her", rideHer, "Nipple-Fuck", nippleFuck, "", null, "", null);
}

//- Leave:
private function leaveLilium():void {
	clearOutput();
	spriteSelect(93);
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00267] == 0) outputText("\"<i>I'm deathly allergic to fun, unfortunately,</i>\" you reply before moving on to examine more of the bazaar.", false);
	else outputText("\"<i>Just passing through, and I thought I'd see how you were doing,</i>\" you reply, and leave Lilium alone at her post.", false);
	doNext(bazaar.enterTheBazaar);
}

//#########BUTTFUCK + TONGUEJOB SCENE######### REQUIRES PENIS AND LONG DEMONIC TONGUE
private function buttFuckTongueJeorb():void {
	clearOutput();
	spriteSelect(93);
	var x:Number = player.cockThatFits(40);
	if (x < 0) x = 0;
	outputText("The two of you find a secluded alley between two buildings.  Lilium removes her corset and skirt before moving to help you remove your " + player.armorName + ".\n\n", false);
	
	outputText("Squatting before you, she traces a single gloved finger along the underside of your " + player.cockDescript(x) + ", teasing it until it grows to its full " + Math.round(player.cocks[x].cockLength) + "-inch length.  Once your maleness has sprung to life, she turns around and bends over to brace herself against the wall before looking back over her shoulder at you mischievously and giving her hips a little wiggle.  Taking position behind her, you slide your " + player.cockDescript(x) + " between her soft thighs.", false);
	//(If player cock length > 8 inches)
	if (player.cocks[x].cockLength > 8) outputText("  You can feel Lilium's smaller cock resting atop your " + player.cockDescript(x) + ".", false);
	outputText("  With each thrust you can feel more and more feminine lube coating your shaft as you glide across Lilium's labia, her dick stiffening with arousal.\n\n", false);

	outputText("One last time, you slowly draw your " + player.cockDescript(x) + " from between her thighs and let it flop against her lower back, your hands moving from Lilium's hips to her pearlescent ass cheeks.  Spreading her wide, you let your " + player.cockDescript(x) + " gradually inch down the cleft between them until the head rests against her back entrance.  With an agonizing slowness you begin to push.  The faintest gasps escape Lilium's lips as her ass finally envelops the head of your cock, followed by a squeak of surprise as you suddenly drive the remaining length in; the force of your " + player.hipDescript() + " meeting her ass pushes her entirely up against the wall.\n\n", false);
	
	outputText("Your lips part slightly as you let your tongue begin to extend.  It journeys around Lilium's trim waist and down across her taut tummy until it finds its target: her turgid penis.  Your long tongue wraps around her shaft tightly and as its tip meets her tip you can taste the pre-cum leaking through her perfumed cock sock.  You begin to massage the unholy herm's cock by flexing your tongue as you speed up your thrusts into her round ass.\n\n", false);
	
	outputText("You establish a rhythm of pleasuring Lilium from both sides; thrust in, flex tongue, pull out, release and soon she begins pushing her hips back in time to meet you on every thrust.", false);
	//(If player has breasts)
	if (player.biggestTitSize() >= 1) {
		outputText("  A tingle emanates from your " + player.nippleDescript(0) + "s as your " + player.allBreastsDescript() + " slide across her sweat-slicked back with every thrust.", false);
		//(If player has a lot of milk)
		if (player.biggestLactation() >= 1) outputText("  The stream of milk that leaves your breasts each time you press your body against Lilium's adds further lubrication between you.", false);
	}
	outputText("\n\n", false);
	
	outputText("The pace of Lilium's breathing quickens and soon she begins to shudder as her cock throbs within your tongue's grasp.  Jets of the satanic streetwalker's cum shoot out against the tip of the sock and she lets out a moan of contentment.  Her internal muscles clench down on your shaft as she ejaculates, causing a wave of goose bumps to cover your body which signals your own impending orgasm.  Your knees buckle and tongue loses its grip on her sock; the wet fabric flies off her cock with her next spurt, hitting the ground with a tiny 'plap'.  The tingling across your body focuses itself in on the base of your " + player.cockDescript(x) + ", and you grab the root of Lilium's demonic tail for more leverage, pulling her roughly against you as you grunt loudly, the proof of your pleasure exploding into her bubble butt.  This final thrust forces an extra gout of cum from her cock, which then leaks down its tongue prison, giving you a last taste of her fluids.\n\n", false);

	outputText("Panting, Lilium grabs your hands and moves them around her waist, holding them against her stomach.  ", false);
	//(If naga body)
	if (player.isNaga()) outputText("As you both stand there, reeling in the wake of your ecstasy, she leans back against you causing you to flop onto your " + player.buttDescript() + " with the demon girl on top of you; you haven't the strength to remain standing.", false);
	//(else) 
	else outputText("As you both stand there, reeling in the wake of your ecstasy, she leans back against you causing you to flop onto your " + player.buttDescript() + " with the demon girl on top of you; your wobbling legs have temporarily lost the strength to keep you both upright.", false);
	outputText("  Lilium lets out a laugh and soon you find yourself laughing with her.\n\n", false);
	
	outputText("After you both recover, you get up to don your " + player.armorName + ", thanking Lilium and beginning the trip back to camp.  Maybe you'll take a bath too...", false);
	
	player.orgasm();
	dynStats("cor", 1);
	doNext(camp.returnToCampUseOneHour);
}

//#########DICK RIDE SCENE######### REQUIRES VAGINA
private function liliumDickRidah():void {
	clearOutput();
	spriteSelect(93);
	outputText("Lilium takes you to a secluded spot away from the Bazaar.  She removes her corset and skirt and slips the lacy cock sock off her cock and you eagerly remove your own " + player.armorName + ".\n\n", false);

	outputText("You gently push Lilium down onto her back and straddle her waist.  As she looks up at you with a demure expression you move your hands to her pert breasts and begin a slow circular massage of her chest.  With each pass you ever so slightly lighten your grip and move your fingers closer to her nipples until finally you are lightly trailing your index fingers around their rosy tips.  You can see Lilium's eyes close as she enjoys your touch on her body.  Gently you slip just the very tip of one finger into each of her fuckable nips and the woman beneath you arches her back, seeking to force your fingers into her heaving breasts further.  With a grin you tear your fingers away from her breasts and Lilium's eyes snap open and a look of disappointment crosses her face.  Quickly you lean down and plant a kiss on her dark, pouting lips, letting your tongue slip between them just the slightest bit to taste her.\n\n", false);

	outputText("Slowly you begin moving down Lilium's body.  You leave a trail of kisses down her neck before running your tongue along her collar bone.  Further down you go, letting your lips gently slide down the center of the demon herm's chest until you reach her navel.  ", false);
	//(if player has long hair)
	if (player.hairLength >= 15) outputText("You can feel Lilium shudder slightly beneath you as your hair tickles her nipples.  ", false);
	outputText("First you begin to circle her navel with the tip of your tongue, following up with long licks beginning at the base of her belly and trailing up and into her belly button. Lilium's breathing begins to quicken and her hips start to dart back and forth beneath you as you continue to tongue her navel. As you become more conscious of the hardened cock poking into your own chest you draw your head back, leaving a long shiny strand of saliva that joins your mouth to her smooth tummy.\n\n", false);

	outputText("You draw yourself up and position yourself above Lilium's twitching cock.  Your fingers part the lips of your " + player.vaginaDescript(0) + " which are slick with your own arousal.  ", false);
	//(If virgin/tight)
	if (player.vaginalCapacity() < 25) outputText("Gingerly you lower yourself down onto Lilium's cock, your breath tight in your chest as the head strains against your moist inner walls.  Each inch is easier than the last and soon you release a long slow exhale as your crotch meets hers and the pleasurable feeling of fullness washes over you.  ", false);
	//(if loose or produce lots of lube)
	else outputText("Without a second thought you plunge yourself down on Lilium's fuckrod, your " + player.buttDescript() + " jiggling from the sudden impact.  ", false);
	outputText("You pull yourself up until only the head of the demon girl's dick remains within you, before sliding back down to let her fill you again.  Up and down you bounce on top of her, your speed and force increasing with every stroke.  You let out a contented half moan, half grunt each time your " + player.hipDescript() + " collide with hers as her stiff cock stimulates your insides.  Lilium's own search for more pleasure brings her hands to her breasts and she begins to finger-fuck her nipples.  Before long she has two and then three fingers furiously plunging in and out of her gaping nipplecunts and you can see her eyes rolled back in her head as her mouth hangs open in testament to the excitement flowing through her body.", false);
	player.cuntChange(14,true,true,false);
	outputText("\n\n", false);

	//(if player has breasts)
	if (player.biggestTitSize() >= 1) {
		outputText("You turn your attention to your own " + player.allBreastsDescript() + " and how they bounce from the force of your vigorous fucking, supporting the weight of your " + player.breastDescript(0) + " with your hands as you continue to ride Lilium's cock.", false);
		//(if demonic tongue)
		if (player.hasLongTongue()) outputText("  Letting your long tongue extend out from between your lips, you wrap it around one " + player.nippleDescript(0) + " and gently squeeze, sending an electric thrill that flows to your core and back out to the tips of your fingers.", false);
		//(else if no demonic tongue)
		else outputText("  You begin to squeeze your " + player.nippleDescript(0) + " between two fingers, sending an electric thrill that flows to your core and back out to the tips of your fingers.", false);
		//(if lactating a little)
		if (player.biggestLactation() >= 1 && player.biggestLactation() <= 2) outputText("  A small stream of milk leaks out and dribbles over your tongue, giving you a taste of your own fluids.", false);
		//(else if lactating a lot)
		else if (player.biggestLactation() > 2) outputText("  A powerful stream of milk fires out of your " + player.nippleDescript(0) + ", coating Lilium's flat stomach.", false);
		outputText("\n\n", false);
	}

	outputText("With several fingers still inside her nipples, Lilium bites her lip and forcefully pushes her breasts together as her hips begin bucking to meet your own " + player.hipDescript() + ".  Seeing that her orgasm is near, you begin flexing your internal muscles in addition to pumping up and down on her cock.  With a sudden burst of movement that surprises you, Lilium tears her hands from her breasts and roughly grabs your " + player.buttDescript() + ", her fingers digging into your buttcheeks as she attempts to hold you down tight upon her.  Her eyes bulge wide and she lets out a loud cry as you feel her pump load after load of demonic cum into you, flooding your " + player.vaginaDescript(0) + ".  Lilium drops her arms to her sides with eyes half-lidded as she pants heavily.\n\n", false);

	outputText("Not finished with her yet, you draw yourself up off her wilting willy, clenching your lower muscles to keep as much of her cum inside you as possible as you flip yourself around and position your body above her face.  Lilium quickly catches on to what you're doing and you think you can see her gulp nervously as you lower your cum-stuffed pussy to her mouth.  Rolling your " + player.hipDescript() + " back and forth you begin grinding your " + player.vaginaDescript(0) + " into the demon woman's face as her tongue worms and tickles inside you, beginning its task of cleaning out the remnants of her ecstasy from your love hole.  While Lilium's tongue gently strokes your insides with lips occasionally sucking gently on your labia, you turn your attention to your clit.  ", false);
	//(if little clit)
	if (player.clitLength < 2) outputText("With one finger you begin to knead your " + player.clitDescript() + ", which instantly increases the pleasure emanating from your lower body.", false);
	//(else if big clit)
	else outputText("Tenderly grasping it between your fingers you begin to rub your " + player.clitDescript() + " from base to tip, each stroke adding a wave of pleasure to that of the tongue treatment your " + player.vaginaDescript(0) + " is receiving.", false);
	outputText("  The tingle of pleasure across your body begins to strengthen and you grind your crotch into your demon lover's face that little bit harder, trying to get yourself over the edge; suddenly you feel a burst of electricity inside you.  Your muscles all contract, your arms pull tight to your body and you collapse inwards, on top of Lilium as the pulses of pleasure shoot out across your body.  The tingles in your " + player.nippleDescript(0) + ", your " + player.clitDescript() + ", your insides and out, through your arms and " + player.legs() + ", reach a fever pitch and you let out a short, strained squeak through gritted teeth to voice your pleasure.\n\n", false);

	outputText("Exhausted, you flop to the side, leaving you lying supine beside Lilium.  You turn your head to look at her and she tilts her own head to meet your gaze.  You can see a similar look of contented exhaustion on her face, although you're fairly sure you lack the mix of cum and feminine lube and the smeared makeup.\n\n", false);

	outputText("After a moment of recovery time you get up to get dressed before starting your journey back to camp.  \"<i>Don't be a stranger, now,</i>\" calls the voice over your shoulder. A slight smile appears on your face.\n\n", false);

	player.orgasm();
	dynStats("cor", 1);
	//(imp preg check)
	player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 14, 61); //Lilium causes faster pregnancies
	doNext(camp.returnToCampUseOneHour);
}

//#########NIPPLE FUCK SCENE######### REQUIRES PENIS
private function liliumNippleFuck():void {
	var x:Number = player.cockThatFits(40);
	if (x < 0) x = 0;
	
	clearOutput();
	spriteSelect(93);
	
	outputText("Lilium takes you to a secluded spot in the Bazaar for you to be able to enjoy each other's company. She kneels down before you and you strip out of your " + player.armorName + ", baring your naked body before her.\n\n", false);

	outputText("Lilium begins to gently rub her palms against the side of your flacid cock.  As it begins to harden in her hands she leans in close, letting it grow stiff against her soft cheek.  You feel her wet tongue against the base of your " + player.cockDescript(x) + " before it begins sliding along the underside of your cock as Lilium licks the length of your maleness right to the tip.  ", false);
	//(If cock is pierced)
	if (player.cocks[x].pierced > 0) outputText("You can feel a slight bump as her tongue passes over each piercing and she gives the head of your cock a flick with the tip of her tongue as she reaches the end.  ", false);
	//(else)
	else outputText("As her tongue reaches the end of its journey she gives the head of your " + player.cockDescript(x) + " a little flick with the tip of her tongue.  ", false);
	outputText("Taking one black tress in hand she draws it slowly across your glans, sending a shiver down your spine. Taking obvious delight in your reaction she starts brushing the lock of plush hair up and down your shaft.  You can see her bring her free hand up to her breast as she continues to tickle your " + player.cockDescript(x) + " with the soft strands of hair.  At first she cups and massages the pale flesh slightly, before slipping a finger inside her rosy nipplecunt.  She bites down on her lip as she begins working the finger in and out.\n\n", false);

	outputText("Not content with just the teasing Lilium continues to give your " + player.cockDescript(x) + ", you grab her shoulders and push her back against the wall, the shock of which causes her finger to come free of her nipple.  With one hand you line the head of your " + player.cockDescript(x) + " up with the now dripping entrance to her breast and drive forward.  There is a slight resistance at first, but then Lilium coos as you overcome it and her breast envelops you.  Her boobs are sadly not large enough to take you to the hilt, but pumping part of your shaft in and out of her chest is pleasurable all the same. The soft flesh mound distorts as you fuck it, stretching out as you draw back and squishing together as you thrust in.  Lilium's eyes unfocus and she begins to pant louder and louder as you fuck her breast.\n\n", false);

	var doubleNipFuck:Boolean = false;
	//(if multicock)
	if (player.cockTotal() >= 2) {
		doubleNipFuck = true;
		outputText("Thinking it unfair that just one of her breasts receives your attention, you grab another of your " + player.multiCockDescriptLight() + " and unceremoniously jam it into Lilium's lonely nipple-cunt, causing her to let out a loud squeal from the extra penetration.  The extra purchase on Lilium's body from both your cocks now being inside her breasts causes the demon's body to rock back and forth vigorously with each of your thrusts.  You move yourself backwards slightly, pulling her with you away from the wall to avoid concussing her.  When you resume your thrusts you can hear her moans warble as her body rocks with yours.\n\n", false);
		doubleNipFuck = true;
	}
	//(else if demon/naga tail)
	else if (player.tailType == TAIL_TYPE_DEMONIC || player.isNaga()) {
		outputText("Thinking it unfair that just one of her breasts receives your attention, you draw your tail up and unceremoniously jam it into Lilium's lonely nipple-cunt, causing her to let out a loud squeal from the extra penetration.  The extra purchase on Lilium's body from both your cock and your tail now being inside her breasts causes the demon's body to rock back and forth vigorously with each of your thrusts.  You move yourself backwards slightly, pulling her with you away from the wall to avoid concussing her.  When you resume your thrusts you can hear her moans warble as her body rocks with yours.\n\n", false);
	}
	
	outputText("Giving up trying to steady herself, Lilium brings her hands to her own cock and begins to stroke and massage it in time with you.  The wet shlicks and pops of you fucking Lilium's dripping nipple", false);
	if (doubleNipFuck) outputText("s", false);
	outputText(" and the soft sound of her stroking her dick combine with your grunts and her moans to form a sexual chorus in this isolated part of the Bazaar.  Soon you feel the familiar pressure building in your loins and you speed up your thrusts; with one great, final effort you drive as far into Lilium's tit", false);
	if (doubleNipFuck) outputText("s", false);
	outputText(" as you can.  A wave of ecstasy washes over you from your head to ", false);
	if (player.tailType > TAIL_TYPE_NONE) outputText("your tail", false);
	else outputText("your " + player.feet(), false);
	outputText(" as you cum", false);
	if (player.cockTotal() > 2) outputText(", your unused cocks drenching her with seed", false);
	outputText(".  The tightness of her ", false);
	if (doubleNipFuck) outputText("nipple-cunts around your twin cocks causes some of your cum to squirt back out of her nipples", false);
	else outputText("nipple-cunt around your cock causes some of your cum to squirt back out of her nipple", false);
	outputText(" each time you fire another load into her, the balance leaking down on Lilium's stomach and thighs.", false);
	if (player.cumQ() >= 700 && player.cockTotal() > 1) outputText("Rivers and rivers of cum pour out of your cocks, distending her nipple-holes as the backflow gushes from around the heads.", false);
	outputText("\n\n", false);

	outputText("The sensation of you pulling out of her fuck-able nipple", false);
	if (doubleNipFuck) outputText("s", false);
	outputText(" drives Lilium herself over the edge, causing jets of her own cum to explode out of her cock.  The outline of the spurt is visible in the end of the lacy sock for a moment; it bulges and drips obscenely as she fills it up, squeezing her cock and letting out a loud cry in pleasure.  As she kneels before you panting, cum dripping from her gaping nipple", false);
	if (doubleNipFuck) outputText("s", false);
	outputText(" and soaked sock, you brush a wayward strand of hair from her face.  Her eyes make their way up to meet yours and you give her a wink as you both smile lasciviously.\n\n", false);

	outputText("You get dressed again and begin to leave; as you look back over shoulder, Lilium - still seated and leaning against the wall - blows you a kiss.", false);
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}
}
}
