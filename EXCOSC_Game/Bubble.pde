class Bubble extends Sprite{

	PImage bubble_image;
	boolean active;
	float p_x, p_y;

	Bubble(float _x, float _y) {
		super(_x, _y);
		bubble_image = loadImage("bubble.png");
		addAnimation(bubble_image, 100, 100);
		pause();
		x_size = 92;
		y_size = 92;
		size = 92;
	}

	void update(){
		super.update();

		if(active){
			x = p_x;
			y = p_y;
		}
		else{
			x = -300;
			y = -300;
		}	
	}

	void draw(){
		super.draw();
	}
}