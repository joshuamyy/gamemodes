/*===============================================================
=																=
=	RPQuiz System - by Amir Fakhrudin (03/02/2018 - 18:14)	=
=																=
=================================================================*/

#include <YSI\y_hooks>

#define MAX_ANSWER_RPQUIZ	5

// ======================================== [Array list] =================================================
stock const g_arrRPQUIZQuestions[][] = {
    "Beberapa hal berikut dilarang digunakan ketika pembicaraan secara In-Character, Kecuali...",
    "Player yang sedang melakukan roleplay dengan cara mencampurkan hal OOC ke dalam IC, pasal apa yang dikenakan player tersebut?.",
    "Jika kamu bingungan dalam Server Legacy, apa yang kamu lakukan untuk menanyakan hal kepada Admin?",
    "Command apa yang dipergunakan untuk melihat Command yang ada di server?",
    "Anda sedang berada di sebuah tempat yang tidak diketahui, dibawah ini adalah tindakan yang boleh kalian lakukan, kecuali?",
    "Jumlah maksimal uang yang boleh dirampok dan ditipu adalah?",
    "Kamu tidak diperbolehkan keluar game disaat?",
    "Berikut ini adalah tindakan penyalahgunaan server feature, kecuali?",
    "Memberi informasi Out of Character menggunakan In-Character termasuk pasal?",
    "Apa yang dimaksud dengan Powergaming dalam roleplay?"
};


enum RPQUIZAnswer {
    QID,
    Answer[128],
    True
};

stock const g_arrRPQUIZAnswer[][RPQUIZAnswer] = {
    {0, "A, Penggunaan Emoji", false},
    {0, "B, Penggunaan Smiley", false},
    {0, "C, Pengunaan Aksen", true},

    {1, "A, Powergaming", false},
    {1, "B, Mixing", true},
    {1, "C, Metagaming", false},

    {2, "A, /report", false},
    {2, "B, /help", false},
    {2, "C, /ask", true},

    {3, "A, /menu", false},
    {3, "B, /help", true},
    {3, "C, /toggle", false},

    {4, "A, Mengeluarkan handphone dan menelpon Taxi untuk meminta jemputan", false},
    {4, "B, Menunggu Bus di Halte terdekat", false},
    {4, "C, Meminta jemputan kepada teman melalui /pm", true},

    {5, "A, $500 dan $1000", true},
    {5, "B, $1000 dan $2000", false},
    {5, "C, Semua jawaban benar.", false},

    {6, "A, Saat seseorang menodongkan senjata kepada saya.", true},
    {6, "B, Saat memarkirkan kendaraan", false},
    {6, "C, Saat bersantai bersama teman di SMB", false},

    {7, "A, Meminta jemputan melalui Private Message", false},
    {7, "B, Membawa kendaraan sidejobuntuk pergi ke suatu tempat tanpa mengikuti intruksi sidejob", false},
    {7, "C, Berlari tergesa- gesa ke lokasi sidejob lalu menyelesaikan sidejob sebanyak yang disediakan oleh server", true},

    {8, "A, Powergaming", false},
    {8, "B, Metagaming", true},
    {8, "C, Metagambling", false},

    {9, "A, Jalan melewati tangga menggunakan kendaraan", false},
    {9, "B, Punya kekuatan super", false},
    {9, "C, Suatu tindakan karakter yang tidak masuk akal didunia nyata", true}
};

// ===================================== [Static variable list] =============================================

static
	question_true[MAX_PLAYERS] = {0, ...},
	question_id[MAX_PLAYERS] = {-1, ...},
	question_alist[MAX_PLAYERS][3] = {0, ...},
	question_answered[MAX_PLAYERS] = {0, ...},
	question_list[MAX_PLAYERS][sizeof(g_arrRPQUIZQuestions)] = {-1, ...};


// ========================================== [Function list] ================================================

ShowRPQuiz(playerid)
{
    new
    	question_index,
    	count = -1,
        question_text[400];

    question_index = random(sizeof(g_arrRPQUIZQuestions));

    if(IsRPQuizInListed(playerid, question_index))
    	return ShowRPQuiz(playerid);

    question_id[playerid] = question_index;
    InsertRPQuiz(playerid, question_index);

    strcat(question_text, sprintf("%s\n", g_arrRPQUIZQuestions[question_index]));
    for(new answer = 0; answer != sizeof(g_arrRPQUIZAnswer); answer++) if(g_arrRPQUIZAnswer[answer][QID] == question_index)
    {
    	count++;

        question_alist[playerid][count] = g_arrRPQUIZAnswer[answer][True];
        strcat(question_text, sprintf("%s\n", g_arrRPQUIZAnswer[answer][Answer]));
    }
    Dialog_Show(playerid, RPQuizQuestions, DIALOG_STYLE_TABLIST_HEADERS, "Questions", question_text, "Select", "Close");
    return 1;
}

InsertRPQuiz(playerid, qid)
{
	for(new id = 0; id != sizeof(g_arrRPQUIZQuestions); id++) if(question_list[playerid][id] == -1)
	{
		question_list[playerid][id] = qid;
		return 1;
	}
	return 0;
}

IsRPQuizInListed(playerid, qid)
{
	for(new id = 0; id != sizeof(g_arrRPQUIZQuestions); id++) if(question_list[playerid][id] == qid) {
		return 1;
	}
	return 0;
}

ResetRPQUIZVariable(playerid)
{
	question_id[playerid] = -1;
	question_answered[playerid] = 0;
	question_true[playerid] = 0;

	for(new i = 0; i < sizeof(g_arrRPQUIZQuestions); i++)
	{
		if(i < 3) question_alist[playerid][i] = 0;
		question_list[playerid][i] = -1;
	}
	return 1;
}

// ========================================== [Dialog responds list] =============================================

Dialog:RPQuizQuestions(playerid, response, listitem, inputtext[])
{
    if(response)
    {
		if(question_alist[playerid][listitem]) question_true[playerid]++;

    	if(++question_answered[playerid] >= MAX_ANSWER_RPQUIZ)
    	{
    		if(question_true[playerid] >= MAX_ANSWER_RPQUIZ) CallLocalFunction("OnRPQuizPassedTest", "dd", playerid, 1);
    		else CallLocalFunction("OnRPQuizPassedTest", "dd", playerid, 0);

    		ResetRPQUIZVariable(playerid);
    		return 1;
    	}
    	ShowRPQuiz(playerid);
    }
    else ResetRPQUIZVariable(playerid), CallLocalFunction("OnRPQuizPassedTest", "dd", playerid, 0);
    return 1;
}

hook OnPlayerDisconnectEx(playerid)
{
    ResetRPQUIZVariable(playerid);
    return 1;
}
