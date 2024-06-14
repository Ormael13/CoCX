/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.Items.*;

import coc.view.ButtonDataList;

public class DianaFollower extends NPCAwareContent
	{

/*
public function aaa():void {
	
}

public function aaa():void {
	
}

public function aaa():void {
	
}

public function aaa():void {
	
}

public function aaa():void {
	
}

public function aaa():void {
	
}

public function aaa():void {
	
}*/
public function uncurseCost(item:IDynamicItem, equipped:Boolean):int {
	var cost:int = 250 * (1 + item.rarity);
	if (equipped) cost *= 2;
	return cost;
}
public function dianaAtJttECursedItemsRemoval1():void {
	clearOutput();
	outputText("Uncurse which item?");
	var buttons:ButtonDataList = new ButtonDataList();
	var cost:int;
	for each (var slot:ItemSlotClass in player.carriedKnownCursedItems()) {
		cost = uncurseCost(slot.itype as IDynamicItem, false);
		buttons.add(slot.itype.shortName, curry(uncurseItem, slot))
				.hint("Lift the curse from "+slot.itype.longName+" ("+cost+" gems)")
				.disableIf(player.gems < cost, "Not enough gems ("+cost+")")
	}
	for each (var item:ItemType in player.equippedKnownCursedItems()) {
		cost = uncurseCost(item as IDynamicItem, true);
		buttons.add(item.shortName, curry(uncurseEquippedItem,item))
				.hint("Lift the curse from "+item.longName+" ("+cost+" gems)")
				.disableIf(player.gems < cost, "Not enough gems ("+cost+")")
	}
	submenu(buttons, SceneLib.journeyToTheEast.dianaAtJttEMain, 0, false);
}
public function uncurseItem(slot:ItemSlotClass):void {
	clearOutput();
	var newItem:ItemType = (slot.itype as IDynamicItem).uncursedCopy();
	outputText("The curse is lifted from "+slot.itype.longName);
	slot.setItemAndQty(newItem, slot.quantity);
	doNext(SceneLib.journeyToTheEast.dianaAtJttEMain);
}
public function uncurseEquippedItem(item:ItemType):void {
	clearOutput();
	var newItem:ItemType = (item as IDynamicItem).uncursedCopy();
	player.replaceEquipment(item as Equipable, newItem as Equipable);
	outputText("The curse is lifted from "+newItem.longName+". You can unequip it now.");
	doNext(SceneLib.journeyToTheEast.dianaAtJttEMain);
}
public function dianaAtJttECursedItemsRemoval2():void {
	clearOutput();
	outputText("As horse healer proceed with the purification ritual you struggle in pain at first as you feel the cursed weapon in your hand resist the unbinding before release washes over you as your grip opens dropping the malevolent item on the ground. ");
	outputText("Horse healer wrap the item in blessed cloth in order to seal its malice before handing you the neutralized cursed item back. Sure you can equip it again anytime but now you know the risks.\n\n");
	player.gems -= 500;
	player.removeStatusEffect(StatusEffects.TookSagittariusBanefulGreatBow);
	player.createStatusEffect(StatusEffects.TookSagittariusBanefulGreatBow,1,0,0,0);
	if (player.statStore.hasBuff('Sagittarius Curse')) player.buff("Sagittarius Curse").remove();
	if (player.statStore.hasBuff('Sagittarius Focus')) player.buff("Sagittarius Focus").remove();
	player.unequipWeaponRange(false,true);
	inventory.takeItem(weaponsrange.SAGITTB, SceneLib.journeyToTheEast.dianaAtJttEMain);
}
	}
}
//