package classes.helper 
{
	import classes.helper.MemoryLogTarget;
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class MemoryLogTargetTest 
	{
		private static const TEST_MESSAGE:String = "this is a test";
		
		private var cut:MemoryLogTarget;
		private var logger:ILogger;
		
		public function MemoryLogTargetTest() 
		{
		}
		
		[Before]
		public function setUp():void {
			cut = new MemoryLogTarget();
			Log.addTarget(cut);
			logger = Log.getLogger("test");
		}
		
		[After]
		public function tearDown():void {
			Log.removeTarget(cut);
		}
		
		private function expectedMessage(prefix:String):String {
			return prefix + TEST_MESSAGE;
		}
		
		[Test]
		public function debugLevelMessage():void {
			logger.debug(TEST_MESSAGE);
			
			assertThat(cut.collectedMessages, hasItem(equalTo(expectedMessage(MemoryLogTarget.PREFIX_DEBUG))));
		}
		
		[Test]
		public function infoLevelMessage():void {
			logger.info(TEST_MESSAGE);
			
			assertThat(cut.collectedMessages, hasItem(equalTo(expectedMessage(MemoryLogTarget.PREFIX_INFO))));
		}
				
		[Test]
		public function warningLevelMessage():void {
			logger.warn(TEST_MESSAGE);
			
			assertThat(cut.collectedMessages, hasItem(equalTo(expectedMessage(MemoryLogTarget.PREFIX_WARNING))));
		}
		
		[Test]
		public function errorLevelMessage():void {
			logger.error(TEST_MESSAGE);
			
			assertThat(cut.collectedMessages, hasItem(equalTo(expectedMessage(MemoryLogTarget.PREFIX_ERROR))));
		}
		
		[Test]
		public function fatalLevelMessage():void {
			logger.fatal(TEST_MESSAGE);
			
			assertThat(cut.collectedMessages, hasItem(equalTo(expectedMessage(MemoryLogTarget.PREFIX_FATAL))));
		}
		
		[Test]
		public function multipleMessages():void {
			logger.info(TEST_MESSAGE);
			logger.warn(TEST_MESSAGE);
			
			assertThat(cut.collectedMessages, arrayWithSize(2));
		}
	}
}
