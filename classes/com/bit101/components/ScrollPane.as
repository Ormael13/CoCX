/**
 * ScrollPane.as
 * Keith Peters
 * version 0.9.10
 * 
 * A panel with scroll bars for scrolling content that is larger.
 * 
 * Copyright (c) 2011 Keith Peters
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.bit101.components
{
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;

public class ScrollPane extends Panel
	{
		protected var _vScrollbar:VScrollBar;
		protected var _hScrollbar:HScrollBar;
		protected var _corner:Shape;
		protected var _dragContent:Boolean = true;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this ScrollPane.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
		public function ScrollPane(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		/**
		 * Initializes this component.
		 */
		override protected function init():void
		{
			super.init();
			addEventListener(Event.RESIZE, onResize);
			addEventListener(MouseEvent.MOUSE_WHEEL, MouseScrollEvent);
			_background.addEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown);
			_background.useHandCursor = true;
			_background.buttonMode = true;
			setSize(100, 100);
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			super.addChildren();
			_vScrollbar = new VScrollBar(null, width - 10, 0, onScroll);
			_hScrollbar = new HScrollBar(null, 0, height - 10, onScroll);
			addRawChild(_vScrollbar);
			addRawChild(_hScrollbar);
			_corner = new Shape();
			_corner.graphics.beginFill(Style.BUTTON_FACE);
			_corner.graphics.drawRect(0, 0, 10, 10);
			_corner.graphics.endFill();
			addRawChild(_corner);
			//hide the horizontal scrollbar by default
			_hScrollbar.autoHide = true;
		}
		
		

		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			
			var vPercent:Number = (_height - 10) / content.height;
			var hPercent:Number = (_width - 10) / content.width;
			
			_vScrollbar.x = width - 15;
			_hScrollbar.y = height - 10;
			
			if(hPercent >= 1)
			{
				_vScrollbar.height = height;
				_mask.height = height;
			}
			else
			{
				_vScrollbar.height = height - 10;
				_mask.height = height - 10;
			}
			if(vPercent >= 1)
			{
				_hScrollbar.width = width;
				_mask.width = width;
			}
			else
			{
				_hScrollbar.width = width - 10;
				_mask.width = width - 10;
			}
			_vScrollbar.setThumbPercent(vPercent);
			_vScrollbar.maximum = Math.max(0, content.height - _height + 10);
			_vScrollbar.pageSize = _height - 10;
			
			_hScrollbar.setThumbPercent(hPercent);
			_hScrollbar.maximum = Math.max(0, content.width - _width + 10);
			_hScrollbar.pageSize = _width - 10;
			
			_corner.x = width - 10;
			_corner.y = height - 10;
			_corner.visible = (hPercent < 1) && (vPercent < 1);
			content.x = -_hScrollbar.value;
			content.y = -_vScrollbar.value;
		}
		
		/**
		 * Updates the scrollbars when content is changed. Needs to be done manually.
		 */
		public function update():void
		{
			invalidate();
		}
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Called when either scroll bar is scrolled.
		 */
		protected function onScroll(event:Event):void
		{
			content.x = -_hScrollbar.value;
			content.y = -_vScrollbar.value;
		}
		
		protected function onResize(event:Event):void
		{
			invalidate();
		}
		
		protected var isMouseDown:Boolean = false;
		protected var isTouchDown:Boolean = false;
		protected function onMouseGoDown(event:MouseEvent):void
		{
			isMouseDown = true;
			setTimeout(function():void {
				if (!isMouseDown) return;
				content.startDrag(false, new Rectangle(0, 0, Math.min(0, _width - content.width - 10), Math.min(0, _height - content.height - 10)));
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			}, 100);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		
		protected function onTouchBegin(event:TouchEvent):void
		{
			isTouchDown = true;
			setTimeout(function():void {
				if (!isTouchDown) return;
				content.startTouchDrag(event.touchPointID, false, new Rectangle(0, 0, Math.min(0, _width - content.width - 10), Math.min(0, _height - content.height - 10)));
				stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			},100);
			stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		}

		protected function onMouseMove(event:MouseEvent):void
		{
			_hScrollbar.value = -content.x;
			_vScrollbar.value = -content.y;
		}
		protected function onTouchMove(event:TouchEvent):void
		{
			_hScrollbar.value = -content.x;
			_vScrollbar.value = -content.y;
		}
		
		protected function onMouseGoUp(event:MouseEvent):void
		{
			isMouseDown = false;
			content.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
		}
		protected function onTouchEnd(event:TouchEvent):void
		{
			isTouchDown = false;
			content.stopTouchDrag(event.touchPointID);
			stage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		}

		private function MouseScrollEvent(e:MouseEvent):void
		{
			_vScrollbar.value += -( e.delta * 8 );
			update();
		}

		public function set dragContent(value:Boolean):void
		{
			_dragContent = value;
			if(_dragContent)
			{
				this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown, true);
				this.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin, true);
				_background.useHandCursor = true;
				_background.buttonMode = true;
			}
			else
			{
				this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown);
				this.removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				_background.useHandCursor = false;
				_background.buttonMode = false;
			}
		}
		public function get dragContent():Boolean
		{
			return _dragContent;
		}

        /**
         * Sets / gets whether the scrollbar will auto hide when there is nothing to scroll.
         */
        public function set autoHideScrollBar(value:Boolean):void
        {
            _vScrollbar.autoHide = value;
            _hScrollbar.autoHide = value;
        }
        public function get autoHideScrollBar():Boolean
        {
            return _vScrollbar.autoHide;
        }


	}
}