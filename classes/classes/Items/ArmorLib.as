/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
	import classes.Items.Armors.*;

	public class ArmorLib
	{
		public static const DEFAULT_VALUE:Number = 6;

		public static const COMFORTABLE_UNDERCLOTHES:Armor = new ComfortableUnderclothes();

		public const ADVENTURERS_OUTFIT:Armor = mk("AdvClth","a green adventurer's outfit, complete with pointed cap",2,200,"A set of comfortable green adventurer's clothes.  It even comes complete with a pointy hat!","Light");
		public const BALLROOM_DRESS:Armor = mk("B.Dress","a ballroom dress patterned with sequins",0,1200,"A long ballroom dress patterned with sequins.  Perfect for important occassions.","Medium");
		public const BEE_ARMOR:Armor = mk("BeeArmr","a set of chitinous armor",18,200,"A suit of armor cleverly fashioned from giant bee chitin.");
		public const BIMBO_SKIRT:Armor = mk("BimboSk","a skirt that looks like it belongs on a bimbo",1,50,"A tight, cleavage-inducing halter top and an extremely short miniskirt.  The sexual allure of this item is undoubtable.","Light");
		public const BONDAGE_STRAPS:Armor = mk("BonStrp","a set of bondage straps",0,600,"These leather straps and well-placed hooks are actually designed in such a way as to be worn as clothing.  While they technically would cover your naughty bits, virtually every other inch of your body would be exposed.","Light");
		public const COMFORTABLE_CLOTHES:Armor = mk("C.Cloth","a set of comfortable clothes",0,0,"These loose fitting and comfortable clothes allow you to move freely while protecting you from the elements.  (DEF: +0) (Cost: 0)","Light");
		public const CHAINMAIL_BIKINI:Armor = mk("ChBikni","a chainmail bikini",2,700,"A revealing chainmail bikini that barely covers anything.  The bottom half is little more than a triangle of metal and a leather thong.","Light");
		public const CLASSY_SUIT:Armor = mk("ClssyCl","a set of classy suit-clothes",1,400,"A set of classy suitclothes.","Light");
		public const FULL_CHAINMAIL:Armor = mk("FullChn","a full suit of chainmail armor",8,150,"This full suit of chainmail armor covers its wearer from head to toe in protective steel rings.","Medium");
		public const FULL_PLATEMAIL:Armor = mk("FullPlt","a suit of full-plate armor",21,250,"A highly protective suit of steel platemail.  It would be hard to find better physical protection than this.");
		public const FUR_LOINCLOTH:Armor = new FurLoincloth();
		public const GEL_ARMOR:Armor = mk("GelArmr","a suit of gel armor",10,150,"This suit of interlocking plates is made from a strange green material.  It feels spongy to the touch but is amazingly resiliant.  (DEF: +10) (Cost: 150)");
		public const GOO_ARMOR:Armor = mk("GooArmr","Valeria, the goo-girl armor",22,1,"This shining suit of platemail is more than just platemail - it houses the goo-girl, Valeria!  Together, they provide one tough defense, but you had better be okay with having goo handling your junk while you fight if you wear this!");
		public const INQUISITORS_CORSET:Armor = mk("I.Corst","inquisitor's corset",4,2000,"This sexualized and feminine red and gold ensemble carries with it the hopes of a shamed sorcerer.  Wearing it will cause spells to tax your health instead of exhausting you.","Light");
		public const INQUISITORS_ROBES:Armor = mk("I.Robes","inquisitor's robes",8,2000,"These foreboding red and gold robes are embroidered with the symbols of a lost kingdom.  Wearing them will cause spells to tax your health instead of exhausting you.","Light");
		public const INDECENT_STEEL_ARMOR:Armor = mk("IndecSt","a suit of practically indecent steel armor",5,800,"This suit of steel 'armor' has two round disks that barely cover the nipples, a tight chainmail bikini, and circular butt-plates.","Medium");
		public const LEATHER_ARMOR:Armor = mk("LeathrA","a set of leather armor",5,76,"This is a suit of well-made leather armor.  It looks fairly rugged. (+5 Defense)","Light");
		public const LEATHER_ARMOR_SEGMENTS:Armor = mk("UrtaLta","leather armor segments",5,76,null,"Light");
		public const LUSTY_MAIDENS_ARMOR:LustyMaidensArmor = new LustyMaidensArmor();
		public const LEATHER_PANTS:Armor = mk("LthrPnt","a pair of leather pants and a white silk shirt",0,450,"A flowing silk shirt and tight black leather pants.  Suave!","Light");
		public const LEATHER_ARMOR_WITH_ROBES:Armor = mk("LthrRob","a suit of black leather armor with voluminous robes",6,100,"This is a suit of flexible leather armor with a voluminous set of concealing black robes.","Light");
		public const MODEST_ROBES:Armor = mk("M.Robes","a set of modest robes",0,120,"A set of modest robes, not dissimilar from what the monks back home would wear.","Light");
		public const NURSES_OUTFIT:Armor = mk("NurseCl","a nurse's outfit",0,800,"This borderline obscene nurse's outfit would barely cover your hips and crotch.  The midriff is totally exposed, and the white top leaves plenty of room for cleavage.  A tiny white hat tops off the whole ensemble.","Light");
		public const OVERALLS:Armor = mk("Overall","a white shirt and overalls",0,60,"A simple white shirt and overalls.","Light");
		public const RED_BODYSUIT:Armor = mk("R.BdySt","a red bodysuit for high society",1,1200,"A high society bodysuit. It is as easy to mistake it for ballroom apparel as it is for boudoir lingerie. The thin transparent fabric is so light and airy that it makes avoiding blows a second nature.","Light");
		public const RUBBER_FETISH_CLOTHES:Armor = mk("RbbrClt","a set of revealing rubber fetish clothes",3,1000,"A revealing set of fetish-wear.  Upgrades tease attack to seduce.","Light");
		public const SKIMPY_BLACK_BIKINI:Armor = mk("S.Swmwr","a skimpy black bikini",0,DEFAULT_VALUE,"An impossibly skimpy black bikini. You feel dirty just looking at it… and a little aroused, actually.","Light");
		public const SCALE_MAIL:Armor = mk("ScaleMl","a set of scale-mail armor",12,170,"This suit of scale-mail covers the entire body with layered steel scales, providing flexibility and protection.");
		public const SEDUCTIVE_ARMOR:Armor = mk("SeductA","a set of scandalously seductive armor",0,1,"A complete suit of scalemail shaped to hug tightly against every curve, it has a solid steel chest-plate with obscenely large nipples molded into it.  The armor does nothing to cover the backside, exposing the wearer's cheeks to the world.");
		public const SPIDERSILK_ROBES:Armor = mk("SS.Robe","a spider-silk robes",6,950,"This robe looks incredibly comfortable.  It's made from alchemically enhanced spider-silk, and embroidered with what looks like magical glyphs around the sleeves and hood.","Light");
		public const SPIDERSILK_ARMOR:Armor = mk("SSArmor","a suit of spider-silk armor",25,950,"This armor is as white as the driven snow.  It's crafted out of thousands of strands of spider-silk into an impenetrable protective suit.  The surface is slightly spongy, but so tough you wager most blows would bounce right off.");
		public const SEMITRANSPARENT_BODYSUIT:Armor = mk("T.BSuit","a semi-transparent, curve-hugging bodysuit",0,1300,"A semi-transparent bodysuit.","Light");
		public const TUBE_TOP:Armor = mk("TubeTop","a snug tube top and VERY short shorts",0,80,"A clingy tube top and VERY short shorts.","Light");
		public const WIZARDS_ROBES:Armor = mk("W.Robes","a wizard's robes",1,50,"These robes appear to have once belonged to a female wizard.  They're long with a slit up the side and full billowing sleeves.  The top is surprisingly low cut.  Somehow you know wearing it would aid your spellcasting.","Light");

		private static function mk(id:String,longName:String,def:Number,value:Number,description:String,perk:String=""):Armor {
			return new Armor(id,id,longName,def,value,description,perk);
		}
		public function ArmorLib()
		{
		}
	}
}
