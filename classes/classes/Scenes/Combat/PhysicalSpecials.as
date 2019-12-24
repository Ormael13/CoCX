/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
import classes.BodyParts.Arms;
import classes.BodyParts.Face;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.JewelryLib;
import classes.Items.ShieldLib;
import classes.Items.WeaponLib;
import classes.PerkLib;
import classes.Scenes.Areas.Ocean.SeaAnemone;
import classes.Scenes.Camp.CampMakeWinions;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.Scenes.NPCs.Anemone;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.SceneLib;
import classes.StatusEffects;

import coc.view.ButtonData;
import coc.view.ButtonDataList;

public class PhysicalSpecials extends BaseCombatContent {

	public var winionsMaker:CampMakeWinions = new CampMakeWinions();
	
	//------------
	// P. SPECIALS
	//------------
	internal function buildMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		if (!player.isInGoblinMech()) {
			buttons.add("PowerAttack", powerAttackMenu).hint("Do a single way more powerfull wrath-enhanced strike.");
			if (player.haveWeaponForCleave() && player.hasStatusEffect(StatusEffects.KnowsCleave)) buttons.add("Cleave", pcCleave).hint("Deal extra damage to multiple foes. Cause area effect bleed damage.");
			if (player.hasPerk(PerkLib.SneakyAttack) && player.haveWeaponForSneakAttack() && (monster.hasStatusEffect(StatusEffects.Stunned) || monster.hasStatusEffect(StatusEffects.FreezingBreathStun) || monster.hasStatusEffect(StatusEffects.StunnedTornado)
				|| monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind) || monster.hasStatusEffect(StatusEffects.Distracted))) buttons.add("SneakAttack", sneakAttack).hint("Strike the vitals of a stunned, blinded or distracted opponent for heavy damage.");
			if (player.hasPerk(PerkLib.Feint)) buttons.add("Feint", feint).hint("Attempt to feint an opponent into dropping its guard.");
			if (player.hairType == 4) {
				buttons.add("AnemoneSting", anemoneSting).hint("Attempt to strike an opponent with the stinging tentacles growing from your scalp.  Reduces enemy speed and increases enemy lust.", "Anemone Sting");
			}
			//Bitez
			if (player.faceType == Face.SHARK_TEETH) {
				buttons.add("SharkBite", bite).hint("Attempt to bite your opponent with your shark-teeth.");
			}
			if (player.faceType == Face.ORCA) {
				buttons.add("OrcaBite", bite).hint("Bite in your opponent with your sharp teeths causing bleed.");
			}
			if (player.faceType == Face.WOLF) {
				buttons.add("ViciousBite", bite).hint("Vicious bite your opponent with your sharp teeths causing bleed.");
				if (player.hasPerk(PerkLib.FreezingBreath)) buttons.add("Frostbite", fenrirFrostbite).hint("You bite in your foe slowly infecting it with cold chill weakening its strength and resolve.");
			}
			//hydra bite - variant of snake bite
			if (player.faceType == Face.SNAKE_FANGS || player.hasPerk(PerkLib.VenomGlands)) {
				if (player.lowerBody == LowerBody.HYDRA) {
					bd = buttons.add("HydraBite", hydraBiteAttack).hint("Deal as many attacks as pc got heads. Also delivers naga poison for as many time as pc got heads. (lower enemy str and spe)  \n\nVenom: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
					if (player.tailVenom < 25) {
						bd.disable("You do not have enough venom to use snake bite right now!");
					}
					bd.requireFatigue(physicalCost(10 * player.statusEffectv1(StatusEffects.HydraTailsPlayer)));
				}
				else {
					bd = buttons.add("SnakeBite", nagaBiteAttack).hint("Attempt to bite your opponent and inject venom. (lower enemy str and spe)  \n\nVenom: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
					if (player.tailVenom < 25) {
						bd.disable("You do not have enough venom to use snake bite right now!");
					}
				}
			}
			if (player.faceType == Face.SPIDER_FANGS || player.hasPerk(PerkLib.VenomGlands)) {
				bd = buttons.add("SpiderBite", spiderBiteAttack).hint("Attempt to bite your opponent and inject venom. (deal lust dmg and lower gradualy enemy lust resistance)  \n\nVenom: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
				if (player.tailVenom < 25) {
					bd.disable("You do not have enough venom to use spider bite right now!");
				}
			}
			//Constrict
			if (player.lowerBody == LowerBody.NAGA) {
				buttons.add("Constrict", SceneLib.desert.nagaScene.nagaPlayerConstrict).hint("Attempt to bind an enemy in your long snake-tail.");
			}
			//Grapple
			if (player.lowerBody == LowerBody.SCYLLA) {
				buttons.add("Grapple", scyllaGrapple).hint("Attempt to grapple a foe with your tentacles.");
			}
			//Engulf
			if (player.lowerBody == LowerBody.GOO) {
				buttons.add("Engulf", gooEngulf).hint("Attempt to engulf a foe with your body.");
			}
			//Embrace
			if ((player.wings.type == Wings.BAT_ARM || player.wings.type == Wings.VAMPIRE) && !monster.hasPerk(PerkLib.EnemyGroupType)) {
				buttons.add("Embrace", vampireEmbrace).hint("Embrace an opponent in your wings.");
			}
			//Pounce
			if (player.canPounce() && !monster.hasPerk(PerkLib.EnemyGroupType)) {
				buttons.add("Pounce", catPounce).hint("Pounce and rend your enemy using your claws, this initiate a grapple combo.");
			}
			//Grab & Slam
			if (player.bearpandaScore() >= 10 && !monster.hasPerk(PerkLib.EnemyGroupType)) {
				buttons.add("Grab", bearGrab).hint("Attempt to grab the opponent in your powerful paws. Does not work on opponent taller than you.");
				bd = buttons.add("Slam", bearSlam).hint("Furiously slam your target with your powerful paw, staggering and stunning it.");
				if (player.hasStatusEffect(StatusEffects.CooldownSlamBear)) {
					bd.disable("<b>You need more time before you can perform Slam again.</b>\n\n");
				}
			}
			//Kick attackuuuu
			if (player.isTaur() || player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.BUNNY || player.lowerBody == LowerBody.KANGAROO) {
				bd = buttons.add("Kick", kick).hint("Attempt to kick an enemy using your powerful lower body.");
				if (player.hasStatusEffect(StatusEffects.CooldownKick)) {
					bd.disable("<b>You need more time before you can perform Kick again.</b>\n\n");
				}
			}
			//Gore if mino horns or unicorn/alicorn horns
			if (player.horns.type == Horns.COW_MINOTAUR && player.horns.count >= 6) {
				buttons.add("Gore", goreAttack).hint("Lower your head and charge your opponent, attempting to gore them on your horns.  This attack is stronger and easier to land with large horns.");
			}
			if (player.horns.type == Horns.UNICORN && player.horns.count >= 6) {
				buttons.add("Gore", goreAttack).hint("Lower your head and charge your opponent, attempting to gore them on your horns.  This attack is stronger and easier to land with large horns.");
			}
			//Upheaval - requires rhino horns
			if (player.horns.type == Horns.RHINO && player.horns.count >= 2 && player.faceType == Face.RHINO) {
				bd = buttons.add("Upheaval", upheavalAttack).hint("Send your foe flying with your dual nose mounted horns. \n");
				if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(30));
				else bd.requireFatigue(physicalCost(15));
			}
			//Infest if infested
			if (player.hasStatusEffect(StatusEffects.Infested) && player.statusEffectv1(StatusEffects.Infested) == 5 && player.hasCock()) {
				buttons.add("Infest", SceneLib.mountain.wormsScene.playerInfest).hint("The infest attack allows you to cum at will, launching a stream of semen and worms at your opponent in order to infest them.  Unless your foe is very aroused they are likely to simply avoid it.  Only works on males or herms. \n\nAlso great for reducing your lust.");
			}
			//Kiss supercedes bite.
			if (player.hasStatusEffect(StatusEffects.LustStickApplied)) {
				bd = buttons.add("Kiss", kissAttack).hint("Attempt to kiss your foe on the lips with drugged lipstick.  It has no effect on those without a penis.");
				if(player.hasStatusEffect(StatusEffects.Blind)) {
					bd.disable("There's no way you'd be able to find their lips while you're blind!");
				}
			}
			if (player.arms.type == Arms.MANTIS && player.weapon == WeaponLib.FISTS) {
				bd = buttons.add("Multi Slash", mantisMultiSlash);
				if (player.hasPerk(PerkLib.PhantomStrike)) {
					if (monster.plural) {
						bd.hint("Attempt to slash your foes with your wrists scythes! \n");
						if (player.hasPerk(PerkLib.MantislikeAgilityEvolved)) bd.requireFatigue(100);
						else bd.requireFatigue(120);
					} else {
						bd.hint("Attempt to slash your foe with your wrists scythes! \n");
						if (player.hasPerk(PerkLib.MantislikeAgilityEvolved)) bd.requireFatigue(40);
						else bd.requireFatigue(48);
					}
				}
				else {
					if (monster.plural) {
						bd.hint("Attempt to slash your foes with your wrists scythes! \n");
						if (player.hasPerk(PerkLib.MantislikeAgilityEvolved)) bd.requireFatigue(50);
						else bd.requireFatigue(60);
					} else {
						bd.hint("Attempt to slash your foe with your wrists scythes! \n");
						if (player.hasPerk(PerkLib.MantislikeAgilityEvolved)) bd.requireFatigue(20);
						else bd.requireFatigue(24);
					}
				}
			}
			if (player.tail.isAny(Tail.BEE_ABDOMEN, Tail.SCORPION)) {
				bd = buttons.add("Sting", playerStinger);
				var stingername:String,period:String;
				if (player.tailType == Tail.BEE_ABDOMEN) {
					stingername = "venomous bee stinger";
					period = "your abdomen's refractory period";
				} else if (player.tailType == Tail.SCORPION){
					stingername = "venomous scorpion stinger";
					period = "your refractory period";
				}
				bd.hint("Attempt to use your " + stingername + " on an enemy.  Be aware it takes quite a while for your venom to build up, so depending on " + period + ", you may have to wait quite a while between stings.  \n\nVenom: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
				if (player.tailVenom < 25) {
					bd.disable("You do not have enough venom to sting right now!");
				}
			}
			if (player.tailType == Tail.MANTICORE_PUSSYTAIL) {
				bd = buttons.add("Tail Spike", playerTailSpike).hint("Shoot an envenomed spike at your opponent dealing minor physical damage, slowing its movement speed and inflicting serious lust damage.  \n\nVenom: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
				if (player.tailVenom < 50 && player.hasPerk(PerkLib.ManticoreMetabolism)) {
					bd.disable("You do not have enough venom to shoot spikes right now!");
				}
				else if (player.tailVenom < 25) {
					bd.disable("You do not have enough venom to shoot spike right now!");
				}
			}
			if (player.tailType == Tail.SPIDER_ADBOMEN) {
				bd = buttons.add("Web", PCWebAttack).hint("Attempt to use your abdomen to spray sticky webs at an enemy and greatly slow them down.  Be aware it takes a while for your webbing to build up.  \n\nWeb Amount: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
				if (player.tailVenom < 30) {
					bd.disable("You do not have enough webbing to shoot right now!");
				}
			}
			if (player.tail.isAny(Tail.SHARK, Tail.LIZARD, Tail.KANGAROO, Tail.DRACONIC, Tail.RACCOON, Tail.RED_PANDA)) {
				buttons.add("Tail Whip", tailWhipAttack).hint("Whip your foe with your tail to enrage them and lower their defense!");
			}
			if (player.tailType == Tail.SALAMANDER) {
				bd = buttons.add("Tail Slap", tailSlapAttack).hint("Set ablaze in red-hot flames your tail to whip your foe with it to hurt and burn them!  \n\n<b>AoE attack.</b>");
				if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(80));
				else bd.requireFatigue(physicalCost(40));
			}
			if (player.tailType == Tail.ORCA) {
				bd = buttons.add("Tail Smack", tailSmackAttack).hint("Smack your powerful tail at your opponent face.</b>");
				bd.requireFatigue(physicalCost(40));
				if (player.hasStatusEffect(StatusEffects.CooldownTailSmack)) {
					bd.disable("<b>You need more time before you can perform Tail Smack again.</b>\n\n");
				}
			}
			if (player.hasPerk(PerkLib.InkSpray) && player.gender > 0) {
				var liftWhat:String = player.gender == 1 ? "your cock" : "your front tentacle";
				var liftWha2:String = player.gender == 1 ? "Lift your cock and s" : "S";
				var cooldown:int    = player.hasPerk(PerkLib.ScyllaInkGlands) ? 4 : 8;
				bd = buttons.add("Ink Spray", inkSpray);
				bd.requireFatigue(physicalCost(30));
				if (player.isScylla()) bd.hint("Lift " + liftWhat + " and spray ink to the face of your foe surprising, arousing and blinding them (cooldown of " + cooldown + " rounds before it can be used again)");
				else bd.hint("" + liftWha2 + "pray ink to the face of your foe surprising, arousing and blinding them (cooldown of " + cooldown + " rounds before it can be used again)");
				if (monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind)) {
					bd.disable("<b>" + monster.capitalA + monster.short + " is already affected by blind.</b>\n\n");
				} else if (player.hasStatusEffect(StatusEffects.CooldownInkSpray)) {
					bd.disable("<b>You need more time before you can shoot ink again.</b>\n\n");
				}
			}
			if (player.hasVagina() && (player.cowScore() >= 9 || player.hasPerk(PerkLib.LactaBovinaOvaries))) {
				var blaaaast2:String = player.hasPerk(PerkLib.LactaBovinaOvariesFinalForm) ? " (cooldown of 4 rounds before it can be used again)" : "";
				bd = buttons.add("Milk Blast", milkBlast).hint("Blast your opponent with a powerful stream of milk, arousing and damaging them. The power of the jet is related to arousal, libido and production." + blaaaast2 + "\n");
				if (player.hasPerk(PerkLib.LactaBovinaOvariesFinalForm)) bd.requireLust(200);
				else bd.requireLust(100);
				if (player.hasStatusEffect(StatusEffects.CooldownMilkBlast)) {
					if (player.hasPerk(PerkLib.LactaBovinaOvariesFinalForm)) bd.disable("\n<b>You need more time before you can do it again.</b>");
					else bd.disable("You can't use it more than once during fight.");
				}
			}
			if (player.hasCock() && (player.minotaurScore() >= 9 || player.hasPerk(PerkLib.MinotaurTesticles))) {
				var blaaaast1:String = player.hasPerk(PerkLib.MinotaurTesticlesFinalForm) ? " (cooldown of 4 rounds before it can be used again)" : "";
				bd = buttons.add("Cum Cannon", cumCannon).hint("Blast your opponent with a powerful stream of cum, arousing and damaging them. The power of the jet is related to arousal, libido and production. " + blaaaast1 + "\n");
				if (player.hasPerk(PerkLib.MinotaurTesticlesFinalForm)) bd.requireLust(200);
				else bd.requireLust(100);
				if (player.hasStatusEffect(StatusEffects.CooldownCumCannon)) {
					if (player.hasPerk(PerkLib.MinotaurTesticlesFinalForm)) bd.disable("\n<b>You need more time before you can do it again.</b>");
					else bd.disable("You can't use it more than once during fight.");
				}
			}
			if ((player.pigScore() >= 8 || player.hasPerk(PerkLib.PigBoarFatFinalForm)) && player.thickness >= minThicknessReq()) {
				bd = buttons.add("Body Slam", bodySlam).hint("Body slam your opponent (small chance to stun). Damage scale with toughness and thickness.");
				bd.requireFatigue(physicalCost(50));
			}
			if (player.gooScore() >= 11 || player.magmagooScore() >= 13 || player.darkgooScore() >= 13) {
				bd = buttons.add("Sling Goo", slinggoo).hint("Throw slime at your opponent, lacing it with your aphrodisiac compound and reduce their speed.");
			}
			if (player.canFly()) {
				var flightduration:Number = 6;
				if (player.hasPerk(PerkLib.AdvancedAerialCombat)) flightduration += 2;
				if (player.hasPerk(PerkLib.GreaterAerialCombat)) flightduration += 4;
				buttons.add("Take Flight", takeFlight).hint("Make use of your wings to take flight into the air for up to " + flightduration + " turns. \n\nGives bonus to evasion, speed but also giving penalties to accuracy of range attacks or spells. Not to meantion for non spear users to attack in melee range.");
			}
			if (player.isShieldsForShieldBash()) {
				bd = buttons.add("Shield Bash", shieldBash).hint("Bash your opponent with a shield. Has a chance to stun. Bypasses stun immunity. \n\nThe more you stun your opponent, the harder it is to stun them again.");
				bd.requireFatigue(physicalCost(20));
			}
			if (player.shieldName == "Battle Net") {
				bd = buttons.add("Entangle", netEntangle).hint("Toss your net at the enemy to entangle it. (cooldown of 8 rounds before it can be used again)");
				if (player.hasStatusEffect(StatusEffects.CooldownNet)) bd.disable("<b>You already used Sidewinder today.</b>\n\n");
			}
			if (player.weaponRangePerk == "Bow" && player.hasStatusEffect(StatusEffects.KnowsSidewinder)) {
				bd = buttons.add("Sidewinder", archerSidewinder).hint("The pinacle art of the hunter. Once per day draw on your fatigue to shoot a single heavily infused arrow at a beast or animal morph. This attack never miss.");
				if (player.hasStatusEffect(StatusEffects.CooldownSideWinder)) bd.disable("<b>You already used Sidewinder today.</b>\n\n");
			}
			if (monster.plural) {
				// Whipping
				if (player.isWeaponsForWhipping()) buttons.add("Whipping", whipping).hint("Attack multiple opponent with your held weapon.  \n\n<b>AoE attack.</b>");
				// Whirlwind
				if ((player.isWeaponForWhirlwind() && !player.hasPerk(PerkLib.PowerSweep)) || ((player.isWeaponForWhirlwind() || player.isOneHandedWeapons()) && player.hasPerk(PerkLib.PowerSweep))) buttons.add("Whirlwind", whirlwind).hint("Spin your weapon around to attack multiple enemies at once.  \n\n<b>AoE attack.</b>");
				// Whirlwind (Beast Warrior)
				if (player.findPerk(PerkLib.JobBeastWarrior) >= 0 && ((player.weaponName == "fists" && player.haveNaturalClaws()) || player.haveNaturalClawsTypeWeapon())) buttons.add("F. Whirlwind", whirlwindClaws).hint("Spin yourself around to slash multiple enemies with your claws at once.  \n\n<b>AoE attack.</b>");
				// Barrage
				if (player.weaponRangePerk == "Bow" && player.hasStatusEffect(StatusEffects.KnowsBarrage)) {
					buttons.add("Barrage", archerBarrage).hint("Draw multiple arrow and shoot them all at the same time to hit several target.  \n\n<b>AoE attack.</b>");
				}
			}
			if (player.lowerBody == LowerBody.PLANT_FLOWER) {
				// Pollen
				bd = buttons.add("AlraunePollen", AlraunePollen).hint("Release a cloud of your pollen in the air to arouse your foe.");
				if (player.hasStatusEffect(StatusEffects.AlraunePollen)) bd.disable("<b>You already spread your pollen over battlefield.</b>\n\n");
				// Entangle
				bd = buttons.add("Entangle", AlrauneEntangle).hint("Use your vines to hinder your opponent.");
				if (player.hasStatusEffect(StatusEffects.AlrauneEntangle)) bd.disable("<b>You already entangle your opponent.</b>\n\n");
			}
			if (player.hasStatusEffect(StatusEffects.AlrauneEntangle)) {
				bd = buttons.add("Strangulate", AlrauneStrangulate).hint("Strangle your opponent with your vines.");
				bd.requireFatigue(physicalCost(60));
				if (monster.tallness > 120 || monster.hasPerk(PerkLib.EnemyGigantType)) bd.disable("<b>Your opponent is too tall for Strangulate to have any effect on it.</b>\n\n");
			}
			if (player.hasKeyItem("Rocket Boots") >= 0 || player.hasKeyItem("Nitro Boots") >= 0) {
				if (player.hasKeyItem("Nitro Boots") >= 0) bd = buttons.add("Blazing rocket kick", blazingRocketKick).hint("Deal fire damage using your boots. Also burns.");
				else bd = buttons.add("Rocket kick", blazingRocketKick).hint("Deal fire damage using your boots.");
			}
			if (player.arms.type == Arms.GARGOYLE) {
				bd = buttons.add("Stone Claw", StoneClawAttack).hint("Rend your foe using your sharp stone claws.  \n\nWould go into cooldown after use for: 3 rounds");
				if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(120));
				else bd.requireFatigue(physicalCost(60));
				if (player.hasStatusEffect(StatusEffects.CooldownStoneClaw)) {
					bd.disable("<b>You need more time before you can perform Stone Claw again.</b>\n\n");
				}
			}
			if (player.arms.type == Arms.GARGOYLE_2) {
				bd = buttons.add("Stone Fist", StoneFistAttack).hint("Slam your two fist at your foe and attempt to stun them.  \n\nWould go into cooldown after use for: 3 rounds");
				if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(120));
				else bd.requireFatigue(physicalCost(60));
				if (player.hasStatusEffect(StatusEffects.CooldownStoneFist)) {
					bd.disable("<b>You need more time before you can perform Stone Fist again.</b>\n\n");
				}
			}
			if (player.tailType == Tail.GARGOYLE) {
				bd = buttons.add("Tail Slam", TailSlamAttack).hint("Slam your mace-like tail on your foe's head, dealing severe damage, crushing its defences, and stunning it.  \n\nWould go into cooldown after use for: 5 rounds");
				if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(60));
				else bd.requireFatigue(physicalCost(30));
				if (player.hasStatusEffect(StatusEffects.CooldownTailSlam)) {
					bd.disable("<b>You need more time before you can perform Tail Slam again.</b>\n\n");
				}
			}
			if (player.tailType == Tail.GARGOYLE_2) {
				bd = buttons.add("Tail Cleave", TailCleaveAttack).hint("Swipe your axe-bladed tail, cleaving through multiple opponents and dealing severe bleeding damage.  \n\nWould go into cooldown after use for: 5 rounds");
				if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(60));
				else bd.requireFatigue(physicalCost(30));
				if (player.hasStatusEffect(StatusEffects.CooldownTailCleave)) {
					bd.disable("<b>You need more time before you can perform Tail Cleave again.</b>\n\n");
				}
			}
			if (player.wings.type == Wings.GARGOYLE_LIKE_LARGE) {
				bd = buttons.add("Wing Buffet", WingBuffetAttack).hint("Buffet your foe using your two massive wings, staggering them.  \n\nWould go into cooldown after use for: 6 rounds");
				if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(60));
				else bd.requireFatigue(physicalCost(30));
				if (player.hasStatusEffect(StatusEffects.CooldownWingBuffet)) {
					bd.disable("<b>You need more time before you can perform Wing Buffet again.</b>\n\n");
				}
			}
		}
		if (player.isInGoblinMech()) {
			if (player.hasKeyItem("Dynapunch Glove") >= 0) {
				bd = buttons.add("Dynapunch G.", mechDynapunchGlove).hint("Shoot a springed gloved fist at the opponent with a rocket punch stunning for one round and dealing damage. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownDynapunchGlove)) {
					bd.disable("<b>You need more time before you can use Dynapunch Glove again.</b>\n\n");
				}
			}
			if (player.hasKeyItem("Taser") >= 0) {
				if (player.hasKeyItem("Taser with an overcharged battery") >= 0) bd = buttons.add("Tazer", mechTazer).hint("A voltage rod set on the mech as an upgrade can be used to temporarily paralyse the opponent. Deals some lesser lightning damage and stun for 4 rounds. \n\nWould go into cooldown after use for: 8 rounds");
				else bd = buttons.add("Tazer", mechTazer).hint("A voltage rod set on the mech as an upgrade can be used to temporarily paralyse the opponent. Deals no damage and stun for 2 rounds. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownTazer)) {
					bd.disable("<b>You need more time before you can use Tazer again.</b>\n\n");
				}
			}
			if (player.hasKeyItem("Missile launcher") >= 0) bd = buttons.add("Missile launcher", mechOmniMissile).hint("Fire missile that will cover a wide area of effect.");
			if (player.hasKeyItem("Omni Missile") >= 0) bd = buttons.add("Omni Missile", mechOmniMissile).hint("Fire omni missiles that will cover a wide area of effect.");
			if (player.hasKeyItem("Whitefire Beam Cannon") >= 0) {
				bd = buttons.add("Whitefire B.C.", mechWhitefireBeamCannon).hint("Shoot with the whitefire beam cannon at enemy burning him. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownWhitefireBeamCannon)) {
					bd.disable("<b>You need more time before you can use Whitefire Beam Cannon again.</b>\n\n");
				}
			}
			if (player.hasKeyItem("Snowball Generator") >= 0) {
				bd = buttons.add("Snowball G.", mechSnowballGenerator).hint("Activate the snowball generator taking aim and launching a volley of snowballs at the enemy. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownSnowballGenerator)) {
					bd.disable("<b>You need more time before you can use Snowball Generator again.</b>\n\n");
				}
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
				}
			}
			if (player.hasKeyItem("Stimpack Dispenser 1.0") >= 0 || player.hasKeyItem("Medical Dispenser 2.0") >= 0) {
				if (player.hasKeyItem("Medical Dispenser 2.0") >= 0) bd = buttons.add("Medical Dispenser 2.0", mechStimpackMedicalDispenser).hint("Activate to gain swift improved medical treatment. Be wary of secondary effects. \n\nWould go into cooldown after use for: 15 rounds");
				else bd = buttons.add("Stimpack Dispenser 1.0", mechStimpackMedicalDispenser).hint("Activate to gain swift medical treatment. Be wary of secondary effects. \n\nWould go into cooldown after use for: 20 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownStimpackDispenser)) {
					bd.disable("<b>You need more time before you can use "+(player.hasKeyItem("Medical Dispenser 2.0") >= 0 ? "Medical Dispenser":"Stimpack Dispenser")+" again.</b>\n\n");
				}
			}
			if (player.hasKeyItem("Jetpack") >= 0 || player.hasKeyItem("MK2 Jetpack") >= 0) {
				buttons.add("Jetpack", takeFlightGoglinMech).hint("Make use of your mech jetpack to take flight into the air for up to 5 turns. \n\nWould go into cooldown after use for: 3 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownJetpack)) {
					bd.disable("<b>You need more time before you can use jetpack again.</b>\n\n");
				}
			}
		}
	}
	internal function buildMenuForFlying(buttons:ButtonDataList):void {
		var bd:ButtonData;
		if (!player.isInGoblinMech()) {
			buttons.add("Great Dive", combat.greatDive).hint("Make a Great Dive to deal TONS of damage!");
			//Embrace
			if ((player.wings.type == Wings.BAT_ARM || player.wings.type == Wings.VAMPIRE) && !monster.hasPerk(PerkLib.EnemyGroupType)) {
				buttons.add("Embrace", vampireEmbrace).hint("Embrace an opponent in your wings.");
			}
			//Sky Pounce
			if (player.canPounce() && !monster.hasPerk(PerkLib.EnemyGroupType)) {
				buttons.add("Skyrend", skyPounce).hint("Land into your enemy dealing damage and initiate a grapple combo. End flight.");
			}				
			//Tornado Strike
			if (player.couatlScore() >= 11) {
				bd = buttons.add("Tornado Strike", TornadoStrike).hint("Use wind to forcefully lift a foe in the air and deal damage.  \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(120));
				else bd.requireFatigue(physicalCost(60));
				if (player.hasStatusEffect(StatusEffects.CooldownTornadoStrike)) {
					bd.disable("<b>You need more time before you can perform Tornado Strike again.</b>\n\n");
				}
			}
			//Wing Slap
			if (player.haveWingsForWingSlap()) {
				bd = buttons.add("Wing Slap", wingSlapAttack).hint("Slap enemy with your wings.");
				if (player.hasPerk(PerkLib.PhantomStrike)) bd.requireFatigue(physicalCost(80));
				else bd.requireFatigue(physicalCost(40));
			}
		}
		if (player.isInGoblinMech()) {
			if (player.hasKeyItem("Dynapunch Glove") >= 0) {
				bd = buttons.add("Dynapunch G.", mechDynapunchGlove).hint("Shoot a springed gloved fist at the opponent with a rocket punch stunning for one round and dealing damage. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownDynapunchGlove)) {
					bd.disable("<b>You need more time before you can use Dynapunch Glove again.</b>\n\n");
				}
			}
			if (player.hasKeyItem("Taser") >= 0) {
				if (player.hasKeyItem("Taser with an overcharged battery") >= 0) bd = buttons.add("Tazer", mechTazer).hint("A voltage rod set on the mech as an upgrade can be used to temporarily paralyse the opponent. Deals some lesser lightning damage and stun for 4 rounds. \n\nWould go into cooldown after use for: 8 rounds");
				else bd = buttons.add("Tazer", mechTazer).hint("A voltage rod set on the mech as an upgrade can be used to temporarily paralyse the opponent. Deals no damage and stun for 2 rounds. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownTazer)) {
					bd.disable("<b>You need more time before you can use Tazer again.</b>\n\n");
				}
			}
			if (player.hasKeyItem("Missile launcher") >= 0) bd = buttons.add("Missile launcher", mechOmniMissile).hint("Fire missile that will cover a wide area of effect.");
			if (player.hasKeyItem("Omni Missile") >= 0) bd = buttons.add("Omni Missile", mechOmniMissile).hint("Fire omni missiles that will cover a wide area of effect.");
			if (player.hasKeyItem("Whitefire Beam Cannon") >= 0) {
				bd = buttons.add("Whitefire B.C.", mechWhitefireBeamCannon).hint("Shoot with the whitefire beam cannon at enemy burning him. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownWhitefireBeamCannon)) {
					bd.disable("<b>You need more time before you can use Whitefire Beam Cannon again.</b>\n\n");
				}
			}
			if (player.hasKeyItem("Snowball Generator") >= 0) {
				bd = buttons.add("Snowball G.", mechSnowballGenerator).hint("Activate the snowball generator taking aim and launching a volley of snowballs at the enemy. \n\nWould go into cooldown after use for: 8 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownSnowballGenerator)) {
					bd.disable("<b>You need more time before you can use Snowball Generator again.</b>\n\n");
				}
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
				}
			}
			if (player.hasKeyItem("Stimpack Dispenser 1.0") >= 0 || player.hasKeyItem("Medical Dispenser 2.0") >= 0) {
				if (player.hasKeyItem("Medical Dispenser 2.0") >= 0) bd = buttons.add("Medical Dispenser 2.0", mechStimpackMedicalDispenser).hint("Activate to gain swift improved medical treatment. Be wary of secondary effects. \n\nWould go into cooldown after use for: 15 rounds");
				else bd = buttons.add("Stimpack Dispenser 1.0", mechStimpackMedicalDispenser).hint("Activate to gain swift medical treatment. Be wary of secondary effects. \n\nWould go into cooldown after use for: 20 rounds");
				if (player.hasStatusEffect(StatusEffects.CooldownStimpackDispenser)) {
					bd.disable("<b>You need more time before you can use "+(player.hasKeyItem("Medical Dispenser 2.0") >= 0 ? "Medical Dispenser":"Stimpack Dispenser")+" again.</b>\n\n");
				}
			}
		}
	}
	
	public function powerAttackMenu():void {
		menu();
		if (player.hasPerk(PerkLib.JobWarrior) || player.hasPerk(PerkLib.JobBeastWarrior)) {
			addButton(0, "2x", powerAttack2x).disableIf(player.wrath < powerfistscoooooost(),"You are too calm to use this special. Req. " + powerfistscoooooost() + "+ wrath");
			if (player.level >= 6) {
				addButton(1, "3x", powerAttack3x).disableIf(player.wrath < (powerfistscoooooost() * 2),"You are too calm to use this special. Req. " + powerfistscoooooost() * 2 + "+ wrath");
			} else addButtonDisabled(1, "???");
			if (player.level >= 12) {
				addButton(2, "4x", powerAttack4x).disableIf(player.wrath < (powerfistscoooooost() * 4),"You are too calm to use this special. Req. " + powerfistscoooooost() * 4 + "+ wrath");
			} else addButtonDisabled(2, "???");
			if (player.level >= 18) {
				addButton(3, "5x", powerAttack5x).disableIf(player.wrath < (powerfistscoooooost() * 6),"You are too calm to use this special. Req. " + powerfistscoooooost() * 6 + "+ wrath");
			} else addButtonDisabled(3, "???");
			if (player.level >= 24) {
				addButton(4, "6x", powerAttack6x).disableIf(player.wrath < (powerfistscoooooost() * 8),"You are too calm to use this special. Req. " + powerfistscoooooost() * 8 + "+ wrath");
			} else addButtonDisabled(4, "???");
			if (player.level >= 30) {
				addButton(5, "7x", powerAttack7x).disableIf(player.wrath < (powerfistscoooooost() * 10),"You are too calm to use this special. Req. " + powerfistscoooooost() * 10 + "+ wrath");
			} else addButtonDisabled(5, "???");
			if (player.level >= 36) {
				addButton(6, "8x", powerAttack8x).disableIf(player.wrath < (powerfistscoooooost() * 12),"You are too calm to use this special. Req. " + powerfistscoooooost() * 12 + "+ wrath");
			} else addButtonDisabled(6, "???");
		}
		else addButton(0, "2x", powerAttack2x).disableIf(player.wrath < 200,"You are too calm to use this special. Req. 200+ wrath");
		addButton(14, "Back", combat.ui.submenuPhySpecials);
	}
	public function powerAttack2x():void {
		clearOutput();
		if (player.hasPerk(PerkLib.JobWarrior) || player.hasPerk(PerkLib.JobBeastWarrior)) player.wrath -= powerfistscoooooost();
		else player.wrath -= 200;
		if (player.canFly()) outputText("You fly by your opponent, striking with your [weapon], utilizing  your full strength in tandem with your flight momentum. ");
		else if (player.isTaur()) {
			outputText("You ");
			if (player.lowerBody == LowerBody.HOOFED) outputText("gallop");
			else outputText("run");
			outputText(" a few meter back and make a U-Turn for a powerful charge, utilizing the full strength and momentum provided by your [race] body. ");
		}
		else outputText("You lift your [weapon] with all of your strenght and smash it on your foe head. ");
		var damage:Number = 0;
		var PAMulti:Number = 2;
		if ((player.weapon == weapons.PRURUMI && player.spe >= 150) || player.jewelry == jewelries.UNDKINS || player.jewelry3 == jewelries3.UNDKINS) PAMulti += powerfistsmultipoweeeeer();
		damage += powerfistspoweeeeer();
		damage *= PAMulti;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.WeaponMastery) && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
		if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.weaponPerk == "Dual Large" && player.str >= 140) critChance += 10;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			if (player.hasPerk(PerkLib.Impale) && (!player.hasPerk(PerkLib.DoubleAttack) || (player.hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= 2.5;
			else damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b> damage. ");
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}
	public function powerAttack3x():void {
		clearOutput();
		player.wrath -= powerfistscoooooost() * 2;
		if (player.canFly()) outputText("You fly by your opponent, striking with your [weapon], utilizing  your full strength in tandem with your flight momentum. ");
		else if (player.isTaur()) {
			outputText("You ");
			if (player.lowerBody == LowerBody.HOOFED) outputText("gallop");
			else outputText("run");
			outputText(" a few meter back and make a U-Turn for a powerful charge, utilizing the full strength and momentum provided by your [race] body. ");
		}
		else outputText("You lift your [weapon] with all of your strenght and smash it on your foe head. ");
		var damage:Number = 0;
		var PAMulti:Number = 3;
		if ((player.weapon == weapons.PRURUMI && player.spe >= 150) || player.jewelry == jewelries.UNDKINS || player.jewelry3 == jewelries3.UNDKINS) PAMulti += powerfistsmultipoweeeeer();
		damage += powerfistspoweeeeer();
		damage *= PAMulti;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.WeaponMastery) && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
		if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.weaponPerk == "Dual Large" && player.str >= 140) critChance += 10;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			if (player.hasPerk(PerkLib.Impale) && (!player.hasPerk(PerkLib.DoubleAttack) || (player.hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= 2.5;
			else damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b> damage. ");
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}
	public function powerAttack4x():void {
		clearOutput();
		player.wrath -= powerfistscoooooost() * 4;
		if (player.canFly()) outputText("You fly by your opponent, striking with your [weapon], utilizing  your full strength in tandem with your flight momentum. ");
		else if (player.isTaur()) {
			outputText("You ");
			if (player.lowerBody == LowerBody.HOOFED) outputText("gallop");
			else outputText("run");
			outputText(" a few meter back and make a U-Turn for a powerful charge, utilizing the full strength and momentum provided by your [race] body. ");
		}
		else outputText("You lift your [weapon] with all of your strenght and smash it on your foe head. ");
		var damage:Number = 0;
		var PAMulti:Number = 4;
		if ((player.weapon == weapons.PRURUMI && player.spe >= 150) || player.jewelry == jewelries.UNDKINS || player.jewelry3 == jewelries3.UNDKINS) PAMulti += powerfistsmultipoweeeeer();
		damage += powerfistspoweeeeer();
		damage *= PAMulti;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.WeaponMastery) && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
		if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.weaponPerk == "Dual Large" && player.str >= 140) critChance += 10;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			if (player.hasPerk(PerkLib.Impale) && (!player.hasPerk(PerkLib.DoubleAttack) || (player.hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= 2.5;
			else damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b> damage. ");
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}
	public function powerAttack5x():void {
		clearOutput();
		player.wrath -= powerfistscoooooost() * 6;
		if (player.canFly()) outputText("You fly by your opponent, striking with your [weapon], utilizing  your full strength in tandem with your flight momentum. ");
		else if (player.isTaur()) {
			outputText("You ");
			if (player.lowerBody == LowerBody.HOOFED) outputText("gallop");
			else outputText("run");
			outputText(" a few meter back and make a U-Turn for a powerful charge, utilizing the full strength and momentum provided by your [race] body. ");
		}
		else outputText("You lift your [weapon] with all of your strenght and smash it on your foe head. ");
		var damage:Number = 0;
		var PAMulti:Number = 5;
		if ((player.weapon == weapons.PRURUMI && player.spe >= 150) || player.jewelry == jewelries.UNDKINS || player.jewelry3 == jewelries3.UNDKINS) PAMulti += powerfistsmultipoweeeeer();
		damage += powerfistspoweeeeer();
		damage *= PAMulti;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.WeaponMastery) && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
		if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.weaponPerk == "Dual Large" && player.str >= 140) critChance += 10;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			if (player.hasPerk(PerkLib.Impale) && (!player.hasPerk(PerkLib.DoubleAttack) || (player.hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= 2.5;
			else damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b> damage. ");
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}
	public function powerAttack6x():void {
		clearOutput();
		player.wrath -= powerfistscoooooost() * 8;
		if (player.canFly()) outputText("You fly by your opponent, striking with your [weapon], utilizing  your full strength in tandem with your flight momentum. ");
		else if (player.isTaur()) {
			outputText("You ");
			if (player.lowerBody == LowerBody.HOOFED) outputText("gallop");
			else outputText("run");
			outputText(" a few meter back and make a U-Turn for a powerful charge, utilizing the full strength and momentum provided by your [race] body. ");
		}
		else outputText("You lift your [weapon] with all of your strenght and smash it on your foe head. ");
		var damage:Number = 0;
		var PAMulti:Number = 6;
		if ((player.weapon == weapons.PRURUMI && player.spe >= 150) || player.jewelry == jewelries.UNDKINS || player.jewelry3 == jewelries3.UNDKINS) PAMulti += powerfistsmultipoweeeeer();
		damage += powerfistspoweeeeer();
		damage *= PAMulti;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.WeaponMastery) && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
		if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.weaponPerk == "Dual Large" && player.str >= 140) critChance += 10;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			if (player.hasPerk(PerkLib.Impale) && (!player.hasPerk(PerkLib.DoubleAttack) || (player.hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= 2.5;
			else damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b> damage. ");
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}
	public function powerAttack7x():void {
		clearOutput();
		player.wrath -= powerfistscoooooost() * 10;
		if (player.canFly()) outputText("You fly by your opponent, striking with your [weapon], utilizing  your full strength in tandem with your flight momentum. ");
		else if (player.isTaur()) {
			outputText("You ");
			if (player.lowerBody == LowerBody.HOOFED) outputText("gallop");
			else outputText("run");
			outputText(" a few meter back and make a U-Turn for a powerful charge, utilizing the full strength and momentum provided by your [race] body. ");
		}
		else outputText("You lift your [weapon] with all of your strenght and smash it on your foe head. ");
		var damage:Number = 0;
		var PAMulti:Number = 7;
		if ((player.weapon == weapons.PRURUMI && player.spe >= 150) || player.jewelry == jewelries.UNDKINS || player.jewelry3 == jewelries3.UNDKINS) PAMulti += powerfistsmultipoweeeeer();
		damage += powerfistspoweeeeer();
		damage *= PAMulti;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.WeaponMastery) && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
		if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.weaponPerk == "Dual Large" && player.str >= 140) critChance += 10;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			if (player.hasPerk(PerkLib.Impale) && (!player.hasPerk(PerkLib.DoubleAttack) || (player.hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= 2.5;
			else damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b> damage. ");
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}
	public function powerAttack8x():void {
		clearOutput();
		player.wrath -= powerfistscoooooost() * 12;
		if (player.canFly()) outputText("You fly by your opponent, striking with your [weapon], utilizing  your full strength in tandem with your flight momentum. ");
		else if (player.isTaur()) {
			outputText("You ");
			if (player.lowerBody == LowerBody.HOOFED) outputText("gallop");
			else outputText("run");
			outputText(" a few meter back and make a U-Turn for a powerful charge, utilizing the full strength and momentum provided by your [race] body. ");
		}
		else outputText("You lift your [weapon] with all of your strenght and smash it on your foe head. ");
		var damage:Number = 0;
		var PAMulti:Number = 8;
		if ((player.weapon == weapons.PRURUMI && player.spe >= 150) || player.jewelry == jewelries.UNDKINS || player.jewelry3 == jewelries3.UNDKINS) PAMulti += powerfistsmultipoweeeeer();
		damage += powerfistspoweeeeer();
		damage *= PAMulti;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.WeaponMastery) && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
		if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.weaponPerk == "Dual Large" && player.str >= 140) critChance += 10;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			if (player.hasPerk(PerkLib.Impale) && (!player.hasPerk(PerkLib.DoubleAttack) || (player.hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= 2.5;
			else damage *= 1.75;
		}
		damage = Math.round(damage);
		if (player.weapon == weapons.L_WHIP) damage = doFireDamage(damage, true, true);
		else if ((player.weapon == weapons.RCLAYMO || player.weapon == weapons.RDAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doFireDamage(damage, true, true);
		else if ((player.weapon == weapons.SCLAYMO || player.weapon == weapons.SDAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doIceDamage(damage, true, true);
		else if ((player.weapon == weapons.TCLAYMO || player.weapon == weapons.TODAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doLightingDamage(damage, true, true);
		else if ((player.weapon == weapons.ACLAYMO || player.weapon == weapons.ADAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doDarknessDamage(damage, true, true);
		else if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) damage = doFireDamage(damage, true, true);
		else if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			damage = doDamage(damage, true, true);
			damage = doFireDamage(Math.round(damage*0.1), true, true);
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
			damage = Math.round(damage * 1.1);
		}
		else damage = doDamage(damage, true, true);
		outputText(" damage. ");
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}
	public function powerfistscoooooost():Number {
		var powerfistscostvalue:Number = 50;
		return powerfistscostvalue;
	}
	public function powerfistspoweeeeer():Number {
		var powerfistspowervalue:Number = 0;
		powerfistspowervalue += player.str;
		powerfistspowervalue += scalingBonusStrength() * 0.25;
		if (player.hasPerk(PerkLib.HoldWithBothHands) && !player.isFistOrFistWeapon() && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) powerfistspowervalue *= 1.2;
		if (powerfistspowervalue < 10) powerfistspowervalue = 10;
		if (player.weaponAttack < 51) powerfistspowervalue *= (1 + (player.weaponAttack * 0.03));
		else if (player.weaponAttack >= 51 && player.weaponAttack < 101) powerfistspowervalue *= (2.5 + ((player.weaponAttack - 50) * 0.025));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 151) powerfistspowervalue *= (3.75 + ((player.weaponAttack - 100) * 0.02));
		else if (player.weaponAttack >= 151 && player.weaponAttack < 201) powerfistspowervalue *= (4.75 + ((player.weaponAttack - 150) * 0.015));
		else powerfistspowervalue *= (5.5 + ((player.weaponAttack - 200) * 0.01));
		if (player.haveWeaponForJouster()) {
			if (player.isMeetingNaturalJousterReq()) powerfistspowervalue *= 3;
			if (player.isMeetingNaturalJousterMasterGradeReq()) powerfistspowervalue *= 5;
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
			if (player.mouseScore() >= 12 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) powerfistspowervalue *= 2.2;
			else powerfistspowervalue *= 2;
		}
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) powerfistspowervalue *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) powerfistspowervalue *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) powerfistspowervalue *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) powerfistspowervalue *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) powerfistspowervalue *= 2;
		if (player.armor == armors.SPKIMO) powerfistspowervalue *= 1.2;
		if (player.necklace == necklaces.OBNECK) powerfistspowervalue *= 1.2;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) powerfistspowervalue *= combat.oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) powerfistspowervalue *= 2;
		return powerfistspowervalue;
	}
	public function powerfistsmultipoweeeeer():Number {
		var powerfistsmultipowervalue:Number = 0;
		if (player.weapon == weapons.PRURUMI && player.spe >= 150) {
			powerfistsmultipowervalue += 1;
			if (player.spe >= 225) powerfistsmultipowervalue += 1;
			if (player.spe >= 300) powerfistsmultipowervalue += 1;
		}
		if (player.jewelry == jewelries.UNDKINS || player.jewelry3 == jewelries3.UNDKINS) {
			powerfistsmultipowervalue += 1;
		}
		return powerfistsmultipowervalue;
	}
	
	public function pcCleave():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
			outputText("You are too tired to attack " + monster.a + " " + monster.short + ".");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(50, USEFATG_PHYSICAL);
		outputText("You go for one mighty swing of your [weapon], effectively cleaving through everyone in front of you in an horizontal arc. Your strike leaves ");
		if (!monster.hasPerk(PerkLib.EnemyGroupType)) outputText("a ");
		outputText("deep gushing wound");
		if (monster.hasPerk(PerkLib.EnemyGroupType)) outputText("s");
		outputText(" in your ");
		if (monster.hasPerk(PerkLib.EnemyGroupType)) outputText("foes. ");
		else outputText("foe. ");
		var damage:Number = 0;
		damage += player.str;
		damage += scalingBonusStrength() * 0.25;
		if (player.hasPerk(PerkLib.HoldWithBothHands) && !player.isFistOrFistWeapon() && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
		if (damage < 10) damage = 10;
		if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.03));
		else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (2.5 + ((player.weaponAttack - 50) * 0.025));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (3.75 + ((player.weaponAttack - 100) * 0.02));
		else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (4.75 + ((player.weaponAttack - 150) * 0.015));
		else damage *= (5.5 + ((player.weaponAttack - 200) * 0.01));
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		if (monster.hasPerk(PerkLib.EnemyGroupType)) damage *= 3;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.WeaponMastery) && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
		if (player.hasPerk(PerkLib.WeaponGrandMastery) && player.weaponPerk == "Dual Large" && player.str >= 140) critChance += 10;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		if (player.weapon == weapons.PRURUMI) {
			damage = doDamage(damage, true, true);
			if (player.spe >= 150) damage = doDamage(damage, true, true);
			if (player.spe >= 225) damage = doDamage(damage, true, true);
			if (player.spe >= 300) damage = doDamage(damage, true, true);
		}
		else if (player.weapon == weapons.RCLAYMO && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doFireDamage(damage, true, true);
		else if (player.weapon == weapons.SCLAYMO && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doIceDamage(damage, true, true);
		else if (player.weapon == weapons.TCLAYMO && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doLightingDamage(damage, true, true);
		else if (player.weapon == weapons.ACLAYMO && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doDarknessDamage(damage, true, true);
		else damage = doDamage(damage, true, true);
		if (crit == true) {
			outputText(" <b>Critical!</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		outputText("\n\n");
		combat.heroBaneProc(damage);
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
		outputText("You strike " + monster.a + " " + monster.short + " vitals with your [weapon]. ");
		var damage:Number = 0;
		var SAMulti:Number = 2;
		if (player.weapon == weapons.ANGSTD) SAMulti += 2;
		if (player.hasPerk(PerkLib.DeadlySneaker)) SAMulti += 2;
		if (player.hasPerk(PerkLib.Slayer)) SAMulti += 3;
		damage += player.str;
		damage += scalingBonusStrength() * 0.25;
		if (player.hasPerk(PerkLib.SpeedDemon) && player.isNoLargeNoStaffWeapon()) {
			damage += player.spe;
			damage += scalingBonusSpeed() * 0.20;
		}
		if (player.hasPerk(PerkLib.QuickStrike) && (player.weaponPerk == "Small" || player.weaponPerk == "Dual Small")) {
			damage += (player.spe / 2);
			damage += scalingBonusSpeed() * 0.10;
		}
		if (player.hasPerk(PerkLib.HoldWithBothHands) && !player.isFistOrFistWeapon() && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
		if (damage < 10) damage = 10;
		if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.03));
		else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (2.5 + ((player.weaponAttack - 50) * 0.025));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (3.75 + ((player.weaponAttack - 100) * 0.02));
		else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (4.75 + ((player.weaponAttack - 150) * 0.015));
		else damage *= (5.5 + ((player.weaponAttack - 200) * 0.01));
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		damage *= SAMulti;
		var crit:Boolean = false;
		var critChance:int = 5;
		var critMulti:Number = 1.75;//coś innego tu wpisać jako perk pozwalający na wyższy mnożnik krytyków
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (player.hasStatusEffect(StatusEffects.Rage)) critChance += player.statusEffectv1(StatusEffects.Rage);
		critChance *= 2;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= critMulti;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b> ");
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			damage = doDamage(damage);
			outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b> ");
			damage *= 2;
		}
		if (crit == true) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (flags[kFLAGS.ENVENOMED_MELEE_ATTACK] == 1 && (player.weaponPerk == "Small" || player.weaponPerk == "Dual Small")) {
			if (player.tailVenom >= 10) {
				outputText("  ");
				if(monster.lustVuln == 0) {
					outputText("  It has no effect!  Your foe clearly does not experience lust in the same way as you.");
				}
				if (player.tailType == Tail.BEE_ABDOMEN) {
					outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
					var damageB:Number = 35 + rand(player.lib/10);
					if (player.level < 10) damageB += 20 + (player.level * 3);
					else if (player.level < 20) damageB += 50 + (player.level - 10) * 2;
					else if (player.level < 30) damageB += 70 + (player.level - 20) * 1;
					else damageB += 80;
					damageB *= 0.2;
					monster.teased(monster.lustVuln * damageB);
					if (monster.hasStatusEffect(StatusEffects.NagaVenom))
					{
						monster.addStatusValue(StatusEffects.NagaVenom,3,1);
					}
					else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
					player.tailVenom -= 5;
				}
				if (player.tailType == Tail.SCORPION) {
					outputText("  [monster he] seems to be effected by the poison, its movement turning sluggish.");
					monster.spe -= 2;
					if (monster.spe < 1) monster.spe = 1;
					if (monster.hasStatusEffect(StatusEffects.NagaVenom))
					{
						monster.addStatusValue(StatusEffects.NagaVenom,3,1);
					}
					else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
					player.tailVenom -= 5;
				}
				if (player.tailType == Tail.MANTICORE_PUSSYTAIL) {
					outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
					var lustdamage:Number = 35 + rand(player.lib / 10);
					if (player.level < 10) damage += 20 + (player.level * 3);
					else if (player.level < 20) damage += 50 + (player.level - 10) * 2;
					else if (player.level < 30) damage += 70 + (player.level - 20) * 1;
					else damage += 80;
					lustdamage *= 0.14;
					monster.teased(monster.lustVuln * lustdamage);
					monster.tou -= 2;
					if (monster.tou < 1) monster.tou = 1;
					if (monster.hasStatusEffect(StatusEffects.NagaVenom))
					{
						monster.addStatusValue(StatusEffects.NagaVenom,3,1);
					}
					else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
					player.tailVenom -= 5;
				}
				if (player.faceType == Face.SNAKE_FANGS) {
					outputText("  [monster he] seems to be effected by the poison, its movement turning sluggish.");
					monster.spe -= 0.4;
					monster.spe -= 0.4;
					if (monster.spe < 1) monster.spe = 1;
					if (monster.spe < 1) monster.spe = 1;
					if (monster.hasStatusEffect(StatusEffects.NagaVenom))
					{
						monster.addStatusValue(StatusEffects.NagaVenom,2,0.4);
						monster.addStatusValue(StatusEffects.NagaVenom,1,0.4);
					}
					else monster.createStatusEffect(StatusEffects.NagaVenom, 0.4, 0.4, 0, 0);
					player.tailVenom -= 5;
				}
				if (player.faceType == Face.SPIDER_FANGS) {
					outputText("  [monster he] seems to be affected by the poison, showing increasing sign of arousal.");
					var lustDmg:int = 6 * monster.lustVuln;
					monster.teased(lustDmg);
					if (monster.lustVuln > 0) {
						monster.lustVuln += 0.01;
						if (monster.lustVuln > 1) monster.lustVuln = 1;
					}
					player.tailVenom -= 5;
				}
				if (monster.lust >= monster.maxLust()) {
					outputText("\n\n");
					checkAchievementDamage(damage);
					doNext(endLustVictory);
				}
			}
			else outputText("  You do not have enough venom to apply on [weapon]!");
		}
		outputText("\n\n");
		combat.checkAchievementDamage(damage);
		combat.WrathWeaponsProc();
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}
	
	public function feint():void {
		clearOutput();
		outputText("You attempt to feint " + monster.a + " " + monster.short + " into dropping " + monster.pronoun3 + " guards. It ");
		if (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80) outputText("failed.");
		else {
			var feintduration:Number = 2;
			if (player.hasPerk(PerkLib.GreaterFeint)) feintduration += 2;
			outputText("worked!");
			monster.createStatusEffect(StatusEffects.Distracted, feintduration, 0, 0, 0);
		}
		outputText("\n\n");
		enemyAI();
	}

	public function whirlwind():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
			outputText("You are too tired to attack " + monster.a + " " + monster.short + ".");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(50, USEFATG_PHYSICAL);
		outputText("You ready your [weapon] and prepare to spin it around trying to hit as many " + monster.a + monster.short + " as possible.  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
			enemyAI();
			return;
		}
		var damage:Number = 0;
		damage += player.str;
		if (player.hasPerk(PerkLib.Whirlwind)) damage += scalingBonusStrength() * 0.2;
		if (damage < 10) damage = 10;
		//weapon bonus
		if (player.weaponAttack < 101) damage *= (1 + (player.weaponAttack * 0.02));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 201) damage *= (2 + ((player.weaponAttack - 100) * 0.015));
		else damage *= (3.5 + ((player.weaponAttack - 200) * 0.01));
		//other bonuses
		if (player.hasPerk(PerkLib.HoldWithBothHands) && !player.isFistOrFistWeapon() && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.hasPerk(PerkLib.PowerSweep)) {
			if (player.isWeaponForWhirlwind()) damage *= 1.25;
			else damage *= 0.75;
		}
		if (player.weaponPerk == "Dual" || player.weaponPerk == "Dual Large") {
			if (player.hasPerk(PerkLib.MakeItDouble)) damage *= 2;
			else damage *= 1.25;
		}
		if (player.hasPerk(PerkLib.GiantsReach) && (player.weaponPerk == "Large" || player.weaponPerk == "Dual Large")) damage *= 1.25;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
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
			damage *= 1.75;
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
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		outputText("Your [weapon] hits few of " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
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
		fatigue(50, USEFATG_PHYSICAL);
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
		if (player.hasPerk(PerkLib.Whipping)) damage += scalingBonusStrength() * 0.2;
		if (damage < 10) damage = 10;
		//weapon bonus
		if (player.weaponAttack < 101) damage *= (1 + (player.weaponAttack * 0.02));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 201) damage *= (2 + ((player.weaponAttack - 100) * 0.015));
		else damage *= (3.5 + ((player.weaponAttack - 200) * 0.01));
		//other bonuses
		if (player.hasPerk(PerkLib.HoldWithBothHands) && !player.isFistOrFistWeapon() && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.weaponPerk == "Dual" || player.weaponPerk == "Dual Large") {
			if (player.hasPerk(PerkLib.MakeItDouble)) damage *= 2;
			else damage *= 1.25;
		}
		if (player.hasPerk(PerkLib.GiantsReach) && (player.weaponPerk == "Large" || player.weaponPerk == "Dual Large")) damage *= 1.25;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
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
			damage *= 1.75;
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
		damage *= (monster.damagePercent() / 100);
		outputText("Your [weapon] whipped few of " + monster.a + monster.short + ", dealing ");
		if (player.weapon == weapons.L_WHIP) damage = doFireDamage(damage, true, true);
		else damage = doDamage(damage, true, true);
		outputText(" damage! ");
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}

	public function whirlwindClaws():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
			outputText("You are too tired to attack " + monster.a + " " + monster.short + ".");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		outputText("You ready your claws and prepare to spin it around trying to hit as many " + monster.a + monster.short + " as possible.  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
			enemyAI();
			return;
		}
		fatigue(50, USEFATG_PHYSICAL);
		var damage:Number = 0;
		damage += (scalingBonusStrength() * 0.3) + ((player.str + unarmedAttack()) * 1.5);
		if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) damage += (scalingBonusStrength() * 0.3) + ((player.str + unarmedAttack()) * 1.5);
		if (player.hasPerk(PerkLib.WhirlwindFeral)) damage += (scalingBonusStrength() * 0.15) + ((player.str + unarmedAttack()) * 0.75);
		if (damage < 15) damage = 15;
		//weapon bonus
		if (player.weaponAttack < 101) damage *= (1 + (player.weaponAttack * 0.02));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 201) damage *= (2 + ((player.weaponAttack - 100) * 0.015));
		else damage *= (3.5 + ((player.weaponAttack - 200) * 0.01));
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
			if (player.mouseScore() >= 12 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
			else damage *= 2;
		}
		//other bonuses
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
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
			damage *= 1.75;
		}
		//add bonus for using aoe special
		var bonusmultiplier:Number = 5;
		if (player.hasPerk(PerkLib.WhirlwindFeral)) bonusmultiplier += 1;
		if (player.hasPerk(PerkLib.JobWarlord)) bonusmultiplier += 1;
		if (player.hasPerk(PerkLib.Tornado)) bonusmultiplier += 1;
		if (player.hasPerk(PerkLib.CycloneStage4)) bonusmultiplier += 0.5;
		if (player.hasPerk(PerkLib.CycloneStage5)) bonusmultiplier += 1.5;
		damage *= bonusmultiplier;
		//final touches
		damage = Math.round(damage);
		damage *= (monster.damagePercent() / 100);
		outputText("Your claws hits few of " + monster.a + monster.short + ", dealing ");
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) damage = doFireDamage(damage, true, true);
		else if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			damage = doDamage(damage, true, true);
			damage = doFireDamage(Math.round(damage*0.1), true, true);
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
			damage = Math.round(damage * 1.1);
		}
		else damage = doDamage(damage, true, true);
		outputText(" damage! ");
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
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
			var hairDamage:int = 1 + rand(2);
			if(player.hairLength >= 12) hairDamage += 1 + rand(2);
			if(player.hairLength >= 24) hairDamage += 1 + rand(2);
			if(player.hairLength >= 36) hairDamage += 1;
			while(hairDamage > 0) {
				hairDamage--;
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
		if(!combatIsOver()) enemyAI();
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
		enemyAI();
	}

	public function tailSlapAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(80, USEFATG_PHYSICAL);
		else fatigue(40, USEFATG_PHYSICAL);
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
			if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) damage += player.str;
			damage = calcInfernoMod(damage);
			if (monster.plural == true) damage *= 5;
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
			if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
			if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
			if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			damage *= monster.damagePercent() / 100;
			if (damage < 5) damage = 5;
			damage = Math.round(damage);
			outputText("  Your tail slams against " + monster.a + monster.short + ", dealing ");
			damage = doFireDamage(damage, true, true);
			outputText(" damage! ");
			if (player.hasPerk(PerkLib.PhantomStrike)) {
				damage = doDamage(damage);
				outputText("  Phantom strike dealing additional ");
				damage = doFireDamage(damage, true, true);
				outputText(" damage! ");
				damage *= 2;
			}
			monster.createStatusEffect(StatusEffects.BurnDoT,10,0.02,0,0);
			checkAchievementDamage(damage);
		}
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}

	public function tailSmackAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		fatigue(40, USEFATG_PHYSICAL);
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
			if (!monster.hasPerk(PerkLib.Resolute)) {
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
		fatigue(30, USEFATG_PHYSICAL);
		if (player.hasPerk(PerkLib.ScyllaInkGlands)) {
			player.createStatusEffect(StatusEffects.CooldownInkSpray,4,0,0,0);
		}
		else player.createStatusEffect(StatusEffects.CooldownInkSpray,8,0,0,0);
		outputText("You ");
		if (player.gender == 1) outputText("lift your cock ");
		if ((player.gender == 2 || player.gender == 3) && player.isScylla()) outputText("lift a few tentacle ");
		outputText("spraying your foe face in ink.  It start trashing its arm about attempting to remove the ink.\n");
		outputText(" <b>" + monster.capitalA + monster.short + " is blinded!</b>");
		monster.createStatusEffect(StatusEffects.InkBlind, 2, 0, 0, 0);
		monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		if (monster.lustVuln > 0) {
			var lustDmg:Number = 2 + player.teaseLevel + rand(5);
			monster.teased(lustDmg);
		}
		outputText("\n\n");
		statScreenRefresh();
		if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
		else enemyAI();
	}
	
	public function milkBlast():void {
		clearOutput();
		if (player.hasPerk(PerkLib.LactaBovinaOvariesFinalForm)) player.createStatusEffect(StatusEffects.CooldownMilkBlast, 4, 0, 0, 0);
		else player.createStatusEffect(StatusEffects.CooldownMilkBlast, 0, 0, 0, 0);
		outputText("You grab both of your udder smirking as you point them toward your somewhat confused target. You moan a pleasured Mooooooo as you open the dam splashing " + monster.a + monster.short + " with a twin jet of milk so powerful it is blown away hitting the nearest obstacle. ");
		var damage:Number = 0;
		damage += player.lactationQ();
		damage *= (player.lust100 * 0.01);
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		if (player.hasPerk(PerkLib.LactaBovinaOvariesFinalForm)) player.lust -= 200;
		else player.lust -= 100;
		if (monster.lustVuln > 0) {
			outputText(" ");
			var MilkLustDmg:Number = 0;
			MilkLustDmg += combat.scalingBonusLibido() * 0.2;
			monster.teased(MilkLustDmg);
		}
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		enemyAI();
	}
	
	public function cumCannon():void {
		clearOutput();
		if (player.hasPerk(PerkLib.MinotaurTesticlesFinalForm)) player.createStatusEffect(StatusEffects.CooldownCumCannon, 4, 0, 0, 0);
		else player.createStatusEffect(StatusEffects.CooldownCumCannon, 0, 0, 0, 0);
		outputText("You begin to masturbate fiercely, your [balls] expending with stacked semen as you ready to blow. Your cock shoot a massive jet of cum, projecting " + monster.a + monster.short + " away and knocking it prone. ");
		var damage:Number = 0;
		damage += player.cumQ();
		damage *= (player.lust100 * 0.01);
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		if (player.hasPerk(PerkLib.MinotaurTesticlesFinalForm)) player.lust -= 200;
		else player.lust -= 100;
		if (monster.lustVuln > 0) {
			outputText(" ");
			var CumLustDmg:Number = 0;
			CumLustDmg += combat.scalingBonusLibido() * 0.2;
			monster.teased(CumLustDmg);
		}
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		awardAchievement("Cum Cannon", kACHIEVEMENTS.COMBAT_CUM_CANNON);
		enemyAI();
	}

	public function takeFlight():void {
		clearOutput();
		outputText("You open you wing taking flight.\n\n");
		player.createStatusEffect(StatusEffects.Flying, 7, 0, 0, 0);
		if (!player.hasPerk(PerkLib.Resolute)) {
			player.createStatusEffect(StatusEffects.FlyingNoStun, 0, 0, 0, 0);
			player.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
		}
		monster.createStatusEffect(StatusEffects.MonsterAttacksDisabled, 0, 0, 0, 0);
		enemyAI();
	}

	public function takeFlightGoglinMech():void {
		clearOutput();
		outputText("You open you wing taking flight.\n\n");
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
		outputText("You take a low stance and begin to charge at " + monster.a + monster.short + ". Letting your momentum take over, you crash into your opponent and tackle them to the ground, dealing massive damage as they're crushed underneath your weight. ");
		if (silly()) {
			outputText("As you collide with " + monster.a + monster.short + ", everything goes grey, and " + monster.a + monster.short + " looks directly at the camera. <i>“Yep, that is me. The one being crushed underneath a fatty. Now you might be wondering how this all happened, ");
			outputText("and honestly, I am too. Here I am doing my job, and out of nowhere I'm attacked by a pig. Next thing I know, I'm about to be crushed under a mountain of fat. Now there's probably some joke you can make right now, the only thing coming to my mind is Space Jam.”</i>");
			outputText(" Everything returns to normal, and " + monster.a + monster.short + " gets comically crushed in slow motion under a mountain of fat, with the camera taking extra care to zoom in on " + monster.a + monster.short + "'s face.");
		}
		var slamDmg:Number = player.thickness;
		if (player.hasPerk(PerkLib.PigBoarFat)) slamDmg += player.thickness;
		slamDmg += scalingBonusToughness();
		if (player.hasPerk(PerkLib.PigBoarFatFinalForm)) slamDmg *= 2;
		slamDmg = Math.round(slamDmg);
		slamDmg = doDamage(slamDmg);
		outputText("<b>(<font color=\"#800000\">" + slamDmg + "</font>)</b>");
		if (!monster.hasPerk(PerkLib.Resolute) && rand(10) == 0) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		if (flags[kFLAGS.HUNGER_ENABLED] >= 1) {
			outputText(" The landing from your impressive charge and tackle deals some recoil damage, leaving you a bit winded. ");
			player.takePhysDamage(Math.round(slamDmg * 0.1), true);
			if (player.HP <= player.minHP()) doNext(endHpLoss);
			return;
		}
		if (silly()) outputText(" The force causes you to literally bounce off of " + monster.a + monster.short + ", allowing the camera to get a nice shot of " + monster.a + monster.short + " twitching in an indent in their general shape.");
		outputText("\n\n");
		combat.heroBaneProc(slamDmg);
		combat.EruptingRiposte();
		enemyAI();
	}
	public function minThicknessReq():Number {
		var miniThicknessvalue:Number = 95;
		if (player.hasPerk(PerkLib.PigBoarFatEvolved)) miniThicknessvalue -= 10;
		if (player.hasPerk(PerkLib.PigBoarFatFinalForm)) miniThicknessvalue -= 35;
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
		if (player.findPerk(PerkLib.SensualLover) >= 0) lustDmgF += 2;
		if (player.findPerk(PerkLib.Seduction) >= 0) lustDmgF += 5;
		if (player.findPerk(PerkLib.SluttySeduction) >= 0) lustDmgF += player.perkv1(PerkLib.SluttySeduction);
		if (player.findPerk(PerkLib.WizardsEnduranceAndSluttySeduction) >= 0) lustDmgF += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
		if (bimbo || bro || futa) lustDmgF += 5;
		if (player.findPerk(PerkLib.FlawlessBody) >= 0) lustDmgF += 10;
		lustDmgF += scalingBonusLibido() * 0.1;
		if (player.hasPerk(PerkLib.EromancyExpert)) lustDmgF *= 1.5;
		if (player.findPerk(PerkLib.JobSeducer) >= 0) lustDmgF += player.teaseLevel * 3;
		else lustDmgF += player.teaseLevel * 2;
		if (player.findPerk(PerkLib.JobCourtesan) >= 0 && monster.findPerk(PerkLib.EnemyBossType) >= 0) lustDmgF *= 1.2;
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
		if (player.findPerk(PerkLib.SluttySimplicity) >= 0 && player.armorName == "nothing") lustDmgF *= (1 + ((10 + rand(11)) / 100));
		if (player.findPerk(PerkLib.ElectrifiedDesire) >= 0) lustDmgF *= (1 + (player.lust100 * 0.01));
		if (player.findPerk(PerkLib.HistoryWhore) >= 0 || player.findPerk(PerkLib.PastLifeWhore) >= 0) lustDmgF *= (1 + combat.historyWhoreBonus());
		lustBoostToLustDmg += lustDmgF * 0.01;
		lustDmgF *= 0.2;
		if (player.lust100 * 0.01 >= 0.9) lustDmgF += (lustBoostToLustDmg * 140);
		else if (player.lust100 * 0.01 < 0.2) lustDmgF += (lustBoostToLustDmg * 140);
		else lustDmgF += (lustBoostToLustDmg * 2 * (20 - (player.lust100 * 0.01)));
		//Determine if critical tease!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.findPerk(PerkLib.CriticalPerformance) >= 0) {
			if (player.lib <= 100) critChance += player.lib / 5;
			if (player.lib > 100) critChance += 20;
		}
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			lustDmgF *= 1.75;
		}
		if (player.findPerk(PerkLib.ChiReflowLust) >= 0) lustDmgF *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
		if (player.findPerk(PerkLib.ArouseTheAudience) >= 0 && player.findPerk(PerkLib.EnemyGroupType) >= 0) lustDmgF *= 1.5;
		lustDmgF = lustDmgF * monster.lustVuln;
		lustDmgF = Math.round(lustDmgF);
		monster.teased(lustDmgF);
		if (crit == true) outputText(" <b>Critical!</b>");
		outputText("\n\n");
		monster.spe -= 15;
		if (monster.spe < 1) monster.spe = 1;
		combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		enemyAI();
	}
	
	public function wingSlapAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(80, USEFATG_PHYSICAL);
		else fatigue(40, USEFATG_PHYSICAL);
		//miss
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("Twirling like a top, you swing your wings, but connect with only empty air.");
		}
		else {
			if(!monster.plural) outputText("Twirling like a top, you slap your opponent with your wings.");
			else outputText("Twirling like a top, you slap your opponents with your wings.");
			var damage:Number = unarmedAttack();
			if (player.thirdtierWingsForWingSlap()) damage += unarmedAttack();
			//if (tu jak byłyby 4th tier wings dodane) damage += unarmedAttack();
			damage += player.str;
			if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) damage += player.str;
			if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
			if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
				if (player.mouseScore() >= 12 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
				else damage *= 2;
			}
			damage *= monster.damagePercent() / 100;
			if (damage < 5) damage = 5;
			damage = Math.round(damage);
			outputText("  Your wings slams against " + monster.a + monster.short + ", dealing ");
			if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) damage = doFireDamage(damage, true, true);
			else if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
				damage = doDamage(damage, true, true);
				damage = doFireDamage(Math.round(damage*0.1), true, true);
				if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
				damage = Math.round(damage * 1.1);
			}
			else damage = doDamage(damage, true, true);
			if (player.hasPerk(PerkLib.PhantomStrike)) {
				if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) damage = doFireDamage(damage, true, true);
				else if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
					damage = doDamage(damage, true, true);
					damage = doFireDamage(Math.round(damage*0.1), true, true);
					if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
					damage = Math.round(damage * 1.1);
				}
				else damage = doDamage(damage, true, true);
			}
			outputText(" damage! ");
			checkAchievementDamage(damage);
		}
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		enemyAI();
	}

	public function sendTemporalGolem1():void {
		clearOutput();
		flags[kFLAGS.TEMPORAL_GOLEMS_BAG]--;
		//Determine if golem core is shattered or not picked due too overloaded bag for them!
		var shatter:Boolean = false;
		var shatterChance:int = 20;
		if (player.hasPerk(PerkLib.BeginnerGolemMaker)) shatterChance -= 5;
		if (player.hasPerk(PerkLib.ApprenticeGolemMaker)) shatterChance -= 5;
		if (player.hasPerk(PerkLib.ExpertGolemMaker)) shatterChance -= 5;
		if (player.hasPerk(PerkLib.MasterGolemMaker)) shatterChance -= 4;
		if (rand(100) < shatterChance) {
			shatter = true;
		}
		var overloadedGolemCoresBag:Boolean = false;
		if (shatter == false) {
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] < winionsMaker.maxReusableGolemCoresBagSize()) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]++;
			else overloadedGolemCoresBag = true;
		}
		var damage:Number = 0;
		var dmgamp:Number = 1;
		damage += 300 + rand(121);
		if (player.hasPerk(PerkLib.ChargedCore)) {
			if (player.hasPerk(PerkLib.SuperChargedCore)) {
				damage += 200 + rand(81);
				damage *= 1.4;
			}
			else {
				damage += 100 + rand(41);
				damage *= 1.2;
			}
		}
		if (player.hasPerk(PerkLib.GolemArmyLieutenant)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyCaptain)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyMajor)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyColonel)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyGeneral)) dmgamp += 0.1;
		if (player.weapon == weapons.SCECOMM) dmgamp += 0.5;
		if (flags[kFLAGS.WILL_O_THE_WISP] == 1) {
			dmgamp += 0.1;
			if (player.hasPerk(PerkLib.WispLieutenant)) dmgamp += 0.2;
			if (player.hasPerk(PerkLib.WispCaptain)) dmgamp += 0.3;
			if (player.hasPerk(PerkLib.WispMajor)) dmgamp += 0.4;
			if (player.hasPerk(PerkLib.WispColonel)) dmgamp += 0.5;
		}
		damage *= dmgamp;
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("Your stone golem slam into " + monster.a + monster.short + " dealing <b>(<font color=\"#800000\">" + damage + "</font>)</b> damage.");
		if (shatter == true) outputText(" <b>*Golem Core shattered!*</b>");
		if (overloadedGolemCoresBag == true) outputText(" <b>*Golem Core wasn't picked due to lack of space to store them!*</b>");
		outputText("\n\n");
		enemyAI();
	}
	public function sendTemporalGolem3():void {
		clearOutput();
		flags[kFLAGS.TEMPORAL_GOLEMS_BAG] -= 3;
		//Determine if golem core is shattered or not picked due too overloaded bag for them!
		var shatter:Boolean = false;
		var shatterChance:int = 20;
		if (player.hasPerk(PerkLib.BeginnerGolemMaker)) shatterChance -= 5;
		if (player.hasPerk(PerkLib.ApprenticeGolemMaker)) shatterChance -= 5;
		if (player.hasPerk(PerkLib.ExpertGolemMaker)) shatterChance -= 5;
		if (player.hasPerk(PerkLib.MasterGolemMaker)) shatterChance -= 4;
		if (rand(100) < shatterChance) {
			shatter = true;
		}
		var overloadedGolemCoresBag:Boolean = false;
		if (shatter == false) {
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] + 3 < winionsMaker.maxReusableGolemCoresBagSize()) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] += 3;
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
		var dmgamp:Number = 1;
		damage += 300 + rand(121);
		if (!player.hasPerk(PerkLib.ChargedCore)) damage *= 3;
		if (player.hasPerk(PerkLib.ChargedCore)) {
			if (player.hasPerk(PerkLib.SuperChargedCore)) {
				damage += 200 + rand(81);
				damage *= 5;
			}
			else {
				damage += 100 + rand(41);
				damage *= 4;
			}
		}
		if (player.hasPerk(PerkLib.GolemArmyLieutenant)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyCaptain)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyMajor)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyColonel)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyGeneral)) dmgamp += 0.1;
		if (player.weapon == weapons.SCECOMM) dmgamp += 0.5;
		if (flags[kFLAGS.WILL_O_THE_WISP] == 1) {
			dmgamp += 0.1;
			if (player.hasPerk(PerkLib.WispLieutenant)) dmgamp += 0.2;
			if (player.hasPerk(PerkLib.WispCaptain)) dmgamp += 0.3;
			if (player.hasPerk(PerkLib.WispMajor)) dmgamp += 0.4;
			if (player.hasPerk(PerkLib.WispColonel)) dmgamp += 0.5;
		}
		damage *= dmgamp;
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("Your stone golems slams into " + monster.a + monster.short + " dealing <b>(<font color=\"#800000\">" + damage + "</font>)</b> damage.");
		if (shatter == true) outputText(" <b>*Golem Cores shattered!*</b>");
		if (overloadedGolemCoresBag == true) outputText(" <b>*None of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		if (partialyoverloadedGolemCoresBag == true) outputText(" <b>*Some of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		outputText("\n\n");
		enemyAI();
	}
	public function sendTemporalGolem5():void {
		clearOutput();
		flags[kFLAGS.TEMPORAL_GOLEMS_BAG] -= 5;
		//Determine if golem core is shattered or not picked due too overloaded bag for them!
		var shatter:Boolean = false;
		var shatterChance:int = 20;
		if (player.hasPerk(PerkLib.BeginnerGolemMaker)) shatterChance -= 5;
		if (player.hasPerk(PerkLib.ApprenticeGolemMaker)) shatterChance -= 5;
		if (player.hasPerk(PerkLib.ExpertGolemMaker)) shatterChance -= 5;
		if (player.hasPerk(PerkLib.MasterGolemMaker)) shatterChance -= 4;
		if (rand(100) < shatterChance) {
			shatter = true;
		}
		var overloadedGolemCoresBag:Boolean = false;
		if (shatter == false) {
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] + 5 < winionsMaker.maxReusableGolemCoresBagSize()) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] += 5;
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
		var dmgamp:Number = 1;
		damage += 300 + rand(121);
		if (!player.hasPerk(PerkLib.ChargedCore)) damage *= 5;
		if (player.hasPerk(PerkLib.ChargedCore)) {
			if (player.hasPerk(PerkLib.SuperChargedCore)) {
				damage += 200 + rand(81);
				damage *= 10;
			}
			else {
				damage += 100 + rand(41);
				damage *= 7.5;
			}
		}
		if (player.hasPerk(PerkLib.GolemArmyLieutenant)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyCaptain)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyMajor)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyColonel)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyGeneral)) dmgamp += 0.1;
		if (player.weapon == weapons.SCECOMM) dmgamp += 0.5;
		if (flags[kFLAGS.WILL_O_THE_WISP] == 1) {
			dmgamp += 0.1;
			if (player.hasPerk(PerkLib.WispLieutenant)) dmgamp += 0.2;
			if (player.hasPerk(PerkLib.WispCaptain)) dmgamp += 0.3;
			if (player.hasPerk(PerkLib.WispMajor)) dmgamp += 0.4;
			if (player.hasPerk(PerkLib.WispColonel)) dmgamp += 0.5;
		}
		damage *= dmgamp;
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("Your stone golems slams into " + monster.a + monster.short + " dealing <b>(<font color=\"#800000\">" + damage + "</font>)</b> damage.");
		if (shatter == true) outputText(" <b>*Golem Cores shattered!*</b>");
		if (overloadedGolemCoresBag == true) outputText(" <b>*None of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		if (partialyoverloadedGolemCoresBag == true) outputText(" <b>*Some of used Golem Cores wasn't picked due to lack of space to store them!*</b>");
		outputText("\n\n");
		enemyAI();
	}
	
	public function pernamentgolemsendcost():Number {
		var pernamentgolemsendcost:Number = 10;
		if (player.findPerk(PerkLib.EpicGolemMaker) >= 0) pernamentgolemsendcost += 5;
		if (player.findPerk(PerkLib.LegendaryGolemMaker) >= 0) pernamentgolemsendcost += 15;
		if (player.findPerk(PerkLib.MythicalGolemMaker) >= 0) pernamentgolemsendcost += 40;
		return pernamentgolemsendcost;
	}
	public function sendPernamentGolem1():void {
		clearOutput();
		if (player.hasPerk(PerkLib.GrandMasterGolemMaker)) {
			if (player.mana < pernamentgolemsendcost()) {
				outputText("Your mana is too low to make your golem attack.");
				menu();
				addButton(0, "Next", combatMenu, false);
				return;
			}
			else useMana(pernamentgolemsendcost());
		}
		var damage:Number = 0;
		var dmgamp:Number = 1;
		damage += 500 + rand(201);
		if (player.hasPerk(PerkLib.MythicalGolemMaker)) damage += combat.intwisscaling() * 0.1;
		if (player.hasPerk(PerkLib.GolemArmyLieutenant)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyCaptain)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyMajor)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyColonel)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyGeneral)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GrandMasterGolemMaker)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.EpicGolemMaker)) dmgamp += 0.25;
		if (player.hasPerk(PerkLib.LegendaryGolemMaker)) dmgamp += 0.65;
		if (player.weapon == weapons.SCECOMM) dmgamp += 0.5;
		if (flags[kFLAGS.WILL_O_THE_WISP] == 1) {
			dmgamp += 0.1;
			if (player.hasPerk(PerkLib.WispLieutenant)) dmgamp += 0.2;
			if (player.hasPerk(PerkLib.WispCaptain)) dmgamp += 0.3;
			if (player.hasPerk(PerkLib.WispMajor)) dmgamp += 0.4;
			if (player.hasPerk(PerkLib.WispColonel)) dmgamp += 0.5;
		}
		damage *= dmgamp;
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("Your stone golem slam into " + monster.a + monster.short + " dealing <b>(<font color=\"#800000\">" + damage + "</font>)</b> damage.\n\n");
		if (flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] != 1 && flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] == 1) {
			flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
		}
		else enemyAI();
	}
	public function sendPernamentGolem3():void {
		clearOutput();
		if (player.hasPerk(PerkLib.GrandMasterGolemMaker)) {
			if (player.mana < pernamentgolemsendcost() * 3) {
				outputText("Your mana is too low to make your golems attack.");
				menu();
				addButton(0, "Next", combatMenu, false);
				return;
			}
			else useMana(pernamentgolemsendcost() * 3);
		}
		var damage:Number = 0;
		var dmgamp:Number = 1;
		damage += 500 + rand(201);
		if (player.hasPerk(PerkLib.MythicalGolemMaker)) damage += player.inte + player.wis;
		damage *= 5;
		if (player.hasPerk(PerkLib.GolemArmyLieutenant)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyCaptain)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyMajor)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyColonel)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyGeneral)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GrandMasterGolemMaker)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.EpicGolemMaker)) dmgamp += 0.25;
		if (player.hasPerk(PerkLib.LegendaryGolemMaker)) dmgamp += 0.65;
		if (player.weapon == weapons.SCECOMM) dmgamp += 0.5;
		if (flags[kFLAGS.WILL_O_THE_WISP] == 1) {
			dmgamp += 0.1;
			if (player.hasPerk(PerkLib.WispLieutenant)) dmgamp += 0.2;
			if (player.hasPerk(PerkLib.WispCaptain)) dmgamp += 0.3;
			if (player.hasPerk(PerkLib.WispMajor)) dmgamp += 0.4;
			if (player.hasPerk(PerkLib.WispColonel)) dmgamp += 0.5;
		}
		damage *= dmgamp;
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("Your stone golems slams into " + monster.a + monster.short + " dealing <b>(<font color=\"#800000\">" + damage + "</font>)</b> damage.\n\n");
		if (flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] != 1 && flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] == 1) {
			flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
		}
		else enemyAI();
	}
	public function sendPernamentGolem5():void {
		clearOutput();
		if (player.hasPerk(PerkLib.GrandMasterGolemMaker)) {
			if (player.mana < pernamentgolemsendcost() * 5) {
				outputText("Your mana is too low to make your golems attack.");
				menu();
				addButton(0, "Next", combatMenu, false);
				return;
			}
			else useMana(pernamentgolemsendcost() * 5);
		}
		var damage:Number = 0;
		var dmgamp:Number = 1;
		damage += 500 + rand(201);
		if (player.hasPerk(PerkLib.MythicalGolemMaker)) damage += player.inte + player.wis;
		damage *= 10;
		if (player.hasPerk(PerkLib.GolemArmyLieutenant)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyCaptain)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyMajor)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyColonel)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GolemArmyGeneral)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.GrandMasterGolemMaker)) dmgamp += 0.1;
		if (player.hasPerk(PerkLib.EpicGolemMaker)) dmgamp += 0.25;
		if (player.hasPerk(PerkLib.LegendaryGolemMaker)) dmgamp += 0.65;
		if (player.weapon == weapons.SCECOMM) dmgamp += 0.5;
		if (flags[kFLAGS.WILL_O_THE_WISP] == 1) {
			dmgamp += 0.1;
			if (player.hasPerk(PerkLib.WispLieutenant)) dmgamp += 0.2;
			if (player.hasPerk(PerkLib.WispCaptain)) dmgamp += 0.3;
			if (player.hasPerk(PerkLib.WispMajor)) dmgamp += 0.4;
			if (player.hasPerk(PerkLib.WispColonel)) dmgamp += 0.5;
		}
		damage *= dmgamp;
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("Your stone golems slams into " + monster.a + monster.short + " dealing <b>(<font color=\"#800000\">" + damage + "</font>)</b> damage.\n\n");
		if (flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] != 1 && flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] == 1) {
			flags[kFLAGS.IN_COMBAT_PLAYER_GOLEM_ATTACKED] = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
		}
		else enemyAI();
	}

	public function AlraunePollen():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var pollen:Number = monster.lustVuln * (2 + rand(4));
		if (player.headjewelryName == "pair of Golden Naga Hairpins") pollen *= 1.1;
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
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(60, USEFATG_PHYSICAL);
		var damage:Number = 0;
		damage += player.tou;
		damage += scalingBonusToughness() * 0.5;
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("You tighten your vines around your opponent's neck to strangle it. " + monster.capitalA + monster.short + " struggles against your natural noose, getting obvious marks on its neck and " + damage + " damage for their trouble.\n\n");
		enemyAI();
	}

	public function blazingRocketKick():void {
		clearOutput();
		outputText("You propel yourself up and kick " + monster.a + monster.short + " in the face leaving burns in the process. ");
		var damage:Number = player.str;
		if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) damage += player.str;
		if (damage < 10) damage = 10;
		damage += (unarmedAttack() * 2);
		damage *= (spellMod() * 2);
		damage = Math.round(damage);
		outputText(" ");
		damage = doDamage(damage, true, true);
		damage = doFireDamage(damage, true, true);
		damage *= 2;
		if (player.hasKeyItem("Nitro Boots") >= 0) {
			outputText(" Your foe catches on fire.");
			monster.createStatusEffect(StatusEffects.BurnDoT, 5, 0.05, 0, 0);
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		doNext(playerMenu);
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

	public function StoneClawAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(120, USEFATG_PHYSICAL);
		else fatigue(60, USEFATG_PHYSICAL);
		player.createStatusEffect(StatusEffects.CooldownStoneClaw,3,0,0,0);
		var damage:Number = 0;
		//str bonuses
		damage += player.str;
		damage += scalingBonusStrength();
		//tou bonuses
		damage += player.tou;
		damage += scalingBonusToughness();
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
		if (player.hasPerk(PerkLib.HoldWithBothHands)) damage *= 1.2;
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
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
			damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("You slash your adversary with your sharp stone claws, dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			damage = doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
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
		player.createStatusEffect(StatusEffects.CooldownStoneFist,3,0,0,0);
		var damage:Number = 0;
		//str bonuses
		damage += player.str;
		damage += scalingBonusStrength();
		//tou bonuses
		damage += player.tou;
		damage += scalingBonusToughness();
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
		if (player.hasPerk(PerkLib.HoldWithBothHands)) damage *= 1.2;
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
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
			damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("You punch your adversary with your stone fist, dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (!monster.hasPerk(PerkLib.Resolute)) {
			outputText(" " + monster.capitalA + monster.short + " recoil under the blow!");
			monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		}
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			damage = doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
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
		player.createStatusEffect(StatusEffects.CooldownTailSlam,5,0,0,0);
		var damage:Number = 0;
		//str bonuses
		damage += player.str;
		damage += scalingBonusStrength();
		//tou bonuses
		damage += player.tou;
		damage += scalingBonusToughness();
		//addictive bonuses
		if (player.hasPerk(PerkLib.JobBrawler)) damage += (5 * (1 + player.newGamePlusMod()));
		if (player.hasPerk(PerkLib.JobMonk)) damage += (10 * (1 + player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Berzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Lustzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		//multiplicative bonuses
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
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
			damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		if (!monster.hasStatusEffect(StatusEffects.TailSlamWhip)) monster.createStatusEffect(StatusEffects.TailSlamWhip,monster.armorDef,5,0,0);
		//monster.armorDef == 0;
		outputText("You slam your mace-like tail on your foe, dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (!monster.hasPerk(PerkLib.Resolute)) {
			outputText(" The attack is so devastating your target is stunned by the crushing blow!");
			monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			damage = doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
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
		player.createStatusEffect(StatusEffects.CooldownTailCleave,5,0,0,0);
		var damage:Number = 0;
		//str bonuses
		damage += player.str;
		damage += scalingBonusStrength();
		//tou bonuses
		damage += player.tou;
		damage += scalingBonusToughness();
		//addictive bonuses
		if (player.hasPerk(PerkLib.JobBrawler)) damage += (5 * (1 + player.newGamePlusMod()));
		if (player.hasPerk(PerkLib.JobMonk)) damage += (10 * (1 + player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Berzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		if (player.hasStatusEffect(StatusEffects.Lustzerking)) damage += (30 + (15 * player.newGamePlusMod()));
		//multiplicative bonuses
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
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
			damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		var multikulti:String = monster.hasPerk(PerkLib.EnemyGroupType) ? "s" : "";
		outputText("You swipe the field with your axe-bladed tail, slicing your foe" + multikulti + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (!monster.hasPerk(PerkLib.EnemyConstructType)) {
			outputText(" The attack leaves your target" + multikulti + " bleeding from deep wounds!");
			if (monster.hasPerk(PerkLib.EnemyGroupType)) monster.createStatusEffect(StatusEffects.SharkBiteBleed, 2, 5, 0, 0);
			monster.createStatusEffect(StatusEffects.SharkBiteBleed, 2, 0, 0, 0);
		}
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			damage = doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
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
		player.createStatusEffect(StatusEffects.CooldownWingBuffet,6,0,0,0);
		var damage:Number = 0;
		damage += player.str;
		damage += player.tou;
		//multiplicative bonuses
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
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
			damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("You buffet your foe with your massive wings, dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			damage = doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		checkAchievementDamage(damage);
		outputText("\n\n");
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
		player.createStatusEffect(StatusEffects.CooldownTornadoStrike,8,0,0,0);
		var damage:Number = 0;
		//spe bonuses
		damage += player.spe;
		damage += scalingBonusSpeed();
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
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
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("You start to channel power into your body unleashing it it into the form of a mighty swirling tornado. " + monster.capitalA + monster.short + " is caught in it and carried into the windstorm taking hit from various other flying objects. <b><font color=\"#800000\">" + damage + "</font></b> damage.");
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			damage = doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		enemyAI();
	}

	public function PCWebAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		//Keep logic sane if this attack brings victory
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
		if(monster.short == "pod") {
			clearOutput();
			outputText("You can't constrict something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10, USEFATG_PHYSICAL);
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
			player.takePhysDamage(5, true);
			if(player.HP <= player.minHP()) {
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
		fatigue(10, USEFATG_PHYSICAL);
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
		if(monster.short == "pod") {
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
			outputText("You dive down at your target, wrapping your wings around " + monster.a + monster.short + " embracing " + monster.pronoun1 + " as you prepare to feast.");
			player.removeStatusEffect(StatusEffects.Flying);
			if (player.hasStatusEffect(StatusEffects.FlyingNoStun)) {
				player.removeStatusEffect(StatusEffects.FlyingNoStun);
				player.removePerk(PerkLib.Resolute);
			}
		}
		else outputText("You leap and box in " + monster.a + monster.short + " with your wings, embracing " + monster.pronoun1 + " as you prepare to feast.");
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
		if (monster.short == "pod") {
			clearOutput();
			outputText("You can't pounce something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10, USEFATG_PHYSICAL);
		//Amily!
		if (monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		//WRAP IT UPPP
		if (40 + rand(player.spe) > monster.spe) {
			outputText("You growl menacingly, dropping on all four" + (player.tail.type != Tail.NONE ? " and flicking your tail" : "") + ", as you pounce on " + monster.a + monster.short + " clawing at " + monster.pronoun1 + " body and leaving deep bleeding wounds.");
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
		if (monster.short == "pod") {
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
			return;
		}
		fatigue(10, USEFATG_PHYSICAL);
		//Amily!
		if (monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		outputText("You attempt to slam both of your powerful forepaws on " + monster.a + monster.short + ". ");
		//WRAP IT UPPP
		if (40 + rand(player.spe) > monster.spe) {
			outputText("You land both paws on " + monster.a + monster.short + " with brutal power using your claws to grab " + monster.pronoun2 + ".");
			monster.createStatusEffect(StatusEffects.GrabBear, 4 + rand(2),0,0,0);
		}
		//Failure
		else outputText("Your opponent seeing it coming dodge to the side as you smash the ground where " + monster.pronoun1 + " used to stand.");
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
		if (monster.short == "pod") {
			clearOutput();
			outputText("You can't slap something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(60, USEFATG_PHYSICAL);
		else fatigue(30, USEFATG_PHYSICAL);
		player.createStatusEffect(StatusEffects.CooldownSlamBear,8,0,0,0);
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		var damage:Number = 0;
		//str bonuses
		damage += player.str;
		damage += scalingBonusStrength();
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
		if (player.hasPerk(PerkLib.HoldWithBothHands)) damage *= 1.2;
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
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
			damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("You slam " + monster.a + monster.short + " with your full strength, crushing it under your weight. " + monster.capitalA + monster.short + " tries to recover but is stunned and grievously wounded by your assault. (<b><font color=\"#800000\">" + damage + "</font></b>)");
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			damage = doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		if (crit == true) {
		outputText(" <b>*Critical Hit!*</b>");
		if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
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
		if (monster.short == "pod") {
			clearOutput();
			outputText("You can't land into something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(20, USEFATG_PHYSICAL);
		else fatigue(10, USEFATG_PHYSICAL);
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
			enemyAI();
			return;
		}
		//WRAP IT UPPP
		if (40 + rand(player.spe) > monster.spe) {
			var damage:Number = 0;
			//str bonuses
			damage += player.str;
			damage += scalingBonusStrength() * 0.5;
			//tou bonuses
			damage += player.spe;
			damage += scalingBonusSpeed() * 0.5;
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
			if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
			if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
			if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
			if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
			if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
			if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
			if (player.armor == armors.SPKIMO) damage *= 1.2;
			if (player.necklace == necklaces.OBNECK) damage *= 1.2;
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
				damage *= 1.75;
			}
			damage = Math.round(damage);
			damage = doDamage(damage);
			if (player.hasPerk(PerkLib.PhantomStrike)) {
				damage = doDamage(damage);
				damage *= 2;
			}
			outputText("You growl menacingly, and fold your wings, as you dive into " + monster.a + monster.short + " clawing at " + monster.pronoun2 + " body and leaving deep bleeding wounds dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!. You’re now grappling with your target ready to tear it to shreds.");
			if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
			}
			if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
				if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
				else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
			}
			checkAchievementDamage(damage);
			outputText("\n\n");
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
		fatigue((10 * player.statusEffectv1(StatusEffects.HydraTailsPlayer)), USEFATG_PHYSICAL);
		//Works similar to bee stinger, must be regenerated over time. Shares the same poison-meter
		outputText("You stand up erect and pull back for a second only to dart out at with all your " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " heads at " + monster.a + monster.short + " rending flesh and delivering your deadly venom in the process. ");
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
		outputText("\n\n");
		player.tailVenom -= 25;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		if (!combatIsOver()) enemyAI();
	}
	public function hydraBiteAttackpoweeeeer():void {
		var HBD:Number = 0;
		HBD += player.str;
		HBD += scalingBonusStrength() * 0.25;
		if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) HBD *= 2;
		HBD += combat.unarmedAttack();
		if (HBD < 10) HBD = 10;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) HBD *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) HBD *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) HBD *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) HBD *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) HBD *= 2;
		if (player.armor == armors.SPKIMO) HBD *= 1.2;
		if (player.necklace == necklaces.OBNECK) HBD *= 1.2;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) HBD *= combat.oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) HBD *= 2;
		HBD = Math.round(HBD);
		HBD = doDamage(HBD, true, true);
	}
	public function nagaBiteAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
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
		if (!combatIsOver()) enemyAI();
	}
	public function spiderBiteAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
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
		if (!combatIsOver()) enemyAI();
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
		fatigue(10, USEFATG_PHYSICAL);
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
		if (!combatIsOver()) enemyAI();
	}
//Mantis Omni Slash (AoE attack)
	public function mantisMultiSlash():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			if (monster.plural) {
				if (player.hasPerk(PerkLib.MantislikeAgilityEvolved)) fatigue(100, USEFATG_PHYSICAL);
				else fatigue(120, USEFATG_PHYSICAL);
			}
			else {
				if (player.hasPerk(PerkLib.MantislikeAgilityEvolved)) fatigue(40, USEFATG_PHYSICAL);
				else fatigue(48, USEFATG_PHYSICAL);
			}
		}
		else {
			if (monster.plural) {
				if (player.hasPerk(PerkLib.MantislikeAgilityEvolved)) fatigue(50, USEFATG_PHYSICAL);
				else fatigue(60, USEFATG_PHYSICAL);
			}
			else {
				if (player.hasPerk(PerkLib.MantislikeAgilityEvolved)) fatigue(20, USEFATG_PHYSICAL);
				else fatigue(24, USEFATG_PHYSICAL);
			}
		}
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
			if (player.hasPerk(PerkLib.MantislikeAgility)) {
				if (player.hasPerk(PerkLib.MantislikeAgilityEvolved) && player.hasPerk(PerkLib.TrachealSystemEvolved)) flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 10;
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
		damage += scalingBonusSpeed() * 0.2;
		if (damage < 10) damage = 10;
		//adjusting to be used 60/100% of base speed while attacking depending on insect-related perks possesed
		if (!player.hasPerk(PerkLib.MantislikeAgility)) damage *= 0.6;
		//bonuses if fighting multiple enemies
		if (monster.plural) {
			if (!player.hasPerk(PerkLib.MantislikeAgility) && !player.hasPerk(PerkLib.TrachealSystemEvolved)) damage *= 1.1;
			if (player.hasPerk(PerkLib.MantislikeAgility) && player.hasPerk(PerkLib.TrachealSystemEvolved)) damage *= 1.5;
		}
		//other bonuses
		damage += player.weaponAttack;
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
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
		if (crit == false && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		if (player.hasPerk(PerkLib.PhantomStrike)) {
			damage = doDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
			damage *= 2;
		}
		outputText("\n");
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
		if (monster.short == "worms") {
			outputText("Taking advantage of your new natural ");
			if (player.horns.type == Horns.COW_MINOTAUR) outputText("weapons, ");
			else outputText("weapon, ");
			outputText("you quickly charge at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving your ");
			if (player.horns.type == Horns.COW_MINOTAUR) outputText("horns ");
			else outputText("horns, ");
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
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
			enemyAI();
			return;
		}
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
		if(monster.short == "Vala") {
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
			damage = int((unarmedAttack() + player.str + player.spe + horns) * 2 * (monster.damagePercent() / 100));
			if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) damage += (player.str * (monster.damagePercent() / 100));
			if (!monster.hasStatusEffect(StatusEffects.GoreBleed)) monster.createStatusEffect(StatusEffects.GoreBleed,16,0,0,0);
			else {
				monster.removeStatusEffect(StatusEffects.GoreBleed);
				monster.createStatusEffect(StatusEffects.GoreBleed,16,0,0,0);
			}
			//normal
			if (rand(4) > 0) {
				outputText("You lower your head and charge, skewering " + monster.a + monster.short + " on ");
				if (player.horns.type == Horns.COW_MINOTAUR) outputText("one of your bullhorns!  ");
				else outputText("your horns!  ");
			}
			//CRIT
			else {
				//doubles horns bonus damage
				damage *= 2;
				outputText("You lower your head and charge, slamming into " + monster.a + monster.short + " and burying ");
				if (player.horns.type == Horns.COW_MINOTAUR) outputText("both your horns ");
				else outputText("your horns ");
				outputText("into " + monster.pronoun2 + "! <b>Critical hit!</b>  ");
			}
			//Bonus damage for rut!
			if (player.inRut && monster.cockTotal() > 0) {
				outputText("The fury of your rut lent you strength, increasing the damage!  ");
				damage *= 1.1;
			}
			//Reduced by armor
			damage *= monster.damagePercent() / 100;
			if (damage < 0) damage = 5;
			//Deal damage and update based on perks
			if (damage > 0) {
				if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
				if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
				if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
				if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
				if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
				if (player.armor == armors.SPKIMO) damage *= 1.2;
				if (player.necklace == necklaces.OBNECK) damage *= 1.2;
				if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
				if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
				if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
				if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
				if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
					if (player.mouseScore() >= 12 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
					else damage *= 2;
				}
			}
			//Different horns damage messages
			if (damage < 25) outputText("You pull yourself free, dealing  damage.");
			if (damage >= 25 && damage < 100) {
				outputText("You struggle to pull your ");
				if (player.horns.type == Horns.COW_MINOTAUR) outputText("horns ");
				else outputText("horns ");
				outputText("free, dealing  damage.");
			}
			if (damage >= 100) {
				outputText("With great difficulty you rip your ");
				if (player.horns.type == Horns.COW_MINOTAUR) outputText("horns ");
				else outputText("horns ");
				outputText("free, dealing  damage.");
			}
			if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) damage = doFireDamage(damage, true, true);
			else if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
				damage = doDamage(damage, true, true);
				damage = doFireDamage(Math.round(damage*0.1), true, true);
				if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
				damage = Math.round(damage * 1.1);
			}
			else damage = doDamage(damage, true, true);
			if (player.hasPerk(PerkLib.PhantomStrike)) {
				if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) damage = doFireDamage(damage, true, true);
				else if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
					damage = doDamage(damage, true, true);
					damage = doFireDamage(Math.round(damage*0.1), true, true);
					if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
					damage = Math.round(damage * 1.1);
				}
				else damage = doDamage(damage, true, true);
				damage *= 2;
			}
			outputText(" damage.");
		}
		//Miss
		else {
			//Special vala changes
			if(monster.short == "Vala") {
				outputText("You lower your head and charge Vala, but she just flutters up higher, grabs hold of your ");
				if (player.horns.type == Horns.COW_MINOTAUR) outputText("horns ");
				else outputText("horns ");
				outputText("as you close the distance, and smears her juicy, fragrant cunt against your nose.  The sensual smell and her excited moans stun you for a second, allowing her to continue to use you as a masturbation aid, but she quickly tires of such foreplay and flutters back with a wink.\n\n");
				dynStats("lus", 5);
			}
			else outputText("You lower your head and charge " + monster.a + monster.short + ", only to be sidestepped at the last moment!");
		}
		//New line before monster attack
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		//Victory ORRRRR enemy turn.
		if(monster.HP > 0 && monster.lust < monster.maxLust()) enemyAI();
		else {
			if(monster.HP <= monster.minHP()) doNext(endHpVictory);
			if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
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
		if (player.hasPerk(PerkLib.PhantomStrike)) fatigue(30, USEFATG_PHYSICAL);
		else fatigue(15, USEFATG_PHYSICAL);
		var damage:Number = 0;
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
			enemyAI();
			return;
		}
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
		if(monster.short == "Vala") {
			chance = 20;
		}
		//Account for monster speed - up to -50%.
		chance -= monster.spe/2;
		//Account for player speed - up to +50%
		chance += player.spe/2;
		//Hit & calculation
		if(chance >= rand(100)) {
			var horns:Number = player.horns.count;
			if (player.horns.count > 40) player.horns.count = 40;
			damage = int(player.str + (player.tou / 2) + (player.spe / 2) + (player.level * 2) * 1.2 * (monster.damagePercent() / 100)); //As normal attack + horns length bonus
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
				if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
				if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
				if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
				if (player.armor == armors.SPKIMO) damage *= 1.2;
				if (player.necklace == necklaces.OBNECK) damage *= 1.2;
				if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
				if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
				if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
				if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
				if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
					if (player.mouseScore() >= 12 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
					else damage *= 2;
				}
				//Round it off
				damage = int(damage);
				if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) damage = doFireDamage(damage, true, true);
				else if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
					damage = doDamage(damage, true, true);
					damage = doFireDamage(Math.round(damage*0.1), true, true);
					if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
					damage = Math.round(damage * 1.1);
				}
				else damage = doDamage(damage, true, true);
				if (player.hasPerk(PerkLib.PhantomStrike)) {
					if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) damage = doFireDamage(damage, true, true);
					else if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
						damage = doDamage(damage, true, true);
						damage = doFireDamage(Math.round(damage*0.1), true, true);
						if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
						damage = Math.round(damage * 1.1);
					}
					else damage = doDamage(damage, true, true);
					damage *= 2;
				}
			}
			if (crit == true) outputText("<b>Critical hit! </b>");
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
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		//Victory ORRRRR enemy turn.
		if(monster.HP > 0 && monster.lust < monster.maxLust()) enemyAI();
		else {
			if(monster.HP <= monster.minHP()) doNext(endHpVictory);
			if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
		}
	}
//Player sting attack
	public function playerStinger():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		//Keep logic sane if this attack brings victory
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
		if(monster.HP > 0 && monster.lust < monster.maxLust()) enemyAI();
		else doNext(endLustVictory);
	}
//Player tail spike attack
	public function playerTailSpike():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		
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
		damage += scalingBonusSpeed() * 0.2;
		if (damage < 10) damage = 10;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText(" This deal " + damage + " damage as your victim grows increasingly flushed by your potent aphrodisiac.");
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
		combat.heroBaneProc(damage);
		//Kick back to main if no damage occured!
		if(player.hasStatusEffect(StatusEffects.FirstAttack)) player.removeStatusEffect(StatusEffects.FirstAttack);
		else {
			if (player.hasPerk(PerkLib.ManticoreMetabolism)) player.createStatusEffect(StatusEffects.FirstAttack,0,0,0,0);
			playerTailSpike();
		}
		if(monster.HP > 0 && monster.lust < monster.maxLust()) enemyAI();
		else doNext(endLustVictory);
	}


	public function kissAttack():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
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
		if(!combatIsOver()) enemyAI();
	}
//Mouf Attack
// (Similar to the bow attack, high damage but it raises your fatigue).
	public function bite():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		if (player.fatigue + physicalCost(25) > player.maxFatigue()) {
			clearOutput();
			if (player.faceType == Face.SHARK_TEETH) outputText("You're too fatigued to use your shark-like jaws!");
			if (player.faceType == Face.ORCA) outputText("You're too fatigued to use your orca-like jaws!");
			if (player.faceType == Face.WOLF) outputText("You're too fatigued to use your wolf jaws!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		//Worms are special
		if (monster.short == "worms") {
			clearOutput();
			outputText("There is no way those are going anywhere near your mouth!\n\n");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(25, USEFATG_PHYSICAL);
		//Amily!
		if(monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
			enemyAI();
			return;
		}
		outputText("You open your mouth wide, your ");
		if (player.faceType == Face.SHARK_TEETH) outputText("shark teeth extending out");
		if (player.faceType == Face.ORCA) outputText("sharp orca teeth shining briefly");
		if (player.faceType == Face.WOLF) outputText("sharp wolf teeth shining briefly");
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
			if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
			if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
			if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
			if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
			if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
			if (player.armor == armors.SPKIMO) damage *= 1.2;
			if (player.necklace == necklaces.OBNECK) damage *= 1.2;
			if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
			if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
			if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
			if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
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
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		//Kick back to main if no damage occured!
		if(monster.HP > 0 && monster.lust < monster.maxLust()) {
			enemyAI();
		}
		else {
			if(monster.HP <= monster.minHP()) doNext(endHpVictory);
			else doNext(endLustVictory);
		}
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
		player.createStatusEffect(StatusEffects.CooldownKick,5,0,0,0);
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
		//Amily!
		if (monster.hasStatusEffect(StatusEffects.Concentration)) {
			clearOutput();
			outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
			enemyAI();
			return;
		}
		//Blind
		if (player.hasStatusEffect(StatusEffects.Blind)) {
			outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ");
		}
		//Worms are special
		if (monster.short == "worms") {
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
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			//Akbal dodges special education
			if (monster.short == "Akbal") outputText("Akbal moves like lightning, weaving in and out of your furious attack with the speed and grace befitting his jaguar body.\n");
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
		if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) damage += scalingBonusStrength();
		else damage += scalingBonusStrength() * 0.5;
		damage += scalingBonusSpeed() * 0.5;
		//Leg bonus
		//Bunny - 20, 1 hoof = 30, 2 hooves = 40, Kangaroo - 50
		if (player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.PONY || player.lowerBody == LowerBody.CLOVEN_HOOFED)
			damage += 30;
		else if (player.lowerBody == LowerBody.BUNNY) damage += 20;
		else if (player.lowerBody == LowerBody.KANGAROO) damage += 50;
		if (player.isTaur()) damage += 10;
		//Damage post processing!
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
		if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		//Reduce damage
		damage *= monster.damagePercent() / 100;
		//(None yet!)
		if (damage > 0) {
			damage = doDamage(damage);
			if (player.hasPerk(PerkLib.PhantomStrike)) damage = doDamage(damage);
		}
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
			if(!monster.plural) outputText(" reels from the damaging impact! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			else outputText(" reel from the damaging impact! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			if (player.hasPerk(PerkLib.PhantomStrike)) {
				outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>)");
				damage *= 2;
			}
		}
		if (damage > 0) {
			//Lust raised by anemone contact!
			if (monster.short == "anemone") {
				outputText("\nThough you managed to hit the anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.");
				//(gain lust, temp lose str/spd)
				(monster as Anemone).applyVenom((1+rand(2)));
			}
			//Lust raised by sea anemone contact!
			if (monster.short == "sea anemone") {
				outputText("\nThough you managed to hit the sea anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.");
				//(gain lust, temp lose str/spd)
				(monster as SeaAnemone).applyVenom((1+rand(2)));
			}
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		if (!combatIsOver())enemyAI();
	}

	public function shieldBash():void {
		clearOutput();
		outputText("You ready your [shield] and prepare to slam it towards " + monster.a + monster.short + ".  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
			enemyAI();
			return;
		}
		var damage:int = 10 + (player.str / 1.5) + rand(player.str / 2) + (player.shieldBlock * 2);
		if (player.hasPerk(PerkLib.ShieldSlam)) damage *= 1.2;
		if (player.hasPerk(PerkLib.SteelImpact)) damage += ((player.tou - 50) * 0.3);
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		damage *= (monster.damagePercent() / 100);
		var chance:int = Math.floor(monster.statusEffectv1(StatusEffects.TimesBashed) + 1);
		if (chance > 10) chance = 10;
		damage = doDamage(damage);
		outputText("Your [shield] slams against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
		if (!monster.hasStatusEffect(StatusEffects.Stunned) && rand(chance) == 0) {
			outputText("<b>Your impact also manages to stun " + monster.a + monster.short + "!</b> ");
			monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			if (!monster.hasStatusEffect(StatusEffects.TimesBashed)) monster.createStatusEffect(StatusEffects.TimesBashed, player.hasPerk(PerkLib.ShieldSlam) ? 0.5 : 1, 0, 0, 0);
			else monster.addStatusValue(StatusEffects.TimesBashed, 1, player.hasPerk(PerkLib.ShieldSlam) ? 0.5 : 1);
		}
		checkAchievementDamage(damage);
		fatigue(20, USEFATG_PHYSICAL);
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
		outputText("You skillfully toss your net at " + monster.a + monster.short + " restraining " + monster.pronoun3 + " movement.");
		player.createStatusEffect(StatusEffects.CooldownNet,8,0,0,0);
		monster.createStatusEffect(StatusEffects.Stunned,3,0,0,0);
		enemyAI();
	}
	public function archerSidewinder():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		var costSidewinder:Number = 0;
		if (player.hasPerk(PerkLib.Multishot)) costSidewinder += 6;
		else if (player.hasPerk(PerkLib.WildQuiver)) costSidewinder += 5;
		else if (player.hasPerk(PerkLib.Manyshot)) costSidewinder += 4;
		else if (player.hasPerk(PerkLib.TripleStrike)) costSidewinder += 3;
		else if (player.hasPerk(PerkLib.DoubleStrike)) costSidewinder += 2;
		else costSidewinder += 1;
		if (player.fatigue + bowCost(200 * costSidewinder) > player.maxFatigue()) {
			outputText("You are too tired to attack " + monster.a + " " + monster.short + ".");
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
		damage += player.spe;
		damage += scalingBonusSpeed() * 0.2;
		if (damage < 10) damage = 10;
		if (!player.hasPerk(PerkLib.DeadlyAim)) damage *= (monster.damagePercent() / 100);//jak ten perk o ignorowaniu armora bedzie czy coś to tu dać jak nie ma tego perku to sie dolicza
		//Weapon addition!
		if (player.weaponRangeAttack < 51) damage *= (1 + (player.weaponRangeAttack * 0.03));
		else if (player.weaponRangeAttack >= 51 && player.weaponRangeAttack < 101) damage *= (2.5 + ((player.weaponRangeAttack - 50) * 0.025));
		else if (player.weaponRangeAttack >= 101 && player.weaponRangeAttack < 151) damage *= (3.75 + ((player.weaponRangeAttack - 100) * 0.02));
		else if (player.weaponRangeAttack >= 151 && player.weaponRangeAttack < 201) damage *= (4.75 + ((player.weaponRangeAttack - 150) * 0.015));
		else damage *= (5.5 + ((player.weaponRangeAttack - 200) * 0.01));
		//add bonus for attacking animal-morph or beast enemy
		if (monster.hasPerk(PerkLib.EnemyBeastOrAnimalMorphType)) damage *= (10 * costSidewinder);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.VitalShot) && player.inte >= 50) critChance += 10;
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (player.hasPerk(PerkLib.HistoryScout) || player.hasPerk(PerkLib.PastLifeScout)) damage *= combat.historyScoutBonus();
		if (player.hasPerk(PerkLib.JobRanger)) damage *= 1.05;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_R_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
		if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
			if (player.statusEffectv1(StatusEffects.Kelt) < 100) damage *= 1 + (0.01 * player.statusEffectv1(StatusEffects.Kelt));
			else {
				if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
					if (player.statusEffectv1(StatusEffects.Kindra) < 150) damage *= 2 + (0.01 * player.statusEffectv1(StatusEffects.Kindra));
					else damage *= 3.5;
				}
				else damage *= 2;
			}
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 3) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 4) {
			damage += player.inte * 0.2;
			if (player.inte >= 50) damage += player.inte * 0.1;
			if (player.inte >= 100) damage += player.inte * 0.1;
			if (player.inte >= 150) damage += player.inte * 0.1;
			if (player.inte >= 200) damage += player.inte * 0.1;
		}
		damage = Math.round(damage);
		outputText("You shoot the projectile toward your opponent the bolt flying at such speed and velocity all you see is a flash of light as it reach " + monster.a + monster.short + " and explode the blast projecting dirt and rock everywhere. It takes an entire minute for the smoke to settle. ");
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) damage = doFireDamage(damage, true, true);
		else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) damage = doIceDamage(damage, true, true);
		else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 3) damage = doLightingDamage(damage, true, true);
		else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 4) damage = doDarknessDamage(damage, true, true);
		else damage = doDamage(damage, true, true);
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		if (flags[kFLAGS.CUPID_ARROWS] == 1) {
			outputText(" ");
			if(monster.lustVuln == 0) {
				outputText("It has no effect! Your foe clearly does not experience lust in the same way as you.");
			}
			else {
				var lustArrowDmg:Number = monster.lustVuln * (player.inte / 5 * spellMod() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
				if (monster.lust < (monster.maxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects [monster him].  ");
				if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
					if (monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
					else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
				}
				if (monster.lust >= (monster.maxLust() * 0.6)) {
					outputText(monster.capitalA + monster.short + "'");
					if(!monster.plural) outputText("s");
					outputText(" eyes glaze over with desire for a moment.  ");
				}
				lustArrowDmg = Math.round(lustArrowDmg);
				monster.lust += lustArrowDmg;
				outputText("<b>(<font color=\"#ff00ff\">" + lustArrowDmg + "</font>)</b>");
			}
		}
		outputText("\n\n");
		flags[kFLAGS.ARROWS_SHOT]++;
		bowPerkUnlock();
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		enemyAI();
	}

	public function archerBarrage():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		if (player.hasPerk(PerkLib.Multishot)) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 6;
		else if (player.hasPerk(PerkLib.WildQuiver)) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 5;
		else if (player.hasPerk(PerkLib.Manyshot)) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 4;
		else if (player.hasPerk(PerkLib.TripleStrike)) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 3;
		else if (player.hasPerk(PerkLib.DoubleStrike)) flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 2;
		else flags[kFLAGS.MULTIPLE_ARROWS_STYLE] = 1;
		clearOutput();
		if (player.fatigue + bowCost(200) > player.maxFatigue()) {
			outputText("You are too tired to attack " + monster.a + " " + monster.short + ".");
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
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("Holding your weapon horizontally you shoot them all spraying " + monster.a + monster.short + " with projectile. (<b><font color=\"#800000\">" + damage + "</font></b>) ");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (flags[kFLAGS.CUPID_ARROWS] == 1) {
			outputText(" ");
			if(monster.lustVuln == 0) {
				outputText("It has no effect! Your foe clearly does not experience lust in the same way as you.");
			}
			else {
				var lustArrowDmg:Number = monster.lustVuln * (player.inte / 5 * spellMod() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
				if (monster.lust < (monster.maxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects [monster him].  ");
				if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
					if (monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
					else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
				}
				if (monster.lust >= (monster.maxLust() * 0.6)) {
					outputText(monster.capitalA + monster.short + "'");
					if(!monster.plural) outputText("s");
					outputText(" eyes glaze over with desire for a moment.  ");
				}
				lustArrowDmg = Math.round(lustArrowDmg);
				monster.lust += lustArrowDmg;
				outputText("<b>(<font color=\"#ff00ff\">" + lustArrowDmg + "</font>)</b>");
			}
		}
		flags[kFLAGS.ARROWS_SHOT] += 6;
		bowPerkUnlock();
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
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		outputText("Then do it another time showering them with an extra volley of arrows. ");
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) damage = doFireDamage(damage, true, true);
		else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) damage = doIceDamage(damage, true, true);
		else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 3) damage = doLightingDamage(damage, true, true);
		else if (flags[kFLAGS.ELEMENTAL_ARROWS] == 4) damage = doDarknessDamage(damage, true, true);
		else damage = doDamage(damage, true, true);
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		if (flags[kFLAGS.CUPID_ARROWS] == 1) {
			outputText(" ");
			if(monster.lustVuln == 0) {
				outputText("It has no effect! Your foe clearly does not experience lust in the same way as you.");
			}
			else {
				var lustArrowDmg:Number = monster.lustVuln * (player.inte / 5 * spellMod() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
				if (monster.lust < (monster.maxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects [monster him].  ");
				if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
					if (monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
					else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
				}
				if (monster.lust >= (monster.maxLust() * 0.6)) {
					outputText(monster.capitalA + monster.short + "'");
					if(!monster.plural) outputText("s");
					outputText(" eyes glaze over with desire for a moment.  ");
				}
				lustArrowDmg = Math.round(lustArrowDmg);
				monster.lust += lustArrowDmg;
				outputText("<b>(<font color=\"#ff00ff\">" + lustArrowDmg + "</font>)</b>");
			}
		}
		outputText("\n\n");
		flags[kFLAGS.ARROWS_SHOT] += 6;
		bowPerkUnlock();
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if (monster.HP <= monster.minHP() || flags[kFLAGS.MULTIPLE_ARROWS_STYLE] == 1) enemyAI();
		else archerBarrage2();
	}
	private function archerBarrage3():Number {
		var dmgBarrage:Number = 0;
		dmgBarrage += player.spe;
		dmgBarrage += scalingBonusSpeed() * 0.2;
		if (dmgBarrage < 60) dmgBarrage = 60;
		if (!player.hasPerk(PerkLib.DeadlyAim)) dmgBarrage *= (monster.damagePercent() / 100);//jak ten perk o ignorowaniu armora bedzie czy coś to tu dać jak nie ma tego perku to sie dolicza
		//Weapon addition!
		if (player.weaponRangeAttack < 51) dmgBarrage *= (1 + (player.weaponRangeAttack * 0.03));
		else if (player.weaponRangeAttack >= 51 && player.weaponRangeAttack < 101) dmgBarrage *= (2.5 + ((player.weaponRangeAttack - 50) * 0.025));
		else if (player.weaponRangeAttack >= 101 && player.weaponRangeAttack < 151) dmgBarrage *= (3.75 + ((player.weaponRangeAttack - 100) * 0.02));
		else if (player.weaponRangeAttack >= 151 && player.weaponRangeAttack < 201) dmgBarrage *= (4.75 + ((player.weaponRangeAttack - 150) * 0.015));
		else dmgBarrage *= (5.5 + ((player.weaponRangeAttack - 200) * 0.01));
		//add bonus for using aoe special
		dmgBarrage *= 6;
		if (player.hasPerk(PerkLib.HistoryScout) || player.hasPerk(PerkLib.PastLifeScout)) dmgBarrage *= combat.historyScoutBonus();
		if (player.hasPerk(PerkLib.JobRanger)) dmgBarrage *= 1.05;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_R_ATTACK_POWER) dmgBarrage *= 1 + (player.jewelryEffectMagnitude / 100);
		if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
			if (player.statusEffectv1(StatusEffects.Kelt) < 100) dmgBarrage *= 1 + (0.01 * player.statusEffectv1(StatusEffects.Kelt));
			else {
				if (player.statusEffectv1(StatusEffects.Kindra) > 0) {
					if (player.statusEffectv1(StatusEffects.Kindra) < 150) dmgBarrage *= 2 + (0.01 * player.statusEffectv1(StatusEffects.Kindra));
					else dmgBarrage *= 3.5;
				}
				else dmgBarrage *= 2;
			}
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) {
			dmgBarrage += player.inte * 0.2;
			if (player.inte >= 50) dmgBarrage += player.inte * 0.1;
			if (player.inte >= 100) dmgBarrage += player.inte * 0.1;
			if (player.inte >= 150) dmgBarrage += player.inte * 0.1;
			if (player.inte >= 200) dmgBarrage += player.inte * 0.1;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) {
			dmgBarrage += player.inte * 0.2;
			if (player.inte >= 50) dmgBarrage += player.inte * 0.1;
			if (player.inte >= 100) dmgBarrage += player.inte * 0.1;
			if (player.inte >= 150) dmgBarrage += player.inte * 0.1;
			if (player.inte >= 200) dmgBarrage += player.inte * 0.1;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 3) {
			dmgBarrage += player.inte * 0.2;
			if (player.inte >= 50) dmgBarrage += player.inte * 0.1;
			if (player.inte >= 100) dmgBarrage += player.inte * 0.1;
			if (player.inte >= 150) dmgBarrage += player.inte * 0.1;
			if (player.inte >= 200) dmgBarrage += player.inte * 0.1;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 4) {
			dmgBarrage += player.inte * 0.2;
			if (player.inte >= 50) dmgBarrage += player.inte * 0.1;
			if (player.inte >= 100) dmgBarrage += player.inte * 0.1;
			if (player.inte >= 150) dmgBarrage += player.inte * 0.1;
			if (player.inte >= 200) dmgBarrage += player.inte * 0.1;
		}
		return dmgBarrage;
	}
	
	public function mechTazer():void {
		clearOutput();
		outputText("You press the lightning button and aim, smirking at " + monster.a + monster.short + ", your mech delivering a ");
		player.createStatusEffect(StatusEffects.CooldownTazer,8,0,0,0);
		if (player.hasKeyItem("Taser overcharge battery") >= 0) {
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
			damage = calcVoltageMod(damage);
			if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
			damage *= 0.5;
			damage = Math.round(damage);
			outputText("potent discharge ");
			damage = doLightingDamage(damage, true, true);
			outputText(" damage!");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
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
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		if (player.hasKeyItem("Omni Missile") >= 0) outputText("You deploy the omni Missile and rain death on " + monster.a + monster.short + ", covering the entire area with explosions for ");
		else outputText("You deploy the missile launcher and aim at " + monster.a + monster.short + ", for a big explosion. ");
		var damage:Number = 0;
		damage += 300 + rand(121);
		if (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyGigantType)) {
			if (player.hasKeyItem("Omni Missile") >= 0) damage *= 10;
			else damage *= 5;
		}
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
		damage = doDamage(damage, true, true);
		outputText(" damage!");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		monster.HP -= damage;
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
		enemyAI();
	}
	
	public function mechGravityShots():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		outputText("You press the spiral button and aim, unleashing the gravity sphere at " + monster.a + monster.short + ". ");
		player.createStatusEffect(StatusEffects.CooldownGravityShots,8,0,0,0);
		var damage:Number = 0;
		damage = scalingBonusIntelligence() * spellModBlack() * 2;
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) damage *= 4;
		if (monster.hasPerk(PerkLib.EnemyGroupType)) damage *= 8;
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
		damage = doDarknessDamage(damage, true, true);
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		if (monster.isFlying()) {
			outputText(" There is something very satisfying about hampering your opponent’s ability to fly around by messing with their space.");
			monster.createStatusEffect(StatusEffects.Stunned, 4, 0, 0, 0);
		}
		outputText("\n\n");
		monster.HP -= damage;
		combat.heroBaneProc(damage);
		statScreenRefresh();
		enemyAI();
	}
	
	public function mechRaijinBlaster():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		outputText("You press the BIG lightning button and aim, smirking wide as the Raijin blaster power up your mech zapping " + monster.a + monster.short + " for ");
		player.createStatusEffect(StatusEffects.CooldownRaijinBlaster,8,0,0,0);
		var damage:Number = 0;
		damage = scalingBonusIntelligence() * spellModWhite() * 2;
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) damage *= 4;
		if (monster.hasPerk(PerkLib.EnemyGroupType)) damage *= 8;
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
		damage = doLightingDamage(damage, true, true);
		outputText(" damage! ");
		if (crit == true) outputText("<b>*Critical Hit!*</b> ");
		var lustDmg:Number = monster.lustVuln * (player.inte / 5 * spellModBlack() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
		//Determine if critical tease!
		var crit1:Boolean = false;
		var critChance1:int = 5;
		if (player.hasPerk(PerkLib.CriticalPerformance)) {
			if (player.lib <= 100) critChance1 += player.lib / 5;
			if (player.lib > 100) critChance1 += 20;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance1 = 0;
		if (rand(100) < critChance1) {
			crit1 = true;
			lustDmg *= 1.75;
		}
		lustDmg = Math.round(lustDmg);
		monster.teased(lustDmg);
		if (crit1 == true) outputText(" <b>Critical!</b>");
		outputText("\n\n");
		monster.HP -= damage;
		combat.heroBaneProc(damage);
		statScreenRefresh();
		enemyAI();
	}
	
	public function mechSnowballGenerator():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		outputText("You activate the snowball generator, taking aim and launching a volley of snowballs at the " + monster.a + monster.short + " for ");
		player.createStatusEffect(StatusEffects.CooldownSnowballGenerator,8,0,0,0);
		var damage:Number = 0;
		damage = scalingBonusIntelligence() * spellModBlack() * 4;
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) damage *= 4;
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
		damage = doIceDamage(damage, true, true);
		outputText(" damage!");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		monster.HP -= damage;
		combat.heroBaneProc(damage);
		statScreenRefresh();
		enemyAI();
	}
	
	public function mechWhitefireBeamCannon():void {
		clearOutput();
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		outputText("You shoot with the Whitefire beam cannon at " + monster.a + monster.short + " burning " + monster.pronoun3 + " badly for ");
		player.createStatusEffect(StatusEffects.CooldownWhitefireBeamCannon,8,0,0,0);
		var damage:Number = 0;
		damage = scalingBonusIntelligence() * spellModWhite() * 4;
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) damage *= 4;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2);
		damage = Math.round(damage);
		damage = doFireDamage(damage, true, true);
		outputText(" damage!");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		monster.HP -= damage;
		combat.heroBaneProc(damage);
		statScreenRefresh();
		enemyAI();
	}
	
	public function mechDynapunchGlove():void {
		clearOutput();
		outputText("You launch the mech springed glove at " + monster.a + monster.short + " hitting " + monster.pronoun3 + " straight in the face for a K.O. " + monster.a + monster.short + " is hit for ");
		player.createStatusEffect(StatusEffects.CooldownDynapunchGlove,8,0,0,0);
		var damage:Number = 0;
		damage += player.str;
		damage += scalingBonusStrength() * 0.25;
		if (damage < 10) damage = 10;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 15;
		var critDamage:Number = 1.75;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= critDamage;
		}
		//Apply AND DONE!
		damage *= (monster.damagePercent() / 100);
		damage = Math.round(damage);
		if (damage < 10) damage = 10;
		if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.hasPerk(PerkLib.GoblinoidBlood)) {
			if (player.hasKeyItem("Power bracer") >= 0) damage *= 1.1;
			if (player.hasKeyItem("Powboy") >= 0) damage *= 1.15;
			if (player.hasKeyItem("M.G.S. bracer") >= 0) damage *= 1.2;
		}
		damage = doDamage(damage);
		outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b> damage");
		if (!monster.hasPerk(PerkLib.Resolute)) {
			outputText(" stunning " + monster.pronoun3 + " for the round");
			monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
		}
		outputText(".");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		combat.heroBaneProc(damage);
		statScreenRefresh();
		enemyAI();
	}

	public function PhysicalSpecials() {
	}
}
}
