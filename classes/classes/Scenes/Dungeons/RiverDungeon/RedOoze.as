package classes.Scenes.Dungeons.RiverDungeon 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Scenes.Dungeons.RiverDungeon;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class RedOoze extends Monster
	{
		public var floor1:RiverDungeon = new RiverDungeon();
		
		override public function defeated(hpVictory:Boolean):void
		{
			outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.");
			cleanupAfterCombat();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			floor1.defeatedByRedOoze();
		}
		
		override public function eAttack():void
		{
			if (player.HP > player.minHP + 50) {
				player.HP -= 50;
				HP += 50;
				if (HP > maxHP()) HP = maxHP();
			}
			if (player.soulforce >= 10) {
				player.soulforce -= 10;
				soulforce += 20;
				if (soulforce > maxSoulforce()) soulforce = maxSoulforce();
			}
			super.eAttack();
		}

		private function lustAttack():void {
			outputText("The creature surges forward slowly with a swing that you easily manage to avoid.  You notice traces of red liquid spurt from the creature as it does, forming a thin mist that makes your skin tingle with excitement when you inhale it.");
			player.takeLustDamage(player.lib / 10 + 8, true);
			doNext(EventParser.playerMenu);
		}
		
		private function lustReduction():void {
			outputText("The creature collapses backwards as its cohesion begins to give out, and the faint outline of eyes and a mouth form on its face.  Its chest heaves as if it were gasping, and the bolt upright erection it sports visibly quivers and pulses before relaxing slightly.");
			if (lust < 20) lust = 0;
			else lust -= 20;
			if (soulforce > 50 && HP < (maxHP() - 50)) {
				soulforce -= 50;
				HP += 50;
			}
			doNext(EventParser.playerMenu);
		}
		
		public function RedOoze() 
		{
			//
			this.short = "red ooze";
			this.long = "The red ooze has a normally featureless face that sits on top of wide shoulders that sprout into thick, strong arms.  Its torso fades into an indistinct column that melds into the something looking like scylla lower body.  From it's back extend few gooey tendrils.";
			initStrTouSpeInte(30, 50, 40, 10);
			initWisLibSensCor(10, 80, 60, 20);
			this.weaponAttack = 4;
			this.armorDef = 4;
			this.armorMDef = 12;
			this.bonusHP = 100;
			this.bonusLust = 146;
			this.level = 6;
			this.gems = rand(5) + 3;
			//
			this.a = "a ";
			this.imageName = "redooze";
			// this.plural = false;
			this.createCock(18, 2, CockTypesEnum.HUMAN);
			this.cumMultiplier = 3;
			this.hoursSinceCum = 20;
			this.pronoun1 = "it";
			this.pronoun2 = "it";
			this.pronoun3 = "its";
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(8) + 80;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.GOO;
			this.bodyColor = "red";
			this.weaponName = "bac tendrils";
			this.weaponVerb = "slap";
			this.armorName = "gelatinous skin";
			this.lust = 30;
			this.drop = new ChainedDrop().add(weapons.PIPE, 1 / 10)
					.add(consumables.WETCLTH, 1 / 2)
					.elseDrop(useables.RED_GEL);
			this.special1 = lustReduction;
			this.special2 = lustAttack;
			this.special3 = lustAttack;
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGooType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}