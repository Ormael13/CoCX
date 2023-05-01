package classes.Scenes.Combat.SpellsNecro {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractNecroSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class BoneSpiritSpell extends AbstractNecroSpell {
	public function BoneSpiritSpell() {
		super(
			"Bone spirit",
			"Turn an ordinary set of bones into a vengeance mad apparition that will charge at your target. Upon contact it will explode dealing massive true damage.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING]
		)
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+calcDamage(target, false, false)+" true damage"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsBoneSpirit);
	}
	
	override public function demonBonesCost():int {
		var calcDBC:int = 5;
		if (player.hasPerk(PerkLib.HyperCasting)) calcDBC -= 1;
		if (player.hasStatusEffect(StatusEffects.BonusEffectsNecroSet) && player.statusEffectv3(StatusEffects.BonusEffectsNecroSet) > 0) calcDBC -= 1;
		return calcDBC;
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
			outputText("You wrap your soulforce around the bones and shape them into a horrifying bone wraith sending it flying and laughing madly toward [themonster]. The ghastly apparition explodes upon contact into a hundred sharp bone shards grievously wounding [themonster]. ");
		}
		var damage:Number = calcDamage(monster, true, true);
		consumeBones(demonBonesCost());
		damage = critAndRepeatDamage(display, damage, DamageType.TRUE);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
