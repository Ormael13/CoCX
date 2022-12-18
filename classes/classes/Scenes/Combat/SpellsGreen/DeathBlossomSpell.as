package classes.Scenes.Combat.SpellsGreen 
{
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreenSpell;
import classes.StatusEffects;

	public class DeathBlossomSpell extends AbstractGreenSpell {
		public function DeathBlossomSpell() 
		{
			super("Death Blossom",
			"Deliver deadly poison and strong aphrodisiac by causing nearby vegetation to bloom corrupted flowers which inflicts their poison each round for 3 rounds. Deals severe tease and poison damage over time intensifying every round by 20%.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_LUSTDMG]);
		baseManaCost = 100;
		}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsDeathBlossom);
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false, false) + " lust poison damage and poison DoT intensifying every round by 20%"
	}
	
	override public function calcCooldown():int {
		return spellWhiteTier2Cooldown();
	}
	
	override protected function usabilityCheck():String {
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		if (!player.hasStatusEffect(StatusEffects.NearbyPlants)) {
			return "Death Blossom require to have plants nearby.";
		}
		
		return "";
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = (combat.teases.teaseBaseLustDamage() * spellModWhite());
		if (player.hasPerk(PerkLib.VegetalAffinity)) baseDamage *= 1.5;
		if (player.hasPerk(PerkLib.GreenMagic)) baseDamage *= 2;
		if (player.hasStatusEffect(StatusEffects.GreenCovenant)) baseDamage *= 2;
		return adjustLustDamage(baseDamage, monster, CAT_SPELL_GREEN, randomize);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You concentrate your desire on the nearby plants causing their flowers to spontaneously bloom in a cloud of corrupted pollen.\n");
			monster.createStatusEffect(StatusEffects.DeathBlossom, 5, 1, 0, 0);
			if (monster.lustVuln != 0) {
				var arve:Number = 1;
				if (player.hasPerk(PerkLib.ArcaneVenom)) arve += stackingArcaneVenom();
				while (arve-->0) doSpellEffect2();
			}
		}
	}
	
	private function doSpellEffect2():void {
		var lustDmg:Number = calcDamage(monster, true, true);
		//Determine if critical tease!
		var crit:Boolean   = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.CriticalPerformance)) {
			if (player.lib <= 100) critChance += player.lib / 5;
			if (player.lib > 100) critChance += 20;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			lustDmg *= 1.75;
		}
		lustDmg = Math.round(monster.lustVuln * lustDmg);
		monster.teased(lustDmg, false);
		if (crit) outputText(" <b>Critical!</b>");
		combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		if (player.hasPerk(PerkLib.VerdantLeech)) {
			if (monster.lustVuln != 0) monster.lustVuln += 0.025;
			HPChange(Math.round(player.maxHP() * 0.05), false);
		}
	}
}
}
