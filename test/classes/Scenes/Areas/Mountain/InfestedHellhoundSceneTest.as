package classes.Scenes.Areas.Mountain 
{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	import classes.CoC;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.PregnancyStore;
	import classes.helper.StageLocator;
	public class InfestedHellhoundSceneTest 
	{
		private var cut:InfestedHellhoundScene;
		private var player:Player;
		
		public function InfestedHellhoundSceneTest() 
		{
			
		}
		
		[BeforeClass]
		public static function setUpClass():void {
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
		[Before]
        public function setUp():void {
			player = new Player();
			player.createVagina();
			
			kGAMECLASS.player = player;
			
			cut = new InfestedHellhoundScene();
        }
		
		/**
		 * Test to expose issue 'Worm pregnancy override bug' #458
		 */
		[Test]
		public function checkThatWormsDoNotClearPregnancy():void {
			player.knockUpForce(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP);
			
			cut.infestedHellhoundLossRape();
			
			assertThat(player.pregnancyType, equalTo(PregnancyStore.PREGNANCY_IMP));
		}
		
		[Test]
		public function wormPregnancyIfNotPregnant():void {
			assertThat(player.isPregnant(), equalTo(false)); // guard assert
			
			cut.infestedHellhoundLossRape();
			
			assertThat(player.pregnancyType, equalTo(PregnancyStore.PREGNANCY_WORM_STUFFED));
		}
	}
}
