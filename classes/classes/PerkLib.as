/**
 * Created by aimozg on 26.01.14.
 */
package classes
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Perks.*;
	import classes.GlobalFlags.*;
	import classes.Creature;

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
		public static const AscensionDesires:AscensionDesiresPerk = new AscensionDesiresPerk();
		public static const AscensionEndurance:AscensionEndurancePerk = new AscensionEndurancePerk();
		public static const AscensionHardiness:AscensionHardinessPerk = new AscensionHardinessPerk();
		public static const AscensionFertility:AscensionFertilityPerk = new AscensionFertilityPerk();
		public static const AscensionFortune:AscensionFortunePerk = new AscensionFortunePerk();
		public static const AscensionMoralShifter:AscensionMoralShifterPerk = new AscensionMoralShifterPerk();
		public static const AscensionMysticality:AscensionMysticalityPerk = new AscensionMysticalityPerk();
		public static const AscensionSoulPurity:AscensionSoulPurityPerk = new AscensionSoulPurityPerk();
		public static const AscensionSpiritualEnlightenment:AscensionSpiritualEnlightenmentPerk = new AscensionSpiritualEnlightenmentPerk();
		public static const AscensionTolerance:AscensionTolerancePerk = new AscensionTolerancePerk();
		public static const AscensionTranshumanism:AscensionTranshumanismPerk = new AscensionTranshumanismPerk();
		public static const AscensionVirility:AscensionVirilityPerk = new AscensionVirilityPerk();
		public static const AscensionWisdom:AscensionWisdomPerk = new AscensionWisdomPerk();
		
		// Ascension Rare perks
		public static const AscensionHerosHeritage:PerkType = mk("Ascension: Hero's Heritage", "Ascension: Hero's Heritage",
				"After reincarnation you ended in body of local hero descendant possesing much more firm body and resolve giving you a slight easier start of your quest in Mareth.");
		public static const AscensionHerosLineage:PerkType = mk("Ascension: Hero's Lineage", "Ascension: Hero's Lineage",
				"Body in which you ends up after next incarnation have much more thicker hero linage than before giving you even better start before venturing into Mareth. You would probably need it.");
		public static const AscensionHybridTheory:PerkType = mk("Ascension: Hybrid Theory", "Ascension: Hybrid Theory",
				"Allows you to reduce by one needed to accumulate mutations into non-human species to attain race specific enhancing effects.");
		public static const AscensionNaturalMetamorph:PerkType = mk("Ascension: Natural Metamorph", "Ascension: Natural Metamorph",
				"When others needs to work hard on unlocking their metamorph potential you never had to do it. Whatever the reason for that is... truth be told you try not to think about it, affraid of what it might mean for you. You do not want to care about it as long as it's nothing harmfull for you in the long run.");
		public static const AscensionUnderdog:PerkType = mk("Ascension: Underdog", "Ascension: Underdog",
				"You're underdog. Gains twice more exp for beating up enemies above your current level with doubled limit after which increase to gained exp stops.");
				// Also allow to use 'accidentally' finding all forgotten or hidden legacies from times before the demon invasion.");
		public static const AscensionUnlockedPotential:PerkType = mk("Ascension: Unlocked Potential", "Ascension: Unlocked Potential",
				"Due to reincarnation experience your body becoming strong faster than in previous life (increased passive hp, fatigue, mana gains at lvl-up).");
		public static const AscensionUnlockedPotential2ndStage:PerkType = mk("Ascension: Unlocked Potential (2nd Stage)", "Ascension: Unlocked Potential (2nd Stage)",
				"Due to reincarnation experience your body becoming strong faster than in previous life (increased passive lust, wrath, soulforce gains at lvl-up).");
	//	public static const Ascension:PerkType = mk("Ascension: ", "Ascension: ",
	//			".");
	//	public static const Ascension:PerkType = mk("Ascension: ", "Ascension: ",
	//			".");
	//	public static const Ascension:PerkType = mk("Ascension: Artifical-made Metamorph", "Ascension: Artifical-made Metamorph",
	//			".");
		
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
				"A Past full of conflict increases physical melee damage dealt by 10%.");
		public static const PastLifeFighter:PerkType = mk("Past Life: Fighter", "Past Life: Fighter",
				"A Past full of conflict increases physical melee damage dealt by 10%.", null, true);
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
				"A Past full of archery training increases physical range damage dealt by 10% and acc by 20%.");
		public static const PastLifeScout:PerkType = mk("Past Life: Scout", "Past Life: Scout",
				"A Past full of archery training increases physical range damage dealt by 10% and acc by 20%.", null, true);
		public static const HistorySlacker:PerkType = mk("History: Slacker", "History: Slacker",
				"Regenerate fatigue 20% faster.");
		public static const PastLifeSlacker:PerkType = mk("Past Life: Slacker", "Past Life: Slacker",
				"Regenerate fatigue 20% faster.", null, true);
		public static const HistorySlut:PerkType = mk("History: Slut", "History: Slut",
				"Sexual experience has made you more able to handle large insertions and more resistant to stretching.");
		public static const PastLifeSlut:PerkType = mk("Past Life: Slut", "Past Life: Slut",
				"Sexual experience has made you more able to handle large insertions and more resistant to stretching.", null, true);
		public static const HistorySmith:PerkType = mk("History: Smith", "History: Smith",
				"Knowledge of armor and fitting increases armor effectiveness by roughly 10%.");
		public static const PastLifeSmith:PerkType = mk("Past Life: Smith", "Past Life: Smith",
				"Knowledge of armor and fitting increases armor effectiveness by roughly 10%.", null, true);
		public static const HistoryWhore:PerkType = mk("History: Whore", "History: Whore",
				"Seductive experience causes your tease attacks to be 15% more effective.");
		public static const PastLifeWhore:PerkType = mk("Past Life: Whore", "Past Life: Whore",
				"Seductive experience causes your tease attacks to be 15% more effective.", null, true);
		
		// Ordinary (levelup) perks
		public static const Acclimation:PerkType = mk("Acclimation", "Acclimation",
				"Reduces lust gain by 15%.",
				"You choose the 'Acclimation' perk, making your body 15% more resistant to lust, up to a maximum of 75%.");
		public static const AdvancedEndurance:PerkType = mk("Advanced Endurance", "Advanced Endurance",
				"Increases maximum fatigue by 200.",
				"You choose the 'Advanced Endurance' perk. Thanks to your advanced physical conditioning, your maximum fatigue has been increased by 200!");	
		public static const AdvancedSelfControl:PerkType = mk("Advanced Self-Control", "Advanced Self-Control",
				"Increases maximum lust by 100.",
				"You choose the 'Advanced Self-Control' perk. Thanks to your advanced mental conditioning, your maximum lust has been increased by 100!");
		public static const AdvancedSpirituality:PerkType = mk("Advanced Spirituality", "Advanced Spirituality",
				"Increases maximum mana by 300.",
				"You choose the 'Advanced Spirituality' perk. Thanks to your advanced mystical conditioning, your maximum mana has been increased by 300!");	
		public static const Agility:PerkType = mk("Agility", "Agility",
				"Boosts armor points by a portion of your speed on light/medium armors.",
				"You choose the 'Agility' perk, increasing the effectiveness of Light/Medium armors by a portion of your speed.");
		public static const Anger:PerkType = mk("Anger", "Anger",
				"For every 1% of missing HP you gain 1% bonus damage.",
				"You choose the 'Anger' perk, increasing damage based on your missing HP.");
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
				"[if (player.inte>=75)" +
						"Increases base spell strength by 30% and base mana pool by 45." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Archmage' perk, increasing base spell strength by 30% and base mana pool by 45.");
		public static const ArcaneLash:PerkType = mk("Arcane Lash", "Arcane Lash",
				"Your whip act as a catalyst for your lust inducing spells as well as for magic weapon.",
				"You choose the 'Arcane Lash' perk, causing you to increase effects of lust inducing spells and weapon when using whip.");
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
		public static const BasicEndurance:PerkType = mk("Basic Endurance", "Basic Endurance",
				"Increases maximum fatigue by 30.",
				"You choose the 'Basic Endurance' perk. Thanks to your basic physical conditioning, your maximum fatigue has been increased by 30!");	
		public static const BasicSelfControl:PerkType = mk("Basic Self-Control", "Basic Self-Control",
				"Increases maximum lust by 15.",
				"You choose the 'Basic Self-Control' perk. Thanks to your basic mental conditioning, your maximum lust has been increased by 15!");
		public static const BasicSpirituality:PerkType = mk("Basic Spirituality", "Basic Spirituality",
				"Increases maximum mana by 45.",
				"You choose the 'Basic Spirituality' perk. Thanks to your basic mystical conditioning, your maximum mana has been increased by 45!");	
		public static const BeginnerGolemMaker:PerkType = mk("Beginner Golem Maker", "Beginner Golem Maker",
				"Your proficiency in making golems allows to lower by 5% chance of core shattering and storing more golems/golem cores.",
				"You choose 'Beginner Golem Maker' perk, increasing your proficiency in making golems.");
		public static const Battleflash:PerkType = mk("Battleflash", "Battleflash",
				"Start every battle with Blink enabled, if you meet Black Magic requirements before it starts.",
				"You choose the 'Battleflash' perk. You start every battle with Blink effect, as long as your Lust is sufficient to cast it before battle.");
		public static const Battlemage:PerkType = mk("Battlemage", "Battlemage",
				"Start every battle with Might enabled, if you meet Black Magic requirements before it starts.",
				"You choose the 'Battlemage' perk. You start every battle with Might effect, as long as your Lust is sufficient to cast it before battle.");
		public static const Berzerker:PerkType = mk("Berzerker", "Berserker",
				"[if(player.str>=75)" +
						"Grants 'Berserk' ability." +
						"|" +
						"<b>You aren't strong enough to benefit from this anymore.</b>" +
						"]",
				"You choose the 'Berserker' perk, which unlocks the 'Berserk' magical ability.  Berserking increases attack and lust resistance but reduces physical defenses.");
		public static const BiggerGolemBag1:PerkType = mk("Bigger Golem Bag 1", "Bigger Golem Bag 1",
				"Your extra dimensional golem bag can store 2 more temporal golems.",
				"You choose 'Bigger Golem Bag 1' perk, increasing your temporal golems bag.");
		public static const BiggerGolemBag2:PerkType = mk("Bigger Golem Bag 2", "Bigger Golem Bag 2",
				"Your extra dimensional golem bag can store 2 more temporal golems.",
				"You choose 'Bigger Golem Bag 2' perk, increasing your temporal golems bag.");
		public static const BiggerGolemBag3:PerkType = mk("Bigger Golem Bag 3", "Bigger Golem Bag 3",
				"Your extra dimensional golem bag can store 2 more temporal golems.",
				"You choose 'Bigger Golem Bag 3' perk, increasing your temporal golems bag.");
		public static const BiggerGolemBag4:PerkType = mk("Bigger Golem Bag 4", "Bigger Golem Bag 4",
				"Your extra dimensional golem bag can store 2 more temporal golems.",
				"You choose 'Bigger Golem Bag 4' perk, increasing your temporal golems bag.");
		public static const BiggerGolemBag5:PerkType = mk("Bigger Golem Bag 5", "Bigger Golem Bag 5",
				"Your extra dimensional golem bag can store 2 more temporal golems.",
				"You choose 'Bigger Golem Bag 5' perk, increasing your temporal golems bag.");
		public static const BiggerGolemBag6:PerkType = mk("Bigger Golem Bag 6", "Bigger Golem Bag 6",
				"Your extra dimensional golem bag can store 2 more temporal golems.",
				"You choose 'Bigger Golem Bag 6' perk, increasing your temporal golems bag.");
		public static const BlackHeart:PerkType = mk("Black Heart", "Black Heart",
				"You intelligence to increase power of lust strike as well making fascinate slightly stronger.",
				"You choose the 'Black Heart' perk. Your heart due to repeadly exposition to corruption turned black.");
		public static const Blademaster:PerkType = mk("Blademaster", "Blademaster",
				"Gain +5% to critical strike chance when wielding a sword and not using a shield.",
				"You choose the 'Blademaster' perk.  Your chance of critical hit is increased by 5% as long as you're wielding a sword and not using a shield.");
		public static const BodyCultivator:PerkType = mk("Body Cultivator", "Body Cultivator",
				"Allow you to train your soul cultivator body to make it as tough as artifacts.",
				"You choose the 'Body Cultivator' perk, starting journey on the body cultivators path!");
		public static const Brawler:PerkType = mk("Brawler", "Brawler",
				"Brawling experience allows you to make two unarmed attacks in a turn.",
				"You choose the 'Brawler' perk, allowing you to make two unarmed attacks in a turn!");
		public static const BrutalBlows:PerkType = mk("Brutal Blows", "Brutal Blows",
				"[if(player.str>=75)" +
						"Reduces enemy armor with each hit." +
						"|" +
						"<b>You aren't strong enough to benefit from this anymore.</b>" +
						"]",
				"You choose the 'Brutal Blows' perk, which reduces enemy armor with each hit.");
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
		public static const Channeling:PerkType = mk("Channeling", "Channeling",
				"[if (player.inte>=60)" +
						"Increases base spell strength by 20% and base mana pool by 30." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Channeling' perk, boosting the strength of your spellcasting and expanding your mana pool!");
		public static const ChargedCore:PerkType = mk("Charged Core", "Charged Core",
				"At the cost of using additional mana you can charge each temporal golem core allowing them to deal minot area of effect damages (it have small synergistic effect when more golems attacks at once).",
				"You choose 'Charged Core' perk, learning how to make golems attacks be slight stronger.");
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
				"You feel naturaly adept at using every new appendage you gain as if they were yours from birth.",
				"You choose the 'Chimerical Body: Advanced Stage' perk. Constant mutations rised your body adaptiveness to new level.");	
		public static const ChimericalBodyBasicStage:PerkType = mk("Chimerical Body: Basic Stage", "Chimerical Body: Basic Stage",
				"Your metabolic adaptation reached level possesed by most simplest and weakest chimeras.",
				"You choose the 'Chimerical Body: Basic Stage' perk. Your body reach adaptation stage for most base type of chimera.");	
		public static const ChimericalBodyInitialStage:PerkType = mk("Chimerical Body: Initial Stage", "Chimerical Body: Initial Stage",
				"Constant mutations resulted in your body developing the most basic resistance to increased stress put on your metabolism by that.",
				"You choose the 'Chimerical Body: Initial Stage' perk. Constant mutations causing your body to forcefully adapt to increased metabolism needs.");	
		public static const ChimericalBodyPerfectStage:PerkType = mk("Chimerical Body: Perfect Stage", "Chimerical Body: Perfect Stage",
				".",
				"You choose the 'Chimerical Body: Perfect Stage' perk.  Coś coś!");	
		public static const ChimericalBodyUltimateStage:PerkType = mk("Chimerical Body: Ultimate Stage", "Chimerical Body: Ultimate Stage",
				".",
				"You choose the 'Chimerical Body: Ultimate Stage' perk.  Coś coś!");	
		public static const ChimericalBodyStage:PerkType = mk("Chimerical Body:  Stage", "Chimerical Body:  Stage",
				"prless lub completed stage.",
				"You choose the 'Chimerical Body:  Stage' perk.  Coś coś!");	
		public static const ColdBlooded:PerkType = mk("Cold Blooded", "Cold Blooded",
				"Reduces minimum lust by up to 20, down to min of 20. Caps min lust at 80.",
				"You choose the 'Cold Blooded' perk.  Thanks to increased control over your desires, your minimum lust is reduced! (Caps minimum lust at 80. Won't reduce minimum lust below 20 though.)");
		public static const ColdAim:PerkType = mk("Cold Aim", "Cold Aim",
				"Careful but Reckless Aim and Shooting does not reduce your max Toughness.",
				"You choose the 'Cold Aim' perk, causing Careful but Reckless Aim and Shooting to not reduce your Toughness.");
		public static const ColdFury:PerkType = mk("Cold Fury", "Cold Fury",
				"Berserking does not reduce your armor.",
				"You choose the 'Cold Fury' perk, causing Berserking to not reduce your armor.");
		public static const ColdLust:PerkType = mk("Cold Lust", "Cold Lust",
				"Lustzerking does not reduce your lust resistance.",
				"You choose the 'Cold Lust' perk, causing Lustzerking to not reduce your lust resistance.");
		public static const Combo:PerkType = mk("Combo", "Combo",
				"Gain an extra attack with fist (weapon).",
				"You choose the 'Combo' perk, gaining an extra attack with fist (weapon).");
		public static const ComboMaster:PerkType = mk("Combo Master", "Combo Master",
				"Gain another extra attack with fist (weapon).",
				"You choose the 'Combo Master' perk, gaining another extra attack with fist (weapon).");
		public static const Convergence:PerkType = mk("Convergence", "Convergence",
				"Grey magic area of effect spells strike twice against single targets.",
				"You choose the 'Convergence' perk, gaining chance to attack single targets twice with grey aoe spells.");
		public static const CorruptedLibido:PerkType = mk("Corrupted Libido", "Corrupted Libido",
				"Reduces lust gain by 10%.",
				"You choose the 'Corrupted Libido' perk.  As a result of your body's corruption, you've become a bit harder to turn on. (Lust gain reduced by 10%!)");
		public static const CriticalPerformance:PerkType = mk("Critical performance", "Critical performance",
				"Allows your non periodic tease damage to critically hit based on your libido, maximum 20%.",
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
		public static const Dantain:PerkType = mk("Dantain", "Dantain",
				"Increase max soulforce by 10% plus 10% to 15% per each attained cultivation stage.",
				"You choose the 'Dantain' perk.  As a result of many cultivation sessions you managed to find dantain in your body, which resulted in increased capacity to store soulforce.");
		public static const DaoistCultivator:PerkType = mk("Daoist Cultivator", "Daoist Cultivator",
				"Allow you to train your soul cultivator mind to unleash soulskills with their apex power.",
				"You choose the 'Daoist Cultivator' perk, starting journey on the daoist cultivators path!");
		public static const DaoistApprenticeStage:PerkType = mk("Daoist: Apprentice Stage", "Daoist: Apprentice Stage",
				"Your reached first stage of Daoist path.",
				"You choose the 'Daoist: Apprentice Stage' perk, progressing on your Daoist path.");
		public static const DaoistElderStage:PerkType = mk("Daoist: Elder Stage", "Daoist: Elder Stage",
				"Your reached third stage of Daoist path.",
				"You choose the 'Daoist: Elder Stage' perk, progressing on your Daoist path.");
		public static const DaoistOverlordStage:PerkType = mk("Daoist: Overlord Stage", "Daoist: Overlord Stage",
				"Your reached fourth stage of Daoist path.",
				"You choose the 'Daoist: Overlord Stage' perk, progressing on your Daoist path.");
		public static const DaoistKingStage:PerkType = mk("Daoist: Tyrant Stage", "Daoist: Tyrant Stage",
				"Your reached fifth stage of Daoist path.",
				"You choose the 'Daoist: Tyrant Stage' perk, progressing on your Daoist path.");
		public static const DaoistWarriorStage:PerkType = mk("Daoist: Warrior Stage", "Daoist: Warrior Stage",
				"Your reached second stage of Daoist path.",
				"You choose the 'Daoist: Warrior Stage' perk, progressing on your Daoist path.");
		public static const DazzlingDisplay:PerkType = mk("Dazzling display", "Dazzling display",
				"Teasing can stun enemy for one round or increase lust damage for grapple-type teases.",
				"You choose 'Dazzling display' perk, allowing to increse tease dmg a little bit or even stun enemy for short moment.");
		public static const DeadlyAim:PerkType = mk("Deadly Aim", "Deadly Aim",
				"Arrows/Bolts ignore damage reductions piercing right through your opponent armor weak points (ignore enemy dmg red).",
				"You choose the 'Deadly Aim' perk, causing arrows/bolts to ignore the damage reductions of opponent.");
		public static const DeadlyThrow:PerkType = mk("Deadly Throw", "Deadly Throw",
				"You learned how to use throwing weapon with better efficiency adding your speed to the damage.",
				"You choose the 'Deadly Throw' perk, adding your speed to throwing weapon damage.");
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
		public static const DoubleAttack:PerkType = mk("Double Attack", "Double Attack",
				"Allows you to perform two melee attacks with non-large weapons per round.",
				"You choose the 'Double Attack' perk.  This allows you to make two melee attacks with non-large weapons.");
		public static const DoubleAttackLarge:PerkType = mk("Double Attack (Large)", "Double Attack (Large)",
				"Allows you to perform two melee attacks with large weapons per round.",
				"You choose the 'Double Attack (Large)' perk.  This allows you to make two melee attacks with large weapons.");
		public static const DoubleStrike:PerkType = mk("Double Strike", "Double Strike",
				"Allows you to perform two range attacks per round.",
				"You choose the 'Double Strike' perk.  This allows you to make two range attacks.");
		public static const DraconicLungs:PerkType = mk("Draconic Lungs", "Draconic Lungs",
				"Draconic Lungs giving you slight increased speed and allows to use breath attack more often.",
				"You choose the 'Draconic Lungs' perk. Your lungs due to repeadly usage of dragon breath attacks turned into draconic lungs.");
		public static const DraconicLungsEvolved:PerkType = mk("Draconic Lungs (Evolved)", "Draconic Lungs (Evolved)",
				"Draconic Lungs giving you slight increased speed/toughness and increased threefold power of the dragon breath attacks.",
				"You choose the 'Draconic Lungs (Evolved)' perk. Continuous exposition to draconic changes caused your lungs evolution into more complete form.");
		public static const DualWield:PerkType = mk("Dual Wield", "Dual Wield",
				"Allows you to wield two weapons (excluding large ones, staffs, with special perks and range ones).",
				"You choose the 'Dual Wield' perk, training skill of using two weapons with a few limitation.");
		public static const DualWieldLarge:PerkType = mk("Dual Wield (Large)", "Dual Wield (Large)",
				"Allows you to wield two weapons of any large type.",
				"You choose the 'Dual Wield (Large)' perk, training skill of using two large weapons.");
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
				"Your intelligence and wisdom is greatly enhanced at the cost of physical body fragility.",
				"You choose 'Elemental Conjurer Dedication' perk, dedicating yourself to pursue path of elemental conjuring at the cost of physical fragility.");
		public static const ElementalConjurerResolve:PerkType = mk("Elemental Conjurer Resolve", "Elemental Conjurer Resolve",
				"Your mental attributes are greatly enhanced at the cost of weakening physical ones.",
				"You choose 'Elemental Conjurer Resolve' perk, showing your resolve to purse mental perfection at the cost of physical weakening.");
		public static const ElementalConjurerSacrifice:PerkType = mk("Elemental Conjurer Sacrifice", "Elemental Conjurer Sacrifice",
				"Your mental attributes are enhanced beyond limits at the cost of similar weakening physical ones.",
				"You choose 'Elemental Conjurer Sacrifice' perk, showing your will to sacrifice everything in reaching beyond mental perfection.");
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
				"As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to elder rank.",
				"You choose 'Elemental Contract Rank 8' perk, rising your ability to command more and stronger elementals.");
		public static const ElementsOfMarethBasics:PerkType = mk("Elements of Mareth: Basics", "Elements of Mareth: Basics",
				"You can now summon and command ice, lightning and darkness elementals. Also increase elementals command limit by 2.",
				"You choose 'Elements of Mareth: Basics' perk, your time spent in Mareth allowed you to get basic understanding of native elemnts that aren't classified as one of four traditional.");
		public static const EnableCriticals:PerkType = mk("Enable Criticals", "Enable Criticals",
				"You now score crits on all naturaly immune to them enemies like constructs, goo or plants.",
				"You choose the 'Enable Criticals' perk, allowing you to get crits on normaly immune to this enemy types.");
		public static const EnvenomedBolt:PerkType = mk("Envenomed Bolt", "Envenomed Bolt",
				"By carefully collecting your venom you can apply poison to your arrows and bolts.",
				"You choose the 'Envenomed Bolt' perk, allowing you to apply your own venom to arrows and bolts.");
		public static const EternalyLastingBuffs:PerkType = mk("(Eternaly) Lasting Buffs", "(Eternaly) Lasting Buffs",
				"Buff spells last another 5 turns longer at another 2x increase of their costs.",
				"You choose the '(Eternaly) Lasting Buffs' perk. Your mastery over buffs reached (eternaly) lasting level.");
		public static const Evade:PerkType = mk("Evade", "Evade",
				"Increases chances of evading enemy attacks.",
				"You choose the 'Evade' perk, allowing you to avoid enemy attacks more often!");
		public static const EverLastingBuffs:PerkType = mk("(Ever)Lasting Buffs", "(Ever)Lasting Buffs",
				"Buff spells last 5 turns longer at the double of normal costs.",
				"You choose the '(Ever)Lasting Buffs' perk. Your mastery over buffs reached (ever)lasting level.");
		public static const ExpertGolemMaker:PerkType = mk("Expert Golem Maker", "Expert Golem Maker",
				"Your proficiency in making golems allows them to attack even flying enemies, lower by 5% chance of core shattering and storing more golems.",
				"You choose 'Expert Golem Maker' perk, increasing your proficiency in making golems.");
		public static const EyesOfTheHunterAdept:PerkType = mk("Eyes of the Hunter (Adept)", "Eyes of the Hunter (Adept)",
				"Allow see another few infomations about enemy (as long it apply to current viewed enemy) (req. 50+ sensitivity).",
				"You choose the 'Eyes of the Hunter (Adept)' perk, allowing you to gain wider than before range of information about enemy you fight.");
		public static const EyesOfTheHunterMaster:PerkType = mk("Eyes of the Hunter (Master)", "Eyes of the Hunter (Master)",
				"Allow see more infomations about enemy (as long it apply to current viewed enemy) (req. 75+ sensitivity).",
				"You choose the 'Eyes of the Hunter (Master)' perk, adding more possible to see information about enemy you fight in compare to Adept stage.");
		public static const EyesOfTheHunterNovice:PerkType = mk("Eyes of the Hunter (Novice)", "Eyes of the Hunter (Novice)",
				"Allow see few more than usual infomations about enemy (req. 25+ sensitivity).",
				"You choose the 'Eyes of the Hunter (Novice)' perk, allowing you to gain more information about enemy you fight.");
		public static const FertilityMinus:PerkType = mk("Fertility-", "Fertility-",
				"Decreases fertility rating by 15 and cum volume by up to 30%. (Req's libido of less than 25.)",
				"You choose the 'Fertility-' perk, making it harder to get pregnant.  It also decreases your cum volume by up to 30% (if appropriate)!");
		public static const FertilityPlus:PerkType = mk("Fertility+", "Fertility+",
				"Increases fertility rating by 15 and cum volume by up to 50%.",
				"You choose the 'Fertility+' perk, making it easier to get pregnant.  It also increases your cum volume by up to 50% (if appropriate)!");
		public static const FleshBodyApprenticeStage:PerkType = mk("Flesh Body: Apprentice Stage", "Flesh Body: Apprentice Stage",
				"Your reached first stage of body cultivating.",
				"You choose the 'Flesh Body: Apprentice Stage' perk, working on cultivating power of your fleshy body.");
		public static const FleshBodyElderStage:PerkType = mk("Flesh Body: Elder Stage", "Flesh Body: Elder Stage",
				"Your reached third stage of body cultivating.",
				"You choose the 'Flesh Body: Elder Stage' perk, working on cultivating power of your fleshy body.");
		public static const FleshBodyOverlordStage:PerkType = mk("Flesh Body: Overlord Stage", "Flesh Body: Overlord Stage",
				"Your reached fourth stage of body cultivating.",
				"You choose the 'Flesh Body: Overlord Stage' perk, working on cultivating power of your fleshy body.");
		public static const FleshBodyKingStage:PerkType = mk("Flesh Body: Tyrant Stage", "Flesh Body: Tyrant Stage",
				"Your reached fifth stage of body cultivating.",
				"You choose the 'Flesh Body: Tyrant Stage' perk, working on cultivating power of your fleshy body.");
		public static const FleshBodyWarriorStage:PerkType = mk("Flesh Body: Warrior Stage", "Flesh Body: Warrior Stage",
				"Your reached second stage of body cultivating.",
				"You choose the 'Flesh Body: Warrior Stage' perk, working on cultivating power of your fleshy body.");
		public static const FocusedMind:PerkType = mk("Focused Mind", "Focused Mind",
				"Black Magic is less likely to backfire and White Magic threshold is increased.",
				"You choose the 'Focused Mind' perk. Black Magic is less likely to backfire and White Magic threshold is increased.");
		public static const FortressOfIntellect:PerkType = mk("Fortress of Intellect", "Fortress of Intellect",
				"Might increases intelligence instead of strength (toggleable).",
				"You choose the 'Fortress of Intellect' perk. You can now change Might to boost intelligence instead of strength.");
		public static const GiantsReach:PerkType = mk("Giant's Reach", "Giant's Reach",
				"When fighting groups of enemies with Large weapons it creates small shockwaves increasing range (and damage) of Aoe attacks.",
				"You choose 'Giant's Reach' perk. Increase range of attacks with large weapons in fights against group enemies.");
		public static const GlacialStorm:PerkType = mk("Glacial Storm", "Glacial Storm",
				"Cumulative 20% damage increase for every subsequent ice spell without interruption.",
				"You choose the 'Glacial Storm' perk. Cumulative 20% damage increase for every subsequent ice spell without interruption.");
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
		public static const GrandArchmage:PerkType = mk("Grand Archmage", "Grand Archmage",
				"[if (player.inte>=100)" +
						"Increases base spell strength by 40% and mana pool by 60." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Grand Archmage' perk, increasing base spell strength by 40% and mana pool by 60.");
		public static const GrandMasterGolemMaker:PerkType = mk("Grand-Master Golem Maker", "Grand-Master Golem Maker",
				"Your proficiency in making golems allows to .",
				"You choose 'Grand-Master Golem Maker' perk, increasing your proficiency in making golems.");
		public static const GreyArchmage:PerkType = mk("Grey Archmage", "Grey Archmage",
				"[if (player.inte>=150)" +
						"Increases base spell strength by 100%, mana pool by 150 and regain it 300% faster." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Grey Archmage' perk, increasing base spell strength by 100%, mana pool by 150 and boosting it recovery by large margin.");
		public static const GreyMage:PerkType = mk("Grey Mage", "Grey Mage",
				"[if (player.inte>=125)" +
						"Increases base spell strength by 70%, mana pool by 105, regain it 100% faster, treshold for Black Magic is 30 lust and for White 30 lust below current max." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Grey Mage' perk. Your base spell mana pool and recover are greatly increased, treshold for White Magic rised and for Black lowered.");
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
		public static const HalfStepToImprovedEndurance:PerkType = mk("Half-step-to Improved Endurance", "Half-step-to Improved Endurance",
				"Increases maximum fatigue by 50.",
				"You choose the 'Half-step-to Improved Endurance' perk. Thanks to your improved physical conditioning, your maximum fatigue has been increased by 50!");
		public static const HalfStepToImprovedSelfControl:PerkType = mk("Half-step-to Improved Self-Control", "Half-step-to Improved Self-Control",
				"Increases maximum lust by 25.",
				"You choose the 'Half-step-to Improved Self-Control' perk. Thanks to your improved mental conditioning, your maximum lust has been increased by 25!");
		public static const HalfStepToImprovedSpirituality:PerkType = mk("Half-step-to Improved Spirituality", "Half-step-to Improved Spirituality",
				"Increases maximum mana by 75.",
				"You choose the 'Half-step-to Improved Spirituality' perk. Thanks to your improved mystical conditioning, your maximum mana has been increased by 75!");
		public static const HalfStepToPeerlessEndurance:PerkType = mk("Half-step-to Peerless Endurance", "Half-step-to Peerless Endurance",
				"Increases maximum fatigue by 700.",
				"You choose the 'Half-step-to Peerless Endurance' perk. Thanks to your peerless physical conditioning, your maximum fatigue has been increased by 700!");
		public static const HalfStepToPeerlessSelfControl:PerkType = mk("Half-step-to Peerless Self-Control", "Half-step-to Peerless Self-Control",
				"Increases maximum lust by 350.",
				"You choose the 'Half-step-to Peerless Self-Control' perk. Thanks to your peerless mental conditioning, your maximum lust has been increased by 350!");
		public static const HalfStepToPeerlessSpirituality:PerkType = mk("Half-step-to Peerless Spirituality", "Half-step-to Peerless Spirituality",
				"Increases maximum mana by 1050.",
				"You choose the 'Half-step-to Peerless Spirituality' perk. Thanks to your peerless mystical conditioning, your maximum mana has been increased by 1050!");
		public static const HalfStepToSuperiorEndurance:PerkType = mk("Half-step-to Superior Endurance", "Half-step-to Superior Endurance",
				"Increases maximum fatigue by 320.",
				"You choose the 'Half-step-to Superior Endurance' perk. Thanks to your superior physical conditioning, your maximum fatigue has been increased by 320!");
		public static const HalfStepToSuperiorSelfControl:PerkType = mk("Half-step-to Superior Self-Control", "Half-step-to Superior Self-Control",
				"Increases maximum lust by 160.",
				"You choose the 'Half-step-to Superior Self-Control' perk. Thanks to your superior mental conditioning, your maximum lust has been increased by 160!");
		public static const HalfStepToSuperiorSpirituality:PerkType = mk("Half-step-to Superior Spirituality", "Half-step-to Superior Spirituality",
				"Increases maximum mana by 480.",
				"You choose the 'Half-step-to Superior Spirituality' perk. Thanks to your superior mystical conditioning, your maximum mana has been increased by 480!");
		public static const Heroism:PerkType = mk("Heroism", "Heroism",
				"Allows you to deal double damage toward boss or gigant sized enemies.",
				"You choose the 'Heroism' perk.  Due to your heroic stance you can now deal more damage toward boss or gigant type enemies.");
		public static const HexaAttack:PerkType = mk("Hexa Attack", "Hexa Attack",
				"Allows you to perform six melee attacks with non-large weapons per round.",
				"You choose the 'Hexa Attack' perk.  This allows you to make six melee attacks with non-large weapons.");
		public static const HoldWithBothHands:PerkType = mk("Hold With Both Hands", "Hold With Both Hands",
				"Gain +20% strength modifier with melee weapons when not using a shield.",
				"You choose the 'Hold With Both Hands' perk.  As long as you're wielding a melee weapon and you're not using a shield, you gain 20% strength modifier to damage.");
		public static const HotBlooded:PerkType = mk("Hot Blooded", "Hot Blooded",
				"Raises minimum lust by up to 20.",
				"You choose the 'Hot Blooded' perk.  As a result of your enhanced libido, your lust no longer drops below 20! (If you already have some minimum lust, it will be increased by 10)");
		public static const ImmovableObject:PerkType = mk("Immovable Object", "Immovable Object",
				"[if(player.tou>=75)" +
						"Grants 10% physical damage reduction.</b>" +
						"|" +
						"<b>You aren't tough enough to benefit from this anymore.</b>" +
						"]",
				"You choose the 'Immovable Object' perk, granting 10% physical damage reduction.</b>");
		public static const Impale:PerkType = mk("Impale", "Impale",
				"Damage bonus of spears and lances critical hits is doubled as long speed is high enough.",
				"You've chosen the 'Impale' perk. Your spear and lance critical hit attacks bonus damages are doubled.");
		public static const ImprovedEndurance:PerkType = mk("Improved Endurance", "Improved Endurance",
				"Increases maximum fatigue by 80.",
				"You choose the 'Improved Endurance' perk. Thanks to your physical conditioning, your maximum fatigue has been increased by 80!");
		public static const ImprovedSelfControl:PerkType = mk("Improved Self-Control", "Improved Self-Control",
				"Increases maximum lust by 40.",
				"You choose the 'Improved Self-Control' perk. Thanks to your mental conditioning, your maximum lust has been increased by 40!");
		public static const ImprovedSpirituality:PerkType = mk("Improved Spirituality", "Improved Spirituality",
				"Increases maximum mana by 80.",
				"You choose the 'Improved Spirituality' perk. Thanks to your mystical conditioning, your maximum mana has been increased by 120!");
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
				"Reduces the fatigue cost of physical specials by 50%.",
				"You choose the 'Iron Stomach' perk, reducing the fatigue cost of physical special attacks by 50%");
		public static const JobAllRounder:PerkType = mk("Job: All-Rounder", "Job: All-Rounder",
				"You've combined all basic jobs training effects into an all-round fighting style.",
				"You choose 'Job: All-Rounder' perk, to combine effects of training in all six basic jobs.");
		public static const JobBarbarian:PerkType = mk("Job: Barbarian", "Job: Barbarian",
				"You've trained in using large weapons in fights.",
				"You choose 'Job: Barbarian' perk, training yourself to became Barbarian.");
		public static const JobBeastWarrior:PerkType = mk("Job: Beast Warrior", "Job: Beast Warrior",
				"You've trained in use of your own body to it limits in fights.",
				"You choose 'Job: Beast Warrior' perk, training yourself to became Beast Warrior.");
		public static const JobBrawler:PerkType = mk("Job: Brawler", "Job: Brawler",
				"You've trained in unarmed combat.",
				"You choose 'Job: Brawler' perk, training yourself to became Brawler.");
		public static const JobCourtesan:PerkType = mk("Job: Courtesan", "Job: Courtesan",
				"You've mastered all various uses of tease.",
				"You choose 'Job: Courtesan' perk, training yourself to became Courtesan.");
		public static const JobDefender:PerkType = mk("Job: Defender", "Job: Defender",
				"You've trained in withstanding even the heaviest attacks head on.",
				"You choose 'Job: Defender' perk, training yourself to became Defender.");
		public static const JobDervish:PerkType = mk("Job: Dervish", "Job: Dervish",
				"You've trained in multi meele attacks combat and using of medium sized dual weapons.",
				"You choose 'Job: Dervish' perk, training yourself to became Dervish.");
		public static const JobElementalConjurer:PerkType = mk("Job: Elemental Conjurer", "Job: Elemental Conjurer",
				"You've trained in summoning various types of elementals.",
				"You choose 'Job: Elemental Conjurer' perk, training yourself to call elementals.");
		public static const JobEnchanter:PerkType = mk("Job: Enchanter", "Job: Enchanter",
				"You've trained in casting empowered buffs.",
				"You choose 'Job: Enchanter' perk, training yourself to became Enchanter.");
		public static const JobEromancer:PerkType = mk("Job: Eromancer", "Job: Eromancer",
				"You've mastered the power of erotic magics.",
				"You choose 'Job: Eromancer' perk, training yourself to became Eromancer.");
		public static const JobGolemancer:PerkType = mk("Job: Golemancer", "Job: Golemancer",
				"You've mastered the art of making golems.",
				"You choose 'Job: Golemancer' perk, training yourself to became golems maker.");
		public static const JobGuardian:PerkType = mk("Job: Guardian", "Job: Guardian",
				"You've trained in defensive combat.",
				"You choose 'Job: Guardian' perk, training yourself to became Guardian.");
		public static const JobHunter:PerkType = mk("Job: Hunter", "Job: Hunter",
				"You've trained in hunter combat.",
				"You choose 'Job: Hunter' perk, training yourself to became Hunter.");
		public static const JobKnight:PerkType = mk("Job: Knight", "Job: Knight",
				"You've trained in combat using shields and heaviest armors.",
				"You choose 'Job: Knight' perk, training yourself to became Knight.");
		public static const JobMonk:PerkType = mk("Job: Monk", "Job: Monk",
				"You've trained in unarmed combat.",
				"You choose 'Job: Monk' perk, training yourself to became Monk.");
		public static const JobRanger:PerkType = mk("Job: Ranger", "Job: Ranger",
				"You've trained in ranged combat.",
				"You choose 'Job: Ranger' perk, training yourself to became Ranger.");
		public static const JobSeducer:PerkType = mk("Job: Seducer", "Job: Seducer",
				"You've trained the art of seduction.",
				"You choose 'Job: Seducer' perk, training yourself to became Seducer.");
		public static const JobSorcerer:PerkType = mk("Job: Sorcerer", "Job: Sorcerer",
				"You've trained in magic combat.",
				"You choose 'Job: Sorcerer' perk, training yourself to became Sorcerer.");
		public static const JobSoulCultivator:PerkType = mk("Job: Soul Cultivator", "Job: Soul Cultivator",
				"You've cultivated powers of your soul.",
				"You choose the 'Job: Soul Cultivator' perk, starting journey of the soul cultivation path!");
		public static const JobWarlord:PerkType = mk("Job: Warlord", "Job: Warlord",
				"You've trained in combat against group of enemies.",
				"You choose 'Job: Warlord' perk, training yourself to became Warlord.");
		public static const JobWarrior:PerkType = mk("Job: Warrior", "Job: Warrior",
				"You've trained in melee combat.",
				"You choose 'Job: Warrior' perk, training yourself to became Warrior.");
		public static const Juggernaut:PerkType = mk("Juggernaut", "Juggernaut",
				"When wearing heavy armor, you have extra 10% damage resistance and are immune to damage from being constricted/squeezed (req. 100+ tou).",
				"You choose the 'Juggernaut' perk, granting extra 10% damage resistance when wearing heavy armor and immunity to damage from been constricted/squeezed.");
		public static const KitsuneThyroidGland:PerkType = mk("Kitsune Thyroid Gland", "Kitsune Thyroid Gland",
				"Kitsune Thyroid Gland lower cooldowns for Illusion and Terror by one turn and speed of the recovery after using magic increased too. (under construction)",
				"You choose the 'Kitsune Thyroid Gland' perk. Some time after you grew ninth tail your enlightened entered on new level allowing you to form hoshi no tama inside your body.");
		public static const KitsuneThyroidGlandEvolved:PerkType = mk("Kitsune Thyroid Gland (Evolved)", "Kitsune Thyroid Gland (Evolved)",
				"Kitsune Thyroid Gland lower cooldowns for Illusion and Terror by one turn and speed of the recovery after using magic increased too. (under construction)",
				"You choose the 'Kitsune Thyroid Gland (Evolved)' perk. Some time after you grew ninth tail your enlightened entered on new level allowing you to form hoshi no tama inside your body.");
		public static const LegendaryGolemMaker:PerkType = mk("Legendary Golem Maker", "Legendary Golem Maker",
				"Your proficiency in making golems allows to .",
				"You choose 'Legendary Golem Maker' perk, increasing your proficiency in making golems.");
		public static const Lifeline:PerkType = mk("Lifeline", "Lifeline",
				"Increases self heling by 100 out of combat and by 50 in combat (using defend option will double it).",
				"You choose the 'Lifeline' perk, increasing your self healing.");
		public static const LightningStrikes:PerkType = mk("Lightning Strikes", "Lightning Strikes",
				"[if(player.spe>=60)" +
						"Increases the attack damage for non-heavy weapons.</b>" +
						"|" +
						"<b>You are too slow to benefit from this perk.</b>" +
						"]",
				"You choose the 'Lightning Strikes' perk, increasing the attack damage for non-heavy weapons.</b>");
		public static const LizanMarrow:PerkType = mk("Lizan Marrow", "Lizan Marrow",
				"Regenerates 0.5% of HP per round in combat and 1% of HP per hour. Additionaly your limit for innate self-regeneration rate increased.",
				"You choose the 'Lizan Marrow' perk. Constant regenerating your body caused pernamently change to your body marrow.");
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
		public static const LungingAttacks:PerkType = mk("Lunging Attacks", "Lunging Attacks",
				"[if(player.spe>=75)" +
						"Grants 50% armor penetration for standard attacks." +
						"|" +
						"<b>You are too slow to benefit from this perk.</b>" +
						"]",
				"You choose the 'Lunging Attacks' perk, granting 50% armor penetration for standard attacks.");
		public static const Mage:PerkType = mk("Mage", "Mage",
				"[if (player.inte>=50)" +
						"Increases base spell strength by 20% and mana pool by 30." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Mage' perk.  You are able to focus your magical abilities even more keenly, boosting your base spell effects by 20% and mana pool by 30.");
		public static const HiddenDualMomentum:PerkType = mk("Hidden Dual Momentum", "Hidden Dual Momentum",
				"You've trained in using your speed to enhance power of your dual large weapons swings.",
				"You choose 'Hidden Dual Momentum' perk, allowing to use your speed to enhance power of your attacks with dual large weapons.");
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
		public static const MantislikeAgility:PerkType = mk("Mantis-like Agility", "Mantis-like Agility",
				"Your altered musculature allows to increase your natural agility and speed. If somehow you would have some type of natural armor or even thicker skin this increase could be even greater...",
				"You choose the 'Mantis-like Agility' perk, by becoming much more mantis-like your body musculature started to slowly adapt to existance of exoskeleton.");
		public static const MantislikeAgilityEvolved:PerkType = mk("Mantis-like Agility (Evolved)", "Mantis-like Agility (Evolved)",
				"Your altered musculature providing you with even higher increase to agility and speed. If somehow you would have some type of natural armor or even thicker skin this increase would be even bigger.",
				"You choose the 'Mantis-like Agility (Evolved)' perk, by becoming much more mantis-like your body musculature started to slowly adapt to existance of exoskeleton.");
		public static const Manyshot:PerkType = mk("Manyshot", "Manyshot",
				"You always shoot two arrows instead of one on your first strike.",
				"You choose the 'Manyshot' perk, to always shoot two arrows instead of one on your first strike.");
		public static const Masochist:PerkType = mk("Masochist", "Masochist",
				"Take 20% less physical damage but gain lust when you take damage.",
				"You choose the 'Masochist' perk, reducing the damage you take but raising your lust each time!  This perk only functions while your libido is at or above 60!");
		public static const MasteredDefenceStance:PerkType = mk("Mastered Defence Stance", "Mastered Defence Stance",
				"Defend move now futher reduce incoming damage and allow for slight improved fatigue/mana/soulforce recovery.",
				"You choose 'Mastered Defence Stance' perk, finally attaining mastery with your defence pose.");
		public static const MasterGolemMaker:PerkType = mk("Master Golem Maker", "Master Golem Maker",
				"Your proficiency in making golems allows to .",
				"You choose 'Master Golem Maker' perk, increasing your proficiency in making golems.");
		public static const Medicine:PerkType = mk("Medicine", "Medicine",
				"Grants 15% chance per round of cleansing poisons/drugs from your body. Increases HP restoration on rest.",
				"You choose the 'Medicine' perk, giving you a chance to remove debilitating poisons automatically! Also, increases HP restoration on rest.");
		public static const Metamorph:PerkType = mk("Metamorph", "Metamorph",
				"Mold your own body using genetic memory and soulforce.",
				"You choose the 'Metamorph' perk, giving you a chance to mold your own body.");
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
		public static const Multishot:PerkType = mk("Multishot", "Multishot",
				"Allows you to perform additional range attack per round.",
				"You choose the 'Multishot' perk, This allows you to make additional range attack.");
		public static const HiddenMomentum:PerkType = mk("Hidden Momentum", "Hidden Momentum",
				"You've trained in using your speed to enhance power of your single large weapons swings.",
				"You choose 'Hidden Momentum' perk, allowing to use your speed to enhance power of your attacks with single large weapons.");
		public static const NakedTruth:PerkType = mk("Naked Truth", "Naked Truth",
				"Opponent have a hard time dealing serious damage as the sight of your naked body distract them (+10% dmg reduction).",
				"You choose the 'Naked Truth' perk, causing opponent have a hard time dealing serious damage as the sight of your naked body distract them.");
		public static const Naturaljouster:PerkType = mk("Natural jouster", "Natural jouster",
				"Increase attack power of spears/lances when you attack once each turn and have taur/drider lower body or 2,5x higher speed if you not have one of this specific lower body types (60+ for taurs/drider and 150+ for others).",
				"You've chosen the 'Natural jouster' perk. As long you will have taur or drider lower body and attack once per turn your spear/lance attack power will be three time higher.");
		public static const NaturaljousterMastergrade:PerkType = mk("Natural jouster (Master grade)", "Natural jouster (Master grade)",
				"Increase attack power of spears/lances when you attack once each turn and have taur/drider lower body or 2,5x higher speed if you not have one of this specific lower body types (180+ for taurs/drider and 450+ for others).",
				"You've chosen the 'Natural jouster (Master grade)' perk. As long you will have taur or drider lower body and attack once per turn your spear/lance attack power will be five time higher.");
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
		public static const Nymphomania:PerkType = mk("Nymphomania", "Nymphomania",
				"Raises minimum lust by up to 30.",
				"You've chosen the 'Nymphomania' perk.  Due to the incredible amount of corruption you've been exposed to, you've begun to live in a state of minor constant arousal.  Your minimum lust will be increased by as much as 30 (If you already have minimum lust, the increase is 10-15).");
		public static const Parry:PerkType = mk("Parry", "Parry",
				"[if(player.spe>=50)" +
						"Increases deflect chance by up to 10% while wielding a weapon. (Speed-based)." +
						"|" +
						"<b>You are not fast enough to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Parry' perk, giving you a chance to deflect blow with your weapon. (Speed-based).");
		public static const PeerlessEndurance:PerkType = mk("Peerless Endurance", "Peerless Endurance",
				"Increases maximum fatigue by 1000.",
				"You choose the 'Peerless Endurance' perk. Thanks to your peerless physical conditioning, your maximum fatigue has been increased by 1000!</b>");
		public static const PeerlessSelfControl:PerkType = mk("Peerless Self-Control", "Peerless Self-Control",
				"Increases maximum lust by 500.",
				"You choose the 'Peerless Self-Control' perk. Thanks to your peerless mental conditioning, your maximum lust has been increased by 500!</b>");
		public static const PeerlessSpirituality:PerkType = mk("Peerless Spirituality", "Peerless Spirituality",
				"Increases maximum mana by 1500.",
				"You choose the 'Peerless Spirituality' perk. Thanks to your peerless mystical conditioning, your maximum mana has been increased by 1500!</b>");
		public static const PentaAttack:PerkType = mk("Penta Attack", "Penta Attack",
				"Allows you to perform five melee attacks with non-large weapons per round.",
				"You choose the 'Penta Attack' perk.  This allows you to make five melee attacks with non-large weapons.");
		public static const PerfectDefenceStance:PerkType = mk("Perfect Defence Stance", "Perfect Defence Stance",
				"Defend move now massively reduce incoming damage and allow for improved fatigue/mana/soulforce recovery.",
				"You choose 'Perfect Defence Stance' perk, perfecting your defence pose beyond mastery level.");
		public static const PowerSweep:PerkType = mk("Power Sweep", "Power Sweep",
				"Allows the use of whirlwind using one handed weapons at 75% of the normal effect. Large weapon gain a 25% bonus to whirlwind damage (Does not include fist).",
				"You choose the 'Power Sweep' perk.  This allows you to improve Whirlwind attack.");
		public static const Precision:PerkType = mk("Precision", "Precision",
				"Reduces enemy armor by 10. (Req's 25+ Intelligence)",
				"You've chosen the 'Precision' perk.  Thanks to your intelligence, you're now more adept at finding and striking an enemy's weak points, reducing their damage resistance from armor by 10.  If your intelligence ever drops below 25 you'll no longer be smart enough to benefit from this perk.");
		public static const PrestigeJobArcaneArcher:PerkType = mk("Prestige Job: Arcane Archer", "Prestige Job: Arcane Archer",
				"You've trained in prestige art of combining magic and arrows.",
				"You choose 'Prestige Job: Arcane Archer' perk, training yourself to became Arcane Archer.");
		public static const PrestigeJobBerserker:PerkType = mk("Prestige Job: Berserker", "Prestige Job: Berserker",
				"You've trained in prestige art of perfect mastery over all forms of berserking.",
				"You choose 'Prestige Job: Berserker' perk, training yourself to became Berserker.");
		public static const PrestigeJobSeer:PerkType = mk("Prestige Job: Seer", "Prestige Job: Seer",
				"You've trained in prestige art of combining soulforce and magic.",
				"You choose 'Prestige Job: Seer' perk, training yourself to became Seer.");
		public static const PrestigeJobSentinel:PerkType = mk("Prestige Job: Sentinel", "Prestige Job: Sentinel",
				"You've trained in prestige art that brings 'tanking' to a whole new level.",
				"You choose 'Prestige Job: Sentinel' perk, training yourself to became Sentinel.");
		public static const PrestigeJobSoulArcher:PerkType = mk("Prestige Job: Soul Archer", "Prestige Job: Soul Archer",
				"You've trained in prestige art of combining soulforce and arrows.",
				"You choose 'Prestige Job: Soul Archer' perk, training yourself to became Soul Archer.");
		public static const PrestigeJobSoulArtMaster:PerkType = mk("Prestige Job: Soul Art Master", "Prestige Job: Soul Art Master",
				"You've trained in prestige art of combine soulforce with physical attacks to various deadly effect.",
				"You choose 'Prestige Job: Soul Art Master' perk, training yourself to became Soul Art Master.");
		public static const QuadrupleAttack:PerkType = mk("Quadruple Attack", "Quadruple Attack",
				"Allows you to perform four melee attacks with non-large weapons per round.",
				"You choose the 'Quadruple Attack' perk.  This allows you to make four melee attacks with non-large weapons.");
		public static const Rage:PerkType = mk("Rage", "Rage",
				"Increasing crit chance by up to 50% in berserk state that would reset after succesful crit attack.",
				"You choose the 'Rage' perk, increasing crit chance by up to 50% in berserk state until next crit attack.");
		public static const RapidReload:PerkType = mk("Rapid Reload", "Rapid Reload",
				"Reloading pistols or similar range weapons no longer using whole turn of action (or lowering by half reload cost).",
				"You choose the 'Rapid Reload' perk, lowering time needed to reload with ammo range weapons like pistols.");
		public static const RagingInferno:PerkType = mk("Raging Inferno", "Raging Inferno",
				"Cumulative 20% damage increase for every subsequent fire spell without interruption.",
				"You choose the 'Raging Inferno' perk. Cumulative 20% damage increase for every subsequent fire spell without interruption.");
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
		public static const Regeneration:RegenerationPerk = new RegenerationPerk();
		public static const Regeneration2:Regeneration2Perk = new Regeneration2Perk();
		public static const Regeneration3:Regeneration3Perk = new Regeneration3Perk();
		public static const Regeneration4:Regeneration4Perk = new Regeneration4Perk();
		public static const Regeneration5:Regeneration5Perk = new Regeneration5Perk();
		public static const Regeneration6:Regeneration6Perk = new Regeneration6Perk();
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
		public static const SalamanderAdrenalGlands:PerkType = mk("Salamander Adrenal Glands", "Salamander Adrenal Glands",
				"Your Salamander adrenal glands giving you slight boost to your natural stamina and libido.",
				"You choose the 'Salamander Adrenal Glands' perk, due to repeadly exposure to effects of lustzerk your adrenal glands mutated.");
		public static const ScyllaInkGlands:PerkType = mk("Scylla Ink Glands", "Scylla Ink Glands",
				"Your Scylla Ink Glands increase rate at which your body produce ink and slight boost to your natural strength.",
				"You choose the 'Scylla Ink Glands' perk, due to repeadly use of ink attack leading to denveloping ink glands!");
		public static const Seduction:PerkType = mk("Seduction", "Seduction",
				"Upgrades your tease attack, making it more effective.",
				"You choose the 'Seduction' perk, upgrading the 'tease' attack with a more powerful damage and a higher chance of success.");
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
				"When you using shield and isn't stunned gain 10% phys damage reduction.",
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
		public static const SluttySimplicity:PerkType = mk("Slutty Simplicity", "Slutty Simplicity",
				"Increases by 10% tease effect when you are naked. (Undergarments won't disable this perk.)",
				"You choose the 'Slutty Simplicity' perk, granting increased tease effect when you are naked.");
		public static const SoulAncestor:PerkType = mk("Soul Ancestor", "Soul Ancestor",
				"Allow reaching 12th stage of soul cultivation.",
				"You choose the 'Soul Ancestor' perk, reaching 12th stage of soul cultivation!");
		public static const SoulApprentice:PerkType = mk("Soul Apprentice", "Soul Apprentice",
				"Allow reaching 1st stage of soul cultivation.",
				"You choose the 'Soul Apprentice' perk, reaching 1st stage of soul cultivation!");
		public static const SoulEmperor:PerkType = mk("Soul Emperor", "Soul Emperor",
				"Allow reaching 11th stage of soul cultivation.",
				"You choose the 'Soul Emperor' perk, reaching 11th stage of soul cultivation!");
		public static const SoulElder:PerkType = mk("Soul Elder", "Soul Elder",
				"Allow reaching 6th stage of soul cultivation.",
				"You choose the 'Soul Elder' perk, reaching 6th stage of soul cultivation!");
		public static const SoulExalt:PerkType = mk("Soul Exalt", "Soul Exalt",
				"Allow reaching 7th stage of soul cultivation.",
				"You choose the 'Soul Exalt' perk, reaching 7th stage of soul cultivation!");
		public static const SoulKing:PerkType = mk("Soul King", "Soul King",
				"Allow reaching 10th stage of soul cultivation.",
				"You choose the 'Soul King' perk, reaching 10th stage of soul cultivation!");
		public static const SoulOverlord:PerkType = mk("Soul Overlord", "Soul Overlord",
				"Allow reaching 8th stage of soul cultivation.",
				"You choose the 'Soul Overlord' perk, reaching 8th stage of soul cultivation!");
		public static const SoulPersonage:PerkType = mk("Soul Personage", "Soul Personage",
				"Allow reaching 2nd stage of soul cultivation.",
				"You choose the 'Soul Personage' perk, reaching 2nd stage of soul cultivation!");
		public static const SoulScholar:PerkType = mk("Soul Scholar", "Soul Scholar",
				"Allow reaching 5th stage of soul cultivation.",
				"You choose the 'Soul Scholar' perk, reaching 5th stage of soul cultivation!");
		public static const SoulSprite:PerkType = mk("Soul Sprite", "Soul Sprite",
				"Allow reaching 4th stage of soul cultivation.",
				"You choose the 'Soul Sprite' perk, reaching 4th stage of soul cultivation!");
		public static const SoulTyrant:PerkType = mk("Soul Tyrant", "Soul Tyrant",
				"Allow reaching 9th stage of soul cultivation.",
				"You choose the 'Soul Tyrant' perk, reaching 9th stage of soul cultivation!");
		public static const SoulWarrior:PerkType = mk("Soul Warrior", "Soul Warrior",
				"Allow reaching 3rd stage of soul cultivation.",
				"You choose the 'Soul Warrior' perk, reaching 3rd stage of soul cultivation!");
		public static const SpeedyRecovery:PerkType = mk("Speedy Recovery", "Speedy Recovery",
				"Regain fatigue 50% faster.",
				"You choose the 'Speedy Recovery' perk, boosting your fatigue recovery rate!");
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
		public static const Spellsword:PerkType = mk("Spellsword", "Spellsword",
				"Start every battle with Charge Weapon enabled, if you meet White Magic requirements before it starts.",
				"You choose the 'Spellsword' perk. You start every battle with Charge Weapon effect, as long as your Lust is not preventing you from casting it before battle.");
		public static const SteelImpact:PerkType = mk("Steel Impact", "Steel Impact",
				"Add a part of your toughness to your weapon and shield damage.",
				"You choose the 'Steel Impact' perk. Increasing damage of your weapon and shield.");
		public static const StrongElementalBond:PerkType = mk("Strong Elemental Bond", "Strong Elemental Bond",
				"You lower by 10 needed mana to sustain active elemntal in combat.",
				"You choose the 'Strong Elemental Bond' perk, enhancing your connection with elementals and lowering mana needed to maintain bonds.");
		public static const StrongerElementalBond:PerkType = mk("Stronger Elemental Bond", "Stronger Elemental Bond",
				"You lower by 30 needed mana to sustain active elemntal in combat.",
				"You choose the 'Stronger Elemental Bond' perk, futher enhancing your connection with elementals.");
		public static const StrongestElementalBond:PerkType = mk("Strongest Elemental Bond", "Strongest Elemental Bond",
				"You lower by 90 needed mana to sustain active elemntal in combat.",
				"You choose the 'Strongest Elemental Bond' perk, reaching near the peak of connection strength with your elementals.");
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
				"Enables fourth item slot.",
				"You choose the 'Strong Back' perk, enabling a fourth item slot.");
		public static const StrongBack2:PerkType = mk("Strong Back 2: Strong Harder", "Strong Back 2: Strong Harder",
				"Enables fifth item slot.",
				"You choose the 'Strong Back 2: Strong Harder' perk, enabling a fifth item slot.");
		public static const Tactician:PerkType = mk("Tactician", "Tactician",
				"[if(player.inte>=50)" +
						"Increases critical hit chance by up to 10% (Intelligence-based)." +
						"|" +
						"<b>You are too dumb to gain benefit from this perk.</b>" +
						"]",
				"You choose the 'Tactician' perk, increasing critical hit chance by up to 10% (Intelligence-based).");
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
		public static const ThirstForBlood:PerkType = mk("Thirst for blood", "Thirst for blood",
				"Weapon and effect that causes bleed damage have this damage increased by 50%.",
				"You choose the 'Thirst for blood' perk, increasing damage done by bleed effects.");
		public static const ThunderousStrikes:PerkType = mk("Thunderous Strikes", "Thunderous Strikes",
				"+20% 'Attack' damage while strength is at or above 80.",
				"You choose the 'Thunderous Strikes' perk, increasing normal damage by 20% while your strength is over 80.");
		public static const TitanGrip:PerkType = mk("Titan Grip", "Titan Grip",
				"Gain an ability to wield large weapons in one hand.",
				"You choose the 'Titan Grip' perk, gaining an ability to wield large weapons in one hand.");
		public static const Tornado:PerkType = mk("Tornado", "Tornado",
				"Increasing damage of aoe like whirlwind by 100% of base value.",
				"You choose the 'Tornado' perk, increasing damage by aoe specials like whirlwind.");
		public static const TrachealSystem:PerkType = mk("Tracheal System", "Tracheal System",
				"Your body posses rudimentary respiratory system of the insects.",
				"You choose the 'Tracheal System' perk, by becoming much more insect-like your body started to denvelop crude version of insects breathing system.");
		public static const TrachealSystemFinalForm:PerkType = mk("Tracheal System (Final Form)", "Tracheal System (Final Form)",
				"Your body posses fully developed respiratory system of the insects.",
				"You choose the 'Tracheal System (Final Form)' perk, continued exposition to insectoidal changes caused your tracheal system evolution into it final form.");
		public static const TrachealSystemEvolved:PerkType = mk("Tracheal System (Evolved)", "Tracheal System (Evolved)",
				"Your body posses half developed respiratory system of the insects.",
				"You choose the 'Tracheal System (Evolved)' perk, continuous exposition to insectoidal changes caused your tracheal system evolution into more complete form.");
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
				"Unlocked ability to enter a state in which PC assumes a crystalline form, enhancing physical and mental abilities at constant cost of soulforce.",
				"You choose the 'Trance' perk, which unlock 'Trance' special. It enhancing physical and mental abilities at constant cost of soulforce.");
		public static const Transference:PerkType = mk("Transference", "Transference",
				"Your mastery of lust and desire allows you to transfer 15% of your current arousal to your opponent.",
				"You choose the 'Transference' perk, granting ability to transfer your own arousal to your opponent.");
		public static const TripleAttack:PerkType = mk("Triple Attack", "Triple Attack",
				"Allows you to perform three melee attacks with non-large weapons per round.",
				"You choose the 'Triple Attack' perk.  This allows you to make three melee attacks with non-large weapons.");
		public static const TripleAttackLarge:PerkType = mk("Triple Attack (Large)", "Triple Attack (Large)",
				"Allows you to perform three melee attacks with large weapons per round.",
				"You choose the 'Triple Attack (Large)' perk.  This allows you to make three melee attacks with large weapons.");
		public static const TripleStrike:PerkType = mk("Triple Strike", "Triple Strike",
				"Allows you to perform three range attacks per round.",
				"You choose the 'Triple Strike' perk.  This allows you to make three range attacks.");
		public static const Unhindered:PerkType = mk("Unhindered", "Unhindered",
				"Increases chances of evading enemy attacks when you are naked. (Undergarments won't disable this perk.)",
				"You choose the 'Unhindered' perk, granting chance to evade when you are naked.");
		public static const UnlockBody:PerkType = mk("Unlock: Body", "Unlock: Body",
				"Unlocking body potential grants additional 15 HP on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Body' perk, allowing you to increase passive HP gains on lvl-up!");
		public static const UnlockBody2ndStage:PerkType = mk("Unlock: Body (2nd Stage)", "Unlock: Body (2nd Stage)",
				"Unlocking body potential grants additional 5 Fatigue on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Body (2nd Stage)' perk, allowing you to increase passive Fatigue gains on lvl-up!");
		public static const UnlockId:PerkType = mk("Unlock: Id", "Unlock: Id",
				"Unlocking id grants additional 1 Lust on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Id' perk, allowing you to increase passive Lust gains on lvl-up!");
		public static const UnlockId2ndStage:PerkType = mk("Unlock: Id (2nd Stage)", "Unlock: Id (2nd Stage)",
				"Unlocking id grants additional 1 Wrath on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Id (2nd Stage)' perk, allowing you to increase passive Wrath gains on lvl-up!");
		public static const UnlockMind:PerkType = mk("Unlock: Mind", "Unlock: Mind",
				"Unlocking mind potential grants additional 5 Mana on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Mind' perk, allowing you to increase passive Mana gains on lvl-up!");
		public static const UnlockMind2ndStage:PerkType = mk("Unlock: Mind (2nd Stage)", "Unlock: Mind (2nd Stage)",
				"Unlocking mind potential grants additional 5 Soulforce on each lvl-up (retroactive effect).",
				"You choose the 'Unlock: Mind (2nd Stage)' perk, allowing you to increase passive Soulforce gains on lvl-up!");
		public static const VitalShot:PerkType = mk("Vital Shot", "Vital Shot",
				"Gain a +10% chance to do a critical strike with arrows.",
				"You choose the 'Vital Shot' perk, gaining an additional +10% chance to cause a critical hit with arrows.");
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
		public static const WildQuiver:PerkType = mk("Wild Quiver", "Wild Quiver",
				"You grab and shoot arrows at blinding speed, gaining an extra shot.",
				"You choose the 'Wild Quiver' perk, you combine it with triple attack and manyshot to shoot up to 5 times.");
		public static const JobSoulArcher:PerkType = mk("Job: Soul Archer", "Job: Soul Archer",
				"You've trained in art of combining soulforce and arrows.",
				"You choose 'Job: Soul Archer' perk, training yourself to became Soul Archer.");
		public static const JobArcaneArcher:PerkType = mk("Job: Arcane Archer", "Job: Arcane Archer",
				"You've trained in art of combining magic and arrows.",
				"You choose 'Job: Arcane Archer' perk, training yourself to became Arcane Archer.");
		public static const JobArcher:PerkType = mk("Job: Archer", "Job: Archer",
				"You've trained in ranged combat.",
				"You choose 'Job: Archer' perk, training yourself to became Archer.");//perk później do usuniecia
		

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
		public static const BloodMage:PerkType = mk("Blood Mage", "Blood Mage",
				"Spellcasting now consumes health instead of mana!",null,true);
		public static const LastResort:PerkType = mk("Last Resort", "Last Resort",
				"When mana is too low to cast a spell, automatically cast from hp instead.",null,true);
		public static const Obsession:ObsessionPerk = new ObsessionPerk();
		public static const Sanctuary:PerkType = mk("Sanctuary", "Sanctuary", "Regenerates up to 1% of HP scaling on purity");
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
		public static const DaoistsFocus:DaoistsFocusPerk = new DaoistsFocusPerk();
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
		public static const Androgyny:PerkType = mk("Androgyny", "Androgyny",
				"No gender limits on facial masculinity or femininity.");
		public static const AquaticAffinity:PerkType = mk("Aquatic Affinity", "Aquatic Affinity",
				"When in an aquatic battle you gains a +30 to strength and speed.");
		public static const BasiliskWomb:PerkType = mk("Basilisk Womb", "Basilisk Womb",
				"Enables your eggs to be properly fertilized into basilisks of both genders!");
		public static const BeeOvipositor:PerkType = mk("Bee Ovipositor", "Bee Ovipositor",
				"Allows you to lay eggs through a special organ on your insect abdomen, though you need at least 10 eggs to lay.");
		public static const BimboBody:PerkType = mk("Bimbo Body", "Bimbo Body",
				"Gives the body of a bimbo.  Tits will never stay below a 'DD' cup, libido is raised, lust resistance is raised, and upgrades tease.");
		public static const BimboBrains:PerkType = mk("Bimbo Brains", "Bimbo Brains",
				"Now that you've drank bimbo liquer, you'll never, like, have the attention span and intelligence you once did!  But it's okay, 'cause you get to be so horny an' stuff!");
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
		public static const ElementalConjurerMindAndBodyDedication:PerkType = mk("Elemental Conjurer Mind and Body Dedication", "Elemental Conjurer Mind and Body Dedication",
				"Removes all negative modifiers to PC max Str/Tou/Spe caps caused by picking perk Elemental Conjurer Dedication.");
		public static const ElementalConjurerMindAndBodyResolve:PerkType = mk("Elemental Conjurer Mind and Body Resolve", "Elemental Conjurer Mind and Body Resolve",
				"Removes all negative modifiers to PC max Str/Tou/Spe caps caused by picking perk Elemental Conjurer Resolve.");
		public static const ElementalConjurerMindAndBodySacrifice:PerkType = mk("Elemental Conjurer Mind and Body Sacrifice", "Elemental Conjurer Mind and Body Sacrifice",
				"Removes all negative modifiers to PC max Str/Tou/Spe caps caused by picking perk Elemental Conjurer Sacrifice.");
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
		public static const FireAffinity:PerkType = mk("Fire Affinity", "Fire Affinity",
				"You have high resistance to fire effects, immunity to the burn condition, and mastery over fire abilities and magic. However, you are highly susceptible to ice.");
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
		public static const HarpyWomb:PerkType = mk("Harpy Womb", "Harpy Womb",
				"Increases all laid eggs to large size so long as you have harpy legs and a harpy tail.");
		public static const ImprovedVenomGland:PerkType = mk("Improved venom gland", "Improved venom gland",
				"Empower your racial venoms, Increasing their effect potencies.");
		public static const Incorporeality:PerkType = mk("Incorporeality", "Incorporeality",
				"Allows you to fade into a ghost-like state and temporarily possess others.");
		public static const InkSpray:PerkType = mk("Ink Spray", "Ink Spray",
				"Allows you to shoot blinding and probably slightly arousing ink out of your genitalia similar like octopus.");
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
		public static const NinetailsKitsuneOfBalance:PerkType = mk("Nine-tails Kitsune of Balance", "Nine-tails Kitsune of Balance",
				"The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  You tread narrow path between corruption and true enlightment maintaining balance that allow to fuse both sides powers.",null,true);
		public static const Oviposition:PerkType = mk("Oviposition", "Oviposition",
				"Causes you to regularly lay eggs when not otherwise pregnant.");
		public static const PhoenixFireBreath:PerkType = mk("Phoenix fire breath", "Phoenix fire breath",
				"Allows access to a phoenix fire breath attack.");
		public static const PurityBlessing:PerkType = mk("Purity Blessing", "Purity Blessing",
				"Reduces the rate at which your corruption, libido, and lust increase. Reduces minimum libido and lust slightly.");
		public static const RapierTraining:PerkType = mk("Rapier Training", "Rapier Training",
				"After finishing of your training, increase attack power of any rapier you're using.");
		public static const SatyrSexuality:PerkType = mk("Satyr Sexuality", "Satyr Sexuality",
				"Thanks to your satyr biology, you now have the ability to impregnate both vaginas and asses. Also increases your virility rating. (Anal impregnation not implemented yet)");
		public static const SlimeCore:PerkType = mk("Slime Core", "Slime Core",
				"Grants more control over your slimy body, allowing you to go twice as long without fluids.");
		public static const SpiderOvipositor:PerkType = mk("Spider Ovipositor", "Spider Ovipositor",
				"Allows you to lay eggs through a special organ on your arachnid abdomen, though you need at least 10 eggs to lay.");
		public static const ThickSkin:PerkType = mk("Thick Skin", "Thick Skin",
				"Toughens your dermis to provide 2 points of armor.");
		public static const TransformationResistance:PerkType = mk("Transformation Resistance", "Transformation Resistance",
				"Reduces the likelihood of undergoing a transformation. Disables Bad Ends from transformative items.");
				
		// Quest, Event & NPC perks
		public static const BasiliskResistance:PerkType = mk("Basilisk Resistance", "Basilisk Resistance",
				"Grants immunity to Basilisk's paralyzing gaze. Disables Basilisk Bad End.");
		public static const BulgeArmor:PerkType = mk("Bulge Armor", "Bulge Armor",
				"Grants a 5 point damage bonus to dick-based tease attacks.");
		public static const Cornucopia:PerkType = mk("Cornucopia", "Cornucopia",
				"Vaginal and Anal capacities increased by 30.");
		public static const ElvenBounty:ElvenBountyPerk = new ElvenBountyPerk();
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
		public static const GclassHeavenTribulationSurvivor:PerkType = mk("G class Heaven Tribulation Survivor", "G class Heaven Tribulation Survivor",
				"You have survived second trial on cultivation path: G class Heaven Tribulation.");
		public static const HclassHeavenTribulationSurvivor:PerkType = mk("H class Heaven Tribulation Survivor", "H class Heaven Tribulation Survivor",
				"You have survived first trial on cultivation path: H class Heaven Tribulation.");
		public static const Hellfire:PerkType = mk("Hellfire", "Hellfire",
				"Grants a corrupted fire breath attack, like the hellhounds in the mountains.");
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
		public static const Misdirection:PerkType = mk("Misdirection", "Misdirection",
				"Grants additional evasion chances while wearing Raphael's red bodysuit.");
		public static const OmnibusGift:PerkType = mk("Omnibus' Gift", "Omnibus' Gift",
				"Increases minimum lust but provides some lust resistance.");
		public static const DemonicLethicite:PerkType = mk("Demonic Lethicite", "Demonic Lethicite",
				"Improves soulforce and makes you more demonic.");//Effects: maxSoulforce += lib; +1 demonscore; 10 min corruption
		public static const ProductivityDrugs:PerkType = new ProductivityDrugsPerk();
		public static const OneTrackMind:PerkType = mk("One Track Mind", "One Track Mind",
				"Your constant desire for sex causes your sexual organs to be able to take larger insertions and disgorge greater amounts of fluid.");
		public static const PilgrimsBounty:PerkType = mk("Pilgrim's Bounty", "Pilgrim's Bounty",
				"Causes you to always cum as hard as if you had max lust.");
		public static const PureAndLoving:PerkType = mk("Pure and Loving", "Pure and Loving",
				"Your caring attitude towards love and romance makes you slightly more resistant to lust and corruption.");
		public static const SensualLover:PerkType = mk("Sensual Lover", "Sensual Lover",
				"Your sensual attitude towards love and romance makes your tease ability slightly more effective.");
		public static const SoulSense:PerkType = mk("Soul Sense", "Soul Sense",
				"Your strong affinity toward soullforce helped to denvelop another sense called 'Soul Sense' by a fellow soul cultivators.");
		public static const Whispered:PerkType = mk("Whispered", "Whispered",
				"Akbal's blessings grant limited telepathy that can induce fear.");
				
		public static const ControlledBreath:ControlledBreathPerk = new ControlledBreathPerk();
		public static const CleansingPalm:CleansingPalmPerk = new CleansingPalmPerk();
		public static const Enlightened:EnlightenedPerk = new EnlightenedPerk();
		public static const StarSphereMastery:StarSphereMasteryPerk = new StarSphereMasteryPerk();

		// Monster perks
		public static const Acid:PerkType = mk("Acid", "Acid", "");
		public static const DarknessNature:PerkType = mk("Darkness Nature", "Darkness Nature", "");
		public static const DarknessVulnerability:PerkType = mk("Darkness Vulnerability", "Darkness Vulnerability", "");
		public static const EnemyBeastOrAnimalMorphType:PerkType = mk("Beast or Animal-morph enemy type", "Beast or Animal-morph enemy type", "");
		public static const EnemyBossType:PerkType = mk("Boss-type enemy", "Boss-type enemy", "");
		public static const EnemyConstructType:PerkType = mk("Construct-type enemy", "Construct-type enemy", "");
		public static const EnemyGigantType:PerkType = mk("Gigant-sized type enemy", "Gigant-sized type enemy", "");
		public static const EnemyGodType:PerkType = mk("God-type enemy", "God-type enemy", "");
		public static const EnemyGroupType:PerkType = mk("Group-type enemy", "Group-type enemy", "");
		public static const FireNature:PerkType = mk("Fire Nature", "Fire Nature", "");
		public static const FireVulnerability:PerkType = mk("Fire Vulnerability", "Fire Vulnerability", "");
		public static const IceNature:PerkType = mk("Ice Nature", "Ice Nature", "");
		public static const IceVulnerability:PerkType = mk("Ice Vulnerability", "Ice Vulnerability", "");
		public static const LightningNature:PerkType = mk("Lightning Nature", "Lightning Nature", "");
		public static const LightningVulnerability:PerkType = mk("Lightning Vulnerability", "Lightning Vulnerability", "");
		public static const ShieldWielder:PerkType = mk("Shield wielder", "Shield wielder", "");
		public static const TeaseResistance:PerkType = mk("Tease Resistance", "Tease Resistance", "");
		//public static const EnemyGooType:PerkType = mk("", "", "");
		//public static const EnemyPlantType:PerkType = mk("", "", "");
		//public static const Enemy:PerkType = mk("", "", "");undead/ghost?
		//public static const :PerkType = mk("", "", "");
		//public static const :PerkType = mk("", "", ""); na poźniej dopisane perki wzór
//dodać także typy perków dla poszczególnych ras przeciwników tak, ze bedą mogły one mieć jakieś korzyści też (np. jak ma Dragon nature to bonusy jak PC miałby dragon score > 6))
		private static function mk(id:String, name:String, desc:String, longDesc:String = null, keepOnAscension:Boolean = false):PerkType
		{
			return new PerkType(id, name, desc, longDesc, keepOnAscension);
		}

	// Perk requirements
	private static function initDependencies():void {
		//------------
		// STRENGTH
		//------------
		JobWarrior.requireStr(10);
		StrongBack.requireStr(25);
		StrongBack2.requirePerk(StrongBack)
				   .requireStr(50);
		//Tier 1 Strength Perks
		ThunderousStrikes.requireLevel(6)
						 .requireStr(80)
						 .requirePerk(JobWarrior);
		BrutalBlows.requireLevel(6)
				   .requireStr(75)
				   .requirePerk(JobWarrior);
		JobBrawler.requireLevel(6)
				  .requireStr(60);
		JobBarbarian.requireLevel(6)
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
					 .requirePerk(JobBarbarian)
					 .requireStr(100);
		DoubleAttackLarge.requireLevel(12)
						 .requirePerk(JobBarbarian)
						 .requireStr(75)
						 .requireStr(50);
		//Tier 3 Strength Perks
		ColdFury.requireLevel(18)
				.requirePerk(Berzerker)
				.requirePerk(ImprovedSelfControl)
				.requireStr(75);
		TitanGrip.requireLevel(18)
				 .requirePerk(WeaponMastery)
				 .requireStr(100);
		HiddenMomentum.requireLevel(18)
					  .requirePerk(JobBarbarian)
					  .requireStr(75)
					  .requireSpe(50);
		//Tier 4 Strength Perks
		WeaponGrandMastery.requirePerk(WeaponMastery)
						  .requireStr(140)
						  .requireLevel(24);
		DualWieldLarge.requirePerk(DualWield)
					  .requirePerk(TitanGrip)
					  .requireStr(125)
					  .requireLevel(24);
		TripleAttackLarge.requirePerk(DoubleAttackLarge)
						 .requireStr(125)
						 .requireSpe(100)
						 .requireLevel(24);
		//Tier 5 Strength Perks
		HiddenDualMomentum.requirePerk(HiddenMomentum)
						  .requirePerk(DualWield)
						  .requireStr(150)
						  .requireSpe(100)
						  .requireLevel(30);
		UnlockId2ndStage.requirePerk(UnlockId)
						.requireStr(150)
						.requireLevel(30);
		
		//Tier 6 Strength Perks
		//HiddenDualMomentum.requirePerk(HiddenMomentum).requireStr(175).requireSpe(100).requireLevel(30);	//herculanmight - perk dodający limit do str cap (i może do max tone też)
		//a może właśnie perk dodający do max str cap tyle ile wynosi obecnie PC tone?
		//Tier 7 Strength Perks
		PrestigeJobBerserker.requirePrestigeJobSlot()
							.requirePerk(JobBarbarian)
							.requirePerk(JobGuardian)
							.requireAnyPerk(Berzerker, Lustzerker)
							.requireStr(200)
							.requireLevel(42);
		//Tier 8 Strength Perks
		Rage.requirePerk(PrestigeJobBerserker)
			.requireLevel(48);
		//Tier 9 Strength Perks
		Anger.requirePerk(Rage)
			 .requireLevel(54);
		//Tier 10 Strength Perks
		//		Too Angry to Die perk
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
		JobDefender.requirePerk(JobGuardian)
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
				   .requireLevel(42);
		//Tier 9 Toughness Perks
		ShieldCombat.requirePerk(SteelImpact)
					.requireLevel(48);
		//Tier 10 Toughness Perks
		//------------
		// SPEED
		//------------
		JobRanger.requireSpe(10);
		Runner.requireSpe(25);
		//slot 3 - speed perk
		Evade.requirePerk(JobRanger)
			 .requireSpe(25);
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
		//Tier 1 Speed Perks
		//Speedy Recovery - Regain Fatigue 50% faster speed.
		SpeedyRecovery.requirePerk(Evade)
					  .requireSpe(60)
					  .requireLevel(6);
		//Agility - A small portion of your speed is applied to your defense rating when wearing light armors.
		Agility.requireSpe(75)
			   .requirePerk(Runner)
			   .requireLevel(6);
		//slot 3 - Double Attack perk
		DoubleAttack.requirePerk(JobDervish)
					.requireSpe(50)
					.requireLevel(6);
		DoubleStrike.requirePerk(Evade)
					.requirePerk(Runner)
					.requireSpe(50)
					.requireLevel(6);
		Unhindered.requireSpe(75)
				  .requirePerk(Evade)
				  .requirePerk(Agility)
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
		JobDervish.requirePerk(JobRanger)
				  .requireSpe(40)
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
		/*Brawler.requireMinSpe(60)
		 .requireMinStr(60);*/ //Would it be fitting to have Urta teach you?
		//Tier 2 Speed Perks
		LungingAttacks.requirePerk(JobRanger)
					  .requireSpe(75)
					  .requireLevel(12);
		Blademaster.requirePerk(JobRanger)
				   .requireSpe(80)
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
				  .requirePerk(JobEromancer)
				  .requireLevel(12);
		TripleStrike.requirePerk(DoubleStrike)
					.requireSpe(75)
					.requireLevel(12);
		JobHunter.requirePerk(JobRanger)
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
		DeadlyThrow.requirePerk(JobHunter);
		//requirePerk(JobMonk).requireMinSpe(50) //perk dajacy 2 ataki kiedy uzywa sie tylko fists -
		// - cos jak double attack ale bez limitu sily ^^ (ale dodac nowy status aby byl niezalezny od double strike)
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
						 return player.tail.isAny(Creature.TAIL_TYPE_BEE_ABDOMEN, Creature.TAIL_TYPE_SCORPION, Creature.TAIL_TYPE_MANTICORE_PUSSYTAIL)
								|| player.facePart.isAny(Creature.FACE_SNAKE_FANGS, Creature.FACE_SPIDER_FANGS);
					 }, "Venom-producing tail, abdomen, or fangs");
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
		//Tier 4 Speed Perks
		WildQuiver.requirePerk(Manyshot)
				  .requireSpe(125)
				  .requireLevel(24);
		PentaAttack.requirePerk(QuadrupleAttack)
				   .requireSpe(125)
				   .requireLevel(24);
		//Tier 5 Speed Perks
		HexaAttack.requirePerk(PentaAttack)
				  .requireSpe(150)
				  .requireLevel(30);
		Multishot.requirePerk(WildQuiver)
				 .requireSpe(150)
				 .requireLevel(30);
		UnlockBody2ndStage.requirePerk(UnlockBody)
						  .requireSpe(150)
						  .requireLevel(30);
		//Tier 6 Speed Perks
		NaturaljousterMastergrade.requirePerk(Naturaljouster)
								 .requireSpe(180)
								 .requireLevel(36);
		//Tier 7 Speed Perks
/*		PrestigeJobSoulArcher.requirePrestigeJobSlot()
							 .requirePerk(SoulOverlord)
							 .requirePerk(JobHunter)
							 .requireSpe(200)
							 .requireLevel(42);
*/		PrestigeJobArcaneArcher.requirePrestigeJobSlot()
							   .requirePerk(JobSorcerer)
							   .requirePerk(JobHunter)
							   .requireSpe(200)
							   .requireInt(150)
							   .requireLevel(42);
		//Tier 8 Speed Perks
		ElementalArrows.requireLevel(48)
					   .requirePerk(PrestigeJobArcaneArcher)
					   .requireCustomFunction(function(player: Player): Boolean {
						   return player.hasStatusEffect(StatusEffects.KnowsWhitefire) || player.hasStatusEffect(StatusEffects.KnowsIceSpike)
					   }, "Whitefire or Ice Spike spell");
		//Tier 9 Speed Perks
		Cupid.requireLevel(54)
			 .requirePerk(PrestigeJobArcaneArcher)
			 .requireStatusEffect(StatusEffects.KnowsArouse, "Arouse spell");
		//------------
		// INTELLIGENCE
		//------------
		JobSorcerer.requireInt(10);
		//Slot 4 - precision - -10 enemy toughness for damage calc
		Precision.requireInt(25);
		//Spellpower - boosts spell power
		Spellpower.requirePerk(JobSorcerer)
				  .requireInt(50);
		UnlockMind.requireInt(20);
		ManaAffinityI.requirePerk(JobSorcerer)
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
					 .requireInt(50);
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
		Archmage.requirePerk(Mage)
				.requireInt(75)
				.requireLevel(12);
		JobEnchanter.requirePerk(Mage)
					.requireInt(75)
					.requireLevel(12);
		FocusedMind.requirePerk(Mage)
				   .requireInt(75)
				   .requireLevel(12);
		RagingInferno.requirePerk(Archmage)
					 .requirePerk(Channeling)
					 .requireCustomFunction(function (player:Player):Boolean {
						 return player.hasStatusEffect(StatusEffects.KnowsWhitefire)
								|| player.hasPerk(DragonFireBreath)
								|| player.hasPerk(FireLord)
								|| player.hasPerk(Hellfire)
								|| player.hasPerk(EnlightenedNinetails)
								|| player.hasPerk(CorruptedNinetails)
					 }, "Any fire spell")
					 .requireLevel(12)
					 .requireInt(75);
		GlacialStorm.requirePerk(Archmage)
					.requirePerk(Channeling)
					.requireCustomFunction(function (player:Player):Boolean {
						return player.hasStatusEffect(StatusEffects.KnowsIceSpike)
							   || player.hasStatusEffect(StatusEffects.KnowsIceRain)
							   || player.hasPerk(DragonIceBreath)
					}, "Any ice spell")
					.requireLevel(12)
					.requireInt(75);
		// Spell-boosting perks
		// Battlemage: auto-use Might
		Battlemage.requireLevel(12)
				  .requirePerk(JobEnchanter)
				  .requireInt(80)
				  .requirePerk(Channeling)
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
		ArcaneRegenerationMajor.requirePerk(Archmage)
							   .requirePerk(ArcaneRegenerationMinor)
							   .requireInt(75)
							   .requireLevel(12);
		//Tier 3 Intelligence perks
		GrandArchmage.requirePerk(Archmage)
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
						.requirePerk(Archmage)
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
						   .requirePerk(Archmage)
						   .requireInt(100)
						   .requireLevel(18);
		ArcaneRegenerationEpic.requirePerk(GrandArchmage)
							  .requirePerk(ArcaneRegenerationMajor)
							  .requireInt(100)
							  .requireLevel(18);
		//Tier 4 Intelligence perks
		GreyMage.requirePerk(GrandArchmage)
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
		ArcaneRegenerationLegendary.requirePerk(GreyMage)
								   .requirePerk(ArcaneRegenerationEpic)
								   .requireInt(125)
								   .requireLevel(24);
		//Tier 5 Intelligence perks
		GreyArchmage.requirePerk(GreyMage)
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
		//Tier 6 Intelligence perks
		Convergence.requirePerk(GreyArchmage)
				   .requireInt(175)
				   .requireLevel(36);
		EternalyLastingBuffs.requirePerk(EverLastingBuffs)
							.requireInt(190)
							.requireLevel(36);
		SuperiorSpirituality.requireWis(140)
							.requireInt(210)
							.requirePerk(HalfStepToSuperiorSpirituality)
							.requireLevel(36);
		//Tier 7 Intelligence perks
		PrestigeJobSeer.requirePrestigeJobSlot()
					   .requirePerk(GreyArchmage)
					   .requirePerk(SoulElder)
					   .requireInt(200)
					   .requireLevel(42);
		HalfStepToPeerlessSpirituality.requireWis(160)
									  .requireInt(240)
									  .requirePerk(SuperiorSpirituality)
									  .requireLevel(42);
		//Tier 8 Intelligence perks
		PeerlessSpirituality.requireWis(180)
							.requireInt(270)
							.requirePerk(HalfStepToPeerlessSpirituality)
							.requireLevel(48);
		Trance.requirePerk(PrestigeJobSeer)
			  .requireInt(240)
			  .requireLevel(48);
		//------------
		// WISDOM
		//------------
		JobElementalConjurer.requireWis(10);
		ElementalConjurerResolve.requirePerk(JobElementalConjurer)
								.requireWis(20);
		ElementalContractRank1.requirePerk(ElementalConjurerResolve)
							  .requireWis(25);
		ElementsOfMarethBasics.requirePerk(ElementalContractRank1)
							  .requireWis(30);
		//Tier 1 Wisdom perks
		ElementalConjurerDedication.requirePerk(ElementalConjurerResolve)
								   .requireWis(40)
								   .requireLevel(6);
		ElementalContractRank2.requirePerk(ElementalConjurerDedication)
							  .requirePerk(ElementalContractRank1)
							  .requireWis(50)
							  .requireLevel(6);
		ElementalBondFlesh.requirePerk(ElementalContractRank1)
						  .requireWis(50)
						  .requireLevel(6);
		//Tier 2 Wisdom perks
		JobMonk.requireWis(60)
			   .requireLevel(12);
		Combo.requirePerk(JobMonk)
			 .requireWis(75)
			 .requireStr(50)
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
		//Tier 3 Wisdom perks
		ElementalContractRank4.requirePerk(ElementalContractRank3)
							  .requireWis(100)
							  .requireLevel(18);
		CatchTheBlade.requirePerk(JobMonk)
					 .requireWis(80)
					 .requireSpe(100)
					 .requireLevel(18);
		//
		//Tier 4 Wisdom perks
		ComboMaster.requirePerk(Combo)
				   .requireWis(125)
				   .requireStr(100)
				   .requireLevel(24);
		ElementalContractRank5.requirePerk(ElementalContractRank4)
							  .requireWis(125)
							  .requireLevel(24);
		StrongerElementalBond.requirePerk(StrongElementalBond)
							 .requirePerk(ElementalContractRank5)
							 .requireWis(125)
							 .requireLevel(24);
		//Tier 5 Wisdom perks
		UnlockMind2ndStage.requirePerk(UnlockMind)
						  .requireWis(150)
						  .requireLevel(30);
		ElementalContractRank6.requirePerk(ElementalContractRank5)
							  .requireWis(150)
							  .requireLevel(30);
		//Tier 6 Wisdom perks
		ElementalContractRank7.requirePerk(ElementalContractRank6)
							  .requireWis(175)
							  .requireLevel(36);
		StrongestElementalBond.requirePerk(StrongerElementalBond)
							  .requirePerk(ElementalContractRank7)
							  .requireWis(175)
							  .requireLevel(36);
		ElementalConjurerSacrifice.requirePerk(ElementalConjurerDedication)
								  .requireWis(160)
								  .requireLevel(36);
		//Tier 7 Wisdom perks
		PrestigeJobSoulArtMaster.requirePrestigeJobSlot()
								.requirePerk(FleshBodyApprenticeStage)
								.requirePerk(JobMonk)
								.requireWis(200)
								.requireLevel(42);
		ElementalContractRank8.requirePerk(ElementalConjurerSacrifice)
							  .requirePerk(ElementalContractRank7)
							  .requireWis(200)
							  .requireLevel(42);
		//Tier 8 Wisdom perks
		//Tier 9 Wisdom perks
		//------------
		// LIBIDO
		//------------
		//slot 5 - libido perks

		//Slot 5 - Fertile+ increases cum production and fertility (+15%)
		JobSeducer.requireLib(10);
		UnlockId.requireLib(20);
		FertilityPlus.requireLib(25);
		FertilityPlus.defaultValue1 = 15;
		FertilityPlus.defaultValue2 = 1.75;
		BasicSelfControl.requireLib(20)
						.requireInt(30);
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
		JobEromancer.requirePerk(JobSeducer)
					.requireLib(30)
					.requireInt(60)
					.requireLevel(6);
		ArcaneLash.requirePerk(JobEromancer).requireLevel(6);
		HalfStepToImprovedSelfControl.requireLib(40)
									 .requireInt(60)
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
		ImprovedSelfControl.requireLib(60)
						   .requireInt(90)
						   .requirePerk(HalfStepToImprovedSelfControl)
						   .requireLevel(12);
		Transference.requirePerk(JobEromancer)
					.requireLevel(12)
					.requireLib(50)
					.requireStatusEffect(StatusEffects.KnowsArouse, "Arouse spell");
		JobCourtesan.requirePerk(JobSeducer)
					.requirePerk(Heroism)
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
		HalfStepToAdvancedSelfControl.requireLib(80)
									 .requireInt(120)
									 .requirePerk(ImprovedSelfControl)
									 .requireLevel(18);
		ColdLust.requirePerk(Lustzerker)
				.requirePerk(ImprovedSelfControl)
				.requireLib(75)
				.requireLevel(18);
		ArouseTheAudience.requirePerk(JobCourtesan)
						 .requireLib(75)
						 .requireLevel(18);
		//Tier 4 Libido Perks
		AdvancedSelfControl.requireLib(100)
						   .requireInt(150)
						   .requirePerk(HalfStepToAdvancedSelfControl)
						   .requireLevel(24);
		CriticalPerformance.requirePerk(JobCourtesan)
						   .requireLib(100)
						   .requireLevel(24);
		//Tier 5 Libido Perks
		HalfStepToSuperiorSelfControl.requireLib(120)
									 .requireInt(180)
									 .requirePerk(AdvancedSelfControl)
									 .requireLevel(30);
		//Tier 6 Libido Perks
		SuperiorSelfControl.requireLib(140)
						   .requireInt(210)
						   .requirePerk(HalfStepToSuperiorSelfControl)
						   .requireLevel(36);
		//Tier 7 Libido Perks
		HalfStepToPeerlessSelfControl.requireLib(160)
									 .requireInt(240)
									 .requirePerk(SuperiorSelfControl)
									 .requireLevel(42);
		//Tier 8 Libido Perks
		PeerlessSelfControl.requireLib(180)
						   .requireInt(270)
						   .requirePerk(HalfStepToPeerlessSelfControl)
						   .requireLevel(48);
		//------------
		// SENSITIVITY
		//------------
		//Slot 6 - Tier 0
		EyesOfTheHunterNovice.requireSen(25);
		//Tier 1
		EyesOfTheHunterAdept.requireSen(50)
							.requirePerk(EyesOfTheHunterNovice)
							.requireLevel(6);
		//Tier 2
		EyesOfTheHunterMaster.requireSen(75)
							 .requirePerk(EyesOfTheHunterAdept)
							 .requireLevel(12);
		//Tier 3
		//------------
		// CORRUPTION
		//------------
		//Slot 7 - Corrupted Libido - lust raises 10% slower.
		CorruptedLibido.requireCor(25);
		CorruptedLibido.defaultValue1 = 20;
		//Slot 7 - Seduction (Must have seduced Jojo)
		Seduction.requireCor(50);
		//Slot 7 - Nymphomania
		Nymphomania.requireCor(75)
				   .requirePerk(CorruptedLibido);
		//Slot 7 - UNFINISHED :3
		Acclimation.requireCor(50)
				   .requirePerk(CorruptedLibido)
				   .requireMinLust(20);
		//Tier 1 Corruption Perks - acclimation over-rides
		Sadist.requireCor(60)
			  .requirePerk(CorruptedLibido)
			  .requireLevel(6);
		ArousingAura.requireCor(70)
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
		BlackHeart.requirePerk(DarkCharm).requireCor(90).requireCustomFunction(function (player:Player):Boolean {
			return player.demonScore() >= 6;
		}, "Demon race");
		CatlikeNimbleness.requirePerk(Flexibility).requireCustomFunction(function (player:Player):Boolean {
			return player.catScore() >= 4;
		}, "Cat race");
		DraconicLungs.requirePerk(DragonFireBreath)
					 .requirePerk(DragonIceBreath)
					 .requirePerk(DragonLightningBreath)
					 .requirePerk(DragonDarknessBreath).requireCustomFunction(function (player:Player):Boolean {
			return player.dragonScore() >= 4;
		}, "Dragon race");
		GorgonsEyes.requireCustomFunction(function (player:Player):Boolean {
			return player.gorgonScore() >= 5 && player.eyeType == 4
		}, "Gorgon race and eyes");
		KitsuneThyroidGland.requireAnyPerk(EnlightenedKitsune, CorruptedKitsune).requireCustomFunction(function (player:Player):Boolean {
			return player.kitsuneScore() >= 5;
		}, "Kitsune race");
		LizanMarrow.requirePerk(LizanRegeneration).requireCustomFunction(function (player:Player):Boolean {
				return player.lizardScore() >= 4
			}, "Lizan race");
		ManticoreMetabolism.requireCustomFunction(function (player:Player):Boolean {
			return player.manticoreScore() >= 10 && player.tailType == Creature.TAIL_TYPE_MANTICORE_PUSSYTAIL
		}, "Manticore race and tail");
		MantislikeAgility.requirePerk(TrachealSystem).requireCustomFunction(function (player:Player):Boolean {
			return player.mantisScore() >= 6
		}, "Mantis race");
		SalamanderAdrenalGlands.requirePerk(Lustzerker).requireCustomFunction(function (player:Player):Boolean {
			return player.salamanderScore() >= 4
		}, "Salamander race");
		ScyllaInkGlands.requirePerk(InkSpray).requireCustomFunction(function (player:Player):Boolean {
			return player.scyllaScore() >= 5
		}, "Scylla race");
		TrachealSystem.requireCustomFunction(function (player:Player):Boolean {
			return player.beeScore() >= 4 || player.mantisScore() >= 4 || player.scorpionScore() >= 4 || player.spiderScore() >= 4;
		}, "Any insect race");
		/*
		 if (player.() >=  && ) {
		 _add(new PerkClass(PerkLib.));
		 }
		 if (player.() >=  && ) {
		 _add(new PerkClass(PerkLib.));
		 }
		 Phoenix Thorax czy jakiś inny związany z morphami perk ub coś związane z gardłem - dla ras mogących używać ultradźwieki jako atak lub kogoś typu banshee atak wyciem

		 Perk związany z mieśniami

		 Perk związany ze skórą

		 Perk związany z układem nerwowym

		 Perk związany z koścmi

		 if (flags[kFLAGS.HUNGER_ENABLED] > 0 && game.player.humanScore() < 5) {
		 _add(new PerkClass(PerkLib.)); - zelazny zoladek czy cos w tym stylu
		 }
		 */
		Metamorph.requirePerk(GeneticMemory);
	//	JobArtificer.requireInt(25)
	//				.requireWis(25);
		JobBeastWarrior.requireStr(25)
					   .requireTou(25)
					   .requireSpe(25);
		//Tier 1
		ResistanceI.requireLevel(6);
		Heroism.requireLevel(6);
		DualWield.requireLevel(6);
		Survivalist.requireLevel(6)
				   .requireHungerEnabled();
		ResistanceII.requirePerk(ResistanceI)
					.requireLevel(8)
					.requireNGPlus(1);
		ResistanceIII.requirePerk(ResistanceII)
					 .requireLevel(10)
					 .requireNGPlus(2);
		ChimericalBodyInitialStage.requireLevel(6)
								  .requireCustomFunction(function (player:Player):Boolean {
			return player.internalChimeraScore() >= 1;
		}, "Any racial perk");
		TrachealSystemEvolved.requireLevel(6).requirePerk(TrachealSystem).requireCustomFunction(function (player:Player):Boolean {
			return player.beeScore() >= 8 || player.mantisScore() >= 8 || player.scorpionScore() >= 8 || player.spiderScore() >= 8;
		}, "Any insect race");
		JobGolemancer.requireLevel(6)
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
		//Tier 2
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
		ChimericalBodyBasicStage.requirePerk(ChimericalBodyInitialStage)
								.requireLevel(12)
								.requireCustomFunction(function (player:Player):Boolean {
				return player.internalChimeraScore() >= 3;
			}, "Three racial perks");
		Whirlwind.requireLevel(12)
				 .requirePerk(JobBarbarian);
		Whipping.requireLevel(12)
				.requirePerk(JobEromancer);
		DraconicLungsEvolved.requireLevel(12).requirePerk(DraconicLungs).requireCustomFunction(function (player:Player):Boolean {
			return player.dragonScore() >= 10;
		}, "Dragon race");
		KitsuneThyroidGlandEvolved.requireLevel(12)
								  .requirePerk(KitsuneThyroidGland)
								  .requireAnyPerk(EnlightenedKitsune, CorruptedKitsune).requireCustomFunction(function (player:Player):Boolean {
			return player.kitsuneScore() >= 6;
		}, "Kitsune race");
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
		//Tier 3
		ChimericalBodyAdvancedStage.requirePerk(ChimericalBodyBasicStage)
								   .requireLevel(18)
								   .requireCustomFunction(function (player:Player):Boolean {
				return player.internalChimeraScore() >= 6;
			}, "Six racial perks");
		JobWarlord.requireAnyPerk(Whirlwind, Whipping)
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
		//Tier 4
		JobAllRounder.requireLevel(24)
					 .requirePerk(JobGuardian)
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
					 .requireLib(45);
	//	if(player.internalChimeraScore() >= 10 && requirePerk(ChimericalBodyAdvancedStage)) {
	//		ChimericalBodyPerfectStage;
	//	}
		Tornado.requireLevel(24)
			   .requireStr(75)
			   .requireTou(75)
			   .requirePerk(JobWarlord);
		CycloneStage2.requireLevel(24)
					 .requireStr(70)
					 .requireTou(70)
					 .requirePerk(CycloneStage1);
	//	.requireLevel(24)
	//				.requireInt(40)
	//				.requireWis(40)
	//				.requirePerk(JobGolemancer);//perk for making permanent golem
		GiantsReach.requireLevel(24)
				   .requireStr(100)
				   .requireTou(100)
				   .requirePerk(JobWarlord);
		EnableCriticals.requireLevel(24);
		//Tier 5
		//	if (requireMinLevel(30)) {
		//		if (player.internalChimeraScore() >= 15 && requirePerk(ChimericalBodyPerfectStage)) {
		//			ChimericalBodyUltimateStage;
		//		}
/*		DeityJobMunchkin.requirePerk(JobMonk)
				   .requirePerk(JobKnight)
				   .requirePerk(JobHunter)
				   .requirePerk(JobEromancer)
				   .requirePerk(JobEnchanter)
				   .requirePerk(JobDervish)
				   .requirePerk(JobDefender)
				   .requirePerk(JobBarbarian)
				   .requirePerk(JobAllRounder)
				   .requireStr(150)
				   .requireTou(150)
				   .requireSpe(150)
				   .requireInt(150)
				   .requireWis(150)
				   .requireLib(90); //requirePerk(JobEromancer)
*/		//(Still need some other related stuff added to make PC true Munchkin
		//na razie jest perk GreyMage, potrzeba jeszcze pare innych perków tak z 3-5 innych jeszcze)
		CycloneStage3.requireLevel(30)
					 .requireStr(90)
					 .requireTou(90)
					 .requirePerk(CycloneStage2);
		//Tier 6
		CycloneStage4.requireLevel(36)
					 .requireStr(120)
					 .requireTou(120)
					 .requirePerk(CycloneStage3);
		//Tier 7
		CycloneStage5.requireLevel(42)
					 .requireStr(160)
					 .requireTou(160)
					 .requirePerk(CycloneStage4);
	}
	try {
		initDependencies();
	} catch (e:Error) {
		trace(e.getStackTrace());
	}
}
}
