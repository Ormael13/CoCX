/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
import classes.BodyParts.*;
import classes.CoC;
import classes.EngineCore;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Items.ItemTags;
import classes.Items.Weapons.Tidarion;
import classes.PerkLib;
import classes.Races;
import classes.Scenes.Areas.Bog.LizanRogue;
import classes.Scenes.Areas.Caves.DisplacerBeast;
import classes.Scenes.Areas.Forest.Akbal;
import classes.Scenes.Areas.Lake.GooGirl;
import classes.Scenes.Areas.Mountain.WormMass;
import classes.Scenes.Areas.Ocean.SeaAnemone;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.Scenes.Dungeons.DeepCave.EncapsulationPod;
import classes.Scenes.Dungeons.DeepCave.Vala;
import classes.Scenes.NPCs.AetherTwinsFollowers;
import classes.Scenes.Places.Boat.Anemone;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.Places.WoodElves;
import classes.Scenes.SceneLib;
import classes.StatusEffectType;
import classes.StatusEffects;

import coc.view.ButtonData;
import coc.view.ButtonDataList;

public class PhysicalSpecials extends BaseCombatContent {
	//------------
	// P. SPECIALS
	//------------
	internal function buildMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		var isEnemyInvisible:Boolean = combat.isEnemyInvisible;
		if (!player.isInGoblinMech() && !player.isInNonGoblinMech()) {
			if (player.isFlying() == monster.isFlying()) {
				if (player.hasPerk(PerkLib.PowerAttack)) {
					bd = buttons.add("PowerAttack", powerAttack).hint("Do a single way more powerfull wrath-enhanced melee strike.");
					if (player.wrath100 < 1) bd.disable("You're too low on wrath to use Power Attack (below 1%)");
					else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (player.statStore.hasBuff("AsuraForm")) {
					bd = buttons.add("Asura's Howl", combat.asurasHowl).hint("Unleash a howl before giving enemy good punching. \n\nWrath Cost: 50");
					if (player.wrath < 50) {
						bd.disable("Your wrath is too low to unleash howl!");
					}
					if (player.hasPerk(PerkLib.AbsoluteStrength)) {
						if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) bd = buttons.add("TFoD", combat.asuras10FingersOfDestruction).hint("Ten Fingers of Destruction - Poke your enemies Asura Style. \n\nWrath Cost: 50% of max Wrath");
						else if (player.hasPerk(PerkLib.AsuraStrength)) bd = buttons.add("EFoD", combat.asuras8FingersOfDestruction).hint("Eight Fingers of Destruction - Poke your enemies Asura Style. \n\nWrath Cost: 50% of max Wrath");
						else bd = buttons.add("SFoD", combat.asuras6FingersOfDestruction).hint("Six Fingers of Destruction - Poke your enemies Asura Style. \n\nWrath Cost: 50% of max Wrath");
						if (player.wrath < (player.maxWrath() * 0.5)) {
							bd.disable("Your wrath is too low to poke your enemies Asura Style!");
						}
					}
					if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) {

					}
				}
				if (player.haveWeaponForCleave() && player.hasStatusEffect(StatusEffects.KnowsCleave)) {
					bd = buttons.add("Cleave", pcCleave).hint("Deal extra damage to multiple foes. Cause area effect bleed damage.");
					if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if ((player.hasPerk(PerkLib.SneakyAttack) && player.haveWeaponForSneakAttack() && (monster.monsterIsStunned()
					|| monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind) || monster.hasStatusEffect(StatusEffects.Distracted)))||
						(player.hasStatusEffect(StatusEffects.EverywhereAndNowhere) && player.haveWeaponForSneakAttack())) {
					bd = buttons.add("SneakAttack (M)", sneakAttack).hint("Strike the vitals of a stunned, blinded or distracted opponent for heavy damage. (Melee variant)");
					if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (!player.isStaffTypeWeapon()) {
					bd = buttons.add("Charge", charging).hint("Charge at your opponent for massive damage. Deals more damage if using a spear or lance. Gains extra damage from the usage of a horn or a pair of horns.");
					if (player.statStore.hasBuff("ScarletSpiritCharge")) {
						if (player.HP <= (player.minHP() + (chargingcoooooost() * 2))) bd.disable("Your hp is too low to perform Charge.");
					}
					else {
						bd.requireFatigue(chargingcoooooost());
						if (player.hasStatusEffect(StatusEffects.CooldownCharging)) {
							bd.disable("<b>You need more time before you can perform Charge again.</b>\n\n");
						}
					}
					if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (!player.hasPerk(PerkLib.ElementalBody)) {
					if (player.hairType == 4) {
						bd = buttons.add("AnemoneSting", anemoneSting).hint("Attempt to strike an opponent with the stinging tentacles growing from your scalp.  Reduces enemy speed and increases enemy lust.", "Anemone Sting");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					//Bitez
					if (player.faceType == Face.SHARK_TEETH || player.faceType == Face.ABYSSAL_SHARK) {
						bd = buttons.add("SharkBite", bite).hint("Attempt to bite your opponent with your shark-teeth.");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					if (player.faceType == Face.ORCA) {
						bd = buttons.add("OrcaBite", bite).hint("Bite your opponent with your sharp teeths causing bleed.");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					if (player.faceType == Face.WOLF) {
						bd = buttons.add("ViciousBite", bite).hint("Viciously bite your opponent with your sharp teeths causing bleed.");
						if (player.hasPerk(PerkLib.FreezingBreath)) buttons.add("Frostbite", fenrirFrostbite).hint("You bite in your foe slowly infecting it with cold chill weakening its strength and resolve.");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					if (player.faceType == Face.CERBERUS) {
						bd = buttons.add("TripleBite", bite).hint("Viciously bite your opponent with your sharp teeths causing bleed.");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					//hydra bite - variant of snake bite
					if ((player.faceType == Face.SNAKE_FANGS || player.perkv1(IMutationsLib.VenomGlandsIM) >= 1)) {
						if (player.lowerBody == LowerBody.HYDRA) {
							bd = buttons.add("HydraBite", hydraBiteAttack).hint("Deal as many attacks as pc got heads. Also delivers naga poison for as many time as pc got heads. (lower enemy str and spe)  \n\nVenom: " + player.tailVenom + "/" + player.maxVenom());
							if (player.tailVenom < player.VenomWebCost() * 5) {
								bd.disable("You do not have enough venom to use hydra bite right now! (Req. " + player.VenomWebCost() * 5 + "+)");
							} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
							bd.requireFatigue(physicalCost(10 * player.statusEffectv1(StatusEffects.HydraTailsPlayer)));
						} else {
							bd = buttons.add("SnakeBite", nagaBiteAttack).hint("Attempt to bite your opponent and inject venom. (lower enemy str and spe)  \n\nVenom: " + player.tailVenom + "/" + player.maxVenom());
							if (player.tailVenom < player.VenomWebCost() * 5) {
								bd.disable("You do not have enough venom to use snake bite right now! (Req. " + player.VenomWebCost() * 5 + "+)");
							} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
						}
					}
					if ((player.faceType == Face.SPIDER_FANGS || player.faceType == Face.USHI_ONI || player.perkv1(IMutationsLib.VenomGlandsIM) >= 1)) {
						bd = buttons.add("SpiderBite", spiderBiteAttack).hint("Attempt to bite your opponent and inject venom. (deal lust dmg and lower gradualy enemy lust resistance)  \n\nVenom: " + player.tailVenom + "/" + player.maxVenom());
						if (player.tailVenom < player.VenomWebCost() * 5) {
							bd.disable("You do not have enough venom to use spider bite right now!");
						} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					//Ant Bite
					if ((player.faceType == Face.ANT || player.perkv1(IMutationsLib.VenomGlandsIM) >= 1)) {
						bd = buttons.add("Ant Bite", antBiteAttack).hint("Attempt to bite your opponent and inject formic acid. (deal acid dmg and lower toughness)  \n\nVenom: " + player.tailVenom + "/" + player.maxVenom());
						if (player.tailVenom < player.VenomWebCost() * 5) {
							bd.disable("You do not have enough venom to use ant bite right now!");
						} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					if (player.isSandWorm()) {
						bd = buttons.add("Devastating Bite", devastatingBiteAttack).hint("Attempt to bite your opponent with your giant sandworm maw. (deal acid dmg)");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					//Constrict
					if (player.isNaga()) {
						bd = buttons.add("Constrict", SceneLib.desert.nagaScene.nagaPlayerConstrict).hint("Attempt to bind an enemy in your long snake-tail.");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					//Cancer Grab
					if (player.lowerBody == LowerBody.CANCER || player.rearBody.type == RearBody.ARIGEAN_PINCER_LIMBS) {
						bd = buttons.add("Grab", combat.CancerGrab).hint("Grab your opponents with your pincers, then proceed to crush them.");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					//Engulf
					if (player.lowerBody == LowerBody.GOO) {
						bd = buttons.add("Engulf", gooEngulf).hint("Attempt to engulf a foe with your body.");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					//Embrace
					if ((player.arms.type == Arms.BAT || player.wings.type == Wings.VAMPIRE) && !monster.hasPerk(PerkLib.EnemyGroupType) && !monster.hasPerk(PerkLib.EnemyLargeGroupType)) {
						bd = buttons.add("Embrace", vampireEmbrace).hint("Embrace an opponent in your wings.");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					//Gore if mino horns or unicorn/alicorn/bicorn/nightmare horns
					if ((player.horns.type == Horns.COW_MINOTAUR || player.horns.type == Horns.FROSTWYRM) && player.horns.count >= 6) {
						bd = buttons.add("Gore", goreAttack).hint("Lower your head and charge your opponent, attempting to gore them on your horns. This attack is stronger and easier to land with large horns.");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					if ((player.horns.type == Horns.UNICORN || player.horns.type == Horns.BICORN) && player.horns.count >= 6) {
						bd = buttons.add("Gore", goreAttack).hint("Lower your head and charge your opponent, attempting to gore them on your horn" + (player.horns.type == Horns.BICORN ? "s" : "") + ".  This attack is stronger and easier to land with large horn" + (player.horns.type == Horns.BICORN ? "s" : "") + ".");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					if ((player.horns.type == Horns.KIRIN) && player.horns.count >= 6) {
						bd = buttons.add("Thunder Gore", thunderGoreAttack).hint("Lower your head and charge your opponent, attempting to gore them on your horn.  This attack is stronger and easier to land with large horn. Scales with electricity damage and stun but has a long cooldown.");
						if (player.hasStatusEffect(StatusEffects.CooldownThunderGore)) {
							bd.disable("<b>You need more time before you can perform Thunder Gore again.</b>\n\n");
							if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
						}
					}
					//Upheaval - requires rhino horns
					if (player.horns.type == Horns.RHINO && player.horns.count >= 2 && player.faceType == Face.RHINO) {
						bd = buttons.add("Upheaval", upheavalAttack).hint("Send your foe flying with your dual nose mounted horns. \n");
						if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(30));
						else bd.requireFatigue(physicalCost(15));
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					//Grapple
					if ((player.lowerBody == LowerBody.SCYLLA || player.lowerBody == LowerBody.KRAKEN || player.isRaceCached(Races.MMINDBREAKER) || player.isRaceCached(Races.FMINDBREAKER))) {
						bd = buttons.add("Grapple", scyllaGrapple).hint("Attempt to grapple a foe with your tentacles.");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					//Kick
					if ((player.isTaur() || player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.KIRIN || player.lowerBody == LowerBody.BUNNY || player.lowerBody == LowerBody.KANGAROO)) {
						bd = buttons.add("Kick", kick).hint("Attempt to kick an enemy using your powerful lower body.");
						if (player.hasStatusEffect(StatusEffects.CooldownKick)) {
							bd.disable("<b>You need more time before you can perform Kick again.</b>\n\n");
						} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					//Pounce
					if (player.canPounce() && !monster.hasPerk(PerkLib.EnemyGroupType) && !monster.hasPerk(PerkLib.EnemyLargeGroupType)) {
						bd = buttons.add("Pounce", catPounce).hint("Pounce and rend your enemy using your claws, this initiate a grapple combo.");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					//Crunch
					if (player.racialScore(Races.ARIGEAN) >= 16) {
						bd = buttons.add("Crunch", arigeanCrunch).hint("Deals Physical Damage based on Strength, also lowers opponent's physical defense by 30% for 3 turns.");
						bd.requireFatigue(physicalCost(100));
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					//Ram
					if (player.tailType == Tail.ARIGEAN_PRINCESS) {
						bd = buttons.add("Ram", arigeanRam).hint("A physical attack that scales off of speed, does recoil damage to the user (10% of max HP).");
						bd.requireFatigue(physicalCost(100));
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
				}
				//Grab & Slam
				if (player.isRaceCached(Races.BEARANDPANDA) && !monster.hasPerk(PerkLib.EnemyGroupType) && !monster.hasPerk(PerkLib.EnemyLargeGroupType)) {
					bd = buttons.add("Grab", bearGrab).hint("Attempt to grab the opponent in your powerful paws. Does not work on opponent taller than you.");
					if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					bd = buttons.add("Slam", bearSlam).hint("Furiously slam your target with your powerful paw, staggering and stunning it.");
					if (player.hasStatusEffect(StatusEffects.CooldownSlamBear)) {
						bd.disable("<b>You need more time before you can perform Slam again.</b>\n\n");
					} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				//Kiss supercedes bite.
				if (player.hasStatusEffect(StatusEffects.LustStickApplied)) {
					bd = buttons.add("Kiss", kissAttack).hint("Attempt to kiss your foe on the lips with drugged lipstick.  It has no effect on those without a penis.");
					if(player.playerIsBlinded()) {
						bd.disable("There's no way you'd be able to find their lips while you're blind!");
					} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (player.arms.type == Arms.MANTIS && player.weapon.isNothing && !player.hasPerk(PerkLib.ElementalBody)) {
					bd = buttons.add("Multi Slash", mantisMultiSlash);
					if (player.hasPerk(PerkLib.PhantomStrike)) {
						if (monster.plural) {
							bd.hint("Attempt to slash your foes with your wrists scythes! \n");
							if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 2) bd.requireFatigue(100);
							else bd.requireFatigue(120);
						} else {
							bd.hint("Attempt to slash your foe with your wrists scythes! \n");
							if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 2) bd.requireFatigue(40);
							else bd.requireFatigue(48);
						}
					}
					else {
						if (monster.plural) {
							bd.hint("Attempt to slash your foes with your wrists scythes! \n");
							if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 2) bd.requireFatigue(50);
							else bd.requireFatigue(60);
						} else {
							bd.hint("Attempt to slash your foe with your wrists scythes! \n");
							if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 2) bd.requireFatigue(20);
							else bd.requireFatigue(24);
						}
					}
					if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if ((player.tail.isAny(Tail.BEE_ABDOMEN, Tail.SCORPION) || player.isSandWorm()) && !player.hasPerk(PerkLib.ElementalBody)) {
					bd = buttons.add("Sting", playerStinger);
					var stingername:String,period:String;
					if (player.tailType == Tail.BEE_ABDOMEN) {
						stingername = "venomous bee stinger";
						period = "your abdomen's refractory period";
					} else if (player.tailType == Tail.SCORPION) {
						stingername = "venomous scorpion stinger";
						period = "your refractory period";
					} else if (player.isSandWorm()) {
						stingername = "venomous sandworm stinger";
						period = "your refractory period";
					}
					bd.hint("Attempt to use your " + stingername + " on an enemy.  Be aware it takes quite a while for your venom to build up, so depending on " + period + ", you may have to wait quite a while between stings.  \n\nVenom: " + player.tailVenom + "/" + player.maxVenom());
					if (player.tailVenom < player.VenomWebCost() * 5) {
						bd.disable("You do not have enough venom to sting right now! (Req. "+player.VenomWebCost()*5+"+)");
					} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (player.tail.isAny(Tail.SHARK, Tail.LIZARD, Tail.KANGAROO, Tail.DRACONIC, Tail.RACCOON, Tail.RED_PANDA) && !player.hasPerk(PerkLib.ElementalBody)) {
					bd = buttons.add("Tail Whip", tailWhipAttack).hint("Whip your foe with your tail to enrage them and lower their defense!");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				if ((player.tailType == Tail.SALAMANDER || player.tailType == Tail.KITSHOO) && !player.hasPerk(PerkLib.ElementalBody)) {
					var kitshoo1:String = "";
					var kitshoo2:String = "it";
					if (player.tailType == Tail.KITSHOO && player.tailCount > 1) {
						kitshoo1 = "s";
						kitshoo2 = "them";
					}
					bd = buttons.add("Tail Slap", tailSlapAttack).hint("Set ablaze in red-hot flames your tail"+kitshoo1+" to whip your foe with "+kitshoo2+" to hurt and burn them!  \n\n<b>AoE attack.</b>");
					if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(80));
					else bd.requireFatigue(physicalCost(40));
					if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (player.tailType == Tail.ORCA && !player.hasPerk(PerkLib.ElementalBody)) {
					bd = buttons.add("Tail Smack", tailSmackAttack).hint("Smack your powerful tail at your opponent face.</b>");
					bd.requireFatigue(physicalCost(40));
					if (player.hasStatusEffect(StatusEffects.CooldownTailSmack)) {
						bd.disable("<b>You need more time before you can perform Tail Smack again.</b>\n\n");
					} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if ((player.isRaceCached(Races.PIG) || player.perkv1(IMutationsLib.PigBoarFatIM) >= 3) && player.thickness >= minThicknessReq()) {
					bd = buttons.add("Body Slam", bodySlam).hint("Body slam your opponent (small chance to stun). Damage scale with toughness and thickness.");
					bd.requireFatigue(physicalCost(50));
					if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (player.isShieldsForShieldBash()) {
					bd = buttons.add("Shield Bash", shieldBash).hint("Bash your opponent with a shield. Has a chance to stun. Bypasses stun immunity. \n\nThe more you stun your opponent, the harder it is to stun them again.");
					bd.requireWrath(shieldbashcostly());
					if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				//ELF ARCHERY
				if (player.weaponRangePerk == "Bow" && WoodElves.WoodElfBowTraining >= 1) {
					bd = buttons.add("Pin Down", ELFarcheryPinDown).hint("Shoot for your opponent legs dealing damage and incapacitating them. (cooldown of 5 rounds before it can be used again)");
					if (player.hasStatusEffect(StatusEffects.CooldownPinDown)) bd.disable("<b>You need more time before you can do it again.</b>\n\n");
					else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (player.weaponRangePerk == "Bow" && WoodElves.WoodElfBowTraining >= 2) {
					bd = buttons.add("Elven Eye", ELFarcheryElvenEye).hint("Elven ability, focus your aim to increase critical chances and greatly raise archery critical damage with bows for 8 rounds.");
					if (player.hasStatusEffect(StatusEffects.ElvenEye)) bd.disable("<b>You are already focusing your aim.</b>\n\n");
					else if (player.eyes.type != Eyes.ELF) bd.disable("<b>You would need an elf vision in order to use this ability.</b>\n\n");
				}
				//KINDRA ARCHERY
				if (player.weaponRangePerk == "Bow" && player.hasStatusEffect(StatusEffects.KnowsSidewinder)) {
					bd = buttons.add("Sidewinder", archerSidewinder).hint("The pinacle art of the hunter. Once per day draw on your fatigue to shoot a single heavily infused arrow at a beast or animal morph. This attack never miss.");
					if (player.hasStatusEffect(StatusEffects.CooldownSideWinder)) bd.disable("<b>You already used Sidewinder today.</b>\n\n");
					else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (monster.plural) {
					// Whipping
					if (player.isWeaponsForWhipping()) {
						bd = buttons.add("Whipping", whipping).hint("Attack multiple opponent with your held weapon.  \n\n<b>AoE attack.</b>");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					// Whirlwind
					if ((player.isWeaponForWhirlwind() && !player.hasPerk(PerkLib.PowerSweep)) || ((player.isWeaponForWhirlwind() || player.isOneHandedWeapons()) && player.hasPerk(PerkLib.PowerSweep))) {
						bd = buttons.add("Whirlwind", whirlwind).hint("Spin your weapon around to attack multiple enemies at once.  \n\n<b>AoE attack.</b>");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
					// Whirlwind (Beast Warrior)
					if (player.hasPerk(PerkLib.JobBeastWarrior) && ((player.weaponName == "fists" && player.haveNaturalClaws()) || player.haveNaturalClawsTypeWeapon())) {
						bd = buttons.add("F. Whirlwind", whirlwindClaws).hint("Spin yourself around to slash multiple enemies with your claws at once.  \n\n<b>AoE attack.</b>");
						if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					}
				}
				if (player.isAlraune() && !player.hasPerk(PerkLib.ElementalBody)) {
					// Entangle
					bd = buttons.add("Entangle", AlrauneEntangle).hint("Use your vines to hinder your opponent.");
					if (player.hasStatusEffect(StatusEffects.AlrauneEntangle)) bd.disable("<b>You already entangle your opponent.</b>\n\n");
					else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (player.hasStatusEffect(StatusEffects.AlrauneEntangle) && !player.hasPerk(PerkLib.ElementalBody)) {
					bd = buttons.add("Strangulate", AlrauneStrangulate).hint("Strangle your opponent with your vines.");
					bd.requireFatigue(physicalCost(60));
					if (monster.tallness > 120 || monster.hasPerk(PerkLib.EnemyHugeType)) bd.disable("<b>Your opponent is too tall for Strangulate to have any effect on it.</b>\n\n");
					else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (player.arms.type == Arms.GARGOYLE && !player.hasPerk(PerkLib.ElementalBody)) {
					bd = buttons.add("Stone Claw", StoneClawAttack).hint("Rend your foe using your sharp stone claws.  \n\nWould go into cooldown after use for: "+(player.hasPerk(PerkLib.NaturalInstincts) ? "2":"3")+" rounds");
					if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(120));
					else bd.requireFatigue(physicalCost(60));
					if (player.hasStatusEffect(StatusEffects.CooldownStoneClaw)) {
						bd.disable("<b>You need more time before you can perform Stone Claw again.</b>\n\n");
					} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (player.arms.type == Arms.GARGOYLE_2 && !player.hasPerk(PerkLib.ElementalBody)) {
					bd = buttons.add("Stone Fist", StoneFistAttack).hint("Slam your two fist at your foe and attempt to stun them.  \n\nWould go into cooldown after use for: "+(player.hasPerk(PerkLib.NaturalInstincts) ? "2":"3")+" rounds");
					if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(120));
					else bd.requireFatigue(physicalCost(60));
					if (player.hasStatusEffect(StatusEffects.CooldownStoneFist)) {
						bd.disable("<b>You need more time before you can perform Stone Fist again.</b>\n\n");
					} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (player.tailType == Tail.GARGOYLE && !player.hasPerk(PerkLib.ElementalBody)) {
					bd = buttons.add("Tail Slam", TailSlamAttack).hint("Slam your mace-like tail on your foe's head, dealing severe damage, crushing its defences, and stunning it.  \n\nWould go into cooldown after use for: "+(player.hasPerk(PerkLib.NaturalInstincts) ? "4":"5")+" rounds");
					if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(60));
					else bd.requireFatigue(physicalCost(30));
					if (player.hasStatusEffect(StatusEffects.CooldownTailSlam)) {
						bd.disable("<b>You need more time before you can perform Tail Slam again.</b>\n\n");
					} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (player.tailType == Tail.GARGOYLE_2 && !player.hasPerk(PerkLib.ElementalBody)) {
					bd = buttons.add("Tail Cleave", TailCleaveAttack).hint("Swipe your axe-bladed tail, cleaving through multiple opponents and dealing severe bleeding damage.  \n\nWould go into cooldown after use for: "+(player.hasPerk(PerkLib.NaturalInstincts) ? "4":"5")+" rounds");
					if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(60));
					else bd.requireFatigue(physicalCost(30));
					if (player.hasStatusEffect(StatusEffects.CooldownTailCleave)) {
						bd.disable("<b>You need more time before you can perform Tail Cleave again.</b>\n\n");
					} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (player.wings.type == Wings.GARGOYLE_LIKE_LARGE && !player.hasPerk(PerkLib.ElementalBody)) {
					bd = buttons.add("Wing Buffet", WingBuffetAttack).hint("Buffet your foe using your two massive wings, staggering them.  \n\nWould go into cooldown after use for: "+(player.hasPerk(PerkLib.NaturalInstincts) ? "5":"6")+" rounds");
					if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(60));
					else bd.requireFatigue(physicalCost(30));
					if (player.hasStatusEffect(StatusEffects.CooldownWingBuffet)) {
						bd.disable("<b>You need more time before you can perform Wing Buffet again.</b>\n\n");
					} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if ((player.isRaceCached(Races.ORCA) || player.isRaceCached(Races.SEA_DRAGON)) && player.faceType == Face.ORCA) {
					bd = buttons.add("Play", orcaPlay).hint("Begin toying with your prey by tossing it in the air, initiating a juggling combo.");
					bd.requireFatigue(physicalCost(30));
					if (!monster.hasStatusEffect(StatusEffects.Stunned)) bd.disable("<b>You need the ennemy to be stunned in order to use this ability.</b>\n\n");
					else if (player.tallness < monster.tallness) bd.disable("<b>You need the ennemy to be smaller then you in order to use this ability.</b>\n\n");
					else if (player.hasStatusEffect(StatusEffects.CooldownPlay)) bd.disable("<b>You need more time before you can use Play again.</b>\n\n");
					else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
			}
			if (player.hasPerk(PerkLib.PowerShot)) {
				bd = buttons.add("Power Shoot", powerShoot).hint("Do a single way more powerfull wrath-enhanced range strike.");
				if (player.wrath100 < 1) bd.disable("You're too low on wrath to use Power Shot (below 1%)");
				else if (player.weaponRangePerk != "Bow" && player.weaponRangePerk != "Crossbow" && player.weaponRangePerk != "Throwing") {
					bd.disable("<b>You need to use bow, crossbow or throwing weapon before you can use Power Shoot.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if ((player.hasPerk(PerkLib.MarkedForDeath) && player.haveWeaponForSneakAttackRange() && (monster.monsterIsStunned()
				|| monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind) || monster.hasStatusEffect(StatusEffects.Distracted)))||
					(player.hasStatusEffect(StatusEffects.EverywhereAndNowhere) && player.haveWeaponForSneakAttackRange())) {
				bd = buttons.add("SneakAttack (R)", sneakAttackRange).hint("Strike the vitals of a stunned, blinded or distracted opponent for heavy damage. (Range variant)");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasPerk(PerkLib.Feint)) {
				bd = buttons.add("Feint", feint).hint("Attempt to feint an opponent into dropping its guard.");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasPerk(PerkLib.ChallengingShout)) {
				bd = buttons.add("Warrior Shout", warriorShout).hint("Embolden yourself with a mighty shout. Generate 20% of max/overmax wrath on use as a free action.\nWould go into cooldown after use for: 10 rounds");//"+(player.hasPerk(PerkLib.NaturalInstincts) ? "1":"2")+"
				if (player.hasStatusEffect(StatusEffects.CooldownWarriorShout)) {
					bd.disable("<b>You need more time before you can perform Warrior Shout again.</b>\n\n");
				}
			}
			if (!player.hasPerk(PerkLib.ElementalBody)) {
				//Dig
				if (InCollection(player.lowerBody, LowerBody.CANCER, LowerBody.CENTIPEDE, LowerBody.FROSTWYRM, LowerBody.SANDWORM) && !player.isFlying()) {
					bd = buttons.add("Dig", Dig).hint("Dig underground to escape your opponent attack for a while.");
					if (player.hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) {
						bd.disable("<b>You can't dig in open water!</b>\n\n");
					}
				}
			}
			//Drink
			if (player.countMiscJewelry(miscjewelries.ONI_GOURD) > 0) {
				bd = buttons.add("Drink", Drink).hint("Drink down some sake from your drinking jug. \n\nSpecial: May have additionnal effects on an oni.");
			}
			//Whip Grapple
			if (player.hasPerk(PerkLib.PrestigeJobBindmaster) && (player.isWeaponsForWhipping() || player.weapon == weapons.D_FLAIL)) {
				bd = buttons.add("Grapple(W)", whipGrapple).hint("Attempt to grapple a foe with your "+(player.weapon == weapons.D_FLAIL?"flail":"whip")+".");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				else if (monster.plural) bd.disable("You cannot grapple more than one foe at once.");
			}
			//Infest if infested
			if (player.hasStatusEffect(StatusEffects.Infested) && player.statusEffectv1(StatusEffects.Infested) == 5 && player.hasCock()) {
				bd = buttons.add("Infest", SceneLib.mountain.wormsScene.playerInfest).hint("The infest attack allows you to cum at will, launching a stream of semen and worms at your opponent in order to infest them.  Unless your foe is very aroused they are likely to simply avoid it.  Only works on males or herms. \n\nAlso great for reducing your lust.");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.tailType == Tail.MANTICORE_PUSSYTAIL && !player.hasPerk(PerkLib.ElementalBody)) {
				bd = buttons.add("Tail Spike", playerTailSpike).hint("Shoot an envenomed spike at your opponent dealing minor physical damage, slowing its movement speed and inflicting serious lust damage.  \n\nVenom: " + player.tailVenom + "/" + player.maxVenom());
				if (player.tailVenom < player.VenomWebCost() * 5) {
					bd.disable("You do not have enough venom to shoot a spike right now! (Req. "+player.VenomWebCost()*5+"+)");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				if (player.perkv1(IMutationsLib.ManticoreMetabolismIM) >= 1) {
					bd = buttons.add("Omni Tail Spike", playerOmniTailSpike).hint("Shoot a volley of envenomed spikes at your opponent dealing minor physical damage, slowing its movement speed and inflicting serious lust damage.  \n\nVenom: " + player.tailVenom + "/" + player.maxVenom());
					if (player.tailVenom < player.VenomWebCost() * 10 && player.perkv1(IMutationsLib.ManticoreMetabolismIM) >= 1) {
						bd.disable("You do not have enough venom to shoot multiple spikes right now! (Req. "+player.VenomWebCost()*10+"+)");
					} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
			}
			if (player.tailType == Tail.SPIDER_ADBOMEN && !player.hasPerk(PerkLib.ElementalBody)) {
				bd = buttons.add("Web", PCWebAttack).hint("Attempt to use your abdomen to spray sticky webs at an enemy and greatly slow them down.  Be aware it takes a while for your webbing to build up.  \n\nWeb Amount: " + player.tailVenom + "/" + player.maxVenom());
				if (player.tailVenom < player.VenomWebCost() * 5) {
					bd.disable("You do not have enough webbing to shoot right now! (Req. "+player.VenomWebCost()*5+"+)");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasPerk(PerkLib.InkSpray) && player.gender > 0 && !player.hasPerk(PerkLib.ElementalBody)) {
				var liftWhat:String = player.gender == 1 ? "your cock" : "your front tentacle";
				var liftWha2:String = player.gender == 1 ? "Lift your cock and s" : "S";
				var cooldown:Number = 8;
				if (player.perkv1(IMutationsLib.ScyllaInkGlandsIM) >= 1) cooldown -= 4;
				if (player.hasPerk(PerkLib.NaturalInstincts)) cooldown -= 1;
				bd = buttons.add("Ink Spray", inkSpray);
				bd.requireFatigue(physicalCost(30));
				if (player.isScylla()) bd.hint("Lift " + liftWhat + " and spray ink to the face of your foe surprising, arousing and blinding them (cooldown of " + cooldown + " rounds before it can be used again)");
				else bd.hint("" + liftWha2 + "pray ink to the face of your foe surprising, arousing and blinding them (cooldown of " + cooldown + " rounds before it can be used again)");
				if (monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind)) {
					bd.disable("<b>[Themonster] is already affected by blind.</b>\n\n");
				} else if (player.hasStatusEffect(StatusEffects.CooldownInkSpray)) {
					bd.disable("<b>You need more time before you can shoot ink again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasVagina() && (player.isRaceCached(Races.COW) || player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 1 || (player.perkv1(IMutationsLib.HumanOvariesIM) >= 3 && player.racialScore(Races.HUMAN) > 17)) && !player.hasPerk(PerkLib.ElementalBody)) {
				var blaaaast2:String = player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 3 ? " (cooldown of "+(player.hasPerk(PerkLib.NaturalInstincts) ? "3":"4")+" rounds before it can be used again)" : "";
				bd = buttons.add("Milk Blast", milkBlast).hint("Blast your opponent with a powerful stream of milk, arousing and damaging them. The power of the jet is related to arousal, libido and production." + blaaaast2 + "\n");
				if (player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 3) bd.requireLust(200);
				else bd.requireLust(100);
				if (player.hasStatusEffect(StatusEffects.CooldownMilkBlast)) {
					if (player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 3) bd.disable("\n<b>You need more time before you can do it again.</b>");
					else bd.disable("You can't use it more than once during fight.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasCock() && (player.isRaceCached(Races.COW) || player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 1 || (player.perkv1(IMutationsLib.HumanTesticlesIM) >= 3 && player.racialScore(Races.HUMAN) > 17)) && !player.hasPerk(PerkLib.ElementalBody)) {
				var blaaaast1:String = player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 3 ? " (cooldown of "+(player.hasPerk(PerkLib.NaturalInstincts) ? "3":"4")+" rounds before it can be used again)" : "";
				bd = buttons.add("Cum Cannon", cumCannon).hint("Blast your opponent with a powerful stream of cum, arousing and damaging them. The power of the jet is related to arousal, libido and production. " + blaaaast1 + "\n");
				if (player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 3) bd.requireLust(200);
				else bd.requireLust(100);
				if (player.hasStatusEffect(StatusEffects.CooldownCumCannon)) {
					if (player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 3) bd.disable("\n<b>You need more time before you can do it again.</b>");
					else bd.disable("You can't use it more than once during fight.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.isRaceCached(Races.SLIME) || player.isRaceCached(Races.MAGMASLIME) || player.isRaceCached(Races.DARKSLIME)) {
				bd = buttons.add("Sling Goo", slinggoo).hint("Throw slime at your opponent, lacing it with your aphrodisiac compound and reduce their speed.");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.isAnyRaceCached([Races.DOG, Races.CERBERUS])) {
				bd = buttons.add("Terr. Howl", terrifyingHowl).hint("Release a powerful howl, dazing your opponent for 1 round.\n4 round cooldown.", "Terrifying Howl");
				bd.requireFatigue(physicalCost(40));
				if(player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
					bd.disable("You cannot fhowl while you're having so much difficult breathing.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.canFly() && !player.hasPerk(PerkLib.ElementalBody)) {
				bd = buttons.add("Take Flight", takeFlight).hint("Make use of your wings to take flight into the air for up to " + combat.flightDurationNatural() + " turns. \n\nGives bonus to evasion, speed but also giving penalties to accuracy of range attacks or spells. Not to meantion for non spear users to attack in melee range.");
			}
			if (player.shieldName == "Battle Net") {
				bd = buttons.add("Entangle", netEntangle).hint("Toss your net at the enemy to entangle it. (cooldown of 5 rounds before it can be used again)");
				if (player.hasStatusEffect(StatusEffects.CooldownNet)) bd.disable("<b>You need more time before you can do it again.</b>\n\n");
				else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			// Barrage
			if (player.weaponRangePerk == "Bow" && player.hasStatusEffect(StatusEffects.KnowsBarrage) && monster.plural) {
				bd = buttons.add("Barrage", archerBarrage).hint("Draw multiple arrow and shoot them all at the same time to hit several target.  \n\n<b>AoE attack.</b>");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if ((player.isAlraune() || player.perkv1(IMutationsLib.FloralOvariesIM) >= 1) && !player.hasPerk(PerkLib.ElementalBody)) {
				// Pollen
				bd = buttons.add("AlraunePollen", AlraunePollen).hint("Release a cloud of your pollen in the air to arouse your foe.");
				if (player.hasStatusEffect(StatusEffects.AlraunePollen)) bd.disable("<b>You already spread your pollen over battlefield.</b>\n\n");
			}
			if (player.hasKeyItem("Rocket Boots") >= 0 || player.hasKeyItem("Nitro Boots") >= 0) {
				if (player.hasKeyItem("Nitro Boots") >= 0) bd = buttons.add("Blazing rocket kick", blazingRocketKick).hint("Deal fire damage using your boots. Also burns.");
				else {
					bd = buttons.add("Rocket kick", blazingRocketKick).hint("Deal fire damage using your boots.");
					if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
			}
			if (player.hasPerk(PerkLib.EasterBunnyBalls) && !player.hasPerk(PerkLib.ElementalBody)) {
				if (!player.perkv1(IMutationsLib.EasterBunnyEggBagIM) >= 1 || (player.perkv1(IMutationsLib.EasterBunnyEggBagIM) >= 1 && flags[kFLAGS.EASTER_BUNNY_EGGS_STORED] == 1)) {
					bd = buttons.add("Egg throw", EggthrowAttack).hint("Throw one of your many stashed bunny eggs blinding and arousing the opponent. These attacks benefit from skills that improve thrown weapons \n\n"+flags[kFLAGS.EASTER_BUNNY_EGGS_STORED]+" egg remaining.");
					bd.requireFatigue(physicalCost(30));
					if (flags[kFLAGS.EASTER_BUNNY_EGGS_STORED] == 0) {
						bd.disable("<b>You need eggs to use this ability.</b>\n\n");
					} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
				}
				if (player.perkv1(IMutationsLib.EasterBunnyEggBagIM) >= 1 && flags[kFLAGS.EASTER_BUNNY_EGGS_STORED] > 1) {
					bd = buttons.add("Omni Egg throw", OmniEggthrowAttack).hint("Throw one or more of your many stashed bunny eggs blinding and arousing the opponent. These attacks benefit from skills that improve thrown weapons. \n\n"+flags[kFLAGS.EASTER_BUNNY_EGGS_STORED]+" egg remaining.");
					bd.requireFatigue(physicalCost(30));
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)) {
				bd = buttons.add("Buzzing tune", buzzingTone).hint("Sing a buzzing hypnotic tune in battle, causing the opponent to be stunned for 6 rounds with massive lust damage. This move takes 2 rounds of preparation during which pc must do nothing but sing.");
				bd.requireFatigue(spellCost(50));
			}
			if (player.hasStatusEffect(StatusEffects.FieryBand)) {
				bd = buttons.add("Call Kiha", callKiha).hint("Call out to Kiha using the Starfire band.");
				bd.requireFatigue(physicalCost(30));
			}
		}
		if (player.isInGoblinMech()) {
			if (player.hasKeyItem("Dynapunch Glove") >= 0 && player.vehicles != vehicles.GS_MECH) {
				bd = buttons.add("Dynapunch G.", mechDynapunchGlove).hint("Shoot a springed gloved fist at the opponent with a rocket punch stunning for one round and dealing damage. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownDynapunchGlove)) {
					bd.disable("<b>You need more time before you can use Dynapunch Glove again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Taser") >= 0 && player.vehicles != vehicles.GS_MECH) {
				if (player.hasKeyItem("Taser with an overcharged battery") >= 0) bd = buttons.add("Tazer", mechTazer).hint("A voltage rod set on the mech as an upgrade can be used to temporarily paralyse the opponent. Deals some lesser lightning damage and stun for 4 rounds. \n\nWould go into cooldown after use for: 8 rounds");
				else bd = buttons.add("Tazer", mechTazer).hint("A voltage rod set on the mech as an upgrade can be used to temporarily paralyse the opponent. Deals no damage and stun for 2 rounds. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownTazer)) {
					bd.disable("<b>You need more time before you can use Tazer again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Missile launcher") >= 0) {
				bd = buttons.add("Missile launcher", mechOmniMissile).hint("Fire missile that will cover a wide area of effect.");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Omni Missile") >= 0) {
				bd = buttons.add("Omni Missile", mechOmniMissile).hint("Fire omni missiles that will cover a wide area of effect.");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Whitefire Beam Cannon") >= 0) {
				bd = buttons.add("Whitefire B.C.", mechWhitefireBeamCannon).hint("Shoot with the whitefire beam cannon at enemy burning him. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownWhitefireBeamCannon)) {
					bd.disable("<b>You need more time before you can use Whitefire Beam Cannon again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Snowball Generator") >= 0) {
				bd = buttons.add("Snowball G.", mechSnowballGenerator).hint("Activate the snowball generator taking aim and launching a volley of snowballs at the enemy. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownSnowballGenerator)) {
					bd.disable("<b>You need more time before you can use Snowball Generator again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Raijin blaster") >= 0) {
				bd = buttons.add("Raijin Blaster", mechRaijinBlaster).hint("Activate the raijin blaster taking aim and zapping enemy. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownRaijinBlaster)) {
					bd.disable("<b>You need more time before you can use Raijin Blaster again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Gravity shots") >= 0) {
				bd = buttons.add("Gravity Shots", mechGravityShots).hint("Activate the gravity shots unleashing the gravity sphere at the enemy. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownGravityShots)) {
					bd.disable("<b>You need more time before you can use Gravity Shots again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Stimpack Dispenser 1.0") >= 0 || player.hasKeyItem("Medical Dispenser 2.0") >= 0) {
				if (player.hasKeyItem("Medical Dispenser 2.0") >= 0) bd = buttons.add("Medical Dispenser 2.0", mechStimpackMedicalDispenser).hint("Activate to gain swift improved medical treatment. Be wary of secondary effects. \n\nWould go into cooldown after use for: 15 rounds");
				else bd = buttons.add("Stimpack Dispenser 1.0", mechStimpackMedicalDispenser).hint("Activate to gain swift medical treatment. Be wary of secondary effects. \n\nWould go into cooldown after use for: 20 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownStimpackDispenser)) {
					bd.disable("<b>You need more time before you can use "+(player.hasKeyItem("Medical Dispenser 2.0") >= 0 ? "Medical Dispenser":"Stimpack Dispenser")+" again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Jetpack") >= 0 || player.hasKeyItem("MK2 Jetpack") >= 0) {
				bd = buttons.add("Jetpack", takeFlightGoglinMech).hint("Make use of your mech jetpack to take flight into the air for up to 5 turns. \n\nWould go into cooldown after use for: 3 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownJetpack)) {
					bd.disable("<b>You need more time before you can use jetpack again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
		}
		if (player.vehicles == vehicles.HB_MECH) {
			if (player.hasKeyItem("HB Stealth System") >= 0) {
				if (player.keyItemvX("HB Stealth System", 1) >= 1) bd = buttons.add("Invisibility", StealthModeActivate).hint("Turn your mech invisible. \n\nWould drain "+combat.StealthModeMechCost()+" SF from mech reserves or your own SF pool per turn.");// Will not use combat action.
				else bd = buttons.add("Camouflage", StealthModeActivate).hint("Turn your mech invisible for 1 turn. \n\nWould drain "+combat.StealthModeMechCost()+" SF from mech reserves or your own SF pool.");
				if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] < combat.StealthModeMechCost() && player.soulforce < combat.StealthModeMechCost()) bd.disable("<b>You are too low on SF reserves to use this option.</b>\n\n");
				if (monster.hasStatusEffect(StatusEffects.InvisibleOrStealth) || monster.monsterIsStunned()
					|| monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind) || monster.hasStatusEffect(StatusEffects.Distracted)) {
					bd = buttons.add("SneakAttack (M)", sneakAttackMech).hint("Strike the vitals of a stunned, blinded or distracted opponent for heavy damage. (Melee variant)");
					if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					else if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] < 100 && player.soulforce < 100) bd.disable("<b>You are too low on SF reserves to use this option.</b>");
				}
				if (monster.hasStatusEffect(StatusEffects.InvisibleOrStealth) || monster.monsterIsStunned()
					|| monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind) || monster.hasStatusEffect(StatusEffects.Distracted)) {
					bd = buttons.add("SneakAttack (R)", sneakAttackRangeMech).hint("Strike the vitals of a stunned, blinded or distracted opponent for heavy damage. (Range variant)");
					if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
					else if (!player.isUsingHowlingBansheeMechFriendlyRangeWeapons()) bd.disable("Your range weapon is not compatibile to be used in this special attack.");
					else if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] < 100 && player.soulforce < 100) bd.disable("<b>You are too low on SF reserves to use this option.</b>");
				}
				if (player.keyItemvX("HB Stealth System", 1) >= 1 && monster.hasStatusEffect(StatusEffects.InvisibleOrStealth)) bd = buttons.add("Visibility", StealthModeDeactivate).hint("Turn your mech visible.");// Will not use combat action.
			}
			if (player.hasKeyItem("HB Dragon's Breath Flamer") >= 0) {
				var HBDBFC:Number = 100;
				if (player.keyItemvX("HB Dragon's Breath Flamer", 2) == 2) HBDBFC *= 2;
				bd = buttons.add("DB Flamer", mechWhitefireBeamCannon).hint("Shoot with Dragon's Breath Flamer at enemy burning him. \n\nWould drain "+HBDBFC+" SF from mech reserves or your own SF pool.");
				if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] < HBDBFC && player.soulforce < HBDBFC) bd.disable("<b>You are too low on SF reserves to use this option.</b>\n\n");
				else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("HB Scatter Laser") >= 0) {
				var LazorC:Number = 100;
				if (player.keyItemvX("HB Scatter Laser", 2) > 1) {
					if (player.keyItemvX("HB Scatter Laser", 2) == 3) {
						if (monster.plural) LazorC += 500;
						else LazorC += 300;
					}
					else {
						if (monster.plural) LazorC += 200;
						else LazorC += 100;
					}
				}
				bd = buttons.add("Scatter Laser", mechScatterLaser).hint("Shoot with Scatter Laser"+((player.keyItemvX("HB Scatter Laser", 2) > 1)?"s":"")+" at enemy. \n\nWould drain "+LazorC+" SF from mech reserves or your own SF pool.");
				if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] < LazorC && player.soulforce < LazorC) bd.disable("<b>You are too low on SF reserves to use this option.</b>\n\n");
				else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
		}
	}
	internal function buildMenuForFlying(buttons:ButtonDataList):void {
		var bd:ButtonData;
		var isEnemyInvisible:Boolean = combat.isEnemyInvisible;
		if (!player.isInGoblinMech() && !player.isInNonGoblinMech()) {
			bd = buttons.add("Great Dive", combat.greatDive).hint("Make a Great Dive to deal TONS of damage!");
			if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			if (player.isRaceCached(Races.FAIRY, 2) || player.isRaceCached(Races.FAERIEDRAGON)) bd.disable("You cannot use Great Dive due to been too small.");
			//Embrace
			if ((player.arms.type == Arms.BAT || player.wings.type == Wings.VAMPIRE) && !monster.hasPerk(PerkLib.EnemyGroupType) && !monster.hasPerk(PerkLib.EnemyLargeGroupType)) {
				bd = buttons.add("Embrace", vampireEmbrace).hint("Embrace an opponent in your wings.");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			//Sky Pounce
			if (player.canPounce() && !monster.hasPerk(PerkLib.EnemyGroupType) && !monster.hasPerk(PerkLib.EnemyLargeGroupType)) {
				bd = buttons.add("Skyrend", skyPounce).hint("Land into your enemy dealing damage and initiate a grapple combo. End flight.");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			//Tornado Strike
			if (player.isRaceCached(Races.COUATL)) {
				bd = buttons.add("Tornado Strike", TornadoStrike).hint("Use wind to forcefully lift a foe in the air and deal damage.  \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(120));
				else bd.requireFatigue(physicalCost(60));
				if (player.hasStatusEffect(StatusEffects.CooldownTornadoStrike)) {
					bd.disable("<b>You need more time before you can perform Tornado Strike again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			//Wing Slap
			if (player.haveWingsForWingSlap()) {
				bd = buttons.add("Wing Slap", wingSlapAttack).hint("Slap enemy with your wings.");
				if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(80));
				else bd.requireFatigue(physicalCost(40));
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			//Pixie Dust
			if (player.isRaceCached(Races.FAIRY) || player.isRaceCached(Races.FAERIEDRAGON)) {
				bd = buttons.add("Pixie Dust", SceneLib.combat.mspecials.PixieDust).hint("Shower your opponent in magical dust, inflicting multiple status effects. More effective against groups.");
				bd.requireMana(spellCost(80));
			}
			if (player.hasPerk(PerkLib.PowerShot)) {
				bd = buttons.add("Power Shoot", powerShoot).hint("Do a single way more powerfull wrath-enhanced range strike.");
				if (player.wrath100 < 1) bd.disable("You're too low on wrath to use Power Shot (below 1%)");
				else if (player.weaponRangePerk != "Bow" && player.weaponRangePerk != "Crossbow" && player.weaponRangePerk != "Throwing") {
					bd.disable("<b>You need to use bow, crossbow or throwing weapon before you can use Power Shoot.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasVagina() && (player.isRaceCached(Races.COW) || player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 1 || (player.perkv1(IMutationsLib.HumanOvariesIM) >= 3 && player.racialScore(Races.HUMAN) > 17)) && !player.hasPerk(PerkLib.ElementalBody)) {
				var blaaaast2:String = player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 3 ? " (cooldown of "+(player.hasPerk(PerkLib.NaturalInstincts) ? "3":"4")+" rounds before it can be used again)" : "";
				bd = buttons.add("Milk Blast", milkBlast).hint("Blast your opponent with a powerful stream of milk, arousing and damaging them. The power of the jet is related to arousal, libido and production." + blaaaast2 + "\n");
				if (player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 3) bd.requireLust(200);
				else bd.requireLust(100);
				if (player.hasStatusEffect(StatusEffects.CooldownMilkBlast)) {
					if (player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 3) bd.disable("\n<b>You need more time before you can do it again.</b>");
					else bd.disable("You can't use it more than once during fight.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasCock() && (player.isRaceCached(Races.COW) || player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 1 || (player.perkv1(IMutationsLib.HumanTesticlesIM) >= 3 && player.racialScore(Races.HUMAN) > 17)) && !player.hasPerk(PerkLib.ElementalBody)) {
				var blaaaast1:String = player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 3 ? " (cooldown of "+(player.hasPerk(PerkLib.NaturalInstincts) ? "3":"4")+" rounds before it can be used again)" : "";
				bd = buttons.add("Cum Cannon", cumCannon).hint("Blast your opponent with a powerful stream of cum, arousing and damaging them. The power of the jet is related to arousal, libido and production. " + blaaaast1 + "\n");
				if (player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 3) bd.requireLust(200);
				else bd.requireLust(100);
				if (player.hasStatusEffect(StatusEffects.CooldownCumCannon)) {
					if (player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 3) bd.disable("\n<b>You need more time before you can do it again.</b>");
					else bd.disable("You can't use it more than once during fight.");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.isRaceCached(Races.SLIME) || player.isRaceCached(Races.MAGMASLIME) || player.isRaceCached(Races.DARKSLIME)) {
				bd = buttons.add("Sling Goo", slinggoo).hint("Throw slime at your opponent, lacing it with your aphrodisiac compound and reduce their speed.");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.shieldName == "Battle Net") {
				bd = buttons.add("Entangle", netEntangle).hint("Toss your net at the enemy to entangle it. (cooldown of 5 rounds before it can be used again)");
				if (player.hasStatusEffect(StatusEffects.CooldownNet)) bd.disable("<b>You need more time before you can do it again.</b>\n\n");
				else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			// Barrage
			if (player.weaponRangePerk == "Bow" && player.hasStatusEffect(StatusEffects.KnowsBarrage) && monster.plural) {
				bd = buttons.add("Barrage", archerBarrage).hint("Draw multiple arrow and shoot them all at the same time to hit several target.  \n\n<b>AoE attack.</b>");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			//ELF ARCHERY
			if (player.weaponRangePerk == "Bow" && WoodElves.WoodElfBowTraining >= 1) {
				bd = buttons.add("Pin Down", ELFarcheryPinDown).hint("Shoot for your opponent legs dealing damage and incapacitating them. (cooldown of 5 rounds before it can be used again)");
				if (player.hasStatusEffect(StatusEffects.CooldownPinDown)) bd.disable("<b>You need more time before you can do it again.</b>\n\n");
				else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.weaponRangePerk == "Bow" && WoodElves.WoodElfBowTraining >= 2) {
				bd = buttons.add("Elven Eye", ELFarcheryElvenEye).hint("Elven ability, focus your aim to increase critical chances and greatly raise archery critical damage with bows for 8 rounds.");
				if (player.hasStatusEffect(StatusEffects.ElvenEye)) bd.disable("<b>You are already focusing your aim.</b>\n\n");
				else if (player.eyes.type != Eyes.ELF) bd.disable("<b>You would need an elf vision in order to use this ability.</b>\n\n");
			}
			//KINDRA ARCHERY
			if (player.weaponRangePerk == "Bow" && player.hasStatusEffect(StatusEffects.KnowsSidewinder)) {
				bd = buttons.add("Sidewinder", archerSidewinder).hint("The pinacle art of the hunter. Once per day draw on your fatigue to shoot a single heavily infused arrow at a beast or animal morph. This attack never miss.");
				if (player.hasStatusEffect(StatusEffects.CooldownSideWinder)) bd.disable("<b>You already used Sidewinder today.</b>\n\n");
				else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
		}
		if (player.isInGoblinMech()) {
			if (player.hasKeyItem("Dynapunch Glove") >= 0 && player.vehicles != vehicles.GS_MECH) {
				bd = buttons.add("Dynapunch G.", mechDynapunchGlove).hint("Shoot a springed gloved fist at the opponent with a rocket punch stunning for one round and dealing damage. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownDynapunchGlove)) {
					bd.disable("<b>You need more time before you can use Dynapunch Glove again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Taser") >= 0 && player.vehicles != vehicles.GS_MECH) {
				if (player.hasKeyItem("Taser with an overcharged battery") >= 0) bd = buttons.add("Tazer", mechTazer).hint("A voltage rod set on the mech as an upgrade can be used to temporarily paralyse the opponent. Deals some lesser lightning damage and stun for 4 rounds. \n\nWould go into cooldown after use for: 8 rounds");
				else bd = buttons.add("Tazer", mechTazer).hint("A voltage rod set on the mech as an upgrade can be used to temporarily paralyse the opponent. Deals no damage and stun for 2 rounds. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownTazer)) {
					bd.disable("<b>You need more time before you can use Tazer again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Missile launcher") >= 0) {
				bd = buttons.add("Missile launcher", mechOmniMissile).hint("Fire missile that will cover a wide area of effect.");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Omni Missile") >= 0) {
				bd = buttons.add("Omni Missile", mechOmniMissile).hint("Fire omni missiles that will cover a wide area of effect.");
				if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Whitefire Beam Cannon") >= 0) {
				bd = buttons.add("Whitefire B.C.", mechWhitefireBeamCannon).hint("Shoot with the whitefire beam cannon at enemy burning him. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownWhitefireBeamCannon)) {
					bd.disable("<b>You need more time before you can use Whitefire Beam Cannon again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Snowball Generator") >= 0) {
				bd = buttons.add("Snowball G.", mechSnowballGenerator).hint("Activate the snowball generator taking aim and launching a volley of snowballs at the enemy. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownSnowballGenerator)) {
					bd.disable("<b>You need more time before you can use Snowball Generator again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Raijin blaster") >= 0) {
				bd = buttons.add("Raijin Blaster", mechRaijinBlaster).hint("Activate the raijin blaster taking aim and zapping enemy. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownRaijinBlaster)) {
					bd.disable("<b>You need more time before you can use Raijin Blaster again.</b>\n\n");
				}
			}
			if (player.hasKeyItem("Gravity shots") >= 0) {
				bd = buttons.add("Gravity Shots", mechGravityShots).hint("Activate the gravity shots unleashing the gravity sphere at the enemy. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownGravityShots)) {
					bd.disable("<b>You need more time before you can use Gravity Shots again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
			if (player.hasKeyItem("Stimpack Dispenser 1.0") >= 0 || player.hasKeyItem("Medical Dispenser 2.0") >= 0) {
				if (player.hasKeyItem("Medical Dispenser 2.0") >= 0) bd = buttons.add("Medical Dispenser 2.0", mechStimpackMedicalDispenser).hint("Activate to gain swift improved medical treatment. Be wary of secondary effects. \n\nWould go into cooldown after use for: 15 rounds");
				else bd = buttons.add("Stimpack Dispenser 1.0", mechStimpackMedicalDispenser).hint("Activate to gain swift medical treatment. Be wary of secondary effects. \n\nWould go into cooldown after use for: 20 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownStimpackDispenser)) {
					bd.disable("<b>You need more time before you can use "+(player.hasKeyItem("Medical Dispenser 2.0") >= 0 ? "Medical Dispenser":"Stimpack Dispenser")+" again.</b>\n\n");
				} else if (isEnemyInvisible) bd.disable("You cannot use offensive skills against an opponent you cannot see or target.");
			}
		}
		if (player.vehicles == vehicles.HB_MECH) {

		}
	}

	public function checkForElementalEnchantmentAndDoDamage(damage:Number, canUseFist:Boolean = true, canUseWhip:Boolean = true):void{
		if (player.weapon == weapons.L_WHIP || player.weapon == weapons.DL_WHIP || player.weapon == weapons.TIDAR) {
			damage = Math.round(damage * combat.fireDamageBoostedByDao());
			doFireDamage(damage, true, true);
			if (player.weapon == weapons.TIDAR) (player.weapon as Tidarion).afterStrike();
		}
		else if ((player.weapon == weapons.RCLAYMO || player.weapon == weapons.RDAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
			damage = Math.round(damage * combat.fireDamageBoostedByDao());
			doFireDamage(damage, true, true);
		}
		if (combat.isFireTypeWeapon()) {
			if (player.flameBladeActive()) damage += scalingBonusLibido() * 0.20;
			if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
				if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
				damage = Math.round(damage * 1.1);
			}
			damage = Math.round(damage * combat.fireDamageBoostedByDao());
			doFireDamage(damage, true, true);
		}
		else if (combat.isIceTypeWeapon()) {
			damage = Math.round(damage * combat.iceDamageBoostedByDao());
			doIceDamage(damage, true, true);
		}
		else if (combat.isLightningTypeWeapon()) {
			damage = Math.round(damage * combat.lightningDamageBoostedByDao());
			doLightningDamage(damage, true, true);
		}
		else if (combat.isDarknessTypeWeapon()) {
			damage = Math.round(damage * combat.darknessDamageBoostedByDao());
			doDarknessDamage(damage, true, true);
		}
		else if (player.weapon == weapons.MGSWORD) doMagicDamage(damage, true, true);
		else if (player.weapon == weapons.MCLAWS) doMagicDamage(damage, true, true);
		else {
			damage = Math.round(damage);
			doDamage(damage, true, true);
			if (player.weapon == weapons.DAISHO) doDamage(Math.round(damage * 0.5), true, true);
		}
	}

	private function shieldbashcostly():Number {
		var BCW:Number = 15;
		if (player.shieldPerk == "Large") BCW += 15;
		if (player.shieldPerk == "Massive") BCW += 15;
		return BCW;
	}

	public function powerAttack():void {
		clearOutput();
		if (player.canFly()) outputText("You fly by your opponent, striking with your [weapon], utilizing  your full strength in tandem with your flight momentum. ");
		else if (player.isTaur()) {
			outputText("You ");
			if (player.lowerBody == LowerBody.HOOFED) outputText("gallop");
			else outputText("run");
			outputText(" a few meter back and make a U-Turn for a powerful charge, utilizing the full strength and momentum provided by your [race] body. ");
		}
		else outputText("You lift your [weapon] with all of your strength and smash it on your foe head. ");
		var damage:Number = 0;
		var PAMulti:Number = 1;
		PAMulti += combat.PASPAS(1);
		if ((player.weapon == weapons.PRURUMI && player.spe >= 150) || player.jewelry1 == jewelries.UNDKINS || player.jewelry3 == jewelries.UNDKINS) {
			if (player.weapon == weapons.PRURUMI && player.spe >= 150) {
				PAMulti += 0.5;
				if (player.spe >= 225) PAMulti += 0.5;
				if (player.spe >= 300) PAMulti += 0.5;
			}
			if (player.jewelry1 == jewelries.UNDKINS || player.jewelry3 == jewelries.UNDKINS) {
				PAMulti += 0.5;
			}
		}
		damage += combat.meleeDamageNoLagSingle();
		if (player.calculateMultiAttacks() > 1) damage *= player.calculateMultiAttacks();
		if (player.hasPerk(PerkLib.PowerAttackEx)) {
			PAMulti += Math.round(PAMulti*0.3);
			damage *= 2;
		}
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		damage *= PAMulti;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.WeaponMastery) && player.weaponSpecials("Large") && player.str >= 100) critChance += 10;
		if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.weaponSpecials("Dual Large") && player.str >= 140) critChance += 10;
		if (player.hasPerk(PerkLib.GigantGripEx) && player.weaponSpecials("Massive")) {
			if (player.str >= 100) critChance += 10;
			if (player.str >= 140) critChance += 10;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= 1.75 + buffMultiplier;
		}
		checkForElementalEnchantmentAndDoDamage(damage);
		if (player.hasPerk(PerkLib.TwinThunder) && player.isDualWieldMelee()) checkForElementalEnchantmentAndDoDamage(damage);
		outputText(" damage. ");
		if (crit) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		var PAC:Number = 0;
		if (player.hasPerk(PerkLib.PowerAttackSu)) PAC += Math.round(player.wrath * 0.5);
		else {
			if (player.wrath > player.maxWrath()) PAC += player.maxWrath();
			else PAC += player.wrath;
		}
		EngineCore.WrathChange(-PAC);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}

	public function powerShoot():void {
		clearOutput();
		outputText("With one smooth motion you "+(player.weaponRangePerk == "Throwing"?"throw":"fire")+" your deadly projectile at one of your opponent"+(monster.plural ? "s":"")+" ");
		var damage:Number = 0;
		var PSMulti:Number = 1;
		PSMulti += combat.PASPAS(2);
		if (player.weaponRangePerk == "Bow") {
			damage += combat.rangeDamageNoLagSingle(0);
			var maxBowAttacks:int = combat.maxBowAttacks();
			if (maxBowAttacks > 1) damage *= maxBowAttacks;
		}
		if (player.weaponRangePerk == "Crossbow") {
			damage += combat.rangeDamageNoLagSingle(1);
			var maxCrossBowAttacks:int = combat.maxCrossbowAttacks();
			if (maxCrossBowAttacks > 1) damage *= maxCrossBowAttacks;
		}
		if (player.weaponRangePerk == "Throwing") {
			damage += combat.rangeDamageNoLagSingle(2);
			var maxThrowAttacks:int = combat.maxThrowingAttacks();
			if (maxThrowAttacks > 1) damage *= maxThrowAttacks;
		}
		if (player.hasPerk(PerkLib.PowerShotEx)) {
			PSMulti += Math.round(PSMulti*0.3);
			damage *= 2;
		}
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		if (player.weaponRangeName == "Wild Hunt" && player.level > monster.level) damage *= 1.2;
		if (player.weaponRangeName == "Hodr's bow" && monster.hasStatusEffect(StatusEffects.Blind)) damage *= 1.1;
		damage *= PSMulti;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) critChance += 10;
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "Bow") critChance += 10;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "Bow") buffMultiplier += 1;
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
		}
		damage = Math.round(damage);
		var ignoreDR:Boolean = (player.hasPerk(PerkLib.DeadlyAim) && (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow"));
		doDamage(damage, true, true, ignoreDR);
		//if (player.hasPerk(PerkLib.TwinThunder) && ) doDamage(damage, true, true);
		if (player.weaponRangeName == "Avelynn") {
			doDamage(damage, true, true, ignoreDR);
			doDamage(damage, true, true, ignoreDR);
		}
		outputText(" damage. ");
		if (crit) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		var PSC:Number = 0;
		if (player.hasPerk(PerkLib.PowerAttackSu)) PSC += Math.round(player.wrath * 0.5);
		else {
			if (player.wrath > player.maxWrath()) PSC += player.maxWrath();
			else PSC += player.wrath;
		}
		EngineCore.WrathChange(-PSC);
		combat.heroBaneProc(damage);
		flags[kFLAGS.ARROWS_SHOT]++;
		bowPerkUnlock();
		enemyAI();
	}

	public function pcCleave():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
			outputText("You are too tired to attack [themonster].");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(50, USEFATG_PHYSICAL);
		outputText("You go for one mighty swing of your [weapon], effectively cleaving through everyone in front of you in an horizontal arc. Your strike leaves ");
		if (!monster.hasPerk(PerkLib.EnemyGroupType) && !monster.hasPerk(PerkLib.EnemyLargeGroupType)) outputText("a ");
		outputText("deep gushing wound");
		if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) outputText("s");
		outputText(" in your ");
		if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) outputText("foes. ");
		else outputText("foe. ");
		var damage:Number = 0;
		damage += combat.meleeDamageNoLagSingle();
		if (damage < 10) damage = 10;
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		if (monster.hasPerk(PerkLib.EnemyGroupType)) damage *= 3;
		if (monster.hasPerk(PerkLib.EnemyLargeGroupType)) damage *= 5;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.WeaponMastery) && player.weaponSpecials("Large") && player.str >= 100) critChance += 10;
		if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.weaponSpecials("Dual Large") && player.str >= 140) critChance += 10;
		if (player.hasPerk(PerkLib.GigantGripEx) && player.weaponSpecials("Massive")) {
			if (player.str >= 100) critChance += 10;
			if (player.str >= 140) critChance += 10;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
		}
		damage = Math.round(damage);
		if (player.weapon == weapons.PRURUMI) {
			if (player.spe >= 150) doDamage(damage, true, true);
			combat.WrathGenerationPerHit2(5);
			if (player.spe >= 225) doDamage(damage, true, true);
			combat.WrathGenerationPerHit2(5);
			if (player.spe >= 300) doDamage(damage, true, true);
			combat.WrathGenerationPerHit2(5);
		}
		checkForElementalEnchantmentAndDoDamage(damage, false, false);
		if (crit) {
			outputText(" <b>Critical!</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.WrathGenerationPerHit2(5);
		combat.EruptingRiposte();
		if (monster.canMonsterBleed()) {
			if (monster.hasStatusEffect(StatusEffects.IzmaBleed)) {
				if (monster.statusEffectv4(StatusEffects.IzmaBleed) == 0) monster.addStatusValue(StatusEffects.IzmaBleed, 4, 1);
				monster.addStatusValue(StatusEffects.IzmaBleed, 2, 1);
			}
			else monster.createStatusEffect(StatusEffects.IzmaBleed,3,0,0,0);
		}
		enemyAI();
	}

	public function sneakAttack():void {
		clearOutput();
		if ((player.hasPerk(PerkLib.PhantomStrike) && (player.fatigue + physicalCost(40) > player.maxFatigue())) || (!player.hasPerk(PerkLib.PhantomStrike) && (player.fatigue + physicalCost(20) > player.maxFatigue()))) {
			clearOutput();
			outputText("You're too fatigued to use sneak attack!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(40, USEFATG_PHYSICAL);
		else fatigue(20, USEFATG_PHYSICAL);
		sneakAttack1();
	}
	public function sneakAttackMech():void {
		clearOutput();
		if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] >= 100) flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] -= 100;
		else player.soulforce -= 100;
		sneakAttack1();
	}
	public function sneakAttack1():void {
		outputText("You strike [themonster] vitals with your [weapon]. ");
		var damage:Number = 0;
		var SAMulti:Number = 2;
		if (player.hasPerk(PerkLib.HistoryThief) || player.hasPerk(PerkLib.PastLifeThief)) SAMulti += 1;
		if (player.weapon == weapons.ANGSTD1 || player.weapon == weapons.ANGSTD) SAMulti += 2;
		if (player.hasPerk(PerkLib.DeadlySneaker)) SAMulti += 2;
		if (player.hasPerk(PerkLib.Slayer)) SAMulti += 3;
		if (monster.hasStatusEffect(StatusEffects.InvisibleOrStealth)) SAMulti *= 2;
		damage += combat.meleeDamageNoLagSingle();
		if (damage < 10) damage = 10;
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		damage *= SAMulti;
		var crit:Boolean = false;
		var critChance:int = 5;
		var critMulti:Number = 1.75;//coś innego tu wpisać jako perk pozwalający na wyższy mnożnik krytyków
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "Bow") critChance += 10;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "Bow") buffMultiplier += 1;
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= (critMulti + buffMultiplier);
		}
		damage = Math.round(damage);
		doDamage(damage);
		outputText("<b>([font-damage]" + damage + "</font>)</b> ");
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			doDamage(damage);
			outputText("<b>([font-damage]" + damage + "</font>)</b> ");
			damage *= 2;
		}
		if (crit) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (flags[kFLAGS.ENVENOMED_MELEE_ATTACK] == 1 && (player.weaponSpecials("Small") || player.weaponSpecials("Dual Small") || player.isFeralCombat())
		){
			if (player.tailVenom >= player.VenomWebCost()) {
				outputText("  ");
				if(monster.lustVuln == 0) {
					outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
				}
				else {
					if (player.tailType == Tail.BEE_ABDOMEN) {
						outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
						var damage1B:Number = 35 + rand(player.lib / 10);
						var damage1Bc:Number = 1;
						if (player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)) damage1B += scalingBonusToughness() * 0.5;
						if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) damage1Bc *= 2;
						if (player.level < 10) damage1B += 20 + (player.level * 3);
						else if (player.level < 20) damage1B += 50 + (player.level - 10) * 2;
						else if (player.level < 30) damage1B += 70 + (player.level - 20) * 1;
						else damage1B += 80;
						damage1B *= 0.2;
						damage1B *= damage1Bc
						if (player.armor == armors.ELFDRES && player.isElf()) damage1B *= 2;
						if (player.armor == armors.FMDRESS && player.isWoodElf()) damage1B *= 2;
						monster.teased(monster.lustVuln * damage1B);
						if (monster.hasStatusEffect(StatusEffects.NagaVenom))
						{
							monster.addStatusValue(StatusEffects.NagaVenom,3,damage1Bc);
						}
						else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, damage1Bc, 0);
						if (player.hasPerk(PerkLib.WoundPoison)){
							if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
							else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
						}
						player.tailVenom -= player.VenomWebCost();
						flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
					}
					if (player.tailType == Tail.SCORPION || player.hasKeyItem("Sky Poison Pearl") >= 0) {
						outputText("  [monster he] seems to be effected by the poison, its movement turning sluggish.");
						var damage1Bcc:Number = 1;
						if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) damage1Bcc *= 2;
						monster.statStore.addBuffObject({spe:-(damage1Bcc*2)}, "Poison",{text:"Poison"});
						if (monster.hasStatusEffect(StatusEffects.NagaVenom))
						{
							monster.addStatusValue(StatusEffects.NagaVenom,3,damage1Bcc);
						}
						else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, damage1Bcc, 0);
						if (player.hasPerk(PerkLib.WoundPoison)){
							if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
							else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
						}
						player.tailVenom -= player.VenomWebCost();
						flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
					}
					if (player.tailType == Tail.MANTICORE_PUSSYTAIL) {
						outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
						var lustdamage:Number = 35 + rand(player.lib / 10);
						var damage1Bcbc:Number = 1;
						if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) damage1Bcbc *= 2;
						if (player.level < 10) damage += 20 + (player.level * 3);
						else if (player.level < 20) damage += 50 + (player.level - 10) * 2;
						else if (player.level < 30) damage += 70 + (player.level - 20) * 1;
						else damage += 80;
						lustdamage *= 0.14;
						lustdamage *= damage1Bcbc;
						if (player.armor == armors.ELFDRES && player.isElf()) lustdamage *= 2;
						if (player.armor == armors.FMDRESS && player.isWoodElf()) lustdamage *= 2;
						monster.teased(monster.lustVuln * lustdamage);
						monster.statStore.addBuffObject({tou:-(damage1Bcbc*2)}, "Poison",{text:"Poison"});
						if (monster.hasStatusEffect(StatusEffects.ManticoreVenom))
						{
							monster.addStatusValue(StatusEffects.ManticoreVenom,3,damage1Bcbc);
						}
						else monster.createStatusEffect(StatusEffects.ManticoreVenom, 0, 0, damage1Bcbc, 0);
						player.tailVenom -= player.VenomWebCost();
						flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
					}
					if (player.faceType == Face.SNAKE_FANGS) {
						outputText("  [monster he] seems to be effected by the poison, its movement turning sluggish.");
						var damage1Bccc:Number = 1;
						if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) damage1Bccc *= 2;
						monster.statStore.addBuffObject({spe:-damage1Bccc}, "Poison",{text:"Poison"});
						var venomType:StatusEffectType = StatusEffects.NagaVenom;
						if (player.racialScore(Races.NAGA) >= 23) venomType = StatusEffects.ApophisVenom;
						if (monster.hasStatusEffect(venomType))
						{
							monster.addStatusValue(venomType,2,0.4);
							monster.addStatusValue(venomType,1,(damage1Bccc*0.4));
						}
						else monster.createStatusEffect(venomType, (damage1Bccc*0.4), 0.4, 0, 0);
						if (player.hasPerk(PerkLib.WoundPoison)){
							if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
							else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
						}
						player.tailVenom -= player.VenomWebCost();
						flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
					}
					if (player.faceType == Face.SPIDER_FANGS) {
						if (player.lowerBody == LowerBody.ATLACH_NACHA){
							outputText("  [monster he] seems to be affected by the poison, showing increasing sign of weakness and arousal.");
							var damage2B:Number = 35 + rand(player.lib / 10);
							var poisonScaling:Number = 1;
							var damage1Bdcc:Number = 1;
							if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) damage1Bdcc *= 2;
							if (player.armor == armors.ELFDRES && player.isElf()) damage1Bdcc *= 2;
							if (player.armor == armors.FMDRESS && player.isWoodElf()) damage1Bdcc *= 2;
							poisonScaling += player.lib/100;
							poisonScaling += player.tou/100;
							if (player.level < 10) damage2B += 20 + (player.level * 3);
							else if (player.level < 20) damage2B += 50 + (player.level - 10) * 2;
							else if (player.level < 30) damage2B += 70 + (player.level - 20) * 1;
							else damage2B += 80;
							damage2B *= 0.2;
							damage2B *= damage1Bdcc;
							damage2B *= 1+(poisonScaling/10);
							poisonScaling *= damage1Bdcc;
							damage2B *= monster.lustVuln;
							monster.teased(damage2B);
							monster.statStore.addBuffObject({tou:-poisonScaling}, "Poison",{text:"Poison"});
							if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
								monster.addStatusValue(StatusEffects.NagaVenom, 3, 1);
							} else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
							if (player.hasPerk(PerkLib.WoundPoison)){
								if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
								else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
							}
							player.tailVenom -= player.VenomWebCost();
							flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
						}
						else {
							outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
							var lustDmg:int = 6 * monster.lustVuln;
							if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) lustDmg *= 2;
							if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
							if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
							lustDmg *= monster.lustVuln;
							monster.teased(lustDmg);
							if (monster.lustVuln > 0 && !monster.hasPerk(PerkLib.EnemyTrueAngel)) {
								monster.lustVuln += 0.01;
								if (monster.lustVuln > 1) monster.lustVuln = 1;
							}
							player.tailVenom -= player.VenomWebCost();
							flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
						}
					}
					if (monster.lust >= monster.maxOverLust()) {
						outputText("\n\n");
						checkAchievementDamage(damage);
						doNext(endLustVictory);
					}
				}
			}
			else outputText("  You do not have enough venom to apply on [weapon]!");
		}
		outputText("\n\n");
		combat.checkAchievementDamage(damage);
		combat.WrathGenerationPerHit2(5);
		combat.WrathWeaponsProc();
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}

	public function feint():void {
		clearOutput();
		outputText("You attempt to feint [themonster] into dropping [monster his] guards. It ");
		if (monster.getEvasionRoll(false, player.spe)) outputText("failed.");
		else {
			var feintduration:Number = 2;
			if (player.hasPerk(PerkLib.GreaterFeint)) feintduration += 2;
			outputText("worked!");
			monster.createStatusEffect(StatusEffects.Distracted, feintduration, 0, 0, 0);
		}
		outputText("\n\n");
		enemyAI();
	}

	public function sneakAttackRange():void {
		clearOutput();
		if (player.fatigue + physicalCost(20) > player.maxFatigue()) {
			clearOutput();
			outputText("You're too fatigued to use sneak attack!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(20, USEFATG_PHYSICAL);
		sneakAttackRange1();
	}
	public function sneakAttackRangeMech():void {
		clearOutput();
		if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] >= 100) flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] -= 100;
		else player.soulforce -= 100;
		sneakAttackRange1();
	}
	public function sneakAttackRange1():void {
		outputText("You shoot [themonster] vitals with your [weaponrange]. ");
		var damage:Number = 0;
		var SAMulti:Number = 2;
		if (player.weaponRange == weaponsrange.M1CERBE || player.weaponRange == weaponsrange.TM1CERB) SAMulti += 4;
		if (player.weaponRange == weaponsrange.SNIPPLE) SAMulti += 6;
		//if (player.weaponRange == weaponsrange.Sakuno M2) SAMulti += 8;
		//if (player.hasPerk(PerkLib.DeadlySneaker)) SAMulti += 2;
		if (combat.calculateRangeDamageMultiplier() > 1) SAMulti += (combat.calculateRangeDamageMultiplier() - 1);
		if (monster.hasStatusEffect(StatusEffects.InvisibleOrStealth)) SAMulti *= 2;
		if (player.weaponRangePerk == "Bow") damage += combat.rangeDamageNoLagSingle(0);
		else damage += combat.firearmsDamageNoLagSingle();
		if (player.weaponRangePerk == "Bow") {
			if (player.weaponRangeName == "Wild Hunt" && player.level > monster.level) damage *= 1.2;
			if (player.weaponRangeName == "Hodr's bow" && monster.hasStatusEffect(StatusEffects.Blind)) damage *= 1.1;
		}
		else {
			if (player.weaponRange == weaponsrange.M1CERBE || player.weaponRange == weaponsrange.TM1CERB) {
				var multiplier:Number = 1;
				var maxFirearmAttacks:int = combat.maxFirearmsAttacks();
				if (maxFirearmAttacks >= 2) multiplier += 1;
				if (maxFirearmAttacks >= 3) multiplier += 1;
				if (maxFirearmAttacks >= 4) multiplier += 1;
				damage *= multiplier;
			}
			if (player.armor == armors.GTECHC_ && !player.isInGoblinMech()) damage *= 1.2;
			if (player.hasKeyItem("Gun Scope") >= 0) damage *= 1.2;
			if (player.hasKeyItem("Gun Scope with Aim tech") >= 0) damage *= 1.4;
			if (player.hasKeyItem("Gun Scope with Aimbot") >= 0) damage *= 1.6;
			if (player.hasPerk(PerkLib.Ghostslinger)) damage *= 1.15;
			if (player.hasPerk(PerkLib.PhantomShooting)) damage *= 1.05;
			if (player.hasPerk(PerkLib.ExplosiveCartridge) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
			if (player.hasPerk(PerkLib.NamedBullet) && monster.hasPerk(PerkLib.EnemyBossType)) damage *= 1.5;
		}
		damage *= SAMulti;
		var crit:Boolean = false;
		var critChance:int = 5;
		var critMulti:Number = 1.75;//coś innego tu wpisać jako perk pozwalający na wyższy mnożnik krytyków
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) critChance += 10;
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50 && player.weaponRangePerk == "Bow") critChance += 5;
		if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "bow") critChance += 10;
		critChance *= 2;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "Bow") buffMultiplier += 1;
			damage *= critMulti+buffMultiplier;
		}
		damage = Math.round(damage);
		var ignoreDR:Boolean = (player.hasPerk(PerkLib.DeadlyAim) && player.weaponRangePerk == "Bow");
		doDamage(damage, true, true, ignoreDR);
		outputText(" ");
		if (crit) outputText("<b>Critical! </b>");
		outputText("\n\n");
		combat.checkAchievementDamage(damage);
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		if (player.weaponRangePerk == "Bow") {
			flags[kFLAGS.ARROWS_SHOT]++;
			if (flags[kFLAGS.ARROWS_SHOT] >= 1) awardAchievement("Arrow to the Knee", kACHIEVEMENTS.COMBAT_ARROW_TO_THE_KNEE);
			bowPerkUnlock();
		}
		enemyAI();
	}

	public function warriorShout():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownWarriorShout, 10, 0, 0, 0);
		outputText("You let out a primal shout that lets your enemies know you won’t be easily defeated.\n\n");
		var wsr:Number = 0.2;
		wsr *= player.maxOverWrath();
		EngineCore.WrathChange(wsr);
		menu();
		addButton(0, "Next", combatMenu, false);
	}

	public function charging():void {
		clearOutput();
		var costvalue:Number = chargingcoooooost();
		if (player.statStore.hasBuff("ScarletSpiritCharge")) HPChange(-(costvalue*2), false);
		else {
			fatigue(costvalue, USEFATG_PHYSICAL);
			if (player.perkv1(IMutationsLib.TwinHeartIM) >= 1 && (player.isTaur() || player.isDrider())) {
				if (player.perkv1(IMutationsLib.TwinHeartIM) >= 2 && (player.isTaur() || player.isDrider())) {
					if (player.perkv1(IMutationsLib.TwinHeartIM) >= 3 && (player.isTaur() || player.isDrider())) {
						if (player.perkv1(IMutationsLib.TwinHeartIM) >= 4 && (player.isTaur() || player.isDrider())) player.createStatusEffect(StatusEffects.CooldownCharging,2,0,0,0);
						else player.createStatusEffect(StatusEffects.CooldownCharging,3,0,0,0);
					}
					else player.createStatusEffect(StatusEffects.CooldownCharging,4,0,0,0);
				}
				else player.createStatusEffect(StatusEffects.CooldownCharging,5,0,0,0);
			}
			else player.createStatusEffect(StatusEffects.CooldownCharging,6,0,0,0);
		}
		outputText("You take some distance before making a U-turn and charge at your opponent with all your might, impaling them on your [weapon]. ");
		var damage:Number = 0;
		var PAM2:Number = 1;
		PAM2 += combat.PASPAS(1);
		damage += combat.meleeDamageNoLagSingle();
		if (damage < 10) damage = 10;
		damage *= 3;
		if (player.haveWeaponForJouster()) {
			var JousterDamageMod:Number = 1;
			if (player.isMeetingNaturalJousterReq()) JousterDamageMod += 2;
            if (player.isMeetingNaturalJousterMasterGradeReq()) JousterDamageMod += 2;
            if (player.isPolearmTypeWeapon()) JousterDamageMod *= 0.75;
			if (player.isTaur() || player.isDrider()) damage *= 2;
			damage *= JousterDamageMod;
		}
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		if (player.isTaur() || player.isDrider()) {
			if (player.perkv1(IMutationsLib.TwinHeartIM) >= 2) {
				if (player.perkv1(IMutationsLib.TwinHeartIM) >= 4) damage *= 3;
				else if (player.perkv1(IMutationsLib.TwinHeartIM) >= 3) damage *= 1.8;
				else damage *= 1.2;
			}
			damage *= 2;
		}
		if (player.hasPerk(PerkLib.DevastatingCharge)) damage *= 1.5;
		if (player.armor.name == "some taur paladin armor" || player.armor.name == "some taur blackguard armor") damage *= 2;
		damage *= PAM2;
		var crit:Boolean = false;
		var critChance:int = 5;
		var critMulti:Number = 1.75;
		critChance += combat.combatPhysicalCritical();
		critMulti += combat.bonusCriticalDamageFromMissingHP();
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) critMulti *= combat.impaleMultiplier();
		if (rand(100) < critChance) {
			crit = true;
			damage *= critMulti;
		}
		checkForElementalEnchantmentAndDoDamage(damage);
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			doDamage(damage, true, true);
			damage *= 2;
		}
		if (player.weapon == weapons.D_LANCE) {
			doDamage(damage, true, true);
			damage *= 2;
		}
		if (crit) {
			outputText("<b>Critical!</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (player.hasAGoreAttack()){
			if (player.horns.type == Horns.UNICORN || player.horns.type == Horns.KIRIN)
			{
				outputText("Not satisfied with your weapon alone you also impale your target on your horn, delivering massive damage.");
			} else {
				outputText("Not satisfied with your weapon alone you also impale your target on your horns, delivering massive damage.");
			}
			doDamage(damage/2, true, true);
			if (player.horns.type == Horns.KIRIN) doLightningDamage(damage/2, true, true)
			if (crit) {
				outputText("<b>Critical!</b>");
			}
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.DevastatingCharge) && !monster.hasPerk(PerkLib.Resolute) && rand(10) > 7) monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		outputText("\n\n");
		combat.checkAchievementDamage(damage);
		combat.WrathGenerationPerHit2(5);
		combat.WrathWeaponsProc();
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}
	public function chargingcoooooost():Number {
		var percent:Number = 40;
		if (player.perkv1(IMutationsLib.TwinHeartIM) >= 1) percent -= (4 * player.perkv1(IMutationsLib.TwinHeartIM));
		var chargingcostvalue:Number = Math.round(player.maxFatigue() * 0.01 * percent);
		if (player.horns.type == Horns.COW_MINOTAUR || player.horns.type == Horns.KIRIN || player.horns.type == Horns.UNICORN || player.horns.type == Horns.BICORN) {
			if (player.hasPerk(PerkLib.PhantomStrike)) chargingcostvalue += 50;
			else chargingcostvalue += 25;
		}
		return chargingcostvalue;
	}

	public function whirlwind():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
			outputText("You are too tired to attack [themonster].");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(50, USEFATG_PHYSICAL);
		outputText("You ready your [weapon] and prepare to spin it around trying to hit as many [themonster] as possible.  ");
		if (((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) && !monster.monsterIsStunned()) {
			if (monster.spe - player.spe < 8) outputText("[Themonster] narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText("[Themonster] dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText("[Themonster] deftly avoids your slow attack.");
			enemyAI();
			return;
		}
		var damage:Number = 0;
		damage += combat.meleeDamageNoLagSingle();
		if (damage < 10) damage = 10;
		if (player.hasPerk(PerkLib.Whirlwind)) damage *= 1.2;
		//other bonuses
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		if (player.hasPerk(PerkLib.PowerSweep)) {
			if (player.isWeaponForWhirlwind()) damage *= 1.25;
			else damage *= 0.75;
		}
		if (player.weaponSpecials("Dual") || player.weaponSpecials("Dual Large")) {
			if (player.hasPerk(PerkLib.MakeItDouble)) damage *= 2;
			else damage *= 1.25;
		}
		if (player.hasPerk(PerkLib.GiantsReach) && (player.weaponSpecials("Large") || player.weaponSpecials("Dual Large") || (player.hasPerk(PerkLib.GigantGripEx) && player.weaponSpecials("Massive")) || (player.hasPerk(PerkLib.GigantGripSu) && player.weaponSpecials("Dual Massive")))) damage *= 1.25;
		//crit
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.isSwordTypeWeapon()) critChance += 10;
		if (player.isDuelingTypeWeapon()) critChance += 20;
		if (player.hasPerk(PerkLib.CycloneStage1)) critChance += 10;
		if (player.hasPerk(PerkLib.CycloneStage2)) critChance += 15;
		if (player.hasPerk(PerkLib.CycloneStage3)) critChance += 20;
		if (player.hasPerk(PerkLib.CycloneStage4)) critChance += 20;
		if (player.hasPerk(PerkLib.CycloneStage5)) critChance += 25;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
		}
		//add bonus for using aoe special
		var bonusmultiplier:Number = 5;
		if (player.hasPerk(PerkLib.Whirlwind)) bonusmultiplier += 1;
		if (player.hasPerk(PerkLib.JobWarlord)) bonusmultiplier += 1;
		if (player.hasPerk(PerkLib.Tornado)) bonusmultiplier += 1;
		if (player.hasPerk(PerkLib.CycloneStage4)) bonusmultiplier += 0.5;
		if (player.hasPerk(PerkLib.CycloneStage5)) bonusmultiplier += 1.5;
		damage *= bonusmultiplier;
		//final touches
		damage = Math.round(damage);
		outputText("Your [weapon] hits few of [themonster], dealing ");
		checkForElementalEnchantmentAndDoDamage(damage);
		outputText(" damage! ");
		if (crit) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}

	public function whipping():void {
		if (player.weapon == weapons.L_WHIP || player.weapon == weapons.DL_WHIP) flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		else flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
			outputText("You are too tired to attack [themonster].");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(50, USEFATG_PHYSICAL);
		outputText("You ready your [weapon] and prepare to spin it around trying to whip as many [themonster] as possible.  ");
		if ((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) {
			if (monster.spe - player.spe < 8) outputText("[Themonster] narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText("[Themonster] dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText("[Themonster] deftly avoids your slow attack.");
			enemyAI();
			return;
		}
		var damage:Number = 0;
		damage += combat.meleeDamageNoLagSingle();
		if (player.hasPerk(PerkLib.Whipping)) damage *= 1.2;
		//other bonuses
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		if (player.weaponSpecials("Dual") || player.weaponSpecials("Dual Large")) {
			if (player.hasPerk(PerkLib.MakeItDouble)) damage *= 2;
			else damage *= 1.25;
		}
		if (player.hasPerk(PerkLib.GiantsReach) && (player.weaponSpecials("Large") || player.weaponSpecials("Dual Large") || (player.hasPerk(PerkLib.GigantGripEx) && player.weaponSpecials("Massive")))) damage *= 1.25;
		//crit
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.CycloneStage1)) critChance += 10;
		if (player.hasPerk(PerkLib.CycloneStage2)) critChance += 15;
		if (player.hasPerk(PerkLib.CycloneStage3)) critChance += 20;
		if (player.hasPerk(PerkLib.CycloneStage4)) critChance += 20;
		if (player.hasPerk(PerkLib.CycloneStage5)) critChance += 25;
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
		}
		//add bonus for using aoe special
		var bonusmultiplier:Number = 5;
		if (player.hasPerk(PerkLib.Whipping)) bonusmultiplier += 1;
		if (player.hasPerk(PerkLib.JobWarlord)) bonusmultiplier += 1;
		if (player.hasPerk(PerkLib.Tornado)) bonusmultiplier += 1;
		if (player.hasPerk(PerkLib.CycloneStage4)) bonusmultiplier += 0.5;
		if (player.hasPerk(PerkLib.CycloneStage5)) bonusmultiplier += 1.5;
		damage *= bonusmultiplier;
		//final touches
		damage = Math.round(damage);
		outputText("Your [weapon] whipped few of [themonster], dealing ");
		checkForElementalEnchantmentAndDoDamage(damage);
		outputText(" damage! ");
		if (crit) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}

	public function whirlwindClaws():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
			outputText("You are too tired to attack [themonster].");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		outputText("You ready your claws and prepare to spin it around trying to hit as many [themonster] as possible.  ");
		if ((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) {
			if (monster.spe - player.spe < 8) outputText("[Themonster] narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText("[Themonster] dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText("[Themonster] deftly avoids your slow attack.");
			enemyAI();
			return;
		}
		fatigue(50, USEFATG_PHYSICAL);
		var damage:Number = 0;
		damage += (combat.meleeUnarmedDamageNoLagSingle() * 2);
		if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) damage += (combat.meleeUnarmedDamageNoLagSingle() * 2);
		if (player.hasPerk(PerkLib.WhirlwindFeral)) damage += combat.meleeUnarmedDamageNoLagSingle();
		//addictive bonuses
		if (player.hasPerk(PerkLib.IronFistsI)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsII)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsIII)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsIV)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsV)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsVI)) damage += 10;
		if (player.hasPerk(PerkLib.JobBrawler)) damage += (5 * (1 + player.newGamePlusMod()));
		if (player.hasPerk(PerkLib.JobMonk)) damage += (10 * (1 + player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Berzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Lustzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
			if (player.isRaceCached(Races.MOUSE, 2) && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
			else damage *= 2;
		}
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		//crit
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.CycloneStage1)) critChance += 10;
		if (player.hasPerk(PerkLib.CycloneStage2)) critChance += 15;
		if (player.hasPerk(PerkLib.CycloneStage3)) critChance += 20;
		if (player.hasPerk(PerkLib.CycloneStage4)) critChance += 20;
		if (player.hasPerk(PerkLib.CycloneStage5)) critChance += 25;
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
		}
		//add bonus for using aoe special
		var bonusmultiplier:Number = 5;
		if (player.hasPerk(PerkLib.WhirlwindFeral)) bonusmultiplier += 1;
		if (player.hasPerk(PerkLib.JobWarlord)) bonusmultiplier += 1;
		if (player.hasPerk(PerkLib.Tornado)) bonusmultiplier += 1;
		if (player.hasPerk(PerkLib.CycloneStage4)) bonusmultiplier += 0.5;
		if (player.hasPerk(PerkLib.CycloneStage5)) bonusmultiplier += 1.5;
		damage *= bonusmultiplier;
		if (player.weaponName == "fists" && player.haveNaturalClaws()) damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
		//final touches
		damage = Math.round(damage);
		outputText("Your claws hits few of [themonster], dealing ");
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
			damage = Math.round(damage * combat.fireDamageBoostedByDao());
			doFireDamage(damage, true, true);
		}
		else if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			doDamage(damage, true, true);
			damage = Math.round(damage * combat.fireDamageBoostedByDao());
			doFireDamage(Math.round(damage*0.1), true, true);
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
			damage = Math.round(damage * 1.1);
		}
		else doDamage(damage, true, true);
		outputText(" damage! ");
		if (crit) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
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
			if(monster.plural) outputText("You rush [themonster], whipping your hair around to catch them with your tentacles, but [monster he] easily dodge.  Oy, you hope you didn't just give yourself whiplash.");
			else outputText("You rush [themonster], whipping your hair around to catch it with your tentacles, but [monster he] easily dodges.  Oy, you hope you didn't just give yourself whiplash.");
		}
		//Success!
		else {
			outputText("You rush [themonster], whipping your hair around like a genie");
			outputText(", and manage to land a few swipes with your tentacles.  ");
			if(monster.plural) outputText("As the venom infiltrates [monster his] bodies, [monster he] twitch and begin to move more slowly, hampered half by paralysis and half by arousal.");
			else outputText("As the venom infiltrates [monster his] body, [monster he] twitches and begins to move more slowly, hampered half by paralysis and half by arousal.");
			//(decrease speed/str, increase lust)
			//-venom capacity determined by hair length, 2-3 stings per level of length
			//Each sting does 5-10 lust damage and 2.5-5 speed damage
			var damage:Number = 0;
			var hairDamage:int = 1 + rand(2);
			if(player.hairLength >= 12) hairDamage += 1 + rand(2);
			if(player.hairLength >= 24) hairDamage += 1 + rand(2);
			if(player.hairLength >= 36) hairDamage += 1;
			if (player.hasPerk(PerkLib.RacialParagon)) hairDamage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) hairDamage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) hairDamage *= 2;
			while(hairDamage > 0) {
				hairDamage--;
				damage += 5 + rand(6);
			}
			damage += player.level * 1.5;
			damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
			if (player.armor == armors.ELFDRES && player.isElf()) damage *= 2;
        	if (player.armor == armors.FMDRESS && player.isWoodElf()) damage *= 2;
			monster.statStore.addBuffObject({spe:-damage/2}, "Poison",{text:"Poison"});
			damage = monster.lustVuln * damage;
			//Clean up down to 1 decimal point
			damage = Math.round(damage*10)/10;
			monster.teased(Math.round(monster.lustVuln * damage));
			combat.WrathGenerationPerHit2(5);
		}
		//New lines and moving on!
		outputText("\n\n");
		doNext(combatMenu);
		if(!combatIsOver()) enemyAI();
	}


//special attack: tail whip? could unlock button for use by dagrons too
//tiny damage and lower monster armor by ~75% for one turn
//hit
	public function tailWhipAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		//miss
		if((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) {
			outputText("Twirling like a top, you swing your tail, but connect with only empty air.");
		}
		else {
			if(!monster.plural) outputText("Twirling like a top, you bat your opponent with your tail.  For a moment, [monster he] looks disbelieving, as if [monster his] world turned upside down, but [monster he] soon becomes irate and redoubles [monster his] offense, leaving large holes in [monster his] guard.  If you're going to take advantage, it had better be right away; [monster he]'ll probably cool off very quickly.");
			else outputText("Twirling like a top, you bat your opponent with your tail.  For a moment, [monster he] look disbelieving, as if [monster his] world turned upside down, but [monster he] soon become irate and redouble [monster his] offense, leaving large holes in [monster his] guard.  If you're going to take advantage, it had better be right away; [monster he]'ll probably cool off very quickly.");
			if(!monster.hasStatusEffect(StatusEffects.CoonWhip)) monster.createStatusEffect(StatusEffects.CoonWhip,0,0,0,0);
			var armorChanges:int = Math.round(monster.armorDef * .75);
			while(armorChanges > 0 && monster.armorDef >= 1) {
				monster.armorDef--;
				monster.addStatusValue(StatusEffects.CoonWhip,1,1);
				armorChanges--;
			}
			monster.addStatusValue(StatusEffects.CoonWhip,2,2);
			if(player.tailType == Tail.RACCOON) monster.addStatusValue(StatusEffects.CoonWhip,2,2);
		}
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		enemyAI();
	}

	public function tailSlapAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(80, USEFATG_PHYSICAL);
		else fatigue(40, USEFATG_PHYSICAL);
		var kitshoo:String = "";
		if (player.tailType == Tail.KITSHOO && player.tailCount > 1) kitshoo = "s"
		outputText("With a simple thought you set your tail"+kitshoo+" ablaze.");
		//miss
		if((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) {
			outputText("  Twirling like a top, you swing your tail"+kitshoo+", but connect with only empty air.");
		}
		else {
			if(!monster.plural) outputText("  Twirling like a top, you bat your opponent with your tail"+kitshoo+".");
			else outputText("  Twirling like a top, you bat your opponents with your tail"+kitshoo+".");
			var damage:Number = 0;
			damage += combat.meleeUnarmedDamageNoLagSingle();
			damage = calcInfernoMod(damage, true);
			if (player.statStore.hasBuff("FoxflamePelt")) {
				var foxfiremulti:Number = 1;
				foxfiremulti += spellMod() - 1;
				foxfiremulti += soulskillMagicalMod() - 1;
				if (player.shieldName == "spirit focus") foxfiremulti += .2;
				if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono" || player.armorName == "black kimono") foxfiremulti += .2;
				if (player.headjewelryName == "fox hairpin") foxfiremulti += .2;
				if (player.hasPerk(PerkLib.StarSphereMastery)) foxfiremulti += player.perkv1(PerkLib.StarSphereMastery) * 0.05;
				if (player.perkv1(IMutationsLib.KitsuneThyroidGlandIM) >= 2) foxfiremulti += 1;
				damage *= foxfiremulti;
			}
			if (monster.plural) damage *= 5;
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
			if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
			damage *= monster.damagePercent() / 100;
			if (damage < 5) damage = 5;
			damage = Math.round(damage * combat.fireDamageBoostedByDao());
			outputText("  Your tail"+kitshoo+" slams against [themonster], dealing ");
			doFireDamage(damage, true, true);
			if (player.statStore.hasBuff("FoxflamePelt")) {
				var lustDmg:Number = tailSlapAttackKitshoo();
				lustDmg = Math.round(monster.lustVuln * lustDmg);
				monster.teased(lustDmg, false);
			}
			if (player.tailType == Tail.KITSHOO && player.tailCount > 1) {
				var multismack:Number = (player.tailCount - 1);
				while (multismack-->0) {
					doFireDamage(damage, true, true);
					if (player.statStore.hasBuff("FoxflamePelt")) monster.teased(lustDmg, false);
				}
			}
			outputText(" damage! ");
			if (player.hasPerk(PerkLib.PhantomStrike)) {
				outputText("  Phantom strike dealing additional ");
				doFireDamage(damage, true, true);
				if (player.tailType == Tail.KITSHOO && player.tailCount > 1) {
					var psmultismack:Number = (player.tailCount - 1);
					while (psmultismack-->0) {
						doFireDamage(damage, true, true);
						if (player.statStore.hasBuff("FoxflamePelt")) monster.teased(lustDmg, false);
					}
				}
				outputText(" damage! ");
				damage *= 2;
			}
			if (monster.hasStatusEffect(StatusEffects.BurnDoT)) monster.addStatusValue(StatusEffects.BurnDoT,1,1);
			else monster.createStatusEffect(StatusEffects.BurnDoT,10,0.02,0,0);
			if (player.tailType == Tail.KITSHOO && player.tailCount > 1) damage *= player.tailCount;
			checkAchievementDamage(damage);
		}
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5*player.tailCount);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}
	private function tailSlapAttackKitshoo():Number {
		var lustDmg:Number = monster.lustVuln * ((player.inte / 12 + player.wis / 8) * ((spellMod() + soulskillMagicalMod()) / 2) + rand(monster.lib + monster.cor) / 5);
		if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg *= 1.5;
		lustDmg *= 0.1;
		if (player.shieldName == "spirit focus") lustDmg *= 1.2;
		if (player.headjewelryName == "fox hairpin") lustDmg *= 1.2;
		if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) lustDmg *= 2;
		if (player.hasPerk(PerkLib.InariBlessedKimono)) lustDmg *= 1.5;
		if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmg *= 1.50;
		return lustDmg;
	}

	public function tailSmackAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(40, USEFATG_PHYSICAL);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownTailSmack,5,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownTailSmack,5,0,0,0);
		//miss
		if((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) {
			outputText("You smash your tail at [themonster], but connect with only empty air.");
		}
		else {
			outputText("You smash your tail at [themonster] face making ");
			if(!monster.plural) outputText("it");
			else outputText("them");
			outputText(" reel ");
			if (!monster.hasPerk(PerkLib.Resolute)) {
				outputText("dazed by the sheer strength of the hit. ");
				monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
			}
			else outputText("back in pain but hold steady despite the impact.");
		}
		combat.WrathGenerationPerHit2(5);
		outputText("\n\n");
		enemyAI();
	}

	public function inkSpray():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(30, USEFATG_PHYSICAL);
		var cooooldown:Number = 8;
		if (player.perkv1(IMutationsLib.ScyllaInkGlandsIM) >= 1) cooooldown -= 4;
		if (player.hasPerk(PerkLib.NaturalInstincts)) cooooldown -= 1;
		player.createStatusEffect(StatusEffects.CooldownInkSpray,cooooldown,0,0,0);
		outputText("You ");
		if (player.gender == 1) outputText("lift your cock ");
		if ((player.gender == 2 || player.gender == 3) && player.isScylla()) outputText("lift a few tentacle ");
		outputText("spraying your foe face in ink.  It start trashing its arm about attempting to remove the ink.\n");
		outputText(" <b>[Themonster] is blinded!</b>");
		var ispray:Number = 2;
		if (player.perkv1(IMutationsLib.ScyllaInkGlandsIM) >= 2) ispray += 2;
		if (player.hasPerk(PerkLib.KrakenBlackDress)) {
			monster.createStatusEffect(StatusEffects.InkBlind, (ispray * 1.5), 0, 0, 0);
			monster.createStatusEffect(StatusEffects.Stunned, (ispray * 1.5), 0, 0, 0);
		}
		else {
			monster.createStatusEffect(StatusEffects.InkBlind, ispray, 0, 0, 0);
			monster.createStatusEffect(StatusEffects.Stunned, ispray, 0, 0, 0);
		}
		if (monster.lustVuln > 0) {
			var lustDmg:Number = 2 + player.teaseLevel + rand(5);
			if (player.perkv1(IMutationsLib.ScyllaInkGlandsIM) >= 2) lustDmg *= 2;
			if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
			if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
			monster.teased(Math.round(monster.lustVuln * lustDmg));
		}
		outputText("\n\n");
		statScreenRefresh();
		if(monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		else enemyAI();
	}

	public function milkBlast():void {
		clearOutput();
		if (player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 3) {
			var cdd:Number = 4;
			if (player.hasPerk(PerkLib.NaturalInstincts)) cdd -= 1;
			if (player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 4) cdd -= 1;
			player.createStatusEffect(StatusEffects.CooldownMilkBlast, cdd, 0, 0, 0);
		}
		else player.createStatusEffect(StatusEffects.CooldownMilkBlast, 0, 0, 0, 0);
		outputText("You grab both of your udder smirking as you point them toward your somewhat confused target. You moan a pleasured Mooooooo as you open the dam splashing [themonster] with a twin jet of milk so powerful it is blown away hitting the nearest obstacle. ");
		var damage:Number = 0;
		damage += player.lactationQ();
		damage *= (player.lust100 * 0.01);
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		if (player.upperGarment == player.game.undergarments.COW_BRA) damage *= 1.50;
		damage = Math.round(damage);
		if (damage < 1) damage = 1;
		doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		if (player.perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 3) player.lust -= 200;
		else player.lust -= 100;
		if (monster.lustVuln > 0) {
			outputText(" ");
			var MilkLustDmg:Number = 0;
			MilkLustDmg += combat.scalingBonusLibido() * 0.2;
			if (player.armor == armors.ELFDRES && player.isElf()) MilkLustDmg *= 2;
			if (player.armor == armors.FMDRESS && player.isWoodElf()) MilkLustDmg *= 2;
			monster.teased(Math.round(monster.lustVuln * MilkLustDmg));
		}
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		enemyAI();
	}

	public function cumCannon():void {
		clearOutput();
		if (player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 3) {
			var cdd:Number = 4;
			if (player.hasPerk(PerkLib.NaturalInstincts)) cdd -= 1;
			if (player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 4) cdd -= 1;
			player.createStatusEffect(StatusEffects.CooldownCumCannon, cdd, 0, 0, 0);
		}
		else player.createStatusEffect(StatusEffects.CooldownCumCannon, 0, 0, 0, 0);
		outputText("You begin to masturbate fiercely, your [balls] expending with stacked semen as you ready to blow. Your cock shoot a massive jet of cum, projecting [themonster] away and knocking it prone. ");
		var damage:Number = 0;
		damage += player.cumQ();
		damage *= (player.lust100 * 0.01);
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage);
		doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		if (player.perkv1(IMutationsLib.MinotaurTesticlesIM) >= 3) player.lust -= 200;
		else player.lust -= 100;
		if (monster.lustVuln > 0) {
			outputText(" ");
			var CumLustDmg:Number = 0;
			CumLustDmg += combat.scalingBonusLibido() * 0.2;
			if (player.armor == armors.ELFDRES && player.isElf()) CumLustDmg *= 2;
			if (player.armor == armors.FMDRESS && player.isWoodElf()) CumLustDmg *= 2;
			monster.teased(Math.round(monster.lustVuln * CumLustDmg));
		}
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		awardAchievement("Cum Cannon", kACHIEVEMENTS.COMBAT_CUM_CANNON);
		enemyAI();
	}

	public function takeFlight():void {
		clearOutput();
		outputText("You open your wings and take flight.\n\n");
		player.createStatusEffect(StatusEffects.Flying, combat.flightDurationNatural(), 0, 0, 0);
		if (!player.hasPerk(PerkLib.Resolute)) {
			player.createStatusEffect(StatusEffects.FlyingNoStun, 0, 0, 0, 0);
			player.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
		}
		monster.createStatusEffect(StatusEffects.MonsterAttacksDisabled, 0, 0, 0, 0);
		enemyAI();
	}

	public function takeFlightGoglinMech():void {
		clearOutput();
		outputText("You activate the fly function and get some distance from the ground.\n\n");
		player.createStatusEffect(StatusEffects.Flying, 5, 0, 0, 0);
		if (!player.hasPerk(PerkLib.Resolute)) {
			player.createStatusEffect(StatusEffects.FlyingNoStun, 0, 0, 0, 0);
			player.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
		}
		monster.createStatusEffect(StatusEffects.MonsterAttacksDisabled, 0, 0, 0, 0);
		enemyAI();
	}

	public function bodySlam():void {
		clearOutput();
		fatigue(50, USEFATG_PHYSICAL);
		outputText("You take a low stance and begin to charge at [themonster]. Letting your momentum take over, you crash into your opponent and tackle them to the ground, dealing massive damage as they're crushed underneath your weight. ");
		if (silly()) {
			outputText("As you collide with [themonster], everything goes grey, and [themonster] looks directly at the camera. <i>\"Yep, that is me. The one being crushed underneath a fatty. Now you might be wondering how this all happened, ");
			outputText("and honestly, I am too. Here I am doing my job, and out of nowhere I'm attacked by a pig. Next thing I know, I'm about to be crushed under a mountain of fat. Now there's probably some joke you can make right now, the only thing coming to my mind is Space Jam.\"</i>");
			outputText(" Everything returns to normal, and [themonster] gets comically crushed in slow motion under a mountain of fat, with the camera taking extra care to zoom in on [themonster]'s face.");
		}
		var slamDmg:Number = player.thickness;
		if (player.perkv1(IMutationsLib.PigBoarFatIM) >= 1) slamDmg += player.thickness;
		slamDmg += scalingBonusToughness();
		if (player.perkv1(IMutationsLib.PigBoarFatIM) >= 3) slamDmg *= 2;
		if (player.hasPerk(PerkLib.RacialParagon)) slamDmg *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) slamDmg *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) slamDmg *= 2;
		slamDmg *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
		slamDmg = Math.round(slamDmg);
		doDamage(slamDmg);
		outputText("<b>(<font color=\"#800000\">" + slamDmg + "</font>)</b>");
		if (!monster.hasPerk(PerkLib.Resolute) && rand(10) == 0) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		if (flags[kFLAGS.HUNGER_ENABLED] >= 1) {
			outputText(" The landing from your impressive charge and tackle deals some recoil damage, leaving you a bit winded. ");
			player.takePhysDamage(Math.round(slamDmg * 0.1), true);
			if (player.HP <= player.minHP()) doNext(endHpLoss);
			return;
		}
		if (silly()) outputText(" The force causes you to literally bounce off of [themonster], allowing the camera to get a nice shot of [themonster] twitching in an indent in their general shape.");
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(slamDmg);
		combat.EruptingRiposte();
		enemyAI();
	}
	public function minThicknessReq():Number {
		var miniThicknessvalue:Number = 95;
		if (player.perkv1(IMutationsLib.PigBoarFatIM) >= 2) miniThicknessvalue -= 10;
		if (player.perkv1(IMutationsLib.PigBoarFatIM) >= 3) miniThicknessvalue -= 35;
		return miniThicknessvalue;
	}

	public function slinggoo():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		outputText("You sift a significant amount of mass to your arm, causing it to bulge grotesquely and almost triple in size, you then open a small slit in your palm to let out a thick stream of pressurized slime at your foe, soaking them with your gooey aphrodisiacs. They won’t be running around at full speed for a while unless they want to slip on your slime. ");
		var lustDmgF:Number = 20 + rand(6);
		var lustBoostToLustDmg:Number = 0;
		var bimbo:Boolean   = false;
		var bro:Boolean     = false;
		var futa:Boolean    = false;
		if (player.hasPerk(PerkLib.SensualLover)) lustDmgF += 2;
		if (player.hasPerk(PerkLib.Seduction)) lustDmgF += 5;
		lustDmgF += player.teaseDmgStat.value;
		if (bimbo || bro || futa) lustDmgF += 5;
		if (player.hasPerk(PerkLib.FlawlessBody)) lustDmgF += 10;
		lustDmgF += scalingBonusLibido() * 0.1;
		if (player.hasPerk(PerkLib.EromancyExpert)) lustDmgF *= 1.5;
		if (player.hasPerk(PerkLib.JobSeducer)) lustDmgF += player.teaseLevel * 3;
		else lustDmgF += player.teaseLevel * 2;
		if (player.hasPerk(PerkLib.JobCourtesan) && monster.hasPerk(PerkLib.EnemyBossType)) lustDmgF *= 1.2;
		switch (player.coatType()) {
			case Skin.FUR:
				lustDmgF += (1 + player.newGamePlusMod());
				break;
			case Skin.SCALES:
				lustDmgF += (2 * (1 + player.newGamePlusMod()));
				break;
			case Skin.CHITIN:
				lustDmgF += (3 * (1 + player.newGamePlusMod()));
				break;
			case Skin.BARK:
				lustDmgF += (4 * (1 + player.newGamePlusMod()));
				break;
		}
		if (player.hasPerk(PerkLib.SluttySimplicity) && player.armor.hasTag(ItemTags.A_REVEALING)) lustDmgF *= (1 + ((10 + rand(11)) / 100));
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) lustDmgF *= (1 + (player.lust100 * 0.01));
		if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) lustDmgF *= (1 + combat.historyWhoreBonus());
		if (player.hasPerk(PerkLib.RacialParagon)) lustDmgF *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmgF *= 1.50;
		lustBoostToLustDmg += lustDmgF * 0.01;
		lustDmgF *= 0.2;
		if (player.lust100 * 0.01 >= 0.9) lustDmgF += (lustBoostToLustDmg * 140);
		else if (player.lust100 * 0.01 < 0.2) lustDmgF += (lustBoostToLustDmg * 140);
		else lustDmgF += (lustBoostToLustDmg * 2 * (20 - (player.lust100 * 0.01)));
		//Determine if critical tease!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.teases.combatTeaseCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			lustDmgF *= 1.75;
		}
		if (player.hasPerk(PerkLib.ChiReflowLust)) lustDmgF *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
		if (player.hasPerk(PerkLib.ArouseTheAudience) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))) lustDmgF *= 1.5;
		if (player.armor == armors.ELFDRES && player.isElf()) lustDmgF *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmgF *= 2;
		lustDmgF = lustDmgF * monster.lustVuln;
		lustDmgF = Math.round(lustDmgF);
		monster.teased(lustDmgF);
		if (crit) outputText(" <b>Critical!</b>");
		outputText("\n\n");
		monster.statStore.addBuffObject({spe:-15}, "Poison",{text:"Poison"});
		combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		combat.WrathGenerationPerHit2(5);
		enemyAI();
	}

	public function terrifyingHowl():void {
		clearOutput();
		if(monster is EncapsulationPod || monster.inte == 0 || monster is LivingStatue) {
			clearOutput();
			outputText("You unleash a deafening howl, but [themonster] has no reaction to the sound\n\n");
			fatigue(10);
			enemyAI();
			return;
		}
		fatigue(40, USEFATG_PHYSICAL);
		if(monster.hasPerk(PerkLib.Focused)) {
			if(!monster.plural) outputText("[Themonster] is too focused for your howl to influence!\n\n");
			enemyAI();
			return;
		}
		//[Failure]
		if(rand(10) == 0) {
			outputText("You unleash a deafening howl, but partway through your voice cracks and you start coughing.\n\n");
			fatigue(10);
			enemyAI();
			return;
		}
		outputText("You unleash a deafening howl causing [themonster] to back off in fear momentarily dazed.\n\n");
		monster.createStatusEffect(StatusEffects.Fear,1,0,0,0);
		enemyAI();
	}

	public function wingSlapAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(80, USEFATG_PHYSICAL);
		else fatigue(40, USEFATG_PHYSICAL);
		//miss
		if((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) {
			outputText("Twirling like a top, you swing your wings, but connect with only empty air.");
		}
		else {
			if(!monster.plural) outputText("Twirling like a top, you slap your opponent with your wings.");
			else outputText("Twirling like a top, you slap your opponents with your wings.");
			var damage:Number = combat.meleeUnarmedDamageNoLagSingle();
			if (player.thirdtierWingsForWingSlap()) damage += combat.meleeUnarmedDamageNoLagSingle();
			//if (tu jak byłyby 4th tier wings dodane) damage += combat.meleeUnarmedDamageNoLagSingle();
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
				if (player.isRaceCached(Races.MOUSE, 2) && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
				else damage *= 2;
			}
			damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
			damage *= monster.damagePercent() / 100;
			if (damage < 5) damage = 5;
			damage = Math.round(damage);
			outputText("  Your wings slams against [themonster], dealing ");
			if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
				damage = Math.round(damage * combat.fireDamageBoostedByDao());
				doFireDamage(damage, true, true);
			}
			else if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
				doDamage(damage, true, true);
				damage = Math.round(damage * combat.fireDamageBoostedByDao());
				doFireDamage(Math.round(damage*0.1), true, true);
				if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
				damage = Math.round(damage * 1.1);
			}
			else doDamage(damage, true, true);
			if (player.hasPerk(PerkLib.PhantomStrike)) {
				if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) doFireDamage(damage, true, true);
				else if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
					doDamage(damage, true, true);
					doFireDamage(Math.round(damage*0.1), true, true);
					if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
					damage = Math.round(damage * 1.1);
				}
				else doDamage(damage, true, true);
			}
			outputText(" damage! ");
			checkAchievementDamage(damage);
		}
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}

	private function temporalGolemsAplification():Number {
		var dmgAMP:Number = 0;
		if (player.hasPerk(PerkLib.ChargedCore)) dmgAMP += 0.5;
		if (player.hasPerk(PerkLib.SuperChargedCore)) dmgAMP += 0.5;
		if (player.hasPerk(PerkLib.GolemArmyJuniorLieutenant)) dmgAMP += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyLieutenant)) dmgAMP += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyCaptain)) dmgAMP += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyMajor)) dmgAMP += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyColonel)) dmgAMP += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyLieutenantColonel)) dmgAMP += 0.1;
		if (player.weapon == weapons.SCECOMM) dmgAMP += 0.5;
		if (player.weapon == weapons.G_ROD) dmgAMP += 0.75;
		if (player.weaponRange == weaponsrange.G_E_MAN) dmgAMP += 0.5;
		if (player.shield == shields.Y_U_PAN) dmgAMP += 0.25;
		if (flags[kFLAGS.WILL_O_THE_WISP] == 2) {
			dmgAMP += 0.1;
			if (player.hasPerk(PerkLib.WispLieutenant)) dmgAMP += 0.2;
			if (player.hasPerk(PerkLib.WispCaptain)) dmgAMP += 0.3;
			if (player.hasPerk(PerkLib.WispMajor)) dmgAMP += 0.4;
			if (player.hasPerk(PerkLib.WispColonel)) dmgAMP += 0.5;
		}
		if (player.hasPerk(PerkLib.HistoryTactician) || player.hasPerk(PerkLib.PastLifeTactician)) dmgAMP += (1 - combat.historyTacticianBonus());
		return dmgAMP;
	}
	public function sendTemporalGolem1():void {
		clearOutput();
		flags[kFLAGS.TEMPORAL_GOLEMS_BAG]--;
		//Determine if golem core is shattered or not picked due too overloaded bag for them!
		var damage:Number = 0;
		var dmgamp:Number = 1;
		var shatter:Boolean = false;
		var shatterChance:int = 10;
		var overloadedGolemCoresBag:Boolean = false;
		if (player.hasPerk(PerkLib.BeginnerGolemMaker)) {
			damage += ((player.inte + player.wis) * 5);
			shatterChance -= 2;
		}
		if (player.hasPerk(PerkLib.ApprenticeGolemMaker)) {
			damage += ((player.inte + player.wis) * 6);
			shatterChance -= 2;
		}
		if (player.hasPerk(PerkLib.ExpertGolemMaker)) {
			damage += ((player.inte + player.wis) * 7);
			shatterChance -= 3;
		}
		if (player.hasPerk(PerkLib.MasterGolemMaker)) {
			damage += ((player.inte + player.wis) * 8);
			shatterChance -= 3;
		}
		if (rand(100) < shatterChance) {
			shatter = true;
		}
		if (!shatter) {
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] < camp.campMake.maxReusableGolemCoresBagSize()) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]++;
			else overloadedGolemCoresBag = true;
		}
		damage += ((player.inte + player.wis + 300 + rand(121)) * 20);
		if (player.hasPerk(PerkLib.ChargedCore)) damage += ((300 + rand(121)) * 10);
		if (player.hasPerk(PerkLib.SuperChargedCore)) damage += ((300 + rand(121)) * 10);
		dmgamp += temporalGolemsAplification();
		damage *= dmgamp;
		damage = Math.round(damage);
		outputText("Your stone golem slam into [themonster]. ");
		doDamage(damage, true, true);
		if (shatter) outputText(" <b>*Golem Core shattered!*</b>");
		if (overloadedGolemCoresBag) outputText(" <b>*Golem Core wasn't picked due to lack of space to store them!*</b>");
		outputText("\n\n");
		enemyAI();
	}
	public function sendTemporalGolem3():void {
		clearOutput();
		flags[kFLAGS.TEMPORAL_GOLEMS_BAG] -= 3;
		//Determine if golem core is shattered or not picked due too overloaded bag for them!
		var damage:Number = 0;
		var dmgamp:Number = 1;
		var shatter:Boolean = false;
		var shatterChance:int = 10;
		var overloadedGolemCoresBag:Boolean = false;
		var partialyoverloadedGolemCoresBag:Boolean = false;
		if (player.hasPerk(PerkLib.BeginnerGolemMaker)) {
			damage += ((player.inte + player.wis) * 5);
			shatterChance -= 2;
		}
		if (player.hasPerk(PerkLib.ApprenticeGolemMaker)) {
			damage += ((player.inte + player.wis) * 6);
			shatterChance -= 2;
		}
		if (player.hasPerk(PerkLib.ExpertGolemMaker)) {
			damage += ((player.inte + player.wis) * 7);
			shatterChance -= 3;
		}
		if (player.hasPerk(PerkLib.MasterGolemMaker)) {
			damage += ((player.inte + player.wis) * 8);
			shatterChance -= 3;
		}
		if (rand(100) < shatterChance) {
			shatter = true;
		}
		if (!shatter) {
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] + 3 < camp.campMake.maxReusableGolemCoresBagSize()) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] += 3;
			else overloadedGolemCoresBag = true;
		}
		if (!shatter && !overloadedGolemCoresBag) {
			if ((camp.campMake.maxReusableGolemCoresBagSize() - flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]) < 3) {
				flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] = camp.campMake.maxReusableGolemCoresBagSize();
				partialyoverloadedGolemCoresBag = true;
			}
		}
		damage += ((player.inte + player.wis + 300 + rand(121)) * 20);
		if (player.hasPerk(PerkLib.ChargedCore)) damage += ((300 + rand(121)) * 10);
		if (player.hasPerk(PerkLib.SuperChargedCore)) damage += ((300 + rand(121)) * 10);
		damage *= 3;
		dmgamp += temporalGolemsAplification();
		damage *= dmgamp;
		damage = Math.round(damage);
		outputText("Your stone golems slams into [themonster]. ");
		doDamage(damage, true, true);
		if (shatter) outputText(" <b>*Golem Cores shattered!*</b>");
		if (overloadedGolemCoresBag) outputText(" <b>*None of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		if (partialyoverloadedGolemCoresBag) outputText(" <b>*Some of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		outputText("\n\n");
		enemyAI();
	}
	public function sendTemporalGolem5():void {
		clearOutput();
		flags[kFLAGS.TEMPORAL_GOLEMS_BAG] -= 5;
		//Determine if golem core is shattered or not picked due too overloaded bag for them!
		var damage:Number = 0;
		var dmgamp:Number = 1;
		var shatter:Boolean = false;
		var shatterChance:int = 10;
		var overloadedGolemCoresBag:Boolean = false;
		var partialyoverloadedGolemCoresBag:Boolean = false;
		if (player.hasPerk(PerkLib.BeginnerGolemMaker)) {
			damage += ((player.inte + player.wis) * 5);
			shatterChance -= 2;
		}
		if (player.hasPerk(PerkLib.ApprenticeGolemMaker)) {
			damage += ((player.inte + player.wis) * 6);
			shatterChance -= 2;
		}
		if (player.hasPerk(PerkLib.ExpertGolemMaker)) {
			damage += ((player.inte + player.wis) * 7);
			shatterChance -= 3;
		}
		if (player.hasPerk(PerkLib.MasterGolemMaker)) {
			damage += ((player.inte + player.wis) * 8);
			shatterChance -= 3;
		}
		if (rand(100) < shatterChance) {
			shatter = true;
		}
		if (!shatter) {
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] + 5 < camp.campMake.maxReusableGolemCoresBagSize()) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] += 5;
			else overloadedGolemCoresBag = true;
		}
		if (!shatter && !overloadedGolemCoresBag) {
			if ((camp.campMake.maxReusableGolemCoresBagSize() - flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]) < 5) {
				flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] = camp.campMake.maxReusableGolemCoresBagSize();
				partialyoverloadedGolemCoresBag = true;
			}
		}
		damage += ((player.inte + player.wis + 300 + rand(121)) * 20);
		if (player.hasPerk(PerkLib.ChargedCore)) damage += ((300 + rand(121)) * 10);
		if (player.hasPerk(PerkLib.SuperChargedCore)) damage += ((300 + rand(121)) * 10);
		damage *= 5;
		dmgamp += temporalGolemsAplification();
		damage *= dmgamp;
		damage = Math.round(damage);
		outputText("Your stone golems slams into [themonster]. ");
		doDamage(damage, true, true);
		if (shatter) outputText(" <b>*Golem Cores shattered!*</b>");
		if (overloadedGolemCoresBag) outputText(" <b>*None of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		if (partialyoverloadedGolemCoresBag) outputText(" <b>*Some of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		outputText("\n\n");
		enemyAI();
	}
	public function sendTemporalGolem4():void {
		flags[kFLAGS.TEMPORAL_GOLEMS_BAG] -= 4;
		var damage:Number = 0;
		var dmgamp:Number = 1;
		var overloadedGolemCoresBag:Boolean = false;
		var partialyoverloadedGolemCoresBag:Boolean = false;
		if (player.hasPerk(PerkLib.BeginnerGolemMaker)) damage += ((player.inte + player.wis) * 5);
		if (player.hasPerk(PerkLib.ApprenticeGolemMaker)) damage += ((player.inte + player.wis) * 6);
		if (player.hasPerk(PerkLib.ExpertGolemMaker)) damage += ((player.inte + player.wis) * 7);
		if (player.hasPerk(PerkLib.MasterGolemMaker)) damage += ((player.inte + player.wis) * 8);
		if (!overloadedGolemCoresBag) {
			if ((camp.campMake.maxReusableGolemCoresBagSize() - flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]) < 4) {
				flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] = camp.campMake.maxReusableGolemCoresBagSize();
				partialyoverloadedGolemCoresBag = true;
			}
		}
		damage += ((player.inte + player.wis + 300 + rand(121)) * 20);
		if (player.hasPerk(PerkLib.ChargedCore)) damage += ((300 + rand(121)) * 10);
		if (player.hasPerk(PerkLib.SuperChargedCore)) damage += ((300 + rand(121)) * 10);
		damage *= 4;
		dmgamp += temporalGolemsAplification();
		damage *= dmgamp;
		damage = Math.round(damage);
		outputText("Your stone golems slams into [themonster]. ");
		doDamage(damage, true, true);
		if (overloadedGolemCoresBag) outputText(" <b>*None of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		if (partialyoverloadedGolemCoresBag) outputText(" <b>*Some of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		outputText("\n\n");
		enemyAI();
	}
	public function sendTemporalGolem10():void {
		flags[kFLAGS.TEMPORAL_GOLEMS_BAG] -= 10;
		var damage:Number = 0;
		var dmgamp:Number = 1;
		var overloadedGolemCoresBag:Boolean = false;
		var partialyoverloadedGolemCoresBag:Boolean = false;
		if (player.hasPerk(PerkLib.BeginnerGolemMaker)) damage += ((player.inte + player.wis) * 5);
		if (player.hasPerk(PerkLib.ApprenticeGolemMaker)) damage += ((player.inte + player.wis) * 6);
		if (player.hasPerk(PerkLib.ExpertGolemMaker)) damage += ((player.inte + player.wis) * 7);
		if (player.hasPerk(PerkLib.MasterGolemMaker)) damage += ((player.inte + player.wis) * 8);
		if (!overloadedGolemCoresBag) {
			if ((camp.campMake.maxReusableGolemCoresBagSize() - flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]) < 10) {
				flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] = camp.campMake.maxReusableGolemCoresBagSize();
				partialyoverloadedGolemCoresBag = true;
			}
		}
		damage += ((player.inte + player.wis + 300 + rand(121)) * 20);
		if (player.hasPerk(PerkLib.ChargedCore)) damage += ((300 + rand(121)) * 10);
		if (player.hasPerk(PerkLib.SuperChargedCore)) damage += ((300 + rand(121)) * 10);
		damage *= 10;
		dmgamp += temporalGolemsAplification();
		damage *= dmgamp;
		damage = Math.round(damage);
		outputText("Your stone golems slams into [themonster]. ");
		doDamage(damage, true, true);
		if (overloadedGolemCoresBag) outputText(" <b>*None of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		if (partialyoverloadedGolemCoresBag) outputText(" <b>*Some of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		outputText("\n\n");
		enemyAI();
	}
	public function sendTemporalGolem20():void {
		flags[kFLAGS.TEMPORAL_GOLEMS_BAG] -= 20;
		var damage:Number = 0;
		var dmgamp:Number = 1;
		var overloadedGolemCoresBag:Boolean = false;
		var partialyoverloadedGolemCoresBag:Boolean = false;
		if (player.hasPerk(PerkLib.BeginnerGolemMaker)) damage += ((player.inte + player.wis) * 5);
		if (player.hasPerk(PerkLib.ApprenticeGolemMaker)) damage += ((player.inte + player.wis) * 6);
		if (player.hasPerk(PerkLib.ExpertGolemMaker)) damage += ((player.inte + player.wis) * 7);
		if (player.hasPerk(PerkLib.MasterGolemMaker)) damage += ((player.inte + player.wis) * 8);
		if (!overloadedGolemCoresBag) {
			if ((camp.campMake.maxReusableGolemCoresBagSize() - flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]) < 20) {
				flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] = camp.campMake.maxReusableGolemCoresBagSize();
				partialyoverloadedGolemCoresBag = true;
			}
		}
		damage += ((player.inte + player.wis + 300 + rand(121)) * 20);
		if (player.hasPerk(PerkLib.ChargedCore)) damage += ((300 + rand(121)) * 10);
		if (player.hasPerk(PerkLib.SuperChargedCore)) damage += ((300 + rand(121)) * 10);
		damage *= 4;
		dmgamp += temporalGolemsAplification();
		damage *= dmgamp;
		damage = Math.round(damage);
		outputText("Your stone golems slams into [themonster]. ");
		doDamage(damage, true, true);
		if (overloadedGolemCoresBag) outputText(" <b>*None of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		if (partialyoverloadedGolemCoresBag) outputText(" <b>*Some of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		outputText("\n\n");
		enemyAI();
	}
	public function sendTemporalGolemKamikazeProtocol():void {
		clearOutput();
		var damage:Number = 0;
		var dmgamp:Number = 1;
		var overloadedGolemCoresBag:Boolean = false;
		var partialyoverloadedGolemCoresBag:Boolean = false;
		var usedGolems:Number = flags[kFLAGS.TEMPORAL_GOLEMS_BAG];
		if (player.hasPerk(PerkLib.BeginnerGolemMaker)) damage += ((player.inte + player.wis) * 5);
		if (player.hasPerk(PerkLib.ApprenticeGolemMaker)) damage += ((player.inte + player.wis) * 5);
		if (player.hasPerk(PerkLib.ExpertGolemMaker)) damage += ((player.inte + player.wis) * 5);
		if (player.hasPerk(PerkLib.MasterGolemMaker)) damage += ((player.inte + player.wis) * 5);
		flags[kFLAGS.TEMPORAL_GOLEMS_BAG] = 0;
		if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] + usedGolems < camp.campMake.maxReusableGolemCoresBagSize()) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] += usedGolems;
		else overloadedGolemCoresBag = true;
		if (!overloadedGolemCoresBag) {
			if ((camp.campMake.maxReusableGolemCoresBagSize() - flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]) < usedGolems) {
				flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] = camp.campMake.maxReusableGolemCoresBagSize();
				partialyoverloadedGolemCoresBag = true;
			}
		}
		damage += ((player.inte + player.wis + 300 + rand(121)) * 20);
		if (player.hasPerk(PerkLib.ChargedCore)) damage += ((300 + rand(121)) * 10);
		if (player.hasPerk(PerkLib.SuperChargedCore)) damage += ((300 + rand(121)) * 10);
		damage *= usedGolems;
		dmgamp += temporalGolemsAplification();
		damage *= dmgamp;
		damage = Math.round(damage);
		outputText("Your stone golems slams into [themonster]. ");
		doDamage(damage, true, true);
		if (overloadedGolemCoresBag) outputText(" <b>*None of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		if (partialyoverloadedGolemCoresBag) outputText(" <b>*Some of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		outputText("\n\n");
		enemyAI();
	}

	public function permanentgolemsendcost():Number {
		var permanentgolemsendcost:Number = 20;
		if (player.hasPerk(PerkLib.EpicGolemMaker)) permanentgolemsendcost += 10;
		if (player.hasPerk(PerkLib.EpicGolemMaker2ndCircle)) permanentgolemsendcost += 30;
		if (player.hasPerk(PerkLib.EpicGolemMaker3rdCircle)) permanentgolemsendcost += 80;
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 1) permanentgolemsendcost += 5;
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv4(StatusEffects.GolemUpgrades1) > 1) permanentgolemsendcost += 5;
		if (player.hasPerk(PerkLib.LegendaryGolemMaker2ndCircle)) permanentgolemsendcost *= 0.8;
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv1(StatusEffects.GolemUpgrades1) > 0) permanentgolemsendcost *= (1 + player.statusEffectv1(StatusEffects.GolemUpgrades1));
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv2(StatusEffects.GolemUpgrades1) > 0) permanentgolemsendcost *= (1 - (0.15 * player.statusEffectv2(StatusEffects.GolemUpgrades1)));//15% off each
		permanentgolemsendcost = Math.round(permanentgolemsendcost);
		return permanentgolemsendcost;
	}
	public function permanentimprovedgolemsendcost():Number {
		var permanentimprovedgolemsendcost:Number = 250;
		if (player.hasPerk(PerkLib.EpicGolemMaker2ndCircle)) permanentimprovedgolemsendcost += 150;
		if (player.hasPerk(PerkLib.EpicGolemMaker3rdCircle)) permanentimprovedgolemsendcost += 400;
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 1) permanentimprovedgolemsendcost += 50;
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv4(StatusEffects.GolemUpgrades1) > 1) permanentimprovedgolemsendcost += 50;
		if (player.hasPerk(PerkLib.LegendaryGolemMaker2ndCircle)) permanentimprovedgolemsendcost *= 0.8;
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv1(StatusEffects.GolemUpgrades1) > 0) permanentimprovedgolemsendcost *= (1 + player.statusEffectv1(StatusEffects.GolemUpgrades1));
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv2(StatusEffects.GolemUpgrades1) > 0) permanentimprovedgolemsendcost *= (1 - (0.15 * player.statusEffectv2(StatusEffects.GolemUpgrades1)));
		permanentimprovedgolemsendcost = Math.round(permanentimprovedgolemsendcost);
		return permanentimprovedgolemsendcost;
	}
	public function permanentsteelgolemsendcost():Number {
		var permanentsteelgolemsendcost:Number = 50;
		if (player.hasPerk(PerkLib.EpicGolemMaker)) permanentsteelgolemsendcost += 25;
		if (player.hasPerk(PerkLib.EpicGolemMaker2ndCircle)) permanentsteelgolemsendcost += 75;
		if (player.hasPerk(PerkLib.EpicGolemMaker3rdCircle)) permanentsteelgolemsendcost += 200;
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 1) permanentsteelgolemsendcost += 10;
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv4(StatusEffects.GolemUpgrades1) > 1) permanentsteelgolemsendcost += 10;
		if (player.hasPerk(PerkLib.LegendaryGolemMaker2ndCircle)) permanentsteelgolemsendcost *= 0.8;
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv1(StatusEffects.GolemUpgrades1) > 0) permanentsteelgolemsendcost *= (1 + player.statusEffectv1(StatusEffects.GolemUpgrades1));
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv2(StatusEffects.GolemUpgrades1) > 0) permanentsteelgolemsendcost *= (1 - (0.15 * player.statusEffectv2(StatusEffects.GolemUpgrades1)));
		permanentsteelgolemsendcost = Math.round(permanentsteelgolemsendcost);
		return permanentsteelgolemsendcost;
	}

	public function permanentimprovedsteelgolemsendcost():Number {
		var permanentimprovedsteelgolemsendcost:Number = 625;
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 1) permanentimprovedsteelgolemsendcost += 100;
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv4(StatusEffects.GolemUpgrades1) > 1) permanentimprovedsteelgolemsendcost += 100;
		if (player.hasPerk(PerkLib.LegendaryGolemMaker2ndCircle)) permanentimprovedsteelgolemsendcost *= 0.8;
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv1(StatusEffects.GolemUpgrades1) > 0) permanentimprovedsteelgolemsendcost *= (1 + player.statusEffectv1(StatusEffects.GolemUpgrades1));
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv2(StatusEffects.GolemUpgrades1) > 0) permanentimprovedsteelgolemsendcost *= (1 - (0.15 * player.statusEffectv2(StatusEffects.GolemUpgrades1)));
		permanentimprovedsteelgolemsendcost = Math.round(permanentimprovedsteelgolemsendcost);
		return permanentimprovedsteelgolemsendcost;
	}

	private function golemsDunks(damage:Number):void {
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 0) {
			if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 5) doDarknessDamage(damage, true, true);
			else if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 4) doLightningDamage(damage, true, true);
			else if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 3) doIceDamage(damage, true, true);
			else if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 2) doFireDamage(damage, true, true);
			else doDamage(damage, true, true);
		}
		else doDamage(damage, true, true);
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv1(StatusEffects.GolemUpgrades1) > 0) {
			if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 0) {
				if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 5) doDarknessDamage(damage, true, true);
				else if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 4) doLightningDamage(damage, true, true);
				else if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 3) doIceDamage(damage, true, true);
				else if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 2) doFireDamage(damage, true, true);
				else doDamage(damage, true, true);
			}
			else doDamage(damage, true, true);
			if (player.statusEffectv1(StatusEffects.GolemUpgrades1) > 1) {
				if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 0) {
					if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 5) doDarknessDamage(damage, true, true);
					else if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 4) doLightningDamage(damage, true, true);
					else if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 3) doIceDamage(damage, true, true);
					else if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 2) doFireDamage(damage, true, true);
					else doDamage(damage, true, true);
				}
				else doDamage(damage, true, true);
			}
		}
	}

	public function dmgamp_permanent_shared():Number {
		var dmgamp:Number = 0;
		if (player.hasPerk(PerkLib.GolemArmyJuniorLieutenant)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyLieutenant)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyCaptain)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyMajor)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyLieutenantColonel)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyColonel)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GrandMasterGolemMaker)) dmgamp += 0.15;
		if (player.hasPerk(PerkLib.EpicGolemMaker)) dmgamp += 0.375;
		if (player.hasPerk(PerkLib.EpicGolemMaker2ndCircle)) dmgamp += 0.9;
		if (player.hasPerk(PerkLib.EpicGolemMaker3rdCircle)) dmgamp += combat.intwisscaling() * 0.15;
		if (player.weapon == weapons.SCECOMM) dmgamp += 0.5;
		if (player.weapon == weapons.G_ROD) dmgamp += 0.75;
		if (player.weaponRange == weaponsrange.G_E_MAN) dmgamp += 0.5;
		if (player.shield == shields.Y_U_PAN) dmgamp += 0.25;
		if (flags[kFLAGS.WILL_O_THE_WISP] == 2) {
			dmgamp += 0.1;
			if (player.hasPerk(PerkLib.WispLieutenant)) dmgamp += 0.2;
			if (player.hasPerk(PerkLib.WispCaptain)) dmgamp += 0.3;
			if (player.hasPerk(PerkLib.WispMajor)) dmgamp += 0.4;
			if (player.hasPerk(PerkLib.WispColonel)) dmgamp += 0.5;
		}
		if (player.hasPerk(PerkLib.HistoryTactician) || player.hasPerk(PerkLib.PastLifeTactician)) dmgamp += (1 - combat.historyTacticianBonus());
		return dmgamp;
	}

	public function sendPermanentGolem(cnt:int = 1, doit:Boolean = false):void {
		if (cnt != 1 && cnt != 3 && cnt != 5) throw new Error("Invalid golem count!");
		if (!player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn)) clearOutput();
		else outputText("\n\n");
		if (player.mana < permanentgolemsendcost() * cnt) {
			outputText("Your mana is too low to make your golem attack.");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		else useMana(permanentgolemsendcost() * cnt);
		//base
		var damage:Number = (player.inte + player.wis + 500 + rand(201)) * 2;
		var dmgamp:Number = 1;
		dmgamp += dmgamp_permanent_shared();
		if ((player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv2(StatusEffects.GolemUpgrades1) > 0)) damage *= (1 + (player.statusEffectv2(StatusEffects.GolemUpgrades1) * 0.25));
		//count
		if (cnt == 3) damage *= 5;
		else if (cnt == 5) damage *= 10;
		//mult-round
		damage *= dmgamp;
		damage = Math.round(damage);
		outputText("Your stone golem" + (cnt > 1 ? "s slam" : " slams") + " into [themonster]. ");
		golemsDunks(damage);
		outputText("\n\n");
		//set flag that golems attacked
		flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] = 1;
		if (!player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn)) {
			menu();
			addButton(0, "Next", combatMenu, false);
		}
		if (doit) enemyAI();
	}

	public function sendPermanentImprovedGolem(cnt:int = 1, doit:Boolean = false):void {
		if (cnt != 1 && cnt != 3 && cnt != 5) throw new Error("Invalid golem count!");
		if (!player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn)) clearOutput();
		else outputText("\n\n");
		if (player.mana < permanentimprovedgolemsendcost() * cnt) {
			outputText("Your mana is too low to make your golem attack.");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		else useMana(permanentimprovedgolemsendcost() * cnt);
		var damage:Number = ((player.inte + player.wis + 1500 + rand(501)) * 10);
		var dmgamp:Number = 1;
		dmgamp += dmgamp_permanent_shared();
		dmgamp *= 2;
		if ((player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv2(StatusEffects.GolemUpgrades1) > 0)) damage *= (1 + (player.statusEffectv2(StatusEffects.GolemUpgrades1) * 0.25));
		//count
		if (cnt == 3) damage *= 5;
		else if (cnt == 5) damage *= 10;
		//mult-round
		damage *= dmgamp;
		damage = Math.round(damage);
		outputText("Your improved stone golem" + (cnt > 1 ? "s slam" : " slams") + " into [themonster]. ");
		golemsDunks(damage);
		outputText(" And then attack" + (cnt > 1 ? "" : "s") + " once again. ");
		golemsDunks(damage);
		outputText("\n\n");
		//set flag that golems attacked
		flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] = 1;
		if (!player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn)) {
			menu();
			addButton(0, "Next", combatMenu, false);
		}
		if (doit) enemyAI();
	}

	public function sendPermanentSteelGolem(cnt:int = 1, doit:Boolean = false):void {
		if (cnt != 1 && cnt != 3 && cnt != 5) throw new Error("Invalid golem count!");
		if (!player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn)) clearOutput();
		else outputText("\n\n");
		if (player.mana < permanentsteelgolemsendcost() * cnt) {
			outputText("Your mana is too low to make your golem attack.");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		else useMana(permanentsteelgolemsendcost() * cnt);
		var damage:Number = ((player.inte + player.wis + 750 + rand(251)) * 5);
		var dmgamp:Number = 1;
		dmgamp += dmgamp_permanent_shared();
		dmgamp *= 1.2;
		if ((player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv2(StatusEffects.GolemUpgrades1) > 0)) damage *= (1 + (player.statusEffectv2(StatusEffects.GolemUpgrades1) * 0.25));
		//count
		if (cnt == 3) damage *= 5;
		else if (cnt == 5) damage *= 10;
		//mult-round
		damage *= dmgamp;
		damage = Math.round(damage);
		outputText("Your steel golem" + (cnt > 1 ? "s slam" : " slams") + " into [themonster]. ");
		golemsDunks(damage);
		outputText("\n\n");
		//set flag that golems attacked
		flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] = 1;
		if (!player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn)) {
			menu();
			addButton(0, "Next", combatMenu, false);
		}
		if (doit) enemyAI();
	}

	public function sendPermanentImprovedSteelGolem(cnt:int = 1, doit:Boolean = false):void {
		if (cnt != 1 && cnt != 3 && cnt != 5) throw new Error("Invalid golem count!");
		if (!player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn)) clearOutput();
		else outputText("\n\n");
		if (player.mana < permanentimprovedsteelgolemsendcost() * cnt) {
			outputText("Your mana is too low to make your golem attack.");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		else useMana(permanentimprovedsteelgolemsendcost() * cnt);
		var damage:Number = ((player.inte + player.wis + 2250 + rand(751)) * 25);
		var dmgamp:Number = 1;
		dmgamp += dmgamp_permanent_shared();
		dmgamp *= 2.4;
		if ((player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv2(StatusEffects.GolemUpgrades1) > 0)) damage *= (1 + (player.statusEffectv2(StatusEffects.GolemUpgrades1) * 0.25));
		//count
		if (cnt == 3) damage *= 5;
		else if (cnt == 5) damage *= 10;
		//mult-round
		damage *= dmgamp;
		damage = Math.round(damage);
		outputText("Your improved steel golem" + (cnt > 1 ? "s slam" : " slams") + " into [themonster]. ");
		golemsDunks(damage);
		outputText(" Then attack" + (cnt > 1 ? "" : "s") + " second time. ");
		golemsDunks(damage);
		outputText(" And finish with a third round. ");
		golemsDunks(damage);
		outputText("\n\n");
		//set flag that golems attacked
		flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] = 1;
		if (!player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn)) {
			menu();
			addButton(0, "Next", combatMenu, false);
		}
		if (doit) enemyAI();
	}

	public function notSendAnyGolem():void {
		//set flag that golems attacked
		flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] = 1;
		//jump to the next since there were no outputs.
		if (!player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn))
			combatMenu(false);
	}

	public function AlraunePollen():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var pollen:Number = monster.lustVuln * (combat.calcHerbalismPower() * 0.05) * (2 + rand(4));
		if (player.headjewelryName == "pair of Golden Naga Hairpins") pollen *= 1.1;
		if (player.hasPerk(PerkLib.RacialParagon)) pollen *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) pollen *= 1.50;
		outputText("You send a cloud of your pollen outward into the air, smiling lustfully at your opponent. Sneezing slightly as they inhale the potent pollen, they begin showing clear signs of arousal. Just how long can they resist coming to pollinate you now? Not for long, you hope. ");
		monster.teased(pollen, false);
		outputText("\n\n");
		player.createStatusEffect(StatusEffects.AlraunePollen,0,0,0,0);
		enemyAI();
	}

	public function AlrauneEntangle():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("You coil your vines around [themonster]'s body, slowing them down and hindering ");
		if(!monster.plural) outputText("its");
		else outputText("their");
		outputText(" movement.\n\n");
		var EntangleNerf:Number;
		EntangleNerf = 0.5;
		if (player.hasPerk(PerkLib.RacialParagon)) EntangleNerf += 0.1;
		if (player.hasPerk(PerkLib.Apex)) EntangleNerf += 0.1;
		if (player.hasPerk(PerkLib.AlphaAndOmega)) EntangleNerf += 0.1;
		if (player.hasPerk(PerkLib.AscensionOneRaceToRuleThemAllX)) EntangleNerf += (0.1 * player.perkv1(PerkLib.AscensionOneRaceToRuleThemAllX));
		if (player.hasPerk(PerkLib.NaturalArsenal)) EntangleNerf += 0.1;
		player.createStatusEffect(StatusEffects.AlrauneEntangle,EntangleNerf,EntangleNerf,0,0);
		monster.statStore.addBuffObject({"str.mult":-EntangleNerf,"spe.mult":-EntangleNerf}, "EntangleNerf",{text:"EntangleNerf"});
		enemyAI();
	}

	public function AlrauneStrangulate():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(60, USEFATG_PHYSICAL);
		var damage:Number = 0;
		damage += player.tou;
		damage += scalingBonusToughness() * 0.5;
		if (player.hasPerk(PerkLib.VladimirRegalia)) damage *= 2;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
		damage = Math.round(damage);
		doDamage(damage);
		combat.WrathGenerationPerHit2(5);
		outputText("You tighten your vines around your opponent's neck to strangle it. [Themonster] struggles against your natural noose, getting obvious marks on its neck and " + damage + " damage for their trouble.\n\n");
		enemyAI();
	}

	public function blazingRocketKick():void {
		clearOutput();
		outputText("You propel yourself up and kick [themonster] in the face leaving burns in the process. ");
		var damage:Number = 0;
		damage += (combat.meleeUnarmedDamageNoLagSingle() * 2);
		damage *= (spellMod() * 2);
		damage = Math.round(damage);
		outputText(" ");
		doDamage(damage, true, true);
		doFireDamage(damage, true, true);
		damage *= 2;
		if (player.hasKeyItem("Nitro Boots") >= 0) {
			outputText(" Your foe catches on fire.");
			if (monster.hasStatusEffect(StatusEffects.BurnDoT)) monster.addStatusValue(StatusEffects.BurnDoT,1,1);
			else monster.createStatusEffect(StatusEffects.BurnDoT, 5, 0.05, 0, 0);
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		doNext(playerMenu);
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

	public function EggThrowLustDamageRepeat():void {
		if(rand(player.spe/2 + 40) + 20 > monster.spe/1.5) {
			var lustDmgF:Number = 20 + rand(6);
			var lustBoostToLustDmg:Number = 0;
			if (player.hasPerk(PerkLib.DeadlyThrow)) lustDmgF += (player.spe/100);
			if (player.hasPerk(PerkLib.SensualLover)) lustDmgF += 2;
			if (player.hasPerk(PerkLib.Seduction)) lustDmgF += 5;
			lustDmgF += player.teaseDmgStat.value;
			if (player.hasPerk(PerkLib.BimboBody) || player.hasPerk(PerkLib.BroBody) || player.hasPerk(PerkLib.FutaForm)) lustDmgF += 5;
			if (player.hasPerk(PerkLib.FlawlessBody)) lustDmgF += 10;
			lustDmgF += scalingBonusLibido() * 0.1;
			if (player.hasPerk(PerkLib.EromancyExpert)) lustDmgF *= 1.5;
			if (player.hasPerk(PerkLib.JobSeducer)) lustDmgF += player.teaseLevel * 3;
			else lustDmgF += player.teaseLevel * 2;
			if (player.hasPerk(PerkLib.JobCourtesan) && monster.hasPerk(PerkLib.EnemyBossType)) lustDmgF *= 1.2;
			switch (player.coatType()) {
				case Skin.FUR:
					lustDmgF += (1 + player.newGamePlusMod());
					break;
				case Skin.SCALES:
					lustDmgF += (2 * (1 + player.newGamePlusMod()));
					break;
				case Skin.CHITIN:
					lustDmgF += (3 * (1 + player.newGamePlusMod()));
					break;
				case Skin.BARK:
					lustDmgF += (4 * (1 + player.newGamePlusMod()));
					break;
			}
			if (player.hasPerk(PerkLib.SluttySimplicity) && player.armor.hasTag(ItemTags.A_REVEALING)) lustDmgF *= (1 + ((10 + rand(11)) / 100));
			if (player.hasPerk(PerkLib.ElectrifiedDesire)) lustDmgF *= (1 + (player.lust100 * 0.01));
			if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) lustDmgF *= (1 + combat.historyWhoreBonus());
			if (player.hasPerk(PerkLib.RacialParagon)) lustDmgF *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmgF *= 1.50;
			lustBoostToLustDmg += lustDmgF * 0.01;
			lustDmgF *= 0.2;
			if (player.lust100 * 0.01 >= 0.9) lustDmgF += (lustBoostToLustDmg * 140);
			else if (player.lust100 * 0.01 < 0.2) lustDmgF += (lustBoostToLustDmg * 140);
			else lustDmgF += (lustBoostToLustDmg * 2 * (20 - (player.lust100 * 0.01)));
			//Determine if critical tease!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combat.teases.combatTeaseCritical();
			if (player.hasPerk(PerkLib.AnatomyExpert)) critChance += 10;
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
			crit = true;
				if (!player.hasPerk(PerkLib.AnatomyExpert)) lustDmgF *= 1.75;
				if (player.hasPerk(PerkLib.AnatomyExpert)) lustDmgF *= 2.50;
			}
			if (player.hasPerk(PerkLib.ChiReflowLust)) lustDmgF *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
			if (player.hasPerk(PerkLib.ArouseTheAudience) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))) lustDmgF *= 1.5;
			if (player.armor == armors.ELFDRES && player.isElf()) lustDmgF*= 2;
			if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmgF *= 2;
			lustDmgF = lustDmgF * monster.lustVuln;
			lustDmgF = Math.round(lustDmgF);
			monster.teased(lustDmgF,false);
			if (crit) outputText(" <b>Critical!</b>");
			combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
			if (monster.lustVuln > 0 && !monster.hasPerk(PerkLib.EnemyTrueAngel)) {
				monster.lustVuln += 0.05;
				if (monster.lustVuln > 1) monster.lustVuln = 1;
			}
		}
		else {
			outputText("<b>([font-miss]Miss!</font>)</b>");
		}
		flags[kFLAGS.EASTER_BUNNY_EGGS_STORED]--;
		combat.bonusExpAfterSuccesfullTease();
	}

	public function EggthrowAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		//(if monster = demons)
		if(!monster.plural) outputText("You throw one of your stashed bunny eggs at [themonster] face! It explodes in a lewd mix of fluids covering [monster his] eyes and body with your unfertilised egg content.");
		else outputText("You throw one of your stashed bunny eggs up at one of [themonster]! It explodes in a lewd mix of fluids covering [monster his] eyes and body with your unfertilised egg content.");
		//React
		if(monster.lustVuln == 0) outputText("  Your opponent does not seem to be affected by it however.");
		else {
			if(monster.plural) outputText("  The one you hit flushes hotly, though the entire group seems to become more aroused in sympathy to their now-lusty compatriot.");
			else outputText("  " + monster.mf("He","She") + " flushes hotly and " + monster.mf("touches his suddenly-stiff member, moaning lewdly for a moment.","touches a suddenly stiff nipple, moaning lewdly.  You can smell her arousal in the air."));
			EggThrowLustDamageRepeat();
		}
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		if (!combatIsOver()) enemyAI();
	}

	public function OmniEggthrowAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		//(if monster = demons)
		if(!monster.plural) outputText("You begin throwing a barrage of your stashed bunny eggs at [themonster] face! They explodes in a lewd mix of fluids covering [monster his] eyes and body with your unfertilised egg content.");
		else outputText("You begin throwing a barrage of your stashed bunny eggs up at one of [themonster]! They explodes in a lewd mix of fluids covering [monster his] eyes and body with your unfertilised egg content.");
		//React
		if(monster.lustVuln == 0) outputText("  Your aphrodisiac toxin has no effect!");
		else {
			if(monster.plural) outputText("  The one you bit flushes hotly, though the entire group seems to become more aroused in sympathy to their now-lusty compatriot.");
			else outputText("  " + monster.mf("He","She") + " flushes hotly and " + monster.mf("touches his suddenly-stiff member, moaning lewdly for a moment.","touches a suddenly stiff nipple, moaning lewdly.  You can smell her arousal in the air."));
			EggThrowLustDamageRepeat();
			if (flags[kFLAGS.EASTER_BUNNY_EGGS_STORED] > 1) EggThrowLustDamageRepeat();
			var maxRangedAttacks:int = player.calculateMultiAttacks(false);
			if (maxRangedAttacks >= 2 && flags[kFLAGS.EASTER_BUNNY_EGGS_STORED] > 1){
				EggThrowLustDamageRepeat();
				if (flags[kFLAGS.EASTER_BUNNY_EGGS_STORED] > 1) EggThrowLustDamageRepeat();
			}
			if (maxRangedAttacks >= 3 && flags[kFLAGS.EASTER_BUNNY_EGGS_STORED] > 1){
				EggThrowLustDamageRepeat();
				if (flags[kFLAGS.EASTER_BUNNY_EGGS_STORED] > 1) EggThrowLustDamageRepeat();
			}
		}
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		if (!combatIsOver()) enemyAI();
	}


	public function StoneClawAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(120, USEFATG_PHYSICAL);
		else fatigue(60, USEFATG_PHYSICAL);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownStoneClaw,2,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownStoneClaw,3,0,0,0);
		var damage:Number = 0;
		damage += combat.meleeUnarmedDamageNoLagSingle(1);
		//addictive bonuses
		if (player.hasPerk(PerkLib.IronFistsI)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsII)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsIII)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsIV)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsV)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsVI)) damage += 10;
		if (player.hasPerk(PerkLib.JobBrawler)) damage += (5 * (1 + player.newGamePlusMod()));
		if (player.hasPerk(PerkLib.JobMonk)) damage += (10 * (1 + player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Berzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Lustzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		//multiplicative bonuses
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.JobBeastWarrior)) damage *= 1.1;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.hasPerk(PerkLib.OniTyrantKimono)) damage *= 2;
		if (player.hasPerk(PerkLib.OniEnlightenedKimono)) damage *= 1.5;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.Blademaster)) critChance += 5;
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
		}
		damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
		damage = Math.round(damage);
		doDamage(damage);
		outputText("You slash your adversary with your sharp stone claws, dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (crit) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}

	public function StoneFistAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(120, USEFATG_PHYSICAL);
		else fatigue(60, USEFATG_PHYSICAL);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownStoneFist,2,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownStoneFist,3,0,0,0);
		var damage:Number = 0;
		damage += combat.meleeUnarmedDamageNoLagSingle(1);
		//addictive bonuses
		if (player.hasPerk(PerkLib.IronFistsI)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsII)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsIII)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsIV)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsV)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsVI)) damage += 10;
		if (player.hasPerk(PerkLib.JobBrawler)) damage += (5 * (1 + player.newGamePlusMod()));
		if (player.hasPerk(PerkLib.JobMonk)) damage += (10 * (1 + player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Berzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Lustzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		//multiplicative bonuses
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.JobBeastWarrior)) damage *= 1.1;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.hasPerk(PerkLib.OniTyrantKimono)) damage *= 2;
		if (player.hasPerk(PerkLib.OniEnlightenedKimono)) damage *= 1.5;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= 1.6;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.Blademaster)) critChance += 5;
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
		}
		damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
		damage = Math.round(damage);
		doDamage(damage);
		outputText("You punch your adversary with your stone fist, dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (!monster.hasPerk(PerkLib.Resolute)) {
			outputText(" [Themonster] recoil under the blow!");
			monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		}
		if (crit) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}

	public function TailSlamAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(60, USEFATG_PHYSICAL);
		else fatigue(30, USEFATG_PHYSICAL);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownTailSlam,4,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownTailSlam,5,0,0,0);
		var damage:Number = 0;
		damage += combat.meleeUnarmedDamageNoLagSingle(1);
		//addictive bonuses
		if (player.hasPerk(PerkLib.JobBrawler)) damage += (5 * (1 + player.newGamePlusMod()));
		if (player.hasPerk(PerkLib.JobMonk)) damage += (10 * (1 + player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Berzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Lustzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		//multiplicative bonuses
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.JobBeastWarrior)) damage *= 1.1;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.hasPerk(PerkLib.OniTyrantKimono)) damage *= 2;
		if (player.hasPerk(PerkLib.OniEnlightenedKimono)) damage *= 1.5;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= 1.5;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.Blademaster)) critChance += 5;
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
		}
		damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
		damage = Math.round(damage);
		doDamage(damage);
		if (!monster.hasStatusEffect(StatusEffects.TailSlamWhip)) monster.createStatusEffect(StatusEffects.TailSlamWhip,monster.armorDef,5,0,0);
		//monster.armorDef == 0;
		outputText("You slam your mace-like tail on your foe, dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (!monster.hasPerk(PerkLib.Resolute)) {
			outputText(" The attack is so devastating your target is stunned by the crushing blow!");
			monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
		if (crit) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}

	public function TailCleaveAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(60, USEFATG_PHYSICAL);
		else fatigue(30, USEFATG_PHYSICAL);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownTailCleave,4,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownTailCleave,5,0,0,0);
		var damage:Number = 0;
		damage += combat.meleeUnarmedDamageNoLagSingle(1);
		//addictive bonuses
		if (player.hasPerk(PerkLib.JobBrawler)) damage += (5 * (1 + player.newGamePlusMod()));
		if (player.hasPerk(PerkLib.JobMonk)) damage += (10 * (1 + player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Berzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Lustzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		//multiplicative bonuses
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.JobBeastWarrior)) damage *= 1.1;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.hasPerk(PerkLib.OniTyrantKimono)) damage *= 2;
		if (player.hasPerk(PerkLib.OniEnlightenedKimono)) damage *= 1.5;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= 1.5;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.Blademaster)) critChance += 5;
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
		}
		damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
		damage = Math.round(damage);
		doDamage(damage);
		var multikulti:String = (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) ? "s" : "";
		outputText("You swipe the field with your axe-bladed tail, slicing your foe" + multikulti + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (!monster.isImmuneToBleed()) {
			outputText(" The attack leaves your target" + multikulti + " bleeding from deep wounds!");
			if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) monster.createStatusEffect(StatusEffects.SharkBiteBleed, 2, 5, 0, 0);
			monster.createStatusEffect(StatusEffects.SharkBiteBleed, 2, 0, 0, 0);
		}
		if (crit) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}

	public function WingBuffetAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(60, USEFATG_PHYSICAL);
		else fatigue(30, USEFATG_PHYSICAL);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownWingBuffet,5,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownWingBuffet,6,0,0,0);
		var damage:Number = 0;
		damage += combat.meleeUnarmedDamageNoLagSingle(1);
		//multiplicative bonuses
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.JobBeastWarrior)) damage *= 1.1;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.hasPerk(PerkLib.OniTyrantKimono)) damage *= 2;
		if (player.hasPerk(PerkLib.OniEnlightenedKimono)) damage *= 1.5;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= 1.5;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.Blademaster)) critChance += 5;
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
		}
		damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
		damage = Math.round(damage);
		doDamage(damage);
		outputText("You buffet your foe with your massive wings, dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (crit) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}

	public function TornadoStrike():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(120, USEFATG_PHYSICAL);
		else fatigue(60, USEFATG_PHYSICAL);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownTornadoStrike,7,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownTornadoStrike,8,0,0,0);
		var damage:Number = 0;
		//spe bonuses
		damage += player.spe;
		damage += scalingBonusSpeed();
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 1) damage *= 1.5;
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 2) damage *= 1.5;
		if (player.perkv1(IMutationsLib.HeartOfTheStormIM) >= 3) damage *= 1.5;
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage = Math.round(damage * combat.windDamageBoostedByDao());
		outputText("You start to channel power into your body unleashing it it into the form of a mighty swirling tornado. [Themonster] is caught in it and carried into the windstorm taking hit from various other flying objects. ");
		doWindDamage(damage);
		if (crit) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		enemyAI();
	}

	public function PCWebAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		//Keep logic sane if this attack brings victory
		player.tailVenom -= player.VenomWebCost() * 5;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LizanRogue) {
			outputText("As your webbing flies at him the lizan flips back, slashing at the adhesive strands with the claws on his hands and feet with practiced ease.  It appears he's used to countering this tactic.");
			enemyAI();
			return;
		}
		//Blind
		if(player.playerIsBlinded()) {
			outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ");
		}
		else outputText("Turning and clenching muscles that no human should have, you expel a spray of sticky webs at [themonster]!  ");
		//Determine if dodged!
		if((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) {
			outputText("You miss [themonster] completely - ");
			if(monster.plural) outputText("they");
			else outputText(monster.mf("he","she") + " moved out of the way!\n\n");
			enemyAI();
			return;
		}
		//Over-webbed
		if(monster.spe < 1) {
			if(!monster.plural) outputText("[Themonster] is completely covered in webbing, but you hose " + monster.mf("him","her") + " down again anyway.");
			else outputText("[Themonster] are completely covered in webbing, but you hose them down again anyway.");
		}
		//LAND A HIT!
		else {
			var Multiplier:Number = 1;
			if (player.perkv1(IMutationsLib.ArachnidBookLungIM) >= 2) Multiplier += 0.5;
			if (player.perkv1(IMutationsLib.ArachnidBookLungIM) >= 3) Multiplier += 0.5;
			if (player.hasPerk(PerkLib.RacialParagon)) Multiplier += 0.5;
			if (player.hasPerk(PerkLib.Apex)) Multiplier += 0.75;
			if (player.hasPerk(PerkLib.AlphaAndOmega)) Multiplier += 0.75;
			if (player.hasPerk(PerkLib.AscensionOneRaceToRuleThemAllX)) Multiplier += (0.25 * player.perkv1(PerkLib.AscensionOneRaceToRuleThemAllX));
			if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) Multiplier *= 2;
			if (!monster.plural) outputText("The adhesive strands cover [themonster] with restrictive webbing, greatly slowing " + monster.mf("him","her") + ". ");
			else outputText("The adhesive strands cover [themonster] with restrictive webbing, greatly slowing " + monster.mf("him","her") + ". ");
			monster.statStore.addBuffObject({spe:-45*Multiplier}, "Web",{text:"Web"});
			if(player.perkv1(IMutationsLib.ArachnidBookLungIM) >= 3){
				if(rand(100) > 50) {
					monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
				}
			}
		}
		awardAchievement("How Do I Shot Web?", kACHIEVEMENTS.COMBAT_SHOT_WEB);
		outputText("\n\n");
		if(!combatIsOver()) enemyAI();
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
		if(monster is EncapsulationPod) {
			clearOutput();
			outputText("You can't constrict something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10, USEFATG_PHYSICAL);
		if (combat.checkConcentration()) return; //Amily concentration
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
			player.takePhysDamage(5, true);
			if(player.HP <= player.minHP()) {
				doNext(endHpLoss);
				return;
			}
		}
		outputText("\n\n");
		enemyAI();
	}
	public function whipGrapple():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if(player.fatigue + physicalCost(10) > player.maxFatigue()) {
			clearOutput();
			outputText("You just don't have the energy to wrap your "+(player.weapon == weapons.D_FLAIL?"flail":"whip")+" so tightly around someone right now...");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if(monster is EncapsulationPod) {
			clearOutput();
			outputText("You can't constrict something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10, USEFATG_PHYSICAL);
		if (combat.checkConcentration()) return; //Amily concentration
		outputText("You entangle your opponent with your "+(player.weapon == weapons.D_FLAIL?"flail":"whip")+", attempting to bind its movement. ");
		//WRAP IT UPPP
		if(40 + rand(player.spe) > monster.spe) {
			outputText("[monster a] [monster name] is tied up!");
			monster.createStatusEffect(StatusEffects.ConstrictedWhip, 3 + rand(3),0,0,0);
		}
		//Failure
		else {
			//Failure (-10 HPs) -
			outputText("[monster a] [monster name] manage to avoid the binding! ");
			player.takePhysDamage(5, true);
			if(player.HP <= player.minHP()) {
				doNext(endHpLoss);
				return;
			}
		}
		outputText("\n\n");
		enemyAI();
	}

	public function orcaPlay():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (monster.plural) {
			outputText("You cannot play while fighting multiple opponents at the same times!");
			addButton(0, "Next", combatMenu, false);
		}
		else{
			if(player.fatigue + physicalCost(10) > player.maxFatigue()) {
				clearOutput();
				outputText("You just don't have the energy to start playing right now...");
				//Gone		menuLoc = 1;
				menu();
				addButton(0, "Next", combatMenu, false);
				return;
			}
			if(monster is EncapsulationPod) {
				clearOutput();
				outputText("You can't play with something you are inside off!");
				//Gone		menuLoc = 1;
				menu();
				addButton(0, "Next", combatMenu, false);
				return;
			}
			fatigue(10, USEFATG_PHYSICAL);
			if (combat.checkConcentration("[monster name] recovers just in time to get out of your reach as you attempt to grapple [monster him].")) return; //Amily concentration
			//WRAP IT UPPP
			outputText("You grab your opponent with your jaw while [monster he] is stunned inflicting grievous wounds before you toss [monster him] high in the air!");
			monster.createStatusEffect(StatusEffects.OrcaPlay, 0,0,0,0);
			player.createStatusEffect(StatusEffects.OrcaCanJuggleStill, 0,0,0,0);
			if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownPlay,14,0,0,0);
			else player.createStatusEffect(StatusEffects.CooldownPlay,15,0,0,0);
			player.createStatusEffect(StatusEffects.OrcaPlayRoundLeft,3,0,0,0);
			outputText("\n\n");
			enemyAI();
		}
	}
	
	public function buzzingTone():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 2) {
			outputText("You end your tune with a powerful finale, compelling your would-be incubator to surrender to your tender ministration.");
			var lustDmgF:Number = monster.lustVuln * 3 * (player.inte / 5 * (player.teaseLevel * 0.2) + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			if (player.hasPerk(PerkLib.EromancyExpert)) lustDmgF *= 1.5;
			if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) {
				if (player.hasPerk(PerkLib.ArouseTheAudience)) lustDmgF *= 7.5;
				else lustDmgF *= 5;
			}
			if (player.hasPerk(PerkLib.RacialParagon)) lustDmgF *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmgF *= 1.50;
			if (player.armor == armors.ELFDRES && player.isElf()) lustDmgF *= 2;
			if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmgF *= 2;
			lustDmgF *= 5;
			lustDmgF = Math.round(lustDmgF);
			monster.teased(lustDmgF);
			if(!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned,6,0,0,0);
			player.removeStatusEffect(StatusEffects.ChanneledAttack);
			player.removeStatusEffect(StatusEffects.ChanneledAttackType);
			outputText("\n\n");
			if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>\"Ouch. Such arcane skills for one so uncouth,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your magics?\"</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
				enemyAI();
			}
			else enemyAI();
		}
		else if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			outputText("You are still singing. Your compelling voice reaches far up to your opponent.");
			if(monster.plural) outputText("s");
			outputText(" ears.");
			var lustDmg2:Number = monster.lustVuln * (player.inte / 5 * (player.teaseLevel * 0.2) + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg2 *= 1.5;
			if (player.hasPerk(PerkLib.RacialParagon)) lustDmg2 *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmg2 *= 1.50;
			if (player.perkv1(IMutationsLib.MelkieLungIM) >= 1) lustDmg2 *= 1.2;
			if (player.perkv1(IMutationsLib.MelkieLungIM) >= 2) lustDmg2 *= 1.3;
			if (player.perkv1(IMutationsLib.MelkieLungIM) >= 3) lustDmg2 *= 1.4;
			if (player.armor == armors.ELFDRES && player.isElf()) lustDmg2 *= 2;
			if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg2 *= 2;
			lustDmg2 = Math.round(lustDmg2);
			monster.teased(lustDmg2);
			player.addStatusValue(StatusEffects.ChanneledAttack, 1, 1);
			outputText("\n\n");
			enemyAI();
		}
		else {
			fatigue(50, USEFATG_MAGIC_NOBM);
			clearOutput();
			outputText("You start singing an enrapturing song. Buzzing over enticingly.");
			var lustDmg:Number = monster.lustVuln * 0.5 * (player.inte / 5 * (player.teaseLevel * 0.2) + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg *= 1.5;
			if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmg *= 1.50;
			if (player.perkv1(IMutationsLib.MelkieLungIM) >= 1) lustDmg *= 1.2;
			if (player.perkv1(IMutationsLib.MelkieLungIM) >= 2) lustDmg *= 1.3;
			if (player.perkv1(IMutationsLib.MelkieLungIM) >= 3) lustDmg *= 1.4;
			if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
			if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
			lustDmg = Math.round(lustDmg);
			monster.teased(lustDmg);
			player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.ChanneledAttackType, 7, 0, 0, 0);
			outputText("\n\n");
			enemyAI();
		}
	}
	
	public function callKiha():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		fatigue(30, USEFATG_PHYSICAL);
		clearOutput();
		outputText("You mentally reach for your ring, and you feel a surge of anger, love and fear. You can all but feel Kiha’s wingbeats, the sensation making your own shoulder blades itch. You can’t relax, not with [enemy] in front of you, but you know that help is on the way!")
		player.createStatusEffect(StatusEffects.CallOutKiha, 0, 0, 0, 0);
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
		if(monster is EncapsulationPod) {
			clearOutput();
			outputText("You can't engulf something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10, USEFATG_PHYSICAL);
		if (combat.checkConcentration()) return; //Amily concentration
		outputText("You plunge on [themonster] and let your liquid body engulf it. ");
		//WRAP IT UPPP
		if(40 + rand(player.spe) > monster.spe) {
			outputText("[Themonster] ends up encased in your fluid form kicking and screaming to get out.");
			monster.createStatusEffect(StatusEffects.GooEngulf, 3 + rand(3),0,0,0);
		}
		//Failure
		else {
			//Failure (-10 HPs) -
			outputText("[Themonster] dodge at the last second stepping out of your slimy embrace and using the opening to strike you.");
			player.takePhysDamage(5, true);
			if(player.HP <= player.minHP()) {
				doNext(endHpLoss);
				return;
			}
		}
		outputText("\n\n");
		enemyAI();
	}

	public function vampireEmbrace():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if(player.fatigue + physicalCost(10) > player.maxFatigue()) {
			clearOutput();
			outputText("You're too tired to wrap your wings around enemy!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if(monster is EncapsulationPod) {
			clearOutput();
			outputText("You can't wrap your wings around something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10, USEFATG_PHYSICAL);
		monster.createStatusEffect(StatusEffects.EmbraceVampire, 3 + rand(3),0,0,0);
		if (player.hasStatusEffect(StatusEffects.Flying)) {
			outputText("You dive down at your target, wrapping your wings around [themonster] embracing [monster he] as you prepare to feast.");
			player.removeStatusEffect(StatusEffects.Flying);
			if (player.hasStatusEffect(StatusEffects.FlyingNoStun)) {
				player.removeStatusEffect(StatusEffects.FlyingNoStun);
				player.removePerk(PerkLib.Resolute);
			}
		}
		else outputText("You leap and box in [themonster] with your wings, embracing [monster he] as you prepare to feast.");
		outputText("\n\n");
		enemyAI();
	}

	public function catPounce():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.fatigue + physicalCost(10) > player.maxFatigue()) {
			clearOutput();
			outputText("You just don't have the energy to pounce at anyone right now...");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (monster is EncapsulationPod) {
			clearOutput();
			outputText("You can't pounce something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10, USEFATG_PHYSICAL);
		if (combat.checkConcentration()) return; //Amily concentration
		//WRAP IT UPPP
		if (40 + rand(player.spe) > monster.spe) {
			outputText("You growl menacingly, dropping on all four" + (player.tail.type != Tail.NONE ? " and flicking your tail" : "") + ", as you pounce on [themonster] clawing at [monster he] body and leaving deep bleeding wounds.");
			monster.createStatusEffect(StatusEffects.Pounce, 4 + rand(2),0,0,0);
		}
		//Failure
		else {
			//Failure (-10 HPs) -
			outputText("As you attempt to grapple your target it slips out of your reach delivering a glancing blow to your limbs. ");
			player.takePhysDamage(5, true);
			if(player.HP <= player.minHP()) {
				doNext(endHpLoss);
				return;
			}
		}
		outputText("\n\n");
		enemyAI();
	}

	public function arigeanCrunch():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.fatigue + physicalCost(100) > player.maxFatigue()) {
			clearOutput();
			outputText("You just don't have the energy to crunch at anyone right now...");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (monster is EncapsulationPod) {
			clearOutput();
			outputText("You can't crounch something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(100, USEFATG_PHYSICAL);
		if (combat.checkConcentration()) return; //Amily concentration
		outputText("You rush forward and bite down on your opponent with your extra mouth" + (player.tail.count > 1 ? "s" : "") + ".");
		if (40 + rand(player.spe) > monster.spe) {
			outputText("[Themonster]’s armor is broken from the force! Dealing ");
			var damage:Number = 0;
			damage += combat.meleeUnarmedDamageNoLagSingle();
			//addictive bonuses
			if (player.hasPerk(PerkLib.IronFistsI)) damage += 10;
			if (player.hasPerk(PerkLib.IronFistsII)) damage += 10;
			if (player.hasPerk(PerkLib.IronFistsIII)) damage += 10;
			if (player.hasPerk(PerkLib.IronFistsIV)) damage += 10;
			if (player.hasPerk(PerkLib.IronFistsV)) damage += 10;
			if (player.hasPerk(PerkLib.IronFistsVI)) damage += 10;
			if (player.hasPerk(PerkLib.JobBrawler)) damage += (5 * (1 + player.newGamePlusMod()));
			if (player.hasPerk(PerkLib.JobMonk)) damage += (10 * (1 + player.newGamePlusMod()));
			if (player.hasStatusEffect(StatusEffects.Berzerking)) damage += (30 + (15 * player.newGamePlusMod()));
			if (player.hasStatusEffect(StatusEffects.Lustzerking)) damage += (30 + (15 * player.newGamePlusMod()));
			//multiplicative bonuses
			if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
			if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
			if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
			if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
			if (player.hasPerk(PerkLib.JobBeastWarrior)) damage *= 1.1;
			if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
			if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
			if (player.armor == armors.SPKIMO) damage *= 1.2;
			if (player.hasPerk(PerkLib.OniTyrantKimono)) damage *= 2;
			if (player.hasPerk(PerkLib.OniEnlightenedKimono)) damage *= 1.5;
			if (player.necklace == necklaces.OBNECK) damage *= 1.2;
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			damage *= 1.6;
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combat.combatPhysicalCritical();
			if (player.hasPerk(PerkLib.Blademaster)) critChance += 5;
			if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
			if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				var buffMultiplier:Number = 0;
				buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
				if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
				else damage *= (1.75 + buffMultiplier);
			}
			damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
			damage = Math.round(damage);
			doDamage(damage, true, true);
			outputText(" damage!");
			if (monster.hasStatusEffect(StatusEffects.DefPDebuff)) monster.addStatusValue(StatusEffects.DefPDebuff, 1, 1);
			else {
				var debuff:Number = Math.round(monster.armorDef * 0.3);
				monster.armorDef -= debuff;
				monster.createStatusEffect(StatusEffects.DefPDebuff, 3, debuff, 0, 0);
			}
			if (player.armor == armors.P_REGAL) HPChange(Math.round(damage*0.15), true);
		}
		else outputText("[Themonster] moves back just in time to avoid being crushed.");
		outputText("\n\n");
		enemyAI();
	}
	
	public function arigeanRam():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.fatigue + physicalCost(100) > player.maxFatigue()) {
			clearOutput();
			outputText("You just don't have the energy to ram anyone right now...");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (monster is EncapsulationPod) {
			clearOutput();
			outputText("You can't ram something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(100, USEFATG_PHYSICAL);
		if (combat.checkConcentration()) return; //Amily concentration
		outputText("You charge your opponent with the intent of ramming them with your large tail-like mouth. ");
		if (40 + rand(player.spe) > monster.spe) {
			outputText(" You hit your opponent hard! Causing them to take ");
			var damage:Number = 0;
			damage += combat.meleeUnarmedDamageNoLagSingle(2);
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
			damage = Math.round(damage);
			doDamage(damage, true, true);
			outputText(" damage! You also are hurt from the recoil. ");
			player.takePhysDamage(Math.round(player.maxHP() * 0.1), true);
			outputText("\n\n");
			combat.WrathGenerationPerHit2(5);
			combat.heroBaneProc(damage);
			combat.EruptingRiposte();
		}
		else outputText("[Themonster] swiftly step out of the way, causing you to charge past [monster him].");
		enemyAI();
	}

	public function bearGrab():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.fatigue + physicalCost(10) > player.maxFatigue()) {
			clearOutput();
			outputText("You just don't have the energy to grab at anyone right now...");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (monster is EncapsulationPod) {
			clearOutput();
			outputText("You can't grab something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (monster.tallness > player.tallness) {
			clearOutput();
			outputText("The opponent is too big for you to grapple it.");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return
		}
		fatigue(10, USEFATG_PHYSICAL);
		outputText("You attempt to slam both of your powerful forepaws on [themonster]. ");
		if (combat.checkConcentration()) return; //Amily concentration
		//WRAP IT UPPP
		if (40 + rand(player.spe) > monster.spe) {
			outputText("You land both paws on [themonster] with brutal power using your claws to grab [monster him].");
			monster.createStatusEffect(StatusEffects.GrabBear, 4 + rand(2),0,0,0);
		}
		//Failure
		else outputText("Your opponent seeing it coming dodge to the side as you smash the ground where [monster he] used to stand.");
		outputText("\n\n");
		enemyAI();
	}

	public function bearSlam():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if ((player.hasPerk(PerkLib.PhantomStrike) && (player.fatigue + physicalCost(60) > player.maxFatigue())) || (!player.hasPerk(PerkLib.PhantomStrike) && (player.fatigue + physicalCost(30) > player.maxFatigue()))) {
			clearOutput();
			outputText("You just don't have the energy to slap anyone right now...");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (monster is EncapsulationPod) {
			clearOutput();
			outputText("You can't slap something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(60, USEFATG_PHYSICAL);
		else fatigue(30, USEFATG_PHYSICAL);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownSlamBear,7,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownSlamBear,8,0,0,0);
		if (combat.checkConcentration()) return; //Amily concentration
		var damage:Number = 0;
		damage += combat.meleeUnarmedDamageNoLagSingle(1);
		//addictive bonuses
		if (player.hasPerk(PerkLib.IronFistsI)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsII)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsIII)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsIV)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsV)) damage += 10;
		if (player.hasPerk(PerkLib.IronFistsVI)) damage += 10;
		if (player.hasPerk(PerkLib.JobBrawler)) damage += (5 * (1 + player.newGamePlusMod()));
		if (player.hasPerk(PerkLib.JobMonk)) damage += (10 * (1 + player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Berzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Lustzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		//multiplicative bonuses
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.JobBeastWarrior)) damage *= 1.1;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.hasPerk(PerkLib.OniTyrantKimono)) damage *= 2;
		if (player.hasPerk(PerkLib.OniEnlightenedKimono)) damage *= 1.5;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= 1.6;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.Blademaster)) critChance += 5;
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
		}
		damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
		damage = Math.round(damage);
		doDamage(damage);
		outputText("You slam [themonster] with your full strength, crushing it under your weight. [Themonster] tries to recover but is stunned and grievously wounded by your assault. (<b><font color=\"#800000\">" + damage + "</font></b>)");
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		if (crit) {
		outputText(" <b>*Critical Hit!*</b>");
		if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		monster.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
		outputText("\n\n");
		enemyAI();
	}

	public function skyPounce():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if ((player.hasPerk(PerkLib.PhantomStrike) && (player.fatigue + physicalCost(20) > player.maxFatigue())) || (!player.hasPerk(PerkLib.PhantomStrike) && (player.fatigue + physicalCost(10) > player.maxFatigue()))) {
			clearOutput();
			outputText("You just don't have the energy to grapple with anyone right now...");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (monster is EncapsulationPod) {
			clearOutput();
			outputText("You can't land into something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(20, USEFATG_PHYSICAL);
		else fatigue(10, USEFATG_PHYSICAL);
		if (combat.checkConcentration()) return; //Amily concentration
		//WRAP IT UPPP
		if (40 + rand(player.spe) > monster.spe) {
			var damage:Number = 0;
			damage += combat.meleeUnarmedDamageNoLagSingle(2);
			//addictive bonuses
			if (player.hasPerk(PerkLib.IronFistsI)) damage += 10;
			if (player.hasPerk(PerkLib.IronFistsII)) damage += 10;
			if (player.hasPerk(PerkLib.IronFistsIII)) damage += 10;
			if (player.hasPerk(PerkLib.IronFistsIV)) damage += 10;
			if (player.hasPerk(PerkLib.IronFistsV)) damage += 10;
			if (player.hasPerk(PerkLib.IronFistsVI)) damage += 10;
			if (player.hasPerk(PerkLib.JobBrawler)) damage += (5 * (1 + player.newGamePlusMod()));
			if (player.hasPerk(PerkLib.JobMonk)) damage += (10 * (1 + player.newGamePlusMod()));
			if (player.hasStatusEffect(StatusEffects.Berzerking)) damage += (30 + (15 * player.newGamePlusMod()));
			if (player.hasStatusEffect(StatusEffects.Lustzerking)) damage += (30 + (15 * player.newGamePlusMod()));
			//multiplicative bonuses
			if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
			if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
			if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
			if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
			if (player.hasPerk(PerkLib.JobBeastWarrior)) damage *= 1.1;
			if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
			if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
			if (player.armor == armors.SPKIMO) damage *= 1.2;
			if (player.hasPerk(PerkLib.OniTyrantKimono)) damage *= 2;
			if (player.hasPerk(PerkLib.OniEnlightenedKimono)) damage *= 1.5;
			if (player.necklace == necklaces.OBNECK) damage *= 1.2;
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combat.combatPhysicalCritical();
			if (player.hasPerk(PerkLib.Blademaster)) critChance += 5;
			if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
			if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				var buffMultiplier:Number = 0;
				buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
				if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
				else damage *= (1.75 + buffMultiplier);
			}
			damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
			damage = Math.round(damage);
			doDamage(damage);
			if (player.hasPerk(PerkLib.PhantomStrike)) {
				doDamage(damage);
				damage *= 2;
			}
			outputText("You growl menacingly, and fold your wings, as you dive into [themonster] clawing at [monster him] body and leaving deep bleeding wounds dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!. You’re now grappling with your target ready to tear it to shreds.");
			if (crit) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
			}
			if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
				if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
				else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
			}
			checkAchievementDamage(damage);
			outputText("\n\n");
			combat.WrathGenerationPerHit2(5);
			combat.heroBaneProc(damage);
			combat.EruptingRiposte();
			monster.createStatusEffect(StatusEffects.Pounce, 4 + rand(2), 0, 0, 0);
			player.removeStatusEffect(StatusEffects.Flying);
			if (player.hasStatusEffect(StatusEffects.FlyingNoStun)) {
				player.removeStatusEffect(StatusEffects.FlyingNoStun);
				player.removePerk(PerkLib.Resolute);
			}
		}
		//Failure
		else {
			//Failure (-10 HPs) -
			outputText("As you attempt to grapple your target it slips out of your reach delivering a glancing blow to your limbs. Unable to grab your opponent flap your wing and resume flight.");
			combat.WrathGenerationPerHit2(5);
			player.takePhysDamage(5, true);
			if(player.HP <= player.minHP()) {
				doNext(endHpLoss);
				return;
			}
		}
		outputText("\n\n");
		enemyAI();
	}

	public function hydraBiteAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("Your fangs can't even penetrate the giant's flesh.");
			enemyAI();
			return;
		}
		fatigue((10 * player.statusEffectv1(StatusEffects.HydraTailsPlayer)), USEFATG_PHYSICAL);
		//Works similar to bee stinger, must be regenerated over time. Shares the same poison-meter
		outputText("You stand up erect and pull back for a second only to dart out at with all your " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " heads at [themonster] rending flesh and delivering your deadly venom in the process. ");
		hydraBiteAttackpoweeeeer();
		hydraBiteAttackpoweeeeer();
		if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 3) hydraBiteAttackpoweeeeer();
		if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 4) hydraBiteAttackpoweeeeer();
		if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 5) hydraBiteAttackpoweeeeer();
		if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 6) hydraBiteAttackpoweeeeer();
		if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 7) hydraBiteAttackpoweeeeer();
		if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 8) hydraBiteAttackpoweeeeer();
		if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 9) hydraBiteAttackpoweeeeer();
		if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 10) hydraBiteAttackpoweeeeer();
		if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 11) hydraBiteAttackpoweeeeer();
		if (player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 12) hydraBiteAttackpoweeeeer();
		//The following is how the enemy reacts over time to poison. It is displayed after the description paragraph,instead of lust
		var d1Bdcc:Number = 2;
		if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) d1Bdcc *= 2;
		monster.statStore.addBuffObject({str:-d1Bdcc,spe:-d1Bdcc}, "Poison",{text:"Poison"});
		if(monster.hasStatusEffect(StatusEffects.NagaVenom))
		{
			monster.addStatusValue(StatusEffects.NagaVenom,2,2);
			monster.addStatusValue(StatusEffects.NagaVenom,1,d1Bdcc);
		}
		else monster.createStatusEffect(StatusEffects.NagaVenom,d1Bdcc,2,0,0);
		if (player.hasPerk(PerkLib.WoundPoison)){
			if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
			else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
		}
		outputText("\n\n");
		player.tailVenom -= player.VenomWebCost() * 5;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		if (!combatIsOver()) enemyAI();
	}
	public function hydraBiteAttackpoweeeeer():void {
		var HBD:Number = 0;
		HBD += combat.meleeUnarmedDamageNoLagSingle();
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) HBD *= 1.5;
		if (player.hasPerk(PerkLib.RacialParagon)) HBD *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) HBD *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) HBD *= 2;
		HBD *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
		HBD = Math.round(HBD);
		doDamage(HBD, true, true);
		combat.WrathGenerationPerHit2(5);
	}
	public function nagaBiteAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (combat.checkConcentration()) return; //Amily concentration
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
			else outputText("You lunge at the foe headfirst, fangs bared. You manage to catch [themonster] off guard, your needle-like fangs penetrating deep into [monster his] body. You quickly release your venom, and retreat before [monster he] manages to react.");
			//The following is how the enemy reacts over time to poison. It is displayed after the description paragraph,instead of lust
			var d2Bdcc:Number = 2;
			if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) d2Bdcc *= 2;
			monster.statStore.addBuffObject({str:-d2Bdcc,spe:-d2Bdcc}, "Poison",{text:"Poison"});

			//Check weither its snakebite or apophis
			var venomType:StatusEffectType = StatusEffects.NagaVenom;
			if (player.racialScore(Races.APOPHIS) >= 20) venomType = StatusEffects.ApophisVenom;
			if(monster.hasStatusEffect(venomType))
			{
				monster.addStatusValue(venomType,2,2);
				monster.addStatusValue(venomType,1,d2Bdcc);
			}
			else monster.createStatusEffect(venomType,d2Bdcc,2,0,0);
		}
		else {
			outputText("You lunge headfirst, fangs bared. Your attempt fails horrendously, as [themonster] manages to counter your lunge, knocking your head away with enough force to make your ears ring.");
		}
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		player.tailVenom -= player.VenomWebCost() * 5;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		if (!combatIsOver()) enemyAI();
	}

	public function spiderBiteAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (combat.checkConcentration()) return; //Amily concentration
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
				if(!monster.plural) outputText("You lunge at the foe headfirst, fangs bared. You manage to catch [themonster] off guard, your needle-like fangs penetrating deep into [monster his] body. You quickly release your venom, and retreat before " + monster.a + monster.pronoun1 + " manages to react.");
				else outputText("You lunge at the foes headfirst, fangs bared. You manage to catch one of [themonster] off guard, your needle-like fangs penetrating deep into [monster his] body. You quickly release your venom, and retreat before " + monster.a + monster.pronoun1 + " manage to react.");
			}
			//React
			if(monster.lustVuln == 0) outputText("  Your aphrodisiac toxin has no effect!");
			else {
				var d3Bdcc:Number = 1;
				if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) d3Bdcc *= 2;
				if (player.lowerBody == LowerBody.ATLACH_NACHA){
					if (monster.plural) outputText("  The one you bit flushes hotly, though the entire group seems to become more aroused in sympathy to their now-lusty compatriot.");
					else outputText("  [monster He] flushes hotly and " + monster.mf("touches his suddenly-stiff member, moaning lewdly for a moment.", "touches a suddenly stiff nipple, moaning lewdly.  You can smell her arousal in the air."));
					var lustDmg2:Number = 35 + rand(player.lib / 10);
					var poisonScaling:Number = 1;
					poisonScaling += player.lib/100;
					poisonScaling += player.tou/100;
					if (player.level < 10) lustDmg2 += 20 + (player.level * 3);
					else if (player.level < 20) lustDmg2 += 50 + (player.level - 10) * 2;
					else if (player.level < 30) lustDmg2 += 70 + (player.level - 20) * 1;
					else lustDmg2 += 80;
					if (player.hasPerk(PerkLib.RacialParagon)) lustDmg2 *= combat.RacialParagonAbilityBoost();
					if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmg2 *= 1.50;
					if (player.armor == armors.ELFDRES && player.isElf()) lustDmg2 *= 2;
					if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg2 *= 2;
					lustDmg2 *= 0.2;
					lustDmg2 *= d3Bdcc;
					lustDmg2 *= 1+(poisonScaling/10);
					poisonScaling *= d3Bdcc;
					monster.teased(Math.round(monster.lustVuln * lustDmg2), true);
					combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
					monster.statStore.addBuffObject({tou:-poisonScaling}, "Poison",{text:"Poison"});
					if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
						monster.addStatusValue(StatusEffects.NagaVenom, 3, d3Bdcc);
					} else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, d3Bdcc, 0);
					if (player.hasPerk(PerkLib.WoundPoison)){
						if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10);
						else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
					}
				} else {
					if (monster.plural) outputText("  The one you bit flushes hotly, though the entire group seems to become more aroused in sympathy to their now-lusty compatriot.");
					else outputText("  [monster He] flushes hotly and " + monster.mf("touches his suddenly-stiff member, moaning lewdly for a moment.", "touches a suddenly stiff nipple, moaning lewdly.  You can smell her arousal in the air."));
					var lustDmg:Number = 35 + rand(player.lib / 10);
					if (player.hasPerk(PerkLib.RacialParagon)) lustDmg *= combat.RacialParagonAbilityBoost();
					if (player.hasPerk(PerkLib.NaturalArsenal)) lustDmg *= 1.50;
					lustDmg *= d3Bdcc;
					monster.teased(Math.round(monster.lustVuln * lustDmg), true);
					combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
					if (monster.lustVuln > 0 && !monster.hasPerk(PerkLib.EnemyTrueAngel)) {
						monster.lustVuln += 0.05;
						if (monster.lustVuln > 1) monster.lustVuln = 1;
					}
				}
			}
		}
		else {
			outputText("You lunge headfirst, fangs bared. Your attempt fails horrendously, as [themonster] manages to counter your lunge, pushing you back out of range.");
		}
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		player.tailVenom -= player.VenomWebCost() * 5;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		if (!combatIsOver()) enemyAI();
	}
	public function antBiteAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("Your "+(player.faceType == Face.ANT ? "mandibles":"fangs")+" can't even penetrate the giant's flesh.");
			enemyAI();
			return;
		}
		//Works similar to bee stinger, must be regenerated over time. Shares the same poison-meter
		if(rand(player.spe/2 + 40) + 20 > monster.spe/1.5) {
			//(if monster = demons)
			if(monster.short == "demons") outputText("You look at the crowd for a moment, wondering which of their number you should bite. Your glance lands upon the leader of the group, easily spotted due to his snakeskin cloak. You quickly dart through the demon crowd as it closes in around you and lunge towards the broad form of the leader. You catch the demon off guard and sink your "+(player.faceType == Face.ANT ? "mandibles":"fangs")+" into his flesh. You quickly release your formic acid and retreat before he, or the rest of the group manage to react.");
			//(Otherwise)
			else outputText("You lunge at the foe headfirst, "+(player.faceType == Face.ANT ? "mandibles":"fangs")+" bared. You manage to catch [themonster] off guard, your "+(player.faceType == Face.ANT ? "mandibles":"fangs")+", penetrating into [monster his] body. You quickly release your formic acid, and retreat before [monster he] manages to react.");
			//The following is how the enemy reacts over time to formic acid. It is displayed after the description paragraph,instead of lust
			var d4Bdcc:Number = 2;
			if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) d4Bdcc *= 2;
			monster.statStore.addBuffObject({str:-d4Bdcc,spe:-d4Bdcc}, "AntBurn",{text:"AntBurn"});
			//Check weither its snakebite or apophis
			if (monster.hasStatusEffect(StatusEffects.AntAcid)) monster.addStatusValue(StatusEffects.AntAcid,1,1);
			else monster.createStatusEffect(StatusEffects.AntAcid,10,0.02,0,0);
		}
		else {
			outputText("You lunge headfirst, "+(player.faceType == Face.ANT ? "mandibles out":"fangs bared")+". Your attempt fails horrendously, as [themonster] manages to counter your lunge, knocking your head away with enough force to make your ears ring.");
		}
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		player.tailVenom -= player.VenomWebCost() * 5;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		if (!combatIsOver()) enemyAI();
	}
	public function devastatingBiteAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("Your razor sharp teeth cannot penetrate the stone of a statue");
			enemyAI();
			return;
		}
		//Works similar to bee stinger, must be regenerated over time. Shares the same poison-meter
		if(rand(player.spe/2 + 40) + 20 > monster.spe/1.5) {
			//(if monster = demons)
			if(monster.short == "demons") outputText("You look at the crowd for a moment, wondering which of their number you should bite. Your glance lands upon the leader of the group, easily spotted due to his snakeskin cloak. You quickly dart through the demon crowd as it closes in around you and lunge towards the broad form of the leader. You catch the demon off guard and sink your fangs into his flesh. You quickly release your formic acid and retreat before he, or the rest of the group manage to react. ");
			//(Otherwise)
			else outputText("You lunge at the foe, intending to bite [monster him] with your circular set of razor-sharp teeth. You manage to catch [themonster] off guard, your fangs, penetrating into [monster his] body. Your acidic spit coating [monster him] before [monster he] manages to react. ");
			//The following is how the enemy reacts over time to acid. It is displayed after the description paragraph
			monster.statStore.addBuffObject({tou:-2,spe:-2}, "Sandworm Spit",{text:"Sandworm Spit"});
			combat.ExtraNaturalWeaponPrep();
			combat.ExtraNaturalWeaponAttack(10, "acid");
			if (!monster.hasStatusEffect(StatusEffects.SandWormAcid))
				monster.createStatusEffect(StatusEffects.SandWormAcid, 2, 0, 0, 0);
			monster.addStatusValue(StatusEffects.SandWormAcid, 2, 2);
		}
		else {
			outputText("You lunge headfirst, maw agape and your ring of teeth glistening. Your attempt fails horrendously as [themonster] manages to leap out of the away, and you impact the ground with enough force to make your ears ring.");
		}
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		if (!combatIsOver()) enemyAI();
	}
	public function fenrirFrostbite():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		//FATIIIIGUE
		if(player.fatigue + physicalCost(100) > player.maxFatigue()) {
			clearOutput();
			outputText("You just don't have the energy to bite something right now...");
//Pass false to combatMenu instead:		menuLoc = 1;
//		doNext(combatMenu);
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(100, USEFATG_PHYSICAL);
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster is LivingStatue)
		{
			outputText("Your fangs can't even penetrate the giant's flesh.");
			enemyAI();
			return;
		}
		//Frostbite for Fenrir
		if(rand(player.spe/2 + 40) + 20 > monster.spe/1.5 || monster.hasStatusEffect(StatusEffects.Constricted)) {
			//(if monster = demons)
			if(monster.short == "demons") outputText("You look at the crowd for a moment, wondering which of their number you should bite. Your glance lands upon the leader of the group, easily spotted due to his snakeskin cloak. You quickly dart through the demon crowd as it closes in around you and lunge towards the broad form of the leader. You manage to catch the demon off guard, biting it viciously. The merciless cold of your bite transfer to your foe weakening it as you retreat before he manages to react.");
			//(Otherwise)
			else outputText("You lunge at the foe headfirst, maw open for a bite. You manage to catch the [themonster] off guard, biting it viciously. The merciless cold of your bite transfer to your foe weakening it as you retreat before [monster he] manages to react.");
			//The following is how the enemy reacts over time to poison. It is displayed after the description paragraph,instead of lust
			monster.statStore.addBuffObject({str:-50,spe:-50}, "Poison",{text:"Poison"});
			if (monster.hasStatusEffect(StatusEffects.Frostbite)) monster.addStatusValue(StatusEffects.Frostbite,1,1);
			else monster.createStatusEffect(StatusEffects.Frostbite, 1, 0, 0, 0);
			var damage:Number = 0;
			//Determine damage - str modified by enemy toughness!
			damage = 0;
			damage += combat.meleeUnarmedDamageNoLagSingle();
			if (!monster.isImmuneToBleed()) {
				if (!monster.hasStatusEffect(StatusEffects.SharkBiteBleed)) monster.createStatusEffect(StatusEffects.SharkBiteBleed,15,0,0,0);
				else {
					monster.removeStatusEffect(StatusEffects.SharkBiteBleed);
					monster.createStatusEffect(StatusEffects.SharkBiteBleed,15,0,0,0);
				}
			}
			//Deal damage and update based on perks
			if(damage > 0) {
				if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
				if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
				if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
				if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
				damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
				damage = Math.round(damage);
				doDamage(damage);
			}
		}
		else {
			outputText("You lunge headfirst, maw open for a bite. Your attempt fails horrendously, as [themonster] manages to counter your lunge, knocking your head away with enough force to make your ears ring.");
		}
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if (!combatIsOver()) enemyAI();
	}

	//Mantis Omni Slash (AoE attack)
	public function mantisMultiSlash():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			if (monster.plural) {
				if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 2) fatigue(100, USEFATG_PHYSICAL);
				else fatigue(120, USEFATG_PHYSICAL);
			}
			else {
				if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 2) fatigue(40, USEFATG_PHYSICAL);
				else fatigue(48, USEFATG_PHYSICAL);
			}
		}
		else {
			if (monster.plural) {
				if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 2) fatigue(50, USEFATG_PHYSICAL);
				else fatigue(60, USEFATG_PHYSICAL);
			}
			else {
				if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 2) fatigue(20, USEFATG_PHYSICAL);
				else fatigue(24, USEFATG_PHYSICAL);
			}
		}
		if (combat.checkConcentration()) return; //Amily concentration
		outputText("You ready your wrists mounted scythes and prepare to sweep them towards [themonster].\n\n");
		if ((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) {
			if (monster.spe - player.spe < 8) outputText("[Themonster] narrowly avoids your attacks!\n\n");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText("[Themonster] dodges your attacks with superior quickness!\n\n");
			if (monster.spe - player.spe >= 20) outputText("[Themonster] deftly avoids your slow attacks.\n\n");
			enemyAI();
			return;
		}
		if (monster.plural) {
			if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 1) {
				if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 2 && player.perkv1(IMutationsLib.TrachealSystemIM) >= 2) {
					if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 3 && player.perkv1(IMutationsLib.TrachealSystemIM) >= 3) flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 15;
					else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 10;
				}
				else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 6;
			}
			else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 3;

		}
		else {
			if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 3 && player.perkv1(IMutationsLib.TrachealSystemIM) >= 3) flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 2;
			else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 1;
		}
		mantisMultipleAttacks();
	}
	public function mantisMultipleAttacks():void {
		var damage:Number = 0;
		damage += combat.meleeUnarmedDamageNoLagSingle(2);
		//adjusting to be used 60/100% of base speed while attacking depending on insect-related perks possesed
		if (!player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 1) damage *= 0.6;
		//bonuses if fighting multiple enemies
		if (monster.plural) {
			if (!player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 1 && !player.perkv1(IMutationsLib.TrachealSystemIM) >= 2) damage *= 1.1;
			if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 1 && player.perkv1(IMutationsLib.TrachealSystemIM) >= 2) damage *= 1.5;
		}
		//other bonuses
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 5;
			if (player.inte > 100) critChance += 10;
		}
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
		}
		damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
		doDamage(damage);
		outputText("Your scythes swiftly sweeps against [themonster], dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (crit) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		outputText("\n");
		combat.WrathGenerationPerHit2(5);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] >= 1) {
			flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
			mantisMultipleAttacks();
			return;
		}
		outputText("\n");
		enemyAI();
	}
//Gore Attack - uses 25 fatigue!
	public function goreAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (monster is WormMass) {
			outputText("Taking advantage of your new natural ");
			if (player.horns.type == Horns.COW_MINOTAUR || player.horns.type == Horns.KIRIN || player.horns.type == Horns.BICORN || player.horns.type == Horns.FROSTWYRM) outputText("weapons, ");
			else outputText("weapon, ");
			outputText("you quickly charge at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving your ");
			if (player.horns.type == Horns.COW_MINOTAUR || player.horns.type == Horns.KIRIN || player.horns.type == Horns.BICORN || player.horns.type == Horns.FROSTWYRM) outputText("horns ");
			else outputText("horn, ");
			outputText("to stab only at air.\n\n");
			enemyAI();
			return;
		}
		if ((player.hasPerk(PerkLib.PhantomStrike) && (player.fatigue + physicalCost(50) > player.maxFatigue())) || (!player.hasPerk(PerkLib.PhantomStrike) && (player.fatigue + physicalCost(25) > player.maxFatigue()))) {
			outputText("You're too fatigued to use a charge attack!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(50, USEFATG_PHYSICAL);
		else fatigue(25, USEFATG_PHYSICAL);
		var damage:Number = 0;
		if (combat.checkConcentration()) return; //Amily concentration
		//Bigger horns = better success chance.
		//Small horns - 60% hit
		if(player.horns.count >= 6 && player.horns.count < 12) {
			var chance:Number = 60;
		}
		//bigger horns - 75% hit
		if(player.horns.count >= 12 && player.horns.count < 20) {
			chance = 75;
		}
		//huge horns - 90% hit
		if(player.horns.count >= 20) {
			chance = 80;
		}
		//Vala dodgy bitch!
		if(monster is Vala) {
			chance = 20;
		}
		//Account for monster speed - up to -50%.
		if (monster.spe <= 100) chance -= monster.spe / 2;
		else chance -= 50;
		//Account for player speed - up to +50%
		if (player.spe <= 100) chance += player.spe / 2;
		else chance += 50;
		//Hit & calculation
		if (chance >= rand(100)) {
			var horns:Number = player.horns.count;
			if (player.horns.count > 40) player.horns.count = 40;
			//Determine damage - str modified by enemy toughness!
			damage = 0;
			damage += ((combat.meleeUnarmedDamageNoLagSingle() + horns) * 2);
			if (!monster.hasStatusEffect(StatusEffects.GoreBleed)) monster.createStatusEffect(StatusEffects.GoreBleed,16,0,0,0);
			else {
				monster.removeStatusEffect(StatusEffects.GoreBleed);
				monster.createStatusEffect(StatusEffects.GoreBleed,16,0,0,0);
			}
			//normal
			if (rand(4) > 0) {
				outputText("You lower your head and charge, skewering [themonster] on ");
				if (player.horns.type == Horns.COW_MINOTAUR) outputText("one of your bullhorns! ");
				else outputText("your horn"+(player.horns.type == Horns.BICORN ? "s":"")+"! ");
			}
			//CRIT
			else {
				//doubles horns bonus damage
				damage *= 2;
				outputText(" You lower your head and charge, slamming into [themonster] and burying "+((player.horns.type == Horns.BICORN || player.horns.type == Horns.COW_MINOTAUR) ? "both your horns":"your horn")+" into [monster him]! <b>Critical hit!</b> ");
			}
			//Bonus damage for rut!
			if (player.inRut && monster.cockTotal() > 0) {
				outputText("The fury of your rut lent you strength, increasing the damage! ");
				damage *= 1.1;
			}
			//Deal damage and update based on perks
			if (damage > 0) {
				if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
				if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
					if (player.isRaceCached(Races.MOUSE, 2) && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
					else damage *= 2;
				}
				damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
			}
			//Different horns damage messages
			if (damage < 25) outputText(" You pull yourself free, dealing  damage.");
			if (damage >= 25 && damage < 100) outputText(" You struggle to pull your horn"+((player.horns.type == Horns.BICORN || player.horns.type == Horns.COW_MINOTAUR) ? "s":"")+" free, dealing  damage.");
			if (damage >= 100) outputText(" With great difficulty you rip your horn"+((player.horns.type == Horns.BICORN || player.horns.type == Horns.COW_MINOTAUR) ? "s":"")+" free, dealing  damage.");
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
				damage = Math.round(damage * combat.fireDamageBoostedByDao());
				doFireDamage(damage, true, true);
			}
			else if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
				doDamage(damage, true, true);
				damage = Math.round(damage * combat.fireDamageBoostedByDao());
				doFireDamage(Math.round(damage*0.1), true, true);
				if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
				damage = Math.round(damage * 1.1);
			}
			else doDamage(damage, true, true);
			if (player.hasPerk(PerkLib.PhantomStrike)) {
				if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) doFireDamage(damage, true, true);
				else if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
					doDamage(damage, true, true);
					doFireDamage(Math.round(damage*0.1), true, true);
					if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
					damage = Math.round(damage * 1.1);
				}
				else doDamage(damage, true, true);
				damage *= 2;
			}
			outputText(" damage.");
		}
		//Miss
		else {
			//Special vala changes
			if(monster is Vala) {
				outputText("You lower your head and charge Vala, but she just flutters up higher, grabs hold of your horn"+((player.horns.type == Horns.BICORN || player.horns.type == Horns.COW_MINOTAUR) ? "s":"")+" as you close the distance, and smears her juicy, fragrant cunt against your nose.  ");
				outputText("The sensual smell and her excited moans stun you for a second, allowing her to continue to use you as a masturbation aid, but she quickly tires of such foreplay and flutters back with a wink.\n\n");
				dynStats("lus", 5);
			}
			else outputText("You lower your head and charge [themonster], only to be sidestepped at the last moment!");
		}
		//New line before monster attack
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		//Victory ORRRRR enemy turn.
		if(monster.HP > 0 && monster.lust < monster.maxOverLust()) enemyAI();
		else {
			if(monster.HP <= monster.minHP()) doNext(endHpVictory);
			if(monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		}
	}

	//Gore Attack - uses 25 fatigue!
	public function thunderGoreAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownThunderGore,7,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownThunderGore,8,0,0,0);
		//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (monster is WormMass) {
			outputText("Taking advantage of your new natural ");
			if (player.horns.type == Horns.COW_MINOTAUR || player.horns.type == Horns.KIRIN || player.horns.type == Horns.BICORN || player.horns.type == Horns.FROSTWYRM) outputText("weapons, ");
			else outputText("weapon, ");
			outputText("you quickly charge at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving your ");
			if (player.horns.type == Horns.COW_MINOTAUR || player.horns.type == Horns.KIRIN || player.horns.type == Horns.BICORN || player.horns.type == Horns.FROSTWYRM) outputText("horns ");
			else outputText("horn, ");
			outputText("to stab only at air.\n\n");
			enemyAI();
			return;
		}
		if ((player.hasPerk(PerkLib.PhantomStrike) && (player.fatigue + physicalCost(50) > player.maxFatigue())) || (!player.hasPerk(PerkLib.PhantomStrike) && (player.fatigue + physicalCost(25) > player.maxFatigue()))) {
			outputText("You're too fatigued to use a charge attack!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(50, USEFATG_PHYSICAL);
		else fatigue(25, USEFATG_PHYSICAL);
		var damage:Number = 0;
		if (combat.checkConcentration()) return; //Amily concentration
		//Bigger horns = better success chance.
		//Small horns - 60% hit
		if(player.horns.count >= 6 && player.horns.count < 12) {
			var chance:Number = 60;
		}
		//bigger horns - 75% hit
		if(player.horns.count >= 12 && player.horns.count < 20) {
			chance = 75;
		}
		//huge horns - 90% hit
		if(player.horns.count >= 20) {
			chance = 80;
		}
		//Vala dodgy bitch!
		if(monster is Vala) {
			chance = 20;
		}
		//Account for monster speed - up to -50%.
		if (monster.spe <= 100) chance -= monster.spe / 2;
		else chance -= 50;
		//Account for player speed - up to +50%
		if (player.spe <= 100) chance += player.spe / 2;
		else chance += 50;
		//Hit & calculation
		if (chance >= rand(100)) {
			var horns:Number = player.horns.count;
			if (player.horns.count > 40) player.horns.count = 40;
			//Determine damage - str modified by enemy toughness!
			damage = 0;
			damage += ((combat.meleeUnarmedDamageNoLagSingle() + horns) * 2);
			if (!monster.hasStatusEffect(StatusEffects.GoreBleed)) monster.createStatusEffect(StatusEffects.GoreBleed,16,0,0,0);
			else {
				monster.removeStatusEffect(StatusEffects.GoreBleed);
				monster.createStatusEffect(StatusEffects.GoreBleed,16,0,0,0);
			}
			if (!monster.hasStatusEffect(StatusEffects.Stunned)) monster.createStatusEffect(StatusEffects.Stunned,3,0,0,0);else {
				monster.removeStatusEffect(StatusEffects.Stunned);
				monster.createStatusEffect(StatusEffects.Stunned,3,0,0,0);
			}
			//normal
			if (rand(4) > 0) {
				outputText("You lower your head and charge, skewering [themonster] on your lightning horn!");
			}
			//CRIT
			else {
				//doubles horns bonus damage
				damage *= 2;
				outputText("You lower your head and charge, slamming into [themonster] and burying your lightning horn into [monster him] delivering a devastating discharge of electricity! <b>Critical hit!</b>  ");
			}
			//Bonus damage for rut!
			if (player.inRut && monster.cockTotal() > 0) {
				outputText("The fury of your rut lent you strength, increasing the damage!  ");
				damage *= 1.1;
			}
			//Deal damage and update based on perks
			if (damage > 0) {
				if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
				damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
			}
			//Different horns damage messages
			if (damage < 25) outputText("You pull yourself free, dealing  damage.");
			if (damage >= 25 && damage < 100) outputText("You struggle to pull your horn"+((player.horns.type == Horns.BICORN || player.horns.type == Horns.COW_MINOTAUR) ? "s":"")+" free, dealing  damage.");
			if (damage >= 100) outputText("With great difficulty you rip your horn"+((player.horns.type == Horns.BICORN || player.horns.type == Horns.COW_MINOTAUR) ? "s":"")+" free, dealing  damage.");
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			doDamage(damage, true, true);
			doLightningDamage(Math.round(damage*0.1), true, true);
			if (player.hasPerk(PerkLib.PhantomStrike)) {
				doDamage(damage, true, true);
				doLightningDamage(Math.round(damage*0.1), true, true);
				damage *= 2;
			}
			outputText(" damage.");
		}
		//Miss
		else {
			//Special vala changes
			if(monster is Vala) {
				outputText("You lower your head and charge Vala, but she just flutters up higher, grabs hold of your horn"+((player.horns.type == Horns.BICORN || player.horns.type == Horns.COW_MINOTAUR) ? "s":"")+" as you close the distance, and smears her juicy, fragrant cunt against your nose.  ");
				outputText("The sensual smell and her excited moans stun you for a second, allowing her to continue to use you as a masturbation aid, but she quickly tires of such foreplay and flutters back with a wink.\n\n");
				dynStats("lus", 5);
			}
			else outputText("You lower your head and charge [themonster], only to be sidestepped at the last moment!");
		}
		//New line before monster attack
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		//Victory ORRRRR enemy turn.
		if(monster.HP > 0 && monster.lust < monster.maxOverLust()) enemyAI();
		else {
			if(monster.HP <= monster.minHP()) doNext(endHpVictory);
			if(monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		}
	}
	//Upheaval Attack
	public function upheavalAttack():void {
		clearOutput();
	//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (monster is WormMass) {
			outputText("Taking advantage of your new natural weapon, you quickly charge at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving your horns to stab only at air.\n\n");
			enemyAI();
			return;
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(30, USEFATG_PHYSICAL);
		else fatigue(15, USEFATG_PHYSICAL);
		var damage:Number = 0;
		if (combat.checkConcentration()) return; //Amily concentration
		//Bigger horns = better success chance.
		//Small horns - 60% hit
		if(player.horns.count >= 6 && player.horns.count < 12) {
			var chance:Number = 60;
		}
		//bigger horns - 75% hit
		if(player.horns.count >= 12 && player.horns.count < 20) {
			chance = 75;
		}
		//huge horns - 90% hit
		if(player.horns.count >= 20) {
			chance = 80;
		}
		//Vala dodgy bitch!
		if(monster is Vala) {
			chance = 20;
		}
		//Account for monster speed - up to -50%.
		chance -= monster.spe/2;
		//Account for player speed - up to +50%
		chance += player.spe/2;
		//Hit & calculation
		if(chance >= rand(100)) {
			damage = 0;
			damage += ((combat.meleeUnarmedDamageNoLagSingle() + player.horns.count) * 1.2); //As normal attack + horns length bonus
			if(damage < 0) damage = 5;
			//Normal
			outputText("You hurl yourself towards [enemy] with your head low and jerk your head upward, every muscle flexing as you send [enemy] flying. ");
			//Critical
			var crit:Boolean = false;
			var critChance:int = 5;
			if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
				if (player.inte <= 100) critChance += (player.inte - 50) / 5;
				if (player.inte > 100) critChance += 10;
			}
			if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			//CAP 'DAT SHIT
			if (damage > player.level * 10 + 100) damage = player.level * 10 + 100;
			if (damage > 0) {
				if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
					if (player.isRaceCached(Races.MOUSE, 2) && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
					else damage *= 2;
				}
				damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
				//Round it off
				damage = int(damage);
				if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
				if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
				if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
				if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
					damage = Math.round(damage * combat.fireDamageBoostedByDao());
					doFireDamage(damage, true, true);
				}
				else if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
					doDamage(damage, true, true);
					damage = Math.round(damage * combat.fireDamageBoostedByDao());
					doFireDamage(Math.round(damage*0.1), true, true);
					if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
					damage = Math.round(damage * 1.1);
				}
				else doDamage(damage, true, true);
				if (player.hasPerk(PerkLib.PhantomStrike)) {
					if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) doFireDamage(damage, true, true);
					else if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
						doDamage(damage, true, true);
						doFireDamage(Math.round(damage*0.1), true, true);
						if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
						damage = Math.round(damage * 1.1);
					}
					else doDamage(damage, true, true);
					damage *= 2;
				}
			}
			if (crit) outputText("<b>Critical hit! </b>");
			outputText("\n\n");
		}
		//Miss
		else {
			//Special vala changes
			if(monster is Vala) {
				outputText("You lower your head and charge Vala, but she just flutters up higher, grabs hold of your horns as you close the distance, and smears her juicy, fragrant cunt against your nose.  The sensual smell and her excited moans stun you for a second, allowing her to continue to use you as a masturbation aid, but she quickly tires of such foreplay and flutters back with a wink.\n\n");
				dynStats("lus", 5);
			}
			else outputText("You hurl yourself towards [enemy] with your head low and snatch it upwards, hitting nothing but air.");
		}
		//New line before monster attack
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		//Victory ORRRRR enemy turn.
		if(monster.HP > 0 && monster.lust < monster.maxOverLust()) enemyAI();
		else {
			if(monster.HP <= monster.minHP()) doNext(endHpVictory);
			if(monster.lust >= monster.maxOverLust()) doNext(endLustVictory);
		}
	}
//Player sting attack
	public function playerStinger():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		//Keep logic sane if this attack brings victory
		//Worms are immune!
		if (monster is WormMass) {
			outputText("Taking advantage of your new natural weapons, you quickly thrust your stinger at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving you to stab only at air.\n\n");
			enemyAI();
			return;
		}
		//Determine if dodged!
		if (combat.checkConcentration()) return; //Amily concentration
		if(monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80) {
			if(monster.spe - player.spe < 8) outputText("[Themonster] narrowly avoids your stinger!\n\n");
			else if(monster.spe-player.spe < 20) outputText("[Themonster] dodges your stinger with superior quickness!\n\n");
			else outputText("[Themonster] deftly avoids your slow attempts to sting [monster him].\n\n");
			enemyAI();
			return;
		}
		//determine if avoided with armor.
		if(monster.armorDef - player.level >= 10 && rand(4) > 0) {
			outputText("Despite your best efforts, your sting attack can't penetrate [themonster]'s defenses.\n\n");
			enemyAI();
			return;
		}
		//Sting successful!
		outputText("Searing pain lances through [themonster] as you manage to sting [monster him]!  ");
		if(monster.plural) outputText("You watch as [monster he] stagger back a step and nearly trip, flushing hotly.");
		else outputText("You watch as [monster he] staggers back a step and nearly trips, flushing hotly.");
		var dBd3c:Number = 1;
		if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) dBd3c *= 2;
		if (player.tailType == 6) {
			var damage:Number = 35 + rand(player.lib/10);
			//Level adds more damage up to a point (level 30)
			if (player.level < 10) damage += player.level * 3;
			else if (player.level < 20) damage += 30 + (player.level - 10) * 2;
			else if (player.level < 30) damage += 50 + (player.level - 20) * 1;
			else damage += 60;
			damage += 20;
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			if (player.armor == armors.ELFDRES && player.isElf()) damage *= 2;
        	if (player.armor == armors.FMDRESS && player.isWoodElf()) damage *= 2;
			damage *= dBd3c;
			monster.teased(Math.round(monster.lustVuln * damage));
		}
		if (player.isSandWorm()) {
			monster.statStore.addBuffObject({str: -20}, "Sandworm Sting", {text: "Sandworm Sting"});
			if (!monster.hasStatusEffect(StatusEffects.LustDoT))
				monster.createStatusEffect(StatusEffects.LustDoT, 3, 0.05, 0, 0);
			else {
				monster.addStatusValue(StatusEffects.LustDoT, 1, 2);
				monster.addStatusValue(StatusEffects.LustDoT, 2, 0.1);
			}
		} else {
			if (player.tailType == Tail.SCORPION) {
				monster.statStore.addBuffObject({spe: -(dBd3c * 10)}, "Poison", {text: "Poison"});
			}
			if (monster.hasStatusEffect(StatusEffects.BeeVenom)) {
				monster.addStatusValue(StatusEffects.BeeVenom, 3, (dBd3c * 5));
			} else monster.createStatusEffect(StatusEffects.BeeVenom, 0, 0, (dBd3c * 5), 0);
			/*	if(!monster.hasStatusEffect(StatusEffects.lustvenom)) monster.createStatusEffect(StatusEffects.lustvenom, 0, 0, 0, 0);
             IT used to paralyze 50% of the time, this is no longer the case!
             Paralise the other 50%!
             else {
             outputText("Searing pain lances through [themonster] as you manage to sting [monster him]!  ");
             if(monster.short == "demons") outputText("You watch as [monster he] stagger back a step and nearly trip, finding it hard to move as [monster he] are afflicted with your paralytic venom.  ");
             else outputText("You watch as [monster he] staggers back a step and nearly trips, finding it hard to move as [monster he] is afflicted with your paralytic venom.  ");
             if(monster.short == "demons") outputText("It appears that [themonster] are weaker and slower.");
             else outputText("It appears that [themonster] is weaker and slower.");
             monster.str -= (5+rand(player.lib/5))
             monster.spe -= (5+rand(player.lib/5))
             if(monster.str < 1) monster.str = 1;
             if(monster.spe < 1) monster.spe = 1;
             }*/
		}
		//New line before monster attack
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		//Use tail mp
		player.tailVenom -= player.VenomWebCost() * 5;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		//Kick back to main if no damage occured!
		if(monster.HP > 0 && monster.lust < monster.maxOverLust()) enemyAI();
		else doNext(endLustVictory);
	}
//Player tail spike attack

	public function tailspikedamage():void{
		//Phys dmg!
		var damage:Number = 0;
		damage += combat.meleeUnarmedDamageNoLagSingle();
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.perkv1(IMutationsLib.ManticoreMetabolismIM) >= 3) damage *= 2;
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= combat.rangePhysicalForce();
		if (player.level < 10) damage += 20 + (player.level * 3);
		else if (player.level < 20) damage += 50 + (player.level - 10) * 2;
		else if (player.level < 30) damage += 70 + (player.level - 20) * 1;
		else damage += 80;
		//Lust damage!
		var lustdamage:Number = combat.teases.teaseBaseLustDamage();
		if (player.hasPerk(PerkLib.JobSeducer)) lustdamage += player.teaseLevel * 3;
		if (player.hasPerk(PerkLib.RacialParagon)) lustdamage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) lustdamage *= 1.50;
		if (player.perkv1(IMutationsLib.ManticoreMetabolismIM) >= 3) lustdamage *= 2;
		//Determine if critical!
		var crit:Boolean = false;
		var critChance:Number;
		critChance = combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			lustdamage *= 1.75;
			damage *= 1.75;
		}
		damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
		//Do all damage
		damage = Math.round(damage);
		doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>"); //Damage
		var dBd1c:Number = 1;
		if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) dBd1c *= 2;
		monster.teased(Math.round(monster.lustVuln * lustdamage * dBd1c), false);
		combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		if (crit) outputText(" <b>Critical!</b>");
		monster.statStore.addBuffObject({spe:-(dBd1c*10)}, "Poison",{text:"Poison"});
		if (monster.hasStatusEffect(StatusEffects.ManticoreVenom)) monster.addStatusValue(StatusEffects.ManticoreVenom,3,(dBd1c*5));
		else monster.createStatusEffect(StatusEffects.ManticoreVenom, 0, 0, (dBd1c*5), 0);
		//if (!monster.hasStatusEffect(StatusEffects.lustvenom)) monster.createStatusEffect(StatusEffects.lustvenom, 0, 0, 0, 0);
		//New line before monster attack
		monster.statStore.addBuffObject({spe:-((2+rand(3))*dBd1c)}, "Poison",{text:"Poison"});
		//Use tail mp
		player.tailVenom -= player.VenomWebCost() * 5;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
	}

	public function playerTailSpike():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		//Worms are immune!
		if (monster is WormMass) {
			outputText("Taking advantage of your new natural weapons, you quickly shoot an envenomed spike at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving your spike impale the ground behind.\n\n");
			enemyAI();
			return;
		}
		//Determine if dodged!
		if (combat.checkConcentration()) return; //Amily concentration
		if(monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80) {
			if(monster.spe - player.spe < 8) outputText("[Themonster] narrowly avoids your spike!\n\n");
			if(monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText("[Themonster] dodges your spike with superior quickness!\n\n");
			if(monster.spe - player.spe >= 20) outputText("[Themonster] deftly avoids your slow attempts to hit with a spike [monster him].\n\n");
			enemyAI();
			return;
		}
		//determine if avoided with armor.
		if(monster.armorDef - player.level >= 10 && rand(4) > 0) {
			outputText("Despite your best efforts, your spike attack can't penetrate [themonster]'s defenses.\n\n");
			enemyAI();
			return;
		}
		//Sting successful!
		outputText("You drop on all fours, flinging your tail forward and shooting an envenomed spike at [themonster].");
		tailspikedamage();
		outputText("\n\n");
		if(monster.HP > 0 && monster.lust < monster.maxOverLust()) enemyAI();
		else doNext(endLustVictory);
	}

	//Player Omni tail spike attack
	public function playerOmniTailSpike():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (monster is WormMass) {
			outputText("Taking advantage of your new natural weapons, you quickly shoot a flurry of envenomed spike at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving your spike impale the ground behind.\n\n");
			enemyAI();
			return;
		}
		//Determine if dodged!
		if (combat.checkConcentration()) return; //Amily concentration
		if (monster.spe - player.spe > 0 && int(Math.random()*(((monster.spe-player.spe)/4)+80)) > 80) {
			if (monster.spe - player.spe >= 20) outputText("[Themonster] deftly avoids your slow attempts to hit with a spike [monster him].\n\n");
			else if (monster.spe - player.spe >= 8) outputText("[Themonster] dodges your spike with superior quickness!\n\n");
			else outputText("[Themonster] narrowly avoids your spike!\n\n");
			enemyAI();
			return;
		}
		//determine if avoided with armor.
		if(monster.armorDef - player.level >= 10 && rand(4) > 0) {
			outputText("Despite your best efforts, your spikes can't penetrate [themonster]'s defenses.\n\n");
			enemyAI();
			return;
		}
		//Sting successful!
		outputText("You drop on all fours, flinging your tail forward and shooting a volley of envenomed spike at [themonster].");

		//deal damage repeatedly
		tailspikedamage();
		tailspikedamage();
		if (player.hasPerk(PerkLib.WeaponClawsClawTraining) && player.tailVenom >= player.VenomWebCost() * 5) tailspikedamage();
		if (player.hasPerk(PerkLib.WeaponClawsExtraClawAttack) && player.tailVenom >= player.VenomWebCost() * 5) tailspikedamage();
		if (player.hasPerk(PerkLib.WeaponClawsMultiClawAttack) && player.tailVenom >= player.VenomWebCost() * 5) tailspikedamage();
		if (player.hasPerk(PerkLib.WeaponClawsClawingFlurry) && player.tailVenom >= player.VenomWebCost() * 5) tailspikedamage();
		if (player.hasPerk(PerkLib.WeaponClawsSavageRend) && player.tailVenom >= player.VenomWebCost() * 5) tailspikedamage();
		if ((player.hasPerk(PerkLib.HistoryFeral) || player.hasPerk(PerkLib.PastLifeFeral)) && player.tailVenom >= player.VenomWebCost() * 5) tailspikedamage();
		outputText("\n\n");
		if(monster.HP > 0 && monster.lust < monster.maxOverLust()) enemyAI();
		else doNext(endLustVictory);
	}


	public function kissAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		clearOutput();
		var attack:Number = rand(6);
		switch(attack) {
			case 1:
				//Attack text 1:
				outputText("You hop up to [themonster] and attempt to plant a kiss on [monster his].");
				break;
				//Attack text 2:
			case 2:
				outputText("You saunter up and dart forward, puckering your golden lips into a perfect kiss.");
				break;
				//Attack text 3:
			case 3:
				outputText("Swaying sensually, you wiggle up to [themonster] and attempt to plant a nice wet kiss on [monster him].");
				break;
				//Attack text 4:
			case 4:
				outputText("Lunging forward, you fly through the air at [themonster] with your lips puckered and ready to smear drugs all over [monster him].");
				break;
				//Attack text 5:
			case 5:
				outputText("You lean over, your lips swollen with lust, wet with your wanting slobber as you close in on [themonster].");
				break;
				//Attack text 6:
			default:
				outputText("Pursing your drug-laced lips, you close on [themonster] and try to plant a nice, wet kiss on [monster him].");
				break;
		}
		//Dodged!
		if(monster.spe - player.spe > 0 && rand(((monster.spe - player.spe)/4)+80) > 80) {
			attack = rand(3);
			switch(attack) {
					//Dodge 1:
				case 1:
					if(monster.plural) outputText("  [Themonster] sees it coming and moves out of the way in the nick of time!\n\n");
					break;
					//Dodge 2:
				case 2:
					if(monster.plural) outputText("  Unfortunately, you're too slow, and [themonster] slips out of the way before you can lay a wet one on one of them.\n\n");
					else outputText("  Unfortunately, you're too slow, and [themonster] slips out of the way before you can lay a wet one on [monster him].\n\n");
					break;
					//Dodge 3:
				default:
					if(monster.plural) outputText("  Sadly, [themonster] moves aside, denying you the chance to give one of them a smooch.\n\n");
					else outputText("  Sadly, [themonster] moves aside, denying you the chance to give [monster him] a smooch.\n\n");
					break;
			}
			enemyAI();
			return;
		}
		//Success but no effect:
		if(monster.lustVuln <= 0 || !monster.hasCock()) {
			if(monster.plural) outputText("  Mouth presses against mouth, and you allow your tongue to stick out to taste the saliva of one of their number, making sure to give them a big dose.  Pulling back, you look at [themonster] and immediately regret wasting the time on the kiss.  It had no effect!\n\n");
			else outputText("  Mouth presses against mouth, and you allow your tongue to stick to taste [monster his]'s saliva as you make sure to give them a big dose.  Pulling back, you look at [themonster] and immediately regret wasting the time on the kiss.  It had no effect!\n\n");
			enemyAI();
			return;
		}
		attack = rand(4);
		var damage:Number;
		switch(attack) {
				//Success 1:
			case 1:
				if(monster.plural) outputText("  Success!  A spit-soaked kiss lands right on one of their mouths.  The victim quickly melts into your embrace, allowing you to give them a nice, heavy dose of sloppy oral aphrodisiacs.");
				else outputText("  Success!  A spit-soaked kiss lands right on [themonster]'s mouth.  " + monster.mf("He","She") + " quickly melts into your embrace, allowing you to give them a nice, heavy dose of sloppy oral aphrodisiacs.");
				damage = 15;
				break;
				//Success 2:
			case 2:
				if(monster.plural) outputText("  Gold-gilt lips press into one of their mouths, the victim's lips melding with yours.  You take your time with your suddenly cooperative captive and make sure to cover every bit of their mouth with your lipstick before you let them go.");
				else outputText("  Gold-gilt lips press into [themonster], [monster his] mouth melding with yours.  You take your time with your suddenly cooperative captive and make sure to cover every inch of [monster his] with your lipstick before you let [monster him] go.");
				damage = 20;
				break;
				//CRITICAL SUCCESS (3)
			case 3:
				if(monster.plural) outputText("  You slip past [themonster]'s guard and press your lips against one of them.  " + monster.mf("He","She") + " melts against you, " + monster.mf("his","her") + " tongue sliding into your mouth as " + monster.mf("he","she") + " quickly succumbs to the fiery, cock-swelling kiss.  It goes on for quite some time.  Once you're sure you've given a full dose to " + monster.mf("his","her") + " mouth, you break back and observe your handwork.  One of [themonster] is still standing there, licking " + monster.mf("his","her") + " his lips while " + monster.mf("his","her") + " dick is standing out, iron hard.  You feel a little daring and give the swollen meat another moist peck, glossing the tip in gold.  There's no way " + monster.mf("he","she") + " will go soft now.  Though you didn't drug the rest, they're probably a little 'heated up' from the show.");
				else outputText("  You slip past [themonster]'s guard and press your lips against [monster his].  " + monster.mf("He","She") + " melts against you, [monster his] tongue sliding into your mouth as [monster he] quickly succumbs to the fiery, cock-swelling kiss.  It goes on for quite some time.  Once you're sure you've given a full dose to [monster his] mouth, you break back and observe your handwork.  [Themonster] is still standing there, licking [monster his] lips while [monster his] dick is standing out, iron hard.  You feel a little daring and give the swollen meat another moist peck, glossing the tip in gold.  There's no way [monster he] will go soft now.");
				damage = 30;
				break;
				//Success 4:
			default:
				outputText("  With great effort, you slip through an opening and compress their lips against your own, lust seeping through the oral embrace along with a heavy dose of drugs.");
				damage = 12;
				break;
		}
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		if (player.armor == armors.ELFDRES && player.isElf()) damage *= 2;
        if (player.armor == armors.FMDRESS && player.isWoodElf()) damage *= 2;
		//Add status if not already drugged
		if(!monster.hasStatusEffect(StatusEffects.LustStick)) monster.createStatusEffect(StatusEffects.LustStick,0,0,0,0);
		//Else add bonus to round damage
		else monster.addStatusValue(StatusEffects.LustStick,2,Math.round(damage / 10));
		//Deal damage
		monster.teased(Math.round(monster.lustVuln * damage));
		combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		outputText("\n\n");
		//Sets up for end of combat, and if not, goes to AI.
		if(!combatIsOver()) enemyAI();
	}
//Mouf Attack
// (Similar to the bow attack, high damage but it raises your fatigue).
	public function bite():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		if ((player.fatigue + physicalCost(50) > player.maxFatigue()) && player.perkv1(IMutationsLib.SharkOlfactorySystemIM) < 2 && player.faceType != Face.SHARK_TEETH && player.faceType != Face.ABYSSAL_SHARK) {
			clearOutput();
			if (player.faceType == Face.SHARK_TEETH || player.faceType == Face.ABYSSAL_SHARK) outputText("You're too fatigued to use your shark-like jaws!");
			if (player.faceType == Face.ORCA) outputText("You're too fatigued to use your orca-like jaws!");
			if (player.faceType == Face.WOLF) outputText("You're too fatigued to use your wolf jaws!");
			if (player.faceType == Face.CERBERUS) outputText("You're too fatigued to use your canine jaws!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		//Worms are special
		if (monster is WormMass) {
			clearOutput();
			outputText("There is no way those are going anywhere near your mouth!\n\n");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) < 2 && player.faceType != Face.SHARK_TEETH && player.faceType != Face.ABYSSAL_SHARK) fatigue(50, USEFATG_PHYSICAL);
		if (combat.checkConcentration()) return; //Amily concentration
		outputText("You open your mouth wide, your ");
		if (player.faceType == Face.SHARK_TEETH || player.faceType == Face.ABYSSAL_SHARK) outputText("shark teeth extending out");
		if (player.faceType == Face.ORCA) outputText("sharp orca teeth shining briefly");
		if (player.faceType == Face.WOLF) outputText("sharp wolf teeth shining briefly");
		if (player.faceType == Face.CERBERUS) outputText("sharp canine teeth shining briefly while your companion heads follow suit");
		clearOutput();
		outputText(". Snarling with hunger, you lunge at your opponent, set to bite right into them!  ");
		if (player.playerIsBlinded()) outputText("In hindsight, trying to bite someone while blind was probably a bad idea... ");
		var damage:Number = 0;
		//Determine if dodged!
		if((player.playerIsBlinded() && rand(3) != 0) || (monster.getEvasionRoll(false, player.spe))) {
			if(monster.spe - player.spe < 8) outputText("[Themonster] narrowly avoids your attack!");
			if(monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText("[Themonster] dodges your attack with superior quickness!");
			if(monster.spe - player.spe >= 20) outputText("[Themonster] deftly avoids your slow attack.");
			outputText("\n\n");
			enemyAI();
			return;
		}
		damage += combat.meleeUnarmedDamageNoLagSingle(2) * 3;
		if (player.faceType == Face.ABYSSAL_SHARK) damage *= 2;
		damage = Math.round(damage);
		if (!monster.isImmuneToBleed()) {
			if (!monster.hasStatusEffect(StatusEffects.SharkBiteBleed)) monster.createStatusEffect(StatusEffects.SharkBiteBleed,15,0,0,0);
			else {
				monster.removeStatusEffect(StatusEffects.SharkBiteBleed);
				monster.createStatusEffect(StatusEffects.SharkBiteBleed,15,0,0,0);
			}
			if (player.faceType == Face.ABYSSAL_SHARK) monster.addStatusValue(StatusEffects.SharkBiteBleed,2,2);
		}
		//Deal damage and update based on perks
		if(damage > 0) {
			if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
			if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
			if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
			if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
			damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
			damage = Math.round(damage);
			var totalDamage:Number;
			if (player.hasPerk(PerkLib.HellfireCoat))
				totalDamage = doFireDamage(damage);
			else totalDamage = doDamage(damage);
			if (player.faceType == Face.CERBERUS) {
				if (player.hasPerk(PerkLib.HellfireCoat)) {
					totalDamage += doFireDamage(damage);
					totalDamage += doFireDamage(damage);
				} else {
					totalDamage += doDamage(damage);
					totalDamage += doDamage(damage);
				}
			}
		}
		if(totalDamage <= 0) {
			totalDamage = 0;
			outputText("Your bite is deflected or blocked by [themonster]. ");
		}
		else if (totalDamage < 10) {
			outputText("You bite doesn't do much damage to [themonster]! ");
		}
		else if (totalDamage < 20) {
			outputText("You seriously wound [themonster] with your bite! ");
		}
		else if (totalDamage < 30) {
			outputText("Your bite staggers [themonster] with its force. ");
		}
		else {
			outputText("Your powerful bite <b>mutilates</b> [themonster]! ");
		}
		if (totalDamage > 0) {
			if (player.hasPerk(PerkLib.HellfireCoat))
				combat.CommasForDigits(totalDamage, false, "", "fire");
			else
				combat.CommasForDigits(totalDamage);
		}
		else outputText("<b>([font-miss]" + 0 + "</font>)</b>");
		if (monster.hasStatusEffect(StatusEffects.SharkBiteBleed)) outputText(" [Themonster] bleeds profusely from the many bloody bite marks you leave behind.");
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		//Kick back to main if no damage occured!
		if(monster.HP > 0 && monster.lust < monster.maxOverLust()) {
			if (player.perkv1(IMutationsLib.SharkOlfactorySystemIM) >= 4 && (player.faceType == Face.SHARK_TEETH || player.faceType == Face.ABYSSAL_SHARK) && flags[kFLAGS.IN_COMBAT_PLAYER_USED_SHARK_BITE] == 0) {
				flags[kFLAGS.IN_COMBAT_PLAYER_USED_SHARK_BITE] = 1;
				combat.combatMenu(false);
			}
			else enemyAI();
		}
		else {
			if(monster.HP <= monster.minHP()) doNext(endHpVictory);
			else doNext(endLustVictory);
		}
	}

	public function Dig():void {
		clearOutput();
		if(monster is EncapsulationPod) {
			outputText("You can't grab something you're trapped inside of!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		outputText("You dig yourself into the ground, moving out of your opponent’s reach.");
		monster.createStatusEffect(StatusEffects.Dig,5,0,0,0);
		enemyAI();
	}

	public function Drink():void {
		clearOutput();
		outputText("You merrily chug from the gourd quenching your thirst for sake.\n\n");
		if (CoC.instance.mutations.CanDrunkenPowerEmpower()) {
			outputText("OOOH YESHHHH! This is just what you needed. You smile doopily as you enter the famous oni drunken daze, your muscle filling with extra alchoholic might. Now that your thirst is quenched you're totaly going to destroy the puny thing who dared to challenge you.\n\n");
			CoC.instance.mutations.DrunkenPowerEmpower();
		}
		enemyAI();
	}

	public function kick():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if ((player.hasPerk(PerkLib.PhantomStrike) && (player.fatigue + physicalCost(40) > player.maxFatigue())) || (!player.hasPerk(PerkLib.PhantomStrike) && (player.fatigue + physicalCost(20) > player.maxFatigue()))) {
			clearOutput();
			outputText("You're too fatigued to use a charge attack!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(20, USEFATG_PHYSICAL);
		else fatigue(20, USEFATG_PHYSICAL);
		if (player.hasPerk(PerkLib.NaturalInstincts)) player.createStatusEffect(StatusEffects.CooldownKick,4,0,0,0);
		else player.createStatusEffect(StatusEffects.CooldownKick,5,0,0,0);
		//Variant start messages!
		if (player.lowerBody == LowerBody.KANGAROO) {
			//(tail)
			if(player.tailType == Tail.KANGAROO) outputText("You balance on your flexible kangaroo-tail, pulling both legs up before slamming them forward simultaneously in a brutal kick.  ");
			//(no tail)
			else outputText("You balance on one leg and cock your powerful, kangaroo-like leg before you slam it forward in a kick.  ");
		}
		//(bunbun kick)
		else if (player.lowerBody == LowerBody.BUNNY) outputText("You leap straight into the air and lash out with both your furred feet simultaneously, slamming forward in a strong kick.  ");
		//(centaur kick)
		else if (player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.PONY || player.lowerBody == LowerBody.CLOVEN_HOOFED)
			if (player.isTaur()) outputText("You lurch up onto your backlegs, lifting your forelegs from the ground a split-second before you lash them out in a vicious kick.  ");
			//(bipedal hoof-kick)
			else outputText("You twist and lurch as you raise a leg and slam your hoof forward in a kick.  ");

		if (flags[kFLAGS.PC_FETISH] >= 3) {
			outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Ceraph's piercings have made normal attack impossible!  Maybe you could try something else?\n\n");
			enemyAI();
			return;
		}
		if (combat.checkConcentration()) return; //Amily concentration
		//Blind
		if (player.playerIsBlinded()) {
			outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ");
		}
		//Worms are special
		if (monster is WormMass) {
			//50% chance of hit (int boost)
			if (rand(100) + player.inte/3 >= 50) {
				var dam:int = int(player.str / 5 - rand(5));
				if (player.tailType == Tail.KANGAROO) dam += 3;
				if (dam == 0) dam = 1;
				outputText("You strike at the amalgamation, crushing countless worms into goo, dealing " + dam + " damage.\n\n");
				monster.HP -= dam;
				if (monster.HP <= monster.minHP()) {
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
		if ((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) {
			//Akbal dodges special education
			if (monster is Akbal) outputText("Akbal moves like lightning, weaving in and out of your furious attack with the speed and grace befitting his jaguar body.\n");
			else {
				outputText("[Themonster] manage");
				if(!monster.plural) outputText("s");
				outputText(" to dodge your kick!");
				outputText("\n\n");
			}
			enemyAI();
			return;
		}
		//Determine damage
		//Base:
		var damage:Number = 0;
		damage += combat.meleeUnarmedDamageNoLagSingle(2);
		//Leg bonus
		//Bunny - 20, 1 hoof = 30, 2 hooves = 40, Kangaroo - 50
		if (player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.PONY || player.lowerBody == LowerBody.CLOVEN_HOOFED) damage += 30;
		else if (player.lowerBody == LowerBody.BUNNY) damage += 20;
		else if (player.lowerBody == LowerBody.KANGAROO) damage += 50;
		if (player.isTaur()) damage += 10;
		//Damage post processing!
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		if (player.hasPerk(PerkLib.RacialParagon)) damage *= combat.RacialParagonAbilityBoost();
		if (player.hasPerk(PerkLib.NaturalArsenal)) damage *= 1.50;
		if (player.hasPerk(PerkLib.LionHeart)) damage *= 2;
		damage *= (1 + (0.01 * combat.masteryFeralCombatLevel()));
		//(None yet!)
		damage = Math.round(damage);
		monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		//BLOCKED
		if (damage <= 0) {
			damage = 0;
			outputText(monster.capitalA + monster.short);
			if(monster.plural) outputText("'");
			else outputText("s");
			outputText(" defenses are too tough for your kick to penetrate!");
		}
		//LAND A HIT!
		else {
			outputText(monster.capitalA + monster.short);
			if(!monster.plural) outputText(" reels from the damaging impact! ");
			else outputText(" reel from the damaging impact! ");
			doDamage(damage, true);
			if (player.hasPerk(PerkLib.PhantomStrike)) {
				outputText(" ");
				doDamage(damage, true);
				damage *= 2;
			}
		}
		if (damage > 0) {
			//Lust raised by anemone contact!
			if (monster is Anemone) {
				outputText("\nThough you managed to hit the anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.");
				//(gain lust, temp lose str/spd)
				(monster as Anemone).applyVenom((1+rand(2)));
			}
			//Lust raised by sea anemone contact!
			if (monster is SeaAnemone) {
				outputText("\nThough you managed to hit the sea anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.");
				//(gain lust, temp lose str/spd)
				(monster as SeaAnemone).applyVenom((1+rand(2)));
			}
		}
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		if (!combatIsOver())enemyAI();
	}

	public function shieldBash():void {
		clearOutput();
		EngineCore.WrathChange(-shieldbashcostly());
		outputText("You ready your [shield] and prepare to slam it towards [themonster].  ");
		if ((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) {
			if (monster.spe - player.spe >= 20) outputText("[Themonster] deftly avoids your slow attack.");
			else if (monster.spe - player.spe >= 8) outputText("[Themonster] dodges your attack with superior quickness!");
			else outputText("[Themonster] narrowly avoids your attack!");
			enemyAI();
			return;
		}
		var damage:int = 10 + (player.str / 1.5) + rand(player.str / 2) + (player.shieldBlock * 2);
		if (player.hasPerk(PerkLib.ShieldSlam)) damage *= 1.2;
		if (player.hasPerk(PerkLib.SteelImpact)) damage += ((player.tou - 50) * 0.3);
		damage = combat.statusEffectBonusDamage(damage);
		if (player.shieldPerk == "Large") damage *= 2;
		if (player.shieldPerk == "Massive") damage *= 5;
		var chance:int = Math.floor(monster.statusEffectv1(StatusEffects.TimesBashed) + 1);
		if (chance > 10) chance = 10;
		doDamage(damage);
		outputText("Your [shield] slams against [themonster], dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
		if (!monster.hasStatusEffect(StatusEffects.Stunned) && rand(chance) == 0) {
			outputText("<b>Your impact also manages to stun [themonster]!</b> ");
			monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			if (!monster.hasStatusEffect(StatusEffects.TimesBashed)) monster.createStatusEffect(StatusEffects.TimesBashed, player.hasPerk(PerkLib.ShieldSlam) ? 0.5 : 1, 0, 0, 0);
			else monster.addStatusValue(StatusEffects.TimesBashed, 1, player.hasPerk(PerkLib.ShieldSlam) ? 0.5 : 1);
		}
		checkAchievementDamage(damage);
		if ((player.shield == shields.SPIL_SH || player.shield == shields.SPIH_SH || player.shield == shields.SPIM_SH || (player.shield == shields.AETHERS && player.weapon == weapons.AETHERD && AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets")) && !monster.isImmuneToBleed()) {
			if (monster.hasStatusEffect(StatusEffects.Hemorrhage)) monster.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
			else {
				monster.createStatusEffect(StatusEffects.Hemorrhage, 3, 0.02, 0, 0);
            	if (player.shield == shields.SPIH_SH) monster.addStatusValue(StatusEffects.Hemorrhage, 2, 0.02);
            	else if (player.shield == shields.SPIM_SH) monster.addStatusValue(StatusEffects.Hemorrhage, 2, 0.05);
			}
			if (monster.plural) outputText("\n[Themonster] bleed profusely from the many bloody gashes your [shield] leave behind.");
            else outputText("\n[Themonster] bleeds profusely from the many bloody gashes your [shield] leave behind.");
		}
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		if (player.statusEffectv1(StatusEffects.CounterAction) == 1) {
			player.removeStatusEffect(StatusEffects.CounterAction);
			doNext(playerMenu);
		}
		else enemyAI();
	}
	public function netEntangle():void {
		clearOutput();
		outputText("You skillfully toss your net at [themonster] restraining [monster his] movement.");
		player.createStatusEffect(StatusEffects.CooldownNet,5,0,0,0);
		monster.createStatusEffect(StatusEffects.Stunned,3,0,0,0);
		enemyAI();
	}

	public function ELFarcheryElvenEye():void {
		clearOutput()
		outputText("You focus your vision concentrating on the target and pinpointing weak points to maximise the damage of your arrows!\n\n");
		player.createStatusEffect(StatusEffects.ElvenEye,8,0,0,0);
		enemyAI();
	}

	public function ELFarcheryPinDown():void {
		clearOutput()
		var accRange:Number = 0;
		accRange += (combat.arrowsAccuracy() / 2);
		if (flags[kFLAGS.ARROWS_ACCURACY] > 0) accRange -= flags[kFLAGS.ARROWS_ACCURACY];
		if (player.weaponRangeName == "Guided bow" || player.vehicles == vehicles.HB_MECH) accRange = 100;
		fatigue(combat.oneArrowTotalCost());
		var weaponRangePerk:String = player.weaponRangePerk;
		var ammoWord:String = "arrow";
		if (rand(100) < accRange) {
			var damage:Number = 0;
			damage += combat.rangeDamageNoLagSingle(0);
			if (player.isInNonGoblinMech()) {
				if (player.vehicles == vehicles.HB_MECH) {
					if (player.armor == armors.HBARMOR) damage *= 1.5;
					if (player.headJewelry == headjewelries.HBHELM) damage *= 1.2;
					if (player.upperGarment == undergarments.HBSHIRT) damage *= 1.1;
					if (player.lowerGarment == undergarments.HBSHORT) damage *= 1.1;
					if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) damage *= 1.25;
				}
				else {
					if (player.armor == armors.HBARMOR) damage *= 1.2;
					if (player.headJewelry == headjewelries.HBHELM) damage *= 1.1;
					if (player.upperGarment == undergarments.HBSHIRT) damage *= 1.05;
					if (player.lowerGarment == undergarments.HBSHORT) damage *= 1.05;
				}
			}
			if (damage == 0) {
				if (monster.inte > 0) {
					outputText("[Themonster] shrugs as the " + ammoWord + " bounces off them harmlessly.\n\n");
				} else {
					outputText("The " + ammoWord + " bounces harmlessly off [monster a] [monster name].\n\n");
				}
				flags[kFLAGS.ARROWS_SHOT]++;
				bowPerkUnlock();
			}
			if (monster is EncapsulationPod) {
				outputText("While the " + ammoWord + " do lodges deep into the pod's fleshy wall it does not hinder it in any ways.");
			} else {
				outputText("You take aim at [themonster] legs in order to restrain [monster his] movement. Your shot hits the mark pinning your shocked opponent down.");
			}
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combatPhysicalCritical();
			if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) critChance += 10;
			if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
			if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "Bow") critChance += 10;
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				var buffMultiplier:Number = 0;
				if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "Bow") buffMultiplier += 1;
				damage *= 1.75+buffMultiplier;
			}
			if (player.weaponRangeName == "Wild Hunt" && player.level > monster.level) damage *= 1.2;
			if (player.weaponRangeName == "Hodr's bow" && monster.hasStatusEffect(StatusEffects.Blind)) damage *= 1.1;
			if (flags[kFLAGS.ELEMENTAL_ARROWS] > 0) damage = combat.elementalArrowDamageMod(damage);
			//Section for item damage modifiers
			if (weaponRangePerk == "Bow"){
				if (player.hasPerk(PerkLib.ElvenRangerArmor)) damage *= 1.5;
				if (player.isElf() && player.hasPerk(PerkLib.ELFArcherCovenant) && player.isSpearTypeWeapon() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise())  damage *= 1.25;
			}
			damage = Math.round(damage);
			if (monster.HP <= monster.minHP()) {
				if (monster is EncapsulationPod)
					outputText(". ");
				else if (monster.plural)
					outputText(" and [monster he] stagger, collapsing onto each other from the wounds you've inflicted on [monster him]. ");
				else outputText(" and [monster he] staggers, collapsing from the wounds you've inflicted on [monster him]. ");
				if (player.isInNonGoblinMech()) combat.doArcheryDamage(damage, 1);
				else combat.doArcheryDamage(damage, 0);
				if (crit) outputText(" <b>*Critical Hit!*</b>");
				combat.archeryXP(combat.rangeMasteryEXPgained(crit));
				outputText("\n\n");
				checkAchievementDamage(damage);
				flags[kFLAGS.ARROWS_SHOT]++;
				bowPerkUnlock();
				doNext(endHpVictory);
				return;
			} else {
				if (rand(100) < 15 && player.weaponRangeName == "Artemis" && !monster.hasStatusEffect(StatusEffects.Blind)) {
					monster.createStatusEffect(StatusEffects.Blind, 3, 0, 0, 0);
					outputText(",  your radiant shots blinded [monster he]");
				}
				if (!combat.MSGControll) {
					outputText(".  It's clearly very painful. ");
					if (player.isInNonGoblinMech()) combat.doArcheryDamage(damage, 1);
					else combat.doArcheryDamage(damage, 0);
					combat.archeryXP(combat.rangeMasteryEXPgained(crit));
				}
				if (crit) outputText(" <b>*Critical Hit!*</b>");
				combat.WrathGenerationPerHit1(5);
				combat.heroBaneProc(damage);
			}
			combat.cupidArrowsEffect();
			EnvenomedBoltEffects();
			if (player.weaponRangeName == "Hodr's bow" && !monster.hasStatusEffect(StatusEffects.Blind)) monster.createStatusEffect(StatusEffects.Blind, 1, 0, 0, 0);
			outputText("\n");
			if (flags[kFLAGS.ARROWS_SHOT] >= 1) EngineCore.awardAchievement("Arrow to the Knee", kACHIEVEMENTS.COMBAT_ARROW_TO_THE_KNEE);
			flags[kFLAGS.ARROWS_SHOT]++;
			combat.WrathWeaponsProc();
			bowPerkUnlock();
		} else {
			if (monster is DisplacerBeast) outputText("\n\nThe displacer beast teleports, dodging your attack.\n");
			else {
				outputText("The " + ammoWord + " goes wide, disappearing behind your foe");
				if (monster.plural) outputText("s");
				outputText(".\n\n");
			}
		}
		if (flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 1) {
			if (monster is Lethice && (monster as Lethice).fightPhase == 3) {
				outputText("\n\n<i>\"Ouch. Such a cowardly weapon,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>\"How will you beat me without your pathetic " + ammoWord + "s?\"</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
			enemyAI();
		}
		if (monster.HP <= monster.minHP()) {
			doNext(endHpVictory);
			return;
		}
		if (monster.lust >= monster.maxOverLust()) {
			doNext(endLustVictory);
			return;
		}
		player.createStatusEffect(StatusEffects.CooldownPinDown,8,0,0,0);
		monster.createStatusEffect(StatusEffects.Stunned,3,0,0,0);
		enemyAI();
	}

	public function archerSidewinder():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		var costSidewinder:Number = 1;
		var maxRangedAttacks:int = player.calculateMultiAttacks(false);
		if (maxRangedAttacks >= 6) costSidewinder += 5;
		else costSidewinder += (maxRangedAttacks - 1);

		if (player.fatigue + bowCost(200 * costSidewinder) > player.maxFatigue()) {
			outputText("You are too tired to attack [themonster].");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		player.createStatusEffect(StatusEffects.CooldownSideWinder,0,0,0,0);
		outputText("You draw but a single arrow infusing a massive amount of magical energy in the bolt which begin to emit a ");
		if (player.cor > 50) outputText("red");
		else if (player.cor < 50) outputText("white");
		else {
			if (rand(2) == 1) outputText("red");
			else outputText("white");
		}
		outputText(" light and grow turning into a huge spear of condensed energy.  ");
		fatigue((200 * costSidewinder), USEFATG_BOW);
		var damage:Number = 0;
		damage += combat.rangeDamageNoLagSingle(0);
		if (monster.hasPerk(PerkLib.EnemyBeastOrAnimalMorphType)) damage *= (10 * costSidewinder);
		if (flags[kFLAGS.ELEMENTAL_ARROWS] > 0) damage = combat.elementalArrowDamageMod(damage);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) critChance += 10;
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "Bow") critChance += 10;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "Bow") buffMultiplier += 1;
			damage *= 1.75+buffMultiplier;
		}
		damage = Math.round(damage);
		outputText("You shoot the projectile toward your opponent the bolt flying at such speed and velocity all you see is a flash of light as it reach [themonster] and explode the blast projecting dirt and rock everywhere. It takes an entire minute for the smoke to settle. ");
		combat.doArcheryDamage(damage, 0);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		combat.cupidArrowsEffect();
		EnvenomedBoltEffects();
		outputText("\n\n");
		flags[kFLAGS.ARROWS_SHOT]++;
		bowPerkUnlock();
		combat.WrathGenerationPerHit2(5);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		enemyAI();
	}

	public function EnvenomedBoltEffects(Omnishot:Number = 1, ammoWord:String = "arrows"):void{
		if (flags[kFLAGS.ENVENOMED_BOLTS] == 1 && player.tailVenom >= player.VenomWebCost()) {
			outputText("  ");
			if (monster.lustVuln == 0) {
				outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
			}
			if (player.tailType == Tail.BEE_ABDOMEN) {
				outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
				var damage1B:Number = 35 + rand(player.lib / 10);
				var damage1Ba:Number = 1;
				if (player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)) damage1B += scalingBonusToughness() * 0.5;
				if (player.level < 10) damage1B += 20 + (player.level * 3);
				else if (player.level < 20) damage1B += 50 + (player.level - 10) * 2;
				else if (player.level < 30) damage1B += 70 + (player.level - 20) * 1;
				else damage1B += 80;
				damage1B *= 0.2;
				if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) {
					damage1B *= 2;
					damage1Ba *= 2;
				}
				if (player.armor == armors.ELFDRES && player.isElf()) damage1B *= 2;
				if (player.armor == armors.FMDRESS && player.isWoodElf()) damage1B *= 2;
				monster.teased(damage1B*Omnishot);
				if (monster.hasStatusEffect(StatusEffects.BeeVenom)) {
					monster.addStatusValue(StatusEffects.BeeVenom, 3, damage1Ba*Omnishot);
				} else monster.createStatusEffect(StatusEffects.BeeVenom, 0, 0, damage1Ba*Omnishot, 0);
				if (player.hasPerk(PerkLib.ToxineMaster)) monster.statStore.addBuffObject({tou:-5*Omnishot}, "Poison",{text:"Poison"});
				player.tailVenom -= player.VenomWebCost();
				flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
			}
			if (player.tailType == Tail.SCORPION || player.hasKeyItem("Sky Poison Pearl") >= 0) {
				outputText("  [monster he] seems to be effected by the poison, its movements slowing rapidly.");
				var DBP:Number = 2;
				var DBPa:Number = 1;
				if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) {
					DBP *= 2;
					DBPa *= 2;
				}
				if (player.hasPerk(PerkLib.ToxineMaster)) monster.statStore.addBuffObject({tou:-(DBP+5*Omnishot), spe:-DBP}, "Poison",{text:"Poison"});
				else monster.statStore.addBuffObject({tou:-DBP*Omnishot, spe:-DBP*Omnishot}, "Poison",{text:"Poison"});
				if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
					monster.addStatusValue(StatusEffects.NagaVenom, 3, DBPa*Omnishot);
				} else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, DBPa*Omnishot, 0);
				if (player.hasPerk(PerkLib.WoundPoison)){
					if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10*Omnishot);
					else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
				}
				player.tailVenom -= player.VenomWebCost();
				flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
			}
			if (player.tailType == Tail.MANTICORE_PUSSYTAIL) {
				outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
				var lustdamage:Number = 35 + rand(player.lib / 10);
				var DBPaa:Number = 1;
				if (player.level < 10) lustdamage += 20 + (player.level * 3);
				else if (player.level < 20) lustdamage += 50 + (player.level - 10) * 2;
				else if (player.level < 30) lustdamage += 70 + (player.level - 20) * 1;
				else lustdamage += 80;
				lustdamage *= 0.14;
				if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) {
					lustdamage *= 2;
					DBPaa *= 2;
				}
				if (player.armor == armors.ELFDRES && player.isElf()) lustdamage *= 2;
				if (player.armor == armors.FMDRESS && player.isWoodElf()) lustdamage *= 2;
				monster.teased(lustdamage*Omnishot, false);
				if (player.hasPerk(PerkLib.ToxineMaster)) DBPaa += 2.5;
				monster.statStore.addBuffObject({tou:-(DBPaa*2*Omnishot)}, "Poison",{text:"Poison"});
				if (monster.hasStatusEffect(StatusEffects.ManticoreVenom)) {
					monster.addStatusValue(StatusEffects.ManticoreVenom, 3, DBPaa*Omnishot);
				} else monster.createStatusEffect(StatusEffects.ManticoreVenom, 0, 0, DBPaa*Omnishot, 0);
				player.tailVenom -= player.VenomWebCost();
				flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
			}
			if (player.faceType == Face.SNAKE_FANGS) {
				outputText("  [monster he] seems to be effected by the poison, its movements slowing down.");
				var DBPaaa:Number = 1;
				if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) DBPaaa *= 2;
				if (player.hasPerk(PerkLib.ToxineMaster)) monster.statStore.addBuffObject({tou:-5, spe:-DBPaaa*Omnishot}, "Poison",{text:"Poison"});
				else monster.statStore.addBuffObject({spe:-DBPaaa*Omnishot}, "Poison",{text:"Poison"});
				var venomType:StatusEffectType = StatusEffects.NagaVenom;
				if (player.racialScore(Races.NAGA) >= 23) venomType = StatusEffects.ApophisVenom;
				if (monster.hasStatusEffect(venomType)) {
					monster.addStatusValue(venomType, 2, 0.4*Omnishot);
					monster.addStatusValue(venomType, 1, (DBPaaa * 0.4*Omnishot));
				} else monster.createStatusEffect(venomType, (DBPaaa * 0.4*Omnishot), 0.4*Omnishot, 0, 0);
				if (player.hasPerk(PerkLib.WoundPoison)){
					if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10*Omnishot);
					else monster.createStatusEffect(StatusEffects.WoundPoison, 10*Omnishot,0,0,0);
				}
				player.tailVenom -= player.VenomWebCost();
				flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
			}
			if (player.faceType == Face.SPIDER_FANGS) {
				if (player.lowerBody == LowerBody.ATLACH_NACHA){
					outputText("  [monster he] seems to be affected by the poison, showing increasing sign of weakness and arousal.");
					var damage2B:Number = 35 + rand(player.lib / 10);
					var poisonScaling:Number = 1;
					var damage2Ba:Number = 1;
					poisonScaling += player.lib/100;
					poisonScaling += player.tou/100;
					if (player.level < 10) damage2B += 20 + (player.level * 3);
					else if (player.level < 20) damage2B += 50 + (player.level - 10) * 2;
					else if (player.level < 30) damage2B += 70 + (player.level - 20) * 1;
					else damage2B += 80;
					damage2B *= 0.2;
					damage2B *= 1 + (poisonScaling / 10);
					if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) {
						damage2B *= 2;
						damage2Ba *= 2;
					}
					if (player.armor == armors.ELFDRES && player.isElf()) damage2B *= 2;
					if (player.armor == armors.FMDRESS && player.isWoodElf()) damage2B *= 2;
					monster.teased(damage2B*Omnishot);
					if (player.hasPerk(PerkLib.ToxineMaster)) poisonScaling += 5;
					monster.statStore.addBuffObject({tou:-poisonScaling*Omnishot}, "Poison",{text:"Poison"});
					if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
						monster.addStatusValue(StatusEffects.NagaVenom, 3, damage2Ba*Omnishot);
					} else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, damage2Ba*Omnishot, 0);
					if (player.hasPerk(PerkLib.WoundPoison)){
						if (monster.hasStatusEffect(StatusEffects.WoundPoison)) monster.addStatusValue(StatusEffects.WoundPoison, 1, 10*Omnishot);
						else monster.createStatusEffect(StatusEffects.WoundPoison, 10,0,0,0);
					}
					player.tailVenom -= player.VenomWebCost();
					flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
				}
				else{
					outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
					var lustDmg:int = 6 * monster.lustVuln;
					if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) lustDmg *= 2;
					if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
					if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
					monster.teased(lustDmg*Omnishot);
					if (monster.lustVuln > 0 && !monster.hasPerk(PerkLib.EnemyTrueAngel)) {
						monster.lustVuln += 0.01;
						if (monster.lustVuln > 1) monster.lustVuln = 1;
					}
					player.tailVenom -= player.VenomWebCost();
					if (player.hasPerk(PerkLib.ToxineMaster)) monster.statStore.addBuffObject({tou:-5*Omnishot}, "Poison",{text:"Poison"});
					flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
				}
			}
			if (monster.lust >= monster.maxOverLust()) {
				outputText("\n\n");
				flags[kFLAGS.ARROWS_SHOT]++;
				doNext(endLustVictory);
			}
			outputText("\n");
		}
		else if (flags[kFLAGS.ENVENOMED_BOLTS] == 1 && player.tailVenom < player.VenomWebCost()) {
			if (player.hasPerk(PerkLib.ToxineMaster) && player.hasKeyItem("Sky Poison Pearl") >= 0) {
				outputText("  [monster he] seems to be affected by the poison, showing increasing sign of weakness.\n");
				monster.statStore.addBuffObject({tou:-5*Omnishot}, "Poison",{text:"Poison"});
			}
			else outputText("  You do not have enough venom to apply on the " + ammoWord + " tip!\n");
		}
	}

	public function archerBarrage():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		var maxBowAttacks:int = combat.maxBowAttacks();
		flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = maxBowAttacks;
		clearOutput();
		if (player.fatigue + bowCost(200) > player.maxFatigue()) {
			outputText("You are too tired to attack [themonster].");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		outputText("You grab six arrows and display them like a fan on your bow as a swift motion.  ");
		fatigue(200, USEFATG_BOW);
		var damage:Number = archerBarrage3();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) critChance += 10;
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "Bow") critChance += 10;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "Bow") buffMultiplier += 1;
			damage *= 1.75+buffMultiplier;
		}
		damage = Math.round(damage);
		outputText("Holding your weapon horizontally, you shoot them all, spraying [themonster] with a projectile. ");
		var ignoreDR:Boolean = (player.hasPerk(PerkLib.DeadlyAim))
		doPhysicalDamage(damage, true, true, ignoreDR);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		combat.cupidArrowsEffect();
		if (monster.plural) EnvenomedBoltEffects(6);
		else EnvenomedBoltEffects();
		flags[kFLAGS.ARROWS_SHOT] += 6;
		bowPerkUnlock();
		combat.WrathGenerationPerHit2(5);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if (monster.HP <= monster.minHP() || flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 1) enemyAI();
		else archerBarrage2();
	}
	private function archerBarrage2():void {
		if (player.fatigue + bowCost(200) > player.maxFatigue()) {
			outputText("You are too tired to shoot next volley of arrows.");
			enemyAI();
			return;
		}
		flags[kFLAGS.MULTIPLE_ARROWS_STYLE]--;
		fatigue(200, USEFATG_BOW);
		var damage:Number = archerBarrage3();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) critChance += 10;
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "Bow") critChance += 20;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			if (player.hasStatusEffect(StatusEffects.ElvenEye) && player.weaponRangePerk == "Bow") buffMultiplier += 2;
			damage *= 1.75+buffMultiplier;
		}
		damage = Math.round(damage);
		outputText("Then do it another time showering them with an extra volley of arrows. ");
		combat.doArcheryDamage(damage, 0);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		combat.cupidArrowsEffect();
		if (monster.plural) EnvenomedBoltEffects(6);
		else EnvenomedBoltEffects();
		outputText("\n\n");
		flags[kFLAGS.ARROWS_SHOT] += 6;
		bowPerkUnlock();
		combat.WrathGenerationPerHit2(5);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if (monster.HP <= monster.minHP() || flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 1) enemyAI();
		else archerBarrage2();
	}
	private function archerBarrage3():Number {
		var dmgBarrage:Number = 0;
		dmgBarrage += combat.rangeDamageNoLagSingle(0);
		dmgBarrage *= 6;
		if (flags[kFLAGS.ELEMENTAL_ARROWS] > 0) dmgBarrage = combat.elementalArrowDamageMod(dmgBarrage);
		return dmgBarrage;
	}
	
	public function StealthModeActivate():void {
		clearOutput();
		if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] >= combat.StealthModeMechCost()) flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] -= combat.StealthModeMechCost();
		else player.soulforce -= combat.StealthModeMechCost();
		outputText("Your mech form shimmers for a second as you vanish into thin air. Your opponent starts looking for you, annoyed.\n\n");
		var DurationIncrease:Number = 0;
		if (player.keyItemvX("HB Stealth System", 1) >= 1) DurationIncrease += 1;
		monster.createStatusEffect(StatusEffects.InvisibleOrStealth, 1, DurationIncrease, 0, 0);
		enemyAI();
	}
	public function StealthModeDeactivate():void {
		clearOutput();
		outputText("Depowering system you cause mech form to become visible.\n\n");
		monster.removeStatusEffect(StatusEffects.InvisibleOrStealth);
		enemyAI();
	}

	public function mechScatterLaser():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		outputText("You press the lightning button and aim, as the Scatter Laser" + ((player.keyItemvX("HB Scatter Laser", 2) > 1)?"s":"") + " power up your mech shoot [themonster] for ");
		var LazorC:Number = 100;
		if (player.keyItemvX("HB Scatter Laser", 2) > 1) {
			if (player.keyItemvX("HB Scatter Laser", 2) == 3) {
				if (monster.plural) LazorC += 500;
				else LazorC += 300;
			}
			else {
				if (monster.plural) LazorC += 200;
				else LazorC += 100;
			}
		}
		if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] >= LazorC) flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] -= LazorC;
		else player.soulforce -= LazorC;
		var damage:Number;
		damage = scalingBonusIntelligence() * spellModWhite() * 8;
		if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) damage *= 8;
		damage = combat.goblinDamageBonus(damage);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		doLightningDamage(damage, true, true);
		if (player.keyItemvX("HB Scatter Laser", 2) > 1) {
			if (player.keyItemvX("HB Scatter Laser", 2) == 3) {
				if (monster.plural) {
					doLightningDamage(damage, true, true);
					doLightningDamage(damage, true, true);
				}
				doLightningDamage(damage, true, true);
				doLightningDamage(damage, true, true);
				doLightningDamage(damage, true, true);
			}
			else {
				if (monster.plural) doLightningDamage(damage, true, true);
				doLightningDamage(damage, true, true);
			}
		}
		outputText(" damage! ");
		if (crit) outputText("<b>*Critical Hit!*</b>");
		outputText("\n\n");
		combat.heroBaneProc(damage);
		statScreenRefresh();
		enemyAI();
	}
/*
	public function mechStarcannon():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		outputText("You press the BIG lightning button and aim, smirking wide as the Raijin blaster power up your mech zapping [themonster] for ");
		player.createStatusEffect(StatusEffects.CooldownRaijinBlaster,8,0,0,0);
		var damage:Number;
		damage = scalingBonusIntelligence() * spellModWhite() * 8;
		if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) damage *= 8;
		damage = combat.goblinDamageBonus(damage);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		doLightningDamage(damage, true, true);
		outputText(" damage! ");
		if (crit) outputText("<b>*Critical Hit!*</b>");
		outputText("\n\n");
		combat.heroBaneProc(damage);
		statScreenRefresh();
		enemyAI();
	}
*/
	public function mechTazer():void {
		clearOutput();
		outputText("You press the lightning button and aim, smirking at [themonster], your mech delivering a ");
		player.createStatusEffect(StatusEffects.CooldownTazer,8,0,0,0);
		if (player.hasKeyItem("Taser overcharge battery") >= 0) {
			flags[kFLAGS.LAST_ATTACK_TYPE] = Combat.LAST_ATTACK_SPELL;
			var damage:Number = scalingBonusIntelligence() * spellModWhite();
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combatMagicalCritical();
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			//High damage to goes.
			damage = calcVoltageMod(damage, true);
			if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
			damage = combat.goblinDamageBonus(damage);
			damage *= 0.5;
			damage = Math.round(damage);
			outputText("potent discharge ");
			doLightningDamage(damage, true, true);
			outputText(" damage!");
			if (crit) outputText(" <b>*Critical Hit!*</b>");
			monster.createStatusEffect(StatusEffects.Stunned,4,0,0,0);
		}
		else {
			outputText("discharge!");
			monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
		statScreenRefresh();
		enemyAI();
	}

	public function mechOmniMissile():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = Combat.LAST_ATTACK_PHYS;
		if (player.hasKeyItem("Omni Missile") >= 0) outputText("You deploy the omni Missile and rain death on [themonster], covering the entire area with explosions for ");
		else outputText("You deploy the missile launcher and aim at [themonster], for a big explosion. ");
		var damage:Number = combat.firearmsDamageNoLagSingle();
		var ignoreDR:Boolean = player.hasPerk(PerkLib.Penetrator);
		if (!ignoreDR) damage *= (monster.damageRangePercent() / 100);
		//Weapon addition!
		if (player.hasKeyItem("Gun Scope") >= 0) damage *= 1.2;
		if (player.hasKeyItem("Gun Scope with Aim tech") >= 0) damage *= 1.4;
		if (player.hasKeyItem("Gun Scope with Aimbot") >= 0) damage *= 1.6;
		if (player.hasPerk(PerkLib.NamedBullet) && monster.hasPerk(PerkLib.EnemyBossType)) damage *= 1.5;
		if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType) || monster.hasPerk(PerkLib.EnemyHugeType) || monster.hasPerk(PerkLib.EnemyGigantType) || monster.hasPerk(PerkLib.EnemyColossalType)) {
			if (player.hasPerk(PerkLib.ExplosiveCartridge)) damage *= 2;
			if (player.hasKeyItem("Omni Missile") >= 0) damage *= 10;
			else damage *= 5;
		}
		damage = combat.goblinDamageBonus(damage);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		doDamage(damage, true, true, ignoreDR);
		outputText(" damage!");
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		combat.heroBaneProc(damage);
		statScreenRefresh();
		enemyAI();
	}

	public function mechStimpackMedicalDispenser():void {
		clearOutput();
		if (player.hasKeyItem("Medical Dispenser 2.0") >= 0) player.createStatusEffect(StatusEffects.CooldownStimpackDispenser, 15, 0, 0, 0);
		else player.createStatusEffect(StatusEffects.CooldownStimpackDispenser, 20, 0, 0, 0);
		outputText("You activate the medical dispenser, recovering from wounds at the expense of feeling your body throb and heat up. Bah, side effects!");
		var heal:Number = 0;
		heal += scalingBonusIntelligence();
		if (player.hasPerk(PerkLib.WisenedHealer)) heal += scalingBonusWisdom();
		heal *= healModWhite();
		if (player.armorName == "skimpy nurse's outfit") heal *= 1.2;
		if (player.weaponName == "unicorn staff") heal *= 1.5;
		if (player.hasPerk(PerkLib.CloseToDeath) && player.HP < (player.maxHP() * 0.25)) {
			if (player.hasPerk(PerkLib.CheatDeath) && player.HP < (player.maxHP() * 0.1)) heal *= 2.5;
			else heal *= 1.5;
		}
		//Determine if critical heal!
		var crit:Boolean = false;
		var critHeal:int = 5;
		critHeal += combatMagicalCritical();
		if (rand(100) < critHeal) {
			crit = true;
			heal *= 1.75;
		}
		if (player.hasKeyItem("Medical Dispenser 2.0") >= 0) heal *= 0.2;
		else heal *= 0.1;
		heal = Math.round(heal);
		player.createStatusEffect(StatusEffects.GoblinMechStimpack, 10, heal, 0, 0);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		enemyAI();
	}

	public function mechGravityShots():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = Combat.LAST_ATTACK_SPELL;
		outputText("You press the spiral button and aim, unleashing the gravity sphere at [themonster]. ");
		player.createStatusEffect(StatusEffects.CooldownGravityShots,8,0,0,0);
		var damage:Number;
		damage = scalingBonusIntelligence() * spellModBlack() * 8;

		damage = calcEclypseMod(damage, true);
		if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) damage *= 8;
		damage = combat.goblinDamageBonus(damage);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		doDarknessDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		if (monster.isFlying()) {
			outputText(" There is something very satisfying about hampering your opponent’s ability to fly around by messing with their space.");
			monster.createStatusEffect(StatusEffects.Stunned, 4, 0, 0, 0);
		}
		outputText("\n\n");
		combat.heroBaneProc(damage);
		statScreenRefresh();
		enemyAI();
	}

	public function mechRaijinBlaster():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = Combat.LAST_ATTACK_SPELL;
		outputText("You press the BIG lightning button and aim, smirking wide as the Raijin blaster power up your mech zapping [themonster] for ");
		player.createStatusEffect(StatusEffects.CooldownRaijinBlaster,8,0,0,0);
		var damage:Number;
		damage = scalingBonusIntelligence() * spellModWhite() * 8;

		damage = calcVoltageMod(damage, true);
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
		if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) damage *= 8;
		damage = combat.goblinDamageBonus(damage);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		doLightningDamage(damage, true, true);
		outputText(" damage! ");
		if (crit) outputText("<b>*Critical Hit!*</b> ");
		var lustDmg:Number = (player.inte / 5 * spellModBlack() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
		if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;
		//Determine if critical tease!
		var crit1:Boolean = false;
		var critChance1:int = 5;
		critChance1 += combat.teases.combatTeaseCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance1 = 0;
		if (rand(100) < critChance1) {
			crit1 = true;
			lustDmg *= 1.75;
		}
		lustDmg = Math.round(monster.lustVuln * lustDmg);
		monster.teased(lustDmg);
		if (crit1) outputText(" <b>Critical!</b>");
		outputText("\n\n");
		combat.heroBaneProc(damage);
		statScreenRefresh();
		enemyAI();
	}

	public function mechSnowballGenerator():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = Combat.LAST_ATTACK_SPELL;
		outputText("You activate the snowball generator, taking aim and launching a volley of snowballs at the [themonster] for ");
		player.createStatusEffect(StatusEffects.CooldownSnowballGenerator,8,0,0,0);
		var damage:Number;
		damage = scalingBonusIntelligence() * spellModBlack() * 8;

		damage = calcGlacialMod(damage, true);
		damage = combat.goblinDamageBonus(damage);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (combat.wearingWinterScarf()) damage *= 1.2;
		damage = Math.round(damage);
		doIceDamage(damage, true, true);
		outputText(" damage!");
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		combat.heroBaneProc(damage);
		statScreenRefresh();
		enemyAI();
	}

	public function mechWhitefireBeamCannon():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = Combat.LAST_ATTACK_SPELL;
		outputText("You shoot with the "+(player.vehicles == vehicles.HB_MECH ? "Dragon's Breath Flamer"+((player.keyItemvX("HB Dragon's Breath Flamer", 2) == 2)?"s":"")+"":"Whitefire beam cannon")+" at [themonster] burning [monster his] badly for ");
		if (player.vehicles == vehicles.HB_MECH) {
			if (player.keyItemvX("HB Dragon's Breath Flamer", 2) == 2) {
				if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] >= 200) flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] -= 200;
				else player.soulforce -= 200;
			}
			else {
				if (flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] >= 100) flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] -= 100;
				else player.soulforce -= 100;
			}
		}
		else player.createStatusEffect(StatusEffects.CooldownWhitefireBeamCannon,8,0,0,0);
		var damage:Number;
		damage = scalingBonusIntelligence() * spellModWhite() * 8;

		damage = calcInfernoMod(damage, true);
		damage = combat.goblinDamageBonus(damage);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (monster is GooGirl) damage = Math.round(damage * 1.5);
		if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2);
		damage = Math.round(damage);
		doFireDamage(damage, true, true);
		if (player.keyItemvX("HB Dragon's Breath Flamer", 2) == 2) doFireDamage(damage, true, true);
		outputText(" damage!");
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		combat.heroBaneProc(damage);
		statScreenRefresh();
		enemyAI();
	}

	public function mechDynapunchGlove():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = Combat.LAST_ATTACK_PHYS;
		outputText("You launch the mech springed glove at [themonster] hitting [monster his] straight in the face for a K.O. [themonster] is hit for ");
		player.createStatusEffect(StatusEffects.CooldownDynapunchGlove,8,0,0,0);
		var damage:Number = 0;
		damage += combat.meleeUnarmedDamageNoLagSingle(3);
		damage = combat.goblinDamageBonus(damage);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 15;
		var critDamage:Number = 1.75;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= critDamage;
		}
		damage = Math.round(damage);
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.JobBeastWarrior)) damage *= 1.1;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) damage *= 1.5;
		doDamage(damage);
		outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b> damage");
		if (!monster.hasPerk(PerkLib.Resolute)) {
			outputText(" stunning [monster his] for the round");
			monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
		}
		outputText(".");
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		combat.heroBaneProc(damage);
		statScreenRefresh();
		enemyAI();
	}

	public function PhysicalSpecials() {
	}
}
}