package classes.Scenes.API {
import classes.ItemType;
import classes.internals.Utils;

import coc.view.CoCButton;

public class MerchantItem extends Utils {
	internal var _menu:MerchantMenu;
	internal var _item:ItemType;
	internal var _amount:int;
	internal var _price:int;
	internal var _hint:String         = "";
	internal var _disabled:Boolean    = false;
	internal var _disabledHint:String = null;
	internal var _hide:Boolean = false;
	
	public function MerchantItem(
			menu:MerchantMenu,
			item:ItemType,
			price:int,
			amount:int = -1
	):void {
		this._menu   = menu;
		this._item   = item;
		this._price  = price;
		this._amount = amount;
		this._hint   = item.description;
		if (_hint.match(/Base value: \d+/)) _hint = _hint.replace(/Base value: \d+/, "Price: " + _price);
		else _hint = _hint += "\nPrice: "+_price;
	}
	
	public function hint(toolTipText:String):MerchantItem {
		this._hint = toolTipText;
		return this;
	}
	
	public function applyToButton(button:CoCButton):void {
		if (_item.isNothing) {
			button.hide();
			return;
		}
		if (_hide) {
			button.showDisabled("???", _disabledHint);
			return;
		}
		
		button.showForItem(_item, curry(_menu.merchantItemClick, this));
		
		if (_amount >= 0) button.iconQty = String(_amount);
		button.toolTipText = _hint;
		if (_disabled) button.disable(_disabledHint ? _disabledHint + "\n" + button.toolTipText : null);
		else if (_amount == 0) button.disable("<b>Out of stock!</b>\n\n" + button.toolTipText);
		else if (_menu.getCurrencyFn() < _price) button.disable("<b>Can't afford!</b>\n\n" + button.toolTipText);
	}
	
	public function disableIf(condition:Boolean, tooltipHint:String = null, hide:Boolean = false):MerchantItem {
		if (!_disabled && condition) {
			_disabled = true;
			if (tooltipHint) _disabledHint = tooltipHint;
			_hide = true;
		}
		return this;
	}
}
}
