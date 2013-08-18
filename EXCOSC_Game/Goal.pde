class Goal extends Sprite{

	PImage goal_image;
	float x, y, size;
	int value;

	Goal(float _x, float _y){
		super(_x, _y);
		x_size = 89;
		y_size = 115;
		size = 89;

		goal_image = loadImage("goal.png");
		addAnimation(goal_image, 89, 115);
		pause();
	}

	void update(){
		super.update();
	}

	void draw(){
		super.draw();
	}
}