/**
 * Coded by aimozg on 30.09.2017.
 */
package coc.view {
public class ButtonDataList {
	public var list:/*ButtonData*/Array = [];
	public function ButtonDataList() {
	}
	public function add(text:String, callback:Function =null, toolTipText:String ="", toolTipHeader:String =""):ButtonData {
		var bd:ButtonData = new ButtonData(text,callback,toolTipText,toolTipHeader);
		list.push(bd);
		return bd;
	}
	public function clear():void {
		list.splice(0);
	}
	public function get length():int {
		return list.length;
	}
}
}
