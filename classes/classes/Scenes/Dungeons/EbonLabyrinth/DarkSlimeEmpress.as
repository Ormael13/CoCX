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
			player.dynStats("lus", 7 + rand(5) + this.sens / 8);
			if (!hasStatusEffect(StatusEffects.LingeringSlime)) createStatusEffect(StatusEffects.LingeringSlime, 0, 0, 0, 0);
		}
		
		private function gooSlimeBarrage():void
		{
			outputText("The slimes suddenly create bows and arrows out of their body, shooting at you with a volley of slimy aphrodisiac bolts!\n");
			if (player.spe < ((100 * (player.newGamePlusMod() + 1)) + rand(200))) gooSlimeBarrageD();
			if (player.spe < ((100 * (player.newGamePlusMod() + 1)) + rand(100))) gooSlimeBarrageD();
			if (player.spe < ((100 * (player.newGamePlusMod() + 1)) + rand(100))) gooSlimeBarrageD();
			if (player.spe < ((100 * (player.newGamePlusMod() + 1)) + rand(100))) gooSlimeBarrageD();
			if (player.spe < ((100 * (player.newGamePlusMod() + 1)) + rand(100))) gooSlimeBarrageD();
			if (player.spe < ((100 * (player.newGamePlusMod() + 1)) + rand(100))) gooSlimeBarrageD();
			if (player.spe < ((100 * (player.newGamePlusMod() + 1)) + rand(100))) gooSlimeBarrageD();
			if (player.spe < ((100 * (player.newGamePlusMod() + 1)) + rand(100))) gooSlimeBarrageD();
			if (player.spe < ((100 * (player.newGamePlusMod() + 1)) + rand(100))) gooSlimeBarrageD();
			if (player.spe < ((100 * (player.newGamePlusMod() + 1)) + rand(100))) gooSlimeBarrageD();
			if (player.spe < ((100 * (player.newGamePlusMod() + 1)) + rand(100))) gooSlimeBarrageD();
			if (player.spe < ((100 * (player.newGamePlusMod() + 1)) + rand(100))) gooSlimeBarrageD();
			outputText("\n");
		}
		private function gooSlimeBarrageD():void {
			var td:Number = 4 + rand(4);
			td += player.lib / 10;
			td += player.sens / 10;
			td = Math.round(td);
			if (!hasStatusEffect(StatusEffects.LingeringSlime)) createStatusEffect(StatusEffects.LingeringSlime, 0, 0, 0, 0);
			outputText("\nLust swells up in your body as the substance splash on you. <b>(<font color=\"#800000\">" + td + "</font>)</b> lust damage.");
			player.dynStats("lus", td);
		}
		
		private function gooGroupGrapple():void
		{
			outputText("The slime girls suddenly attempt to grapple you one after another to restrict your movements!");
			if((player.findPerk(PerkLib.Evade) && rand(6) == 0) || (player.spe > rand(300))) outputText("You barely manage to break out of their clingy bodies!");
			else {
				outputText("Before you know it you’re covered and pulled down by their combined bodies.");
				if (!player.hasStatusEffect(StatusEffects.GooBind)) player.createStatusEffect(StatusEffects.GooBind, 0, 0, 0, 0);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.LingeringSlime)) {
				outputText("Small stains of lingering slimes cling to your body, insidiously pouring you with aphrodisiacs.\n\n");
				player.dynStats("lus", (8 + int(player.lib / 20 + player.cor / 25)));
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
				this.armorDef = 30;
				this.armorMDef = 90;
				this.bonusHP = 10000;
				this.level = 65;
			}
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 70) {
				initStrTouSpeInte(140, 290, 200, 180);
				initWisLibSensCor(180, 290, 200, 10);
				this.armorDef = 40;
				this.armorMDef = 120;
				this.bonusHP = 20000;
				this.level = 70;
			}
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 75) {
				initStrTouSpeInte(160, 340, 240, 210);
				initWisLibSensCor(210, 340, 200, 10);
				this.armorDef = 50;
				this.armorMDef = 150;
				this.bonusHP = 30000;
				this.level = 75;
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
			this.gems = rand(6) + 4;
			this.drop = new ChainedDrop().add(weapons.PIPE,1/10)
					.add(consumables.DSLIMEJ,1/2)
					.elseDrop(useables.GREENGL);
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