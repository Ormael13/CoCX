package classes.Scenes.Camp
{
import classes.*;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Monsters.Imp;
import classes.Scenes.SceneLib;

public class ImpGang extends Imp
	{
		override public function get capitalA():String {
			return "gang of imps";
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void {
			SceneLib.impScene.impGangabangaEXPLOSIONS(true);
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.flags[kFLAGS.DEMONS_DEFEATED]++;
			SceneLib.impScene.impGangGetsWhooped();
		}
		
		public function ImpGang()
		{
			this.a = "a ";
			this.short = "mob of imps";
			this.plural = true;
			/*
			this.removeStatuses();
			this.removePerks();
			this.removeCock(0, this.cocks.length);
			this.removeVagina(0, this.vaginas.length);
			this.removeBreastRow(0, this.breastRows.length);
			 */
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
			this.createStatusEffect(StatusEffects.GenericRunDisabled, 0, 0, 0, 0);
			this.long = "The imps stand anywhere from two to four feet tall, with scrawny builds and tiny demonic wings. Their red and orange skin is dirty, and their dark hair looks greasy. Some are naked, but most are dressed in ragged loincloths that do little to hide their groins. Each has a cock as long and thick as a man's arm, far oversized for their small bodies.";
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			initStrTouSpeInte(70, 40, 75, 42);
			initWisLibSensCor(42, 55, 35, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 10;
			this.armorName = "leathery skin";
			this.armorDef = 3;
			this.armorMDef = 0;
			this.bonusHP = 300;
			this.bonusLust = 104;
			this.lust = 30;
			this.lustVuln = .65;
			this.level = 14;
			this.gems = rand(15) + 25;
			this.drop = NO_DROP;
			this.wings.type = Wings.IMP;
			this.special1 = lustMagicAttack;
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 14, 0, 0, 0);
			checkMonster();
		}
		
	}

}
