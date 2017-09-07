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
regle 21700:
application : oceans , iliad ;


RAP_RNI    = RNI_TL - RNI_INIT ;
RAP_ETR    = ETR_TL - ETR_INIT ;
RAP_PVQ    = PVQ_TL - PVQ_INIT ;
RAP_PV     = PV_TL - PV_INIT ;
RAP_RI     = - RI_TL + RI_INIT ;
RAP_CI     = RAPCI_TL ;
RAP_CRDS   = RDS_TL - CRDS_INIT ;
RAP_TAXAGA = TAXAGA_TL - TAXAGA_INIT ;
RAP_CSAL   = CSALA_TL - CSAL_INIT ;
RAP_CDIS   = CDISA_TL - CDIS_INIT ;


NUM_IR_TL     = RAP_RNI
               + RAP_ETR
               + RAP_PVQ
               + RAP_PV
               + RAP_RI 
               + RAP_CI ;

NUM_CS_TL     = RAP_CRDS ;

NUM_TAXAGA_TL = RAP_TAXAGA ; 

NUM_CSAL_TL   = RAP_CSAL ;
NUM_CDIS_TL   = RAP_CDIS ;

regle 21710 :
application : oceans , iliad ;


DEN_IR_TL     = RNI_RECT
               + ETR_RECT
               + PVQ_RECT
               + PV_RECT
               + RI_RECT
               + CI_RECT 
	        ;

DEN_CS_TL     = CRDS_RECT ;

DEN_TAXAGA_TL = TAXAGA_RECT ;

DEN_CSAL_TL   = CSAL_RECT ;
DEN_CDIS_TL   = CDIS_RECT ;

regle 21720 :
application : oceans , iliad ;
enchaineur : ENCH_TL ;


TL_IR = (1 - positif(TL_MF*positif(MFIR+0)+FLAG_RETARD+FLAG_DEFAUT+PASS_TLIR))
            *( positif(   positif (NUM_IR_TL+0)
                          * positif (DEN_IR_TL+0)
                          * positif (NUM_IR_TL / DEN_IR_TL  - 0.05 )
                     )
            )
           + positif(TL_MF*positif(MFIR+0)+FLAG_RETARD+FLAG_DEFAUT+PASS_TLIR) ;

TL_CS = (1 - positif(TL_MF*positif(MFCS)+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF*positif(MFCS) + positif (NUM_CS_TL / DEN_CS_TL  - 0.05 )) )
         + positif(TL_MF*positif(MFCS)+FLAG_RETARD+FLAG_DEFAUT);


TL_TAXAGA = ( 1 - positif( TL_MF * positif(MFTAXAGA)+FLAG_RETARD+FLAG_DEFAUT + PASS_TLTAXAGA ))
		 * ( positif(TL_MF*positif(MFTAXAGA) + positif(NUM_TAXAGA_TL / DEN_TAXAGA_TL - 0.05 )
		    + TL_IR * null(NUM_TAXAGA_TL) * positif(DEN_TAXAGA_TL) ))
            + positif( TL_MF * positif(MFTAXAGA)+FLAG_RETARD+FLAG_DEFAUT + PASS_TLTAXAGA ) ;

TL_CSAL = (1 - positif(TL_MF * positif(MFCSAL)+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFCSAL) + positif (NUM_CSAL_TL / DEN_CSAL_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFCSAL)+FLAG_RETARD+FLAG_DEFAUT);

TL_CDIS = (1 - positif(TL_MF * positif(MFCDIS)+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFCDIS) + positif (NUM_CDIS_TL / DEN_CDIS_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFCDIS)+FLAG_RETARD+FLAG_DEFAUT);

