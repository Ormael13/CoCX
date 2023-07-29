package classes.Stats {
import classes.CoC;
import classes.Creature;
import classes.Player;
import classes.internals.Jsonable;
import classes.internals.Utils;

public class SkillXpStat extends Utils implements IStat, Jsonable {
	public var player:Player;
	public var skillId:String;
	public var skillName:String;
	public var iconId:String;
	public var xp:Number = 0;
	public var level:Number = 0;
	
	public function SkillXpStat(
			player:Player,
			skillId:String,
			skillName:String,
			iconId:String
	) {
		this.player    = player;
		this.skillId = skillId;
		this.skillName = skillName;
		this.iconId    = iconId;
	}
	
	protected function onLevelUp():void {
		// Implement (optionally) in subclasses
	}
	public function maxLevel():Number {
		// Implement in subclasses
		return 1;
	}
	public function get skillFullName():String {
		return skillName+" Skill";
	}
	public function xpToNextLevel():Number {
		// Implement in subclasses
		return 1000;
	}
	public function describe(format:Boolean):String {
		var s:String = "";
		
		if (format) s += "<b>";
		s += skillFullName + ":";
		if (format) s += "</b>";
		s += " ";
		
		s += ""+level+" / "+maxLevel();
		
		s += " (Exp: ";
		if (level == maxLevel()) s += "MAX";
		else s += ""+xp+"/"+xpToNextLevel();
		s += ")";
		
		return s;
	}
	public function giveXp(amount:Number):void {
		if (amount == 0) return;
		var oldRatio:Number = xp / xpToNextLevel();
		xp += amount;
		CoC.instance.mainView.notificationView.popupProgressBar2(
				skillName, iconId,
				skillName + " XP +" + amount,
				oldRatio,
				xp / xpToNextLevel()
		);
		while (level < maxLevel()) {
			var tnl:Number = xpToNextLevel();
			if (xp < tnl) break;
			level++;
			xp -= tnl;
			CoC.instance.mainView.notificationView.popupIconText(
					skillName, iconId,
					skillName + " leveled up to " + level + "!"
			);
			onLevelUp();
		}
	}
	public function get statName():String {
		return skillId
	}
	public function get host():Creature {
		return player;
	}
	public function get value():Number {
		return xp;
	}
	public function get min():Number {
		return 0;
	}
	public function get max():Number {
		return xpToNextLevel();
	}
	
	public function saveToObject():Object {
		return {xp:xp, level:level}
	}
	
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o) {
			xp = numberOr(o['xp'], 0);
			level = numberOr(o['level'], 0);
		} else {
			xp = 0;
			level = 0;
		}
	}
}
}
