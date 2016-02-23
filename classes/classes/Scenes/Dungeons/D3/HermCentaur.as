package classes.Scenes.Dungeons.D3 
{
	import classes.Monster;
	import classes.Appearance;
	import classes.StatusEffects;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class HermCentaur extends Monster
	{
		
		public function HermCentaur() 
		{
			this.a = "the ";
			this.short = "herm centaur";
			this.imageName = "hermcentaur";
			this.long = "Standing tall and proud just a few feet away is a massive demon unlike any others you've seen.  She's every bit a centaur - horse body, hooves, fur, and everything, but she's also massive in proportion - about nine feet tall and equally well endowed.  Heaving, jiggly E-cups jut proudly from her chest, unrestrained and bare to the world, thick nipples capping them like majestic, sexual crowns.  Under her belly, a thick equine cock slaps wetly against her fur with every step, heavy balls dangling behind.  A solid black horn juts from her forehead, a testament to the demonic corruption flowing through this monstrous woman's veins.  Still, without the horn, you'd never have guessed she was a demon.  Her gleaming fire-orange hair and pale, freckled skin look like something you would see on an innocent maid, not a bestial altar of corrupted decadence.";
			
			this.tallness = 12 * 9;
			
			// THIS SHIT IS RETARDED.
			// Rather than doing something smart, like usiing the mf() function to set the gender prounouns in checkMonster, instead, each create<x> function sets them to something. So if you createVag then createCock, you get male pronouns. Fuck off.
			this.createBreastRow(Appearance.breastCupInverse("E"));
			this.createCock(36, 5, CockTypesEnum.HORSE);
			this.createVagina(false, 4, 5); 
			
			
			this.balls = 2;
			this.ballSize = 3;
			
			this.hipRating = HIP_RATING_FERTILE;
			this.buttRating = BUTT_RATING_EXPANSIVE;
			
			initStrTouSpeInte(100, 100, 65, 65);
			initLibSensCor(85, 40, 100);
			
			this.weaponName = "fists";
			this.weaponAttack = 1;
			this.weaponVerb = "punch";
			this.armorName = "wraps";
			
			this.bonusHP = 800;
			
			this.gems = 75 + rand(50);
			this.level = 22;
			
			this.lustVuln = 0.6;
			
			this.drop = NO_DROP;
			
			this.checkMonster();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.d3.hermCentaur.beatThePony(hpVictory);
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.d3.hermCentaur.inSovietCoCPonyRidesYou(hpVictory, pcCameWorms);
		}
		
		// Gonna handle this a little differently than usual.
		// This is one of the advantages of containing monster detail in this manner, and encapsulating the
		// combat implemenation thereof with it- we can easily make use of the object to store things
		// we would normally use StatusEffects for, in instances where the only thing that will care 
		// about those Affects are the user/consumer of them.
		
		private var _usedGottaCum:Boolean = false;
		private var _usedHeal:Boolean = false;
		
		private var _chargingArouse:Boolean = false;
		private var _lustAtChargeStart:Number = -1;
		private var _arouseCooldown:int = 0;
		
		private var _hypnoCockUses:int = 0;
		
		override protected function performCombatAction():void
		{
			_arouseCooldown--;
			
			// Priority use
			if (_chargingArouse) arouseSpellCast();
			else if (this.lust >= 60 && !_usedGottaCum) gottaCum();
			else if (this.HPRatio() <= 0.5 && !_usedHeal) healUp();
			else if (rand(lust) >= 40) this.hypnoCock();
			else
			{	
				// Selections
				var opts:Array = [feminineMusk, aphrodisiacSquirt];
				if (!_chargingArouse && _arouseCooldown <= 0) opts.push(arouseSpellCharge);
				
				opts[rand(opts.length)]();
			}
			
			combatRoundOver();
		}
		
		private function feminineMusk():void
		{
			outputText("Turning about, the demonic centauress lifts her tail to reveal the slimy, lubricated lips of her puffy, black horse-cunt.  She arches her human body back to lie on her back, an incredible show of flexibility, allowing you to view the silhouette of her jutting nipples her tail lazily fans her corruption-enhanced pheromones in your direction.  The air temperature seems to spike by a few degrees as the fan of biological lust washes over you.  Fragrant female moisture seems to seep into your very pores, and in spite of your desire to win out, ");
			
			if (player.lust <= 50) outputText(" your " + player.skin() + " grows feverishly hot.");
			else 
			{
				outputText(" blood rushes to your loins, invigorating");
				if (player.hasCock()) outputText(" [eachCock] with the desire to plunge inside that juicy-hot hole.");
				else if (player.hasVagina()) outputText(" your [vagina] with the desire to submit while juices pool between your [legs].");
				else outputText(" your anus until it puckers, craving something to fill it - anything.");
			}
			
			game.dynStats("lus+", 8 + (player.lib / 10) + (player.sens / 10));
		}
		
		private function aphrodisiacSquirt():void
		{
			outputText("The centaur grabs her heavy tits and casually squeezes the prodding, hard nipples that cap them.  A trickle of rose moisture trickles out, dripping down the underside of her bust to glisten wetly in the light.  Spellbound for the moment, you look on in wonder at the display of demonic lactations.  A faint sweetness lingers in the air, and you lick your lips without meaning to.  Then, she squeezes down to spray a torrent of pink-tinged breastmilk directly at you, splitting into so many forks of fluid that you have no hope to dodge.");
			
			game.dynStats("lus+", 8 + (player.lib / 10) + (player.sens / 10));

	if (player.lust < 30) outputText("\n\nYou close your mouth tight and endure the shimmering shower, trying your damnedest to resist the effects of this insidious liquid.  Wherever it strikes you, it vanishes soon after, absorbed directly into your body.");
	else if (player.lust < 40) outputText("\n\nYour heart beats faster.");
	else if (player.lust < 50) outputText("\n\nYour cheeks color as you try not to imagine how you could fuck such a beast.");
	else if (player.lust < 60) outputText("\n\nYour blink, but find your eyes staying closed a moment longer than you intended, visions of yourself suckling down the pink sweetness occupying your mind.");
	else if (player.lust < 70) 
	{
		outputText("\n\nYou groan in disappointment when you realize what's going to happen, but as soon as you're slicked with the aphrodisiac,");
		if (player.hasCock()) outputText(" [eachCock] awakens, filling itself towards full erection.");
		else if (player.hasVagina()) outputText(" a wet heat answers in your loins, growing more insistent from moment to moment.");
		else outputText(" your [asshole] tingles, craving something to fill it.");
	}
	else if (player.lust < 80) 
	{
		outputText("\n\nYou sigh and try to gain a better position during the pink rain");
		if (player.hasCock()) outputText(" ignoring the stiffening pressure of [eachCock]");
		else outputText(" ignoring the increasing wetness of your inner [armor]");
		outputText(". It's getting harder to think straight with all this desire welling up inside you.  It isn't for a few moments that you realize you tongue is hanging out and drooling all over youself.  Gods, you want to fuck!");
	}
	else if (player.lust < 90)
	{
		outputText("\n\nPanting feverishly, you try to ignore the blush-colored downfall, but it's a futile gesture.  It makes your " + player.skinFurScales() + " burn hot, wicking inside you with devilish efficiency to stoke the fires of your lust beyond normal limits.");
		if (player.hasCock()) outputText("  Pre begins to dribble from your hot-and-ready cum-slit, eager to pour out in a deluge of sperm.");
		else if (player.hasVagina()) outputText("  A flood of sopping moisture dribbles down your [legs], the proof of your unholy desire to breed.");
		outputText(" You NEED to fuck soon.  You can barely contain yourself!");
	}
	else if (player.lust < 100) outputText("\n\nMoaning out loud, you smear the stuff across your [chest] as it sprinkles you, the mounting desire almost at your limit.  You want to touch yourself SO BADLY, but you know that if you do, you'll wind up a mare to this centaur, perhaps forever.  You have to resist!  You can't fall victim to this... alluring creature.");
	else outputText(" Sinking to your knees, you start trying to tear your way out of your [armor].  You don't care about winning anymore - fucking this woman... this beast... that's all that matters.  You don't care how she takes you, as long as you get to cum all over her!");
	
		}
		
		private function arouseSpellCharge():void
		{
			// one turn charge-up, can be interrupted by tease
			outputText("The centauress closes her eyes for a moment, then opens them.  Her eyes have gone completely, solidly black.  She's chanting low, though you see her dick bobbing beneath her in time with the mysterious utterances, leaking pre-cum.  You've got to stop her!");
			if (player.inte > 80) outputText("  A tease attack would likely be the most effective method of attack.");
			
			_chargingArouse = true;
			_lustAtChargeStart = this.lust;
			_arouseCooldown = 7;
		}
		
		private function arouseSpellCast():void
		{
			_chargingArouse = false;
			_lustAtChargeStart = -1;
			
			if (this.lust >= this._lustAtChargeStart + 10)
			{
				//(Interrupted)
				outputText("Shuddering, the demoness stumbles over her words, and a flash of ruby light envelops her form!  A low, lurid moan escapes the crimson-fogged outline, echoing with lust beyond measure as its owner's spell backfires on her.  Ropes of pre as thick as most men's cum-shots splatter into the grass and cobble while the herm's balls seem to double in size.  Even then, the heavy male orbs shine dully, absolutely soaked with dripping mare-lube.");
			}
			else
			{
				//(OH SHIT YOU GUNNA GET FUKKED)
				outputText("The chanting reaches a crescendo before you can stop it, and as the nine-foot woman points at you, you barely have time to enunciate a single curse.  Her spell is upon you.  There's a flash of crimson light, seemingly as bright as the sun, and then you're hit with a wave of lust so strong it might as well be a physical force.  It slaps you hard enough to send you reeling, even while your heart pumps every spare drop of blood south.  You cry out at the forced arousal, blubbering wildly as the pleasure mounts and images of you and your foe locked together in every sexual position imaginable flood your consciousness.");
				
				game.dynStats("lus+", 20 + (player.lib / 6) + (player.sens / 6));
			}
		}
		
		private function hypnoCock():void
		{
			_hypnoCockUses++;
			
			if (_hypnoCockUses == 1)
			{
				outputText("THWACK! You start at the odd noise - neither of you were making contact with the other.  THWACKschlorp!  This time a ludicrously wet sound punctuates the noise.  The demonic centaur is smiling widely, her cheeks flushing slightly as the audible noises continue, each time deepening her blush.  What the hell?  TWHACKschhhlick!");
				outputText("\n\nYou glance lower in time to see her member slowly stretching away from her equine underside, seemingly held by thick strands of her heavy pre.  Only when it's hanging low enough for the shiny webs to snap does it move, surging upward with fresh lust to slap against her belly, spattering globules of pre-cum over the furry flesh.  There's a steady, undeniable tempo to it - every impact seems to follow the same hidden beat as the one before, echoing through the courtyard and into your vulnerable ears.");
				outputText("\n\nOnly after watching spellbound for a few moments do you realize that the demoness has begun to talk, speaking in low whispers, \"<i>Hard to look away isn't it?  I've been told it can be quite hypnotic... almost... spell-binding.</i>\"");
				outputText("\n\nWell, you can see that for yourself.  It's easy to watch it slowly lower, then smack up, ejecting a heavy load of pre-orgasmic fuck-juice.  You've got to look at her while you fight her anyway, so you don't mind that you're looking there.  You can keep an eye where she's most vulnerable.");
			}
			else
			{
				outputText("THWACK!  She's started thumping her cock against her belly again, and you look for the source of the noise again without thinking, spotting her turgid horse-cock just soon enough to watch it thump into her belly, a drizzle of pre running across its hard underside.  It slowly lowers, then rises again, slamming itself against her jizz-moistened underset with a wet slap.  The tempo is as steady and rhythmic as before, and the demon's voice doesn't help.");
				outputText("\n\n\"<i>Yes, your eyes do seem to lock onto it, don't they?  They see my hard cock and they have such a hard time doing anything but watching it, letting it fill their view entirely,</i>\" she muses quietly.");
				outputText("\n\nYes... it's quite mesmerizing.  You try to look up, but that cock just seems to slap itself right back into your view, the echo of the impact rattling around your skull.  The sultry centaur muses, \"<i>I can see you're quite taken with it.  Surely there's no harm in relaxing to watch it, is there?</i>\"");
			}

			// Resistance-esque check, idk I threw this terrible shit together
			if (player.inte * (2 / _hypnoCockUses) > rand((player.lib / 3) + (player.sens / 3) + (player.cor / 3)))
			{
				game.dynStats("lus+", 2 + rand((player.lib / 20) + (player.sens / 20)));
				
				if (player.lust <= 33) outputText("\n\nA warning thought jars you out of the cock-induced reverie with a start - this demon was going to hypnotize you, likely trying to seduce you into submission.  Not this time!  You tear yourself away and look her in the eye triumphantly.");
				else if (player.lust <= 66) outputText("\n\nA quiet voice pipes up somewhere inside you and warns that something is amiss.  It's enough to stir you from your stupor, kindling your willpower to wrest your view from your foe's gently bobbing fuck-log.  You look her in the eye triumphantly.");
				else outputText("\n\nA simpering voice begs you to look away from the deliciously-throbbing fuck-stick before you, but you nearly ignore it.  That fat cock looks so goddamn good - so hypnotic as it bounces and dances before you, enthralling you.  No!  You jerk your gaze up to look the demon in the eyes and frown when you see her gloating.  You might be primed to fuck, but you won't fall for her tricks this time!");
			}
			else
			{
				game.dynStats("lus+", 20 + 2 * _hypnoCockUses + 2 + rand((player.lib / 10) + (player.sens / 10)));
				
				outputText("Down it bobs, slowly hanging lower and lower... SMACK!  Up it goes, taking your bedazzled eyes along for the ride.  \"<i>That's a good " + player.mf("boy", "girl") + ",</i>\" the dick's director whispers, \"<i>Just follow the tempo and let it fill your mind, oozing inside you with each thump.</i>\"");
				outputText("\n\nFuck!  She's right, it's getting awfully hard to think about anything else.  You fixate further on the cock, unwilling or unable to look away.");
				outputText("\n\n\"<i>It's so easy to just watch and let your thoughts leak out of your head?</i>\" the voice asks.");
				outputText("\n\nYou nod.");
				outputText("\n\n\"<i>Each pendulous motion, every movement, it's so sexy, isn't it?</i>\"");
				outputText("\n\nAgain, you nod.");
				outputText("\n\nThe voice continues, \"<i>Every pulse, every sloppy discharge, every throb... they're all so sexy, so wet and hot.  The harder you watch, the more arousing it gets... the more you want to touch it.</i>\"");
				outputText("\n\nGods, you want to touch it.  One of the rigid veins pulsates, and you want to caress it so badly, to feel it twitch in your hand and drip all over you.  It looks so good, so powerful and lusty.  It's making you so horny just looking at it.  How would it feel to fuck it?  To ride it?  To bend over and present yourself to be willingly impaled?");
	
				if (player.lust >= player.maxLust()) outputText("\n\nYou whimper, too horny to care anymore.  You moan in anticipation when you realize she's going to breed you...");
				else
				{
					outputText("You stumble forward, the movement actually startling you from your lusty haze.  It's just what you need to free yourself from the unholy compulsion, and you ready yourself anew to take down this troublesome foe.  Still, your gaze keeps flicking down.  You'll have a harder time fighting off any similar teases...");
					outputText("\n\n\"<i>Let's see the mighty 'Champion' resist me now,</i>\" the equine demon taunts, finally stopping her phallus's troublesome motion.");
				}
			}
		}
		
		private function gottaCum():void
		{
			_usedGottaCum = true;
			outputText("Sighing, the demoness gives you a lust glare and idly stomps at the ground with a hoof.  \"<i>Stop turning-unf-on you... you stupid... sexy...ungh, DAMNIT!</i>\" she protests, her rigid cock, slapping her belly while streamers of lady-jizz drip down the gleaming orbs that fill her black-skinned ballsack.  The centaur paws at her tits with unrepentant lust, tugging her large, hard nipples mercilessly while her hind legs stutter around, probably only moving in order to grind the thick, female lips together that much harder.");
			
			outputText("\n\nThe corruption-fouled, fair-skinned creature coos breathily, \"<i>Now you've got to watch me cum, Champion.</i>\"");
			
			outputText("\n\nHundreds of pounds of monstrous, equine bulk shift and contort, her body violently clenching with bliss as her cock flares, rigid beneath her belly.  She moans and dribbles pink milk from her hard nipples as her pussy explodes, releasing a torrent of slimy lady-spunk that splashes in the grass between her hooves, flooding the air with her scent.  A second later, her fully-dilated cockhead trembles, the moist cum-slit opening wide.  A surge of white bursts from that narrow hole, spattering over the cobbles in a messy tide, flooding the air with salty jizz-smell.  Quaking, her cum-inflated nuts slowly shrink with each spray of spunk until they're barely the size of large apples.");
			
			outputText("\n\nFlushing, the demoness whimpers, \"<i>...don't think I can do that again, but I don't think you'll be able to turn me on like that twice!</i>\"");
			
			this.lust = 0;
			game.dynStats("lus", 15);
		}
		
		private function healUp():void
		{
			_usedHeal = true;
			
			outputText("Wiping a drop of blood from her wounds, the demon frowns in irritation.  \"<i>Do you have any idea how hard healing spells are to pull off when you're thinking about plowing a champion from behind?</i>\"  Her eyes flutter closed in concentration while sexual fluids run unimpeded from her mixed genitals.  At the same time, her wounds close up, covered with freshly grown horsehair or pale pink skin.  A few moments later, she wobbles slightly and mutters, \"<i>All better... hopefully you don't manage that twice.  I doubt I could pull it off again.  Then again, you'll likely be hilted on my dick or tongue-deep in my snatch by then, won't you?</i>\"");
			
			this.HP = this.eMaxHP();
		}
		
	}

}