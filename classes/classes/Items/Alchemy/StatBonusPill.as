package classes.Items.Alchemy {
import classes.Items.Consumable;
import classes.Stats.IStat;
import classes.Stats.RawStat;
import classes.Stats.StatUtils;
import classes.internals.EnumValue;

public class StatBonusPill extends Consumable {
	public var residue:int;
	public var stat:String;
	public var power:int;
	public var bonus:Number;
	public var isMutagenBonus:Boolean;
	
	/**
	 * @param params
	 * @param params.r Alchemy residue used (AlchemyLib.AR_XXX)
	 * @param params.p Pill power (AlchemyLib.PP_XXX)
	 */
	public function StatBonusPill(id:String, params:Object) {
		this.residue = params.r;
		this.power   = params.p;
		
		var shortName:String;
		var longName:String;
		var description:String;
		var value:Number = 100;
		
		var powerMeta:EnumValue   = AlchemyLib.PillPowerTiers[power];
		var residueMeta:EnumValue = AlchemyLib.Residues[residue];
		
		this.stat  = residueMeta.stat;
		this.bonus = powerMeta.power * residueMeta.sign;
		
		shortName      = powerMeta.short + residueMeta.short + " E.Pill";
		longName       = powerMeta.name + " " + residueMeta.name + " enhancer pill";
		isMutagenBonus = StatUtils.isKnownStat(stat + ".mult");
		description    =
				"This " + powerMeta.name + " pill permanently " +
				(residueMeta.sign > 0 ? "increases" : "decreases") +
				" your " + StatUtils.nameOfStat(stat) +
				" by " + Math.abs(bonus) + (isMutagenBonus ? "%" : "");
		if (isMutagenBonus) {
			description += " up to +{cap}%";
			if (power == AlchemyLib.PP_POTENT) {
				description += ", then by 1% up to +{cap+5}%";
			} else if (power == AlchemyLib.PP_RADIANT) {
				description += ", then by 1% up to +{cap+10}%";
			}
		}
		description += ".";
		
		super(id, shortName, longName, value, description);
	}
	
	
	override public function get ownIconId():String {
		return "I_"+templateId()+"_"+power;
	}
	override public function get description():String {
		var cap:Number = player.MutagenBonusCap100();
		return super.description.replace(/\{cap}/, cap)
					.replace(/\{cap\+5}/, cap + 5)
					.replace(/\{cap\+10}/, cap + 10);
	}
	override public function useItem():Boolean {
		clearOutput();
		outputText("You swallow the " + longNameBase + ". You feel warmth spreading from your stomach...\n\n");
		var dud:Boolean = false;
		if (isMutagenBonus) {
			var cap:Number     = 0.01*player.MutagenBonusCap100();
			var current:Number = player.GetMutagenBonus(stat);
			if (current < cap) {
				player.MutagenBonus(stat, bonus);
			} else if (power == AlchemyLib.PP_POTENT && current < cap+0.05) {
				player.MutagenBonus(stat, 1, true, 5);
			} else if (power == AlchemyLib.PP_RADIANT && current < cap+0.10) {
				player.MutagenBonus(stat, 1, true, 10);
			} else {
				dud = true;
			}
		} else {
			var oldValue:Number = player[stat];
			var iStat:IStat     = player.statStore.findStat(stat);
			if (iStat is RawStat) {
				(iStat as RawStat).value += bonus;
			} else {
				player[stat] += bonus;
			}
			dud = oldValue == player[stat];
		}
		
		if (dud) {
			outputText("You don't feel any different.")
		} else {
			outputText("<b>You feel "+AlchemyLib.Residues[residue].feedback+"!</b>");
		}
		return false;
	}
}
}
