		//Calls are now made through kGAMECLASS rather than thisPtr. This allows the compiler to detect if/when a function is inaccessible.
		import classes.GlobalFlags.kGAMECLASS;



		// Possible text arguments in the conditional of a if statement
		// First, there is an attempt to cast the argument to a Number. If that fails,
		// a dictionary lookup is performed to see if the argument is in the conditionalOptions[]
		// object. If that fails, we just fall back to returning 0
		public var conditionalOptions:Object =
		{
				"strength"			: function(thisPtr:*):* {return  kGAMECLASS.player.str;},
				"toughness"			: function(thisPtr:*):* {return  kGAMECLASS.player.tou;},
				"speed"				: function(thisPtr:*):* {return  kGAMECLASS.player.spe;},
				"intelligence"		: function(thisPtr:*):* {return  kGAMECLASS.player.inte;},
				"libido"			: function(thisPtr:*):* {return  kGAMECLASS.player.lib;},
				"sensitivity"		: function(thisPtr:*):* {return  kGAMECLASS.player.sens;},
				"corruption"		: function(thisPtr:*):* {return  kGAMECLASS.player.cor;},
				"fatigue"			: function(thisPtr:*):* {return  kGAMECLASS.player.fatigue;},
				"hp"				: function(thisPtr:*):* {return  kGAMECLASS.player.HP;},
				"hunger"			: function(thisPtr:*):* {return  kGAMECLASS.player.hunger;},
				"minute"			: function(thisPtr:*):* {return  kGAMECLASS.model.time.minutes;},
				"hour"				: function(thisPtr:*):* {return  kGAMECLASS.model.time.hours;},
				"days"				: function(thisPtr:*):* {return  kGAMECLASS.model.time.days;},
				"tallness"			: function(thisPtr:*):* {return  kGAMECLASS.player.tallness;},
				"hairlength"		: function(thisPtr:*):* {return  kGAMECLASS.player.hairLength;},
				"femininity"		: function(thisPtr:*):* {return  kGAMECLASS.player.femininity;},
				"masculinity"		: function(thisPtr:*):* {return  100 - kGAMECLASS.player.femininity;},
				"cocks"				: function(thisPtr:*):* {return  kGAMECLASS.player.cockTotal();},
				"breastrows"		: function(thisPtr:*):* {return  kGAMECLASS.player.bRows();},
				"biggesttitsize"	: function(thisPtr:*):* {return  kGAMECLASS.player.biggestTitSize();},
				"vagcapacity"		: function(thisPtr:*):* {return  kGAMECLASS.player.vaginalCapacity();},
				"analcapacity"		: function(thisPtr:*):* {return  kGAMECLASS.player.analCapacity();},
				"balls"				: function(thisPtr:*):* {return  kGAMECLASS.player.balls;},
				"cumquantity"		: function(thisPtr:*):* {return  kGAMECLASS.player.cumQ();},
				"biggesttitsize"	: function(thisPtr:*):* {return  kGAMECLASS.player.biggestTitSize();},
				"milkquantity"		: function(thisPtr:*):* {return  kGAMECLASS.player.lactationQ();},
				"hasvagina"			: function(thisPtr:*):* {return  kGAMECLASS.player.hasVagina();},
				"istaur"			: function(thisPtr:*):* {return  kGAMECLASS.player.isTaur();},
				"isnaga"			: function(thisPtr:*):* {return  kGAMECLASS.player.isNaga();},
				"isgoo"				: function(thisPtr:*):* {return  kGAMECLASS.player.isGoo();},
				"isbiped"			: function(thisPtr:*):* {return  kGAMECLASS.player.isBiped();},
				"hasbreasts"		: function(thisPtr:*):* {return  (kGAMECLASS.player.biggestTitSize() >= 1);},
				"hasballs"			: function(thisPtr:*):* {return  (kGAMECLASS.player.balls > 0);},
				"hascock"			: function(thisPtr:*):* {return  kGAMECLASS.player.hasCock();},
				"isherm"			: function(thisPtr:*):* {return  (kGAMECLASS.player.gender == 3);},
				"cumnormal"			: function(thisPtr:*):* {return  (kGAMECLASS.player.cumQ() <= 150);},
				"cummedium"			: function(thisPtr:*):* {return  (kGAMECLASS.player.cumQ() > 150 && kGAMECLASS.player.cumQ() <= 350);},
				"cumhigh"			: function(thisPtr:*):* {return  (kGAMECLASS.player.cumQ() > 350 && kGAMECLASS.player.cumQ() <= 1000);},
				"cumveryhigh"		: function(thisPtr:*):* {return  (kGAMECLASS.player.cumQ() > 1000 && kGAMECLASS.player.cumQ() <= 2500);},
				"cumextreme"		: function(thisPtr:*):* {return  (kGAMECLASS.player.cumQ() > 2500);},
				"issquirter"		: function(thisPtr:*):* {return  (kGAMECLASS.player.wetness() >= 4);},
				"ispregnant"		: function(thisPtr:*):* {return  (kGAMECLASS.player.pregnancyIncubation > 0);},
				"isbuttpregnant"	: function(thisPtr:*):* {return  (kGAMECLASS.player.buttPregnancyIncubation > 0);},
				"hasnipplecunts"	: function(thisPtr:*):* {return  kGAMECLASS.player.hasFuckableNipples();},
				"canfly"			: function(thisPtr:*):* {return  kGAMECLASS.player.canFly();},
				"islactating"		: function(thisPtr:*):* {return  (kGAMECLASS.player.lactationQ() > 0);},
				"true"				: function(thisPtr:*):* {return  true;},
				"false"				: function(thisPtr:*):* {return  false;},
				
				//Prison
				"esteem"			: function(thisPtr:*):* {return  kGAMECLASS.player.esteem; },
				"obey"				: function(thisPtr:*):* {return  kGAMECLASS.player.obey; },
				"will"				: function(thisPtr:*):* {return  kGAMECLASS.player.will; }
			}
