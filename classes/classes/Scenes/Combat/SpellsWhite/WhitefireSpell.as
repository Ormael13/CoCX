package classes.Scenes.Combat.SpellsWhite {
import classes.MutationsLib;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.NPCs.Diva;
import classes.StatusEffects;

public class WhitefireSpell extends AbstractWhiteSpell {
	
	
	function WhitefireSpell() {
		super(
				"Whitefire",
				"Whitefire is a potent fire based attack that will burn your foe with flickering white flames, ignoring their physical toughness and most armors.",
				TARGET_ENEMY
		);
		_baseManaCost = 40;
	}
	
	override public function get currentCooldown():int {
		return player.statusEffectv1(StatusEffects.CooldownSpellWhitefire);
	}
	
	
	override protected function useResources():void {
		super.useResources(); // mana is used in AbstractSpell
		player.createStatusEffect(
				StatusEffects.CooldownSpellWhitefire,spellWhiteCooldown(),0,0,0
		);
	}
	
	override protected function doEffect():void {
		if (monster is Lethice && (monster as Lethice).fightPhase == 2) {
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!");
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
		} else {
			outputText("You narrow your eyes, focusing your mind with deadly intent.  You snap your fingers and " + monster.a + monster.short + " is enveloped in a flash of white flames!\n");
		}
		if(monster is Diva){(monster as Diva).handlePlayerSpell("whitefire");}
		var damage:Number = scalingBonusIntelligence() * spellModWhite() * 2;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//High damage to goes.
		damage = calcInfernoMod(damage);
		if (player.armor == armors.BLIZZ_K) damage *= 0.5;
		if (player.headJewelry == headjewelries.SNOWFH) damage *= 0.7;
		if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2);
		if (player.hasPerk(PerkLib.DivineKnowledge) && monster.cor > 65) damage = Math.round(damage * 1.2);
		if (player.hasPerk(PerkLib.PureMagic)) {
			if (monster.cor < 33) damage = Math.round(damage * 1.0);
			else if (monster.cor < 50) damage = Math.round(damage * 1.1);
			else if (monster.cor < 75) damage = Math.round(damage * 1.2);
			else if (monster.cor < 90) damage = Math.round(damage * 1.3);
			else damage = Math.round(damage * 1.4);
		}
		damage = Math.round(damage * combat.fireDamageBoostedByDao());
		outputText(monster.capitalA + monster.short + " takes ");
		if (player.hasPerk(PerkLib.Omnicaster)) {
			if (player.hasPerk(MutationsLib.GazerEyeEvolved)) damage *= 0.5;
			else if (player.hasPerk(MutationsLib.GazerEyePrimitive)) damage *= 0.3;
			else damage *= 0.2;
			damage = Math.round(damage);
			doFireDamage(damage, true, true);
			doFireDamage(damage, true, true);
			doFireDamage(damage, true, true);
			doFireDamage(damage, true, true);
			doFireDamage(damage, true, true);
			doFireDamage(damage, true, true);
			if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 8) {
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
			}
			if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) {
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
			}
		}
		else doFireDamage(damage, true, true);
		outputText(" damage.");
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		MagicAddonEffect();
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}

}
