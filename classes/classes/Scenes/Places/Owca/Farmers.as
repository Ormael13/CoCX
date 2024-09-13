package classes.Scenes.Places.Owca
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;

public class Farmers extends Monster
	{

		override protected function performCombatAction():void
		{
			createStatusEffect(StatusEffects.Attacks,4,0,0,0);
			eAttack();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.owca.beatUpOwca();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.owca.loseToOwca();
		}

		public function Farmers()
		{
			this.a = "the ";
			this.short = "farmers";
			this.imageName = "farmers";
			this.long = "This is a group of thirty angry villagers, almost all human-looking but for the tiny horns-like protrusions growing from their heads and the white fuzz that almost passes off as hair.  They are all armed with pitchforks or other crude farming tools they use in their everyday task.  Rebecc is staring from behind them with horrified eyes at the combat, paralyzed by the sudden turn of events.";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createCock(9,2,CockTypesEnum.HUMAN);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
			createBreastRow(Appearance.breastCupInverse("A"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(8) + 70;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.bodyColor = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(40, 120, 110, 100);
			initWisLibSensCor(100, 35, 35, -40);
			this.weaponName = "pitchforks";
			this.weaponVerb="stab";
			this.weaponAttack = 20;
			this.armorName = "chitin";
			this.armorDef = 10;
			this.armorMDef = 1;
			this.bonusHP = 300;
			this.bonusLust = 94;
			this.lustVuln = 0.01;
			this.level = 24;
			this.gems = rand(50)+100;
			this.horns.type = Horns.DEMON;
			this.horns.count = 2;
			this.tailType = Tail.DEMONIC;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.EnemyLargeGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
