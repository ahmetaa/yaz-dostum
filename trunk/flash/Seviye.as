package {

	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.Event;

	public class Seviye {

		var tumKelimeler:Array = new Array();
		var kaybolanKelimeSayisi:int;
		var toplamKelimeSayisi:int;
		var kelimeFrekansi:int;
		var dusmeHizi:int;
		var dusenKelimeSayisi:int;
		var rasgele:Boolean;
		var siraSayaci=0;

		public function Seviye(tumKelimeler:Array, toplamKelime:int, kelimeFrekansi:int, dusmeHizi:int, ras:uint) {
			this.tumKelimeler=tumKelimeler;
			if(ras==0)
			  this.rasgele=false;
			else
			  this.rasgele=true;
			this.toplamKelimeSayisi=toplamKelime;			
			if(rasgele==false) {
				this.toplamKelimeSayisi=tumKelimeler.length;
			}
			this.kelimeFrekansi=kelimeFrekansi;
			this.dusmeHizi=dusmeHizi;
			dusenKelimeSayisi=0;
			kaybolanKelimeSayisi=0;
		}

		public function kelimeKaldiMi():Boolean {
			if (dusenKelimeSayisi<toplamKelimeSayisi) {
				return true;
			} else {
				return false;
			}
		}

		public function yeniKelime():String {
			dusenKelimeSayisi++;
			if(rasgele==true)
				return tumKelimeler[Math.floor( Math.random()*tumKelimeler.length)];
			else {
				return tumKelimeler[siraSayaci++];				
			}			
		}

		public function kelimeEksildi() {
			kaybolanKelimeSayisi++;
		}

		public function bittiMi():Boolean {
			if (kaybolanKelimeSayisi==toplamKelimeSayisi-1) {
				return true;
			} else {
				return false;
			}
		}
	}
}