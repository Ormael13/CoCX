package classes.Scenes.Areas.Desert
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.*;

	public class SandWitch extends Monster
	{


		override public function defeated(hpVictory:Boolean):void
		{
			if (player.findStatusEffect(StatusEffects.StoneLust))
			{
				player.removeStatusEffect(StatusEffects.StoneLust);
			}
			
			if (player.lust >= 33 && flags[kFLAGS.SFW_MODE] <= 0){
				game.desert.sandWitchScene.beatSandwitch();
			} else {
				game.combat.finishCombat();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe witch blanches and backs away, leaving you to your fate.");
				game.combat.cleanupAfterCombat();
			} else {
				game.desert.sandWitchScene.sandwitchRape();
			}
		}
		
		private function lustMagicAttack():void {
			outputText("The sand witch points at you, drawing a circle in the air and mouthing strange words.\n\n");
			if (player.findStatusEffect(StatusEffects.StoneLust) >= 0) {
				outputText("The orb inside you grows warm, almost hot, suffusing your body with heat and arousal.  ");
				game.dynStats("lus", 8 + int(player.sens) / 10);
			}
			else {
				outputText("You feel the sands shift by your " + player.feet() + ", and look down to see something slip out of the sands and into your clothes!  It feels incredibly smooth and circular as it glides upward along your " + player.leg() + ", its progress unaffected by your frantic effort to dislodge it.  ");
				if (player.vaginas.length > 0) outputText("It glides up your thighs to the entrance of your sex, and its intentions dawn on you!\n\nToo late! You reach to stop it, but it pushes against your lips and slips inside your " + player.vaginaDescript(0) + " in an instant.  You groan in frustration as it begins pulsing and vibrating, sometimes even seeming to change size.");
				else outputText("It glides up your thighs, curving around your buttocks, and its intentions dawn on you.\n\nYou desperately grab for it, but are too late!  It pushes firmly against your rectum and slips inside instantaneously.  You groan in frustration as it begins pulsing and vibrating, sometimes even seeming to change size.");
				player.createStatusEffect(StatusEffects.StoneLust, 0, 0, 0, 0);
				game.dynStats("lus", 4 + int(player.sens) / 10);
			}
			doNext(game.playerMenu);
		}
		
		public function SandWitch()
		{
			trace("SandWitch Constructor!");
			this.a = "the ";
			if (game.silly()){
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
			this.special1 = lustMagicAttack;
			this.special2 = special2;
			this.special3 = special3;
			checkMonster();
		}

	}

}