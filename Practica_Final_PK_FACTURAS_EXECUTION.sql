
--Registrar una nueva factura
EXECUTE HR.PK_FACTURAS.ALTA_FACTURA(1,SYSDATE,'Test1');

--Modificar el campo DESCRIPCION de una factura existente
EXECUTE HR.PK_FACTURAS.MOD_DESCRI(1,'NewValue Test1');

--Modificar el campo FECHA de una factura existente
EXECUTE HR.PK_FACTURAS.MOD_FECHA(1,'2024-02-09 10:20:15');

--Eliminar una factura existente
EXECUTE HR.PK_FACTURAS.BAJA_FACTURA(1);


--Funcion para buscar las Facturas existentes en un rango de fechas
DECLARE
    InFecha DATE;
    FinFecha DATE;
    Cantidad NUMBER;
BEGIN
    InFecha:='2024-01-01';
    FinFecha:='2024-02-10';
    Cantidad := HR.PK_FACTURAS.NUM_FACTURAS(InFecha,FinFecha);
    DBMS_OUTPUT.PUT_LINE(Cantidad);
END;

--Funcion para obtener el total de ventas suma(pvp * unidades) por factura
DECLARE
    ID_FACTURA NUMBER;
    Cantidad FLOAT;
BEGIN
    ID_FACTURA:=1;
    Cantidad := HR.PK_FACTURAS.TOTAL_FACTURA(ID_FACTURA);
    DBMS_OUTPUT.PUT_LINE(Cantidad);
END;