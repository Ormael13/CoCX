package classes.Scenes.NPCs
{
	import classes.DefaultDict;
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
	import classes.PerkLib;
	import classes.CockTypesEnum;
	
	public class IsabellaFollowerSceneTest 
	{
		private var isabellaScene : IsabellaScene;
		private var cut:IsabellaFollowerSceneForTest;
		private var player:Player;
		
		private static const INCUBATION_DELTA : int = 10;
		/**
		 * This is used to skip time to the last pregnancy stage
		 */
		private static const ADVANCE_PREGNANCY : int = PregnancyStore.INCUBATION_ISABELLA - (IsabellaScene.ISABELLA_PREGNANCY_LAST_STAGE - INCUBATION_DELTA);
		
		public function IsabellaFollowerSceneTest() 
		{
		}
		
		[BeforeClass]
		public static function setUpClass():void {
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
		private function setUpIsabella() : void {
			isabellaScene = new IsabellaScene();
			cut = new IsabellaFollowerSceneForTest();
		}
		
		[Before]
        public function setUp():void {
			setUpIsabella();
			
			isabellaScene.pregnancy.knockUpForce();
			
			// preggers time!
			isabellaScene.pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_ISABELLA)
			
			player = new Player();
			kGAMECLASS.player = player;
        }
		
		//FIXME text comparison makes for brittle tests, it would drive proofreaders nuts -> replace with const

		[Test]
		public function isabellaAppearance_withUnsupportedPregnancyType() : void 
		{
			isabellaScene.pregnancy.knockUpForce()
			isabellaScene.pregnancy.knockUpForce(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_ISABELLA)
			
			cut.isaAppearance();
			
			assertThat(cut.collectedOutput, hasItem(equalTo("you cannot help but question as to whether or not your seed was \"planted\" in the Bovine Braud's womb.")));
		}
		
		[Test]
		public function isabellaAppearance_playerLowCumQuantity() : void 
		{
			isabellaScene.pregnancy.knockUpForce()
			isabellaScene.pregnancy.knockUpForce(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_ISABELLA)
			
			player.cocks = []
			assertThat(player.cumQ(), equalTo(0)); // guard assert 

			cut.isaAppearance();
			
			assertThat(cut.collectedOutput, not(hasItem(equalTo("and your potent babymaking skills, "))));
		}
		
		[Test]
		public function isabellaAppearance_playerHighCumQuantity() : void 
		{
			isabellaScene.pregnancy.knockUpForce()
			isabellaScene.pregnancy.knockUpForce(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_ISABELLA)
			player.createPerk(PerkLib.FerasBoonSeeder, 0, 0, 0, 0);
			player.createCock(6, 1, CockTypesEnum.HUMAN);
			assertThat(player.cumQ(), greaterThan(500)); // guard assert 
			
			cut.isaAppearance();
			
			assertThat(cut.collectedOutput, hasItem(equalTo("and your potent babymaking skills, ")));
		}
		
		[Test]
		public function isabellaAppearance_whenNotPregnant() : void 
		{
			isabellaScene.pregnancy.knockUpForce();
			
			cut.isaAppearance();
			
			assertThat(cut.collectedOutput, hasItem(equalTo("The cow-girl is about seven and a half feet tall. Instead of feet, she has hooves, complete with fur that grows part-way up her legs. Her olive skirt only covers the upper portion of her dusky, spotted thighs, and it flares out deliciously from her swaying hips. Isabella's top is sheer, white silk that barely hides anything from you, least of all her exotic, quad-tipped nipples. Unlike most of the rest of her, her face is not spotted with dark and white patches. Instead it is pure, unbroken chocolate in color. Two small, bovine horns sprout from her head, emerging from the tangle of her unruly, red curls. She even has a pair of cow ears that flick back and forth from time to time.")));
		}
		
		[Test]
		public function isabellaAppearance_firstStageOfPregnancy() : void 
		{
			cut.isaAppearance();
			
			assertThat(cut.collectedOutput, hasItem(equalTo("The cow-girl is about seven and a half feet tall. Instead of feet, she has hooves, complete with fur that grows part-way up her legs. Her olive skirt only covers the upper portion of her dusky, spotted thighs, and it flares out deliciously from her swaying hips. Since you did the deed you often find her on her plump, toned, derriere. ")));
		}
		
		[Test]
		public function isabellaAppearance_playerLowLibido() : void 
		{
			player.lib = 0;
			
			cut.isaAppearance();
			
			assertThat(cut.collectedOutput, not(hasItem(equalTo("Every once in a while when the wind blows just right you get a pleasing view of her well lubricated womanhood between her legs. "))));
		}
		
		[Test]
		public function isabellaAppearance_playerHighLibido() : void 
		{
			player.lib = 100;
			
			cut.isaAppearance();
			
			assertThat(cut.collectedOutput, hasItem(equalTo("Every once in a while when the wind blows just right you get a pleasing view of her well lubricated womanhood between her legs. ")));
		}
		
		[Test]
		public function isabellaAppearance_lastStageOfPregnancy() : void 
		{
			for (var i : int = 0; i < ADVANCE_PREGNANCY; i++ ) {
				isabellaScene.pregnancy.pregnancyAdvance();
			}
			
			cut.isaAppearance();
			
			assertThat(cut.collectedOutput, hasItem(containsString("it kicked")));
		}
	}
}

import classes.Scenes.NPCs.IsabellaFollowerScene;

/**
 * Class to collect scene text output so the test can compare it to expected values.
 */
class IsabellaFollowerSceneForTest extends IsabellaFollowerScene {
	public var collectedOutput:Vector.<String> = new Vector.<String>(); 
	
	override protected function outputText(output:String, purgeText:Boolean = false, parseAsMarkdown:Boolean = false):void {
		collectedOutput.push(output);
	}
	
	/**
	 * This is to avoid making the appearance function public
	 */
	public function isaAppearance() : void {
		this.isabellasAppearance();
	}
	
	override protected function isabellasAppearance():void {
		super.isabellasAppearance();
	}
 }
