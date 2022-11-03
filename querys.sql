ALTER TABLE minimarkets_gs
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
SELECT gs.id
FROM zonas_censales_gs AS gs, minimarkets_gs AS mini
WHERE not(ST_DWithin(ST_Transform(gs.geom,4326),ST_Transform(mini.geo::geometry,4326),500))
LIMIT 10;
--

SELECT ST_Distance(ST_MakePoint(23.73,37.99),ST_MakePoint(23.73,37.99))
FROM zonas_censales_gs AS gs, minimarkets_gs AS mini;

SELECT ST_Distance(gs.geom,mini.geo)
FROM zonas_censales_gs AS gs, minimarkets_gs AS mini;

SELECT ST_SRID(gs.geom) FROM zonas_censales_gs as gs;