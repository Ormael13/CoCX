/**
 * ...
 * @author Liadri and other ppl who scenes gets here
 */
package classes.Scenes.Camp 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class UniqueCampScenes extends BaseContent
	{
		
		public function UniqueCampScenes() 
		{	//flags[kFLAGS.ALRAUNE_GROWING] == 15 - 2 weeks old children
		}	//flags[kFLAGS.ALRAUNE_GROWING] == 22 - 3 weeks old children

public function manageyourgarden():void
{
	clearOutput();
	outputText("Your daughters are busy bickering about whose the most beautiful flower of them all.\n\n");
	menu();
	if (flags[kFLAGS.ALRAUNE_GROWING] > 14) addButton(0, "Play", playwithyourplantdaughters);
	if (flags[kFLAGS.ALRAUNE_DAILY_WATERING] < 1) addButton(9, "Water", wateryourgarden);
	addButton(14, "Back", inventory.stash);
}

public function wateryourgarden():void
{
	clearOutput();
	outputText("You water your sprouts, making sure they don’t lack anything. This includes spending a little time ensuring no weeds get so much as half a chance to encroach on your private garden.\n\n");
	flags[kFLAGS.ALRAUNE_DAILY_WATERING] = 1;
	if (flags[kFLAGS.ALRAUNE_GROWING] < 22) flags[kFLAGS.ALRAUNE_GROWING]++;
	doNext(camp.returnToCampUseOneHour);
}

public function playwithyourplantdaughters():void
{
	clearOutput();
	outputText("You decide to set some time aside to play with your sprouts. You tell them as much while you pull water toys you bought in Tel'Adre out of your pack. The happiness on their little faces warms your heart.\n\n");
	outputText("\"<i>Wow, really mom? You are the best!</i>\"\n\n");
	outputText("Your daughters all cheer up as they pick up the toys and rush to the rivers to fill them up. Soon you’re all splashing each other. The experience is refreshing and soothing. You never thought you would appreciate having children this much. Perhaps parenting comes included in the whole “being a child of a fertility goddess” deal, you ponder, before being splashed in the face by one of your daughters, breaking you out of your reverie, and dragging you back into the game.\n\n");
	doNext(camp.returnToCampUseOneHour);
}

public function playsRathazulAndSoulgemScene():void
{
	clearOutput();
	spriteSelect(49);
	outputText("As you pass by Rathazul considers you, then asks \"<i>May I ask what you’re planning to do with that soul gem of yours? Because yes I know exactly what this dangerous crystal you’re carrying is</i>\"\n\n");
	outputText("When you mention you want to create a golem, Rathazul seems to lose himself in thought, as if trying to remember something.\n\n");
	outputText("\"<i>Years ago, when I was younger, I knew a woman who specialised in such constructs. She was obsessed with creating the perfect servant. However when the demons came, hungry for power, she embraced them instead of fleeing and became one of those aberrations. Her laboratory is likely still located in the same area as before - hidden somewhere in the place now called the blighted ridges. If you go there, be careful. ");
	outputText("Losing her humanity likely didn't do any good to her already fragile sanity. None can say  what you will find.</i>\"\n\n");
	outputText("You thank Rathazul for telling you this as this might just be the information you need.");
	flags[kFLAGS.DEN_OF_DESIRE_QUEST] = 1;
	doNext(camp.returnToCampUseOneHour);
}

public function droppingToZeroSatietyAsGargoyle():void
{
	clearOutput();
	if (player.hasPerk(PerkLib.GargoylePure)) {
		outputText("Unable to sustain your movement longer you are forced into an emergency rest. And only wake up a few hours later after absorbing enough energy to regain movement.\n\n");
		doNext(camp.returnToCampUseEightHours);
	}
	else {
		outputText("Unable to sustain your movement longer you are unable to maintain control, you need sex NOW!\n\n");
		if (player.hasVagina()) {
			outputText("You rush into the mountain starved for energy and seduce the first minotaur you can find putting your drooling pussy on display. The minotaur, used to having to fight for a hole to fuck, does not complain and lies down for you to take him in.  Your eyes zero in as a dollop of pre escapes his ribbed horse-like member, locating the source of the scent.\n\n");
			//Too small
			if(player.vaginalCapacity() < monster.cockArea(0)) {
				outputText("Restraint evaporates as you lower yourself, your aching " + vaginaDescript(0) + " desperate for contact.  Your thighs quiver as you touch his wobbling column of maleness, the slick pre-cum soaking into your engorged clitty, filling it with tingling warmth.  Oblivious to the apparent size difference, your body pushes downwards, your knees giving out, forcing his flared head against your " + vaginaDescript(0) + " roughly.  The need to be speared on the beast's meat is overwhelming urged on by constantly leaking pre-cum currently pumping into your love-canal.  With strength born of unnatural lust, you grip his flanks and drive yourself downwards, feeling yourself stretch painfully as you take in his length.  ");
			}
			//Good match
			if(player.vaginalCapacity() >= monster.cockArea(0) && player.vaginalCapacity() < monster.cockArea(0) * 1.5) {
				outputText("Restraint evaporates as you lower yourself, your aching " + vaginaDescript(0) + " desperate for contact.  Your thighs quiver as you touch his wobbling column of maleness, the slick pre-cum soaking into your engorged clitty, filling it with tingling warmth.  You push downwards eagerly, happily noting that you should be able to accommodate his length and girth.  The overly wide head slips inside, easily lubricated with his copious fluids, musky pre-spunk lubricating your passage with its intoxicating sensation.  With deliberate slowness, you sink down along his shaft, shuddering once, twice, then three times as you pass each of the thick fleshy rings along his length.  Eventually, you bottom on him.  ");
			}
			//Bigger than he is
			if(player.vaginalCapacity() >= monster.cockArea(0) *1.5) {
				outputText("Restraint evaporates as you lower yourself, your aching " + vaginaDescript(0) + " desperate for contact.  Your thighs quiver as you touch his wobbling column of maleness, the slick pre-cum soaking into your engorged clitty, filling it with tingling warmth.  With a lusty giggle you slip his head inside your " + vaginaDescript(0) + ", allowing him to drool his musky pre-seed deep inside your wide love-canal.  Sinking down slowly, your easily encompass all of his equine-like member, enjoying the feeling of his three thick cock-ridges as they slip through your lips.  Eventually you take all of him, wishing he was just a bit bigger...");
			}
			//Resume sexings, p2
			outputText("\n\nAt last you feel the minotaur's meaty hands grab you by the " + hipDescript() + ", forcefully grinding up and down along his length like a cheap sex-toy.  ");
			//Size variants
			//Too small
			if(player.vaginalCapacity() < monster.cockArea(0)) outputText("Every ridge of his " + monster.cockDescriptShort(0) + " presses tightly against your walls, smearing more of his wondrous pre-seed into your body with every stroke.  ");
			//Just right
			if(player.vaginalCapacity() >= monster.cockArea(0) && player.vaginalCapacity() * 1.5 < monster.cockArea(0)) outputText("Every stroke of his " + monster.cockDescriptShort(0) + " deposits a bit more of his wondrous preseed into your body, spreading a relaxing warmth throughout your groin.  ");
			//Too big
			if(player.vaginalCapacity() *1.5 >= monster.cockArea(0)) outputText("Every stroke of his " + monster.cockDescriptShort(0) + " slides easily into your " + vaginaDescript(0) + ", allowing him to slowly build up a puddle of his wondrous druggy pre-seed into your aching womb.  ");
			//Resume!
			outputText("The minotaur picks up the pace, heartbeat thudding through his rigid meat, making it convulse and vibrate as he slams you down on it over and over again.  You feel his balls twitching against your ass as his cock visibly thickens, bulging out at the base and slowly fattening inside you until it feels fit to burst.  With a throaty roar he cums at last, fountaining seed directly into your womb.  Your eyes roll back as it fills you, swooning as you feel the liquid pleasure seeping into you.  Your " + vaginaDescript(0) + " clamps down, trapping his seed inside, his orgasm dragging on as his balls begin to shrink.  The copious fluid fills your womb, distending your belly painfully.  The minotaur gives one last powerful spurt, the force pushing you off his " + monster.cockDescriptShort(0) + ", just as you both reach total sexual satisfaction.\n\n");
			//ITS OVER
			outputText("He passes out with a contented sigh, balls shrunk down to the size of baseballs and his cock still dribbling cum.  You pull yourself to your feet unsteadily, drunk with pleasure as you stagger away, clamping your " + vaginaDescript(0) + " down unconsciously to hold in his wonderful seed.");
			if(player.vaginalCapacity() < monster.cockArea(0)) outputText("\n\nMixed with the sheer sexual pleasure, you feel a diffuse pain and numbness coming from your much-abused " + vaginaDescript(0) + ", but decide with a smile that it was well worth it as his cum numbs away the last of the pain.");
			player.orgasm();
			dynStats("spe", -.5, "int", -.5, "sen", 1.5, "cor", 1);
		}
		else {
			outputText("You rush into the forest starved for energy and forcefully grab the first goblin you can find wiping your rock hard cock against her face with clear intent. The goblin getting the idea that your pretty much ready to kill to get laid decide against puting any form of resistance.\n\n");
			var x:Number = player.cockThatFits(monster.vaginalCapacity());
			outputText(images.showImage("goblin-win-male-goblinboners"));
			outputText("You begin to fondle your cock as you walk towards the unsuspecting goblin girl, taking in the sight of her perfectly round cheeks as they jiggle against her hurried movements, her soft thighs clenched against the eager hand between them.  Bending down, you quickly grab the goblin's ample hips, causing the girl to squeak in surprise as she turns around to catch the sight of your erect length.\n\n");
			outputText("\"<i>W-woah!  Hey stud, whaddya think you're doing back there?</i>\" she yelps, more surprised than scared at your sudden appearance.  Instead of answering, you decide to grab your cock and slap it against the bare flesh of her ass, whilst your victim anxiously awaits your next move.  You take your time massaging the goblin's slutty ass with your bare hands before sliding your " + cockDescript(x) + " in between her soft cheeks.  ");
			outputText("Your horny victim appears impatient, attempting to grind against you as she spreads her moist lips open, enthusiastic that she's found someone willing to mate with her.  You slap her ass firmly as you quicken your thrusting - seconds before finally plunging your dick inside of the panting whore, pushing her forwards violently as you enter her tight snatch.\n\n");
			outputText("You roughly pound against the goblin girl, maintaining a firm grip on her hips while she squeals with delight.  The sound of your groin slapping against her echoes throughout the area, followed by your grunting and the goblin's moans of ecstasy.  Your victim struggles to lift herself up by her arms, only to collapse back down from the feeling of you invading her insides.\n\n");
			outputText("Eventually you begin to feel yourself coming to a climax, your movements getting faster and faster as you build up to your release.  The goblin below you has already lost herself to the pleasure of your " + cockDescript(x) + ", her eyes rolled upwards and her tongue drooling out of her mouth while her slutty face rubs against the ground you're currently pounding her on.  With a final thrust, your hips lurch forward as you paint her insides with your thick spunk, ");
			outputText("relishing in the feeling of your ejaculate filling her up to the brim and plugging her entrance.  You slowly release yourself from her tight body, finishing off by covering her curved back and pert rump with the rest of your seed.\n\n");
			outputText("You pick yourself back up, jerking yourself slowly as cum dribbles from your " + cockDescript(x) + " onto the collapsed body of the goblin.  It'll be awhile before she comes back to consciousness, but you're certain she'll have a better appreciation for sex when she does.");
		}
		player.refillGargoyleHunger(30);
		doNext(camp.returnToCampUseOneHour);
	}
}

public function badendManticoreOuroboros():void {
	clearOutput();
	outputText("You eye your penis then your tail pussy then back at your penis. The smell of precum dripping from your maleness.. it drives you insane with desire.");
	outputText("\n\nWithout thinking any further you curl your tail between your legs and plug it to your own twitching cock. The pleasure is instantaneous as you instinctively sting yourself and start cuming nonstop into your tail. Your legs twitches and spasms making you fall to the ground on short notice. Your brain begins to melt as your thoughts shrinks to cuming and feeding, your own fluids fueling you with the endless supply of stamina needed to never stop cuming.");
	outputText("\n\nGuess this is what you get for messing around with designs known only to mother nature. Even if you tried to stop now you wouldn't be able to as you tail instinctively tries to milk your dick to a last drop that will never come. Unable to form coherent thought anymore you become a creature of pure basest instinct. Month and year will pass before ultimately you die out of old age having long lost the ability to process rational thought.");
	EventParser.gameOver();
}

	}

}