package classes.Scenes.Areas.Desert
{
	import classes.*;
	import classes.internals.WeightedDrop;

	public class CumWitch extends Monster
	{
		public function cumWitchAI():void {
			//Hurt!
			if (HPRatio() < .6 && fatigue <= 90) {
				sandWitchCuntHeals();
				return;
			}
			
			var choices:Array = [];
			
			//Dicks only
			if (player.hasCock()) choices[choices.length] = cumMagicAttack;
			choices[choices.length] = bukkakeAttack;
			choices[choices.length] = cocknosisAttack;
			if (findStatusEffect(StatusEffects.Shell) < 0) {
				choices[choices.length] = shellDefense;
				choices[choices.length] = shellDefense;
				choices[choices.length] = shellDefense;
			}
			//HERMS
			if (player.gender == 3) choices[choices.length] = genderConfusionAttack;
			//VAGOOZLES
			if (player.hasVagina()) choices[choices.length] = cumHungerAttack;
			choices[rand(choices.length)]();
		}
		
		//*Attack: Bukkake
		public function bukkakeAttack():void {
			//*Cum Witch hikes up her dress and bukkake's at PC.  Large # of chance for 'hits' for low individual damage.  Small reduction to sand witch lust.  Used more at high lust.
			outputText("The Cum Witch moans and daintily peels her robes away from her swollen cock-flesh.  A bubble of precum pops wetly from her urethra to splatter on the floor as her balls suddenly swell.  You look back up in time to see the telltale glow of magic surrounding her staff, but then she's thrusting her hips at you, lewdly humping the air as she unleashes rope after thick rope of potent jism in your direction!\n");
			var hits:int = 5 + rand(8);
			var bonus:int = 0;
			var damage:int = 0;
			while (hits > 0) {
				var evade:String = player.getEvasionReason();
				//Evade
				if (evade == EVASION_EVADE) outputText("\nYou roll away from some of the hermaphrodite spunk, easily evading it.");
				//Misdirect
				else if (evade == EVASION_MISDIRECTION) outputText("\nYou feint one direction and then move another, misdirecting like a pro and avoiding some of the sexual artillery.");
				//Flexibility
				else if (evade == EVASION_FLEXIBILITY) outputText("\nYou twist aside, making the most of your cat-like reflexes to avoid some of the stuff.");
				else if (evade == EVASION_SPEED || evade != null) { // failsafe
					//Miss1
					if (rand(3) == 0) outputText("\nA glob of her goo goes wide, over your shoulder!");
					else if (rand(2) == 0) outputText("\nOne wave of alabaster falls short, to splatter at your [feet].");
					else outputText("\nSome of the Cum Witch's cum nearly hits you, but you manage to step aside.");
				}
				//Dragon-shell shield
				else if (player.shield == game.shields.DRGNSHL && rand(2) == 0) outputText("\nYou ready your dragon-shell shield, letting the futa-cum hit your shield. Within a short span of time, the cum is absorbed into your shield.");
				else {
					var temp:Number = rand(5);
					//Hit1
					if (temp == 0) outputText("\nA mass of jizz splatters into your [hair], soaking it with thick, salty goo.");
					else if (temp == 1) outputText("\nOne jet of thick witch-cum hits you in the [chest] before you can react.  You can feel it getting inside your [armor], squishing and sliding over your [nipples] as you try to fight.");
					else if (temp == 2) outputText("\nSome of the stuff spatters off your arm and soaks your hand, making it a slimy mess.");
					else if (temp == 3) outputText("\nA creamy deluge hits your [legs], though rather than running down, it seems to come up, flowing into your [armor] to squish wetly across your sensitive groin.");
					else {
						outputText("\nSpunk nearly blinds you as the Cum Witch's virile fluids take you in the face.  You spit some of it out, the smell of the stuff making your head swim.");
						//bonus damage!
						bonus = 3;
					}
					damage+= 2;
				}
				hits--;
			}
			game.dynStats("lus", damage+bonus);
			combatRoundOver();
		}

		//*Attack: Cum Magic
		public function cumMagicAttack():void {
			//*Used on males only, casts spell that causes balls to temporarily swell and increase lust by a moderate amount.  Unavoidable.
			outputText("Gesticulating with her free hand, the Cum Witch utters impossible to pronounce words before closing her fingers tightly into a fist.  That same instant, you feel an onset of warmth in your [balls], a spreading heat that makes you tremble with growing lust.  A second later, [eachCock] is throbbing, and a runner of cum trickles from the [cockHead], a hint of your temporarily-enhanced virility.");
			//(15-30 lust, based on libido)
			game.dynStats("lus", 5+player.lib/12);
			player.hoursSinceCum += 100;
			combatRoundOver();
		}
		//*Attack: Cum Hunger
		//*Used on vagoozles, spell that causes womb to literally thirst for sperm.  Unavoidable moderate lust gain.  Pregnant character's are immune.
		public function cumHungerAttack():void {
			outputText("Moaning luridly, the Cum Witch swivels her staff and opens her hand to spread her fingers wide.  At the same time, you feel her magic slam into your midsection, burrowing into your womb.  ");
			if (player.pregnancyIncubation > 0) {
				outputText("Yet, whatever she tries to do fails, as her otherworldly conjuration falls apart as soon as soon as it reaches you.");
				combatRoundOver();
				return;
			}
			outputText("It worms around your uterus, tickling it faintly before gently kneading your ovaries.  Your [legs] go weak as your womb throbs, hungering for something to fill it.  A trickle of wetness squirts from your [vagina] as the magic fades, and you squirm as your lust rises. If only something would make you pregnant!  Your eyes dart unbidden to the Witch's groin before you yank them away.");
			game.dynStats("lus", 5+player.lib/12);
			combatRoundOver();
		}

		//*Attack: Gender Confusion
		public function genderConfusionAttack():void {
			//*Used on genderless and hermaphrodite characters.  Mental attack that draws on disharmony with standard gender types to stun for one round.  3 turn cooldown
			outputText("Touching her alabaster staff to her brow, just under the brim of her hat, the Cum Witch makes a brief incantation and fixes you with her gaze.  Her eyes flash blindingly white, and then you feel her inside you, rifling through your memories, digging up memories of your childhood, your past, and throwing them against you.  ");
			if (player.inte/5 + rand(20) + player.level/2 < 18) {
				outputText("She batters your consciousness with conflicting memories of your gender, utterly dazing you.  How can you fight when you can barely tell who you are anymore?");
				player.createStatusEffect(StatusEffects.Confusion,0,0,0,0);
			}
			else {
				outputText("You parse the flood of information with mental focus and expel the intruder from your mind with a clenching of your sizable intellect.");
			}
			combatRoundOver();
		}
		//*Attack: Shell
		public function shellDefense():void {
			//*Grants immunity to all magic-based attacks for the next two turns.
			outputText("The Cum Witch holds her staff in both hands and rotates it in a circle, chanting all the while.  Her voice rises in pitch and intensity until she's screaming out unwords of power.  With one final cry, she slams her staff down into the ground hard enough to kick up a puff of sandy dust.  It quickly settles, but the Cum Witch has some kind of glittering, reflective shield around herself now!");
			createStatusEffect(StatusEffects.Shell,3,0,0,0);
			combatRoundOver();
		}

		//*Attack: Cocknosis
		//*Intelligence dependant attack with possibility of very high lust gain.
		public function cocknosisAttack():void {
			outputText("Lifting her robes enticingly, the Cum Witch reveals her ");
			if (lust < 50) outputText("half-hard");
			else if (lust < 70) outputText("hard");
			else if (lust < 85) outputText("throbbing");
			else outputText("hard, dripping");
			outputText(" cock.  She gently begins to sway her hips, bouncing back and forth with near-mechanical precision, her softly bobbing cock catching your eyes with its metronome-like precision.  She softly begins to speak, enunciating each word to the time and tune of her movements.");
			
			outputText("\n\n\"<i>See my cock?  See the glistening thickness of it?  Watch how it sways and bobs for you, moving with such smooth and easy grace.  Can you feel your eyes following it, locking onto it and never letting go?</i>\"\n\n");
			
			if (player.inte/20 + rand(20) >= 13) {
				outputText("You chuckle at her crude attempt to hypnotize you with her member.  She stomps her foot in irritation and drops her robes back into place.");
			}
			else {
				outputText("The Witch smirks, though you're too focused on her cock to see, and she continues, \"<i>Good " + player.mf("boy","girl") + ".  Watch it sway.  You're so focused on my cock now that the world is just falling away around it, sinking into nothingness, leaving only that wonderful cock behind for you to watch.  And since it's filling your view, you can feel it filling your mind as well, can't you?</i>\"");
				outputText("\n\nYou nod, your view rigidly attached to her equally rigid tool as you utterly and completely fixate on her penis, admiring its curves, its thickness, and the way it seems to pulsate happily for you whenever you look at it just right.  The Witch keeps talking, but it's her dick that's important.  You start to drool as your " + player.skin() + " flushes and your body heats.  Gods, her cock is gorgeous.  Reaching down, you begin to masturbate without thinking.  You don't know why, but it just feels like the right thing to do.");
				game.dynStats("lus", 20);
				if (player.lust <= 99) outputText("\n\nYou bump against something, startling yourself out of the cocknosis before you can completely fall for it.  Still, you keep seeing her dick every time you close your eyes, and your body is very turned on from how you were touching yourself.");
				else outputText("\n\nYou play with yourself until you're on the very edge of orgasm.  At that moment, a loud *SNAP* startles you back to wakefulness, and as you look down at the cock bobbing just a few inches away, you realize it's hopeless.  You can't fight this.");
				outputText("\n\nThe witch smiles knowingly.");
			}
			combatRoundOver();
		}

		//*Attack: Heal
		//*Restores one third of her HP.
		public function sandWitchCuntHeals():void {
			outputText("The Witch smirks at you and holds her free hand under her robes.  When she pulls it out, you realize she's gathered a handful of her cum.  She holds it up and exhales over it, the air making a slight whistle as it blows through her parted lips.  The ebony sorceress then smears the goop over her wounds, which seem to drink in the cum and vanish before your eyes.  She scolds, \"<i>Physical damage?  How artless.</i>\"");
			addHP(eMaxHP()*0.33);
			fatigue += 10;
			combatRoundOver();
		}
		
		override protected function performCombatAction():void
		{
			cumWitchAI();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.dungeons.desertcave.cumWitchDefeated();
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.dungeons.desertcave.defeatedByCumWitch();
		}
		
		public function CumWitch()
		{
			this.a = "the ";
			this.short = "Cum Witch";
			this.imageName = "cumwitch";
			this.long = "The Cum Witch is a moderately tall woman, almost six feet in height.  Her dark ebony skin is nearly as black as pitch, though it glitters with sweat from her recent sexual activities and the fight.  She has plump lips and long, smooth blonde hair, though much of it is hidden behind a pointed, wide-brimmed hat.  Her robes are even blacker than she is, but she wields an alabaster staff that fairly sizzles with magical might.  Of course, her garments don't do much to conceal her gigantic breasts.  Though there are only two, they're large enough to dwarf the four tits most sand witches are packing.";
			// this.plural = false;
			this.createCock(12,2,CockTypesEnum.HUMAN);
			this.balls = 0;
			this.ballSize = 0;
			this.cumMultiplier = 3;
			this.hoursSinceCum = 20;
			this.createVagina(false, VAGINA_WETNESS_WET, VAGINA_LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = rand(12) + 55;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "black";
			this.hairColor = "sandy-blonde";
			this.hairLength = 15;
			initStrTouSpeInte(35, 35, 35, 85);
			initLibSensCor(55, 40, 30);
			this.weaponName = "fists";
			this.weaponVerb="punches";
			this.armorName = "robes";
			this.bonusHP = 100;
			this.lust = 30;
			this.lustVuln = .8;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 6;
			this.gems = rand(15) + 5;
			this.drop = new WeightedDrop().addMany(1,
					consumables.TSCROLL,
					consumables.OVIELIX,
					consumables.LACTAID,
					consumables.LABOVA_,
					consumables.W__BOOK,
					consumables.B__BOOK,
					null);
			checkMonster();
		}
		
	}

}