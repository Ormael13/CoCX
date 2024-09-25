package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.Scenes.NPCs.Jojo;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.Races;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class CleansingPalmSkill extends AbstractSoulSkill {
    public function CleansingPalmSkill() {
        super(
            "Cleansing Palm",
            "Unleash the power of your cleansing aura! More effective against corrupted opponents. Doesn't work on the pure. Damage based on physical attack.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_MAGICAL],
            PerkLib.CleansingPalm
        )
		baseSFCost = 30;
		lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

    override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

        if (player.cor >= (10 + player.corruptionTolerance)) {
				return "You are too corrupt to use this ability!";
		}

        return "";
    }

	override public function get buttonName():String {
		return "C.Palm";
	}

	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target)) + " magical damage"
	}

	private function calcCorruptionMulti(monster:Monster):Number {
		var corruptionMulti:Number = (monster.cor - 20) / 25;
		if (corruptionMulti > 1.5) {
			corruptionMulti = 1.5;
			corruptionMulti += ((monster.cor - 57.5) / 100); //The increase to multiplier is diminished.
		}
		return corruptionMulti;
	}

	public function calcDamage(monster:Monster):Number {
		var damage:Number = scalingBonusWisdom() * 2;
		damage += combat.meleeUnarmedDamageNoLagSingle();
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
			if (player.isRaceCached(Races.MOUSE, 2) && player.countRings(jewelries.INMORNG)) damage *= 2.2;
			else damage *= 2;
			damage = combat.fireTypeDamageBonusLarge(damage);
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			damage = combat.fireTypeDamageBonus(damage);
			damage *= 1.1;
		}
		damage *= soulskillMod();
		if (monster) {
			damage *= calcCorruptionMulti(monster);
			if (player.hasPerk(PerkLib.PerfectStrike) && monster.monsterIsStunned()) damage *= 1.5;
		}
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5)) damage *= 1.5;
		return Math.round(damage);

	}

    override public function doEffect(display:Boolean = true):void {
        if (monster is Jojo) {
			// Not a completely corrupted monkmouse
			if (JojoScene.monk < 2) {
				if (display) {
					outputText("You thrust your palm forward, sending a blast of pure energy towards Jojo. At the last second he sends a blast of his own against yours canceling it out\n\n");
				}
				return;
			}
		}
		if (monster is LivingStatue) {
			if (display) {
				outputText("You thrust your palm forward, causing a blast of pure energy to slam against the giant stone statue - to no effect!");		
			}
			return;
		}

		var damage:Number = calcDamage(monster);
		if (damage > 0) {
			if (display) {
				outputText("You thrust your palm forward, creating a blast of pure energy that erupts from your palm, slamming into [themonster], tossing");
				if ((monster as Monster).plural) {
					outputText(" them");
				} else {
					outputText((monster as Monster).mfn(" him", " her", " it"));
				}
				outputText(" back a few feet.\n\n");
				if (silly() && calcCorruptionMulti(monster) >= 1.75) outputText("It's super effective!  ");
			}
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combat.combatPhysicalCritical();
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			if (display) {
				outputText("[Themonster] takes ");
			}
			combat.checkForElementalEnchantmentAndDoDamageMain(damage, true, true, crit, false, 2);
			if (display) {
				if (crit) 
					outputText(" <b>*Critical Hit!*</b>");
				outputText("damage \n\n");
			}
			
		}
		else {
			if (display) {
				outputText("You thrust your palm forward, causing a blast of pure energy to slam against [themonster], which they ignore. It is probably best you don’t use this technique against the pure.\n\n");
			}
		} 
		combat.WrathGenerationPerHit2(5);
		if (!player.hasStatusEffect(StatusEffects.BloodCultivator) && flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] == 0) this.anubiHeartLeeching(damage);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
    }
}
}