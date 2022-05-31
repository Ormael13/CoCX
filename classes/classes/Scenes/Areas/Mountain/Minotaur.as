package classes.Scenes.Areas.Mountain
{

import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
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
			if (hasStatusEffect(StatusEffects.PhyllaFight)) {
				removeStatusEffect(StatusEffects.PhyllaFight);
				outputText("You defeat a minotaur!  ", true);
				SceneLib.desert.antsScene.phyllaBeatAMino();
			} else {
				SceneLib.mountain.minotaurScene.minoVictoryRapeChoices();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (inDungeon) {
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
			if (inDungeon) return "This minotaur, attired with a steel full plate and a pair of deadly battle axes, is easily eight feet tall. True to his species nature, his huge equine cock is already dripping with precum in anticipation."
			else return "An angry-looking minotaur looms over you.  Covered in shaggy " + hairColor + " fur, the beast is an imposing sight.  Wearing little but an obviously distended loincloth, he is clearly already plotting his method of punishment.  Like most minotaurs he has hooves, a cow-like tail and face, prominent horns, and impressive musculature. "+
					(ballSize > 4?("  Barely visible below the tattered shreds of loincloth are " + Appearance.ballsDescription(true, true, this) + ", swollen with the minotaur's long pent-up need."):"")+
					(hasAxe?"<b>This minotaur seems to have found a deadly looking axe somewhere!</b>":"");
		}

		public function Minotaur(axe:Boolean=false)
		{
			//Most times they dont have an axe
			hasAxe = axe || rand(3)==0;
			var furColor:String = randomChoice("black","brown");

			trace(game.flags);
			if (inDungeon) {
				this.short = "labyrinth minotaur";
				this.weaponName = "pair of deadly battle axes";
				this.weaponVerb = "cleave";
				this.armorName = "steel full plate";
                var mod:int = SceneLib.dungeons.ebonlabyrinth.enemyLevelMod;
                initStrTouSpeInte(350 + 25*mod, 300 + 20*mod, 175 + 20*mod, 100 + 5*mod);
                initWisLibSensCor(
                    100 + 5*mod,
                    120 + 10*mod + this.ballSize * (3 + mod),
                    45 + 5*mod + this.ballSize * (3 + mod),
                    35);
                this.weaponAttack = 100 + 27*mod;
                this.armorDef = 75 + 25*mod;
                this.armorMDef = 15 + 5*mod;
                this.bonusHP = 200 + 50*mod + rand(this.ballSize * (3 + mod));
                this.bonusLust = 230 + 19*mod + this.ballSize * 2*(3 + mod) + rand(this.ballSize * (4 + mod));
                this.level = 64 + 5*mod;
				this.drop = new ChainedDrop().add(necklaces.COWBELL, 1 / 12)
						.add(weapons.DL_AXE_, 1 / 8)
						.add(consumables.MINOCUM, 1 / 5)
						.add(consumables.MINOBLO, 1 / 2)
						.elseDrop(null);
			    this.gems = int((rand(15) + 85) * Math.exp(0.3*mod));
                this.additionalXP = int(600 * Math.exp(0.3*mod));
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
			    this.gems = rand(15) + 15;
			}
			this.a = "the ";
			this.imageName = "minotaur";
			this.long = "";
			// this.plural = false;
			this.createCock(rand(13)+ 24,2 + rand(3),CockTypesEnum.HORSE);
			this.balls = 2;
			this.ballSize = 5 + rand(6); //turned the random down a bit. Too OP for dungeon IMO
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
			this.abilities = [
				{call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[], weight: 3},
				{call: SceneLib.mountain.minotaurScene.minoPheromones, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[]}
			];
			if (inDungeon) {
				hasTwoAttacks = true;
			}
			this.horns.type = Horns.COW_MINOTAUR;
			this.horns.count = 6;
			this.tailType = Tail.COW;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
