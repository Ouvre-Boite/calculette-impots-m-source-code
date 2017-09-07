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

verif corrective horizontale 19 :
application : iliad ;
si
   (
      ( COD_RAPPEL = 1 et MONT_RAPPEL > 19) ou
      ( COD_RAPPEL = 2 et MONT_RAPPEL > 19) ou
      ( COD_RAPPEL = 3 et MONT_RAPPEL > 19) ou
      ( COD_RAPPEL = 4 et MONT_RAPPEL > 19) ou
      ( COD_RAPPEL = 5 et MONT_RAPPEL > 19) ou
      ( COD_RAPPEL = 6 et MONT_RAPPEL > 19) ou
      ( COD_RAPPEL = 7 et MONT_RAPPEL > 19) ou
      ( COD_RAPPEL = 8 et MONT_RAPPEL > 19)
   )
alors erreur A019;
verif corrective horizontale 1401 :
application : iliad ;
si
    (
      COD_RAPPEL = 1401 et MONT_RAPPEL > 45 
     )
alors erreur A14001;
verif corrective horizontale 1411 :
application : iliad ;
si
    (
      COD_RAPPEL = 1411 et MONT_RAPPEL > 25 
     )
alors erreur A14101;
verif corrective horizontale 20200 :
application : iliad ;
si
  (
    COD_RAPPEL = 2020 et MONT_RAPPEL > 9

  )
alors erreur A00101;
