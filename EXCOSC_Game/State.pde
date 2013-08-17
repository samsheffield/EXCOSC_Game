class State {
	boolean finish;		// When this is set to true, it signals parent class to switch to another state.
	int switch_state;	// Switch to this state when finished (0: Menu, 1: PlayState, 2: EndState)

	State(){
		finish = false;
	}

	void draw(){
		background(0);
	}

}