package classes.Scenes.Dungeons.DemonLab 
{
	/**
	 * ...
	 * @author ...
	 */
	 import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Scenes.Dungeons.Demonlab;
	public class ProjectTyrant extends monster
	{
		
		public function ProjectTyrant() 
		{
		this.a = "the ";
			this.short = "Drider-Rider";
			this.long= "Facing you is a creature vaguely resembling a Drider. Easily seventeen feet tall and thirty feet long, the creature turns to face you, six crimson eyes gleaming. Its naked form is built like a tank, masculine, with no genitals to be seen. Twin horns poke through the chitin covering its forehead. It breathes heavily, and as it takes a step, the spikes on its legs clank against the stone floor below. Corruption oozes from this creature in a sickening aura. It holds no weapons, but the massive muscles sloping down the creature’s arms leave little doubt that this creature doesn’t need a weapon to crush its foes. ";
			this.plural = false;
			this.tallness = 104;
			this.horns.count = 4;
			initStrTouSpeInte(575, 400, 190, 130);
			initWisLibSensCor(140, 345, 150, 100);
			this.weaponName = "fists";
			this.weaponVerb = "punch";
			this.weaponAttack = 80;
			this.armorName = "chitin";
			this.armorDef = 101;
			this.armorMDef = 139;
			this.bonusHP = 300;
			this.bonusLust = 200;
			this.lust = 50;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 45;
			this.gems = rand(550) + 175;
			
			this.drop = new WeightedDrop().
					add(UseableLib.D_SCALE,5).
					add(UseableLib.LETHITE,2).
					add(jewelries.POWRRNG,1).
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.ToughHide, 0, 0, 0, 0);
			this.createPerk(PerkLib.Brawler, 0, 0, 0, 0);
			this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			this.createPerk(PerkLib.GoliathII, 0, 0, 0, 0);

			checkMonster();
		}	

		private function lustFromHits():Number {
			return (25 + int(player.effectiveLibido() / 5 + player.effectiveSensitivity() / 5 + player.cor / 5));
		}
		private function CorruptionAura():void {
			outputText("You feel the corrupt aura of this creature seeping into the very air around you. This creature seems to generate corrupt energy just by existing!\n\n");
			player.dynStats("cor", 2, "lus", (lustFromHits() * 2.5));
		}
	private function SlamTrample():void {
			outputText("The hulking frame in front of you charges, fists held high. \n");

			//Miss:
			//Determine if evaded
			if(player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				outputText("Using your talent for evasion, you manage to sidestep the creature's clumsy charge.");
			}
			//("Misdirection"
			else if(player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				outputText("Using your talent for misdirection, you manage to sidestep the creature's clumsy charge.");

			}
			//Determine if cat'ed
			else if(player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				outputText("Using your cat-like flexibility, you manage to bend your spine backwards. Throwing yourself into a sideways flip, you manage to sidestep the creature's clumsy charge.");
			}
			else {
				outputText("You try to dodge, but the creature’s fist is too fast, hitting you square in the chest. You’re sent tumbling back.");
				createStatusEffect(StatusEffects.Attacks, 1 ,0,0,0);
				outputText("As it keeps charging through, a few of the drider’s legs come down onto your prone frame, trampling you. ");
				createStatusEffect(StatusEffects.Attacks, 2 ,0,0,0);
				outputText("\n");
			}
		}
	private function TackleGrapple():void {
		outputText("The Drider-monster charges again. You ready yourself to dodge the meaty fists, but instead, it charges head-on into you, shoulder first. You’re thrown back by the impact, but as you hit the ground, you feel an immense weight press down on you. You are pinned underneath the Drider-beast’s weight, and it begins to crush you! \n\n");
		var damage:Number = ((str + tou) * 1.2) + rand(50);
		player.takePhysicalDamage(damage*1.2, true);
		player.createStatusEffect(StatusEffects.Pounced, 2, 0, 0, 0);
		}
public function TackleGrappleStruggle():void {
			player.removeStatusEffect(StatusEffects.Pounced);
			if ((rand(player.str) > this.str / 2) || player.hasPerk(PerkLib.FluidBody)) TackleGrappleSuccess();
			else TackleGrapple();
			SceneLib.combat.enemyAIImpl();
		}
		public function TackleGrappleWait():void {
			clearOutput();
			player.removeStatusEffect(StatusEffects.Pounced);
			TackleGrappleFail();
			SceneLib.combat.enemyAIImpl();
		}
public function TackleGrappleFail():void {
		outputText("The Drider-thing’s bulk presses down on you, crushing your body. You can feel your bones beginning to crack! \n\n"); 
		outputText(" \n\n");
		var damage:Number = ((str + tou) * 1.2) + rand(50);
		player.takePhysicalDamage(damage*1.2, true);
		var dmg0:Number = 0;
			dmg0 += this.spd * 2;
			dmg0 += eBaseSpeedDamage() * 2;
			dmg0 += this.weaponAttack * 1;
			outputText("As you struggle with the creature, the Incubus on top of it cackles, shooting at your exposed upper body! \n\n"); 
			player.takePhysDamage(dmg0, true);
			player.takePhysDamage(dmg0, true);
			player.takePhysDamage(dmg0, true);
}

public function TackleGrappleSuccess():void {
		outputText("with a roar of effort, you get your [legs] underneath you. The creature’s arms are there to try and grab you, but you pull the other way, slipping underneath the creature’s Spider body. As it looks about in confusion, you slip out from underneath it, striking one of the beast’s legs with your [weapon] as you pass. \n\n"); 
}


public function BlackMortar():void {
		outputText("The demon on top grins, whistling, and you see the unholy mount tense up. A massive glob of black goop is launched from the Drider’s backside like a mortar shell. \n\n"); 
		if ((rand(player.spe) > this.spe / 2)) outputText("You break into a sweat as you throw yourself to the side. You evade the worst of the acidic goop, but a bit still splashes you.");
		var dmg1:Number = this.inte * 0.2;
				dmg1 += eBaseIntelligenceDamage() * 0.1;
				dmg1 = Math.round(dmg1);
				dmg1 = player.takeAcidDamage(dmg1, true);
			else {
				outputText("You gasp as the sticky mess engulfs you, burning like acid on impact. ");
				var dmg1:Number = this.inte * 0.2;
				dmg1 += eBaseIntelligenceDamage() * 0.2;
				dmg1 = Math.round(dmg1);
				dmg1 = player.takeAcidDamage(dmg1, true);
				if (player.hasStatusEffect(StatusEffects.AcidDoT)) player.addStatusValue(StatusEffects.AcidDoT, 1, 1);
				else player.createStatusEffect(StatusEffects.AcidDoT, 5, 10, 0, 0);
				player.buff("Goop Web").addStats( {"spe":-25} ).withText("Goop Web").combatPermanent();
			}
		}
}
override protected function performCombatAction():void {
clearOutput();
CorruptionAura();
var dmg0:Number = 0;
			dmg0 += this.spd * 2;
			dmg0 += eBaseSpeedDamage() * 2;
			dmg0 += this.weaponAttack * 1;
			outputText("The Incubus fires a shot at you! \n\n"); 
			player.takePhysDamage(dmg0, true);
				var choice0:Number = rand(3);
				switch (choice0) {
					case 0:
						SlamTrample();
						break;
					case 1:
						TackleGrapple();
						break;
					case 2:
						BlackMortar();
						break;
				}
		}
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.DemonLab.PrTyrantVictory();
		}
override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.DemonLab.BadEndExperiment();
		}
	}

}