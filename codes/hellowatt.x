/*
* @author 1 : Akram ALNEZAMI
* @author 2 : Lenaïc Love HOUNLEBA
* @file : hellowatt.x
*/

/* --- Structures pour les arguments multiples --- */
struct auth_creds {
    char email[200];
    char mdp[30];
};

struct update_new_mdp {
    char email[200];
    char new_mdp[30];
};

struct update_new_tele {
    char email[200];
    char new_tele[20];
};

struct alerte_journaliere {
    char email[200];
    float valeur_max;
};

/* Pour lier une requete mensuelle a un utilisateur */
struct requete_mois {
    char email[200];
    int mois;
    int annee;
};

/* Pour lier une requete annuelle a un utilisateur */
struct requete_annee {
    char email[200];
    int annee;
};

/* Pour lier une requete journaliere a un utilisateur */
struct requete_jour {
    char email[200];
    int jour;
    int mois;
    int annee;
};

/* Pour lier une alerte mensuelle a un utilisateur */
struct alerte_mensuelle {
    char email[200];
    float valeur_max;
};

/* Pour lier une alerte tension a un utilisateur */
struct alerte_tension {
    char email[200];
    int actif;
};

/* Pour lier un numero PDL a un utilisateur */
struct pdl_arg {
    char email[200];
    char numero_pdl[30];
};


/* --- Structures de donnees principales --- */
struct client {
    char cl_nom[80];
    char cl_prenom[80];
    char cl_email[200];
    char cl_tele[20];
    char cl_mdp[30];
};

struct logement {
    char log_email[200];
    char log_addr[500];
    float log_surface;
    char log_type[50];
    char log_structure[50];
};

struct energie {
    char en_email[200];
    char en_type_cuisson[50];
    char en_type_chauffage[50];
};

/* consommation par jour par utilisateur */
struct consommation {
    char cons_email[200];
    int cons_jour;
    int cons_mois;
    int cons_annee;
    float cons_euros;
    float cons_kwh;
    float cons_co2;
};

struct usage_result {
    char us_email[200];
    float us_chauffage;
    float us_cuisson;
    float us_eclairage;
    float us_electromenager;
    float us_autres;
};

struct comparaison {
    char cmp_email[200];
    float cmp_ma_conso;
    float cmp_moyenne_region;
};

program HELLOWATT_PROG {
    version HELLOWATT_VERS {
        /* --- SCENARIO 1 : LENAIC --- */
        int CREER_COMPTE(client) = 1;
        int SE_CONNECTER(auth_creds) = 2;
        int UPDATE_MDP(update_new_mdp) = 3;
        int UPDATE_TELE(update_new_tele) = 4;
        int SAISIR_CARACTERISTIQUES_LOG(logement) = 5;
        int SAISIR_SOURCE_ENERGIE(energie) = 6;
        consommation OBTENIR_CONSOMMATION_PAR_MOIS(requete_mois) = 7;
        comparaison COMPARER_CONSOMMATION(requete_mois) = 8;
        int CONFIG_ALERT_MAX_DEPENSE_PAR_MOIS(alerte_mensuelle) = 9;
        int SUPPRIMER_COMPTE(auth_creds) = 10;

        /* --- SCENARIO 2 : AKRAM (Fonctions additionnelles) --- */
        consommation OBTENIR_CONSOMMATION_PAR_ANNEE(requete_annee) = 11;
        consommation OBTENIR_CONSOMMATION_PAR_JOUR(requete_jour) = 12;
        usage_result AFFICHER_USAGES(requete_mois) = 13;
        int SAISIR_NUMERO_PDL(pdl_arg) = 14;
        int CONFIG_ALERT_MAX_DEPENSE_PAR_JOUR(alerte_journaliere) = 15;
        int CONFIG_ALERT_TENSION_RESEAU(alerte_tension) = 16;
        int SE_DECONNECTER(auth_creds) = 17;
    } = 1;
} = 0x20000001;
