# NovaStore E-Ticaret Veri Yönetim Sistemi 🛒

Bu proje, "NovaStore" adlı e-ticaret platformu için tasarlanmış kapsamlı bir ilişkisel veri tabanı yönetim sistemidir. Proje kapsamında veri tabanı tasarımı (DDL), veri girişi (DML), karmaşık sorgulamalar (DQL) ve ileri seviye veri tabanı nesnelerinin oluşturulması işlemleri T-SQL kullanılarak MS SQL Server üzerinde gerçekleştirilmiştir.

## 🛠️ Kullanılan Teknolojiler
* **Veri Tabanı:** Microsoft SQL Server
* **Sorgu Dili:** T-SQL (Transact-SQL)
* **Geliştirme Ortamı:** SQL Server Management Studio (SSMS)

## 🗄️ Veri Tabanı Mimarisi (DDL)
Sistem, `NovaStoreDB` adında bir ana veri tabanı üzerinde inşa edilmiştir. Tablolar arası ilişkiler (Primary Key & Foreign Key) kurularak veri bütünlüğü sağlanmıştır.
* **Categories:** Ürün kategorilerini tutan ana tablo.
* **Customers:** Benzersiz (UNIQUE) e-posta adreslerine sahip müşteri kayıtları.
* **Products:** Kategoriye bağlı ürün ve stok bilgileri.
* **Orders:** Müşterilerin sipariş tarihleri ve toplam tutarları.
* **OrderDetails:** Hangi siparişte hangi üründen kaç adet alındığını bağlayan detaylı ara tablo.

## 📊 İçerik ve Analiz Özellikleri
* **Veri Girişi (DML):** Sistemin test edilebilmesi için 5 kategori, 12 ürün, 6 müşteri ve 10 adet detaylı sipariş verisi `INSERT` işlemleriyle eklenmiştir.
* **Sorgulama ve Analizler (DQL):**
  * **Kritik Stok Kontrolü:** Stok miktarı 20'nin altında olan ürünlerin filtrelenmesi.
  * **Sipariş Geçmişi:** `INNER JOIN` kullanılarak müşteri ve sipariş verilerinin birleştirilmesi.
  * **Detaylı Raporlama:** 5 farklı tablonun zincirleme birleştirilmesiyle spesifik müşteri harcama dökümlerinin çıkarılması.
  * **Envanter Analizi:** `LEFT JOIN` ve `COUNT` kullanılarak kategori bazlı ürün sayımı.
  * **Ciro Analizi:** `SUM` ve `GROUP BY` kullanılarak şirkete en çok ciro kazandıran müşterilerin sıralanması.
  * **Zaman Analizi:** `DATEDIFF` fonksiyonu ile siparişlerin üzerinden geçen sürenin hesaplanması.
* **İleri Seviye Nesneler:** Karmaşık sorguları kolaylaştırmak için `vw_SiparisOzet` adında bir VIEW (Sanal Tablo) oluşturulmuştur.
* **Veri Güvenliği:** Veri tabanının fiziksel yedeğini almak için `BACKUP DATABASE` komutu entegre edilmiştir.

## 🗺️ İlişkisel Şema (Database Diagram)

![NovaStore ER Diagram](Berke_Mert_Ozturk_NovaStore_Proje.png)
*(Tablolar arası bağlar ve yapılar yukarıdaki diyagramda belirtilmiştir.)*

## 🚀 Kurulum ve Çalıştırma
1. Bu repodaki `Berke_Mert_Ozturk_NovaStore_Proje.sql` dosyasını indirin.
2. SQL Server Management Studio (SSMS) uygulamasını açın ve sunucunuza bağlanın.
3. İndirdiğiniz `.sql` dosyasını SSMS içine sürükleyip bırakın veya `Dosya > Aç` diyerek yükleyin.
4. Kod bloklarını (Bölüm 1'den başlayarak) fare ile seçip `Execute (F5)` butonuna basarak adım adım çalıştırın.

---
**Geliştirici:** Berke Mert ÖZTÜRK
