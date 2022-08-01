package classes.Scenes.Dungeons.DemonLab 
{
	/**
	 * ...
	 * @author ...
	 */
	public class MutantIncubus 
	{
		
		public function MutantIncubus() 
		{
			import Scenes.Dungeons.DemonLab;
			this.a = "the ";
			this.short = "Mutant Incubus";
			this.imageName = "demonmob";
			this.long= "";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createCock(18,2);
			this.createCock(18,2,CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(8) + 70;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.bodyColor = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(170, 290, 280, 40);
			initWisLibSensCor(40, 150, 80, 100);
			this.weaponName = "claws";
			this.weaponVerb="weapons";
			this.weaponAttack = 89;
			this.armorName = "demonic skin";
			this.armorDef = 85;
			this.armorMDef = 60;
			this.bonusHP = 1200;
			this.bonusLust = 575;
			this.lust = 20;
			this.level = 55;
			this.gems = rand(60)+20;
			this.randomDropChance = 0.1;
			this.randomDropParams = {
				rarity: DynamicItems.RARITY_CHANCES_LESSER
			};
			this.drop = new WeightedDrop().addMany(1,
							consumables.SUCMILK,
							consumables.INCUBID,
							consumables.OVIELIX,
							consumables.B__BOOK);

			this.tailType = Tail.DEMONIC;
			this.horns.type = Horns.DEMON;
			this.horns.count = 2;
			this.createPerk(PerkLib.EnemyLargeGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 45, 0, 0, 0);
			checkMonster();
		}	
		}
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.DemonLab.AfterLabGuardsVictory();
		}
override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.DemonLab.BadEndExperiment();
		}
		
	}

}