class Enemy extends Sprite{
	PImage enemy_image;
	int type;
	float floater;
	float p_x, p_y;
	float x_direction, y_direction;
	float r_speed;
	float floaty_spread;

	boolean p_invincible;
	boolean stuck;

	Enemy(float _x, float _y, int _type){
		super(_x, _y);
		x_size = 64;
		y_size = 64;
		size = 64;
		radius = size/2;
		type = _type;
		min_x = 48+(radius);
		max_x = 1232-(radius);
		min_y = 96+radius;
		max_y = 672-(radius);
		gravity = 5;

		enemy_image = loadImage("enemies.png");
		addAnimation(enemy_image, 64,64);
		seek(type);

		if(int(random(2)) == 0)
			x_direction = -1;
		else
			x_direction = 1;

		if(int(random(2)) == 0)
			y_direction = -1;
		else
			y_direction = 1;

		c = color(random(255), random(255), random(255));

		switch (type){
			case 0 : straightMovement(1, 10); break;
			case 1 : angularMovement(10, 20); break;
			case 2 : angularMovement(2, 10); break;
			case 3 : angularMovement(2, 5); break;
		}

	}

	void update(){
		super.update();
		c = color(getEntityOsc(type, 2)*255, getEntityOsc(type, 3)*255, getEntityOsc(type, 4)*255);

		switch (type){
			case 0 : bounce(); break;
			case 1 : bounce(); rotate(10); break;
			case 2 : bounce(); rotate(5); break;
			case 3 : wrap(); faceMovement(); break;
			case 4 : drop(); stick(); break;
			case 5 : floaty(); rotate(3); wrap(); break;
			case 6 : moveToward(); rotate(r_speed); stick(); break;
			case 7 : jump(); faceMovement(); break;
		}
	}

	void draw(){
		tint(c);
		super.draw();
		noTint();
	}

	void faceMovement(){
		flip = true;
	}

	void respawn(Cloud _cloud){
		x = _cloud.x;
		y = _cloud.y;
		stuck = false;
		_cloud.activate();
	}

	void bounce(){
		if (x < min_x || x > max_x)
			setXVelocity(x_velocity*-1);
			
		if (y < min_y || y > max_y)
			setYVelocity(y_velocity*-1);
	}

	void wrap(){
		if (x < -(radius))
			x = (width+(radius))-1;

		if (x > width+(radius))
			x = -(radius)+1;
			
		if (y < -(radius))
			y = (height+(radius))-1;

		if(y > height+(radius))
			y = -(radius)+1;
	}

	void stick(){
		if(y > max_y){
			setXVelocity(0);
			setYVelocity(0);
			y = max_y;
			stuck = true;
		}
		else if(y < min_y){
			setXVelocity(0);
			setYVelocity(0);
			y = min_y;
			stuck = true;
		}

		if (x < min_x){
			setXVelocity(0);
			setYVelocity(0);
			x = min_x;
			stuck = true;
		}
		else if (x > max_x){
			setXVelocity(0);
			setYVelocity(0);
			x = max_x;
			stuck = true;
		}
	}

	void rotate(float _r_speed){
		rotating = true;
		rotation += _r_speed;
	}

	void angularMovement(float _min_speed, float _max_speed){
		setXVelocity(random(_min_speed, _max_speed)*x_direction);
		setYVelocity(random(_min_speed, _max_speed)*y_direction);
	}

	void straightMovement(float _min_speed, float _max_speed){
		if(int(random(2)) == 0)
			setXVelocity(random(_min_speed, _max_speed)*x_direction);
		else
			setYVelocity(random(_min_speed, _max_speed)*y_direction);
	}

	void drop(){
		setYVelocity(40);
	}

	void floaty(){
		if(floaty_spread > -.00001)
			floaty_spread = -.005;

		floaty_spread += .00001;

		floater += floaty_spread;

		setXVelocity(sin(floater));
		setYVelocity(cos(floater));
	}

	void moveToward(){
		if(p_invincible){
			r_speed = 3;
		}
		else{
			if(!stuck){
				if(frameCount % 2 == 0){
					if (x != p_x)
						x_velocity += (p_x-x)/400;
					if (y != p_y)
						y_velocity += (p_y-y)/400;
				}
			}
			r_speed = x_velocity*y_velocity*.125;
		}
	}

	void jump(){
		if(y > max_y){
			y = max_y;
			setXVelocity(random(-10, 10));
			setYVelocity(random(-70, -20));
		}
		else if (y < min_y){
			y = min_y;
		}
		
		if(x > max_x)
			x = max_x;
		if(x <  min_x)
			x = min_x;

		y_velocity += gravity;
	}

}