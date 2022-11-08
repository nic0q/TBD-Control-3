-- Se añade el atributo del punto (geometry)
ALTER TABLE minimarkets_gs ADD COLUMN geom GEOMETRY;
UPDATE minimarkets_gs SET geom = ST_SetSRID(ST_MakePoint(longitud,latitud),4326);

SELECT * FROM minimarkets_gs;
SELECT * FROM zonas_censales_gs;

-- Pregunta 1

-- Se añade el atributo del punto (geometry)
ALTER TABLE minimarkets_gs ADD COLUMN geom GEOMETRY;
UPDATE minimarkets_gs SET geom = ST_SetSRID(ST_MakePoint(longitud,latitud),4326);

-- Se hace LEFT JOIN con la tabla de zonas censales con un minimarket a menos de 500 metros, obteniendo así la cantidad de minimarkets por zona censal que tienen un minimarket a mas de 500 metros
DROP TABLE IF EXISTS zc_500m;
CREATE TABLE zc_500m AS(
	SELECT zona.id, zona.comuna, zona.nom_comuna, zona.geom, zona.cod_distri, zona.cod_zona, zona.geocodigo, zona.shape_leng, zona.shape_area
	FROM public.zonas_censales_gs AS zona
	LEFT JOIN minimarkets_gs mini ON ST_DWithin(ST_Transform(mini.geom, 32719), zona.geom, 500)
	WHERE mini.nombre IS NULL);

-- Pregunta 2
DROP TABLE IF EXISTS comunas_ptje_mini;
CREATE TABLE comunas_ptje_mini AS(
	SELECT zonas.nom_comuna, ROUND((COUNT(zc_500m.id) * 100.0) / zonas.total_zonas, 2) AS "porcentaje (%)" , zonas.area_comuna
	FROM public.zc_500m AS zc_500m
	RIGHT JOIN (SELECT zona.comuna, zona.nom_comuna, COUNT(zona.id) AS total_zonas, ST_union(zona.geom) AS area_comuna
							FROM public.zonas_censales_gs AS zona
							GROUP BY zona.comuna, zona.nom_comuna) AS zonas
	ON zonas.comuna = zc_500m.comuna
	GROUP BY zonas.nom_comuna, zonas.area_comuna, zonas.total_zonas
	ORDER BY "porcentaje (%)" DESC);
SELECT * FROM comunas_ptje_mini;