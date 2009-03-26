package  {
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.DisplayObject;	
	
	public class EfektTasiyici extends Sprite {
		
		// o sirada ekranda olan efektleri tutar. patlama efekti gibi.
		var efektler:Array=new Array();

		// bu zamanlayici ekrandaki bulunan efektlerin silinmesi icin kullanilir.
		// belli peryotlar ile efektlerin silinmesi gerekip gerekmedigini kontrol eder
		// ve silinecek olanlari efektler dizisinden cikarir. 
		var efektZamanlayici:Timer=new Timer(200);

		public function EfektTasiyici() { 
			efektZamanlayici.addEventListener(TimerEvent.TIMER,efektKontrol,false,0,true);
			efektZamanlayici.start();		
		}
		
		public function sil(efekt:IEfekt) {
			// ActionScript'in adam gibi diziden eleman cikarma destegi yok.
			efektler.splice(efektler.indexOf(efekt),1);
			var ef:DisplayObject=DisplayObject(efekt);
			removeChild(ef);
			ef=null;
		}
		
		public function ekle(efekt:IEfekt) {
			efektler.push(efekt);
			addChild(DisplayObject(efekt));
		}

		// ekrandan silinmesi gereken efektleri kontrol eder.
		private function efektKontrol(event:TimerEvent) {
			var silinecekler:Array=new Array(1);
			for each (var element:IEfekt in efektler) {
				if (element.bittimi()) {
					silinecekler.push(element);
				}
			}
			if (silinecekler!=null) {
				for each (var silinecek:IEfekt in silinecekler) {
					sil(silinecek);
				}
			}
		}		
	}
	
}