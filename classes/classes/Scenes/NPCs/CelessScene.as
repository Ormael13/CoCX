package classes.Scenes.NPCs 
{
	import classes.CoC;
	import classes.SaveAwareInterface;
	import classes.TimeAwareInterface;
	/**
	 * ...
	 * @author Oxdeception
	 */
	public class CelessScene extends NPCAwareContent implements TimeAwareInterface
	{
		// TODO Stick Celess vars in the save file.
		private var _age:int;
		private var _corrupt:Boolean;
		private var _name:String
		private var _armorFound:Boolean;
		
		public function CelessScene() 
		{
			CoC.timeAwareClassAdd(this);
		}
		
		/* INTERFACE classes.TimeAwareInterface */
		
		public function timeChange():Boolean 
		{
			if (_age > 0){_age++; }
			return false;
		}
		
		public function timeChangeLarge():Boolean 
		{
			if (_age > 720){
				growUpScene();
				_age = -1;
				return true;
			}
			return false;
		}
		// End Interface implementation
		
		public function get name():String{
			return _name;
		}
		public function get isFollower():Boolean{
			return _age != 0;
		}
		public function get isCorrupt():Boolean{
			return _corrupt;
		}
		public function get isAdult():Boolean{
			return _age == -1;
		}
		
		public function get armorFound():Boolean 
		{
			return _armorFound;
		}
		public function findArmor():void 
		{
			_armorFound = true;
		}
		
		public function campInteraction():void{
			
		}
		public function birthScene():void{
			trace("Celess is born");
			mainView.nameBox.text = "";
			doNext(nameScene);
		}
		public function nameScene():void{
			if (mainView.nameBox.text == ""){
				clearOutput();
				outputText("<b>You must name her.</b>");
				mainView.nameBox.text = "Celess";
				mainView.nameBox.visible = true;
				mainView.nameBox.width = 165;
				menu();
				mainView.nameBox.x = mainView.mainText.x + 5;
				mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
				addButton(0, "Next", nameScene);
				return;
			}
			_age = 1;
			_name = mainView.nameBox.text;
			_corrupt = player.cor > ((100+player.corruptionTolerance()) / 2);
			trace("Celess named: " + _name);
			trace("Celess corrupt: " + _corrupt);
			
			mainView.nameBox.visible = false;
			clearOutput();
			
			// TODO strings here!
			doNext(camp.returnToCampUseOneHour);
		}
		public function playtimeScene():void{
			
		}
		public function growUpScene():void{
			
		}
		public function incestMenu():void{
			
		}
		public function incestScene(scene:int):void{
			
		}
		
		public function itemImproveMenu():void{
			
		}
	}
}