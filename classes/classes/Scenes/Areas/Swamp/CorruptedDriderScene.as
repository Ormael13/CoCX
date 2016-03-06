/**
 * Created by aimozg on 03.01.14.
 */
package classes.Scenes.Areas.Swamp
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Armors.LustyMaidensArmor;

	use namespace kGAMECLASS;

	public class CorruptedDriderScene extends BaseContent
	{
		public function CorruptedDriderScene()
		{
		}

//VARS
//9999 - times encountered
//Skintone used for eyecolor
//Hair for carapace/hair
//nipplesPierced > 0 indicates pierced!

//*Encounter Intro (done)
		public function driderEncounter():void
		{
			spriteSelect(77);
			clearOutput();
			//Load monster stats so we can display things like eye/hide color!
			var drider:CorruptedDrider = new CorruptedDrider();
			//First time
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00277] == 0) {
				outputText("While you explore the swamp, the sun's light withers and fades.  You look up through the mossy trees, but the sky is totally blocked from sight.  It's nearly as purple as twilight here, but you press on, brushing aside old spider-webs as you go.  Faintly, you can hear the sound of skittering legs moving around you, but with the way the damp air muffles everything, it's impossible to tell from which direction.\n\n", false);
				outputText("You catch a blur of movement to the side, but by the time you turn for a better look, it's gone.  How odd.  Turning your eyes back to your path, you're shocked to see the form of a massive spider-woman in front of you.  She isn't just some humanoid spider-morph - she's a full-fledged drider, with a giant spider's body from the waist down and eight spindly legs supporting her.  Her eyes practically glow bright " + drider.skinTone + " while her venom-soaked lips twist into a cruel, confident smile.\n\n", false);

				outputText("\"<i>My, what lovely prey I seem to have found tonight,</i>\" croons the drider.\n\n", false);

				outputText("Her tone makes it quite clear you'll have to run or fight your way out of this!", false);
			}
			//repeat intro:
			else {
				outputText("Bushwhacking your way through the dense foliage of the swamp, it soon becomes clear that you've wandered into spider territory.  Webbing hangs from trees and the dark, dank air hides ambushes well.  Diligence and wariness pay off, for you become aware of a skittering too near to be simple background noise.\n\n", false);

				outputText("As far as you're aware, it's unlikely you'll be able to scare your stalker off, and so you simply wait for them to show themselves.  You search with your eyes and, noisily clearing your throat, make it clear you're aware of their presence.  Soft chuckling chimes around you, seeming to originate from several places in the scrub, but nothing appears.  You turn about and call again, raising your " + player.weaponName + ".  A gentle tap on the shoulder answers you, but when you look the vista is equally as desolate as the first time.  And where the hell is that laughing coming from?\n\n", false);

				outputText("Spinning again, you lose your patience and loudly demand your ambusher present itself.  A soft tug on your ", false);
				if (player.tailType > TAIL_TYPE_NONE) outputText("tail ", false);
				else outputText("hair ", false);
				outputText("pulls you back halfway, but as you open your mouth to yell, the ground gives a quiet thump.  Just barely in your periphery, you see a white apparition with a yawning mouth stretching out to bite, and your reflexes take over, dropping your weight and rolling you away from it.\n\n", false);

				outputText("\"<i>Clever little pet,</i>\" the phantom spits, resolving into the shape of a drider as your eyes focus and your adrenaline haze clears.  Raising a cupped hand to her ghoulishly grinning mouth, she laughs into it; a minute shivering in the air reveals the taut threads of silk attached to her finger.  The vibrations travel down them, shaking several silk-tied leaves and producing the raspy, laughing audience from before.  \"<i>It'd be so much easier on you if you'd just walked into the trap, sweetness.</i>\"\n\n", false);

				outputText("You've yet to meet a wild drider that let you walk away without some sadistic display of power, and this one looks to be no different.", false);
			}
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00277]++;
			if (flags[kFLAGS.CODEX_ENTRY_ARACHNES] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_ARACHNES] = 1;
				outputText("\n\n<b>New codex entry unlocked: Arachnes, Spider-Morphs, and Driders!</b>")
			}
			startCombat(drider);
		}


		//*Victory Intro: (done)
		public function defeatDriderIntro():void
		{
			spriteSelect(77);
			clearOutput();
			outputText("All eight of the drider's black and " + monster.hairColor + " striped legs collapse under her weight while she struggles ", false);
			if (monster.HP < 1) outputText("to try to continue the fight, her movements slowed by pain and weakness.", false);
			else outputText("to masturbate her swollen pussy-lips and the thick, juicy demon-cock that's sprouted in place of her clit.  She's so focused on getting off that she utterly gives up on the idea of fighting back, let alone dominating you as she seemed to plan originally.", false);
			outputText("  The spider-herm lies in a miserable, defeated heap.", false);

			var buttFuckBUTTFUCKBUTTTFUCKBUTTFUCK:Function =null;
			if (player.cockThatFits(monster.analCapacity()) >= 0) buttFuckBUTTFUCKBUTTTFUCKBUTTFUCK = buttFuckADriderOhBaby;
			var vagFuck:Function =null;
			var fuckSpinner:Function =null;
			var careful:Function =null;
			if (player.hasCock() && player.lust >= 33) {
				if (player.cockThatFits(monster.vaginalCapacity()) >= 0) {
					outputText("\nYou could fuck her pussy, though you'd be within easy reach of her lips.  If she gets any crazy ideas, it'd be hard to stop her.", false);
					vagFuck = winDriderPCDickInSpiderCunt;
					if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN || player.hasItem(useables.T_SSILK)) {
						outputText("\nYou could bind her up with some webbing for some bondage.  Her lips are dangerous, after all.");
						careful = driderVagSmartFuck;
					}
				}
				else outputText("\n<b>You're too big to fit inside her vagina.</b>", false);
				if (player.cockThatFits(12) >= 0) {
					fuckSpinner = victoryVSDriderStickDickInSpinneret;
					outputText("\nYou could fuck her spinneret.", false);
				}
				else outputText("\n<b>You briefly consider shoving it in a spinneret, but there's no way you could fit inside the tight opening.</b>", false);
			}
			var rideCock:Function =null;
			var rideOvi:Function =null;
			var bikiniTits:Function =null;
			if (player.hasVagina() && player.biggestTitSize() >= 4 && player.armor is LustyMaidensArmor) bikiniTits = (player.armor as LustyMaidensArmor).lustyMaidenPaizuri;
			if (player.hasVagina() && player.lust >= 33) {
				rideCock = winVSDriderTakeItsCockInCunt;
				rideOvi = victoryVSDriderRideOviVaginal;
				outputText("\nYou could ride the drider's retractible demon-cock or her ovipositor.", false);
			}
			var rideOviAss:Function =null;
			if (player.lust >= 33) {
				outputText("\nYou could always ride her ovipositor anally...", false);
				rideOviAss = victoryVSDriderRideOviAnal;
			}

			//(Qualifies for any rape?:)
			if (player.lust >= 33 && flags[kFLAGS.SFW_MODE] <= 0) {
				outputText("\n\nWhat do you do?", false);
				choices("Butt Fuck", buttFuckBUTTFUCKBUTTTFUCKBUTTFUCK, "Fuck Pussy", vagFuck, "Bondage Fuck", careful, "FuckSpinner", fuckSpinner, "Ride Cock", rideCock,
					"Ride Ovi", rideOvi, "RideOviAnal", rideOviAss, "", null, "B.Titfuck", bikiniTits, "Leave", combat.cleanupAfterCombat);
			}
			else combat.cleanupAfterCombat();
		}

//Lose to drider
		public function loseToDrider():void
		{
			spriteSelect(77);
			if (flags[kFLAGS.SFW_MODE] > 0) { //No rape in SFW mode.
				clearOutput();
				combat.cleanupAfterCombat();
				return;
			}
			//Build array of choices
			var select:Array = [];
			if (player.hasCock()) select[select.length] = 0;
			if (player.hasVagina()) select[select.length] = 1;
			//Genderless scene has low chance for gendered folks
			if (player.gender == 0 || (player.gender > 0 && rand(3) == 0)) select[select.length] = 2;

			//SELECT SCENE HERE
			var choice:Number = select[rand(select.length)];
			//*Loss Ride Ovi Anal unsexed - gats (done)
			if (choice == 2) loseVSDriderGetAnalledOvi();
			//*Loss Vaginal Impregnation and forced BJ - Symphonie (done)
			else if (choice == 1) loseVSDriderAndVaginallyImpreggleOvi();
			//*Loss Ride & Impregnate Butt (done) MALE
			else loseVSDriderAndGetFuckedANDAnalImpreggegity();
		}


//*Victory Rape: PC Penis goes in Vagina (done)
		private function winDriderPCDickInSpiderCunt():void
		{
			var x:int = player.cockThatFits(monster.vaginalCapacity());
			spriteSelect(77);
			clearOutput();
			//*Summary: Fuck her cunt with a wang that fits it, lose control of the 
			//situation when she kisses you with potent, envenomed lips.  Get 
			//moderately hypno'ed into cumming into her over and over again?
			outputText("Eager to plumb the depths of this greedy spider's snatch, you practically tear your way out of your " + player.armorName + " in your hurry to get naked.  Through it all ", false);
			if (monster.lust >= monster.eMaxLust()) {
				outputText("she looks ", false);
				if (player.tallness > 72) outputText("up ", false);
				outputText("at you with her " + monster.skinTone + " eyes opened wide and her tongue hanging from her mouth, panting lewdly.  Carapace-clad digits sink into her dripping honey-pot over and over while she watches, deep in her own lusty haze.  She retracts her engorged demon-cock so as to have better access to that feminine hole.", false);
			}
			else {
				outputText("she looks ", false);
				if (player.tallness > 72) outputText("up ", false);
				outputText("at you with a look of disgust in her " + monster.skinTone + " eyes.  She folds her arms across her many-bosomed, quadratically endowed chest with disdain", false);
				if (monster.nipplesPierced > 0) outputText(", the chains jingling loudly as she does so", false);
				outputText(".  In spite of keeping a stiff upper lip about it, her lower ones visibly quiver while you strip.", false);
			}
			outputText("  You saunter over to the limp-legged drider and run your hands down her inhuman, arachnid body, exploring the smooth, shiny carapace.\n\n", false);

			outputText("The corrupted monster-girl sighs and shudders at your touches, as if she can somehow feel your finger-tips through the rock-hard exoskeleton.  From the way she's trying to hold in her exhalations, you can only guess that it must feel wonderful, so you keep it up, circling and touching every part of her exotic anatomy.  By the time you've circled around her entire body, she's ", false);
			if (monster.HP < 1) outputText("giving up little, lewd moans", false);
			else outputText("breathing out lurid moans", false);
			outputText(" of pleasure and her ", false);
			if (monster.nipplesPierced > 0) outputText("chain-pierced-", false);
			outputText("nipples and clit look as hard as her natural body-armor.  You boldly grope one of her ", false);
			if (monster.nipplesPierced > 0) outputText("pierced ", false);
			outputText("breasts, feeling the supple, soft flesh shift while you roughly palm it and rub your thumb down a dark nipple.  You let the sensitive bud go and watch it spring back up, enjoying the drider's gasp of surprised pleasure for the brief moment before she muffles herself.\n\n", false);

			outputText("Still fondling one of the four nicely-sized tits, you push the spider-bitch back, admiring the drider's flexibility as she leans back over her inhuman lower body, giving you an even better view of her intoxicatingly sweet-smelling pussy.  You take " + player.oMultiCockDesc() + " in hand and rub the " + player.cockHead(x) + " along the slick lips of her pussy, shuddering slightly as her wetness rubs the sensitive glans.  Gasping, you slowly spread her molten-hot pussy around your girth, reveling in the tight embrace of her slick walls.  The drider squirms in your grip with her breasts bouncing deliciously and whole body trembling.  Spreading as easily as her cunt, the drider's venom-glossed lips slowly open into a wordless 'o' of rapturous pleasure.\n\n", false);

			outputText("Half an inch at a time, you sink ever-deeper inside the seemingly bottomless pit that is the spider-girl's steamy sex.  Reveling in the taming of the aggressive predator's sticky snatch, you postpone the eventual hilting as long as possible.  For her part, she doesn't seem to mind you having your way with her.  All eight of her spindly legs are scrabbling pitifully in the dirt, doing little more than nervelessly convulsing in uncontrolled pleasure.  The spider-woman's arms close behind your back, the sharp tips of her nails trying to claw deep furrows into your " + player.skinFurScales() + ".  At long last, your waist presses against her own to feel the oozing slipperiness of her nethers.  Your " + player.cockDescript(x) + " is totally buried in her tunnel, and now that you're holding still, you can feel the tiny folds inside her vagina slowly moving and gliding along your length, stroking your " + player.cockDescript(x) + " like dozens of tongues.\n\n", false);

			outputText("Compelled by your body's instincts, you draw back your " + player.hipDescript() + " to expose the bulk of your pussy-soaked shaft.  The spider-woman moans disappointedly, her voice filled with so much wanton desire that your " + player.cockHead(x) + " twitches in response.  You fondle the drider's lower pair of breasts with both hands, circling and squeezing the delectable mounds while you begin to repeatedly impale her squelching pussy, watching the upper row of pale breasts bounce and jiggle above your busy fingers.", false);
			if (monster.nipplesPierced > 0) outputText("  The chains binding her nipples make a delightful clinking noise with each squeeze and stroke.", false);
			outputText("\n\n", false);

			outputText("Meanwhile, the drider's swollen clit prods at your loins with each penetrating thrust, leaving lines of sticky spider-juice all over your crotch.  ", false);
			if (player.cockTotal() > 1) {
				outputText("Your extra penis", false);
				if (player.cockTotal() > 2) outputText("es fan out to the side, forgotten while you give yourself over to the silken caresses of her glorious vagina.", false);
				else outputText(" sticks out to the side, forgotten while you give yourself over to the silken caresses of her glorious vagina.", false);
			}
			else outputText("Your " + player.cockDescript(x) + " seems to bulge inside her, giving itself over to the silken caresses of her glorious vagina.", false);
			outputText("  The more you fuck the arachnid hussy's wanton slit, the more animated she becomes, until she finally breaks her wordless silence by crying, \"<i>Yes " + player.mf("master", "mistress") + ", dominate me!  I've been such a naughty bitch.  Use me like your cheap whore!  Fuck my holes full of cum, and leave me defiled in a puddle of spunk-laced mud!</i>\"\n\n", false);

			outputText("Invigorated by the rising tide of desire inside her, the drider pulls her torso up, crushing her tits into your palms so hard that her flesh bulges out through your fingers.  You smile down at the slutty spider and squeeze them hard enough to give her a taste of pain in response.  She pants, and her four " + monster.skinTone + "-hued eyes gaze at you, so full of desire that you have a hard time not cumming on the spot while you lock onto those half-lidded, luminous orbs.  You let go of her breasts and reach back to squeeze the smooth skin of her butt, feeling the joint between her human and arachnid halves just under her curvy derriere.\n\n", false);

			outputText("Heaving mightily, you use the submissive spider's ass-cheeks as hand-holds for a fast, hard fuck.  Her four ", false);
			if (monster.nipplesPierced > 0) outputText("pierced", false);
			else outputText("white-skinned", false);
			outputText(" breasts mash against your " + player.allChestDesc() + ", sweaty skin sliding back and forth and drawing gasps from each of you every time one of her nipples brushes one of yours.  She coos, \"<i>Please fuck my slutty drider-cunt harder, " + player.mf("master", "mistress") + "!  It was so naughty and cruel when I tried to rape you.  Don't let me cum... deny me over and over until I'm your good little spider-pet that'll do anything for release!</i>\"  She emphasizes every sentence by clamping her quim down on your " + player.cockDescript(x) + ", the dozens of lubricant-soaked folds rolling back and forth, milking you until you cannot help but ejaculate inside her.\n\n", false);

			outputText("Your back arches in orgasmic pleasure, fingers squeezing her butt tightly enough that your pale lover's derriere will show your hand-prints for some time.  She shudders slightly as your " + player.cockDescript(x) + " is forced as far inside her lewdly-textured vagina as possible, milking your penis with repeated strokes while your urethra bulges with the first load.  You release what feels like a torrent into her passage; the heavy spurt is quickly swallowed by the drider, disappearing deep inside her as if drawn away on an unseen current.  The sudden suction and increase in the movement of her folds makes your next rope of jizz feel even bigger, but it too disappears into the drider's seemingly-bottomless body.", false);
			if (player.cumQ() > 1000) outputText("  Amazingly, you actually manage to cum enough to fill her massive womb, and after the first few squirts, the cum slowly bubbles out around your shaft with each fresh deposit of jism.", false);
			outputText("\n\n", false);

			outputText("While you're distracted by the repeated contrast of tension and relief emanating from " + player.sMultiCockDesc() + ", the drider leans up and kisses your neck, humming against your throat as you squirt the last of your orgasmic goop into her vagina.  You slump into her arms, spent by the effort of fucking her so fast and cumming so hard.  As you lie there, her lips sucking hard enough to leave hickeys on your neck with every crushing, passionate kiss, you feel the patterns of glossy fluid tingling on your " + player.skin() + ".  A jolt of fear runs up your spine, and you try to push away from her envenomed affections.  It doesn't work!  You can barely lift your arms, let alone pull out of the amorous arachnid's embrace!\n\n", false);

			outputText("\"<i>Mmmmm,</i>\" hums the drider into your collarbone, smearing more of her toxic lip-gloss onto you as she goes.  \"<i>Such a good " + player.mf("master", "mistress") + "!  You punished me so well!  Now just relax... I've been dripping out a special venom that'll help you teach me the rest of my lesson, and I need to make sure that every... single... drop... slips inside that sexy bloodstream of yours.</i>\"\n\n", false);

			outputText("You wiggle futilely, using the last of your strength to try to break free, but it's no use - she's too strong, or the venom has made you too weak.  Dimly, you're aware of your " + player.cockDescript(x) + " pulsating inside her, hard as iron and burning hot with lust, even though you just came.  The spider-woman continues to kiss you, and with every peck of her lips, you feel yourself sagging deeper into her embrace until you lay your head down on her breast, your only movements the slight twitches of your body as it tries to deal with the poison-induced need to copulate.  You feel the warmth of her breath on your neck when she stops, cradling you in her arms.\n\n", false);

			outputText("The drider cocks her head to the side so you can see her luminous " + monster.skinTone + " eyes boring into you while she whispers, \"<i>Don't try to fight it, dear.  While there's enough of my normal venom in there to keep your " + player.cockDescript(x) + " hard enough to cum a few more times for me, the real magic is in the secondary chemicals my demonic friends were kind enough to teach me how to excrete.  You can feel it relaxing your muscles can't you?  Well, the beauty is that it isn't just your muscles relaxing... your mind is getting nice and relaxed too.  So open and pliable that you'll soon be a horny puddle of putty for me to play with.</i>\"\n\n", false);

			outputText("Gods, she's right!  You started to nod while she was talking, automatically agreeing with every sibilant syllable.  Trying to shake your head in denial, you only succeed at bouncing the jiggling tit-flesh beneath you.  You have to resist!  You beat her!  She can't do this!\n\n", false);

			outputText("As if reading your thoughts, the seductive spider answers, \"<i>Oh dear, don't struggle.  You won, remember?  You held me down and fucked me hard.  You mounted me like a fuck-hungry stud that does all his thinking with the big fat cock between his legs, and we both loved it.  You won't deny that will you?  It's the truth.</i>\"\n\n", false);

			if (player.cor > 80 && player.lib > 50) outputText("Of course it's the truth, the cunt's clearly got a good grasp on the obvious. Unwilling to lose your grip on dominance, however, you try to keep struggling to get the upper hand.\n\n", false);

			else outputText("No, that's not right.  You're not some rutting beast, you're the champion.  Sure, you've got your " + player.cockDescript(x) + " locked hilt-deep inside her squirming slit, but that doesn't mean you're some kind of " + player.mf("stud", "slut") + " who jumps on a cunt without a second thought, does it?  You blink your eyes while you try to think.  She does have a point though, if you hadn't been in such a hurry for some sex, you wouldn't be sagging into her tits and feeling so awfully relaxed.\n\n", false);

			outputText("The drider croons, \"<i>Come on, don't delude yourself.  If you weren't such a dominating, rape-hungry beast you wouldn't be nuzzling against my tits and giving me little nods of agreement.  Honestly, how could you ever think of yourself as anything different when your brain just does whatever your dick tells it to?  You just got off and might have even knocked me up, but your penis is even harder than before.</i>\"\n\n", false);

			if (player.cor > 80 && player.lib > 50) outputText("You grumble out a denial.  You're not dumb, you just like to take charge and fuck. There's no reason to resist jumping on a nice wet pussy and making it squirt while you pack it full... but you can't quite get your limbs to move.\n\n", false);

			else outputText("You mumble out a denial.  You're not a beast... you just like to take charge and fuck.  It's just so hard to resist jumping on a nice wet pussy and making it squirt while you pack it full... no!  That's not what...\n\n", false);

			outputText("\"<i>Oooh, are you leaking out more pre-cum already?  You're insatiable!  I bet you start thinking about your next fuck before you even finish getting off, don't you?  You can deny it all you want, but I felt your dick puff up a little bit more as soon as I said it.  No matter what you think, your cock is a dumb, happy little tattle-tale that always tells the girls exactly what you're thinking.</i>\"", false);
			if (player.statusEffectv1(StatusEffects.Exgartuan) == 1) outputText("  Exgartuan mumbles telepathicaly, \"<i>Fuck yes I do, but I wanna see how this plays out.</i>\"", false);
			outputText("  She adds, \"<i>Face the music - there's nothing you love more than defeating someone and letting your dick tell you what to do.  You dumb... domineering... beast...</i>\"\n\n", false);

			outputText("Gods!  It's getting so hard to think with that tight cunt clutching at your cock and the soft, feminine enunciations constantly interrupting your thoughts.  How can she concentrate with the stink of sex hanging so thick in the air?  Your " + player.cockDescript(x) + " is so horny, why aren't you fucking her yet?  You shudder weakly and remember ", false);
			if (player.cor > 80 && player.lib > 50) outputText("that it's because of her own venom paralyzing your muscles so effectively.\n\n", false);
			else outputText("there was something wrong about what she was saying... something important.\n\n", false);

			outputText("The drider pauses to gaze into your eyes with all four of hers.  She runs a hand through your hair while making gentle shushing noises at you before she resumes her diatribe.  \"<i>There there, I know how eager you are to fuck me into my place.  I'm just another wanton harlot waiting to be forced on her back and turned into a fresh cock-sleeve for you, aren't I?  You recognize the absolute truth of my words.  Every time I talk you can feel the words bouncing around inside that empty head of yours.</i>\"\n\n", false);

			outputText("You nod, actually moving your head against her pillowy breasts as you feel your strength starting to return.  Why is she wasting so much time telling you things you already know?  This bitch's cunt is like a white-hot furnace of lust, and your cock is so tired of having to sit still.  You can't wait to recover from the venom and fuck her so hard she'll black out from the ensuing orgasm.  Then you'll fuck her a few more times until your cock finally gets tired of her sloppy, cream-pied pussy.\n\n", false);

			outputText("\"<i>Oooh, that dick is just getting harder and harder isn't it?  I bet it feels like it's about to burst and cum, even though you're not able to punish me like you want to yet.  Maybe you secretly get turned on by being denied?  Oh!  I just felt your dick jump!  So you want to go around, letting your dick tell you to dominate every horny cunt you see, but the thing that turns you on more than anything else is having a woman turn the tables on you, isn't it?</i>\"\n\n", false);

			outputText("You moan, \"<i>N-no...</i>\" but a small burst of pre-cum chooses that moment to erupt from your " + player.cockDescript(x) + ", still nestled inside the squirming spider-cunt.  It feels heavenly, and while you try to struggle in your weakened state, the warm embrace of her pussy's many cock-milking folds is turning your penis into a cum-drooling behemoth on the edge of exploding.  Oh gods, is she going to do it?  Damn, you want to put her in her place, but you're so weak right now.  Even worse, her pussy has you so close, so very close.\n\n", false);

			outputText("The chitinous, oh-so-right bitch pulls your head up to gaze deeply into her eyes.  \"<i>You have a horny, naughty cock, and you always listen to it.  This rebellious member gets you into so much trouble, but you'll never stop listening to it.  You'll keep chasing every wet pussy you see, because you're just a horny animal.  A rutting, horny animal.  But I know your secret.  Your dick really wants a girl to turn the tables on you, paralyze you, and tease your cock mercilessly.  It feels so good to let me touch your body, stroke it, tease it, and squeeze it.  You won't even fight any more.  My pussy has your cock so close, so very close, and you're going to cum when I tell you.  You'll blow your load on command for me, my servile, secretly submissive mount.</i>\"\n\n", false);

			outputText("A plaintive whining, almost exactly like that of an animal, vocalizes subconsciously.  Your " + player.cockDescript(x) + " feels afire, constantly leaking pre-cum while you're held immobile in your spidery mistress' arms; you lick your lips and start to beg, mumbling out your desire to cum for her, anything for her, so long as she lets your dick orgasm again and again.  You want to climax so bad, but you want her to control your cock so much more.  It's always getting you in trouble, and it feels so good to let her use you as her cum-drooling mount.\n\n", false);

			outputText("The spider-woman giggles and surprises you by kissing you on the lips, holding you against her while her narrow tongue smears her venom all over your lips and tongue, staining them purple.  You exhale happily through your nose, feeling perfectly, utterly relaxed and yet aroused beyond any reasonable measure.  The squeezing caresses around your dick keep you happily squirting heavy dollops of pre-cum.  You've no doubt it must look like some kind of over-stuffed sausage by this point, bloated beyond reason.\n\n", false);

			outputText("When she pulls away, her face is covered in a huge blush, and she's panting out loud and interrupting her words with quiet moans as she talks, \"<i>That's a good " + player.mf("boy", "girl") + ".  Even though you're a stupid pussy-slave, bound to let your cock lead you into every hungry snatch you see, you know how to obey a smarter woman's cunt, don't you?  Let me hear you beg like the animal you are.  Whine for mistress while her cunt fucks your dick, show me with every fiber of your being how much you love to submit, to obey, and to beg to be allowed to cum.</i>\"\n\n", false);

			outputText("She lets your head hang limply, and all you can do is whine, and try to look up at her with the most pathetic expression in your eyes.  You're beaten - she's so much smarter than you and she's got you by your dick.  Why didn't you think?  ", false);

			if (player.cor > 80 && player.lib > 50) outputText("Gods it was a bad idea not to bind her lips... ", false);
			else outputText("Gods this was a bad idea... ", false);
			outputText("still, at least she's controlling your rebellious dick, teaching the little prick a lesson while letting you feel so good.\n\n", false);

			outputText("The drider moans louder and responds, \"<i>Yes, oooh, good " + player.mf("boy", "girl") + ".  You're so hard, so very hard.  You're oozing out cum even though you're not allowed to fuck me, and you love it.  I bet you don't even mind not getting to orgasm - so long as you're helpless and hilt-deep in a cunt, you're happy, aren't you?  Oohhh, I'm gonna... gonna... cum soon.  Luckily for you, I want you to squirt inside me.  I want that cock creaming my pussy as soon as I... ohhhh... so good... s-soon as I command it...  You'll do that for me, won't you?  You'll obey me completely, utterly, and pump every drop of your jism into my soon-to-be-pregnant pussy, right?</i>\"\n\n", false);

			outputText("You mewl out an affirmation, forgetting how to speak with all the venom pumping through you and the mind-crushing levels of arousal pouring out of your " + player.cockDescript(x) + ".\n\n", false);

			outputText("The spider-woman shudders from head to all eight of her 'toes', her four eyelids closing while her mouth gasps out, \"<i>Cum for me.</i>\"\n\n", false);

			outputText("The first spurt of pent-up seed splatters the spider's womb before you even realize she gave you permission, painting the squirming walls white.  You growl and cum, releasing spurt after spurt of spunk while her pussy seems to drink it all down", false);
			if (player.cumQ() > 1000) outputText(", even though you've packed it full once already", false);
			outputText(".  Her legs skitter and tremble, her pussy convulses, and your dick gets the squeezing, sucking orgasm of a lifetime.  It feels like you're pumping out two or three orgasms worth of spooge, each dick-stretching explosion of cream dilating your slit almost painfully wide.", false);
			if (player.cumQ() > 1000) {
				outputText("  The stuff dribbles out around your tool along with a mix of girl-lube, too much even for her prodigious pussy to contain.", false);
				if (player.cumQ() > 2000) outputText("  The flow thickens into a river, and soon the puddle of cum looks more like a pond, turning the dirt into a soup of muddy cum.", false);
			}
			outputText("\n\n", false);

			outputText("While it seems to go on and on, your orgasm eventually ends, leaving you to hang limp while your still-hard dick is massaged by a much wetter spider-cunt.  The " + monster.hairColor + "-haired beauty dreamily says, \"<i>Mmmm... good job, pet.  Now, let that nice hard dick do the thinking for you and keep fucking my hot cunt until it goes dry.  Maybe a few hours after you finish, you'll be able to remember that you used to be a " + player.mf("man", "woman") + " before you became my livestock.</i>\"\n\n", false);

			outputText("The blissful arachnid rolls onto her side with you still locked inside her and falls asleep, her " + monster.hairColor + " tresses ", false);
			if (player.cumQ() <= 1000) outputText("splayed across the ground", false);
			else outputText("soaking in the white puddle of spooge", false);
			outputText(".  Even unconscious, her vagina continues its rhythmic contractions around your cock, working you towards another burst of orgasmic pleasure while you wait for your strength to come back...\n\n", false);
			//[NEXT]
			doNext(winDriderPCDickInSpiderCunt2);
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
		}

//Part 2 of the above
		private function winDriderPCDickInSpiderCunt2():void
		{
			var x:int = player.cockThatFits(monster.vaginalCapacity());
			spriteSelect(77);
			clearOutput();
			outputText("<b>Sometime Later...</b>\n", false);

			outputText("Pistoning your hips violently, you continue to ravage the unconscious spider, fucking her in a brutal, beast-like manner that centers entirely upon your own pleasure.  You cum, dumping a fresh batch of jizz into her already-stuffed twat, grinning when a few more rivulets of ooze roll over her inflamed pussy-lips to drip into the growing puddle.  Still hard, " + player.sMultiCockDesc() + " continues to twitch, hungry for more, and you don't deny it.  You grab the arachnid bitch and stuff your dick into her mouth, shivering while her venom seeps into your dick, keeping you hard and ready to blow.  Whatever special, immobilizing venom she had earlier, it seems exhausted, and the only response your body has to the onslaught of toxin is to erupt, spouting a huge load of semen into her mouth.\n\n", false);

			outputText("A low growl rips through your throat as you pull back and plaster her face white, coating the caked-on residue of a few previous loads with fresh moisture.  You shift position and force your " + player.cockDescript(x) + " between her two pairs of breasts, sandwiching it in there for the titty-fuck of a lifetime.  Pistoning back and forth, humping the glorious orbs relentlessly, you give yourself over completely to your sore dick, letting your world dissolve into the feelings of each of the spider-woman's orifices around your member.\n\n", false);

			outputText("<b>Even later...</b>\n", false);

			outputText("You collapse into the dirt, not even caring that it stinks of dried cum and girl-jizz.  You've completely emptied out every speck of sperm from your " + player.ballsDescriptLight() + ", and you even kept going for a while after that.  It wasn't until " + player.sMultiCockDesc() + " went soft at last that you found enough peace to lie down.  ", false);
			if (player.cor > 80 && player.lib > 50) outputText("The longer you sit there, the more your strength returns to you, and the more the submissiveness placed into you by her venom recedes. Still, you've tired yourself out too much to leave at the moment.", false);
			else outputText("The longer you sit there, the more you remember of yourself, and the more you forget the animal, the rut-beast that the spider-woman placed inside you.", false);
			outputText("  You shiver and wrap your arms around her, snuggling against her while a primal, buried part of your brain insists that she's YOURS.  You fall asleep like that, resting dreamlessly even through your mate's waking and departure.", false);
			hideUpDown();
			monster.lust = 98;
			monster.HP = 2;
			player.lust = player.maxLust();
			flags[kFLAGS.COMBAT_BONUS_XP_VALUE] = monster.XP;
			combat.cleanupAfterCombat();
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
		}


//*Victory Rape: Ride Spider-Cawk in Vagoo (done)
		private function winVSDriderTakeItsCockInCunt():void
		{
			spriteSelect(77);
			clearOutput();
			outputText("Your eyes lower towards the drider-woman's thick, demonic shaft lying exposed to your wicked intention.  Easing yourself over to the defeated arachnid, you slowly reach out and squeeze her pained member, a quiet, unwanted moan escaping from between her soft lips.  Gently caressing her length, you make sure to trace your fingers around every bump and curve of the corrupted tool that throbs heatedly in your palm, using your thumb to apply pressure underneath her growing cock.  The drider lies fully erect in no time at all, and you respond by hastily jerking her pride before relinquishing your grip and moving away from your new toy.  Any reluctance she may have held before has vanished with your gratuitous touch, the exhausted spider-lady now humping aimlessly at the air in an attempt to relieve herself - using her trembling hands to fondle her breasts while whining pathetically at her lack of sexual gratification.  An idea sparks in your head - you figure it'd be more satisfying to watch the spidertaur squirm than to give her relief straight away.\n\n", false);

			outputText("Avoiding the desperate drider's spindly legs, you walk around to grab onto her limp torso, pulling it over until she lands on her back with her lewd figure in full display.  The girl pauses hesitantly, cupping one of her heaving tits in her hand while placing a finger to her lips with the other as she waits for you to make your move - in her current state, it's unlikely she can retaliate even if she wanted to.  The drider's corrupted cock twitches with excitement, a thick rod standing tall amidst the collapsed heap of its owner.  A bead of pre-cum oozes from the tip as evidence of your quick work, reminding you it would be rude to leave the job unfinished.  Swaying your " + player.hipDescript() + " enticingly, you move slowly down towards her lower torso, reaching over and propping yourself on top of the spider-woman with your " + player.assDescript() + " pressing against her slick devil-dick.  You look into her eager eyes, the aroused pet almost screaming for relief with her pained stare and the equally responsive cock grinding along your " + player.vaginaDescript(0) + ".  Reaching behind you, you grab the base of her member and pull, eliciting a yelp and an involuntary thrust from your victim that almost forces her tip inside.  It misses, however, and instead slips out in front of you, the nubs of her cock pushing along your lips and accidentally brushing along your " + player.clitDescript() + ".  You stifle a moan - she'll pay for that.\n\n", false);

			outputText("Holding on to the top portion of the drider's thick member, you squeeze her in between your upper legs, pressing the demonic dong against your labia and inner thighs, both hot with desire.  Sliding upwards, you begin to bounce on top of the drider in a cowgirl-like position, grinding against her length while your " + player.buttDescript() + " slaps against her soaking pussy with every downward thrust.  The arachnid-morph convulses and moans along with your movements, unable to handle the feeling of your warmth against her heated member and the expertise of your hands fondling her tip, your fingers soaked with her leaking pre.  Riding your new pet victoriously, you make sure that the spider-woman can't escape the confines of your " + player.hipDescript() + ".\n\n", false);

			outputText("The drider's shaft begins to grow underneath your fingers, the slick head pulsing with the need to release into your palms.  You decide to lay still, driving your pet insane as she tries to thrust in between your thighs for a chance to ejaculate.  Before she can, however, you grab the base of her studded cock and squeeze firmly, a gasp of both pain and pleasure escaping from the arachnid's lips.  You inform the trembling plaything that if she wants an opportunity to release she'll have to make you do so first, otherwise - you grip harder - you'll beat her down again.  The busty spidertaur nods timidly, to which you respond with an eager grin.  She eyes you up as you position yourself above her bulbous member, giving it one last playful slap before slamming yourself down and taking as much of it as you can.\n\n", false);

			outputText("A moan escapes your lips as her nine-inch pleasure-rod ", false);
			if (player.vaginalCapacity() < monster.cockArea(0)) outputText("bottoms out", false);
			else if (player.vaginalCapacity() < monster.cockArea(0) * 2) outputText("fits tightly", false);
			else outputText("barely reaches halfway", false);
			outputText(" inside of you.", false);
			player.cuntChange(monster.cockArea(0), true, true, false);
			outputText("  You lean down, straddling her sides and reaching over to plant a kiss on one of the spider-woman's ", false);
			if (monster.nipplesPierced > 0) outputText("pierced nipples, circling the metallic stud", false);
			else outputText("nipples, circling the moist bud", false);
			outputText(" with your tongue", false);
			if (player.tongueType > TONGUE_HUMAN) outputText(" as the rest of its demonic length lashes out and wraps around her pillowy bosom", false);
			outputText(".  With your free hand you massage one of her top breasts, your forearm pressing against the one below it.  The drider has no choice but to satisfy your hunger for her motherly tits, holding the back of your head with her hard gloved hand and groping your " + player.assDescript() + " with the other.  You begin to gyrate your hips in a sideways motion, allowing the demon-cock inside of you to grind against your inner walls with every bump protruding from its dark body.  The spider-woman bites her bottom lip as she forces herself not to paint your " + player.vaginaDescript(0) + " with her fervent seed.  You take your time switching through various techniques, slapping your butt against her groin or squeezing your thighs together and tightening your muscles against her thickness. Each advance is met with her lustful thrusting, the spider's cock pumping in and out in accordance to your own hip movements.  The slick juices of her cunt mix with yours, and you dwell in the pleasure of your " + player.vaginaDescript(0) + " filled with her own hot sex.\n\n", false);

			outputText("You begin to feel yourself coming to a climax, increasing your movements and forcing the drider-woman to pump faster inside of you.  Lurching back, you drive yourself into the arachnid's crotch, her fat, demonic cock squeezing itself against your gripping walls.  Unable to take the pressure, your plaything explodes inside of you, hot white seed splattering against your inner walls and slowly oozing outside with every thrust.  You grind yourself against the spunk-machine forced inside, your orgasm causing you to shudder in pleasure along with her.  In the fullness of your vagina and time, you lay flat against her exhausted figure, your hips still squeezing the last few remaining drops of spooge left drooling from the spider's tip.  You figure it wouldn't hurt to lay still for another few hours, comfortable against the soft, plush curves of your new mate.", false);
			//GET KNOCKED UP
			//Pregnancy Goes Here
			player.knockUp(PregnancyStore.PREGNANCY_DRIDER_EGGS, PregnancyStore.INCUBATION_DRIDER, 151);
			player.slimeFeed();
			player.orgasm();
			dynStats("cor", .5);
			combat.cleanupAfterCombat();
		}

//*Victory Rape: Ride Ovi Vaginal (done)
		private function victoryVSDriderRideOviVaginal():void
		{
			spriteSelect(77);
			clearOutput();
			//*Summary:  Roll the drider over and squat on an ovipositor - reuse anal intro? (fuck you bitch, i'm taking your shitty kids to the lake and turning them pink)	
			player.slimeFeed();
			outputText("Eyeing the small lump of the spider's retracted ovipositor, you resolve to have a little fun with it, even if it means giving the spider exactly what she wants in a way that she doesn't.  You tear off your " + player.armorName + " while the drider watches with ", false);
			if (monster.HP < 1) outputText("hate", false);
			else outputText("lust", false);
			outputText(" pouring from all four of her eyes.  Now nude, you saunter over with a gleam in your eyes and a telltale tingling in your loins.  You move around some of the eight, sprawled-out legs and close in on her side.  With a mighty heave, you help to lift her up onto her shaking legs, then keep pushing, tipping her dangerously to the side.  She cries out in surprise as she flips over, rolling onto her back while her spindly, chitinous legs flail uselessly at the muggy air.\n\n", false);

			outputText("Like this, you're treated to a perfect view of ALL of the web-woman's endowments.  Her four D-cup tits flatten slightly against her torso now that she's on her back, hanging slightly to the side.  At her crotch, you can see her glistening, black-lipped sex puffing up, the tip of her large button already peeking out of her tempting box.  Just below that, the black and " + monster.hairColor + "-striped exoskeleton of her spider-half starts, merging down into an bulbous, arachnid shape.  At the very bottom of it all is the huge bulk of her abdomen, covered with numerous spinnerets and with a wide, mostly-retracted organ near the back.\n\n", false);

			outputText("The spider's look of ", false);
			if (monster.HP < 1) {
				outputText("hate fades slightly when she sees you eyeing her ovipositor, and with a sigh of annoyance, allows the segmented organ to slowly slide out from her body.  It grows to just over two feet in length, swaying sinuously in the air, though you can tell it isn't completely engorged yet.  Still, your " + player.vaginaDescript(), false);
				if (player.hasCock()) outputText(" and " + player.sMultiCockDesc() + " twitch", false);
				else outputText(" twitches", false);
				outputText(" at the thought of trying to pack all of that meaty, alien pole inside you.\n\n", false);
			}
			else {
				outputText("lust only deepens when she sees you eyeing her ovipositor, and with a twinkle in her eyes, she releases a hiss of pleasure.  The organ pulsates once, then practically explodes before your eyes, lancing just over two feet into the air and waving back and forth sinuously, like a snake.  In a way, the tubular, segmented shaft reminds you of a monstrously thick cock, something that might even give a minotaur pause. Your " + player.vaginaDescript(), false);
				if (player.hasCock()) outputText(" and  " + player.sMultiCockDesc() + " twitch", false);
				else outputText(" twitches", false);
				outputText(" in anticipation - you can't wait to feel that thing going inside you!\n\n", false);
			}

			outputText("You sit on top of the chitinous abdomen and grab it in your hands, letting it pulse and squirm in response to your touches.  The copious slime it's covered in lets your fingers easily slide down its length.  Each stroke of the odd, feminine member elicits a pleasured groan from your defeated opponent, and you quickly surmise that she must like this just as much as you do using your own genitals.  Pumping and stroking it, you watch with perverse fascination as the ridges grow firmer, hardening in your hand.  A viscous green slime bubbles out of the wide slot at its tip as the spider-girl's moans reach a crescendo.  It's as lubricated as it's going to get.\n\n", false);

			outputText("Shifting back a bit, you place the entrance to your " + player.vaginaDescript() + " against the wiggling tip.  The drider sighs and warm green goop gushes inside you eagerly, spreading your canal wide and making you gasp with pleasure.  Subtly, you begin sliding your hips, seeking to soak in more sensation for your slit.  Cooing in delight, the drider grabs at her four ", false);
			if (monster.nipplesPierced > 0) outputText("pierced ", false);
			outputText("tits and begins to grope herself, squeezing hard on her breasts and tugging viciously at her pert, black nipples.  The segmented ovipositor wiggles excitably and plunges forward to bury the first few inches inside your sloppy snatch, the tube dilating and contracting inside you with alien rhythms.", false);
			player.cuntChange(30, true, true, false);
			outputText("  You gasp, arching your back and sliding your " + player.vaginaDescript() + " forward, as if your quim could somehow devour the entire length on its own.\n\n", false);

			outputText("Once you get about halfway down the drider's ovipositor, it stops sliding in so easily, leaving you to hump away at the drider's abdomen in a futile quest for further penetration.  You mewl in disappointment and prepare to pull back and fuck the portion you've already taken like no tomorrow.  The flexible shaft undulates, then pistons forward, spear-like.  You feel your " + player.vaginaDescript() + " stretching wide, then relaxing as one of the segmented rings nestles into your canal's sopping embrace.  A fresh gush of green slime sprays out of your tightly-stretched labia, strings of the stuff shooting fanwise over the drider's glossy, black abdomen.", false);
			player.cuntChange(50, true, true, false);
			outputText("\n\n", false);

			outputText("Throughout it all, the spider-girl is still mauling her tits, the once-perky nipples now distended and sore from the constant tugging, twisting, and flicking she subjects them to.  The skin of her breasts is rosy and pink, with imprints of her fingers highlighted in red where she's squeezed herself too hard.  In between exhaling blissful moans of contentment, the drider pants, \"<i>Just like that... yeah.  Ride my fat, egg-filled cock like that, you slut...</i>\"\n\n", false);

			outputText("You look back in irritation, though your displeasure is stolen away by another fierce push of the woman's massive organ.  It stretches you so nicely while it fills you with sloppy green goo, the excess squeezing out from your lips in three squirts as another fat ring pops inside you.  You shudder and look down, watching as the ovipositor begins to wriggle and squirm, twisting about inside you in a relentless drive to impale your " + player.vaginaDescript() + " with its entire length.  Even before you finish adjusting to the last one, the next segment is thrown against you, squeezing out gushes of the verdant egg-lube while it works its way inside you.  Though you've almost got the entire thing lodged deep in your twat at this point, it still manages to squirm back and forth, working half of the ring in at a time, until it too pops into place, stuffing you utterly.\n\n", false);

			outputText("Shuddering in what you suppose must be climax, the drider screams and twists, bucking at the air and threatening to dislodge you from your perch.  You hold onto her slippery chitin as well as you can, but you get far more support from the girthy, widening ovipositor inside you.  Each of the thick rings is pressing tightly into your walls, while the circular tip engorges and presses against your cervix, sealing against it in a perfect kiss.  Slowly, you feel your belly growing warm, your uterus filling with the green goo, now with no vent for the pressure.  A few wet, gurgling moments later you start to feel full, but thankfully, the fluid-filling flow tapers off to a slow trickle.  At the same time, the spider stops her gyrations, her whole body holding utterly, completely still.  You look down at her, seeing an orgasmic, slack-jawed expression grow on her face until her eyes begin to roll back.  In that same second, you feel a burgeoning, spherical pressure sliding up your soaking tunnel, rubbing along your walls from your lips all the way to now-stretching cervix.\n\n", false);

			outputText("There's a moment of terrific, agonizing pain that forces you farther onto your back, and then it vanishes, the only signal of its passage a muffled slosh coming from your belly.  You shiver, feeling strange, unexpected bliss welling up from your loins, just in time for the next egg to traverse your ovipositor-gaped, goo-spewing cunny.  Even before this one can squeeze through your abused cervix, another backs up behind... and another... and another.  Your poor, stretched-out pussy clenches, shooting spasms of pleasure through your whole body that make you grunt and moan.  Lost in your orgasm, you throw your head back to howl, only to find the drider's cock, graduated from its larval clitoris, twitching and spewing its foul steaming load directly where you just laid your head.  Several ropes of the demonic jizz land in your " + player.hairDescript() + " and even patter on your forehead, but you can't be put out to care right now.", false);
			if (player.hasCock()) {
				outputText("  Your own " + player.multiCockDescriptLight() + " retaliate", false);
				if (player.cockTotal() == 1) outputText("s", false);
				outputText(" automatically, dumping ", false);
				if (player.cumQ() < 500) outputText("scores of", false);
				else outputText("unending", false);
				outputText(" jizz-ropes on your groin and the base of the drider's slimy stalk.", false);
			}
			outputText("  The sounds coming from your throat are gutteral, animalistic, and utterly inhuman, but you're too busy cumming... cumming so hard with each orb dropping into your already-packed womb, lost in motherly bliss.\n\n", false);

			outputText("Vocalizing like an animal, you climax over and over in a seemingly endless rut, swiveling your hips while your muscles milk the ovipositor, practically pulling the eggs into your hungry womb.  When the last one is packed tightly into your uterus, your " + player.vaginaDescript() + " keeps milking it, a hollow ring of disappointment penetrating your fog as you realize the pleasure has come to an end.  The thick, egg-laying organ slowly shrivels, shrinking down enough that it slides free.  As it's pulled out, a river of slime comes with it, released to pour out of your overstuffed cooch.\n\n", false);

			outputText("Still in the aftershocks of your orgasm, your muscles go limp, leaving you to slide off the drider into a puddle of your own juices on the ground.  The slime piles out of your punished pussy and pools in small declivities in the ground; you keep trickling more from your loins to swell the tides.  Next to you, the spider-woman is gasping and shuddering, still spurting tainted fluid all over herself from her demonic cock while bursts of lady-cream erupt from her sloppy spider-cunt.  She's stopped abusing her breasts and her arms lie immobile beside her; she's cumming utterly hands-free from the pleasure of thoroughly impregnating your womb.\n\n", false);

			outputText("You watch her for a time, until her orgasms finally die down.  By that point, you've recovered enough to get dressed.  You walk away a little bow-legged, with a new, heavy weight in your belly, just waiting to be born.", false);
			//GET KNOCKED UP
			//Pregnancy Goes Here
			player.knockUp(PregnancyStore.PREGNANCY_DRIDER_EGGS, PregnancyStore.INCUBATION_DRIDER, 151);
			player.slimeFeed();
			player.orgasm();
			dynStats("cor", .5);
			combat.cleanupAfterCombat();
		}


//*Victory Rape: Ride Ovi Anal sex-insenitive (done)
		private function victoryVSDriderRideOviAnal():void
		{
			spriteSelect(77);
			//*Summary: Force the drider onto her back and then fish out her ovipositor, jerk it off, then climb on top for some egg-based buttlovin'
			clearOutput();
			outputText("Eyeing the small lump of the spider's retracted ovipositor, you resolve to have a little fun with it, even if it means giving the spider exactly what she wants in a way that she doesn't.  You tear off your " + player.armorName + " while the drider watches with ", false);
			if (monster.HP < 1) outputText("hate", false);
			else outputText("lust", false);
			outputText(" pouring from all four of her eyes.  Now nude, you saunter over with a gleam in your eyes and a telltale tingling in your loins.  You move around some of the eight, sprawled-out legs and close in on her side.  With a mighty heave, you help to lift her up onto her shaking legs, then keep pushing, tipping her dangerously to the side.  She cries out in surprise as she flips over, rolling onto her back while her spindly, chitinous legs flail uselessly at the muggy air.\n\n", false);

			outputText("Like this, you're treated to a perfect view of ALL of the web-woman's endowments.  Her four D-cup tits flatten slightly against her torso now that she's on her back, hanging slightly to the side.  At her crotch, you can see her glistening, black-lipped sex puffing up, the tip of her large button already peeking out of her tempting box.  Just below that, the black and " + monster.hairColor + "-striped exoskeleton of her spider-half starts, merging down into an bulbous, arachnid shape.  At the very bottom of it all is the huge bulk of her abdomen, covered with numerous spinnerets and with a wide, mostly-retracted organ near the back.\n\n", false);

			outputText("The spider's look of ", false);
			if (monster.HP < 1) {
				outputText("hate fades slightly when she sees you eyeing her ovipositor, and with a sigh of annoyance, allows the segmented organ to slowly slide out from her body.  It grows to just over two feet in length, swaying sinuously in the air, though you can tell it isn't completely engorged yet.  Still, your " + player.assholeDescript(), false);
				if (player.hasCock()) outputText(" and " + player.sMultiCockDesc() + " twitch", false);
				else outputText(" twitches", false);
				outputText(" at the thought of trying to pack all of that meaty, alien pole inside you.\n\n", false);
			}
			else {
				outputText("lust only deepens when she sees you eyeing her ovipositor, and with a twinkle in her eyes, she releases a hiss of pleasure.  The organ pulsates once, then practically explodes before your eyes, lancing just over two feet into the air and waving back and forth sinuously, like a snake.  In a way, the tubular, segmented shaft reminds you of a monstrously thick cock, something that might even give a minotaur pause. Your " + player.assholeDescript(), false);
				if (player.hasCock()) outputText(" and  " + player.sMultiCockDesc() + " twitch", false);
				else outputText(" twitches", false);
				outputText(" in anticipation - you can't wait to feel that thing going inside you!\n\n", false);
			}

			outputText("You lean over and grab it in your hands, letting it pulse and squirm in response to your touches.  The copious slime it's covered in lets your fingers easily slide down its length.  Each stroke of the odd, feminine member elicits a pleasured groan from your defeated opponent, and you quickly surmise that she must like this just as much as you do using your own genitals.  Pumping and stroking it, you watch with perverse fascination as the ridges grow firmer, hardening in your hand.  A viscous green slime bubbles out of the wide slot at its tip as the spider-girl's moans reach a crescendo.  It's as lubricated as it's going to get.\n\n", false);

			outputText("Climbing over the drider's bulbous body, you bend over to present your " + player.assDescript() + " to the twitching ovipositor, beckoning her to slide inside your twitching " + player.assholeDescript() + " as you stand atop its owner.  The sprawled-out spider looks up past all of her body to watch you, leaving you waiting.  Nothing happens at first.  You're just there, ass in the air and waiting to be violated, encouraging it on your own terms, but she doesn't do anything at all.  She simply watches you.  It isn't until a scowl of irritation makes its way across your face that she acts.\n\n", false);

			outputText("The ovipositor lurches over, bending and flexing to reach up to your exposed hole, barely touching you while it explores your cheeks.   You pant and grab your " + player.buttDescript() + ", pulling yourself wide to expose the clenching, dark circle that is your pucker.  It rubs across your hand before finally finding its way into your anal cleavage, ridges sliding between your backside and flopping against your ring while it blindly tries to get adjusted.  The moist, dripping slime it exudes quickly turns your ass into a green-glazed slip-'n-slide.  A sudden shock of sensation alerts you that yes, the ovipositor has finally found your asshole.\n\n", false);

			outputText("The tentacle-like tube prods forward, leaking ooze inside you as the first ring contracts to squeeze inside you.  You gasp when it pops into place, barely adjusting before the next ridge slides into the slightly-loosened sphincter.", false);
			player.buttChange(30, true, true, false);
			outputText("  Each segment somehow feels larger than the one preceding it, though it seems impossible given how widely stretched you feel by the time the fourth is inside you.", false);
			if (player.hasCock()) {
				outputText("  The warm organ brushes past your prostate, the slippery caress making " + player.sMultiCockDesc() + " dribble a ", false);
				if (player.cumQ() < 500) outputText("drop", false);
				else outputText("stream", false);
				outputText(" of pre-cum down its length.", false);
			}
			if (player.hasVagina()) {
				outputText("  Your " + player.vaginaDescript(0) + " quivers", false);
				if (player.wetness() >= 3) outputText(" and drips", false);
				outputText(" sympathetically with the sensation, and your " + player.clitDescript() + " peeks from the wet lips.", false);
			}
			outputText("  Yet you are not denied the anal pleasure you crave, as the widening bands now filling you are each pushing out harder than the one before.  At the stimulation, her own demonic clit swells as if posessed, nodulates, and hardens into dick form, poking up from her pussy and drooling a slime of pre-cum onto her abdomen.  The second ring rolls over your anal g-spot and you gasp, nearly losing your grip.  The third knocks your " + player.legs() + " out from under you, and you collapse atop your partner, squeezing oozing dick", false);
			if (player.hasCock()) outputText("s", false);
			outputText(" between you", false);
			if (player.clitLength >= 4 && player.hasVagina()) outputText(", and pressing your monster chick-stick into it; the gooey heat sends a tingle of shock up your spine and your pussy convulses", false);
			outputText(".", false);
			player.buttChange(50, true, true, false);
			outputText("\n\n", false);

			outputText("Shivering, you glance back up at the defeated woman; she has a passionate, prideful look plastered on her face, though it seems to waver each time another inch of ovipositor pushes past your stretched-out ring.\n\n", false);

			//([not mans]
			if (!player.hasCock()) outputText("\"<i>I never would've thought you were an anal-pregnancy slut,</i>\" hisses the spider in pleasure, flexing her organ harder while it curls through your guts, so deep inside you that you wonder how much further she can go.", false);
			else outputText("\"<i>Just because I have an exoskeleton doesn't mean I can't feel you dripping on me.  I thought I was the corrupt bitch here, but you... you take the cake.</i>\"", false);
			outputText("\n\n", false);

			outputText("With a final hard shove, the last few segments pop inside you", false);
			if (player.hasCock()) outputText(", nearly crushing your prostate from the tight squeeze", false);
			outputText(".  ", false);
			if (!player.hasCock() && player.hasVagina()) outputText("You gasp and dribble a few strands of girl-goo, the contractions of your achingly empty pussy intensifying.  ", false);
			if (player.hasCock()) outputText("You gasp and squirt a few weak ropes of cum, having a miniature orgasm on the spot.  ", false);
			outputText("Writhing happily, you sigh ", false);
			if (player.hasCock()) outputText("while your " + player.multiCockDescriptLight() + " dribbles white, wasted goo onto the black and " + monster.hairColor + " striped carapace below", false);
			else if (player.hasVagina()) outputText("while your " + player.vaginaDescript(0) + " dribbles fem-slime onto the black and " + monster.hairColor + " striped carapace below", false);
			else outputText("while your fingers tweak your " + player.nippleDescript(0) + "s and your starved sphincter sucks at its slimy, squirming stuffing", false);
			outputText(".  Without warning, the ovipositor dilates, pulling your " + player.assholeDescript() + " even wider.  An explosion of warmth goes off in your guts, and you realize that your term as an incubator has begun with a sense of perverse delight.\n\n", false);

			outputText("The large, round egg pushes its way up your butt, squeezes past your ring", false);
			if (player.hasCock()) outputText(" and your prostate", false);
			outputText(", and travels deep inside you, bulging your belly the slightest bit once it's deposited.  With a groan of deep satisfaction, you start humping the fluid-slicked chitin beneath you, barely registering the long, seemingly unending series of eggs that infiltrate your ass", false);
			if (player.hasCock()) outputText(" and milk your prostate as they push past", false);
			outputText(".\n\n", false);

			outputText("The stream of slime only spreads as the stimulation of the sliding spheres slewing into your sphincter sets off", false);
			if (player.gender > 0) {
				outputText(", simultaneously, ", false);
				if (player.hasCock()) {
					outputText("a storm of semen-squirting spurts from your shaft", false);
					if (player.cockTotal() > 1) outputText("s", false);
				}
				else if (player.hasVagina()) outputText("a siege of spray-scattering spasms from your snatch", false);
				outputText(" and", false);
			}
			outputText(" squirts of slippery spooge from her shuddering spunk-stick.  While you shriek, squirm and shiver shamelessly, you see the spider-slut suspended in the same, similarly a slave to the sensation of shoving and slamming her stalk into your straining sacrum and stuffing you with her strange spawn.\n\n", false);

			outputText("Gradually, you're lifted off the carapace by your inflating abdomen.  Your belly gurgles, making you burp as you're filled with enough eggs to make you feel uncomfortable and compressed.  The " + player.skinFurScales() + " of your stomach is drum-tight by the time you slide off the wilting ovipositor, and the bottom portion of it is soaked in the last of your partner's orgasm.  You look positively pregnant as you stagger upright and make for your garments, trying to ignore the exhausted drider's jibes.\n\n", false);

			outputText("By the time you finish getting dressed, she's fallen into a fitful slumber.  What an ordeal!", false);
			//GET KNOCKED UP
			player.buttKnockUp(PregnancyStore.PREGNANCY_DRIDER_EGGS, PregnancyStore.INCUBATION_DRIDER - 200, 10); //Butt pregnancy goes faster
			player.slimeFeed();
			player.orgasm();
			dynStats("cor", .5);
			combat.cleanupAfterCombat();
		}

//*Victory Spinneret Penetration - written by Sham (done)
//(please view the spinneret as a spider-horsecock because for all intents and purposes that is really what it is) - shambadibs (1.5-inch width max because i'm racist against buur-bous american penis) (also probably a corruption minimum this is a pretty dick move) (I GET IT)
		private function victoryVSDriderStickDickInSpinneret():void
		{
			spriteSelect(77);
			clearOutput();
			var x:Number = player.smallestCockIndex();
			outputText("Quickly shedding your " + player.armorName + ", you eye up the incapacitated drider, wondering how best to take advantage of your successes.  A remarkably nasty thought strikes you, and your lips nearly curl into a devious grin then and there.  You stride toward your trophy, taking pleasure in the simmering hatred in her eyes as she glares up at you.  A sudden bout of mocking laughter stops your progress; the drider seems to have noticed ", false);
			if (player.cockTotal() == 1) outputText("your", false);
			else outputText("one of your", false);
			outputText(" sub-par (by Marethian standards at least) cock", false);
			if (player.cockTotal() > 1) outputText("s", false);
			outputText(".  \"<i>What the hell is that?</i>\" she taunts. \"<i>I wasn't aware I was beaten by a baby imp.</i>\"  She snaps her fingers three times: up, across the body, and then out again on the first side.\n\n", false);

			outputText("Outraged at her slight, you storm up to her and cuff her ear, reddening the marble-like skin and drawing a snarl from her.  You push her to her back, her huge abdomen pressing flat against the ground and her spider-legs curled up plaintively. Thanks to her insults, you're prepared to give her the dicking of a lifetime.  You're given pause, however, when you look over your shoulder, noticing the huge, twitching spinneret, positioned a few feet under her ovipositor.  Your interests shifted, you turn towards her rear and wrap a hand around the almost phallic appendage.  The way the drider's subsequent protests are buried under a heady moan confirms your suspicions; this is definitely one of her 'weak points'.\n\n", false);

			outputText("A little twist of the spinneret is all the stimulation the drider needs, and she climaxes right then and there.  Her little clit quickly swells into a large demonic dick, which quivers piteously.  The new penis pours a surprising amount of semen over her firm belly and onto both rows of plump, sweat-glistening breasts.  You dodge a thick spray of half-formed webbing, then affix the drider's panting visage with a victorious smirk.  With a condescending clicking of your tongue, you chide the drider for such a lack of control.  \"<i>P-...Piss off!</i>\" she sputters, trying to form words through your continued stroking of her sensitive web-maker.  \"<i>Be happy you c-can even pleasure a woman with such a tiny tool!</i>\"  Your smug expression melts into a frown at her impudence.  She wants pleasure?  Well...how about you try something else?\n\n", false);

			outputText("Any satisfaction the drider could have gleaned is quickly replaced with complete trepidation as you swivel her spinneret toward you, grabbing your " + player.cockDescript(x) + " and lining it up with the onyx protrusion.  She manages to choke out a protest before you plunge into the depths, the tight recesses squeezing you wonderfully.  A strangled, gurgly scream peals from the oversensitized girl, both her arms and legs flailing about.  You push up to your pelvis into her spinneret, then slowly—so slowly—draw back, the sensation leaving the drider to claw deep divots into the mossy ground.  You draw out to the " + player.cockHead(x) + ", then thrust back in, taking your sweet time with the motions.  Her eyes roll back into her head, and another gurgle rumbles in her throat.  You have to wonder if she can even form coherent thoughts, in this state.  No matter; she insulted you, after all.  She begins hissing something through her clenched teeth, and while unintelligible at first, you can eventually make out, \"<i>Fuck you... fuck you... fuck you...</i>\" like some sort of vulgar mantra.\n\n", false);

			outputText("Annoyed by her rebelliousness, you reach back, ", false);
			if (monster.nipplesPierced > 0) outputText("grasp the intersection of her nipple-chains, ", false);
			else outputText("grasp her nipples, ", false);
			outputText("and tug them about roughly.  You're delighted when she reacts with an excited gasp, neatly interrupting her chant.  You feel her body tensing up under you, and you prepare yourself for her second orgasm.  Taking pleasure in her squirms, you make one more powerful thrust.  Once again, you slowly pull back until you're nearly out, and you hear her sigh of relief at the thought of removing the obstruction.  At the last moment, you thrust as hard as you can back inside, bottling the still-unsticky webbing inside the spinneret as she attempts to ejaculate.  Her silk-making organ bulges obscenely with the load, and her groan quickly escalates to a shriek at her inability to clear the way.  Meanwhile, her penis is wantonly spraying its seed all over her shivering form, coloring her pale complexion even whiter.\n\n", false);

			outputText("Fem-spunk, at this point, is openly leaking from her similarly unattended nether-lips.  The drider tries her best to curse at you, and the mixture of aroused moans and furious swearing entertains you more than it should.  Her words catch in her throat, however, when you reach down and begin lightly caressing and tickling the impaled spinerette.  Her screams reach an even higher octave, her entire body going into a frenzied spasm under your excruciatingly gentle touch.  She quickly cums again, her backlog of silk puffing her poor silk-maker up even further.\n\n", false);

			outputText("Finally, on a merciful whim, you uncork her pent-up organ and lean back against the inevitable geyser of silk-spunk.  With a final, near-ear-splitting screech, both the spinneret and her still-erect penis gush huge globs of alabaster fluid in brain-scrambling pulses of pleasure.  \"<i>Son of a-a... bitch...</i>\" she groans, her hands idly gnashing her bosom against itself in a forced orgasm-induced fit.  \"<i>Bastard!</i>\"  You merely chuckle and give her spewing stiffy a little slap, watching gleefully at the wiggling pattern of her ejaculatory fluids.  However, while her maleness's flow eventually slows, the spinneret doesn't let up.  Like a minotaur who's taken one too many lust drafts, the drider throws her half-formed web all over the trees, undergrowth, ground, and, of course, your entire front.", false);
			if (player.biggestTitSize() >= 3) outputText("  The semi-sticky stuff soaks into the cleavage of your " + player.allBreastsDescript() + ", the feeling surprisingly enjoyable.  You even knead the web in a bit, biting your bottom lip from the sensation.", false);
			outputText("  She actually slips into unconsciousness from the huge release, falling limp under you and even beginning to snore.  It dawns on you at that moment; you haven't even gotten to climax!  Cursing yourself for such a silly oversight, you cast around for something fuckable.  Eventually, you find the perfect receptacle for your lust; her slightly-gaping, purple-lipped mouth.\n\n", false);

			outputText("As gently as you can, you slide off of the drider's body and move around in front of her, falling to a kneel next to her head.  No sense in foreplay, you figure - she's asleep and you're ridiculously horny. Leaving her upside-down, you slide your " + player.cockDescript(x) + " between her lips slowly, like a baker making a delicious crème brûlée.  Upon entry, however, caution is scattered in the wind, abandoned because of the feeling of her glorious gob, enveloping, envenomating, lubricating, and teasing the shaft.  Although aware of how bad of an idea it is, you're compelled to thrust as deep as you can into your knocked-out sex aid.  Happily, she's too out of it to react to the face-fucking", false);
			if (player.balls > 0) outputText(", even giggling a little as your " + player.ballsDescriptLight() + " slap against her nose", false);
			outputText(".\n\n", false);

			outputText("Her tongue idly licks and teases your " + player.cockDescript(x) + ", each passionate thrust jiggling her hefty tits.  It's not long before your limit is reached.  Planting a hand on each side of her head, you slam your groin into her chin.  She gurgles in pleasure from your continuing rough treatment, and her pleasured sounds only increase when your first load is shot down her throat.", false);
			if (player.cumQ() < 50) outputText("  She easily keeps in rhythm with your spurts.", false);
			else if (player.cumQ() < 350) outputText("  She sputters a bit from the amount of semen, but she catches up well enough.", false);
			else if (player.cumQ() < 1000) outputText("  She's hard-pressed to swallow enough of your seed before another waves washes in.", false);
			else outputText("  Her throat bulges from the sheer amount of cum you deposit into her mouth, and she nearly chokes as she attempts to swallow all of it.", false);
			if (player.cockTotal() > 1) {
				outputText("  Your other ", false);
				if (player.cockTotal() > 2) outputText("cocks give ", false);
				else outputText("cock gives ", false);
				outputText("you a picture-in-picture view of what's happening inside, launching identical strokes all over her face.  She's in for a stinging surprise if she opens her eyes quickly when she wakes.", false);
			}
			outputText("\n\n", false);
			outputText("Your lust sated, you disengage from her with a little pop, leaving her to lick her lips happily and groan unintelligible babble.  You wipe your " + player.cockDescript(x) + " off on her hair to clean it off a bit, then redress and head out.  With a glance at the snoozing drider over your shoulder, you head out of the smelly swamp and start back towards camp.", false);
			player.orgasm();
			dynStats("cor", .5);
			combat.cleanupAfterCombat();
		}

//*Loss Ride Ovi Anal unsexed - gats (done)
		private function loseVSDriderGetAnalledOvi():void
		{
			spriteSelect(77);
			clearOutput();
			outputText("You fall to the ground, defeated by the agile arachnid-woman as she slowly advances towards you, her engorged clit growing larger and larger as it throbs in your direction.  You've managed to find yourself crumpled face down in the dirt, your " + player.buttDescript() + " in full display of the aroused drider while she grins lustfully at your broken figure.  Grunting, you begin to pull yourself off the ground, only to hear your attacker 'tsk' before feeling the warm stickiness of her web launch upon your limbs, gluing your hands to your ankles and leaving you completely vulnerable.  You struggle against the bindings, but to no avail.  Lifting your head, you turn to see the drider stroking her now fully-enlarged demon cock, replacing the hardened clit that once adorned her moist pussy.\n\n", false);
			outputText("\"<i>You just had to make it harder for yourself, didn't you?</i>\"\n\n", false);

			outputText("You grunt, too exhausted to move any further.  She chuckles at your disinterest, bending down to rest her thick member in between your cheeks and slowly grind along the cleft of your ass.  You feel the tiny nubs of her demonic cock rub along your eager asshole, pre-cum lubricating your hot entrance as she moans in unrequited pleasure.  Gritting your teeth, you force yourself to ", false);
			if (player.HP < 1) outputText("relax in order to reduce the discomfort", false);
			else outputText("calm your racing thoughts and resist showing how eager you are", false);
			outputText(" as she begins to enter inside of you.\n\n", false);

			outputText("Inch by inch, the bumps and curves of her nine-inch demonic dick massage your puckered hole as she plunges further in, working slowly to savor the feeling of being inside of you.  With a hearty grunt she fails to control her lust, driving in at full force and filling you with her corrupted member.", false);
			player.buttChange(monster.cockArea(0), true, true, false);
			outputText("\n\n", false);

			outputText("\"<i>Ungh, if I knew your ass was this eager to s-swallow my cock I wouldn't have wasted my time tying you up...</i>\"  She gasps, clearly the more impassioned of the two of you as she manages to bottom out inside of your " + player.buttDescript() + ".  You have very little time to regain your breath as the horny drider-woman begins to thrust in and out of your " + player.assholeDescript() + " with fevered abandon, tongue lolling out of her open mouth while you're forced to bounce against her crotch, your ", false);
			if (player.balls > 0) outputText(player.ballsDescriptLight(), false);
			else if (player.hasVagina()) outputText(player.vaginaDescript(0), false);
			else outputText("taint", false);
			outputText(" slapping against her slavering cunt.  She grabs on to your " + player.hipDescript() + ", using you as leverage to pump her pole inside of you while you jerk against the ground, eyes closed tight while your cheek rubs against the cold dirt.\n\n", false);

			outputText("After what seems like hours of the lustful spider-taur plunging in and out of your now loosened hole, the horny herm lessens her speed, appearing to give in to exhaustion.  She slaps your asscheeks and slowly removes herself from inside you, your original feeling of fullness now being replaced by the pleasure of her nubby cock grinding against your entrance as it moves against your inner walls.  At this point you're already numbed to the sensation of her pleasurable rod, though the emptiness of your insides seems to wake you up from your enthused trance.\n\n", false);

			outputText("Your vigor renewed, you start to move against your binds once more, only to pause once you feel the sensation of a larger, more intimidating organ rub along your back.  You try to move around to observe the new invader, though you freeze when you notice the slim spider-legs of your opponent surround you on all sides - almost like a prison.\n\n", false);

			outputText("\"<i>Well, aah, enough of my fun,</i>\" the drider pants, groping her pillowy breasts and stroking herself to maintain her stiff erection.  \"<i>Time to get down to business.</i>\"\n\n", false);

			outputText("Shifting your head, you notice a menacing ovipositor reaching from underneath the arachnid-woman's abdomen - the ribbed, tentacle-like appendage thick and twitching with excited intention.  The lengthy organ bulges with her rounded eggs, its slick opening drooling a slimy liquid that pools onto the curve of your back.  You stifle a moan as you feel her thickness poking against you, the segmented ovipositor tracing around your puckered anus to relax the unprepared hole.  Feeling something drip onto your face, you look over your shoulder to see the hot and bothered drider woman groping and massaging her distended member, pre-cum spurting from the tip and landing on your nose.  Her scent fills your nostrils, the feeling of helplessness doing little to aid your struggle.\n\n", false);

			outputText("With a more gentle movement of her body, the arachnid-morph begins to ease into your " + player.assholeDescript() + ", the ridges of her ovipositor grinding against your opening.  The bulging appendage is far thicker than the drider's demonic dick, and the constant jerking and shuddering of the egg-laying organ causes your body to drag along the moist dirt to keep up with the movements of the cock-like extension.  The drider's length feels as if it stretches on infinitely, the arachnid-tentacle dipping further and further inside until it stops inside of you, beginning to expand uncomfortably against your inner walls.  Your mouth hangs open; the feeling of the growing stalk as it tenses is driving you insane.  The carapaced body of the drider lowers onto you, her weight resting upon your back while the woman groans in pleasure.\n\n", false);

			outputText("\"<i>A-ah, here they come!</i>\"\n\n", false);

			outputText("One by one, the round protrusions of the ovipositor enter your ", false);
			if (player.HP < 1) outputText("abused", false);
			else outputText("hungry", false);
			outputText(" asshole, her eggs squeezing along and filling you up inside.  You yelp as the seemingly endless onslaught of spherical objects force their way inside, the drider effortlessly pumping in and out of you to help the process along.  The arachnid-woman pants and curses while she jerks off her nubbed member, using both of her hands to double the pleasure of being inside of you.  You're pushed and shoved against the ground while your attacker slams against your " + player.assDescript() + " with wild abandon, and with one final push she's sent over the edge, shuddering in orgasmic delight as ropes of cum fly out of her thick length and land ", false);
			if (player.tallness < 66) outputText("in front of you", false);
			else outputText("on your face", false);
			outputText(", her pussy juices squirting alongside them.  As she calms down, the herm-drider's spunk lessens in force, instead drooling out of her softening cock and landing onto your ", false);
			if (player.tallness < 66) outputText(player.face() + ", sliding down across your cheeks and along your lips", false);
			else outputText("chest, trickling between your " + player.nippleDescript(0) + "s", false);
			outputText(".  She pulls out her ovipositor slowly, though the bulge in your stomach remains as evidence of her work.", false);
			player.buttChange(50, true, true, false);
			outputText("  With a giggle, she removes herself from you and walks in front of your defeated form, bending down to kiss you gently on your lips and licking a pearl of semen from your face.  Your skin tingles with the brush of her venomous lips.  \"<i>Thanks for the fuck, pet!  Here's hoping my babies won't keep you for too long,</i>\" the arachnid-woman purrs, before turning around and walking towards the hazy embrace of the fog.  \"<i>Toodle-oo~!</i>\"\n\n", false);
			outputText("...\n\n", false);
			outputText("A few hours later and you wake up to the sound of loud croaking and the smell of the bog.  You try moving your limbs, finding that your bindings had partially dissolved since the encounter. Painfully removing yourself from the ground, you begin your journey back to camp - carrying a bit more than you were before.", false);
			//GET KNOCKED UP
			player.buttKnockUp(PregnancyStore.PREGNANCY_DRIDER_EGGS, PregnancyStore.INCUBATION_DRIDER - 200, 10); //Butt pregnancy goes faster
			//(slimefeed, set lust to 100?)
			player.slimeFeed();
			dynStats("sen", 1, "lus", 800, "cor", 1);
			combat.cleanupAfterCombat();
		}

//*Loss Vaginal Impregnation and forced BJ - Symphonie (done)
		private function loseVSDriderAndVaginallyImpreggleOvi():void
		{
			spriteSelect(77);
			clearOutput();
			//FAST FACTS: Drider uses webbing to spread eagle you then oviposits your womb while making you suck some dick.
			//SYMNOTE: I think I've done a proper naga pass on this but it was really late so don't trust me 100% on that. I honestly can't imagine the way this scene is set up ever working for centaur, the posing would have to be completely different, but if someone else wants to try to centaurify it you are welcome to. I think there could probably stand to be a few offhand references to your cock and tits if you have them in the later parts, I'm not good at sewing those in. (done)
			//(No reason it wouldn't work for hoers. The ovipositor is two feet, flexible, and at the tail end of her long-ass abdomen, while her genitals are all the way in front. She could DP a horsemans (or another drider) no problem if she tethered the human head to the bound forelegs. It won't be very comfortable, but this is a loss. So, in you get. -Z)
			//[LUST: Desperately (jerking your " + player.cockDescript(0) + \"<i>/grinding your fingers against your " + player.clitDescript() + \"<i>/and shamelessly groping your " + player.biggestBreastSizeDescript() + \"<i>) you find yourself unable to continue fighting.  The carnal sexuality of the drider - her full chest, her gorgeous lips, and her pristine and gorgeous skin - has overwhelmed you.  Even if your mind was acutely aware that defeating your enemy was a necessity, your body would rebel. You need release.  More than that, you need her to provide it.] [BEATDOWN: With unceremonious indignity, you fall onto your " + player.buttDescript() + \"<i>.  It seems that you overestimated your capabilities, or underestimated the drider's strength, or perhaps both.  You have lost, and the expression that twinkles in her four eyes suggests that what awaits you is the violation you have come to expect from defeat.  Though weary, you steel yourself for what is to come. You may be her next victim, but you don't have to enjoy it.]
			outputText("The drider ignores you at first, lifting her head and glancing from side to side.  It's unclear why - perhaps she is worried that another predator will have been attracted by the sounds of combat, and attempt to steal her prey away.  Whatever her reasons she's apparently satisfied with what she sees.  Her gaze returns to you, eyes twinkling maliciously.  \"<i>Aren't you <b>precocious</b>,</i>\" she chuckles, walking slowly towards your prone body.  \"<i>Such an aggressive little morsel.</i>\"  A single strong spider leg places itself on your chest, pushing you ", false);
			if (player.isBiped() || player.isGoo()) outputText("down onto your back", false);
			else outputText("over, onto your side and then to your back", false);
			outputText(".  It seems that, regardless of their slenderness, she can still put an impressive amount of weight behind her legs.  They ", false);
			if (!player.isNaga()) outputText("pull your own " + player.feet() + " apart", false);
			else outputText("scrape inquisitively at your scales", false);
			outputText(", her body climbing atop you.  Before you can realize her plans her spinneret is at work, ", false);
			if (!player.isNaga()) {
				outputText("coating your ", false);
				if (player.isTaur()) outputText("rear ", false);
				outputText(player.legs() + " and pinning you in that prone, separated position", false);
			}
			else outputText("spraying webbing across your tail and weighing it down to pin it against the earth", false);
			outputText(".  She turns with the eerie speed of the arachnids of Mareth, quickly performing the same acts to your ", false);
			if (!player.isTaur()) outputText("wrists", false);
			else outputText("forelegs", false);
			outputText(" and leaving you pinned and spread-eagled on the ground.  \"<i>That should stem that.</i>\"\n\n", false);

			outputText("Turning, she makes as though to bite you, before pausing.  A thought runs through her head, and if the wicked curve of her dark lips are any indication, she likes it.  She gathers webbing on her fingers and bends down, inspecting your features carefully.  Placing said fingers on your chin she forces it open, quickly and expertly weaving sticky strands to connect your jaw and your chest.  The strands are just short enough to keep your chin held down, while strong enough that you can't seem to pull at them.  ", false);
			if (!player.isTaur()) outputText("Her fingers then move to the sides of your head, lacing webbing through your hair and sticking it firmly to the ground. More vulnerable than ever, you can't lift your head without ripping your hair from your scalp in chunks.", false);
			else {
				outputText("Her fingers then reach behind your head, pulling your upper body off of the damp dirt and stretching sticky strands between your skull and your immobile forelegs.  ", false);
				if (player.biggestTitSize() > 4) outputText("With pain and then a pop, your " + player.allBreastsDescript() + " squash out to the sides as she presses your torso into your knees.  ", false);
				outputText("Reaching back for more webbing, she ties your arms behind your back in a bundle of white thread.  Now pretzeled into an uncomfortable curled shape, you can't pull your torso away from your forelegs without wrenching your head off of your neck.  You feel completely helpless.", false);
			}
			outputText("  \"<i>Now, isn't that just precious,</i>\" the drider chuckles again.  She leans in low, her fingers trickling over your thighs like the steps of... well, of small spiders.  You gurgle in response, mouth held open uncomfortably.  She roams slowly up your body.", false);
			if (player.hasCock() && monster.nipplesPierced > 0) outputText("  Chains brush over " + player.sMultiCockDesc() + " as her chest passes your crotch.", false);
			outputText("  Her fangs trail teasingly along your belly, her fingers crawling up your sides.", false);
			if (player.biggestTitSize() > 3) outputText("  Venom dribbles down the cleavage of your " + player.biggestBreastSizeDescript() + " as she approaches your vulnerable face.  Her own quartet of matronly tits comes to rest on them as her torso appears over their horizon.", false);
			outputText("\n\n", false);

			outputText("Drawing ever closer, at last her eyes blink slowly in front of yours.  Her lips seem to be pouting, then smirking, then - oh.  She's swirling something around in her mouth.  Finally it opens up above yours, her fangs extending.  Though you flinch in preparation for a bite, none comes - instead venom drips off her teeth and lips, every drop felt as it lands on your tongue.  You gurgle once more in protestation at this torture, but her hand pets the skin of your forehead maternally to remind you of your powerlessness.  Sadistic delight plays across her eyes as she watches your restrained struggles.  As the venom seeps, a heat grows.  Though subtle at first, you soon recognize it: lust.  Raw, burning need.  The poison coursing through you makes little effect on your heart, but a world of difference to your crotch.", false);
			if (player.hasCock()) outputText("  Worse still, its blood-swollen protuberance is met with no reaction from the drider.", false);
			outputText("  The slow drip serves no purpose - at least, none that serves you.  She is not teasing your body, nor whispering delicious torments.  All it does is force you to tremble more and more as she watches, knowing the effect that her venom will have. For no reason beyond her own sadistic amusement, she forces your body to put on the display of a helpless victim losing more and more control of their lust. You feel like a toy.\n\n", false);

			outputText("And the more you drink, the less you mind that.\n\n", false);

			outputText("Eventually she decides you've had enough, or perhaps grows impatient.  Her mouth closes, and her body rises.  Yours, incapable of either, merely burns.  The entirety of your body desires her, and your mind has a difficult time coming up with counterarguments.  Venom flows through you, commandeering your sensibilities and trading them in for a desire thus far unquenched.  She stands tall above you, straddling your body with her arachnid behind.  Something moist and ridged stretches out, caressing your thighs.  The degree to which you hope it's a cock is nearly immeasurable.  \"<i>I think you'll make a delectable little nest, morsel,</i>\" the drider croons.  \"<i>Let's start.</i>\"  Though you can't shift your head down to look at what she has in her behind, you can feel it.  It slaps messily against your thighs, searching out your " + player.vaginaDescript() + ".  The caress the tentacle gives your slit is mockingly affectionate, but any illusions of gentility that may have persisted are soon ended by the thrust that delves greedily and deeply into your " + player.vaginaDescript() + ".  If there is any small mercy, it's that the insatiable lust flooding your mind may wind up sated after all.\n\n", false);

			outputText("The thick, vile appendage twists inside of you as it advances.  Slick and obscene in its girth, each individual segmented ridge is palpable against your walls.  The prick practically breathes inside of you, pulsing with life and the ravenous desires that embody a phallus.  As it pushes it twists about in an attempt to wriggle in deeper, inadvertently showing the flexibility of its form.  \"<i>How many eggs have you lain, snack?</i>\" the drider coos.  Her fingers rub her sizeable swollen clit forebodingly.  It grows increasingly large, acquiring veins and bulges where no clit should.  \"<i>How swollen has your belly grown?</i>\"  Her tongue flicks across her venomous full lips.  \"<i>Time to enjoy it again.</i>\"  You can't see the tentacle shoved into your " + player.vaginaDescript() + ", but you are increasingly certain that it is in not, in fact, a dick.", false);
			player.cuntChange(50, true, true, false);
			outputText("  With her body in the way, you cannot clearly see what transpires in your loins, yet a sight emerges before your eyes that dominates your mind. Her clit has finished growing, and is no longer a clit.\n\n", false);

			outputText("From her crotch a cock has erupted, demonic and terrible.  It drips with sweat and musk, dribbling onto your collarbone.  The position you're in has never seemed more ominous - or more exciting.  Her cockhead smacks against your lower lip, pre-cum bouncing off and lightly spattering on your forehead.  Venom-addled, breathing in her fragrant spunk sends a quake up your body.  Inadvertently your hips start to seize, your " + player.vaginaDescript() + " shuddering in surprising pleasure.", false);
			if (player.hasCock()) outputText("  Even your " + player.cockDescript(0) + " spurts some pre-cum of its own.", false);
			outputText("  There's some shame in having a small orgasm from nothing more than the scent of sperm, but you place the blame solely on your intoxicated state.\n\n", false);
			//It would take a creature with truly fucked up biology to evoke such a reaction otherwise.

			outputText("She grinds her prick against your open mouth, massaging the underside of the infernal shaft with your lips.  The steaming heat of the cock this close to your face makes you sweat, a low sheen of moisture on your forehead adding to the heady sensation of lust.  Pushing past your nose, the scent of her demon dick only grows more intense.  \"<i>Open up, morsel,</i>\" the drider coos, then snickers.  She lowers her upper body, angles herself, and then calmly slides her prick into your mouth.  A low purr rises from her throat, cockhead grinding into your palate.  \"<i>So warm,</i>\" she hisses affectionately, \"<i>so wet.  Have you hungered for my domination, snack?</i>\"  Her shaft presses firmly against your tongue.  \"<i>Have you hungered for me?</i>\"\n\n", false);

			outputText("You suspect she is not waiting for an answer, given that her prick pushes at the entrance to your throat.  Horny and helpless, you start sucking.  It seems like a good idea, and the obscenity of the act arouses you.  Chitin-covered fingers wriggle into your hair as she moans, and her heady breath seems echoed by the beast lodged between your legs, long since settled but preparing for its obscene duty.  The appendage is buried as deep as it can go, practically kissing your womb.  This intimacy is soon interrupted by the equivalent of an obscene tongue.  The bulge comes slowly; it pushes aside the walls of your " + player.vaginaDescript() + " without mercy, the ovipositor forcing your hole into an all-access VIP club for its fertilized cargo.  No matter how your pussy contracts, there's only one direction those eggs are going right now: in.  Belching into your belly, the first egg pushes all the way and sits heavy inside of you. Already the entrance of your " + player.vaginaDescript() + " can feel the next one coming, but her thrust distracts you.\n\n", false);

			outputText("The drider presses you to her crotch", false);
			if (!player.isTaur()) outputText(", cutting your head loose from the imposed bondage with sharp, hard fingertips", false);
			outputText(". Throat stretched and jaw gaped, no matter how much you try to hold it you gag.  You spit, and you struggle, and you gag.  A throaty exhalation above you lets you know that she doesn't care.  The webbing at your wrists holds strong as you tug reflexively; but her hips rock forward, knocking your nose into lusciously pale skin.  Venom drools from her open mouth, catching on her tits before eventually finding its way into your hair, landing in small spatters.  She fucks <i>deep</i>, never leaving your throat as she bounces your head.  Though you can occasionally catch a breath through your nose, it's not quite enough.  The corners of your vision fade in and out as your eyelids flutter, finding it more and more difficult to stay awake.  Even the lust inflicted upon you seems strained and near being forgotten as you struggle.\n\n", false);

			outputText("Another egg shoves itself into your womb.  The next is already halfway down your cunt and another is at your entrance.  They are coming faster, and you don't know when they'll stop.  Small twitches shake your head as your oxygen-deprived and unconscious state threatens to overtake you.  You're so close to the edge that it takes you a moment to notice when she rips her prick out of your mouth and lets you drop.  Dredged-up slime splatters across your chin and chest, drooling from her cock.  Hacking and gasping desperately you fill your lungs, jolted back to wakefulness.\n\n", false);

			outputText("Before you can protest or ground yourself, she takes your hair and shoves herself back in.  The taste of the back of your throat sits on your tongue as she pushes past, back into the filthy deepthroat.  She's obviously done talking to you, using you purely as a vehicle to get herself off now.  A repository for her eggs and a hole to dump her lusts in - add it to your resume.  Her webbing is too strong to rip, and her venom too intoxicating.  Even if you could fight off both of those aspects, you're not sure you could pull away from the ovipositor dug into you.\n\n", false);

			outputText("You don't mind, though.\n\n", false);

			outputText("You like it.  The venom coursing through your veins makes sure of that.  It's not an intense feeling, not an overwhelming need to fuck fuck fuck now forever always, but you like this sex.  You like this drider.  You like her cock in your throat, smearing the thickest of your saliva over your lips.  You like the weight of that fifth egg being added to the pile in your womb - and then, there's six. You like your helplessness, the restrained limbs occasionally spasming in a desperate need to move.  It's sedentary and unusual, a sexual experience you don't frequently have.  In some ways the slothful use of your " + player.vaginaDescript() + " would be more at home against your lips, while the aggressive rape of your throat is expected for your crotch.  As far as this drider seems to be concerned, the two may as well have swapped places.\n\n", false);

			outputText("You take another deep gasp of breath as you lay against the ground.  You hadn't noticed that she had stolen so much of your air again.  Perhaps you passed out.  The deprivation and the venom have already slowed your mind enough that you can't be certain, but she picks your head back up, and back on her prick you go.  Each time you feel a little weaker, a little more exhausted.  Your jaw is slacker than it was before, the energy to squeeze and suck bleeding out of you and splattered across your face every time she dredges up the depths of your throat.  She just lets your head drop now, whenever she thinks you're near passing out.  It hurts to ", false);
			if (!player.isTaur()) outputText("land against the ground", false);
			else outputText("strain your neck suddenly with the dead weight of it", false);
			outputText(", and you nearly spit up, but the drider's abuse remains welcome.\n\n", false);

			outputText("Her thick cock feels like it might be stretching your throat less now, but you don't think it's gotten any smaller.  Your throat is just being as worn out as any sex hole, as gaped as any slut's cunt.  Your tongue is nearly limp in your mouth, and even your gagging is quieter.  Her crotch pushes up your nose every time you slap into it.  Wet noises echo in your head, and it sometimes takes a bit too long to remember they're coming from it.  She violates your mouth, and violates you.\n\n", false);

			outputText("The cum explodes into your throat unexpectedly - but then, you can't even remember when she started fucking your mouth.  How could you have known how close she was?  The drider moans loudly, slapping into and grasping your cheeks with hard fingers as she pulls you down to blow her foul load deep into your maw.  You think you can feel it landing directly into your stomach.  Hair is pulled, and scratches dig into your scalp.  Shuddering and seizing a few last times, with a sigh she lets you go.  Cum keeps flowing as you fall back, drenching your mouth and then shooting across your features.  It pools out the corner of your mouth when your head slumps to the side.  The last few spurts drip across your ear, the drider squeezing them out carefully with her dark fingers.  She wriggles her behind and slowly pulls her ovipositor out, leaving the sticky weights in your womb as a reminder of her actions.  You haven't cum yet.  She doesn't care.\n\n", false);

			outputText("She steps over you, satisfied and still groaning slightly.  Not fully retracted, her ovipositor drags over your belly and chest as she departs, smearing your pussy juices over you.\n\n", false);

			outputText("You can tell that the bindings at your limbs are already slackening, but you're so weak, so exhausted - simply being able to breathe seems like a delicacy that had not been afforded you until just this moment.  You can't leave, just yet.  You just need... to rest... a little...", false);
			//(+ corruption and set lust to 100, slimefeed)
			//GET KNOCKED UP
			//Pregnancy Goes Here
			player.knockUp(PregnancyStore.PREGNANCY_DRIDER_EGGS, PregnancyStore.INCUBATION_DRIDER, 151);
			dynStats("lib", 1, "lus=", 100, "cor", 1);
			player.slimeFeed();
			combat.cleanupAfterCombat();
		}

//*Loss Ride & Impregnate Butt (done)
		private function loseVSDriderAndGetFuckedANDAnalImpreggegity():void
		{
			var x:int = player.cockThatFits(monster.vaginalCapacity());
			spriteSelect(77);
			//Poor males.  All the buttsexes. (yo this is an actual paragraph of the game text right)
			clearOutput();
			if (player.lust >= player.maxLust()) outputText("Unable to resist the desire coursing through your body, you strip off your " + player.armorName + " and start stroking " + player.sMultiCockDesc() + ", displaying it in the hope that it will draw the drider's attention, while at the same time just trying to get yourself off and attain release.", false);
			else {
				outputText("You slump down, too beat up to mount an effective defense, let alone stay up on your " + player.feet() + ".  The drider skitters over to you and effortlessly peels you out of your " + player.armorName + ", exposing your ", false);
				if (player.lust < 50) outputText("soft", false);
				else outputText("hard", false);
				outputText("member", false);
				if (player.cockTotal() > 1) outputText("s", false);
				outputText(" to the air.  She squeezes " + player.oMultiCockDesc() + " in her hand and pumps it, smiling while you stiffen and twitch precipitously in her grasp.", false);
			}
			outputText("  With a strength beyond what her lithe frame would imply, the spider-woman's shiny, exoskeletal arms slip under your shoulders and lift you up, hugging you into both pairs of breasts", false);
			if (monster.nipplesPierced > 0) outputText(", the crossed chains digging into your " + player.chestDesc(), false);
			outputText(".  The warmth of her nodule-covered cock pulsates on your belly, smearing you with a trail of pre-cum while she arranges your entwined bodies.\n\n", false);

			outputText("Lines of webbing burst from the arachnid abdomen, snapping into tree limbs before pulling taut.  The drider's eight legs clitter and clack, four of them folding around your back while your world rotates 90 degrees.  The two of you are pulled into the trees by the sticky strands, hanging sideways, almost upside-down, in the leaves.  The four-eyed monster-girl blinks asynchronously and smiles, shifting you slightly to bring " + player.oMultiCockDesc() + " against her moist lips.  You exhale, an intense, animalistic thrill shivering through you from the feeling of having your " + player.cockDescript(x) + " lodged in a woman's entrance.  She leans down and bites into your neck, releasing a surge of toxin into your bloodstream.  It boils like fire, making you twitch and squirm in her many-limbed clutches.  The pain fades quickly, but in its place it leaves behind a molten, liquid lust, filling " + player.sMultiCockDesc() + " to its absolute maximum size, as hard as it can possibly be.\n\n", false);

			outputText("The " + monster.hairColor + "-haired dominatrix pulls back, a single drop of blood clinging to one of her fangs while she hisses, \"<i>Mmm, fresh meat is always so tasty... not to mention... firm...</i>\"\n\n", false);

			outputText("You look at her with fear, but your " + player.hipDescript() + " start to twitch against her, rubbing your " + player.cockHead(x) + " up and down the slippery slit.  A slow exhale of pleasure escapes the spider's purple lips while her legs squeeze tighter against you, trying to push your " + player.cockDescript(x) + " home.  The drider gasps when at last, you slip between her juicy outer labia, slurping deep into her cunny with a lurid squelch.  Finally held within her depths, your muscles all slacken, save for those you need to pump your hips against her, futilely trying to fuck her hot quim even though you have zero leverage.\n\n", false);

			outputText("\"<i>So eager!  I'm not going to let you fuck me, but I do want your sperm.  After all, I'll need to fertilize some more eggs.</i>\"\n\n", false);

			outputText("Wait, eggs?  While you try to chew over the thought, you're battling with your raging, venom-enhanced libido in order to think about something other than how good her pussy feels.  Fuck it!  You go back to grinding against your mistress, nuzzling at her neck while she twists her spider-half around you, holding you tightly in her chitin and bringing her abdomen up behind you.  A weird, wet appendage rubs over your exposed " + player.buttDescript() + ", slapping at your cheeks until it finds the cleft between them.  Sliding deeper, it bumps into your sphincter, spurts something warm, wet, and sticky against it, then pushes through.", false);
			player.buttChange(8, true, true, false);
			outputText("  You shudder from the anal violation and twist against the legs holding you in place, but with your " + player.cockDescript(x) + " locked inside her, it's a useless endeavor.  It isn't shaped like a dick, and besides, that's currently dripping on your belly.  Oh gods... she mentioned eggs.\n\n", false);

			outputText("The strange organ keeps forcing its way deeper, slipping the steadily-widening, rib-like segments of its bulk into your " + player.assholeDescript() + ".  ", false);
			outputText("  Once it gets deep enough to push on your prostate, an upsurge of pleasure hits you hard enough to make " + player.sMultiCockDesc() + " dribble.  You moan against the drider's neck, pulsing pathetically inside the spider-woman's slit.  You know you'll soon be giving her exactly what she wants - all of it - and there's nothing you can do about it.\n\n", false);

			outputText("Another inch slides inside you, filling you uncomfortably full.  You shiver, clutching at your spidery mistress while she prepares both to deposit and to withdraw from the bank of you.   While you hang there, on the very edge of orgasm, it stops going deeper.  You've been given a reprieve, but it doesn't last long.  The drider kisses your forehead, her venomy lips spiking the sensitivity of your skin once again.  Suddenly, the fat tube in your " + player.assholeDescript() + " is dilating, stretching you wider.  Goo races up it, pumping into your guts, paving the way for the bigger bulk of the coming egg.  It stops at your pucker, battering against your muscles' resistance until it pops inside you, slamming into your prostate so hard that a huge rope of dick-milk erupts into the spider-woman's wet vagina.", false);
			player.buttChange(50, true, true, false);
			outputText("\n\n", false);

			outputText("The egg travels further up your butt, eventually flowing out the end of her stalk-like organ to rest deep in your digestive tract, ensconced in a bubble of slime.  Before you can adjust to this new sensation, another egg slips through your now-widened ring.  It squishes past your anal g-spot, rubbing it just as hard as the first, but before it even finishes traveling up your intestines, a third egg is forced inside you.  " + player.SMultiCockDesc() + " begins to cum wildly, squirting and leaking a torrent of jizz.  The first few ropes blast out with incredible force, hosing down her cunt", false);
			if (player.cockTotal() > 1) outputText(" and belly", false);
			outputText(".  Then, the constant application and release of pressure on your prostate utterly destroys the orgasmic timing of your muscles' contractions, making " + player.sMultiCockDesc() + " release a weak, but constant trickle of cum.\n\n", false);

			outputText("You quickly lose track of how many of the drider's eggs have gone inside you.  Feeling the numerous bulges in your abdomen, you give up entirely.  Your ass is going to be full of eggs and you've probably cum enough for her to make a whole 'nother batch.  Shuddering while the ovipositor is withdrawn, you sag, exhausted, barely realizing that the drider is hosing down your " + player.chestDesc() + " with her arachnid herm-spunk, the nodules ringing her dick pulsing in time with the blasts of thick spooge.  Some sticks to your chin, but you're so drained from your rough treatment that you barely react.\n\n", false);
			outputText("\"<i>Shhh, shhh... it's all right.  You'll be such a good mother for my young, and an even better father for the eggs you just fertilized.  Maybe if we ever meet again you can tell me how they looked when they were born.  For now, rest up.  I want you to take good care of our babies,</i>\" instructs the drider while she lowers herself towards the ground.  She sets you down on a soft spot, giving you a blanket of moss to recover in.  You struggle to stay awake but quickly slump into a deep slumber.", false);
			//(slimefeed)
			player.slimeFeed();
			//GET KNOCKED UP
			player.buttKnockUp(PregnancyStore.PREGNANCY_DRIDER_EGGS, PregnancyStore.INCUBATION_DRIDER - 200, 10); //Butt pregnancy goes faster
			player.orgasm();
			dynStats("lib", 1, "sen", 1, "cor", .5);
			combat.cleanupAfterCombat();
		}

//*Asspreg egg 'birth': (done)
//Summary: what goes up must come down
		public function birthSpiderEggsFromAnusITSBLEEDINGYAYYYYY():void
		{
			spriteSelect(77);
			outputText("\nYour gut rumbles dangerously.  As if by instinct, you drop down and bend over, supporting half your weight on your hands while you lower your " + player.buttDescript() + " to just above ground level.  You grunt suddenly, your pregnant asshole dilating wide as a heavy weight seems to settle atop it, just inside you.  Clenching and tingling, your pucker slowly opens, releasing a torrent of green goop, along with a spherical white egg.  It drops into the messy puddle, cushioned from the fall by the heavy slime still leaking from your slightly agape anus.\n\n", false);
			outputText("The feeling of giving birth in such a way is oddly soothing, almost pleasant.  Your muscles move on their own, slowly and repeatedly clenching, relaxing, and forcing the eggs downward.  The next orb slips through your ring more easily than the first, shooting tingles of pleasure out from your pucker and making you gasp in surprise.  Hot on its heels, another egg follows, catching at your anal ring for a moment before your next contraction squeezes it out into the growing pile of goop.  It feels even better, good enough to make you cross your eyes and exhale contentedly.", false);
			//(buttstretch)
			player.buttChange(40, true, true, false);
			outputText("\n\n", false);

			outputText("You shift position slightly, if only to get more comfortable, and relax as the eggs work their way through your guts.  With each egg's passage, your sphincter seems to be looser, more pliant, and more sensitive.  You blush and squeeze, hurrying the process to make yourself feel even better, and egg after egg splats wetly into the growing pile, each one slick and soaked in slime.  One after another, the heavy orbs exit your body, until the last one is sliding out of your rectum and you're having a strange anal orgasm that feels as relaxing as it is pleasant.\n\n", false);

			outputText("Clenching and relaxing, your slime-dripping asshole slowly narrows, gaping less visibly while you shudder and sigh, so happy and blissful that you don't even care about the crackling egg-shells hatching beneath you.  ", false);
			if (player.hasCock()) outputText(player.SMultiCockDesc() + " stays limp, but drools a heavy flow of semen, puddling up a nice thick batch of your pleasure alongside your goo-pile.  ", false);
			if (player.hasVagina()) {
				outputText("Your pussy clenches and ", false);
				if (player.wetness() < 3) outputText("drips", false);
				else if (player.wetness() < 4) outputText("dribbles", false);
				else if (player.wetness() < 5) outputText("gives a tiny squirt", false);
				else outputText("gushes a river of lady-spunk", false);
				outputText(" into the dirt, getting off along with your " + player.assholeDescript() + ".  ", false);
			}
			outputText("Once you come down from your high, you roll to the side and watch the tiny driders clambering out of their egg shells.\n\n", false);
			outputText("Your newborn children glance at you, chittering happily before they scurry off in the direction of the swamp.\n", false);
			player.orgasm();
		}


		public function driderPregVagBirth():void
		{
			spriteSelect(77);
			outputText("\nYou shudder violently, your stomach growling fiercely at you.  It feels as if something is moving around in your womb, and you bend over on all fours, raising your ass into the air as if it is the most natural thing in the world.  A slimy green fluid starts leaking out of your cunt, making a small puddle on the ground.  The sensation is extremely pleasurable as you feel it running down your thighs.  Groaning, you start to push out a small, smooth green ball, and the action makes your pussy so much wetter.  Groaning, you push out another, and another, each ball rubbing against your inner walls before dropping into the slimy pool of goo.  After the sixth, you orgasm, spraying your cum all over the ground underneath you, each egg squeezing out and prolonging the intense feeling.", false);
			player.cuntChange(40, true, true, false);
			outputText("\n\n", false);

			outputText("After what seems like hours, you have lost count of the eggs pushed out.  ", false);
			if (player.isNaga()) outputText("At last, when no more eggs seem to be coming, you flop over onto your back, careful not to crush any of your dormant offspring.", false);
			else outputText("Looking between your legs you can see another slick, green egg slide from your body to join the sizable pile behind you.  At last, when no more seem to be following it, you flop over onto your back, careful not to crush any of your dormant offspring.", false);
			outputText("  As you lie panting, your revery is interrupted by a small cracking noise.  You sit up with a start and scan the area for someone approaching.  The cracking noise begins to multiply and you realize that it's coming from the pile of eggs nearby.  You begin watching with interest as your eggs start to hatch.\n\n", false);

			outputText("One egg rolls away from about the middle of the pile and you can see the little drider has almost made her way out of it.  With one last push she completely breaks out of the egg and falls face forward onto the ground.  The drider child seems to be having trouble coordinating all eight of her legs at the same time as she repeatedly picks herself up and stumbles a few steps before falling down again.  Looking back to the pile you can see many more of your drider children breaking out.  Soon enough, there are countless little drider girls, all about the size of your palm, skittering around.\n\n", false);

			//(If breasts)
			if (player.biggestTitSize() >= 2) {
				outputText("One drider girl cautiously makes her way over to you.  Her legs tickle your stomach as she climbs up to one of your " + player.breastDescript(0) + ".  Grasping the flesh tightly in her tiny hands she begins to suckle at your " + player.nippleDescript(0) + ".", false);
				if (player.bRows() > 1) outputText("  Following their sister's lead, more little driders take their place at each of your nipples and begin to drink.", false);
				else outputText("  Following her sister's lead, another little drider takes her place at your other nipple and begins to drink.", false);
				if (player.lactationQ() >= 3000) outputText("  One of your offspring seemed to be grasping your breast too tightly and drinking too greedily as suddenly you see one propelled away from you before she lands in a small puddle of milk nearby.  She seems to be struggling to right herself as she writhes around in the milk puddle, and so with a grin you reach over to pluck up the clumsy child and place her back at your waiting teat.", false);
				outputText("\n\n", false);
			}

			outputText("Around you, your many drider children fervently explore their surroundings.  One climbs up your back and perches atop your head.  She raises one hand to her forehead to block the sun's glare and stretches all four of her jewel-like eyes wide, delighting in the wondrous world she surveys.", false);
			if (player.eyeType != EYES_FOUR_SPIDER_EYES) outputText("  Suddenly she flops forward, leaning against your eyebrows and causing you to cross your eyes in an attempt to focus on her.  She seems confused by the way your eyes are different to hers.", false);
			if (player.isNaga()) outputText("  A few baby driders crawl ponderously across your scaled tail.  You give your tail a little wiggle and suddenly they go wild crawling around it and letting out the faintest, cute little squeals.", false);
			else outputText("  A few baby driders sit on each of your legs, facing each other.  Some gesture and squeak at each other in wonder while others pull faces.", false);
			outputText("\n\n", false);

			outputText("Nearby, two more of your little girls are in a stand-off, as each skitters back and forth in front of the other, ready to charge.  Suddenly one leaps forward and grabs the other before attempting to bite her arm.  Of course the attack is completely harmless - they are still much too young to have grown their fangs.  The other then turns the tables on her sister by grappling her sister to the ground, and soon, they're both letting out tiny giggles.\n\n", false);

			outputText("You lie back and your exhaustion finally begins to get the better of you when combined with the contentment from seeing your babies enjoying themselves.  Your eyelids begin to droop, and before you know it, you've slipped into unconsciousness.  You awaken later on, a sticky feeling between your legs to go with your wet pussy", false);
			if (player.hasCock()) outputText(" and raging hard on", false);
			outputText(".  After remembering where you are, the next thing you notice is the absence of your drider children.  Only a pile of empty, broken egg shells and some messy webbing in the trees remain.  As you stand up and prepare to move on, the sun reflecting off something in the corner of your eye catches your attention.\n\n", false);

			outputText("Between two nearby trees is a large spider web.  While not out of the ordinary, when the sunlight hits it at a certain angle the gossamer strands spell out a simple message:  \"<i>THANK YOU MOMMY.</i>\"", false);
			player.orgasm();
		}

//Win Drider Male Anal (OH BABY)
		private function buttFuckADriderOhBaby():void
		{
			var x:int = player.cockThatFits(monster.analCapacity());
			spriteSelect(77);
			clearOutput();
			outputText("As soon as the drider-girl goes down, you leap into action.  Before she has a chance to recover, you run over and leap onto her back, balancing shakily as the drider stumbles back up onto her many legs, trying to shake you off.  You grab onto the drider's hair for support, pulling tight each time you're nearly displaced.  Yelping in agony, she soon learns her lesson and settles down, submitting to your dominance.\n\n", false);

			outputText("Now that she's calmed down, you give her a hard shove, putting her on her drider-belly so you're not nearly thrown off her every other moment.  With that done, you put your hands on her human back, pushing her forward and exposing her human-like bubble-butt, seated just above where woman meets spider. Greedily, you pull her cheeks apart, revealing the tiny star of her puckered asshole.  You pull your " + player.cockDescript(x) + " out of your " + player.armorName + ", already hardening from the thought of you pounding her tight little backdoor.\n\n", false);

			outputText("\"<i>Oh, you want that hole, do you? How very kinky,</i>\" the drider chides, but you aren't fooled by her tone – you can see her anus relaxing, preparing itself for your arrival.  With a grin, you grab your " + player.cockDescript(x) + " and push it against her tight hole, leaning into the penetration until you feel it slip past her sphincter and into her hot, snug passage.  As you slide more and more of your cockmeat into her, you reach up from her cheeks and grope her breasts, squeezing her pert nipples between your fingers as you finally bottom out.  Since you can go no further up her butt, you start to piston your hips forward, slapping your hips to her ass with short, forceful strokes.\n\n", false);

			outputText("You're pleased to see the drider's tongue loll out of her mouth, her eyes rolled up into her head. Clearly she's enjoying this!  Encouraged, you start to fuck her butt harder, hammering into her ass with every bit of force your powerful muscles can summon up.  You're rewarded with a sharp, high moan from the drider.  Once she starts, she doesn't stop.  A symphony of moans, grunts, and pleasured screams erupt from the spider-girl, all in concert with your rough anal ravishing.\n\n", false);

			outputText("Without warning, the drider cums.  She cries out and grabs her fully-engaged corrupted cock, hosing down the trees in front of her with spider-cum as her butt squeezes down on your " + player.cockDescript(x) + ", milking your dick with her anal passage.  You pick up the tempo of your fucking to break-pelvis speeds, ramming your cock into her backdoor and letting loose a torrent of your spunk, shooting it deep inside her", false);
			//(if Vagina: 
			if (player.hasVagina()) {
				outputText(" while your unused cunt spurts girlcum across her carapace", false);
				if (player.cockTotal() > 1) outputText(" and", false);
			}
			else if (player.cockTotal() > 1) outputText(" as", false);
			if (player.cockTotal() > 1) {
				outputText(" your spare cock", false);
				if (player.cockTotal() == 2) outputText(" coats", false);
				else outputText("s coat", false);
				outputText(" her human back with a thick white layer of spooge", false);
			}
			outputText(".\n\n", false);

			outputText("Finally done, you pull out of the drider, collapsing on her spider-back with a contented sigh.  Completely insensate after the anal ravaging you just gave her, the drider poses no threat as you leisurely gather " + player.sMultiCockDesc() + " back into your " + player.armorName + " and lower yourself off her cum-soaked abdomen.  You give her a final, playful ass slap as you dismount before heading back to camp.", false);
			if (silly()) outputText("\n\n(Driders butt-sex is awesome.)", false);
			player.orgasm();
			combat.cleanupAfterCombat();
		}


		private function driderVagSmartFuck():void
		{
			spriteSelect(77);
			clearOutput();
			//Drider Non-reverse Rape
			//Requires a cock that fits and either a spider/drider abdomen or a bundle of tough spider silk
			//Radar (completely correctly) said it was too rapey, so I tried to tone it down.  Let me know if it's still over the top.
			var x:Number = player.cockThatFits(monster.vaginalCapacity());
			if (x < 0) x = player.smallestCockIndex();
			var y:Number = x + 1;

			outputText("You keep your distance from the downed spidermorph, still wary of her dripping, toxin-coated lips despite her weakened state and your own rising desire to breed her.  Trailing your eyes over her sweaty, splayed body you feel a familiar rush below the belt, your hardening [cock " + y + "] pressing against the inside of your [armor] as her breasts rise and fall seductively with each panting breath.  Desire threatens to overpower your caution as your gaze lingers on the vulnerable woman before you, her netherlips ");
			if (monster.HP < 1) outputText("parted slightly and glistening with beads of sweat from the adrenaline of battle.");
			else outputText("stuffed with her fingers, femcum streaming down the front of her spider-half as she desperately plays with herself.");
			outputText("  The need to bury your aching length inside that puffy snatch is almost unbearable, but you don't want to risk exposing yourself to any of her tricks, especially considering how close you'd be to her mouth as you take her.  Racking your brain for a solution, the mass of webbing that covers the canopy around this area catches your eye.");

			if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN) {
				outputText("\n\nA plan quickly forms in your mind and you feel your spinnerets twitch with anticipation as you ");
				if (player.isDrider()) outputText("scuttle");
				else outputText("saunter");
				outputText(" over to the collapsed drider.");
				driderTiedUpPartTwo(false);
			}
			//(Champion has some Tough Spider Silk on them)
			else if (player.hasItem(useables.T_SSILK)) {
				outputText("\n\nRemembering the bundle of silk that you have with you, it doesn't take long to come up with a very enticing idea for dealing with the drider.  However, you have a feeling that you won't be able to do much else with the silk if you go through with your plan.  Are you sure you want to use it on her?");
				//[Yes] [No]
				doYesNo(createCallBackFunction(driderTiedUpPartTwo,true), dontSilkRapeDrider);
			}
		}

//[No] 
		private function dontSilkRapeDrider():void
		{
			spriteSelect(77);
			clearOutput();
			outputText("Deciding against wasting the valuable material for little more than a quick fuck, you ponder your other options for using the defeated girl.");
			//(Return to "win" menu)
			doNext(defeatDriderIntro);
		}

		private function driderTiedUpPartTwo(useItem:Boolean):void
		{
			spriteSelect(77);
			var x:Number = player.cockThatFits(monster.vaginalCapacity());
			if (x < 0) x = player.smallestCockIndex();
			var y:Number = x + 1;
			if (useItem) {
				clearOutput();
				player.consumeItem(useables.T_SSILK);
				outputText("Smirking to yourself, you advance on the collapsed girl, [cock " + y + "] straining against your clothing in anticipation of what's to come.");
			}
			outputText("\n\nDarting forwards suddenly, you seize her wrists, pulling her arms above her head");
			if (monster.lust >= monster.eMaxLust()) outputText(" and away from her quivering snatch");
			outputText(", her struggles useless against your steely grip.  The defeated drider's eyes darken as she looks up at you, but before she can protest you roughly flip her onto her back, splashing both of you with dank water as she flails about in the shallow muck around your feet.  Spindly legs flail feebly as you grasp both of her wrists in one hand, sliding the other down her arm until it grazes softly across her first row of breasts.  You gently squeeze the supple flesh, fingers rolling a pert nipple as it slides between them and eliciting a surprised, pleasure-laden gasp from the spider-taur.  Your member twitches as you play with her, reminding you that you've still got to deal with the woman before you can have any real fun.  Reluctantly you remove your hand from her chest, catching what sounded like a soft sigh from the drider's mouth as you start to circle around her.");

			outputText("\n\nMoving behind her back, you lift up her human half until you can firmly pin her arms together behind her back.  She writhes as you ");
			if (!useItem) outputText("awkwardly try to position yourself so that you can web her arms, eventually deciding that it would be easier to simply use your hands and tie her yourself.  You squirt out a few strands of strong, sticky thread and deftly wrap her forearms together, pinning them about halfway up her back.  As you bind her, you make sure to wrap up her hands as well, until you're confident that she won't be able to slice her way out with her uncomfortably sharp nails... at least, not until after you've finished with her.");
			else outputText("reach into your pack, pulling out the sizeable mass of silky strands.  As soon as she feels the first sticky thread wrapping around her arm she squeaks and tries to recoil, though her current position means that she can do little more than rock slightly from side to side.  In no time at all her arms are covered from elbow to fingertip by the tough silk and, judging by her ineffective struggles, it looks like it's going to take her a while to break out; to your surprise, you still have some silk left over, which you quickly pocket.");
			outputText("  Releasing her now-bound form, you chuckle deeply as she falls back into your chest, body wriggling furiously in her attempts to free herself from the tight bindings and covering both of you with even more dark water.  You pull her into your lap as you drop into the shallow water around you, reveling in the feeling of the cool water surrounding you in comparison to the warm, heavy air.");

			outputText("\n\nSeizing your advantage, you slide your hands around her chest, eagerly grasping for her now-dripping breasts.  She tries to bite back a moan as your fingers latch onto her sensitive orbs, all four nipples standing erect in the humid air.  Your hands dart over her chest, squeezing and pinching, trying relentlessly to stimulate all four of her tits at once.  All the seductive spider-taur can do in response is writhe under your assault, pleasured whimpers breaking past her lips as you knead her soft, smooth skin and groaning loudly whenever you twist one of her pert little nubs.  You lean over her human half even more, burying your face into her neck and sucking on the sweet flesh you find there.  She cries out as you nip at her throat, breaking the constant stream of moans that pour from her mouth.");

			outputText("\n\nHer firm behind continually bumps against your throbbing shaft as she struggles against your attentions, rapidly bringing you to full hardness and making you wince as you press against the inside of your [armor].  You can feel a damp patch spreading against your tip, a result of the pre-cum being forced out of you with every grinding movement the drider makes against your crotch.  Unable to resist, you quickly drag one hand down her body, streaking a path through the mixture of sweat and swamp-water still clinging to her toned muscles, until finally driving it between your bodies to free your aching member.  You nearly gasp as it springs free, wetly slapping against her taut rear and driving her to another fit of panic as she squirms away from your thick meat, apparently terrified that you're going to stuff her tight ass.");

			outputText("\n\nThe thought is definitely enticing, causing your [cock " + y + "] to twitch as you thrust it against the girl's back, smearing pre-cum on her already-slick skin.  However, you've already got a plan in mind and you feel that it's about time that you finish teasing the poor thing and finally put it into action.  Taking one last luxury you slide your free hand around her hip, suckling her neck as your searching fingers spread across her lower stomach.");

			outputText("\n\nShe inhales sharply as you find your target, fingertips brushing against her throbbing, erect clit.  You trail your hand down her slit, feeling how wet and ready she's getting for you.  You dip two fingers into her, sliding them past her puffy lips with ease, drawing out a flurry of uncontrolled cries as you wiggle them against her sensitive walls.  As you tease the woman, you realize that her arms have stopped struggling against their bonds, apparently she's putting all her effort into not crying out at your assault on her engorged sex.");

			outputText("\n\n<i>\"Looks like you want this as much as I do,\"</i> you whisper into her ear, your thumb circling around her hard little clit as you slowly pump your fingers into her, \"<i>[if (corruption >= 60) \"but I guess that's just because you're such a useless slut who's not good for anything else, right?\"] [if (corruption <= 60) \"looks like you're just too easy to get all worked up.  I suppose I'll have to make up for all that teasing, won't I?\"]</i>\"  She can only moan and twist her head away from your lips as you drag your tongue over her earlobe, pinching and pulling on her nipples while your hips slowly thrust against her back, smearing pre-cum over both of you.  She whimpers as you tease and deny her clit, leaving you chuckling at the sight of such a previously dangerous creature reduced to this much of a desperate, moaning mess, just dying for you to spread her open and fill her squirming cunt with cum.  Her pussy is streaming juices now, coating your hand and running down her body, pooling slightly at the spot where her human and spider halves meet.  No matter how much she struggles against you, it's clear that she is enjoying the treatment you're giving her, the shuddering moan rolling out of her mouth as you resume suckling on her exposed collarbone doing little to contradict you.");

			outputText("\n\nAll right, enough's enough.  She's more than ready for you, and you don't even know if her drooling, toxin-coated lips will be any kind of threat at this point.  Considering that she's currently biting down on her lower one to try and deny you the satisfaction of her moans, maybe she's too aroused by your constant attentions to even consider trying to turn the tables.  Then again, if this land has taught you anything, it's that it is far better to be safe than sorry.  ");
			if (!useItem) outputText("Shifting yourself, you withdraw your hand from her quivering slit, reaching back to collect another handful of stretchy silk.");
			else outputText("Reaching back into your pack, you grab the remainder of the bundle of silk that you tied the girl's hands with.  Looking over the mass of white-grey strands, you smile as you see that there seems to be more than enough left for what you have in mind.");

			//New Page
			doNext(driderTiedUpPartThree);
		}

		private function driderTiedUpPartThree():void
		{
			spriteSelect(77);
			var x:Number = player.cockThatFits(monster.vaginalCapacity());
			if (x < 0) x = player.smallestCockIndex();
			var y:Number = x + 1;
			clearOutput();
			outputText("The drider seems to be completely oblivious, apparently too focused on ignoring your hand still roaming over her chest to realize your intentions.  You start to prepare the ball of silk with one hand, keeping the other on her chest to distract her from your actions.  You notice that the silk is starting to glisten slightly as the juices on your hand begin to stain the material and the sight gives you a devious idea.  Wrapping the strands around your hand, you dip it down in between your bodies, trying to absorb as much pre-cum as possible.  You run it over your slick stomach, as well as the small of the spider-taur's back, making her squeak slightly at the strange, wet sensation.  As you brush the dampening sheet over your still-leaking length, you have to choke back a moan as the soft, slick, sticky silk sticks slightly to your [cock " + y + "].");

			outputText("\n\nYou grunt as you pull the material off, a few strands clinging stubbornly to your head as you withdraw it from between your sweat-slicked bodies.  It crosses your mind that the grasping, wet cloth could make a great toy for playing with when you're all alone, but you dismiss the idea for now, reasoning that you've got a perfectly good slut here to play with and you might as well make the most of her.  The silk is now sodden, slowly dripping with the excess seed that you've collected in it.  Deciding that it's now or never, you remove your hand from the drider's breasts, pulling the wet material taut between your hands, forming a wide strip of tough silk.  Before she can react to the sudden loss of sensation, you strike, throwing your hands over her head and wrapping the cum-soaked material around her drooling mouth.  She thrashes as you pull it tight and tie it off, but her weakened body is no match for your own lust-fueled frame, especially with her arms already out of the way.");

			outputText("\n\nOnce you are sure the gag is secure you jump to your feet abruptly, leaving the drider to splash back into the shallow water of the swamp floor, her hair and chest becoming drenched once again as water cascades over her struggling form.  You loom over the trapped girl, your cock twitching in the air as your eyes drink in her completely exposed form, the sight compelling you to start removing your armor as quickly as possible.  She seems to be having trouble with her new facial wear; you can see her mouth moving through the wet material and it looks as if she is trying to keep the silk away from her lips by pushing at it with her tongue.  It looks as though she isn't a big fan of the taste that you \"infused\" it with and she starts to whip her head left and right, trying to wash the silk in the water that she's lying in.");

			outputText("\n\nYou finally free yourself of your [armor], releasing your body from its stuffy confines and throwing the damp clothing to a relatively dry patch of land nearby.  By the time you turn back to face the drider she has recovered from her surprise bath and her eyes stare at your nude form, each one widening with a mixture of apprehension and desire.  You start to advance on her, shaft bouncing with each step, a giddy smile plastered on your face.  However, as soon as you get in range she suddenly lashes out, trying to grab you with her myriad of spider-legs in a final attempt to be the one taking charge.");

			outputText("\n\nHer hard, spindly limbs grasp and sweep at you, hoping to take advantage of your unarmored, overly aroused state to get a good hold of you while she frees herself.  Luckily, she's still exhausted from the fight, not to mention how flushed her skin is with all the lust coursing through her, leaving her attempts weak and ineffectual at best.  You force your way through her flurry of legs, knocking aside or simply ignoring any attacks that are actually aimed at you.  Her attacks seem to get more and more unfocused the closer you get to her, her eyes more fixated on your hard shaft than where she's aiming.  Pre-cum has started rolling down her neck from the gag, only making you throb as you loom over the girl, who seems by now to be completely mesmerized by your meat.  You roughly sit down, just below the join of her human and spider bodies, her legs too weak at this point to even try and clutch at you.  You smile to yourself, tracing a finger from the top of her cleavage down to her belly button.");

			outputText("\n\nIt was a nice try, you tell her as your digit lazily slips its way between her slick tits, but you'll be the one calling the shots this time around.  She makes a show of looking furious, though it quickly breaks as her eyes drop away from your face, dragged back down your body to the shaft resting against her stomach.");

			outputText("\n\nLeaning over her writhing, taut human half, you grab her shoulders and pin her into the soft, wet ground, putting a little weight on her to stop her from struggling any more.  Your new position leaves your [cock " + y + "] hanging just next to her slick entrance, almost perfectly lined up and just begging for you to enter her.  Her eyes dart away from your gaze as you stare at her face, the feeling of being so in control making you leak pre all over her waiting lips, staining her crotch with drizzles of white.  You dart in to her collarbone again, avoiding her neck which is now covered in the pre-cum that drips from her gag.  Kissing and sucking at the soft skin, you slowly trail your mouth down, leaving a sticky trail of saliva as you zero in on her hard nipples.");

			outputText("\n\nYour tongue draws little circles around the sensitive nub, the whimpers of the girl barely audible through her semen-soaked muffler.  Despite the mix of sweat and swamp water that has left a thin sheen on her flesh, the drider still tastes sweet as your tongue flicks over her pert tip and your mouth curls into a smile as you realize that you have four of these sweet orbs to choose from.  The way her body still tries to writhe under your grip, mixed with the little grunts of pleasure she makes whenever you drag your tongue over her breast, leave your cock aching and you panting, overcome with a desperate need to plunge it into the helpless spider-taur.");

			outputText("\n\nUnable to hold back any longer you bite down on her sensitive nip, making her cry out at the sudden pain.  As she tries uselessly to buck against you, you roughly thrust inside her and slip into her glistening lips with almost no effort, quickly burying yourself entirely in sweet, wet spider-pussy.  Her cry intensifies into a muffled scream as your length fills her up, her back arching as your hips slam together with a wet slap, signaling that you've hilted yourself inside her.  You find her tight slit almost too much to take after so much build-up and need to take a few moments to adjust to her incredible tightness, groaning into her chest as her entrance spasms around you after the sudden intrusion.  Pulling your head away from her, you examine her trembling body as her scream slowly dies down, devolving into a series of choking gasps and panting moans while you struggle to contain yourself.");

			outputText("\n\nYou manage to calm yourself after a few seconds of relative stillness, though the drider still squirms under your grip, her writhing somewhat weakened after your impalement of her needy body.  Her cunt carries on leaking despite how stuffed it is, smearing your crotch with a ridiculous amount of fem-spunk.  You start to pull out of the girl, dragging your shaft out as slowly as you can bear, giving yourself as much contact as you can against her quivering walls.  She gasps as you near the end of your backstroke, only your tip remaining clutched in her hot, wet snatch.");

			outputText("\n\nYou hang there for a few moments, giving the woman time to recover.  Still panting for breath, she cranes her neck and looks down between your bodies, her brow furrowing as if confused at your lack of movement.  You wince at the feeling of your tip being squeezed as her entrance twitches around you, drawing out even more pre-cum from your [cock " + y + "] to slather her already-sodden passage.  Grunting at the sensation, you realize that you're not going to last much longer if you keep teasing yourself like this.  Sliding your hands away from her shoulders, you bring them back to the woman's chest, groping and pinching at the sensitive skin, drawing a whine from her as she writhes under you.");

			outputText("\n\nWaiting for the perfect moment, you have to clench your teeth to stop yourself from driving forwards into her and engulfing your member in her warmth once more.  She wriggles under your ministrations, her slit grinding around the end of your member and leaving you panting with the effort of holding yourself back.  Finally, you spy your moment, just as her back arches and she presses her tits against your hands, squashing them against your fingers.  You plunge forwards, hips slamming into her with so much pent-up want that you feel your control slip away.  She squeals again as you fill her, though you can already hear the pleasure creeping in at the edge of her voice despite the gag.  Your bodies smack together harder and harder each time,[if (hasBalls = true)  your [sack] slapping into her at the point where chitin meets flesh,] spattering your mixed fluids everywhere with each body-shaking impact.");

			outputText("\n\nYour hands keep roaming over her chest, pinching and twisting as they go.  Each time you tease the girl's pliable skin, her cunt tightens around you, gripping your slick shaft ridiculously hard while you force your way into her again and again.  One hand snakes down across her toned stomach, eagerly seeking out her clit once more.  Her lower stomach is completely soaked with arousal, the force of your rutting painting you both quite liberally with your combined efforts, each time your hips meet sending up another spray of pleasure between your bodies.  Finally reaching the top of her slit, you waste no time in finding her throbbing little button with your searching digits, quickly starting to roll the nub between your fingertips.  The drider's reaction is immediate, her body tensing as you fuck her into the wet ground, [cock " + y + "] driving in and out of her gripping, spasming tunnel.  She cries out again, trying to twist away from you but you keep her in check by pinching a nipple roughly as she squirms, leaving her arching her back in an effort to press herself against you.");

			outputText("\n\nThe hand rubbing her fun-buzzer never relents, rubbing, squeezing and pinching in an effort to drive her completely over the edge, needing to feel her slick passage orgasming around your shaft, her voice keening as she sprays you with femcum.  She tries to fight it as long as she can, groaning and writhing against you in an attempt to stave off her building pleasure, but your overwhelming assault on her body is ultimately too much for her to take.");

			outputText("\n\nShe finally climaxes, her body shuddering and undulating against yours as you continue to stuff her quivering hole, her constantly contracting grip utter bliss on your aching shaft.  Her head rears back as she screams, neck stretching to show just how cum-stained it has become since you gagged her, the same gag that is now surely filling her open mouth full of your seed.  Your hands never cease their teasing, squeezing her tits and rapidly polishing her button as you thrust into her sensitive walls, drawing out her orgasm by long seconds and spraying you crotch with girlcum as her pussy unleashes itself on you.");

			outputText("\n\nYou moan as she writhes beneath you, her passage gripping and touching you in ways you never thought possible whilst she breathlessly whines at your aggressive over-stimulation, each brush against her clit quickening your thrusts as her insides grow ever wetter.  Her voice fails her long before she stops convulsing, body still wracked with bolts of pleasure as you hump into her unceasingly, drawing out pleasure-filled grunts as you push into her pleasure-wracked walls again and again, her tired body twitching as it lies in the mire beneath you, unable to do much more than pant and groan after her impossibly long orgasm.");

			outputText("\n\nDriven on by the sight of the thoroughly defeated girl, you move your hands to grip her sides and start pistoning your bodies together.  She can only moan pathetically while you use her, the way your length presses against her sensitive insides all too much for her exhausted frame.  Hammering into her, you dart a thumb across to sweep over her throbbing clit, bringing about a particularly loud cry of pleasure that makes your [cock " + y + "] jump delightfully even as she clenches especially tightly around you.  You feel yourself getting close, the mixture of such a tight, wet cunt and your unbelieveable arousal leaving you smacking into her pelvis with a single goal in mind: filling her with your potent seed.");

			outputText("\n\nYou pant in time with her, watching as her throat reflexively swallows the spunk filling her mouth from the gag, too tired to put up any fight anymore.  Seeing her similarly cum-coated throat bulge as she takes your sperm is the last push you need, the sight of her finally accepting her part in this relationship bringing you right to the edge, leaving you teetering on the point of letting yourself go.  As you feel your body starting to shiver you speed up, roughly ramming the insensate girl, trying to get as deep as possible before you release into her.  Her raspy moans get louder with every thrust, pausing every so often to allow another glob of spunk to slide down her throat while you lean yourself further down, pressing against her body.");

			outputText("\n\nYou feel your cock starting to contract and pull the drider tight against you, fingers digging into the soft flesh of her hips as you press her as closely to you as you can manage.  Fully hilted within her, the entire length of your [cock " + y + "] is squeezed and teased by her still-spasming cunt all at once.  The heat is incredible, enhanced by the sheer amount of wet, warm fluid gushing down both of your hips, leaving you crying out as you finally start to cum.  Your body is wracked with unbelievable pleasure whilst your member explodes inside her, painting her insides white with fertile cream.  She barely realizes what's going on at this point, completely zoned out after her own mind-numbing orgasm, only able to softly grunt at each steaming load that you fire into her.  You take the opportunity to sink your teeth into her collar, marking her as [if (corruption < 40) yours][if (corruption >= 40) your slut] at the same time as your seed marks her pussy as your property, moaning deeply the entire time.");

			outputText("\n\nFinally finished, you collapse on top of the similarly exhausted woman, barely capable of moving after such a breathtaking end.  Your shaft still twinges after such a powerful climax, not helped by the way her pussy continually shudders around you.  The drider, smothered underneath you, begins to sink slowly into the soft ground of the swamp, still completely oblivious to anything going on around her.  Deciding it would be a terrible shame if your new cumdump were to be lost so soon after acquiring it, you heave yourself onto unsteady legs, cock drizzling as you withdraw yourself from the abused, sperm-stuffed cunt that surrounded it.");
			player.orgasm();
			dynStats("sen", -1);
			doNext(driderTiedUpPartFour);
		}

		private function driderTiedUpPartFour():void
		{
			spriteSelect(77);
			var x:Number = player.cockThatFits(monster.vaginalCapacity());
			if (x < 0) x = player.smallestCockIndex();
			var y:Number = x + 1;
			clearOutput();
			outputText("Grabbing the drider by her shoulders, you find the girl surprisingly light despite your weakened state.  Swiftly dragging her through the shallow water to a patch of firmer ground, you prop her up against a web-covered tree before recovering your gear.  She mumbles slightly whilst you redress yourself; it looks like she's going to be out of it for a while.  ");
			//[if (corruption >= 70)
			if (player.cor >= 70) {
				outputText("You chuckle to yourself at the thought of her waking up, still bound and gagged in her own swamp, packed with your cream.  You use her hair to clean the filth still clinging to your cock, but after smearing the collected juices into her soft, wet locks you only find yourself irritatingly, achingly hard once more.  Looking at her still-oozing cunt, you decide against filling her up a second time; it'd just make even more mess anyway.  You idly stroke yourself whilst deciding what to do, until the sight of her throat bulging as she swallows down another mouthful from the sodden gag strikes you with an idea.");
				outputText("\n\nRoughly tearing away the silk from her face, you grab her hair and ram her mouth down your shaft, grunting with delight as you force your way into her already cum-slicked throat.  Her eyes shoot open as you facefuck her, smearing her mouth with her own juices whilst you drag her lips down your member at a blinding pace, the desire to finish yourself off the only thing running through your mind.  She gags slightly as your tip slams into the back of her throat, her tongue wildly working against your length as she tries to cope with the oral invasion, slathering it with saliva and only making each stroke that much easier.  Too weak to even pull at her bonds, she can only try as best she can to get you off quickly, her tongue darting under your tip even as she sucks for all she's worth.  You groan as she services you, the warmth and wetness almost as good as her pussy was, not to mention how your shaft jumps as her tongue constantly darts up and down your length.  Each time you hilt in her, her nose bumps against you, the lewd noise of her sloppy sucking echoing through the swamp.  Her chin runs with semen-laden drool, mouth too focused on pleasing you to even attempt to hold it all in.");

				outputText("\n\nWith every thrust her lips are pressed firmly against your crotch, [if (hasBalls = true) [sack]|groin] smacking into her soaked chin with a wet slap, spraying seed and spit with such force that it splatters across her chest and neck.  The combination of her efforts and your own post-orgasmic sensitivity rapidly brings you to your second peak, her head almost a blur on your rod as you feel your control slipping.  Moaning happily you hilt yourself in her, driving her face into you just before your [cock " + y + "] throbs, releasing a surprisingly large load that coats the inside of her mouth a thick white.  She moans as your spunk shoots into her, attempting to swallow as much of it as she can, though most dribbles out between your girth and her mouth and cascades down onto the rest of her body in thick globules.  Sighing, you draw her off your shrinking member, making sure as her lips slide down you that they leave you completely clean of any evidence of your climax.  Satisfied, you release her head, which immediately slumps down and begins snoring gently, still drooling cum onto her chest.  As you start to check her for anything valuable, you wonder if something else will happen across her before she can get free.  In such a vulnerable state, she'll probably wind up thoroughly used if anything does finds her.  Pocketing your new riches, you realize as you walk away that the slut would probably enjoy it anyway.");
			}
			//(if (30 =< corruption < 70)
			else if (player.cor > 30) {
				outputText("You decide to check on your new lover, subtly searching her for anything useful at the same time.  You slice away the bindings on her arms as you check her, ensuring she isn't keeping anything hidden anything behind her back.  She stirs slightly as your hands roam across her, eyes fluttering drunkenly as she tries to focus on you.  Her hands slowly move to yours, taking hold of them gently and pressing them against her taut belly.  Your brow furrows in confusion for a second, before a flash of understanding rushes through your head; she seems to think that she's pregnant!  Then again, considering how pent up you were before you flooded her, maybe she's not far wrong.");

				outputText("\n\nYou rub her stomach slightly, watching as the apparent mother-to-be closes her eyes, resting her head against the tree as she coos softly at your touch.  Before long you're ready to head back to camp, but not until you've severed the bonds of the slumbering girl, though you're not sure whether it was out of pity or simply because of the chance that she's carrying your progeny.");
			}
			else {
				outputText("You make sure she's comfortable before checking her for anything that could help your quest.  She stirs slightly as your hands caress her, eyes fluttering drunkenly as she tries to focus on you.  Something in the way her eyes bore into you fills you with a sense of shame at having taken advantage of her and you quickly sever her bonds, reasoning that she'll still be too weak to try anything.");
				outputText("\n\nHer newly freed hands slowly move to yours, taking hold of them gently and pressing them against her taut belly.  Your brow furrows in confusion for a second, before a flash of understanding rushes through your head; she seems to think that she's pregnant!  Then again, considering how pent up you were before you finally flooded her, maybe she's not far wrong.  Though a little taken aback by the realization, you start to rub her stomach softly, watching as the apparent mother-to-be closes her eyes and rests her head against the tree, cooing happily at your touch.  You stay with her for a while, until she falls asleep again and reluctantly ready yourself to head back to camp, smiling softly at her contented expression.");
			}

			//Plus gems and such
			combat.cleanupAfterCombat();
		}
	}
}
