package classes{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	import classes.helper.StageLocator;
	
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Creature;
	import classes.CoC;
     
    public class CreatureTest {
		include "../../includes/appearanceDefs.as";
		
		private const MAX_SUPPORTED_VAGINAS:Number = 2;
		private const DEFAULT_CLIT_LENGTH:Number = 0.5;
		private const TEST_CLIT_LENGTH:Number = 3;
		private const CUNT_CHANGE_VALUE:Number = 5;
		
        private var cut:Creature;
		
		private function createVaginas(numberOfVaginas:Number):void {
			var i:Number;
			
			for(i=0; i<numberOfVaginas; i++) {
				cut.createVagina();
			}
		}
		
		private function createMaxVaginas():void {
			createVaginas(MAX_SUPPORTED_VAGINAS);
		}
		
		[BeforeClass]
		public static function setUpClass():void {
		 /* Hidden dependencies on global variables can cause tests to fail spectacularly.
		  * 
		  * Seriously people, DONT use global variables.
		  */
		  
			kGAMECLASS = new CoC(StageLocator.stage);
		}
         
        [Before]
        public function setUp():void {  
			cut = new Creature();
        }  
		
		[Test] 
        public function testValidation():void {
            assertThat(cut.validate(), equalTo("Empty 'weaponName'. Empty 'weaponVerb'. Empty 'armorName'. "));  
        }
        	
		[Test] 
        public function testWetnessWithNoVagina():void {
            assertThat(cut.hasVagina(), equalTo(false)); //guard assert
            
			assertThat(cut.wetness(), equalTo(0));
        }
		
		[Test] 
        public function testWetnessWithVagina():void {
			assertThat(cut.createVagina(), equalTo(true));			
            
			assertThat(cut.wetness(), equalTo(1));
        }
		
		[Test] 
        public function testVaginaTypeWithNoVagina():void {
			assertThat(cut.vaginaType(), equalTo(-1));
        }
		
		[Test] 
        public function testVaginaTypeWithVagina():void {
			assertThat(cut.createVagina(), equalTo(true));
			
			assertThat(cut.vaginaType(), equalTo(VAGINA_TYPE_HUMAN));
        }
		
		[Test] 
        public function testSetVaginaTypeWithNoVagina():void {
			assertThat(cut.vaginaType(VAGINA_TYPE_EQUINE), equalTo(-1));
        }
		
		[Test] 
        public function testSetVaginaTypeWithVagina():void {
			assertThat(cut.createVagina(), equalTo(true));
			
			assertThat(cut.vaginaType(VAGINA_TYPE_EQUINE), equalTo(VAGINA_TYPE_EQUINE));
        }
		
		[Test] 
        public function testReadVaginaTypeAfterSet():void {
			assertThat(cut.createVagina(), equalTo(true));
			
			cut.vaginaType(VAGINA_TYPE_EQUINE);
			
			assertThat(cut.vaginaType(), equalTo(VAGINA_TYPE_EQUINE));
        }
		
		[Test] 
        public function testLoosenessVaginaWithNoVagina():void {
			assertThat(cut.looseness(), equalTo(0));
        }
		
		[Test] 
        public function testLoosenessVaginaWithVagina():void {
			assertThat(cut.createVagina(), equalTo(true));
			
			assertThat(cut.looseness(), equalTo(0));
        }
		
		[Test] 
        public function testLoosenessAnus():void {
			assertThat(cut.looseness(false), equalTo(0));
        }
		
		[Test] 
        public function testVaginalCapacityNoVagina():void {
			assertThat(cut.vaginalCapacity(), equalTo(0));
        }
		
		[Test] 
        public function testVaginalCapacityWithVagina():void {
			assertThat(cut.createVagina(), equalTo(true));
			
			assertThat(cut.vaginalCapacity(), equalTo(0));
        }
		
		[Test] 
        public function testVaginalCapacityWithVaginaAfterStrech():void {
			assertThat(cut.createVagina(), equalTo(true));
			cut.cuntChangeNoDisplay(CUNT_CHANGE_VALUE)
			
			assertThat(cut.vaginalCapacity(), equalTo(8.8));
        }
		
		[Test] 
        public function testHasVaginaWithNoVagina():void {
            assertThat(cut.hasVagina(), equalTo(false));  
        }
		
		[Test] 
        public function testHasVaginaWithVagina():void {
			assertThat(cut.createVagina(), equalTo(true));
			
            assertThat(cut.hasVagina(), equalTo(true));  
        }
		
		[Test] 
        public function testHasVirginVaginaWithNoVagina():void {
            assertThat(cut.hasVirginVagina(), equalTo(false));  
        }
		
		[Test] 
        public function testHasVirginVaginaWithVirginVagina():void {
			assertThat(cut.createVagina(), equalTo(true));
			
            assertThat(cut.hasVirginVagina(), equalTo(true));  
        }
		
		[Test] 
        public function testHasVirginVaginaWithNonVirginVagina():void {
			assertThat(cut.createVagina(false), equalTo(true));
			
            assertThat(cut.hasVirginVagina(), equalTo(false));  
        }
		
		[Test] 
        public function testCreateVaginaVirgin():void {
			assertThat(cut.createVagina(), equalTo(true));
			
            assertThat(cut.hasVirginVagina(), equalTo(true));  
        }
		
		[Test] 
        public function testCreateVaginaNonVirgin():void {
			assertThat(cut.createVagina(false), equalTo(true));
			
            assertThat(cut.hasVirginVagina(), equalTo(false));  
        }
		
		[Test] 
        public function testCreateVaginaWetness():void {
			assertThat(cut.createVagina(true, 3), equalTo(true));
			
            assertThat(cut.wetness(), equalTo(3));  
        }
		
		[Test] 
        public function testCreateVaginaLooseness():void {
			assertThat(cut.createVagina(true, 1, 3), equalTo(true));
			
            assertThat(cut.looseness(), equalTo(3));  
        }
		
		[Test] 
        public function testCreateVaginaMaxVaginas():void {
			createMaxVaginas();
			
			assertThat(cut.createVagina(), equalTo(false));
        }
		
		[Test] 
        public function testCreateVaginaMaxVaginasArraySize():void {
			createVaginas(MAX_SUPPORTED_VAGINAS + 1);
			
			assertThat(cut.vaginas, arrayWithSize(MAX_SUPPORTED_VAGINAS));
        }

		[Test] 
        public function testRemoveVaginaNegativeIndex():void {
			createMaxVaginas();
			
			cut.removeVagina(-2);
			
			assertThat(cut.vaginas, arrayWithSize(MAX_SUPPORTED_VAGINAS));
        }
		
		[Test] 
        public function testRemoveVaginaNegativeRemoveCount():void {
			createMaxVaginas();
			
			cut.removeVagina(0, -1);
			
			assertThat(cut.vaginas, arrayWithSize(MAX_SUPPORTED_VAGINAS));
        }
		
		[Test] 
        public function testRemoveVaginaIndexToLarge():void {
			createMaxVaginas();
			
			cut.removeVagina(MAX_SUPPORTED_VAGINAS + 1);
			
			assertThat(cut.vaginas, arrayWithSize(MAX_SUPPORTED_VAGINAS));
        }
		
		[Test] 
        public function testRemoveVaginaSpecificIndexFirst():void {
			assertThat(cut.createVagina(true, 1, 2), equalTo(true));
			assertThat(cut.createVagina(true, 1, 3), equalTo(true));
			
			cut.removeVagina(0);
			
			assertThat(cut.looseness(), equalTo(3));
        }
		
		[Test] 
        public function testRemoveVaginaRemoveLastWithMinusOne():void {
			assertThat(cut.createVagina(true, 1, 2), equalTo(true));
			assertThat(cut.createVagina(true, 1, 3), equalTo(true));
			
			cut.removeVagina(-1);
			
			assertThat(cut.looseness(), equalTo(2));
			assertThat(cut.vaginas, arrayWithSize(1));
        }
		
		[Test] 
        public function testRemoveVaginaSpecificIndexLast():void {
			assertThat(cut.createVagina(true, 1, 2), equalTo(true));
			assertThat(cut.createVagina(true, 1, 3), equalTo(true));
			
			cut.removeVagina(1);
			
			assertThat(cut.looseness(), equalTo(2));
			assertThat(cut.vaginas, arrayWithSize(1));
        }
		
		[Test] 
        public function testCuntChangeNoDisplayLoosnessChanged():void {
			assertThat(cut.createVagina(), equalTo(true));
			assertThat(cut.looseness(), equalTo(0)); // guard assert
			
			cut.cuntChangeNoDisplay(CUNT_CHANGE_VALUE);
			
			assertThat(cut.looseness(), equalTo(1));
        }
		
		[Test] 
        public function testCuntChangeNoDisplayIsStretched():void {
			assertThat(cut.createVagina(), equalTo(true));
			
			assertThat(cut.cuntChangeNoDisplay(CUNT_CHANGE_VALUE), equalTo(true)); 
        }
		
		[Test] 
        public function testCuntChangeNoDisplayLooseVaginaNotStretched():void {
			assertThat(cut.createVagina(true,1,4), equalTo(true));
			
			assertThat(cut.cuntChangeNoDisplay(CUNT_CHANGE_VALUE), equalTo(false)); 
        }
		
		[Test] 
        public function testCuntChangeNoDisplayLoseVirginity():void {
			assertThat(cut.createVagina(), equalTo(true));
			
			cut.cuntChangeNoDisplay(CUNT_CHANGE_VALUE);
			
			assertThat(cut.hasVirginVagina(), equalTo(false));
        }
		
		[Test] 
        public function testCuntChangeNoDisplayWithNoVagina():void {
			assertThat(cut.cuntChangeNoDisplay(CUNT_CHANGE_VALUE), equalTo(false));
        }
		
		[Test] 
        public function testAverageVaginalLoosenessNoVagina():void {
			assertThat(cut.averageVaginalLooseness(), equalTo(2));
        }
		
		[Test] 
        public function testAverageVaginalLooseness():void {
			cut.createVagina(false, 1, 2);
			cut.createVagina(false, 1, 4);
			
			assertThat(cut.averageVaginalLooseness(), equalTo(3));
        }
		
		[Test] 
        public function testAverageVaginalWetnessNoVagina():void {
			assertThat(cut.averageVaginalWetness(), equalTo(2));
        }
		
		[Test] 
        public function testAverageVaginalWetness():void {
			cut.createVagina(false, 2, 1);
			cut.createVagina(false, 4, 1);
			
			assertThat(cut.averageVaginalWetness(), equalTo(3));
        }
		
		[Test] 
        public function testAllVaginaDescriptOnlyOneVagina():void {
			cut.createVagina();
			
			assertThat(cut.allVaginaDescript(), not(endsWith("s")));
        }
		
		[Test] 
        public function testAllVaginaDescriptOnlyMultipleVaginas():void {
			createMaxVaginas();
			
			assertThat(cut.allVaginaDescript(), endsWith("s"));
        }
		
		[Test] 
        public function testClitLengthNoVagina():void {
			assertThat(cut.hasVagina(), equalTo(false)); //guard assert
			
			assertThat(cut.clitLength, equalTo(DEFAULT_CLIT_LENGTH));
        }
		
		[Test] 
        public function testClitLengthWithVagina():void {
			assertThat(cut.createVagina(), equalTo(true));
			
			assertThat(cut.clitLength, equalTo(DEFAULT_CLIT_LENGTH));
        }
		
		[Test] 
        public function testClitLengthUpdateNoVagina():void {
			assertThat(cut.hasVagina(), equalTo(false)); //guard assert
			
			cut.clitLength = TEST_CLIT_LENGTH;

			assertThat(cut.clitLength, equalTo(TEST_CLIT_LENGTH));
        }
		
		[Test] 
        public function testClitLengthUpdateWithVagina():void {
			assertThat(cut.createVagina(), equalTo(true));
			
			cut.clitLength = TEST_CLIT_LENGTH;

			assertThat(cut.clitLength, equalTo(TEST_CLIT_LENGTH));
        }
		
				
		[Test] 
        public function testClitLengthIncrementNoVagina():void {
			assertThat(cut.hasVagina(), equalTo(false)); //guard assert
			
			cut.clitLength = TEST_CLIT_LENGTH;
			cut.clitLength++;

			assertThat(cut.clitLength, equalTo(TEST_CLIT_LENGTH + 1));
        }
		
		[Test] 
        public function testClitLengthIncrementWithVagina():void {
			assertThat(cut.createVagina(), equalTo(true));
			
			cut.clitLength = TEST_CLIT_LENGTH;
			cut.clitLength++;

			assertThat(cut.clitLength, equalTo(TEST_CLIT_LENGTH + 1));
        }
		
		[Test] 
        public function testClitLengthAdditionAssignmentNoVagina():void {
			assertThat(cut.hasVagina(), equalTo(false)); //guard assert
			
			cut.clitLength = TEST_CLIT_LENGTH;
			cut.clitLength += 1;

			assertThat(cut.clitLength, equalTo(TEST_CLIT_LENGTH + 1));
        }
		
		[Test] 
        public function testClitLengthAdditionAssignmentWithVagina():void {
			assertThat(cut.createVagina(), equalTo(true));
			
			cut.clitLength = TEST_CLIT_LENGTH;
			cut.clitLength += 1;

			assertThat(cut.clitLength, equalTo(TEST_CLIT_LENGTH + 1));
        }
		
		[Test] 
        public function testClitLengthDivisionAssignmentNoVagina():void {
			assertThat(cut.hasVagina(), equalTo(false)); //guard assert
			
			cut.clitLength = TEST_CLIT_LENGTH;
			cut.clitLength /= TEST_CLIT_LENGTH;

			assertThat(cut.clitLength, equalTo(1));
        }
		
		[Test] 
        public function testClitLengthDivisionAssignmentWithVagina():void {
			assertThat(cut.createVagina(), equalTo(true));
			
			cut.clitLength = TEST_CLIT_LENGTH;
			cut.clitLength /= TEST_CLIT_LENGTH;

			assertThat(cut.clitLength, equalTo(1));
        }
    }
}