CREATE DEFINER = CURRENT_USER TRIGGER `Catastro_Eduardo`.`Construcciones_por_persona_BEFORE_INSERT` BEFORE INSERT ON `Construcciones` FOR EACH ROW
BEGIN
	
    IF (NEW.Construcciones_Nombre = Unifamiliar.Construcciones_Nombre || NEW.Construcciones_Nombre = Bloque.Construcciones_Nombre) THEN
		RETURN NULL;
	ELSE
		SET NEW.Construcciones_Nombre = Persona.Nombre;
	END IF;

END
