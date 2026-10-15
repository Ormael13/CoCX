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
		if ((player.perkv2(PerkLib.JobHaruspex) - (5 * SceneLib.campMakeWinions.maxSkeletonMulti())) > (SceneLib.campMakeWinions.maxSkeletonWarriors() * SceneLib.campMakeWinions.maxSkeletonMulti())) {
			player.addPerkValue(PerkLib.JobHaruspex, 2, -(5 * SceneLib.campMakeWinions.maxSkeletonMulti()));
			player.addPerkValue(PerkLib.JobHaruspex, 1, (5 * SceneLib.campMakeWinions.bonesUsedToMakeNormalSkeleton() * SceneLib.campMakeWinions.maxSkeletonMulti()));
		}
		if ((player.perkv1(PerkLib.BoneyBow) - (5 * SceneLib.campMakeWinions.maxSkeletonMulti())) > (SceneLib.campMakeWinions.maxSkeletonArchers() * SceneLib.campMakeWinions.maxSkeletonMulti())) {
			player.addPerkValue(PerkLib.BoneyBow, 1, -(5 * SceneLib.campMakeWinions.maxSkeletonMulti()));
			player.addPerkValue(PerkLib.JobHaruspex, 1, (5 * SceneLib.campMakeWinions.bonesUsedToMakeNormalSkeleton() * SceneLib.campMakeWinions.maxSkeletonMulti()));
		}
		if ((player.perkv1(PerkLib.BoneyWand) - (5 * SceneLib.campMakeWinions.maxSkeletonMulti())) > (SceneLib.campMakeWinions.maxSkeletonMages() * SceneLib.campMakeWinions.maxSkeletonMulti())) {
			player.addPerkValue(PerkLib.BoneyWand, 1, -(5 * SceneLib.campMakeWinions.maxSkeletonMulti()));
			player.addPerkValue(PerkLib.JobHaruspex, 1, (5 * SceneLib.campMakeWinions.bonesUsedToMakeNormalSkeleton() * SceneLib.campMakeWinions.maxSkeletonMulti()));
		}
		if ((player.perkv1(PerkLib.BoneGiants) - SceneLib.campMakeWinions.maxSkeletonMulti()) > (SceneLib.campMakeWinions.maxSkeletonGiants() * SceneLib.campMakeWinions.maxSkeletonMulti())) {
			player.addPerkValue(PerkLib.BoneGiants, 1, -SceneLib.campMakeWinions.maxSkeletonMulti());
			player.addPerkValue(PerkLib.JobHaruspex, 1, (SceneLib.campMakeWinions.bonesUsedToMakeLargeSkeleton() * SceneLib.campMakeWinions.maxSkeletonMulti()));
		}
		if ((player.perkv1(PerkLib.BoneBallistaSkelies) - SceneLib.campMakeWinions.maxSkeletonMulti()) > (SceneLib.campMakeWinions.maxBoneBallistaSkeletons() * SceneLib.campMakeWinions.maxSkeletonMulti())) {
			player.addPerkValue(PerkLib.BoneBallistaSkelies, 1, -SceneLib.campMakeWinions.maxSkeletonMulti());
			player.addPerkValue(PerkLib.JobHaruspex, 1, (SceneLib.campMakeWinions.bonesUsedToMakeLargeSkeleton() * SceneLib.campMakeWinions.maxSkeletonMulti()));
		}
		if ((player.perkv1(PerkLib.GigachadSkeletalMages) - SceneLib.campMakeWinions.maxSkeletonMulti()) > (SceneLib.campMakeWinions.maxSkeletonGigachadMages() * SceneLib.campMakeWinions.maxSkeletonMulti())) {
			player.addPerkValue(PerkLib.GigachadSkeletalMages, 1, -SceneLib.campMakeWinions.maxSkeletonMulti());
			player.addPerkValue(PerkLib.JobHaruspex, 1, (SceneLib.campMakeWinions.bonesUsedToMakeLargeSkeleton() * SceneLib.campMakeWinions.maxSkeletonMulti()));
		}
	} else if (count == 1) {
		player.removeStatusEffect(StatusEffects.BonusEffectsNecroSet);// 2 -> 1, remove 2 item bonus
		if ((player.perkv2(PerkLib.JobHaruspex) - (2 * SceneLib.campMakeWinions.maxSkeletonMulti())) > (SceneLib.campMakeWinions.maxSkeletonWarriors() * SceneLib.campMakeWinions.maxSkeletonMulti())) {
			player.addPerkValue(PerkLib.JobHaruspex, 2, -(2 * SceneLib.campMakeWinions.maxSkeletonMulti()));
			player.addPerkValue(PerkLib.JobHaruspex, 1, (2 * SceneLib.campMakeWinions.bonesUsedToMakeNormalSkeleton() * SceneLib.campMakeWinions.maxSkeletonMulti()));
		}
		if ((player.perkv1(PerkLib.BoneyBow) - (2 * SceneLib.campMakeWinions.maxSkeletonMulti())) > (SceneLib.campMakeWinions.maxSkeletonArchers() * SceneLib.campMakeWinions.maxSkeletonMulti())) {
			player.addPerkValue(PerkLib.BoneyBow, 1, -(2 * SceneLib.campMakeWinions.maxSkeletonMulti()));
			player.addPerkValue(PerkLib.JobHaruspex, 1, (2 * SceneLib.campMakeWinions.bonesUsedToMakeNormalSkeleton() * SceneLib.campMakeWinions.maxSkeletonMulti()));
		}
		if ((player.perkv1(PerkLib.BoneyWand) - (2 * SceneLib.campMakeWinions.maxSkeletonMulti())) > (SceneLib.campMakeWinions.maxSkeletonMages() * SceneLib.campMakeWinions.maxSkeletonMulti())) {
			player.addPerkValue(PerkLib.BoneyWand, 1, -(2 * SceneLib.campMakeWinions.maxSkeletonMulti()));
			player.addPerkValue(PerkLib.JobHaruspex, 1, (2 * SceneLib.campMakeWinions.bonesUsedToMakeNormalSkeleton() * SceneLib.campMakeWinions.maxSkeletonMulti()));
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

public function equippedTamerSetItems():int {
	var eTSI:int = 0;
	if (player.jewelry1 == jewelries.RINGOTAM || player.jewelry2 == jewelries.RINGOTAM || player.jewelry3 == jewelries.RINGOTAM || player.jewelry4 == jewelries.RINGOTAM) eTSI++;
	if (player.jewelry1 == jewelries.RINGOTAM) eTSI++;
	return eTSI;
}
public function equipTamerItemsSet():void {
	var count:int = equippedTamerSetItems();
	if (count == 2) player.createStatusEffect(StatusEffects.BonusEffectsTamerSet, 0, 0, 0, 0);
}
public function unequipTamerItemsSet():void {
	var count:int = equippedTamerSetItems();
	if (count == 1) player.removeStatusEffect(StatusEffects.BonusEffectsTamerSet);
}/*

public function equippedUndefeatedKingSetItems():int {
	var eUKSI:int = 0;
	if (player.isUdefeatedKingSignetEquipped()) eUKSI++;
	if (player.headJewelry == headjewelries.CUNDKIN) eUKSI++;
	if (player.weapon == weapons.UDKDEST || player.weaponOff == weapons.UDKDEST) eNSI++;
	return eToLSI;
}
public function equipUndefeatedKingItemsSet():void {
	var count:int = equippedUndefeatedKingSetItems();
	if (count == 2) player.createStatusEffect(StatusEffects.BonusEffectsUndefeatedKingSet, 0, 0, 0, 0);
}
public function unequipUndefeatedKingItemsSet():void {
	var count:int = equippedUndefeatedKingSetItems();
	if (count == 1) player.removeStatusEffect(StatusEffects.BonusEffectsUndefeatedKingSet);
}*/

}
}