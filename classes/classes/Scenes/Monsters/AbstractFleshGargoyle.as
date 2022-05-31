/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	
public class AbstractFleshGargoyle extends Monster {
	
	public function FleshGargoyleClawAttack():void {
		clearOutput();
		var damage:Number = 0;
		damage += this.str * 0.8;
		damage += eBaseStrengthDamage() * 0.4;
		damage += this.tou * 0.8;
		damage += eBaseToughnessDamage() * 0.4;
		if (hasStatusEffect(StatusEffects.Provoke)) damage *= statusEffectv2(StatusEffects.Provoke);
		var crit:Boolean = false;
		var critChance:int = 5;
		if (this.inte <= 200) critChance += this.inte / 10;
		if (this.inte > 200) critChance += 20;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		outputText(capitalA + short + " slash you with sharp stone-like claw dealing ");
		player.takePhysDamage(damage, true);
		outputText(" damage!");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
	}
	public function FleshGargoyleTailSlamAttack():void {
		clearOutput();
		createStatusEffect(StatusEffects.AbilityCooldown1, 4, 0, 0, 0);
		var damage:Number = 0;
		damage += this.str * 0.8;
		damage += eBaseStrengthDamage() * 0.2;
		damage += this.tou * 0.8;
		damage += eBaseToughnessDamage() * 0.2;
		if (hasStatusEffect(StatusEffects.Provoke)) {
			damage *= statusEffectv2(StatusEffects.Provoke);
			addStatusValue(StatusEffects.AbilityCooldown1, 1, -1);
		}
		var crit:Boolean = false;
		var critChance:int = 5;
		if (this.inte <= 200) critChance += this.inte / 10;
		if (this.inte > 200) critChance += 20;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		outputText(capitalA + short + " hammers " + pronoun1 + " tail down on you attempting to crush you under its mace like tip. It hurt a lot, but you hold your ground wincing against the blow. ");
		player.takePhysDamage(damage, true);
		if (!player.hasPerk(PerkLib.Resolute)) {
			outputText(" You recoil, stunned by the massive impact and take ");
			player.takePhysDamage(Math.round(damage * 0.1), true);
			outputText(" damage!");
			player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
	}
	public function FleshGargoyleTailCleaveAttack():void {
		clearOutput();
		createStatusEffect(StatusEffects.AbilityCooldown2, 4, 0, 0, 0);
		var damage:Number = 0;
		damage += this.str * 0.8;
		damage += eBaseStrengthDamage() * 0.2;
		damage += this.tou * 0.8;
		damage += eBaseToughnessDamage() * 0.2;
		if (hasStatusEffect(StatusEffects.Provoke)) {
			damage *= statusEffectv2(StatusEffects.Provoke);
			addStatusValue(StatusEffects.AbilityCooldown2, 1, -1);
		}
		//if () damage *= 5;jak PC ma 4+ pomocników
		var crit:Boolean = false;
		var critChance:int = 5;
		if (this.inte <= 200) critChance += this.inte / 10;
		if (this.inte > 200) critChance += 20;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		outputText(capitalA + short + " swipe the field with it axe-bladed tail, slicing you");
		//if () outputText("r team");jak PC ma 4+ pomocników
		outputText(", dealing ");
		player.takePhysDamage(damage, true);
		outputText(" damage! The attack leaves you bleeding from deep wounds!");
		player.createStatusEffect(StatusEffects.IzmaBleed, 3, 0, 0, 0);
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
	}
	public function FleshGargoyleWingBuffetAttack():void {
		clearOutput();
		createStatusEffect(StatusEffects.AbilityCooldown3, 3, 0, 0, 0);
		var damage:Number = 0;
		damage += this.str * 0.16;
		damage += this.tou * 0.16;
		if (hasStatusEffect(StatusEffects.Provoke)) {
			damage *= statusEffectv2(StatusEffects.Provoke);
			addStatusValue(StatusEffects.AbilityCooldown3, 1, -1);
		}
		var crit:Boolean = false;
		var critChance:int = 5;
		if (this.inte <= 200) critChance += this.inte / 10;
		if (this.inte > 200) critChance += 20;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		outputText(capitalA + short + " flaps " + pronoun1 + " massive stone-like wings at you trying to knock you down. You’re thrown to the ground. ");
		player.takePhysDamage(damage, true);
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		if (!player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		if (player.hasPerk(PerkLib.Resolute)) outputText(" You’re thankfully to resilient to be stunned by such attacks and remain standing.");
		outputText("\n\n");
	}
	
	public function AbstractFleshGargoyle() 
	{
		createPerk(PerkLib.Resolute, 0, 0, 0, 0);
		createPerk(PerkLib.Sentience, 0, 0, 0, 0);
		createPerk(PerkLib.EnemyFleshConstructType, 0, 0, 0, 0);
		createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
		createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
		createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
		createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
		createPerk(PerkLib.TankI, 0, 0, 0, 0);
	}
}
}