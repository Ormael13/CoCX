package coc.model 
{
	public class TimeModel 
	{
		private var _days:Number;
		private var _hours:Number;

		public function get days():Number
		{
			return _days;
		}
		
		public function set days(value:Number):void
		{
			_days = value;
		}
		
		public function get hours():Number
		{
			return _hours;
		}
		
		public function set hours(value:Number):void
		{
			_hours = value;
		}		
		public function get totalTime():Number
		{
			return (this._days * 24 + this._hours);
		}
	}
}