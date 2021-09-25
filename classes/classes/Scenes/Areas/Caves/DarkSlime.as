/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class DarkSlime extends Monster
	{
		private function gooGalAttack():void
		{
			var damage:Number = 0;
			//return to combat menu when finished
			doNext(EventParser.playerMenu);
			if (hasPerk(PerkLib.Acid)) outputText("Her body quivering from your flames, the dark slime ");
			else outputText("The dark slime holds its hands up and they morph into a replica of your [weapon].  Happily, she swings at you");
			//Determine if dodged!
			if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				if (hasPerk(PerkLib.Acid)) outputText("tries to slap you, but you dodge her attack.");
				else outputText(", missing as you dodge aside.");
				return;
			}
			//Determine if evaded
			if (short != "Kiha" && player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				if (hasPerk(PerkLib.Acid)) outputText("tries to slap you, but you evade her attack.");
				else outputText(", but you evade the clumsy attack.");
				return;
			}
			//("Misdirection"
			if (player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				if (hasPerk(PerkLib.Acid)) outputText("tries to slap you.  You misdirect her, avoiding the hit.");
				else outputText(", missing as you misdirect her attentions.");
				return;
			}
			//Determine if cat'ed
			if (player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				if (hasPerk(PerkLib.Acid)) outputText("tries to slap you, but misses due to your cat-like evasion.");
				else outputText(", missing due to your cat-like evasion.");
				return;
			}
			//Determine damage - str modified by enemy toughness!
			if (hasPerk(PerkLib.Acid)) damage = int(((str + 10 + weaponAttack) * 1.5) - rand(player.tou) - player.armorDef);
			else damage = int(((str + weaponAttack) * 1.5) - rand(player.tou) - player.armorDef);

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
					lust += 6 * lustVuln;
				}
			}
			if (damage > 0) player.takePhysDamage(damage, true);
			statScreenRefresh();
			outputText("\n");
		}
		private function gooPlay():void
		{
			outputText("The dark slime lunges, wrapping her slimy arms around your waist in a happy hug, hot muck quivering excitedly against you. She looks up, empty eyes confused by your lack of enthusiasm and forms her mouth into a petulant pout before letting go.  You shiver in the cold air, regretting the loss of her embrace.");
			player.dynStats("lus", 4 + rand(4) + player.effectiveSensitivity() / 9);
		}
		private function gooThrow():void
		{
			outputText("The girl reaches into her torso, pulls a large clump of goo out, and chucks it at you like a child throwing mud. The slime splatters on your chest and creeps under your [armor], tickling your skin like fingers dancing across your body. ");
			var damage:Number = weaponAttack;
			player.takePhysDamage(damage, true);
			player.dynStats("lus", 7 + rand(4) + player.effectiveSensitivity() / 9);
		}
		private function gooEngulph():void
		{
			outputText("The dark slime gleefully throws her entire body at you and, before you can get out of the way, she has engulfed you in her oozing form! Tendrils of purple slime slide up your nostrils and through your lips, filling your lungs with the girl's muck. You begin suffocating!");
			if (!player.hasStatusEffect(StatusEffects.GooBind)) player.createStatusEffect(StatusEffects.GooBind, 0, 0, 0, 0);
		}
		private function darkslimeMagic():void
		{
			outputText("The slime’s hand waves a pattern in the air, creating a weird portal from which a huge glob of slime launches towards you, splashing your entire body. You feel your arousal spike up as the gooey matter soaks into your skin.");
			var damage:int = (inte/3 + rand(inte/2));
			if (inte >= 21 && inte < 41) damage += (inte / 2 + rand((inte * 3) / 4));
			if (inte >= 41 && inte < 61) damage += ((inte * 2) / 3 + rand(inte));
			if (inte >= 61 && inte < 81) damage += ((inte * 5) / 6 + rand(inte * 1.25));
			if (inte >= 81 && inte < 101) damage += (inte + rand(inte * 1.5));
			if (inte >= 101 && inte < 151) damage += ((inte * 1.25) + rand(inte * 1.75));
			if (inte >= 151 && inte < 201) damage += ((inte * 1.5) + rand(inte * 2));
			if (inte >= 201) damage += ((inte * 1.75) + rand(inte * 2.25));
			player.takeMagicDamage(damage, true);
			player.dynStats("lus", 20 + rand(8) + player.effectiveSensitivity() / 7);
		}
		private function darkslimePoison():void
		{
			outputText("The slime suddenly throws some of its jelly at you. As it sticks to your skin, you start to feel horribly aroused. You have been poisoned with an aphrodisiac!");
			var damage:int = (inte/3 + rand(inte/2));
			if (inte >= 21 && inte < 41) damage += (inte / 2 + rand((inte * 3) / 4));
			if (inte >= 41 && inte < 61) damage += ((inte * 2) / 3 + rand(inte));
			if (inte >= 61 && inte < 81) damage += ((inte * 5) / 6 + rand(inte * 1.25));
			if (inte >= 81 && inte < 101) damage += (inte + rand(inte * 1.5));
			if (inte >= 101 && inte < 151) damage += ((inte * 1.25) + rand(inte * 1.75));
			if (inte >= 151 && inte < 201) damage += ((inte * 1.5) + rand(inte * 2));
			if (inte >= 201) damage += ((inte * 1.75) + rand(inte * 2.25));
			player.takePoisonDamage(damage, true);
			player.dynStats("lus", 20 + rand(8) + player.effectiveSensitivity() / 7);
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.caves.darkslimeScene.beatingDarkSlime();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.defeatedByDarkSlime();
		}

		public function DarkSlime()
		{
			if (player.hasStatusEffect(StatusEffects.EbonLabyrinthB)) {
				if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 250) {
					initStrTouSpeInte(195, 290, 120, 175);
					initWisLibSensCor(175, 370, 300, 10);
					this.weaponAttack = 45;
					this.armorDef = 45;
					this.armorMDef = 135;
					this.bonusHP = 1400;
					this.bonusMana = 350;
					this.bonusLust = 750;
					this.level = 80;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 200) {
					initStrTouSpeInte(188, 272, 120, 170);
					initWisLibSensCor(170, 346, 280, 10);
					this.weaponAttack = 43;
					this.armorDef = 40;
					this.armorMDef = 120;
					this.bonusHP = 1200;
					this.bonusMana = 300;
					this.bonusLust = 702;
					this.level = 76;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 150) {
					initStrTouSpeInte(181, 254, 130, 165);
					initWisLibSensCor(165, 322, 260, 10);
					this.weaponAttack = 41;
					this.armorDef = 35;
					this.armorMDef = 105;
					this.bonusHP = 1000;
					this.bonusMana = 250;
					this.bonusLust = 654;
					this.level = 72;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 100) {
					initStrTouSpeInte(174, 236, 120, 160);
					initWisLibSensCor(160, 298, 240, 10);
					this.weaponAttack = 39;
					this.armorDef = 30;
					this.armorMDef = 90;
					this.bonusHP = 800;
					this.bonusMana = 200;
					this.bonusLust = 606;
					this.level = 68;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 50) {
					initStrTouSpeInte(167, 218, 110, 155);
					initWisLibSensCor(155, 274, 220, 10);
					this.weaponAttack = 37;
					this.armorDef = 25;
					this.armorMDef = 75;
					this.bonusHP = 600;
					this.bonusMana = 150;
					this.bonusLust = 558;
					this.level = 64;
				}
				else {
					initStrTouSpeInte(160, 200, 100, 150);
					initWisLibSensCor(150, 250, 200, 10);
					this.weaponAttack = 35;
					this.armorDef = 20;
					this.armorMDef = 60;
					this.bonusHP = 400;
					this.bonusMana = 100;
					this.bonusLust = 510;
					this.level = 60;
				}
			}
			else {
				initStrTouSpeInte(154, 187, 92, 145);
				initWisLibSensCor(145, 226, 182, 10);
				this.weaponAttack = 35;
				this.armorDef = 20;
				this.armorMDef = 60;
				this.bonusHP = 400;
				this.bonusMana = 100;
				this.bonusLust = 463;
				this.level = 55;
			}
			this.a = "";
			this.short = "dark slime";
			this.imageName = "googirl";
			this.long = "This slime looks similar to the goo girls from the lake. However, it’s nucleus is the size of an apple and spherical, not to mention it's purple gel coloration. Surprisingly, it seems intelligent enough to even speak so you better watch out for other oddities.";
			// this.long = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 9001, 0, 0, 0);
			this.createBreastRow(3);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.createStatusEffect(StatusEffects.BonusACapacity,9001,0,0,0);
			this.tallness = rand(8) + 70;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.GOO;
			this.skin.setBaseOnly({color:"purple",type:Skin.GOO});
			this.hairColor = "purple";
			this.hairLength = 12 + rand(10);
			this.weaponName = "hands";
			this.weaponVerb="slap";
			this.armorName = "gelatinous skin";
			this.lust = 45;
			this.lustVuln = .75;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.gems = rand(6) + 4;
			this.drop = new ChainedDrop().add(weapons.PIPE,1/10)
					.add(consumables.DSLIMEJ,1/2)
					.elseDrop(useables.GREENGL);
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.LightningVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGooType, 0, 0, 0, 0);
			this.abilities = [
				{ call: gooGalAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_FLUID,TAG_ACID]},
				{ call: gooEngulph, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[]},
				{ call: gooPlay, type: ABILITY_TEASE, range: RANGE_MELEE, tags:[TAG_FLUID]},
				{ call: gooThrow, type: ABILITY_PHYSICAL, range: RANGE_RANGED, tags:[TAG_FLUID,TAG_ACID]},
				{ call: darkslimeMagic, type: ABILITY_MAGIC, range: RANGE_RANGED, tags:[TAG_FLUID,TAG_ACID]},
				{ call: darkslimePoison, type: ABILITY_MAGIC, range: RANGE_RANGED, tags:[TAG_FLUID]}
			]
			checkMonster();
		}
	}
}
