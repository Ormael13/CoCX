/**
 * Coded by aimozg on 27.09.2017.
 */
package classes.Scenes.Combat {
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.PerkLib;
import classes.Scenes.Areas.Desert.SandTrap;
import classes.Scenes.Areas.Forest.Alraune;
import classes.Scenes.Areas.HighMountains.Izumi;
import classes.Scenes.Dungeons.D3.DriderIncubus;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.D3.SuccubusGardener;
import classes.Scenes.NPCs.Ceraph;
import classes.StatusEffectClass;
import classes.StatusEffects;

import coc.view.ButtonData;

import coc.view.CoCButton;

public class CombatUI extends BaseCombatContent {
	
	public function CombatUI() {
	}
	
	private var magspButtons:/*ButtonData*/Array = [];
	private var physpButtons:/*ButtonData*/Array = [];
	private var spellButtons:/*ButtonData*/Array = [];
	public function mainMenu():void {
		menu();
		
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
		} else {
			btnMelee.show("Attack", combat.basemeleeattacks, "Attempt to attack the enemy with your "+player.weaponName+".  Damage done is determined by your strength and weapon.");
			if (!player.isFlying() && monster.isFlying()) {
				btnMelee.disable("No way you could reach enemy in air with melee attacks.");
			} else if (player.isFlying()
					   && player.weapon != weapons.SPEAR && player.weapon != weapons.LANCE) {
				btnMelee.disable("No way you could reach enemy with melee attacks while flying.");
			} else if (player.hasStatusEffect(StatusEffects.KnockedBack)) {
				outputText("\n<b>You'll need to close some distance before you can use any physical attacks!</b>");
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
				if ( player.ammo <= 0 && player.weaponRange != weaponsrange.SHUNHAR) btnRanged.disable("You have used all your throwing weapons in this fight.");
				break;
			case "Pistol":
			case "Rifle":
				if (player.ammo <= 0)
					btnRanged.show("Reload", combat.reloadWeapon, "Your " + player.weaponRangeName + " is out of ammo.  You'll have to reload it before attack.");
				else btnRanged.show("Shoot", combat.fireBow, "Fire a round at your opponent with your " + player.weaponRangeName + "!  Damage done is determined only by your weapon.");
				break;
			default:
				btnRanged.showDisabled("Shoot");
		}
		btnItems.show("Items", inventory.inventoryMenu, "The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.");

		// Submenus
		buildSubmenus();
//		if (pspcButtons.length > 0) btnPSpecials.show("P. Specials", submenuPSpecials, "Physical special attack menu.", "Physical Specials");
		if (magspButtons.length > 0) btnMSpecials.show("M. Specials", submenuMSpecials, "Mental and supernatural special attack menu.", "Magical Specials");
//		if (magicButtons.length > 0) btnMagic.show("Spells", submenuMagic, "Opens your spells menu, where you can cast any spells you have learned.", "Spells");
//		if (soulSkillButtons.length > 0) btnSoulskills.show("Soulforce", submenuSoulskills, "Soulforce attacks menu.", "Soulforce Specials");
//		if (otherButtons.length > 0) btnOther.show("Other", submenuOther, "Combat options and uncategorized actions");
		
		btnFantasize.show("Fantasize", combat.fantasize, "Fantasize about your opponent in a sexual way.  Its probably a pretty bad idea to do this unless you want to end up getting raped.");
		btnTease.show("Tease", combat.teaseAttack, "Attempt to make an enemy more aroused by striking a seductive pose and exposing parts of your body.");
		btnWait.show("Wait", combat.wait, "Take no action for this round.  Why would you do this?  This is a terrible idea.");
		btnRun.show("Run", combat.runAway, "Choosing to run will let you try to escape from your enemy. However, it will be hard to escape enemies that are faster than you and if you fail, your enemy will get a free attack.");
		
		// Modifications - full replacements
		if (isPlayerBound()) {
			mainMenuWhenBound();
		} else if (isPlayerStunned()) {
			menu();
			addButton(0, "Recover", combat.wait);
		} else if (player.hasStatusEffect(StatusEffects.ChanneledAttack)) {
			mainMenuWhenChanneling();
		}
		
		// Modifications - monster-special actions
		if (monster is SandTrap) {
			btnSpecial1.show("Climb", (monster as SandTrap).sandTrapWait, "Climb the sand to move away from the sand trap.");
		} else if (monster is Alraune) {
			btnSpecial1.show("Struggle", (monster as Alraune).alrauneWait, "Struggle to forcefully pull yourself a good distance away from plant woman.");
			if (player.fatigueLeft() < 50) btnSpecial1.disable("You're too tired to struggle.");
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
		if (player.hasStatusEffect(StatusEffects.UBERWEB)) {
			addButton(6, "M. Special", submenuMSpecials);
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
		else if (player.hasStatusEffect(StatusEffects.LethicesRapeTentacles) && player.statusEffectv3(StatusEffects.LethicesRapeTentacles) == 1) {
			outputText("\n<b>Lethice's tentacles have a firm grip of your limbs!</b>");
			addButton(0, "Struggle", (monster as Lethice).grappleStruggle);
			addButton(5, "Wait", (monster as Lethice).grappleWait);
			
			var whitefireLustCap:int = player.maxLust() * 0.75;
			if (player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < (10 + player.corruptionTolerance())) whitefireLustCap += (player.maxLust() * 0.1);
			if (player.findPerk(PerkLib.FocusedMind) >= 0 && player.findPerk(PerkLib.GreyMage) < 0) whitefireLustCap += (player.maxLust() * 0.1);
			if (player.findPerk(PerkLib.GreyMage) >= 0) whitefireLustCap = (player.maxLust() - 45);
			if (player.findPerk(PerkLib.GreyMage) >= 0 && player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < (10 + player.corruptionTolerance())) whitefireLustCap = (player.maxLust() - 15);
			var gotEnergy:Boolean = player.findPerk(PerkLib.BloodMage) < 0 && player.mana >= 30;
			if (player.lust < whitefireLustCap && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && gotEnergy) {
				addButton(1, "Dispell", (monster as Lethice).dispellRapetacles);
			}
		}
	}
	
	internal function mainMenuWhenChanneling():void {
		menu();
		var chatk:StatusEffectClass  = player.statusEffectByType(StatusEffects.ChanneledAttack);
		var chtype:StatusEffectClass = player.statusEffectByType(StatusEffects.ChanneledAttackType);
		var btnContinue:CoCButton    = button(0);
		var btnStop:CoCButton        = button(1);
		btnStop.show("Stop", combat.stopChanneledSpecial, "Stop singing.");
		if (chatk && chatk.value1 >= 1) {
			if (!isPlayerBound() && !isPlayerSilenced() && !isPlayerStunned()) {
				switch (chtype.value1) {
					case 1:
						btnContinue.show("Continue", combat.mspecials.singCompellingAria, "Continue singing.");
						break;
					case 2:
						btnContinue.show("Continue", combat.mspecials.startOniRampage, "Continue starting rampage.");
						break;
				}
			}
		}
	}
	
	internal function addMagSpButton(text:String, callback:Function =null, toolTipText:String ="", toolTipHeader:String =""):ButtonData {
		var bd:ButtonData = new ButtonData(text);
		magspButtons.push(bd);
		return bd;
	}
	internal function addPhySpButton(text:String, callback:Function =null, toolTipText:String ="", toolTipHeader:String =""):ButtonData {
		var bd:ButtonData = new ButtonData(text);
		physpButtons.push(bd);
		return bd;
	}
	internal function addSpellButton(text:String, callback:Function =null, toolTipText:String ="", toolTipHeader:String =""):ButtonData {
		var bd:ButtonData = new ButtonData(text);
		spellButtons.push(bd);
		return bd;
	}
	internal function submenuMSpecials(page:int=0):void {
		if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && (player.statusEffectv2(StatusEffects.Sealed) == 6 || player.statusEffectv2(StatusEffects.Sealed) == 10)) {
			clearOutput();
			if (player.statusEffectv2(StatusEffects.Sealed) == 6) outputText("You try to ready a special ability, but wind up stumbling dizzily instead.  <b>Your ability to use magical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
			if (player.statusEffectv2(StatusEffects.Sealed) == 10) outputText("You try to use a magical ability but you are currently silenced by the alraune vines!\n\n");
			enemyAI();
			return;
		}
		magspButtons.sortOn('text');
		menu();
		var total:int = magspButtons.length;
		var n:int = Math.min(total,(page+1)*12);
		for (var i:int = page*12; i<n; i++) {
			magspButtons[i].applyTo(button(i));
		}
		if (page>0) {
			button(12).show("< Prev", curry(submenuMSpecials, page-1));
		}
		if (n < total) {
			button(13).show("Next >", curry(submenuMSpecials, page+1));
		}
		button(14).show("Back",mainMenu);
	}
	private function buildSubmenus():void {
//		combat.pspecials.buildMenu(this);
		combat.mspecials.buildMenu(this);
//		combat..buildMenu(this);
//		combat..buildMenu(this);
//		combat..buildMenu(this);
	
	}
}
}
