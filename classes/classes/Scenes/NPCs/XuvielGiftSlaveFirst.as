/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.StatusEffects;
import classes.internals.SaveableState;

public class XuvielGiftSlaveFirst extends NPCAwareContent implements SaveableState
	{
		public static var SlaveGender:Number;
		public static var HairColor:String;
		public static var SkinColor:String;
		public static var EyesColor:String;
		public static var SlaveName:String;
		public static var Defiance:Number;
		public static var SlavePersonality:Number;
		public static var CockDesc:String;
		public static var BallsDesc:String;
		public static var PussyDesc:String;
		public static var CupSize:String;
		public static var IsHumanStill:Boolean;
		public static var HalfRaceDesc:String;
		public static var HornsType:Number;
		public static var FaceType:Number;
		public static var LowerBodyType:Number;
		public static var TailType:Number;
		public static var WingsType:Number;

		public function stateObjectName():String {
			return "XuvielGiftSlaveFirst";
		}

		public function resetState():void {
			SlaveGender = 0;
			HairColor = "";
			SkinColor = "";
			EyesColor = "";
			SlaveName = "";
			Defiance = 0;
			SlavePersonality = 0;
			CockDesc = "";
			BallsDesc = "";
			PussyDesc = "";
			CupSize = "";
			IsHumanStill = false;
			HalfRaceDesc = "";
			HornsType = 0;
			FaceType = 0;
			LowerBodyType = 0;
			TailType = 0;
			WingsType = 0;
		}

		public function saveToObject():Object {
			return {
				"SlaveGender": SlaveGender,
				"HairColor": HairColor,
				"SkinColor": SkinColor,
				"EyesColor": EyesColor,
				"SlaveName": SlaveName,
				"Defiance": Defiance,
				"SlavePersonality": SlavePersonality,
				"CockDesc": CockDesc,
				"BallsDesc": BallsDesc,
				"PussyDesc": PussyDesc,
				"CupSize": CupSize,
				"IsHumanStill": IsHumanStill,
				"HalfRaceDesc": HalfRaceDesc,
				"HornsType": HornsType,
				"FaceType": FaceType,
				"LowerBodyType": LowerBodyType,
				"TailType": TailType,
				"WingsType": WingsType
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				SlaveGender = o["SlaveGender"];
				HairColor = o["HairColor"];
				SkinColor = o["SkinColor"];
				EyesColor = o["EyesColor"];
				SlaveName = o["SlaveName"];
				Defiance = o["Defiance"];
				SlavePersonality = o["SlavePersonality"];
				CockDesc = o["CockDesc"];
				BallsDesc = o["BallsDesc"];
				PussyDesc = o["PussyDesc"];
				CupSize = o["CupSize"];
				IsHumanStill = o["IsHumanStill"];
				HalfRaceDesc = o["HalfRaceDesc"];
				HornsType = o["HornsType"];
				FaceType = o["FaceType"];
				LowerBodyType = o["LowerBodyType"];
				TailType = o["TailType"];
				WingsType = o["WingsType"];
			} else {
				// loading from old save
				resetState();
			}
		}
		
		public function XuvielGiftSlaveFirst() 
		{
			Saves.registerSaveableState(this);
		}
		
	}

}