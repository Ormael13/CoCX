package classes{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	import classes.Monster;
     
    public class MonsterTest {
        private var cut:Monster;
		
        [Before]
        public function setUp():void {  
			cut = new Monster();
        }  
		
		[Test] 
        public function testMonsterConstructor():void {
        	cut = new Monster();
		}
		
		[Test(description="Check that the array or vector for vaginas is correctly initialised")] 
        public function testVaginasStoreLengthIsZero():void {
        	assertThat(cut.vaginas.length, equalTo(0));
		}
		
		[Test(description="Check that the array or vector for vaginas is correctly initialised")] 
        public function testVaginasStoreIsNotNull():void {
        	assertThat(cut.vaginas, notNullValue());
		}
    }
}