
class CollisionDetect {
  static narrowPhase(player, obj) {
    var playerTop_ObjBottom = (player.position.y - (obj.y + obj.size.y)).abs();
    var playerRight_ObjLeft = ((player.position.x + player.size.x) - obj.position.x).abs();
    var playerLeft_ObjRight = (player.position.x - (obj.position.x + obj.size.x)).abs();
    var playerBottom_ObjTop = ((player.position.y + player.size.y) - obj.position.y).abs();

    if ((player.position.y <= obj.position.y + obj.size.y && player.position.y + player.size.y > obj.position.y + obj.size.y) && (playerTop_ObjBottom < playerRight_ObjLeft && playerTop_ObjBottom < playerLeft_ObjRight)) {
      player.position.y = obj.position.y + obj.size.y;
      player.velocity.y = 0.0;
    }
    if ((player.position.y + player.size.y >= obj.position.y && player.position.y < obj.position.y) && (playerBottom_ObjTop < playerRight_ObjLeft && playerBottom_ObjTop < playerLeft_ObjRight)) {
      player.position.y = obj.position.y - player.size.y;
      player.velocity.y = 0.0;
    }
    if ((player.position.x + player.size.x >= obj.position.x && player.position.x < obj.position.x) && (playerRight_ObjLeft < playerTop_ObjBottom && playerRight_ObjLeft < playerBottom_ObjTop)) {
      player.position.x = obj.position.x - player.size.x;
      player.velocity.x = 0.0;
    }
    if ((player.position.x <= obj.position.x + obj.size.x && player.position.x + player.size.x > obj.position.x + obj.size.x) && (playerLeft_ObjRight < playerTop_ObjBottom && playerLeft_ObjRight < playerBottom_ObjTop)) {
      player.position.x = obj.position.x + obj.size.x;
      player.velocity.x = 0.0;
    }
  }
}
