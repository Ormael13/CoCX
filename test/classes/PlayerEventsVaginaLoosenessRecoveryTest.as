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
	
	  
	import org.flexunit.runners.Parameterized;
    
	/**
	 * Test treshold values for vagina looseness recovery.
	 */
	
    [RunWith("org.flexunit.runners.Parameterized")]
    public class PlayerEventsVaginaLoosenessRecoveryTest {
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
			player.createStatusEffect(StatusEffects.CuntStretched, Number.MAX_VALUE, 0, 0, 0);
        }
		
		private function setVaginaSize(size:Number):void {
			player.removeVagina();
			player.createVagina(false, 1, size);  
		}
		
		/**
		 * Sets 'cuntStretched' status to the give value - 1.
		 * The - 1 is required to counteract the code adding 1 to the value prior to checking.
		 */
		private function setVaginaStretchStatus(value:Number):void {
			player.removeStatusEffect(StatusEffects.CuntStretched);
			player.createStatusEffect(StatusEffects.CuntStretched, value - 1, 0, 0, 0);
		}
     
	 
          [Parameters]
          public static var testData:Array = [    
		  	[VAGINA_LOOSENESS_LOOSE, PlayerEvents.VAGINA_RECOVER_THRESHOLD_LOOSE, 0],
			[VAGINA_LOOSENESS_GAPING, PlayerEvents.VAGINA_RECOVER_THRESHOLD_GAPING, 0],
			[VAGINA_LOOSENESS_GAPING_WIDE, PlayerEvents.VAGINA_RECOVER_THRESHOLD_GAPING_WIDE, 0],
			[VAGINA_LOOSENESS_LEVEL_CLOWN_CAR, PlayerEvents.VAGINA_RECOVER_THRESHOLD_CLOWN_CAR, 1]
			];
           
          private var looseness:Number;
          private var threshold:Number;
		   private var ferrasBoonChange:Number;
		  
		        
		public function PlayerEventsVaginaLoosenessRecoveryTest(looseness:Number, threshold:Number, ferrasBoonChange:Number){
               this.looseness = looseness;
               this.threshold = threshold;
			   this.ferrasBoonChange = ferrasBoonChange;
		}
		
		[Test]
        public function testAffectedByFerasBoon():void {
			player.createPerk(PerkLib.FerasBoonWideOpen, 1, 1, 1, 1);
			setVaginaSize(looseness);
			setVaginaStretchStatus(Number.MAX_VALUE);
		
			cut.timeChange();
			
			assertThat(player.looseness(), equalTo(looseness - ferrasBoonChange));
        }
		
		[Test]
        public function testStatusEffectReset():void {
			setVaginaSize(looseness);
			setVaginaStretchStatus(threshold);
		
			cut.timeChange();
			
			assertThat(player.statusEffectv1(StatusEffects.CuntStretched), equalTo(0));
        }
		
		[Test]
        public function testVaginaLoosenessChangeThreshold_above():void {
			setVaginaSize(looseness);
			setVaginaStretchStatus(threshold + 1);
					
			cut.timeChange();
			
			assertThat(player.looseness(), equalTo(looseness - 1));
        }
				
		[Test]
        public function testVaginaLoosenessChangeThreshold_at():void {
			setVaginaSize(looseness);
			setVaginaStretchStatus(threshold);
		
			cut.timeChange();
			
			assertThat(player.looseness(), equalTo(looseness - 1));
        }
		
		[Test]
        public function testVaginaLoosenessChangeThreshold_below():void {
			setVaginaSize(looseness);
			setVaginaStretchStatus(threshold - 1);

			cut.timeChange();
			
			assertThat(player.looseness(), equalTo(looseness));
        }
    }
}