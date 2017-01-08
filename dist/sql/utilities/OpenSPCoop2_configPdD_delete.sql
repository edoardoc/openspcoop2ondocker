

-- OpenSPCoop2

DELETE FROM users;


-- openspcoop2
		  		
DELETE FROM audit_appender_prop;
DELETE FROM audit_appender;
DELETE FROM audit_filters;
DELETE FROM audit_conf;


-- openspcoop2
		  		
DELETE FROM pdd_sys_props;
DELETE FROM servizi_pdd_filtri;
DELETE FROM servizi_pdd;
DELETE FROM tracce_ds_prop;
DELETE FROM tracce_ds;
DELETE FROM msgdiag_ds_prop;
DELETE FROM msgdiag_ds;
DELETE FROM tracce_appender_prop;
DELETE FROM tracce_appender;
DELETE FROM msgdiag_appender_prop;
DELETE FROM msgdiag_appender;
DELETE FROM configurazione;
DELETE FROM routing;
DELETE FROM registri;

-- Pdd operativa
DELETE FROM pdd where tipo='operativo';


-- openspcoop2
		  		
