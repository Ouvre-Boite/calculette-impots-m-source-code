#*************************************************************************************************************************
#
#Copyright or © or Copr.[DGFIP][2017]
#
#Ce logiciel a été initialement développé par la Direction Générale des 
#Finances Publiques pour permettre le calcul de l'impôt sur le revenu 2013 
#au titre des revenus percus en 2012. La présente version a permis la 
#génération du moteur de calcul des chaînes de taxation des rôles d'impôt 
#sur le revenu de ce millésime.
#
#Ce logiciel est régi par la licence CeCILL 2.1 soumise au droit français 
#et respectant les principes de diffusion des logiciels libres. Vous pouvez 
#utiliser, modifier et/ou redistribuer ce programme sous les conditions de 
#la licence CeCILL 2.1 telle que diffusée par le CEA, le CNRS et l'INRIA  sur 
#le site "http://www.cecill.info".
#
#Le fait que vous puissiez accéder à cet en-tête signifie que vous avez pris 
#connaissance de la licence CeCILL 2.1 et que vous en avez accepté les termes.
#
#**************************************************************************************************************************
regle 8501 :
application : iliad , batch  ;
 pour i= V,C,P:                                           
BIPTAi = (BICNOi - BICDNi );           
pour i= V,C,P:                                           
BIPTTAi = (BIPTAi + BI1Ai);              
regle 8503 :
application : iliad , batch  ;
pour i= V,C,P:                                           
BINTAi = (BICREi - BICDEi );        
                                                         
pour i= V,C,P:                                           
BINTTAi = (BINTAi + BI2Ai);           
                                                         
                                                         
regle 8506 :
application : iliad , batch  ;
 
pour i= V,C,P:                                           
BI12Ai = BI1Ai +  BI2Ai;

regle 8508 :
application : iliad , batch  ;

pour i= V,C,P:                                           
BITAi = BIPTAi + BINTAi;

pour i= V,C,P:                                           
BITTAi = BITAi + BI12Ai;

regle 857:
application : iliad , batch  ;
BI1 = somme(i=V,C,P:BI1i);
BI2 = somme(i=V,C,P:BI2i);
regle 8571:
application : iliad , batch  ;
pour i = V,C,P:
BI1i = BI1Ai;
pour i = V,C,P:
BI2i = BI2Ai;
regle 8580:
application : iliad , batch ;
pour i = V,P,C:
BIHTAi = max(0,arr((BIHNOi - BIHDNi) * MAJREV))
         + min(0,(BIHNOi - BIHDNi) );

pour i = V,P,C:
BINHTAi = max(0,arr((BICHREi - BICHDEi)*MAJREV))
          + min(0,(BICHREi - BICHDEi) ) ;
regle 85200:
application : iliad , batch ;

pour i = V,C,P:
MIB_TVENi = MIBVENi + MIBNPVENi + MIBGITEi+LOCGITi;

pour i = V,C,P:
MIB_TPRESi = MIBPRESi + MIBNPPRESi + MIBMEUi;

pour i = V,C,P:
MIB_TTi = MIB_TVENi + MIB_TPRESi;

regle 85240:
application : iliad , batch ;

pour i = V,C,P:
MIB_AVi = min ( MIB_TVENi,
                         (max(MIN_MBIC,
                              arr( MIB_TVENi*TX_MIBVEN/100))
                         )
              );
pour i = V,C,P:
PMIB_AVi = min ( MIBVENi,
                         (max(MIN_MBIC,
                              arr( MIBVENi*TX_MIBVEN/100))
                         )
              );


pour i = V,C,P:
MIB_APi = min ( MIB_TPRESi,
                         (max(MIN_MBIC,
                              arr(MIB_TPRESi*TX_MIBPRES/100))
                         )
               );
pour i = V,C,P:
PMIB_APi = min ( MIBPRESi,
                         (max(MIN_MBIC,
                              arr(MIBPRESi*TX_MIBPRES/100))
                         )
               );



regle 85250:
application : iliad , batch ;

pour i = V,C,P:
MIB_ABVi = max(0,arr(MIB_AVi * MIBVENi / MIB_TVENi));
pour i = V,C,P:
MIB_ABNPVi = max(0,arr(MIB_AVi * MIBNPVENi / MIB_TVENi))* positif(present(MIBGITEi)+present(LOCGITi))
	      + (MIB_AVi - MIB_ABVi) * (1 - positif(present(MIBGITEi)+present(LOCGITi)));
pour i = V,C,P:
MIB_ABNPVLi = (MIB_AVi - MIB_ABVi - MIB_ABNPVi) * positif(present(MIBGITEi)+present(LOCGITi));

pour i = V,C,P:
MIB_ABPi = max(0,arr(MIB_APi * MIBPRESi / MIB_TPRESi));
pour i = V,C,P:
MIB_ABNPPi = max(0,arr(MIB_APi * MIBNPPRESi / MIB_TPRESi)) * present(MIBMEUi)
	      + (MIB_APi - MIB_ABPi) * (1 - present(MIBMEUi));
pour i = V,C,P:
MIB_ABNPPLi = (MIB_APi - MIB_ABPi - MIB_ABNPPi) *  present(MIBMEUi);


regle 85260:
application : iliad , batch ;

pour i = V,C,P:
MIB_NETVi = MIBVENi - MIB_ABVi;
MIBNETVF = somme(i=V,C,P:MIB_NETVi) ;
pour i = V,C,P:
MIB_NETNPVi = MIBNPVENi - MIB_ABNPVi;
MIBNETNPVF = somme(i=V,C,P:MIB_NETNPVi);
pour i = V,C,P:
MIB_NETNPVLi = MIBGITEi+ LOCGITi - MIB_ABNPVLi;
pour i = V,C,P:
MIBNETNPVLSi = arr(MIB_NETNPVLi * MIBGITEi / (MIBGITEi + LOCGITi));
pour i = V,C,P:
MIBNETNPVLNSi = MIB_NETNPVLi - MIBNETNPVLSi;
MIBNETNPVLF = somme(i=V,C,P:MIB_NETNPVLi);

pour i = V,C,P:
MIB_NETPi = MIBPRESi - MIB_ABPi;
MIBNETPF = somme(i=V,C,P:MIB_NETPi) ;
pour i = V,C,P:
MIB_NETNPPi = MIBNPPRESi - MIB_ABNPPi;
MIBNETNPPF = somme(i=V,C,P:MIB_NETNPPi);
pour i = V,C,P:
MIB_NETNPPLi = MIBMEUi - MIB_ABNPPLi;
MIBNETNPPLF = somme(i=V,C,P:MIB_NETNPPLi);

pour i = V,C,P:
PMIB_NETVi = MIBVENi - PMIB_AVi;
pour i = V,C,P:
PMIB_NETPi = MIBPRESi - PMIB_APi;



regle 85265:
application : iliad , batch ;
MIB_NETCT = MIBPVV + MIBPVC + MIBPVP - BICPMVCTV - BICPMVCTC - BICPMVCTP;

MIB_NETNPCT = MIBNPPVV + MIBNPPVC + MIBNPPVP - MIBNPDCT ;


regle 85270:
application : iliad , batch ;

pour i=V,C,P:
MIB_P1Ai = MIB1Ai - MIBDEi ;
pour i=V,C,P:
MIB_NP1Ai = MIBNP1Ai - MIBNPDEi ;
pour i=V,C,P:
MIB_1Ai = max(0,MIB_P1Ai + MIB_NP1Ai);
MIB_1AF = max (0, somme(i=V,C,P:MIB_1Ai));
regle 85390:
application : iliad , batch ;
pour i = V,C,P:
REVIBI12i = BIH1i + BIH2i + BI1Ai + BI2Ai;
regle 85700:
application : iliad , batch ;
BICPF = somme(i=V,C,P:BIPTAi+BIHTAi+MIB_NETVi+MIB_NETPi) + MIB_NETCT  ; 
regle 85730:
application : iliad , batch ;
DEFNP  = somme (i=1,2,3,4,5,6:DEFBICi);
pour i = V,C,P:
BICNPi = BINTAi+BINHTAi+  MIB_NETNPVi + MIB_NETNPPi ;
BICNPF = max(0,somme(i=V,C,P:BICNPi)+MIB_NETNPCT - DEFNP)  ; 
DEFNPI = abs(min( DEFNP , somme(i=V,C,P:BICNPi*positif(BICNPi))));

regle 85740:
application : iliad , batch ;
BICNPR = somme(i=V,C,P:BINTAi);
regle 85750:
application : iliad , batch ;
BI12F = somme(i=V,C,P:REVIBI12i) + MIB_1AF  ; 
regle 85900:
application : iliad , batch  ;                   
pour i=V,C,P:                                       
BICIMPi = BIHTAi +  BIPTAi + MIB_NETVi + MIB_NETPi;
BIN = BICPF + BICNPF ;
regle 85960:
application : batch, iliad ;



DCTMIB = (BICPMVCTV + BICPMVCTC + BICPMVCTP) * positif_ou_nul(BIPN+MIB_NETCT)
	 + (1-positif_ou_nul(BIPN+MIB_NETCT)) * ((BICPMVCTV +BICPMVCTC +BICPMVCTP ) - abs(BIPN+MIB_NETCT))
	 + (1-positif_ou_nul(BIPN+MIB_NETCT)) * null((BICPMVCTV +BICPMVCTC +BICPMVCTP) - abs(BIPN+MIB_NETCT)) * (BICPMVCTV +BICPMVCTC +BICPMVCTP)
	 ;
DCTMIBNP = MIBNPDCT * positif_ou_nul(BINNV+BINNC+BINNP+MIB_NETNPCT)
	 + (1-positif_ou_nul(BINNV+BINNC+BINNP+MIB_NETNPCT)) * (MIBNPDCT - abs(BINNV+BINNC+BINNP+MIB_NETNPCT))
	 + (1-positif_ou_nul(BINNV+BINNC+BINNP+MIB_NETNPCT)) * null(MIBNPDCT - abs(BINNV+BINNC+BINNP+MIB_NETNPCT))*MIBNPDCT
	 ;
regle 90000:
application : iliad , batch  ;                   

DEPLOCV = (LOCPROCGAV - LOCDEFPROCGAV) + (LOCPROV - LOCDEFPROV) ;
DEPLOCC = (LOCPROCGAC - LOCDEFPROCGAC) + (LOCPROC - LOCDEFPROC) ;
DEPLOCP = (LOCPROCGAP - LOCDEFPROCGAP) + (LOCPROP - LOCDEFPROP) ;

DENPLOCV = (LOCNPCGAV + LOCGITCV - LOCDEFNPCGAV) + (LOCNPV + LOCGITHCV - LOCDEFNPV) ;
DENPLOCC = (LOCNPCGAC + LOCGITCC - LOCDEFNPCGAC) + (LOCNPC + LOCGITHCC - LOCDEFNPC) ;
DENPLOCP = (LOCNPCGAPAC + LOCGITCP - LOCDEFNPCGAPAC) + (LOCNPPAC + LOCGITHCP - LOCDEFNPPAC) ;

PLOCCGAV = LOCPROCGAV - LOCDEFPROCGAV;
PLOCCGAC = LOCPROCGAC - LOCDEFPROCGAC;
PLOCCGAPAC = LOCPROCGAP - LOCDEFPROCGAP;
NPLOCCGAV = LOCNPCGAV + LOCGITCV - LOCDEFNPCGAV;
NPLOCCGAC = LOCNPCGAC + LOCGITCC - LOCDEFNPCGAC;
NPLOCCGAPAC = LOCNPCGAPAC + LOCGITCP - LOCDEFNPCGAPAC;
NPLOCCGASV = arr(NPLOCCGAV * LOCNPCGAV / (LOCNPCGAV + LOCGITCV))* present(LOCNPCGAV) + min(0,NPLOCCGAV) * (1-present(LOCNPCGAV));
NPLOCCGASC = arr(NPLOCCGAC * LOCNPCGAC / (LOCNPCGAC + LOCGITCC))* present(LOCNPCGAC) + min(0,NPLOCCGAC) * (1-present(LOCNPCGAC));
NPLOCCGASP = arr(NPLOCCGAPAC * LOCNPCGAPAC / (LOCNPCGAPAC + LOCGITCP))* present(LOCNPCGAPAC) + min(0,NPLOCCGAPAC) * (1-present(LOCNPCGAPAC));
NPLOCCGANSV = NPLOCCGAV - NPLOCCGASV;
NPLOCCGANSC = NPLOCCGAC - NPLOCCGASC;
NPLOCCGANSP = NPLOCCGAPAC - NPLOCCGASP;
PLOCV = min(0,LOCPROV - LOCDEFPROV) * positif_ou_nul(LOCDEFPROV - LOCPROV) 
	       + arr(max(0, LOCPROV - LOCDEFPROV) * MAJREV) * positif(LOCPROV - LOCDEFPROV);
PLOCC = min(0,LOCPROC - LOCDEFPROC) * positif_ou_nul(LOCDEFPROC - LOCPROC) 
	       + arr(max(0, LOCPROC - LOCDEFPROC) * MAJREV) * positif(LOCPROC - LOCDEFPROC);
PLOCPAC = min(0,LOCPROP - LOCDEFPROP) * positif_ou_nul(LOCDEFPROP - LOCPROP) 
	       + arr(max(0, LOCPROP - LOCDEFPROP) * MAJREV) * positif(LOCPROP - LOCDEFPROP);
NPLOCV = min(0,LOCNPV + LOCGITHCV - LOCDEFNPV) * positif_ou_nul(LOCDEFNPV - LOCNPV- LOCGITHCV ) 
	       + arr(max(0, LOCNPV + LOCGITHCV - LOCDEFNPV) * MAJREV) * positif(LOCNPV + LOCGITHCV - LOCDEFNPV);
NPLOCC = min(0,LOCNPC + LOCGITHCC - LOCDEFNPC) * positif_ou_nul(LOCDEFNPC - LOCNPC- LOCGITHCC ) 
	       + arr(max(0, LOCNPC + LOCGITHCC - LOCDEFNPC) * MAJREV) * positif(LOCNPC + LOCGITHCC - LOCDEFNPC);
NPLOCPAC = min(0,LOCNPPAC + LOCGITHCP - LOCDEFNPPAC) * positif_ou_nul(LOCDEFNPPAC - LOCNPPAC- LOCGITHCP ) 
	       + arr(max(0, LOCNPPAC + LOCGITHCP - LOCDEFNPPAC) * MAJREV) * positif(LOCNPPAC + LOCGITHCP - LOCDEFNPPAC);
NPLOCSV = arr(NPLOCV * LOCNPV / (LOCNPV + LOCGITHCV))* present(LOCNPV) + min(0,NPLOCV) * (1-present(LOCNPV));
NPLOCSC = arr(NPLOCC * LOCNPC / (LOCNPC + LOCGITHCC))* present(LOCNPC) + min(0,NPLOCC) * (1-present(LOCNPC));
NPLOCSP = arr(NPLOCPAC * LOCNPPAC / (LOCNPPAC + LOCGITHCP))* present(LOCNPPAC) + min(0,NPLOCPAC) * (1-present(LOCNPPAC));
NPLOCNSV = NPLOCV - NPLOCSV;
NPLOCNSC =  NPLOCC - NPLOCSC;
NPLOCNSP = NPLOCPAC - NPLOCSP;
regle 90010:
application : iliad , batch  ;                   
PLOCNETV = PLOCCGAV + PLOCV;
PLOCNETC = PLOCCGAC + PLOCC;
PLOCNETPAC = PLOCCGAPAC + PLOCPAC;
NPLOCNETTV = NPLOCCGAV + NPLOCV + MIB_NETNPVLV + MIB_NETNPPLV ;
NPLOCNETTC = NPLOCCGAC + NPLOCC + MIB_NETNPVLC + MIB_NETNPPLC ;
NPLOCNETTPAC = NPLOCCGAPAC + NPLOCPAC + MIB_NETNPVLP + MIB_NETNPPLP ;
NPLOCNETTSV = NPLOCCGASV + NPLOCSV + MIBNETNPVLSV + MIB_NETNPPLV ;
NPLOCNETTSC = NPLOCCGASC + NPLOCSC + MIBNETNPVLSC + MIB_NETNPPLC ;
NPLOCNETTSP = NPLOCCGASP + NPLOCSP + MIBNETNPVLSP + MIB_NETNPPLP ;
NPLOCNETV = NPLOCCGAV + NPLOCV ;
NPLOCNETC = NPLOCCGAC + NPLOCC ;
NPLOCNETPAC = NPLOCCGAPAC + NPLOCPAC ;
regle 90020:
application : iliad , batch  ;                   
PLOCNETF = PLOCNETV + PLOCNETC + PLOCNETPAC;
TOTDEFLOCNP = LNPRODEF10 + LNPRODEF9 + LNPRODEF8 + LNPRODEF7 + LNPRODEF6 +  LNPRODEF5 + LNPRODEF4 + LNPRODEF3 + LNPRODEF2 + LNPRODEF1;
NPLOCNETF10 = NPLOCNETTV + NPLOCNETTC + NPLOCNETTPAC-(LNPRODEF10 +  LNPRODEF9);
NPLOCNETF9 = NPLOCNETTV + NPLOCNETTC + NPLOCNETTPAC-(LNPRODEF10 +  LNPRODEF9 + LNPRODEF8);
NPLOCNETF8 = NPLOCNETTV + NPLOCNETTC + NPLOCNETTPAC-(LNPRODEF10 +  LNPRODEF9 + LNPRODEF8 + LNPRODEF7);
NPLOCNETF7 = NPLOCNETTV + NPLOCNETTC + NPLOCNETTPAC-(LNPRODEF10 +  LNPRODEF9 + LNPRODEF8 + LNPRODEF7 + LNPRODEF6);
NPLOCNETF6 = NPLOCNETTV + NPLOCNETTC + NPLOCNETTPAC-(LNPRODEF10 +  LNPRODEF9 + LNPRODEF8 + LNPRODEF7 + LNPRODEF6 + LNPRODEF5);
NPLOCNETF5 = NPLOCNETTV + NPLOCNETTC + NPLOCNETTPAC-(LNPRODEF10 +  LNPRODEF9 + LNPRODEF8 + LNPRODEF7 + LNPRODEF6 + LNPRODEF5 + LNPRODEF4);
NPLOCNETF4 = NPLOCNETTV + NPLOCNETTC + NPLOCNETTPAC-(LNPRODEF10 +  LNPRODEF9 + LNPRODEF8 + LNPRODEF7 + LNPRODEF6 + LNPRODEF5 + LNPRODEF4 + LNPRODEF3);
NPLOCNETF3 = NPLOCNETTV + NPLOCNETTC + NPLOCNETTPAC-(LNPRODEF10 +  LNPRODEF9 + LNPRODEF8 + LNPRODEF7 + LNPRODEF6 + LNPRODEF5 + LNPRODEF4 + LNPRODEF3 + LNPRODEF2 );
NPLOCNETF2 = NPLOCNETTV + NPLOCNETTC + NPLOCNETTPAC-(LNPRODEF10 +  LNPRODEF9 + LNPRODEF8 + LNPRODEF7 + LNPRODEF6 + LNPRODEF5 + LNPRODEF4 + LNPRODEF3 + LNPRODEF2 + LNPRODEF1);
NPLOCNETF = max(0,NPLOCNETTV + NPLOCNETTC + NPLOCNETTPAC-TOTDEFLOCNP);
NPLOCNETSF = max(0,NPLOCNETTSV + NPLOCNETTSC + NPLOCNETTSP-TOTDEFLOCNP);
DNPLOCIMPU = max(0,min(TOTDEFLOCNP,NPLOCNETTV + NPLOCNETTC + NPLOCNETTPAC));
NPLOCNETFHDEFANT = max(0,NPLOCNETTV + NPLOCNETTC + NPLOCNETTPAC);
DEFNPLOCF = min(0,NPLOCNETTV + NPLOCNETTC + NPLOCNETTPAC-(TOTDEFLOCNP-LNPRODEF10));
DEFNONPLOC = abs(DEFNPLOCF) ;
regle 90030:
application : iliad , batch  ;
DEFLOC10 = (1- positif_ou_nul(NPLOCNETF10))
            * abs(min(max(NPLOCNETFHDEFANT-LNPRODEF10,0)-LNPRODEF9,LNPRODEF9))
            * positif_ou_nul(LNPRODEF9-max(NPLOCNETFHDEFANT-LNPRODEF10,0));
DEFLOC9 = (1- positif_ou_nul(NPLOCNETF9))
            * abs(min(max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9,0)-LNPRODEF8,LNPRODEF8))
            * positif_ou_nul(LNPRODEF8-max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9,0));
DEFLOC8 = (1- positif_ou_nul(NPLOCNETF8))
            * abs(min(max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9-LNPRODEF8,0)-LNPRODEF7,LNPRODEF7))
            * positif_ou_nul(LNPRODEF7-max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9-LNPRODEF8,0));
DEFLOC7 = (1- positif_ou_nul(NPLOCNETF7))
            * abs(min(max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9-LNPRODEF8-LNPRODEF7,0)-LNPRODEF6,LNPRODEF6))
            * positif_ou_nul(LNPRODEF6-max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9-LNPRODEF8-LNPRODEF7,0));
DEFLOC6 = (1- positif_ou_nul(NPLOCNETF6))
            * abs(min(max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9-LNPRODEF8-LNPRODEF7-LNPRODEF6,0)-LNPRODEF5,LNPRODEF5))
            * positif_ou_nul(LNPRODEF5-max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9-LNPRODEF8-LNPRODEF7-LNPRODEF6,0));
DEFLOC5 = (1- positif_ou_nul(NPLOCNETF5))
            * abs(min(max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9-LNPRODEF8-LNPRODEF7-LNPRODEF6 -LNPRODEF5,0)-LNPRODEF4,LNPRODEF4))
            * positif_ou_nul(LNPRODEF4-max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9-LNPRODEF8-LNPRODEF7-LNPRODEF6-LNPRODEF5,0));
DEFLOC4 =(1- positif_ou_nul(NPLOCNETF4))
            * abs(min(max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9-LNPRODEF8-LNPRODEF7-LNPRODEF6-LNPRODEF5-LNPRODEF4,0)-LNPRODEF3,LNPRODEF3))
            * positif_ou_nul(LNPRODEF3-max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9-LNPRODEF8-LNPRODEF7-LNPRODEF6-LNPRODEF5-LNPRODEF4,0));
DEFLOC3 =(1- positif_ou_nul(NPLOCNETF3))
            * abs(min(max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9-LNPRODEF8-LNPRODEF7-LNPRODEF6-LNPRODEF5-LNPRODEF4-LNPRODEF3,0)-LNPRODEF2,LNPRODEF2))
            * positif_ou_nul(LNPRODEF2-max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9-LNPRODEF8-LNPRODEF7-LNPRODEF6-LNPRODEF5-LNPRODEF4-LNPRODEF3,0));
DEFLOC2 = (1-positif_ou_nul(NPLOCNETF2))
            * abs(min(max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9-LNPRODEF8-LNPRODEF7-LNPRODEF6-LNPRODEF5-LNPRODEF4-LNPRODEF3-LNPRODEF2,0)-LNPRODEF1,LNPRODEF1))
            * positif_ou_nul(LNPRODEF1-max(NPLOCNETFHDEFANT-LNPRODEF10-LNPRODEF9-LNPRODEF8-LNPRODEF7-LNPRODEF6-LNPRODEF5-LNPRODEF4-LNPRODEF3-LNPRODEF2,0));
DEFNPLOCFAV = max(0,abs(DEFNPLOCF) - DEFLOC2 - DEFLOC3 - DEFLOC4 - DEFLOC5 - DEFLOC6 - DEFLOC7 - DEFLOC8 - DEFLOC9 - DEFLOC10);
DEFLOC1 = positif(DEFNONPLOC) * DEFNPLOCFAV;
