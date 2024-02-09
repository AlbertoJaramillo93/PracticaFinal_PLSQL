create or replace PACKAGE BODY PK_LINEAS_FACTURAS
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

    --FUNCTION EXISTE PRODUCTO
    FUNCTION EXISTE_PRODUCTO(ID_PRODUCTO NUMBER)
    RETURN BOOLEAN
    IS
        CURSOR my_cursorPro IS SELECT COD_PRODUCTO FROM PRODUCTOS;
        BEGIN
            FOR i IN my_cursorPro LOOP
                IF i.COD_PRODUCTO = ID_PRODUCTO THEN
                    RETURN TRUE; --EXISTE PRODUCTO
                END IF;
            END LOOP;
            RETURN FALSE; --PRODUCTO NO EXISTE
        END;

    --FUNCTION EXISTE LINEA_FACTURA
    FUNCTION EXISTE_LINEA_FACTURA(ID_FACTURA NUMBER, ID_PRODUCTO NUMBER)
    RETURN BOOLEAN
    IS
        CURSOR my_cursorLiFa IS SELECT COD_FACTURA,COD_PRODUCTO FROM LINEAS_FACTURA;
        BEGIN
            FOR i IN my_cursorLiFa LOOP
                IF i.COD_FACTURA = ID_FACTURA AND i.COD_PRODUCTO = ID_PRODUCTO THEN
                    RETURN TRUE;--SI EXISTE LINEA_FACTURA
                END IF;
            END LOOP;
            RETURN FALSE;-- NO EXISTE LINEA_FACTURA
        END;

    --ALTA LINEAS_FACTURA
    PROCEDURE ALTA_LINEA(ID_FACTURA NUMBER, ID_PRODUCTO NUMBER, UNIDADES NUMBER, FECHA DATE)
    IS
        existe_fact BOOLEAN;
        existe_prod BOOLEAN;
        v_pvp NUMBER;
    BEGIN
        existe_fact:=EXITE_FACTURA(ID_FACTURA);
        existe_prod:=EXISTE_PRODUCTO(ID_PRODUCTO);

        SELECT PVP
        INTO v_pvp
        FROM PRODUCTOS WHERE COD_PRODUCTO = ID_PRODUCTO;

        IF existe_fact = TRUE AND existe_prod = TRUE THEN
            INSERT INTO LINEAS_FACTURA(COD_FACTURA,COD_PRODUCTO,PVP,UNIDADES,FECHA)VALUES(ID_FACTURA,ID_PRODUCTO,v_pvp,UNIDADES,FECHA);
            COMMIT;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Factura o Producto invalido');
        END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                  DBMS_OUTPUT.PUT_LINE('Factura o Producto invalido');
            WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLCODE);
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END ALTA_LINEA;

    --BAJA LINEAS_FACTURA
    PROCEDURE BAJA_LINEA(ID_FACTURA NUMBER, ID_PRODUCTO NUMBER)
    IS
        existe_linfac BOOLEAN;
    BEGIN
        existe_linfac:=EXISTE_LINEA_FACTURA(ID_FACTURA,ID_PRODUCTO);

        IF existe_linfac = TRUE THEN
            DELETE FROM LINEAS_FACTURA WHERE COD_FACTURA = ID_FACTURA AND COD_PRODUCTO = ID_PRODUCTO;
            COMMIT;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Factura o Producto invalido');
        END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                  DBMS_OUTPUT.PUT_LINE('Factura o Producto invalido');
            WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLCODE);
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END BAJA_LINEA;

    --OVERLOAD FUCTION MODIFY UNITS INTO TABLE LINEAS_FACTURAS
    FUNCTION MOD_LINEA(ID_FACTURA NUMBER, ID_PRODUCTO NUMBER,UNIDADES NUMBER)
    RETURN NUMBER
    IS
        existe_linfac BOOLEAN;
        unidades_final NUMBER;
    BEGIN
        existe_linfac:=EXISTE_LINEA_FACTURA(ID_FACTURA,ID_PRODUCTO);
        unidades_final:= UNIDADES;
        IF existe_linfac = TRUE THEN
            UPDATE LINEAS_FACTURA SET UNIDADES = unidades_final WHERE COD_FACTURA = ID_FACTURA AND COD_PRODUCTO = ID_PRODUCTO;
            COMMIT;
            RETURN unidades_final;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Factura o Producto invalido');
            RETURN unidades_final;
        END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                  DBMS_OUTPUT.PUT_LINE('Factura o Producto invalido');
            WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLCODE);
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;

    --OVERLOAD FUNCTION MODIFY DATE INTO TABLE LINEAS_FACTURA
    FUNCTION MOD_LINEA(ID_FACTURA NUMBER, ID_PRODUCTO NUMBER,FECHA DATE)
    RETURN DATE
    IS
        existe_linfac BOOLEAN;
        fecha_final DATE;
    BEGIN
        existe_linfac:=EXISTE_LINEA_FACTURA(ID_FACTURA,ID_PRODUCTO);
        fecha_final:=FECHA;
        IF existe_linfac = TRUE THEN
            UPDATE LINEAS_FACTURA SET FECHA = fecha_final WHERE COD_FACTURA = ID_FACTURA AND COD_PRODUCTO = ID_PRODUCTO;
            COMMIT;
            RETURN fecha_final;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Factura o Producto invalido');
            RETURN fecha_final;
        END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                  DBMS_OUTPUT.PUT_LINE('Factura o Producto invalido');
            WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLCODE);
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;

    --FUNCTION COUNT NUMBER OF ROWS INTO LINEA_FACTURA
    FUNCTION NUM_LINEAS_FAC(ID_FACTURA NUMBER)
    RETURN NUMBER
    IS
        Total_fac NUMBER;
    BEGIN
        SELECT COUNT(*)
            INTO Total_fac
        FROM LINEAS_FACTURA WHERE COD_FACTURA = ID_FACTURA;
        RETURN Total_fac;
    END;

END PK_LINEAS_FACTURAS;