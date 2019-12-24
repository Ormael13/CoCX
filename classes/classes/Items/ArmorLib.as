/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
	import classes.Items.Armors.*;
	import classes.PerkLib;
	import classes.PerkType;

	public final class ArmorLib
	{
		public static const COMFORTABLE_UNDERCLOTHES:Armor = new ComfortableUnderclothes();
		public static const NOTHING:Armor = new Nothing();
//25 za 1 ptk robes, 20 dla light, 40 dla medium i 60 dla heavy, z perkiem/dod. efektem podwaja koszt za każdy
		public const ADVCLTH:Armor = new Armor("AdvClth","G. Clothes","green adventurer's clothes","a green adventurer's outfit, complete with pointed cap",2,0,50,"A set of comfortable green adventurer's clothes.  It even comes complete with a pointy hat!","Light");
		public const A_ROBE_:ArmorWithPerk = new ArmorWithPerk("A.Robe","A.Robe","apprentice's robe","an apprentice's robe",0,1,25,"This drab robe lacks adornment, yet retains an air of mysticality. The low quality of the fabric coupled with its mystic air suggests that it is a garment meant for mages in training.","Light",
				PerkLib.WizardsEndurance,10,0,0,0);
		public const ARCBANG:ArmorWithPerk = new ArmorWithPerk("ArcaBangl","ArcaneBangles","arcane bangles","a set of arcane bangles",0,1,150,"Silver bangles to be worn from the wrists and ankles, inscribed with arcane runes.  For some reason, you feel like wearing these with armor or clothes is somehow wrong.","Light",
				PerkLib.WizardsEnduranceAndSluttySeduction,20,5,0,0,"Your arcane bangles allows you access to 'Seduce', an improved form of 'Tease'.");
		public const B_CHANG:Armor = new Armor("B.Chang","BlueChangshan","Blue Lunar new year dress (m)","a Blue Lunar new year dress (m)",0,0,100,"A simple yet elegant blue changshan with dragon motif. This clothing is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const B_DRESS:Armor = new Armor("B.Dress","Long Dress","long ballroom dress patterned with sequins","a ballroom dress patterned with sequins",0,0,40,"A long ballroom dress patterned with sequins.  Perfect for important occasions.","Medium");
		public const B_QIPAO:Armor = new Armor("B.Qipao","BlueQipao","Blue Lunar new year dress (f)","a Blue Lunar new year dress (f)",0,0,100,"A simple yet elegant blue qipao with floral motif. This dress is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const BEEARMR:Armor = new BeeArmor();
		public const BIMBOSK:ArmorWithPerk = new ArmorWithPerk("BimboSk","BimboSk","bimbo skirt","a skirt that looks like it belongs on a bimbo",1,0,40,"A tight, cleavage-inducing halter top and an extremely short miniskirt.  The sexual allure of this item is undoubtable.","Light",
				PerkLib.SluttySeduction,10,0,0,0,"Your delightfully slutty yet upbeat garb helps you seduce your foes!", false, false);
		public const BLKIMONO:ArmorWithPerk = new ArmorWithPerk("Bl.Kimono","Bl.Kimono","black kimono","a black kimono",0,1,200,"This lovely black kimono is adorned with a red floral pattern. It will likely increase your spiritual power as a kitsune.","Light",
				PerkLib.WizardsAndDaoistsEndurance,20,20,0,0);
		public const BKIMONO:ArmorWithPerk = new ArmorWithPerk("B.Kimono","B.Kimono","blue kimono","a blue kimono",0,1,200,"This lovely blue kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.","Light",
				PerkLib.WizardsAndDaoistsEndurance,20,20,0,0);
		public const BONSTRP:ArmorWithPerk = new ArmorWithPerk("BonStrp","BonStrp","barely-decent bondage straps","a set of bondage straps",0,0,40,"These leather straps and well-placed hooks are actually designed in such a way as to be worn as clothing.  While they technically would cover your naughty bits, virtually every other inch of your body would be exposed.","Light",
				PerkLib.SluttySeduction,10,0,0,0,"Your fetishy bondage outfit allows you access to an improved form of 'Tease'.", false, false);
		public const C_CLOTH:ComfortableClothes = new ComfortableClothes();
		public const CHBIKNI:ArmorWithPerk = new ArmorWithPerk("ChBikni","Chn Bikini","revealing chainmail bikini","a chainmail bikini",2,0,80,"A revealing chainmail bikini that barely covers anything.  The bottom half is little more than a triangle of metal and a leather thong.","Light",
				PerkLib.SluttySeduction,5,0,0,0,"Your revealing chain bikini allows you access to 'Seduce', an improved form of 'Tease'.", false, false);
		public const CLSSYCL:Armor = new Armor("ClssyCl", "Suitclothes", "classy suitclothes", "a set of classy suit-clothes", 1, 0, 40, "A set of classy suitclothes.", "Light");
		public const CTPALAD:CentaurArmor = new CentaurArmor();
		public const CTBGUAR:CentaurBlackguardArmor = new CentaurBlackguardArmor();
		public const DBARMOR:Armor = new PureMaraeArmor();
		public const DSCLARM:Armor = new Armor("DSclArm", "D.Scale Armor", "dragonscale armor", "a suit of dragonscale armor", 10, 10, 800, "This armor is cleverly fashioned from dragon scales. It offers high protection while at the same time, quite flexible.", "Medium");
		public const DSCLROB:Armor = new ArmorWithPerk("DSclRob", "D.Scale Robes", "dragonscale robes", "a dragonscale robes", 0, 10, 500, "This robe is expertly made from dragon scales. It offers high protection while being lightweight and should be comfortable to wear all day.", "Light",
				PerkLib.WizardsEndurance,20,0,0,0);
		public const EHGARB_:EbonweaveHereticsGarb = new EbonweaveHereticsGarb();
		public const EWJACK_:ArmorWithPerk = new ArmorWithPerk("EWJack","E.W. Jacket","ebonweave jacket","an ebonweave jacket",12,12,960,"This outfit is ebonweave, created using refined ebonbloom petals. The outfit consists of a leatherlike jacket, a mesh breastplate and a set of arrowproof clothing. Between them all, the outfit provide layers of protection rivaling heavier, more traditional armor.","Light",
				PerkLib.WizardsEndurance,15,0,0,0);
		public const EWPLTMA:ArmorWithPerk = new ArmorWithPerk("EWPltMa","E.W. Platemail","ebonweave platemail","an ebonweave platemail",30,6,4320,"The armor is ebonweave, created using refined ebonbloom petals. The armor consists of two layers, an outer layer of ebonweave playing, and an inner layer of arrowproof ebonweave cloth.","Heavy",
				PerkLib.WizardsEndurance,15,0,0,0);
		public const EWROBE_:ArmorWithPerk = new ArmorWithPerk("EWRobe","E.W. Robe","ebonweave robe","an ebonweave robe",2,10,600,"This robe is ebonweave, created using refined ebonbloom petals. This robe is as comfortable as cloth yet more protective than chainmail. The cloth has a mystic aura, helpful when working magic.","Light",
				PerkLib.WizardsEndurance,30,0,0,0);
		public const FULLCHN:Armor = new Armor("FullChn","Full Chain","full-body chainmail","a full suit of chainmail armor",8,0,320,"This full suit of chainmail armor covers its wearer from head to toe in protective steel rings.","Medium");
		public const FULLPLT:Armor = new Armor("FullPlt","Full Plate","full platemail","a suit of full-plate armor",21,0,1260,"A highly protective suit of steel platemail.  It would be hard to find better physical protection than this.","Heavy");
		public const G_CHANG:Armor = new Armor("G.Chang","GreenChangshan","Green Lunar new year dress (m)","a Green Lunar new year dress (m)",0,0,100,"A simple yet elegant green changshan with dragon motif. This clothing is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const G_QIPAO:Armor = new Armor("G.Qipao","GreenQipao","Green Lunar new year dress (f)","a Green Lunar new year dress (f)",0,0,100,"A simple yet elegant green qipao with floral motif. This dress is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const GELARMR:Armor = new Armor("GelArmr","GelArmr","glistening gel-armor plates","a suit of gel armor",10,0,600,"This suit of interlocking plates is made from a strange green material.  It feels spongy to the touch but is amazingly resiliant.","Heavy");
		public const GOOARMR:GooArmor = new GooArmor();
		public const H_GARB_:HereticsGarb = new HereticsGarb();
		public const HBA_ARM:HBAspArmor = new HBAspArmor();
		public const I_CORST:InquisitorsCorset = new InquisitorsCorset();
		public const I_ROBES:InquisitorsRobes = new InquisitorsRobes();
		public const INDECST:ArmorWithPerk = new ArmorWithPerk("IndecSt","Indec StAr","practically indecent steel armor","a suit of practically indecent steel armor",5,0,400,"This suit of steel 'armor' has two round disks that barely cover the nipples, a tight chainmail bikini, and circular butt-plates.","Medium",
				PerkLib.SluttySeduction,6,0,0,0,"Your incredibly revealing steel armor allows you access to 'Seduce', an improved form of 'Tease'.");
		public const INDEDSR:ArmorWithPerk = new ArmorWithPerk("IndeDSR","Indec D.Scale Robe","indecent dragonscale robe","an indecent dragonscale robe",0,4,400,"More of a longcoat than a robe, this outfit is crafted from dragon scales. Discrete straps centered around the belt keep the front perpetually open, displaying your groin and any cleavage you might have. The dragonscale is treated to be durable yet remain comfortable.","Light",
				PerkLib.WizardsEnduranceAndSluttySeduction,15,5,0,0,"Your indecent dragonscale robe allows you access to 'Seduce', an improved form of 'Tease'.");
		public const INDEEWR:ArmorWithPerk = new ArmorWithPerk("IndeEWR","Indec. E.W. Robe","indecent ebonweave robe","an indecent ebonweave robe",0,6,600,"More of a longcoat than a robe, this outfit is crafted from refined ebonbloom petals. Discrete straps centered around the belt keep the front perpetually open, displaying your groin and any cleavage you might have. The cloth has a mystic aura, helpful when working magic.","Light",
				PerkLib.WizardsEnduranceAndSluttySeduction,20,5,0,0,"Your indecent ebonweave robe allows you access to 'Seduce', an improved form of 'Tease'.");
		public const INDESSR:ArmorWithPerk = new ArmorWithPerk("IndeSSR","Indec S.S. Robe","indecent spider silk robe","an indecent spider silk robe",0,2,200,"More of a longcoat than a robe, this outfit is crafted from alchemically treated spider silk. Discrete straps centered around the belt keep the front perpetually open, displaying your groin and any cleavage you might have.","Light",
				PerkLib.WizardsEnduranceAndSluttySeduction,15,5,0,0,"Your indecent spider silk robe allows you access to 'Seduce', an improved form of 'Tease'.");
		public const LEATHRA:Armor = new Armor("LeathrA","LeathrA","leather armor segments","a set of leather armor",5,0,100,"This is a suit of well-made leather armor.  It looks fairly rugged.","Light");
		public const URTALTA:LeatherArmorSegments = new LeatherArmorSegments();
		public const LMARMOR:LustyMaidensArmor = new LustyMaidensArmor();
		public const LAYOARM:LightAyoArmor = new LightAyoArmor();
		public const LTHCARM:LethiciteArmor = new LethiciteArmor();
		public const LTHRPNT:Armor = new Armor("LthrPnt","T.Lthr Pants","white silk shirt and tight leather pants","a pair of leather pants and a white silk shirt",0,0,20,"A flowing silk shirt and tight black leather pants.  Suave!","Light");
		public const LTHRROB:Armor = new Armor("LthrRob","Lthr Robes","black leather armor surrounded by voluminous robes","a suit of black leather armor with voluminous robes",3,3,150,"This is a suit of flexible leather armor with a voluminous set of concealing black robes.","Light");
		public const M_ROBES:Armor = new Armor("M.Robes","Robes","modest robes","a set of modest robes",0,0,25,"A set of modest robes, not dissimilar from what the monks back home would wear.","Light");
		public const NAGASLK:ArmorWithPerk = new ArmorWithPerk("NagaSlk","NagaDress","desert naga pink and black silk dress","a desert naga pink and black silk dress",0,0,0,"A very seductive dress made for naga or females without a human set of legs. It has a black collar, bikini top, sleeves with golden bangles and a waistcloth, all decorated with a golden trim. The bottom has a pink silk veil that runs down to what would be the human knee while the center of the bikini is also covered by a small strand of silk. It helps accentuate your curves and increase your natural charm. The dress obviously is so minimalist that you could as well say you are naked yet it looks quite classy on a tauric or naga body giving you the air of a master seducer.","Light",
				PerkLib.SluttySeduction,10,0,0,0,"Your desert naga pink and black silk dress allows you access to 'Seduce', an improved form of 'Tease'.", false, false);
		public const NURSECL:ArmorWithPerk = new ArmorWithPerk("NurseCl","NurseCl","skimpy nurse's outfit","a nurse's outfit",0,0,100,"This borderline obscene nurse's outfit would barely cover your hips and crotch.  The midriff is totally exposed, and the white top leaves plenty of room for cleavage.  A tiny white hat tops off the whole ensemble.  It would grant a small regeneration to your HP.","Light",
				PerkLib.SluttySeduction,8,0,0,0,"Your fetishy nurse outfit allows you access to an improved form of 'Tease'.");
		public const OVERALL:Armor = new Armor("Overall", "Overalls", "white shirt and overalls", "a white shirt and overalls", 0, 0, 25, "A simple white shirt and overalls.", "Light", true);
		public const P_CHANG:Armor = new Armor("P.Chang","PurpleChangshan","Purple Lunar new year dress (m)","a Purple Lunar new year dress (m)",0,0,100,"A simple yet elegant purple changshan with dragon motif. This clothing is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const P_QIPAO:Armor = new Armor("P.Qipao","PurpleQipao","Purple Lunar new year dress (f)","a Purple Lunar new year dress (f)",0,0,100,"A simple yet elegant purple qipao with floral motif. This dress is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const PKIMONO:ArmorWithPerk = new ArmorWithPerk("P.Kimono","P.Kimono","purple kimono","a purple kimono",0,1,200,"This lovely purple kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.","Light",
				PerkLib.WizardsAndDaoistsEndurance,20,20,0,0);
		public const R_BDYST:Armor = new Armor("R.BdySt","R.BdySt","red, high-society bodysuit","a red bodysuit for high society",1,0,50,"A high society bodysuit. It is as easy to mistake it for ballroom apparel as it is for boudoir lingerie. The thin transparent fabric is so light and airy that it makes avoiding blows a second nature.","Light", true, false);
		public const R_CHANG:Armor = new Armor("R.Chang","RedChangshan","Red Lunar new year dress (m)","a Red Lunar new year dress (m)",0,0,100,"A simple yet elegant red changshan with dragon motif. This clothing is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const R_QIPAO:Armor = new Armor("R.Qipao","RedQipao","Red Lunar new year dress (f)","a Red Lunar new year dress (f)",0,0,100,"A simple yet elegant red qipao with floral motif. This dress is said to bring in good luck increasing evasiveness and critical chance.","Light");
		public const RBBRCLT:ArmorWithPerk = new ArmorWithPerk("RbbrClt","Rbbr Fetish","rubber fetish clothes","a set of revealing rubber fetish clothes",3,0,150,"A revealing set of fetish-wear.  Upgrades your tease attack with the \"Slutty Seduction\" perk.","Light",
				PerkLib.SluttySeduction,8,0,0,0,"Your fetishy rubberwear allows you access to 'Seduce', an improved form of 'Tease'.", true, false);
		public const RKIMONO:ArmorWithPerk = new ArmorWithPerk("R.Kimono","R.Kimono","red kimono","a red kimono",0,1,200,"This lovely red kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.","Light",
				PerkLib.WizardsAndDaoistsEndurance,20,20,0,0);
		public const S_SWMWR:SluttySwimwear = new SluttySwimwear();
		public const SAMUARM:Armor = new Armor("SamuArm","Samu.Armor","samurai armor","a suit of samurai armor",18,0,300,"This suit of armor is originally worn by the Samurai, the warriors from the far East.","Heavy");
		public const SAQBIKNI:ArmorWithPerk = new ArmorWithPerk("SAqBikini","S Aq Bikini","Sexy Aquamarine Bikini","a Sexy Aquamarine Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light",
				PerkLib.SluttySeduction,10,0,0,0,"Your revealing chain bikini allows you access to 'Seduce', an improved form of 'Tease'.", false, false);
		public const SBABIKNI:ArmorWithPerk = new ArmorWithPerk("SBaBikini","S Ba Bikini","Sexy Black Bikini","a Sexy Black Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light",
				PerkLib.SluttySeduction,10,0,0,0,"Your revealing chain bikini allows you access to 'Seduce', an improved form of 'Tease'.", false, false);
		public const SBUBIKNI:ArmorWithPerk = new ArmorWithPerk("SBuBikini","S Bu Bikini","Sexy Blue Bikini","a Sexy Blue Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light",
				PerkLib.SluttySeduction,10,0,0,0,"Your revealing chain bikini allows you access to 'Seduce', an improved form of 'Tease'.", false, false);
		public const SCALEML:Armor = new Armor("ScaleMl","Scale Mail","scale-mail armor","a set of scale-mail armor",12,0,720,"This suit of scale-mail covers the entire body with layered steel scales, providing flexibility and protection.","Heavy");
		public const SEDUCTA:SeductiveArmor = new SeductiveArmor();
		public const SEDUCTU:SeductiveArmorUntrapped = new SeductiveArmorUntrapped();
		public const SGRBIKNI:ArmorWithPerk = new ArmorWithPerk("SGrBikini","S Gr Bikini","Sexy Green Bikini","a Sexy Green Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light",
				PerkLib.SluttySeduction,10,0,0,0,"Your revealing chain bikini allows you access to 'Seduce', an improved form of 'Tease'.", false, false);
		public const SPIBIKNI:ArmorWithPerk = new ArmorWithPerk("SPiBikini","S Pi Bikini","Sexy Pink Bikini","a Sexy Pink Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light",
				PerkLib.SluttySeduction,10,0,0,0,"Your revealing chain bikini allows you access to 'Seduce', an improved form of 'Tease'.", false, false);
		public const SPKIMO :SakuraPetalKimono = new SakuraPetalKimono();
		public const SREBIKNI:ArmorWithPerk = new ArmorWithPerk("SReBikini","S Re Bikini","Sexy Red Bikini","a Sexy Red Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light",
				PerkLib.SluttySeduction,10,0,0,0,"Your revealing chain bikini allows you access to 'Seduce', an improved form of 'Tease'.", false, false);
		public const SS_ROBE:ArmorWithPerk = new ArmorWithPerk("SS.Robe","SS.Robes","spider-silk robes","a spider-silk robes",0,6,300,"This robe looks incredibly comfortable.  It's made from alchemically enhanced spider-silk, and embroidered with what looks like magical glyphs around the sleeves and hood.","Light",
				PerkLib.WizardsEndurance,30,0,0,0);
		public const SSARMOR:Armor = new Armor("SSArmor","SS.Armor","spider-silk armor","a suit of spider-silk armor",25,0,1500,"This armor is as white as the driven snow.  It's crafted out of thousands of strands of spider-silk into an impenetrable protective suit.  The surface is slightly spongy, but so tough you wager most blows would bounce right off.","Heavy");
		public const SWHBIKNI:ArmorWithPerk = new ArmorWithPerk("SWhBikini","S Wh Bikini","Sexy White Bikini","a Sexy White Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light",
				PerkLib.SluttySeduction,10,0,0,0,"Your revealing chain bikini allows you access to 'Seduce', an improved form of 'Tease'.", false, false);
		public const SYEBIKNI:ArmorWithPerk = new ArmorWithPerk("SYeBikini","S Ye Bikini","Sexy Yellow Bikini","a Sexy Yellow Bikini",0,0,160,"This item helps female swimmers look sexy while not hindering movement. A perfect dress for a day at the beach.","Light",
				PerkLib.SluttySeduction,10,0,0,0,"Your revealing chain bikini allows you access to 'Seduce', an improved form of 'Tease'.", false, false);
		public const T_BSUIT:ArmorWithPerk = new ArmorWithPerk("T.BSuit","Bodysuit","semi-transparent bodysuit","a semi-transparent, curve-hugging bodysuit",0,0,50,"A semi-transparent bodysuit. It looks like it will cling to all the curves of your body.","Light",
				PerkLib.SluttySeduction,7,0,0,0,"Your clingy transparent bodysuit allows you access to 'Seduce', an improved form of 'Tease'.");
		public const TBARMOR:Armor = new MaraeArmor();
		public const TRADITC:ArmorWithPerk = new ArmorWithPerk("TraditC","TraditionalCloth","Traditional clothes","a Traditional clothes",0,0,160,"These clothes bear resemblance to the traditional outfit whore by people in He'Xin'Dao on important days however there is something lewd and obscene about this more skimpy variant of the design. These clothes naturally assist soul force manipulation.","Light",
				PerkLib.SluttySeduction,10,0,0,0,"Your revealing clothes allows you access to 'Seduce', an improved form of 'Tease'.", false, false);
		public const TRASARM:Armor = new Armor("TraSArm","TraSArmor","training soul armor","a training soul armor",1,1,240,"This set of heavy armor is made using soulmetal but it main purpose is to allow user train soulforce to the uttermost limit for novice soul cultivator.","Heavy");
		public const TUBETOP:Armor = new Armor("TubeTop","Tube Top","tube top and short shorts","a snug tube top and VERY short shorts",0,0,25,"A clingy tube top and VERY short shorts.","Light");
		public const W_ROBES:ArmorWithPerk = new ArmorWithPerk("W.Robes","W.Robes","wizard's robes","a wizard's robes",0,1,50,"These robes appear to have once belonged to a female wizard.  They're long with a slit up the side and full billowing sleeves.  The top is surprisingly low cut.  Somehow you know wearing it would aid your spellcasting.","Light",
				PerkLib.WizardsEndurance,25,0,0,0);
		public const WKIMONO:ArmorWithPerk = new ArmorWithPerk("W.Kimono","W.Kimono","white kimono","a white kimono",0,1,200,"This lovely white kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.","Light",
				PerkLib.WizardsAndDaoistsEndurance,20,20,0,0);

		/*
		private static function mk(id:String,shortName:String,name:String,longName:String,def:Number,value:Number,description:String,perk:String=""):Armor {
			return new Armor(id,shortName,name,longName,def,value,description,perk);
		}
		private static function mk2(id:String,shortName:String,name:String,longName:String,def:Number,value:Number,description:String,perk:String,
				playerPerk:PerkType,playerPerkV1:Number,playerPerkV2:Number,playerPerkV3:Number,playerPerkV4:Number,playerPerkDesc:String=null):ArmorWithPerk{
			return new ArmorWithPerk(id,shortName,name,longName,def,value,description,perk,
					playerPerk,playerPerkV1,playerPerkV2,playerPerkV3,playerPerkV4);
		}
		*/
		public function ArmorLib()
		{
		}
	}
}
