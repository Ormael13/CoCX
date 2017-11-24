		//Calls are now made through CoC.instance rather than thisPtr. This allows the compiler to detect if/when a function is inaccessible.
		import classes.CoC;



		// Possible text arguments in the conditional of a if statement
		// First, there is an attempt to cast the argument to a Number. If that fails,
		// a dictionary lookup is performed to see if the argument is in the conditionalOptions[]
		// object. If that fails, we just fall back to returning 0
		public var conditionalOptions:Object =
		{
				"strength"			: function(thisPtr:*):* {return  CoC.instance.player.str;},
				"toughness"			: function(thisPtr:*):* {return  CoC.instance.player.tou;},
				"speed"				: function(thisPtr:*):* {return  CoC.instance.player.spe;},
				"intelligence"		: function(thisPtr:*):* {return  CoC.instance.player.inte;},
				"wisdom"			: function(thisPtr:*):* {return  CoC.instance.player.wis;},
				"libido"			: function(thisPtr:*):* {return  CoC.instance.player.lib;},
				"sensitivity"		: function(thisPtr:*):* {return  CoC.instance.player.sens;},
				"corruption"		: function(thisPtr:*):* {return  CoC.instance.player.cor;},
				"soulforce"			: function(thisPtr:*):* {return  CoC.instance.player.soulforce;},
				"mana"				: function(thisPtr:*):* {return  CoC.instance.player.mana;},
				"fatigue"			: function(thisPtr:*):* {return  CoC.instance.player.fatigue;},
				"wrath"				: function(thisPtr:*):* {return  CoC.instance.player.wrath;},
				"hp"				: function(thisPtr:*):* {return  CoC.instance.player.HP;},
				"hunger"			: function(thisPtr:*):* {return  CoC.instance.player.hunger;},
				"minute"			: function(thisPtr:*):* {return  CoC.instance.model.time.minutes;},
				"hour"				: function(thisPtr:*):* {return  CoC.instance.model.time.hours;},
				"days"				: function(thisPtr:*):* {return  CoC.instance.model.time.days;},
				"tallness"			: function(thisPtr:*):* {return  CoC.instance.player.tallness;},
				"hairlength"		: function(thisPtr:*):* {return  CoC.instance.player.hairLength;},
				"femininity"		: function(thisPtr:*):* {return  CoC.instance.player.femininity;},
				"masculinity"		: function(thisPtr:*):* {return  100 - CoC.instance.player.femininity;},
				"cocks"				: function(thisPtr:*):* {return  CoC.instance.player.cockTotal();},
				"breastrows"		: function(thisPtr:*):* {return  CoC.instance.player.bRows();},
				"biggesttitsize"	: function(thisPtr:*):* {return  CoC.instance.player.biggestTitSize();},
				"vagcapacity"		: function(thisPtr:*):* {return  CoC.instance.player.vaginalCapacity();},
				"analcapacity"		: function(thisPtr:*):* {return  CoC.instance.player.analCapacity();},
				"balls"				: function(thisPtr:*):* {return  CoC.instance.player.balls;},
				"cumquantity"		: function(thisPtr:*):* {return  CoC.instance.player.cumQ();},
				"milkquantity"		: function(thisPtr:*):* {return  CoC.instance.player.lactationQ();},
				"hasvagina"			: function(thisPtr:*):* {return  CoC.instance.player.hasVagina();},
				"istaur"			: function(thisPtr:*):* {return  CoC.instance.player.isTaur();},
				"isnaga"			: function(thisPtr:*):* {return  CoC.instance.player.isNaga();},
				"isgoo"				: function(thisPtr:*):* {return  CoC.instance.player.isGoo();},
				"isbiped"			: function(thisPtr:*):* {return  CoC.instance.player.isBiped();},
				"isscylla"			: function(thisPtr:*):* {return  CoC.instance.player.isScylla();},
				"hasbreasts"		: function(thisPtr:*):* {return  (CoC.instance.player.biggestTitSize() >= 1);},
				"hasballs"			: function(thisPtr:*):* {return  (CoC.instance.player.balls > 0);},
				"hascock"			: function(thisPtr:*):* {return  CoC.instance.player.hasCock();},
				"isherm"			: function(thisPtr:*):* {return  (CoC.instance.player.gender == 3);},
				"cumnormal"			: function(thisPtr:*):* {return  (CoC.instance.player.cumQ() <= 150);},
				"cummedium"			: function(thisPtr:*):* {return  (CoC.instance.player.cumQ() > 150 && CoC.instance.player.cumQ() <= 350);},
				"cumhigh"			: function(thisPtr:*):* {return  (CoC.instance.player.cumQ() > 350 && CoC.instance.player.cumQ() <= 1000);},
				"cumveryhigh"		: function(thisPtr:*):* {return  (CoC.instance.player.cumQ() > 1000 && CoC.instance.player.cumQ() <= 2500);},
				"cumextreme"		: function(thisPtr:*):* {return  (CoC.instance.player.cumQ() > 2500);},
				"issquirter"		: function(thisPtr:*):* {return  (CoC.instance.player.wetness() >= 4);},
				"ispregnant"		: function(thisPtr:*):* {return  (CoC.instance.player.pregnancyIncubation > 0);},
				"isbuttpregnant"	: function(thisPtr:*):* {return  (CoC.instance.player.buttPregnancyIncubation > 0);},
				"hasnipplecunts"	: function(thisPtr:*):* {return  CoC.instance.player.hasFuckableNipples();},
				"canfly"			: function(thisPtr:*):* {return  CoC.instance.player.canFly();},
				"islactating"		: function(thisPtr:*):* {return  (CoC.instance.player.lactationQ() > 0);},
				"true"				: function(thisPtr:*):* {return  true;},
				"false"				: function(thisPtr:*):* {return  false;},
				
				//Prison
				"esteem"			: function(thisPtr:*):* {return  CoC.instance.player.esteem; },
				"obey"				: function(thisPtr:*):* {return  CoC.instance.player.obey; },
				"will"				: function(thisPtr:*):* {return  CoC.instance.player.will; }
			};
