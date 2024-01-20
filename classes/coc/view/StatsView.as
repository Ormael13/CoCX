package coc.view {
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.Player;
import classes.Stats.BuffableStat;
import classes.Stats.IStat;
import classes.Stats.PrimaryStat;
import classes.Stats.StatUtils;
import classes.internals.Utils;

import coc.model.TimeModel;

import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class StatsView extends Block {
	public static const ValueFontOld:String    = 'Lucida Sans Typewriter';
	public static const ValueFont:String       = 'Georgia';
	
	public static const LABEL_FORMAT:Object = {
		font:'Times New Roman',
		bold:true,
		size:22
	};
	public static const TEXT_FORMAT:Object = {
		font:ValueFont,
		size:16
	};
	public static const TIME_FORMAT:Object = {
		font:'Lucida Sans Typewriter',
		size:18
	};

	private var sideBarBG:BitmapDataSprite;
	private var nameText:TextField;
	private var coreStatsText:TextField;
	private var combatStatsText:TextField;
	private var strBar:StatBar;
	private var touBar:StatBar;
	private var speBar:StatBar;
	private var intBar:StatBar;
	private var wisBar:StatBar;
	private var libBar:StatBar;
	private var senBar:StatBar;
	private var corBar:StatBar;
	private var hpBar:StatBar;
	private var wrathBar:StatBar;
	private var lustBar:StatBar;
	private var fatigueBar:StatBar;
	private var manaBar:StatBar;
	private var soulforceBar:StatBar;
	private var hungerBar:StatBar;

	private var allStats:/*StatBar*/Array;

	private var col1:Block;
	private var col2:Block;
	private var corner:CornerStatsView;

	public function StatsView(mainView:MainView, cornerStatsView:CornerStatsView) {
		super({
			x    : MainView.STATBAR_X,
			y    : MainView.STATBAR_Y,
			width: MainView.STATBAR_W,
			height: MainView.STATBAR_H
		});
		this.corner = cornerStatsView;
		sideBarBG     = addBitmapDataSprite({
			x:0,y:0,
			width: MainView.STATBAR_W,
			height: MainView.STATBAR_H,
			crop: true,
			borderColor: '#A37C17',
			borderWidth: 1,
			borderRadius: 2
		});
		nameText      = addTextField({
			x:0,y:0,
			width: MainView.STATBAR_W,
			defaultTextFormat: Utils.extend({},LABEL_FORMAT,{
				align:TextFormatAlign.CENTER
			})
		});
		addElement(col1 = new Block({
			x: 0,
			y: 20,
			width: MainView.STATBAR_COL_W,
			height: MainView.STATBAR_H,
			layoutConfig: {
				padding: MainView.HALFGAP,
				type: 'flow',
				direction: 'column',
				ignoreHidden: true,
				gap: 1
			}
		}));
		addElement(col2 = new Block({
			x: MainView.STATBAR_COL_W,
			y: 20,
			width: MainView.STATBAR_COL_W,
			height: MainView.STATBAR_H,
			layoutConfig: {
				padding: MainView.HALFGAP,
				type: 'flow',
				direction: 'column',
				ignoreHidden: true,
				gap: 1
			}
		}));
		coreStatsText = col1.addTextField({
			text: 'Core stats:',
			defaultTextFormat: LABEL_FORMAT
		},{before:1});
		col1.addElement(strBar = new StatBar({statName: "Strength:"}));
		strBar.addEventListener("rollOver",Utils.curry(hoverStat,'str'));
		strBar.addEventListener("rollOut",Utils.curry(hoverStat,'str'));
		col1.addElement(touBar = new StatBar({statName: "Toughness:"}));
		touBar.addEventListener("rollOver",Utils.curry(hoverStat,'tou'));
		touBar.addEventListener("rollOut",Utils.curry(hoverStat,'tou'));
		col1.addElement(speBar = new StatBar({statName: "Speed:"}));
		speBar.addEventListener("rollOver",Utils.curry(hoverStat,'spe'));
		speBar.addEventListener("rollOut",Utils.curry(hoverStat,'spe'));
		col1.addElement(intBar = new StatBar({statName: "Intelligence:"}));
		intBar.addEventListener("rollOver",Utils.curry(hoverStat,'int'));
		intBar.addEventListener("rollOut",Utils.curry(hoverStat,'int'));
		col1.addElement(wisBar = new StatBar({statName: "Wisdom:"}));
		wisBar.addEventListener("rollOver",Utils.curry(hoverStat,'wis'));
		wisBar.addEventListener("rollOut",Utils.curry(hoverStat,'wis'));
		col1.addElement(libBar = new StatBar({statName: "Libido:"}));
		libBar.addEventListener("rollOver",Utils.curry(hoverStat,'lib'));
		libBar.addEventListener("rollOut",Utils.curry(hoverStat,'lib'));
		col1.addElement(senBar = new StatBar({statName: "Sensitivity:"}));
		senBar.addEventListener("rollOver",Utils.curry(hoverStat,'sens'));
		senBar.addEventListener("rollOut",Utils.curry(hoverStat,'sens'));
		col1.addElement(corBar = new StatBar({statName: "Corruption:"}));
		corBar.addEventListener("rollOver",Utils.curry(hoverStat,'cor'));
		corBar.addEventListener("rollOut",Utils.curry(hoverStat,'cor'));
		
		combatStatsText = col2.addTextField({
			text: 'Combat stats',
			defaultTextFormat: LABEL_FORMAT
		},{before:1});
		col2.addElement(hpBar = new StatBar({
			statName: "HP:",
			barColor: '#008000',
			bgColor : '#ff0000',
			showMax : true
		}));
		hpBar.addEventListener("rollOver",Utils.curry(hoverStat,'hp'));
		hpBar.addEventListener("rollOut",Utils.curry(hoverStat,'hp'));
		col2.addElement(lustBar = new StatBar({
			statName   : "Lust:",
		//	barColor   : '#ff1493',
			minBarColor: '#ff0000',
			hasMinBar  : true,
			showMax    : true
		}));
		lustBar.addEventListener("rollOver",Utils.curry(hoverStat,'minlust'));
		lustBar.addEventListener("rollOut",Utils.curry(hoverStat,'minlust'));
		col2.addElement(wrathBar = new StatBar({
			statName: "Wrath:",
			showMax : true
		}));
		wrathBar.addEventListener("rollOver",Utils.curry(hoverStat,'wrath'));
		wrathBar.addEventListener("rollOut",Utils.curry(hoverStat,'wrath'));
		col2.addElement(fatigueBar = new StatBar({
			statName: "Fatigue:",
			showMax : true
		}));
		col2.addElement(manaBar = new StatBar({
			statName: "Mana:",
		//	barColor: '#0000ff',
			showMax : true
		}));
		col2.addElement(soulforceBar = new StatBar({
			statName: "SF:",
		//	barColor: '#ffd700',
			showMax : true
		}));
		col2.addElement(hungerBar = new StatBar({
			statName: "Satiety:",
			showMax : true
		}));
		///////////////////////////
		allStats = [];
		for (var ci:int = 0, cn:int = col1.numElements; ci < cn; ci++) {
			var e:StatBar = col1.getElementAt(ci) as StatBar;
			if (e) allStats.push(e);
		}
		for (ci = 0, cn = col2.numElements; ci < cn; ci++) {
			e = col2.getElementAt(ci) as StatBar;
			if (e) allStats.push(e);
		}
		for (ci = 0, cn = cornerStatsView.numElements; ci < cn; ci++) {
			e = cornerStatsView.getElementAt(ci) as StatBar;
			if (e) allStats.push(e);
		}
	}
	override public function invalidateLayout():void {
		super.invalidateLayout();
		if (col1) col1.invalidateLayout();
		if (col2) col2.invalidateLayout();
		if (corner) corner.invalidateLayout();
	}
	public function show():void {
		this.visible = true;
	}

	public function hide():void {
		this.visible = false;
	}

	
	override public function set visible(value:Boolean):void {
		if (visible != value) {
			for each (var sb:StatBar in allStats) {
				sb.animate = value && (CoC.instance.flags[kFLAGS.STATBAR_ANIMATIONS] == 0);
			}
		}
		super.visible = value;
		if (corner) corner.visible = visible;
	}
	// <- hideUpDown
	public function hideUpDown():void {
		var ci:int, cc:int = this.allStats.length;
		for (ci = 0; ci < cc; ++ci) {
			var c:StatBar = this.allStats[ci];
			c.isUp        = false;
			c.isDown      = false;
		}
	}

	public function showLevelUp():void {
		this.corner.levelBar.isUp = true;
	}

	public function hideLevelUp():void {
		this.corner.levelBar.isUp = false;
	}

	public function statByName(statName:String):StatBar {
		switch (statName.toLowerCase()) {
			case 'str':
				return strBar;
			case 'tou':
				return touBar;
			case 'spe':
				return speBar;
			case 'inte':
			case 'int':
				return intBar;
			case 'wis':
				return wisBar;
			case 'lib':
				return libBar;
			case 'sens':
			case 'sen':
				return senBar;
			case 'cor':
				return corBar;
			case 'hp':
				return hpBar;
			case 'wrath':
				return wrathBar;
			case 'lust':
				return lustBar;
			case 'fatigue':
				return fatigueBar;
			case 'mana':
				return manaBar;
			case 'soulforce':
				return soulforceBar;
			case 'hunger':
				return hungerBar;
			case 'level':
				return corner.levelBar;
			case 'xp':
				return corner.xpBar;
			case 'gems':
				return corner.gemsBar;
			case 'spiritstones':
				return corner.spiritstonesBar;
		}
		return null;
	}
	public function showStatUp(statName:String):void {
		var stat:StatBar = statByName(statName);
		if (stat) stat.isUp        = true;
		else trace("[ERROR] Cannot showStatUp "+statName);
	}

	public function showStatDown(statName:String):void {
		var stat:StatBar = statByName(statName);
		if (stat) stat.isDown      = true;
		else trace("[ERROR] Cannot showStatDown "+statName);
	}
	public function hungerBarIsVisible():Boolean {
		return hungerBar.visible;
	}
	public function toggleHungerBar(show:Boolean):void {
		hungerBar.visible = show;
		invalidateLayout();
	}
	public function refreshStats(game:CoC):void {
		var player:Player            = game.player;
		nameText.htmlText     = "<b>" + player.short + "</b>";
		strBar.maxValue       = player.strStat.max;
		strBar.value          = player.str;
		touBar.maxValue       = player.touStat.max;
		touBar.value          = player.tou;
		speBar.maxValue       = player.speStat.max;
		speBar.value          = player.spe;
		intBar.maxValue       = player.intStat.max;
		intBar.value          = player.inte;
		wisBar.maxValue       = player.wisStat.max;
		wisBar.value          = player.wis;
		libBar.maxValue       = player.libStat.max;
		libBar.value          = player.lib;
		senBar.maxValue       = player.sens;
		senBar.value          = player.effectiveSensitivity();
		corBar.value          = player.cor;
		var hpPercent:Boolean = game.flags[kFLAGS.HP_STATBAR_PERCENTAGE] == 1;
		hpBar.maxValue        = player.maxHP();
		hpBar.value           = player.HP;
		hpBar.percentage	  = hpPercent;
		var wrathPercent:Boolean = game.flags[kFLAGS.WRATH_STATBAR_PERCENTAGE] == 1;
		wrathBar.maxValue 	  = player.maxWrath();
		wrathBar.value    	  = player.wrath;
		wrathBar.percentage	  = wrathPercent;
		var lustPercent:Boolean = game.flags[kFLAGS.LUST_STATBAR_PERCENTAGE] == 1;
		lustBar.maxValue      = player.maxLust();
		lustBar.minValue      = player.minLust();
		lustBar.percentage	  = lustPercent;
		lustBar.value         = player.lust;
		fatigueBar.maxValue   = player.maxFatigue();
		fatigueBar.value      = player.fatigue;
		manaBar.maxValue 	  = player.maxMana();
		manaBar.value    	  = player.mana;
		soulforceBar.maxValue = player.maxSoulforce();
		soulforceBar.value    = player.soulforce;
	//	soulforceBar.valueText= (player.soulforce/player.maxSoulforce()).toFixed(2)+'%';
		hungerBar.maxValue    = player.maxHunger();
		hungerBar.value       = player.hunger;
		if (player.hunger < 25) {
			hungerBar.statName = '/!\\ Satiety:';
		} else {
			hungerBar.statName = 'Satiety:';
		}

		corner.advancementText.htmlText = "<b>Advancement</b>";
		corner.levelBar.value           = player.level;
		if (player.negativeLevel) corner.levelBar.valueText = "(-" + player.negativeLevel + ") " + player.level;
		if (player.level < CoC.instance.levelCap || player.negativeLevel > 0) {
			corner.xpBar.maxValue = player.requiredXP();
			corner.xpBar.value    = player.XP;
		} else {
			corner.xpBar.maxValue  = player.XP;
			corner.xpBar.value     = player.XP;
			corner.xpBar.valueText = 'MAX';
		}
		corner.gemsBar.valueText = Utils.addComma(Math.floor(player.gems));
		corner.spiritstonesBar.valueText = game.flags[kFLAGS.SPIRIT_STONES];

		var minutesDisplay:String = "" + game.model.time.minutes;
		if (minutesDisplay.length == 1) minutesDisplay = "0" + minutesDisplay;

		var hours:Number = game.model.time.hours;
		var hrs:String, ampm:String;
		if (game.flags[kFLAGS.USE_12_HOURS] == 0) {
			hrs  = "" + hours;
			ampm = "";
		} else {
			hrs  = (hours % 12 == 0) ? "12" : "" + (hours % 12);
			ampm = hours < 12 ? "am" : "pm";
		}
		corner.timeText.htmlText = "<u>Days Passed: " + game.model.time.days + "</u>\n"
			+ (CoC.instance.model.time.useRealDate() ? '' : '<u>Date: ' + TimeModel.formatDate(CoC.instance.model.time.date) + '</u>\n')
			+ "Time: " + hrs + ":" + minutesDisplay + ampm;
		corner.debugBuildVersion.htmlText = "CoCX: " + CoC.instance.debugGameVer +
				", NG: "+ CoC.instance.flags[kFLAGS.NEW_GAME_PLUS_LEVEL];

		invalidateLayout();
	}

	public function setTheme(type:int, font:String):void {
		var style:* = MainView.Themes[type];
		if (!style) return;
		sideBarBG.borderColor = style.statBorderColor;
		sideBarBG.fillColor = style.statGlass;
		sideBarBG.fillAlpha = style.statGlassAlpha;
		corner.bg.borderColor = style.statBorderColor;
		corner.bg.fillColor = style.statGlass;
		corner.bg.fillAlpha = style.statGlassAlpha;
		
		var dtf:TextFormat;
		for each(var e:StatBar in allStats) {
			dtf = e.valueLabel.defaultTextFormat;
			dtf.color = style.statTextColor;
			dtf.font = font;
			e.valueLabel.defaultTextFormat = dtf;
			e.valueLabel.setTextFormat(dtf);
			e.nameColor = style.statTextColor;
			if (e.bar) e.bar.alpha    = style.barAlpha;
			if (e.minBar) e.minBar.alpha = (1 - (1 - style.barAlpha) / 2); // 2 times less transparent than bar
		}
		for each(var tf:TextField in [nameText,coreStatsText,combatStatsText,corner.advancementText,corner.timeText,corner.debugBuildVersion]) {
			dtf = tf.defaultTextFormat;
			dtf.color = style.statTextColor;
			tf.defaultTextFormat = dtf;
			tf.setTextFormat(dtf);
		}
	}

	private function hoverStat(statname:String, event:MouseEvent):void {
		var player:Player = CoC.instance.player;
		switch (event.type) {
			case MouseEvent.ROLL_OVER:
				var astat:IStat = player.statStore.findStat(statname);
				var isPositiveStat:Boolean = true;
				var bar:StatBar = event.target as StatBar;
				if (astat is BuffableStat) {
					var stat:BuffableStat = astat as BuffableStat;
					if (!stat) return;
					if (!bar) return;
					if (statname == "sens" || statname == "cor" || statname == "minlust") isPositiveStat = false;
					if (statname == "minlust") {
						var lustValue:String = (CoC.instance.flags[kFLAGS.LUST_STATBAR_PERCENTAGE])? "Lust: " +
							 Utils.formatNumber(Math.floor(player.lust)) + (bar.showMax ? '/' + Utils.formatNumber(player.maxLust()) : '') + "\n": "";
						var text:String = lustValue + StatUtils.describeBuffs(stat, false, isPositiveStat);
						player.listMinLustMultiBuffs();
						text += StatUtils.describeBuffs(player.minLustXStat, true, isPositiveStat);
						CoC.instance.mainView.toolTipView.showForElement(
								bar,
								bar.statName,
								text);
					}
					else {
						CoC.instance.mainView.toolTipView.showForElement(
								bar,
								bar.statName,
								StatUtils.describeBuffs(stat, false, isPositiveStat));
					}
				} else if (astat is PrimaryStat) {
					var primStat:PrimaryStat = astat as PrimaryStat;
					if (!primStat) return;
					if (statname == "sens" || statname == "cor") isPositiveStat = false;
					var s:String = "Core: "+primStat.core.value+"/"+primStat.core.max+". ";
					s += "Training: "+primStat.train.value+"/"+primStat.train.max+". ";
					if (statname == "tou" && (player.hasPerk(PerkLib.IcyFlesh) || player.hasPerk(PerkLib.HaltedVitals))) {
						s += "\nYou are currently in a state of undeath and cannot benefit from bonus to toughness.";
					} else {
						s += "\n" +
								"" + StatUtils.describeBuffs(primStat.bonus, false, isPositiveStat) + "" +
								"" + StatUtils.describeBuffs(primStat.mult, true, isPositiveStat) + "";
					}
					CoC.instance.mainView.toolTipView.showForElement(bar,bar.statName,s);
				} else if (statname == "hp") {
					if (!bar) return;
					if (!CoC.instance.flags[kFLAGS.HP_STATBAR_PERCENTAGE]) return;
					var hpText:String = "HP: " + Utils.formatNumber(Math.floor(player.HP)) + (bar.showMax ? '/' + Utils.formatNumber(player.maxHP()) : '');
					CoC.instance.mainView.toolTipView.showForElement(bar,bar.statName,hpText);
				} else if (statname == "wrath") {
					if (!bar) return;
					if (!CoC.instance.flags[kFLAGS.WRATH_STATBAR_PERCENTAGE]) return;
					var wrathText:String = "Wrath: " + Utils.formatNumber(Math.floor(player.wrath)) + (bar.showMax ? '/' + Utils.formatNumber(player.maxWrath()) : '');
					CoC.instance.mainView.toolTipView.showForElement(bar,bar.statName,wrathText);
				}
				break;
			case MouseEvent.ROLL_OUT:
				CoC.instance.mainView.toolTipView.hide();
				if (statname == "minlust") {
					player.minLustStat.removeCombatRoundTrackingBuffs();
					player.minLustXStat.removeCombatRoundTrackingBuffs();
				}
				break;
		}
	}
}
}
