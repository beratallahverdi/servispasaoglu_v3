import 'package:shared_preferences/shared_preferences.dart';

class ServisPasaogluData {
  static final Future<SharedPreferences> sharedPrefs =
      SharedPreferences.getInstance();

  static final info = {
    "companyLogo": "assets/images/pasaoglu.png",
    "companyName": "Servis PAŞAOĞLU",
    "companyAddress":
        "Atatürk Oto Sanayi Sitesi 2. Kısım 34. Sokak 1396 – 1397 Maslak / İSTANBUL",
    "companyTelephone": "tel:+902122764169",
    "companyEmail": "mailto:info@servispasaoglu.com.tr",
    "companyWebsite": "https://www.servispasaoglu.com.tr",
    "companyFaxNumber": "02122766091",
    "companyGoogleMaps":
        "https://www.google.com/maps/place/SERVICE+PA%C5%9EAO%C4%9ELU/@41.1177141,29.0209282,16z/data=!3m1!5s0x14cab5bd68a91717:0x91cda2abbf20e940!4m13!1m7!3m6!1s0x14cab5bd69210511:0xc048441edb69345d!2zTWFzbGFrLCAzNC4gU2suIDEzOTUtMTQwNiwgMzQzOTggxZ5pxZ9saS_EsHN0YW5idWw!3b1!8m2!3d41.11998!4d29.0217929!3m4!1s0x14cab5bd6bc533d3:0xf15a585d69b6a86f!8m2!3d41.1199907!4d29.0217164",
    "companyAbout":
        "1990 yılında faaliyetlerine başlayıp, bugünlere gelen Team Paşaoğlu, bir aile şirketi olup konusunda uzman ve deneyimli kadrosuyla hizmetlerine devam etmektedir. Atmosferik veya aşırı besleme her türlü mekanik ve elektronik motor modifiyesini aracınıza uygulamaktadır.Motor modifiyesine paralel olarak bu artan gücün yere doğru ve mümkün olduğunca eksiksiz aktarımında otomobillerin en önemli parçaları olan şanzıman ve diferansiyel oranlarının istekleriniz dahilinde, kullanım amacına ( Drag, Rally, Pist Şampiyonası, Time trail, Rolling v.b. ) uygun şekilde hesaplanması ve bu amaç da aracınıza uygun parça teminlerini ve montaj işlemlerini gerçekleştirmektedir.",
    "companyMissionText":
        "Araştırma ve geliştirmeye önem veren, mevcut teknoloji ile en iyi kalite ürünleri ve en iyi servis hizmetini müşterilerine sunmak, en iyi test ve yazılım programlarını kullanarak, kaliteden ödün vermeden yoluna devam etmeyi görev edinmiştir.",
    "companyVisionText":
        "Çalışanlarımızla birlikte, kaliteli imalat tekniklerini uygulamak, projelerimizde farklılık ve yenilikler yaratarak, bu farklılığı müşteri memnuniyeti doğrultusunda geliştiren yenilikçiliği özümsemiş uluslar arası alanda sektöründe öncü ve başarılarıyla adını duyurabilen bir firma olmak.",
  };
  static final home = {
    "pageHeader":
        "Atmosferik ve aşırı besleme her türlü mekanik ve elektronik motor modifiyesi (chip tuning); uygulanmakta olan motor modifiyesine paralel olarak amaca uygun farklı oranlı şanzıman ve diferansiyel oranları, drag, rally ve pist yarışlarına araç hazırlanması, bakımlarının yapılması ve servis hizmetlerinin sağlanması gibi işlemleri yapıyoruz. Performansa yönelik araç bakım ve onarım işleri, elektronik test ekipmanları ile arıza tespiti, araç şasi dinamometresi ile de araçların güç ve tork eğrilerindeki ölçümlerinin yapılması, güç kayıplarının hesaplanması gibi ihtiyaçlarınıza cevap veriyoruz.",
    "pageServicesMekanikServis":
        "Tüm mekanik bakım ve özelleştirme hizmetimiz alanında uzmanlaşmış personelimiz ile gerçekleştirilir. Dünyada kabul görmüş en iyi parçaları kullanıyor, aracınızın verimliliğini artırıyoruz.",
    "pageServicesChipTuning":
        "Araç yazılımı (chip tuning) konusunda yıllanmış tecrübemiz ile her adımda ihtiyacınıza yönelik özel yazılım geliştiriyoruz. Detaylı bilgi için chip tuning bölümünden bilgi alabilir ve yazılım sonrası güç değerlerinizi öğrenebilirsiniz.",
    "pageServicesYedekParca":
        "Firmamız bünyesinde bulunan distribütörlükleri ve yedek parça stoku ile müşterilerimize hizmet vermektedir. Motor performans parçaları, aşırı besleme sistemleri ve güç aktarım organları ile ilgili tüm parçaların yurtdışından temini, satışı ve bakım-onarım, servis desteği sağlanmaktadır.",
    "pageServicesEkspertiz":
        "Oto ekspertiz işlemleri, ilgili spor veya süper spor otomobilin yürüyen aksam kontrolü, motor performans testleri, gövde parçalarının kontrolü aracın mekanik aksamında bozulan yerlerden, yakın zamanda masraf çıkarabilecek tüm noktalara kadar otomobilin incelenmesinden oluşmaktadır. Fiyat ve randevu bilgisi için iletişim adreslerimizden bize ulaşabilirsiniz.",
    "pageServicesDinamometre":
        "Aracınıza yapacağınız motor güçlendirme işleminin sonuçlarını öğrenebilir. Aracınızın mekanik durumuna göre, motorun yıpranma payı ve anlık gücünü görebilir, aracınızın motorundaki var olan sorunları daha net görebilirsiniz. Randevu için iletişim adresimizden ulaşabilir veya internet sitemizin dinamometre bölümünden detaylı bilgi alabilirsiniz.",
    "pageServicesOzelProjelendirme":
        "Servis Paşaoğlu aracınıza özel projelendirme yapar ve her bir adımda sizi bilgilendirerek aracınızın dönüşüm sürecini sizinle birlikte yürütür. 20 yılı aşkın süredir müşterilerinin amaçlarına yönelik mekanik servis hizmeti, chip tuning ve güç aktarımına yönelik profesyonel destek sağlamaktadır.",
    "pageChipTuningText":
        "Günümüz teknolojisinde otomobiller, stabil ve istenilen verimlilikte çalışabilmesi için gerekli olan gelişmiş bir Elektronik Kontrol Ünitesi (ecu) tarafından yönetilmektedir, bu kontrol ünitesi motordan gelen çeşitli sensörlerin bilgilerini aracın bulunduğu şartlar altında, kullanıcının istekleri üzerine işler ve motorun optimum performansta çalışmasını düzenlemek için selenoidlere ve birtakım valflere sinyaller göndererek sağlar. Ancak özel ihtiyaç hallerinde bu kontrol ünitesine müdahale etmek gerekebilir, bu durumlara sınıflandırma yapacak olursak;"
  };
  static final gallery = [
    "assets/images/gallery/1.jpeg",
    "assets/images/gallery/2.jpeg",
    "assets/images/gallery/3.jpeg",
    "assets/images/gallery/4.jpeg",
    "assets/images/gallery/1.jpeg",
    "assets/images/gallery/2.jpeg",
    "assets/images/gallery/3.jpeg",
    "assets/images/gallery/4.jpeg",
  ];

  static final brands = [
    "assets/images/brands/small-aem.png",
    "assets/images/brands/small-brembo.png",
    "assets/images/brands/small-carrilo.png",
    "assets/images/brands/small-ebc-brakes.png",
    "assets/images/brands/small-eibach-springs.png",
    "assets/images/brands/small-garrett.png",
    "assets/images/brands/small-hks.png",
    "assets/images/brands/small-hondata.png",
    "assets/images/brands/small-kandn.png",
    "assets/images/brands/small-mishimoto.png",
    "assets/images/brands/small-ngk.png",
    "assets/images/brands/small-omp.png",
    "assets/images/brands/small-powerflex.png",
    "assets/images/brands/small-sparco.png",
    "assets/images/brands/small-walbro.png",
    "assets/images/brands/small-wiseco.png",
  ];
}
