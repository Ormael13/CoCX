package coc.view {
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Player;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
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
	private var esteemBar:StatBar;
	private var willBar:StatBar;
	private var obeyBar:StatBar;

	private var allStats:Array;

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
		col1.addElement(touBar = new StatBar({statName: "Toughness:"}));
		col1.addElement(speBar = new StatBar({statName: "Speed:"}));
		col1.addElement(intBar = new StatBar({statName: "Intelligence:"}));
		col1.addElement(wisBar = new StatBar({statName: "Wisdom:"}));
		col1.addElement(libBar = new StatBar({statName: "Libido:"}));
		col1.addElement(senBar = new StatBar({statName: "Sensitivity:"}));
		col1.addElement(corBar = new StatBar({statName: "Corruption:"}));
		
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
		col2.addElement(lustBar = new StatBar({
			statName   : "Lust:",
		//	barColor   : '#ff1493',
			minBarColor: '#ff0000',
			hasMinBar  : true,
			showMax    : true
		}));
		col2.addElement(wrathBar = new StatBar({
			statName: "Wrath:",
			showMax : true
		}));
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
		col2.addElement(esteemBar = new StatBar({
			statName: "Self Esteem:",
			showMax : true
		}));
		col2.addElement(willBar = new StatBar({
			statName: "Willpower:",
			showMax : true
		}));
		col2.addElement(obeyBar = new StatBar({
			statName: "Obedience:",
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
			case 'will':
				return willBar;
			case 'esteem':
				return esteemBar;
			case 'obey':
				return obeyBar;
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
	public function toggleHungerBar(show:Boolean):void {
		hungerBar.visible = show;
		invalidateLayout();
	}
	public function refreshStats(game:CoC):void {
		var player:Player            = game.player;
		var maxes:Object      = player.getAllMaxStats();
		nameText.htmlText     = "<b>" + player.short + "</b>";
		strBar.maxValue       = maxes.str;
		strBar.value          = player.str;
		touBar.maxValue       = maxes.tou;
		touBar.value          = player.tou;
		speBar.maxValue       = maxes.spe;
		speBar.value          = player.spe;
		intBar.maxValue       = maxes.inte;
		intBar.value          = player.inte;
		wisBar.maxValue       = maxes.wis;
		wisBar.value          = player.wis;
		libBar.maxValue       = maxes.lib;
		libBar.value          = player.lib;
		senBar.maxValue       = maxes.sens;
		senBar.value          = player.sens;
		corBar.value          = player.cor;
		hpBar.maxValue        = player.maxHP();
		hpBar.value           = player.HP;
		wrathBar.maxValue 	  = player.maxWrath();
		wrathBar.value    	  = player.wrath;
		lustBar.maxValue      = player.maxLust();
		lustBar.minValue      = player.minLust();
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
		var inPrison:Boolean          = SceneLib.prison.inPrison;
		esteemBar.visible     		  = inPrison;
		willBar.visible      		  = inPrison;
		obeyBar.visible       		  = inPrison;
		corner.levelBar.visible      		  = !inPrison;
		corner.xpBar.visible         		  = !inPrison;
		corner.gemsBar.visible       		  = !inPrison;
		corner.spiritstonesBar.visible       = !inPrison;
		if (inPrison) {
			corner.advancementText.htmlText = "<b>Prison Stats</b>";
			esteemBar.maxValue       = 100;
			esteemBar.value          = player.esteem;
			willBar.maxValue         = 100;
			willBar.value            = player.will;
			obeyBar.maxValue         = 100;
			obeyBar.value            = player.obey;
		} else {
			corner.advancementText.htmlText = "<b>Advancement</b>";
			corner.levelBar.value           = player.level;
			if (player.level < CoC.instance.levelCap) {
				corner.xpBar.maxValue = player.requiredXP();
				corner.xpBar.value    = player.XP;
			} else {
				corner.xpBar.maxValue  = player.XP;
				corner.xpBar.value     = player.XP;
				corner.xpBar.valueText = 'MAX';
			}
			corner.gemsBar.valueText = Utils.addComma(Math.floor(player.gems));
			corner.spiritstonesBar.valueText = game.flags[kFLAGS.SPIRIT_STONES];
		}

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
		corner.timeText.htmlText = "<u>Day#: " + game.model.time.days + "</u>"+
						"\nTime: " + hrs + ":" + minutesDisplay + ampm;

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
		for each(var tf:TextField in [nameText,coreStatsText,combatStatsText,corner.advancementText,corner.timeText]) {
			dtf = tf.defaultTextFormat;
			dtf.color = style.statTextColor;
			tf.defaultTextFormat = dtf;
			tf.setTextFormat(dtf);
		}
	}
}
}