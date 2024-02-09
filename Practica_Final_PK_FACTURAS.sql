create or replace PACKAGE PK_FACTURAS
IS
    PROCEDURE ALTA_FACTURA(ID_FACTURA NUMBER,FECHA DATE, DESCRIPCION VARCHAR2);
    PROCEDURE BAJA_FACTURA(ID_FACTURA NUMBER);
    PROCEDURE MOD_DESCRI(ID_FACTURA NUMBER, NEW_DESC VARCHAR2);
    PROCEDURE MOD_FECHA(ID_FACTURA NUMBER, NEW_FECHA DATE);

    FUNCTION NUM_FACTURAS(FECHA_INICO DATE, FECHA_FIN DATE)
    RETURN NUMBER;

    FUNCTION TOTAL_FACTURA(ID_FACTURA NUMBER)
    RETURN FLOAT;

END PK_FACTURAS;