/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
import classes.GlobalFlags.kFLAGS;
import classes.Items.ShieldLib;
import classes.Items.WeaponLib;
import classes.PerkLib;
import classes.StatusEffects;

public class CombatSoulskills extends BaseCombatContent {
	public function CombatSoulskills() {
	}
	//------------
// S. SPECIALS
//------------
	public function soulforceSpecials():void {
		//if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 5) {
		//clearOutput();
		//outputText("You try to ready a special attack, but wind up stumbling dizzily instead.  <b>Your ability to use physical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
		//enemyAI();
		//return;
		//}
		outputText("\n<b>Current soulpower:</b> " + player.soulforce + " / " + player.maxSoulforce() + " \n");
		menu();
		var button:int = 0;
		if (player.hasStatusEffect(StatusEffects.KnowsTripleThrust)) {
			addButton(0, "Triple Thrust", TripleThrust, null, null, null, "Use a little bit of soulforce to infuse your weapon and thrust three times toward your enemy.\n\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti());
		}
		if (player.hasStatusEffect(StatusEffects.KnowsDracoSweep)) {
			addButton(1, "Draco Sweep", DracoSweep, null, null, null, "Use a little bit of soulforce to infuse your weapon and then sweep ahead hitting as many enemies as possible.\n\nSoulforce cost: " + 50 * soulskillCost() * soulskillcostmulti());
		}
		if (player.hasStatusEffect(StatusEffects.KnowsManyBirds)) {
			addButton(2, "Many Birds", ManyBirds, null, null, null, "Project a figment of your soulforce as a crystal traveling at extreme speeds.\n\nSoulforce cost: " + 10 * soulskillCost() * soulskillcostmulti());
		}
		if (player.hasStatusEffect(StatusEffects.KnowsComet)) {
			addButton(5, "Comet", Comet, null, null, null, "Project a shard of soulforce, which will come crashing down upon your opponent as a crystalline comet.\n\nSoulforce cost: " + 60 * soulskillCost() * soulskillcostmulti());
		}
		if (player.hasStatusEffect(StatusEffects.KnowsVioletPupilTransformation)) {
			if (!player.hasStatusEffect(StatusEffects.VioletPupilTransformation)) {
				if ((player.unicornScore() >= 5) && (player.alicornScore() >= 6)) addButton(10, "V P Trans", VioletPupilTransformation, null, null, null, "Violet Pupil Transformation is a regenerating oriented soul art that at the cost of constant using fixed amount of soulforce would be healing user.  Usualy it would ends when caster run out of soulforce to substain it or situation that casused it activation is over.\n\nSoulforce cost: <i>100 soulforce</i> regenerating <b>" + (200 + ((player.unicornScore() - 4) * 25) + ((player.alicornScore() - 5) * 25)) + " HP</b> per turn.");
				else if (player.unicornScore() >= 5) addButton(10, "V P Trans", VioletPupilTransformation, null, null, null, "Violet Pupil Transformation is a regenerating oriented soul art that at the cost of constant using fixed amount of soulforce would be healing user.  Usualy it would ends when caster run out of soulforce to substain it or situation that casused it activation is over.\n\nSoulforce cost: <i>100 soulforce</i> regenerating <b>" + (200 + ((player.unicornScore() - 4) * 25)) + " HP</b> per turn.");
				else addButton(10, "V P Trans", VioletPupilTransformation, null, null, null, "Violet Pupil Transformation is a regenerating oriented soul art that at the cost of constant using fixed amount of soulforce would be healing user.  Usualy it would ends when caster run out of soulforce to substain it or situation that casused it activation is over.\n\nSoulforce cost: <i>100 soulforce</i> regenerating <b>200 HP</b> per turn.");
			}
			else addButton(10, "Deactiv VPT", DeactivateVioletPupilTransformation, null, null, null, "Deactivate Violet Pupil Transformation.\n");
		}
		if (player.weapon == weapons.WGSWORD) {
			addButton(12, "Beat of War", BeatOfWar, null, null, null, "Attack with low-moderate additional soul damage, gain strength equal to 15% your base strength until end of battle. This effect stacks.\n\nSoulforce cost: " + 50 * soulskillCost() * soulskillcostmulti());
		}
		if (player.weapon == weapons.WDBLADE) {
			addButton(12, "Blade Dance", BladeDance, null, null, null, "Attack twice (four times if double attack is active, six times if triple attack is active and etc.).\n\nSoulforce cost: " + 50 * soulskillCost() * (1 + flags[kFLAGS.DOUBLE_ATTACK_STYLE]));
		}
		if (player.weapon == weapons.WDSTAFF) {
			addButton(12, "AvatarOfTheSong", AvatarOfTheSong, null, null, null, "Doublecast Charged Weapon and Might. Casts blind if charged weapon is already active. Casts Heal if Might is already active.\n\nSoulforce cost: 200");
		}
		if (player.weaponRangeName == "Warden’s bow") {
			addButton(13, "ResonanceVolley", ResonanceVolley, null, null, null, "Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.\n\nSoulforce cost: 150");
		}
		addButton(14, "Back", combatMenu, false);
	}
	public function TripleThrust():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) {
			outputText("<b>Your current soulforce is too low.</b>");
			doNext(combatMenu);
			return;
		}
		outputText("You ready your [weapon] and prepare to thrust it towards " + monster.a + monster.short + ".  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!", false);
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!", false);
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.", false);
			enemyAI();
			return;
		}
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var damage:Number = 0;
		damage += player.str;
		damage += strenghtscalingbonus() * 0.5;
		if (damage < 10) damage = 10;
		//weapon bonus
		if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
		else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
		else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
		else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
		//soulskill mod effect
		damage *= soulskillMod();
		//other bonuses
		if (player.findPerk(PerkLib.HoldWithBothHands) >= 0 && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
		if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80) damage *= 1.2;
		if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
		if (player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		//triple strike bonus
		damage *= 3;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (rand(100) < critChance) {
			crit = true;
			temp *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		outputText("Your [weapon] hits thrice against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.findPerk(PerkLib.Rage) >= 0 && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		if(monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}

	public function DracoSweep():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.soulforce < 50 * soulskillCost() * soulskillcostmulti()) {
			outputText("<b>Your current soulforce is too low.</b>");
			doNext(combatMenu);
			return;
		}
		outputText("You ready your [weapon] and prepare to sweep it towards " + monster.a + monster.short + ".  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!", false);
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!", false);
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.", false);
			enemyAI();
			return;
		}
		var soulforcecost:int = 50 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var damage:Number = 0;
		damage += player.str;
		damage += strenghtscalingbonus() * 0.5;
		if (damage < 10) damage = 10;
		//weapon bonus
		if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
		else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
		else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
		else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
		//soulskill mod effect
		damage *= soulskillMod();
		//group enemies bonus
		if (monster.plural == true) damage *= 5;
		//other bonuses
		if (player.findPerk(PerkLib.HoldWithBothHands) >= 0 && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
		if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80) damage *= 1.2;
		if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
		if (player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (rand(100) < critChance) {
			crit = true;
			temp *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		outputText("Your [weapon] sweeps against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.findPerk(PerkLib.Rage) >= 0 && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		if(monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}

	public function ManyBirds():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
			outputText("<b>Your current soulforce is too low.</b>");
			doNext(combatMenu);
			return;
		}
		outputText("You thrust your hand outwards with deadly intent, and in the blink of an eye a crystal shoots towards " + monster.a + monster.short + ".  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids crystal!", false);
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges crystal with superior quickness!", false);
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids crystal.", false);
			enemyAI();
			return;
		}
		var soulforcecost:int = 10 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var damage:Number = 0;
		damage += inteligencescalingbonus();
		if (damage < 10) damage = 10;
		damage *= spellMod();
		//soulskill mod effect
		damage *= soulskillMod();
		//other bonuses
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (rand(100) < critChance) {
			crit = true;
			temp *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		outputText("Crystal hits " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		outputText("\n\n");
		if(monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}

	public function Comet():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.soulforce < 60 * soulskillCost() * soulskillcostmulti()) {
			outputText("<b>Your current soulforce is too low.</b>");
			doNext(combatMenu);
			return;
		}
		outputText("You focus for a moment, projecting a fragment of your soulforce above you.  A moment later, a prismatic comet crashes down on your opponents " + monster.a + monster.short + ".  ");
		if (monster.plural == true) outputText("Shattering into thousands of fragments that shower anything and everything around you.  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids comet fragments!", false);
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges comet fragments with superior quickness!", false);
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids comet fragments.", false);
			enemyAI();
			return;
		}
		var soulforcecost:int = 60 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var damage:Number = 0;
		damage += inteligencescalingbonus();
		if (damage < 10) damage = 10;
		damage *= spellMod();
		//soulskill mod effect
		damage *= soulskillMod();
		//group enemies bonus
		if (monster.plural == true) damage *= 5;
		//other bonuses
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (rand(100) < critChance) {
			crit = true;
			temp *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		outputText("Comet fragments hits " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		outputText("\n\n");
		if(monster.HP < 1) doNext(endHpVictory);
		else enemyAI();
	}

	public function VioletPupilTransformation():void {
		clearOutput();
		if (player.soulforce < 100) {
			outputText("<b>Your current soulforce is too low.</b>");
			doNext(combatMenu);
			return;
		}
		outputText("Deciding you need additional regeneration during current fight you spend moment to concentrate and activate Violet Pupil Transformation.  Your eyes starting to glow with a violet hua and you can feel refreshing feeling spreading all over your body.\n");
		player.createStatusEffect(StatusEffects.VioletPupilTransformation,0,0,0,0);
		enemyAI();
	}

	public function DeactivateVioletPupilTransformation():void {
		clearOutput();
		outputText("Deciding you not need for now to constantly using Violet Pupil Transformation you concentrate and deactivating it.");
		player.removeStatusEffect(StatusEffects.VioletPupilTransformation);
		enemyAI();
	}

	public function BeatOfWar():void {
		clearOutput();
		if (player.soulforce < 50 * soulskillCost() * soulskillcostmulti()) {
			outputText("<b>Your current soulforce is too low.</b>");
			doNext(combatMenu);
			return;
		}
		var tempStr:Number = 0;
		var soulforcecost:int = 50 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var BeatOfWarBoost:Number = (player.str - player.statusEffectv1(StatusEffects.BeatOfWar)) * 0.15;
		if (BeatOfWarBoost < 1) BeatOfWarBoost = 1;
		BeatOfWarBoost = Math.round(BeatOfWarBoost);
		if (!player.hasStatusEffect(StatusEffects.BeatOfWar)) player.createStatusEffect(StatusEffects.BeatOfWar,0,0,0,0);//player.addStatusValue(StatusEffects.BeatOfWar, 1, BeatOfWarBoost);
		temp = BeatOfWarBoost;
		tempStr = temp;
		player.addStatusValue(StatusEffects.BeatOfWar,1,tempStr);
		mainView.statsView.showStatUp('str');
		player.str += BeatOfWarBoost;			//player.statusEffectv1(StatusEffects.BeatOfWar);
		statScreenRefresh();
		outputText("You momentarily attune yourself to the song of the mother tree, and prepare to add a note of your own to it’s rhythm. You feel the beat shift the song’s tempo slightly, taking a twist towards the ominous. This attunement augments your strength.\n\n");
		combat.basemeleeattacks();
	}
	public function BladeDance():void {
		clearOutput();
		if (player.soulforce < 50 * soulskillCost() * (1 + flags[kFLAGS.DOUBLE_ATTACK_STYLE])) {
			outputText("<b>Your current soulforce is too low.</b>");
			doNext(combatMenu);
			return;
		}
		outputText("You momentarily attune yourself to the song of the mother tree, and dance forward, darting your blade around your enemy.\n\n");
		player.createStatusEffect(StatusEffects.BladeDance,0,0,0,0);
		combat.basemeleeattacks();
	}
	public function ResonanceVolley():void {
		clearOutput();
		if (player.soulforce < 150) {
			outputText("<b>Your current soulforce is too low.</b>");
			doNext(combatMenu);
			return;
		}
		outputText("You ready your bow, infusing it with a figment of soulforce. The energy awakens the wood’s connection to the world tree, causing the bow to pulse beneath your fingers.\n\n");
		player.createStatusEffect(StatusEffects.ResonanceVolley,0,0,0,0);
		combat.fireBow();
	}
	public function AvatarOfTheSong():void {
		clearOutput();
		if (player.soulforce < 200) {
			outputText("<b>Your current soulforce is too low.</b>");
			doNext(combatMenu);
			return;
		}
		outputText("You feel the song of the mother tree all around you, and using your staff as a beacon, you unify it with the flow of magic through your body,");
		if (!player.hasStatusEffect(StatusEffects.Might)) {
			outputText("drawing strength from it");
			combat.magic.spellMight(true);
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
		}
		else {
			outputText("feeling it mend your wounds");
			fatigue(30, 8);
			combat.magic.spellHealEffect();
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
		}
		if (!monster.hasStatusEffect(StatusEffects.Blind)) {
			outputText(". The residual power ");
			if (!player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
				outputText("makes your staff glow with barely contained energy");
				combat.magic.spellChargeWeapon(true);
				flags[kFLAGS.SPELLS_CAST]++;
				if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
				spellPerkUnlock();
			}
			else {
				outputText("makes your staff flare up, as the energy escapes as a radiant flash");
				combat.magic.spellBlind();
				flags[kFLAGS.SPELLS_CAST]++;
				if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
				spellPerkUnlock();
			}
		}
		outputText(".\n\n");
		enemyAI();
	}
	/*
	 //Mantis Omni Slash (AoE attack) - przerobić to na soulskilla zużywającego jak inne soulforce z rosnącym kosztem im wyższy lvl postaci ^^ owinno wciąż jakoś być powiązane z posiadaniem mantis arms czy też ulepszonych mantis arms (czyt. versji 2.0 tych ramion z TF bdącego soul evolution of Mantis) ^^
	 public function mantisOmniSlash():void {
	 flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
	 clearOutput();
	 if (monster.plural) {
	 if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
	 outputText("You are too tired to slash " + monster.a + " " + monster.short + ".");
	 addButton(0, "Next", combatMenu, false);
	 return;
	 }
	 }
	 else {
	 if (player.fatigue + physicalCost(20) > player.maxFatigue()) {
	 outputText("You are too tired to slash " + monster.a + " " + monster.short + ".");
	 addButton(0, "Next", combatMenu, false);
	 return;
	 }
	 }
	 if (monster.plural) {
	 fatigue(60, 2);
	 }
	 else fatigue(24, 2);
	 //Amily!
	 if(monster.hasStatusEffect(StatusEffects.Concentration)) {
	 outputText("Amily easily glides around your attacks thanks to her complete concentration on your movements.\n\n");
	 enemyAI();
	 return;
	 }
	 outputText("You ready your wrists mounted scythes and prepare to sweep them towards " + monster.a + monster.short + ".\n\n");
	 if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe-player.spe) / 4) + 80)) > 80)) {
	 if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attacks!\n\n", false);
	 if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attacks with superior quickness!\n\n", false);
	 if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attacks.\n\n", false);
	 enemyAI();
	 return;
	 }
	 if (monster.plural) {
	 if (player.findPerk(PerkLib.MantislikeAgility) < 0) flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 5;
	 if (player.findPerk(PerkLib.MantislikeAgility) >= 0) flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 9;
	 }
	 else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 1;
	 mantisMultipleAttacks();
	 }
	 public function mantisMultipleAttacks():void {
	 var damage:Number = 0;
	 damage += player.spe;
	 damage += speedscalingbonus() * 0.5;
	 if (damage < 10) damage = 10;
	 //adjusting to be used 60/100% of base speed while attacking depending on insect-related perks possesed
	 if (player.findPerk(PerkLib.MantislikeAgility) < 0) damage *= 0.6;
	 //bonuses if fighting multiple enemies
	 if (monster.plural) {
	 if (player.findPerk(PerkLib.MantislikeAgility) < 0 && player.findPerk(PerkLib.TrachealSystemEvolved) < 0) damage *= 1.1;
	 if (player.findPerk(PerkLib.MantislikeAgility) >= 0 && player.findPerk(PerkLib.TrachealSystemEvolved) >= 0) damage *= 1.5;
	 }
	 //weapon bonus
	 if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
	 else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
	 else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
	 else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
	 else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
	 //other bonuses
	 if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80) damage *= 1.2;
	 if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
	 //Determine if critical hit!
	 var crit:Boolean = false;
	 var critChance:int = 5;
	 if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
	 if (player.inte <= 100) critChance += (player.inte - 50) / 50;
	 if (player.inte > 100) critChance += 1;
	 }
	 if (rand(100) < critChance) {
	 crit = true;
	 damage *= 1.75;
	 }
	 //final touches
	 damage *= (monster.damagePercent() / 100);
	 damage = doDamage(damage);
	 outputText("Your scythes swiftly sweeps against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
	 if (crit == true) outputText(" <b>*Critical Hit!*</b>");
	 outputText("\n");
	 checkAchievementDamage(damage);
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 0) {
	 outputText("\n");
	 enemyAI();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 1) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 2) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 3) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 4) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 5) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 6) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 7) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 8) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 9) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 }

	 public function tripleThrust():void {
	 flags[kFLAGS.LAST_ATTACK_TYPE] = 4;//fizyczny atak
	 clearOutput();
	 if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
	 outputText("<b>Your current soulforce is too low.</b>");
	 doNext(combatMenu);
	 return;
	 }
	 outputText("You ready your [weapon] and prepare to thrust it towards " + monster.a + monster.short + ".  ");
	 if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe-player.spe) / 4) + 80)) > 80)) {
	 if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!", false);
	 if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!", false);
	 if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.", false);
	 enemyAI();
	 return;
	 }
	 var soulforcecost:int = 10 * soulskillCost() * soulskillcostmulti();
	 player.soulforce -= soulforcecost;
	 var damage:Number = 0;
	 damage += player.str;
	 damage += strenghtscalingbonus() * 0.5;
	 if (damage < 10) damage = 10;
	 //weapon bonus
	 if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
	 else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
	 else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
	 else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
	 else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
	 //other bonuses
	 if (player.findPerk(PerkLib.HoldWithBothHands) >= 0 && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
	 if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80) damage *= 1.2;
	 if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
	 if (player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
	 if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
	 //triple strike bonus
	 damage *= 3;
	 //soulskill mod effect
	 damage *= soulskillMod();
	 //final touches
	 damage *= (monster.damagePercent() / 100);
	 damage = doDamage(damage);
	 outputText("Your [weapon] hits thrice against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
	 checkAchievementDamage(damage);
	 outputText("\n\n");
	 if(monster.HP < 1) doNext(endHpVictory);
	 else enemyAI();
	 }*/
}
}
