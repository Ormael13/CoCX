package coc.model 
{
	public class TimeModel 
	{
		private var _days:Number;
		private var _hours:Number;
		private var _minutes:Number;

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
		
		public function get minutes():Number
		{
			return _minutes;
		}
		
		public function set minutes(value:Number):void
		{
			_minutes = value;
		}		
		
		public function get totalTime():Number
		{
			return (this._days * 24 + this._hours);
		}
	}
}