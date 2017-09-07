#*************************************************************************************************************************
#
#Copyright or � or Copr.[DGFIP][2017]
#
#Ce logiciel a �t� initialement d�velopp� par la Direction G�n�rale des 
#Finances Publiques pour permettre le calcul de l'imp�t sur le revenu 2012 
#au titre des revenus percus en 2011. La pr�sente version a permis la 
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
verif corrective horizontale 760 :
application : oceans, iliad ;
si          (
            V_IND_TRAIT > 0
	    et
            SENS_RAPPEL non dans (1, 2, 3, 4)
	    )
alors erreur A760;
verif corrective horizontale 770 :
application : oceans, iliad ;
si          (
            V_IND_TRAIT > 0
	    et
            SENS_RAPPEL = 4 
	    et 
            PEN_RAPPEL non dans (07, 08, 09, 10, 11, 12, 17, 18, 31)
	    )
alors erreur A770;
verif corrective horizontale 780 :
application : oceans, iliad ;
si
 (
            V_IND_TRAIT > 0
	    et
	    (
            ANNEE_RAPPEL <= V_ANREV
            ou
            MOIS_RAPPEL non dans ( 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 )
	    )
 )

alors erreur A780;
