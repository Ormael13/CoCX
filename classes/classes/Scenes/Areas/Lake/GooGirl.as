package classes.Scenes.Areas.Lake
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.Scenes.Combat.CombatAbility;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class GooGirl extends Monster
	{
		/*Fight-
		 You are fighting a goo-girl.
		 The goo-girl has a curious expression on her youthful, shimmering face. Her body is slender and globs of slime regularly drip from her limbs, splattering into the goo puddle pooling beneath her hips. A small, heart-shaped nucleus pulses in her chest with a red glow. [if the player has a c-cup or larger chest: She has apparently made herself a bit more like you, as her chest appears to be a perfect copy of your " + biggestBreastSizeDescript()+ ".]
		 */
		
		
		override public function postPlayerAbility(ability:CombatAbility, display:Boolean = true):void {
			//[Using fire attacks on the goo]
			if (ability.hasTag(CombatAbility.TAG_DAMAGING) && ability.hasTag(CombatAbility.TAG_FIRE)) {
				if (display) outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture." + 
					" When the fire passes, she seems a bit smaller and her slimy " + bodyColor + " skin has lost some of its shimmer.");
				if(!hasPerk(PerkLib.Acid)) createPerk(PerkLib.Acid,0,0,0,0);
			}
		}
		
		//[Goo attacks]
//Slap – The slime holds its hands up and they morph into a replica of your " + weaponName + ". Happily, she swings at you, painfully smacking her gooey limbs against your head.  You shake your " + hairDescript() + ", clearing your head of the dazing slap. (lightly damages hit points)
//Acid Slap (Only after player's fire attack) – Her body quivering from your flames, the goo-girl delivers a painful slap across your cheek. You gasp when the light stinging becomes a searing burn that seems to get worse as time goes on! (heavily damages hit points and puts Acid Burn on the player)
		private function gooGalAttack():void
		{
			var damage:Number = 0;
			//return to combat menu when finished
			doNext(EventParser.playerMenu);
			if (hasPerk(PerkLib.Acid)) outputText("Her body quivering from your flames, the goo-girl ");
			else outputText("The slime holds its hands up and they morph into a replica of your [weapon].  Happily, she swings at you");
			//Determine if dodged!
			if (player.getEvasionRoll()) {
				if (hasPerk(PerkLib.Acid)) outputText("tries to slap you, but you dodge her attack.");
				else outputText(", missing as you dodge aside.");
				return;
			}
			//Determine damage - str modified by enemy toughness!
			if (hasPerk(PerkLib.Acid)) damage = int((str + 10 + weaponAttack) - rand(player.tou) - player.armorDef);
			else damage = int((str + weaponAttack) - rand(player.tou) - player.armorDef);
			
			if (damage <= 0) {
				damage = 0;
				if (hasPerk(PerkLib.Acid)) {
					if (rand(player.armorDef + player.tou) < player.armorDef) outputText("tries to slap you, but the acid-bearing slap spatters weakly off your [armor]. ");
					else outputText("tries to slap you with an acid-loaded hand, but it splatters off you ineffectually. ");
				}
				else {
					//Due to toughness or amor...
					if (rand(player.armorDef + player.tou) < player.armorDef) outputText(", her attack slapping fruitlessly against your [armor]. ");
					else outputText(", her attack splattering ineffectually against you. ");
				}
			}
			//everyone else
			else {
				if (hasPerk(PerkLib.Acid)) {
					outputText("delivers a painful slap across your cheek.  You gasp when the light stinging becomes a searing burn that seems to get worse as time goes on! ");
					if (!player.hasStatusEffect(StatusEffects.AcidSlap)) player.createStatusEffect(StatusEffects.AcidSlap, 0, 0, 0, 0);
				}
				else outputText(", painfully smacking her gooey limbs against your head.  You shake your [hair], clearing your head of the dazing slap. ");
			}
			if (damage > 0) {
				if (lustVuln > 0 && player.armorName == "barely-decent bondage straps") {
					if (!plural) outputText("\n" + capitalA + short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed. ");
					else outputText("\n" + capitalA + short + " brush against your exposed skin and jerk back in surprise, coloring slightly from seeing so much of you revealed. ");
					lust += 5 * lustVuln;
				}
			}
			if (damage > 0) player.takePhysDamage(damage, true);
			statScreenRefresh();
			outputText("\n");
		}

//Play –
		private function gooPlay():void
		{
			outputText("The goo-girl lunges, wrapping her slimy arms around your waist in a happy hug, hot muck quivering excitedly against you. She looks up, empty eyes confused by your lack of enthusiasm and forms her mouth into a petulant pout before letting go.  You shiver in the cold air, regretting the loss of her embrace.");
			player.takeLustDamage(3 + rand(3) + player.effectiveSensitivity() / 10, true);
		}

//Throw –
		private function gooThrow():void
		{
			outputText("The girl reaches into her torso, pulls a large clump of goo out, and chucks it at you like a child throwing mud. The slime splatters on your chest and creeps under your [armor], tickling your skin like fingers dancing across your body. ");
			var damage:Number = 1;
			player.takePhysDamage(damage, true);
			player.takeLustDamage(5 + rand(3) + player.effectiveSensitivity() / 10, true);
		}

//Engulf –
		private function gooEngulph():void
		{
			outputText("The goo-girl gleefully throws her entire body at you and, before you can get out of the way, she has engulfed you in her oozing form! Tendrils of " + bodyColor + " slime slide up your nostrils and through your lips, filling your lungs with the girl's muck. You begin suffocating!");
			if (!player.hasStatusEffect(StatusEffects.GooBind)) player.createStatusEffect(StatusEffects.GooBind, 0, 0, 0, 0);
		}

		override protected function performCombatAction():void
		{
			//1/3 chance of base attack + bonus if in acid mode
			if ((hasPerk(PerkLib.Acid) && rand(3) == 0) || rand(3) == 0)
				gooGalAttack();
			else if (rand(5) == 0) gooEngulph();
			else if (rand(3) == 0) gooPlay();
			else gooThrow();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.lake.gooGirlScene.beatUpGoo();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nThe goo-girl seems confused but doesn't mind.");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.lake.gooGirlScene.getBeatByGooGirl();
			}
		}

		override public function teased(lustDelta:Number, isNotSilent:Boolean = true, display:Boolean = true):void
		{
			if (lust <= maxLust() * 0.99) {
				if (lustDelta <= 0) outputText("\nThe goo-girl looks confused by your actions, as if she's trying to understand what you're doing.");
				else if (lustDelta < maxLust() * 0.13) outputText("\nThe curious goo has begun stroking herself openly, trying to understand the meaning of your actions by imitating you.");
				else outputText("\nThe girl begins to understand your intent. She opens and closes her mouth, as if panting, while she works slimy fingers between her thighs and across her jiggling nipples.");
			}
			else outputText("\nIt appears the goo-girl has gotten lost in her mimicry, squeezing her breasts and jilling her shiny " + bodyColor + " clit, her desire to investigate you forgotten.");
			applyTease(lustDelta, display);
		}

		public function GooGirl(noInit:Boolean = false)
		{
			if (noInit) return;
			var playerHasBigBoobs:Boolean = player.biggestTitSize() >= 3;
			this.a = "the ";
			this.short = "goo-girl";
			this.imageName = "googirl";
			this.long = "The goo-girl has a curious expression on her youthful, shimmering face. Her body is slender and globs of slime regularly drip from her limbs, splattering into the goo puddle pooling beneath her hips. A small, heart-shaped nucleus pulses in her chest with a red glow." + (playerHasBigBoobs ? ("  She has apparently made herself a bit more like you, as her chest appears to be a perfect copy of your [chest].") : "");
			// this.long = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 9001, 0, 0, 0);
			this.createBreastRow(playerHasBigBoobs ? player.biggestTitSize() : 3);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.createStatusEffect(StatusEffects.BonusACapacity,9001,0,0,0);
			this.tallness = rand(8) + 70;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.GOO;
			var tone:String = randomChoice("blue", "purple", "crystal");
			this.skin.setBaseOnly({color:tone,type:Skin.GOO});
			this.hairColor = tone;
			this.hairLength = 12 + rand(10);
			initStrTouSpeInte(32, 40, 20, 30);
			initWisLibSensCor(30, 50, 40, 10);
			this.weaponName = "hands";
			this.weaponVerb="slap";
			this.weaponAttack = 7;
			this.armorName = "gelatinous skin";
			this.armorDef = 4;
			this.armorMDef = 12;
			this.bonusHP = 40;
			this.bonusLust = 96;
			this.lust = 45;
			this.lustVuln = .75;
			this.level = 6;
			this.gems = rand(6) + 4;
			this.drop = new ChainedDrop().add(weapons.PIPE,1/10)
					.add(consumables.WETCLTH,1/2)
					.elseDrop(useables.GREENGL);
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGooType, 0, 0, 0, 0);
			checkMonster();
		}

//Color types are presented as [Blue slimes/Purple Slimes/Clear Slimes]
		public function gooColor():String
		{
			//blue, purple, or crystal
			return bodyColor;
		}

//[azure/plum/crystalline]
		public function gooColor2():String
		{
			if (bodyColor == "blue") return "azure";
			else if (bodyColor == "purple") return "plum";
			else return "crystalline";
		}

//[cerulean/violet/clear]
		public function gooColor3():String
		{
			if (bodyColor == "blue") return "cerulean";
			else if (bodyColor == "purple") return "violet";
			else return "clear";
		}

//[teal/lavender/glassy]
		public function gooColor4():String
		{
			if (bodyColor == "blue") return "teal";
			else if (bodyColor == "purple") return "lavender";
			else return "glassy";
		}

//[sapphire/amethyst/diamond]
		public function gooColor5():String
		{
			if (bodyColor == "blue") return "sapphire";
			else if (bodyColor == "purple") return "amethyst";
			else return "diamond";
		}

//[lapis/periwinkle/pure]
		public function gooColor6():String
		{
			if (bodyColor == "blue") return "sapphire";
			else if (bodyColor == "purple") return "amethyst";
			else return "diamond";
		}

//[blue berry/grape/crystal]
		public function gooColor7():String
		{
			if (bodyColor == "blue") return "blueberry";
			else if (bodyColor == "purple") return "grape";
			else return "crystal";
		}

//[aquamarine/plum/transparent]
		public function gooColor8():String
		{
			if (bodyColor == "blue") return "aquamarine";
			else if (bodyColor == "purple") return "plum";
			else return "transparent";
		}

//[an aquamarine/a lilac/a translucent]
		public function gooColor9():String
		{
			if (bodyColor == "blue") return "an aquamarine";
			else if (bodyColor == "purple") return "a plum";
			else return "a translucent";
		}

//[blueberries/grapes/strawberries]
		public function gooColor10():String
		{
			if (bodyColor == "blue") return "blueberries";
			else if (bodyColor == "purple") return "grapes";
			else return "strawberries";
		}

//[cerulean tint/violet tint/clear body]
		public function gooColor11():String
		{
			if (bodyColor == "blue") return "cerulean tint";
			else if (bodyColor == "purple") return "violet tint";
			else return "clear body";
		}
	}

}
