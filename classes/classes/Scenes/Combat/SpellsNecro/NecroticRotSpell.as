package classes.Scenes.Combat.SpellsNecro {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractNecroSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class NecroticRotSpell extends AbstractNecroSpell {
	public function NecroticRotSpell() {
		super(
			"Necrotic Rot",
			"Deals damage and cause the opponent wounds to fester and worsen increasing damage taken from physical attacks by 25%. This effect stacks.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING]
		)
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+calcDamage(target, false, false)+" true damage"
	}
	
	override public function calcCooldown():int {
		return spellBlackCooldown();
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsNecroticRot);
	}
	
	override public function demonBonesCost():int {
		var calcDBC:int = 5;
		if (player.hasPerk(PerkLib.HyperCasting)) calcDBC -= 1;
		if (player.hasStatusEffect(StatusEffects.BonusEffectsNecroSet) && player.statusEffectv3(StatusEffects.BonusEffectsNecroSet) > 0) calcDBC -= 1;
		return calcDBC;
	}
	
	override protected function usabilityCheck():String {
		if (monster.hasPerk(PerkLib.EnemyElementalType)
				|| monster.hasPerk(PerkLib.EnemyGhostType)) {
			return "Your enemy lacks physical body.";
		}
		if (monster.plural
				|| monster.hasPerk(PerkLib.Enemy300Type)
				|| monster.hasPerk(PerkLib.EnemyGroupType)
				|| monster.hasPerk(PerkLib.EnemyLargeGroupType)) {
			return "You can only strike one target.";
		}
		return super.usabilityCheck();
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean=true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var damage:Number = adjustSpellDamage(
				scalingBonusIntelligence()*2,
				DamageType.TRUE,
				CAT_SPELL_NECRO,
				monster,
                true,
                casting
		);
		if (player.hasPerk(PerkLib.Necromancy)) damage *= 1.5;
		damage *= boneSoulBonus(demonBonesCost());
		return damage;
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You curse [themonster] with rot causing wounds old and new to open wide with increased deadliness as [monster his] flesh festers! ");
		}
		var damage:Number = calcDamage(monster, true, true);
		consumeBones(demonBonesCost());
		damage = critAndRepeatDamage(display, damage, DamageType.TRUE);
		checkAchievementDamage(damage);
		if (monster.hasStatusEffect(StatusEffects.NecroticRot)) monster.addStatusValue(StatusEffects.NecroticRot, 1, 1);
		else monster.createStatusEffect(StatusEffects.NecroticRot, 1, 0, 0, 0);
	}
}
}
