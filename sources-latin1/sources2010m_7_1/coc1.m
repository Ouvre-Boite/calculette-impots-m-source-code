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
verif 1507:
application : pro , oceans ,  iliad  , batch;
si
    (
 ( FRNV > 0 et (present(TSHALLOV) + present(ALLOV)) = 0 )
     ou
 ( FRNC > 0 et (present(TSHALLOC) + present(ALLOC)) = 0 )
     ou
 ( FRN1 > 0 et (present(TSHALLO1) + present(ALLO1)) = 0 )
     ou
 ( FRN2 > 0 et (present(TSHALLO2) + present(ALLO2)) = 0 )
     ou
 ( FRN3 > 0 et (present(TSHALLO3) + present(ALLO3)) = 0 )
     ou
 ( FRN4 > 0 et (present(TSHALLO4) + present(ALLO4)) = 0 )
    )
alors erreur A143;
verif 1508:
application : pro , oceans ,  iliad  , batch;
si ( 
   (TSHALLOV +0) < (GSALV + 0)
   et
   (GSALV + 0) > 0
   )
alors erreur A14401;
verif 1509:
application : pro , oceans ,  iliad  , batch;
si ( 
   (TSHALLOC +0) < (GSALC + 0)
   et
   (GSALC + 0) > 0
   )
alors erreur A14402;
verif 153:
application : pro , oceans,iliad , batch ;
si
   (
       (positif(PPETPV)=1 et positif(PPENHV)=1)
    ou (positif(PPETPC)=1 et positif(PPENHC)=1)
    ou (positif(PPETPP1)=1 et positif(PPENHP1)=1)
    ou (positif(PPETPP2)=1 et positif(PPENHP2)=1)
    ou (positif(PPETPP3)=1 et positif(PPENHP3)=1)
    ou (positif(PPETPP4)=1 et positif(PPENHP4)=1)
   )
alors erreur A153;
verif 148:
application : pro , iliad , batch ;
si
   (
     V_NOTRAIT + 0 < 20
     et
     positif ( present ( IPTEFP ) + present ( IPTEFN ) + 0 ) = 0 
     et
     positif ( positif ( TSELUPPEV + 0 ) + positif ( TSELUPPEC + 0 )) = 1 
     et
     positif ( IND_TDR + 0 ) = 0
   )
   ou
   (
     V_NOTRAIT + 0 >= 20
     et
     positif ( present ( IPTEFP ) + present ( IPTEFN ) + 0 ) = 0 
     et
     positif ( positif ( TSELUPPEV + 0 ) + positif ( TSELUPPEC + 0 )) = 1 
     et
     positif_ou_nul ( IND_TDR ) = 0
   )
alors erreur A148;
verif non_auto_cc 1513:
application : pro , oceans ,  iliad , batch ;
si (
     ( DETSV=1 et
       positif(present(TSHALLOV) + present(ALLOV) + present(CARTSV) + present(CARTSNBAV) + present(REMPLAV) + present(REMPLANBV)) = 0 )
 ou
     ( DETSC=1 et 
       positif(present(TSHALLOC) + present(ALLOC) + present(CARTSC) + present(CARTSNBAC) + present(REMPLAC) + present(REMPLANBC))=0 )
 ou
     ( DETS1=1 et 
       positif(present(TSHALLO1) + present(ALLO1) + present(CARTSP1) + present(CARTSNBAP1) + present(REMPLAP1) + present(REMPLANBP1))=0 )
 ou
     ( DETS2=1 et 
       positif(present(TSHALLO2) + present(ALLO2) + present(CARTSP2) + present(CARTSNBAP2) + present(REMPLAP2) + present(REMPLANBP2))=0 )
 ou
     ( DETS3=1 et
       positif(present(TSHALLO3) + present(ALLO3) + present(CARTSP3) + present(CARTSNBAP3) + present(REMPLAP3) + present(REMPLANBP3))=0 )
 ou
     ( DETS4=1 et
       positif(present(TSHALLO4) + present(ALLO4) + present(CARTSP4) + present(CARTSNBAP4) + present(REMPLAP4) + present(REMPLANBP4))=0 )
	)
alors erreur A146;
verif 1600:
application : pro , oceans ,  iliad , batch ;
si

( DPVRCM > 0 et ((BPVRCM + BPVCESDOM + PEA) > 0 ))

alors erreur A320;
verif 1601:
application : pro , oceans ,  iliad , batch ;
si

   positif(ABDETPLUS) + positif(ABDETMOINS) = 2 

alors erreur A321;
verif 1602:
application : pro , oceans ,  iliad , batch ;
si
   BPVCESDOM + 0 > 0  
   et 
   V_EAD + V_EAG + 0 = 0

alors erreur A322 ;
verif 1608:
application : pro , oceans , iliad , batch ;
si
   positif(ABIMPPV + 0) = 1 
   et 
   positif(ABIMPMV + 0) = 1 

alors erreur A323 ;
verif 1611:
application : pro , oceans , iliad , batch ;

si
   positif(BPVOPTCS + 0) = 1
   et
   positif(BPV18 + BPCOPT + BPV40 + BPCOSAV + BPCOSAC + 0) = 0

alors erreur A324 ;
verif 1616:
application : pro , iliad , batch ;
si
          (
                ( RDPRESREPORT +0  > V_BTPRESCOMP  +  LIM_REPORT )
           ou 
                ( PRESCOMP2000 + PRESCOMPJUGE  +0 > LIM_REPORT  et
                   V_BTPRESCOMP  + 0> 0 )
           ou
                ( RDPRESREPORT +0  > LIM_REPORT et V_BTPRESCOMP+0 = 0 )
          )
          et
          (
              1 - V_CNR > 0
          )
          et
          (
              RPRESCOMP > 0
          )
         et
          ((APPLI_ILIAD = 1 et V_NOTRAIT+0 < 16)
             ou APPLI_PRO = 1
             ou ((V_BTNI1+0) non dans (50,92) et APPLI_BATCH = 1))
alors erreur DD15;
verif 1606:
application : pro , iliad , batch ;
si
(   (1 - V_CNR > 0) et 
(RCMRDS > (LIM_CONTROLE + RCMABD 
                        + RCMAV 
                        + RCMHAD 
                        + RCMHAB  
			+ REVACT
			+ PROVIE
			+ DISQUO 
			+ INTERE  ))
)
alors erreur DD14;
verif 1603:
application : batch , iliad, pro, oceans ;
si (
   RFMIC > 0 et ( RFORDI > 0 ou RFDORD > 0 ou RFDHIS > 0 ou FONCI > 0 ou REAMOR > 0 et FONCINB > 0 ou REAMORNB > 0)
   )
alors erreur A420;
verif 1604:
application : batch , iliad , pro , oceans ;
si ( V_IND_TRAIT > 0)
   et
   (
   RFMIC >  LIM_MICFON
   )
alors erreur A421;
verif 422:
application : batch , iliad , pro , oceans ;
si 
  (
   LOYIMP > 0 et ( present(RFORDI) = 0
		et 
		   present(FONCI) = 0
		et 
		   present(FONCINB) = 0
		et 
		   present(REAMOR) = 0
		et 
		   present(REAMORNB) = 0
		et 
		   present(RFDORD) = 0
                et 
		   present(RFDHIS) = 0
		et 
		   present(RFMIC) = 0)
  )
alors erreur A422;
verif 1609:
application : batch , iliad, pro, oceans ;

 si (
    (RFROBOR > 0 et RFDANT > 0) et (present(RFORDI)=0
		                   et present(RFDORD)=0
                                   et present(RFDHIS)=0
                                    )
    )
alors erreur A423;
verif 1610:
application : batch , iliad, pro, oceans ;

si 
   RFROBOR > 0 et (FONCI > 0 ou REAMOR > 0)

alors erreur A424 ;
verif 1605:
application : batch, iliad, pro ;
si
	(
	RFMIC > 0 et RFDANT > 0

	)
alors erreur DD11;
verif 1607:
application : batch ,iliad;
si
	(
	BAILOC98 > V_BTBAILOC98        
	ou
	( present(BAILOC98) = 1 et present(V_BTBAILOC98) = 0)
	)
alors erreur DD24;
verif 1538:                                                                    
application : pro , oceans ,  iliad , batch ;                                 
si ( 
( RCSV > 0 et SOMMEA538VB = 0 )

ou
( RCSC > 0 et SOMMEA538CB = 0 )

ou
( RCSP > 0 et SOMMEA538PB = 0 )

)
alors erreur A538;
