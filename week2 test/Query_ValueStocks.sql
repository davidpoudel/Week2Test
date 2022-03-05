CREATE TABLE dividend (company varchar(120), fiscal_year integer);
INSERT INTO dividend (company, fiscal_year) VALUES ('AHPC',20702071),
('AHPC',20712072),
('AHPC',20732074),
('AHPC',20762077),
('CZBIL',20692070),
('CZBIL',20702071),
('CZBIL',20712072),
('CZBIL',20732074),
('GBIME',20692070),
('GBIME',20702071),
('GBIME',20712072),
('GBIME',20732074);

WITH RECURSIVE var1 AS (
  
  SELECT company, LEFT(fiscal_year::TEXT,4)::INT AS yrs FROM dividend
), var2 AS (
  
  SELECT var1.company, var1.yrs, 1 AS cs 
   FROM var1
  UNION DISTINCT

	SELECT var1.company, var1.yrs, var2.cs + 1 
   FROM var1
   JOIN var2 
     ON var1.company = var2.company
    AND var1.yrs = var2.yrs + 1
)

SELECT JSONB_AGG(DISTINCT company) as valuestocks FROM var2

WHERE cs >= 3;

