class Goal extends Sprite{

	PImage goal_image;
	float size;
	int value;

	Goal(float _x, float _y){
		super(_x, _y);
		x_size = 87;
		y_size = 113;
		size = 87;

		goal_image = loadImage("goal.png");
		addAnimation(goal_image, 87, 113);
		pause();
	}

	void update(){
		println(getPlayerOsc(2));
		x = map(getPlayerOsc(0),0,1, 93, 1187);
		y = map(getPlayerOsc(1),0,1, 154, 613);
		c = color(getPlayerOsc(2)*255, getPlayerOsc(3)*255, getPlayerOsc(4)*255);
		super.update();
	}

	void draw(){
		tint(c);
		super.draw();
		noTint();
	}


}