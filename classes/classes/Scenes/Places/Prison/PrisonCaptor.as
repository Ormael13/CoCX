package classes.Scenes.Places.Prison 
{
	import classes.*;
	import classes.GlobalFlags.*;
	
	public class PrisonCaptor extends BaseContent
	{
		public var roomEventOverride:Array = [false, true, true, false, false];
		
		public function PrisonCaptor() {}
		
		public function get captorTitle():String {
			return "Mistress";
		}
		
		public function get captorName():String {
			return "Elly";
		}
		
		public function get captorPronoun1():String {
			return "she";
		}
		public function get captorPronoun2():String {
			return "her";
		}
		public function get captorPronoun3():String {
			return "her";
		}
		
		public function get submitFuckFunc():Function {
			return prison.prisonCaptorSubmitFuck;
		}
		public function get resistFuckFunc():Function {
			return prison.prisonCaptorResistFuck;
		}
		
		/*public function prisonLoadCaptor(newPrisonTrainerID:String = "default") : void
		{
			prisonTrainerID = newPrisonTrainerID;
			prisonCaptor = new prisonTrainer();
			switch(newPrisonTrainerID)
			{
				case "test":
					captorTitle = "Master";
					captorName = "Testeroo";
					captorPronoun1 = "he";
					captorPronoun2 = "him";
					captorPronoun3 = "his";
					break;
				case "default":
			}
			prisonCaptor.updateNextRestraintCheckEvent(model.time.hours, model.time.days,rand(24));
			prisonCaptor.updateNextFeedingEvent(model.time.hours, model.time.days,rand(8));
		}*/
		
		public function prisonCaptorScratch(valueNum:Number) : Number
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScratch) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScratch,0,0,0,0);
			}
			return player["statusEffectv" + String(valueNum)](StatusEffects.PrisonCaptorEllyScratch);
		}
		
		public function prisonCaptorScratchSet(valueNum:Number, newVal:Number) : void
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScratch) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScratch,0,0,0,0);
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyScratch,valueNum,newVal);
		}
		
		public function prisonCaptorScratchChange(valueNum:Number, changeVal:Number) : void
		{
			var newVal:* = undefined;
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyScratch) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyScratch,0,0,0,0);
			}
			newVal = player["statusEffectv" + String(valueNum)](StatusEffects.PrisonCaptorEllyScratch) + changeVal;
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyScratch, valueNum, newVal);
		}
		
		public function selectPunishmentEvent(lightChance:int = 0):void {
			var lightOrHeavy:int = rand(100);
			var chooser:int = rand(6);
			if (lightOrHeavy < lightChance) { //Light
				if (chooser > 0) prison.prisonCaptorPunishmentRestrain();
				//else if (chooser == 4) prison.billieScene.prisonCaptorBilliePunishmentFuck();
				else prison.punishments.prisonCaptorPunishmentBJTrainer();
			}
			else { //Heavy
				if (chooser >= 2) prison.punishments.prisonCaptorPunishmentConfinement();
				else prison.punishments.prisonCaptorPunishmentStockades();
			}
		}
		
		/*public function restraintDescriptionsV1():Boolean {
			if (player.statusEffectv1(StatusEffects.PrisonRestraints) == 1) {
				return true;
			}
			else return false;
		}
		public function restraintDescriptionsV2():Boolean {
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) == 1) {
				outputText("Your legs are fettered and chained securely to the wall.");
				return true;
			}
			else if (player.statusEffectv2(StatusEffects.PrisonRestraints) >= 2) {
				outputText("You are hogtied and chained to the wall. You find this demoralizing and fatiguing.");
				return true;
			}
			else return false;
		}
		public function restraintDescriptionsV3():Boolean {
			if (player.statusEffectv3(StatusEffects.PrisonRestraints) > 0) {
				outputText("Your arms are bound behind your back.");
				return true;
			}
			else return false;
		}
		public function restraintDescriptionsV4():Boolean {
			if (player.statusEffectv4(StatusEffects.PrisonRestraints) > 0) {
				return true;
			}
			else return false;
		}*/
		
		public function updateNextWaitRandomEvent(hours:int, days:int):void {
			
		}
		
		public function updateNextRoomRandomEvent(hours:int, days:int):void {
			
		}
		
		public function updateNextFeedingEvent(hours:int, days:int):Boolean {
			return prison.trainingFeed.prisonCaptorFeedingEvent();
		}
		
		public function timeForWaitRandomEvent(hours:int, days:int, goal:int):Boolean {
			var timesPassed:int = model.time.totalTime;
			if (timesPassed % goal == 0) return true;
			else return false;
		}
	}

}