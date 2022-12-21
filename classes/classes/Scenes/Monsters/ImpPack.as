/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters
{
import classes.*;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;
	
	public class ImpPack extends Imp
	{
		override public function defeated(hpVictory:Boolean):void
		{
			game.flags[kFLAGS.DEMONS_DEFEATED]++;
			SceneLib.impScene.defeatImpPack();
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			SceneLib.impScene.loseToAnImpPack();
		}
		
		public function ImpPack()
		{
			this.a = "a ";
			this.short = "pack of imps";
			this.plural = true;
			this.createBreastRow();
			this.createCock(12,1.5);
			this.createCock(25,2.5);
			this.createCock(25,2.5);
			this.cocks[2].cockType = CockTypesEnum.DOG;
			this.cocks[2].knotMultiplier = 2;
			this.balls = 2;
			this.ballSize = 3;
			this.tallness = 36;
			this.tailType = Tail.DEMONIC;
			this.wings.type = Wings.IMP;
			this.bodyColor = "green";
			this.long = "The imps stand anywhere from two to four feet tall, with scrawny builds and tiny demonic wings. Their red and orange skin is dirty, and their dark hair looks greasy. Some are naked, but most are dressed in ragged loincloths that do little to hide their groins. They all have a cocks as long and thick as a man's arm, far oversized for their bodies.";
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			initStrTouSpeInte(70, 40, 50, 42);
			initWisLibSensCor(42, 55, 35, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 16;
			this.armorName = "leathery skin";
			this.armorDef = 10;
			this.armorMDef = 1;
			this.bonusHP = 500;
			this.bonusLust = 105;
			this.lust = 30;
			this.lustVuln = .6;
			this.level = 15;
			this.gems = rand(20) + 30;
			this.drop = new WeightedDrop().
					add(consumables.MINOBLO,1).
					add(consumables.LABOVA_,1).
					add(consumables.INCUBID,6).
					add(consumables.SUCMILK,6);
			this.wings.type = Wings.IMP;
			this.special1 = lustMagicAttack;
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 15, 0, 0, 0);
			checkMonster();
		}
	}
}
