# Türkiye Deprem Verisi Görselleştirme Projesi

Bu proje, Türkiye'nin sismik geçmişini ve deprem karakteristiklerini veri bilimi yöntemleriyle analiz etmek ve profesyonel grafiklerle görselleştirmek amacıyla hazırlanmıştır. Proje, üniversite düzeyinde bir akademik çalışma kapsamında geliştirilmiş olup fakülte sergisi ve sınıf sunumu için optimize edilmiştir.

## 📊 Proje Hakkında

Proje kapsamında, R programlama dili ve `ggplot2` kütüphanesi kullanılarak 6 farklı temel görselleştirme yapılmıştır. Her bir grafik, deprem verisinin farklı bir boyutunu (büyüklük, derinlik, mevsimsel dağılım, zaman yoğunluğu vb.) ele almaktadır.

### Kullanılan Teknolojiler
- **Dil:** R
- **Kütüphaneler:** `ggplot2`, `dplyr`, `tidyr`, `ggrepel`
- **Veri Seti:** Temizlenmiş Türkiye Deprem Kayıtları (CSV)

## 📈 Görselleştirme Türleri

1.  **Yıllara Göre Deprem Büyüklükleri (Boxplot):** Standart sismik aktivite ile yıkıcı ana depremler (outliers) arasındaki farkı gösterir.
2.  **Derinlik ve Büyüklük İlişkisi (Scatter Plot):** Sığ odaklı depremlerin büyüklük potansiyelini modeller.
3.  **Mevsimsel Dağılım (Bar Chart):** Deprem sayılarının mevsimlere göre dağılımını `n=...` değerleriyle sunar.
4.  **Zaman ve Ay Yoğunluğu (Heatmap):** 1999 Marmara ve 2023 Kahramanmaraş gibi kritik dönemleri renk yoğunluğuyla vurgular.
5.  **Büyüklük Dağılımı (Histogram & Density):** Sismolojik verinin istatistiksel karakterini gösterir.
6.  **Bölgesel Risk Analizi (Bar Chart):** Türkiye'nin farklı bölgelerindeki ortalama deprem büyüklüklerini kıyaslar.

## 🚀 Kullanım

Projeyi kendi bilgisayarınızda çalıştırmak için:

1.  Bu depoyu (repository) klonlayın veya indirin.
2.  `deprem_analiz.R` ve `temizlenmis_deprem_verisi.csv` dosyalarının aynı klasörde olduğundan emin olun.
3.  RStudio'da `deprem_analiz.R` dosyasını açın.
4.  Gerekli paketleri yükleyin:
    ```R
    install.packages(c("ggplot2", "dplyr", "tidyr", "ggrepel"))
    ```
5.  Kodun tamamını seçip `Run` butonuna basın.


---
*Bu çalışma eğitim amaçlıdır ve resmi sismolojik raporların yerine kullanılamaz.*

##Hazırlayanlar

### Fatih İnce
- ifatih0046@gmail.com
### Ahmet Uğur Tezel
- ahmetugurhesapp@gmail.com
### Bekir Çelik
- bekir751675@gmail.com
