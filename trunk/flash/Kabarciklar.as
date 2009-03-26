package  {
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class Kabarciklar extends Sprite implements IEfekt {

		var kabarciklar:Array=new Array();
		var zamanlayici:Timer;
		// Initialization:
		public function Kabarciklar(renk: uint  = 0xeeffff) {
			for (var i:uint = 0; i<20; i++) {
				var par:Kabarcik=new Kabarcik(renk);
				addChild(par);
				kabarciklar.push(par);
			}
			zamanlayici=new Timer(80);
			zamanlayici.addEventListener(TimerEvent.TIMER, tick,false,0,true);
			zamanlayici.start();
		}

		public function tick(event:TimerEvent):void {
			for each (var p:Kabarcik in kabarciklar) {
				p.calculate();
			}
		}

		public function bittimi():Boolean {
 			return false;
		}
	}
}