create or replace PACKAGE BODY PK_FACTURAS
IS
    --FUNCTION EXITE FACTURA
    FUNCTION EXITE_FACTURA(ID_FACTURA NUMBER)
    RETURN BOOLEAN
    IS
        CURSOR my_cursor IS SELECT COD_FACTURA FROM FACTURAS;
        BEGIN
            FOR i IN my_cursor LOOP
                IF i.COD_FACTURA = ID_FACTURA THEN
                    RETURN TRUE; --EXISTE LA FACTURA
                END IF;
            END LOOP;
            RETURN FALSE; --FACTURA NO EXISTE
        END;

    --FUNCION NUM_FACTURAS
    FUNCTION NUM_FACTURAS(FECHA_INICO DATE, FECHA_FIN DATE)
    RETURN NUMBER
    IS
        Total_Fac NUMBER;
    BEGIN   
        SELECT COUNT(*) 
            INTO Total_Fac
        FROM FACTURAS WHERE TO_CHAR(FECHA, 'YYYY-MM-DD') BETWEEN FECHA_INICO AND FECHA_FIN;
        RETURN Total_Fac;
    END;

    --FUNCION TOTAL_VENTAS EN LINEAS_FACTURA
    FUNCTION TOTAL_FACTURA(ID_FACTURA NUMBER)
    RETURN FLOAT
    IS
        Total_Factura FLOAT;
    BEGIN      
        SELECT SUM(PVP * UNIDADES)
            INTO Total_Factura
        FROM LINEAS_FACTURA WHERE COD_FACTURA = ID_FACTURA
        GROUP BY COD_FACTURA;
        RETURN Total_Factura;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('La factura: ' || ID_FACTURA  ||' aun no cuenta con datos en la tabla Lineas Factura');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLCODE);
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;

    --ALTA FACTURA
    PROCEDURE ALTA_FACTURA(ID_FACTURA NUMBER,FECHA DATE, DESCRIPCION VARCHAR2)
    IS
        existe BOOLEAN;
    BEGIN
        --VALIDA SI EXISTE
        existe:= EXITE_FACTURA(ID_FACTURA);
        IF existe = FALSE THEN
            INSERT INTO FACTURAS(COD_FACTURA,FECHA,DESCRIPCION) VALUES(ID_FACTURA,FECHA,DESCRIPCION);
            COMMIT;
        ELSE
            DBMS_OUTPUT.PUT_LINE('La factura YA existe');
        END IF;
        EXCEPTION
            WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLCODE);
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END ALTA_FACTURA;

    --BAJA FACTURA
    PROCEDURE BAJA_FACTURA(ID_FACTURA NUMBER)
    IS
        existe BOOLEAN;
    BEGIN
        --VALIDA SI EXISTE
        existe:= EXITE_FACTURA(ID_FACTURA);
        IF existe = TRUE THEN
            DELETE FROM FACTURAS WHERE COD_FACTURA = ID_FACTURA;
            DELETE FROM LINEAS_FACTURA WHERE COD_FACTURA = ID_FACTURA;
            COMMIT;
        ELSE
            DBMS_OUTPUT.PUT_LINE('La factura NO existe');
        END IF;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLCODE);
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END BAJA_FACTURA;

    --MOD FACTURA
    PROCEDURE MOD_DESCRI(ID_FACTURA NUMBER, NEW_DESC VARCHAR2)
    IS
        existe BOOLEAN;
    BEGIN
        --VALIDA SI EXISTE
        existe:= EXITE_FACTURA(ID_FACTURA);
        IF existe = TRUE THEN
            UPDATE FACTURAS SET DESCRIPCION = NEW_DESC WHERE COD_FACTURA = ID_FACTURA;
            COMMIT;
        ELSE
            DBMS_OUTPUT.PUT_LINE('La factura NO existe');
        END IF;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLCODE);
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END MOD_DESCRI;

    --MOD FECHA
    PROCEDURE MOD_FECHA(ID_FACTURA NUMBER, NEW_FECHA DATE)
    IS
        existe BOOLEAN;
    BEGIN
        --VALIDA SI EXISTE
        existe:= EXITE_FACTURA(ID_FACTURA);
        IF existe = TRUE THEN
            UPDATE FACTURAS SET FECHA = NEW_FECHA WHERE COD_FACTURA = ID_FACTURA;
            COMMIT;
        ELSE
            DBMS_OUTPUT.PUT_LINE('La factura NO existe');
        END IF;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLCODE);
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END MOD_FECHA;

END PK_FACTURAS;