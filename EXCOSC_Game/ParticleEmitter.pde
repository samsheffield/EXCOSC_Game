class ParticleEmitter {

	ArrayList<Particle> p;
	int total_particles;

	ParticleEmitter(float _x, float _y, color _c){
		total_particles = 8;
		p = new ArrayList<Particle>();

		for (int i = 0; i<total_particles; i++){
			p.add(new Particle(_x, _y, _c));
		}

	}

	void update(){
		for (Particle _p : p){
			_p.update();
		}
	}

	void draw(){
		for (Particle _p : p){
			_p.draw();
		}
	}
}