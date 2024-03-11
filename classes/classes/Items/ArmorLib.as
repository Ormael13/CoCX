/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
import classes.Items.Armors.*;
import classes.Items.Dynamic.DynamicArmor;
import classes.PerkLib;

public final class ArmorLib extends ItemConstants
	{
		public function Legendary():Array {
			return legendaryPure().concat(LegendaryCorrupt());
		}
		public function legendaryPure():Array {
			return [
				BMARMOR,
				IBKIMO,
				IBKIMO,
				IBKIMO,
				IBKIMO,
				IBKIMO,
				OEKIMO,
				CTHPALA
			];
		}
		public function LegendaryCorrupt():Array {
			return [
				S_ARMOR,
				TCKIMO,
				TCKIMO,
				TCKIMO,
				TCKIMO,
				TCKIMO,
				OTKIMO,
				CTBGUAR,
				CGUNSLI,
				DEATHPGA
			];
		}


		public static const COMFORTABLE_UNDERCLOTHES:Armor = new ComfortableUnderclothes();
		public static const NOTHING:Armor = new Nothing();
		
		/** @param subtypeId key in DynamicArmor.Subtypes */
		private static function findCommonDynamicArmor(subtypeId:String):DynamicArmor {
			return ItemTemplateLib.instance.createArmor(subtypeId, RARITY_COMMON, 0, CS_KNOWN_UNCURSED, []);
		}

		//25 za 1 ptk robes, 20 dla light, 40 dla medium, 60 dla heavy, 80 dla light ayo, 100 dla heavy ayo i 150 dla ultra heavy ayo, z perkiem/dod. efektem podwaja koszt za każdy
		public const A_ROBE_:Armor = new Armor("A.Robe","A.Robe","apprentice's robe","an apprentice's robe",0,1,25,"This drab robe lacks adornment, yet retains an air of mysticality. The low quality of the fabric coupled with its mystic air suggests that it is a garment meant for mages in training.","Light")
				.withBuffs({'spellcost': -0.10}) as Armor;
		public const ADVCLTH:Armor = new Armor("AdvClth","G. Clothes","green adventurer's clothes","a green adventurer's outfit, complete with pointed cap",2,0,50,"A set of comfortable green adventurer's clothes.  It even comes complete with a pointy hat!","Light");
		public const ANE_UNI:Armor = new Armor("ANe.Uni","ArigeanNCUni","Arigean Ne-Class Uniform","an Arigean Ne-Class Uniform",9,0,720,"A waterproof uniform designed to fit your body type, it seems to only consist of what looks like a black tank top with a built in mantle coming off the collar and metal fragments to help cover your squishy bits. it doesn’t seem to come with anything to cover your downstairs region however.","Light");
		public const ARCBANG:Armor = new Armor("ArcaBangl","ArcaneBangles","arcane bangles","a set of arcane bangles",0,1,150,"Silver bangles to be worn from the wrists and ankles, inscribed with arcane runes.  For some reason, you feel like wearing these with armor or clothes is somehow wrong.","Light")
				.withBuffs({
					'spellcost':-0.20,
					'teasedmg': 5
				})
				.withTag(A_REVEALING) as Armor;
		public const B_CHANG:Armor = new Armor("B.Chang","BlueChangshan","Blue Lunar new year dress (m)","a Blue Lunar new year dress (m)",0,0,100,"A simple yet elegant blue changshan with dragon motif. This clothing is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const B_DRESS:Armor = new Armor("B.Dress","Long Dress","long ballroom dress patterned with sequins","a ballroom dress patterned with sequins",0,0,40,"A long ballroom dress patterned with sequins.  Perfect for important occasions.","Medium");
		public const B_QIPAO:Armor = new Armor("B.Qipao","BlueQipao","Blue Lunar new year dress (f)","a Blue Lunar new year dress (f)",0,0,100,"A simple yet elegant blue qipao with floral motif. This dress is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const BEEARMR:BeeArmor = new BeeArmor();
		public const BERA:Armor = new Armor("B.Armor","B.Armor","berserker armor","a berserker armor",12,0,30720,"A sturdy albeith skimpy armor made of leather and metal plates tied up to the body with straps. While it offers limited protections it also does not hinder the movement of its owner allowing for greater agility then most armors.","Medium")
				.withBuffs({'teasedmg':8})
				.withPerk(PerkLib.BerserkerArmor, 0, 0, 0, 0)
				.withTag(A_AGILE) as Armor;
		public const BESTBLA:BestialBlademasterArmor = new BestialBlademasterArmor();
		public const BIMBOSK:Armor = new Armor("BimboSk","BimboSk","bimbo skirt","a skirt that looks like it belongs on a bimbo",1,0,40,"A tight, cleavage-inducing halter top and an extremely short miniskirt.  The sexual allure of this item is undoubtable.","Light", false, false)
				.withBuffs({'teasedmg': 10})
				.withTag(A_REVEALING) as Armor;
		public const BLIZZ_K:BlizzardKimono = new BlizzardKimono();
		public const BLKIMONO:Armor = new Armor("Bl.Kimono","Bl.Kimono","black kimono","a black kimono",0,1,200,"This lovely black kimono is adorned with a red floral pattern. It will likely increase your spiritual power as a kitsune.","Light")
				.withBuffs({
					'spellcost': -0.20,
					'soulskillcost': -0.20
				}) as Armor;
		public const BKIMONO:Armor = new Armor("B.Kimono","B.Kimono","blue kimono","a blue kimono",0,1,200,"This lovely blue kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.","Light")
				.withBuffs({
					'spellcost': -0.20,
					'soulskillcost': -0.20
				}) as Armor;
		public const BMARMOR:BattleMaidenArmor = new BattleMaidenArmor();
		public const BONSTRP:Armor = new Armor("BonStrp", "BonStrp", "barely-decent bondage straps", "a set of bondage straps", 0, 0, 40, "These leather straps and well-placed hooks are actually designed in such a way as to be worn as clothing.  While they technically would cover your naughty bits, virtually every other inch of your body would be exposed.", "Light", false, false)
				.withBuffs({'teasedmg': 10})
				.withTag(A_REVEALING)
				.withTag(A_AGILE) as Armor;
		public const C_CLOTH:ComfortableClothes = new ComfortableClothes();
		public const CHBIKNI:Armor = new Armor("ChBikni","Chn Bikini","revealing chainmail bikini","a chainmail bikini",2,0,80,"A revealing chainmail bikini that barely covers anything.  The bottom half is little more than a triangle of metal and a leather thong.","Light", false, false)
				.withBuffs({'teasedmg': 5})
				.withTag(A_REVEALING)
				.withTag(A_AGILE) as Armor;
		public const CLSSYCL:Armor = new Armor("ClssyCl", "Suitclothes", "classy suitclothes", "a set of classy suit-clothes", 1, 0, 40, "A set of classy suitclothes.", "Light");
		public const CGUNSLI:CowGunslingerOutfit = new CowGunslingerOutfit();
		public const CTBGUAR:CentaurBlackguardArmor = new CentaurBlackguardArmor();
		public const CTHPALA:CentaurPaladinArmor = new CentaurPaladinArmor();
		public const CTPALAD:CentaurArmor = new CentaurArmor();
		public const DBARMOR:PureMaraeArmor = new PureMaraeArmor();
		public const DEATHPGA:DeathPrinceGoldenArmor = new DeathPrinceGoldenArmor();
		public const DEATHPO:DeathPrinceOutfit = new DeathPrinceOutfit();
		public const DSCLARM:Armor = new Armor("DSclArm", "D.Scale Armor", "dragonscale armor", "a suit of dragonscale armor", 10, 10, 800, "This armor is cleverly fashioned from dragon scales. It offers high protection while at the same time, quite flexible.", "Medium");
		public const DSCLROB:Armor = new Armor("DSclRob", "D.Scale Robes", "dragonscale robes", "a dragonscale robes", 0, 10, 500, "This robe is expertly made from dragon scales. It offers high protection while being lightweight and should be comfortable to wear all day.", "Light")
				.withBuffs({'spellcost': -0.20}) as Armor;
		public const DWARMOR:Armor = new Armor("DWArmor","D-wArmor","Drider-weave Armor","a Drider-weave Armor",20,34,2160,"This set of white armor shimmers in the light, rippling strands of silk pumping mana through them. The chestpiece is thick, padded with multiple layers of overlapping strands, and as you poke it, you can feel it’s been reinforced with many small pieces of metal, silk strands woven through holes in the steel.","Light");
		public const DWSROBE:DriderWeaveSheerRobe = new DriderWeaveSheerRobe();
		public const ELFDRES:Armor = new Armor("ElfDress","Elf Dress","Elven Villager Dress","an Elven Villager Dress",0,0,250,"This white dress with a green sash is typically worn by wood elves. It doesn't offer much protection but for some reason seems to greatly enhance one's natural charm. Just the act of showing it off seems to ease ones lust when wearing this surprisingly simple but lewd outfit.","Light")
				.withBuffs({'teasedmg': 10})
				.withTag(A_REVEALING)
				.withTag(A_AGILE)  as Armor;
		public const EHGARB_:Armor = new Armor("EH.Garb","E.Heretic‘s Garb","Ebonweave Heretic‘s Garb","an Ebonweave Heretic‘s Garb",0,20,1600,"This outfit is ebonweave, created using refined ebonbloom petals. The outfit consists of arrowproof clothes, covered by a mesh breastplate and leatherlike duster inscribed with glyphs of magic and warding.  A trilby adorned with a moon pin completes the look.","Light", true, true)
				.withBuffs({
					'spellcost': -0.20,
					'soulskillcost': -0.20
				}) as Armor;
		public const ERA:Armor = new Armor("ERA", "ElvenRangerArmor", "Elven Ranger Armor", "a elven ranger armor", 0, 18, 10000, "An armor typically worn by wood elves on the rare occasion where they go to battle. This outfit is made of green spider silk specially treated for extra elasticity in order to offer good armor while preserving the user's own agility. Unsurprisingly for an elven armor it is highly revealing and barely tries to hide whatever assets the user may have thus it is as effective for combat as it is for teasing. Several enchantments fortifying archery and spearmanship have been bestowed upon this armor.", "Medium", false,false)
				.withBuffs({'teasedmg': 10})
				.withPerk(PerkLib.ElvenRangerArmor,0,0,0,0)
				.withTag(A_REVEALING)
				.withTag(A_AGILE) as Armor;
		public const EWJACK_:Armor = new Armor("EWJack","E.W. Jacket","ebonweave jacket","an ebonweave jacket",12,12,960,"This outfit is ebonweave, created using refined ebonbloom petals. The outfit consists of a leatherlike jacket, a mesh breastplate and a set of arrowproof clothing. Between them all, the outfit provide layers of protection rivaling heavier, more traditional armor.","Light")
				.withBuffs({'spellcost': -0.15}) as Armor;
		public const EWPLTMA:Armor = new Armor("EWPltMa","E.W. Platemail","ebonweave platemail","an ebonweave platemail",30,6,4320,"The armor is ebonweave, created using refined ebonbloom petals. The armor consists of two layers, an outer layer of ebonweave playing, and an inner layer of arrowproof ebonweave cloth.","Heavy")
				.withBuffs({'spellcost': -0.15}) as Armor;
		public const EWROBE_:Armor = new Armor("EWRobe","E.W. Robe","ebonweave robe","an ebonweave robe",2,10,600,"This robe is ebonweave, created using refined ebonbloom petals. This robe is as comfortable as cloth yet more protective than chainmail. The cloth has a mystic aura, helpful when working magic.","Light")
				.withBuffs({'spellcost': -0.30}) as Armor;
		public const FCLOAK:Armor = new Armor("F.Cloak","F.Cloak","black cloak","Francesca's Black Cloak",12,12,6000,"A cloak rumored to have been worn by the black cat adventurer Francesca the heavenly black tiger. Not exactly a strong armor per say, its true ability is to conceal its owner body's true location through a mix of glamor and illusion spell improving the users evasiveness by leaps and bound. Francesca was a famous sword mage and as thus the cloak greatly reinforces spells casted through the medium of a weapon.","Light")
				.withBuffs({
					'spellcost': -0.40,
					'evade': 2
				})
				.withPerk(PerkLib.Misdirection)
				.withTag(A_AGILE)
				.withTag(A_REVEALING) as Armor;
		public const FCLOTHS:Armor =  new Armor("FCloths","Fur Clothes","Fur Clothes","fur clothes",1,0,40,"Generic brown fur clothing that trolls wear. It’s made to be form fitting and suit anyone of reasonable size or shape.\n","Light", false, false)
				.withBuffs({'teasedmg': 10}) as Armor;
		public const FMDRESS:Armor = new Armor("FMageDress","Forest Mage Dress","Forest Mage Dress","a Forest Mage Dress",0,0,800,"The wearer of this dress desire and pleasure is no longer vexed by the limitations of mortal flesh allowing one to keep control over their lust long enough to claim victory by diluting their own lust within the ambiant natural world for a time. So long as a Green Magic spell was cast within the 5 previous rounds the user of this dress effectively is able to maintain their focus and mind entirely to the task at hand at the cost of potentialy turning into a lecherous sex maniac due to all the dilluted lust merging back with the user at the end of combat. There is a small chance for this to backfire instead causing the ambiant flora to turn on and rape the wearer of the dress.","Light")
				.withBuffs({
					'spellcost': -0.10
				}) as Armor;	//Effect: Slutty Seduction 10, Wizard Endurance 60. Increase tease total damage by x 2 when worn by a wood elf. Inflicting Tease damage reduces the wielder's own lust by a small amount.
		public const FQR:Armor = new Armor("F.Q.Regalia","F.Q.Regalia","Fairy Queen Regalia","a Fairy Queen Regalia",0,30,6000,"This long dress has full glove sleeves to match, and changes color depending on your mood. It is lighter than air and about almost as transparent. Modeled after its people carefree nature this dress barely conceal anything though it still hide your assets just enough that you don’t appear outright naked. It also magicaly enhances one's ability to evade and is especially useful when worn by someone trained in the art of misdirection or fey magic. It comes with an assorted Tiara and choker.","Light")
				.withBuffs({
					'spellcost': -0.60,
					'teasedmg': 10
				})
				.withPerk(PerkLib.FairyQueenRegalia, 0, 0, 0, 0)
				.withTag(A_AGILE) as Armor;
		public const FULLCHN:Armor = new Armor("FullChn","Full Chain","full-body chainmail","a full suit of chainmail armor",8,0,320,"This full suit of chainmail armor covers its wearer from head to toe in protective steel rings.","Medium");
		public const FULLPLT:Armor = new Armor("FullPlt","Full Plate","full platemail","a suit of full-plate armor",21,0,1260,"A highly protective suit of steel platemail.  It would be hard to find better physical protection than this.","Heavy");
		public const G_CHANG:Armor = new Armor("G.Chang","GreenChangshan","Green Lunar new year dress (m)","a Green Lunar new year dress (m)",0,0,100,"A simple yet elegant green changshan with dragon motif. This clothing is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const G_DIVES:Armor = new Armor("G.DiveS","GreenDivingSuit","Green Diving Suit","a Green Diving Suit",25,5,1800,"A green diving suit. Good for diving, stomping splicers or slaying demons.","Heavy");
		public const G_QIPAO:Armor = new Armor("G.Qipao","GreenQipao","Green Lunar new year dress (f)","a Green Lunar new year dress (f)",0,0,100,"A simple yet elegant green qipao with floral motif. This dress is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const GELARMR:Armor = new Armor("GelArmr","GelArmr","glistening gel-armor plates","a suit of gel armor",10,0,600,"This suit of interlocking plates is made from a strange green material.  It feels spongy to the touch but is amazingly resiliant.","Heavy");
		public const GELCARM:Armor = new Armor("GelCArm","GelCArm","glistening crimson gel-armor plates","a suit of crimson gel armor",10,0,1200,"This suit of interlocking plates is made from a strange red material.  It feels spongy to the touch but is amazingly resiliant and very reactive to soulforce.","Heavy")
				.withBuffs({
					'soulskillcost': -0.20
				}) as Armor;
		public const GTECHC_:GoblinTechnomancerClothes = new GoblinTechnomancerClothes();
		public const GOOARMR:GooArmor = new GooArmor();
		public const H_GARB_:Armor = new Armor("H. Garb","Heretic‘s Garb","Heretic‘s Garb","an Heretic‘s Garb",0,6,480,"Weathered traveling clothes, covered by a duster.  Wards and arcane glyphs inscribed in the duster facilitates magic while providing significant defense.  A feather tipped trilby completes the look.","Light", true, true)
				.withBuffs({
					'spellcost': -0.10,
					'soulskillcost': -0.10
				}) as Armor;
		public const HBARMOR:HBArmor = new HBArmor();
		public const HAYOARM:HeavyAyoArmor = new HeavyAyoArmor();
		public const HLEATHR:Armor = new Armor("HLeathr", "Hvy Lthr", "Heavy Leather", "a heavy leather armour", 10,0,375, "Layers of cured animal hide to offer greater protection from damage.\n", "Heavy");
		public const I_CORST:InquisitorsCorset = new InquisitorsCorset();
		public const I_ROBES:InquisitorsRobes = new InquisitorsRobes();
		public const IBKIMO:Armor = new InariBlessedKimono();
		public const INDECST:Armor = new Armor("IndecSt","Indec StAr","practically indecent steel armor","a suit of practically indecent steel armor",5,0,400,"This suit of steel 'armor' has two round disks that barely cover the nipples, a tight chainmail bikini, and circular butt-plates.","Medium")
				.withBuffs({'teasedmg': 6})
				.withTag(A_REVEALING) as Armor;
		public const INDEDSR:Armor = new Armor("IndeDSR","Indec D.Scale Robe","indecent dragonscale robe","an indecent dragonscale robe",0,4,400,"More of a longcoat than a robe, this outfit is crafted from dragon scales. Discrete straps centered around the belt keep the front perpetually open, displaying your groin and any cleavage you might have. The dragonscale is treated to be durable yet remain comfortable.","Light")
				.withBuffs({
					'spellcost':-0.15,
					'teasedmg': 5
				})
				.withTag(A_REVEALING) as Armor;
		public const INDEEWR:Armor = new Armor("IndeEWR","Indec. E.W. Robe","indecent ebonweave robe","an indecent ebonweave robe",0,6,600,"More of a longcoat than a robe, this outfit is crafted from refined ebonbloom petals. Discrete straps centered around the belt keep the front perpetually open, displaying your groin and any cleavage you might have. The cloth has a mystic aura, helpful when working magic.","Light")
				.withBuffs({
					'spellcost':-0.20,
					'teasedmg': 5
				})
				.withTag(A_REVEALING) as Armor;
		public const INDESSR:Armor = new Armor("IndeSSR","Indec S.S. Robe","indecent spider silk robe","an indecent spider silk robe",0,2,200,"More of a longcoat than a robe, this outfit is crafted from alchemically treated spider silk. Discrete straps centered around the belt keep the front perpetually open, displaying your groin and any cleavage you might have.","Light")
				.withBuffs({
					'spellcost':-0.15,
					'teasedmg': 5
				})
				.withTag(A_REVEALING) as Armor;
		public const IQG:Armor = new Armor("I.Q.Gown","I.Q.Gown","Ice Queen Gown","a Ice Queen Gown",0,30,12000,"A gown, previously worn by the late Queen Sophia before her kingdom was buried under the snow by the frost titan. The queen is said to have perished as the restless spirits of her people rose from their icy tomb. Eternally cold and devoid of life's warmth, the spirits seek to steal whatever heat they can get from others if only to soothe their ice-coated flesh. Anyone wearing this dress shall have their hearts, blood and body freeze in exchange for an undying fortitude and control over ice and light.","Light")
				.withBuffs({
					'spellcost': -0.60,
					'teasedmg': 10
				})
				.withPerk(PerkLib.IceQueenGown,0,0,0,0)
				.withPerk(PerkLib.IcyFlesh,0,0,0,0) as Armor;
		public const KBDRESS:Armor = new KrakenBlackDress();
		public const LEATHRA:Armor = new Armor("LeathrA","LeathrA","leather armor segments","a set of leather armor",5,0,100,"This is a suit of well-made leather armor.  It looks fairly rugged.","Light");
		public const URTALTA:LeatherArmorSegments = new LeatherArmorSegments();
		public const LMARMOR:LustyMaidensArmor = new LustyMaidensArmor();
		public const LAYOARM:LightAyoArmor = new LightAyoArmor();
		public const LTHCARM:LethiciteArmor = new LethiciteArmor();
		public const LTHRPNT:Armor = new Armor("LthrPnt","T.Lthr Pants","white silk shirt and tight leather pants","a pair of leather pants and a white silk shirt",0,0,20,"A flowing silk shirt and tight black leather pants.  Suave!","Light");
		public const LTHRROB:Armor = new Armor("LthrRob","Lthr Robes","black leather armor surrounded by voluminous robes","a suit of black leather armor with voluminous robes",3,3,150,"This is a suit of flexible leather armor with a voluminous set of concealing black robes.","Light");
		public const M_ROBES:Armor = new Armor("M.Robes","Robes","modest robes","a set of modest robes",0,0,25,"A set of modest robes, not dissimilar from what the monks back home would wear.","Light");
		public const NAGASLK:Armor = new Armor("NagaSlk","NagaDress","desert naga pink and black silk dress","a desert naga pink and black silk dress",0,0,0,"A very seductive dress made for naga or females without a human set of legs. It has a black collar, bikini top, sleeves with golden bangles and a waistcloth, all decorated with a golden trim. The bottom has a pink silk veil that runs down to what would be the human knee while the center of the bikini is also covered by a small strand of silk. It helps accentuate your curves and increase your natural charm. The dress obviously is so minimalist that you could as well say you are naked yet it looks quite classy on a tauric or naga body giving you the air of a master seducer.","Light", false, false)
				.withBuffs({'teasedmg': 10})
				.withTag(A_REVEALING)
				.withTag(A_AGILE) as Armor;
		public const NURSECL:Armor = new Armor("NurseCl","NurseCl","skimpy nurse's outfit","a nurse's outfit",0,0,100,"This borderline obscene nurse's outfit would barely cover your hips and crotch.  The midriff is totally exposed, and the white top leaves plenty of room for cleavage.  A tiny white hat tops off the whole ensemble.  It would grant a small regeneration to your HP.","Light")
				.withBuffs({'teasedmg': 8}) as Armor;
		public const OVERALL:Armor = new Armor("Overall", "Overalls", "white shirt and overalls", "a white shirt and overalls", 0, 0, 25, "A simple white shirt and overalls.", "Light", true);
		public const OEKIMO :OniEnlightenedKimono = new OniEnlightenedKimono();
		public const OTKIMO :OniTyrantKimono = new OniTyrantKimono();
		public const P_CHANG:Armor = new Armor("P.Chang","PurpleChangshan","Purple Lunar new year dress (m)","a Purple Lunar new year dress (m)",0,0,100,"A simple yet elegant purple changshan with dragon motif. This clothing is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const P_REGAL:Armor = new Armor("P.Regal","PrincessRegalia","Princess Regalia","a Princess Regalia",17,13,9600,"Your Regalia is just one of the markers of your position as a princess, it’s made of beautiful, soft yet surprisingly strong cloth that hugs your skin, it covers the majority of your body, but is cut out with a black bordering just below your shoulders on your arms, and down the center from the bottom of your collar to just above your navel, effectively showing your cleavage. It also possesses black and white gloved sleeves, large, crown-shaped, black metal armbands which hang around your arms, a black metal mask which effectively covers, and protects your lower face. Your dress ends in a skirt with black and white metal stars acting as additional, decorative protection.","Light");
		public const P_QIPAO:Armor = new Armor("P.Qipao","PurpleQipao","Purple Lunar new year dress (f)","a Purple Lunar new year dress (f)",0,0,100,"A simple yet elegant purple qipao with floral motif. This dress is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const PKIMONO:Armor = new Armor("P.Kimono","P.Kimono","purple kimono","a purple kimono",0,1,200,"This lovely purple kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.","Light")
				.withBuffs({
					'spellcost': -0.20,
					'soulskillcost': -0.20
				}) as Armor;
		public const R_BDYST:Armor = new Armor("R.BdySt","R.BdySt","red, high-society bodysuit","a red bodysuit for high society",1,0,50,"A high society bodysuit. It is as easy to mistake it for ballroom apparel as it is for boudoir lingerie. The thin transparent fabric is so light and airy that it makes avoiding blows a second nature.","Light", true, false)
				.withTag(A_AGILE) as Armor;
		public const R_CHANG:Armor = new Armor("R.Chang","RedChangshan","Red Lunar new year dress (m)","a Red Lunar new year dress (m)",0,0,100,"A simple yet elegant red changshan with dragon motif. This clothing is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const R_QIPAO:Armor = new Armor("R.Qipao","RedQipao","Red Lunar new year dress (f)","a Red Lunar new year dress (f)",0,0,100,"A simple yet elegant red qipao with floral motif. This dress is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const RBBRCLT:Armor = new Armor("RbbrClt","Rbbr Fetish","rubber fetish clothes","a set of revealing rubber fetish clothes",3,0,150,"A revealing set of fetish-wear.  Upgrades your tease attack with the \"Slutty Seduction\" perk.","Light", true, false)
				.withBuffs({'teasedmg': 8}) as Armor;
		public const RKIMONO:Armor = new Armor("R.Kimono","R.Kimono","red kimono","a red kimono",0,1,200,"This lovely red kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.","Light")
				.withBuffs({
					'spellcost': -0.20,
					'soulskillcost': -0.20
				}) as Armor;
		public const S_ARMOR:SuccubusArmor = new SuccubusArmor();
		public const S_SWMWR:SluttySwimwear = new SluttySwimwear();
		public const SAMUARM:Armor = new Armor("SamuArm","Samu.Armor","samurai armor","a suit of samurai armor",18,0,300,"This suit of armor is originally worn by the Samurai, the warriors from the far East.","Heavy");
		public const SAQBIKNI:Armor = new Armor("SAqBikini","S Aq Bikini","Sexy Aquamarine Bikini","a Sexy Aquamarine Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light", false, false)
				.withBuffs({'teasedmg': 10}) as Armor;
		public const SBABIKNI:Armor = new Armor("SBaBikini","S Ba Bikini","Sexy Black Bikini","a Sexy Black Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light", false, false)
				.withBuffs({'teasedmg': 10}) as Armor;
		public const SBUBIKNI:Armor = new Armor("SBuBikini","S Bu Bikini","Sexy Blue Bikini","a Sexy Blue Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light", false, false)
				.withBuffs({'teasedmg': 10}) as Armor;
		public const SCALEML:Armor = new Armor("ScaleMl","Scale Mail","scale-mail armor","a set of scale-mail armor",12,0,720,"This suit of scale-mail covers the entire body with layered steel scales, providing flexibility and protection.","Heavy");
		public const SEDUCTA:SeductiveArmor = new SeductiveArmor();
		public const SEDUCTU:SeductiveArmorUntrapped = new SeductiveArmorUntrapped();
		public const SGRBIKNI:Armor = new Armor("SGrBikini","S Gr Bikini","Sexy Green Bikini","a Sexy Green Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light", false, false)
				.withBuffs({'teasedmg': 10}) as Armor;
		public const SPIBIKNI:Armor = new Armor("SPiBikini","S Pi Bikini","Sexy Pink Bikini","a Sexy Pink Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light", false, false)
				.withBuffs({'teasedmg': 10}) as Armor;
		public const SPKIMO :SakuraPetalKimono = new SakuraPetalKimono();
		public const SREBIKNI:Armor = new Armor("SReBikini","S Re Bikini","Sexy Red Bikini","a Sexy Red Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light", false, false)
				.withBuffs({'teasedmg': 10}) as Armor;
		public const SS_ROBE:Armor = new Armor("SS.Robe","SS.Robes","spider-silk robes","a spider-silk robes",0,6,300,"This robe looks incredibly comfortable.  It's made from alchemically enhanced spider-silk, and embroidered with what looks like magical glyphs around the sleeves and hood.","Light")
				.withBuffs({'spellcost': -0.30}) as Armor;
		public const SSARMOR:Armor = new Armor("SSArmor","SS.Armor","spider-silk armor","a suit of spider-silk armor",25,0,1500,"This armor is as white as the driven snow.  It's crafted out of thousands of strands of spider-silk into an impenetrable protective suit.  The surface is slightly spongy, but so tough you wager most blows would bounce right off.","Heavy");
		public const SCANSC:Armor = new Armor("S.S.Clothing","S.S.Clothing","Scandalous Succubus Clothing","a Scandalous Succubus Clothing",0,30,6000,"This black leather vestment consist of two sleeves open at the hands with fur trimming, a choker with a large gold ring to which a chain can be attached, a very minimalistic panty and two pairs of socks with a golden trim at the tight. Since the bra is very thin your breasts are almost fully on display for whoever wants to see and grope them. A perfectly decadent dress for a supremely lewd succubus.","Light",false,false)
				.withBuffs({'teasedmg': 15})
				.withPerk(PerkLib.ScandalousSuccubusClothing, 0, 0, 0, 0)
				.withTag(A_REVEALING)
				.withTag(A_AGILE) as Armor;
		public const SLEATHR:Armor = new Armor("SLeathr", "Stud.Leather", "Studded Leather", "a cured leather armor", 8, 0,250, "A cured leather armor, it’s tough and can offer some modest protection while also allowing freedom of movement.", "Light");
		public const SWHBIKNI:Armor = new Armor("SWhBikini","S Wh Bikini","Sexy White Bikini","a Sexy White Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light", false, false)
				.withBuffs({'teasedmg': 10}) as Armor;
		public const SYEBIKNI:Armor = new Armor("SYeBikini","S Ye Bikini","Sexy Yellow Bikini","a Sexy Yellow Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light", false, false)
				.withBuffs({'teasedmg': 10}) as Armor;
		public const T_BSUIT:Armor = new Armor("T.BSuit","Bodysuit","semi-transparent bodysuit","a semi-transparent, curve-hugging bodysuit",0,0,50,"A semi-transparent bodysuit. It looks like it will cling to all the curves of your body.","Light")
				.withBuffs({'teasedmg': 7}) as Armor;
		public const TBARMOR:Armor = new MaraeArmor();
		public const TCKIMO:Armor = new TamamoNoMaeCursedKimono();
		public const TRMOUTF:Armor = new Armor("T.M.Outfit","T.M.Outfit","Traveling Merchant Outfit","a Traveling Merchant Outfit",0,0,2000,"This outfit looks to be made in the traditional Tanuki merchant fashion. It has been enchanted to help raise one's fortune.","Light")
				.withBuffs({
					'spellcost': -0.60
				})
				.withPerk(PerkLib.TravelingMerchantOutfit,60,0,0,0) as Armor;
		public const TRADITC:Armor = new Armor("TraditC","TraditionalCloth","Traditional clothes","a Traditional clothes",0,0,160,"These clothes bear resemblance to the traditional outfit worn by people in He'Xin'Dao on important days, however there is something lewd and obscene about this more skimpy variant of the design. These clothes naturally assist soulforce manipulation.","Light", false, false)
				.withBuffs({'teasedmg': 10}) as Armor;
		public const TRASARM:Armor = new Armor("TraSArm","TraSArmor","training soul armor","a training soul armor",1,1,240,"This set of heavy armor is made using soulmetal but it main purpose is to allow user train soulforce to the uttermost limit for novice soul cultivator.","Heavy");
		public const TUBETOP:Armor = new Armor("TubeTop","Tube Top","tube top and short shorts","a snug tube top and VERY short shorts",0,0,25,"A clingy tube top and VERY short shorts.","Light");
		public const UHAYOARM:UltraHeavyAyoArmor = new UltraHeavyAyoArmor();
		public const W_ROBES:Armor = new Armor("W.Robes","W.Robes","wizard's robes","a wizard's robes",0,1,50,"These robes appear to have once belonged to a female wizard.  They're long with a slit up the side and full billowing sleeves.  The top is surprisingly low cut.  Somehow you know wearing it would aid your spellcasting.","Light")
				.withBuffs({'spellcost': -0.25}) as Armor;
		public const WALIC:Armor = new Armor("W.I.Cloak","W.I.Cloak","cloak","a Walpurgis Izalia Cloak",0,30,12000,"This black cloak is very similar to the clothes of the hellcat witches cabal this cloak include golden filigree shaped like fiery tongues and troubling arcane design. Rumored to have been the prized cloak of the legendary Izalia herself who created the original whitefire.","Light")
				.withBuffs({
					'spellcost': -0.60,
					'teasedmg': 15
				})
				.withPerk(PerkLib.WalpurgisIzaliaRobe,0,0,0,0) as Armor;
		public const WKIMONO:Armor = new Armor("W.Kimono","W.Kimono","white kimono","a white kimono",0,1,200,"This lovely white kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.","Light")
				.withBuffs({
					'spellcost': -0.20,
					'soulskillcost': -0.20
				}) as Armor;
		public const VLAR:Armor = new Armor("V.Regalia","V.Regalia","Vladimir Regalia","a Vladimir Regalia",0,20,6400,"These burgundy clothes fit for a noble seem to naturally befit the style of a vampire. Strangely, the clothes seem to catch on fire when basked into sunlight yet remain intact when pulled back through the shadows.","Light")
				.withBuffs({
					'spellcost': -0.60
				})
				.withPerk(PerkLib.VladimirRegalia,0,0,0,0) as Armor;
		
		public function ArmorLib()
		{
		}
	}
}
