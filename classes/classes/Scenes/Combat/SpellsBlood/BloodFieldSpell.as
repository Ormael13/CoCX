package classes.Scenes.Combat.SpellsBlood {
import classes.EngineCore;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBloodSpell;
import classes.StatusEffects;

public class BloodFieldSpell extends AbstractBloodSpell {
	public function BloodFieldSpell() {
		super(
			"Blood Field",
			"Blood Field will coat the ground in tacky-wet blood infused with your mana. The mass will slow down enemies, drain their health and heal the caster.",
			TARGET_ENEMY,
			TIMING_LASTING,
			[TAG_DEBUFF]
		);
		baseHpCost = 600;
		inflictBleed = false;
	}
	
	override public function describeEffectVs(target:Monster):String {
		return ""+calcPower()+" hp leech for "+numberOfThings(calcDuration(),"round");
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsBloodField);
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.BloodField);
	}
	
	override public function calcDuration():int {
		var calcD:int = 3;
		if (player.hasPerk(PerkLib.BloodDemonIntelligence)) calcD *= 2;
		return calcD;
	}
	
	public function calcPower():Number {
		return Math.round(player.maxOverHP() * 0.01);
	}
	
	override public function advance(display:Boolean):void {
		player.addStatusValue(StatusEffects.BloodField, 1, -1);
		if (player.statusEffectv1(StatusEffects.BloodField) <= 0) player.removeStatusEffect(StatusEffects.BloodField);
		if (!player.hasStatusEffect(StatusEffects.MonsterDig) && !monster.isFlying()) {
			var bloodfield:Number = monster.statusEffectv2(StatusEffects.BloodField);
			if (monster.plural) bloodfield *= 5;
			if (monster.hasPerk(PerkLib.EnemyLargeGroupType)) bloodfield *= 5;
			bloodfield = combat.doDamage(bloodfield);
			EngineCore.HPChange(bloodfield, false);
		}
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + (player.HP < player.maxOverHP() ? "wounds":"skin pores") + ". Blood starts to gather before your chest, coalescing into a crimson sphere. ");
			outputText("It roils as you concentrate on it before aim the orb at the ground. Bursting on impact, the blood forms tendrils, spreading its mass across the battlefield. As you watch, small spines of crystalized blood form on the surface. When you touch them, they bend, but your enem" + (monster.plural ? "es":"y") + " won't be as lucky.\n\n");
		}
		player.createStatusEffect(StatusEffects.BloodField,calcDuration(),calcPower(),0,0);
		if (!monster.isFlying()) {
			monster.buff("BloodThorns")
					.addStats({spe:-20})
					.withText("Blood Thorns")
					.combatTemporary(calcDuration());
		}
	}
}
}
