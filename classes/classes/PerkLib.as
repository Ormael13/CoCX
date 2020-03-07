/**
 * Created by aimozg on 26.01.14.
 */
package classes
{
import classes.BodyParts.Face;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Perks.*;

public class PerkLib
	{

		// UNSORTED perks TODO these are mostly incorrect perks: tested but never created
		public static const Buttslut:PerkType = mk("Buttslut", "Buttslut",
				"");
		public static const Focused:PerkType = mk("Focused", "Focused",
				"");
/* Never used, removed because it used a numbered event. Could be re-implemented differently if some new monster actually uses it
		public static const LastStrike:PerkType = mk("Last Strike", "Last Strike",
				"");
		public static const AnalFertility:PerkType = mk("Anal Fertility", "Anal Fertility", //Not implemented
				"Unlocks the ability to get anally pregnant other than Satyrs.");
				
*/
		// Player creation perks
		public static const Fast:PerkType = mk("Fast", "Fast",
				"Gains speed 25% faster.", null, true);
		public static const Lusty:PerkType = mk("Lusty", "Lusty",
				"Gains lust 25% faster.", null, true);
		public static const Pervert:PerkType = mk("Pervert", "Pervert",
				"Gains corruption 25% faster. Reduces corruption requirement for high-corruption variant of scenes.", null, true);
		public static const Sensitive:PerkType = mk("Sensitive", "Sensitive",
				"Gains sensitivity 25% faster.", null, true);
		public static const Wise:PerkType = mk("Wise", "Wise",
				"Gains wisdom 25% faster.", null, true);
		public static const Smart:PerkType = mk("Smart", "Smart",
				"Gains intelligence 25% faster.", null, true);
		public static const Strong:PerkType = mk("Strong", "Strong",
				"Gains strength 25% faster.", null, true);
		public static const Tough:PerkType = mk("Tough", "Tough",
				"Gains toughness 25% faster.", null, true);
		// Female creation perks
		public static const BigClit:PerkType = mk("Big Clit", "Big Clit",
				"Allows your clit to grow larger more easily and faster.", null, true);
		public static const BigTits:PerkType = mk("Big Tits", "Big Tits",
				"Makes your tits grow larger more easily.", null, true);
		public static const Fertile:PerkType = mk("Fertile", "Fertile",
				"Makes you 15% more likely to become pregnant.", null, true);
		public static const WetPussy:PerkType = mk("Wet Pussy", "Wet Pussy",
				"Keeps your pussy wet and provides a bonus to capacity.", null, true);
		// Male creation perks
		public static const BigCock:PerkType = mk("Big Cock", "Big Cock",
				"Gains cock size 25% faster and with less limitations.", null, true);
		public static const MessyOrgasms:PerkType = mk("Messy Orgasms", "Messy Orgasms",
				"Produces 50% more cum volume.", null, true);
				
		// Ascension perks
		public static const AscensionCumHose:AscensionCumHosePerk = new AscensionCumHosePerk();
		public static const AscensionDesires:AscensionDesiresPerk = new AscensionDesiresPerk();
		public static const AscensionEndurance:AscensionEndurancePerk = new AscensionEndurancePerk();
		public static const AscensionHardiness:AscensionHardinessPerk = new AscensionHardinessPerk();
		public static const AscensionFertility:AscensionFertilityPerk = new AscensionFertilityPerk();
		public static const AscensionFortune:AscensionFortunePerk = new AscensionFortunePerk();
		public static const AscensionFury:AscensionFuryPerk = new AscensionFuryPerk();
		public static const AscensionInnerPower:AscensionInnerPowerPerk = new AscensionInnerPowerPerk();
		public static const AscensionMilkFaucet:AscensionMilkFaucetPerk = new AscensionMilkFaucetPerk();
		public static const AscensionMoralShifter:AscensionMoralShifterPerk = new AscensionMoralShifterPerk();
		public static const AscensionMysticality:AscensionMysticalityPerk = new AscensionMysticalityPerk();
		public static const AscensionSoulPurity:AscensionSoulPurityPerk = new AscensionSoulPurityPerk();
		public static const AscensionSpiritualEnlightenment:AscensionSpiritualEnlightenmentPerk = new AscensionSpiritualEnlightenmentPerk();
		public static const AscensionTolerance:AscensionTolerancePerk = new AscensionTolerancePerk();
		public static const AscensionTranshumanism:AscensionTranshumanismPerk = new AscensionTranshumanismPerk();
		public static const AscensionVirility:AscensionVirilityPerk = new AscensionVirilityPerk();
		public static const AscensionWisdom:AscensionWisdomPerk = new AscensionWisdomPerk();
		
		// Ascension Rare perks
		public static const AscensionAdditionalOrganMutation01:PerkType = mk("Ascension: Additional Organ Mutation (1st Stage)", "Ascension: Additional Organ Mutation (1st Stage)",
				"Numerous internal mutation changed your body to allow handle 2nd mutation of the same organ/internal body part.");
		public static const AscensionAdditionalOrganMutation02:PerkType = mk("Ascension: Additional Organ Mutation (2nd Stage)", "Ascension: Additional Organ Mutation (2nd Stage)",
				"Numerous internal mutation changed your body to allow handle 3rd mutation of the same organ/internal body part.");
		public static const AscensionAdditionalOrganMutation03:PerkType = mk("Ascension: Additional Organ Mutation (3rd Stage)", "Ascension: Additional Organ Mutation (3rd Stage)",
				"Numerous internal mutation changed your body to allow handle 4th mutation of the same organ/internal body part.");
		public static const AscensionBuildingPrestige01:PerkType = mk("Ascension: Building Prestige (1st Stage)", "Ascension: Building Prestige (1st Stage)",
				"Your understanding of prestige jobs from previous life allows to pick 2nd one at lvl 42+.");
		public static const AscensionBuildingPrestige02:PerkType = mk("Ascension: Building Prestige (2nd Stage)", "Ascension: Building Prestige (2nd Stage)",
				"Your understanding of prestige jobs from previous life allows to pick 3rd one at lvl 42+.");
		public static const AscensionBuildingPrestige03:PerkType = mk("Ascension: Building Prestige (3rd Stage)", "Ascension: Building Prestige (3rd Stage)",
				"Your understanding of prestige jobs from previous life allows to pick 4th one at lvl 42+.");
		public static const AscensionBuildingPrestige04:PerkType = mk("Ascension: Building Prestige (4th Stage)", "Ascension: Building Prestige (4th Stage)",
				"Your understanding of prestige jobs from previous life allows to pick 5th one at lvl 42+.");
		public static const AscensionBuildingPrestige05:PerkType = mk("Ascension: Building Prestige (5th Stage)", "Ascension: Building Prestige (5th Stage)",
				"Your understanding of prestige jobs from previous life allows to pick 6th one at lvl 42+.");
		public static const AscensionBuildingPrestige06:PerkType = mk("Ascension: Building Prestige (6th Stage)", "Ascension: Building Prestige (6th Stage)",
				"Your understanding of prestige jobs from previous life allows to pick 7th one at lvl 42+.");
		public static const AscensionCruelChimerasThesis:PerkType = mk("Ascension: Cruel Chimera's Thesis", "Ascension: Cruel Chimera's Thesis",
				"Allows you to reduce by another one point needed to accumulate mutations into non-human species to attain race specific enhancing effects.");
		public static const AscensionHerosHeritage:PerkType = mk("Ascension: Hero's Heritage", "Ascension: Hero's Heritage",
				"After reincarnation you ended in body of local hero descendant possesing much more firm body and resolve giving you a slight easier start of your quest in Mareth.");
		public static const AscensionHerosLineage:PerkType = mk("Ascension: Hero's Lineage", "Ascension: Hero's Lineage",
				"Body in which you ends up after next incarnation have much more thicker hero lineage than before giving you even better start before venturing into Mareth. You would probably need it.");
		public static const AscensionHybridTheory:PerkType = mk("Ascension: Hybrid Theory", "Ascension: Hybrid Theory",
				"Allows you to reduce by one needed to accumulate mutations into non-human species to attain race specific enhancing effects.");
		public static const AscensionNaturalMetamorph:PerkType = mk("Ascension: Natural Metamorph", "Ascension: Natural Metamorph",
				"When others needs to work hard on unlocking their metamorph potential you never had to do it. Whatever the reason for that is... truth be told you try not to think about it, affraid of what it might mean for you. You do not want to care about it as long as it's nothing harmfull for you in the long run.");
		public static const AscensionTranscendentalGeneticMemoryStage1:PerkType = mk("Ascension: Transcendental Genetic Memory (Stage 1)", "Ascension: Transcendental Genetic Memory (Stage 1)",
				"Allows to retain up to 15 choosen unlocked metamorph options.");
		public static const AscensionTranscendentalGeneticMemoryStage2:PerkType = mk("Ascension: Transcendental Genetic Memory (Stage 2)", "Ascension: Transcendental Genetic Memory (Stage 2)",
				"Allows to retain up to 30 choosen unlocked metamorph options.");
		public static const AscensionTranscendentalGeneticMemoryStage3:PerkType = mk("Ascension: Transcendental Genetic Memory (Stage 3)", "Ascension: Transcendental Genetic Memory (Stage 3)",
				"Allows to retain up to 45 choosen unlocked metamorph options.");
		public static const AscensionTranscendentalGeneticMemoryStage4:PerkType = mk("Ascension: Transcendental Genetic Memory (Stage 4)", "Ascension: Transcendental Genetic Memory (Stage 4)",
				"Allows to retain up to 60 choosen unlocked metamorph options.");
		public static const AscensionTranscendentalGeneticMemoryStage5:PerkType = mk("Ascension: Transcendental Genetic Memory (Stage 5)", "Ascension: Transcendental Genetic Memory (Stage 5)",
				"Allows to retain up to 75 choosen unlocked metamorph options.");
		public static const AscensionUnderdog:PerkType = mk("Ascension: Underdog", "Ascension: Underdog",
				"You're underdog. Gains twice more exp for beating up enemies above your current level with doubled limit after which increase to gained exp stops.");// Also allow to use 'accidentally' finding all forgotten or hidden legacies from times before the demon invasion.");
		public static const AscensionUnlockedPotential:PerkType = mk("Ascension: Unlocked Potential", "Ascension: Unlocked Potential",
				"Due to reincarnation experience your body becoming strong faster than in previous life (increased passive hp, lust, fatigue gains at lvl-up).");
		public static const AscensionUnlockedPotential2ndStage:PerkType = mk("Ascension: Unlocked Potential (2nd Stage)", "Ascension: Unlocked Potential (2nd Stage)",
				"Due to reincarnation experience your body becoming strong faster than in previous life (increased passive wrath, mana, soulforce gains at lvl-up).");
	//	public static const AscensionTranscendentalGeneticMemoryStage6:PerkType = mk("Ascension: Transcendental Genetic Memory (Stage 6)", "Ascension: Transcendental Genetic Memory (Stage 6)",
	//			"Allows to retain up to 90 choosen unlocked metamorph options.");
	//	public static const AscensionTranscendentalGeneticMemoryStage7:PerkType = mk("Ascension: Transcendental Genetic Memory (Stage 7)", "Ascension: Transcendental Genetic Memory (Stage 7)",
	//			"Allows to retain up to 105 choosen unlocked metamorph options.");
	//	public static const AscensionBuildingPrestige07:PerkType = mk("Ascension: Building Prestige (7th Stage)", "Ascension: Building Prestige (7th Stage)",
	//			"Your understanding of prestige jobs from previous life allows to pick 8th one at lvl 42+.");
	//	public static const Ascension:PerkType = mk("Ascension: Artifical-made Metamorph", "Ascension: Artifical-made Metamorph",
	//			".");
	//	public static const Ascension:PerkType = mk("Ascension: ", "Ascension: ",
	//			".");
	//	public static const Ascension:PerkType = mk("Ascension: ", "Ascension: ",
	//			".");
	//	public static const Ascension:PerkType = mk("Ascension: ", "Ascension: ",
	//			".");
	//	public static const Ascension:PerkType = mk("Ascension: ", "Ascension: ",
	//			".");

		// Bloodline perks
		public static const DragonsDescendant:PerkType = mk("Dragon's descendant", "Dragon's descendant",
				"You are a descendant of your ancestor, who was the child of a human and a Dragon. (+2 to dragon score)");
		public static const BloodlineDragon:PerkType = mk("Bloodline: Dragon", "Bloodline: Dragon",
				"Your Dragon bloodline appears strongly within you. (+2 to dragon score)", null, true);
		public static const ElfsDescendant:PerkType = mk("Elf's descendant", "Elf's descendant",
				"You are a descendant of your ancestor, who was the child of a human and an Elf. (+2 to elf score)");
		public static const BloodlineElf:PerkType = mk("Bloodline: Elf", "Bloodline: Elf",
				"Your Elf bloodline appears strongly within you. (+2 to elf score)", null, true);
		public static const GoblinsDescendant:PerkType = mk("Race's descendant", "Race's descendant",
				"You are a descendant of your ancestor, who was the child of a human and a Goblin. (+2 to goblin score)");
		public static const BloodlineGoblin:PerkType = mk("Bloodline: Goblin", "Bloodline: Goblin",
				"Your Goblin bloodline appears strongly within you. (+2 to goblin score)", null, true);
		public static const KitsunesDescendant:PerkType = mk("Kitsune's descendant", "Kitsune's descendant",
				"You are a descendant of your ancestor, who was the child of a human and a Kitsune. (+2 to kitsune score)");
		public static const BloodlineKitsune:PerkType = mk("Bloodline: Kitsune", "Bloodline: Kitsune",
				"Your Kitsune bloodline appears strongly within you. (+2 to kitsune score)", null, true);
		public static const RaijusDescendant:PerkType = mk("Raiju's descendant", "Raiju's descendant",
				"You are a descendant of your ancestor, who was the child of a human and a Raiju. (+2 to raiju score)");
		public static const BloodlineRaiju:PerkType = mk("Bloodline: Raiju", "Bloodline: Raiju",
				"Your Raiju bloodline appears strongly within you. (+2 to raiju score)", null, true);
		public static const MinotaursDescendant:PerkType = mk("Minotaur's descendant", "Minotaur's descendant",
				"You are a descendant of your ancestor, who was the child of a human and a Minotaur. (+2 to minotaur/cow score)");
		public static const BloodlineMinotaur:PerkType = mk("Bloodline: Minotaur", "Bloodline: Minotaur",
				"Your Minotaur bloodline appears strongly within you. (+2 to minotaur/cow score)", null, true);
		public static const OnisDescendant:PerkType = mk("Oni's descendant", "Oni's descendant",
				"You are a descendant of your ancestor, who was the child of a human and an Oni. (+2 to oni score)");
		public static const BloodlineOni:PerkType = mk("Bloodline: Oni", "Bloodline: Oni",
				"Your Oni bloodline appears strongly within you. (+2 to oni score)", null, true);
		public static const OrcsDescendant:PerkType = mk("Orc's descendant", "Orc's descendant",
				"You are a descendant of your ancestor, who was the child of a human and an Orc. (+2 to orc score)");
		public static const BloodlineOrc:PerkType = mk("Bloodline: Orc", "Bloodline: Orc",
				"Your Orc bloodline appears strongly within you. (+2 to orc score)", null, true);
	//	public static const sDescendant:PerkType = mk("Race's descendant", "Race's descendant",
	//			"You are a descendant of your ancestor, who was the child of a human and a (Race). (+2 to  score)");
	//	public static const Bloodline:PerkType = mk("Bloodline: Demon", "Bloodline: Demon",
	//			"Your Demonic bloodline appears strongly within you. (+2 to  score)", null, true);

		// History perks
		public static const HistoryAlchemist:PerkType = mk("History: Alchemist", "History: Alchemist",
				"Alchemical experience makes items more reactive to your body.");
		public static const PastLifeAlchemist:PerkType = mk("Past Life: Alchemist", "Past Life: Alchemist",
				"Alchemical experience makes items more reactive to your body.", null, true);
		public static const HistoryCultivator:PerkType = mk("History: Cultivator", "History: Cultivator",
				"Soulforce is easier to kept giving you 10% increase to it maximum amount.");
		public static const PastLifeCultivator:PerkType = mk("Past Life: Cultivator", "Past Life: Cultivator",
				"Soulforce is easier to kept giving you 10% increase to it maximum amount.", null, true);
		public static const HistoryFighter:PerkType = mk("History: Fighter", "History: Fighter",
				"A Past full of conflict increases physical melee damage dealt by 10% and acc by 10%.");
		public static const PastLifeFighter:PerkType = mk("Past Life: Fighter", "Past Life: Fighter",
				"A Past full of conflict increases physical melee damage dealt by 10% and acc by 10%.", null, true);
		public static const HistoryFortune:PerkType = mk("History: Fortune", "History: Fortune",
				"Your luck and skills at gathering currency allows you to get 15% more gems from victories.");
		public static const PastLifeFortune:PerkType = mk("Past Life: Fortune", "Past Life: Fortune",
				"Your luck and skills at gathering currency allows you to get 15% more gems from victories.", null, true);
		public static const HistoryHealer:PerkType = mk("History: Healer", "History: Healer",
				"Healing experience increases HP gains by 20%.");
		public static const PastLifeHealer:PerkType = mk("Past Life: Healer", "Past Life: Healer",
				"Healing experience increases HP gains by 20%.", null, true);
		public static const HistoryReligious:PerkType = mk("History: Religious", "History: Religious",
				"Replaces masturbate with meditate when corruption less than or equal to 66. Reduces minimum libido slightly.");
		public static const PastLifeReligious:PerkType = mk("Past Life: Religious", "Past Life: Religious",
				"Replaces masturbate with meditate when corruption less than or equal to 66. Reduces minimum libido slightly.", null, true);
		public static const HistoryScholar:PerkType = mk("History: Scholar", "History: Scholar",
				"Time spent focusing your mind makes spellcasting use 20% less mana.");
		public static const PastLifeScholar:PerkType = mk("Past Life: Scholar", "Past Life: Scholar",
				"Time spent focusing your mind makes spellcasting use 20% less mana.", null, true);
		public static const HistoryScout:PerkType = mk("History: Scout", "History: Scout",
				"A past full of archery training increases physical range damage dealt by 10% and acc by 20%.");
		public static const PastLifeScout:PerkType = mk("Past Life: Scout", "Past Life: Scout",
				"A past full of archery training increases physical range damage dealt by 10% and acc by 20%.", null, true);
		public static const HistorySlacker:PerkType = mk("History: Slacker", "History: Slacker",
				"Regenerate fatigue 20% faster.");
		public static const PastLifeSlacker:PerkType = mk("Past Life: Slacker", "Past Life: Slacker",
				"Regenerate fatigue 20% faster.", null, true);
		public static const HistorySlut:PerkType = mk("History: Slut", "History: Slut",
				"Sexual experience has made you more able to handle large insertions and more resistant to stretching.");
		public static const PastLifeSlut:PerkType = mk("Past Life: Slut", "Past Life: Slut",
				"Sexual experience has made you more able to handle large insertions and more resistant to stretching.", null, true);
		public static const HistorySmith:PerkType = mk("History: Smith", "History: Smith",
				"Knowledge of armor and fitting increases armor effectiveness by roughly 5% each (phys + mag).");
		public static const PastLifeSmith:PerkType = mk("Past Life: Smith", "Past Life: Smith",
				"Knowledge of armor and fitting increases armor effectiveness by roughly 5% each (phys + mag).", null, true);
		public static const HistoryTactician:PerkType = mk("History: Tactician", "History: Tactician",
				" (+10% to minions/pets damage).");
		public static const PastLifeTactician:PerkType = mk("Past Life: Tactician", "Past Life: Tactician",
				" (+10% to minions/pets damage).", null, true);
		public static const HistoryWhore:PerkType = mk("History: Whore", "History: Whore",
				"Seductive experience causes your tease attacks to be 15% more effective.");
		public static const PastLifeWhore:PerkType = mk("Past Life: Whore", "Past Life: Whore",
				"Seductive experience causes your tease attacks to be 15% more effective.", null, true);
		
		// Ordinary (levelup) perks
		public static const DevastatingCharge:PerkType = mk("Devastating charge", "Devastating charge",
				"When using the charge action you have a 20% chance to stun the opponent for a round. Charge is 50% more powerful.",
				"You choose the 'Devastating charge' perk, when using the charge action you have a 20% chance to stun the opponent for a round. Charge is 50% more powerful.");
		public static const FrozenHeart:PerkType = mk("Frozen heart", "Frozen heart",
				"Allow to retain the ability Ice barrage and hungering cold at all time and increase their damage by 10%.",
				"You choose the 'Frozen heart' perk, freezing your heart.");
		public static const FrozenHeartEvolved:PerkType = mk("Frozen heart (Evolved)", "Frozen heart (Evolved)",
				"Ice barrage and hungering cold abilities increase their damage by additional 20%, hungering cold last for 1 additional turn and recharge 1 turn faster.",
				"You choose the 'Frozen heart (Evolved)' perk, deepening your heart freezing.");
		public static const FrozenHeartFinalForm:PerkType = mk("Frozen heart (Final Form)", "Frozen heart (Final Form)",
				"Ice barrage and hungering cold abilities increase their damage by another 30%, hungering cold last for 3 additional turn and recharge 3 turn faster. Gain an extra modifier from your intelligence to health. (Increase original value by 50%).",
				"You choose the 'Frozen heart (Final Form)' perk, goying beyond just a very frozen heart.");
		public static const HexKnowledge:PerkType = mk("Hex Knowledge", "Hex Knowledge",
				"Allow to cast hex magic spells as long corruption is 80+, locks out access to white spells and deal 20% more dmg when using black or hex magic to attack pure enemies.",
				"You choose the 'Hex Knowledge' perk, gaining access to hex magic.");
		public static const JobLeader:PerkType = mk("Job: Leader", "Job: Leader",
				"You've trained in ways to better lead combat companions or command minions. (+5 to max int/wis, -5 to max lib - scalable)",
				"You choose 'Job: Leader' perk, training yourself to better lead your companions or command minions.");
		public static const Motivation:PerkType = mk("Motivation", "Motivation",
				"Decrease to 35% henchmans idle time during combat.",
				"You choose the 'Motivation' perk, slightly increasing motivation of allies to act in combat.");
		public static const MotivationEx:PerkType = mk("Motivation (Ex)", "Motivation (Ex)",
				"Decrease to 20% henchmans idle time during combat.",
				"You choose the 'Motivation (Ex)' perk, increasing motivation of allies to act in combat.");
		public static const MotivationSu:PerkType = mk("Motivation (Su)", "Motivation (Su)",
				"Decrease to 5% henchmans idle time during combat.",
				"You choose the 'Motivation (Su)' perk, further increasing motivation of allies to act in combat.");
		public static const ShootTheLoadAndHitTheRoad:PerkType = mk("Shoot the load and hit the road", "Shoot the load and hit the road",
				"Removes penalty to libido and boost slightly speed. (+5 to max spe - scalable).",
				"You choose the 'Shoot the load and hit the road' perk, removing penalty to libido and slight boosting speed.");
		public static const TemporalGolemsRestructuration:PerkType = mk("Temporal Golems Restructuration", "Temporal Golems Restructuration",
				"Allow to use option of send all temporal golems to attack in one turn. Adding option to make 5 temporal golems at once and shorten a bit time to make 1 temporal golem..",
				"You choose the 'Temporal Golems Restructuration' perk, adding option to make faster and more temporal golems at once and have option to send them all at once to attack.");
		public static const TwinHeart:PerkType = mk("Twin Heart", "Twin Heart",
				"+40% fatigue recovery and +5 to max tou/spe (scalable). +100% fatigue recovery, reduce Charge fatigue cost by 10% as well as its cooldown by 1 round so long as your body is tauric/drider. (Also raise all Taur race score by 1, by 2 as long pc is tauric/drider).",
				"You choose the 'Twin Heart' perk, +40% fatigue recovery and +5 to max tou/spe (scalable). +100% fatigue recovery, reduce Charge fatigue cost by 10% as well as its cooldown by 1 round so long as your body is tauric/drider. (Also raise all Taur race score by 1, by 2 as long pc is tauric/drider).");
		public static const TwinHeartEvolved:PerkType = mk("Twin Heart (Evolved)", "Twin Heart (Evolved)",
				"+40% fatigue recovery and +10 to max tou/spe (scalable). +100% fatigue recovery, reduce Charge fatigue cost by 10%, increase damage by 20%, its cooldown by 1 round so long as your body is tauric/drider. (Also raise all Taur race score by 1, by 2 as long pc is tauric/drider).",
				"You choose the 'Twin Heart (Evolved)' perk, +40% fatigue recovery and +10 to max tou/spe (scalable). +100% fatigue recovery, reduce Charge fatigue cost by 10%, increase damage by 20%, its cooldown by 1 round so long as your body is tauric/drider. (Also raise all Taur race score by 1, by 2 as long pc is tauric/drider).");
		public static const TwinHeartFinalForm:PerkType = mk("Twin Heart (Final Form)", "Twin Heart (Final Form)",
				"+40% fatigue recovery and +30 to max tou/spe (scalable). +100% fatigue recovery, reduce Charge fatigue cost by 10%, increase damage by 60%, its cooldown by 1 round so long as your body is tauric/drider. (Also raise all Taur race score by 1, by 2 as long pc is tauric/drider).",
				"You choose the 'Twin Heart (Final Form)' perk, +40% fatigue recovery and +30 to max tou/spe (scalable). +100% fatigue recovery, reduce Charge fatigue cost by 10%, increase damage by 60%, its cooldown by 1 round so long as your body is tauric/drider. (Also raise all Taur race score by 1, by 2 as long pc is tauric/drider).");
		public static const WispCaptain:PerkType = mk("Wisp Captain", "Wisp Captain",
				"Increase wisp commanding aura boosting other summoned pets/minions attack power effects by 30% (60% in total).",
				"You choose the 'Wisp Captain' perk, training your wisp to Wisp Captain.");
		public static const WispColonel:PerkType = mk("Wisp Colonel", "Wisp Colonel",
				"Increase wisp commanding aura boosting other summoned pets/minions attack power effects by 50% (150% in total).",
				"You choose the 'Wisp Colonel' perk, training your wisp to Wisp Colonel.");
		public static const WispLieutenant:PerkType = mk("Wisp Lieutenant", "Wisp Lieutenant",
				"Increase wisp commanding aura boosting other summoned pets/minions attack power effects by 20% (30% in total).",
				"You choose the 'Wisp Lieutenant' perk, training your wisp to Wisp Lieutenant.");
		public static const WispMajor:PerkType = mk("Wisp Major", "Wisp Major",
				"Increase wisp commanding aura boosting other summoned pets/minions attack power effects by 40% (100% in total).",
				"You choose the 'Wisp Major' perk, training your wisp to Wisp Major.");
		public static const PowerShot:PerkType = mk("Power Shot", "Power Shot",
				"Enable Power Shoot p. special. Add some of your strength (~40% of str scaling value) to bow damage.",
				"You choose the 'Power Shot' perk. Enable Power Shoot p. special. Add some of your strength (~40% of str scaling value) to bow damage.");
		public static const TooAngryToDie:PerkType = mk("Too Angry to Die", "Too Angry to Die",
				"+600 to max Wrath.",//stay alive when berserking at cost of super fast 20% max wrath drain per turn when below min HP or above max Lust (?drain decreased by some specific perks?)?
				"You choose the 'Too Angry to Die' perk, .");
		public static const AdvancedGolemancyTheory:PerkType = mk("Advanced Golemancy Theory", "Advanced Golemancy Theory",
				"Enable option to make steel golems and store 1 such golem.",
				"You choose the 'Advanced Golemancy Theory' perk, allowing to make steel golems.");
		public static const ElementsOfMarethBasic:PerkType = mk("Elements of Mareth: ", "Elements of Mareth: ",
				"You can now summon and command ice, lightning and darkness elementals. Also increase elementals command limit by 1.",
				"You choose 'Elements of Mareth: ' perk, your time spent in Mareth allowed you to get basic understanding of native elements that aren't classified as one of four traditional.");
		public static const NekomataThyroidGland:PerkType = mk("Nekomata Thyroid Gland", "Nekomata Thyroid Gland",
				"Nekomata Thyroid Gland .",//lower cooldowns for Illusion and Terror by three turns, increase speed of the recovery after using magic and slightly boost PC speed
				"You choose the 'Nekomata Thyroid Gland' perk. Some time after you become nekomata part of your body changed allowing to boost your nekomata powers.");
		public static const NekomataThyroidGlandEvolved:PerkType = mk("Nekomata Thyroid Gland (Evolved)", "Nekomata Thyroid Gland (Evolved)",
				"Nekomata Thyroid Gland (Evolved) .",//increase speed of the recovery after using magic, boost PC speed and wisdom. And make fox fire specials 50% stronger when having 9 tails (both fire and lust damage)
				"You choose the 'Nekomata Thyroid Gland (Evolved)' perk. Continued using of nekomata powers caused your thyroid gland to evolve.");
		public static const NekomataThyroidGlandFinalForm:PerkType = mk("Nekomata Thyroid Gland (Final Form)", "Nekomata Thyroid Gland (Final Form)",
				"Nekomata Thyroid Gland (Final Form) .",//grant bonus soulforce/mana regen depending on Star Sphere rank, increase max Star Sphere rank to 20. Increase speed debuff of Terror to 50, increase evasion boost from Illusion to 20%. Boost PC speed, wisdom and intelligence
				"You choose the 'Nekomata Thyroid Gland (Final Form)' perk. Your thyroid gland to evolved once again increasing efficiency of your nekomata powers.");
		public static const HellcatParathyroidGlands:PerkType = mk("Hellcat Parathyroid Glands", "Hellcat Parathyroid Glands",
				".",
				"You choose the 'Hellcat Parathyroid Glands' perk, .");
		public static const HellcatParathyroidGlandsEvolved:PerkType = mk("Hellcat Parathyroid Glands (Evolved)", "Hellcat Parathyroid Glands (Evolved)",
				".",
				"You choose the 'Hellcat Parathyroid Glands (Evolved)' perk, .");
		public static const HellcatParathyroidGlandsFinalForm:PerkType = mk("Hellcat Parathyroid Glands (Final Form)", "Hellcat Parathyroid Glands (Final Form)",
				".",
				"You choose the 'Hellcat Parathyroid Glands (Final Form)' perk, .");
		public static const CaveWyrmLungs:PerkType = mk("Cave Wyrm Lungs", "Cave Wyrm Lungs",
				"Your lung has became accustomed to the presence of acid in your biology improving the corrosiveness and volatility of your biochemical weapons.",
				"You choose the 'Cave Wyrm Lungs' perk, .");
		public static const CaveWyrmLungsEvolved:PerkType = mk("Cave Wyrm Lungs (Evolved)", "Cave Wyrm Lungs (Evolved)",
				".",
				"You choose the 'Cave Wyrm Lungs (Evolved)' perk, .");
		public static const CaveWyrmLungsFinalForm:PerkType = mk("Cave Wyrm Lungs (Final Form)", "Cave Wyrm Lungs (Final Form)",
				".",
				"You choose the 'Cave Wyrm Lungs (Final Form)' perk, .");
		/*public static const :PerkType = mk("", "",
				".",
				"You choose the '' perk, increasing amount of food you can eat. As side effect your vitality increased (+x to max Tou (scalable)).");
		public static const :PerkType = mk("", "",
				".",
				"You choose the '' perk, .");
		public static const :PerkType = mk("", "",
				".",
				"You choose the '' perk, .");
		public static const :PerkType = mk("", "",
				".",
				"You choose the '' perk, .");
		public static const :PerkType = mk("", "",
				".",
				"You choose the '' perk, .");*/
		public static const Acclimation:PerkType = mk("Acclimation", "Acclimation",
				"Reduces lust gain by 15%.",
				"You choose the 'Acclimation' perk, making your body 15% more resistant to lust, up to a maximum of 75%.");
		public static const Acolyte:PerkType = mk("Acolyte", "Acolyte",
				"You carry that long pole with a lit flme on it... you no longer sleep during mass, so you know how to further decrease your minimum libido and boost lust resistance. (-2 min libido/+5% to lust resistance)",
				"You choose the 'Acolyte' perk, lowering min libido by 2 and rise lust resistance by 5%.");
		public static const AdvancedAerialCombat:PerkType = mk("Advanced Aerial Combat", "Advanced Aerial Combat",
				"You are trained to fight while in flight. (extend flight duration by 2 turns and increase evasion when flying by 5%)",
				"You choose the 'Advanced Aerial Combat' perk, you trained to fight while in flight.");
		public static const AdvancedAerobatics:PerkType = mk("Advanced Aerobatics", "Advanced Aerobatics",
				"You understand the properties of wind resistance and aerodynamics nearly perfectly. (increase accuracy to melee/range attacks by 50% when flying)",
				"You choose the 'Advanced Aerobatics' perk. You understand the properties of wind resistance and aerodynamics nearly perfectly.");
		public static const AdvancedAllRounderEducation:PerkType = mk("Advanced All-Rounder Education", "Advanced All-Rounder Education",
				"Limit of advanced job you can learn is increased by 3.",
				"You choose the 'Advanced All-Rounder Education' perk, expanding amount of advanced jobs you can learn. (+3)");
		public static const AdvancedEndurance:PerkType = mk("Advanced Endurance", "Advanced Endurance",
				"Increases maximum fatigue by 200.",
				"You choose the 'Advanced Endurance' perk. Thanks to your advanced physical conditioning, your maximum fatigue has been increased by 200!");
		public static const AdvancedMagiculesTheory:PerkType = mk("Advanced Magicules Theory", "Advanced Magicules Theory",
				"[if(player.wis>=150)" +
						"Increases magical critical hit chance by up to 30% (Wisdom-based)." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Advanced Magicules Theory' perk, increasing magical critical hit chance by up to 30% (Wisdom-based).");	
		public static const AdvancedSelfControl:PerkType = mk("Advanced Self-Control", "Advanced Self-Control",
				"Increases maximum lust by 100.",
				"You choose the 'Advanced Self-Control' perk. Thanks to your advanced mental conditioning, your maximum lust has been increased by 100!");
		public static const AdvancedSpirituality:PerkType = mk("Advanced Spirituality", "Advanced Spirituality",
				"Increases maximum mana by 300.",
				"You choose the 'Advanced Spirituality' perk. Thanks to your advanced mystical conditioning, your maximum mana has been increased by 300!");	
		public static const AdvancedTranquilness:PerkType = mk("Advanced Tranquilness", "Advanced Tranquilness",
				"Increases maximum wrath by 100.",
				"You choose the 'Advanced Tranquilness' perk. Thanks to your advanced anger managment training, your maximum wrath has been increased by 100!");	
		public static const AerialCombat:PerkType = mk("Aerial Combat", "Aerial Combat",
				"You trained basics of fighting while flying (allow melee attacks with any weapon at cost of 30% accuracy penalty).",
				"You choose the 'Aerial Combat' perk, you trained basics of fighting while flying.");
		public static const Aerobatics:PerkType = mk("Aerobatics", "Aerobatics",
				"You understand the properties of wind resistance and aerodynamics and how to optimize your situation in the air. (increase accuracy to melee/range attacks by 20% when flying)",
				"You choose the 'Aerobatics' perk. You understand the properties of wind resistance and aerodynamics and how to optimize your situation in the air.");
		public static const Agility:PerkType = mk("Agility", "Agility",
				"Boosts armor points by a portion of your speed on light/medium armors.",
				"You choose the 'Agility' perk, increasing the effectiveness of Light/Medium armors by a portion of your speed.");
		public static const AlchemicalCartridge:PerkType = mk("Alchemical cartridge", "Alchemical cartridge",
				"Add your intelligence to gun damage as a modifier.",
				"You choose the 'Alchemical cartridge' perk, adding intelligence scaling to firearms damage.");
		public static const AllSeeing:PerkType = mk("All-Seeing", "All-Seeing",
				"You see everything... so you should have expected this description, and the 10% soul force gain.",
				"You choose the 'All-Seeing' perk, gaining +10% max Soulforce.");
		public static const Amateur:PerkType = mk("Amateur", "Amateur",
				"You've just started out on your sex life. You don't know much, but you can tease well. (+15% tease dmg)",
				"You choose the 'Amateur' perk, gaining +15% tease dmg.");
		public static const AmateurGunslinger:PerkType = mk("Amateur Gunslinger", "Amateur Gunslinger",
				"Gain an extra firearm attack per turn (2nd one).",
				"You choose the 'Amateur Gunslinger' perk, gaining an extra firearm attack per turn.");
		public static const AnatomyExpert:PerkType = mk("Anatomy expert", "Anatomy expert",
				"Your continued study of your opponents anatomy granted you insight to their weak point allowing you to strike precisely where it will hurt the most for increased critical chances and damage with thrown weapon. (+10% crit chance and +50% crit dmg)",
				"You choose the 'Anatomy expert' perk. Your continued study of your opponents anatomy granted you insight to their weak point allowing you to strike precisely where it will hurt the most for increased critical chances and damage with thrown weapon. (+10% crit chance and +50% crit dmg)");
		public static const Anger:PerkType = mk("Anger", "Anger",
				"For every 1% of missing HP you gain 1% bonus damage.",
				"You choose the 'Anger' perk, increasing damage based on your missing HP.");
		public static const Anvil:PerkType = mk("Anvil", "Anvil",
				"Now that you have an anvil, your work can be done even better, once again increasing your armor proficiency, how you used to work without all of this is the question... (+5% phys/mag resistance)",
				"You choose the 'Anvil' perk, increasing armor proficiency. (+5% phys/mag resistance)");
		public static const ApprenticeGolemMaker:PerkType = mk("Apprentice Golem Maker", "Apprentice Golem Maker",
				"Your proficiency in making golems allows to decrease by 10 mana cost of their creation, lower by 5% chance of core shattering and storing more golems.",
				"You choose 'Apprentice Golem Maker' perk, increasing your proficiency in making golems.");
		public static const ArcanePoolI:PerkType = mk("Arcane Pool I", "Arcane Pool I",
				"+1 extra mana per point of intelligence and wisdom.",
				"You choose the 'Arcane Pool I' perk, granting +1 extra maximum mana for each point of intelligence and wisdom.");
		public static const ArcanePoolII:PerkType = mk("Arcane Pool II", "Arcane Pool II",
				"+1 extra mana per point of intelligence and wisdom.",
				"You choose the 'Arcane Pool II' perk, granting +1 extra maximum mana for each point of intelligence and wisdom.");
		public static const ArcanePoolIII:PerkType = mk("Arcane Pool III", "Arcane Pool III",
				"+1 extra mana per point of intelligence and wisdom.",
				"You choose the 'Arcane Pool III' perk, granting +1 extra maximum mana for each point of intelligence and wisdom.");
		public static const ArcanePoolIV:PerkType = mk("Arcane Pool IV", "Arcane Pool IV",
				"+1 extra mana per point of intelligence and wisdom.",
				"You choose the 'Arcane Pool IV' perk, granting +1 extra maximum mana for each point of intelligence and wisdom.");
		public static const ArcanePoolV:PerkType = mk("Arcane Pool V", "Arcane Pool V",
				"+1 extra mana per point of intelligence and wisdom.",
				"You choose the 'Arcane Pool V' perk, granting +1 extra maximum mana for each point of intelligence and wisdom.");
		public static const ArcanePoolVI:PerkType = mk("Arcane Pool VI", "Arcane Pool VI",
				"+1 extra mana per point of intelligence and wisdom.",
				"You choose the 'Arcane Pool VI' perk, granting +1 extra maximum mana for each point of intelligence and wisdom.");
		public static const ArcaneRegenerationEpic:PerkType = mk("Arcane Regeneration (Epic)", "Arcane Regeneration (Epic)",
				"[if (player.inte>=100)" +
						"Increase by 150% base mana recovery and 30% max mana." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Arcane Regeneration (Epic)' perk, increasing mana recovery and mana pool.");
		public static const ArcaneRegenerationLegendary:PerkType = mk("Arcane Regeneration (Legendary)", "Arcane Regeneration (Legendary)",
				"[if (player.inte>=125)" +
						"Increase by 200% base mana recovery and 40% max mana." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Arcane Regeneration (Legendary)' perk, increasing mana recovery and mana pool.");
		public static const ArcaneRegenerationMajor:PerkType = mk("Arcane Regeneration (Major)", "Arcane Regeneration (Major)",
				"[if (player.inte>=75)" +
						"Increase by 100% base mana recovery and 20% max mana." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Arcane Regeneration (Major)' perk, increasing mana recovery and mana pool.");
		public static const ArcaneRegenerationMinor:PerkType = mk("Arcane Regeneration (Minor)", "Arcane Regeneration (Minor)",
				"[if (player.inte>=50)" +
						"Increase by 50% base mana recovery and 10% max mana." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Arcane Regeneration (Minor)' perk, increasing mana recovery and mana pool.");
		public static const ArchersStaminaI:PerkType = mk("Archer's Stamina I", "Archer's Stamina I",
				"+1 extra fatigue per point of speed.",
				"You choose the 'Archer's Stamina I' perk, granting +1 extra maximum fatigue for each point of speed.");
		public static const ArchersStaminaII:PerkType = mk("Archer's Stamina II", "Archer's Stamina II",
				"+1 extra fatigue per point of speed.",
				"You choose the 'Archer's Stamina II' perk, granting +1 extra maximum fatigue for each point of speed.");
		public static const ArchersStaminaIII:PerkType = mk("Archer's Stamina III", "Archer's Stamina III",
				"+1 extra fatigue per point of speed.",
				"You choose the 'Archer's Stamina III' perk, granting +1 extra maximum fatigue for each point of speed.");
		public static const ArchersStaminaIV:PerkType = mk("Archer's Stamina IV", "Archer's Stamina IV",
				"+1 extra fatigue per point of speed.",
				"You choose the 'Archer's Stamina IV' perk, granting +1 extra maximum fatigue for each point of speed.");
		public static const ArchersStaminaV:PerkType = mk("Archer's Stamina V", "Archer's Stamina V",
				"+1 extra fatigue per point of speed.",
				"You choose the 'Archer's Stamina V' perk, granting +1 extra maximum fatigue for each point of speed.");
		public static const ArchersStaminaVI:PerkType = mk("Archer's Stamina VI", "Archer's Stamina VI",
				"+1 extra fatigue per point of speed.",
				"You choose the 'Archer's Stamina VI' perk, granting +1 extra maximum fatigue for each point of speed.");
		public static const Archmage:PerkType = mk("Archmage", "Archmage",
				"[if (player.inte>=100)" +
						"Increases base spell strength by 30%, mana pool by 60 and lust bar by 15." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Archmage' perk, increasing base spell strength by 30%, base mana pool by 60 and lust bar by 15.");
		public static const ArcaneLash:PerkType = mk("Arcane Lash", "Arcane Lash",
				"Your whip act as a catalyst for your lust inducing spells as well as for magic weapon.",
				"You choose the 'Arcane Lash' perk, causing you to increase effects of lust inducing spells and weapon when using whip.");
		public static const Arm0r:PerkType = mk("Armor", "Armor",
				"You finally forged your best piece of work! With all of your accumulated knowledge and tools, you can make good armor better, and forge great armor, further increasing your proficiency all things armor! (+5% phys/mag resistance)",
				"You choose the 'Armor' perk, increasing armor proficiency. (+5% phys/mag resistance)");
		public static const ArmorMaster:PerkType = mk("Armor Master", "Armor Master",
				"Boosts armor points by a portion of your speed on heavy armors.",
				"You choose the 'Armor Master' perk, increasing the effectiveness of Heavy armors by a portion of your speed.");
		public static const ArouseTheAudience:PerkType = mk("Arouse the audience", "Arouse the audience",
				"Increase the damage of non periodic tease against groups by 50% and periodic by 20%.",
				"You choose the 'Arouse the audience' perk, increasing the damage of tease against groups.");
		public static const ArousingAura:PerkType = mk("Arousing Aura", "Arousing Aura",
				"Exude a lust-inducing aura (Req's corruption of 70 or more)",
				"You choose the 'Arousing Aura' perk, causing you to radiate an aura of lust when your corruption is over 70.");
		public static const AyoArmorProficiency:PerkType = mk("Ayo Armor Proficiency", "Ayo Armor Proficiency",
				"Wearing Ayo Armor's grants 10% damage reduction.",
				"You choose the 'Ayo Armor Proficiency' perk.  Due to your specialization in wearing ayo armor's you gain a little bit of damage reduction.");
		public static const Backlash:PerkType = mk("Backlash", "Backlash",
				"Raises parry chance with your fist by an extra 5% when wearing no shield. When you manage to block an attack with your fist do a single attack in response.",
				"You choose the 'Backlash' perk, raising parry chance with your fist when wearing no shield. When you manage to block an attack with your fist do a single counterattack.");
		public static const BasicAllRounderEducation:PerkType = mk("Basic All-Rounder Education", "Basic All-Rounder Education",
				"Limit of advanced job you can learn is increased by 3.",
				"You choose the 'Basic All-Rounder Education' perk, expanding amount of advanced jobs you can learn. (+3)");
		public static const BasicEndurance:PerkType = mk("Basic Endurance", "Basic Endurance",
				"Increases maximum fatigue by 30.",
				"You choose the 'Basic Endurance' perk. Thanks to your basic physical conditioning, your maximum fatigue has been increased by 30!");	
		public static const BasicSelfControl:PerkType = mk("Basic Self-Control", "Basic Self-Control",
				"Increases maximum lust by 15.",
				"You choose the 'Basic Self-Control' perk. Thanks to your basic mental conditioning, your maximum lust has been increased by 15!");
		public static const BasicSpirituality:PerkType = mk("Basic Spirituality", "Basic Spirituality",
				"Increases maximum mana by 45.",
				"You choose the 'Basic Spirituality' perk. Thanks to your basic mystical conditioning, your maximum mana has been increased by 45!");	
		public static const BasicTranquilness:PerkType = mk("Basic Tranquilness", "Basic Tranquilness",
				"Increases maximum wrath by 15.",
				"You choose the 'Basic Tranquilness' perk. Thanks to your basic anger managment training, your maximum wrath has been increased by 15!");	
		public static const BeginnerGolemMaker:PerkType = mk("Beginner Golem Maker", "Beginner Golem Maker",
				"Your proficiency in making golems allows to lower by 5% chance of core shattering and storing more golems/golem cores.",
				"You choose 'Beginner Golem Maker' perk, increasing your proficiency in making golems.");
		public static const Battleflash:PerkType = mk("Battleflash", "Battleflash",
				"Start every battle with Blink enabled, if you meet Black Magic requirements before it starts.",
				"You choose the 'Battleflash' perk. You start every battle with Blink effect, as long as your Lust is sufficient to cast it before battle.");
		public static const Battlemage:PerkType = mk("Battlemage", "Battlemage",
				"Start every battle with Might enabled, if you meet Black Magic requirements before it starts.",
				"You choose the 'Battlemage' perk. You start every battle with Might effect, as long as your Lust is sufficient to cast it before battle.");
		public static const Battleshield:PerkType = mk("Battleshield", "Battleshield",
				"Start every battle with Blink enabled, if you meet Black Magic requirements before it starts.",
				"You choose the 'Battleshield' perk. You start every battle with Mana Shield, as long as your Lust is sufficient to cast it before battle.");
		public static const Bellows:PerkType = mk("Bellows", "Bellows",
				"You've found an efficient way to keep the fire hot, allowing you to work faster. This increases your armor proficiency. (+5% phys/mag resistance)",
				"You choose the 'Bellows' perk, increasing armor proficiency. (+5% phys/mag resistance)");
		public static const Berzerker:PerkType = mk("Berzerker", "Berserker",
				"[if(player.str>=75)" +
						"Grants 'Berserk' ability." +
						"|" +
						"<b>You aren't strong enough to benefit from this anymore.</b>" +
						"]",
				"You choose the 'Berserker' perk, which unlocks the 'Berserk' magical ability.  Berserking increases attack and lust resistance but reduces physical defenses.");
		public static const BiggerGolemBag1:PerkType = mk("Bigger Golem Bag 1", "Bigger Golem Bag 1",
				"Your extra dimensional golem bag can store 2 more temporal (and 1 more pernament when becoming Master Golem Maker) golems.",
				"You choose 'Bigger Golem Bag 1' perk, increasing your golems bag.");
		public static const BiggerGolemBag2:PerkType = mk("Bigger Golem Bag 2", "Bigger Golem Bag 2",
				"Your extra dimensional golem bag can store 2 more temporal (and 1 more pernament when becoming Master Golem Maker) golems.",
				"You choose 'Bigger Golem Bag 2' perk, increasing your golems bag.");
		public static const BiggerGolemBag3:PerkType = mk("Bigger Golem Bag 3", "Bigger Golem Bag 3",
				"Your extra dimensional golem bag can store 2 more temporal (and 1 more pernament when becoming Master Golem Maker) golems.",
				"You choose 'Bigger Golem Bag 3' perk, increasing your golems bag.");
		public static const BiggerGolemBag4:PerkType = mk("Bigger Golem Bag 4", "Bigger Golem Bag 4",
				"Your extra dimensional golem bag can store 2 more temporal (and 1 more pernament when becoming Master Golem Maker) golems.",
				"You choose 'Bigger Golem Bag 4' perk, increasing your golems bag.");
		public static const BiggerGolemBag5:PerkType = mk("Bigger Golem Bag 5", "Bigger Golem Bag 5",
				"Your extra dimensional golem bag can store 2 more temporal (and 1 more pernament when becoming Master Golem Maker) golems.",
				"You choose 'Bigger Golem Bag 5' perk, increasing your golems bag.");
		public static const BiggerGolemBag6:PerkType = mk("Bigger Golem Bag 6", "Bigger Golem Bag 6",
				"Your extra dimensional golem bag can store 2 more temporal (and 1 more pernament when becoming Master Golem Maker) golems.",
				"You choose 'Bigger Golem Bag 6' perk, increasing your golems bag.");
		public static const BlackHeart:PerkType = mk("Black Heart", "Black Heart",
				"You intelligence to increase power of lust strike as well making fascinate slightly stronger.",
				"You choose the 'Black Heart' perk. Your heart due to repeadly exposition to corruption turned black.");
		public static const BlackHeartEvolved:PerkType = mk("Black Heart (Evolved)", "Black Heart (Evolved)",
				"Adds additional lust dmg to Lust strike depending on current chara Wis (additional wis/10 lust dmg), lower by 1 turn CD on Fascinate.",
				"You choose the 'Black Heart (Evolved)' perk. Your heart slowly evolve empowering your racial specials.");
		public static const BlackHeartFinalForm:PerkType = mk("Black Heart (Final Form)", "Black Heart (Final Form)",
				"Adds additional lust dmg to Lust strike depending on current chara Sens (additional sens/10 lust dmg), extend to 2 turns stun from Fascinate.",
				"You choose the 'Black Heart (Final Form)' perk. Another evolution of your heart that give another boost to your racial specials.");
		public static const BladeBarrier:PerkType = mk("Blade Barrier", "Blade Barrier",
				"Chance to parry is further increased by +15% when dual wielding.",
				"You choose the 'Blade Barrier' perk. Chance to parry is further increased by +15% when dual wielding.");
		public static const Blademaster:PerkType = mk("Blademaster", "Blademaster",
				"Gain +5% to critical strike chance when wielding weapon with blade (sword, dueling sword, axe) and not using a shield.",
				"You choose the 'Blademaster' perk.  Your chance of critical hit is increased by 5% as long as you're wielding weapon with blade like sword and not using a shield.");
		public static const BlessedByLadyGodiva:PerkType = mk("Blessed by Lady Godiva", "Blessed by Lady Godiva",
				"Oh now she blesses you? As it's painfully obvious you have the Goddess of chance's favor... you get even more money upon victory... yay... (15% more gems from victories)",
				"You choose the 'Blessed by Lady Godiva' perk, increasing gem gains from victories by 15%.");
		public static const BodyCultivator:PerkType = mk("Body Cultivator", "Body Cultivator",
				"Allow you to train your soul cultivator body to make it as tough as artifacts. (+1 to armor, +2 to unarmed attack, +25 max HP, +0.5% HP regen)",
				"You choose the 'Body Cultivator' perk, starting journey on the body cultivators path! (+1 to armor, +2 to unarmed attack, +25 max HP, +0.5% HP regen)");
		public static const BodyOfSteel:PerkType = mk("Body of Steel", "Body of Steel",
				"Your physical body has become a honed weapon, capable of striking most enemies down. With your body made of steel, your melee damage has increased again. (+10% melee phys dmg)",
				"You choose the 'Body of Steel' perk, gaining +10% melee phys dmg.");
		public static const BonesOfSteel:PerkType = mk("Bones of Steel", "Bones of Steel",
				"Your body has adapted to constant fighting, making your bones as hard as steel, increasing the damage dealt with melee attacks. (+10% melee phys dmg)",
				"You choose the 'Bones of Steel' perk, gaining +10% melee phys dmg.");
		public static const Brawler:PerkType = mk("Brawler", "Brawler",
				"Brawling experience allows you to make two unarmed attacks in a turn.",
				"You choose the 'Brawler' perk, allowing you to make two unarmed attacks in a turn!");
		public static const Brawn:PerkType = mk("Brawn", "Brawn",
				"You have increased your striking power. (+10% to phantom Str bonus, +5% to unarmed atk)",
				"You choose the 'Brawn' perk, increasing your striking power. (+10% to phantom Str bonus, +5% to unarmed atk)");
		public static const BrothelOwner:PerkType = mk("Brothel Owner", "Brothel Owner",
				"You are now above having sex by yourself, having created an industry and now teach new women and men to have sex. These allow you to refine your tricks, increasing your tease damage by 15%.",
				"You choose the 'Brothel Owner' perk, gaining +15% tease dmg.");
		public static const BrutalBlows:PerkType = mk("Brutal Blows", "Brutal Blows",
				"[if(player.str>=75)" +
						"Reduces enemy armor with each hit." +
						"|" +
						"<b>You aren't strong enough to benefit from this anymore.</b>" +
						"]",
				"You choose the 'Brutal Blows' perk, which reduces enemy armor with each hit.");
		public static const Brute:PerkType = mk("Brute", "Brute",
				"You have increased your striking strength. (add 20 pts of phantom Str (scalable))",
				"You choose the 'Brute' perk, increased your striking strength. (add 20 pts of phantom Str (scalable))");
		public static const Cardinal:PerkType = mk("Cardinal", "Cardinal",
				"You are on of the more important people of faith, and an aid to the pope themself. Your dedication to both the pope and your faith decreases the minimum libido you have and boost lust resistance. (-2 min libido/+5% to lust resistance)",
				"You choose the 'Cardinal' perk, lowering min libido by 2 and rise lust resistance by 5%.");
		public static const CarefulButRecklessAimAndShooting:PerkType = mk("Careful but Reckless Aim and Shooting", "Careful but Reckless Aim and Shooting",
				"Increase accuracy by 30% at cost of loosing 15 Tou.",
				"You choose the 'Careful but Reckless Aim and Shooting' perk, improving your accuracy by 30% at the cost of lowering by 15 your toughness.");
		public static const CatchTheBlade:PerkType = mk("Catch the blade", "Catch the blade",
				"[if(player.spe>=50)" +
						"Increases deflect chance by up to 15% while using only fists/fist weapons. (Speed-based)." +
						"|" +
						"<b>You are not fast enough to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Catch the blade' perk, giving you a chance to deflect blow with your fists. (Speed-based).");
		public static const CatlikeNimbleness:PerkType = mk("Cat-like Nimbleness", "Cat-like Nimbleness",
				"Your transformed joins allows you to move more swiftly and with greater nimbleness.",
				"You choose the 'Cat-like Nimbleness' perk. Your body joints due to repeadly usage of cat-like flexibility became more nimble.");
		public static const CatlikeNimblenessEvolved:PerkType = mk("Cat-like Nimbleness (Evolved)", "Cat-like Nimbleness (Evolved)",
				"Your nimble body allows you to move more swiftly and with greater nimbleness than before.",
				"You choose the 'Cat-like Nimbleness (Evolved)' perk. Continuous usage of cat-like flexibility caused it to undergo change.");
		public static const Channeling:PerkType = mk("Channeling", "Channeling",
				"[if (player.inte>=60)" +
						"Increases base spell strength by 20% and base mana pool by 30." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Channeling' perk, boosting the strength of your spellcasting and expanding your mana pool!");
		public static const ChargedCore:PerkType = mk("Charged Core", "Charged Core",
				"At the cost of using additional mana you can charge each temporal golem core allowing them to deal minor area of effect damages (it have small synergistic effect when more golems attacks at once).",
				"You choose 'Charged Core' perk, learning how to make golems attacks be slight stronger.");
		public static const CheatDeath:PerkType = mk("Cheat Death", "Cheat Death",
				"Increasing healing spells effect by another 100% when below 10% max HP (cumulative with Close to death perk effect for total boost of 150%).",
				"You choose the 'Cheat Death' perk, increasing healing spells effect when below 10% max HP.");
		public static const CheetahI:PerkType = mk("Cheetah I", "Cheetah I",
				"+1 extra HP per point of speed.",
				"You choose the 'Cheetah I' perk, granting +1 extra maximum HP for each point of speed.");
		public static const CheetahII:PerkType = mk("Cheetah II", "Cheetah II",
				"+1 extra HP per point of speed.",
				"You choose the 'Cheetah II' perk, granting +1 extra maximum HP for each point of speed.");
		public static const CheetahIII:PerkType = mk("Cheetah III", "Cheetah III",
				"+1 extra HP per point of speed.",
				"You choose the 'Cheetah III' perk, granting +1 extra maximum HP for each point of speed.");
		public static const CheetahIV:PerkType = mk("Cheetah IV", "Cheetah IV",
				"+1 extra HP per point of speed.",
				"You choose the 'Cheetah IV' perk, granting +1 extra maximum HP for each point of speed.");
		public static const CheetahV:PerkType = mk("Cheetah V", "Cheetah V",
				"+1 extra HP per point of speed.",
				"You choose the 'Cheetah V' perk, granting +1 extra maximum HP for each point of speed.");
		public static const CheetahVI:PerkType = mk("Cheetah VI", "Cheetah VI",
				"+1 extra HP per point of speed.",
				"You choose the 'Cheetah VI' perk, granting +1 extra maximum HP for each point of speed.");
		public static const ChimericalBodyAdvancedStage:PerkType = mk("Chimerical Body: Advanced Stage", "Chimerical Body: Advanced Stage",
				"Your metabolic adaptation reached level possesed by those sitting on the apex among average strong chimeras (negate up to 6 racial perk points negative effects).",
				"You choose the 'Chimerical Body: Advanced Stage' perk. Constant mutations rised your body adaptiveness to advanced level.");
		public static const ChimericalBodyBasicStage:PerkType = mk("Chimerical Body: Basic Stage", "Chimerical Body: Basic Stage",
				"Your metabolic adaptation reached level possesed by those sitting on the apex among weak chimeras (negate up to 4 racial perk points negative effects).",
				"You choose the 'Chimerical Body: Basic Stage' perk. Your body reach adaptation stage for most base type of chimera.");
		public static const ChimericalBodyEpicStage:PerkType = mk("Chimerical Body: Epic Stage", "Chimerical Body: Epic Stage",
				"Your metabolic adaptation reached level above that possesed by those sitting on the apex among strong chimeras (negate up to 12 racial perk points negative effects).",
				"You choose the 'Chimerical Body: Epic Stage' perk. Constant mutations rised your body adaptiveness to Epic level.");
		public static const ChimericalBodyInitialStage:PerkType = mk("Chimerical Body: Initial Stage", "Chimerical Body: Initial Stage",
				"Constant mutations resulted in your body developing the most basic resistance to increased stress on your metabolism due to that (negate up to 2 racial perk points negative effects).",
				"You choose the 'Chimerical Body: Initial Stage' perk. Constant mutations causing your body to slowly start adapt to increased metabolism needs.");
		public static const ChimericalBodyPeerlessStage:PerkType = mk("Chimerical Body: Peerless Stage", "Chimerical Body: Peerless Stage",
				"Your metabolic adaptation reached level possesed by those sitting on the apex among strong chimeras (negate up to 10 racial perk points negative effects).",
				"You choose the 'Chimerical Body: Peerless Stage' perk. Constant mutations rised your body adaptiveness to peerless level.");
		public static const ChimericalBodySuperiorStage:PerkType = mk("Chimerical Body: Superior Stage", "Chimerical Body: Superior Stage",
				"You feel naturaly adept at using every new appendage you gain as if they were yours from the birth (negate up to 8 racial perk points negative effects).",
				"You choose the 'Chimerical Body: Superior Stage' perk. Constant mutations rised your body adaptiveness to superior level.");
		public static const ChimericalBodySemiAdvancedStage:PerkType = mk("Chimerical Body: Semi-Advanced Stage", "Chimerical Body: Semi-Advanced Stage",
				"Your metabolic adaptation reached level possesed by most average strong chimeras (negate up to 5 racial perk points negative effects).",
				"You choose the 'Chimerical Body: Semi-Advanced Stage' perk. Constant mutations rised your body adaptiveness beyond basic level.");
		public static const ChimericalBodySemiBasicStage:PerkType = mk("Chimerical Body: Semi-Basic Stage", "Chimerical Body: Semi-Basic Stage",
				"Your metabolic adaptation reached level possesed by most weak chimeras (negate up to 3 racial perk points negative effects).",
				"You choose the 'Chimerical Body: Semi-Basic Stage' perk. Your body will reach apex stage of adaptation for most base type of chimera.");
		public static const ChimericalBodySemiEpicStage:PerkType = mk("Chimerical Body: Semi-Epic Stage", "Chimerical Body: Semi-Epic Stage",
				"Your metabolic adaptation reached level above that possesed by most strong chimeras (negate up to 11 racial perk points negative effects).",
				"You choose the 'Chimerical Body: Semi-Epic Stage' perk. Constant mutations rised your body adaptiveness beyond peerless level.");
		public static const ChimericalBodySemiPeerlessStage:PerkType = mk("Chimerical Body: Semi-Peerless Stage", "Chimerical Body: Semi-Peerless Stage",
				"Your metabolic adaptation reached level possesed by most strong chimeras (negate up to 9 racial perk points negative effects).",
				"You choose the 'Chimerical Body: Semi-Peerless Stage' perk. Constant mutations rised your body adaptiveness beyond superior level.");
		public static const ChimericalBodySemiSuperiorStage:PerkType = mk("Chimerical Body: Semi-Superior Stage", "Chimerical Body: Semi-Superior Stage",
				"You feel almost naturaly adept at using every new appendage as if they were yours from the birth (negate up to 7 racial perk points negative effects).",
				"You choose the 'Chimerical Body: Semi-Superior Stage' perk. Constant mutations rised your body adaptiveness beyond advanced level.");
		public static const ChimericalBodyUltimateStage:PerkType = mk("Chimerical Body: Ultimate Stage", "Chimerical Body: Ultimate Stage",
				".",
				"You choose the 'Chimerical Body: Ultimate Stage' perk.  Coś coś!");	
		public static const ChimericalBodyStage:PerkType = mk("Chimerical Body:  Stage", "Chimerical Body:  Stage",
				"prless lub completed stage.",
				"You choose the 'Chimerical Body:  Stage' perk.  Coś coś!");	
		public static const ChurchOfTheGun:PerkType = mk("Church of the gun", "Church of the gun",
				"Add your wisdom to gun damage as a modifier.",
				"You choose the 'Church of the gun' perk, adding wisdom scaling to firearms damage.");
		public static const ClawingFlurry:PerkType = mk("Clawing flurry", "Clawing flurry",
				"When attacking with your claws, add an additional attack striking up to 5 times.",
				"You choose the 'Clawing flurry' perk, gaining an additional attack with your claws!");
		public static const ClawTraining:PerkType = mk("Claw training", "Claw training",
				"Gain 1 extra natural attack with your claws.",
				"You choose the 'Claw training' perk, gain 1 extra natural attack with your claws!");
		public static const CloseToDeath:PerkType = mk("Close to death", "Close to death",
				"Increasing healing spells effect by 50% when below 25% max HP.",
				"You choose the 'Close to death' perk, increasing healing spells effect when below 25% max HP.");
		public static const ColdBlooded:PerkType = mk("Cold Blooded", "Cold Blooded",
				"Reduces minimum lust by up to 20, down to min of 20. Caps min lust at 80.",
				"You choose the 'Cold Blooded' perk.  Thanks to increased control over your desires, your minimum lust is reduced! (Won't reduce minimum lust below 20 though.)");
		public static const ColdAim:PerkType = mk("Cold Aim", "Cold Aim",
				"Careful but Reckless Aim and Shooting does not reduce your max Toughness.",
				"You choose the 'Cold Aim' perk, causing Careful but Reckless Aim and Shooting to not reduce your Toughness.");
		public static const ColderFury:PerkType = mk("Colder Fury", "Colder Fury",
				"Berserking does not reduce your magic resistance (increase atk boost).",
				"You choose the 'Colder Fury' perk, causing Berserking to not reduce your magic resistance (increase atk boost).");
		public static const ColderLust:PerkType = mk("Colder Lust", "Colder Lust",
				"Lustzerking does not reduce your magic resistance (increase atk boost).",
				"You choose the 'Colder Lust' perk, causing Lustzerking to not reduce your magic resistance (increase atk boost).");
		public static const ColdFury:PerkType = mk("Cold Fury", "Cold Fury",
				"Berserking does not reduce your armor (increase atk boost a bit).",
				"You choose the 'Cold Fury' perk, causing Berserking to not reduce your armor (increase atk boost a bit).");
		public static const ColdLust:PerkType = mk("Cold Lust", "Cold Lust",
				"Lustzerking does not reduce your lust resistance (increase atk boost a bit).",
				"You choose the 'Cold Lust' perk, causing Lustzerking to not reduce your lust resistance (increase atk boost a bit).");
		public static const Collector:PerkType = mk("Collector", "Collector",
				"This is getting out of hand! Why do you need so much money? Just, take it and leave... you monster. Take your added bonus upon victory and get out of my sight. (15% more gems from victories)",
				"You choose the 'Collector' perk, increasing gem gains from victories by 15%.");
		public static const Combo:PerkType = mk("Combo", "Combo",
				"Gain an extra attack with fist (weapon).",
				"You choose the 'Combo' perk, gaining an extra attack with fist (weapon).");
		public static const ComboMaster:PerkType = mk("Combo Master", "Combo Master",
				"Gain another extra attack with fist (weapon).",
				"You choose the 'Combo Master' perk, gaining another extra attack with fist (weapon).");
		public static const Convergence:PerkType = mk("Convergence", "Convergence",
				"Grey magic area of effect spells strike three times against single targets.",
				"You choose the 'Convergence' perk, gaining chance to attack single targets three times with grey aoe spells.");
		public static const CorruptedLibido:PerkType = mk("Corrupted Libido", "Corrupted Libido",
				"Reduces lust gain by 10%.",
				"You choose the 'Corrupted Libido' perk.  As a result of your body's corruption, you've become a bit harder to turn on. (Lust gain reduced by 10%!)");
		public static const Creationism:PerkType = mk("Creationism", "Creationism",
				"You have surpassed the pinnacle of alchemy, placing yourself on the level of gods. By creating the perfect transformative, you have guaranteed its potent effects +1 effect.",
				"You choose the 'Creationism' perk, number of possible effects of transformatives +1.");
		public static const CriticalPerformance:PerkType = mk("Critical performance", "Critical performance",
				"Allows your non periodic tease damage to critically hit based on your libido, maximum +20%.",
				"You choose the 'Critical performance' perk, allowing your non periodic tease damage to critically hit based on your libido.");
		public static const Cupid:PerkType = mk("Cupid", "Cupid",
				"You arrows are charged with heavy black magic inflicting lust on those pierced by them.",
				"You choose the 'Cupid' perk, allowing you to shoot arrows inflicting lust.");
		public static const CycloneStage1:PerkType = mk("Cyclone (Stage 1)", "Cyclone (Stage 1)",
				"Increasing crit chance for aoe like whirlwind by 10%.",
				"You choose the 'Cyclone (Stage 1)' perk, increasing crit chance for aoe specials like whirlwind.");
		public static const CycloneStage2:PerkType = mk("Cyclone (Stage 2)", "Cyclone (Stage 2)",
				"Increasing crit chance for aoe like whirlwind by 15%.",
				"You choose the 'Cyclone (Stage 2)' perk, increasing crit chance for aoe specials like whirlwind.");
		public static const CycloneStage3:PerkType = mk("Cyclone (Stage 3)", "Cyclone (Stage 3)",
				"Increasing crit chance for aoe like whirlwind by 20%.",
				"You choose the 'Cyclone (Stage 3)' perk, increasing crit chance for aoe specials like whirlwind.");
		public static const CycloneStage4:PerkType = mk("Cyclone (Stage 4)", "Cyclone (Stage 4)",
				"Increasing crit chance for aoe like whirlwind by 20% and damage multipier by 50% of base value.",
				"You choose the 'Cyclone (Stage 4)' perk, increasing crit chance and damage for aoe specials like whirlwind.");
		public static const CycloneStage5:PerkType = mk("Cyclone (Stage 5)", "Cyclone (Stage 5)",
				"Increasing crit chance for aoe like whirlwind by 25% and damage multipier by 150% of base value.",
				"You choose the 'Cyclone (Stage 5)' perk, increasing crit chance and damage for aoe specials like whirlwind.");
		public static const DancersVitalityI:PerkType = mk("Dancer's Vitality I", "Dancer's Vitality I",
				"+1.5 extra fatigue per point of speed.",
				"You choose the 'Dancer's Vitality I' perk, granting +1.5 extra maximum fatigue for each point of speed.");
		public static const DancersVitalityII:PerkType = mk("Dancer's Vitality II", "Dancer's Vitality II",
				"+1.5 extra fatigue per point of speed.",
				"You choose the 'Dancer's Vitality II' perk, granting +1.5 extra maximum fatigue for each point of speed.");
		public static const DancersVitalityIII:PerkType = mk("Dancer's Vitality III", "Dancer's Vitality III",
				"+1.5 extra fatigue per point of speed.",
				"You choose the 'Dancer's Vitality III' perk, granting +1.5 extra maximum fatigue for each point of speed.");
		public static const DancersVitalityIV:PerkType = mk("Dancer's Vitality IV", "Dancer's Vitality IV",
				"+1.5 extra fatigue per point of speed.",
				"You choose the 'Dancer's Vitality IV' perk, granting +1.5 extra maximum fatigue for each point of speed.");
		public static const DancersVitalityV:PerkType = mk("Dancer's Vitality V", "Dancer's Vitality V",
				"+1.5 extra fatigue per point of speed.",
				"You choose the 'Dancer's Vitality V' perk, granting +1.5 extra maximum fatigue for each point of speed.");
		public static const DancersVitalityVI:PerkType = mk("Dancer's Vitality VI", "Dancer's Vitality VI",
				"+1.5 extra fatigue per point of speed.",
				"You choose the 'Dancer's Vitality VI' perk, granting +1.5 extra maximum fatigue for each point of speed.");
		public static const Dantain:PerkType = mk("Dantian", "Dantian",
				"Increase max soulforce by 10% + 10% to 25% (per each attained cultivation stage) of base value.",
				"You choose the 'Dantian' perk.  As a result of many cultivation sessions you managed to find dantian in your body, which resulted in increased capacity to store soulforce.");
		public static const DaoistCultivator:PerkType = mk("Daoist Cultivator", "Daoist Cultivator",
				"Allow you to train your soul cultivator mind to unleash soulskills with their apex power. (+10% soulskill/m.soulskill power, -10% soulskills cost, +50% base soulforce recovery multiplier)",
				"You choose the 'Daoist Cultivator' perk, starting journey on the daoist cultivators path! (+10% soulskill/m.soulskill power, -10% soulskills cost, +50% base soulforce recovery multiplier)");
		public static const DaoistApprenticeStage:PerkType = mk("Daoist: Apprentice Stage", "Daoist: Apprentice Stage",
				"Your reached first stage of Daoist path. (+20% soulskill/m.soulskill power, +30 max SF at S.Apprentice, S.Personage, S.Warrior stages)",
				"You choose the 'Daoist: Apprentice Stage' perk, progressing on your Daoist path. (+20% soulskill/m.soulskill power, +30 max SF at S.Apprentice, S.Personage, S.Warrior stages)");
		public static const DaoistElderStage:PerkType = mk("Daoist: Elder Stage", "Daoist: Elder Stage",
				"Your reached third stage of Daoist path. (+40% soulskill/m.soulskill power, +50 max SF at S.Exalt, S.Overlord, S.Tyrant stages)",
				"You choose the 'Daoist: Elder Stage' perk, progressing on your Daoist path. (+40% soulskill/m.soulskill power, +50 max SF at S.Exalt, S.Overlord, S.Tyrant stages)");
		public static const DaoistOverlordStage:PerkType = mk("Daoist: Overlord Stage", "Daoist: Overlord Stage",
				"Your reached fourth stage of Daoist path. (+50% soulskill/m.soulskill power, +60 max SF S.King, S.Emperor, S.Ancestor stages)",
				"You choose the 'Daoist: Overlord Stage' perk, progressing on your Daoist path. (+50% soulskill/m.soulskill power, +60 max SF S.King, S.Emperor, S.Ancestor stages)");
		public static const DaoistTyrantStage:PerkType = mk("Daoist: Tyrant Stage", "Daoist: Tyrant Stage",
				"Your reached fifth stage of Daoist path.",
				"You choose the 'Daoist: Tyrant Stage' perk, progressing on your Daoist path. (+60% soulskill/m.soulskill power, +70 max SF at )");
		public static const DaoistWarriorStage:PerkType = mk("Daoist: Warrior Stage", "Daoist: Warrior Stage",
				"Your reached second stage of Daoist path. (+30% soulskill/m.soulskill power, +40 max SF at S.Sprite, S.Scholar, S.Elder stages)",
				"You choose the 'Daoist: Warrior Stage' perk, progressing on your Daoist path. (+30% soulskill/m.soulskill power, +40 max SF at S.Sprite, S.Scholar, S.Elder stages)");
		public static const DazzlingDisplay:PerkType = mk("Dazzling display", "Dazzling display",
				"Teasing can stun enemy for one round or increase lust damage for grapple-type teases.",
				"You choose 'Dazzling display' perk, allowing to increse tease dmg a little bit or even stun enemy for short moment.");
		public static const DeadlyAim:PerkType = mk("Deadly Aim", "Deadly Aim",
				"Arrows/Bolts ignore damage reductions piercing right through your opponent armor weak points (ignore enemy dmg red).",
				"You choose the 'Deadly Aim' perk, causing arrows/bolts to ignore the damage reductions of opponent.");
		public static const DeadlySneaker:PerkType = mk("Deadly sneaker", "Deadly sneaker",
				"Increase sneaky attack dmg by 200% base value (4x).",
				"You choose the 'Deadly sneaker' perk. Increase sneaky attack dmg by 200% base value (4x).");
		public static const DeadlyThrow:PerkType = mk("Deadly Throw", "Deadly Throw",
				"You learned how to use throwing weapon with better efficiency adding your speed to the damage.",
				"You choose the 'Deadly Throw' perk, adding your speed to throwing weapon damage.");
		public static const Dean:PerkType = mk("Dean", "Dean",
				"You control a section of the school as a member of the school board, answering only to the president. This increases max mana by 10%.",
				"You choose the 'Dean' perk, gaining +10% max Mana.");
		public static const DeathPlunge:PerkType = mk("Death plunge", "Death plunge",
				"When using Great Dive you may add your weapon damage as part of the attack damage as if using power attack at its current maximum value consuming no wrath in the process.",
				"You choose the 'Death plunge' perk. When using Great Dive you may add your weapon damage as part of the attack damage as if using power attack at its current maximum value consuming no wrath in the process.");
		public static const DecaAttackSmall:PerkType = mk("Deca Attack (Small)", "Deca Attack (Small)",
				"Allows you to perform ten melee attacks with small weapons per round.",
				"You choose the 'Deca Attack (Small)' perk. This allows you to make ten melee attacks with small weapons.");
		public static const DefenceStance:PerkType = mk("Defence Stance", "Defence Stance",
				"Defend move now reduce incoming damage a littl more and allow recovering fatigue/mana/soulforce.",
				"You choose 'Defence Stance' perk, training to master you defence pose.");
		public static const DeityJobMunchkin:PerkType = mk("Deity Job: Munchkin", "Deity Job: Munchkin",
				"You're Munchkin, an ultimate being that possess a god-like body and powers.",
				"You choose 'Deity Job: Munchkin' perk, becoming an ultimate being with a god-like body and powers.");
		public static const DemonicDesireI:PerkType = mk("Demonic Desire I", "Demonic Desire I",
				"+1 extra LP per point of libido.",
				"You choose the 'Demonic Desire I' perk, granting an extra maximum LP for each point of libido.");
		public static const DemonicDesireII:PerkType = mk("Demonic Desire II", "Demonic Desire II",
				"+1 extra LP per point of libido.",
				"You choose the 'Demonic Desire II' perk, granting an extra maximum LP for each point of libido.");
		public static const DemonicDesireIII:PerkType = mk("Demonic Desire III", "Demonic Desire III",
				"+1 extra LP per point of libido.",
				"You choose the 'Demonic Desire III' perk, granting an extra maximum LP for each point of libido.");
		public static const DemonicDesireIV:PerkType = mk("Demonic Desire IV", "Demonic Desire IV",
				"+1 extra LP per point of libido.",
				"You choose the 'Demonic Desire IV' perk, granting an extra maximum LP for each point of libido.");
		public static const DemonicDesireV:PerkType = mk("Demonic Desire V", "Demonic Desire V",
				"+1 extra LP per point of libido.",
				"You choose the 'Demonic Desire V' perk, granting an extra maximum LP for each point of libido.");
		public static const DemonicDesireVI:PerkType = mk("Demonic Desire VI", "Demonic Desire VI",
				"+1 extra LP per point of libido.",
				"You choose the 'Demonic Desire VI' perk, granting an extra maximum LP for each point of libido.");
		public static const Diehard:PerkType = mk("Diehard", "Diehard",
				"You can't loose by HP until reaching droping into negative health larger than 2% of max HP + 200(scalable). When below 0 HP would lose 1% of max HP per turn.",
				"You choose the 'Diehard' perk, allowing to contiue fight even when below 0 HP.");
		public static const Doctor:PerkType = mk("Doctor", "Doctor",
				"You got promoted to a doctor, allowing you to cure a wider variety of ailments. This knowledge allows you to heal yourself better, increasing health regen.",
				"You choose the 'Doctor' perk, increasing HP gains by 20%.");
		public static const DoubleAttack:PerkType = mk("Double Attack", "Double Attack",
				"Allows you to perform two melee attacks with non-large weapons per round.",
				"You choose the 'Double Attack' perk.  This allows you to make two melee attacks with non-large weapons.");
		public static const DoubleAttackLarge:PerkType = mk("Double Attack (Large)", "Double Attack (Large)",
				"Allows you to perform two melee attacks with large weapons per round.",
				"You choose the 'Double Attack (Large)' perk.  This allows you to make two melee attacks with large weapons.");
		public static const DoubleAttackSmall:PerkType = mk("Double Attack (Small)", "Double Attack (Small)",
				"Allows you to perform two melee attacks with small weapons per round.",
				"You choose the 'Double Attack (Small)' perk.  This allows you to make two melee attacks with small weapons.");
		public static const DoubleStrike:PerkType = mk("Double Strike", "Double Strike",
				"Allows you to perform two range attacks per round.",
				"You choose the 'Double Strike' perk.  This allows you to make two range attacks.");
		public static const DraconicLungs:PerkType = mk("Draconic Lungs", "Draconic Lungs",
				"Draconic Lungs giving you slight increased speed and allows to use breath attack more often.",
				"You choose the 'Draconic Lungs' perk. Your lungs due to repeadly usage of dragon breath attacks turned into draconic lungs.");
		public static const DraconicLungsEvolved:PerkType = mk("Draconic Lungs (Evolved)", "Draconic Lungs (Evolved)",
				"Draconic Lungs (Evolved) giving you slight increased speed/toughness and increased threefold power of the dragon breath attacks.",
				"You choose the 'Draconic Lungs (Evolved)' perk. Continuous exposition to draconic changes caused your lungs evolution into more complete form.");
		public static const DraconicLungsFinalForm:PerkType = mk("Draconic Lungs (Final Form)", "Draconic Lungs (Final Form)",
				"Draconic Lungs (Final Form) giving you slight increased str/tou/spe, a bit increase dragon breath attacks power and allows to use breath attack from combining all 4 basic breath types more often.",
				"You choose the 'Draconic Lungs (Final Form)' perk. Your draconic lungs evolved once again giving minor boost to stats and more often use of fused dragon breath attack.");
		public static const DualWield:PerkType = mk("Dual Wield", "Dual Wield",
				"Allows you to wield two normal sized melee weapons (excluding staffs).",
				"You choose the 'Dual Wield' perk, training skill of using two melee weapons excluding staffs.");
		public static const DualWieldFirearms:PerkType = mk("Dual Wield (Firearms)", "Dual Wield (Firearms)",
				"Allows you to wield two firearms (non 2H ones).",
				"You choose the 'Dual Wield (Firearms)' perk, training skill of using two firearms (non 2H ones).");
		public static const DualWieldLarge:PerkType = mk("Dual Wield (Large)", "Dual Wield (Large)",
				"Allows you to wield two large sized melee weapons.",
				"You choose the 'Dual Wield (Large)' perk, training skill of using two large melee weapons.");
		public static const DualWieldSmall:PerkType = mk("Dual Wield (Small)", "Dual Wield (Small)",
				"Allows you to wield two small sized melee weapons.",
				"You choose the 'Dual Wield (Small)' perk, training skill of using two small melee weapons.");
		public static const EagleEye:PerkType = mk("Eagle eye", "Eagle eye",
				"Increase traditional range weapons (like bows) base attack by another 50%.",
				"You choose the 'Eagle eye' perk, increasing traditional range weapons base attack.");
		public static const EclipsingShadow:PerkType = mk("Eclipsing Shadow", "Eclipsing Shadow",
				"Cumulative 20% damage increase for every subsequent darkness spell without interruption.",
				"You choose the 'Eclipsing Shadow' perk. Cumulative 20% damage increase for every subsequent darkness spell without interruption.");
		public static const ElementalArrows:PerkType = mk("Elemental Arrows", "Elemental Arrows",
				"Shoot elemental arrows adding your intelligence to your damage.",
				"You choose the 'Elemental Arrows' perk, allowing you to shoot elemental arrows.");
		public static const ElementalBondFlesh:PerkType = mk("Elemental Bond: Flesh", "Elemental Bond: Flesh",
				"You gains bonus to max HP depending on amount of summoned elementals and their ranks.",
				"You choose the 'Elemental Bond: Flesh' perk, allowing you to form bond with summoned elementals to share recived damage.");
		public static const ElementalBondUrges:PerkType = mk("Elemental Bond: Urges", "Elemental Bond: Urges",
				"You gains bonus to max Lust depending on amount of summoned elementals and their ranks.",
				"You choose the 'Elemental Bond: Urges' perk, allowing you to form bond with summoned elementals to share recived lust damage.");
		public static const ElementalConjurerDedication:PerkType = mk("Elemental Conjurer Dedication", "Elemental Conjurer Dedication",
				"Your elementals attack power is greatly enhanced at the cost of physical body fragility.",
				"You choose 'Elemental Conjurer Dedication' perk, dedicating yourself to pursue path of elemental conjuring at the cost of physical fragility.");
		public static const ElementalConjurerResolve:PerkType = mk("Elemental Conjurer Resolve", "Elemental Conjurer Resolve",
				"Your elementals attack power is enhanced at the cost of weakening physical body.",
				"You choose 'Elemental Conjurer Resolve' perk, showing your resolve to purse elementals enhancing at the cost of physical weakening.");
		public static const ElementalConjurerSacrifice:PerkType = mk("Elemental Conjurer Sacrifice", "Elemental Conjurer Sacrifice",
				"Your elementals attack power is enhanced beyond limits at the cost of similar weakening physical ones.",
				"You choose 'Elemental Conjurer Sacrifice' perk, showing your will to sacrifice everything in reaching perfect elementals enhancing.");
		public static const ElementalContractRank1:PerkType = mk("Elemental Contract Rank 1", "Elemental Contract Rank 1",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 1.",
				"You choose 'Elemental Contract Rank 1' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank2:PerkType = mk("Elemental Contract Rank 2", "Elemental Contract Rank 2",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 2.",
				"You choose 'Elemental Contract Rank 2' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank3:PerkType = mk("Elemental Contract Rank 3", "Elemental Contract Rank 3",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 3.",
				"You choose 'Elemental Contract Rank 3' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank4:PerkType = mk("Elemental Contract Rank 4", "Elemental Contract Rank 4",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 4.",
				"You choose 'Elemental Contract Rank 4' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank5:PerkType = mk("Elemental Contract Rank 5", "Elemental Contract Rank 5",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 5.",
				"You choose 'Elemental Contract Rank 5' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank6:PerkType = mk("Elemental Contract Rank 6", "Elemental Contract Rank 6",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 6.",
				"You choose 'Elemental Contract Rank 6' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank7:PerkType = mk("Elemental Contract Rank 7", "Elemental Contract Rank 7",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 7.",
				"You choose 'Elemental Contract Rank 7' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank8:PerkType = mk("Elemental Contract Rank 8", "Elemental Contract Rank 8",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 8.",
				"You choose 'Elemental Contract Rank 8' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank9:PerkType = mk("Elemental Contract Rank 9", "Elemental Contract Rank 9",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 9.",
				"You choose 'Elemental Contract Rank 9' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank10:PerkType = mk("Elemental Contract Rank 10", "Elemental Contract Rank 10",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to 9th Elder rank.",
				"You choose 'Elemental Contract Rank 10' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank11:PerkType = mk("Elemental Contract Rank 11", "Elemental Contract Rank 11",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to 8th Elder rank.",
				"You choose 'Elemental Contract Rank 11' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank12:PerkType = mk("Elemental Contract Rank 12", "Elemental Contract Rank 12",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to 7th Elder rank.",
				"You choose 'Elemental Contract Rank 12' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank13:PerkType = mk("Elemental Contract Rank 13", "Elemental Contract Rank 13",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to 6th Elder rank.",
				"You choose 'Elemental Contract Rank 13' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank14:PerkType = mk("Elemental Contract Rank 14", "Elemental Contract Rank 14",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to 5th Elder rank.",
				"You choose 'Elemental Contract Rank 14' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank15:PerkType = mk("Elemental Contract Rank 15", "Elemental Contract Rank 15",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to 4th Elder rank.",
				"You choose 'Elemental Contract Rank 15' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank16:PerkType = mk("Elemental Contract Rank 16", "Elemental Contract Rank 16",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to 3rd Elder rank.",
				"You choose 'Elemental Contract Rank 16' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank17:PerkType = mk("Elemental Contract Rank 17", "Elemental Contract Rank 17",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to 2nd Elder rank.",
				"You choose 'Elemental Contract Rank 17' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank18:PerkType = mk("Elemental Contract Rank 18", "Elemental Contract Rank 18",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to 1st Elder rank.",
				"You choose 'Elemental Contract Rank 18' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank19:PerkType = mk("Elemental Contract Rank 19", "Elemental Contract Rank 19",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to Grand Elder rank.",
				"You choose 'Elemental Contract Rank 19' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank20:PerkType = mk("Elemental Contract Rank 20", "Elemental Contract Rank 20",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 3. Allow to rank-up summoned elementals to (Low) Lord rank.",
				"You choose 'Elemental Contract Rank 20' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank21:PerkType = mk("Elemental Contract Rank 21", "Elemental Contract Rank 21",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 3. Allow to rank-up summoned elementals to (Mid) Lord rank.",
				"You choose 'Elemental Contract Rank 21' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank22:PerkType = mk("Elemental Contract Rank 22", "Elemental Contract Rank 22",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 3. Allow to rank-up summoned elementals to (Advanced) Lord rank.",
				"You choose 'Elemental Contract Rank 22' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank23:PerkType = mk("Elemental Contract Rank 23", "Elemental Contract Rank 23",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 3. Allow to rank-up summoned elementals to (Peak) Lord rank.",
				"You choose 'Elemental Contract Rank 23' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank24:PerkType = mk("Elemental Contract Rank 24", "Elemental Contract Rank 24",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 3. Allow to rank-up summoned elementals to (Low) Baron rank.",
				"You choose 'Elemental Contract Rank 24' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank25:PerkType = mk("Elemental Contract Rank 25", "Elemental Contract Rank 25",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 3. Allow to rank-up summoned elementals to (Mid) Baron rank.",
				"You choose 'Elemental Contract Rank 25' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank26:PerkType = mk("Elemental Contract Rank 26", "Elemental Contract Rank 26",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 3. Allow to rank-up summoned elementals to (Advanced) Baron rank.",
				"You choose 'Elemental Contract Rank 26' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank27:PerkType = mk("Elemental Contract Rank 27", "Elemental Contract Rank 27",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 3. Allow to rank-up summoned elementals to (Peak) Baron rank.",
				"You choose 'Elemental Contract Rank 27' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank28:PerkType = mk("Elemental Contract Rank 28", "Elemental Contract Rank 28",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 3. Allow to rank-up summoned elementals to (Low) Viscount rank.",
				"You choose 'Elemental Contract Rank 28' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank29:PerkType = mk("Elemental Contract Rank 29", "Elemental Contract Rank 29",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 3. Allow to rank-up summoned elementals to (Mid) Viscount rank.",
				"You choose 'Elemental Contract Rank 29' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank30:PerkType = mk("Elemental Contract Rank 30", "Elemental Contract Rank 30",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 3. Allow to rank-up summoned elementals to (Advanced) Viscount rank.",
				"You choose 'Elemental Contract Rank 30' perk, rising your ability to command more and stronger elementals.");
		public static const ElementalContractRank31:PerkType = mk("Elemental Contract Rank 31", "Elemental Contract Rank 31",
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 3. Allow to rank-up summoned elementals to (Peak) Viscount rank.",
				"You choose 'Elemental Contract Rank 31' perk, rising your ability to command more and stronger elementals.");
		public static const ElementsOfMarethAdvanced:PerkType = mk("Elements of Mareth: Advanced", "Elements of Mareth: Advanced",
				"You can now summon and command poison, purity and corruption elementals. Also increase elementals command limit by 1.",
				"You choose 'Elements of Mareth: Advanced' perk, your time spent in Mareth allowed you to get advanced understanding of native elements that aren't classified as one of four traditional.");
		public static const ElementsOfMarethBasics:PerkType = mk("Elements of Mareth: Basics", "Elements of Mareth: Basics",
				"You can now summon and command ice, lightning and darkness elementals. Also increase elementals command limit by 1.",
				"You choose 'Elements of Mareth: Basics' perk, your time spent in Mareth allowed you to get basic understanding of native elements that aren't classified as one of four traditional.");
		public static const ElementsOfTheOrtodoxPath:PerkType = mk("Elements of the Ortodox Path", "Elements of the Ortodox Path",
				"You can now summon and command ether, wood and metal elementals. Also increase elementals command limit by 1.",
				"You choose 'Elements of the Ortodox Path' perk, your time spent on studing elements allowed to be able call those meantioned in more ortodox writings.");
		public static const ElvishPeripheralNervSys:PerkType = mk("Elvish Peripheral NervSys", "Elvish Peripheral NervSys",
				"Your Elvish Peripheral NervSys is giving you 5 pts of phantom Spe (scalable) and allow to keep Elven Sense even without elf arms/legs.",
				"You choose the 'Elvish Peripheral NervSys' perk, due to repeadly balancing on line between life and death your peripheral nervous system started to work like that of elfs.");
		public static const ElvishPeripheralNervSysEvolved:PerkType = mk("Elvish Peripheral NervSys (Evolved)", "Elvish Peripheral NervSys (Evolved)",
				"Your Elvish Peripheral NervSys is giving you 10 pts of phantom Spe (scalable), increase your natural speed, evasion and thickness.",
				"You choose the 'Elvish Peripheral NervSys (Evolved)' perk, your peripheral nervous system continue subtile changes leading to be more elf-like.");
		public static const ElvishPeripheralNervSysFinalForm:PerkType = mk("Elvish Peripheral NervSys (Final Form)", "Elvish Peripheral NervSys (Final Form)",
				"Your Elvish Peripheral NervSys is giving you 15 pts of phantom Spe (scalable), increase your natural speed and evasion, decrease melee/range accuracy penalty when using multiattack options.",
				"You choose the 'Elvish Peripheral NervSys (Final Form)' perk, your peripheral nervous system reached it final changes to reassamble elvish peripheral nervous system.");
		public static const Embodiment:PerkType = mk("Embodiment", "Embodiment",
				"You embody the principles of the monks... as usual you should only expect the 10% soulforce gain.",
				"You choose the 'Embodiment' perk, gaining +10% max Soulforce.");
		public static const EnableCriticals:PerkType = mk("Enable Criticals", "Enable Criticals",
				"You now score crits on all naturaly immune to them enemies like constructs, goo or plants.",
				"You choose the 'Enable Criticals' perk, allowing you to get crits on normaly immune to this enemy types.");
		public static const Enchantment:PerkType = mk("Enchantment", "Enchantment",
				"Using your arcane knowledge associated with alchemy,  you enchant each item to further power its effects +1 effect.",
				"You choose the 'Enchantment' perk, number of possible effects of transformatives +1.");
		public static const EngineersFriend:PerkType = mk("Engineer's Friend", "Engineer's Friend",
				"Ah Spah's sappin' mah Sentrah! (Damn that's a thick accent... best take the +10% ranged damage buff before he turns it on you)",
				"You choose the 'Engineer's Friend' perk, gaining +10% range phys dmg.");
		public static const Enhancement:PerkType = mk("Enhancement", "Enhancement",
				"Using your knowledge of alchemy, you've found a way to enhance the effects of transformatives +1 effect.",
				"You choose the 'Enhancement' perk, number of possible effects of transformatives +1.");
		public static const EnvenomedBolt:PerkType = mk("Envenomed Bolt", "Envenomed Bolt",
				"By carefully collecting your venom you can apply poison to your arrows and bolts.",
				"You choose the 'Envenomed Bolt' perk, allowing you to apply your own venom to arrows and bolts.");
		public static const EpicBrawn:PerkType = mk("Epic Brawn", "Epic Brawn",
				"You have improved your striking power to epic level. (+25% to phantom Str bonus, +20% to unarmed atk)",
				"You choose the 'Epic Brawn' perk, improving your striking power to epic level. (+25% to phantom Str bonus, +20% to unarmed atk)");
		public static const EpicBrute:PerkType = mk("Epic Brute", "Epic Brute",
				"You have improved your striking strength to epic level. (add 80 pts of phantom Str (scalable))",
				"You choose the 'Epic Brute' perk, improving your striking strength to epic level. (add 80 pts of phantom Str (scalable))");
		public static const EpicDiehard:PerkType = mk("Epic Diehard", "Epic Diehard",
				"You can't loose by HP until reaching droping into negative health larger than 8% of max HP + 800(scalable). HP limit cumulative with other Diehard perks and when below 0 HP will not longer loose 1% of max HP per turn.",
				"You choose the 'Epic Diehard' perk, getting third upgrade of Diehard effect.");
		public static const EpicEndurance:PerkType = mk("Epic Endurance", "Epic Endurance",
				"Increases maximum fatigue by 4500.",
				"You choose the 'Epic Endurance' perk. Thanks to your epic physical conditioning, your maximum fatigue has been increased by 4500!");
		public static const EpicGolemMaker:PerkType = mk("Epic Golem Maker", "Epic Golem Maker",
				"Your proficiency in making golems allows to make stronger golems and slightly rise your intelligence and wisdom.",
				"You choose 'Epic Golem Maker' perk, increasing your proficiency in making golems.");
		public static const EpicGolemMaker2ndCircle:PerkType = mk("Epic Golem Maker (2nd Circle)", "Epic Golem Maker (2nd Circle)",
				"Your proficiency in making golems allows to make stronger than before golems and slightly rise your intelligence and wisdom.",
				"You choose 'Epic Golem Maker (2nd Circle)' perk, increasing your proficiency in making golems.");
		public static const EpicGolemMaker3rdCircle:PerkType = mk("Epic Golem Maker (3rd Circle)", "Epic Golem Maker (3rd Circle)",
				"Your proficiency in making golems allows to make stronger golems as much stronger their creator became and slightly rise your intelligence and wisdom. Also allow to make and store 1 improved stone golem.",
				"You choose 'Epic Golem Maker (3rd Circle)' perk, increasing your proficiency in making golems. Also allow to make improved stone golems.");
		public static const EpicIntelligence:PerkType = mk("Epic Intelligence", "Epic Intelligence",
				"Increases maximum intelligence by 35 + 5 * NG tier.",
				"You choose the 'Epic Intelligence' perk. Increases maximum intelligence by 35 + 5 * NG tier.");
		public static const EpicLibido:PerkType = mk("Epic Libido", "Epic Libido",
				"Increases maximum libido by 35 + 5 * NG tier.",
				"You choose the 'Epic Libido' perk. Increases maximum libido by 35 + 5 * NG tier.");
		public static const EpicLifeline:PerkType = mk("Epic Lifeline", "Epic Lifeline",
				"Increases self healing by 240 out of combat and by 120 in combat (using defend option will double it).",
				"You choose the 'Epic Lifeline' perk, increasing your self healing to epic level.");
		public static const EpicSelfControl:PerkType = mk("Epic Self-Control", "Epic Self-Control",
				"Increases maximum lust by 2250.",
				"You choose the 'Epic Self-Control' perk. Thanks to your epic mental conditioning, your maximum lust has been increased by 2250!");
		public static const EpicSensitivity:PerkType = mk("Epic Sensitivity", "Epic Sensitivity",
				"Increases maximum sensitivity by 35 + 5 * NG tier.",
				"You choose the 'Epic Sensitivity' perk. Increases maximum sensitivity by 35 + 5 * NG tier.");
		public static const EpicSpeed:PerkType = mk("Epic Speed", "Epic Speed",
				"Increases maximum speed by 35 + 5 * NG tier.",
				"You choose the 'Epic Speed' perk. Increases maximum speed by 35 + 5 * NG tier.");
		public static const EpicSpirituality:PerkType = mk("Epic Spirituality", "Epic Spirituality",
				"Increases maximum mana by 6750.",
				"You choose the 'Epic Spirituality' perk. Thanks to your epic mystical conditioning, your maximum mana has been increased by 6750!");
		public static const EpicStrength:PerkType = mk("Epic Strength", "Epic Strength",
				"Increases maximum strength by 35 + 5 * NG tier.",
				"You choose the 'Epic Strength' perk. Increases maximum strength by 35 + 5 * NG tier.");
		public static const EpicToughness:PerkType = mk("Epic Toughness", "Epic Toughness",
				"Increases maximum toughness by 35 + 5 * NG tier.",
				"You choose the 'Epic Toughness' perk. Increases maximum toughness by 35 + 5 * NG tier.");
		public static const EpicTranquilness:PerkType = mk("Epic Tranquilness", "Epic Tranquilness",
				"Increases maximum wrath by 2250.",
				"You choose the 'Epic Tranquilness' perk. Thanks to your epic anger managment training, your maximum wrath has been increased by 2250!");
		public static const EpicWisdom:PerkType = mk("Epic Wisdom", "Epic Wisdom",
				"Increases maximum wisdom by 35 + 5 * NG tier.",
				"You choose the 'Epic Wisdom' perk. Increases maximum wisdom by 35 + 5 * NG tier.");
		public static const EromancyBeginner:PerkType = mk("Eromancy (Beginner)", "Eromancy (Beginner)",
				"+1 extra maximum mana for each point of intelligence and +1 extra maximum fatigue for each point of libido.",
				"You choose 'Eromancy (Beginner)' perk, granting +1 extra maximum mana for each point of intelligence and +1 extra maximum fatigue for each point of libido.");
		public static const EromancyExpert:PerkType = mk("Eromancy (Expert)", "Eromancy (Expert)",
				"+1 extra maximum mana for each point of intelligence and +2 extra maximum fatigue for each point of libido, bonus to lust dmg dealt by m. specials similary to the one given by Arcane Lash.",
				"You choose 'Eromancy (Expert)' perk, granting +1 extra maximum mana for each point of intelligence and +2 extra maximum fatigue for each point of libido, bonus to lust dmg dealt by m. specials similary to the one given by Arcane Lash.");
		public static const EromancyMaster:PerkType = mk("Eromancy (Master)", "Eromancy (Master)",
				"+2 extra maximum mana for each point of intelligence and +2 extra maximum fatigue for each point of libido, tease exp for use of Arouse spell or m. specials dealing lust dmg.",
				"You choose 'Eromancy (Master)' perk, granting +2 extra maximum mana for each point of intelligence and +2 extra maximum fatigue for each point of libido, tease exp for use of Arouse spell or m. specials dealing lust dmg.");
		public static const Escort:PerkType = mk("Escort", "Escort",
				"You've gotten so good you can now charge people money for having sex with you. There's many tricks you learned, increasing your tease damage by 15%.",
				"You choose the 'Escort' perk, gaining +15% tease dmg.");
		public static const EternalyLastingBuffs:PerkType = mk("(Eternaly) Lasting Buffs", "(Eternaly) Lasting Buffs",
				"Buff spells last another 5 turns longer at another 2x increase of their costs.",
				"You choose the '(Eternaly) Lasting Buffs' perk. Your mastery over buffs reached (eternaly) lasting level. (+5 turns duration and increasing cost 2x)");
		public static const Evade:PerkType = mk("Evade", "Evade",
				"Increases chances of evading enemy attacks. (+5% to evasion)",
				"You choose the 'Evade' perk, allowing you to avoid enemy attacks more often! (+5% to evasion)");
		public static const EverLastingBuffs:PerkType = mk("(Ever)Lasting Buffs", "(Ever)Lasting Buffs",
				"Buff spells last 5 turns longer at the double of normal costs.",
				"You choose the '(Ever)Lasting Buffs' perk. Your mastery over buffs reached (ever)lasting level. (+5 turns duration and increasing cost 2x)");
		public static const ExpertAllRounderEducation:PerkType = mk("Expert All-Rounder Education", "Expert All-Rounder Education",
				"Limit of advanced job you can learn is increased by 3.",
				"You choose the 'Expert All-Rounder Education' perk, expanding amount of advanced jobs you can learn. (+3)");
		public static const ExpertGolemMaker:PerkType = mk("Expert Golem Maker", "Expert Golem Maker",
				"Your proficiency in making golems allows them to attack even flying enemies, lower by 5% chance of core shattering and storing more golems.",
				"You choose 'Expert Golem Maker' perk, increasing your proficiency in making golems.");
		public static const ExpertGunslinger:PerkType = mk("Expert Gunslinger", "Expert Gunslinger",
				"Gain an extra firearm attack per turn (3rd one).",
				"You choose the 'Expert Gunslinger' perk, gaining an extra firearm attack per turn.");
		public static const ExplosiveCartridge:PerkType = mk("Explosive cartridge", "Explosive cartridge",
				"Gunshots deals double damage against groups and large enemies.",
				"You choose the 'Explosive cartridge' perk, allowing for your gunshots dealing extra damage to group or large enemies.");
		public static const ExtraClawAttack:PerkType = mk("Extra claw attack", "Extra claw attack",
				"When attacking with your claws, add an additional attack striking up to 3 times.",
				"You choose the 'Extra claw attack' perk, gaining an additional attack with your claws!");
		public static const ExtremelyLucky:PerkType = mk("Extremely Lucky", "Extremely Lucky",
				"You're banned from casinos with that luck of yours, but you still find stuff lying around after battles, increasing your gain upon victory. (15% more gems from victories)",
				"You choose the 'Extremely Lucky' perk, increasing gem gains from victories by 15%.");
		public static const EyesOfTheHunterAdept:PerkType = mk("Eyes of the Hunter (Adept)", "Eyes of the Hunter (Adept)",
				"Allow see another few infomations about enemy (as long it apply to current viewed enemy) (req. 50+ sensitivity).",
				"You choose the 'Eyes of the Hunter (Adept)' perk, allowing you to gain wider than before range of information about enemy you fight.");
		public static const EyesOfTheHunterMaster:PerkType = mk("Eyes of the Hunter (Master)", "Eyes of the Hunter (Master)",
				"Allow see more infomations about enemy (as long it apply to current viewed enemy) (req. 75+ sensitivity).",
				"You choose the 'Eyes of the Hunter (Master)' perk, adding more possible to see information about enemy you fight in compare to Adept stage.");
		public static const EyesOfTheHunterNovice:PerkType = mk("Eyes of the Hunter (Novice)", "Eyes of the Hunter (Novice)",
				"Allow see few more than usual infomations about enemy (req. 25+ sensitivity).",
				"You choose the 'Eyes of the Hunter (Novice)' perk, allowing you to gain more information about enemy you fight.");
		public static const Feint:PerkType = mk("Feint", "Feint",
				"Unlock p. special 'Feint' that have chance to cause 1 turn long distraction of enemy(ies) that allow to use sneaky attack.",
				"You choose the 'Feint' perk. Unlock p. special 'Feint' that have chance to cause 1 turn long distraction of enemy(ies) that allow to use sneaky attack.");
		public static const FeralArmor:PerkType = mk("Feral Armor", "Feral Armor",
				"Gain extra armor based on your toughness so long as you’re naked and have any form of natural armor.",
				"You choose the 'Feral Armor' perk, gaining extra armor as long you are naked and have any natural armor!");
		public static const FertilityMinus:PerkType = mk("Fertility-", "Fertility-",
				"Decreases fertility rating by 15 and cum volume by up to 30%. (Req's libido of less than 25.)",
				"You choose the 'Fertility-' perk, making it harder to get pregnant.  It also decreases your cum volume by up to 30% (if appropriate)!");
		public static const FertilityPlus:PerkType = mk("Fertility+", "Fertility+",
				"Increases fertility rating by 15 and cum volume by up to 50%.",
				"You choose the 'Fertility+' perk, making it easier to get pregnant.  It also increases your cum volume by up to 50% (if appropriate)!");
		public static const FirstAttackElementals:PerkType = mk("First Attack: Elementals", "First Attack: Elementals",
				"Instead of melee attacking in PC place one of summoned elementals will attack before PC allowing latter to take any action even personaly attaking with melee weapon.",
				"You choose the 'First Attack: Elementals' perk, allowing your summoned elementals to attack independly from you.");
		public static const FirstAttackGolems:PerkType = mk("First Attack: Golems", "First Attack: Golems",
				"Before your actions one or more of your golems will attack.",
				"You choose the 'First Attack: Golems' perk, allowing some of your pernament golems strike before you.");
		public static const FirstResponse:PerkType = mk("First Response", "First Response",
				"Your time running into disaster to take care of others allows you to take better care of wounds, further increasing your regen.",
				"You choose the 'First Response' perk, increasing HP gains by 20%.");
		public static const FleshBodyApprenticeStage:PerkType = mk("Flesh Body: Apprentice Stage", "Flesh Body: Apprentice Stage",
				"Your reached first stage of body cultivating. (+4 to unarmed attack, +2 to armor, +1 to magic resistance, +50 max HP at S.Apprentice, S.Personage, S.Warrior stages)",
				"You choose the 'Flesh Body: Apprentice Stage' perk, working on cultivating power of your fleshy body. (+4 to unarmed attack, +2 to armor, +1 to magic resistance, +50 max HP at S.Apprentice, S.Personage, S.Warrior stages)");
		public static const FleshBodyElderStage:PerkType = mk("Flesh Body: Elder Stage", "Flesh Body: Elder Stage",
				"Your reached third stage of body cultivating. (+8 to unarmed attack, +4 to armor, +3 to magic resistance, +100 max HP at S.Exalt, S.Overlord, S.Tyrant stages)",
				"You choose the 'Flesh Body: Elder Stage' perk, working on cultivating power of your fleshy body. (+8 to unarmed attack, +4 to armor, +3 to magic resistance, +100 max HP at S.Exalt, S.Overlord, S.Tyrant stages)");
		public static const FleshBodyOverlordStage:PerkType = mk("Flesh Body: Overlord Stage", "Flesh Body: Overlord Stage",
				"Your reached fourth stage of body cultivating. (+10 to unarmed attack, +5 to armor, +4 to magic resistance, +125 max HP S.King, S.Emperor, S.Ancestor stages)",
				"You choose the 'Flesh Body: Overlord Stage' perk, working on cultivating power of your fleshy body. (+10 to unarmed attack, +5 to armor, +4 to magic resistance, +125 max HP S.King, S.Emperor, S.Ancestor stages)");
		public static const FleshBodyTyrantStage:PerkType = mk("Flesh Body: Tyrant Stage", "Flesh Body: Tyrant Stage",
				"Your reached fifth stage of body cultivating.",
				"You choose the 'Flesh Body: Tyrant Stage' perk, working on cultivating power of your fleshy body. (+12 to unarmed attack, +6 to armor, +5 to magic resistance, +150 max HP at )");
		public static const FleshBodyWarriorStage:PerkType = mk("Flesh Body: Warrior Stage", "Flesh Body: Warrior Stage",
				"Your reached second stage of body cultivating. (+6 to unarmed attack, +3 to armor, +2 to magic resistance, +75 max HP at S.Sprite, S.Scholar, S.Elder stages)",
				"You choose the 'Flesh Body: Warrior Stage' perk, working on cultivating power of your fleshy body. (+6 to unarmed attack, +3 to armor, +2 to magic resistance, +75 max HP at S.Sprite, S.Scholar, S.Elder stages)");
		public static const FlurryOfBlows:PerkType = mk("Flurry of Blows", "Flurry of Blows",
				"Gain two additional attack when fighting with fist or fist weapon. All physical soulforce ability now also strike twice!",
				"You choose the 'Flurry of Blows' perk, gaining two additional attack when fighting with fist or fist weapon. All physical soulforce ability now also strike twice.");
		public static const FuelForTheFire:PerkType = mk("Fuel for the Fire", "Fuel for the Fire",
				"Increase two times wrath gains from getting hit.",
				"You choose the 'Fuel for the Fire' perk, increasing gained wrath after taking damage.");
		public static const FocusedMind:PerkType = mk("Focused Mind", "Focused Mind",
				"Black Magic is less likely to backfire and White Magic threshold is increased.",
				"You choose the 'Focused Mind' perk. Black Magic is less likely to backfire and White Magic threshold is increased.");
		public static const FortressOfIntellect:PerkType = mk("Fortress of Intellect", "Fortress of Intellect",
				"Might increases intelligence instead of strength (toggleable).",
				"You choose the 'Fortress of Intellect' perk. You can now change Might to boost intelligence instead of strength.");
		public static const FourthRing:PerkType = mk("Fourth Ring", "Fourth Ring",
				"Your expert understanding of magic pools allows you to equip fourth ring.",
				"You choose the 'Fourth Ring' perk, reaching expert understanding of magic pools to allow you equip fourth ring.");
		public static const Furnace:PerkType = mk("Furnace", "Furnace",
				"I don't know how you worked without one, but now you have a furnace! Now take your upgraded armor proficiency while I get answers... (+5% phys/mag resistance)",
				"You choose the 'Furnace' perk, increasing armor proficiency. (+5% phys/mag resistance)");
		public static const Fusion:PerkType = mk("Fusion", "Fusion",
				"Using your knowledge of alchemy and enhancement, you found a way to fuse two of the same item together, further enhacing transformative effects +1 effect.",
				"You choose the 'Fusion' perk, number of possible effects of transformatives +1.");
		public static const GigantGrip:PerkType = mk("Gigant's Grip", "Gigant's Grip",
				"Gain an ability to wield large weapons in one hand. (+5 to max Str)",
				"You choose the 'Gigant's Grip' perk, gaining an ability to wield large weapons in one hand. (+5 to max Str)");
		public static const GigantGripEx:PerkType = mk("Gigant's Grip (Ex)", "Gigant's Grip (Ex)",
				"Allow to apply all perks boosting Large weapon performance (increased atk and etc.) to Massive weapons. Exception are perks that allow for multi attacks of large weapons. (+5 to max Str/Tou)",
				"You choose the 'Gigant's Grip (Ex)' perk, allowing to apply all perks boosting Large weapon performance (increased atk and etc.) to Massive weapons. Exception are perks that allow for multi attacks of large weapons. (+5 to max Str/Tou)");
		public static const GigantGripSu:PerkType = mk("Gigant's Grip (Su)", "Gigant's Grip (Su)",
				"Gain an ability to wield four large weapons as long you have 4 or more arms. (+5 to max Str/Tou/Spe)",
				"You choose the 'Gigant's Grip (Su)' perk, gaining an ability to wield large weapons in one hand. (+5 to max Str/Tou/Spe)");
		public static const GiantsReach:PerkType = mk("Giant's Reach", "Giant's Reach",
				"When fighting groups of enemies with Large weapons it creates small shockwaves increasing range (and damage) of Aoe attacks.",
				"You choose 'Giant's Reach' perk. Increase range of attacks with large weapons in fights against group enemies.");
		public static const GiftOfLust:PerkType = mk("Gift of Lust", "Gift of Lust",
				"You enhanced your Transference special to transfer 25% of your current arousal to your opponent at 25% lower fatigue cost.",
				"You choose the 'Gift of Lust' perk, enhancing special Transference to transfer 10% more lust to enemy.");
		public static const GlacialStorm:PerkType = mk("Glacial Storm", "Glacial Storm",
				"Cumulative 20% damage increase for every subsequent ice spell without interruption.",
				"You choose the 'Glacial Storm' perk. Cumulative 20% damage increase for every subsequent ice spell without interruption.");
		public static const GodOfSteel:PerkType = mk("God of Steel", "God of Steel",
				"You have surpassed your mortal self to become the embodiment of melee damage, further increasing it. (+10% melee phys dmg)",
				"You choose the 'God of Steel' perk, gaining +10% melee phys dmg.");
		public static const GolemArmyCaptain:PerkType = mk("Golem Army Captain", "Golem Army Captain",
				"+2/4 to max limit of stored pernament/temporal stone golems.",// +1 to max limit for stored pernament steel golems.
				"You choose the 'Golem Army Captain' perk, allowing to store additional pernament (+2) and temporal (+4) stone golems golems in your golem bag.");// Allow to store steel golem. (+1)
		public static const GolemArmyColonel:PerkType = mk("Golem Army Colonel", "Golem Army Colonel",
				"+4/8 to max limit of stored pernament/temporal stone golems.",
				"You choose the 'Golem Army Colonel' perk, allowing to store additional pernament (+4) and temporal (+8) stone golems in your golem bag.");
		public static const GolemArmyGeneral:PerkType = mk("Golem Army General", "Golem Army General",
				"+1/5/10 to max limit stored of (pernament improved/normal)/temporal stone golems.",
				"You choose the 'Golem Army General' perk, allowing to store additional pernament (improved stone +1/stone +5) and temporal (+10) stone golems in your golem bag.");
		public static const GolemArmyLieutenant:PerkType = mk("Golem Army Lieutenant", "Golem Army Lieutenant",
				"+1/2 to max limit stored of pernament/temporal stone golems.",
				"You choose the 'Golem Army Lieutenant' perk, allowing to store additional pernament (+1) and temporal (+2) stone golems in your golem bag.");
		public static const GolemArmyMajor:PerkType = mk("Golem Army Major", "Golem Army Major",
				"+3/6 to max limit stored of pernament/temporal stone golems.",
				"You choose the 'Golem Army Major' perk, allowing to store additional pernament (+3) and temporal (+6) stone golems in your golem bag.");
		public static const GoliathI:PerkType = mk("Goliath I", "Goliath I",
				"+2 extra HP per point of strength.",
				"You choose the 'Goliath I' perk, granting +2 extra maximum HP for each point of strength.");
		public static const GoliathII:PerkType = mk("Goliath II", "Goliath II",
				"+2 extra HP per point of strength.",
				"You choose the 'Goliath II' perk, granting +2 extra maximum HP for each point of strength.");
		public static const GoliathIII:PerkType = mk("Goliath III", "Goliath III",
				"+2 extra HP per point of strength.",
				"You choose the 'Goliath III' perk, granting +2 extra maximum HP for each point of strength.");
		public static const GoliathIV:PerkType = mk("Goliath IV", "Goliath IV",
				"+2 extra HP per point of strength.",
				"You choose the 'Goliath IV' perk, granting +2 extra maximum HP for each point of strength.");
		public static const GoliathV:PerkType = mk("Goliath V", "Goliath V",
				"+2 extra HP per point of strength.",
				"You choose the 'Goliath V' perk, granting +2 extra maximum HP for each point of strength.");
		public static const GoliathVI:PerkType = mk("Goliath VI", "Goliath VI",
				"+2 extra HP per point of strength.",
				"You choose the 'Goliath VI' perk, granting +2 extra maximum HP for each point of strength.");
		public static const GorgonsEyes:PerkType = mk("Gorgon's Eyes", "Gorgon's Eyes",
				"Your eyes mutated and now even with any type of eyes you can use petrifying gaze. Additionaly it makes you more immune to all types of attack that are related to sight.",
				"You choose the 'Gorgon's Eyes' perk. Prolonged using petrifying caused your eyes to change even more like those of gorgons.");
		public static const GorgonsEyesEvolved:PerkType = mk("Gorgon's Eyes (Evolved)", "Gorgon's Eyes (Evolved)",
				"Another mutation of your eyes allows you to move a bit faster, a bit longer Petrify effect and change negative effect of resistance to basilisks and similar effects into positive effect (-5 to Spe change into +5 to Spe (scalable)).",
				"You choose the 'Gorgon's Eyes (Evolved)' perk. Long term use of petrifying caused your eyes to mutate even more.");
		public static const GrandArchmage:PerkType = mk("Grand Archmage", "Grand Archmage",
				"[if (player.inte>=125)" +
						"Increases base spell strength by 40%, mana pool by 75 and lust bar by 20." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Grand Archmage' perk, increasing base spell strength by 40%, mana pool by 75 and lust bar by 20.");
		public static const GrandArchmage2ndCircle:PerkType = mk("Grand Archmage (2nd Circle)", "Grand Archmage (2nd Circle)",
				"[if (player.inte>=150)" +
						"Increases base spell strength by 50%, mana pool by 90 and lust bar by 25." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Grand Archmage (2nd Circle)' perk, increasing base spell strength by 50%, mana pool by 90 and lust bar by 25.");
		public static const GrandArchmage3rdCircle:PerkType = mk("Grand Archmage (3rd Circle)", "Grand Archmage (3rd Circle)",
				"[if (player.inte>=175)" +
						"Increases base spell strength by 60%, mana pool by 105 and lust bar by 30." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Grand Archmage (3rd Circle)' perk, increasing base spell strength by 60%, mana pool by 105 and lust bar by 30.");
		public static const GrandBlademaster:PerkType = mk("Grand Blademaster", "Grand Blademaster",
				"Gain +15% to critical strike chance when wielding weapon with blade (sword, dueling sword, axe) and not using a shield.",
				"You choose the 'Grand Blademaster' perk.  Your chance of critical hit is increased by 15% as long as you're wielding weapon with blade like sword and not using a shield.");
		public static const GrandMage:PerkType = mk("Grand Mage", "Grand Mage",
				"[if (player.inte>=75)" +
						"Increases base spell strength by 30%, base mana pool by 45 and lust bar by 10." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Grand Mage' perk, increasing base spell strength by 30%, mana pool by 45 and lust bar by 10.");
		public static const GrandMasterGolemMaker:PerkType = mk("Grand-Master Golem Maker", "Grand-Master Golem Maker",
				"Your proficiency in making golems allows to make golems that can attack flying enemies at small cost in mana drawn from it owner (aka PC). Also allowing to store one more in golem bag.",
				"You choose 'Grand-Master Golem Maker' perk, increasing your proficiency in making golems.");
		public static const GrandTactician:PerkType = mk("Grand Tactician", "Grand Tactician",
				"[if(player.inte>=150)" +
						"Increases physical critical hit chance by up to 30% (Intelligence-based)." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Grand Tactician' perk, increasing physical critical hit chance by up to 30% (Intelligence-based).");
		public static const GreaterAerialCombat:PerkType = mk("Greater Aerial Combat", "Greater Aerial Combat",
				"You have learned to use air and gravity to your own benefit. (extend flight duration by 4 turns and increase evasion when flying by 15%)",
				"You choose the 'Greater Aerial Combat' perk, you learned to use air and gravity to your own benefit.");
		public static const GreaterBrawn:PerkType = mk("Greater Brawn", "Greater Brawn",
				"You have greatly improved your striking power. (+20% to phantom Str bonus, +15% to unarmed atk)",
				"You choose the 'Greater Brawn' perk, greatly improving your striking power. (+20% to phantom Str bonus, +15% to unarmed atk)");
		public static const GreaterBrute:PerkType = mk("Greater Brute", "Greater Brute",
				"You have greatly improved your striking strength. (add 60 pts of phantom Str (scalable))",
				"You choose the 'Greater Brute' perk, greatly improving your striking strength. (add 60 pts of phantom Str (scalable))");
		public static const GreaterCrinosShape:PerkType = mk("Greater Crinos Shape", "Greater Crinos Shape",
				"Crinos Shape increase to physical might rise to 80% of str/tou/spe.",
				"You choose the 'Greater Crinos Shape' perk, gaining another increase to phys stats boost in Crinos Shape (+80%).");
		public static const GreaterDiehard:PerkType = mk("Greater Diehard", "Greater Diehard",
				"You can't loose by HP until reaching droping into negative health larger than 6% of max HP + 600(scalable). HP limit cumulative with other Diehard perks.",
				"You choose the 'Greater Diehard' perk, getting second increase to limit of maintaining Diehard effects.");
		public static const GreaterEvade:PerkType = mk("Greater Evade", "Greater Evade",
				"Increases chances of evading enemy attacks. (+15% to evasion)",
				"You choose the 'Greater Evade' perk, allowing you to avoid enemy attacks more often! (+15% to evasion)");
		public static const GreaterFeint:PerkType = mk("Greater feint", "Greater feint",
				"Increase duration of enemy(ies) distraction by 2 turns.",
				"You choose the 'Greater feint' perk. Increase duration of enemy(ies) distraction by 2 turns.");
		public static const GreaterGiftOfLust:PerkType = mk("Greater Gift of Lust", "Greater Gift of Lust",
				"You enhanced your Transference special second time to transfer 40% of your current arousal to your opponent at doubled fatigue cost compared to previous enhance (1,5x of orginal fatigue cost).",
				"You choose the 'Greater Gift of Lust' perk, enhancing Transference special second time to transfer 15% more lust to enemy at increased fatigue cost.");
		public static const GreaterLifeline:PerkType = mk("Greater Lifeline", "Greater Lifeline",
				"Increases self healing by 180 out of combat and by 90 in combat (using defend option will double it).",
				"You choose the 'Greater Lifeline' perk, greatly increasing your self healing.");
		public static const GreyArchmage:PerkType = mk("Grey Archmage", "Grey Archmage",
				"[if (player.inte>=275)" +
						"Increases base spell strength by 100%, mana pool by 200, lust bar by 50 and regain mana 150% faster." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Grey Archmage' perk, increasing base spell strength by 100%, mana pool by 150, lust bar by 40 and boosting mana recovery by large margin.");
		public static const GreyMage:PerkType = mk("Grey Mage", "Grey Mage",
				"[if (player.inte>=225)" +
						"Increases base spell strength by 80%, mana pool by 150, lust bar by 40, regain it 50% faster, treshold for Black Magic is 30 lust and for White 30 lust below current max." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Grey Mage' perk. Your base spell, mana pool, lust bar and mana recovery are greatly increased, treshold for White Magic rised and for Black lowered.");
		public static const HeavyArmorProficiency:PerkType = mk("Heavy Armor Proficiency", "Heavy Armor Proficiency",
				"Wearing Heavy Armor's grants 10% damage reduction.",
				"You choose the 'Heavy Armor Proficiency' perk.  Due to your specialization in wearing heavy armor's you gain a little bit of damage reduction.");
		public static const HalfStepToAdvancedEndurance:PerkType = mk("Half-step-to Advanced Endurance", "Half-step-to Advanced Endurance",
				"Increases maximum fatigue by 120.",
				"You choose the 'Half-step-to Advanced Endurance' perk. Thanks to your advanced physical conditioning, your maximum fatigue has been increased by 120!");	
		public static const HalfStepToAdvancedSelfControl:PerkType = mk("Half-step-to Advanced Self-Control", "Half-step-to Advanced Self-Control",
				"Increases maximum lust by 60.",
				"You choose the 'Half-step-to Advanced Self-Control' perk. Thanks to your advanced mental conditioning, your maximum lust has been increased by 60!");
		public static const HalfStepToAdvancedSpirituality:PerkType = mk("Half-step-to Advanced Spirituality", "Half-step-to Advanced Spirituality",
				"Increases maximum mana by 180.",
				"You choose the 'Half-step-to Advanced Spirituality' perk. Thanks to your advanced mystical conditioning, your maximum mana has been increased by 180!");	
		public static const HalfStepToAdvancedTranquilness:PerkType = mk("Half-step-to Advanced Tranquilness", "Half-step-to Advanced Tranquilness",
				"Increases maximum wrath by 60.",
				"You choose the 'Half-step-to Advanced Tranquilness' perk. Thanks to your advanced anger managment training, your maximum wrath has been increased by 60!");	
		public static const HalfStepToEpicEndurance:PerkType = mk("Half-step-to Epic Endurance", "Half-step-to Epic Endurance",
				"Increases maximum fatigue by 3000.",
				"You choose the 'Half-step-to Epic Endurance' perk. Thanks to your epic physical conditioning, your maximum fatigue has been increased by 3000!");
		public static const HalfStepToEpicSelfControl:PerkType = mk("Half-step-to Epic Self-Control", "Half-step-to Epic Self-Control",
				"Increases maximum lust by 1500.",
				"You choose the 'Half-step-to Epic Self-Control' perk. Thanks to your epic mental conditioning, your maximum lust has been increased by 1500!");
		public static const HalfStepToEpicSpirituality:PerkType = mk("Half-step-to Epic Spirituality", "Half-step-to Epic Spirituality",
				"Increases maximum mana by 4500.",
				"You choose the 'Half-step-to Epic Spirituality' perk. Thanks to your epic mystical conditioning, your maximum mana has been increased by 4500!");
		public static const HalfStepToEpicTranquilness:PerkType = mk("Half-step-to Epic Tranquilness", "Half-step-to Epic Tranquilness",
				"Increases maximum wrath by 1500.",
				"You choose the 'Half-step-to Epic Tranquilness' perk. Thanks to your epic anger managment training, your maximum wrath has been increased by 1500!");
		public static const HalfStepToImprovedEndurance:PerkType = mk("Half-step-to Improved Endurance", "Half-step-to Improved Endurance",
				"Increases maximum fatigue by 50.",
				"You choose the 'Half-step-to Improved Endurance' perk. Thanks to your improved physical conditioning, your maximum fatigue has been increased by 50!");
		public static const HalfStepToImprovedSelfControl:PerkType = mk("Half-step-to Improved Self-Control", "Half-step-to Improved Self-Control",
				"Increases maximum lust by 25.",
				"You choose the 'Half-step-to Improved Self-Control' perk. Thanks to your improved mental conditioning, your maximum lust has been increased by 25!");
		public static const HalfStepToImprovedSpirituality:PerkType = mk("Half-step-to Improved Spirituality", "Half-step-to Improved Spirituality",
				"Increases maximum mana by 75.",
				"You choose the 'Half-step-to Improved Spirituality' perk. Thanks to your improved mystical conditioning, your maximum mana has been increased by 75!");
		public static const HalfStepToImprovedTranquilness:PerkType = mk("Half-step-to Improved Tranquilness", "Half-step-to Improved Tranquilness",
				"Increases maximum wrath by 25.",
				"You choose the 'Half-step-to Improved Tranquilness' perk. Thanks to your improved anger managment training, your maximum wrath has been increased by 25!");
		public static const HalfStepToInhumanEndurance:PerkType = mk("Half-step-to Inhuman Endurance", "Half-step-to Inhuman Endurance",
				"Increases maximum fatigue by 1500.",
				"You choose the 'Half-step-to Inhuman Endurance' perk. Thanks to your inhuman physical conditioning, your maximum fatigue has been increased by 1500!");
		public static const HalfStepToInhumanSelfControl:PerkType = mk("Half-step-to Inhuman Self-Control", "Half-step-to Inhuman Self-Control",
				"Increases maximum lust by 750.",
				"You choose the 'Half-step-to Inhuman Self-Control' perk. Thanks to your inhuman mental conditioning, your maximum lust has been increased by 750!");
		public static const HalfStepToInhumanSpirituality:PerkType = mk("Half-step-to Inhuman Spirituality", "Half-step-to Inhuman Spirituality",
				"Increases maximum mana by 2250.",
				"You choose the 'Half-step-to Inhuman Spirituality' perk. Thanks to your inhuman mystical conditioning, your maximum mana has been increased by 2250!");
		public static const HalfStepToInhumanTranquilness:PerkType = mk("Half-step-to Inhuman Tranquilness", "Half-step-to Inhuman Tranquilness",
				"Increases maximum wrath by 750.",
				"You choose the 'Half-step-to Inhuman Tranquilness' perk. Thanks to your inhuman anger managment training, your maximum wrath has been increased by 750!");
		public static const HalfStepToLegendaryEndurance:PerkType = mk("Half-step-to Legendary Endurance", "Half-step-to Legendary Endurance",
				"Increases maximum fatigue by 7000.",
				"You choose the 'Half-step-to Legendary Endurance' perk. Thanks to your legendary physical conditioning, your maximum fatigue has been increased by 7000!");
		public static const HalfStepToLegendarySelfControl:PerkType = mk("Half-step-to Legendary Self-Control", "Half-step-to Legendary Self-Control",
				"Increases maximum lust by 3500.",
				"You choose the 'Half-step-to Legendary Self-Control' perk. Thanks to your legendary mental conditioning, your maximum lust has been increased by 3500!");
		public static const HalfStepToLegendarySpirituality:PerkType = mk("Half-step-to Legendary Spirituality", "Half-step-to Legendary Spirituality",
				"Increases maximum mana by 10500.",
				"You choose the 'Half-step-to Legendary Spirituality' perk. Thanks to your legendary mystical conditioning, your maximum mana has been increased by 10500!");
		public static const HalfStepToLegendaryTranquilness:PerkType = mk("Half-step-to Legendary Tranquilness", "Half-step-to Legendary Tranquilness",
				"Increases maximum wrath by 3500.",
				"You choose the 'Half-step-to Legendary Tranquilness' perk. Thanks to your legendary anger managment training, your maximum wrath has been increased by 3500!");
		public static const HalfStepToMythicalEndurance:PerkType = mk("Half-step-to Mythical Endurance", "Half-step-to Mythical Endurance",
				"Increases maximum fatigue by 15000.",
				"You choose the 'Half-step-to Mythical Endurance' perk. Thanks to your mythical physical conditioning, your maximum fatigue has been increased by 15000!");
		public static const HalfStepToMythicalSelfControl:PerkType = mk("Half-step-to Mythical Self-Control", "Half-step-to Mythical Self-Control",
				"Increases maximum lust by 7500.",
				"You choose the 'Half-step-to Mythical Self-Control' perk. Thanks to your mythical mental conditioning, your maximum lust has been increased by 7500!");
		public static const HalfStepToMythicalSpirituality:PerkType = mk("Half-step-to Mythical Spirituality", "Half-step-to Mythical Spirituality",
				"Increases maximum mana by 22500.",
				"You choose the 'Half-step-to Mythical Spirituality' perk. Thanks to your mythical mystical conditioning, your maximum mana has been increased by 22500!");
		public static const HalfStepToMythicalTranquilness:PerkType = mk("Half-step-to Mythical Tranquilness", "Half-step-to Mythical Tranquilness",
				"Increases maximum wrath by 7500.",
				"You choose the 'Half-step-to Mythical Tranquilness' perk. Thanks to your mythical anger managment training, your maximum wrath has been increased by 7500!");
		public static const HalfStepToPeerlessEndurance:PerkType = mk("Half-step-to Peerless Endurance", "Half-step-to Peerless Endurance",
				"Increases maximum fatigue by 700.",
				"You choose the 'Half-step-to Peerless Endurance' perk. Thanks to your peerless physical conditioning, your maximum fatigue has been increased by 700!");
		public static const HalfStepToPeerlessSelfControl:PerkType = mk("Half-step-to Peerless Self-Control", "Half-step-to Peerless Self-Control",
				"Increases maximum lust by 350.",
				"You choose the 'Half-step-to Peerless Self-Control' perk. Thanks to your peerless mental conditioning, your maximum lust has been increased by 350!");
		public static const HalfStepToPeerlessSpirituality:PerkType = mk("Half-step-to Peerless Spirituality", "Half-step-to Peerless Spirituality",
				"Increases maximum mana by 1050.",
				"You choose the 'Half-step-to Peerless Spirituality' perk. Thanks to your peerless mystical conditioning, your maximum mana has been increased by 1050!");
		public static const HalfStepToPeerlessTranquilness:PerkType = mk("Half-step-to Peerless Tranquilness", "Half-step-to Peerless Tranquilness",
				"Increases maximum wrath by 350.",
				"You choose the 'Half-step-to Peerless Tranquilness' perk. Thanks to your peerless anger managment training, your maximum wrath has been increased by 350!");
		public static const HalfStepToSuperiorEndurance:PerkType = mk("Half-step-to Superior Endurance", "Half-step-to Superior Endurance",
				"Increases maximum fatigue by 320.",
				"You choose the 'Half-step-to Superior Endurance' perk. Thanks to your superior physical conditioning, your maximum fatigue has been increased by 320!");
		public static const HalfStepToSuperiorSelfControl:PerkType = mk("Half-step-to Superior Self-Control", "Half-step-to Superior Self-Control",
				"Increases maximum lust by 160.",
				"You choose the 'Half-step-to Superior Self-Control' perk. Thanks to your superior mental conditioning, your maximum lust has been increased by 160!");
		public static const HalfStepToSuperiorSpirituality:PerkType = mk("Half-step-to Superior Spirituality", "Half-step-to Superior Spirituality",
				"Increases maximum mana by 480.",
				"You choose the 'Half-step-to Superior Spirituality' perk. Thanks to your superior mystical conditioning, your maximum mana has been increased by 480!");
		public static const HalfStepToSuperiorTranquilness:PerkType = mk("Half-step-to Superior Tranquilness", "Half-step-to Superior Tranquilness",
				"Increases maximum wrath by 160.",
				"You choose the 'Half-step-to Superior Tranquilness' perk. Thanks to your superior anger managment training, your maximum wrath has been increased by 160!");
		public static const Hammer:PerkType = mk("Hammer", "Hammer",
				"You found a hammer! Now you can pound out any dents in your armor, increasing its proficiency! Look at you growing up. (+5% phys/mag resistance)",
				"You choose the 'Hammer' perk, increasing armor proficiency. (+5% phys/mag resistance)");
		public static const HeartOfSteel:PerkType = mk("Heart of Steel", "Heart of Steel",
				"Even your heart has grown used to fighting, after all, the saying goes 'Steel your heart', further increasing your melee strength. (+10% melee phys dmg)",
				"You choose the 'Heart of Steel' perk, gaining +10% melee phys dmg.");
		public static const HeavysFriend:PerkType = mk("Heavy's Friend", "Heavy's Friend",
				"I like you! Cover Heavy! (You'll definitely need that +10% ranged damage buff if you're going in front of that dude)",
				"You choose the 'Heavy's Friend' perk, gaining +10% range phys dmg.");
		public static const HectaAttackSmall:PerkType = mk("Hecta Attack (Small)", "Hecta Attack (Small)",
				"Allows you to perform seven melee attacks with small weapons per round.",
				"You choose the 'Hecta Attack (Small)' perk. This allows you to make seven melee attacks with small weapons.");
		public static const Heroism:PerkType = mk("Heroism", "Heroism",
				"Allows you to deal double damage toward boss or gigant sized enemies.",
				"You choose the 'Heroism' perk. Due to your heroic stance you can now deal more damage toward boss or gigant type enemies.");
		public static const HexaAttack:PerkType = mk("Hexa Attack", "Hexa Attack",
				"Allows you to perform six melee attacks with non-large weapons per round.",
				"You choose the 'Hexa Attack' perk. This allows you to make six melee attacks with non-large weapons.");
		public static const HexaAttackSmall:PerkType = mk("Hexa Attack (Small)", "Hexa Attack (Small)",
				"Allows you to perform six melee attacks with small weapons per round.",
				"You choose the 'Hexa Attack (Small)' perk. This allows you to make six melee attacks with small weapons.");
		public static const HiddenDualMomentum:PerkType = mk("Hidden Dual Momentum", "Hidden Dual Momentum",
				"You've trained in using your speed to enhance power of your dual large weapons swings.",
				"You choose 'Hidden Dual Momentum' perk, allowing to use your speed to enhance power of your attacks with dual large weapons.");
		public static const HiddenMomentum:PerkType = mk("Hidden Momentum", "Hidden Momentum",
				"You've trained in using your speed to enhance power of your single large weapons swings.",
				"You choose 'Hidden Momentum' perk, allowing to use your speed to enhance power of your attacks with single large weapons.");
		public static const HighVoltage:PerkType = mk("High Voltage", "High Voltage",
				"Cumulative 20% damage increase for every subsequent lightning spell without interruption.",
				"You choose the 'High Voltage' perk. Cumulative 20% damage increase for every subsequent lightning spell without interruption.");
		public static const HinezumiBurningBlood:PerkType = mk("Hinezumi burning blood", "Hinezumi burning blood",
				"Increase the healing from the cauterize ability by 0.5% and raise Blazing battle spirit duration by 1 round.",
				"You choose the 'Hinezumi burning blood' perk, increasing the healing from the cauterize ability by 0.5% and raising Blazing battle spirit duration by 1 round.");
		public static const HinezumiBurningBloodEvolved:PerkType = mk("Hinezumi burning blood (Evolved)", "Hinezumi burning blood (Evolved)",
				"Increase the healing from the cauterize ability by 0.5% and raising Blazing battle spirit duration by 2 rounds.",
				"You choose the 'Hinezumi burning blood (Evolved)' perk, increasing the healing from the cauterize ability by 0.5% and raising Blazing battle spirit duration by 2 rounds.");
		public static const HinezumiBurningBloodFinalForm:PerkType = mk("Hinezumi burning blood (Final Form)", "Hinezumi burning blood (Final Form)",
				"Increase the healing from the cauterize ability by 0.5%, raising Blazing battle spirit duration by 7 rounds, slight increased toughness (+10 * NG tier to max Tou) and allowing to use cauterize even wihtout been Hinezumi.",
				"You choose the 'Hinezumi burning blood (Final Form)' perk, increasing the healing from the cauterize ability by 0.5%, raising Blazing battle spirit duration by 7 rounds, slight increased toughness and ability to use cauterize always.");
		public static const Hoarder:PerkType = mk("Hoarder", "Hoarder",
				"That's what you are, a hoarder. I bet you don't even spend the money. Sleep well at night knowing you're ruining the economy... while you take more money after each victory. (15% more gems from victories)",
				"You choose the 'Hoarder' perk, increasing gem gains from victories by 15%.");
		public static const HoldWithBothHands:PerkType = mk("Hold With Both Hands", "Hold With Both Hands",
				"Gain +20% strength modifier with melee weapons when not using a shield.",
				"You choose the 'Hold With Both Hands' perk.  As long as you're wielding a melee weapon and you're not using a shield, you gain 20% strength modifier to damage.");
		public static const HollowFangs:PerkType = mk("Hollow Fangs", "Hollow Fangs",
				"Your fangs and mouth started to slowly change showing rudimental ability to suck out fluids like blood. (+5 max stack of Vampire Thirst)",
				"You choose the 'Hollow Fangs' perk. Due to often feeding on fluids like blood your mouth started to adapt to such feeding style.");
		public static const HollowFangsEvolved:PerkType = mk("Hollow Fangs (Evolved)", "Hollow Fangs (Evolved)",
				"Your ability to suck substances like blood have developed halfway. (+5 max stack of Vampire Thirst, +3% more healed from Vampire Bite)",
				"You choose the 'Hollow Fangs (Evolved)' perk, changes to your mouth and tissues around progressing.");
		public static const HollowFangsFinalForm:PerkType = mk("Hollow Fangs (Final Form)", "Hollow Fangs (Final Form)",
				"You can now freely feed on blood and other atypical fluids. (+5 max stack of Vampire Thirst, +7% more healed from Vampire Bite, each Vampire Bite giving 2 stacks and deal +50% lust dmg)",
				"You choose the 'Hollow Fangs (Final Form)' perk, you are well prepared to feed on substances like blood now.");
		public static const HotBlooded:PerkType = mk("Hot Blooded", "Hot Blooded",
				"Raises minimum lust by 20.",
				"You choose the 'Hot Blooded' perk.  As a result of your enhanced libido, your lust no longer drops below 20!");
		public static const ImmovableObject:PerkType = mk("Immovable Object", "Immovable Object",
				"[if(player.tou>=75)" +
						"Grants 10% physical damage reduction.</b>" +
						"|" +
						"<b>You aren't tough enough to benefit from this anymore.</b>" +
						"]",
				"You choose the 'Immovable Object' perk, granting 10% physical damage reduction.</b>");
		public static const Impale:PerkType = mk("Impale", "Impale",
				"Damage bonus of spears and lances critical hits is doubled as long your speed is high enough.",
				"You've chosen the 'Impale' perk. Your spear and lance critical hit attacks bonus damages are doubled.");
		public static const ImprovedBrawn:PerkType = mk("Improved Brawn", "Improved Brawn",
				"You have improved your striking power. (+15% to phantom Str bonus, +10% to unarmed atk)",
				"You choose the 'Improved Brawn' perk, improving your striking power. (+15% to phantom Str bonus, +10% to unarmed atk)");
		public static const ImprovedBrute:PerkType = mk("Improved Brute", "Improved Brute",
				"You have improved your striking strength. (add 40 pts of phantom Str (scalable))",
				"You choose the 'Improved Brute' perk, improving your striking strength. (add 40 pts of phantom Str (scalable))");
		public static const ImprovedCrinosShape:PerkType = mk("Improved Crinos Shape", "Improved Crinos Shape",
				"Crinos Shape increase to physical might rise to 40% of str/tou/spe.",
				"You choose the 'Improved Crinos Shape' perk, increasing boost recived by using Crinos Shape (+40%).");
		public static const ImprovedDiehard:PerkType = mk("Improved Diehard", "Improved Diehard",
				"You can't loose by HP until reaching droping into negative health larger than 4% of max HP + 400(scalable). HP limit cumulative with other Diehard perks.",
				"You choose the 'Improved Diehard' perk, increasing limit on how long you can fight.");
		public static const ImprovedEndurance:PerkType = mk("Improved Endurance", "Improved Endurance",
				"Increases maximum fatigue by 80.",
				"You choose the 'Improved Endurance' perk. Thanks to your improved physical conditioning, your maximum fatigue has been increased by 80!");
		public static const ImprovedEvade:PerkType = mk("Improved Evade", "Improved Evade",
				"Increases chances of evading enemy attacks. (+10% to evasion)",
				"You choose the 'Improved Evade' perk, allowing you to avoid enemy attacks more often! (+10% to evasion)");
		public static const ImprovedLifeline:PerkType = mk("Improved Lifeline", "Improved Lifeline",
				"Increases self healing by 120 out of combat and by 60 in combat (using defend option will double it).",
				"You choose the 'Improved Lifeline' perk, improving your self healing.");
		public static const ImprovedSelfControl:PerkType = mk("Improved Self-Control", "Improved Self-Control",
				"Increases maximum lust by 40.",
				"You choose the 'Improved Self-Control' perk. Thanks to your improved mental conditioning, your maximum lust has been increased by 40!");
		public static const ImprovedSpirituality:PerkType = mk("Improved Spirituality", "Improved Spirituality",
				"Increases maximum mana by 80.",
				"You choose the 'Improved Spirituality' perk. Thanks to your improved mystical conditioning, your maximum mana has been increased by 120!");
		public static const ImprovedTranquilness:PerkType = mk("Improved Tranquilness", "Improved Tranquilness",
				"Increases maximum wrath by 40.",
				"You choose the 'Improved Tranquilness' perk. Thanks to your improved anger managment training, your maximum wrath has been increased by 40!");
		public static const ImprovingNaturesBlueprintsNaturalArmor:PerkType = mk("Improving Nature's Blueprints (Natural Armor)", "Improving Nature's Blueprints (Natural Armor)",
				"Charge Armor can be casted even if PC is not wearing any armor as long it have any form of natural armor (any skin type providing bonus to armor) and slight boost armor while under Crinos Shape effects.",
				"You choose the 'Improving Nature's Blueprints (Natural Armor)' perk, allowing you to use Charge Armor even without wearing any weapon and slight boost armor when using Crinos Shape.");
		public static const ImprovingNaturesBlueprintsNaturalWeapons:PerkType = mk("Improving Nature's Blueprints (Natural Weapons)", "Improving Nature's Blueprints (Natural Weapons)",
				"Charge Weapon can be cast whenever PC hold any weapon or merely using bare fists. And slight boost unarmed attacks while under Crinos Shape effects.",
				"You choose the 'Improving Nature's Blueprints (Natural Weapons)' perk, allowing you to use Charge Weapon even without holding any weapon and slight boost unarmed attacks when using Crinos Shape.");
		public static const ImprovingNaturesBlueprintsApexPredator:PerkType = mk("Improving Nature's Blueprints (Apex Predator)", "Improving Nature's Blueprints (Apex Predator)",
				"Changing negative bonuses to max Int and Wis from Job: Beast Warrior is the same value positive bonuses. While using Crinos shape increasing natural regeneration by 2% of max HP per turn. (+10 to max int/wis - scalable)",
				"You choose the 'Improving Nature's Blueprints (Apex Predator)' perk, allowing you to become an Apex Predator that isn't dull and slow witted along with increased regeneration while using Crinos Shape.");
		public static const InControl:PerkType = mk("In Control", "In Control",
				"You are in control of your desires, that's it... except another 10% soul force gain.",
				"You choose the 'In Control' perk, gaining +10% max Soulforce.");
		public static const InhumanDesireI:PerkType = mk("Inhuman Desire I", "Inhuman Desire I",
				"Raises max LP by 20.",
				"You choose the 'Inhuman Desire I' perk, giving you an additional 20 LP!");
		public static const InhumanDesireII:PerkType = mk("Inhuman Desire II", "Inhuman Desire II",
				"Raises max LP by 20.",
				"You choose the 'Inhuman Desire II' perk, giving you an additional 20 LP!");
		public static const InhumanDesireIII:PerkType = mk("Inhuman Desire III", "Inhuman Desire III",
				"Raises max LP by 20.",
				"You choose the 'Inhuman Desire III' perk, giving you an additional 20 LP!");
		public static const InhumanDesireIV:PerkType = mk("Inhuman Desire IV", "Inhuman Desire IV",
				"Raises max LP by 20.",
				"You choose the 'Inhuman Desire IV' perk, giving you an additional 20 LP!");
		public static const InhumanDesireV:PerkType = mk("Inhuman Desire V", "Inhuman Desire V",
				"Raises max LP by 20.",
				"You choose the 'Inhuman Desire V' perk, giving you an additional 20 LP!");
		public static const InhumanDesireVI:PerkType = mk("Inhuman Desire VI", "Inhuman Desire VI",
				"Raises max LP by 20.",
				"You choose the 'Inhuman Desire VI' perk, giving you an additional 20 LP!");
		public static const InhumanEndurance:PerkType = mk("Inhuman Endurance", "Inhuman Endurance",
				"Increases maximum fatigue by 2000.",
				"You choose the 'Inhuman Endurance' perk. Thanks to your inhuman physical conditioning, your maximum fatigue has been increased by 2000!");
		public static const InhumanSelfControl:PerkType = mk("Inhuman Self-Control", "Inhuman Self-Control",
				"Increases maximum lust by 1000.",
				"You choose the 'Inhuman Self-Control' perk. Thanks to your inhuman mental conditioning, your maximum lust has been increased by 1000!");
		public static const InhumanSpirituality:PerkType = mk("Inhuman Spirituality", "Inhuman Spirituality",
				"Increases maximum mana by 3000.",
				"You choose the 'Inhuman Spirituality' perk. Thanks to your inhuman mystical conditioning, your maximum mana has been increased by 3000!");
		public static const InhumanTranquilness:PerkType = mk("Inhuman Tranquilness", "Inhuman Tranquilness",
				"Increases maximum wrath by 1000.",
				"You choose the 'Inhuman Tranquilness' perk. Thanks to your inhuman anger managment training, your maximum wrath has been increased by 1000!");
		public static const InsightfulResourcesI:PerkType = mk("Insightful Resources I", "Insightful Resources I",
				"+5 extra soulforce per point of wisdom.",
				"You choose the 'Insightful Resources I' perk, granting +5 extra maximum soulforce for each point of wisdom.");
		public static const InsightfulResourcesII:PerkType = mk("Insightful Resources II", "Insightful Resources II",
				"+5 extra soulforce per point of wisdom.",
				"You choose the 'Insightful Resources II' perk, granting +5 extra maximum soulforce for each point of wisdom.");
		public static const InsightfulResourcesIII:PerkType = mk("Insightful Resources III", "Insightful Resources III",
				"+5 extra soulforce per point of wisdom.",
				"You choose the 'Insightful Resources III' perk, granting +5 extra maximum soulforce for each point of wisdom.");
		public static const InsightfulResourcesIV:PerkType = mk("Insightful Resources IV", "Insightful Resources IV",
				"+5 extra soulforce per point of wisdom.",
				"You choose the 'Insightful Resources IV' perk, granting +5 extra maximum soulforce for each point of wisdom.");
		public static const InsightfulResourcesV:PerkType = mk("Insightful Resources V", "Insightful Resources V",
				"+5 extra soulforce per point of wisdom.",
				"You choose the 'Insightful Resources V' perk, granting +5 extra maximum soulforce for each point of wisdom.");
		public static const InsightfulResourcesVI:PerkType = mk("Insightful Resources VI", "Insightful Resources VI",
				"+5 extra soulforce per point of wisdom.",
				"You choose the 'Insightful Resources VI' perk, granting +5 extra maximum soulforce for each point of wisdom.");
		public static const IntermediateAllRounderEducation:PerkType = mk("Intermediate All-Rounder Education", "Intermediate All-Rounder Education",
				"Limit of advanced job you can learn is increased by 3.",
				"You choose the 'Intermediate All-Rounder Education' perk, expanding amount of advanced jobs you can learn. (+3)");
		public static const IronFistsI:PerkType = mk("Iron Fists I", "Iron Fists I",
				"Hardens your fists to increase attack rating by 10.",
				"You choose the 'Iron Fists I' perk, hardening your fists. This increases attack power by 10.");
		public static const IronFistsII:PerkType = mk("Iron Fists II", "Iron Fists II",
				"Further hardens your fists to increase attack rating by another 10.",
				"You choose the 'Iron Fists II' perk, further hardening your fists. This increases attack power by another 10.");
		public static const IronFistsIII:PerkType = mk("Iron Fists III", "Iron Fists III",
				"Even more hardens your fists to increase attack rating again by 10.",
				"You choose the 'Iron Fists III' perk, even further hardening your fists. This increases attack power again by 10.");				
		public static const IronFistsIV:PerkType = mk("Iron Fists IV", "Iron Fists IV",
				"Next training to harden your fists increased their attack rating by 10.",
				"You choose the 'Iron Fists IV' perk, again hardening your fists. This increases attack power for another 10.");
		public static const IronFistsV:PerkType = mk("Iron Fists V", "Iron Fists V",
				"Almost hellish training increeased your fists attack rating by another 10.",
				"You choose the 'Iron Fists V' perk, to once again make your first more tough. This increases attack power once more for 10.");
		public static const IronFistsVI:PerkType = mk("Iron Fists VI", "Iron Fists VI",
				"Another round of almost hellish taining increeased your fists attack rating by another 10.",
				"You choose the 'Iron Fists VI' perk, to again make your first tougher. This increases attack power again for 10.");
		public static const IronMan:PerkType = mk("Iron Man", "Iron Man",
				"Reduces the fatigue cost of physical specials by 50%.",
				"You choose the 'Iron Man' perk, reducing the fatigue cost of physical special attacks by 50%");
		public static const IronStomach:PerkType = mk("Iron Stomach", "Iron Stomach",
				"Increase max Satiety by 50 and limit when PC gain weight from eating too much by 5.",
				"You choose the 'Iron Stomach' perk, increasing your limit for eating without getting fat.");
		public static const IronStomachEx:PerkType = mk("Iron Stomach (Ex)", "Iron Stomach (Ex)",
				"Increase max Satiety by 100 and limit when PC gain weight from eating too much by another 10.",
				"You choose the 'Iron Stomach (Ex)' perk, getting second increase to maximum amount of food you can eat before you start to getting fat.");
		public static const IronStomachSu:PerkType = mk("Iron Stomach (Su)", "Iron Stomach (Su)",
				"Increase max Satiety by 200, limit when PC gain weight from eating too much by another 15 and max toughness by 5 (scalable).",
				"You choose the 'Iron Stomach (Su)' perk, making yourself capable to eat more without getting overweigh.");
		/*public static const IronStomach:PerkType = mk("Iron Stomach", "Iron Stomach",
				"Reduces the fatigue cost of physical specials by 50%.",
				"You choose the 'Iron Stomach' perk, reducing the fatigue cost of physical special attacks by 50%");*/
		public static const JobAllRounder:PerkType = mk("Job: All-Rounder", "Job: All-Rounder",
				"You've combined all basic jobs training effects into an all-round fighting style. (+10 to max str/tou/spe/int/wis, +6 to max lib/sens - scalable)",
				"You choose 'Job: All-Rounder' perk, to combine effects of training in all six basic jobs.");
		public static const JobBeastWarrior:PerkType = mk("Job: Beast Warrior", "Job: Beast Warrior",
				"You've trained in use of your own body to it limits in fights. (+5 to max str/tou/spe, -5 to max int/wis - scalable)",
				"You choose 'Job: Beast Warrior' perk, training yourself to became Beast Warrior.");
		public static const JobBrawler:PerkType = mk("Job: Brawler", "Job: Brawler",
				"You've trained in unarmed combat. (+10 to max str - scalable)",
				"You choose 'Job: Brawler' perk, training yourself to became Brawler.");
		public static const JobCourtesan:PerkType = mk("Job: Courtesan", "Job: Courtesan",
				"You've mastered all various uses of tease. (+15 to max lib - scalable)",
				"You choose 'Job: Courtesan' perk, training yourself to became Courtesan.");
		public static const JobDefender:PerkType = mk("Job: Defender", "Job: Defender",
				"You've trained in withstanding even the heaviest attacks head on. (+15 to max tou - scalable)",
				"You choose 'Job: Defender' perk, training yourself to became Defender.");
		public static const JobDervish:PerkType = mk("Job: Dervish", "Job: Dervish",
				"You've trained in multi meele attacks combat and using of medium sized dual weapons. (+10 to max spe - scalable)",
				"You choose 'Job: Dervish' perk, training yourself to became Dervish.");
		public static const JobElementalConjurer:PerkType = mk("Job: Elemental Conjurer", "Job: Elemental Conjurer",
				"You've trained in summoning various types of elementals. (+5 to max wis - scalable)",
				"You choose 'Job: Elemental Conjurer' perk, training yourself to call elementals.");
		public static const JobEnchanter:PerkType = mk("Job: Enchanter", "Job: Enchanter",
				"You've trained in casting empowered buffs. (+15 to max int - scalable)",
				"You choose 'Job: Enchanter' perk, training yourself to became Enchanter.");
		public static const JobEromancer:PerkType = mk("Job: Eromancer", "Job: Eromancer",
				"You've mastered the power of erotic magics. (+5 to max int/lib - scalable)",
				"You choose 'Job: Eromancer' perk, training yourself to became Eromancer.");
		public static const JobGolemancer:PerkType = mk("Job: Golemancer", "Job: Golemancer",
				"You've mastered the art of making golems. (+5 to max int/wis - scalable)",
				"You choose 'Job: Golemancer' perk, training yourself to became golems maker.");
		public static const JobGuardian:PerkType = mk("Job: Guardian", "Job: Guardian",
				"You've trained in defensive combat. (+5 to max tou - scalable)",
				"You choose 'Job: Guardian' perk, training yourself to became Guardian.");
		public static const JobGunslinger:PerkType = mk("Job: Gunslinger", "Job: Gunslinger",
				"You've trained in ranged combat using firearms. (+10 to max wis - scalable)",
				"You choose 'Job: Gunslinger' perk, training yourself to became Gunslinger.");
		public static const JobHealer:PerkType = mk("Job: Healer", "Job: Healer",
				"You've trained in using more effectively heal spells and effects. (+5 to max int/wis - scalable)",
				"You choose 'Job: Healer' perk, training yourself to became Healer.");
		public static const JobHunter:PerkType = mk("Job: Hunter", "Job: Hunter",
				"You've trained in combat with traditional range weapons (like bows). (+10 to max spe, +5 to max int - scalable)",
				"You choose 'Job: Hunter' perk, training yourself to became Hunter.");
		public static const JobKnight:PerkType = mk("Job: Knight", "Job: Knight",
				"You've trained in combat using shields and heaviest armors. (+10 to max tou - scalable)",
				"You choose 'Job: Knight' perk, training yourself to became Knight.");
		public static const JobMonk:PerkType = mk("Job: Monk", "Job: Monk",
				"You've trained in unarmed combat. (+15 to max wis - scalable)",
				"You choose 'Job: Monk' perk, training yourself to became Monk.");
		public static const JobRanger:PerkType = mk("Job: Ranger", "Job: Ranger",
				"You've trained in ranged combat. (+5 to max spe - scalable)",
				"You choose 'Job: Ranger' perk, training yourself to became Ranger.");
		public static const JobRogue:PerkType = mk("Job: Rogue", "Job: Rogue",
				"You've trained in how to strike at your opponent's vital points and use various deadly tricks. (+5 to max str/spe - scalable)",
				"You choose 'Job: Rogue' perk, training yourself to became Rogue.");
		public static const JobSeducer:PerkType = mk("Job: Seducer", "Job: Seducer",
				"You've trained the art of seduction. (+5 to max lib - scalable)",
				"You choose 'Job: Seducer' perk, training yourself to became Seducer.");
		public static const JobSorcerer:PerkType = mk("Job: Sorcerer", "Job: Sorcerer",
				"You've trained in magic combat. (+5 to max int - scalable)",
				"You choose 'Job: Sorcerer' perk, training yourself to became Sorcerer.");
		public static const JobSoulCultivator:PerkType = mk("Job: Soul Cultivator", "Job: Soul Cultivator",
				"You've cultivated powers of your soul. (+5 to max wis - scalable)",
				"You choose the 'Job: Soul Cultivator' perk, starting journey of the soul cultivation path!");
		public static const JobSwordsman:PerkType = mk("Job: Swordsman", "Job: Swordsman",
				"You've trained in using large weapons in fights. (+10 to max str - scalable)",
				"You choose 'Job: Swordsman' perk, training yourself to became Swordsman.");
		public static const JobWarlord:PerkType = mk("Job: Warlord", "Job: Warlord",
				"You've trained in combat against group of enemies. (+20 to max tou - scalable)",
				"You choose 'Job: Warlord' perk, training yourself to became Warlord.");
		public static const JobWarrior:PerkType = mk("Job: Warrior", "Job: Warrior",
				"You've trained in melee combat. (+5 to max str - scalable)",
				"You choose 'Job: Warrior' perk, training yourself to became Warrior.");
		public static const Juggernaut:PerkType = mk("Juggernaut", "Juggernaut",
				"When wearing heavy armor, you have extra 10% damage resistance and are immune to damage from being constricted/squeezed (req. 100+ tou).",
				"You choose the 'Juggernaut' perk, granting extra 10% damage resistance when wearing heavy armor and immunity to damage from been constricted/squeezed.");
		public static const KitsuneThyroidGland:PerkType = mk("Kitsune Thyroid Gland", "Kitsune Thyroid Gland",
				"Kitsune Thyroid Gland lower cooldowns for Illusion and Terror by three turns, increase speed of the recovery after using magic and slightly boost PC speed.",
				"You choose the 'Kitsune Thyroid Gland' perk. Some time after you become kitsune part of your body changed allowing to boost your kitsune powers.");
		public static const KitsuneThyroidGlandEvolved:PerkType = mk("Kitsune Thyroid Gland (Evolved)", "Kitsune Thyroid Gland (Evolved)",
				"Kitsune Thyroid Gland (Evolved) increase speed of the recovery after using magic, boost PC speed and wisdom. And make fox fire specials 50% stronger when having 9 tails (both fire and lust damage).",
				"You choose the 'Kitsune Thyroid Gland (Evolved)' perk. Continued using of kitsune powers caused your thyroid gland to evolve.");
		public static const KitsuneThyroidGlandFinalForm:PerkType = mk("Kitsune Thyroid Gland (Final Form)", "Kitsune Thyroid Gland (Final Form)",
				"Kitsune Thyroid Gland (Final Form) grant bonus soulforce/mana regen depending on Star Sphere rank, increase max Star Sphere rank to 20. Increase speed debuff of Terror to 50, increase evasion boost from Illusion to 20%. Boost PC speed, wisdom and intelligence.",
				"You choose the 'Kitsune Thyroid Gland (Final Form)' perk. Your thyroid gland to evolved once again increasing efficiency of your kitsune powers.");
		public static const LactaBovinaOvaries:PerkType = mk("Lacta Bovina Ovaries", "Lacta Bovina Ovaries",
				"Allow keep Milk Blast special even if cow score is lower than 9. Additionaly your max Lust increase by 10.",
				"You choose the 'Lacta Bovina Ovaries' perk. Interaction between pernament body alteration from Bimbo Liquer (maybe Bro Brew too) and your cow-like nature allows you to keep cow racial special even if you stop been cow-like.");
		public static const LactaBovinaOvariesEvolved:PerkType = mk("Lacta Bovina Ovaries (Evolved)", "Lacta Bovina Ovaries (Evolved)",
				"+5% to lust resistance, increase lactation output by 200 mLs and +10 to max libido.",
				"You choose the 'Lacta Bovina Ovaries (Evolved)' perk. Granting more lust resistance, increase slight lactation output and boost to max libido.");
		public static const LactaBovinaOvariesFinalForm:PerkType = mk("Lacta Bovina Ovaries (Final Form)", "Lacta Bovina Ovaries (Final Form)",
				"+5 to max tou an +10 to max str/lib, increase milk production by ~100%, +90 to max lust and Milk Blast cost rise to 200 lust but can be used more than once per fight.",
				"You choose the 'Lacta Bovina Ovaries (Final Form)' perk. Granting boost to max speed/libido/lust, increase milk output and allowing using Milk Blast more than once per fight.");
		public static const LadyGodivasFavoriteChild:PerkType = mk("Lady Godiva's favorite Child", "Lady Godiva's favorite Child",
				"That's the source of your fortune... not only are you her child... but you're also her favorite... take your bonus and leave me alone while I wallow in my moneyless despair... meanie (More money upon victory because the writer began to sulk). (15% more gems from victories)",
				"You choose the 'Lady Godiva's favorite Child' perk, increasing gem gains from victories by 15%.");
		public static const Lazy:PerkType = mk("LAZY!!!", "LAZY!!!",
				"Sample Text Here/+20% fatigue recovery rate",
				"You choose the 'LAZY!!!' perk, gaining +20% fatigue recovery rate.");
		public static const LegendaryBrawn:PerkType = mk("Legendary Brawn", "Legendary Brawn",
				"You have improved your striking power to epic level. (+30% to phantom Str bonus, +25% to unarmed atk)",
				"You choose the 'Legendary Brawn' perk, improving your striking power to epic level. (+30% to phantom Str bonus, +25% to unarmed atk)");
		public static const LegendaryBrute:PerkType = mk("Legendary Brute", "Legendary Brute",
				"You have improved your striking strength to epic level. (add 100 pts of phantom Str (scalable))",
				"You choose the 'Legendary Brute' perk, improving your striking strength to epic level. (add 100 pts of phantom Str (scalable))");
		public static const LegendaryEndurance:PerkType = mk("Legendary Endurance", "Legendary Endurance",
				"Increases maximum fatigue by 10000.",
				"You choose the 'Legendary Endurance' perk. Thanks to your legendary physical conditioning, your maximum fatigue has been increased by 10000!");
		public static const LegendaryGolemMaker:PerkType = mk("Legendary Golem Maker", "Legendary Golem Maker",
				"Your proficiency in making golems allows to make stronger than before golems and slightly rise your intelligence and wisdom.",
				"You choose 'Legendary Golem Maker' perk, increasing your proficiency in making golems.");
		public static const LegendaryIntelligence:PerkType = mk("Legendary Intelligence", "Legendary Intelligence",
				"Increases maximum intelligence by 50 + 10 * NG tier.",
				"You choose the 'Legendary Intelligence' perk. Increases wisdom intelligence by 50 + 10 * NG tier.");
		public static const LegendaryLibido:PerkType = mk("Legendary Libido", "Legendary Libido",
				"Increases maximum libido by 50 + 10 * NG tier.",
				"You choose the 'Legendary Libido' perk. Increases maximum libido by 50 + 10 * NG tier.");
		public static const LegendarySelfControl:PerkType = mk("Legendary Self-Control", "Legendary Self-Control",
				"Increases maximum lust by 5000.",
				"You choose the 'Legendary Self-Control' perk. Thanks to your legendary mental conditioning, your maximum lust has been increased by 5000!");
		public static const LegendarySensitivity:PerkType = mk("Legendary Sensitivity", "Legendary Sensitivity",
				"Increases maximum sensitivity by 50 + 10 * NG tier.",
				"You choose the 'Legendary Sensitivity' perk. Increases maximum sensitivity by 50 + 10 * NG tier.");
		public static const LegendarySpeed:PerkType = mk("Legendary Speed", "Legendary Speed",
				"Increases maximum speed by 50 + 10 * NG tier.",
				"You choose the 'Legendary Speed' perk. Increases speed by 50 + 10 * NG tier.");
		public static const LegendarySpirituality:PerkType = mk("Legendary Spirituality", "Legendary Spirituality",
				"Increases maximum mana by 15000.",
				"You choose the 'Legendary Spirituality' perk. Thanks to your legendary mystical conditioning, your maximum mana has been increased by 15000!");
		public static const LegendaryStrength:PerkType = mk("Legendary Strength", "Legendary Strength",
				"Increases maximum strength by 50 + 10 * NG tier.",
				"You choose the 'Legendary Strength' perk. Increases strength libido by 50 + 10 * NG tier.");
		public static const LegendaryToughness:PerkType = mk("Legendary Toughness", "Legendary Toughness",
				"Increases maximum toughness by 50 + 10 * NG tier.",
				"You choose the 'Legendary Toughness' perk. Increases toughness by 50 + 10 * NG tier.");
		public static const LegendaryTranquilness:PerkType = mk("Legendary Tranquilness", "Legendary Tranquilness",
				"Increases maximum wrath by 5000.",
				"You choose the 'Legendary Tranquilness' perk. Thanks to your legendary anger managment training, your maximum wrath has been increased by 5000!");
		public static const LegendaryWisdom:PerkType = mk("Legendary Wisdom", "Legendary Wisdom",
				"Increases maximum wisdom by 50 + 10 * NG tier.",
				"You choose the 'Legendary Wisdom' perk. Increases wisdom libido by 50 + 10 * NG tier.");
		public static const Lifeline:PerkType = mk("Lifeline", "Lifeline",
				"Increases self healing by 90 out of combat and by 45 in combat (using defend option will double it).",
				"You choose the 'Lifeline' perk, increasing your self healing.");
		public static const LightningStrikes:PerkType = mk("Lightning Strikes", "Lightning Strikes",
				"[if(player.spe>=60)" +
						"Increases the attack damage for non-heavy/non-small weapons.</b>" +
						"|" +
						"<b>You are too slow to benefit from this perk.</b>" +
						"]",
				"You choose the 'Lightning Strikes' perk, increasing the attack damage for non-heavy/non-small weapons.</b>");
		public static const LimitBreakerBody1stStage:PerkType = mk("Limit Breaker: Body (1st stage)", "Limit Breaker: Body (1st stage)",
				"Breaking your limits for 'body' for the first time grants you +5% max HP and Wrath.",
				"You choose the 'Limit Breaker: Body (1st stage)' perk, breaking your limits for 'body' for the first time. (+5% max HP and Wrath)");
		public static const LimitBreakerFlesh1stStage:PerkType = mk("Limit Breaker: Flesh (1st stage)", "Limit Breaker: Flesh (1st stage)",
				"Breaking your limits for 'flesh' for the first time grants you +10 to max Str, Tou, Spe (scalable).",
				"You choose the 'Limit Breaker: Flesh (1st stage)' perk, breaking your limits for 'flesh' for the first time. (+10 to max Str, Tou, Spe (scalable))");
		public static const LimitBreakerHeart1stStage:PerkType = mk("Limit Breaker: Heart (1st stage)", "Limit Breaker: Heart (1st stage)",
				"Breaking your limits for 'heart' for the first time grants you +5% max Lust and Fatigue.",
				"You choose the 'Limit Breaker: Heart (1st stage)' perk, breaking your limits for 'heart' for the first time. (+5% max Lust and Fatigue)");
		public static const LimitBreakerPsyche1stStage:PerkType = mk("Limit Breaker: Psyche (1st stage)", "Limit Breaker: Psyche (1st stage)",
				"Breaking your limits for 'psyche' for the first time grants you +10 to max Int, Wis, Lib, Sens (scalable).",
				"You choose the 'Limit Breaker: Psyche (1st stage)' perk, breaking your limits for 'psyche' for the first time. (+10 to max Int, Wis, Lib, Sens (scalable))");
		public static const LimitBreakerSoul1stStage:PerkType = mk("Limit Breaker: Soul (1st stage)", "Limit Breaker: Soul (1st stage)",
				"Breaking your limits for 'soul' for the first time grants you +5% max Mana and Soulforce.",
				"You choose the 'Limit Breaker: Soul (1st stage)' perk, breaking your limits for 'soul' for the first time. (+5% max Mana and Soulforce)");
		public static const LimitBreakerBody2ndStage:PerkType = mk("Limit Breaker: Body (2nd stage)", "Limit Breaker: Body (2nd stage)",
				"Breaking your limits for 'body' for the second time grants you +10% max HP and Wrath.",
				"You choose the 'Limit Breaker: Body (2nd stage)' perk, breaking your limits for 'body' for the second time. (+10% max HP and Wrath)");
		public static const LimitBreakerFlesh2ndStage:PerkType = mk("Limit Breaker: Flesh (2nd stage)", "Limit Breaker: Flesh (2nd stage)",
				"Breaking your limits for 'flesh' for the second time grants you +20 to max Str, Tou, Spe (scalable).",
				"You choose the 'Limit Breaker: Flesh (2nd stage)' perk, breaking your limits for 'flesh' for the second time. (+20 to max Str, Tou, Spe (scalable))");
		public static const LimitBreakerHeart2ndStage:PerkType = mk("Limit Breaker: Heart (2nd stage)", "Limit Breaker: Heart (2nd stage)",
				"Breaking your limits for 'heart' for the second time grants you +10% max Lust and Fatigue.",
				"You choose the 'Limit Breaker: Heart (2nd stage)' perk, breaking your limits for 'heart' for the second time. (+10% max Lust and Fatigue)");
		public static const LimitBreakerPsyche2ndStage:PerkType = mk("Limit Breaker: Psyche (2nd stage)", "Limit Breaker: Psyche (2nd stage)",
				"Breaking your limits for 'psyche' for the second time grants you +20 to max Int, Wis, Lib, Sens (scalable).",
				"You choose the 'Limit Breaker: Psyche (2nd stage)' perk, breaking your limits for 'psyche' for the second time. (+20 to max Int, Wis, Lib, Sens (scalable))");
		public static const LimitBreakerSoul2ndStage:PerkType = mk("Limit Breaker: Soul (2nd stage)", "Limit Breaker: Soul (2nd stage)",
				"Breaking your limits for 'soul' for the second time grants you +10% max Mana and Soulforce.",
				"You choose the 'Limit Breaker: Soul (2nd stage)' perk, breaking your limits for 'soul' for the second time. (+10% max Mana and Soulforce)");
		public static const LizanMarrow:PerkType = mk("Lizan Marrow", "Lizan Marrow",
				"Regenerates 0.5% of HP per round in combat and 1% of HP per hour. Additionaly your limit for innate self-regeneration rate increased.",
				"You choose the 'Lizan Marrow' perk. Constant regenerating your body caused pernamently change to your body marrow.");
		public static const LizanMarrowEvolved:PerkType = mk("Lizan Marrow (Evolved)", "Lizan Marrow (Evolved)",
				"Regenerates 1% of HP per round in combat and 2% of HP per hour. Additionaly your limit for innate self-regeneration rate increased.",
				"You choose the 'Lizan Marrow (Evolved)' perk. Constant use of your lizan marrow caused it to change.");
		public static const LongerLastingBuffsI:PerkType = mk("Long(er) Lasting Buffs I", "Long(er) Lasting Buffs I",
				"Buff spells last 1 turn longer.",
				"You choose the 'Long(er) Lasting Buffs I' perk. Constant use of buffs allowed you to optimize them a little bit.");
		public static const LongerLastingBuffsII:PerkType = mk("Long(er) Lasting Buffs II", "Long(er) Lasting Buffs II",
				"Buff spells last 1 turn longer.",
				"You choose the 'Long(er) Lasting Buffs II' perk. Constant use of buffs allowed you to optimize them a little bit.");
		public static const LongerLastingBuffsIII:PerkType = mk("Long(er) Lasting Buffs III", "Long(er) Lasting Buffs III",
				"Buff spells last 1 turn longer.",
				"You choose the 'Long(er) Lasting Buffs III' perk. Constant use of buffs allowed you to optimize them a little bit.");
		public static const LongerLastingBuffsIV:PerkType = mk("Long(er) Lasting Buffs IV", "Long(er) Lasting Buffs IV",
				"Buff spells last 1 turn longer.",
				"You choose the 'Long(er) Lasting Buffs IV' perk. Constant use of buffs allowed you to optimize them a little bit.");
		public static const LongerLastingBuffsV:PerkType = mk("Long(er) Lasting Buffs V", "Long(er) Lasting Buffs V",
				"Buff spells last 1 turn longer.",
				"You choose the 'Long(er) Lasting Buffs V' perk. Constant use of buffs allowed you to optimize them a little bit.");
		public static const LongerLastingBuffsVI:PerkType = mk("Long(er) Lasting Buffs VI", "Long(er) Lasting Buffs VI",
				"Buff spells last 1 turn longer.",
				"You choose the 'Long(er) Lasting Buffs VI' perk. Constant use of buffs allowed you to optimize them a little bit.");
		public static const Lucky:PerkType = mk("Lucky", "Lucky",
				"You just happen to stumble across money where ever you go, increasing the money gained upon victory. (15% more gems from victories)",
				"You choose the 'Lucky' perk, increasing gem gains from victories by 15%.");
		public static const LungingAttacks:PerkType = mk("Lunging Attacks", "Lunging Attacks",
				"[if(player.spe>=75)" +
						"Grants 50% armor penetration for standard attacks." +
						"|" +
						"<b>You are too slow to benefit from this perk.</b>" +
						"]",
				"You choose the 'Lunging Attacks' perk, granting 50% armor penetration for standard attacks.");
		public static const LyingDown:PerkType = mk("Lying Down", "Lying Down",
				"Sample Text Here/+20% fatigue recovery rate",
				"You choose the 'Lying Down' perk, gaining +20% fatigue recovery rate.");
		public static const Mage:PerkType = mk("Mage", "Mage",
				"[if (player.inte>=50)" +
						"Increases base spell strength by 10%, mana pool by 30 and lust bar by 5." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Mage' perk.  You are able to focus your magical abilities even more keenly, boosting your base spell effects by 10%, mana pool by 30 and lust bar by 5.");
		public static const MagicMetabolism:PerkType = mk("Magic Metabolism", "Magic Metabolism",
				"When your hunger level go down below 50, you start loosing mana (5:1 ratio for mana:hunger decay) instead of hunger when it should happen. If your mana is empty, hunger works as usual.",
				"You choose the 'Magic Metabolism' perk. If PC have enough mana can use it as way to keep hunger around 50 pts.");
		public static const MagiculesTheory:PerkType = mk("Magicules Theory", "Magicules Theory",
				"[if(player.wis>=50)" +
						"Increases magical critical hit chance by up to 10% (Wisdom-based)." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Magicules Theory' perk, increasing magical critical hit chance by up to 10% (Wisdom-based).");
		public static const MakeItDouble:PerkType = mk("Make it Double", "Make it Double",
				"Increased damage when using specials like Whirlwind/Whipping with dual weapons rather than single weapons.",
				"You choose the 'Make it Double' perk, allowing to make full use of dual weapons when using moves like whirlwind or whipping.");
		public static const ManaAffinityI:PerkType = mk("Mana Affinity I", "Mana Affinity I",
				"Raises max mana by 35 and regain it 20% faster.",
				"You choose the 'Mana Affinity I' perk, giving you an additional 35 mana and boosting it recovery rate.");
		public static const ManaAffinityII:PerkType = mk("Mana Affinity II", "Mana Affinity II",
				"Raises max mana by 35 and regain it 20% faster.",
				"You choose the 'Mana Affinity II' perk, giving you an additional 35 mana and boosting it recovery rate.");
		public static const ManaAffinityIII:PerkType = mk("Mana Affinity III", "Mana Affinity III",
				"Raises max mana by 35 and regain it 20% faster.",
				"You choose the 'Mana Affinity III' perk, giving you an additional 35 mana and boosting it recovery rate.");
		public static const ManaAffinityIV:PerkType = mk("Mana Affinity IV", "Mana Affinity IV",
				"Raises max mana by 35 and regain it 20% faster.",
				"You choose the 'Mana Affinity IV' perk, giving you an additional 35 mana and boosting it recovery rate.");
		public static const ManaAffinityV:PerkType = mk("Mana Affinity V", "Mana Affinity V",
				"Raises max mana by 35 and regain it 20% faster.",
				"You choose the 'Mana Affinity V' perk, giving you an additional 35 mana and boosting it recovery rate.");
		public static const ManaAffinityVI:PerkType = mk("Mana Affinity VI", "Mana Affinity VI",
				"Raises max mana by 35 and regain it 20% faster.",
				"You choose the 'Mana Affinity VI' perk, giving you an additional 35 mana and boosting it recovery rate.");
		public static const ManticoreMetabolism:PerkType = mk("Manticore Metabolism", "Manticore Metabolism",
				"Allows you to gain a boost of speed for a few hours after an intake of cum and allow attack twice with tail spike per turn.",
				"You choose the 'Manticore Metabolism' perk, allows you to gain a boost of speed after an intake of cum and allow atack more often with tail spike.");
		public static const ManticoreMetabolismEvolved:PerkType = mk("Manticore Metabolism (Evolved)", "Manticore Metabolism (Evolved)",
				"Increase by (10 * NG tier) boost of speed for a five hours longer after an intake of cum and increase max Hunger cap by 50 (if PC have Hunger bar active).",
				"You choose the 'Manticore Metabolism (Evolved)' perk, allows you to increase max boost of speed after an intake of cum and keeping it for 50% longer.");
		public static const MantislikeAgility:PerkType = mk("Mantis-like Agility", "Mantis-like Agility",
				"Your altered musculature allows to increase your natural agility and speed. If somehow you would have some type of natural armor or even thicker skin this increase could be even greater...",
				"You choose the 'Mantis-like Agility' perk, by becoming much more mantis-like your body musculature started to slowly adapt to existance of exoskeleton.");
		public static const MantislikeAgilityEvolved:PerkType = mk("Mantis-like Agility (Evolved)", "Mantis-like Agility (Evolved)",
				"Your evolved musculature providing you with even higher increase to agility and speed. If somehow you would have some type of natural armor or even thicker skin this increase would be even bigger.",
				"You choose the 'Mantis-like Agility (Evolved)' perk, by becoming much more mantis-like your body musculature started to slowly adapt to existance of exoskeleton.");
		public static const Manyshot:PerkType = mk("Manyshot", "Manyshot",
				"You always shoot two arrows instead of one on your first strike.",
				"You choose the 'Manyshot' perk, to always shoot two arrows instead of one on your first strike.");
		public static const MarkedForDeath:PerkType = mk("Marked for death", "Marked for death",
				"You can now use sneak attack with ranged weapon. (bows and snipper firearms)",
				"You choose the 'Marked for death' perk. You can now use sneak attack with ranged weapon. (bows and snipper firearms)");
		public static const Masochist:PerkType = mk("Masochist", "Masochist",
				"Take 20% less physical damage but gain lust when you take damage.",
				"You choose the 'Masochist' perk, reducing the damage you take but raising your lust each time!  This perk only functions while your libido is at or above 60!");
		public static const MasterAllRounderEducation:PerkType = mk("Master All-Rounder Education", "Master All-Rounder Education",
				"Limit of advanced job you can learn is increased by 3.",
				"You choose the 'Master All-Rounder Education' perk, expanding amount of advanced jobs you can learn. (+3)");
		public static const MasterCrinosShape:PerkType = mk("Master Crinos Shape", "Master Crinos Shape",
				"Crinos Shape increase to physical might rise to 160% of str/tou/spe.",
				"You choose the 'Master Crinos Shape' perk, once again increasing boost gained in Crinos Shape (+160%).");
		public static const MasteredDefenceStance:PerkType = mk("Mastered Defence Stance", "Mastered Defence Stance",
				"Defend move now futher reduce incoming damage and allow for slight improved fatigue/mana/soulforce recovery.",
				"You choose 'Mastered Defence Stance' perk, finally attaining mastery with your defence pose.");
		public static const MasterGolemMaker:PerkType = mk("Master Golem Maker", "Master Golem Maker",
				"Your proficiency in making golems allows to make pernament golems that will not longer shatter after one attack. Allows to store one such golem in golem bag.",
				"You choose 'Master Golem Maker' perk, increasing your proficiency in making golems.");
		public static const MasterGunslinger:PerkType = mk("Master Gunslinger", "Master Gunslinger",
				"Gain an extra firearm attack per turn (4th one).",
				"You choose the 'Master Gunslinger' perk, gaining an extra firearm attack per turn.");
		public static const Medic:PerkType = mk("MEDIC!!!", "MEDIC!!!",
				"You stole someone's skeleton from them, and nobody noticed until the patient woke up. While your doctor's license may be revoked, you are still the best medic in the world, increasing your health regen... now if only Heavy would stop screaming at you.",
				"You choose the 'MEDIC!!!' perk, increasing HP gains by 20%.");
		public static const Medicine:PerkType = mk("Medicine", "Medicine",
				"Grants 15% chance per round of cleansing poisons/drugs from your body. Increases HP restoration on rest.",
				"You choose the 'Medicine' perk, giving you a chance to remove debilitating poisons automatically! Also, increases HP restoration on rest.");
		public static const Metamorph:MetamorphPerk = new MetamorphPerk();
		public static const MetamorphEx:PerkType = mk("Metamorph (Ex)", "Metamorph (Ex)",
				"Mold your own body even further than before using genetic memory and soulforce.",
				"You choose the 'Metamorph (Ex)' perk, giving you a more options to mold your own body.");
		public static const Metamorphable:PerkType = mk("Metamorphable", "Metamorphable",
				"You can manipulate your soul force to change your body... but this increases your soul force by 10%.",
				"You choose the 'Metamorphable' perk, gaining +10% max Soulforce.");
		public static const MindOfSteel:PerkType = mk("Mind of Steel", "Mind of Steel",
				"Careful now, you're becoming too much like a weapon. You're mindset has become that of a weapon, allowing you to connect with your melee weapon to deal even more damage. (+10% melee phys dmg)",
				"You choose the 'Mind of Steel' perk, gaining +10% melee phys dmg.");
		public static const MindOverBodyI:PerkType = mk("Mind over Body I", "Mind over Body I",
				"+2 extra mana per point of intelligence.",
				"You choose the 'Mind over Body I' perk, granting +2 extra maximum mana for each point of intelligence.");
		public static const MindOverBodyII:PerkType = mk("Mind over Body II", "Mind over Body II",
				"+2 extra mana per point of intelligence.",
				"You choose the 'Mind over Body II' perk, granting +2 extra maximum mana for each point of intelligence.");
		public static const MindOverBodyIII:PerkType = mk("Mind over Body III", "Mind over Body III",
				"+2 extra mana per point of intelligence.",
				"You choose the 'Mind over Body III' perk, granting +2 extra maximum mana for each point of intelligence.");
		public static const MindOverBodyIV:PerkType = mk("Mind over Body IV", "Mind over Body IV",
				"+2 extra mana per point of intelligence.",
				"You choose the 'Mind over Body IV' perk, granting +2 extra maximum mana for each point of intelligence.");
		public static const MindOverBodyV:PerkType = mk("Mind over Body V", "Mind over Body V",
				"+2 extra mana per point of intelligence.",
				"You choose the 'Mind over Body V' perk, granting +2 extra maximum mana for each point of intelligence.");
		public static const MindOverBodyVI:PerkType = mk("Mind over Body VI", "Mind over Body VI",
				"+2 extra mana per point of intelligence.",
				"You choose the 'Mind over Body VI' perk, granting +2 extra maximum mana for each point of intelligence.");
		public static const MinotaurTesticles:PerkType = mk("Minotaur Testicles", "Minotaur Testicles",
				"Allow keep Cum Cannon special even if minotaur score is lower than 9. Additionaly your max Lust increase by 10.",
				"You choose the 'Minotaur Testicles' perk. Interaction between pernament body alteration from Bro Brew (maybe Bimbo Liquer too) and your minotaur nature allows you to keep minotaur racial special even if you stop been bull-like.");
		public static const MinotaurTesticlesEvolved:PerkType = mk("Minotaur Testicles (Evolved)", "Minotaur Testicles (Evolved)",
				"+5% to lust resistance, increase cum output by 200 mLs and +10 to max libido (scalable).",
				"You choose the 'Minotaur Testicles (Evolved)' perk. Granting more lust resistance, increase slight cum output and boost to max libido.");
		public static const MinotaurTesticlesFinalForm:PerkType = mk("Minotaur Testicles (Final Form)", "Minotaur Testicles (Final Form)",
				"+5 to max tou an +10 to max str/lib, increase cum production by ~100%, +90 to max lust and Cum Cannon cost rise to 200 lust but can be used more than once per fight.",
				"You choose the 'Minotaur Testicles (Final Form)' perk. Granting boost to max speed/libido/lust, increase cum output and allowing using Cum Cannon more than once per fight.");
		public static const MoneyFinder:PerkType = mk("Money Finder", "Money Finder",
				"Some people get all the luck it seems... Shut up and take our money is what all enemies scream at you upon defeat, increasing your gains on victory. (15% more gems from victories)",
				"You choose the 'Money Finder' perk, increasing gem gains from victories by 15%.");
		public static const MultiClawAttack:PerkType = mk("Multi Claw Attack", "Multi Claw Attack",
				"When attacking with your claws, add an additional attack striking up to 4 times.",
				"You choose the 'Multi Claw Attack' perk, gaining an additional attack with your claws!");
		public static const Multishot:PerkType = mk("Multishot", "Multishot",
				"Allows you to perform additional range attack per round.",
				"You choose the 'Multishot' perk, This allows you to make additional range attack.");
		public static const MusclesOfSteel:PerkType = mk("Muscles of Steel", "Muscles of Steel",
				"Your body has further adapted to fighting, strengthening your muscles so that they too possess the power of steel to further your melee power. (+10% melee phys dmg)",
				"You choose the 'Muscles of Steel' perk, gaining +10% melee phys dmg.");
		public static const MythicalBrawn:PerkType = mk("Mythical Brawn", "Mythical Brawn",
				"You have improved your striking power to epic level. (+35% to phantom Str bonus, +30% to unarmed atk)",
				"You choose the 'Mythical Brawn' perk, improving your striking power to epic level. (+35% to phantom Str bonus, +30% to unarmed atk)");
		public static const MythicalBrute:PerkType = mk("Mythical Brute", "Mythical Brute",
				"You have improved your striking strength to epic level. (add 120 pts of phantom Str (scalable))",
				"You choose the 'Mythical Brute' perk, improving your striking strength to epic level. (add 120 pts of phantom Str (scalable))");
		public static const MythicalEndurance:PerkType = mk("Mythical Endurance", "Mythical Endurance",
				"Increases maximum fatigue by 20000.",
				"You choose the 'Mythical Endurance' perk. Thanks to your mythical physical conditioning, your maximum fatigue has been increased by 20000!");
		public static const MythicalGolemMaker:PerkType = mk("Mythical Golem Maker", "Mythical Golem Maker",
				"Your proficiency in making golems allows to make stronger golems as much stronger their creator became and slightly rise your intelligence and wisdom. Also allow to make and store 1 improved stone golem.",
				"You choose 'Mythical Golem Maker' perk, increasing your proficiency in making golems. Also allow to make improved stone golems.");
		public static const MythicalIntelligence:PerkType = mk("Mythical Intelligence", "Mythical Intelligence",
				"Increases maximum intelligence by 65 + 15 * NG tier.",
				"You choose the 'Mythical Intelligence' perk. Increases maximum intelligence by 65 + 15 * NG tier.");
		public static const MythicalLibido:PerkType = mk("Mythical Libido", "Mythical Libido",
				"Increases maximum libido by 65 + 15 * NG tier.",
				"You choose the 'Mythical Libido' perk. Increases maximum libido by 65 + 15 * NG tier.");
		public static const MythicalSelfControl:PerkType = mk("Mythical Self-Control", "Mythical Self-Control",
				"Increases maximum lust by 10000.",
				"You choose the 'Mythical Self-Control' perk. Thanks to your mythical mental conditioning, your maximum lust has been increased by 10000!");
		public static const MythicalSensitivity:PerkType = mk("Mythical Sensitivity", "Mythical Sensitivity",
				"Increases maximum sensitivity by 65 + 15 * NG tier.",
				"You choose the 'Mythical Sensitivity' perk. Increases maximum sensitivity by 65 + 15 * NG tier.");
		public static const MythicalSpeed:PerkType = mk("Mythical Speed", "Mythical Speed",
				"Increases maximum speed by 65 + 15 * NG tier.",
				"You choose the 'Mythical Speed' perk. Increases maximum speed by 65 + 15 * NG tier.");
		public static const MythicalSpirituality:PerkType = mk("Mythical Spirituality", "Mythical Spirituality",
				"Increases maximum mana by 30000.",
				"You choose the 'Mythical Spirituality' perk. Thanks to your mythical mystical conditioning, your maximum mana has been increased by 30000!");
		public static const MythicalStrength:PerkType = mk("Mythical Strength", "Mythical Strength",
				"Increases maximum strength by 65 + 15 * NG tier.",
				"You choose the 'Mythical Strength' perk. Increases maximum strength by 65 + 15 * NG tier.");
		public static const MythicalToughness:PerkType = mk("Mythical Toughness", "Mythical Toughness",
				"Increases maximum toughness by 65 + 15 * NG tier.",
				"You choose the 'Mythical Toughness' perk. Increases maximum toughness by 65 + 15 * NG tier.");
		public static const MythicalTranquilness:PerkType = mk("Mythical Tranquilness", "Mythical Tranquilness",
				"Increases maximum wrath by 10000.",
				"You choose the 'Mythical Tranquilness' perk. Thanks to your mythical anger managment training, your maximum wrath has been increased by 10000!");
		public static const MythicalWisdom:PerkType = mk("Mythical Wisdom", "Mythical Wisdom",
				"Increases maximum wisdom by 65 + 15 * NG tier.",
				"You choose the 'Mythical Wisdom' perk. Increases maximum wisdom by 65 + 15 * NG tier.");
		public static const NakedTruth:PerkType = mk("Naked Truth", "Naked Truth",
				"Opponent have a hard time dealing serious damage as the sight of your naked body distract them (+10% dmg reduction).",
				"You choose the 'Naked Truth' perk, causing opponent have a hard time dealing serious damage as the sight of your naked body distract them.");
		public static const NamedBullet:PerkType = mk("Named Bullet", "Named Bullet",
				"Bosses fears your guns, add 50% increased damage to bosses.",
				"You choose the 'Named Bullet' perk, allowing for your guns deal extra damage to boss enemies.");
		public static const Napping:PerkType = mk("Napping", "Napping",
				"Sample Text Here/+20% fatigue recovery rate",
				"You choose the 'Napping' perk, gaining +20% fatigue recovery rate.");
		public static const NaturalHealingEpic:PerkType = mk("Natural healing (Epic)", "Natural healing (Epic)",
				"Incease healing power by 50% and lower healing spells mana costs by 20%.",
				"You choose the 'Natural healing (Epic)' perk, increasing healing spells effectivnes and lowering their costs.");
		public static const NaturalHealingLegendary:PerkType = mk("Natural healing (Legendary)", "Natural healing (Legendary)",
				"Incease healing power by 60% and lower healing spells mana costs by 25%.",
				"You choose the 'Natural healing (Legendary)' perk, increasing healing spells effectivnes and lowering their costs.");
		public static const NaturalHealingMajor:PerkType = mk("Natural healing (Major)", "Natural healing (Major)",
				"Incease healing power by 40% and lower healing spells mana costs by 15%.",
				"You choose the 'Natural healing (Major)' perk, increasing healing spells effectivnes and lowering their costs.");
		public static const NaturalHealingMinor:PerkType = mk("Natural healing (Minor)", "Natural healing (Minor)",
				"Incease healing power by 30% and lower healing spells mana costs by 10%.",
				"You choose the 'Natural healing (Minor)' perk, increasing healing spells effectivnes and lowering their costs.");
		public static const Naturaljouster:PerkType = mk("Natural jouster", "Natural jouster",
				"Increase attack power of spears/lances when you attack once each turn and have taur/drider lower body or 2,5x higher speed if you not have one of this specific lower body types (60+ for taurs/drider and 150+ for others).",
				"You've chosen the 'Natural jouster' perk. As long you will have taur or drider lower body and attack once per turn your spear/lance attack power will be three time higher.");
		public static const NaturaljousterMastergrade:PerkType = mk("Natural jouster (Master grade)", "Natural jouster (Master grade)",
				"Increase attack power of spears/lances when you attack once each turn and have taur/drider lower body or 2,5x higher speed if you not have one of this specific lower body types (180+ for taurs/drider and 450+ for others).",
				"You've chosen the 'Natural jouster (Master grade)' perk. As long you will have taur or drider lower body and attack once per turn your spear/lance attack power will be five time higher.");
		public static const NaturalPunchingBag:PerkType = mk("Natural punching bag", "Natural punching bag",
				"Increases the damage reduction from Bouncy body by 5% and increase your natural toughness.",
				"You choose the 'Natural punching bag' perk, by becoming much more goblin-like your body fat tissue started to slowly adapt to their lifestyle.");
		public static const NaturalPunchingBagEvolved:PerkType = mk("Natural punching bag (Evolved)", "Natural punching bag (Evolved)",
				"Oncreases the damage reduction from Bouncy body by 10%, continue to increase your natural toughness and healing items are more effective.",
				"You choose the 'Natural punching bag (Evolved)' perk. Your changing fat tissue giving you a boost to goblin-related special and more effective healing from pills.");
		public static const NaturalPunchingBagFinalForm:PerkType = mk("Natural punching bag (Final Form)", "Natural punching bag (Final Form)",
				"Increases the damage reduction from Bouncy body by 20%, continue to increase your natural toughness and healing/wrath/stat boosting items are more effective and allow to keep the effect of bouncy body as long as you are below 4 feet tall.",
				"You choose the 'Natural punching bag (Final Form)' perk. Your goblin fat tissue changes, boosting your goblin specials once again.");
		public static const NaturesSpringI:PerkType = mk("Nature's Spring I", "Nature's Spring I",
				"Raises max fatigue by 20 and regain it 5% faster.",
				"You choose the 'Nature's Spring I' perk, giving you an additional 20 fatigue and boosting your fatigue recovery rate.");
		public static const NaturesSpringII:PerkType = mk("Nature's Spring II", "Nature's Spring II",
				"Raises max fatigue by 20 and regain it 5% faster.",
				"You choose the 'Nature's Spring II' perk, giving you an additional 20 fatigue and boosting your fatigue recovery rate.");
		public static const NaturesSpringIII:PerkType = mk("Nature's Spring III", "Nature's Spring III",
				"Raises max fatigue by 20 and regain it 5% faster.",
				"You choose the 'Nature's Spring III' perk, giving you an additional 20 fatigue and boosting your fatigue recovery rate.");
		public static const NaturesSpringIV:PerkType = mk("Nature's Spring IV", "Nature's Spring IV",
				"Raises max fatigue by 20 and regain it 5% faster.",
				"You choose the 'Nature's Spring IV' perk, giving you an additional 20 fatigue and boosting your fatigue recovery rate.");
		public static const NaturesSpringV:PerkType = mk("Nature's Spring V", "Nature's Spring V",
				"Raises max fatigue by 20 and regain it 5% faster.",
				"You choose the 'Nature's Spring V' perk, giving you an additional 20 fatigue and boosting your fatigue recovery rate.");
		public static const NaturesSpringVI:PerkType = mk("Nature's Spring VI", "Nature's Spring VI",
				"Raises max fatigue by 20 and regain it 5% faster.",
				"You choose the 'Nature's Spring VI' perk, giving you an additional 20 fatigue and boosting your fatigue recovery rate.");
		public static const Nerd:PerkType = mk("NERD!!!", "NERD!!!",
				"Piccolo's words, not mine... but they are perfect for describing you. Increase max mana by 10%.",
				"You choose the 'NERD!!!' perk, gaining +10% max Mana.");
		public static const NonaAttackSmall:PerkType = mk("Nona Attack (Small)", "Nona Attack (Small)",
				"Allows you to perform nine melee attacks with small weapons per round.",
				"You choose the 'Nona Attack (Small)' perk. This allows you to make nine melee attacks with small weapons.");
		public static const Nurse:PerkType = mk("Nurse", "Nurse",
				"Constantly running around tending to the sick has made you better at taking care of yourself, increasing health regen.",
				"You choose the 'Nurse' perk, increasing HP gains by 20%.");
		public static const Nymphomania:PerkType = mk("Nymphomania", "Nymphomania",
				"Raises minimum lust by up to 30.",
				"You've chosen the 'Nymphomania' perk.  Due to the incredible amount of corruption you've been exposed to, you've begun to live in a state of minor constant arousal.  Your minimum lust will be increased by 30.");
		public static const ObsidianHeart:PerkType = mk("Obsidian Heart", "Obsidian Heart",
				"You can use both devil m. specials without need to be full devilkin race member (but each use of them will give a bit of corruption if it's below 60).",
				"You choose the 'Obsidian Heart' perk. Your heart due to been more devilish turned obsidian-like.");
		public static const ObsidianHeartEvolved:PerkType = mk("Obsidian Heart (Evolved)", "Obsidian Heart (Evolved)",
				"Increase Maleficium duration by 5 turns and boost to spell power from 100% to 125% of base value; Infernal Flare dealing ~25% more dmg.",
				"You choose the 'Obsidian Heart (Evolved)' perk. Your changing heart giving you boost to both devil special attacks.");
		public static const ObsidianHeartFinalForm:PerkType = mk("Obsidian Heart (Final Form)", "Obsidian Heart (Final Form)",
				"Increase Maleficium boost to spell power from 125% to 250% of base value and lower lust resistance decrease to 30%; Infernal Flare dealing ~40% more dmg and have +20% higher chance to Crit.",
				"You choose the 'Obsidian Heart (Final Form)' perk. Your devil heart changes boosted your devil special once again.");
		public static const OctaAttackSmall:PerkType = mk("Octa Attack (Small)", "Octa Attack (Small)",
				"Allows you to perform eight melee attacks with small weapons per round.",
				"You choose the 'Octa Attack (Small)' perk. This allows you to make eight melee attacks with small weapons.");
		public static const OniMusculature:PerkType = mk("Oni Musculature", "Oni Musculature",
				"Your altered musculature allows to increase your natural strenght and tone. Oni Rampage and Drunker Power can be used at Half-Oni score.",
				"You choose the 'Oni Musculature' perk, by becoming much more oni-like your body musculature started to slowly adapt to oni lifestyle.");
		public static const OniMusculatureEvolved:PerkType = mk("Oni Musculature (Evolved)", "Oni Musculature (Evolved)",
				"Your altered musculature continue to increase your natural strenght and tone gained from previous change. Oni Rampage and Drunker Power req. only 3+ pts in Oni score and dmg multi from Oni Rampage increased to 4x.",
				"You choose the 'Oni Musculature' perk. Your changing musculature giving you boost to oni-related specials.");
		public static const OniMusculatureFinalForm:PerkType = mk("Oni Musculature (Final Form)", "Oni Musculature (Final Form)",
				"Your altered musculature increased again your natural strenght and tone limit. Dmg multi from Oni Rampage increased to 6x, it duration increased by 3 turns and cooldown decreased by 3 turns. Drunken Power boost increased to 6x.",
				"You choose the 'Oni Musculature (Final Form)' perk. Your oni musculature changes boosted your oni specials once again.");
		public static const OrcAdrenalGlands:PerkType = mk("Orc Adrenal Glands", "Orc Adrenal Glands",
				"Your Orc adrenal glands are increasing Ferocity limit by 2%, 5 pts of phantom Str (scalable).",
				"You choose the 'Orc Adrenal Glands' perk, due to repeadly balancing on line between life and death your adrenal glands mutated.");
		public static const OrcAdrenalGlandsEvolved:PerkType = mk("Orc Adrenal Glands (Evolved)", "Orc Adrenal Glands (Evolved)",
				"Your Orc adrenal glands are increasing Ferocity limit by 3%, 10 pts of phantom Str (scalable), increase your natural strenght and tone.",
				"You choose the 'Orc Adrenal Glands (Evolved)' perk. Your adrenal glands changes boosted your orc innate abilities once again.");
		public static const OrcAdrenalGlandsFinalForm:PerkType = mk("Orc Adrenal Glands (Final Form)", "Orc Adrenal Glands (Final Form)",
				"Your Orc adrenal glands are giving you 15 pts of phantom Str (scalable), increase your natural strenght, boost natural wrath generation rate, allow to use Ferocity even when been no longer an orc.",
				"You choose the 'Orc Adrenal Glands (Final Form)' perk, repeadly balancing on line between life and death caused your adrenal glands mutate into final form.");
		public static const Paramedic:PerkType = mk("Paramedic", "Paramedic",
				"Having been a part of the emergency team called out, you can handle working in high stress environments effectively, further increasing your health regen.",
				"You choose the 'Paramedic' perk, increasing HP gains by 20%.");
		public static const Parry:PerkType = mk("Parry", "Parry",
				"[if(player.spe>=50)" +
						"Increases deflect chance by up to 10% while wielding a weapon. (Speed-based)." +
						"|" +
						"<b>You are not fast enough to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Parry' perk, giving you a chance to deflect blow with your weapon. (Speed-based).");
		public static const Pastor:PerkType = mk("Pastor", "Pastor",
				"Congratulations! You went from sleeping during the sermon, to being the putting people to sleep with sermons! The sheer devotion to your faith lowers you minimum libido and boost lust resistance. (-2 min libido/+5% to lust resistance)",
				"You choose the 'Pastor' perk, lowering min libido by 2 and rise lust resistance by 5%.");
		public static const PathOfEnlightenment:PerkType = mk("Path of Enlightenment", "Path of Enlightenment",
				"You walk a path of enlightenment... You should stop expecting anything other than the 10% more soulforce.",
				"You choose the 'Path of Enlightenment' perk, gaining +10% max Soulforce.");
		public static const PeerlessEndurance:PerkType = mk("Peerless Endurance", "Peerless Endurance",
				"Increases maximum fatigue by 1000.",
				"You choose the 'Peerless Endurance' perk. Thanks to your peerless physical conditioning, your maximum fatigue has been increased by 1000!</b>");
		public static const PeerlessSelfControl:PerkType = mk("Peerless Self-Control", "Peerless Self-Control",
				"Increases maximum lust by 500.",
				"You choose the 'Peerless Self-Control' perk. Thanks to your peerless mental conditioning, your maximum lust has been increased by 500!</b>");
		public static const PeerlessSpirituality:PerkType = mk("Peerless Spirituality", "Peerless Spirituality",
				"Increases maximum mana by 1500.",
				"You choose the 'Peerless Spirituality' perk. Thanks to your peerless mystical conditioning, your maximum mana has been increased by 1500!</b>");
		public static const PeerlessTranquilness:PerkType = mk("Peerless Tranquilness", "Peerless Tranquilness",
				"Increases maximum wrath by 500.",
				"You choose the 'Peerless Tranquilness' perk. Thanks to your peerless anger managment training, your maximum mana has been increased by 500!</b>");
		public static const PentaAttack:PerkType = mk("Penta Attack", "Penta Attack",
				"Allows you to perform five melee attacks with non-large weapons per round.",
				"You choose the 'Penta Attack' perk.  This allows you to make five melee attacks with non-large weapons.");
		public static const PentaAttackSmall:PerkType = mk("Penta Attack (Small)", "Penta Attack (Small)",
				"Allows you to perform five melee attacks with small weapons per round.",
				"You choose the 'Penta Attack (Small)' perk.  This allows you to make five melee attacks with small weapons.");
		public static const PerfectDefenceStance:PerkType = mk("Perfect Defence Stance", "Perfect Defence Stance",
				"Defend move now massively reduce incoming damage and allow for improved fatigue/mana/soulforce recovery.",
				"You choose 'Perfect Defence Stance' perk, perfecting your defence pose beyond mastery level.");
		public static const Perfection:PerkType = mk("Perfection", "Perfection",
				"The ultimate stage of alchemy, you have perfected the art of making transformatives more effective. This is a level very few have reached +1 effect.",
				"You choose the 'Perfection' perk, number of possible effects of transformatives +1.");
		public static const PerfectStrike:PerkType = mk("Perfect strike", "Perfect strike",
				"When you strike (with puch/kick/soulblast) a stunned or frozen solid opponent you deal extra damage (50%).",
				"You choose the 'Perfect strike' perk, allowing to deal more damage to stunned or frozen solid enemeis with punch/kick type soulskills.");
		public static const PewWarmer:PerkType = mk("Pew Warmer", "Pew Warmer",
				"You attend mass, but have a small tendecy to sleep during the sermon... but hey, merely attending was enough to help lower your minimum libido and boost lust resistance. (-2 min libido/+5% to lust resistance)",
				"You choose the 'Pew Warmer' perk, lowering min libido by 2 and rise lust resistance by 5%.");
		public static const PhantomStrike:PerkType = mk("Phantom Strike", "Phantom Strike",
				"Allows to attack twice with some P. Specials at double cost. (Wing Slap, Stone Claw, Tail Slam, Kick and few others)",
				"You choose the 'Phantom Strike' perk, allowing to attack twice with some P. Specials at double cost.");
		public static const PigBoarFat:PerkType = mk("Pig/Boar Fat", "Pig/Boar Fat",
				"Your altered fat tissue allows to increase your natural resistance to damage, toughness and thickness.",
				"You choose the 'Pig/Boar Fat' perk, by becoming much more pig-like your body fat tissue started to slowly adapt to pig lifestyle.");
		public static const PigBoarFatEvolved:PerkType = mk("Pig/Boar Fat (Evolved)", "Pig/Boar Fat (Evolved)",
				"Your altered fat tissue continue to increase your natural resistance to damage, toughness and thickness gained from previous change. Body Slam req. lower thickness to be used.",
				"You choose the 'Pig/Boar Fat (Evolved)' perk. Your changing fat tissue giving you a boost to pig-related special.");
		public static const PigBoarFatFinalForm:PerkType = mk("Pig/Boar Fat (Final Form)", "Pig/Boar Fat (Final Form)",
				"Your altered fat tissue increased again your natural resistance to damage, toughness and thickness limit. Body Slam power increase twicefold and it not req. to be pig/boar to use it, also another lowering of min. thickness to use it.",
				"You choose the 'Pig/Boar Fat (Final Form)' perk. Your pig fat tissue changes, boosting your pig specials once again.");
		public static const Poisoning:PerkType = mk("Poisoning", "Poisoning",
				"By carefully collecting your venom you can apply poison to your small weapons.",
				"You choose the 'Poisoning' perk, allowing you to apply your own venom to small weapons.");
		public static const Pope:PerkType = mk("Pope", "Pope",
				"You are the most important mortal in your faith, the pinnacle of faith and devotion! Of course this means your minimum libido and lust resistance is as far as it will go! (-2 min libido/+5% to lust resistance)",
				"You choose the 'Pope' perk, lowering min libido by 2 and rise lust resistance by 5%.");
		public static const Pornstar:PerkType = mk("Pornstar", "Pornstar",
				"You are famous for your acts of sex, with many teenagers dreaming of having a chance with you. All the tips you learned help your tease damage by 15%.",
				"You choose the 'Pornstar' perk, gaining +15% tease dmg.");
		public static const PowerSweep:PerkType = mk("Power Sweep", "Power Sweep",
				"Allows the use of whirlwind using one handed weapons at 75% of the normal effect. Large weapon gain a 25% bonus to whirlwind damage (Does not include fist).",
				"You choose the 'Power Sweep' perk.  This allows you to improve Whirlwind attack.");
		public static const PracticedShot:PerkType = mk("Practiced shot", "Practiced shot",
				"Increase traditional range weapons (like bows) base attack by 50%.",
				"You choose the 'Practiced shot' perk, increasing traditional range weapons base attack.");
		public static const Precision:PerkType = mk("Precision", "Precision",
				"Reduces enemy armor by 10. (Req's 25+ Intelligence)",
				"You've chosen the 'Precision' perk.  Thanks to your intelligence, you're now more adept at finding and striking an enemy's weak points, reducing their damage resistance from armor by 10.  If your intelligence ever drops below 25 you'll no longer be smart enough to benefit from this perk.");
		public static const President:PerkType = mk("President", "President",
				"You own the school board, controlling what classes are taught, further increasing max mana by 10%.",
				"You choose the 'President' perk, gaining +10% max Mana.");
		public static const PrestigeJobArcaneArcher:PerkType = mk("Prestige Job: Arcane Archer", "Prestige Job: Arcane Archer",
				"You've trained in prestige art of combining magic and arrows. (+40 to max spe/int - scalable)",
				"You choose 'Prestige Job: Arcane Archer' perk, training yourself to became Arcane Archer.");
		public static const PrestigeJobBerserker:PerkType = mk("Prestige Job: Berserker", "Prestige Job: Berserker",
				"You've trained in prestige art of perfect mastery over all forms of berserking. (+60 to max str, +20 to max tou - scalable)",
				"You choose 'Prestige Job: Berserker' perk, training yourself to became Berserker.");
		public static const PrestigeJobGreySage:PerkType = mk("Prestige Job: Grey Sage", "Prestige Job: Grey Sage",
				"You've trained in prestige art of perfect mastery over all forms of aoe magic spells. (+80 to max int - scalable)",
				"You choose 'Prestige Job: Grey Sage' perk, training yourself to became Grey Sage - master of area spells.");
		public static const PrestigeJobNecromancer:PerkType = mk("Prestige Job: Necromancer", "Prestige Job: Necromancer",
				".",//golemancer + ?daoist path of soul cultivation or just soul cultivation path perk?
				"You choose 'Prestige Job: Necromancer' perk, training yourself to became Necromancer.");
		public static const PrestigeJobSeer:PerkType = mk("Prestige Job: Seer", "Prestige Job: Seer",
				"You've trained in prestige art of combining soulforce and magic.",
				"You choose 'Prestige Job: Seer' perk, training yourself to became Seer.");
		public static const PrestigeJobSentinel:PerkType = mk("Prestige Job: Sentinel", "Prestige Job: Sentinel",
				"You've trained in prestige art that brings 'tanking' to a whole new level. (+20 to max str, +60 to max tou - scalable)",
				"You choose 'Prestige Job: Sentinel' perk, training yourself to became Sentinel.");
		public static const PrestigeJobSoulArcher:PerkType = mk("Prestige Job: Soul Archer", "Prestige Job: Soul Archer",
				"You've trained in prestige art of combining soulforce and arrows.",
				"You choose 'Prestige Job: Soul Archer' perk, training yourself to became Soul Archer.");
		public static const PrestigeJobSoulArtMaster:PerkType = mk("Prestige Job: Soul Art Master", "Prestige Job: Soul Art Master",
				"You've trained in prestige art of combine soulforce with physical attacks to various deadly effect. (+40 to max str/wis - scalable)",
				"You choose 'Prestige Job: Soul Art Master' perk, training yourself to became Soul Art Master.");
		public static const PrestigeJobSpellKnight:PerkType = mk("Prestige Job: Spell-Knight", "Prestige Job: Spell-Knight",
				"You've trained in prestige art of combining swordplay and magic. (+40 to max str/int - scalable)",
				"You choose 'Prestige Job: Spell-Knight' perk, training yourself to became Spell-Knight.");
		public static const PrestigeJobTempest:PerkType = mk("Prestige Job: Tempest", "Prestige Job: Tempest",
				"You've trained in prestige art of dual wielding as you hack and slice through your opponents like a raging storm of steel. (+40 to max str/spe - scalable)",
				"You choose 'Prestige Job: Tempest' perk, training yourself to became Tempest.");
		public static const PrestigeJobWarlock:PerkType = mk("Prestige Job: Warlock", "Prestige Job: Warlock",
				"You've trained in prestige art of hex magic. (+60 to max int, +20 to max lib - scalable; +20% to black magic spellpower, -40% to white magic spellpower)",
				"You choose 'Prestige Job: Warlock' perk, training yourself to became Warlock.");
		public static const Priest:PerkType = mk("Priest", "Priest",
				"You now speak during mass, your words of wisdom empowerin others and you to have a lower minimum libido and boost lust resistance. (-2 min libido/+5% to lust resistance)",
				"You choose the 'Priest' perk, lowering min libido by 2 and rise lust resistance by 5%.");
		public static const PrimalFuryI:PerkType = mk("Primal Fury I", "Primal Fury I",
				"Raises max Wrath by 10, generates 2 point of Wrath out of combat and double this amount during fight.",
				"You choose the 'Primal Fury I' perk, increasing passive wrath generation and max Wrath.");
		public static const PrimalFuryII:PerkType = mk("Primal Fury II", "Primal Fury II",
				"Raises max Wrath by 10, generates 2 point of Wrath out of combat and double this amount during fight.",
				"You choose the 'Primal Fury II' perk, increasing passive wrath generation and max Wrath.");
		public static const PrimalFuryIII:PerkType = mk("Primal Fury III", "Primal Fury III",
				"Raises max Wrath by 10, generates 2 point of Wrath out of combat and double this amount during fight.",
				"You choose the 'Primal Fury III' perk, increasing passive wrath generation and max Wrath.");
		public static const PrimalFuryIV:PerkType = mk("Primal Fury IV", "Primal Fury IV",
				"Raises max Wrath by 10, generates 2 point of Wrath out of combat and double this amount during fight.",
				"You choose the 'Primal Fury IV' perk, increasing passive wrath generation and max Wrath.");
		public static const PrimalFuryV:PerkType = mk("Primal Fury V", "Primal Fury V",
				"Raises max Wrath by 10, generates 2 point of Wrath out of combat and double this amount during fight.",
				"You choose the 'Primal Fury V' perk, increasing passive wrath generation and max Wrath.");
		public static const PrimalFuryVI:PerkType = mk("Primal Fury VI", "Primal Fury VI",
				"Raises max Wrath by 10, generates 2 point of Wrath out of combat and double this amount during fight.",
				"You choose the 'Primal Fury VI' perk, increasing passive wrath generation and max Wrath.");
		public static const Principle:PerkType = mk("Principle", "Principle",
				"You oversee the day to day actions inside the school, your studious nature increasing max mana by 10%.",
				"You choose the 'Principle' perk, gaining +10% max Mana.");
		public static const Professor:PerkType = mk("Professor", "Professor",
				"You're more important than the standard teacher, and your paycheck reflects that. You're hired for your knowledge which increases max mana by 10%.",
				"You choose the 'Professor' perk, gaining +10% max Mana.");
		public static const Prostitute:PerkType = mk("Prostitute", "Prostitute",
				"It's official, everyone knows to go to you for sex. You're still new to the business, but you learned some new tricks. (+15% tease dmg)",
				"You choose the 'Prostitute' perk, gaining +15% tease dmg.");
		public static const PyrosFriend:PerkType = mk("Pyro's Friend", "Pyro's Friend",
				"Mmmphmm! (No idea what he? is trying to say... but same rules apply... +10% ranged damage buff)",
				"You choose the 'Pyro's Friend' perk, gaining +10% range phys dmg.");
		public static const QuadrupleAttack:PerkType = mk("Quadruple Attack", "Quadruple Attack",
				"Allows you to perform four melee attacks with non-large weapons per round.",
				"You choose the 'Quadruple Attack' perk.  This allows you to make four melee attacks with non-large weapons.");
		public static const QuadrupleAttackSmall:PerkType = mk("Quadruple Attack (Small)", "Quadruple Attack (Small)",
				"Allows you to perform four melee attacks with small weapons per round.",
				"You choose the 'Quadruple Attack (Small)' perk.  This allows you to make four melee attacks with small weapons.");
		public static const QuickStrike:PerkType = mk("Quick Strike", "Quick Strike",
				"Add speed based scaling of melee attacks when using small weapon(s). It effect is added on top of Speed Demon perk boost.",
				"You choose the 'Quick Strike' perk, allowing you to use your speed when attacking with small melee weapons.");
		public static const Rage:PerkType = mk("Rage", "Rage",
				"Increasing crit chance by up to 50% in berserk state that would reset after succesful crit attack.",
				"You choose the 'Rage' perk, increasing crit chance by up to 50% in berserk state until next crit attack.");
		public static const RapidReload:PerkType = mk("Rapid Reload", "Rapid Reload",
				"Allow to not spend whole turn to use Reload button as long PC got enough fatigue.",
				"You choose the 'Rapid Reload' perk, lowering time needed to reload ammo for range weapons like pistols.");
		public static const LightningReload:PerkType = mk("Lightning Reload", "Lightning Reload",
				"Allow to reload in middle of shooting as long PC have enough fatigue for that without ending turn.",
				"You choose the 'Lightning Reload' perk, lowering even more time needed to reload with ammo range weapons like pistols.");
		public static const RagingInferno:PerkType = mk("Raging Inferno", "Raging Inferno",
				"Cumulative 20% damage increase for every subsequent fire spell without interruption.",
				"You choose the 'Raging Inferno' perk. Cumulative 20% damage increase for every subsequent fire spell without interruption.");
				//"Cumulative 10% damage increase for every subsequent fire spell. Each turn without casted fire spell lower damage by 10%.",
				//"You choose the 'Raging Inferno' perk. Cumulative 10% damage increase for every subsequent fire spell.");
		public static const RecoveryMantra:PerkType = mk("Recovery mantra", "Recovery mantra",
				"Gain soulforce recovery equal to 2% of your total soulforce.",
				"You choose the 'Recovery mantra' perk, gaining soulfroce recovery rate equal to 2% of your total soulforce.");
		public static const RecuperationSleep:PerkType = mk("Recuperation Sleep", "Recuperation Sleep",
				"Gain +100% boost to health and fatigue recovery during sleep.",
				"You choose the 'Recuperation Sleep' perk, boosting your health and fatigue recovery rate while sleeping!");
		public static const RefinedBodyI:PerkType = mk("Refined Body I", "Refined Body I",
				"Raises max HP by 50.",
				"You choose the 'Refined Body I' perk, giving you an additional 50 HP!");
		public static const RefinedBodyII:PerkType = mk("Refined Body II", "Refined Body II",
				"Raises max HP by 50.",
				"You choose the 'Refined Body II' perk, giving you an additional 50 HP!");
		public static const RefinedBodyIII:PerkType = mk("Refined Body III", "Refined Body III",
				"Raises max HP by 50.",
				"You choose the 'Refined Body III' perk, giving you an additional 50 HP!");
		public static const RefinedBodyIV:PerkType = mk("Refined Body IV", "Refined Body IV",
				"Raises max HP by 50.",
				"You choose the 'Refined Body IV' perk, giving you an additional 50 HP!");
		public static const RefinedBodyV:PerkType = mk("Refined Body V", "Refined Body V",
				"Raises max HP by 50.",
				"You choose the 'Refined Body V' perk, giving you an additional 50 HP!");
		public static const RefinedBodyVI:PerkType = mk("Refined Body VI", "Refined Body VI",
				"Raises max HP by 50.",
				"You choose the 'Refined Body VI' perk, giving you an additional 50 HP!");
		public static const Refinement:PerkType = mk("Refinement", "Refinement",
				"Using your acquired knowledge, you refine each item to increase its effects on your body, further increasing the changes +1 effect.",
				"You choose the 'Refinement' perk, number of possible effects of transformatives +1.");
		public static const Regeneration:RegenerationPerk = new RegenerationPerk();
		public static const Regeneration2:Regeneration2Perk = new Regeneration2Perk();
		public static const Regeneration3:Regeneration3Perk = new Regeneration3Perk();
		public static const Regeneration4:Regeneration4Perk = new Regeneration4Perk();
		public static const Regeneration5:Regeneration5Perk = new Regeneration5Perk();
		public static const Regeneration6:Regeneration6Perk = new Regeneration6Perk();
		public static const RejuvenationSleep:PerkType = mk("Rejuvenation Sleep", "Rejuvenation Sleep",
				"Gain +200% boost to health and fatigue recovery during sleep.",
				"You choose the 'Rejuvenation Sleep' perk, boosting your health and fatigue recovery rate while sleeping!");
		public static const ResistanceI:PerkType = mk("Resistance I", "Resistance I",
				"Reduces lust gain by 5%.",
				"You choose the 'Resistance I' perk, reducing the rate at which your lust increases by 5%.");
		public static const ResistanceII:PerkType = mk("Resistance II", "Resistance II",
				"Reduces lust gain by 5%.",
				"You choose the 'Resistance II' perk, reducing the rate at which your lust increases by 5%.");
		public static const ResistanceIII:PerkType = mk("Resistance III", "Resistance III",
				"Reduces lust gain by 5%.",
				"You choose the 'Resistance III' perk, reducing the rate at which your lust increases by 5%.");
		public static const ResistanceIV:PerkType = mk("Resistance IV", "Resistance IV",
				"Reduces lust gain by 5%.",
				"You choose the 'Resistance IV' perk, reducing the rate at which your lust increases by 5%.");
		public static const ResistanceV:PerkType = mk("Resistance V", "Resistance V",
				"Reduces lust gain by 5%.",
				"You choose the 'Resistance V' perk, reducing the rate at which your lust increases by 5%.");
		public static const ResistanceVI:PerkType = mk("Resistance VI", "Resistance VI",
				"Reduces lust gain by 5%.",
				"You choose the 'Resistance VI' perk, reducing the rate at which your lust increases by 5%.");
		public static const Resolute:PerkType = mk("Resolute", "Resolute",
				"[if(player.tou>=75)" +
						"Grants immunity to stuns and some statuses.</b>" +
						"|" +
						"<b>You aren't tough enough to benefit from this anymore.</b>" +
						"]",
				"You choose the 'Resolute' perk, granting immunity to stuns and some statuses.</b>");
		public static const Runner:PerkType = mk("Runner", "Runner",
				"Increases chances of escaping combat.",
				"You choose the 'Runner' perk, increasing your chances to escape from your foes when fleeing!");
		public static const Sadist:PerkType = mk("Sadist", "Sadist",
				"Deal 20% more damage, but gain lust at the same time.",
				"You choose the 'Sadist' perk, increasing damage by 20 percent but causing you to gain lust from dealing damage.");
		public static const Saint:PerkType = mk("Saint", "Saint",
				"You go on periodic journeys to spread your faith and help those in need. These constant pilgrimages decrease your minimum libido and boost lust resistance. (-2 min libido/+5% to lust resistance)",
				"You choose the 'Saint' perk, lowering min libido by 2 and rise lust resistance by 5%.");
		public static const SalamanderAdrenalGlands:PerkType = mk("Salamander Adrenal Glands", "Salamander Adrenal Glands",
				"Your Salamander adrenal glands are giving you slight boost to your natural stamina and libido.",
				"You choose the 'Salamander Adrenal Glands' perk, due to repeadly exposure to effects of lustzerk your adrenal glands mutated.");
		public static const SalamanderAdrenalGlandsEvolved:PerkType = mk("Salamander Adrenal Glands (Evolved)", "Salamander Adrenal Glands (Evolved)",
				"Your Salamander adrenal glands are giving you slight boost to your natural strength, stamina, speed and libido and extend lustzerker and berserker duration by 2 turns.",
				"You choose the 'Salamander Adrenal Glands (Evolved)' perk, repeadly use of lustzerk caused your adrenal glands mutate even more.");
		public static const SalamanderAdrenalGlandsFinalForm:PerkType = mk("Salamander Adrenal Glands (Final Form)", "Salamander Adrenal Glands (Final Form)",
				"Your Salamander adrenal glands are giving you slight boost to your natural strength, stamina, speed, libido; double bonus to attack, boost slight natural wrath generation rate, extend berserking/lustzerking by 8 turns and enable to start with one or both of them.",
				"You choose the 'Salamander Adrenal Glands (Final Form)' perk, repeadly use of lustzerk caused your adrenal glands mutate for the third time.");
		public static const Saturation:PerkType = mk("Saturation", "Saturation",
				"Using your advanced knowledge, you soak each transformative in a special liquid to enhance their effects +1 effect.",
				"You choose the 'Saturation' perk, number of possible effects of transformatives +1.");
		public static const ScyllaInkGlands:PerkType = mk("Scylla Ink Glands", "Scylla Ink Glands",
				"Your Scylla Ink Glands increase rate at which your body produce ink and slight boost to your natural strength.",
				"You choose the 'Scylla Ink Glands' perk, due to repeadly use of ink attack leading to denveloping ink glands!");
		public static const ScyllaInkGlandsEvolved:PerkType = mk("Scylla Ink Glands (Evolved)", "Scylla Ink Glands (Evolved)",
				"WiP perk.",
				"You choose the 'Scylla Ink Glands (Evolved)' perk, WiP perk!");
		public static const SecondRing:PerkType = mk("Second Ring", "Second Ring",
				"Your basic understanding of magic pools allows you to equip second ring.",
				"You choose the 'Second Ring' perk, reaching basic understanding of magic pools to allow you equip second ring.");
		public static const SecondWind:PerkType = mk("Second Wind", "Second Wind",
				"Using half remaining fatigue increase by 5% regeneration in combat for 10 turns.",
				"You choose the 'Second Wind' perk, allowing to once per fight increase for few turns natural regeneration at cost of some fatigue.");
		public static const Seduction:PerkType = mk("Seduction", "Seduction",
				"Upgrades your tease attack, making it more effective.",
				"You choose the 'Seduction' perk, upgrading the 'tease' attack with a more powerful damage and a higher chance of success.");
		public static const Sensual:PerkType = mk("Sensual", "Sensual",
				"Lowering by ~40% needed exp to lvl-up tease and +1 more tease exp after succes.",
				"You choose the 'Sensual' perk, lowering by ~40% needed exp to lvl-up tease and +1 more tease exp after succes.");
		public static const SexChampion:PerkType = mk("Sex Champion", "Sex Champion",
				"You are the shining symbol of the sex industry, the beacon of hope for those aspiring in the industry. The sheer number of tricks and tips you have up your tease damage 15%.",
				"You choose the 'Sex Champion' perk, gaining +15% tease dmg.");
		public static const SexDeity:PerkType = mk("Sex Deity", "Sex Deity",
				"Screw Xeria, you're the true sex deity! You're holiness empowers your sex drive, increasing your tease damage by 15%.",
				"You choose the 'Sex Deity' perk, gaining +15% tease dmg.");
		public static const Sharpshooter:PerkType = mk("Sharpshooter", "Sharpshooter",
				"Allow to increase non-bow range weapons attack up to 200% (Intelligence-based).",
				"You choose the 'Sharpshooter' perk, allowing to slightly increase non-bow range weapons attack.");
		public static const ShieldCombat:PerkType = mk("Shield Combat", "Shield Combat",
				"When you block an attack riposte with a shield bash damaging your opponent.",
				"You choose the 'Shield Combat' perk, allowing to riposte with a shield bash when you block an attack.");
		public static const ShieldExpertise:PerkType = mk("Shield Expertise", "Shield Expertise",
				"When you wearing a shield add quarter of block value to your armor (at least 1).",
				"You choose the 'Shield Expertise' perk, allowing to increase you armor when using shield.");
		public static const ShieldGrandmastery:PerkType = mk("Shield Grandmastery", "Shield Grandmastery",
				"[if(player.tou>=100)" +
						"Increases block chance by up to 10% while using a shield (Toughness-based) and lowering by 50% fatigue cost." +
						"|" +
						"<b>You are not durable enough to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Shield Grandmastery' perk, lowering fatigue cost and increasing block chance as long as you're wielding a shield (Toughness-based).");
		public static const ShieldHarmony:PerkType = mk("Shield Harmony", "Shield Harmony",
				"When you using shield and isn't stunned, you gain 10% phys damage reduction.",
				"You choose the 'Shield Harmony' perk, allowing to reduce recived phys damage when using shield.");
		public static const ShieldMastery:PerkType = mk("Shield Mastery", "Shield Mastery",
				"[if(player.tou>=50)" +
						"Increases block chance by up to 10% while using a shield (Toughness-based)." +
						"|" +
						"<b>You are not durable enough to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Shield Mastery' perk, increasing block chance by up to 10% as long as you're wielding a shield (Toughness-based).");
		public static const ShieldSlam:PerkType = mk("Shield Slam", "Shield Slam",
				"Reduces shield bash diminishing returns by 50% and increases bash damage by 20%.",
				"You choose the 'Shield Slam' perk.  Stun diminishing returns is reduced by 50% and shield bash damage is increased by 20%.");
		public static const ShieldWard:PerkType = mk("Shield Ward", "Shield Ward",
				"When you wearing a shield lower chance to be knocked back or disarmed by enemy attacks.",
				"You choose the 'Shield Ward' perk, allowing to lower chance to be knocked back or disarmed when using shield.");
		public static const ShitYouTouchedSasha:PerkType = mk("SHIT YOU TOUCHED SASHA!!!", "SHIT YOU TOUCHED SASHA!!!",
				"DIE!!! (You're fucked... not even this final +10% ranged damage buff will save your sorry ass...)",
				"You choose the 'SHIT YOU TOUCHED SASHA!!!' perk, gaining +10% range phys dmg.");
		public static const SkippingWork:PerkType = mk("Skipping Work", "Skipping Work",
				"Sample Text Here/+20% fatigue recovery rate",
				"You choose the 'Skipping Work' perk, gaining +20% fatigue recovery rate.");
		public static const Slayer:PerkType = mk("Slayer", "Slayer",
				"Increase sneaky attack dmg by another 300% base value (7x).",
				"You choose the 'Slayer' perk. Increase sneaky attack dmg by another 300% base value (7x).");
		public static const SluttySimplicity:PerkType = mk("Slutty Simplicity", "Slutty Simplicity",
				"Increases by 10% tease effect when you are naked. (Undergarments won't disable this perk.)",
				"You choose the 'Slutty Simplicity' perk, granting increased tease effect when you are naked.");
		public static const SneakyAttack:PerkType = mk("Sneaky attack", "Sneaky attack",
				"Strike the vitals of a stunned, blinded or distracted opponent for heavy damage (2x).",
				"You choose the 'Sneaky attack' perk. Strike the vitals of a stunned, blinded or distracted opponent for heavy damage (2x).");
		public static const SnipersFriend:PerkType = mk("Sniper's Friend", "Sniper's Friend",
				"Angry Ausie Noises! (Did you understand him? Neither did I... be careful of the piss jars and get that +10% ranged damage buff!)",
				"You choose the 'Sniper's Friend' perk, gaining +10% range phys dmg.");
		public static const SoldiersFriend:PerkType = mk("Soldier's Friend", "Soldier's Friend",
				"Get out there ya commie! (Just go, don't argue with him and take a +10% ranged damage buff)",
				"You choose the 'Soldier's Friend' perk, gaining +10% range phys dmg.");
		public static const SoulAncestor:PerkType = mk("Soul Ancestor", "Soul Ancestor",
				"Allow reaching 12th stage of soul cultivation. (+35 max Hunger, +5 to max Wis, +140 max SF at lvl 72, 74, 76; +25% to max SF at lvl 72)",
				"You choose the 'Soul Ancestor' perk, reaching 12th stage of soul cultivation! (+35 max Hunger, +140 max SF at lvl 72, 74, 76; +25% to max SF at lvl 72)");
		public static const SoulApprentice:PerkType = mk("Soul Apprentice", "Soul Apprentice",
				"Allow reaching 1st stage of soul cultivation. (+20 max Hunger, +5 to max Wis, +30 max SF at lvl 6, 8, 10; +10% to max SF at lvl 6)",
				"You choose the 'Soul Apprentice' perk, reaching 1st stage of soul cultivation! (+20 max Hunger, +30 max SF at lvl 6, 8, 10; +10% to max SF at lvl 6)");
		public static const SoulEmperor:PerkType = mk("Soul Emperor", "Soul Emperor",
				"Allow reaching 11th stage of soul cultivation. (+35 max Hunger, +5 to max Wis, +130 max SF at lvl 66, 68, 70; +25% to max SF at lvl 66)",
				"You choose the 'Soul Emperor' perk, reaching 11th stage of soul cultivation! (+35 max Hunger, +130 max SF at lvl 66, 68, 70; +25% to max SF at lvl 66)");
		public static const SoulElder:PerkType = mk("Soul Elder", "Soul Elder",
				"Allow reaching 6th stage of soul cultivation. (+25 max Hunger, +5 to max Wis, +80 max SF at lvl 36, 38, 40; +15% to max SF at lvl 36)",
				"You choose the 'Soul Elder' perk, reaching 6th stage of soul cultivation! (+25 max Hunger, +80 max SF at lvl 36, 38, 40; +15% to max SF at lvl 36)");
		public static const SoulExalt:PerkType = mk("Soul Exalt", "Soul Exalt",
				"Allow reaching 7th stage of soul cultivation. (+30 max Hunger, +5 to max Wis, +90 max SF at lvl 42, 44, 46; +20% to max SF at lvl 42)",
				"You choose the 'Soul Exalt' perk, reaching 7th stage of soul cultivation! (+30 max Hunger, +90 max SF at lvl 42, 44, 46; +20% to max SF at lvl 42)");
		public static const SoulKing:PerkType = mk("Soul King", "Soul King",
				"Allow reaching 10th stage of soul cultivation. (+35 max Hunger, +5 to max Wis, +120 max SF at lvl 60, 62, 64; +25% to max SF at lvl 60)",
				"You choose the 'Soul King' perk, reaching 10th stage of soul cultivation! (+35 max Hunger, +120 max SF at lvl 60, 62, 64; +25% to max SF at lvl 60)");
		public static const SoulOfSteel:PerkType = mk("Soul of Steel", "Soul of Steel",
				"Every aspect of you has become a weapon. Your melee damage has increased yet again, but could you even be considered living at this point? (+10% melee phys dmg)",
				"You choose the 'Soul of Steel' perk, gaining +10% melee phys dmg.");
		public static const SoulOverlord:PerkType = mk("Soul Overlord", "Soul Overlord",
				"Allow reaching 8th stage of soul cultivation. (+30 max Hunger, +5 to max Wis, +100 max SF at lvl 48, 50, 52; +20% to max SF at lvl 48)",
				"You choose the 'Soul Overlord' perk, reaching 8th stage of soul cultivation! (+30 max Hunger, +100 max SF at lvl 48, 50, 52; +20% to max SF at lvl 48)");
		public static const SoulPersonage:PerkType = mk("Soul Personage", "Soul Personage",
				"Allow reaching 2nd stage of soul cultivation. (+20 max Hunger, +5 to max Wis, +40 max SF at lvl 12, 14, 16; +10% to max SF at lvl 12)",
				"You choose the 'Soul Personage' perk, reaching 2nd stage of soul cultivation! (+20 max Hunger, +40 max SF at lvl 12, 14, 16; +10% to max SF at lvl 12)");
		public static const SoulPowered:PerkType = mk("Soul Powered", "Soul Powered",
				"You use your soul force more than anything else... increasing its size by 10%.",
				"You choose the 'Soul Powered' perk, gaining +10% max Soulforce.");
		public static const SoulScholar:PerkType = mk("Soul Scholar", "Soul Scholar",
				"Allow reaching 5th stage of soul cultivation. (+25 max Hunger, +5 to max Wis, +70 max SF at lvl 30, 32, 34; +15% to max SF at lvl 30)",
				"You choose the 'Soul Scholar' perk, reaching 5th stage of soul cultivation! (+25 max Hunger, +70 max SF at lvl 30, 32, 34; +15% to max SF at lvl 30)");
		public static const SoulSprite:PerkType = mk("Soul Sprite", "Soul Sprite",
				"Allow reaching 4th stage of soul cultivation. (+25 max Hunger, +5 to max Wis, +60 max SF at lvl 24, 26, 28; +15% to max SF at lvl 24)",
				"You choose the 'Soul Sprite' perk, reaching 4th stage of soul cultivation! (+25 max Hunger, +60 max SF at lvl 24, 26, 28; +15% to max SF at lvl 24)");
		public static const SoulTyrant:PerkType = mk("Soul Tyrant", "Soul Tyrant",
				"Allow reaching 9th stage of soul cultivation. (+30 max Hunger, +5 to max Wis, +110 max SF at lvl 54, 56, 58; +20% to max SF at lvl 54)",
				"You choose the 'Soul Tyrant' perk, reaching 9th stage of soul cultivation! (+30 max Hunger, +110 max SF at lvl 54, 56, 58; +20% to max SF at lvl 54)");
		public static const SoulWarrior:PerkType = mk("Soul Warrior", "Soul Warrior",
				"Allow reaching 3rd stage of soul cultivation. (+20 max Hunger, +5 to max Wis, +50 max SF at lvl 18, 20, 22; +10% to max SF at lvl 18)",
				"You choose the 'Soul Warrior' perk, reaching 3rd stage of soul cultivation! (+20 max Hunger, +50 max SF at lvl 18, 20, 22; +10% to max SF at lvl 18)");
		public static const Spectre:PerkType = mk("Spectre", "Spectre",
				"You have mastered dematerialization, so now you can use it to avoid incoming attacks (+10% to dodge chance) and slip from enemy grasp (you can try to possess during struggle, and even if not successfull you'll escape from constriction).",
				"You choose the 'Spectre' perk. You have mastered dematerialization, so now you can use it to avoid incoming attacks (+10% to dodge chance) and slip from enemy grasp (you can try to possess during struggle, and even if not successfull you'll escape from constriction).");
		public static const SpeedDemon:PerkType = mk("Speed Demon", "Speed Demon",
				"Add speed based scaling of melee attacks when using smaller than large weapon(s).",
				"You choose the 'Speed Demon' perk, allowing you to use your speed when attacking with smaller than large melee weapons.");
		public static const SpeedyRecovery:PerkType = mk("Speedy Recovery", "Speedy Recovery",
				"Regain fatigue +50% out of combat / +100% in combat faster.",
				"You choose the 'Speedy Recovery' perk, boosting your fatigue recovery rate!");
		public static const SpeedyRecuperation:PerkType = mk("Speedy Recuperation", "Speedy Recuperation",
				"Regain fatigue +100% out of combat / +200% in combat faster.",
				"You choose the 'Speedy Recuperation' perk, boosting your fatigue recovery rate!");
		public static const SpeedyRejuvenation:PerkType = mk("Speedy Rejuvenation", "Speedy Rejuvenation",
				"Regain fatigue +200% out of combat / +400% in combat faster.",
				"You choose the 'Speedy Rejuvenation' perk, boosting your fatigue recovery rate!");
		public static const Spellarmor:PerkType = mk("Spellarmor", "Spellarmor",
				"Start every battle with Charge Armor enabled, if you meet White Magic requirements before it starts.",
				"You choose the 'Spellarmor' perk. You start every battle with Charge Armor effect, as long as your Lust is not preventing you from casting it before battle.");
		public static const Spellpower:PerkType = mk("Spellpower", "Spellpower",
				"[if (player.inte>=50)" +
						"Increases base spell strength by 10% and mana pool by 15." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Spellpower' perk.  Thanks to your sizeable intellect and willpower, you are able to more effectively use magic, boosting base spell effects by 10% and mana pool by 15.");
		public static const SpellpowerHealing:PerkType = mk("Spellpower: Healing", "Spellpower: Healing",
				"[if (player.wis>=50)" +
						"Increases base spell strength by 20% and mana pool by 30." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Spellpower: Healing' perk.  Thanks to your sizeable intellect and willpower, you are able to more effectively use magic, boosting base healing spell effects by 20% and mana pool by 30.");
		public static const Spellsword:PerkType = mk("Spellsword", "Spellsword",
				"Start every battle with Charge Weapon enabled, if you meet White Magic requirements before it starts.",
				"You choose the 'Spellsword' perk. You start every battle with Charge Weapon effect, as long as your Lust is not preventing you from casting it before battle.");
		public static const SpinAttack:PerkType = mk("Spin Attack", "Spin Attack",
				"Allow using P. Special Wing Slap when having proper type of wings and flying. (the bigger (higher tier) wings the higher dmg)",
				"You choose the 'Spin Attack' perk, learning to use your wings to use Wing Slam attack when in air.");
		public static const SpiritedDive:PerkType = mk("Spirited Dive", "Spirited Dive",
				"You can perform a terrifying dive-bomb attack. (Great Dive have full AoE dmg bonus vs Groups)",
				"You choose the 'Spirited Dive' perk, learning to perform terrifying dive-bomb attack. (AoE dmg on Great Dive)");
		public static const SpysEnemy:PerkType = mk("Spy's Enemy", "Spy's Enemy",
				"Backst- Enemy Spy is here! Aww Dammit! (Close call there... I'd take the +10% ranged damage buff before he comes back)",
				"You choose the 'Spy's Enemy' perk, gaining +10% range phys dmg.");
		public static const StarlightStrikes:PerkType = mk("Starlight Strikes", "Starlight Strikes",
				"[if(player.spe>=60)" +
						"Increases the attack damage for small weapons.</b>" +
						"|" +
						"<b>You are too slow to benefit from this perk.</b>" +
						"]",
				"You choose the 'Starlight Strikes' perk, increasing the attack damage for small weapons.</b>");
		public static const SteelImpact:PerkType = mk("Steel Impact", "Steel Impact",
				"Add a part of your toughness to your weapon and shield damage.",
				"You choose the 'Steel Impact' perk. Increasing damage of your weapon and shield.");
		public static const SteelStorm:PerkType = mk("Steel Storm", "Steel Storm",
				"Gain two (or four/six if PC normaly attack 5+/9+ times per turn) extra attack when dual wielding.",
				"You choose the 'Steel Storm' perk. Gain two (or four/six if PC normaly attack 5+/9+ times per turn) extra attack when dual wielding.");
		public static const StrongElementalBond:PerkType = mk("Strong Elemental Bond", "Strong Elemental Bond",
				"Lower by 10 needed mana to sustain active elemental in combat.",
				"You choose the 'Strong Elemental Bond' perk, enhancing your connection with elementals and lowering mana needed to maintain bonds.");
		public static const StrongerElementalBond:PerkType = mk("Stronger Elemental Bond", "Stronger Elemental Bond",
				"Lower by 20 needed mana to sustain active elemental in combat.",
				"You choose the 'Stronger Elemental Bond' perk, futher enhancing your connection with elementals.");
		public static const StrongestElementalBond:PerkType = mk("Strongest Elemental Bond", "Strongest Elemental Bond",
				"Lower by 30 needed mana to sustain active elemental in combat.",
				"You choose the 'Strongest Elemental Bond' perk, reaching near the peak of connection strength with your elementals.");
		public static const StrongestElementalBondEx:PerkType = mk("Strongest Elemental Bond (Ex)", "Strongest Elemental Bond (Ex)",
				"Lower by 40 needed mana to sustain active elemental in combat.",
				"You choose the 'Strongest Elemental Bond (Ex)' perk, reaching near the peak of connection strength with your elementals.");
		public static const StrongestElementalBondSu:PerkType = mk("Strongest Elemental Bond (Su)", "Strongest Elemental Bond (Su)",
				"Lower by 40 needed mana to sustain active elemental in combat.",
				"You choose the 'Strongest Elemental Bond (Su)' perk, reaching near the peak of connection strength with your elementals.");
		public static const Studious:PerkType = mk("Studious", "Studious",
				"You're a new student, kinda have to be studious. Your hours of study has helped you increase max mana by 10%.",
				"You choose the 'Studious' perk, gaining +10% max Mana.");
		public static const SuperChargedCore:PerkType = mk("Super Charged Core", "Super Charged Core",
				"At the cost of using additional mana you can super charge each temporal golem core attaing ever better effects than before.",
				"You choose 'Super Charged Core' perk, learning how to make core charging more effective.");
		public static const SuperiorEndurance:PerkType = mk("Superior Endurance", "Superior Endurance",
				"Increases maximum fatigue by 500.",
				"You choose the 'Superior Endurance' perk. Thanks to your superior physical conditioning, your maximum fatigue has been increased by 500!</b>");
		public static const SuperiorSelfControl:PerkType = mk("Superior Self-Control", "Superior Self-Control",
				"Increases maximum lust by 250.",
				"You choose the 'Superior Self-Control' perk. Thanks to your superior mental conditioning, your maximum lust has been increased by 250!</b>");
		public static const SuperiorSpirituality:PerkType = mk("Superior Spirituality", "Superior Spirituality",
				"Increases maximum mana by 750.",
				"You choose the 'Superior Spirituality' perk. Thanks to your superior mystical conditioning, your maximum mana has been increased by 750!</b>");
		public static const SuperiorTranquilness:PerkType = mk("Superior Tranquilness", "Superior Tranquilness",
				"Increases maximum wrath by 250.",
				"You choose the 'Superior Tranquilness' perk. Thanks to your superior anger managment training, your maximum wrath has been increased by 250!</b>");
		public static const SuperSensual:PerkType = mk("Super Sensual", "Super Sensual",
				"Lowering by another ~40% needed exp to lvl-up tease, increasing max tease lvl cap to 50, increasing a bit lust dmg when tease chance is above 100% (each 1% above 100% increase lust dmg by ~1%) and +2 more tease exp after succes.",
				"You choose the 'Super Sensual' perk, lowering by another ~33% needed exp to lvl-up tease, increasing max tease lvl cap to 50, increasing a bit lust dmg when tease chance is above 100% and +2 more tease exp after succes.");
		public static const Surgeon:PerkType = mk("Surgeon", "Surgeon",
				"You saved many lives while working, and thus have an intimate knowledge of how your body works, knowing exactly what to do in any situation. This helps you take care of yourself, and increases health regen.",
				"You choose the 'Surgeon' perk, increasing HP gains by 20%.");
		public static const SurgeonsAide:PerkType = mk("Surgeon's Aide", "Surgeon's Aide",
				"You were the head aide of the surgeon, making sure they had everything they need. By working to make sure nothing went wrong, you have a better understanding at how to heal yourself, increasing health regen.",
				"You choose the 'Surgeon's Aide' perk, increasing HP gains by 20%.");
		public static const Survivalist:PerkType = mk("Survivalist", "Survivalist",
				"Slows hunger rate by 20%.",
				"You choose the 'Survivalist' perk.  With this perk, your hunger rate is reduced by 20%.");
		public static const Survivalist2:PerkType = mk("Survivalist 2", "Survivalist 2",
				"Slows hunger rate by further 20%.",
				"You choose the 'Survivalist 2' perk.  With this perk, your hunger rate is reduced by another 20%.");
		public static const StaffChanneling:PerkType = mk("Staff Channeling", "Staff Channeling",
				"Basic attack with wizard's staff is replaced with ranged magic bolt.",
				"You choose the 'Staff Channeling' perk. Basic attack with wizard's staff is replaced with ranged magic bolt.");
		public static const StrongBack:PerkType = mk("Strong Back", "Strong Back",
				"Enables sixth item slot.",
				"You choose the 'Strong Back' perk, enabling a sixth item slot.");
		public static const StrongBack2:PerkType = mk("Strong Back 2: Strong Harder", "Strong Back 2: Strong Harder",
				"Enables seventh item slot.",
				"You choose the 'Strong Back 2: Strong Harder' perk, enabling a seventh item slot.");
		public static const StrongBack3:PerkType = mk("Strong Back 3: Strong Hardest", "Strong Back 3: Strong Hardest",
				"Enables eighth item slot.",
				"You choose the 'Strong Back 3: Strong Hardest' perk, enabling a eighth item slot.");
		public static const SwiftCasting:PerkType = mk("Swift casting", "Swift casting",
				"When attacking with melee using a one handed weapon with no shield equiped, pc can choose an available spell in combat options to cast during the round. It will be used at the end of the full attack.",
				"You choose the 'Swift casting' perk, allowing to cast one of simple spells after melee attack.");
		public static const Tactician:PerkType = mk("Tactician", "Tactician",
				"[if(player.inte>=50)" +
						"Increases physical critical hit chance by up to 10% (Intelligence-based)." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Tactician' perk, increasing physical critical hit chance by up to 10% (Intelligence-based).");
		public static const TakingABreak:PerkType = mk("Taking a Break", "Taking a Break",
				"Sample Text Here/+20% fatigue recovery rate",
				"You choose the 'Taking a Break' perk, gaining +20% fatigue recovery rate.");
		public static const TankI:PerkType = mk("Tank I", "Tank I",
				"+3 extra HP per point of toughness.",
				"You choose the 'Tank I' perk, granting +3 extra maximum HP for each point of toughness.");
		public static const TankII:PerkType = mk("Tank II", "Tank II",
				"+3 extra HP per point of toughness.",
				"You choose the 'Tank II' perk, granting +3 extra maximum HP for each point of toughness.");
		public static const TankIII:PerkType = mk("Tank III", "Tank III",
				"+3 extra HP per point of toughness.",
				"You choose the 'Tank III' perk, granting +3 extra maximum HP for each point of toughness.");
		public static const TankIV:PerkType = mk("Tank IV", "Tank IV",
				"+3 extra HP per point of toughness.",
				"You choose the 'Tank IV' perk, granting +3 extra maximum HP for each point of toughness.");
		public static const TankV:PerkType = mk("Tank V", "Tank V",
				"+3 extra HP per point of toughness.",
				"You choose the 'Tank V' perk, granting +3 extra maximum HP for each point of toughness.");
		public static const TankVI:PerkType = mk("Tank VI", "Tank VI",
				"+3 extra HP per point of toughness.",
				"You choose the 'Tank VI' perk, granting +3 extra maximum HP for each point of toughness.");
		public static const Teacher:PerkType = mk("Teacher", "Teacher",
				"Instead of being taught, now you teach others. Your skill allows you to increase max mana by 10%.",
				"You choose the 'Teacher' perk, gaining +10% max Mana.");
		public static const ThirdRing:PerkType = mk("Third Ring", "Third Ring",
				"Your advanced understanding of magic pools allows you to equip third ring.",
				"You choose the 'Third Ring' perk, reaching advanced understanding of magic pools to allow you equip third ring.");
		public static const ThirstForBlood:PerkType = mk("Thirst for blood", "Thirst for blood",
				"Weapon and effect that causes bleed damage have this damage increased by 50%.",
				"You choose the 'Thirst for blood' perk, increasing damage done by bleed effects.");
		public static const ThunderousStrikes:PerkType = mk("Thunderous Strikes", "Thunderous Strikes",
				"+20% 'Attack' damage while strength is at or above 80.",
				"You choose the 'Thunderous Strikes' perk, increasing normal damage by 20% while your strength is over 80.");
		public static const TitanGrip:PerkType = mk("Titan's Grip", "Titan's Grip",
				"Gain an ability to wield massive weapons in one hand. (+5 to max Str)",
				"You choose the 'Titan's Grip' perk, gaining an ability to wield large weapons in one hand. (+5 to max Str)");
		public static const TitanGripEx:PerkType = mk("Titan's Grip (Ex)", "Titan's Grip (Ex)",
				"Gain an ability to wield large weapons in one hand. (+5 to max Str/Tou)",
				"You choose the 'Titan's Grip (Ex)' perk, gaining an ability to wield large weapons in one hand. (+5 to max Str/Tou)");
		public static const TitanGripSu:PerkType = mk("Titan's Grip (Su)", "Titan's Grip (Su)",
				"Gain an ability to wield large weapons in one hand. (+5 to max Str/Tou/Spe)",
				"You choose the 'Titan's Grip (Su)' perk, gaining an ability to wield large weapons in one hand. (+5 to max Str/Tou/Spe)");
		public static const Tongs:PerkType = mk("Tongs", "Tongs",
				"You no longer burn your hands when forging, allowing you to actually get work done! This increases armor proficiency. (+5% phys/mag resistance)",
				"You choose the 'Tongs' perk, increasing armor proficiency. (+5% phys/mag resistance)");
		public static const Tornado:PerkType = mk("Tornado", "Tornado",
				"Increasing damage of aoe like whirlwind by 100% of base value.",
				"You choose the 'Tornado' perk, increasing damage by aoe specials like whirlwind.");
		public static const ToughHide:PerkType = mk("Tough Hide", "Tough Hide",
				"Increase your armor by 2 and magic resistance by 1 so long as you have scale chitin fur or other natural armor. (boost scalable with ng tiers)",
				"You choose the 'Tough Hide' perk, increase your armor and magic resistance as long you have any natural armor!");
		public static const TrachealSystem:PerkType = mk("Tracheal System", "Tracheal System",
				"Your body posses rudimentary respiratory system of the insects.",
				"You choose the 'Tracheal System' perk, by becoming much more insect-like your body started to denvelop crude version of insects breathing system.");
		public static const TrachealSystemEvolved:PerkType = mk("Tracheal System (Evolved)", "Tracheal System (Evolved)",
				"Your body posses half developed respiratory system of the insects. (+5 to max str (scalable))",
				"You choose the 'Tracheal System (Evolved)' perk, continuous exposition to insectoidal changes caused your tracheal system evolution into more complete form.");
		public static const TrachealSystemFinalForm:PerkType = mk("Tracheal System (Final Form)", "Tracheal System (Final Form)",
				"Your body posses fully developed respiratory system of the insects. (+10 to max spe (scalable))",
				"You choose the 'Tracheal System (Final Form)' perk, continued exposition to insectoidal changes caused your tracheal system evolution into it final form.");
		public static const TraditionalMageI:PerkType = mk("Traditional Mage I", "Traditional Mage I",
				"You gain 100% spell effect multiplier while using a staff and either a tome or no ranged weapon.",
				"You choose the 'Traditional Mage I' perk, boosting your base spell effects while using a staff and either a tome or no ranged weapon.");
		public static const TraditionalMageII:PerkType = mk("Traditional Mage II", "Traditional Mage II",
				"You gain 100% spell effect multiplier while using a staff and either a tome or no ranged weapon.",
				"You choose the 'Traditional Mage II' perk, boosting your base spell effects while using a staff and either a tome or no ranged weapon.");
		public static const TraditionalMageIII:PerkType = mk("Traditional Mage III", "Traditional Mage III",
				"You gain 100% spell effect multiplier while using a staff and either a tome or no ranged weapon.",
				"You choose the 'Traditional Mage III' perk, boosting your base spell effects while using a staff and either a tome or no ranged weapon.");
		public static const TraditionalMageIV:PerkType = mk("Traditional Mage IV", "Traditional Mage IV",
				"You gain 100% spell effect multiplier while using a staff and either a tome or no ranged weapon.",
				"You choose the 'Traditional Mage IV' perk, boosting your base spell effects while using a staff and either a tome or no ranged weapon.");
		public static const TraditionalMageV:PerkType = mk("Traditional Mage V", "Traditional Mage V",
				"You gain 100% spell effect multiplier while using a staff and either a tome or no ranged weapon.",
				"You choose the 'Traditional Mage V' perk, boosting your base spell effects while using a staff and either a tome or no ranged weapon.");
		public static const TraditionalMageVI:PerkType = mk("Traditional Mage VI", "Traditional Mage VI",
				"You gain 100% spell effect multiplier while using a staff and either a tome or no ranged weapon.",
				"You choose the 'Traditional Mage VI' perk, boosting your base spell effects while using a staff and either a tome or no ranged weapon.");
		public static const Trance:PerkType = mk("Trance", "Trance",
				"Unlocked ability to enter a state in which PC assumes a crystalline form, enhancing physical and mental abilities at cost of constant using soulforce.",
				"You choose the 'Trance' perk, which unlock 'Trance' special. It enhancing physical and mental abilities at cost of constant using soulforce.");
		public static const Transference:PerkType = mk("Transference", "Transference",
				"Your mastery of lust and desire allows you to transfer 15% of your current arousal to your opponent.",
				"You choose the 'Transference' perk, granting ability to transfer your own arousal to your opponent.");
		public static const TripleAttack:PerkType = mk("Triple Attack", "Triple Attack",
				"Allows you to perform three melee attacks with non-large weapons per round.",
				"You choose the 'Triple Attack' perk.  This allows you to make three melee attacks with non-large weapons.");
		public static const TripleAttackLarge:PerkType = mk("Triple Attack (Large)", "Triple Attack (Large)",
				"Allows you to perform three melee attacks with large weapons per round.",
				"You choose the 'Triple Attack (Large)' perk.  This allows you to make three melee attacks with large weapons.");
		public static const TripleAttackSmall:PerkType = mk("Triple Attack (Small)", "Triple Attack (Small)",
				"Allows you to perform three melee attacks with small weapons per round.",
				"You choose the 'Triple Attack (Small)' perk.  This allows you to make three melee attacks with small weapons.");
		public static const TripleStrike:PerkType = mk("Triple Strike", "Triple Strike",
				"Allows you to perform three range attacks per round.",
				"You choose the 'Triple Strike' perk.  This allows you to make three range attacks.");
		public static const TwinRiposte:PerkType = mk("Twin Riposte", "Twin Riposte",
				"Upon a successful parry when dual wielding deal two attack.",
				"You choose the 'Twin Riposte' perk. Upon a successful parry when dual wielding deal two attack.");
		public static const Unhindered:PerkType = mk("Unhindered", "Unhindered",
				"Increases chances of evading enemy attacks when you are naked. (Undergarments won't disable this perk.)",
				"You choose the 'Unhindered' perk, granting chance to evade when you are naked.");
		public static const UnlockArdor:PerkType = mk("Unlock: Ardor", "Unlock: Ardor (1st Stage)",
				"Unlocking ardor grants additional 1 Lust on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Ardor (1st Stage)' perk, allowing you to increase passive Lust gains on lvl-up!");
		public static const UnlockArdor2ndStage:PerkType = mk("Unlock: Ardor (2nd Stage)", "Unlock: Ardor (2nd Stage)",
				"Unlocking ardor grants additional 1 Lust on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Ardor (2nd Stage)' perk, allowing you to increase passive Lust gains on lvl-up!");
		public static const UnlockArdor3rdStage:PerkType = mk("Unlock: Ardor (3rd Stage)", "Unlock: Ardor (3rd Stage)",
				"Unlocking ardor grants additional 1 Lust on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Ardor (3rd Stage)' perk, allowing you to increase passive Lust gains on lvl-up!");
		public static const UnlockArdor4thStage:PerkType = mk("Unlock: Ardor (4th Stage)", "Unlock: Ardor (4th Stage)",
				"Unlocking ardor grants additional 1 Lust on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Ardor (4th Stage)' perk, allowing you to increase passive Lust gains on lvl-up!");
		public static const UnlockBody:PerkType = mk("Unlock: Body", "Unlock: Body (1st Stage)",
				"Unlocking body potential grants additional 15 HP on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Body (1st Stage)' perk, allowing you to increase passive HP gains on lvl-up!");
		public static const UnlockBody2ndStage:PerkType = mk("Unlock: Body (2nd Stage)", "Unlock: Body (2nd Stage)",
				"Unlocking body potential grants additional 15 HP on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Body (2nd Stage)' perk, allowing you to increase passive HP gains on lvl-up!");
		public static const UnlockBody3rdStage:PerkType = mk("Unlock: Body (3rd Stage)", "Unlock: Body (3rd Stage)",
				"Unlocking body potential grants additional 15 HP on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Body (3rd Stage)' perk, allowing you to increase passive HP gains on lvl-up!");
		public static const UnlockBody4thStage:PerkType = mk("Unlock: Body (4th Stage)", "Unlock: Body (4th Stage)",
				"Unlocking body potential grants additional 15 HP on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Body (4th Stage)' perk, allowing you to increase passive HP gains on lvl-up!");
		public static const UnlockEndurance:PerkType = mk("Unlock: Endurance", "Unlock: Endurance (1st Stage)",
				"Unlocking innate endurance grants additional 5 Fatigue on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Endurance (1st Stage)' perk, allowing you to increase passive Fatigue gains on lvl-up!");
		public static const UnlockEndurance2ndStage:PerkType = mk("Unlock: Endurance (2nd Stage)", "Unlock: Endurance (2nd Stage)",
				"Unlocking innate endurance grants additional 5 Fatigue on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Endurance (2nd Stage)' perk, allowing you to increase passive Fatigue gains on lvl-up!");
		public static const UnlockEndurance3rdStage:PerkType = mk("Unlock: Endurance (3rd Stage)", "Unlock: Endurance (3rd Stage)",
				"Unlocking innate endurance grants additional 5 Fatigue on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Endurance (3rd Stage)' perk, allowing you to increase passive Fatigue gains on lvl-up!");
		public static const UnlockEndurance4thStage:PerkType = mk("Unlock: Endurance (4th Stage)", "Unlock: Endurance (4th Stage)",
				"Unlocking innate endurance grants additional 5 Fatigue on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Endurance (4th Stage)' perk, allowing you to increase passive Fatigue gains on lvl-up!");
		public static const UnlockId:PerkType = mk("Unlock: Id", "Unlock: Id (1st Stage)",
				"Unlocking id grants additional 1 Wrath on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Id (1st Stage)' perk, allowing you to increase passive Wrath gains on lvl-up!");
		public static const UnlockId2ndStage:PerkType = mk("Unlock: Id (2nd Stage)", "Unlock: Id (2nd Stage)",
				"Unlocking id grants additional 1 Wrath on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Id (2nd Stage)' perk, allowing you to increase passive Wrath gains on lvl-up!");
		public static const UnlockId3rdStage:PerkType = mk("Unlock: Id (3rd Stage)", "Unlock: Id (3rd Stage)",
				"Unlocking id grants additional 1 Wrath on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Id (3rd Stage)' perk, allowing you to increase passive Wrath gains on lvl-up!");
		public static const UnlockId4thStage:PerkType = mk("Unlock: Id (4th Stage)", "Unlock: Id (4th Stage)",
				"Unlocking id grants additional 1 Wrath on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Id (4th Stage)' perk, allowing you to increase passive Wrath gains on lvl-up!");
		public static const UnlockSpirit:PerkType = mk("Unlock: Spirit", "Unlock: Spirit (1st Stage)",
				"Unlocking spirit potential grants additional 5 Soulforce on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Spirit (1st Stage)' perk, allowing you to increase passive Soulforce gains on lvl-up!");
		public static const UnlockSpirit2ndStage:PerkType = mk("Unlock: Spirit (2nd Stage)", "Unlock: Spirit (2nd Stage)",
				"Unlocking spirit potential grants additional 5 Soulforce Spirit each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Spirit (2nd Stage)' perk, allowing you to increase passive Soulforce gains on lvl-up!");
		public static const UnlockSpirit3rdStage:PerkType = mk("Unlock: Spirit (3rd Stage)", "Unlock: Spirit (3rd Stage)",
				"Unlocking spirit potential grants additional 5 Soulforce on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Spirit (3rd Stage)' perk, allowing you to increase passive Soulforce gains on lvl-up!");
		public static const UnlockSpirit4thStage:PerkType = mk("Unlock: Spirit (4th Stage)", "Unlock: Spirit (4th Stage)",
				"Unlocking spirit potential grants additional 5 Soulforce on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Spirit (4th Stage)' perk, allowing you to increase passive Soulforce gains on lvl-up!");
		public static const UnlockForce:PerkType = mk("Unlock: Force", "Unlock: Force (1st Stage)",
				"Unlocking magic potential grants additional 10 Mana on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Force (1st Stage)' perk, allowing you to increase passive Mana gains on lvl-up!");
		public static const UnlockForce2ndStage:PerkType = mk("Unlock: Force (2nd Stage)", "Unlock: Force (2nd Stage)",
				"Unlocking magic potential grants additional 10 Mana on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Force (2nd Stage)' perk, allowing you to increase passive Mana gains on lvl-up!");
		public static const UnlockForce3rdStage:PerkType = mk("Unlock: Force (3rd Stage)", "Unlock: Force (3rd Stage)",
				"Unlocking magic potential grants additional 10 Mana on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Force (3rd Stage)' perk, allowing you to increase passive Mana gains on lvl-up!");
		public static const UnlockForce4thStage:PerkType = mk("Unlock: Force (4th Stage)", "Unlock: Force (4th Stage)",
				"Unlocking magic potential grants additional 10 Mana on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Force (4th Stage)' perk, allowing you to increase passive Mana gains on lvl-up!");
		public static const VampiricBlade:PerkType = mk("Vampiric blade", "Vampiric blade",
				"PC recovers 0.5/1/2/4 % of its health each time it strikes with a melee attack. (% restored depend on weapon size used)",
				"You choose the 'Vampiric blade' perk, recovering some HP after each succesfull melee attack.");
		public static const VampiricBloodsteam:PerkType = mk("Vampiric Bloodsteam", "Vampiric Bloodsteam",
				"Your bloodsteam started to adapt to presence of vampiric blood. (+15 max stacks of Vampire Thirst)",
				"You choose the 'Vampiric Bloodsteam' perk. Your bloodsteam started to adapt to presence of vampiric blood.");
		public static const VampiricBloodsteamEvolved:PerkType = mk("Vampiric Bloodsteam (Evolved)", "Vampiric Bloodsteam (Evolved)",
				"Your bloodsteam halfway adapted to presence of vampiric blood. (+30 max stacks of Vampire Thirst, Vampire Thirst stack decay each 2 days)",
				"You choose the 'Vampiric Bloodsteam (Evolved)' perk, increasing adaptation level to vampiric blood in your veins.");
		public static const VampiricBloodsteamFinalForm:PerkType = mk("Vampiric Bloodsteam (Final Form)", "Vampiric Bloodsteam (Final Form)",
				"Your bloodsteam fully adapted to presence of vampiric blood. (+60 max stacks of Vampire Thirst, 50% higher bonus from each Vampire Thirst stack)",
				"You choose the 'Vampiric Bloodsteam (Final Form)' perk. Your bloodsteam fully adapted to presence of vampiric blood.");
		public static const VenomGlands:PerkType = mk("Venom Glands", "Venom Glands",
				"Your body posses rudimentary venom glands along with changes in teeth to been able use this venom when biting.",
				"You choose the 'Venom Glands' perk, by becoming much more venomous your body started to denvelop crude version of venom glads along with slight changes to your teeth.");
		public static const VenomGlandsEvolved:PerkType = mk("Venom Glands (Evolved)", "Venom Glands (Evolved)",
				"Your body posses half developed venom glands increasing their capacity. (+5% poison resistance)",
				"You choose the 'Venom Glands (Evolved)' perk, continuous usage of the venom caused your venom glands evolution into more complete form.");
		public static const VenomGlandsFinalForm:PerkType = mk("Venom Glands (Final Form)", "Venom Glands (Final Form)",
				"Your body posses fully developed venom glands with large reservoir of venom and good recharge speed. (+10% to poison resistance and +10 max Tou (scalable))",
				"You choose the 'Venom Glands (Final Form)' perk, after long time usage of venom from your glands they evolved into their final form.");
		public static const VitalShot:PerkType = mk("Vital Shot", "Vital Shot",
				"Gain a +10% chance to do a critical strike with arrows.",
				"You choose the 'Vital Shot' perk, gaining an additional +10% chance to cause a critical hit with arrows.");
		public static const WarCaster:PerkType = mk("War caster", "War caster",
				"Increases magical and physical critical chance by up to 25% based on intelligence.",
				"You choose the 'War caster' perk, increasing magical and physical critical chance by up to 25% based on intelligence.");
		public static const Weap0n:PerkType = mk("Weapon", "Weapon",
				"Now that you've forged your first weapon, you have a better handling on how they work, allowing you to forge even better armor. Once again, your proficiency in armors increase! (+5% phys/mag resistance)",
				"You choose the 'Weapon' perk, increasing armor proficiency. (+5% phys/mag resistance)");
		public static const WeaponGrandMastery:PerkType = mk("Weapon Grandmastery", "Weapon Grandmastery",
				"[if(player.str>139)" +
						"Double damage bonus of weapons classified as 'Large' and 'Dual Large'. Additionaly 10% higher chance to crit with dual large weapons." +
						"|" +
						"<b>You aren't strong enough to benefit from this anymore.</b>" +
						"]",
				"You choose the 'Weapon Grandmastery' perk, doubling the effectiveness of large or dual large weapons.");
		public static const WeaponMastery:PerkType = mk("Weapon Mastery", "Weapon Mastery",
				"[if(player.str>99)" +
						"One and half damage bonus of weapons classified as 'Large'. Additionaly 10% higher chance to crit with those weapons." +
						"|" +
						"<b>You aren't strong enough to benefit from this anymore.</b>" +
						"]",
				"You choose the 'Weapon Mastery' perk, getting one and half of the effectiveness of large weapons.");
		public static const WellAdjusted:PerkType = mk("Well Adjusted", "Well Adjusted",
				"You gain half as much lust as time passes in Mareth.",
				"You choose the 'Well Adjusted' perk, reducing the amount of lust you naturally gain over time while in this strange land!");
		public static const Whipping:PerkType = mk("Whipping", "Whipping",
				"Whipping special deal increased damage based on current strength.",
				"You choose the 'Whipping' perk, making your Whipping special stronger.");
		public static const Whirlwind:PerkType = mk("Whirlwind", "Whirlwind",
				"Whirlwind special deal increased damage based on current strength.",
				"You choose the 'Whirlwind' perk, making your Whirlwind special stronger.");
		public static const WhirlwindFeral:PerkType = mk("Feral Whirlwind", "Feral Whirlwind",
				"Feral Whirlwind special deal increased damage based on current strength and unarmed bonus.",
				"You choose the 'Feral Whirlwind' perk, making your Feral Whirlwind special stronger.");
		public static const Whistles:PerkType = mk("Whistles", "Whistles",
				"Sample Text Here/+20% fatigue recovery rate",
				"You choose the 'Whistles' perk, gaining +20% fatigue recovery rate.");
		public static const WildQuiver:PerkType = mk("Wild Quiver", "Wild Quiver",
				"You grab and shoot arrows at blinding speed, gaining an extra shot.",
				"You choose the 'Wild Quiver' perk, you combine it with triple attack and manyshot to shoot up to 5 times.");
		public static const WisenedHealer:PerkType = mk("Wisened Healer", "Wisened Healer",
				"Adds wisdom based scaling to healing spells at cost of doubling spells costs.",
				"You choose the 'Wisened Healer' perk. Increasing healing spells effects based on current wisdom.");
		public static const Wizened:PerkType = mk("Wizened", "Wizened",
				"You are wise, what did you expect, something wise? You do get 10% more soulforce though.",
				"You choose the 'Wizened' perk, gaining +10% max Soulforce.");
		public static const ZZZ:PerkType = mk("ZZZ", "ZZZ",
				"Sample Text Here/+20% fatigue recovery rate",
				"You choose the 'ZZZ' perk, gaining +20% fatigue recovery rate.");
		//Perki obecnie nie używanie nigdzie - do usuniecia lub wykorzystania w czymś innym
		public static const UnlockMind:PerkType = mk("Unlock: Mind", "Unlock: Mind (1st Stage)",
				"Unlocking mind potential grants additional 5 Mana on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Mind (1st Stage)' perk, allowing you to increase passive Mana gains on lvl-up!");
		public static const UnlockMind2ndStage:PerkType = mk("Unlock: Mind (2nd Stage)", "Unlock: Mind (2nd Stage)",
				"Unlocking mind potential grants additional 5 Soulforce on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Mind (2nd Stage)' perk, allowing you to increase passive Soulforce gains on lvl-up!");
		public static const JobSoulArcher:PerkType = mk("Job: Soul Archer", "Job: Soul Archer",
				"You've trained in art of combining soulforce and arrows.",
				"You choose 'Job: Soul Archer' perk, training yourself to became Soul Archer.");
		public static const JobArcaneArcher:PerkType = mk("Job: Arcane Archer", "Job: Arcane Archer",
				"You've trained in art of combining magic and arrows.",
				"You choose 'Job: Arcane Archer' perk, training yourself to became Arcane Archer.");
		public static const JobArcher:PerkType = mk("Job: Archer", "Job: Archer",
				"You've trained in ranged combat.",
				"You choose 'Job: Archer' perk, training yourself to became Archer.");
		public static const JobBarbarian:PerkType = mk("Job: Barbarian", "Job: Barbarian",
				"You've trained in using large weapons in fights.",
				"You choose 'Job: Barbarian' perk, training yourself to became Barbarian.");

		// Needlework perks
		public static const ChiReflowAttack:PerkType = mk("Chi Reflow - Attack", "Chi Reflow - Attack",
				"Regular attacks boosted, but damage resistance decreased.");
		public static const ChiReflowDefense:PerkType = mk("Chi Reflow - Defense", "Chi Reflow - Defense",
				"Passive damage resistance, but caps speed");
		public static const ChiReflowLust:PerkType = mk("Chi Reflow - Lust", "Chi Reflow - Lust",
				"Lust resistance and Tease are enhanced, but Libido and Sensitivity gains increased.");
		public static const ChiReflowMagic:PerkType = mk("Chi Reflow - Magic", "Chi Reflow - Magic",
				"Magic attacks boosted, but regular attacks are weaker.");
		public static const ChiReflowSpeed:PerkType = mk("Chi Reflow - Speed", "Chi Reflow - Speed",
				"Speed reductions are halved but caps strength");

		// Piercing perks
		public static const PiercedCrimstone:PiercedCrimstonePerk = new PiercedCrimstonePerk();
		public static const PiercedIcestone:PiercedIcestonePerk = new PiercedIcestonePerk();
		public static const PiercedFertite:PiercedFertitePerk = new PiercedFertitePerk();
		public static const PiercedFurrite:PerkType = mk("Pierced: Furrite", "Pierced: Furrite",
				"Increases chances of encountering 'furry' foes.");
		public static const PiercedLethite:PerkType = mk("Pierced: Lethite", "Pierced: Lethite",
				"Increases chances of encountering demonic foes.");

		// Cock sock perks
		public static const LustyRegeneration:PerkType = mk("Lusty Regeneration", "Lusty Regeneration",
				"Regenerates 0,5% of HP per round in combat and 1% of HP per hour.");
		public static const MidasCock:PerkType = mk("Midas Cock", "Midas Cock",
				"Increases the gems awarded from victory in battle.");
		public static const PentUp:PentUpPerk = new PentUpPerk();
		public static const PhallicPotential:PerkType = mk("Phallic Potential", "Phallic Potential",
				"Increases the effects of penis-enlarging transformations.");
		public static const PhallicRestraint:PerkType = mk("Phallic Restraint", "Phallic Restraint",
				"Reduces the effects of penis-enlarging transformations.");

		// Non-weapon equipment perks
		public static const Ambition:AmbitionPerk = new AmbitionPerk();
		public static const BlindImmunity:PerkType = mk("Blind Immunity", "Blind Immunity", "Gives PC immunity to enemy blinding effects.");
		public static const BloodMage:PerkType = mk("Blood Mage", "Blood Mage",
				"Spellcasting now consumes health instead of mana!",null,true);
		public static const LastResort:PerkType = mk("Last Resort", "Last Resort",
				"When mana is too low to cast a spell, automatically cast from hp instead.",null,true);
		public static const Obsession:ObsessionPerk = new ObsessionPerk();
		public static const Sanctuary:PerkType = mk("Sanctuary", "Sanctuary", "Regenerates up to 1% of HP scaling on purity.");
		public static const SeersInsight:SeersInsightPerk = new SeersInsightPerk();
		public static const SluttySeduction:SluttySeductionPerk = new SluttySeductionPerk();
		public static const WellspringOfLust:PerkType = mk("Wellspring of Lust", "Wellspring of Lust",
				"At the beginning of combat, gain lust up to black magic threshold if lust is bellow black magic threshold.",null,true);
		public static const WizardsEnduranceAndSluttySeduction:WizardsEnduranceAndSluttySeductionPerk = new WizardsEnduranceAndSluttySeductionPerk();
		public static const WizardsAndDaoistsEndurance:WizardsAndDaoistsEndurancePerk = new WizardsAndDaoistsEndurancePerk();
		public static const WizardsEndurance:WizardsEndurancePerk = new WizardsEndurancePerk();

		// Melee & Range weapon perks
		public static const Accuracy1:Accuracy1Perk = new Accuracy1Perk();
		public static const Accuracy2:Accuracy2Perk = new Accuracy2Perk();
		public static const BladeWarden:PerkType = mk("Blade-Warden", "Blade-Warden",
				"Enables Resonance Volley soul skill while equipped: Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.",null,true);
		public static const BodyCultivatorsFocus:BodyCultivatorsFocusPerk = new BodyCultivatorsFocusPerk();
		public static const DaoistsFocus:DaoistsFocusPerk = new DaoistsFocusPerk();
		public static const DexterousSwordsmanship:PerkType = mk("Dexterous swordsmanship", "Dexterous swordsmanship",
				"Increases parry chance by 10% while wielding a weapon.",null,true);
		public static const MageWarden:PerkType = mk("Mage-Warden", "Mage-Warden",
				"Enables Resonance Volley soul skill while equipped: Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.",null,true);
		public static const SagesKnowledge:SagesKnowledgePerk = new SagesKnowledgePerk();
		public static const StrifeWarden:PerkType = mk("Strife-Warden", "Strife-Warden",
				"Enables Beat of War soul skill while equipped: Attack with low-moderate additional soul damage, gain strength equal to 15% your base strength until end of battle. This effect stacks.",null,true);
		public static const WildWarden:PerkType = mk("Wild-Warden", "Wild-Warden",
				"Enables Resonance Volley soul skill while equipped: Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.",null,true);
		public static const WizardsAndDaoistsFocus:WizardsAndDaoistsFocusPerk = new WizardsAndDaoistsFocusPerk();
		public static const WizardsFocus:WizardsFocusPerk = new WizardsFocusPerk();

		// Achievement perks
		public static const BowShooting:BowShootingPerk = new BowShootingPerk();
		public static const BroodMother:PerkType = mk("Brood Mother", "Brood Mother",
				"Pregnancy moves twice as fast as a normal woman's.");
		public static const SpellcastingAffinity:SpellcastingAffinityPerk = new SpellcastingAffinityPerk();
		public static const Cultivation:PerkType = mk("Cultivation", "Cultivation",
				"Allow to cultivate powers of the soul.",
				"You choose the 'Cultivation' perk, starting journey of the soul cultivation path!");//potem przerobić na coć innego - moze jak perki do czarów i łuku bedzie dawać jakieś korzyści do soul skills po odpowiednio dużej ilości ich użycia czy cos xD

		// Mutation perks
		public static const AcidSpit:PerkType = mk("Acid Spit", "Acid Spit",
				"Allows access to a cave wyrm acid spit attack.");
		public static const AzureflameBreath:PerkType = mk("Azureflame Breath", "Azureflame Breath",
				"Allows access to a cave wyrm azureflame breath attack.");
		public static const Androgyny:PerkType = mk("Androgyny", "Androgyny",
				"No gender limits on facial masculinity or femininity.");
		public static const AquaticAffinity:PerkType = mk("Aquatic Affinity", "Aquatic Affinity",
				"When in an aquatic battle you gains a +30 to strength and speed.");
		public static const AvatorOfCorruption:PerkType = mk("Avatar of Corruption", "Avatar of Corruption",
				"Your impure body grants you shortened spellcasting cooldown and empowered black and healing magic.");
		public static const AvatorOfPurity:PerkType = mk("Avatar of Purity", "Avatar of Purity",
				"Your pure body grants you shortened spellcasting cooldown and empowered white and healing magic.");
		public static const BasiliskWomb:PerkType = mk("Basilisk Womb", "Basilisk Womb",
				"Enables your eggs to be properly fertilized into basilisks of both genders!");
		public static const BeeOvipositor:PerkType = mk("Bee Ovipositor", "Bee Ovipositor",
				"Allows you to lay eggs through a special organ on your insect abdomen, though you need at least 10 eggs to lay.");
		public static const BicornBlessing:PerkType = mk("Bicorn Blessing", "Bicorn Blessing",
				"Your are blessed with the unholy power of a bicorn and while above 80 corruption your black magic is increased by 20% and lust resistance by 10%.");
		public static const BigHandAndFeet:PerkType = mk("Big hand and feet", "Big hand and feet",
				"Increase strength modifier on unarmed attack by 100%.");
		public static const BimboBody:PerkType = mk("Bimbo Body", "Bimbo Body",
				"Gives the body of a bimbo.  Tits will never stay below a 'DD' cup, libido is raised, lust resistance is raised, and upgrades tease.");
		public static const BimboBrains:PerkType = mk("Bimbo Brains", "Bimbo Brains",
				"Now that you've drank bimbo liquer, you'll never, like, have the attention span and intelligence you once did!  But it's okay, 'cause you get to be so horny an' stuff!");
		public static const BouncyBody:PerkType = mk("Bouncy body", "Bouncy body",
				"Attacks that would deal more than half of your health have a chance to simply punt you around, reducing damage taken by 25%.");
		public static const BroBody:PerkType = mk("Bro Body", "Bro Body",
				"Grants an ubermasculine body that's sure to impress.");
		public static const BroBrains:PerkType = mk("Bro Brains", "Bro Brains",
				"Makes thou... thin... fuck, that shit's for nerds.");
		public static const BunnyEggs:PerkType = mk("Bunny Eggs", "Bunny Eggs",
				"Laying eggs has become a normal part of your bunny-body's routine.");
		public static const ColdAffinity:PerkType = mk("Cold Affinity", "Cold Affinity",
				"You have high resistance to cold effects, immunity to the frozen condition, and mastery over ice abilities and magic. However, you are highly susceptible to fire.");
		public static const ColdMastery:PerkType = mk("Cold Mastery", "Cold Mastery",
				"You now have complete control over the ice element adding your own inner power to all cold based attack.");
		public static const CorruptedKitsune:PerkType = mk("Corrupted Kitsune", "Corrupted Kitsune",
				"The mystical energy of the kitsunes surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells, but your method of attaining it has corrupted the transformation, preventing you from achieving true enlightenment.",null,true);
		public static const CorruptedNinetails:PerkType = mk("Corrupted Nine-tails", "Corrupted Nine-tails",
				"The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells, but your method of attaining it has corrupted the transformation, preventing you from achieving true enlightenment.",null,true);
		public static const DarkCharm:PerkType = mk("Dark Charm", "Dark Charm",
				"Allows access to demons charm attacks.");
		public static const DeadMetabolism:PerkType = mk("Dead metabolism", "Dead metabolism",
				"Kills off hunger. (hunger meter wouldn't decay with time)");
		public static const Diapause:PerkType = mk("Diapause", "Diapause",
				"Pregnancy does not advance normally, but develops quickly after taking in fluids.");
		public static const DragonDarknessBreath:PerkType = mk("Dragon darkness breath", "Dragon darkness breath",
				"Allows access to a dragon darkness breath attack.");
		public static const DragonFireBreath:PerkType = mk("Dragon fire breath", "Dragon fire breath",
				"Allows access to a dragon fire breath attack.");
		public static const DragonIceBreath:PerkType = mk("Dragon ice breath", "Dragon ice breath",
				"Allows access to a dragon ice breath attack.");
		public static const DragonLightningBreath:PerkType = mk("Dragon lightning breath", "Dragon lightning breath",
				"Allows access to a dragon lightning breath attack.");
		public static const ElectrifiedDesire:PerkType = mk("Electrified Desire", "Electrified Desire",
				"Masturbating only makes you hornier. Furthermore, your ability to entice, tease and zap things is enhanced the more horny you are.");
		public static const ElementalConjurerMindAndBodyDedication:PerkType = mk("Elemental Conjurer Mind and Body Dedication", "Elemental Conjurer Mind and Body Dedication",
				"Removes all negative modifiers to PC max Str/Tou/Spe caps caused by picking perk Elemental Conjurer Dedication.");
		public static const ElementalConjurerMindAndBodyResolve:PerkType = mk("Elemental Conjurer Mind and Body Resolve", "Elemental Conjurer Mind and Body Resolve",
				"Removes all negative modifiers to PC max Str/Tou/Spe caps caused by picking perk Elemental Conjurer Resolve.");
		public static const ElementalConjurerMindAndBodySacrifice:PerkType = mk("Elemental Conjurer Mind and Body Sacrifice", "Elemental Conjurer Mind and Body Sacrifice",
				"Removes all negative modifiers to PC max Str/Tou/Spe caps caused by picking perk Elemental Conjurer Sacrifice.");
		public static const ElvenSense:PerkType = mk("Elven Sense", "Elven Sense",
				"Gain a chance to dodge attacks and an increased chance to score critical hits.");
		public static const EnergyDependent:PerkType = mk("Energy dependent", "Energy dependent",
				"You become faster, smarter and clearer of mind when well fed in life force. However you become dim witted and stiffer than a corpse when starved. You cannot recover soul force through normal means.");
		public static const EnlightenedKitsune:PerkType = mk("Enlightened Kitsune", "Enlightened Kitsune",
				"The mystical energy of the kitsunes surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells.",null,true);
		public static const EnlightenedNinetails:PerkType = mk("Enlightened Nine-tails", "Enlightened Nine-tails",
				"The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells.",null,true);
		public static const EzekielBlessing:PerkType = mk("Ezekiel Blessing", "Ezekiel Blessing",
				"You've recived blessing of Ezekiel enhancing your body and mind.");
		public static const Feeder:PerkType = mk("Feeder", "Feeder",
				"Lactation does not decrease and gives a compulsion to breastfeed others.");
		public static const FenrirSpikedCollar:PerkType = mk("Fenrir spiked collar", "Fenrir spiked collar",
				"The magical chain as well as the strongly enchanted collar increase damage reduction by 10%.");
		public static const Ferocity:PerkType = mk("Ferocity", "Ferocity",
				"You can remains conscious and continue fighting even if your HP is below 0. You gonna loose 1% of max HP each round and would loose fight when negative HP reach 7% (or more if PC got other perks to stay undefeated below 0%) of max HP.");
		public static const FireAffinity:PerkType = mk("Fire Affinity", "Fire Affinity",
				"You have high resistance to fire effects, immunity to the burn condition, and mastery over fire abilities and magic. However, you are highly susceptible to ice.");
		public static const FlawlessBody:PerkType = mk("Flawless Body", "Flawless Body",
				"Your elven body with its flawless form and skin is so alluring it reinforces your ability to tease.");
		public static const Flexibility:PerkType = mk("Flexibility", "Flexibility",
				"Grants cat-like flexibility.  Useful for dodging and 'fun'.");
		public static const FreezingBreath:PerkType = mk("Freezing Breath (F)", "Freezing Breath (F)",
				"Allows access to Fenrir (AoE) freezing breath attack.");
		public static const FreezingBreathYeti:PerkType = mk("Freezing Breath (Y)", "Freezing Breath (Y)",
				"Allows access to Yeti freezing breath attack.");
		public static const FromTheFrozenWaste:PerkType = mk("From the frozen waste", "From the frozen waste",
				"You are resistant to cold but gain a weakness to fire.");
		public static const FutaFaculties:PerkType = mk("Futa Faculties", "Futa Faculties",
				"It's super hard to think about stuff that like, isn't working out or fucking!");
		public static const FutaForm:PerkType = mk("Futa Form", "Futa Form",
				"Ensures that your body fits the Futa look (Tits DD+, Dick 8\"+, & Pussy).  Also keeps your lusts burning bright and improves the tease skill.");
		public static const GeneticMemory:PerkType = mk("Genetic Memory", "Genetic Memory",
				"Your body can remember almost any transformation it undergone.");
		public static const Ghostslinger:PerkType = mk("Ghost-slinger", "Ghost-slinger",
				"Increases damage with guns and thrown weapons by 15%.");
		public static const GoblinoidBlood:PerkType = mk("Goblinoid blood", "Goblinoid blood",
				"Your blood is highly susceptible to chemical drugs, stimulants and poisons.");
		public static const HaltedVitals:PerkType = mk("Halted vitals", "Halted vitals",
				"Your vitals are frozen in time by the magic of the curse tag, allowing you to live without the need for breathing, eating and a heartbeat. It also reduces damage taken from physical attacks by 20%.");
		public static const HarpyWomb:PerkType = mk("Harpy Womb", "Harpy Womb",
				"Increases all laid eggs to large size so long as you have harpy legs and a harpy tail.");
		public static const HydraAcidBreath:PerkType = mk("Hydra acid breath", "Hydra acid breath",
				"Allows access to a hydra acid breath attack.");
		public static const HydraRegeneration:PerkType = mk("Hydra Regeneration", "Hydra Regeneration",
				"(Amount of hydra heads)% health and (Amount of hydra heads) points of fatigue regeneration but double hunger decaying speed. Stops for 5 rounds when damaged by fire.");
		public static const IcyFlesh:PerkType = mk("Icy flesh", "Icy flesh",
				"You are about as frigid and dead as a corpse however your mastery of ice magic grants you the ability to harden your flesh to the durability of diamonds. Gain an intelligence modifier as a bonus to health calculation equal to that of toughness as well as 1% regeneration. Gain an extra 40% resistance to cold.");
		public static const ImprovedVenomGland:PerkType = mk("Improved venom gland", "Improved venom gland",
				"Increase your venom max capacity and refill speed.");
		public static const Incorporeality:PerkType = mk("Incorporeality", "Incorporeality",
				"Allows you to fade into a ghost-like state and temporarily possess others.");
		public static const InkSpray:PerkType = mk("Ink Spray", "Ink Spray",
				"Allows you to shoot blinding and probably slightly arousing ink out of your genitalia similar like octopus.");
		public static const JunglesWanderer:PerkType = mk("Jungle’s Wanderer", "Jungle’s Wanderer",
				"Your nimble body has adapted to moving through jungles and forests, evading enemy attacks with ease and making yourself harder to catch. (+35 to the Evasion percentage)");
		public static const LifeLeech:PerkType = mk("Life leech", "Life leech",
				"Your unarmed strike steals vital energy from your victims, dealing 5% extra damage and restoring 1% mana, health, fatigue and soulforce per hit.");
		public static const Lycanthropy:PerkType = mk("Lycanthropy", "Lycanthropy",
				"Your strength and urges are directly tied to the cycle of the moon. Furthermore, your skin is more resistant to physical damage and your claws are sharper than normal.");
		public static const LycanthropyDormant:PerkType = mk("Dormant Lycanthropy", "Dormant Lycanthropy",
				"You sometimes hear echoes of the call of the moon. If you were more of a werewolf you likely would feel its pull again. A lycanthrope is never truly cured.");
		public static const Vulpesthropy:PerkType = mk("Vulpesthropy", "Vulpesthropy",
				"Your strength and urges are directly tied to the cycle of the moon. Furthermore, your skin is more resistant to magical damage       .");
		public static const VulpesthropyDormant:PerkType = mk("Dormant Vulpesthropy", "Dormant Vulpesthropy",
				"You sometimes hear echoes of the call of the moon. If you were more of a werefox you likely would feel its pull again. A vulpesthrope is never truly cured.");
		public static const LightningAffinity:PerkType = mk("Lightning Affinity", "Lightning Affinity",
				"Increase all damage dealt with lightning spells by 100% and reduce lightning damage taken by 50%.");
		public static const LightningClaw:PerkType = mk("Lightning claw", "Lightning claw",
				"Your natural weapons are charged with raiju electricity adding a lusty effect to all attacks.");
		public static const LizanRegeneration:PerkType = mk("Lizan Regeneration", "Lizan Regeneration",
				"Regenerates 1.5% of HP per round in combat and 3% of HP per hour and additional slightly increasing maximal attainable natural healing rate.");
		public static const Lustzerker:PerkType = mk("Lustzerker", "Lustzerker",
				"Lustserking increases attack and physical defenses resistance but reduces lust resistance.");
		public static const ManticoreCumAddict:PerkType = mk("Manticore Cum Addict", "Manticore Cum Addict",
				"Causes you to crave cum frequently.  Yet at the same time grants you immunity to Minotaur Cum addiction.");
		public static const MantisOvipositor:PerkType = mk("Mantis Ovipositor", "Mantis Ovipositor",
				"Allows you to lay eggs through a special organ on your insect abdomen, though you need at least 10 eggs to lay.");
		public static const MilkMaid:MilkMaidPerk = new MilkMaidPerk();
		public static const MinotaurCumAddict:PerkType = mk("Minotaur Cum Addict", "Minotaur Cum Addict",
				"Causes you to crave minotaur cum frequently.  You cannot shake this addiction.");
		public static const MinotaurCumResistance:PerkType = mk("Minotaur Cum Resistance", "Minotaur Cum Resistance",
				"You can never become a Minotaur Cum Addict. Grants immunity to Minotaur Cum addiction.");
		public static const Necromancy:PerkType = mk("Necromancy", "Necromancy",
				"Black magic effectiveness is increased by 50%. Soulforce regenerate passively by 2%.");//, Hex and Necromancy		 and recharge 1 round faster
		public static const NinetailsKitsuneOfBalance:PerkType = mk("Nine-tails Kitsune of Balance", "Nine-tails Kitsune of Balance",
				"The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  You tread narrow path between corruption and true enlightment maintaining balance that allow to fuse both sides powers.",null,true);
		public static const Oviposition:PerkType = mk("Oviposition", "Oviposition",
				"Causes you to regularly lay eggs when not otherwise pregnant.");
		public static const PhantomShooting:PerkType = mk("Phantom Shooting", "Phantom Shooting",
				"Thanks to your ghostly form, throwing weapons and firearms now drains some of your ectoplasm with each use instead of using ammunition. (+5% dmg)");
		public static const PhoenixFireBreath:PerkType = mk("Phoenix fire breath", "Phoenix fire breath",
				"Allows access to a phoenix fire breath attack.");
		public static const PoisonNails:PerkType = mk("Poison nails", "Poison nails",
				"Your nails inflict a deadly poison on strike, damaging your foe’s toughness, speed and arousing them.");
		public static const PurityBlessing:PerkType = mk("Purity Blessing", "Purity Blessing",
				"Reduces the rate at which your corruption, libido, and lust increase. Reduces minimum libido and lust slightly.");
		public static const RapierTraining:PerkType = mk("Rapier Training", "Rapier Training",
				"After finishing of your training, increase attack power of any rapier you're using.");
		public static const Rigidity:PerkType = mk("Rigidity", "Rigidity",
				"Your cadaverous rigidity prevents any form of escape in battle.");
		public static const SatyrSexuality:PerkType = mk("Satyr Sexuality", "Satyr Sexuality",
				"Thanks to your satyr biology, you now have the ability to impregnate both vaginas and asses. Also increases your virility rating. (Anal impregnation not implemented yet)");
		public static const SlimeCore:PerkType = mk("Slime Core", "Slime Core",
				"Grants more control over your slimy body, allowing you to go twice as long without fluids.");
		public static const SpiderOvipositor:PerkType = mk("Spider Ovipositor", "Spider Ovipositor",
				"Allows you to lay eggs through a special organ on your arachnid abdomen, though you need at least 10 eggs to lay.");
		public static const SuperStrength:PerkType = mk("Super strength", "Super strength",
				"Unarmed strike damage modifier from strength is doubled.");
		public static const ThickSkin:PerkType = mk("Thick Skin", "Thick Skin",
				"Toughens your dermis to provide 2 points of armor and 1 point of magic resistance.");
		public static const TitanicStrength:PerkType = mk("Titanic Strength", "Titanic Strength",
				"Increase max Strength by a percentage equal to the size in ft of the player x4.");
		public static const TransformationResistance:PerkType = mk("Transformation Resistance", "Transformation Resistance",
				"Reduces the likelihood of undergoing a transformation. Disables Bad Ends from transformative items.");
				
		// Quest, Event & NPC perks
		public static const AdvancedLeadership:PerkType = mk("Advanced Leadership", "Advanced Leadership",
				"Allows to form 4 people party.");
		public static const BasicLeadership:PerkType = mk("Basic Leadership", "Basic Leadership",
				"Allows to form 2 people party.");
		public static const BasiliskResistance:PerkType = mk("Basilisk Resistance", "Basilisk Resistance",
				"Grants immunity to Basilisk's paralyzing gaze. Disables Basilisk Bad End.");
		public static const BulgeArmor:PerkType = mk("Bulge Armor", "Bulge Armor",
				"Grants a 5 point damage bonus to dick-based tease attacks.");
		public static const Cornucopia:PerkType = mk("Cornucopia", "Cornucopia",
				"Vaginal and Anal capacities increased by 30.");
		public static const DemonicLethicite:PerkType = mk("Demonic Lethicite", "Demonic Lethicite",
				"Improves soulforce and makes you more demonic.");//Effects: maxSoulforce += lib; +1 demonscore; 10 min corruption
		public static const DemonSlayer:DemonSlayerPerk = new DemonSlayerPerk();
		public static const ElvenBounty:ElvenBountyPerk = new ElvenBountyPerk();
		public static const FclassHeavenTribulationSurvivor:PerkType = mk("F class Heaven Tribulation Survivor", "F class Heaven Tribulation Survivor",
				"You have survived third trial on cultivation path: F class Heaven Tribulation.");
		public static const FeralHunter:FeralHunterPerk = new FeralHunterPerk();
		public static const FerasBoonAlpha:PerkType = mk("Fera's Boon - Alpha", "Fera's Boon - Alpha",
				"Increases the rate your cum builds up and cum production in general.");
		public static const FerasBoonBreedingBitch:PerkType = mk("Fera's Boon - Breeding Bitch", "Fera's Boon - Breeding Bitch",
				"Increases fertility and reduces the time it takes to birth young.");
		public static const FerasBoonMilkingTwat:PerkType = mk("Fera's Boon - Milking Twat", "Fera's Boon - Milking Twat",
				"Keeps your pussy from ever getting too loose and increases pregnancy speed.");
		public static const FerasBoonSeeder:PerkType = mk("Fera's Boon - Seeder", "Fera's Boon - Seeder",
				"Increases cum output by 1,000 mLs.");
		public static const FerasBoonWideOpen:PerkType = mk("Fera's Boon - Wide Open", "Fera's Boon - Wide Open",
				"Keeps your pussy permanently gaped and increases pregnancy speed.");
		public static const FireLord:PerkType = mk("Fire Lord", "Fire Lord",
				"Akbal's blessings grant the ability to breathe burning green flames.");
		public static const FluidBody:PerkType = mk("Fluid Body", "Fluid Body",
				"You are extremely resilient to physical strike when naked reducing physical damage taken by 50% but become aroused as attacks penetrates you. You also can slip out of any mundane grapple without effort (100% escape chance).");
		public static const GargoyleCorrupted:PerkType = mk("Corrupted Gargoyle", "Corrupted Gargoyle",
				"You need constant intakes of sexual fluids to stay alive.");
		public static const GargoylePure:PerkType = mk("Gargoyle", "Pure Gargoyle",
				"Need to gain sustenance from soulforce to stay alive.");
		public static const GclassHeavenTribulationSurvivor:PerkType = mk("G class Heaven Tribulation Survivor", "G class Heaven Tribulation Survivor",
				"You have survived second trial on cultivation path: G class Heaven Tribulation.");
		public static const HclassHeavenTribulationSurvivor:PerkType = mk("H class Heaven Tribulation Survivor", "H class Heaven Tribulation Survivor",
				"You have survived first trial on cultivation path: H class Heaven Tribulation.");
		public static const Hellfire:PerkType = mk("Hellfire", "Hellfire",
				"Grants a corrupted fire breath attack, like the hellhounds in the mountains.");
		public static const IntermediateLeadership:PerkType = mk("Intermediate Leadership", "Intermediate Leadership",
				"Allows to form 3 people party.");
		public static const LuststickAdapted:PerkType = mk("Luststick Adapted", "Luststick Adapted",
				"Grants immunity to the lust-increasing effects of lust-stick and allows its use.");
		public static const MagicalFertility:MagicalFertilityPerk = new MagicalFertilityPerk();
		public static const MagicalVirility:MagicalVirilityPerk = new MagicalVirilityPerk();
		public static const MaraesGiftButtslut:PerkType = mk("Marae's Gift - Buttslut", "Marae's Gift - Buttslut",
				"Makes your anus provide lubrication when aroused.");
		public static const MaraesGiftFertility:PerkType = mk("Marae's Gift - Fertility", "Marae's Gift - Fertility",
				"Greatly increases fertility and halves base pregnancy speed.");
		public static const MaraesGiftProfractory:PerkType = mk("Marae's Gift - Profractory", "Marae's Gift - Profractory",
				"Causes your cum to build up at 3x the normal rate.");
		public static const MaraesGiftStud:PerkType = mk("Marae's Gift - Stud", "Marae's Gift - Stud",
				"Increases your cum production and potency greatly.");
		public static const MarbleResistant:PerkType = mk("Marble Resistant", "Marble Resistant",
				"Provides resistance to the addictive effects of bottled LaBova milk.");
		public static const MarblesMilk:PerkType = mk("Marble's Milk", "Marble's Milk",
				"Requires you to drink LaBova milk frequently or eventually die.  You cannot shake this addiction.");
		public static const MightyFist:PerkType = mk("Mighty Fist", "Mighty Fist",
				"Regular fist attacks now have a chance to cause stun and fist damage is increased by 5 (x NG tier).");
		public static const Misdirection:PerkType = mk("Misdirection", "Misdirection",
				"Grants additional evasion chances while wearing Raphael's red bodysuit.");
		public static const OmnibusGift:PerkType = mk("Omnibus' Gift", "Omnibus' Gift",
				"Increases minimum lust but provides some lust resistance.");
		public static const OneTrackMind:PerkType = mk("One Track Mind", "One Track Mind",
				"Your constant desire for sex causes your sexual organs to be able to take larger insertions and disgorge greater amounts of fluid.");
		public static const PilgrimsBounty:PerkType = mk("Pilgrim's Bounty", "Pilgrim's Bounty",
				"Causes you to always cum as hard as if you had max lust.");
		public static const ProductivityDrugs:PerkType = new ProductivityDrugsPerk();
		public static const PureAndLoving:PerkType = mk("Pure and Loving", "Pure and Loving",
				"Your caring attitude towards love and romance makes you slightly more resistant to lust and corruption.");
		public static const SenseCorruption:PerkType = mk("Sense Corruption", "Sense Corruption",
				"Allow to determine how corrupted or pure is enemy.");
		public static const SenseWrath:PerkType = mk("Sense Wrath", "Sense Wrath",
				"Allow to determine how much wrath enemy have.");
		public static const SensualLover:PerkType = mk("Sensual Lover", "Sensual Lover",
				"Your sensual attitude towards love and romance makes your tease ability slightly more effective.");
		public static const SoulSense:PerkType = mk("Soul Sense", "Soul Sense",
				"Your strong affinity toward soullforce helped to denvelop another sense called 'Soul Sense' by a fellow soul cultivators.");
		public static const TransformationImmunity:PerkType = mk("Transformation immunity", "Transformation Immunity",
				"As a magical construct you are immune to all effects that change the body of living beings, including most transformatives on Mareth (work as the regular transformative resistance except it reduce the odds of getting a body part tfed to 0 although stats increasing effects still could be triggered).");
		public static const Undeath:PerkType = mk("Undeath", "Undeath",
				"With a body that lacks a heartbeat, breath or working digestive system you are unable to gain benefit from transformative items. You're bodily functions are pretty much dead for lack of a better word (it reduce the odds of getting a body part tf'd to 0%).");
		public static const UnicornBlessing:PerkType = mk("Unicorn Blessing", "Unicorn Blessing",
				"You are blessed with the power of a unicorn and while below 20 corruption all white magic spells are 20% stronger and lust resistance increased by 10%.");
		public static const Whispered:PerkType = mk("Whispered", "Whispered",
				"Akbal's blessings grant limited telepathy that can induce fear.");
				
		public static const ControlledBreath:ControlledBreathPerk = new ControlledBreathPerk();
		public static const CleansingPalm:CleansingPalmPerk = new CleansingPalmPerk();
		public static const Enlightened:EnlightenedPerk = new EnlightenedPerk();
		public static const StarSphereMastery:StarSphereMasteryPerk = new StarSphereMasteryPerk();

		// Monster perks
		public static const Acid:PerkType = mk("Acid", "Acid", "");
		public static const AlwaysSuccesfullRunaway:PerkType = mk("Always Succesfull Runaway", "Always Succesfull Runaway", "");
		public static const DarknessNature:PerkType = mk("Darkness Nature", "Darkness Nature", "");//NYU
		public static const DarknessVulnerability:PerkType = mk("Darkness Vulnerability", "Darkness Vulnerability", "");//NYU
		public static const EnemyBeastOrAnimalMorphType:PerkType = mk("Beast or Animal-morph enemy type", "Beast or Animal-morph enemy type", "");
		public static const EnemyBossType:PerkType = mk("Boss-type enemy", "Boss-type enemy", "");
		public static const EnemyChampionType:PerkType = mk("Champion-type enemy", "Champion-type enemy", "");//NYU
		public static const EnemyConstructType:PerkType = mk("Construct-type enemy", "Construct-type enemy", "");
		public static const EnemyEliteType:PerkType = mk("Elite-type enemy", "Elite-type enemy", "");//NYU
		public static const EnemyFeralType:PerkType = mk("Feral-type enemy", "Feral-type enemy", "");
		public static const EnemyGhostType:PerkType = mk("Ghost-type enemy", "Ghost-type enemy", "");
		public static const EnemyGigantType:PerkType = mk("Gigant-sized type enemy", "Gigant-sized type enemy", "");
		public static const EnemyGodType:PerkType = mk("God-type enemy", "God-type enemy", "");
		public static const EnemyGooType:PerkType = mk("Goo-type enemy", "Goo-type enemy", "");
		public static const EnemyGroupType:PerkType = mk("Group-type enemy", "Group-type enemy", "");
		public static const EnemyPlantType:PerkType = mk("Plant-type enemy", "Plant-type enemy", "");
		public static const EnemyTrueDemon:PerkType = mk("True Demon-type enemy", "True Demon-type enemy", "");
		public static const FireNature:PerkType = mk("Fire Nature", "Fire Nature", "");
		public static const FireVulnerability:PerkType = mk("Fire Vulnerability", "Fire Vulnerability", "");
		public static const IceNature:PerkType = mk("Ice Nature", "Ice Nature", "");
		public static const IceVulnerability:PerkType = mk("Ice Vulnerability", "Ice Vulnerability", "");
		public static const LightningNature:PerkType = mk("Lightning Nature", "Lightning Nature", "");//NYU
		public static const LightningVulnerability:PerkType = mk("Lightning Vulnerability", "Lightning Vulnerability", "");
		public static const MonsterRegeneration:PerkType = mk("Monster Regeneration", "Monster Regeneration", "");
		public static const NoGemsLost:PerkType = mk("No Gems Lost", "No Gems Lost", "");
		public static const Phylactery:PerkType = mk("Phylactery", "Phylactery", "");
		public static const Sentience:PerkType = mk("Sentience", "Sentience", "");
		public static const ShieldWielder:PerkType = mk("Shield wielder", "Shield wielder", "");
		public static const TeaseResistance:PerkType = mk("Tease Resistance", "Tease Resistance", "");//NYU
		public static const UniqueNPC:PerkType = mk("Unique npc", "Unique npc", "");
		//public static const Enemy_Type:PerkType = mk("-type enemy", "-type enemy", "");
		//public static const Enemy_Type:PerkType = mk("-type enemy", "-type enemy", "");undead?
		//public static const :PerkType = mk("", "", ""); na poźniej dopisane perki wzór
//dodać także typy perków dla poszczególnych ras przeciwników tak, ze bedą mogły one mieć jakieś korzyści też (np. jak ma Dragon nature to bonusy jak PC miałby dragon score > 6))
		private static function mk(id:String, name:String, desc:String, longDesc:String = null, keepOnAscension:Boolean = false):PerkType
		{
			return new PerkType(id, name, desc, longDesc, keepOnAscension);
		}

	// Perk requirements
	private static function initDependencies():void {
        try {
			//------------
            // STRENGTH
            //------------
            JobWarrior.requireStr(10);
            StrongBack.requireStr(20);
            StrongBack2.requireLevel(2)
					.requirePerk(StrongBack)
                    .requireStr(40);
            StrongBack3.requireLevel(4)
					.requirePerk(StrongBack2)
                    .requireStr(60);
            BasicTranquilness.requireStr(30)
                    .requireTou(10)
                    .requireSpe(10);
            UnlockId.requireStr(20);
            //Tier 1 Strength Perks
            ThunderousStrikes.requireLevel(6)
                    .requireStr(80)
                    .requirePerk(JobWarrior);
            BrutalBlows.requireLevel(6)
                    .requireStr(75)
                    .requirePerk(JobWarrior);
            JobBrawler.requireAdvancedJobSlot()
					.requireLevel(6)
                    .requireStr(60);
            JobSwordsman.requireAdvancedJobSlot()
					.requireLevel(6)
                    .requireStr(60);
            IronFistsI.requireLevel(6)
                    .requireStr(60)
                    .requirePerk(JobBrawler);
            IronFistsII.requireNGPlus(1)
                    .requireLevel(8)
                    .requireStr(75)
                    .requirePerk(IronFistsI);
            IronFistsIII.requireNGPlus(2)
                    .requireLevel(10)
                    .requireStr(90)
                    .requirePerk(IronFistsII);
            Parry.requireLevel(6)
                    .requireStr(50)
                    .requireSpe(50);
            ThirstForBlood.requireLevel(6)
                    .requireStr(75)
                    .requirePerk(JobWarrior);
            Brute.requireLevel(6)
                    .requireStr(60)
                    .requirePerk(JobBrawler);
            HalfStepToImprovedTranquilness.requireStr(60)
                    .requireTou(20)
                    .requireSpe(20)
                    .requirePerk(BasicTranquilness)
                    .requireLevel(6);
            //Tier 2 Strength Perks
            IronFistsIV.requireNGPlus(3)
                    .requireLevel(12)
                    .requireStr(105)
                    .requirePerk(IronFistsIII);
            IronFistsV.requireNGPlus(4)
                    .requireLevel(14)
                    .requireStr(120)
                    .requirePerk(IronFistsIV);
            IronFistsVI.requireNGPlus(5)
                    .requireLevel(16)
                    .requireStr(135)
                    .requirePerk(IronFistsV);
            Berzerker.requireLevel(12)
                    .requireStr(75);
            HoldWithBothHands.requireLevel(12)
                    .requireStr(80)
                    .requirePerk(JobWarrior);
            ShieldSlam.requireLevel(12)
                    .requireStr(80)
                    .requireTou(60);
            WeaponMastery.requireLevel(12)
                    .requirePerk(JobSwordsman)
                    .requireStr(100);
            DoubleAttackLarge.requireLevel(12)
                    .requirePerk(JobSwordsman)
                    .requireStr(75)
                    .requireStr(50);
            Brawn.requireLevel(12)
                    .requireStr(75)
                    .requirePerk(Brute);
            PhantomStrike.requireLevel(12)
                    .requireStr(80)
                    .requirePerk(IronFistsI);
            ImprovedTranquilness.requireStr(90)
                    .requireTou(30)
                    .requireSpe(30)
                    .requirePerk(HalfStepToImprovedTranquilness)
                    .requireLevel(12);
            //Tier 3 Strength Perks
            ColdFury.requireLevel(18)
                    .requirePerk(Berzerker)
                    .requirePerk(ImprovedSelfControl)
                    .requireStr(75);
            GigantGrip.requireLevel(18)
                    .requirePerk(WeaponMastery)
                    .requireStr(100);
            HiddenMomentum.requireLevel(18)
                    .requirePerk(JobSwordsman)
                    .requireStr(75)
                    .requireSpe(50);
            ImprovedBrute.requireLevel(18)
                    .requireStr(90)
                    .requirePerk(Brute);
            HalfStepToAdvancedTranquilness.requireStr(120)
                    .requireTou(40)
                    .requireSpe(40)
                    .requirePerk(ImprovedTranquilness)
                    .requireLevel(18);
            //Tier 4 Strength Perks
            WeaponGrandMastery.requirePerk(WeaponMastery)
                    .requireStr(140)
                    .requireLevel(24);
            DualWieldLarge.requirePerk(GigantGrip)
                    .requireStr(125)
                    .requireLevel(24);
            TripleAttackLarge.requirePerk(DoubleAttackLarge)
                    .requireStr(125)
                    .requireSpe(100)
                    .requireLevel(24);
            GigantGripEx.requireLevel(24)
                    .requireStr(120)
                    .requirePerk(GigantGrip);
            ImprovedBrawn.requireLevel(24)
                    .requireStr(105)
                    .requirePerk(Brawn)
                    .requirePerk(Brute);
            AdvancedTranquilness.requireStr(150)
                    .requireTou(50)
                    .requireSpe(50)
                    .requirePerk(HalfStepToAdvancedTranquilness)
                    .requireLevel(24);
            //Tier 5 Strength Perks
            HiddenDualMomentum.requirePerk(HiddenMomentum)
                    .requirePerk(DualWieldLarge)
                    .requireStr(150)
                    .requireSpe(100)
                    .requireLevel(30);
            UnlockId2ndStage.requirePerk(UnlockId)
                    .requireStr(125)
                    .requireLevel(30);
            HalfStepToSuperiorTranquilness.requireStr(180)
                    .requireTou(60)
                    .requireSpe(60)
                    .requirePerk(AdvancedTranquilness)
                    .requireLevel(30);
            ColderFury.requireLevel(30)
                    .requirePerk(ColdFury)
                    .requirePerk(AdvancedSelfControl)
                    .requireStr(150);
            GreaterBrute.requireLevel(30)
                    .requireStr(120)
                    .requirePerk(ImprovedBrute);
            //Tier 6 Strength Perks
            SuperiorTranquilness.requireStr(210)
                    .requireTou(70)
                    .requireSpe(70)
                    .requirePerk(HalfStepToSuperiorTranquilness)
                    .requireLevel(36);
            EpicStrength.requireStr(10)
                    .requireLevel(36);
            GreaterBrawn.requireLevel(36)
                    .requireStr(135)
                    .requirePerk(ImprovedBrawn)
                    .requirePerk(ImprovedBrute);
            //HiddenDualMomentum.requirePerk(HiddenMomentum).requireStr(175).requireSpe(100).requireLevel(30);	//herculanmight - perk dodający limit do str cap (i może do max tone też)
            //a może właśnie perk dodający do max str cap tyle ile wynosi obecnie PC tone?
            //Tier 7 Strength Perks
            PrestigeJobBerserker.requirePrestigeJobSlot()
                    .requirePerk(JobSwordsman)
                    .requirePerk(JobGuardian)
                    .requireAnyPerk(Berzerker, Lustzerker)
                    .requireStr(200)
                    .requireLevel(42);
            PrestigeJobSpellKnight.requirePrestigeJobSlot()
                    .requireStr(200)
                    .requireInt(150)
                    .requireLevel(42)
					.requireCustomFunction(function (player:Player):Boolean {
                        return player.statusEffectv1(StatusEffects.AlvinaTraining2) > 3 || player.statusEffectv1(StatusEffects.SiegweirdTraining2) > 2;
                    }, "Finished one of the two mages (Alvina/Siegweird) quest lines up to the optional battle");
            HalfStepToPeerlessTranquilness.requireStr(240)
                    .requireTou(80)
                    .requireSpe(80)
                    .requirePerk(SuperiorTranquilness)
                    .requireLevel(42);
            EpicBrute.requireLevel(42)
                    .requireStr(150)
                    .requirePerk(GreaterBrute);
            //Tier 8 Strength Perks
            Rage.requirePerk(PrestigeJobBerserker)
                    .requireLevel(48);
            SwiftCasting.requireLevel(48)
                    .requirePerk(PrestigeJobSpellKnight)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.hasStatusEffect(StatusEffects.KnowsWhitefire) || player.hasStatusEffect(StatusEffects.KnowsIceSpike) || player.hasStatusEffect(StatusEffects.KnowsLightningBolt) || player.hasStatusEffect(StatusEffects.KnowsDarknessShard);
                    }, "Whitefire or Ice Spike or Lightning Bolt or Darkness Shard spell");
            PeerlessTranquilness.requireStr(270)
                    .requireTou(90)
                    .requireSpe(90)
                    .requirePerk(HalfStepToPeerlessTranquilness)
                    .requireLevel(48);
            EpicBrawn.requireLevel(48)
                    .requireStr(165)
                    .requirePerk(GreaterBrawn)
                    .requirePerk(GreaterBrute);
            //Tier 9 Strength Perks
            Anger.requirePerk(Rage)
                    .requireLevel(54);
            WarCaster.requirePerk(SwiftCasting)
                    .requireLevel(54);
            HalfStepToInhumanTranquilness.requireStr(300)
                    .requireTou(100)
                    .requireSpe(100)
                    .requirePerk(PeerlessTranquilness)
                    .requireLevel(54);
            LegendaryBrute.requireLevel(54)
                    .requireStr(180)
                    .requirePerk(EpicBrute);
            //Tier 10 Strength Perks
            FuelForTheFire.requirePerk(Anger)
                    .requireLevel(60);
            VampiricBlade.requirePerk(WarCaster)
                    .requireLevel(54);
            InhumanTranquilness.requireStr(330)
                    .requireTou(110)
                    .requireSpe(110)
                    .requirePerk(HalfStepToInhumanTranquilness)
                    .requireLevel(60);
            UnlockId3rdStage.requirePerk(UnlockId2ndStage)
                    .requireStr(230)
                    .requireLevel(60);
            LegendaryBrawn.requireLevel(60)
                    .requireStr(195)
                    .requirePerk(EpicBrawn)
                    .requirePerk(EpicBrute);
            //Tier 11 Strength Perks
            //TooAngryToDie.requirePerk(FuelForTheFire)
                    //.requireLevel(66);
            HalfStepToEpicTranquilness.requireStr(360)
                    .requireTou(120)
                    .requireSpe(120)
                    .requirePerk(InhumanTranquilness)
                    .requireLevel(66);
            LegendaryStrength.requireStr(15)
                    .requirePerk(EpicStrength)
                    .requireLevel(66);
            MythicalBrute.requireLevel(66)
                    .requireStr(210)
                    .requirePerk(LegendaryBrute);
            //Tier 12 Strength Perks
            EpicTranquilness.requireStr(390)
                    .requireTou(130)
                    .requireSpe(130)
                    .requirePerk(HalfStepToEpicTranquilness)
                    .requireLevel(72);
            MythicalBrawn.requireLevel(72)
                    .requireStr(225)
                    .requirePerk(LegendaryBrawn)
                    .requirePerk(LegendaryBrute);
            //Tier 13 Strength Perks
            HalfStepToLegendaryTranquilness.requireStr(420)
                    .requireTou(140)
                    .requireSpe(140)
                    .requirePerk(EpicTranquilness)
                    .requireLevel(78);
            //Tier 14 Strength Perks
            LegendaryTranquilness.requireStr(450)
                    .requireTou(150)
                    .requireSpe(150)
                    .requirePerk(HalfStepToLegendaryTranquilness)
                    .requireLevel(84);
            //Tier 15 Strength Perks
            HalfStepToMythicalTranquilness.requireStr(480)
                    .requireTou(160)
                    .requireSpe(160)
                    .requirePerk(LegendaryTranquilness)
                    .requireLevel(90);
            UnlockId4thStage.requirePerk(UnlockId3rdStage)
                    .requireStr(335)
                    .requireLevel(90);
            //Tier 16 Strength Perks
            MythicalTranquilness.requireStr(510)
                    .requireTou(170)
                    .requireSpe(170)
                    .requirePerk(HalfStepToMythicalTranquilness)
                    .requireLevel(96);
            MythicalStrength.requireStr(20)
                    .requirePerk(LegendaryStrength)
                    .requireLevel(96);
            //------------
            // TOUGHNESS
            //------------
            JobGuardian.requireTou(10);
            RefinedBodyI.requirePerk(JobGuardian)
                    .requireTou(25);
            RefinedBodyII.requirePerk(RefinedBodyI)
                    .requireTou(40)
                    .requireLevel(2)
                    .requireNGPlus(1);
            RefinedBodyIII.requirePerk(RefinedBodyII)
                    .requireTou(55)
                    .requireLevel(4)
                    .requireNGPlus(2);
            Regeneration.requireTou(50);
            Regeneration2.requirePerk(Regeneration)
                    .requireTou(70)
                    .requireLevel(2)
                    .requireNGPlus(1);
            Regeneration3.requirePerk(Regeneration2)
                    .requireTou(90)
                    .requireLevel(4)
                    .requireNGPlus(2);
            BasicEndurance.requireTou(30)
                    .requireStr(20);
            UnlockBody.requireTou(20);
            //Tier 1 Toughness Perks
            RefinedBodyIV.requirePerk(RefinedBodyIII)
                    .requireTou(70)
                    .requireNGPlus(3)
                    .requireLevel(6);
            RefinedBodyV.requirePerk(RefinedBodyIV)
                    .requireTou(85)
                    .requireLevel(8)
                    .requireNGPlus(4);
            RefinedBodyVI.requirePerk(RefinedBodyV)
                    .requireTou(100)
                    .requireLevel(10)
                    .requireNGPlus(5);
            Regeneration4.requirePerk(Regeneration3)
                    .requireTou(110)
                    .requireNGPlus(3)
                    .requireLevel(6);
            Regeneration5.requirePerk(Regeneration4)
                    .requireTou(130)
                    .requireLevel(8)
                    .requireNGPlus(4);
            Regeneration6.requirePerk(Regeneration5)
                    .requireTou(150)
                    .requireLevel(10)
                    .requireNGPlus(5);
            TankI.requirePerk(RefinedBodyI)
                    .requireTou(60)
                    .requireLevel(6);
            TankII.requirePerk(TankI)
                    .requireTou(80)
                    .requireLevel(8)
                    .requireNGPlus(1);
            TankIII.requirePerk(TankII)
                    .requireTou(100)
                    .requireLevel(10)
                    .requireNGPlus(2);
            JobKnight.requirePerk(JobGuardian)
                    .requireTou(50)
                    .requireLevel(6);
            ShieldMastery.requirePerk(JobKnight)
                    .requireTou(50)
                    .requireLevel(6);
            HalfStepToImprovedEndurance.requireTou(60)
                    .requireStr(40)
                    .requirePerk(BasicEndurance)
                    .requireLevel(6);
            ArmorMaster.requirePerk(JobKnight)
                    .requireTou(50)
                    .requireLevel(6);
            //Tier 2 Toughness Perks
            JobDefender.requireAdvancedJobSlot()
					.requirePerk(JobGuardian)
                    .requireTou(75)
                    .requireLevel(12);
            ImmovableObject.requirePerk(JobDefender)
                    .requireTou(75)
                    .requireLevel(12);
            Resolute.requirePerk(JobDefender)
                    .requireTou(75)
                    .requireLevel(12);
            HeavyArmorProficiency.requirePerk(JobKnight)
                    .requireTou(75)
                    .requireLevel(12);
            IronMan.requireTou(60)
                    .requireLevel(12);
            TankIV.requirePerk(TankIII)
                    .requireTou(120)
                    .requireNGPlus(3)
                    .requireLevel(12);
            TankV.requirePerk(TankIV)
                    .requireTou(140)
                    .requireLevel(14)
                    .requireNGPlus(4);
            TankVI.requirePerk(TankV)
                    .requireTou(140)
                    .requireLevel(16)
                    .requireNGPlus(5);
            ImprovedEndurance.requireTou(90)
                    .requireStr(60)
                    .requirePerk(HalfStepToImprovedEndurance)
                    .requireLevel(12);
            ShieldExpertise.requirePerk(JobKnight)
                    .requireTou(70)
                    .requireLevel(12);
            //Tier 3 Toughness Perks
            Juggernaut.requireTou(100)
                    .requirePerk(HeavyArmorProficiency)
                    .requireLevel(18);
            //AyoArmorProficiency.requireMinTou(80).requirePerk(HeavyArmorProficiency);
            HalfStepToAdvancedEndurance.requireTou(120)
                    .requireStr(80)
                    .requireLevel(18)
                    .requirePerk(ImprovedEndurance);
            DefenceStance.requirePerk(JobDefender)
                    .requireTou(80)
                    .requireLevel(18);
            ShieldHarmony.requirePerk(ShieldExpertise)
                    .requireTou(80)
                    .requireLevel(18);
            Lifeline.requirePerk(JobDefender)
                    .requireTou(75)
                    .requireLevel(18);
            //Tier 4 Toughness Perks
            AdvancedEndurance.requireLevel(24)
                    .requireTou(150)
                    .requireStr(100)
                    .requirePerk(HalfStepToAdvancedEndurance);
            ShieldGrandmastery.requirePerk(ShieldMastery)
                    .requireTou(100)
                    .requireLevel(24);
            //perk związany z ayotech armors na pewno tu umieścić coś podobnego do juggernaut pewnie a moze właśnie wersja juggernaut dla ayo tech armors może?
            MasteredDefenceStance.requirePerk(DefenceStance)
                    .requireTou(120)
                    .requireLevel(24);
            GoliathI.requirePerk(JobDefender)
                    .requirePerk(TankI)
                    .requireTou(100)
                    .requireLevel(24);
            GoliathII.requirePerk(GoliathI)
                    .requireTou(115)
                    .requireLevel(26)
                    .requireNGPlus(1);
            GoliathIII.requirePerk(GoliathII)
                    .requireTou(130)
                    .requireLevel(28)
                    .requireNGPlus(2);
            ImprovedLifeline.requirePerk(Lifeline)
                    .requireTou(125)
                    .requireLevel(24);
            //Tier 5 Toughness Perks
            HalfStepToSuperiorEndurance.requireTou(180)
                    .requireStr(120)
                    .requirePerk(AdvancedEndurance)
                    .requireLevel(30);
            PerfectDefenceStance.requirePerk(MasteredDefenceStance)
                    .requireTou(160)
                    .requireLevel(30);
            ShieldWard.requirePerk(ShieldGrandmastery)
                    .requireTou(120)
                    .requireLevel(30);
            GoliathIV.requirePerk(GoliathIII)
                    .requireTou(145)
                    .requireLevel(30)
                    .requireNGPlus(3);
            GoliathV.requirePerk(GoliathIV)
                    .requireTou(160)
                    .requireLevel(32)
                    .requireNGPlus(4);
            GoliathVI.requirePerk(GoliathV)
                    .requireTou(175)
                    .requireLevel(34)
                    .requireNGPlus(5);
            UnlockBody2ndStage.requirePerk(UnlockBody)
                    .requireTou(125)
                    .requireLevel(30);
            //Tier 6 Toughness Perks
            SuperiorEndurance.requireTou(210)
                    .requireStr(140)
                    .requirePerk(HalfStepToSuperiorEndurance)
                    .requireLevel(36);
            CheetahI.requirePerk(GoliathI)
                    .requireTou(150)
                    .requireLevel(36);
            CheetahII.requirePerk(CheetahI)
                    .requireTou(165)
                    .requireLevel(38)
                    .requireNGPlus(1);
            CheetahIII.requirePerk(CheetahII)
                    .requireTou(180)
                    .requireLevel(40)
                    .requireNGPlus(2);
            EpicToughness.requireTou(10)
                    .requireLevel(36);
            GreaterLifeline.requirePerk(ImprovedLifeline)
                    .requireTou(175)
                    .requireLevel(36);
            //Tier 7 Toughness Perks
            HalfStepToPeerlessEndurance.requireTou(240)
                    .requireStr(160)
                    .requirePerk(SuperiorEndurance)
                    .requireLevel(42);
            PrestigeJobSentinel.requirePrestigeJobSlot()
                    .requirePerk(JobKnight)
                    .requirePerk(JobWarrior)
                    .requireTou(200)
                    .requireLevel(42);
            CheetahIV.requirePerk(CheetahIII)
                    .requireTou(195)
                    .requireLevel(42)
                    .requireNGPlus(3);
            CheetahV.requirePerk(CheetahIV)
                    .requireTou(210)
                    .requireLevel(44)
                    .requireNGPlus(4);
            CheetahVI.requirePerk(CheetahV)
                    .requireTou(225)
                    .requireLevel(46)
                    .requireNGPlus(5);
            //Tier 8 Toughness Perks
            PeerlessEndurance.requireTou(270)
                    .requireStr(180)
                    .requirePerk(HalfStepToPeerlessEndurance)
                    .requireLevel(48);
            SteelImpact.requirePerk(PrestigeJobSentinel)
                    .requireLevel(48);
            EpicLifeline.requirePerk(GreaterLifeline)
                    .requireTou(225)
                    .requireLevel(48);
            //Tier 9 Toughness Perks
            ShieldCombat.requirePerk(SteelImpact)
                    .requireLevel(54);
            HalfStepToInhumanEndurance.requireTou(300)
                    .requireStr(200)
                    .requirePerk(PeerlessEndurance)
                    .requireLevel(54);
            //Tier 10 Toughness Perks
            SecondWind.requirePerk(ShieldCombat)
                    .requireLevel(60);
            InhumanEndurance.requireTou(330)
                    .requireStr(220)
                    .requirePerk(HalfStepToInhumanEndurance)
                    .requireLevel(60);
            UnlockBody3rdStage.requirePerk(UnlockBody2ndStage)
                    .requireTou(230)
                    .requireLevel(60);
            //Tier 11 Toughness Perks
            HalfStepToEpicEndurance.requireTou(360)
                    .requireStr(240)
                    .requirePerk(InhumanEndurance)
                    .requireLevel(66);
            LegendaryToughness.requireTou(15)
                    .requirePerk(EpicToughness)
                    .requireLevel(66);
            //Tier 12 Toughness Perks
            EpicEndurance.requireTou(390)
                    .requireStr(260)
                    .requirePerk(HalfStepToEpicEndurance)
                    .requireLevel(72);
            //Tier 13 Toughness Perks
            HalfStepToLegendaryEndurance.requireTou(420)
                    .requireStr(280)
                    .requirePerk(EpicEndurance)
                    .requireLevel(78);
            //Tier 14 Toughness Perks
            LegendaryEndurance.requireTou(450)
                    .requireStr(300)
                    .requirePerk(HalfStepToLegendaryEndurance)
                    .requireLevel(84);
            //Tier 15 Toughness Perks
            HalfStepToMythicalEndurance.requireTou(480)
                    .requireStr(320)
                    .requirePerk(LegendaryEndurance)
                    .requireLevel(90);
            UnlockBody4thStage.requirePerk(UnlockBody3rdStage)
                    .requireTou(335)
                    .requireLevel(90);
            //Tier 16 Toughness Perks
            MythicalEndurance.requireTou(510)
                    .requireStr(340)
                    .requirePerk(HalfStepToMythicalEndurance)
                    .requireLevel(96);
            MythicalToughness.requireTou(20)
                    .requirePerk(LegendaryToughness)
                    .requireLevel(96);
            //------------
            // SPEED
            //------------
            JobRanger.requireSpe(10);
            Runner.requireSpe(25);
            //slot 3 - speed perk
            Evade.requireSpe(20);
            ArchersStaminaI.requirePerk(JobRanger)
                    .requireSpe(25);
            ArchersStaminaII.requirePerk(ArchersStaminaI)
                    .requireSpe(45)
                    .requireLevel(2)
                    .requireNGPlus(1);
            ArchersStaminaIII.requirePerk(ArchersStaminaII)
                    .requireSpe(65)
                    .requireLevel(4)
                    .requireNGPlus(2);
            CarefulButRecklessAimAndShooting.requirePerk(JobRanger)
                    .requireSpe(30);
            Sharpshooter.requirePerk(JobRanger);
            PowerShot.requirePerk(JobRanger);
            NaturesSpringI.requirePerk(ArchersStaminaI)
                    .requireSpe(30);
            NaturesSpringII.requirePerk(NaturesSpringI)
                    .requireSpe(50)
                    .requireLevel(2)
                    .requireNGPlus(1);
            NaturesSpringIII.requirePerk(NaturesSpringII)
                    .requireSpe(70)
                    .requireLevel(4)
                    .requireNGPlus(2);
            UnlockEndurance.requireSpe(20);
            //Tier 1 Speed Perks
            //Agility - A small portion of your speed is applied to your defense rating when wearing light armors.
            Agility.requireSpe(75)
                    .requirePerk(Runner)
                    .requireLevel(6);
            //slot 3 - Double Attack perk
            DoubleAttack.requirePerk(JobDervish)
                    .requireSpe(50)
                    .requireLevel(6);
            DoubleStrike.requirePerk(JobRanger)
                    .requireSpe(50)
                    .requireLevel(6);
            Unhindered.requireSpe(75)
                    .requirePerk(Evade)
                    .requireLevel(6);
            LightningStrikes.requireSpe(60)
                    .requireLevel(6);
            Naturaljouster.requireSpe(60)
                    .requireLevel(6);
            VitalShot.requireSpe(60)
                    .requirePerk(JobRanger)
                    .requirePerk(Tactician)
                    .requireLevel(6);
            DeadlyAim.requireSpe(60)
                    .requirePerk(JobRanger)
                    .requirePerk(Precision)
                    .requireLevel(6);
            ArchersStaminaIV.requirePerk(ArchersStaminaIII)
                    .requireSpe(85)
                    .requireNGPlus(3)
                    .requireLevel(6);
            ArchersStaminaV.requirePerk(ArchersStaminaIV)
                    .requireSpe(105)
                    .requireLevel(8)
                    .requireNGPlus(4);
            ArchersStaminaVI.requirePerk(ArchersStaminaV)
                    .requireSpe(125)
                    .requireLevel(10)
                    .requireNGPlus(5);
            JobDervish.requireAdvancedJobSlot()
					.requireAnyPerk(JobRanger, JobWarrior)
                    .requireSpe(30)
                    .requireStr(20)
                    .requireLevel(6);
            NaturesSpringIV.requirePerk(NaturesSpringIII)
                    .requireSpe(90)
                    .requireNGPlus(3)
                    .requireLevel(6);
            NaturesSpringV.requirePerk(NaturesSpringIV)
                    .requireSpe(110)
                    .requireLevel(8)
                    .requireNGPlus(4);
            NaturesSpringVI.requirePerk(NaturesSpringV)
                    .requireSpe(130)
                    .requireLevel(10)
                    .requireNGPlus(5);
            JobRogue.requireAdvancedJobSlot()
					.requirePerk(JobRanger)
					.requirePerk(Evade)
                    .requireSpe(25)
                    .requireStr(25)
                    .requireLevel(6);
            DualWieldSmall.requirePerk(JobRogue)
                    .requireLevel(6);
            SneakyAttack.requirePerk(JobRogue)
                    .requireLevel(6);
            DoubleAttackSmall.requirePerk(JobRogue)
                    .requireSpe(40)
                    .requireLevel(6);
            StarlightStrikes.requirePerk(JobRogue)
                    .requireSpe(60)
                    .requireLevel(6);
            /*Brawler.requireMinSpe(60)
					.requireMinStr(60);*/ //Would it be fitting to have Urta teach you?
            //Tier 2 Speed Perks
            LungingAttacks.requireSpe(75)
                    .requireLevel(12);
            Blademaster.requireSpe(80)
                    .requireStr(60)
                    .requireLevel(12);
            TripleAttack.requirePerk(DoubleAttack)
                    .requireSpe(75)
                    .requireLevel(12);
            SluttySimplicity.requireSpe(80)
                    .requireLib(50)
                    .requirePerk(Unhindered)
                    .requireLevel(12);
            NakedTruth.requireSpe(80)
                    .requireLib(50)
                    .requirePerk(Unhindered)
                    .requireLevel(12);
            TripleStrike.requirePerk(DoubleStrike)
                    .requireSpe(75)
                    .requireLevel(12);
            JobHunter.requireAdvancedJobSlot()
					.requirePerk(JobRanger)
                    .requirePerk(ArchersStaminaI)
                    .requireSpe(80)
                    .requireLevel(12);
            ColdAim.requirePerk(CarefulButRecklessAimAndShooting)
                    .requireSpe(50)
                    .requireLevel(12);
            DancersVitalityI.requirePerk(JobDervish)
                    .requireSpe(60)
                    .requireLevel(12);
            DancersVitalityII.requirePerk(DancersVitalityI)
                    .requireSpe(75)
                    .requireLevel(14)
                    .requireNGPlus(1);
            DancersVitalityIII.requirePerk(DancersVitalityII)
                    .requireSpe(90)
                    .requireLevel(16)
                    .requireNGPlus(2);
            DeadlyThrow.requirePerk(JobHunter)
                    .requireLevel(12);
            DeadlySneaker.requirePerk(SneakyAttack)
                    .requireSpe(60)
                    .requireLevel(12);
            MarkedForDeath.requireAnyPerk(JobHunter, JobGunslinger)
                    .requireLevel(12);
            Feint.requireAnyPerk(SneakyAttack, MarkedForDeath)
                    .requireSpe(50)
                    .requireLevel(12);
            TripleAttackSmall.requirePerk(DoubleAttackSmall)
                    .requireSpe(55)
                    .requireLevel(12);
            QuadrupleAttackSmall.requirePerk(TripleAttackSmall)
                    .requireSpe(70)
                    .requireLevel(12);
            ImprovedEvade.requirePerk(JobRanger)
					.requirePerk(Evade)
                    .requireSpe(60)
                    .requireLevel(12);
            PracticedShot.requirePerk(JobRanger)
                    .requireSpe(75)
                    .requireLevel(12);
            SpeedDemon.requireAnyPerk(JobDervish, JobRogue)
                    .requireSpe(90)
                    .requireLevel(12);
            DevastatingCharge.requirePerk(Naturaljouster)
                    .requireSpe(90)
                    .requireLevel(12);
            //Tier 3 Speed Perks
            Manyshot.requirePerk(JobHunter)
                    .requirePerk(TripleStrike)
                    .requireSpe(100)
                    .requireLevel(18);
            QuadrupleAttack.requirePerk(TripleAttack)
                    .requireSpe(100)
                    .requireLevel(18);
            EnvenomedBolt.requireLevel(18)
                    .requirePerk(JobHunter)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.tail.isAny(Tail.BEE_ABDOMEN, Tail.SCORPION, Tail.MANTICORE_PUSSYTAIL)
                                || player.facePart.isAny(Face.SNAKE_FANGS, Face.SPIDER_FANGS) || player.hasPerk(PerkLib.VenomGlands);
                    }, "Venom-producing tail, abdomen, fangs or having Venom Glands mutation");
            DancersVitalityIV.requirePerk(DancersVitalityIII)
                    .requireSpe(105)
                    .requireNGPlus(3)
                    .requireLevel(18);
            DancersVitalityV.requirePerk(DancersVitalityIV)
                    .requireSpe(120)
                    .requireLevel(20)
                    .requireNGPlus(4);
            DancersVitalityVI.requirePerk(DancersVitalityV)
                    .requireSpe(140)
                    .requireLevel(22)
                    .requireNGPlus(5);
            Impale.requirePerk(Naturaljouster)
                    .requireSpe(100)
                    .requireLevel(18);
            AnatomyExpert.requirePerk(DeadlyThrow)
                    .requireLevel(18);
            GreaterFeint.requirePerk(Feint)
                    .requireSpe(100)
                    .requireLevel(18);
            PentaAttackSmall.requirePerk(QuadrupleAttackSmall)
                    .requireSpe(85)
                    .requireLevel(18);
            HexaAttackSmall.requirePerk(PentaAttackSmall)
                    .requireSpe(100)
                    .requireLevel(18);
            QuickStrike.requirePerk(SpeedDemon)
                    .requireSpe(120)
                    .requireLevel(18);
            Poisoning.requireLevel(18)
                    .requirePerk(JobRogue)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.tail.isAny(Tail.BEE_ABDOMEN, Tail.SCORPION, Tail.MANTICORE_PUSSYTAIL)
                                || player.facePart.isAny(Face.SNAKE_FANGS, Face.SPIDER_FANGS) || player.hasPerk(PerkLib.VenomGlands);
                    }, "Venom-producing tail, abdomen, fangs or having Venom Glands mutation");
            //Tier 4 Speed Perks
            WildQuiver.requirePerk(Manyshot)
                    .requireSpe(125)
                    .requireLevel(24);
            PentaAttack.requirePerk(QuadrupleAttack)
                    .requireSpe(125)
                    .requireLevel(24);
            Slayer.requirePerk(DeadlySneaker)
                    .requireSpe(120)
                    .requireLevel(12);
            HectaAttackSmall.requirePerk(HexaAttackSmall)
                    .requireSpe(115)
                    .requireLevel(24);
            OctaAttackSmall.requirePerk(HectaAttackSmall)
                    .requireSpe(130)
                    .requireLevel(24);
            GreaterEvade.requirePerk(ImprovedEvade)
                    .requireSpe(100)
                    .requireLevel(24);
            EagleEye.requirePerk(PracticedShot)
                    .requireSpe(125)
                    .requireLevel(24);
            //Tier 5 Speed Perks
            HexaAttack.requirePerk(PentaAttack)
                    .requireSpe(150)
                    .requireLevel(30);
            Multishot.requirePerk(WildQuiver)
                    .requireSpe(150)
                    .requireLevel(30);
            UnlockEndurance2ndStage.requirePerk(UnlockEndurance)
                    .requireSpe(125)
                    .requireLevel(30);
            NonaAttackSmall.requirePerk(OctaAttackSmall)
                    .requireSpe(145)
                    .requireLevel(30);
            DecaAttackSmall.requirePerk(NonaAttackSmall)
                    .requireSpe(160)
                    .requireLevel(30);
            //Tier 6 Speed Perks
            NaturaljousterMastergrade.requirePerk(Naturaljouster)
                    .requireSpe(180)
                    .requireLevel(36);
			EpicSpeed.requireSpe(10)
                    .requireLevel(36);
            GrandBlademaster.requirePerk(Blademaster)
                    .requireSpe(160)
                    .requireStr(120)
                    .requireLevel(36);
            //Tier 7 Speed Perks
            PrestigeJobArcaneArcher.requirePrestigeJobSlot()
                    .requirePerk(JobSorcerer)
                    .requirePerk(JobHunter)
                    .requireSpe(200)
                    .requireInt(150)
                    .requireLevel(42);
            PrestigeJobTempest.requirePrestigeJobSlot()
                    .requirePerk(JobDervish)
                    .requirePerk(JobWarrior)
                    .requirePerk(DualWield)
                    .requireSpe(200)
                    .requireLevel(42);
            //Tier 8 Speed Perks
            ElementalArrows.requireLevel(48)
                    .requirePerk(PrestigeJobArcaneArcher)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.hasStatusEffect(StatusEffects.KnowsWhitefire) || player.hasStatusEffect(StatusEffects.KnowsIceSpike) || player.hasStatusEffect(StatusEffects.KnowsLightningBolt) || player.hasStatusEffect(StatusEffects.KnowsDarknessShard);
                    }, "Whitefire or Ice Spike or Lightning Bolt or Darkness Shard spell");
            SteelStorm.requireLevel(48)
                    .requirePerk(PrestigeJobTempest);
            //Tier 9 Speed Perks
            Cupid.requireLevel(54)
                    .requirePerk(ElementalArrows)
                    .requireStatusEffect(StatusEffects.KnowsArouse, "Arouse spell");
            BladeBarrier.requireLevel(54)
                    .requirePerk(SteelStorm);
			//Tier 10 Speed Perks
            TwinRiposte.requireLevel(60)
                    .requirePerk(Parry)
                    .requirePerk(BladeBarrier);
            UnlockEndurance3rdStage.requirePerk(UnlockEndurance2ndStage)
                    .requireSpe(230)
                    .requireLevel(60);
			//Tier 11 Speed Perks
			LegendarySpeed.requireSpe(15)
                    .requirePerk(EpicSpeed)
                    .requireLevel(66);
			//Tier 12 Speed Perks
			/*		PrestigeJobSoulArcher.requirePrestigeJobSlot()
					 .requirePerk(SoulOverlord)
					 .requirePerk(JobHunter)
					 .requireSpe(200)
					 .requireLevel(72);
                    */
			
            //Tier 13 Speed Perks
			
			//Tier 14 Speed Perks
			
			//Tier 15 Speed Perks
            UnlockEndurance4thStage.requirePerk(UnlockEndurance3rdStage)
                    .requireSpe(335)
                    .requireLevel(90);
			//Tier 16 Speed Perks
            MythicalSpeed.requireSpe(20)
                    .requirePerk(LegendarySpeed)
                    .requireLevel(96);
            //------------
            // INTELLIGENCE
            //------------
            JobSorcerer.requireInt(10);
            //Slot 4 - precision - -10 enemy toughness for damage calc
            Precision.requireInt(25);
            //Spellpower - boosts spell power
            Spellpower.requirePerk(JobSorcerer)
                    .requireInt(50);
            UnlockForce.requireInt(20);
            ManaAffinityI.requireAnyPerk(JobSorcerer, JobHealer)
                    .requireInt(25);
            ManaAffinityII.requirePerk(ManaAffinityI)
                    .requireInt(45)
                    .requireLevel(2)
                    .requireNGPlus(1);
            ManaAffinityIII.requirePerk(ManaAffinityII)
                    .requireInt(65)
                    .requireLevel(4)
                    .requireNGPlus(2);
            BasicSpirituality.requireWis(20)
                    .requireInt(30);
            //Tier 1 Intelligence Perks
            Mage.requirePerk(Spellpower)
                    .requireInt(50)
                    .requireLevel(6);
            Tactician.requireInt(50)
                    .requireLevel(6);
            Channeling.requirePerk(Spellpower)
                    .requirePerk(Mage)
                    .requireInt(60)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.spellCount() > 0;
                    }, "Any spell")
                    .requireLevel(6);
            Medicine.requireInt(60);
            StaffChanneling.requirePerk(Channeling)
                    .requireInt(60)
                    .requireLevel(6);
            ManaAffinityIV.requirePerk(ManaAffinityIII)
                    .requireInt(85)
                    .requireNGPlus(3)
                    .requireLevel(6);
            ManaAffinityV.requirePerk(ManaAffinityIV)
                    .requireInt(105)
                    .requireLevel(8)
                    .requireNGPlus(4);
            ManaAffinityVI.requirePerk(ManaAffinityV)
                    .requireInt(125)
                    .requireLevel(10)
                    .requireNGPlus(5);
            MindOverBodyI.requirePerk(ManaAffinityI)
                    .requireInt(50)
					.requireLevel(6);
            MindOverBodyII.requirePerk(MindOverBodyI)
                    .requireInt(70)
                    .requireLevel(8)
                    .requireNGPlus(1);
            MindOverBodyIII.requirePerk(MindOverBodyII)
                    .requireInt(90)
                    .requireLevel(10)
                    .requireNGPlus(2);
            HalfStepToImprovedSpirituality.requireWis(40)
                    .requireInt(60)
                    .requirePerk(BasicSpirituality)
                    .requireLevel(6);
            ArcaneRegenerationMinor.requirePerk(Mage)
                    .requireInt(50)
                    .requireLevel(6);
            //Tier 2 Intelligence perks
            GrandMage.requirePerk(Mage)
                    .requireInt(75)
                    .requireLevel(12);
            JobEnchanter.requireAdvancedJobSlot()
					.requirePerk(Mage)
                    .requireInt(75)
                    .requireLevel(12);
            FocusedMind.requirePerk(Mage)
                    .requireInt(75)
                    .requireLevel(12);
            RagingInferno.requirePerk(GrandMage)
                    .requirePerk(Channeling)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.hasStatusEffect(StatusEffects.KnowsWhitefire)
                                || player.hasStatusEffect(StatusEffects.KnowsPyreBurst)
                                || player.hasStatusEffect(StatusEffects.KnowsFireStorm)
                                || player.hasPerk(DragonFireBreath)
                                || player.hasPerk(FireLord)
                                || player.hasPerk(Hellfire)
                                || player.hasPerk(EnlightenedKitsune)
                                || player.hasPerk(CorruptedKitsune);
                    }, "Any fire spell")
                    .requireLevel(12)
                    .requireInt(75);
            GlacialStorm.requirePerk(GrandMage)
                    .requirePerk(Channeling)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.hasStatusEffect(StatusEffects.KnowsIceSpike)
                                || player.hasStatusEffect(StatusEffects.KnowsArcticGale)
                                || player.hasStatusEffect(StatusEffects.KnowsIceRain)
                                || player.hasPerk(DragonIceBreath)
                                || player.hasPerk(FreezingBreath)
                                || player.hasPerk(FreezingBreathYeti);
                    }, "Any ice spell")
                    .requireLevel(12)
                    .requireInt(75);
            HighVoltage.requirePerk(GrandMage)
                    .requirePerk(Channeling)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.hasStatusEffect(StatusEffects.KnowsLightningBolt)
                                || player.hasStatusEffect(StatusEffects.KnowsChainLighting)
                                || player.hasPerk(DragonLightningBreath);
                    }, "Any lightning spell")
                    .requireLevel(12)
                    .requireInt(75);
            EclipsingShadow.requirePerk(GrandMage)
                    .requirePerk(Channeling)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.hasStatusEffect(StatusEffects.KnowsDarknessShard)
                                || player.hasStatusEffect(StatusEffects.KnowsDuskWave)
                                || player.hasPerk(DragonDarknessBreath);
                    }, "Any darkness spell")
                    .requireLevel(12)
                    .requireInt(75);
            // Spell-boosting perks
            // Battlemage: auto-use Might
            Battlemage.requireLevel(12)
                    .requirePerk(JobEnchanter)
                    .requirePerk(Channeling)
                    .requireInt(80)
                    .requireStatusEffect(StatusEffects.KnowsMight, "Might spell");
            // Spellsword: auto-use Charge Weapon
            Spellsword.requireLevel(12)
                    .requirePerk(JobEnchanter)
                    .requirePerk(Channeling)
                    .requireInt(80)
                    .requireStatusEffect(StatusEffects.KnowsCharge, "Charge spell");
            MindOverBodyIV.requirePerk(MindOverBodyIII)
                    .requireInt(110)
                    .requireNGPlus(3)
                    .requireLevel(12);
            MindOverBodyV.requirePerk(MindOverBodyIV)
                    .requireInt(130)
                    .requireLevel(14)
                    .requireNGPlus(4);
            MindOverBodyVI.requirePerk(MindOverBodyV)
                    .requireInt(150)
                    .requireLevel(16)
                    .requireNGPlus(5);
            ImprovedSpirituality.requireWis(60)
                    .requireInt(90)
                    .requirePerk(HalfStepToImprovedSpirituality)
                    .requireLevel(12);
            ArcaneRegenerationMajor.requirePerk(GrandMage)
                    .requirePerk(ArcaneRegenerationMinor)
                    .requireInt(75)
                    .requireLevel(12);
            MagicMetabolism.requireHungerEnabled()
					.requirePerk(Channeling)
                    .requireInt(75)
                    .requireLevel(12);
            //Tier 3 Intelligence perks
            Archmage.requirePerk(GrandMage)
                    .requireInt(100).requireLevel(18);
            // Battleflash: auto-use Blink
            Battleflash.requireLevel(18)
                    .requirePerk(Battlemage)
                    .requireInt(90)
                    .requireStatusEffect(StatusEffects.KnowsBlink, "Blink spell");
            // Spellarmor: auto-use Charge Armor
            Spellarmor.requireLevel(18)
                    .requirePerk(Spellsword)
                    .requireInt(90)
                    .requireStatusEffect(StatusEffects.KnowsChargeA, "Charge Armor spell");
            TraditionalMageI.requireLevel(18)
                    .requirePerk(GrandMage)
                    .requireInt(80);
            TraditionalMageII.requireLevel(20)
                    .requirePerk(TraditionalMageI)
                    .requireInt(100)
                    .requireNGPlus(1);
            TraditionalMageIII.requireLevel(22)
                    .requirePerk(TraditionalMageII)
                    .requireInt(120)
                    .requireNGPlus(2);
            HalfStepToAdvancedSpirituality.requireWis(80)
                    .requireInt(120)
                    .requirePerk(ImprovedSpirituality)
                    .requireLevel(18);
            FortressOfIntellect.requireStatusEffect(StatusEffects.KnowsMight, "Might spell")
                    .requirePerk(GrandMage)
                    .requireInt(100)
                    .requireLevel(18);
            ArcaneRegenerationEpic.requirePerk(Archmage)
                    .requirePerk(ArcaneRegenerationMajor)
                    .requireInt(100)
                    .requireLevel(18);
            //Tier 4 Intelligence perks
            GrandArchmage.requirePerk(Archmage)
                    .requirePerk(FocusedMind)
                    .requireInt(125)
                    .requireLevel(24);
            TraditionalMageIV.requireLevel(24)
                    .requirePerk(TraditionalMageIII)
                    .requireInt(140)
                    .requireNGPlus(3);
            TraditionalMageV.requireLevel(26)
                    .requirePerk(TraditionalMageIV)
                    .requireInt(160)
                    .requireNGPlus(4);
            TraditionalMageVI.requireLevel(28)
                    .requirePerk(TraditionalMageV)
                    .requireInt(180)
                    .requireNGPlus(5);
            AdvancedSpirituality.requireWis(100)
                    .requireInt(150)
                    .requirePerk(HalfStepToAdvancedSpirituality)
                    .requireLevel(24);
            LongerLastingBuffsI.requirePerk(JobEnchanter)
                    .requireInt(120)
                    .requireLevel(24);
            LongerLastingBuffsII.requirePerk(LongerLastingBuffsI)
                    .requireInt(140)
                    .requireLevel(26)
                    .requireNGPlus(1);
            LongerLastingBuffsIII.requirePerk(LongerLastingBuffsII)
                    .requireInt(160)
                    .requireLevel(28)
                    .requireNGPlus(2);
            ArcaneRegenerationLegendary.requirePerk(GrandArchmage)
                    .requirePerk(ArcaneRegenerationEpic)
                    .requireInt(125)
                    .requireLevel(24);
            //Tier 5 Intelligence perks
            GrandArchmage2ndCircle.requirePerk(GrandArchmage)
                    .requireInt(150)
                    .requireLevel(30);
            HalfStepToSuperiorSpirituality.requireWis(120)
                    .requireInt(180)
                    .requirePerk(AdvancedSpirituality)
                    .requireLevel(30);
            LongerLastingBuffsIV.requirePerk(LongerLastingBuffsIII)
                    .requireInt(180)
                    .requireLevel(30)
                    .requireNGPlus(3);
            LongerLastingBuffsV.requirePerk(LongerLastingBuffsIV)
                    .requireInt(200)
                    .requireLevel(32)
                    .requireNGPlus(4);
            LongerLastingBuffsVI.requirePerk(LongerLastingBuffsV)
                    .requireInt(220)
                    .requireLevel(34)
                    .requireNGPlus(5);
            EverLastingBuffs.requirePerk(JobEnchanter)
                    .requireInt(160)
                    .requireLevel(30);
            UnlockForce2ndStage.requirePerk(UnlockForce)
                    .requireInt(125)
                    .requireLevel(30);
            //Tier 6 Intelligence perks
            GrandArchmage3rdCircle.requirePerk(GrandArchmage2ndCircle)
                    .requireInt(175)
                    .requireLevel(36);
            EternalyLastingBuffs.requirePerk(EverLastingBuffs)
                    .requireInt(190)
                    .requireLevel(36);
            SuperiorSpirituality.requireWis(140)
                    .requireInt(210)
                    .requirePerk(HalfStepToSuperiorSpirituality)
                    .requireLevel(36);
            EpicIntelligence.requireInt(10)
                    .requireLevel(36);
            GrandTactician.requirePerk(Tactician)
                    .requireInt(150)
                    .requireLevel(36);
            //Tier 7 Intelligence perks
        /*	PrestigeJobSeer.requirePrestigeJobSlot()
                    .requirePerk(GrandArchmage3rdCircle)
                    .requirePerk(SoulElder)
                    .requireInt(200)
                    .requireLevel(42);
		*/	PrestigeJobGreySage.requirePrestigeJobSlot()
                    .requirePerk(GrandArchmage3rdCircle)
                    .requirePerk(JobEnchanter)
                    .requireInt(200)
                    .requireLevel(42);
        	PrestigeJobWarlock.requirePrestigeJobSlot()
                    .requirePerk(GrandArchmage3rdCircle)
                    .requirePerk(JobEromancer)
                    .requireInt(200)
                    .requireLevel(42)
					.requireCustomFunction(function (player:Player):Boolean {
                        return player.statusEffectv1(StatusEffects.AlvinaTraining2) > 3;// || player.statusEffectv1(StatusEffects.SiegweirdTraining2) > 2
                    }, "Finished Alvina quest line up to the optional battle");//Siegweird
        	HalfStepToPeerlessSpirituality.requireWis(160)
                    .requireInt(240)
                    .requirePerk(SuperiorSpirituality)
                    .requireLevel(42);
            Battleshield.requireStatusEffect(StatusEffects.KnowsManaShield, "Mana Shield spell")
                    .requirePerk(JobEnchanter)
                    .requireInt(200)
                    .requireLevel(42);
            //Tier 8 Intelligence perks
            PeerlessSpirituality.requireWis(180)
                    .requireInt(270)
                    .requirePerk(HalfStepToPeerlessSpirituality)
                    .requireLevel(48);
            /*Trance.requirePerk(PrestigeJobSeer)
					.requireInt(240)
					.requireLevel(48);*/
            Convergence.requirePerk(PrestigeJobGreySage)
                    .requireInt(225)
                    .requireLevel(48);
            GreyMage.requirePerk(PrestigeJobGreySage)//później jeden z 2 grey mage prestige perks
                    .requireInt(225)
                    .requireLevel(48);
            HexKnowledge.requirePerk(PrestigeJobWarlock)
                    .requireInt(225)
                    .requireLevel(48);
            //Tier 9 Intelligence perks
            HalfStepToInhumanSpirituality.requireWis(200)
                    .requireInt(300)
                    .requirePerk(PeerlessSpirituality)
                    .requireLevel(54);
            //Tier 10 Intelligence perks
            GreyArchmage.requirePerk(GreyMage)
                    .requireInt(275)
                    .requireLevel(60);
            InhumanSpirituality.requireWis(220)
                    .requireInt(330)
                    .requirePerk(HalfStepToInhumanSpirituality)
                    .requireLevel(60);
            UnlockForce3rdStage.requirePerk(UnlockForce2ndStage)
                    .requireInt(230)
                    .requireLevel(60);
            //Tier 11 Intelligence perks
            HalfStepToEpicSpirituality.requireWis(240)
                    .requireInt(360)
                    .requirePerk(InhumanSpirituality)
                    .requireLevel(66);
            LegendaryIntelligence.requireInt(15)
                    .requirePerk(EpicIntelligence)
                    .requireLevel(66);
            //Tier 12 Intelligence perks
            EpicSpirituality.requireWis(260)
                    .requireInt(390)
                    .requirePerk(HalfStepToEpicSpirituality)
                    .requireLevel(72);
            //Tier 13 Intelligence perks
            HalfStepToLegendarySpirituality.requireWis(280)
                    .requireInt(420)
                    .requirePerk(EpicSpirituality)
                    .requireLevel(78);
            //Tier 14 Intelligence perks
            LegendarySpirituality.requireWis(300)
                    .requireInt(450)
                    .requirePerk(HalfStepToLegendarySpirituality)
                    .requireLevel(84);
            //Tier 15 Intelligence perks
            HalfStepToMythicalSpirituality.requireWis(320)
                    .requireInt(480)
                    .requirePerk(LegendarySpirituality)
                    .requireLevel(90);
            UnlockForce4thStage.requirePerk(UnlockForce3rdStage)
                    .requireInt(335)
                    .requireLevel(90);
            //Tier 16 Intelligence perks
            MythicalSpirituality.requireWis(340)
                    .requireInt(510)
                    .requirePerk(HalfStepToMythicalSpirituality)
                    .requireLevel(96);
            MythicalIntelligence.requireInt(20)
                    .requirePerk(LegendaryIntelligence)
                    .requireLevel(96);
            //------------
            // WISDOM
            //------------
            JobElementalConjurer.requireAdvancedJobSlot()
					.requirePerk(JobLeader)
                    .requireWis(10);
            ElementalConjurerResolve.requirePerk(JobElementalConjurer)
                    .requireWis(20);
            ElementalContractRank1.requirePerk(ElementalConjurerResolve)
                    .requireWis(25);
            ElementsOfTheOrtodoxPath.requirePerk(ElementalContractRank1)
                    .requireWis(30);
            ElementsOfMarethBasics.requirePerk(ElementsOfTheOrtodoxPath)
                    .requireWis(35);
            UnlockSpirit.requireWis(20);
            //Tier 1 Wisdom perks
            ElementalContractRank2.requirePerk(ElementalContractRank1)
                    .requireWis(50)
                    .requireLevel(6);
            ElementalBondFlesh.requirePerk(ElementalContractRank1)
                    .requireWis(50)
                    .requireLevel(6);
            ElementsOfMarethAdvanced.requirePerk(ElementsOfMarethBasics)
					.requireWis(50)
					.requireLevel(6);
            MagiculesTheory.requireWis(50)
                    .requireLevel(6);
            JobGunslinger.requireAdvancedJobSlot()
					.requirePerk(JobRanger)
					.requireWis(25)
					.requireTou(20)
                    .requireSpe(15)
                    .requireLevel(6);
            AmateurGunslinger.requirePerk(JobGunslinger)
					.requireWis(30)
					.requireTou(25)
                    .requireSpe(20)
                    .requireLevel(6);
            DualWieldFirearms.requirePerk(JobGunslinger)
					.requireWis(25)
					.requireTou(20)
                    .requireSpe(15)
                    .requireLevel(6);
            //Tier 2 Wisdom perks
            JobMonk.requireAdvancedJobSlot()
					.requirePerk(JobSoulCultivator)
					.requireWis(60)
                    .requireLevel(12);
            Combo.requirePerk(JobMonk)
                    .requireWis(75)
                    .requireSpe(50)
                    .requireLevel(12);
            ElementalContractRank3.requirePerk(ElementalContractRank2)
                    .requireWis(75)
                    .requireLevel(12);
            ElementalBondUrges.requirePerk(ElementalContractRank2)
                    .requireWis(75)
                    .requireLevel(12);
            StrongElementalBond.requirePerk(ElementalContractRank3)
                    .requireWis(75)
                    .requireLevel(12);
            RapidReload.requirePerk(JobGunslinger)
					.requireWis(35)
                    .requireTou(30)
                    .requireSpe(25)
                    .requireLevel(12);
			ExplosiveCartridge.requirePerk(AmateurGunslinger)
					.requireWis(40)
                    .requireTou(35)
                    .requireSpe(30)
                    .requireLevel(12);
            //Tier 3 Wisdom perks
            ElementalContractRank4.requirePerk(ElementalContractRank3)
                    .requireWis(100)
                    .requireLevel(18);
            CatchTheBlade.requirePerk(JobMonk)
                    .requireWis(80)
                    .requireSpe(100)
                    .requireLevel(18);
            ExpertGunslinger.requirePerk(AmateurGunslinger)
					.requireWis(55)
                    .requireTou(50)
                    .requireSpe(45)
                    .requireLevel(18);
			NamedBullet.requirePerk(AmateurGunslinger)
					.requireWis(50)
                    .requireTou(45)
                    .requireSpe(40)
                    .requireLevel(18);
            //Tier 4 Wisdom perks
            ComboMaster.requirePerk(Combo)
                    .requireWis(125)
                    .requireSpe(100)
                    .requireLevel(24);
            ElementalContractRank5.requirePerk(ElementalContractRank4)
                    .requirePerk(ElementalConjurerDedication)
                    .requireWis(125)
                    .requireLevel(24);
            StrongerElementalBond.requirePerk(StrongElementalBond)
                    .requirePerk(ElementalContractRank5)
                    .requireWis(125)
                    .requireLevel(24);
            ElementalConjurerDedication.requirePerk(ElementalConjurerResolve)
                    .requireWis(120)
                    .requireLevel(24);
            FirstAttackElementals.requirePerk(StrongElementalBond)
                    .requirePerk(ElementalContractRank4)
                    .requireLevel(24);
            LightningReload.requirePerk(RapidReload)
					.requireWis(65)
                    .requireTou(60)
                    .requireSpe(55)
                    .requireLevel(24);
            //Tier 5 Wisdom perks
            UnlockSpirit2ndStage.requirePerk(UnlockSpirit)
                    .requireWis(125)
                    .requireLevel(30);
            ElementalContractRank6.requirePerk(ElementalContractRank5)
                    .requireWis(150)
                    .requireLevel(30);
            MasterGunslinger.requirePerk(ExpertGunslinger)
					.requireWis(80)
                    .requireTou(75)
                    .requireSpe(70)
                    .requireLevel(30);
            AlchemicalCartridge.requirePerk(ExpertGunslinger)
					.requireWis(80)
                    .requireTou(75)
                    .requireInt(70)
                    .requireLevel(30);
            //Tier 6 Wisdom perks
            ElementalContractRank7.requirePerk(ElementalContractRank6)
                    .requireWis(175)
                    .requireLevel(36);
            StrongestElementalBond.requirePerk(StrongerElementalBond)
                    .requirePerk(ElementalContractRank7)
                    .requireWis(175)
                    .requireLevel(36);
            EpicWisdom.requireWis(10)
                    .requireLevel(36);
            AdvancedMagiculesTheory.requirePerk(MagiculesTheory)
                    .requireWis(150)
                    .requireLevel(36);
            ChurchOfTheGun.requirePerk(MasterGunslinger)
					.requireWis(95)
                    .requireTou(90)
                    .requireInt(85)
                    .requireLevel(36);
            //Tier 7 Wisdom perks
            PrestigeJobSoulArtMaster.requirePrestigeJobSlot()
                    .requirePerk(FleshBodyApprenticeStage)
                    .requirePerk(JobMonk)
                    .requireWis(200)
                    .requireLevel(42);
            ElementalContractRank8.requirePerk(ElementalContractRank7)
                    .requireWis(200)
                    .requireLevel(42);
            //Tier 8 Wisdom perks
            ElementalContractRank9.requirePerk(ElementalContractRank8)
                    .requirePerk(ElementalConjurerSacrifice)
                    .requireWis(225)
                    .requireLevel(48);
            ElementalConjurerSacrifice.requirePerk(ElementalConjurerDedication)
                    .requireWis(220)
                    .requireLevel(48);
            PerfectStrike.requireLevel(48)
                    .requirePerk(PrestigeJobSoulArtMaster);
            //Tier 9 Wisdom perks
            ElementalContractRank10.requirePerk(ElementalContractRank9)
                    .requireWis(250)
                    .requireLevel(54);
            StrongestElementalBondEx.requirePerk(StrongestElementalBond)
                    .requirePerk(ElementalContractRank10)
                    .requireWis(250)
                    .requireLevel(54);
            Backlash.requireLevel(54)
                    .requirePerk(PerfectStrike);
            //Tier 10 Wisdom perks
            ElementalContractRank11.requirePerk(ElementalContractRank10)
                    .requireWis(275)
                    .requireLevel(60);
            UnlockSpirit3rdStage.requirePerk(UnlockSpirit2ndStage)
                    .requireWis(230)
                    .requireLevel(60);
            FlurryOfBlows.requireLevel(60)
                    .requirePerk(ComboMaster)
                    .requirePerk(Backlash);
            //Tier 11 Wisdom perks
            ElementalContractRank12.requirePerk(ElementalContractRank11)
                    .requireWis(300)
                    .requireLevel(66);
            LegendaryWisdom.requireWis(15)
                    .requirePerk(EpicWisdom)
                    .requireLevel(66);
            RecoveryMantra.requireLevel(66)
                    .requirePerk(FlurryOfBlows);
            //Tier 12 Wisdom perks
            ElementalContractRank13.requirePerk(ElementalContractRank12)
                    .requireWis(325)
                    .requireLevel(72);
            //Tier 13 Wisdom perks
			ElementalContractRank14.requirePerk(ElementalContractRank13)
                    .requireWis(350)
                    .requireLevel(78);
            //Tier 14 Wisdom perks
			ElementalContractRank15.requirePerk(ElementalContractRank14)
                    .requireWis(375)
                    .requireLevel(84);
            //Tier 15 Wisdom perks
			UnlockSpirit4thStage.requirePerk(UnlockSpirit3rdStage)
                    .requireWis(335)
                    .requireLevel(90);
			ElementalContractRank16.requirePerk(ElementalContractRank15)
                    .requireWis(400)
                    .requireLevel(90);
			///Tier 16 Wisdom perks
			ElementalContractRank17.requirePerk(ElementalContractRank16)
                    .requireWis(425)
                    .requireLevel(96);
            MythicalWisdom.requireWis(20)
                    .requirePerk(LegendaryWisdom)
                    .requireLevel(96);
			///Tier 17 Wisdom perks
			ElementalContractRank18.requirePerk(ElementalContractRank17)
                    .requireWis(450)
                    .requireLevel(102);
			///Tier 18 Wisdom perks
			ElementalContractRank19.requirePerk(ElementalContractRank18)
                    .requireWis(475)
                    .requireLevel(108);
			///Tier 19 Wisdom perks
			ElementalContractRank20.requirePerk(ElementalContractRank19)
                    .requireWis(500)
                    .requireLevel(114);
            StrongestElementalBondSu.requirePerk(StrongestElementalBondEx)
                    .requirePerk(ElementalContractRank20)
                    .requireWis(500)
                    .requireLevel(114);
			///Tier 20 Wisdom perks
			ElementalContractRank21.requirePerk(ElementalContractRank20)
                    .requireWis(525)
                    .requireLevel(120);
			///Tier 21 Wisdom perks
			ElementalContractRank22.requirePerk(ElementalContractRank21)
                    .requireWis(550)
                    .requireLevel(126);
			///Tier 22 Wisdom perks
			ElementalContractRank23.requirePerk(ElementalContractRank22)
                    .requireWis(575)
                    .requireLevel(132);
			///Tier 23 Wisdom perks
			ElementalContractRank24.requirePerk(ElementalContractRank23)
                    .requireWis(600)
                    .requireLevel(138);
			///Tier 24 Wisdom perks
			ElementalContractRank25.requirePerk(ElementalContractRank24)
                    .requireWis(625)
                    .requireLevel(144);
			///Tier 25 Wisdom perks
			ElementalContractRank26.requirePerk(ElementalContractRank25)
                    .requireWis(650)
                    .requireLevel(150);
			///Tier 26 Wisdom perks
			ElementalContractRank27.requirePerk(ElementalContractRank26)
                    .requireWis(675)
                    .requireLevel(156);
			///Tier 27 Wisdom perks
			ElementalContractRank28.requirePerk(ElementalContractRank27)
                    .requireWis(700)
                    .requireLevel(162);
			///Tier 28 Wisdom perks
			ElementalContractRank29.requirePerk(ElementalContractRank28)
                    .requireWis(725)
                    .requireLevel(168);
			///Tier 29 Wisdom perks
			ElementalContractRank30.requirePerk(ElementalContractRank29)
                    .requireWis(750)
                    .requireLevel(174);
			///Tier 30 Wisdom perks
			ElementalContractRank31.requirePerk(ElementalContractRank30)
                    .requireWis(775)
                    .requireLevel(180);
            //------------
            // LIBIDO
            //------------
            //slot 5 - libido perks

            //Slot 5 - Fertile+ increases cum production and fertility (+15%)
            JobSeducer.requireLib(10);
            UnlockArdor.requireLib(20);
            FertilityPlus.requireLib(25);
            FertilityPlus.defaultValue1 = 15;
            FertilityPlus.defaultValue2 = 1.75;
            BasicSelfControl.requireLib(30)
                    .requireInt(20);
            Sensual.requirePerk(JobSeducer)
                    .requireLib(20);
            SuperSensual.requirePerk(Sensual)
                    .requireLib(40);
            //Slot 5 - minimum libido
            ColdBlooded.requireMinLust(20);
            ColdBlooded.defaultValue1 = 20;
            HotBlooded.requireLib(50);
            HotBlooded.defaultValue1 = 20;
            //Tier 1 Libido Perks
            //Slot 5 - minimum libido
            //Slot 5 - Fertility- decreases cum production and fertility.
            FertilityMinus.requireLibLessThan(25)
                    .requireLevel(6);
            FertilityMinus.defaultValue1 = 15;
            FertilityMinus.defaultValue2 = 0.7;
            WellAdjusted.requireLib(60)
                    .requireLevel(6);
            //Slot 5 - minimum libido
            Masochist.requireLib(60)
                    .requireCor(50)
                    .requireLevel(6);
            JobEromancer.requireAdvancedJobSlot()
					.requirePerk(JobSeducer)
                    .requireLib(35)
                    .requireInt(35)
                    .requireLevel(6);
            ArcaneLash.requirePerk(JobEromancer)
					.requireLevel(6);
            EromancyBeginner.requirePerk(JobEromancer)
					.requireLib(45)
                    .requireInt(45)
                    .requireLevel(6);
            HalfStepToImprovedSelfControl.requireLib(60)
                    .requireInt(40)
                    .requirePerk(BasicSelfControl)
                    .requireLevel(6);
            InhumanDesireI.requirePerk(JobSeducer)
                    .requireLib(50)
                    .requireLevel(6);
            InhumanDesireII.requirePerk(InhumanDesireI)
                    .requireLib(70)
                    .requireLevel(8)
                    .requireNGPlus(1);
            InhumanDesireIII.requirePerk(InhumanDesireII)
                    .requireLib(90)
                    .requireLevel(10)
                    .requireNGPlus(2);

            //Tier 2 Libido Perks
            InhumanDesireIV.requirePerk(InhumanDesireIII)
                    .requireLib(110)
                    .requireNGPlus(3)
                    .requireLevel(12);
            InhumanDesireV.requirePerk(InhumanDesireIV)
                    .requireLib(130)
                    .requireLevel(14)
                    .requireNGPlus(4);
            InhumanDesireVI.requirePerk(InhumanDesireV)
                    .requireLib(150)
                    .requireLevel(16)
                    .requireNGPlus(5);
            DemonicDesireI.requirePerk(InhumanDesireI)
                    .requireLib(75)
                    .requireLevel(12);
            DemonicDesireII.requirePerk(DemonicDesireI)
                    .requireLib(95)
                    .requireLevel(14)
                    .requireNGPlus(1);
            DemonicDesireIII.requirePerk(DemonicDesireII)
                    .requireLib(115)
                    .requireLevel(16)
                    .requireNGPlus(2);
            ImprovedSelfControl.requireLib(90)
                    .requireInt(60)
                    .requirePerk(HalfStepToImprovedSelfControl)
                    .requireLevel(12);
            Transference.requirePerk(JobEromancer)
                    .requireLevel(12)
                    .requireLib(50)
                    .requireStatusEffect(StatusEffects.KnowsArouse, "Arouse spell");
            EromancyExpert.requirePerk(EromancyBeginner)
					.requireLib(65)
                    .requireInt(65)
                    .requireLevel(12);
            JobCourtesan.requireAdvancedJobSlot()
					.requirePerk(JobSeducer)
                    .requireLib(50)
                    .requireLevel(12);
            DazzlingDisplay.requirePerk(JobCourtesan)
                    .requireLib(50)
                    .requireLevel(12);
            //Tier 3 Libido Perks
            DemonicDesireIV.requirePerk(DemonicDesireIII)
                    .requireLib(135)
                    .requireNGPlus(3)
                    .requireLevel(18);
            DemonicDesireV.requirePerk(DemonicDesireIV)
                    .requireLib(155)
                    .requireLevel(20)
                    .requireNGPlus(4);
            DemonicDesireVI.requirePerk(DemonicDesireV)
                    .requireLib(175)
                    .requireLevel(22)
                    .requireNGPlus(5);
            HalfStepToAdvancedSelfControl.requireLib(120)
                    .requireInt(80)
                    .requirePerk(ImprovedSelfControl)
                    .requireLevel(18);
            ColdLust.requirePerk(Lustzerker)
                    .requirePerk(ImprovedSelfControl)
                    .requireLib(75)
                    .requireLevel(18);
            EromancyMaster.requirePerk(EromancyExpert)
					.requireLib(85)
                    .requireInt(85)
                    .requireLevel(18);
            ArouseTheAudience.requirePerk(JobCourtesan)
                    .requireLib(75)
                    .requireLevel(18);
            //Tier 4 Libido Perks
            AdvancedSelfControl.requireLib(150)
                    .requireInt(100)
                    .requirePerk(HalfStepToAdvancedSelfControl)
                    .requireLevel(24);
            CriticalPerformance.requirePerk(JobCourtesan)
                    .requireLib(100)
                    .requireLevel(24);
            GiftOfLust.requirePerk(Transference)
                    .requirePerk(EromancyBeginner)
					.requireLevel(24)
                    .requireLib(100);
            //Tier 5 Libido Perks
            HalfStepToSuperiorSelfControl.requireLib(180)
                    .requireInt(120)
                    .requirePerk(AdvancedSelfControl)
                    .requireLevel(30);
            ColderLust.requirePerk(ColdLust)
                    .requirePerk(AdvancedSelfControl)
                    .requireLib(150)
                    .requireLevel(30);
            UnlockArdor2ndStage.requirePerk(UnlockArdor)
                    .requireLib(125)
                    .requireLevel(30);
            //Tier 6 Libido Perks
            SuperiorSelfControl.requireLib(210)
                    .requireInt(140)
                    .requirePerk(HalfStepToSuperiorSelfControl)
                    .requireLevel(36);
            EpicLibido.requireLib(10)
                    .requireLevel(36);
            GreaterGiftOfLust.requirePerk(GiftOfLust)
                    .requirePerk(EromancyExpert)
					.requireLevel(36)
                    .requireLib(150);
            //Tier 7 Libido Perks
            HalfStepToPeerlessSelfControl.requireLib(240)
                    .requireInt(160)
                    .requirePerk(SuperiorSelfControl)
                    .requireLevel(42);
            //Tier 8 Libido Perks
            PeerlessSelfControl.requireLib(270)
                    .requireInt(180)
                    .requirePerk(HalfStepToPeerlessSelfControl)
                    .requireLevel(48);
            //Tier 9 Libido Perks
            HalfStepToInhumanSelfControl.requireLib(300)
                    .requireInt(200)
                    .requirePerk(PeerlessSelfControl)
                    .requireLevel(54);
            //Tier 10 Libido Perks
            InhumanSelfControl.requireLib(330)
                    .requireInt(220)
                    .requirePerk(HalfStepToInhumanSelfControl)
                    .requireLevel(60);
            UnlockArdor3rdStage.requirePerk(UnlockArdor2ndStage)
                    .requireLib(230)
                    .requireLevel(60);
            //Tier 11 Libido Perks
            HalfStepToEpicSelfControl.requireLib(360)
                    .requireInt(240)
                    .requirePerk(InhumanSelfControl)
                    .requireLevel(66);
            LegendaryLibido.requireLib(15)
                    .requirePerk(EpicLibido)
                    .requireLevel(66);
            //Tier 12 Libido Perks
            EpicSelfControl.requireLib(390)
                    .requireInt(260)
                    .requirePerk(HalfStepToEpicSelfControl)
                    .requireLevel(72);
            //Tier 13 Libido Perks
            HalfStepToLegendarySelfControl.requireLib(420)
                    .requireInt(280)
                    .requirePerk(EpicSelfControl)
                    .requireLevel(78);
            //Tier 14 Libido Perks
            LegendarySelfControl.requireLib(450)
                    .requireInt(300)
                    .requirePerk(HalfStepToLegendarySelfControl)
                    .requireLevel(84);
            //Tier 15 Libido Perks
            HalfStepToMythicalSelfControl.requireLib(480)
                    .requireInt(320)
                    .requirePerk(LegendarySelfControl)
                    .requireLevel(90);
            UnlockArdor4thStage.requirePerk(UnlockArdor3rdStage)
                    .requireLib(335)
                    .requireLevel(90);
            //Tier 16 Libido Perks
            MythicalSelfControl.requireLib(510)
                    .requireInt(340)
                    .requirePerk(HalfStepToMythicalSelfControl)
                    .requireLevel(96);
            MythicalLibido.requireLib(20)
                    .requirePerk(LegendaryLibido)
                    .requireLevel(96);
            //------------
            // SENSITIVITY
            //------------
            //Slot 6 - Tier 0
            EyesOfTheHunterNovice.requireSen(25);
            //.requireSen(25);
            //.requireMinSens(15);
            //Tier 1 Sensitivity Perks
            EyesOfTheHunterAdept.requireSen(50)
                    .requirePerk(EyesOfTheHunterNovice)
                    .requireLevel(6);
            //Tier 2 Sensitivity Perks
            EyesOfTheHunterMaster.requireSen(75)
                    .requirePerk(EyesOfTheHunterAdept)
                    .requireLevel(12);
            //Tier 3 Sensitivity Perks
            //Tier 4 Sensitivity Perks
            //Tier 5 Sensitivity Perks
            //Tier 6 Sensitivity Perks
			EpicSensitivity.requireSen(10)
                    .requireLevel(36);
            //Tier 7 Sensitivity Perks
            //Tier 8 Sensitivity Perks
            //Tier 9 Sensitivity Perks
            //Tier 10 Sensitivity Perks
            //Tier 11 Sensitivity Perks
            LegendarySensitivity.requireSen(15)
                    .requirePerk(EpicSensitivity)
                    .requireLevel(66);
            //Tier 12 Sensitivity Perks
            //Tier 13 Sensitivity Perks
            //Tier 14 Sensitivity Perks
            //Tier 15 Sensitivity Perks
            //Tier 16 Sensitivity Perks
            MythicalSensitivity.requireSen(20)
                    .requirePerk(LegendarySensitivity)
                    .requireLevel(96);
            //Tier 17 Sensitivity Perks
            //Tier 18 Sensitivity Perks
            //Tier 19 Sensitivity Perks
            //Tier 20 Sensitivity Perks
            //Tier 21 Sensitivity Perks
            //------------
            // CORRUPTION
            //------------
            //Slot 7 - Corrupted Libido - lust raises 10% slower.
            CorruptedLibido.requireCor(10);
            CorruptedLibido.defaultValue1 = 20;
            //Slot 7 - Seduction (Must have seduced Jojo)
            Seduction.requireCor(15);
            //Slot 7 - Nymphomania
            Nymphomania.requireCor(15)
                    .requirePerk(CorruptedLibido);
            //Slot 7 - UNFINISHED :3
            Acclimation.requireCor(15)
                    .requirePerk(CorruptedLibido)
                    .requireMinLust(20);
			//
            //Tier 1 Corruption Perks - acclimation over-rides
            Sadist.requireCor(20)
                    .requirePerk(CorruptedLibido)
                    .requireLevel(6);
            ArousingAura.requireCor(25)
                    .requirePerk(CorruptedLibido)
                    .requireLevel(6);
            //Tier 2
            /*if (requireMinLevel(12))
			{
			if (requirePerk(JobSeducer)
			.requireMinCor(50)) {
			_add(new PerkClass(PerkLib				job:corrupter czy jakoś tak - daje efekt iż wszyscy reaguja jakby pc miał 10/15/20/25 mniej corruption, nie wiem czy jeszcze jakiś efekt dodać
			}
			}*/
            //Tier 3
            //Tier 4
            //------------
            // SOULFORCE
            //------------
            //Tier 0
            JobSoulCultivator.requireWis(10);
            Dantain.requirePerk(JobSoulCultivator)
                    .requireMaxSoulforce(100);
            BodyCultivator.requirePerk(JobSoulCultivator);
            DaoistCultivator.requirePerk(JobSoulCultivator);
            //HeartCultivator.requirePerk(JobSoulCultivator);		//psionic/min powers cultivation/psion class from D&D?
            //requirePerk(JobSoulCultivator)		//allowing to use soulforce options more times per day - 1/2/3 time more?
            //requirePerk(JobSoulCultivator)		//allowing to use soul artifacts - new slot?
            //Tier 1
            SoulApprentice.requireWis(20)
                    .requireLevel(6)
                    .requirePerk(JobSoulCultivator);
            InsightfulResourcesI.requireLevel(6)
                    .requireWis(50)
                    .requirePerk(JobSoulCultivator);
            FleshBodyApprenticeStage.requireLevel(6)
                    .requirePerk(BodyCultivator);
            DaoistApprenticeStage.requireLevel(6)
                    .requirePerk(DaoistCultivator);
            InsightfulResourcesII.requireLevel(6)
                    .requirePerk(InsightfulResourcesI)
                    .requireWis(70)
                    .requireLevel(8)
                    .requireNGPlus(1);
            InsightfulResourcesIII.requirePerk(InsightfulResourcesII)
                    .requireWis(90)
                    .requireLevel(10)
                    .requireNGPlus(2);
            //Tier 2
            SoulPersonage.requireLevel(12)
                    .requirePerk(SoulApprentice)
                    .requireWis(40);
            InsightfulResourcesIV.requireLevel(12)
                    .requirePerk(InsightfulResourcesIII)
                    .requireWis(110)
                    .requireNGPlus(3);
            InsightfulResourcesV.requirePerk(InsightfulResourcesIV)
                    .requireWis(130)
                    .requireLevel(20)
                    .requireNGPlus(4);
            InsightfulResourcesVI.requirePerk(InsightfulResourcesV)
                    .requireWis(150)
                    .requireLevel(22)
                    .requireNGPlus(5);
            //Tier 3
            SoulWarrior.requirePerk(SoulPersonage)
                    .requireWis(60)
                    .requireLevel(18);
            //Tier 4
            SoulSprite.requireLevel(24)
                    .requirePerk(SoulWarrior)
                    .requireWis(80); // && requirePerk(HclassHeavenTribulationSurvivor)
            FleshBodyWarriorStage.requireLevel(24)
                    .requirePerk(FleshBodyApprenticeStage);
            DaoistWarriorStage.requireLevel(24)
                    .requirePerk(DaoistApprenticeStage);
            //Tier 5
            SoulScholar.requirePerk(SoulSprite)
                    .requireWis(100)
                    .requireLevel(30);
            //Tier 6
            SoulElder.requirePerk(SoulScholar)
                    .requireWis(120)
                    .requireLevel(36);
            //Tier 7
            SoulExalt.requirePerk(SoulElder)
                    .requireWis(140)
                    .requireLevel(42);// && requirePerk(GclassHeavenTribulationSurvivor)
            FleshBodyElderStage.requireLevel(42)
                    .requirePerk(FleshBodyWarriorStage);
            DaoistElderStage.requireLevel(42)
                    .requirePerk(DaoistWarriorStage);
            //Tier 8
            SoulOverlord.requirePerk(SoulExalt)
                    .requireWis(160)
                    .requireLevel(48);
            //Tier 9
            SoulTyrant.requireLevel(54)
                    .requirePerk(SoulOverlord)
                    .requireWis(180);
            //Tier 10
     /*		SoulKing.requirePerk(SoulTyrant)
                    .requireWis(200)
                    .requireLevel(60);
            FleshBodyOverlordStage.requireLevel(60)
                    .requirePerk(FleshBodyElderStage);
            DaoistOverlordStage.requireLevel(60)
                    .requirePerk(DaoistElderStage);
            //Tier 11
            SoulEmperor.requirePerk(SoulKing)
                    .requireWis(220)
                    .requireLevel(66);
            //Tier 12
            SoulAncestor.requirePerk(SoulEmperor)
                    .requireWis(240)
                    .requireLevel(72);
     */		//------------
            // MISCELLANEOUS
            //------------
            //Tier 0
            BlackHeart.requireHeartMutationSlot().requirePerk(DarkCharm).requireCor(100).requireCustomFunction(function (player:Player):Boolean {
                return player.demonScore() >= 5;
            }, "Demon race");
            CatlikeNimbleness.requirePerk(Flexibility).requireCustomFunction(function (player:Player):Boolean {
                return player.catScore() >= 4 || player.nekomataScore() >= 4 || player.displacerbeastScore() >= 4 || player.hellcatScore() >= 4 || player.cheshireScore() >= 4;
            }, "Any cat race");
            DraconicLungs.requirePerk(DragonFireBreath)
                .requirePerk(DragonIceBreath)
                .requirePerk(DragonLightningBreath)
                .requirePerk(DragonDarknessBreath).requireCustomFunction(function (player:Player):Boolean {
                return player.dragonScore() >= 4;
            }, "Dragon race");
            ElvishPeripheralNervSys.requirePerk(ElvenSense).requireCustomFunction(function (player:Player):Boolean {
                return player.elfScore() >= 4;
            }, "Elf race");
            FrozenHeart.requireHeartMutationSlot().requireCustomFunction(function (player:Player):Boolean {
                return player.yukiOnnaScore() >= 14;
            }, "Yuki onna race");
            GorgonsEyes.requireCustomFunction(function (player:Player):Boolean {
                return player.eyes.type == 4;
				}, "Gorgon eyes")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.gorgonScore() >= 5;
            }, "Gorgon race");
			HinezumiBurningBlood.requireBloodsteamMutationSlot().requireCustomFunction(function (player:Player):Boolean {
                return player.arms.type == 34;
				}, "Hinezumi arms")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.lowerBody == 49;
				}, "Hinezumi legs")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.tailType == 43;
				}, "Hinezumi tail")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.mouseScore() >= 12;
            }, "Mouse race");
			HollowFangs.requireMouthMutationSlot().requirePerk(VampiricBloodsteam)
				.requireCustomFunction(function (player:Player):Boolean {
                return player.facePart.type == 34;//player.facePart.isAny(Face.VAMPIRE, Face.)
				}, "Vampire fangs")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.vampireScore() >= 4;//potem dodać mosquito race i ew. inne co mogą wypijać krew
            }, "Vampire race");
            KitsuneThyroidGland.requireAnyPerk(EnlightenedKitsune, CorruptedKitsune).requireCustomFunction(function (player:Player):Boolean {
                return player.kitsuneScore() >= 5;
            }, "Kitsune race");
            LactaBovinaOvaries.requireCustomFunction(function (player:Player):Boolean {
                return player.hasVagina();
				}, "is Female")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.femininity >= 95;
				}, "95+ feminity")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.cowScore() >= 4;
            }, "Lacta Bovine race");
            LizanMarrow.requirePerk(LizanRegeneration).requireCustomFunction(function (player:Player):Boolean {
                return player.lizardScore() >= 4;
            }, "Lizan race");
            ManticoreMetabolism.requireCustomFunction(function (player:Player):Boolean {
                return player.manticoreScore() >= 5 && player.tailType == Tail.MANTICORE_PUSSYTAIL;
            }, "Manticore race and tail");
            MantislikeAgility.requireMusclesMutationSlot().requirePerk(TrachealSystem).requireCustomFunction(function (player:Player):Boolean {
                return player.mantisScore() >= 5;
            }, "Mantis race");
            MinotaurTesticles.requireCustomFunction(function (player:Player):Boolean {
                return player.hasCock();
				}, "is Male")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.femininity <= 5;
				}, "5- feminity")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.minotaurScore() >= 4;
            }, "Minotaur race");
            NaturalPunchingBag.requireFatTissueMutationSlot().requirePerk(BouncyBody).requireCustomFunction(function (player:Player):Boolean {
                return player.goblinScore() >= 4;
            }, "Goblin race");
            ObsidianHeart.requireHeartMutationSlot().requireCor(100).requireCustomFunction(function (player:Player):Boolean {
                return player.devilkinScore() >= 10;
            }, "Devil race");
            OniMusculature.requireMusclesMutationSlot().requireCustomFunction(function (player:Player):Boolean {
                return player.tone >= 100;
				}, "100+ tone")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.oniScore() >= 4;
            }, "Oni race");
            OrcAdrenalGlands.requireAdrenalGlandsMutationSlot().requirePerk(Ferocity).requireCustomFunction(function (player:Player):Boolean {
                return player.orcScore() >= 4;
            }, "Orc race");
            PigBoarFat.requireFatTissueMutationSlot().requireCustomFunction(function (player:Player):Boolean {
                return player.thickness >= 100;
				}, "100+ thickness")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.pigScore() >= 4;
            }, "Pig/Boar race");
            SalamanderAdrenalGlands.requireAdrenalGlandsMutationSlot().requirePerk(Lustzerker).requireCustomFunction(function (player:Player):Boolean {
                return player.salamanderScore() >= 4;
            }, "Salamander race");
            ScyllaInkGlands.requirePerk(InkSpray).requireCustomFunction(function (player:Player):Boolean {
                return player.scyllaScore() >= 5;
            }, "Scylla race");
            TrachealSystem.requireCustomFunction(function (player:Player):Boolean {
                return player.beeScore() >= 4 || player.mantisScore() >= 4 || player.scorpionScore() >= 4 || player.spiderScore() >= 4;
            }, "Any insect race");
            TwinHeart.requireHeartMutationSlot().requireCustomFunction(function (player:Player):Boolean {
                return player.centaurScore() >= 4;
            }, "Centaur race");
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
            /*
			if (player.() >=  && ) {
			_add(new PerkClass(PerkLib.));
			}
			if (player.() >=  && ) {
			_add(new PerkClass(PerkLib.));
			}
			Phoenix Thorax czy jakiś inny związany z morphami perk ub coś związane z gardłem - dla ras mogących używać ultradźwieki jako atak lub kogoś typu banshee atak wyciem

			Perk związany ze skórą

			Perk związany z układem nerwowym

			Perk związany z koścmi

			if (flags[kFLAGS.HUNGER_ENABLED] > 0 && game.player.humanScore() < 5) {
			_add(new PerkClass(PerkLib.)); - zelazny zoladek czy cos w tym stylu
			}
			*/
            Metamorph.requirePerk(GeneticMemory);
            //MetamorphEx.requirePerk(Metamorph);
            //	JobArtificer.requireInt(25)
            //				.requireWis(25);
            JobBeastWarrior.requireStr(20)
					.requireTou(20)
					.requireSpe(20);
            PrimalFuryI.requirePerk(JobBeastWarrior);
            PrimalFuryII.requirePerk(PrimalFuryI)
					.requireLevel(2)
					.requireNGPlus(1);
            PrimalFuryIII.requirePerk(PrimalFuryII)
					.requireLevel(4)
					.requireNGPlus(2);
			ToughHide.requirePerk(JobBeastWarrior)
					.requireTou(30);
			AerialCombat.requireStr(20)
					.requireSpe(20)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.canFly();
                    }, "Can fly");
            IronStomach.requireHungerEnabled();
            JobLeader.requireInt(10)
					.requireWis(10);
            Motivation.requirePerk(JobLeader)
					.requirePerk(BasicLeadership);
            //Tier 1
            BlackHeartEvolved.requireLevel(6)
				.requirePerk(BlackHeart)
				.requireCor(100)
				.requireCustomFunction(function (player:Player):Boolean {
                return player.demonScore() >= 9;
            }, "Demon race");
            CatlikeNimblenessEvolved.requireLevel(6)
					.requirePerk(CatlikeNimbleness)
					.requireCustomFunction(function (player:Player):Boolean {
						return player.catScore() >= 8 || player.nekomataScore() >= 8 || player.displacerbeastScore() >= 8 || player.hellcatScore() >= 8 || player.cheshireScore() >= 8;
					}, "Any cat race");
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
            HinezumiBurningBloodEvolved.requireLevel(6)
				.requirePerk(HinezumiBurningBlood)
				.requireCustomFunction(function (player:Player):Boolean {
                return player.arms.type == 34;
				}, "Hinezumi arms")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.lowerBody == 49;
				}, "Hinezumi legs")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.tailType == 43;
				}, "Hinezumi tail")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.mouseScore() >= 12;
            }, "Mouse race");
			ManticoreMetabolismEvolved.requireLevel(6)
				.requirePerk(ManticoreMetabolism)
				.requireCustomFunction(function (player:Player):Boolean {
					return player.manticoreScore() >= 10 && player.tailType == Tail.MANTICORE_PUSSYTAIL;
            }, "Manticore race and tail");
			ObsidianHeartEvolved.requireLevel(6)
				.requirePerk(ObsidianHeart)
				.requireCor(100)
				.requireCustomFunction(function (player:Player):Boolean {
                return player.devilkinScore() >= 12;
            }, "Devil race");
            /*ScyllaInkGlandsEvolved.requireLevel(6).requirePerk(ScyllaInkGlands).requireCustomFunction(function (player:Player):Boolean {
                return player.scyllaScore() >= 10;
            }, "Scylla race");*/
            TrachealSystemEvolved.requireLevel(6).requirePerk(TrachealSystem).requireCustomFunction(function (player:Player):Boolean {
                return player.beeScore() >= 8 || player.mantisScore() >= 8 || player.scorpionScore() >= 8 || player.spiderScore() >= 8;
            }, "Any insect race");
            TwinHeartEvolved.requireLevel(6)
				.requirePerk(TwinHeart)
				.requireCustomFunction(function (player:Player):Boolean {
                return player.centaurScore() >= 8;
            }, "Centaur race");
			ChimericalBodyInitialStage.requireLevel(6)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.internalChimeraScore() >= 2;
                    }, "Two racial perks");
            //Speedy Recovery - Regain Fatigue 50% faster.
            SpeedyRecovery.requireLevel(6);
            ResistanceI.requireLevel(6);
            Heroism.requireLevel(6);
            DualWield.requireLevel(6);
            Diehard.requireLevel(6);
            Survivalist.requireLevel(6)
                    .requireHungerEnabled();
            ResistanceII.requirePerk(ResistanceI)
                    .requireLevel(8)
                    .requireNGPlus(1);
            ResistanceIII.requirePerk(ResistanceII)
                    .requireLevel(10)
                    .requireNGPlus(2);
            JobGolemancer.requireAdvancedJobSlot()
					.requirePerk(JobLeader)
                    .requireLevel(6)
                    .requireInt(25)
                    .requireWis(25);
            ArcanePoolI.requireLevel(6)
                    .requireInt(30)
                    .requireWis(30)
                    .requireAnyPerk(JobElementalConjurer, JobGolemancer);
            ArcanePoolII.requireLevel(8)
                    .requireInt(40)
                    .requireWis(40)
                    .requirePerk(ArcanePoolI)
                    .requireNGPlus(1);
            ArcanePoolIII.requireLevel(10)
                    .requireInt(50)
                    .requireWis(50)
                    .requirePerk(ArcanePoolII)
                    .requireNGPlus(2);
            BeginnerGolemMaker.requireLevel(6)
                    .requireInt(30)
                    .requireWis(30)
                    .requirePerk(JobGolemancer);
            BiggerGolemBag1.requireLevel(6)
                    .requireInt(40)
                    .requireWis(40)
                    .requirePerk(JobGolemancer);
            BiggerGolemBag2.requireLevel(8)
                    .requireInt(60)
                    .requireWis(60)
                    .requirePerk(BiggerGolemBag1)
                    .requireNGPlus(1);
            BiggerGolemBag3.requireLevel(10)
                    .requireInt(80)
                    .requireWis(80)
                    .requirePerk(BiggerGolemBag2)
                    .requireNGPlus(2);
            ImprovingNaturesBlueprintsNaturalWeapons.requirePerk(JobBeastWarrior)
                    .requireStr(35)
                    .requireTou(35)
                    .requireSpe(35)
                    .requireLevel(6);
            PrimalFuryIV.requirePerk(PrimalFuryIII)
                    .requireNGPlus(3);
            PrimalFuryV.requirePerk(PrimalFuryIV)
                    .requireLevel(8)
                    .requireNGPlus(4);
            PrimalFuryVI.requirePerk(PrimalFuryV)
                    .requireLevel(10)
                    .requireNGPlus(5);
            FeralArmor.requirePerk(ToughHide)
					.requireLevel(6)
					.requireTou(60);
            ClawTraining.requirePerk(JobBeastWarrior)
					.requireLevel(6)
					.requireCustomFunction(function (player:Player):Boolean {
					return player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon();
					}, "Any claws");
            JobHealer.requireAdvancedJobSlot()
					.requireAnyPerk(JobSorcerer, JobSoulCultivator)
					.requireLevel(6)
                    .requireInt(30)
                    .requireWis(30);
            SpellpowerHealing.requireLevel(6)
                    .requirePerk(JobHealer)
                    .requireWis(50);
            WisenedHealer.requireLevel(6)
                    .requirePerk(JobHealer)
                    .requireWis(50);
			DeathPlunge.requireLevel(6)
                    .requirePerk(AerialCombat);
			SpiritedDive.requireLevel(6)
                    .requirePerk(AerialCombat);
			Spectre.requireLevel(6)
                    .requirePerk(Evade)
                    .requirePerk(Runner)
                    .requirePerk(Incorporeality);
			IronStomachEx.requireLevel(6)
                    .requirePerk(IronStomach);
            WispLieutenant.requireLevel(6)
                    .requirePerk(JobLeader)
					.requireInt(50)
					.requireWis(50)
					.requireCustomFunction(function (player:Player):Boolean {
					return (player.statusEffectv1(StatusEffects.SummonedElementals) + player.flags[kFLAGS.PERNAMENT_GOLEMS_BAG]) >= 3;
					}, "3+ pets/minions");
            ShootTheLoadAndHitTheRoad.requireLevel(6)
                    .requirePerk(JobLeader)
					.requireInt(60)
					.requireWis(60);
			Enhancement.requireLevel(6)
					.requireAnyPerk(HistoryAlchemist, PastLifeAlchemist);
			Wizened.requireLevel(6)
					.requireAnyPerk(HistoryCultivator, PastLifeCultivator);
			BonesOfSteel.requireLevel(6)
					.requireAnyPerk(HistoryFighter, PastLifeFighter);
			Lucky.requireLevel(6)
					.requireAnyPerk(HistoryFortune, PastLifeFortune);
			Nurse.requireLevel(6)
					.requireAnyPerk(HistoryHealer, PastLifeHealer);
			PewWarmer.requireLevel(6)
					.requireAnyPerk(HistoryReligious, PastLifeReligious);
			Studious.requireLevel(6)
					.requireAnyPerk(HistoryScholar, PastLifeScholar);
			SoldiersFriend.requireLevel(6)
					.requireAnyPerk(HistoryScout, PastLifeScout);
			Whistles.requireLevel(6)
					.requireAnyPerk(HistorySlacker, PastLifeSlacker);
			//??Slut??
			Tongs.requireLevel(6)
					.requireAnyPerk(HistorySmith, PastLifeSmith);
			Amateur.requireLevel(6)
					.requireAnyPerk(HistoryWhore, PastLifeWhore);
            //Tier 2
            DraconicLungsEvolved.requireLevel(12)
                    .requirePerk(DraconicLungs)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.dragonScore() >= 10;
                    }, "Dragon race");
            ElvishPeripheralNervSysEvolved.requireLevel(12).requirePerk(ElvishPeripheralNervSys).requireCustomFunction(function (player:Player):Boolean {
                return player.elfScore() >= 8;
            }, "Elf race");
			HollowFangsEvolved.requireLevel(12).requirePerk(HollowFangs)
				.requireCustomFunction(function (player:Player):Boolean {
                return player.vampireScore() >= 8;//potem dodać mosquito race i ew. inne co mogą wypijać krew
            }, "Vampire race");
            KitsuneThyroidGlandEvolved.requireLevel(12)
                    .requirePerk(KitsuneThyroidGland)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.kitsuneScore() >= 8;
                    }, "Kitsune race");
            LizanMarrowEvolved.requireLevel(12).requirePerk(LizanMarrow).requireCustomFunction(function (player:Player):Boolean {
                return player.lizardScore() >= 8
            }, "Lizan race");
            MantislikeAgilityEvolved.requireLevel(12).requirePerk(MantislikeAgility).requireCustomFunction(function (player:Player):Boolean {
                return player.mantisScore() >= 10
            }, "Mantis race");
            NaturalPunchingBagEvolved.requireLevel(12).requirePerk(NaturalPunchingBag).requireCustomFunction(function (player:Player):Boolean {
                return player.goblinScore() >= 8
            }, "Goblin race");
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
                return player.salamanderScore() >= 7;
            }, "Salamander race");
			VampiricBloodsteamEvolved.requireLevel(12).requirePerk(VampiricBloodsteam).requireCustomFunction(function (player:Player):Boolean {
                return player.hasStatusEffect(StatusEffects.VampireThirst);
				}, "Vampire Thirst")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.vampireScore() >= 8;//potem dodać mosquito race i ew. inne co mogą wypijać krew
            }, "Vampire race");
			VenomGlandsEvolved.requireLevel(12).requirePerk(VenomGlands).requireCustomFunction(function (player:Player):Boolean {
                return player.spiderScore() >= 8 || player.nagaScore() >= 8 || player.gorgonScore() >= 8 || player.vouivreScore() >= 8 || player.couatlScore() >= 8 || player.hydraScore() >= 8;
            }, "Spider or any snake-like race");
            ChimericalBodySemiBasicStage.requirePerk(ChimericalBodyInitialStage)
                    .requireLevel(12)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.internalChimeraScore() >= 4;
                    }, "Four racial perks");
            Survivalist2.requireLevel(12)
                    .requireHungerEnabled()
                    .requirePerk(Survivalist);
            ResistanceIV.requireLevel(12)
                    .requirePerk(ResistanceIII)
                    .requireNGPlus(3);
            ResistanceV.requirePerk(ResistanceIV)
                    .requireLevel(14)
                    .requireNGPlus(4);
            ResistanceVI.requirePerk(ResistanceV)
                    .requireLevel(16)
                    .requireNGPlus(5);
            Whirlwind.requireLevel(12)
                    .requirePerk(JobSwordsman);
            Whipping.requireLevel(12)
                    .requirePerk(JobEromancer);
            WhirlwindFeral.requireLevel(12)
                    .requirePerk(JobBeastWarrior);
            ArcanePoolIV.requireLevel(12)
                    .requireInt(60)
                    .requireWis(60)
                    .requirePerk(ArcanePoolIII)
                    .requireNGPlus(3);
            ArcanePoolV.requireLevel(14)
                    .requireInt(70)
                    .requireWis(70)
                    .requirePerk(ArcanePoolIV)
                    .requireNGPlus(4);
            ArcanePoolVI.requireLevel(16)
                    .requireInt(80)
                    .requireWis(80)
                    .requirePerk(ArcanePoolV)
                    .requireNGPlus(5);
            ApprenticeGolemMaker.requireLevel(12)
                    .requireInt(50)
                    .requireWis(50)
                    .requirePerk(BeginnerGolemMaker);
            BiggerGolemBag4.requireLevel(12)
                    .requireInt(100)
                    .requireWis(100)
                    .requirePerk(BiggerGolemBag3)
                    .requireNGPlus(3);
            BiggerGolemBag5.requireLevel(14)
                    .requireInt(120)
                    .requireWis(120)
                    .requirePerk(BiggerGolemBag4)
                    .requireNGPlus(4);
            BiggerGolemBag6.requireLevel(14)
                    .requireInt(140)
                    .requireWis(140)
                    .requirePerk(BiggerGolemBag5)
                    .requireNGPlus(5);
            ChargedCore.requireLevel(12)
                    .requireInt(70)
                    .requireWis(70)
                    .requirePerk(ApprenticeGolemMaker);
            ImprovedCrinosShape.requirePerk(ImprovingNaturesBlueprintsNaturalWeapons)
                    .requireStr(50)
                    .requireTou(50)
                    .requireSpe(50)
                    .requireLevel(12);
            ExtraClawAttack.requireLevel(12)
                    .requirePerk(ClawTraining)
					.requireCustomFunction(function (player:Player):Boolean {
					return player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon();
					}, "Any claws");
            NaturalHealingMinor.requireLevel(12)
                    .requirePerk(WisenedHealer)
                    .requireInt(15)
                    .requireWis(60);
            CloseToDeath.requireLevel(12)
                    .requirePerk(JobHealer)
                    .requireInt(50)
                    .requireWis(50);
			AdvancedAerialCombat.requireLevel(12)
					.requirePerk(AerialCombat)
					.requireStr(35)
					.requireSpe(35);
			Aerobatics.requireLevel(12)
					.requirePerk(AerialCombat)
					.requireStr(30)
					.requireSpe(40);
            //Tier 3
            HinezumiBurningBloodFinalForm.requireLevel(18)
				.requirePerk(HinezumiBurningBloodEvolved)
				.requireCustomFunction(function (player:Player):Boolean {
                return player.arms.type == 34;
				}, "Hinezumi arms")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.lowerBody == 49;
				}, "Hinezumi legs")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.tailType == 43;
				}, "Hinezumi tail")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.mouseScore() >= 12;
            }, "Mouse race");
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
            ChimericalBodyBasicStage.requirePerk(ChimericalBodySemiBasicStage)
                    .requireLevel(18)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.internalChimeraScore() >= 8;
                    }, "Eight racial perks");
            JobWarlord.requireAdvancedJobSlot()
					.requireAnyPerk(Whirlwind, Whipping, WhirlwindFeral)
                    .requireLevel(18);
            PowerSweep.requireLevel(18)
                    .requireStr(60)
                    .requireTou(60)
                    .requirePerk(Whirlwind)
                    .requirePerk(JobWarlord);
            CycloneStage1.requireLevel(18)
                    .requireStr(50)
                    .requireTou(50)
                    .requirePerk(JobWarlord);
            ExpertGolemMaker.requireLevel(18)
                    .requireInt(70)
                    .requireWis(70)
                    .requirePerk(ApprenticeGolemMaker);
            SuperChargedCore.requireLevel(18)
                    .requireInt(90)
                    .requireWis(90)
                    .requirePerk(ExpertGolemMaker)
                    .requirePerk(ChargedCore);
            MakeItDouble.requireLevel(18)
                    .requireStr(50)
                    .requireTou(50)
                    .requirePerk(JobWarlord);
            ImprovingNaturesBlueprintsNaturalArmor.requirePerk(ImprovedCrinosShape)
                    .requireStr(65)
                    .requireTou(65)
                    .requireSpe(65)
                    .requireLevel(18);
            SpeedyRecuperation.requirePerk(SpeedyRecovery)
							  .requireLevel(18);
            RecuperationSleep.requirePerk(SpeedyRecovery)
							 .requireLevel(18);
            NaturalHealingMajor.requireLevel(18)
                    .requirePerk(NaturalHealingMinor)
                    .requireInt(20)
                    .requireWis(80);
            MultiClawAttack.requireLevel(18)
                    .requirePerk(ExtraClawAttack)
					.requireCustomFunction(function (player:Player):Boolean {
					return player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon();
					}, "Any claws");
			SpinAttack.requireLevel(18)
					.requirePerk(Aerobatics)
					.requireStr(60)
					.requireSpe(60);
            ImprovedDiehard.requireLevel(18)
                    .requirePerk(Diehard);
            MotivationEx.requireLevel(18)
                    .requirePerk(Motivation);//.requirePerk(IntermediateLeadership)
            //Tier 4
            BlackHeartFinalForm.requireLevel(24)
				.requirePerk(BlackHeartEvolved)
				.requireCor(100)
				.requireCustomFunction(function (player:Player):Boolean {
                return player.demonScore() >= 14;
            }, "Demon race");
            FrozenHeartFinalForm.requireLevel(24)
				.requirePerk(FrozenHeartEvolved)
				.requireCustomFunction(function (player:Player):Boolean {
                return player.yukiOnnaScore() >= 14;
            }, "Yuki onna race");
            ObsidianHeartFinalForm.requireLevel(24)
				.requirePerk(ObsidianHeartEvolved)
				.requireCor(100)
				.requireCustomFunction(function (player:Player):Boolean {
                return player.devilkinScore() >= 14;
            }, "Devil race");
            TrachealSystemFinalForm.requireLevel(24).requirePerk(TrachealSystemEvolved).requireCustomFunction(function (player:Player):Boolean {
                return player.beeScore() >= 12 || player.mantisScore() >= 12 || player.scorpionScore() >= 12 || player.spiderScore() >= 12;
            }, "Any insect race");
            TwinHeartFinalForm.requireLevel(24)
				.requirePerk(TwinHeartEvolved)
				.requireCustomFunction(function (player:Player):Boolean {
                return player.centaurScore() >= 12;
            }, "Centaur race");
			VenomGlandsFinalForm.requireLevel(24).requirePerk(VenomGlandsEvolved).requireCustomFunction(function (player:Player):Boolean {
                return player.spiderScore() >= 12 || player.nagaScore() >= 12 || player.gorgonScore() >= 12 || player.vouivreScore() >= 12 || player.couatlScore() >= 12 || player.hydraScore() >= 12;
            }, "Spider or any snake-like race");
			ChimericalBodySemiAdvancedStage.requirePerk(ChimericalBodyBasicStage)
                    .requireLevel(24)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.internalChimeraScore() >= 12;
                    }, "Twelve racial perks");
            JobAllRounder.requireLevel(24)
                    .requirePerk(JobBeastWarrior)
                    .requirePerk(JobGuardian)
                    .requirePerk(JobLeader)
                    .requirePerk(JobRanger)
                    .requirePerk(JobSeducer)
                    .requirePerk(JobSorcerer)
                    .requirePerk(JobSoulCultivator)
                    .requirePerk(JobWarrior)
                    .requireStr(75)
                    .requireTou(75)
                    .requireSpe(75)
                    .requireInt(75)
                    .requireWis(75)
                    .requireLib(45)
                    .requireSen(45);
            Tornado.requireLevel(24)
                    .requireStr(75)
                    .requireTou(75)
                    .requirePerk(JobWarlord);
            CycloneStage2.requireLevel(24)
                    .requireStr(70)
                    .requireTou(70)
                    .requirePerk(CycloneStage1);
            MasterGolemMaker.requireLevel(24)
                    .requireInt(100)
                    .requireWis(100)
                    .requirePerk(ExpertGolemMaker);
            GiantsReach.requireLevel(24)
                    .requireStr(100)
                    .requireTou(100)
                    .requirePerk(JobWarlord);
            EnableCriticals.requireLevel(24);
            GreaterCrinosShape.requirePerk(ImprovingNaturesBlueprintsNaturalArmor)
                    .requireStr(80)
                    .requireTou(80)
                    .requireSpe(80)
                    .requireLevel(24);
            FirstAttackGolems.requireLevel(24)
                    .requirePerk(MasterGolemMaker);
            //.requireLevel(24)
            //				 .requirePerk(MasterGolemMaker);
            NaturalHealingEpic.requireLevel(24)
                    .requirePerk(NaturalHealingMajor)
                    .requireInt(25)
                    .requireWis(100);
            ClawingFlurry.requireLevel(24)
                    .requirePerk(MultiClawAttack)
					.requireCustomFunction(function (player:Player):Boolean {
					return player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon();
					}, "Any claws");
            CheatDeath.requireLevel(24)
                    .requirePerk(CloseToDeath)
                    .requireInt(100)
                    .requireWis(100);
			GreaterAerialCombat.requireLevel(24)
					.requirePerk(AdvancedAerialCombat)
					.requireStr(50)
					.requireSpe(50);
			IronStomachSu.requireLevel(24)
                    .requirePerk(IronStomachEx);
            WispCaptain.requireLevel(24)
                    .requirePerk(WispLieutenant)
					.requireInt(100)
					.requireWis(100)
					.requireCustomFunction(function (player:Player):Boolean {
					return (player.statusEffectv1(StatusEffects.SummonedElementals) + player.flags[kFLAGS.PERNAMENT_GOLEMS_BAG]) >= 6;
					}, "6+ pets/minions");
			Fusion.requireLevel(24)
					.requirePerk(Enhancement);
			PathOfEnlightenment.requireLevel(24)
					.requirePerk(Wizened);
			MusclesOfSteel.requireLevel(24)
					.requirePerk(BonesOfSteel);
			ExtremelyLucky.requireLevel(24)
					.requirePerk(Lucky);
			Doctor.requireLevel(24)
					.requirePerk(Nurse);
			Acolyte.requireLevel(24)
					.requirePerk(PewWarmer);
			Teacher.requireLevel(24)
					.requirePerk(Studious);
			PyrosFriend.requireLevel(24)
					.requirePerk(SoldiersFriend);
			LyingDown.requireLevel(24)
					.requirePerk(Whistles);
			//??Slut??
			Bellows.requireLevel(24)
					.requirePerk(Tongs);
			Prostitute.requireLevel(24)
					.requirePerk(Amateur);
            BasicAllRounderEducation.requireLevel(24)
                    .requirePerk(JobAllRounder);
            //Tier 5
            DraconicLungsFinalForm.requireLevel(30)
                    .requirePerk(DraconicLungsEvolved)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.dragonScore() >= 16;
                    }, "Dragon race");
            ElvishPeripheralNervSysFinalForm.requireLevel(30).requirePerk(ElvishPeripheralNervSysEvolved).requireCustomFunction(function (player:Player):Boolean {
                return player.elfScore() >= 12;
            }, "Elf race");
			HollowFangsFinalForm.requireLevel(30).requirePerk(HollowFangsEvolved)
				.requireCustomFunction(function (player:Player):Boolean {
                return player.vampireScore() >= 12;//potem dodać mosquito race i ew. inne co mogą wypijać krew
            }, "Vampire race");
            KitsuneThyroidGlandFinalForm.requireLevel(30)
                    .requirePerk(KitsuneThyroidGlandEvolved)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.kitsuneScore() >= 12;
                    }, "Kitsune race");
            NaturalPunchingBagFinalForm.requireLevel(30).requirePerk(NaturalPunchingBagEvolved).requireCustomFunction(function (player:Player):Boolean {
                return player.goblinScore() >= 12
            }, "Goblin race");
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
                return player.salamanderScore() >= 10;
            }, "Salamander race");
			VampiricBloodsteamFinalForm.requireLevel(30).requirePerk(VampiricBloodsteamEvolved).requireCustomFunction(function (player:Player):Boolean {
                return player.hasStatusEffect(StatusEffects.VampireThirst);
				}, "Vampire Thirst")
				.requireCustomFunction(function (player:Player):Boolean {
                return player.vampireScore() >= 12;//potem dodać mosquito race i ew. inne co mogą wypijać krew
            }, "Vampire race");
            ChimericalBodyAdvancedStage.requirePerk(ChimericalBodySemiAdvancedStage)
                    .requireLevel(30)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.internalChimeraScore() >= 18;
                    }, "Eighteen racial perks");
            /*	DeityJobMunchkin.requirePerk(JobWarlord)
                                .requirePerk(JobMonk)
                                .requirePerk(JobKnight)
                                .requirePerk(JobGolemancer)
                                .requirePerk(JobHunter)
                                .requirePerk(JobEromancer)
                                .requirePerk(JobEnchanter)
                                .requirePerk(JobElementalConjurer)
                                .requirePerk(JobCourtesan)
                                .requirePerk(JobDervish)
                                .requirePerk(JobDefender)
                                .requirePerk(JobBrawler)
                                .requirePerk(JobBeastWarrior)
                                .requirePerk(JobSwordsman)
                                .requirePerk(JobAllRounder)
                                .requireStr(150)
                                .requireTou(150)
                                .requireSpe(150)
                                .requireInt(150)
                                .requireWis(150)
                                .requireLib(90)
                                .requireSen(90)
                                .requireLevel(30); //requirePerk(JobEromancer)
			*/	//(Still need some other related stuff added to make PC true Munchkin
            //na razie jest perk GreyMage, potrzeba jeszcze pare innych perków tak z 3-5 innych jeszcze)
            CycloneStage3.requireLevel(30)
                    .requireStr(90)
                    .requireTou(90)
                    .requirePerk(CycloneStage2);
            ImprovingNaturesBlueprintsApexPredator.requirePerk(GreaterCrinosShape)
                    .requireStr(95)
                    .requireTou(95)
                    .requireSpe(95)
                    .requireLevel(30);
            GolemArmyLieutenant.requireLevel(30)
                    .requireInt(110)
                    .requireWis(110)
                    .requirePerk(MasterGolemMaker);
            SpeedyRejuvenation.requirePerk(SpeedyRecuperation)
							  .requireLevel(30);
            RejuvenationSleep.requirePerk(RecuperationSleep)
							 .requireLevel(30);
            NaturalHealingLegendary.requireLevel(30)
                    .requirePerk(NaturalHealingEpic)
                    .requireInt(30)
                    .requireWis(120);
			AdvancedAerobatics.requireLevel(30)
					.requirePerk(Aerobatics)
					.requireStr(90)
					.requireSpe(120);
            GreaterDiehard.requireLevel(30)
                    .requirePerk(ImprovedDiehard);
            IntermediateAllRounderEducation.requireLevel(30)
                    .requirePerk(BasicAllRounderEducation);
			SecondRing.requireLevel(30);
            //Tier 6
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
            ChimericalBodySemiSuperiorStage.requirePerk(ChimericalBodyAdvancedStage)
                    .requireLevel(36)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.internalChimeraScore() >= 24;
                    }, "Twenty four racial perks");
            CycloneStage4.requireLevel(36)
                    .requireStr(120)
                    .requireTou(120)
                    .requirePerk(CycloneStage3);
            MasterCrinosShape.requirePerk(ImprovingNaturesBlueprintsApexPredator)
                    .requireStr(110)
                    .requireTou(110)
                    .requireSpe(110)
                    .requireLevel(36);
            GrandMasterGolemMaker.requireLevel(36)
                    .requireInt(125)
                    .requireWis(125)
                    .requirePerk(MasterGolemMaker);
            TemporalGolemsRestructuration.requireLevel(36)
                    .requireInt(120)
                    .requireWis(120)
                    .requirePerk(MasterGolemMaker);
            AdvancedAllRounderEducation.requireLevel(36)
                    .requirePerk(IntermediateAllRounderEducation);
            //Tier 7
            ChimericalBodySuperiorStage.requirePerk(ChimericalBodySemiSuperiorStage)
                    .requireLevel(42)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.internalChimeraScore() >= 32;
                    }, "Thirty two racial perks");
            CycloneStage5.requireLevel(42)
                    .requireStr(160)
                    .requireTou(160)
                    .requirePerk(CycloneStage4);
            GolemArmyCaptain.requireLevel(42)
                    .requireInt(135)
                    .requireWis(135)
                    .requirePerk(GolemArmyLieutenant)
                    .requirePerk(GrandMasterGolemMaker);
            //AdvancedGolemancyTheory.requireLevel(42)
            //        .requireInt(140)
            //        .requireWis(140)
            //        .requirePerk(GrandMasterGolemMaker);
            EpicDiehard.requireLevel(42)
                    .requirePerk(EpicToughness)
                    .requirePerk(GreaterDiehard);
            WispMajor.requireLevel(42)
                    .requirePerk(WispCaptain)
					.requireInt(150)
					.requireWis(150)
					.requireCustomFunction(function (player:Player):Boolean {
					return (player.statusEffectv1(StatusEffects.SummonedElementals) + player.flags[kFLAGS.PERNAMENT_GOLEMS_BAG]) >= 10;
					}, "10+ pets/minions");
            MotivationSu.requireLevel(36)
                    .requirePerk(MotivationEx);//.requirePerk(AdvancedLeadership)
			Enchantment.requireLevel(42)
					.requirePerk(Fusion);
			Embodiment.requireLevel(42)
					.requirePerk(PathOfEnlightenment);
			HeartOfSteel.requireLevel(42)
					.requirePerk(MusclesOfSteel);
			MoneyFinder.requireLevel(42)
					.requirePerk(ExtremelyLucky);
			FirstResponse.requireLevel(42)
					.requirePerk(Doctor);
			Priest.requireLevel(42)
					.requirePerk(Acolyte);
			Professor.requireLevel(42)
					.requirePerk(Teacher);
			HeavysFriend.requireLevel(42)
					.requirePerk(PyrosFriend);
			TakingABreak.requireLevel(42)
					.requirePerk(LyingDown);
			//??Slut??
			Furnace.requireLevel(42)
					.requirePerk(Bellows);
			Escort.requireLevel(42)
					.requirePerk(Prostitute);
			LimitBreakerBody1stStage.requireLevel(42);
            ExpertAllRounderEducation.requireLevel(42)
                    .requirePerk(AdvancedAllRounderEducation);
            //Tier 8
            ChimericalBodySemiPeerlessStage.requirePerk(ChimericalBodySuperiorStage)
                    .requireLevel(48)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.internalChimeraScore() >= 40;
                    }, "Forty racial perks");
            EpicGolemMaker.requireLevel(48)
                    .requireInt(150)
                    .requireWis(150)
                    .requirePerk(GrandMasterGolemMaker);
			LimitBreakerHeart1stStage.requireLevel(48)
					.requirePerk(LimitBreakerBody1stStage);
            MasterAllRounderEducation.requireLevel(48)
                    .requirePerk(ExpertAllRounderEducation);
            //Tier 9
            ChimericalBodyPeerlessStage.requirePerk(ChimericalBodySemiPeerlessStage)
                    .requireLevel(54)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.internalChimeraScore() >= 50;
                    }, "Fifty racial perks");
            GolemArmyMajor.requireLevel(54)
                    .requireInt(160)
                    .requireWis(160)
                    .requirePerk(GolemArmyCaptain)
                    .requirePerk(EpicGolemMaker);
			LimitBreakerFlesh1stStage.requireLevel(54)
					.requirePerk(LimitBreakerHeart1stStage);
            //Tier 10
            ChimericalBodySemiEpicStage.requirePerk(ChimericalBodyPeerlessStage)
                     .requireLevel(60)
                     .requireCustomFunction(function (player:Player):Boolean {
                         return player.internalChimeraScore() >= 61;
                     }, "Sixty one racial perks");
            EpicGolemMaker2ndCircle.requireLevel(60)
                    .requireInt(175)
                    .requireWis(175)
                    .requirePerk(EpicGolemMaker);
			LimitBreakerPsyche1stStage.requireLevel(60)
					.requirePerk(LimitBreakerFlesh1stStage);
			ThirdRing.requireLevel(60)
                    .requirePerk(SecondRing);
            //Tier 11
            //ChimericalBodyEpicStage.requirePerk(ChimericalBodySemiEpicStage)
            //        .requireLevel(66)
            //        .requireCustomFunction(function (player:Player):Boolean {
            //            return player.internalChimeraScore() >= 72;
            //        }, "Seventy two racial perks");
            GolemArmyColonel.requireLevel(66)
                    .requireInt(185)
                    .requireWis(185)
                    .requirePerk(GolemArmyMajor)
                    .requirePerk(EpicGolemMaker2ndCircle);
			LimitBreakerSoul1stStage.requireLevel(66)
					.requirePerk(LimitBreakerPsyche1stStage);
            //Tier 12
            EpicGolemMaker3rdCircle.requireLevel(72)
                    .requireInt(200)
                    .requireWis(200)
                    .requirePerk(EpicGolemMaker2ndCircle);
            WispColonel.requireLevel(72)
                    .requirePerk(WispMajor)
					.requireInt(200)
					.requireWis(200)
					.requireCustomFunction(function (player:Player):Boolean {
					return (player.statusEffectv1(StatusEffects.SummonedElementals) + player.flags[kFLAGS.PERNAMENT_GOLEMS_BAG]) >= 15;
					}, "15+ pets/minions");
			Refinement.requireLevel(72)
					.requirePerk(Enchantment);
			InControl.requireLevel(72)
					.requirePerk(Embodiment);
			BodyOfSteel.requireLevel(72)
					.requirePerk(HeartOfSteel);
			Collector.requireLevel(72)
					.requirePerk(MoneyFinder);
			Paramedic.requireLevel(72)
					.requirePerk(FirstResponse);
			Pastor.requireLevel(72)
					.requirePerk(Priest);
			Principle.requireLevel(72)
					.requirePerk(Professor);
			EngineersFriend.requireLevel(72)
					.requirePerk(HeavysFriend);
			SkippingWork.requireLevel(72)
					.requirePerk(TakingABreak);
			//??Slut??
			Hammer.requireLevel(72)
					.requirePerk(Furnace);
			BrothelOwner.requireLevel(72)
					.requirePerk(Escort);
			LimitBreakerBody2ndStage.requireLevel(72)
					.requirePerk(LimitBreakerSoul1stStage);
            //Tier 13
            GolemArmyGeneral.requireLevel(78)
                    .requireInt(210)
                    .requireWis(210)
                    .requirePerk(GolemArmyColonel)
                    .requirePerk(EpicGolemMaker3rdCircle);
			LimitBreakerHeart2ndStage.requireLevel(78)
					.requirePerk(LimitBreakerBody2ndStage);
            //Tier 14
			LimitBreakerFlesh2ndStage.requireLevel(84)
					.requirePerk(LimitBreakerHeart2ndStage);
            //Tier 15
			LimitBreakerPsyche2ndStage.requireLevel(90)
					.requirePerk(LimitBreakerFlesh2ndStage);
			FourthRing.requireLevel(90)
                    .requirePerk(ThirdRing);
            //Tier 16
			LimitBreakerSoul2ndStage.requireLevel(96)
					.requirePerk(LimitBreakerPsyche2ndStage);
            //Tier 17
			Saturation.requireLevel(102)
					.requirePerk(Refinement);
			Metamorphable.requireLevel(102)
					.requirePerk(InControl);
			MindOfSteel.requireLevel(102)
					.requirePerk(BodyOfSteel);
			Hoarder.requireLevel(102)
					.requirePerk(Collector);
			SurgeonsAide.requireLevel(102)
					.requirePerk(Paramedic);
			Saint.requireLevel(102)
					.requirePerk(Pastor);
			Dean.requireLevel(102)
					.requirePerk(Principle);
			SnipersFriend.requireLevel(102)
					.requirePerk(EngineersFriend);
			Napping.requireLevel(102)
					.requirePerk(SkippingWork);
			//??Slut??
			Anvil.requireLevel(102)
					.requirePerk(Hammer);
			Pornstar.requireLevel(102)
					.requirePerk(BrothelOwner);
            //Tier 18
			
            //Tier 19
			
            //Tier 20
			
            //Tier 21
			
            //Tier 22
			
            //Tier 23
			
            //Tier 24
			
            //Tier 25
			
            //Tier 26
			
            //Tier 27
			
            //Tier 28
			
            //Tier 29
			
            //Tier 30
			Perfection.requireLevel(180)
					.requirePerk(Saturation);
			SoulPowered.requireLevel(180)
					.requirePerk(Metamorphable);
			SoulOfSteel.requireLevel(180)
					.requirePerk(MindOfSteel);
			BlessedByLadyGodiva.requireLevel(180)
					.requirePerk(Hoarder);
			Surgeon.requireLevel(180)
					.requirePerk(SurgeonsAide);
			Cardinal.requireLevel(180)
					.requirePerk(Saint);
			President.requireLevel(180)
					.requirePerk(Dean);
			SpysEnemy.requireLevel(180)
					.requirePerk(SnipersFriend);
			ZZZ.requireLevel(180)
					.requirePerk(Napping);
			//??Slut??
			Weap0n.requireLevel(180)
					.requirePerk(Anvil);
			SexChampion.requireLevel(180)
					.requirePerk(Pornstar);
			// ChimericalBodyUltimateStage.requirePerk(ChimericalBodyInitialStage)
            //        .requireLevel(1)
            //        .requireCustomFunction(function (player:Player):Boolean {
            //            return player.internalChimeraScore() >= 2;
            //        }, "Two racial perks");//TYLKO do szybkich testów rasowych/rasowych perków mutacyjnych
        } catch (e:Error) {
            trace(e.getStackTrace());
        }
	}
	initDependencies();
}
}