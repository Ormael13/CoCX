package classes.Scenes.Areas.HighMountains
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class Minerva extends Monster
	{

		//Normal Attacks for all Minerva Types
		//Shark-bite:
		private function minervaBite():void
		{
			outputText("The siren paces around you in circles, waiting for the right moment to strike.  Unexpectedly quick thanks to her clawed feet, she propels herself toward you at full speed.  Her maw opens wide to chomp on you, showing off multiple rows of glinting, razor-sharp teeth.");
			var damage:int = int((str + 5) - rand(player.tou) - player.armorDef);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 12) damage + 340;
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 8) damage + 255;
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 4) damage + 170;
			else damage + 85;
			if (player.getEvasionRoll()) {
				outputText("  You get out of the way just in time, Minerva making a loud chomping sound as she only catches the air.");
			}
			else if (combatBlock(true)) {
				outputText("  You raise your [shield] just in time, deflecting her bite.");
				SceneLib.combat.ShieldsStatusProcs();
			}
			//[else block]
			else if (damage <= 0) outputText("  Your hands lash out, knocking her head to the side as she tries to bite you.  With the bite deflected, Minerva makes a loud chomping sound as she only bites the air.");
			//[if attack lands]
			else {
				outputText("  Her teeth dig right into your arm!  It's a bit of a struggle, but you're able to free yourself.  The damage doesn't look too serious. ");
				player.takePhysDamage(damage, true);
			}
		}

//Flying kick:
		private function minervaKnowsKungfu():void
		{
			outputText("The blue beauty flaps her wings and launches herself into the air.  Once she's gained as much altitude as she can, she dive-bombs you, her demon-clawed feet leading the attack.");
			var damage:int = int((str + weaponAttack + 100) - rand(player.tou) - player.armorDef);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 12) damage += 400;
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 8) damage += 200;
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 4) damage += 100;
			speStat.core.value -= 70;
			if (player.getEvasionRoll()) {
				outputText("  You jump out of the landing zone just in time, piles of dirt exploding in all directions as Minerva slams into the ground.");
			}
			//[else block]
			else if (damage <= 0) outputText("  Steadying yourself, you reach up, grabbing hold of Minerva as she attempts to land a heavy blow on you.  Grunting hard, you pull against her and toss the siren aside completely, halting her attack.");
			//[if attack lands]
			else {
				outputText("  She hits you square in the chest, knocking you to the ground as her entire weight lands on you.  The bombshell of a woman jumps off your chest, ready to keep fighting. ");
				player.takePhysDamage(damage, true);
			}
			speStat.core.value += 70;
		}

//Tail-whip
		private function tailWhip():void
		{
			var damage:int = int((str + 35) - rand(player.tou) - player.armorDef);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 12) damage += 140;
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 8) damage += 70;
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 4) damage += 35;
			outputText("She runs at you, holding the weapon like she's about to chop into your side.  You brace yourself, but when she's only a few feet away, she starts to turn her body.");
			//[else block]
			if (damage <= 0) outputText("  Lashing out with a fierce kick you intercept the tail-whip, your [foot] impacting against her strong appendage and totally neutralizing its momentum.");
			//[if attack lands]
			else {
				outputText("  Her shark tail whacks you, knocking you to the ground.  You quickly struggle back into position");
				if (player.armorDef > 0) outputText(", but your defense has been reduced");
				outputText("! ");
				player.takePhysDamage(damage, true);
				if (hasStatusEffect(StatusEffects.TailWhip)) addStatusValue(StatusEffects.TailWhip, 1, 10);
				else createStatusEffect(StatusEffects.TailWhip, 10, 0, 0, 0);
			}
		}

//Halberd stab:
		private function minervaUsesHalberdStab():void
		{
			outputText("Minerva charges at you, brandishing her halberd's sharp tip toward you.");
			var damage:int = int((str + weaponAttack) - rand(player.tou));
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 12) damage += 100;
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 8) damage += 50;
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 4) damage += 25;
			if (player.getEvasionRoll()) outputText("  You sidestep the attack just as she thrusts the point past your face.");
			//[else block]
			else if (damage < 0) outputText("  With all your strength, you swing your [weapon], the blow landing on the side of Minerva's halberd and deflecting the goring strike away from you.");
			//[if attack lands]
			else {
				outputText("  She pierces you right in the shoulder!  You wince in pain and step back, out of her reach again.");
				player.takePhysDamage(damage, true);
			}
		}

//Halberd CHOP:
		private function minervaUsesHalberdCHOP():void
		{
			outputText("She moves in close, practically right in front of you and raises the halberd.");
			var damage:int = int((str + 100) - rand(player.tou) - player.armorDef);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 12) damage += 400;
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 8) damage += 200;
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 4) damage += 100;
			if (player.getEvasionRoll()) outputText("  You get out of the way quickly, her attack chopping deeply into the earth. ");
			//[else block]
			else if (damage < 0) outputText("  In a mad show of pure skill, you lift your hands, clamping them down on the cheeks of the halberd blade and stop Minerva's attack cold, bewildering the siren in the process.");
			//[if attack lands]
			else {
				outputText("  You don't have time to avoid the downward chop and the axe head lands right in your shoulder blade!  You cry out in pain, but you can still move your arm despite the brutal blow.");
				player.takePhysDamage(damage, true);
			}
		}

//White Fire
		private function kiteFire():void
		{
			var inteused:Number = inte;
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 12) inteused *= 4;
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 8) inteused *= 3;
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 4) inteused *= 2;
			var damage:int = int(10 + (inteused / 3 + rand(inteused / 2)) * 1.5);
			damage = Math.round(damage);
			if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				player.addStatusValue(StatusEffects.Blizzard,1,-1);
				outputText("The siren holds her hand out, flashing you a cunning smirk and snapping her fingers.  Your entire body is engulfed in white-hot flames, searing flesh and burning your [armor].  The sudden flash of heat and fire elicit panic from deep within you, causing you to cry out and roll on the ground to put the fires out.  The burns aren't too severe due to surrounding your blizzard, but you know you can't keep getting hit like that! ");
				damage *= 0.2;
			}
			else {
				outputText("The siren holds her hand out, flashing you a cunning smirk and snapping her fingers.  Your entire body is engulfed in white-hot flames, searing flesh and burning your [armor].  The sudden flash of heat and fire elicit panic from deep within you, causing you to cry out and roll on the ground to put the fires out.  The burns aren't too severe, but you know you can't keep getting hit like that! ");
			}
			damage = Math.round(damage);
			player.takeFireDamage(damage, true);
		}

//Lust Attacks for tainted Minerva
//Booty-shorts
		private function bootyShortInYoFaceSon():void
		{
			outputText("The blue beauty turns around and bends over so far that she uses her halberd like a pole to support herself.  She lifts her shark tail up so you can see her short-shorts hugging perfectly against her ample bottom.  Her tail waves to the left and to the right as she does a little booty shake for you.  The siren gives her big ass a nice, hard slap that echoes off the tower walls, and making it jiggle even more.  She quickly turns around to face you, smirking at what she just did. ");
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 12) player.dynStats("lus", 50 + player.lib / 10 + rand(8));
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 8) player.dynStats("lus", 40 + player.lib / 10 + rand(7));
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 4) player.dynStats("lus", 30 + player.lib / 10 + rand(6));
			else player.dynStats("lus", 20 + player.lib / 10 + rand(5));
		}

//Lust Attacks for all Minervas
//Pole licking
		private function lickDatPole():void
		{
			outputText("Minerva stands, holding her halberd straight up next to her as she looks it over with a seductive stare.  Giving you a suggestive look she rolls out a two-foot long tongue from her mouth, licking a good length of the massive weapon, even wrapping her tongue around it a few times.  Suddenly she sucks her tongue back into her mouth and gives you a little smirk, almost to say \"<i>Yeah, I can do that... and more.</i>\" ");
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 12) player.dynStats("lus", 50 + player.lib / 10 + rand(8));
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 8) player.dynStats("lus", 40 + player.lib / 10 + rand(7));
			else if (flags[kFLAGS.MINERVA_LVL_UP] >= 4) player.dynStats("lus", 30 + player.lib / 10 + rand(6));
			else player.dynStats("lus", 20 + player.lib / 10 + rand(5));
		}

//Special attack
		private function sirensSong():void
		{
			//The Siren's Song (2-part attack) (Rarely used or when she's desperate aka: Less than 10% hp)
			//[part 1]
			if (!hasStatusEffect(StatusEffects.SirenSong)) {
				outputText("Minerva begins to hum a pleasant tune.  It might be better to stand back to see what she's up to!");
				createStatusEffect(StatusEffects.SirenSong, 0, 0, 0, 0);
			}
			//[part 2]
			else {
				outputText("Her hum becomes a song.  A magnificent song without words, a sound that should be impossible for any human, or creature for that matter, to make naturally.");
				//If wait:
				if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) outputText("  You cover your ears before she even opens her lips, wary of its power.  Judging by the dim feeling of pleasure simmering through you with the little sound you're picking up regardless, it probably was for the better.");
				//No wait - insta loss:
				else {
					outputText("  Your mind clouds over as the song flows through your ears and fills your mind with sweet bliss.");
					player.dynStats("lus", 1000);
					if (player.lust >= player.maxOverLust()) outputText("  You lower your [weapon] and dreamily walk into the siren's sweet embrace.  You absent-mindedly disrobe yourself as you move in closer, the song getting louder with each step you take, until you finally bury yourself into the siren's soft bosom and she wraps her feathery arms around your body.  She stops singing her beautiful song and whispers into your ear, \"<i>You're all mine now.</i>\"");
				}
				removeStatusEffect(StatusEffects.SirenSong);
			}
		}

		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.SirenSong)) sirensSong();
			else if (rand(25) == 0 || (HP < 100 && rand(2) == 0)) sirensSong();
			//Else choose randomly!
			else {
				var choices:Array = [lickDatPole,
					bootyShortInYoFaceSon,
					kiteFire,
					minervaUsesHalberdCHOP,
					minervaUsesHalberdStab,
					tailWhip,
					minervaKnowsKungfu,
					minervaBite];
				choices[rand(choices.length)]();
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.highMountains.minervaScene.beatUpDatSharpie();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			SceneLib.highMountains.minervaScene.loseToMinerva();
		}

		public function Minerva()
		{
			if (flags[kFLAGS.MINERVA_LVL_UP] < 1) {
				initStrTouSpeInte(64, 80, 110, 75);
				initWisLibSensCor(70, 30, 25, 45);
				this.weaponAttack = 50;
				this.armorDef = 7;
				this.armorMDef = 2;
				this.bonusHP = 470;
				this.bonusLust = 78;
				this.level = 23;//potem zrobic jak purification udane to dostaje nieco lvl up i stat up tez
				this.additionalXP = 50;
			}
			else if (flags[kFLAGS.MINERVA_LVL_UP] == 12) {
				initStrTouSpeInte(268, 320, 350, 255);
				initWisLibSensCor(250, 162, 145, 45);
				this.weaponAttack = 170;
				this.armorDef = 31;
				this.armorMDef = 14;
				this.bonusHP = 6110;
				this.bonusLust = 402;
				this.level = 95;
				this.additionalXP = 650;
			}
			else {	//leave min and max levels to easily balance npc combat
				var lvlMulti:Number = flags[kFLAGS.MINERVA_LVL_UP];
				initStrTouSpeInte(64 + 17*lvlMulti, 80 + 20*lvlMulti, 110 + 20*lvlMulti, 75 + 15*lvlMulti);
				initWisLibSensCor(70 + 15*lvlMulti, 30 + 11*lvlMulti, 25 + 10*lvlMulti, 45);
				this.weaponAttack = 50 + 10*lvlMulti;
				this.armorDef = 7 + 2*lvlMulti;
				this.armorMDef = 2 + lvlMulti;
				this.bonusHP = 470 + 470*lvlMulti;
				this.bonusLust = 78 + 27*lvlMulti;
				this.level = 23 + 6*lvlMulti;
				this.additionalXP = 50 + 50*lvlMulti;
			}//level up giving 2x all growns and so follow next level ups's as long each npc break lvl 100 (also makes npc use new better gear)
			this.a = "";
			this.short = "Minerva";
			//Set imageName based on pure/corrupt
			if (flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] >= 10) this.imageName = "minervapure";
			else if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] >= 10) this.imageName = "minervacorrupt";
			else this.imageName = "minerva";
			//Set description based on pure/corrupt
			if (flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] >= 10) this.long = "You're fighting the purified siren, Minerva.  Standing around eight feet and wielding a weapon just as tall, she is a force to be reckoned with.  Her skin is a golden yellow, though her belly, neck and inner thighs are as white as the clouds in the sky, and a golden piecing decorates her navel.  White stripes adorn her legs, tail and back.  Two large wings sprout from her back, their feathers an attention-grabbing white and .  She wears a tube-top that hold back her G-cups, and short shorts around her wide waist that seem to be holding back a huge bulge.\n\nHer weapon is a halberd, made from a shiny, silvery metal, and seems to have an unnatural glow to it.";
			else if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] >= 10) this.long = "You're fighting the corrupted siren, Minerva.";
			else this.long = "You're fighting the tainted siren, Minerva.  Standing around eight feet and wielding a weapon just as tall, she is a force to be reckoned with.  Her skin is a dark navy blue, though her belly, neck and inner thighs are as white as the clouds in the sky, and a golden piecing decorates her navel.  Orange and white stripes adorn her legs, tail and back.  Two large wings sprout from her back, their feathers an attention-grabbing red and orange mix.  She wears a tube-top that hold back her double D-cups, and short shorts around her wide waist that seem to be holding back a huge bulge.\n\nHer weapon is a halberd, made from a shiny, silvery metal, and seems to have an unnatural glow to it.";
			// this.plural = false;
			this.createCock(16, 3);
			if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] >= 10) this.createCock(16, 3); //Second cock for corrupted Minerva.
			this.balls = 2;
			this.ballSize = 3;
			if (flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] >= 10 || flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] >= 10) ballSize += 2;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_NORMAL);
			//Set breast size based on pure/corrupt
			if (flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] >= 10) createBreastRow(Appearance.breastCupInverse("G"));
			else if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] >= 10) createBreastRow(Appearance.breastCupInverse("E"));
			else createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 8*12+4;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.skinTone = "blue";
			this.hairColor = "red";
			this.hairLength = 25;
			if (flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] >= 10) cor = 0; //Set to 0 corruption if purified.
			if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] >= 10) cor = 80; //Set to 80 corruption if corrupted.
			this.weaponName = "halberd";
			this.weaponVerb="slash";
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = game.armors.TUBETOP.name;
			this.armorPerk = "";
			this.armorValue = 5;
			this.lust = 20;
			this.lustVuln = .2;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.gems = rand(40)+25;
			this.drop = new WeightedDrop(consumables.PURPEAC, 1);
			this.wings.type = Wings.HARPY;
			this.wings.desc = "fluffy feathery";
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 1) this.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 2) this.createPerk(PerkLib.JobBrawler, 0, 0, 0, 0);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 3) this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 4) this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 5) this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 6) this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 7) this.createPerk(PerkLib.LegendaryStrength, 0, 0, 0, 0);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 8) this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 9) this.createPerk(PerkLib.LegendarySpeed, 0, 0, 0, 0);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 10) this.createPerk(PerkLib.PrestigeJobTempest, 0, 0, 0, 0);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 11) this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			if (flags[kFLAGS.MINERVA_LVL_UP] >= 12) this.createPerk(PerkLib.MythicalSpeed, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
