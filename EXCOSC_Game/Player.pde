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

		if(keyboard[0]){
			seek(1); 
			setYVelocity(-15); 
		}

		if(keyboard[2]){
			seek(0); 
			setYVelocity(15); 
		}

		if(keyboard[1]){
			seek(0); 
			setXVelocity(-15); 
		}

		if(keyboard[3]){
			seek(0); 
			setXVelocity(15); 
		}

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
			c = #eeeeee;

		size = x_size;

		println(y_velocity);

		

		super.update();
		if(y+size/1.61 <= world_floor)
			y_velocity += gravity;
		else
			y = world_floor-size/1.61;

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