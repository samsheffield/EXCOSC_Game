/*
PlayState

Make a game and put it here.
PlayState can be switched to from any other state with switch_state = 1;
*/

class PlayState extends State {
	Player p1;
	Bubble bubble;
	Goal goal;
	Utilities utilities;

	ArrayList<Enemy> enemies;
	ArrayList<Cloud> clouds;
	ArrayList<ParticleEmitter> particle_emitters;
	ArrayList<ParticleEmitter> p1_particle_emitters;

	PImage stage;
	int door_score;
	boolean done;

	PlayState(){
		super();
		switch_state = 2;

		clouds = new ArrayList<Cloud>();
		for (int i = 0; i<8; i++){
			clouds.add(new Cloud(random(200, 800), random(200, 500), i));
		}

		enemies = new ArrayList<Enemy>();
		for (int i = 0; i<8; i++){
			enemies.add(new Enemy(random(81, 1199), random(129, 639), i));
			enemies.get(i).respawn(clouds.get(i));
		}

		PVector player_start = new PVector(random(81, 1199), 180, 0);

		goal = new Goal(player_start.x, player_start.y);
		p1 = new Player(player_start.x, player_start.y);
		stage = loadImage("stage.png");

		particle_emitters = new ArrayList<ParticleEmitter>();
		p1_particle_emitters = new ArrayList<ParticleEmitter>();
		bubble = new Bubble(p1.x, p1.y);

		utilities = new Utilities();
	}

	void draw(){
		super.draw();
		background(255);
		image(stage,0,0);

		for (Cloud _cloud : clouds){
			_cloud.update();
			_cloud.draw();
		}
		goal.update();
		goal.draw();
		textAlign(CENTER, CENTER);
		fill(255);
		text(door_score, goal.x, goal.y+20);

		for (int i = enemies.size()-1; i >=0; i--){
			enemies.get(i).p_invincible = p1.invincible;
			enemies.get(i).p_x = p1.x;
			enemies.get(i).p_y = p1.y;
			enemies.get(i).update();
			enemies.get(i).draw();

			sendOsc("/entity"+i+"/position/x", map(enemies.get(i).x, 0, width, 0, 1));
			sendOsc("/entity"+i+"/position/y", map(enemies.get(i).y, 0, height, 0, 1));
			sendOsc("/entity"+i+"/colour/r", map(red(enemies.get(i).c), 0, 255, 0, 1));
			sendOsc("/entity"+i+"/colour/g", map(green(enemies.get(i).c), 0, 255, 0, 1));
			sendOsc("/entity"+i+"/colour/b", map(blue(enemies.get(i).c), 0, 255, 0, 1));

			if(p1.dead)
				finish = true;

			if(!p1.invincible){
				if(utilities.overlaps(p1, enemies.get(i)) && !p1.killed){
					if(utilities.testColor(p1, enemies.get(i))){
						particle_emitters.add(new ParticleEmitter(enemies.get(i).x, enemies.get(i).y, enemies.get(i).c, 8));
						enemies.get(i).respawn(clouds.get(i));
						p1.grow();
						door_score+=10;
					}
					else{
						if(!p1.killed){
							p1.kill(millis());
							p1_particle_emitters.add(new ParticleEmitter(p1.x, p1.y, p1.c, score+1));
						}
					}
				}	
			}	
		}

		for (int i = particle_emitters.size()-1; i >=0; i--){
			particle_emitters.get(i).update();
			particle_emitters.get(i).draw();

			for (int j = particle_emitters.get(i).p.size()-1; j>= 0; j--){
				if(utilities.overlaps(p1, particle_emitters.get(i).p.get(j))){
					//particle_emitters.remove(particle_emitters.get(i));
					if(utilities.testColor(p1, particle_emitters.get(i).p.get(j))){
						particle_emitters.get(i).p.remove(particle_emitters.get(i).p.get(j));
						score++;
					}
				}
			}
		}

		for (int i = p1_particle_emitters.size()-1; i >=0; i--){
			p1_particle_emitters.get(i).update();
			p1_particle_emitters.get(i).draw();
		}

		p1.update();
		p1.draw();

		if(p1.invincible){
			bubble.active = true;
			bubble.p_x = p1.x;
			bubble.p_y = p1.y;
		}
		else{
			bubble.active = false;
		}

		bubble.update();
		bubble.draw();

		if(utilities.overlaps(p1, goal) && !p1.invincible){
			if(utilities.testColor(p1, goal)){
				if(done)
					finish = true;
				score += door_score;
				switch_state = 1;
				done = true;
			}
		}

		addScore(0);

		sendOsc("/player/position/x", map(p1.x, 0, width, 0, 1));
		sendOsc("/player/position/y", map(p1.y, 0, height, 0, 1));
		sendOsc("/player/colour/r", map(red(p1.c), 0, 255, 0, 1));
		sendOsc("/player/colour/g", map(green(p1.c), 0, 255, 0, 1));
		sendOsc("/player/colour/b", map(blue(p1.c), 0, 255, 0, 1));
		sendOsc("/player/trigger", p1.trigger);
	}
}