package {

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;	
	import flash.geom.Point;	
	import flash.display.DisplayObject;	

	public class OyunBittiEkrani extends MovieClip {

		// o sirada ekranda olan efektleri tutar. patlama efekti gibi.
		var efektTasiyici:EfektTasiyici=new EfektTasiyici();

		public function OyunBittiEkrani() {
			addChild(efektTasiyici);
			yenidenBaslaDugmesi.addEventListener(MouseEvent.CLICK,yenidenBaslayaTiklandi,false,0,true);
		}

		function yenidenBaslayaTiklandi(mouseEvent:MouseEvent) {
			dispatchEvent( new NavigationEvent( NavigationEvent.RESTART ) );
		}

		public function setPuan( puanDegeri:Number ):void {
			puan.text=puanDegeri.toString();
		}
		
		public function setHata( hataDegeri:Number ):void {
			hata.text=hataDegeri.toString();
		}		
		
		public function setMesaj( m:String ):void {
			mesaj.text=m;
		}				

		public function efekt():void {
			var t:Timer = new Timer(500, 50);
			t.addEventListener(TimerEvent.TIMER, tick);			
			t.start();
		}				
		
		private function tick(event:TimerEvent):void {
			efektTasiyici.ekle(new Patlama(new Point(Math.random()*400, Math.random()*520) , 0xff9900));
			efektTasiyici.ekle(new Patlama(new Point(Math.random()*400, Math.random()*520) , 0x00ff77));
        }
	}
}