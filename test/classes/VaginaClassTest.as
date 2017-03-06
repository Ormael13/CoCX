package classes{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	
	import classes.VaginaClass;
	
    public class VaginaClassTest {
        private var cut:VaginaClass;
		
        [Before]
        public function runBeforeEveryTest():void {
			cut = new VaginaClass();
        }  
     
        [Test(description="Default clit length const is not used so that changes to the default value will cause this test to fail")] 
        public function testVaginaClassDefaultValueForClitLength():void {
			assertThat(cut.clitLength, equalTo(0.5));
        }
		
		[Test] 
        public function testValidateClitLengthNegative():void {
			cut = new VaginaClass(1, 0, true, -1);
			
			assertThat(cut.validate(), containsString("clitLength"));
        }
		
		[Test] 
        public function testValidateClitLengthPositive():void {
			cut = new VaginaClass(1, 0, true, 2);
			
			assertThat(cut.validate(), not(containsString("clitLength")));
        }
		
		[Test] 
        public function testValidateRecoveryProgressNegative():void {
			cut.recoveryProgress = -1;
			
			assertThat(cut.validate(), containsString("recoveryProgress"));
        }
		
		[Test] 
        public function testValidateRecoveryProgressNotNegative():void {
			cut = new VaginaClass();
			
			assertThat(cut.validate(), not(containsString("recoveryProgress")));
        }
		
		[Test] 
        public function testWetnessFactorZero():void {
			cut.vaginalWetness = 0;
			
			assertThat(cut.wetnessFactor(), equalTo(1));
        }
		
		[Test] 
        public function testWetnessFactorFive():void {
			cut.vaginalWetness = 5;
			
			assertThat(cut.wetnessFactor(), equalTo(1.5));
        }
		
		[Test] 
        public function testResetRecoveryProgress():void {
			cut.recoveryProgress = 1;
			
			cut.resetRecoveryProgress();
			
			assertThat(cut.recoveryProgress, equalTo(0));
        }
    }
}