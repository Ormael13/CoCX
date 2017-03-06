package classes{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	import flash.display.Stage;
	
	import classes.GlobalFlags.kGAMECLASS;
	import classes.CoC;
	import classes.helper.StageLocator;
	import classes.PlayerEvents;
	import classes.Player;
	
    public class PlayerEventsTest {
		include "../../includes/appearanceDefs.as";
		
		private const LOOSENESS:Number = VAGINA_LOOSENESS_LOOSE;
		
        private var cut:PlayerEvents;
		private var player:Player;
		
		[BeforeClass]
		public static function setUpClass():void {
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
        [Before]
        public function setUp():void {
			player = new Player();
			kGAMECLASS.player = player;
			cut = new PlayerEvents();
			
			player.createVagina(false, 1, LOOSENESS);
			player.vaginas[0].recoveryProgress = Number.MAX_VALUE;
        }
		
		// most of the recovery tests are performed with a parametrized tests
		
        [Test] 
        public function testVaginaLoosenessChangeWithNoVagina():void {
			player.removeVagina();
			
			cut.timeChange();
			
			assertThat(player.hasVagina(), equalTo(false));
        }
		
		[Test] 
        public function testVaginaLoosenessChangeWithoutStatus():void {
			player.vaginas[0].resetRecoveryProgress();
						
			cut.timeChange();
			
			assertThat(player.looseness(), equalTo(LOOSENESS));
        }
    }
}