/**
 * Created by JTecx on 21.08.21.
 * Based on PerkLib, created by Aimozg.
 */
package classes
{
import classes.BodyParts.Arms;
import classes.BodyParts.Face;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;

public class MutationsLib
	{
		public function get game():CoC{
			return CoC.instance;
		}
		//public static const
		public static const DraconicBones:PerkType = mk("Draconic Bones", "Draconic Bones",
				"Basic strengthening of your body bone structure. (+10 to unarmed attack)",
				"You've chosen the 'Draconic Bones' perk. Basic strengthening of your body bone structure. (+10 to unarmed attack)").withBuffs({'tou.mult':0.05});
		public static const DraconicBonesEvolved:PerkType = mk("Draconic Bones (Evolved)", "Draconic Bones (Evolved)",
				"Advanced strengthening of your body bone structure. (+10 to unarmed attack, +5% to damage reduction against physical and magical attacks, +5% of max core Tou as phantom Tou)",
				"You've chosen the 'Draconic Bones (Evolved)' perk. Advanced strengthening of your body bone structure. (+10 to unarmed attack, +5% to damage reduction against physical and magical attacks, +5% of max core Tou as phantom Tou)").withBuffs({'tou.mult':0.10});
		public static const DraconicBonesFinalForm:PerkType = mk("Draconic Bones (Final Form)", "Draconic Bones (Final Form)",
				"Strengthening of your body bone structure to pseudo-dragon grade. (+20 to unarmed attack, +50% to unarmed atk, +5% to damage reduction against physical and magical attacks, +10% of max core Tou as phantom Tou)",
				"You've chosen the 'Draconic Bones (Final Form)' perk. Strengthening of your body bone structure to pseudo-dragon grade. (+20 to unarmed attack, +50% to unarmed atk, +5% to damage reduction against physical and magical attacks, +10% of max core Tou as phantom Tou)").withBuffs({'tou.mult':0.20});
		public static const DraconicHeart:PerkType = mk("Draconic Heart", "Draconic Heart",
				"Your heart was strengthened to better handle your changing body. (+1 Fatigue / +4 SF / +5 Mana / +1 Wrath regen)",
				"You've chosen the 'Draconic Heart' perk. Your heart was strengthened to better handle your changing body. (+1 Fatigue / +4 SF / +5 Mana / +1 Wrath regen)").withBuffs({'str.mult':0.05});
		public static const DraconicHeartEvolved:PerkType = mk("Draconic Heart (Evolved)", "Draconic Heart (Evolved)",
				"Each heartbeat fills your body with great power. (+1 Fatigue / +4 SF / +5 Mana / +1 Wrath regen, +5% of max core Str as phantom Str)",
				"You've chosen the 'Draconic Heart (Evolved)' perk. Each heartbeat fills your body with great power. (+1 Fatigue / +4 SF / +5 Mana / +1 Wrath regen, +5% of max core Str as phantom Str)").withBuffs({'str.mult':0.10});
		public static const DraconicHeartFinalForm:PerkType = mk("Draconic Heart (Final Form)", "Draconic Heart (Final Form)",
				"Your heart metamorphosis reached pseudo-dragon level. (+1 Fatigue / +4 SF / +5 Mana / +1 Wrath regen, +1% HP regen, +10% of max core Str as phantom Str)",
				"You've chosen the 'Draconic Heart (Final Form)' perk. Your heart metamorphosis reached pseudo-dragon level. (+1 Fatigue / +4 SF / +5 Mana / +1 Wrath regen, +1% HP regen, +10% of max core Str as phantom Str)").withBuffs({'str.mult':0.20});
		public static const DrakeLungs:PerkType = mk("Drake Lungs", "Drake Lungs",
				"Increases the power of dragon breath attack. (+300% to dragon breath damage that race is using)",
				"You've chosen the 'Drake Lungs' perk. Increases the power of dragon breath attack.").withBuffs({'spe.mult':0.05});
		public static const DrakeLungsEvolved:PerkType = mk("Drake Lungs (Evolved)", "Drake Lungs (Evolved)",
				"Further increases increases dragon breath attack power. (+300% to dragon breath damage that race is using)",
				"You've chosen the 'Drake Lungs (Evolved)' perk. Further increases increases dragon breath attack power.").withBuffs({'spe.mult':0.10});
		public static const DrakeLungsFinalForm:PerkType = mk("Drake Lungs (Final Form)", "Drake Lungs (Final Form)",
				"Allows to use breath attack more often with increase to it power. (+300% to dragon breath damage that race is using AND breath usable once per combat)",
				"You've chosen the 'Drake Lungs (Final Form)' perk. Allows to use breath attack more often with increase to it power.").withBuffs({'spe.mult':0.20});
		public static const FloralOvaries:PerkType = mk("Floral Ovaries", "Floral Ovaries",
				"Increase the potency of Alraune pollen.",
				"You've chosen the 'Floral Ovaries' perk. Increase the potency of Alraune pollen.").withBuffs({'lib.mult':0.05});
		public static const FloralOvariesEvolved:PerkType = mk("Floral Ovaries (Evolved)", "Floral Ovaries (Evolved)",
				"Further increase the potency of Alraune pollen. Males takes an extra 50% lust damage.",
				"You've chosen the 'Floral Ovaries (Evolved)' perk. Further increase the potency of Alraune pollen. Males takes an extra 50% lust damage.").withBuffs({'lib.mult':0.10});
		public static const FloralOvariesFinalForm:PerkType = mk("Floral Ovaries (Final Form)", "Floral Ovaries (Final Form)",
				"Further increase the potency of Alraune pollen. Alraune pollen has a 25% chance per round to fascinate your victim.",
				"You've chosen the 'Floral Ovaries (Final Form)' perk. Further increase the potency of Alraune pollen. Alraune pollen has a 30% chance per round to fascinate your victim.").withBuffs({'lib.mult':0.20});
		public static const HarpyHollowBones:PerkType = mk("Harpy Hollow Bones", "Harpy Hollow Bones",
				"Your bones are hollow like those of a harpy granting you 20% increased physical damage when flying and increasing speed at the expense of toughness. Also allows to keep Harpy song.",
				"You've chosen the 'Harpy Hollow Bones' perk. Increase damage while flying by 20% and increasing speed at the expense of toughness.").withBuffs({'tou.mult':-0.05,'spe.mult':0.20});
		public static const HarpyHollowBonesEvolved:PerkType = mk("Harpy Hollow Bones (Evolved)", "Harpy Hollow Bones (Evolved)",
				"Your bones are hollow like those of a harpy granting you an additionnal 30% increased physical damage when flying and increasing speed at the expense of toughness. Increase flying evasiveness by 10%.",
				"You've chosen the 'Harpy Hollow Bones (Evolved)' perk. Further Increase damage while flying by 30% and increasing speed at the expense of toughness. Increase flying evasiveness by 10%.").withBuffs({'tou.mult':-0.05,'spe.mult':0.25});
		public static const HarpyHollowBonesFinalForm:PerkType = mk("Harpy Hollow Bones (Final Form)", "Harpy Hollow Bones (Final Form)",
				"Your bones are hollow like those of a harpy granting you an additionnal 30% increased physical damage when flying and increasing speed at the expense of toughness. Increase great dive damage by 50%.",
				"You've chosen the 'Harpy Hollow Bones (Final Form)' perk. Further Increase damage while flying by 50% and increasing speed at the expense of toughness. Increase great dive damage by 50% and no longuer cause it to end flight.").withBuffs({'tou.mult':-0.05,'spe.mult':0.45});
		public static const HeartOfTheStorm:PerkType = mk("Heart of the storm", "Heart of the storm",
				"Increase the power of all Wind and Lightning racial abilities.",
				"You've chosen the 'Heart of the storm' perk. Increase the power of all Wind and Lightning racial abilities.").withBuffs({'spe.mult':0.05});
		public static const HeartOfTheStormEvolved:PerkType = mk("Heart of the storm (Evolved)", "Heart of the storm (Evolved)",
				"Further increase the power of all Wind and Lightning abilities and Increase wind and electricity resistance by 10%.",
				"You've chosen the 'Heart of the storm (Evolved)' perk. Further increase the power of all Wind and Lightning abilities and Increase wind and electricity resistance by 10%.").withBuffs({'spe.mult':0.10});
		public static const HeartOfTheStormFinalForm:PerkType = mk("Heart of the storm (Final Form)", "Heart of the storm (Final Form)",
				"Further increase the power of all Wind and Lightning abilities and Increases wind and electricity resistance by another 30%. You may fly without end so long as you got the ability to fly. If you got energy attacks you have now a chance to stun your opponents with them.",
				"You've chosen the 'Heart of the storm (Final Form)' perk. Further increase the power of all Wind and Lightning abilities and Increases wind and electricity resistance by another 30%. You may fly without end so long as you got the ability to fly. If you got energy attacks you have now a chance to stun your opponents with them.").withBuffs({'spe.mult':0.20});
		public static const SlimeMetabolism:PerkType = mk("Slime Metabolism", "Slime Metabolism",
				"Allows you to gain a boost of speed for a few hours after an intake of cum and allows you to attack twice per turn.",
				"You've chosen the 'Slime Metabolism' perk, allows you to gain a boost of speed after an intake of cum and attack more often.");
		public static const SlimeMetabolismEvolved:PerkType = mk("Slime Metabolism (Evolved)", "Slime Metabolism (Evolved)",
				"Increase by (10 * NG tier) boost of speed for a five hours longer after an intake of cum and increase max Hunger cap by 50 (if PC have Hunger bar active).",
				"You've chosen the 'Slime Metabolism (Evolved)' perk, allows you to increase max boost of speed after an intake of cum and keeping it for 50% longer.");
		public static const NekomataThyroidGland:PerkType = mk("Nekomata Thyroid Gland", "Nekomata Thyroid Gland",
				"Nekomata Thyroid Gland .",//lower cooldowns for Illusion and Terror by three turns, increase speed of the recovery after using magic and slightly boost PC speed
				"You've chosen the 'Nekomata Thyroid Gland' perk. Some time after you become nekomata part of your body changed allowing to boost your nekomata powers.");
		public static const NekomataThyroidGlandEvolved:PerkType = mk("Nekomata Thyroid Gland (Evolved)", "Nekomata Thyroid Gland (Evolved)",
				"Nekomata Thyroid Gland (Evolved) .",//increase speed of the recovery after using magic, boost PC speed and wisdom. And make fox fire specials 50% stronger when having 9 tails (both fire and lust damage)
				"You've chosen the 'Nekomata Thyroid Gland (Evolved)' perk. Continued using of nekomata powers caused your thyroid gland to evolve.");
		public static const NekomataThyroidGlandFinalForm:PerkType = mk("Nekomata Thyroid Gland (Final Form)", "Nekomata Thyroid Gland (Final Form)",
				"Nekomata Thyroid Gland (Final Form) .",//grant bonus soulforce/mana regen depending on Star Sphere rank, increase max Star Sphere rank to 20. Increase speed debuff of Terror to 50, increase evasion boost from Illusion to 20%. Boost PC speed, wisdom and intelligence
				"You've chosen the 'Nekomata Thyroid Gland (Final Form)' perk. Your thyroid gland to evolved once again increasing efficiency of your nekomata powers.");
		public static const HellcatParathyroidGlands:PerkType = mk("Hellcat Parathyroid Glands", "Hellcat Parathyroid Glands",
				".",
				"You've chosen the 'Hellcat Parathyroid Glands' perk, .");
		public static const HellcatParathyroidGlandsEvolved:PerkType = mk("Hellcat Parathyroid Glands (Evolved)", "Hellcat Parathyroid Glands (Evolved)",
				".",
				"You've chosen the 'Hellcat Parathyroid Glands (EvFolved)' perk, .");
		public static const HellcatParathyroidGlandsFinalForm:PerkType = mk("Hellcat Parathyroid Glands (Final Form)", "Hellcat Parathyroid Glands (Final Form)",
				".",
				"You've chosen the 'Hellcat Parathyroid Glands (Final Form)' perk, .");
		public static const CaveWyrmLungs:PerkType = mk("Cave Wyrm Lungs", "Cave Wyrm Lungs",
				"Your lung has became accustomed to the presence of acid in your biology improving the corrosiveness and volatility of your biochemical weapons.",
				"You've chosen the 'Cave Wyrm Lungs' perk, .");
		public static const CaveWyrmLungsEvolved:PerkType = mk("Cave Wyrm Lungs (Evolved)", "Cave Wyrm Lungs (Evolved)",
				".",
				"You've chosen the 'Cave Wyrm Lungs (Evolved)' perk, .");
		public static const CaveWyrmLungsFinalForm:PerkType = mk("Cave Wyrm Lungs (Final Form)", "Cave Wyrm Lungs (Final Form)",
				".",
				"You've chosen the 'Cave Wyrm Lungs (Final Form)' perk, .");
		public static const KitsuneParathyroidGlands:PerkType = mk("Kitsune Parathyroid Glands", "Kitsune Parathyroid Glands",
				".",//decrease terror/ilussions cooldown instead of thyroid gland - rise wis or bonus sf regen or mana regen and thyroid gland instead regering sf?
				"You've chosen the 'Kitsune Parathyroid Glands' perk, .");
		public static const KitsuneParathyroidGlandsEvolved:PerkType = mk("Kitsune Parathyroid Glands (Evolved)", "Kitsune Parathyroid Glands (Evolved)",
				".",
				"You've chosen the 'Kitsune Parathyroid Glands (Evolved)' perk, .");
		public static const KitsuneParathyroidGlandsFinalForm:PerkType = mk("Kitsune Parathyroid Glands (Final Form)", "Kitsune Parathyroid Glands (Final Form)",
				".",
				"You've chosen the 'Kitsune Parathyroid Glands (Final Form)' perk, .");
		public static const BlackHeart:PerkType = mk("Black Heart", "Black Heart",
				"Increase the power of lust strike and empower fascinate.",
				"You've chosen the 'Black Heart' perk. Increase the power of lust strike and empower fascinate.").withBuffs({'lib.mult':0.05});
		public static const BlackHeartEvolved:PerkType = mk("Black Heart (Evolved)", "Black Heart (Evolved)",
				"Adds additional lust dmg to Lust strike depending on your current wisdom (additional wisdom/10 lust dmg), lower by 1 turn CD on Fascinate.",
				"You've chosen the 'Black Heart (Evolved)' perk. Adds additional lust dmg to Lust strike depending on your current wisdom (additional wisdom/10 lust dmg), lower by 1 turn CD on Fascinate.").withBuffs({'lib.mult':0.10});
		public static const BlackHeartFinalForm:PerkType = mk("Black Heart (Final Form)", "Black Heart (Final Form)",
				"Adds additional lust dmg to Lust strike depending on your current sensitivity (additional sensitivity/10 lust dmg), extend to 2 turns stun from Fascinate.",
				"You've chosen the 'Black Heart (Final Form)' perk. Adds additional lust dmg to Lust strike depending on current chara sensitivity (additional sensitivity/10 lust dmg), extend to 2 turns stun from Fascinate.").withBuffs({'lib.mult':0.15});
		public static const DraconicLungs:PerkType = mk("Draconic Lungs", "Draconic Lungs",
				"Allows to use breath attack more often. (All dragon breaths usable once per combat)",
				"You've chosen the 'Draconic Lungs' perk. Allows to use breath attack more often.").withBuffs({'spe.mult':0.05});
		public static const DraconicLungsEvolved:PerkType = mk("Draconic Lungs (Evolved)", "Draconic Lungs (Evolved)",
				"Increases threefold the power of dragon breath attacks. (+300% to dragon breaths damage, +5% of max core Spe as phantom Spe)",
				"You've chosen the 'Draconic Lungs (Evolved)' perk. Increases threefold the power of dragon breath attacks.").withBuffs({'spe.mult':0.10});
		public static const DraconicLungsFinalForm:PerkType = mk("Draconic Lungs (Final Form)", "Draconic Lungs (Final Form)",
				"Further increases dragon breath attacks power and allows to combine all 4 basic breath types more often. (+600% to dragon breaths damage, +10% of max core Spe as phantom Spe)",
				"You've chosen the 'Draconic Lungs (Final Form)' perk. Further increases increases dragon breath attacks power and allows to combine all 4 basic breath types more often.").withBuffs({'spe.mult':0.20});
		public static const EasterBunnyEggBag:PerkType = mk("Easter Bunny egg bag", "Easter Bunny egg bag",
				"Keep oviposition, easter bunny balls and egg throw ability so long as you have balls. May now shoot more then one egg per round. Double cum production.",
				"You've chosen the 'Easter bunny balls' perk. Keep oviposition, easter bunny balls and egg throw ability so long as you have balls. May now shoot more then one egg per round. Double cum production.");
		public static const EasterBunnyEggBagEvolved:PerkType = mk("Easter bunny balls (Evolved)", "Easter bunny balls (Evolved)",
				"Raise libido by a percentage based on current balls size. Triple cum production.",
				"You've chosen the 'Easter bunny balls (Evolved)' perk. Raise libido by a percentage based on current balls size. Triple cum production.");
		public static const EasterBunnyEggBagFinalForm:PerkType = mk("Easter bunny balls (Final Form)", "Easter bunny balls (Final Form)",
				"Further raise libido by a percentage based on current balls size. Double balls growth rates and double cum production again.\n",
				"You've chosen the 'Easter bunny balls (Final Form)' perk. Further raise libido by a percentage based on current balls size. Double balls growth rates and double cum production again.");
		public static const ElvishPeripheralNervSys:PerkType = mk("Elvish Peripheral NervSys", "Elvish Peripheral NervSys",
				"Your Elvish Peripheral NervSys is giving you +5% of max core Spe as phantom Spe and allow to keep Elven Sense even without elf arms/legs.",
				"You've chosen the 'Elvish Peripheral NervSys' perk, due to repeadly balancing on line between life and death your peripheral nervous system started to work like that of elfs.");
		public static const ElvishPeripheralNervSysEvolved:PerkType = mk("Elvish Peripheral NervSys (Evolved)", "Elvish Peripheral NervSys (Evolved)",
				"Your Elvish Peripheral NervSys is giving you +10% of max core Spe as phantom Spe.",
				"You've chosen the 'Elvish Peripheral NervSys (Evolved)' perk, your peripheral nervous system continue subtile changes leading to be more elf-like.").withBuffs({'spe.mult':0.05});
		public static const ElvishPeripheralNervSysFinalForm:PerkType = mk("Elvish Peripheral NervSys (Final Form)", "Elvish Peripheral NervSys (Final Form)",
				"Your Elvish Peripheral NervSys is giving you +15% of max core Spe as phantom Spe, increase your natural evasion, decrease melee/range accuracy penalty when using multiattack options. Furthermore elven signature abilities will keep working weither you are a full blooded elf or not.",
				"You've chosen the 'Elvish Peripheral NervSys (Final Form)' perk, your peripheral nervous system reached it final changes to reassamble elvish peripheral nervous system. Furthermore elven signature abilities will keep working weither you are a full blooded elf or not.").withBuffs({'spe.mult':0.05});
		public static const FeyArcaneBloodstream:PerkType = mk("Fey Arcane Bloodstream", "Fey Arcane Bloodstream",
				"Your Fey Arcane Bloodstream is granting you along with an eternal lifespan increased mana recovery and increased magical power.",
				"You've chosen the 'Fey Arcane Bloodstream' perk, gaining along with an eternal lifespan increased mana recovery and increased magical power.").withBuffs({'int.mult':0.05});
		public static const FeyArcaneBloodstreamEvolved:PerkType = mk("Fey Arcane Bloodstream (Evolved)", "Fey Arcane Bloodstream (Evolved)",
				"Your Fey Arcane Bloodstream is granting you an even greater mana recovery and further increased magical power. Furthermore your chaotic magic is more likely to explode into additionnal effects.",
				"You've chosen the 'Fey Arcane Bloodstream (Evolved)' perk, gaining an even greater mana recovery and further increased magical power. Furthermore your chaotic magic is more likely to explode into additionnal effects.").withBuffs({'int.mult':0.10});
		public static const FeyArcaneBloodstreamFinalForm:PerkType = mk("Fey Arcane Bloodstream (Final Form)", "Fey Arcane Bloodstream (Final Form)",
				"Your Fey Arcane Bloodstream grants you an even greater mana recovery and further increased magical power. Furthermore your chaotic magic is more likely to explode into additionnal effects and its damage is increased by 50%.",
				"You've chosen the 'Fey Arcane Bloodstream (Final Form)' perk, gaining an even greater mana recovery and further increased magical power. Furthermore your chaotic magic is more likely to explode into additionnal effects and its damage is increased by 50%.").withBuffs({'int.mult':0.20});
		public static const FrozenHeart:PerkType = mk("Frozen heart", "Frozen heart",
				"Allow to retain the ability Ice barrage and hungering cold at all time and increase their damage by 10%.",
				"You've chosen the 'Frozen heart' perk, freezing your heart.");
		public static const FrozenHeartEvolved:PerkType = mk("Frozen heart (Evolved)", "Frozen heart (Evolved)",
				"Ice barrage and hungering cold abilities increase their damage by additional 20%, hungering cold last for 1 additional turn and recharge 1 turn faster.",
				"You've chosen the 'Frozen heart (Evolved)' perk, deepening your heart freezing.");
		public static const FrozenHeartFinalForm:PerkType = mk("Frozen heart (Final Form)", "Frozen heart (Final Form)",
				"Ice barrage and hungering cold abilities increase their damage by another 30%, hungering cold last for 3 additional turn and recharge 3 turn faster. Gain an extra modifier from your intelligence to health. (Increase original value by 50%).",
				"You've chosen the 'Frozen heart (Final Form)' perk, going beyond just a very frozen heart.");
		public static const HinezumiBurningBlood:PerkType = mk("Hinezumi burning blood", "Hinezumi burning blood",
				"Increase the healing from the cauterize ability by 0.5% and raise Blazing battle spirit duration by 1 round.",
				"You've chosen the 'Hinezumi burning blood' perk, increasing the healing from the cauterize ability by 0.5% and raising Blazing battle spirit duration by 1 round.").withBuffs({'tou.mult':0.05});
		public static const HinezumiBurningBloodEvolved:PerkType = mk("Hinezumi burning blood (Evolved)", "Hinezumi burning blood (Evolved)",
				"Increase the healing from the cauterize ability by 0.5% and raising Blazing battle spirit duration by 2 rounds.",
				"You've chosen the 'Hinezumi burning blood (Evolved)' perk, increasing the healing from the cauterize ability by 0.5% and raising Blazing battle spirit duration by 2 rounds.").withBuffs({'tou.mult':0.10});
		public static const HinezumiBurningBloodFinalForm:PerkType = mk("Hinezumi burning blood (Final Form)", "Hinezumi burning blood (Final Form)",
				"Increase the healing from the cauterize ability by 0.5%, raising Blazing battle spirit duration by 7 rounds and allowing to use cauterize even wihtout being an Hinezumi.",
				"You've chosen the 'Hinezumi burning blood (Final Form)' perk, increasing the healing from the cauterize ability by 0.5%, raising Blazing battle spirit duration by 7 rounds and the gaining ability to use cauterize at all time.").withBuffs({'tou.mult':0.15});
		public static const HollowFangs:PerkType = mk("Hollow Fangs", "Hollow Fangs",
				"Your fangs and mouth started to slowly change showing rudimental ability to suck out fluids like blood. (+5 max stack of Vampire Thirst)",
				"You've chosen the 'Hollow Fangs' perk. Due to often feeding on fluids like blood your mouth started to adapt to such feeding style.").withBuffs({'tou.mult':0.05});
		public static const HollowFangsEvolved:PerkType = mk("Hollow Fangs (Evolved)", "Hollow Fangs (Evolved)",
				"Your ability to suck substances like blood have developed halfway. (+5 max stack of Vampire Thirst, +3% more healed from Vampire Bite)",
				"You've chosen the 'Hollow Fangs (Evolved)' perk, changes to your mouth and tissues around progressing.").withBuffs({'tou.mult':0.10});
		public static const HollowFangsFinalForm:PerkType = mk("Hollow Fangs (Final Form)", "Hollow Fangs (Final Form)",
				"You can now freely feed on blood and other atypical fluids. (+5 max stack of Vampire Thirst, +7% more healed from Vampire Bite, each Vampire Bite giving 2 stacks and deal +50% lust dmg)",
				"You've chosen the 'Hollow Fangs (Final Form)' perk, you are well prepared to feed on substances like blood now.").withBuffs({'tou.mult':0.15});
		public static const KitsuneThyroidGland:PerkType = mk("Kitsune Thyroid Gland", "Kitsune Thyroid Gland",
				"Kitsune Thyroid Gland lower cooldowns for Illusion and Terror by three turns and increase speed of the recovery after using magic.",
				"You've chosen the 'Kitsune Thyroid Gland' perk. Lower the cooldowns for Illusion and Terror by three turns and increase the speed of the recovery after using magic.").withBuffs({'spe.mult':0.05});
		public static const KitsuneThyroidGlandEvolved:PerkType = mk("Kitsune Thyroid Gland (Evolved)", "Kitsune Thyroid Gland (Evolved)",
				"Kitsune Thyroid Gland (Evolved) increase the mana recovery after using magic and make fox fire specials 50% stronger when having 9 tails (both fire and lust damage).",
				"You've chosen the 'Kitsune Thyroid Gland (Evolved)' perk. Increases the mana recovery after using magic and make fox fire specials 50% stronger when having 9 tails (both fire and lust damage).").withBuffs({'spe.mult':0.05,'wis.mult':0.05});
		public static const KitsuneThyroidGlandFinalForm:PerkType = mk("Kitsune Thyroid Gland (Final Form)", "Kitsune Thyroid Gland (Final Form)",
				"Kitsune Thyroid Gland (Final Form) grant bonus soulforce/mana regeneration depending on your Star Sphere rank, increase max Star Sphere rank to 20. Increase speed debuff of Terror to 50, increase evasion boost from Illusion to 20%.",
				"You've chosen the 'Kitsune Thyroid Gland (Final Form)' perk. Your thyroid gland to evolved once again increasing the efficiency of your kitsune powers.").withBuffs({'spe.mult':0.05,'int.mult':0.05,'wis.mult':0.05});
		public static const LactaBovinaOvaries:PerkType = mk("Lacta Bovina Ovaries", "Lacta Bovina Ovaries",
				"Allow keep Milk Blast special even if cow score is lower than 9. Additionaly your max Lust increase by 10.",
				"You've chosen the 'Lacta Bovina Ovaries' perk. Interaction between permanent body alteration from Bimbo Liquer (maybe Bro Brew too) and your cow-like nature allows you to keep cow racial special even if you stop been cow-like.");
		public static const LactaBovinaOvariesEvolved:PerkType = mk("Lacta Bovina Ovaries (Evolved)", "Lacta Bovina Ovaries (Evolved)",
				"+5% to lust resistance, increase lactation output by 200 mLs",
				"You've chosen the 'Lacta Bovina Ovaries (Evolved)' perk. Granting more lust resistance, increase slight lactation output.").withBuffs({'lib.mult':0.10});
		public static const LactaBovinaOvariesFinalForm:PerkType = mk("Lacta Bovina Ovaries (Final Form)", "Lacta Bovina Ovaries (Final Form)",
				"+5 to max tou an +10 to max str/lib, increase milk production by ~100%, +90 to max lust and Milk Blast cost rise to 200 lust but can be used more than once per fight.",
				"You've chosen the 'Lacta Bovina Ovaries (Final Form)' perk. Granting boost to max lust, increase milk output and allowing using Milk Blast more than once per fight.").withBuffs({'str.mult':0.10,'tou.mult':0.05,'lib.mult':0.10});
		public static const LizanMarrow:PerkType = mk("Lizan Marrow", "Lizan Marrow",
				"Regenerates 0.5% of HP per round in combat and 1% of HP per hour. Additionaly your limit for innate self-regeneration rate increased.",
				"You've chosen the 'Lizan Marrow' perk. Constant regenerating your body caused permanently change to your body marrow.");
		public static const LizanMarrowEvolved:PerkType = mk("Lizan Marrow (Evolved)", "Lizan Marrow (Evolved)",
				"Regenerates 1% of HP per round in combat and 2% of HP per hour. Additionaly your limit for innate self-regeneration rate increased.",
				"You've chosen the 'Lizan Marrow (Evolved)' perk. Constant use of your lizan marrow caused it to change.");
		public static const LizanMarrowFinalForm:PerkType = mk("Lizan Marrow (Final Form)", "Lizan Marrow (Final Form)",
				"Regenerates 1.5% of HP per round in combat and 3% of HP per hour. Additionaly your limit for innate self-regeneration rate increased. When below 25% of max HP regeneration provided by Lizan regeneration doubles. You can't loose by HP until reaching droping into negative health larger than 5% of max HP.",
				"You've chosen the 'Lizan Marrow (Final Form)' perk. Your lizan marrow undergone another change.");
		public static const ManticoreMetabolism:PerkType = mk("Manticore Metabolism", "Manticore Metabolism",
				"Allows you to gain a boost of speed for a few hours after an intake of cum and allow atack with many tail spikes at once.",
				"You've chosen the 'Manticore Metabolism' perk, allows you to gain a boost of speed after an intake of cum and allow atack with many tail spikes at once.");
		public static const ManticoreMetabolismEvolved:PerkType = mk("Manticore Metabolism (Evolved)", "Manticore Metabolism (Evolved)",
				"Increase by (10 * NG tier) boost of speed for a five hours longer after an intake of cum, venom recharge rate when using Manticore Feed special is 2x higher and increase max Hunger cap by 50 (if PC have Hunger bar active).",
				"You've chosen the 'Manticore Metabolism (Evolved)' perk, allows you to increase max boost of speed after an intake of cum and keeping it for 50% longer, venom recharge rate when using Manticore Feed special is 2x higher.");
		public static const MantislikeAgility:PerkType = mk("Mantis-like Agility", "Mantis-like Agility",
				"Your altered musculature allows to increase your natural agility and speed. If somehow you would have some type of natural armor or even thicker skin this increase could be even greater...",
				"You've chosen the 'Mantis-like Agility' perk, by becoming much more mantis-like your body musculature started to slowly adapt to existance of exoskeleton.");
		public static const MantislikeAgilityEvolved:PerkType = mk("Mantis-like Agility (Evolved)", "Mantis-like Agility (Evolved)",
				"Your evolved musculature providing you with even higher increase to agility and speed. If somehow you would have some type of natural armor or even thicker skin this increase would be even bigger.",
				"You've chosen the 'Mantis-like Agility (Evolved)' perk, by becoming much more mantis-like your body musculature started to slowly adapt to existance of exoskeleton.");
		public static const MantislikeAgilityFinalForm:PerkType = mk("Mantis-like Agility (Final Form)", "Mantis-like Agility (Final Form)",
				"Your musculature providing you with much higher increase to agility and speed than before. With some type of natural armor or even thicker skin this increase would be even larger. (+30% of max core Spe as phantom Spe)",
				"You've chosen the 'Mantis-like Agility (Final Form)' perk, your body musculature started fully adapt to existance of exoskeleton.");
		public static const MelkieLung:PerkType = mk("Melkie Lungs", "Melkie Lungs",
				"Increase damage reduction against spells by 5% and increase the power of compelling aria by 20%, Compelling Aria is kept at all time.",
				"You've chosen the 'Melkie Lungs' perk, gaining increased magic resistances and the power to sing regardless of being a Melkie.");
		public static const MelkieLungEvolved:PerkType = mk("Melkie Lungs (Evolved)", "Melkie Lungs (Evolved)",
				"Increase damage reduction against spells by 10% and increase the power of compelling aria by 30%. Compelling Aria now has an Intelligence scaling.",
				"You've chosen the 'Melkie Lungs (Evolved)' perk, gaining increased magic resistances and improving the power of your song based on your inteligence.");
		public static const MelkieLungFinalForm:PerkType = mk("Melkie Lungs (Final Form)", "Melkie Lungs (Final Form)",
				"Increase damage reduction against spells by 15% and increase the power of compelling aria by 40%. Compelling Aria intelligence scaling is doubled.",
				"You've chosen the 'Melkie Lungs (Final Form)' perk, gaining increased magic resistances and further improving the power of your song.");
		public static const MinotaurTesticles:PerkType = mk("Minotaur Testicles", "Minotaur Testicles",
				"Allow keep Cum Cannon special even if minotaur score is lower than 9. Additionaly your max Lust increase by 10.",
				"You've chosen the 'Minotaur Testicles' perk. Interaction between permanent body alteration from Bro Brew (maybe Bimbo Liquer too) and your minotaur nature allows you to keep minotaur racial special even if you stop been bull-like.");
		public static const MinotaurTesticlesEvolved:PerkType = mk("Minotaur Testicles (Evolved)", "Minotaur Testicles (Evolved)",
				"+5% to lust resistance, increase cum output by 200 mLs.",
				"You've chosen the 'Minotaur Testicles (Evolved)' perk. Granting more lust resistance, increase slight cum output.").withBuffs({'lib.mult':0.10});
		public static const MinotaurTesticlesFinalForm:PerkType = mk("Minotaur Testicles (Final Form)", "Minotaur Testicles (Final Form)",
				"+5 to max tou an +10 to max str/lib, increase cum production by ~100%, +90 to max lust and Cum Cannon cost rise to 200 lust but can be used more than once per fight.",
				"You've chosen the 'Minotaur Testicles (Final Form)' perk. Granting boost to max lust, increase cum output and allowing using Cum Cannon more than once per fight.").withBuffs({'str.mult':0.10,'tou.mult':0.05,'lib.mult':0.10});
		public static const NaturalPunchingBag:PerkType = mk("Natural punching bag", "Natural punching bag",
				"Increases the damage reduction from Bouncy body by 5% and increase your natural toughness.",
				"You've chosen the 'Natural punching bag' perk, by becoming much more goblin-like your body fat tissue started to slowly adapt to their lifestyle.").withBuffs({'tou.mult':0.05});
		public static const NaturalPunchingBagEvolved:PerkType = mk("Natural punching bag (Evolved)", "Natural punching bag (Evolved)",
				"Oncreases the damage reduction from Bouncy body by 10%, continue to increase your natural toughness and healing items are more effective.",
				"You've chosen the 'Natural punching bag (Evolved)' perk. Your changing fat tissue giving you a boost to goblin-related special and more effective healing from pills.").withBuffs({'tou.mult':0.10});
		public static const NaturalPunchingBagFinalForm:PerkType = mk("Natural punching bag (Final Form)", "Natural punching bag (Final Form)",
				"Increases the damage reduction from Bouncy body by 20%, continue to increase your natural toughness and healing/wrath/stat boosting items are more effective and allow to keep the effect of bouncy body as long as you are below 4 feet tall.",
				"You've chosen the 'Natural punching bag (Final Form)' perk. Your goblin fat tissue changes, boosting your goblin specials once again.").withBuffs({'tou.mult':0.20});
		public static const NukiNuts:PerkType = mk("Nuki Nuts", "Nuki Nuts",
				"Gain a natural armor bonus based on your ball size and prevent the loss of money strike.",
				"You've chosen the 'Nuki Nuts' perk, Gain a natural armor bonus based on your ball size and prevent the loss of money strike.").withBuffs({'lib.mult':0.05});
		public static const NukiNutsEvolved:PerkType = mk("Nuki Nuts, (Evolved)", "Nuki Nuts, (Evolved)",
				"Increase the Armor bonus granted by Nuki nuts and improve cum production. Cumming now has a small chance of generating gems.",
				"You've chosen the 'Nuki Nuts, (Evolved)' perk, Increase the Armor bonus granted by Nuki nuts and improve cum production. Cumming now has a small chance of generating gems.").withBuffs({'lib.mult':0.10});
		public static const NukiNutsFinalForm:PerkType = mk("Nuki Nuts, (Final Form)", "Nuki Nuts, (Final Form)",
				"Further Increase the Armor bonus granted by Nuki nuts and further improve cum production. Cumming now has a greater chance of generating gems. Double the damage of Money Strike.",
				"You've chosen the 'Nuki Nuts, (Final Form)' perk, Further Increase the Armor bonus granted by Nuki nuts and further improve cum production. Cumming now has a greater chance of generating gems. Double the damage of Money Strike.").withBuffs({'lib.mult':0.15});
		public static const ObsidianHeart:PerkType = mk("Obsidian Heart", "Obsidian Heart",
				"You can use both devil m. specials without need to be full devilkin race member (but each use of them will give a bit of corruption if it's below 60).",
				"You've chosen the 'Obsidian Heart' perk. Your heart due to been more devilish turned obsidian-like.");
		public static const ObsidianHeartEvolved:PerkType = mk("Obsidian Heart (Evolved)", "Obsidian Heart (Evolved)",
				"Increase Maleficium duration by 5 turns and boost to spell power from 100% to 125% of base value; Infernal Flare dealing ~25% more dmg.",
				"You've chosen the 'Obsidian Heart (Evolved)' perk. Your changing heart giving you boost to both devil special attacks.");
		public static const ObsidianHeartFinalForm:PerkType = mk("Obsidian Heart (Final Form)", "Obsidian Heart (Final Form)",
				"Increase Maleficium boost to spell power from 125% to 250% of base value and lower lust resistance decrease to 30%; Infernal Flare dealing ~40% more dmg and have +20% higher chance to Crit.",
				"You've chosen the 'Obsidian Heart (Final Form)' perk. Your devil heart changes boosted your devil special once again.").withBuffs({'str.mult':0.05,'tou.mult':0.05,'spe.mult':0.05 });
		public static const OniMusculature:PerkType = mk("Oni Musculature", "Oni Musculature",
				"Your altered musculature allows to increase your natural strength and tone. Oni Rampage and Drunker Power can be used at Half-Oni score.",
				"You've chosen the 'Oni Musculature' perk, by becoming much more oni-like your body musculature started to slowly adapt to oni lifestyle.").withBuffs({'str.mult':0.05});
		public static const OniMusculatureEvolved:PerkType = mk("Oni Musculature (Evolved)", "Oni Musculature (Evolved)",
				"Your altered musculature continue to increase your natural strength and tone gained from previous change. Oni Rampage and Drunker Power req. only 3+ pts in Oni score and dmg multi from Oni Rampage increased to 4x.",
				"You've chosen the 'Oni Musculature' perk. Your changing musculature giving you boost to oni-related specials.").withBuffs({'str.mult':0.10});
		public static const OniMusculatureFinalForm:PerkType = mk("Oni Musculature (Final Form)", "Oni Musculature (Final Form)",
				"Your altered musculature increased again your natural strength and tone limit. Dmg multi from Oni Rampage increased to 6x, it duration increased by 3 turns and cooldown decreased by 3 turns. Drunken Power boost increased to 6x.",
				"You've chosen the 'Oni Musculature (Final Form)' perk. Your oni musculature changes boosted your oni specials once again.").withBuffs({'str.mult':0.15});
		public static const OrcAdrenalGlands:PerkType = mk("Orc Adrenal Glands", "Orc Adrenal Glands",
				"Your Orc adrenal glands are increasing Ferocity limit by 1%, +5% of max core Str as phantom Str.",
				"You've chosen the 'Orc Adrenal Glands' perk, due to repeadly balancing on line between life and death your adrenal glands mutated.");
		public static const OrcAdrenalGlandsEvolved:PerkType = mk("Orc Adrenal Glands (Evolved)", "Orc Adrenal Glands (Evolved)",
				"Your Orc adrenal glands are increasing Ferocity limit by 2%, +10% of max core Str as phantom Str, increase your natural strength and tone.",
				"You've chosen the 'Orc Adrenal Glands (Evolved)' perk. Your adrenal glands changes boosted your orc innate abilities once again.").withBuffs({'str.mult':0.5});
		public static const OrcAdrenalGlandsFinalForm:PerkType = mk("Orc Adrenal Glands (Final Form)", "Orc Adrenal Glands (Final Form)",
				"Your Orc adrenal glands are giving you +15% of max core Str as phantom Str, increase your natural strength, boost natural wrath generation rate, allow to use Ferocity even when been no longer an orc.",
				"You've chosen the 'Orc Adrenal Glands (Final Form)' perk, repeadly balancing on line between life and death caused your adrenal glands mutate into final form.").withBuffs({'str.mult':0.5});
		public static const PigBoarFat:PerkType = mk("Pig/Boar Fat", "Pig/Boar Fat",
				"Your altered fat tissue allows to increase your natural resistance to damage, toughness and thickness. Increase max Hunger cap by 5 (if PC have Hunger bar active).",
				"You've chosen the 'Pig/Boar Fat' perk, by becoming much more pig-like your body fat tissue started to slowly adapt to pig lifestyle.").withBuffs({'tou.mult':0.05});
		public static const PigBoarFatEvolved:PerkType = mk("Pig/Boar Fat (Evolved)", "Pig/Boar Fat (Evolved)",
				"Your altered fat tissue continue to increase your natural resistance to damage, toughness and thickness gained from previous change. Body Slam req. lower thickness to be used. Increase max Hunger cap by 10 (if PC have Hunger bar active).",
				"You've chosen the 'Pig/Boar Fat (Evolved)' perk. Your changing fat tissue giving you a boost to pig-related special.").withBuffs({'tou.mult':0.10});
		public static const PigBoarFatFinalForm:PerkType = mk("Pig/Boar Fat (Final Form)", "Pig/Boar Fat (Final Form)",
				"Your altered fat tissue increased again your natural resistance to damage, toughness and thickness limit. Body Slam power increase twicefold and it not req. to be pig/boar to use it, also another lowering of min. thickness to use it. Increase max Hunger cap by 20 (if PC have Hunger bar active).",
				"You've chosen the 'Pig/Boar Fat (Final Form)' perk. Your pig fat tissue changes, boosting your pig specials once again.").withBuffs({'tou.mult':0.15});
		public static const SalamanderAdrenalGlands:PerkType = mk("Salamander Adrenal Glands", "Salamander Adrenal Glands",
				"Your Salamander adrenal glands are giving you slight boost to your natural stamina and libido.",
				"You've chosen the 'Salamander Adrenal Glands' perk, due to repeadly exposure to effects of lustzerk your adrenal glands mutated.").withBuffs({'tou.mult':0.05,'lib.mult':0.05});
		public static const SalamanderAdrenalGlandsEvolved:PerkType = mk("Salamander Adrenal Glands (Evolved)", "Salamander Adrenal Glands (Evolved)",
				"Your Salamander adrenal glands are giving you slight boost to your natural strength, stamina, speed and libido and extend lustzerker and berserker duration by 2 turns.",
				"You've chosen the 'Salamander Adrenal Glands (Evolved)' perk, repeadly use of lustzerk caused your adrenal glands mutate even more.").withBuffs({'str.mult':0.05,'tou.mult':0.05,'spe.mult':0.05,'lib.mult':0.05});
		public static const SalamanderAdrenalGlandsFinalForm:PerkType = mk("Salamander Adrenal Glands (Final Form)", "Salamander Adrenal Glands (Final Form)",
				"Your Salamander adrenal glands are giving you slight boost to your natural strength, stamina, speed, libido; double bonus to attack, boost slight natural wrath generation rate, extend berserking/lustzerking by 8 turns and enable to start with one or both of them.",
				"You've chosen the 'Salamander Adrenal Glands (Final Form)' perk, repeadly use of lustzerk caused your adrenal glands mutate for the third time.").withBuffs({'str.mult':0.15,'tou.mult':0.05,'spe.mult':0.15,'lib.mult':0.05});
		public static const TwinHeart:PerkType = mk("Twin Heart", "Twin Heart",
				"+40% fatigue recovery and +5 to max tou/spe (scalable). +100% fatigue recovery, reduce Charge fatigue cost by 10% as well as its cooldown by 1 round so long as your body is tauric/drider. (Also raise all Taur race score by 1, by 2 as long pc is tauric/drider).",
				"You've chosen the 'Twin Heart' perk, +40% fatigue recovery and +5 to max tou/spe (scalable). +100% fatigue recovery, reduce Charge fatigue cost by 10% as well as its cooldown by 1 round so long as your body is tauric/drider. (Also raise all Taur race score by 1, by 2 as long pc is tauric/drider).").withBuffs({'tou.mult':0.05,'spe.mult':0.05});
		public static const TwinHeartEvolved:PerkType = mk("Twin Heart (Evolved)", "Twin Heart (Evolved)",
				"+40% fatigue recovery and +10 to max tou/spe (scalable). +100% fatigue recovery, reduce Charge fatigue cost by 10%, increase damage by 20%, its cooldown by 1 round so long as your body is tauric/drider. (Also raise all Taur race score by 1, by 2 as long pc is tauric/drider).",
				"You've chosen the 'Twin Heart (Evolved)' perk, +40% fatigue recovery and +10 to max tou/spe (scalable). +100% fatigue recovery, reduce Charge fatigue cost by 10%, increase damage by 20%, its cooldown by 1 round so long as your body is tauric/drider. (Also raise all Taur race score by 1, by 2 as long pc is tauric/drider).").withBuffs({'tou.mult':0.10,'spe.mult':0.10});
		public static const TwinHeartFinalForm:PerkType = mk("Twin Heart (Final Form)", "Twin Heart (Final Form)",
				"+40% fatigue recovery and +30 to max tou/spe (scalable). +100% fatigue recovery, reduce Charge fatigue cost by 10%, increase damage by 60%, its cooldown by 1 round so long as your body is tauric/drider. (Also raise all Taur race score by 1, by 2 as long pc is tauric/drider).",
				"You've chosen the 'Twin Heart (Final Form)' perk, +40% fatigue recovery and +30 to max tou/spe (scalable). +100% fatigue recovery, reduce Charge fatigue cost by 10%, increase damage by 60%, its cooldown by 1 round so long as your body is tauric/drider. (Also raise all Taur race score by 1, by 2 as long pc is tauric/drider).").withBuffs({'tou.mult':0.30,'spe.mult':0.30});
		public static const VampiricBloodsteam:PerkType = mk("Vampiric Bloodsteam", "Vampiric Bloodsteam",
				"Your bloodsteam started to adapt to presence of vampiric blood. Increases the maximum numbers of stacks of Vampire Thirst by 15.",
				"You've chosen the 'Vampiric Bloodsteam' perk. Your bloodsteam started to adapt to presence of vampiric blood. Increases the maximum numbers of stacks of Vampire Thirst by 15.").withBuffs({'lib.mult':0.05});
		public static const VampiricBloodsteamEvolved:PerkType = mk("Vampiric Bloodsteam (Evolved)", "Vampiric Bloodsteam (Evolved)",
				"Your bloodsteam halfway adapted to presence of vampiric blood. Increases the maximum numbers of stacks of Vampire Thirst by 30, Vampire Thirst stack now decays each 2 days.",
				"You've chosen the 'Vampiric Bloodsteam (Evolved)' perk. Your bloodsteam has better adapted to the presence of vampiric blood. Increases the maximum numbers of stacks of Vampire Thirst by 30, Vampire Thirst stack now decays each 2 days").withBuffs({'lib.mult':0.10});
		public static const VampiricBloodsteamFinalForm:PerkType = mk("Vampiric Bloodsteam (Final Form)", "Vampiric Bloodsteam (Final Form)",
				"Your bloodsteam fully adapted to presence of vampiric blood. Increases the maximum numbers of stacks of Vampire Thirst by 60 and increase their potency by 50%.",
				"You've chosen the 'Vampiric Bloodsteam (Final Form)' perk. Your bloodsteam fully adapted to presence of vampiric blood. Increases the maximum numbers of stacks of Vampire Thirst by 60 and increase their potency by 50%.").withBuffs({'lib.mult':0.15});
		public static const VenomGlands:PerkType = mk("Venom Glands", "Venom Glands",
				"Your body possesses rudimentary venom glands along with changes in teeth to been able use this venom when biting.",
				"You've chosen the 'Venom Glands' perk. Your body possesses rudimentary venom glands along with changes in teeth to been able use this venom when biting.").withBuffs({'tou.mult':0.05});
		public static const VenomGlandsEvolved:PerkType = mk("Venom Glands (Evolved)", "Venom Glands (Evolved)",
				"Your body possesses half developed venom glands increasing their capacity. +5% poison resistance.",
				"You've chosen the 'Venom Glands (Evolved)' perk. Your body possesses half developed venom glands increasing their capacity. +5% poison resistance.").withBuffs({'tou.mult':0.10});
		public static const VenomGlandsFinalForm:PerkType = mk("Venom Glands (Final Form)", "Venom Glands (Final Form)",
				"Your body possesses fully developed venom glands with large reservoir of venom and good recharge speed. (+10% to poison resistance)",
				"You've chosen the 'Venom Glands (Final Form)' perk. Your body possesses fully developed venom glands with large reservoir of venom and good recharge speed. also raises poison resistance by +10%").withBuffs({'tou.mult':0.15});
		public static const WhaleFat:PerkType = mk("Whale fat", "Whale fat",
				"Your whale fat increase your damage reduction against physical attacks and grants you resistance to cold permanantly. Increase max Hunger cap by 5 (if PC have Hunger bar active).",
				"You've chosen the 'Whale fat' perk, making your more resilient against physical attacks and gaining cold affinity permanantly.").withBuffs({'str.mult':0.05});
		public static const WhaleFatEvolved:PerkType = mk("Whale fat (Evolved)", "Whale fat (Evolved)",
				"Your whale fat further increase your damage reduction against physical attacks and the duration of juggle is increased by 1 round. Increase max Hunger cap by 10 (if PC have Hunger bar active).",
				"You've chosen the 'Whale fat' perk, making your more resilient against physical attacks and increasing the duration of Juggle by 1 round while playing.").withBuffs({'tou.mult':0.10});
		public static const WhaleFatFinalForm:PerkType = mk("Whale fat (Final Form)", "Whale fat (Final Form)",
				"Your whale fat further increase your damage reduction against physical attacks and the duration of juggle is increased by 1 additionnal round. Juggle can now be used a third time. Increase max Hunger cap by 20 (if PC have Hunger bar active).",
				"You've chosen the 'Whale fat' perk, making your more resilient against physical attacks and Juggle can now be used a third time while playing.").withBuffs({'tou.mult':0.20});
		public static const YetiFat:PerkType = mk("Yeti Fat", "Yeti Fat",
				"Gain damage reduction against attacks and increase the strength of the yeti ice breath by 50%.",
				"You've chosen the 'Yeti Fat' perk, gaining damage reduction against attacks and increase the strength of the yeti ice breath by 50%.");
		public static const YetiFatEvolved:PerkType = mk("Yeti Fat (Evolved)", "Yeti Fat (Evolved)",
				"Gain further damage reduction against attacks and increase the potency of Big Hand And Feet by 50%.",
				"You've chosen the 'Yeti Fat Evolved' perk, gaining further damage reduction against attacks and increase the potency of Big Hand And Feet by 50%.");
		public static const YetiFatFinalForm:PerkType = mk("Yeti Fat (Final Form)", "Yeti Fat (Final Form)",
				"Gain further damage reduction against attacks, further increase the potency of Big Hand And Feet by 50% and increase the duration of yeti breath stun by 1 round.",
				"You've chosen the 'Yeti Fat Final Form' perk, gaining further damage reduction against attacks, further increase the potency of Big Hand And Feet by 50% and increase the duration of yeti breath stun by 1 round while also reducing its cooldown by 3 rounds.");
		public static const ArachnidBookLung:PerkType = mk("Arachnid Book Lung", "Arachnid Book Lung",
				"Increase the web and poison capacity by 100%.",
				"You've chosen the 'Arachnid Book Lung' perk. Increase the web and poison capacity by 100%.").withBuffs({'int.mult':0.05});
		public static const ArachnidBookLungEvolved:PerkType = mk("Arachnid Book Lung (Evolved)", "Arachnid Book Lung (Evolved)",
				"Increase the web and poison capacity by an additional 100% and increase the effectiveness of all Web abilities by half.",
				"You've chosen the 'Arachnid Book Lung Evolved' perk. Increase the web and poison capacity by an additional 100% and increase the effectiveness of all Web abilities by half.").withBuffs({'int.mult':0.10});
		public static const ArachnidBookLungFinalForm:PerkType = mk("Arachnid Book Lung (Final Form)", "Arachnid Book Lung (Final Form)",
				"Increase the web and poison capacity by an additional 100%, increase the effectiveness of all Web abilities by half. Web abilities have a 50% chance to immobilize opponents for 2 rounds when used as the opponent struggles to get free. ",
				"You've chosen the 'Arachnid Book Lung Final Form' perk. Increase the web and poison capacity by an additional 100%, increase the effectiveness of all Web abilities by half. Web abilities have a 50% chance to immobilize opponents for 2 rounds when used as the opponent struggles to get free. ").withBuffs({'int.mult':0.15});
		public static const GazerEye:PerkType = mk("Gazer Eye", "Gazer Eye",
				"Keep true seeing at all times and empower gaze attacks.").withBuffs({'int.mult':0.05});
		public static const GazerEyeEvolved:PerkType = mk("Gazer Eye (Evolved)", "Gazer Eye (Evolved)",
				"Keep true seeing at all times, empower gaze attacks and empower your ability to cast many spells as a Gazer if available.").withBuffs({'lib.mult':0.05,'int.mult':0.10});
		public static const GazerEyeFinalForm:PerkType = mk("Gazer Eye (Final Form)", "Gazer Eye (Final Form)",
				"Keep true seeing at all times, empower gaze attacks, further empower your ability to cast many spells as a Gazer if available and increase spell critical hit chance by 10%.").withBuffs({'lib.mult':0.05,'int.mult':0.10});
		public static const GorgonsEyes:PerkType = mk("Gorgon's Eyes", "Gorgon's Eyes",
				"Can use Petrify with any type of eyes and improves your resistance to attacks that are related to sight.").withBuffs({'spe.mult':0.05,'sens':5});
		public static const GorgonsEyesEvolved:PerkType = mk("Gorgon's Eyes (Evolved)", "Gorgon's Eyes (Evolved)",
				"Another mutation of your eyes allows you to move a bit faster, increase the duration of Petrify and change negative effect of resistance to basilisks and similar effects into positive effect.").withBuffs({'spe.mult':0.10,'sens':10});
		public static const DisplacerMetabolism:PerkType = mk("Displacer Metabolism", "Displacer Metabolism",
				"Allows you to gain a boost of speed after an intake of milk and double the damage of displacer beast claws attacks.",
				"You've chosen the 'Displacer Metabolism' perk, allows you to gain a boost of speed after an intake of milk and double the damage of displacer beast claws attacks.");
		public static const DisplacerMetabolismEvolved:PerkType = mk("Displacer Metabolism (Evolved)", "Displacer Metabolism (Evolved)",
				"Increase by (10 * NG tier) boost of speed for a five hours longer after an intake of milk and increase max Hunger cap by 50 (if PC have Hunger bar active).",
				"You've chosen the 'Displacer Metabolism (Evolved)' perk, allows you to increase max boost of speed after an intake of milk and keeping it for 50% longer. Alse triple the damage of displacer beast claws attacks.");

		private static function mk(id:String, name:String, desc:String, longDesc:String = null, keepOnAscension:Boolean = false):PerkType
		{
			return new PerkType(id, name, desc, longDesc, keepOnAscension);
		}

		/**
		*Returns an array of arrays of mutation body parts in PerkType type.
		*Can be specified to specific parts with the first argument.
		*Must update here with an extra push to all mutations points.
		*This feeds the Perks/Mutations DB and Evangeline's Mutations information.
		*/
		public static function mutationsArray(spec:String = "", merge:Boolean = false):Array {

			var MutationsList:Array = []
			function mutationsHeart():void{
				MutationsList.push([BlackHeart, BlackHeartEvolved, BlackHeartFinalForm]);
				MutationsList.push([FrozenHeart, FrozenHeartEvolved, FrozenHeartFinalForm]);
				MutationsList.push([ObsidianHeart, ObsidianHeartEvolved, ObsidianHeartFinalForm]);
				MutationsList.push([TwinHeart, TwinHeartEvolved, TwinHeartFinalForm]);
				MutationsList.push([HeartOfTheStorm, HeartOfTheStormEvolved, HeartOfTheStormFinalForm]);
				MutationsList.push([DraconicHeart, DraconicHeartEvolved, DraconicHeartFinalForm]);
			}
			function mutationsMuscle():void{
				MutationsList.push([MantislikeAgility, MantislikeAgilityEvolved, MantislikeAgilityFinalForm]);
				MutationsList.push([OniMusculature, OniMusculatureEvolved, OniMusculatureFinalForm]);
			}
			function mutationsMouth():void{
				MutationsList.push([VenomGlands, VenomGlandsEvolved, VenomGlandsFinalForm]);
				MutationsList.push([HollowFangs, HollowFangsEvolved, HollowFangsFinalForm]);
			}
			function mutationsAdrGland():void{
				MutationsList.push([SalamanderAdrenalGlands, SalamanderAdrenalGlandsEvolved, SalamanderAdrenalGlandsFinalForm]);
				MutationsList.push([OrcAdrenalGlands, OrcAdrenalGlandsEvolved, OrcAdrenalGlandsFinalForm]);
			}
			function mutationsBloodStream():void{
				MutationsList.push([VampiricBloodsteam, VampiricBloodsteamEvolved, VampiricBloodsteamFinalForm]);
				MutationsList.push([HinezumiBurningBlood, HinezumiBurningBloodEvolved, HinezumiBurningBloodFinalForm]);
				MutationsList.push([FeyArcaneBloodstream, FeyArcaneBloodstreamEvolved, FeyArcaneBloodstreamFinalForm]);
			}
			function mutationsFaT():void{
				MutationsList.push([PigBoarFat, PigBoarFatEvolved, PigBoarFatFinalForm]);
				MutationsList.push([NaturalPunchingBag, NaturalPunchingBagEvolved, NaturalPunchingBagFinalForm]);
				MutationsList.push([WhaleFat, WhaleFatEvolved, WhaleFatFinalForm]);
				MutationsList.push([YetiFat, YetiFatEvolved, YetiFatFinalForm]);
			}
			function mutationsLungs():void{
				MutationsList.push([ArachnidBookLung, ArachnidBookLungEvolved, ArachnidBookLungFinalForm]);
				MutationsList.push([DraconicLungs, DraconicLungsEvolved, DraconicLungsFinalForm]);
				//MutationsList.push([CaveWyrmLungs, CaveWyrmLungsEvolved, CaveWyrmLungsFinalForm]);
				MutationsList.push([MelkieLung, MelkieLungEvolved, MelkieLungFinalForm]);
				MutationsList.push([DrakeLungs, DrakeLungsEvolved, DrakeLungsFinalForm]);
			}
			function mutationsMetabolism():void{
				MutationsList.push([ManticoreMetabolism, ManticoreMetabolismEvolved]);
				MutationsList.push([DisplacerMetabolism, DisplacerMetabolismEvolved]);
				//MutationsList.push([SlimeMetabolism, SlimeMetabolismEvolved]);
			}
			function mutationsOvaries():void{
				MutationsList.push([LactaBovinaOvaries, LactaBovinaOvariesEvolved, LactaBovinaOvariesFinalForm]);
				MutationsList.push([FloralOvaries, FloralOvariesEvolved, FloralOvariesFinalForm]);
			}
			function mutationsTesticles():void{
				MutationsList.push([MinotaurTesticles, MinotaurTesticlesEvolved, MinotaurTesticlesFinalForm]);
				MutationsList.push([EasterBunnyEggBag, EasterBunnyEggBagEvolved, EasterBunnyEggBagFinalForm]);
				MutationsList.push([NukiNuts, NukiNutsEvolved, NukiNutsFinalForm]);
			}
			function mutationsEyes():void{
				//MutationsList.push([GazerEye, GazerEyeEvolved, GazerEyeFinalForm]);
				MutationsList.push([GorgonsEyes, GorgonsEyesEvolved]);
			}
			function mutationsNervSys():void{
				MutationsList.push([ElvishPeripheralNervSys, ElvishPeripheralNervSysEvolved, ElvishPeripheralNervSysFinalForm]);
			}
			function mutationsBone():void{
				MutationsList.push([LizanMarrow, LizanMarrowEvolved, LizanMarrowFinalForm]);
				MutationsList.push([DraconicBones, DraconicBonesEvolved, DraconicBonesFinalForm]);
				MutationsList.push([HarpyHollowBones, HarpyHollowBonesEvolved, HarpyHollowBonesFinalForm]);
			}
			function mutationsThyroidGlands():void{
				MutationsList.push([KitsuneThyroidGland, KitsuneThyroidGlandEvolved, KitsuneThyroidGlandFinalForm]);
				//MutationsList.push([NekomataThyroidGland, NekomataThyroidGlandEvolved, NekomataThyroidGlandFinalForm]);
			}
			function mutationsParaThyroidGlands():void{
				MutationsList.push([KitsuneParathyroidGlands, KitsuneParathyroidGlandsEvolved, KitsuneParathyroidGlandsFinalForm]);
				MutationsList.push([HellcatParathyroidGlands, HellcatParathyroidGlandsEvolved, HellcatParathyroidGlandsFinalForm]);
			}

			switch(spec){
				case "Heart":
					mutationsHeart();
					break;
				case "Muscle":
					mutationsMuscle();
					break;
				case "Mouth":
					mutationsMouth();
					break;
				case "Adrenals":
					mutationsAdrGland();
					break;
				case "Bloodstream":
					mutationsBloodStream();
					break;
				case "FaT":
					mutationsFaT();
					break;
				case "Lungs":
					mutationsLungs();
					break;
				case "Metabolism":
					mutationsMetabolism();
					break;
				case "Ovaries":
					mutationsOvaries();
					break;
				case "Testicles":
					mutationsTesticles();
					break;
				case "Eyes":
					mutationsEyes();
					break;
				case "Nerv/Sys":
					mutationsNervSys();
					break;
				case "Bone":
					mutationsBone();
					break;
				case "Thyroid":
					mutationsThyroidGlands();
					break;
				case "PThyroid":
					mutationsParaThyroidGlands();
					break;
				default:
					mutationsHeart();
					mutationsMuscle();
					mutationsMouth();
					mutationsAdrGland();
					mutationsBloodStream();
					mutationsFaT();
					mutationsLungs();
					mutationsMetabolism();
					mutationsOvaries();
					mutationsTesticles();
					mutationsEyes();
					mutationsNervSys();
					mutationsBone();
					mutationsThyroidGlands();
					mutationsParaThyroidGlands();
			}

			if (merge){
				var finalrez:Array = [];
				for each(var mutatetype:Array in MutationsList){
					for each (var mutate:PerkType in mutatetype){
						finalrez.push(mutate);
					}
				}
				MutationsList = finalrez;
			}
			return MutationsList;
		}

		private static function initMutations():void{
			try {
				//Tier 1
				ArachnidBookLung.requireLungsMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.spiderScore() >= 5 || player.atlachNachaScore() >= 5;
				}, "Arachnid race");
				BlackHeart.requireHeartMutationSlot().requirePerk(PerkLib.DarkCharm).requireCor(100).requireCustomFunction(function (player:Player):Boolean {
					return player.demonScore() >= 5;
				}, "Demon race");
				DisplacerMetabolism.requireMetabolismMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.displacerbeastScore() >= 8;
				}, "Displacer beast");
				DraconicBones.requireBonesAndMarrowMutationSlot()
						.requireCustomFunction(function (player:Player):Boolean {
							return (player.arms.type == Arms.DRACONIC || player.arms.type == Arms.FROSTWYRM || player.arms.type == Arms.SEA_DRAGON);
						}, "Dragon race or its variants arms")
						.requireCustomFunction(function (player:Player):Boolean {
							return (LowerBody.hasDraconicLegs(player));
						}, "Dragon race or its variants legs")
						.requireCustomFunction(function (player:Player):Boolean {
							return (Tail.hasDraconicTail(player) || LowerBody.hasDraconicLegs(player) && LowerBody.hasTail(player));
						}, "Dragon race or its variants tail")
						.requireCustomFunction(function (player:Player):Boolean {
							return (player.dragonScore() >= 8 || player.jabberwockyScore() >= 10 || player.frostWyrmScore() >= 10 || player.leviathanScore() >= 20);
						}, "Dragon race or its variants");
				DraconicHeart.requireHeartMutationSlot()
						.requirePerk(DraconicBones)
						.requireAnyPerk(DraconicLungs, DrakeLungs)
						.requireCustomFunction(function (player:Player):Boolean {
							return (player.dragonScore() >= 8 || player.frostWyrmScore() >= 10 || player.leviathanScore() >= 20);
						}, "Dragon race or its variants");
				DraconicLungs.requireLungsMutationSlot()
						.requirePerks(PerkLib.DragonFireBreath, PerkLib.DragonIceBreath, PerkLib.DragonLightningBreath, PerkLib.DragonDarknessBreath)
						.requireCustomFunction(function (player:Player):Boolean {
					return (player.dragonScore() >= 8);
				}, "Dragon race");
				DrakeLungs.requireLungsMutationSlot()
						.requireAnyPerk(PerkLib.DragonFireBreath, PerkLib.DragonIceBreath, PerkLib.DragonLightningBreath, PerkLib.DragonDarknessBreath, PerkLib.DragonWaterBreath)
						.requireCustomFunction(function (player:Player):Boolean {
							return (player.frostWyrmScore() >= 10 || player.jabberwockyScore() >= 10 || player.vouivreScore() >= 11 || player.leviathanScore() >= 20);
						}, "Variants of the dragon race");
				EasterBunnyEggBag.requireBallsMutationSlot().requirePerk(PerkLib.EasterBunnyBalls).requireCustomFunction(function (player:Player):Boolean {
					return player.easterbunnyScore() >= 12;
				}, "Easter Bunny race and Easter bunny balls.");
				ElvishPeripheralNervSys.requirePerk(PerkLib.ElvenSense).requireCustomFunction(function (player:Player):Boolean {
					return player.elfScore() >= 4 || player.woodElfScore() >= 17;
				}, "Elf race");
				FeyArcaneBloodstream.requireBloodsteamMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.fairyScore() >= 20;
				}, "Fairy race");
				FloralOvaries.requireOvariesMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.alrauneScore() >= 13;
				}, "Alraune race");
				FrozenHeart.requireHeartMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.yukiOnnaScore() >= 14;
				}, "Yuki onna race");
				GorgonsEyes.requireEyesMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.eyes.type == 4;
				}, "Gorgon eyes")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.gorgonScore() >= 5;
						}, "Gorgon race");
				HinezumiBurningBlood.requireBloodsteamMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.arms.type == Arms.HINEZUMI;
				}, "Hinezumi arms")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.lowerBody == LowerBody.HINEZUMI;
						}, "Hinezumi legs")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.tailType == Tail.HINEZUMI;
						}, "Hinezumi tail")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.mouseScore() >= 12;
						}, "Mouse race");
				HarpyHollowBones.requireBonesAndMarrowMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.harpyScore() >= 6 || player.sirenScore() >= 10 || player.thunderbirdScore() >= 10 || player.phoenixScore() >= 10 || player.couatlScore() >= 11;
				}, "Harpy winged race");
				HeartOfTheStorm.requireHeartMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.raijuScore() >= 6 || player.thunderbirdScore() >= 10 || player.kamaitachiScore() >= 10 || player.couatlScore() >= 11;
				}, "Stormborn race");
				HollowFangs.requireMouthMutationSlot().requirePerk(VampiricBloodsteam)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.facePart.type == 34;//player.facePart.isAny(Face.VAMPIRE, Face.)
						}, "Vampire fangs")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.vampireScore() >= 4;//potem dodać mosquito race i ew. inne co mogą wypijać krew
						}, "Vampire race");
				KitsuneThyroidGland.requireThyroidGlandMutationSlot().requireAnyPerk(PerkLib.EnlightenedKitsune, PerkLib.CorruptedKitsune).requireCustomFunction(function (player:Player):Boolean {
					return player.kitsuneScore() >= 5;
				}, "Kitsune race");
				LactaBovinaOvaries.requireOvariesMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.hasVagina();
				}, "is Female")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.femininity >= 95;
						}, "95+ feminity")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.cowScore() >= 4;
						}, "Lacta Bovine race");
				LizanMarrow.requireBonesAndMarrowMutationSlot().requirePerk(PerkLib.LizanRegeneration).requireCustomFunction(function (player:Player):Boolean {
					return player.lizardScore() >= 4;
				}, "Lizan race");
				ManticoreMetabolism.requireMetabolismMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.manticoreScore() >= 5 && player.tailType == Tail.MANTICORE_PUSSYTAIL;
				}, "Manticore race and tail");
				MantislikeAgility.requireMusclesMutationSlot().requirePerk(PerkLib.TrachealSystem).requireCustomFunction(function (player:Player):Boolean {
					return player.mantisScore() >= 5;
				}, "Mantis race");
				MelkieLung.requireLungsMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.melkieScore() >= 12;
				}, "Melkie race");
				MinotaurTesticles.requireBallsMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.hasCock();
				}, "is Male")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.femininity <= 5;
						}, "5- feminity")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.minotaurScore() >= 4;
						}, "Minotaur race");
				NaturalPunchingBag.requireFatTissueMutationSlot().requirePerk(PerkLib.BouncyBody).requireCustomFunction(function (player:Player):Boolean {
					return player.isGoblinoid();
				}, "Goblin race");
				NukiNuts.requireBallsMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.raccoonScore() >= 8 && player.balls > 0 && player.ballSize > 5;
				}, "Tanuki race and large balls");
				ObsidianHeart.requireHeartMutationSlot().requireCor(100).requireCustomFunction(function (player:Player):Boolean {
					return player.devilkinScore() >= 10;
				}, "Devil race");
				OniMusculature.requireMusclesMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.tone >= 100;
				}, "100+ tone")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.oniScore() >= 4;
						}, "Oni race");
				OrcAdrenalGlands.requireAdrenalGlandsMutationSlot().requirePerk(PerkLib.Ferocity).requireCustomFunction(function (player:Player):Boolean {
					return player.orcScore() >= 4;
				}, "Orc race");
				PigBoarFat.requireFatTissueMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.thickness >= 100;
				}, "100+ thickness")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.pigScore() >= 4;
						}, "Pig/Boar race");
				SalamanderAdrenalGlands.requireAdrenalGlandsMutationSlot().requirePerk(PerkLib.Lustzerker).requireCustomFunction(function (player:Player):Boolean {
					return player.salamanderScore() >= 8 || player.phoenixScore() >= 10;
				}, "Salamander race");
				TwinHeart.requireHeartMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.centaurScore() >= 4 || player.unicornScore() >= 8 || player.sphinxScore() >= 15 || player.cancerScore() >= 8;
				}, "Tauric or Unicorn race");
				VampiricBloodsteam.requireBloodsteamMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.hasStatusEffect(StatusEffects.VampireThirst);
				}, "Vampire Thirst")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.vampireScore() >= 4;//potem dodać mosquito race i ew. inne co mogą wypijać krew
						}, "Vampire race");
				VenomGlands.requireMouthMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.facePart.isAny(Face.SNAKE_FANGS, Face.SPIDER_FANGS);
				}, "Spider or Snake fangs")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.spiderScore() >= 4 || player.nagaScore() >= 4 || player.gorgonScore() >= 4 || player.vouivreScore() >= 4 || player.couatlScore() >= 4 || player.hydraScore() >= 4;
						}, "Spider or any snake-like race");
				WhaleFat.requireFatTissueMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.orcaScore() >= 6 || player.leviathanScore() >= 20;
				}, "Orca race");
				YetiFat.requireFatTissueMutationSlot().requireCustomFunction(function (player:Player):Boolean {
					return player.yetiScore() >= 14;
				}, "Yeti race");
				//Tier 2
				ArachnidBookLungEvolved.requireLevel(6)
						.requirePerk(ArachnidBookLung)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.spiderScore() >= 9 || player.atlachNachaScore() >= 9;
						}, "Arachnid race");
				BlackHeartEvolved.requireLevel(6)
						.requirePerk(BlackHeart)
						.requireCor(100)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.demonScore() >= 9;
						}, "Demon race");
				DisplacerMetabolismEvolved.requireLevel(12)
						.requirePerk(DisplacerMetabolism).requireCustomFunction(function (player:Player):Boolean {
					return player.displacerbeastScore() >= 12;
				}, "Displacer beast");
				DraconicBonesEvolved.requireLevel(12).requirePerk(DraconicBones)
						.requireCustomFunction(function (player:Player):Boolean {
							return (player.dragonScore() >= 12 || player.frostWyrmScore() >= 12 || player.leviathanScore() >= 20);
						}, "Dragon race or its variants");
				DraconicHeartEvolved.requireLevel(12).requirePerk(DraconicHeart)
						.requireCustomFunction(function (player:Player):Boolean {
							return (player.dragonScore() >= 12 || player.frostWyrmScore() >= 12 || player.leviathanScore() >= 20);
						}, "Dragon race or its variants");
				DraconicLungsEvolved.requireLevel(12).requirePerk(DraconicLungs)
						.requireCustomFunction(function (player:Player):Boolean {
							return (player.dragonScore() >= 12);
						}, "Dragon race");
				DrakeLungsEvolved.requireLevel(12).requirePerk(DrakeLungs)
						.requireCustomFunction(function (player:Player):Boolean {
							return (player.frostWyrmScore() >= 12 || player.jabberwockyScore() >= 12 || player.vouivreScore() >= 12 || player.leviathanScore() >= 20);
						}, "Variants of the dragon race");
				EasterBunnyEggBagEvolved.requireLevel(12).requirePerk(EasterBunnyEggBag).requireCustomFunction(function (player:Player):Boolean {
					return player.easterbunnyScore() >= 12;
				}, "Easter Bunny race and Easter bunny balls.");
				ElvishPeripheralNervSysEvolved.requireLevel(12).requirePerk(ElvishPeripheralNervSys).requireCustomFunction(function (player:Player):Boolean {
					return player.elfScore() >= 8 || player.woodElfScore() >= 17;
				}, "Elf race");
				FeyArcaneBloodstreamEvolved.requireLevel(12).requirePerk(FeyArcaneBloodstream).requireCustomFunction(function (player:Player):Boolean {
					return player.fairyScore() >= 21;
				}, "Fairy race");
				FloralOvariesEvolved.requireLevel(6).requirePerk(FloralOvaries).requireCustomFunction(function (player:Player):Boolean {
					return player.alrauneScore() >= 13;
				}, "Alraune race");
				FrozenHeartEvolved.requireLevel(6)
						.requirePerk(FrozenHeart)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.yukiOnnaScore() >= 14;
						}, "Yuki onna race");
				GorgonsEyesEvolved.requireLevel(6)
						.requirePerk(GorgonsEyes)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.gorgonScore() >= 10;
						}, "Gorgon race");
				HarpyHollowBonesEvolved.requireLevel(6).requirePerk(HarpyHollowBones).requireCustomFunction(function (player:Player):Boolean {
					return player.harpyScore() >= 7 || player.sirenScore() >= 11 || player.thunderbirdScore() >= 11 || player.phoenixScore() >= 11 || player.couatlScore() >= 12;
				}, "Harpy winged race");
				HeartOfTheStormEvolved.requireLevel(6).requirePerk(HeartOfTheStorm).requireCustomFunction(function (player:Player):Boolean {
					return player.raijuScore() >= 9 || player.thunderbirdScore() >= 11 || player.kamaitachiScore() >= 11 || player.couatlScore() >= 12;
				}, "Stormborn race");
				HinezumiBurningBloodEvolved.requireLevel(6)
						.requirePerk(HinezumiBurningBlood)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.arms.type == Arms.HINEZUMI;
						}, "Hinezumi arms")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.lowerBody == LowerBody.HINEZUMI;
						}, "Hinezumi legs")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.tailType == Tail.HINEZUMI;
						}, "Hinezumi tail")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.mouseScore() >= 12;
						}, "Mouse race");
				HollowFangsEvolved.requireLevel(12).requirePerk(HollowFangs)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.vampireScore() >= 8;//potem dodać mosquito race i ew. inne co mogą wypijać krew
						}, "Vampire race");
				KitsuneThyroidGlandEvolved.requireLevel(12)
						.requirePerk(KitsuneThyroidGland)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.kitsuneScore() >= 8;
						}, "Kitsune race");
				LactaBovinaOvariesEvolved.requireLevel(18)
						.requirePerk(LactaBovinaOvaries)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.hasVagina();
						}, "is Female")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.femininity >= 95;
						}, "95+ feminity")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.cowScore() >= 8;
						}, "Lacta Bovine race");
				LizanMarrowEvolved.requireLevel(12).requirePerk(LizanMarrow).requireCustomFunction(function (player:Player):Boolean {
					return player.lizardScore() >= 8;
				}, "Lizan race");
				ManticoreMetabolismEvolved.requireLevel(6)
						.requirePerk(ManticoreMetabolism)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.manticoreScore() >= 10 && player.tailType == Tail.MANTICORE_PUSSYTAIL;
						}, "Manticore race and tail");
				MantislikeAgilityEvolved.requireLevel(12).requirePerk(MantislikeAgility).requireCustomFunction(function (player:Player):Boolean {
					return player.mantisScore() >= 10;
				}, "Mantis race");
				MelkieLungEvolved.requirePerk(MelkieLung).requireCustomFunction(function (player:Player):Boolean {
					return player.melkieScore() >= 12;
				}, "Melkie race");
				MinotaurTesticlesEvolved.requireLevel(18)
						.requirePerk(MinotaurTesticles)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.hasCock();
						}, "is Male")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.femininity <= 5;
						}, "5- feminity")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.minotaurScore() >= 8;
						}, "Minotaur race");
				NaturalPunchingBagEvolved.requireLevel(12).requirePerk(NaturalPunchingBag).requireCustomFunction(function (player:Player):Boolean {
					return player.isGoblinoid()
				}, "Goblin race");
				NukiNutsEvolved.requireLevel(12).requirePerk(NukiNuts).requireCustomFunction(function (player:Player):Boolean {
					return player.raccoonScore() >= 10 && player.balls > 0 && player.ballSize > 5;
				}, "Tanuki race and large balls");
				ObsidianHeartEvolved.requireLevel(6)
						.requirePerk(ObsidianHeart)
						.requireCor(100)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.devilkinScore() >= 12;
						}, "Devil race");
				OniMusculatureEvolved.requireLevel(12).requirePerk(OniMusculature).requireCustomFunction(function (player:Player):Boolean {
					return player.tone >= 100;
				}, "100+ tone")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.oniScore() >= 8;
						}, "Oni race");
				OrcAdrenalGlandsEvolved.requireLevel(12).requirePerk(OrcAdrenalGlands).requireCustomFunction(function (player:Player):Boolean {
					return player.orcScore() >= 8;
				}, "Orc race");
				PigBoarFatEvolved.requireLevel(12).requirePerk(PigBoarFat).requireCustomFunction(function (player:Player):Boolean {
					return player.thickness >= 100;
				}, "100+ thickness")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.pigScore() >= 8;
						}, "Pig/Boar race");
				SalamanderAdrenalGlandsEvolved.requireLevel(12).requirePerk(SalamanderAdrenalGlands).requireCustomFunction(function (player:Player):Boolean {
					return player.salamanderScore() >= 9 || player.phoenixScore() >= 11;
				}, "Salamander race");
				TwinHeartEvolved.requireLevel(6)
						.requirePerk(TwinHeart)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.centaurScore() >= 8 || player.unicornScore() >= 8 || player.sphinxScore() >= 16 || player.cancerScore() >= 8;
						}, "Tauric or Unicorn race");
				VampiricBloodsteamEvolved.requireLevel(12).requirePerk(VampiricBloodsteam).requireCustomFunction(function (player:Player):Boolean {
					return player.hasStatusEffect(StatusEffects.VampireThirst);
				}, "Vampire Thirst")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.vampireScore() >= 8;//potem dodać mosquito race i ew. inne co mogą wypijać krew
						}, "Vampire race");
				VenomGlandsEvolved.requireLevel(12).requirePerk(VenomGlands).requireCustomFunction(function (player:Player):Boolean {
					return player.spiderScore() >= 8 || player.atlachNachaScore() >= 17 || player.nagaScore() >= 6 || player.gorgonScore() >= 8 || player.vouivreScore() >= 8 || player.couatlScore() >= 8 || player.hydraScore() >= 8;
				}, "Spider or any snake-like race");
				WhaleFatEvolved.requireLevel(12).requirePerk(WhaleFat).requireCustomFunction(function (player:Player):Boolean {
					return player.orcaScore() >= 9 || player.leviathanScore() >= 20;
				}, "Orca race");
				YetiFatEvolved.requireLevel(12).requirePerk(YetiFat).requireCustomFunction(function (player:Player):Boolean {
					return player.yetiScore() >= 15;
				}, "Yeti race");
				//Tier 3
				ArachnidBookLungFinalForm.requireLevel(24)
						.requirePerk(ArachnidBookLungEvolved)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.spiderScore() >= 9 || player.atlachNachaScore() >= 9;
						}, "Arachnid race");
				BlackHeartFinalForm.requireLevel(24)
						.requirePerk(BlackHeartEvolved)
						.requireCor(100)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.demonScore() >= 14;
						}, "Demon race");
				DraconicBonesFinalForm.requireLevel(30).requirePerk(DraconicBonesEvolved)
						.requireCustomFunction(function (player:Player):Boolean {
							return (player.dragonScore() >= 16 || player.frostWyrmScore() >= 15 || player.leviathanScore() >= 20);
						}, "Dragon race or its variants");
				DraconicHeartFinalForm.requireLevel(30).requirePerk(DraconicHeartEvolved)
						.requireCustomFunction(function (player:Player):Boolean {
							return (player.dragonScore() >= 16 || player.jabberwockyScore() >= 16 || player.frostWyrmScore() >= 15 || player.leviathanScore() >= 20);
						}, "Dragon race or its variants");
				DraconicLungsFinalForm.requireLevel(30).requirePerk(DraconicLungsEvolved)
						.requireCustomFunction(function (player:Player):Boolean {
							return (player.dragonScore() >= 16);
						}, "Dragon race");
				DrakeLungsFinalForm.requireLevel(30).requirePerk(DrakeLungsEvolved)
						.requireCustomFunction(function (player:Player):Boolean {
							return (player.frostWyrmScore() >= 15 || player.jabberwockyScore() >= 15 || player.vouivreScore() >= 13 || player.leviathanScore() >= 20);
						}, "Variants of the dragon race");
				EasterBunnyEggBagFinalForm.requireLevel(30).requirePerk(EasterBunnyEggBagEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.easterbunnyScore() >= 12;
				}, "Easter Bunny race and Easter bunny balls.");
				ElvishPeripheralNervSysFinalForm.requireLevel(30).requirePerk(ElvishPeripheralNervSysEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.elfScore() >= 12 || player.woodElfScore() >= 17;
				}, "Elf race");
				FeyArcaneBloodstreamFinalForm.requireLevel(24).requirePerk(FeyArcaneBloodstreamEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.fairyScore() >= 22;
				}, "Fairy race");
				FloralOvariesFinalForm.requireLevel(24).requirePerk(FloralOvariesEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.alrauneScore() >= 13;
				}, "Alraune race");
				FrozenHeartFinalForm.requireLevel(24)
						.requirePerk(FrozenHeartEvolved)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.yukiOnnaScore() >= 14;
						}, "Yuki onna race");
				HollowFangsFinalForm.requireLevel(30).requirePerk(HollowFangsEvolved)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.vampireScore() >= 12;//potem dodać mosquito race i ew. inne co mogą wypijać krew
						}, "Vampire race");
				HarpyHollowBonesFinalForm.requireLevel(18).requirePerk(HarpyHollowBonesEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.harpyScore() >= 8 || player.sirenScore() >= 12 || player.thunderbirdScore() >= 12 || player.phoenixScore() >= 12 || player.couatlScore() >= 13;
				}, "Harpy winged race");
				HeartOfTheStormFinalForm.requireLevel(18).requirePerk(HeartOfTheStormEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.raijuScore() >= 12 || player.thunderbirdScore() >= 12 || player.kamaitachiScore() >= 12 || player.couatlScore() >= 13;
				}, "Stormborn race");
				HinezumiBurningBloodFinalForm.requireLevel(18)
						.requirePerk(HinezumiBurningBloodEvolved)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.arms.type == Arms.HINEZUMI;
						}, "Hinezumi arms")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.lowerBody == LowerBody.HINEZUMI;
						}, "Hinezumi legs")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.tailType == Tail.HINEZUMI;
						}, "Hinezumi tail")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.mouseScore() >= 12;
						}, "Mouse race");
				KitsuneThyroidGlandFinalForm.requireLevel(30).requirePerk(KitsuneThyroidGlandEvolved)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.kitsuneScore() >= 12;
						}, "Kitsune race");
				LactaBovinaOvariesFinalForm.requireLevel(36)
						.requirePerk(LactaBovinaOvariesEvolved)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.hasVagina();
						}, "is Female")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.femininity >= 95;
						}, "95+ feminity")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.cowScore() >= 12;
						}, "Lacta Bovine race");
				LizanMarrowFinalForm.requireLevel(36).requirePerk(LizanMarrowEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.lizardScore() >= 12;
				}, "Lizan race");
				MelkieLungFinalForm.requirePerk(MelkieLungEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.melkieScore() >= 12;
				}, "Melkie race");
				MinotaurTesticlesFinalForm.requireLevel(36)
						.requirePerk(MinotaurTesticlesEvolved)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.hasCock();
						}, "is Male")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.femininity <= 5;
						}, "5- feminity")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.minotaurScore() >= 12;
						}, "Minotaur race");
				MantislikeAgilityFinalForm.requireLevel(30).requirePerk(MantislikeAgilityEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.mantisScore() >= 15;
				}, "Mantis race");
				NaturalPunchingBagFinalForm.requireLevel(30).requirePerk(NaturalPunchingBagEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.isGoblinoid()
				}, "Goblin race");
				NukiNutsFinalForm.requireLevel(30).requirePerk(NukiNutsEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.raccoonScore() >= 12 && player.balls > 0 && player.ballSize > 5;
				}, "Tanuki race and large balls");
				ObsidianHeartFinalForm.requireLevel(24)
						.requirePerk(ObsidianHeartEvolved)
						.requireCor(100)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.devilkinScore() >= 14;
						}, "Devil race");
				OniMusculatureFinalForm.requireLevel(30).requirePerk(OniMusculatureEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.tone >= 100;
				}, "100+ tone")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.oniScore() >= 12;
						}, "Oni race");
				OrcAdrenalGlandsFinalForm.requireLevel(30).requirePerk(OrcAdrenalGlandsEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.orcScore() >= 12;
				}, "Orc race");
				PigBoarFatFinalForm.requireLevel(30).requirePerk(PigBoarFatEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.thickness >= 100;
				}, "100+ thickness")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.pigScore() >= 12;
						}, "Pig/Boar race");
				SalamanderAdrenalGlandsFinalForm.requireLevel(30).requirePerk(SalamanderAdrenalGlandsEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.salamanderScore() >= 10 || player.phoenixScore() >= 13;
				}, "Salamander race");
				TwinHeartFinalForm.requireLevel(24)
						.requirePerk(TwinHeartEvolved)
						.requireCustomFunction(function (player:Player):Boolean {
							return player.centaurScore() >= 12 || player.unicornScore() >= 12 || player.sphinxScore() >= 17 || player.cancerScore() >= 12;
						}, "Tauric or Unicorn race");
				VenomGlandsFinalForm.requireLevel(24).requirePerk(VenomGlandsEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.spiderScore() >= 12 || player.atlachNachaScore() >= 17 || player.nagaScore() >= 8 || player.gorgonScore() >= 12 || player.vouivreScore() >= 12 || player.couatlScore() >= 12 || player.hydraScore() >= 12;
				}, "Spider or any snake-like race");
				WhaleFatFinalForm.requireLevel(24).requirePerk(WhaleFatEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.orcaScore() >= 12 || player.leviathanScore() >= 20;
				}, "Orca race");
				YetiFatFinalForm.requireLevel(24).requirePerk(YetiFatEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.yetiScore() >= 16;
				}, "Yeti race");
				VampiricBloodsteamFinalForm.requireLevel(30).requirePerk(VampiricBloodsteamEvolved).requireCustomFunction(function (player:Player):Boolean {
					return player.hasStatusEffect(StatusEffects.VampireThirst);
				}, "Vampire Thirst")
						.requireCustomFunction(function (player:Player):Boolean {
							return player.vampireScore() >= 12;//potem dodać mosquito race i ew. inne co mogą wypijać krew
						}, "Vampire race");
				} catch (e:Error) {
					trace(e.getStackTrace());
				}
			}
		initMutations();
	}
}