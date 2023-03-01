package classes.Scenes.Combat.SpellsNecro {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractNecroSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class BoneshatterSpell extends AbstractNecroSpell {
	public function BoneshatterSpell() {
		super(
			"Boneshatter",
			"Strike at the target ossature causing it to explode from the inside and causing serious internal damage and weakening its blow. Single target only (does not work on boneless creatures, Monster take 20% strength drain from this effect which stacks).",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING]
		)
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+calcDamage(target, false, false)+" true damage, "+
				"-"+Math.round(100*calcDebuffPower(monster,false))+"% str"
	}
	
	override public function calcCooldown():int {
		var calcC:int = 0;
		calcC += spellGenericCooldown();
		return calcC;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsBoneshatter);
	}
	
	override public function demonBonesCost():int {
		var calcDBC:int = 5;
		if (player.hasPerk(PerkLib.HyperCasting)) calcDBC -= 1;
		if (player.hasStatusEffect(StatusEffects.BonusEffectsNecroSet) && player.statusEffectv3(StatusEffects.BonusEffectsNecroSet) > 0) calcDBC -= 1;
		return calcDBC;
	}
	
	override protected function usabilityCheck():String {
		if (monster.hasPerk(PerkLib.EnemyConstructType)
				|| monster.hasPerk(PerkLib.EnemyElementalType)
				|| monster.hasPerk(PerkLib.EnemyGhostType)
				|| monster.hasPerk(PerkLib.EnemyGooType)
				|| monster.hasPerk(PerkLib.EnemyPlantType)) {
			return "Your enemy lacks bones.";
		}
		if (monster.plural
				|| monster.hasPerk(PerkLib.Enemy300Type)
				|| monster.hasPerk(PerkLib.EnemyGroupType)
				|| monster.hasPerk(PerkLib.EnemyLargeGroupType)) {
			return "You can only strike one target.";
		}
		return super.usabilityCheck();
	}
	
	public function calcDebuffPower(monster:Monster, randomize:Boolean=true):Number {
		var shatterIt:Number = 0.2;
		shatterIt *= boneSoulBonus(demonBonesCost());
		return shatterIt;
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean=true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var damage:Number = adjustSpellDamage(
				scalingBonusIntelligence()*3,
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
			outputText("You channel your powers in [themonster] bone structure stressing it and forcing the bones to snap. [Themonster] cough blood you wreck [monster his] from the inside. ");
		}
		var damage:Number = calcDamage(monster, true, true);
		var shatterIt:Number = calcDebuffPower(monster);
		consumeBones(demonBonesCost());
		damage = critAndRepeatDamage(display, damage, DamageType.TRUE);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if (monster.hasStatusEffect(StatusEffects.Boneshatter)) {
			var currentShatter:Number = monster.statusEffectv1(StatusEffects.Boneshatter);
			if (currentShatter < 0.9) {
				if (currentShatter - shatterIt > 0.9) shatterIt = 0.9-currentShatter;
				monster.addStatusValue(StatusEffects.Boneshatter, 1, shatterIt);
				monster.buff("Boneshatter").addStats({str:-(Math.round(shatterIt * monster.str))}).withText("Boneshatter").combatPermanent();
			}
		} else {
			monster.createStatusEffect(StatusEffects.Boneshatter, shatterIt, 0, 0, 0);
			monster.buff("Boneshatter").addStats({str:-(Math.round(shatterIt * monster.str))}).withText("Boneshatter").combatPermanent();
		}
	}
}
}
