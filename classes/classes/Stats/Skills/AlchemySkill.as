package classes.Stats.Skills {
import classes.PerkLib;
import classes.Player;
import classes.Races;
import classes.IMutations.IMutationsLib;
import classes.Stats.SkillXpStat;

public class AlchemySkill extends SkillXpStat {
	public function AlchemySkill(player:Player) {
        super(player, "alchemy", "Alchemy", "alchemyXP");
	}
	
	override public function xpToNextLevel():Number {
		var base:Number = 10;
		var factor1:Number = level + 1;
		var factor2:Number = 5;
		var factor3:Number = level + 1;
		if (player.hasPerk(PerkLib.UtilitySkillsApprentice)) factor1 -= 1;
		//-2;//4th
		//-3;//6th
		if (player.hasMutation(IMutationsLib.HumanVersatilityIM) && player.perkv1(IMutationsLib.HumanVersatilityIM) >= 2 && player.racialScore(Races.HUMAN) > 17) factor2 -= 1;
		if (player.hasMutation(IMutationsLib.HumanVersatilityIM) && player.perkv1(IMutationsLib.HumanVersatilityIM) >= 3 && player.racialScore(Races.HUMAN) > 17) factor2 -= 2;
		//if (hasPerk(PerkLib.SuperSensual)) factor2 -= 1;
		if (player.hasPerk(PerkLib.UtilitySkillsBeginner)) factor3 -= 1;
		if (player.hasPerk(PerkLib.UtilitySkillsSkilled)) factor3 -= 2;
		//-3;//5th
		return base + factor1 * factor2 * factor3;
	}
	
	override public function maxLevel():Number {
		var maxLevel:Number = 6;
		if (player.level < 64) maxLevel += player.level;
		else maxLevel += 64;
		return maxLevel;
	}
}
}
