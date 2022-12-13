package classes.Scenes.Combat.SpellsGreen 
{
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreenSpell;
import classes.StatusEffects;

	public class GreenCovenantSpell extends AbstractGreenSpell {
		
		public function GreenCovenantSpell() 
		{
			super("Green Covenant",
			"Enforce the full might of your elven pact. Connect with nearby plants gaining high regeneration damage reduction, and empowering elven magic but taking periodic lust damage and reducing evade.",
			TARGET_SELF,
			TIMING_LASTING,
			[TAG_BUFF]);
		baseManaCost = 1250;
		}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsGreenCovenant);
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "high regeneration, damage reduction; empowering elven magic but taking periodic lust damage and reducing evade"
	}
	
	override public function calcCooldown():int {
		return spellWhiteTier3Cooldown();
	}
	
	override protected function usabilityCheck():String {
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		if (!player.hasStatusEffect(StatusEffects.NearbyPlants)) {
			return "Entangle require to have plants nearby.";
		}
		
		return "";
	}
	
	override public function isActive():Boolean {
		return monster.hasStatusEffect(StatusEffects.GreenCovenant);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You direct your desire to the nearby plants causing them to surge and wrap around you as a tendril gently wraps itself around your left leg, embracing your form like a lover, before "+(player.hasVagina()?"plunging within your welcoming elven nether lips. A second one ":"it ")+"");
			outputText("finds the hole to your pucker plugging it perfectly as embery sap flows directly from the plants into your core. Now one with the nearby corrupted vegetation you overflow with magical might as the plants literally pump their power directly into you.\n");
			player.createStatusEffect(StatusEffects.GreenCovenant, 0, 0, 0, 0);
		}
	}
}
}
