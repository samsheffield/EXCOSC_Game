/*
MenuState

Make a START screen and put it here.
MenuState can be switched to from any other state with switch_state = 0;
*/

class MenuState extends State {

	MenuState(){
		super();
		switch_state = 1;	// Switch to State 1 (PlayState) when finished
	}

	void draw(){
		super.draw();
		
		textAlign(CENTER, CENTER);
		fill(#ffffff);
		text("Press any key to start", width/2, height/2);

		// Press any key or click mouse to start
		if(keyPressed || mousePressed)
			finish = true;
	}
}