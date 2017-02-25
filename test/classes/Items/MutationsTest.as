package classes.Items {
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	import classes.helper.StageLocator;
	
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Mutations;
	import classes.Player;
	import classes.CoC;
	import classes.StatusEffects;
	
    public class MutationsTest {
		private var player:Player;
		private var femalePlayer:Player;
        private var cut:Mutations;   
		
		[BeforeClass]
		public static function setUpClass():void { 
			kGAMECLASS = new CoC(StageLocator.stage);
		}
         
        [Before]
        public function setUp():void {  
			cut = Mutations.init();
			player = new Player();
			
			femalePlayer = new Player();
			femalePlayer.createBreastRow(2);
			femalePlayer.createVagina();

			// guard asserts			
			assertThat(player.hasVagina(), equalTo(false)); 
			assertThat(player.hasBreasts(), equalTo(false));
			assertThat(player.skinTone, equalTo("albino"));
			
			assertThat(femalePlayer.hasVagina(), equalTo(true)); 
			assertThat(femalePlayer.hasBreasts(), equalTo(true));
			assertThat(femalePlayer.hasCock(), equalTo(false));
        }
		
		private function drinkBova(count:int, tainted : Boolean, enhanced : Boolean, player : Player):void {
			var i:int;
			for(i = 0; i < count; i++) {
				cut.laBova(tainted, enhanced, player);
			}
		}
		
		[Test(expected="Error")]
        public function testConstructorFails():void {
            cut = new Mutations(); 
        }
		
		[Test]
		public function testLaBovaAddsStatusEffect():void {
            assertThat(femalePlayer.findStatusEffect(StatusEffects.CuntStretched), not(equalTo(0))) //guard assert
            
			drinkBova(100, true, false, femalePlayer);
			
			assertThat(femalePlayer.findStatusEffect(StatusEffects.CuntStretched), equalTo(0))
        }
		
		[Test]
		public function testLaBovaUpdatedStatusEffect():void {
            femalePlayer.createStatusEffect(StatusEffects.CuntStretched, int.MAX_VALUE, 0, 0, 0)
            assertThat(femalePlayer.statusEffect(femalePlayer.findStatusEffect(StatusEffects.CuntStretched)).value1, equalTo(int.MAX_VALUE))
			
			drinkBova(100, true, false, femalePlayer);
			
			assertThat(femalePlayer.statusEffect(femalePlayer.findStatusEffect(StatusEffects.CuntStretched)).value1, equalTo(0))
        }
    }
}