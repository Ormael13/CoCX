/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.Items.*
	
public class AbstractGargoyle extends Monster
{
	public function GargoyleStoneClawAttack():void {
		clearOutput();
		var damage:Number = 0;
		damage += this.str;
		damage += eBaseStrengthDamage() * 0.5;
		damage += this.tou;
		damage += eBaseToughnessDamage() * 0.5;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (this.inte <= 200) critChance += this.inte / 10;
		if (this.inte > 200) critChance += 20;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		player.takeDamage(damage, true);
		outputText(capitalA + short + " slash you with sharp stone claw dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
	}
	public function GargoyleTailSlamAttack():void {
		clearOutput();
		var damage:Number = 0;
		damage += this.str;
		damage += eBaseStrengthDamage() * 0.25;
		damage += this.tou;
		damage += eBaseToughnessDamage() * 0.25;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (this.inte <= 200) critChance += this.inte / 10;
		if (this.inte > 200) critChance += 20;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		player.takeDamage(damage, true);
		createStatusEffect(StatusEffects.AbilityCooldown1, 5, 0, 0, 0)
		outputText(capitalA + short + " slam you with it mace like tail dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (player.findPerk(PerkLib.Resolute) < 0) {
			outputText(" The attack is so devastating you're stunned by it!");
			player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
	}
	public function GargoyleTailCleaveAttack():void {
		clearOutput();
		var damage:Number = 0;
		damage += this.str;
		damage += eBaseStrengthDamage() * 0.25;
		damage += this.tou;
		damage += eBaseToughnessDamage() * 0.25;
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
		player.takeDamage(damage, true);
		createStatusEffect(StatusEffects.AbilityCooldown1, 5, 0, 0, 0)
		outputText(capitalA + short + " swipe the field with it axe-bladed tail, slicing you");
		//if () outputText("r team");jak PC ma 4+ pomocników
		outputText(", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! The attack leaves you bleeding from deep wounds!");
		player.createStatusEffect(StatusEffects.IzmaBleed, 3, 0, 0, 0);
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
	}
	public function GargoyleWingBuffetAttack():void {
		clearOutput();
		var damage:Number = 0;
		damage += this.str / 5;
		damage += this.tou / 5;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (this.inte <= 200) critChance += this.inte / 10;
		if (this.inte > 200) critChance += 20;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		player.takeDamage(damage, true);
		createStatusEffect(StatusEffects.AbilityCooldown2, 4, 0, 0, 0)
		outputText(capitalA + short + " slam you with it mace like tail dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		if (player.findPerk(PerkLib.Resolute) < 0) player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		outputText("\n\n");
	}
	
	public function AbstractGargoyle() 
	{
	}
}
}