package classes.Scenes.NPCs 
{
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
	import classes.PregnancyStore;
	import classes.Scenes.NPCs.IsabellaFollowerScene;
	
	public class IsabellaSceneTest 
	{
		private var cut : IsabellaScene;
		private var player:Player;
		
		private static const INCUBATION_DELTA : int = 10;
		/**
		 * This is used to skip time to the last pregnancy stage
		 */
		private static const ADVANCE_PREGNANCY : int = PregnancyStore.INCUBATION_ISABELLA - (IsabellaScene.ISABELLA_PREGNANCY_LAST_STAGE - INCUBATION_DELTA);
		
		public function IsabellaSceneTest() 
		{
		}
		
		[BeforeClass]
		public static function setUpClass():void {
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
		private function setUpIsabella() : void {
			cut = new IsabellaScene();
		}
		
		[Before]
        public function setUp():void {
			setUpIsabella();
			
			cut.pregnancy.knockUpForce();
			
			// preggers time!
			cut.pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_ISABELLA)
			
			player = new Player();
			kGAMECLASS.player = player;
        }
		
		[Test]
		public function isabellaNotPregnant_afterPregnancyClear() : void 
		{
			cut.pregnancy.knockUpForce();
			
			// law of demeter violation ahoi!
			assertThat(cut.pregnancy.isPregnant, equalTo(false));
		}
		
		[Test]
		public function isabellaPregnant_afterKnockUp() : void 
		{
			assertThat(cut.pregnancy.isPregnant, equalTo(true));
		}
		
		[Test]
		public function isabellaIncubationProgress_afterKnockUp() : void 
		{
			assertThat(cut.pregnancy.incubation, equalTo(PregnancyStore.INCUBATION_ISABELLA));
		}
		
				
		[Test]
		public function isabellaIncubationProgress_lastStageOfPregnancy() : void 
		{
			for (var i : int = 0; i < ADVANCE_PREGNANCY; i++ ) {
				cut.pregnancy.pregnancyAdvance();
			}
			
			assertThat(cut.pregnancy.incubation, between(0, IsabellaScene.ISABELLA_PREGNANCY_LAST_STAGE));
		}
		
		[Test]
		public function isabellaPregnancyEventStage_withUnsupportedPregnancyType() : void 
		{
			cut.pregnancy.knockUpForce()
			
			cut.pregnancy.knockUpForce(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_ISABELLA)
			
			assertThat(cut.pregnancy.event, 1);
		}
		
		[Test]
		public function isabellaPregnancyEventStage_afterKnockUp() : void 
		{
			cut.pregnancy.knockUpForce()
			
			cut.pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_ISABELLA)
			
			assertThat(cut.pregnancy.event, 2);
		}
				
		[Test]
		public function isabellaPregnancyEventStage_lastStageOfPregnancy() : void 
		{
			for (var i : int = 0; i < ADVANCE_PREGNANCY; i++ ) {
				cut.pregnancy.pregnancyAdvance();
			}
			
			assertThat(cut.pregnancy.event, equalTo(10));
		}
	}
}