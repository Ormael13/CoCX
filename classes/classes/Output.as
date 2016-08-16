package classes 
{
	/**
	 * Class to replace the old and somewhat outdated output-system, which mostly uses the include-file includes/engineCore.as
	 * @since  08.08.2016
	 * @author Stadler76
	 */
	public class Output extends BaseContent
	{
		import flash.text.TextFormat;
		import classes.GlobalFlags.kGAMECLASS;
		import classes.GlobalFlags.kFLAGS;
		import coc.view.MainView;

		private static var _instance:Output = new Output();

		public function Output()
		{
			if (_instance != null)
			{
				throw new Error("Output can only be accessed through Output.init()");
			}
		}

		public static function init():Output { return _instance; }

		protected var _currentText:String = "";
		public function get currentText():String { return _currentText; }
		public function set currentText(value:String):void { _currentText = value; }

		public function get mainViewManager():MainViewManager { return kGAMECLASS.mainViewManager; }
		public function forceUpdate():void { kGAMECLASS.forceUpdate(); }

		/**
		 * Passes the text through the parser and adds it to the output-buffer 
		 *
		 * In debug-mode the output is directly flushed to the GUI.
		 * If you want to clear the output before adding text, use clear(true) or just clear()
		 * The old second param `purgeText:Boolean = false` from outputText(...) is not supported anymore
		 * in favor of using clear() and will never return.
		 * 
		 * Unfortunately no one succeded to support markdown formatting for CoC, although this was attempted.
		 *
		 * This must not be made possible to be called directly from the outside, use wrapper-methods instead.
		 *
		 * @param   text              The text to be added
		 * @param   parseAsMarkdown   set this to true, if you want the text to be formatted, using a markdown parser (NYI, sry)
		 * @return  The instance of the class to support the 'Fluent interface' aka method-chaining
		 */
		protected function _addText(text:String, parseAsMarkdown:Boolean = false):Output
		{
			// This is cleaup in case someone hits the Data or new-game button when the event-test window is shown. 
			// It's needed since those buttons are available even when in the event-tester
			mainView.hideTestInputPanel();

			_currentText += kGAMECLASS.parser.recursiveParser(text, parseAsMarkdown);
			if (debug) mainView.setOutputText(_currentText);

			return this;
		}

		/**
		 * Add text to the output-buffer
		 *
		 * Actually this is a wrapper around _addText(text)
		 *
		 * @param   text    The text to be added
		 * @return  The instance of the class to support the 'Fluent interface' aka method-chaining
		 */
		public function text(text:String):Output
		{
			return _addText(text);
		}

		/**
		 * Add markdown formatted text (NYI!) to the output-buffer
		 *
		 * Actually this is a wrapper around _addText(text, true)
		 * Unfortunately no one succeded to support markdown formatting for CoC, so as of speaking, this does exactly the same, as text("...")
		 *
		 * @param   text    The text to be formatted with markdown (NYI!)
		 * @return  The instance of the class to support the 'Fluent interface' aka method-chaining
		 */
		public function markdown(text:String):Output
		{
			return _addText(text, true);
		}

		/**
		 * Flushes the buffered output to the GUI aka displaying it
		 *
		 * This doesn't clear the output buffer, so you can add more text after that and flush it again.
		 * flush() always ends a method chain, so you need to start a new one.
		 */
		public function flush():void
		{
			var fmt:TextFormat = mainView.mainText.getTextFormat();

			if (flags[kFLAGS.CUSTOM_FONT_SIZE] != 0)
				fmt.size = flags[kFLAGS.CUSTOM_FONT_SIZE];

			mainView.setOutputText(_currentText);

			if (flags[kFLAGS.CUSTOM_FONT_SIZE] != 0)
				mainView.mainText.setTextFormat(fmt);

			if (mainViewManager.mainColorArray[flags[kFLAGS.BACKGROUND_STYLE]] != null)
				mainView.mainText.textColor = mainViewManager.mainColorArray[flags[kFLAGS.BACKGROUND_STYLE]];
		}

		/**
		 * Adds a formatted headline to the output-buffer
		 *
		 * @param	headLine    The headline to be formatted and added
		 * @return  The instance of the class to support the 'Fluent interface' aka method-chaining
		 */
		public function header(headLine:String):Output
		{
			return text("<font size=\"36\" face=\"Georgia\"><u>" + headLine + "</u></font>\n");
		}

		/**
		 * Clears the output-buffer
		 *
		 * @param   hideMenuButtons   Set this to true to hide the menu-buttons (rarely used)
		 * @return  The instance of the class to support the 'Fluent interface' aka method-chaining
		 */
		public function clear(hideMenuButtons:Boolean = false):Output
		{
			if (hideMenuButtons) {
				forceUpdate();
				if (kGAMECLASS.gameState != 3) mainView.hideMenuButton(MainView.MENU_DATA);
				mainView.hideMenuButton(MainView.MENU_APPEARANCE);
				mainView.hideMenuButton(MainView.MENU_LEVEL);
				mainView.hideMenuButton(MainView.MENU_PERKS);
				mainView.hideMenuButton(MainView.MENU_STATS);
			}

			_currentText = "";
			mainView.clearOutputText();
			return this;
		}

		/**
		 * Adds raw text to the output without passing it through the parser
		 *
		 * If you want to clear the output before adding raw text, use clear(true) or just clear()
		 * The second param `purgeText:Boolean = false` is not supported anymore in favor of using clear() and will never return.
		 *
		 * @param   text    The text to be added to the output-buffer
		 * @return  The instance of the class to support the 'Fluent interface' aka method-chaining
		 */
		public function raw(text:String):Output
		{
			_currentText += text;
			mainView.setOutputText(_currentText);
			return this;
		}

	}
}
