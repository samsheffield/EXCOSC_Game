class Utilities{
	int current_state;
	int score;
	boolean[] keyboard;

	Utilities(){
		current_state = 0;
		keyboard = new boolean[8];
	}

	boolean overlaps(Sprite _player, Sprite _enemy){
		if(dist(_player.x, _player.y, _enemy.x, _enemy.y) < _player.size/2 + _enemy.size/2)
			return true;
		else
			return false;
	}

	boolean testColor(Player _player, Enemy _enemy){
		PVector _player_color = new PVector(red(_player.c), green(_player.c), blue(_player.c));
		PVector _enemy_color = new PVector(red(_enemy.c), green(_enemy.c), blue(_enemy.c));

		if(_player_color.dist(_enemy_color) < 190)
			return true;
		else
			return false;
	}

	void setKey(int _key){
		switch (_key){
			case 'w': keyboard[0]=true; break;
			case 'a': keyboard[1]=true; break;
			case 's': keyboard[2]=true; break;
			case 'd': keyboard[3]=true; break;
			case 'j': keyboard[4]=true; break;
			case 'k': keyboard[5]=true; break;
			case 'l': keyboard[6]=true; break;
			case ' ': keyboard[7]=true; break;
		}
	}

	void releaseKey(int _key){
		switch (_key){
			case 'w': keyboard[0]=false; break;
			case 'a': keyboard[1]=false; break;
			case 's': keyboard[2]=false; break;
			case 'd': keyboard[3]=false; break;
			case 'j': keyboard[4]=false; break;
			case 'k': keyboard[5]=false; break;
			case 'l': keyboard[6]=false; break;
			case ' ': keyboard[7]=false; break;
		}		
	}

}