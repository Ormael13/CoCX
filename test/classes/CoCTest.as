package classes{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	import flash.display.Stage;
	
	import classes.CoC;
	import classes.helper.StageLocator;
	
    public class CoCTest {
        private var cut:CoC;
		
        [Before]
        public function runBeforeEveryTest():void {
			assertThat(StageLocator.stage, not(nullValue()));
        }  
     
        [Test] 
        public function injectStageForTest():void {
            cut = new CoC(StageLocator.stage);
        }
		
		[Test(expected="TypeError")] 
        public function noInjectedStage():void {
            cut = new CoC();
        }
    }
}