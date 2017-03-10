package classes.Scenes.NPCs{
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
     
    public class JojoSceneTest {
		private const ALWAYS_EXPECTED_TEXT:String = "You crawl further up his body and grin down at him as you press";
		private const WET_ONLY_EXPECTED_TEXT:String = "You moan as he works, your juices flowing liberally across his muzzle and into his";
		
        private var cut:JojoSceneForTest;
		private var player:Player;
		
		[BeforeClass]
		public static function setUpClass():void {
			kGAMECLASS = new CoC(StageLocator.stage);
		}
         
        [Before]
        public function setUp():void {  
			cut = new JojoSceneForTest();
			player = new Player();
			kGAMECLASS.player = player;
        }
		
		[Test] 
        public function testCorruptJojoVaginalSmotherNotWetEnough():void {
			player.createVagina();
			
			cut.testCorruptJojoVaginalSmother();
			
			assertThat(cut.collectedOutput, hasItem(startsWith(ALWAYS_EXPECTED_TEXT)));
			assertThat(cut.collectedOutput, not(hasItem(startsWith(WET_ONLY_EXPECTED_TEXT))));
		}
		
				
		[Test] 
        public function testCorruptJojoVaginalSmotherEnough():void {
			player.createVagina(false,5,1);
			
			cut.testCorruptJojoVaginalSmother();
			
			assertThat(cut.collectedOutput, hasItem(startsWith(ALWAYS_EXPECTED_TEXT)));
			assertThat(cut.collectedOutput, hasItem(startsWith(WET_ONLY_EXPECTED_TEXT)));
		} 
    }
}

import classes.Scenes.NPCs.JojoScene;

class JojoSceneForTest extends JojoScene {
	public var collectedOutput:Vector.<String> = new Vector.<String>(); 
	
	public function testCorruptJojoVaginalSmother():void {
		corruptJojoVaginalSmother();
	}
	
	override protected function outputText(output:String, purgeText:Boolean = false, parseAsMarkdown:Boolean = false):void {
		collectedOutput.push(output);
	}
}