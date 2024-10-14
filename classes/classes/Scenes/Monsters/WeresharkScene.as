/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.*;
import classes.GlobalFlags.kFLAGS;
import classes.Races.WeresharkRace;
import classes.Scenes.SceneLib;

	public class WeresharkScene extends BaseContent
	{
		
		public function WeresharkScene() 
		{}

private function wsG():Boolean {
	return flags[kFLAGS.WERESHARKS_EXTRAS] < 2;//male ones wereshark enemies
}
public function weresharkEncounter():void {
	clearOutput();
	outputText("As you steadily row your boat through the moonlit ocean, you spot a figure looming close to the surface in the distance. Before you can assess the situation, the figure seemingly disappears deeper into the water.\n\n");
	outputText("With your guard raised, you slow down, preparing for anything that could happen. In moments, something erupts from beneath you, knocking you out of the boat as your vessel capsizes. The ocean's cool embrace envelops you as you plunge into the water. You're met with several rows of teeth from a creature in the water before you.\n\n");
	outputText("You struggle to regain your composure, trying not to give it an advantage over you. Rubbing your eyes as you resurface, you prepare for a fight against the shark-like creature!\n\n");
	flags[kFLAGS.WERESHARKS_EXTRAS] = 1;
	startCombat(new Wereshark());
}
public function lostToWereshark():void {
	clearOutput();
	//spriteSelect(SpriteDb.s_DarkElf);
	if (player.isRaceCached(Races.WERESHARK)) {
		if (Math.round(player.HP) <= Math.round(player.minHP())) outputText("Your injuries are mounting, your fins slowly give up support as you’re caught by the ocean. The current surrounds you as you’re unable to withstand his assault any longer. ");
		else outputText("Your body stiffens, heat growing in your loins. The cool water around you is like a gentle caress from a tender lover as you find yourself caught by the current. ");
		outputText("The wereshark swims up to you, teeth barred eagerly as he inspects your form on a deeper level.\n\n");
		if (player.hasVagina()) {
			outputText("As you’re carried by the waves, he draws closer, nostrils flaring as he bars his teeth in a deviously malicious grin. Your vision falls beneath the ocean’s surface as the shadow of his underside crawls over you, pushing you down with him. His limbs crawl over your body, the smoothness of his scales brushing against you fervently as he locks you within an eager embrace.\n\n");
			outputText((player.isNaked()?"":"He wastes no time tearing apart your [armor] until your body is left exposed to the cool ocean. ")+"With nothing left to protect you from him, you can feel the dual erections split from him, brushing against your loins as he carries you with the current. The faint ridges of his abdominals grind against you as he shakily aligns his member with your folds, only letting the surrounding water suffice as any sense of lubrication.\n\n");
			if (player.vaginalCapacity() < 79) outputText("He slowly rubs his member against your labia, testing your resistance before he finally pulls you in tighter, his erection pushing into you as you adjust to his presence.");
			else outputText("He slowly rubs his member against your labia, testing your resistance only to bring himself closer to you, allowing his twin erections to push into you as you adjust to his presence.");
			outputText(" He moans softly as he begins bucking his hips, your waist held in his ravenous clutch as he bites your shoulder endearingly, lost in his infatuated state. Streams of blood flow out in your peripheral, but you don’t feel any pain, just immense pleasure while he crashes his hips against yours with each thrust.\n\n");
			outputText("You can almost taste the faint iron in your mouth as much as you can smell it. He brings his face up to yours, pupils dilated as he pants softly before rushing in for an abrupt kiss, his tongue lapping up your face, his warmth contrasting the cool ocean on your cheek. His intensity grows in voracity, thrusts losing any semblance of care, only a desperate need to get off as he bucks into you with almost complete abandon, ");
			outputText("shoving in every inch he can into you with each pump. You wrap your legs around him in desperation, holding onto him is your only option. It’s as if he’s in a futile attempt to take your breath away from you as his messy kiss practically inhales your face.\n\n");
			outputText("You tense tighter around him as he continues to fill you, pushing his length deeper into you with each thrust. You can feel yourself getting closer to the edge as you clamp down on him eagerly, returning the kiss with what remnants of strength you have as you sink into his grasp before you reach your climax.\n\n");
			outputText("Spurned by your grasp on him, you can feel his thrusts grow even more desperate as he bucks into you harder. His presence within you twitches and throbs repeatedly as he shoves every last inch he can force into you until he cums. With a heavy grunt as he presses his pecs against you, he pulls out of the kiss to bite your lip softly. ");
			outputText("You can feel the warmth of his load within you, filling you with more than you expected he could offer until he finally slips out, the cum slowly spilling out to mingle with the ocean.\n\n");
			outputText("Spent, he slowly loosens his grasp on you, allowing you to drift with the ocean’s current beneath the surface. He gives you a final, affectionate lick across the face before he darts off, leaving you alone with the fading memories of him.\n\n");
		}
		else {
			outputText("As you’re carried by the waves, he draws closer, nostrils flaring as he bars his teeth in a deviously malicious grin. Your vision falls beneath the ocean’s surface as the shadow of his underside crawls over you, pushing you down with him. His limbs crawl over your body, the smoothness of his scales brushing against you fervently as he locks you within an eager embrace.\n\n");
			outputText((player.isNaked()?"":"He wastes no time tearing apart your [armor] until your body is left exposed to the cool ocean. ")+"With nothing left to protect you from him, you can feel the dual erections split from him, brushing against your backside as he carries you with the current. The faint ridges of his abdominals grind against you as he shakily aligns his member with your ass, only letting the surrounding water suffice as any sense of lubrication.\n\n");
			if (player.analCapacity() < 56) outputText("He urgently rubs his growing erections against your ass, prodding for entry and testing your limits teasingly. He seems slightly frustrated with you as he brushes against you more, pressing his pecs against you as his grasp on you tightens. Finally, he brings himself to insert a single erection into you.");
			else outputText("He urgently rubs his growing erections against your ass, prodding for entry and testing your limits teasingly. He seems slightly frustrated with you as he brushes against you more, pressing his pecs against you as his grasp on you tightens. Finally, he lines himself up as he thrusts both of his dicks into your hole.");
			outputText("He lifts himself up to gaze mockingly into your weary eyes with his familiar grin before he lowers his face to your throat, sinking his teeth in to draw blood. In your slightly dazed state, there’s not as much pain as you’d expect, yet in your peripherals, you can still see the streams of blood spilling out into the open water. ");
			outputText("You can nearly taste the iron as much as you can smell the blood. His intensity grows as he bucks into you with greater vigor, spurned on by your scent as he fills your ass more and more with each thrust. His claws dig into your hips as he brings you tighter into the embrace, pressing you against his body further.\n\n");
			outputText("His thrusts are starting to tremble as you can feel his presence inside you twitching and throbbing intensely. Unable to take it any longer, he bites into you again, clutching you tightly as he offers you one final thrust, pushing himself as deep as he possibly can into you. You clench your ass tightly around him as you can feel your orgasm wash over you as well.");
			if (player.hasCock()) outputText(" Your [cock] twitches and throbs as you cum, unloading everything you have to offer onto his chest."+(player.cumQ() > 1999?" The water around you is starting to turn white just as the ocean relents to your virility.":""));
			outputText("\n\nSpent, he slowly loosens his grasp on you, allowing you to drift with the ocean’s current beneath the surface. He doesn’t bother with anything else before he darts off, leaving you alone with the fading memories of him.\n\n");
		}
	}
	else {
		if (Math.round(player.HP) <= Math.round(player.minHP())) outputText("Your injuries are mounting, your cuts growing too deep as the saltwater pours into your wounds. You're caught by the current around you, unable to withstand his assault any longer. ");
		else outputText("Your body stiffens, heat growing in your loins. The cool water around you is like a gentle caress from a tender lover as you find yourself caught by the current. ");
		outputText("The wereshark swims up to you, teeth barred eagerly as he inspects your form on a deeper level.\n\n");
		outputText("As you're carried by the waves, you see a twinge of disappointment in his eyes, but his grin betrays nothing aside from ferocity. With a lurch forward, his teeth sink into your shoulder, clamping down, but not enough to make you bleed... any more than you already are. ");
		outputText("His hands wrap tightly around you, pulling you deeper into his embrace, locking your limbs into place. Your strength is lost, you can't fight back even if you wanted to against his advances.\n\n");
		outputText("His body is smooth "+(silly()?"only smooth, not even the slightest hint of roughness. The way a shark should be, smooth in every which way. You're almost slipping because of how smooth he is!":"but as you rub against him in the other direction, you feel the coarseness of his denticles, much like sandpaper, it's a strange feeling.")+" ");
		outputText("The faint ridges of his abdominals compliment his body as he gropes you tighter, rubbing you against his abs. His toned arms wrap tighter around you, pulling you deeper into the water. You try to take a deep breath before the plunge before you find yourself submerged in his grasp as his legs lock around your waist.\n\n");
		outputText("He pulls back from your shoulder as his eyes graze your face until his razor-like grin seems to fade for the first time. Mercifully, he takes you back to the surface to hold you from drowning, but he hardly loosens his grip upon you. You can feel his hips sway beneath you as his tails propel himself against the surface, keeping you just above the ocean’s grace as he holds you locked in his limbs.\n\n");
		if (player.hasVagina()) {
			outputText("You feel something stir beneath you as his erections rub against your loins, prodding against your labia. He grins lewdly before leaning forward to bite your other shoulder, marking you as his whilst he aligns his growing erection to your nether lips, prodding for entry as he braces himself against you again. ");
			outputText("Your body is pulled tighter against him as he manages to slip into your walls, his free erection rubbing against your underside as he grinds against you, bucking fervently into you, bubbles forming from his head just below the water as he growls lightly.\n\n");
			outputText("Relenting, you shrink into his embrace, holding back onto him for support as you allow him to have his way with you. His thrusts are ragged, he’s practically pulling you in for each thrust against him. Your mind begins to spin as he constantly bobs up and down beneath the water. You’re left trying to gasp for air between his thrusts as you sink just below the ocean surface before rising again. ");
			outputText("You try to keep from asphyxiating as you clench against him desperately, holding onto him for dear life as he’s completely unaware of your struggle, only bothering to claim you for himself.\n\n");
			outputText("His erection is pulsating within you as he picks up the tempo eagerly to catch his release. Unable to take it any longer, your thoughts swimming in the lack of air, you clench down fervently."+(player.hasCock()?" Your erection thrums as it grinds against his abs before you cum, shooting several ropes of your seed into the open water.":"")+" ");
			outputText("With a soft cry, you clamp down on his member as your orgasm rocks through you, coating him in your girlcum to further lubricate him. He heaves a low growl as his chest heaves, brushing up against you as he cums while you take in wave after wave of his warm seed, contrasting the cool ocean.\n\n");
		}
		else {
			outputText("You feel something stir along your underside as his erections rub against your ass, prodding against your hole. He grins lewdly before leaning forward to bite your other shoulder, marking you as his whilst he aligns his growing erection to your ass, prodding for entry as he braces himself against you again. ");
			outputText("Your body is pulled tighter against him as he manages to slip past your sphincter, his free erection rubbing against your underside as he grinds against you, bucking fervently into you, bubbles forming from his head just below the water as he growls lightly.\n\n");
			outputText("You brush up against him, giving him easier access to your hole whilst trying to keep your head above the water."+(player.hasCock()?" Your [cock] grinds against his abs, the ridges of his abdominals are almost pleasurable within the water as your erection stirs against his smooth yet coarse, cool body.":"")+" He clenches tighter against you as he thrusts deeper into your ass, grinding against your body eagerly.\n\n");
			outputText("You relent, allowing him to have his way with you as you try to keep your head above the surface. He seems to lose interest in you, lost in his pleasure as he slowly sinks with you tightly wound in his embrace. Every thrust has him sink, taking you below the ocean’s surface before he brings you above again. You struggle and gasp for air, holding onto him for dear life as he remains unaware of your struggle, only bothered about claiming you for himself.\n\n");
			outputText("His erection is pulsating within you as he picks up the tempo eagerly to catch his release. Unable to take it any longer, your thoughts swimming in the lack of air, you clench down fervently."+(player.hasCock()?" With a heavy moan, your erection thrums as it grinds against his abs before you cum, shooting several ropes of your seed into the open water.":"")+" ");
			outputText("You clench your ass tighter on his member as the height of your orgasm rocks through you. He heaves a low growl as his chest heaves, brushing up against you as he cums, forcing you to take in wave after wave of his warm seed, contrasting the cool ocean.\n\n");
		}
		if (!player.blockingBodyTransformations())
			tfIntoWereshark();
		outputText("Spent, he slowly loosens his grasp on you, allowing you to float back to the surface. Not without giving you a final, mocking lick across your face, he swims away, leaving you to float back to shore.\n\n");
	}
	cleanupAfterCombat();
}
private function tfIntoWereshark():void {
	outputText("You feel your body being overcome by a strange sensation as the bite wound in your shoulder begins to heat up… at first tingling then with a pleasurable sensation. You sink into the water bathing in moonlight as your face and nose take on triangular features, your mouth filling in with rows of sharp teeths as strands of silvers run across your"+(player.hairType == Hair.NORMAL?"":" now very")+" human hairs. Your skin begins to feel strange as ");
	if (player.hasCoat()) {
		outputText("your ");
		if (player.isFurCovered()) outputText("fur");
		if (player.isChitinCovered()) outputText("chitin");
		if (player.isScaleCovered()) outputText("scales(end of cut)");
		outputText("falls out replaced with");
	}
	else outputText("you grow a full coat of");
	outputText(" shark scales with a lighter underbelly and a rough side. Your arms bone structures change as your hands gain webbed fingers and your forearms extend themselves into a pair of large blade-like fins. ");
	if (player.hasCock()) outputText("Your "+(player.normalCocks() == 0?"now fully human ":"")+"cock fattens and grows in size and length"+(player.balls <= 2?", a sloshing quartet of gonads forming beneath your twitching shaft":", a second pair of orbs falling into your ballsack and sloshing with fresh cum")+" as you harden to full mast shooting your semen into the moonlit water. ");
	outputText((player.hasVagina()?"Your vaginal lips begins to quiver uncontrollably opening and closing like a fish mouth as your walls tingle with pleasure covering with feelers like those of sharks that causes you to almost lose your mind. ":"")+"You roar to the moon, your mouthful of shark tooth glistening in the silvery light into a powerful almighty orgasm, your legs finally merging together into a powerful shark tail, your transformation into a fearsome wereshark complete!\n\n");
	CoC.instance.transformations.RearBodySharkFin.applyEffect(false);
	CoC.instance.transformations.ArmsShark.applyEffect(false);
	CoC.instance.transformations.FaceSharkTeeth.applyEffect(false);
	CoC.instance.transformations.LowerBodyWereshark.applyEffect(false);
	CoC.instance.transformations.EarsShark.applyEffect(false);
	CoC.instance.transformations.EyesFeral.applyEffect(false);
	CoC.instance.transformations.TongueHuman.applyEffect(false);
	CoC.instance.transformations.GillsFish.applyEffect(false);
	CoC.instance.transformations.WingsNone.applyEffect(false);
	CoC.instance.transformations.AntennaeNone.applyEffect(false);
	CoC.instance.transformations.HornsNone.applyEffect(false);
	var color:String;
    color = randomChoice(WeresharkRace.WeresharkScaleColors);
    CoC.instance.transformations.SkinAquaScales(Skin.COVERAGE_HIGH, {color:color}).applyEffect(false);
	CoC.instance.transformations.HairChangeColor(["silver"]).applyEffect(false);
	CoC.instance.transformations.HairHuman.applyEffect(false);
	if (player.hasCock() && player.normalCocks() < 1) {
		var selectedCockValue:int = -1;
		for (var indexI:int = 0; indexI < player.cocks.length; indexI++)
		{
			if (player.cocks[indexI].cockType != CockTypesEnum.HUMAN)
			{
				selectedCockValue = indexI;
				break;
			}
		}
		if (selectedCockValue != -1) {
			transformations.CockHuman(selectedCockValue).applyEffect(false);
			player.thickenCock(selectedCockValue, 2);
		}
	}
	if (player.hasVagina() && player.vaginaType() != VaginaClass.SHARK) CoC.instance.transformations.VaginaShark().applyEffect();
	var ngM:Number = (player.newGamePlusMod() + 1);
	var bonusStats:Number = 0;
	if (flags[kFLAGS.LUNA_MOON_CYCLE] == 3 || flags[kFLAGS.LUNA_MOON_CYCLE] == 5) bonusStats += 10;
	if (flags[kFLAGS.LUNA_MOON_CYCLE] == 2 || flags[kFLAGS.LUNA_MOON_CYCLE] == 6) bonusStats += 20;
	if (flags[kFLAGS.LUNA_MOON_CYCLE] == 1 || flags[kFLAGS.LUNA_MOON_CYCLE] == 7) bonusStats += 30;
	if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) bonusStats += 40;
	if (player.hasPerk(PerkLib.Vulpesthropy)) {
		player.createPerk(PerkLib.VulpesthropyDormant,0,0,0,0);
		player.removePerk(PerkLib.Vulpesthropy);
	}
	if (player.hasPerk(PerkLib.Lycanthropy)) {
		player.createPerk(PerkLib.LycanthropyDormant,0,0,0,0);
		player.removePerk(PerkLib.Lycanthropy);
	}
	if (!player.hasPerk(PerkLib.Selachimorphanthropy)) player.createPerk(PerkLib.Selachimorphanthropy,bonusStats,0,0,0);
	if (player.hasPerk(PerkLib.SelachimorphanthropyDormant)) player.removePerk(PerkLib.SelachimorphanthropyDormant);
	if (player.hasPerk(PerkLib.Selachimorphanthropy)){
		if (!player.hasStatusEffect(StatusEffects.HumanForm)) player.createStatusEffect(StatusEffects.HumanForm,1,0,0,0);
	}
	player.statStore.replaceBuffObject({ 'str.mult': bonusStats*0.1*ngM,'tou.mult': bonusStats*0.05*ngM,'spe.mult': bonusStats*0.05*ngM, 'minlustx': bonusStats * 0.01}, 'Selachimorphanthropy', { text: 'Selachimorphanthropy'});
	player.trainStat('str', +5, 100);
	player.trainStat('tou', +5, 100);
	player.trainStat('spe', +5, 100);
	player.trainStat('lib', +5, 100);
	player.dynStats("cor", 20);
	statScreenRefresh();
}
public function wonWithWereshark():void {
	clearOutput();
	//spriteSelect(SpriteDb.s_DarkElf);
	outputText("Seeing "+(wsG()?"his":"her")+" impending defeat your opponent smacks your face momentarily dazing you with "+(wsG()?"his":"her")+" tail and suddenly makes a turn to swim away at high speed vanishing into the dark water before you can regain your composure. ");
	outputText("Guess you won’t be dining on that fish tonight. Somewhat frustrated you grab the loot your opponent left behind in "+(wsG()?"his":"her")+" quick retreat.\n\n");
	menu();//outputText("\"<i></i>\"\n\n");
	addButtonIfTrue(3, "Tame It", SceneLib.campMakeWinions.tamingAttempt, "Req. to have Job: Tamer", player.hasPerk(PerkLib.JobTamer));
	addButton(4, "Leave", cleanupAfterCombat);
}
	}

}