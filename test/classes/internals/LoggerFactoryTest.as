package classes.internals 
{
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import classes.helper.MemoryLogTarget;
	import classes.helper.StageLocator;
	
	public class LoggerFactoryTest 
	{
		public function LoggerFactoryTest() 
		{
		}
		
		[Test]
		public function createLoggerForClass():void {
			var logger:ILogger = LoggerFactory.getLogger(StageLocator);
		}
		
		[Test]
		public function loggersAreCached():void {
			var logger:ILogger = LoggerFactory.getLogger(StageLocator);
			var logger2:ILogger = LoggerFactory.getLogger(StageLocator);
			
			assertThat(logger, strictlyEqualTo(logger2));
		}
	}
}
