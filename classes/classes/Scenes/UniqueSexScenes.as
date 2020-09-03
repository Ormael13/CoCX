/**
 * ...
 * @author Liadri
 */
package classes.Scenes 
{
	import classes.*;
	import classes.BodyParts.Arms;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.Tail;
	
	public class UniqueSexScenes extends BaseContent
	{
		
		public function UniqueSexScenes() 
		{
		}

		public function alrauneExtraSceneWithHollicyntiaTentacleDuel():void {
			clearOutput();
			outputText("As you ponder how you will deal with Hollicyntia’s behaviour today, you catch a glimpse of her checking out your vines. Holli seems to be comparing her vines with yours, evaluating size and length thoroughly like a boy in a shower room. As if that upstart could rival your floral perfection!\n\n");
			outputText("\"<i>These are big and healthy, but mine are better!</i>\" she taunts, evidently trying to rile you up.\n\n");
			outputText("Surely not! You bet you could fuck your sister’s brains out before she actually managed to get you off. With confidence you issue her a challenge, your vines raised around you. Here’s the deal, both of you will try to fuck each other silly, and whoever orgasms first loses!\n\n");
			outputText("\"<i>Deal! I will prove to you, dear sister, that my stamens are the best in this garden.</i>\"\n\n");
			outputText("You vines lunge at Holli’s nectar pot as her own zero in on yours, and soon you’re tentacle fucking each other in earnest in an attempt to make the other orgasm first. You start by hammering your stamen in her pussy, but she swiftly counter attacks by blooming her stamen in a dozen tendrils right inside your vagina, each one wriggling independently. Two can play at this game however, and you let out a cloud of pollen, letting it reach her nose and drive her into a lust crazed haze as you ready your other vines. She surprises you by pulling you into a tight embrace, mashing the both of your nectar dripping breasts together. You fuck her ass and grope her breast with your remaining vines, forcing her to restart the offensive with a chest assault of her own.");
			outputText(" The both of you are moaning like wanton whores and lost in sensations by now, but neither of you want to lose to the other in this desperate duel of endurance and sexual skill. Soon your mind is going blank from the vigorous fucking but you don’t care. You won’t allow yourself to orgasm before Holli does. Eventually, unable to hold anymore, the both of you scream your defeat together as your stamens explode, filling each others wombs to the brim. There’s so much liquid pollen pumped into you and you can feel your bloated stomach groan under the pressure. You can’t help but cup it with your hand in motherly delight. Holli isn't looking any better, it will probably take hours for her belly to deflate.\n\n");
			outputText("\"<i>I... want a rematch...No way I'll stop at a tie!</i>\"\n\n");
			outputText("That won’t be today though. You're so packed up with plant cum that without even checking your odds, you're pretty sure you are pregnant. You doubt Holli can hold any more of your pollen either, so you dress back up, highly satisfied and somewhat smug, leaving Holli to her personal frustration.");
			player.sexReward("cum");
			player.sexReward("vaginalFluids");
			player.sexReward("saliva");
			statScreenRefresh();
			player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
			doNext(camp.returnToCampUseOneHour);
		}

		public function TreeWayRapeLiliraune():void {
			clearOutput();
			outputText("With your foe on the ground before you, you feel a familiar warmth rushing through you, making you blush purple as fantasies of filling this woman with your progeny overcome you. You smile mischievously at your twin sister.\n\n" +
					"\"<i>Hey sister, feel like going for a threeway, including pollination?</i>\"\n\n" +
					"\"<i>Sure, and she looks just like the kind of girl I'd like to relieve me of my load.</i>\"\n\n" +
					"Resolving to make your dreams a reality, the pair of you loose a spray of pollen for your victim to slowly inhale as it lays thick in the air...\n\n" +
					"Her face flushes rapidly as her expression gradually turns to that of a bitch in heat, ready for pollination as your aphrodisiacs fill her with pink thoughts. " +
					"You and your sister help your soon to be bride of the day to climb up into the nectar bath, allowing her to get a full whiff of your intoxicating scent from the source, " +
					"something she eagerly does. When you're sure she’s sufficiently entranced you start with a sweet kiss, pulling her into your arms as you sister massages and plays with her breasts.  " +
					"Meanwhile, with the prey distracted, you ready your many stamen mounted vines for the incoming pollination.\n\n" +
					"You and your sister share a bath with her, washing her body thoroughly with your syrupy nectar until she’s as slimy and ready as the two of you are. " +
					"Your ambient pollen and various aphrodisiacs only serve to turn her on more, her skin a flushed shade of pink under your sticky nectar, making her squirt from the smallest stimulation, like your heated breath against her neck or your sister’s hands toying with her nipples. " +
					"The two of you caress her skin, making sure not to leave any area untouched, as you pull your vines into the bath, slowly aligning your cunnies and hers with your stamens.\n\n" +
					"She lazily gasps in surprise and delight as you insert yourself in her, filling her ass and cunt in just the perfect way with your thick vines. You aren't left wanting either, " +
					"expertly fucking your pussies in a way only your own stamens can manage. The three of you moan together as your stamens work both yours and her holes in perfect synchronization. " +
					"While you and your sister are in control, you aren’t sure whether you’re more enthusiastic about fucking the woman’s cunt or fucking your own, " +
					"as you can feel every stamen and the two cunts from your body that much more sharply. " +
					"Not that it matters at all as long as all these holes are filled with pollen by the end.\n\n" +
					"\"<i>Ahhh sis! It's like fucking with three dicks except you also feel two in your own pussy! Ahhhhn!!!</i>\"\n\n" +
					"\"<i>I’m completely losing it! I think I’m going to cum!</i>\"\n\n" +
					"Nectar and pussy juice mix in the bath, as the trio of you, reach orgasm after orgasm, pumping your respective bodies full of liquid pollen. " +
					"Reaching your peak for the last time with a shuddering cry, you slowly pull the girl out of your flower and deposit her back on the ground, " +
					"leaving her unconscious but satisfied as you caress her belly still full of your pollen. " +
					"You look back at your twin to confer with her.\n\n" +
					"\"<i>You think it took?</i>\"\n\n" +
					"\"<i>Oh, I’m positive it did… she should be giving birth to our seedling in no time.</i>\"\n\n" +
					"Your bellies aren’t any better, though the pregnancy will soon move down to the pitcher, " +
					"and you fantasize at the idea of giving birth, the two of you hoping for the best as you head back to camp.");
			player.sexReward("cum");
			player.sexReward("vaginalFluids");
			player.sexReward("saliva");
			player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
			statScreenRefresh();
			cleanupAfterCombat();
		}

		public function TagTeam():void {
			clearOutput();
			outputText("With your foe on the ground beneath you, you can’t help but think you’ve finally found a stamen to fertilize yourself with! " +
					"You grin at your sister, voicing your line of thought.\n\n" +
					"\"<i>Think he can fertilize us good?</i>\"\n\n" +
					"\"<i>If he can feed our two pistils sure, but I want the first turn.</i>\"\n\n" +
					"Without waiting any longer, the two of you proceed to grab him with your vines and pull him toward your waiting flower. " +
					"He violently struggles to escape as you pull him ever closer to the pool, all the while you and your sister giggle at his desperate attempts to get away.\n\n" +
					"\"<i>Look sister, he's trying so hard to escape. I love these guys.</i>\"\n\n" +
					"\"<i>You can’t run away silly, not from our vines. There's no way you will make it, tied up like this… Mmmmmmm, that and the fact your resistance only makes us hornier.</i>\"\n\n" +
					"All good things must come to an end however, and entertaining as it is, you want to pollinate now, even if your twin will get the first round! " +
					"The both of you release a massive cloud of aphrodisiac pollen toward him, letting him inhale your scent. " +
					"He doesn’t struggle much anymore as his ‘stamen’ betrays him, going erect in seconds, drooling precum at the mere thought of getting a shot at your lovely pair of pussies, " +
					"something you will be more than happy to let him do. Looking at you both with half-lidded eyes, he relinquishes control entirely. " +
					"You finally reel him into your nectar bath and kiss him as your sister lubes up his stamen with your nectar. He makes a cute moan as she prepares him for the next step, " +
					"drooling with delight at the idea of getting what she wants. You sister straddles him right away as you lay against his back feeling your own pussy clench in pleasure as she milks him for his semen. " +
					"Eventually, you both achieve orgasm, her on his dick and you on his ass. Giggling, your sister hands him over.\n\n" +
					"\"<i>It’s your turn sis, please take him in as I take his mouth.</i>\"\n\n" +
					"\"<i>All good, I have it under control. Make sure to kiss him correctly, the last time it didn't feel quite as good for me.</i>\"\n\n" +
					"While your twin takes care of his mouth, unable to wait any longer, you pull him to you, impaling your nectar drenched hole on his cock. You begin to slide yourself up and down, making lewd wet noises as you forcefully milk your former opponent's stamen. Pollination feels so wonderful! You fawn over him, moving into your drugged victim’s open arms and before long, it’s hard to figure out which of you is the most addicted. Your sister suddenly breaks the sloppy kiss, her mouth and his still linked by a strand of saliva, as your mate finally bottoms out and fills your flower with his seed, you and your sister achieve a second orgasm.\n\n" +
					"Highly satisfied, the both of you deposit him back on the ground with little ceremony, half conscious from the massive drug-induced orgasm your pollen put him under. You and your twin can’t help but hope the seed took, " +
					"daydreaming of your children to come as you seal your vaginas shut to prevent the load from escaping.");
			player.sexReward("cum");
			player.sexReward("vaginalFluids");
			player.sexReward("saliva");
			player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
			statScreenRefresh();
			cleanupAfterCombat();
		}

		public function Convert():void {
			clearOutput();
			outputText("You watch delighted as " + monster.a + monster.short + " drops to the ground in defeat. You could have used her as a seedbed, " +
					"but this time around you have other ideas as you raise your stamen mounted vine. ");
			if(player.isLiliraune())
			{
				outputText("Your twin smirks mischievously, she likes this program.\n\n" +
						"\"<i>Um, look at her lovely body; do you think we can make it better?</i>\"\n\n" +
						"\"<i>We sure can! I wonder how she'll look once the pleasure ravages her.</i>\"\n\n");
			}
			outputText("Terrified of you, she tries to crawl away, but your vines firmly grip her and pull her toward you. " +
					"your victim screams, claws and struggles in all the ways she can, but your vines finish binding her in place as your last free vine moves towards her pussy. You ");
			if(player.isLiliraune()) outputText("and your sister both ");
			outputText("moan in pleasure as the tentacle tip blooms open into a flower mounted by a hard stamen. It begins to slowly leak a purple fluid, a sign of your corruption, " +
					"as you approach it from the wanton slut slit. Unable to escape and immobilized like she is, she can only beg as your stamen suddenly starts leaking it’s liquid corruption into her pussy, " +
					"flooding her womb until her belly looks pregnant with your corrupted fluids. She resists for a moment, but it is short lived as her body begins to change color to light green, " +
					"spreading from her already nectar gushing pussy of which the amber brew mixes with your fluids. She moans and drools nectar as her hair is replaced by grass and her body becomes progressively closer to that of a plant morph, " +
					"her overflowing pussy drenching the ground from which corrupted grass begins to grow. Unsatisfied with your stamen in her pussy, " +
					"she yanks at a vine, forces it open and shoves it in her mouth with an eye crossed glaze. You can’t hold the pleasure at bay anymore, " +
					"cuming both inside and outside as the bitch grows her floral hair ornament, finishing her transformation into a dryad.\n\n");
			if(player.isLiliraune())
			{
				outputText("\"<i>Mmmmm, look how good she looks now! I’d eat her flower anytime.</i>\"\n\n" +
						"\"<i>Except we already did, sister, she doesn’t look like she will wake up anytime soon either.</i>\"\n\n" +
						"The two of you chuckle, turning people into messes like these is so much more fun with each other around. ");
			}
			outputText("Satisfied with your handiwork,");
			if(player.isLiliraune()) outputText(" the both of");
			outputText(" you depose your newest adopted daughter on the ground, who swiftly wakes up and looks at ");
			if(player.isLiliraune()) outputText(" the pair of");
			outputText(" you with eyes full of adoration." +
					"\"<i>Thank you so much, I’m so happy! Let me repay you by spreading this gift to everyone I can!</i>\"\n\n" +
					"Aw, ain’t she grateful. She stands up in a rush, having spotted a somewhat terrified imp. She proceeds to run after it, screaming." +
					"\"<i>Stop running away and fuck my flower!!!!</i>\"\n\n" +
					"You giggle and shrug. How your newest daughter enjoys her new life is none of your concern. " +
					"You head back to camp as she begins to forcefully rub the imp’s stamen for his pollen.");
			player.sexReward("vaginalFluids");
			player.sexReward("saliva");
			statScreenRefresh();
			cleanupAfterCombat();
		}

		public function pcUniqueSexScenesChoiceMenu():void {
			menu();
			if (player.tailType == Tail.MANTICORE_PUSSYTAIL && monster.hasCock()) addButton(0, "Tail Rape", manticoreTailRapeScene);
			else addButtonDisabled(0, "Tail Rape", "Req. to have Pussytail and enemy with cock.");
			if (player.tailType == Tail.HINEZUMI || player.tailType == Tail.SALAMANDER) addButton(1, "Tailpeg", hinezumiTailpegScene);
			else addButtonDisabled(1, "Tailpeg", "Req. to have Hinezumi Tail.");
			if ((player.gender == 1 || player.gender == 2) && (player.tailType == Tail.HINEZUMI || player.tailType == Tail.MOUSE || player.tailType == Tail.DEMONIC)) addButton(2, "Strangle and rape", strangleAndRapeScene);
			else addButtonDisabled(2, "Strangle and rape", "Req. to be male or female with hinezumi, mouse or demon tail.");
			if (player.lowerBody == LowerBody.PLANT_FLOWER && monster.hasCock()) addButton(3, "Get Pollinated", alrauneGetPollinatedScene);
			else addButtonDisabled(3, "Get Pollinated", "Req. to have Alraune lower body and enemy with cock.");
			if (player.lowerBody == LowerBody.PLANT_FLOWER && monster.hasVagina()) addButton(4, "Seeding", alrauneSeedingScene);
			else addButtonDisabled(4, "Seeding", "Req. to have Alraune lower body and enemy with vagina.");
			if (player.raijuScore() >= 10 && !monster.hasPerk(PerkLib.EnemyGigantType) && !monster.isAlraune() && !monster.isDrider() && !monster.isGoo() && !monster.isNaga() && !monster.isScylla() && !monster.isTaur()) addButton(5, "Volt Transfer", raijuVoltTransfer);
			else addButtonDisabled(5, "Volt Transfer", "Req. to be Raiju and enemy must be non-gigant humanoid.");
			/*if (player.hasStatusEffect(StatusEffects.HinezumiCoat) && player.lust >= player.lust100() * 0.5 && !monster.hasPerk(PerkLib.EnemyGigantType))
            else */
			addButtonDisabled(6, "Heat transfer", "Req. to have Hinezumi Coat, over 50% of max lust, enemy must be humanoid and not giant. (not yet added scene)");
			addButtonDisabled(7, "Cooldown", "Req. to have (Winter wolf/other cold cum creatures, pc must be female salamander or hinezumi). (not yet added scene)");
			if (player.yukiOnnaScore() >= 14 && monster.hasCock() && !monster.hasPerk(PerkLib.UniqueNPC) && !monster.hasPerk(PerkLib.EnemyGigantType) && !monster.isAlraune() && !monster.isDrider() && !monster.isGoo() && !monster.isNaga() && !monster.isScylla() && !monster.isTaur()) addButton(8, "Steal warmth", yukionnaStealWarmthScene);
			else addButtonDisabled(8, "Steal warmth", "Req. to be Yuki Onna and enemy must be: non-gigant, humanoid, with cock, non-unique npc.");
			if (player.hasPerk(PerkLib.EasterBunnyBalls) && player.hasCock() && player.ballSize > 3) addButton(9, "EGGS!!", EasterBunnyLayEggsRape);
			else addButtonDisabled(9, "EGGS!!", "Req. to be a Easter Bunny.");

			//Giantess and tentacle rape
			if (monster.hasVagina() && (player.isKraken() || player.isScylla())) addButton(10, "Tentacle rape!", TentacleRape);
			else addButtonDisabled(10, "Tentacle rape!", "You need scylla or kraken tentacles to do this. Only works on female foes.");
			if (player.hasVagina() && (((player.isKraken() || player.lowerBody == LowerBody.HYDRA) && player.tallness*3/2 > monster.tallness) || player.tallness > monster.tallness*2) ) addButton(10, "Living Dildo", HumanDildo);
			else addButtonDisabled(10, "Living Dildo", "To be way taller then your opponent in order to even use this scene.");

			if (player.isAlraune()) {
				//Liliraune
				if (player.isLiliraune() && monster.hasVagina()) addButton(11, "Triple Girl Fun", TreeWayRapeLiliraune);
				else addButtonDisabled(11, "Triple Girl Fun", "You need to be two person against a female to use this scene.");
				if (player.isLiliraune() && monster.hasCock()) addButton(12, "Tag Team", TagTeam);
				else addButtonDisabled(12, "Tag Team", "You need to be two person against a male to use this scene.");
				if (player.isAlraune() && player.cor >= 50 && monster.hasVagina() && !monster.hasPerk(PerkLib.UniqueNPC)) addButton(13, "Convert", Convert);
				else addButtonDisabled(13, "Convert", "You need to be a very corrupted alraune against a non unique female character to use this scene.");
			}
			else {
				if (player.isInGoblinMech() && player.hasKeyItem("Cum Reservoir") >= 0 && monster.hasCock()) {
				if (player.keyItemv1("Cum Reservoir") == 4) addButtonDisabled(13, "Fill the reservoir", "Reservoir is already full. You need to use all this stored cum before you harvest new one.");
				else addButton(13, "Fill the reservoir", gobomechFillTheReservoir);
				} else addButtonDisabled(13, "Fill the reservoir", "Req. to be in goblin mech, having Cum Reservoir upgrade instaled on it and enemy with cock.");
			}
			addButton(14, "Leave", cleanupAfterCombat);
		}

		public function manticoreTailRapeScene():void {
			clearOutput();
			outputText("While your defeated foe is laying on the ground, you make a sadistic grin as you contemplate the situation. This came just as you got hungry or rather, just as your tail did.\n\n");
			outputText("Kicking " + monster.pronoun2 + " on " + monster.pronoun3 + " back you proceed to sit on " + monster.pronoun3 + " legs to prevent " + monster.pronoun2 + " from moving. You push everything out of the way as your eyes zero in on the target, his " + monster.cockDescriptShort(0) + ". You sting " + monster.a + monster.short + " a few times, injecting " + monster.pronoun2 + " with a pint worth of aphrodisiac. For several seconds, your toy tries to get you off of " + monster.pronoun2 + " but your poison eventually kicks in and " + monster.pronoun1 + " falls limp on the ground at your it’s " + monster.cockDescriptShort(0) + " is standing throbbing and erect. Licking your lips, you take it upon yourself to relieve your victim of its pent-up lust, opening your tail and swallowing its entire length inside.\n\n");
			outputText("Smirking with malicious cruelty, you whisper softly in your terrified victim’s ear.\n\n\"<i>Does me eating you whole make it feel like you're dying? Don't worry, I will make you die over and over again until you're dry as an empty husk! From this moment you are my toy, slut!</i>\"\n\n");
			outputText("Soon, your cumpump’s face turns to a tormented expression as your tail forcefully milks him of all his cum, regularly injecting more aphrodisiac to make him orgasm and leak constantly like a hose. Almost ironically, and against " + monster.pronoun2 + " better judgment the stimulation of your vaginal walls causes " + monster.pronoun3 + " body to buck up and down in your tail, only making him cum more. On your end, you taste every drop of cum he deposits inside just like you would with your mouth. It is a delicious taste, way different from what cum would have tasted had you been human. However you have another body part that you would like to satisfy and you move your hips to the " + monster.a + monster.short + " face, shoving your drooling [pussy] in your victim’s face.\n\n");
			outputText("\"<i>Lick me clean you worm! Don’t you see how wet I am?!</i>\"\n\nBoth too terrified and supremely horny to refuse your command, your defeated foe begins to use its tongue to give your sensitive pussy a proper licking. Delighted by the sensations from both of your pussies, you feel like singing your pleasure and to your surprise a series of moans that sound like a song come out from your mouth as you ride orgasm after orgasm, splattering " + monster.pronoun3 + " crotch and face with your girl juice.\n\n");
			outputText("Only once " + monster.pronoun3 + " " + monster.ballsDescriptLight() + " have shrunk to the point they look like a pair of raisins do you let go of what's left of " + monster.pronoun2 + ".\n\nYou lick your lips feeling like you just had a five course meal fit for a queen as you leave the body of your passed out opponent on the ground at the mercy of other potential sexual predators.");
			player.sexReward("cum");
			statScreenRefresh();
			cleanupAfterCombat();
		}

		public function hinezumiTailpegScene():void {
			clearOutput();
			outputText("You feel like some payback is in order, however, this time around you have something different in mind than your regular antics.\n\n");
			outputText("You walk over " + monster.a + monster.short + " and wrap your tail around " + monster.pronoun3 + " neck tightening until " + monster.pronoun1 + " gasps for air and threateningly adding your next sentence.\n\n");
			outputText("\"<i>You lost and I won. Normally I would leave you alone and go about my business but know what? I don’t feel like it! You see that thing wrapped around your neck? That's my tail and I have an excellent idea of where I'll stick it in. If you try anything out of line I’m going to have you enjoy a real literal anal burn. Keep in mind that my flames only burns when I want or if I’m extra pissed, better not make either happen.</i>\"\n\n");
			outputText("Most creatures on Mareth cares little for being raped, but pain and suffering is a whole different concept. At first " + monster.a + monster.short + " tenses up in shock then stops struggling not to further incur your wrath. In response to " + monster.pronoun3 + " you sarcastically taunt " + monster.pronoun2 + ".\n\n");
			outputText("\"<i>That's a good buttslut right there. Now let's have a look at the material I will be having my fun with.</i>\"\n\n");
			outputText("You force " + monster.a + monster.short + " on " + monster.pronoun3 + " belly as you sit on " + monster.pronoun3 + " back releasing " + monster.pronoun3 + " neck from your tail noose and aiming your now still burning whip-like appendage for a new destination. Your ride shakes a little and you decide to properly tell it to stay still by wiping your tail across " + monster.pronoun3 + " ass cheeks. " + monster.capitalA + monster.short + " screams in pain as your tail leaves a pair of red marks across " + monster.pronoun3 + " flesh then finally gets the point.\n\n");
			outputText("Once your well aligned your tail darts in and forces its way through " + monster.a + monster.short + " welcoming ass hole. You gasp as inch after inch of your tail fills your partner all the way up the bowels. You could even see the bumps of your tail in " + monster.pronoun3 + " stomach if you wanted to. Now well inside you begin to work that hole, stretching it on your passage. While you rape that anus with your tail your hands aren’t left idle and you use them to fiercely masturbate, well intent on covering the back of your unwilling partner with your own personal markings. You feel " + monster.a + monster.short + " moan, " + monster.pronoun3 + " anal ring tightening around your tail, ");
			outputText("as you keep sliding in and out faster and faster with your own impending orgasm. The dam finally breaks as your ");
			if (player.hasCock()) outputText("[cock]");
			if (player.gender == 3) outputText(" and ");
			if (player.hasVagina()) outputText("[pussy]");
			outputText(" make a fine mess on " + monster.a + monster.short + " back. You pull your tail out of " + monster.pronoun3 + " abused hole utterly satisfied before wiping " + monster.pronoun3 + " ass once or twice as a parting gift, making " + monster.pronoun2 + " double in pain. Gosh, it feels so good to put those freaks in their place.\n\n");
			outputText("You head back to camp both morally and physically satisfied of your deeds.\n\n");
			player.sexReward("Default", "Default", true, false);
			statScreenRefresh();
			cleanupAfterCombat();
		}

		public function strangleAndRapeScene():void {
			clearOutput();
			outputText("While you were deliberating what to do you suddenly catch sight of " + monster.a + monster.short + " attempting to flee. You swiftly wrap your tail around its neck like a noose and forcefully pull " + monster.pronoun2 + " back to you.\n\n");
			outputText("\"<i>Where do you think you’re going now? You think I will just let you go after that? You’re dead wrong!?</i>\"\n\n");
			outputText("You begin to choke " + monster.pronoun2 + " until " + monster.pronoun1 + " gasp pitifully for air and then finally you get an idea. You forcefully shove " + monster.a + monster.short + " on " + monster.pronoun3 + " back exposing your ");
			if (player.hasCock()) outputText("[cock]");
			if (player.hasVagina()) outputText("[pussy]");
			outputText(" with clear intent.\n\n");
			outputText("\"<i>Well, what are you waiting for dumbass? ");
			if (player.hasCock()) outputText("Suck it! ");
			if (player.hasVagina()) outputText("Eat me out! ");
			outputText("You want me to tighten it?");
			if (player.mouseScore() >= 12 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI) outputText(" I can also give you a nice neck burn too and I won’t hesitate to do it after what you’ve done.");
			outputText("</i>\"\n\n");
			outputText("" + monster.capitalA + monster.short + " fully realizes the predicament of " + monster.pronoun3 + " situation as you begin tightening the noose and panicked, " + monster.pronoun1 + " begins to lick your");
			if (player.hasCock()) outputText(" [cock] in an effort to draw it erect as fast as possible");
			if (player.hasVagina()) outputText(" your vaginal lips");
			outputText(" in an effort to douse your wrath. That’s way to fast for your tastes though and you order your fuckslave to slow down and actually proceed with better care." + ((player.tallness < 60 && player.mouseScore() >= 8) ? " You get a thrill out of this domineering position which considering your size is actually unsurprising. It's not every day that the small mouse gets to thoroughly humiliate the cat." : "") + " As you use your opponent’s mouth like a sex toy, you give a quick glance down and spot its ");
			if (monster.hasCock()) outputText("" + monster.cockDescript() + " hardening and twitching");
			if (monster.hasVagina()) {
				if (monster.hasCock()) outputText(" and its");
				outputText("" + monster.vaginaDescript() + " wetting the ground with girl juices");
			}
			outputText(" this sicko is getting off from the abuse. Well, guess you won’t need to worry about its need then as you shove your");
			if (player.hasCock()) outputText("[cock]");
			if (player.hasVagina()) outputText("[pussy]");
			outputText("harder into " + monster.pronoun3 + " face!\n\n");
			outputText("Only as you reach your third orgasm do you finally release your abused victim from your noose. You can still see your tail imprints on its neck but hell if you care " + monster.pronoun1 + " had it coming. You head home highly satisfied.\n\n");
			player.sexReward("saliva");
			statScreenRefresh();
			cleanupAfterCombat();
		}

		public function alrauneGetPollinatedScene():void {
			clearOutput();
			outputText("With your foe on the ground beneath you, you can’t help but think you’ve finally found a stamen to fertilise yourself with! Without waiting any longer, you proceed to grab him with your vines and pull him toward your waiting flower. He violently struggles to escape as you pull him ever closer to your flower, all the while you giggle at his desperate attempts to get away. All good things must come to an end however, and, entertaining as it is, you want him pollinating you now! You release a massive cloud of your aphrodisiac pollen toward him,  letting him inhale your scent.  He doesn’t struggle much any more as his stamen betrays him, going erect in seconds, ");
			outputText("drooling precum at the mere thought of getting a shot at your lovely pussy, something you will be more than happy to let him do. Looking at you with half lidded eyes, he lets you take control entirely. You finally reel him into your nectar bath and kiss him, lubing up his stamen with your nectar. He makes a cute moan as you prepare him for the next step, drooling with delight at the idea of getting what you want.\n\n");
			outputText("Unable to wait any longer, you pull him to you, impaling your nectar drenched hole on his cock. You begin to slide yourself up and down, making lewd wet noises as you forcefully milk your former opponent's stamen. Pollination feels so wonderful! You fawn over him, moving into your drugged victim’s open arms and before long it’s hard to figure which of you is the most addicted, as you kiss him with the passion of a longtime lover. You break the sloppy kiss, your mouths still linked by a strand of saliva, as your mate finally bottoms out and fills your flower with his seed.\n\n");
			outputText("Highly satisfied, you deposit him back on the ground with little ceremony, half conscious from the massive drugged induced orgasm your pollen claimed from him. You can’t help but hope it took, daydreaming of your children to come as you seal your vagina shut to prevent the load from escaping.");
			player.sexReward("cum");
			player.sexReward("vaginal");
			statScreenRefresh();
			player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
			cleanupAfterCombat();
		}

		public function alrauneSeedingScene():void {
			clearOutput();
			outputText("With your foe on the ground before you, you feel a familiar warmth rushing through you, making you blush purple as fantasies of filling this woman with your progeny takes you over. Resolving to make your dreams reality, you let loose a spray of your pollen for her to slowly inhale as it lays thick in the air.\n\n");
			outputText("Her face flushes rapidly as her expression gradually turns to that of a bitch in heat, ready for pollination as your aphrodisiacs flood her senses. You help your soon-to-be bride of the day climb up into your nectar bath, allowing her to get a full whiff of your intoxicating scent from the source, something she eagerly does. When you're sure she’s sufficiently entranced you start with a sweet kiss, pulling her into your arms and readying your many stamen mounted vines for the incoming pollination.\n\n");
			outputText("You share a bath with her, washing her body thoroughly with your syrupy nectar until she’s as slimy and ready as you are. Your ambient pollen and various aphrodisiacs only serve to turn her on more, her skin a flushed shade of pink under your sticky nectar, making her squirt from the smallest stimulation, like your heated breath against her neck. You caress her skin, making sure not to leave any area untouched, as you pull your vines into the bath, slowly aligning your cunny and hers with your stamens.\n\n");
			outputText("She lazily gasps in surprise and delight as you insert yourself in her, filling her ass and cunt in just the perfect way with your thick vines. You aren't left wanting either, expertly fucking your pussy in a way only your own stamens can manage. You moan in unison with your partner as your stamens work both your and her holes in perfect synchronization. Nectar and pussy juice mix in the bath, as the pair of you reach orgasm after orgasm, pumping your respective bodies full of fluids. Reaching your peak for the last time with a shuddering cry, you slowly pull the girl out of your flower and deposit her back on the ground, leaving her unconscious but satisfied as you caress her belly still full of your semen.\n\n");
			outputText("Your own belly isn’t any better, and you fantasise at the idea of giving birth hoping it took as you head back to camp.");
			player.sexReward("cum");
			statScreenRefresh();
			player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
			cleanupAfterCombat();
		}

		public function raijuVoltTransfer():void {
			clearOutput();
			outputText("You ponder what to do with your defeated opponent then realize your body is overflowing with static. Your opponent shudders as you grab " + monster.pronoun2 + " by the neck.\n\n");
			outputText("\"<i>Do you know how charged I am right now? I’ll need to get rid of that before I lose my mind. Thankfully you came along at the perfect moment.</i>\"\n\n");
			outputText("" + monster.capitalA + monster.short + " only understands what you mean when you kiss " + monster.pronoun2 + ", your static starting to lick " + monster.pronoun3 + " skin, leaving a tingle of pleasure and arousal as you start to vent your electricity out.\n\n");
			outputText("Voltage rushes out of your body as it transfers to your victim");
			if (monster.hasCock()) outputText(" wrapping and sheathing around " + monster.pronoun3 + " penis,");
			if (monster.biggestTitSize() >= 1) outputText(" massaging the shape of " + monster.pronoun3 + " " + monster.breastDescript(0) + ",");
			if (monster.hasVagina()) outputText(" licking the entrance of " + monster.pronoun3 + " pussy");
			outputText(" and spreading across the rest of " + monster.pronoun3 + " skin. You smile in contentment as the haze of lust progressively clears from your mind which is the opposite of what can be said for your victim. The excess of your static slowly passes into " + monster.a + monster.short + " prone form and you almost achieve climax from the relief as you purge all of this bad energy out of yourself.\n\n");
			outputText("Your victim, however, is not so lucky. As you pour in your lust " + monster.pronoun1 + " begins to completely lose control, attempting to fiercely masturbate this excess of desire out, to no avail. As you are close to done your partner is a wrecked mess on the floor, desperate to gain release but unable to achieve it fully as the supernatural electricity keeps building " + monster.pronoun3 + " desire way beyond normal, obliterating self-restraint and pride along the way. You move away from " + monster.a + monster.short + " just as " + monster.pronoun3 + " hands begin to draw fluids out of " + monster.pronoun3 + " lust filled endowment. ");
			outputText("You stay clear as your victim’s lust explodes, spewing ");
			if (monster.hasCock()) outputText("cum");
			if (monster.hasVagina()) outputText("girlcum");
			if (monster.biggestTitSize() > 0) outputText(" and milk");
			outputText(" everywhere in the vicinity. You can see the pulse of your statics as a small glow in every thrust of " + monster.pronoun3 + " hips as " + monster.pronoun1 + " keep fiercely masturbating in an attempt to expel the lust.\n\n");
			outputText("You leave your lust receptacle there, it's unlikely " + monster.pronoun1 + " will stop masturbating anytime soon.");
			player.sexReward("Default", "Default", true, false);
			statScreenRefresh();
			cleanupAfterCombat();
		}

		public function hinezumiHeatTransferScene():void {
			clearOutput();
			outputText("You feel like some payback is in order, however, this time around you have something different in mind than your regular antics.\n\n");
			outputText("You feel like some payback is in order, however, this time around you have something different in mind than your regular antics.\n\n");
			outputText("You feel like some payback is in order, however, this time around you have something different in mind than your regular antics.\n\n");
			outputText("You feel like some payback is in order, however, this time around you have something different in mind than your regular antics.\n\n");
			player.sexReward("Default", "Default", true, false);
			cleanupAfterCombat();
		}

		public function TentacleRape():void {
			clearOutput();
			outputText("As your opponent falls defeated on the ground it dawns on you the slut needs to be severely punished. " +
					"She wanted to rape you? Well you're going to give her a whole new definition to the term.\n\n" +
					"You pick up the defeated woman, easily lifting her by the leg with one of your tentacles, holding her upside down.\n\n" +
					"<i>”Wait, what are you doing?! Stop!”</i>\n\n" +
					"You pull her to you, smiling widely as you reply.\n\n" +
					"<i>“What's wrong? You were so eager to fuck me just a second ago. You won’t back down after such a bold attempt, right?" +
					" Not that you have a choice in this matter.”/i>\n\n" +
					"You pay her no further heed as you methodically proceed to brutally strip every single piece clothing she had from her body. " +
					"Once she's suitably naked, you grab her other leg with a second tentacle and spread her wide, exposing her pussy for the entire world to see as you prepare to break her mind with the most intense set of penetrations she ever had. " +
					"You insert one tentacle... then a second, and so on, the girl eyes going wider after each insertion. " +
					"The little bitch can stretch way wider than her size would tell, and soon you're inserting your fourth tentacle inside of her abused pussy, her belly bulging with the sheer size of your limbs. " +
					"She begs you to stop but this only drives you on as you proceed to fuck her senseless, moving a fifth and sixth tentacle to invade her ass and mouth, gagging her up. " +
					"You expected her ass to be tighter than this but obviously a few people passed before you did and made a good number on the girl. Meanwhile your remaining tentacles aren't left unused as you fuck your own hole trying to get yourself off as you rape the she-devil into submission. " +
					"You watch the merciless movement of your limbs in her belly and can’t help but to be amazed the girl didn’t die from your insertions alone, likely people on Mareth are better adapted to this kind of senseless rape then humans. " +
					"No matter how accommodating she is, she still cums an incalculable amount of times, her eyes rolling back as you finally get yourself off and drench her entire body in your viscous ink, " +
					"doing a nice painting job. Still you are far from done punishing that slut as you bring your now free tentacles to her making her scream in pleasure mixed horror. " +
					"You aren’t left without pleasure yourself as each of your tentacles are covered with a million nerves and fucking the slut with them isn’t so different to you from fucking her with a full set of penises. " +
					"You moan in pleasure, achieving several ink gushing orgasms from raping the sluts many holes. This of course only entices you to fuck her even more.\n\n" +
					"You violate the mind broken woman for a good hour before leaving her unconscious on the ground like the overused heap of trash she is to bathe in the ink your many orgasms produced. It's very likely she will find even minotaurs to be too small for her for quite a while. " +
					"That said, you return to camp satisfied.");
			player.sexReward("vaginalFluids");
			cleanupAfterCombat();
		}

		public function HumanDildo():void {
			clearOutput();
			outputText("Seeing as your needs have not been met and your opponent is on the ground crawling away, a wicked idea surges through your mind as you pick it up with your tentacles. " +
					"It starts screaming, kicking and waving its arms everywhere trying to get you to drop it, but you prove too strong and mainly too huge for your victim. " +
					"Before long you manage to bind [monster him] with your tentacles so to prevent its movement as you order [monster him] to stay still.\n\n" +
					"Defeated and utterly terrified, your toy obeys reluctantly as you draw its entire body inside your vagina inch by inch and order him/her to squirm, using [monster him] like an improvised dildo to fuck yourself with. " +
					"The movements of your prisoner against your vaginal walls is simply divine as they rock you with several small consecutive orgasms, gushing ink everywhere. [monster He] finally finds your clitoris, grabs it, then start jerking it off like a pseudo cock, " +
					"driving you completely insane as you flood the ground with ink. " +
					"You finally sigh satisfied and draw your unwilling toy out of your vaginal walls still covered from head to toe with your ink. " +
					"\n\nYou laugh at it’s shocked expression, the scene is just too hilarious. Satisfied you throw your opponent away as you head back to camp.");
			player.sexReward("Default", "Vaginal", true, false);
			cleanupAfterCombat();
		}

		public function EasterBunnyLayEggsRape():void {
			clearOutput();
			outputText("Oh gawsh your balls feels like they will explode anytime soon if you don’t shoot those eggs out already! Again the welcoming piece of ass your defeated foe present you looks like the perfect place to lay and this is not the kind of opportunity you would pass on.\n\n");
			outputText("With a soulless stare and a manic smile completing your lust crazed expression that would scare the shit out of the most pent up of demon, you ready for breeding revealing your hardening [cock] as you prepare to go to town on " + monster.a + monster.short + " welcoming ass. " +
					"" + monster.pronoun1 + " eyes widen in terror as " + monster.pronoun1 + " realizes that from predator " + monster.pronoun1 + " became the prey. You grab that ass and smack it a few times for good measure forcing a moan or two out of your partner before grabbing your victims tight as you prepare for the mating." +
					" " + monster.a + monster.short + " eyes are almost begging for mercy by now but you’re too far gone in your lust to care.\n\n");
			outputText("You gasp in delight as your bunny cock slides into that sweet hole the walls tighten around you. Using your powerful bunny legs you begin to jump in and out of this rabbit hole your unwilling partner groaning as you use his/her/its backside to sate your bottomless lust.\n\n");
			outputText("<i>”Eggs…!!!! EGGS!!!”</i> You finally scream, eye crossed in delight as your two/four heavy eggs finally slide out of your balls, moving through your urethra and into your victim's spacious bowels.\n\n");
			outputText("Your [cock] still hard, you keep bucking inside -opponent- name relentlessly until you cum not once not twice but three times, tongues out, caring little for the destroyed hole of your partner. Only caring for your own satisfaction you stop fucking only once " + monster.a + monster.short + " faint from exhaustion. " +
					"Well you still got plenty of energy left but might as well fuck something that's awake. You unplug your still hard cock from " + monster.pronoun3 + " asshole gasping as your cock sensitive flesh is exposed to the air again." +
					" Without anything to plug it the excessive load of cum stashed in your victim's stomach surges out and dye the ground beneath " + monster.pronoun3 + " white. For good measure you clean your dripping penis on " + monster.a + monster.short + " ass and hops off back to camp.\n\n");
			player.sexReward("Default", "Dick", true, false);
			cleanupAfterCombat();
		}

		public function gobomechFillTheReservoir():void {
			clearOutput();
			player.addKeyValue("Cum Reservoir", 1, 1);
			outputText("Gosh you really aren't horny right now but that doesn’t mean you're going to let all this precious baby making gold go to waste!\n\n");
			outputText("You jump out of your mech and painfully grab " + monster.a + monster.short + " by the cock in order to make your next statement clear.\n\n");
			outputText("\"<i>You don’t move one inch while I work or I swear you will regret it… understood, shank???</i>\"\n\n");
			outputText("Having made your intentions obvious, you get under your mech and pull out the reservoir tube, paying no heed to your confused victim, " + monster.pronoun1 + "'s going to find out soon enough anyway. You run back to " + monster.a + monster.short + ", tube in hand, and plug it on " + monster.pronoun3 + " " + monster.cockDescriptShort(0) + " fastening it in place with straps. Satisfied with the result, you run back to your mech and press the start button activating the vacuum.\n\n");
			outputText("" + monster.capitalA + monster.short + "’s eyes widen as your engine forcely starts milking " + monster.pronoun3 + " dick. Of course " + monster.pronoun1 + " struggles for a bit against the pleasure inducing contraption but the aphrodisiac dripping syringes you added in the fastening make short work of any resistance " + monster.pronoun1 + " has left, causing " + monster.pronoun2 + " to jerk up and down on the ground in unwanted, yet forced consecutive orgasms. You watch with keen interest as the tube fills up with a constant flow of freshly harvested cum, smiling at the fluctuation of the volume needle on your motherboard. ");
			outputText("Since you have nothing to do but wait, you slowly enjoy a coffee, laid back in your driver’s seat and whistling, as the engine’s cum-o-meter fills up. Soon " + monster.a + monster.short + " eyes rolls in their socket as " + monster.pronoun1 + " completely lose control of " + monster.pronoun3 + " body, " + monster.pronoun3 + " sexual organ taking over for " + monster.pronoun3 + " brain. The needle finally reaches ");
			if (player.keyItemv1("Cum Reservoir") == 1) outputText("1 quarters");
			if (player.keyItemv1("Cum Reservoir") == 2) outputText("2 quarters");
			if (player.keyItemv1("Cum Reservoir") == 3) outputText("3 quarters");
			if (player.keyItemv1("Cum Reservoir") == 4) outputText("full");
			outputText(", a little before the cum pump falls unconscious, well that's a good harvest.\n\nYou go to the passed out cum cow and unfasten your equipment before jumping back into the mech, heading back to camp.\n\n");
			cleanupAfterCombat();
		}

		public function yukionnaStealWarmthScene():void {
			clearOutput();
			outputText("You eye your defeated opponent’s form with delight. " + monster.Pronoun1 + "'s so warm and full of life, certainly sharing some of it with you should be no problem? Yet the greedy creature squirms and crawl away in a vain attempt to escape you and this angers you to no end. Even worse this thing is a guy. You freeze " + monster.a + monster.short + " limbs in place, trapping them with ice, and approach him.\n\n");
			outputText("\"<i>You're hoarding that sweet warmth all to yourself aren't you? How about you share.</i>\"\n\n");
			outputText("He looks at you fearfully and rightly so, there's no telling how far you will go to get the warmth you’re craving from him. You spread " + monster.pronoun3 + " leg wide to reveal the already hardening " + monster.cockDescriptShort(0) + " between. You lick his length to lube it properly for what is coming next, your cool saliva making " + monster.a + monster.short + " shiver. You rub your body along his while doing this, enjoying the sensation of warmth over your skin. A few seconds later you're already straddling the towering erection, inserting inch after inch inside your folds. Moans are exchanged as you begins to lower your body on your victim’s cock, moving at a steady pace. Midway you kiss " + monster.a + monster.short + " silencing his pain and pleasure mixed groans ");
			outputText("as your cool breath pours in and you draw out his warm one. He begins to shake as his cock hardens further, both from the pleasure and the thin layer of ice preventing his release and softening, freezing the very blood inside and spreading out across his body. He would be screaming half mad right now if you weren't choking his loud reply with a kiss, breathing in his warmth. He keeps thrusting until his lower body loses mobility to the creeping frost, not one to end so soon you prolong his agonizing pleasure and yours by your own efforts, moaning in delight each time his diamond hard frozen member bottoms in.\n\n");
			outputText("As you achieve your fifth orgasm, his body is entirely covered in creeping ice and he's no better than a frozen statue, devoid of all warmth and life. What a bore, you were just barely satiated and could've went on for several hours. You kick him in anger, causing his form to crack and explode like glass in the opposite direction. Guess you had fun while it lasted, time to head back to camp.\n\n");
			player.HP = player.maxHP();
			player.mana = player.maxMana();
			player.soulforce = player.maxSoulforce();
			player.sexReward("cum");
			cleanupAfterCombat();
		}
//this.pronoun1 = "he";
//this.pronoun2 = "him";
//this.pronoun3 = "his";
}
}