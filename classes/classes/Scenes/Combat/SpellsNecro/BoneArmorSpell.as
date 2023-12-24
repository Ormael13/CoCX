package classes.Scenes.Combat.SpellsNecro {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractNecroSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class BoneArmorSpell extends AbstractNecroSpell {
	public function BoneArmorSpell() {
		super(
			"Bone armor",
			"Animate bones to create an impenetrable shield lasting 5 rounds and reducing all damage taken by 50%.",
			TARGET_SELF,
			TIMING_LASTING,
			[TAG_BUFF]
		)
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "50% protection for "+numberOfThings(calcDuration(),"round");
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsBoneArmor);
	}
	
	override public function demonBonesCost():int {
		var calcDBC:int = 10;
		if (player.hasPerk(PerkLib.HyperCasting)) calcDBC -= 2;
		if (player.hasStatusEffect(StatusEffects.BonusEffectsNecroSet) && player.statusEffectv3(StatusEffects.BonusEffectsNecroSet) > 0) calcDBC -= 2;
		return calcDBC;
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.BoneArmor);
	}
	
	override public function calcDuration():int {
		var duration:Number = 5;
		duration *= boneSoulBonus(demonBonesCost());
		return Math.floor(duration);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You animate a set of bones to fly around you, deflecting incoming attacks.\n\n");
		}
		var dura:int = calcDuration();
		consumeBones(demonBonesCost());
		player.createStatusEffect(StatusEffects.BoneArmor,dura,0,0,0);
	}
}
}
