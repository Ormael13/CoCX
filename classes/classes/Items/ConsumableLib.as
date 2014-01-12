/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
	import classes.BaseContent;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Consumables.DeBimbo;
	import classes.Items.Consumables.LustStick;
	import classes.Items.Consumables.SimpleConsumable;
	import classes.Items.Consumables.WingStick;

	public class ConsumableLib extends BaseContent
	{
		public static const DEFAULT_VALUE:Number = 6;

		public const AUBURND:SimpleConsumable = mk("AuburnD", "a vial of auburn hair dye", curry(m.hairDye, "auburn"),"This bottle of dye will allow you to change the color of your hair.  Of course if you don't have hair, using this would be a waste.");
		public const B__BOOK:SimpleConsumable = mk("B. Book", "a small book with a midnight-black cover", m.blackSpellbook, "This solid black book is totally unmarked, saved for a blood red clasp that holds the covers closed until you are ready to read it.  The pages are edged with gold, like some of the fancy books in the monastary back home.", 40);
		public const B_GOSSR:SimpleConsumable = mk("B.Gossr", "a bundle of black, gossamer webbing", curry(m.sweetGossamer, 1), "These strands of gooey black gossamer seem quite unlike the normal silk that driders produce.  It smells sweet and is clearly edible, but who knows what it might do to you?");
		public const BC_BEER:SimpleConsumable = mk("BC Beer", "a mug of Black Cat Beer", kGAMECLASS.telAdre.niamh.blackCatBeerEffects, "A capped mug containing an alcoholic drink secreted from the breasts of Niamh.  It smells tasty.", 1);
		public const BEEHONY:SimpleConsumable = mk("BeeHony", "a small vial filled with giant-bee honey", curry(m.pureHoney, false), "This fine crystal vial is filled with a thick amber liquid that glitters dully in the light.  You can smell a sweet scent, even though it is tightly corked.");
		public const BIMBOCH:SimpleConsumable = mk("BimboCh", "a bottle of bimbo champagne", curry(kGAMECLASS.telAdre.niamh.bimboChampagne, true, true), null, 1);
		public const BIMBOLQ:SimpleConsumable = mk("BimboLq", "a potent bottle of 'Bimbo Liqueur'", m.bimboLiquer, "This small bottle of liqueur is labelled 'Bimbo Liqueur'.  There's a HUGE warning label about the effects being strong and usually permanent, so you should handle this with care.", 1000);
		public const BLACK_D:SimpleConsumable = mk("Black D", "a vial of black hair dye", curry(m.hairDye, "black"),"This bottle of dye will allow you to change the color of your hair.  Of course if you don't have hair, using this would be a waste.");
		public const BLACKEG:SimpleConsumable = mk("BlackEg", "a rubbery black egg", curry(m.blackRubberEgg, false), "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const BLACKPP:SimpleConsumable = mk("BlackPp", "a solid black canine pepper", curry(m.caninePepper, 3), "This solid black canine pepper is smooth and shiny, but something about it doesn't seem quite right...", 10);
		public const BLOND_D:SimpleConsumable = mk("Blond D", "a vial of blonde hair dye", curry(m.hairDye, "blonde"),"This bottle of dye will allow you to change the color of your hair.  Of course if you don't have hair, using this would be a waste.");
		public const BLUEDYE:SimpleConsumable = mk("BlueDye", "a vial of blue hair dye", curry(m.hairDye, "dark blue"),"This bottle of dye will allow you to change the color of your hair.  Of course if you don't have hair, using this would be a waste.");
		public const BLUEEGG:SimpleConsumable = mk("BlueEgg", "a blue and white mottled egg", curry(m.blueEgg, false), "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const BROBREW:SimpleConsumable = mk("BroBrew", "a can of Bro Brew", m.broBrew, "This aluminum can is labelled as 'Bro Brew'.  It even has a picture of a muscly, bare-chested man flexing on it.  A small label in the corner displays: \"Demon General's Warning: Bro Brew's effects are as potent (and irreversible) as they are refreshing.\"");
		public const BROWN_D:SimpleConsumable = mk("Brown D", "a vial of brown hair dye", curry(m.hairDye, "brown"),"This bottle of dye will allow you to change the color of your hair.  Of course if you don't have hair, using this would be a waste.");
		public const BROWNEG:SimpleConsumable = mk("BrownEg", "a brown and white mottled egg", curry(m.brownEgg, false), "This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const BULBYPP:SimpleConsumable = mk("BulbyPp", "a bulbous pepper", curry(m.caninePepper, 5), "This bulbous pepper has a slightly different shape than the other canine peppers, with two large orb-like protrusions at the base.", 10);
		public const CANINEP:SimpleConsumable = mk("CanineP", "a Canine pepper", m.caninePepper, "The pepper is shiny and red, bulbous at the base but long and narrow at the tip.  It smells spicy.");
		public const CCUPCAK:SimpleConsumable = mk("CCupcak", "a gigantic, chocolate cupcake", m.giantChocolateCupcake, null, 250);
		public const CERUL_P:SimpleConsumable = mk("Cerul P", "a cerulean-tinted potion", m.ceruleanPotion, "This is a mysterious bottle filled with a sky-blue liquid that sloshes gently inside.  Supposedly it will make you irresistible, though to what or who you cannot say.");
		public const COAL___:SimpleConsumable = mk("Coal   ", "two pieces of coal", m.coal);
		public const DBLPEPP:SimpleConsumable = mk("DblPepp", "a double canine pepper", curry(m.caninePepper, 2), "This canine pepper is actually two that have grown together due to some freak coincidence.", 10);
		public const DEBIMBO:DeBimbo = new DeBimbo();
		public const DRGNEGG:SimpleConsumable = mk("DrgnEgg","an unfertilized dragon egg", m.eatEmberEgg,"A large, solid egg, easily the size of your clenched fist.  Its shell color is reddish-white, with blue splotches.");
		public const DRYTENT:SimpleConsumable = mk("DryTent", "a shriveled tentacle", m.shriveledTentacle, "A dried tentacle from one of the lake anemones.  It's probably edible, but the stingers are still a little active.");
		public const ECTOPLS:SimpleConsumable = mk("EctoPls", "a bottle of ectoplasm", m.ectoplasm, "The green-tinted, hardly corporeal substance flows like a liquid inside its container. It makes you feel... uncomfortable, as you observe it.");
		public const EQUINUM:SimpleConsumable = mk("Equinum", "a vial of Equinum", m.equinum, "This is a long flared vial with a small label that reads, \"<i>Equinum</i>\".  It is likely this potion is tied to horses in some way.");
		public const EXTSERM:SimpleConsumable = mk("ExtSerm", "a bottle of hair extension serum", m.extensionSerum, "This is a bottle of foamy pink liquid, purported by the label to increase the speed at which the user's hair grows.");
		public const F_DRAFT:SimpleConsumable = mk("F.Draft", "a vial of roiling red fluid labeled \"Fuck Draft\"", curry(m.lustDraft, true), "This vial of red fluid bubbles constantly inside the glass, as if eager to escape.  It smells very strongly, though its odor is difficult to identify.  The word \"Fuck\" is inscribed on the side of the vial.");
		public const FISHFIL:SimpleConsumable = mk("FishFil", "a fish fillet", m.fishFillet, "A perfectly cooked piece of fish.  You're not sure what type of fish is, since you're fairly certain \"delicious\" is not a valid species.");
		public const FOXBERY:SimpleConsumable = mk("FoxBery", "a fox berry", m.foxTF, "This large orange berry is heavy in your hands.  It may have gotten its name from its bright orange coloration.  You're certain it is no mere fruit.");
		public const FOXJEWL:SimpleConsumable = mk("FoxJewl", "a fox jewel", m.foxJewel, "A shining teardrop-shaped jewel.  An eerie blue flame dances beneath the surface.");
		public const GLDSEED:SimpleConsumable = mk("GldSeed", "a golden seed", m.goldenSeed,"This seed looks and smells absolutely delicious.  Though it has an unusual color, the harpies prize these nuts as delicious treats.  Eating one might induce some physical transformations.");
		public const GODMEAD:SimpleConsumable = mk("GodMead", "a pint of god's mead", m.godMead);
		public const GOB_ALE:SimpleConsumable = mk("Gob.Ale", "a flagon of potent goblin ale", m.goblinAle, "This sealed flagon of 'Goblin Ale' sloshes noisily with alcoholic brew.  Judging by the markings on the flagon, it's a VERY strong drink, and not to be trifled with.");
		public const GRAYDYE:SimpleConsumable = mk("GrayDye", "a vial of gray hair dye", curry(m.hairDye, "gray"),"This bottle of dye will allow you to change the color of your hair.  Of course if you don't have hair, using this would be a waste.");
		public const GROPLUS:SimpleConsumable = mk("GroPlus", "a needle filled with Gro+", m.growPlus, "This is a small needle with a resevoir full of blue liquid.  A faded label marks it as 'GroPlus'.  Its purpose seems obvious.", 50);
		public const HUMMUS_:SimpleConsumable = mk("Hummus ", "a blob of cheesy-looking hummus", m.Hummus, "This pile of hummus doesn't look that clean, and you really don't remember where you got it from.  It looks bland.  So bland that you feel blander just by looking at it.");
		public const IMPFOOD:SimpleConsumable = mk("ImpFood", "a parcel of imp food", m.impFood, "This is a small parcel of reddish-brown bread stuffed with some kind of meat.  It smells delicious.");
		public const INCUBID:SimpleConsumable = mk("IncubiD", "an Incubi draft", curry(m.incubiDraft, true), "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers.  A stylized picture of a humanoid with a huge penis is etched into the glass.");
		public const IZYMILK:SimpleConsumable = mk("IzyMilk", "a bottle of Isabella's milk", m.isabellaMilk, "This is a bottle of Isabella's milk.  Isabella seems fairly certain it will invigorate you.");
		public const KANGAFT:SimpleConsumable = mk("KangaFt", "a piece of kanga fruit", m.kangaFruit,"A yellow, fibrous, tubular pod.  A split in the end reveals many lumpy, small seeds inside.  The smell of mild fermentation wafts from them.");
		public const KITGIFT:SimpleConsumable = mk("KitGift", "a kitsune's gift", m.kitsunesGift, "A small square package given to you by a forest kitsune.  It is wrapped up in plain white paper and tied with a string.  Who knows what's inside?", 0);
		public const KNOTTYP:SimpleConsumable = mk("KnottyP", "a knotty canine pepper", curry(m.caninePepper, 4), "This knotted pepper is very swollen, with a massive, distended knot near the base.", 10);
		public const L_DRAFT:SimpleConsumable = mk("L.Draft", "a vial of roiling bubble-gum pink fluid", m.lustDraft, "This vial of bright pink fluid bubbles constantly inside the glass, as if eager to escape.  It smells very sweet, and has \"Lust\" inscribed on the side of the vial.", 20);
		public const L_BLKEG:SimpleConsumable = mk("L.BlkEg", "a large rubbery black egg", curry(m.blackRubberEgg, true), "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.  For all you know, it could turn you into rubber!");
		public const L_BLUEG:SimpleConsumable = mk("L.BluEg", "a large blue and white mottled egg", curry(m.blueEgg, true),"This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const L_BRNEG:SimpleConsumable = mk("L.BrnEg", "a large brown and white mottled egg", curry(m.brownEgg, true),"This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const L_PNKEG:SimpleConsumable = mk("L.PnkEg", "a large pink and white mottled egg", curry(m.pinkEgg, true),"This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const L_PRPEG:SimpleConsumable = mk("L.PrpEg", "a large purple and white mottled egg", curry(m.purpleEgg, true),"This is an oblong egg, not much different from an ostrich egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const L_WHTEG:SimpleConsumable = mk("L.WhtEg", "a large white egg", curry(m.whiteEgg, true), "This is an oblong egg, not much different from an ostrich egg in appearance.  Something tells you it's more than just food.");
		public const LABOVA_:SimpleConsumable = mk("LaBova ", "a bottle containing a misty fluid labeled \"LaBova\"", m.laBova, "A bottle containing a misty fluid with a grainy texture, it has a long neck and a ball-like base.  The label has a stylized picture of a well endowed cowgirl nursing two guys while they jerk themselves off.");
		public const LACTAID:SimpleConsumable = mk("Lactaid", "a pink bottle labelled \"Lactaid\"", m.lactaid, "Judging by the name printed on this bottle, 'Lactaid' probably has an effect on the ability to lactate, and you doubt that effect is a reduction.");
		public const LARGEPP:SimpleConsumable = mk("LargePp", "an overly large canine pepper", curry(m.caninePepper, 1), "This large canine pepper is much bigger than any normal peppers you've seen.", 10);
		public const LUSTSTK:LustStick = new LustStick();
		public const M__MILK:SimpleConsumable = mk("M. Milk", "a clear bottle of milk from Marble", m.useMarbleMilk, "A clear bottle of milk from Marble's breasts. It smells delicious.");
		public const MAGSEED:SimpleConsumable = mk("MagSeed", "a magically-enhanced golden seed", curry(m.goldenSeed, 1),"This seed glows with power.  It's been enhanced by Lumi to unlock its full potential, allowing it to transform you more easily.");
		public const MGHTYVG:SimpleConsumable = mk("MghtyVg", "a mightily enhanced piece of kanga fruit", curry(m.kangaFruit, 1),"A yellow, fibrous, tubular pod.  A split in the end reveals many lumpy, small seeds inside.  The smell of mild fermentation wafts from them.  It glows slightly from Lumi's enhancements.");
		public const MOUSECO:SimpleConsumable = mk("MouseCo", "a handful of mouse cocoa", m.mouseCocoa, "A handful of rare aromatic beans with sharp creases in the middle, making them look like small mouse ears.  Allegedly very popular and plentiful before the mice-folk were wiped out.");
		public const MINOBLO:SimpleConsumable = mk("MinoBlo", "a vial of Minotaur blood", m.minotaurBlood, "You've got a scratched up looking vial full of bright red minotaur blood.  Any time you move it around it seems to froth up, as if eager to escape.");
		public const MINOCUM:SimpleConsumable = mk("MinoCum", "a sealed bottle of minotaur cum", m.minotaurCum, "This bottle of minotaur cum looks thick and viscous.  You know it has narcotic properties, but aside from that its effects are relatively unknown.", 60);
		public const MYSTJWL:SimpleConsumable = mk("MystJwl", "a mystic jewel", curry(m.foxJewel, true), "The flames within this jewel glow brighter than before, and have taken on a sinister purple hue.  It has been enhanced to increase its potency, allowing it to transform you more easily, but may have odd side-effects...", 20);
		public const NUMBROX:SimpleConsumable = mk("NumbRox", "a strange packet of candy called 'Numb Rocks'", m.numbRocks, "This packet of innocuous looking 'candy' guarantees to reduce troublesome sensations and taste delicious.", 15);
		public const NPNKEGG:SimpleConsumable = mk("NPnkEgg", "a neon pink egg", m.neonPinkEgg, "This is an oblong egg with an unnatural neon pink coloration.  It tingles in your hand with odd energies that make you feel as if you could jump straight into the sky.");
		public const ORANGDY:SimpleConsumable = mk("OrangDy", "a vial of brilliant orange hair dye", curry(m.hairDye, "bright orange"),"This bottle of dye will allow you to change the color of your hair.  Of course if you don't have hair, using this would be a waste.");
		public const OVIELIX:SimpleConsumable = mk("OviElix", "a hexagonal crystal bottle tagged with an image of an egg", m.ovipositionElixer, "This hexagonal crystal bottle is filled with a strange green fluid.  A tag with a picture of an egg is tied to the neck of the bottle, indicating it is somehow connected to egg-laying.", 30);
		public const P_DRAFT:SimpleConsumable = mk("P.Draft", "an untainted Incubi draft", curry(m.incubiDraft, false), "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers.  A stylized picture of a humanoid with a huge penis is etched into the glass. Rathazul has purified this to prevent corruption upon use.", 20);
		public const P_LBOVA:SimpleConsumable = mk("P.LBova", "a bottle containing a white fluid labeled \"Pure LaBova\"", curry(m.laBova, false, false),"A bottle containing a misty fluid with a grainy texture; it has a long neck and a ball-like base.  The label has a stylized picture of a well-endowed cow-girl nursing two guys while they jerk themselves off. It has been purified by Rathazul.");
		public const P_PEARL:SimpleConsumable = mk("P.Pearl", "a pure pearl", m.purePearl, null,1000);
		public const P_S_MLK:SimpleConsumable = mk("P.S.Mlk", "an untainted bottle of Succubi milk", curry(m.succubiMilk, false), "This milk-bottle is filled to the brim with a creamy white milk of dubious origin.  A pink label proudly labels it as \"<i>Succubi Milk</i>\".  In small text at the bottom of the label it reads: \"<i>To bring out the succubus in YOU!</i>\"  Purified by Rathazul to prevent corruption.", 20);
		public const PEPPWHT:SimpleConsumable = mk("PeppWht", "a vial of peppermint white", kGAMECLASS.peppermintWhite, "This tightly corked glass bottle gives of a pepperminty smell and reminds you of the winter holidays.  How odd.", 120);
		public const PINKDYE:SimpleConsumable = mk("PinkDye", "a vial of bright pink hair dye", curry(m.hairDye, "neon pink"),"This bottle of dye will allow you to change the color of your hair.  Of course if you don't have hair, using this would be a waste.");
		public const PINKEGG:SimpleConsumable = mk("PinkEgg", "a pink and white mottled egg", curry(m.pinkEgg, false),"This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const PRFRUIT:SimpleConsumable = mk("PrFruit", "a purple fruit", m.purpleFruitEssrayle, "This sweet-smelling produce looks like an eggplant, but feels almost squishy, and rubbery to the touch. Holding it to your ear, you think you can hear some fluid sloshing around inside.");
		public const PROBOVA:SimpleConsumable = mk("ProBova", "a bottle containing a misty fluid labeled \"ProBova\"", curry(m.laBova, true, true), "This cloudy potion has been enhanced by the alchemist Lumi to imbue its drinker with cow-like attributes.");
		public const PSDELIT:SimpleConsumable = mk("PSDelit", "an untainted bottle of \"Succubi's Delight\"", curry(m.succubisDelight, false),  "This precious fluid is often given to men a succubus intends to play with for a long time.  It has been partially purified by Rathazul to prevent corruption.", 20);
		public const PURHONY:SimpleConsumable = mk("PurHony", "a crystal vial filled with glittering honey", curry(m.pureHoney, true), "This fine crystal vial is filled with a thick amber liquid that glitters in the light.  You can smell a sweet scent, even though it is tightly corked.", 40);
		public const PURPDYE:SimpleConsumable = mk("PurpDye", "a vial of purple hair dye", curry(m.hairDye, "purple"),"This bottle of dye will allow you to change the color of your hair.  Of course if you don't have hair, using this would be a waste.");
		public const PURPEAC:SimpleConsumable = mk("PurPeac", "a pure peach", m.purityPeach, "This is a peach from Minerva's spring, yellowy-orange with red stripes all over it.", 10);
		public const PURPLEG:SimpleConsumable = mk("PurplEg", "a purple and white mottled egg", curry(m.purpleEgg, false),"This is an oblong egg, not much different from a chicken egg in appearance (save for the color).  Something tells you it's more than just food.");
		public const RED_DYE:SimpleConsumable = mk("Red Dye", "a vial of red hair dye", curry(m.hairDye, "red"),"This bottle of dye will allow you to change the color of your hair.  Of course if you don't have hair, using this would be a waste.");
		public const REPTLUM:SimpleConsumable = mk("Reptlum", "a vial of Reptilum", m.reptilum, "This is a rounded bottle with a small label that reads, \"<i>Reptilum</i>\".  It is likely this potion is tied to reptiles in some way.");
		public const REDUCTO:SimpleConsumable = mk("Reducto", "a salve marked as 'Reducto'", m.reducto, "This container full of paste can be used to shrink a body part down by a significant amount.", 30);
		public const RINGFIG:SimpleConsumable = mk("RingFig","a ringtail fig", m.ringtailFig,"A dried fig with two lobes and thin dark rings just below its stem.  The skin is wrinkly and it looks vaguely like a bulging scrotum.");
		public const S_DREAM:SimpleConsumable = mk("S.Dream", "a bottle of 'Succubus' Dream'", m.succubisDream, "This precious fluid is often given to men a succubus intends to play with for a long time, though this batch has been enhanced by Lumi to have even greater potency.");
		public const S_GOSSR:SimpleConsumable = mk("S.Gossr", "a bundle of pink, gossamer webbing", m.sweetGossamer, "These strands of gooey pink gossamer seem quite unlike the normal silk that spider-morphs produce.  It smells sweet and is clearly edible, but who knows what it might do to you?");
		public const SDELITE:SimpleConsumable = mk("SDelite", "a bottle of 'Succubi's Delight'", curry(m.succubisDelight, true),"This precious fluid is often given to men a succubus intends to play with for a long time.");
		public const SENSDRF:SimpleConsumable = mk("SensDrf", "a bottle of sensitivity draft", m.sensitivityDraft, "This carefully labelled potion is a 'Sensitivity Draft', and if the diagrams are any indication, it will make your body more sensitive.", 15);
		public const SHARK_T:SimpleConsumable = mk("Shark.T", "a sharp shark tooth", m.sharkTooth, "A glinting white tooth, very sharp and intimidating.");
		public const SHEEPMK:SimpleConsumable = mk("SheepMk", "a bottle of sheep milk", m.sheepMilk,"This bottle of sheep milk is said to have corruption-fighting properties.  It may be useful.");
		public const SMART_T:SimpleConsumable = mk("Smart T", "a cup of scholar's tea", m.scholarsTea, "This powerful brew supposedly has mind-strengthening effects.");
		public const SNAKOIL:SimpleConsumable = mk("SnakOil", "a vial of snake oil", m.snakeOil, "A vial the size of your fist made of dark brown glass. It contains what appears to be an oily, yellowish liquid. The odor is abominable.");
		public const SUCMILK:SimpleConsumable = mk("SucMilk", "a bottle of Succubi milk", curry(m.succubiMilk, true), "This milk-bottle is filled to the brim with a creamy white milk of dubious origin.  A pink label proudly labels it as \"<i>Succubi Milk</i>\".  In small text at the bottom of the label it reads: \"<i>To bring out the succubus in YOU!</i>\"");
		public const TRAPOIL:SimpleConsumable = mk("TrapOil", "a vial of trap oil", m.trapOil, "A round, opaque glass vial filled with a clear, viscous fluid.  It has a symbol inscribed on it, a circle with a cross and arrow pointing out of it in opposite directions.  It looks and smells entirely innocuous.");
		public const TSCROLL:SimpleConsumable = mk("TScroll", "a tattered scroll", m.tatteredScroll, "This tattered scroll is written in strange symbols, yet you have the feeling that if you tried to, you could decipher it.");
		public const TSTOOTH:SimpleConsumable = mk("TSTooth", "a glowing tiger shark tooth", curry(m.sharkTooth, 1),"This looks like a normal shark tooth, though with an odd purple glow.");
		public const VITAL_T:SimpleConsumable = mk("Vital T", "a vitality tincture", m.vitalityTincture, "This potent tea is supposedly good for the strengthening the body.");
		public const VIXVIGR:SimpleConsumable = mk("VixVigr", "a bottle labelled \"Vixen's Vigor\"", curry(m.foxTF, true), "This small medicine bottle contains something called \"Vixen's Vigor\", supposedly distilled from common fox-berries.  It is supposed to be a great deal more potent, and a small warning label warns of \"extra boobs\", whatever that means.", 30);
		public const W__BOOK:SimpleConsumable = mk("W. Book", "a small book with a pristine white cover", m.whiteSpellbook, "This white book is totally unmarked, and the cover is devoid of any lettering or title.  A shiny brass clasp keeps the covers closed until you are ready to read it.", 40);
		public const W_FRUIT:SimpleConsumable = mk("W.Fruit", "a piece of whisker-fruit", m.catTransformation, "This small, peach-sized fruit has tiny whisker-like protrusions growing from the sides.");
		public const W_STICK:WingStick = new WingStick();
		public const WETCLTH:SimpleConsumable = mk("WetClth", "a wet cloth dripping with slippery slime", m.gooGasmic, "Dripping with a viscous slime, you've no doubt rubbing this cloth on your body would have some kind of strange effect.");
		public const WHITEDY:SimpleConsumable = mk("WhiteDy", "a vial of white hair dye", curry(m.hairDye, "white"));
		public const WHITEEG:SimpleConsumable = mk("WhiteEg", "a milky-white egg", curry(m.whiteEgg, false),"This is an oblong egg, not much different from a chicken egg in appearance.  Something tells you it's more than just food.");
		private static function mk(id:String, longName:String, effect:Function, description:String, value:Number = DEFAULT_VALUE):SimpleConsumable{
			return new SimpleConsumable(id,id,longName,effect,value,description);
		}
		private function get m():Mutations{
			return kGAMECLASS.mutations;
		}
		public function ConsumableLib()
		{
		}
	}
}
