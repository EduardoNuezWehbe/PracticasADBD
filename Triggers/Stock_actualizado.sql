CREATE PROCEDURE stock_actualizado (IN producto VARCHAR(45), IN cantidad INT, OUT resultado binary)
BEGIN
	IF cantidad > 0 THEN
		SET resultado = 0;
	ELSE
		SET resultado = 1;
	END IF;

END