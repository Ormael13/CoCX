/**
 * ...
 * @author Ormael & Liadri
 */
package classes.Scenes.Camp 
{
import classes.*;
import classes.BaseContent;
import classes.internals.SaveableState;
import classes.Items.Consumables.SimpleConsumable;

	public class Garden extends BaseContent implements SaveableState
	{
		public static var GardenSlot01:String;
		public static var GardenSlot01Time:Number;
		public static var GardenSlot02:String;
		public static var GardenSlot02Time:Number;
		public static var GardenSlot03:String;
		public static var GardenSlot03Time:Number;
		public static var GardenSlot04:String;
		public static var GardenSlot04Time:Number;
		public static var GardenSlot05:String;
		public static var GardenSlot05Time:Number;
		public static var GardenSlot06:String;
		public static var GardenSlot06Time:Number;
		public static var GardenSlot07:String;
		public static var GardenSlot07Time:Number;
		public static var GardenSlot08:String;
		public static var GardenSlot08Time:Number;
		public static var GardenSlot09:String;
		public static var GardenSlot09Time:Number;
		public static var GardenSlot10:String;
		public static var GardenSlot10Time:Number;
		public static var GardenSlot11:String;
		public static var GardenSlot11Time:Number;
		public static var GardenSlot12:String;
		public static var GardenSlot12Time:Number;
		public static var IngrediantBagSlot01:Number;
		public static var IngrediantBagSlot01Cap:Number;//healing herb
		public static var IngrediantBagSlot02:Number;
		public static var IngrediantBagSlot02Cap:Number;//moon grass
		public static var IngrediantBagSlot03:Number;
		public static var IngrediantBagSlot03Cap:Number;//snakebane flower
		public static var IngrediantBagSlot04:Number;
		public static var IngrediantBagSlot04Cap:Number;//ironweed
		public static var IngrediantBagSlot05:Number;
		public static var IngrediantBagSlot05Cap:Number;//blade ferns
		public static var IngrediantBagSlot06:Number;
		public static var IngrediantBagSlot06Cap:Number;//alraune nectar
		public static var IngrediantBagSlot07:Number;
		public static var IngrediantBagSlot07Cap:Number;//	???
		public static var IngrediantBagSlot08:Number;
		public static var IngrediantBagSlot08Cap:Number;//	???
		public static var IngrediantBagSlot09:Number;
		public static var IngrediantBagSlot09Cap:Number;//	???
		public static var IngrediantBagSlot10:Number;
		public static var IngrediantBagSlot10Cap:Number;//	???
		public static var PotionsBagSlot01:Number;
		public static var PotionsBagSlot01Cap:Number;
		public static var PotionsBagSlot02:Number;
		public static var PotionsBagSlot02Cap:Number;
		public static var PotionsBagSlot03:Number;
		public static var PotionsBagSlot03Cap:Number;
		public static var PotionsBagSlot04:Number;
		public static var PotionsBagSlot04Cap:Number;
		public static var PotionsBagSlot05:Number;
		public static var PotionsBagSlot05Cap:Number;
		public static var PotionsBagSlot06:Number;
		public static var PotionsBagSlot06Cap:Number;
		public static var PotionsBagSlot07:Number;
		public static var PotionsBagSlot07Cap:Number;
		public static var PotionsBagSlot08:Number;
		public static var PotionsBagSlot08Cap:Number;
		public static var PotionsBagSlot09:Number;
		public static var PotionsBagSlot09Cap:Number;
		public static var PotionsBagSlot10:Number;
		public static var PotionsBagSlot10Cap:Number;
		public static var PotionsBagSlot11:Number;
		public static var PotionsBagSlot11Cap:Number;
		public static var PotionsBagSlot12:Number;
		public static var PotionsBagSlot12Cap:Number;
		public static var PotionsBagSlot13:Number;
		public static var PotionsBagSlot13Cap:Number;
		public static var PotionsBagSlot14:Number;
		public static var PotionsBagSlot14Cap:Number;
		public static var PotionsBagSlot15:Number;
		public static var PotionsBagSlot15Cap:Number;
		public static var PotionsBagSlot16:Number;
		public static var PotionsBagSlot16Cap:Number;
		public static var PotionsBagSlot17:Number;
		public static var PotionsBagSlot17Cap:Number;
		public static var PotionsBagSlot18:Number;
		public static var PotionsBagSlot18Cap:Number;
		public static var PotionsBagSlot19:Number;
		public static var PotionsBagSlot19Cap:Number;
		public static var PotionsBagSlot20:Number;
		public static var PotionsBagSlot20Cap:Number;
		public static var PotionsBagSlot21:Number;
		public static var PotionsBagSlot21Cap:Number;
		public static var PotionsBagSlot22:Number;
		public static var PotionsBagSlot22Cap:Number;
		public static var PotionsBagSlot23:Number;
		public static var PotionsBagSlot23Cap:Number;
		public static var PotionsBagSlot24:Number;
		public static var PotionsBagSlot24Cap:Number;
		public static var PotionsBagSlot25:Number;
		public static var PotionsBagSlot25Cap:Number;
		public static var PotionsBagSlot26:Number;
		public static var PotionsBagSlot26Cap:Number;
		public static var PotionsBagSlot27:Number;
		public static var PotionsBagSlot27Cap:Number;
		public static var PotionsBagSlot28:Number;
		public static var PotionsBagSlot28Cap:Number;
		public static var PotionsBagSlot29:Number;
		public static var PotionsBagSlot29Cap:Number;
		public static var PotionsBagSlot30:Number;
		public static var PotionsBagSlot30Cap:Number;
		public static var PotionsBagSlot31:Number;
		public static var PotionsBagSlot31Cap:Number;
		public static var PotionsBagSlot32:Number;
		public static var PotionsBagSlot32Cap:Number;
		public static var PotionsBagSlot33:Number;
		public static var PotionsBagSlot33Cap:Number;
		public static var PotionsBagSlot34:Number;
		public static var PotionsBagSlot34Cap:Number;
		public static var PotionsBagSlot35:Number;
		public static var PotionsBagSlot35Cap:Number;
		public static var PotionsBagSlot36:Number;
		public static var PotionsBagSlot36Cap:Number;
		public static var PotionsBagSlot37:Number;
		public static var PotionsBagSlot37Cap:Number;
		public static var PotionsBagSlot38:Number;
		public static var PotionsBagSlot38Cap:Number;
		public static var PotionsBagSlot39:Number;
		public static var PotionsBagSlot39Cap:Number;
		public static var PotionsBagSlot40:Number;
		public static var PotionsBagSlot40Cap:Number;
		public static var PotionsBagSlot41:Number;
		public static var PotionsBagSlot41Cap:Number;
		public static var PotionsBagSlot42:Number;
		public static var PotionsBagSlot42Cap:Number;
		public static var PotionsBagSlot43:Number;
		public static var PotionsBagSlot43Cap:Number;
		public static var PotionsBagSlot44:Number;
		public static var PotionsBagSlot44Cap:Number;
		public static var PotionsBagSlot45:Number;
		public static var PotionsBagSlot45Cap:Number;
		public static var PotionsBagSlot46:Number;
		public static var PotionsBagSlot46Cap:Number;
		public static var PotionsBagSlot47:Number;
		public static var PotionsBagSlot47Cap:Number;
		public static var PotionsBagSlot48:Number;
		public static var PotionsBagSlot48Cap:Number;
		public static var PotionsBagSlot49:Number;
		public static var PotionsBagSlot49Cap:Number;
		public static var PotionsBagSlot50:Number;
		public static var PotionsBagSlot50Cap:Number;

		public function stateObjectName():String {
			return "Gardening";
		}

		public function resetState():void {
			GardenSlot01 = "";
			GardenSlot01Time = 0;
			GardenSlot02 = "";
			GardenSlot02Time = 0;
			GardenSlot03 = "";
			GardenSlot03Time = 0;
			GardenSlot04 = "";
			GardenSlot04Time = 0;
			GardenSlot05 = "";
			GardenSlot05Time = 0;
			GardenSlot06 = "";
			GardenSlot06Time = 0;
			GardenSlot07 = "";
			GardenSlot07Time = 0;
			GardenSlot08 = "";
			GardenSlot08Time = 0;
			GardenSlot09 = "";
			GardenSlot09Time = 0;
			GardenSlot10 = "";
			GardenSlot10Time = 0;
			GardenSlot11 = "";
			GardenSlot11Time = 0;
			GardenSlot12 = "";
			GardenSlot12Time = 0;
			IngrediantBagSlot01 = 0;
			IngrediantBagSlot01Cap = 0;
			IngrediantBagSlot02 = 0;
			IngrediantBagSlot02Cap = 0;
			IngrediantBagSlot03 = 0;
			IngrediantBagSlot03Cap = 0;
			IngrediantBagSlot04 = 0;
			IngrediantBagSlot04Cap = 0;
			IngrediantBagSlot05 = 0;
			IngrediantBagSlot05Cap = 0;
			IngrediantBagSlot06 = 0;
			IngrediantBagSlot06Cap = 0;
			IngrediantBagSlot07 = 0;
			IngrediantBagSlot07Cap = 0;
			IngrediantBagSlot08 = 0;
			IngrediantBagSlot08Cap = 0;
			IngrediantBagSlot09 = 0;
			IngrediantBagSlot09Cap = 0;
			IngrediantBagSlot10 = 0;
			IngrediantBagSlot10Cap = 0;
			PotionsBagSlot01 = 0;
			PotionsBagSlot01Cap = 0;
			PotionsBagSlot02 = 0;
			PotionsBagSlot02Cap = 0;
			PotionsBagSlot03 = 0;
			PotionsBagSlot03Cap = 0;
			PotionsBagSlot04 = 0;
			PotionsBagSlot04Cap = 0;
			PotionsBagSlot05 = 0;
			PotionsBagSlot05Cap = 0;
			PotionsBagSlot06 = 0;
			PotionsBagSlot06Cap = 0;
			PotionsBagSlot07 = 0;
			PotionsBagSlot07Cap = 0;
			PotionsBagSlot08 = 0;
			PotionsBagSlot08Cap = 0;
			PotionsBagSlot09 = 0;
			PotionsBagSlot09Cap = 0;
			PotionsBagSlot10 = 0;
			PotionsBagSlot10Cap = 0;
			PotionsBagSlot11 = 0;
			PotionsBagSlot11Cap = 0;
			PotionsBagSlot12 = 0;
			PotionsBagSlot12Cap = 0;
			PotionsBagSlot13 = 0;
			PotionsBagSlot13Cap = 0;
			PotionsBagSlot14 = 0;
			PotionsBagSlot14Cap = 0;
			PotionsBagSlot15 = 0;
			PotionsBagSlot15Cap = 0;
			PotionsBagSlot16 = 0;
			PotionsBagSlot16Cap = 0;
			PotionsBagSlot17 = 0;
			PotionsBagSlot17Cap = 0;
			PotionsBagSlot18 = 0;
			PotionsBagSlot18Cap = 0;
			PotionsBagSlot19 = 0;
			PotionsBagSlot19Cap = 0;
			PotionsBagSlot20 = 0;
			PotionsBagSlot20Cap = 0;
			PotionsBagSlot21 = 0;
			PotionsBagSlot21Cap = 0;
			PotionsBagSlot22 = 0;
			PotionsBagSlot22Cap = 0;
			PotionsBagSlot23 = 0;
			PotionsBagSlot23Cap = 0;
			PotionsBagSlot24 = 0;
			PotionsBagSlot24Cap = 0;
			PotionsBagSlot25 = 0;
			PotionsBagSlot25Cap = 0;
			PotionsBagSlot26 = 0;
			PotionsBagSlot26Cap = 0;
			PotionsBagSlot27 = 0;
			PotionsBagSlot27Cap = 0;
			PotionsBagSlot28 = 0;
			PotionsBagSlot28Cap = 0;
			PotionsBagSlot29 = 0;
			PotionsBagSlot29Cap = 0;
			PotionsBagSlot30 = 0;
			PotionsBagSlot30Cap = 0;
			PotionsBagSlot31 = 0;
			PotionsBagSlot31Cap = 0;
			PotionsBagSlot32 = 0;
			PotionsBagSlot32Cap = 0;
			PotionsBagSlot33 = 0;
			PotionsBagSlot33Cap = 0;
			PotionsBagSlot34 = 0;
			PotionsBagSlot34Cap = 0;
			PotionsBagSlot35 = 0;
			PotionsBagSlot35Cap = 0;
			PotionsBagSlot36 = 0;
			PotionsBagSlot36Cap = 0;
			PotionsBagSlot37 = 0;
			PotionsBagSlot37Cap = 0;
			PotionsBagSlot38 = 0;
			PotionsBagSlot38Cap = 0;
			PotionsBagSlot39 = 0;
			PotionsBagSlot39Cap = 0;
			PotionsBagSlot40 = 0;
			PotionsBagSlot40Cap = 0;
			PotionsBagSlot41 = 0;
			PotionsBagSlot41Cap = 0;
			PotionsBagSlot42 = 0;
			PotionsBagSlot42Cap = 0;
			PotionsBagSlot43 = 0;
			PotionsBagSlot43Cap = 0;
			PotionsBagSlot44 = 0;
			PotionsBagSlot44Cap = 0;
			PotionsBagSlot45 = 0;
			PotionsBagSlot45Cap = 0;
			PotionsBagSlot46 = 0;
			PotionsBagSlot46Cap = 0;
			PotionsBagSlot47 = 0;
			PotionsBagSlot47Cap = 0;
			PotionsBagSlot48 = 0;
			PotionsBagSlot48Cap = 0;
			PotionsBagSlot49 = 0;
			PotionsBagSlot49Cap = 0;
			PotionsBagSlot50 = 0;
			PotionsBagSlot50Cap = 0;
		}

		public function saveToObject():Object {
			return {
				"GardenSlot01": GardenSlot01,
				"GardenSlot01Time": GardenSlot01Time,
				"GardenSlot02": GardenSlot02,
				"GardenSlot02Time": GardenSlot02Time,
				"GardenSlot03": GardenSlot03,
				"GardenSlot03Time": GardenSlot03Time,
				"GardenSlot04": GardenSlot04,
				"GardenSlot04Time": GardenSlot04Time,
				"GardenSlot05": GardenSlot05,
				"GardenSlot05Time": GardenSlot05Time,
				"GardenSlot06": GardenSlot06,
				"GardenSlot06Time": GardenSlot06Time,
				"GardenSlot07": GardenSlot07,
				"GardenSlot07Time": GardenSlot07Time,
				"GardenSlot08": GardenSlot08,
				"GardenSlot08Time": GardenSlot08Time,
				"GardenSlot09": GardenSlot09,
				"GardenSlot09Time": GardenSlot09Time,
				"GardenSlot10": GardenSlot10,
				"GardenSlot10Time": GardenSlot10Time,
				"GardenSlot11": GardenSlot11,
				"GardenSlot11Time": GardenSlot11Time,
				"GardenSlot12": GardenSlot12,
				"GardenSlot12Time": GardenSlot12Time,
				"IngrediantBagSlot01": IngrediantBagSlot01,
				"IngrediantBagSlot01Cap": IngrediantBagSlot01Cap,
				"IngrediantBagSlot02": IngrediantBagSlot02,
				"IngrediantBagSlot02Cap": IngrediantBagSlot02Cap,
				"IngrediantBagSlot03": IngrediantBagSlot03,
				"IngrediantBagSlot03Cap": IngrediantBagSlot03Cap,
				"IngrediantBagSlot04": IngrediantBagSlot04,
				"IngrediantBagSlot04Cap": IngrediantBagSlot04Cap,
				"IngrediantBagSlot05": IngrediantBagSlot05,
				"IngrediantBagSlot05Cap": IngrediantBagSlot05Cap,
				"IngrediantBagSlot06": IngrediantBagSlot06,
				"IngrediantBagSlot06Cap": IngrediantBagSlot06Cap,
				"IngrediantBagSlot07": IngrediantBagSlot07,
				"IngrediantBagSlot07Cap": IngrediantBagSlot07Cap,
				"IngrediantBagSlot08": IngrediantBagSlot08,
				"IngrediantBagSlot08Cap": IngrediantBagSlot08Cap,
				"IngrediantBagSlot09": IngrediantBagSlot09,
				"IngrediantBagSlot09Cap": IngrediantBagSlot09Cap,
				"IngrediantBagSlot10": IngrediantBagSlot10,
				"IngrediantBagSlot10Cap": IngrediantBagSlot10Cap,
				"PotionsBagSlot01": PotionsBagSlot01,
				"PotionsBagSlot01Cap": PotionsBagSlot01Cap,
				"PotionsBagSlot02": PotionsBagSlot02,
				"PotionsBagSlot02Cap": PotionsBagSlot02Cap,
				"PotionsBagSlot03": PotionsBagSlot03,
				"PotionsBagSlot03Cap": PotionsBagSlot03Cap,
				"PotionsBagSlot04": PotionsBagSlot04,
				"PotionsBagSlot04Cap": PotionsBagSlot04Cap,
				"PotionsBagSlot05": PotionsBagSlot05,
				"PotionsBagSlot05Cap": PotionsBagSlot05Cap,
				"PotionsBagSlot06": PotionsBagSlot06,
				"PotionsBagSlot06Cap": PotionsBagSlot06Cap,
				"PotionsBagSlot07": PotionsBagSlot07,
				"PotionsBagSlot07Cap": PotionsBagSlot07Cap,
				"PotionsBagSlot08": PotionsBagSlot08,
				"PotionsBagSlot08Cap": PotionsBagSlot08Cap,
				"PotionsBagSlot09": PotionsBagSlot09,
				"PotionsBagSlot09Cap": PotionsBagSlot09Cap,
				"PotionsBagSlot10": PotionsBagSlot10,
				"PotionsBagSlot10Cap": PotionsBagSlot10Cap,
				"PotionsBagSlot11": PotionsBagSlot11,
				"PotionsBagSlot11Cap": PotionsBagSlot11Cap,
				"PotionsBagSlot12": PotionsBagSlot12,
				"PotionsBagSlot12Cap": PotionsBagSlot12Cap,
				"PotionsBagSlot13": PotionsBagSlot13,
				"PotionsBagSlot13Cap": PotionsBagSlot13Cap,
				"PotionsBagSlot14": PotionsBagSlot14,
				"PotionsBagSlot14Cap": PotionsBagSlot14Cap,
				"PotionsBagSlot15": PotionsBagSlot15,
				"PotionsBagSlot15Cap": PotionsBagSlot15Cap,
				"PotionsBagSlot16": PotionsBagSlot16,
				"PotionsBagSlot16Cap": PotionsBagSlot16Cap,
				"PotionsBagSlot17": PotionsBagSlot17,
				"PotionsBagSlot17Cap": PotionsBagSlot17Cap,
				"PotionsBagSlot18": PotionsBagSlot18,
				"PotionsBagSlot18Cap": PotionsBagSlot18Cap,
				"PotionsBagSlot19": PotionsBagSlot19,
				"PotionsBagSlot19Cap": PotionsBagSlot19Cap,
				"PotionsBagSlot20": PotionsBagSlot20,
				"PotionsBagSlot20Cap": PotionsBagSlot20Cap,
				"PotionsBagSlot21": PotionsBagSlot21,
				"PotionsBagSlot21Cap": PotionsBagSlot21Cap,
				"PotionsBagSlot22": PotionsBagSlot22,
				"PotionsBagSlot22Cap": PotionsBagSlot22Cap,
				"PotionsBagSlot23": PotionsBagSlot23,
				"PotionsBagSlot23Cap": PotionsBagSlot23Cap,
				"PotionsBagSlot24": PotionsBagSlot24,
				"PotionsBagSlot24Cap": PotionsBagSlot24Cap,
				"PotionsBagSlot25": PotionsBagSlot25,
				"PotionsBagSlot25Cap": PotionsBagSlot25Cap,
				"PotionsBagSlot26": PotionsBagSlot26,
				"PotionsBagSlot26Cap": PotionsBagSlot26Cap,
				"PotionsBagSlot27": PotionsBagSlot27,
				"PotionsBagSlot27Cap": PotionsBagSlot27Cap,
				"PotionsBagSlot28": PotionsBagSlot28,
				"PotionsBagSlot28Cap": PotionsBagSlot28Cap,
				"PotionsBagSlot29": PotionsBagSlot29,
				"PotionsBagSlot29Cap": PotionsBagSlot29Cap,
				"PotionsBagSlot30": PotionsBagSlot30,
				"PotionsBagSlot30Cap": PotionsBagSlot30Cap,
				"PotionsBagSlot31": PotionsBagSlot31,
				"PotionsBagSlot31Cap": PotionsBagSlot31Cap,
				"PotionsBagSlot32": PotionsBagSlot32,
				"PotionsBagSlot32Cap": PotionsBagSlot32Cap,
				"PotionsBagSlot33": PotionsBagSlot33,
				"PotionsBagSlot33Cap": PotionsBagSlot33Cap,
				"PotionsBagSlot34": PotionsBagSlot34,
				"PotionsBagSlot34Cap": PotionsBagSlot34Cap,
				"PotionsBagSlot35": PotionsBagSlot35,
				"PotionsBagSlot35Cap": PotionsBagSlot35Cap,
				"PotionsBagSlot36": PotionsBagSlot36,
				"PotionsBagSlot36Cap": PotionsBagSlot36Cap,
				"PotionsBagSlot37": PotionsBagSlot37,
				"PotionsBagSlot37Cap": PotionsBagSlot37Cap,
				"PotionsBagSlot38": PotionsBagSlot38,
				"PotionsBagSlot38Cap": PotionsBagSlot38Cap,
				"PotionsBagSlot39": PotionsBagSlot39,
				"PotionsBagSlot39Cap": PotionsBagSlot39Cap,
				"PotionsBagSlot40": PotionsBagSlot40,
				"PotionsBagSlot40Cap": PotionsBagSlot40Cap,
				"PotionsBagSlot41": PotionsBagSlot41,
				"PotionsBagSlot41Cap": PotionsBagSlot41Cap,
				"PotionsBagSlot42": PotionsBagSlot42,
				"PotionsBagSlot42Cap": PotionsBagSlot42Cap,
				"PotionsBagSlot43": PotionsBagSlot43,
				"PotionsBagSlot43Cap": PotionsBagSlot43Cap,
				"PotionsBagSlot44": PotionsBagSlot44,
				"PotionsBagSlot44Cap": PotionsBagSlot44Cap,
				"PotionsBagSlot45": PotionsBagSlot45,
				"PotionsBagSlot45Cap": PotionsBagSlot45Cap,
				"PotionsBagSlot46": PotionsBagSlot46,
				"PotionsBagSlot46Cap": PotionsBagSlot46Cap,
				"PotionsBagSlot47": PotionsBagSlot47,
				"PotionsBagSlot47Cap": PotionsBagSlot47Cap,
				"PotionsBagSlot48": PotionsBagSlot48,
				"PotionsBagSlot48Cap": PotionsBagSlot48Cap,
				"PotionsBagSlot49": PotionsBagSlot49,
				"PotionsBagSlot49Cap": PotionsBagSlot49Cap,
				"PotionsBagSlot50": PotionsBagSlot50,
				"PotionsBagSlot50Cap": PotionsBagSlot50Cap
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				GardenSlot01 = o["GardenSlot01"];
				GardenSlot01Time = o["GardenSlot01Time"];
				GardenSlot02 = o["GardenSlot02"];
				GardenSlot02Time = o["GardenSlot02Time"];
				GardenSlot03 = o["GardenSlot03"];
				GardenSlot03Time = o["GardenSlot03Time"];
				GardenSlot04 = o["GardenSlot04"];
				GardenSlot04Time = o["GardenSlot04Time"];
				GardenSlot05 = o["GardenSlot05"];
				GardenSlot05Time = o["GardenSlot05Time"];
				GardenSlot06 = o["GardenSlot06"];
				GardenSlot06Time = o["GardenSlot06Time"];
				GardenSlot07 = o["GardenSlot07"];
				GardenSlot07Time = o["GardenSlot07Time"];
				GardenSlot08 = o["GardenSlot08"];
				GardenSlot08Time = o["GardenSlot08Time"];
				GardenSlot09 = o["GardenSlot09"];
				GardenSlot09Time = o["GardenSlot09Time"];
				GardenSlot10 = o["GardenSlot10"];
				GardenSlot10Time = o["GardenSlot10Time"];
				GardenSlot11 = o["GardenSlot11"];
				GardenSlot11Time = o["GardenSlot11Time"];
				GardenSlot12 = o["GardenSlot12"];
				GardenSlot12Time = o["GardenSlot12Time"];
				IngrediantBagSlot01 = o["IngrediantBagSlot01"];
				IngrediantBagSlot01Cap = o["IngrediantBagSlot01Cap"];
				IngrediantBagSlot02 = o["IngrediantBagSlot02"];
				IngrediantBagSlot02Cap = o["IngrediantBagSlot02Cap"];
				IngrediantBagSlot03 = o["IngrediantBagSlot03"];
				IngrediantBagSlot03Cap = o["IngrediantBagSlot03Cap"];
				IngrediantBagSlot04 = o["IngrediantBagSlot04"];
				IngrediantBagSlot04Cap = o["IngrediantBagSlot04Cap"];
				IngrediantBagSlot05 = o["IngrediantBagSlot05"];
				IngrediantBagSlot05Cap = o["IngrediantBagSlot05Cap"];
				IngrediantBagSlot06 = o["IngrediantBagSlot06"];
				IngrediantBagSlot06Cap = o["IngrediantBagSlot06Cap"];
				IngrediantBagSlot07 = o["IngrediantBagSlot07"];
				IngrediantBagSlot07Cap = o["IngrediantBagSlot07Cap"];
				IngrediantBagSlot08 = o["IngrediantBagSlot08"];
				IngrediantBagSlot08Cap = o["IngrediantBagSlot08Cap"];
				IngrediantBagSlot09 = o["IngrediantBagSlot09"];
				IngrediantBagSlot09Cap = o["IngrediantBagSlot09Cap"];
				IngrediantBagSlot10 = o["IngrediantBagSlot10"];
				IngrediantBagSlot10Cap = o["IngrediantBagSlot10Cap"];
				PotionsBagSlot01 = o["PotionsBagSlot01"];
				PotionsBagSlot01Cap = o["PotionsBagSlot01Cap"];
				PotionsBagSlot02 = o["PotionsBagSlot02"];
				PotionsBagSlot02Cap = o["PotionsBagSlot02Cap"];
				PotionsBagSlot03 = o["PotionsBagSlot03"];
				PotionsBagSlot03Cap = o["PotionsBagSlot03Cap"];
				PotionsBagSlot04 = o["PotionsBagSlot04"];
				PotionsBagSlot04Cap = o["PotionsBagSlot04Cap"];
				PotionsBagSlot05 = o["PotionsBagSlot05"];
				PotionsBagSlot05Cap = o["PotionsBagSlot05Cap"];
				PotionsBagSlot06 = o["PotionsBagSlot06"];
				PotionsBagSlot06Cap = o["PotionsBagSlot06Cap"];
				PotionsBagSlot07 = o["PotionsBagSlot07"];
				PotionsBagSlot07Cap = o["PotionsBagSlot07Cap"];
				PotionsBagSlot08 = o["PotionsBagSlot08"];
				PotionsBagSlot08Cap = o["PotionsBagSlot08Cap"];
				PotionsBagSlot09 = o["PotionsBagSlot09"];
				PotionsBagSlot09Cap = o["PotionsBagSlot09Cap"];
				PotionsBagSlot10 = o["PotionsBagSlot10"];
				PotionsBagSlot10Cap = o["PotionsBagSlot10Cap"];
				PotionsBagSlot11 = o["PotionsBagSlot11"];
				PotionsBagSlot11Cap = o["PotionsBagSlot11Cap"];
				PotionsBagSlot12 = o["PotionsBagSlot12"];
				PotionsBagSlot12Cap = o["PotionsBagSlot12Cap"];
				PotionsBagSlot13 = o["PotionsBagSlot13"];
				PotionsBagSlot13Cap = o["PotionsBagSlot13Cap"];
				PotionsBagSlot14 = o["PotionsBagSlot14"];
				PotionsBagSlot14Cap = o["PotionsBagSlot14Cap"];
				PotionsBagSlot15 = o["PotionsBagSlot15"];
				PotionsBagSlot15Cap = o["PotionsBagSlot15Cap"];
				PotionsBagSlot16 = o["PotionsBagSlot16"];
				PotionsBagSlot16Cap = o["PotionsBagSlot16Cap"];
				PotionsBagSlot17 = o["PotionsBagSlot17"];
				PotionsBagSlot17Cap = o["PotionsBagSlot17Cap"];
				PotionsBagSlot18 = o["PotionsBagSlot18"];
				PotionsBagSlot18Cap = o["PotionsBagSlot18Cap"];
				PotionsBagSlot19 = o["PotionsBagSlot19"];
				PotionsBagSlot19Cap = o["PotionsBagSlot19Cap"];
				PotionsBagSlot20 = o["PotionsBagSlot20"];
				PotionsBagSlot20Cap = o["PotionsBagSlot20Cap"];
				PotionsBagSlot21 = o["PotionsBagSlot21"];
				PotionsBagSlot21Cap = o["PotionsBagSlot21Cap"];
				PotionsBagSlot22 = o["PotionsBagSlot22"];
				PotionsBagSlot22Cap = o["PotionsBagSlot22Cap"];
				PotionsBagSlot23 = o["PotionsBagSlot23"];
				PotionsBagSlot23Cap = o["PotionsBagSlot23Cap"];
				PotionsBagSlot24 = o["PotionsBagSlot24"];
				PotionsBagSlot24Cap = o["PotionsBagSlot24Cap"];
				PotionsBagSlot25 = o["PotionsBagSlot25"];
				PotionsBagSlot25Cap = o["PotionsBagSlot25Cap"];
				PotionsBagSlot26 = o["PotionsBagSlot26"];
				PotionsBagSlot26Cap = o["PotionsBagSlot26Cap"];
				PotionsBagSlot27 = o["PotionsBagSlot27"];
				PotionsBagSlot27Cap = o["PotionsBagSlot27Cap"];
				PotionsBagSlot28 = o["PotionsBagSlot28"];
				PotionsBagSlot28Cap = o["PotionsBagSlot28Cap"];
				PotionsBagSlot29 = o["PotionsBagSlot29"];
				PotionsBagSlot29Cap = o["PotionsBagSlot29Cap"];
				PotionsBagSlot30 = o["PotionsBagSlot30"];
				PotionsBagSlot30Cap = o["PotionsBagSlot30Cap"];
				PotionsBagSlot31 = o["PotionsBagSlot31"];
				PotionsBagSlot31Cap = o["PotionsBagSlot31Cap"];
				PotionsBagSlot32 = o["PotionsBagSlot32"];
				PotionsBagSlot32Cap = o["PotionsBagSlot32Cap"];
				PotionsBagSlot33 = o["PotionsBagSlot33"];
				PotionsBagSlot33Cap = o["PotionsBagSlot33Cap"];
				PotionsBagSlot34 = o["PotionsBagSlot34"];
				PotionsBagSlot34Cap = o["PotionsBagSlot34Cap"];
				PotionsBagSlot35 = o["PotionsBagSlot35"];
				PotionsBagSlot35Cap = o["PotionsBagSlot35Cap"];
				PotionsBagSlot36 = o["PotionsBagSlot36"];
				PotionsBagSlot36Cap = o["PotionsBagSlot36Cap"];
				PotionsBagSlot37 = o["PotionsBagSlot37"];
				PotionsBagSlot37Cap = o["PotionsBagSlot37Cap"];
				PotionsBagSlot38 = o["PotionsBagSlot38"];
				PotionsBagSlot38Cap = o["PotionsBagSlot38Cap"];
				PotionsBagSlot39 = o["PotionsBagSlot39"];
				PotionsBagSlot39Cap = o["PotionsBagSlot39Cap"];
				PotionsBagSlot40 = o["PotionsBagSlot40"];
				PotionsBagSlot40Cap = o["PotionsBagSlot40Cap"];
				PotionsBagSlot41 = o["PotionsBagSlot41"];
				PotionsBagSlot41Cap = o["PotionsBagSlot41Cap"];
				PotionsBagSlot42 = o["PotionsBagSlot42"];
				PotionsBagSlot42Cap = o["PotionsBagSlot42Cap"];
				PotionsBagSlot43 = o["PotionsBagSlot43"];
				PotionsBagSlot43Cap = o["PotionsBagSlot43Cap"];
				PotionsBagSlot44 = o["PotionsBagSlot44"];
				PotionsBagSlot44Cap = o["PotionsBagSlot44Cap"];
				PotionsBagSlot45 = o["PotionsBagSlot45"];
				PotionsBagSlot45Cap = o["PotionsBagSlot45Cap"];
				PotionsBagSlot46 = o["PotionsBagSlot46"];
				PotionsBagSlot46Cap = o["PotionsBagSlot46Cap"];
				PotionsBagSlot47 = o["PotionsBagSlot47"];
				PotionsBagSlot47Cap = o["PotionsBagSlot47Cap"];
				PotionsBagSlot48 = o["PotionsBagSlot48"];
				PotionsBagSlot48Cap = o["PotionsBagSlot48Cap"];
				PotionsBagSlot49 = o["PotionsBagSlot49"];
				PotionsBagSlot49Cap = o["PotionsBagSlot49Cap"];
				PotionsBagSlot50 = o["PotionsBagSlot50"];
				PotionsBagSlot50Cap = o["PotionsBagSlot50Cap"];
			} else {
				// loading from old save
				resetState();
			}
		}
		
		public function Garden() 
		{
			Saves.registerSaveableState(this);
		}

	public function accessGarden():void {
		hideMenus();
		clearOutput();
		menu();
		//Checks if pc has this ingrediant growing
		outputText("You move over to your gardening fields. You can plant and grow herbs here.");
		addButton(0, "Put Herb In", putInHerbIntoHerbBag0);
		//plants typicaly takes 1 week to grow from a single ingrediant into 5 new ingrediants sample player can use this button to go to the harvest selection
		addButton(1, "Seed", Seed).hint("Plant down some seeds sacrificing an ingrediants.");
		//addFiveArgButton(2, "Harvest", Harvest, HarvestMoonScenes.harvestmoonstageHH >= 1, HarvestMoonScenes.harvestmoonstageMG >= 1, HarvestMoonScenes.harvestmoonstageSB >= 1, HarvestMoonScenes.harvestmoonstageIW >= 1, HarvestMoonScenes.harvestmoonstageBF >= 1).hint("Check your harvests.")
		addButton(14, "Back", camp.HerbalismMenu);
	}
	
	private function putInHerbIntoHerbBag0():void {
		menu();
		if (player.hasItem(consumables.HEALHERB)) addButton(0, "Healing herb", putInHerbIntoHerbBag, CoC.instance.consumables.HEALHERB);
		if (player.hasItem(consumables.MOONGRASS)) addButton(1, "Moon grass", putInHerbIntoHerbBag, CoC.instance.consumables.MOONGRASS);
		if (player.hasItem(consumables.SNAKEBANE)) addButton(2, "Snakebane", putInHerbIntoHerbBag, CoC.instance.consumables.SNAKEBANE);
		if (player.hasItem(consumables.IRONWEED)) addButton(3, "Ironweed", putInHerbIntoHerbBag, CoC.instance.consumables.IRONWEED);
		if (player.hasItem(consumables.BLADEFERN)) addButton(4, "Blade fern", putInHerbIntoHerbBag, CoC.instance.consumables.BLADEFERN);
		addButton(14, "Back", accessGarden);
	}
	private function putInHerbIntoHerbBag(ItemID:SimpleConsumable):void {
		clearOutput();
		outputText("In order to have some free space in your backpack you put one of the herbs into your bag.\n\n");
		player.destroyItems(ItemID, 1);
		if (ItemID == CoC.instance.consumables.HEALHERB) IngrediantBagSlot01++;
		if (ItemID == CoC.instance.consumables.MOONGRASS) IngrediantBagSlot02++;
		if (ItemID == CoC.instance.consumables.SNAKEBANE) IngrediantBagSlot03++;
		if (ItemID == CoC.instance.consumables.IRONWEED) IngrediantBagSlot04++;
		if (ItemID == CoC.instance.consumables.BLADEFERN) IngrediantBagSlot05++;
		doNext(putInHerbIntoHerbBag0);
	}
	
	private function timeUntilHarvest():Number {
		var tUH:Number = 168;
		return tUH;
	}

	private function Seed():void {
		hideMenus();
		clearOutput();
		menu();
		outputText("What kind of herb would you like to grow?");
		if (IngrediantBagSlot02 == 0) addButtonDisabled(0, "Healing herb", "You lack a plant sample in ingrediant bag to get seeds from.");
		else addButton(0, "Healing herb", Seed1, CoC.instance.consumables.HEALHERB).hint("Plant new seeds.");
		if (IngrediantBagSlot02 == 0) addButtonDisabled(1, "Moon grass", "You lack a plant sample in ingrediant bag to get seeds from.");
		else addButton(1, "Moon grass", Seed1, CoC.instance.consumables.MOONGRASS).hint("Plant new seeds.");
		if (IngrediantBagSlot03 == 0) addButtonDisabled(2, "Snakebane", "You lack a plant sample in ingrediant bag to get seeds from.");
		else addButton(2, "Snakebane", Seed1, CoC.instance.consumables.SNAKEBANE).hint("Plant new seeds.");
		if (IngrediantBagSlot04 == 0) addButtonDisabled(3, "Ironweed", "You lack a plant sample in ingrediant bag to get seeds from.");
		else addButton(3, "Ironweed", Seed1, CoC.instance.consumables.IRONWEED).hint("Plant new seeds.");
		if (IngrediantBagSlot05 == 0) addButtonDisabled(4, "Blade fern", "You lack a plant sample in ingrediant bag to get seeds from.");
		else addButton(4, "Blade fern", Seed1, CoC.instance.consumables.BLADEFERN).hint("Plant new seeds.");
		addButton(14, "Back", accessGarden).hint("Go back to garden menu.");
	}
	
	private function Seed1(ItemID:SimpleConsumable):void {
		hideMenus();
		clearOutput();
		menu();
		outputText("Which plot would you like to use?");
		if (GardenSlot01 != "") addButtonDisabled(0, "-1-", "This plot is already occupied. Wait until the crops are ready for harvest to plant anything here.");
		else addButton(0, "-1-", curry(Seed2, ItemID, 1));
		if (GardenSlot02 != "") addButtonDisabled(1, "-2-", "This plot is already occupied. Wait until the crops are ready for harvest to plant anything here.");
		else addButton(1, "-2-", curry(Seed2, ItemID, 2));
		addButton(14, "Back", Seed).hint("Go back to plot choice menu.");
	}

	private function Seed2(ItemID:SimpleConsumable, plot:Number):void {
		hideMenus();
		clearOutput();
		outputText("Planting a new herb will consume one of your herb items, proceed anyway?");
		doYesNo(curry(Seed3,ItemID,plot), Seed);
	}

	private function Seed3(ItemID:SimpleConsumable, plot:Number):void {
		var herb:String = "";
		if (ItemID == CoC.instance.consumables.HEALHERB) herb = "healing herb";
		if (ItemID == CoC.instance.consumables.MOONGRASS) herb = "moon grass";
		if (ItemID == CoC.instance.consumables.SNAKEBANE) herb = "snakebane";
		if (ItemID == CoC.instance.consumables.IRONWEED) herb = "ironweed";
		if (ItemID == CoC.instance.consumables.BLADEFERN) herb = "bladefern";
		switch (plot) {
			case 1:
				GardenSlot01 = herb;
				GardenSlot01Time = timeUntilHarvest();
				break;
			case 2:
				GardenSlot02 = herb;
				GardenSlot02Time = timeUntilHarvest();
				break;
			case 3:
				GardenSlot03 = herb;
				GardenSlot03Time = timeUntilHarvest();
				break;
			case 4:
				GardenSlot04 = herb;
				GardenSlot04Time = timeUntilHarvest();
				break;
			case 5:
				GardenSlot05 = herb;
				GardenSlot05Time = timeUntilHarvest();
				break;
			case 6:
				GardenSlot06 = herb;
				GardenSlot06Time = timeUntilHarvest();
				break;
			case 7:
				GardenSlot07 = herb;
				GardenSlot07Time = timeUntilHarvest();
				break;
			case 8:
				GardenSlot08 = herb;
				GardenSlot08Time = timeUntilHarvest();
				break;
			case 9:
				GardenSlot09 = herb;
				GardenSlot09Time = timeUntilHarvest();
				break;
			case 10:
				GardenSlot10 = herb;
				GardenSlot10Time = timeUntilHarvest();
				break;
			case 11:
				GardenSlot11 = herb;
				GardenSlot11Time = timeUntilHarvest();
				break;
			case 12:
				GardenSlot12 = herb;
				GardenSlot12Time = timeUntilHarvest();
				break;
			default:
				GardenSlot01 = herb;
				GardenSlot01Time = timeUntilHarvest();
		}
		Seed4(ItemID);
	}
	private function Seed4(ItemID:SimpleConsumable):void {
		clearOutput();
		outputText("You begin carefully planting the");
		player.destroyItems(ItemID, 1);
		if (ItemID == CoC.instance.consumables.HEALHERB) outputText("healing herb");
		if (ItemID == CoC.instance.consumables.MOONGRASS) outputText("moon grass");
		if (ItemID == CoC.instance.consumables.SNAKEBANE) outputText("snakebane");
		if (ItemID == CoC.instance.consumables.IRONWEED) outputText("ironweed");
		if (ItemID == CoC.instance.consumables.BLADEFERN) outputText("bladefern");
		outputText("into the fertile soil. It should grow back into several or more plants within a few days. Sometime you ponder if you shouldve just became a farmer back home you definitively have a knack for this.");
		var HE:Number = 20 + player.level;
		HE *= player.HerbalismMulti();
		player.herbXP(HE);
		doNext(Seed);
	}

	}
}