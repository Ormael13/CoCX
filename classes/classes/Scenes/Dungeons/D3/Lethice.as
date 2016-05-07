package classes.Scenes.Dungeons.D3
{
	import classes.Monster;
	import classes.StatusEffects;
	import classes.GlobalFlags.kFLAGS;
	import classes.PerkLib;
	
	public class Lethice extends Monster
	{
		//LAST_ATTACK_TYPE
		//0 - Regular & physical special
		//1 - Bow
		//2 - Spells
		//3 - Teases
		//4 - ???
		
		private var _roundCount:int = 0;
		
		private var _fightPhase:int = 1;
		
		private var _wingsDestroyed:Boolean = false;
		
		private var _defMode:int = 0;
		
		public function Lethice()
		{
			super();
			this.a = "";
			this.short = "Lethice";
			this.long = "";
			this.tallness = 12 * 9;
			this.createVagina(false,3,3);
			this.createBreastRow(8);
			this.balls = 2;
			this.ballSize = 4;
			this.hipRating = HIP_RATING_SLENDER;
			this.buttRating = BUTT_RATING_TIGHT;
			initStrTouSpeInte(110, 110, 110, 110);
			initLibSensCor(100, 40, 100);
			this.weaponName = "whip";
			this.weaponAttack = 25;
			this.weaponVerb = "whip";
			this.armorName = "wraps";
			this.armorDef = 15;	
			if (player.newGamePlusMod() >= 3) {
				this.armorName = "lethicite armor";
				this.armorDef += 30;
			}
			this.bonusHP = 650;
			this.bonusLust = 80;
			this.additionalXP = 1000;
			this.gems = 500 + rand(50);
			this.level = 25;
			this.lustVuln = 0.15;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.Tank, 0, 0, 0, 0);
			this.createPerk(PerkLib.Tank2, 0, 0, 0, 0);
			this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
			this.checkMonster();
		}
		
		override public function get long():String
		{
			var str:* = "";
			if (_fightPhase == 1) {
				str += "Lethice is the epitome of all things demonic. From her luxurious purple hair, interwoven with black roses, to her pink skin and goat-like horns, she is the perfect image of sensual, enticing corruption. Tall heels of bone complement her revealing"; 
				if (armorName == "lethicite armor") //New Game+++ description
					str += ", pink armor. It appears to be made of lethicite; who knows how many souls were corrupted in order to create such strange armor? It covers Lethice from neck to toe and definitely gives her a lot of defense. The fact that it leaves her nipples and dripping cunt exposed adds to the lewdness of her otherwise-protective armor.";
				else
					str += ", black clothes. They look almost like a nun’s habit, but pared down to an almost fetishistic extreme. Her slim breasts provide just a hint of shape to the diaphanous fabric, a promise of feminine delights instead of the garish acres of flesh her outfit displays.";  
				str += " Outsized wings, like those of a dragon, hold Lethice aloft as she zips about her throne room, gathering her corruptive magics. The strangely slit pupils of her black-rimmed eyes never seem to leave you.";
			}
			else if (_fightPhase == 2) {
				str += "You're completely surrounded by demons! The members of Lethice's corrupted court have flooded the throne hall like a sea of tainted flesh, crushing in on you with the sheer weight of bodies being thrown against you. Incubi, succubi, and forms between and combining them all grasp and thrust at you, trying to overwhelm you with desire for their inhuman bodies and the unspeakable pleasures only demons command.";
				if (findStatusEffect(StatusEffects.Blind) >= 0)
				{
					str += " The demons have relented somewhat, clutching at their eyes and screaming in frustration and panic thanks to your potent spell!";
				}
				else if (findStatusEffect(StatusEffects.OnFire) >= 0)
				{
					str += " More than a few of the court are screaming in terror, rolling on the ground and trying desperately to put out the flames you've bathed them in! Turns out Marethian demons aren't all that immune to fire!";
				}
			}
			else {
				str += "Lethice is the epitome of all things demonic. From her luxurious purple hair, interwoven with black roses, to her pink skin and goat-like horns, she is the perfect image of sensual, enticing corruption. Tall heels of bone complement her revealing";
				if (armorName == "lethicite armor") //New Game+ description
					str += ", pink armor. It appears to be made of lethicite; who knows how many souls were corrupted in order to create such strange armor? It covers Lethice from neck to toe and definitely gives her a lot of defense. The fact that it leaves her nipples and dripping cunt exposed adds to the lewdness of her otherwise-protective armor.";
				else
					str += ", black clothes. They look almost like a nun’s habit, but pared down to an almost fetishistic extreme. Her slim breasts provide just a hint of shape to the diaphanous fabric, a promise of feminine delights instead of the garish acres of flesh her outfit displays.";  
				str += " Standing astride her throne";
				if (_wingsDestroyed)
				{
					str += ", her wings in tatters";
				}
				str += ", Lethice regards you with a snarl and a crack of her flaming whip. Her yellow-black eyes are wide with fury, the pointed tips of her teeth bared in a snarl. Gorged with lethicite, the enraged demon queen is determined to finish you. Her endurance can’t possible hold for too much longer. You can beat her!";
				if (_fightPhase == 3 && _defMode != 0)
				{
					if (_defMode == 1)
					{
						str += "\nLethice is standing ready for your next attack, ready to defend against any strike. Perhaps you could surprise her with something else?";
					}
					else if (_defMode == 2)
					{
						str += "\nLethice is smirking and confident, prepared to resist any sort of libidinous advance, but her posture is ill-suited to deflecting attacks.";
					}
				}
			}
			if (player.findStatusEffect(StatusEffects.LethicesRapeTentacles) >= 0)
			{
				str += "\n\n<b>A forest of black tentacles sprout from the floor, snaring any demons unlucky enough to venture close - or any champions unlucky enough to be in the center of it all.";
				if (player.statusEffectv3(StatusEffects.LethicesRapeTentacles) != 0)
				{
					outputText(" Unfortunately, they’ve grabbed you. You need to break free to do anything!");
				}
				if (player.findStatusEffect(StatusEffects.KnowsWhitefire) >= 0)
				{
					outputText(" A blast of white-fire could probably dispel them, or you could rely on your");
					if (player.canFly())
					{
						outputText(" flight");
					}
					else
					{
						outputText(" quickness");
					}
					outputText(" to stay safe. Either way, you’re free for now.");
				}
				outputText("</b>");
			}
			if (game.monster.findStatusEffect(StatusEffects.Shell) >= 0)
			{
				outputText("\n\n<b>Lethice is surrounded by a shimmering dome of magical energy. Spells and ranged attacks will be ineffective!</b>");
			}
			if (player.findStatusEffect(StatusEffects.PigbysHands) >= 0)
			{
				outputText("\n\nInvisible hands roam over your body, stroking you in ways that no one but a lover ever should. They won’t stop, and they won’t slow. You’ll have to try to ignore their arousing caresses.");
			}
			return str;
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (_fightPhase == 1)
			{
				phase1Ends(hpVictory);
				return;
			}
			if (_fightPhase == 2)
			{
				phase2Ends(hpVictory);
				return;
			}
			game.d3.lethice.defeated(hpVictory);
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.d3.lethice.won(hpVictory,pcCameWorms);
		}
		
		public function get fightPhase():int
		{
			return _fightPhase;
		}
		
		override protected function performCombatAction():void
		{
			_roundCount++;
			switch(_fightPhase)
			{
				case 1:
					phase1();
					break;
				case 2:
					phase2();
					break;
				case 3:
					phase3();
					break;
				default:
					phase1();
			}
			combatRoundOver();
		}
		
		private function phase1():void
		{
			var atks:Array = [demonicArouse,demonfire];
			if (_roundCount % 10 == 3)
			{
				atks.push(rapetacles);
			}
			if (player.findStatusEffect(StatusEffects.Blind) < 0)
			{
				atks.push(wingbuffet);
			}
			atks[rand(atks.length)]();
		}
		
		private function demonicArouse():void
		{
			outputText("Lethice’s hands blur in a familiar set of arcane motions, similar to the magical gestures you’ve seen from the imps. Hers are a thousand times more intricate. Her slender fingers move with all the precision of a master artist’s brush, wreathed in sparks of black energy.");
			var l:Number = player.lib / 10 + player.cor / 10 + 25;
			if (player.findStatusEffect(StatusEffects.MinotaurKingsTouch) >= 0)
			{
				l = l * 1.25;
			}
			game.dynStats("lus",l);
			if (player.lust <= 30)
			{
				outputText("\n\nYou feel strangely warm.");
			}
			else if (player.lust <= 60)
			{
				outputText("\n\nBlood rushes to your groin as a surge of arousal hits you, making your knees weak.");
			}
			else if (player.lust <= 75)
			{
				outputText("\n\nDespite the dire situation, your mind keeps filling with images of Lethice fully uncovered, her body poised just inches away. You can’t help but want her.");
			}
			else if (player.lust <= 90)
			{
				outputText("\n\nThe dark power forces ideas into your mind, thoughts of you on your knees, hands shackled behind you and your mistress’s perfect, pretty pussy in front of you, awaiting your tongue. You barely shake it off.");
			}
			else if (player.lust <= 100)
			{
				outputText("\n\nYour mind is filled with visions of lovely pussies, perfect tits, and one overriding emotion - submission. She’s making you want to give up and indulge in her tainted wiles, and the worst part is... you’re having a hard time coming up with a reason not to. You barely pull back from an all-consuming image of her slick, juicy snatch, shaking your head in wonderment. How can you possibly defeat her?");
			}
			else
			{
				outputText("You give yourself over to the alien imagery invading your mind, wallowing a dozen conflicting fantasies. In one, you’re tied to Lethice’s clit-piercing by a leash, lapping her spilled cunt-juice from the ground. In another, you’re begging her to let you tongue her asshole. Each is more perverse than the last, and they blend together into an endless tableau of submission.");
			}
		}
		
		private function rapetacles():void
		{
			outputText("Lethice gestures at the ground underfoot. A pulse of black mist rolls out around you for dozens of feet in every direction. The crowd of watching demons pulls back fearfully, save for a few foolish slaves who blithely step into the magic circle. A second later, hundreds of oily, black tentacles emerge from the floor, unspooling from whatever horrible dimension they were summoned from. They immediately attack every living creature within reach, wrapping around wrists and ankles, violating vaginas and assholes alike. They come at you from every direction!");
			if (player.canFly())
			{
				outputText("\n\nYou laugh as you fly out of their reach, immune to their touches.");
				player.createStatusEffect(StatusEffects.LethicesRapeTentacles,4 + rand(2),0,0,0);
			}
			else if (player.getEvasionRoll())
			{
				outputText("\n\nYou manage to sidestep the grasping tentacles with ease.");
				player.createStatusEffect(StatusEffects.LethicesRapeTentacles,4 + rand(2),0,0,0);
			}
			else
			{
				outputText("\n\nYou aren’t fast enough to avoid them. They yank your arms and [legs] taut. Some burrow under your [armor], crawling toward your most sensitive, forbidden places.");
				player.createStatusEffect(StatusEffects.LethicesRapeTentacles,4 + rand(2),0,1,0);
			}
		}
		
		public function dispellRapetacles():void
		{
			clearOutput();
			if (player.statusEffectv3(StatusEffects.LethicesRapeTentacles) == 0)
			{
				outputText("You raise your arm and");
			}
			else
			{
				outputText("You struggle and manage to raise your arm against the tight grasp of the tentacles, managing to");
			}
			outputText(" spray forth a torrent of white flame, burning the shadowy constructs away in the light of your pure, focused fire. In the span of seconds, Lethice’s spell is gone.");
			game.doNext(game.combat.combatMenu);
			player.changeFatigue(30,1);
			outputText("\n\n",false);
			flags[kFLAGS.SPELLS_CAST]++;
			game.combat.combatAbilities.spellPerkUnlock();
			game.statScreenRefresh();
			doAI();
		}
		
		private function demonfire():void
		{
			outputText("Lethice narrows her eyes, focusing her mind with deadly intent. She snaps her fingers and a gout of black, twisting flames engulfs you! ");
			var damage:Number = inte + rand(25) * (1 + (player.newGamePlusMod() * 0.3));
			damage = player.takeDamage(damage, true);
		}
		
		private function wingbuffet():void
		{
			outputText("Lethice flutters toward a burning brazier and flaps her wings, causing the flames to flare and thick gusts of smoke to flow past the assembled demons, straight at you!");
			if (player.getEvasionRoll())
			{
				outputText(" You manage to slide under the waves of smoke.");
			}
			else
			{
				outputText(" The cloying smoke gets in your eyes and your mouth, making you cough and sputter. Worst of all, you can’t see anything! ");
				player.createStatusEffect(StatusEffects.Blind,2,0,0,0);
				player.takeDamage(1, true);
			}
		}
		
		private function claw():void
		{
			outputText("Swooping low, the Demonic Queen takes a swipe at you with claws that are suddenly six inches long and as sharp as razors!");
			var damage:Number = str + weaponAttack - rand(player.tou);
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_SPEED || evade == EVASION_UNHINDERED)
			{
				outputText("You manage to dodge her slash!");
			}
			else if (evade == EVASION_MISDIRECTION)
			{
				outputText(" Misdirecting her with your movements, you avoid the swipe.");
			}
			else if (evade == EVASION_FLEXIBILITY)
			{
				outputText(" With your feline flexibility, you bend double to avoid the swipe.");
			}
			else if (evade == EVASION_EVADE)
			{
				outputText(" You evade her slash with a quick roll.");
			}
			else
			{
				if (damage <= 5)
					outputText(" She barely scratches you. She’ll need stronger weapons than that to take you down. ");
				else
					outputText(" Damn, that hurts! ");
				player.takeDamage(damage, true);
			}
		}
		
		public function grappleStruggle():void
		{
			clearOutput();
			outputText("You pull with all your might against the grasping tentacles to no avail; their grip is simply too strong!");
			doAI();
		}
		
		public function grappleWait():void
		{
			clearOutput();
			outputText("You can't bring yourself to fight back against Lethice's tentaclespawn. The sensuous, coiling grasp around your limbs, their questing, pliant tips digging around inside your [armor]... you relax in their grip for a little while longer, too enticed by their movement to struggle right now.");
			doAI();
		}
		
		private function phase1Ends(hpVictory:Boolean):void
		{
			clearOutput();
			if (hpVictory)
			{
				if (player.canFly())
				{
					outputText("Even held aloft by her sprawling dragon wings, Lethice can’t hide from your righteous wrath.");
					outputText(" Taking wing yourself, you slam into the demoness, striking a final blow that sends her toppling to the ground. She shrieks and spirals, crashing into the hard stone floor just before her throne.");
				}
				else if (flags[kFLAGS.LAST_ATTACK_TYPE] == 1)
				{
					outputText("Even held aloft by her sprawling dragon wings, Lethice can’t hide from your righteous wrath.");
					outputText(" You draw your bowstring and let loose one last arrow, sending the missile hurtling through the air - and right into Lethice’s wing! The Demon Queen lets out an ear-piercing shriek of pain and, with her wing flopping weakly beside her, goes tumbling to the earth! She’s down!");
				}
				else if (flags[kFLAGS.LAST_ATTACK_TYPE] == 2)
				{
					outputText("Unable to resist your arcane assault, Lethice lets loose a howl of frustration and swoops back to the earth, mounting her throne once again.");
				}
				else if (flags[kFLAGS.LAST_ATTACK_TYPE] == 4)
				{
					outputText("Even held aloft by her sprawling dragon wings, Lethice can’t hide from your righteous wrath.");
					outputText(" You draw your bowstring and let loose one last arrow, sending the missile hurtling through the air - and right into Lethice’s wing! The Demon Queen lets out an ear-piercing shriek of pain and, with her wing flopping weakly beside her, goes tumbling to the earth! She’s down!");
				}
			}
			else
			{
				outputText("Unable to resist your sensual assault, Lethice lets loose a howl of frustration and swoops back to the earth, mounting her throne once again.");
			}
			outputText("\n\n<i>“I tire of this game!”</i> she shouts, grasping at the arms of her towering throne. Suddenly, her gaze snaps from you, to the horde of demons clamoring in the stands. <i>“What are you waiting for, fools!? Get " + player.mf("him", "her") + "!”</i>");
			outputText("\n\nOh, shit. You look up in time to see a cavalcade of demonic flesh swooping down from on high, bodies practically tumbling one over the other to get at you. The horde takes every physical form imaginable: towering, hulking brutish males, inhumanly curvaceous succubi, and the reverse of both - not to mention hermaphrodites masculine and feminine - and all with every sort of transformation. Bestial creatures, dragon-like incubi, and succubi whose skins range the colors of the rainbow and so, so much more come piling down the throne hall in a ceaseless barrage of flesh and decadence. They won’t stop until they’ve dragged you to the ground and fucked you into submission!");
			HP = eMaxHP();
			lust = 10;
			_fightPhase = 2;
			a = "the ";
			short = "demons";
			plural = true;
			pronoun1 = "they";
			pronoun2 = "them";
			pronoun3 = "their";
			if (findStatusEffect(StatusEffects.PhysicalDisabled) >= 0)
			{
				removeStatusEffect(StatusEffects.PhysicalDisabled);
			}
			if (findStatusEffect(StatusEffects.AttackDisabled) >= 0)
			{
				removeStatusEffect(StatusEffects.AttackDisabled);
			}
			combatRoundOver();
		}
		
		private function phase2():void
		{
			var atks:Array = [demonLustMagic,dirtyDancing,hornyPoke,crushingBodies];
			if (rand(10) == 0 && player.findStatusEffect(StatusEffects.Blind) < 0)
			{
				atks.push(bukkakeTime);
			}
			atks[rand(atks.length)]();
			combatRoundOver();
		}
		
		private function demonLustMagic():void
		{
			var l:Number = 0;
			outputText("Though the front rank of demons are compressed so tight against you by their cohorts that they can’t move, the second and third rings have more than ample room to move their arms about, tracing arcane runes in the air. You know you can resist the lust-magics of a mere demon, but so many at once...");
			if (rand(100) >= player.lib / 2)
			{
				outputText("\n\nYou close your eyes, focusing the entirety of your will inwards. Though a burn of arousal stings your flesh, you keep your mind centered long enough to resist the brunt of the demon's magic. Taking a deep breath, you let out a raging battle cry and shove the horde back, punishing those who dared try to ensorcell you.");
			}
			else if (player.lust <= 33)
			{
				outputText("\n\nYou try your hardest to push back the lustful, submissive thoughts that begin to permeate your mind, but against so many concentrated wills... even you can't hold back. You moan as the first hints of arousal spread through you, burning in your loins. What you wouldn't give for a fuck about now!");
				l = player.lib / 10 + player.cor / 10 + 10;
				if (player.findStatusEffect(StatusEffects.MinotaurKingsTouch) >= 0)
				{
					l = l * 1.25;
				}
				game.dynStats("lus",l);
			}
			else if (player.lust <= 66)
			{
				outputText("\n\nAt first, you try to think of something else... but in your state, that just ends up being sex: hot, dirty, sweaty fucking surrounded by a sea of bodies. With a gasp, you realize you've left yourself open to the demons, and they're all too happy to flood your mind with images of submission and wanton debauchery, trying to trick you into letting them take you!");
				l = player.lib / 10 + player.cor / 10 + 10;
				if (player.findStatusEffect(StatusEffects.MinotaurKingsTouch) >= 0)
				{
					l = l * 1.25;
				}
				game.dynStats("lus",l);
			}
			else
			{
				outputText("\n\nYou don't even try to resist anymore -- your mind is already a cornucopia of lustful thoughts, mixed together with desire that burns in your veins and swells in your loins, all but crippling your ability to resist. The demons only add to it, fueling your wanton imagination with images of hedonistic submission, of all the wondrous things they could do to you if you only gave them the chance. It's damn hard not to.");
				l = player.lib / 10 + player.cor / 10 + 10;
				if (player.findStatusEffect(StatusEffects.MinotaurKingsTouch) >= 0)
				{
					l = l * 1.25;
				}
				game.dynStats("lus",l);
			}
		}
		
		private function dirtyDancing():void
		{
			var l:Number = 0;
			outputText("The demons closest to you are basically pinned between your body and those behind them, all surging forward to get at you - and half of them are being fucked or teased by the laggards, with cocks and over-sized clits thrusting with wild abandon. Nevertheless, the closest demons are just as determined as the others to make you theirs, even if their options are severely limited. So they do what they can: they dance and grind and thrust themselves against you, smearing your [armor] with milk and feminine excitement and musky, salty pre-cum between showing you with ample, soft flesh and hard muscle.");
			if (rand(100) >= player.lib / 2)
			{
				outputText("\n\nYou push back as hard as you can, throwing back the whorish bodies trying to capture your attentions. Several succubi whine and moan at you, pouting that their lustful dances weren't satisfying to you -- like you just insulted them on a personal level. Others are quick to replace them, though, instantly filling the gaps you leave in the crushing tide of bodies.");
			}
			else
			{
				if (player.lust <= 33)
				{
					outputText("\n\nYou try and push back, to ignore the lustful bodies and lurid performances going on around you, but the effect they have on you is undeniable -- heat spreads like wildfire through your [skinFurScales], and your [armor] suddenly feels a whole lot less comfortable.");
				}
				else if (player.lust <= 66)
				{
					outputText("\n\nTry as you might to resist, the demons are having an effect on you! Your whole body is flushed with unbidden arousal, burning with lust for the demonic sluts pressing against you. The temptresses are almost enough to want to make you lay down your arms and bend one of them double for a good, hard fuck!");
				}
				else
				{
					outputText("\n\nOh gods! The way their bodies undulate, caressing and cumming, moaning as they're fucked from behind and transfer all of that energy to you, makes your body burn with desire. It's almost too much to bear!");
				}
				l = player.lib / 10 + player.cor / 10 + 10;
				if (player.findStatusEffect(StatusEffects.MinotaurKingsTouch) >= 0)
				{
					l = l * 1.25;
				}
				game.dynStats("lus",l);
			}
		}
		
		private function hornyPoke():void
		{
			outputText("Several of the demons nearest you have grown immense sets of curling, sharp horns. When they can’t get at you to sexually provoke or hurl magic at you, they’re more than content to just give you an old-fashioned ram!");
			var damage:Number = 0;
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_SPEED || evade == EVASION_UNHINDERED)
			{
				outputText(" You deftly dodge out of the way!");
			}
			else if (evade == EVASION_MISDIRECTION)
			{
				outputText(" At least, they try to! Too bad for them you’re already elsewhere in the crowd, well away from harm!");
			}
			else if (evade == EVASION_FLEXIBILITY)
			{
				outputText(" You contort and bend in ways a human never could, easily twisting between all the pairs of horns the demons can thrust at you. By the time they’re done, you’re sitting on top of a demon’s head, balanced on his antlers until with a furious howl he throws you back into the sea of maledicts.");
			}
			else if (evade == EVASION_EVADE)
			{
				outputText(" You manage to duck down enough to avoid the worst of the horn-spikes, and your [armor] deflects the rest!");
			}
			else
			{
				damage = (70 - rand(player.tou)) * (1 + (player.newGamePlusMod() * 0.3));
				outputText(" Several of the big, stout horns slam into you, given all the more force thanks to the crushing waves of demons pushing them forward. You yelp in pain as they score your flesh! ");
				player.takeDamage(damage, true);
			}
		}
		
		private function crushingBodies():void
		{
			var damage:Number = 0;
			outputText("The sheer weight of a hundred demonic bodies crushing down on you is enough to make you cry out in discomfort, then pain. Are they just trying to crush you to death!?");
			if (player.getEvasionReason() == EVASION_EVADE)
			{
				outputText("\n\nYou drop to the ground, squirming between several of their legs until you get somewhere you can stand again -- this time without breaking your ribs. Howls of frustration and anger echo through the hall, and the horde just comes barreling down on your again!");
			}
			else
			{
				damage = (70 - rand(player.tou)) * (1 + (player.newGamePlusMod() * 0.3));
				if (damage < 5) damage = 10;
				outputText(" You squirm out of their crushing embrace, trying to crawl away on the ground, but if they can't squeeze you down the demons seem happy to trample you! You scream in alarm and pain as dozens of feet, hooves, claws, and other appendages come crushing down on you! ");
				player.takeDamage(damage, true);
			}
		}
		
		private function bukkakeTime():void
		{
			outputText("Considering how half of the demon host is just getting fucked by whoever’s behind them, it’s just a question of how long they last before the cum starts flowing. The answer just happens to be now! You gasp and gag as the air is suddenly flooded by the reek of potent, virile jizz, and ropes of thick white spunk start flying through the air. This is less of a gank mob and more of an orgy now!");
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_SPEED || evade == EVASION_UNHINDERED)
			{
				outputText(" You grab the biggest incubus you can find and shove him in the way of the airborne bukkake, letting his burly back take the brunt of the demons’ load. He grunts in displeasure, giving you a rough shove back into the demonic gang-bang. <i>“No escape!”</i>");
			}
			else if (evade == EVASION_MISDIRECTION)
			{
				outputText(" You duck under the nearest group of succubi, happily letting the demonic hussies get plastering with the wave of flying spooge. They seem to enjoy it, too, and quickly you’re surrounded by less demonic fighting and much, much more infernal cock-sucking. Seems they’re hungry!");
			}
			else if (evade == EVASION_FLEXIBILITY)
			{
				outputText(" You do a graceful backflip out of the way, making sure it’s a group of eager succubi who get painted white with cum rather than you!");
			}
			else if (evade == EVASION_EVADE)
			{
				outputText(" You at least manage to close your eyes before the wave of spooge hits you, splattering all over your [armor].");
				game.dynStats("lus",5);
			}
			else
			{
				outputText(" You take a huge, fat, musky glob of spunk right to the eyes! You yelp in alarm, trying to wipe the salty, burning demonic cock-cream out, but it's simply too thick! Yuck!");
				game.dynStats("lus",5);
				player.createStatusEffect(StatusEffects.Blind,2 + rand(2),0,0,0);
			}
		}
		
		private function phase2Ends(hpVictory:Boolean):void
		{
			clearOutput();
			if (hpVictory)
			{
				outputText("The last of the demons falls to your [weapon], crumpling into an unconscious lump before you. A few are crawling haplessly away, retreating to the stands with the rest of their fellows - those too timid to fight at all.");
			}
			else
			{
				outputText("Lethice’s minions have all but turned into an orgy, completely forgetting their original intent, no matter how much their draconic queen screeches for them to attack.");
			}
			outputText("\n\nWhile the demons are down, and Lethice is still recovering from your first skirmish, you have a much-needed moment to relieve the tensions starting to grow within you. Or you could press the attack, and take the fight to the queen.");
			game.menu();
			if (Boolean(player.hasCock()) || Boolean(player.hasVagina()))
			{
				game.addButton(0,"DemonFuck",p2DemonFuck,hpVictory);
			}
			if (player.findStatusEffect(StatusEffects.KnowsHeal) >= 0)
			{
				game.addButton(1,"Heal",p2Heal);
			}
			game.addButton(2,"Next",p2Next);
		}
		
		private function p2DemonFuck(hpVictory:Boolean):void
		{
			clearOutput();
			outputText("Rather than advance on Lethice, you turn your attention to the pile of demons");
			if (hpVictory)
			{
				outputText(" lying stunned and helpless");
			}
			else
			{
				outputText(" who’ve fallen into a frenzied orgy");
			}
			outputText(" on the floor. One in particular catches your attention: a purple-skinned harlot of an omnibus, with bone-formed high heels and voluptuous breasts and hips and a throbbing canine’s cock swinging between her legs, resting over a positively massive pair of balls, more like what you’d expect to be swinging under a centaur’s shaft. You reach down and grab her by her curling horns, pulling her off the crotch of another demon and pulling your [armor] aside to reveal your own");
			if (player.hasCock())
			{
				outputText(" cock.");
			}
			else
			{
				outputText(" cunt.");
			}
			outputText("\n\n<i>“O-oh my!”</i> she purrs, black eyes batting at you as you make your intentions clear. <i>“Here I thought you were saving this for the queen.”</i>");
			outputText("\n\nYou growl for her to get started, prompting her to slither out a forked tongue to");
			if (player.hasCock())
			{
				outputText(" wrap around your [cock]");
			}
			else
			{
				outputText(" lap across the lips of your [cunt]");
			}
			outputText(". Shudders of pleasure almost instantly begin to wrack your body, reacting to the demoness’s talented touch. She’s certainly skilled with her tongue, flicking and licking and caressing your sex with vigorous determination. You guide her movements by her demonic horns at first, but soon find yourself too busy gasping and moaning to try and control her - there’s no point, when she’s this good at");
			if (!player.hasCock())
			{
				outputText(" munching rug.");
			}
			else
			{
				outputText(" sucking cock.");
			}
			outputText("\n\nAround you, spurred on by your face-fucking the omnibus, the defeated demon court undulates in waves of orgiastic pleasure, gleefully sucking each other’s cocks, penetrating any hole they can find, or simply rolling on the floor locked in each other’s sensual embraces. Those that didn’t join the fight hoot and holler from the stands, encouraging you to fuck the omnibus like the eager slut she is. For her part, the horny demon just smirks up at you between long, loving licks across your sex.");
			game.menu();
			game.addButton(0,"OralFinish",oralFinish);
			if (player.hasCock())
			{
				game.addButton(1,"FuckDemon",fuckDemon);
			}
			game.addButton(2,"RideCock",rideCock);
		}
		
		private function oralFinish():void
		{
			clearOutput();
			if (player.hasCock())
			{
				outputText("You ignore the horde’s jeers, grinding your hips against the omnibus’s face until you feel the tell-tale rise of climax surging through you. Her throat bulges around your [cock] and the load of salty spunk you pour down her gullet, right up until you pull out and give her face a showering for good measure.");
				outputText("\n\nSated, you give the well-used omnibus a shove back into the demon fuck-pile and ready your [weapon]. Confident in your readiness, you advance on Lethice.");
			}
			else
			{
				outputText("You disregard the demons’ demands, instead focusing on grinding your hips on the omnibus’s face, slathering her chin and cheeks with slick feminine excitement. She moans in appreciation, wrapping a hand around her over-sized doggy-cock and stroking it furiously to the same rhythm of her tongue’s exploration of your [cunt]. With such single-minded intention, it doesn’t take the demon slut long at all to bring you to a well-deserved climax - and herself as well, spraying a thick, musky rope of cum across your [feet] while you smear her face with orgasmic juices.");
				outputText("\n\nSated, you give the well-used omnibus a shove back into the demon fuck-pile and ready your [weapon]. Confident in your readiness, you advance on Lethice.");
			}
			player.orgasm();
			beginPhase3(true);
		}
		
		private function fuckDemon():void
		{
			clearOutput();
			outputText("The demons’ urging tears down your self-control, and with a grunt of effort and desire, you shove the omnibus down on her back. She yelps with surprise, but her fall is cushioned by the massive, milky tits of a cow-girl-turned-demon behind her who’s busily sucking a pair of demonic dongs. Your omnibus recovers from her surprise in a heartbeat, turning it into a luxurious stretch that spreads her pussy-lips open under the hefty, churning weight of her equine-like balls.");
			outputText("\n\nYou lunge on her the moment you see that vermillion slit opening, driving your [cock] to the hilt inside the sloppy twat and making the omnibus moan with delight. Her canid cock bobs up at full mast, poking at your [chest]");
			if (player.hasFuckableNipples())
			{
				outputText(" until you give her a wicked grin and guide the tip inside your [nipple]");
			}
			else
			{
				outputText(" and smearing your [skinFurScales] with pre");
			}
			outputText(". You grab her melon-sized tits and squeeze them as hard as you can while you hammer your [hips] forward, taking advantage of the silky-wet vice of her twat to milk yourself to orgasm. She’s practically an ona-hole for you, only able to squirm around and moan while you pound away.");
			outputText("\n\nSuddenly, your entire body tenses, shivering with new sensation. You look over your shoulder in time to see another succubus crawling up behind you, running her tongue through the crack of your ass");
			if (player.balls > 0)
			{
				outputText(" and around your balls");
			}
			else
			{
				outputText(" down to the base of your cock");
			}
			outputText(". Another demoness snuggles up behind you, pressing a hefty pair of jugs into your back and murmuring about how she wants to see you breed that hermaphroditic cum-slut under you.");
			outputText("\n\nWith more and more demons crawling up over you, urging you to cement your victory on their companion or adding to your pleasure with mouths and corrupted tongues, it’s not long before you surrender to your body’s carnal demands. Giving one last, mighty thrust into the omnibus’s twat, you grunt with the surging pleasure of cum swelling through your shaft, spilling out and basting the demoness’s womb. She cries out, bucking her hips against you and quickly following you with a shot of her own");
			if (!player.hasFuckableNipples())
			{
				outputText(" that splatters all over your chest");
			}
			else
			{
				outputText(" right into your tit");
			}
			outputText("! You give her a reproachful look, still grinding your hips as the aftershocks of orgasm pass.");
			outputText("\n\n<i>“Not sorry,”</i> she giggles, running a finger around her cum-smeared twat and pushing every spare droplet back in as you pull out. <i>“Mmm, that’ll make for a lovely brood of imps, </i>Champion<i>!”</i>");
			outputText("\n\nShuddering at the thought, you grab your gear and stagger up and away, leaving the demons to finish each other off. Confident in your readiness, you advance on Lethice.");
			player.orgasm();
			beginPhase3(true);
		}
		
		private function rideCock():void
		{
			clearOutput();
			outputText("Considering the demons seem intent on having you get down and dirty with their defeated compatriot, you figure you might as well get the most out of the moment. Lethice doesn’t seem to be in any hurry to resume your battle, after all!");
			outputText("\n\nYou give the buxom demon hermaphrodite down on her ass, letting her rest her head in the lap of another cow-girl demon who’s busy sucking off a two-cock’d incubus, and crawl up her shapely red body. <i>“Oooh,”</i> the omnibus coos as her throbbing red rocket is pressed between your bodies. <i>“Gonna go for a ride, Champion?”</i>");
			outputText("\n\nDamn right you are. You grab her tits, sinking your fingers into the soft, crimson udders as you straddle her hips and grind your [vagOrAss] against the demon’s tumescent shaft. She’s hung like a stud, rock hard and ready to roll before you even get near her pointed crown. You feel her hands grasp your [hips], guiding you down until your [vagOrAss] is sinking onto her thick rod. Your belly bulges with the sheer length of cockflesh sliding into you, and your mind goes blank with overwhelming pleasure.");
			outputText("\n\nIt takes you a moment to recover from the initial shock, but when you do, you start moving with a vengeance, bouncing on the demonic doggy-cock with mounting speed. Its owner moans and squirms beneath you, too weakened from your fight to do anything but go along for the ride. Still, her big, black nipples are hard as rocks in your hand, and her pussy soaks both your thighs in her ever-rising excitement.");
			outputText("\n\nSuddenly, your entire body tenses, shivering with new sensation. You look over your shoulder in time to see another succubus crawling up behind you,");
			if (player.hasVagina())
			{
				outputText(" licking at your [cunt]");
			}
			else
			{
				outputText(" reaching around to give your unused [cocks] a tug}. Another demoness snuggles up behind you, pressing a hefty pair of jugs into your back and murmuring about how she wants to see you get bred by that hermaphroditic stud under you.");
			}
			outputText("\n\nWith more and more demons crawling up over you, urging you to cement your victory on their companion or adding to your pleasure with mouths and corrupted tongues, it’s not long before you surrender to your body’s carnal demands. You grind your hips hard and fast against the demoness’s mis-matched crotch, loving the way her churning black balls ride in your ass, the way her fist-thick knot hammers against your [vagOrAss]. With so many sensations assaulting your body, it’s impossible to hold back. Screaming your ecstasy for the whole hall to hear, you climax, body shuddering and clenching hard around the thick demonic cock spreading you open.");
			outputText("\n\nThe demoness isn’t far behind. She grabs your hips hard enough that her nails score your flesh, and you feel a rush of sticky, wet heat flooding your");
			if (player.hasVagina())
			{
				outputText(" womb");
			}
			else
			{
				outputText(" bowels");
			}
			outputText(". You only barely keep your wits about you enough to push her back down before she can force her knot inside you, though you’re treated to a veritable waterfall of white spunk pouring out of your well-bred hole instead.");
			outputText("\n\n<i>“I can see why they call you ‘Champion,’”</i> the demon purrs as her spunk-slathered red prick flops against her belly. <i>“Maybe after our queen beats you down, I’ll come visit you in the breaking tanks... I could always use another eager little broodmare.”</i>");
			outputText("\n\nYou shove the demoness away, suddenly reminded of her true nature. At least for now, you’re sated. Confident in your readiness, you advance on Lethice.");
			player.orgasm();
			beginPhase3(true);
		}
		
		private function p2Heal():void
		{
			clearOutput();
			outputText("Drawing on your magic, you use the opportunity to mend your wounds. No foe dares challenge you during the brief lull in battle, enabling you to maintain perfect concentration. With your flesh freshly knit and ready for battle, you look to Lethice.");
			var temp:int = int((player.level + (player.inte / 1.5) + rand(player.inte)) * player.spellMod()) * 2;
			if (player.armorName == "skimpy nurse's outfit")
			{
				temp = temp * 1.2;
			}
			game.HPChange(temp,false);
			beginPhase3(true);
		}
		
		private function p2Next():void
		{
			clearOutput();
			outputText("<i>“Useless whelps,”</i> Lethice growls, rising back to her feet and spreading her");
			if (_wingsDestroyed)
			{
				outputText(" tattered");
			}
			outputText(" draconic wings behind herself, letting them flare out to their full majesty. She grabs a whip from her flank and uncoils it with a snap, cracking it just over your head. Black fire seethes on the length of the whip, burning with corrupt magics that make the air reek of sex and desire around her.");
			outputText("\n\n<i>“Very well, Champion,”</i> she snarls, throwing aside her goblet of Lethicite. The crystals go scattering as the vessel shatters on the flagstone, and in an instant even the defeated demons are scrambling for the gems, making the floor you fight on a rabid hell to walk through. <i>“I see I’ll have to finish you myself! Let us see what you’re really made of... before I rape your soul out of your body!”</i>");
			beginPhase3(false);
		}
		
		private function beginPhase3(doLethNext:Boolean):void
		{
			_fightPhase = 3;
			HP = eMaxHP();
			lust = 10;
			_defMode = 1;
			a = "";
			short = "Lethice";
			plural = false;
			pronoun1 = "she";
			pronoun2 = "her";
			pronoun3 = "her";
			if (player.newGamePlusMod() >= 1 && armorName != "lethicite armor") { //In New Game+, have her use Lethicite armour.
				this.armorName = "lethicite armor";
				this.armorDef += 30;
			}
			game.menu();
			if (doLethNext)
			{
				game.addButton(0,"Next",p2Next);
			}
			else
			{
				combatRoundOver();
			}
		}
		
		private function phase3():void
		{
			var atks:Array = null;
			//Determine defense mode
			if (flags[kFLAGS.LAST_ATTACK_TYPE] == 1 || flags[kFLAGS.LAST_ATTACK_TYPE] == 2 || flags[kFLAGS.LAST_ATTACK_TYPE] == 4)
				_defMode = 1;
			else
				_defMode = 2;
			//Texts and effects
			if (_defMode == 1) {
				outputText("Lethice dabs at her injury, then licks her finger, smiling sensually. She seems excited and invigorated. Scales appear over her skin, and her spaded tail swishes back and forth in a blur, too fast to follow.\n\n");
				spe = 400;
				armorDef = 400;
				if (armorName == "lethicite armor")
					armorDef += 30;
				lustVuln = 1.125;
			}
			else {
				outputText("Shuddering, the Demon Queen steels herself. Her curves soften visibly as she prepares herself for additional arousing efforts, forgoing physical defense.\n\n");
				spe = 80;
				armorDef = 14;
				if (armorName == "lethicite armor")
					armorDef += 30;
				lustVuln = 0;
			}
			if (_roundCount == 5) {
				gropehands();
			}
			else
			{
				atks = [parasiteThrowingStars, whiptrip, sonicwhip];
				if (player.findStatusEffect(StatusEffects.WhipSilence) < 0)
				{
					atks.push(whipchoke);
				}
				atks[rand(atks.length)]();
			}
		}
		
		private function parasiteThrowingStars():void
		{
			var l:Number = 0;
			var damage:Number = 0;
			var evade:String = player.getEvasionReason();
			outputText("Lethice retrieves three squirming, star-shaped creatures from beneath her clothes and flings them at you. A split second after they leave her hand, needles burst from their edges!");
			if (evade == EVASION_SPEED || evade == EVASION_UNHINDERED)
			{
				outputText(" The living throwing stars whistle by you, barely missing you.");
			}
			else if (evade == EVASION_EVADE)
			{
				outputText(" You barely avoid the living throwing stars.");
			}
			else if (evade == EVASION_MISDIRECTION)
			{
				outputText(" Your misdirecting movements allow you to avoid the living throwing stars.");
			}
			else if (evade == EVASION_FLEXIBILITY)
			{
				outputText(" You bend over backwards to avoid the living throwing stars.");
			}
			else
			{
				l = player.lib / 10 + player.cor / 10 + 10;
				if (player.findStatusEffect(StatusEffects.MinotaurKingsTouch) >= 0)
				{
					l = l * 1.25;
				}
				game.dynStats("lus",l);
				damage = str + weaponAttack - rand(player.tou);
				outputText(" You can’t avoid them all! One clips you on its way past, ripping into your [skin] and leaving you feeling... flushed and hot in its wake.");
				if (player.hasCock() && rand(player.tou + 50) < 25) {
					outputText(" There’s suddenly a dearth of room in the crotch of your [armor], rubbing distractingly and slowing you with added weight. <b>[EachCock] has grown bigger!</b> ");
					player.increaseEachCock(1);
				}
				else if (player.biggestTitSize() <= 0 && rand(player.tou + 50) < 25) {
					outputText(" The inside of your [armor] is suddenly pressing back on your [nipples]. <b>You’ve grown breasts!</b> That bitch! ");
					player.growTits(3, player.breastRows.length, false, 2);
				}
				else if (rand(player.tou + 50) < 25) {
					outputText(" There’s suddenly a dearth of room in the chest of your [armor]. Your [chest] are expanding, bouncing distractingly and slowing you with the extra weight! ");
					player.growTits(2, player.breastRows.length, false, 2);
				}
				damage = player.takeDamage(damage, true);
			}
		}
		
		private function whiptrip():void
		{
			var damage:Number = 0;
			outputText("Lethice slashes her whip in a wide, low arc.");
			var minDamage:Boolean = false;
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_SPEED || evade == EVASION_UNHINDERED) {
				outputText(" You jump over it at the last second, the heat singing your [feet]. ");
				minDamage = true;
			}
			else if (evade == EVASION_EVADE) {
				outputText(" You evade her trip, but the heat pouring off the whip singes your [feet]. ");
				minDamage = true;
			}
			else {
				outputText("You try to avoid it, but the burning weapon catches your [leg], simultaneously scorching your flesh and attempting to pull you off balance. ");
				if (player.findPerk(PerkLib.Resolute) < 0 && rand(player.tou) <= 25) {
					outputText("The ground rushes up at you awful fast. Lethice has tripped you, <b>stunning you!</b> ");
					player.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
				}
				else
					outputText("Lethice is going to need to pull a lot harder if she wants to trip you. ");
			}
			if (minDamage)
				damage = (25 + weaponAttack - rand(player.tou)) * (1 + (player.newGamePlusMod() * 0.3));
			else
				damage = (100 + weaponAttack + str - rand(player.tou)) * (1 + (player.newGamePlusMod() * 0.3));
			damage = player.takeDamage(damage, true);
		}
		
		private function sonicwhip():void
		{
			outputText("Lethice raises her sizzling, flame-spitting whip high up overhead, then snaps her arm out and back in an instant, cracking the whip so hard that it gives birth to a shockwave of flame and cacophonous thunder. There’s no avoiding the all-encompassing wave of energy. There’s not even time to brace yourself. It slams into you, rattling bones and scorching flesh. ");
			var damage:Number = (75 + weaponAttack + str) * (1 + (player.newGamePlusMod() * 0.3));
			damage = player.takeDamage(damage, true);
		}
		
		private function whipchoke():void
		{
			var damage:Number = 0;
			outputText("<i>“Silence your prattling, curr.”</i> Lethice strikes out with her whip, aimed at your neck!");
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_SPEED || evade == EVASION_UNHINDERED)
			{
				outputText(" You barely avoid it.");
			}
			else if (evade == EVASION_EVADE)
			{
				outputText(" You evade the targeted strike.");
			}
			else if (evade == EVASION_FLEXIBILITY)
			{
				outputText(" You twist aside at the last moment.");
			}
			else if (evade == EVASION_MISDIRECTION)
			{
				outputText(" Raphael taught you well. Lethice failed to account for your misleading movements and swung wide.");
			}
			else
			{
				outputText("\n\nYou gasp when the burning cord encircles your throat, unable to speak and unable to discern why the licking flames haven’t scorched the flesh from your face. Laughing, the queen snaps her end of the whip off like a rotten cord, dropping the burning length to the ground with disdain. The unattached end loops around your neck again and again, binding tight. At the same time, fresh flame boils out of the tightly held handle, revealing a sinuously slithering implement of pain no worse for the wear. ");
				outputText("\n\n<b>You are effectively silenced!</b> ");
				damage = weaponAttack + 25 - rand(player.tou);
				damage = player.takeDamage(damage, true);
				player.createStatusEffect(StatusEffects.WhipSilence,3,0,0,0);
			}
		}
		
		private function triplestroke():void
		{
			var damage:Number = 1;
			outputText("Lethice’s arm blurs in figure eights, snapping the whip at you from every sides. You’ll have a tough time avoiding so many strikes!");
			for(var i:int = 0; i < 3; i++)
			{
				if (attackSucceeded())
				{
					damage = eOneAttack();
					outputAttack(damage);
					postAttack(damage);
					game.statScreenRefresh();
					outputText("\n");
				}
				else
				{
					outputText("You duck and weave, barely managing to avoid a stinging slash from the whip!\n");
				}
			}
		}
		
		private function gropehands():void
		{
			outputText("<i>“Let’s see how you fight while you’re being groped, shall we? A shame Pigby isn’t around to see how I’ve improved his hands,”</i> Lethice murmurs. Cupping her hands into a parody of lecher’s grip, the corruptive Queen squeezes and chants. Immediately, you feel phantasmal hands all over your body, reaching through your armor to fondle your bare [skinFurScales]. Digits slip into your [butt]. Fingertips brush your [nipples]. Warm palms slide down your quivering belly toward your vulnerable loins.");
			outputText("\n\nYou glare daggers at Lethice, but she merely laughs. <i>“A shame I never got to convince him that his hands were so much more effective when used like this.”</i>");
			game.dynStats("lus",5);
			player.createStatusEffect(StatusEffects.PigbysHands,0,0,0,0);
		}
	}
}
