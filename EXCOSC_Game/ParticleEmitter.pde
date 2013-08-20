class ParticleEmitter {

	Particle[] p;
	int total_particles;

	ParticleEmitter(float _x, float _y, color _c){
		total_particles = 8;
		p = new Particle[total_particles];

		for (int i = 0; i<p.length; i++){
			p[i] = new Particle(_x, _y, _c);
		}

	}

	void update(){
		for (int i = 0; i<p.length; i++){
			p[i].update();
		}
	}

	void draw(){
		for (int i = 0; i<p.length; i++){
			p[i].draw();
		}
	}
}