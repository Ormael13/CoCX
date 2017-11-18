package classes.Scenes.Areas.Mountain
{

	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;

	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Minotaur extends Monster
	{
		public var hasAxe:Boolean;


		override public function defeated(hpVictory:Boolean):void
		{
			if(hasStatusEffect(StatusEffects.PhyllaFight)) {
				removeStatusEffect(StatusEffects.PhyllaFight);
				outputText("You defeat a minotaur!  ", true);
				game.desert.antsScene.phyllaBeatAMino();
			} else {
				game.mountain.minotaurScene.minoVictoryRapeChoices();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(hasStatusEffect(StatusEffects.PhyllaFight)) {
				removeStatusEffect(StatusEffects.PhyllaFight);
				game.desert.antsScene.phyllaPCLostToMino();
			} else if (pcCameWorms){
				outputText("\n\nThe minotaur picks you up and forcibly tosses you from his cave, grunting in displeasure.");
				game.cleanupAfterCombat();
			} else
				game.mountain.minotaurScene.getRapedByMinotaur();
		}

		override public function get long():String
		{
			return "An angry-looking minotaur looms over you.  Covered in shaggy " + hairColor + " fur, the beast is an imposing sight.  Wearing little but an obviously distended loincloth, he is clearly already plotting his method of punishment.  Like most minotaurs he has hooves, a cow-like tail and face, prominent horns, and impressive musculature. "+
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
			this.a = "the ";
			this.short = "minotaur";
			this.imageName = "minotaur";
			this.long = "";
			// this.plural = false;
			this.createCock(rand(13)+ 24,2 + rand(3),CockTypesEnum.HORSE);
			this.balls = 2;
			this.ballSize = 2 + rand(13);
			this.cumMultiplier = 1.5;
			this.hoursSinceCum = this.ballSize * 10;
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = rand(37) + 84;
			this.hipRating = HIP_RATING_AVERAGE;
			this.buttRating = BUTT_RATING_AVERAGE;
			this.lowerBody = LOWER_BODY_TYPE_HOOFED;
			this.skin.growFur({color:furColor});
			this.skinDesc = "shaggy fur";
			this.hairColor = furColor;
			this.hairLength = 3;
			initStrTouSpeInte(hasAxe ? 100 : 75, 70, 35, 20);
			initWisLibSensCor(20, 40 + this.ballSize * 2, 15 + this.ballSize * 2, 35);
			this.faceType = FACE_COW_MINOTAUR;
			this.weaponName = hasAxe?"axe":"fist";
			this.weaponVerb = hasAxe?"cleave":"punch";
			this.weaponAttack = hasAxe?50:40;
			this.armorName = "thick fur";
			this.armorDef = 12;
			this.bonusHP = 20 + rand(this.ballSize*2);
			this.bonusLust = 30 + rand(this.ballSize*3);
			this.lust = this.ballSize * 3;
			this.lustVuln = hasAxe?0.84:0.87;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = hasAxe?15:12;
			this.gems = rand(15) + 15;
			if (hasAxe) {
				this.drop = new WeightedDrop(consumables.MINOBLO, 1);
			} else {
				this.drop = new ChainedDrop().add(consumables.MINOCUM, 1 / 5)
						.add(consumables.MINOBLO, 1 / 2)
						.elseDrop(null);
			}
			this.special1 = game.mountain.minotaurScene.minoPheromones;
			this.tailType = TAIL_TYPE_COW;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
