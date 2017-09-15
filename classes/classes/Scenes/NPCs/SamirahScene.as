package classes.Scenes.NPCs 
{
	/**
	 * ...
	 * @author Oxdeception
	 */
	public class SamirahScene extends XXCNPC
	{
		private static var _instance:SamirahScene;
		private var _status:int;
		private var _affection:int;
		public function SamirahScene() 
		{
			if(!_instance){
				super("samirah");
				_instance = this;
			}
			else{
				throw new Error("Singleton class. Use getInstance()");
			}
		}
		public function debugDisplay():void{
			_story.display(_context, "strings/debug");
		}
		static public function getInstance():SamirahScene 
		{
			if (_instance == null){
				new SamirahScene();
			}
			return _instance;
		}
	}
}