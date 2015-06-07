package classes.Perks 
{
	import classes.*;
	import classes.GlobalFlags.*;
	
	public class MetamorphPerk extends PerkType
	{
		public function MetamorphPerk() {
			super("Metamorph", "Metamorph",
				"Grants ability to change your body at will.",
				"You choose the 'Metamorph' perk, giving you an ability to change your body at will!");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean {
			return true;
		}
		
		public function metamorphOptions():void { // TODO: save your initial body after character creation to support special characters and to be able to get real initial body instead of generic human.
			clearOutput();
			menu();
			outputText("You can use your ability to change your body.");
			var button:int = 0;
			var p:Player = kGAMECLASS.player;
			
			outputText("\n\nYou can change your gender traits.");
			addButton(button++, "Gender", metamorphEndowments);
			
			if (p.faceType != FACE_HUMAN) {
				outputText("\n\nYou can change your face to the initial state.");
				addButton(button++, "Face", face); }
			
			if (p.eyeType != EYES_HUMAN) {
				outputText("\n\nYou can change your eyes to the initial state.");
				addButton(button++, "Eyes", eyes); }
			
			if (p.faceType != SKIN_TYPE_PLAIN) {
				outputText("\n\nYou can change your skin to the initial state.");
				addButton(button++, "Skin", skin); }
			
			if (p.hairType != HAIR_NORMAL) {
				outputText("\n\nYou can change your hair to the initial state.");
				addButton(button++, "Hair", hair); }
			
			if (p.antennae != ANTENNAE_NONE) {
				outputText("\n\nYou can change your antennae to the initial state.");
				addButton(button++, "Antennae", antennae); }
			
			if (p.earType != EARS_HUMAN) {
				outputText("\n\nYou can change your ears to the initial state.");
				addButton(button++, "Ears", ears); }
			
			if (p.tongueType != TONUGE_HUMAN) {
				outputText("\n\nYou can change your tongue to the initial state.");
				addButton(button++, "Tongue", tongue); }
			
			if (p.hornType != HORNS_NONE) {
				outputText("\n\nYou can change your horns to the initial state.");
				addButton(button++, "Horns", horns); }
			
			if (p.wingType != WING_TYPE_NONE) {
				outputText("\n\nYou can change your wings to the initial state.");
				addButton(button++, "Wings", wings); }
			
			if (p.armType != ARM_TYPE_HUMAN) {
				outputText("\n\nYou can change your arms to the initial state.");
				addButton(button++, "Arms", arms); }
			
			if (p.gills != false) {
				outputText("\n\nYou can change your gills to the initial state.");
				addButton(button++, "Gills", gills); }
			
			if (p.tailType != TAIL_TYPE_NONE) {
				outputText("\n\nYou can change your tail to the initial state.");
				addButton(button++, "Tail", tail); }
			
			if (p.lowerBody != LOWER_BODY_TYPE_HUMAN) {
				outputText("\n\nYou can change your legs to the initial state.");
				addButton(button++, "Legs", legs); }
			
			addButton(14, "Next", playerMenu);
		}
		
		public function revert(part:String):void { // common code for revert
			clearOutput();
			menu();
			outputText("After some time in meditation you was able to get your normal " + part + " back!");
			addButton(14, "Next", metamorphOptions); }
		
		public function face():void {
			revert("face");
			kGAMECLASS.player.faceType = FACE_HUMAN; }
		
		public function eyes():void {
			revert("eyes");
			kGAMECLASS.player.eyeType = EYES_HUMAN; }
		
		public function skin():void {
			revert("skin");
			kGAMECLASS.player.skinType = SKIN_TYPE_PLAIN; }
		
		public function hair():void {
			revert("hair");
			kGAMECLASS.player.hairType = HAIR_NORMAL; }
		
		public function antennae():void {
			revert("antennae");
			kGAMECLASS.player.antennae = ANTENNAE_NONE; }
		
		public function ears():void {
			revert("ears");
			kGAMECLASS.player.earType = EARS_HUMAN; }
		
		public function tongue():void {
			revert("tongue");
			kGAMECLASS.player.tongueType = TONUGE_HUMAN; }
		
		public function horns():void {
			revert("horns");
			kGAMECLASS.player.hornType = HORNS_NONE;
			kGAMECLASS.player.horns = 0; }
		
		public function wings():void {
			revert("wings");
			kGAMECLASS.player.wingType = WING_TYPE_NONE; }
		
		public function arms():void {
			revert("arms");
			kGAMECLASS.player.armType = ARM_TYPE_HUMAN; }
		
		public function gills():void {
			revert("gills");
			kGAMECLASS.player.gills = false; }
		
		public function tail():void {
			revert("tail");
			kGAMECLASS.player.tailType = TAIL_TYPE_NONE;
			kGAMECLASS.player.tailRecharge = 5;
			kGAMECLASS.player.tailVenom = 0; }
		
		public function legs():void {
			revert("legs");
			kGAMECLASS.player.lowerBody = LOWER_BODY_TYPE_HUMAN; }
		
		public function metamorphEndowments():void {
			clearOutput();
			menu();
			outputText("You can use your ability to change your body.");
			var button:int = 0;
			var p:Player = kGAMECLASS.player;
			
			outputText("\n\nYou can change your breasts.");
			addButton(button++, "Breasts", metamorphBreasts);
			
			if (p.hasCock()) outputText("\n\nYou can change your cocks.");
			else outputText("\n\nYou can grow cock.");
			addButton(button++, "Cock", metamorphCock);
			
			if (p.balls > 0) {
				outputText("\n\nYou can change your balls.");
				addButton(button++, "Balls", metamorphBalls);
			}
			else if (p.hasCock()) {
				outputText("\n\nYou can grow balls.");
				addButton(button++, "Balls", metamorphBalls);
			}
			
			if (p.hasVagina()) outputText("\n\nYou can change your vagina.");
			else outputText("\n\nYou can grow vagina.");
			addButton(button++, "Vagina", metamorphVagina);
			
			outputText("\n\nYou can change your ass.");
			addButton(button++, "Ass", metamorphAss);
			
			addButton(14, "Next", metamorphOptions);
		}
		
		public function metamorphBreasts():void {
			clearOutput();
			menu();
			kGAMECLASS.descBreasts();
			var button:int = 0;
			var p:Player = kGAMECLASS.player;
			
			if (/*p.breastRows.length < 4*/kGAMECLASS.debug) { // should be only for characters who had more rows from beginning
				outputText("\n\nYou can grow new breasts row.");
				addButton(0, "Add Row", metamorphBreastsAdd); }
			
			if (p.breastRows.length > 1) { // TODO: make it like cocks, choose row first, change later
				outputText("\n\nYou can remove lowest row of breasts.");
				addButton(1, "Rem Row", metamorphBreastsRemove); }
			
			if (p.breastRows[0].breastRating < BREAST_CUP_E) {
				outputText("\n\nYou can grow your breasts.");
				addButton(2, "Grow", metamorphBreastsGrow); }
			
			if (p.breastRows[0].breastRating > BREAST_CUP_FLAT) {
				outputText("\n\nYou can shrink your breasts.");
				addButton(3, "Shrink", metamorphBreastsShrink); }
			
				/*
			if (p.nippleLength > 0.25) {
				outputText("\n\nYou can grow your nipples.");
				addButton(button++, "ShrinkNips", metamorphNipplesShrink); } // TODO
			
			if (p.nippleLength < 5) {
				outputText("\n\nYou can grow your nipples.");
				addButton(button++, "GrowNips", metamorphNipplesGrow); } // TODO
			
			if (p.breastRows[0].nipplesPerBreast > 1) {
				outputText("\n\nYou can remove extra nipples.");
				addButton(button++, "LessNipps", metamorphBreastsRemoveNipples); } // TODO
			
			if (p.breastRows[0].fuckable) {
				outputText("\n\nYou can shut close your fuckable nipples.");
				addButton(button++, "NoFuck", metamorphBreastsRemoveFuckable); } // TODO
			
			if (p.isLactating()) {
				outputText("\n\nYou can stop lactation.");
				addButton(button++, "StopLact", metamorphBreastsStopLact); } // TODO
			
			if (p.breastRows[0].breastRating > BREAST_CUP_FLAT) {
				outputText("\n\nYou can boost lactation.");
				addButton(button++, "BoostLact", metamorphBreastsBoostLact); } // TODO
			*/
			
			addButton(14, "Next", metamorphEndowments);
		}
		
		public function metamorphBreastsAdd():void {
			kGAMECLASS.player.createBreastRow();
			kGAMECLASS.player.breastRows[player.bRows() - 1].breastRating = kGAMECLASS.player.breastRows[kGAMECLASS.player.bRows() - 2].breastRating;
			kGAMECLASS.player.breastRows[player.bRows() - 1].nipplesPerBreast = kGAMECLASS.player.breastRows[kGAMECLASS.player.bRows() - 2].nipplesPerBreast;
			if (kGAMECLASS.player.hasFuckableNipples()) player.breastRows[player.bRows() - 1].fuckable = true;
			kGAMECLASS.player.breastRows[player.bRows() - 1].lactationMultiplier = kGAMECLASS.player.breastRows[kGAMECLASS.player.bRows() - 2].lactationMultiplier;
			clearOutput();
			menu();
			outputText("Now you have new row of breasts.");
			addButton(14, "Next", metamorphBreasts);
		}
		
		public function metamorphBreastsRemove():void {
			kGAMECLASS.player.removeBreastRow(player.bRows() - 1, 1);
			metamorphBreasts();
		}
		
		public function metamorphBreastsGrow(select:int = -1):void {
			clearOutput();
			menu();
			var button:int = 0;
			var p:Player = kGAMECLASS.player;
			if (select >= 0) p.breastRows[select].breastRating++;
			kGAMECLASS.descBreasts();
			
			for (var j:int = 0; j < p.breastRows.length; j++)
				if(p.breastRows[j].breastRating < BREAST_CUP_E && (j == 0 || p.breastRows[j].breastRating < p.breastRows[j - 1].breastRating)) // can not grow above E, can not have lower larger than upper
					addButton(button++, "" + (j + 1), createCallBackFunction(metamorphBreastsGrow, j));
			
			if (button > 0) outputText("\nWhich row should be bigger?");
			else outputText("\nYou have no appropriate breast rows to grow.");
			
			addButton(14, "Next", metamorphBreasts);
		}
		
		public function metamorphBreastsShrink(select:int = -1):void {
			clearOutput();
			menu();
			var button:int = 0;
			var p:Player = kGAMECLASS.player;
			if (select >= 0) p.breastRows[select].breastRating--;
			kGAMECLASS.descBreasts();
			
			for (var j:int = 0; j < p.breastRows.length; j++)
				if(p.breastRows[j].breastRating > BREAST_CUP_FLAT && (j == p.breastRows.length - 1 || p.breastRows[j].breastRating > p.breastRows[j + 1].breastRating)) // can not shrink below flat, can not have lower larger than upper
					addButton(button++, "" + (j + 1), createCallBackFunction(metamorphBreastsShrink, j));
			
			if (button > 0) outputText("\nWhich row should be smaller?");
			else outputText("\nYou have no appropriate breast rows to shrink.");
			
			addButton(14, "Next", metamorphBreasts);
		}
		
		
		public function metamorphAss():void {
			clearOutput();
			menu();
			var button:int = 0;
			var p:Player = kGAMECLASS.player;
			outputText("You have " + Appearance.assholeDescript(p, true) + ".\n");
			
			if (p.ass.analWetness < (kGAMECLASS.debug ? ANAL_WETNESS_SLIME_DROOLING : ANAL_WETNESS_SLIMY)) {
				outputText("\nYou can increase wetness.");
				addButton(button++, "Wet", createCallBackFunction(metamorphAssWet, 1)); }
			
			if (p.ass.analWetness > (kGAMECLASS.debug ? ANAL_WETNESS_DRY : ANAL_WETNESS_NORMAL)) {
				outputText("\nYou can decrease wetness.");
				addButton(button++, "Dry", createCallBackFunction(metamorphAssWet, -1)); }
			
			if (p.ass.analLooseness > (kGAMECLASS.debug ? ANAL_LOOSENESS_VIRGIN : ANAL_LOOSENESS_TIGHT)) {
				outputText("\nYou can tighten it.");
				addButton(button++, "Tight", createCallBackFunction(metamorphAssLoose, -1)); }
			
			if (p.ass.analLooseness < (kGAMECLASS.debug ? ANAL_LOOSENESS_GAPING : ANAL_LOOSENESS_STRETCHED)) {
				outputText("\nYou can make it more loose.");
				addButton(button++, "Loose", createCallBackFunction(metamorphAssLoose, 1)); }
			
			// TODO: capacity
			
			addButton(14, "Next", metamorphEndowments);
		}
		
		public function metamorphAssWet(change:int):void {
			kGAMECLASS.player.ass.analWetness = kGAMECLASS.player.ass.analWetness + change;
			metamorphAss(); }
		
		public function metamorphAssLoose(change:int):void {
			kGAMECLASS.player.ass.analLooseness = kGAMECLASS.player.ass.analLooseness + change;
			metamorphAss(); }
		
		public function metamorphVagina():void {
			clearOutput();
			menu();
			var p:Player = kGAMECLASS.player;
			
			if (!p.hasVagina()) {
				outputText("\n\nYou can grow new vagina.\n");
				addButton(0, "Grow", newVag);
			} else {
			outputText("You have " + Appearance.vaginaDescript(p, 0 , true) + ".");
			
			if (!p.isPregnant()) {
				outputText("\nYou can remove vagina.");
				addButton(0, "Remove", noVag); }
			
			if (p.vaginas[0].vaginalWetness < (kGAMECLASS.debug ? VAGINA_WETNESS_SLAVERING : VAGINA_WETNESS_SLICK)) {
				outputText("\nYou can increase wetness.");
				addButton(1, "Wet", createCallBackFunction(metamorphVagWet, 1)); }
			
			if (p.vaginas[0].vaginalWetness > (kGAMECLASS.debug ? VAGINA_WETNESS_DRY : VAGINA_WETNESS_NORMAL)) {
				outputText("\nYou can decrease wetness.");
				addButton(2, "Dry", createCallBackFunction(metamorphVagWet, -1)); }
			
			if (p.vaginas[0].vaginalLooseness > VAGINA_LOOSENESS_TIGHT) {
				outputText("\nYou can tighten it.");
				addButton(3, "Tight", createCallBackFunction(metamorphVagLoose, -1)); }
			
			if (p.vaginas[0].vaginalLooseness < (kGAMECLASS.debug ? VAGINA_LOOSENESS_LEVEL_CLOWN_CAR : VAGINA_LOOSENESS_GAPING)) {
				outputText("\nYou can make it more loose.");
				addButton(4, "Loose", createCallBackFunction(metamorphVagLoose, 1)); }
			
			// TODO: capacity
			// TODO: clit change
			
			}
			
			addButton(14, "Next", metamorphEndowments);
		}
		
		public function newVag():void {
			kGAMECLASS.player.createVagina();
			metamorphVagina(); }
		
		public function noVag():void {
			kGAMECLASS.player.removeVagina();
			metamorphVagina(); }
		
		public function metamorphVagWet(change:int):void {
			kGAMECLASS.player.vaginas[0].vaginalWetness = kGAMECLASS.player.vaginas[0].vaginalWetness + change;
			metamorphVagina(); }
		
		public function metamorphVagLoose(change:int):void {
			kGAMECLASS.player.vaginas[0].vaginalLooseness = kGAMECLASS.player.vaginas[0].vaginalLooseness + change;
			metamorphVagina(); }
		
		public function metamorphCock():void {
			clearOutput();
			menu();
			var button:int = 0;
			var p:Player = kGAMECLASS.player;
			
			if (!p.hasCock()) {
				outputText("\nYou can grow new cock.");
				addButton(button++, "New", newCock);
			} else {
			outputText("Which cock you want to alter?");
			kGAMECLASS.descCocks();
			for (var i:int = 0; i < p.cocks.length; i++) {
				addButton(button++, "" + (i + 1), createCallBackFunction(selectCock, i)); }
			
			if (p.cockTotal() < 10) {
				outputText("\nYou can grow new cock.");
				addButton(button++, "New", newCock);
			}
			
			}
			addButton(14, "Next", metamorphEndowments);
		}
		
		public function newCock():void {
			kGAMECLASS.player.createCock();
			selectCock(kGAMECLASS.player.cocks.length - 1);
		}
		
		public function selectCock(index:int = 0):void {
			clearOutput();
			menu();
			var button:int = 0;
			var p:Player = kGAMECLASS.player;
			
			outputText("Your " + cockDescript(index) + " is " + int(10*p.cocks[index].cockLength)/10 + " inches long and ", false);
			if(Math.round(10*p.cocks[index].cockThickness)/10 < 10) 
			{
				if(Math.round(10*p.cocks[index].cockThickness)/10 == 1) 
					outputText(int(10*p.cocks[index].cockThickness)/10 + " inch thick.", false);
				else outputText(Math.round(10 * p.cocks[index].cockThickness) / 10 + " inches thick.", false);
			}
			else outputText (num2Text(Math.round(10*p.cocks[index].cockThickness)/10) + " inches wide.", false);
			
			kGAMECLASS.descCockFlavor(index);
			
			outputText("\n\nYou can remove this cock.");
			addButton(0, "Remove", createCallBackFunction(cockRem, index));
			
			if (p.cocks[index].cockLength < (kGAMECLASS.debug ? 100 : p.tallness / 8)) {
				outputText("\nYou make your cock longer.");
				addButton(1, "Len+", createCallBackFunction2(cockLen, index, 1)); }
			
			if (p.cocks[index].cockLength > (kGAMECLASS.debug ? 2 : p.tallness / 24)) {
				outputText("\nYou make your cock shorter.");
				addButton(2, "Len-", createCallBackFunction2(cockLen, index, -1)); }
			
			if (p.cocks[index].cockThickness < (kGAMECLASS.debug ? 10 : p.tallness / 32)) {
				outputText("\nYou make your cock thicker.");
				addButton(3, "Wide+", createCallBackFunction2(cockWid, index, 1)); }
			
			if (p.cocks[index].cockThickness > 1) {
				outputText("\nYou make your cock thinner.");
				addButton(4, "Wide-", createCallBackFunction2(cockWid, index, -1)); }
			
			if ((p.cocks[index].cockType == CockTypesEnum.DOG || p.cocks[index].cockType == CockTypesEnum.FOX) && p.cocks[index].knotMultiplier < 1.6) {
				outputText("\nYou make your knot thicker.");
				addButton(5, "Knot+", createCallBackFunction2(cockKnotWid, index, 1)); }
			
			if ((p.cocks[index].cockType == CockTypesEnum.DOG || p.cocks[index].cockType == CockTypesEnum.FOX) && p.cocks[index].knotMultiplier > 1.2) {
				outputText("\nYou make your knot thinner.");
				addButton(6, "Knot-", createCallBackFunction2(cockKnotWid, index, -1)); }
			
			addButton(14, "Next", metamorphCock);
		}
		
		public function cockRem(index:int):void {
			kGAMECLASS.player.removeCock(index, 1);
			metamorphCock();
		}
		
		public function cockLen(index:int, change:int):void { // 1 cm for metrics, 1 inch for imperial
			var target:Cock = kGAMECLASS.player.cocks[index];
			target.cockLength = target.cockLength + (kGAMECLASS.flags[kFLAGS.USE_METRICS] > 0 ? 1 / 2.54 : 1) * change;
			selectCock(index);
		}
		
		public function cockWid(index:int, change:int):void { // 0.1 cm for metrics, 0.1 inch for imperial
			var target:Cock = kGAMECLASS.player.cocks[index];
			target.cockLength = target.cockLength + (kGAMECLASS.flags[kFLAGS.USE_METRICS] > 0 ? 0.1 / 2.54 : 0.1) * change;
			selectCock(index);
		}
		
		public function cockKnotWid(index:int, change:int):void { // it's mult, 0.1 per step
			var target:Cock = kGAMECLASS.player.cocks[index];
			target.knotMultiplier = target.knotMultiplier + 0.1 * change;
			selectCock(index);
		}
		
		public function metamorphBalls():void {
			clearOutput();
			menu();
			var button:int = 0;
			var p:Player = kGAMECLASS.player;
			
			kGAMECLASS.descBalls();
			outputText("\n");
			
			if (p.balls == 0) {
				outputText("\n\nYou can grow new balls.");
				addButton(0, "Grow", ballsNew);
			} else {
				outputText("\n\nYou can remove balls.");
				addButton(0, "Remove", ballsRemove);
				outputText("\nYou can change balls size.");
				if(p.ballSize < 1 + Math.floor(p.tallness / 33) || kGAMECLASS.debug) addButton(2, "Grow", createCallBackFunction(ballsSize, 1));
				if(p.ballSize > 1) addButton(3, "Shrink", createCallBackFunction(ballsSize, -1));
			}
			
			// TODO: remove quad sack
			// TODO: remove uniball
			
			addButton(14, "Next", metamorphEndowments);
		}
		
		public function ballsRemove():void {
			var p:Player = kGAMECLASS.player;
			p.balls = 0;
			p.ballSize = 0;
			metamorphBalls();
		}
		
		public function ballsNew():void {
			var p:Player = kGAMECLASS.player;
			p.balls = 2;
			p.ballSize = 1;
			metamorphBalls();
		}
		
		public function ballsSize(change:int):void {
			kGAMECLASS.player.ballSize += change;
			metamorphBalls();
		}
	}
}