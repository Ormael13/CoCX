package classes
{
	import classes.Character;

	public class Appearance
	{

		// Eventually, this should contain the entire char appearance.
		// At the moment, it's pretty piecemeal.

		public static function randomChoice(...args):*
		{
			if ((args.length == 1) && (args[0] is Array))
			{
				var i:Number = int(Math.round(Math.random() * (args[0].length - 1)));
				return args[0][i];
			}
			else 
				throw Error("WUT");
		}

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
			var options:Array;
			var descript:String = "";
			var rando:Number = 0;
			if (cockType == CockTypesEnum.HUMAN)
			{
				// Yeah, this is kind of messy
				// there is no other easy way to preserve the weighting fenoxo did
				options = ["cock",
							"cock",
							"cock",
							"cock",
							"cock",
							"prick",
							"prick",
							"pecker",
							"shaft",
							"shaft",
							"shaft"];
				descript += randomChoice(options);
			}
			if (cockType == CockTypesEnum.DOG)
			{
				options = ["dog-shaped dong",
							"canine shaft",
							"pointed prick",
							"knotty dog-shaft",
							"bestial cock",
							"animalistic puppy-pecker",
							"pointed dog-dick",
							"pointed shaft",
							"canine member",
							"canine cock",
							"knotted dog-cock"];

				descript += randomChoice(options);
			}
			if (cockType == CockTypesEnum.FOX)
			{				
				options = ["fox-shaped dong",
							"vulpine shaft",
							"pointed prick",
							"knotty fox-shaft",
							"bestial cock",
							"animalistic vixen-pricker",
							"pointed fox-dick",
							"pointed shaft",
							"vulpine member",
							"vulpine cock",
							"knotted fox-cock"];
				descript += randomChoice(options);

			}
		
			if (cockType == CockTypesEnum.HORSE)
			{
				options = ["flared horse-cock",
							"equine prick",
							"bestial horse-shaft",
							"flat-tipped horse-member",
							"animalistic stallion-prick",
							"equine dong",
							"beast cock",
							"flared stallion-cock"];
				descript += randomChoice(options);

			}
			if (cockType == CockTypesEnum.DEMON)
			{
				options = ["nub-covered demon-dick",
							"nubby shaft",
							"corrupted cock",
							"perverse pecker",
							"bumpy demon-dick",
							"demonic cock",
							"demonic dong",
							"cursed cock",
							"infernal prick",
							"unholy cock",
							"blighted cock"];
				descript += randomChoice(options);

			}
			if (cockType == CockTypesEnum.TENTACLE)
			{
				options = ["twisting tentacle-prick",
							"wriggling plant-shaft",
							"sinuous tentacle-cock",
							"squirming cock-tendril",
							"writhing tentacle-pecker",
							"wriggling plant-prick",
							"penile flora",
							"smooth shaft",
							"undulating tentacle-dick",
							"slithering vine-prick",
							"vine-shaped cock"];
				descript += randomChoice(options);
			}
			if (cockType == CockTypesEnum.CAT)
			{
				options = ["feline dick",
							"spined cat-cock",
							"pink kitty-cock",
							"spiny prick",
							"animalistic kitty-prick",
							"oddly-textured cat-penis",
							"feline member",
							"spined shaft",
							"feline shaft",
							"barbed dick",
							"nubby kitten-prick"];
				descript += randomChoice(options);
			}
			if (cockType == CockTypesEnum.LIZARD)
			{
				options = ["reptilian dick",
							"purple cock",
							"inhuman cock",
							"reptilian prick",
							"purple prick",
							"purple member",
							"serpentine member",
							"serpentine shaft",
							"reptilian shaft",
							"bulbous snake-shaft",
							"bulging snake-dick"];
				descript += randomChoice(options);
			}
			if (cockType == CockTypesEnum.ANEMONE)
			{
				options = ["anemone dick",
							"tentacle-ringed cock",
							"blue member",
							"stinger-laden shaft",
							"pulsating prick",
							"anemone prick",
							"stinger-coated member",
							"blue cock",
							"tentacle-ringed dick",
							"near-transparent shaft",
							"squirming shaft"];
				descript += randomChoice(options);
			}
			if (cockType == CockTypesEnum.KANGAROO)
			{
				options = ["kangaroo-like dick",
							"pointed cock",
							"marsupial member",
							"tapered shaft",
							"curved pecker",
							"pointed prick",
							"squirming kangaroo-cock",
							"marsupial cock",
							"tapered kangaroo-dick",
							"curved kangaroo-cock",
							"squirming shaft"];
				descript += randomChoice(options);
			}
			if (cockType == CockTypesEnum.DRAGON) 
			{
				options = ["dragon-like dick",
							"segmented shaft",
							"pointed prick",
							"knotted dragon-cock",
							"mythical mast",
							"segmented tool",
							"draconic dick",
							"draconic cock",
							"tapered dick",
							"unusual endowment",
							"scaly shaft"];
				descript += randomChoice(options);
			}
			if(cockType == CockTypesEnum.DISPLACER)
			{
				options = ["coerl cock",
							"tentacle-tipped phallus",
							"starfish-tipped shaft",
							"alien member",
							"almost-canine dick",
							"bizarre prick",
							"beastly cock",
							"cthulhu-tier cock",
							"coerl cock",
							"animal dong",
							"star-capped tool",
							"knotted erection"];
				descript += randomChoice(options);
			}

			//trace("Correct Appearance.cockNoun - Produced noun descriptor - ", descript);
			return descript;
		}

		
	}
}