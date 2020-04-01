/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Forest 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Scenes.Areas.GlacialRift.SnowLily;
	import classes.Scenes.Areas.VolcanicCrag.Cinderbloom;
	import classes.display.SpriteDb;

public class AlrauneScene extends BaseContent
	{
		
		public function AlrauneScene() 
		{
			
		}
		
	public function alrauneDeepwoods():void {
		spriteSelect(SpriteDb.s_alraune);
		clearOutput();
		if (isHalloween()) {
			outputText("As you wander the area you come across a rather large pumpkin growing in the forest. You ponder how plants even manage to grow this big to begin with. While you are busy examining it, large vines surge out at you, binding your arms and legs and reeling you toward the pumpkin as it opens up, revealing a beautiful woman with pale orange skin and light green eyes.\n\n");
			outputText("\"<i>Boo!!! Trick or treat?! Well you don’t seem very keen on giving me treats so I guess I will have to collect.</i>\"\n\n");
			outputText("There's no way you will let this thing pull you in!\n\n");
		}
		else {
			outputText("As you wander the forest you come across a rather large flower, easily twice your size. You ponder how plants even manage to grow this big even on Mareth. The flower has pink petals and a pitcher like center. While you are busy examining it, several large vines surge out at you, binding your arms and legs and reeling you toward the flower as it opens up, revealing a beautiful woman with light green skin and deep green eyes.\n\n");
			outputText("\"<i>Mmmmmm such a nice catch... Come closer into my pitcher.</i>\"\n\n");
			outputText("There's no way you will let this thing pull you in!\n\n");
		}
		if (flags[kFLAGS.CODEX_ENTRY_ALRAUNE] <= 0) {
			flags[kFLAGS.CODEX_ENTRY_ALRAUNE] = 1;
			outputText("\n\n<b>New codex entry unlocked: Alraune!</b>");
		}
		startCombat(new Alraune());
	}
	
	public function alrauneVolcanicCrag():void {
		spriteSelect(SpriteDb.s_cinderbloom);
		clearOutput();
		if (isHalloween()) {
			outputText("As you wander the area you come across a rather large pumpkin growing in the crag. You ponder how plants even manage to grow this big to begin with. While you are busy examining it, large vines surge out at you, binding your arms and legs and reeling you toward the pumpkin as it opens up, revealing a beautiful woman with pale orange skin and light green eyes.\n\n");
			outputText("\"<i>Boo!!! Trick or treat?! Well you don’t seem very keen on giving me treats so I guess I will have to collect.</i>\"\n\n");
			outputText("There's no way you will let this thing pull you in!\n\n");
		}
		else {
			outputText("As you wander the crag you come across a rather large flower growing in the ash. You ponder how plants even manage to grow in this inhospitable landscape. The flower has petals the same color as lava and a pitcher like center. While you are busy examining it, large vines surge out at you, binding your arms and legs and reeling you toward the flower as it opens up, revealing a beautiful woman with chocolate skin and deep red eyes.\n\n");
			outputText("\"<i>Mmmmmm such a nice catch... Come closer into my pitcher.</i>\"\n\n");
			outputText("There's no way you will let this thing pull you in!\n\n");
		}
		startCombat(new Cinderbloom());
	}
	
	public function alrauneGlacialRift():void {
		spriteSelect(SpriteDb.s_snow_lily);
		clearOutput();
		if (isHalloween()) {
			outputText("As you wander the area you come across a rather large pumpkin growing in the rift. You ponder how plants even manage to grow this big to begin with. While you are busy examining it, large vines surge out at you, binding your arms and legs and reeling you toward the pumpkin as it opens up, revealing a beautiful woman with pale orange skin and light green eyes.\n\n");
			outputText("\"<i>Boo!!! Trick or treat?! Well you don’t seem very keen on giving me treats so I guess I will have to collect.</i>\"\n\n");
			outputText("There's no way you will let this thing pull you in!\n\n");
		}
		else {
			outputText("As you wander the rift you come across a rather large flower growing in the snow. You ponder how plants even manage to grow in this icy landscape. The flower has petals the same color as the snow and a pitcher like center. While you are busy examining it, large vines surge out at you, binding your arms and legs and reeling you toward the flower as it opens up, revealing a beautiful woman with sky blue skin and light blue eyes.\n\n");
			outputText("\"<i>Mmmmmm such a nice catch... Come closer into my pitcher.</i>\"\n\n");
			outputText("There's no way you will let this thing pull you in!\n\n");
		}
		startCombat(new SnowLily());
	}
	
	public function alrauneDeepwoodsWon():void {
		if (monster.short == "cinderbloom alraune") spriteSelect(SpriteDb.s_cinderbloom);
		else if (monster.short == "snow lily alraune") spriteSelect(SpriteDb.s_snow_lily);
		else if (isHalloween()) spriteSelect(SpriteDb.s_alraune);
		else spriteSelect(SpriteDb.s_alraune);
		clearOutput();
		if (isHalloween()) outputText("The Jack-O-Raune, unable to fight any longer, retreat in her pumpkin in self defence, her vines unwrapping from you. Well, you are free, but the god damn plant woman left you horny and frustrated, what a tease! Guess it's time to head back to camp.\n\n");
		else outputText("The alraune, unable to fight any longer, closes her petals in self defence, her vines unwrapping from you. Well, you are free, but the god damn plant woman left you horny and frustrated, what a tease! Guess it's time to head back to camp.\n\n");
		cleanupAfterCombat();
	}
	
	public function alrauneDeepwoodsLost():void {
		if (monster.short == "cinderbloom alraune") spriteSelect(SpriteDb.s_cinderbloom);
		else if (monster.short == "snow lily alraune") spriteSelect(SpriteDb.s_snow_lily);
		else if (isHalloween()) spriteSelect(SpriteDb.s_alraune);
		else spriteSelect(SpriteDb.s_alraune);
		clearOutput();
		if (player.gender == 1) {
			if (monster.statusEffectv1(StatusEffects.Level) > 2) outputText("Your desire finally breaks your resolve as you stop struggling and make a dopey lust drunk face while the vines bring you to their mistress. ");
			outputText("You don’t recall when or how you ended up in her nectar bath, but there you are and your cock is throbbing with burning desire for this female.\n\n");
			outputText("\"<i>Aw you poor thing. Let me comfort this pained stamen of yours with my nectar gushing pussy.</i>\"\n\n");
			outputText("She begins to run her hands all over your body, making you shiver at the touch. She grabs you by the shoulders and brings you closer to her as she begins to kiss you, her sweet nectar flowing from her mouth to yours. It tastes wonderful yet is packed with powerful aphrodisiac; so before you know it your desire to mate intensifies and your cock is now aching to be used. You begin to drool mindlessly as her hands caress your throbbing cock.\n\n");
			outputText("\"<i>Mmmm you look about ready... such a nice face you're making, it makes me even more wet for you.</i>\"\n\n");
			outputText("Her pussy is like a balm on your suffering cock, as her nectar slowly coats your entire length, you feel your manhood tingle with the telltale pleasure of more aphrodisiac entering your body. Your twitching balls, which have been dipped in the syrup for god knows how long, have grown so large you could compete with a pussy starved minotaur and your dick... oh your dick! The feeling of her pussy wrapped around your cock is so perfect you almost melt in her arms.\n\n");
			outputText("\"<i>Just stay still, honey, while I take care of you.</i>\"\n\n");
			outputText("She wraps some of her vines around you both, using them to pull you both closer as she slides on your cock. You moan in incomprehensible babble as your drugged penis is milked by the alraune, cum flooding out at about a rate as steady as her pussy nectar. Men can, normally, only orgasm once or twice before they need a rest; you however simply can’t lose your hard on, cumming over and over as your drugged balls keep producing an almost endless amount of semen. ");
			outputText("Whenever the Alraune sees the signs of thirst on your face, she quenches it with her breast, filling your mouth with more nectar. Go figure because plants don't leak any other fluids than that. Thankfully your stamina eventually gives out as you fall unconscious, way before your raging erection dies out.\n\n");
			outputText("When you wake up you are in a different area with your gear packed up next to you. Seems some thief made off with a small amount of your gems though.\n\n");
			player.sexReward("vaginalFluids","Dick")
		}
		else {
			if (monster.statusEffectv1(StatusEffects.Level) > 2) outputText("Your desire finally breaks your resolve as you stop struggling and make a dopey lust drunk face while the vines bring you to their mistress. ");
			outputText("You don’t recall when or how you ended up naked in her nectar bath but there you are, fawning in the arms of the ");
			if (isHalloween()) outputText("pumpkin");
			else outputText("plant");
			outputText(" woman.\n\n");
			outputText("\"<i>Mmmmm aren’t you a eager girl? Let’s start at the beginning then.</i>\"\n\n");
			outputText("She begins to run her hands all over your body, making you shiver at every touch. She grabs you by the shoulders and brings you closer to her as she begins to kiss you, her sweet nectar flowing into your mouth. It tastes wonderful yet is packed with a powerful aphrodisiac. Before you know it, your desire for her only skyrockets. You break the kiss, a thin strand of syrupy nectar still connecting your lips as she moves a hand to your breasts, ");
			outputText("cupping them up, as she picks up some nectar with her other hand and pours it on your body making you all sticky with her lovely nectar. Your skin begins to tingle as it soaks in the aphrodisiacs in her nectar and you gasp as a small breeze blows past you.\n\n");
			outputText("\"<i>Umm... you should find my touch to be way more delectable now.</i>\"\n\n");
			if (isHalloween()) outputText("Jack-O-Raune");
			else outputText("The alraune");
			outputText(" gently moves her head to your nipples and begins suckling, making you moan as a whole new world of pleasure opens to you. She gently suckles on your breast for a few moments until you're unable to stand from the massive pleasure overload rocking your body. This is too much! ");
			outputText("You want to be touched by her, kissed by her and most of all your drug addled mind wants her to fuck your pleasure-starved pussy. The ");
			if (isHalloween()) outputText("pumpkin");
			else outputText("plant");
			outputText(" girl caresses your breast making your pussy gush as she slowly gets you in position sitting in her bath.\n\n");
			outputText("\"<i>Looks like we can go to the next step.</i>\"\n\n");
			outputText("A lovely set of bulby vines slither inside the bath and goes straight for your cunt and ass making you scream in delight as they open your vaginal lips and slide in. If you came just from getting penetrated, you can’t imagine what the fuck will feel like.\n\n");
			outputText("\"<i>Hang on tightly to me... we’re beginning.</i>\"\n\n");
			outputText("Her stamen bulbs open inside of your cunt and ass and your eyes go wide as you are struck by yet another orgasm. She begins to wildly fuck you, your mouth drooling and your eyes rolling back as you lose the ability to make coherent words. She fills you over and over with her liquid pollen, making your belly swell to the size of a heavily pregnant woman as you buck your hips mindlessly. ");
			outputText("You barely recall her gently lifting you out of her bath and depositing you to the ground as you lose consciousness.\n\n");
			outputText("When you wake up you are in a different area with your gear packed up next to you. Seems some thief made off with a small amount of your gems though.\n\n");
			if (player.goblinScore() > 9) player.knockUp(PregnancyStore.PREGNANCY_GOBLIN, PregnancyStore.INCUBATION_GOBLIN);
            else player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
			player.sexReward("cum", "Vaginal");
		}
		dynStats("lib", 15, "sen", 5);
		cleanupAfterCombat();
	}
	
	}

}