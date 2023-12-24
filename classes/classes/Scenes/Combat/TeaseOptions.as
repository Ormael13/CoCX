package classes.Scenes.Combat {
    public class TeaseOptions {
        //Tags used for bonus damage and chance later on
        public var breasts:Boolean = false;
        public var penis:Boolean   = false;
        public var balls:Boolean   = false;
        public var vagina:Boolean  = false;
        public var anus:Boolean    = false;
        public var ass:Boolean     = false;
        //If auto = true, set up bonuses using above flags
        public var auto:Boolean    = true;
        public var damage:Number    = 0;
        public var chance:Number    = 0;
        public var bonusDamage:Number    = 0;
        public var bonusChance:Number    = 0;

        public function TeaseOptions(
            breasts:Boolean = false, 
            penis:Boolean = false,
            balls:Boolean = false,
            vagina:Boolean = false,
            anus:Boolean = false,
            ass:Boolean = false,
            auto:Boolean = true,
            damage:Number = 0,
            chance:Number = 0,
            bonusDamage:Number = 0,
            bonusChance:Number = 0
            ) {
                this.breasts = breasts;
                this.penis = penis;
                this.balls = balls;
                this.vagina = vagina;
                this.anus = anus;
                this.auto = auto;
                this.damage = damage;
                this.chance = chance;
                this.bonusDamage = bonusDamage;
                this.bonusChance = bonusChance;
        }

    }
}


