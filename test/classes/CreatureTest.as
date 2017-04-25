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
	import classes.PerkLib;
     
    public class CreatureTest {
		include "../../includes/appearanceDefs.as";
		
		private const MAX_SUPPORTED_VAGINAS:Number = 2;
		private const DEFAULT_CLIT_LENGTH:Number = 0.5;
		private const TEST_CLIT_LENGTH:Number = 3;
		private const CUNT_CHANGE_VALUE:Number = 5;
		private const VAGINAL_LOOSENESS_VALUE:Number = VAGINA_LOOSENESS_LOOSE;
		private const VAGINAL_CAPCITY_OFFSET:Number = 2;
		private const VAGINAL_CAPCITY_TEST_DELTA:Number = 2;
		private const RECOVERY_COUNT:Number = 5;
		
        private var cut:Creature;
		private var noVagina:Creature;
		private var oneVagina:Creature;
		private var maxVagina:Creature;
		
		private function createVaginas(numberOfVaginas:Number, instance:Creature):void {
			var i:Number;
			
			for(i=0; i<numberOfVaginas; i++) {
				instance.createVagina();
			}
		}
		
		private function createMaxVaginas(instance:Creature):void {
			createVaginas(MAX_SUPPORTED_VAGINAS, instance);
		}
		
		private function createPerk(perk:PerkType, instance:Creature): void {
			instance.createPerk(perk, 1, 1, 1, 1);
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
			noVagina = new Creature();
			
			oneVagina = new Creature();
			oneVagina.createVagina();
			oneVagina.vaginas[0].recoveryProgress = RECOVERY_COUNT;
			
			maxVagina = new Creature();
			createMaxVaginas(maxVagina);

			for each (var vag:VaginaClass in maxVagina.vaginas){
				vag.recoveryProgress = RECOVERY_COUNT;		
			}
			
			// verify created test instances
			assertThat(noVagina.hasVagina(), equalTo(false));
			
			assertThat(oneVagina.hasVagina(), equalTo(true));
			assertThat(oneVagina.vaginas, arrayWithSize(1));
			
			assertThat(maxVagina.hasVagina(),equalTo(true));
			assertThat(maxVagina.vaginas, arrayWithSize(MAX_SUPPORTED_VAGINAS));
        }  
		
		[Test] 
        public function testValidation():void {
            assertThat(noVagina.validate(), equalTo("Empty 'weaponName'. Empty 'weaponVerb'. Empty 'armorName'. "));  
        }
        	
		[Test] 
        public function testWetnessWithNoVagina():void {
			assertThat(noVagina.wetness(), equalTo(0));
        }
		
		[Test] 
        public function testWetnessWithVagina():void {
			assertThat(oneVagina.wetness(), equalTo(1));
        }
		
		[Test] 
        public function testVaginaTypeWithNoVagina():void {
			assertThat(noVagina.vaginaType(), equalTo(-1));
        }
		
		[Test] 
        public function testVaginaTypeWithVagina():void {
			assertThat(oneVagina.vaginaType(), equalTo(VAGINA_TYPE_HUMAN));
        }
		
		[Test] 
        public function testSetVaginaTypeWithNoVagina():void {
			assertThat(noVagina.vaginaType(VAGINA_TYPE_EQUINE), equalTo(-1));
        }
		
		[Test] 
        public function testSetVaginaTypeWithVagina():void {
			assertThat(oneVagina.vaginaType(VAGINA_TYPE_EQUINE), equalTo(VAGINA_TYPE_EQUINE));
        }
		
		[Test] 
        public function testReadVaginaTypeAfterSet():void {
			oneVagina.vaginaType(VAGINA_TYPE_EQUINE);
			
			assertThat(oneVagina.vaginaType(), equalTo(VAGINA_TYPE_EQUINE));
        }
		
		[Test] 
        public function testLoosenessVaginaWithNoVagina():void {
			assertThat(noVagina.looseness(), equalTo(0));
        }
		
		[Test] 
        public function testLoosenessVaginaWithVagina():void {
			assertThat(oneVagina.looseness(), equalTo(0));
        }
		
		[Test] 
        public function testLoosenessAnus():void {
			assertThat(noVagina.looseness(false), equalTo(0));
        }
		
		[Test] 
        public function testVaginalCapacityNoVagina():void {
			assertThat(noVagina.vaginalCapacity(), equalTo(0));
        }
		
		[Test] 
        public function testVaginalCapacityWithVagina():void {
			assertThat(oneVagina.vaginalCapacity(), equalTo(0));
        }
		
		[Test]
		public function testVaginalCapacityTaurBodyBonus():void {
			oneVagina.legCount = 4;
			assertThat(oneVagina.isTaur(), equalTo(true)); //guard assert
			
			assertThat(oneVagina.vaginalCapacity(), closeTo(55, 0.001));
		}
		
		[Test]
		public function testVaginalCapacityNagaBodyBonus():void {
			oneVagina.lowerBody = LOWER_BODY_TYPE_NAGA;
			assertThat(oneVagina.isNaga(), equalTo(true)); //guard assert
			
			assertThat(oneVagina.vaginalCapacity(), equalTo(22));
		}
		
		[Test]
		public function testVaginalCapacityWetPussyPerkBonus():void {
			oneVagina.createPerk(PerkLib.WetPussy, 1, 1, 1, 1);
			
			assertThat(oneVagina.vaginalCapacity(), equalTo(22));
		}
		
		[Test]
		public function testVaginalCapacityHistorySlutPerkBonus():void {
			oneVagina.createPerk(PerkLib.HistorySlut, 1, 1, 1, 1);
			
			assertThat(oneVagina.vaginalCapacity(), equalTo(22));
		}
		
		[Test]
		public function testVaginalCapacityOneTrackMindPerkBonus():void {
			oneVagina.createPerk(PerkLib.OneTrackMind, 1, 1, 1, 1);
			
			assertThat(oneVagina.vaginalCapacity(), closeTo(10 + VAGINAL_CAPCITY_OFFSET, VAGINAL_CAPCITY_TEST_DELTA));
		}
		
		
		[Test]
		public function testVaginalCapacityCornucopiaPerkBonus():void {
			oneVagina.createPerk(PerkLib.Cornucopia, 1, 1, 1, 1);
			
			assertThat(oneVagina.vaginalCapacity(), closeTo(30 + VAGINAL_CAPCITY_OFFSET, VAGINAL_CAPCITY_TEST_DELTA));
		}
		
		[Test]
		public function testVaginalCapacityFerasBoonWideOpenPerkBonus():void {
			oneVagina.createPerk(PerkLib.FerasBoonWideOpen, 1, 1, 1, 1);
			
			assertThat(oneVagina.vaginalCapacity(), closeTo(25 + VAGINAL_CAPCITY_OFFSET, VAGINAL_CAPCITY_TEST_DELTA));
		}
		
		[Test]
		public function testVaginalCapacityFerasBoonMilkingTwatPerkBonus():void {
			oneVagina.createPerk(PerkLib.FerasBoonMilkingTwat, 1, 1, 1, 1);
			
			assertThat(oneVagina.vaginalCapacity(), closeTo(40 + VAGINAL_CAPCITY_OFFSET, VAGINAL_CAPCITY_TEST_DELTA));
		}
		
		[Test]
		public function testVaginalCapacityBonusVCapacityStatusEffect():void {
			noVagina.createVagina(true, 1, 4);
			noVagina.createStatusEffect(StatusEffects.BonusVCapacity, 1, 1, 1, 1);
			
			assertThat(noVagina.vaginalCapacity(), equalTo(141.9));
		}
		
		[Test]
		public function testVaginalCapacityBasedOnLooseness():void {
			noVagina.createVagina(true, 0, 4);
			
			assertThat(noVagina.vaginalCapacity(), equalTo(128));
		}
		
		[Test]
		public function testVaginalCapacityBasedOnWetness():void {
			noVagina.createVagina(true, 4, 1);
			
			assertThat(noVagina.vaginalCapacity(), equalTo(11.2));
		}
		
		[Test] 
        public function testVaginalCapacityWithVaginaAfterStrech():void {
			oneVagina.cuntChangeNoDisplay(CUNT_CHANGE_VALUE)
			
			assertThat(oneVagina.vaginalCapacity(), equalTo(8.8));
        }
		
		[Test] 
        public function testHasVaginaWithNoVagina():void {
            assertThat(noVagina.hasVagina(), equalTo(false));  
        }
		
		[Test] 
        public function testHasVaginaWithVagina():void {
            assertThat(oneVagina.hasVagina(), equalTo(true));  
        }
		
		[Test] 
        public function testHasVirginVaginaWithNoVagina():void {
            assertThat(noVagina.hasVirginVagina(), equalTo(false));  
        }
		
		[Test] 
        public function testHasVirginVaginaWithVirginVagina():void {
            assertThat(oneVagina.hasVirginVagina(), equalTo(true));  
        }
		
		[Test] 
        public function testHasVirginVaginaWithNonVirginVagina():void {
			assertThat(noVagina.createVagina(false), equalTo(true));
			
            assertThat(noVagina.hasVirginVagina(), equalTo(false));  
        }
		
		[Test] 
        public function testCreateVaginaVirgin():void {
			assertThat(noVagina.createVagina(), equalTo(true));
			
            assertThat(noVagina.hasVirginVagina(), equalTo(true));  
        }
		
		[Test] 
        public function testCreateVaginaNonVirgin():void {
			assertThat(noVagina.createVagina(false), equalTo(true));
			
            assertThat(noVagina.hasVirginVagina(), equalTo(false));  
        }
		
		[Test] 
        public function testCreateVaginaWetness():void {
			assertThat(noVagina.createVagina(true, 3), equalTo(true));
			
            assertThat(noVagina.wetness(), equalTo(3));  
        }
		
		[Test] 
        public function testCreateVaginaLooseness():void {
			assertThat(noVagina.createVagina(true, 1, 3), equalTo(true));
			
            assertThat(noVagina.looseness(), equalTo(3));  
        }
		
		[Test] 
        public function testCreateVaginaMaxVaginas():void {
			assertThat(maxVagina.createVagina(), equalTo(false));
        }
		
		[Test] 
        public function testCreateVaginaMaxVaginasArraySize():void {
			maxVagina.createVagina();
			
			assertThat(maxVagina.vaginas, arrayWithSize(MAX_SUPPORTED_VAGINAS));
        }

		[Test] 
        public function testRemoveVaginaNegativeIndex():void {
			maxVagina.removeVagina(-2);
			
			assertThat(maxVagina.vaginas, arrayWithSize(MAX_SUPPORTED_VAGINAS));
        }
		
		[Test] 
        public function testRemoveVaginaNegativeRemoveCount():void {
			maxVagina.removeVagina(0, -1);
			
			assertThat(maxVagina.vaginas, arrayWithSize(MAX_SUPPORTED_VAGINAS));
        }
		
		[Test] 
        public function testRemoveVaginaIndexToLarge():void {
			maxVagina.removeVagina(MAX_SUPPORTED_VAGINAS + 1);
			
			assertThat(maxVagina.vaginas, arrayWithSize(MAX_SUPPORTED_VAGINAS));
        }
		
		[Test] 
        public function testRemoveVaginaSpecificIndexFirst():void {
			assertThat(noVagina.createVagina(true, 1, 2), equalTo(true));
			assertThat(noVagina.createVagina(true, 1, 3), equalTo(true));
			
			noVagina.removeVagina(0);
			
			assertThat(noVagina.looseness(), equalTo(3));
        }
		
		[Test] 
        public function testRemoveVaginaRemoveLastWithMinusOne():void {
			assertThat(noVagina.createVagina(true, 1, 2), equalTo(true));
			assertThat(noVagina.createVagina(true, 1, 3), equalTo(true));
			
			noVagina.removeVagina(-1);
			
			assertThat(noVagina.looseness(), equalTo(2));
			assertThat(noVagina.vaginas, arrayWithSize(1));
        }
		
		[Test] 
        public function testRemoveVaginaSpecificIndexLast():void {
			assertThat(noVagina.createVagina(true, 1, 2), equalTo(true));
			assertThat(noVagina.createVagina(true, 1, 3), equalTo(true));
			
			noVagina.removeVagina(1);
			
			assertThat(noVagina.looseness(), equalTo(2));
			assertThat(noVagina.vaginas, arrayWithSize(1));
        }
		
		[Test] 
        public function testCuntChangeNoDisplayLoosnessChanged():void {
			assertThat(oneVagina.looseness(), equalTo(0)); // guard assert
			
			oneVagina.cuntChangeNoDisplay(CUNT_CHANGE_VALUE);
			
			assertThat(oneVagina.looseness(), equalTo(1));
        }
		
		[Test] 
        public function testCuntChangeNoDisplayIsStretched():void {
			assertThat(oneVagina.cuntChangeNoDisplay(CUNT_CHANGE_VALUE), equalTo(true)); 
        }
		
		[Test] 
        public function testCuntChangeNoDisplayWithFeraMilkingTwatAndAboveNormalLooseness():void {
			oneVagina.vaginas[0].vaginalLooseness = VAGINAL_LOOSENESS_VALUE;
			oneVagina.createPerk(PerkLib.FerasBoonMilkingTwat, 1, 1, 1, 1);
			
			assertThat(oneVagina.cuntChangeNoDisplay(Number.MAX_VALUE), equalTo(false));
        }
			
		[Test] 
        public function testCuntChangeNoDisplayWithNoFeraMilkingTwatAndAboveNormalLooseness():void {
			oneVagina.vaginas[0].vaginalLooseness = VAGINAL_LOOSENESS_VALUE;
			
			assertThat(oneVagina.cuntChangeNoDisplay(Number.MAX_VALUE), equalTo(true));
        }
		
		[Test] 
        public function testCuntChangeNoDisplayWithFeraMilkingTwatAndNormalLooseness():void {
			oneVagina.createPerk(PerkLib.FerasBoonMilkingTwat, 1, 1, 1, 1);
			
			assertThat(oneVagina.cuntChangeNoDisplay(Number.MAX_VALUE), equalTo(true));
        }
		
		[Test] 
        public function testCuntChangeNoDisplayWithNoFeraMilkingTwatAndNormalLooseness():void {
			assertThat(oneVagina.cuntChangeNoDisplay(Number.MAX_VALUE), equalTo(true));
        }
				
		[Test] 
        public function testFeraMilkingTwatPerkCheck():void {
			oneVagina.createPerk(PerkLib.FerasBoonMilkingTwat, 1, 1, 1, 1);
			
			assertThat(oneVagina.findPerk(PerkLib.FerasBoonMilkingTwat), equalTo(0));
        }
		
		[Test] 
        public function testCuntChangeNoDisplayLooseVaginaNotStretched():void {
			assertThat(noVagina.createVagina(true,1,4), equalTo(true));
			
			assertThat(noVagina.cuntChangeNoDisplay(CUNT_CHANGE_VALUE), equalTo(false)); 
        }
		
		[Test] 
        public function testCuntChangeNoDisplayLoseVirginity():void {
			oneVagina.cuntChangeNoDisplay(CUNT_CHANGE_VALUE);
			
			assertThat(oneVagina.hasVirginVagina(), equalTo(false));
        }
		
		[Test] 
        public function testCuntChangeNoDisplayWithNoVagina():void {
			assertThat(noVagina.cuntChangeNoDisplay(CUNT_CHANGE_VALUE), equalTo(false));
        }
		
		[Test] 
        public function testCuntChangeNoDisplayCuntStretchedRecoveryProgress():void {
			oneVagina.cuntChangeNoDisplay(Number.MAX_VALUE);
			
			assertThat(oneVagina.vaginas[0].recoveryProgress, equalTo(0));
        }
		
		[Test] 

        public function testCuntChangeNoDisplayNoRecoveryProgressIncrease():void {
			oneVagina.cuntChangeNoDisplay(0);
			
			assertThat(oneVagina.vaginas[0].recoveryProgress, equalTo(RECOVERY_COUNT));
        }
		
		[Test] 
        public function testAverageVaginalLoosenessNoVagina():void {
			assertThat(noVagina.averageVaginalLooseness(), equalTo(2));
        }
		
		[Test] 
        public function testAverageVaginalLooseness():void {
			noVagina.createVagina(false, 1, 2);
			noVagina.createVagina(false, 1, 4);
			
			assertThat(noVagina.averageVaginalLooseness(), equalTo(3));
        }
		
		[Test] 
        public function testAverageVaginalWetnessNoVagina():void {
			assertThat(noVagina.averageVaginalWetness(), equalTo(2));
        }
		
		[Test] 
        public function testAverageVaginalWetness():void {
			noVagina.createVagina(false, 2, 1);
			noVagina.createVagina(false, 4, 1);
			
			assertThat(noVagina.averageVaginalWetness(), equalTo(3));
        }
		
		[Test] 
        public function testAllVaginaDescriptOnlyOneVagina():void {
			assertThat(oneVagina.allVaginaDescript(), not(endsWith("s")));
        }
		
		[Test] 
        public function testAllVaginaDescriptOnlyMultipleVaginas():void {
			assertThat(maxVagina.allVaginaDescript(), endsWith("s"));
        }
		
		[Test(expected="flash.errors.IllegalOperationError")] 
        public function setClitLength_noVagina():void {
			noVagina.setClitLength(TEST_CLIT_LENGTH);
        }
		
		[Test(expected="flash.errors.IllegalOperationError")] 
        public function getClitLength_noVagina():void {
			noVagina.getClitLength(TEST_CLIT_LENGTH);
        }
		
		[Test] 
        public function setClitLength_oneVagina():void {
			oneVagina.setClitLength(TEST_CLIT_LENGTH);
			
			assertThat(oneVagina.getClitLength(), equalTo(TEST_CLIT_LENGTH));
        }
		
		[Test] 
        public function getClitLength_oneVagina():void {
			assertThat(oneVagina.getClitLength(), equalTo(VaginaClass.DEFAULT_CLIT_LENGTH));
        }
		
		[Test] 
        public function setClitLength_multiVagina():void {
			maxVagina.setClitLength(TEST_CLIT_LENGTH, 1);
			
			assertThat(maxVagina.getClitLength(1), equalTo(TEST_CLIT_LENGTH));
        }
		
		[Test] 
        public function getClitLength_multiVagina():void {
			assertThat(maxVagina.getClitLength(1), equalTo(VaginaClass.DEFAULT_CLIT_LENGTH));
        }
		
				
		[Test(expected="flash.errors.IllegalOperationError")] 
        public function changeClitLength_noVagina():void {
			noVagina.changeClitLength(1);
		}
		
		[Test] 
        public function changeClitLength_increase():void {
			assertThat(oneVagina.changeClitLength(1), equalTo(VaginaClass.DEFAULT_CLIT_LENGTH + 1));
        }
		
		[Test] 
        public function changeClitLength_decrease():void {
			assertThat(oneVagina.changeClitLength(-0.2), equalTo(VaginaClass.DEFAULT_CLIT_LENGTH - 0.2));
        }
		
		[Test] 
        public function changeClitLength_noNegativeValues():void {
			assertThat(oneVagina.changeClitLength(-Number.MAX_VALUE), equalTo(0));
        }
		
		[Test(expected="RangeError")] 
        public function changeClitLength_invalid_vagina_index():void {
			oneVagina.changeClitLength(1, int.MAX_VALUE);
        }
		
		[Test]
		public function noGender():void {
			assertThat(noVagina.gender, equalTo(GENDER_NONE));
		}
		
		[Test]
		public function genderIsFemale():void {
			assertThat(oneVagina.gender, equalTo(GENDER_FEMALE));
		}
		
		[Test]
		public function genderIsMale():void {
			noVagina.createCock(5, 1, CockTypesEnum.HUMAN);
			
			assertThat(noVagina.gender, equalTo(GENDER_MALE));
		}
		
		[Test]
		public function genderIsHerm():void {
			noVagina.createCock(5, 1, CockTypesEnum.HUMAN);
			noVagina.createVagina();
			
			assertThat(noVagina.gender, equalTo(GENDER_HERM));
		}
    }
}
