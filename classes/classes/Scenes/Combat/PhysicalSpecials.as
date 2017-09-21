/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.Items.JewelryLib;
import classes.Items.ShieldLib;
import classes.Items.WeaponLib;
import classes.PerkLib;
import classes.Scenes.Areas.Ocean.SeaAnemone;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.Scenes.NPCs.Anemone;
import classes.StatusEffects;
import classes.Scenes.Camp.CampMakeWinions;

public class PhysicalSpecials extends BaseCombatContent {

	public var winionsMaker:CampMakeWinions = new CampMakeWinions();
	
//------------
// P. SPECIALS
//------------
	public function psMenu():void {
		if(kGAMECLASS.urtaQuest.isUrta()) {
			kGAMECLASS.urtaQuest.urtaSpecials();
			return;
		}
		if (inCombat && player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 5) {
			clearOutput();
			outputText("You try to ready a special attack, but wind up stumbling dizzily instead.  <b>Your ability to use physical special attacks was sealed, and now you've wasted a chance to attack!</b>\n\n");
			enemyAI();
			return;
		}
		menu();
		var button:int = 0;
		if (player.findPerk(PerkLib.JobWarrior) >= 0) {
			addButton(button++, "PowerAttack", powerAttackMenu).hint("Do a single way more powerfull wrath-enhanced strike.");
		}
		if (player.hairType == 4) {
			addButton(button++, "AnemoneSting", anemoneSting).hint("Attempt to strike an opponent with the stinging tentacles growing from your scalp.  Reduces enemy speed and increases enemy lust.", "Anemone Sting");
		}
		//Bitez
		if (player.faceType == FACE_SHARK_TEETH) {
			addButton(button++, "SharkBite", bite).hint("Attempt to bite your opponent with your shark-teeth.");
		}
		if (player.faceType == FACE_ORCA) {
			addButton(button++, "OrcaBite", bite).hint("Bite in your opponent with your sharp teeths causing bleed.");
		}
		else if (player.faceType == FACE_SNAKE_FANGS) {
			addButton(button++, "Bite", nagaBiteAttack).hint("Attempt to bite your opponent and inject venom.  \n\nVenom: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
		}
		else if (player.faceType == FACE_SPIDER_FANGS) {
			addButton(button++, "Bite", spiderBiteAttack).hint("Attempt to bite your opponent and inject venom.  \n\nVenom: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
		}
		else if (player.faceType == FACE_WOLF) {
			addButton(button++, "Frostbite", fenrirFrostbite).hint("You bite in your foe slowly infecting it with cold chill weakening its strength and resolve.");
		}
		//Constrict
		if (player.lowerBody == LOWER_BODY_TYPE_NAGA) {
			addButton(button++, "Constrict", kGAMECLASS.desert.nagaScene.nagaPlayerConstrict).hint("Attempt to bind an enemy in your long snake-tail.");
		}
		//Grapple
		if (player.lowerBody == LOWER_BODY_TYPE_SCYLLA) {
			addButton(button++, "Grapple", scyllaGrapple).hint("Attempt to grapple a foe with your tentacles.");
		}
		//Engulf
		if (player.lowerBody == LOWER_BODY_TYPE_GOO) {
			addButton(button++, "Engulf", gooEngulf).hint("Attempt to engulf a foe with your body.");
		}
		//Kick attackuuuu
		if (player.isTaur() || player.lowerBody == LOWER_BODY_TYPE_HOOFED || player.lowerBody == LOWER_BODY_TYPE_BUNNY || player.lowerBody == LOWER_BODY_TYPE_KANGAROO) {
			if (!player.hasStatusEffect(StatusEffects.CooldownKick)) {
				addButton(button++, "Kick", kick).hint("Attempt to kick an enemy using your powerful lower body.");
			}
			else if (player.hasStatusEffect(StatusEffects.CooldownKick)) {
				outputText("<b>You need more time before you can perform Kick again.</b>\n\n");
			}
		}
		//Gore if mino horns or unicorn/alicorn horn
		if (player.hornType == HORNS_COW_MINOTAUR && player.horns >= 6) {
			addButton(button++, "Gore", goreAttack).hint("Lower your head and charge your opponent, attempting to gore them on your horns.  This attack is stronger and easier to land with large horns.");
		}
		if (player.hornType == HORNS_UNICORN && player.horns >= 6) {
			addButton(button++, "Gore", goreAttack).hint("Lower your head and charge your opponent, attempting to gore them on your horn.  This attack is stronger and easier to land with large horn.");
		}
		//Upheaval - requires rhino horn
		if (player.hornType == HORNS_RHINO && player.horns >= 2 && player.faceType == FACE_RHINO) {
			addButton(button++, "Upheaval", upheavalAttack).hint("Send your foe flying with your dual nose mounted horns. \n\nFatigue Cost: " + physicalCost(15) + "");
		}
		//Infest if infested
		if (player.hasStatusEffect(StatusEffects.Infested) && player.statusEffectv1(StatusEffects.Infested) == 5 && player.hasCock()) {
			addButton(button++, "Infest", kGAMECLASS.mountain.wormsScene.playerInfest).hint("The infest attack allows you to cum at will, launching a stream of semen and worms at your opponent in order to infest them.  Unless your foe is very aroused they are likely to simply avoid it.  Only works on males or herms. \n\nAlso great for reducing your lust.");
		}
		//Kiss supercedes bite.
		if (player.hasStatusEffect(StatusEffects.LustStickApplied)) {
			addButton(button++, "Kiss", kissAttack).hint("Attempt to kiss your foe on the lips with drugged lipstick.  It has no effect on those without a penis.");
		}
		if (player.armType == ARM_TYPE_MANTIS && player.weapon == WeaponLib.FISTS) {
			if (monster.plural) {
				addButton(button++, "Multi Slash", mantisMultiSlash).hint("Attempt to slash your foes with your wrists scythes! \n\nFatigue Cost: " + physicalCost(60) + "");
			}
			else addButton(button++, "Multi Slash", mantisMultiSlash).hint("Attempt to slash your foe with your wrists scythes! \n\nFatigue Cost: " + physicalCost(24) + "");
		}
		if (player.tailType == TAIL_TYPE_BEE_ABDOMEN) addButton(button++, "Sting", playerStinger).hint("Attempt to use your venomous bee stinger on an enemy.  Be aware it takes quite a while for your venom to build up, so depending on your abdomen's refractory period, you may have to wait quite a while between stings.  \n\nVenom: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
		if (player.tailType == TAIL_TYPE_SCORPION) addButton(button++, "Sting", playerStinger).hint("Attempt to use your venomous scorpion stinger on an enemy.  Be aware it takes quite a while for your venom to build up, so depending on your refractory period, you may have to wait quite a while between stings.  \n\nVenom: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
		if (player.tailType == TAIL_TYPE_MANTICORE_PUSSYTAIL) addButton(button++, "Tail Spike", playerTailSpike).hint("Shoot an envenomed spike at your opponent dealing minor physical damage, slowing its movement speed and inflicting serious lust damage.  \n\nVenom: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
		if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN) addButton(button++, "Web", PCWebAttack).hint("Attempt to use your abdomen to spray sticky webs at an enemy and greatly slow them down.  Be aware it takes a while for your webbing to build up.  \n\nWeb Amount: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
		if (player.tailType == TAIL_TYPE_SHARK || player.tailType == TAIL_TYPE_LIZARD || player.tailType == TAIL_TYPE_KANGAROO || player.tailType == TAIL_TYPE_DRACONIC || player.tailType == TAIL_TYPE_RACCOON) addButton(button++, "Tail Whip", tailWhipAttack).hint("Whip your foe with your tail to enrage them and lower their defense!");
		if (player.tailType == TAIL_TYPE_SALAMANDER) addButton(button++, "Tail Slap", tailSlapAttack).hint("Set ablaze in red-hot flames your tail to whip your foe with it to hurt and burn them!  \n\n<b>AoE attack.</b>");
		if (player.tailType == TAIL_TYPE_ORCA) {
			if (!player.hasStatusEffect(StatusEffects.CooldownTailSmack)) {
				addButton(button++, "Tail Smack", tailSmackAttack).hint("Smack your powerful tail at your opponent face.</b>");
			}
			else if (player.hasStatusEffect(StatusEffects.CooldownTailSmack)) {
				outputText("<b>You need more time before you can perform Tail Smack again.</b>\n\n");
			}
		}
		if (player.findPerk(PerkLib.InkSpray) >= 0) {
			if (!player.hasStatusEffect(StatusEffects.CooldownInkSpray) && !monster.hasStatusEffect(StatusEffects.Blind)) {
				if (player.gender == 1) {
					if (player.findPerk(PerkLib.ScyllaInkGlands) >= 0) {
						addButton(button++, "Ink Spray", inkSpray).hint("Lift your cock and spray ink to the face of your foe surprising, arousing and blinding them (cooldown of 4 round before it can be used again)");
					}
					else {
						addButton(button++, "Ink Spray", inkSpray).hint("Lift your cock and spray ink to the face of your foe surprising, arousing and blinding them (cooldown of 8 round before it can be used again)");
					}
				}
				if (player.gender == 2 || player.gender == 3) {
					if (player.findPerk(PerkLib.ScyllaInkGlands) >= 0) {
						addButton(button++, "Ink Spray", inkSpray).hint("Lift your front tentacle and spray ink to the face of your foe surprising, arousing and blinding them (cooldown of 4 round before it can be used again)");
					}
					else {
						addButton(button++, "Ink Spray", inkSpray).hint("Lift your front tentacle and spray ink to the face of your foe surprising, arousing and blinding them (cooldown of 8 round before it can be used again)");
					}
				}
			}
			else if (monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind)) {
				outputText("<b>" + monster.capitalA + monster.short + " is already affected by blind.</b>\n\n");
			}
			else if (player.hasStatusEffect(StatusEffects.CooldownInkSpray)) {
				outputText("<b>You need more time before you can shoot ink again.</b>\n\n");
			}
		}
		if (player.hasVagina() && player.cowScore() >= 9) {
			if (player.hasStatusEffect(StatusEffects.MilkBlastCooldown)) addButtonDisabled(button++, "Milk Blast", "You can't use it more than once during fight.");
			else addButton(button++, "Milk Blast", milkBlask).hint("Blast your opponent with a powerful stream of milk, arousing and damaging them. The power of the jet is related to arousal, libido and production. \n\nLust Cost: 100");
		}
		if (player.hasCock() && player.minotaurScore() >= 9) {
			if (player.hasStatusEffect(StatusEffects.CumCannonCooldown)) addButtonDisabled(button++, "Cum Cannon", "You can't use it more than once during fight.");
			else addButton(button++, "Cum Cannon", cumCannon).hint("Blast your opponent with a powerful stream of cum, arousing and damaging them. The power of the jet is related to arousal, libido and production. \n\nLust Cost: 100");
		}
		if (player.canFly()) {
			addButton(button++, "Take Flight", takeFlight).hint("Make use of your wings to take flight into the air for up to 7 turns. \n\nGives bonus to evasion, speed but also giving penalties to accuracy of range attacks or spells. Not to meantion for non spear users to attack in melee range.");
		}
		if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] > 0) {
			if (monster.hasStatusEffect(StatusEffects.Flying) && player.findPerk(PerkLib.ExpertGolemMaker) < 0) addButtonDisabled(button++, "Send T.Gol/1", "Your golem can't attack flying target. (Only golems made by expert golem maker can do this)");
			else addButton(button++, "Send T.Gol/1", sendTemporalGolem1).hint("Send one golem from your bag to attack enemy. <b>After attack golem will fall apart and it core can shatter leaving it unable to be reused in future!</b>");
		}
		if (monster.plural) {
			if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] > 2) {
				if (monster.hasStatusEffect(StatusEffects.Flying) && player.findPerk(PerkLib.ExpertGolemMaker) < 0) addButtonDisabled(button++, "Send T.Gol/3", "Your golems can't attack flying target. (Only golems made by expert golem maker can do this)");
				else addButton(button++, "Send T.Gol/3", sendTemporalGolem3).hint("Send three golem from your bag to attack enemy. <b>After attack golems will fall apart and they cores can shatter leaving it unable to be reused in future!</b>");
			}
			if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] > 4) {
				if (monster.hasStatusEffect(StatusEffects.Flying) && player.findPerk(PerkLib.ExpertGolemMaker) < 0) addButtonDisabled(button++, "Send T.Gol/5", "Your golems can't attack flying target. (Only golems made by expert golem maker can do this)");
				else addButton(button++, "Send T.Gol/5", sendTemporalGolem5).hint("Send five golem from your bag to attack enemy. <b>After attack golems will fall apart and they cores can shatter leaving it unable to be reused in future!</b>");
			}
		}
		if (player.shield != ShieldLib.NOTHING) {
			addButton(button++, "Shield Bash", shieldBash).hint("Bash your opponent with a shield. Has a chance to stun. Bypasses stun immunity. \n\nThe more you stun your opponent, the harder it is to stun them again.");
		}
		if (player.weaponRangePerk == "Bow" && player.hasStatusEffect(StatusEffects.KnowsSidewinder)) {
			addButton(button++, "Sidewinder", archerSidewinder).hint("The pinacle art of the hunter. Once per day draw on your fatigue to shoot a single heavily infused arrow at a beast or animal morph. This attack never miss.");
		}
		if (monster.plural) {
			if (player.isWeaponsForWhipping()) addButton(button++, "Whipping", whipping).hint("Attack multiple opponent with your held weapon.  \n\n<b>AoE attack.</b>");
			if ((player.isWeaponForWhirlwind() && player.findPerk(PerkLib.PowerSweep) < 0) || ((player.isWeaponForWhirlwind() || player.isOneHandedWeapons()) && player.findPerk(PerkLib.PowerSweep) >= 0)) addButton(button++, "Whirlwind", whirlwind).hint("Spin your weapon around to attack multiple enemies at once.  \n\n<b>AoE attack.</b>");
			if (player.weaponRangePerk == "Bow" && player.hasStatusEffect(StatusEffects.KnowsBarrage)) {
				addButton(button++, "Barrage", archerBarrage).hint("Draw multiple arrow and shoot them all at the same time to hit several target.  \n\n<b>AoE attack.</b>");
			}
		}
		if (player.lowerBody == LOWER_BODY_TYPE_PLANT_FLOWER) {
			if (!player.hasStatusEffect(StatusEffects.AlraunePollen)) addButton(button++, "AlraunePollen", AlraunePollen).hint("Release a cloud of your pollen in the air to arouse your foe.");
			else if (player.hasStatusEffect(StatusEffects.AlraunePollen)) outputText("<b>You already spread your pollen over battlefield.</b>\n\n");
			if (!player.hasStatusEffect(StatusEffects.AlrauneEntangle)) addButton(button++, "Entangle", AlrauneEntangle).hint("Use your vines to hinder your opponent.");
			else if (player.hasStatusEffect(StatusEffects.AlrauneEntangle)) outputText("<b>You already entangle your opponent.</b>\n\n");
		}
		if (player.hasStatusEffect(StatusEffects.AlrauneEntangle)) {
			if (monster.tallness > 120 || monster.findPerk(PerkLib.EnemyGigantType) > 0) outputText("<b>Your opponent is too tall for Strangulate to have any effect on it.</b>\n\n");
			else addButton(button++, "Strangulate", AlrauneStrangulate).hint("Strangle your opponent with your vines.");
		}
		if (player.armType == ARM_TYPE_GARGOYLE && player.shield == ShieldLib.NOTHING && player.weaponPerk != "Large") {
			if (!player.hasStatusEffect(StatusEffects.CooldownStoneClaw)) {
				addButton(button++, "Stone Claw", StoneClawAttack).hint("Rend your foe using your sharp stone claw (available if you have no shield and use a one handed weapon).  \n\nWould go into cooldown after use for: 3 rounds");
			}
			else if (player.hasStatusEffect(StatusEffects.CooldownStoneClaw)) {
				outputText("<b>You need more time before you can perform Stone Claw again.</b>\n\n");
			}
		}
		if (player.tailType == TAIL_TYPE_GARGOYLE) {
			if (!player.hasStatusEffect(StatusEffects.CooldownTailSlam)) {
				addButton(button++, "Tail Slam", TailSlamAttack).hint("Slam your mace like tail on your foes head dealing severe damage crushing its defence and stunning it.  \n\nWould go into cooldown after use for: 5 rounds");
			}
			else if (player.hasStatusEffect(StatusEffects.CooldownTailSlam)) {
				outputText("<b>You need more time before you can perform Tail Slam again.</b>\n\n");
			}
		}
		if (player.wingType == WING_TYPE_GARGOYLE_LIKE_LARGE) {
			if (!player.hasStatusEffect(StatusEffects.CooldownWingBuffet)) {
				addButton(button++, "Wing Buffet", WingBuffetAttack).hint("Buffet your foe using your two massive stone wings staggering your foe.  \n\nWould go into cooldown after use for: 5 rounds");
			}
			else if (player.hasStatusEffect(StatusEffects.CooldownWingBuffet)) {
				outputText("<b>You need more time before you can perform Wing Buffet again.</b>\n\n");
			}
		}
		addButton(14, "Back", combatMenu, false);
	}
	
	public function powerAttackMenu():void {
		menu();
		addButton(0, "2x", powerAttack2x);
		if (player.level >= 6) addButton(1, "3x", powerAttack3x);
		else addButtonDisabled(1, "???");
		if (player.level >= 12) addButton(2, "4x", powerAttack4x);
		else addButtonDisabled(2, "???");
		if (player.level >= 18) addButton(3, "6x", powerAttack6x);
		else addButtonDisabled(3, "???");
		if (player.level >= 24) addButton(4, "8x", powerAttack8x);
		else addButtonDisabled(4, "???");
		if (player.level >= 30) addButton(5, "10x", powerAttack10x);
		else addButtonDisabled(5, "???");
		addButton(14, "Back", psMenu);
	}
	public function powerAttack2x():void {
		clearOutput();
		if(player.wrath < 5) {
			clearOutput();
			outputText("You are too calm to use this special.");
			doNext(combatMenu);
			return;
		}
		player.wrath -= 5;
		outputText("You lift your [weapon] with all of your strenght and smash it on your foe head. ");
		var damage:Number = 0;
		damage += powerfistspoweeeeer();
		damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.WeaponMastery) >= 0 && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
		if (player.findPerk(PerkLib.WeaponGrandMastery) >= 0 && player.weaponPerk == "Dual Large" && player.str >= 140) critChance += 10;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			if (player.findPerk(PerkLib.Impale) >= 0 && (player.findPerk(PerkLib.DoubleAttack) < 0 || (player.findPerk(PerkLib.DoubleAttack) >= 0 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)) && player.spe >= 100 && (player.weaponName == "deadly spear" || player.weaponName == "deadly lance" || player.weaponName == "deadly trident")) damage *= 2.5;
			else damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b> damage. ");
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.findPerk(PerkLib.Rage) >= 0 && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		enemyAI();
	}
	public function powerAttack3x():void {
		clearOutput();
		if(player.wrath < 10) {
			clearOutput();
			outputText("You are too calm to use this special.");
			doNext(combatMenu);
			return;
		}
		player.wrath -= 10;
		outputText("You lift your [weapon] with all of your strenght and smash it on your foe head. ");
		var damage:Number = 0;
		damage += powerfistspoweeeeer();
		damage *= 3;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.WeaponMastery) >= 0 && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
		if (player.findPerk(PerkLib.WeaponGrandMastery) >= 0 && player.weaponPerk == "Dual Large" && player.str >= 140) critChance += 10;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			if (player.findPerk(PerkLib.Impale) >= 0 && (player.findPerk(PerkLib.DoubleAttack) < 0 || (player.findPerk(PerkLib.DoubleAttack) >= 0 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)) && player.spe >= 100 && (player.weaponName == "deadly spear" || player.weaponName == "deadly lance" || player.weaponName == "deadly trident")) damage *= 2.5;
			else damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b> damage. ");
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.findPerk(PerkLib.Rage) >= 0 && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		enemyAI();
	}
	public function powerAttack4x():void {
		clearOutput();
		if(player.wrath < 20) {
			clearOutput();
			outputText("You are too calm to use this special.");
			doNext(combatMenu);
			return;
		}
		player.wrath -= 20;
		outputText("You lift your [weapon] with all of your strenght and smash it on your foe head. ");
		var damage:Number = 0;
		damage += powerfistspoweeeeer();
		damage *= 4;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.WeaponMastery) >= 0 && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
		if (player.findPerk(PerkLib.WeaponGrandMastery) >= 0 && player.weaponPerk == "Dual Large" && player.str >= 140) critChance += 10;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			if (player.findPerk(PerkLib.Impale) >= 0 && (player.findPerk(PerkLib.DoubleAttack) < 0 || (player.findPerk(PerkLib.DoubleAttack) >= 0 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)) && player.spe >= 100 && (player.weaponName == "deadly spear" || player.weaponName == "deadly lance" || player.weaponName == "deadly trident")) damage *= 2.5;
			else damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b> damage. ");
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.findPerk(PerkLib.Rage) >= 0 && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		enemyAI();
	}
	public function powerAttack6x():void {
		clearOutput();
		if(player.wrath < 50) {
			clearOutput();
			outputText("You are too calm to use this special.");
			doNext(combatMenu);
			return;
		}
		player.wrath -= 50;
		outputText("You lift your [weapon] with all of your strenght and smash it on your foe head. ");
		var damage:Number = 0;
		damage += powerfistspoweeeeer();
		damage *= 6;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.WeaponMastery) >= 0 && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
		if (player.findPerk(PerkLib.WeaponGrandMastery) >= 0 && player.weaponPerk == "Dual Large" && player.str >= 140) critChance += 10;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			if (player.findPerk(PerkLib.Impale) >= 0 && (player.findPerk(PerkLib.DoubleAttack) < 0 || (player.findPerk(PerkLib.DoubleAttack) >= 0 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)) && player.spe >= 100 && (player.weaponName == "deadly spear" || player.weaponName == "deadly lance" || player.weaponName == "deadly trident")) damage *= 2.5;
			else damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b> damage. ");
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.findPerk(PerkLib.Rage) >= 0 && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		enemyAI();
	}
	public function powerAttack8x():void {
		clearOutput();
		if(player.wrath < 125) {
			clearOutput();
			outputText("You are too calm to use this special.");
			doNext(combatMenu);
			return;
		}
		player.wrath -= 125;
		outputText("You lift your [weapon] with all of your strenght and smash it on your foe head. ");
		var damage:Number = 0;
		damage += powerfistspoweeeeer();
		damage *= 8;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.WeaponMastery) >= 0 && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
		if (player.findPerk(PerkLib.WeaponGrandMastery) >= 0 && player.weaponPerk == "Dual Large" && player.str >= 140) critChance += 10;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			if (player.findPerk(PerkLib.Impale) >= 0 && (player.findPerk(PerkLib.DoubleAttack) < 0 || (player.findPerk(PerkLib.DoubleAttack) >= 0 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)) && player.spe >= 100 && (player.weaponName == "deadly spear" || player.weaponName == "deadly lance" || player.weaponName == "deadly trident")) damage *= 2.5;
			else damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b> damage. ");
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.findPerk(PerkLib.Rage) >= 0 && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		enemyAI();
	}
	public function powerAttack10x():void {
		clearOutput();
		if(player.wrath < 350) {
			clearOutput();
			outputText("You are too calm to use this special.");
			doNext(combatMenu);
			return;
		}
		player.wrath -= 350;
		outputText("You lift your [weapon] with all of your strenght and smash it on your foe head. ");
		var damage:Number = 0;
		damage += powerfistspoweeeeer();
		damage *= 10;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.WeaponMastery) >= 0 && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
		if (player.findPerk(PerkLib.WeaponGrandMastery) >= 0 && player.weaponPerk == "Dual Large" && player.str >= 140) critChance += 10;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			if (player.findPerk(PerkLib.Impale) >= 0 && (player.findPerk(PerkLib.DoubleAttack) < 0 || (player.findPerk(PerkLib.DoubleAttack) >= 0 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)) && player.spe >= 100 && (player.weaponName == "deadly spear" || player.weaponName == "deadly lance" || player.weaponName == "deadly trident")) damage *= 2.5;
			else damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b> damage. ");
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.findPerk(PerkLib.Rage) >= 0 && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		enemyAI();
	}
	public function powerfistspoweeeeer():Number {
		var powerfistspowervalue:Number = 0;
		powerfistspowervalue += player.str;
		powerfistspowervalue += strenghtscalingbonus() * 0.25;
		if (player.findPerk(PerkLib.HoldWithBothHands) >= 0 && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) powerfistspowervalue *= 1.2;
		if (powerfistspowervalue < 10) powerfistspowervalue = 10;
		if (player.weaponAttack < 51) powerfistspowervalue *= (1 + (player.weaponAttack * 0.03));
		else if (player.weaponAttack >= 51 && player.weaponAttack < 101) powerfistspowervalue *= (2.5 + ((player.weaponAttack - 50) * 0.025));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 151) powerfistspowervalue *= (3.75 + ((player.weaponAttack - 100) * 0.02));
		else if (player.weaponAttack >= 151 && player.weaponAttack < 201) powerfistspowervalue *= (4.75 + ((player.weaponAttack - 150) * 0.015));
		else powerfistspowervalue *= (5.5 + ((player.weaponAttack - 200) * 0.01));
		if (player.weapon == weapons.L_WHIP) {
			if (monster.findPerk(PerkLib.IceNature) >= 0) powerfistspowervalue *= 5;
			if (monster.findPerk(PerkLib.FireVulnerability) >= 0) powerfistspowervalue *= 2;
			if (monster.findPerk(PerkLib.IceVulnerability) >= 0) powerfistspowervalue *= 0.5;
			if (monster.findPerk(PerkLib.FireNature) >= 0) powerfistspowervalue *= 0.2;
		}
		if (player.weapon == weapons.RCLAYMO && player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
			if (monster.findPerk(PerkLib.IceNature) >= 0) powerfistspowervalue *= 5;
			if (monster.findPerk(PerkLib.FireVulnerability) >= 0) powerfistspowervalue *= 2;
			if (monster.findPerk(PerkLib.IceVulnerability) >= 0) powerfistspowervalue *= 0.5;
			if (monster.findPerk(PerkLib.FireNature) >= 0) powerfistspowervalue *= 0.2;
		}
		if (player.weapon == weapons.SCLAYMO && player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
			if (monster.findPerk(PerkLib.IceNature) >= 0) powerfistspowervalue *= 0.2;
			if (monster.findPerk(PerkLib.FireVulnerability) >= 0) powerfistspowervalue *= 0.5;
			if (monster.findPerk(PerkLib.IceVulnerability) >= 0) powerfistspowervalue *= 2;
			if (monster.findPerk(PerkLib.FireNature) >= 0) powerfistspowervalue *= 5;
		}
		if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) powerfistspowervalue *= 1.1;
		if (player.findPerk(PerkLib.JobWarrior) >= 0) powerfistspowervalue *= 1.05;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) powerfistspowervalue *= 2;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) powerfistspowervalue *= 3;
		return powerfistspowervalue;
	}

	public function whirlwind():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
			outputText("You are too tired to attack " + monster.a + " " + monster.short + ".");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		outputText("You ready your [weapon] and prepare to spin it around trying to hit as many " + monster.a + monster.short + " as possible.  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
			enemyAI();
			return;
		}
		fatigue(50,2);
		var damage:Number = 0;
		damage += player.str;
		if (player.findPerk(PerkLib.Whirlwind) >= 0) damage += strenghtscalingbonus() * 0.2;
		if (damage < 10) damage = 10;
		//weapon bonus
		if (player.weaponAttack < 101) damage *= (1 + (player.weaponAttack * 0.02));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 201) damage *= (2 + ((player.weaponAttack - 100) * 0.015));
		else damage *= (3.5 + ((player.weaponAttack - 200) * 0.01));
		//other bonuses
		if (player.findPerk(PerkLib.HoldWithBothHands) >= 0 && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
		if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80) damage *= 1.2;
		if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
		if (player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		if (player.findPerk(PerkLib.PowerSweep) >= 0) {
			if (player.isWeaponForWhirlwind()) damage *= 1.25;
			else damage *= 0.75;
		}
		if (player.weaponPerk == "Dual" || player.weaponPerk == "Dual Large") {
			if (player.findPerk(PerkLib.MakeItDouble) >= 0) damage *= 2;
			else damage *= 1.25;
		}
		if (player.findPerk(PerkLib.GiantsReach) >= 0 && (player.weaponPerk == "Large" || player.weaponPerk == "Dual Large")) damage *= 1.25;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		//crit
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.CycloneStage1) >= 0) critChance += 10;
		if (player.findPerk(PerkLib.CycloneStage2) >= 0) critChance += 15;
		if (player.findPerk(PerkLib.CycloneStage3) >= 0) critChance += 20;
		if (player.findPerk(PerkLib.CycloneStage4) >= 0) critChance += 20;
		if (player.findPerk(PerkLib.CycloneStage5) >= 0) critChance += 25;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//add bonus for using aoe special
		var bonusmultiplier:Number = 5;
		if (player.findPerk(PerkLib.Whirlwind) >= 0) bonusmultiplier += 1;
		if (player.findPerk(PerkLib.JobWarlord) >= 0) bonusmultiplier += 1;
		if (player.findPerk(PerkLib.Tornado) >= 0) bonusmultiplier += 1;
		if (player.findPerk(PerkLib.CycloneStage4) >= 0) bonusmultiplier += 0.5;
		if (player.findPerk(PerkLib.CycloneStage5) >= 0) bonusmultiplier += 1.5;
		damage *= bonusmultiplier;
		//final touches
		damage = Math.round(damage);
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		outputText("Your [weapon] hits few of " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
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
		enemyAI();
	}

	public function whipping():void {
		if (player.weapon == weapons.L_WHIP) flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		else flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
			outputText("You are too tired to attack " + monster.a + " " + monster.short + ".");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(50,2);
		outputText("You ready your [weapon] and prepare to spin it around trying to whip as many " + monster.a + monster.short + " as possible.  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
			enemyAI();
			return;
		}
		var damage:Number = 0;
		damage += player.str;
		if (player.findPerk(PerkLib.Whipping) >= 0) damage += strenghtscalingbonus() * 0.2;
		if (damage < 10) damage = 10;
		//weapon bonus
		if (player.weaponAttack < 101) damage *= (1 + (player.weaponAttack * 0.02));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 201) damage *= (2 + ((player.weaponAttack - 100) * 0.015));
		else damage *= (3.5 + ((player.weaponAttack - 200) * 0.01));
		//other bonuses
		if (player.findPerk(PerkLib.HoldWithBothHands) >= 0 && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
		if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80) damage *= 1.2;
		if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
		if (player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		if (player.weaponPerk == "Dual" || player.weaponPerk == "Dual Large") {
			if (player.findPerk(PerkLib.MakeItDouble) >= 0) damage *= 2;
			else damage *= 1.25;
		}
		if (player.findPerk(PerkLib.GiantsReach) >= 0 && (player.weaponPerk == "Large" || player.weaponPerk == "Dual Large")) damage *= 1.25;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		//crit
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.CycloneStage1) >= 0) critChance += 10;
		if (player.findPerk(PerkLib.CycloneStage2) >= 0) critChance += 15;
		if (player.findPerk(PerkLib.CycloneStage3) >= 0) critChance += 20;
		if (player.findPerk(PerkLib.CycloneStage4) >= 0) critChance += 20;
		if (player.findPerk(PerkLib.CycloneStage5) >= 0) critChance += 25;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//add bonus for using aoe special
		var bonusmultiplier:Number = 5;
		if (player.findPerk(PerkLib.Whirlwind) >= 0) bonusmultiplier += 1;
		if (player.findPerk(PerkLib.JobWarlord) >= 0) bonusmultiplier += 1;
		if (player.findPerk(PerkLib.Tornado) >= 0) bonusmultiplier += 1;
		if (player.findPerk(PerkLib.CycloneStage4) >= 0) bonusmultiplier += 0.5;
		if (player.findPerk(PerkLib.CycloneStage5) >= 0) bonusmultiplier += 1.5;
		damage *= bonusmultiplier;
		//flame whip
		if (player.weapon == weapons.L_WHIP) {
			if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 5;
			if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 2;
			if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 0.5;
			if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 0.2;
		}
		//final touches
		damage = Math.round(damage);
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		outputText("Your [weapon] whipped few of " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
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
		enemyAI();
	}

	public function anemoneSting():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		//-sting with hair (combines both bee-sting effects, but weaker than either one separately):
		//Fail!
		//25% base fail chance
		//Increased by 1% for every point over PC's speed
		//Decreased by 1% for every inch of hair the PC has
		var prob:Number = 70;
		if(monster.spe > player.spe) prob -= monster.spe - player.spe;
		prob += player.hairLength;
		if(prob <= rand(101)) {
			//-miss a sting
			if(monster.plural) outputText("You rush " + monster.a + monster.short + ", whipping your hair around to catch them with your tentacles, but " + monster.pronoun1 + " easily dodge.  Oy, you hope you didn't just give yourself whiplash.");
			else outputText("You rush " + monster.a + monster.short + ", whipping your hair around to catch it with your tentacles, but " + monster.pronoun1 + " easily dodges.  Oy, you hope you didn't just give yourself whiplash.");
		}
		//Success!
		else {
			outputText("You rush " + monster.a + monster.short + ", whipping your hair around like a genie");
			outputText(", and manage to land a few swipes with your tentacles.  ");
			if(monster.plural) outputText("As the venom infiltrates " + monster.pronoun3 + " bodies, " + monster.pronoun1 + " twitch and begin to move more slowly, hampered half by paralysis and half by arousal.");
			else outputText("As the venom infiltrates " + monster.pronoun3 + " body, " + monster.pronoun1 + " twitches and begins to move more slowly, hampered half by paralysis and half by arousal.");
			//(decrease speed/str, increase lust)
			//-venom capacity determined by hair length, 2-3 stings per level of length
			//Each sting does 5-10 lust damage and 2.5-5 speed damage
			var damage:Number = 0;
			temp = 1 + rand(2);
			if(player.hairLength >= 12) temp += 1 + rand(2);
			if(player.hairLength >= 24) temp += 1 + rand(2);
			if(player.hairLength >= 36) temp += 1;
			while(temp > 0) {
				temp--;
				damage += 5 + rand(6);
			}
			damage += player.level * 1.5;
			monster.spe -= damage/2;
			damage = monster.lustVuln * damage;
			//Clean up down to 1 decimal point
			damage = Math.round(damage*10)/10;
			monster.teased(monster.lustVuln * damage);
		}
		//New lines and moving on!
		outputText("\n\n");
		doNext(combatMenu);
		if(!combatRoundOver()) enemyAI();
	}


//special attack: tail whip? could unlock button for use by dagrons too
//tiny damage and lower monster armor by ~75% for one turn
//hit
	public function tailWhipAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		//miss
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("Twirling like a top, you swing your tail, but connect with only empty air.");
		}
		else {
			if(!monster.plural) outputText("Twirling like a top, you bat your opponent with your tail.  For a moment, " + monster.pronoun1 + " looks disbelieving, as if " + monster.pronoun3 + " world turned upside down, but " + monster.pronoun1 + " soon becomes irate and redoubles " + monster.pronoun3 + " offense, leaving large holes in " + monster.pronoun3 + " guard.  If you're going to take advantage, it had better be right away; " + monster.pronoun1 + "'ll probably cool off very quickly.");
			else outputText("Twirling like a top, you bat your opponent with your tail.  For a moment, " + monster.pronoun1 + " look disbelieving, as if " + monster.pronoun3 + " world turned upside down, but " + monster.pronoun1 + " soon become irate and redouble " + monster.pronoun3 + " offense, leaving large holes in " + monster.pronoun3 + " guard.  If you're going to take advantage, it had better be right away; " + monster.pronoun1 + "'ll probably cool off very quickly.");
			if(!monster.hasStatusEffect(StatusEffects.CoonWhip)) monster.createStatusEffect(StatusEffects.CoonWhip,0,0,0,0);
			temp = Math.round(monster.armorDef * .75);
			while(temp > 0 && monster.armorDef >= 1) {
				monster.armorDef--;
				monster.addStatusValue(StatusEffects.CoonWhip,1,1);
				temp--;
			}
			monster.addStatusValue(StatusEffects.CoonWhip,2,2);
			if(player.tailType == TAIL_TYPE_RACCOON) monster.addStatusValue(StatusEffects.CoonWhip,2,2);
		}
		outputText("\n\n");
		enemyAI();
	}

	public function tailSlapAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if(player.fatigue + physicalCost(40) > player.maxFatigue()) {
			clearOutput();
			outputText("You are too tired to perform tail slap attack.");
			doNext(combatMenu);
			return;
		}
		fatigue(40,2);
		outputText("With a simple thought you set your tail ablaze.");
		//miss
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  Twirling like a top, you swing your tail, but connect with only empty air.");
		}
		else {
			if(!monster.plural) outputText("  Twirling like a top, you bat your opponent with your tail.");
			else outputText("  Twirling like a top, you bat your opponents with your tail.");
			var damage:Number = unarmedAttack();
			damage += player.str;
			damage = calcInfernoMod(damage);
			if (monster.plural == true) damage *= 5;
			if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 5;
			if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 2;
			if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 0.5;
			if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 0.2;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 2;
			if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
			damage *= monster.damagePercent() / 100;
			if(damage < 0) damage = 5;
			damage = Math.round(damage);
			damage = doDamage(damage);
			outputText("  Your tail slams against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
			monster.createStatusEffect(StatusEffects.BurnDoT,10,0,0,0);
			checkAchievementDamage(damage);
		}
		outputText("\n\n");
		enemyAI();
	}

	public function tailSmackAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if(player.fatigue + physicalCost(40) > player.maxFatigue()) {
			clearOutput();
			outputText("You are too tired to perform tail smack attack.");
			doNext(combatMenu);
			return;
		}
		fatigue(40,1);
		player.createStatusEffect(StatusEffects.CooldownTailSmack,5,0,0,0);
		//miss
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  You smash your tail at " + monster.a + monster.short + ", but connect with only empty air.");
		}
		else {
			outputText("  You smash your tail at " + monster.a + monster.short + " face making ");
			if(!monster.plural) outputText("it");
			else outputText("them");
			outputText(" reel ");
			if (monster.findPerk(PerkLib.Resolute) < 0) {
				outputText("dazed by the sheer strength of the hit. ");
				monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
			}
			else outputText("back in pain but hold steady despite the impact.");
		}
		outputText("\n\n");
		enemyAI();
	}

	public function inkSpray():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if(player.fatigue + physicalCost(30) > player.maxFatigue()) {
			clearOutput();
			outputText("You are too tired to perform an ink spray attack.");
			doNext(combatMenu);
			return;
		}
//		doNext(combatMenu);
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(30,1);
		if (player.findPerk(PerkLib.ScyllaInkGlands) >= 0) {
			player.createStatusEffect(StatusEffects.CooldownInkSpray,4,0,0,0);
		}
		else player.createStatusEffect(StatusEffects.CooldownInkSpray,8,0,0,0);
		outputText("You lift");
		if (player.gender == 1) outputText(" your cock");
		if (player.gender == 2 || player.gender == 3) outputText(" a few tentacle");
		outputText(" spraying your foe face in ink.  It start trashing its arm about attempting to remove the ink.\n");
		outputText(" <b>" + monster.capitalA + monster.short + " is blinded!</b>");
		monster.createStatusEffect(StatusEffects.InkBlind, 2, 0, 0, 0);
		monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		if (monster.lustVuln > 0) {
			var lustDmg:Number = 2 + (3 * player.teaseLevel) + rand(5);
			monster.teased(lustDmg);
		}
		outputText("\n\n");
		statScreenRefresh();
		if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		else enemyAI();
	}
	
	public function milkBlask():void {
		clearOutput();
		if(player.lust < 100) {
			clearOutput();
			outputText("You are not horny enough to use this special.");
			doNext(combatMenu);
			return;
		}
		player.createStatusEffect(StatusEffects.MilkBlastCooldown, 0, 0, 0, 0);
		outputText("You grab both of your udder smirking as you point them toward your somewhat confused target. You moan a pleasured Mooooooo as you open the dam splashing " + monster.a + monster.short + " with a twin jet of milk so powerful it is blown away hitting the nearest obstacle. ");
		var damage:Number = 0;
		damage += player.lactationQ();
		damage *= player.lust / player.maxLust();
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		player.lust -= 100;
		if (monster.lustVuln > 0) {
			outputText(" ");
			var MilkLustDmg:Number = 0;
			MilkLustDmg += combat.libidoscalingbonus() * 0.2;
			monster.teased(MilkLustDmg);
		}
		if (monster.findPerk(PerkLib.Resolute) < 0) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		outputText("\n\n");
		enemyAI();
	}
	
	public function cumCannon():void {
		clearOutput();
		if(player.lust < 100) {
			clearOutput();
			outputText("You are not horny enough to use this special.");
			doNext(combatMenu);
			return;
		}
		player.createStatusEffect(StatusEffects.CumCannonCooldown, 0, 0, 0, 0);
		outputText("You begin to masturbate fiercely, your [balls] expending with stacked semen as you ready to blow. Your cock shoot a massive jet of cum, projecting " + monster.a + monster.short + " away and knocking it prone. ");
		var damage:Number = 0;
		damage += player.cumQ();
		damage *= player.lust / player.maxLust();
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		player.lust -= 100;
		if (monster.lustVuln > 0) {
			outputText(" ");
			var CumLustDmg:Number = 0;
			CumLustDmg += combat.libidoscalingbonus() * 0.2;
			monster.teased(CumLustDmg);
		}
		if (monster.findPerk(PerkLib.Resolute) < 0) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		outputText("\n\n");
		enemyAI();
	}

	public function takeFlight():void {
		clearOutput();
		outputText("You open you wing taking flight.\n\n");
		player.createStatusEffect(StatusEffects.Flying, 7, 0, 0, 0);
		if (player.findPerk(PerkLib.Resolute) < 0) {
			player.createStatusEffect(StatusEffects.FlyingNoStun, 0, 0, 0, 0);
			player.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
		}
		monster.createStatusEffect(StatusEffects.MonsterAttacksDisabled, 0, 0, 0, 0);
		enemyAI();
	}

	public function sendTemporalGolem1():void {
		clearOutput();
		flags[kFLAGS.TEMPORAL_GOLEMS_BAG]--;
		//Determine if golem core is shattered or not picked due too overloaded bag for them!
		var shatter:Boolean = false;
		var shatterChance:int = 20;
		if (player.findPerk(PerkLib.BeginnerGolemMaker) >= 0) shatterChance -= 5;
		if (player.findPerk(PerkLib.ApprenticeGolemMaker) >= 0) shatterChance -= 5;
		if (player.findPerk(PerkLib.ExpertGolemMaker) >= 0) shatterChance -= 5;
		if (rand(100) < shatterChance) {
			shatter = true;
		}
		var overloadedGolemCoresBag:Boolean = false;
		if (shatter == false) {
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] < winionsMaker.maxReusableGolemCoresBagSize()) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]++;
			else overloadedGolemCoresBag = true;
		}
		var damage:Number = 0;
		damage += 300 + rand(121);
		if (player.findPerk(PerkLib.ChargedCore) >= 0) {
			if (player.findPerk(PerkLib.SuperChargedCore) >= 0) {
				damage += 200 + rand(81);
				damage *= 1.4;
			}
			else {
				damage += 100 + rand(41);
				damage *= 1.2;
			}
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("Your stone golem slam into " + monster.a + monster.short + " dealing " + damage + " damage.");
		if (shatter == true) outputText(" <b>*Golem Core shattered!*</b>");
		if (overloadedGolemCoresBag == true) outputText(" <b>*Golem Core wasn't picked due to lack of space to store them!*</b>");
		enemyAI();
	}
	public function sendTemporalGolem3():void {
		clearOutput();
		flags[kFLAGS.TEMPORAL_GOLEMS_BAG] -= 3;
		//Determine if golem core is shattered or not picked due too overloaded bag for them!
		var shatter:Boolean = false;
		var shatterChance:int = 20;
		if (player.findPerk(PerkLib.BeginnerGolemMaker) >= 0) shatterChance -= 5;
		if (player.findPerk(PerkLib.ApprenticeGolemMaker) >= 0) shatterChance -= 5;
		if (player.findPerk(PerkLib.ExpertGolemMaker) >= 0) shatterChance -= 5;
		if (rand(100) < shatterChance) {
			shatter = true;
		}
		var overloadedGolemCoresBag:Boolean = false;
		if (shatter == false) {
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] < winionsMaker.maxReusableGolemCoresBagSize()) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] += 3;
			else overloadedGolemCoresBag = true;
		}
		var partialyoverloadedGolemCoresBag:Boolean = false;
		if (shatter == false && overloadedGolemCoresBag == false) {
			if ((winionsMaker.maxReusableGolemCoresBagSize() - flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]) < 3) {
				flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] = winionsMaker.maxReusableGolemCoresBagSize();
				partialyoverloadedGolemCoresBag = true;
			}
		}
		var damage:Number = 0;
		damage += 300 + rand(121);
		if (player.findPerk(PerkLib.ChargedCore) < 0) damage *= 3;
		if (player.findPerk(PerkLib.ChargedCore) >= 0) {
			if (player.findPerk(PerkLib.SuperChargedCore) >= 0) {
				damage += 200 + rand(81);
				damage *= 5;
			}
			else {
				damage += 100 + rand(41);
				damage *= 4;
			}
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("Your stone golems slams into " + monster.a + monster.short + " dealing " + damage + " damage.");
		if (shatter == true) outputText(" <b>*Golem Cores shattered!*</b>");
		if (overloadedGolemCoresBag == true) outputText(" <b>*None of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		if (partialyoverloadedGolemCoresBag == true) outputText(" <b>*Some of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		enemyAI();
	}
	public function sendTemporalGolem5():void {
		clearOutput();
		flags[kFLAGS.TEMPORAL_GOLEMS_BAG] -= 5;
		//Determine if golem core is shattered or not picked due too overloaded bag for them!
		var shatter:Boolean = false;
		var shatterChance:int = 20;
		if (player.findPerk(PerkLib.BeginnerGolemMaker) >= 0) shatterChance -= 5;
		if (player.findPerk(PerkLib.ApprenticeGolemMaker) >= 0) shatterChance -= 5;
		if (player.findPerk(PerkLib.ExpertGolemMaker) >= 0) shatterChance -= 5;
		if (rand(100) < shatterChance) {
			shatter = true;
		}
		var overloadedGolemCoresBag:Boolean = false;
		if (shatter == false) {
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] < winionsMaker.maxReusableGolemCoresBagSize()) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]++;
			else overloadedGolemCoresBag = true;
		}
		var partialyoverloadedGolemCoresBag:Boolean = false;
		if (shatter == false && overloadedGolemCoresBag == false) {
			if ((winionsMaker.maxReusableGolemCoresBagSize() - flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]) < 5) {
				flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] = winionsMaker.maxReusableGolemCoresBagSize();
				partialyoverloadedGolemCoresBag = true;
			}
		}
		var damage:Number = 0;
		damage += 300 + rand(121);
		if (player.findPerk(PerkLib.ChargedCore) < 0) damage *= 5;
		if (player.findPerk(PerkLib.ChargedCore) >= 0) {
			if (player.findPerk(PerkLib.SuperChargedCore) >= 0) {
				damage += 200 + rand(81);
				damage *= 10;
			}
			else {
				damage += 100 + rand(41);
				damage *= 7.5;
			}
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("Your stone golems slams into " + monster.a + monster.short + " dealing " + damage + " damage.");
		if (shatter == true) outputText(" <b>*Golem Cores shattered!*</b>");
		if (overloadedGolemCoresBag == true) outputText(" <b>*None of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		if (partialyoverloadedGolemCoresBag == true) outputText(" <b>*Some of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		enemyAI();
	}

	public function AlraunePollen():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var pollen:Number = monster.lustVuln * (2 + rand(4));
		monster.lust += pollen;
		outputText("You send a cloud of your pollen outward into the air, smiling lustfully at your opponent. Sneezing slightly as they inhale the potent pollen, they begin showing clear signs of arousal. Just how long can they resist coming to pollinate you now? Not for long, you hope. (" + pollen + ")\n\n");
		player.createStatusEffect(StatusEffects.AlraunePollen,0,0,0,0);
		enemyAI();
	}

	public function AlrauneEntangle():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("You coil your vines around " + monster.a + monster.short + "'s body, slowing them down and hindering ");
		if(!monster.plural) outputText("its");
		else outputText("their");
		outputText(" movement.\n\n");
		var EntangleStrNerf:Number = 0;
		var EntangleSpeNerf:Number = 0;
		EntangleStrNerf = Math.round(monster.str * .5);
		EntangleSpeNerf = Math.round(monster.spe * .5);
		monster.str -= EntangleStrNerf;
		monster.spe -= EntangleSpeNerf;
		if(monster.str < 1) monster.str = 1;
		if(monster.spe < 1) monster.spe = 1;
		player.createStatusEffect(StatusEffects.AlrauneEntangle,EntangleStrNerf,EntangleSpeNerf,0,0);
		enemyAI();
	}

	public function AlrauneStrangulate():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if(player.fatigue + physicalCost(60) > player.maxFatigue()) {
			clearOutput();
			outputText("You are too tired to strangulate enemy.");
			doNext(combatMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(60,1);
		var damage:Number = 0;
		damage += player.tou;
		damage += toughnessscalingbonus() * 0.5;
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("You tighten your vines around your opponent's neck to strangle it. " + monster.capitalA + monster.short + " struggles against your natural noose, getting obvious marks on its neck and " + damage + " damage for their trouble.\n\n");
		enemyAI();
	}

	public function StoneClawAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if(player.fatigue + physicalCost(60) > player.maxFatigue()) {
			clearOutput();
			outputText("You are too tired to perform an stone claw attack.");
			doNext(combatMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(60,1);
		player.createStatusEffect(StatusEffects.CooldownStoneClaw,3,0,0,0);
		var damage:Number = 0;
		//str bonuses
		damage += player.str;
		damage += strenghtscalingbonus() * 0.5;
		//tou bonuses
		damage += player.tou;
		damage += toughnessscalingbonus() * 0.5;
		//addictive bonuses
		if (player.findPerk(PerkLib.IronFistsI) >= 0) damage += 10;
		if (player.findPerk(PerkLib.IronFistsII) >= 0) damage += 10;
		if (player.findPerk(PerkLib.IronFistsIII) >= 0) damage += 10;
		if (player.findPerk(PerkLib.IronFistsIV) >= 0) damage += 10;
		if (player.findPerk(PerkLib.IronFistsV) >= 0) damage += 10;
		if (player.findPerk(PerkLib.IronFistsVI) >= 0) damage += 10;
		if (player.findPerk(PerkLib.JobBrawler) >= 0) damage += (5 * (1 + player.newGamePlusMod()));
		if (player.findPerk(PerkLib.JobMonk) >= 0) damage += (10 * (1 + player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Berzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Lustzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		//multiplicative bonuses
		if (player.findPerk(PerkLib.HoldWithBothHands) >= 0) damage *= 1.2;
		if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80) damage *= 1.2;
		if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
		if (player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.Blademaster) >= 0) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("You slash your adversary with your sharp stone claw dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
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
		enemyAI();
	}

	public function TailSlamAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if(player.fatigue + physicalCost(30) > player.maxFatigue()) {
			clearOutput();
			outputText("You are too tired to perform an tail slam attack.");
			doNext(combatMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(30,1);
		player.createStatusEffect(StatusEffects.CooldownTailSlam,5,0,0,0);
		var damage:Number = 0;
		//str bonuses
		damage += player.str;
		damage += strenghtscalingbonus() * 0.25;
		//tou bonuses
		damage += player.tou;
		damage += toughnessscalingbonus() * 0.25;
		//addictive bonuses
		if (player.findPerk(PerkLib.IronFistsI) >= 0) damage += 10;
		if (player.findPerk(PerkLib.IronFistsII) >= 0) damage += 10;
		if (player.findPerk(PerkLib.IronFistsIII) >= 0) damage += 10;
		if (player.findPerk(PerkLib.IronFistsIV) >= 0) damage += 10;
		if (player.findPerk(PerkLib.IronFistsV) >= 0) damage += 10;
		if (player.findPerk(PerkLib.IronFistsVI) >= 0) damage += 10;
		if (player.findPerk(PerkLib.JobBrawler) >= 0) damage += (5 * (1 + player.newGamePlusMod()));
		if (player.findPerk(PerkLib.JobMonk) >= 0) damage += (10 * (1 + player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Berzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Lustzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		//multiplicative bonuses
		if (player.findPerk(PerkLib.HoldWithBothHands) >= 0) damage *= 1.2;
		if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80) damage *= 1.2;
		if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
		if (player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.Blademaster) >= 0) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		if (!monster.hasStatusEffect(StatusEffects.TailSlamWhip)) monster.createStatusEffect(StatusEffects.TailSlamWhip,monster.armorDef,5,0,0);
		monster.armorDef == 0;
		outputText("You slam your mace like tail on your foe dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (monster.findPerk(PerkLib.Resolute) < 0) {
			outputText(" The attack is so devastating your target is stunned by the crushing blow!");
			monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
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
		enemyAI();
	}

	public function WingBuffetAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if(player.fatigue + physicalCost(30) > player.maxFatigue()) {
			clearOutput();
			outputText("You are too tired to perform an wing buffet attack.");
			doNext(combatMenu);
			return;
		}
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(30,1);
		player.createStatusEffect(StatusEffects.CooldownWingBuffet,5,0,0,0);
		var damage:Number = 0;
		damage += player.str/5;
		damage += player.tou/5;
		//multiplicative bonuses
		if (player.findPerk(PerkLib.HoldWithBothHands) >= 0) damage *= 1.2;
		if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80) damage *= 1.2;
		if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
		if (player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.Blademaster) >= 0) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("You buffet your foe with your massive wings dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.findPerk(PerkLib.Rage) >= 0 && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (monster.findPerk(PerkLib.Resolute) < 0) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		checkAchievementDamage(damage);
		outputText("\n\n");
		enemyAI();
	}

	public function PCWebAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		//Keep logic sane if this attack brings victory
		if(player.tailVenom < 30) {
			clearOutput();
			outputText("You do not have enough webbing to shoot right now!");
			doNext(psMenu);
			return;
		}
		player.tailVenom -= 30;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
			enemyAI();
			return;
		}
		if (monster.short == "lizan rogue") {
			outputText("As your webbing flies at him the lizan flips back, slashing at the adhesive strands with the claws on his hands and feet with practiced ease.  It appears he's used to countering this tactic.");
			enemyAI();
			return;
		}
		//Blind
		if(player.hasStatusEffect(StatusEffects.Blind)) {
			outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ");
		}
		else outputText("Turning and clenching muscles that no human should have, you expel a spray of sticky webs at " + monster.a + monster.short + "!  ");
		//Determine if dodged!
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("You miss " + monster.a + monster.short + " completely - ");
			if(monster.plural) outputText("they");
			else outputText(monster.mf("he","she") + " moved out of the way!\n\n");
			enemyAI();
			return;
		}
		//Over-webbed
		if(monster.spe < 1) {
			if(!monster.plural) outputText(monster.capitalA + monster.short + " is completely covered in webbing, but you hose " + monster.mf("him","her") + " down again anyway.");
			else outputText(monster.capitalA + monster.short + " are completely covered in webbing, but you hose them down again anyway.");
		}
		//LAND A HIT!
		else {
			if(!monster.plural) outputText("The adhesive strands cover " + monster.a + monster.short + " with restrictive webbing, greatly slowing " + monster.mf("him","her") + ". ");
			else outputText("The adhesive strands cover " + monster.a + monster.short + " with restrictive webbing, greatly slowing " + monster.mf("him","her") + ". ");
			monster.spe -= 45;
			if(monster.spe < 0) monster.spe = 0;
		}
		awardAchievement("How Do I Shot Web?", kACHIEVEMENTS.COMBAT_SHOT_WEB);
		outputText("\n\n");
		if(monster.HP < 1 || monster.lust > monster.eMaxLust()) combatRoundOver();
		else enemyAI();
	}
	public function scyllaGrapple():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if(player.fatigue + physicalCost(10) > player.maxFatigue()) {
			clearOutput();
			outputText("You just don't have the energy to wrap your tentacles so tightly around someone right now...");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if(monster.short == "pod") {
			clearOutput();
			outputText("You can't constrict something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10,2);
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		//WRAP IT UPPP
		if(40 + rand(player.spe) > monster.spe) {
			if(monster.plural) {
				outputText("Thinking for a moment you proceed to rush for the mob grappling as many as you can in your eight powerfull tentacle as you prepare to squeeze them.");
			}
			else {
				outputText("You grab your foe with your powerfull tentacle entangling legs and arms in order to immobilize it.");
			}
			monster.createStatusEffect(StatusEffects.ConstrictedScylla, 3 + rand(3),0,0,0);
		}
		//Failure
		else {
			//Failure (-10 HPs) -
			outputText("As you attempt to grapple your target it slips out of your reach delivering a glancing blow to your limbs. ");
			player.takeDamage(5, true);
			if(player.HP <= 0) {
				doNext(endHpLoss);
				return;
			}
		}
		outputText("\n\n");
		enemyAI();
	}

	public function gooEngulf():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if(player.fatigue + physicalCost(10) > player.maxFatigue()) {
			clearOutput();
			outputText("You just don't have the energy to engulf yourself around someone right now...");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if(monster.short == "pod") {
			clearOutput();
			outputText("You can't engulf something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10,2);
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		outputText("You plunge on " + monster.a + monster.short + " and let your liquid body engulf it. ");
		//WRAP IT UPPP
		if(40 + rand(player.spe) > monster.spe) {
			outputText("" + monster.capitalA + monster.short + " ends up encased in your fluid form kicking and screaming to get out.");
			monster.createStatusEffect(StatusEffects.GooEngulf, 3 + rand(3),0,0,0);
		}
		//Failure
		else {
			//Failure (-10 HPs) -
			outputText("" + monster.capitalA + monster.short + " dodge at the last second stepping out of your slimy embrace and using the opening to strike you.");
			player.takeDamage(5, true);
			if(player.HP <= 0) {
				doNext(endHpLoss);
				return;
			}
		}
		outputText("\n\n");
		enemyAI();
	}

	public function nagaBiteAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
//Pass false to combatMenu instead:		menuLoc = 1;
		if (player.tailVenom < 25) {
			outputText("You do not have enough venom to bite right now!");
			doNext(psMenu);
			return;
		}
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		if (monster is LivingStatue)
		{
			outputText("Your fangs can't even penetrate the giant's flesh.");
			enemyAI();
			return;
		}
		//Works similar to bee stinger, must be regenerated over time. Shares the same poison-meter
		if(rand(player.spe/2 + 40) + 20 > monster.spe/1.5 || monster.hasStatusEffect(StatusEffects.Constricted)) {
			//(if monster = demons)
			if(monster.short == "demons") outputText("You look at the crowd for a moment, wondering which of their number you should bite. Your glance lands upon the leader of the group, easily spotted due to his snakeskin cloak. You quickly dart through the demon crowd as it closes in around you and lunge towards the broad form of the leader. You catch the demon off guard and sink your needle-like fangs deep into his flesh. You quickly release your venom and retreat before he, or the rest of the group manage to react.");
			//(Otherwise)
			else outputText("You lunge at the foe headfirst, fangs bared. You manage to catch " + monster.a + monster.short + " off guard, your needle-like fangs penetrating deep into " + monster.pronoun3 + " body. You quickly release your venom, and retreat before " + monster.pronoun1 + " manages to react.");
			//The following is how the enemy reacts over time to poison. It is displayed after the description paragraph,instead of lust
			monster.str -= 2;
			monster.spe -= 2;
			if(monster.str < 1) monster.str = 1;
			if(monster.spe < 1) monster.spe = 1;
			if(monster.hasStatusEffect(StatusEffects.NagaVenom))
			{
				monster.addStatusValue(StatusEffects.NagaVenom,2,2);
				monster.addStatusValue(StatusEffects.NagaVenom,1,2);
			}
			else monster.createStatusEffect(StatusEffects.NagaVenom,2,2,0,0);
		}
		else {
			outputText("You lunge headfirst, fangs bared. Your attempt fails horrendously, as " + monster.a + monster.short + " manages to counter your lunge, knocking your head away with enough force to make your ears ring.");
		}
		outputText("\n\n");
		player.tailVenom -= 25;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		if(monster.HP < 1 || monster.lust > monster.eMaxLust()) combatRoundOver();
		else enemyAI();
	}
	public function spiderBiteAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
//Pass false to combatMenu instead:		menuLoc = 1;
		if (player.tailVenom < 25) {
			outputText("You do not have enough venom to bite right now!");
			doNext(psMenu);
			return;
		}
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		if (monster is LivingStatue)
		{
			outputText("Your fangs can't even penetrate the giant's flesh.");
			enemyAI();
			return;
		}
		//Works similar to bee stinger, must be regenerated over time. Shares the same poison-meter
		if(rand(player.spe/2 + 40) + 20 > monster.spe/1.5) {
			//(if monster = demons)
			if(monster.short == "demons") outputText("You look at the crowd for a moment, wondering which of their number you should bite. Your glance lands upon the leader of the group, easily spotted due to his snakeskin cloak. You quickly dart through the demon crowd as it closes in around you and lunge towards the broad form of the leader. You catch the demon off guard and sink your needle-like fangs deep into his flesh. You quickly release your venom and retreat before he, or the rest of the group manage to react.");
			//(Otherwise)
			else {
				if(!monster.plural) outputText("You lunge at the foe headfirst, fangs bared. You manage to catch " + monster.a + monster.short + " off guard, your needle-like fangs penetrating deep into " + monster.pronoun3 + " body. You quickly release your venom, and retreat before " + monster.a + monster.pronoun1 + " manages to react.");
				else outputText("You lunge at the foes headfirst, fangs bared. You manage to catch one of " + monster.a + monster.short + " off guard, your needle-like fangs penetrating deep into " + monster.pronoun3 + " body. You quickly release your venom, and retreat before " + monster.a + monster.pronoun1 + " manage to react.");
			}
			//React
			if(monster.lustVuln == 0) outputText("  Your aphrodisiac toxin has no effect!");
			else {
				if(monster.plural) outputText("  The one you bit flushes hotly, though the entire group seems to become more aroused in sympathy to their now-lusty compatriot.");
				else outputText("  " + monster.mf("He","She") + " flushes hotly and " + monster.mf("touches his suddenly-stiff member, moaning lewdly for a moment.","touches a suddenly stiff nipple, moaning lewdly.  You can smell her arousal in the air."));
				var lustDmg:int = 30 * monster.lustVuln;
				monster.teased(lustDmg);
				if (monster.lustVuln > 0) {
					monster.lustVuln += 0.05;
					if (monster.lustVuln > 1) monster.lustVuln = 1;
				}
			}
		}
		else {
			outputText("You lunge headfirst, fangs bared. Your attempt fails horrendously, as " + monster.a + monster.short + " manages to counter your lunge, pushing you back out of range.");
		}
		outputText("\n\n");
		player.tailVenom -= 25;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		if(monster.HP < 1 || monster.lust > monster.eMaxLust()) combatRoundOver();
		else enemyAI();
	}
	public function fenrirFrostbite():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		//FATIIIIGUE
		if(player.fatigue + physicalCost(10) > player.maxFatigue()) {
			clearOutput();
			outputText("You just don't have the energy to bite something right now...");
//Pass false to combatMenu instead:		menuLoc = 1;
//		doNext(combatMenu);
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10,2);
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		if (monster is LivingStatue)
		{
			outputText("Your fangs can't even penetrate the giant's flesh.");
			enemyAI();
			return;
		}
		//Works similar to bee stinger, must be regenerated over time. Shares the same poison-meter
		if(rand(player.spe/2 + 40) + 20 > monster.spe/1.5 || monster.hasStatusEffect(StatusEffects.Constricted)) {
			//(if monster = demons)
			if(monster.short == "demons") outputText("You look at the crowd for a moment, wondering which of their number you should bite. Your glance lands upon the leader of the group, easily spotted due to his snakeskin cloak. You quickly dart through the demon crowd as it closes in around you and lunge towards the broad form of the leader. You manage to catch the demon off guard, biting it viciously. The merciless cold of your bite transfer to your foe weakening it as you retreat before he manages to react.");
			//(Otherwise)
			else outputText("You lunge at the foe headfirst, maw open for a bite. You manage to catch the " + monster.a + monster.short + " off guard, biting it viciously. The merciless cold of your bite transfer to your foe weakening it as you retreat before " + monster.pronoun1 + " manages to react.");
			//The following is how the enemy reacts over time to poison. It is displayed after the description paragraph,instead of lust
			monster.str -= 5 + rand(5);
			monster.spe -= 5 + rand(5);
			if(monster.str < 1) monster.str = 1;
			if(monster.spe < 1) monster.spe = 1;
			if(monster.hasStatusEffect(StatusEffects.Frostbite))
			{
				monster.addStatusValue(StatusEffects.Frostbite,1,1);
			}
			else monster.createStatusEffect(StatusEffects.Frostbite,1,0,0,0);
		}
		else {
			outputText("You lunge headfirst, maw open for a bite. Your attempt fails horrendously, as " + monster.a + monster.short + " manages to counter your lunge, knocking your head away with enough force to make your ears ring.");
		}
		outputText("\n\n");
		if(monster.HP < 1 || monster.lust > monster.eMaxLust()) combatRoundOver();
		else enemyAI();
	}
//Mantis Omni Slash (AoE attack)
	public function mantisMultiSlash():void {
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
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attacks!\n\n");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attacks with superior quickness!\n\n");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attacks.\n\n");
			enemyAI();
			return;
		}
		if (monster.plural) {
			if (player.findPerk(PerkLib.MantislikeAgility) >= 0) {
				if (player.findPerk(PerkLib.MantislikeAgilityEvolved) >= 0 && player.findPerk(PerkLib.TrachealSystemEvolved) >= 0) flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 10;
				else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 6;
			}
			else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 3;
			
		}
		else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 1;
		mantisMultipleAttacks();
	}
	public function mantisMultipleAttacks():void {
		var damage:Number = 0;
		damage += player.spe;
		damage += speedscalingbonus() * 0.2;
		if (damage < 10) damage = 10;
		//adjusting to be used 60/100% of base speed while attacking depending on insect-related perks possesed
		if (player.findPerk(PerkLib.MantislikeAgility) < 0) damage *= 0.6;
		//bonuses if fighting multiple enemies
		if (monster.plural) {
			if (player.findPerk(PerkLib.MantislikeAgility) < 0 && player.findPerk(PerkLib.TrachealSystemEvolved) < 0) damage *= 1.1;
			if (player.findPerk(PerkLib.MantislikeAgility) >= 0 && player.findPerk(PerkLib.TrachealSystemEvolved) >= 0) damage *= 1.5;
		}
		//other bonuses
		damage += player.weaponAttack;
		if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80) damage *= 1.2;
		if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		outputText("Your scythes swiftly sweeps against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.findPerk(PerkLib.Rage) >= 0 && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n");
		checkAchievementDamage(damage);
		if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 0) {
			outputText("\n");
			enemyAI();
		}
		if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] >= 1) {
			flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
			mantisMultipleAttacks();
		}
	}
//Gore Attack - uses 15 fatigue!
	public function goreAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (monster.short == "worms") {
			outputText("Taking advantage of your new natural ");
			if (player.hornType == HORNS_COW_MINOTAUR) outputText("weapons, ");
			else outputText("weapon, ");
			outputText("you quickly charge at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving your ");
			if (player.hornType == HORNS_COW_MINOTAUR) outputText("horns ");
			else outputText("horn, ");
			outputText("to stab only at air.\n\n");
			enemyAI();
			return;
		}
		if(player.fatigue + physicalCost(25) > player.maxFatigue()) {
			outputText("You're too fatigued to use a charge attack!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(25,2);
		var damage:Number = 0;
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
			enemyAI();
			return;
		}
		//Bigger horns = better success chance.
		//Small horns - 60% hit
		if(player.horns >= 6 && player.horns < 12) {
			temp = 60;
		}
		//bigger horns - 75% hit
		if(player.horns >= 12 && player.horns < 20) {
			temp = 75;
		}
		//huge horns - 90% hit
		if(player.horns >= 20) {
			temp = 80;
		}
		//Vala dodgy bitch!
		if(monster.short == "Vala") {
			temp = 20;
		}
		//Account for monster speed - up to -50%.
		if (monster.spe <= 100) temp -= monster.spe / 2;
		else temp -= 50;
		//Account for player speed - up to +50%
		if (player.spe <= 100) temp += player.spe / 2;
		else temp += 50;
		//Hit & calculation
		if(temp >= rand(100)) {
			var horns:Number = player.horns;
			if (player.horns > 40) player.horns = 40;
			//Determine damage - str modified by enemy toughness!
			damage = int((unarmedAttack() + player.str + player.spe + horns) * 2 * (monster.damagePercent() / 100));
			if (!monster.hasStatusEffect(StatusEffects.GoreBleed)) monster.createStatusEffect(StatusEffects.GoreBleed,16,0,0,0);
			else {
				monster.removeStatusEffect(StatusEffects.GoreBleed);
				monster.createStatusEffect(StatusEffects.GoreBleed,16,0,0,0);
			}
			//normal
			if(rand(4) > 0) {
				outputText("You lower your head and charge, skewering " + monster.a + monster.short + " on ");
				if (player.hornType == HORNS_COW_MINOTAUR) outputText("one of your bullhorns!  ");
				else outputText("your horn!  ");
			}
			//CRIT
			else {
				//doubles horn bonus damage
				damage *= 2;
				outputText("You lower your head and charge, slamming into " + monster.a + monster.short + " and burying ");
				if (player.hornType == HORNS_COW_MINOTAUR) outputText("both your horns ");
				else outputText("your horn ");
				outputText("into " + monster.pronoun2 + "! <b>Critical hit!</b>  ");
			}
			//Bonus damage for rut!
			if(player.inRut && monster.cockTotal() > 0) {
				outputText("The fury of your rut lent you strength, increasing the damage!  ");
				damage *= 1.1;
			}
			//Reduced by armor
			damage *= monster.damagePercent() / 100;
			if(damage < 0) damage = 5;
			//Deal damage and update based on perks
			if(damage > 0) {
				if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
				if (player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
				if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
				if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
				if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
				if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
				damage = doDamage(damage);
			}
			//Different horn damage messages
			if(damage < 20) outputText("You pull yourself free, dealing <b><font color=\"#080000\">" + damage + "</font></b> damage.");
			if (damage >= 20 && damage < 40) {
				outputText("You struggle to pull your ");
				if (player.hornType == HORNS_COW_MINOTAUR) outputText("horns ");
				else outputText("horn ");
				outputText("free, dealing <b><font color=\"#080000\">" + damage + "</font></b> damage.");
			}
			if (damage >= 40) {
				outputText("With great difficulty you rip your ");
				if (player.hornType == HORNS_COW_MINOTAUR) outputText("horns ");
				else outputText("horn ");
				outputText("free, dealing <b><font color=\"#080000\">" + damage + "</font></b> damage.");
			}
		}
		//Miss
		else {
			//Special vala changes
			if(monster.short == "Vala") {
				outputText("You lower your head and charge Vala, but she just flutters up higher, grabs hold of your ");
				if (player.hornType == HORNS_COW_MINOTAUR) outputText("horns ");
				else outputText("horn ");
				outputText("as you close the distance, and smears her juicy, fragrant cunt against your nose.  The sensual smell and her excited moans stun you for a second, allowing her to continue to use you as a masturbation aid, but she quickly tires of such foreplay and flutters back with a wink.\n\n");
				dynStats("lus", 5);
			}
			else outputText("You lower your head and charge " + monster.a + monster.short + ", only to be sidestepped at the last moment!");
		}
		//New line before monster attack
		outputText("\n\n");
		checkAchievementDamage(damage);
		//Victory ORRRRR enemy turn.
		if(monster.HP > 0 && monster.lust < monster.eMaxLust()) enemyAI();
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
//Upheaval Attack
	public function upheavalAttack():void {
		clearOutput();
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (monster.short == "worms") {
			outputText("Taking advantage of your new natural weapon, you quickly charge at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving your horns to stab only at air.\n\n");
			enemyAI();
			return;
		}
		if(player.fatigue + physicalCost(15) > player.maxFatigue()) {
			outputText("You're too fatigued to use a charge attack!");
			doNext(combatMenu);
			return;
		}
		fatigue(15,2);
		var damage:Number = 0;
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
			enemyAI();
			return;
		}
		//Bigger horns = better success chance.
		//Small horns - 60% hit
		if(player.horns >= 6 && player.horns < 12) {
			temp = 60;
		}
		//bigger horns - 75% hit
		if(player.horns >= 12 && player.horns < 20) {
			temp = 75;
		}
		//huge horns - 90% hit
		if(player.horns >= 20) {
			temp = 80;
		}
		//Vala dodgy bitch!
		if(monster.short == "Vala") {
			temp = 20;
		}
		//Account for monster speed - up to -50%.
		temp -= monster.spe/2;
		//Account for player speed - up to +50%
		temp += player.spe/2;
		//Hit & calculation
		if(temp >= rand(100)) {
			var horns:Number = player.horns;
			if (player.horns > 40) player.horns = 40;
			damage = int(player.str + (player.tou / 2) + (player.spe / 2) + (player.level * 2) * 1.2 * (monster.damagePercent() / 100)); //As normal attack + horn length bonus
			if(damage < 0) damage = 5;
			//Normal
			outputText("You hurl yourself towards [enemy] with your head low and jerk your head upward, every muscle flexing as you send [enemy] flying. ");
			//Critical
			if (combatCritical()) {
				outputText("<b>Critical hit! </b>");
				damage *= 1.75;
			}
			//CAP 'DAT SHIT
			if(damage > player.level * 10 + 100) damage = player.level * 10 + 100;
			if(damage > 0) {
				if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
				if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
				if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
				if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
				//Round it off
				damage = int(damage);
				damage = doDamage(damage, true);
			}
			outputText("\n\n");
		}
		//Miss
		else {
			//Special vala changes
			if(monster.short == "Vala") {
				outputText("You lower your head and charge Vala, but she just flutters up higher, grabs hold of your horns as you close the distance, and smears her juicy, fragrant cunt against your nose.  The sensual smell and her excited moans stun you for a second, allowing her to continue to use you as a masturbation aid, but she quickly tires of such foreplay and flutters back with a wink.\n\n");
				dynStats("lus", 5);
			}
			else outputText("You hurl yourself towards [enemy] with your head low and snatch it upwards, hitting nothing but air.");
		}
		//New line before monster attack
		outputText("\n\n");
		checkAchievementDamage(damage);
		//Victory ORRRRR enemy turn.
		if(monster.HP > 0 && monster.lust < monster.eMaxLust()) enemyAI();
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			if(monster.lust >= monster.eMaxLust()) doNext(endLustVictory);
		}
	}
//Player sting attack
	public function playerStinger():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		//Keep logic sane if this attack brings victory
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (player.tailVenom < 25) {
			outputText("You do not have enough venom to sting right now!");
			doNext(psMenu);
			return;
		}
		//Worms are immune!
		if (monster.short == "worms") {
			outputText("Taking advantage of your new natural weapons, you quickly thrust your stinger at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving you to stab only at air.\n\n");
			enemyAI();
			return;
		}
		//Determine if dodged!
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
			enemyAI();
			return;
		}
		if(monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80) {
			if(monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your stinger!\n\n");
			if(monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your stinger with superior quickness!\n\n");
			if(monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attempts to sting " + monster.pronoun2 + ".\n\n");
			enemyAI();
			return;
		}
		//determine if avoided with armor.
		if(monster.armorDef - player.level >= 10 && rand(4) > 0) {
			outputText("Despite your best efforts, your sting attack can't penetrate " +  monster.a + monster.short + "'s defenses.\n\n");
			enemyAI();
			return;
		}
		//Sting successful!
		outputText("Searing pain lances through " + monster.a + monster.short + " as you manage to sting " + monster.pronoun2 + "!  ");
		if(monster.plural) outputText("You watch as " + monster.pronoun1 + " stagger back a step and nearly trip, flushing hotly.");
		else outputText("You watch as " + monster.pronoun1 + " staggers back a step and nearly trips, flushing hotly.");
		if (player.tailType == 6) {
			var damage:Number = 35 + rand(player.lib/10);
			//Level adds more damage up to a point (level 30)
			if (player.level < 10) damage += player.level * 3;
			else if (player.level < 20) damage += 30 + (player.level - 10) * 2;
			else if (player.level < 30) damage += 50 + (player.level - 20) * 1;
			else damage += 60;
			damage += 20;
			monster.teased(monster.lustVuln * damage);
		}
		if (player.tailType == 20) {
			monster.spe -= 10;
			if(monster.spe < 1) monster.spe = 1;
		}
		if(monster.hasStatusEffect(StatusEffects.NagaVenom))
		{
			monster.addStatusValue(StatusEffects.NagaVenom,3,5);
		}
		else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 5, 0);
		/*	if(!monster.hasStatusEffect(StatusEffects.lustvenom)) monster.createStatusEffect(StatusEffects.lustvenom, 0, 0, 0, 0);
		 IT used to paralyze 50% of the time, this is no longer the case!
		 Paralise the other 50%!
		 else {
		 outputText("Searing pain lances through " + monster.a + monster.short + " as you manage to sting " + monster.pronoun2 + "!  ");
		 if(monster.short == "demons") outputText("You watch as " + monster.pronoun1 + " stagger back a step and nearly trip, finding it hard to move as " + monster.pronoun1 + " are afflicted with your paralytic venom.  ");
		 else outputText("You watch as " + monster.pronoun1 + " staggers back a step and nearly trips, finding it hard to move as " + monster.pronoun1 + " is afflicted with your paralytic venom.  ");
		 if(monster.short == "demons") outputText("It appears that " + monster.a + monster.short + " are weaker and slower.");
		 else outputText("It appears that " + monster.a + monster.short + " is weaker and slower.");
		 monster.str -= (5+rand(player.lib/5))
		 monster.spe -= (5+rand(player.lib/5))
		 if(monster.str < 1) monster.str = 1;
		 if(monster.spe < 1) monster.spe = 1;
		 }*/
		//New line before monster attack
		outputText("\n\n");
		//Use tail mp
		player.tailVenom -= 25;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		//Kick back to main if no damage occured!
		if(monster.HP > 0 && monster.lust < monster.eMaxLust()) enemyAI();
		else doNext(endLustVictory);
	}
//Player tail spike attack
	public function playerTailSpike():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		//Keep logic sane if this attack brings victory
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (player.tailVenom < 25) {
			outputText("You do not have enough venom to shoot spike right now!");
			doNext(psMenu);
			return;
		}
		//Worms are immune!
		if (monster.short == "worms") {
			outputText("Taking advantage of your new natural weapons, you quickly shooting an envenomed spike at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving your spike impale the ground behind.\n\n");
			enemyAI();
			return;
		}
		//Determine if dodged!
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
			enemyAI();
			return;
		}
		if(monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80) {
			if(monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your spike!\n\n");
			if(monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your spike with superior quickness!\n\n");
			if(monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attempts to hit with a spike " + monster.pronoun2 + ".\n\n");
			enemyAI();
			return;
		}
		//determine if avoided with armor.
		if(monster.armorDef - player.level >= 10 && rand(4) > 0) {
			outputText("Despite your best efforts, your spike attack can't penetrate " +  monster.a + monster.short + "'s defenses.\n\n");
			enemyAI();
			return;
		}
		//Sting successful!
		outputText("You drop on all fours, flinging your tail forward and shooting an envenomed spike at " + monster.a + monster.short + ".");
		//Phys dmg!
		var damage:Number = unarmedAttack();
		damage += player.spe;
		damage += speedscalingbonus() * 0.2;
		if (damage < 10) damage = 10;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("\n\nThis deal " + damage + " damage as your victim grow increasingly flushed by your potent aphrodisiac.");
		//Lust damage!
		var lustdamage:Number = 35 + rand(player.lib / 10);
		if (player.level < 10) damage += 20 + (player.level * 3);
		else if (player.level < 20) damage += 50 + (player.level - 10) * 2;
		else if (player.level < 30) damage += 70 + (player.level - 20) * 1;
		else damage += 80;
		lustdamage *= 0.7;
		monster.teased(monster.lustVuln * lustdamage);
		monster.spe -= 10;
		if(monster.spe < 1) monster.spe = 1;
		if(monster.hasStatusEffect(StatusEffects.NagaVenom))
		{
			monster.addStatusValue(StatusEffects.NagaVenom,3,5);
		}
		else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 5, 0);
		//if (!monster.hasStatusEffect(StatusEffects.lustvenom)) monster.createStatusEffect(StatusEffects.lustvenom, 0, 0, 0, 0);
		//New line before monster attack
		outputText("\n\n");
		monster.spe -= (2+rand(3));
		if(monster.spe < 1) monster.spe = 1;
		//Use tail mp
		player.tailVenom -= 25;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		//Kick back to main if no damage occured!
		if(player.hasStatusEffect(StatusEffects.FirstAttack)) player.removeStatusEffect(StatusEffects.FirstAttack);
		else {
			if (player.findPerk(PerkLib.ManticoreMetabolism) >= 0) player.createStatusEffect(StatusEffects.FirstAttack,0,0,0,0);
			playerTailSpike();
		}
		if(monster.HP > 0 && monster.lust < monster.eMaxLust()) enemyAI();
		else doNext(endLustVictory);
	}


	public function kissAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		if(player.hasStatusEffect(StatusEffects.Blind)) {
			clearOutput();
			outputText("There's no way you'd be able to find their lips while you're blind!");
//Pass false to combatMenu instead:		menuLoc = 3;
			doNext(psMenu);
			return;
		}
		clearOutput();
		var attack:Number = rand(6);
		switch(attack) {
			case 1:
				//Attack text 1:
				outputText("You hop up to " + monster.a + monster.short + " and attempt to plant a kiss on " + monster.pronoun3 + ".");
				break;
				//Attack text 2:
			case 2:
				outputText("You saunter up and dart forward, puckering your golden lips into a perfect kiss.");
				break;
				//Attack text 3:
			case 3:
				outputText("Swaying sensually, you wiggle up to " + monster.a + monster.short + " and attempt to plant a nice wet kiss on " + monster.pronoun2 + ".");
				break;
				//Attack text 4:
			case 4:
				outputText("Lunging forward, you fly through the air at " + monster.a + monster.short + " with your lips puckered and ready to smear drugs all over " + monster.pronoun2 + ".");
				break;
				//Attack text 5:
			case 5:
				outputText("You lean over, your lips swollen with lust, wet with your wanting slobber as you close in on " + monster.a + monster.short + ".");
				break;
				//Attack text 6:
			default:
				outputText("Pursing your drug-laced lips, you close on " + monster.a + monster.short + " and try to plant a nice, wet kiss on " + monster.pronoun2 + ".");
				break;
		}
		//Dodged!
		if(monster.spe - player.spe > 0 && rand(((monster.spe - player.spe)/4)+80) > 80) {
			attack = rand(3);
			switch(attack) {
					//Dodge 1:
				case 1:
					if(monster.plural) outputText("  " + monster.capitalA + monster.short + " sees it coming and moves out of the way in the nick of time!\n\n");
					break;
					//Dodge 2:
				case 2:
					if(monster.plural) outputText("  Unfortunately, you're too slow, and " + monster.a + monster.short + " slips out of the way before you can lay a wet one on one of them.\n\n");
					else outputText("  Unfortunately, you're too slow, and " + monster.a + monster.short + " slips out of the way before you can lay a wet one on " + monster.pronoun2 + ".\n\n");
					break;
					//Dodge 3:
				default:
					if(monster.plural) outputText("  Sadly, " + monster.a + monster.short + " moves aside, denying you the chance to give one of them a smooch.\n\n");
					else outputText("  Sadly, " + monster.a + monster.short + " moves aside, denying you the chance to give " + monster.pronoun2 + " a smooch.\n\n");
					break;
			}
			enemyAI();
			return;
		}
		//Success but no effect:
		if(monster.lustVuln <= 0 || !monster.hasCock()) {
			if(monster.plural) outputText("  Mouth presses against mouth, and you allow your tongue to stick out to taste the saliva of one of their number, making sure to give them a big dose.  Pulling back, you look at " + monster.a + monster.short + " and immediately regret wasting the time on the kiss.  It had no effect!\n\n");
			else outputText("  Mouth presses against mouth, and you allow your tongue to stick to taste " + monster.pronoun3 + "'s saliva as you make sure to give them a big dose.  Pulling back, you look at " + monster.a + monster.short + " and immediately regret wasting the time on the kiss.  It had no effect!\n\n");
			enemyAI();
			return;
		}
		attack = rand(4);
		var damage:Number = 0;
		switch(attack) {
				//Success 1:
			case 1:
				if(monster.plural) outputText("  Success!  A spit-soaked kiss lands right on one of their mouths.  The victim quickly melts into your embrace, allowing you to give them a nice, heavy dose of sloppy oral aphrodisiacs.");
				else outputText("  Success!  A spit-soaked kiss lands right on " + monster.a + monster.short + "'s mouth.  " + monster.mf("He","She") + " quickly melts into your embrace, allowing you to give them a nice, heavy dose of sloppy oral aphrodisiacs.");
				damage = 15;
				break;
				//Success 2:
			case 2:
				if(monster.plural) outputText("  Gold-gilt lips press into one of their mouths, the victim's lips melding with yours.  You take your time with your suddenly cooperative captive and make sure to cover every bit of their mouth with your lipstick before you let them go.");
				else outputText("  Gold-gilt lips press into " + monster.a + monster.short + ", " + monster.pronoun3 + " mouth melding with yours.  You take your time with your suddenly cooperative captive and make sure to cover every inch of " + monster.pronoun3 + " with your lipstick before you let " + monster.pronoun2 + " go.");
				damage = 20;
				break;
				//CRITICAL SUCCESS (3)
			case 3:
				if(monster.plural) outputText("  You slip past " + monster.a + monster.short + "'s guard and press your lips against one of them.  " + monster.mf("He","She") + " melts against you, " + monster.mf("his","her") + " tongue sliding into your mouth as " + monster.mf("he","she") + " quickly succumbs to the fiery, cock-swelling kiss.  It goes on for quite some time.  Once you're sure you've given a full dose to " + monster.mf("his","her") + " mouth, you break back and observe your handwork.  One of " + monster.a + monster.short + " is still standing there, licking " + monster.mf("his","her") + " his lips while " + monster.mf("his","her") + " dick is standing out, iron hard.  You feel a little daring and give the swollen meat another moist peck, glossing the tip in gold.  There's no way " + monster.mf("he","she") + " will go soft now.  Though you didn't drug the rest, they're probably a little 'heated up' from the show.");
				else outputText("  You slip past " + monster.a + monster.short + "'s guard and press your lips against " + monster.pronoun3 + ".  " + monster.mf("He","She") + " melts against you, " + monster.pronoun3 + " tongue sliding into your mouth as " + monster.pronoun1 + " quickly succumbs to the fiery, cock-swelling kiss.  It goes on for quite some time.  Once you're sure you've given a full dose to " + monster.pronoun3 + " mouth, you break back and observe your handwork.  " + monster.capitalA + monster.short + " is still standing there, licking " + monster.pronoun3 + " lips while " + monster.pronoun3 + " dick is standing out, iron hard.  You feel a little daring and give the swollen meat another moist peck, glossing the tip in gold.  There's no way " + monster.pronoun1 + " will go soft now.");
				damage = 30;
				break;
				//Success 4:
			default:
				outputText("  With great effort, you slip through an opening and compress their lips against your own, lust seeping through the oral embrace along with a heavy dose of drugs.");
				damage = 12;
				break;
		}
		//Add status if not already drugged
		if(!monster.hasStatusEffect(StatusEffects.LustStick)) monster.createStatusEffect(StatusEffects.LustStick,0,0,0,0);
		//Else add bonus to round damage
		else monster.addStatusValue(StatusEffects.LustStick,2,Math.round(damage / 10));
		//Deal damage
		monster.teased(monster.lustVuln * damage);
		outputText("\n\n");
		//Sets up for end of combat, and if not, goes to AI.
		if(!combatRoundOver()) enemyAI();
	}
//Mouf Attack
// (Similar to the bow attack, high damage but it raises your fatigue).
	public function bite():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		if(player.fatigue + physicalCost(25) > player.maxFatigue()) {
			clearOutput();
			if (player.faceType == FACE_SHARK_TEETH) outputText("You're too fatigued to use your shark-like jaws!");
			if (player.faceType == FACE_ORCA) outputText("You're too fatigued to use your orca-like jaws!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		//Worms are special
		if(monster.short == "worms") {
			clearOutput();
			outputText("There is no way those are going anywhere near your mouth!\n\n");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(25,2);
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
			enemyAI();
			return;
		}
		outputText("You open your mouth wide, your ");
		if (player.faceType == FACE_SHARK_TEETH) outputText("shark teeth extending out");
		if (player.faceType == FACE_ORCA) outputText("sharp orca teeth shining briefly");
		clearOutput();
		outputText(". Snarling with hunger, you lunge at your opponent, set to bite right into them!  ");
		if(player.hasStatusEffect(StatusEffects.Blind)) outputText("In hindsight, trying to bite someone while blind was probably a bad idea... ");
		var damage:Number = 0;
		//Determine if dodged!
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(3) != 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if(monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
			if(monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
			if(monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
			outputText("\n\n");
			enemyAI();
			return;
		}
		//Determine damage - str modified by enemy toughness!
		damage = int((player.str + player.spe) * 3 * (monster.damagePercent() / 100));
		if (!monster.hasStatusEffect(StatusEffects.SharkBiteBleed)) monster.createStatusEffect(StatusEffects.SharkBiteBleed,15,0,0,0);
		else {
			monster.removeStatusEffect(StatusEffects.SharkBiteBleed);
			monster.createStatusEffect(StatusEffects.SharkBiteBleed,15,0,0,0);
		}
		//Deal damage and update based on perks
		if(damage > 0) {
			if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
			if (player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
			if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
			if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
			if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
			if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
			damage = doDamage(damage);
		}
		if(damage <= 0) {
			damage = 0;
			outputText("Your bite is deflected or blocked by " + monster.a + monster.short + ". ");
		}
		if(damage > 0 && damage < 10) {
			outputText("You bite doesn't do much damage to " + monster.a + monster.short + "! ");
		}
		if(damage >= 10 && damage < 20) {
			outputText("You seriously wound " + monster.a + monster.short + " with your bite! ");
		}
		if(damage >= 20 && damage < 30) {
			outputText("Your bite staggers " + monster.a + monster.short + " with its force. ");
		}
		if(damage >= 30) {
			outputText("Your powerful bite <b>mutilates</b> " + monster.a + monster.short + "! ");
		}
		if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
		outputText(" " + monster.capitalA + monster.short + " bleeds profusely from the many bloody bite marks you leave behind.");
		outputText("\n\n");
		checkAchievementDamage(damage);
		//Kick back to main if no damage occured!
		if(monster.HP > 0 && monster.lust < monster.eMaxLust()) {
			enemyAI();
		}
		else {
			if(monster.HP <= 0) doNext(endHpVictory);
			else doNext(endLustVictory);
		}
	}
	
	public function kick():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if(player.fatigue + physicalCost(20) > player.maxFatigue()) {
			clearOutput();
			outputText("You're too fatigued to use a charge attack!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(20,2);
		player.createStatusEffect(StatusEffects.CooldownKick,5,0,0,0);
		//Variant start messages!
		if(player.lowerBody == LOWER_BODY_TYPE_KANGAROO) {
			//(tail)
			if(player.tailType == TAIL_TYPE_KANGAROO) outputText("You balance on your flexible kangaroo-tail, pulling both legs up before slamming them forward simultaneously in a brutal kick.  ");
			//(no tail)
			else outputText("You balance on one leg and cock your powerful, kangaroo-like leg before you slam it forward in a kick.  ");
		}
		//(bunbun kick)
		else if(player.lowerBody == LOWER_BODY_TYPE_BUNNY) outputText("You leap straight into the air and lash out with both your furred feet simultaneously, slamming forward in a strong kick.  ");
		//(centaur kick)
		else if(player.lowerBody == LOWER_BODY_TYPE_HOOFED || player.lowerBody == LOWER_BODY_TYPE_PONY || player.lowerBody == LOWER_BODY_TYPE_CLOVEN_HOOFED)
			if(player.isTaur()) outputText("You lurch up onto your backlegs, lifting your forelegs from the ground a split-second before you lash them out in a vicious kick.  ");
			//(bipedal hoof-kick)
			else outputText("You twist and lurch as you raise a leg and slam your hoof forward in a kick.  ");

		if(flags[kFLAGS.PC_FETISH] >= 3) {
			outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Ceraph's piercings have made normal attack impossible!  Maybe you could try something else?\n\n");
			enemyAI();
			return;
		}
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
			enemyAI();
			return;
		}
		//Blind
		if(player.hasStatusEffect(StatusEffects.Blind)) {
			outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ");
		}
		//Worms are special
		if(monster.short == "worms") {
			//50% chance of hit (int boost)
			if(rand(100) + player.inte/3 >= 50) {
				temp = int(player.str / 5 - rand(5));
				if(player.tailType == TAIL_TYPE_KANGAROO) temp += 3;
				if(temp == 0) temp = 1;
				outputText("You strike at the amalgamation, crushing countless worms into goo, dealing " + temp + " damage.\n\n");
				monster.HP -= temp;
				if(monster.HP <= 0) {
					doNext(endHpVictory);
					return;
				}
			}
			//Fail
			else {
				outputText("You attempt to crush the worms with your reprisal, only to have the collective move its individual members, creating a void at the point of impact, leaving you to attack only empty air.\n\n");
			}
			enemyAI();
			return;
		}
		//Determine if dodged!
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			//Akbal dodges special education
			if(monster.short == "Akbal") outputText("Akbal moves like lightning, weaving in and out of your furious attack with the speed and grace befitting his jaguar body.\n");
			else {
				outputText(monster.capitalA + monster.short + " manage");
				if(!monster.plural) outputText("s");
				outputText(" to dodge your kick!");
				outputText("\n\n");
			}
			enemyAI();
			return;
		}
		//Determine damage
		//Base:
		var damage:Number = unarmedAttack();
		damage += strenghtscalingbonus() * 0.5;
		damage += speedscalingbonus() * 0.5;
		//Leg bonus
		//Bunny - 20, 1 hoof = 30, 2 hooves = 40, Kangaroo - 50
		if(player.lowerBody == LOWER_BODY_TYPE_HOOFED || player.lowerBody == LOWER_BODY_TYPE_PONY || player.lowerBody == LOWER_BODY_TYPE_CLOVEN_HOOFED)
			damage += 30;
		else if(player.lowerBody == LOWER_BODY_TYPE_BUNNY) damage += 20;
		else if (player.lowerBody == LOWER_BODY_TYPE_KANGAROO) damage += 50;
		if(player.isTaur()) damage += 10;
		//Damage post processing!
		if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= 1.1;
		if (player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
		if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		//Reduce damage
		damage *= monster.damagePercent() / 100;
		//(None yet!)
		if(damage > 0) damage = doDamage(damage);
		monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		//BLOCKED
		if(damage <= 0) {
			damage = 0;
			outputText(monster.capitalA + monster.short);
			if(monster.plural) outputText("'");
			else outputText("s");
			outputText(" defenses are too tough for your kick to penetrate!");
		}
		//LAND A HIT!
		else {
			outputText(monster.capitalA + monster.short);
			if(!monster.plural) outputText(" reels from the damaging impact! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			else outputText(" reel from the damaging impact! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		}
		if(damage > 0) {
			//Lust raised by anemone contact!
			if(monster.short == "anemone") {
				outputText("\nThough you managed to hit the anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.");
				//(gain lust, temp lose str/spd)
				(monster as Anemone).applyVenom((1+rand(2)));
			}
			//Lust raised by sea anemone contact!
			if(monster.short == "sea anemone") {
				outputText("\nThough you managed to hit the sea anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.");
				//(gain lust, temp lose str/spd)
				(monster as SeaAnemone).applyVenom((1+rand(2)));
			}
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		if(monster.HP < 1 || monster.lust > monster.eMaxLust()) combatRoundOver();
		else enemyAI();
	}

	public function shieldBash():void {
		clearOutput();
		if (player.fatigue + physicalCost(20) > player.maxFatigue()) {
			outputText("You are too tired to perform a shield bash.");
			doNext(combatMenu);
			return;
		}
		outputText("You ready your [shield] and prepare to slam it towards " + monster.a + monster.short + ".  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
			enemyAI();
			return;
		}
		var damage:int = 10 + (player.str / 1.5) + rand(player.str / 2) + (player.shieldBlock * 2);
		if (player.findPerk(PerkLib.ShieldSlam) >= 0) damage *= 1.2;
		if (player.findPerk(PerkLib.SteelImpact) >= 0) damage += ((player.tou - 50) * 0.3);
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		damage *= (monster.damagePercent() / 100);
		var chance:int = Math.floor(monster.statusEffectv1(StatusEffects.TimesBashed) + 1);
		if (chance > 10) chance = 10;
		damage = doDamage(damage);
		outputText("Your [shield] slams against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
		if (!monster.hasStatusEffect(StatusEffects.Stunned) && rand(chance) == 0) {
			outputText("<b>Your impact also manages to stun " + monster.a + monster.short + "!</b> ");
			monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			if (!monster.hasStatusEffect(StatusEffects.TimesBashed)) monster.createStatusEffect(StatusEffects.TimesBashed, player.findPerk(PerkLib.ShieldSlam) >= 0 ? 0.5 : 1, 0, 0, 0);
			else monster.addStatusValue(StatusEffects.TimesBashed, 1, player.findPerk(PerkLib.ShieldSlam) >= 0 ? 0.5 : 1);
		}
		checkAchievementDamage(damage);
		fatigue(20,2);
		outputText("\n\n");
		enemyAI();
	}
	public function archerSidewinder():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.fatigue + bowCost(300) > player.maxFatigue()) {
			outputText("You are too tired to attack " + monster.a + " " + monster.short + ".");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		outputText("You draw but a single arrow infusing a massive amount of magical energy in the bolt which begin to emit a ");
		if (player.cor > 50) outputText("red");
		else if (player.cor < 50) outputText("white");
		else {
			if (rand(2) == 1) outputText("red");
			else outputText("white");
		}
		outputText(" light and grow turning into a huge spear of condensed energy.  ");
		fatigue(300,4);
		var damage:Number = 0;
		damage += player.spe;
		damage += speedscalingbonus() * 0.2;
		if (damage < 10) damage = 10;
		if (player.findPerk(PerkLib.DeadlyAim) < 0) damage *= (monster.damagePercent() / 100);//jak ten perk o ignorowaniu armora bedzie czy coś to tu dać jak nie ma tego perku to sie dolicza
		//Weapon addition!
		if (player.weaponRangeAttack < 51) damage *= (1 + (player.weaponRangeAttack * 0.03));
		else if (player.weaponRangeAttack >= 51 && player.weaponRangeAttack < 101) damage *= (2.5 + ((player.weaponRangeAttack - 50) * 0.025));
		else if (player.weaponRangeAttack >= 101 && player.weaponRangeAttack < 151) damage *= (3.75 + ((player.weaponRangeAttack - 100) * 0.02));
		else if (player.weaponRangeAttack >= 151 && player.weaponRangeAttack < 201) damage *= (4.75 + ((player.weaponRangeAttack - 150) * 0.015));
		else damage *= (5.5 + ((player.weaponRangeAttack - 200) * 0.01));
		//add bonus for attacking animal-morph or beast enemy
		if (monster.findPerk(PerkLib.EnemyBeastOrAnimalMorphType) >= 0) damage *= 15;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.VitalShot) >= 0 && player.inte >= 50) critChance += 10;
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (player.findPerk(PerkLib.HistoryScout) >= 0 || player.findPerk(PerkLib.PastLifeScout) >= 0) damage *= 1.1;
		if (player.findPerk(PerkLib.JobRanger) >= 0) damage *= 1.05;
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 5;
			if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 2;
			if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 0.5;
			if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 0.2;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 0.5;
			if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 0.2;
			if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 5;
			if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 2;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("You shoot the projectile toward your opponent the bolt flying at such speed and velocity all you see is a flash of light as it reach " + monster.a + monster.short + " and explode the blast projecting dirt and rock everywhere. It takes an entire minute for the smoke to settle. (<b><font color=\"#800000\">" + damage + "</font></b>) ");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		flags[kFLAGS.ARROWS_SHOT]++;
		bowPerkUnlock();
		checkAchievementDamage(damage);
		enemyAI();
	}

	public function archerBarrage():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.fatigue + bowCost(300) > player.maxFatigue()) {
			outputText("You are too tired to attack " + monster.a + " " + monster.short + ".");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		outputText("You ready your [weapon] and prepare to spin it around trying to hit as many " + monster.a + monster.short + " as possible.  ");
		fatigue(300,4);
		var damage:Number = 0;
		damage += player.spe;
		damage += speedscalingbonus() * 0.2;
		if (damage < 10) damage = 10;
		if (player.findPerk(PerkLib.DeadlyAim) < 0) damage *= (monster.damagePercent() / 100);//jak ten perk o ignorowaniu armora bedzie czy coś to tu dać jak nie ma tego perku to sie dolicza
		//Weapon addition!
		if (player.weaponRangeAttack < 51) damage *= (1 + (player.weaponRangeAttack * 0.03));
		else if (player.weaponRangeAttack >= 51 && player.weaponRangeAttack < 101) damage *= (2.5 + ((player.weaponRangeAttack - 50) * 0.025));
		else if (player.weaponRangeAttack >= 101 && player.weaponRangeAttack < 151) damage *= (3.75 + ((player.weaponRangeAttack - 100) * 0.02));
		else if (player.weaponRangeAttack >= 151 && player.weaponRangeAttack < 201) damage *= (4.75 + ((player.weaponRangeAttack - 150) * 0.015));
		else damage *= (5.5 + ((player.weaponRangeAttack - 200) * 0.01));
		//add bonus for using aoe special
		damage *= 12;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.findPerk(PerkLib.VitalShot) >= 0 && player.inte >= 50) critChance += 10;
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (player.findPerk(PerkLib.HistoryScout) >= 0 || player.findPerk(PerkLib.PastLifeScout) >= 0) damage *= 1.1;
		if (player.findPerk(PerkLib.JobRanger) >= 0) damage *= 1.05;
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 5;
			if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 2;
			if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 0.5;
			if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 0.2;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
			if (monster.findPerk(PerkLib.IceNature) >= 0) damage *= 0.5;
			if (monster.findPerk(PerkLib.FireVulnerability) >= 0) damage *= 0.2;
			if (monster.findPerk(PerkLib.IceVulnerability) >= 0) damage *= 5;
			if (monster.findPerk(PerkLib.FireNature) >= 0) damage *= 2;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("You grab six arrows and display them like a fan on your bow as a swift motion. Holding your weapon horizontally you shoot them all spraying " + monster.a + monster.short + " with projectile then do it a second time showering them with an extra volley of arrows. (<b><font color=\"#800000\">" + damage + "</font></b>) ");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		flags[kFLAGS.ARROWS_SHOT] += 12;
		bowPerkUnlock();
		checkAchievementDamage(damage);
		enemyAI();
	}

	public function PhysicalSpecials() {
	}
}
}
