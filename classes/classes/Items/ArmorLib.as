/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
	import classes.Items.Armors.*;

	public final class ArmorLib
	{
		public static const DEFAULT_VALUE:Number = 6;

		public static const COMFORTABLE_UNDERCLOTHES:Armor = new ComfortableUnderclothes();

		public const ADVCLTH:Armor = mk("AdvClth","AdvClth","green adventurer's clothes","a green adventurer's outfit, complete with pointed cap",2,200,"A set of comfortable green adventurer's clothes.  It even comes complete with a pointy hat!","Light");
		public const B_DRESS:Armor = mk("B.Dress","B.Dress","long ballroom dress patterned with sequins","a ballroom dress patterned with sequins",0,1200,"A long ballroom dress patterned with sequins.  Perfect for important occassions.","Medium");
		public const BEEARMR:Armor = mk("BeeArmr","BeeArmr","sexy black chitin armor-plating","a set of chitinous armor",18,200,"A suit of armor cleverly fashioned from giant bee chitin.");
		public const BIMBOSK:ArmorWithPerk = mk2("BimboSk","BimboSk","bimbo skirt","a skirt that looks like it belongs on a bimbo",1,50,"A tight, cleavage-inducing halter top and an extremely short miniskirt.  The sexual allure of this item is undoubtable.","Light",
				"Slutty Seduction",10,0,0,0,"Your delightfully slutty yet upbeat garb helps you seduce your foes!");
		public const BONSTRP:ArmorWithPerk = mk2("BonStrp","BonStrp","barely-decent bondage straps","a set of bondage straps",0,600,"These leather straps and well-placed hooks are actually designed in such a way as to be worn as clothing.  While they technically would cover your naughty bits, virtually every other inch of your body would be exposed.","Light",
				"Slutty Seduction",10,0,0,0,"Your fetishy bondage outfit allows you access to an improved form of 'Tease'.");
		public const C_CLOTH:ComfortableClothes = new ComfortableClothes();
		public const CHBIKNI:ArmorWithPerk = mk2("ChBikni","ChBikni","revealing chainmal bikini","a chainmail bikini",2,700,"A revealing chainmail bikini that barely covers anything.  The bottom half is little more than a triangle of metal and a leather thong.","Light",
				"Slutty Seduction",5,0,0,0,"Your revealing chain bikini allows you access to 'Seduce', an improved form of 'Tease'.");
		public const CLSSYCL:Armor = mk("ClssyCl","ClssyCl","classy suitclothes","a set of classy suit-clothes",1,400,"A set of classy suitclothes.","Light");
		public const FULLCHN:Armor = mk("FullChn","FullChn","full-body chainmail","a full suit of chainmail armor",8,150,"This full suit of chainmail armor covers its wearer from head to toe in protective steel rings.","Medium");
		public const FULLPLT:Armor = mk("FullPlt","FullPlt","full platemail","a suit of full-plate armor",21,250,"A highly protective suit of steel platemail.  It would be hard to find better physical protection than this.");
		public const FURLOIN:Armor = new FurLoincloth();
		public const GELARMR:Armor = mk("GelArmr","GelArmr","glistening gel-armor plates","a suit of gel armor",10,150,"This suit of interlocking plates is made from a strange green material.  It feels spongy to the touch but is amazingly resiliant.  (DEF: +10) (Cost: 150)");
		public const GOOARMR:GooArmor = new GooArmor();
		public const I_CORST:InquisitorsCorset = new InquisitorsCorset();
		public const I_ROBES:InquisitorsRobes = new InquisitorsRobes();
		public const INDECST:ArmorWithPerk = mk2("IndecSt","IndecSt","practically indecent steel armor","a suit of practically indecent steel armor",5,800,"This suit of steel 'armor' has two round disks that barely cover the nipples, a tight chainmail bikini, and circular butt-plates.","Medium",
				"Slutty Seduction",6,0,0,0,"Your incredibly revealing steel armor allows you access to 'Seduce', an improved form of 'Tease'.");
		public const LEATHRA:Armor = mk("LeathrA","LeathrA","leather armor segments","a set of leather armor",5,76,"This is a suit of well-made leather armor.  It looks fairly rugged. (+5 Defense)","Light");
		public const URTALTA:LeatherArmorSegments = new LeatherArmorSegments();
		public const LMARMOR:LustyMaidensArmor = new LustyMaidensArmor();
		public const LTHRPNT:Armor = mk("LthrPnt","LthrPnt","white silk shirt and tight leather pants","a pair of leather pants and a white silk shirt",0,450,"A flowing silk shirt and tight black leather pants.  Suave!","Light");
		public const LTHRROB:Armor = mk("LthrRob","LthrRob","black leather armor surrounded by voluminous robes","a suit of black leather armor with voluminous robes",6,100,"This is a suit of flexible leather armor with a voluminous set of concealing black robes.","Light");
		public const M_ROBES:Armor = mk("M.Robes","M.Robes","modest robes","a set of modest robes",0,120,"A set of modest robes, not dissimilar from what the monks back home would wear.","Light");
		public const NURSECL:ArmorWithPerk = mk2("NurseCl","NurseCl","skimpy nurse's outfit","a nurse's outfit",0,800,"This borderline obscene nurse's outfit would barely cover your hips and crotch.  The midriff is totally exposed, and the white top leaves plenty of room for cleavage.  A tiny white hat tops off the whole ensemble.","Light",
				"Slutty Seduction",8,0,0,0,"Your fetishy nurse outfit allows you access to an improved form of 'Tease'.");
		public const OVERALL:Armor = mk("Overall","Overall","white shirt and overalls","a white shirt and overalls",0,60,"A simple white shirt and overalls.","Light");
		public const R_BDYST:Armor = mk("R.BdySt","R.BdySt","red, high-society bodysuit","a red bodysuit for high society",1,1200,"A high society bodysuit. It is as easy to mistake it for ballroom apparel as it is for boudoir lingerie. The thin transparent fabric is so light and airy that it makes avoiding blows a second nature.","Light");
		public const RBBRCLT:ArmorWithPerk = mk2("RbbrClt","RbbrClt","rubber fetish clothes","a set of revealing rubber fetish clothes",3,1000,"A revealing set of fetish-wear.  Upgrades tease attack to seduce.","Light",
				"Slutty Seduction",8,0,0,0,"Your fetishy rubberwear allows you access to 'Seduce', an improved form of 'Tease'.");
		public const S_SWMWR:SluttySwimwear = new SluttySwimwear();
		public const SCALEML:Armor = mk("ScaleMl","ScaleMl","scale-mail armor","a set of scale-mail armor",12,170,"This suit of scale-mail covers the entire body with layered steel scales, providing flexibility and protection.");
		public const SEDUCTA:SeductiveArmor = new SeductiveArmor();
		public const SS_ROBE:ArmorWithPerk = mk2("SS.Robe","SS.Robe","spider-silk robes","a spider-silk robes",6,950,"This robe looks incredibly comfortable.  It's made from alchemically enhanced spider-silk, and embroidered with what looks like magical glyphs around the sleeves and hood.","Light",
				"Wizard's Endurance",30,0,0,0,"Your spellcasting equipment makes it harder for spell-casting to fatigue you!");
		public const SSARMOR:Armor = mk("SSArmor","SSArmor","spider-silk armor","a suit of spider-silk armor",25,950,"This armor is as white as the driven snow.  It's crafted out of thousands of strands of spider-silk into an impenetrable protective suit.  The surface is slightly spongy, but so tough you wager most blows would bounce right off.");
		public const T_BSUIT:ArmorWithPerk = mk2("T.BSuit","T.BSuit","semi-transparent bodysuit","a semi-transparent, curve-hugging bodysuit",0,1300,"A semi-transparent bodysuit.","Light",
				"Slutty Seduction",7,0,0,0,"Your clingy transparent bodysuit allows you access to 'Seduce', an improved form of 'Tease'.");
		public const TUBETOP:Armor = mk("TubeTop","TubeTop","tube top and short shorts","a snug tube top and VERY short shorts",0,80,"A clingy tube top and VERY short shorts.","Light");
		public const W_ROBES:ArmorWithPerk = mk2("W.Robes","W.Robes","wizard's robes","a wizard's robes",1,50,"These robes appear to have once belonged to a female wizard.  They're long with a slit up the side and full billowing sleeves.  The top is surprisingly low cut.  Somehow you know wearing it would aid your spellcasting.","Light",
				"Wizard's Endurance",25,0,0,0,"Your spellcasting equipment makes it harder for spell-casting to fatigue you!");

		private static function mk(id:String,shortName:String,name:String,longName:String,def:Number,value:Number,description:String,perk:String=""):Armor {
			return new Armor(id,shortName,name,longName,def,value,description,perk);
		}
		private static function mk2(id:String,shortName:String,name:String,longName:String,def:Number,value:Number,description:String,perk:String,
				playerPerkName:String,playerPerkV1:Number,playerPerkV2:Number,playerPerkV3:Number,playerPerkV4:Number,playerPerkDesc:String):ArmorWithPerk{
			return new ArmorWithPerk(id,shortName,name,longName,def,value,description,perk,
					playerPerkName,playerPerkV1,playerPerkV2,playerPerkV3,playerPerkV4,playerPerkDesc);
		}
		public function ArmorLib()
		{
		}
	}
}
