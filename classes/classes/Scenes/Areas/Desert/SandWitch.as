package classes.Scenes.Areas.Desert
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.*;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class SandWitch extends Monster
	{


		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.StoneLust))
			{
				player.removeStatusEffect(StatusEffects.StoneLust);
			}
			SceneLib.desert.sandWitchScene.beatSandwitch();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe witch blanches and backs away, leaving you to your fate.");
				SceneLib.combat.cleanupAfterCombatImpl();
			} else {
				SceneLib.desert.sandWitchScene.sandwitchRape();
			}
		}
		
		private function lustMagicAttack():void {
			outputText("The sand witch points at you, drawing a circle in the air and mouthing strange words.\n\n");
			if (player.hasStatusEffect(StatusEffects.StoneLust)) {
				outputText("The orb inside you grows warm, almost hot, suffusing your body with heat and arousal.  ");
				player.takeLustDamage(8 + int(player.effectiveSensitivity()) / 5, true);
			}
			else {
				outputText("You feel the sands shift by your [feet], and look down to see something slip out of the sands and into your clothes!  It feels incredibly smooth and circular as it glides upward along your [leg], its progress unaffected by your frantic effort to dislodge it.  ");
				if (player.vaginas.length > 0) outputText("It glides up your thighs to the entrance of your sex, and its intentions dawn on you!\n\nToo late! You reach to stop it, but it pushes against your lips and slips inside your " + vaginaDescript(0) + " in an instant.  You groan in frustration as it begins pulsing and vibrating, sometimes even seeming to change size.");
				else outputText("It glides up your thighs, curving around your buttocks, and its intentions dawn on you.\n\nYou desperately grab for it, but are too late!  It pushes firmly against your rectum and slips inside instantaneously.  You groan in frustration as it begins pulsing and vibrating, sometimes even seeming to change size.");
				player.createStatusEffect(StatusEffects.StoneLust, 0, 0, 0, 0);
				player.takeLustDamage(4 + int(player.effectiveSensitivity()) / 5, true);
			}
			doNext(EventParser.playerMenu);
		}
		
		public function SandWitch()
		{
			trace("SandWitch Constructor!");
			this.a = "the ";
			if(EngineCore.silly()){
				this.short = "sand witch";
				this.imageName = "sandwidch";
			} else {
				this.short = "sand witch";
				this.imageName = "sandwitch";
			}
			this.long = "A sand witch appears to be totally human, an oddity in this strange land.  She has dirty blonde hair and a very tanned complexion, choosing to cover most of her body with robes of the same color as the desert sands, making her impossible to spot from afar.";
			this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_LOOSE);
			this.createBreastRow(Appearance.breastCupInverse("DD"));
			this.createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = rand(12) + 55;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE;
			this.bodyColor = "bronzed";
			this.hairColor = "sandy-blonde";
			this.hairLength = 15;
			initStrTouSpeInte(55, 75, 65, 110);
			initWisLibSensCor(100, 105, 80, -40);
			this.weaponName = "kick";
			this.weaponVerb="kick";
			this.weaponAttack = 2;
			this.armorName = "robes";
			this.armorDef = 20;
			this.armorMDef = 100;
			this.bonusHP = 100;
			this.bonusLust = 199;
			this.lust = 30;
			this.level = 14;
			this.gems = rand(15) + 5;
			this.drop = new WeightedDrop().addMany(2,
					consumables.TSCROLL,
					consumables.OVIELIX,
					consumables.LACTAID,
					consumables.LABOVA_).
					addMany(1,
					consumables.W__BOOK,
					consumables.B__BOOK,
					consumables.RMANUSC,
					consumables.CRIMS_J,
					weapons.WDAGGER,
					weapons.A_WAND);
			this.abilities = [
				{call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[]},
				{call: lustMagicAttack, type: ABILITY_MAGIC, range: RANGE_RANGED, tags:[]},
				{call: special2, type: ABILITY_MAGIC, range: RANGE_RANGED, tags:[]},
				{call: special3, type: ABILITY_MAGIC, range: RANGE_RANGED, tags:[]}
			];
			//this.special1 = lustMagicAttack;
			//this.special2 = special2;
			//this.special3 = special3;
			checkMonster();
		}

	}

}
