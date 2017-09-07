#*************************************************************************************************************************
#
#Copyright or � or Copr.[DGFIP][2015]
#
#Ce logiciel a �t� initialement d�velopp� par la Direction G�n�rale des 
#Finances Publiques pour permettre le calcul de l'imp�t sur le revenu 2015 
#au titre des revenus per�us en 2014. La pr�sente version a permis la 
#g�n�ration du moteur de calcul des cha�nes de taxation des r�les d'imp�t 
#sur le revenu de ce mill�sime.
#
#Ce logiciel est r�gi par la licence CeCILL 2.1 soumise au droit fran�ais 
#et respectant les principes de diffusion des logiciels libres. Vous pouvez 
#utiliser, modifier et/ou redistribuer ce programme sous les conditions de 
#la licence CeCILL 2.1 telle que diffus�e par le CEA, le CNRS et l'INRIA  sur 
#le site "http://www.cecill.info".
#
#Le fait que vous puissiez acc�der � cet en-t�te signifie que vous avez pris 
#connaissance de la licence CeCILL 2.1 et que vous en avez accept� les termes.
#
#**************************************************************************************************************************
regle corrective base_tl_init 1202:
application :  iliad ;


TL_MF = IND_TL_MF;
RNI_INIT = RNI * (1 - positif(TEFFP)) * (1 - positif(IPTEFN + RMOND)) ;
EFF_INIT = TEFFP ;
PVQ_INIT = TTPVQ ;
PV_INIT  = BPTP3 + BPTP2 + BPTP4 + BPTP40 + BPTP18 + BPTPD + BPTPG + BPTP19 + BPTP24 ;
RI_INIT  = (REDTL + CIMPTL) * (1-V_CNR) ;
CRDS_INIT = BCSG ;
BRDS_INIT = BRDS ;
BPRS_INIT = BPRS ;
TAXAGA_INIT = BASSURV + BASSURC ;
PCAP_INIT = BPCAPTAXV + BPCAPTAXC ;
LOY_INIT = LOYELEV ;
CHR_INIT  = REVKIREHR + (RFRH2 + RFRH1) * positif(HRCONDTHEO) ;
CVN_INIT = CVNSALAV + CVNSALAC + GLDGRATV + GLDGRATC ;
CDIS_INIT = GSALV + GSALC ;
GLO_INIT = GLDGRATV + GLDGRATC ;
RSE1_INIT = BRSE1 ;
RSE2_INIT = BRSE2 ;
RSE3_INIT = BRSE3 ;
RSE4_INIT = BRSE4 ;
RSE5_INIT = BRSE5 ;

regle corrective  base_tl 1204:
application :  iliad ;


RNI_TL = RNI * (1 - positif(TEFFP)) * (1 - positif(IPTEFN + RMOND)) ;
EFF_TL = TEFFP ;
PVQ_TL = TTPVQ ;
PV_TL  = BPTP3 + BPTP2 + BPTP4 + BPTP40 + BPTP18 + BPTPD + BPTPG + BPTP19 + BPTP24 ;
RI_TL  = (REDTL + CIMPTL) * (1 - V_CNR) ;
RDS_TL  = BCSG ;
BRDS_TL = BRDS ;
BPRS_TL = BPRS ;
TAXAGA_TL = BASSURV + BASSURC ;
PCAP_TL = BPCAPTAXV + BPCAPTAXC ;
LOYA_TL = LOYELEV ;
CHR_TL  = REVKIREHR + (RFRH2 + RFRH1) * positif(HRCONDTHEO) ;
CVNA_TL = CVNSALAV + CVNSALAC + GLDGRATV + GLDGRATC ;
CDISA_TL = GSALV + GSALC;
GLOA_TL = GLDGRATV + GLDGRATC ;
RSE1A_TL = BRSE1 ;
RSE2A_TL = BRSE2 ;
RSE3A_TL = BRSE3 ;
RSE4A_TL = BRSE4 ;
RSE5A_TL = BRSE5 ;

regle corrective base_tl_rect 1206:
application :  iliad ;


RNI_RECT = RNI * (1 - positif(TEFFP)) * (1 - positif(IPTEFN + RMOND)) ;
EFF_RECT = TEFFP ;
PVQ_RECT = TTPVQ ;
PV_RECT  = BPTP3 + BPTP2 + BPTP4 + BPTP40 + BPTP18 + BPTPD + BPTPG + BPTP19 + BPTP24 ;
RI_RECT  = RI_INIT - (REDTL + CIMPTL) * (1-V_CNR) ;
CRDS_RECT = BCSG ;
BRDS_RECT = BRDS ;
BPRS_RECT = BPRS ;
TAXAGA_RECT = BASSURV + BASSURC ;
PCAP_RECT = BPCAPTAXV + BPCAPTAXC ;
LOY_RECT = LOYELEV ;
CHR_RECT  = REVKIREHR + (RFRH2 + RFRH1) * positif(HRCONDTHEO) ;
CVN_RECT = CVNSALAV + CVNSALAC + GLDGRATV + GLDGRATC ;
CDIS_RECT = GSALV + GSALC ;
GLO_RECT = GLDGRATV + GLDGRATC ;
RSE1_RECT = BRSE1 ;
RSE2_RECT = BRSE2 ;
RSE3_RECT = BRSE3 ;
RSE4_RECT = BRSE4 ;
RSE5_RECT = BRSE5 ;

CSG_RECT = CSG ;
PS_RECT  = PRS ;

