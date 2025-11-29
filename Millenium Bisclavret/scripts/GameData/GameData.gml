global.actionLibrary =
{
    attack: {
        name: "Strike",
        description: "{0} Struck!",
        subMenu: -1,
        targetRequired: true,
        targetEnemyByDefault: true,
        targetAll: MODE.NEVER,
        effectSprite: sAttack,
        effectOnTarget: MODE.ALWAYS,
        func: function(_user, _targets) {
            var _damage=ceil(_user.strength);
            BattleChangeHP(_targets[0],-_damage,0);
        }
    }
}

enum MODE {
    NEVER=0,
    ALWAYS=1,
    VARIES=2
}


global.player = [
    {
        name: "Bisclavret",
        hp: 3,
        hp_max: 3,
        strength: 1,
        sprites: {idle: battle_player},
        actions: []
        
    }
]

global.enemies = {
    renee: {
        name: "Renée",
        hp: 5,
        hp_max: 5,
        strength: 1,
        sprites: {idle: battle_renee},
        actions: [global.actionLibrary.attack],
        AIscript : function() {
            //attack random target (alaways bisclavret)
            var _action = actions[0];
            var _possibleTargets=array_filter(oBattle.playerUnits, function(_unit, _index) {
                return(_unit.hp>0);
            });
            var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
            return [_action, _target];
        }
    },
    letheque: {
        name: "LeThèque",
        hp: 6,
        hp_max: 6,
        strength: 1,
        sprites: {idle: battle_enemy},
        actions: [global.actionLibrary.attack],
        AIscript : function() {
            
        }
    },
    guarin: {
        name: "Guarin",
        hp: 8,
        hp_max: 8,
        strength: 1,
        sprites: {idle: battle_enemy},
        actions: [global.actionLibrary.attack],
        AIscript : function() {
            
        }
    },
}