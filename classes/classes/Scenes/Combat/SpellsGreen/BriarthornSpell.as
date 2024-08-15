package classes.Scenes.Combat.SpellsGreen {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreenSpell;
import classes.StatusEffects;

public class BriarthornSpell extends AbstractGreenSpell {
	public function BriarthornSpell() {
		super("Briarthorn",
			"While entangling, vines grows sharp thorns that rend the opponent's flesh and deliver a deadly poison that rend vitality. This spell also Inflict heavy bleed and poison damage.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_LUSTDMG, TAG_TIER1]);
		baseManaCost = 40;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsBriarthorn);
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target, false, false)) + " lust poison damage and bleeding DoT"
	}
	
	override public function calcCooldown():int {
		return spellWhiteCooldown();
	}

	override public function calcDuration():int {
		var dura:Number = 6;
		if (player.hasPerk(PerkLib.GreenMagic)) dura *= 2;
		return dura;
	}
	
	override public function isActive():Boolean {
		return monster.hasStatusEffect(StatusEffects.Briarthorn);
	}
	
	override protected function usabilityCheck():String {
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		if (!monster.hasStatusEffect(StatusEffects.EntangledBySpell)) {
			return "Briarthorn require to have the enemy entangled by vines.";
		}
		
		return "";
	}
	
	override public function advance(display:Boolean):void {
		if (player.hasStatusEffect(StatusEffects.Briarthorn)) {
			if (player.statusEffectv1(StatusEffects.Briarthorn) <= 0) {
				player.removeStatusEffect(StatusEffects.Briarthorn);
				if (display) outputText("<b>Briarthorn effect wore off!</b>\n\n");
			} else {
				player.addStatusValue(StatusEffects.Briarthorn, 1, -1);
			}
		}
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = ((scalingBonusIntelligence() + scalingBonusLibido()));
		return adjustLustDamage(baseDamage, monster, CAT_SPELL_GREEN, randomize);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) outputText("You concentrate on the vines causing them to grow vicious thorns that tear through your opponent's flesh delivering a noxious poison.");
		if (monster.lustVuln == 0) {
			if (display) outputText("\nIt has no effect!  Your foe clearly does not experience lust in the same way as you.\n");
			return;
		}
		monster.createStatusEffect(StatusEffects.Briarthorn, calcDuration(), 0, 0, 0);

		var lustDmg:Number = calcDamage(monster, true, true);
		var resultArray:Array = critAndRepeatLust(display, lustDmg, CAT_SPELL_GREEN);
		postLustSpellEffect(resultArray[1]);
		
		if (display) outputText("\n");
	}
	
}
}
