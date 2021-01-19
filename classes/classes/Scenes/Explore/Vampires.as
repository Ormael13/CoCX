/**
 * ...
 * @author ...
 */
package classes.Scenes.Explore 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
//import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.internals.*;

	public class Vampires extends Monster
	{
		
		public function Vampires()
		{
			{
				this.short = "childe vampire";
				this.long = "";
				this.level = 24;
			}/*
			{
				this.short = "neonate vampire";
				this.long = "";
				this.level = 44;musi być 44 - inne wampiry mogą być na innych levelach
			}
			{
				this.short = "ancillae vampire";
				this.long = "";
				this.level = 64;
			}
			{
				this.short = "elder vampire";
				this.long = "";
				this.level = 84;
			}
			{
				this.short = "methusalah vampire";
				this.long = "";
				this.level = 104;
			}
			{
				this.short = "antediluvian vampire";
				this.long = "";
				this.level = 124;
			}*/
			this.a = "the ";
			// this.plural = false;
		}
	}
}