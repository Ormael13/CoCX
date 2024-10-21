package classes.display
{
import coc.view.Block;
import coc.view.CoCButton;

import flash.text.TextField;

/**
	 * Defines a composite display object of all the separate components required to display a
	 * single BoundControlMethod, its associated primary and secondary bindings with the buttons
	 * used to bind methods to new keys.
	 * @author Gedan
	 */
	public class BindDisplay extends Block
	{
		// Object components and settings
		private var _nameLabel:TextField;
		private var _button1:CoCButton;
		private var _button2:CoCButton;
		
		/**
		 * Create a new composite object, initilizing the label to be used for display, as well as the two
		 * buttons used for user interface.
		 *
		 * @param	maxWidth	Defines the maximum available width that the control can consume for positining math
		 */
		public function BindDisplay(maxWidth:int)
		{
			layoutConfig = {
				type: Block.LAYOUT_GRID,
				cols: 3,
				setWidth: true
			};
			width = maxWidth;
			_nameLabel = addTextField({
				text:"THIS IS SOME KINDA CRAZY LABEL",
				defaultTextFormat: {
					font: 'Times New Roman',
					size: 20,
					align: 'right'
				}
			});
			addElement(_button1 = new CoCButton({
				labelText: 'Unbound'
			}));
			addElement(_button2 = new CoCButton({
				labelText: 'Unbound'
			}));
		}
		
		public function get text():String
		{
			return _nameLabel.text;
		}
		
		public function set text(value:String):void
		{
			_nameLabel.text = value;
		}
		
		public function get htmlText():String
		{
			return _nameLabel.htmlText;
		}
		
		public function set htmlText(value:String):void
		{
			_nameLabel.htmlText = value;
		}
		
		public function get button1Text():String
		{
			return _button1.labelText;
		}
		
		public function get button2Text():String
		{
			return _button2.labelText;
		}
		
		public function set button1Text(value:String):void
		{
			_button1.labelText = value;
		}
		
		public function set button2Text(value:String):void
		{
			_button2.labelText = value;
		}
		
		public function set button1Callback(callback:Function):void
		{
			_button1.callback = callback;
		}
		
		public function set button2Callback(callback:Function):void
		{
			_button2.callback = callback;
		}
	}

}
