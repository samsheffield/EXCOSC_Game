class Game {

	ArrayList<State> state;
	Utilities utilities;
	int score, hiscore;
	PFont font;

	float[] player_osc = new float[6];
	float[][] entity_osc = new float[8][5];

	Game(){
		state = new ArrayList<State>();
		state.add(new MenuState());
		utilities = new Utilities();
		font = loadFont("score_text_30.vlw");
		textFont(font, 30);
	}

	void play(){
		for (int i = state.size()-1; i >= 0; i--){
			if(state.get(i).finish){
				switch (state.get(i).switch_state){
					case 0 : state.add(new MenuState()); state.get(i+1).hiscore = hiscore; break;
					case 1 : state.add(new PlayState()); state.get(i+1).score = score; state.get(i+1).hiscore = hiscore; break;
					case 2 : state.add(new EndState()); state.get(i+1).score = score; state.get(i+1).hiscore = hiscore; break;
				}
				state.remove(state.get(i));
			}
			else {
				arrayCopy(utilities.keyboard, state.get(i).utilities.keyboard);
				score = state.get(i).score;
				if(score > hiscore)
					hiscore = score;
				state.get(i).draw();
			}
		}
	}

	void setPlayerOSC(float[] _player_osc){
		arrayCopy(_player_osc, player_osc);
	}

	void setEntityOSC(float[][] _entity_osc){
		arrayCopy(_entity_osc, entity_osc);
	}
}