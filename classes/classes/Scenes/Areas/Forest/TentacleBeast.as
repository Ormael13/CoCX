package classes.Scenes.Areas.Forest
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class TentacleBeast extends Monster
	{
		
		private function tentaclePhysicalAttack():void {
			outputText("The shambling horror throws its tentacles at you with a murderous force.\n");
			var temp:int = int((str + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
			if (inDungeon) temp += str + weaponAttack;
			if(temp < 0) temp = 0;
			//Miss
			if(temp == 0 || (player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80)) {
				outputText("However, you quickly evade the clumsy efforts of the abomination to strike you.");
			}
			//Hit
			else {
				outputText("The tentacles crash upon your body mercilessly. ");
				player.takePhysDamage(temp, true);
			}
		}
		private function tentacleEntwine():void {
			outputText("The beast lunges its tentacles at you from all directions in an attempt to immobilize you.\n");
			//Not Trapped yet
			if(!player.hasStatusEffect(StatusEffects.TentacleBind)) {
				//Success
				if(int(Math.random()*(((player.spe)/2))) > 15 || (player.hasPerk(PerkLib.Evade) && int(Math.random()*(((player.spe)/2))) > 15)) {
					outputText("In an impressive display of gymnastics, you dodge, duck, dip, dive, and roll away from the shower of grab-happy arms trying to hold you. Your instincts tell you that this was a GOOD thing.\n");
				}
				//Fail
				else {
					outputText("While you attempt to avoid the onslaught of pseudopods, one catches you around your [foot] and drags you to the ground. You attempt to reach for it to pull it off only to have all of the other tentacles grab you in various places and immobilize you in the air. You are trapped and helpless!!!\n\n");
					//Male/Herm Version:
					if(player.hasCock()) outputText("The creature, having immobilized you, coils a long tendril about your penis. You shudder as the creature begins stroking your cock like a maid at a dairy farm in an attempt to provoke a response from you. Unable to resist, your [cock] easily becomes erect, signaling to the creature that you are responsive to harsher stimulation.\n");
					//Female Version:
					else if(player.hasVagina()) outputText("The creature quickly positions a long tentacle with a single sucker over your clitoris. You feel the power of the suction on you, and your body quickly heats up.  Your clit engorges, prompting the beast to latch the sucker onto your [clit].\n");
					//Genderless
					else outputText("The creature quickly positions a long tentacle against your " + Appearance.assholeDescript(player) + ". It circles your pucker with slow, delicate strokes that bring unexpected warmth to your body.\n");
					player.dynStats("lus", (8+player.effectiveSensitivity()/20));
					player.createStatusEffect(StatusEffects.TentacleBind,0,0,0,0);
				}
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			player.removeStatusEffect(StatusEffects.TentacleBadEndCounter); //clear counter
			if (hpVictory) {
				outputText("The creature lets out an ear-piercing screech as it collapses upon itself. Its green coloring quickly fades to brown as the life drains from it, leaving you victorious.", true);
				EngineCore.awardAchievement("Tentacle Beast Slayer", kACHIEVEMENTS.GENERAL_TENTACLE_BEAST_SLAYER);
			} else {
				outputText("The tentacle beast's mass begins quivering and sighing, the tentacles wrapping around each other and feverishly caressing each other.  It seems the beast has given up on fighting.");
			}
			if (player.hasStatusEffect(StatusEffects.SoulArenaGaunlet)) {
				SceneLib.hexindao.gaunletchallange1fight3();
			}
			else if (hasStatusEffect(StatusEffects.PhyllaFight)) {
				removeStatusEffect(StatusEffects.PhyllaFight);
				SceneLib.desert.antsScene.phyllaTentacleDefeat();
			}
			else if (inDungeon) cleanupAfterCombat(); //EL check
			else if (flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] < 1 && rand(4) == 0) {// && rand(10) == 0-na razie zamiast 10% szansa podniesiona do 25%		move to diff stronger variant of tentacle beast later on?
				outputText("\n\nAs the tentacle beast runs away in defeat you discover to your surprise it left behind a somewhat passed out bee girl. At first, you are worried that she might be dead but, as she thankfully regains consciousness, she crawls to you, grabbing your leg for a plea.\n\n");
				outputText("\"<i>Y..you ought to help uzz, our hive is under siege by corrupted sisterzzz if no one does anything my queen will… she…</i>\"\n\n");
				outputText("The bee points toward a gigantic structure in the far distance.\n\n");
				outputText("\"<i>Pleazzze zzzave the queen!</i>\"\n\n");
				outputText("Seems you have a quest and as a champion, it is your duty to accomplish it.\n\n");
				outputText("<b>You found the Hive!</b>\n\n");
				flags[kFLAGS.DISCOVERED_BEE_HIVE_DUNGEON] = 1;
				cleanupAfterCombat();
			}
			else {
				if(!hpVictory && player.gender > 0)
					SceneLib.forest.tentacleBeastScene.tentacleVictory();
				else {
					sceneHunter.print("Maybe lust-defeat would leave more opportunities?");
					cleanupAfterCombat();
				}
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (inDungeon) SceneLib.forest.tentacleBeastScene.defeatedByAncientTentacleBeast(); //EL check
			else {
				if (hpVictory) {
					outputText("Overcome by your wounds, you turn to make a last desperate attempt to run...\n\n");
					if (hasStatusEffect(StatusEffects.PhyllaFight)) {
						removeStatusEffect(StatusEffects.PhyllaFight);
						outputText("...and make it into the nearby tunnel.  ");
						SceneLib.desert.antsScene.phyllaTentaclePCLoss();
					} else
						SceneLib.forest.tentacleBeastScene.tentacleLossRape();
				} else {
					outputText("You give up on fighting, too aroused to resist any longer.  Shrugging, you walk into the writhing mass...\n\n");
					if(hasStatusEffect(StatusEffects.PhyllaFight)) {
						removeStatusEffect(StatusEffects.PhyllaFight);
						outputText("...but an insistent voice rouses you from your stupor.  You manage to run into a nearby tunnel.  ");
						SceneLib.desert.antsScene.phyllaTentaclePCLoss();
					} else
						doNext(SceneLib.forest.tentacleBeastScene.tentacleLossRape);
				}
			}
		}

		public function TentacleBeast()
		{
			trace("TentacleBeast Constructor!");
			if (inDungeon) { //EL check
                var mod:int = SceneLib.dungeons.ebonlabyrinth.enemyLevelMod;
				this.short = "ancient tentacle beast";
				this.long = "You see the titanic, shambling form of the tentacle beast before you.  Appearing as a massive shrub, it shifts its bulbous mass and reveals a collection of thorny tendrils and cephalopodic limbs.";
				initStrTouSpeInte(292 + 31*mod, 320 + 40*mod, 150 + 10*mod, 120 + 5*mod);
                initWisLibSensCor(100 + 5*mod, 270, 60 + 5*mod, 100);
                this.weaponAttack = 50 + 10*mod;
                this.armorDef = 90 + 45*mod;
                this.armorMDef = 30 + 10*mod;
                this.bonusHP = 4000 + 4000*mod;
                this.bonusLust = 390 + 9*mod;
                this.level = 60 + 5*mod;
                this.additionalXP = int(250 * Math.exp(0.3*mod));
                this.gems = int((rand(50)+25) * Math.exp(0.3*mod));
			}
			else {
				this.short = "tentacle beast";
				this.long = "You see the massive, shambling form of the tentacle beast before you.  Appearing as a large shrub, it shifts its bulbous mass and reveals a collection of thorny tendrils and cephalopodic limbs.";
				initStrTouSpeInte(73, 90, 25, 45);
				initWisLibSensCor(40, 90, 20, 100);
				this.weaponAttack = 10;
				this.armorDef = 18;
				this.armorMDef = 2;
				this.bonusHP = 400;
				this.bonusLust = 122;
				this.level = 11;
			    this.gems = rand(25)+10;
			}
			this.a = "the ";
			this.imageName = "tentaclebeast";
			// this.plural = false;
			this.createCock(40,1.5);
			this.createCock(60,1.5);
			this.createCock(50,1.5);
			this.createCock(20,1.5);
			this.balls = 0;
			this.ballSize = 0;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.pronoun1 = "it";
			this.pronoun2 = "it";
			this.pronoun3 = "its";
			this.createBreastRow(0,0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 70;
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_BUTTLESS;
			this.skin.setBaseOnly({color:"green"});
			this.skinDesc = "bark";
			this.hairColor = "green";
			this.hairLength = 1;
			this.weaponName = "whip-tendril";
			this.weaponVerb="thorny tendril";
			this.armorName = "rubbery skin";
			this.lust = 10;
			this.lustVuln = 0.8;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.drop = new WeightedDrop().addMany(1,consumables.HEALHERB,
					consumables.HEALHERB,
					consumables.HEALHERB,
					consumables.MOONGRASS,
					consumables.SNAKEBANE,
					consumables.IRONWEED,
					consumables.BLADEFERN);
			this.abilities = [
				{ call: tentaclePhysicalAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[], condition: function():Boolean { return hasStatusEffect(StatusEffects.TentacleCoolDown) }},
				{ call: tentacleEntwine, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[]},
			]
			this.tailType = Tail.DEMONIC;
			checkMonster();
		}

	}

}
