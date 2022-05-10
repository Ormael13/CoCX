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
            for (var i:int = 1; i < 4; ++i) {
                outputText("\n\nThe displacer beast claws you! ");
                phasestrikeDmg();
            }
		}
		private function phasestrikeDmg():void {
			var damage:Number = 0;
			damage += eBaseStrengthDamage();
			damage += this.weaponAttack;
			damage += rand(str);
			damage += rand(weaponAttack);
			damage += 1.2;
			damage = Math.round(damage);
			player.takePhysDamage(damage, true);
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.displacerbeastScene.displacerBeastVictory();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
            if (inDungeon) inDungeon = false; //EL check
            if (flags[kFLAGS.DISPLACER_BEAST_WINS] < 1) flags[kFLAGS.DISPLACER_BEAST_WINS] = 1;
			SceneLib.displacerbeastScene.displacerBeastDefeat();
		}
		
		override public function get long():String {
			var str:String = "";
			str += "This strange cat girl has two pairs of arms ending with clawed paws. From her back grows two long tentacles similar to that of a calamari. She growls aggressively at you like a feral beast and despite the obvious clothes she wears, she might as well be one.";
			if (game.flags[kFLAGS.DISPLACER_BEAST_WINS] >= 1) str += " She’s clearly starved and wants your milk!";
			return str;
		}
		
		public function DisplacerBeast() 
		{
			if (inDungeon) { //EL check
                var mod:int = SceneLib.dungeons.ebonlabyrinth.enemyLevelMod;
                initStrTouSpeInte(162 + 11*mod, 142 + 21*mod, 210 + 30*mod, 76 + 10*mod);
                initWisLibSensCor(76 + 10*mod, 120 + 20*mod, 60 + 10*mod, 30);
                this.weaponAttack = 40 + 6*mod;
                this.armorDef = 40 + 3*mod;
                this.armorMDef = 40 + 3*mod;
                this.bonusHP = 100 + 50*mod;
                this.bonusLust = 240 + 34*mod;
                this.level = 60 + 5*mod;
                this.gems = int((120 + rand(60)) * Math.exp(0.3*mod));
                this.additionalXP = int(800 * Math.exp(0.3*mod));
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
			    this.gems = rand(20) + 80;
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