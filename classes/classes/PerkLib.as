/**
 * Created by aimozg on 26.01.14.
 */
package classes
{
	public class PerkLib
	{

		// UNSORTED perks TODO
		public static const Brawler:PerkType = mk("Brawler","Brawler", "");
		public static const Focused:PerkType = mk("Focused","Focused", "");

		// Player creation perks
		public static const Fast:PerkType = mk("Fast","Fast", "Gain speed 25% faster.");
		public static const Lusty:PerkType = mk("Lusty","Lusty", "Gain lust 25% faster.");
		public static const Sensitive:PerkType = mk("Sensitive","Sensitive", "Gain sensitivity 25% faster.");
		public static const Smart:PerkType = mk("Smart","Smart", "Gain intelligence 25% faster.");
		public static const Strong:PerkType = mk("Strong","Strong", "Gain strength 25% faster.");
		public static const Tough:PerkType = mk("Tough","Tough", "Gain toughness 25% faster.");
		// Female creation perks
		public static const BigClit:PerkType = mk("Big Clit","Big Clit", "Allows your clit to grow larger faster.");
		public static const BigTits:PerkType = mk("Big Tits","Big Tits", "Makes your tits grow larger more easily.");
		public static const Fertile:PerkType = mk("Fertile","Fertile", "Makes you 15% more likely to become pregnant.");
		public static const WetPussy:PerkType = mk("Wet Pussy","Wet Pussy", "Keeps your pussy from ever being anything less than wet.");
		// Male creation perks
		public static const BigCock:PerkType = mk("Big Cock","Big Cock", "Gain cock size 25% faster and grow larger easier.");
		public static const MessyOrgasms:PerkType = mk("Messy Orgasms","Messy Orgasms", "Produces 50% more cum volume.");

		// History perks
		public static const HistoryAlchemist:PerkType = mk("History: Alchemist","History: Alchemist", "");
		public static const HistoryFighter:PerkType = mk("History: Fighter","History: Fighter", "");
		public static const HistoryHealer:PerkType = mk("History: Healer","History: Healer", "");
		public static const HistoryReligious:PerkType = mk("History: Religious","History: Religious", "");
		public static const HistoryScholar:PerkType = mk("History: Scholar","History: Scholar", "");
		public static const HistorySlacker:PerkType = mk("History: Slacker","History: Slacker", "");
		public static const HistorySlut:PerkType = mk("History: Slut","History: Slut", "");
		public static const HistorySmith:PerkType = mk("History: Smith","History: Smith", "");
		public static const HistoryWhore:PerkType = mk("History: Whote","History: Whote", "");

		// Ordinary perks
		public static const Acclimation:PerkType = mk("Acclimation","Acclimation", "Reduces the rate at which your lust increases.");
		public static const Agility:PerkType = mk("Agility","Agility", "When wearing light or medium armor its effectiveness is increased by a portion of your speed.");
		public static const Archmage:PerkType = mk("Archmage","Archmage", "");
		public static const ArousingAura:PerkType = mk("Arousing Aura","Arousing Aura", "While your corruption is at or above 70, you exude an aura of lust.");
		public static const Berzerker:PerkType = mk("Berzerker","Berzerker", "");
		public static const BrutalBlows:PerkType = mk("Brutal Blows","Brutal Blows", "");
		public static const Channeling:PerkType = mk("Channeling","Channeling", "You've gotten even better at spellcasting, gaining up to 50% more effectiveness!");
		public static const CorruptedLibido:PerkType = mk("Corrupted Libido","Corrupted Libido", "Reduces lust gain by 10%.");
		public static const DoubleAttack:PerkType = mk("Double Attack","Double Attack", "Allows you to perform two melee attacks per round.");
		public static const Evade:PerkType = mk("Evade","Evade", "Increases avoidance chances.");
		public static const FertilityPlus:PerkType = mk("Fertility+","Fertility+", "Increases pregnancy chance by 15% and cum volume by up to 50%.");
		public static const HotBlooded:PerkType = mk("Hot Blooded","Hot Blooded", "Raises minimum lust by up to 20.");
		public static const ImmovableObject:PerkType = mk("ImmovableObject","ImmovableObject", "");
		public static const IronMan:PerkType = mk("Iron Man","Iron Man", "Now now, don't cheat.");
		public static const LightningStrikes:PerkType = mk("Lightning Strikes","Lightning Strikes", "");
		public static const LungingAttacks:PerkType = mk("Lunging Attacks","Lunging Attacks", "");
		public static const Mage:PerkType = mk("Mage","Mage", "Increases the strength of your spells even more than 'Spellpower', up to 100%.");
		public static const Masochist:PerkType = mk("Masochist","Masochist", "You have a masochism fetish and take 30 percent less damage, but your lust goes up when struck (Requires 60+ Libido).");
		public static const Medicine:PerkType = mk("Medicine","Medicine", "You now have a 15% chance per round of cleansing poisons/drugs from your body.");
		public static const Nymphomania:PerkType = mk("Nymphomania","Nymphomania", "Raises minimum lust by up to 30.");
		public static const Precision:PerkType = mk("Precision","Precision", "Reduces enemy damage resistance by 10.");
		public static const Regeneration:PerkType = mk("Regeneration","Regeneration", "Regenerates 2% of max HP/hour and 1% of max HP/round.");
		public static const Regeneration2:PerkType = mk("Regeneration 2","Regeneration 2", "You regenerate an additional 2% of max HP per round and heal faster out of combat (4% of max HP/hour)");
		public static const Resistance:PerkType = mk("Resistance","Resistance", "You've become resistant to the myriad ways your lust can be increased.");
		public static const Resolute:PerkType = mk("Resolute","Resolute", "");
		public static const Runner:PerkType = mk("Runner","Runner", "Increases chances of escaping combat.");
		public static const Sadist:PerkType = mk("Sadist","Sadist", "You have a sadism fetish and strike harder, but become aroused by the act of dealing damage.");
		public static const Seduction:PerkType = mk("Seduction","Seduction", "Upgrades your tease attack, making it more effective.");
		public static const SpeedyRecovery:PerkType = mk("Speedy Recovery","Speedy Recovery", "Thanks to your impressive metabolism you regain fatigue 50% faster.");
		public static const Spellpower:PerkType = mk("Spellpower","Spellpower", "Increases the effects of your spells by up to 50%.");
		public static const StrongBack:PerkType = mk("Strong Back","Strong Back", "Enables fourth item slot.");
		public static const StrongBack2:PerkType = mk("Strong Back 2: Strong Harder","Strong Back 2: Strong Harder", "Enables fifth item slot.");
		public static const Tactician:PerkType = mk("Tactician","Tactician", "");
		public static const Tank:PerkType = mk("Tank","Tank", "Raises max HP by 50.");
		public static const Tank2:PerkType = mk("Tank 2","Tank 2", "Your maximum HP is raised by an extra 1 point per point of toughness!");
		public static const ThunderousStrikes:PerkType = mk("Thunderous Strikes","Thunderous Strikes", "+20% 'Attack' damage while strength is at or above 80.");
		public static const WeaponMastery:PerkType = mk("Weapon Mastery","Weapon Mastery", "After getting so good at carrying large objects, you find large weapons much easier to handle (Double 'Large' weapon bonuses when equipped).");
		public static const WellAdjusted:PerkType = mk("Well Adjusted","Well Adjusted", "You gain half as much lust as time passes in Mareth.");

		// Needlework perks
		public static const ChiReflowAttack:PerkType = mk("Chi Reflow - Attack","Chi Reflow - Attack", "Regular attacks boosted, but damage resistance decreased.");
		public static const ChiReflowDefense:PerkType = mk("Chi Reflow - Defense","Chi Reflow - Defense", "Passive damage resistance, but caps speed");
		public static const ChiReflowLust:PerkType = mk("Chi Reflow - Lust","Chi Reflow - Lust", "Lust resistance and Tease are enhanced, but Libido and Sensitivity gains increased.");
		public static const ChiReflowMagic:PerkType = mk("Chi Reflow - Magic","Chi Reflow - Magic", "Magic attacks boosted, but regular attacks are weaker.");
		public static const ChiReflowSpeed:PerkType = mk("Chi Reflow - Speed","Chi Reflow - Speed", "Speed reductions are halved but caps strength");

		// Piercing perks
		public static const PiercedCrimstone:PerkType = mk("Pierced: Crimstone","Pierced: Crimstone", "You've been pierced with Crimstone and your lust seems to stay a bit higher than before.");
		public static const PiercedFertite:PerkType = mk("Pierced: Fertite","Pierced: Fertite", "You've been pierced with Fertite and any male or female organs have become more fertile.");
		public static const PiercedFurrite:PerkType = mk("Pierced: Furrite","Pierced: Furrite", "You've been pierced with Furrite and are more attractive to those who are part beast.");
		public static const PiercedLethite:PerkType = mk("Pierced: Lethite","Pierced: Lethite", "You've been pierced with Lethite and demons are more attracted to you.");

		// Cock sock perks
		public static const LustyRegeneration:PerkType = mk("LustyRegeneration","LustyRegeneration", "");
		public static const MidasCock:PerkType = mk("Midas Cock","Midas Cock", "");
		public static const PentUp:PerkType = mk("Pent Up","Pent Up", "");
		public static const PhallicPotential:PerkType = mk("Phallic Potential","Phallic Potential", "");
		public static const PhallicRestraint:PerkType = mk("Phallic Restraint","Phallic Restraint", "");

		// Armor perks
		public static const BloodMage:PerkType = mk("Blood Mage","Blood Mage","");
		public static const SluttySeduction:PerkType = mk("Slutty Seduction","Slutty Seduction", "Your armor allows you access to 'Seduce', an improved form of 'Tease'.");//TODO desc depends on armor
		public static const WizardsEndurance:PerkType = mk("Wizard's Endurance","Wizard's Endurance", "Your spellcasting equipment makes it harder for spell-casting to fatigue you!");

		// Weapon perks
		public static const WizardsFocus:PerkType = mk("Wizard's Focus","Wizard's Focus", "Your wizard's staff grants you additional focus, reducing the use of fatigue for spells.");//TODO desc depends on weapon

		// Achievement perks
		public static const BroodMother:PerkType = mk("Brood Mother","Brood Mother", "Pregnancy moves twice as fast as a normal woman's.");
		public static const SpellcastingAffinity:PerkType = mk("Spellcasting Affinity","Spellcasting Affinity", "");

		// Mutation perks
		public static const Androgyny:PerkType = mk("Androgyny","Androgyny", "Your face is able to be as masculine or feminine as possible, regardless of gender.");
		public static const BeeOvipositor:PerkType = mk("Bee Ovipositor","Bee Ovipositor", "Allows you to lay eggs in your foes!");
		public static const BimboBody:PerkType = mk("Bimbo Body","Bimbo Body", "You have the body of a bimbo.  Your tits will never stay below a 'DD' cup, you're much lustier, more accustomed to being turned on, and you gain a bonus to using your body to arouse your enemies in combat!");
		public static const BimboBrains:PerkType = mk("Bimbo Brains","Bimbo Brains", "Now that you've drank bimbo liquer, you'll never, like, have the attention span and intelligence you once did!  But it's okay, 'cause you get to be so horny an' stuff!");
		public static const BroBody:PerkType = mk("Bro Body","Bro Body", "You have the body of a muscled, sex-addicted hunk.  Your cock cannot be shorter than 10\", you're much lustier, more accustomed to being turned on, and you gain a bonus to using your body to arouse your enemies in combat!");
		public static const BroBrains:PerkType = mk("Bro Brains","Bro Brains", "After drinking a 'Bro Brew', your maximum capacity for intellect is greatly decreased.");
		public static const BunnyEggs:PerkType = mk("Bunny Eggs","Bunny Eggs", "Laying eggs has become a normal part of your bunny-body's routine.");
		public static const CorruptedNinetails:PerkType = mk("Corrupted Nine-tails","Corrupted Nine-tails", "Grants two magical special attacks.");
		public static const Diapause:PerkType = mk("Diapause","Diapause", "Your marsupial-like body can delay a pregnancy indefinitely, but drinking or otherwise intaking fluids will advance it.");
		public static const Dragonfire:PerkType = mk("Dragonfire","Dragonfire", "");
		public static const EnlightenedNinetails:PerkType = mk("Enlightened Nine-tails","Enlightened Nine-tails", "");
		public static const Feeder:PerkType = mk("Feeder","Feeder", "The LaBova has corrupted your breasts, preventing your lactation from decreasing and giving you an urge to feed it to others.");
		public static const Flexibility:PerkType = mk("Flexibility","Flexibility", "Due to your cat-like body, you're able to dodge attacks more often.");
		public static const FutaFaculties:PerkType = mk("Futa Faculties","Futa Faculties", "");
		public static const FutaForm:PerkType = mk("Futa Form","Futa Form", "");
		public static const HarpyWomb:PerkType = mk("Harpy Womb","Harpy Womb", "So long as you have harpy legs and a harpy tail, your womb will never produce small eggs.");
		public static const Incorporeality:PerkType = mk("Incorporeality","Incorporeality", "You seem to have inherited some of the spiritual powers of the residents of the afterlife!  While you wouldn't consider doing it for long due to its instability, you can temporarily become incorporeal for the sake of taking over enemies and giving them a taste of ghostly libido.");
		public static const MinotaurCumAddict:PerkType = mk("Minotaur Cum Addict","Minotaur Cum Addict", "A hopeless addict to minotaur cum, you need it regularly and can be healed by bottled minotaur cum.");
		public static const Oviposition:PerkType = mk("Oviposition","Oviposition", "Laying eggs has become a normal part of your reptilian body's routine.");
		public static const PurityBlessing:PerkType = mk("Purity Blessing","Purity Blessing", "Reduces the rate at which your corruption, libido, and lust increase.");
		public static const SlimeCore:PerkType = mk("Slime Core","Slime Core", "Moisture craving builds at a greatly reduced rate.");
		public static const SpiderOvipositor:PerkType = mk("Spider Ovipositor","Spider Ovipositor", "Allows you to lay eggs in your foes!");
		public static const ThickSkin:PerkType = mk("Thick Skin","Thick Skin", "Your skin is now tough enough to effectively grant you an extra armor!");

		// Quest, Event & NPC perks
		public static const BasiliskWomb:PerkType = mk("Basilisk Womb","Basilisk Womb", "You can now give birth to female basilisks.");
		public static const BulgeArmor:PerkType = mk("Bulge Armor","Bulge Armor", "Your crotch-hugging armor improves penis-based enticements.");
		public static const Cornucopia:PerkType = mk("Cornucopia","Cornucopia", "Increases vaginal and anal capacities by 30.");
		public static const ElvenBounty:PerkType = mk("Elven Bounty","Elven Bounty", "After your encounter with an elf, her magic has left you with increased fertility.");// TODO description depends on subtype
		public static const FerasBoonAlpha:PerkType = mk("Fera's Boon - Alpha","Fera's Boon - Alpha", "");
		public static const FerasBoonBreedingBitch:PerkType = mk("Fera's Boon - Breeding Bitch","Fera's Boon - Breeding Bitch", "");
		public static const FerasBoonMilkingTwat:PerkType = mk("Fera's Boon - Milking Twat","Fera's Boon - Milking Twat", "");
		public static const FerasBoonSeeder:PerkType = mk("Fera's Boon - Seeder","Fera's Boon - Seeder", "");
		public static const FerasBoonWideOpen:PerkType = mk("Fera's Boon - Wide Open","Fera's Boon - Wide Open", "");
		public static const FireLord:PerkType = mk("Fire Lord","Fire Lord", "Thanks to Akbal's blessings, you're able to breathe gouts of green flame at your foes.");
		public static const Hellfire:PerkType = mk("Hellfire","Hellfire", "You've been gifted with Hellfire for pleasing the master of the hellhounds.");
		public static const LuststickAdapted:PerkType = mk("Luststick Adapted","Luststick Adapted", "Minimum lust is permanently raised, but you are also more lust resistant.  In combat, you're immune to harpy lipstick, though it still gives you a rush during sex.  You can also wear the lipstick yourself.");
		public static const MagicalFertility:PerkType = mk("Magical Fertility","Magical Fertility", "10% higher chance of pregnancy and increased pregnancy speed.");
		public static const MagicalVirility:PerkType = mk("Magical Virility","Magical Virility", "200 mLs more cum per orgasm and enhanced virility.");
		public static const MaraesGiftButtslut:PerkType = mk("Marae's Gift - Buttslut","Marae's Gift - Buttslut","For some reason Marae altered your butthole to make it become wet and slippery when you're aroused.");
		public static const MaraesGiftFertility:PerkType = mk("Marae's Gift - Fertility","Marae's Gift - Fertility","Marae saw fit to 'reward' you for corrupting her by blessing you with unholy fertility!");
		public static const MaraesGiftProfractory:PerkType = mk("Marae's Gift - Profractory","Marae's Gift - Profractory","Marae increased the speed at which your body produces cum, allowing you to build up fluid 3x as fast as a normal person.");
		public static const MaraesGiftStud:PerkType = mk("Marae's Gift - Stud","Marae's Gift - Stud","Marae saw fit to reward you for corrupting her by giving you a higher volume of semen and increasing its potency.");
		public static const MarbleResistant:PerkType = mk("Marble Resistant","Marble Resistant", "You know how to avoid the addictive qualities of Marble's milk.");
		public static const MarblesMilk:PerkType = mk("Marble's Milk","Marble's Milk", "You're totally addicted to Marble's milk and can't live without it.");
		public static const Misdirection:PerkType = mk("Misdirection","Misdirection", "You've learned quite a lot from Raphael, and your training, combined with the bodysuit, makes it easier to avoid attacks.");
		public static const OmnibusGift:PerkType = mk("Omnibus' Gift","Omnibus' Gift", "Raises your minimum lust by up to 35 and slightly reduces lust gain.");
		public static const PilgrimsBounty:PerkType = mk("Pilgrim's Bounty","Pilgrim's Bounty", "Lower lust values no longer reduce the size of your orgasm.");
		public static const Whispered:PerkType = mk("Whispered","Whispered", "Akbal has allowed you to whisper to the minds of your foes, as he does.");

		// Other perks
		public static const OneTrackMind:PerkType = mk("One Track Mind","One Track Mind", "Q-q-quit peaking in my code, desu-chan!");
		public static const PureAndLoving:PerkType = mk("Pure and Loving","Pure and Loving", "Q-q-quit peaking in my code, desu-chan!");
		public static const SensualLover:PerkType = mk("Sensual Lover","Sensual Lover", "Q-q-quit peaking in my code, desu-chan!");

		// Monster perks
		public static const Acid:PerkType = mk("Acid","Acid", "");

		private static function mk(id:String, name:String, desc:String):PerkType
		{
			return new PerkType(id, name, desc);
		}
	}
}
