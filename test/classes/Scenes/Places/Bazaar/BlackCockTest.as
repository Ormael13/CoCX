package classes.Scenes.Places.Bazaar{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	import classes.helper.StageLocator;
	
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.CoC;
     
    public class BlackCockTest {
		private const ALWAYS_EXPECTED_TEXT:String = "\n\nThe moment you think this, Harry reaches his free hand";
		private const WET_ONLY_EXPECTED_TEXT:String = "Every time you gush fluid onto his fingers he vibrates his palm, sending";
		
        private var cut:BlackCockForTest;
		private var player:Player;
		
		[BeforeClass]
		public static function setUpClass():void {
			kGAMECLASS = new CoC(StageLocator.stage);
		}
         
        [Before]
        public function setUp():void {  
			cut = new BlackCockForTest();
			player = new Player();
			kGAMECLASS.player = player;
        }
		
		[Test] 
        public function testHarryFuckNotWetEnough():void {
			player.createVagina();
			
			cut.testHaveHarryFuckYou();
			
			assertThat(cut.collectedOutput, hasItem(startsWith(ALWAYS_EXPECTED_TEXT)));
			assertThat(cut.collectedOutput, not(hasItem(startsWith(WET_ONLY_EXPECTED_TEXT))));
		}
		
				
		[Test] 
        public function testHarryFuckWetEnough():void {
			player.createVagina(false,5,1);
			
			cut.testHaveHarryFuckYou();
			
			assertThat(cut.collectedOutput, hasItem(startsWith(ALWAYS_EXPECTED_TEXT)));
			assertThat(cut.collectedOutput, hasItem(startsWith(WET_ONLY_EXPECTED_TEXT)));
		} 
    }
}

import classes.Scenes.Places.Bazaar.BlackCock;

class BlackCockForTest extends BlackCock {
	public var collectedOutput:Vector.<String> = new Vector.<String>(); 
	
	public function testHaveHarryFuckYou():void {
		haveHarryFuckYou();
	}
	
	override protected function outputText(output:String, purgeText:Boolean = false, parseAsMarkdown:Boolean = false):void {
		collectedOutput.push(output);
	}
}