/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class Siegweird extends Monster
	{
		public var spellCostCharge:int = 6;
		
		public function siegweirdMagicWeapon():void {
			outputText("Siegweird passes his armored paw over his greatsword, which begins to flash like a torchlight. This is gonna hurt!");
			createStatusEffect(StatusEffects.ChargeWeapon, 40, 0, 0, 0);
			this.weaponAttack += (40 + (40 * (1 + player.newGamePlusMod)));
			mana -= spellCostCharge;
		}
		
		private function siegweirdSmash():void {
			var damage:Number = 0;
			damage += eBaseStrengthDamage();
			if (this.weaponAttack < 51) damage *= (1 + (this.weaponAttack * 0.03));
			else if (this.weaponAttack >= 51 && this.weaponAttack < 101) damage *= (2.5 + ((this.weaponAttack - 50) * 0.025));
			else if (this.weaponAttack >= 101 && this.weaponAttack < 151) damage *= (3.75 + ((this.weaponAttack - 100) * 0.02));
			else if (this.weaponAttack >= 151 && this.weaponAttack < 201) damage *= (4.75 + ((this.weaponAttack - 150) * 0.015));
			else damage *= (5.5 + ((this.weaponAttack - 200) * 0.01));
			if (hasStatusEffect(StatusEffects.BerzerkingSiegweird)) damage *= 2;
			damage = Math.round(damage);
			outputText("Siegweird smashes his weapon at you! The impact makes you reel for ");
			if (hasStatusEffect(StatusEffects.ChargeWeapon)) damage = player.takeFireDamage(damage, true);
			else damage = player.takePhysDamage(damage, true);
			statScreenRefresh();
			outputText(" damage!\n");
		}
		
		private function siegweirdBerserk():void {
			outputText("Siegweird suddenly screams a war cry, becoming bigger, tougher and more intimidating by the second!\n\n");
			createStatusEffect(StatusEffects.BerzerkingSiegweird,50,0,0,0);
		}
		
		private function siegweirdHeal():void {
			outputText("Siegweird swiftly casts a spell and you can see his wounds periodically closing.\n\n");
			createStatusEffect(StatusEffects.HealingSiegweird,10,0,0,0);
		}
		
		override protected function performCombatAction():void {
			var choice:Number = rand(3);
			if (hasStatusEffect(StatusEffects.HealingSiegweird)) {
				if (statusEffectv1(StatusEffects.HealingSiegweird) > 1) addStatusValue(StatusEffects.HealingSiegweird, 1, -1);
				else removeStatusEffect(StatusEffects.HealingSiegweird);
			}
			if ((this.lust > this.maxLust() * 0.5) || (this.HP < this.maxHP() * 0.5) && !hasStatusEffect(StatusEffects.BerzerkingSiegweird)) siegweirdBerserk();
			switch (choice) {
				case 0:
					siegweirdSmash();
					break;
				case 1:
					if ((this.HP < this.maxHP() * 0.75) && !hasStatusEffect(StatusEffects.HealingSiegweird)) siegweirdHeal();
					else siegweirdSmash();
					break;
				case 2:
					if (!hasStatusEffect(StatusEffects.ChargeWeapon)) siegweirdMagicWeapon();
					else siegweirdSmash();
					break;
				default:
					siegweirdSmash();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			cleanupAfterCombat();
			SceneLib.siegweirdFollower.siegweirdFirstEncounterPostFightAnotherFightWon();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			cleanupAfterCombat();
			SceneLib.siegweirdFollower.siegweirdFirstEncounterPostFightAnotherFightLost();
		}
		
		public function Siegweird() 
		{
			this.a = "";
			this.short = "Siegweird of Catelyna";
			this.imageName = "siegweird";
			this.long = "You are fighting Siegweird of Catelyna, a somewhat goofy albeith determined paladin of Marae. He wield his sword with both hands, his onion shaped spiked shield on his back. His Onion shaped Armor hides most of his features though you know him to be a white bear morph.";
			// this.plural = false;
			this.createCock(7.5,1.8);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 1;
			this.hoursSinceCum = 1000;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 5*12+6;
			this.skin.growFur({color:"tawny"});
			this.hairColor = "brown";
			this.hairLength = 5;
			initStrTouSpeInte(275, 255, 190, 180);
			initWisLibSensCor(180, 75, 75, 0);
			this.weaponName = "greatsword";
			this.weaponVerb="slash";
			this.weaponAttack = 40;
			this.armorName = "onion armor";
			this.armorDef = 200;
			this.armorMDef = 200;
			this.bonusHP = 200;
			this.bonusLust = 40;
			this.lust = 30;
			this.lustVuln = 0.75;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 64;
			this.gems = rand(25) + 138;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}