package {

	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.TextEvent;

	public class Oyun extends MovieClip {

		// yazilmakta olan kelime bu degiskende tutulur.
		var yazilanKelime:DusenKelime;

		// ekranda gorunen tum kelimeler bu dizide yer alir.
		var dusenKelimeler:Array=new Array();

		// o sirada ekranda olan efektleri tutar. patlama efekti gibi.
		var efektTasiyici:EfektTasiyici=new EfektTasiyici();

		// su anda oynanmakta olan seviye bilgileri.
		var seviye:Seviye;

		// seviyelerin alindigi nesne.
		var kaynak:OyunBilgileri;

		var mesaj:EkranMesaj;

		// bu zamanlayici kelimelerikiun dusus islemini kontrol eder.
		var kelimeZamanlayici:Timer;

		// bu zamanlayici kelimelerin dusme islemini ve hizini kontrol eder.
		var dusmeZamanlayici:Timer;

		var oyunDurdu:Boolean=false;

		var oyunDegerleri:OyunDegerleri = new OyunDegerleri();

		public function Oyun() {
			// oyun baslangicinda seviye-kelime bilgilerini okuyoruz. o is bitince asagidaki
			// basla metodu cagrilir.
			kaynak=new OyunBilgileri(this);
		}

		public function basla() {
			addChild(oyunDegerleri);
			addChild(efektTasiyici);
			// text event kullaniyoruz cunku KeyboardEvent Turkce karakterler ile sorunlu.
			// ayrica focus'un da oyun ekraninda olmasi gerekiyor. yoksa TextEvent uretilemiyor bazi durumlarda.
			this.addEventListener(TextEvent.TEXT_INPUT,tusaBasildi);
			this.addEventListener(MouseEvent.CLICK,click);			
			stage.stageFocusRect=false;			
			stage.focus=this;
			efektTasiyici.ekle(new Kabarciklar());
			yeniSeviye();
		}
		
		// ekranda tiklandiginda odagi ana oyun alanina al. yoksa tus basmalarini yakalayamiyor.
		public function click(event:MouseEvent) {
			stage.focus=this;
		}

		// yeni seviyenin gelisi ile kelime zamanlayicisinin frekansi ve dusme zamnalayicisi
		// seviyeye gore degisir.
		public function yeniSeviye() {
			if(kaynak.seviyeKaldiMi()) {
				seviye=kaynak.yeniSeviye();
			} else {
				// OYUN_TAMAMLANDI!
				zamanlayicilariTemizle();
				kaynak.muzikDur();
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,tusaBasildi);
				dispatchEvent( new OyunOlayi( OyunOlayi.TAMAMLANDI ));
				return;				
			}
			zamanlayicilariTemizle();
			dusmeZamanlayici=new Timer(seviye.dusmeHizi);
			dusmeZamanlayici.addEventListener(TimerEvent.TIMER,dus,false,0,true);
			dusmeZamanlayici.start();
			kelimeZamanlayici=new Timer(seviye.kelimeFrekansi);
			kelimeZamanlayici.addEventListener(TimerEvent.TIMER,yeniKelime,false,0,true);
			kelimeZamanlayici.start();
			efektTasiyici.ekle(new EkranMesaj(kaynak.seviyeAdi(),stage.stageWidth/2,stage.stageHeight/2,100));
		}

		private function zamanlayicilariTemizle() {
			if (kelimeZamanlayici!=null) {
				kelimeZamanlayici.stop();
				kelimeZamanlayici.removeEventListener(TimerEvent.TIMER,yeniKelime);
			}
			if (dusmeZamanlayici!=null) {
				dusmeZamanlayici.stop();
				dusmeZamanlayici.removeEventListener(TimerEvent.TIMER,dus);
			}
		}

		// kelime zamanlayicisinin her tetiklemesinde bu fonksiyon cagrilir.
		public function yeniKelime(event:TimerEvent):void {

			//eger o seviye icin dusecek toplam kelime miktarina erismissek yeni kelime cagirmiyoruz.
			if (seviye.kelimeKaldiMi()==false) {
				return;
			}

			var kel:DusenKelime=new DusenKelime(seviye.yeniKelime());
			//kelimenin x koordinati ekrandan tasmasin ve yukarida aniden olusmasin (y<0 ile)
			kel.x=Math.floor(Math.random()*(stage.stageWidth-kel.genislik()));
			kel.y=-20;
			dusenKelimeler.push(kel);
			addChild(kel);
		}

		//dusme zamanlayicisinin her tetiklenmesinde bu fonksiyon cagrilir.
		public function dus(event:TimerEvent):void {

			for each (var dusen:DusenKelime in dusenKelimeler) {
				dusen.dus();
			}

			// kelime carpti mi?
			if (dusenKelimeler.length>0&&dusenKelimeler[0].dustuMu()) {

				kaynak.yereCarptiSes();
				oyunDegerleri.hayatAzalt();
				if (oyunDegerleri.hayatSayisi()==0) {
					// zamanlayicilari durdur.
					zamanlayicilariTemizle();
					// HAYAT KALMADI, OYUN BITTI..
					kaynak.muzikDur();
					stage.removeEventListener(KeyboardEvent.KEY_DOWN,tusaBasildi);
					dispatchEvent( new OyunOlayi( OyunOlayi.BITTI ));
					return;
				}

				if (dusenKelimeler[0]==yazilanKelime) {
					yazilanKelime=null;
				}
				removeChild(dusenKelimeler[0]);
				dusenKelimeler.shift();
				if (seviye.bittiMi()) {
					yeniSeviye();
				} else {
					seviye.kelimeEksildi();
				}
			}
		}

		private function kelimeSil(kel:DusenKelime) {
			// ActionScript'in adam gibi diziden eleman cikarma destegi yok.
			var index:uint=dusenKelimeler.indexOf(kel);
			dusenKelimeler.splice(index,1);
			removeChild(kel);
			//kel=null;
		}

		private function tusaBasildi(event:TextEvent):void {
			
			var harf:String=event.text;
					
			// oyun durdurma-calistirma kontrolu
			if (harf.charCodeAt(0)==19) {
				if (oyunDurdu) {
					dusmeZamanlayici.start();
					kelimeZamanlayici.start();
					removeChild(mesaj);
					mesaj=null;
					oyunDurdu=false;
				} else {
					dusmeZamanlayici.stop();
					kelimeZamanlayici.stop();
					oyunDurdu=true;
					mesaj=new EkranMesaj("Oyun Durdu",stage.stageWidth/2,stage.stageHeight/2);
					addChild(mesaj);
				}
				return;
			}			

			if (harf==" ") {
				if (oyunDegerleri.jokerKullan()) {
					if (dusenKelimeler.length>0) {
						if (yazilanKelime==dusenKelimeler[0]) {
							yazilanKelime=null;
						}
						kelimeTamamlandi(dusenKelimeler[0]);
					}
				}
				return;
			}
			
			if (yazilanKelime==null) {
				for each (var kel:DusenKelime in dusenKelimeler) {
					if (kel.beklenenKaraktermi(harf)) {
						yazilanKelime=kel;
						yazilanKelime.belirginlestir();
						break;
					}
				}
				// burada hatali harf basilmis demektir. o yuzden cik.
				if (yazilanKelime==null) {
					oyunDegerleri.hataArttir(1);
					return;
				}
			}

			if (yazilanKelime.beklenenKaraktermi(harf)) {
				yazilanKelime.harfBasildi(harf);
				oyunDegerleri.puanArttir(1);
			} else {
				oyunDegerleri.hataArttir(1);
			}

			// kelimenin yazimi bitti ise efekt koy ve kelimeyi ekrandan sil.
			if (yazilanKelime.kelimeBittimi()) {
				oyunDegerleri.hatasizlikArttir();
				if (oyunDegerleri.jokerKazandimi()) {
					oyunDegerleri.jokerArttir();
					oyunDegerleri.puanArttir(10);
					efektTasiyici.ekle(new Patlama(yazilanKelime.merkez(), 0xffff00));
					efektTasiyici.ekle(new Patlama(yazilanKelime.merkez(), 0x00ff00));
				}
				if (oyunDegerleri.hayatKazandimi()) {
					oyunDegerleri.hayatArttir();
					oyunDegerleri.puanArttir(25);
					efektTasiyici.ekle(new Patlama(yazilanKelime.merkez(), 0xff77ee));
					efektTasiyici.ekle(new Patlama(yazilanKelime.merkez(), 0x33ccff));
				}
				kelimeTamamlandi(yazilanKelime);
				yazilanKelime=null;
			}
		}

		public function getOyunDegerleri():OyunDegerleri {
			return oyunDegerleri;
		}

		private function kelimeTamamlandi(kelime:DusenKelime) {
			if (seviye.bittiMi()) {
				yeniSeviye();
			} else {
				seviye.kelimeEksildi();
			}
			kaynak.kelimeBittiSes();
			efektTasiyici.ekle(new Patlama(kelime.merkez()));
			kelimeSil(kelime);
		}

	}
}