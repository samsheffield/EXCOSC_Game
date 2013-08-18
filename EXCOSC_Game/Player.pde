class Player extends Sprite{
	float x_velocity, y_velocity, max_velocity;
	float x_direction, y_direction;
	PImage player_image;
	color[] colors = {#ff0000, #00ff00, #0000ff};
	int current_color;
	color c = #000000;

	boolean justPressed;

	Player(float _x, float _y){
		super(_x, _y);
		player_image = loadImage("mrplayer.png");
		addAnimation(player_image, 416, 544);
		pause();

		y_size = 68;
		x_size = 52;
		max_velocity = 5;
		size = x_size;
		x_velocity = 15;
		y_velocity = 15;
	}

	void update(){
		size = x_size;
		if(keyPressed){
			switch (key){
				case 'w' : 
					seek(1); 
					pause(); 
					setYVelocity(-15); 
					break;
				case 's' : 
					seek(0); 
					pause(); 
					setYVelocity(15); 
					break;
				case 'a' : 
					seek(0); 
					pause(); 
					setXVelocity(-15); 
					break;
				case 'd' : 
					seek(0); 
					pause(); 
					setXVelocity(15); 
					break;
				case ' ' : 
					if (current_color < colors.length-1)
						current_color++;
					else
						current_color = 0;
					break;
			}
		}else{
			switch (key){
				case 'w' : setYVelocity(0); break;
				case 's' : setYVelocity(0); break;
				case 'a' : setXVelocity(0); break;
				case 'd' : setXVelocity(0); break;
			}
		}
		c = colors[current_color];

		super.update();
	}

	void grow(){
		x_size+=5;
		y_size+=6;
	}

	void draw(){
		tint(c);
		super.draw();
		noTint();
	}
}