/**
 * Coded by aimozg on 29.09.2017.
 */
package coc.view {
public class ButtonData {
	public var text:String = "";
	public var callback:Function = null;
	public var enabled:Boolean = false;
	public var visible:Boolean = true;
	public var toolTipHeader:String = "";
	public var toolTipText:String = "";
	public function ButtonData(text:String, callback:Function =null, toolTipText:String ="", toolTipHeader:String ="") {
		this.text = text;
		this.callback = callback;
		this.enabled = callback != null;
		this.toolTipText = toolTipText;
		this.toolTipHeader = toolTipHeader;
	}
	public function hint(toolTipText:String,toolTipHeader:String=""):ButtonData {
		this.toolTipText = toolTipText;
		this.toolTipHeader = toolTipHeader;
		return this;
	}
	public function enable(callback:Function,toolTipText:String=null,toolTipHeader:String=null):ButtonData {
		this.callback = callback;
		this.enabled = callback != null;
		if (toolTipText is String) this.toolTipText = toolTipText;
		if (toolTipHeader is String) this.toolTipHeader = toolTipHeader;
		return this;
	}
	public function disable(toolTipText:String=null,toolTipHeader:String=null):ButtonData {
		this.enabled = false;
		if (toolTipText is String) this.toolTipText = toolTipText;
		if (toolTipHeader is String) this.toolTipHeader = toolTipHeader;
		return this;
	}
	public function applyTo(btn:CoCButton):void {
		if (!visible) {
			btn.hide();
		} else if (!enabled) {
			btn.showDisabled(text, toolTipText, toolTipHeader);
		} else {
			btn.show(text, callback, toolTipText, toolTipHeader);
		}
	}
}
}
