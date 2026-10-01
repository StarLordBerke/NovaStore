-- 1. ADIM: Önce tüm projemi içinde tutacağım ana veri tabanını oluşturuyorum.
CREATE DATABASE NovaStoreDB;
GO

-- Oluşturduğum bu yeni veri tabanının içine giriyorum ki tablolar yanlış yere açılmasın.
USE NovaStoreDB;
GO

-- 2. ADIM: Ana tabloları oluşturmaya başlıyorum. 
-- Ürünlerimi kategorilere ayıracağım için önce Categories (Kategoriler) tablosunu açıyorum.
-- Yönergeye göre CategoryID otomatik artsın diye IDENTITY(1,1) kullandım ve CategoryName boş geçilemesin diye NOT NULL ekledim.
CREATE TABLE Categories (
    CategoryID int IDENTITY(1,1) PRIMARY KEY,
    CategoryName varchar(50) NOT NULL
);

-- Müşteriler (Customers) ana tablosunu oluşturuyorum.
-- Email adreslerinin sistemde bir daha tekrar etmemesi, benzersiz olması için UNIQUE kuralını ekledim.
CREATE TABLE Customers (
    CustomerID int IDENTITY(1,1) PRIMARY KEY,
    FullName varchar(50),
    City varchar(20),
    Email varchar(100) UNIQUE
);

-- 3. ADIM: Şimdi ana tablolara "bağımlı" olan tabloları oluşturuyorum.
-- Ürünler (Products) tablosunu kuruyorum. 
-- Bu ürün hangi kategoriye ait bilmek için CategoryID sütununu FOREIGN KEY ile Categories tablosuna bağladım.
-- Stok miktarı girilmezse otomatik 0 olsun diye DEFAULT 0 kuralını ekledim.
CREATE TABLE Products (
    ProductID int IDENTITY(1,1) PRIMARY KEY,
    ProductName varchar(100) NOT NULL,
    Price decimal(10,2),
    Stock int DEFAULT 0,
    CategoryID int FOREIGN KEY REFERENCES Categories(CategoryID)
);

-- Siparişler (Orders) tablosunu oluşturuyorum.
-- Bu siparişi kim verdi bulabilmek için CustomerID'yi FOREIGN KEY ile Customers tablosuna bağladım.
-- Sipariş tarihi boş bırakılırsa o anki tarihi otomatik alsın diye DEFAULT GETDATE() ekledim.
CREATE TABLE Orders (
    OrderID int IDENTITY(1,1) PRIMARY KEY,
    CustomerID int FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate datetime DEFAULT GETDATE(),
    TotalAmount decimal(10,2)
);

-- 4. ADIM: En detaylı yapı olan Sipariş Detayları (OrderDetails) tablosunu kuruyorum.
-- Bu tablo hem siparişin kendisine hem de içindeki ürüne bağlı olduğu için iki tane ayrı FOREIGN KEY kullanarak diğer tablolara bağladım.
CREATE TABLE OrderDetails (
    DetailID int IDENTITY(1,1) PRIMARY KEY,
    OrderID int FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID int FOREIGN KEY REFERENCES Products(ProductID),
    Quantity int
);
GO

--

-- GÖREV 1: 5 Adet Kategori Ekliyorum
-- Ürünlerimi gruplamak için yönergede istenen 5 farklı kategoriyi sisteme giriyorum.
INSERT INTO Categories (CategoryName) VALUES
('Elektronik'),
('Giyim'),
('Kitap'),
('Kozmetik'),
('Ev ve Yaşam');

-- GÖREV 2: En az 10-12 Ürün Ekliyorum
-- Kategorilere uygun şekilde toplam 12 adet ürün giriyorum ve fiyat ile stok bilgilerini belirliyorum.
-- Sondaki numaralar CategoryID'yi temsil ediyor (Örn: 1 = Elektronik).
INSERT INTO Products (ProductName, Price, Stock, CategoryID) VALUES
('Akıllı Telefon', 25000.00, 15, 1),
('Laptop', 45000.00, 8, 1),
('Bluetooth Kulaklık', 1500.00, 30, 1),
('Kışlık Mont', 2500.00, 50, 2),
('Spor Ayakkabı', 1800.00, 12, 2),
('Bilim Kurgu Romanı', 150.00, 100, 3),
('SQL Eğitim Kitabı', 250.00, 18, 3),
('Güneş Kremi', 400.00, 60, 4),
('Parfüm', 1200.00, 10, 4),
('Çalışma Masası', 3000.00, 5, 5),
('Masa Lambası', 500.00, 25, 5),
('Ergonomik Koltuk', 4500.00, 7, 5);

-- GÖREV 3: 5-6 Adet Müşteri Ekliyorum
-- 3. Bölümdeki sorgularda benden "Ahmet Yılmaz" istendiği için onu özellikle ekliyorum.
-- E-postalarının benzersiz (Unique) olmasına dikkat ettim.
INSERT INTO Customers (FullName, City, Email) VALUES
('Ahmet Yılmaz', 'İstanbul', 'ahmetyilmaz@email.com'),
('Ayşe Kaya', 'Ankara', 'aysekaya@email.com'),
('Mehmet Demir', 'İzmir', 'mehmetdemir@email.com'),
('Fatma Çelik', 'Bursa', 'fatmacelik@email.com'),
('Ali Can', 'Antalya', 'alican@email.com'),
('Zeynep Şahin', 'Eskişehir', 'zeynepsahin@email.com');

-- GÖREV 4: Farklı tarihlerde 8-10 Sipariş Ekliyorum
-- Siparişlerin zaman analizi yapılacağı için eski tarihler de kullandım. 
-- İlk rakamlar CustomerID'yi temsil ediyor (Örn: 1 numaralı müşteri Ahmet Yılmaz).
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2023-10-01 10:30:00', 26500.00), -- Ahmet Yılmaz'ın 1. siparişi
(1, '2023-10-05 14:00:00', 150.00),   -- Ahmet Yılmaz'ın 2. siparişi
(2, '2023-10-02 09:15:00', 45000.00), -- Ayşe Kaya
(3, '2023-10-03 16:45:00', 2500.00),  -- Mehmet Demir
(4, '2023-10-10 11:00:00', 3000.00),  -- Fatma Çelik
(5, '2023-10-12 13:20:00', 1600.00),  -- Ali Can
(2, '2023-10-15 15:30:00', 1500.00),  -- Ayşe Kaya'nın 2. siparişi
(3, '2023-10-20 18:00:00', 500.00),   -- Mehmet Demir'in 2. siparişi
(6, '2023-10-25 12:00:00', 4500.00),  -- Zeynep Şahin
(1, '2023-10-28 17:30:00', 250.00);   -- Ahmet Yılmaz'ın 3. siparişi

-- Sipariş Detaylarını (Ara Tabloyu) Dolduruyorum
-- Hangi siparişte (OrderID), hangi üründen (ProductID), kaç adet (Quantity) alınmış eşleştiriyorum.
INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 1), -- 1. Siparişte 1 tane Akıllı Telefon alındı
(1, 3, 1), -- 1. Siparişte 1 tane Kulaklık alındı
(2, 6, 1), -- 2. Siparişte 1 tane Roman alındı
(3, 2, 1), -- 3. Siparişte 1 tane Laptop alındı
(4, 4, 1), -- 4. Siparişte 1 tane Mont alındı
(5, 10, 1),-- 5. Siparişte 1 tane Masa alındı
(6, 9, 1), -- 6. Siparişte 1 Parfüm alındı
(6, 8, 1), -- 6. Siparişte 1 Güneş Kremi alındı
(7, 3, 1), -- 7. Siparişte 1 Kulaklık alındı
(8, 11, 1),-- 8. Siparişte 1 Masa Lambası alındı
(9, 12, 1),-- 9. Siparişte 1 Ergonomik Koltuk alındı
(10, 7, 1);-- 10. Siparişte 1 SQL Kitabı alındı
GO

--

-- Doğru veri tabanında çalıştığımdan emin olmak için ilk olarak bunu yazıyorum.
USE NovaStoreDB;
GO

-- 1. TEMEL LİSTELEME
-- Soru: Stok miktarı 20'den az olan ürünlerin adını ve stok miktarını "AZALAN" sırada listele.
-- Çözüm: WHERE ile stoğu 20'nin altında olanları filtreleyip, ORDER BY ... DESC komutuyla en yüksekten en düşüğe doğru diziyorum.
SELECT ProductName, Stock 
FROM Products 
WHERE Stock < 20 
ORDER BY Stock DESC;

-- 2. VERİ BİRLEŞTİRME (JOIN)
-- Soru: Hangi müşteri hangi tarihte sipariş vermiş? (Müşteri Adı, Şehir, Sipariş Tarihi, Toplam Tutar)
-- Çözüm: Müşteriler ve Siparişler tablolarını INNER JOIN ile CustomerID üzerinden birleştiriyorum.
SELECT c.FullName, c.City, o.OrderDate, o.TotalAmount 
FROM Customers c 
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 3. ÇOKLU BİRLEŞTİRME VE DETAY RAPORU
-- Soru: "Ahmet Yılmaz" isimli müşterinin aldığı ürünlerin isimlerini, fiyatlarını ve kategorilerini listele.
-- Çözüm: Müşteriden başlayıp ürün kategorisine kadar tam 5 tabloyu aralarındaki Foreign Key'ler sayesinde zincirleme olarak birbirine bağlıyorum ve WHERE ile sadece Ahmet Yılmaz'ı filtreliyorum.
SELECT c.FullName, p.ProductName, p.Price, cat.CategoryName 
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE c.FullName = 'Ahmet Yılmaz';

-- 4. GRUPLAMA VE AGGREGATE FONKSİYONLAR
-- Soru: Hangi kategoride toplam kaç adet ürünümüz var?
-- Çözüm: Kategorileri GROUP BY ile gruplayıp, her birinin içine düşen ürünleri COUNT fonksiyonuyla saydırıyorum. (Hiç ürünü olmayan kategori de gözüksün diye LEFT JOIN kullandım).
SELECT cat.CategoryName, COUNT(p.ProductID) AS ToplamUrunSayisi 
FROM Categories cat 
LEFT JOIN Products p ON cat.CategoryID = p.CategoryID 
GROUP BY cat.CategoryName;

-- 5. CİRO ANALİZİ (ZOR)
-- Soru: Her müşterinin kazandırdığı toplam ciro nedir? En çok harcama yapandan en aza doğru sırala.
-- Çözüm: Müşterileri gruplayıp, verdikleri siparişlerin tutarlarını SUM fonksiyonuyla topluyorum. Çıkan sonucu da ORDER BY DESC ile çoktan aza sıralıyorum.
SELECT c.FullName, SUM(o.TotalAmount) AS ToplamCiro 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
GROUP BY c.FullName 
ORDER BY ToplamCiro DESC;

-- 6. ZAMAN ANALİZİ
-- Soru: Bugünün tarihine göre siparişlerin üzerinden kaç gün geçti?
-- Çözüm: DATEDIFF fonksiyonunu kullanarak sipariş tarihi (OrderDate) ile bugünün tarihi (GETDATE) arasındaki farkı GÜN (DAY) cinsinden hesaplatıyorum.
SELECT OrderID, OrderDate, DATEDIFF(DAY, OrderDate, GETDATE()) AS GecenGunSayisi 
FROM Orders;
GO


--

-- Doğru veri tabanında olduğumdan emin oluyorum.
USE NovaStoreDB;
GO

-- 1. VIEW (GÖRÜNÜM) OLUŞTURMA
-- Sürekli uzun uzun JOIN sorguları yazmaktan kurtulmak için sık kullandığım bilgileri tek bir sanal tabloda topluyorum.
-- Benden istenen Müşteri Adı, Sipariş Tarihi, Ürün Adı ve Adet bilgilerini getiren vw_SiparisOzet adında bir VIEW oluşturuyorum.
CREATE VIEW vw_SiparisOzet AS
SELECT c.FullName, o.OrderDate, p.ProductName, od.Quantity
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;
GO

-- Not: Oluşturduğum bu View'i test etmek için sanki normal bir tabloymuş gibi şu kodu seçip çalıştırabilirim:
-- SELECT * FROM vw_SiparisOzet;


-- 2. YEDEKLEME (BACKUP)
-- Projemi bitirdim, bunca emeğim boşa gitmesin diye veri tabanımın tam yedeğini alıyorum.
-- Yönergede istendiği gibi yedeği C sürücüsündeki Yedek klasörüne NovaStoreDB.bak adıyla kaydediyorum.
BACKUP DATABASE NovaStoreDB 
TO DISK = 'C:\Yedek\NovaStoreDB.bak';
GO

