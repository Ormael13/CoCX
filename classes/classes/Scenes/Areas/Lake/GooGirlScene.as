/**
 * Created by aimozg on 04.01.14.
 */
package classes.Scenes.Areas.Lake
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class GooGirlScene extends AbstractLakeContent
	{
		public function GooGirlScene()
		{
		}

//VARS
//const GOOGIRL_BIRTHS:int = 384;
//const GOOGIRL_CONSECUTIVE_LOSSES:int = 385;

		private function gooGirl():GooGirl
		{
			var g:GooGirl = monster as GooGirl;
			if (g == null) {
				trace(monster.short+", not GooGirl!");
				CoC_Settings.error(monster.short+", not GooGirl!");
				g = new GooGirl();
			}
			return g;
		}
//goo-girl encounter- 

//[Lake]
		public function encounterGooGirl():void
		{
			clearOutput();
			spriteSelect(69);
			outputText("As you walk around the lake, you notice a pale red light pulsing in the ", false);
			if (!flags[kFLAGS.FACTORY_SHUTDOWN] == 2) outputText("sapphire ", false);
			else outputText("murky ", false);
			outputText("waters. You pause, trying to figure out what the shape might be. Just under the surface of the water, there appears to be a fist-sized heart shedding a crimson glow. Leaning closer, you gaze down into your reflection only to find your face rising up with pursed lips, trying to kiss you! You jerk backwards and the pseudo-head quivers, resolving its face into a gooey-looking girl, her ", false);
			startCombat(new GooGirl());
			outputText(gooColor() + " slime body sculpting itself into a humanoid shape. The girl curiously tilts her head to one side, as if trying to figure out why you're backing away, before she happily surges forward!", false);
			if (flags[kFLAGS.CODEX_ENTRY_GOOGIRLS] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_GOOGIRLS] = 1;
				outputText("\n\n<b>New codex entry unlocked: Goo Girls!</b>")
			}
			doNext(playerMenu);
		}

//New Perk – Slime Core (requires goo player, random drop rate?)
		private function coreDropChance():void
		{
			if (rand(4) == 0 && player.findStatusEffect(StatusEffects.SlimeCraving) >= 0 && player.findPerk(PerkLib.SlimeCore) < 0 && player.isGoo() && player.gooScore() >= 4) {
				outputText("\n\nAs the goo-girl slithers away, into the lake's placid waves, you notice she seems to have left behind a small blob. Upon investigation, it appears to be a tiny, ruby heart, encased in a slimy " + gooColor8() + " membrane. As you reach to pick it up, the jelly ball quivers and pulses with a warm, cheerful light. Your fingers close on it and the nucleus slides through your palm, into your body!\n\n", false);

				outputText("There is a momentary pressure in your chest and a few memories that are not your own flicker before your eyes. The dizzying sight passes and the slime core settles within your body, imprinted with your personality and experiences. There is a comforting calmness from your new nucleus and you feel as though, with your new memories, you will be better able to manage your body's fluid requirements.\n\n", false);
				//(Reduces Fluid Addiction to a 24 hour intake requirement).
				outputText("(<b>Gained New Perk: Slime Core - Moisture craving builds at a greatly reduced rate.</b>)", false);
				player.createPerk(PerkLib.SlimeCore, 0, 0, 0, 0);
			}
		}

		private function gooColor():String { return gooGirl().gooColor(); }
		private function gooColor2():String { return gooGirl().gooColor2(); }
		private function gooColor3():String { return gooGirl().gooColor3(); }
		private function gooColor4():String { return gooGirl().gooColor4(); }
		private function gooColor5():String { return gooGirl().gooColor5(); }
		private function gooColor6():String { return gooGirl().gooColor6(); }
		private function gooColor7():String { return gooGirl().gooColor7(); }
		private function gooColor8():String { return gooGirl().gooColor8(); }
		private function gooColor9():String { return gooGirl().gooColor9(); }
		private function gooColor10():String { return gooGirl().gooColor10(); }
		private function gooColor11():String { return gooGirl().gooColor11(); }

//goo-girl Bad End – If the player loses to 3-5 goo encounters while under full goo Transformation
		private function gooGirlBadEnd():void
		{
			clearOutput();
			outputText("You collapse, your strength gone, body open to the investigation of the goo-girl.  Her expression, however, has become one of excitement and focus rather than playful curiosity.  With exaggerated gestures, the " + gooColor() + " girl tilts her head left and right, shakes her shoulders, and wraps her fingers together, as if cracking her knuckles. Rubbing the dripping palms of her hands together, she draws backward before leaping at you. Instead of the slimy, semi-solid splash you were expecting, the girl sinks INTO your body, her muck penetrating your membrane and filling you in a way you've never felt before. Her crimson nucleus flashing rapidly within you, every inch of your body quivers and bulges under the pressure of her added mass.\n\n", false);

			outputText("The invading nucleus swells and twitches, sending waves of ecstasy through your mind before erupting in an orgasm of memories. Your vision is filled with decades of life in an instant, every moment in the goo-girl's existence adding itself to your own. Gradually, they become your experiences as well, perfectly crystal clear memories blossoming in your mind. Engulfing solid creatures to learn their shapes, milking proteins from the lake's inhabitants and visitors, mimicking humanoid behaviors to better understand them. The girl's life- your life- flashes in brilliant hues of heat and motion, your body climaxing helplessly at the mental overload until, after what seems like a lifetime, the goo-girl slides out of you with an expression of blissful satisfaction on her face.\n\n", false);

			outputText("Panting, trying to come to terms with your new memories, you notice that the girl's nucleus appears to be half a heart, neatly bisected down the middle. You look at yourself and find the other half floating inside your chest, shedding its soft, scarlet light in time to your gasping breath. The half-hearted girl smiles mischievously and winks at you. A sudden wash of heat erupts from her " + gooColor2() + " body and it's all you can do to avert your face from the blaze of magma she's made of herself. The meaning of the girl's warmth is immediately apparent- all across the surface of the lake, dozens of cute, curious heads poke above the water, gel-like faces locking onto the intense signal of your companion. Sliding swiftly, the other girls rush toward you, their faces positively brimming with an expression that almost seems like lustful hunger.\n\n", false);

			outputText("Your body feels leaden and overburdened, making escape impossible. When the girls reach you, they dive into your now-permeable membrane, one by one at first, then two and three at a time. You grow and swell as they fill you, cascades of memories and thoughts suffocating you like the torrent of a waterfall. Your bloated, expanding body responds to the psychic barrage in the only way it can- releasing an orgasm of gushing fluids from your body in lustful spree, showering the girls milling about you in protein-rich, gooey milk and cum, feeding their bodies even as they force-feed your mind. Hundreds of years unpack themselves within you, tiny heart buds floating inside of your chest, gradually merging into one, vibrant crimson orb.", false);
			//[Next]
			doNext(gooGirlBadEnd2);
		}

		private function gooGirlBadEnd2():void
		{
			clearOutput();
			outputText("<b>One Year Later...</b>\n", false);
			outputText("Two of your sisters swim toward you with a solid woman in their arms. Good girls, you think, emitting heat to thank them for their dutiful service. The largest of them smiles happily at the compliment while the purplish girl vibrates with fierce pride in serving her queen.  You quiver in delight at the title, the memory of your coronation still as bright in your memory as the day it was thrust upon you. Stroking your breast with a goopy hand, you take a moment to admire the colossal heart your nucleuses have fused into, easily as large as the woman being brought before you to receive your blessing.\n\n", false);

			outputText("The woman is dressed in full plate mail and has her pale tresses done up in a sensible bun, her five-foot frame well-toned from long nights of swordplay and discipline. Perhaps she is the new champion, you idly muse, the image of your home conjured from the depths of your core. The girl struggles weakly and you pull a comforting gesture from your past. Placing one, massive finger against your lips, you reach a hand down to stroke the champion's head delicately, her body little larger than a doll next to you. Shifting the slimy girth of your gigantic body aside, you draw her into a wet embrace, hugging her to your breast, your core 'beating' in time with her heart until panic and fear fades, desire quickening her pulse.\n\n", false);

			outputText("Gripping her in your gentle hands, you lower the girl to the junction of your groin.  ", false);
			if (player.hasCock()) outputText("A pseudopod extends from your crotch, a gooey penis the size of a minotaur. It snakes through the air toward the girl, its tip flaring to expose a wide, urethra-like opening.  ", false);
			else outputText("Head-first, you slowly insert the girl into your body, soft, slimy folds enveloping her and drawing the solid flesh deeper into you. She struggles, hands beating at your yielding membrane pleasurably before her shoulders and arms slide into you as well and are pinned at her sides. She kicks her legs, reflexively, but those too are sucked in as she is utterly swallowed by your translucent organ.\n\n", false);

			outputText("You shiver in orgasmic jubilation at the feeling of a solid creature inside your quivering womb, every twitch sending renewed pleasure through your tremendous form, exciting your heart to excrete a seething, purple jelly. The blob of violet rolls within you, getting its bearings before it surrounds the slime-entombed girl. As your muck caresses her lips and breasts, the girl's hair becomes goopy, merging into a clump of coifed slime atop her head. When the sloshing goo slides around her armor and slips into her inflamed pussy, she wriggles in slimy orgasm, her legs pulled apart by the thrusting, mindless imperative of the royal jelly. Gradually, her legs soften and melt into a shapeless blob, her toned muscles gushing into pulsing masses. She climaxes within you again and again as her flesh becomes gooey and her equipment slides off of her now slimy body.\n\n", false);

			outputText("You slide your nucleus down to the champion and she wraps her " + gooColor3() + " arms around it, kissing the heat of your core. Your gargantuan form ripples in shivering glee as a small piece of your heart splits off, sliding between your new daughter's lips, resting firmly between her gooey tits in a tiny, crimson ruby. Climaxing from the birth of a new goo-girl, your body convulses and clenches, squeezing the former champion back into the lake with a gushing, " + gooColor2() + " splash. Your daughter bows her head in reverence and embraces her sisters happily. The largest girl, a former minotaur, gives her a bear hug that nearly splits the smaller slime in two. The purple girl, who used to be a succubus before you showed her the error of her polluting ways, is more reserved, merely nodding and smiling. All the same, they stroke each other fondly, enjoying each other's rippling bodies.\n\n", false);

			outputText("Radiating heat and vibrating the water between the four of you, you communicate your will to the girls. Hundreds of your sisters have already expanded the lake's shores to the mountains and others have nearly reached the forest. Deep in your memory, however, there remains a city in the desert filled with your friends. It seems like such a long time since you've seen them. Once your children flood the desert, you'll be able to pay a visit and show them what you've become. Maybe they'll even want to be reborn themselves. Yes, you decide, they will definitely want to join you.", false);
			getGame().gameOver();
		}

		public function slimeBadEnd():void { //Another gooey bad end; you should have drunk more fluids
			outputText("\nYour entire body wobbles as your strength fails, collapsing into itself.  You struggle to rise, but your form loses more and more rigidity, melting into an amorphous blob.  Without the strength to rise, you've no hope of getting the fluids you need.  The aching craving for moisture drives you to roll to the lake, which you slip into.  With the constant runoff of bodily fluids that enter the lake, you're able to subsist for a time, forgetting about your mission as the all-consuming need devours your personality.");
			doNext(slimeBadEnd2);
		}
		
		private function slimeBadEnd2():void {
			clearOutput();
			outputText("One year later...");
			outputText("\n\nThe new champion has managed to escape imprisonment in the demons' sick plots, but the monsters and trials of this land have taken their toll on him.  He undresses and slips into the water, hesitant around his newly enlarged member, but once he slips beneath the soothing waters he forgets all about it and just relaxes.");
			outputText("\n\nHis reprieve is rudely interrupted as something thick and viscous wraps around his legs, gripping them with vicelike tightness.  He kicks futilely, accomplishing nothing but making the once-champion's goopy body jiggle as it slowly envelops more and more of the young man.  Suspended so that his head barely breaks the surface of the water, his entire body is wrapped up in more and more of the slime.  It curls around his member, slick and moist, gently massaging away his desire to resist.  The new champion relaxes and accepts it, twitching as the slime manages to caress a particularly tender spot.");
			outputText("\n\nThough the situation is incredibly pleasurable to both parties, the slime is merely following its instincts and seeking to fulfill its never ending craving.  For his part, the champion resisted admirably, though perhaps he simply had a high sexual endurance.  Whatever the case, this male doesn't last too long.  His altered sexuality easily accommodates the creature's desires, filling it with spurt after spurt of creamy whiteness, making it stronger for the first time in a long time.  It does not release him once his orgasm concludes.  It milks him again, and again, and again until the champion is unconscious, cradled in the slime's sloppy embrace.");
			outputText("\n\nFilled with new-found vigor, the slime travels up the beach, still holding its captive trapped inside it.  Its body shifts as a half-remembered humanoid form grows out from the blob's surface.  The new body is a parody of its former self, with sexually distorted features and jiggling, globe-like breasts.  It presses the captive's lips against a nipple, allowing him to suckle down a bit of her essence.  He does so instinctively – his parched body seeking relief from the orgasm-induced dehydration afflicting him.");
			outputText("\n\nIn a few hours he awakens, still entirely trapped by the wet-dream of a slime-girl.  His belly is full of her nutritious and corruptive slime, and his cock feels bigger and more sensitive than ever inside her tight embrace.  She squeezes and milks it, gurgling happily.  He cums for her.  Again and again he cums for her.  He can't stop or resist the feeling she gives him as he helplessly orgasms over and over.  She milks him forever, growing stronger, feeding him slime, and gathering incubi drafts and succubi's delight to satiate her ever-growing needs.");
			outputText("\n\nEvery year thereafter the new champion is greeted with a slippery prison, forced to orgasm and feed the slime-queen for the rest of their natural life.  Most of them stop minding by the second day, too drunk on her breast-milk and all the drugs she's mixed into it.");
			getGame().gameOver();
		}
		
//===============
//DEFEAT
//===============
		public function getBeatByGooGirl():void
		{
			if (doSFWloss()) return; //No rape in SFW mode.
			flags[kFLAGS.GOOGIRL_CONSECUTIVE_LOSSES]++;
			if (flags[kFLAGS.GOOGIRL_CONSECUTIVE_LOSSES] >= 5 && player.gooScore() >= 4) gooGirlBadEnd();
			else if (player.gender == 0) genderlessLoseToGooGal();
			else if (player.gender == 1) dudeLoseToGooGal();
			else if (player.gender == 2) femaleLoseToGooGal();
			else hermLoseToGooGal();
			flags[kFLAGS.TIMES_FUCKED_NORMAL_GOOS]++;
		}

//Defeat – Neuter
		private function genderlessLoseToGooGal():void
		{
			clearOutput();
			outputText("You stumble, nearly falling to your knees and the slime recognizes her victory with a smile that nearly bisects her face. Clapping her hands in a wet splash, she oozes up to you and wraps her dripping, puddle-like lower body around yours, quickly stripping your " + player.armorName + " off. There's no strength left in your limbs to resist, the goo-girl's insistent tugging guides you into the lapping waves of the lake. The cool water eases the excited heat of the girl's slimy embrace and you barely notice the depth until she's dragged you up to your chin. A surge of panic thrills up your spine, but she seems comfortable enough here, so she halts to investigate her prize.\n\n", false);

			outputText("The girl makes a careful survey of your flesh, rolling warm, goopy fingers along every curve and over every muscle. Shivering under her exhaustive inspection, it's all you can do to keep from sighing in blissful relief when her prodding becomes as firm as a masseuse's skilled hands. When she reaches the end of your abdomen, however, the girl's face screws up in an expression of confusion and annoyance. She pokes slurping, blobby hands across your groin without finding anything and her blank, " + gooColor() + " eyes roll theatrically in annoyance. She flicks your nose in a sullen huff and rests her amorphous fists on her jiggling hips, as she considers what to do with you.\n\n", false);

			outputText("The small, red core of the slime's heart pulses and a mischievous look crosses her face. She holds a hand between the two of you and, before your eyes, the fingers merge into a single digit, rolling into a plump, cylindrical mitt. The tip thins and curves into a sloping crest, while the base tightens into a shaft that looks vaguely fleshy. Tiny veins pop up on its surface and you realize she's made her arm into one, tremendously long, phallus. You shake your head weakly, but she just nods encouragingly and slides the tendril under the waves.\n\n", false);

			outputText("You struggle as best you can, but the vibrations only excite the girl. Her " + gooColor3() + " cock braces against your anus for a moment before squishing into your rectum without further ceremony. You bite your lower lip as the goo wriggles into you, just wide enough to put a moist pressure on your rippled inner walls. The translucent prick pushes deeper and through the slightly murky water, you can see your abdomen bulge with a foot of slithering slime. Squeezing your knees together, your face flushes in embarrassed excitement as another foot splurts into your bowels, then another. The invading pseudopod thins as it hits your small intestines, speeding up as it worms through your labyrinthine innards. The pressure in your gut becomes so intense, you find it difficult to breathe, your belly swelling many times its normal size. Savoring your helpless ecstasy, the playful goo leans in to plant a deep, gooshing kiss on your lips, warm " + gooColor4() + " ooze yielding and pliant to your flushed flesh.\n\n", false);

			outputText("Easily slipping through your digestive sphincters, the girl's slime-crafted cock plunges into your stomach and inflates so suddenly that you almost choke on the goo's kiss. Your body fattens to overflowing and your " + player.legs() + " give out. You break the slime's kiss to steal a deep breath before your head sinks beneath the waves. You blink at the white foam in your eyes and when your vision clears, the goo-girl is inches from your face, her expression one of mindless rapture. The fat cockhead in your gut twitches and pulses dangerously before a wave of dizzying fullness floods your chest. An insistent bulge enters your esophagus, working its way up your throat and past your tonsils before slapping the back of your teeth. You open your mouth in surprise and a " + gooColor5() + " blob as large as your head spills from your lips, floating in the water around you. The goo-girl is cumming in your belly and- with the other direction plugged up by her throbbing cock- it's being forced out of your head! Several smaller loads bubble up and you helplessly let them plop past your jaw to join the halo of swirling ejaculate around the two of you. Close on their heels, her shaft begins ascending through your throat, your neck distending at its passage. Your lack of air begins to take its toll as blackness creeps at the edges of your vision and your chest burns with suffocation. Through your woozy haze, you can feel the " + gooColor6() + " cockhead burst from your maw, poking several inches past your nose, just under your eyes. The goo-girl leans in again, this time opening her mouth to swallow her cock before sealing her lips around yours. The last thing you remember is the sensation of bulges moving up your whole body as the girl's mouth fills with her own cum. Then, there is only darkness.\n\n", false);

			outputText("You awaken with a sputtering hack, water and gooey " + gooColor() + " cum spilling from your lungs. You've been returned to shore and other than a full-body soreness and a splitting headache, you seem none the worse for wear. Who knew cute little slimes could be so aggressive when they don't have sex organs to suck on?", false);
			player.slimeFeed();
			player.orgasm();
			dynStats("sen", 4);
			combat.cleanupAfterCombat();
		}

//Defeat – Male
		private function dudeLoseToGooGal():void
		{
			clearOutput();
			var x:Number = player.biggestCockIndex();
			outputText("Reeling, you stumble backwards, trying and failing to shake the dizziness from your eyes. The " + gooColor() + " girl nods, emboldened, and leaps at you, her gushing body splashing heavily against your chest, knocking you to the ground. Your landing takes the breath from your throat and you struggle weakly as the " + gooColor5() + " muck below the girl's knees flows around your limbs, sucking your hands and feet into her slimy membrane with a slurping schlick. Trying to pull free, you stretch her body this way and that, but the goo holds fast, bonding you to her slippery form like warm, elastic shackles. The slime gurgles with pleasure at your struggles, her body rippling with your weak movements, her mouth curled into a happy grin. She gives you a wicked wink and rubs her hands over your hips, her dripping fingers slipping under your " + player.armorName + " and spreading across your flesh like a second skin. With squeezing tickles her groping digits massage her sludgy muck into your " + player.skin() + ". Pursing her mouth into a cute pucker, she grips your vestments between her lips and deftly pulls them aside just enough to let your " + player.cockDescript(x) + " flop free.\n\n", false);

			outputText("The heat from the slime girl's engulfing second skin begins seeping into your core, leaving you panting while beads of sweat trickle down your brow. She notices your discomfort and lowers her head to nudge your veiny phallus with her tiny, vestigial nose. The girl follows up with a playful kiss, cobalt lips pliant and moist. The fire around your skin goes from uncomfortable to suffocating as your cock surges to life, and the girl pouts at the look of dismay on your face. Her eyes light up with an idea and she opens her mouth as wide as your fist, revealing a thin, " + gooColor2() + " tongue swirling behind her lips. The goo-girl presses the tip of her tongue at the tip of your head and a wonderful flash of cold floods your groin, chilly shivers soothing your overheated body like an icy glass of water in the desert. Your voice wavers as you laugh in relief, her wet, whirling tongue lapping along your pulsing shaft, growing longer and more flexible with each passing moment. After a few minutes of her licking, the girl's tongue has grown long enough to wrap around your " + player.cockDescript(x) + " several times. Using it like a slimy tendril, she strokes up and down your manhood in tightening coils of " + gooColor4() + ", slimy drool giving your cock an almost indigo appearance.\n\n", false);

			outputText("As she jerks you off with her tentacle-tongue, the goo-girl's body temperature slowly equalizes, her tongue warming and her body cooling to match your body heat. Her wobbling chest moves in time with your breaths and her skin ripples at each of your heart beats, subtle mimicry synchronizing her form to yours. As you gradually relax, she gives you a second wink and unravels her prehensile tongue from your shaft, raising its thin, pointed tip to the crest of your bulb. She teasingly circles your urethra a few times, making you bite your lower lip, before sliding her tongue into the narrow cleft, pressing into your organ almost effortlessly. You marvel at how... right... it feels. There is no pain from the penetration, her gooey body sculpting the intruder to fit perfectly, just large enough to give you the sensation of a uniquely exciting pressure. Reflexively, your body tries to expel the snaking interloper, clenching rhythmically in trembling throbs that curl your fingers into quivering fists. At the sight of your pulsing erection, the girl lowers her head over your " + player.cockDescript(x) + ", and in one, long quaff, seals her mouth shut with a slurping gulp around your base. She stares at you, curiously, studying your expression as she bobs her head up and down in time to your quickening heart rate, syrupy clumps of the goo's hair falling over one of her eyes.\n\n", false);

			//[If the player has balls:
			if (player.balls > 0) outputText("The lithe layer of ooze that creeps across your body wraps around your " + player.ballsDescriptLight() + ", its silken touch like the caressing tips of dozens of fingers, nestling against your swollen testicles, cradling them to feel the rush of cum inflating your sac at the building suction of her mouth.  Even with your " + player.armorName + " still on, it feels like she's licking your bulging pouch with her sylphlike hands.  The slime's gooey grip presses against your scrotum with steady strokes, rolling your overinflated balls in their pouch as if the silent girl were playing some mischievous game. You shake your head as your " + player.ballsDescriptLight() + " bloat fuller and fuller at the coy girl's sport.\n\n", false);

			outputText("Through the " + gooColor2() + " hue of her semi-transparent face, you can see your cock throbbing at the gurgling eddies of her oozing mouth and the lively tongue-fucking she's giving your slit. Her pace has quickened to the point where her lips and nose slap against your groin with every heartbeat, a " + gooColor5() + " blur that feeds blissful inches of ooze into your urethra, flesh parting like a pussy before her penetration.  The second skin of the goo-girl's creeping hands reach the junction between your ass cheeks and you clench down as hard as you can, reluctant to let the spunky slime explore your body any deeper. The forceful girl will not be dissuaded, however, and her fingers grow thinner and thinner until one slides past your sealed sphincter like a key, inflating itself from within to open your ass to her curiosity. You moan as the oozing touch of her long, searching fingers edge their way past the plush, folded flesh of your anus, velvety walls parting as her hands swell to fit your bumpy nethers, first one finger, then another. She presses deeper until you feel what seems to be a fully formed hand snaking through your colon, up to the elbow, just as her devious tongue reaches the end of your urethra. Utterly penetrated, you are little more than putty in the hands and mouth of the goo-girl and the last of your resistance melts away.\n\n", false);

			outputText("She clenches her rippling body, mouth squeezing tighter than a fist and softer than a pussy on your sensitive organ. Your abdomen bulges outward as her gooey arm grows more solid inside your ass, filling you with a painless pressure that mirrors the straw-like tongue that you can see impatiently wriggling in your shaft. Her head ignites with the heat of anticipation and your muscles unclench, orgasm washing over you at last.", false);
			if (player.balls > 0) outputText("  Your scrotum lurches with the force of your load, balls slapping against her cobalt chin as thick cum churns against the obstructing tongue plugging your release. Some chemical in her saliva seems to be reacting inside your " + player.ballsDescriptLight() + ", the gurgling ejaculate multiplying, semen filling your pouch and bloating it before your eyes. The rubbing pressure on your prostate just worsens the condition and, for a moment, you fear your balls will swell too large for you to move!\n\n", false);

			outputText("Just in time, the thin tongue pistoning its way into your abdomen opens, the tube-like appendage mirroring the thirsty suckling of her " + gooColor5() + " mouth. Your body feels like it melts just a bit as your potent seed is greedily slurped up her tongue and bursts into her mouth with enough force to kick against the back of her maw, nearly blowing clear out of her head! Pumping her slimy fist inside your rear, the goo-girl milks your prostate for every drop of cum in your body.  ", false);
			//[small to medium cum amounts:
			if (player.cumQ() <= 500) outputText("A ball of pearl fluid builds up in the girl's head, turning her curious eyes white for a moment before she makes an exaggerated swallowing motion and the huge lump rolls down her throat, neck bulging outward as it drops into her belly, surrounding the gleaming ruby heart in a halo of ivory sperm.", false);
			else outputText("The girl's expression goes from pleased triumph to mild panic when your orgasm shows no sign of flagging, load after load racing into her body. She quickly snakes her tongue out of your urethra and tries to pull off of your " + player.cockDescript(x) + ", but her arm is too deep in your ass and she finds herself stuck! You rest your hands on the " + gooColor4() + " sludge of her goopy hair, fingers sinking into her slime as she tries to make room for your gushing, ivory torrent.  You clench your eyes in pleasure and surrender yourself to the feeling, your groin a font of creamy seed.  When you finally slow and open your eyes, you're a little surprised to find that the girl has become almost entirely white!  Her translucent skin retains a bit of the lake's " + monster.skinTone + " hue, but top to bottom, the goo-girl's body swirls with your cum, leaving her with the fattened appearance of pale pregnancy.", false);
			outputText("  Her arm slides out of your rump and the goo-girl practically rolls into the lake, splashing into the depths lazily. It sure didn't feel like you lost that fight, you reflect while taking delicious swallows of cold air.", false);
			player.slimeFeed();
			player.orgasm();
			dynStats("sen", 4);
			player.slimeFeed();
			combat.cleanupAfterCombat();
		}

//Defeat – Herm
		private function hermLoseToGooGal():void
		{
			var x:Number = player.biggestCockIndex();
			clearOutput();
			outputText("You can't take anymore and your hands fall at your sides as you sink to your knees. The goo-girl, sensing your surrender, happily claps her hands together in a wet, slapping motion and slides against you. Her soft, moist body squishes against yours as she runs her hands up and down your shoulders, fingers slipping under your " + player.armorName + ", sliding it off of you easily. The puddle of " + gooColor2() + " slime that makes up her lower torso laps at your " + player.legs() + ", warm muck sucking at your " + player.skin() + " with eager splashes. From the amorphous blob, two long, slender legs emerge and wrap themselves around the small of your back as she drapes her arms around your neck, drawing you into an embrace that squeezes her gooey chest against yours, her breasts twin globes of seething heat. She smiles innocently and her face shimmers as she stares into your eyes, drawing you tighter into her heat before leaning in and placing her " + gooColor7() + " lips against yours, kissing you with a curious, experimental hesitance at first that slowly becomes a gleeful pleasure, her wet tongue filling your mouth with the slimy girl's pulsing vibrations. You return her kiss, pressing your own tongue into her jelly-like throat, the squishy folds parting before your intrusion, happy pulses of warmth radiating from her quivering membrane.\n\n", false);

			outputText("When you break the kiss, a trail of " + gooColor3() + " goo still joining your lips to hers, you notice that she's slid her body entirely around yours, up to your neck! You struggle, but don't have the energy to fight against the slime's engulfing, gel-like form. Every inch of your bare flesh has the slight pressure of the girl's membrane against it, like too-tight clothes in a warm bathtub. You wriggle inside of her and she blinks in surprise, her mouth narrowing to a cooing pucker. Her eyes light up and she points a squishy hand at her mouth, her lips bulging a bit, filling with puffy goo. You shake your head, not understanding, until your body explains the meaning of her gesture. The supple suction of the girl's engulfing body gives way to the startling sensation of mouths, pressed against every sensitive inch of your flesh. The breath in your lungs catches in your throat as warm, wet, eager mouths wrap their yielding lips around your " + player.clitDescript() + " and " + player.nippleDescript(0) + ", semi-solid tongues teasing and flicking the tender organs. Sucking heat swallows " + player.sMultiCockDesc() + ", stroking the shaft", false);
			if (player.cockTotal() > 1) outputText("s", false);
			outputText(" in rippling walls of needy slime. Coils of hot and cold run up and down your " + player.cockDescript(x) + ", as playful tongues part your labia and trace every petal-like fold of your " + player.vaginaDescript(0) + ", filling you to your brim with gooey, thirsty ooze.\n\n", false);

			outputText("Dozens of mouths lick, suck, and nibble your flesh with the sweet pressure of the goo-girl's zest to explore your body, your building climax feeding her excitement, giving her body a feverish heat and sending rapid vibrations through the mouths and tongues that taste your inner recesses and coax your straining, pulsing length for the creamy ejaculate boiling in you. She cradles your body, twitching and helpless inside her, and gives you a playful bop on the nose before opening her smiling mouth as wide as she can. With a soundless giggle, she runs the tip of her tongue along the line of your jaw, up your cheek, and tickles the back of your earlobe. With a sweet little kiss on your lips, she contracts, squeezing down on your whole body as her face shifts into an intense expression of eye-clenched orgasm, silently moaning for you. It's too much, and your climax exhales in rapturous relief, the girl's body opening before the gushing expulsion of your protein-rich cum.", false);
			if (player.biggestLactation() >= 2) outputText("  The mouths sucking at your " + player.allBreastsDescript() + " ripple against your flesh until milk sprays from your mammaries, her body suckling the entirety of your lactate-heavy chest, cleavage to teat.", false);
			outputText("  Your spurting ecstasy floods the girl's jelly body, coloring her " + gooColor3() + " body white as she drinks deeply, coaxing a few seconds of gasping spasms into long, seed-spewing minutes of climaxing euphoria.", false);

			outputText("When you finally run dry, every muscle in your body aches with exhaustion and it feels like you haven't had anything to drink in months.  The slime slowly disentangles herself from your twitching form, ejecting you from the womb-like ardor of her squishy interior.  When she reforms her slender body, the goo-girl's belly bulges with your creamy load.  She gives you a beaming smile and pats her belly, sending ripples through her body with each wobbling slap.  The girl waves goodbye and slides back into the lake, giving you enough time to catch your breath and let your body recover.", false);
			player.orgasm();
			dynStats("sen", 4);
			player.slimeFeed();
			combat.cleanupAfterCombat();
		}

//Defeat – Female
		private function femaleLoseToGooGal():void
		{
			clearOutput();
			outputText("You sway, finding it difficult to maintain your balance. When you fall, your " + player.buttDescript() + " splashes wetly in the enveloping folds of the goo-girl's eager slime. You weakly hold your hand up to keep her back, but the wide-eyed victor disregards the gesture with playful disdain. She slithers against you, moist muck slurping at your flesh with a hungry heat. Her semi-solid hands take yours, pulling your arms apart to bare your chest. She cranes her dripping head around your shoulders, skillfully removing your " + player.armorName + " with only her mouth. Your " + player.chestDesc() + " heave as the irrepressible heat of the slime sears your " + player.nippleDescript(0) + "s until beads of sweat well up on your " + player.skin() + " and trickle down your curves, leaving a wet sheen over your body.\n\n", false);

			//[If the player is pregnant]
			if (player.pregnancyIncubation <= 280 && player.pregnancyIncubation >= 1) {
				outputText("The goo-girl squishes her lurid " + gooColor() + " body against yours, yielding membrane rippling across your flesh in anticipation. She leans in, inches from your face, when her expression turns quizzical. She seems surprised by something and studies you carefully. Her head cranes to one side, as if listening to something. Her face lights up in cheerful glee and she lowers her head to your belly, feeling the vibrations from within. By way of demonstration, she strokes her belly and it bloats to a sloshing pudge, making her appear to be in a state of advanced pregnancy. Nodding vigorously, she points to her breast and you notice that what you took for a single slime core, is actually two hearts pressed against one another! With happy bounces of excitement, she embraces you in a motherly hug.\n\n", false);
			}
			//	[If the player is not obviously pregnant/small breasts/not lactating]
			else {
				outputText("Shrugging, you gesture at yourself, unsure what she's trying to communicate to you. The goo-girl rolls her eyes and soundlessly sighs in exasperation. She grabs hold of you and runs her hands from your head to your hips, her body rippling as she does so, sculpting itself into a crude copy. She brings your attention to her belly and breasts, pointing to them as they swell and grow, nipples leaking " + gooColor8() + " goo-milk. Her stomach plumps further and further until she squeezes her whole body and a small, spherical blob tumbles from between her legs before being reabsorbed in her puddle. It's pretty obvious that the slime is telling you that you're pregnant.\n\n", false);
				outputText("Disparagingly, she pokes your " + player.allBreastsDescript() + " and shakes her head, an expression of disappointment on her face. She smiles and strokes your cheek, patting you comfortingly on the head with a dripping appendage. She quirks her head to the side and her blank eyes light up in the excitement of inspiration. Grabbing the sides of her hair, she lifts two of the gooey hair clumps and sculpts them into tiny cow horns. With a focused determination, she bites down on her lower lip and balls her mitten-like hands into fists, inflating her chest larger and larger, until it begins to dwarf the rest of her body. Her arms stretch out, around the titanic chest and grab the back of your head, pulling your mouth against her wobbling breast. Pulling your lips apart, she seals your face around a shimmering nipple.\n\n", false);

				outputText("Tentatively, you take an experimental swallow, a thin trickle of " + gooColor7() + " gel rolling warmly down your throat. The taste is vaguely familiar, but you can't quite place it. Taking another gulp, you roll the milky goo around in your mouth, trying to identify the flavor, but it continues to elude you. For some reason, it seems very important to determine the maddening fluid and you suck as hard as you can, steady streams of slimy cream filling your belly with a blossoming heat. When the goo-girl pulls you off, you're a little surprised to see that your breasts have grown! The liquid weight in your stomach seems to have expanded your chest. You tweak a " + player.nippleDescript(0) + " and find that milk gushes out, even at the slightest stimulation. You are lactating! Seemingly satisfied that your body is now fit to birth a child, the goo-girl nods her head, beaming.", false);
				//[player breast size increase, lactation activated/ amount increases]
				player.breastRows[0].breastRating++;
				player.boostLactation(1);
			}
			//[Pregnancy continued]
			if (player.pregnancyIncubation <= 280 && player.pregnancyIncubation >= 1) {
				outputText("The fluid woman squeezes her goopy breasts against yours and the globes jiggle with their liquid weight. The " + gooColor() + " girl wriggles against you with an ecstatic expression, delighting in the quivering vibrations of your body. She presses her palms to your breasts and the warm goo engulfs your " + player.nippleDescript(0) + " with a wet plop. She plays with your tits, rolling them in her hands while the slurping goop of her body sucks at your swollen mammaries. She bends down to pepper your pulsing tit-flesh with tiny, moist kisses that leave " + gooColor() + " lip prints on your " + player.skin() + ". Rocking her body against yours, the girl's expression mimicks the helpless, agonized bliss of your face, her cheeks even flushing indigo to imitate your blush. She darts in and gives you a deep, full-bodied kiss of pregnant joy and your " + player.allBreastsDescript() + " burst with creamy milk, even as your climax leaves your body as quivering as the goo-girl's. Feeding on your sexual release, she arches her back and her hearts flicker wildly, her body losing some of its focus as it appears to melt under her orgasmic heat.\n\n", false);

				outputText("Thick trails of milk squirt into the slime's hands and down her arms, filling the girl's " + gooColor() + " body with your creamy milk.", false);
				if (player.lactationQ() <= 1000) outputText("  She drains you in no time, hands hungrily sucking for more in goopy kisses on your overtaxed nipples.", false);
				//[medium milk only: 
				else if (player.lactationQ() <= 2000) outputText("  She drinks gratefully, nursing you with her permeable body until the pout of her belly sloshes heavily with the pale ivory of your motherly bounty.", false);
				else outputText("  You bite your lip and let go, torrents of rich, pearl fluid rushing through her arms and inflating the surprised girl before your eyes. The milk gushing into her fills the goo from base to breast, giving the once-" + gooColor5() + " girl an opalescent shine, her over-filled body bloated as if she were carrying triplets.", false);
				outputText("  She gives you a fond bop on the chin and a loving stroke on your belly before sloshing back into the lake, her seething heat still clinging to your body like a lingering hug.", false);
			}
			//[If the player isn't pregnant]
			else {
				outputText("The goo-girl flashes a broad smile and tickles under your chin to get your attention. Apparently trying to communicate her intent, she puffs out her cheeks and pats her belly, jiggling her amorphous frame in the process. Next, she taps your nose and pats your belly, slapping your " + player.skin() + " with a moist splat of her hand. Your expression remains blank and she sighs soundlessly, turning cold in annoyance. The slime presses you on your back and lifts your " + player.legs() + " into the air. In a splattering motion, the goo lets her lower half sink into the thick sludge of her feet until only her upper torso remains. Then, with impatient force, she descends on your " + player.vaginaDescript(0) + ", her yielding breasts rolling across your lower body.\n\n", false);

				outputText("The girl's face finds your all-too-eager pussy swiftly enough, her tongue tracing every fleshy fold of your labia while the warming slime of her lips suck at the moisture of your rapidly lubricating slit. She pushes a little harder, forcing the oozing length of her tongue inside of you, its pulsing surface expanding and contracting, leaving you squirming and gasping, biting at one of your knuckles while the goo prods the limits of your womanhood. Seemingly satisfied, she screws her face into an expression of intense focus and slaps her head down, between your thighs. The delicate features of her nose and face press against your lower lips with an insistence that practically melts you before, shockingly, her head begins to squeeze into your " + player.vaginaDescript(0) + "!\n\n", false);

				outputText("You try to stop the girl's progress, frantically, wagging your legs and clenching your inner walls together, but your strength has left you and her " + gooColor() + " skin is much too slippery to gain ground against. A moment later, all thoughts of stopping the invading goo are lost to the waves of gushing heat pouring into your body as her neck feeds into your aching cunt, filling your uterus with the sentient slime. She braces her hands at the widening mouth of your sex before slipping those in as well, working her arms and shoulders into your now gaping body.  ", false);
				//[Small vaginal capacity: 
				if (player.vaginalCapacity() <= 30) outputText("She bottoms out quickly, filling every inch of your pussy with her squished form, wriggling inside of you happily, her membrane molding to your birth canals every crevasse.", false);
				else outputText("More and more of her ooze thrusts into you, shivers of overstimulation tearing through your mind like fists through wet parchment. Your eyes roll aimlessly as the pressure makes it difficult to breathe. With a squelching slurp, the last of the girl's form is pulled inside your slavering pussy.", false);
				outputText("  Your body is wildly distorted by the intruder, some aspect of her slimy coating anesthetizing your anticipated pain with tooth-grinding pleasure. You stroke your bloated form, thoughts turning to sweet daydreams of pregnancy, your body full of a pulsing, liquid life, dependent upon you and squirming with eager desire.\n\n", false);

				outputText("When the girl begins sliding back out, it's all you can do not to vocalize your disappointment with a feeble moan. Splashing in an expanding puddle, the girl gradually molds her features back into a humanoid shape, but you notice she's smaller than before. Touching your belly, you can feel a jiggling orb still inside of you. You nearly bite your tongue when the straggler presses up against your cervix and forces its way into your womb with wriggling suction. Your body clenches in orgasm, but the slime's fluid body works past your sphincter-tight barrier and distends your gut with its occupancy. You shake in the squirting throes of your climax and the reduced woman rubs her cheek against your goo-slick breasts affectionately. Dimly, you notice that her heart-shaped core has been split right down the center, the other half, presumably, inside your body. With a wave goodbye, she plunges back into the lake, leaving you hot, wet, and pregnant- or what passes for pregnancy in asexual creatures.", false);
				if (player.pregnancyIncubation >= 1) outputText("  Everything she pumped into you runs back out after.  For some reason or another, it didn't take.", false);
				else {
					player.knockUp(PregnancyStore.PREGNANCY_GOO_GIRL, PregnancyStore.INCUBATION_GOO_GIRL, 1, 1);
				}
			}
			player.orgasm();
			dynStats("sen", 4);
			player.slimeFeed();
			combat.cleanupAfterCombat();
		}

//[Goo pregnancy- 3-4 days]
		public function gooPregVagBirth():void
		{
			flags[kFLAGS.GOOGIRL_BIRTHS]++;
			outputText("\n", false);
			if (player.vaginas.length == 0) {
				outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold a vagina.  ", false);
				player.createVagina();
				player.genderCheck();
			}
			outputText("There is a lurching in your belly that steals the breath from you. As seconds pass, the quivering kicks increase and you're forced to the ground as your womb feels like it's been set aflame by the heat pouring from your stowaway goo-girl. You pant and spread your labia with two fingers, the chill of your hands on your inflamed sex so sweet that you almost cum from the mere touch. Your cervix clenches involuntarily and you try to relax as much as possible, but the slime inside of you hardly needs the help. Squishing and slurping in gouts of syrupy fluid, she trickles from your uterus, sliding out of your tunnel in spurting gouts. You sigh and let her force her seething warmth from within you, the small puddle of ooze growing larger as it pools together. Finally, the small, red heart pops out of your tunnel and you allow yourself a big gulp of chill air to resuscitate your seared lungs.\n\n", false);
			monster = new GooGirl();//because if we don't, the gooColor4() goes crazy.
			outputText("The small " + gooColor4() + " sludge quivers, but seems unable to take a human shape. Extending pseudopods, it experimentally prods at your skin, trying to gets its bearings. You shiver as the goo slides over your flesh, poking you wetly from time to time. When it finds your breasts, the goo works up your mounds and slurps at your teats, milk filling the blob with a creamy tint that makes it larger and gives its membrane a firmer texture. It takes about ten minutes to flop its way across your entire body before sliding off of you and wriggling at your feet. It shifts again, but this time, manages to form a featureless head. Slowly, gradually, it adds more, morphing shoulders, arms, a waist, and even hips. Her body ripples and the blank slime morphs into a perfect miniature copy of you! It stares up at its mother with a happy expression before lurching away, toward the lake. Even though you were just her incubator and template, you can't help but feel a little pride at your goo child entering the wild world with a fearless sense of exploration.", false);
			dynStats("lus", 50);
		}


//VICTORY
		public function beatUpGoo():void
		{
			flags[kFLAGS.GOOGIRL_CONSECUTIVE_LOSSES] = 0;
			clearOutput();
			outputText("The excitement of your scuffle proves too much for the goo-girl to keep up with and she collapses into the slime of her lower torso, her skin wiggling as she struggles to maintain cohesion. Her expression is one of disappointment, and she looks at you with big, hopeful eyes, reaching out a hand, as if to offer an apology for her over-exuberance.\n\n", false);

			//Victory – Neuter
			if (player.gender == 0 || player.lust < 33 || flags[kFLAGS.SFW_MODE] > 0) {
				outputText("The goo-girl, while an unusual creature, seems unable to communicate and clearly has nothing of value.  Of no particular use in your quest, you shoo the dripping blob back to the shore. She seems disappointed at first, but bounces back quickly enough, spotting movement in the lake.  She splashes in and takes off at top speed, " + gooColor9() + " blur while you take your leave.", false);
				combat.cleanupAfterCombat();
			}
			else {
				outputText("With the goo-girl defeated, her unusual body is at your mercy.  What do you do?", false);
				var sex1S:String = "";
				var sex1N:Function =null;
				var sex2S:String = "";
				var sex2N:Function =null;
				var sex3S:String = "";
				var sex3N:Function =null;
				var sex4S:String = "";
				var sex4N:Function =null;
				var valeria:Function = kGAMECLASS.valeria.valeriaAndGooThreeStuff;
				if (player.armorName != "goo armor" || player.isButtPregnant() || player.isPregnant()) valeria = null;
				var eggs:Function =null;
				if (player.canOvipositBee()) eggs = layBeeEggsInGoo;
				if (player.hasCock()) {
					if (player.cocks[player.smallestCockIndex()].cockLength < 24) {
						sex1S = "DickSex";
						sex1N = createCallBackFunction(gooMaleRape,2);
					}
					if (player.longestCockLength() >= 24) {
						sex2S = "BigDickSex";
						sex2N = createCallBackFunction(gooMaleRape,1);
					}
					if (player.hasVagina()) {
						sex3S = "Herm Sex";
						sex3N = victoryHermSex;
					}
				}
				else if (player.hasVagina()) {
					sex1S = "Fuck";
					sex1N = normalFemaleRapesAGooGirl;
					if (flags[kFLAGS.PC_FETISH] >= 1) {
						sex2S = "Exhib.Fuck";
						sex2N = exhibitionismGooGirlVictoryRape;
					}
				}
				if (player.findPerk(PerkLib.Feeder) >= 0) {
					sex4S = "Breastfeed";
					sex4N = victoryRapeAGooGalAsFeeder;
				}
				var gooTF:Function = null;
				//corrupt chances
				if ((flags[kFLAGS.GOO_TFED_MEAN] == 0 && flags[kFLAGS.GOO_TFED_NICE] == 0) && flags[kFLAGS.TIMES_FUCKED_NORMAL_GOOS] >= 2) {
					if (player.cor < 50 && (player.hasItem(consumables.SUCMILK) || player.hasItem(consumables.P_S_MLK)) && (player.hasItem(consumables.BLACKEG) || player.hasItem(consumables.L_BLKEG))) {
						kGAMECLASS.latexGirl.pureGooRecruitmentStart();
						return;
					}
					else if (flags[kFLAGS.PC_KNOWS_ABOUT_BLACK_EGGS] > 0) {
						//Recruitment:
						//Notice After Victory:
						if (flags[kFLAGS.TIMES_THOUGHT_ABOUT_GOO_RECRUITMENT] == 0) {
							outputText("\n\nWith this quivering lump of goo before you, a devilish idea comes to mind.  What would it take to make one of these aqueous sluts your willing slave?  ...Something to make them a little solid - perhaps one of those black eggs to make its skin a little more solid and restrainable?  Maybe a succubi milk to help make it a little more human-like, and the increased libido certainly couldn't hurt.");
							flags[kFLAGS.TIMES_THOUGHT_ABOUT_GOO_RECRUITMENT]++;
						}
						//(Repeat)
						else {
							outputText("\n\nAs you survey your victory, you remember the idea you had before - maybe if you drugged one of these things with a black egg and some succubi milk, you could make it your pet?");
						}
						if ((player.hasItem(consumables.SUCMILK) || player.hasItem(consumables.P_S_MLK)) && (player.hasItem(consumables.BLACKEG) || player.hasItem(consumables.L_BLKEG))) {
							outputText("  Good thing you have those handy!");
							gooTF = kGAMECLASS.latexGirl.meanGooGirlRecruitment;
						}
					}
				}
				if (valeria != null) {
					outputText("\n\nValeria's armored form seems to ebb towards the puddled goo-woman before you, almost eager to close the distance with her despite her pledge to protect you. ");
					if (flags[kFLAGS.TIMES_VALERIA_GOO_THREESOMED] == 0) outputText("Do you offer a threesome with the girl to Valeria? It could get a little weird....");
					else outputText("Do you offer a threesome with the girl to Valeria? She'll likely try flood with you with more sloshing, shuddering pleasure than your body can handle.");
				}
				choices(sex1S, sex1N, sex2S, sex2N, sex3S, sex3N, sex4S, sex4N, "Lay Eggs", eggs, "", null, "", null, "Valeria", valeria, "Make Slave", gooTF, "Leave", combat.cleanupAfterCombat);
			}
		}


//Victory – Male
		private function gooMaleRape(type:Number = 1):void
		{
			flags[kFLAGS.TIMES_FUCKED_NORMAL_GOOS]++;
			clearOutput();
			var x:Number = player.biggestCockIndex();
			if (player.longestCockLength() >= 24 && player.shortestCockLength() < 24) {
				if (type == 1) x = player.longestCock();
				else x = player.shortestCockIndex();
			}
			outputText("The girl wriggles in place, staring hopefully at you from her oozing puddle, her arms folded under her chest, eagerly waiting for your next move. Your skin still prickles from the lingering heat of her touch, impatient desire bubbling in your chest. You descend on the girl and she proudly puffs out her breast, presenting herself to you.\n\n", false);
			//[Dick under 2 ft] 
			if (player.cocks[x].cockLength < 24) {
				outputText("Dropping to the goo-girl's level, you roughly grab her pulsing breasts, fingers sinking an inch into the slime before her surface tension gives you something to grip. Her membrane squishes between your fingers with lewd squelches as you squeeze harder, rolling the " + gooColor() + " orbs in your palms, her " + gooColor2() + " nipples bulging outward the harder you press. She noiselessly coos at your stimulation and shivers of delight ripple through her body. Stroking your body with soft hands, the goo-girl leaves " + gooColor9() + " film of warm slime across your " + player.armorName + " that quickly leaves you too hot to stay clothed. You strip and the buxom slime flashes a happy smile of victory.\n\n", false);

				outputText("Noticing your hardening length, the goo-girl claps her hands in gushing pleasure and gently pushes you back onto your " + player.buttDescript() + ". Rubbing her moist cheek against yours, she slides down your " + player.chestDesc() + " and perches over your groin. Slowly, she moves back and forth, stroking your shaft with the perky wetness of her stiff nipples. She hovers over your manhood for a moment before dropping down, her sloping cleavage stroking your cock between her slimy pillows with a slurping squelch. Pressing her balled-up fists to either side, she squeezes your " + player.cockDescript(x) + " between her breasts and begins to slowly pump your stiffening organ. The natural lubrication of her gooey skin makes the tit-fuck pleasantly slick, softness sucking your flesh with wet gulps as she rolls from base to tip, your cockhead popping between her cleavage at a brisk pace, cooled by the air for only a moment before it is swallowed once more by the seething heat of her chest. Through her transparent skin, you can see your " + player.cockDescript(x) + " being massaged by the gooey embrace of her tits. Your body trembles to the precipice of an orgasm, muscle spasms and a shortness of breath makes each pump of your slime-oiled hardness more exquisite than the last, as if the girl's murky breasts were pulling the air from your lungs.\n\n", false);

				outputText("As sweet as the oily crevasse of her chest is, you have a more pressing need. Grabbing the girl's shoulders, you push her back, your cock popping free of the slime's wobbling chest with a moist smack. She tilts her head, not understanding, and you look down, dismayed to find that she's sunk into her pooling lower body up to her hips, the pussy you so desperately need gone, just like that. Your engorged dick pulses in the open air and, in desperation, you lunge at the closest gooey protrusion. Pressing your cockhead to the girl's large, bobbing nipple, you thrust forward.\n\n", false);

				outputText("A burst of icy bliss arcs through your limbs as your " + player.cockDescript(x) + " penetrates the girl's membrane, her nipple begrudgingly opening to your intrusion like a virginal cunt. The slime soundlessly gasps and clasps her hands to her mouth in surprise. You grit your teeth at the sucking pressure of her body clenching down on your prick, trying to force you out, but the resistance just makes your thrusts all the sweeter. You buck against her chest, fucking her nipple and breast with everything you've got until, through the " + gooColor() + " hue of her transparent skin, you can see your cock bumping against the small red core of her heart.\n\n", false);

				outputText("The stimulation of the assault is too much and you let loose, spraying a pale torrent of seed against her nucleus. The girl's face transforms from utter confusion to mindless ecstasy in a heartbeat as your cum buffets her crimson center.  Her body gushes around you in orgasmic rapture and, with a rumbling shudder, her small, red heart is expelled violently from her shell, arcing through the air and splashing a hundred yards away, in the lake. The girl, fucked heartless, continues writhing in the throes of her climax, wrapping you in a blazing embrace and slathering you with sticky kisses.\n\n", false);

				outputText("You dump the rest of your load in the hollow girl and try to pull away, but she clings to you, desperately. Lacking a brain, all that's left of the girl appears to be her final impulse to fuck and suck endlessly. You indulge her again and again, but before long it's clear she's not stopping. Thankfully, after nearly an hour of her exhausting play, she finally looses consistency and collapses into a slimy puddle of muck, now more white than " + gooColor() + ". She slides into the lake, returning to whatever liquid state she came from. You take a dip yourself, to clean the lingering ooze on your body and slake your dehydration.", false);
				//Corrupt victory ooze – (After specific sex scenes while the player has a 70+ corruption score)
				if (player.cor >= 85 && rand(2) == 0) outputText("\n\nAs you're leaving, you happen to glance back at the lake and notice something strange; the sludge left by the melting shell of the goo-girl is quivering with renewed life! The swirling opalescence of your corrupt seed is clearly visible through her membrane, her " + gooColor11() + " slowly bleeding into a pale emerald hue. Your eyes widen as the muck regains solidity, first a head and then shoulders slowly rising from the puddle. The empty girl regains her shape, but the rippling within her does not stop. Gradually, her breasts shrink, flattening against her chest while a viridian phallus rises from between her legs.  Your cum floats down her torso and inflates a pair of jiggling, slimy balls.  The potency of your semen has reanimated the goo-girl, it seems, but has transformed her into an instinctual, mindless ooze. She- now a he- stares vacantly at you, the slick, green cock at his base stiffening, before he plunges into the lake. You'll have to check on your new son one of these days.", false);
			}
			//[Dick 2ft or larger]
			else {
				outputText("You hook your hands under her arms and haul the girl upwards, legs forming as her amorphous puddle shrinks and pools together into blobby limbs. She wobbles, finding it difficult to stand on two feet, and wraps her arms around your neck to steady herself. Squishing her body against yours, the goo-girl's " + gooColor4() + " slime leaks under your " + player.armorName + ", warm moisture lapping at your skin. Your shaft begins to stiffen under her boiling, wet hug and you peel off your clothes to let your mammoth girth stand free. Turning the girl around in your arms, you slap your burgeoning cock between her jiggling ass cheeks and haul her hands back, gripping the delicate, murky " + gooColor() + " fingers in one palm. With your other hand, you press down on the back of her head, bending the girl at a right angle. The slime shimmers and eyes open up in the back of her head, trying to figure out what you're doing.\n\n", false);

				outputText("You rub your " + player.cockDescript(x) + " between the girl's cheeks, drinking in the warmth of her body. She totters forward, almost falling, and clenches her ass around your length, gurgling rump sealing with a tickling gush as easily as if she'd extended a hand to steady herself. The clutching pressure makes you gasp in surprise and you jerk her arms back further, fingers sinking another inch into her skin. The girl inflates her tight, rippling ass for a better grip, but you've had enough foreplay. Sliding back, you line up your tip at the junction of her legs only to find that she has but a single hole! The goo's dim understanding of reproduction and waste removal notwithstanding, it oozes with a translucent fluid that sends chilling shivers of pleasure through you, cooling the blazing heat of her wriggling " + gooColor2() + " body.\n\n", false);

				outputText("With a forceful thrust, you push into the girl's drooling hole and are disappointed when you bottom out after a mere three inches. Clearly, she has entirely the wrong idea of sufficient depth. Giving her arms a jerk, you pump into her harder, pounding her recess until the slimy, sucking walls give before the pressure of your insistent member. She curls her mouth into a surprised O and molds her tunnel deeper, allowing you to feed more of your twitching fuck-pole into her. Eight, then ten, then twelve inches slap into the girl, your manhood visibly bisecting the goo as you slam past her rolling ass and squishy hips, into her belly. By the time twenty inches of your " + player.cockDescript(x) + " are inside her, your tip is just about level with her chest, breasts wobbling heavily as you impale the girl on your straining flesh-rod.\n\n", false);

				outputText("As your tip nears the girl's red core, she begins to squirm, your ceaseless pounding exciting her vibration-sensitive membrane. Her heart-shaped nucleus retreats into her head, making room for your seemingly endless cock. Finally, at twenty-three inches, it seems you've reached the end of her stretchy capabilities, her inner walls pulled so tightly around your colossal prick that every pulse of blood through your " + player.cockDescript(x) + " sends ripples through her body. You take a moment to bask in the heavenly fullness of the gooey onahole, her liquid mass suckling at your skin, pulsing with the eager need for your sweet protein.\n\n", false);

				outputText("But, if she was going to get fucked how she wanted, you reason, she should've put up a better fight in your little scuffle. Releasing her arms, you grab the goo-girl's pliable hips and fall backward, landing on your " + player.buttDescript() + " and dragging her with you. She flails her arms as the inflated globes of her ass squelch against your lap, penetrating the integrity of her inner passage as you slam the rest of the way up her throat. The girl opens her mouth in shock just as your tip emerges from her neck, pushing her jaw down and pulling her lips in a tight circle around your twitching glans. The girl's sultry body clenches down, trying to reseal the hole you've fucked all the way through her, giving you the final tension you need to climax.\n\n", false);

				outputText("Your orgasm bursts from your loins, thick loads pumping in bloated bulges up her squirming body and erupting from your corona in an ivory shower that splatters in wet ropes across the girl's stuffed face, her wobbling tits, and all along her translucent " + gooColor5() + " body. Like an unwilling cum hose, the girl wriggles, unable to disentangle herself from the flagpole of your " + player.cockDescript(x) + ". She settles with gathering your slippery, pearl seed with her hands, stuffing the nutrient-rich jizz into her belly button, which expands to slurp up the spunk like a second mouth. When the last of your climax is spent, you unsteadily regain your feet and slide the slime off your titanic shaft, her interior resealing with a gurgling plop. She rubs her stretched jaw and shoots you a look of playful annoyance before patting the milk-like bloat of her belly. She flashes a grin and slithers back into the lake.\n\n", false);

				outputText("If only all of Mareth's denizens were so accommodating, you muse, as you gather your things and depart.", false);
				coreDropChance();
			}
			player.orgasm();
			player.slimeFeed();
			combat.cleanupAfterCombat();
		}

//Victory – Herm
		private function victoryHermSex():void
		{
			var x:Number = player.biggestCockIndex();
			flags[kFLAGS.TIMES_FUCKED_NORMAL_GOOS]++;
			clearOutput();
			outputText("The goo-girl relents, her body sloshing into the puddle at her feet. Apparently convinced you want to explore her body, she composes her face into a willing smile and raises her arms at her sides, baring her " + gooColor8() + " torso for inspection. The slime's chest juts out in perfect hemispheres, untouched by gravity and topped with puffy, " + gooColor4() + " nipples that steadily drip a gooey imitation of milk. Her waist is whip-thin but broadens at her hips to accommodate her smooth, shiny rump, which she wiggles happily. Her hourglass figure would be life-threatening on any solid organism, but on the goo-girl, it merely appears she's been molded by someone with a dim grasp of anatomy.  Apparently, if slimes can't touch an organ, they don't consider it terribly important.\n\n", false);

			outputText("Reaching out, you take hold of her breasts, the gelatinous orbs jiggling at your touch. Her slick membrane is strangely warm, curtains of heat playing across her skin in an attempt to speak a language you don't understand. You communicate in your own way by giving the girl a slap across her tits, the fluid mammaries rippling from the impact. Her mouth curls into a little 'o' of shocked pleasure and she nods in encouragement. Giving her another open-palmed smack, you notice that her breasts begin to enlarge, providing more surface area for you to strike. The slime seems to be getting off on the spanking, so you slap her again and again, " + gooColor() + " jelly quivering in " + gooColor5() + " tidal waves, her bloating chest swallowing her belly and waist as it inflates under your stimulation. Her body heaves in imitation of orgasmic panting and her arms sink into her oceanic bosom, squeezing the shimmering pillows together for you.\n\n", false);

			outputText("Quickly stripping, you let your " + player.multiCockDescriptLight() + " slap against her turbulent membrane, the warm muck gurgling wetly at your turgid stiffness. Sinking your fingers into the girl's yielding breasts, you push forward, pulsing flesh sliding into the " + gooColor2() + " depths of her expanded cleavage. The goo-girl's chest sucks eagerly at you, pliant slime drooling warm " + gooColor5() + " beads of unnecessary lubrication as you pick up your pace. Staring at your " + player.multiCockDescriptLight() + " moving in and out of the girl's chest through her transparent skin, you are surprised to see her body shifting further under your pounding. A vertical slit opens between her breasts and her membrane quickly folds itself in delicate petals around the edges. Your next thrust pushes into the new cavity and the organic texture confirms your suspicion: she's created a vagina between her breasts for you to fuck!\n\n", false);

			outputText("Slowing yourself to enjoy the experience, you note that she seems to have made her new cunny too tight- every inch you push in displaces her mass, forming a bulge beneath her abdomen. Without even pausing, you lower yourself to sit atop the girl's lap and jam your " + player.cockDescript(x) + "  into her narrow tunnel. The bulge rises into your dripping pussy, her moist shaft conforming to your inner walls for a moment before stiffening into a replica of your own dick.  ");
			player.cuntChange(player.cockArea(0), true, false, true);
			outputText("Every time you withdraw from the squirming slime, she pulls out of you and every time you slam back in, your pussy fills with the aching delight of the gooey copy-cock. Through the girl's mimicking body, you've found a way to fuck yourself by proxy! The thought fuels your pace as you accelerate to a fevered pitch. Slamming the " + gooColor5() + " mirror of your " + player.cockDescript(x) + " into your sloppy cunt, you ride yourself with reckless abandon.  The force of your fucking is too much for the goo-girl and she silently cries out in ecstatic bliss before the pulsing scarlet heart in her chest is violently ejected from her body, splashing a hundred yards away in the lake's depths. With no core, the empty girl's face becomes wanton, little more than a lusty slut unable to sate her need to fuck, her tongue dangling out of the side of her mouth.\n\n", false);

			outputText("Before long, you find yourself mimicking the heartless whore, eyes lidded heavily and mouth agape at the doubled sensations of the hard fucking you're giving yourself. You know your body's sensitive weaknesses too well, it seems, and you're unable to hold out for very long. The slime-duplicate cock that strokes every delicate inch of your drooling pussy blends into the slippery cunt between the goo's breasts, tightening in pulsing rings of lubricated, velvet muscle. When you cum, both organs twitch in orgasmic spree, the feeling of filling and being filled scrambling your mind with sensory overload. Thick globs of cum splurt into the slime girl's body, pushing equally huge bubbles of seething hot muck into your clenched lower lips, splooshing gunk plopping against your cervix and sloshing together into one gurgling blob of slime-ejaculate. Wrapping her arms around you in a big, cheerful hug, the mindless shell keeps you pinned down until your cunt aches and your dick begins to stiffen again. Before a second round, however, the goo loses her consistency, the lack of a nucleus melting her wobbling form into a seed-saturated sludge that wiggles back toward the water's edge. You rise, panting hotly, deciding it's time to move on.", false);

			//Corrupt victory ooze – (After specific sex scenes while the player has a 70+ corruption score)
			if (player.cor >= 85 && rand(2) == 0) outputText("\n\nAs you're leaving, you happen to glance back at the lake and notice something strange; the sludge left by the melting shell of the goo-girl is quivering with renewed life! The swirling opalescence of your corrupt seed is clearly visible through her membrane, her " + gooColor11() + " slowly bleeding into a pale emerald hue. Your eyes widen as the muck regains solidity, first a head and then shoulders slowly rising from the puddle. The empty girl regains her shape, but the rippling within her does not stop. Gradually, her breasts shrink, flattening against her chest while a viridian phallus rises from between her legs.  Your cum floats down her torso and inflates a pair of jiggling, slimy balls.  The potency of your semen has reanimated the goo-girl, it seems, but has transformed her into an instinctual, mindless ooze. She- now a he- stares vacantly at you, the slick, green cock at his base stiffening, before he plunges into the lake. You'll have to check on your new son one of these days.", false);
			coreDropChance();
			player.orgasm();
			player.slimeFeed();
			combat.cleanupAfterCombat();
		}

//FEMALE VICTORIES
//[Feeder perk] 
		private function victoryRapeAGooGalAsFeeder():void
		{
			flags[kFLAGS.TIMES_FUCKED_NORMAL_GOOS]++;
			clearOutput();
			outputText("The slimy girl wobbles back and forth, curiously eyeing you with her mouth turned up in an expectant smile. Her expression slowly widens into one of alarm, as your breath comes in quickened gasps. The need is building in your chest, setting your nipples aflame with the pressure within your breasts. Reading the blossoming heat from your body, the goo-girl seems to guess your intent and the playful petulance gives way to a wary caution. She shakes her head, puffing her cheeks and patting her belly as if to say 'no thank you, I am full.' A lop-sided grin creeps up the side of your face, a trickle of drool sliding out the corner of your mouth. She thinks she's got a choice in the matter, you muse. How cute. Advancing on the girl, you gently stroke her " + gooColor4() + " cheek with the back of your hand, her fluid membrane slick and warm on your skin. Yes, she'll do quite nicely.\n\n", false);

			outputText("Stripping your " + player.armorName + " to the waist, you settle on your ass, guiding the slime to a sitting position in front of you, her gaze darting back and forth, debating if she still has a chance to run. Before she can weigh the option any further, you seize her head with both hands and brace your thumbs on either side of her jaw. With a bit of pressure, her gelatinous head squishes between your fingers, mouth opening under the force of your grip while her eyes fill with silent panic. Your chest heaves in the open air, the heat of the goo-girl's muck feeding into the furnace your thumping heart has made of your flesh. Unbidden, pale cream bubbles along the sensitive surface of your nipples, beading like sweat on your skin. You pull the girl's head against your leaking mammary, guiding her " + gooColor4() + " lips into a suckling seal around your areola, squelching slime lapping at your trembling mound. A pressure builds just beyond your ribs and you grit your teeth, clenching your eyes shut as you push past the resistance, squeezing your thighs together. With a sweet, trembling wave of blissful release, your breast gushes into the girl's mouth, a torrent released from the swollen bounty of your heavy peak. Your fingers dig into the girl's head as you press her pliant softness into the yielding swell of your " + player.allBreastsDescript() + ". The girl sucks gently, but every licking ripple of the slime's molded mouth excites your tingling breast with the familiar, surging sensations that creeps into your mind, clawing out all rational thought and leaving behind only the primal need to nurse.\n\n", false);

			outputText("The slime swallows, creamy milk floating down her neck and into her belly as she pops her lips off of your breast. \"<i>Not enough,</i>\" you pant, mouth twisting into a snarl. Sliding your thumbs from her jaw to her mouth, you hook your digits into the sides of her lips and pull outward, stretching her mouth wider and wider. Thrusting your chest forward, almost violently, you press your breasts together, between the sides of your arms, rubbing your nipples against each other. Jamming them into her stretched mouth, you begin jerking her head back and forth, fucking her face with your nipples. She gasps and the action seals her mouth as tight as a pussy around your intruding peaks, " + player.allBreastsDescript() + " squirting increasing loads with every thrust. On some level, you delight in the knowledge that the girl doesn't need to breathe as you have no desire to relent your milk-heavy assault, orbs throbbing with every pink-tipped smack against her " + gooColor5() + " face. After a few minutes of your pounding, she's given up struggling against you, rounded eyes relenting to a vacant expression as you use her head as a slimy milking machine.\n\n", false);

			outputText("Again and again, you fill her cheeks with your glistening warmth, and it's all she can do to swallow as quickly as possible, her throat bulging with the alabaster loads rolling into her over-full belly. Overwhelmed, the goo-girl's ruby heart rolls helplessly in the fattening slime's body, unable to digest the sheer volume of lactate you're pumping into her. Running out of places to store it, the girl's own breasts begin to inflate, her " + gooColor2() + " nipples leaking in bubbling rivulets to mirror your own aching mounds. She cycles through cup-sizes faster than you can list them, the burgeoning promise of her curved bounty weighing her down until her chest bounces against the puddle of her feet with every jiggling gulp. The " + gooColor8() + " hair sliding across your fingers begins to writhe and twist, gooey strands merging and rising to the sides of her head forming two little horns on either side of her head, her body morphing into a shape more appropriate for the sloshing udders her chest has become under the suckling you're forcing on the girl. You've fed her so much that she's become a milk cow, you realize with a shuddering pleasure that touches the addiction center of your brain so intensely that you feel yourself creaming in a sequence of full-body contractions, muscles clenching with shivering rapture. It's just so right, you muse, panting through the coiling suffocation of your orgasm, to awaken in others the NEED to be fed. How sweet to nurse and to be used! And how much sweeter to teach others the mind-erasing desire to be little more than a beast, addicted to the lust of being milked!  ", false);
			if (player.hasVagina()) outputText("Even without stimulation, your clit practically vibrates under your climax, squeezing your body to its limits until everything fades into a pearl haze and you lose yourself to the euphoria.\n\n", false);
			else if (player.hasCock()) if (player.hasVagina()) outputText("Even without stimulation, your cock practically vibrates under your climax, squeezing your body to its limits until everything fades into a pearl haze and you lose yourself to the euphoria.\n\n", false);
			else if (player.hasVagina()) outputText("Even without stimulation, your tingling anus practically vibrates under your climax, squeezing to its limits until everything fades into a pearl haze and you lose yourself to the euphoria.\n\n", false);

			outputText("When you regain consciousness, your breasts finally feel empty, milked dry by your rough treatment of the goo-girl. Shaking your head, you look for a sign of the girl and spot something a short distance off in the lake. You almost don't recognize her at first, until you notice the tiny, jiggling horns poking out of the sides of her head. The cow-slime has apparently captured a shark girl and an anemone, her pale " + gooColor() + " membrane wrapping around their bodies like giant fists. She's holding them to each giant breast, kneading their faces against her quivering membrane as her periwinkle nipples gush with your milk, soaking their heads and filling their senses with your addictive fragrance. In short order, they wrap their mouths around the " + gooColor5() + " faucets and begin to drink deeply, the cow-goo's face a silent mirror of your previous climax. Two more girls being taught the joys of lactation, you murmur, touching yourself with a gleeful shudder. Forcing yourself to master the desire to keep watching, you clean yourself up and head out, pleased gurgles fading into the distance.", false);
			coreDropChance();
			player.orgasm();
			//You've now been milked, reset the timer for that
			player.addStatusValue(StatusEffects.Feeder, 1, 1);
			player.changeStatusValue(StatusEffects.Feeder, 2, 0);
			combat.cleanupAfterCombat();
		}

//[Exhibitionist Perk]
		private function exhibitionismGooGirlVictoryRape():void
		{
			flags[kFLAGS.TIMES_FUCKED_NORMAL_GOOS]++;
			clearOutput();
			outputText("The slimy girl wobbles back and forth, curiously eyeing you with her mouth turned up in an expectant smile. Glancing around, you notice that your little scuffle with the slime has attracted several onlookers! From deeper in the lake, a grey-tinted shark girl and violet-colored anemone seem to be watching you with mild interest while on the shore a robed man has interrupted his secretive journey to eye the two of you warily. Further away, a small minotaur stands, surprisingly far from the mountains, sniffing the air and taking his measure of potential mates. The variety of eyes upon your body brings a cold sweat to your brow and you bite your lower lip with a ragged suck of air between your teeth. Fists clenched, you bow your head as your pulse quickens. With trembling hands, you reach up and loosen your " + player.armorName + " with deliberate slowness, stripping them from your form until you stand, bare skin exposed to all five viewers. With a nervous smile, you move closer to the goo-girl. Every step you take is followed so carefully by your watchers that it sends a thrill of excitement to your gut that ignites your loins with a steady dripping between your thighs. The slime girl purses her lips at your advance before seeming to notice the figures watching the two of you with a delighted clap of her mitt-like hands.\n\n", false);

			outputText("You close the distance with the " + gooColor8() + " girl and she rises up out of her puddle to meet you shoulder to shoulder, wrapping her slimy arms around your waist with an eager grope. You blush at the warm contact and can almost hear the intake of breath from your audience when you press your " + player.allBreastsDescript() + " into your partner's, flesh and membrane squishing against each other and gooshing out at the sides, as your stiff nipples rub against her slippery peaks. The goo's mouth opens in a silent moan and her wobbly membrane begins dripping thick beads of " + gooColor2() + ". The goo rubs against you in a steady, circular motion, her hands tracing the small of your back and up along your spine, her slippery slickness covering your skin in a " + gooColor4() + " film so thin and shimmering that it looks almost as though she is oiling your body with a " + gooColor6() + " lacquer. In your lust-filled mind, it is as if the gazes on your exposed form are filling your flesh with the heat of their desire until you realize that your body temperature actually is increasing with each passing second. The goo-girl's oil seems to retain the slime's rippling warmth and it caresses your torso with her playful glee, infectious giddiness adding fuel to the fetish worming its way through your brain. You guide your hands over your hips and across your " + player.skin() + ", spreading the glistening oil over you with a faint squeak of pleasure that just barely carries into the ears of your watchers. The shark girl's teeth gnash the open air, the water between her legs churning, while the anemone's wavy hair tendrils rub against one another in impatience. The robed man hasn't budged, but the minotaur's loin cloth has been pushed aside by his stiffening erection, the flaring head pulsing higher and higher with each trembling gasp that sighs from your chest.\n\n", false);

			outputText("Your hands find the goo-girl's and your fingers entwine around the girl's oozing digits, palms pressed together hard enough to send ripples down her arms. You lean forward and lick the side of her face, surprised to find that, despite the girl's heat, she tastes cold and sweet, like " + gooColor10() + " washed in a mountain stream. She kisses your cheek, leaving a " + gooColor5() + " lip-print on your skin before moving to your mouth. Tilting your head, you lean into her and lock your lips against her pliant mouth, sharing body heat with the slime as you slide your tongue into her gooey maw, the crimson organ vibrant inside her translucent head. Forming a tongue of her own, she wraps the moist duplicate around the original, coiling around your sensitive muscle, exciting your taste buds with a feast of milky flavors. You cast a quick glance at your watchers and a wave of gratification washes through you as you see the anemone stroking a phallus between her tendril-like legs under the lake's surface. The human's hands have disappeared inside his robe, but you can practically feel him touching himself to the sight of your heated embrace. The minotaur now stands at full mast and his face is flushing with the precursors to a rutting passion. Time to up the ante.\n\n", false);

			outputText("Freeing a hand from the slime, you reach across her jiggling butt and slide your middle finger down between her " + gooColor4() + " cheeks, locating the juncture of her wobbling legs. Stroking a spiraling circle around her pert rump, you push her abdomen against yours. The steady trickle of fluid from your " + player.vaginaDescript(0) + " has increased to an eager flow at the unabashed lust you're inspiring in those around you. Pulling your drooling cunny against the goo-girl's lubrication-beaded lips, you grind into her, fingers flickering between the two of you. She trembles against you, deepening the kiss, her tongue seeking the wetness of your moaning maw, stroking the panting inner walls of your mouth. Once your fingers have been sufficiently soaked by a mixture of your own girl-cum and your partner's goo-oil, you bundle your fingers into a narrow point. Your fingers rub gingerly at her sucking pussy, the moist girl's sex hot on your hand. Turning your bodies in a slow circle to make sure all your viewers get a good look, you slowly slide your hand into the goo-girl's opening, making the slime throw her head back in euphoric rapture. Pulling her hand down with your unoccupied arm, you roll your hips against her slick mitt, communicating your desire wordlessly. She take the hint immediately, arm stretching around your " + player.buttDescript() + " and up to your slavering cunt, the " + gooColor5() + " tendril penetrating you with exaggerated force, slime splashing across your lower body as she drives her hot goo into you.\n\n", false);

			outputText("You cry out with a swooning note of exhilaration so crystal clear that it carries across the lake like a chime, the force of your paradise reaching into the minds of your watchers and filling their eyes with images of running their hands all over your body, thrusting against you and using your willing flesh for every perverted desire they can dream up. You scream another inflaming moan of entranced delight, the fervor in your watchers boiling to a crescendo. When the shark girl jills herself to a trembling orgasm, it's as if you can feel her rough skin frantically rubbing against your sensitive clit. The anemone's climax spurts shimmering clouds of seed into the lake, filling the azure water around her with murky pools of jizz that you can somehow taste in your mouth, rolling down your throat in drug-like bubbles of rainbow ooze. The robed man sheds his vestments in time to free his member as it shoots a thick arc of rope-like cum into the air and you could swear you feel the warm slap of his seed splashing against your face and on your tits even though he's still dozens of yards away.  The minotaur is frantically jerking at his leg-thick shaft, unable to achieve release, but the goo-girl's ramming tendril feels just like the bull-man's engorged cock. In your fantasy world, he is drilling your cunt as hard as he can, using you like a breeding slave, his rut giving his thrusts enough force to bruise your tender form in his rush to fill your fertile womb with big, strong minotaur children.\n\n", false);

			outputText("Your orgasms are as loud as you can make them, screaming, cursing, and praying in consecutive breaths until you're hoarse and your body is sore with exhaustion. The goo-girl looks just as drained from the performance, cradling you in her gooey body as much as resting against yours. The effect of your show has left your viewers wanting more, it seems, as they've partnered off. The anemone has entwined the shark girl and is giving her enough to keep the vicious female snarling in ecstatic throes as the two churn the water to thick foam. The stray minotaur has taken the man from behind and, despite its formidable size, has pulled his victim to the very hilt of its member, swollen balls slapping against his legs while the stuffed man jerks himself off again, lost in some private memory of your display. You give the goo-girl a kiss on her " + gooColor7() + "-flavored face as thanks for the wonderful time and she musses your hair playfully. You give them a final show as you slowly put your " + player.armorName + " back on, gradually covering up your oil-slick skin before leaving the monsters to their own sport.", false);
			coreDropChance();
			player.orgasm();
			player.slimeFeed();
			combat.cleanupAfterCombat();
		}

//[Normal Female] 
		private function normalFemaleRapesAGooGirl():void
		{
			flags[kFLAGS.TIMES_FUCKED_NORMAL_GOOS]++;
			clearOutput();
			outputText("The slimy girl wobbles back and forth, curiously eyeing you with her mouth turned up in an expectant smile. You don't doubt that she'd enjoy playing with your body given half a chance, but your victory in the scuffle has given you a rare opportunity to try out something that been lurking in the back of your head for a while. With a devious smile, you remove your " + player.armorName + " until your bare flesh shivers at the cool wind blowing over the surface of the lake. You hook a beckoning finger to the goo-girl and she shrugs, a willing grin on her face. Splashing toward you, the girl's puddle laps at your " + player.feet() + ", " + gooColor2() + " muck lapping around you until you hold a palm up to stop her. Reaching down, you wrap your hands under her arms and haul her upward, plump legs forming under her waist as she grows taller and taller until you're eye to eye with the slime. Placing your fingers on her hips, you turn the girl around until her jiggling butt is pressed against your " + player.hipDescript() + ", warm goop wobbling with your every movement. Taking a deep breath, you shake out your shoulders and swallow. Here goes nothing.\n\n", false);

			outputText("With your hands wrapped around the goo-girl's waist, you take a step forward. The pliant ooze of the girl's body squelches at the pressure of your legs straining against her membrane, spilling out to the side of her hips and she perks her head up, unfamiliar with what you're trying to do. You push harder, keeping her in place as you move against her, more forcefully this time. Her body squeaks with the slapping pressure against her yielding form and she furrows her brow, pointing at her mouth and between her legs. You just smile and pull her against you harder and harder, her expression becoming pinched with the force of your attempt to move through her. Finally, her mouth gapes in discomfort and her membrane parts, gooey legs becoming permeable and squishing around " + player.legs() + ", engulfing your lower body in her " + gooColor4() + " slime. Your " + player.vaginaDescript(0) + " sinks into the muck of the girl's body and her heat washes over you in a wonderful embrace of fluid tightness that caresses as much as it gurgles across your sensitive flesh. Wet and soft, the inside of the girl's gelatinous form sculpts itself around yours like a slimy mold. As delightful as the moist embrace is for you, it seems to be getting the goo off even more, the rest of her membrane trembling, unable to maintain firmness in the assault of your invading body. You easily push your arms into her shoulders and down the dripping shafts of her " + gooColor8() + " limbs, fingers siding into hers like moist gloves of gelatin.  Your " + player.allBreastsDescript() + " goosh against her back and the tiny red heart in her chest retreats into her head as your orbs sink into the translucent girl's sapphire torso and rest within her wobbling breasts, her tits cupping your flush mounds like huge, warm mouths, her " + gooColor5() + " nipples tweaking yours ever so slightly as they pop into the pert nubs. You take another deep breath and release it, savoring the sensation as her back slowly closes up around your shoulder blades, sealing you to the neck in the goo-girl's body.\n\n", false);

			outputText("The sensations are so strange all over your body that it is overwhelming at first. You have to steady your breathing to keep the heat and tightness from subsuming your mind, so you take inventory of your body, focusing the cresting ecstasy of complete immersion down to more manageable chunks. The slime embracing your " + player.clitDescript() + " vibrates ever so slightly, teasing you so lightly it is maddening, your fingers twitching with the desire to rub yourself more vigorously. The goo around your pussy and ass is less coy, pressing inward with every heartbeat, penetrating you by inches as the bunch at your feet rolls upward to fill every nook and crevice of your curves with its oily " + gooColor2() + ". The goo inside you is just thick enough to make it difficult for you to take deep breaths, but soft enough to let your body squeeze and clench with gushing spasms that leave you swaying in place, not daring to move too much. Your breasts feel weightless, suspended in the thick fluid of the goo's body, leaving you light-headed and almost giddy, unable to help yourself as you play with your chest, wobbling the " + gooColor2() + " mammaries and giggling at the endless ripples that radiate over your chest, the motion sending curtains of heat rolling over your sensitive " + player.skin() + ".\n\n", false);

			outputText("Taking slow, shallow gulps of air, you finally master yourself and are able to move, albeit slowly. At your first step, the goo-girl sucks up the slime pooling at your feet and thickens the jiggling gel-encasement around you. Her head pokes out next to your shoulder, her expression one of eye-clenching bliss at the vibrations of your body inside her. She can feel every twitch of your over-stimulated flesh, every pulse of blood through your veins, and every muscle contraction of your building orgasm. The trivial sensation you take for granted are transmitted through the tightly-fitting body-suit you've made of her. A sudden resolve strikes you, and you launch yourself forward, breaking into a swift run across the shore of the lake. Next to yours, the girl's head silently moans at the muscles thrumming within her body. You clench your bobbing breasts with one hand, squeezing your nipples through the goo-suit and the shimmering, slick membrane begins to bead with droplets of sapphire sweat, your ministrations overwhelming the girl's ability to maintain consistency. The heat of her orgasm feeding into your own, it's all you can do to keep your " + player.legs() + " from slipping out from underneath you.  Your free arm lifts of its own accord and you realize with a start that she's not completely helpless as she moves your hand to your crotch, bracing your thumb firmly against your pulsing clit. You let out a soft gasp and try to pull your hand away, but the goo-glove controls your limb as firmly as if it were hers. She slides one finger after another into your goo-stuffed cunt and the penetrating firmness pushes her slimy-soft dildo deeper against your inner walls.\n\n", false);

			outputText("When she gets to the third finger, you lose your balance and tumble to the ground, rolling in the sand and ending up on your back as the goo-girl digs your hand into your pussy as deeply as she can. Trying to fight back, you squeeze your nipples in a pinch so tight it is just shy of painful. Wearing each others' bodies, the two of you roll your hands up and down, tweaking, stroking, pumping, teasing, and pinching every sensitive spot, trying to work the other to a release but succeeding only in pleasuring both of you. You turn your head to the goo-girl next to you and murmur \"<i>fuck it,</i>\" before pressing in to a deep, gooey kiss with the girl. The goo suit stops fighting against you immediately and the two of you jill yourselves frantically, redoubling your efforts, cooperatively this time. Your climax is almost immediate, the goo-girl rippling wildly as you clench down, muscles spasming in a full body shudder that floods your mind and tints your vision with a pinkish " + gooColor4() + ".\n\n", false);

			outputText("You aren't sure how much time has passed when you finally regain your senses. The goo-girl nuzzles your cheek affectionately, perhaps thanking you for the unique experience. Slowly, regretfully, she flows off of you, suckling ooze lapping at your limbs with slurping kisses all over your body. When the two of you are finally separated, you notice that she's maintained your proportions exactly, a " + gooColor3() + " mirror of your body, jiggling alluringly. You sigh as she flows back into the lapping waves of the lake, missing the heat of her embrace already. Admittedly, you don't know if trying to wear her for an extended length of time would've been a good idea- you'd never get anything done! Retracing your steps, you recover your " + player.armorName + " and head back to camp.", false);
			coreDropChance();
			player.orgasm();
			player.slimeFeed();
			combat.cleanupAfterCombat();
		}

//Ooze and Goo scene (one shot voyeur scene similar to the minotaur peep-show)– 
		public function spyOnGooAndOozeSex():void
		{
			monster = new GooGirl();
			clearOutput();
			outputText("As you are walking along the edge of the lake, the sound of splashing echoing across the shore catches your attention. At first, it is difficult to make sense of the confusing tableau of color, but before long you discern what's happening amid the chaotic waves. A girl-shaped mass of " + gooColor7() + " goo seems to be under attack by a swarm of smaller, vaguely masculine green slimes, all more or less male. Their limbs whip around the girl, trying to box her in from below, driving her to the surface of the water. Blunt, oozing limbs slap at her thighs and rump, sending cascading ripples through her body which seem to be causing her some distress. They're too far away to get a good look, but it almost seems like her mouth is open in a silent moan, her arms weakly trying to fend off the emerald men.\n\n", false);

			outputText("Blinking, you realize that they're not attacking her in the traditional sense. The oozes are apparently raping the goo-girl, in some strange slime-fashion. Every slapping blow they give her makes her amorphous body shift, spreading mass to her jiggling ass, swelling breasts, and plumping hips. Her feeble attempts to push the men away merely ends up pulling them closer to her, delicate fingers stroking their phallus-shaped pseudopods. Her thighs slap against one another wetly as she pinches her knees together, but the slimy rapists merely distort their bodies to slip between the goo's fattening 'legs'. With a tremendous splash, the goo-girl sends a curtain of water up around the slimes, blocking your sight for a moment. When the blinding mist settles, you can see that the girl's translucent, sapphire body has several verdant shafts pulsing within it. The ooze men underneath her and between her legs have pushed their way into her membrane, forcing her to form an asshole and pussy. The ones that have been inflating her form with gooshing slaps are pressed against her huge, wobbling tits, their dicks thrusting into her " + gooColor8() + " orbs. As they pump into her, the slime cocks draw additional mass from their bodies, growing larger and thicker, their burgeoning girth reducing the girl to a quivering ecstasy. Her head arches back, her mouth wide open, waggling " + gooColor3() + " tongue dripping out the side of her lips.\n\n", false);

			outputText("The small, crimson heart-shaped core in the girl's body swims within her form uncertainly. The expanding " + gooColor8() + " lengths gradually approach the jewel-like nucleus at the girl's center, their corrupt fluids swirling within the trembling shafts, moments from release. In panic, the girl's heart leaps up into her head and her eyes clench as her gaping mouth crinkles around the edges and she lurches forward in a tremendous sneeze. The slime core launches from her lips and arcs through the air before splashing safely away from the orgy. Without an intellect, the girl's now doll-like body coos wordlessly when the ooze men climax, unleashing a torrent of seething viridian into her. The murky cum floods the goo's vibration-sexualized form, filling her belly, limbs, and head with a creeping green tint. The hollow slime blissfully strokes her distorted form as the corrupt slime within her begins to work its masculine influence on her shape. Her overfull curves bubble and collapse as the last of her " + gooColor() + " goo is smothered by the corrupt slime semen.  When it's all over, the hyper-feminine slime's body has been sculpted to a slightly effete male. A bulge rises from between her legs, dripping into a fresh, gooey cock.\n\n", false);

			outputText("You hurry away before the five oozes take an interest in you next.", false);
			dynStats("lus", (4 + player.cor / 10));
			doNext(camp.returnToCampUseOneHour);
		}


		private function layBeeEggsInGoo():void
		{
			clearOutput();
			outputText("You stand triumphantly over the goo-girl, pondering how best to use her to sate your needs.  The girl doesn't seem quite interested in you anymore however, looking down between your feet instead.  Curious as to what grabbed her attention all of the sudden you look down behind you to find a small puddle of honey forming on the ground.  Your ovipositor twitches delightedly, dripping - and that's when you know just how to deal with your urges.");

			outputText("\n\nYou turn about, raising your bee abdomen over the defeated goo.  Sweet golden honey dribbles down and splatters across her breasts, staining them gold and adding girth to her slowly-swelling tits.  The goo quakes and ripples behind you, delighted by the honey now merging with her body.  She opens her mouth wide and lolls out her tongue in a silent pant, catching some of the amber goop in her mouth.");

			outputText("\n\nHaving acquired a target, you plunge your swelling ovipositor into her mouth, instantly distorting her cheeks and distending her neck as her mass is displaced around your injector.  The tightening and contracting as her form tries to re-contort itself around your egg hose is immensely pleasurable, robbing strength from your knees and eliciting a burst of honey into the hungry googirl's form.  You collapse to the ground with your bee abdomen still raised, pumping her full of sweet sludge.  A moan escapes your lips as you feel the first egg begin its journey down your canal and you begin panting heavily, working the first of many eggs through your ovipositor.");

			outputText("\n\nThe sudden appearance of a bulge in your honey-belching member excites the goo and she brings up her hands to work your tube, helping the bulging surprise along.  The first egg finally escapes with a large burst of honey, startling the goo's core.  The core and the egg bounce against each other for a moment, but are suddenly joined by a second egg and another flood of golden nectar.  You look over your shoulder at your honey-dump goo lover and watch as her form begins to become stained throughout by your fluids.  Splotches of amber goo begin to replace her normal coloration and by the third egg, her entire body is colored gold.");

			outputText("\n\nThis continues on for quite some time with the honey googirl greedily sucking down everything it can from your ovipositor, stroking it and squeezing your abdomen to work out all of its sweet fluid and eggs.  When you finally decide enough is enough, you retract your black tube and rise back up to your [feet].  Turning to look at the goo, you see her idly rubbing at her distended honey-colored belly, imitating a pregnant mother before she slides back down the lakeshore; your numerous eggs bounce around inside her infused body.  She turns one last time to you and waves before sinking below the surface.");
			player.dumpEggs();
			player.orgasm();
			combat.cleanupAfterCombat();
		}
	}
}
