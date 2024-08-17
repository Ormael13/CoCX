/**
 * ...
 * @author Ormael
 */
package classes.Items 
{
	import classes.BaseContent;
	import classes.PerkLib;
	import classes.Player;
	import classes.StatusEffects;
	import classes.Scenes.SceneLib;
	
	public class ItemSetChecks extends BaseContent
	{
		
		public function ItemSetChecks() 
		{}

public function equippedNecroSetItems():int {
	var eNSI:int = 0;
	if (player.weapon == weapons.NECROWA) eNSI++;
	if (player.shield == shields.NECROSH) eNSI++;
	if (player.necklace == necklaces.NECRONE) eNSI++;
	return eNSI;
}
public function equipNecroItemsSet():void {
	var count:int = equippedNecroSetItems();
	if (count == 3) {
		player.addStatusValue(StatusEffects.BonusEffectsNecroSet, 1, 5);// 2 -> 3, give 3 item bonus
		player.addStatusValue(StatusEffects.BonusEffectsNecroSet, 2, 3);
		player.addStatusValue(StatusEffects.BonusEffectsNecroSet, 3, 1);
	} else if (count == 2) {
		player.createStatusEffect(StatusEffects.BonusEffectsNecroSet, 2, 1, 0, 0);// 1 -> 2, give 2 item bonus
	}
}
public function unequipNecroItemsSet():void {
	var count:int = equippedNecroSetItems();
	if (count == 2) {
		player.addStatusValue(StatusEffects.BonusEffectsNecroSet, 1, -5);// 3 -> 2, remove 3 item bonus
		player.addStatusValue(StatusEffects.BonusEffectsNecroSet, 2, -3);
		player.addStatusValue(StatusEffects.BonusEffectsNecroSet, 3, -1);
		if ((player.perkv2(PerkLib.PrestigeJobNecromancer) - 5) > SceneLib.campMakeWinions.maxSkeletonWarriors()) {
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 2, -5);
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, 100);
		}
		if ((player.perkv1(PerkLib.GreaterHarvest) - 5) > SceneLib.campMakeWinions.maxSkeletonArchers()) {
			player.addPerkValue(PerkLib.GreaterHarvest, 1, -5);
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, 100);
		}
		if ((player.perkv2(PerkLib.GreaterHarvest) - 5) > SceneLib.campMakeWinions.maxSkeletonMages()) {
			player.addPerkValue(PerkLib.GreaterHarvest, 2, -5);
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, 100);
		}
	} else if (count == 1) {
		player.removeStatusEffect(StatusEffects.BonusEffectsNecroSet);// 2 -> 1, remove 2 item bonus
		if ((player.perkv2(PerkLib.PrestigeJobNecromancer) - 2) > SceneLib.campMakeWinions.maxSkeletonWarriors()) {
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 2, -2);
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, 40);
		}
		if ((player.perkv1(PerkLib.GreaterHarvest) - 2) > SceneLib.campMakeWinions.maxSkeletonArchers()) {
			player.addPerkValue(PerkLib.GreaterHarvest, 1, -2);
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, 40);
		}
		if ((player.perkv2(PerkLib.GreaterHarvest) - 2) > SceneLib.campMakeWinions.maxSkeletonMages()) {
			player.addPerkValue(PerkLib.GreaterHarvest, 2, -2);
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, 40);
		}
	}
}

public function equippedBestialBlademasterSetItems():int {
	var eBBSI:int = 0;
	if (player.armor == armors.BESTBLA) eBBSI++;
	if (player.headJewelry == headjewelries.BESTBLAA) eBBSI++;
	return eBBSI;
}
public function equipBestialBlademasterItemsSet():void {
	var count:int = equippedBestialBlademasterSetItems();
	if (count == 2) player.createPerk(PerkLib.BestialBlademaster, 0, 0, 0, 0);
}
public function unequipBestialBlademasterItemsSet():void {
	var count:int = equippedBestialBlademasterSetItems();
	if (count == 1) player.removePerk(PerkLib.BestialBlademaster);
}

public function equippedSkullSetItems():int {
	var eSSI:int = 0;
	if (player.necklace == necklaces.SKULLNE) eSSI++;
	if (player.headJewelry == headjewelries.SKULLCR) eSSI++;
	return eSSI;
}
public function equipSkullItemsSet():void {
	var count:int = equippedSkullSetItems();
	if (count == 2) player.createStatusEffect(StatusEffects.BonusEffectsSkullSet, 0, 0, 0, 0);
}
public function unequipSkullItemsSet():void {
	var count:int = equippedSkullSetItems();
	if (count == 1) player.removeStatusEffect(StatusEffects.BonusEffectsSkullSet);
}

public function equippedTreeOfLifeSetItems():int {
	var eToLSI:int = 0;
	if (player.necklace == necklaces.TREELNE) eToLSI++;
	if (player.headJewelry == headjewelries.TREELCR) eToLSI++;
	return eToLSI;
}
public function equipTreeOfLifeItemsSet():void {
	var count:int = equippedTreeOfLifeSetItems();
	if (count == 2) player.createStatusEffect(StatusEffects.BonusEffectsTreeOfLifeSet, 0, 0, 0, 0);
}
public function unequipTreeOfLifeItemsSet():void {
	var count:int = equippedTreeOfLifeSetItems();
	if (count == 1) player.removeStatusEffect(StatusEffects.BonusEffectsTreeOfLifeSet);
}

}
}