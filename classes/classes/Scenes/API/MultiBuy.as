package classes.Scenes.API {

import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.ItemType;
import classes.Player;



public class MultiBuy extends BaseContent {
	private static var utils:MultiBuy = new MultiBuy();
	private static function debitItemMulti(returnFunc:Function,shopKeep:String,priceRate:Number,itype:ItemType,onBuy:String, useStones:Boolean=false, currentQuantity:int=1):void {
	var wallet:int;
	var costPerItem:int;
	var debitFunction:Function;
	var paymentMethod:String = useStones? "spirit stones": "gems";

	if (useStones) {
		wallet = flags[kFLAGS.SPIRIT_STONES];
		costPerItem = itype.value / priceRate;
		debitFunction = function (cost:int):void {
			flags[kFLAGS.SPIRIT_STONES] -= cost;
		};
	} else {
		wallet = player.gems;
		costPerItem = itype.value * priceRate;
		debitFunction = function (cost:int):void {
			player.gems -= cost;
		};
	}

	var value:int = costPerItem * currentQuantity;

	if (wallet < value) {
		clearOutput();
		outputText("\n\n"+shopKeep+" shakes their head, indicating you need " + String(value - wallet) + " more " + paymentMethod + " to purchase this item.");
		utils.doNext(returnFunc);
	} else {
		debitFunction(value);
		outputText(onBuy);
		var amountDeposited:int = utils.inventory.tryAddMultipleItemsToPlayer(itype, currentQuantity);
		outputText("You place " + amountDeposited + " of them in your bag, leaving you with " + player.itemCount(itype) + " of them.");

		if(amountDeposited < currentQuantity) {
			var amountToRefund:int = (currentQuantity - amountDeposited) * costPerItem;
			debitFunction(-amountToRefund);
		}
		utils.doNext(returnFunc);
		utils.statScreenRefresh();
	}
}

private static function confirmPurchase(returnFunc:Function,shopKeep:String,priceRate:Number,itype:ItemType,descString:String,onBuy:String, useStones:Boolean=false, currentQuantity:int=1):void {
	clearOutput();
	outputText("Are you sure you want to buy " + currentQuantity + " of " + itype.longName + "?\n");
	utils.doYesNo(curry(debitItemMulti, returnFunc, shopKeep, priceRate, itype, onBuy, useStones, currentQuantity),
		curry(confirmBuyMulti, returnFunc, shopKeep, priceRate, itype, descString, onBuy, useStones, currentQuantity));
}


public static function confirmBuyMulti(returnFunc:Function,shopKeep:String,priceRate:Number,itype:ItemType,descString:String,onBuyString:String="\n", useStones:Boolean=false, currentQuantity:int=1):void{
	clearOutput();

	var costPerItem:int = (useStones)? itype.value / priceRate: itype.value * priceRate;
	var wallet:int = (useStones)? flags[kFLAGS.SPIRIT_STONES]: player.gems;

	var roomLeftInBag:int = player.roomForItem(itype);
	var maxBuy:int = Math.floor(wallet / costPerItem);
	var maxQuanity:int = Math.min(roomLeftInBag, maxBuy);
	var paymentMethod:String = (useStones)? "spirit stones" : "gems";
	

	if (currentQuantity < 1) {
		currentQuantity = 1;
	}
	if (currentQuantity > maxQuanity){
		currentQuantity = maxQuanity;
	}

	outputText(descString);
	outputText("\n\n");
	outputText("Currently buying: " + itype.longName + "\n");
	outputText("Maximum amount: " + maxQuanity + "\n");
	outputText("Quanity: " + currentQuantity + "\n");
	if (maxBuy != 0) {
		outputText("Cost: " + String(costPerItem * currentQuantity) + " " + paymentMethod + "\n");
	} else {
		outputText("This item costs " + String(costPerItem) + " " + paymentMethod + ".\n");
		outputText("You need " + String(costPerItem - wallet) + " more " + paymentMethod + " to buy this item.\n");
	}

	menu();
	utils.addButton(0, "Subtract 1", curry(confirmBuyMulti,returnFunc, shopKeep, priceRate, itype, descString, onBuyString, useStones, currentQuantity - 1))
		.disableIf(currentQuantity <= 1, "Minimum Quantity reached");
	utils.addButton(1, "Add 1", curry(confirmBuyMulti,returnFunc, shopKeep, priceRate, itype, descString, onBuyString, useStones, currentQuantity + 1))
		.disableIf(currentQuantity == maxQuanity, "Maximum Quantity reached");
	utils.addButton(5, "Subtract 5", curry(confirmBuyMulti,returnFunc, shopKeep, priceRate, itype, descString, onBuyString, useStones, currentQuantity - 5))
		.disableIf(currentQuantity <= 1, "Minimum Quantity reached");
	utils.addButton(6, "Add 5", curry(confirmBuyMulti,returnFunc, shopKeep, priceRate, itype, descString, onBuyString, useStones, currentQuantity + 5))
		.disableIf(currentQuantity == maxQuanity, "Maximum Quantity reached");

	utils.addButton(4, "1", curry(confirmBuyMulti,returnFunc, shopKeep, priceRate, itype, descString, onBuyString, useStones, 1))
		.disableIf(currentQuantity <= 1, "Minimum Quantity reached");
	utils.addButton(9, "Max", curry(confirmBuyMulti,returnFunc, shopKeep, priceRate, itype, descString, onBuyString, useStones, maxQuanity))
		.disableIf(currentQuantity == maxQuanity, "Maximum Quantity reached");

	utils.addButton(13, "Buy", curry(confirmPurchase,returnFunc,shopKeep,priceRate,itype,descString, onBuyString, useStones, currentQuantity))
		.disableIf(roomLeftInBag == 0, "You have no space left in your bag")
		.disableIf(maxBuy == 0, "You do not have enough to buy this item");
	utils.addButton(14, "Return", returnFunc);
}
}
}