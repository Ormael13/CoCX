/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class DisplacerBeast extends Monster
	{	
		public function moveDisplacerBeastPhaseStrike():void {
			outputText("The displacer beast blinks out and appears right behind you as it begins mauling you with its claws.");
			outputText("\n\nThe displacer beast claws you! ");
			phasestrikeDmg();
			outputText("\n\nThe displacer beast claws you! ");
			phasestrikeDmg();
			outputText("\n\nThe displacer beast claws you! ");
			phasestrikeDmg();
			outputText("\n\nThe displacer beast claws you! ");
			phasestrikeDmg();
		}
		private function phasestrikeDmg():void {
			var damage:Number = 0;
			damage += eBaseStrengthDamage();
			damage += this.weaponAttack;
			damage += rand(str);
			damage += rand(weaponAttack);
			damage += 1.2;
			damage = Math.round(damage);
			damage = player.takePhysDamage(damage, true);
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.displacerbeastScene.displacerBeastVictory();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.EbonLabyrinthB)) SceneLib.dungeons.ebonlabyrinth.defeatedByDisplacerBeast();
			else {
				if (flags[kFLAGS.DISPLACER_BEAST_WINS] < 1) flags[kFLAGS.DISPLACER_BEAST_WINS] = 1;
				SceneLib.displacerbeastScene.displacerBeastDefeat();
			}
		}
		
		override public function get long():String {
			var str:String = "";
			str += "This strange cat girl has two pairs of arms ending with clawed paws. From her back grows two long tentacles similar to that of a calamari. She growls aggressively at you like a feral beast and despite the obvious clothes she wears, she might as well be one.";
			if (game.flags[kFLAGS.DISPLACER_BEAST_WINS] >= 1) str += " She’s clearly starved and wants your milk!";
			return str;
		}
		
		public function DisplacerBeast() 
		{
			if (player.hasStatusEffect(StatusEffects.EbonLabyrinthB)) {
				if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 250) {
					initStrTouSpeInte(217, 247, 360, 126);
					initWisLibSensCor(126, 220, 110, 30);
					this.weaponAttack = 70;
					this.armorDef = 55;
					this.armorMDef = 55;
					this.bonusHP = 600;
					this.bonusLust = 404;
					this.level = 80;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 200) {
					initStrTouSpeInte(206, 226, 330, 116);
					initWisLibSensCor(116, 200, 100, 30);
					this.weaponAttack = 64;
					this.armorDef = 52;
					this.armorMDef = 52;
					this.bonusHP = 500;
					this.bonusLust = 372;
					this.level = 76;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 150) {
					initStrTouSpeInte(195, 205, 300, 106);
					initWisLibSensCor(06, 180, 90, 30);
					this.weaponAttack = 58;
					this.armorDef = 49;
					this.armorMDef = 49;
					this.bonusHP = 400;
					this.bonusLust = 340;
					this.level = 72;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 100) {
					initStrTouSpeInte(184, 184, 270, 96);
					initWisLibSensCor(96, 160, 80, 30);
					this.weaponAttack = 52;
					this.armorDef = 46;
					this.armorMDef = 46;
					this.bonusHP = 300;
					this.bonusLust = 308;
					this.level = 68;
				}
				else if (player.statusEffectv1(StatusEffects.EbonLabyrinthB) > 50) {
					initStrTouSpeInte(173, 173, 240, 86);
					initWisLibSensCor(86, 140, 70, 30);
					this.weaponAttack = 46;
					this.armorDef = 43;
					this.armorMDef = 43;
					this.bonusHP = 200;
					this.bonusLust = 274;
					this.level = 64;
				}
				else {
					initStrTouSpeInte(152, 152, 210, 76);
					initWisLibSensCor(76, 120, 60, 30);
					this.weaponAttack = 40;
					this.armorDef = 40;
					this.armorMDef = 40;
					this.bonusHP = 100;
					this.bonusLust = 240;
					this.level = 60;
				}
			}
			else {
				initStrTouSpeInte(152, 152, 210, 76);
				initWisLibSensCor(76, 120, 60, 30);
				this.weaponAttack = 40;
				this.armorDef = 40;
				this.armorMDef = 40;
				this.bonusHP = 100;
				this.bonusLust = 240;
				this.level = 60;
			}
			this.a = "the ";
			this.short = "displacer beast";
			this.imageName = "displacer beast";
			this.long = "";
			this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE + 2;
			this.skinTone = "";
			this.hairColor = "";
			this.hairLength = 9;
			this.weaponName = "claws";
			this.weaponVerb= "slash";
			this.armorName = "fur";
			this.wrath = 130;
			this.lustVuln = .35;
			this.lust = 30;
			this.gems = rand(20) + 70;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.drop = new ChainedDrop().
					add(useables.EBONBLO,1/20).
					add(consumables.D_FRUIT,0.7);
			this.abilities = [
				{ call: moveDisplacerBeastPhaseStrike, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY] },
			]
			this.createStatusEffect(StatusEffects.EvasiveTeleport, 190, 0, 0, 0);
			checkMonster();
		}
	}
}