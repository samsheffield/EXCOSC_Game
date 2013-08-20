/*
PlayState

Make a game and put it here.
PlayState can be switched to from any other state with switch_state = 1;
*/

class PlayState extends State {
	Player p1;
	ArrayList<Enemy> enemies;
	ArrayList<Cloud> clouds;
	Goal goal;
	PImage stage;

	int door_score;
	boolean done;
	PlayState(){
		super();
		switch_state = 2;

		clouds = new ArrayList<Cloud>();
		for (int i = 0; i<8; i++){
			clouds.add(new Cloud(random(200, 800), random(200, 500)));
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

		p1.update();
		p1.getInput(utilities.keyboard);
		p1.draw();

		for (int i = enemies.size()-1; i >=0; i--){
			enemies.get(i).update();
			enemies.get(i).draw();

			if(!p1.invincible){
				if(utilities.overlaps(p1, enemies.get(i))){
					if(utilities.testColor(p1, enemies.get(i))){
						enemies.get(i).respawn(clouds.get(i));
						p1.grow();
						door_score++;
					}
					else{
						finish = true;
					}
				}	
			}	
		}

		if(utilities.overlaps(p1, goal) && !p1.invincible){
			if(done)
				finish = true;
			score += door_score;
			switch_state = 1;
			done = true;
		}
		textAlign(LEFT, BOTTOM);
		fill(0);
		text("SCORE: " + score, 16, 48);
		textAlign(RIGHT, BOTTOM);
		text("HI SCORE: " + hiscore, 1264, 48);
	}
}