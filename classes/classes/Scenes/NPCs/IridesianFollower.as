/**
 * Multicolored angelic unicorn-gazer hybrid ^^
 * @author Ormael (for now)
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

	public class IridesianFollower extends NPCAwareContent
	{
		
		public function IridesianFollower() 
		{
			
		}

public function firstMeetingIridesian():void {
	clearOutput();
	outputText("As you wander the battlefield you hear nearby sounds of the battle. Walking into that direction you finds large group of imps battling lone person dressed into robe. From under the hood sticks out medium length single horn and throu holes on the back extends many pairs of tentacle-like appendixes.\n\n");
	outputText("\"<i>Begone foul creatures!!!</i>\" you can hear the sole figure yelling ocassionaly when another imp fell after one of back tentacles tips glowing for brief moment. In few minutes you spends watching it deals with most of remaining imps as the rest fleed in all directions. Then he turns his attnetion toward you.\n\n");
	outputText("\"<i>Another Tarnished One?</i>\" he speaks slowly until assuming combat posture. \"<i>Rip or Tear? What you choose?</i>\"\n\n");
	startCombat(new Iridesian());
	doNext(playerMenu);
}
public function firstMeetingIridesianVictory():void {
	
}
public function firstMeetingIridesianDefeat():void {
	
}
public function repeatMeetingIridesian():void {
	clearOutput();
	//outputText("\"<i></i>\"\n\n");
	//outputText("\"<i></i>\"\n\n");
}
/*
public function a():void {
	
}
public function b():void {
	
}
public function c():void {
	
}
public function IridesianMainCampMenu():void {
	
}

public function itemImproveMenuPure():void {
	var improvableItems:Array = [
		[weapons.BFSWORD, weapons.NPHBLDE, weapons.EBNYBLD],
		[weapons.DBFSWO, weapons.T_HEART, weapons.DORSOUL],
		[weapons.MASTGLO, weapons.KARMTOU, weapons.YAMARG],
		[weapons.KATANA, weapons.MASAMUN, weapons.BLETTER],
		[weapons.W_STAFF, weapons.U_STAFF, weapons.N_STAFF],
		[weapons.DEMSCYT, weapons.LHSCYTH, weapons.HELRAIS],
		[weapons.UGATANA, weapons.MOONLIT, weapons.C_BLADE],
		[weapons.L__AXE, weapons.WG_GAXE, weapons.DE_GAXE],
		[weapons.SPEAR, weapons.SESPEAR, weapons.DSSPEAR],
		[weapons.JRAPIER, weapons.Q_GUARD, weapons.B_WIDOW],
		[weapons.OTETSU, weapons.POCDEST, weapons.DOCDEST],
		[weapons.BFTHSWORD, weapons.ARMAGED, weapons.CHAOSEA],
		[weapons.A_WAND, weapons.OCCULUS, weapons.ECLIPSE],
		[weapons.PFLUTTE, weapons.ELYSIUM, weapons.HELLCAL],
		[weaponsrange.BOWLONG, weaponsrange.ARTEMIS, weaponsrange.WILDHUN],
		[weaponsrange.SHUNHAR, weaponsrange.KSLHARP, weaponsrange.LEVHARP],
		[weaponsrange.SIXSHOT, weaponsrange.GOODSAM, weaponsrange.BADOMEN],
		[shields.SANCTYN, shields.SANCTYL, shields.SANCTYD],
		[armors.LMARMOR, armors.BMARMOR, armors.S_ARMOR],
		[armors.BLKIMONO, armors.IBKIMO, armors.TCKIMO],
		[armors.BKIMONO, armors.IBKIMO, armors.TCKIMO],
		[armors.PKIMONO, armors.IBKIMO, armors.TCKIMO],
		[armors.RKIMONO, armors.IBKIMO, armors.TCKIMO],
		[armors.WKIMONO, armors.IBKIMO, armors.TCKIMO],
		[armors.SPKIMO, armors.OEKIMO, armors.OTKIMO],
		[armors.CTPALAD, armors.CTHPALA, armors.CTBGUAR],
		[armors.LTHRPNT, null, armors.CGUNSLI],
		[armors.DEATHPO, null, armors.DEATHPGA],
		[armors.B_QIPAO, armors.SFLAREQ, null],
		[armors.G_QIPAO, armors.SFLAREQ, null],
		[armors.P_QIPAO, armors.SFLAREQ, null],
		[armors.R_QIPAO, armors.SFLAREQ, null]
	];
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	outputText("\n\n<b>You currently have " + player.keyItemvX("Radiant shard", 1) + " radiant shards.</b>");
	var selectfrom:int = 1;
	var selectMenu:ButtonDataList = new ButtonDataList();
	for (var i:int = 0; i < improvableItems.length; i++) {
		if (improvableItems[i][selectfrom] == null) {/*do nothing*/
		/*}
		else {
			var item:ItemType = improvableItems[i][selectfrom];
			var from:ItemType = improvableItems[i][0];
			selectMenu.add(item.id, curry(improveItem, item, from)).disableIf(!player.hasItem(from),"You need "+from.longName+" as a base to create this item")
			.disableIf(player.keyItemvX("Radiant shard", 1) < 3,"You need at least three radiant shards in order to create this item.")
			.disableIf(player.gems < 20000,"You need at least 10 000 gems in order to create this item");
		}
	}
	submenu(selectMenu, IridesianMainCampMenu);
	
	function improveItem(item:ItemType, from:ItemType):void {
		clearOutput();
		outputText("\"<i></i>\"\n\n");
		if(player.keyItemvX("Radiant shard", 1) == 3) player.removeKeyItem("Radiant shard");
		else player.addKeyValue("Radiant shard",1,-3);
		player.gems -= 20000;
		player.destroyItems(from, 1);
		inventory.takeItem(item, camp.returnToCampUseOneHour);
	}
}*/
	}
}