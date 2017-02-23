package classes{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	import classes.Creature;
     
    public class CreatureTest {
        private var cut:Creature;   
         
        [Before]
        public function runBeforeEveryTest():void {  
			cut = new Creature();
        }  
         
        [After] 
        public function runAfterEveryTest():void {  
           
        }
         
        [Test] 
        public function noVagina():void {
            assertThat(cut.hasVagina(), equalTo(false));  
        }
    }
}