package classes.Scenes.Monsters 
{
	/**
	 * ...
	 * @author Kitteh6660
	 */
	public class GoblinWarrior extends Goblin
	{
		
		public function GoblinWarrior() 
		{
			if (noInit) return;
			this.a = "the ";
			this.short = "goblin warrior";
			this.imageName = "goblinwarrior";
			this.long = "Unlike most goblins you've seen, this one is well armed. She is slightly taller than most of the goblins and her hair is in a deep red hue. She's wearing a metal breastplate that covers her torso, offering her more defense. She's wielding a dagger in her right hand and a wooden shield in her left hand.  In spite of how well she's armed, her nipples and cooter are exposed.";
			this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_NORMAL);
			this.createStatusAffect(StatusAffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusAffect(StatusAffects.BonusACapacity,30,0,0,0);
			this.tallness = 44 + rand(7);
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "dark green";
			this.hairColor = "red";
			this.hairLength = 4;
			initStrTouSpeInte(75, 50, 70, 72);
			initLibSensCor(45, 45, 60);
			this.weaponName = "dagger and shield";
			this.weaponVerb = "slash";
			this.weaponAttack = 8;
			this.armorName = "platemail";
			this.armorDef = 12;
			this.lust = 50;
			this.lustVuln = 0.44
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 16;
			this.gems = rand(5) + 5;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE,5).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.GREEN_D,
							consumables.PURPDYE);
			this.special1 = goblinDrugAttack;
			this.special2 = goblinTeaseAttack;
			checkMonster();			
		}
		
	}

}