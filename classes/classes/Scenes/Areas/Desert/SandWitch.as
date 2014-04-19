package classes.Scenes.Areas.Desert
{
	import classes.*;
	import classes.internals.*;

	public class SandWitch extends Monster
	{


		override public function defeated(hpVictory:Boolean):void
		{
			if (player.findStatusAffect(StatusAffects.StoneLust))
			{
				player.removeStatusAffect(StatusAffects.StoneLust);
			}
			
			if (player.lust >= 33){
				game.desert.sandWitchScene.beatSandwitch();
			} else {
				game.finishCombat();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe witch blanches and backs away, leaving you to your fate.", false);
				game.cleanupAfterCombat();
			} else {
				game.desert.sandWitchScene.sandwitchRape();
			}
		}
		
		public function SandWitch()
		{
			trace("SandWitch Constructor!");
			this.a = "the ";
			if(game.silly()){
				this.short = "sand witch";
				this.imageName = "sandwidch";
			} else {
				this.short = "sand witch";
				this.imageName = "sandwitch";
			}
			this.long = "A sand witch appears to be totally human, an oddity in this strange land.  She has dirty blonde hair and a very tanned complexion, choosing to cover most of her body with robes of the same color as the desert sands, making her impossible to spot from afar.";
			this.createVagina(false, VAGINA_WETNESS_WET, VAGINA_LOOSENESS_LOOSE);
			this.createBreastRow(Appearance.breastCupInverse("DD"));
			this.createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = rand(12) + 55;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "bronzed";
			this.hairColor = "sandy-blonde";
			this.hairLength = 15;
			initStrTouSpeInte(25, 25, 35, 45);
			initLibSensCor(55, 40, 30);
			this.weaponName = "kick";
			this.weaponVerb="kick";
			this.armorName = "robes";
			this.bonusHP = 20;
			this.lust = 30;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 3;
			this.gems = rand(15) + 5;
			this.drop = new WeightedDrop().addMany(1,
					consumables.TSCROLL,
					consumables.OVIELIX,
					consumables.LACTAID,
					consumables.LABOVA_,
					consumables.W__BOOK,
					consumables.B__BOOK,
					null);
			this.special1 = 5020;
			this.special2 = special2;
			this.special3 = special3;
			checkMonster();
		}

	}

}