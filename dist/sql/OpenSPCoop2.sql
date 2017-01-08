

-- OpenSPCoop2



-- OpenSPCoop2

-- **** Repository Buste ****

CREATE TABLE REPOSITORY_BUSTE
(
	ID_MESSAGGIO VARCHAR(255) NOT NULL,
	TIPO VARCHAR(255) NOT NULL,
	MITTENTE VARCHAR(255) NOT NULL,
	IDPORTA_MITTENTE VARCHAR(255),
	TIPO_MITTENTE VARCHAR(255) NOT NULL,
	IND_TELEMATICO_MITT VARCHAR(255),
	DESTINATARIO VARCHAR(255) NOT NULL,
	IDPORTA_DESTINATARIO VARCHAR(255),
	TIPO_DESTINATARIO VARCHAR(255) NOT NULL,
	IND_TELEMATICO_DEST VARCHAR(255),
	VERSIONE_SERVIZIO VARCHAR(255),
	SERVIZIO VARCHAR(255),
	TIPO_SERVIZIO VARCHAR(255),
	AZIONE VARCHAR(255),
	PROFILO_DI_COLLABORAZIONE VARCHAR(255),
	SERVIZIO_CORRELATO VARCHAR(255),
	TIPO_SERVIZIO_CORRELATO VARCHAR(255),
	COLLABORAZIONE VARCHAR(255),
	SEQUENZA INT,
	INOLTRO_SENZA_DUPLICATI INT NOT NULL,
	CONFERMA_RICEZIONE INT NOT NULL,
	ORA_REGISTRAZIONE TIMESTAMP,
	TIPO_ORA_REGISTRAZIONE VARCHAR(255),
	RIFERIMENTO_MESSAGGIO VARCHAR(255),
	SCADENZA_BUSTA TIMESTAMP NOT NULL,
	DUPLICATI INT NOT NULL,
	-- Dati di integrazione
	LOCATION_PD VARCHAR(255),
	SERVIZIO_APPLICATIVO VARCHAR(255),
	MODULO_IN_ATTESA VARCHAR(255),
	SCENARIO VARCHAR(255),
	PROTOCOLLO VARCHAR(255) NOT NULL,
	-- Booleani che indicano l'attuali modalita' di utilizzo del repository:
	--  HISTORY: Busta usata per funzionalita di confermaRicezione(OUTBOX)/FiltroDuplicati(INBOX)
	--  PROFILI: Busta usata per funzionalita di profili di collaborazione
	--  PDD:     Busta usata eventualmente da un PdD
	--  
	--  DEFAULT CONTROLLER: 3 interi con semantica booleana (1->true, 0->false)
	HISTORY INT NOT NULL DEFAULT 0,
	PROFILO INT NOT NULL DEFAULT 0,
	PDD INT NOT NULL DEFAULT 0,
	REPOSITORY_ACCESS INT NOT NULL DEFAULT 0,
	-- fk/pk columns
	-- check constraints
	CONSTRAINT chk_REPOSITORY_BUSTE_1 CHECK (TIPO IN ('INBOX','OUTBOX')),
	-- fk/pk keys constraints
	CONSTRAINT pk_REPOSITORY_BUSTE PRIMARY KEY (ID_MESSAGGIO,TIPO)
);

-- index
CREATE INDEX REP_BUSTE_SEARCH ON REPOSITORY_BUSTE (SCADENZA_BUSTA,TIPO,HISTORY,PROFILO,PDD);
CREATE INDEX REP_BUSTE_SEARCH_RA ON REPOSITORY_BUSTE (SCADENZA_BUSTA,TIPO,REPOSITORY_ACCESS);
CREATE INDEX REP_BUSTE_SEARCH_TIPO ON REPOSITORY_BUSTE (TIPO,HISTORY,PROFILO,PDD);
CREATE INDEX REP_BUSTE_SEARCH_TIPO_RA ON REPOSITORY_BUSTE (TIPO,REPOSITORY_ACCESS);

CREATE SEQUENCE seq_LISTA_RISCONTRI start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE LISTA_RISCONTRI
(
	ID_MESSAGGIO VARCHAR(255) NOT NULL,
	TIPO VARCHAR(255) NOT NULL,
	ID_RISCONTRO VARCHAR(255),
	ORA_REGISTRAZIONE TIMESTAMP,
	TIPO_ORA_REGISTRAZIONE VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_LISTA_RISCONTRI') NOT NULL,
	-- check constraints
	CONSTRAINT chk_LISTA_RISCONTRI_1 CHECK (TIPO IN ('INBOX','OUTBOX')),
	-- fk/pk keys constraints
	CONSTRAINT fk_LISTA_RISCONTRI_1 FOREIGN KEY (ID_MESSAGGIO,TIPO) REFERENCES REPOSITORY_BUSTE(ID_MESSAGGIO,TIPO) ON DELETE CASCADE,
	CONSTRAINT pk_LISTA_RISCONTRI PRIMARY KEY (id)
);

-- index
CREATE INDEX LISTA_RISC_ID ON LISTA_RISCONTRI (ID_MESSAGGIO,TIPO);



CREATE SEQUENCE seq_LISTA_TRASMISSIONI start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE LISTA_TRASMISSIONI
(
	ID_MESSAGGIO VARCHAR(255) NOT NULL,
	TIPO VARCHAR(255) NOT NULL,
	ORIGINE VARCHAR(255),
	TIPO_ORIGINE VARCHAR(255),
	DESTINAZIONE VARCHAR(255),
	TIPO_DESTINAZIONE VARCHAR(255),
	ORA_REGISTRAZIONE TIMESTAMP,
	TIPO_ORA_REGISTRAZIONE VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_LISTA_TRASMISSIONI') NOT NULL,
	-- check constraints
	CONSTRAINT chk_LISTA_TRASMISSIONI_1 CHECK (TIPO IN ('INBOX','OUTBOX')),
	-- fk/pk keys constraints
	CONSTRAINT fk_LISTA_TRASMISSIONI_1 FOREIGN KEY (ID_MESSAGGIO,TIPO) REFERENCES REPOSITORY_BUSTE(ID_MESSAGGIO,TIPO) ON DELETE CASCADE,
	CONSTRAINT pk_LISTA_TRASMISSIONI PRIMARY KEY (id)
);

-- index
CREATE INDEX LISTA_TRASM_ID ON LISTA_TRASMISSIONI (ID_MESSAGGIO,TIPO);



CREATE SEQUENCE seq_LISTA_ECCEZIONI start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE LISTA_ECCEZIONI
(
	ID_MESSAGGIO VARCHAR(255) NOT NULL,
	TIPO VARCHAR(255) NOT NULL,
	VALIDAZIONE INT,
	CONTESTO VARCHAR(255),
	CODICE VARCHAR(255),
	RILEVANZA VARCHAR(255),
	POSIZIONE TEXT,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_LISTA_ECCEZIONI') NOT NULL,
	-- check constraints
	CONSTRAINT chk_LISTA_ECCEZIONI_1 CHECK (TIPO IN ('INBOX','OUTBOX')),
	-- fk/pk keys constraints
	CONSTRAINT fk_LISTA_ECCEZIONI_1 FOREIGN KEY (ID_MESSAGGIO,TIPO) REFERENCES REPOSITORY_BUSTE(ID_MESSAGGIO,TIPO) ON DELETE CASCADE,
	CONSTRAINT pk_LISTA_ECCEZIONI PRIMARY KEY (id)
);

-- index
CREATE INDEX LISTA_ECC_ID ON LISTA_ECCEZIONI (ID_MESSAGGIO,TIPO);
CREATE INDEX LISTA_ECC_VALIDAZIONE ON LISTA_ECCEZIONI (ID_MESSAGGIO,TIPO,VALIDAZIONE);



CREATE SEQUENCE seq_LISTA_EXT_PROTOCOL_INFO start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE LISTA_EXT_PROTOCOL_INFO
(
	ID_MESSAGGIO VARCHAR(255) NOT NULL,
	TIPO VARCHAR(255) NOT NULL,
	NOME VARCHAR(255) NOT NULL,
	VALORE TEXT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_LISTA_EXT_PROTOCOL_INFO') NOT NULL,
	-- check constraints
	CONSTRAINT chk_LISTA_EXT_PROTOCOL_INFO_1 CHECK (TIPO IN ('INBOX','OUTBOX')),
	-- fk/pk keys constraints
	CONSTRAINT fk_LISTA_EXT_PROTOCOL_INFO_1 FOREIGN KEY (ID_MESSAGGIO,TIPO) REFERENCES REPOSITORY_BUSTE(ID_MESSAGGIO,TIPO) ON DELETE CASCADE,
	CONSTRAINT pk_LISTA_EXT_PROTOCOL_INFO PRIMARY KEY (id)
);

-- index
CREATE INDEX LISTA_EXT_ID ON LISTA_EXT_PROTOCOL_INFO (ID_MESSAGGIO,TIPO);



-- **** Riscontri ****

CREATE TABLE RISCONTRI_DA_RICEVERE
(
	ID_MESSAGGIO VARCHAR(255) NOT NULL,
	DATA_INVIO TIMESTAMP NOT NULL,
	-- fk/pk columns
	-- fk/pk keys constraints
	CONSTRAINT pk_RISCONTRI_DA_RICEVERE PRIMARY KEY (ID_MESSAGGIO)
);

-- index
CREATE INDEX RISCONTRI_NON_RICEVUTI ON RISCONTRI_DA_RICEVERE (DATA_INVIO);

-- **** Sequenze ****

CREATE TABLE SEQUENZA_DA_INVIARE
(
	MITTENTE VARCHAR(255) NOT NULL,
	TIPO_MITTENTE VARCHAR(255) NOT NULL,
	DESTINATARIO VARCHAR(255) NOT NULL,
	TIPO_DESTINATARIO VARCHAR(255) NOT NULL,
	SERVIZIO VARCHAR(255) NOT NULL,
	TIPO_SERVIZIO VARCHAR(255) NOT NULL,
	AZIONE VARCHAR(255) NOT NULL DEFAULT '',
	PROSSIMA_SEQUENZA INT NOT NULL,
	ID_COLLABORAZIONE VARCHAR(255) NOT NULL,
	-- fk/pk columns
	-- fk/pk keys constraints
	CONSTRAINT pk_SEQUENZA_DA_INVIARE PRIMARY KEY (MITTENTE,TIPO_MITTENTE,DESTINATARIO,TIPO_DESTINATARIO,SERVIZIO,TIPO_SERVIZIO,AZIONE)
);


CREATE TABLE SEQUENZA_DA_RICEVERE
(
	ID_COLLABORAZIONE VARCHAR(255) NOT NULL,
	SEQUENZA_ATTESA INT NOT NULL,
	-- le informazioni su mitt/dest/servizio/azione servono per un controllo di validazione sulla collaborazione
	MITTENTE VARCHAR(255) NOT NULL,
	TIPO_MITTENTE VARCHAR(255) NOT NULL,
	DESTINATARIO VARCHAR(255) NOT NULL,
	TIPO_DESTINATARIO VARCHAR(255) NOT NULL,
	SERVIZIO VARCHAR(255) NOT NULL,
	TIPO_SERVIZIO VARCHAR(255) NOT NULL,
	AZIONE VARCHAR(255),
	-- fk/pk columns
	-- fk/pk keys constraints
	CONSTRAINT pk_SEQUENZA_DA_RICEVERE PRIMARY KEY (ID_COLLABORAZIONE)
);


-- **** Asincroni ****

CREATE TABLE ASINCRONO
(
	ID_MESSAGGIO VARCHAR(255) NOT NULL,
	TIPO VARCHAR(255) NOT NULL,
	ORA_REGISTRAZIONE TIMESTAMP NOT NULL,
	RICEVUTA_ASINCRONA INT NOT NULL,
	TIPO_SERVIZIO_CORRELATO VARCHAR(255),
	SERVIZIO_CORRELATO VARCHAR(255),
	-- per diversificare il flusso di richiesta/ricevuta da risposta(richiestaStato)/ricevuta(Risposta)
	IS_RICHIESTA INT NOT NULL,
	ID_ASINCRONO VARCHAR(255) NOT NULL,
	ID_COLLABORAZIONE VARCHAR(255),
	-- 1 se la ricevuta applicativa e' abilitata, 0 se non lo e'
	RICEVUTA_APPLICATIVA INT NOT NULL,
	-- serve per la re-spedizione di una risposta asincrona
	BACKUP_ID_RICHIESTA VARCHAR(255),
	-- fk/pk columns
	-- check constraints
	CONSTRAINT chk_ASINCRONO_1 CHECK (TIPO IN ('INBOX','OUTBOX')),
	-- fk/pk keys constraints
	CONSTRAINT pk_ASINCRONO PRIMARY KEY (ID_MESSAGGIO,TIPO)
);

-- index
CREATE INDEX ASINCRONO_BACKUP_ID ON ASINCRONO (BACKUP_ID_RICHIESTA);
CREATE INDEX ASINCRONO_IS_RICEVUTA ON ASINCRONO (ID_MESSAGGIO,TIPO,RICEVUTA_ASINCRONA);
CREATE INDEX ASINCRONO_NON_RICEVUTE ON ASINCRONO (ORA_REGISTRAZIONE,TIPO,RICEVUTA_ASINCRONA,RICEVUTA_APPLICATIVA);


-- openspcoop2
		  		
-- **** Serial for ID ****

CREATE TABLE ID_MESSAGGIO
(
	COUNTER BIGINT NOT NULL,
	PROTOCOLLO VARCHAR(255) NOT NULL,
	ora_registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	-- fk/pk columns
	-- fk/pk keys constraints
	CONSTRAINT pk_ID_MESSAGGIO PRIMARY KEY (PROTOCOLLO)
);


CREATE TABLE ID_MESSAGGIO_RELATIVO
(
	COUNTER BIGINT NOT NULL,
	PROTOCOLLO VARCHAR(255) NOT NULL,
	INFO_ASSOCIATA VARCHAR(255) NOT NULL,
	ora_registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	-- fk/pk columns
	-- fk/pk keys constraints
	CONSTRAINT pk_ID_MESSAGGIO_RELATIVO PRIMARY KEY (PROTOCOLLO,INFO_ASSOCIATA)
);


CREATE TABLE ID_MESSAGGIO_PRG
(
	PROGRESSIVO VARCHAR(255) NOT NULL,
	PROTOCOLLO VARCHAR(255) NOT NULL,
	ora_registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	-- fk/pk columns
	-- fk/pk keys constraints
	CONSTRAINT pk_ID_MESSAGGIO_PRG PRIMARY KEY (PROTOCOLLO)
);


CREATE TABLE ID_MESSAGGIO_RELATIVO_PRG
(
	PROGRESSIVO VARCHAR(255) NOT NULL,
	PROTOCOLLO VARCHAR(255) NOT NULL,
	INFO_ASSOCIATA VARCHAR(255) NOT NULL,
	ora_registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	-- fk/pk columns
	-- fk/pk keys constraints
	CONSTRAINT pk_ID_MESSAGGIO_RELATIVO_PRG PRIMARY KEY (PROTOCOLLO,INFO_ASSOCIATA)
);



-- openspcoop2
		  		
-- **** Messaggi ****

CREATE TABLE MESSAGGI
(
	ID_MESSAGGIO VARCHAR(255) NOT NULL,
	TIPO VARCHAR(255) NOT NULL,
	RIFERIMENTO_MSG VARCHAR(255),
	ERRORE_PROCESSAMENTO TEXT,
	-- data dalla quale il msg puo' essere rispedito in caso di errori
	RISPEDIZIONE TIMESTAMP NOT NULL,
	ORA_REGISTRAZIONE TIMESTAMP NOT NULL,
	PROPRIETARIO VARCHAR(255),
	-- le colonne seguenti servono per il servizio di TransactionManager
	MOD_RICEZ_CONT_APPLICATIVI VARCHAR(255),
	MOD_RICEZ_BUSTE VARCHAR(255),
	MOD_INOLTRO_BUSTE VARCHAR(255),
	MOD_INOLTRO_RISPOSTE VARCHAR(255),
	MOD_IMBUSTAMENTO VARCHAR(255),
	MOD_IMBUSTAMENTO_RISPOSTE VARCHAR(255),
	MOD_SBUSTAMENTO VARCHAR(255),
	MOD_SBUSTAMENTO_RISPOSTE VARCHAR(255),
	-- Thread Pool:impedisce la gestione di messaggi gia schedulati
	SCHEDULING INT DEFAULT 0,
	-- permette la riconsegna del messaggio dopo tot tempo
	REDELIVERY_DELAY TIMESTAMP NOT NULL,
	-- numero di riconsegne effettuate
	REDELIVERY_COUNT INT DEFAULT 0,
	-- id del nodo del cluster che deve gestire questo messaggio.
	CLUSTER_ID VARCHAR(255),
	-- memorizza l'ora in cui il messaggio e stato schedulato la prima volta
	SCHEDULING_TIME TIMESTAMP,
	-- contiene un messaggio serializzato
	MSG_BYTES BYTEA,
	CORRELAZIONE_APPLICATIVA VARCHAR(255),
	CORRELAZIONE_RISPOSTA VARCHAR(255),
	PROTOCOLLO VARCHAR(255) NOT NULL,
	-- fk/pk columns
	-- check constraints
	CONSTRAINT chk_MESSAGGI_1 CHECK (TIPO IN ('INBOX','OUTBOX')),
	-- fk/pk keys constraints
	CONSTRAINT pk_MESSAGGI PRIMARY KEY (ID_MESSAGGIO,TIPO)
);

-- index
CREATE INDEX MESSAGGI_SEARCH ON MESSAGGI (ORA_REGISTRAZIONE,RIFERIMENTO_MSG,TIPO,PROPRIETARIO);
CREATE INDEX MESSAGGI_RIFMSG ON MESSAGGI (RIFERIMENTO_MSG);
CREATE INDEX MESSAGGI_TESTSUITE ON MESSAGGI (PROPRIETARIO,ID_MESSAGGIO,RIFERIMENTO_MSG);

CREATE TABLE MSG_SERVIZI_APPLICATIVI
(
	ID_MESSAGGIO VARCHAR(255) NOT NULL,
	TIPO VARCHAR(255) NOT NULL DEFAULT 'INBOX',
	SERVIZIO_APPLICATIVO VARCHAR(255) NOT NULL,
	SBUSTAMENTO_SOAP INT NOT NULL,
	SBUSTAMENTO_INFO_PROTOCOL INT NOT NULL,
	INTEGRATION_MANAGER INT NOT NULL,
	MOD_CONSEGNA_CONT_APPLICATIVI VARCHAR(255),
	-- Assume il valore 'Connettore' se la consegna avviente tramite un connettore,
	-- 'ConnectionReply' se viene ritornato tramite connectionReply,
	-- 'IntegrationManager' se e' solo ottenibile tramite IntegrationManager
	TIPO_CONSEGNA VARCHAR(255) NOT NULL,
	ERRORE_PROCESSAMENTO TEXT,
	-- data dalla quale il msg puo' essere rispedito in caso di errori
	RISPEDIZIONE TIMESTAMP NOT NULL,
	NOME_PORTA VARCHAR(255),
	-- fk/pk columns
	-- check constraints
	CONSTRAINT chk_MSG_SERVIZI_APPLICATIVI_1 CHECK (TIPO IN ('INBOX','OUTBOX')),
	CONSTRAINT chk_MSG_SERVIZI_APPLICATIVI_2 CHECK (TIPO_CONSEGNA IN ('Connettore','ConnectionReply','IntegrationManager')),
	-- fk/pk keys constraints
	CONSTRAINT fk_MSG_SERVIZI_APPLICATIVI_1 FOREIGN KEY (ID_MESSAGGIO,TIPO) REFERENCES MESSAGGI(ID_MESSAGGIO,TIPO) ON DELETE CASCADE,
	CONSTRAINT pk_MSG_SERVIZI_APPLICATIVI PRIMARY KEY (ID_MESSAGGIO,SERVIZIO_APPLICATIVO)
);

-- index
CREATE INDEX MSG_SERV_APPL_LIST ON MSG_SERVIZI_APPLICATIVI (SERVIZIO_APPLICATIVO,INTEGRATION_MANAGER);
CREATE INDEX MSG_SERV_APPL_TIMEOUT ON MSG_SERVIZI_APPLICATIVI (ID_MESSAGGIO,TIPO_CONSEGNA,INTEGRATION_MANAGER);

CREATE TABLE DEFINIZIONE_MESSAGGI
(
	ID_MESSAGGIO VARCHAR(255) NOT NULL,
	TIPO VARCHAR(255) NOT NULL,
	SOAP_ACTION VARCHAR(255),
	CONTENT_TYPE VARCHAR(255) NOT NULL,
	CONTENT_LOCATION VARCHAR(255),
	MSG_BYTES BYTEA,
	-- fk/pk columns
	-- check constraints
	CONSTRAINT chk_DEFINIZIONE_MESSAGGI_1 CHECK (TIPO IN ('INBOX','OUTBOX')),
	-- fk/pk keys constraints
	CONSTRAINT fk_DEFINIZIONE_MESSAGGI_1 FOREIGN KEY (ID_MESSAGGIO,TIPO) REFERENCES MESSAGGI(ID_MESSAGGIO,TIPO) ON DELETE CASCADE,
	CONSTRAINT pk_DEFINIZIONE_MESSAGGI PRIMARY KEY (ID_MESSAGGIO,TIPO)
);


-- **** Correlazione Applicativa ****

CREATE SEQUENCE seq_CORRELAZIONE_APPLICATIVA start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE CORRELAZIONE_APPLICATIVA
(
	ID_MESSAGGIO VARCHAR(255) NOT NULL,
	ID_APPLICATIVO VARCHAR(255) NOT NULL,
	SERVIZIO_APPLICATIVO VARCHAR(255) NOT NULL,
	TIPO_MITTENTE VARCHAR(255) NOT NULL,
	MITTENTE VARCHAR(255) NOT NULL,
	TIPO_DESTINATARIO VARCHAR(255) NOT NULL,
	DESTINATARIO VARCHAR(255) NOT NULL,
	TIPO_SERVIZIO VARCHAR(255),
	SERVIZIO VARCHAR(255),
	AZIONE VARCHAR(255),
	SCADENZA TIMESTAMP,
	ora_registrazione TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_CORRELAZIONE_APPLICATIVA') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT pk_CORRELAZIONE_APPLICATIVA PRIMARY KEY (id)
);

-- index
CREATE INDEX CORR_APPL_SCADUTE ON CORRELAZIONE_APPLICATIVA (SCADENZA);
CREATE INDEX CORR_APPL_OLD ON CORRELAZIONE_APPLICATIVA (ora_registrazione);




-- openspcoop2
		  		
CREATE SEQUENCE seq_db_info start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE db_info
(
	major_version INT NOT NULL,
	minor_version INT NOT NULL,
	notes VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_db_info') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT pk_db_info PRIMARY KEY (id)
);





-- openspcoop2
		  		


INSERT INTO db_info (major_version,minor_version,notes) VALUES (2,3,'[OpenSPCoop_tags_2.3_ant_setup Revision N.12244, LastChangedRevision N.12244, 10/04/2016 01:37 PM] Database della Porta di Dominio OpenSPCoop2');

-- **** Porte di Dominio ****

CREATE SEQUENCE seq_pdd start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE pdd
(
	nome VARCHAR(255) NOT NULL,
	descrizione VARCHAR(255),
	-- ip pubblico
	ip VARCHAR(255),
	-- porta pubblico
	porta INT,
	-- protocollo pubblico
	protocollo VARCHAR(255),
	-- ip gestione
	ip_gestione VARCHAR(255),
	-- porta gestione
	porta_gestione INT,
	-- protocollo gestione
	protocollo_gestione VARCHAR(255),
	-- Tipo della Porta
	tipo VARCHAR(255),
	implementazione VARCHAR(255) DEFAULT 'standard',
	subject VARCHAR(255),
	password VARCHAR(255),
	-- client auth: disabilitato/abilitato
	client_auth VARCHAR(255),
	ora_registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	superuser VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_pdd') NOT NULL,
	-- check constraints
	CONSTRAINT chk_pdd_1 CHECK (tipo IN ('operativo','nonoperativo','esterno')),
	-- unique constraints
	CONSTRAINT unique_pdd_1 UNIQUE (nome),
	-- fk/pk keys constraints
	CONSTRAINT pk_pdd PRIMARY KEY (id)
);





-- openspcoop2
		  		
-- **** Connettori ****

CREATE SEQUENCE seq_connettori start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE connettori
(
	-- (disabilitato,http,jms)
	endpointtype VARCHAR(255) NOT NULL,
	nome_connettore VARCHAR(255) NOT NULL,
	-- url nel caso http
	url VARCHAR(255),
	-- nome coda jms
	nome VARCHAR(255),
	-- tipo coda jms (queue,topic)
	tipo VARCHAR(255),
	-- utente di una connessione jms
	utente VARCHAR(255),
	-- password per una connessione jms
	password VARCHAR(255),
	-- context property: initial_content
	initcont VARCHAR(255),
	-- context property: url_pkg
	urlpkg VARCHAR(255),
	-- context property: provider_url
	provurl VARCHAR(255),
	-- ConnectionFactory JMS
	connection_factory VARCHAR(255),
	-- Messaggio JMS inviato come text/byte message
	send_as VARCHAR(255),
	-- 1/0 (true/false) abilita il debug tramite il connettore
	debug INT DEFAULT 0,
	-- 1/0 (true/false) indica se il connettore e' gestito tramite le proprieta' custom
	custom INT DEFAULT 0,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_connettori') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_connettori_1 UNIQUE (nome_connettore),
	-- fk/pk keys constraints
	CONSTRAINT pk_connettori PRIMARY KEY (id)
);




CREATE SEQUENCE seq_connettori_custom start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE connettori_custom
(
	name VARCHAR(255) NOT NULL,
	value VARCHAR(255) NOT NULL,
	id_connettore BIGINT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_connettori_custom') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_connettori_custom_1 UNIQUE (id_connettore,name,value),
	-- fk/pk keys constraints
	CONSTRAINT fk_connettori_custom_1 FOREIGN KEY (id_connettore) REFERENCES connettori(id),
	CONSTRAINT pk_connettori_custom PRIMARY KEY (id)
);




CREATE SEQUENCE seq_connettori_properties start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE connettori_properties
(
	-- nome connettore personalizzato attraverso file properties
	nome_connettore VARCHAR(255) NOT NULL,
	-- location del file properties
	path VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_connettori_properties') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_connettori_properties_1 UNIQUE (nome_connettore),
	-- fk/pk keys constraints
	CONSTRAINT pk_connettori_properties PRIMARY KEY (id)
);





-- openspcoop2
		  		
-- **** Connettori Gestione Errore ****

CREATE SEQUENCE seq_gestione_errore start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE gestione_errore
(
	-- accetta/rispedisci
	comportamento_default VARCHAR(255),
	cadenza_rispedizione VARCHAR(255),
	nome VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_gestione_errore') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_gestione_errore_1 UNIQUE (nome),
	-- fk/pk keys constraints
	CONSTRAINT pk_gestione_errore PRIMARY KEY (id)
);




CREATE SEQUENCE seq_gestione_errore_trasporto start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE gestione_errore_trasporto
(
	id_gestione_errore BIGINT NOT NULL,
	valore_massimo INT,
	valore_minimo INT,
	-- accetta/rispedisci
	comportamento VARCHAR(255),
	cadenza_rispedizione VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_gestione_errore_trasporto') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_gestione_errore_trasporto_1 FOREIGN KEY (id_gestione_errore) REFERENCES gestione_errore(id),
	CONSTRAINT pk_gestione_errore_trasporto PRIMARY KEY (id)
);




CREATE SEQUENCE seq_gestione_errore_soap start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE gestione_errore_soap
(
	id_gestione_errore BIGINT NOT NULL,
	fault_actor VARCHAR(255),
	fault_code VARCHAR(255),
	fault_string VARCHAR(255),
	-- accetta/rispedisci
	comportamento VARCHAR(255),
	cadenza_rispedizione VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_gestione_errore_soap') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_gestione_errore_soap_1 FOREIGN KEY (id_gestione_errore) REFERENCES gestione_errore(id),
	CONSTRAINT pk_gestione_errore_soap PRIMARY KEY (id)
);





-- openspcoop2
		  		
-- **** Soggetti ****

CREATE SEQUENCE seq_soggetti start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE soggetti
(
	nome_soggetto VARCHAR(255) NOT NULL,
	tipo_soggetto VARCHAR(255) NOT NULL,
	descrizione VARCHAR(255),
	identificativo_porta VARCHAR(255),
	-- 1/0 (true/false) svolge attivita di router
	is_router INT DEFAULT 0,
	id_connettore BIGINT NOT NULL,
	superuser VARCHAR(255),
	server VARCHAR(255),
	-- 1/0 (true/false) indica se il soggetto e' privato/pubblico
	privato INT DEFAULT 0,
	ora_registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	profilo VARCHAR(255),
	codice_ipa VARCHAR(255) NOT NULL,
	pd_url_prefix_rewriter VARCHAR(255),
	pa_url_prefix_rewriter VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_soggetti') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_soggetti_1 UNIQUE (nome_soggetto,tipo_soggetto),
	CONSTRAINT unique_soggetti_2 UNIQUE (codice_ipa),
	-- fk/pk keys constraints
	CONSTRAINT fk_soggetti_1 FOREIGN KEY (id_connettore) REFERENCES connettori(id),
	CONSTRAINT pk_soggetti PRIMARY KEY (id)
);





-- openspcoop2
		  		
-- **** Documenti ****

CREATE SEQUENCE seq_documenti start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE documenti
(
	ruolo VARCHAR(255) NOT NULL,
	-- tipo (es. xsd,xml...)
	tipo VARCHAR(255) NOT NULL,
	-- nome documento
	nome VARCHAR(255) NOT NULL,
	-- contenuto documento
	contenuto BYTEA NOT NULL,
	-- idOggettoProprietarioDocumento
	id_proprietario BIGINT NOT NULL,
	-- tipoProprietario
	tipo_proprietario VARCHAR(255) NOT NULL,
	ora_registrazione TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_documenti') NOT NULL,
	-- check constraints
	CONSTRAINT chk_documenti_1 CHECK (ruolo IN ('allegato','specificaSemiformale','specificaLivelloServizio','specificaSicurezza','specificaCoordinamento')),
	CONSTRAINT chk_documenti_2 CHECK (tipo_proprietario IN ('accordoServizio','accordoCooperazione','servizio')),
	-- unique constraints
	CONSTRAINT unique_documenti_1 UNIQUE (ruolo,tipo,nome,id_proprietario,tipo_proprietario),
	-- fk/pk keys constraints
	CONSTRAINT pk_documenti PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_DOC_SEARCH ON documenti (id_proprietario);



-- **** Accordi di Servizio Parte Comune ****

CREATE SEQUENCE seq_accordi start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE accordi
(
	nome VARCHAR(255) NOT NULL,
	descrizione VARCHAR(255),
	profilo_collaborazione VARCHAR(255),
	wsdl_definitorio TEXT,
	wsdl_concettuale TEXT,
	wsdl_logico_erogatore TEXT,
	wsdl_logico_fruitore TEXT,
	spec_conv_concettuale TEXT,
	spec_conv_erogatore TEXT,
	spec_conv_fruitore TEXT,
	filtro_duplicati VARCHAR(255),
	conferma_ricezione VARCHAR(255),
	identificativo_collaborazione VARCHAR(255),
	consegna_in_ordine VARCHAR(255),
	scadenza VARCHAR(255),
	superuser VARCHAR(255),
	-- id del soggetto referente
	id_referente BIGINT DEFAULT 0,
	versione VARCHAR(255) DEFAULT '',
	-- 1/0 (vero/falso) indica se questo accordo di servizio e' utilizzabile in mancanza di azioni associate
	utilizzo_senza_azione INT DEFAULT 1,
	-- 1/0 (true/false) indica se il soggetto e' privato/pubblico
	privato INT DEFAULT 0,
	ora_registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	stato VARCHAR(255) NOT NULL DEFAULT 'finale',
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_accordi') NOT NULL,
	-- check constraints
	CONSTRAINT chk_accordi_1 CHECK (stato IN ('finale','bozza','operativo')),
	-- unique constraints
	CONSTRAINT unique_accordi_1 UNIQUE (nome,id_referente,versione),
	-- fk/pk keys constraints
	CONSTRAINT pk_accordi PRIMARY KEY (id)
);




CREATE SEQUENCE seq_accordi_azioni start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE accordi_azioni
(
	id_accordo BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	profilo_collaborazione VARCHAR(255),
	filtro_duplicati VARCHAR(255),
	conferma_ricezione VARCHAR(255),
	identificativo_collaborazione VARCHAR(255),
	consegna_in_ordine VARCHAR(255),
	scadenza VARCHAR(255),
	correlata VARCHAR(255),
	-- ridefinito/default
	profilo_azione VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_accordi_azioni') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_accordi_azioni_1 UNIQUE (id_accordo,nome),
	-- fk/pk keys constraints
	CONSTRAINT fk_accordi_azioni_1 FOREIGN KEY (id_accordo) REFERENCES accordi(id),
	CONSTRAINT pk_accordi_azioni PRIMARY KEY (id)
);




CREATE SEQUENCE seq_port_type start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE port_type
(
	id_accordo BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	descrizione VARCHAR(255),
	profilo_collaborazione VARCHAR(255),
	filtro_duplicati VARCHAR(255),
	conferma_ricezione VARCHAR(255),
	identificativo_collaborazione VARCHAR(255),
	consegna_in_ordine VARCHAR(255),
	scadenza VARCHAR(255),
	-- ridefinito/default
	profilo_pt VARCHAR(255),
	-- document/RPC
	soap_style VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_port_type') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_port_type_1 UNIQUE (id_accordo,nome),
	-- fk/pk keys constraints
	CONSTRAINT fk_port_type_1 FOREIGN KEY (id_accordo) REFERENCES accordi(id),
	CONSTRAINT pk_port_type PRIMARY KEY (id)
);




CREATE SEQUENCE seq_port_type_azioni start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE port_type_azioni
(
	id_port_type BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	profilo_collaborazione VARCHAR(255),
	filtro_duplicati VARCHAR(255),
	conferma_ricezione VARCHAR(255),
	identificativo_collaborazione VARCHAR(255),
	consegna_in_ordine VARCHAR(255),
	scadenza VARCHAR(255),
	correlata_servizio VARCHAR(255),
	correlata VARCHAR(255),
	-- ridefinito/default
	profilo_pt_azione VARCHAR(255),
	-- document/rpc
	soap_style VARCHAR(255),
	soap_action VARCHAR(255),
	-- literal/encoded
	soap_use_msg_input VARCHAR(255),
	-- namespace utilizzato per RPC
	soap_namespace_msg_input VARCHAR(255),
	-- literal/encoded
	soap_use_msg_output VARCHAR(255),
	-- namespace utilizzato per RPC
	soap_namespace_msg_output VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_port_type_azioni') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_port_type_azioni_1 UNIQUE (id_port_type,nome),
	-- fk/pk keys constraints
	CONSTRAINT fk_port_type_azioni_1 FOREIGN KEY (id_port_type) REFERENCES port_type(id),
	CONSTRAINT pk_port_type_azioni PRIMARY KEY (id)
);




CREATE SEQUENCE seq_operation_messages start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE operation_messages
(
	id_port_type_azione BIGINT NOT NULL,
	-- true(1)/false(0), true indica un input-message, false un output-message
	input_message INT DEFAULT 1,
	name VARCHAR(255) NOT NULL,
	element_name VARCHAR(255),
	element_namespace VARCHAR(255),
	type_name VARCHAR(255),
	type_namespace VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_operation_messages') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_operation_messages_1 FOREIGN KEY (id_port_type_azione) REFERENCES port_type_azioni(id),
	CONSTRAINT pk_operation_messages PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_OP_MESSAGES ON operation_messages (id_port_type_azione,input_message);



-- **** Accordi di Cooperazione ****

CREATE SEQUENCE seq_accordi_cooperazione start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE accordi_cooperazione
(
	nome VARCHAR(255) NOT NULL,
	descrizione VARCHAR(255),
	-- id del soggetto referente
	id_referente BIGINT DEFAULT 0,
	versione VARCHAR(255) DEFAULT '',
	stato VARCHAR(255) NOT NULL DEFAULT 'finale',
	-- 1/0 (true/false) indica se il soggetto e' privato/pubblico
	privato INT DEFAULT 0,
	superuser VARCHAR(255),
	ora_registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_accordi_cooperazione') NOT NULL,
	-- check constraints
	CONSTRAINT chk_accordi_cooperazione_1 CHECK (stato IN ('finale','bozza','operativo')),
	-- unique constraints
	CONSTRAINT unique_accordi_cooperazione_1 UNIQUE (nome,versione),
	-- fk/pk keys constraints
	CONSTRAINT pk_accordi_cooperazione PRIMARY KEY (id)
);




CREATE SEQUENCE seq_accordi_coop_partecipanti start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE accordi_coop_partecipanti
(
	id_accordo_cooperazione BIGINT NOT NULL,
	id_soggetto BIGINT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_accordi_coop_partecipanti') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_acc_coop_part_1 UNIQUE (id_accordo_cooperazione,id_soggetto),
	-- fk/pk keys constraints
	CONSTRAINT fk_accordi_coop_partecipanti_1 FOREIGN KEY (id_soggetto) REFERENCES soggetti(id),
	CONSTRAINT fk_accordi_coop_partecipanti_2 FOREIGN KEY (id_accordo_cooperazione) REFERENCES accordi_cooperazione(id),
	CONSTRAINT pk_accordi_coop_partecipanti PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_AC_COOP_PAR ON accordi_coop_partecipanti (id_accordo_cooperazione);



-- **** Accordi di Servizio Parte Specifica ****

CREATE SEQUENCE seq_servizi start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE servizi
(
	nome_servizio VARCHAR(255) NOT NULL,
	tipo_servizio VARCHAR(255) NOT NULL,
	id_soggetto BIGINT NOT NULL,
	id_accordo BIGINT NOT NULL,
	servizio_correlato VARCHAR(255),
	id_connettore BIGINT NOT NULL,
	wsdl_implementativo_erogatore TEXT,
	wsdl_implementativo_fruitore TEXT,
	superuser VARCHAR(255),
	-- 1/0 (true/false) indica se il soggetto e' privato/pubblico
	privato INT DEFAULT 0,
	ora_registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	port_type VARCHAR(255),
	profilo VARCHAR(255),
	descrizione VARCHAR(255),
	stato VARCHAR(255) NOT NULL DEFAULT 'finale',
	-- identificativi accordo di servizio parte specifica
	aps_nome VARCHAR(255),
	aps_versione VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_servizi') NOT NULL,
	-- check constraints
	CONSTRAINT chk_servizi_1 CHECK (stato IN ('finale','bozza','operativo')),
	-- unique constraints
	CONSTRAINT unique_servizi_1 UNIQUE (nome_servizio,tipo_servizio,id_soggetto),
	-- fk/pk keys constraints
	CONSTRAINT fk_servizi_1 FOREIGN KEY (id_connettore) REFERENCES connettori(id),
	CONSTRAINT fk_servizi_2 FOREIGN KEY (id_soggetto) REFERENCES soggetti(id),
	CONSTRAINT fk_servizi_3 FOREIGN KEY (id_accordo) REFERENCES accordi(id),
	CONSTRAINT pk_servizi PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_APS ON servizi (aps_nome,aps_versione,id_soggetto);



CREATE SEQUENCE seq_servizi_fruitori start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE servizi_fruitori
(
	id_servizio BIGINT NOT NULL,
	id_soggetto BIGINT NOT NULL,
	id_connettore BIGINT NOT NULL,
	wsdl_implementativo_erogatore TEXT,
	wsdl_implementativo_fruitore TEXT,
	ora_registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	profilo VARCHAR(255),
	-- client auth: disabilitato/abilitato
	client_auth VARCHAR(255),
	stato VARCHAR(255) NOT NULL DEFAULT 'finale',
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_servizi_fruitori') NOT NULL,
	-- check constraints
	CONSTRAINT chk_servizi_fruitori_1 CHECK (stato IN ('finale','bozza','operativo')),
	-- unique constraints
	CONSTRAINT unique_servizi_fruitori_1 UNIQUE (id_servizio,id_soggetto),
	-- fk/pk keys constraints
	CONSTRAINT fk_servizi_fruitori_1 FOREIGN KEY (id_connettore) REFERENCES connettori(id),
	CONSTRAINT fk_servizi_fruitori_2 FOREIGN KEY (id_soggetto) REFERENCES soggetti(id),
	CONSTRAINT fk_servizi_fruitori_3 FOREIGN KEY (id_servizio) REFERENCES servizi(id),
	CONSTRAINT pk_servizi_fruitori PRIMARY KEY (id)
);




CREATE SEQUENCE seq_servizi_azioni start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE servizi_azioni
(
	nome_azione VARCHAR(255) NOT NULL,
	id_servizio BIGINT NOT NULL,
	id_connettore BIGINT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_servizi_azioni') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_servizi_azioni_1 UNIQUE (nome_azione,id_servizio),
	-- fk/pk keys constraints
	CONSTRAINT fk_servizi_azioni_1 FOREIGN KEY (id_connettore) REFERENCES connettori(id),
	CONSTRAINT fk_servizi_azioni_2 FOREIGN KEY (id_servizio) REFERENCES servizi(id),
	CONSTRAINT pk_servizi_azioni PRIMARY KEY (id)
);




-- **** Accordi di Servizio Composti ****

CREATE SEQUENCE seq_acc_serv_composti start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE acc_serv_composti
(
	id_accordo BIGINT NOT NULL,
	id_accordo_cooperazione BIGINT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_acc_serv_composti') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_acc_serv_composti_1 UNIQUE (id_accordo),
	-- fk/pk keys constraints
	CONSTRAINT fk_acc_serv_composti_1 FOREIGN KEY (id_accordo_cooperazione) REFERENCES accordi_cooperazione(id),
	CONSTRAINT fk_acc_serv_composti_2 FOREIGN KEY (id_accordo) REFERENCES accordi(id),
	CONSTRAINT pk_acc_serv_composti PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_AC_SC ON acc_serv_composti (id_accordo_cooperazione);



CREATE SEQUENCE seq_acc_serv_componenti start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE acc_serv_componenti
(
	id_servizio_composto BIGINT NOT NULL,
	id_servizio_componente BIGINT NOT NULL,
	azione VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_acc_serv_componenti') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_acc_serv_componenti_1 FOREIGN KEY (id_servizio_composto) REFERENCES acc_serv_composti(id),
	CONSTRAINT fk_acc_serv_componenti_2 FOREIGN KEY (id_servizio_componente) REFERENCES servizi(id),
	CONSTRAINT pk_acc_serv_componenti PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_AC_SC_SC ON acc_serv_componenti (id_servizio_composto);




-- openspcoop2
		  		
-- **** Servizi Applicativi ****

CREATE SEQUENCE seq_servizi_applicativi start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE servizi_applicativi
(
	nome VARCHAR(255) NOT NULL,
	descrizione VARCHAR(255),
	-- * Risposta Asincrona *
	-- valori 0/1 indicano rispettivamente FALSE/TRUE
	sbustamentorisp INT DEFAULT 0,
	getmsgrisp VARCHAR(255),
	-- FOREIGN KEY (id_gestione_errore_risp) REFERENCES gestione_errore(id) Nota: indica un eventuale tipologia di gestione dell'errore per la risposta asincrona
	id_gestione_errore_risp BIGINT,
	tipoauthrisp VARCHAR(255),
	utenterisp VARCHAR(255),
	passwordrisp VARCHAR(255),
	subjectrisp VARCHAR(255),
	invio_x_rif_risp VARCHAR(255),
	risposta_x_rif_risp VARCHAR(255),
	id_connettore_risp BIGINT NOT NULL,
	sbustamento_protocol_info_risp INT DEFAULT 1,
	-- * Invocazione Servizio *
	-- valori 0/1 indicano rispettivamente FALSE/TRUE
	sbustamentoinv INT DEFAULT 0,
	getmsginv VARCHAR(255),
	-- FOREIGN KEY (id_gestione_errore_inv) REFERENCES gestione_errore(id) Nota: indica un eventuale tipologia di gestione dell'errore per l'invocazione servizio
	id_gestione_errore_inv BIGINT,
	tipoauthinv VARCHAR(255),
	utenteinv VARCHAR(255),
	passwordinv VARCHAR(255),
	subjectinv VARCHAR(255),
	invio_x_rif_inv VARCHAR(255),
	risposta_x_rif_inv VARCHAR(255),
	id_connettore_inv BIGINT NOT NULL,
	sbustamento_protocol_info_inv INT DEFAULT 1,
	-- * SoggettoErogatore *
	id_soggetto BIGINT NOT NULL,
	-- * Invocazione Porta *
	fault VARCHAR(255),
	fault_actor VARCHAR(255),
	generic_fault_code VARCHAR(255),
	prefix_fault_code VARCHAR(255),
	tipoauth VARCHAR(255),
	utente VARCHAR(255),
	password VARCHAR(255),
	subject VARCHAR(255),
	invio_x_rif VARCHAR(255),
	sbustamento_protocol_info INT DEFAULT 1,
	tipologia_fruizione VARCHAR(255),
	tipologia_erogazione VARCHAR(255),
	ora_registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_servizi_applicativi') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_servizi_applicativi_1 UNIQUE (nome,id_soggetto),
	-- fk/pk keys constraints
	CONSTRAINT fk_servizi_applicativi_1 FOREIGN KEY (id_connettore_inv) REFERENCES connettori(id),
	CONSTRAINT fk_servizi_applicativi_2 FOREIGN KEY (id_soggetto) REFERENCES soggetti(id),
	CONSTRAINT pk_servizi_applicativi PRIMARY KEY (id)
);





-- openspcoop2
		  		
-- **** Ruoli ****

CREATE SEQUENCE seq_ruoli_sa start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE ruoli_sa
(
	id_accordo BIGINT NOT NULL,
	servizio_correlato INT NOT NULL,
	id_servizio_applicativo BIGINT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_ruoli_sa') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_ruoli_sa_1 UNIQUE (id_accordo,servizio_correlato,id_servizio_applicativo),
	-- fk/pk keys constraints
	CONSTRAINT fk_ruoli_sa_1 FOREIGN KEY (id_servizio_applicativo) REFERENCES servizi_applicativi(id),
	CONSTRAINT fk_ruoli_sa_2 FOREIGN KEY (id_accordo) REFERENCES accordi(id),
	CONSTRAINT pk_ruoli_sa PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_RUOLI ON ruoli_sa (id_accordo,servizio_correlato);
CREATE INDEX INDEX_RUOLI_SA ON ruoli_sa (id_servizio_applicativo);




-- openspcoop2
		  		
-- **** Politiche di Sicurezza ****

CREATE SEQUENCE seq_politiche_sicurezza start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE politiche_sicurezza
(
	id_fruitore BIGINT NOT NULL,
	id_servizio BIGINT NOT NULL,
	id_servizio_applicativo BIGINT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_politiche_sicurezza') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_politiche_sicurezza_1 UNIQUE (id_fruitore,id_servizio,id_servizio_applicativo),
	-- fk/pk keys constraints
	CONSTRAINT fk_politiche_sicurezza_1 FOREIGN KEY (id_fruitore) REFERENCES soggetti(id),
	CONSTRAINT fk_politiche_sicurezza_2 FOREIGN KEY (id_servizio_applicativo) REFERENCES servizi_applicativi(id),
	CONSTRAINT fk_politiche_sicurezza_3 FOREIGN KEY (id_servizio) REFERENCES servizi(id),
	CONSTRAINT pk_politiche_sicurezza PRIMARY KEY (id)
);





-- openspcoop2
		  		
-- **** Porte Delegate ****

CREATE SEQUENCE seq_porte_delegate start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE porte_delegate
(
	nome_porta VARCHAR(255) NOT NULL,
	descrizione VARCHAR(255),
	-- la location sovrascrive il nome di una porta delegata, nella sua url di invocazione
	location VARCHAR(255),
	-- * Soggetto Erogatore *
	-- tipo/nome per le modalita static
	-- tipo/pattern per la modalita contentBased/urlBased
	-- id utilizzato in caso di registryInput
	id_soggetto_erogatore BIGINT,
	tipo_soggetto_erogatore VARCHAR(255),
	nome_soggetto_erogatore VARCHAR(255),
	mode_soggetto_erogatore VARCHAR(255),
	pattern_soggetto_erogatore VARCHAR(255),
	-- * Servizio *
	-- tipo/nome per le modalita static
	-- tipo/pattern per la modalita contentBased/urlBased
	-- id utilizzato in caso di registryInput
	id_servizio BIGINT,
	tipo_servizio VARCHAR(255),
	nome_servizio VARCHAR(255),
	mode_servizio VARCHAR(255),
	pattern_servizio VARCHAR(255),
	id_accordo BIGINT,
	id_port_type BIGINT,
	-- * Azione *
	-- tipo/nome per le modalita static
	-- tipo/pattern per la modalita contentBased/urlBased
	-- id utilizzato in caso di registryInput
	id_azione BIGINT,
	nome_azione VARCHAR(255),
	mode_azione VARCHAR(255),
	pattern_azione VARCHAR(255),
	-- abilitato/disabilitato
	force_wsdl_based_azione VARCHAR(255),
	-- * Configurazione *
	autenticazione VARCHAR(255),
	autorizzazione VARCHAR(255),
	autorizzazione_contenuto VARCHAR(255),
	-- disable/packaging/unpackaging/verify
	mtom_request_mode VARCHAR(255),
	-- disable/packaging/unpackaging/verify
	mtom_response_mode VARCHAR(255),
	-- abilitato/disabilitato (se abilitato le WSSproperties sono presenti nelle tabelle ...._ws_request/response)
	ws_security VARCHAR(255),
	-- abilitato/disabilitato
	ws_security_mtom_req VARCHAR(255),
	-- abilitato/disabilitato
	ws_security_mtom_res VARCHAR(255),
	-- abilitato/disabilitato
	ricevuta_asincrona_sim VARCHAR(255),
	-- abilitato/disabilitato
	ricevuta_asincrona_asim VARCHAR(255),
	-- abilitato/disabilitato/warningOnly
	validazione_contenuti_stato VARCHAR(255),
	-- wsdl/openspcoop/xsd
	validazione_contenuti_tipo VARCHAR(255),
	-- abilitato/disabilitato
	validazione_contenuti_mtom VARCHAR(255),
	-- lista di tipi separati dalla virgola
	integrazione VARCHAR(255),
	-- scadenza correlazione applicativa
	scadenza_correlazione_appl VARCHAR(255),
	-- abilitato/disabilitato
	allega_body VARCHAR(255),
	-- abilitato/disabilitato
	scarta_body VARCHAR(255),
	-- abilitato/disabilitato
	gestione_manifest VARCHAR(255),
	-- abilitato/disabilitato
	stateless VARCHAR(255),
	-- abilitato/disabilitato
	local_forward VARCHAR(255),
	-- proprietario porta delegata (Soggetto fruitore)
	id_soggetto BIGINT NOT NULL,
	ora_registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_porte_delegate') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_porte_delegate_1 UNIQUE (id_soggetto,nome_porta),
	-- fk/pk keys constraints
	CONSTRAINT fk_porte_delegate_1 FOREIGN KEY (id_soggetto) REFERENCES soggetti(id),
	CONSTRAINT pk_porte_delegate PRIMARY KEY (id)
);




CREATE SEQUENCE seq_porte_delegate_sa start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE porte_delegate_sa
(
	id_porta BIGINT NOT NULL,
	id_servizio_applicativo BIGINT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_porte_delegate_sa') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_porte_delegate_sa_1 UNIQUE (id_porta,id_servizio_applicativo),
	-- fk/pk keys constraints
	CONSTRAINT fk_porte_delegate_sa_1 FOREIGN KEY (id_servizio_applicativo) REFERENCES servizi_applicativi(id),
	CONSTRAINT fk_porte_delegate_sa_2 FOREIGN KEY (id_porta) REFERENCES porte_delegate(id),
	CONSTRAINT pk_porte_delegate_sa PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_PD_SA ON porte_delegate_sa (id_porta);



CREATE SEQUENCE seq_pd_mtom_request start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE pd_mtom_request
(
	id_porta BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	pattern TEXT NOT NULL,
	content_type VARCHAR(255),
	required INT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_pd_mtom_request') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_pd_mtom_request_1 FOREIGN KEY (id_porta) REFERENCES porte_delegate(id),
	CONSTRAINT pk_pd_mtom_request PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_PD_MTOMTREQ ON pd_mtom_request (id_porta);



CREATE SEQUENCE seq_pd_mtom_response start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE pd_mtom_response
(
	id_porta BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	pattern TEXT NOT NULL,
	content_type VARCHAR(255),
	required INT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_pd_mtom_response') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_pd_mtom_response_1 FOREIGN KEY (id_porta) REFERENCES porte_delegate(id),
	CONSTRAINT pk_pd_mtom_response PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_PD_MTOMTRES ON pd_mtom_response (id_porta);



CREATE SEQUENCE seq_pd_ws_request start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE pd_ws_request
(
	id_porta BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	valore TEXT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_pd_ws_request') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_pd_ws_request_1 FOREIGN KEY (id_porta) REFERENCES porte_delegate(id),
	CONSTRAINT pk_pd_ws_request PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_PD_WSSREQ ON pd_ws_request (id_porta);



CREATE SEQUENCE seq_pd_ws_response start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE pd_ws_response
(
	id_porta BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	valore TEXT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_pd_ws_response') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_pd_ws_response_1 FOREIGN KEY (id_porta) REFERENCES porte_delegate(id),
	CONSTRAINT pk_pd_ws_response PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_PD_WSSRES ON pd_ws_response (id_porta);



CREATE SEQUENCE seq_pd_correlazione start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE pd_correlazione
(
	id_porta BIGINT NOT NULL,
	nome_elemento VARCHAR(255),
	-- modalita di scelta user input, content-based, url-based, disabilitato
	mode_correlazione VARCHAR(255),
	-- pattern utilizzato solo per content/url based
	pattern TEXT,
	-- blocca/accetta
	identificazione_fallita VARCHAR(255),
	-- abilitato/disabilitato
	riuso_id VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_pd_correlazione') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_pd_correlazione_1 FOREIGN KEY (id_porta) REFERENCES porte_delegate(id),
	CONSTRAINT pk_pd_correlazione PRIMARY KEY (id)
);




CREATE SEQUENCE seq_pd_correlazione_risposta start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE pd_correlazione_risposta
(
	id_porta BIGINT NOT NULL,
	nome_elemento VARCHAR(255),
	-- modalita di scelta user input, content-based, url-based, disabilitato
	mode_correlazione VARCHAR(255),
	-- pattern utilizzato solo per content/url based
	pattern TEXT,
	-- blocca/accetta
	identificazione_fallita VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_pd_correlazione_risposta') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_pd_correlazione_risposta_1 FOREIGN KEY (id_porta) REFERENCES porte_delegate(id),
	CONSTRAINT pk_pd_correlazione_risposta PRIMARY KEY (id)
);





-- openspcoop2
		  		
-- **** Porte Applicative ****

CREATE SEQUENCE seq_porte_applicative start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE porte_applicative
(
	nome_porta VARCHAR(255) NOT NULL,
	descrizione VARCHAR(255),
	-- Soggetto Virtuale
	id_soggetto_virtuale BIGINT,
	tipo_soggetto_virtuale VARCHAR(255),
	nome_soggetto_virtuale VARCHAR(255),
	-- Servizio
	id_servizio BIGINT,
	tipo_servizio VARCHAR(255),
	servizio VARCHAR(255),
	id_accordo BIGINT,
	id_port_type BIGINT,
	-- azione
	azione VARCHAR(255),
	-- disable/packaging/unpackaging/verify
	mtom_request_mode VARCHAR(255),
	-- disable/packaging/unpackaging/verify
	mtom_response_mode VARCHAR(255),
	-- abilitato/disabilitato (se abilitato le WSSproperties sono presenti nelle tabelle ...._ws_request/response)
	ws_security VARCHAR(255),
	-- abilitato/disabilitato
	ws_security_mtom_req VARCHAR(255),
	-- abilitato/disabilitato
	ws_security_mtom_res VARCHAR(255),
	-- abilitato/disabilitato
	ricevuta_asincrona_sim VARCHAR(255),
	-- abilitato/disabilitato
	ricevuta_asincrona_asim VARCHAR(255),
	-- abilitato/disabilitato/warningOnly
	validazione_contenuti_stato VARCHAR(255),
	-- wsdl/openspcoop/xsd
	validazione_contenuti_tipo VARCHAR(255),
	-- abilitato/disabilitato
	validazione_contenuti_mtom VARCHAR(255),
	-- lista di tipi separati dalla virgola
	integrazione VARCHAR(255),
	-- scadenza correlazione applicativa
	scadenza_correlazione_appl VARCHAR(255),
	-- abilitato/disabilitato
	allega_body VARCHAR(255),
	-- abilitato/disabilitato
	scarta_body VARCHAR(255),
	-- abilitato/disabilitato
	gestione_manifest VARCHAR(255),
	-- abilitato/disabilitato
	stateless VARCHAR(255),
	behaviour VARCHAR(255),
	autorizzazione_contenuto VARCHAR(255),
	-- proprietario porta applicativa
	id_soggetto BIGINT NOT NULL,
	ora_registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_porte_applicative') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_porte_applicative_1 UNIQUE (id_soggetto,nome_porta),
	-- fk/pk keys constraints
	CONSTRAINT fk_porte_applicative_1 FOREIGN KEY (id_soggetto) REFERENCES soggetti(id),
	CONSTRAINT pk_porte_applicative PRIMARY KEY (id)
);




CREATE SEQUENCE seq_porte_applicative_sa start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE porte_applicative_sa
(
	id_porta BIGINT NOT NULL,
	id_servizio_applicativo BIGINT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_porte_applicative_sa') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_porte_applicative_sa_1 UNIQUE (id_porta,id_servizio_applicativo),
	-- fk/pk keys constraints
	CONSTRAINT fk_porte_applicative_sa_1 FOREIGN KEY (id_servizio_applicativo) REFERENCES servizi_applicativi(id),
	CONSTRAINT fk_porte_applicative_sa_2 FOREIGN KEY (id_porta) REFERENCES porte_applicative(id),
	CONSTRAINT pk_porte_applicative_sa PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_PA_SA ON porte_applicative_sa (id_porta);



CREATE SEQUENCE seq_pa_properties start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE pa_properties
(
	id_porta BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	valore VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_pa_properties') NOT NULL,
	-- unique constraints
	CONSTRAINT uniq_pa_properties_1 UNIQUE (id_porta,nome,valore),
	-- fk/pk keys constraints
	CONSTRAINT fk_pa_properties_1 FOREIGN KEY (id_porta) REFERENCES porte_applicative(id),
	CONSTRAINT pk_pa_properties PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_PA_PROP ON pa_properties (id_porta);



CREATE SEQUENCE seq_pa_mtom_request start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE pa_mtom_request
(
	id_porta BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	pattern TEXT NOT NULL,
	content_type VARCHAR(255),
	required INT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_pa_mtom_request') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_pa_mtom_request_1 FOREIGN KEY (id_porta) REFERENCES porte_applicative(id),
	CONSTRAINT pk_pa_mtom_request PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_PA_MTOMTREQ ON pa_mtom_request (id_porta);



CREATE SEQUENCE seq_pa_mtom_response start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE pa_mtom_response
(
	id_porta BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	pattern TEXT NOT NULL,
	content_type VARCHAR(255),
	required INT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_pa_mtom_response') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_pa_mtom_response_1 FOREIGN KEY (id_porta) REFERENCES porte_applicative(id),
	CONSTRAINT pk_pa_mtom_response PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_PA_MTOMTRES ON pa_mtom_response (id_porta);



CREATE SEQUENCE seq_pa_ws_request start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE pa_ws_request
(
	id_porta BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	valore TEXT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_pa_ws_request') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_pa_ws_request_1 FOREIGN KEY (id_porta) REFERENCES porte_applicative(id),
	CONSTRAINT pk_pa_ws_request PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_PA_WSSREQ ON pa_ws_request (id_porta);



CREATE SEQUENCE seq_pa_ws_response start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE pa_ws_response
(
	id_porta BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	valore TEXT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_pa_ws_response') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_pa_ws_response_1 FOREIGN KEY (id_porta) REFERENCES porte_applicative(id),
	CONSTRAINT pk_pa_ws_response PRIMARY KEY (id)
);

-- index
CREATE INDEX INDEX_PA_WSSRES ON pa_ws_response (id_porta);



CREATE SEQUENCE seq_pa_correlazione start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE pa_correlazione
(
	id_porta BIGINT NOT NULL,
	nome_elemento VARCHAR(255),
	-- modalita di scelta user input, content-based, url-based, disabilitato
	mode_correlazione VARCHAR(255),
	-- pattern utilizzato solo per content/url based
	pattern TEXT,
	-- blocca/accetta
	identificazione_fallita VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_pa_correlazione') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_pa_correlazione_1 FOREIGN KEY (id_porta) REFERENCES porte_applicative(id),
	CONSTRAINT pk_pa_correlazione PRIMARY KEY (id)
);




CREATE SEQUENCE seq_pa_correlazione_risposta start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE pa_correlazione_risposta
(
	id_porta BIGINT NOT NULL,
	nome_elemento VARCHAR(255),
	-- modalita di scelta user input, content-based, url-based, disabilitato
	mode_correlazione VARCHAR(255),
	-- pattern utilizzato solo per content/url based
	pattern TEXT,
	-- blocca/accetta
	identificazione_fallita VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_pa_correlazione_risposta') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_pa_correlazione_risposta_1 FOREIGN KEY (id_porta) REFERENCES porte_applicative(id),
	CONSTRAINT pk_pa_correlazione_risposta PRIMARY KEY (id)
);





-- openspcoop2
		  		
-- **** Audit Appenders ****

CREATE SEQUENCE seq_audit_operations start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE audit_operations
(
	tipo_operazione VARCHAR(255) NOT NULL,
	-- non definito in caso di LOGIN/LOGOUT
	tipo VARCHAR(255),
	-- non definito in caso di LOGIN/LOGOUT
	object_id TEXT,
	object_old_id TEXT,
	utente VARCHAR(255) NOT NULL,
	stato VARCHAR(255) NOT NULL,
	-- Dettaglio oggetto in gestione (Rappresentazione tramite JSON o XML format)
	object_details TEXT,
	-- Class, serve eventualmente per riottenere l'oggetto dal dettaglio
	-- non definito in caso di LOGIN/LOGOUT
	object_class VARCHAR(255),
	-- Eventuale messaggio di errore
	error TEXT,
	time_request TIMESTAMP NOT NULL,
	time_execute TIMESTAMP NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_audit_operations') NOT NULL,
	-- check constraints
	CONSTRAINT chk_audit_operations_1 CHECK (tipo_operazione IN ('LOGIN','LOGOUT','ADD','CHANGE','DEL')),
	CONSTRAINT chk_audit_operations_2 CHECK (stato IN ('requesting','error','completed')),
	-- fk/pk keys constraints
	CONSTRAINT pk_audit_operations PRIMARY KEY (id)
);

-- index
CREATE INDEX audit_filter_time ON audit_operations (time_request);
CREATE INDEX audit_filter ON audit_operations (tipo_operazione,tipo,utente,stato);



CREATE SEQUENCE seq_audit_binaries start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE audit_binaries
(
	binary_id VARCHAR(255) NOT NULL,
	checksum BIGINT NOT NULL,
	id_audit_operation BIGINT NOT NULL,
	time_rec TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_audit_binaries') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_audit_binaries_1 UNIQUE (binary_id,id_audit_operation),
	-- fk/pk keys constraints
	CONSTRAINT fk_audit_binaries_1 FOREIGN KEY (id_audit_operation) REFERENCES audit_operations(id),
	CONSTRAINT pk_audit_binaries PRIMARY KEY (id)
);





-- openspcoop2
		  		
-- **** Audit Configuration ****

CREATE SEQUENCE seq_audit_conf start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE audit_conf
(
	audit_engine INT NOT NULL DEFAULT 0,
	enabled INT NOT NULL DEFAULT 0,
	dump INT NOT NULL DEFAULT 0,
	dump_format VARCHAR(255) NOT NULL DEFAULT 'JSON',
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_audit_conf') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT pk_audit_conf PRIMARY KEY (id)
);




CREATE SEQUENCE seq_audit_filters start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE audit_filters
(
	-- Filter
	username VARCHAR(255),
	tipo_operazione VARCHAR(255),
	tipo VARCHAR(255),
	stato VARCHAR(255),
	-- Filtri basati su contenuto utilizzabili solo se il dump della configurazione generale e' abilitato
	dump_search VARCHAR(255),
	-- 1(espressione regolare)/0(semplice stringa da ricercare)
	dump_expr INT NOT NULL DEFAULT 0,
	-- Action
	enabled INT NOT NULL DEFAULT 0,
	dump INT NOT NULL DEFAULT 0,
	-- Tempo di registrazione
	ora_registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_audit_filters') NOT NULL,
	-- check constraints
	CONSTRAINT chk_audit_filters_1 CHECK (tipo_operazione IN ('ADD','CHANGE','DEL')),
	CONSTRAINT chk_audit_filters_2 CHECK (stato IN ('requesting','error','completed')),
	-- fk/pk keys constraints
	CONSTRAINT pk_audit_filters PRIMARY KEY (id)
);




CREATE SEQUENCE seq_audit_appender start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE audit_appender
(
	name VARCHAR(255) NOT NULL,
	class VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_audit_appender') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_audit_appender_1 UNIQUE (name),
	-- fk/pk keys constraints
	CONSTRAINT pk_audit_appender PRIMARY KEY (id)
);




CREATE SEQUENCE seq_audit_appender_prop start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE audit_appender_prop
(
	name VARCHAR(255) NOT NULL,
	value VARCHAR(255) NOT NULL,
	id_audit_appender BIGINT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_audit_appender_prop') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_audit_appender_prop_1 FOREIGN KEY (id_audit_appender) REFERENCES audit_appender(id),
	CONSTRAINT pk_audit_appender_prop PRIMARY KEY (id)
);





-- openspcoop2
		  		
-- **** Operations ****

CREATE SEQUENCE seq_operations start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE operations
(
	operation VARCHAR(255) NOT NULL,
	tipo VARCHAR(255) NOT NULL,
	superuser VARCHAR(255) NOT NULL,
	hostname VARCHAR(255) NOT NULL,
	status VARCHAR(255) NOT NULL,
	details TEXT,
	timereq TIMESTAMP NOT NULL,
	timexecute TIMESTAMP NOT NULL,
	deleted INT NOT NULL DEFAULT 0,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_operations') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT pk_operations PRIMARY KEY (id)
);

-- index
CREATE INDEX operations_superuser ON operations (superuser);
CREATE INDEX operations_precedenti ON operations (id,deleted,hostname,timereq);



CREATE SEQUENCE seq_parameters start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE parameters
(
	id_operations BIGINT NOT NULL,
	name VARCHAR(255) NOT NULL,
	value VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_parameters') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_parameters_1 FOREIGN KEY (id_operations) REFERENCES operations(id),
	CONSTRAINT pk_parameters PRIMARY KEY (id)
);

-- index
CREATE INDEX parameters_index ON parameters (name,value);




-- openspcoop2
		  		
-- **** Utenti ****

CREATE SEQUENCE seq_users start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE users
(
	login VARCHAR(255) NOT NULL,
	password VARCHAR(255) NOT NULL,
	tipo_interfaccia VARCHAR(255) NOT NULL,
	permessi VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_users') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_users_1 UNIQUE (login),
	-- fk/pk keys constraints
	CONSTRAINT pk_users PRIMARY KEY (id)
);





-- openspcoop2
		  		
CREATE SEQUENCE seq_db_info_console start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE db_info_console
(
	major_version INT NOT NULL,
	minor_version INT NOT NULL,
	notes VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_db_info_console') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT pk_db_info_console PRIMARY KEY (id)
);





-- openspcoop2
		  		

INSERT INTO audit_appender (name,class) VALUES ('dbAppender','org.openspcoop2.web.lib.audit.appender.AuditDBAppender');
INSERT INTO audit_appender_prop (name,value,id_audit_appender) VALUES ('datasource','org.openspcoop2.dataSource.pddConsole',(select id from audit_appender where name='dbAppender'));
INSERT INTO audit_appender_prop (name,value,id_audit_appender) VALUES ('tipoDatabase','postgresql',(select id from audit_appender where name='dbAppender'));


-- openspcoop2
			  		

INSERT INTO audit_appender (name,class) VALUES ('log4jAppender','org.openspcoop2.web.lib.audit.appender.AuditLog4JAppender');
INSERT INTO audit_appender_prop (name,value,id_audit_appender) VALUES ('fileConfigurazione','console.audit.log4j2.properties',(select id from audit_appender where name='log4jAppender'));
INSERT INTO audit_appender_prop (name,value,id_audit_appender) VALUES ('nomeFileLoaderInstance','console_local.audit.log4j2.properties',(select id from audit_appender where name='log4jAppender'));
INSERT INTO audit_appender_prop (name,value,id_audit_appender) VALUES ('nomeProprietaLoaderInstance','OPENSPCOOP2_CONSOLE_AUDIT_LOG_PROPERTIES',(select id from audit_appender where name='log4jAppender'));
INSERT INTO audit_appender_prop (name,value,id_audit_appender) VALUES ('category','audit',(select id from audit_appender where name='log4jAppender'));
INSERT INTO audit_appender_prop (name,value,id_audit_appender) VALUES ('xml','true',(select id from audit_appender where name='log4jAppender'));


-- openspcoop2
			  		

INSERT INTO audit_conf (audit_engine,enabled,dump,dump_format) VALUES (1,1,0,'JSON');


-- openspcoop2
			  		
-- users
-- INSERT INTO users (login, password, tipo_interfaccia, permessi) VALUES ('super',	'$1$.bquKJDS$yZ4EYC3354HqEjmSRL/sR0','STANDARD','U');
-- INSERT INTO users (login, password, tipo_interfaccia, permessi) VALUES ('amministratore',	'$1$.bquKJDS$yZ4EYC3354HqEjmSRL/sR0','STANDARD','SDCMA');


-- openspcoop2
			  		


INSERT INTO db_info_console (major_version,minor_version,notes) VALUES (2,3,'[OpenSPCoop_tags_2.3_ant_setup Revision N.12244, LastChangedRevision N.12244, 10/04/2016 01:37 PM] Database della Console di Gestione della Porta di Dominio OpenSPCoop2');

-- **** Configurazione ****

CREATE SEQUENCE seq_registri start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE registri
(
	nome VARCHAR(255) NOT NULL,
	location VARCHAR(255) NOT NULL,
	tipo VARCHAR(255) NOT NULL,
	utente VARCHAR(255),
	password VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_registri') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_registri_1 UNIQUE (nome),
	-- fk/pk keys constraints
	CONSTRAINT pk_registri PRIMARY KEY (id)
);




CREATE SEQUENCE seq_routing start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE routing
(
	tipo VARCHAR(255),
	nome VARCHAR(255),
	-- registro/gateway
	tiporotta VARCHAR(255) NOT NULL,
	tiposoggrotta VARCHAR(255),
	nomesoggrotta VARCHAR(255),
	-- foreign key per i registri(id)
	registrorotta BIGINT,
	is_default BIGINT NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_routing') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT pk_routing PRIMARY KEY (id)
);




CREATE SEQUENCE seq_configurazione start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE configurazione
(
	-- Cadenza inoltro Riscontri/BusteAsincrone
	cadenza_inoltro VARCHAR(255) NOT NULL,
	-- Validazione Buste
	validazione_stato VARCHAR(255),
	validazione_controllo VARCHAR(255),
	validazione_profilo VARCHAR(255),
	validazione_manifest VARCHAR(255),
	-- Validazione Contenuti Applicativi
	-- abilitato/disabilitato/warningOnly
	validazione_contenuti_stato VARCHAR(255),
	-- wsdl/openspcoop/xsd
	validazione_contenuti_tipo VARCHAR(255),
	-- abilitato/disabilitato
	validazione_contenuti_mtom VARCHAR(255),
	-- Livello Log Messaggi Diagnostici
	msg_diag_severita VARCHAR(255) NOT NULL,
	msg_diag_severita_log4j VARCHAR(255) NOT NULL,
	-- Tracciamento Buste
	tracciamento_buste VARCHAR(255),
	tracciamento_dump VARCHAR(255),
	tracciamento_dump_bin_pd VARCHAR(255),
	tracciamento_dump_bin_pa VARCHAR(255),
	-- Autenticazione IntegrationManager
	auth_integration_manager VARCHAR(255),
	-- Cache per l'accesso ai registri
	statocache VARCHAR(255),
	dimensionecache VARCHAR(255),
	algoritmocache VARCHAR(255),
	idlecache VARCHAR(255),
	lifecache VARCHAR(255),
	-- Cache per l'accesso alla configurazione
	config_statocache VARCHAR(255),
	config_dimensionecache VARCHAR(255),
	config_algoritmocache VARCHAR(255),
	config_idlecache VARCHAR(255),
	config_lifecache VARCHAR(255),
	-- Cache per l'accesso ai dati di autorizzazione
	auth_statocache VARCHAR(255),
	auth_dimensionecache VARCHAR(255),
	auth_algoritmocache VARCHAR(255),
	auth_idlecache VARCHAR(255),
	auth_lifecache VARCHAR(255),
	-- connessione su cui vengono inviate le risposte
	-- reply: connessione esistente (es. http reply)
	-- new: nuova connessione
	mod_risposta VARCHAR(255),
	-- Gestione dell'indirizzo
	indirizzo_telematico VARCHAR(255),
	-- Gestione Manifest
	gestione_manifest VARCHAR(255),
	-- Routing Table
	routing_enabled VARCHAR(255) NOT NULL,
	-- Gestione errore di default per la Porta di Dominio
	-- FOREIGN KEY (id_ge_cooperazione) REFERENCES gestione_errore(id) Nota: indica un eventuale tipologia di gestione dell'errore di default durante l'utilizzo di un connettore
	id_ge_cooperazione BIGINT,
	-- FOREIGN KEY (id_ge_integrazione) REFERENCES gestione_errore(id) Nota: indica un eventuale tipologia di gestione dell'errore di default durante l'utilizzo di un connettore
	id_ge_integrazione BIGINT,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_configurazione') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT pk_configurazione PRIMARY KEY (id)
);




-- **** Messaggi diagnostici Appender ****

CREATE SEQUENCE seq_msgdiag_appender start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE msgdiag_appender
(
	tipo VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_msgdiag_appender') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT pk_msgdiag_appender PRIMARY KEY (id)
);




CREATE SEQUENCE seq_msgdiag_appender_prop start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE msgdiag_appender_prop
(
	id_appender BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	valore VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_msgdiag_appender_prop') NOT NULL,
	-- unique constraints
	CONSTRAINT uniq_msgdiag_app_prop_1 UNIQUE (id_appender,nome,valore),
	-- fk/pk keys constraints
	CONSTRAINT fk_msgdiag_appender_prop_1 FOREIGN KEY (id_appender) REFERENCES msgdiag_appender(id),
	CONSTRAINT pk_msgdiag_appender_prop PRIMARY KEY (id)
);




-- **** Tracciamento Appender ****

CREATE SEQUENCE seq_tracce_appender start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE tracce_appender
(
	tipo VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_tracce_appender') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT pk_tracce_appender PRIMARY KEY (id)
);




CREATE SEQUENCE seq_tracce_appender_prop start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE tracce_appender_prop
(
	id_appender BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	valore VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_tracce_appender_prop') NOT NULL,
	-- unique constraints
	CONSTRAINT uniq_tracce_app_prop_1 UNIQUE (id_appender,nome,valore),
	-- fk/pk keys constraints
	CONSTRAINT fk_tracce_appender_prop_1 FOREIGN KEY (id_appender) REFERENCES tracce_appender(id),
	CONSTRAINT pk_tracce_appender_prop PRIMARY KEY (id)
);




-- **** Datasources dove reperire i messaggi diagnostici salvati ****

CREATE SEQUENCE seq_msgdiag_ds start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE msgdiag_ds
(
	nome VARCHAR(255) NOT NULL,
	nome_jndi VARCHAR(255) NOT NULL,
	tipo_database VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_msgdiag_ds') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_msgdiag_ds_1 UNIQUE (nome),
	-- fk/pk keys constraints
	CONSTRAINT pk_msgdiag_ds PRIMARY KEY (id)
);




CREATE SEQUENCE seq_msgdiag_ds_prop start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE msgdiag_ds_prop
(
	id_prop BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	valore VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_msgdiag_ds_prop') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_msgdiag_ds_prop_1 UNIQUE (id_prop,nome,valore),
	-- fk/pk keys constraints
	CONSTRAINT fk_msgdiag_ds_prop_1 FOREIGN KEY (id_prop) REFERENCES msgdiag_ds(id),
	CONSTRAINT pk_msgdiag_ds_prop PRIMARY KEY (id)
);




-- **** Datasources dove reperire le tracce salvate ****

CREATE SEQUENCE seq_tracce_ds start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE tracce_ds
(
	nome VARCHAR(255) NOT NULL,
	nome_jndi VARCHAR(255) NOT NULL,
	tipo_database VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_tracce_ds') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_tracce_ds_1 UNIQUE (nome),
	-- fk/pk keys constraints
	CONSTRAINT pk_tracce_ds PRIMARY KEY (id)
);




CREATE SEQUENCE seq_tracce_ds_prop start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE tracce_ds_prop
(
	id_prop BIGINT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	valore VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_tracce_ds_prop') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_tracce_ds_prop_1 UNIQUE (id_prop,nome,valore),
	-- fk/pk keys constraints
	CONSTRAINT fk_tracce_ds_prop_1 FOREIGN KEY (id_prop) REFERENCES tracce_ds(id),
	CONSTRAINT pk_tracce_ds_prop PRIMARY KEY (id)
);




-- **** Stato dei servizi attivi sulla Porta di Dominio ****

CREATE SEQUENCE seq_servizi_pdd start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE servizi_pdd
(
	componente VARCHAR(255) NOT NULL,
	-- Stato dei servizi attivi sulla Porta di Dominio
	stato INT DEFAULT 1,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_servizi_pdd') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_servizi_pdd_1 UNIQUE (componente),
	-- fk/pk keys constraints
	CONSTRAINT pk_servizi_pdd PRIMARY KEY (id)
);




CREATE SEQUENCE seq_servizi_pdd_filtri start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE servizi_pdd_filtri
(
	id_servizio_pdd BIGINT NOT NULL,
	tipo_filtro VARCHAR(255) NOT NULL,
	tipo_soggetto_fruitore VARCHAR(255),
	soggetto_fruitore VARCHAR(255),
	identificativo_porta_fruitore VARCHAR(255),
	tipo_soggetto_erogatore VARCHAR(255),
	soggetto_erogatore VARCHAR(255),
	identificativo_porta_erogatore VARCHAR(255),
	tipo_servizio VARCHAR(255),
	servizio VARCHAR(255),
	azione VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_servizi_pdd_filtri') NOT NULL,
	-- check constraints
	CONSTRAINT chk_servizi_pdd_filtri_1 CHECK (tipo_filtro IN ('abilitazione','disabilitazione')),
	-- fk/pk keys constraints
	CONSTRAINT fk_servizi_pdd_filtri_1 FOREIGN KEY (id_servizio_pdd) REFERENCES servizi_pdd(id),
	CONSTRAINT pk_servizi_pdd_filtri PRIMARY KEY (id)
);




-- **** PddSystemProperties ****

CREATE SEQUENCE seq_pdd_sys_props start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 NO CYCLE;

CREATE TABLE pdd_sys_props
(
	nome VARCHAR(255) NOT NULL,
	valore VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_pdd_sys_props') NOT NULL,
	-- unique constraints
	CONSTRAINT unique_pdd_sys_props_1 UNIQUE (nome,valore),
	-- fk/pk keys constraints
	CONSTRAINT pk_pdd_sys_props PRIMARY KEY (id)
);





-- openspcoop2
		  		
CREATE SEQUENCE seq_tracce start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE tracce
(
	gdo TIMESTAMP NOT NULL,
	gdo_int BIGINT NOT NULL,
	pdd_codice VARCHAR(255) NOT NULL,
	pdd_tipo_soggetto VARCHAR(255) NOT NULL,
	pdd_nome_soggetto VARCHAR(255) NOT NULL,
	pdd_ruolo VARCHAR(255) NOT NULL,
	tipo_messaggio VARCHAR(255) NOT NULL,
	esito_elaborazione VARCHAR(255) NOT NULL,
	dettaglio_esito_elaborazione TEXT,
	mittente VARCHAR(255),
	tipo_mittente VARCHAR(255),
	idporta_mittente VARCHAR(255),
	indirizzo_mittente VARCHAR(255),
	destinatario VARCHAR(255),
	tipo_destinatario VARCHAR(255),
	idporta_destinatario VARCHAR(255),
	indirizzo_destinatario VARCHAR(255),
	profilo_collaborazione VARCHAR(255),
	profilo_collaborazione_meta VARCHAR(255),
	servizio_correlato VARCHAR(255),
	tipo_servizio_correlato VARCHAR(255),
	collaborazione VARCHAR(255),
	versione_servizio INT,
	servizio VARCHAR(255),
	tipo_servizio VARCHAR(255),
	azione VARCHAR(255),
	id_messaggio VARCHAR(255),
	ora_registrazione TIMESTAMP,
	tipo_ora_reg VARCHAR(255),
	tipo_ora_reg_meta VARCHAR(255),
	rif_messaggio VARCHAR(255),
	scadenza TIMESTAMP,
	inoltro VARCHAR(255),
	inoltro_meta VARCHAR(255),
	conferma_ricezione INT,
	sequenza INT,
	-- Dati di integrazione
	location VARCHAR(255),
	correlazione_applicativa VARCHAR(255),
	correlazione_risposta VARCHAR(255),
	sa_fruitore VARCHAR(255),
	sa_erogatore VARCHAR(255),
	-- Protocollo
	protocollo VARCHAR(255) NOT NULL,
	-- Testsuite
	is_arrived INT DEFAULT 0,
	soap_element TEXT,
	digest TEXT,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_tracce') NOT NULL,
	-- check constraints
	CONSTRAINT chk_tracce_1 CHECK (pdd_ruolo IN ('delegata','applicativa','integrationManager','router')),
	CONSTRAINT chk_tracce_2 CHECK (tipo_messaggio IN ('Richiesta','Risposta')),
	CONSTRAINT chk_tracce_3 CHECK (esito_elaborazione IN ('INVIATO','RICEVUTO','ERRORE')),
	-- fk/pk keys constraints
	CONSTRAINT pk_tracce PRIMARY KEY (id)
);

-- index
CREATE INDEX TRACCE_SEARCH_ID ON tracce (id_messaggio,pdd_codice);
CREATE INDEX TRACCE_SEARCH_RIF ON tracce (rif_messaggio,pdd_codice);
CREATE INDEX TRACCE_SEARCH_ID_SOGGETTO ON tracce (id_messaggio,pdd_tipo_soggetto,pdd_nome_soggetto);
CREATE INDEX TRACCE_SEARCH_RIF_SOGGETTO ON tracce (rif_messaggio,pdd_tipo_soggetto,pdd_nome_soggetto);



CREATE SEQUENCE seq_tracce_riscontri start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE tracce_riscontri
(
	idtraccia BIGINT NOT NULL,
	riscontro VARCHAR(255),
	ora_registrazione TIMESTAMP,
	tipo_ora_reg VARCHAR(255),
	tipo_ora_reg_meta VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_tracce_riscontri') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_tracce_riscontri_1 FOREIGN KEY (idtraccia) REFERENCES tracce(id) ON DELETE CASCADE,
	CONSTRAINT pk_tracce_riscontri PRIMARY KEY (id)
);

-- index
CREATE INDEX TRACCE_RIS ON tracce_riscontri (idtraccia);



CREATE SEQUENCE seq_tracce_trasmissioni start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE tracce_trasmissioni
(
	idtraccia BIGINT NOT NULL,
	origine VARCHAR(255),
	tipo_origine VARCHAR(255),
	indirizzo_origine VARCHAR(255),
	idporta_origine VARCHAR(255),
	destinazione VARCHAR(255),
	tipo_destinazione VARCHAR(255),
	indirizzo_destinazione VARCHAR(255),
	idporta_destinazione VARCHAR(255),
	ora_registrazione TIMESTAMP,
	tipo_ora_reg VARCHAR(255),
	tipo_ora_reg_meta VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_tracce_trasmissioni') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_tracce_trasmissioni_1 FOREIGN KEY (idtraccia) REFERENCES tracce(id) ON DELETE CASCADE,
	CONSTRAINT pk_tracce_trasmissioni PRIMARY KEY (id)
);

-- index
CREATE INDEX TRACCE_TR ON tracce_trasmissioni (idtraccia);



CREATE SEQUENCE seq_tracce_eccezioni start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE tracce_eccezioni
(
	idtraccia BIGINT NOT NULL,
	contesto_codifica VARCHAR(255),
	contesto_codifica_meta VARCHAR(255),
	codice_eccezione VARCHAR(255),
	codice_eccezione_meta INT,
	subcodice_eccezione_meta INT,
	rilevanza VARCHAR(255),
	rilevanza_meta VARCHAR(255),
	posizione TEXT,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_tracce_eccezioni') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_tracce_eccezioni_1 FOREIGN KEY (idtraccia) REFERENCES tracce(id) ON DELETE CASCADE,
	CONSTRAINT pk_tracce_eccezioni PRIMARY KEY (id)
);

-- index
CREATE INDEX TRACCE_ECC ON tracce_eccezioni (idtraccia);



CREATE SEQUENCE seq_tracce_allegati start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE tracce_allegati
(
	idtraccia BIGINT NOT NULL,
	content_id VARCHAR(255),
	content_location VARCHAR(255),
	content_type VARCHAR(255),
	digest TEXT,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_tracce_allegati') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_tracce_allegati_1 FOREIGN KEY (idtraccia) REFERENCES tracce(id) ON DELETE CASCADE,
	CONSTRAINT pk_tracce_allegati PRIMARY KEY (id)
);

-- index
CREATE INDEX TRACCE_ALLEGATI_INDEX ON tracce_allegati (idtraccia);



CREATE SEQUENCE seq_tracce_ext_protocol_info start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE tracce_ext_protocol_info
(
	idtraccia BIGINT NOT NULL,
	name VARCHAR(255) NOT NULL,
	value TEXT,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_tracce_ext_protocol_info') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT fk_tracce_ext_protocol_info_1 FOREIGN KEY (idtraccia) REFERENCES tracce(id) ON DELETE CASCADE,
	CONSTRAINT pk_tracce_ext_protocol_info PRIMARY KEY (id)
);

-- index
CREATE INDEX TRACCE_EXT_INFO ON tracce_ext_protocol_info (idtraccia);




-- openspcoop2
		  		
CREATE SEQUENCE seq_msgdiagnostici start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE msgdiagnostici
(
	gdo TIMESTAMP NOT NULL,
	pdd_codice VARCHAR(255) NOT NULL,
	pdd_tipo_soggetto VARCHAR(255) NOT NULL,
	pdd_nome_soggetto VARCHAR(255) NOT NULL,
	idfunzione VARCHAR(255) NOT NULL,
	severita INT NOT NULL,
	messaggio TEXT NOT NULL,
	-- Eventuale id della richiesta in gestione (informazione non definita dalla specifica)
	idmessaggio VARCHAR(255),
	-- Eventuale id della risposta correlata alla richiesta (informazione non definita dalla specifica)
	idmessaggio_risposta VARCHAR(255),
	-- Codice del diagnostico emesso
	codice VARCHAR(255) NOT NULL,
	-- Protocollo (puo' non essere presente per i diagnostici di 'servizio' della porta)
	protocollo VARCHAR(255),
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_msgdiagnostici') NOT NULL,
	-- check constraints
	CONSTRAINT chk_msgdiagnostici_1 CHECK (severita IN (0,1,2,3,4,5,6,7)),
	-- fk/pk keys constraints
	CONSTRAINT pk_msgdiagnostici PRIMARY KEY (id)
);

-- index
CREATE INDEX MSG_DIAG_ID ON msgdiagnostici (idmessaggio);
CREATE INDEX MSG_DIAG_GDO ON msgdiagnostici (gdo);



CREATE SEQUENCE seq_msgdiag_correlazione start 1 increment 1 maxvalue 9223372036854775807 minvalue 1 cache 1 CYCLE;

CREATE TABLE msgdiag_correlazione
(
	-- Dati di Correlazione con i messaggi diagnostici
	idmessaggio VARCHAR(255) NOT NULL,
	pdd_codice VARCHAR(255) NOT NULL,
	pdd_tipo_soggetto VARCHAR(255) NOT NULL,
	pdd_nome_soggetto VARCHAR(255) NOT NULL,
	-- Data di registrazione
	gdo TIMESTAMP NOT NULL,
	-- nome porta delegata/applicativa
	porta VARCHAR(255),
	-- (1/0 true/false) True se siamo in un contesto di porta delegata, False se in un contesto di porta applicativa
	delegata INT NOT NULL,
	tipo_fruitore VARCHAR(255) NOT NULL,
	fruitore VARCHAR(255) NOT NULL,
	tipo_erogatore VARCHAR(255) NOT NULL,
	erogatore VARCHAR(255) NOT NULL,
	tipo_servizio VARCHAR(255) NOT NULL,
	servizio VARCHAR(255) NOT NULL,
	versione_servizio INT NOT NULL,
	azione VARCHAR(255),
	-- Identificatore correlazione applicativa
	id_correlazione_applicativa VARCHAR(255),
	id_correlazione_risposta VARCHAR(255),
	-- Protocollo
	protocollo VARCHAR(255) NOT NULL,
	-- fk/pk columns
	id BIGINT DEFAULT nextval('seq_msgdiag_correlazione') NOT NULL,
	-- fk/pk keys constraints
	CONSTRAINT pk_msgdiag_correlazione PRIMARY KEY (id)
);

-- index
CREATE INDEX MSG_CORR_INDEX ON msgdiag_correlazione (idmessaggio,delegata);
CREATE INDEX MSG_CORR_GDO ON msgdiag_correlazione (gdo);
CREATE INDEX MSG_CORR_APP ON msgdiag_correlazione (id_correlazione_applicativa,delegata);



CREATE TABLE msgdiag_correlazione_sa
(
	id_correlazione BIGINT NOT NULL,
	-- Identita ServizioApplicativo
	servizio_applicativo VARCHAR(255) NOT NULL,
	-- fk/pk columns
	-- fk/pk keys constraints
	CONSTRAINT fk_msgdiag_correlazione_sa_1 FOREIGN KEY (id_correlazione) REFERENCES msgdiag_correlazione(id) ON DELETE CASCADE,
	CONSTRAINT pk_msgdiag_correlazione_sa PRIMARY KEY (id_correlazione,servizio_applicativo)
);



-- openspcoop2
		  		
-- Configurazione
INSERT INTO configurazione (cadenza_inoltro, validazione_stato, validazione_controllo, msg_diag_severita, msg_diag_severita_log4j, auth_integration_manager,validazione_profilo, mod_risposta, indirizzo_telematico, routing_enabled, validazione_manifest, gestione_manifest, tracciamento_buste, tracciamento_dump, tracciamento_dump_bin_pd, tracciamento_dump_bin_pa, statocache,dimensionecache,algoritmocache,lifecache, config_statocache,config_dimensionecache,config_algoritmocache,config_lifecache,auth_statocache,auth_dimensionecache,auth_algoritmocache,auth_lifecache) VALUES( '60',       'abilitato',    'rigido', 'infoIntegration', 'infoIntegration', 'basic,ssl', 'disabilitato','reply','disabilitato','disabilitato', 'abilitato', 'disabilitato', 'abilitato', 'disabilitato', 'disabilitato', 'disabilitato', 'abilitato','10000','lru','7200','abilitato','10000','lru','7200','abilitato','5000','lru','7200');

-- Rotta di default per routing
insert INTO routing (tiporotta,registrorotta,is_default) VALUES ('registro',0,1);

-- Registro locale
insert INTO registri (nome,location,tipo) VALUES ('RegistroDB','org.openspcoop2.dataSource.pddConsole','db');

-- Porta di Dominio locale
INSERT INTO pdd (nome,tipo,superuser) VALUES ('PddOpenSPCoop','operativo','amministratore');


-- openspcoop2
			  		
-- users
-- INSERT INTO users (login, password, tipo_interfaccia, permessi) VALUES ('operatore',	'$1$.bquKJDS$yZ4EYC3354HqEjmSRL/sR0','STANDARD','D');


-- openspcoop2
			  		




-- Tracciamento
INSERT INTO tracce_appender (tipo) VALUES ('protocol');
INSERT INTO tracce_appender_prop (id_appender,nome,valore) VALUES ((select id from tracce_appender where tipo='protocol'),'datasource','org.openspcoop2.dataSource');
INSERT INTO tracce_appender_prop (id_appender,nome,valore) VALUES ((select id from tracce_appender where tipo='protocol'),'tipoDatabase','postgresql');
INSERT INTO tracce_appender_prop (id_appender,nome,valore) VALUES ((select id from tracce_appender where tipo='protocol'),'usePdDConnection','true'); 

-- MsgDiagnostici
INSERT INTO msgdiag_appender (tipo) VALUES ('protocol');
INSERT INTO msgdiag_appender_prop (id_appender,nome,valore) VALUES ((select id from msgdiag_appender where tipo='protocol'),'datasource','org.openspcoop2.dataSource');
INSERT INTO msgdiag_appender_prop (id_appender,nome,valore) VALUES ((select id from msgdiag_appender where tipo='protocol'),'usePdDConnection','true');

-- PdD
UPDATE pdd set nome='PdDsoggettoPDD01';
UPDATE pdd set superuser='amministratore';

-- Configurazione Cache Registro
UPDATE configurazione set statocache='abilitato';
UPDATE configurazione set dimensionecache='10000';
UPDATE configurazione set algoritmocache='lru';
UPDATE configurazione set lifecache='7200';

-- Configurazione Cache Dati Configurazione
UPDATE configurazione set config_statocache='abilitato';
UPDATE configurazione set config_dimensionecache='10000';
UPDATE configurazione set config_algoritmocache='lru';
UPDATE configurazione set config_lifecache='7200';

-- Configurazione Cache Dati Autorizzazione
UPDATE configurazione set auth_statocache='abilitato';
UPDATE configurazione set auth_dimensionecache='5000';
UPDATE configurazione set auth_algoritmocache='lru';
UPDATE configurazione set auth_lifecache='7200';


-- Protocol spcoop

INSERT INTO connettori (endpointtype,nome_connettore,debug,custom) VALUES 
			('disabilitato','CNT_SPC_soggettoPDD01',0,0);
INSERT INTO soggetti (nome_soggetto,tipo_soggetto,descrizione,identificativo_porta,is_router,id_connettore,superuser,server,privato,profilo,codice_ipa) VALUES
	    ('soggettoPDD01','SPC',null,'soggettoPDD01SPCoopIT',0,
	     (select id from connettori where nome_connettore='CNT_SPC_soggettoPDD01'),
	     'amministratore','PdDsoggettoPDD01',0,'eGov1.1-lineeGuida1.1','o=soggettoPDD01,c=it');



-- Protocol trasparente

INSERT INTO connettori (endpointtype,nome_connettore,debug,custom) VALUES 
			('disabilitato','CNT_PROXY_soggettoPDD01',0,0);
INSERT INTO soggetti (nome_soggetto,tipo_soggetto,descrizione,identificativo_porta,is_router,id_connettore,superuser,server,privato,profilo,codice_ipa) VALUES
	    ('soggettoPDD01','PROXY',null,'soggettoPDD01PdD',0,
	     (select id from connettori where nome_connettore='CNT_PROXY_soggettoPDD01'),
	     'amministratore','PdDsoggettoPDD01',0,'1.0','o=PROXYsoggettoPDD01,c=it');



-- Utenza pddConsole

INSERT INTO users (login, password, tipo_interfaccia, permessi) VALUES ('amministratore','$1$xM$w6jXANHJ.HLQWDN1z5r9e/','STANDARD','SDCMAU');
