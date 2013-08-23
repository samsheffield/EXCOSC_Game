class Utilities{
	int color_threshold;

	Utilities(){
		color_threshold = 190;
	}

	// Collision
	boolean overlaps(Sprite _player, Sprite _enemy){
		if(dist(_player.x, _player.y, _enemy.x, _enemy.y) < _player.size/2 + _enemy.size/2)
			return true;
		else
			return false;
	}

	boolean testColor(Sprite _player, Sprite _enemy){
		PVector _player_color = new PVector(red(_player.c), green(_player.c), blue(_player.c));
		PVector _enemy_color = new PVector(red(_enemy.c), green(_enemy.c), blue(_enemy.c));

		if(_player_color.dist(_enemy_color) < color_threshold)
			return true;
		else
			return false;
	}
}