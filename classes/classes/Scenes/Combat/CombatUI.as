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
	private var soulforceButtons:/*ButtonData*/Array = [];
	private var otherButtons:/*ButtonData*/Array = [];
	public function mainMenu():void {
		menu();
		magspButtons.splice(0);
		physpButtons.splice(0);
		spellButtons.splice(0);
		soulforceButtons.splice(0);
		otherButtons.splice(0);
		
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
		combat.mspecials.buildMenu(this);
		combat.pspecials.buildMenu(this);
//		combat..buildMenu(this);
//		combat..buildMenu(this);
//		combat..buildMenu(this);
		if (physpButtons.length > 0) btnPSpecials.show("P. Specials", submenuPhySpecials, "Physical special attack menu.", "Physical Specials");
		if (magspButtons.length > 0) btnMSpecials.show("M. Specials", submenuMagSpecials, "Mental and supernatural special attack menu.", "Magical Specials");
//		if (magicButtons.length > 0) btnMagic.show("Spells", submenuMagic, "Opens your spells menu, where you can cast any spells you have learned.", "Spells");
		// if (!canUseMagic()) btnMagic.disable();
//		//Silence: Disables magic menu.
//		if (isPlayerSilenced()) {
//			removeButton(5);
//		}
//		if (soulSkillButtons.length > 0) btnSoulskills.show("Soulforce", submenuSoulskills, "Soulforce attacks menu.", "Soulforce Specials");
//		if (otherButtons.length > 0) btnOther.show("Other", submenuOther, "Combat options and uncategorized actions");
		
		btnFantasize.show("Fantasize", combat.fantasize, "Fantasize about your opponent in a sexual way.  Its probably a pretty bad idea to do this unless you want to end up getting raped.");
		btnTease.show("Tease", combat.teaseAttack, "Attempt to make an enemy more aroused by striking a seductive pose and exposing parts of your body.");
		btnWait.show("Wait", combat.wait, "Take no action for this round.  Why would you do this?  This is a terrible idea.");
		btnRun.show("Run", combat.runAway, "Choosing to run will let you try to escape from your enemy. However, it will be hard to escape enemies that are faster than you and if you fail, your enemy will get a free attack.");
		
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
		} else if (monster.hasStatusEffect(StatusEffects.Constricted)) {
			menu();
			addButton(0, "Squeeze", kGAMECLASS.desert.nagaScene.naggaSqueeze).hint("Squeeze some HP out of your opponent! \n\nFatigue Cost: " + physicalCost(20) + "");
			addButton(1, "Tease", kGAMECLASS.desert.nagaScene.naggaTease);
			addButton(4, "Release", kGAMECLASS.desert.nagaScene.nagaLeggoMyEggo);
		} else if (monster.hasStatusEffect(StatusEffects.ConstrictedScylla)) {
			menu();
			addButton(0, "Squeeze", combat.ScyllaSqueeze);
			if (monster.plural) {
				button(0).hint("Squeeze your foes with your tentacles attempting to break them appart! \n\nFatigue Cost: " + physicalCost(50) + "");
			} else {
				button(0).hint("Squeeze your foe with your tentacle attempting to break it appart! \n\nFatigue Cost: " + physicalCost(20) + "");
			}
			addButton(1, "Tease", combat.ScyllaTease).hint("Use a free limb to caress and pleasure your grappled foe. \n\nFatigue Cost: " + physicalCost(20) + "");
			addButton(4, "Release", combat.ScyllaLeggoMyEggo);
		} else if (monster.hasStatusEffect(StatusEffects.GooEngulf)) {
			menu();
			addButton(0, "Tease", combat.GooTease).hint("Mold limb to caress and pleasure your grappled foe. \n\nFatigue Cost: " + physicalCost(20) + "");
			addButton(4, "Release", combat.GooLeggoMyEggo);
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
		var bd:ButtonData = new ButtonData(text,callback,toolTipText,toolTipHeader);
		magspButtons.push(bd);
		return bd;
	}
	internal function addPhySpButton(text:String, callback:Function =null, toolTipText:String ="", toolTipHeader:String =""):ButtonData {
		var bd:ButtonData = new ButtonData(text,callback,toolTipText,toolTipHeader);
		physpButtons.push(bd);
		return bd;
	}
	internal function addSpellButton(text:String, callback:Function =null, toolTipText:String ="", toolTipHeader:String =""):ButtonData {
		var bd:ButtonData = new ButtonData(text,callback,toolTipText,toolTipHeader);
		spellButtons.push(bd);
		return bd;
	}
	internal function addSoulforceButton(text:String, callback:Function =null, toolTipText:String ="", toolTipHeader:String =""):ButtonData {
		var bd:ButtonData = new ButtonData(text,callback,toolTipText,toolTipHeader);
		soulforceButtons.push(bd);
		return bd;
	}
	private function submenu(list:/*ButtonData*/Array,page:int,self:Function):void {
		list = list.filter(function(e:ButtonData,i:int,a:Array):Boolean{
			return e.visible;
		}).sortOn('text');
		menu();
		var total:int = list.length;
		var n:int = Math.min(total,(page+1)*12);
		for (var bi:int = 0,li:int=page*12; li<n; li++,bi++) {
			list[li].applyTo(button(bi%12));
		}
		button(12).show("< Prev", curry(self, page-1)).disableIf(page==0);
		button(13).show("Next >", curry(self, page+1)).disableIf(n>=total);
		button(14).show("Back",mainMenu);
	}
	internal function submenuMagSpecials(page:int =0):void {
		if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && (player.statusEffectv2(StatusEffects.Sealed) == 6 || player.statusEffectv2(StatusEffects.Sealed) == 10)) {
			clearOutput();
			if (player.statusEffectv2(StatusEffects.Sealed) == 6) outputText("You try to ready a special ability, but wind up stumbling dizzily instead.  <b>Your ability to use magical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
			if (player.statusEffectv2(StatusEffects.Sealed) == 10) outputText("You try to use a magical ability but you are currently silenced by the alraune vines!\n\n");
			enemyAI();
			return;
		}
		submenu(magspButtons,page,submenuMagSpecials);
	}
	internal function submenuPhySpecials(page:int =0):void {
		if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 5) {
			clearOutput();
			outputText("You try to ready a special attack, but wind up stumbling dizzily instead.  <b>Your ability to use physical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
			enemyAI();
			return;
		}
		if (player.hasStatusEffect(StatusEffects.TaintedMind)) {
			(monster as DriderIncubus).taintedMindAttackAttempt();
			return;
		}
		submenu(physpButtons,page,submenuPhySpecials);
	}
	internal function submenuOther(page:int=0):void {
		//addButton(11, "Surrender", surrender).hint("Fantasize about your opponent in a sexual way so much it would fill up your lust you'll end up getting raped.");
//		if (player.findPerk(PerkLib.DoubleAttack) >= 0 || player.findPerk(PerkLib.DoubleAttackLarge) >= 0 || player.findPerk(PerkLib.Combo) >= 0 || player.findPerk(PerkLib.DoubleStrike) >= 0 || player.findPerk(PerkLib.ElementalArrows) >= 0 || player.findPerk(PerkLib.Cupid) >= 0 || player.statusEffectv1(StatusEffects.SummonedElementals) >= 1) addButton(12,"Combat Options",combatOptionsSubMenu);
//		if (CoC_Settings.debugBuild && !debug) addButton(13, "Inspect", debugInspect).hint("Use your debug powers to inspect your enemy.");
//		if (player.findPerk(PerkLib.JobDefender) >= 0) addButton(9, "Defend", defendpose).hint("Take no offensive action for this round.  Why would you do this?  Maybe because you will assume defensive pose?");
//		if (!player.isFlying() && monster.isFlying()) {
//			if (player.canFly()) addButton(0, "Take Flight", takeFlight).hint("Make use of your wings to take flight into the air for up to 7 turns. \n\nGives bonus to evasion, speed but also giving penalties to accuracy of range attacks or spells. Not to meantion for non spear users to attack in melee range.");
//			else addButtonDisabled(0, "P. Specials", "No way you could reach enemy in air with p. specials.");
//		}
//		else if (player.isFlying()) addButton(0, "Great Dive", greatDive).hint("Make a Great Dive to deal TONS of damage!");
	
	}
}
}
