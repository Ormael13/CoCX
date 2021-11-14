package classes.Scenes.Combat.SpellsWhite {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.Scenes.Combat.DamageType;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.StatusEffects;

public class PyreBurstSpell extends AbstractWhiteSpell {
	private var ex:Boolean;
	public function PyreBurstSpell(ex:Boolean=false) {
		super(
				ex ? "Pyre Burst(Ex)" : "Pyre Burst",
				ex ?
						"Teach your foes a lesson with the strength of a wrath-empowered firestorm."
						: "Teach your foes a lesson with the strength of a firestorm.",
				TARGET_ENEMY,
				[TAG_DAMAGING]
		);
		baseManaCost = 200;
		baseWrathCost = ex ? 100 : 0;
		this.ex = ex;
	}
	
	
	override public function describeEffectVs(target:Monster):String {
		return ""+calcDamage(target)+" fire damage"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsPyreBurst) &&
				(!ex || player.hasPerk(PerkLib.MagesWrathEx))
	}
	
	override public function get currentCooldown():int {
		return ex ?
				player.statusEffectv1(StatusEffects.CooldownSpellPyreBurst)
				: player.statusEffectv1(StatusEffects.CooldownSpellPyreBurstEx);
	}
	
	override protected function useResources():void {
		super.useResources(); // mana is used in AbstractSpell
		player.createStatusEffect(
				ex ?
						StatusEffects.CooldownSpellPyreBurstEx
						: StatusEffects.CooldownSpellPyreBurst,
				spellWhiteCooldown(),0,0,0
		);
	}
	
	/**
	 * Calculate real (or theoretic) damage dealt by this spell
	 * @param monster Target, or null if no target (ex. for description outside combat)
	 * @return {Number} Damage dealt by this spell
	 */
	public function calcDamage(monster:Monster):Number {
		var baseDamage:Number = 2*scalingBonusIntelligence();
		if (ex) baseDamage *= 2;
		if (monster != null && monster.plural) baseDamage *= 5;
		return adjustSpellDamage(baseDamage, DamageType.FIRE, SPELL_WHITE, monster);
	}
	
	override protected function doSpellEffect():void {
		if (monster is Lethice && (monster as Lethice).fightPhase == 2) {
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!")
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
		} else {
			outputText("You wave the signs with your hands before striking the grounds causing an expending wave of flames to wash over " + monster.a + monster.short + ".\n");
		}
		var damage:Number = calcDamage(monster);
		critAndRepeatDamage(damage, DamageType.FIRE);
		outputText("\n\n");
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
