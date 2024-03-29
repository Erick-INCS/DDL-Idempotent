
SET TERM !!;
EXECUTE block as
BEGIN

	IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'MV_COVES')) THEN
    EXECUTE STATEMENT 'CREATE TABLE MV_COVES(  MC_FMANIFESTACION VARCHAR(8) NOT NULL,  MC_COVE VARCHAR(20) NOT NULL,  MC_VALORACION VARCHAR(20),  CONSTRAINT PK_COVE_MV_COVES PRIMARY KEY (MC_FMANIFESTACION, MC_COVE),  CONSTRAINT FK_MV_COVES_VALORACION FOREIGN KEY(MC_VALORACION) REFERENCES MANIFVALOR_VAL(MVV_CLAVE))';

	IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'MV_COVE_PEDIMENTO')) THEN
    EXECUTE STATEMENT 'CREATE TABLE MV_COVE_PEDIMENTO (  MCP_FMANIFESTACION VARCHAR(8),  MCP_COVE VARCHAR(20) NOT NULL,  MCP_PEDIMENTO PEDIMENTO NOT NULL,  MCP_PANTENTE VARCHAR(10) NOT NULL,  MCP_ADUANA CHAR(3) NOT NULL,  CONSTRAINT PK_M_COVE_PED PRIMARY KEY (MCP_FMANIFESTACION, MCP_COVE, MCP_PEDIMENTO),  CONSTRAINT FK_M_COVE_PED_COVE FOREIGN KEY (MCP_FMANIFESTACION, MCP_COVE) REFERENCES MV_COVES(MC_FMANIFESTACION, MC_COVE),  CONSTRAINT FK_M_COVE_PED_PATENTE FOREIGN KEY (MCP_PANTENTE) REFERENCES AGENTESA(AG_PATENTE))';

	IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'MV_COVE_INCREM')) THEN
    EXECUTE STATEMENT 'CREATE TABLE MV_COVE_INCREM (  MCI_FMANIFESTACION VARCHAR(8),  MCI_COVE VARCHAR(20) NOT NULL,  MCI_TIPO varchar(20) NOT NULL,  MCI_FECHAEROGACION TIMESTAMP NOT NULL,  MCI_IMPORTE MONEDA NOT NULL,  MCI_ACARGOIMPORTADOR INT(1),  CONSTRAINT PK_M_COVE_INCREM PRIMARY KEY (MCI_FMANIFESTACION, MCI_COVE, MCI_TIPO),  CONSTRAINT FK_M_COVE_INCREM_COVE FOREIGN KEY (MCI_FMANIFESTACION, MCI_COVE) REFERENCES MV_COVES(MC_FMANIFESTACION, MC_COVE),  CONSTRAINT FK_M_COVE_INCREM_INCREM FOREIGN KEY (MCI_TIPO) REFERENCES MANIFVALOR_INCREM(MCI_TIPO))';

	IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'MV_COVE_DECREM')) THEN
    EXECUTE STATEMENT 'CREATE TABLE MV_COVE_DECREM (  MCD_FMANIFESTACION VARCHAR(8),  MCD_COVE VARCHAR(20) NOT NULL,  MCD_TIPO varchar(20) NOT NULL,  MCD_FECHAEROGACION TIMESTAMP NOT NULL,  MCD_IMPORTE MONEDA NOT NULL,  CONSTRAINT PK_M_COVE_DECREM PRIMARY KEY (MCD_FMANIFESTACION, MCD_COVE, MCD_TIPO),  CONSTRAINT FK_M_COVE_DECREM_COVE FOREIGN KEY (MCD_FMANIFESTACION, MCD_COVE) REFERENCES MV_COVES(MC_FMANIFESTACION, MC_COVE),  CONSTRAINT FK_M_COVE_DECREM_DECREM FOREIGN KEY (MCD_TIPO) REFERENCES MANIFVALOR_DECREM(MCD_TIPO))';

	IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'MV_COVE_PPAGADO')) THEN
    EXECUTE STATEMENT 'CREATE TABLE MV_COVE_PPAGADO (  MCPA_FMANIFESTACION VARCHAR(8),  MCPA_COVE VARCHAR(20) NOT NULL,  MCPA_FPAGO TIMESTAMP NOT NULL,  MCPA_TOTAL MONEDA NOT NULL,  MCPA_TPAGO VARCHAR(20) NOT NULL,  MCAP_ESPECIFIQUE VARCHAR(70),  CONSTRAINT PK_M_COVE_PPAG PRIMARY KEY (MCPA_FMANIFESTACION, MCPA_COVE, MCPA_FPAGO, MCPA_TPAGO),  CONSTRAINT FK_M_COVE_PPAG_COVE FOREIGN KEY (MCPA_FMANIFESTACION, MCPA_COVE) REFERENCES MV_COVES(MC_FMANIFESTACION, MC_COVE),  CONSTRAINT FK_M_COVE_PPAG_TPAFO FOREIGN KEY (MCPA_TPAGO) REFERENCES MANIFVALOR_FORMAPAGO(MVF_CLAVE))';

	IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'MV_COVE_PPPAGAR')) THEN
    EXECUTE STATEMENT 'CREATE TABLE MV_COVE_PPPAGAR (  MCPG_FMANIFESTACION VARCHAR(8),  MCPG_COVE VARCHAR(20) NOT NULL,  MCPG_FPAGO TIMESTAMP NOT NULL,  MCPG_TOTAL MONEDA NOT NULL,  MCPG_SITUACION TEXT,  MCPG_TPAGO VARCHAR(20) NOT NULL,  MCAG_ESPECIFIQUE VARCHAR(70),  CONSTRAINT PK_M_COVE_PPPAG PRIMARY KEY (MCPG_FMANIFESTACION, MCPG_COVE, MCPG_FPAGO, MCPG_TPAGO),  CONSTRAINT FK_M_COVE_PPPAG_COVE FOREIGN KEY (MCPG_FMANIFESTACION, MCPG_COVE) REFERENCES MV_COVES(MC_FMANIFESTACION, MC_COVE),  CONSTRAINT FK_M_COVE_PPPAG_TPAFO FOREIGN KEY (MCPG_TPAGO) REFERENCES MANIFVALOR_FORMAPAGO(MVF_CLAVE))';

	IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'MV_COVE_CPAGO')) THEN
    EXECUTE STATEMENT 'CREATE TABLE MV_COVE_CPAGO (  MCPG_FMANIFESTACION VARCHAR(8),  MCPG_COVE VARCHAR(20) NOT NULL,  MCPG_FPAGO TIMESTAMP NOT NULL,  MCPG_TOTAL MONEDA NOT NULL,  MCPG_SITUACION TEXT,  MCPG_TPAGO VARCHAR(20) NOT NULL,  MCAG_ESPECIFIQUE VARCHAR(70),  CONSTRAINT PK_M_COVE_PPPAG PRIMARY KEY (MCPG_FMANIFESTACION, MCPG_COVE, MCPG_FPAGO, MCPG_TPAGO),  CONSTRAINT FK_M_COVE_PPPAG_COVE FOREIGN KEY (MCPG_FMANIFESTACION, MCPG_COVE) REFERENCES MV_COVES(MC_FMANIFESTACION, MC_COVE),  CONSTRAINT FK_M_COVE_PPPAG_TPAFO FOREIGN KEY (MCPG_TPAGO) REFERENCES MANIFVALOR_FORMAPAGO(MVF_CLAVE))';

END!!
SET TERM ; !!