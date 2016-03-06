package classes.Scenes.NPCs
{
	import classes.*;
	import classes.internals.WeightedDrop;

	public class Anemone extends Monster
	{


		override public function eAttack():void
		{
			outputText("Giggling playfully, the anemone launches several tentacles at you.  Most are aimed for your crotch, but a few attempt to caress your chest and face.\n", false);
			super.eAttack();
		}

		override public function eOneAttack():int
		{
			applyVenom(rand(4 + player.sens / 20) + 1);
			return 1;
		}

		//Apply the effects of AnemoneVenom()
		public function applyVenom(str:Number = 1):void
		{
			//First application
			if (player.findStatusEffect(StatusEffects.AnemoneVenom) < 0) player.createStatusEffect(StatusEffects.AnemoneVenom, 0, 0, 0, 0);
			//Gain some lust
			game.dynStats("lus", (2 * str));

			//Loop through applying 1 point of venom at a time.
			while (str > 0) {
				str--;
				//Str bottommed out, convert to lust
				if (player.str < 2) game.dynStats("lus", 2);
				//Lose a point of str.
				else {
					showStatDown("str");
					// strDown.visible = true;
					// strUp.visible = false;
					player.str--;
					player.addStatusValue(StatusEffects.AnemoneVenom, 1, 1);
				}
				//Spe bottomed out, convert to lust
				if (player.spe < 2) game.dynStats("lus", 2);
				//Lose a point of spe.
				else {
					showStatDown("spe");
					// speDown.visible = true;
					// speUp.visible = false;
					player.spe--;
					player.addStatusValue(StatusEffects.AnemoneVenom, 2, 1);
				}
			}
			game.statScreenRefresh();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			game.anemoneScene.defeatAnemone();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem to mind at all...");
				doNext(game.combat.endLustLoss);
			} else {
				game.anemoneScene.loseToAnemone();
			}
		}

		override public function outputAttack(damage:int):void
		{
			outputText("You jink and dodge valiantly but the tentacles are too numerous and coming from too many directions.  A few get past your guard and caress your skin, leaving a tingling, warm sensation that arouses you further.", false);
		}

		public function Anemone()
		{
			this.a = "the ";
			this.short = "anemone";
			this.imageName = "anemone";
			this.long = "The anemone is a blue androgyne humanoid of medium height and slender build, with colorful tentacles sprouting on her head where hair would otherwise be.  Her feminine face contains two eyes of solid color, lighter than her skin.  Two feathery gills sprout from the middle of her chest, along the line of her spine and below her collarbone, and drape over her pair of small B-cup breasts.  Though you wouldn't describe her curves as generous, she sways her girly hips back and forth in a way that contrasts them to her slim waist quite attractively.  Protruding from her groin is a blue shaft with its head flanged by diminutive tentacles, and below that is a dark-blue pussy ringed by small feelers.  Further down are a pair of legs ending in flat sticky feet; proof of her aquatic heritage.  She smiles broadly and innocently as she regards you from her deep eyes.";
			// this.plural = false;
			this.createCock(7,1,CockTypesEnum.ANEMONE);
			this.createVagina(false, VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 5, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("B"));
			this.ass.analLooseness = ANAL_LOOSENESS_NORMAL;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 5*12+5;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_NOTICEABLE;
			this.skinTone = "purple";
			this.hairColor = "purplish-black";
			this.hairLength = 20;
			this.hairType = HAIR_ANEMONE;
			initStrTouSpeInte(40, 20, 40, 50);
			initLibSensCor(55, 35, 50);
			this.weaponName = "tendrils";
			this.weaponVerb="tentacle";
			this.weaponAttack = 5;
			this.armorName = "clammy skin";
			this.bonusHP = 120;
			this.lust = 30;
			this.lustVuln = .9;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 4;
			this.gems = rand(5) + 1;
			this.drop = new WeightedDrop(consumables.DRYTENT, 1);
			checkMonster();
		}
		
	}

}