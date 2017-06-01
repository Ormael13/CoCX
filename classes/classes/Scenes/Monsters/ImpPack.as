/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	use namespace kGAMECLASS;
	
	public class ImpPack extends Imp
	{
		override public function defeated(hpVictory:Boolean):void
		{
			game.flags[kFLAGS.DEMONS_DEFEATED]++;
			game.impScene.defeatImpPack();
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.impScene.loseToAnImpPack();
		}
		
		public function ImpPack()
		{
			this.a = "a ";
			this.short = "pack of imps";
			this.plural = true;
			this.removeStatuses();
			this.removePerks();
			this.removeCock(0, this.cocks.length);
			this.removeVagina(0, this.vaginas.length);
			this.removeBreastRow(0, this.breastRows.length);
			this.createBreastRow();
			this.createCock(12,1.5);
			this.createCock(25,2.5);
			this.createCock(25,2.5);
			this.cocks[2].cockType = CockTypesEnum.DOG;
			this.cocks[2].knotMultiplier = 2;
			this.balls = 2;
			this.ballSize = 3;
			this.tallness = 36;
			this.tailType = TAIL_TYPE_DEMONIC;
			this.wingType = WING_TYPE_IMP;
			this.skinTone = "green";
			this.long = "The imps stand anywhere from two to four feet tall, with scrawny builds and tiny demonic wings. Their red and orange skin is dirty, and their dark hair looks greasy. Some are naked, but most are dressed in ragged loincloths that do little to hide their groins. They all have a [cock] as long and thick as a man's arm, far oversized for their bodies."
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			initStrTouSpeInte(70, 40, 50, 42);
			initLibSensCor(55, 35, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 16 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "leathery skin";
			this.armorDef = 10 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 500;
			this.bonusLust = 150;
			this.lust = 30;
			this.lustVuln = .6;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 15;
			this.gems = rand(20) + 30;
			this.drop = new WeightedDrop().
					add(consumables.MINOBLO,1).
					add(consumables.LABOVA_,1).
					add(consumables.INCUBID,6).
					add(consumables.SUCMILK,6);
			this.wingType = WING_TYPE_IMP;
			this.special1 = lustMagicAttack;
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.str += 14 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 11 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 1020;
			checkMonster();
		}
	}
}