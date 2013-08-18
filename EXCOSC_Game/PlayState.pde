/*
PlayState

Make a game and put it here.
PlayState can be switched to from any other state with switch_state = 1;
*/

class PlayState extends State {
	Player p1;
	ArrayList<Enemy> enemies;
	Utilities utilities;
	Goal goal;

	PlayState(){
		super();
		switch_state = 2;
		p1 = new Player(width/2, height/2);

		enemies = new ArrayList<Enemy>();
		for (int i = 0; i<8; i++){
			enemies.add(new Enemy(random(33, width-33), random(33, height-33)));
		}
		utilities = new Utilities();
		goal = new Goal(random(width), 180);
	}

	void draw(){
		super.draw();

		background(#ddfaf8);

		goal.update();
		goal.draw();

		p1.update();
		p1.draw();

		for (int i = enemies.size()-1; i >=0; i--){
			enemies.get(i).update();
			enemies.get(i).draw();

			if(utilities.overlaps(p1, enemies.get(i))){
				if(utilities.testColor(p1, enemies.get(i))){
					enemies.get(i).respawn();
					p1.grow();
				}
				else{
					println("HIT");
				}
			}	

			if(utilities.overlaps(p1, goal)){
				finish = true;
			}
				
		}
		
		// When finished...
		// finish = true;
	}
}