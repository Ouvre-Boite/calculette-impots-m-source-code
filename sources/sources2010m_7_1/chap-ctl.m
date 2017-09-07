#*************************************************************************************************************************
#
#Copyright or � or Copr.[DGFIP][2017]
#
#Ce logiciel a �t� initialement d�velopp� par la Direction G�n�rale des 
#Finances Publiques pour permettre le calcul de l'imp�t sur le revenu 2011 
#au titre des revenus per�us en 2010. La pr�sente version a permis la 
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
application :  oceans, iliad ;


TL_MF = IND_TL_MF;
RNI_INIT = RNI ;
ETR_INIT = IPMOND + IPTXMO ;
PVQ_INIT = TTPVQ ;
PV_INIT  = BPTP3 + BPTP2 + BPTP4 + BPTP40 + BPTP18 + BPTPD + BPTPG + BPVCESDOM * positif(V_EAD+V_EAG);
RI_INIT  = ( BSURV + RFC + BDOM + BSOUFIP + BILNEUF + BILRES
                 + BAD + BAH + BRFG + BAA + BSN + BSOCREP + BCOS + BON + RETUD + BFCPI
		 + BPRESCOMP + DFOREST + BDOMINT ) 
	     * (1-V_CNR) ;

CRDS_INIT = RDSN;
TAXAGA_INIT = BASSURV + BASSURC ;
CSAL_INIT = BPVOPTCS ;
CDIS_INIT = GSALV + GSALC;

regle corrective  base_tl 1204:
application :  oceans, iliad ;


RNI_TL = RNI ;
ETR_TL = IPMOND + IPTXMO ;
PVQ_TL = TTPVQ ;
PV_TL  = BPTP3 + BPTP2 + BPTP4 + BPTP40 + BPTP18 + BPTPD + BPTPG + BPVCESDOM * positif(V_EAD+V_EAG);
RI_TL  = ( BSURV + RFC + BDOM + BSOUFIP + BILNEUF + BILRES
	      + BAD + BAH + BRFG + BAA + BSN + BSOCREP + BCOS + BON + RETUD + BFCPI
	      + BPRESCOMP + DFOREST + BDOMINT )
	   * (1-V_CNR) ;

RDS_TL  = RDSN ;
TAXAGA_TL = BASSURV + BASSURC ;
CSALA_TL = BPVOPTCS ;
CDISA_TL = GSALV + GSALC;

regle corrective base_tl_rect 1206:
application :  oceans, iliad ;


RNI_RECT = RNI ;
ETR_RECT = IPMOND + IPTXMO ;
PVQ_RECT = TTPVQ ;
PV_RECT  = BPTP3 + BPTP2 + BPTP4 + BPTP40 + BPTP18 + BPTPD + BPTPG + BPVCESDOM * positif(V_EAD+V_EAG);
RI_RECT  = RI_INIT - (BSURV + RFC + BDOM + BSOUFIP + BILNEUF + BILRES
		       + BAD + BAH + BRFG + BAA + BSN + BSOCREP + BCOS + BON + RETUD + BFCPI
		       + BPRESCOMP + DFOREST + BDOMINT )
		     * (1-V_CNR) ;

CRDS_RECT = RDSN ;
TAXAGA_RECT = BASSURV + BASSURC ;
CSAL_RECT = BPVOPTCS ;
CDIS_RECT = GSALV + GSALC ;

CSG_RECT = CSG ;
PS_RECT  = PRS ;

