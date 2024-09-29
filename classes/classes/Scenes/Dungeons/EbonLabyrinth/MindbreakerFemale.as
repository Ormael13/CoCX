/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.EbonLabyrinth 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class MindbreakerFemale extends Monster
	{
		override public function combatStatusesUpdateWhenBound():void{
			tentacleBindUpdateWhenBound();
		}

		override public function playerBoundStruggle():Boolean{
			return tentacleBindStruggle();
		}

		override public function playerBoundWait():Boolean{
			return tentacleBindWait();
		}

		private function mindbreakerBlackout():void {
			outputText("\"<i>All of this knowledge of yours is utterly useless. You might as well forget everything!</i>\"\n\n");
			outputText("As the Mindbreaker says this she points her finger at you for a spell. As you try to use powers you realize you no longer know how to use any of your magic or abilities!\n\n");
			player.createStatusEffect(StatusEffects.Blackout,5,0,0,0);
		}

		private function mindbreakerMindTrust():void {
			outputText("The mindbreaker’s third eye opens and glows green as you feel your consciousness being viciously impaled by her mental powers. ");
			var damage:Number = eBaseIntelligenceDamage() * 1.5;
			damage += eBaseWisdomDamage() * 0.25;
			damage = Math.round(damage);
			damage = player.takePsychicDamage(damage, true);
		}

		private function mindbreakerMindBreak():void {
			outputText("As she maintains the grapple you can feel her tentacle hair playing with your brain, your mind slowly turning to mush. You ought to stop her before she breaks you!");
			if (player.buff("Mind Break").isPresent()) {
				player.buff("Mind Break").addStats( {"int": -25} ).withText("Mind Break").combatPermanent();
				if (player.inte < 50) {
					if (player.hasVagina()) {
						if (player.intStat.train.value >= 50) player.intStat.train.value -= 50;
						else if (player.intStat.core.value >= 50) player.intStat.core.value -= 50;
						else player.intStat.train.value = 0;
					}
					SceneLib.dungeons.ebonlabyrinth.mindbreakerScene.defeatedBy();
				}
			}
			else player.buff("Mind Break").addStats( {"int":-25} ).withText("Mind Break").combatPermanent();
		}

		private function mindbreakerGrapple():void {
			outputText("The mindbreaker attempts to embrace you and insert her tentacle into your head! ");
			if(player.getEvasionRoll()) outputText("You barely manage to evade her embrace!");
			else {
				outputText("Your attempt to evade was unsuccesfull.");
				if (!player.hasStatusEffect(StatusEffects.PlayerBoundPhysical)) player.createStatusEffect(StatusEffects.PlayerBoundPhysical, 0, 0, 0, 0);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (player.hasStatusEffect(StatusEffects.PlayerBoundPhysical)) mindbreakerMindBreak();
			else switch(rand(3)) {
                case 0:
                    mindbreakerGrapple();
                    break;
                case 1:
                    mindbreakerMindTrust();
                    break;
                case 2:
                    if (player.hasStatusEffect(StatusEffects.Blackout)) mindbreakerMindTrust();
					else mindbreakerBlackout();
                    break;
            }
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.mindbreakerScene.defeatedBy();
		}
		
		public function MindbreakerFemale() 
		{
			//scaled from 65 now, reduced base stats to compensate
			var mod:int = SceneLib.dungeons.ebonlabyrinth.enemyLevelMod;
            initStrTouSpeInte(32 + 29*mod, 99 + 11*mod, 126 + 32*mod, 270 + 40*mod);
            initWisLibSensCor(112 + 21*mod, 160 + 30*mod, 30 + 40*mod, 100);
            this.armorDef = 1 + 1*mod;
            this.armorMDef = 1 + 1*mod;
            this.bonusHP = mod == 0 ? 0 : 100*(mod-1);
            this.bonusLust = 255 + 75*mod;
            this.level = 60 + 5*mod; //starts from 65 due to EL levelMod calculations;
            this.gems = mod > 20 ? 0 : Math.floor((700 + rand(100)) * Math.exp(0.3*mod));
            this.additionalXP = mod > 20 ? 0 : Math.floor(1000 * Math.exp(0.3*mod));
            
			this.a = "the ";
			this.short = "mindbreaker";
			this.imageName = "mindbreaker";
			this.long = "This woman with tentacle hair and a third eye is a mindbreaker. You keep watch for her dangerous mental power and tentacles, for these creatures are rumored to insert themselves into the heads of their victims. She moves slowly, like a predator waiting for the chance to pounce.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 10*12+10;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_NOTICEABLE + 1;
			this.lowerBody = LowerBody.GAZER;
			this.faceType = Face.ANIMAL_TOOTHS;
			this.bodyColor = "light grey";
			this.hairColor = "black";
			this.hairLength = 16;
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.weaponAttack = 5;
			this.armorName = "skin";
			this.lustVuln = .75;
			this.lust = 30;
			this.drop = new WeightedDrop(consumables.MADMENK, 1);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}