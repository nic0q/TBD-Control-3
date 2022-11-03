ALTER TABLE minimarkets_gs;
-- Se crea la nueva columna geo de tipo de dato geography para trabajar distancias
ALTER TABLE minimarkets_gs ADD COLUMN geo GEOGRAPHY;
-- Se actualiza y se calcula los puntos
UPDATE minimarkets_gs SET geo = ST_MakePoint(longitud,latitud);
--
SELECT *
FROM zonas_censales_gs AS gs;
SELECT *
FROM minimarkets_gs AS mini;
--
SELECT ST_Distance(ST_MakePoint(23.73,37.99),ST_MakePoint(23.73,37.99))
FROM zonas_censales_gs AS gs, minimarkets_gs AS mini;
--
SELECT ST_SRID(mini.geo), ST_SRID(gs.geom)
FROM zonas_censales_gs as gs, minimarkets_gs AS mini;
-- Query 1
SELECT DISTINCT gs.id, gs.geom -- Columnas no repetidas
FROM zonas_censales_gs AS gs, minimarkets_gs AS mini
WHERE NOT(ST_DWithin(ST_Transform(gs.geom,32719),ST_Transform(mini.geo::geometry,32719),500)) -- Transformacion a SRID 32719 y a mas de 500m
LIMIT 20;
--
