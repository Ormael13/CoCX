package classes{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	import classes.CharSpecial;
	import classes.CoC;
	import classes.Player;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.helper.StageLocator;
	import classes.CharCreation;
	
    public class CharCreationTest {
        private var cut:CharCreationForTest;
		
		[BeforeClass]
		public static function runOnceForTestClass():void { 
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
        [Before]
        public function setUp():void {
			cut = new CharCreationForTest();
			kGAMECLASS.player = new Player();
        }  
     
		[Test(description="Check that the array or vector for vaginas is correctly initialised")] 
        public function testReincarnateCreatesVaginaStoreNotNull():void {
			cut.testReincarnate();
			
			assertThat(kGAMECLASS.player.vaginas, notNullValue());
        }
		
		[Test(description="Check that the array or vector for vaginas is correctly initialised")] 
        public function testReincarnateCreatesVaginaStoreZeroLength():void {
			cut.testReincarnate();
			
			assertThat(kGAMECLASS.player.vaginas, emptyArray());
        }
    }
}

import classes.CharCreation;
/**
 * This is to allow the testing of functions without making them public in the actual class.
 */
class CharCreationForTest extends CharCreation {
	public function testReincarnate():void {
		reincarnate();
	}
}