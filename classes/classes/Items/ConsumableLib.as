/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
import classes.BaseContent;
import classes.EngineCore;
import classes.Items.Consumables.*;
import classes.Player;
import classes.Scenes.SceneLib;
import classes.CoC;

public final class ConsumableLib extends BaseContent
	{
		//public var consumableItems:Array = [];

		public static const DEFAULT_VALUE:Number = 6;

		//DEMONIC POTIONS
		//Tainted
		public const INCUBID:SimpleConsumable = mk("IncubiD", "IncubiD", "an Incubi draft", 6, "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers.  A stylized picture of a humanoid with a huge penis is etched into the glass.", curry(m.incubiDraft, true));
		public const S_DREAM:SimpleConsumable = mk("S.Dream", "S.Dream", "a bottle of 'Succubus' Dream'", 6, "This precious fluid is often given to men a succubus intends to play with for a long time, though this batch has been enhanced by Lumi to have even greater potency.", m.succubisDream);
		public const SDELITE:SimpleConsumable = mk("SDelite", "S.Delite", "a bottle of 'Succubi's Delight'", 6, "This precious fluid is often given to men a succubus intends to play with for a long time.", curry(m.succubisDelight, true));
		public const SUCMILK:SimpleConsumable = mk("SucMilk", "SucMilk", "a bottle of Succubi milk", 6, "This milk-bottle is filled to the brim with a creamy white milk of dubious origin.  A pink label proudly labels it as \"<i>Succubi Milk</i>\".  In small text at the bottom of the label it reads: \"<i>To bring out the succubus in YOU!</i>\"", curry(m.succubiMilk, true));
		//Untainted
		public const P_DRAFT:SimpleConsumable = mk("P.Draft", "P.Draft", "an untainted Incubi draft", 20, "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers.  A stylized picture of a humanoid with a huge penis is etched into the glass. Rathazul has purified this to prevent corruption upon use.", curry(m.incubiDraft, false));
		public const P_S_MLK:SimpleConsumable = mk("P.S.Mlk", "P.S.Mlk", "an untainted bottle of Succubi milk", 20, "This milk-bottle is filled to the brim with a creamy white milk of dubious origin.  A pink label proudly labels it as \"<i>Succubi Milk</i>\".  In small text at the bottom of the label it reads: \"<i>To bring out the succubus in YOU!</i>\"  Purified by Rathazul to prevent corruption.", curry(m.succubiMilk, false));
		public const PSDELIT:SimpleConsumable = mk("PSDelit", "PSDelit", "an untainted bottle of \"Succubi's Delight\"", 20, "This precious fluid is often given to men a succubus intends to play with for a long time.  It has been partially purified by Rathazul to prevent corruption.", curry(m.succubisDelight, false));

		//DYES
		public const AUBURND:HairDye = new HairDye("AuburnD", "Auburn",	DEFAULT_VALUE);
		public const BLACK_D:HairDye = new HairDye("Black D", "Black",	DEFAULT_VALUE);
		public const BLOND_D:HairDye = new HairDye("Blond D", "Blond",	DEFAULT_VALUE);
		public const BLUEDYE:HairDye = new HairDye("BlueDye", "Blue",	DEFAULT_VALUE);
		public const BROWN_D:HairDye = new HairDye("Brown D", "Brown",	DEFAULT_VALUE);
		public const GRAYDYE:HairDye = new HairDye("GrayDye", "Gray",	DEFAULT_VALUE);
		public const GREEN_D:HairDye = new HairDye("Green D", "Green",	DEFAULT_VALUE);
		public const ORANGDY:HairDye = new HairDye("OrangDy", "Orange",	DEFAULT_VALUE);
		public const PINKDYE:HairDye = new HairDye("PinkDye", "Pink",	DEFAULT_VALUE);
		public const PURPDYE:HairDye = new HairDye("PurpDye", "Purple",	DEFAULT_VALUE);
		public const RAINDYE:HairDye = new HairDye("RainDye", "Rainbow", 100);
		public const RED_DYE:HairDye = new HairDye("Red Dye", "Red",	DEFAULT_VALUE);
		public const WHITEDY:HairDye = new HairDye("WhiteDy", "White",	DEFAULT_VALUE);
		public const RUSSDYE:HairDye = new HairDye("RussetD", "Russet",	DEFAULT_VALUE);

		//SKIN OILS & BODY LOTIONS
		public const DARK_OL:SkinOil = new SkinOil("DarkOil", "Dark");
		public const EBONYOL:SkinOil = new SkinOil("EbonyOl", "Ebony");
		public const FAIR_OL:SkinOil = new SkinOil("FairOil", "Fair");
		public const LIGHTOL:SkinOil = new SkinOil("LightOl", "Light");
		public const MAHOGOL:SkinOil = new SkinOil("MahogOl", "Mahogany");
		public const OLIVEOL:SkinOil = new SkinOil("OliveOl", "Olive");
		public const RUSS_OL:SkinOil = new SkinOil("RussOil", "Russet");
		public const TAN_OIL:SkinOil = new SkinOil("Tan Oil", "Tan");

		public const CLEARLN:BodyLotion = new BodyLotion("ClearLn", "Clear", "smooth thick creamy liquid");
		public const ROUGHLN:BodyLotion = new BodyLotion("RoughLn", "Rough", "thick abrasive cream");
		public const SEXY_LN:BodyLotion = new BodyLotion("SexyLtn", "Sexy", "pretty cream like substance");
		public const SMTH_LN:BodyLotion = new BodyLotion("SmthLtn", "Smooth", "smooth thick creamy liquid");

		//EGGS
		//Small
		public const BLACKEG:SimpleConsumable = mk("BlackEg", "BlackEg", "a rubbery black egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.blackRubberEgg, false));
		public const BLUEEGG:SimpleConsumable = mk("BlueEgg", "BlueEgg", "a blue and white mottled egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.blueEgg, false));
		public const BROWNEG:SimpleConsumable = mk("BrownEg", "BrownEg", "a brown and white mottled egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.brownEgg, false));
		public const PINKEGG:SimpleConsumable = mk("PinkEgg", "PinkEgg", "a pink and white mottled egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.pinkEgg, false));
		public const PURPLEG:SimpleConsumable = mk("PurplEg", "PurplEg", "a purple and white mottled egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.purpleEgg, false));
		public const WHITEEG:SimpleConsumable = mk("WhiteEg", "WhiteEg", "a milky-white egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance.  Something tells you it's more than just food.", curry(m.whiteEgg, false));
		//Large
		public const L_BLKEG:SimpleConsumable = mk("L.BlkEg", "L.BlkEg", "a large rubbery black egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.  For all you know, it could turn you into rubber!", curry(m.blackRubberEgg, true));
		public const L_BLUEG:SimpleConsumable = mk("L.BluEg", "L.BluEg", "a large blue and white mottled egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.blueEgg, true));
		public const L_BRNEG:SimpleConsumable = mk("L.BrnEg", "L.BrnEg", "a large brown and white mottled egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.brownEgg, true));
		public const L_PNKEG:SimpleConsumable = mk("L.PnkEg", "L.PnkEg", "a large pink and white mottled egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.pinkEgg, true));
		public const L_PRPEG:SimpleConsumable = mk("L.PrpEg", "L.PrpEg", "a large purple and white mottled egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.purpleEgg, true));
		public const L_WHTEG:SimpleConsumable = mk("L.WhtEg", "L.WhtEg", "a large white egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance.  Something tells you it's more than just food.", curry(m.whiteEgg, true));
		//Others
		public const DRGNEGG:SimpleConsumable = mk("DrgnEgg", "DrgnEgg", "an unfertilized dragon egg", 6, "A large, solid egg, easily the size of your clenched fist.  Its shell color is reddish-white, with blue splotches.", m.eatEmberEgg);
		public const NPNKEGG:SimpleConsumable = mk("NPnkEgg", "NPnkEgg", "a neon pink egg", 6, "This is an oblong egg with an unnatural neon pink coloration.  It tingles in your hand with odd energies that make you feel as if you could jump straight into the sky.", curry(m.neonPinkEgg, false));

		//FOOD & BEVERAGES
        public const BC_BEER:SimpleConsumable = mk("BC Beer", "BC Beer", "a mug of Black Cat Beer", 1, "A capped mug containing an alcoholic drink secreted from the breasts of Niamh.  It smells tasty.", function (player:Player):void {
            SceneLib.telAdre.niamh.blackCatBeerEffects(player)
        });
        public const BHMTCUM:SimpleConsumable = mk("BhmtCum", "BhmtCum", "a sealed bottle of behemoth cum", 15, "This bottle of behemoth cum looks thick and viscous.  You suspect that it might boost your strength and toughness.  It also has delicious taste.", m.behemothCum);
        public const BIMBOCH:SimpleConsumable = mk("BimboCh", "BimboCh", "a bottle of bimbo champagne", 20, "A bottle of bimbo champagne. Drinking this might incur temporary bimbofication.", curry(function (player:Player):void {
            SceneLib.telAdre.niamh.bimboChampagne(player, true, true)
        }));
        public const C_BREAD:CumBread         = new CumBread();
		public const CCUPCAK:SimpleConsumable = mk("CCupcak", "CCupcak", "a gigantic, chocolate cupcake", 250, "A gigantic, chocolate cupcake. You could easily get full from eating this!", m.giantChocolateCupcake);
		public const FISHFIL:SimpleConsumable = mk("FishFil", "FishFil", "a fish fillet", 10, "A perfectly cooked piece of fish.  You're not sure what type of fish is, since you're fairly certain \"delicious\" is not a valid species.", m.fishFillet);
		public const FREFISH:SimpleConsumable = mk("FreFish", "FreshFish", "a fresh fish", 6, "A fish freshly caugh from the waters of mareth.", m.freshFish);
		public const FR_BEER:SimpleConsumable = mk("Fr Beer", "Fr Beer", "a mug of frothy beer", 6, "A bottle of beer from The Black Cock.", m.frothyBeer);
		public const GODMEAD:SimpleConsumable = mk("GodMead", "GodMead", "a pint of god's mead", 6, "A horn of potent, honey-colored mead. A single whiff makes your head swim and your thoughts turn to violence and heroism.", m.godMead);
		public const H_BISCU:SimpleConsumable = mk("H.Bisct", "H.Biscuits", "a pack of hard biscuits", 5, "These biscuits are tasteless, but they can stay edible for an exceedingly long time.", m.hardBiscuits);
		public const IZYMILK:SimpleConsumable = mk("IzyMilk", "IzyMilk", "a bottle of Isabella's milk", 6, "This is a bottle of Isabella's milk.  Isabella seems fairly certain it will invigorate you.", m.isabellaMilk);
		public const M__MILK:SimpleConsumable = mk("M. Milk", "M. Milk", "a clear bottle of milk from Marble", 6, "A clear bottle of milk from Marble's breasts. It smells delicious.", m.useMarbleMilk);
		public const MINOCUM:SimpleConsumable = mk("MinoCum", "MinoCum", "a sealed bottle of minotaur cum", 60, "This bottle of minotaur cum looks thick and viscous.  You know it has narcotic properties, but aside from that its effects are relatively unknown.", curry(m.minotaurCum, false));
		public const P_BREAD:SimpleConsumable = mk("P.Bread", "P.Bread", "a stale loaf of prison bread", 6, "An impossibly hard loaf of stale bread.  Despite its age, still quite nutritious.", m.prisonBread);
		public const P_M_CUM:SimpleConsumable = mk("P.M.Cum", "P.MinoCum", "a sealed bottle of purified minotaur cum", 80, "This bottle of minotaur cum looks thick and viscous.  You know it has narcotic properties, but aside from that its effects are relatively unknown.  This bottle of cum has been purified to prevent corruption and addiction.", curry(m.minotaurCum, true));
		public const P_WHSKY:PhoukaWhiskey    = new PhoukaWhiskey();
		public const PROMEAD:SimpleConsumable = mk("ProMead", "ProMead", "a pint of premium god's mead", 6, null, m.proMead);
		public const PURPEAC:SimpleConsumable = mk("PurPeac", "PurPeac", "a pure peach", 10, "This is a peach from Minerva's spring, yellowy-orange with red stripes all over it.", m.purityPeach);
		public const SHEEPMK:SimpleConsumable = mk("SheepMk", "SheepMk", "a bottle of sheep milk", 6, "This bottle of sheep milk is said to have corruption-fighting properties.  It may be useful.", m.sheepMilk);
		public const S_WATER:SimpleConsumable = mk("S.Water", "SpringWtr", "a waterskin filled with spring water", 6, "A waterskin full of purified water from Minerva's spring.  It's clean and clear, with a faint sweet scent to it.  You're sure it would be a very refreshing drink.", m.springWater);
		public const TRAILMX:SimpleConsumable = mk("TrailMx", "Trail Mix", "a pack of trail mix", 20, "This mix of nuts, dried fruits and berries is lightweight, easy to store and very nutritious.", m.trailMix);
		public const URTACUM:SimpleConsumable = mk("UrtaCum", "UrtaCum", "a sealed bottle of Urta's cum", 15, "This bottle of Urta's cum looks thick and viscous.  It's quite delicious.", m.urtaCum);
		public const W_PDDNG:SimpleConsumable = mk("W.Pddng", "W.Pudding", "a slice of winter pudding", 35, "A slice of delicious Winter Pudding.  It smells delicious. \n\nNote: Eating this might cause antlers to grow from your head.", m.winterPudding);

		//GROWERS/SHRINKERS
		public const REDUCTO:Consumable = new Reducto();
		public const GROPLUS:Consumable = new GroPlus();

		//MAGIC BOOKS
		public const B__BOOK:SimpleConsumable = mk("B. Book", "B. Book", "a small book with a midnight-black cover", 40, "This solid black book is totally unmarked, saved for a blood red clasp that holds the covers closed until you are ready to read it.  The pages are edged with gold, like some of the fancy books in the monastary back home.", m.blackSpellbook);
		public const G__BOOK:SimpleConsumable = mk("G. Book", "G. Book", "a small book with a ash-grey cover", 200, "This grey book is totally unmarked, and on the cover is wrote few words that seems have no meaning or maybe you just aren't able to decipher them yet. A plain green clasp keeps the covers closed until you are ready to read it.", m.greySpellbook);
		public const W__BOOK:SimpleConsumable = mk("W. Book", "W. Book", "a small book with a pristine white cover", 40, "This white book is totally unmarked, and the cover is devoid of any lettering or title.  A shiny brass clasp keeps the covers closed until you are ready to read it.", m.whiteSpellbook);

		//MANA POTIONS
		public const VDARCON:SimpleConsumable = mk("VDARCON", "V.D.ARC", "a very diluted Arcane Regen Concotion", 8, "This very diluted concotion could help you recover some of the spent mana.  Naturaly it won't be much but in tight situation it could make a difference between won or lost fight.", m.verydilutedarcaneregenconcotion);
		public const D_ARCON:SimpleConsumable = mk("D_ARCON", "Dil.ARC", "a diluted Arcane Regen Concotion", 48, "This diluted concotion could help you recover some of the spent mana.  It won't be much but still a few more time more than after using very diluted concotion.", m.dilutedarcaneregenconcotion);

		//MAGIC STORAGE
		public const BAGOCOS:SimpleConsumable = mk("BagOCos", "BagOfCosmos", "a Bag of Cosmos", 1200, "It's small bag used by Soul Cultivtors covered with a complex symbols making it object that allow to store many more things that the size of itself would indicate.", m.bagofcosmos);
		public const SPPEARL:SimpleConsumable = mk("SPPearl", "SkyPoisonPearl", "a Sky Poison Pearl", 12000, "Mysterious Pearl.", m.skypoisonpearl);//moze jednak zmniejszyc do 6k tylko - 60 slotow po 200 gems kazdy wart = 12k

		//PILLS
		public const LG_SFRP:SimpleConsumable = mk("LGSFRP", "LGSFRPill", "a low-grade Soulforce Recovery Pill", 5, "This low-grade recovery pill could help you recover some of the spent soulforce.  Naturaly it won't be much but in tight situation it could make a difference between won or lost fight.", m.lowgradesoulforcerecoverypill);
		public const MG_SFRP:SimpleConsumable = mk("MGSFRP", "MGSFRPill", "a mid-grade Soulforce Recovery Pill", 30, "This mid-grade recovery pill could help you recover some of the spent soulforce.  It won't be much but still a few more time more than after using low-grade one version of this pill.", m.midgradesoulforcerecoverypill);
		public const HG_SFRP:SimpleConsumable = mk("HGSFRP", "HGSFRPill", "a high-grade Soulforce Recovery Pill", 180, "This high-grade recovery pill could hep you recover some of the spent soulforce.  It can restore significant amount of soulforce compared to lower grade pills but still it's only an aid not a replacement for regular cultivation.", m.highgradesoulforcerecoverypill);
		//public const SG_SFRP:SimpleConsumable = mk("SGSFRP", "SuperiorGradeSFRecovPill", "a superior-grade Soulforce Recovery Pill", m.superiorgradesoulforcerecoverypill, "This superior-grade recovery pill could hep you recover some of the spent soulforce.  Best possible to obtain pill to fast recover soulforce in tight situations when you not have time to cultivate.", 1080);

		//SOUL SKILLS MANUALS
		public const TRITMAN:SimpleConsumable = mk("TRITMAN", "TTManual", "a manual for Triple Thrust Soulskill", 50, "This manual would teach you how to use Triple Thrust soulskill.", m.triplethrustmanual);
		public const MABIMAN:SimpleConsumable = mk("MABIMAN", "MBManual", "a manual for Many Birds Soulskill", 50, "This manual would teach you how to use Many Birds soulskill.", m.manybirdsmanual);
		public const DRASMAN:SimpleConsumable = mk("DRASMAN", "DSManual", "a manual for Draco Sweep Soulskill", 50, "This manual would teach you how to use Draco Sweep soulskill.", m.dracosweepmanual);
		public const COMETMA:SimpleConsumable = mk("COMETMA", "COManual", "a manual for Comet Soulskill", 250, "This manual would teach you how to use Comet soulskill.", m.cometmanual);
		public const VPTRMAN:SimpleConsumable = mk("VPTRMAN", "VPTManual", "a manual for Violet Pupil Transformation Soulskill", 250, "This manual would teach you how to use Violet Pupil Transformation soulskill.", m.violetpupiltransformationmanual);
		public const SOBLMAN:SimpleConsumable = mk("SOBLMAN", "SOBLManual", "a manual for Soul Blast Soulskill", 1000, "This manual would teach you how to use Soul Blast soulskill.", m.soulblastmanual);
	/*	public const XXXXMAN:SimpleConsumable = mk("MAN", "Manual", "", x, ".", m.xxx);
		public const XXXXMAN:SimpleConsumable = mk("MAN", "Manual", "", x, ".", m.xxx);
		public const XXXXMAN:SimpleConsumable = mk("MAN", "Manual", "", x, ".", m.xxx);*/

		//RARE ITEMS (Permanent effects, gives perks on consumption.)
		public const BIMBOLQ:BimboLiqueur = new BimboLiqueur();
		public const BROBREW:SimpleConsumable = mk("BroBrew", "BroBrew", "a can of Bro Brew", 1000, "This aluminum can is labelled as 'Bro Brew'.  It even has a picture of a muscly, bare-chested man flexing on it.  A small label in the corner displays: \"Demon General's Warning: Bro Brew's effects are as potent (and irreversible) as they are refreshing.", m.broBrew);
		public const HUMMUS2:SimpleConsumable = mk("Hummus2", "S.Hummus", "a blob of cheesy-looking super hummus", 6, "This pile of hummus doesn't look that clean, and you really don't remember where you got it from.  It looks bland.  So bland that you feel blander just by looking at it.", m.superHummus);
		public const P_PEARL:SimpleConsumable = mk("P.Pearl", "P.Pearl", "a pure pearl", 1000, "Marae gave you this pure pearl as a reward for shutting down the demonic factory.", m.purePearl);
		public const EZEKFRU:SimpleConsumable = mk("EzekFru", "EzekielFruit", "a simple looking fruit", 300, "Evangeline gave you this fruit as means of showing her gratitude.", m.ezekielfruit);
		public const E3PEARL:SimpleConsumable = mk("E3Pearl", "Elemen3CPearl", "a simple looking three-colored pearl", 200, "Pearl formed after defeating group of golems. It's surrounded by faint aura of elements.", m.lowgradeelementalPearl);
		public const E_PEARL:SimpleConsumable = mk("E5Pearl", "Elemen5CPearl", "a simple looking five-colored pearl", 400, "Pearl formed after defeating . It's surrounded by weak aura of elements.", m.middlegradeelementalPearl);
		public const E7PEARL:SimpleConsumable = mk("E7Pearl", "Elemen7CPearl", "a simple looking seven-colored pearl", 800, "Pearl formed after defeating . It's surrounded by aura of elements.", m.highgradeelementalPearl);

		//NON-TRANSFORMATIVE ITEMS
		public const AGILI_E:SimpleConsumable = mk("Agil.E.", "Agility E.", "an agility elixir", 6, "This greenish elixir is supposed to increase the user’s natural swiftness and agility.", m.agilityElixir);
		public const AKBALSL:Consumable = new AkbalSaliva();
		public const BANGB_M:MiniBangBall = new MiniBangBall();
		//public const BANGBM1:BngBall = new BangBll();//BangBall mark 1 - nastpne powinny mieć coś ala mk 2 itd. nazwy w kodzie :P
		public const C__MINT:Consumable = new Mint();
		public const CERUL_P:Consumable = new CeruleanPotion();
		public const COAL___:Consumable = new Coal();
	//	public const DAO_DEW:SimpleConsumable = mk("Dao Dew", "Dao Dew", "a cup of vixen tea", 15, "An exotic tea made by kitsunes. This herbal infusion is rumored to improve your expertise and expand your sexual knowledge.", m.daoDew);
		public const DEBIMBO:DeBimbo = new DeBimbo();
		public const EXTSERM:HairExtensionSerum = new HairExtensionSerum();
		public const F_DRAFT:SimpleConsumable = mk("F.Draft", "FuckDraft", "a vial of roiling red fluid labeled \"Fuck Draft\"", 6, "This vial of red fluid bubbles constantly inside the glass, as if eager to escape.  It smells very strongly, though its odor is difficult to identify.  The word \"Fuck\" is inscribed on the side of the vial.", curry(m.lustDraft, true));
		public const INCOINS:SimpleConsumable = mk("incOIns", "incenOfIns", "an incense of Insight", 15, "These sticks, when burned, are rumored to fill an area with an incense that allows for deep meditation and granting greater insight.", m.incenseOfInsight);
		public const H_PILL:Consumable = new HealPill();
		public const HRBCNT:Consumable = new HerbalContraceptive();
		public const ICICLE_:Consumable = new IceShard();
		public const KITGIFT:KitsuneGift		= new KitsuneGift();
		public const L_DRAFT:SimpleConsumable = mk("L.Draft", "LustDraft", "a vial of roiling bubble-gum pink fluid", 20, "This vial of bright pink fluid bubbles constantly inside the glass, as if eager to escape.  It smells very sweet, and has \"Lust\" inscribed on the side of the vial.", curry(m.lustDraft, false));
		public const LACTAID:Consumable = new Lactaid();
		public const LUSTSTK:LustStick        = new LustStick();
		public const MANUP_B:SimpleConsumable = mk("ManUp B", "ManUp B.", "a ManUp beer", 6, "A beverage made for people who believe brawn is better than brains.", m.manUpBeer);
		public const MILKPTN:Consumable = new MilkPotion();
		public const NUMBROX:Consumable = new NumbRocks();
		public const NUMBOIL:Consumable = new NumbingOil();
		public const OVIELIX:OvipositionElixir = new OvipositionElixir();
        public const PEPPWHT:SimpleConsumable = mk("PeppWht", "PeppWht", "a vial of peppermint white", 120, "This tightly corked glass bottle gives of a pepperminty smell and reminds you of the winter holidays.  How odd.", function (player:Player):void {
            EngineCore.clearOutput();
            EngineCore.outputText("You pull the cork off the gift from the mysterious stranger.  The scent of alluring mint fills your nose once again.  You bring the head of the bottle to your lips and tip it back, the creamy white fluid hits your tongue and slips down your throat.  The liquid is surprisingly refreshing, the creamy mint flavor clings to your tongue and mouth, and makes your breath feel cool as you exhale over your lips.  You can feel the liquid drip down to your stomach and fill you with a pleasant warmth and holiday cheer.\n\n");
            //Recovers health and fatigue, adds five to max health, and one to libido.*/
            EngineCore.HPChange(EngineCore.maxHP(),true);
            EngineCore.fatigue(-100);
        });
        public const PPHILTR:Consumable = new PurityPhilter();
		public const PRNPKR :Consumable = new PrincessPucker();
		public const SENSDRF:Consumable = new SensitivityDraft();
		public const SMART_T:Consumable = new ScholarsTea();
		public const VITAL_T:Consumable = new VitalityTincture();
		public const VIXEN_T:SimpleConsumable = mk("Vixen T", "Vixen T.", "a cup of vixen tea", 15, "An exotic tea made by kitsunes. This herbal infusion is rumored to improve your expertise and expand your sexual knowledge.", m.vixenTea);
		public const W_STICK:WingStick = new WingStick();
		//Aqua Seed - prawdopodobnie nazwa dla Siren TF ; Bubble Lemonade - nazwa dla Dark Slime TF
		//TRANSFORMATIVE ITEMS
		public const ABYSSIN:SimpleConsumable = mk("AbyssIn", "AbyssalInk", "a vial of abyssal ink", 10, "Pitch black ink normaly used for writing consuming this doesnt seem like the best idea.", curry(m.scyllaInk, 3));
		public const ALICORN:AbstractEquinum = new AbstractEquinum(2, "Alicorn", "Alicornum", "a vial of Alicornum", 200, "This is a long flared vial with a small label that reads, \"<i>Alicornum</i>\".  It is likely this potion is tied to alicorns in some way.");
		public const ENIGMANIUM:Enigmanium = new Enigmanium();
		public const AQUSEED:SimpleConsumable = mk("AquSeed", "AquaSeed", "an aqua seed", 20, "This seed looks and smells absolutely delicious.  Though it has an unusual color, the harpies prize these nuts as delicious treats.  Eating one might induce some physical transformations.", curry(m.goldenSeed, 0));
		public const B_GOSSR:SimpleConsumable = mk("B.Gossr", "B.Gossr", "a bundle of black, gossamer webbing", 6, "These strands of gooey black gossamer seem quite unlike the normal silk that driders produce.  It smells sweet and is clearly edible, but who knows what it might do to you?", curry(m.sweetGossamer, 1));
		public const BEEHONY:BeeHoney         = new BeeHoney(false, false);
		public const BLACKIN:SimpleConsumable = mk("BlackIn", "BlackInk", "a vial of black ink", 10, "Pitch black ink normaly used for writing consuming this doesnt seem like the best idea.", curry(m.scyllaInk, 0));
		public const BLACKPP:SimpleConsumable = mk("BlackPp", "BlackPp", "a solid black canine pepper", 10, "This solid black canine pepper is smooth and shiny, but something about it doesn't seem quite right...", curry(m.caninePepper, 3));
		public const BLADEGR:SimpleConsumable = mk("BladeGr", "BladeGrass", "a blade shaped grass", 6, "A form of herb normaly infused in samurai and other warrior tea.  You think infusing this unprocessed item in your tea could result in interesting result.", m.bladeGrass);
		public const BOARTRU:SimpleConsumable = mk("BoarTru", "BoarTruffle", "a boar truffle", 6, "It’s clear where the pigtail truffle gets its name.  A small, curly sprig resembling a pig’s tail can be seen jutting out of it. Now that it’s been enhanced by Lumi, it’s larger and fuzzier than it was before, almost like a peach.", curry(m.pigTruffle, true));
		public const BULBYPP:SimpleConsumable = mk("BulbyPp", "BulbyPp", "a bulbous pepper", 10, "This bulbous pepper has a slightly different shape than the other canine peppers, with two large orb-like protrusions at the base.", curry(m.caninePepper, 5));
		public const CANINEP:SimpleConsumable = mk("CanineP", "CanineP", "a Canine pepper", 6, "The pepper is shiny and red, bulbous at the base but long and narrow at the tip.  It smells spicy.", curry(m.caninePepper, 0));
		public const CENTARI:Centaurinum = new Centaurinum();
		public const CHILLYP:SimpleConsumable = mk("ChillyP", "ChillyPp", "a Chilly pepper", 10, "This pepper is positively shrouded with a thin layer of ice.", m.chillyPepper);
		public const COUAOIL:SimpleConsumable = mk("CouaOil", "CouatlOil", "a vial of couatl oil", 20, "A vial the size of your fist made of dark blue glass. It contains what appears to be an oily, red liquid. The odor is strange.", curry(m.evolvedNagaOil, 2));
		public const DBLPEPP:SimpleConsumable = mk("DblPepp", "DblPepp", "a double canine pepper", 10, "This canine pepper is actually two that have grown together due to some freak coincidence.", curry(m.caninePepper, 2));
		public const DRAKHRT:SimpleConsumable = mk("DrakHrt", "DrakeHeart", "a drake's heart's flower", 50, "A rare, beautiful flower.  It could make an exquisite perfume.  According to a legend, dragons give this flower to the ones they intend to court.", curry(m.drakeHeart));
		public const DRYTENT:SimpleConsumable = mk("DryTent", "DryTent", "a shriveled tentacle", 6, "A dried tentacle from one of the lake anemones.  It's probably edible, but the stingers are still a little active.", m.shriveledTentacle);
		public const ECTOPLS:SimpleConsumable = mk("EctoPls", "EctoPls", "a bottle of ectoplasm", 6, "The green-tinted, hardly corporeal substance flows like a liquid inside its container. It makes you feel... uncomfortable, as you observe it.", m.ectoplasm);
		public const ELFEARS:SimpleConsumable = mk("ElfEars", "ElfEars", "a Fae ear shaped plant", 6, "A plant that looks like a pointed Fae ear. Upon further inspection, the plant is very delicate and seems to radiate some sort of magical energy.", m.elfears);
		public const EQUINUM:AbstractEquinum = new AbstractEquinum(0, "Equinum", "Equinum", "a vial of Equinum", 6, "This is a long flared vial with a small label that reads, \"<i>Equinum</i>\".  It is likely this potion is tied to horses in some way.");
		public const FOXBERY:SimpleConsumable = mk("FoxBery", "Fox Berry", "a fox berry", 6, "This large orange berry is heavy in your hands.  It may have gotten its name from its bright orange coloration.  You're certain it is no mere fruit.", curry(m.foxTF, false));
		public const FRRTFRT:SimpleConsumable = mk("Frrtfrt", "FerretFrt", "a ferret fruit", 6, "This fruit is curved oddly, just like the tree it came from.  The skin is fuzzy and brown, like the skin of a peach.", m.ferretTF);
		public const FOXJEWL:SimpleConsumable = mk("FoxJewl", "Fox Jewel", "a fox jewel", 50, "A shining teardrop-shaped jewel.  An eerie blue flame dances beneath the surface.", curry(m.foxJewel, false));
		public const GLDRIND:GoldenRind       = new GoldenRind();
		public const GORGOIL:SimpleConsumable = mk("GorgOil", "GorgonOil", "a vial of gorgon oil", 20, "A vial the size of your fist made of dark green glass. It contains what appears to be oily, greenish liquid. The odor is foul.", curry(m.evolvedNagaOil, 0));
		public const GREYINK:SimpleConsumable = mk("GreyInk", "GreyInk", "a vial of grey ink", 30, "Ash grey ink normaly used for writing consuming this doesnt seem like the best idea.", curry(m.scyllaInk, 1));
		public const GLDSEED:SimpleConsumable = mk("GldSeed", "GoldenSeed", "a golden seed", 6, "This seed looks and smells absolutely delicious.  Though it has an unusual color, the harpies prize these nuts as delicious treats.  Eating one might induce some physical transformations.", curry(m.goldenSeed, 0));
		public const GOB_ALE:SimpleConsumable = mk("Gob.Ale", "Gob.Ale", "a flagon of potent goblin ale", 6, "This sealed flagon of 'Goblin Ale' sloshes noisily with alcoholic brew.  Judging by the markings on the flagon, it's a VERY strong drink, and not to be trifled with.", m.goblinAle);
		public const HUMMUS_:SimpleConsumable = mk("Hummus ", "Hummus", "a blob of cheesy-looking hummus", 100, "This pile of hummus doesn't look that clean.  It looks bland.  So bland that you feel blander just by looking at it.", m.regularHummus);
		public const IMPFOOD:SimpleConsumable = mk("ImpFood", "ImpFood", "a parcel of imp food", 6, "This is a small parcel of reddish-brown bread stuffed with some kind of meat.  It smells delicious.", m.impFood);
		public const INFWINE:SimpleConsumable = mk("InfWine", "InfWine", "a bottle of infernal wine", 500, "This drink is made from satyr wine, incubus draft, and succubus milk. It reeks of corruption. Are you sure it would be a smart idea to drink this?", m.infernalWine);
		public const JABBERS:SimpleConsumable = mk("JabberS", "JabberS", "a Jabberwocky scale", 100, "A scale of the so called rabbit dragon. It emits a faint glow of residual magic but are you sure you should be eating this?", m.jabberwockyScale);
		public const KANGAFT:SimpleConsumable = mk("KangaFt", "KangaFruit", "a piece of kanga fruit", 6, "A yellow, fibrous, tubular pod.  A split in the end reveals many lumpy, small seeds inside.  The smell of mild fermentation wafts from them.", curry(m.kangaFruit, 0));
		public const KNOTTYP:SimpleConsumable = mk("KnottyP", "KnottyP", "a knotty canine pepper", 10, "This knotted pepper is very swollen, with a massive, distended knot near the base.", curry(m.caninePepper, 4));
		public const LABOVA_:SimpleConsumable = mk("LaBova ", "La Bova", "a bottle containing a misty fluid labeled \"LaBova\"", 6, "A bottle containing a misty fluid with a grainy texture, it has a long neck and a ball-like base.  The label has a stylized picture of a well endowed cowgirl nursing two guys while they jerk themselves off.", curry(m.laBova, true, false));
		public const LARGEPP:SimpleConsumable = mk("LargePp", "LargePp", "an overly large canine pepper", 10, "This large canine pepper is much bigger than any normal peppers you've seen.", curry(m.caninePepper, 1));
		public const MAGSEED:SimpleConsumable = mk("MagSeed", "MagSeed", "a magically-enhanced golden seed", 6, "This seed glows with power.  It's been enhanced by Lumi to unlock its full potential, allowing it to transform you more easily.", curry(m.goldenSeed, 1));
		public const MARAFRU:MaraFruit = new MaraFruit();
		public const MANTICV:ManticoreVenom = new ManticoreVenom();
		public const MGHTYVG:SimpleConsumable = mk("MghtyVg", "MghtyVg", "a mightily enhanced piece of kanga fruit", 6, "A yellow, fibrous, tubular pod.  A split in the end reveals many lumpy, small seeds inside.  The smell of mild fermentation wafts from them.  It glows slightly from Lumi's enhancements.", curry(m.kangaFruit, 1));
		public const MOUSECO:SimpleConsumable = mk("MouseCo", "MouseCo", "a handful of mouse cocoa", 6, "A handful of rare aromatic beans with sharp creases in the middle, making them look like small mouse ears.  Allegedly very popular and plentiful before the mice-folk were wiped out.", m.mouseCocoa);
		public const MINOBLO:MinotaurBlood = new MinotaurBlood();
		public const MYSTJWL:SimpleConsumable = mk("MystJwl", "MystJwl", "a mystic jewel", 50, "The flames within this jewel glow brighter than before, and have taken on a sinister purple hue.  It has been enhanced to increase its potency, allowing it to transform you more easily, but may have odd side-effects...", curry(m.foxJewel, true));
		public const NOCELIQ:SimpleConsumable = mk("NoceLiq", "NocelloLiq", "a bottle of Nocello Liquer", 20, "This bottle contain sweet liquer called 'Nocello', which one sip can makes your stomach feel warm even in middle of glacial rift.  It looks to be just hazelnut flavored alcohol or there is more to it?", m.nocelloliquer);
		public const ONISAKE:OnikiriSake = new OnikiriSake();
		public const ORCASUN:SimpleConsumable = mk("OrcaSun", "OrcaSunscr", "a bottle of Orca Sunscreen", 6, "A very ordinary looking bottle of sunscreen, with a whale girl in swimwear labeled 'Orca subscreen'.", m.orcaSunscreen);
		public const P_LBOVA:SimpleConsumable = mk("P.LBova", "P.LBova", "a bottle containing a white fluid labeled \"Pure LaBova\"", 6, "A bottle containing a misty fluid with a grainy texture; it has a long neck and a ball-like base.  The label has a stylized picture of a well-endowed cow-girl nursing two guys while they jerk themselves off. It has been purified by Rathazul.", curry(m.laBova, false, false));
		public const PIGTRUF:SimpleConsumable = mk("PigTruf", "PigTruffle", "a pigtail truffle", 6, "It’s clear where this fungus gets its name.  A small, curly sprig resembling a pig’s tail can be seen jutting out of it.", curry(m.pigTruffle, false));
		public const PRFRUIT:SimpleConsumable = mk("PrFruit", "PrFruit", "a purple fruit", 6, "This sweet-smelling produce looks like an eggplant, but feels almost squishy, and rubbery to the touch. Holding it to your ear, you think you can hear some fluid sloshing around inside.", m.purpleFruitEssrayle);
		public const PROBOVA:SimpleConsumable = mk("ProBova", "ProBova", "a bottle containing a misty fluid labeled \"ProBova\"", 6, "This cloudy potion has been enhanced by the alchemist Lumi to imbue its drinker with cow-like attributes.", curry(m.laBova, true, true));
		public const PURHONY:BeeHoney			= new BeeHoney(true, false);
		public const RDRROOT:SimpleConsumable = mk("RdRRoot", "R.R.Root", "a red river root", 14, "A long, odd shaped root. It smells spicy but surprisingly tasty. Eating it would supposedly alter your body in unknown ways.", m.redRiverRoot);
		public const REDVIAL:VampireBlood = new VampireBlood();
		public const REPTLUM:SimpleConsumable = mk("Reptlum", "Reptilum", "a vial of Reptilum", 6, "This is a rounded bottle with a small label that reads, \"<i>Reptilum</i>\".  It is likely this potion is tied to reptiles in some way.", m.reptilum);
		public const RINGFIG:SimpleConsumable = mk("RingFig", "RingFig", "a ringtail fig", 6, "A dried fig with two lobes and thin dark rings just below its stem.  The skin is wrinkly and it looks vaguely like a bulging scrotum.", m.ringtailFig);
		public const RIZZART:RizzaRoot			= new RizzaRoot();
		public const S_GOSSR:SimpleConsumable = mk("S.Gossr", "S.Gossr", "a bundle of pink, gossamer webbing", 6, "These strands of gooey pink gossamer seem quite unlike the normal silk that spider-morphs produce.  It smells sweet and is clearly edible, but who knows what it might do to you?", curry(m.sweetGossamer, 0));
		public const SALAMFW:SimpleConsumable = mk("SalamFW", "SalamFW", "a hip flask of Salamander Firewater", 6, "This hip flask contain high-proof beverage called 'Salamander Firewater', which one sip can makes your throat feel like it been set on fire.  What whould happen if you drink whole flask content?", m.salamanderfirewater);
		public const SATYR_W:SatyrWine        = new SatyrWine();
		public const SCORICO:Scorpinum = new Scorpinum();
		public const SHARK_T:SimpleConsumable = mk("Shark.T", "Shark.T", "a sharp shark tooth", 6, "A glinting white tooth, very sharp and intimidating.", curry(m.sharkTooth, 0));
		public const SKYSEED:SimpleConsumable = mk("SkySeed", "SkybornSeed", "a skybornn seed", 10, "A smallish, ovular nut-like fruit, with a hard greenish-blue shell that gives off a pleasant aroma.", curry(m.skybornSeed, 0));
		public const SNAKOIL:SimpleConsumable = mk("SnakOil", "SnakeOil", "a vial of snake oil", 6, "A vial the size of your fist made of dark brown glass. It contains what appears to be an oily, yellowish liquid. The odor is abominable.", m.snakeOil);
		public const SPHONEY:Consumable		  = new BeeHoney(false, true);
		public const TRAPOIL:SimpleConsumable = mk("TrapOil", "TrapOil", "a vial of trap oil", 6, "A round, opaque glass vial filled with a clear, viscous fluid.  It has a symbol inscribed on it, a circle with a cross and arrow pointing out of it in opposite directions.  It looks and smells entirely innocuous.", m.trapOil);
		public const TSCROLL:TatteredScroll = new TatteredScroll();
		public const TSTOOTH:SimpleConsumable = mk("TSTooth", "TSTooth", "a glowing tiger shark tooth", 6, "This looks like a normal shark tooth, though with an odd purple glow.", curry(m.sharkTooth, 1));
		public const UNICORN:AbstractEquinum = new AbstractEquinum(1, "Unicorn", "Unicornum", "a vial of Unicornum", 40, "This is a long flared vial with a small label that reads, \"<i>Unicornum</i>\".  It is likely this potion is tied to unicorns in some way.");
		public const VAMPBLD:VampireBlood = new VampireBlood(true);
		public const VIXVIGR:SimpleConsumable = mk("VixVigr", "VixVigr", "a bottle labelled \"Vixen's Vigor\"", 30, "This small medicine bottle contains something called \"Vixen's Vigor\", supposedly distilled from common fox-berries.  It is supposed to be a great deal more potent, and a small warning label warns of \"extra boobs\", whatever that means.", curry(m.foxTF, true));
		public const VOLTTOP:SimpleConsumable = mk("VoltTop", "VoltTopaz", "a Voltage topaz", 6, "This glittering jewel sparkles with a wondrous light. With such beauty, it would probably fetch a fair amount of gems in various markets. A faint static tingle warms your [hands] as a light flush travels up your arms...", curry(m.voltageTopaz, true));
		public const VOUIOIL:SimpleConsumable = mk("VouiOil", "VouivreOil", "a vial of vouivre oil", 70, "A vial the size of your fist made of light green glass. It contains what appears to be an oily, purple liquid. The odor is strange.", curry(m.evolvedNagaOil, 1));
		public const W_FRUIT:SimpleConsumable = mk("W.Fruit", "W.Fruit", "a piece of whisker-fruit", 6, "This small, peach-sized fruit has tiny whisker-like protrusions growing from the sides.", curry(m.catTransformation, 0));
		public const WOFRUIT:SimpleConsumable = mk("WoFruit", "WonderFruit", "a Wonder fruit", 10, "A strange whisker fruit from what appears to be a different dimension. Its skin is dyed with all the color of the rainbow.", curry(m.catTransformation, 2));
	//	public const W_FRUIT:SimpleConsumable = mk("W.Fruit", "W.Fruit", "a piece of whisker-fruit", 10, "Nekomanta TF item", curry(m.catTransformation, 1));
		public const WETCLTH:SimpleConsumable = mk("WetClth", "WetCloth", "a wet cloth dripping with slippery slime", 6, "Dripping with a viscous slime, you've no doubt rubbing this cloth on your body would have some kind of strange effect.", m.gooGasmic);
		public const WHITEIN:SimpleConsumable = mk("WhiteIn", "WhiteInk", "a vial of white ink", 50, "Pearly white ink normaly used for writing consuming this doesnt seem like the best idea.", curry(m.scyllaInk, 2));
		//Wolf Pepper chyba jest nieużywanym itemem ale jesli jednak gdzie byl uzyty zostawie go nie wycietego a w przyszłosci zrobic z niego prawdziwy wolf TF ^^
		public const WOLF_PP:SimpleConsumable = mk("Wolf Pp", "WolfPepper", "a Wolf pepper", 10, "The pepper is shiny and black, bulbous at the base but long and narrow at the tip.  It has a fuzzy feel to it and it smells spicy.", curry(m.caninePepper, 6));
		public const YETICUM:SimpleConsumable = mk("YetiCum", "YetiCum", "a bottle of Yeti Cum", 6, "This looks like some cum from a yeti. It looks potent and you can’t help but ponder about its effect.", m.yetiCum);

		public const LARGE_EGGS:Array = [L_BLKEG,L_BLUEG,L_BRNEG,L_PNKEG,L_PRPEG,L_WHTEG];
		public const SMALL_EGGS:Array = [BLACKEG,BLUEEGG,BROWNEG,PINKEGG,PURPLEG,WHITEEG];
		private var mutations:Mutations;

		/**
		 * A handy function to create SimpleConsumables (useable by any player, effect is a function accepting player:Player,
		 * shortName, longName, description and value are const)
		 * @param id id. Must be String 7 chars long
		 * @param shortName shortName, null to use id as shortName
		 * @param longName null to use shortName as longName
		 * @param description null to use longName as description
		 * @param effect function(player:Player) called to produce effect
		 */
		private static function mk(id:String, shortName:String, longName:String, value:Number, description:String, effect:Function):SimpleConsumable {
			return new SimpleConsumable(id, shortName, longName, effect, value, description);
		}
		private function get m():Mutations{
			if (mutations == null) {
				mutations = new Mutations();
			}
			return mutations;
		}
		public function ConsumableLib()
		{
		}
	}
}
