package classes.Scenes.Camp
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Monsters.Imp;
	
	public class ImpGang extends Imp
	{
		override public function get capitalA():String {
			return "gang of imps";
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void {
			game.impScene.impGangabangaEXPLOSIONS(true);
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.flags[kFLAGS.DEMONS_DEFEATED]++;
			game.impScene.impGangGetsWhooped();
		}
		
		public function ImpGang()
		{
			this.a = "a ";
			this.short = "mob of imps";
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
			this.createStatusEffect(StatusEffects.GenericRunDisabled, 0, 0, 0, 0);
			this.long = "The imps stand anywhere from two to four feet tall, with scrawny builds and tiny demonic wings. Their red and orange skin is dirty, and their dark hair looks greasy. Some are naked, but most are dressed in ragged loincloths that do little to hide their groins. They all have a " + cockDescript(0) + " as long and thick as a man's arm, far oversized for their bodies."
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			initStrTouSpeInte(70, 40, 75, 42);
			initLibSensCor(55, 35, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 10;
			this.armorName = "leathery skin";
			this.armorDef = 3;
			this.bonusHP = 300;
			this.lust = 30;
			this.lustVuln = .65;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 10;
			this.gems = rand(15) + 25;
			this.drop = NO_DROP;
			this.wingType = WING_TYPE_IMP;
			this.special1 = lustMagicAttack;
			checkMonster();
		}
		
	}

}