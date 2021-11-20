package classes.Scenes.Combat.SpellsWhite {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.StatusEffects;

public class BlizzardSpell extends AbstractWhiteSpell {
	public function BlizzardSpell() {
		super(
				"Blizzard",
				"Blizzard is a potent ice based defense spell that will reduce power of any fire based attack used against the user.",
				TARGET_SELF,
				TIMING_LASTING,
				[TAG_BUFF, TAG_ICE]
		);
		baseManaCost = 50;
	}
	
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsBlizzard);
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.Blizzard)
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You utter words of power, summoning an ice storm.  It swirls arounds you, ensuring that you'll have more protection from the fire attacks for a few moments.\n\n");
		}
		var blizzardmagnitude:Number = 0;
		if (player.hasPerk(PerkLib.ColdMastery) || player.hasPerk(PerkLib.ColdAffinity)) blizzardmagnitude += 2 + player.inte / 10;
		else blizzardmagnitude += 1 + player.inte / 25;
		if (player.hasPerk(PerkLib.DefensiveStaffChanneling)) blizzardmagnitude *= 1.1;
		player.createStatusEffect(StatusEffects.Blizzard, Math.round(blizzardmagnitude), 0, 0, 0);
	}
}
}
