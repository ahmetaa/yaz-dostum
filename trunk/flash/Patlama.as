package {

	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class Patlama extends Sprite implements IEfekt {

		var parcaciklar:Array=new Array();
		var zamanlayici:Timer;
		// Initialization:
		public function Patlama(p:Point, renk: uint  = 0x5555FF) {
			for (var i:uint = 0; i<10; i++) {
				var par:Parcacik=new Parcacik(p.x,p.y, renk);
				addChild(par);
				parcaciklar.push(par);
			}
			zamanlayici=new Timer(15,300);
			zamanlayici.addEventListener(TimerEvent.TIMER, tick);
			zamanlayici.start();
		}

		public function tick(event:TimerEvent):void {
			for each (var p:Parcacik in parcaciklar) {
				p.calculate();
			}
		}

		public function bittimi():Boolean {
			if (zamanlayici==null) {
				return false;
			}
			if (zamanlayici.running) {
				return false;
			} else {
				return true;
			}

		}
	}
}