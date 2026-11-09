package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.*;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;
import classes.lists.BreastCup;
import classes.lists.Gender;

	/**
	 * Jolene (Debimbofied Joy)
	 * Retains all of Joy/Jojo's body and pregnancy variables while offering her own interactions and scenes.
	 */
	public class JoleneScene extends NPCAwareContent
	{
		public function JoleneScene()
		{
			// Shares pregnancy store with JojoScene.as (jojoScene.pregnancy)
		}

		//------------
		// SHARED BODY & PREGNANCY HELPERS
		//------------
		public function get pregnancy():PregnancyStore {
			return jojoScene.pregnancy;
		}

		public function joleneVagCapacity():int {
			var temp:int = 30 + (10 * flags[kFLAGS.JOY_VAGINAL_WETNESS]);
			temp += (2 * flags[kFLAGS.TIMES_PENETRATED_JOY_VAGINALLY]);
			if (temp > 120) temp = 120;
			return temp;
		}

		public function joleneAnalCapacity():int {
			var temp:int = 30;
			temp += (5 * flags[kFLAGS.JOJO_ANAL_XP]);
			if (temp > 80) temp = 80;
			return temp;
		}

		public function joleneCockLength():Number {
			return flags[kFLAGS.JOY_COCK_SIZE];
		}

		public function joleneCockGirth():Number {
			return 1 + (Math.floor(flags[kFLAGS.JOY_COCK_SIZE]) / 10);
		}

		public function joleneBallSize():Number {
			if (joleneHasCock()) {
				if (flags[kFLAGS.JOY_COCK_SIZE] < 7) return 1;
				else if (flags[kFLAGS.JOY_COCK_SIZE] < 8) return 2;
				else return 3;
			}
			else return 0;
		}

		public function joleneHasCock():Boolean {
			return flags[kFLAGS.JOY_COCK_SIZE] > 0;
		}

		public function joleneHasCockText(text:String):String {
			if (joleneHasCock()) return text;
			else return "";
		}

		public function joleneCumQ():int {
			return jojoScene.jojoCumQ();
		}

		public function getTotalLitters():int {
			return flags[kFLAGS.JOJO_LITTERS] + flags[kFLAGS.JOY_TWINS_BIRTHED];
		}

		public function joleneBallsDescript():String {
			return SceneLib.joyScene.joyBallsDescript();
		}
		public function joleneCockDescript():String {
			return SceneLib.joyScene.joyCockDescript();
		}
		public function jolenePussyDescript():String {
			return SceneLib.joyScene.joyPussyDescript();
		}
		public function joleneAssDescript():String {
			return SceneLib.joyScene.joyAssDescript();
		}
		public function joleneBreastDescript():String {
			return SceneLib.joyScene.joyBreastDescript();
		}

		//------------
		// CAMP DESCRIPTIONS & FOLLOWER MENU
		//------------
		public function joleneCampDescription():void {
			if (flags[kFLAGS.JOLENE_FOLLOWER] <= 0) return;
			
			if (time.hours >= 6 && time.hours <= 21) {
				outputText("Jolene is seated cross-legged atop a flat boulder near her tent, her tailored monastic robes draped over her voluptuous figure as she meditates with a serene smile. ");
			} else {
				outputText("A warm candlelight glows from inside Jolene's tent, where the curvy mouse-monk is resting for the night. ");
			}
		}

		public function approachCampJolene():void {
			clearOutput();
			spriteSelect(SpriteDb.s_joy);
			
			outputText("You walk over to the smooth boulder where Jolene spends much of her day. Sensing your footsteps long before you arrive, the platinum-blonde mouse-morph opens her bright blue eyes and graces you with a warm, affectionate smile. She rises with fluid, martial grace, smoothing her modified silk robes over her generous curves.\n\n");
			if (pregnancy.isPregnant) {
				if (pregnancy.incubation < 100) {
					outputText("One of her slender hands rests lovingly atop the heavy, full swell of her pregnant belly. \"<i>Greetings, [name]. Our little ones are particularly lively today,</i>\" she murmurs in her smooth alto voice.\n\n");
				} else {
					outputText("Her hand briefly caresses the gentle curve of her pregnant tummy, her eyes softening as she looks at you.\n\n");
				}
			}
			outputText("\"<i>It is always a pleasure when you come to visit me, my love,</i>\" Jolene says, her long tail curling happily behind her. \"<i>Did you wish to train your body and mind, or were you hoping for more... intimate company?</i>\"");
			
			joleneMenu(true);
		}

		private function joleneMenu(approach:Boolean = false):void {
			if (!approach) {
				clearOutput();
				outputText("\"<i>Is there something else you would like to share with me, [name]?</i>\" Jolene asks warmly, her tail giving a gentle sway.");
			}
			spriteSelect(SpriteDb.s_joy);
			menu();
			addButton(0, "Appearance", jolenesAppearance).hint("Examine Jolene's appearance in detail.");
			addButton(1, "Talk", joleneTalkMenu).hint("Converse with Jolene about her life, philosophy, and feelings.");
			addButton(2, "Meditate", meditateWithJolene).hint("Meditate with Jolene to soothe your mind and calm your corruption.");
			addButton(3, "Spar", trainWithJolene).hint("Practice martial arts and physical conditioning with Jolene.");
			addButton(4, "Sex", initiateSexWithJolene).hint("Share an intimate, passionate moment with Jolene.");
			addButton(5, "Give Item", giveItemsToJolene).hint("Offer a consumable item to Jolene to alter her body.");
			if (player.hasStatusEffect(StatusEffects.JojoNightWatch)) {
				addButton(6, "Stop Watch", toggleJoleneNightWatch).hint("Ask Jolene to rest at night instead of standing guard.");
			} else {
				addButton(6, "Night Watch", toggleJoleneNightWatch).hint("Ask Jolene to help guard the camp at night.");
			}
			addButton(14, "Back", camp.campFollowers);
		}

		//------------
		// APPEARANCE
		//------------
		private function jolenesAppearance():void {
			clearOutput();
			var breastDesc:String = Appearance.breastCup(flags[kFLAGS.JOY_BREAST_SIZE]);
			outputText("Jolene stands just over four feet tall, possessing a captivating blend of monastic poise and unabashed, hourglass sensuality. Soft white fur covers her slender frame, accented by long, silky locks of platinum-blonde hair that frame her delicate mouse-like face and round, furry ears. Her bright blue eyes shine with keen intellect, mindfulness, and deep affection, while her naturally full lips carry a serene, confident smile.\n\n");
			
			outputText("She wears her white monastic robe altered with deliberate care: rather than hanging in tattered shreds, it has been neatly tailored into a sleeveless, wrap-around garment secured at her narrow waist by her string of wooden prayer beads. The open neckline still frames the lush, snowy cleavage of her " + breastDesc + " breasts, which sway gently with every breath she takes.\n\n");
			
			if (pregnancy.isPregnant) {
				if (pregnancy.incubation < 72) {
					outputText("Her belly is heavily distended with the ripe, unmistakable fullness of late pregnancy, her robes parted around the warm, furred dome of her womb.\n\n");
				} else if (pregnancy.incubation < 140) {
					outputText("Her midsection swells outward with a prominent, rounded baby bump that she carries with effortless pride.\n\n");
				} else {
					outputText("Her normally flat stomach bears a subtle, gentle rounding—the early sign of new life growing within her.\n\n");
				}
			}

			outputText("Below the hem of her robe, her flared, motherly hips and plush " + joleneAssDescript() + " lead down to toned thighs and digitigrade rodent paws. ");
			if (joleneHasCock()) {
				outputText("Nestled between her thighs is a prominent, " + Measurements.inchesOrCentimetres(joleneCockLength()) + " " + joleneCockDescript() + " resting above a pair of " + joleneBallsDescript() + ", while just beneath them lies the warm, glistening petals of her " + jolenePussyDescript() + ". ");
			} else {
				outputText("Nestled between her soft inner thighs are the warm, glistening petals of her " + jolenePussyDescript() + ", which often carry the sweet, inviting scent of her arousal. ");
			}
			outputText("Her long, pink mouse tail sways behind her in slow, graceful arcs.");
			doNext(joleneMenu);
		}

		//------------
		// TALK MENU
		//------------
		private function joleneTalkMenu():void {
			clearOutput();
			outputText("Jolene pours two small cups of herbal tea beside her boulder and invites you to sit with her. \"<i>What is on your mind, [name]?</i>\"");
			menu();
			addButton(0, "Her Identity", talkIdentity).hint("Ask how she feels about her past as Jojo and Joy.");
			addButton(1, "Philosophy", talkPhilosophy).hint("Ask about her new outlook on monastic discipline and pleasure.");
			addButton(2, "You & Her", talkRelationship).hint("Talk about your bond with her.");
			if (getTotalLitters() > 0 || pregnancy.isPregnant) {
				addButton(3, "Motherhood", talkMotherhood).hint("Ask how she feels about bearing your children.");
			}
			addButton(14, "Back", joleneMenu);
		}

		private function talkIdentity():void {
			clearOutput();
			outputText("You ask Jolene if she ever misses being Jojo, or if the memories of being 'Joy' ever trouble her.\n\n");
			outputText("She takes a slow sip of her tea, her blue eyes thoughtful. \"<i>In the first few hours after your elixir cleared the pink fog from my mind, I wondered if I ought to feel ashamed,</i>\" she admits softly. \"<i>As Jojo, I was taught that every bodily urge was a crack in the armor of the soul. When the incubus liqueur shattered that armor, I had nothing left to hold onto, so I drowned in pure, mindless hedonism.</i>\"\n\n");
			outputText("She sets her cup down and places a warm, furred hand over her heart—right above the swell of her cleavage. \"<i>But when I woke up as myself in this body, I realized something liberating. Jojo was miserable because he denied his heart, and Joy was hollow because she had no mind to appreciate what she felt. As Jolene, I am finally whole. I love the softness of my curves, the warmth of my desires, and the clarity of my spirit. I would never go back.</i>\"");
			doNext(joleneTalkMenu);
		}

		private function talkPhilosophy():void {
			clearOutput();
			outputText("You ask how she reconciles her monastic training with her unabashedly sensual nature.\n\n");
			outputText("Jolene chuckles, a rich, melodic sound. \"<i>My old masters at the monastery believed that peace could only be found through abstinence. Yet look what happened to so many who came to Mareth—the moment they tasted forbidden fruit, their willpower crumbled because they had never learned moderation or self-acceptance.</i>\"\n\n");
			outputText("Her long tail reaches over to trace along your knee. \"<i>True harmony isn't starving the body to feed the mind, [name]. It is allowing the body and spirit to dance together. A clear mind makes every touch, every kiss, and every climax infinitely more meaningful than mindless lust ever could.</i>\"");
			doNext(joleneTalkMenu);
		}

		private function talkRelationship():void {
			clearOutput();
			outputText("You ask Jolene how she views the two of you now.\n\n");
			outputText("A tender blush colors her furry cheeks beneath her white fur, and she leans in to press a soft, lingering kiss against your cheek. \"<i>Even when I was a stubborn, frightened little monk, you were the anchor that kept me from losing hope,</i>\" she whispers. \"<i>And when my mind was lost to the liqueur, you didn't abandon me—you gave me back my soul. You are my dearest friend, my protector, and my beloved partner. Whatever trials this realm throws at you, my body and my heart are yours.</i>\"");
			doNext(joleneTalkMenu);
		}

		private function talkMotherhood():void {
			clearOutput();
			outputText("You ask Jolene how she feels about motherhood and the children you share.\n\n");
			outputText("Jolene's expression melts into one of radiant warmth. ");
			if (pregnancy.isPregnant) {
				outputText("She strokes her rounded belly affectionately. \"<i>Feeling our little ones growing inside me is a miracle I never dreamed I would experience when I was a male monk,</i>\" she murmurs. ");
			}
			if (getTotalLitters() > 0) {
				outputText("\"<i>Knowing that we have brought new life into this world—and that our children are safe and thriving at the monastery—fills me with such pride. Being a mother hasn't dulled my martial edge; if anything, it has given me an even fiercer reason to protect our future.</i>\"");
			} else {
				outputText("\"<i>To carry your seed and nurture new life within my womb feels like the ultimate expression of our bond, [name].</i>\"");
			}
			doNext(joleneTalkMenu);
		}

		//------------
		// MEDITATION & TRAINING & NIGHT WATCH
		//------------
		private function meditateWithJolene():void {
			clearOutput();
			if (flags[kFLAGS.JOJO_LAST_MEDITATION] == time.days) {
				outputText("\"<i>We have already meditated together today, my love,</i>\" Jolene says gently. \"<i>Even the spirit needs time to absorb tranquility. Let us sit together again tomorrow.</i>\"");
				doNext(joleneMenu);
				return;
			}
			flags[kFLAGS.JOJO_LAST_MEDITATION] = time.days;
			outputText("You sit cross-legged across from Jolene atop the smooth boulder. Rather than keeping a rigid distance as Jojo once did, Jolene invites you to rest your hands in hers, your knees brushing against her soft thighs.\n\n");
			outputText("\"<i>Breathe with me, [name],</i>\" she murmurs, her soothing alto voice guiding your focus. \"<i>Do not fight the desires inside you, nor let them master you. Acknowledge them, embrace the warmth we share, and let the chaos of Mareth wash away.</i>\"\n\n");
			outputText("For nearly an hour, you breathe in tandem with the curvy mouse-monk, the subtle scent of her herbal tea and sweet femininity grounding your thoughts. By the time you open your eyes, your mind feels sharper, your spirit lighter, and your body deeply refreshed.");
			
			dynStats("int", 0.5, "wis", 0.5, "cor", -1);
			player.changeFatigue(-20);
			doNext(camp.returnToCampUseOneHour);
		}

		private function trainWithJolene():void {
			clearOutput();
			if (pregnancy.isPregnant && pregnancy.incubation < 72) {
				outputText("Jolene laughs softly, resting a hand on her heavily pregnant belly. \"<i>As much as I enjoy a good bout of sparring, my love, I think vigorous martial arts will have to wait until after I have delivered our little ones. Perhaps a gentler form of exercise in my tent instead?</i>\"");
				doNext(joleneMenu);
				return;
			}
			outputText("You step out into the clearing with Jolene for a sparring session. Despite her voluptuous " + Appearance.breastCup(flags[kFLAGS.JOY_BREAST_SIZE]) + " bust and wide, sway-heavy hips, Jolene moves with breathtaking agility—using the momentum of her curves to flow seamlessly from dodges into sweeping kicks and palm strikes.\n\n");
			outputText("You trade blows and grapples for nearly an hour until both of you are glistening with sweat. The match ends with Jolene deftly sweeping your legs and pinning you to the grass, straddling your waist with a breathless, triumphant grin as her heavy breasts heave against your chest.\n\n");
			outputText("\"<i>Well fought, my love,</i>\" she purrs, leaning down to steal a quick, heated kiss before helping you to your feet.");
			
			dynStats("str", 0.5, "spe", 0.5, "tou", 0.5);
			doNext(camp.returnToCampUseOneHour);
		}

		private function toggleJoleneNightWatch():void {
			clearOutput();
			if (player.hasStatusEffect(StatusEffects.JojoNightWatch)) {
				player.removeStatusEffect(StatusEffects.JojoNightWatch);
				outputText("You tell Jolene that she doesn't need to stand guard at night anymore. She bows her head graciously. \"<i>Very well, [name]. That simply means I can spend more of my nights warming your bed instead.</i>\"");
			} else {
				player.createStatusEffect(StatusEffects.JojoNightWatch, 0, 0, 0, 0);
				outputText("You ask Jolene if she would be willing to keep watch over the camp at night. She smiles and nods, tapping the prayer beads at her waist. \"<i>Of course, my love. My senses are sharp, and no intruder will disturb your rest while I am on guard.</i>\"");
			}
			doNext(joleneMenu);
		}

		//------------
		// GIVE ITEMS (BODY MODIFICATION)
		//------------
		private function giveItemsToJolene():void {
			clearOutput();
			outputText("Jolene tilts her head curiously. \"<i>Did you bring something for me to try, [name]? I trust your judgment completely.</i>\"");
			menu();
			var btn:int = 0;
			if (player.hasItem(consumables.INCUBID)) {
				addButton(btn++, "Incubi Draft", giveJoleneIncubiDraft).hint("Offer her an Incubi Draft to grow or enlarge her manhood.");
			}
			if (player.hasItem(consumables.SUCMILK)) {
				addButton(btn++, "Succubi Milk", giveJoleneSuccubiMilk).hint("Offer her Succubi Milk to shrink her manhood or swell her bust.");
			}
			if (player.hasItem(consumables.GROPLUS)) {
				addButton(btn++, "GroPlus", giveJoleneGroPlusMenu).hint("Use GroPlus to increase her bust or endowment.");
			}
			if (player.hasItem(consumables.REDUCTO)) {
				addButton(btn++, "Reducto", giveJoleneReductoMenu).hint("Use Reducto to reduce her bust or endowment.");
			}
			addButton(14, "Back", joleneMenu);
		}

		private function giveJoleneIncubiDraft():void {
			clearOutput();
			player.consumeItem(consumables.INCUBID, 1);
			outputText("You hand the Incubi Draft to Jolene. Now that her mind is clear and fortified, she examines the bottle without fear. \"<i>Purified or not, the essence within won't cloud my thoughts again,</i>\" she notes, uncorking it and drinking it down.\n\n");
			if (flags[kFLAGS.JOY_COCK_SIZE] == 0) {
				flags[kFLAGS.JOY_COCK_SIZE] = 5.5;
				outputText("Jolene inhales sharply, her cheeks flushing as a warm bulge pushes outward above her glistening slit, rapidlyunfurling into a throbbing, 5.5-inch " + joleneCockDescript() + " complete with a pair of " + joleneBallsDescript() + ". She strokes her new shaft with a sultry smile. \"<i>Mmm... having both sets of equipment certainly opens up wonderful possibilities for us, doesn't it?</i>\"");
			} else if (flags[kFLAGS.JOY_COCK_SIZE] < 8.5) {
				flags[kFLAGS.JOY_COCK_SIZE] += 1;
				outputText("A soft moan escapes Jolene's lips as her " + joleneCockDescript() + " surges forward, swelling thicker and longer until it settles at a hefty " + Measurements.inchesOrCentimetres(joleneCockLength()) + " long! \"<i>Oh my... I can feel every pulse of it against my thigh,</i>\" she purrs.");
			} else {
				outputText("Her shaft twitches and throbs warmly, dribbling a bead of pre-cum, though it seems to have already reached its maximum size.");
			}
			doNext(joleneMenu);
		}

		private function giveJoleneSuccubiMilk():void {
			clearOutput();
			player.consumeItem(consumables.SUCMILK, 1);
			outputText("You offer a bottle of Succubi Milk to Jolene, who drinks the creamy liquid with poised appreciation.\n\n");
			if (flags[kFLAGS.JOY_COCK_SIZE] > 0) {
				if (flags[kFLAGS.JOY_COCK_SIZE] <= 5.5) {
					flags[kFLAGS.JOY_COCK_SIZE] = 0;
					outputText("Jolene gasps softly as her manhood and testicles retreat smoothly back into her body, leaving only the warm, feminine folds of her " + jolenePussyDescript() + " between her thighs. \"<i>Back to pure femininity, I see. I am happy either way, so long as it pleases you,</i>\" she smiles.");
				} else {
					flags[kFLAGS.JOY_COCK_SIZE] -= 1;
					outputText("Her " + joleneCockDescript() + " shivers and diminishes slightly, settling to a more manageable " + Measurements.inchesOrCentimetres(joleneCockLength()) + ".");
				}
			} else if (flags[kFLAGS.JOY_BREAST_SIZE] < BreastCup.H) {
				flags[kFLAGS.JOY_BREAST_SIZE]++;
				outputText("Jolene places both hands under her chest as her breasts swell outward with a warm tingle, expanding into a lusher pair of " + Appearance.breastCup(flags[kFLAGS.JOY_BREAST_SIZE]) + "s!");
			} else {
				outputText("A pleasant warmth washes through her curves, making her sigh contentedly, though her body doesn't change any further.");
			}
			doNext(joleneMenu);
		}

		private function giveJoleneGroPlusMenu():void {
			clearOutput();
			outputText("Where would you like Jolene to apply the GroPlus?");
			menu();
			if (flags[kFLAGS.JOY_BREAST_SIZE] < BreastCup.J) {
				addButton(0, "Breasts", giveJoleneGroPlusBreasts);
			}
			if (joleneHasCock() && flags[kFLAGS.JOY_COCK_SIZE] < 10) {
				addButton(1, "Cock", giveJoleneGroPlusCock);
			}
			addButton(14, "Back", giveItemsToJolene);
		}

		private function giveJoleneGroPlusBreasts():void {
			clearOutput();
			player.consumeItem(consumables.GROPLUS, 1);
			flags[kFLAGS.JOY_BREAST_SIZE]++;
			outputText("Jolene administers the GroPlus to her chest, gasping in pleasant surprise as her breasts surge outward into even heavier, firmer " + Appearance.breastCup(flags[kFLAGS.JOY_BREAST_SIZE]) + "s. She tests their heft in her palms with an appreciative hum. \"<i>You certainly enjoy a generous pillow to rest upon, don't you, my love?</i>\"");
			doNext(joleneMenu);
		}

		private function giveJoleneGroPlusCock():void {
			clearOutput();
			player.consumeItem(consumables.GROPLUS, 1);
			flags[kFLAGS.JOY_COCK_SIZE] += 1;
			outputText("Jolene applies the GroPlus to her groin. A low, resonant moan rolls from her throat as her " + joleneCockDescript() + " thickens and lengthens, settling at an impressive " + Measurements.inchesOrCentimetres(joleneCockLength()) + "!");
			doNext(joleneMenu);
		}

		private function giveJoleneReductoMenu():void {
			clearOutput();
			outputText("Where would you like Jolene to apply the Reducto?");
			menu();
			if (flags[kFLAGS.JOY_BREAST_SIZE] > BreastCup.B) {
				addButton(0, "Breasts", giveJoleneReductoBreasts);
			}
			if (joleneHasCock()) {
				addButton(1, "Cock", giveJoleneReductoCock);
			}
			addButton(14, "Back", giveItemsToJolene);
		}

		private function giveJoleneReductoBreasts():void {
			clearOutput();
			player.consumeItem(consumables.REDUCTO, 1);
			flags[kFLAGS.JOY_BREAST_SIZE]--;
			outputText("Jolene massages the Reducto paste into her cleavage. Within moments, her bust shrinks down a cup size, leaving her with perky, athletic " + Appearance.breastCup(flags[kFLAGS.JOY_BREAST_SIZE]) + "s. \"<i>Ah, much lighter on my back during sparring!</i>\" she remarks happily.");
			doNext(joleneMenu);
		}

		private function giveJoleneReductoCock():void {
			clearOutput();
			player.consumeItem(consumables.REDUCTO, 1);
			if (flags[kFLAGS.JOY_COCK_SIZE] <= 5.5) {
				flags[kFLAGS.JOY_COCK_SIZE] = 0;
				outputText("Jolene applies the Reducto to her manhood, and with a gentle tingle, her shaft and balls recede completely, leaving only her smooth, feminine slit.");
			} else {
				flags[kFLAGS.JOY_COCK_SIZE] -= 1;
				outputText("Jolene applies the Reducto to her shaft, reducing it down to a sleeker " + Measurements.inchesOrCentimetres(joleneCockLength()) + ".");
			}
			doNext(joleneMenu);
		}

		//------------
		// SEX SCENES (JOLENE-SPECIFIC)
		//------------
		private function initiateSexWithJolene():void {
			clearOutput();
			outputText("You step closer to Jolene, sliding a hand around her slender waist and drawing her curvy body against yours. Rather than giggling mindlessly as Joy once did, Jolene meets your gaze with smoldering intensity. Her nimble fingers rise to trace your jawline before she rises up on her tiptoes to press her soft, full lips to yours in a deep, passionate kiss.\n\n");
			outputText("\"<i>Come inside my tent, [name],</i>\" she whispers against your lips, her voice thick with desire as she leads you by the hand onto her plush bedding and unties the prayer beads holding her silk robe closed. The garment parts, baring her " + Appearance.breastCup(flags[kFLAGS.JOY_BREAST_SIZE]) + " breasts, her " + jolenePussyDescript() + joleneHasCockText(", and her stiffening " + joleneCockDescript()) + ".\n\n");
			outputText("\"<i>Tell me how you want me, my love...</i>\"");
			
			menu();
			if (player.hasCock()) {
				addButton(0, "Vaginal", joleneVaginalSex).hint("Make love to Jolene's warm mouse pussy.");
				addButton(1, "Anal", joleneAnalSex).hint("Take Jolene's plush rear.");
				addButton(2, "Titfuck & Oral", joleneTitfuckAndOral).hint("Let Jolene worship your shaft with her breasts and mouth.");
			}
			if (joleneHasCock()) {
				if (player.hasVagina()) {
					addButton(3, "Ride Her Cock", joleneFucksPlayerVaginal).hint("Let Jolene make love to your pussy with her shaft.");
				}
				addButton(4, "Take Her Anal", joleneFucksPlayerAnal).hint("Let Jolene take your ass with her shaft.");
				addButton(5, "Pleasure Cock", playerOralJoleneCock).hint("Worship Jolene's throbbing shaft with your mouth.");
			}
			addButton(6, "Cunnilingus", playerEatJoleneOut).hint("Use your tongue and fingers to bring Jolene to climax.");
			addButton(14, "Back", joleneMenu);
		}

		private function joleneVaginalSex():void {
			clearOutput();
			flags[kFLAGS.TIMES_PENETRATED_JOY_VAGINALLY]++;
			if (flags[kFLAGS.JOY_VAGINAL_WETNESS] < 4 && flags[kFLAGS.TIMES_PENETRATED_JOY_VAGINALLY] % 5 == 0) {
				flags[kFLAGS.JOY_VAGINAL_WETNESS]++;
			}
			var breastDesc:String = Appearance.breastCup(flags[kFLAGS.JOY_BREAST_SIZE]);
			outputText("Jolene reclines back on her cushions, parting her toned, white-furred thighs in a graceful, welcoming invitation. Her " + jolenePussyDescript() + " is already glistening with dewy arousal, her scent warm and intoxicating. As you position yourself between her legs and press the head of your [cock] against her slick folds, she reaches up to cup your cheek, her bright blue eyes locked onto yours.\n\n");
			outputText("With a slow, firm thrust, you sink deep into her velvety heat. Jolene lets out a breathless, melodic gasp, her back arching as her trained pelvic muscles clench rhythmically around your length. Unlike the frantic, scatterbrained bouncing of her bimbo past, Jolene moves her hips with deliberate, sensual mastery—rolling her pelvis to meet every stroke while her long tail wraps affectionately around your waist.\n\n");
			outputText("\"<i>Yes, [name]... just like that,</i>\" she moans, her hands sliding down to entwine her fingers with yours as her " + breastDesc + " breasts sway lusciously with each thrust. " + joleneHasCockText("Between your stomachs, her " + joleneCockDescript() + " twitches and rubs against your abs, leaking clear pre-cum onto her snowy fur. ") + "Every squeeze of her inner walls feels intentional, drawing you closer and closer to the edge.\n\n");
			outputText("When your climax finally crests, Jolene wraps her legs tight around your hips, pulling you to the hilt. \"<i>Give it to me, my love—fill me completely!</i>\" she cries out, her own body shuddering through an intense orgasm as her inner walls milk your [cock]" + joleneHasCockText(" and her shaft erupts in thick, hot ropes between your bellies") + ". You pour pulse after pulse of hot seed deep into her womb while kissing her deeply, basking in the tender afterglow as she holds you close against her heaving chest.");
			
			if (!pregnancy.isPregnant) {
				pregnancy.knockUp(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_JOJO, 175);
			}
			player.orgasm('Vaginal');
			doNext(camp.returnToCampUseOneHour);
		}

		private function joleneAnalSex():void {
			clearOutput();
			flags[kFLAGS.JOJO_ANAL_XP]++;
			outputText("Smiling over her shoulder, Jolene turns onto her hands and knees, arching her back in a supple stretch that presents her plush " + joleneAssDescript() + " and the tight pucker nestled beneath her tail. She reaches back with one hand, using the slick moisture from her " + jolenePussyDescript() + " to coat her rosebud and the tip of your [cock].\n\n");
			outputText("\"<i>Take your time with me, [name],</i>\" she murmurs soothingly, relaxing her breathing with her monastic control as you press forward. Her tight ring yields to your advance, gripping your shaft in a hot, velvety vise that makes both of you groan aloud.\n\n");
			outputText("Once you are seated deep inside her, Jolene begins to push back against your hips in a slow, undulating rhythm. Her mastery of her own body is extraordinary—she tightens and relaxes around you on command, turning every thrust into waves of exquisite friction. " + joleneHasCockText("Beneath her swaying hips, her " + joleneCockDescript() + " swings heavily, dripping pre-cum onto the blankets as you stroke it in time with your thrusts. ") + "\n\n");
			outputText("With a final, passionate cry, Jolene climaxes around you, her plush cheeks clapping against your thighs as you bury yourself deep and fill her rear with your hot release.");
			
			player.orgasm('Anal');
			doNext(camp.returnToCampUseOneHour);
		}

		private function joleneTitfuckAndOral():void {
			clearOutput();
			var breastDesc:String = Appearance.breastCup(flags[kFLAGS.JOY_BREAST_SIZE]);
			outputText("Jolene kneels gracefully between your legs, her blue eyes sparkling with affectionate devotion as she gazes up at you. Leaning forward, she presses a warm kiss to the tip of your [cock] before enveloping your shaft between the plush, snowy mounds of her " + breastDesc + " breasts.\n\n");
			outputText("With practiced elegance, she slicks her cleavage with her tongue and begins sliding her heavy breasts up and down your length. Every time your tip emerges from her soft valley, her warm lips and nimble rodent tongue swirl over your glans, teasing you with exquisite precision while her gaze never leaves yours.\n\n");
			outputText("\"<i>I love feeling how much you want me, [name],</i>\" she purrs, taking the top half of your shaft deep into her warm throat while continuing to massage the base with her breasts. Unable to hold back any longer, you groan and release a thick torrent of cum—Jolene eagerly swallowing the first several pulses before letting the rest glaze her cleavage with a satisfied, sultry smile.");
			
			player.orgasm('Lips');
			doNext(camp.returnToCampUseOneHour);
		}

		private function joleneFucksPlayerVaginal():void {
			clearOutput();
			flags[kFLAGS.JOY_COCK_FONDNESS]++;
			outputText("Jolene lies back against the pillows, her " + joleneCockDescript() + " standing proud and throbbing against her stomach. She extends her hands to guide you atop her hips, her touch both gentle and commanding. \"<i>Come here, my love... let me feel you around me,</i>\" she whispers.\n\n");
			outputText("You straddle her waist and sink your [vagina] down onto her hot, " + Measurements.inchesOrCentimetres(joleneCockLength()) + " shaft. Jolene lets out a low, resonant groan, her nimble hands gripping your hips as she begins to thrust upward into you with powerful, measured strokes. Her martial stamina and flexibility make her an incredible lover; she sits up effortlessly to capture your lips in a fiery kiss and bury her face against your neck while rolling her hips deep inside you.\n\n");
			outputText("Feeling you clench around her in climax, Jolene holds you tight against her " + Appearance.breastCup(flags[kFLAGS.JOY_BREAST_SIZE]) + " breasts and groans into your ear as her " + joleneBallsDescript() + " tighten, pumping rope after thick rope of warm mouse-cum deep into your womb.");
			
			player.orgasm('Vaginal');
			doNext(camp.returnToCampUseOneHour);
		}

		private function joleneFucksPlayerAnal():void {
			clearOutput();
			flags[kFLAGS.JOY_COCK_FONDNESS]++;
			outputText("Jolene spoons up behind you on the bedding, her soft breasts pressed warmly against your shoulder blades and her throbbing " + joleneCockDescript() + " nestled against your [ass]. After carefully slicking your pucker and her shaft, she whispers tenderly into your ear, \"<i>Breathe with me, [name]... I have you.</i>\"\n\n");
			outputText("She eases her " + Measurements.inchesOrCentimetres(joleneCockLength()) + " length into your rear with patient, loving care before building into a deep, sensual rhythm. One of her hands wraps around your chest while the other strokes your groin in time with her thrusts, driving you both to a shuddering, simultaneous climax as she fills your depths with her hot seed.");
			
			player.orgasm('Anal');
			doNext(camp.returnToCampUseOneHour);
		}

		private function playerOralJoleneCock():void {
			clearOutput();
			flags[kFLAGS.JOY_COCK_FONDNESS]++;
			outputText("You settle between Jolene's parted thighs, taking her warm, throbbing " + joleneCockDescript() + " into your hand. Jolene props herself up on her elbows, biting her lower lip as you run your tongue from her " + joleneBallsDescript() + " all the way to her sensitive tip before taking her into your mouth.\n\n");
			outputText("\"<i>Oh, gods, [name]...</i>\" she breathes, her fingers gently tangling in your hair—never forcing your head, only caressing you affectionately as her hips rock in shallow, appreciative thrusts. Simultaneously, you slip two fingers into her slick " + jolenePussyDescript() + " beneath her balls, curling them against her inner walls until her whole body tenses and she cries out, filling your mouth with a rich, warm flood of her seed.");
			
			player.orgasm('Lips');
			doNext(camp.returnToCampUseOneHour);
		}

		private function playerEatJoleneOut():void {
			clearOutput();
			outputText("You ease Jolene back onto the furs and kiss your way down her stomach, past the lush swell of her " + Appearance.breastCup(flags[kFLAGS.JOY_BREAST_SIZE]) + " breasts, until your lips meet the warm, glistening folds of her " + jolenePussyDescript() + ". Jolene inhales sharply, her long tail curling around your shoulder as you part her petals with your tongue.\n\n");
			outputText("With her mind clear and present, she is exquisitely sensitive to every flick and caress. She moans your name in her smooth alto voice, her thighs trembling against your ears as you ease two fingers inside her velvety channel while lavishing attention on her pearl. Within minutes, her back arches off the cushions in a breathtaking climax, her inner walls pulsing around your fingers" + joleneHasCockText(" as her " + joleneCockDescript() + " spurts ribbons of cum across her stomach") + " before she pulls you up into a tender, breathless embrace.");
			
			player.orgasm('Lips');
			doNext(camp.returnToCampUseOneHour);
		}

		//------------
		// PREGNANCY UPDATES & BIRTH (HOOKED INTO JOJO'S PREGNANCY STORE)
		//------------
		public function jolenePregnancyUpdate():Boolean {
			switch (pregnancy.event) {
				case 2:
					outputText("\n<b>During your quiet morning meal, Jolene smiles serenely and guides your hand to her stomach, which feels warm and subtly rounded. \"<i>It seems our love has borne fruit, [name],</i>\" she tells you happily. \"<i>I can sense new life growing within me.</i>\"</b>\n");
					return true;
				case 3:
					outputText("\n<b>Jolene's pregnant belly has grown noticeably rounder, her tailored robes parted gracefully around her swelling womb. She carries the extra weight with poised, maternal pride.</b>\n");
					return true;
				case 4:
					outputText("\n<b>Jolene is now heavily pregnant, her furred belly full and lively with the kicks of your unborn children. \"<i>It won't be much longer now, my love,</i>\" she murmurs, resting her hands on her tummy.</b>\n");
					return true;
				case 5:
					joleneGivesBirth();
					return true;
				default:
					return false;
			}
		}

		public function joleneGivesBirth():void {
			clearOutput();
			spriteSelect(SpriteDb.s_joy);
			flags[kFLAGS.JOY_TWINS_BIRTHED]++;
			pregnancy.knockUpForce(); // Clear pregnancy
			
			outputText("Jolene calls out to you from her tent in a calm but urgent voice. When you rush inside, you find her reclining on fresh linens, breathing in deep, rhythmic meditative breaths as contractions ripple across her heavily pregnant belly.\n\n");
			outputText("\"<i>It is time, [name]. Stay with me and hold my hand,</i>\" she gasps softly, squeezing your fingers as she focuses her monastic control on bringing your children into the world. With admirable composure and strength, she pushes through the labor until the soft, healthy squeaks of newborn twin mouse-morphs fill the tent.\n\n");
			outputText("Tears of pure joy glisten in Jolene's bright blue eyes as she cradles the two tiny bundles against her " + Appearance.breastCup(flags[kFLAGS.JOY_BREAST_SIZE]) + " breasts, letting them nurse warmly. \"<i>Look at them, my love... they are perfect,</i>\" she whispers, leaning her head against your shoulder.\n\n");
			outputText("Over the next few days, once the twins are strong enough to travel, Jolene arranges for trusted brethren from her old monastery to escort them to the mountain sanctuary where they will be raised in safety—before returning to your side in camp, her heart fuller than ever.");
			doNext(camp.returnToCampUseOneHour);
		}
	}
}