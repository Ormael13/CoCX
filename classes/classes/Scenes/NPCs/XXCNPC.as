package classes.Scenes.NPCs 
{
	import classes.BaseContent;
	import classes.CoC;
	import coc.xxc.Story;
	import classes.GlobalFlags.kGAMECLASS;
	import coc.xxc.StoryContext;
	
	/**
	 * ...
	 * @author Oxdeception
	 */
	internal class XXCNPC extends BaseContent
	{
		protected var _story:Story;
		protected var _context:StoryContext;
		protected var _storyName:String;
		
		public function XXCNPC(storyName:String) 
		{
			_storyName = storyName;
			if(!kGAMECLASS||kGAMECLASS.rootStory == null){
				CoC.onGameInit(init);
			}
			else {init();}
		}
		private function init():void{
			_story = kGAMECLASS.rootStory.locate(_storyName);
			_context = kGAMECLASS.context;
		}
		protected function display(toDisplay:String):void
		{
			_story.display(_context, toDisplay);
		}
	}
}