package classes.Scenes.Areas.Lake
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Dungeons.RiverDungeon;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class GreenSlime extends Monster
	{
		public var floor1:RiverDungeon = new RiverDungeon();
		
		override public function defeated(hpVictory:Boolean):void
		{
			outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.", true);
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) SceneLib.combat.cleanupAfterCombatImpl();
			//Boobfeed.
			else if (player.hasStatusEffect(StatusEffects.Feeder) && flags[kFLAGS.SFW_MODE] <= 0) {
				//Eligable to rape
				if(player.lust >= 33 && player.gender > 0) {
					outputText("\n\nYou're horny enough to try and rape it, though you'd rather see how much milk you can squirt into it.  What do you do?");
					EngineCore.simpleChoices("B.Feed",SceneLib.lake.greenSlimeScene.rapeOozeWithMilk,"Rape",SceneLib.lake.greenSlimeScene.slimeVictoryRape,"",null,"",null,"Leave",SceneLib.combat.cleanupAfterCombatImpl);
				}
				//Rapes not on the table.
				else {
					outputText("\n\nYour nipples ache with the desire to forcibly breastfeed the gelatinous beast.  Do you?");
					EngineCore.doYesNo(SceneLib.lake.greenSlimeScene.rapeOozeWithMilk,SceneLib.combat.cleanupAfterCombatImpl);
				}
			}
			//Not a breastfeeder
			else if (player.lust >= 33 && player.gender > 0 && flags[kFLAGS.SFW_MODE] <= 0) {
				outputText("  Sadly you realize your own needs have not been met.  Of course, you could always play with the poor thing... Do you rape it?");
				EngineCore.doYesNo(SceneLib.lake.greenSlimeScene.slimeVictoryRape, SceneLib.combat.cleanupAfterCombatImpl);
			}
			else SceneLib.combat.cleanupAfterCombatImpl();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) floor1.defeatedByGreenSlime();
			else {
				if (pcCameWorms) {
					outputText("\n\nThe slime doesn't even seem to notice.\n\n");
				}
				doNext(SceneLib.lake.greenSlimeScene.slimeLoss);
			}
		}
		
		private function lustAttack():void {
			outputText("The creature surges forward slowly with a swing that you easily manage to avoid.  You notice traces of green liquid spurt from the creature as it does, forming a thin mist that makes your skin tingle with excitement when you inhale it.");
			player.dynStats("lus", player.lib / 10 + 8);
			doNext(EventParser.playerMenu);
		}
		
		private function lustReduction():void {
			outputText("The creature collapses backwards as its cohesion begins to give out, and the faint outline of eyes and a mouth form on its face.  Its chest heaves as if it were gasping, and the bolt upright erection it sports visibly quivers and pulses before relaxing slightly.");
			lust -= 13;
			doNext(EventParser.playerMenu);
		}
		
		public function GreenSlime()
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				initStrTouSpeInte(30, 50, 40, 10);
				initWisLibSensCor(10, 80, 60, 20);
				this.weaponAttack = 4;
				this.armorDef = 4;
				this.armorMDef = 12;
				this.bonusHP = 100;
				this.level = 6;
			}
			else {
				initStrTouSpeInte(25, 30, 10, 5);
				initWisLibSensCor(5, 50, 60, 20);
				this.weaponAttack = 3;
				this.armorDef = 3;
				this.armorMDef = 9;
				this.bonusHP = 50;
				this.level = 4;
			}
			trace("GreenSlime Constructor!");
			this.a = "a ";
			this.short = "green slime";
			this.imageName = "greenslime";
			this.long = "The green slime has a normally featureless face that sits on top of wide shoulders that sprout into thick, strong arms.  Its torso fades into an indistinct column that melds into the lump of ooze on the ground that serves as a makeshift form of locomotion.";
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
			this.skinTone = "green";
			this.weaponName = "hands";
			this.weaponVerb = "slap";
			this.armorName = "gelatinous skin";
			this.bonusLust = 20;
			this.lust = 30;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.gems = rand(5) + 3;
			this.drop = new ChainedDrop().add(weapons.PIPE, 1 / 10)
					.add(consumables.WETCLTH, 1 / 2)
					.elseDrop(useables.GREENGL);
			this.special1 = lustReduction;
			this.special2 = lustAttack;
			this.special3 = lustAttack;
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGooType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
