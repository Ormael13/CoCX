package classes.Stats.Skills {
import classes.Player;
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
		return base + factor1 * factor2 * factor3;
	}
	
	override public function maxLevel():Number {
		var maxLevel:Number = 2;
		if (player.level < 48) maxLevel += player.level;
		else maxLevel += 48;
		return maxLevel;
	}
}
}
