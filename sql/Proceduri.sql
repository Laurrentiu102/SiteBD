USE cabinet_avocatura;

DROP PROCEDURE IF EXISTS Ex3a;
DROP PROCEDURE IF EXISTS Ex3b;
DROP PROCEDURE IF EXISTS Ex4a;
DROP PROCEDURE IF EXISTS Ex4b;
DROP PROCEDURE IF EXISTS Ex5a;
DROP PROCEDURE IF EXISTS Ex5b;
DROP PROCEDURE IF EXISTS Ex6a;
DROP PROCEDURE IF EXISTS Ex6b;
DELIMITER //

CREATE PROCEDURE Ex6b()
BEGIN
	SELECT cj.id_cj,cj.data,cj.obiect,cj.onorar,cj.nr_pagini,cj.id_client,cj.id_avocat
	FROM
		(
		SELECT id,cj.onorar-SUM(valoare) AS dif
		FROM
		(
			SELECT id_cj AS id,SUM(suma) AS valoare
			FROM Rata 
			GROUP BY id_cj,suma
			ORDER BY id_cj 
		) AS Tabela
		JOIN Contract_j cj ON id=cj.id_cj 
		GROUP BY id,cj.onorar
		ORDER BY id
	) AS Tabela
	JOIN Contract_j cj ON id=cj.id_cj
	WHERE dif!=0
UNION
	SELECT *
	FROM Contract_j
	WHERE id_cj NOT IN(SELECT id_cj
					   FROM Rata);
END //

CREATE PROCEDURE Ex6a(
				      IN an INTEGER,
                      IN func VARCHAR(20)
)
BEGIN
	SELECT nume,TRUNCATE(bonus_total/12+salar_baza,2) AS "SALAR MEDIU"
	FROM
		(
		SELECT id_om AS id, SUM(bonus) AS bonus_total,salar_baza
		FROM
		(
			SELECT cm.id_angajat AS id_om,cj.id_cj,MONTH(cj.data),cm.comision/100*cj.onorar AS bonus
			FROM Contract_j cj
			JOIN Contract_m cm ON cj.id_avocat=cm.id_angajat
			WHERE YEAR(cj.data)= an AND cm.functie=func
		) AS Tabela
		JOIN Contract_m cm ON cm.id_angajat=id_om
		GROUP BY id_om,salar_baza
		) AS Tabela
	JOIN Persoana ON id=id_p
UNION
	SELECT nume,salar_baza
	FROM Persoana
	JOIN Contract_m ON id_p=id_angajat
	WHERE functie=func AND id_p NOT IN(SELECT id_avocat
										   FROM Contract_j 
                                           WHERE YEAR(data)=an);
END //

CREATE PROCEDURE Ex5b()
BEGIN
	SELECT nume
	FROM Persoana p
	JOIN Contract_j cj ON p.id_p=cj.id_avocat
	WHERE cj.onorar>=ALL(SELECT onorar
                         FROM Contract_j);
END //

CREATE PROCEDURE Ex5a()
BEGIN
	SELECT *
	FROM Contract_m cm1
	WHERE EXISTS(SELECT comision
				 FROM Contract_m cm2
				 WHERE cm1.comision=cm2.comision AND cm1.id_cm<>cm2.id_cm)
	ORDER BY comision,id_cm ASC;
END //

CREATE PROCEDURE Ex4b(
					  IN id_av INTEGER
)
BEGIN
	SELECT CONCAT(CONCAT(cj1.id_cj,' '),cj2.id_cj) AS "Perechi(id_cj1, id_cj2)"
	FROM Contract_j cj1
	INNER JOIN Contract_j cj2 ON cj1.id_cj<cj2.id_cj
	WHERE cj1.id_avocat=cj2.id_avocat AND cj1.id_client<>cj2.id_client  AND cj1.id_avocat=id_av;
END //

CREATE PROCEDURE Ex4a(
					  IN an INTEGER,
					  IN functieDif VARCHAR(10)
)
BEGIN
	SELECT nume
	FROM Persoana p 
	JOIN Contract_m c ON p.id_p = c.id_angajat
	WHERE functie<>functieDif AND YEAR(data)=an;
END //

CREATE PROCEDURE Ex3b(
					  IN litera VARCHAR(1)
)
BEGIN
	SELECT *
	FROM Contract_m
	WHERE LOWER(functie) LIKE CONCAT(litera,'%')
	ORDER BY salar_baza DESC, functie ASC; 
END //

CREATE PROCEDURE Ex3a(
					  IN luna INTEGER,
                      IN an INTEGER,
					  IN onorarMin INTEGER,
                      IN onorarMax INTEGER 
)
BEGIN
	SELECT *
    FROM Contract_j
    WHERE MONTH(data)=luna AND YEAR(data)=an AND onorar BETWEEN onorarMin AND onorarMax
    ORDER BY data ASC;
END //
DELIMITER ;
