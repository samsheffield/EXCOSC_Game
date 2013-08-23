/*
MenuState

Make a START screen and put it here.
MenuState can be switched to from any other state with switch_state = 0;
*/

class MenuState extends State {
	float start_frame, trigger_frame;
	int switch_title;

	PImage title_image, howto_image;
	MenuState(){
		super();
		switch_state = 1;	// Switch to State 1 (PlayState) when finished
		title_image = loadImage("title.png");
		howto_image = loadImage("instructions.png");
		start_frame = frameCount;
		trigger_frame = 180;
	}

	void draw(){
		super.draw();
		println(trigger_frame + " " + switch_title);
		if(frameCount == start_frame + trigger_frame){
			switch_title++;
			trigger_frame += 180;
		}


		if(switch_title % 2 == 0)
			image(title_image, 0, 0);
		else
			image(howto_image, 0, 0);
		
		textAlign(LEFT, BOTTOM);
		fill(255);
		text("SCORE: " + score, 16, 48);
		textAlign(RIGHT, BOTTOM);
		text("HI SCORE: " + hiscore, 1264, 48);

		if(keyPressed || mousePressed)
			finish = true;
	}
}