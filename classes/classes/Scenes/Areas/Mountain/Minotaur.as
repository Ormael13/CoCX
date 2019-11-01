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
		
		override protected function performCombatAction():void
		{
			if (player.hasStatusEffect(StatusEffects.EbonLabyrinthB)) {
				if (rand(4) == 0) special1();
				else {
					createStatusEffect(StatusEffects.Attacks, 1, 0, 0, 0);
					eAttack();
				}
			}
			else {
				if (rand(4) == 0) special1();
				else eAttack();
			}
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
				initStrTouSpeInte(350, 300, 175, 100);
				initWisLibSensCor(100, 120 + this.ballSize * 3, 45 + this.ballSize * 3, 35);
				this.weaponName = "pair of deadly battle axes";
				this.weaponVerb = "cleave";
				this.weaponAttack = 100;
				this.armorName = "steel full plate";
				this.armorDef = 75;
				this.armorMDef = 15;
				this.bonusHP = 200 + rand(this.ballSize * 3);
				this.bonusLust = 40 + rand(this.ballSize * 4);
				this.level = 65;
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
				this.bonusLust = 30 + rand(this.ballSize * 3);
				this.level = hasAxe?15:12;
				if (hasAxe) {
					this.drop = new WeightedDrop(consumables.MINOBLO, 1);
				} else {
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
			this.special1 = SceneLib.mountain.minotaurScene.minoPheromones;
			this.tailType = Tail.COW;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
