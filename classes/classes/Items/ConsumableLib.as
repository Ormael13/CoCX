/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumables.*;
import classes.Player;
import classes.Races.*;
import classes.Scenes.SceneLib;

public final class ConsumableLib extends AlchemyLib
	{
		//public var consumableItems:Array = [];

		public static const DEFAULT_VALUE:Number = 6;

		//DEMONIC POTIONS
		//Tainted
		public const INCUBID: Consumable = mk("IncubiD", "IncubiD", "an Incubi draft", 6, "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers.  A stylized picture of a humanoid with a huge penis is etched into the glass.", curry(m.incubiDraft, true), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_DEMON, true),
						[
							[10, AR_CORR_INC],
							[1, AR_INT],
							[1, AR_LIB],
							[1, AR_SENS_INC]
						]);
		public const S_DREAM: Consumable = mk("S.Dream", "S.Dream", "a bottle of 'Succubus' Dream'", 6, "This precious fluid is often given to men a succubus intends to play with for a long time, though this batch has been enhanced by Lumi to have even greater potency.", m.succubusDream, ItemTags.U_TF)
				.refineableInto(
						[
							[1, AS_BALLS]
						], [
							[1, AE_DEMON],
							[1, AE_GROW]
						], [
							[10, AR_CORR_INC]
						]);
		public const SDELITE: Consumable = mk("SDelite", "S.Delite", "a bottle of 'Succubi's Delight'", 6, "This precious fluid is often given to men a succubus intends to play with for a long time.", curry(m.succubisDelight, true), ItemTags.U_TF)
				.refineableInto(
						[
							[1, AS_BALLS]
						], [
							[1, AE_DEMON],
							[1, AE_GROW]
						], [
							[10, AR_CORR_INC]
						]);
		public const SUCMILK: Consumable = mk("SucMilk", "SucMilk", "a bottle of Succubi milk", 6, "This milk-bottle is filled to the brim with a creamy white milk of dubious origin.  A pink label proudly labels it as \"<i>Succubi Milk</i>\".  In small text at the bottom of the label it reads: \"<i>To bring out the succubus in YOU!</i>\"", curry(m.succubiMilk, true), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_DEMON, true),
						[
							[10, AR_CORR_INC],
							[1, AR_INT],
							[1, AR_LIB],
							[1, AR_SPE],
							[1, AR_SENS_INC]
						],
						DemonRace.DemonSkinColors
				);
		//Untainted
		public const P_DRAFT:Consumable = mk("P.Draft", "P.Draft", "an untainted Incubi draft", 20, "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers.  A stylized picture of a humanoid with a huge penis is etched into the glass. Rathazul has purified this to prevent corruption upon use.", curry(m.incubiDraft, false), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_DEMON, true),
						[
							[1, AR_INT],
							[1, AR_LIB],
							[1, AR_SENS_INC]
						]);
		public const P_S_MLK: Consumable = mk("P.S.Mlk", "P.S.Mlk", "an untainted bottle of Succubi milk", 20, "This milk-bottle is filled to the brim with a creamy white milk of dubious origin.  A pink label proudly labels it as \"<i>Succubi Milk</i>\".  In small text at the bottom of the label it reads: \"<i>To bring out the succubus in YOU!</i>\"  Purified by Rathazul to prevent corruption.", curry(m.succubiMilk, false), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_DEMON, true),
						[
							[1, AR_INT],
							[1, AR_LIB],
							[1, AR_SPE],
							[1, AR_SENS_INC]
						],
						DemonRace.DemonSkinColors
				);
		public const PSDELIT: Consumable = mk("PSDelit", "PSDelit", "an untainted bottle of \"Succubi's Delight\"", 20, "This precious fluid is often given to men a succubus intends to play with for a long time.  It has been partially purified by Rathazul to prevent corruption.", curry(m.succubisDelight, false), ItemTags.U_TF)
				.refineableInto(
						[
							[1, AS_BALLS]
						], [
							[1, AE_DEMON],
							[1, AE_GROW]
						]
				);

		//DYES
		public const AUBURND:HairDye = ItemTemplateLib.instance.createHairDye("Auburn", 1);
		public const BLACK_D:HairDye = ItemTemplateLib.instance.createHairDye("Black", 1);
		public const BLOND_D:HairDye = ItemTemplateLib.instance.createHairDye("Blond", 1);
		public const BLUEDYE:HairDye = ItemTemplateLib.instance.createHairDye("Blue", 1);
		public const BROWN_D:HairDye = ItemTemplateLib.instance.createHairDye("Brown", 1);
		public const GRAYDYE:HairDye = ItemTemplateLib.instance.createHairDye("Gray", 1);
		public const GREEN_D:HairDye = ItemTemplateLib.instance.createHairDye("Green", 1);
		public const ORANGDY:HairDye = ItemTemplateLib.instance.createHairDye("Orange", 1);
		public const PINKDYE:HairDye = ItemTemplateLib.instance.createHairDye("Pink", 1);
		public const PURPDYE:HairDye = ItemTemplateLib.instance.createHairDye("Purple", 1);
		public const RAINDYE:HairDye = ItemTemplateLib.instance.createHairDye("Rainbow", 4);
		public const RED_DYE:HairDye = ItemTemplateLib.instance.createHairDye("Red", 1);
		public const WHITEDY:HairDye = ItemTemplateLib.instance.createHairDye("White", 1);
		public const RUSSDYE:HairDye = ItemTemplateLib.instance.createHairDye("Russet", 1);
		public const YELLDYE:HairDye = ItemTemplateLib.instance.createHairDye("Yellow", 1);
		public const GOLDB_D:HairDye = ItemTemplateLib.instance.createHairDye("Golden Blonde", 1);
		public const SNOWW_D:HairDye = ItemTemplateLib.instance.createHairDye("Snow White", 2);
		public const SILVDYE:HairDye = ItemTemplateLib.instance.createHairDye("Silver", 2);
		public const GOLDDYE:HairDye = ItemTemplateLib.instance.createHairDye("Golden", 2);
		public const QWHITED:HairDye = ItemTemplateLib.instance.createHairDye("Quartz White", 3);

		//SKIN OILS & BODY LOTIONS
		public const DARK_OL:SkinOil = ItemTemplateLib.instance.createSkinOil("dark");
		public const EBONYOL:SkinOil = ItemTemplateLib.instance.createSkinOil("ebony");
		public const FAIR_OL:SkinOil = ItemTemplateLib.instance.createSkinOil("fair");
		public const LIGHTOL:SkinOil = ItemTemplateLib.instance.createSkinOil("light");
		public const MAHOGOL:SkinOil = ItemTemplateLib.instance.createSkinOil("mahogany");
		public const OLIVEOL:SkinOil = ItemTemplateLib.instance.createSkinOil("olive");
		public const RUSS_OL:SkinOil = ItemTemplateLib.instance.createSkinOil("russet");
		public const TAN_OIL:SkinOil = ItemTemplateLib.instance.createSkinOil("tan");

		public const CLEARLN:BodyLotion = new BodyLotion("ClearLn", "Clear", "smooth thick creamy liquid");
		public const ROUGHLN:BodyLotion = new BodyLotion("RoughLn", "Rough", "thick abrasive cream");
		public const SEXY_LN:BodyLotion = new BodyLotion("SexyLtn", "Sexy", "pretty cream like substance");
		public const SMTH_LN:BodyLotion = new BodyLotion("SmthLtn", "Smooth", "smooth thick creamy liquid");

		//EGGS
		//Small
		public const BLACKEG: Consumable = mk("BlackEg", "BlackEg(Ltx)", "a rubbery black egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.blackRubberEgg, false));
		public const BLUEEGG: Consumable = mk("BlueEgg", "BlueEgg(-Vg)", "a blue and white mottled egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.blueEgg, false));
		public const BROWNEG: Consumable = mk("BrownEg", "BrownEg(Ass)", "a brown and white mottled egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.brownEgg, false));
		public const PINKEGG: Consumable = mk("PinkEgg", "PinkEgg(-Dk)", "a pink and white mottled egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.pinkEgg, false));
		public const PURPLEG: Consumable = mk("PurplEg", "PurplEg(Hip)", "a purple and white mottled egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.purpleEgg, false));
		public const WHITEEG: Consumable = mk("WhiteEg", "WhiteEg(Nip)", "a milky-white egg", 6, "This is an oblong egg, not much different from a chicken egg in appearance.  Something tells you it's more than just food.", curry(m.whiteEgg, false));
		//Large
		public const L_BLKEG: Consumable = mk("L.BlkEg", "L.BlkEg", "a large rubbery black egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.  For all you know, it could turn you into rubber!", curry(m.blackRubberEgg, true));
		public const L_BLUEG: Consumable = mk("L.BluEg", "L.BluEg", "a large blue and white mottled egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.blueEgg, true));
		public const L_BRNEG: Consumable = mk("L.BrnEg", "L.BrnEg", "a large brown and white mottled egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.brownEgg, true));
		public const L_PNKEG: Consumable = mk("L.PnkEg", "L.PnkEg", "a large pink and white mottled egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.pinkEgg, true));
		public const L_PRPEG: Consumable = mk("L.PrpEg", "L.PrpEg", "a large purple and white mottled egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.", curry(m.purpleEgg, true));
		public const L_WHTEG: Consumable = mk("L.WhtEg", "L.WhtEg", "a large white egg", 6, "This is an oblong egg, not much different from an ostrich egg in appearance.  Something tells you it's more than just food.", curry(m.whiteEgg, true));
		//Others
		public const DRGNEGG: Consumable = mk("DrgnEgg", "DrgnEgg", "an unfertilized dragon egg", 6, "A large, solid egg, easily the size of your clenched fist.  Its shell color is reddish-white, with blue splotches.", m.eatEmberEgg);
		public const NPNKEGG: Consumable = mk("NPnkEgg", "NPnkEgg", "a neon pink egg", 6, "This is an oblong egg with an unnatural neon pink coloration.  It tingles in your hand with odd energies that make you feel as if you could jump straight into the sky.", curry(m.neonPinkEgg, false));

		//FOOD & BEVERAGES
		public const AjidAji: Consumable = mk ("AjidAji", "Aji de Aji", "a bag of Aji de Aji", 6, "A small bag of Aji de Aji Peppers.",function(player:Player):void{SceneLib.trollVillage.elderstore.itemsConsumed("AjidAji")});
        public const BC_BEER: Consumable = mk("BC Beer", "BC Beer", "a mug of Black Cat Beer", 1, "A capped mug containing an alcoholic drink secreted from the breasts of Niamh.  It smells tasty.", function (player:Player):void {
            SceneLib.telAdre.niamh.blackCatBeerEffects(player)
        });
        public const BHMTCUM: Consumable = mk("BhmtCum", "BhmtCum", "a sealed bottle of behemoth cum", 15, "This bottle of behemoth cum looks thick and viscous.  You suspect that it might boost your strength and toughness.  It also has delicious taste.", m.behemothCum);
        public const BIMBOCH: Consumable = mk("BimboCh", "BimboCh", "a bottle of bimbo champagne", 20, "A bottle of bimbo champagne. Drinking this might incur temporary bimbofication.", curry(function (player:Player):void {
            SceneLib.telAdre.niamh.bimboChampagne(player, true, true)
        }));
		public const CHOCBOX: Consumable = mk("ChocBox", "ChocBox", "a box of chocolate", 250, "A box of sweet chocolates. Maybe you can give it to someone you like?", m.boxChocolate);
		public const CCUPCAK: Consumable = mk("CCupcak", "CCupcak", "a gigantic, chocolate cupcake", 250, "A gigantic, chocolate cupcake. You could easily get full from eating this!", m.giantChocolateCupcake);
		public const D_MORAD: Consumable = mk("D_Morad", "D.Morada", "a bag of Dulce Morada", 6, "It appears to be a few purple-colored hard candies. It has the same color as the troll figs.\n",function(player:Player):void{SceneLib.trollVillage.elderstore.itemsConsumed("D.Morada")});
		public const EXCMILK: Consumable = mk("ExcMilk", "ExcMilk", "a bottle of Excellia's milk", 10, "It's a bottle of Excellia's milk. It's guaranteed to restore your body and energy.", m.excelliaMilk);
		public const FISHFIL: Consumable = mk("FishFil", "FishFil", "a fish fillet", 10, "A perfectly cooked piece of fish.  You're not sure what type of fish is, since you're fairly certain \"delicious\" is not a valid species.", m.fishFillet);
		public const FREFISH: Consumable = mk("FreFish", "FreshFish", "a fresh fish", 6, "A fish freshly caugh from the waters of mareth.", m.freshFish);
		public const FR_BEER: Consumable = mk("Fr Beer", "Fr Beer", "a mug of frothy beer", 6, "A bottle of beer from The Black Cock.", m.frothyBeer);
		public const GODMEAD: Consumable = mk("GodMead", "GodMead", "a pint of god's mead", 20, "A horn of potent, honey-colored mead. A single whiff makes your head swim and your thoughts turn to violence and heroism.", m.godMead);
		public const H_BISCU: Consumable = mk("H.Bisct", "H.Biscuits", "a pack of hard biscuits", 5, "These biscuits are tasteless, but they can stay edible for an exceedingly long time.", m.hardBiscuits);
		public const IZYMILK: Consumable = mk("IzyMilk", "IzyMilk", "a bottle of Isabella's milk", 6, "This is a bottle of Isabella's milk.  Isabella seems fairly certain it will invigorate you.", m.isabellaMilk);
		public const M__MILK: Consumable = mk("M. Milk", "M. Milk", "a clear bottle of milk from Marble", 6, "A clear bottle of milk from Marble's breasts. It smells delicious.", m.useMarbleMilk);
		public const MINOCUM: Consumable = mk("MinoCum", "MinoCum", "a sealed bottle of minotaur cum", 60, "This bottle of minotaur cum looks thick and viscous.  You know it has narcotic properties, but aside from that its effects are relatively unknown.", curry(m.minotaurCum, false));
		public const P_M_CUM: Consumable = mk("P.M.Cum", "P.MinoCum", "a sealed bottle of purified minotaur cum", 80, "This bottle of minotaur cum looks thick and viscous.  You know it has narcotic properties, but aside from that its effects are relatively unknown.  This bottle of cum has been purified to prevent corruption and addiction.", curry(m.minotaurCum, true));
		public const P_WHSKY:PhoukaWhiskey    = new PhoukaWhiskey();
		public const PROMEAD: Consumable = mk("ProMead", "ProMead", "a pint of premium god's mead", 200, "A horn of super potent, honey-colored premium mead. A single whiff makes your head swim and your thoughts turn to violence and heroism.", m.proMead);
		public const PURPEAC: Consumable = mk("PurPeac", "PurPeac", "a pure peach", 10, "This is a peach from Minerva's spring, yellowy-orange with red stripes all over it.", m.purityPeach);
		public const SHEEPMK: Consumable = mk("SheepMk", "SheepMk", "a bottle of sheep milk", 30, "This bottle of sheep milk is said to have corruption-fighting properties.  It may be useful.", m.sheepMilk);
		public const S_WATER: Consumable = mk("S.Water", "SpringWtr", "a waterskin filled with spring water", 30, "A waterskin full of purified water from Minerva's spring.  It's clean and clear, with a faint sweet scent to it.  You're sure it would be a very refreshing drink.", m.springWater);
		public const TRAILMX: Consumable = mk("TrailMx", "Trail Mix", "a pack of trail mix", 20, "This mix of nuts, dried fruits and berries is lightweight, easy to store and very nutritious.", m.trailMix);
		public const URTACUM: Consumable = mk("UrtaCum", "UrtaCum", "a sealed bottle of Urta's cum", 15, "This bottle of Urta's cum looks thick and viscous.  It's quite delicious.", m.urtaCum);
		public const W_PDDNG: Consumable = mk("W.Pddng", "W.Pudding", "a slice of winter pudding", 35, "A slice of delicious Winter Pudding.  It smells delicious. \n\nNote: Eating this might cause antlers to grow from your head.", m.winterPudding);
		public const ZENJI_H: Consumable = mk("Zenji H", "ZenjiHunt", "a Zenji's Hunt", 30, "Presumably the seared meat of a smaller creature, a gift from your loving troll.", m.zenjiHunt);
		public const SFILLET: Consumable = mk("SFillet", "S.Fillet", "a Stomiidae fillet", 10, "A fish fillet made of some deep sea fish, while not very big it is packed with nutrition.", m.stomiidaeFillet);
		public const C_STEAK: Consumable = mk("C.Steak", "C.Steak", "a Calamari Steak", 15, "A squid that’s been roasted over a fire, it seems like it would be a decent meal.", m.calamariSteak);
		public const C_JERKY: Consumable = mk("C.Jerky", "C.Jerky", "a Coelacanth Jerky", 5, "A piece of jerky with a bit of extra salt, supposedly it’s from a deep sea fish. It keeps quite well.", m.coelacanthJerky);
		public const SIINGOT: Consumable = mk("SIIngot", "SoftIronIngot", "a Soft Iron Ingot", 70, "An ingot of soft iron, while still hard it should be softer than most metals. (Requires Miracle Metal to use)", m.softIronIngot);
		public const L_B_BAR: Consumable = mk("L.B.Bar", "LightBronzeBar", "a Light Bronze Bar", 120, "An ingot of light bronze, the metallic smell it gives off is quite strong. (Requires Miracle Metal to use)", m.lightBronzeBar);
		public const EAINGOT: Consumable = mk("EAIngot", "EbonbloomAlloyIngot", "a Ebonbloom Alloy Ingot", 200, "A dark gray, metal alloy ingot which supposedly is made with Ebonbloom, you can’t help but drool at the thought of consuming this. (Requires Miracle Metal to use)", m.ebonbloomAlloyIngot);

		//GROWERS/SHRINKERS
		public const REDUCTO:Consumable = new Reducto();
		public const GROPLUS:Consumable = new GroPlus();
		public const LBSPRAY:Consumable = new LubeSpray();
		public const SSPONGE:Consumable = new ShimmeringSponge();

		//MAGIC BOOKS
		public const B__BOOK: Consumable = mk("B. Book", "B. Book", "a small book with a midnight-black cover", 40, "This solid black book is totally unmarked, saved for a blood red clasp that holds the covers closed until you are ready to read it.  The pages are edged with gold, like some of the fancy books in the monastary back home.", m.blackSpellbook);
		public const G__BOOK: Consumable = mk("G. Book", "G. Book", "a small book with a ash-grey cover", 200, "This grey book is totally unmarked, and on the cover is wrote few words that seems have no meaning or maybe you just aren't able to decipher them yet. A plain green clasp keeps the covers closed until you are ready to read it.", m.greySpellbook);
		public const W__BOOK: Consumable = mk("W. Book", "W. Book", "a small book with a pristine white cover", 40, "This white book is totally unmarked, and the cover is devoid of any lettering or title.  A shiny brass clasp keeps the covers closed until you are ready to read it.", m.whiteSpellbook);
		public const RMANUSC: Consumable = mk("R.Manusc", "R. Manuscript", "a Red Manuscript", 50, "This manuscript contains knowledge about blood spells.  There's a faint metallic scent that lingers around it, the unmistakable scent of blood from some creature.", m.redManuscript);
		public const CRIMS_J: Consumable = mk("Crims.J", "Crimson Jade", "a Crimson Jade", 50, "This jade seems to contain knowledge about the usage of blood soulskills. There's a faint metallic scent that lingers around it, the unmistakable scent of blood from some creature.", m.crimsonJade);
		public const POL_MID: Consumable = mk("Pol.Mid", "Pol.Mid.Spell", "a scroll with Polar Midnight spell", 200, "This scroll, wrote down by Alvina Shadowbane, contain knowledge about Polar Midnight spell.", m.blackPolarMidnight);
		public const MET_SHO: Consumable = mk("Met.Sho", "Met.Sho.Spell", "a tome with Meteor Shower spell", 200, "This tome, contain knowledge about Meteor Shower spell.", m.whiteMeteorShower);

		//MANA POTIONS
		public const VDARCON: Consumable = mk("VDARCON", "V.D.ARC", "a very diluted Arcane Regen Concotion", 20, "This very diluted concotion could help you recover some of the spent mana.  Naturaly it won't be much but in tight situation it could make a difference between won or lost fight.", m.verydilutedarcaneregenconcotion);
		public const D_ARCON: Consumable = mk("D_ARCON", "Dil.ARC", "a diluted Arcane Regen Concotion", 120, "This diluted concotion could help you recover some of the spent mana.  It won't be much but still a few more time more than after using very diluted concotion.", m.dilutedarcaneregenconcotion);
		public const AREGCON: Consumable = mk("AREGCON", "ARegCon", "an Arcane Regen Concotion", 720, "This concotion could help you recover some of the spent mana.  It won't be much but still a few more time more than after using diluted concotion.", m.arcaneregenconcotion);

		//MAGIC STORAGES AND LOOT BAGS OF COSMOS
		public const BAGOCOS: Consumable = mk("BagOCos", "BagOfCosmos", "a Bag of Cosmos", 1200, "It's small bag used by Soul Cultivtors covered with a complex symbols making it object that allow to store many more things that the size of itself would indicate.", m.bagofcosmos);
		public const SPPEARL: Consumable = mk("SPPearl", "SkyPoisonPearl", "a Sky Poison Pearl", 12000, "Mysterious Pearl.", m.skypoisonpearl);//moze jednak zmniejszyc do 6k tylko - 60 slotow po 200 gems kazdy wart = 12k
		public const BAGOCA1: Consumable = mk("BagOCA1", "BagOfCosmosA1", "a Bag of Cosmos (A1)", 0, "It's small bag used by enemy Soul Cultivtor to store much more things that the size of itself would indicate. What could be in this one?", m.bagofcosmosA1);
		public const BAGOCA2: Consumable = mk("BagOCA2", "BagOfCosmosA2", "a Bag of Cosmos (A2)", 0, "It's small bag used by enemy Soul Cultivtor to store much more things that the size of itself would indicate. What could be in this one?", m.bagofcosmosA2);
		public const BAGOCA3: Consumable = mk("BagOCA3", "BagOfCosmosA3", "a Bag of Cosmos (A3)", 0, "It's small bag used by enemy Soul Cultivtor to store much more things that the size of itself would indicate. What could be in this one?", m.bagofcosmosA3);
		public const BAGOCA4: Consumable = mk("BagOCA4", "BagOfCosmosA4", "a Bag of Cosmos (A4)", 0, "It's small bag used by enemy Soul Cultivtor to store much more things that the size of itself would indicate. What could be in this one?", m.bagofcosmosA4);
		public const BAGOCA5: Consumable = mk("BagOCA5", "BagOfCosmosA5", "a Bag of Cosmos (A5)", 0, "It's small bag used by enemy Soul Cultivtor to store much more things that the size of itself would indicate. What could be in this one?", m.bagofcosmosA5);
		public const BAGOCA6: Consumable = mk("BagOCA6", "BagOfCosmosA6", "a Bag of Cosmos (A6)", 0, "It's small bag used by enemy Soul Cultivtor to store much more things that the size of itself would indicate. What could be in this one?", m.bagofcosmosA6);

		//PILLS
		public const LG_SFRP: Consumable = mk("LGSFRP", "LGSFRPill", "a low-grade Soulforce Recovery Pill", 10, "This low-grade recovery pill could help you recover some of the spent soulforce.  Naturaly it won't be much but in tight situation it could make a difference between won or lost fight.", m.lowgradesoulforcerecoverypill);
		public const LGSFRPB: Consumable = mk("LGSFRPB", "LGSFRPBottle", "a bottle of low-grade Soulforce Recovery Pills", 110, "Those low-grade recovery pills could help you recover some of the spent soulforce.  Naturaly they won't be much but in tight situation it could make a difference between won or lost fight.", m.lowgradesoulforcerecoverypill2);
		public const MG_SFRP: Consumable = mk("MGSFRP", "MGSFRPill", "a mid-grade Soulforce Recovery Pill", 60, "This mid-grade recovery pill could help you recover some of the spent soulforce.  It won't be much but still a few more time more than after using low-grade one version of this pill.", m.midgradesoulforcerecoverypill);
		public const MGSFRPB: Consumable = mk("MGSFRPB", "MGSFRPBottle", "a bottle of mid-grade Soulforce Recovery Pills", 610, "Those mid-grade recovery pills could help you recover some of the spent soulforce.  They won't be much but still a few more time more than after using low-grade one version of those pills.", m.midgradesoulforcerecoverypill2);
		public const HG_SFRP: Consumable = mk("HGSFRP", "HGSFRPill", "a high-grade Soulforce Recovery Pill", 360, "This high-grade recovery pill could hep you recover some of the spent soulforce.  It can restore significant amount of soulforce compared to lower grade pills but still it's only an aid not a replacement for regular cultivation.", m.highgradesoulforcerecoverypill);
		public const HGSFRPB: Consumable = mk("HGSFRPB", "HGSFRPBottle", "a bottle of high-grade Soulforce Recovery Pills", 3610, "Those high-grade recovery pills could help you recover some of the spent soulforce.  They can restore significant amount of soulforce compared to lower grade pills but still it's only an aid not a replacement for regular cultivation.", m.highgradesoulforcerecoverypill2);
		public const SG_SFRP: Consumable = mk("SGSFRP", "SuperiorGradeSFRecovPill", "a superior-grade Soulforce Recovery Pill", 2160, "This superior-grade recovery pill could hep you recover some of the spent soulforce.  Best possible to obtain pill to fast recover soulforce in tight situations when you don't have time to cultivate.", m.superiorgradesoulforcerecoverypill);
		public const SGSFRPB: Consumable = mk("SGSFRPB", "SGSFRPBottle", "a bottle of superior-grade Soulforce Recovery Pills", 21610, "Those superior-grade recovery pills could help you recover some of the spent soulforce.  Best possible to obtain pills to fast recover soulforce in tight situations when you don't have time to cultivate.", m.superiorgradesoulforcerecoverypill2);
		public const FATPILL: Consumable = mk("FATPILL", "FastingPill", "a Fasting Pill", 100, "This fasting pill could keep you fully/partialy from feeling hunger for a few days.", m.fasteningpill);

		//SOUL SKILLS MANUALS
		public const TRITMAN: Consumable = mk("TRITMAN", "TTManual", "a manual for Triple Thrust Soulskill", 50, "This manual would teach you how to use Triple Thrust soulskill. (Phys)", m.triplethrustmanual);
		public const SEXTMAN: Consumable = mk("SEXTMAN", "STManual", "a manual for Sextuple Thrust Soulskill", 120, "This manual would teach you how to use Sextuple Thrust soulskill. (Phys)", m.sextuplethrustmanual);
		public const NONTMAN: Consumable = mk("NONTMAN", "NTManual", "a manual for Nonuple Thrust Soulskill", 290, "This manual would teach you how to use Nonuple Thrust soulskill. (Phys)", m.nonuplethrustmanual);
		public const MABIMAN: Consumable = mk("MABIMAN", "MBManual", "a manual for Many Birds Soulskill", 50, "This manual would teach you how to use Many Birds soulskill. (Mag)", m.manybirdsmanual);
		public const DRASMAN: Consumable = mk("DRASMAN", "DSManual", "a manual for Draco Sweep Soulskill", 50, "This manual would teach you how to use Draco Sweep soulskill. (Phys)", m.dracosweepmanual);
		public const COMETMA: Consumable = mk("COMETMA", "COManual", "a manual for Comet Soulskill", 200, "This manual would teach you how to use Comet soulskill. (Mag)", m.cometmanual);
		public const VPTRMAN: Consumable = mk("VPTRMAN", "VPTManual", "a manual for Violet Pupil Transformation Soulskill", 200, "This manual would teach you how to use Violet Pupil Transformation soulskill.", m.violetpupiltransformationmanual);
		public const SOBLMAN: Consumable = mk("SOBLMAN", "SOBLManual", "a manual for Soul Blast Soulskill", 1000, "This manual would teach you how to use Soul Blast soulskill. (Phys)", m.soulblastmanual);
		public const FOLBMAN: Consumable = mk("FOLBMAN", "FOLBscManual", "a manual for Flames of Love (Rankless) Soulskill", 50, "This manual would teach you how to use Flames of Love (Rankless) soulskill.", m.flamesoflovemanualrankless);
		public const IOLBMAN: Consumable = mk("IOLBMAN", "IOLBscManual", "a manual for Icicles of Love (Rankless) Soulskill", 50, "This manual would teach you how to use Icicles of Love (Rankless) soulskill.", m.iciclesoflovemanualrankless);
		public const SOSBMAN: Consumable = mk("SOSBMAN", "SOSBscManual", "a manual for Storm of Sisterhood (Rankless) Soulskill", 50, "This manual would teach you how to use Storm of Sisterhood (Rankless) soulskill.", m.stormofsisterhoodmanualrankless);
		public const NOBBMAN: Consumable = mk("NOBBMAN", "NOBBscManual", "a manual for Night of Brotherhood (Rankless) Soulskill", 50, "This manual would teach you how to use Night of Brotherhood (Rankless) soulskill.", m.nightofbrotherhoodmanualrankless);
		public const DEV_MAN: Consumable = mk("DEV_MAN", "DevourManual", "a manual for Devour Soulskill", 50, "This manual would teach you how to use Devour soulskill.", m.devourermanual);
		public const HOB1MAN: Consumable = mk("HOB1MAN", "HoBManual", "a manual for Hail of Blades", 100, "This manual would teach you how to use Hail of Blades soulskill. (Mag)", m.hailofbladesmanual1);
		public const HOB2MAN: Consumable = mk("HOB2MAN", "GHoBManual", "a manual for Grandiose Hail of Blades", 400, "This manual would teach you how to use Grandiose Hail of Blades soulskill. (Mag)", m.hailofbladesmanual2);
		public const HOB3MAN: Consumable = mk("HOB3MAN", "GHoMBManual", "a manual for Grandiose Hail of Moon Blades", 1600, "This manual would teach you how to use Grandiose Hail of Moon Blades soulskill. (Mag)", m.hailofbladesmanual3);
		//public const HOB4MAN: Consumable = mk("HOB4MAN", "Manual", "a manual for Grandiose Hailstorm of Yin-Yang Blades: Endless Tide", x, ".", m.hailofbladesmanual4);secret grandmaster ver of Hail of Blades ^^
		public const CEB_MAN: Consumable = mk("CEB_MAN", "CEBManual", "a manual for Create Element (Basic)", 100, "This manual would teach you how to use Create Element (Basic) soulskill. (Mag)", m.createelementmanual1);
		public const CEA_MAN: Consumable = mk("CEA_MAN", "CEAManual", "a manual for Create Element (Advanced)", 400, "This manual would teach you how to use Create Element (Advanced) soulskill. (Mag)", m.createelementmanual2);
		public const S_B_MAN: Consumable = mk("S_B_MAN", "SoarBManual", "a manual for Soaring Blades passive", 1000, "This manual would teach you Soaring Blades passive.", m.soaringbladesmanual);
		//public const YYB_MAN: Consumable = mk("YYB_MAN", "YYBlastManual", "a manual for Yin Yang Blast", x, "This manual would teach you how to use Yin Yang Blast combination soulskill and it components Yin Palm and Yang Fist soulskills.", m.xxx);
	/*	public const FOLXMAN: Consumable = mk("MAN", "Manual", "a manual for Flames of Love () Soulskill", x, "This manual would teach you how to use Flames of Love (... Rank) soulskill.", m.xxx);
		public const IOLXMAN: Consumable = mk("MAN", "Manual", "a manual for Icicles of Love () Soulskill", x, ".", m.xxx);
		public const SOSXMAN: Consumable = mk("MAN", "Manual", "a manual for Storm of Sisterhood () Soulskill", x, ".", m.xxx);
		public const NOBXMAN: Consumable = mk("MAN", "Manual", "a manual for Night of Brotherhood () Soulskill", x, ".", m.xxx);
		public const XXXXMAN: Consumable = mk("MAN", "Manual", "a manual for ", x, ".", m.xxx);
		public const XXXXMAN: Consumable = mk("MAN", "Manual", "a manual for ", x, ".", m.xxx);
		public const XXXXMAN: Consumable = mk("MAN", "Manual", "a manual for ", x, ".", m.xxx);
		public const XXXXMAN: Consumable = mk("MAN", "Manual", "a manual for ", x, ".", m.xxx);
		public const XXXXMAN: Consumable = mk("MAN", "Manual", "a manual for ", x, ".", m.xxx);*/

		//RARE ITEMS (Permanent effects, gives perks on consumption.)
		public const BIMBOLQ:BimboLiqueur     = new BimboLiqueur();
		public const BROBREW: Consumable = mk("BroBrew", "BroBrew", "a can of Bro Brew", 1000, "This aluminum can is labelled as 'Bro Brew'.  It even has a picture of a muscly, bare-chested man flexing on it.  A small label in the corner displays: \"Demon General's Warning: Bro Brew's effects are as potent (and irreversible) as they are refreshing.", m.broBrew);
		public const HUMMUS2: Consumable = mk("Hummus2", "S.Hummus", "a blob of cheesy-looking super hummus", 6, "This pile of hummus doesn't look that clean, and you really don't remember where you got it from.  It looks bland.  So bland that you feel blander just by looking at it.", m.superHummus);
		public const P_PEARL:PurePearl = new PurePearl();
		public const EZEKFRU: Consumable = mk("EzekFru", "EzekielFruit", "a magical fruit", 300,
			"Evangeline gave you this fruit as means of showing her gratitude. Eating it will probably strengthen your body and mind.\n\n<b>Effect: all stats +10</b>", m.ezekielfruit);
		public const E3PEARL:ElementalPearl = new ElementalPearl(3);
		public const E5PEARL:ElementalPearl = new ElementalPearl(5);
		public const E7PEARL:ElementalPearl = new ElementalPearl(7);
		
		//NON-TRANSFORMATIVE ITEMS
		public const AGILI_E: Consumable = mk("Agil.E.", "Agility E.", "an agility elixir", 6, "This greenish elixir is supposed to increase the user’s natural swiftness and agility.", m.agilityElixir);
		public const AIRWEED: Consumable = mk("Airweed", "Airweed", "an Airweed", 10, "Upon consumption, this magic seaweed grants water breathing for 24 hours.", m.airweed);
		public const AKBALSL:Consumable       = new AkbalSaliva();
		public const ALCTHUN: Consumable = mk("AlcThun", "Alch.Thunder", "an Alchemical Thunder", 50, "Lightning in a bottle. Add heavy electricity damage to your weapon for a limited time upon use.", m.buffAlchemicalThunder);
		public const AMBROSA:Consumable       = new Ambrosia();
		public const BALLOFL:BallsOfFlame     = new BallsOfFlame();
		public const BALLOTD:BallsOfTheDarkness = new BallsOfTheDarkness();
		public const BANGB_M:MiniBangBall     = new MiniBangBall();
		public const BANGBM1:BangBallMk1      = new BangBallMk1();
		public const BANGBM2:BangBallMk2      = new BangBallMk2();
		public const BANGBM3:BangBallMk3      = new BangBallMk3();
		public const BAPILL_: Consumable = mk("BAPill", "Big Angry Pill", "a big angry pill", 125, "A big pill that's guaranteed to makes you a bit more angry.", m.bigangrypill);
		public const BCHCAKE: Consumable = mk("BChCake", "BigChocolateCake", "a Big chocolate cake", 30, "A decadent-looking chocolate cake found primarily in wonderland.", m.bigChocolateCake);
		public const BH_PILL: Consumable = mk("BH.Pill", "B.Heal Pill", "a big healing pill", 42, "A big healing pill that's guaranteed to heal you by a bit.", m.bighealpill);
		public const C__MINT:Consumable       = new Mint();
		public const CERUL_P:Consumable       = new CeruleanPotion();
		public const COAL___:Consumable       = new Coal();
		public const CFISHS: Consumable  = mk("CFishS.", "Cold Fish S.", "a bowl of cold fish soup", 20, "A soup made with fishes from the glacial rift. It is served cold to preserve the flavor and supposed calming effect which act as a lustkiller.", m.coldFishSoup);
	//	public const DAO_DEW: Consumable = mk("Dao Dew", "Dao Dew", "a cup of vixen tea", 15, "An exotic tea made by kitsunes. This herbal infusion is rumored to improve your expertise and expand your sexual knowledge.", m.daoDew);
		public const DEBIMBO:DeBimbo          = new DeBimbo();
		public const EXTSERM:HairExtensionSerum = new HairExtensionSerum();
		public const F_DRAFT: Consumable = mk("F.Draft", "FuckDraft", "a vial of roiling red fluid labeled \"Fuck Draft\"", 6, "This vial of red fluid bubbles constantly inside the glass, as if eager to escape.  It smells very strongly, though its odor is difficult to identify.  The word \"Fuck\" is inscribed on the side of the vial.", curry(m.lustDraft, true));
		public const FROZENB:FrozenBalls      = new FrozenBalls();
		public const H_PILL:Consumable        = new HealPill();
		public const HRBCNT:Consumable        = new HerbalContraceptive();
		public const INCOINS: Consumable = mk("IncOIns", "IncenOfIns", "an incense of Insight", 15, "These sticks, when burned, are rumored to fill an area with an incense that allows for deep meditation and granting greater insight.", m.incenseOfInsight);
		public const ICICLE_:Consumable       = new IceShard();
		public const KITGIFT:KitsuneGift	  = new KitsuneGift();
		public const LETHITE:Lethite	      = new Lethite();
		public const L_DRAFT: Consumable = mk("L.Draft", "LustDraft", "a vial of roiling bubble-gum pink fluid", 20, "This vial of bright pink fluid bubbles constantly inside the glass, as if eager to escape.  It smells very sweet, and has \"Lust\" inscribed on the side of the vial.", curry(m.lustDraft, false));
		public const LACTAID:Consumable       = new Lactaid();
		public const LUSTSTK:LustStick        = new LustStick();
		public const MADMENK: Consumable = mk("MadmenK", "MadmenKnowledge", "a Madmen knowledge", 100, "A bottle filled with the raw knowledge of an insane person. Every now and then insane people speak a truth unavailable to sane folks, having glimpsed into something only they can see. Knowledge is power but power is corrupt and can, with time, break even the most steeled of minds.", m.madmenKnowledge);
		public const MANUP_B: Consumable = mk("ManUp B", "ManUp B.", "a ManUp beer", 6, "A beverage made for people who believe brawn is better than brains.", m.manUpBeer);
		public const MAPILL_: Consumable = mk("MAPill", "Medium Angry Pill", "a medium angry pill", 50, "A medium pill that's guaranteed to makes you a bit more angry.", m.mediumangrypill);
		public const MH_PILL: Consumable = mk("MH.Pill", "M.Heal Pill", "a medium healing pill", 15, "A medium healing pill that's guaranteed to heal you by a bit.", m.mediumhealpill);
		public const MILKPTN:Consumable       = new MilkPotion();
		public const MIND_UP:MindUp           = new MindUp();
		public const NUMBCND: Consumable = mk("NumbCnd","Numb Candies", "a strange packet of 'Numb Candies'", 40, "This packet of innocuous looking 'candy' guarantees to reduce troublesome hear or rut and taste delicious.", m.numbCandies);
		public const NUMBROX:Consumable       = new NumbRocks();
		public const NUMBOIL:Consumable       = new NumbingOil();
		public const OVIELIX:OvipositionElixir = new OvipositionElixir();
        public const PEPPWHT: Consumable = mk("PeppWht", "PeppWht", "a vial of peppermint white", 120, "This tightly corked glass bottle gives of a pepperminty smell and reminds you of the winter holidays.  How odd.", m.peppermintwhite);
        public const PODBONE: Consumable = mk("PODBone", "pack of demon bones", "a pack of demon bones", 20, "It looks like a pack of demon bones that may still have between 1 and 10 demon bones inside.", m.packOfDemonBones);
		public const POISONB:PoisonedBalls    = new PoisonedBalls();
		public const PONAILS: Consumable = mk("PONails", "pack of nails", "a pack of nails", 20, "It looks like a pack of nails that may still have between 10 and 30 nails inside.", m.packOfNails);
		public const PPHILTR:Consumable       = new PurityPhilter();
		public const PRNPKR :Consumable       = new PrincessPucker();
		public const SAPILL_: Consumable = mk("SAPill", "Small Angry Pill", "a small angry pill", 20, "A small pill that's guaranteed to makes you a bit more angry.", m.smallangrypill);
		public const SENSDRF:Consumable       = new SensitivityDraft();
		public const SMART_T:Consumable       = new ScholarsTea();
		public const STRASCA: Consumable = mk("StraSCa", "StrawberryShortcake", "a Strawberry shortcake", 30, "A delicious-looking shortcake found primarily in wonderland.", m.strawberryShortcake);
		public const TCLEAVE: Consumable = mk("TCleave", "TCleave", "a tome for Cleave special", 10, "This tome would teach you how to use Cleave special.", m.tomeofcleave);
		public const THUNDBl:ThunderBalls     = new ThunderBalls();
		public const VITAL_T:Consumable       = new VitalityTincture();
		public const VIXEN_T: Consumable = mk("Vixen T", "Vixen T.", "a cup of vixen tea", 15, "An exotic tea made by kitsunes. This herbal infusion is rumored to improve your expertise and expand your sexual knowledge.", m.vixenTea);
		public const W_STICK:WingStick        = new WingStick();
		//Aqua Seed - prawdopodobnie nazwa dla Siren TF ; Bubble Lemonade - nazwa dla Dark Slime TF
		
		//TRANSFORMATIVE ITEMS
		
		public const ABYSSIN: Consumable = mk("AbyssIn", "AbyssalInk", "a vial of abyssal ink", 20, "Black abyssal ink normaly used for writing consuming this doesnt seem like the best idea.", curry(m.krakenInk, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(
								AE_SCYLLA,
								AE_KRAKEN
						), [
								[1, AR_INT],
								[1, AR_STR]
						], ["ghostly white"]);
		public const ABYSGIN: Consumable = mk("AbysGIn", "AbyssalGreyInk", "a vial of grey abyssal ink", 40, "Grey abyssal ink normaly used for writing consuming this doesnt seem like the best idea.", curry(m.krakenInk, 1), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(
								AE_SCYLLA,
								AE_KRAKEN
						), [
							[1, AR_INT],
							[1, AR_STR]
						], ["ghostly white"]);
		public const ABYSWIN: Consumable = mk("AbysWIn", "AbyssalWhiteInk", "a vial of white abyssal ink", 60, "White abyssal ink normaly used for writing consuming this doesnt seem like the best idea.", curry(m.krakenInk, 2), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(
								AE_SCYLLA,
								AE_KRAKEN
						), [
							[1, AR_INT],
							[1, AR_STR]
						], ["ghostly white"]);
		public const ALICORN:AbstractEquinum  = new AbstractEquinum(2, "Alicorn", "Alicornum", "a vial of Alicornum", 200, "This is a long flared vial with a small label that reads, \"<i>Alicornum</i>\".  It is likely this potion is tied to alicorns in some way.");
		public const AQUSEED: Consumable = mk("AquSeed", "AquaSeed", "an aqua seed", 20, "This seed looks and smells absolutely delicious.  Though it has an unusual color, the harpies prize these nuts as delicious treats.  Eating one might induce some physical transformations.", curry(m.goldenSeed, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_SHARK, AE_HARPY, AE_SIREN),
						[
								[1, AR_STR],
								[1, AR_SPE],
								[1, AR_LIB]
						]
				);
		public const ASKIRIN:AsumaKirin 	  = new AsumaKirin();
		public const ASTOOTH: Consumable = mk("ASTooth", "ASTooth", "a gloomy abyssal shark tooth", 20, "This looks like a normal shark tooth, though enveloped with darkness.", curry(m.sharkTooth, 2), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_ABYSSAL_SHARK),
						[
							[1, AR_STR],
							[1, AR_WIS],
							[1, AR_SPE]
						],
						concatUnique(AbyssalSharkRace.AbyssalSharkHairColors, AbyssalSharkRace.AbyssalSharkScaleColors)
				);
		public const B_GOSSR: Consumable = mk("B.Gossr", "B.Gossr", "a bundle of black, gossamer webbing", 6, "These strands of gooey black gossamer seem quite unlike the normal silk that driders produce.  It smells sweet and is clearly edible, but who knows what it might do to you?", curry(m.sweetGossamer, 1), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_DRIDER, AE_SPIDER)
				);
		public const BAYRLEA: Consumable = mk("BayrLea", "Bayr leaf", "a Bayr leaf", 6, "This small leaf shaped like a bear paw can be made into a tea or used as a seasoning.", m.bayrleaf, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_BEAR),
						[
							[1, AR_STR],
							[1, AR_TOU]
						]
				);
		public const BEEHONY:BeeHoney         = new BeeHoney(false, false);
		public const BLACKIN: Consumable = mk("BlackIn", "BlackInk", "a vial of black ink", 10, "Pitch black ink normaly used for writing. Consuming this doesnt seem like the best idea.", curry(m.scyllaInk, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_SCYLLA),
						[
							[1, AR_STR],
							[1, AR_SPE],
							[1, AR_INT]
						]
				);
		public const BLACKPP: Consumable = mk("BlackPp", "BlackPp", "a solid black canine pepper", 10, "This solid black canine pepper is smooth and shiny, but something about it doesn't seem quite right...", curry(m.caninePepper, 3), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_DOG),
						[
								[1, AR_LIB],
								[1, AR_STR],
								[1, AR_SPE],
								[1, AR_TOU]
						]
				);
		public const BLADEGR: Consumable = mk("BladeGr", "BladeGrass", "a blade shaped grass", 6, "A form of herb normaly infused in samurai and other warrior tea.  You think infusing this unprocessed item in your tea could result in interesting result.", m.bladeGrass, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_MANTIS),
						[
							[1, AR_LIB],
							[1, AR_SPE],
							[1, AR_INT]
						],
						MantisRace.MantisChitinColors
				);
		public const BOARTRU: Consumable = mk("BoarTru", "BoarTruffle", "a boar truffle", 6, "It’s clear where the pigtail truffle gets its name.  A small, curly sprig resembling a pig’s tail can be seen jutting out of it. Now that it’s been enhanced by Lumi, it’s larger and fuzzier than it was before, almost like a peach.", curry(m.pigTruffle, true), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_PIG),
						[
							[1, AR_STR],
							[1, AR_LIB]
						]
				);
		public const BUBBLEG: Consumable = mk("B.Gum", "B.Gum", "a Bubblegum candy", 6, "A somewhat innocent pink spherical candy favored by cancers.", m.bubblegum, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_CANCER),
						[
							[1, AR_STR],
							[1, AR_LIB]
						]
				);
		public const BULBYPP: Consumable = mk("BulbyPp", "BulbyPp", "a bulbous pepper", 10, "This bulbous pepper has a slightly different shape than the other canine peppers, with two large orb-like protrusions at the base.", curry(m.caninePepper, 5), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_DOG),
						[
							[1, AR_LIB],
							[1, AR_STR],
							[1, AR_SPE],
							[1, AR_TOU]
						]
				);
		public const C_VEMOM:CentipedeVenom   = new CentipedeVenom();
		public const CANINEP: Consumable = mk("CanineP", "CanineP", "a Canine pepper", 6, "The pepper is shiny and red, bulbous at the base but long and narrow at the tip.  It smells spicy.", curry(m.caninePepper, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_DOG),
						[
							[1, AR_LIB],
							[1, AR_STR],
							[1, AR_SPE],
							[1, AR_TOU]
						]
				);
		public const CENTARI:Centaurinum      = new Centaurinum();
		public const CHILLYP: Consumable = mk("ChillyP", "ChillyPp", "a Chilly pepper", 10, "This pepper is positively shrouded with a thin layer of ice.", m.chillyPepper, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_FENRIR, AE_WOLF),
						[
								[1, AR_LIB],
								[1, AR_STR],
								[1, AR_SPE],
								[1, AR_TOU]
						]
				);
		public const COUAOIL: Consumable = mk("CouaOil", "CouatlOil", "a vial of couatl oil", 20, "A vial the size of your fist made of dark blue glass. It contains what appears to be an oily, red liquid. The odor is strange.", curry(m.evolvedNagaOil, 2), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_COUATL, AE_SNAKE, AE_HARPY),
						[
							[1, AR_SPE],
							[1, AR_TOU],
							[1, AR_LIB]
						]
				);
		public const D_FRUIT: Consumable = mk("D.Fruit", "D.Fruit", "a Displacement Fruit", 25, "This weird fruit is said to taste completely otherworldly. They grow in only the weirdest of place. Highly favored by displacer beasts.", m.displacementFruit, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_DISPLACER_BEAST)
				);
		public const DBLPEPP: Consumable = mk("DblPepp", "DblPepp", "a double canine pepper", 10, "This canine pepper is actually two that have grown together due to some freak coincidence.", curry(m.caninePepper, 2), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_DOG),
						[
							[1, AR_LIB],
							[1, AR_STR],
							[1, AR_SPE],
							[1, AR_TOU]
						]
				);
		public const DESERTB: Consumable = mk("DesertB", "Desert Berry", "a desert berry", 20, "This small orange berry is light in your hands.  It may have gotten its name from been founded usualy in desert regions.  You're certain it is no mere fruit.", m.desertBerry, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_WEREFOX),
						[
							[1, AR_TOU],
							[1, AR_SPE],
							[1, AR_WIS]
						],
						concatUnique(
								FoxRace.FoxHairColors,
								FoxRace.FoxFurColors
						)
				);
		public const DSLIMEJ: Consumable = mk("DSlimeJ", "DarkSlimeJelly", "a Dark slime jelly", 20, "This looks to be a chunk of inert goop from a dark slime. Consuming this thing may have a weird effect on you.", curry(m.gooGasmic, 2), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_GOO, AE_DARK_SLIME),
						[],
						DarkSlimeRace.DarkSlimeSkinColors
				);
		public const DRAKHRT: Consumable = mk("DrakHrt", "DrakeHeart", "a drake's heart's flower", 50, "A rare, beautiful flower.  It could make an exquisite perfume.  According to a legend, dragons give this flower to the ones they intend to court.", curry(m.drakeHeart), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_DRAGON),
						[],
						DragonRace.DragonScaleColors
				);
		public const DRYTENT: Consumable = mk("DryTent", "DryTent", "a shriveled tentacle", 6, "A dried tentacle from one of the lake anemones.  It's probably edible, but the stingers are still a little active.", m.shriveledTentacle, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_ANEMONE),
						[
							[1, AR_TOU]
						]
				);
		public const ECTOPLS: Consumable = mk("EctoPls", "EctoPls", "a bottle of ectoplasm", 6, "The green-tinted, hardly corporeal substance flows like a liquid inside its container. It makes you feel... uncomfortable, as you observe it.", curry(m.ectoplasm, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_GHOST),
						[
							[1, AR_INT],
							[1, AR_LIB]
						]
				);
		public const ELFEARS: Consumable = mk("ElfEars", "ElfEars", "a Fae ear shaped plant", 6, "A plant that looks like a pointed Fae ear. Upon further inspection, the plant is very delicate and seems to radiate some sort of magical energy.", m.elfears, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_ELF, true),
						[
								[1, AR_SPE],
								[1, AR_INT],
						],
						concatUnique(
								ElfRace.ElfHairColors,
								ElfRace.ElfSkinColors
						)
				);
		public const ENIGMANIUM:Enigmanium    = new Enigmanium();
		public const EQUINUM:AbstractEquinum  = new AbstractEquinum(0, "Equinum", "Equinum", "a vial of Equinum", 6, "This is a long flared vial with a small label that reads, \"<i>Equinum</i>\".  It is likely this potion is tied to horses in some way.");
		public const EYEDROP: Consumable = mk("EyeDrop", "EyeDrop", "a bottle of eye drops", 50, "A bottle of medicinal eye drops for when a person has sight issues. May have strange effects on offworlders.", curry(m.eyeDrops, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_CYCLOP),
						[
							[1, AR_STR],
							[1, AR_INT],
							[1, AR_TOU],
							[1, AR_LIB]
						],
						concatUnique(
								GazerRace.GazerHairColors,
								GazerRace.GazerSkinColors
						)
				);
		public const F_TEAR: Consumable  = mk("F.Tear", "FafnirTear", "a Fafnir Tear", 15, "This beautiful flower only grows in the snow. It somehow digs its way and survives even in the harsh climate of the rift.", m.FafnirTear, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_FROST_WYRM),
						[
							[1, AR_TOU],
							[1, AR_SPE],
							[1, AR_LIB]
						]
				);
		public const FIERYS_: Consumable = mk("FieryS", "FieryS.", "Fiery saké", 10, "A strong alcoholic beverage best served hot. The Hinezumi drink of this regularly.", curry(m.mouseCocoa, 1), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_HINEZUMI, AE_MOUSE)
				);
		public const FOXBERY: Consumable = mk("FoxBery", "Fox Berry", "a fox berry", 6, "This large orange berry is heavy in your hands.  It may have gotten its name from its bright orange coloration.  You're certain it is no mere fruit.", curry(m.foxTF, false), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_FOX),
						[
							[1, AR_INT],
							[1, AR_LIB]
						],
						concatUnique(
								FoxRace.FoxHairColors,
								FoxRace.FoxFurColors
						)
				);
		public const FRRTFRT: Consumable = mk("Frrtfrt", "FerretFrt", "a ferret fruit", 6, "This fruit is curved oddly, just like the tree it came from.  The skin is fuzzy and brown, like the skin of a peach.", m.ferretTF, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_FERRET),
						[
							[1, AR_SPE]
						]
				);
		public const FOXJEWL: Consumable = mk("FoxJewl", "Fox Jewel", "a fox jewel", 50, "A shining teardrop-shaped jewel.  An eerie blue flame dances beneath the surface.", curry(m.foxJewel, false), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_KITSUNE, AE_KITSUNE, AE_FOX, AE_HUMAN),
						[
								[1, AR_INT],
								[1, AR_WIS],
								[1, AR_LIB]
						],
						concatUnique(
								KitsuneRace.BasicKitsuneHairColors,
								KitsuneRace.BasicKitsuneFurColors,
								KitsuneRace.BasicKitsuneSkinColors
						)
				);
		public const FSNAILS: Consumable = mk("FSnailS", "FireSnailSaliva", "a Fire snail Saliva", 20, "The saliva of a fire snail. Highly volatile.", m.firesnailsaliva, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_FIRE_SNAIL)
				);
		public const G_FRUIT: Consumable = mk("G.Fruit", "G.Fruit", "a Ghastly fruit", 10, "A ghastly whisker fruit from some underground place. Legends even says they may been growing in netherwold. Highly favored by nekomata.", m.ghastlyFruit, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_NEKOMATA, AE_CAT)
				);
		public const GLDRIND:GoldenRind       = new GoldenRind();
		public const GORGOIL: Consumable = mk("GorgOil", "GorgonOil", "a vial of gorgon oil", 20, "A vial the size of your fist made of dark green glass. It contains what appears to be oily, greenish liquid. The odor is foul.", curry(m.evolvedNagaOil, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_GORGON, AE_SNAKE),
						[
							[1, AR_SPE],
							[1, AR_TOU],
							[1, AR_LIB]
						]
				);
		public const GREYINK: Consumable = mk("GreyInk", "GreyInk", "a vial of grey ink", 30, "Ash grey ink normaly used for writing consuming this doesnt seem like the best idea.", curry(m.scyllaInk, 1), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_SCYLLA),
						[
							[1, AR_STR],
							[1, AR_SPE],
							[1, AR_INT]
						]
				);
		public const GLDSEED: Consumable = mk("GldSeed", "GoldenSeed", "a golden seed", 6, "This seed looks and smells absolutely delicious.  Though it has an unusual color, the harpies prize these nuts as delicious treats.  Eating one might induce some physical transformations.", curry(m.goldenSeed, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_HARPY),
						[
							[1, AR_SPE],
							[1, AR_STR],
							[1, AR_LIB]
						],
						HumanRace.HumanSkinColors
				);
		public const GOB_ALE: Consumable = mk("Gob.Ale", "Gob.Ale", "a flagon of potent goblin ale", 6, "This sealed flagon of 'Goblin Ale' sloshes noisily with alcoholic brew.  Judging by the markings on the flagon, it's a VERY strong drink, and not to be trifled with.", m.goblinAle, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						[
								[10, AE_GOBLIN],
								[2, AE_HUMAN],
								[2, AE_SHRINK],
								[1, AE_REMOVE]
						],
						[
								[1, AR_SPE]
						], concatUnique(
								GoblinRace.GoblinHairColors,
								GoblinRace.GoblinEyeColors,
								GoblinRace.GoblinSkinColors,
								GoblinRace.GoblinRareSkinColors
						)
				);
		public const GRE_BER: Consumable = mk("Gre.Beer", "Gre.Beer", "a flagon of potent gremlin beer", 6, "This disgusting brew is made from the combination of goblin ale and Imp food. It smells of old engine oil and rust, let’s hope it does not taste like that as well.", m.gremlinBeer, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_GREMLIN),
						[
							[1, AR_SPE]
						],
						concatUnique(
							GremlinRace.GremlinEyeColors,
							GremlinRace.GremlinHairColors,
							GremlinRace.GremlinSkinColors
						)
				);
		public const HDEWCAK:HoneydewCake     = new HoneydewCake();
		public const HUMMUS_: Consumable = mk("Hummus ", "Hummus", "a blob of cheesy-looking hummus", 100, "This pile of hummus doesn't look that clean.  It looks bland.  So bland that you feel blander just by looking at it.", m.regularHummus, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						[
							[1, AE_HUMAN]
						]
				);
		public const HYDRASC: Consumable = mk("HydraSc", "HydraScale", "a hydra scale", 75, "The scale of a hydra. There is no telling of what it could do to you should you decide to use it.", curry(m.evolvedNagaOil, 3), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_HYDRA),
						[
							[1, AR_SPE],
							[1, AR_TOU],
							[1, AR_LIB]
						]
				);
		public const ICY_FIG: Consumable = mk("Icy Fig", "Icy Fig", "an Icy Fig", 12, "A frozen fig that's a common delicacy among trolls that live in cold regions, it’s said that it infuses the consumer with tremendous insight.", curry(m.trollFig, 1), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_TROLL),
						[
							[1, AR_WIS]
						]
				);
		public const IMPFOOD: Consumable = mk("ImpFood", "ImpFood", "a parcel of imp food", 6, "This is a small parcel of reddish-brown bread stuffed with some kind of meat.  It smells delicious.", m.impFood, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_IMP),
						[],
						concatUnique(
								ImpRace.ImpEyeColors,
								ImpRace.ImpHairColors,
								ImpRace.ImpSkinColors,
								ImpRace.ImpRareSkinColors
						)
				);
		public const INFWINE: Consumable = mk("InfWine", "InfWine", "a bottle of infernal wine", 500, "This drink is made from a bottle of satyr wine, an incubus draft, and some succubus milk. It reeks of corruption. Are you sure it would be a smart idea to drink this?", m.infernalWine, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_DEVIL),
						[
							[1, AR_INT],
							[1, AR_LIB]
						]
				);
		public const JABBERS: Consumable = mk("JabberS", "JabberS", "a Jabberwocky scale", 100, "A scale of the so called rabbit dragon. It emits a faint glow of residual magic but are you sure you should be eating this?", m.jabberwockyScale, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_JABBERWOCKY)
				);
		public const JACKALD: Consumable = mk("JackalD", "JackalD", "a Jackal Date", 10, "A fruit found in the desert commonly eaten by its denizen. A favorite of the jackal like anubi.", m.jackalDate, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_ANUBIS),
						[
							[1, AR_TOU],
							[1, AR_WIS],
							[1, AR_LIB]
						]
				);
		public const KANGAFT: Consumable = mk("KangaFt", "KangaFruit", "a piece of kanga fruit", 6, "A yellow, fibrous, tubular pod.  A split in the end reveals many lumpy, small seeds inside.  The smell of mild fermentation wafts from them.", curry(m.kangaFruit, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_KANGAROO)
				);
		public const KNOTTYP: Consumable = mk("KnottyP", "KnottyP", "a knotty canine pepper", 10, "This knotted pepper is very swollen, with a massive, distended knot near the base.", curry(m.caninePepper, 4), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_DOG),
						[
							[1, AR_LIB],
							[1, AR_STR],
							[1, AR_SPE],
							[1, AR_TOU]
						]
				);
		public const LABOVA_: Consumable = mk("LaBova ", "La Bova", "a bottle containing a misty fluid labeled \"LaBova\"", 6, "A bottle containing a misty fluid with a grainy texture. It has a long neck and a ball-like base.  The label has a stylized picture of a well endowed cowgirl nursing two guys while they jerk themselves off.", curry(m.laBova, true, false), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_COW, true),
						[
							[1, AR_STR],
							[1, AR_TOU],
							[1, AR_SPE]
						]
				);
		public const LARGEPP: Consumable = mk("LargePp", "LargePp", "an overly large canine pepper", 10, "This large canine pepper is much bigger than any normal peppers you've seen.", curry(m.caninePepper, 1), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_DOG),
						[
							[1, AR_LIB],
							[1, AR_STR],
							[1, AR_SPE],
							[1, AR_TOU]
						]
				);
		public const LEVISUN: Consumable = mk("LeviSun", "LeviSunscr", "a bottle of Leviathan Sunscreen", 6, "Seriously sea dragons use sunscreen too? You thought with all the scales they would not need such a thing to protect their pretty skin.", curry(m.orcaSunscreen, 1), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_LEVIATHAN, AE_ORCA),
						[
							[1, AR_STR],
							[1, AR_SPE],
							[1, AR_TOU]
						]
				);
		public const MAGSEED: Consumable = mk("MagSeed", "MagSeed", "a magically-enhanced golden seed", 6, "This seed glows with power.  It's been enhanced by Lumi to unlock its full potential, allowing it to transform you more easily.", curry(m.goldenSeed, 1), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						[[1, AE_HARPY]],
						[
								[1, AR_STR],
								[1, AR_SPE],
								[1, AR_LIB]
						],
						HumanRace.HumanSkinColors
				);
		public const MARAFRU:MaraFruit 	      = new MaraFruit();
		public const MANTICV:ManticoreVenom   = new ManticoreVenom();
		public const METHIRC: Consumable = mk("MethirC", "MethirCryst", "a methir crystal", 6, "This fluorescent crystal grows near cave wyrm's nests, it looks edible.", m.methircrystal, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_CAVE_WYRM),
						[
							[1, AR_STR],
							[1, AR_TOU],
							[1, AR_LIB]
						]
				);
		public const ME_DROP: Consumable = mk("ME Drop", "M.EyeDrop", "a bottle of magic eye drops", 50, "A bottle of medicinal eye drops for when a person has sight issues. It has been enhanced by powerful magic and may have severe secondary effects on offworlders.", curry(m.eyeDrops, 1), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_GAZER, AE_CYCLOP),
						[
							[1, AR_STR],
							[1, AR_TOU],
							[1, AR_INT],
							[1, AR_LIB]
						],
						concatUnique(
								GazerRace.GazerHairColors,
								GazerRace.GazerSkinColors
						)
				);
		public const MGHTYVG: Consumable = mk("MghtyVg", "MghtyVg", "a mightily enhanced piece of kanga fruit", 6, "A yellow, fibrous, tubular pod.  A split in the end reveals many lumpy, small seeds inside.  The smell of mild fermentation wafts from them.  It glows slightly from Lumi's enhancements.", curry(m.kangaFruit, 1), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						[[1, KANGAFT]]
				);
		public const M_GOSSR: Consumable = mk("M.Gossr", "M.Gossr", "a bundle of midnight black gossamer webbing", 50, "This strange webbing is darker than night. It's so thick that light fails to get through it. It likely would be most unwise to consume it.", m.midnightGossamer, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_ATLACH_NACHA, AE_SPIDER)
				);
		public const MOUSECO: Consumable = mk("MouseCo", "MouseCo", "a handful of mouse cocoa", 6, "A handful of rare aromatic beans with sharp creases in the middle, making them look like small mouse ears.  Allegedly very popular and plentiful before the mice-folk were wiped out.", curry(m.mouseCocoa, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AlchemyLib.AE_MOUSE),
						[
							[1, AR_SPE]
						]
				);
		public const MINOBLO:MinotaurBlood    = new MinotaurBlood();
		public const MYSTJWL: Consumable = mk("MystJwl", "MystJwl", "a mystic jewel", 50, "The flames within this jewel glow brighter than before, and have taken on a sinister purple hue.  It has been enhanced to increase its potency, allowing it to transform you more easily, but may have odd side-effects...", curry(m.foxJewel, true), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_KITSUNE, AE_KITSUNE, AE_FOX, AE_HUMAN),
						[
							[1, AR_INT],
							[1, AR_WIS],
							[1, AR_LIB],
							[1, AR_CORR_INC],
						],
						concatUnique(
								KitsuneRace.ElderKitsuneSkinColors,
								KitsuneRace.ElderKitsuneColors
						)
				);
		public const NOCELIQ: Consumable = mk("NoceLiq", "NocelloLiq", "a bottle of Nocello Liquer", 20, "This bottle contain sweet liquer called 'Nocello', which one sip can makes your stomach feel warm even in middle of glacial rift.  It looks to be just hazelnut flavored alcohol or there is more to it?", m.nocelloliquer, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_PHOENIX,AE_PHOENIX,AE_SALAMANDER,AE_HARPY),
						[
							[1, AR_SPE],
							[1, AR_TOU],
							[1, AR_LIB]
						]
				);
		public const ONISAKE:OnikiriSake 	  = new OnikiriSake();
		public const ORCASUN: Consumable = mk("OrcaSun", "OrcaSunscr", "a bottle of Orca Sunscreen", 6, "A very ordinary looking bottle of sunscreen, with a whale girl in swimwear labeled 'Orca sunscreen'.", curry(m.orcaSunscreen, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_ORCA),
						[
							[1, AR_STR],
							[1, AR_SPE],
							[1, AR_TOU]
						]
				);
		public const ORCMEAD: Consumable = mk("OrcMead", "OrcMead", "a flagon of Orc Mead", 6, "This sealed flagon of 'Orc Mead' sloshes noisily with alcoholic brew.  Judging by the markings on the flagon, it's a VERY strong drink, and not to be trifled with.", m.orcMead, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_ORC),
						[
							[1, AR_STR],
							[1, AR_SPE],
							[1, AR_TOU]
						],
						OrcRace.OrcSkinColors
				);
		public const P_LBOVA: Consumable = mk("P.LBova", "P.LBova", "a bottle containing a white fluid labeled \"Pure LaBova\"", 6, "A bottle containing a misty fluid with a grainy texture; it has a long neck and a ball-like base.  The label has a stylized picture of a well-endowed cow-girl nursing two guys while they jerk themselves off. It has been purified by Rathazul.", curry(m.laBova, false, false), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_COW),
						[
							[1, AR_STR],
							[1, AR_TOU],
							[1, AR_SPE]
						]
				);
		public const P_VEMOM:PotentVenom 	  = new PotentVenom();
		public const PIGTRUF: Consumable = mk("PigTruf", "PigTruffle", "a pigtail truffle", 6, "It’s clear where this fungus gets its name.  A small, curly sprig resembling a pig’s tail can be seen jutting out of it.", curry(m.pigTruffle, false), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_PIG),
						[
							[1, AR_STR],
							[1, AR_TOU]
						]
				);
		public const PRFRUIT: Consumable = mk("PrFruit", "PrFruit", "a purple fruit", 6, "This sweet-smelling produce looks like an eggplant, but feels almost squishy, and rubbery to the touch. Holding it to your ear, you think you can hear some fluid sloshing around inside.", m.purpleFruitEssrayle, ItemTags.U_TF);
		public const PROBOVA: Consumable = mk("ProBova", "ProBova", "a bottle containing a misty fluid labeled \"ProBova\"", 6, "This cloudy potion has been enhanced by the alchemist Lumi to imbue its drinker with cow-like attributes.", curry(m.laBova, true, true), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_COW),
						[
							[1, AR_STR],
							[1, AR_TOU],
							[1, AR_SPE]
						]
				);
		public const PROTPLS: Consumable = mk("ProtPls", "ProtPls", "a bottle of protoplasm", 6, "The opaque, incorporeal substance flows like a liquid inside its container. It makes you feel... uncomfortable, as you observe it and maybe it observe you back...", curry(m.ectoplasm, 1), ItemTags.U_TF);
		public const PURHONY:BeeHoney		  = new BeeHoney(true, false);
		public const RDRROOT: Consumable = mk("RdRRoot", "R.R.Root", "a red river root", 14, "A long, odd shaped root. It smells spicy but surprisingly tasty. Eating it would supposedly alter your body in unknown ways.", m.redRiverRoot, ItemTags.U_TF);
		public const REDVIAL:VampireBlood 	  = new VampireBlood();
		public const REPTLUM: Consumable = mk("Reptlum", "Reptilum", "a vial of Reptilum", 6, "This is a rounded bottle with a small label that reads, \"<i>Reptilum</i>\".  It is likely this potion is tied to reptiles in some way.", m.reptilum, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_LIZARD),
						[
							[1, AR_TOU],
							[1, AR_LIB]
						]
				);
		public const RESNOIL: Consumable = mk("R.SnakOil", "R.SnakOil", "a vial of refined snake oil", 6, "A vial the size of your fist made of dark brown glass. It contains what appears to be an oily, blackish liquid. The odor is even more abominable then that of regular snake oil.", curry(m.snakeOil, 1), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_APOPHIS, AE_SNAKE),
						[],
						NagaRace.SnakeScaleColors
				);
		public const RINGFIG: Consumable = mk("RingFig", "RingFig", "a ringtail fig", 6, "A dried fig with two lobes and thin dark rings just below its stem.  The skin is wrinkly and it looks vaguely like a bulging scrotum.", m.ringtailFig, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_RACCOON),
						[
							[1, AR_SPE],
							[1, AR_LIB]
						]
				);
		public const RIZZART:RizzaRoot			= new RizzaRoot();
		public const RUBYCRY: Consumable = mk("RubyCry", "RubyCryst", "a ruby crystal", 6, "A shining teardrop-shaped jewel.  An eerie red fluid dances beneath the surface.", m.rubycrystal, ItemTags.U_TF);
		public const S_GOSSR: Consumable = mk("S.Gossr", "S.Gossr", "a bundle of pink, gossamer webbing", 6, "These strands of gooey pink gossamer seem quite unlike the normal silk that spider-morphs produce.  It smells sweet and is clearly edible, but who knows what it might do to you?", curry(m.sweetGossamer, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_SPIDER)
				);
		public const SALAMFW: Consumable = mk("SalamFW", "SalamFW", "a hip flask of Salamander Firewater", 6, "This hip flask contain high-proof beverage called 'Salamander Firewater', which one sip can makes your throat feel like it been set on fire.  What whould happen if you drink whole flask content?", m.salamanderfirewater, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_SALAMANDER),
						[
							[1, AR_STR],
							[1, AR_TOU],
							[1, AR_LIB]
						],
						concatUnique(
								SalamanderRace.SalamanderScaleColors,
								SalamanderRace.SalamanderSkinColors
						)
				);
		public const SATYR_W:SatyrWine        = new SatyrWine();
		public const SAGEMED:SageMedicine     = new SageMedicine();
		public const SCORICO:Scorpinum 		  = new Scorpinum();
		public const SHARK_T: Consumable = mk("Shark.T", "Shark.T", "a sharp shark tooth", 6, "A glinting white tooth, very sharp and intimidating.", curry(m.sharkTooth, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_SHARK),
						[
							[1, AR_STR],
							[1, AR_LIB],
							[1, AR_SPE]
						],
						concatUnique(SharkRace.SharkHairColors, SharkRace.SharkScaleColors)
				);
		public const SKELP__: Consumable = mk("Skelp  ", "Skelp", "a skelp", 15, "A form of Kelp used by the Melkie as seasoning for their food. Very tasty but can result in transformation if used uncooked.", m.skelp, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_MELKIE, true),
						[
							[1, AR_LIB],
							[1, AR_SPE],
							[1, AR_INT]
						],
						concatUnique(
								MelkieRace.MelkieFurColors,
								MelkieRace.MelkieHairColors,
								MelkieRace.MelkieSkinColors
						)
				);
		public const SKYSEED: Consumable = mk("SkySeed", "SkybornSeed", "a skyborn seed", 10, "A smallish, ovular nut-like fruit, with a hard greenish-blue shell that gives off a pleasant aroma.", curry(m.skybornSeed, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_AVIAN),
						[
							[1, AR_SPE],
							[1, AR_STR]
						]
				);
		public const SNAKOIL: Consumable = mk("SnakOil", "SnakeOil", "a vial of snake oil", 6, "A vial the size of your fist made of dark brown glass. It contains what appears to be an oily, yellowish liquid. The odor is abominable.", curry(m.snakeOil, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_SNAKE),
						[
							[1, AR_LIB]
						],
						HumanRace.HumanSkinColors
				);
		public const SMRTNUT: Consumable = mk("SmrtNut", "SmartyNuts", "a smarty nut", 6, "A special nut highly prized by Ratatoskr's. Rumors are it makes you smarter.", m.smartyNuts, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_SQUIRREL),
						[
							[1, AR_INT],
							[1, AR_SPE]
						],
						RatatoskrRace.RatatoskrHairColors
				);
		public const SPHONEY:Consumable		  = new BeeHoney(false, true);
		public const SRMSEED: Consumable = mk("SrmSeed", "StormSeed", "a storm seed", 20, "This magical seed radiate a faint aura of static as if struck by lightning.", m.stormSeed, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_THUNDERBIRD, AE_HARPY),
						[
							[1, AR_SPE],
							[1, AR_LIB]
						]
				);
		public const STRFLOW: Consumable = mk("StrFlow", "StrangeFlower", "a strange flower", 20, "This weird flower has two pistils instead of one. You feel a strange connection to it.", m.strangeFlower, ItemTags.U_TF);
		public const TGOGODD: Consumable = mk("TGOGoss", "TGOnnaGoss", "a Thick Green Onna Gossamer", 6, "Those strands of green gossamer are rougher than those of driders. It looks edible, but the smell of musk and milk makes you a little dizzy.", curry(m.thickGossamer, 0), ItemTags.U_TF);
		public const TRAPOIL: Consumable = mk("TrapOil", "TrapOil", "a vial of trap oil", 6, "A round, opaque glass vial filled with a clear, viscous fluid.  It has a symbol inscribed on it, a circle with a cross and arrow pointing out of it in opposite directions.  It looks and smells entirely innocuous.", m.trapOil, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_SAND_TRAP),
						[
							[1, AR_SPE],
							[1, AR_LIB]
						]
				);
		public const TROLFIG: Consumable = mk("TrolFig", "TrollFig", "a Troll Fig", 12, "A hairy fig that's a common delicacy among trolls, it’s said that it infuses the consumer with tremendous insight.", curry(m.trollFig, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_TROLL),
						[
							[1, AR_WIS]
						]
				);
		public const TSCROLL:TatteredScroll   = new TatteredScroll();
		public const TSTOOTH: Consumable = mk("TSTooth", "TSTooth", "a glowing tiger shark tooth", 6, "This looks like a normal shark tooth, though with an odd purple glow.", curry(m.sharkTooth, 1), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_SHARK),
						[
							[1, AR_STR],
							[1, AR_LIB],
							[1, AR_SPE]
						],
						concatUnique(SharkRace.SharkHairColors, SharkRace.SharkScaleColors, ["orange"])
				);
		public const UNICORN:AbstractEquinum  = new AbstractEquinum(1, "Unicorn", "Unicornum", "a vial of Unicornum", 40, "This is a long flared vial with a small label that reads, \"<i>Unicornum</i>\".  It is likely this potion is tied to unicorns in some way.");
		public const VAMPBLD:VampireBlood     = new VampireBlood(true);
		public const VIXVIGR: Consumable = mk("VixVigr", "VixVigr", "a bottle labelled \"Vixen's Vigor\"", 30, "This small medicine bottle contains something called \"Vixen's Vigor\", supposedly distilled from common fox-berries.  It is supposed to be a great deal more potent, and a small warning label warns of \"extra boobs\", whatever that means.", curry(m.foxTF, true), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						[[1, AE_FOX]],
						[
							[1, AR_INT],
							[1, AR_LIB]
						],
						concatUnique(
								FoxRace.FoxHairColors,
								FoxRace.FoxFurColors
						)
				);
		public const VOLTTOP: Consumable = mk("VoltTop", "VoltTopaz", "a Voltage topaz", 6, "This glittering jewel sparkles with a wondrous light. With such beauty, it would probably fetch a fair amount of gems in various markets. A faint static tingle warms your hands as a light flush travels up your arms...", curry(m.voltageTopaz, true), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_RAIJU),
						[
							[1, AR_LIB]
						],
						concatUnique(
								RaijuRace.RaijuEyeColors,
								RaijuRace.RaijuHairColors
						)
				);
		public const VOUIOIL: Consumable = mk("VouiOil", "VouivreOil", "a vial of vouivre oil", 70, "A vial the size of your fist made of light green glass. It contains what appears to be an oily, purple liquid. The odor is strange.", curry(m.evolvedNagaOil, 1), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_DRAGON, AE_SNAKE),
						[
							[1, AR_SPE],
							[1, AR_TOU],
							[1, AR_LIB]
						]
				);
		public const W_FRUIT: Consumable = mk("W.Fruit", "W.Fruit", "a piece of whisker-fruit", 6, "This small, peach-sized fruit has tiny whisker-like protrusions growing from the sides.", m.whiskerFruit, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_CAT),
						[],
						CatRace.catFurColors
				);
		public const W_EMRLD: Consumable = mk("W.Emerald", "W.Emerald", "a Windstorm Emerald", 20, "This glittering jewel sparkles with a wondrous light. With such beauty, it would probably fetch a fair amount of gems in various markets. A faint green glow warms your hands as a light breeze travels up your arms...", curry(m.windstormEmerald, true), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_KAMAITACHI),
						[
							[1, AR_LIB]
						]
				);
		public const WHITEIS: Consumable = mk("WhiteIS", "WhiteIceShard", "a White Ice Shard", 30, "This shard of cloudy white ice seems to resist all forms of heat and appears to radiate a sense of loneliness and frigid desire.", m.whiteIceShard, ItemTags.U_TF);
		public const WOFRUIT: Consumable = mk("WoFruit", "WonderFruit", "a Wonder fruit", 10, "A strange whisker fruit from what appears to be a different dimension. Its skin is dyed with all the color of the rainbow.", m.wonderFruit, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						MULTIRACE_ESSENCE_DROP_TABLE(AE_CHESHIRE, AE_CAT)
				);
		public const WETCLTH: Consumable = mk("WetClth", "WetCloth", "a wet cloth dripping with slippery slime", 6, "Dripping with a viscous slime, you've no doubt rubbing this cloth on your body would have some kind of strange effect.", curry(m.gooGasmic, 0), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_GOO),
						[
							[1, AR_STR],
							[1, AR_TOU]
						],
						SlimeRace.SlimeSkinColors
				);
		public const WHITEIN: Consumable = mk("WhiteIn", "WhiteInk", "a vial of white ink", 50, "Pearly white ink normaly used for writing consuming this doesnt seem like the best idea.", curry(m.scyllaInk, 2), ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_SCYLLA),
						[
							[1, AR_STR],
							[1, AR_SPE],
							[1, AR_INT]
						]
				);
		public const WOLF_PP: Consumable = mk("Wolf Pp", "WolfPepper", "a Wolf pepper", 20, "The pepper is shiny and black, bulbous at the base but long and narrow at the tip.  It has a fuzzy feel to it and it smells spicy.", m.wolfPepper, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_WEREWOLF),
						[
							[1, AR_STR],
							[1, AR_TOU],
							[1, AR_SPE]
						]
				);
		public const YETICUM: Consumable = mk("YetiCum", "YetiCum", "a bottle of Yeti Cum", 6, "This looks like some cum from a yeti. It looks potent and you can’t help but ponder about its effect.", m.yetiCum, ItemTags.U_TF)
				.refineableInto(
						DEFAULT_SUBSTANCES_DROP_TABLE,
						DEFAULT_ESSENCE_DROP_TABLE(AE_YETI),
						[
							[1, AR_STR],
							[1, AR_TOU],
							[1, AR_SPE],
							[1, AR_INT],
							[1, AR_LIB]
						]
				);

		public const LARGE_EGGS:Array = [L_BLKEG,L_BLUEG,L_BRNEG,L_PNKEG,L_PRPEG,L_WHTEG];
		public const SMALL_EGGS:Array = [BLACKEG,BLUEEGG,BROWNEG,PINKEGG,PURPLEG,WHITEEG];

		//ALCHEMICAL INGREDIANTS
		public const GINSENG: Consumable  = mk("Ginseng", "Ginseng", "a Ginseng", 6, "A plant of wich the fragant root is commonly used for perfume and cooking. If properly refined its alchemical property can also be used as a component to enhance potions.", m.Ginseng);
		public const HEALHERB: Consumable  = mk("HealHerb", "HealHerb", "a Healing herb", 6, "An herb with healing properties. Can be consumed directly or processed into a poultice.", m.HealingHerb);
		public const MOONGRASS: Consumable = mk("MoonGrass", "MoonGrass", "Moonlight grass", 6, "A tuft of grass with invigorative properties. Can be consumed directly or processed into a medicine.\n", m.MoonGrass);
		public const SNAKEBANE: Consumable = mk("SnakFlowr", "SnakFlowr", "a Snakebane flower", 6, "This flower can cure poison but, when alchemically processed, remove burns and frostburns as well. Can be consumed directly or processed into a medicine.", m.SnakeFlower);
		public const IRONWEED: Consumable  = mk("IronWeed", "IronWeed", "a Iron weed", 6, "This magical weed dulls one’s sense of pain and temporarily hardens the skin. Can be consumed directly or processed into a medicine.", m.Ironweed);
		public const BLADEFERN: Consumable = mk("BladeFerns", "BladeFerns", "a handfull of Blade ferns", 6, "This magical ferns helps the user temporarily generate more adrenaline and boosts the muscle mass, improving one’s strength and speed. Can be consumed directly or processed into a medicine.", m.BladeFerns);
		public const RAUNENECT: Consumable = mk("RauneNectar", "RauneNectar", "a bottle of Alaune nectar", 6, "A powerful aphrodisiac when consumed, Alraune nectar can be processed into a perfume, granting the user the infamous arousing scent of the alraunes as well as an alchemical resilience to lust. Can be consumed directly or processed into a perfume.", m.AlrauneNectar);

		private var mutations:Mutations;

		/**
		 * A handy function to create SimpleConsumables (useable by any player, effect is a function accepting player:Player,
		 * shortName, longName, description and value are const)
		 * @param id id. Must be String 7 chars long
		 * @param shortName shortName, null to use id as shortName
		 * @param longName null to use shortName as longName
		 * @param description null to use longName as description
		 * @param effect function(player:Player) called to produce effect
		 * @param  (default false) Tag item as transformative
		 */
		private static function mk(id:String, shortName:String, longName:String, value:Number, description:String, effect:Function, ...tags:/*String*/Array): Consumable {
			var item: Consumable = new SimpleConsumable(id, shortName, longName, effect, value, description);
			for each (var tag:String in tags) item.withTag(tag);
			return item;
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
}