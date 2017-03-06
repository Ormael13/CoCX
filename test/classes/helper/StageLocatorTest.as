package classes.helper {
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	import flash.display.Stage;
	
	import classes.helper.StageLocator;
	
    public class StageLocatorTest {	 
		
        [Test] 
        public function stageSet():void {
            assertThat(StageLocator.stage, not(nullValue()));
        }
    }
}