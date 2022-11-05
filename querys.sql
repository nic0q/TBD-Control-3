ALTER TABLE minimarkets_gs ADD COLUMN geo GEOGRAPHY;
ALTER TABLE minimarkets_gs ADD COLUMN geom GEOMETRY;
UPDATE minimarkets_gs SET geo = ST_MakePoint(longitud,latitud);
UPDATE minimarkets_gs SET geom = ST_SetSRID(ST_MakePoint(longitud,latitud),4326);

ALTER TABLE zonas_censales_gs ADD COLUMN geo GEOGRAPHY;
ALTER TABLE zonas_censales_gs ADD COLUMN geo2 GEOGRAPHY;
UPDATE zonas_censales_gs SET geo = ST_Transform(geom,4326)::GEOGRAPHY;

SELECT * FROM minimarkets_gs;
SELECT * FROM zonas_censales_gs;

SELECT ST_Distance(gs.geo,mini.geo,true) -- Columnas no repetidas
FROM zonas_censales_gs AS gs, minimarkets_gs AS mini
LIMIT 1000;
-- Ver los SRID de las tablas
SELECT ST_SRID(mini.geo), ST_SRID(gs.geom)
FROM zonas_censales_gs as gs, minimarkets_gs AS mini;
-- Distancia con geography
SELECT DISTINCT zona_censal.geom
FROM zonas_censales_gs AS zona_censal, minimarkets_gs AS mini
WHERE ST_Distance(mini.geo,zona_censal.geo) < 500
GROUP BY(zona_censal.geom);
-- Distancia con geometry
SELECT DISTINCT zona_censal.geom
FROM zonas_censales_gs AS zona_censal, minimarkets_gs AS mini
WHERE ST_Distance(
    ST_Transform(mini.geom::geometry, 32719),
    zona_censal.geom
		) > 500
GROUP BY(zona_censal.geom);