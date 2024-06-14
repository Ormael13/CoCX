package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.API.FnHelpers;

public class TranceSkill extends AbstractSoulSkill {
	private static const TranceABC:Object = FnHelpers.FN.buildLogScaleABC(10,100,1000,10,100);
    public function TranceSkill() {
        super(
            "Trance",
            "Activate Trance state, which enhances your physical and mental abilities.",
            TARGET_SELF,
            TIMING_TOGGLE,
            [TAG_RECOVERY],
            PerkLib.Trance,
			false
        )
		baseSFCost = 100;
    }

	override public function get buttonName():String {
		if (isActive())
			return "Deactiv VPT";
		else
			return "V P Trans";
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

	override public function isActive():Boolean {
		return player.statStore.hasBuff("TranceTransformation");
	}

	override public function describeEffectVs(target:Monster):String {
		return "Increases physical and mental damage for 50 soulforce per turn";
	}

	override public function toggleOff(display:Boolean = true):void {
		if (display) outputText("You disrupt the flow of power within you, softly falling to the ground as the crystal sheathing your [skin] dissipates into nothingness.");
		player.statStore.removeBuffs("TranceTransformation");
	}

    override public function doEffect(display:Boolean = true):void {
		var tempStrTou:Number = 0;
		if (display) outputText("You focus the power of your mind and soul, letting the mystic energy fill you. Your [skin] begins to crystalize as the power within you takes form. The power whirls within you like a hurricane, the force of it lifting you off your feet. This power...  You will use it to reach victory!\n");
		
		var TranceBoost:Number = 10;
		if (player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) TranceBoost += 5;
		if (player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) TranceBoost += 5;
		if (player.hasPerk(PerkLib.Mage) && player.inte >= 50) TranceBoost += 10;
		if (player.hasPerk(PerkLib.FocusedMind) && player.inte >= 50) TranceBoost += 10;
		if (player.hasPerk(PerkLib.Channeling) && player.inte >= 60) TranceBoost += 10;
		if (player.hasPerk(PerkLib.Archmage) && player.inte >= 75) TranceBoost += 15;
		if (player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 100) TranceBoost += 20;
		if (player.hasPerk(PerkLib.GreyMageApprentice) && player.inte >= 75) TranceBoost += 10;
		if (player.hasPerk(PerkLib.GreyMage) && player.inte >= 125) TranceBoost += 15;
		if (player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 175) TranceBoost += 20;
		if (player.hasPerk(PerkLib.GrandGreyArchmage) && player.inte >= 225) TranceBoost += 25;
		if (player.hasPerk(PerkLib.GrandGreyArchmage2ndCircle) && player.inte >= 275) TranceBoost += 30;
		if (player.hasPerk(PerkLib.JobEnchanter) && player.inte >= 50) TranceBoost += 5;
		if (player.hasPerk(PerkLib.Battleflash) && player.inte >= 50) TranceBoost += 15;
		if (player.hasPerk(PerkLib.JobSwordsman)) TranceBoost -= 10;
		if (player.hasPerk(PerkLib.JobBrawler)) TranceBoost -= 10;
		if (player.hasPerk(PerkLib.JobDervish)) TranceBoost -= 10;
		if (player.hasPerk(PerkLib.IronFistsI)) TranceBoost -= 10;
		if (player.hasPerk(PerkLib.JobMonk)) TranceBoost -= 15;
		if (player.hasPerk(PerkLib.Berzerker)) TranceBoost -= 15;
		if (player.hasPerk(PerkLib.Lustzerker)) TranceBoost -= 15;
		if (player.hasPerk(PerkLib.WeaponMastery)) TranceBoost -= 15;
		if (player.hasPerk(PerkLib.WeaponGrandMastery)) TranceBoost -= 25;
		if (player.hasPerk(PerkLib.HeavyArmorProficiency)) TranceBoost -= 15;
		if (player.hasPerk(PerkLib.AyoArmorProficiency)) TranceBoost -= 20;
		if (player.hasPerk(PerkLib.Agility)) TranceBoost -= 10;
		if (player.hasPerk(PerkLib.LightningStrikes)) TranceBoost -= 10;
		if (player.hasPerk(PerkLib.StarlightStrikes)) TranceBoost -= 10;
		if (player.hasPerk(PerkLib.FleshBodyApprenticeStage)) TranceBoost -= 5;
		//	TranceBoost += player.inte / 10;player.inte * 0.1 - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells (maybe only when they have a perk from the prestige job: magus/warlock/other related to spells)
		if (TranceBoost < 10) TranceBoost = 10;
		//	if (player.hasPerk(PerkLib.JobEnchanter)) TranceBoost *= 1.2;
		//	TranceBoost *= spellModBlack();
		TranceBoost = FnHelpers.FN.logScale(TranceBoost,TranceABC,10);
		TranceBoost = Math.round(TranceBoost);
		tempStrTou = TranceBoost;
		mainView.statsView.showStatUp('str');
		// strUp.visible = true;
		// strDown.visible = false;
		mainView.statsView.showStatUp('tou');
		// touUp.visible = true;
		// touDown.visible = false;
		player.buff("TranceTransformation").addStats({str:TranceBoost,tou:TranceBoost}).withText("Trance Transformation").combatPermanent();
    }
}
}