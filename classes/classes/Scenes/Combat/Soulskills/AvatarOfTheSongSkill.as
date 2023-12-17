package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Scenes.Combat.CombatAbilities;
import classes.PerkLib;

public class AvatarOfTheSongSkill extends AbstractSoulSkill {
    public function AvatarOfTheSongSkill() {
        super(
            "Avatar Of The Song",
            "Doublecast Charged Weapon and Might. Casts Blind if Charged Weapon is already active. Casts Heal if Might is already active.",
            TARGET_SELF,
            TIMING_INSTANT,
            [TAG_BUFF, TAG_HEALING],
            PerkLib.MageWarden,
			false
        )
		baseSFCost = 200;
    }

	override public function get buttonName():String {
		return "AvatarOfTheSong";
	}

	override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

		if (player.hasStatusEffect(StatusEffects.OniRampage) || player.wrath > player.maxSafeWrathMagicalAbilities()) {
			return "You are too angry to think straight. Smash your puny opponents first and think later.";
		}

        return "";
    }

	override public function sfCost():int {
		return baseSFCost;
	}

    override public function doEffect(display:Boolean = true):void {		
		if (display) outputText("You feel the song of the mother tree all around you. Using your staff as a beacon, you unify it with the flow of magic through your body,");
		if (!player.statStore.hasBuff("Might")) {
			if (display) outputText("drawing strength from it");
			CombatAbilities.Might.backfireEnabled = false;
			CombatAbilities.Might.doEffect(false);
			CombatAbilities.Might.backfireEnabled = true;
		}
		else {
			if (display) outputText("feeling it mend your wounds");
			CombatAbilities.Heal.doEffect(false);
			spellPerkUnlock();
		}
		if (!monster.hasStatusEffect(StatusEffects.Blind)) {
			if (display) outputText(". The residual power ");
			if (!player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
				if (display) outputText("makes your staff glow with barely contained energy");
				CombatAbilities.ChargeWeapon.doEffect(false);
			}
			else {
				if (display) outputText("makes your staff flare up, as the energy escapes in a radiant flash");
				CombatAbilities.Blind.doEffect(false);
			}
		}
		if (display) outputText(".\n\n");
    }
}
}