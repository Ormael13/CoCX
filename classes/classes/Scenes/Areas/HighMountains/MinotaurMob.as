package classes.Scenes.Areas.HighMountains
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

/**
	 * ...
	 * @author ...
	 */
	public class MinotaurMob extends Monster 
	{
		public var wastedTurn:Boolean = false;

		private function precumTease():void {
			var teased:Boolean = false;
			var damage:Number = 0;
			var oldLust:Number = player.lust;
			game.spriteSelect(SpriteDb.s_minotaurSons);
			//(Big taur pre-cum tease)
			if(rand(2) == 0) {
				teased = true;
				if(rand(5) > 0) {
					outputText("The biggest lifts his loincloth, giving you a perfect view of his veiny hardness.  Pre-cum visibly bubbles from his flared tip, splattering wetly on the rocks and filling the air with his bestial musk.  He says, \"<i>See how much I need you?</i>\"\n");
					if (flags[kFLAGS.MINO_SONS_LVL_UP] > 8) damage = 19 + player.lib;
					else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 6) damage = 16 + player.lib/5;
					else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 4) damage = 13 + player.lib/10;
					else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 2) damage = 10 + player.lib/15;
					else damage = 7 + player.lib/20;
				}
				//crit)
				else {
					outputText("The largest bull in the crowd flaps his cum-soaked loincloth up and wraps a massive, muscled hand around his incredible erection.  Shaking it back and forth, he flicks his bubbling pre-cum in your direction, letting it spatter noisily against the rocks around you.  A few droplets even land on your skin, fogging the air with minotaur pheromones.\n");
					if (flags[kFLAGS.MINO_SONS_LVL_UP] > 8) damage = 7 + player.lib/10;
					else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 6) damage = 6 + player.lib/15;
					else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 4) damage = 5 + player.lib/20;
					else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 2) damage = 4 + player.lib/25;
					else damage = 3 + player.lib/30;
				}
			}
			//(Middle Taur pre-cum tease)
			if(rand(2) == 0) {
				teased = true;
				if(rand(5) > 0) {
					outputText("\"<i>Hey, slut, look at this!</i>\" taunts one of the beast-men.  He shakes his hips lewdly, spinning his thick horse-cock in wide circles and sending his potent pre flying through the air.  Droplets rain down around you, filling the air with even more of that delicious smell.\n");
					if (flags[kFLAGS.MINO_SONS_LVL_UP] > 8) damage = 7 + player.lib/10;
					else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 6) damage = 6 + player.lib/15;
					else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 4) damage = 5 + player.lib/20;
					else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 2) damage = 4 + player.lib/25;
					else damage = 3 + player.lib/30;
				}
				else {
					outputText("\"<i>Mom, you may as well spread your thighs now, I got a treat for ya!</i>\" announces a well-built minotaur.  He shifts his coverings and pumps on his swollen shaft, tugging hard enough over the iron-hard erection to blast out huge blobs of pre-seed in your direction.  ");
					if(player.spe/5 + rand(20) > 20) {
						outputText("You avoid most of them, the blobs splattering against the mountain and still getting a little on you.  Regardless, the air stinks of their heavy spunk.");
						if (flags[kFLAGS.MINO_SONS_LVL_UP] > 8) damage = 18 + player.lib;
						else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 6) damage = 15 + player.lib/5;
						else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 4) damage = 12 + player.lib/10;
						else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 2) damage = 9 + player.lib/15;
						else damage = 6 + player.lib/20;
					}
					else {
						outputText("You try to avoid them, but one catches you in the face, a little getting into your mouth.  You swallow it reflexively and salivate some more, your eyes darting to look at the stained rocks around you.  Are you really considering licking it up from the ground?");
						if (flags[kFLAGS.MINO_SONS_LVL_UP] > 8) damage = 35 + player.lib;
						else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 6) damage = 30 + player.lib/5;
						else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 4) damage = 25 + player.lib/10;
						else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 2) damage = 20 + player.lib/15;
						else damage = 15 + player.lib/20;
					}
				}
				outputText("\n");
			}
			//(Minitaur pre-cum tease)
			if(!teased || rand(3) == 0) {
				outputText("The smallest of the beastmen, the minitaur, moans and begs, \"<i>Please Mom, can we please fuck you?  I... I need it so bad.</i>\"  He raises the edge of his loincloth to show exactly what he's talking about.  His member is limp but leaking.  What really catches your eyes sits behind that drizzling shaft - a pair of balls looking swollen and pent up beyond belief.  A sticky web of his leavings hangs between his genitals and his loincloth, showing you just how much he's been leaking at the thought of fucking you.  Fanning the sopping garment, he inadvertently blows a wave of his pheromones your way.\n");
				if (flags[kFLAGS.MINO_SONS_LVL_UP] > 8) damage = 21 + player.lib;
				else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 6) damage = 18 + player.lib/5;
				else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 4) damage = 15 + player.lib/10;
				else if (flags[kFLAGS.MINO_SONS_LVL_UP] > 2) damage = 12 + player.lib/15;
				else damage = 9 + player.lib/20;
			}
			player.takeLustDamage(damage, true);
			damage = player.lust - oldLust;
			//UNIVERSAL pre-cum RESULT:
			//(Low damage taken)
			if(damage <= 8) {
				outputText("Though your body is tingling from the show the horny beasts are giving you, it doesn't effect you as much as it could have.");
				if(player.lust >= player.maxOverLust()) outputText("  Still, you're too horny to fight any longer.");
			}
			//(Medium damage taken)
			else if(damage <= 14) {
				outputText("The powerful pheromones and scents hanging in the air around you make your body flush hotly.  Your [nipple]s grow harder");
				if(player.lust > 70) outputText(", though you didn't think such a thing was possible");
				else outputText(", feeling like two bullets scraping along the inside of your " + player.armorName);
				outputText(", but it... it could have been worse.  You shudder as a little fantasy of letting them dribble it all over your body works through your mind.");
				if(player.lust >= player.maxOverLust()) outputText("  Fuck it, they smell so good.  You want, no, NEED more.");
				else outputText("  A growing part of you wants to experience that.");
			}
			//(high damage taken)
			else {
				outputText("All that potent pre-ejaculate makes your cunny ");
				if(player.wetness() <= 1) outputText("moisten");
				else if(player.wetness() <= 2) outputText("drip");
				else if(player.wetness() <= 3) outputText("drool");
				else outputText("juice itself");
				outputText(" in need.");
				if(player.minotaurNeed()) {
					outputText("  You need a fix so bad!");
					player.takeLustDamage((5*flags[kFLAGS.MINO_SONS_LVL_UP]), true);
				}
				else {
					outputText("  You can understand firsthand just how potent and addictive that fluid is...");
				}
				if(player.hasCock()) outputText("  " + SMultiCockDesc() + " twitches and dribbles its own pre-seed, but it doesn't smell anywhere near as good!");
				outputText("  Shuddering and moaning, your body is wracked by ever-increasing arousal.  Fantasies of crawling under the beast-men's soaked legs and lapping at their drooling erections inundate your mind, your body shivering and shaking in response.  ");
				if(player.lust < player.maxOverLust()) outputText("You pull back from the brink with a start.  It'll take more than a little drugged pre-cum to bring you down!");
				else outputText("You sigh and let your tongue loll out.  It wouldn't so bad, would it?");
			}
		}

		//Grope
		private function minotaurGangGropeAttack():void {
			game.spriteSelect(SpriteDb.s_minotaurSons);
			outputText("Strong hands come from behind and slide under your equipment to squeeze your " + chestDesc() + ".  The brutish fingers immediately locate and pinch at your " + nippleDescript(0) + "s, the sensitive flesh on your chest lighting up with pain and pleasure.  You arch your back in surprise, utterly stunned by the violation of your body.  After a moment you regain your senses and twist away, but the damage is already done.  You're breathing a bit quicker now");
			if(player.lust >= Math.round(player.maxLust()*0.8)) outputText(", and your pussy is absolutely soaking wet");
			outputText(".");
			player.takeLustDamage(((5 + player.effectiveSensitivity()*flags[kFLAGS.MINO_SONS_LVL_UP])/10), true);
		}
		//Gang Grope
		private function minotaurGangGangGropeAttack():void {
			game.spriteSelect(SpriteDb.s_minotaurSons);
			outputText("Before you can react, hands reach out from multiple angles and latch onto your body.  One pair squeezes at your " + Appearance.buttDescription(player) + ", the strong grip massaging your cheeks with loving touches.  Another set of hands are sliding along your tummy, reaching down for, but not quite touching, the juicy delta below.  Palms encircle your [chest] and caress them, gently squeezing in spite of the brutish hands holding you.  You wriggle and squirm in the collective grip of the many minotaurs for a few moments, growing more and more turned on by the treatment.  At last, you shake out of their hold and stand free, panting hard from exertion and desire.");
			player.takeLustDamage(((15 + player.effectiveSensitivity()*flags[kFLAGS.MINO_SONS_LVL_UP])/10), true);
		}
		//Waste  a turn
		private function minotaurGangWaste():void {
			wastedTurn = true;
			game.spriteSelect(SpriteDb.s_minotaurSons);
			outputText("\"<i>Oh man I can't wait to go hilt-deep in that pussy... I'm going to wreck [him],</i>\" promises one bull to his brother.  The other laughs and snorts, telling him how he'll have to do the deed during sloppy seconds.  It quickly escalates, and soon, every single one of the beast-men is taunting the others, bickering over how and when they'll get to have you.  While they're wasting their time, it's your chance to act!");
		}
		//
		private function minosPheromones():void {
			game.spriteSelect(SpriteDb.s_minotaurSons);
			outputText("The minotaurs smiles at you and lifts their loincloth, flicking them at you.  Thick ropes of pre-cum fly through the air, ");
			//sometimes get hit with the pre for stronger effect!
			if(rand(3) == 0) {
				outputText("slapping into your face before you can react!  You wipe the slick snot-like stuff out of your eyes and nose, ");
				if(player.lust > player.maxLust() * 0.75) {
					outputText("swallowing it into your mouth without thinking.  ");
					takeLustDamage(100 + player.lib, true);
				}
				else {
					outputText("feeling your heart beat with desire as your tongue licks the residue from your lips.  ");
					takeLustDamage(50 + player.lib/2, true);
				}
			}
			else outputText("right past your head.  ");
			outputText("The animalistic scent of it seems to get inside you, the musky aroma burning a path of liquid heat to your groin.");
			takeLustDamage(100 + player.lib/2, true);
			if(player.hasPerk(PerkLib.MinotaurCumAddict) || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2) {
				if(rand(2) == 0) outputText("\n<b>You shiver with need, wanting nothing more than to bury your face under one of those loincloth and slurp out every drop of goopey goodness.</b>");
				else outputText("\n<b>You groan and lick your lips over and over, craving the taste of them in your mouth.</b>");
				takeLustDamage(50+rand(50), true);
			}
		}
		//This is sparta
		private function minotaurThisIsSparta():void {
			game.spriteSelect(SpriteDb.s_minotaurSons);
			outputText("One of the minotaurs in golden armor with a helmet, a round shield and a gladius jumps out of the lot and kicks you in the face throwing you to the ground screaming.\n\n");
			outputText("\"<i>This.. is… <b>MY FUUUUCK!!!!</b></i>\"");
			player.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}

		override protected function performCombatAction():void
		{
			game.spriteSelect(SpriteDb.s_minotaurSons);
			if (flags[kFLAGS.ETNA_FOLLOWER] == 3) {
				var select1:Number = rand(5);
				if(select1 <= 2) eAttack();
				else if (select1 == 3) minosPheromones();
				else minotaurThisIsSparta();
			}
			else {
				wastedTurn = false;
				var select:Number = rand(7);
				if(select <= 2) precumTease();
				else if(select <= 4) minotaurGangGropeAttack();
				else if(select == 5) minotaurGangGangGropeAttack();
				else minotaurGangWaste();
			}
		}


		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.ETNA_FOLLOWER] == 3) SceneLib.etnaScene.etnaMarriageYes4();
			else SceneLib.mountain.minotaurMobScene.victoryMinotaurGang();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.ETNA_FOLLOWER] == 3) {
				SceneLib.etnaScene.etnaMarriageYes3();
			} else if (pcCameWorms) {
				outputText("\n\nThe minutaurs share a laugh while you cum, but their throbbing erections don't subside in the slightest.");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.mountain.minotaurMobScene.minotaurDeFeet();
			}
		}

		public function MinotaurMob()
		{
			var mod0:int = flags[kFLAGS.MINO_SONS_LVL_UP];
			var mod1:int = (flags[kFLAGS.MINO_SONS_LVL_UP] + flags[kFLAGS.MINOTAUR_SONS_TRIBE_SIZE] - 3);
			var mod2:int = ((flags[kFLAGS.MINO_SONS_LVL_UP]*6) + flags[kFLAGS.MINOTAUR_SONS_TRIBE_SIZE] - 3);
			this.a = "the ";
			if (flags[kFLAGS.ETNA_FOLLOWER] == 3) this.short = "300 jealous minotaurs Ex-es";
			else if (game.flags[kFLAGS.MINOTAUR_SONS_TRIBE_SIZE] < 20) this.short = "minotaur gang";
			else this.short = "minotaur tribe";
			this.imageName = "minotaurmob";
			if (flags[kFLAGS.ETNA_FOLLOWER] == 3)
				this.long = "Whoa, it looks like all of Etna’s sexual partners have amassed in one group to take her and you down. The bull men are all over the chapel!";
			else 
				this.long = Num2Text(game.flags[kFLAGS.MINOTAUR_SONS_TRIBE_SIZE]) + " shaggy beastmen stand around you in a loose circle.  Their postures aren't exactly threatening.  If anything, they seem to be standing protectively around you, as if their presence would somehow shelter you from the rest of the mountain.  All of their features share a brotherly similarity, though there's still a fair bit of differences between your minotaur sons.  One of them is a head above the rest, a massive hulk of muscle so big he seems to dwarf the rest.  In stark contrast, a feminine minitaur keeps his distance in the rear."+(game.flags[kFLAGS.MINOTAUR_SONS_TRIBE_SIZE] >= 20?"  The tribe constantly makes hoots and cat-calls, fully expecting to be fucking you soon.":"");
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createCock(rand(13) + 24,2 + rand(3),CockTypesEnum.HORSE);
			this.balls = 2;
			this.ballSize = 2 + rand(13);
			this.cumMultiplier = 1.5;
			this.hoursSinceCum = ballSize * 10;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = rand(37) + 84;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.lowerBody = LowerBody.HOOFED;
			this.skin.growFur({color:"red"});
			this.skinDesc = "shaggy fur";
			this.hairColor = randomChoice("black","brown");
			this.hairLength = 3;
			this.faceType = Face.COW_MINOTAUR;
			this.weaponName = "fists";
			this.weaponVerb="punches";
			this.armorName = "thick fur";
			var bonusHP:Number = 600;
			var lustVuln:Number = 0.45;
			if (flags[kFLAGS.ETNA_FOLLOWER] == 3) {
				initStrTouSpeInte(80, 110, 30, 20);
				initWisLibSensCor(20, 100, 15, 35);
				this.weaponAttack = 36;
				this.armorDef = 30;
				this.armorMDef = 5;
				lustVuln -= 0.4;
				this.bonusLust = 145;
				this.level = 30;
				this.createPerk(PerkLib.Enemy300Type, 0, 0, 0, 0);
			}
			else {
				initStrTouSpeInte(160 + mod0*20, 220 + mod0*15, 60 + mod0*10, 25 + mod0);
				initWisLibSensCor(25 + mod0, 200 + mod0*50, 30 + mod0*10, 25);
				this.weaponAttack = 36 + mod0*20;
				this.armorDef = 60 + mod0*7;
				this.armorMDef = 20 + mod0*2;
				bonusHP += 100 * mod2;
				lustVuln = .3;
				this.bonusLust = 257 + (mod0*60) + mod2;
				this.level = 27 + mod2;
			}
			this.bonusHP = bonusHP;
			this.lust = 30;
			this.lustVuln = lustVuln;
			this.gems = rand(50) + 100;
			this.tailType = Tail.COW;
			this.special1 = SceneLib.mountain.minotaurScene.minoPheromones;
			this.drop = NO_DROP;
			if (flags[kFLAGS.MINOTAUR_SONS_GROW_COUNTDOWN] > 20 || flags[kFLAGS.ETNA_FOLLOWER] == 3) this.createPerk(PerkLib.EnemyLargeGroupType, 0, 0, 0, 0);
			else this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			if (flags[kFLAGS.MINO_SONS_LVL_UP] >= 2) this.createPerk(PerkLib.JobBeastWarrior, 0, 0, 0, 0);
			if (flags[kFLAGS.MINO_SONS_LVL_UP] >= 4) this.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
			if (flags[kFLAGS.MINO_SONS_LVL_UP] >= 6) this.createPerk(PerkLib.JobBeastlord, 0, 0, 0, 0);
			if (flags[kFLAGS.MINO_SONS_LVL_UP] >= 8) this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
			if (flags[kFLAGS.MINO_SONS_LVL_UP] >= 10) this.createPerk(PerkLib.EpicLibido, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
