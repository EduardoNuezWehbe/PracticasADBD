CREATE DEFINER = CURRENT_USER TRIGGER `Diagrama_Viveros`.`Productos_stock_BEFORE_DELETE` BEFORE DELETE ON `Productos` FOR EACH ROW
BEGIN

	IF Stock = 0 THEN
		RETURN NULL;
	END IF;
    
    IF Stock > 1 THEN
		SET NEW.Stock = Stock - 1;
		INSERT INTO Productos values(NEW.Stock);
	END IF;
END