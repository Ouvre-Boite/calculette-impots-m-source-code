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
regle 831:
application : iliad , batch  ;
RRFI = (RFON + DRCF + max(0,RFMIC - MICFR - RFDANT )) * (1-positif(ART1731BIS))
       + (RFON + DRCF + max(0,RFMIC - MICFR - DEFRF4BD )) * positif(ART1731BIS);
RRFIPS = RRFI; 
regle 8312:
application : iliad , batch  ;
MICFR = present(RFMIC) * arr(RFMIC * TX_MICFON/100);
regle 8316:
application : iliad , batch ;
RMF = max(0,RFMIC - MICFR);
RMFN = max(0,RFMIC - MICFR - RFDANT  )* (1 - positif(ART1731BIS))
     + max(0,RFMIC - MICFR - DEFRF4BD) * positif(ART1731BIS);
regle 832:
application : iliad , batch  ;
RFCD = RFORDI + FONCI + REAMOR;
regle 833:
application : iliad , batch  ;
VARRFDORD = min(RFCD,RFDORD);
RFCE = max(0,RFCD- RFDORD) * (1 - positif(ART1731BIS))
        + max(0,RFCD- DEFRF4BB) * positif(ART1731BIS);
RFCEAPS = max(0,RFORDI- RFDORD) * (1 - positif(ART1731BIS))
         + max(0,RFORDI- DEFRF4BB) *  positif(ART1731BIS);
RFCEPS = max(0,RFCD-RFDORD)* (1 - positif(ART1731BIS))
         +  max(0,RFCD-DEFRF4BB) * positif(ART1731BIS);

DFCE = min(0,RFCD- RFDORD) * (1 - positif(ART1731BIS))
       +  min(0,RFCD- DEFRF4BB)  * positif(ART1731BIS);

RFCF = max(0,RFCE-(RFDHIS * (1 - positif(PREM8_11))));
RFCFPS = (RFCEPS-RFDHIS* (1 - positif(PREM8_11)));
RFCFAPS = max(0,RFCEAPS-(RFDHIS * (1 - positif(PREM8_11))));

DRCF  = min(0,RFCE-(RFDHIS * (1 - positif(PREM8_11))));
VARRFDANT = min(RFCF+RFMIC - MICFR,RFDANT);
RFCG = max(0,RFCF- RFDANT) * (1 - positif(ART1731BIS))
       + max(0,RFCF- DEFRF4BD) * positif(ART1731BIS);
DFCG = min(0,RFCF- RFDANT) * (1 - positif(ART1731BIS))
       + min(0,RFCF- DEFRF4BD) * positif(ART1731BIS);
regle 834:
application : iliad , batch  ;
RFON = arr(RFCG*RFORDI/RFCD);
2REVF = min( arr ((RFCG)*(FONCI)/RFCD) , RFCG-RFON);
3REVF = min( arr (RFCG*(REAMOR)/RFCD) , RFCG-RFON-2REVF);
RFQ = FONCI + REAMOR;
regle 834113:
application : iliad ;
DEF4BB = RFORDI + RFMIC * 0.70 + FONCI + REAMOR - max(0,RFORDI+ RFMIC * 0.70 + FONCI + REAMOR - RFDORD);
DEFRF4BB = min(RFDORD,max(DEF4BB1731,max(DEF4BB_P,DEF4BBP2))) * DEFRIRF * (1-PREM8_11) ;
regle 834115:
application : iliad ;
DEF4BD = RFORDI + RFMIC * 0.70 + FONCI + REAMOR-RFDORD - RFDHIS- max(0,RFORDI+ RFMIC * 0.70 + FONCI + REAMOR-RFDORD - RFDHIS-RFDANT);
DEFRF4BD = min(RFDANT,max(DEF4BD1731,max(DEF4BD_P,DEF4BDP2)))* DEFRIRF * (1-PREM8_11) ;
DEF4BC = max(0, RFORDI-RFDORD);
DEFRF4BC = max(0,min(RFDHIS,-max(DEF4BC1731,max(DEF4BC_P,DEF4BCP2))+RFDHIS)) * positif(DEFRIGLOBINF+DEFRIGLOBSUP) * (1-PREM8_11);
regle 834117:
application : iliad ;
DEFRFNONI = max(0,RFDORD + RFDANT - DEFRF4BB - DEFRF4BD);
 
