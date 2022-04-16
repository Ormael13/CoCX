package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class Marble extends Monster
	{
		private function marbleSpecialAttackOne():void {
			//Special1: Heavy overhead swing, high chance of being avoided with evasion, does heavy damage if it hits.
			var damage:Number = 0;
			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind)) {
				outputText("Marble unwisely tries to make a massive swing while blinded, which you are easily able to avoid.");
				return;
			}
			//Determine if dodged!
			if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 60) {
				outputText("You manage to roll out of the way of a massive overhand swing.");
				return;
			}
			//Determine if evaded
			if(player.hasPerk(PerkLib.Evade) && rand(100) < 60) {
				outputText("You easily sidestep as Marble tries to deliver a huge overhand blow.");
				return;
			}
			//Determine damage - str modified by enemy toughness!
			damage = int((str + 20 + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
			if(damage <= 0) {
				damage = 0;
				//Due to toughness or amor...
				outputText("You somehow manage to deflect and block Marble's massive overhead swing.");
			}
			if(damage > 0) {
				outputText("You are struck by a two-handed overhead swing from the enraged cow-girl.  ");
				damage = player.takePhysDamage(damage, true);
			}
			statScreenRefresh();
		}
		private function marbleSpecialAttackTwo():void {
			//Special2: Wide sweep; very high hit chance, does low damage.
			var damage:Number = 0;
			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind)) {
				outputText("Marble makes a wide sweeping attack with her hammer, which is difficult to avoid even from a blinded opponent.\n");
			}
			//Determine if evaded
			if(player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				outputText("You barely manage to avoid a wide sweeping attack from marble by rolling under it.");
				return;
			}
			//Determine damage - str modified by enemy toughness!
			damage = int((str + 40 + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
			damage /= 2;
			if(damage <= 0) {
				damage = 0;
				//Due to toughness or amor...
				outputText("You easily deflect and block the damage from Marble's wide swing.");
			}
			outputText("Marble easily hits you with a wide, difficult to avoid swing.  ");
			if(damage > 0) player.takePhysDamage(damage, true);
			statScreenRefresh();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.marbleScene.marbleFightWin();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.marbleScene.marbleFightLose();
		}

		public function Marble()
		{
			trace("Marble Constructor!");
			this.a = "";
			this.short = "Marble";
			this.imageName = "marble";
			this.long = "Before you stands a female humanoid with numerous cow features, such as medium-sized cow horns, cow ears, and a cow tail.  She is very well endowed, with wide hips and a wide ass.  She stands over 6 feet tall.  She is using a large two handed hammer with practiced ease, making it clear she is much stronger than she may appear to be.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
			createBreastRow(Appearance.breastCupInverse("F"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 6*12+4;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.HOOFED;
			this.skinTone = "pale";
			this.hairColor = "brown";
			this.hairLength = 13;
			initStrTouSpeInte(85, 80, 45, 40);
			initWisLibSensCor(40, 25, 45, 40);
			this.weaponName = "large hammer";
			this.weaponVerb="hammer-blow";
			this.weaponAttack = 26;
			this.armorName = "tough hide";
			this.armorDef = 10;
			this.armorMDef = 0;
			this.bonusLust = 84;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 14;
			this.gems = rand(15) + 50;
			this.drop = new WeightedDrop(weapons.L_HAMMR, 1);
			this.tailType = Tail.COW;
			this.special1 = marbleSpecialAttackOne;
			this.special2 = marbleSpecialAttackTwo;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
