package classes.Scenes.Areas.HighMountains {
import classes.*;
import classes.BodyParts.*;
import classes.Races.CatRace;
import classes.Races.CheshireRace;
import classes.Races.HellcatRace;
import classes.Races.ManticoreRace;
import classes.Races.NekomataRace;
import classes.Races.SphinxRace;
import classes.lists.BreastCup;

public class NekobakeInn extends BaseContent implements TimeAwareInterface {
	
	public function NekobakeInn() {
		EventParser.timeAwareClassAdd(this);
	}

	public function timeChange():Boolean
	{
		var needNext:Boolean = false;
		return needNext;
	}

	public function timeChangeLarge():Boolean {
		return false;
	}

	public function encounterNekobakeInn():void {
		clearOutput();
		outputText("As you explore the High Mountain you come upon a curious sight. As the mist parts away, an inn with eastern thematics and décor appears before you. Advertised outside by an ardoise are hot springs, warm meals and well made beds. A clean, freshly painted sign featuring a sleeping cat announces this place as the Nekobake Inn.[pg]");
		outputText("This place looks sketchy as can be, but you really could use some me time right now. Do you go in?[pg]");
		outputText("[pg]");
		doYesNo(enterTheInn, avoidTheInn);
	}

	private function avoidTheInn():void {
		clearOutput();
		outputText("Yeah, no. This place looks like a trap, smells like a trap and is probably a trap. Better move away from here as fast as possible. On this, you head back to camp.[pg]");
		endEncounter();
	}

	private function enterTheInn():void {
		clearOutput();
		outputText("You approach the inn, glad to have found this oasis in the hellscape that is nowaday Mareth. As you enter you are surprised by the presence of several human women all wearing Yukata. One standing out from the rest greets you as you enter.[pg]");
		outputText("\"<i>Welcome to the Nekobake Inn. I am Tsaabi, and I will be taking care of all your needs today. We have baths, food and bed. Would you like to have dinner or use the baths first?</i>\"[pg]");
		menu();
		addButton(0, "Dinner", dinner);
		addButton(1, "Bath", bath);
		addButton(2, "Just passing by", justPassingBy)
	}

	private function justPassingBy():void {
		clearOutput();
		outputText("A little unsure about your initial choice, you decide it would be wise not to linger and say you just wanted in to see what's inside and will be on your way. The ladies in yukata sigh in a united disappointment but bid you a good day as you leave, requesting you to come back soon.[pg]");
		endEncounter();
	}

	private function transform():void {
		if (player.ears.type != Ears.CAT)
			transformations.EarsCat.applyEffect(false);
		if (!Tail.hasFelineTail(player))
			transformations.TailCat.applyEffect(false);
		if (player.lowerBody != LowerBody.CAT)
			transformations.LowerBodyCat(2).applyEffect(false);
		if (player.arms.type != Arms.CAT)
			transformations.ArmsCat.applyEffect(false);
		if (!InCollection(player.faceType, Face.CAT, Face.CAT_CANINES, Face.CHESHIRE, Face.CHESHIRE_SMILE))
			transformations.FaceCatCanines.applyEffect(false);
		if (player.tongue.type != Tongue.CAT)
			transformations.TongueCat.applyEffect(false);
		if (player.eyes.type != Eyes.CAT && player.eyes.type != Eyes.INFERNAL) {
			transformations.EyesCat.applyEffect(false);
			transformations.EyesChangeColor(["yellow"]).applyEffect(false);
		}
		if (!player.hasCoatOfType(Skin.FUR))
			transformations.SkinFur(Skin.COVERAGE_LOW, {colors: ["brown", "chocolate", "auburn", "caramel", "orange", "sandy brown", "golden", "black", "midnight black", "dark gray", "gray", "light gray", "silver", "white", "orange and white", "brown and white", "black and white", "gray and white", "lilac and white"]}).applyEffect(false);
		if (player.hasGills())
			transformations.GillsNone.applyEffect(false);
		if (player.wings.type != Wings.NONE)
			transformations.WingsNone.applyEffect(false);
		if (player.rearBody.type != RearBody.NONE)
			transformations.RearBodyNone.applyEffect(false);
		if (player.antennae.type != Antennae.NONE)
			transformations.AntennaeNone.applyEffect(false);
		if (player.horns.type != Horns.NONE)
			transformations.HornsNone.applyEffect(false);
		mainViewManager.updateCharviewIfNeeded();
	}

	private function dinner():void {
		clearOutput();
		outputText("You could use a good, old fashioned warm meal right now.[pg]");
		outputText("\"<i>Certainly "+player.mf("Mister", "Miss")+", please come and make yourself comfortable in this room while we prepare the meal.</i>\"[pg]");
		outputText("They escort you to a side room with a comfy carpet and seats. You spend some time admiring the various artworks in the room which represent cats, a recurring theme in this building.[pg]");
		outputText("\"<i>"+player.mf("Sir","Miss")+", your meal is ready.</i>\"[pg]");
		outputText("You had almost forgotten about it but they indeed brought a platter filled with various delicious foods. \"<i>Call for us at any time you want something, anything.</i>\" Without further ado, you dig in. Each bite is like a dream, you missed such enjoyment so much. Your pawed hands claw at an egg roll mixing it with the sweet sauce and the smell of the combination has your whiskers shaking in excitement. " +
				"The rice and fish are exquisite too. Your tail calmly reflects your contentment as you purr in bliss. [pg]");
		player.refillHunger(player.maxHunger() - player.hunger);
		outputText("This said after such a good meal you sense a familiar warmth build up in your loins, your ");
		if (player.hasCock()) male2();
		else female2();
	}

	private function bath():void {
		clearOutput();
		outputText("Your body is all sweaty from the constant trekking all across Mareth, you could use a relaxing warm bath at the hotspring.[pg]");
		outputText("\"<i>Please use the door to your left for the hotspring "+player.mf("mister", "miss")+". You will have the location to yourself for a while, call for us at any time you want something, anything.</i>\"[pg]");
		outputText("You nod as you head past the sliding door into the spring area[if (hasarmor), removing your gear] to prepare for the much needed bath. The first thing you do as you approach the hot spring is leap in it. The warm water swiftly envelopes your form like a caring lover, soothing your muscles in just the right way. You feel limper, lighter and rejuvenated. Yet amidst this blissful moment, something feels… off?[pg]");
		outputText("You get half way out of the water revealing your lean, still dripping and warm body to check on your things, every item is there, no theft happened while you were bathing. Your furry cat ears twitch in an attempt to pick up any suspicious noise as your eyes focus, looking for would be intruders, maybe a peeping tom looking to get a glance of your still glistening [if (hasbreasts)"+player.breastCup(0)+"|D-cup ] breasts or your heart shaped ass. ");
		outputText("Your furry tail bobs from side to side in agitation and your claws extend from your furry paws, ready to tear some idiot to shreds, yet as you fail to find any sign of a peeper you sigh in relief and sink back into the warm water. A few minutes later, you crawl out trying to refresh yourself only to find out you can't. You're warmer than an oven right now and your cunt is practically juicing itself with need. Your ");
		female2(true);
	}

	private function male2():void {
		outputText("needy spiked cock hardening in response.[pg]");
		outputText("As if on cue, a catgirl with two tails, already naked, steps into the room. Your whiskers twitch in excitement as your nose catches the scent of a female in heat. If memory serves, she was part of the entryway cast. Something feels wrong, but you brush it from the side of the paw, you have a hitch to soothe, both yours and hers. " +
				"The catgirl purrs as she does a mock faint into your arms, briefly reaching back to tough your face as both of her tails tenderly stroke your side before she bends forward, getting down on all-fours to give you better access to her already dripping cunt.[pg]");
		outputText("Not one to refuse a lady when she begs, you grab her by her supple hips and begin inserting your warm cat cock into her snatch. Immediately, she grips your erection tightly, her cunt was made to please your cock, and you return her enthusiasm with eager thrusts back into her. Your fuzzy ears pick up the cutest of noises from her as you methodically fuck the rut out of your system. She continues mewling softly, her cunt trying to pull you back in with the descent of each thrust, desperate for more of your cock.[pg]");
		outputText("The heat deep down within you continues building, the onslaught of your climax inching nearer. Without any hesitation, you hilt every last inch into her as you empty your balls into the slut, flooding her thirsty canal with your feline seed until your balls can't offer anything else. [if (cumextreme) The poor kitten is left mewling helplessly as her stomach inflates from the sheer volume of seed you're pouring into her. It's not long until she's left gasping, barely hanging on for dear life.] " +
				"That said, this alone is hardly enough to satisfy your need, and perhaps your partner heard your thoughts as she simply begs, \"<i>Please do me again.</i>\" and you are most happy to oblige.[pg]");
		outputText("Inevitably, you lose count of how many cat girls you fucked that day but this matters little, so long as you have the energy and hardness to do so. Heck, maybe they fed you some energy drink to keep you going too. It’s not like you could grow tired of their sweet drinks.[pg]");
		for (var i:int=0; i < player.cocks.length; i++)
			transformations.CockCat(1).applyEffect(false);
		if (!player.isAnyRace(Races.NEKOMATA, Races.CAT, Races.SPHINX,Races.MANTICORE,Races.HELLCAT,Races.CHESHIRE)) transform();
		var x:int=20;
		while (x-->0) player.sexReward("VaginalFluids", "Dick");
		doNext(exitCafe);
	}

	private function female2(fromSpring:Boolean = false):void {
		outputText("body is begging for attention, anything to quench the burning heat quickly building within you. [pg]" +
				"It's almost uncanny, but maybe it's just ovulation. Remembering what the receptionist said earlier, you ring the bell "+ (fromSpring?" at the side of the hot spring":" on the corner of the table")+". Almost immediately on cue, a hunky catboy enters the room. He's clad in only a loincloth as his perfectly chiseled body is fully on display for your eyes to feast upon.[pg]");
		outputText("His baritone voice fills your ears, \"<i>What do you need, Miss?</i>\"[pg]");
		outputText("You cross your legs feverishly, biting your lip at the sight. His nose twitches slightly before he gives a knowing grin, revealing his canines teasingly as he approaches, discarding his loincloth and revealing his manhood.[pg]");
		outputText("Straddling you with his encompassing frame, he caresses your cheek before leaning in for a soft kiss. Losing all sense of resistance, your hands roam around him eagerly, admiring his burly frame as you grip to his body, eager to clutch onto him as he offers intermittent licks along your face as your hands roam around each other.[pg]");
		outputText("His tail coils around yours as he slowly presses more of his weight upon you, grinding his prickly erection against your torso. As the kiss deepens, you close your eyes, relaxing into the warm embrace of the man. Suddenly, it's as if the world spins around you until you find yourself tightly pressed against his thick pecs, he's now below you, hands loving around your waist, giving you the chance to straddle him.[pg]");
		outputText("His pulsating erection grinds against your underside, yet not intruding on anything you don't want. You take hold of his firm, manly pecs as you lift yourself, uncoiling your tail from his as you guide his erection to your labia. He grins eagerly, lowering his hands to cup your [ass] as he helps align himself with your entrance.[pg]");
		outputText("He eases you down as you eagerly clutch onto his rod with your inner walls, desperate for more of your hunky lover's presence. You need to feel him... you need every inch of his flesh... you want to be with him more than anything else at this moment.[pg]");
		outputText("Sensing your growing heat, he moves his beefy arm lower, stroking your tail gently before it slides up your side, sending tingles of pleasure through your spine as he holds you closer. Finally, he gives you an affirming buck, driving his erection deep into you.[pg]");
		outputText("You gasp in pleasure as you break the kiss, gripping the silky fur on his chest tightly between your fingers as he holds onto you lovingly. Your hands roam around his strapping form, grasping the soft fur on his body as he continues railing into you.[pg]");
		outputText("With senses overridden, you give into the numbing ecstasy. Waves of pleasure coarse through you as the soft barbs lining his erection brush the inside of your vagina, scratching every possible corner.[pg]");
		outputText("The burning heat that's welled up in you unleashes as the height of your orgasm rocks your being. You clench tightly against his erection, your feminine juices coating his dick as he gives your [ass] a tight clutch.[pg]");
		outputText("He doesn't stop, nor lose pace, leaving you a shaky, trembling mess in his powerful embrace. Time seems to drag on as he mercilessly continues pumping into you.[pg]");
		outputText("Finally, you can feel his amazing cock pulsate with heavier throbs, he gives a low growl before finally giving you a determined thrust, spearing his shaft into you, his bulgy balls pressing against your underside as he unloads wave after wave of his warm love into your canal.[pg]");
		outputText("His rod slowly deflates as you're left panting on top of him before his penis slips out past your lips. You rest your head against his thick pectorals as he tenderly strokes your back. His tail once again reaches for yours, gently wrapping around you as you take the moment to collect yourself now that your heat has been utterly sated.[pg]");
		outputText("His deep voice reverberates through you, \"<i>I hope you enjoyed... I'll be around if you need my services again, just ring the bell.</i>\"[pg]");
		outputText("He slowly lifts himself, taking you with him briefly before resting you on a carpet. Once he leaves, you take the time to recollect yourself and grab your equipment.[pg]");
		while (player.hasCock()) player.killCocks(-1, false);
		if (!player.hasVagina()) transformations.VaginaHuman().applyEffect(false);
		if (!player.hasBreasts()) transformations.CreateBreastRow(BreastCup.D).applyEffect(false);
		if (!player.isAnyRace(Races.NEKOMATA, Races.CAT, Races.SPHINX,Races.MANTICORE,Races.HELLCAT,Races.CHESHIRE)) transform();
		var x:int=20;
		while (x-->0) player.sexReward("Cum", "Vagina");
		doNext(exitCafe);
	}

	private function exitCafe():void {
		clearOutput();
		outputText("Once you're finished, you take your leave. As you head to the entryway to pay your tab, the catgirl at the guest booth waves you off, \"<i>Don't worry about the tab. We currently have a policy that allows people to rent for free for a limited time. Just promise to come again. If anything, you could even stay at the resort permanently. We have job vacancies available.</i>\"[pg]");
		outputText("The lusty stare in the receptionist's eyes tells you everything you need to know about the innuendo in her invitation. Another night like those would be great, but you got work to do. You politely decline the offer before you head out, returning to your camp.[pg]");
		for each (var stat:String in ["spe","tou","lib"]) {
			if (stat != "sens")
			{
				player.removeCurse(stat+".mult", 1,1);
				player.removeCurse(stat+".mult", 1,2);
				player.removeCurse(stat+".mult", 1,3);
				player.removeCurse(stat, 20,1);
				player.removeCurse(stat, 20,2);
				player.removeCurse(stat, 20,3);
			}
		}
		player.dynStats("cor", 20, "spe", 5, "tou", 5, "lib", 5);
		explorer.stopExploring();
		doNext(camp.returnToCampUseFourHours);
	}

}
}
