/**
 * Coded by aimozg on 30.09.2017.
 */
package coc.view {
public class ButtonDataList {
	public var list:/*ButtonData*/Array = [];
	public function ButtonDataList() {
	}
	public function append(bd:ButtonData):void {
		list.push(bd);
	}
	public function add(text:String, callback:Function =null, toolTipText:String ="", toolTipHeader:String =""):ButtonData {
		var bd:ButtonData = new ButtonData(text,callback,toolTipText,toolTipHeader);
		list.push(bd);
		return bd;
	}
	public function get(index:int):ButtonData {
		return list[index];
	}
	public function clear():void {
		list.splice(0);
	}
	public function get length():int {
		return list.length;
	}
	public function get active():int {
		var activeBtns:int = 0;
		for each(var i:ButtonData in list) {
			if (i["enabled"]) activeBtns++;
		}
		return activeBtns;
	}
}
}
