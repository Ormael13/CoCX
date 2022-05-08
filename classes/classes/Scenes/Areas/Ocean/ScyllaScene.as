/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Ocean 
{
	import classes.*;
	import classes.Scenes.SceneLib;

	public class ScyllaScene extends BaseContent
	{
				
		public function ScyllaScene() 
		{
		}
		
public function oceanScyllaEncounter():void {
	clearOutput();
//	spriteSelect(SpriteDb.s_izma);
	outputText("As you row around on the ocean; tentacles surge around your boat, grabbing your leg and pulling you to the watery deeps under! As you scan the water to find your pseudo attacker, you end up face to face with what looks to be a mix between an octopus and a woman. Eight long tentacles grow at the place where her legs should be, each easily twice her length. She’s clearly intent on using them on you as she pulls you closer to her and opens her arms wide to welcome you in. That and the fact she's smirking like she’s about to have dinner tells you that you're clearly on the menu.\n\n");
//	if (flags[kFLAGS.CODEX_ENTRY_SHARKGIRLS] <= 0) {
//		flags[kFLAGS.CODEX_ENTRY_SHARKGIRLS] = 1;
//		outputText("<b>New codex entry unlocked: Shark-girls & Tigershark-girls!</b>\n\n")
//	}
	outputText("You are fighting a Scylla!");
	if (!player.canSwimUnderwater()) player.createStatusEffect(StatusEffects.UnderwaterOutOfAir,0,0,0,0);
	startCombat(new Scylla());
	//spriteSelect(SpriteDb.s_izma);
}

public function oceanScyllaWin():void {
	//spriteSelect(SpriteDb.s_sharkgirl);
	clearOutput();
	outputText("The scylla is defeated, weakly trying to get back to the lightless depths below. ");
	if (player.canSwimUnderwater()) {
		outputText("You could take advantage of her and punish her for trying to impose herself on you. Do you rape her?\n\n");
		menu();
		addButton(14, "No", oceanScyllaWin2);
		if (player.lust >= 33 && player.gender > 0) {
			addButton(0, "Fuck Her", oceanScyllaWin3);
			SceneLib.uniqueSexScene.pcUSSPreChecksV2(oceanScyllaWin);
		}
		else outputText("You're not aroused enough to rape her.");
	}
	else {
		outputText("You could rape her but, sadly, you would have trouble fucking anything underwater without drowning in the first place. Therefore, you head back to your boat and row back to the beach.");
		doNext(cleanupAfterCombat);
	}
}
public function oceanScyllaWin2():void {
	clearOutput();
	outputText("You are not interested in fucking the tentacle bitch at the time and so you swim back to your boat.\n\n");
	cleanupAfterCombat();
}
public function oceanScyllaWin3():void {
	//spriteSelect(SpriteDb.s_sharkgirl);
	clearOutput();
	outputText("Sadly for her, you are as good a swimmer as you are a fighter and as you close the distance, she is unable to deny you anymore. You smirk and slowly pull her tentacles out of the way, exposing her massive pussy");
	sceneHunter.selectGender(dickF, vagF);
	//==================================
	function dickF():void {
		var x:Number = player.biggestCockIndex();
		outputText(".\n\nShe gives a pleading look looking as if begging you not to do this, but you have decided not to listen. You pull all her legs apart and align your [cock] with her hole then force your way in to the scylla’s complete dismay. The girl tries to slap you, but you have her arms under control as you begin to piston in and out of her massive cunt. ");
		outputText(""+(player.cocks[x].cockLength >= 10 ? "":"Truthfully, she is too loose for you, and it takes you a full hour fucking to even reach satisfaction, but you still manage to feel some form of pleasure. ")+"The scylla has issues controlling her own lust as instead of trying to shove you away, her powerful tentacles try to drag you in deeper, only helping you fuck her all the better. Before long you start losing control as your [cock] begin pulse with the telltale sign of impending orgasm. \n\n");
		outputText("You finally groan and bottom in, painting her ink hole white with your fluids as black ink spreads in the water around you an obvious sign of your partner having reached her peak. You swim back to the beach/your boat still giddy from the action.\n\n");
		player.sexReward("vaginalFluids","Dick",true,false);
		cleanupAfterCombat();
	}
	function vagF():void {
		outputText(" to view, however what you are interested in is not her pussy as much as the tentacle themselves.\n\n");
		outputText("She gives a pleading look, as if begging you not to do this, but you have decided not to listen as you shove her tentacle right into your own hole, moaning in delight at the sheer size of her limb. You begin to grind against her member like it was a huge cock, and considering octopus tentacles are covered with nerves she can’t help but shiver in pleasure at the forced ministrations of her limbs. ");
		outputText("She tries to insert her other tentacles inside you, but you deny her, making it clear that she is on the receiving end and not the other way around. Unable to fuck anything else but herself, she proceeds to insert her remaining tentacle in her own pussy, the bubbles rushing out of her mouth only telling her delight at her own ministrations.\n\n");
		outputText("You finally achieve orgasm, your cunt gripping on her tentacle like a vice as you cum in the water. The scylla is far from satisfied still busy fucking her own cunt, but you don’t care, leaving her to her masturbation as you swim back to your boat.\n\n");
		player.sexReward("Default", "Vaginal", true, false);
		cleanupAfterCombat();
	}
}

public function oceanScyllaLoss():void {
	clearOutput();
	oceanScyllaLoss2();
}
public function oceanScyllaLoss2():void {
	outputText("As you collapse in the water, unable to continue fighting, the scylla grapples you with a sultry smile"+(player.canSwimUnderwater() ? "":". She force-feeds you a strange kelp like plant and to your surprise you can now manage to breath underwater. Likely until the girl is done with you")+".\n\n");
	if (player.gender == 0) {
		outputText("This doesn't take long though - the tentacle bitch quickly discovers that you don't have any genitalia to play with. Grumbling, she leaves, taking some of your gems.\n\n");
		//Maybe someon could write anal-only scene?
		cleanupAfterCombat();
		return;
	}
	outputText("The scylla anchors your boat, preventing it from moving away as she brings you to what looks like an underwater cave. Once there, her intentions becomes clear as she begins to strip you.\n\n");
	sceneHunter.selectLossMenu([
			[0, "Vagina", vagF, "Req. a vagina", player.hasVagina()],
			[1, "Dick", dickF, "Req. a dick", player.hasCock()]
		],
		"Since you're not going anywhere, maybe you could enjoy the situation a bit? If you promise not to struggle, she might even let you choose the part to play with.\n\n"
	);

	function vagF():void {
		outputText("The scylla starts by pulling your head between her tentacles right into her massive cunt. She doesn't need words to tell what she wants, and you begin to lick her insides thoroughly.\n\n");
		outputText("You feel something pushing its way down into your [pussy] and gasp in delight as it reaches deeper and deeper up to your cervix. You don't have much time to think about it as the scylla’s tentacle starts to squirm inside of you, driving you insane with pleasure. The scylla, however, isn't satisfied with one hole and soon inserts a second tentacle right into your [asshole] fucking both of your holes with honed expertise. Gods above, her suckers feels like bumps on a cock, and they keep massaging your entire canal!\n\n");
		outputText("Your brain starts to turn to mush from the intense penetrations as her vagina clamps and unload a thick cloud of ink right into your face. The taste isn't really that bad for something normally used for calligraphy. As the scylla orgasms, your eyes roll back as her tentacle completely loses any semblance of restraint, finishing you off. You lay still on the seafloor completely messed up as you lose consciousness.\n\n");
		player.sexReward("Default","Vaginal",true,false);
		cleanupAfterCombat();
	}
	function dickF():void {
		outputText("The scylla forces you down on the seabed, sitting on your chest as she goes straight for the kiss. Surprised by her straightforward actions, you don't see one of her tentacles wrapping around your [penis] and slowly begin to stroke you as you both exchange saliva. You moan in her mouth as the makeshift onahole begins to slowly milk you, one of the tentacle tips caressing your tip for the best hand job you’ve ever felt. As your cock hardens, she moves her enormous vagina to engulf your [penis], her face taking on a pleased expression as she impales herself on you. ");
		outputText("Her pussy is like a gigantic mouth as it closes around your dick perfectly, sucking you in with a vacuum and making you jerk upwards, unable to stop fucking those wondrous walls. Soon you’re cumming as her vagina sucks the semen out of you, massaging it perfectly and creating naughty noises underwater. Not wanting to be useless, you start to grope her breasts, making her moan deliriously as she keeps eating you.\n\n");
		outputText("After continuously cumming for a fair few hours, you lose consciousness, only to wake up back in your boat. Weirdly, you got 20 more gems than before. Did the girl just pay for raping you? You look down by the side of the boat just in time to see the Scylla wave a goodbye before diving back into the deeps.\n\n");
		player.sexReward("vaginalFluids", "Dick");
		monster.createPerk(PerkLib.NoGemsLost, 0, 0, 20, 0);
		cleanupAfterCombat();
	}
}

	}
}