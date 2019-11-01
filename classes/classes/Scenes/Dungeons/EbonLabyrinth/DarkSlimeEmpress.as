/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.EbonLabyrinth 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class DarkSlimeEmpress extends Monster
	{
		private function gooHaremStrike():void
		{
			outputText("The slime girls begin to fondle your ");
			if (player.hasCock()) outputText("[cock]");
			if (player.gender == 3) outputText(" and ");
			if (player.hasVagina()) outputText("[pussy]");
			if (player.gender == 0) outputText("empty nether");
			outputText(" religiously in an all out effort to make you cum the fluids they all so crave");
			if (player.gender == 0) outputText(", though you doubt they’ll get any due to your absence of endowments");
			outputText(". ");
			if (player.isLactating()) outputText("One of them even made suction cup tentacles in order to milk your breasts. ");
			outputText("You’re being violated from all sides and in all possible ways by a full harem of jelly girls!\n\n");
			player.dynStats("lus", 17 + rand(7) + this.sens / 5, "scale", false);
			if (!hasStatusEffect(StatusEffects.LingeringSlime)) createStatusEffect(StatusEffects.LingeringSlime, 0, 0, 0, 0);
		}
		
		private function gooSlimeBarrage():void
		{
			outputText("The slimes suddenly create bows and arrows out of their body, shooting at you with a volley of slimy aphrodisiac bolts!\n");
			gooSlimeBarrageD();
			gooSlimeBarrageD();
			gooSlimeBarrageD();
			gooSlimeBarrageD();
			if (player.spe < ((160 * (player.newGamePlusMod() + 1)) + rand(80))) gooSlimeBarrageD();
			if (player.spe < ((160 * (player.newGamePlusMod() + 1)) + rand(80))) gooSlimeBarrageD();
			if (player.spe < ((140 * (player.newGamePlusMod() + 1)) + rand(70))) gooSlimeBarrageD();
			if (player.spe < ((140 * (player.newGamePlusMod() + 1)) + rand(70))) gooSlimeBarrageD();
			if (player.spe < ((120 * (player.newGamePlusMod() + 1)) + rand(60))) gooSlimeBarrageD();
			if (player.spe < ((120 * (player.newGamePlusMod() + 1)) + rand(60))) gooSlimeBarrageD();
			if (player.spe < ((100 * (player.newGamePlusMod() + 1)) + rand(50))) gooSlimeBarrageD();
			if (player.spe < ((100 * (player.newGamePlusMod() + 1)) + rand(50))) gooSlimeBarrageD();
			outputText("\n");
		}
		private function gooSlimeBarrageD():void {
			var td:Number = 7 + rand(5);
			td += player.lib / 8;
			td += player.sens / 8;
			td = Math.round(td);
			td = td * (EngineCore.lustPercent() / 100);
			if (!hasStatusEffect(StatusEffects.LingeringSlime)) createStatusEffect(StatusEffects.LingeringSlime, 0, 0, 0, 0);
			outputText("\nLust swells up in your body as the substance splash on you. <b>(<font color=\"#ff00ff\">" + (Math.round(td * 10) / 10) + "</font>)</b> lust damage.");
			player.dynStats("lus", td, "scale", false);
		}
		
		private function gooGroupGrapple():void
		{
			outputText("The slime girls suddenly attempt to grapple you one after another to restrict your movements!");
			if((player.findPerk(PerkLib.Evade) && rand(6) == 0) || (player.spe > ((this.spe * 1.5) + rand(200)))) outputText("You barely manage to break out of their clingy bodies!");
			else {
				outputText("Before you know it you’re covered and pulled down by their combined bodies.");
				if (!player.hasStatusEffect(StatusEffects.GooBind)) player.createStatusEffect(StatusEffects.GooBind, 0, 0, 0, 0);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.LingeringSlime)) {
				outputText("Small stains of lingering slimes cling to your body, insidiously pouring you with aphrodisiacs.\n\n");
				player.dynStats("lus", (10 + int(player.lib / 12 + player.cor / 14)));
				removeStatusEffect(StatusEffects.LingeringSlime);
			}			
			if (player.hasStatusEffect(StatusEffects.GooBind)) gooHaremStrike();
			else {
				if (rand(3) == 0) gooGroupGrapple();
				else gooSlimeBarrage();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			player.removeStatusEffect(StatusEffects.EbonLabyrinthBoss);
			SceneLib.dungeons.ebonlabyrinth.defeatDarkSlimeEmpress();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			player.removeStatusEffect(StatusEffects.EbonLabyrinthBoss);
			SceneLib.dungeons.ebonlabyrinth.defeatedByDarkSlimeEmpress();
		}
		
		public function DarkSlimeEmpress() 
		{
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 65) {
				initStrTouSpeInte(120, 240, 160, 150);
				initWisLibSensCor(150, 240, 200, 10);
				this.armorDef = 60;
				this.armorMDef = 180;
				this.bonusHP = 10000;
				this.level = 65;
				this.gems = 200 + rand(80);
			}
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 70) {
				initStrTouSpeInte(140, 290, 200, 180);
				initWisLibSensCor(180, 290, 210, 10);
				this.armorDef = 80;
				this.armorMDef = 240;
				this.bonusHP = 20000;
				this.level = 70;
				this.gems = 250 + rand(90);
			}
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 75) {
				initStrTouSpeInte(160, 340, 240, 210);
				initWisLibSensCor(210, 340, 220, 10);
				this.armorDef = 100;
				this.armorMDef = 300;
				this.bonusHP = 30000;
				this.level = 75;
				this.gems = 300 + rand(100);
			}
			this.a = "";
			this.short = "Dark Slime Empress";
			this.imageName = "googirl";
			this.long = "You face a dark slime empress and her purple legion of fanatical slime soldiers all bent on engulfing you! The empress sits on her throne in the back of the room ordering her soldiers around. These gooey soldiers fight with slime made weaponry which, while inefficient at dealing wounds, are quite efficient at arousing you.";
			this.plural = true;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 9001, 0, 0, 0);
			this.createBreastRow(3);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.createStatusEffect(StatusEffects.BonusACapacity,9001,0,0,0);
			this.tallness = 120;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.GOO;
			this.skin.setBaseOnly({color:"purple",type:Skin.GOO});
			this.hairColor = "purple";
			this.hairLength = 12 + rand(10);
			this.weaponName = "hands";
			this.weaponAttack = 35;
			this.weaponVerb="slap";
			this.armorName = "gelatinous skin";
			this.bonusLust = 100;
			this.lust = 45;
			this.lustVuln = .75;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.drop = new WeightedDrop(consumables.DSLIMEJ, 1);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.LightningVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGooType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}