/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Forest
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Ashlands.Cinderbloom;
import classes.Scenes.Areas.Tundra.SnowLily;
import classes.Scenes.Places.WoodElves;
import classes.display.SpriteDb;

public class AlrauneScene extends BaseContent
	{
		public function AlrauneVSAlraune(Location:String, type:String):void{
			outputText("As you wander the "+Location+" you come across a rather large flower. " +
					"You easily recognize the plant for what it is and wake her up by shaking her vines with yours. " +
					"The "+type+" pops out and yawns, surprised at seeing another flower like her.\n\n" +
					"\"<i>Oh hello sister I didn't expect to see another of Marae’s lifeblood in the area. What brings you here?</i>\"\n\n");
			if(player.isLiliraune())
			{
				outputText("You and your sister look at each other, then shrug before replying." +
						"\"<i>Looking for a stamen to fertilize us, or a pussy to stuff our seed, truly.</i>\"\n\n" +
						"\"<i>Except we haven’t found anyone but you so far.</i>\"\n\n");
			}
			outputText("You pretty much stumbled upon her at random though truth be told now that you think of it, there is no such thing as incest when it comes down to plants.");
			if(player.isLiliraune()) outputText(" Both of you ");
			else outputText(" You ");
			outputText("give the flower girl a wink.");
			if(player.isLiliraune())
			{
				outputText("\"<i>No such thing as incest amongst flowers right sister?</i>\"\n\n" +
						"\"<i>Since we’re both in need of proper fertilization how about an exchange?</i>\"\n\n");
			}
			outputText("The plant girl gets the idea and giggles, her vine stamens already blooming out at the prospect of fertilizing something. " +
					"You joyously move all the way over to her, as your vines entwine, sliding on each other. " +
					"Truth be told, if a penis had grown to ridiculous length and gained this kind of absurd flexibility, " +
					"it would have felt similar to getting a handjob and giving someone a handjob at the same time as one of your vines coil and slide on " +
					"the other plant girl’s vines, both stamen pointing toward the sky as you moan in delight. " +
					"You both swiftly reach a first orgasm, and the two entwined vines rain pollen in the area. " +
					"That's only one stamen out of many however, and you reposition your vines so that each tip is aligned toward your partner’s cunt, " +
					"entwining all of your other vines around the first two to create what could be only called a vine made double ended dildo. " +
					"The smell of her stamens is overpowering your senses and without a second thought you shove all of her 10 appendages together in your pussy just as you feel the end of your vines being pulled inside her wet fold. " +
					"Your eyes roll in absolute bliss as all of your vine lengths are sliding on each other, all of your stamen fucking a wanting pussy at the same time as your own plant cunt is being filled up. " +
					"The air itself is becoming increasingly intoxicating as both of you release pollen everywhere from your combined lust. " +
					"You don’t care who is fucking who, you are way too lost in the sensations of your pleasure mad body to care.\n\n" +
					"Liquid pollen eventually floods your crazed pussy stuffing your body so much your belly inflates up to looking absurdly pregnant. " +
					"It’ll slowly flow all the way back in the depth of your pitcher where your seeds are created but for now, you look like you might as well be filled with four or even eight kids! " +
					"Your stamens pop free from their cunt sheaths, falling limply to the ground and still leaking as you doze off highly content.");
			player.sexReward("cum", "Vaginal");
			if (!WoodElves.WoodElfMagicTranerGetLaid) WoodElves.WoodElfMagicTranerGetLaid = true;
			endEncounter();
		}
		
	public function alrauneDeepwoods():void {
		spriteSelect(SpriteDb.s_alraune);
		clearOutput();
		sceneHunter.print("Unique options for bee handmaidens and alraunes!");
		if (player.isAlraune()) AlrauneVSAlraune("forest","alraune");
		else if (player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)) beeHandmaidens("forest","alraune");
		else {
			if (isHalloween()) {
				outputText("As you wander the area, you come across a rather large pumpkin growing in the forest. You ponder how plants even manage to grow this big to begin with. While you are busy examining it, large vines surge out at you, binding your arms and legs and reeling you toward the pumpkin as it opens up, revealing a beautiful woman with pale orange skin and light green eyes.\n\n");
				outputText("\"<i>Boo!!! Trick or treat?! Well you don’t seem very keen on giving me treats, so I guess I will have to collect.</i>\"\n\n");
				outputText("There's no way you will let this thing pull you in!\n\n");
			}
			else {
				outputText("As you wander the forest you come across a rather large flower, easily twice your size. You ponder how plants even manage to grow this big even on Mareth. The flower has pink petals and a pitcher-like center. While you are busy examining it, several large vines surge out at you, binding your arms and legs and reeling you toward the flower as it opens up, revealing a beautiful woman with light green skin and deep green eyes.\n\n");
				outputText("\"<i>Mmmmmm such a nice catch... Come closer into my pitcher.</i>\"\n\n");
				outputText("There's no way you will let this thing pull you in!\n\n");
			}
			camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_ALRAUNE);
			startCombat(new Alraune());
		}
	}
	
	public function alrauneVolcanicCrag():void {
		spriteSelect(SpriteDb.s_cinderbloom);
		clearOutput();
		sceneHunter.print("Unique options for bee handmaidens and alraunes!");
		if (player.isAlraune()) AlrauneVSAlraune("crag","cinderbloom");
		else if (player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)) beeHandmaidens("crag","cinderbloom");
		else {
			if (isHalloween()) {
				outputText("As you wander the area, you come across a rather large pumpkin growing in the ashlands. You ponder how plants even manage to grow this big to begin with. While you are busy examining it, large vines surge out at you, binding your arms and legs and reeling you toward the pumpkin as it opens up, revealing a beautiful woman with pale orange skin and light green eyes.\n\n");
				outputText("\"<i>Boo!!! Trick or treat?! Well you don’t seem very keen on giving me treats, so I guess I will have to collect.</i>\"\n\n");
				outputText("There's no way you will let this thing pull you in!\n\n");
			} else {
				outputText("As you wander the ashlands, you come across a rather large flower growing in the ashes. You ponder how plants even manage to grow in this inhospitable landscape. The flower has petals the same color as lava, and a pitcher like center. While you are busy examining it, large vines surge out at you, binding your arms and legs and reeling you toward the flower as it opens up, revealing a beautiful woman with chocolate skin and deep red eyes.\n\n");
				outputText("\"<i>Mmmmmm such a nice catch... Come closer into my pitcher.</i>\"\n\n");
				outputText("There's no way you will let this thing pull you in!\n\n");
			}
			startCombat(new Cinderbloom());
		}
	}
	
	public function alrauneGlacialRift():void {
		spriteSelect(SpriteDb.s_snow_lily);
		clearOutput();
		sceneHunter.print("Unique options for bee handmaidens and alraunes!");
		if (player.isAlraune()) AlrauneVSAlraune("rift","snow lily");
		else if (player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)) beeHandmaidens("rift","snow lily");
		else {
			if (isHalloween()) {
				outputText("As you wander the area, you come across a rather large pumpkin growing in the tundra. You ponder how plants even manage to grow this big to begin with. While you are busy examining it, large vines surge out at you, binding your arms and legs and reeling you toward the pumpkin as it opens up, revealing a beautiful woman with pale orange skin and light green eyes.\n\n");
				outputText("\"<i>Boo!!! Trick or treat?! Well you don’t seem very keen on giving me treats, so I guess I will have to collect.</i>\"\n\n");
				outputText("There's no way you will let this thing pull you in!\n\n");
			} else {
				outputText("As you wander the tundra, you come across a rather large flower growing in the snow. You ponder how plants even manage to grow in this cold landscape. The flower has petals the same color as the snow and a pitcher like center. While you are busy examining it, large vines surge out at you, binding your arms and legs and reeling you toward the flower as it opens up, revealing a beautiful woman with sky blue skin and light blue eyes.\n\n");
				outputText("\"<i>Mmmmmm such a nice catch... Come closer into my pitcher.</i>\"\n\n");
				outputText("There's no way you will let this thing pull you in!\n\n");
			}
			startCombat(new SnowLily());
		}
	}
	
	public function alrauneDeepwoodsWon():void {
		clearOutput();
		if (isHalloween()) outputText("The Jack-O-Raune, unable to fight any longer, retreat in her pumpkin in self defence, her vines unwrapping from you. Well, you are free, but the god-damn plant woman left you horny and frustrated, what a tease! Guess it's time to head back to camp.\n\n");
		else outputText("The alraune, unable to fight any longer, closes her petals in self defence, her vines unwrapping from you. Well, you are free, but the god-damn plant woman left you horny and frustrated, what a tease! Guess it's time to head back to camp.\n\n");
		cleanupAfterCombat();
	}
	
	public function alrauneDeepwoodsLost():void {
		clearOutput();
		if (player.gender == 0) {
			cleanupAfterCombat();
			return;
		}
		if (monster.statusEffectv1(StatusEffects.Level) > 2) outputText("Your desire finally breaks your resolve as you stop struggling and make a dopey lust drunk face while the vines bring you to their mistress. ");
		sceneHunter.selectLossMenu([
				[0, "Pistil", dickF, "Req. a cock.", player.hasCock()],
				[1, "Stamen", vagF, "Req. a vagina.", player.hasVagina()]
			],
			"\n\nHer body is perfect, her smell is intoxicating... but the alraune looks the same - she wants you. Maybe if you ask her nicely, she'll let you choose? What part of <i>her</i> body are you going to use?"
		);

		function dickF():void {
			outputText("You don’t recall when or how you ended up in her nectar bath, but there you are, and your cock is throbbing with burning desire for this female.\n\n");
			outputText("\"<i>Aw you poor thing. Let me comfort this pained stamen of yours with my nectar gushing pussy.</i>\"\n\n");
			outputText("She begins to run her hands all over your body, making you shiver at the touch. She grabs you by the shoulders and brings you closer to her as she begins to kiss you, her sweet nectar flowing from her mouth to yours. It tastes wonderful yet is packed with powerful aphrodisiac; so before you know it your desire to mate intensifies, and your cock is now aching to be used. You begin to drool mindlessly as her hands caress your throbbing cock.\n\n");
			outputText("\"<i>Mmmm you look about ready... such a nice face you're making, it makes me even more wet for you.</i>\"\n\n");
			outputText("Her pussy is like a balm on your suffering cock, as her nectar slowly coats your entire length, you feel your manhood tingle with the telltale pleasure of more aphrodisiac entering your body. Your twitching balls, which have been dipped in the syrup for god knows how long, have grown so large you could compete with a pussy starved minotaur and your dick... oh your dick! The feeling of her pussy wrapped around your cock is so perfect you almost melt in her arms.\n\n");
			outputText("\"<i>Just stay still, honey, while I take care of you.</i>\"\n\n");
			outputText("She wraps some of her vines around you both, using them to pull you both closer as she slides on your cock. You moan in incomprehensible babble as your drugged penis is milked by the alraune, cum flooding out at about a rate as steady as her pussy nectar. Men can, normally, only orgasm once or twice before they need a rest; you however simply can’t lose your hard on, cumming over and over as your drugged balls keep producing an almost endless amount of semen. ");
			outputText("Whenever the Alraune sees the signs of thirst on your face, she quenches it with her breast, filling your mouth with more nectar. Go figure because plants don't leak any other fluids than that. Thankfully your stamina eventually gives out as you fall unconscious, way before your raging erection dies out.\n\n");
			outputText("When you wake up, you are in a different area with your gear packed up next to you. Seems some thief made off with a small amount of your gems though.\n\n");
			player.sexReward("vaginalFluids", "Dick");
			if (!WoodElves.WoodElfMagicTranerGetLaid) WoodElves.WoodElfMagicTranerGetLaid = true;
			dynStats("lib", 15, "sen", 5);
			cleanupAfterCombat();
		}
		function vagF():void {
			outputText("You don’t recall when or how you ended up naked in her nectar bath but there you are, fawning in the arms of the " + (isHalloween() ? "pumpkin" : "plant") + " woman.\n\n");
			outputText("\"<i>Mmmmm aren’t you an eager girl? Let’s start at the beginning then.</i>\"\n\n");
			outputText("She begins to run her hands all over your body, making you shiver at every touch. She grabs you by the shoulders and brings you closer to her as she begins to kiss you, her sweet nectar flowing into your mouth. It tastes wonderful yet is packed with a powerful aphrodisiac. Before you know it, your desire for her only skyrockets. You break the kiss, a thin strand of syrupy nectar still connecting your lips as she moves a hand to your breasts, ");
			outputText("cupping them up, as she picks up some nectar with her other hand and pours it on your body making you all sticky with her lovely nectar. Your skin begins to tingle as it soaks in the aphrodisiacs in her nectar, and you gasp as a small breeze blows past you.\n\n");
			outputText("\"<i>Umm... you should find my touch to be way more delectable now.</i>\"\n\n");
			if (isHalloween()) outputText("Jack-O-Raune");
			else outputText("The alraune");
			outputText(" gently moves her head to your nipples and begins suckling, making you moan as a whole new world of pleasure opens to you. She gently suckles on your breast for a few moments until you're unable to stand from the massive pleasure overload rocking your body. This is too much! ");
			outputText("You want to be touched by her, kissed by her, and most of all your drug addled mind wants her to fuck your pleasure-starved pussy. The ");
			if (isHalloween()) outputText("pumpkin");
			else outputText("plant");
			outputText(" girl caresses your breast making your pussy gush as she slowly gets you in position sitting in her bath.\n\n");
			outputText("\"<i>Looks like we can go to the next step.</i>\"\n\n");
			outputText("A lovely set of bulby vines slither inside the bath and goes straight for your cunt and ass making you scream in delight as they open your vaginal lips and slide in. If you came just from getting penetrated, you can’t imagine what the fuck will feel like.\n\n");
			outputText("\"<i>Hang on tightly to me... we’re beginning.</i>\"\n\n");
			outputText("Her stamen bulbs open inside of your cunt and ass and your eyes go wide as you are struck by yet another orgasm. She begins to wildly fuck you, your mouth drooling and your eyes rolling back as you lose the ability to make coherent words. She fills you over and over with her liquid pollen, making your belly swell to the size of a heavily pregnant woman as you buck your hips mindlessly. ");
			outputText("You barely recall her gently lifting you out of her bath and depositing you to the ground as you lose consciousness.\n\n");
			outputText("When you wake up, you are in a different area with your gear packed up next to you. Seems some thief made off with a small amount of your gems though.\n\n");
			if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
            else player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
			player.sexReward("cum", "Vaginal");
			player.sexReward("cum", "Anal");
			if (!WoodElves.WoodElfMagicTranerGetLaid) WoodElves.WoodElfMagicTranerGetLaid = true;
			dynStats("lib", 15, "sen", 5);
			cleanupAfterCombat();
		}
	}

		private function beeHandmaidens(location:String, type:String):void {
			spriteSelect(SpriteDb.s_alraune);
			clearOutput();
			outputText("As you wander the "+location+", you spot a closed flower of exceptional size. You already smell the delicious ripe nectar inside. As you get closer vines suddenly snap alive and pull you to the blossoming flower. At the center of the pitcher stands a plant-like woman who looks at you, examining her catch of the day. It’s clearly an "+type+" but instead of attacking you, she evaluates you as a trader evaluates a potential deal.\n"
				+ "\n"
				+ "“<i>Oh, it's one of those handmaiden girls again. Let me guess, you are after my nectar right?</i>” \n"
				+ "\n"
				+ "God damn, of course you are, such ripe nectar is very precious to your hive. \n"
				+ "\n"
				+ "“<i>Yea fine but you will have to earn it. You know the standard agreement between flowers and bees right?</i>”\n"
				+ "\n"
				+ "You buzz for a moment pondering the ramification of this trade then shrug before diving for the alraune breasts attacking them with your greedy hands as you try to get the nectar to flow out, several bottles ready for the collect. The Alraune moans, dribbles of nectar leaking from her swollen breast as you fill bottle after bottle of the precious fluid. However, collecting isn’t enough and you let your long insectile tongue out to lick and flick the plant woman’s exposed pussy in order to savor the delicious nectar yourself.  The Alraune starts to pant in arousal. She clearly likes it but she has other plans for you.\n"
				+ "\n"
				+ "“<i>Ahhhn... Yesss!! Delicious!… it's my turn .. AAAAhhh!... to use your parts.</i>”\n"
				+ "\n"
				+ "True to her word, you soon feel a vine prodding up your [butt]. You vividly recall that bees drink and use the nectars of flowers and in exchange help those same flowers reproduce by spreading their pollen around. Well, you don’t care anymore, you are too busy lapping on the Alraune’s juicy snatch and delicious nectar to bother when her vine forcefully penetrates your ass.");
			player.buttChange(30, true);
			outputText("You moan in delight in the pleasured Alraune pussy as you both get each other off. The plant woman has a dreamy stare as she both fucks your ass and gets licked at the same time, her mouth drooling mindlessly. While you are in your nectar haze you do not notice a second vine seeking out for your pussy and going in. One is fine but two is way too much and you swiftly lose yourself to your lust as the Alraune fucks you full of liquid pollen. You both pass out exhausted a few minutes later.\n"
				+ "\n"
				+ "When you wake up you are visibly pregnant with what might be her seeds and the plant woman is nowhere to be found. Not that it matters since you got several flasks of her precious nectar.\n");
			cleanupAfterCombat();
			inventory.takeItem(consumables.RAUNENECT, explorer.done); //TODO: make it 5
			player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
			player.sexReward("cum", "Anal");
		}
	}
}
