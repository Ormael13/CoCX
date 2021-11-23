package classes.Scenes.Combat.SpellsBlack {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class ArcticGaleSpell extends AbstractBlackSpell {
	public var ex:Boolean;
	
	public function ArcticGaleSpell(ex:Boolean = false) {
		super(
				ex ? "Arctic Gale (Ex)" : "Arctic Gale",
				ex ?
						"Devastate the enemy ranks with a blast of wrath-enpowered icy wind sharper then steel blades."
						: "Devastate the enemy ranks with a blast of icy wind sharper then steel blades.",
				TARGET_ENEMY,
				TIMING_INSTANT,
				[TAG_DAMAGING, TAG_ICE, TAG_AOE]
		);
		baseManaCost = 200;
		if (ex) baseWrathCost = 100;
		this.ex = ex;
	}
	
	override public function get buttonName():String {
		return ex ? "ArcticGale(Ex)" : "Arctic Gale";
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false) + " ice damage"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsArcticGale) &&
				(!ex || player.hasPerk(PerkLib.MagesWrathEx));
	}
	
	override public function get currentCooldown():int {
		return ex ?
				player.statusEffectv1(StatusEffects.CooldownSpellArcticGaleEx)
				: player.statusEffectv1(StatusEffects.CooldownSpellArcticGale);
	}
	
	override public function useResources():void {
		super.useResources();
		player.createStatusEffect(
				ex ?
						StatusEffects.CooldownSpellArcticGaleEx
						: StatusEffects.CooldownSpellArcticGale,
				spellBlackCooldown(), 0, 0, 0);
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true):Number {
		var baseDamage:Number = 2 * scalingBonusIntelligence(randomize);
		if (ex) baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.ICE, CAT_SPELL_BLACK, monster);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You wave the signs with your hands and unleash an howling blast of cold magic upon " + monster.a + monster.short + ".\n");
		}
		var damage:Number = calcDamage(monster);
		critAndRepeatDamage(display, damage, DamageType.ICE);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		damage *= omnicasterRepeatCount();
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
