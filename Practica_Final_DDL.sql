----------------------------------------------------------------------------------------------------------------
-- Practica final PL/SQL
----------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------
--  DDL for Table FACTURAS
----------------------------------------------------------------------------------------------------------------
CREATE TABLE "HR"."FACTURAS" (
    "COD_FACTURA" NUMBER(5, 0),
    "FECHA"       DATE,
    "DESCRIPCION" VARCHAR2(100 BYTE)
)
SEGMENT CREATION IMMEDIATE
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
TABLESPACE "USERS";


----------------------------------------------------------------------------------------------------------------
--  DDL for Table LINEAS_FACTURA
----------------------------------------------------------------------------------------------------------------
CREATE TABLE "HR"."LINEAS_FACTURA" (
    "COD_FACTURA"  NUMBER,
    "COD_PRODUCTO" NUMBER,
    "PVP"          NUMBER,
    "UNIDADES"     NUMBER,
    "FECHA"        DATE
)
SEGMENT CREATION IMMEDIATE
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
TABLESPACE "USERS";


----------------------------------------------------------------------------------------------------------------
--  DDL for Table PRODUCTOS
----------------------------------------------------------------------------------------------------------------
CREATE TABLE "HR"."PRODUCTOS" (
    "COD_PRODUCTO"    NUMBER,
    "NOMBRE_PRODUCTO" VARCHAR2(50 BYTE),
    "PVP"             NUMBER,
    "TOTAL_VENDIDOS"  NUMBER
)
SEGMENT CREATION IMMEDIATE
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
TABLESPACE "USERS";


----------------------------------------------------------------------------------------------------------------
--  DDL for Table CONTROL_LOG
----------------------------------------------------------------------------------------------------------------
CREATE TABLE "HR"."CONTROL_LOG" (
    "COD_EMPLEADO"  VARCHAR2(50),
    "FECHA"         DATE,
    "TABLA"         VARCHAR2(20 BYTE),
    "COD_OPERACION" CHAR(1 BYTE)
)
SEGMENT CREATION IMMEDIATE
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
TABLESPACE "USERS";

----------------------------------------------------------------------------------------------------------------
--  DDL for Index LINEAS_FACTURA_PK
----------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX "HR"."LINEAS_FACTURA_PK" ON
    "HR"."LINEAS_FACTURA" (
        "COD_FACTURA",
        "COD_PRODUCTO"
    )
        PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
        TABLESPACE "USERS";

----------------------------------------------------------------------------------------------------------------
--  Constraints for Table LINEAS_FACTURA
----------------------------------------------------------------------------------------------------------------

ALTER TABLE "HR"."LINEAS_FACTURA"
    ADD CONSTRAINT "LINEAS_FACTURA_PK" PRIMARY KEY ( "COD_FACTURA",
                                                     "COD_PRODUCTO" )
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT )
        TABLESPACE "USERS"
    ENABLE;

ALTER TABLE "HR"."LINEAS_FACTURA" MODIFY (
    "COD_PRODUCTO"
        NOT NULL ENABLE
);

ALTER TABLE "HR"."LINEAS_FACTURA" MODIFY (
    "COD_FACTURA"
        NOT NULL ENABLE
);


----------------------------------------------------------------------------------------------------------------
--  Inserts into Table PRODUCTOS
----------------------------------------------------------------------------------------------------------------
REM INSERTING into HR.PRODUCTOS
SET DEFINE OFF;

INSERT INTO HR.PRODUCTOS (COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDOS) VALUES ('1','TORNILLO','1',null);
INSERT INTO HR.PRODUCTOS (COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDOS) VALUES ('2','TUERCA','5',null);
INSERT INTO HR.PRODUCTOS (COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDOS) VALUES ('3','ARANDELA','4',null);
INSERT INTO HR.PRODUCTOS (COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDOS) VALUES ('4','MARTILLO','40',null);
INSERT INTO HR.PRODUCTOS (COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDOS) VALUES ('5','CLAVO','1',null);
COMMIT;