package classes.Scenes.Areas.Mountain
{

import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.*;

/**
	 * ...
	 * @author Fake-Name
	 */


	public class Minotaur extends Monster
	{
		public var hasAxe:Boolean;

		public var hasTwoAttacks:Boolean = false;

		override public function eAttack():void {
			if (hasTwoAttacks) {
				createStatusEffect(StatusEffects.Attacks, 1, 0, 0, 0);
			}
			super.eAttack();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			/*if (player.hasStatusEffect(StatusEffects.EbonLabyrinthB)) {
				SceneLib.mountain.minotaurScene.minoVictoryRapeChoices();
			} else */if (hasStatusEffect(StatusEffects.PhyllaFight)) {
				removeStatusEffect(StatusEffects.PhyllaFight);
				outputText("You defeat a minotaur!  ", true);
				SceneLib.desert.antsScene.phyllaBeatAMino();
			} else {
				SceneLib.mountain.minotaurScene.minoVictoryRapeChoices();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.EbonLabyrinthB)) {
				SceneLib.mountain.minotaurScene.getRapedByMinotaur();
			} else if (hasStatusEffect(StatusEffects.PhyllaFight)) {
				removeStatusEffect(StatusEffects.PhyllaFight);
				SceneLib.desert.antsScene.phyllaPCLostToMino();
			} else if (pcCameWorms){
				outputText("\n\nThe minotaur picks you up and forcibly tosses you from his cave, grunting in displeasure.");
				cleanupAfterCombat();
			} else
				SceneLib.mountain.minotaurScene.getRapedByMinotaur();
		}

		override public function get long():String
		{
			if (player.hasStatusEffect(StatusEffects.EbonLabyrinthB)) return "This minotaur, attired with a steel full plate and a pair of deadly battle axes, is easily eight feet tall. True to his species nature, his huge equine cock is already dripping with precum in anticipation."
			else return "An angry-looking minotaur looms over you.  Covered in shaggy " + hairColor + " fur, the beast is an imposing sight.  Wearing little but an obviously distended loincloth, he is clearly already plotting his method of punishment.  Like most minotaurs he has hooves, a cow-like tail and face, prominent horns, and impressive musculature. "+
					(ballSize > 4?("  Barely visible below the tattered shreds of loincloth are " + Appearance.ballsDescription(true, true, this) + ", swollen with the minotaur's long pent-up need."):"")+
					(hasAxe?"<b>This minotaur seems to have found a deadly looking axe somewhere!</b>":"");
		}

		public function Minotaur(axe:Boolean=false)
		{
			//Most times they dont have an axe
			hasAxe = axe || rand(3)==0;
			var furColor:String = randomChoice("black","brown");

			trace("Minotaur Constructor!");
			trace(game.flags);
			if (player.hasStatusEffect(StatusEffects.EbonLabyrinthB)) {
				this.short = "labyrinth minotaur";
				this.weaponName = "pair of deadly battle axes";
				this.weaponVerb = "cleave";
				this.armorName = "steel full plate";
				if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 250) {
					initStrTouSpeInte(475, 400, 275, 125);
					initWisLibSensCor(125, 170 + this.ballSize * 5, 70 + this.ballSize * 5, 35);
					this.weaponAttack = 154;
					this.armorDef = 200;
					this.armorMDef = 40;
					this.bonusHP = 450 + rand(this.ballSize * 5);
					this.bonusLust = 325 + this.ballSize * 16 + rand(this.ballSize * 9);
					this.level = 85;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 200) {
					initStrTouSpeInte(450, 380, 255, 120);
					initWisLibSensCor(120, 160 + this.ballSize * 7, 65 + this.ballSize * 7, 35);
					this.weaponAttack = 154;
					this.armorDef = 175;
					this.armorMDef = 35;
					this.bonusHP = 400 + rand(this.ballSize * 5);
					this.bonusLust = 306 + this.ballSize * 14 + rand(this.ballSize * 8);
					this.level = 81;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 150) {
					initStrTouSpeInte(425, 360, 235, 115);
					initWisLibSensCor(115, 150 + this.ballSize * 6, 60 + this.ballSize * 6, 35);
					this.weaponAttack = 154;
					this.armorDef = 150;
					this.armorMDef = 30;
					this.bonusHP = 350 + rand(this.ballSize * 5);
					this.bonusLust = 287 + this.ballSize * 12 + rand(this.ballSize * 7);
					this.level = 77;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 100) {
					initStrTouSpeInte(400, 340, 215, 110);
					initWisLibSensCor(110, 140 + this.ballSize * 5, 55 + this.ballSize * 5, 35);
					this.weaponAttack = 154;
					this.armorDef = 125;
					this.armorMDef = 25;
					this.bonusHP = 300 + rand(this.ballSize * 5);
					this.bonusLust = 268 + this.ballSize * 10 + rand(this.ballSize * 6);
					this.level = 73;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 50) {
					initStrTouSpeInte(375, 320, 195, 105);
					initWisLibSensCor(105, 130 + this.ballSize * 4, 50 + this.ballSize * 4, 35);
					this.weaponAttack = 127;
					this.armorDef = 100;
					this.armorMDef = 20;
					this.bonusHP = 250 + rand(this.ballSize * 4);
					this.bonusLust = 249 + this.ballSize * 8 + rand(this.ballSize * 5);
					this.level = 69;
				}
				else {
					initStrTouSpeInte(350, 300, 175, 100);
					initWisLibSensCor(100, 120 + this.ballSize * 3, 45 + this.ballSize * 3, 35);
					this.weaponAttack = 100;
					this.armorDef = 75;
					this.armorMDef = 15;
					this.bonusHP = 200 + rand(this.ballSize * 3);
					this.bonusLust = 230 + this.ballSize * 6 + rand(this.ballSize * 4);
					this.level = 65;
				}
				this.drop = new ChainedDrop().add(weapons.DL_AXE_, 1 / 8)
						.add(consumables.MINOCUM, 1 / 5)
						.add(consumables.MINOBLO, 1 / 2)
						.elseDrop(null);
			}
			else {
				this.short = "minotaur";
				initStrTouSpeInte(hasAxe ? 100 : 75, 70, 35, 20);
				initWisLibSensCor(20, 40 + this.ballSize * 2, 15 + this.ballSize * 2, 35);
				this.weaponName = hasAxe?"axe":"fist";
				this.weaponVerb = hasAxe?"cleave":"punch";
				this.weaponAttack = hasAxe?50:40;
				this.armorName = "thick fur";
				this.armorDef = 12;
				this.armorMDef = 1;
				this.bonusHP = 20 + rand(this.ballSize * 2);
				this.level = hasAxe?15:12;
				if (hasAxe) {
					this.bonusLust = 70 + this.ballSize * 4 + rand(this.ballSize * 3);
					this.drop = new WeightedDrop(consumables.MINOBLO, 1);
				} else {
					this.bonusLust = 68 + this.ballSize * 4 + rand(this.ballSize * 3);
					this.drop = new ChainedDrop().add(consumables.MINOCUM, 1 / 5)
							.add(consumables.MINOBLO, 1 / 2)
							.elseDrop(null);
				}
			}
			this.a = "the ";
			this.imageName = "minotaur";
			this.long = "";
			// this.plural = false;
			this.createCock(rand(13)+ 24,2 + rand(3),CockTypesEnum.HORSE);
			this.balls = 2;
			this.ballSize = 2 + rand(13);
			this.cumMultiplier = 1.5;
			this.hoursSinceCum = this.ballSize * 10;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = rand(37) + 84;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE;
			this.lowerBody = LowerBody.HOOFED;
			this.skin.growFur({color:furColor});
			this.skinDesc = "shaggy fur";
			this.hairColor = furColor;
			this.hairLength = 3;
			this.faceType = Face.COW_MINOTAUR;
			this.lust = this.ballSize * 3;
			this.lustVuln = hasAxe?0.84:0.87;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.gems = rand(15) + 15;
			this.abilities = [
				{call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[], weight: 3},
				{call: SceneLib.mountain.minotaurScene.minoPheromones, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[]}
			];
			if (player.hasStatusEffect(StatusEffects.EbonLabyrinthB)) {
				hasTwoAttacks = true;
			}
			this.tailType = Tail.COW;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
