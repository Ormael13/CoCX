package classes.Scenes.Dungeons.RiverDungeon 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Dungeons.RiverDungeon;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class RedOoze extends Monster
	{
		public var floors:RiverDungeon = new RiverDungeon();
		
		override public function defeated(hpVictory:Boolean):void
		{
			outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.");
			cleanupAfterCombat();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.RED_OOZE_SUBTYPE] == 1) floors.defeatedByRedMistOoze();
			else floors.defeatedByRedOoze();
		}
		
		override public function eAttack():void
		{
			var sipHP:Number = 50;
			var sipSF:Number = 10;
			if (flags[kFLAGS.RED_OOZE_SUBTYPE] == 1) {
				sipHP *= 20;
				sipSF *= 10;
			}
			if (player.HP > player.minHP + sipHP) {
				player.HP -= sipHP;
				HP += sipHP;
				if (HP > maxHP()) HP = maxHP();
			}
			if (player.soulforce >= sipSF) {
				player.soulforce -= sipSF;
				soulforce += sipSF;
				if (soulforce > maxSoulforce()) soulforce = maxSoulforce();
			}
			super.eAttack();
		}

		private function lustAttack():void {
			outputText("The creature surges forward slowly with a swing that you easily manage to avoid.  You notice traces of red liquid spurt from the creature as it does, forming a thin mist that makes your skin tingle with excitement when you inhale it.");
			var baseLA:Number = player.lib / 10 + 8;
			if (flags[kFLAGS.RED_OOZE_SUBTYPE] == 1) baseLA += player.lib / 20 + 4;
			player.takeLustDamage(baseLA, true);
			doNext(EventParser.playerMenu);
		}
		
		private function lustReduction():void {
			outputText("The creature collapses backwards as its cohesion begins to give out, and the faint outline of "+(flags[kFLAGS.RED_OOZE_SUBTYPE] == 1 ? "" : "eyes and ")+"a mouth form on its face.  Its chest heaves as if it were gasping"+(flags[kFLAGS.RED_OOZE_SUBTYPE] == 1 ? " with veins puslsing with bright purple glow" : "")+", and the bolt upright erection it sports visibly quivers and pulses before relaxing slightly.");
			var lustRed:Number = 20;
			var healthR:Number = 50;
			if (flags[kFLAGS.RED_OOZE_SUBTYPE] == 1) {
				lustRed *= 5;
				healthR *= 20;
			}
			if (lust < lustRed) lust = 0;
			else lust -= lustRed;
			if (soulforce > healthR && HP < (maxHP() - healthR)) {
				soulforce -= healthR;
				HP += healthR;
			}
			doNext(EventParser.playerMenu);
		}
		
		public function RedOoze() 
		{
			if (flags[kFLAGS.RED_OOZE_SUBTYPE] == 1) {
				this.short = "red mist ooze";
				this.long = "The red mist ooze has a normally featureless face with pair of purple glowing eyes that sits on top of wide shoulders that sprout into thick, strong arms.  Its torso fades into an indistinct column that melds into the something looking like scylla lower body.  From it's back extend few gooey tendrils.  It unusual feature are glowing gently purple veins that covers it whole body.";
				initStrTouSpeInte(220, 380, 280, 60);
				initWisLibSensCor(100, 180, 176, -40);
				this.weaponAttack = 40;
				this.armorDef = 30;
				this.armorMDef = 90;
				this.bonusHP = 1200;
				this.bonusLust = 400;
				this.bonusSoulforce = 2000;
				this.level = 44;
				this.gems = rand(5) + 3;
			}
			if (flags[kFLAGS.RED_OOZE_SUBTYPE] == 2) {
				this.short = "red ooze";
				this.long = "The red ooze has a normally featureless face that sits on top of wide shoulders that sprout into thick, strong arms.  Its torso fades into an indistinct column that melds into the something looking like scylla lower body.  From it's back extend few gooey tendrils.";
				initStrTouSpeInte(60, 100, 80, 20);
				initWisLibSensCor(20, 160, 120, -40);
				this.weaponAttack = 6;
				this.armorDef = 6;
				this.armorMDef = 18;
				this.bonusHP = 200;
				this.bonusLust = 286;
				this.bonusSoulforce = 200;
				this.level = 4;
				this.gems = rand(5) + 3;
			}
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
			this.weaponName = "back tendrils";
			this.weaponVerb = "slap";
			this.armorName = "gelatinous skin";
			this.lust = 30;
			if (flags[kFLAGS.RED_OOZE_SUBTYPE] == 1)  {
				this.drop = new ChainedDrop().add(useables.PCSHARD, 1 / 2)
						.elseDrop(useables.RED_GEL);
			}
			else {
				this.drop = new ChainedDrop().add(weapons.PIPE, 1 / 10)
						.add(consumables.WETCLTH, 1 / 2)
						.elseDrop(useables.RED_GEL);
			}
			this.special1 = lustReduction;
			this.special2 = lustAttack;
			this.special3 = lustAttack;
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGooType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}