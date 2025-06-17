DELIMITER $$
DROP FUNCTION IF EXISTS fn_total_pedidos $$

CREATE FUNCTION fn_total_pedidos(id_cliente INT)
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_to_pe INT;

    SELECT COUNT(p.id) AS ID_pedido INTO v_to_pe
    FROM pedido AS p
    WHERE p.id_cliente = id_cliente;

    RETURN v_to_pe;
END $$

DELIMITER ;

SELECT fn_total_pedidoS(1);



DELIMITER $$
DROP FUNCTION IF EXISTS fn_total_ganancia $$

CREATE FUNCTION fn_total_ganancia(id_comercial INT)
RETURNS DECIMAL(10,2)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_ganancia DECIMAL(10,2);

    SELECT comision INTO v_ganancia
    FROM comercial
    WHERE id = id_comercial;

    RETURN v_ganancia;
END $$

DELIMITER ;

SELECT fn_total_ganancia(1);



DELIMITER $$
DROP FUNCTION IF EXISTS fn_pedido_mayor $$

CREATE FUNCTION fn_pedido_mayor()
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_top INT;

    SELECT c.id AS id_cliente INTO v_top
    FROM cliente AS c
    JOIN pedido AS p USING(id)
    GROUP BY c.id
    ORDER BY c.id ASC
    LIMIT 1;

    RETURN v_top;
END $$

DELIMITER ;

SELECT fn_pedido_mayor();

DELIMITER $$
DROP FUNCTION IF EXISTS fn_pedidos_year $$

CREATE FUNCTION fn_pedidos_year(year_1 DATE, year_2 DATE)
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_pedidos INT;

    SELECT COUNT(id) INTO v_pedidos
    FROM pedido
    WHERE fecha BETWEEN year_1 AND year_2;

    RETURN v_pedidos;
END $$

DELIMITER ;

SELECT fn_pedidos_year('2023-01-01', '2024-01-01');