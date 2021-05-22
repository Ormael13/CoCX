/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves 
{
	import classes.*;
	import classes.BodyParts.Antennae;
	import classes.BodyParts.Arms;
	import classes.BodyParts.Ears;
	import classes.BodyParts.Eyes;
	import classes.BodyParts.Face;
	import classes.BodyParts.Gills;
	import classes.BodyParts.Hair;
	import classes.BodyParts.Horns;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.RearBody;
	import classes.BodyParts.Skin;
	import classes.BodyParts.Tail;
	import classes.BodyParts.Tongue;
	import classes.BodyParts.Wings;
	import classes.Items.Shields.DarkAegis;
	import classes.Scenes.Dungeons.EbonLabyrinth;
	import classes.Scenes.SceneLib;
	import classes.display.SpriteDb;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.lists.BreastCup;
	
	public class DarkSlimeScene extends BaseContent
	{
		public function DarkSlimeScene() 
		{
		}

public function cavesDarkSlimeEncounter():void {
	clearOutput();
    spriteSelect(SpriteDb.s_darkgoogirlsprite_16bit);
	if (player.gooScore() >= 11 || player.magmagooScore() >= 13 || player.darkgooScore() >= 13) {
		outputText("You take the turn at the end of the cave and run right into a dark slime. For a few second the both of you consider each other before the slime shrugs and simply asks.\n\n");
		outputText("\"<i>No luck finding fluids that way?</i>\"");
		outputText("You didn’t find any and if you did you would have pumped it out until it ran dry.\n\n");
		outputText("\"<i>Well darn, if you spot a fleshling do share!</i>\"");
		outputText("Well that was easy… you can only guess slimes don’t get much out of other slimes’ bodies. You proceed deeper into the caves unhindered, though, you wish you indeed had found someone to milk the fluids off.\n\n");
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		outputText("As you engage in a new tunnel you come face to face with a purplish jelly-like woman. She giggles upon spotting you, her small, sphere-shaped core emitting an ominous light as she surges toward you with a gooey smile.\n\n");
		outputText("\"<i>Dinner is served! Your fluids are mine, so surrender them now intruder and I promise to make it very pleasurable for you!</i>\"\n\n");
//		if (flags[kFLAGS.CODEX_ENTRY_] <= 0) {
//			flags[kFLAGS.CODEX_ENTRY_] = 1;
//			outputText("<b>New codex entry unlocked: Dark Slime!</b>\n\n")
//		}
		outputText("You are fighting a dark slime!");
		startCombat(new DarkSlime());
	}
}

public function beatingDarkSlime():void {
	clearOutput();
	spriteSelect(SpriteDb.s_darkgoogirlsprite_16bit);
	outputText("You smirk as the creature falls to the ground, flattened in every possible way.\n\n");
	outputText("\"<i>L..look, I didn't mean to try and eat you… I mean yes I did but it’s just my instincts, I need fluids and…</i>\"\n\n");
	outputText("Now that the slime is clearly defeated, you consider your options. You could rape her but then realise it might as well be EXACTLY what she wants. Heck there's no telling if she won’t turn the table on you. What do you do with her?");
	menu();
	addButton(1, "Scram", beatingDarkSlimeScram);
	addButton(2, "Use her", beatingDarkSlimeUseHer);
	addButton(3, "Letz rape", LetzRape2);//curry(, true)
}

public function LetzRape2():void {
	LetzRape(true);
	cleanupAfterCombat();
	doNext(camp.returnToCampUseOneHour);
}
public function LetzRape(letzRape:Boolean = false):void {
	clearOutput();
	spriteSelect(SpriteDb.s_darkgoogirlsprite_16bit);
	if (player.blockingBodyTransformations()) {
		outputText("The slime moves to you, licks you and then recoils in frustration.\n\n");
		outputText("\"<i>Just what the hell have you done to your body! You’re outright inedible, I can’t actually eat that! Get the hell out back from where you came and tell whatever species you're from not to visit the area. What a waste of my time.</i>\"\n\n");
		outputText("The slime moves away, grumbling something to herself. Guess you’re having it easy thanks to the permanence of your form.\n\n");
	}
	else {
		if (!letzRape) {
			outputText("You simply stay still as the slime slowly flows over you, covering your legs to prevent your escape.\n\n");
			outputText("\"<i>Mmmm...a prey that doesn’t resist. How delicious…. Nice body, too. Quite the catch I have found, huh. I think I will help myself.</i>\"\n\n");
		}
		else {
			outputText("You smirk and proceed to play with the slime’s body, discarding your gear to the side as you prepare for some nice relief. However the moment your naked body comes into contact with her she swiftly uses her mass to shift the position, forcing you on your back as she now towers over you.\n\n" +
			"\"<i>Hehehe… you poor idiot you thought you could just rape the rapist? I got you right where I wanted and now that you're naked I can proceed with what I had in mind, starting with making you more compliant.</i>\"\n\n" +
			"You realise the depth of your mistake as your body begins to tingle. Obviously her fluids are filled with aphrodisiacs and they began affecting you the moment you were in contact with her body. " +
			"Now that you are weakened by your own arousal the slime has no issue taking over, some of her drool falling over your chest as she slowly covers you. Eventually, you are left floating inside her body as she forces you to sit, a slimy hand holding you up. ");
		}
		outputText("Some of her drool falls over your chest as the slime slowly covers you. Eventually, you are left floating inside her body as she forces you to sit, a slimy hand holding you up. You aren’t even granted the dignity of undressing yourself as the slime forcefully makes your gear float off with her oozing masses. ");
		if (player.hasVagina()) outputText("You barely register your nakedness as your pussy is forced open, your eyes going wide as the slime fills you with a solid dick shaped goo mass. At first you try to close your pussy to keep it out, but the more you tighten, the deeper it goes… forcefully fucking you through the small hole no other cock but hers could enter! Your struggle is short lived, your lips opening wide again as the goo methodically fucks you up to the cervix. ");
		if (player.hasCock()) outputText("The slime mass moves to your cock "+(player.gender == 3 ? "as well ":"")+"forcefully entering your urethra and violating you from the inside, filling your balls and forcefully drinking the cum out of them. The pleasure of your cock being violated in this way is almost too much to bear, your body is spasming from the forced consecutive ejaculations.");
		outputText("You want to scream, but the slime is not finished yet as she proceeds to take your anus just the same as your canal"+(player.gender == 3 ? "s":"")+". The wild "+(player.gender == 3 ? "s":"")+"");
		if(player.gender == 3) outputText("double ");
		else outputText("triple ");
		outputText("penetration is driving your crazy. your nipples going hard from this over stimulation. ");
		if (player.biggestTitSize() >= BreastCup.A) outputText("Not one to miss out on any nutrient source, the slime suddenly grabs your breasts, forming a tight goo bikini around your areola as it forces the milk out. ");
		outputText("You can’t hold it anymore and begin to scream in pleasure.\n\n");
		outputText("\"<i>Shhhhh, don’t be so loud… don’t you see I’m working? Here, have a treat.</i>\"\n\n");
		outputText("You barely register what she said as her head, which is right next to your shoulder, pulls you into a forceful kiss, her tongue going all the way in, violating your throat and filling your stomach with slime. The aphrodisiac in her goo makes short work of what's left of your resolve, as the more she fucks you, the more you want it. Soon you begin kissing her in earnest and bucking your hips inside your liquid prison. Your fluids are flowing at a steady rate, ");
		if (player.biggestTitSize() >= BreastCup.A) outputText("even dyeing her goo with your breast milk ");
		outputText("but it's not enough. Soon the goo begins to close on you, submerging you entirely until there's no pockets of air left for you to breathe. She more than makes up for your inability to make a sound by moaning twice as hard.\n\n");
		outputText("\"<i>Mmmmm Ahhhhh yeshhh... become one with meee...</i>\"\n\n");
		outputText("You barely register her core coming face to face with your head as it start to emit a darker, purple mucus towards you. You try to squirm away, but you are quickly force-fed the liquid through all of your orifices, starting with your ");
		if (player.hasVagina()) outputText("gushing pussy");
		if (player.gender == 3) outputText(" and ");
		if (player.hasCock()) outputText("drooling penis");
		outputText(". . Your entire body is starting to feel like a single erogenous zone and you want to touch yourself yet, immobilised like you are, you can only let the slime fuck you silly." +
		" The pleasure is melting your mind, you want to abandon yourself to the syrupy feeling of your body melting like ice under the pleasure of the slime’s touches. You can barely feel yourself anymore, all that matters is the crazed pleasure your body is going through." +
		" So much pleasure that you eventually lose even the ability to see, closing your eyes as your world turns into an explosive purple mess of fluid and orgasms. You can’t move, where are your limbs…? Heck, do you even have a body anymore?" +
		" The delicious sensation is dying down, and you have an irrepressible need to feel, to touch. You start pushing, forcing your way out of this empty mass as you finally find something solid to touch in the form of the dungeon ground." +
		" A hand… you can… feel the ground through your hand and the pleasure of it begins echoing through you like the ripple caused by throwing a rock in the middle of a still pool of water. This is not enough, you need more!" +
		" You force yourself out of the slimy mass, trying to move just about everything you can in order to enjoy the delicious sensation of touch again." +
		" You finally gush out from the side, feeling the caress of the wind on your body once again and opening your eyes, the pleasure of feeling so great you pant in delight. The slime girl simply looks at you.\n\n");
		outputText("\"<i>Good morning sleepyhead, had a nice sleep?</i>\"\n\n");
		outputText("You… you are not exactly out of the slimy mass. Weirder yet, it’s the fact that you are attached to it. You can see the slime girl lazily watching you from the other side of the liquid. The first thing your desire-addled mind makes you do is pull her into a wet kiss, yet when you do, you feel not only your lips, but also her own. The sensation is confusing at first, so you push away, a small gooey purple strand still connecting your lips." +
		" Finally, the slime girl suddenly starts to push you out, her face ravaged by mind breaking pleasure as if she was actually having the orgasm of her life and so do you as you’re suddenly expelled from her body with such strength that you are projected onto a nearby wall." +
		" You try to stand up, but suddenly realise that you actually lack a bodily structure to do so! What happened to you? You look around, panicking for a moment, as you realise you have no arms or legs, then it dawns on you that when you did need an arm earlier, you had it." +
		" At the center of the mass that is your, now translucent, purple body, you actually do have something solid that allows you to shape your form, a heart, or more accurately, a core." +
		" You try and pull yourself away from the wall, sliding to the ground, translucent liquid arms and torso shaping back from your body mass as you need them." +
		" Your body, molded to your needs, resembles that of your human self, but different. You take some time admiring your perfect gooey self, a beautiful exaggeration of what you were before." +
		" Your whole skin is as sensitive as an erogenous zone, and for a while you begin to drip in delight as every single stimulation brings insane levels of pleasure to you, it will take some time getting used to this." +
		" You don’t have much time to think over this matter, as a sudden hunger takes hold of you. You thirst, your body mass thirsts for fluids… the fluids of others!" +
		" You set out with a drooling pleasure addled smile looking for a fleshling to feed from.\n\n");
		outputText("<b>You have been transformed into a dark slime!</b>\n\n");
		player.hairType = Hair.GOO;
		player.arms.type = Arms.GOO;
		player.lowerBody = LowerBody.GOO;
		player.rearBody.type = RearBody.METAMORPHIC_GOO;
		player.skin.setBaseOnly({adj: "slimy", type: Skin.GOO});
		var darkgooSkinColors:Array = ["indigo", "light purple", "purple", "purplish black", "dark purple"];
		var choosencolor:String = randomChoice(darkgooSkinColors);
		player.skin.base.color = choosencolor;
		player.skin.base.pattern = Skin.PATTERN_NONE;
		player.hairColor = choosencolor;
		player.eyes.type = Eyes.FIENDISH;
		player.eyes.colour = "red";
		player.ears.type = Ears.ELFIN;
		player.faceType = Face.HUMAN;
		player.tongue.type = Tongue.HUMAN;
		player.createVagina()
		if (!player.hasStatusEffect(StatusEffects.BonusVCapacity)) player.createStatusEffect(StatusEffects.BonusVCapacity, 9000, 0, 0, 0);
		else player.addStatusValue(StatusEffects.BonusVCapacity, 1, 9000);
		player.antennae.type = Antennae.NONE;
		player.horns.type = Horns.NONE;
		player.wings.type = Wings.NONE;
		player.tail.type = Tail.NONE;
		player.gills.type = Gills.NONE;
		if (!player.hasStatusEffect(StatusEffects.SlimeCraving)) {
			player.createStatusEffect(StatusEffects.SlimeCraving, 0, 0, 0, 1); //Value four indicates this tracks strength and speed separately
		}
		if (!player.hasPerk(PerkLib.DarkSlimeCore)) player.createPerk(PerkLib.DarkSlimeCore, 0,0,0,0);
		CoC.instance.mainViewManager.updateCharviewIfNeeded();
	}
}

public function beatingDarkSlimeScram():void {
	clearOutput();
	spriteSelect(SpriteDb.s_darkgoogirlsprite_16bit);
	outputText("You silence her pathetic excuses and tell her to get the fuck away. Something to which she gladly complies with.\n\n");
	cleanupAfterCombat();
}

public function beatingDarkSlimeUseHer():void {
	clearOutput();
	spriteSelect(SpriteDb.s_darkgoogirlsprite_16bit);
	outputText("You silence her pathetic excuses and tell her to regain shape right fucking now, the fun is about to begin.\n\n");
	outputText("The grape-colored jelly girl obeys without question molding itself into something you can fuck with.\n\n");
	outputText("She makes a mischievous smile understanding that she may get that meal after all and turns into what appears to be a bed, with slimy sheets and a pillow. Well now, this is a most interesting proposal. You lay down in the slime bed and order her to show you her talents double time.\n\n");
	outputText("You slowly sink into the bed up to the neck, your head still carefully rested on the pillow as the slime begins its exploration of your body. ");
	if (player.hasCock()) outputText("Something in the slime grabs hold of your penis, slowly and gently massaging it within the confines of the lewd bed. You gasp in pleasure as your cock begins to harden under the slime’s methodical ministration some even going inside your urethra. ");
	if (player.hasVagina()) outputText("Your pussy begins to drool as slime floods inside, filling you up to and way past the cervix. This is the nice thing about these creatures, no matter how small the orifices they can move right in. Your belly inflates to an overly pregnant size as the slime begins to gently fuck you up to into your womb. ");
	if (player.biggestTitSize() >= 2) outputText("The slime gets to tenderly massaging your two mounds of flesh small pressure applying to your nipples in just the right way. ");
	outputText("You could stick to vanilla and enjoy yourself but you ponder if you should not go one step further and ask for anal stretching.\n\n");
	menu();
	addButton(1, "Nope", beatingDarkSlimeUseHerNope);
	addButton(2, "Fill", beatingDarkSlimeUseHerFillMyAssWithGoo).hint("Fill my ass with goo");
}

public function beatingDarkSlimeUseHerNope():void {
	outputText("Nah no anal for today.\n\n");
	beatingDarkSlimeUseHer2();
}

public function beatingDarkSlimeUseHerFillMyAssWithGoo():void {
	outputText("Yea some anal would be appreciated too. Your malleable toy gets the message and slowly floods into your pucker widening inside in just the right way.\n\n");
	beatingDarkSlimeUseHer2();
}

public function beatingDarkSlimeUseHer2():void {
	outputText("Regardless of the number of tendrils massaging you in every right way, your having one hell of a great session. The slime is pleasing you in a rhythmic tempo not unlike that of your heartbeat its body pulsing with every small drop of fluid you produce. At this rate, you won’t be able to hold off any further and the slime knowing it speeds up its pace eager for the reward.\n\n");
	outputText("You cum magnificently your fluids mixing and flooding in the slime’s body mass. You almost doze off to sleep too but the mass of the slime moving off from you jar you awake, guess she does not double up as a real bed for resting purposes. She waves off goodbye as she takes her departure leaving you there to ponder who truly raped who.\n\n");
	player.sexReward("Default", "Default",true,false);
	cleanupAfterCombat();
}

	}
}