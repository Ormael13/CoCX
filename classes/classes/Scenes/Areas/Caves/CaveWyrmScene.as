/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;

	public class CaveWyrmScene extends BaseContent
	{
		
		public function CaveWyrmScene() 
		{
		}
		
public function berserkingCaveWyrmEncounter():void {
	clearOutput();
//	spriteSelect(32);
	if (rand(3) == 0) flags[kFLAGS.HERM_CAVE_WYRM] = 1;
	else flags[kFLAGS.HERM_CAVE_WYRM] = 0;
	outputText("As you wander the cave you are suddenly surprised as a shimmering neon blue light rush at you at increasing speed. Before you can figure out what is going on a bloodcrazed lizard "+(flags[kFLAGS.HERM_CAVE_WYRM] > 0 ?"herm":"girl")+" with a pair of war axe charge at you her fluorescent eyes glimmering with uncontained rage.\n\n");
//	if (flags[kFLAGS.CODEX_ENTRY_] <= 0) {
//		flags[kFLAGS.CODEX_ENTRY_] = 1;
//		outputText("<b>New codex entry unlocked: Cave Wyrms!</b>\n\n")
//	}
	outputText("You are fighting a Berserking cave wyrm!");
	startCombat(new CaveWyrm());
}

public function winningOverCaveWyrm():void {
	clearOutput();
	outputText("You approach the defeated lizard girl intending to punish her for her assault but the drop of precum fuming on the ground like acid next to her cunt tells you that it's a VERY bad idea. Who knows what your ");
	if (player.hasVagina()) outputText("pussy" + (player.hasCock() ?" or ":"") + "");
	if (player.hasCock()) outputText("cock");
	outputText(" might end up like if any of these fluids gets in contact with them. Deciding against it you smash the " + (flags[kFLAGS.HERM_CAVE_WYRM] > 0 ?"herm":"female") + " unconscious instead and get your spoils. The locals will better use her then you would.");
	cleanupAfterCombat();
}	
public function loosingToCaveWyrm():void {
	clearOutput();
	outputText("You fall to the ground, defeated and look for a way to escape the she-maniac but a jet of blue fire on your right reminds you that if you attempt anything she will roast you alive, so you turn back to face your assailant.\n\n");
	outputText("The lizard girl grin as her pussy slowly begins to drool a clear drop of blue fluid. You are keenly aware of what is about to happen as she casually walks to you and begin to remove her gear.\n\n");
	if (player.hasCock()) outputText("\"<i>Pathetic… I was hoping for a mighty warrior not a welp unworthy of fertilising my eggs. You know what happens to losers down in these caves? Because you are about to find out the hard way. I have been looking for someone to sooth my itches with for hours. That said your unworthy of me as a female so you're going to use your cute little tongue instead.</i>\"\n\n");
	else {
		outputText("As she gets to you to have  a check at her catch she sigh disappointed as she realise you have no penis.\n\n");
		outputText("\"<i>You know what happens to losers down in these caves? Because you are about to find out the hard way. I have been looking for someone to fuck with for hours but since you have no cock to do it you're going to use your cute little tongue instead.</i>\"\n\n");
	}
	outputText("She grabs you by the hair and pulls you toward her cunt.\n\n");
	outputText("\"<i>Get to it and don’t make me repeat myself twice!</i>\"\n\n");
	outputText("You get the message and let your tongue past your lips into her fold. For some reason as your tongue comes into contact with the juices of the lizard girl it begins to throb uncontrollably until at some point it's dye the same color as the radioactive blue fluid its coated into. Something takes hold of your mind there and urges you to finish the job. You need more, you want more of that fluid!\n\n");
	outputText("\"<i>Ah yes that's a good slut! Lick me clean.</i>\"\n\n");
	outputText("She shove you closer filling your nose full on that pussy scent and you outright lose it eating her out in earnest as you try to fill your mouth with this nectar of hers. By now your tongue feels sensible like a clit yet at the same time you manage to reach corners of the woman pussy you never could before proding all the way up to her womb.  Eventually the reptilian woman cry in orgasm as her pussy flood your face with your juice reward, you mouth gladly swallowing as much of it as you can before the warrior finally knock you out satisfied with your handiwork.\n\n");
	outputText("When you wake up she is already gone but at least she left your equipment in a tidy pile next to you.\n\n");
	cleanupAfterCombat();
}
public function loosingToHermCaveWyrm():void {
	clearOutput();
	outputText("You fall to the ground defeated and look for a way to escape the she-maniac but a jet of blue fire on your right reminds you that if you attempt anything she will roast you alive, so you turn back to face your assailant.\n\n");
	outputText("The lizard-herm grin as her 13 inch cock, already erect, begins to dribble precum. You are keenly aware of what is about to happen as she casually walk to you and begin to remove her gear.\n\n");
	outputText("\"<i>You know what happens to losers down in these caves? Because you are about to find out the hard way. I have been looking for someone to fuck with for hours.</i>\"\n\n");
	if (player.hasVagina()) {
		outputText("Before you can do anything, the lizard herm forces you to the ground, stripping you of your gear as she grabs your arms and pull your legs apart. You try and keep them closed but she is already blocking them with her body. She however swiftly remind you who is in charge.\n\n");
		outputText("\"<i>Don’t resist and I perhaps won't need to scorch your face, got it bitch?</i>\"\n\n");
		outputText("You comply, horrified, as she begins to slowly tease your pussy with her tip. Before you get any chance to react she shove her entire length in, making your eyes go wide. Warm precum slowly leak from her cock into your cunt and to your surprise you vaginal walls begins to mold and accomodate the reptilian prick as the warm fluid smears against them. You look down to your pussy in time to notice the lips have taken on a weird blue glow. Warmth spread from it to the rest of your body");
		if (player.hasBreasts()) outputText("your nipple hardening at the thought of letting that powerful herm mate you");
		outputText(". She moves her face down right next to yours and give it a playful lick with her long, neon blue, glowing lizard tongue.\n\n");
		outputText("\"<i>Like the gift of my precum girl? Down here it's eat or be eaten and I can’t afford to be picky. That said you have one great pussy! Put some heart into it and I’ll perhaps get you off too, maybe even impregnate you if you are very lucky as deserves a proper warrior maiden.</i>\"\n\n");
		outputText("The lizard herm begin to pant in delight as she forcefully pull in and out of you. You moan as her length works your [vagina], holding her tight to you by wrapping your arms around her body in a lust addled hug. You cry in ecstasy as she finally reach her orgasm filling your warm thirsty cunt full of glowing blue seed. Thankfully, you lose consciousness just as she ready for round two.\n\n");
		outputText("When you wake up she is already gone but at least she left your equipment in a tidy pile next to you.\n\n");
	}
	else {
		outputText("Before you can do anything, the lizard herm forces you into the ground, stripping you of your gear as she pushes you on all fours and grab your [ass]. You try to crawl away but she swiftly remind you who is in charge by breathing fire just ahead of you.\n\n");
		outputText("\"<i>Don’t resist and perhaps I won't need to scorch your back, got it buttslut?</i>\"\n\n");
		outputText("You comply, horrified, as she began to slowly align herself with your pucker. Before you get any chance to react she shove her entire length in, making your eyes go wide. Warm precum slowly leak from her cock into your ass and to your surprise you hole begins to loosen on its own as the warm fluid spreads against its walls. She move her face down right next to your ear and give it a playful lick with her long, neon blue, glowing lizard tongue.\n\n");
		outputText("\"<i>Now that's what I call a hole! Put some heart into it and I'll perhaps get you off too.</i>\"\n\n");
		outputText("The lizard herm begin to pant in delight as she forcefully pull in and out of you, slapping your [ass] at about every five thrusts. By the time she finally reach her orgasm, filling your abused hole full of glowing blue seed, your butt cheeks are imprinted red with her hand shape. Thankfully, you lose consciousness just as she ready for round two.\n\n");
		outputText("When you wake up, she is already gone and your ass is still leaking with bluish fluorescent cum but at least she left your equipment in a tidy pile next to you.");
	}
	if (player.isGargoyle() && player.hasPerk(PerkLib.GargoyleCorrupted)) player.refillGargoyleHunger(30);
	player.orgasm();
	cleanupAfterCombat();
}
		
	}
}