/*
EndState

Make a GAME OVER screen and put it here.
EndState can be switched to from any other state with switch_state = 2;
*/

class EndState extends State {

	PImage end_image;

	EndState(){
		super();
		end_image = loadImage("end.png");
		switch_state = 0;
	}

	void draw(){
		super.draw();
		image(end_image, 0, 0);

		textAlign(LEFT, BOTTOM);
		fill(255);
		text("SCORE: " + score, 16, 48);
		textAlign(RIGHT, BOTTOM);
		text("HI SCORE: " + hiscore, 1264, 48);
		
		// Press any key or click mouse to return to 
		if(keyPressed || mousePressed)
			finish = true;
	}
}