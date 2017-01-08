

-- OpenSPCoop2

DELETE FROM parameters;
DELETE FROM operations;


-- openspcoop2
		  		
DELETE FROM audit_binaries;
DELETE FROM audit_operations;


-- openspcoop2
		  		
DELETE FROM pa_correlazione_risposta;
DELETE FROM pa_correlazione;
DELETE FROM pa_ws_response;
DELETE FROM pa_ws_request;
DELETE FROM pa_mtom_response;
DELETE FROM pa_mtom_request;
DELETE FROM pa_properties;
DELETE FROM porte_applicative_sa;
DELETE FROM porte_applicative;


-- openspcoop2
		  		
DELETE FROM pd_correlazione_risposta;
DELETE FROM pd_correlazione;
DELETE FROM pd_ws_response;
DELETE FROM pd_ws_request;
DELETE FROM pd_mtom_response;
DELETE FROM pd_mtom_request;
DELETE FROM porte_delegate_sa;
DELETE FROM porte_delegate;


-- openspcoop2
		  		
DELETE FROM politiche_sicurezza;


-- openspcoop2
		  		
DELETE FROM ruoli_sa;


-- openspcoop2
		  		
DELETE FROM servizi_applicativi;


-- openspcoop2
		  		
DELETE FROM acc_serv_componenti;
DELETE FROM acc_serv_composti;
DELETE FROM servizi_azioni;
DELETE FROM servizi_fruitori;
DELETE FROM servizi;
DELETE FROM accordi_coop_partecipanti;
DELETE FROM accordi_cooperazione;
DELETE FROM operation_messages;
DELETE FROM port_type_azioni;
DELETE FROM port_type;
DELETE FROM accordi_azioni;
DELETE FROM accordi;
DELETE FROM documenti;


-- openspcoop2
		  		
DELETE FROM soggetti;


-- openspcoop2
		  		
DELETE FROM connettori_properties;
DELETE FROM connettori_custom;
DELETE FROM connettori;


-- openspcoop2
		  		
DELETE FROM gestione_errore_soap;
DELETE FROM gestione_errore_trasporto;
DELETE FROM gestione_errore;


-- openspcoop2
		  		
DELETE FROM pdd where tipo<>'operativo';


-- openspcoop2
		  		
