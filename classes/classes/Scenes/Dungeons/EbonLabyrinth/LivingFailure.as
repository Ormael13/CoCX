/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.EbonLabyrinth 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Wings;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class LivingFailure extends Monster
	{
		private function livingFailureLustTransferance():void {
			outputText("The thing waves a sign at you and you realise to your horror that it opened an arcane connection to your mind, some of its overflowing lust transfering straith into your body!\n\n");
			var bonus:int = 0;
			if (player.hasCock()) bonus++;
			if (player.hasVagina()) bonus++;
			if (player.balls > 0) bonus++;
			if (player.bRows() > 1) bonus++;
			if (player.bRows() > 2) bonus++;
			player.createStatusEffect(StatusEffects.LustTransferance,bonus,0,0,0);
			player.dynStats("lus", bonus * 2 + 5 + player.effectiveSensitivity()/5);
		}
		
		private function livingFailureIdInsinuation():void {
			outputText("The creature waves a red magical sigil and suddenly you feel the urge to hurt yourself really hard. In your confusion you strike yourself on a nearby rock taking ");
			player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			player.takePhysDamage(100, true);
			outputText(" damage.\n\n");
		}
		
		private function livingFailureMadness():void {
			outputText("The thing begins blabbering incomprehensible but harmful words. These words, these horrible words resonate all the way up into your soul rending your sanity. Let them out, LET THEM OUT!!\n\n");
			player.addCurse("int.mult", 0.10,3);
			player.addCurse("wis.mult", 0.10,3);
		}
		
		private function livingFailurePrimalDemonfire():void {
			outputText("The demon four hands wave this sign as his cocks and vaginas erupts in a real deluge of black cum, the unholy fluid floating in the air and forming a massive ball of black liquid corruption which ignites like oil into a black flame flying straiths at you.\n\n");
			if (!player.getEvasionRoll()) {
				var damage:Number = eBaseIntelligenceDamage();
				damage += eBaseWisdomDamage();
				damage = Math.round(damage);
				damage = player.takeFireDamage(damage, true);
			}
		}
		
		private function livingFailureEclipse():void {
			outputText("The Demon waves his hand in the air into an unholy curse sign. Sealing away your white magic!\n\n");
			player.createStatusEffect(StatusEffects.Sealed, 4, 10, 0, 0);
		}
		
		private function livingFailureCorruptEruption():void {
			outputText("The horror suddenly bleats an ecstatics roar as his cocks and vagina take aim at you, showering you in a deluge of black cum.");
			if (player.cor < 100) {
				outputText(" The damage is immediate, toroughtly corrupting your purity with depraved evil thoughts.");
				dynStats("cor", 20);
			}
			outputText("\n\n");
			player.dynStats("lus", (10 + int(player.lib / 10 + player.effectiveSensitivity() / 10 + player.cor / 10)));
		}
		
		private function livingFailureDefileBody():void {
			outputText("The thing waves his free hands bleating some unknown demonic spells at you. You moan as your endowment begins growing to unnatural size your" + (player.biggestTitSize() >= 1 ? " breast":"") + "");
			if (player.hasCock()) {
				if (player.hasVagina()) outputText(", [cock] and clit");
				else outputText(" and penis");
			}
			if (player.hasVagina()) outputText(" and clit");
			outputText(" inflating. As a result of this pleasurable transformation reducing your general agility and greatly increasing your sensitivity. Resisting the thing lusty assault is gonna become increasingly difficult.\n\n");
			if (player.biggestTitSize() >= 1) player.breastRows[0].breastRating++;
			if (player.hasCock()) player.increaseCock(0, rand(2) + 1);
			if (player.hasVagina()) player.clitLength += .25;
			player.addCurse("spe.mult", 0.10,3);
			player.addCurse("sen", 10,3);
		}
		
		override protected function performCombatAction():void
		{
			if (!hasStatusEffect(StatusEffects.LustTransferance) && rand(4) == 0) livingFailureLustTransferance();
			else {
				var choice:Number = rand(6);
				if (choice == 0) {
					if (player.hasStatusEffect(StatusEffects.Stunned)) livingFailureMadness();
					else livingFailureIdInsinuation();
				}
				if (choice == 1) livingFailureMadness();
				if (choice == 2) livingFailurePrimalDemonfire();
				if (choice == 3) {
					if (player.hasStatusEffect(StatusEffects.Sealed)) livingFailureDefileBody();
					else livingFailureEclipse();
				}
				if (choice == 4) livingFailureCorruptEruption();
				if (choice == 5) livingFailureDefileBody();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.livingFailureScene.defeat();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.livingFailureScene.defeatedBy();
		}
		
		override public function get long():String
		{
			var str:String = "";
			str += "This towering horror combines the traits of a man, a goat and a bat, it's pair of 36 inches horsecocks bubbling constantly with cum as they are jerked. Its four sets of bat wings flap at mismatched intervals and its barbed heart shaped tail whips from one side to another. Four tentacles tipped with what appears to be vagina’s flail from each side of his back to just in front of his wings.  ";
			str += "It's eyes are glazed in a state of constant orgasm yet seems to focus every now and then on you, acknowledging your presence as if deep down the shadow of this abomination’s consciousness still lingers. The goat faced nightmare groans curses, the first pair of hands jerking his dicks, while the other is constantly waving arcane signs in the air, whether to enhance his own maddening pleasures or yours.";
			return str;
		}
		
		public function LivingFailure()
		{
            //scaled from 65 now, reduced base stats to compensate
			var mod:int = inDungeon ? SceneLib.dungeons.ebonlabyrinth.enemyLevelMod : 3;
            initStrTouSpeInte(240 + 30*mod, 240 + 30*mod, 73 + 27*mod, 281 + 23*mod);
            initWisLibSensCor(281 + 23*mod, 270 + 30*mod, 60 + 40*mod, 100);
            this.armorDef = 20 + 20*mod;
            this.armorMDef = 20 + 20*mod;
            this.bonusHP = mod == 0 ? 0 : 2000*(mod-1);
            this.bonusLust = 395 + 75*mod;
            this.level = 60 + 5*mod; //starts from 65 due to EL levelMod calculations;
            this.gems = mod > 50 ? 0 : Math.floor((1200 + rand(200)) * Math.exp(0.3*mod));
            this.additionalXP = mod > 50 ? 0 : Math.floor(4000 * Math.exp(0.3*mod));
			
			this.a = " ";
			this.short = "Living Failure";
			this.imageName = "livingfailure";
			this.long = "";
			this.tallness = 12 * 15;
			createVagina(false,VaginaClass.WETNESS_SLAVERING,VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR);
			this.createCock(36, 7, CockTypesEnum.HORSE);
			this.createCock(36, 7, CockTypesEnum.HORSE);
			this.createBreastRow(0);
			this.balls = 2;
			this.ballSize = 4;
			this.hoursSinceCum = 9999;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.weaponName = "claws";
			this.weaponVerb = "slash";
			this.armorName = "fur";
			this.lustVuln = 0;
			this.lowerBody = LowerBody.HYDRA;
			this.faceType = Face.ANIMAL_TOOTHS;
			this.wings.type = Wings.BAT_LIKE_LARGE_2;
			this.tailType = Tail.DEMONIC;
			this.drop = new WeightedDrop(consumables.INFWINE, 1);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, (60 + 5*mod), 0, 0, 0);
			this.checkMonster();
		}
	}
}