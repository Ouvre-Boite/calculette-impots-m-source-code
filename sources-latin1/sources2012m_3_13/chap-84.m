#*************************************************************************************************************************
#
#Copyright or � or Copr.[DGFIP][2017]
#
#Ce logiciel a �t� initialement d�velopp� par la Direction G�n�rale des 
#Finances Publiques pour permettre le calcul de l'imp�t sur le revenu 2013 
#au titre des revenus percus en 2012. La pr�sente version a permis la 
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
regle 801 :
application : iliad , batch  ;
BA1AF =  BAF1AP  + BAF1AC  + BAF1AV  ;
regle 840 :
application : iliad , batch  ;
BARSV = BAHREV + 4BAHREV - BAHDEV;
BARSREVV = BAHREV +4BAHREV;
BARSC = BAHREC + 4BAHREC - BAHDEC;
BARSREVC = BAHREC +4BAHREC;
BARSP = BAHREP + 4BAHREP - BAHDEP;
BARSREVP = BAHREP +4BAHREP;
BARAV = (BACREV + 4BACREV - BACDEV) ;
BARREVAV = BACREV + 4BACREV;
BARAC = (BACREC  + 4BACREC - BACDEC) ;
BARREVAC = BACREC + 4BACREC;
BARAP = (BACREP + 4BACREP - BACDEP) ;
BARREVAP = BACREP + 4BACREP;
regle 8421:
application : iliad , batch  ;
pour i =V,C,P:
DEFBACREi = positif(4BACREi) * arr((BACDEi * BACREi) / BARREVAi) + (1 - positif(4BACREi)) * BACDEi ;
pour i =V,C,P:
4DEFBACREi = positif(4BACREi) * (BACDEi - DEFBACREi);
regle 84211:
application : iliad , batch  ;
BANV = (BACREV - DEFBACREV) * positif_ou_nul(BARAV) + BARAV * (1-positif(BARAV));
BANC = (BACREC - DEFBACREC) * positif_ou_nul(BARAC) + BARAC * (1-positif(BARAC));
BANP = (BACREP - DEFBACREP) * positif_ou_nul(BARAP) + BARAP * (1-positif(BARAP));
BAEV = (4BACREV - 4DEFBACREV) * positif_ou_nul(BARAV) + 0;
BAEC = (4BACREC - 4DEFBACREC) * positif_ou_nul(BARAC) + 0;
BAEP = (4BACREP - 4DEFBACREP) * positif_ou_nul(BARAP) + 0;
regle 842111:
application : iliad , batch  ;
pour i =V,C,P:
DEFBAHREi = positif(4BAHREi) * arr((BAHDEi * BAHREi) / BARSREVi) + (1 - positif(4BAHREi)) * BAHDEi ;
pour i =V,C,P:
4DEFBAHREi = positif(4BAHREi) * (BAHDEi - DEFBAHREi) ;
regle 843:
application : iliad , batch  ;
BAMV = arr((BAHREV - DEFBAHREV) * MAJREV) * positif_ou_nul(BARSV) + BARSV * (1-positif(BARSV));
BAMC = arr((BAHREC - DEFBAHREC) * MAJREV) * positif_ou_nul(BARSC) + BARSC * (1-positif(BARSC));
BAMP = arr((BAHREP - DEFBAHREP) * MAJREV) * positif_ou_nul(BARSP) + BARSP * (1-positif(BARSP));
BAEMV = (arr((4BAHREV - 4DEFBAHREV)* MAJREV)) * positif_ou_nul(BARSV) + 0;
BAEMC = (arr((4BAHREC - 4DEFBAHREC)* MAJREV)) * positif_ou_nul(BARSC) + 0;
BAEMP = (arr((4BAHREP - 4DEFBAHREP)* MAJREV)) * positif_ou_nul(BARSP) + 0;
regle 8431:
application : iliad , batch  ;
BAFORV = arr(BAFV*MAJREV)+BAFORESTV+BAFPVV;
BAFORC = arr(BAFC*MAJREV)+BAFORESTC+BAFPVC;
BAFORP = arr(BAFP*MAJREV)+BAFORESTP+BAFPVP;
regle 84311:
application : iliad , batch  ;
BAHQV = BANV + BAMV + BAFORV;
BAHQC = BANC + BAMC + BAFORC;
BAHQP = BANP + BAMP + BAFORP;
regle 845:
application : iliad , batch  ;
4BAQV = max(0,(4BACREV - 4DEFBACREV))*positif_ou_nul(BARAV)+arr(max(0,(4BAHREV - 4DEFBAHREV))*MAJREV) * positif_ou_nul(BARSV);
4BAQC = max(0,(4BACREC - 4DEFBACREC))*positif_ou_nul(BARAC)+arr(max(0,(4BAHREC - 4DEFBAHREC))*MAJREV) * positif_ou_nul(BARSC);
4BAQP = max(0,(4BACREP - 4DEFBACREP))*positif_ou_nul(BARAP)+arr(max(0,(4BAHREP - 4DEFBAHREP))*MAJREV) * positif_ou_nul(BARSP);
regle 8451:
application : iliad , batch  ;
BAQV = BAEV + BAEMV;
BAQC = BAEC + BAEMC;
BAQP = BAEP + BAEMP;
regle 84511:
application : iliad , batch  ;
BA1V = BA1AV + BAF1AV ;
BA1C = BA1AC + BAF1AC ;
BA1P = BA1AP + BAF1AP ;
regle 84512:
application : iliad , batch  ;
BAHQT=BAHQV+BAHQC+BAHQP;
BAHQTOT=BAHQV+BAHQC+BAHQP-DAGRI6-DAGRI5-DAGRI4-DAGRI3-DAGRI2-DAGRI1;
BAHQTOTMAXP=positif_ou_nul(BAHQT) * max(0,BAHQV+BAHQC+BAHQP-DAGRI6-DAGRI5-DAGRI4-DAGRI3-DAGRI2-DAGRI1);
BAHQTOTMAXN=positif_ou_nul(BAHQT) * min(0,BAHQV+BAHQC+BAHQP-DAGRI6-DAGRI5-DAGRI4-DAGRI3-DAGRI2-DAGRI1);
BAHQTOTMIN=positif(-BAHQT) * BAHQT;
regle 84513:
application : iliad , batch  ;
BAQT = BAQV + BAQC + BAQP;
BAQTOT = max(0,BAQV + BAQC + BAQP + BAHQTOTMAXN);
BAQTOTN = min(0,BAQV + BAQC + BAQP + BAHQTOTMAXN);
BAQTOTMIN = min(0,BAQV + BAQC + BAQP + BAHQTOTMIN);
BAQTOTAV = positif_ou_nul(BAQT + BAHQT) * BAQTOT + (1 - positif(BAQT + BAHQT)) * 0;
4BAQTOT = somme(x=V,C,P: 4BAQx) ;
4BAQTOTNET = positif(4BAQTOT) * max(0, 4BAQTOT + (BAHQTOTMIN + BAHQTOTMAXN) );
regle 845111:
application : iliad , batch  ;
BA1 = BA1V + BA1C + BA1P; 
regle 846:
application : iliad , batch  ;
BANOR = BAHQTOTMAXP + BAQTOTMIN;

regle 847:
application : iliad , batch  ;
DEFBA6 = (1-positif(BAHQT+BAQT)) * (DAGRI5) 
	    + positif(BAHQT+BAQT) * 
	    abs(min(max(BAHQT+BAQT-DAGRI6,0)-DAGRI5,DAGRI5))
            * positif_ou_nul(DAGRI5-max(BAHQT+BAQT-DAGRI6,0))
		    * (1 - positif(IPVLOC)) ;
DEFBA5 = (1-positif(BAHQT+BAQT)) * (DAGRI4) 
	    + positif(BAHQT+BAQT) * 
	     abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5,0)-DAGRI4,DAGRI4))
            * positif_ou_nul(DAGRI4-max(BAHQT+BAQT-DAGRI6-DAGRI5,0))
		    * (1 - positif(IPVLOC)) ;
DEFBA4 = (1-positif(BAHQT+BAQT)) * (DAGRI3) 
	    + positif(BAHQT+BAQT) * 
	     abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4,0)-DAGRI3,DAGRI3))
            * positif_ou_nul(DAGRI3-max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4,0))
		    * (1 - positif(IPVLOC)) ;
DEFBA3 = (1-positif(BAHQT+BAQT)) * (DAGRI2) 
	    + positif(BAHQT+BAQT) * 
	     abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3,0)-DAGRI2,DAGRI2))
            * positif_ou_nul(DAGRI2-max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3,0))
		    * (1 - positif(IPVLOC)) ;
DEFBA2 = (1-positif(BAHQT+BAQT)) * (DAGRI1) 
	    + positif(BAHQT+BAQT) * 
	     abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3-DAGRI2,0)-DAGRI1,DAGRI1))
            * positif_ou_nul(DAGRI1-max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3-DAGRI2,0))
		    * (1 - positif(IPVLOC)) ;
DEFBA1 = (1-positif(BAHQT+BAQT)) * (abs(BAHQT+BAQT)-abs(DEFIBA))
	    + positif(BAHQT+BAQT) * 
	     positif_ou_nul(DAGRI5+DAGRI4+DAGRI3+DAGRI2+DAGRI1-BAHQT-BAQT)
	    * (DAGRI5+DAGRI4+DAGRI3+DAGRI2+DAGRI1-BAHQT-BAQT)
	    * null(DEFBA2+DEFBA3+DEFBA4+DEFBA5+DEFBA6)
		    * (1 - positif(IPVLOC)) ;
regle 848:
application : iliad , batch  ;
DEFIBAANT = positif_ou_nul(BAQT+BAHQTOT-DAGRI1-DAGRI2-DAGRI3-DAGRI4-DAGRI5-DAGRI6)
            * (DAGRI1-DAGRI2-DAGRI3-DAGRI4-DAGRI5-DAGRI6)
            + positif_ou_nul(DAGRI1+DAGRI2+DAGRI3+DAGRI4+DAGRI5+DAGRI6-BAQT-BAHQTOT)
            * (BAQT+BAHQTOT);
regle 849:
application : iliad , batch  ;
DAGRI = DAGRI1+DAGRI2+DAGRI3+DAGRI4+DAGRI5+DAGRI6;
regle 850:
application : iliad , batch  ;
BAQTOTAVIS = 4BAQTOTNET;
