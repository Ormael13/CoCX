package com.bit101.components {
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;

    public class TextFieldVScroll extends VScrollBar {
        protected var scrollTarget:TextField;

        public function TextFieldVScroll(_scrollTarget:TextField = null, parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0) {
            scrollTarget = _scrollTarget;
            super(parent, xpos, ypos, onScrollbarScroll);
            this.autoHide = true;
        }


        /**
         * Initilizes the component.
         */
        protected override function init():void {
            super.init();
            addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
            scrollTarget.width = scrollTarget.width - this.width;
        }

        /**
         * Creates and adds the child display objects of this component.
         */
        override protected function addChildren():void {
            super.addChildren();
            scrollTarget.addEventListener(Event.SCROLL, onTextScroll);
        }

        /**
         * Changes the thumb percent of the scrollbar based on how much text is shown in the text area.
         */
        protected function updateScrollbar():void {
            var visibleLines:int = scrollTarget.numLines - scrollTarget.maxScrollV + 1;
            var percent:Number = visibleLines / scrollTarget.numLines;
            this.setSliderParams(1, scrollTarget.maxScrollV, scrollTarget.scrollV);
            this.setThumbPercent(percent);
            this.pageSize = visibleLines;
        }


        ///////////////////////////////////
        // public methods
        ///////////////////////////////////

        /**
         * Draws the visual ui of the component.
         */
        override public function draw():void {
            super.draw();
            this.x = (scrollTarget.x + scrollTarget.width) + 10;
            this.height = scrollTarget.height;
            addEventListener(Event.ENTER_FRAME, onTextScrollDelay);
        }


        ///////////////////////////////////
        // event handlers
        ///////////////////////////////////

        /**
         * Waits one more frame before updating scroll bar.
         * It seems that numLines and maxScrollV are not valid immediately after changing a TextField's size.
         */
        protected function onTextScrollDelay(event:Event):void {
            removeEventListener(Event.ENTER_FRAME, onTextScrollDelay);
            updateScrollbar();
        }

        /**
         * Called when the scroll bar is moved. Scrolls text accordingly.
         */
        protected function onScrollbarScroll(event:Event):void {
            scrollTarget.scrollV = Math.round(this.value);
        }

        /**
         * Called when the text is scrolled manually. Updates the position of the scroll bar.
         */
        protected function onTextScroll(event:Event):void {
            this.value = scrollTarget.scrollV;
            updateScrollbar();
        }

        /**
         * Called when the mouse wheel is scrolled over the component.
         */
        protected function onMouseWheel(event:MouseEvent):void {
            this.value -= event.delta;
            scrollTarget.scrollV = Math.round(this.value);
        }

        /**
         * Sets/gets whether this component is enabled or not.
         */
        public override function set enabled(value:Boolean):void {
            super.enabled = value;
            scrollTarget.tabEnabled = value;
        }
    }
}
