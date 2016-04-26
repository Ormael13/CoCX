/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
	import classes.BaseContent;
	import classes.CoC;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Consumables.*;
	import classes.Player;

	public final class ConsumableLib extends BaseContent
	{
		//public var consumableItems:Array = [];
		
		public static const DEFAULT_VALUE:Number = 6;

		//DEMONIC POTIONS
		//Tainted
		public const INCUBID:SimpleConsumable = mk("IncubiD","IncubiD", "an Incubi draft", curry(m.incubiDraft, true), "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers.  A stylized picture of a humanoid with a huge penis is etched into the glass.");
		public const S_DREAM:SimpleConsumable = mk("S.Dream","S.Dream", "a bottle of 'Succubus' Dream'", m.succubisDream, "This precious fluid is often given to men a succubus intends to play with for a long time, though this batch has been enhanced by Lumi to have even greater potency.");
		public const SDELITE:SimpleConsumable = mk("SDelite","S.Delite", "a bottle of 'Succubi's Delight'", curry(m.succubisDelight, true),"This precious fluid is often given to men a succubus intends to play with for a long time.");
		public const SUCMILK:SimpleConsumable = mk("SucMilk","SucMilk", "a bottle of Succubi milk", curry(m.succubiMilk, true), "This milk-bottle is filled to the brim with a creamy white milk of dubious origin.  A pink label proudly labels it as \"<i>Succubi Milk</i>\".  In small text at the bottom of the label it reads: \"<i>To bring out the succubus in YOU!</i>\"");
		//Untainted
		public const P_DRAFT:SimpleConsumable = mk("P.Draft","P.Draft", "an untainted Incubi draft", curry(m.incubiDraft, false), "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers.  A stylized picture of a humanoid with a huge penis is etched into the glass. Rathazul has purified this to prevent corruption upon use.", 20);
		public const P_S_MLK:SimpleConsumable = mk("P.S.Mlk","P.S.Mlk", "an untainted bottle of Succubi milk", curry(m.succubiMilk, false), "This milk-bottle is filled to the brim with a creamy white milk of dubious origin.  A pink label proudly labels it as \"<i>Succubi Milk</i>\".  In small text at the bottom of the label it reads: \"<i>To bring out the succubus in YOU!</i>\"  Purified by Rathazul to prevent corruption.", 20);
		public const PSDELIT:SimpleConsumable = mk("PSDelit","PSDelit", "an untainted bottle of \"Succubi's Delight\"", curry(m.succubisDelight, false),  "This precious fluid is often given to men a succubus intends to play with for a long time.  It has been partially purified by Rathazul to prevent corruption.", 20);
		
		//DYES
		public const AUBURND:HairDye = new HairDye("AuburnD", "Auburn");
		public const BLACK_D:HairDye = new HairDye("Black D", "Black");
		public const BLOND_D:HairDye = new HairDye("Blond D", "Blond");
		public const BLUEDYE:HairDye = new HairDye("BlueDye", "Blue");
		public const BROWN_D:HairDye = new HairDye("Brown D", "Brown");
		public const GRAYDYE:HairDye = new HairDye("GrayDye", "Gray");
		public const GREEN_D:HairDye = new HairDye("Green D", "Green");
		public const ORANGDY:HairDye = new HairDye("OrangDy", "Orange");
		public const PINKDYE:HairDye = new HairDye("PinkDye", "Pink");
		public const PURPDYE:HairDye = new HairDye("PurpDye", "Purple");
		public const RAINDYE:HairDye = new HairDye("RainDye", "Rainbow");
		public const RED_DYE:HairDye = new HairDye("Red Dye", "Red");
		public const WHITEDY:HairDye = new HairDye("WhiteDy", "White");
		
		//SKIN OILS & BODY LOTIONS
		public const DARK_OL:SkinOil = new SkinOil("DarkOil", "Dark");
		public const EBONYOL:SkinOil = new SkinOil("EbonyOl", "Ebony");
		public const FAIR_OL:SkinOil = new SkinOil("FairOil", "Fair");
		public const LIGHTOL:SkinOil = new SkinOil("LightOl", "Light");
		public const MAHOGOL:SkinOil = new SkinOil("MahogOl", "Mahogany");
		public const OLIVEOL:SkinOil = new SkinOil("OliveOl", "Olive");
		public const RUSS_OL:SkinOil = new SkinOil("RussOil", "Russet");
		
		public const CLEARLN:BodyLotion = new BodyLotion("ClearLn", "Clear", "smooth thick creamy liquid");
		public const ROUGHLN:BodyLotion = new BodyLotion("RoughLn", "Rough", "thick abrasive cream");
		public const SEXY_LN:BodyLotion = new BodyLotion("SexyLtn", "Sexy", "pretty cream like substance");
		public const SMTH_LN:BodyLotion = new BodyLotion("SmthLtn", "Smooth", "smooth thick creamy liquid");
		
		//EGGS
		//Small
		public const BLACKEG:SimpleConsumable = mk("BlackEg","BlackEg", "a rubbery black egg", curry(m.blackRubberEgg, false), "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const BLUEEGG:SimpleConsumable = mk("BlueEgg","BlueEgg", "a blue and white mottled egg", curry(m.blueEgg, false), "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const BROWNEG:SimpleConsumable = mk("BrownEg","BrownEg", "a brown and white mottled egg", curry(m.brownEgg, false), "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const PINKEGG:SimpleConsumable = mk("PinkEgg","PinkEgg", "a pink and white mottled egg", curry(m.pinkEgg, false),"This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const PURPLEG:SimpleConsumable = mk("PurplEg","PurplEg", "a purple and white mottled egg", curry(m.purpleEgg, false),"This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const WHITEEG:SimpleConsumable = mk("WhiteEg", "WhiteEg", "a milky-white egg", curry(m.whiteEgg, false), "This is an oblong egg, not much different from a chicken egg in appearance.  Something tells you it's more than just food.");
		//Large
		public const L_BLKEG:SimpleConsumable = mk("L.BlkEg","L.BlkEg", "a large rubbery black egg", curry(m.blackRubberEgg, true), "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.  For all you know, it could turn you into rubber!");
		public const L_BLUEG:SimpleConsumable = mk("L.BluEg","L.BluEg", "a large blue and white mottled egg", curry(m.blueEgg, true),"This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const L_BRNEG:SimpleConsumable = mk("L.BrnEg","L.BrnEg", "a large brown and white mottled egg", curry(m.brownEgg, true),"This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const L_PNKEG:SimpleConsumable = mk("L.PnkEg","L.PnkEg", "a large pink and white mottled egg", curry(m.pinkEgg, true),"This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const L_PRPEG:SimpleConsumable = mk("L.PrpEg","L.PrpEg", "a large purple and white mottled egg", curry(m.purpleEgg, true),"This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const L_WHTEG:SimpleConsumable = mk("L.WhtEg","L.WhtEg", "a large white egg", curry(m.whiteEgg, true), "This is an oblong egg, not much different from an ostrich egg in appearance.  Something tells you it's more than just food.");
		//Others
		public const DRGNEGG:SimpleConsumable = mk("DrgnEgg","DrgnEgg","an unfertilized dragon egg", m.eatEmberEgg,"A large, solid egg, easily the size of your clenched fist.  Its shell color is reddish-white, with blue splotches.");
		public const NPNKEGG:SimpleConsumable = mk("NPnkEgg","NPnkEgg", "a neon pink egg", curry(m.neonPinkEgg,false), "This is an oblong egg with an unnatural neon pink coloration.  It tingles in your hand with odd energies that make you feel as if you could jump straight into the sky.");

		//FOOD & BEVERAGES
		public const BC_BEER:SimpleConsumable = mk("BC Beer", "BC Beer", "a mug of Black Cat Beer", function(player:Player):void { getGame().telAdre.niamh.blackCatBeerEffects(player) }, "A capped mug containing an alcoholic drink secreted from the breasts of Niamh.  It smells tasty.", 1);
		public const BHMTCUM:SimpleConsumable = mk("BhmtCum", "BhmtCum", "a sealed bottle of behemoth cum", m.behemothCum, "This bottle of behemoth cum looks thick and viscous.  You suspect that it might boost your strength and toughness.  It also has delicious taste.", 15);
		public const BIMBOCH:SimpleConsumable = mk("BimboCh","BimboCh", "a bottle of bimbo champagne", curry(function(player:Player):void{getGame().telAdre.niamh.bimboChampagne(player,true,true)}), "A bottle of bimbo champagne. Drinking this might incur temporary bimbofication.", 1);
		public const C_BREAD:CumBread         = new CumBread();
		public const CCUPCAK:SimpleConsumable = mk("CCupcak","CCupcak", "a gigantic, chocolate cupcake", m.giantChocolateCupcake, "A gigantic, chocolate cupcake. You could easily get full from eating this!", 250);
		public const FISHFIL:SimpleConsumable = mk("FishFil", "FishFil", "a fish fillet", m.fishFillet, "A perfectly cooked piece of fish.  You're not sure what type of fish is, since you're fairly certain \"delicious\" is not a valid species.");
		public const FR_BEER:SimpleConsumable = mk("Fr Beer", "Fr Beer", "a mug of frothy beer", m.frothyBeer, "A bottle of beer from The Black Cock.");
		public const GODMEAD:SimpleConsumable = mk("GodMead","GodMead", "a pint of god's mead", m.godMead,"A horn of potent, honey-colored mead. A single whiff makes your head swim and your thoughts turn to violence and heroism.");
		public const H_BISCU:SimpleConsumable = mk("H.Bisct", "H.Biscuits", "a pack of hard biscuits", m.hardBiscuits, "These biscuits are tasteless, but they can stay edible for an exceedingly long time.", 5);
		public const IZYMILK:SimpleConsumable = mk("IzyMilk","IzyMilk", "a bottle of Isabella's milk", m.isabellaMilk, "This is a bottle of Isabella's milk.  Isabella seems fairly certain it will invigorate you.");
		public const M__MILK:SimpleConsumable = mk("M. Milk","M. Milk", "a clear bottle of milk from Marble", m.useMarbleMilk, "A clear bottle of milk from Marble's breasts. It smells delicious.");
		public const MINOCUM:SimpleConsumable = mk("MinoCum", "MinoCum", "a sealed bottle of minotaur cum", curry(m.minotaurCum, false), "This bottle of minotaur cum looks thick and viscous.  You know it has narcotic properties, but aside from that its effects are relatively unknown.", 60);
		public const P_BREAD:SimpleConsumable = mk("P.Bread", "P.Bread", "a stale loaf of prison bread", m.prisonBread, "An impossibly hard loaf of stale bread.  Despite its age, still quite nutritious.");
		public const P_M_CUM:SimpleConsumable = mk("P.M.Cum","P.MinoCum", "a sealed bottle of purified minotaur cum", curry(m.minotaurCum, true), "This bottle of minotaur cum looks thick and viscous.  You know it has narcotic properties, but aside from that its effects are relatively unknown.  This bottle of cum has been purified to prevent corruption and addiction.", 80);
		public const P_WHSKY:PhoukaWhiskey    = new PhoukaWhiskey();
		public const PROMEAD:SimpleConsumable = mk("ProMead", "ProMead", "a pint of premium god\'s mead", m.proMead, null);
		public const PURPEAC:SimpleConsumable = mk("PurPeac", "PurPeac", "a pure peach", m.purityPeach, "This is a peach from Minerva's spring, yellowy-orange with red stripes all over it.", 10);
		public const SHEEPMK:SimpleConsumable = mk("SheepMk","SheepMk", "a bottle of sheep milk", m.sheepMilk,"This bottle of sheep milk is said to have corruption-fighting properties.  It may be useful.");
		public const S_WATER:SimpleConsumable = mk("S.Water", "SpringWtr", "a waterskin filled with spring water", m.springWater, "A waterskin full of purified water from Minerva's spring.  It's clean and clear, with a faint sweet scent to it.  You're sure it would be a very refreshing drink.");
		public const TRAILMX:SimpleConsumable = mk("TrailMx", "Trail Mix", "a pack of trail mix", m.trailMix, "This mix of nuts, dried fruits and berries is lightweight, easy to store and very nutritious.", 20);
		public const URTACUM:SimpleConsumable = mk("UrtaCum", "UrtaCum", "a sealed bottle of Urta's cum", m.urtaCum, "This bottle of Urta's cum looks thick and viscous.  It's quite delicious.", 15);
		public const W_PDDNG:SimpleConsumable = mk("W.Pddng","W.Pudding", "a slice of winter pudding", m.winterPudding,"A slice of delicious Winter Pudding.  It smells delicious. \n\nNote: Eating this might cause antlers to grow from your head.", 35);
 
		//GROWERS/SHRINKERS
		public const REDUCTO:Consumable = new Reducto();
		public const GROPLUS:Consumable = new GroPlus();
		
		//MAGIC BOOKS
		public const B__BOOK:SimpleConsumable = mk("B. Book","B. Book", "a small book with a midnight-black cover", m.blackSpellbook, "This solid black book is totally unmarked, saved for a blood red clasp that holds the covers closed until you are ready to read it.  The pages are edged with gold, like some of the fancy books in the monastary back home.", 40);
		public const W__BOOK:SimpleConsumable = mk("W. Book","W. Book", "a small book with a pristine white cover", m.whiteSpellbook, "This white book is totally unmarked, and the cover is devoid of any lettering or title.  A shiny brass clasp keeps the covers closed until you are ready to read it.", 40);
		
		//RARE ITEMS (Permanent effects, gives perks on consumption.)
		public const BIMBOLQ:BimboLiqueur = new BimboLiqueur();
		public const BROBREW:SimpleConsumable = mk("BroBrew","BroBrew", "a can of Bro Brew", m.broBrew, "This aluminum can is labelled as 'Bro Brew'.  It even has a picture of a muscly, bare-chested man flexing on it.  A small label in the corner displays: \"Demon General's Warning: Bro Brew's effects are as potent (and irreversible) as they are refreshing.", 1000);
		public const HUMMUS2:SimpleConsumable = mk("Hummus2","S.Hummus", "a blob of cheesy-looking super hummus", m.superHummus, "This pile of hummus doesn't look that clean, and you really don't remember where you got it from.  It looks bland.  So bland that you feel blander just by looking at it.");
		public const P_PEARL:SimpleConsumable = mk("P.Pearl","P.Pearl", "a pure pearl", m.purePearl, "Marae gave you this pure pearl as a reward for shutting down the demonic factory.", 1000);
		
		//NON-TRANSFORMATIVE ITEMS
		public const AKBALSL:SimpleConsumable = mk("AkbalSl","AkbalSlv", "a vial of Akbal's saliva", m.akbalSaliva,"This corked vial of Akbal's saliva is said to contain healing properties. ");
		public const C__MINT:SimpleConsumable = mk("C. Mint","C. Mint", "a calm mint", m.calmMint,"This is a sprig of silver-colored mint.  Its strong scent makes you feel calmer and less lustful.");
		public const CERUL_P:SimpleConsumable = mk("Cerul P","Cerulean P.", "a cerulean-tinted potion", m.ceruleanPotion, "This is a mysterious bottle filled with a sky-blue liquid that sloshes gently inside.  Supposedly it will make you irresistible, though to what or who you cannot say.");
		public const COAL___:SimpleConsumable = mk("Coal   ","Coal", "two pieces of coal", m.coal, "These two pieces of coal may look ordinary but it makes you wonder what happens when you rub them.");
		public const DEBIMBO:DeBimbo = new DeBimbo();
		public const EXTSERM:HairExtensionSerum = new HairExtensionSerum();
		public const F_DRAFT:SimpleConsumable = mk("F.Draft","FuckDraft", "a vial of roiling red fluid labeled \"Fuck Draft\"", curry(m.lustDraft, true), "This vial of red fluid bubbles constantly inside the glass, as if eager to escape.  It smells very strongly, though its odor is difficult to identify.  The word \"Fuck\" is inscribed on the side of the vial.");
		public const H_PILL:SimpleConsumable  = mk("H. Pill", "Heal Pill", "a small healing pill", m.healPill, "A small healing pill that's guaranteed to heal you by a bit.");
		public const HRBCNT:SimpleConsumable  = mk("HrblCnt", "HrblCnt", "a bundle of verdant green leaves", m.herbalContraceptive, "A small bundle of verdant green leaves.");
		public const ICICLE_:SimpleConsumable = mk("Icicle ","Icicle", "an ice shard", m.iceShard,"An icicle that seems to be incapable of melting.  It numbs your hands as you hold it. ");
		public const KITGIFT:KitsuneGift		= new KitsuneGift();
		public const L_DRAFT:SimpleConsumable = mk("L.Draft","LustDraft", "a vial of roiling bubble-gum pink fluid", curry(m.lustDraft,false), "This vial of bright pink fluid bubbles constantly inside the glass, as if eager to escape.  It smells very sweet, and has \"Lust\" inscribed on the side of the vial.", 20);
		public const LACTAID:SimpleConsumable = mk("Lactaid","Lactaid", "a pink bottle labelled \"Lactaid\"", m.lactaid, "Judging by the name printed on this bottle, 'Lactaid' probably has an effect on the ability to lactate, and you doubt that effect is a reduction.");
		public const LUSTSTK:LustStick        = new LustStick();
		public const MILKPTN:SimpleConsumable = mk("MilkPtn","ProLactaid", "a bottle labelled \"Pro Lactaid\"", m.milkPotion, "A bottle filled with white liquid which is distilled from Lactaid and LaBovas.  Rathazul mentioned that this potion will greatly improve your lactation. There's the possibility of permanently lactating, even if you're a male.", 120);
		public const NUMBOIL:SimpleConsumable = mk("NumbOil","Numb Oil", "a bottle of numbing oil", m.numbingOil, "This bottle feels a bit warm to the touch. From the look of the label on the bottle of oil, you suspect this will make you less sensitive.", 100);
		public const NUMBROX:SimpleConsumable = mk("NumbRox","Numb Rox", "a strange packet of candy called 'Numb Rocks'", m.numbRocks, "This packet of innocuous looking 'candy' guarantees to reduce troublesome sensations and taste delicious.", 15);
		public const OVIELIX:OvipositionElixir = new OvipositionElixir();
		public const PEPPWHT:SimpleConsumable = mk("PeppWht","PeppWht", "a vial of peppermint white", function(player:Player):void{getGame().xmas.xmasMisc.peppermintWhite(player)}, "This tightly corked glass bottle gives of a pepperminty smell and reminds you of the winter holidays.  How odd.", 120);
		public const PPHILTR:SimpleConsumable = mk("PPhiltr","P.Philter", "a vial of purity philter", m.purityPhilter, "This silver vial feels cool to the touch. In fact, it feels a bit cold. Given the label, you suspect this will help to erase corruption.", 100);
		public const PRNPKR :SimpleConsumable  = mk("PrnsPkr", "P.Pucker", "a vial of pinkish fluid", m.princessPucker, "A vial filled with a viscous pink liquid. A label reads \"Princess Pucker\".");
		public const SENSDRF:SimpleConsumable = mk("SensDrf","SensDraft", "a bottle of sensitivity draft", m.sensitivityDraft, "This carefully labelled potion is a 'Sensitivity Draft', and if the diagrams are any indication, it will make your body more sensitive.", 15);
		public const SMART_T:SimpleConsumable = mk("Smart T","Scholars T.", "a cup of scholar's tea", m.scholarsTea, "This powerful brew supposedly has mind-strengthening effects.");
		public const VITAL_T:SimpleConsumable = mk("Vital T", "Vitality T.", "a vitality tincture", m.vitalityTincture, "This potent tea is supposedly good for the strengthening the body.");
		public const W_STICK:WingStick = new WingStick();
		
		//TRANSFORMATIVE ITEMS
		public const B_GOSSR:SimpleConsumable = mk("B.Gossr","B.Gossr", "a bundle of black, gossamer webbing", curry(m.sweetGossamer, 1), "These strands of gooey black gossamer seem quite unlike the normal silk that driders produce.  It smells sweet and is clearly edible, but who knows what it might do to you?");
		public const BEEHONY:BeeHoney         = new BeeHoney(false, false);
		public const BLACKPP:SimpleConsumable = mk("BlackPp","BlackPp", "a solid black canine pepper", curry(m.caninePepper, 3), "This solid black canine pepper is smooth and shiny, but something about it doesn't seem quite right...", 10);
		public const BOARTRU:SimpleConsumable = mk("BoarTru", "BoarTruffle", "a boar truffle", curry(m.pigTruffle, true), "It’s clear where the pigtail truffle gets its name.  A small, curly sprig resembling a pig’s tail can be seen jutting out of it. Now that it’s been enhanced by Lumi, it’s larger and fuzzier than it was before, almost like a peach.");
		public const BULBYPP:SimpleConsumable = mk("BulbyPp","BulbyPp", "a bulbous pepper", curry(m.caninePepper, 5), "This bulbous pepper has a slightly different shape than the other canine peppers, with two large orb-like protrusions at the base.", 10);
		public const CANINEP:SimpleConsumable = mk("CanineP","CanineP", "a Canine pepper", curry(m.caninePepper,0), "The pepper is shiny and red, bulbous at the base but long and narrow at the tip.  It smells spicy.");
		public const DBLPEPP:SimpleConsumable = mk("DblPepp","DblPepp", "a double canine pepper", curry(m.caninePepper, 2), "This canine pepper is actually two that have grown together due to some freak coincidence.", 10);
		public const DRAKHRT:SimpleConsumable = mk("DrakHrt","DrakeHeart", "a drake's heart's flower", curry(m.drakeHeart), "A rare, beautiful flower.  It could make an exquisite perfume.  According to a legend, dragons give this flower to the ones they intend to court.", 50);
		public const DRYTENT:SimpleConsumable = mk("DryTent","DryTent", "a shriveled tentacle", m.shriveledTentacle, "A dried tentacle from one of the lake anemones.  It's probably edible, but the stingers are still a little active.");
		public const ECTOPLS:SimpleConsumable = mk("EctoPls","EctoPls", "a bottle of ectoplasm", m.ectoplasm, "The green-tinted, hardly corporeal substance flows like a liquid inside its container. It makes you feel... uncomfortable, as you observe it.");
		public const EQUINUM:SimpleConsumable = mk("Equinum","Equinum", "a vial of Equinum", m.equinum, "This is a long flared vial with a small label that reads, \"<i>Equinum</i>\".  It is likely this potion is tied to horses in some way.");
		public const FOXBERY:SimpleConsumable = mk("FoxBery","Fox Berry", "a fox berry", curry(m.foxTF,false), "This large orange berry is heavy in your hands.  It may have gotten its name from its bright orange coloration.  You're certain it is no mere fruit.");
		public const FRRTFRT:SimpleConsumable = mk("Frrtfrt","FerretFrt","a ferret fruit", m.ferretTF, "This fruit is curved oddly, just like the tree it came from.  The skin is fuzzy and brown, like the skin of a peach.");
		public const FOXJEWL:SimpleConsumable = mk("FoxJewl", "Fox Jewel", "a fox jewel", curry(m.foxJewel, false), "A shining teardrop-shaped jewel.  An eerie blue flame dances beneath the surface.");
		public const GLDRIND:GoldenRind       = new GoldenRind();
		public const GLDSEED:SimpleConsumable = mk("GldSeed","GoldenSeed", "a golden seed", curry(m.goldenSeed,0),"This seed looks and smells absolutely delicious.  Though it has an unusual color, the harpies prize these nuts as delicious treats.  Eating one might induce some physical transformations.");
		public const GOB_ALE:SimpleConsumable = mk("Gob.Ale","Gob.Ale", "a flagon of potent goblin ale", m.goblinAle, "This sealed flagon of 'Goblin Ale' sloshes noisily with alcoholic brew.  Judging by the markings on the flagon, it's a VERY strong drink, and not to be trifled with.");
		public const HUMMUS_:SimpleConsumable = mk("Hummus ","Hummanus", "a jar of cheesy-looking hummus", m.regularHummus, "This small clay jar contains a substance known as hummus. Given the label, it's probably going to help you regain lost humanity.", 100);
		public const IMPFOOD:SimpleConsumable = mk("ImpFood","ImpFood", "a parcel of imp food", m.impFood, "This is a small parcel of reddish-brown bread stuffed with some kind of meat.  It smells delicious.");
		public const KANGAFT:SimpleConsumable = mk("KangaFt","KangaFruit", "a piece of kanga fruit", curry(m.kangaFruit,0),"A yellow, fibrous, tubular pod.  A split in the end reveals many lumpy, small seeds inside.  The smell of mild fermentation wafts from them.");
		public const KNOTTYP:SimpleConsumable = mk("KnottyP","KnottyP", "a knotty canine pepper", curry(m.caninePepper, 4), "This knotted pepper is very swollen, with a massive, distended knot near the base.", 10);
		public const LABOVA_:SimpleConsumable = mk("LaBova ","La Bova", "a bottle containing a misty fluid labeled \"LaBova\"", curry(m.laBova,true,false), "A bottle containing a misty fluid with a grainy texture, it has a long neck and a ball-like base.  The label has a stylized picture of a well endowed cowgirl nursing two guys while they jerk themselves off.");
		public const LARGEPP:SimpleConsumable = mk("LargePp","LargePp", "an overly large canine pepper", curry(m.caninePepper, 1), "This large canine pepper is much bigger than any normal peppers you've seen.", 10);
		public const MAGSEED:SimpleConsumable = mk("MagSeed","MagSeed", "a magically-enhanced golden seed", curry(m.goldenSeed, 1),"This seed glows with power.  It's been enhanced by Lumi to unlock its full potential, allowing it to transform you more easily.");
		public const MGHTYVG:SimpleConsumable = mk("MghtyVg","MghtyVg", "a mightily enhanced piece of kanga fruit", curry(m.kangaFruit, 1),"A yellow, fibrous, tubular pod.  A split in the end reveals many lumpy, small seeds inside.  The smell of mild fermentation wafts from them.  It glows slightly from Lumi's enhancements.");
		public const MOUSECO:SimpleConsumable = mk("MouseCo","MouseCo", "a handful of mouse cocoa", m.mouseCocoa, "A handful of rare aromatic beans with sharp creases in the middle, making them look like small mouse ears.  Allegedly very popular and plentiful before the mice-folk were wiped out.");
		public const MINOBLO:SimpleConsumable = mk("MinoBlo","MinoBlo", "a vial of Minotaur blood", m.minotaurBlood, "You've got a scratched up looking vial full of bright red minotaur blood.  Any time you move it around it seems to froth up, as if eager to escape.");
		public const MYSTJWL:SimpleConsumable = mk("MystJwl","MystJwl", "a mystic jewel", curry(m.foxJewel, true), "The flames within this jewel glow brighter than before, and have taken on a sinister purple hue.  It has been enhanced to increase its potency, allowing it to transform you more easily, but may have odd side-effects...", 20);
		public const P_LBOVA:SimpleConsumable = mk("P.LBova", "P.LBova", "a bottle containing a white fluid labeled \"Pure LaBova\"", curry(m.laBova, false, false), "A bottle containing a misty fluid with a grainy texture; it has a long neck and a ball-like base.  The label has a stylized picture of a well-endowed cow-girl nursing two guys while they jerk themselves off. It has been purified by Rathazul.");
		public const PIGTRUF:SimpleConsumable = mk("PigTruf", "PigTruffle", "a pigtail truffle", curry(m.pigTruffle, false), "It’s clear where this fungus gets its name.  A small, curly sprig resembling a pig’s tail can be seen jutting out of it.");
		public const PRFRUIT:SimpleConsumable = mk("PrFruit","PrFruit", "a purple fruit", m.purpleFruitEssrayle, "This sweet-smelling produce looks like an eggplant, but feels almost squishy, and rubbery to the touch. Holding it to your ear, you think you can hear some fluid sloshing around inside.");
		public const PROBOVA:SimpleConsumable = mk("ProBova","ProBova", "a bottle containing a misty fluid labeled \"ProBova\"", curry(m.laBova, true, true), "This cloudy potion has been enhanced by the alchemist Lumi to imbue its drinker with cow-like attributes.");
		public const PURHONY:BeeHoney			= new BeeHoney(true, false);
		public const REPTLUM:SimpleConsumable = mk("Reptlum","Reptilum", "a vial of Reptilum", m.reptilum, "This is a rounded bottle with a small label that reads, \"<i>Reptilum</i>\".  It is likely this potion is tied to reptiles in some way.");
		public const RINGFIG:SimpleConsumable = mk("RingFig","RingFig","a ringtail fig", m.ringtailFig,"A dried fig with two lobes and thin dark rings just below its stem.  The skin is wrinkly and it looks vaguely like a bulging scrotum.");
		public const RIZZART:RizzaRoot			= new RizzaRoot();
		public const S_GOSSR:SimpleConsumable = mk("S.Gossr","S.Gossr", "a bundle of pink, gossamer webbing", curry(m.sweetGossamer,0), "These strands of gooey pink gossamer seem quite unlike the normal silk that spider-morphs produce.  It smells sweet and is clearly edible, but who knows what it might do to you?");
		public const SALAMFW:SimpleConsumable = mk("SalamFW","SalamFW", "a hip flask of Salamander Firewater", m.salamanderfirewater, "This hip flask contain high-proof beverage called 'Salamander Firewater', which one sip can makes your throat feel like it been set on fire.  What whould happen if you drink whole flask content?");
		public const SATYR_W:SatyrWine        = new SatyrWine();
		public const SHARK_T:SimpleConsumable = mk("Shark.T","Shark.T", "a sharp shark tooth", curry(m.sharkTooth,0), "A glinting white tooth, very sharp and intimidating.");
		public const SNAKOIL:SimpleConsumable = mk("SnakOil", "SnakOil", "a vial of snake oil", m.snakeOil, "A vial the size of your fist made of dark brown glass. It contains what appears to be an oily, yellowish liquid. The odor is abominable.");
		public const SPHONEY:Consumable		  = new BeeHoney(false, true);
		public const TAURICO:SimpleConsumable = mk("Taurico","Taurinum", "a vial of Taurinum", m.taurinum, "This is a long flared vial with a small label that reads, \"<i>Taurinum</i>\".  It is likely this potion is tied to centaurs in some way.");
		public const TRAPOIL:SimpleConsumable = mk("TrapOil","TrapOil", "a vial of trap oil", m.trapOil, "A round, opaque glass vial filled with a clear, viscous fluid.  It has a symbol inscribed on it, a circle with a cross and arrow pointing out of it in opposite directions.  It looks and smells entirely innocuous.");
		public const TSCROLL:SimpleConsumable = mk("TScroll","TScroll", "a tattered scroll", m.tatteredScroll, "This tattered scroll is written in strange symbols, yet you have the feeling that if you tried to, you could decipher it.");
		public const TSTOOTH:SimpleConsumable = mk("TSTooth","TSTooth", "a glowing tiger shark tooth", curry(m.sharkTooth, 1),"This looks like a normal shark tooth, though with an odd purple glow.");
		public const VIXVIGR:SimpleConsumable = mk("VixVigr","VixVigr", "a bottle labelled \"Vixen's Vigor\"", curry(m.foxTF, true), "This small medicine bottle contains something called \"Vixen's Vigor\", supposedly distilled from common fox-berries.  It is supposed to be a great deal more potent, and a small warning label warns of \"extra boobs\", whatever that means.", 30);
		public const W_FRUIT:SimpleConsumable = mk("W.Fruit","W.Fruit", "a piece of whisker-fruit", m.catTransformation, "This small, peach-sized fruit has tiny whisker-like protrusions growing from the sides.");
		public const WETCLTH:SimpleConsumable = mk("WetClth","WetClth", "a wet cloth dripping with slippery slime", m.gooGasmic, "Dripping with a viscous slime, you've no doubt rubbing this cloth on your body would have some kind of strange effect.");
		public const WOLF_PP:SimpleConsumable = mk("Wolf Pp","WolfPepper", "a Wolf pepper", curry(m.caninePepper, 6), "The pepper is shiny and black, bulbous at the base but long and narrow at the tip.  It has a fuzzy feel to it and it smells spicy.", 10);

		public const LARGE_EGGS:Array = [L_BLKEG,L_BLUEG,L_BRNEG,L_PNKEG,L_PRPEG,L_WHTEG];
		public const SMALL_EGGS:Array = [BLACKEG,BLUEEGG,BROWNEG,PINKEGG,PURPLEG,WHITEEG];
		public var mutations:Mutations;

		/**
		 * A handy function to create SimpleConsumables (useable by any player, effect is a function accepting player:Player,
		 * shortName, longName, description and value are const)
		 * @param id id. Must be String 7 chars long
		 * @param shortName shortName, null to use id as shortName
		 * @param longName null to use shortName as longName
		 * @param effect function(player:Player) called to produce effect
		 * @param description null to use longName as description
		 */
		private static function mk(id:String, shortName:String, longName:String, effect:Function, description:String, value:Number = DEFAULT_VALUE):SimpleConsumable {
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
