CREATE DEFINER = CURRENT_USER TRIGGER `Diagrama_Viveros`.`trigger_crear_email_before_insert` BEFORE INSERT ON `Cliente` FOR EACH ROW
BEGIN
	IF NEW.email_ IS NULL THEN
        CALL crear_email(Nombre, Apellidos, 'ull.es', email);
		INSERT INTO Cliente values (email);
	END IF;
    
    SET NEW.email_ = email;
    
END
