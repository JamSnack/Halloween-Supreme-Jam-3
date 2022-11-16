{
  "spriteId": null,
  "solid": false,
  "visible": true,
  "managed": true,
  "spriteMaskId": {
    "name": "spr_enemy",
    "path": "sprites/spr_enemy/spr_enemy.yy",
  },
  "persistent": false,
  "parentObjectId": {
    "name": "ENTITY_NODE",
    "path": "objects/ENTITY_NODE/ENTITY_NODE.yy",
  },
  "physicsObject": false,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsGroup": 1,
  "physicsDensity": 0.5,
  "physicsRestitution": 0.1,
  "physicsLinearDamping": 0.1,
  "physicsAngularDamping": 0.1,
  "physicsFriction": 0.2,
  "physicsStartAwake": true,
  "physicsKinematic": false,
  "physicsShapePoints": [],
  "eventList": [],
  "properties": [],
  "overriddenProperties": [
    {"propertyId":{"name":"move_speed","path":"objects/entity_enemy/entity_enemy.yy",},"objectId":{"name":"entity_enemy","path":"objects/entity_enemy/entity_enemy.yy",},"value":"0","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"max_hp","path":"objects/entity_enemy/entity_enemy.yy",},"objectId":{"name":"entity_enemy","path":"objects/entity_enemy/entity_enemy.yy",},"value":"250","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"enemy_index","path":"objects/entity_enemy/entity_enemy.yy",},"objectId":{"name":"entity_enemy","path":"objects/entity_enemy/entity_enemy.yy",},"value":"ENEMY.star;","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"torque","path":"objects/entity_enemy/entity_enemy.yy",},"objectId":{"name":"entity_enemy","path":"objects/entity_enemy/entity_enemy.yy",},"value":"0","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"held_treat","path":"objects/entity_enemy/entity_enemy.yy",},"objectId":{"name":"entity_enemy","path":"objects/entity_enemy/entity_enemy.yy",},"value":"CANDY.magic;","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"held_treat_amt_max","path":"objects/entity_enemy/entity_enemy.yy",},"objectId":{"name":"entity_enemy","path":"objects/entity_enemy/entity_enemy.yy",},"value":"2","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"attack_range","path":"objects/entity_enemy/entity_enemy.yy",},"objectId":{"name":"entity_enemy","path":"objects/entity_enemy/entity_enemy.yy",},"value":"0","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"player_damage","path":"objects/entity_enemy/entity_enemy.yy",},"objectId":{"name":"entity_enemy","path":"objects/entity_enemy/entity_enemy.yy",},"value":"0","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"held_treat_amt_min","path":"objects/entity_enemy/entity_enemy.yy",},"objectId":{"name":"entity_enemy","path":"objects/entity_enemy/entity_enemy.yy",},"value":"1","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"targeting_type","path":"objects/entity_enemy/entity_enemy.yy",},"objectId":{"name":"entity_enemy","path":"objects/entity_enemy/entity_enemy.yy",},"value":"TARGET_TYPE.none","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"held_treat_amt","path":"objects/entity_enemy/entity_enemy.yy",},"objectId":{"name":"entity_enemy","path":"objects/entity_enemy/entity_enemy.yy",},"value":"irandom_range(held_treat_amt_min, held_treat_amt_max);","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
  ],
  "parent": {
    "name": "Enemies",
    "path": "folders/Objects/Enemies.yy",
  },
  "resourceVersion": "1.0",
  "name": "entity_star",
  "tags": [],
  "resourceType": "GMObject",
}