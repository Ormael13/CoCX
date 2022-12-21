package coc.model 
{
import classes.CoC;
import classes.DefaultDict;
import classes.GlobalFlags.kFLAGS;
import classes.StatusEffects;

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

		//===================================================================
		//Date tools
		//IMPORTANT: Date class counts month from 0 to 11.
		protected static function get flags():DefaultDict {
			return CoC.instance.flags;
		}

		public static function formatDate(d:Date):String {
			var monthDayYear:Array = d.toDateString().split(" ").slice(1);
			if (flags[kFLAGS.USE_METRICS]) return monthDayYear[1] + " " + monthDayYear[0] + " " + monthDayYear[2];
			else return monthDayYear[1] + " " + monthDayYear[0] + " " + monthDayYear[2];
		}

		private static function get dateReal():Date {
			return new Date();
		}

		public function useRealDate():Boolean {
			return flags[kFLAGS.DAYS_PER_YEAR] <= 0;
		}

		//days are counted from 0, date from {1,1,1}
		public static function dateFromDays(gameDays:int, daysPerYear:int):Date {
			var day:int = 1;
			var month:int = 5; //starting from June to avoid most events
			var year:int = 2010; //CoC origins!
			if (daysPerYear != 365) { //easy case
				year += int(gameDays / daysPerYear);
				gameDays %= daysPerYear;
				month += int(gameDays / int(daysPerYear/12));
				gameDays %= int(daysPerYear/12);
			} else { //reality fuckery
				year += int(gameDays / 1461) * 4; //365*3+366
				gameDays %= 1461;
				var dpyReal:Array = [365, 366, 365, 365]; //days per year from the middle of 2010
				for (var i:int = 0; gameDays >= dpyReal[i]; ++i) {
					gameDays -= dpyReal[i];
					++year;
				}
				year += int(gameDays / 365); //leap year will be the last
				gameDays %= 365;
				var daysPerMonth:Array = [30, 31, 31, 30, 31, 30, 31, /*OVERFLOW - next year*/ 31, (year + 1) % 4 == 0 ? 29 : 28, 31, 30, 31];
				while (gameDays >= daysPerMonth[month - 5]) gameDays -= daysPerMonth[month++ - 5]; //STARTS FROM JUNE
			}
			if (month >= 12) { //fix overflow
				++year;
				month -= 12;
			}
			day += gameDays;
			return new Date(year, month, day);
		}

		public static function daysFromDate(dateObj:Date, daysPerYear:int):int {
			var gameDays:int = 0;
			var day:int = dateObj.date;
			var dayOffset:int = day - 1;
			var month:int = dateObj.month < 5 ? dateObj.month + 12 : dateObj.month;
			var monthOffset:int = month - 5;
			var year:int = dateObj.month < 5 ? dateObj.fullYear - 1 : dateObj.fullYear;
			var yearOffset:int = year - 2010;
			if (daysPerYear != 365) { //easy case
				gameDays += yearOffset * daysPerYear;
				gameDays += monthOffset * int(daysPerYear/12);
			} else { //reality fuckery
				gameDays += int(yearOffset / 4) * 1461;
				var dpyReal:Array = [365, 366, 365, 365]; //days per year from the middle of 2010
				for (var i:int = 0; i < yearOffset % 4; ++i) gameDays += dpyReal[i];
				var daysPerMonth:Array = [30, 31, 31, 30, 31, 30, 31, /*OVERFLOW - next year*/ 31, year % 4 == 0 ? 29 : 28, 31, 30, 31];
				while (monthOffset > 0) gameDays += daysPerMonth[--monthOffset];
			}
			gameDays += dayOffset;
			return gameDays;
		}

		public function get date():Date {
			return useRealDate() ? dateReal :
				dateFromDays(CoC.instance.model.time.days + flags[kFLAGS.DATE_OFFSET], flags[kFLAGS.DAYS_PER_YEAR]);
		}

		//Change daysPerYear - and recalculate offset to keep the date as close as possible to original one.
		public function changeDPY(newDPY:int):void {
			if (flags[kFLAGS.DAYS_PER_YEAR] == newDPY) return;
			var curDate:Date = date; //calculate the date using the current DPY and offset
			if (newDPY <= 0) { //real date - reset the offset and fix stored year values
				var yearOffset:int = dateReal.fullYear - curDate.fullYear;
				var flagsToFix:Array = [
					kFLAGS.CANDY_CANE_YEAR_MET,
					kFLAGS.FERAS_GLADE_EXPLORED_YEAR,
					kFLAGS.FERAS_TRAP_SPRUNG_YEAR,
					kFLAGS.JACK_FROST_YEAR,
					kFLAGS.LAST_EASTER_YEAR,
					kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE,
					kFLAGS.POLAR_PETE_YEAR_MET,
					kFLAGS.PUMPKIN_FUCK_YEAR_DONE,
					kFLAGS.TREACLE_MINE_YEAR_DONE,
					kFLAGS.TURKEY_FUCK_YEAR_DONE,
					kFLAGS.VALENTINES_EVENT_YEAR,
					kFLAGS.XMAS_CHICKEN_YEAR,
					kFLAGS.HELIA_BIRTHDAY_LAST_YEAR,
				]
				for each (var flagID:int in flagsToFix)
					if (flags[flagID] != 0) flags[flagID] += yearOffset;
				//Rathazul status too!
				if (CoC.instance.player.hasStatusEffect(StatusEffects.RathazulAprilFool))
					CoC.instance.player.changeStatusValue(StatusEffects.RathazulAprilFool, 1,
						CoC.instance.player.statusEffectv1(StatusEffects.RathazulAprilFool) + yearOffset);
				flags[kFLAGS.DATE_OFFSET] = 0;
			} else {
				var gameDays:int = CoC.instance.model.time.days; //current days counter
				var dpm365:Array = [31, curDate.fullYear % 4 == 0 ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
				var dpmOld:int = (flags[kFLAGS.DAYS_PER_YEAR] == 0 || flags[kFLAGS.DAYS_PER_YEAR] == 365) ? dpm365[date.month] : flags[kFLAGS.DAYS_PER_YEAR] / 12;
				var dpmNew:int = (newDPY == 365) ? dpm365[date.month] : newDPY / 12;
				curDate.setDate(int(curDate.date * dpmNew / dpmOld)); //correct the day of month to the new scale
				var newDays:int = daysFromDate(curDate, newDPY); //calculate the 'new' days value for this date.
				flags[kFLAGS.DATE_OFFSET] = newDays - gameDays; //fix the offset
			}
			flags[kFLAGS.DAYS_PER_YEAR] = newDPY;
		}
	}
}