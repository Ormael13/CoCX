package classes.helper 
{
	import flash.errors.IllegalOperationError;
	import mx.logging.ILogger;
	import mx.logging.LogEventLevel;
	import mx.logging.AbstractTarget;
	import mx.logging.LogEvent;
	
	/**
	 * Log target for collecting log messages in memory.
	 */
	public class MemoryLogTarget extends AbstractTarget
	{
		public static const PREFIX_DEBUG:String = "DEBUG:";
		public static const PREFIX_ERROR:String = "ERROR:";
		public static const PREFIX_FATAL:String = "FATAL:";
		public static const PREFIX_INFO:String = "INFO:";
		public static const PREFIX_WARNING:String = "WARN:";
		
		private var _collectedMessages:Vector.<String>;
		
		public function get collectedMessages():Vector.<String> {
			return _collectedMessages;
		}

		/**
		 * Create a new logging target with an empty internal vector to store
		 * messages.
		 */
		public function MemoryLogTarget() 
		{
			_collectedMessages = new Vector.<String>();
			super();
		}
		
		/**
		 * Handle a log event.
		 * @param	event to handle
		 */
		public override function logEvent(event:LogEvent):void {
			log(event.level, event.message);
		}
		
		/**
		 * Store the given event with a prefix
		 * @param	level of the log event
		 * @param	message of the log event
		 */
		private function log(level:int, message:String):void {
			switch (level) {
				case LogEventLevel.DEBUG:
					_collectedMessages.push(PREFIX_DEBUG + message);
					break;
					
				case LogEventLevel.INFO:
					_collectedMessages.push(PREFIX_INFO + message);
					break;
				
				case LogEventLevel.FATAL:
					_collectedMessages.push(PREFIX_FATAL + message);
					break;
					
				case LogEventLevel.ERROR:
					_collectedMessages.push(PREFIX_ERROR + message);
					break;
					
				case LogEventLevel.WARN:
					_collectedMessages.push(PREFIX_WARNING + message);
					break;
			}
		}
	}
}
