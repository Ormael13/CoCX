package classes.Scenes.Camp
{
	import classes.*;

	public class ImpGang extends Monster
	{
		override public function get capitalA():String {
			return "gang of imps";
		}
		public function ImpGang()
		{
			this.removeStatuses();
			this.removePerks();
			this.removeCock(0, this.cocks.length);
			this.removeVagina(0, this.vaginas.length);
			this.removeBreastRow(0, this.breastRows.length);
			this.createCock(12,1.5);
			this.createCock(25,2.5);
			this.createCock(25,2.5);
			this.cocks[2].cockType = CockTypesEnum.DOG;
			this.cocks[2].knotMultiplier = 2;
			this.balls = 2;
			this.ballSize = 3;
			this.a = "a mob of imps";
			this.short = "imp gang";
			this.skinTone = "imp mob";
		}
		
	}

}