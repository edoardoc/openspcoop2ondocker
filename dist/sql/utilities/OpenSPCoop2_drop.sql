

-- OpenSPCoop2

-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX ASINCRONO_NON_RICEVUTE ON ASINCRONO ;
-- DROP INDEX ASINCRONO_IS_RICEVUTA ON ASINCRONO ;
-- DROP INDEX ASINCRONO_BACKUP_ID ON ASINCRONO ;
-- DROP INDEX RISCONTRI_NON_RICEVUTI ON RISCONTRI_DA_RICEVERE ;
-- DROP INDEX LISTA_EXT_ID ON LISTA_EXT_PROTOCOL_INFO ;
-- DROP INDEX LISTA_ECC_VALIDAZIONE ON LISTA_ECCEZIONI ;
-- DROP INDEX LISTA_ECC_ID ON LISTA_ECCEZIONI ;
-- DROP INDEX LISTA_TRASM_ID ON LISTA_TRASMISSIONI ;
-- DROP INDEX LISTA_RISC_ID ON LISTA_RISCONTRI ;
-- DROP INDEX REP_BUSTE_SEARCH_TIPO_RA ON REPOSITORY_BUSTE ;
-- DROP INDEX REP_BUSTE_SEARCH_TIPO ON REPOSITORY_BUSTE ;
-- DROP INDEX REP_BUSTE_SEARCH_RA ON REPOSITORY_BUSTE ;
-- DROP INDEX REP_BUSTE_SEARCH ON REPOSITORY_BUSTE ;
DROP TABLE ASINCRONO;
DROP TABLE SEQUENZA_DA_RICEVERE;
DROP TABLE SEQUENZA_DA_INVIARE;
DROP TABLE RISCONTRI_DA_RICEVERE;
DROP TABLE LISTA_EXT_PROTOCOL_INFO;
DROP TABLE LISTA_ECCEZIONI;
DROP TABLE LISTA_TRASMISSIONI;
DROP TABLE LISTA_RISCONTRI;
DROP TABLE REPOSITORY_BUSTE;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
DROP TABLE ID_MESSAGGIO_RELATIVO_PRG;
DROP TABLE ID_MESSAGGIO_PRG;
DROP TABLE ID_MESSAGGIO_RELATIVO;
DROP TABLE ID_MESSAGGIO;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX CORR_APPL_OLD ON CORRELAZIONE_APPLICATIVA ;
-- DROP INDEX CORR_APPL_SCADUTE ON CORRELAZIONE_APPLICATIVA ;
-- DROP INDEX MSG_SERV_APPL_TIMEOUT ON MSG_SERVIZI_APPLICATIVI ;
-- DROP INDEX MSG_SERV_APPL_LIST ON MSG_SERVIZI_APPLICATIVI ;
-- DROP INDEX MESSAGGI_TESTSUITE ON MESSAGGI ;
-- DROP INDEX MESSAGGI_RIFMSG ON MESSAGGI ;
-- DROP INDEX MESSAGGI_SEARCH ON MESSAGGI ;
DROP TABLE CORRELAZIONE_APPLICATIVA;
DROP TABLE DEFINIZIONE_MESSAGGI;
DROP TABLE MSG_SERVIZI_APPLICATIVI;
DROP TABLE MESSAGGI;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
DROP TABLE db_info;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
DROP TABLE users;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX parameters_index ON parameters ;
-- DROP INDEX operations_precedenti ON operations ;
-- DROP INDEX operations_superuser ON operations ;
DROP TABLE parameters;
DROP TABLE operations;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
DROP TABLE audit_appender_prop;
DROP TABLE audit_appender;
DROP TABLE audit_filters;
DROP TABLE audit_conf;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX index_audit_binaries_1 ON audit_binaries ;
-- DROP INDEX audit_filter ON audit_operations ;
-- DROP INDEX audit_filter_time ON audit_operations ;
DROP TABLE audit_binaries;
DROP TABLE audit_operations;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX INDEX_PA_WSSRES ON pa_ws_response ;
-- DROP INDEX INDEX_PA_WSSREQ ON pa_ws_request ;
-- DROP INDEX INDEX_PA_MTOMTRES ON pa_mtom_response ;
-- DROP INDEX INDEX_PA_MTOMTREQ ON pa_mtom_request ;
-- DROP INDEX INDEX_PA_PROP ON pa_properties ;
-- DROP INDEX INDEX_PA_SA ON porte_applicative_sa ;
-- DROP INDEX index_porte_applicative_1 ON porte_applicative ;
DROP TABLE pa_correlazione_risposta;
DROP TABLE pa_correlazione;
DROP TABLE pa_ws_response;
DROP TABLE pa_ws_request;
DROP TABLE pa_mtom_response;
DROP TABLE pa_mtom_request;
DROP TABLE pa_properties;
DROP TABLE porte_applicative_sa;
DROP TABLE porte_applicative;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX INDEX_PD_WSSRES ON pd_ws_response ;
-- DROP INDEX INDEX_PD_WSSREQ ON pd_ws_request ;
-- DROP INDEX INDEX_PD_MTOMTRES ON pd_mtom_response ;
-- DROP INDEX INDEX_PD_MTOMTREQ ON pd_mtom_request ;
-- DROP INDEX INDEX_PD_SA ON porte_delegate_sa ;
-- DROP INDEX index_porte_delegate_1 ON porte_delegate ;
DROP TABLE pd_correlazione_risposta;
DROP TABLE pd_correlazione;
DROP TABLE pd_ws_response;
DROP TABLE pd_ws_request;
DROP TABLE pd_mtom_response;
DROP TABLE pd_mtom_request;
DROP TABLE porte_delegate_sa;
DROP TABLE porte_delegate;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX index_politiche_sicurezza_1 ON politiche_sicurezza ;
DROP TABLE politiche_sicurezza;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX INDEX_RUOLI_SA ON ruoli_sa ;
-- DROP INDEX INDEX_RUOLI ON ruoli_sa ;
DROP TABLE ruoli_sa;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX index_servizi_applicativi_1 ON servizi_applicativi ;
DROP TABLE servizi_applicativi;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX INDEX_AC_SC_SC ON acc_serv_componenti ;
-- DROP INDEX INDEX_AC_SC ON acc_serv_composti ;
-- DROP INDEX index_acc_serv_composti_1 ON acc_serv_composti ;
-- DROP INDEX index_servizi_azioni_1 ON servizi_azioni ;
-- DROP INDEX index_servizi_fruitori_1 ON servizi_fruitori ;
-- DROP INDEX INDEX_APS ON servizi ;
-- DROP INDEX index_servizi_1 ON servizi ;
-- DROP INDEX INDEX_AC_COOP_PAR ON accordi_coop_partecipanti ;
-- DROP INDEX index_accordi_cooperazione_1 ON accordi_cooperazione ;
-- DROP INDEX INDEX_OP_MESSAGES ON operation_messages ;
-- DROP INDEX index_port_type_azioni_1 ON port_type_azioni ;
-- DROP INDEX index_port_type_1 ON port_type ;
-- DROP INDEX index_accordi_azioni_1 ON accordi_azioni ;
-- DROP INDEX index_accordi_1 ON accordi ;
-- DROP INDEX INDEX_DOC_SEARCH ON documenti ;
-- DROP INDEX index_documenti_1 ON documenti ;
DROP TABLE acc_serv_componenti;
DROP TABLE acc_serv_composti;
DROP TABLE servizi_azioni;
DROP TABLE servizi_fruitori;
DROP TABLE servizi;
DROP TABLE accordi_coop_partecipanti;
DROP TABLE accordi_cooperazione;
DROP TABLE operation_messages;
DROP TABLE port_type_azioni;
DROP TABLE port_type;
DROP TABLE accordi_azioni;
DROP TABLE accordi;
DROP TABLE documenti;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX index_soggetti_2 ON soggetti ;
-- DROP INDEX index_soggetti_1 ON soggetti ;
DROP TABLE soggetti;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX index_connettori_properties_1 ON connettori_properties ;
-- DROP INDEX index_connettori_1 ON connettori ;
DROP TABLE connettori_properties;
DROP TABLE connettori_custom;
DROP TABLE connettori;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
DROP TABLE gestione_errore_soap;
DROP TABLE gestione_errore_trasporto;
DROP TABLE gestione_errore;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX index_pdd_1 ON pdd ;
DROP TABLE pdd;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
DROP TABLE db_info_console;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX TRACCE_EXT_INFO ON tracce_ext_protocol_info ;
-- DROP INDEX TRACCE_ALLEGATI_INDEX ON tracce_allegati ;
-- DROP INDEX TRACCE_ECC ON tracce_eccezioni ;
-- DROP INDEX TRACCE_TR ON tracce_trasmissioni ;
-- DROP INDEX TRACCE_RIS ON tracce_riscontri ;
-- DROP INDEX TRACCE_SEARCH_RIF_SOGGETTO ON tracce ;
-- DROP INDEX TRACCE_SEARCH_ID_SOGGETTO ON tracce ;
-- DROP INDEX TRACCE_SEARCH_RIF ON tracce ;
-- DROP INDEX TRACCE_SEARCH_ID ON tracce ;
DROP TABLE tracce_ext_protocol_info;
DROP TABLE tracce_allegati;
DROP TABLE tracce_eccezioni;
DROP TABLE tracce_trasmissioni;
DROP TABLE tracce_riscontri;
DROP TABLE tracce;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX MSG_CORR_APP ON msgdiag_correlazione ;
-- DROP INDEX MSG_CORR_GDO ON msgdiag_correlazione ;
-- DROP INDEX MSG_CORR_INDEX ON msgdiag_correlazione ;
-- DROP INDEX MSG_DIAG_GDO ON msgdiagnostici ;
-- DROP INDEX MSG_DIAG_ID ON msgdiagnostici ;
DROP TABLE msgdiag_correlazione_sa;
DROP TABLE msgdiag_correlazione;
DROP TABLE msgdiagnostici;


-- openspcoop2
		  		
-- Gli indici vengono eliminati automaticamente una volta eliminata la tabella
-- DROP INDEX index_pdd_sys_props_1 ON pdd_sys_props ;
-- DROP INDEX index_servizi_pdd_1 ON servizi_pdd ;
DROP TABLE pdd_sys_props;
DROP TABLE servizi_pdd_filtri;
DROP TABLE servizi_pdd;
DROP TABLE tracce_ds_prop;
DROP TABLE tracce_ds;
DROP TABLE msgdiag_ds_prop;
DROP TABLE msgdiag_ds;
DROP TABLE tracce_appender_prop;
DROP TABLE tracce_appender;
DROP TABLE msgdiag_appender_prop;
DROP TABLE msgdiag_appender;
DROP TABLE configurazione;
DROP TABLE routing;
DROP TABLE registri;


-- openspcoop2
		  		
