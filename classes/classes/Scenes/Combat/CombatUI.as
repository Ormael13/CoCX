/**
 * Coded by aimozg on 27.09.2017.
 */
package classes.Scenes.Combat {
import classes.BodyParts.Face;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.Scenes.Areas.Desert.SandTrap;
import classes.Scenes.Areas.Forest.Alraune;
import classes.Scenes.Areas.HighMountains.Izumi;
import classes.Scenes.Dungeons.D3.DriderIncubus;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.D3.SuccubusGardener;
import classes.Scenes.NPCs.Ceraph;
import classes.Scenes.NPCs.Yamata;
import classes.Scenes.SceneLib;
import classes.StatusEffectClass;
import classes.StatusEffects;

import coc.view.ButtonDataList;
import coc.view.CoCButton;

public class CombatUI extends BaseCombatContent {
	
	public function CombatUI() {
	}
	
	private var magspButtons:ButtonDataList = new ButtonDataList();
	private var physpButtons:ButtonDataList = new ButtonDataList();
	private var spellButtons:ButtonDataList = new ButtonDataList();
	private var soulforceButtons:ButtonDataList = new ButtonDataList();
	private var otherButtons:ButtonDataList = new ButtonDataList();
	public function mainMenu():void {
		menu();
		magspButtons.clear();
		physpButtons.clear();
		spellButtons.clear();
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
		if (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 2) {
			btnMelee.show("E.Attack", combat.baseelementalattacks, "Command your elemental to attack the enemy.  Damage it will deal is affcted by your wisdom and intelligence.");
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
			if (player.isInGoblinMech()) {
				if (monster.isFlying()) {
					if (player.isFlying()) btnMelee.show("Sawblade", combat.basemechmeleeattacks, "Attempt to attack the enemy with your mech sawblade.  Damage done is determined by your strength and weapon.");
					else btnMelee.disable("No way you could reach enemy in air with melee attacks.");
				}
				else btnMelee.show("Sawblade", combat.basemechmeleeattacks, "Attempt to attack the enemy with your mech sawblade.  Damage done is determined by your strength and weapon.");
			}
			else {
				if (monster.isFlying()) {
					if (player.isFlying() || player.haveThrowableMeleeWeapon()) {
						if (player.isFlying()) {
							if (player.hasPerk(PerkLib.AerialCombat)) {
								if (player.wings.type == Wings.BAT_ARM) btnMelee.disable("No way you could use your melee weapon with those arms while flying.");
								else btnMelee.show("Attack", combat.basemeleeattacks, "Attempt to attack the enemy with your " + player.weaponName+".  Damage done is determined by your strength and weapon.");
							}
							else btnMelee.disable("No way you could hit enemy with melee attacks while flying.");
						}
						else btnMelee.show("Attack", combat.basemeleeattacks, "Attempt to attack the enemy with your " + player.weaponName+".  Damage done is determined by your strength and weapon.");
					}
					else btnMelee.disable("No way you could reach enemy in air with melee attacks.");
				}
				else btnMelee.show("Attack", combat.basemeleeattacks, "Attempt to attack the enemy with your " + player.weaponName+".  Damage done is determined by your strength and weapon.");
			}
		}
		// Ranged
		switch (player.weaponRangePerk) {
			case "Bow":
				btnRanged.show("Bow", combat.fireBow, "Attempt to attack the enemy with your " + player.weaponRangeName + ".  Damage done is determined by your speed and weapon.");
				break;
			case "Crossbow":
				btnRanged.show("Crossbow", combat.fireBow, "Attempt to attack the enemy with your " + player.weaponRangeName + ".  Damage done is determined only by your weapon.");
				break;
			case "Throwing":
                btnRanged.show("Throw", combat.fireBow, "Attempt to throw " + player.weaponRangeName + " at enemy.  Damage done is determined by your strength and weapon.");
                if (player.ammo <= 0 && player.weaponRange != weaponsrange.SHUNHAR) btnRanged.disable("You have used all your throwing weapons in this fight.");
				break;
			case "Pistol":
			case "Rifle":
                if (player.ammo <= 0)
                    btnRanged.show("Reload", combat.reloadWeapon1, "Your " + player.weaponRangeName + " is out of ammo.  You'll have to reload it before attack.");
                else btnRanged.show("Shoot", combat.fireBow, "Fire a round at your opponent with your " + player.weaponRangeName + "!  Damage done is determined only by your weapon.");
				break;
			default:
				btnRanged.showDisabled("Shoot");
		}
		if (player.isFlying() && player.wings.type == Wings.BAT_ARM){btnRanged.disable("It would be rather difficult to aim while flapping your arms."); }
		if (player.isInGoblinMech()) {
			if (player.hasKeyItem("Repeater Gun") >= 0 || player.hasKeyItem("Machine Gun MK1") >= 0 || player.hasKeyItem("Machine Gun MK2") >= 0 || player.hasKeyItem("Machine Gun MK3") >= 0) {
				if (player.weaponRangePerk == "Pistol" || player.weaponRangePerk == "Rifle" || player.weaponRangePerk == "2H Firearm") {
					if (player.isUsingGoblinMechFriendlyFirearms()) btnRanged.show("Shoot", combat.fireBow, "Fire a round at your opponent with your " + player.weaponRangeName + "!  Damage done is determined only by your weapon.");
					else btnRanged.disable("Your firearms is not compatibile to be used with current piloted mech.");
				}
				else btnRanged.disable("You could use your range weapon while piloting goblin mech if it would be any form of firearms.");
			}
			else btnRanged.disable("No way you could use your range weapon while piloting goblin mech.");
		}
		btnItems.show("Items", inventory.inventoryMenu, "The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.");
		
		// Submenus
		
		// Submenu - Physical Specials
		if (player.isFlying()) combat.pspecials.buildMenuForFlying(physpButtons);
		else combat.pspecials.buildMenu(physpButtons);
		if (physpButtons.length > 0) {
			if (player.isInGoblinMech()) btnPSpecials.show("Mech", submenuPhySpecials, "Mech special attacks menu.", "Mech Specials");
			else btnPSpecials.show("P. Specials", submenuPhySpecials, "Physical special attack menu.", "Physical Specials");
		}
		if (!player.isFlying() && monster.isFlying() && !player.canFly()) {
			if (player.isInGoblinMech()) btnPSpecials.show("Mech", submenuPhySpecials, "Mech special attacks menu.", "Mech Specials");
			else btnPSpecials.disable("No way you could reach enemy in air with p. specials.");
		}
		// Submenu - Magical Specials
		combat.mspecials.buildMenu(magspButtons);
		if (magspButtons.length > 0) btnMSpecials.show("M. Specials", submenuMagSpecials, "Mental and supernatural special attack menu.", "Magical Specials");
		if (combat.isPlayerSilenced()) {
			btnMSpecials.disable();
		}
		// Submenu - Spells
		combat.magic.buildMenu(spellButtons);
		if (spellButtons.length > 0) btnMagic.show("Spells", submenuSpells, "Opens your spells menu, where you can cast any spells you have learned.", "Spells");
		if (player.hasStatusEffect(StatusEffects.OniRampage)) {
			btnMagic.disable("You are too angry to think straight. Smash your puny opponents first and think later.\n\n");
		} else if (!combat.canUseMagic()) {
			btnMagic.disable();
		}
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
		else btnTease.show("Tease", combat.teaseAttack, "Attempt to make an enemy more aroused by striking a seductive pose and exposing parts of your body.");
		btnWait.show("Wait", combat.wait, "Take no action for this round.  Why would you do this?  This is a terrible idea.");
		if (monster.hasStatusEffect(StatusEffects.CreepingDoom)) btnRun.show("Struggle", combat.struggleCreepingDoom, "Shake away the pests.");
		else btnRun.show("Run", combat.runAway, "Choosing to run will let you try to escape from your enemy. However, it will be hard to escape enemies that are faster than you and if you fail, your enemy will get a free attack.");
		
		// Modifications - full or partial replacements
		if (isPlayerBound()) {
			mainMenuWhenBound();
		} else if (isPlayerStunned()) {
			menu();
			addButton(0, "Recover", combat.wait);
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
		} else if (monster.hasStatusEffect(StatusEffects.HypnosisNaga) && !monster.hasStatusEffect(StatusEffects.Constricted)) {
			menu();
			addButton(0, "Heal", combat.HypnosisHeal);
			addButton(1, "Attack", combat.HypnosisAttack);
			addButton(2, "Coil", combat.HypnosisCoil);
			if (player.hasPerk(PerkLib.HollowFangsEvolved)) {
				addButton(3, "Bite", combat.VampiricBite).hint("Suck on the blood of an opponent. \n\nFatigue Cost: " + physicalCost(20) + "");
				if (player.fatigueLeft() <= combat.physicalCost(20)) {
					button(3).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
				}
			}
			addButton(4, "Maintain", combat.HypnosisMaintain);
		} else if (monster.hasStatusEffect(StatusEffects.HypnosisNaga) && monster.hasStatusEffect(StatusEffects.Constricted)) {
			menu();
			addButton(0, "Squeeze", SceneLib.desert.nagaScene.naggaSqueeze).hint("Squeeze some HP out of your opponent! Break hypnosis! \n\nFatigue Cost: " + physicalCost(20) + "");
			addButton(1, "Tease", SceneLib.desert.nagaScene.naggaTease).hint("Deals lesser lust damage. Does not break hypnosis.");
			if (player.hasPerk(PerkLib.HollowFangsEvolved)) {
				addButton(3, "Bite", combat.VampiricBite).hint("Suck on the blood of an opponent. Break hypnosis! \n\nFatigue Cost: " + physicalCost(20) + "");
				if (player.fatigueLeft() <= combat.physicalCost(20)) {
					button(3).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
				}
			}
			addButton(4, "Maintain", combat.HypnosisMaintain);
		} else if (monster.hasStatusEffect(StatusEffects.Constricted) && !monster.hasStatusEffect(StatusEffects.HypnosisNaga)) {
			menu();
			addButton(0, "Squeeze", SceneLib.desert.nagaScene.naggaSqueeze).hint("Squeeze some HP out of your opponent! \n\nFatigue Cost: " + physicalCost(20) + "");
			addButton(1, "Tease", SceneLib.desert.nagaScene.naggaTease);
			if (player.hasPerk(PerkLib.HollowFangsEvolved)) {
				addButton(3, "Bite", combat.VampiricBite).hint("Suck on the blood of an opponent. \n\nFatigue Cost: " + physicalCost(20) + "");
				if (player.fatigueLeft() <= combat.physicalCost(20)) {
					button(3).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
				}
			}
			addButton(4, "Release", SceneLib.desert.nagaScene.nagaLeggoMyEggo);
		} else if (monster.hasStatusEffect(StatusEffects.ConstrictedScylla)) {
			menu();
			addButton(0, "Squeeze", combat.ScyllaSqueeze);
			if (monster.plural) {
				button(0).hint("Squeeze your foes with your tentacles attempting to break them appart! \n\nFatigue Cost: " + physicalCost(50) + "");
			} else {
				button(0).hint("Squeeze your foe with your tentacle attempting to break it appart! \n\nFatigue Cost: " + physicalCost(20) + "");
			}
			addButton(1, "Tease", combat.ScyllaTease).hint("Use a free limb to caress and pleasure your grappled foe. \n\nFatigue Cost: " + physicalCost(20) + "");
			if (player.hasPerk(PerkLib.HollowFangsEvolved)) {
				addButton(3, "Bite", combat.VampiricBite).hint("Suck on the blood of an opponent. \n\nFatigue Cost: " + physicalCost(20) + "");
				if (player.fatigueLeft() <= combat.physicalCost(20)) {
					button(3).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
				}
			}
			addButton(4, "Release", combat.ScyllaLeggoMyEggo);
		} else if (monster.hasStatusEffect(StatusEffects.GooEngulf)) {
			menu();
			addButton(0, "Tease", combat.GooTease).hint("Mold limb to caress and pleasure your grappled foe. \n\nFatigue Cost: " + physicalCost(20) + "");
			if (player.hasPerk(PerkLib.HollowFangsEvolved)) {
				addButton(3, "Bite", combat.VampiricBite).hint("Suck on the blood of an opponent. \n\nFatigue Cost: " + physicalCost(20) + "");
				if (player.fatigueLeft() <= combat.physicalCost(20)) {
					button(3).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
				}
			}
			addButton(4, "Release", combat.GooLeggoMyEggo);
		} else if (monster.hasStatusEffect(StatusEffects.EmbraceVampire)) {
			menu();
			if (player.faceType == Face.VAMPIRE || player.hasPerk(PerkLib.HollowFangs)) {
				addButton(0, "Bite", combat.VampiricBite).hint("Suck on the blood of an opponent. \n\nFatigue Cost: " + physicalCost(20) + "");
				if (player.fatigueLeft() <= combat.physicalCost(20)) {
					button(0).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
				}
			}
			else addButtonDisabled(0, "Bite", "If only you had fangs.");
			addButton(4, "Release", combat.VampireLeggoMyEggo);
		} else if (monster.hasStatusEffect(StatusEffects.Pounce)) {
			menu();
			addButton(0, "Claws", combat.clawsRend).hint("Rend your enemy using your claws. \n\nFatigue Cost: " + physicalCost(20) + "");
			if ((player.hasPerk(PerkLib.PhantomStrike) && (player.fatigueLeft() <= combat.physicalCost(40))) || (!player.hasPerk(PerkLib.PhantomStrike) && (player.fatigueLeft() <= combat.physicalCost(20)))) {
				button(0).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
			}
			if (player.hasPerk(PerkLib.HollowFangsEvolved)) {
				addButton(3, "Bite", combat.VampiricBite).hint("Suck on the blood of an opponent. \n\nFatigue Cost: " + physicalCost(20) + "");
				if (player.fatigueLeft() <= combat.physicalCost(20)) {
					button(3).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
				}
			}
			addButton(4, "Release", combat.PussyLeggoMyEggo);
		} else if (monster.hasStatusEffect(StatusEffects.GrabBear)) {
			menu();
			addButton(0, "Hug", combat.bearHug).hint("Crush your opponent with a bear hug. \n\nFatigue Cost: " + physicalCost(30) + "");
			if (player.hasPerk(PerkLib.HollowFangsEvolved)) {
				addButton(3, "Bite", combat.VampiricBite).hint("Suck on the blood of an opponent. \n\nFatigue Cost: " + physicalCost(20) + "");
				if (player.fatigueLeft() <= combat.physicalCost(20)) {
					button(3).disable("You are too tired to bite " + monster.a + " " + monster.short + ".");
				}
			}
			addButton(4, "Release", combat.BearLeggoMyEggo);
		} else if (player.hasPerk(PerkLib.JobLeader) && flags[kFLAGS.WILL_O_THE_WISP] == 0 && flags[kFLAGS.IN_COMBAT_PLAYER_WILL_O_THE_WISP_ATTACKED] != 1) {
			combat.willothewispattacks();
		} else if (player.hasPerk(PerkLib.FirstAttackElementals) && flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 3 && flags[kFLAGS.IN_COMBAT_PLAYER_ELEMENTAL_ATTACKED] != 1) {
			menu();
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir)) addButton(0, "Air", combat.baseelementalattacks, Combat.AIR);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth)) addButton(1, "Earth", combat.baseelementalattacks, Combat.EARTH);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire)) addButton(2, "Fire", combat.baseelementalattacks, Combat.FIRE);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater)) addButton(3, "Water", combat.baseelementalattacks, Combat.WATER);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther)) addButton(4, "Ether", combat.baseelementalattacks, Combat.ETHER);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood)) addButton(5, "Wood", combat.baseelementalattacks, Combat.WOOD);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal)) addButton(6, "Metal", combat.baseelementalattacks, Combat.METAL);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce)) addButton(7, "Ice", combat.baseelementalattacks, Combat.ICE);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning)) addButton(8, "Lightning", combat.baseelementalattacks, Combat.LIGHTNING);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) addButton(9, "Darkness", combat.baseelementalattacks, Combat.DARKNESS);
		} else if (player.hasPerk(PerkLib.FirstAttackGolems) && flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] == 1 && flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] != 1 && player.mana >= combat.pspecials.pernamentgolemsendcost()) {
			menu();
			addButton(0, "Send P.Gol/1", combat.pspecials.sendPernamentGolem1);
			if (monster.plural) {
				if (flags[kFLAGS.PERNAMENT_GOLEMS_BAG] > 2) {
					if (player.mana >= combat.pspecials.pernamentgolemsendcost() * 3) addButton(1, "Send P.Gol/3", combat.pspecials.sendPernamentGolem3);
					else addButtonDisabled(1, "Send P.Gol/3", "Not enough mana.");
				}
				if (flags[kFLAGS.PERNAMENT_GOLEMS_BAG] > 4) {
					if (player.mana >= combat.pspecials.pernamentgolemsendcost() * 5) addButton(2, "Send P.Gol/5", combat.pspecials.sendPernamentGolem5);
					else addButtonDisabled(2, "Send P.Gol/5", "Not enough mana.");
				}
			}
		} else if (flags[kFLAGS.PLAYER_COMPANION_1] != "" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) {
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Alvina") combat.comfoll.alvinaCombatActions();
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Aurora") combat.comfoll.auroraCombatActions();
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Etna") combat.comfoll.etnaCombatActions();
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Mitzi") combat.comfoll.mitziCombatActions();
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Neisa") combat.comfoll.neisaCombatActions();
		} else if (flags[kFLAGS.PLAYER_COMPANION_2] != "" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) {
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Alvina") combat.comfoll.alvinaCombatActions();
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Aurora") combat.comfoll.auroraCombatActions();
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Etna") combat.comfoll.etnaCombatActions();
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Mitzi") combat.comfoll.mitziCombatActions();
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Neisa") combat.comfoll.neisaCombatActions();
		} else if (flags[kFLAGS.PLAYER_COMPANION_3] != "" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) {
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Alvina") combat.comfoll.alvinaCombatActions();
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Aurora") combat.comfoll.auroraCombatActions();
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Etna") combat.comfoll.etnaCombatActions();
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Mitzi") combat.comfoll.mitziCombatActions();
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Neisa") combat.comfoll.neisaCombatActions();
		}
		
		// Modifications - monster-special actions
		if (monster is SandTrap) {
			btnSpecial1.show("Climb", combat.wait2, "Climb the sand to move away from the sand trap.");
		} else if (monster is Alraune) {
			if (player.fatigueLeft() < 50) btnSpecial1.disable("You're too tired to struggle.");
			else btnSpecial1.show("Struggle", combat.wait2, "Struggle to forcefully pull yourself a good distance away from plant woman.");
		} else if (monster is DriderIncubus) {
			var drider:DriderIncubus = monster as DriderIncubus;
			if (!drider.goblinFree) btnSpecial1.show("Free Goblin", drider.freeGoblin);
		} else if (monster is Lethice) {
			var lethice:Lethice = monster as Lethice;
			if (player.hasStatusEffect(StatusEffects.LethicesRapeTentacles)) {
				if (player.lust < combat.magic.getWhiteMagicLustCap()
					&& player.hasStatusEffect(StatusEffects.KnowsWhitefire)
					&& !player.hasPerk(PerkLib.BloodMage)
					&& player.mana >= 30) {
					btnSpecial1.show("Dispell", lethice.dispellRapetacles);
				}
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
		if (player.hasStatusEffect(StatusEffects.Bound)) {
			btnStruggle.call((monster as Ceraph).ceraphBindingStruggle);
			btnBoundWait.call((monster as Ceraph).ceraphBoundWait);
		}
		if (player.hasStatusEffect(StatusEffects.Chokeslam)) {
			btnStruggle.call((monster as Izumi).chokeSlamStruggle);
			btnBoundWait.call((monster as Izumi).chokeSlamWait);
		}
		if (player.hasStatusEffect(StatusEffects.Titsmother)) {
			btnStruggle.call((monster as Izumi).titSmotherStruggle);
			btnBoundWait.call((monster as Izumi).titSmotherWait);
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
			if (player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < (10 + player.corruptionTolerance())) whitefireLustCap += (player.maxLust() * 0.1);
			if (player.findPerk(PerkLib.FocusedMind) >= 0 && player.findPerk(PerkLib.GreyMage) < 0) whitefireLustCap += (player.maxLust() * 0.1);
			if (player.findPerk(PerkLib.GreyMage) >= 0) whitefireLustCap = (player.maxLust() - 45);
			if (player.findPerk(PerkLib.GreyMage) >= 0 && player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < (10 + player.corruptionTolerance())) whitefireLustCap = (player.maxLust() - 15);
			var gotEnergy:Boolean = player.findPerk(PerkLib.BloodMage) < 0 && player.mana >= 30;
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
			if (!isPlayerBound() && !isPlayerSilenced() && !isPlayerStunned()) {
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
						btnContinue.show("Continue", combat.magic.spellPolarMidnight, "Continue casting Polar Midnight spell.");
						break;
					case 6:
						btnContinue.show("Continue", combat.magic.spellMeteorShower, "Continue casting Meteor Shower spell.");
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
		submenu(spellButtons,mainMenu);
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
