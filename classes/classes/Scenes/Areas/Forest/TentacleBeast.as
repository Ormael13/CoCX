package classes.Scenes.Areas.Forest
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Places.HeXinDao;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class TentacleBeast extends Monster
	{
		public var golems:HeXinDao = new HeXinDao();
		
		private function tentaclePhysicalAttack():void {
			outputText("The shambling horror throws its tentacles at you with a murderous force.\n");
			var temp:int = int((str + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
			if (player.hasStatusEffect(StatusEffects.EbonLabyrinthB)) temp += str + weaponAttack;
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
				if(int(Math.random()*(((player.spe)/2))) > 15 || (player.findPerk(PerkLib.Evade) >= 0 && int(Math.random()*(((player.spe)/2))) > 15)) {
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
			if (hpVictory) {
				outputText("The creature lets out an ear-piercing screech as it collapses upon itself. Its green coloring quickly fades to brown as the life drains from it, leaving you victorious.", true);
				EngineCore.awardAchievement("Tentacle Beast Slayer", kACHIEVEMENTS.GENERAL_TENTACLE_BEAST_SLAYER);
			} else {
				outputText("The tentacle beast's mass begins quivering and sighing, the tentacles wrapping around each other and feverishly caressing each other.  It seems the beast has given up on fighting.");
			}
			if (player.hasStatusEffect(StatusEffects.SoulArenaGaunlet)) {
				golems.gaunletchallange1fight3();
			}
			else if (hasStatusEffect(StatusEffects.PhyllaFight)) {
				removeStatusEffect(StatusEffects.PhyllaFight);
				SceneLib.desert.antsScene.phyllaTentacleDefeat();
			}
			else if (player.hasStatusEffect(StatusEffects.EbonLabyrinthB)) cleanupAfterCombat();
			else {
				if(!hpVictory && player.gender > 0 && flags[kFLAGS.SFW_MODE] <= 0) {
					outputText("  Perhaps you could use it to sate yourself?", true);
					EngineCore.doYesNo(SceneLib.forest.tentacleBeastScene.tentacleVictoryRape,cleanupAfterCombat);
				} else {
					cleanupAfterCombat();
				}
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.EbonLabyrinthB)) SceneLib.dungeons.ebonlabyrinth.defeatedByAncientTentacleBeast();
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
			if (player.hasStatusEffect(StatusEffects.EbonLabyrinthB)) {
				this.short = "ancient tentacle beast";
				this.long = "You see the titanic, shambling form of the tentacle beast before you.  Appearing as a massive shrub, it shifts its bulbous mass and reveals a collection of thorny tendrils and cephalopodic limbs.";
				if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 250) {
					initStrTouSpeInte(447, 520, 200, 145);
					initWisLibSensCor(125, 270, 85, 100);
					this.weaponAttack = 100;
					this.armorDef = 315;
					this.armorMDef = 70;
					this.bonusHP = 24000;
					this.bonusLust = 435;
					this.level = 80;
					this.additionalXP = 750;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 200) {
					initStrTouSpeInte(416, 480, 190, 140);
					initWisLibSensCor(120, 270, 80, 100);
					this.weaponAttack = 90;
					this.armorDef = 270;
					this.armorMDef = 60;
					this.bonusHP = 20000;
					this.bonusLust = 426;
					this.level = 76;
					this.additionalXP = 650;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 150) {
					initStrTouSpeInte(385, 440, 180, 135);
					initWisLibSensCor(115, 270, 75, 100);
					this.weaponAttack = 80;
					this.armorDef = 225;
					this.armorMDef = 50;
					this.bonusHP = 16000;
					this.bonusLust = 417;
					this.level = 72;
					this.additionalXP = 550;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 100) {
					initStrTouSpeInte(354, 400, 170, 130);
					initWisLibSensCor(110, 270, 70, 100);
					this.weaponAttack = 70;
					this.armorDef = 180;
					this.armorMDef = 40;
					this.bonusHP = 12000;
					this.bonusLust = 408;
					this.level = 68;
					this.additionalXP = 450;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 50) {
					initStrTouSpeInte(323, 360, 160, 125);
					initWisLibSensCor(105, 270, 65, 100);
					this.weaponAttack = 60;
					this.armorDef = 135;
					this.armorMDef = 30;
					this.bonusHP = 8000;
					this.bonusLust = 399;
					this.level = 64;
					this.additionalXP = 350;
				}
				else {
					initStrTouSpeInte(292, 320, 150, 120);
					initWisLibSensCor(100, 270, 60, 100);
					this.weaponAttack = 50;
					this.armorDef = 90;
					this.armorMDef = 20;
					this.bonusHP = 4000;
					this.bonusLust = 390;
					this.level = 60;
					this.additionalXP = 250;
				}
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
				this.level = 12;
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
			this.gems = rand(25)+10;
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
