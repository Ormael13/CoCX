package classes.Scenes.Combat.SpellsHex {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractHexSpell;
import classes.Scenes.Combat.Combat;
import classes.StatusEffects;

public class LifeSiphonSpell extends AbstractHexSpell {
	public function LifeSiphonSpell() {
		super(
			"Life Siphon",
			"Create a funnel between you and your target, forcefully stealing its vitality to recover your own.",
			TARGET_ENEMY,
			TIMING_LASTING,
			[TAG_DAMAGING, TAG_HEALING]
		);
		baseManaCost = 750;
		useManaType = Combat.USEMANA_MAGIC_HEAL;
		canBackfire  = true;
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "" + numberFormat(calcDamage(target, false, false)) + " HP leech for "+
				numberOfThings(calcDuration(),"round") +
				"; " + calcBackfirePercent() + "% backfire"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsLifeSiphon);
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.LifeSiphon);
	}
	
	override public function calcDuration():int {
		return 15;
	}
	
	override public function advance(display:Boolean):void {
		if (player.statusEffectv1(StatusEffects.LifeSiphon) <= 0) {
			player.removeStatusEffect(StatusEffects.LifeSiphon);
		 }else {
			player.addStatusValue(StatusEffects.LifeSiphon, 1, -1);
			if (display) {
				outputText("<b>[Themonster] health is being funneled to you through your life siphon hex. ([font-heal]+" + player.statusEffectv2(StatusEffects.LifeSiphon) + "[/font])</b>\n\n");
			}
			HPChange(player.statusEffectv2(StatusEffects.LifeSiphon), false);
			monster.HP -= player.statusEffectv2(StatusEffects.LifeSiphon);
		}
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean=true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var lifesiphon:Number = 0;
		lifesiphon += player.inte;
		if (player.hasPerk(PerkLib.WisenedHealer)) lifesiphon += player.wis;
		if (monster != null) {
			if (player.hasPerk(PerkLib.HexKnowledge) && monster.cor < 34) lifesiphon = Math.round(lifesiphon * 1.2);
			lifesiphon *= corruptMagicPerkFactor(monster);
		}
		if (player.hasPerk(PerkLib.Necromancy)) lifesiphon *= 1.5;
		if (player.hasPerk(PerkLib.CorruptMagic) && player.hasStatusEffect(StatusEffects.DarkRitual)) lifesiphon *= 2;
		return Math.round(lifesiphon);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You focus on your magic, trying to draw on it without enhancing your own arousal.\n");
		}
		if (!backfired(display)) {
			var lifesiphon:Number = calcDamage(monster, true, true);
			if (display) {
				outputText("You wave a sign linking yourself to [themonster] as you begin to funnel its health and vitality to yourself.");
			}
			monster.HP -= lifesiphon;
			HPChange(lifesiphon, false);
			player.createStatusEffect(StatusEffects.LifeSiphon, 15, lifesiphon, 0, 0);
		}
	}
}
}
