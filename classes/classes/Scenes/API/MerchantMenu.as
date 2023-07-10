package classes.Scenes.API {
import classes.BaseContent;
import classes.ItemSlotClass;
import classes.ItemType;

import coc.view.Block;
import coc.view.CoCButton;

public class MerchantMenu extends BaseContent {
	public var items:/*MerchantItem*/Array = [];
	/**
	 * Player can sell items to this merchant
	 */
	public var playerCanSell:Boolean       = false;
	/**
	 * Buy items from player for (item value) * (sell factor) gems
	 */
	public var playerSellFactor:Number     = 0.5;
	/**
	 * Function `function(itype:ItemType):Boolean` to check if player can sell item.
	 *
	 * null - player can sell any item (if playerCanSell is true).
	 */
	public var playerSellFilter:Function = null;
	/**
	 * Default price = item value * price factor
	 */
	public var priceFactor:Number          = 1.0;
	/**
	 * `function(itype:ItemType, quantity:int, next:Function):void`
	 *
	 * Called after player purchases an item.
	 *
	 * To return to merchant interface, this function should call `next();`
	 */
	public var afterPurchase:Function = null;
	/**
	 * `function(itype:ItemType, quantity:int, slotIndex:int, next:Function):void`.
	 *
	 * Called after player sells an item.
	 *
	 * To return to merchant interface, this function should call `next();`
	 */
	public var afterPlayerSell:Function = null;
	/**
	 * `function(delta:int):void`
	 */
	public var modCurrencyFn:Function;
	/**
	 * `function():int`
	 */
	public var getCurrencyFn:Function;
	/**
	 * `function():void`
	 *
	 * Called after merchant interface is displayed. Can be used to add extra buttons.
	 */
	public var onShow:Function = null;
	/**
	 * Show [Inventory] button.
	 */
	public var canInventory:Boolean = true;
	
	private var grid:Block;
	private var backButton:Function                   = camp.returnToCampUseOneHour;
	private var playerInvButtons:/*CoCButton*/Array   = [];
	private var playerPage:int                        = 0;
	private var playerItemsPerPage:int                = 25;
	private var playerPageMax:int                     = 0;
	private var merchantInvButtons:/*CoCButton*/Array = [];
	private var merchantPage:int                      = 0;
	private var merchantItemsPerPage:int              = 25;
	private var merchantPageMax:int                   = 0;
	
	public function MerchantMenu() {
		useGemCurrency();
	}
	
	public function useGemCurrency():void {
		modCurrencyFn = function(delta:int):void {
			player.gems += delta;
			statScreenRefresh();
		}
		getCurrencyFn = function():int { return player.gems }
	}
	
	public function addItem(
			item:ItemType,
			price:int  = -1,
			amount:int = -1
	):MerchantItem {
		if (price == -1) price = Math.ceil(item.value * priceFactor);
		var mi:MerchantItem = new MerchantItem(this, item, price, amount);
		this.items.push(mi);
		return mi;
	}
	/**
	 * Add an empty (invisible) slot
	 */
	public function addSpacer():void {
		addItem(ItemType.NOTHING);
	}
	/**
	 * Add empty slots to ensure that next item will start on new line
	 */
	public function addLineBreak():void {
		while (items.length % 5 > 0) addSpacer();
	}
	
	public function merchantItemClick(mi:MerchantItem):void {
		var amount:int = 1;
		if (shiftKeyDown) {
			amount = mi._item.stackSize;
			if (mi._amount >= 0) amount = Math.min(amount, mi._amount);
			amount = Math.min(amount, Math.max(1, player.roomForItem(mi._item)));
		}
		modCurrencyFn(-mi._price*amount);
		if (mi._amount >= 0) mi._amount -= amount;
		var n:int = amount;
		var redraw:Boolean = false;
		function addOneItem():void {
			while (n-- > 0) {
				if (inventory.tryAddItemToPlayer(mi._item) == 0) {
					clearOutput();
					inventory.takeItem(mi._item, addOneItem);
					return;
				}
			}
			if (afterPurchase != null) {
				redraw = true;
				afterPurchase(mi._item, amount, curry(addOneItem));
			} else {
				if (redraw) showScreen();
				else update();
			}
		}
		addOneItem();
	}
	public function playerItemClick(i:int):void {
		sellPlayerItem(i, shiftKeyDown ? -1 : 1);
	}
	public function sellPlayerItem(slotIndex:int, quantity:int):void {
		var itemSlot:ItemSlotClass = player.itemSlot(slotIndex);
		var itype:ItemType         = itemSlot.itype;
		if (itemSlot.isEmpty() || !canSell(itype)) return;
		if (quantity < 0) quantity = itemSlot.quantity;
		if (quantity > itemSlot.quantity) quantity = itemSlot.quantity;
		if (quantity == 0) return;
		var value:Number = sellPrice(itype) * quantity;
		modCurrencyFn(+value);
		itemSlot.quantity -= quantity;
		update();
		if (afterPlayerSell != null) afterPlayerSell(itype, quantity, slotIndex, showScreen);
	}
	public function sellAllClick():void {
		for (var i:int = 0; i < player.itemSlotCount(); i++) {
			if (player.itemSlot(i).unlocked) {
				sellPlayerItem(i, -1);
				if (mainView.getCustomElement() != grid) {
					// If afterPlayerSell callback displayed own interface, halt
					return;
				}
			}
		}
	}
	public function canSell(itype:ItemType):Boolean {
		return playerCanSell && !itype.isNothing && (playerSellFilter == null || playerSellFilter(itype));
	}
	public function sellPrice(itype:ItemType):int {
		return Math.floor(itype.value * playerSellFactor);
	}
	
	public function update():void {
		var i:int, j:int, n:int;
		j = playerPage * playerItemsPerPage;
		n = player.itemSlotCount();
		for (i = 0; i < playerInvButtons.length; i++, j++) {
			if (j < n) {
				var itemSlot:ItemSlotClass = player.itemSlot(j);
				playerInvButtons[i].showForItemSlot(itemSlot, curry(playerItemClick, j))
								   .disableIf(!playerCanSell);
				if (canSell(itemSlot.itype)) playerInvButtons[i].toolTipText += "\nSell price: " + sellPrice(itemSlot.itype);
			} else {
				playerInvButtons[i].hide();
			}
		}
		j = merchantPage * merchantItemsPerPage;
		for (i = 0; i < merchantInvButtons.length; i++, j++) {
			if (items[j]) items[j].applyToButton(merchantInvButtons[i]);
			else merchantInvButtons[i].hide();
		}
		statScreenRefresh();
	}
	
	public function show(backButton:Function):void {
		this.backButton = backButton;
		flushOutputTextToGUI();
		show0();
	}
	private function showScreen():void {
		clearOutput();
		show0();
	}
	private function show0():void {
		grid = new Block({
			layoutConfig: {
				type: "grid",
				cols: 5
			}
		});
		var i:int, n:int;
		var btn:CoCButton;
		// 5 rows: player inventory
		// 1 row : player inventory pages
		// 1 row : spacer
		// 5 rows: merchant
		// 1 row : merchant pages
		n                       = 0;
		var playerItemCount:int = player.itemSlotCount();
		var playerItemRows:int  = Math.min(5, Math.ceil(playerItemCount / 5));
		playerPage              = 0;
		playerPageMax           = Math.ceil(playerItemCount / playerItemRows / 5);
		playerItemsPerPage      = playerItemRows * 5;
		playerInvButtons = [];
		if (playerItemCount > 0) {
			grid.addTextField({
				htmlText         : "Your inventory: " + (playerCanSell ? " <i>(Click ot sell)</i>" : ""),
				defaultTextFormat: mainView.mainText.defaultTextFormat
			}, {colspan: 5})
		}
		for (i = 0; i < playerItemRows * 5; i++) {
			btn = mainView.createActionButton(i);
			grid.addElement(btn);
			playerInvButtons.push(btn);
		}
		if (playerPageMax > 0) {
			// todo @aimozg player inventory pagination
		}
		var merchantItemCount:int = items.length;
		var merchantItemRows:int  = Math.min(5, Math.ceil(merchantItemCount / 5));
		merchantPage              = 0;
		merchantPageMax           = Math.ceil(merchantItemCount / merchantItemRows / 5);
		merchantItemsPerPage      = merchantItemRows * 5;
		merchantInvButtons = [];
		if (merchantItemCount > 0) {
			grid.addTextField({
				htmlText         : "Merchant inventory: <i>(Click to buy)</i>",
				defaultTextFormat: mainView.mainText.defaultTextFormat
			}, {colspan: 5})
		}
		for (i = 0; i < merchantItemRows * 5; i++) {
			btn = mainView.createActionButton(i);
			grid.addElement(btn);
			merchantInvButtons.push(btn);
		}
		if (playerPageMax > 0) {
			// todo @aimozg merchant inventory pagination
		}
		update();
		
		mainView.setCustomElement(grid, true, true);
		grid.doLayout();
		menu();
		if (playerCanSell) button(0).show("Sell All", sellAllClick);
		if (canInventory) button(2).show("Inventory", curry(inventory.showInventoryMenu, showScreen));
		button(14).show( "Back", backButton).icon("Back");
		if (onShow != null) onShow();
	}
}
}


