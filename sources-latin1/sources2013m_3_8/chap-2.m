#*************************************************************************************************************************
#
#Copyright or � or Copr.[DGFIP][2017]
#
#Ce logiciel a �t� initialement d�velopp� par la Direction G�n�rale des 
#Finances Publiques pour permettre le calcul de l'imp�t sur le revenu 2014 
#au titre des revenus per�us en 2013. La pr�sente version a permis la 
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
 #
 #     CHAPITRE 2. CALCUL DU NET A PAYER
 #
 #
 #
regle 20100:
application : batch, iliad ;
NAPINI = ( IRN + PIR - IRANT )* (1 - INDTXMIN) *(1 - INDTXMOY)
       + min(0, IRN + PIR - IRANT) * (INDTXMIN + INDTXMOY)
       + max(0, IRN + PIR - IRANT) * 
                                (INDTXMIN*positif((IAVIMBIS-NAPCRPAVIM)-SEUIL_61 )
			       + INDTXMOY* positif((IAVIMO-NAPCRPAVIM)-SEUIL_61))
                      + RASAR * V_CR2;
RC1INI = positif( NAPINI + 1 - SEUIL_12 ) ;
regle 20101:
application : batch, iliad ;
NAPTOT = IRCUM + TAXACUM + PCAPCUM + TAXLOYCUM + HAUTREVCUM  - RECUMIR;
regle 20103:
application : iliad ,batch;
NAPTOTA = V_IRPSANT - V_ANTRE;
NAPTOTAIR = V_TOTIRANT - V_ANTREIR;
TOTCRA = V_ANTCR ;
TOTIRPSANT = V_IRPSANT - V_NONMERANT + V_NONRESTANT - V_ANTRE;
regle 20104:
application : iliad ;
OCEDIMP = IRNIN ;
regle 20105:
application : batch, iliad ;
IRNIN = (IRN - IRANT) * positif(IRN - IRANT) ;
regle isf 201050:
application : batch, iliad ;
ISF4BASE = ISF4BIS * positif_ou_nul(ISF4BIS - SEUIL_12);  
ISFIN = ISF4BASE ;
regle 201051:
application : batch, iliad;
IRNIN_INR = (IRN - IRANT - ACODELAISINR) * positif(IRN - IRANT) ;
CSBASE = CSG - CSGIM ;
RDBASE = RDSN - CRDSIM ;
PSBASE = PRS - PRSPROV ;
CVNBASE = CVNSALC - COD8YT ;
CDISBASE = CDIS - CDISPROV ;
GLOBASE = CGLOA - COD8YL ;
RSE1BASE = RSE1N - CSPROVYD;
RSE2BASE = RSE2N - CSPROVYF;
RSE3BASE = RSE3N - CSPROVYG;
RSE4BASE = RSE4N - CSPROVYH;
RSE5BASE = RSE5N - CSPROVYE;
TAXABASE = arr(max(TAXASSUR + min(0,IRN - IRANT),0)) * positif(IAMD1 + 1 - SEUIL_61);
PCAPBASE = arr(max(IPCAPTAXT + min(0,IRN - IRANT + TAXASSUR),0)) * positif(IAMD1 + 1 - SEUIL_61);
LOYBASE = arr(max(TAXLOY + min(0,IRN - IRANT + TAXASSUR+IPCAPTAXT),0)) * positif(IAMD1 + 1 - SEUIL_61);
CHRBASE = arr(max(IHAUTREVT + min(0,IRN - IRANT + TAXASSUR+IPCAPTAXT+TAXLOY),0)) * positif(IAMD1 + 1 - SEUIL_61);

IRBASE_I = (IRN -IRANT)*positif(IRN+1-SEUIL_12);

IRBASE_N = (IRN - IRANT)*(1 - positif (IRN-IRANT + TAXABASE_IRECT+CAPBASE_IRECT+HRBASE_IRECT))
           + (IAN - min( IAN , IRE )) * positif (IRN-IRANT + TAXABASE_IRECT+CAPBASE_IRECT+HRBASE_IRECT);
TAXABASE_I = TAXASSUR * positif(IAMD1 + 1 - SEUIL_61);
TAXABASE_N = arr(max(TAXASSUR + min(0,IRN - IRANT),0)) * positif(IAMD1 + 1 - SEUIL_61);
CAPBASE_I = IPCAPTAXT * positif(IAMD1 + 1 - SEUIL_61);
CAPBASE_N = arr(max(IPCAPTAXT + min(0,IRN - IRANT + TAXASSUR),0)) * positif(IAMD1 + 1 - SEUIL_61);
LOYBASE_I = TAXLOY * positif(IAMD1 + 1 - SEUIL_61);
LOYBASE_N = arr(max(TAXLOY + min(0,IRN - IRANT + TAXASSUR+IPCAPTAXT),0)) * positif(IAMD1 + 1 - SEUIL_61);
HRBASE_I = IHAUTREVT * positif(IAMD1 + 1 - SEUIL_61);
HRBASE_N = arr(max(IHAUTREVT + min(0,IRN - IRANT + TAXASSUR+IPCAPTAXT+TAXLOY),0)) * positif(IAMD1 + 1 - SEUIL_61);

IRNN = IRNIN;

regle 20106:
application : iliad;
PIR = (
       INCIR_NET
       + NMAJ1 + NMAJ3 + NMAJ4 
       + arr((BTOINR) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT)))
       ;
PPRS = (
       INCPS_NET
       + NMAJP1 + NMAJP4
       + arr((PRS-PRSPROV) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PCSG = (
       INCCS_NET
       + NMAJC1 + NMAJC4
         + arr((CSG-CSGIM) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PRDS = (
       INCRD_NET
       + NMAJR1 + NMAJR4
         + arr((RDSN-CRDSIM) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

PTAXA = (
       INCTAXA_NET
       + NMAJTAXA1 + NMAJTAXA3 + NMAJTAXA4
         + arr(max(0,TAXASSUR- min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))+min(0,IRN - IRANT)) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PPCAP = (
       INCPCAP_NET
       + NMAJPCAP1 + NMAJPCAP3 + NMAJPCAP4
         + arr(max(0,IPCAPTAXT- min(IPCAPTAXT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR))+min(0,IRN - IRANT+TAXASSUR)) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PTAXLOY = (
       INCLOY_NET
       + NMAJLOY1 + NMAJLOY3 + NMAJLOY4
         + arr(max(0,LOYELEV- min(LOYELEV+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR-IPCAPTAXT))+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT)) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PHAUTREV  = (
       INCCHR_NET
       + NMAJCHR1 + NMAJCHR3 + NMAJCHR4
         + arr(max(0,IHAUTREVT+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT+LOYELEV)) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PCVN = (
       INCCVN_NET
       + NMAJCVN1 + NMAJCVN4
         + arr(max(0,(CVNSALC - COD8YT)) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PGLOA = (
       INCGLOA_NET
       + NMAJGLO1 + NMAJGLO4
         + arr(((CGLOA  - COD8YL)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT)))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PRSE1 = (
       INCRSE1_NET
       + NMAJRSE11 + NMAJRSE14
         + arr(max(0,RSE1 -CIRSE1 -CSPROVYD)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PRSE2 = (
       INCRSE2_NET
       + NMAJRSE21 + NMAJRSE24
         + arr(max(0,RSE2 -CIRSE2 -CSPROVYF)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PRSE3 = (
       INCRSE3_NET
       + NMAJRSE31 + NMAJRSE34
         + arr(max(0,RSE3 -CIRSE3 -CSPROVYG)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PRSE4 = (
       INCRSE4_NET
       + NMAJRSE41 + NMAJRSE44
         + arr(max(0,RSE4 -CIRSE4 -CSPROVYH)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PRSE5 = (
       INCRSE5_NET
       + NMAJRSE51 + NMAJRSE54
         + arr(max(0,RSE5 -CIRSE5 -CSPROVYE)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PCDIS = (
       INCCDIS_NET
       + NMAJCDIS1 + NMAJCDIS4
         + arr((CDIS-CDISPROV) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

PDEG = max(0,PIR_A + PTAXA_A + PPCAP_A - PTAXLOY_A - PCHR_A - PIR - PTAXA - PPCAP - PTAXLOY - PHAUTREV);

regle 201061:
application : batch , iliad  ;
PTOTIRCS = PIR + PPRS + PCSG + PRDS + PTAXA + PTAXLOY + PHAUTREV + PPCAP + PCDIS + PCVN 
	   + PGLOA + PRSE1 + PRSE2 + PRSE3 + PRSE4 + PRSE5 ;
TOTPENIR = PIR + PTAXA + PTAXLOY + PHAUTREV + PPCAP ;

TOTPENCS = PPRS+ PCSG + PRDS + PCVN + PCDIS + PGLOA + PRSE1 + PRSE2 + PRSE3 + PRSE4 + PRSE5;

RETIRCS_TOT = RETIR+RETCS+RETRD+RETPS+RETCVN+RETCDIS+RETGLOA+RETRSE1+RETRSE2+RETRSE3+RETRSE4+RETRSE5
              +RETTAXA+RETPCAP+RETLOY+RETHAUTREV ;


regle 20107:
application : batch  ;
PIR = PTOIR * positif_ou_nul(IAMD1 - SEUIL_61) ;
PPRS = PTOPRS ;
PCSG = PTOCSG ;
PRSE1 = PTORSE1 ;
PRSE2 = PTORSE2 ;
PRSE3 = PTORSE3 ;
PRSE4 = PTORSE4 ;
PRSE5 = PTORSE5 ;
PRDS = PTORDS ;
PTAXA = PTOTAXA ;
PPCAP = PTOTPCAP ;
PTAXLOY = PTOTLOY ;
PHAUTREV = PTOTCHR ;
PCVN = PTOCVN ;
PCDIS = PTOCDIS ;
PGLOA = PTOGLOA ;

regle 20109:
application : iliad , batch ;
PTOT = PIR ;
regle 20110:
application : iliad ;
ILI_SYNT_IR =  positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR) * max(0 , IRCUM - NONMER + NONREST - PIR)
              + (1 - positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR)) * (TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR) ;

PIRNEG = abs(min(0 , IRCUM - NONMER + NONREST - PIR)) ;

ILI_SYNT_TAXA = positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR) * max(0,TAXACUM - PTAXA - PIRNEG)
               + (1 - positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR)) * 0 ;

PTAXANEG = abs(min(0 , TAXACUM - PTAXA - PIRNEG)) ;

ILI_SYNT_CAP = positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR) * max(0 , PCAPCUM - PPCAP - PTAXANEG)
               + (1 - positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR)) * 0 ;

PPCAPNEG = abs(min(0 , PCAPCUM - PPCAP - PTAXANEG)) ;

ILI_SYNT_LOY = positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR) * max(0 , TAXLOYCUM - PTAXLOY - PPCAPNEG)
               + (1 - positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR)) * 0 ;

PTAXLOYNEG = abs(min(0 , TAXLOYCUM - PTAXLOY - PPCAPNEG)) ;

ILI_SYNT_CHR = positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR) * max(0 , HAUTREVCUM - PHAUTREV - PTAXLOYNEG)
               + (1 - positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR)) * 0 ;

ILI_SYNT_TOTIR = ILI_SYNT_IR + ILI_SYNT_TAXA + ILI_SYNT_CAP + ILI_SYNT_LOY + ILI_SYNT_CHR ;

regle 201101:
application : iliad ;
ILI_SYNT_IRNET =  positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR) * max(0,IRCUM-PIR)
	      + (1 - positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR)) * (TOTIRCUM - RECUMIR - TOTPENIR);
PIRNETNEG =  max(0,PIR-IRCUM);
ILI_SYNT_TAXANET = positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR) * max(0,TAXACUM - PTAXA - PIRNETNEG)
	       + (1 - positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR)) * 0;

PTAXANETNEG =  max(0,PIR+PTAXA-IRCUM-TAXACUM);
ILI_SYNT_CAPNET = positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR) * max(0,PCAPCUM -PPCAP-PTAXANETNEG)
	       + (1 - positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR)) * 0;

PPCAPNETNEG =  max(0,PIR+PTAXA+PPCAP-IRCUM-TAXACUM-PCAPCUM);
ILI_SYNT_LOYNET = positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR) * max(0,TAXLOYCUM-PTAXLOY-PPCAPNETNEG)
	       + (1 - positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR)) * 0;

PTAXLOYNETNEG =  max(0,PIR+PTAXA+PPCAP+PTAXLOY-IRCUM-TAXACUM-PCAPCUM-TAXLOYCUM);
ILI_SYNT_CHRNET = positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR) * max(0,HAUTREVCUM-PHAUTREV-PTAXLOYNETNEG) 
	       + (1 - positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR)) * 0;
ILI_SYNT_TOTIRNET = ILI_SYNT_IRNET + ILI_SYNT_TAXANET + ILI_SYNT_CAPNET + ILI_SYNT_LOYNET + ILI_SYNT_CHRNET;
regle 20111:
application : iliad ;
DEC_CGA_AGA = BAFV + BAFC + BAFP
            + BAHREV - (BAHDEV * (1 - positif(ART1731BIS) ))
            + BAHREC - (BAHDEC * (1 - positif(ART1731BIS) ))
            + BAHREP - (BAHDEP * (1 - positif(ART1731BIS) ))
            + BIHNOV - (BIHDNV * (1 - positif(ART1731BIS) ))
            + BIHNOC - (BIHDNC * (1 - positif(ART1731BIS) ))
            + BIHNOP - (BIHDNP * (1 - positif(ART1731BIS) ))
            + BICHREV - (min(BICHDEV,BICHDEV1731+0) * positif(ART1731BIS) + BICHDEV * (1 - ART1731BIS))
            + BICHREC - (min(BICHDEC,BICHDEC1731+0) * positif(ART1731BIS) + BICHDEC * (1 - ART1731BIS)) 
            + BICHREP - (min(BICHDEP,BICHDEP1731+0) * positif(ART1731BIS) + BICHDEP * (1 - ART1731BIS)) 
            + BNHREV - (BNHDEV * (1 - positif(ART1731BIS) ))
            + BNHREC - (BNHDEC * (1 - positif(ART1731BIS) ))
            + BNHREP - (BNHDEP * (1 - positif(ART1731BIS) ))
            + ANOCEP - (min(DNOCEP,DNOCEP1731+0) * positif(ART1731BIS) + DNOCEP * (1 - ART1731BIS))
            + ANOVEP - (min(DNOCEPC,DNOCEPC1731+0) * positif(ART1731BIS) + DNOCEPC * (1 - ART1731BIS))
            + ANOPEP - (min(DNOCEPP,DNOCEPP1731+0) * positif(ART1731BIS) + DNOCEPP * (1 - ART1731BIS))
	    ;
MAJ_CGA_AGA =  arr(SUPREV * (BAFV + BAFC + BAFP))
	    + arr(SUPREV * max(0,BAHREV - (BAHDEV * (1 - positif(ART1731BIS) ))))
            + arr(SUPREV * max(0,BAHREC - (BAHDEC * (1 - positif(ART1731BIS) ))))
            + arr(SUPREV * max(0,BAHREP - (BAHDEP * (1 - positif(ART1731BIS) ))))
            + arr(SUPREV * max(0,BIHNOV - (BIHDNV * (1 - positif(ART1731BIS) )) ))
            + arr(SUPREV * max(0,BIHNOC - (BIHDNC * (1 - positif(ART1731BIS) )) ))
            + arr(SUPREV * max(0,BIHNOP - (BIHDNP * (1 - positif(ART1731BIS) )) ))
            + arr(SUPREV * max(0,BICHREV - (min(BICHDEV,BICHDEV1731+0) * positif(ART1731BIS) + BICHDEV * (1 - ART1731BIS)) ))
            + arr(SUPREV * max(0,BICHREC - (min(BICHDEC,BICHDEC1731+0) * positif(ART1731BIS) + BICHDEC * (1 - ART1731BIS)) ))
            + arr(SUPREV * max(0,BICHREP - (min(BICHDEP,BICHDEP1731+0) * positif(ART1731BIS) + BICHDEP * (1 - ART1731BIS)) ))
            + arr(SUPREV * max(0,BNHREV - (BNHDEV * (1 - positif(ART1731BIS) ))))
            + arr(SUPREV * max(0,BNHREC - (BNHDEC * (1 - positif(ART1731BIS) ))))
            + arr(SUPREV * max(0,BNHREP - (BNHDEP * (1 - positif(ART1731BIS) ))))
            + arr(SUPREV * max(0,ANOCEP - (min(DNOCEP,DNOCEP1731+0) * positif(ART1731BIS) + DNOCEP * (1 - ART1731BIS))))
            + arr(SUPREV * max(0,ANOVEP - (min(DNOCEPC,DNOCEPC1731+0) * positif(ART1731BIS) + DNOCEPC * (1 - ART1731BIS))))
            + arr(SUPREV * max(0,ANOPEP - (min(DNOCEPP,DNOCEPP1731+0) * positif(ART1731BIS) + DNOCEPP * (1 - ART1731BIS))))
	    ;
TOT_CGA_AGA = DEC_CGA_AGA + MAJ_CGA_AGA;
