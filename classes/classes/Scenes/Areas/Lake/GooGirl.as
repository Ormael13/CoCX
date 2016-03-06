package classes.Scenes.Areas.Lake
{
	import classes.*;
	import classes.internals.*;

	public class GooGirl extends Monster
	{
		/*Fight-
		 You are fighting a goo-girl.
		 The goo-girl has a curious expression on her youthful, shimmering face. Her body is slender and globs of slime regularly drip from her limbs, splattering into the goo puddle pooling beneath her hips. A small, heart-shaped nucleus pulses in her chest with a red glow. [if the player has a c-cup or larger chest: She has apparently made herself a bit more like you, as her chest appears to be a perfect copy of your " + player.biggestBreastSizeDescript() + ".]
		 */

//[Goo attacks]
//Slap – The slime holds its hands up and they morph into a replica of your " + weaponName + ". Happily, she swings at you, painfully smacking her gooey limbs against your head.  You shake your " + player.hairDescript() + ", clearing your head of the dazing slap. (lightly damages hit points)
//Acid Slap (Only after player's fire attack) – Her body quivering from your flames, the goo-girl delivers a painful slap across your cheek. You gasp when the light stinging becomes a searing burn that seems to get worse as time goes on! (heavily damages hit points and puts Acid Burn on the player)
		private function gooGalAttack():void
		{
			var damage:Number = 0;
			//return to combat menu when finished
			doNext(game.playerMenu);
			if (findPerk(PerkLib.Acid) >= 0) outputText("Her body quivering from your flames, the goo-girl ", false);
			else outputText("The slime holds its hands up and they morph into a replica of your " + player.weaponName + ".  Happily, she swings at you", false);
			//Determine if dodged!
			if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				if (findPerk(PerkLib.Acid) >= 0) outputText("tries to slap you, but you dodge her attack.", false);
				else outputText(", missing as you dodge aside.", false);
				return;
			}
			//Determine if evaded
			if (short != "Kiha" && player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				if (findPerk(PerkLib.Acid) >= 0) outputText("tries to slap you, but you evade her attack.", false);
				else outputText(", but you evade the clumsy attack.", false);
				return;
			}
			//("Misdirection"
			if (player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				if (findPerk(PerkLib.Acid) >= 0) outputText("tries to slap you.  You misdirect her, avoiding the hit.", false);
				else outputText(", missing as you misdirect her attentions.", false);
				return;
			}
			//Determine if cat'ed
			if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
				if (findPerk(PerkLib.Acid) >= 0) outputText("tries to slap you, but misses due to your cat-like evasion.", false);
				else outputText(", missing due to your cat-like evasion.", false);
				return;
			}
			//Determine damage - str modified by enemy toughness!
			if (findPerk(PerkLib.Acid) >= 0) damage = int((str + 10 + weaponAttack) - rand(player.tou) - player.armorDef);
			else damage = int((str + weaponAttack) - rand(player.tou) - player.armorDef);
			
			if (damage <= 0) {
				damage = 0;
				if (findPerk(PerkLib.Acid) >= 0) {
					if (rand(player.armorDef + player.tou) < player.armorDef) outputText("tries to slap you, but the acid-bearing slap spatters weakly off your " + player.armorName + ". ", false);
					else outputText("tries to slap you with an acid-loaded hand, but it splatters off you ineffectually. ", false);
				}
				else {
					//Due to toughness or amor...
					if (rand(player.armorDef + player.tou) < player.armorDef) outputText(", her attack slapping fruitlessly against your " + player.armorName + ". ", false);
					else outputText(", her attack splattering ineffectually against you. ", false);
				}
			}
			//everyone else
			else {
				if (findPerk(PerkLib.Acid) >= 0) {
					outputText("delivers a painful slap across your cheek.  You gasp when the light stinging becomes a searing burn that seems to get worse as time goes on! ", false);
					if (player.findStatusEffect(StatusEffects.AcidSlap) < 0) player.createStatusEffect(StatusEffects.AcidSlap, 0, 0, 0, 0);
				}
				else outputText(", painfully smacking her gooey limbs against your head.  You shake your " + player.hairDescript() + ", clearing your head of the dazing slap. ", false);
			}
			if (damage > 0) {
				if (lustVuln > 0 && player.armorName == "barely-decent bondage straps") {
					if (!plural) outputText("\n" + capitalA + short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed. ", false);
					else outputText("\n" + capitalA + short + " brush against your exposed skin and jerk back in surprise, coloring slightly from seeing so much of you revealed. ", false);
					lust += 5 * lustVuln;
				}
			}
			if (damage > 0) player.takeDamage(damage, true);
			statScreenRefresh();
			outputText("\n", false);
			combatRoundOver();
		}

//Play – 
		private function gooPlay():void
		{
			outputText("The goo-girl lunges, wrapping her slimy arms around your waist in a happy hug, hot muck quivering excitedly against you. She looks up, empty eyes confused by your lack of enthusiasm and forms her mouth into a petulant pout before letting go.  You shiver in the cold air, regretting the loss of her embrace.", false);
			game.dynStats("lus", 3 + rand(3) + player.sens / 10);
			combatRoundOver();
		}

//Throw – 
		private function gooThrow():void
		{
			outputText("The girl reaches into her torso, pulls a large clump of goo out, and chucks it at you like a child throwing mud. The slime splatters on your chest and creeps under your " + player.armorName + ", tickling your skin like fingers dancing across your body. ", false);
			var damage:Number = 1;
			player.takeDamage(damage, true);
			game.dynStats("lus", 5 + rand(3) + player.sens / 10);
			combatRoundOver();
		}

//Engulf – 
		private function gooEngulph():void
		{
			outputText("The goo-girl gleefully throws her entire body at you and, before you can get out of the way, she has engulfed you in her oozing form! Tendrils of " + skinTone + " slime slide up your nostrils and through your lips, filling your lungs with the girl's muck. You begin suffocating!", false);
			if (player.findStatusEffect(StatusEffects.GooBind) < 0) player.createStatusEffect(StatusEffects.GooBind, 0, 0, 0, 0);
			combatRoundOver();
		}

		override protected function performCombatAction():void
		{
			//1/3 chance of base attack + bonus if in acid mode
			if ((findPerk(PerkLib.Acid) >= 0 && rand(3) == 0) || rand(3) == 0)
				gooGalAttack();
			else if (rand(5) == 0) gooEngulph();
			else if (rand(3) == 0) gooPlay();
			else gooThrow();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.lake.gooGirlScene.beatUpGoo();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nThe goo-girl seems confused but doesn't mind.");
				doNext(game.combat.endLustLoss);
			} else {
				game.lake.gooGirlScene.getBeatByGooGirl();
			}
		}

		override public function teased(lustDelta:Number):void
		{
			if (lust <= 99) {
				if (lustDelta <= 0) outputText("\nThe goo-girl looks confused by your actions, as if she's trying to understand what you're doing.", false);
				else if (lustDelta < 13) outputText("\nThe curious goo has begun stroking herself openly, trying to understand the meaning of your actions by imitating you.", false);
				else outputText("\nThe girl begins to understand your intent. She opens and closes her mouth, as if panting, while she works slimy fingers between her thighs and across her jiggling nipples.", false);
			}
			else outputText("\nIt appears the goo-girl has gotten lost in her mimicry, squeezing her breasts and jilling her shiny " + skinTone + " clit, her desire to investigate you forgotten.", false);
			applyTease(lustDelta);
		}

		public function GooGirl(noInit:Boolean = false)
		{
			if (noInit) return;
			var playerHasBigBoobs:Boolean = player.biggestTitSize() >= 3;
			this.a = "the ";
			this.short = "goo-girl";
			this.imageName = "googirl";
			this.long = "The goo-girl has a curious expression on her youthful, shimmering face. Her body is slender and globs of slime regularly drip from her limbs, splattering into the goo puddle pooling beneath her hips. A small, heart-shaped nucleus pulses in her chest with a red glow." + (playerHasBigBoobs ? ("  She has apparently made herself a bit more like you, as her chest appears to be a perfect copy of your " + player.chestDesc() + ".") : "");
			// this.long = false;
			this.createVagina(false, VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 9001, 0, 0, 0);
			this.createBreastRow(playerHasBigBoobs ? player.biggestTitSize() : 3);
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_SLIME_DROOLING;
			this.createStatusEffect(StatusEffects.BonusACapacity,9001,0,0,0);
			this.tallness = rand(8) + 70;
			this.hipRating = HIP_RATING_AMPLE;
			this.buttRating = BUTT_RATING_LARGE;
			this.lowerBody = LOWER_BODY_TYPE_GOO;
			var tone:String = randomChoice("blue", "purple", "crystal");
			this.skinTone = tone;
			this.skinType = SKIN_TYPE_GOO;
			//this.skinDesc = Appearance.Appearance.DEFAULT_SKIN_DESCS[SKIN_TYPE_GOO];
			this.skinAdj = "goopey";
			this.hairColor = tone;
			this.hairLength = 12 + rand(10);
			initStrTouSpeInte(25, 25, 20, 30);
			initLibSensCor(50, 40, 10);
			this.weaponName = "hands";
			this.weaponVerb="slap";
			this.armorName = "gelatinous skin";
			this.bonusHP = 40;
			this.lust = 45;
			this.lustVuln = .75;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 3;
			this.gems = rand(5) + 1;
			this.drop = new ChainedDrop().add(weapons.PIPE,1/10)
					.add(consumables.WETCLTH,1/2)
					.elseDrop(useables.GREENGL);
/* These are actually green slime functions and were never called in GooGirl due to override of performCombatAction
			this.special1 = 5040;
			this.special2 = 5039;
			this.special3 = 5039;
*/
			checkMonster();
		}

//Color types are presented as [Blue slimes/Purple Slimes/Clear Slimes]
		public function gooColor():String
		{
			//blue, purple, or crystal
			return skinTone;
		}

//[azure/plum/crystalline] 
		public function gooColor2():String
		{
			if (skinTone == "blue") return "azure";
			else if (skinTone == "purple") return "plum";
			else return "crystalline";
		}

//[cerulean/violet/clear]
		public function gooColor3():String
		{
			if (skinTone == "blue") return "cerulean";
			else if (skinTone == "purple") return "violet";
			else return "clear";
		}

//[teal/lavender/glassy] 
		public function gooColor4():String
		{
			if (skinTone == "blue") return "teal";
			else if (skinTone == "purple") return "lavender";
			else return "glassy";
		}

//[sapphire/amethyst/diamond]
		public function gooColor5():String
		{
			if (skinTone == "blue") return "sapphire";
			else if (skinTone == "purple") return "amethyst";
			else return "diamond";
		}

//[lapis/periwinkle/pure]
		public function gooColor6():String
		{
			if (skinTone == "blue") return "sapphire";
			else if (skinTone == "purple") return "amethyst";
			else return "diamond";
		}

//[blue berry/grape/crystal]
		public function gooColor7():String
		{
			if (skinTone == "blue") return "blueberry";
			else if (skinTone == "purple") return "grape";
			else return "crystal";
		}

//[aquamarine/plum/transparent]
		public function gooColor8():String
		{
			if (skinTone == "blue") return "aquamarine";
			else if (skinTone == "purple") return "plum";
			else return "transparent";
		}

//[an aquamarine/a lilac/a translucent]
		public function gooColor9():String
		{
			if (skinTone == "blue") return "an aquamarine";
			else if (skinTone == "purple") return "a plum";
			else return "a translucent";
		}

//[blueberries/grapes/strawberries]
		public function gooColor10():String
		{
			if (skinTone == "blue") return "blueberries";
			else if (skinTone == "purple") return "grapes";
			else return "strawberries";
		}

//[cerulean tint/violet tint/clear body]
		public function gooColor11():String
		{
			if (skinTone == "blue") return "cerulean tint";
			else if (skinTone == "purple") return "violet tint";
			else return "clear body";
		}
	}

}