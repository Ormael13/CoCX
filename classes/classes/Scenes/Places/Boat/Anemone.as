package classes.Scenes.Places.Boat
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hair;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.StatusEffects.Combat.AnemoneVenomDebuff;
import classes.internals.WeightedDrop;

public class Anemone extends Monster
	{
		private static const STAT_DOWN_FLAT:int = 4;
		private static const STAT_DOWN_MULT:int = 4;
		private var cuteCheck:Boolean = true;

		override public function eAttack():void
		{
			outputText("Giggling playfully, the anemone launches several tentacles at you.  Most are aimed for your crotch, but a few attempt to caress your chest and face.\n");
			super.eAttack();
		}

		override public function eOneAttack(display:Boolean = false):int
		{
			applyVenom(rand(STAT_DOWN_FLAT + STAT_DOWN_MULT*player.newGamePlusMod() + player.effectiveSensitivity() / 20) + 1);
			return 1;
		}

		//Apply the effects of AnemoneVenom()
		public function applyVenom(amt:Number = 1):void
		{
			var ave:AnemoneVenomDebuff = player.createOrFindStatusEffect(StatusEffects.AnemoneVenom) as AnemoneVenomDebuff;
			ave.applyEffect(amt);
		}

		override public function preMeleeDmg(damage:Number):Number{
			//hit successful:
			//special event, block (no more than 10-20% of turns, also fails if PC has >75 corruption):
			cuteCheck = true;
			if (rand(10) <= 1) {
				outputText("Seeing your [weapon] raised, the anemone looks down at the water, angles her eyes up at you, and puts out a trembling lip.  ");
				if (player.cor < 75) {
					outputText("You stare into her hangdog expression and lose most of the killing intensity you had summoned up for your attack, stopping a few feet short of hitting her.\n");
					//damage = 0;
					//Kick back to main if no damage occured!
					// so cute! skip remaining attacks
					cuteCheck = false;

				} else outputText("Though you lose a bit of steam to the display, the drive for dominance still motivates you to follow through on your swing.");
			}
			return damage;
		}
		override public function postMeleeDmgSkip(attackInstance:int):Boolean{
			if(attackInstance==1)
				return cuteCheck;
			else
				return true;
		}
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.boat.anemoneScene.defeatAnemone();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe anemone, having reached out to try and catch some of the load but missing the grab, sets her face in an irate scowl and approaches you...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.boat.anemoneScene.loseToAnemone();
			}
		}

		override public function outputAttack(damage:int):void
		{
			outputText("You jink and dodge valiantly but the tentacles are too numerous and coming from too many directions.  A few get past your guard and caress your skin, leaving a tingling, warm sensation that arouses you further.");
		}

		public function Anemone()
		{
			this.a = "the ";
			this.short = "anemone";
			this.imageName = "anemone";
			this.long = "The anemone is a blue androgyne humanoid of medium height and slender build, with colorful tentacles sprouting on her head where hair would otherwise be.  Her feminine face contains two eyes of solid color, lighter than her skin.  Two feathery gills sprout from the middle of her chest, along the line of her spine and below her collarbone, and drape over her pair of small B-cup breasts.  Though you wouldn't describe her curves as generous, she sways her girly hips back and forth in a way that contrasts them to her slim waist quite attractively.  Protruding from her groin is a blue shaft with its head flanged by diminutive tentacles, and below that is a dark-blue pussy ringed by small feelers.  Further down are a pair of legs ending in flat sticky feet; proof of her aquatic heritage.  She smiles broadly and innocently as she regards you from her deep eyes.";
			// this.plural = false;
			this.createCock(7,1,CockTypesEnum.ANEMONE);
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 5, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("B"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 5*12+5;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_NOTICEABLE;
			this.bodyColor = "purple";
			this.hairColor = "purplish-black";
			this.hairLength = 20;
			this.hairType = Hair.ANEMONE;
			initStrTouSpeInte(127, 90, 80, 60);
			initWisLibSensCor(60, 69, 47, 0);
			this.weaponName = "tendrils";
			this.weaponVerb="tentacle";
			this.weaponAttack = 24;
			this.armorName = "clammy skin";
			this.armorDef = 30;
			this.armorMDef = 3;
			this.bonusHP = 240;
			this.bonusLust = 131;
			this.lust = 30;
			this.lustVuln = .9;
			this.level = 15;
			this.gems = rand(20) + 20;
			this.drop = new WeightedDrop(consumables.DRYTENT, 1);
			checkMonster();
		}
		
	}

}
