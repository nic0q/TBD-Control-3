-- Se añade el atributo del punto (geometry)
ALTER TABLE minimarkets_gs ADD COLUMN geom GEOMETRY;
UPDATE minimarkets_gs SET geom = ST_SetSRID(ST_MakePoint(longitud,latitud),4326);

SELECT * FROM minimarkets_gs;
SELECT * FROM zonas_censales_gs;

-- Pregunta 1
-- Se hace LEFT JOIN con la tabla de zonas censales para obtener las zonas censales que no tienen minimarket a menos de 501 metros, es decir a más de 500 metros
DROP TABLE IF EXISTS zc_500m;
CREATE TABLE zc_500m AS(
	SELECT zona_censal.id, zona_censal.comuna, zona_censal.nom_comuna
	FROM zonas_censales_gs AS zona_censal
		LEFT JOIN (SELECT DISTINCT zona_censal.id, zona_censal.comuna
					     FROM zonas_censales_gs AS zona_censal, minimarkets_gs AS mini
					     WHERE ST_Distance(ST_Transform(mini.geom::geometry, 32719),zona_censal.geom) <= 500) AS zonas_menos_501m
		ON zonas_menos_501m.id = zona_censal.id
	WHERE zonas_menos_501m.id IS null
);
SELECT * FROM zc_500m;

-- Pregunta 2
SELECT zc_500m.comuna, COUNT(zc_500m.id) AS total_zc_500m, zonas.total_comunas, COUNT(zc_500m.id) * 100 / zonas.total_comunas
	FROM zc_500m
	INNER JOIN (SELECT zona_censal.comuna, COUNT(zona_censal.id) AS total_comunas
					    FROM zonas_censales_gs AS zona_censal
					    GROUP BY zona_censal.comuna) AS zonas ON zonas.comuna = zc_500m.comuna
	GROUP BY zc_500m.comuna,zonas.total_comunas;