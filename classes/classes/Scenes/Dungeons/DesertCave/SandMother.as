package classes.Scenes.Dungeons.DesertCave
{
	import classes.*;

	public class SandMother extends Monster
	{

		override public function defeated(hpVictory:Boolean):void
		{
			game.defeatTheSandMother();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.loseToTheSandMother();
		}

		public function SandMother()
		{
			this.a = "the ";
			this.short = "Sand Mother";
			this.imageName = "sandmother";
			this.long = "The Sand Mother is a towering woman of imposing stature and bust.  She wears a much silkier, regal-looking robe than her sisters, and it barely serves to contain her four milk-laden breasts, straining under their jiggling weight.  Dangling around her in a way that reminds you oddly of a halo, the Sand Mother's blonde-white hair fans around her, hanging long behind her.  The queen witch is brandishing a pearly white scepter rather threateningly, though from the way she holds it, it's clear she doesn't intend to use it as a physical weapon.";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_WET, VAGINA_LOOSENESS_LOOSE);
			this.createStatusAffect(StatusAffects.BonusVCapacity, 70, 0, 0, 0);
			this.createBreastRow(Appearance.breastCupInverse("DD"));
			this.createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.createStatusAffect(StatusAffects.BonusACapacity,50,0,0,0);
			this.tallness = 8*12+6;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "bronzed";
			this.hairColor = "platinum-blonde";
			this.hairLength = 15;
			initStrTouSpeInte(55, 55, 35, 45);
			initLibSensCor(55, 40, 30);
			this.weaponName = "fists";
			this.weaponVerb="punches";
			this.weaponAttack = 0;
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "robes";
			this.armorDef = 1;
			this.bonusHP = 130;
			this.lust = 20;
			this.lustVuln = .6;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 7;
			this.gems = rand(15) + 55;
			this.createPerk(PerkLib.Resolute,0,0,0,0);
			this.createPerk(PerkLib.Focused,0,0,0,0);
			this.drop = NO_DROP;
			checkMonster();
		}
		
	}

}