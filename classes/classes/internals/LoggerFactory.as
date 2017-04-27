package classes.internals 
{
	import flash.errors.IllegalOperationError;
	import flash.utils.getQualifiedClassName;
	import mx.logging.Log;
	import mx.logging.ILogger;
	
	/**
	 * Factory to create loggers for classes.
	 */
	public class LoggerFactory 
	{
		/**
		 * Symbols that cannot be used in a category name
		 */
		public static const ILLEGAL_SYMBOLS:String = "[]~$^&\/(){}<>+=`!#%?,:;'\"@";
		
		private static const PACKAGE_DELIMITER:RegExp = /::/g;
		private static const PACKAGE_DELIMITER_REPLACEMENT:String = ".";
		
		public function LoggerFactory() 
		{
			throw new IllegalOperationError("This class cannot be instantiated.");
		}
		
		/**
		 * Create a logger for the given class. Loggers are cached by mx.logging.Log, so using the same Class
		 * multiple times will return the same logger instance.
		 * @param	clazz to create a logger for
		 * @return a new logger for the class
		 */
		public static function getLogger(clazz:Class):ILogger {
			var sanitizedFQN:String = getQualifiedClassName(clazz).replace(PACKAGE_DELIMITER, PACKAGE_DELIMITER_REPLACEMENT);
			return Log.getLogger(sanitizedFQN);
		}
	}
}
