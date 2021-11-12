package classes.Scenes.Combat {
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.StatusEffects;

public class AbstractSpell extends CombatAbility {
	
	protected var isBloodMagicApplicable:Boolean = true;
	protected var useManaType:int;
	
	function AbstractSpell(name:String, desc:String, targetType: int, useManaType:int) {
		super(name, desc, targetType);
		this.useManaType = useManaType;
	}
	
	override protected function useResources():void {
		var realCost:Number = manaCost();
		
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		
		if (player.hasPerk(PerkLib.LastResort) && player.mana < realCost) {
			player.HP -= realCost;
		} else {
			useMana(40, useManaType);
		}
		
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		combat.spellPerkUnlock();
	}
	
	override protected function usabilityCheck():String {
		
		// Run all check applicable to all abilities
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		// Run our checks
		if (player.hasStatusEffect(StatusEffects.BloodMage)) {
			if (player.HP - player.minHP() > manaCost()) {
				return "Your hp is too low to cast this spell."
			}
		} else {
			if (player.mana < manaCost()) {
				if (player.hasPerk(PerkLib.LastResort)) {
					if (player.HP < manaCost()) {
						return "Your hp and mana are too low to cast this spell."
					}
				} else {
					return "Your mana is too low to cast this spell."
				}
			}
		}
		if (targetType == TARGET_ENEMY) {
			if (monster.hasStatusEffect(StatusEffects.Dig)) {
				return "You can only use buff magic while underground."
			}
			if (combat.isEnnemyInvisible) {
				return "You cannot use offensive spells against an opponent you cannot see or target."
			}
		}
		return ""
	}
	
	protected function performSpellEffect():void {
		throw new Error("Method performSpellEffect() not implemented for ability "+name);
	}
	
	protected override function doEffect():void {
		useResources();
		if (monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
		} else {
			performSpellEffect();
		}
	}
	
	///////////////////////////
	// Shortcuts
	///////////////////////////
	
	protected function MagicAddonEffect(numberOfProcs:Number = 1):void {
		combat.magic.MagicAddonEffect(numberOfProcs);
	}
}
}
