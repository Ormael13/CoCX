		//Calls are now made through CoC.instance rather than thisPtr. This allows the compiler to detect if/when a function is inaccessible.
		import classes.CoC;
		import classes.CoC;
        import classes.Scenes.SceneLib;

        // PRONOUNS: The parser uses Elverson/Spivak Pronouns specifically to allow characters to be written with non-specific genders.
		// http://en.wikipedia.org/wiki/Spivak_pronoun
		//
		// Cheat Table:
		//           | Subject    | Object       | Possessive Adjective | Possessive Pronoun | Reflexive         |
		// Agendered | ey laughs  | I hugged em  | eir heart warmed     | that is eirs       | ey loves emself   |
		// Masculine | he laughs  | I hugged him | his heart warmed     | that is his        | he loves himself  |
		// Feminine  | she laughs | I hugged her | her heart warmed     | that is hers       | she loves herself |

		// (Is it bad that half my development time so far has been researching non-gendered nouns? ~~~~Fake-Name)


		public var arianLookups:Object = // For subject: "arian"
		{
			"man"		: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.arianScene.arianMF("man","woman")},
			// argh! "Man" is the mass-noun for humanity, and I'm loathe to choose an even more esoteric variant.
			// Elverson/Spivak terminology is already esoteric enough, and it lacks a ungendered mass noun.

			"ey"		: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.arianScene.arianMF("he","she")},
			"em"		: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.arianScene.arianMF("him","her")},
			"eir"		: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.arianScene.arianMF("his","her")},
			"eirs"		: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.arianScene.arianMF("his","hers")},
			"emself"	: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.arianScene.arianMF("himself","herself")},

			"chestadj"	: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.arianScene.arianChestAdjective()},
			"chest"		: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.arianScene.arianChest()}
		};
		// Arian unhandled terms (I have not decided how to support them yet):
		// arianMF("mas","mis")
		// arianMF("master","mistress")
		// arianMF("male","girly")



		public var rubiLookups:Object = // For subject: "rubi"
		{
			"man"		: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.telAdre.rubi.rubiMF("man","woman")},

			"ey"		: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.telAdre.rubi.rubiMF("he","she")},
			"em"		: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.telAdre.rubi.rubiMF("him","her")},
			"eir"		: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.telAdre.rubi.rubiMF("his","her")},
			"eirs"		: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.telAdre.rubi.rubiMF("his","hers")},
			"emself"	: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.telAdre.rubi.rubiMF("himself","herself")},

			"cock"		: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.telAdre.rubi.rubiCock()},
			"breasts"	: function(thisPtr:CoC):String {return classes.Scenes.SceneLib.telAdre.rubi.rubiBreasts()}

		};
		//Rubi unhandled terms :
		// rubiMF("boy","girl")
		// rubiMF("demon","demoness")
		// rubiMF("gentleman","lady")
