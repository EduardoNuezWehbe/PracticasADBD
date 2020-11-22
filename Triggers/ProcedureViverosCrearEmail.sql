CREATE PROCEDURE crear_email (IN nombre VARCHAR(50), IN apellido VARCHAR(50), IN dominio VARCHAR(50), OUT email VARCHAR(50))
BEGIN
	SET email_ = CONCAT(nombre,apellido,'@',dominio);
END