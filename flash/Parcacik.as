package {

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.DisplayObject;

	public class Parcacik extends Shape {

		// Constants:
		var v0;
		var aci;
		var t=0;
		var g=2;
		var ilkx:uint;
		var ilky:uint;

		private var renk:uint=0x5555FF;

		// Initialization:
		public function Parcacik(ilkx_:uint,ilky_:uint, renk: uint  = 0x5555FF) {
			this.ilkx=ilkx_;
			this.ilky=ilky_;
			this.x=ilkx_;
			this.y=ilky_;
			this.renk=renk;
			aci=Math.PI/Math.random()*5;
			v0=Math.random()*10+8;
			var cap=Math.random()*5+3;

			graphics.beginFill(renk);
			graphics.drawCircle(0,0,cap);
			graphics.endFill();
			alpha=0.8;
		}

		public function calculate():void {
			if (alpha>0.0) {
				t=t+0.08;
				this.x=ilkx+v0*Math.cos(aci)*t;
				this.y=ilky-(v0*Math.sin(aci)*t-0.5*g*t*t);
				alpha=alpha-0.007;
			}
		}

	}

}