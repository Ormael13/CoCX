package classes.Scenes.Combat.SpellsDivine {
import classes.Items.ShieldLib;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractDivineSpell;
import classes.StatusEffects;

public class AegisSpell extends AbstractDivineSpell {
	public function AegisSpell() {
		super(
			"Aegis",
			"Increase block chance by 1 to 10%, tripled if using a staff and no shield. (Based on spell buff and intelligence).",
			TARGET_SELF,
			TIMING_LASTING,
			[TAG_BUFF]
		);
		baseManaCost = 500;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsAegis)
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "Block chance +"+calcMagnitude()+"% for "+numberOfThings(calcDuration(),"round");
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.Aegis);
	}
	
	override public function calcDuration():int {
		var AegisDuration:int = 6;
		AegisDuration += combat.magic.perkRelatedDurationBoosting();
		return AegisDuration;
	}
	
	public function calcMagnitude():Number {
		var aegismagnitude:Number = 0;
		if (spellModWhite() > 5) aegismagnitude += 5;
		else aegismagnitude += spellModWhite();
		if (player.inte / 50 > 5) aegismagnitude += 5;
		else aegismagnitude += player.inte / 25;
		if (player.hasPerk(PerkLib.DefensiveStaffChanneling) && (player.weapon.isStaffType() || player.weaponOff.isStaffType() || player.weapon.isWandType() || player.weaponOff.isWandType())) aegismagnitude *= 1.2;
		if ((player.isUsingStaff() || player.isUsingWand()) && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) aegismagnitude *= 3;
		return Math.round(aegismagnitude);
	}
	
	override public function advance(display:Boolean):void {
		if (player.statusEffectv2(StatusEffects.Aegis) <= 0) {
			player.removeStatusEffect(StatusEffects.Aegis);
		} else {
			player.addStatusValue(StatusEffects.Aegis, 2, -1);
		}
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You call on divine protection in order to shield yourself against attacks."+(!player.shield.isNothing ? " On your off-hand manifests a shield made of pure light, which will help deflect blows.":" Your shield begins to glow with white protective light, strengthening it as benevolent powers guide your hands, increasing your ability to block.")+"\n\n");
		}
		player.createStatusEffect(StatusEffects.Aegis,calcMagnitude(),calcDuration(),0,0);
	}
}
}
