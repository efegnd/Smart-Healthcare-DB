-- ====================================================================
-- SMART HEALTHCARE SYSTEM - ADVANCED ANALYTICAL SQL QUERIES
-- Developed by Efe Günduğar
-- Course: MTM2522 Data Management and File Structures (Task 8)
-- ====================================================================

USE hastanesistemi;

-- --------------------------------------------------------------------
-- QUERY 1: INNER JOIN WITH AGGREGATION & HAVING
-- Find doctors who have conducted more than 5 examinations, sorted by rank.
-- --------------------------------------------------------------------
SELECT 
    d.Doktor_ID, 
    k.Ad_Soyad AS Doktor_Adi, 
    COUNT(m.Muayene_No) AS Toplam_Muayene
FROM doktor d
INNER JOIN kullanici k ON d.Kullanici_ID = k.Kullanici_ID
INNER JOIN muayene m ON d.Doktor_ID = m.Doktor_ID
GROUP BY d.Doktor_ID, k.Ad_Soyad
HAVING COUNT(m.Muayene_No) > 5
ORDER BY Toplam_Muayene DESC;


-- --------------------------------------------------------------------
-- QUERY 2: LEFT OUTER JOIN
-- List all patients and their total prescriptions, including those with zero prescriptions.
-- --------------------------------------------------------------------
SELECT 
    h.TC_Kimlik, 
    h.Ad_Soyad AS Hasta_Adi, 
    COUNT(r.Recete_No) AS Toplam_Recete_Sayisi
FROM hasta h
LEFT OUTER JOIN recete r ON h.TC_Kimlik = r.Hasta_TC_Kimlik
GROUP BY h.TC_Kimlik, h.Ad_Soyad
ORDER BY Toplam_Recete_Sayisi DESC;


-- --------------------------------------------------------------------
-- QUERY 3: MULTI-TABLE JOIN WITH DATA FILTERING
-- Fetch examination details including Patient Name, Doctor Name, Date, and Diagnosis.
-- --------------------------------------------------------------------
SELECT 
    m.Muayene_No,
    h.Ad_Soyad AS Hasta_Adi,
    kd.Ad_Soyad AS Doktor_Adi,
    m.Tarih AS Muayene_Tarihi,
    m.Teshis
FROM muayene m
INNER JOIN hasta h ON m.Hasta_TC_Kimlik = h.TC_Kimlik
INNER JOIN doktor d ON m.Doktor_ID = d.Doktor_ID
INNER JOIN kullanici kd ON d.Kullanici_ID = kd.Kullanici_ID
WHERE m.Tarih >= '2026-01-01'
ORDER BY m.Tarih DESC;


-- --------------------------------------------------------------------
-- QUERY 4: CORRELATED SUBQUERY
-- Find examinations where the patient has a prescription issued on the exact same day.
-- --------------------------------------------------------------------
SELECT m.Muayene_No, m.Hasta_TC_Kimlik, m.Tarih, m.Teshis
FROM muayene m
WHERE EXISTS (
    SELECT 1 
    FROM recete r 
    WHERE r.Hasta_TC_Kimlik = m.Hasta_TC_Kimlik 
      AND r.Tarih = m.Tarih
);


-- --------------------------------------------------------------------
-- QUERY 5: NESTED SUBQUERY WITH AGGREGATION (IN Clause)
-- Find patients who have been prescribed medication with specific dense dosages (e.g., 'Günde 2' or 'Sabah akşam').
-- --------------------------------------------------------------------
SELECT TC_Kimlik, Ad_Soyad, Kan_Grubu
FROM hasta
WHERE TC_Kimlik IN (
    SELECT Hasta_TC_Kimlik 
    FROM recete 
    WHERE Dozaj LIKE '%Günde 2%' OR Dozaj LIKE '%Sabah akşam%'
);


-- --------------------------------------------------------------------
-- QUERY 6: STRING MANIPULATION & CONCATENATION WITH JOIN
-- Retrieve patient contact log, combining multiple phone numbers where applicable.
-- --------------------------------------------------------------------
SELECT 
    h.TC_Kimlik, 
    h.Ad_Soyad AS Hasta_Adi, 
    GROUP_CONCAT(ht.Telefon_No SEPARATOR ' / ') AS Iletisim_Numaralari
FROM hasta h
INNER JOIN hasta_telefon ht ON h.TC_Kimlik = ht.Hasta_TC_Kimlik
GROUP BY h.TC_Kimlik, h.Ad_Soyad;


-- --------------------------------------------------------------------
-- QUERY 7: SCALAR SUBQUERY IN SELECT CLAUSE
-- List all doctors along with a dynamically calculated column showing the percentage of total hospital examinations they handled.
-- --------------------------------------------------------------------
SELECT 
    d.Doktor_ID,
    ku.Ad_Soyad AS Doktor_Adi,
    COUNT(m.Muayene_No) AS Doktor_Muayene_Sayisi,
    ROUND((COUNT(m.Muayene_No) / (SELECT COUNT(*) FROM muayene)) * 100, 2) AS Hospital_Share_Percentage
FROM doktor d
INNER JOIN kullanici ku ON d.Kullanici_ID = ku.Kullanici_ID
LEFT JOIN muayene m ON d.Doktor_ID = m.Doktor_ID
GROUP BY d.Doktor_ID, ku.Ad_Soyad;


-- --------------------------------------------------------------------
-- QUERY 8: ADVANCED DATA SEGMENTATION (CASE WHEN)
-- Categorize patients into risk groups based on their check-up frequencies in the system.
-- --------------------------------------------------------------------
SELECT 
    h.TC_Kimlik,
    h.Ad_Soyad AS Hasta_Adi,
    COUNT(m.Muayene_No) AS Toplam_Ziyaret,
    CASE 
        WHEN COUNT(m.Muayene_No) >= 5 THEN 'Kronik Takip / Yüksek Risk'
        WHEN COUNT(m.Muayene_No) BETWEEN 2 AND 4 THEN 'Rutin Takip / Orta Risk'
        ELSE 'Stabil / Düşük Risk'
    END AS Hasta_Medikal_Kategorisi
FROM hasta h
LEFT JOIN muayene m ON h.TC_Kimlik = m.Hasta_TC_Kimlik
GROUP BY h.TC_Kimlik, h.Ad_Soyad;


-- --------------------------------------------------------------------
-- QUERY 9: SUBQUERY IN FROM CLAUSE (DERIVED TABLES)
-- Find the maximum number of prescriptions given out in a single calendar month.
-- --------------------------------------------------------------------
SELECT 
    MAX(Aylik_Recete.Sayi) AS En_Yoğun_Aydaki_Recete_Sayisi
FROM (
    SELECT 
        DATE_FORMAT(Tarih, '%Y-%m') AS Ay, 
        COUNT(*) AS Sayi 
    FROM recete
    GROUP BY DATE_FORMAT(Tarih, '%Y-%m')
) AS Aylik_Recete;


-- --------------------------------------------------------------------
-- QUERY 10: COMPLEX ANALYTICAL FILTERING (CTE / COMPLEX NESTED)
-- Identify the top diagnosis (most common disease) across the entire system.
-- --------------------------------------------------------------------
SELECT 
    Teshis, 
    COUNT(*) AS Teshis_Sikligi
FROM muayene
WHERE Teshis IS NOT NULL AND Teshis <> ''
GROUP BY Teshis
ORDER BY Teshis_Sikligi DESC
LIMIT 1;