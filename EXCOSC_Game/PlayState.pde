/*
PlayState

Make a game and put it here.
PlayState can be switched to from any other state with switch_state = 1;
*/

class PlayState extends State {
	PlayState(){
		super();
		switch_state = 2;
	}

	void draw(){
		super.draw();

		// When finished...
		// finish = true;
	}
}