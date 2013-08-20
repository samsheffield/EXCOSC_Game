class Player extends Sprite{
	float max_velocity;
	float x_direction, y_direction;
	PImage player_image;
	int current_color;
	float world_floor;

	color c;

	boolean justPressed;

	boolean invincible;
	boolean[] keyboard;
	int frame;

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
		invincible = true;
		keyboard = new boolean[8];
		world_floor = 672;
		gravity = 5;
	}

	void update(){
		if(keyPressed)
			invincible = false;

		// Reset speed
		//setYVelocity(0);
		setXVelocity(0);

		// UP
		if(keyboard[0]){ 
			setYVelocity(-15); 
		}
		// DOWN
		if(keyboard[2]){ 
			setYVelocity(15); 
		}

		// LEFT
		if(keyboard[1]){
			frame = 0;
			setXVelocity(-15); 
		}

		// RIGHT
		if(keyboard[3]){
			frame = 1;
			setXVelocity(15); 
		}
		
		if(y < 200)
			seek(frame+2);
		else
			seek(frame);


		// Color switching (pretty slow method)
		c = #000000;

		if(keyboard[4])
			c = #ff0000;
		else if(keyboard[5])
			c = #00ff00;
		else if(keyboard[6])
			c = #0000ff;

		if(keyboard[4] && keyboard[5])
			c = #ffff00;
		else if(keyboard[5] && keyboard[6])
			c = #00ffff;
		else if(keyboard[4] && keyboard[6])
			c = #ff00ff;

		if(keyboard[4] && keyboard[5] && keyboard[6])
			c = #ffffff;

		size = x_size;

		super.update();

		if(y+size/1.61 > world_floor){
			y = world_floor-size/1.61;
			gravity = 0;
		}
		else if (y-size/1.61 < 96){
			y = 96+size/1.61;
		}else{
			gravity = 5;
		}
		
		y_velocity += gravity;

		if(x > 1232 - size/2)
			x = 1232-size/2;
		if(x <  48+size/2)
			x = 48+size/2;
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

	void getInput(boolean[] _keyboard){
		arrayCopy(_keyboard, keyboard);
	}
}