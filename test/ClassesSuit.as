package {
	import classes.HelperSuit;
	import classes.ScenesSuit;

	import classes.CreatureTest;
	import classes.CoCTest;
	import classes.CharSpecialTest;
	import classes.CharCreationTest;
	import classes.MonsterTest;

[Suite]
[RunWith("org.flexunit.runners.Suite")]
	public class ClassesSuit
	{
		 public var helperSuit:HelperSuit;
		 public var scenesSuit:ScenesSuit;
		
		 public var coCTest:CoCTest;
		 public var charSpecialTest:CharSpecialTest;
		 public var charCreationTest:CharCreationTest; 
		 public var monsterTest:MonsterTest;
		 public var creaturTest:CreatureTest;
	}
}