/**
 * Coded by aimozg on 27.09.2017.
 */
package classes.Scenes.Combat {
import classes.BodyParts.Arms;
import classes.BodyParts.Face;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.CoC_Settings;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Scenes.Areas.Beach.CancerAttack;
import classes.Scenes.Areas.Desert.SandTrap;
import classes.Scenes.Areas.Forest.Alraune;
import classes.Scenes.Areas.Forest.WoodElvesHuntingParty;
import classes.Scenes.Areas.HighMountains.Izumi;
import classes.Scenes.Dungeons.D3.DriderIncubus;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.D3.MinotaurKing;
import classes.Scenes.Dungeons.D3.SuccubusGardener;
import classes.Scenes.NPCs.Ceraph;
import classes.Scenes.NPCs.Tyrantia;
import classes.Scenes.NPCs.Yamata;
import classes.Scenes.SceneLib;
import classes.StatusEffectClass;
import classes.StatusEffects;

import coc.view.ButtonData;

import coc.view.ButtonDataList;
import coc.view.CoCButton;

public class CombatUI extends BaseCombatContent {

	public function CombatUI() {
	}

	private var magspButtons:ButtonDataList = new ButtonDataList();
	private var physpButtons:ButtonDataList = new ButtonDataList();
	private var spellBookButtons:ButtonDataList = new ButtonDataList();
	private var whiteSpellButtons:ButtonDataList = new ButtonDataList();
	private var blackSpellButtons:ButtonDataList = new ButtonDataList();
	private var greySpellButtons:ButtonDataList = new ButtonDataList();
	private var hexSpellButtons:ButtonDataList = new ButtonDataList();
	private var divineSpellButtons:ButtonDataList = new ButtonDataList();
	private var necroSpellButtons:ButtonDataList = new ButtonDataList();
	private var bloodSpellButtons:ButtonDataList = new ButtonDataList();
	private var soulforceButtons:ButtonDataList = new ButtonDataList();
	private var otherButtons:ButtonDataList = new ButtonDataList();
	public function mainMenu():void {
		menu();
		magspButtons.clear();
		physpButtons.clear();
		spellBookButtons.clear();
		whiteSpellButtons.clear();
		blackSpellButtons.clear();
		greySpellButtons.clear();
		hexSpellButtons.clear();
		divineSpellButtons.clear();
		necroSpellButtons.clear();
		bloodSpellButtons.clear();
		soulforceButtons.clear();
		otherButtons.clear();

		var btnMelee:CoCButton      = button(0);
		var btnRanged:CoCButton     = button(1);
		var btnTease:CoCButton      = button(2);
		var btnWait:CoCButton       = button(3);
		var btnItems:CoCButton      = button(4);
		var btnPSpecials:CoCButton  = button(5);
		var btnMSpecials:CoCButton  = button(6);
		var btnMagic:CoCButton      = button(7);
		var btnSoulskills:CoCButton = button(8);
		var btnOther:CoCButton      = button(9);
		var btnSpecial1:CoCButton   = button(10);
		var btnSpecial2:CoCButton   = button(11);
		var btnSpecial3:CoCButton   = button(12);
		var btnFantasize:CoCButton  = button(13);
		var btnRun:CoCButton        = button(14);
		/*
		 0 [ Melee ] [ Range ] [ Tease ] [  Wait   ] [ Items ]
		 5 ability groups
		10 [   ?   ] [   ?   ] [   ?   ] [Fantasize] [  Run  ]
		 */

		//Standard menu before modifications.
		if (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 2 || flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 4) {
			btnMelee.show("E.Attack", combat.baseelementalattacks, "Command your elemental to attack the enemy.  Damage it will deal is affected by your wisdom and intelligence.");
			if (combat.isEnnemyInvisible) btnMelee.disable("You cannot use command your elemental to attack an opponent you cannot see or target.");
		}
		else {/*
			btnMelee.show("Attack", combat.basemeleeattacks, "Attempt to attack the enemy with your "+player.weaponName+".  Damage done is determined by your strength and weapon.");
			if (!player.isFlying() && monster.isFlying() && !player.haveThrowableMeleeWeapon()) {
				btnMelee.disable("No way you could reach enemy in air with melee attacks.");
			} else if (player.isFlying() && !player.hasPerk(PerkLib.AerialCombat)) {
				if (!player.haveWeaponForJouster() && !player.haveThrowableMeleeWeapon()) {
					btnMelee.disable("No way you could reach enemy with melee attacks while flying.");
				}
				else if (player.wings.type == Wings.BAT_ARM) {
					btnMelee.disable("No way you could use your melee weapon with those arms while flying.");
				}
			} else if (player.hasStatusEffect(StatusEffects.KnockedBack)) {
				outputText("\n<b>You'll need to close some distance before you can use any physical attacks!</b>");
			} else if (player.isInGoblinMech()) {
				btnMelee.show("Sawblade", combat.basemechmeleeattacks, "Attempt to attack the enemy with your mech sawblade.  Damage done is determined by your strength and weapon.");
			}*/
			if (player.isInGoblinMech() || player.isInNonGoblinMech()) {
				var weapon:String = "";
				if (player.isInGoblinMech()) weapon = "saw blade";
				if (player.vehicles == vehicles.HB_MECH) weapon = "twin power blades";
				if (monster.isFlying()) {
					if (player.isFlying()) btnMelee.show("Attack", combat.basemechmeleeattacks, "Attempt to attack the enemy with your mech "+weapon+".  Damage done is determined by your strength and weapon.");
					else btnMelee.disable("No way you could reach enemy in air with melee attacks.");
					if (combat.isEnnemyInvisible) btnRanged.disable("You cannot use shoot an opponent you cannot see or target.");
				}
				else btnMelee.show("Attack", combat.basemechmeleeattacks, "Attempt to attack the enemy with your mech "+weapon+".  Damage done is determined by your strength and weapon.");
				if (combat.isEnnemyInvisible) btnMelee.disable("You cannot use attack an opponent you cannot see or target.");
			}
			else if ((player.isStaffTypeWeapon() || player.isPartiallyStaffTypeWeapon()) && player.hasPerk(PerkLib.StaffChanneling)) {
				if (!Wings.Types[player.wings.type].canFly && Arms.Types[player.arms.type].canFly) btnMelee.disable("No way you could use your melee weapon with those arms while flying.");
				else {
					if (player.hasPerk(PerkLib.ElementalBolt)) btnMelee.show("E.Bolt", combat.magic.spellElementalBolt, "Attempt to attack the enemy with elemental bolt from your [weapon].  Damage done is determined by your intelligence and weapon.");
					else btnMelee.show("M.Bolt", combat.magic.spellMagicBolt, "Attempt to attack the enemy with magic bolt from your [weapon].  Damage done is determined by your intelligence and weapon.");
				}
			}
			else {
				if (monster.isFlying()) {
					if (player.isFlying() || player.haveThrowableMeleeWeapon() || player.isWhipTypeWeapon() || player.isRibbonTypeWeapon() || ((player.isStaffTypeWeapon() || player.isPartiallyStaffTypeWeapon()) && player.hasPerk(PerkLib.StaffChanneling))) {
						if (player.isFlying()) {
							if (player.hasPerk(PerkLib.AerialCombat) || player.haveThrowableMeleeWeapon() || player.isWhipTypeWeapon() || player.isRibbonTypeWeapon()) {
								if (!Wings.Types[player.wings.type].canFly && Arms.Types[player.arms.type].canFly) btnMelee.disable("No way you could use your melee weapon with those arms while flying.");
								else btnMelee.show("Attack", combat.basemeleeattacks, "Attempt to attack the enemy with your " + player.weaponName+".  Damage done is determined by your strength and weapon.");
							}
							else btnMelee.disable("No way you could hit enemy with melee attacks while flying. Req. Aerial Combat perk or having melee weapon that could be used for range attack too.");
						}
						else if ((player.isStaffTypeWeapon() || player.isPartiallyStaffTypeWeapon()) && player.hasPerk(PerkLib.StaffChanneling)) {
							if (player.hasPerk(PerkLib.ElementalBolt)) btnMelee.show("E.Bolt", combat.magic.spellElementalBolt, "Attempt to attack the enemy with elemental bolt from your [weapon].  Damage done is determined by your intelligence and weapon.");
							else btnMelee.show("M.Bolt", combat.magic.spellMagicBolt, "Attempt to attack the enemy with magic bolt from your [weapon].  Damage done is determined by your intelligence and weapon.");
						}
						else btnMelee.show("Attack", combat.basemeleeattacks, "Attempt to attack the enemy with your " + player.weaponName+".  Damage done is determined by your strength and weapon.");
					}
					else btnMelee.disable("No way you could reach enemy in air with melee attacks. Unless you have melee weapon that could be used for range attack too.");
				}
				else btnMelee.show("Attack", combat.basemeleeattacks, "Attempt to attack the enemy with your " + player.weaponName+".  Damage done is determined by your strength and weapon.");
			}
		}
		if (combat.isEnnemyInvisible){
			btnMelee.disable("You cannot use attack an opponent you cannot see or target.");
		}
		// Ranged
		switch (player.weaponRangePerk) {
			case "Bow":
				btnRanged.show("Bow", combat.fireBow, "Attempt to attack the enemy with your " + player.weaponRangeName + ".  Damage done is determined by your speed and weapon.");
				if (combat.isEnnemyInvisible) btnRanged.disable("You cannot use shoot an opponent you cannot see or target.");
				break;
			case "Crossbow":
				btnRanged.show("Crossbow", combat.fireBow, "Attempt to attack the enemy with your " + player.weaponRangeName + ".  Damage done is determined only by your weapon.");
				if (combat.isEnnemyInvisible) btnRanged.disable("You cannot use shoot an opponent you cannot see or target.");
				break;
			case "Throwing":
				btnRanged.show("Throw", combat.fireBow, "Attempt to throw " + player.weaponRangeName + " at enemy.  Damage done is determined by your strength and weapon.");
				if (player.ammo <= 0 && player.weaponRange != weaponsrange.SHUNHAR) btnRanged.disable("You have used all your throwing weapons in this fight.");
				if (combat.isEnnemyInvisible) btnRanged.disable("You cannot use shoot an opponent you cannot see or target.");
				break;
			case "Pistol":
			case "Rifle":
			case "2H Firearm":
			case "Dual Firearms":
				if (player.ammo <= 0)
					btnRanged.show("Reload", combat.reloadWeapon1, "Your " + player.weaponRangeName + " is out of ammo.  You'll have to reload it before attack.");
				else btnRanged.show("Shoot", combat.fireBow, "Fire a round at your opponent with your " + player.weaponRangeName + "!  Damage done is determined only by your weapon. <b>AMMO LEFT: "+player.ammo+"</b>");
				if (combat.isEnnemyInvisible) btnRanged.disable("You cannot use shoot an opponent you cannot see or target.");
				break;
			default:
				btnRanged.showDisabled("Shoot", "You cannot use ranged combat without a ranged weapon equiped");
				if (combat.isEnnemyInvisible) btnRanged.disable("You cannot use shoot an opponent you cannot see or target.");
		}
		if (player.isFlying() && (!Wings.Types[player.wings.type].canFly && Arms.Types[player.arms.type].canFly)){btnRanged.disable("It would be rather difficult to aim while flapping your arms."); }
		if (player.isInGoblinMech()) {
			if (player.hasKeyItem("Repeater Gun") >= 0 || player.hasKeyItem("Machine Gun MK1") >= 0 || player.hasKeyItem("Machine Gun MK2") >= 0 || player.hasKeyItem("Machine Gun MK3") >= 0) {
				if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle" || player.weaponRangePerk == "2H Firearm" || player.weaponRangePerk == "Dual Firearms") {
					if (player.isUsingGoblinMechFriendlyFirearms()) btnRanged.show("Shoot", combat.fireBow, "Fire a round at your opponent with your " + player.weaponRangeName + "!  Damage done is determined only by your weapon. <b>AMMO LEFT: "+player.ammo+"</b>");
					else btnRanged.disable("Your firearms are not compatibile with the current piloted mech.");
				}
				else btnRanged.disable("You could use your ranged weapon while piloting the goblin mech if you have firearms.");
			} else btnRanged.disable("There is no way you could use your ranged weapon while piloting the goblin mech.");
			if (combat.isEnnemyInvisible) btnRanged.disable("You cannot use shoot an opponent you cannot see or target.");
		}
		if (player.vehicles == vehicles.HB_MECH) {
			if (player.isUsingHowlingBansheeMechFriendlyRangeWeapons()) btnRanged.show("Shoot", combat.fireBow, "Attempt to attack the enemy with your mech's inbuilt ranged weapons.  Damage done is determined by your speed and weapon.");
			else btnRanged.disable("Your range weapon is not compatibile to be used with current piloted mech.");
		}
		if (player.hasPerk(PerkLib.ElementalBody) && (player.weaponRangePerk == "" || player.weaponRangePerk == "Tome")) btnRanged.show("Throw", combat.throwElementalAttack, "Attack enemy with range elemental attack.  Damage done is determined by your strength.");
		if (player.weapon == weapons.MGSWORD && (player.weaponRangePerk == "" || player.weaponRangePerk == "Tome")) btnRanged.show("MoonWave", combat.throwElementalAttack, "Attack enemy with wave of moonlight.  Damage done is determined by your intelligence and weapon.");
		btnItems.show("Items", inventory.inventoryMenu, "The inventory allows you to use an item.  Be careful, as this leaves you open to a counterattack when in combat.");

		// Submenus
		function vampireBiteDuringGrapple(Position:int):void {
			if (player.perkv1(IMutationsLib.HollowFangsIM) >= 2) {
				addButton(Position, "Bite", combat.VampiricBite).hint("Suck on the blood of an opponent. \n\nFatigue Cost: " + physicalCost(20) + "");
				if (player.fatigueLeft() <= combat.physicalCost(20)) {
					button(Position).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
				}
			}
		}

		// Submenu - Physical Specials
		if (player.isFlying()) combat.pspecials.buildMenuForFlying(physpButtons);
		else combat.pspecials.buildMenu(physpButtons);
		if (physpButtons.length > 0) {
			if (!player.isFlying() && monster.isFlying() && !player.canFly()) {
				if (player.isInGoblinMech() || player.isInNonGoblinMech()) btnPSpecials.show("Mech", submenuPhySpecials, "Mech special attacks menu.", "Mech Specials");
				else btnPSpecials.disable("There is no way you could reach an opponent in the air with p. specials.");
			}
			else {
				if (player.isInGoblinMech() || player.isInNonGoblinMech()) btnPSpecials.show("Mech", submenuPhySpecials, "Mech special attacks menu.", "Mech Specials");
				else btnPSpecials.show("P. Specials", submenuPhySpecials, "Physical special attack menu.", "Physical Specials");
			}
		}
		// Submenu - Magical Specials
		combat.mspecials.buildMenu(magspButtons);
		if (magspButtons.length > 0) btnMSpecials.show("M. Specials", submenuMagSpecials, "Mental and supernatural special attack menu.", "Magical Specials");
		if (combat.isPlayerSilenced()) {
			btnMSpecials.disable();
		}
		// Submenu - Spells
		BuildSpellBookMenu(spellBookButtons);
		if (spellBookButtons.length > 0) btnMagic.show("Spells", submenuSpells, "Opens your spells menu, where you can cast any spells you have learned.", "Spells");
		if (player.hasStatusEffect(StatusEffects.OniRampage) || player.wrath > player.maxSafeWrathSpellcasting()) {
			btnMagic.disable("You are too angry to think straight. Smash your puny opponents first and think later.\n\n");
		} else if (!combat.canUseMagic()) btnMagic.disable();
		// Submenu - Soulskills
		combat.soulskills.buildMenu(soulforceButtons);
		if (soulforceButtons.length > 0) btnSoulskills.show("Soulforce", submenuSoulforce, "Soulforce attacks menu.", "Soulforce Specials");
		// Submenu - Other
		combat.buildOtherActions(otherButtons);
		if (otherButtons.length > 0) btnOther.show("Other", submenuOther, "Combat options and uncategorized actions");

		btnFantasize.show("Fantasize", combat.fantasize, "Fantasize about your opponent in a sexual way.  Its probably a pretty bad idea to do this unless you want to end up getting raped.");
		if (player.isInGoblinMech()) {
			if (player.hasKeyItem("Lustnade Launcher") >= 0) {
				btnTease.show("Lustnade Launcher", combat.goboLustnadeLauncher, "Launch Lustnade at enemy, dealing really heavy lust damage.");
				if (player.hasStatusEffect(StatusEffects.CooldownLustnadeLauncher)) btnTease.disable("<b>You need more time before you can use Lustnade Launcher again.</b>");
			}
			else if (player.hasKeyItem("Aphrodigas Gun") >= 0) btnTease.show("Aphrodigas Gun", combat.goboLustnadeLauncher, "Gassing the opponent with aphrodisiacs.");
			else btnTease.disable("No way you could make an enemy more aroused by striking a seductive pose and exposing parts of your body while piloting goblin mech.");
		}
		else if (player.vehicles == vehicles.HB_MECH) btnTease.disable("No way you could make an enemy more aroused by striking a seductive pose and exposing parts of your body while piloting elf mech.");
		else if (monster.lustVuln != 0 && monster.hasStatusEffect(StatusEffects.Stunned) && player.hasPerk(PerkLib.Straddle)) btnTease.show("Straddle", combat.Straddle, "Go to town on your opponent with devastating teases.");
		else btnTease.show("Tease", combat.teaseAttack, "Attempt to make an enemy more aroused by striking a seductive pose and exposing parts of your body.");
		if (combat.isEnnemyInvisible) btnTease.disable("You cannot tease an opponent you cannot see or target, heck is it even looking at you right now?");
		btnWait.show("Wait", combat.wait, "Take no action for this round.  Why would you do this?  This is a terrible idea.");
		if (monster.hasStatusEffect(StatusEffects.CreepingDoom)) btnRun.show("Struggle", combat.struggleCreepingDoom, "Shake away the pests.");
		else btnRun.show("Run", combat.runAway, "Choosing to run will let you try to escape from your enemy. However, it will be hard to escape enemies that are faster than you and if you fail, your enemy will get a free attack.");

		// Modifications - full or partial replacements
		//==============================================================================================================
		//ALLIES - 'smart' ones (wisps & henchmen). Do not depend on PC to do anything. Call them first!
		if (player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn) && player.statusEffectv1(StatusEffects.SimplifiedNonPCTurn) == 0)
			combat.simplifiedPrePCTurn_smart();
		else if (isWispTurn())
			doWispTurn();
		else if (isCompanionTurn(0))
			doCompanionTurn(0);
		else if (isCompanionTurn(1))
			doCompanionTurn(1);
		else if (isCompanionTurn(2))
			doCompanionTurn(2);
		else if (isCompanionTurn(3))
			doCompanionTurn(3);
		//PC: is busy with something
		else if (isPlayerBound()) {
			mainMenuWhenBound();
		} else if (isPlayerStunned() || isPlayerPowerStunned() || isPlayerFeared()) {
			menu();
			addButton(0, "Recover", combat.wait);
			if (CombatAbilities.ClearMind.isKnown) {
				CombatAbilities.ClearMind.createButton(monster).applyTo(button(1));
			}
			addButton(13, "Surrender(H)", combat.surrenderByHP).hint("Stop defending up to the point enemy would beat you down to minimal HP.");
			addButton(14, "Surrender(L)", combat.surrenderByLust).hint("Fantasize about your opponent in a sexual way so much it would fill up your lust you'll end up getting raped.");
		} else if (player.hasStatusEffect(StatusEffects.ChanneledAttack)) {
			mainMenuWhenChanneling();
		} else if (player.hasStatusEffect(StatusEffects.KnockedBack)) {
			if (player.ammo <= 0 && (player.weaponRangeName == "flintlock pistol" || player.weaponRangeName == "blunderbuss rifle")){
				btnMelee.show("Reload&Approach", combat.approachAfterKnockback1, "Reload your range weapon while approaching.", "Reload and Approach");
			} else if (player.ammo > 0 && (player.weaponRangeName == "flintlock pistol" || player.weaponRangeName == "blunderbuss rifle")) {
				btnMelee.show("Shoot&Approach", combat.approachAfterKnockback2, "Fire a round at your opponent and approach.", "Fire and Approach");
			} else {
				btnMelee.show("Approach", combat.approachAfterKnockback3, "Close some distance between you and your opponent.");
			}
		}
		//HYPNOSIS
		else if (monster.hasStatusEffect(StatusEffects.HypnosisNaga) && !monster.hasStatusEffect(StatusEffects.Constricted)) {
			menu();
			addButton(0, "Heal", combat.HypnosisHeal);
			addButton(1, "Attack", combat.HypnosisAttack);
			addButton(2, "Coil", combat.HypnosisCoil);
			vampireBiteDuringGrapple(3);
			addButton(4, "Maintain", combat.HypnosisMaintain);
			if (player.apophisScore() >= 23){
				addButton(5, "D.Shard", combat.HypnosisDarknessShard);
				addButton(6, "D.Wave", combat.HypnosisDuskWave);
			}
		} else if (monster.hasStatusEffect(StatusEffects.HypnosisNaga) && monster.hasStatusEffect(StatusEffects.Constricted)) {
			menu();
			addButton(0, "Squeeze", SceneLib.desert.nagaScene.naggaSqueeze).hint("Squeeze some HP out of your opponent! Break hypnosis! \n\nFatigue Cost: " + physicalCost(20) + "");
			addButton(1, "Tease", SceneLib.desert.nagaScene.naggaTease).hint("Deals lesser lust damage. Does not break hypnosis.");
			if (player.perkv1(IMutationsLib.HollowFangsIM) >= 2) {
				addButton(3, "Bite", combat.VampiricBite).hint("Suck on the blood of an opponent. Break hypnosis! \n\nFatigue Cost: " + physicalCost(20) + "");
				if (player.fatigueLeft() <= combat.physicalCost(20)) {
					button(3).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
				}
			}
			addButton(4, "Maintain", combat.HypnosisMaintain);
		}
		//Naga grapple
		else if (monster.hasStatusEffect(StatusEffects.Constricted) && !monster.hasStatusEffect(StatusEffects.HypnosisNaga)) {
			menu();
			addButton(0, "Squeeze", SceneLib.desert.nagaScene.naggaSqueeze).hint("Squeeze some HP out of your opponent! \n\nFatigue Cost: " + physicalCost(20) + "");
			addButton(1, "Tease", SceneLib.desert.nagaScene.naggaTease);
			vampireBiteDuringGrapple(3);
			addButton(4, "Release", SceneLib.desert.nagaScene.nagaLeggoMyEggo);
		} else if (monster.hasStatusEffect(StatusEffects.CancerGrab)) {
			menu();
			addButton(0, "Guillotine", combat.Guillotine).hint("Crush your foe with your pincer and attempt to break it appart! \n\nFatigue Cost: " + physicalCost(20) + "");
			vampireBiteDuringGrapple(3);
			addButton(4, "Release", combat.CrabLeggoMyEggo);
		}
		//Grappling scylla
		else if (monster.hasStatusEffect(StatusEffects.ConstrictedScylla)) {
			menu();
			addButton(0, "Squeeze", combat.ScyllaSqueeze);
			if (monster.plural) {
				button(0).hint("Squeeze your foes with your tentacles attempting to break them appart! \n\nFatigue Cost: " + physicalCost(50) + "");
			} else {
				button(0).hint("Squeeze your foe with your tentacle attempting to break it appart! \n\nFatigue Cost: " + physicalCost(20) + "");
			}
			addButton(1, "Tease", combat.ScyllaTease).hint("Use a free limb to caress and pleasure your grappled foe. \n\nFatigue Cost: " + physicalCost(20) + "");
			vampireBiteDuringGrapple(3);
			addButton(4, "Release", combat.ScyllaLeggoMyEggo);
		} else if (monster.hasStatusEffect(StatusEffects.ConstrictedWhip)) {
			menu();
			addButton(0, "Strangulate", combat.WhipStrangulate);
			vampireBiteDuringGrapple(3);
			addButton(4, "Release", combat.WhipLeggoMyEggo);
		}
		//Orca be playing rought
		else if (monster.hasStatusEffect(StatusEffects.OrcaPlay)) {
			menu();
			addButton(0, "Juggle", combat.OrcaJuggle).hint("Deal bite damage and send your foe back in the air at the cost of a fairly decent amount of fatigue. Extend the duration of play by 2 rounds up to twice. \n\nFatigue Cost: " + physicalCost(50) + "");
			addButton(1, "Tail wack", combat.OrcaWack).hint("Stun your opponent and smash it back into the air with your tail.\n\nFatigue Cost: " + physicalCost(20) + "");
			addButton(2, "Smash", combat.OrcaSmash).hint("Wack your opponent with your weapon crushing its armor and increasing all further damage dealth by 50% for two rounds.\n\nFatigue Cost: " + physicalCost(20) + "");
			if(player.tailType == !Tail.ORCA) {
				button(0).disable("You need a orca tail to use this ability.");
			}
			addButton(3, "Impale", combat.OrcaImpale).hint("End the game by viciously impaling your falling foe on your weapon. \n\nFatigue Cost: " + physicalCost(20) + "");
			addButton(4, "Release", combat.OrcaLeggoMyEggo).hint("Stop playing early and let your prey fall to the ground.");
		} else if (monster.hasStatusEffect(StatusEffects.Straddle)) {
			menu();
			addButton(0, "Tease", combat.StraddleTease).hint("Use a powerful teasing attack");
			if (player.perkv1(IMutationsLib.HollowFangsIM) >= 2) {
				addButton(1, "Bite", combat.VampiricBite).hint("Suck on the blood of an opponent. Break hypnosis! \n\nFatigue Cost: " + physicalCost(20) + "");
				if (player.fatigueLeft() <= combat.physicalCost(20)) {
					button(1).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
				}
			}
			addButton(4, "Release", combat.StraddleLeggoMyEggo).hint("Release your opponent.");
		} else if (monster.hasStatusEffect(StatusEffects.ManticorePlug)) {
			menu();
			addButton(0, "Feed", combat.ManticoreFeed).hint("Milk your victim's cock with your powerful tail!");
		} else if (monster.hasStatusEffect(StatusEffects.DisplacerPlug)) {
			menu();
			addButton(0, "Feed", combat.displacerFeedContinue).hint("Milk your victim's breast with your tentacles!");
		} else if (monster.hasStatusEffect(StatusEffects.SlimeInsert)) {
			menu();
			addButton(0, "Rape", combat.SlimeRapeFeed).hint("Violate your opponent from the inside!");
		} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
			menu();
			if (monster.statusEffectv1(StatusEffects.Dig) > 0){
				if (player.lowerBody == LowerBody.CANCER) addButton(0, "Grab", combat.CancerGrab).hint("Dig underneath your opponent and attempt to grab it in your pincers");
				if (player.arms.type == Arms.FROSTWYRM) {
					if (!player.hasStatusEffect(StatusEffects.CooldownTremor)) addButton(1, "Tremor", combat.Tremor).hint("Cause seismic activity beneath your foes in an attempt to stun them");
					if (player.lowerBody == LowerBody.FROSTWYRM) addButton(0, "Grab", SceneLib.desert.nagaScene.nagaPlayerConstrict).hint("Surge out of the ground and coil around your opponent!");
				}
				addButton(4, "Wait", combat.wait);
				if (spellBookButtons.length > 0) btnMagic.show("Spells", submenuSpells, "Opens your spells menu, where you can cast any spells you have learned.", "Spells");
				if (player.hasStatusEffect(StatusEffects.OniRampage)) {
					btnMagic.disable("You are too angry to think straight. Smash your puny opponents first and think later.\n\n");
				} else if (!combat.canUseMagic()) {
					btnMagic.disable();
				}
			}
			addButton(2, "Dig out", combat.DigOut).hint("Dig back out out of the ground.");
			addButton(14, "Escape", combat.runAway).hint("Escape away from the battle throught underground tunneling.");
		} else if (monster.hasStatusEffect(StatusEffects.GooEngulf)) {
			menu();
			addButton(0, "Tease", combat.GooTease).hint("Toy with your opponent");
			addButton(4, "Release", combat.GooLeggoMyEggo).hint("Release your opponent.");
		} else if (monster.hasStatusEffect(StatusEffects.EmbraceVampire)) {
			menu();
			if (player.faceType == Face.VAMPIRE || player.perkv1(IMutationsLib.HollowFangsIM) >= 1) {
				addButton(0, "Bite", combat.VampiricBite).hint("Suck on the blood of an opponent. \n\nFatigue Cost: " + physicalCost(20) + "");
				if (player.fatigueLeft() <= combat.physicalCost(20)) {
					button(0).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
				}
			}
			else addButtonDisabled(0, "Bite", "If only you had fangs.");
			addButton(4, "Release", combat.VampireLeggoMyEggo);
		} else if (monster.hasStatusEffect(StatusEffects.MysticWeb)) {
			menu();
			addButton(0, "Tease", combat.WebTease).hint("Toy with your opponent");
			addButton(1, "Bite", combat.spiderBiteAttack).hint("Inject your venom.");
			addButton(2, "Release", combat.BreakOutWeb);
			vampireBiteDuringGrapple(3);
			//combat.mspecials.buildMenu(magspButtons);
			if (magspButtons.length > 0) btnMSpecials.show("M. Specials", submenuMagSpecials, "Mental and supernatural special attack menu.", "Magical Specials");
			if (combat.isPlayerSilenced()) {
				btnMSpecials.disable();
			}
			// Submenu - Spells
			//BuildSpellBookMenu(spellBookButtons);
			if (spellBookButtons.length > 0) btnMagic.show("Spells", submenuSpells, "Opens your spells menu, where you can cast any spells you have learned.", "Spells");
			if (player.hasStatusEffect(StatusEffects.OniRampage) || player.wrath > player.maxSafeWrathSpellcasting()) {
				btnMagic.disable("You are too angry to think straight. Smash your puny opponents first and think later.\n\n");
			} else if (!combat.canUseMagic()) btnMagic.disable();
		} else if (monster.hasStatusEffect(StatusEffects.Pounce)) {
			menu();
			if (player.arms.type == Arms.DISPLACER) addButton(0, "Ravage", combat.clawsRend).hint("Rend your enemy using your four sets of claws. \n\nFatigue Cost: " + physicalCost(20) + "");
			else addButton(0, "Claws", combat.clawsRend).hint("Rend your enemy using your claws. \n\nFatigue Cost: " + physicalCost(20) + "");
			if (monster.lustVuln != 0 && !monster.plural && player.hasPerk(PerkLib.Straddle)) addButton(1, "Straddle", combat.Straddle).hint("Change position and initiate a straddling stance");
			if ((player.hasPerk(PerkLib.PhantomStrike) && (player.fatigueLeft() <= combat.physicalCost(40))) || (!player.hasPerk(PerkLib.PhantomStrike) && (player.fatigueLeft() <= combat.physicalCost(20)))) {
				button(0).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
			}
			if (player.rearBody.type == RearBody.DISPLACER_TENTACLES) {
				if (monster.hasStatusEffect(StatusEffects.DisplacerPlug)) addButton(1, "Feed", combat.displacerFeedContinue).hint("Feast on your foe breast milk.");
				else addButton(1, "Attach", combat.displacerCombatFeed).hint("Attach you tentacles to start feast on your foe breast milk. \n\nFatigue Cost: " + physicalCost(50) + "");
			}
			vampireBiteDuringGrapple(3);
			addButton(4, "Release", combat.PussyLeggoMyEggo);
		} else if (monster.hasStatusEffect(StatusEffects.GrabBear)) {
			menu();
			addButton(0, "Hug", combat.bearHug).hint("Crush your opponent with a bear hug. \n\nFatigue Cost: " + physicalCost(30) + "");
			if (player.perkv1(IMutationsLib.HollowFangsIM) >= 2) {
				addButton(3, "Bite", combat.VampiricBite).hint("Suck on the blood of an opponent. \n\nFatigue Cost: " + physicalCost(20) + "");
				if (player.fatigueLeft() <= combat.physicalCost(20)) {
					button(3).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
				}
			}
			addButton(4, "Release", combat.BearLeggoMyEggo);
		}
		//ALLIES - 'stupid' ones (elem & golems). Requires PC to NOT be stunned or channel anything.
		else if (player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn) && player.statusEffectv2(StatusEffects.SimplifiedNonPCTurn) == 0)
			combat.simplifiedPrePCTurn_stupid();
		else if (isGolemTurn())
			doGolemTurn();
		else if (isEpicElementalTurn())
			doEpicElementalTurn();
		else if (isElementalTurn())
			doElementalTurn();
		//UNIQUE OPTIONS - No changes applied, player turn, no status/CC
		else {
			if (monster is SandTrap) {
				btnSpecial1.show("Climb", combat.wait2, "Climb the sand to move away from the sand trap.");
			} else if (monster is Alraune) {
				if (player.fatigueLeft() < 50) btnSpecial1.disable("You're too tired to struggle.");
				else btnSpecial1.show("Struggle", combat.wait2, "Struggle to forcefully pull yourself a good distance away from plant woman.");
			} else if (monster is DriderIncubus) {
				var drider:DriderIncubus = monster as DriderIncubus;
				if (!drider.goblinFree) btnSpecial1.show("Free Goblin", drider.freeGoblin);
			} else if (monster is MinotaurKing) {
				var minoking:MinotaurKing = monster as MinotaurKing;
				if (!player.hasStatusEffect(StatusEffects.MinoKing) && player.companionsInPCParty()) btnSpecial1.show("Dish Helper", minoking.dishHelper);
                else btnSpecial1.showDisabled("Dish Helper", "You don't have anyone to take care of Excellia!");
			} else if (monster is Lethice) {
				var lethice:Lethice = monster as Lethice;
				if (player.hasStatusEffect(StatusEffects.LethicesRapeTentacles)) {
					if (player.lust < combat.magic.getWhiteMagicLustCap() && player.hasStatusEffect(StatusEffects.KnowsWhitefire)
						&& ((!player.hasPerk(PerkLib.BloodMage) && player.mana >= 30) || (player.hasStatusEffect(StatusEffects.BloodMage) && ((player.HP + 30) > (player.minHP() + 30))))) {
						btnSpecial1.show("Dispel", lethice.dispellRapetacles);
					}
				}
			} else if (monster is WoodElvesHuntingParty) {
				var woodelves:WoodElvesHuntingParty = monster as WoodElvesHuntingParty;
				if (flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] != 0) btnSpecial1.show("Pick (M)", woodelves.pickUpMelee, "Pick up your melee weapon.");
				if (flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] != 0) btnSpecial2.show("Pick (R)", woodelves.pickUpRange, "Pick up your range weapon.");
			}
			if ((player.weaponRange == weaponsrange.GTHRSPE && player.ammo <= 15) || (player.weaponRange == weaponsrange.GTHRAXE && player.ammo <= 10) || (player.weaponRange == weaponsrange.TRJAVEL && player.ammo <= 10)) {
				btnSpecial3.show("Pick", combat.pickUpThrownWeapons, "Pick up some of the thrown weapons.");
			}
		}
	}

	public function isWispTurn():Boolean {
		return player.hasPerk(PerkLib.JobLeader) && flags[kFLAGS.WILL_O_THE_WISP] < 2 && flags[kFLAGS.IN_COMBAT_PLAYER_WILL_O_THE_WISP_ATTACKED] != 1;
	}

	public function doWispTurn():void {
		if (flags[kFLAGS.WILL_O_THE_WISP] == 0) combat.willothewispattacks();
		else {
			clearOutput();
			outputText("Would you like your wisp to attack?");
			outputText("\n<b>The wisp can be toggled to attack automatically (Page 3).</b>");
			outputText("\n<b>You can also enable \"Simplified Pre-PC Turn\" in Perk menu to set all your allies' behaviour to automatic and avoid pressing the 'Next' button every time.</b>\n\n");
			menu();
			addButton(0, "Skip", combat.willothewispskip).hint("You forfeit this attack of the wisp. Would skip to next minion attack/your main turn.");
			addButton(1, "Attack", combat.willothewispattacks).hint("The wisp attacks your enemy.");
		}
	}

	public function isGolemTurn():Boolean {
		return player.hasPerk(PerkLib.FirstAttackGolems) && flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] == 1 && flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] != 1 && player.mana >= combat.pspecials.permanentgolemsendcost();
	}

	public function doGolemTurn():void {
		clearOutput();
		outputText("\n\nWould you like your golems to attack?");
		outputText("\n<b>You can  enable \"Simplified Pre-PC Turn\" in Perk menu to send your golems automatically and avoid pressing the button every time.</b>");
		menu();
		addButton(0, "None", combat.pspecials.notSendAnyGolem).hint("You forfeit potential attack of golem(s). Would skip to next minion attack/your main turn.");
		addButton(1, "Send P.Gol/1", combat.pspecials.sendPermanentGolem, 1).hint("Send 1 golem.\n<b>Mana cost of sending 1 permanent golem: "+combat.pspecials.permanentgolemsendcost() + "</b>");
		if (monster.plural) {
			if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] >= 3) {
				if (player.mana >= combat.pspecials.permanentgolemsendcost() * 3) addButton(6, "Send P.Gol/3", combat.pspecials.sendPermanentGolem, 3).hint("Send 3 golems (deals 5x damage).\n<b>Mana cost of sending 3 pernament golems: "+(combat.pspecials.permanentgolemsendcost()*3) + "</b>");
				else addButtonDisabled(6, "Send P.Gol/3", "Not enough mana.");
			}
			if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] >= 5) {
				if (player.mana >= combat.pspecials.permanentgolemsendcost() * 5) addButton(11, "Send P.Gol/5", combat.pspecials.sendPermanentGolem, 5).hint("Send 3 golems (deals 5x damage).\n<b>Mana cost of sending 5 pernament golems: "+(combat.pspecials.permanentgolemsendcost()*5));
				else addButtonDisabled(11, "Send P.Gol/5", "Not enough mana.");
			}
		}
		if (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] > 0) {
			if (player.mana >= combat.pspecials.permanentimprovedgolemsendcost()) addButton(2, "Send I.P.Gol/1", combat.pspecials.sendPermanentImprovedGolem, 1).hint("Send 1 improved golem (deals 5x damage).\n<b>Mana cost of sending 1 improved pernament golem: "+combat.pspecials.permanentimprovedgolemsendcost() + "</b>");
			else addButtonDisabled(2, "Send I.P.Gol/1", "Not enough mana.");
			if (monster.plural) {
				if (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] >= 3) {
					if (player.mana >= combat.pspecials.permanentimprovedgolemsendcost() * 3) addButton(7, "Send I.P.Gol/3", combat.pspecials.sendPermanentImprovedGolem, 3).hint("Send 3 improved golems (deals 5x damage).\n<b>Mana cost of sending 3 improved pernament golems: "+(combat.pspecials.permanentimprovedgolemsendcost()*3) + "</b>");
					else addButtonDisabled(7, "Send I.P.Gol/3", "Not enough mana.");
				}
				if (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] >= 5) {
					if (player.mana >= combat.pspecials.permanentimprovedgolemsendcost() * 5) addButton(12, "Send I.P.Gol/5", combat.pspecials.sendPermanentImprovedGolem, 5).hint("Send 3 improved golems (deals 5x damage).\n<b>Mana cost of sending 5 improved pernament golems: "+(combat.pspecials.permanentimprovedgolemsendcost()*5) + "</b>");
					else addButtonDisabled(12, "Send I.P.Gol/5", "Not enough mana.");
				}
			}
		}
		if (flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] > 0) {
			if (player.mana >= combat.pspecials.permanentsteelgolemsendcost()) addButton(3, "Send S.Gol/1", combat.pspecials.sendPermanentSteelGolem1).hint("Mana cost of sending 1 pernament steel golem: "+combat.pspecials.permanentsteelgolemsendcost());
			else addButtonDisabled(2, "Send S.Gol/1", "Not enough mana.");
		}
	}

	public function isEpicElementalTurn():Boolean {
		return player.hasPerk(PerkLib.FirstAttackElementalsSu) && player.statusEffectv2(StatusEffects.SummonedElementals) > 0 && (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 3 || flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 4) && flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] < 1;
	}

	public function doEpicElementalTurn():void {
		clearOutput();
		outputText("\n\nWould you like your <b>epic</b> elementals to attack?");
		outputText("\n<b>You can  enable \"Simplified Pre-PC Turn\" in Perk menu to change their behavior to automatic and avoid pressing the button every time.</b>");
		menu();
		addButton(0, "None", combat.baseelementalattacks, Combat.NONE_E).hint("You forfeit potential attack of epic elemental. Would skip to next minion attack/your main turn.");
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsAirE)) {
			if (player.hasPerk(PerkLib.ElementalBody) && player.perkv1(PerkLib.ElementalBody) == 1) addButtonDisabled(1, "Air(E)", "You can't command this elemental to attack (independently of you) when you're currently fused with it.");
			else addButton(1, "Air(E)", combat.baseelementalattacks, Combat.AIR_E);
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarthE)) {
			if (player.hasPerk(PerkLib.ElementalBody) && player.perkv1(PerkLib.ElementalBody) == 2) addButtonDisabled(2, "Earth(E)", "You can't command this elemental to attack (independently of you) when you're currently fused with it.");
			else addButton(2, "Earth(E)", combat.baseelementalattacks, Combat.EARTH_E);
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsFireE)) {
			if (player.hasPerk(PerkLib.ElementalBody) && player.perkv1(PerkLib.ElementalBody) == 3) addButtonDisabled(3, "Fire(E)", "You can't command this elemental to attack (independently of you) when you're currently fused with it.");
			else addButton(3, "Fire(E)", combat.baseelementalattacks, Combat.FIRE_E);
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsWaterE)) {
			if (player.hasPerk(PerkLib.ElementalBody) && player.perkv1(PerkLib.ElementalBody) == 4) addButtonDisabled(4, "Water(E)", "You can't command this elemental to attack (independently of you) when you're currently fused with it.");
			else addButton(4, "Water(E)", combat.baseelementalattacks, Combat.WATER_E);
		}
	}

	public function isElementalTurn():Boolean {
		return player.hasPerk(PerkLib.FirstAttackElementals) && (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 3 || flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 4) && flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] < 2;
	}

	public function doElementalTurn():void {
		clearOutput();
		outputText("\n\nWould you like your elementals to attack?");
		outputText("\n<b>You can  enable \"Simplified Pre-PC Turn\" in Perk menu to change their behavior to automatic and avoid pressing the button every time.</b>");
		menu();
		addButton(0, "None", combat.baseelementalattacks, Combat.NONE).hint("You forfeit potential attack of normal elemental. Would skip to next minion attack/your main turn.");
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir)) addButton(1, "Air", combat.baseelementalattacks, Combat.AIR);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth)) addButton(2, "Earth", combat.baseelementalattacks, Combat.EARTH);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire)) addButton(3, "Fire", combat.baseelementalattacks, Combat.FIRE);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater)) addButton(4, "Water", combat.baseelementalattacks, Combat.WATER);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther)) addButton(5, "Ether", combat.baseelementalattacks, Combat.ETHER);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood)) addButton(6, "Wood", combat.baseelementalattacks, Combat.WOOD);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal)) addButton(7, "Metal", combat.baseelementalattacks, Combat.METAL);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce)) addButton(8, "Ice", combat.baseelementalattacks, Combat.ICE);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning)) addButton(9, "Lightning", combat.baseelementalattacks, Combat.LIGHTNING);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) addButton(10, "Darkness", combat.baseelementalattacks, Combat.DARKNESS);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsPoison)) addButton(11, "Poison", combat.baseelementalattacks, Combat.POISON);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsPurity)) addButton(12, "Purity", combat.baseelementalattacks, Combat.PURITY);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsCorruption)) addButton(13, "Corruption", combat.baseelementalattacks, Combat.CORRUPTION);
	}

	public function isCompanionTurn(num:int):Boolean {
		var present:Boolean;
		var acted:Boolean;
		switch(num) {
			case 0:
				present = flags[kFLAGS.PLAYER_COMPANION_0] != "";
				acted = flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_0_ACTION];
				break;
			case 1:
				present = flags[kFLAGS.PLAYER_COMPANION_1] != "";
				acted = flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION];
				break;
			case 2:
				present = flags[kFLAGS.PLAYER_COMPANION_2] != "";
				acted = flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION];
				break;
			case 3:
				present = flags[kFLAGS.PLAYER_COMPANION_3] != "";
				acted = flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION];
				break;
		}
		return present && !acted && !player.hasStatusEffect(StatusEffects.MinoKing);
	}

	public function doCompanionTurn(num:int, clearAndNext:Boolean = true):void {
		var companionName:String = num == 0 ? flags[kFLAGS.PLAYER_COMPANION_0]
			: num == 1 ? flags[kFLAGS.PLAYER_COMPANION_1]
				: num == 2 ? flags[kFLAGS.PLAYER_COMPANION_2]
					: flags[kFLAGS.PLAYER_COMPANION_3];
		var actFunction:Function = companionName == "Alvina" ? combat.comfoll.alvinaCombatActions
			: companionName == "Amily" ? combat.comfoll.amilyCombatActions
				: companionName == "Aurora" ? combat.comfoll.auroraCombatActions
					: companionName == "Etna" ? combat.comfoll.etnaCombatActions
						: companionName == "Excellia" ? combat.comfoll.excelliaCombatActions
							: companionName == "Mitzi" ? combat.comfoll.mitziCombatActions
								: companionName == "Neisa" ? combat.comfoll.neisaCombatActions
									: companionName == "Tyrantia" ? combat.comfoll.tyrantiaCombatActions
										: companionName == "Zenji" ? combat.comfoll.zenjiCombatActions : null;
		//do action
		if (clearAndNext) {
			clearOutput();
			outputText("Your follower attacks...");
			outputText("\n<b>You can  enable \"Simplified Pre-PC Turn\" in Perk menu to avoid pressing the 'Next' button every time.</b>\n\n");
		}
		if (actFunction == null) CoC_Settings.error("Illegal companion " + num + ": " + companionName);
		actFunction();
		if (player.hasPerk(PerkLib.MotivationSu)) actFunction();
		if (clearAndNext) {
			menu();
			addButton(0, "Next", combatMenu, false);
		}
	}

	private function BuildSpellBookMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		//Most basic spell ever ^^
		if (player.hasPerk(PerkLib.JobSorcerer)) {
			bd = buttons.add("M.Bolt", combat.magic.spellMagicBolt);
			if (player.hasPerk(PerkLib.StaffChanneling) && player.weaponSpecials("Staff")) bd.hint("Attempt to attack the enemy with magic bolt from your [weapon].  Damage done is determined by your intelligence and weapon.", "Magic Bolt");
			else bd.hint("Attempt to attack the enemy with magic bolt.  Damage done is determined by your intelligence.", "Magic Bolt");
			if (player.mana < spellCost(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff magic while underground.");
			} else if (player.hasStatusEffect(StatusEffects.MonsterDig)) {
				bd.disable("You cannot use offensive spell against an opponent you cannot see or target.");
			}
			if (player.hasPerk(PerkLib.MagesWrath)) {
				bd = buttons.add("M.Bolt(Ex)", combat.magic.spellEdgyMagicBolt);
				if (player.hasPerk(PerkLib.StaffChanneling) && player.weaponSpecials("Staff")) bd.hint("Attempt to attack the enemy with wrath-empowered magic bolt from your [weapon].  Damage done is determined by your intelligence and weapon.", "Wrath-Empowered Magic Bolt");
				else bd.hint("Attempt to attack the enemy with wrath-empowered magic bolt.  Damage done is determined by your intelligence.", "Wrath-Empowered Magic Bolt");
				if (player.mana < spellCost(40)) {
					bd.disable("Your mana is too low to cast this spell.");
				} else if (player.wrath < 100) {
					bd.disable("Your wrath is too low to cast this spell.");
				} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
					bd.disable("You can only use buff magic while underground.");
				} else if (player.hasStatusEffect(StatusEffects.MonsterDig)) {
					bd.disable("You cannot use offensive spell against an opponent you cannot see or target.");
				}
			}
		}
		if (player.hasPerk(PerkLib.ElementalBolt)) {
			bd = buttons.add("E.Bolt", combat.magic.spellElementalBolt);
			if (player.hasPerk(PerkLib.StaffChanneling) && player.weaponSpecials("Staff")) bd.hint("Attempt to attack the enemy with elemental bolt from your [weapon].  Damage done is determined by your intelligence and weapon.", "Elemental Bolt");
			else bd.hint("Attempt to attack the enemy with elemental bolt.  Damage done is determined by your intelligence.", "Elemental Bolt");
			if (player.mana < spellCost(80)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff magic while underground.");
			} else if (player.hasStatusEffect(StatusEffects.MonsterDig)) {
				bd.disable("You cannot use offensive spell against an opponent you cannot see or target.");
			}
			if (player.hasPerk(PerkLib.MagesWrath)) {
				bd = buttons.add("E.Bolt(Ex)", combat.magic.spellEdgyElementalBolt);
				if (player.hasPerk(PerkLib.StaffChanneling) && player.weaponSpecials("Staff")) bd.hint("Attempt to attack the enemy with wrath-empowered elemental bolt from your [weapon].  Damage done is determined by your intelligence and weapon.", "Wrath-Empowered Elemental Bolt");
				else bd.hint("Attempt to attack the enemy with wrath-empowered elemental bolt.  Damage done is determined by your intelligence.", "Wrath-Empowered Elemental Bolt");
				if (player.mana < spellCost(80)) {
					bd.disable("Your mana is too low to cast this spell.");
				} else if (player.wrath < 100) {
					bd.disable("Your wrath is too low to cast this spell.");
				} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
					bd.disable("You can only use buff magic while underground.");
				} else if (player.hasStatusEffect(StatusEffects.MonsterDig)) {
					bd.disable("You cannot use offensive spell against an opponent you cannot see or target.");
				}
			}
		}
		buildAbilityMenu(CombatAbilities.ALL_WHITE_SPELLS, whiteSpellButtons);
		buildAbilityMenu(CombatAbilities.ALL_BLACK_SPELLS, blackSpellButtons);
		buildAbilityMenu(CombatAbilities.ALL_GREY_SPELLS, greySpellButtons);
		buildAbilityMenu(CombatAbilities.ALL_HEX_SPELLS, hexSpellButtons);
		buildAbilityMenu(CombatAbilities.ALL_DIVINE_SPELLS, divineSpellButtons);
		buildAbilityMenu(CombatAbilities.ALL_NECRO_SPELLS, necroSpellButtons);
		buildAbilityMenu(CombatAbilities.ALL_BLOOD_SPELLS, bloodSpellButtons);
		if (whiteSpellButtons.length > 0) buttons.add("White Spells", curry(submenu,whiteSpellButtons, submenuSpells, 0, false)).hint("Open your White magic book");
		if (blackSpellButtons.length > 0) buttons.add("Black Spells", curry(submenu,blackSpellButtons, submenuSpells, 0, false)).hint("Open your Black magic book");
		if (player.hasPerk(PerkLib.GreyMagic) && greySpellButtons.length > 0) buttons.add("Grey Spells", curry(submenu,greySpellButtons, submenuSpells, 0, false)).hint("Open your Grey magic book");
		if (player.hasPerk(PerkLib.HexKnowledge) && hexSpellButtons.length > 0) buttons.add("Hexes", curry(submenu,hexSpellButtons, submenuSpells, 0, false)).hint("Open your Hex grimoire");
		if (player.hasPerk(PerkLib.DivineKnowledge) && divineSpellButtons.length > 0) buttons.add("Divine", curry(submenu,divineSpellButtons, submenuSpells, 0, false)).hint("Open your Divine tome");
		if (player.hasPerk(PerkLib.PrestigeJobNecromancer) && necroSpellButtons.length > 0) buttons.add("Necro Spells", curry(submenu,necroSpellButtons, submenuSpells, 0, false)).hint("Open your Necromicon");
		if (player.hasPerk(PerkLib.HiddenJobBloodDemon) && bloodSpellButtons.length > 0) buttons.add("Blood Spells", curry(submenu,bloodSpellButtons, submenuSpells, 0, false)).hint("Open your Blood grimoire");
	}
	
	private function buildAbilityMenu(abilities:/*CombatAbility*/Array, buttons:ButtonDataList):void {
		for each(var ability:CombatAbility in abilities) {
			if (ability.isKnown) {
				buttons.list.push(ability.createButton(monster));
			}
		}
	}

	internal function mainMenuWhenBound():void {
		menu();
		var btnStruggle:CoCButton  = addButton(0, "Struggle", combat.struggle);
		var btnBoundWait:CoCButton = addButton(1, "Wait", combat.wait);
		if (player.hasPerk(PerkLib.Spectre) && player.hasPerk(PerkLib.Incorporeality)) {
			if (player.hasStatusEffect(StatusEffects.CooldownPossess)) addButtonDisabled(3, "Possess", "<b>You need more time before you can use Possess again.</b>");
			else addButton(3, "Possess", combat.mspecials.possess2);
		}
		if (player.hasStatusEffect(StatusEffects.UBERWEB)) {
			addButton(6, "M. Special", submenuMagSpecials);
		}
		addButton(13, "Surrender(H)", combat.surrenderByHP).hint("Stop defending up to the point enemy would beat you down to minimal HP.");
		addButton(14, "Surrender(L)", combat.surrenderByLust).hint("Fantasize about your opponent in a sexual way so much it would fill up your lust you'll end up getting raped.");
		if (player.hasStatusEffect(StatusEffects.Bound)) {
			btnStruggle.call((monster as Ceraph).ceraphBindingStruggle);
			btnBoundWait.call((monster as Ceraph).ceraphBoundWait);
		}
		if (player.hasStatusEffect(StatusEffects.CancerMonsterGrab)) {
			btnStruggle.call((monster as CancerAttack).cancerGrabStruggle);
			btnBoundWait.call((monster as CancerAttack).cancerGrabWait);
		}
		if (player.hasStatusEffect(StatusEffects.Chokeslam)) {
			btnStruggle.call((monster as Izumi).chokeSlamStruggle);
			btnBoundWait.call((monster as Izumi).chokeSlamWait);
		}
		if (player.hasStatusEffect(StatusEffects.Titsmother)) {
			btnStruggle.call((monster as Izumi).titSmotherStruggle);
			btnBoundWait.call((monster as Izumi).titSmotherWait);
		}
		if (player.hasStatusEffect(StatusEffects.Pounced)) {
			outputText("\n<b>You’re trapped underneath the giant Drider, and all you can see is her armored undercarriage. Eight legs jab down at you, steel glinting dangerously. You need to get out of here, or you’ll end up crushed!</b>");
			btnStruggle.call((monster as Tyrantia).tyrantiaPouncedStruggle);
			btnBoundWait.call((monster as Tyrantia).tyrantiaPouncedWait);
		}
		if (player.hasStatusEffect(StatusEffects.Tentagrappled)) {
			btnStruggle.call((monster as SuccubusGardener).grappleStruggle);
			btnBoundWait.call((monster as SuccubusGardener).grappleWait);
		}
		if (player.hasStatusEffect(StatusEffects.YamataEntwine)) {
			btnStruggle.call((monster as Yamata).entwineStruggle);
			btnBoundWait.call((monster as Yamata).entwineWait);
		}
		if (player.hasStatusEffect(StatusEffects.LethicesRapeTentacles) && player.statusEffectv3(StatusEffects.LethicesRapeTentacles) == 1) {
			outputText("\n<b>Lethice's tentacles have a firm grip of your limbs!</b>");
			addButton(0, "Struggle", (monster as Lethice).grappleStruggle);
			addButton(1, "Wait", (monster as Lethice).grappleWait);

			var whitefireLustCap:int = player.maxLust() * 0.75;
			if (player.hasPerk(PerkLib.Enlightened) && player.cor < (10 + player.corruptionTolerance)) whitefireLustCap += (player.maxLust() * 0.1);
			if (player.hasPerk(PerkLib.FocusedMind) && !player.hasPerk(PerkLib.GreyMage)) whitefireLustCap += (player.maxLust() * 0.1);
			if (player.hasPerk(PerkLib.GreyMage)) whitefireLustCap = (player.maxLust() - 45);
			if (player.hasPerk(PerkLib.GreyMage) && player.hasPerk(PerkLib.Enlightened) && player.cor < (10 + player.corruptionTolerance)) whitefireLustCap = (player.maxLust() - 15);
			var gotEnergy:Boolean = !player.hasPerk(PerkLib.BloodMage) && player.mana >= 30;
			if (player.lust < whitefireLustCap && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && gotEnergy) {
				addButton(2, "Dispell", (monster as Lethice).dispellRapetacles);
			}
		}
	}

	internal function mainMenuWhenChanneling():void {
		menu();
		var chatk:StatusEffectClass  = player.statusEffectByType(StatusEffects.ChanneledAttack);
		var chtype:StatusEffectClass = player.statusEffectByType(StatusEffects.ChanneledAttackType);
		var btnContinue:CoCButton    = button(0);
		var btnStop:CoCButton        = button(1);
		btnStop.show("Stop", combat.stopChanneledSpecial, "Stop channeling.");
		if (chatk && chatk.value1 >= 1) {
			if (!isPlayerBound() && !isPlayerSilenced() && !isPlayerStunned() && !isPlayerFeared()) {
				switch (chtype.value1) {
					case 1:
						btnContinue.show("Continue", combat.mspecials.singCompellingAria, "Continue singing.");
						break;
					case 2:
						btnContinue.show("Continue", combat.mspecials.startOniRampage, "Continue starting rampage.");
						break;
					case 3:
						btnContinue.show("Continue", combat.mspecials.OrgasmicLightningStrike, "Continue masturbating.");
						break;
					case 4:
						btnContinue.show("Continue", combat.mspecials.trueDragonBreath, "Continue gathering elemental energy.");
						break;
					case 5:
						btnContinue.show("Continue", CombatAbilities.PolarMidnight.buttonCallback, "Continue casting Polar Midnight spell.");
						break;
					case 6:
						btnContinue.show("Continue", CombatAbilities.MeteorShower.buttonCallback, "Continue casting Meteor Shower spell.");
						break;/*
					case 7:
						btnContinue.show("Continue", combat.magic., "Continue casting  spell.");
						break;
					case 8:
						btnContinue.show("Continue", combat.magic., "Continue casting  spell.");
						break;
					case 9:
						btnContinue.show("Continue", combat.magic., "Continue casting  spell.");
						break;
					case 10:
						btnContinue.show("Continue", combat.magic., "Continue casting  spell.");
						break;*/
				}
			}
		}
	}
	internal function submenuMagSpecials():void {
		if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && (player.statusEffectv2(StatusEffects.Sealed) == 6 || player.statusEffectv2(StatusEffects.Sealed) == 10)) {
			clearOutput();
			if (player.statusEffectv2(StatusEffects.Sealed) == 6) outputText("You try to ready a special ability, but wind up stumbling dizzily instead.  <b>Your ability to use magical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
			if (player.statusEffectv2(StatusEffects.Sealed) == 10) outputText("You try to use a magical ability but you are currently silenced by the alraune vines!\n\n");
			enemyAI();
			return;
		}
		submenu(magspButtons,mainMenu);
	}
	internal function submenuPhySpecials():void {
		if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 5) {
			clearOutput();
			outputText("You try to ready a special attack, but wind up stumbling dizzily instead.  <b>Your ability to use physical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
			enemyAI();
			return;
		}
		if (player.hasStatusEffect(StatusEffects.TaintedMind)) {
			combat.taintedMindAttackAttempt();
			return;
		}
		submenu(physpButtons,mainMenu);
	}
	internal function submenuSpells():void {
		if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && (player.statusEffectv2(StatusEffects.Sealed) == 2 || player.statusEffectv2(StatusEffects.Sealed) == 10)) {
			clearOutput();
			if (player.statusEffectv2(StatusEffects.Sealed) == 2) outputText("You reach for your magic, but you just can't manage the focus necessary.  <b>Your ability to use magic was sealed, and now you've wasted a chance to attack!</b>\n\n");
			if (player.statusEffectv2(StatusEffects.Sealed) == 10) outputText("You try to use magic but you are currently silenced by the alraune vines!\n\n");
			enemyAI();
			return;
		}
		submenu(spellBookButtons,mainMenu, 0, false);
	}
	internal function submenuSoulforce():void {
		//if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 5) {
		//clearOutput();
		//outputText("You try to ready a special attack, but wind up stumbling dizzily instead.  <b>Your ability to use physical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
		//enemyAI();
		//return;
		//}
		submenu(soulforceButtons,mainMenu);
	}
	internal function submenuOther():void {
		submenu(otherButtons,mainMenu);
	}
}
}
