/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{

import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.Player;
import classes.Race;
import classes.Scenes.SceneLib;

import coc.view.IconLib;

public class Weapon extends Equipable
	{
		private var _verb:String;
		private var _attack:Number;
		private var _type:String;
		private var _size:int;
		private var _dual:Boolean;
		
		override public function get category():String {
			return CATEGORY_WEAPON_MELEE;
		}
		
		public function Weapon(
				id:String,
				shortName:String,
				name:String,
				longName:String,
				verb:String,
				attack:Number,
				value:Number,
				description:String,
				type:String,
				size:int,
				dual:Boolean = false
		) {
			super(id, shortName, name, longName, value, description);
			this._verb = verb;
			this._attack = attack;
			this._type = type;
			this._size = size;
			this._dual = dual;
		}
		
		override public function get iconId():String {
			return IconLib.pickIcon(ownIconId, "I_GenericWeapon_"+type, super.iconId);
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS; // don't recreate every time
		}
		
		public function get verb():String {
			if (type == WT_STAFF && game.player.hasPerk(PerkLib.StaffChanneling)) return 'shot';
			return _verb;
		}
		
		public function get baseAttack():Number {
			return _attack;
		}
		public function get attack():Number {
			var baseAttack:Number = this.baseAttack;
			if (!CoC.instance || !CoC.instance.player) return baseAttack;
			var player:Player = CoC.instance.player;
			
			var baseAttackBonus:Number = 0;
			var scale:Number = 1; // scale factor
			var multiplier:Number = 100; // %
			var bonus:Number = 0;
			// result = (attack + baseAttackBonuss) * scale * (multiplier/100) + bonus
			
			var stat:Number;
			for each (var ie:ItemEffect in effectsFlagged(IEF_ATTACK)) {
				switch (ie.type) {
					//---------------------//
					// Base attack bonuses //
					//---------------------//
					case IELib.AttackBonus_Cor: {
						baseAttackBonus += ie.power * player.cor;
						break;
					}
					case IELib.AttackBonus_Purity: {
						baseAttackBonus += ie.power * (100 - player.cor);
						break;
					}
					case IELib.AttackBonus_Fem: {
						baseAttackBonus += ie.power * player.femininity;
						break;
					}
					case IELib.AttackBonus_Masc: {
						baseAttackBonus += ie.power * (100 - player.femininity);
						break;
					}
					//--------------//
					// Stat scaling //
					//--------------//
					case IELib.ScaleAttack_Str: {
						if (player.hasPerk(PerkLib.HiddenJobSwordImmortal)) break;
						// Strength non-massive
						stat = player.str * 100 / ie.power;
						if (stat < 50) {
							scale *= 0.05;
						} else if (stat < 75) {
							scale *= 0.25;
						} else if (stat < 100) {
							scale *= 0.50;
						}
						break;
					}
					case IELib.ScaleAttack_StrXL: {
						if (player.hasPerk(PerkLib.HiddenJobSwordImmortal)) break;
						// Strength massive
						stat = player.str * 100 / ie.power;
						if (stat < 40) {
							scale *= 0.05;
						} else if (stat < 60) {
							scale *= 0.25;
						} else if (stat < 80) {
							scale *= 0.50;
						} else if (stat < 100) {
							scale *= 0.75;
						}
						break;
					}
					case IELib.ScaleAttack_Spe: {
						if (player.hasPerk(PerkLib.HiddenJobSwordImmortal)) break;
						// Speed non-massive
						stat = player.spe * 100 / ie.power;
						if (stat < 50) {
							scale *= 0.05;
						} else if (stat < 75) {
							scale *= 0.25;
						} else if (stat < 100) {
							scale *= 0.50;
						}
						break;
					}
					//------------------------//
					// Multiplicative bonuses //
					//------------------------//
					case IELib.AttackMult_RaceTier: {
						multiplier += ie.power * player.racialTier(ie.value1 as Race);
						break;
					}
					//------------------//
					// Additive bonuses //
					//------------------//
					case IELib.AttackBonus_RaceTier: {
						bonus += ie.power * player.racialTier(ie.value1 as Race)
						break;
					}
				}
			}
			// Non-ItemEffect bonuses
			if (type == WT_WHIP && player.hasPerk(PerkLib.ArcaneLash)) {
				// double the attack, can be downscaled but not upscaled
				bonus += Math.min(bonus, baseAttack + baseAttackBonus);
			}
			if (hasTag(W_RAPIER)) {
				stat = player.getRapierTrainingLevel();
				// +1 +2 +4 +6 +8
				if (stat < 3) {
					bonus += stat;
				} else {
					bonus += stat*2 - 2;
				}
			}
			
			// Compute the total value.
			// result = (attack + baseAttackBonuss) * scale * (multiplier/100) + bonus
			var attack:Number = baseAttack;
			attack += baseAttackBonus;
			if (attack > 0) {
				attack = Math.max(1, attack*scale);
			}
			attack *= multiplier / 100;
			attack += bonus;
			
			return Math.round(attack);
		}
		
		public function get type():String { return _type; }
		
		public function get size():int { return _size; }
		
		public function isDual():Boolean { return _dual; }

		public function isSmall():Boolean { return size == WSZ_SMALL; }
		public function isMedium():Boolean { return size == WSZ_MEDIUM; }
		public function isLarge():Boolean { return size == WSZ_LARGE; }
		public function isMassive():Boolean { return size == WSZ_MASSIVE; }
		public function isDualSmall():Boolean { return isDual() && isSmall(); }
		public function isDualMedium():Boolean { return isDual() && isMedium(); }
		public function isDualLarge():Boolean { return isDual() && isLarge(); }
		public function isDualMassive():Boolean { return isDual() && isMassive(); }
		public function isSingleSmall():Boolean { return !isDual() && isSmall(); }
		public function isSingleMedium():Boolean { return !isDual() && isMedium(); }
		public function isSingleLarge():Boolean { return !isDual() && isLarge(); }
		public function isSingleMassive():Boolean { return !isDual() && isMassive(); }
		
		public function isHybrid():Boolean { return hasTag(W_HYBRID); }
		public function isStaffPart():Boolean { return hasTag(W_STAFFPART); }
		public function isMusicInstrument():Boolean { return hasTag(W_MUSICINSTR); }
		public function isTetsubo():Boolean { return hasTag(W_TETSUBO); }
		public function isThrown():Boolean { return hasTag(W_THROWN); }
		public function isWhirlwind():Boolean { return hasTag(W_WHIRLWIND); }
		public function isWhipping():Boolean { return hasTag(W_WHIPPING); }
		
		public function isLGWrath():Boolean { return hasTag(W_LGWRATH); }
		public function isMGWrath():Boolean { return hasTag(W_MGWRATH); }
		
		public function isAxeType():Boolean { return type == WT_AXE; }
		public function isDaggerType():Boolean { return type == WT_DAGGER; }
		public function isDuelingType():Boolean { return type == WT_DUELING; }
		public function isExoticType():Boolean { return type == WT_EXOTIC; }
		public function isGauntletType():Boolean { return type == WT_GAUNTLET; }
		public function isMaceHammerType():Boolean { return type == WT_MACE_HAMMER; }
		public function isPolearmType():Boolean { return type == WT_POLEARM; }
		public function isRibbonType():Boolean { return type == WT_RIBBON; }
		public function isScytheType():Boolean { return type == WT_SCYTHE; }
		public function isSpearType():Boolean { return type == WT_SPEAR; }
		public function isStaffType():Boolean { return type == WT_STAFF; }
		public function isSwordType():Boolean { return type == WT_SWORD; }
		public function isWhipType():Boolean { return type == WT_WHIP; }
		public function isWandType():Boolean { return type == WT_WAND; }
		
		public function get descBase():String { return _description; }
		
		override public function effectDescriptionParts():Array {
			var list:Array = super.effectDescriptionParts();
			// Type
			list.push([10,"Type: Melee Weapon"]);
			list.push([15, "Weapon Class: " + (isDual() ? "Dual " : "") + WeaponSizeNames[size] + " " + type]);
			// Attack
			var attack:Number = this.attack;
			list.push([20, "Attack: " + attack + (attack != baseAttack ? " (base " + baseAttack + ")" : "")]);
			return list;
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			//========================//
			// Size/Dual/Shield check //
			//========================//
			
			var hasShield:Boolean = !game.player.shield.isNothing;
			var noShieldAllowed:Boolean = false;
			
			if (isDual()) {
				// all dual req. DW
				noShieldAllowed = true;
				if (!game.player.hasPerk(PerkLib.DualWield)) {
					if (doOutput) outputText(getItemText("dual_fail"));
					return false;
				}
			}
			if (isLarge()) {
				// large + shield req. GG
				// dual large req. DW + GG
				if (!game.player.hasPerk(PerkLib.GigantGrip)) {
					noShieldAllowed = true;
					if (isDual()) {
						if (doOutput) outputText(getItemText("dual_fail"));
						return false;
					}
				}
			} else if (isMassive()) {
				// dual massive req. DW + (GGSu4a | AD4a | TG)
				// massive + shield req. TG
				// massive req. GG
				if (isDual()) {
					if (!game.player.hasPerk(PerkLib.TitanGrip)) {
						if (game.player.hasPerk(PerkLib.GigantGripSu) || game.player.hasPerk(PerkLib.AntyDexterity)) {
							if (!game.player.hasFourArms()) {
								if (doOutput) outputText(getItemText("dualmasssive_4afail"));
								return false;
							}
						} else {
							if (doOutput) outputText(getItemText("dualmassive_fail"));
							return false;
						}
					}
				} else if (!game.player.hasPerk(PerkLib.TitanGrip)) {
					noShieldAllowed = true;
					if (!game.player.hasPerk(PerkLib.GigantGrip)) {
						if (doOutput) outputText(getItemText("massive_fail"));
						return false;
					}
				}
			}
			if (hasShield && noShieldAllowed) {
				if (!game.player.shield.canUnequip(doOutput)) {
					if (doOutput) {
						outputText(getItemText("unshield_fail"));
					}
				} else if (doOutput) {
					outputText(getItemText("unshield"));
					SceneLib.inventory.unequipShield();
				}
				return false;
			}
			if (game.player.hasPerk(PerkLib.Rigidity)) {
				if (doOutput) outputText(getItemText("rigidity_fail"));
				return false;
			}
			// All checks passed, check superclass //
			return super.canEquip(doOutput);
		}
		
		override public function beforeEquip(doOutput:Boolean):Equipable {
			if (!game.player.shield.isNothing) {
				if (isLarge() && !game.player.hasPerk(PerkLib.GigantGrip)
					|| isMassive() && !game.player.hasPerk(PerkLib.TitanGrip)){
					SceneLib.inventory.unequipShield();
				}
			}
			if (game.flags[kFLAGS.FERAL_COMBAT_MODE] == 1 && !game.player.isFeralCombat()) game.flags[kFLAGS.FERAL_COMBAT_MODE] = 0;
			
			return super.beforeEquip(doOutput);
		}
		
		/**
		 * Extra texts for weapons:
		 * - "dual_fail": cannot equip dual weapons, no perk
		 * - "dualmasssive_4afail": cannot wield dual massive, perk requires 4 arms
		 * - "dualmasssive_fail": cannot wield dual massive, no perk
		 * - "massive_fail": cannot equip massive wepon, no perk
		 * - "unshield_fail": req. 2 hands but cannot unequip shield
		 * - "unshield": req. 2 hands, unequipping shield
		 */
		override public function getItemText(textid:String):String {
			switch (textid) {
				case "legendary_fail":
					var weaponType:String = _type;
					if (weaponType == WT_MACE_HAMMER) weaponType = "Mace";
					if (weaponType == WT_DUELING || weaponType == WT_EXOTIC) weaponType = "Weapon";
					return "You try to equip the legendary " + weaponType.toLowerCase() + ", but to your disappointment the item simply refuses to stay in your hands. It seems you still lack the right to wear this item.";
				case "dual_fail":
					return "You aren't skilled enough to handle this pair of weapons!  ";
				case "dualmasssive_4afail":
					return "You lack second pair of arms!  "
				case "dualmassive_fail":
					return "You aren't skilled enough to handle this pair of weapons with only two hands!  Unless you want to hurt yourself instead of your enemies when trying to use them...  "
				case "massive_fail":
					return "You aren't skilled enough in handling massive weapons, even when using both hands to use this weapon.  "
				case "unshield_fail":
					return "You currently cannot remove your [shield]."
				case "unshield":
					return "Because " +
							(isDual() ? "those weapons require":"this weapon requires") +
							" the use of two hands, you have unequipped your shield. ";
			}
			return super.getItemText(textid);
		}
	}
}
