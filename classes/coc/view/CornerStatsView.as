/**
 * Coded by aimozg on 17.01.2020.
 */
package coc.view {
import flash.text.TextField;

public class CornerStatsView extends Block {
	internal var advancementText:TextField;
	internal var timeText:TextField;
	internal var levelBar:StatBar;
	internal var xpBar:StatBar;
	internal var gemsBar:StatBar;
	internal var spiritstonesBar:StatBar;
	internal var bg:BitmapDataSprite;
	public function CornerStatsView() {
		super({
			x: MainView.CORNERSTATS_X,
			width: MainView.CORNERSTATS_W,
			layoutConfig: {
				padding: MainView.HALFGAP,
				type: 'flow',
				direction: 'column',
				ignoreHidden: true,
				gap: 1
			}
		});
		bg     = addBitmapDataSprite({
			x:0,y:0,
			width: this.width,
			height: this.height,
			crop: true,
			borderColor: '#A37C17',
			borderWidth: 1,
			borderRadius: 2
		},{ ignore:true });
		advancementText = addTextField({
			text:'Advancement',
			defaultTextFormat: StatsView.LABEL_FORMAT
		},{before:1});
		addElement(levelBar = new StatBar({
			statName: "Level:",
			hasBar  : false
		}));
		addElement(xpBar = new StatBar({
			statName: "XP:"
		}));
		addElement(gemsBar = new StatBar({
			statName: "Gems:",
			hasBar: false
		}));
		addElement(spiritstonesBar = new StatBar({
			statName: "Spirit Stones:",
			hasBar: false
		}));
		timeText = addTextField({
			htmlText: '<u>Day#: 0</u>\nTime: 00:00',
			defaultTextFormat: StatsView.TIME_FORMAT
		},{before:1});
	}
	
	override public function doLayout():void {
		super.doLayout();
		this.y = MainView.CORNERSTATS_BOTTOM - this.height;
		bg.height = this.height;
	}
}
}
