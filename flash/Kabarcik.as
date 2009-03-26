package  {
	
	import flash.display.Shape;

	public class Kabarcik extends Shape {

		var artim:Number;
		private var renk;

		// Initialization:
		public function Kabarcik( renk: uint  = 0xeeffff) {
			this.renk=renk;
			this.y = - Math.random()* 520;
			ciz();
		}

        private function ciz() {			
			this.x = Math.random()* 400;
			var cap=Math.random()*3+2;
			artim=Math.random()*3+0.5;			
			graphics.clear();
			graphics.beginFill(renk);
			graphics.drawCircle(0,0,cap);
			graphics.endFill();
			alpha=Math.random()/4+0.1;
		}

		public function calculate():void {
			if(this.y>520) {
				this.y=0;
			 	ciz();
			}
			var cap=Math.random()*36; 
			if(cap>30) {
				if(cap<33)
				   this.x= this.x-1;
				else    
				   this.x= this.x+1;
			}
			this.y = this.y+artim;   
		}
	}	
}