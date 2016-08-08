package classes 
{
	/**
	 * ...
	 * @author Stadler76
	 */
	public class Output extends BaseContent
	{
		import flash.text.TextFormat;
		import classes.GlobalFlags.kGAMECLASS;
		import classes.GlobalFlags.kFLAGS;
		import coc.view.MainView;

		public function Output() {}

		protected var _currentText:String = "";
		public function get currentText():String { return _currentText; }
		public function set currentText(value:String):void { _currentText = value; }

		public function get mainViewManager():MainViewManager { return kGAMECLASS.mainViewManager; }
		public function forceUpdate():void { kGAMECLASS.forceUpdate();  }

		private function _addText(text:String, parseAsMarkdown:Boolean = false):Output
		{
			// we have to purge the output text BEFORE calling parseText, because if there are scene commands in 
			// the parsed text, parseText() will write directly to the output


			// This is cleaup in case someone hits the Data or new-game button when the event-test window is shown. 
			// It's needed since those buttons are available even when in the event-tester
			mainView.hideTestInputPanel();

			text = kGAMECLASS.parser.recursiveParser(text, parseAsMarkdown);

			_currentText += text;

			if (debug) 
			{
				mainView.setOutputText(_currentText);
			}

			return this;
		}

		public function text(text:String):Output
		{
			return _addText(text);
		}

		public function markdown(text:String):Output
		{
			return _addText(text, true);
		}

		public function flush():void
		{
			var fmt:TextFormat = mainView.mainText.getTextFormat();

			if (flags[kFLAGS.CUSTOM_FONT_SIZE] != 0) fmt.size = flags[kFLAGS.CUSTOM_FONT_SIZE];

			mainView.setOutputText(_currentText);

			if (flags[kFLAGS.CUSTOM_FONT_SIZE] != 0)
			{
				mainView.mainText.setTextFormat(fmt);
			}
			if (mainViewManager.mainColorArray[flags[kFLAGS.BACKGROUND_STYLE]] != null) mainView.mainText.textColor = mainViewManager.mainColorArray[flags[kFLAGS.BACKGROUND_STYLE]];
		}

		public function header(string:String):Output
		{
			outputText("<font size=\"36\" face=\"Georgia\"><u>" + string + "</u></font>\n");
			return this;
		}

		public function clear():Output
		{
			forceUpdate();
			_currentText = "";
			mainView.clearOutputText();
			if (kGAMECLASS.gameState != 3) mainView.hideMenuButton( MainView.MENU_DATA );
			mainView.hideMenuButton( MainView.MENU_APPEARANCE );
			mainView.hideMenuButton( MainView.MENU_LEVEL );
			mainView.hideMenuButton( MainView.MENU_PERKS );
			mainView.hideMenuButton( MainView.MENU_STATS );
			return this;
		}

		public function raw(output:String, purgeText:Boolean = false):Output
		{
			//OUTPUT!
			if (purgeText) {
				//if (!debug) mainText.htmlText = output;
				//trace("Purging and writing Text", output);
				clearOutput();
				_currentText = output;
				mainView.setOutputText( output );
				// mainText.htmlText = output;
			}
			else
			{
				//trace("Adding Text");
				_currentText += output;
				mainView.appendOutputText( output );
				// mainText.htmlText += output;
			}
			// trace(getCurrentStackTrace())
			// scrollBar.update();

			return this;
		}

	}
}
