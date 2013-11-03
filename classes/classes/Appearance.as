package classes
{
	import classes.Character;

	public class Appearance
	{

		// Eventually, this should contain the entire char appearance.
		// At the moment, it's pretty piecemeal.

		public static function rand(max:Number):Number
		{
			return int(Math.random() * max);
		}
		
		public static function cockNoun(cockType:*):String
		{	
			if (cockType is int)
			{
				trace("Someone is still calling cockNoun with an integer cock type");
				trace("Fix this shit already, dammit!")
				cockType = CockTypesEnum.legacySuportLoadCockType(cockType);
			}


			var descript:String = "";
			var rando:Number = 0;
			if (cockType == CockTypesEnum.HUMAN)
			{
				rando = rand(10) + 1;
				if (rando >= 0 && rando <= 4)
					descript += "cock";
				if (rando == 5 || rando == 6)
					descript += "prick";
				if (rando == 7)
					descript += "pecker";
				if (rando > 7)
					descript += "shaft";
			}
			if (cockType == CockTypesEnum.DOG)
			{
				
				rando = int(Math.random() * 11);
				if (rando == 0)
					descript += "dog-shaped dong";
				if (rando == 1)
					descript += "canine shaft";
				if (rando == 2)
					descript += "pointed prick";
				if (rando == 3)
					descript += "knotty dog-shaft";
				if (rando == 4)
					descript += "bestial cock";
				if (rando == 5)
					descript += "animalistic puppy-pecker";
				if (rando == 6)
					descript += "pointed dog-dick";
				if (rando == 7)
					descript += "pointed shaft";
				if (rando == 8)
					descript += "canine member";
				if (rando == 9)
					descript += "canine cock";
				if (rando == 10)
					descript += "knotted dog-cock";
			}
			if (cockType == CockTypesEnum.FOX)
			{				
				rando = int(Math.random() * 11);
				if (rando == 0)
					descript += "fox-shaped dong";
				if (rando == 1)
					descript += "vulpine shaft";
				if (rando == 2)
					descript += "pointed prick";
				if (rando == 3)
					descript += "knotty fox-shaft";
				if (rando == 4)
					descript += "bestial cock";
				if (rando == 5)
					descript += "animalistic vixen-pricker";
				if (rando == 6)
					descript += "pointed fox-dick";
				if (rando == 7)
					descript += "pointed shaft";
				if (rando == 8)
					descript += "vulpine member";
				if (rando == 9)
					descript += "vulpine cock";
				if (rando == 10)
					descript += "knotted fox-cock";
			}
		
			if (cockType == CockTypesEnum.HORSE)
			{
				rando = rand(6);
				if (rando == 0)
					descript += "flared horse-cock";
				if (rando == 1)
					descript += "equine prick";
				if (rando == 2)
					descript += "bestial horse-shaft";
				if (rando == 3)
					descript += "flat-tipped horse-member";
				if (rando == 4)
					descript += "animalistic stallion-prick";
				if (rando == 5)
					descript += "equine dong";
				if (rando == 6)
					descript += "beast cock";
				if (rando == 7)
					descript += "flared stallion-cock";
			}
			if (cockType == CockTypesEnum.DEMON)
			{
				rando = int(Math.random() * 11);
				if (rando == 0)
					descript += "nub-covered demon-dick";
				if (rando == 1)
					descript += "nubby shaft";
				if (rando == 2)
					descript += "corrupted cock";
				if (rando == 3)
					descript += "perverse pecker";
				if (rando == 4)
					descript += "bumpy demon-dick";
				if (rando == 5)
					descript += "demonic cock";
				if (rando == 6)
					descript += "demonic dong";
				if (rando == 7)
					descript += "cursed cock";
				if (rando == 8)
					descript += "infernal prick";
				if (rando == 9)
					descript += "unholy cock";
				if (rando == 10)
					descript += "blighted cock";
			}
			if (cockType == CockTypesEnum.TENTACLE)
			{
				rando = int(Math.random() * 11);
				if (rando == 0)
					descript += "twisting tentacle-prick";
				if (rando == 1)
					descript += "wriggling plant-shaft";
				if (rando == 2)
					descript += "sinuous tentacle-cock";
				if (rando == 3)
					descript += "squirming cock-tendril";
				if (rando == 4)
					descript += "writhing tentacle-pecker";
				if (rando == 5)
					descript += "wriggling plant-prick";
				if (rando == 6)
					descript += "penile flora";
				if (rando == 7)
					descript += "smooth shaft";
				if (rando == 8)
					descript += "undulating tentacle-dick";
				if (rando == 9)
					descript += "slithering vine-prick";
				if (rando == 10)
					descript += "vine-shaped cock";
			}
			if (cockType == CockTypesEnum.CAT)
			{
				rando = int(Math.random() * 11);
				if (rando == 0)
					descript += "feline dick";
				if (rando == 1)
					descript += "spined cat-cock";
				if (rando == 2)
					descript += "pink kitty-cock";
				if (rando == 3)
					descript += "spiny prick";
				if (rando == 4)
					descript += "animalistic kitty-prick";
				if (rando == 5)
					descript += "oddly-textured cat-penis";
				if (rando == 6)
					descript += "feline member";
				if (rando == 7)
					descript += "spined shaft";
				if (rando == 8)
					descript += "feline shaft";
				if (rando == 9)
					descript += "barbed dick";
				if (rando == 10)
					descript += "nubby kitten-prick";
			}
			if (cockType == CockTypesEnum.LIZARD)
			{
				rando = int(Math.random() * 11);
				if (rando == 0)
					descript += "reptilian dick";
				if (rando == 1)
					descript += "purple cock";
				if (rando == 2)
					descript += "inhuman cock";
				if (rando == 3)
					descript += "reptilian prick";
				if (rando == 4)
					descript += "purple prick";
				if (rando == 5)
					descript += "purple member";
				if (rando == 6)
					descript += "serpentine member";
				if (rando == 7)
					descript += "serpentine shaft";
				if (rando == 8)
					descript += "reptilian shaft";
				if (rando == 9)
					descript += "bulbous snake-shaft";
				if (rando == 10)
					descript += "bulging snake-dick";
			}
			if (cockType == CockTypesEnum.ANEMONE)
			{
				rando = rand(11);
				if (rando == 0)
					descript += "anemone dick";
				if (rando == 1)
					descript += "tentacle-ringed cock";
				if (rando == 2)
					descript += "blue member";
				if (rando == 3)
					descript += "stinger-laden shaft";
				if (rando == 4)
					descript += "pulsating prick";
				if (rando == 5)
					descript += "anemone prick";
				if (rando == 6)
					descript += "stinger-coated member";
				if (rando == 7)
					descript += "blue cock";
				if (rando == 8)
					descript += "tentacle-ringed dick";
				if (rando == 9)
					descript += "near-transparent shaft";
				if (rando == 10)
					descript += "squirming shaft";
			}
			if (cockType == CockTypesEnum.KANGAROO)
			{
				rando = rand(11);
				if (rando == 0)
					descript += "kangaroo-like dick";
				if (rando == 1)
					descript += "pointed cock";
				if (rando == 2)
					descript += "marsupial member";
				if (rando == 3)
					descript += "tapered shaft";
				if (rando == 4)
					descript += "curved pecker";
				if (rando == 5)
					descript += "pointed prick";
				if (rando == 6)
					descript += "squirming kangaroo-cock";
				if (rando == 7)
					descript += "marsupial cock";
				if (rando == 8)
					descript += "tapered kangaroo-dick";
				if (rando == 9)
					descript += "curved kangaroo-cock";
				if (rando == 10)
					descript += "squirming shaft";
			}
			if (cockType == CockTypesEnum.DRAGON) 
			{
				rando = rand(11);
				if (rando == 0)
					descript += "dragon-like dick";
				if (rando == 1)
					descript += "segmented shaft";
				if (rando == 2)
					descript += "pointed prick";
				if (rando == 3)
					descript += "knotted dragon-cock";
				if (rando == 4)
					descript += "mythical mast";
				if (rando == 5)
					descript += "segmented tool";
				if (rando == 6)
					descript += "draconic dick";
				if (rando == 7)
					descript += "draconic cock";
				if (rando == 8)
					descript += "tapered dick";
				if (rando == 9)
					descript += "unusual endowment";
				if (rando == 10)
					descript += "scaly shaft";
			}
			if(cockType == CockTypesEnum.DISPLACER)
			{
				rando = rand(12);
				if(rando == 0) 
					descript+="coerl cock";
				if(rando == 1) 
					descript+="tentacle-tipped phallus";
				if(rando == 2) 
					descript+="starfish-tipped shaft";
				if(rando == 3) 
					descript+="alien member";
				if(rando == 4) 
					descript+="almost-canine dick";
				if(rando == 5) 
					descript+="bizarre prick";
				if(rando == 6) 
					descript+="beastly cock";
				if(rando == 7) 
					descript+="cthulhu-tier cock";
				if(rando == 8) 
					descript+="coerl cock";
				if(rando == 9) 
					descript+="animal dong";
				if(rando == 10) 
					descript+="star-capped tool";
				if(rando == 11) 
					descript+="knotted erection";
			}

			//trace("Correct Appearance.cockNoun - Produced noun descriptor - ", descript);
			return descript;
		}

		
	}
}