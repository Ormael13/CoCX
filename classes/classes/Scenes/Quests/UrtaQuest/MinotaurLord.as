package classes.Scenes.Quests.UrtaQuest
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Items.WeaponLib;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;



	public class MinotaurLord extends Monster
	{

		override protected function performCombatAction():void
		{
			if (HP < 300 && statusEffectv1(StatusEffects.MinoMilk) < 4 && flags[kFLAGS.URTA_QUEST_STATUS] == 0.75) minotaurDrankMalk();
			else if (rand(4) == 0 && player.weaponName != "fists") minotaurDisarm();
			else if (!hasStatusEffect(StatusEffects.Timer)) minotaurLordEntangle();
			else if (player.hasStatusEffect(StatusEffects.MinotaurEntangled)) minotaurCumPress();
			else {
				if (rand(2) == 0) minotaurPrecumTease();
				else eAttack();
			}
		}

		private function minotaurDrankMalk():void //Only procs during Urta's quest.
		{
			outputText("The minotaur lord snorts audibly and turns to look at his mistress.  \"<i>What is it, Fido, boy?  You thirsty?</i>\"  The hulking minotaur nods.");
			//Success:*
			if (statusEffectv1(StatusEffects.MinoMilk) < 3) {
				outputText("\"<i>Catch!</i>\"  The succubus throws a bottle containing a milky-white substance to the minotaur.  He grabs it and uncorks the bottle, quickly chugging its contents with obvious enjoyment.  After he is done he looks even more energetic and ready to fight, and his cock looks even harder!");
				addHP(300);
				lust += 10;
				if (!hasStatusEffect(StatusEffects.MinoMilk))
					createStatusEffect(StatusEffects.MinoMilk, 1, 0, 0, 0);
				else
					addStatusValue(StatusEffects.MinoMilk, 1, 1);
			}
			//Failure:*
			else {
				outputText("\"<i>Well too bad!  We're all out of milk... but don't worry, my dear pet, I'll let you drink as much as you want after you're done with this bitch.</i>\"  The succubus replies, idly checking her elongated nails.");
				outputText("\n\nThe minotaur glares at you and snorts, obviously pissed at not getting his serving...");
				addStatusValue(StatusEffects.MinoMilk, 1, 1);
			}
		}

		private function minotaurDisarm():void
		{
			if (player.hasPerk(PerkLib.ShieldWard) && rand (2) == 0) {
				outputText("The giant of a minotaur raises his chain threateningly into the air, clearly intent on striking you down.  With your trained reflexes, you quickly move to block his blow with your [shield].  You recoil as the chain impacts your [shield] with a loud clang, bouncing off it.  You smile triumphantly at the minotaur, only to notice his smirk fading away.  ");
			}
			else {
				if (flags[kFLAGS.URTA_QUEST_STATUS] == 0.75) {
					outputText("The giant of a minotaur raises his chain threateningly into the air, clearly intent on striking you down.  With your trained reflexes, you quickly move to block his blow with your halberd.  You recoil as the chain impacts your halberd with a loud clang, wrapping around it.  You smile triumphantly at the minotaur, only to glance at his smirk.  With a strong pull, he rips the halberd off your hands and into a corner of the room. Shit!");
					outputText("\n\nThe succubus laughs maniacally.  \"<i>Good boy, Fido!  Take that fox slut's toys away so she'll be easier to play with!</i>\"  The minotaur puffs his chest, proud of himself for pleasing his mistress.");
				//	player.setWeapon(WeaponLib.FISTS);
				}
				else {
				outputText("The giant of a minotaur raises his chain threateningly into the air, clearly intent on striking you down.  With your trained reflexes, you quickly move to block his blow with your [weapon].  You recoil as the chain impacts your [weapon] with a loud clang, wrapping around it.  You smile triumphantly at the minotaur, only to glance at his smirk.  ");
					if (player.weaponName != "fists") {
						outputText("With a strong pull, he yanks your [weapon] off your hands and into a corner of the room. Shit!");
					//	flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = player.weapon.id;
					//	flags[kFLAGS.PLAYER_DISARMED_WEAPON_ATTACK] = player.weaponAttack;
					//	player.setWeapon(WeaponLib.FISTS);
					//	player.createStatusEffect(StatusEffects.Disarmed, 2, 0, 0, 0);
					}
				}
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = player.weapon.id;
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_ATTACK] = player.weaponAttack;
				player.setWeapon(WeaponLib.FISTS);
				player.createStatusEffect(StatusEffects.Disarmed, 2, 0, 0, 0);
			}
		}

		private function minotaurLordEntangle():void
		{
			outputText("The minotaur lord lashes out with his chain, swinging in a wide arc!\n");
			createStatusEffect(StatusEffects.Timer, 2 + rand(4), 0, 0, 0);
			//{dodge/whatever}
			if (player.getEvasionRoll()) {
				outputText("You leap over the clumsy swing, allowing the chain to fly harmlessly underneath you!");
			}
			else {
				outputText("You try to avoid it, but you're too slow, and the chain slaps into your hip, painfully bruising you with the strength of the blow, even through your armor.  The inertia carries the back half of the whip around you, and in a second, the chain has you all wrapped up with your arms pinned to your sides and your movement restricted.");
				if (flags[kFLAGS.URTA_QUEST_STATUS] == 0.75) outputText("\n\n\"<i>Hahaha!  Good boy, Fido!  Leash that bitch up!</i>\"  The succubus laughs with glee.");
				outputText("\n\n<b>You're tangled up in the minotaur lord's chain, and at his mercy, unless you can break free!</b>");
				player.createStatusEffect(StatusEffects.MinotaurEntangled, 0, 0, 0, 0);
			}
		}

		private function minotaurCumPress():void
		{
			outputText("The minotaur lord tugs on the end of the chain, pulling you toward him, making you spin round and round so many times that you're dazed and dizzy.  You can feel the links coming free of your " + player.skinFurScales() + ", and the closer you get, the more freedom of movement you have.  Yet, the dizziness makes it hard to do anything other than stumble.  You splat into something wet, sticky, and spongy.  You gasp, breathing a heavy gasp of minotaur musk that makes your head spin in a whole different way.  You pry yourself away from the sweaty, sperm-soaked nuts you landed on and look up, admiring the towering horse-cock with its three-rings of pre-puce along its length.  A droplet of pre-cum as fat as your head smacks into your face, staggering you back and dulling your senses with narcotic lust.");
			player.takeLustDamage(22 + player.lib / 8 + player.effectiveSensitivity() / 8, true);
			outputText("You tumble to your knees a few feet away, compulsively licking it up.  Once it's gone, ");
			if (player.lust >= player.maxOverLust()) outputText("you rise up, horny and hungry for more.");
			else {
				outputText("you realize what you've been doing.  Your embarrassment gives you the strength to re-adopt your fighting pose, but it's hard with how ");
				if (player.hasCock()) {
					outputText("rigid");
					if (player.lust >= 80) outputText(" and drippy");
					outputText(" your cock has become.  ")
					
				}
				else if (player.hasVagina()) {
					outputText("wet your pussy has become.  ");
				}
				else {
					outputText("aroused you feel in your groin.  ");
				}
				outputText("You want another taste...");
			}
			player.removeStatusEffect(StatusEffects.MinotaurEntangled);
		}

		private function minotaurPrecumTease():void
		{
			outputText("The minotaur smiles at you and lifts his loincloth, flicking it at you.  Thick ropes of pre-cum fly through the air in a swarm,");
			if (rand(2) == 0) {
				outputText(" slapping into your face before you can react!  You wipe the slick snot-like stuff out of your eyes and nose, ");
				if (player.lust >= 70) outputText("swallowing it into your mouth without thinking.  You greedily guzzle the potent, narcotic aphrodisiac down, even going so far as to lick it from each of your fingers in turn, sucking every drop into your waiting gullet.");
				else outputText("feeling your heart hammer lustily.");
				player.takeLustDamage(15 + player.lib / 8 + player.effectiveSensitivity() / 8, true);
			}
			else {
				outputText(" right past your head, but the smell alone is enough to make you weak at the knees.");
				if (flags[kFLAGS.URTA_QUEST_STATUS] == 0.75) outputText("  The animalistic scent of it seems to get inside you, the musky aroma burning a path of liquid heat to your groin, stiffening your horse-cock to absurd degrees.");
				else outputText("  The animalistic scent of it seems to get inside you, the musky aroma burning a path of liquid heat to your groin.");
				player.takeLustDamage(11 + player.lib / 10, true);
			}
			//(1)
			if (player.lust <= 75) outputText("  You shiver with need, wanting nothing more than to bury your face under that loincloth and slurp out every drop of goopey goodness.");
			else outputText("  <b>You groan and lick your lips over and over, craving the taste of him in your mouth.</b>");
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.URTA_QUEST_STATUS] == 0.75 || CoC.instance.gameSettings.sceneHunter_inst._recalling) SceneLib.urtaQuest.winMinotaur();
			else SceneLib.mountain.minotaurScene.minoVictoryRapeChoices();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.URTA_QUEST_STATUS] == 0.75 || CoC.instance.gameSettings.sceneHunter_inst._recalling) {
				if (hpVictory) SceneLib.urtaQuest.urtaLosesToMinotaurRoughVersion();
				else SceneLib.urtaQuest.urtaSubmitsToMinotaurBadEnd();
			}
			else SceneLib.mountain.minotaurScene.getRapedByMinotaur();
		}

		public function MinotaurLord()
		{
			this.a = "the ";
			this.short = "minotaur lord";
			this.imageName = "minotaurlord";
			if (flags[kFLAGS.URTA_QUEST_STATUS] == 0.75) this.long = "Across from you is the biggest minotaur you've ever seen.  Fully eleven feet tall, this shaggy monstrosity has muscles so thick that they stand even through his thick, obscuring fur.  A leather collar with a tag indicates his status as 'pet' though it seems completely out of place on the herculean minotaur.  His legs and arms are like thick tree trunks, imposing and implacable, flexing fiercely with every movement.  This can only be a minotaur lord, a minotaur of strength and virility far beyond his lesser brothers. In his hands, a massive chain swings, connected to his collar, but used as an impromptu weapon for now.  A simple loincloth girds his groin, though it does little to hide the massive, erect length that tents it.  It winds up looking more like a simple, cloth condom than any sort of clothing, and it drips long strings of musky pre-slime in ribbons onto the ground.  Below, heavy testes, each easily the size of a basketball, swing in a taut, sloshing sack.  You can almost smell the liquid bounty he has for you, and the musk he's giving off makes it seem like a good idea...";
			else this.long = "Across from you is the biggest minotaur you've ever seen.  Fully eleven feet tall, this shaggy monstrosity has muscles so thick that they stand even through his thick, obscuring fur.  His legs and arms are like thick tree trunks, imposing and implacable, flexing fiercely with every movement.  This can only be a minotaur lord, a minotaur of strength and virility far beyond his lesser brothers. In his hands, a massive chain swings, connected to his collar, but used as an impromptu weapon for now.  A simple loincloth girds his groin, though it does little to hide the massive, erect length that tents it.  It winds up looking more like a simple, cloth condom than any sort of clothing, and it drips long strings of musky pre-slime in ribbons onto the ground.  Below, heavy testes, each easily the size of a basketball, swing in a taut, sloshing sack.  You can almost smell the liquid bounty he has for you, and the musk he's giving off makes it seem like a good idea...";
			// this.plural = false;
			this.createCock(rand(13 + 24),2 + rand(3),CockTypesEnum.HORSE);
			this.balls = 2;
			this.ballSize = 2 + rand(13);
			this.cumMultiplier = 1.5;
			this.hoursSinceCum = this.ballSize * 10;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,50,0,0,0);
			this.tallness = 132;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.lowerBody = LowerBody.HOOFED;
			this.skin.growFur({color:"red"});
			this.skinDesc = "shaggy fur";
			this.hairColor = randomChoice("black","brown");
			this.hairLength = 3;
			this.faceType = Face.COW_MINOTAUR;
			initStrTouSpeInte(25, 190, 150, 50);
			initWisLibSensCor(50, 170, 125, 70);
			this.weaponName = "chain";
			this.weaponVerb="chain-whip";
			this.weaponAttack = 99;
			this.armorName = "thick fur";
			this.armorDef = 120;
			this.armorMDef = 40;
			this.bonusHP = 1250 + rand(this.ballSize*5);
			this.bonusLust = 325 + rand(this.ballSize*4);
			this.lust = 50;
			this.lustVuln = 0.33;
			this.level = 30;
			this.additionalXP = 100;
			this.gems = rand(25) + 40;
			if (flags[kFLAGS.URTA_QUEST_STATUS] != 0.75) {
				this.drop = new ChainedDrop().add(consumables.MINOCUM, 1 / 5)
						.add(consumables.MINOBLO, 1 / 2)
						.elseDrop(null);
			}
			else this.drop = NO_DROP;
			this.tailType = Tail.COW;
			this.special1 = SceneLib.mountain.minotaurScene.minoPheromones;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}