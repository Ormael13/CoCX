/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.SaveableState;
	
	public class WaizAbiFollower extends NPCAwareContent implements SaveableState
	{
		public static var WaizAbiState:Number;//state or status (friend, lover, etc.)
		public static var WaizAbiAffection:Number;
		public static var WaizAbiWrathMulti:Number;
		public static var WaizAbiHPMulti:Number;
		public static var WaizAbiSoulforceMulti:Number;
		public static var WaizAbiLustMulti:Number;
		public static var WaizAbiOtherSecondaryBarsMulti:Number;//mana, fatigue ?and hunger?
		public static var WaizAbiStrMulti:Number;
		public static var WaizAbiSpeMulti:Number;
		public static var WaizAbiTouMulti:Number;
		public static var WaizAbiWisMulti:Number;
		public static var WaizAbiIntMulti:Number;
		public static var WaizAbiLibMulti:Number;
		public static var WaizAbiSensMulti:Number;

		public function stateObjectName():String {
			return "WaizAbiFollower";
		}

		public function resetState():void {
			WaizAbiState = 0;
			WaizAbiAffection = 0;
			WaizAbiWrathMulti = 1;
			WaizAbiHPMulti = 1;
			WaizAbiSoulforceMulti = 1;
			WaizAbiLustMulti = 1;
			WaizAbiOtherSecondaryBarsMulti = 1;
			WaizAbiStrMulti = 1;
			WaizAbiSpeMulti = 1;
			WaizAbiTouMulti = 1;
			WaizAbiWisMulti = 1;
			WaizAbiIntMulti = 1;
			WaizAbiLibMulti = 1;
			WaizAbiSensMulti = 1;
		}

		public function saveToObject():Object {
			return {
				"WaizAbiState": WaizAbiState,
				"WaizAbiAffection": WaizAbiAffection,
				"WaizAbiWrathMulti": WaizAbiWrathMulti,
				"WaizAbiHPMulti": WaizAbiHPMulti,
				"WaizAbiSoulforceMulti": WaizAbiSoulforceMulti,
				"WaizAbiLustMulti": WaizAbiLustMulti,
				"WaizAbiOtherSecondaryBarsMulti": WaizAbiOtherSecondaryBarsMulti,
				"WaizAbiStrMulti": WaizAbiStrMulti,
				"WaizAbiSpeMulti": WaizAbiSpeMulti,
				"WaizAbiTouMulti": WaizAbiTouMulti,
				"WaizAbiWisMulti": WaizAbiWisMulti,
				"WaizAbiIntMulti": WaizAbiIntMulti,
				"WaizAbiLibMulti": WaizAbiLibMulti,
				"WaizAbiSensMulti": WaizAbiSensMulti
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				WaizAbiState = o["WaizAbiState"];
				WaizAbiAffection = o["WaizAbiAffection"];
				WaizAbiWrathMulti = o["WaizAbiWrathMulti"];
				WaizAbiHPMulti = o["WaizAbiHPMulti"];
				WaizAbiSoulforceMulti = o["WaizAbiSoulforceMulti"];
				WaizAbiLustMulti = o["WaizAbiLustMulti"];
				WaizAbiOtherSecondaryBarsMulti = o["WaizAbiOtherSecondaryBarsMulti"];
				WaizAbiStrMulti = o["WaizAbiStrMulti"];
				WaizAbiSpeMulti = o["WaizAbiSpeMulti"];
				WaizAbiTouMulti = o["WaizAbiTouMulti"];
				WaizAbiWisMulti = o["WaizAbiWisMulti"];
				WaizAbiIntMulti = o["WaizAbiIntMulti"];
				WaizAbiLibMulti = o["WaizAbiLibMulti"];
				WaizAbiSensMulti = o["WaizAbiSensMulti"];
			} else {
				// loading from old save
				resetState();
			}
		}

		public function WaizAbiFollower() //adorable bimbo monkey... err sayian
		{
			Saves.registerSaveableState(this);
		}
		//WaizAbiStory: 1 - x, 2 - x, 3 - x
		public function bimboMonkey():void {
			clearOutput();
			outputText("\"<i>O Hai there,</i>\" she says looking over you from head to feet and back. \"<i>Mmmmm maybe you could put a good 'fight' or if not then at least good beatdown...</i>\" she trails out licking her lips slowly.\n\n");
			outputText("Wait what fight she mean? Is that some nonsense that any bimbo here would say or is ther deeper meaning to this?\n\n");
			outputText("\"<i>I not know. Maybe it's up to you te decide what it mean. Right?</i>\" She awaits your reaction while sipping some liquid from the glass she hold.\n\n");
			menu();
			addButton(1, "Sex", bimboMonkeySex);//(Koshya appearance here)
			addButton(2, "Fight", bimboMonkeyFight);//(And here)
			//3 - Drink (but not he.... jk also here appears)
			addButton(14, "Back", curry(SceneLib.journeyToTheEast.enteringInn, false));
		}//outputText("\"<i></i>\"\n\n");
		public function bimboMonkeySex():void {
			clearOutput();
			outputText("Then maybe a good 'fight'?\n\n");
			outputText("\"<i>Really???</i>\" her eyes nearly shines as she puts away the glass. After getting up she grabs your hand and leads you toward the entrance.\n\n");
			outputText("\"<i>Stop right there you sexual offender...</i>\" after leaving inn you hear someone calling you out. After turning around you see pale blue skinned female of averange look with snow white wings folded on her back. She walks to you and standing between you and monkey bimbo cast you contempting look.\n\n");
			outputText("\"<i>Return alone miss. I have someone to teach a lesson.</i>\" Newcommer speaks to monkey which after very long moment of hesistation nods and starting to walk away. Meanwhile blue-skinned angel points toward direction of Soul Arena. \"<i>Would you go on your own or should i drag you there?</i>\"\n\n");
			outputText("Slight annoyed by missed 'fight' you walks to the arena and enter one of it sections.\n\n");
			outputText("\"<i>Now, shall we start education?</i>\" After asking angelic woman assunme combat pose unfolding her wings.\n\n");
			startCombat(new Koshya());
		}
		public function bimboMonkeyFight():void {
			clearOutput();
			outputText("You're down for some good beatdown.\n\n");
			outputText("\"<i>Ohhh beatdown. Well i can get behind that too.</i>\" she slowly puts away the glass. After getting up she grabs your hand and leads you toward the entrance.\n\n");
			outputText("You follow her thou the village until both of you enter the Soul Arena. Picking one of empty parts of it both of you stand on oppposite of each others when pale blue skinned female of averange look with snow white wings folded on her back interrupts.\n\n");
			outputText("\"<i>Miss. You shouldn't fight. Let this humble servant replace you in this brawl. I shall try my best to not dissapoint your opponent.</i>\" She speaks gently but you got some gut feeling she may get mroe forcefully as long her miss not agree to this request.\n\n");
			outputText("\"<i>But why i can't even fight. No fuck no fights. You're such a boring servant.</i>\" Bimbo monkey pouts but still slowly walking toward the nearby stands. \"<i>Fine but next time you won;t interrupt my fight...</i>\"\n\n");
			outputText("\"<i>Of course milady.</i>\" Replies angelic woman as she take the monkey spot before you unfolding her wings.\n\n");
			startCombat(new Koshya());
		}
		public function bimboMonkeyDrink():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
			
		}
		
		public function WaizAbiMainMenu():void {
			
		}
		
		/*public function c():void {
			
		}
		
		public function b():void {
			
		}
		
		public function a():void {
			
		}*/
	}
}