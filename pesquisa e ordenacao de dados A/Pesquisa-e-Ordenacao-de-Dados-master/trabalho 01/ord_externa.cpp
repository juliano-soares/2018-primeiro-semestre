#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <sstream>
#include <algorithm>
#include <numeric>
#include <ctime>
#include <locale.h>

using namespace std;

/// entradas do arquivo a ser ordenado
string entrada_file;
string saida_file;
int tamanho_pagina;
int bloco_memoria;
int conta_rodadas;

void tamanho_arquivo_saida();
void tamanho_arquivo_entrada();
void gerador_de_arquivo_alet();
void Gerador_Random_Txt_File (string ger_file_nome, int ger_file_tamanho);

int main()
{
    setlocale(LC_ALL,"");
	char escolha;
	cout << "-------------------------------------------------------\n";
	cout << "     Bem-vindo ao programa de classificação externa!\n";
	cout << "-------------------------------------------------------\n\n\n";
	/// caso o usuario queira gerar um arquico aleatorio
	cout << "Você gostaria de gerar um arquivo de texto aleatório? (y/n) ";
	cin >> escolha;
	if(escolha == 'y'){/// Gera arquivo de texto aleatório
	    gerador_de_arquivo_alet();
	}
	cout << "\n\nPara iniciar o procedimento de classificação externa, forneça as seguintes informações:\n";
	cout << "(1) Digite o nome do arquivo de entrada (incluindo extensão): ";
	cin >> entrada_file;
	cout << "(2) Digite o nome do arquivo de saída (incluindo extensão): ";
	cin >> saida_file;
	char escolha_tamanho_pagina;
	cout << "(3) O tamanho de página padrão é de 4 KB, você gostaria de alterá-lo? (y/n) ";
	cin >> escolha_tamanho_pagina;
	if(escolha_tamanho_pagina == 'y'){
		cout << "	- Digite o tamanho da página (em bytes): ";
		cin >> tamanho_pagina;
	}
	else if(escolha_tamanho_pagina == 'n'){
		tamanho_pagina = 1024*4;
	}
	else{
		cout << "	- Por favor, reinicie o programa e insira uma opção válida para o tamanho da página! " << endl;
	}
	cout << "(4) Digite o número de blocos de memória: ";
	cin >> bloco_memoria;
	/// Time:
	const clock_t begin_time = clock();
	int TOTAL_MEM = tamanho_pagina * bloco_memoria;
	ifstream inFile;
	inFile.open(entrada_file.c_str());
	/// Obtém o tamanho do arquivo
	inFile.seekg (0, inFile.end);
    int tamanho_entrada_arquivo = inFile.tellg();
    inFile.seekg (0, inFile.beg);
	cout << "O tamanho do arquivo escolhido é (em bytes): " << tamanho_entrada_arquivo << endl;
	/// Computa o número necessário de execuções
	if(tamanho_entrada_arquivo % TOTAL_MEM > 0)
		conta_rodadas = tamanho_entrada_arquivo/TOTAL_MEM + 1;
	else
		conta_rodadas = tamanho_entrada_arquivo/TOTAL_MEM;
    cout << "Dadas as restrições introduzidas, o número necessário de execuções para PASS0 0  é: " << conta_rodadas << endl;
	vector<string> carrega_nomes;
	string carrega_nome;
	for(int i = 0; i < conta_rodadas; i++){///crie nomes para as corridas de teto (N / B) que serão criadas posteriormente
		std::stringstream ss;
		ss << "run_" << i << ".txt";
		carrega_nome = ss.str();
		carrega_nomes.push_back(carrega_nome);
	}
	int tamanho_do_txt = 0;
	int carr_index = 0;
	ofstream outFile;
	string word;
	vector<string> data;
	/// Começa a ler o arquivo de entrada
	cout << "\n\n\n----------------------------------------\n";
	cout << "começando...\n";
	cout << "----------------------------------------\n\n\n";
	cout << "Nome do arquivo "<< entrada_file << " está sendo lido agora... " << endl;
	while(!inFile.eof())
    {
		/// enquanto o fim do arquivo NÃO foi atingido
		inFile >> word;
		if((tamanho_do_txt + word.size()) < TOTAL_MEM){
			data.push_back(word);
			tamanho_do_txt++;
			tamanho_do_txt += word.size();
		}
		else{
			sort(data.begin(), data.end());
			outFile.open(carrega_nomes[carr_index].c_str());/// criar arquivo de execução
			int tamanho_do_dado = data.size();
			for(int i = 0; i < (tamanho_do_dado- 1); i++){
				outFile << data[i];
				outFile << " ";
			}
			outFile << data[tamanho_do_dado - 1];
			outFile.close();/// fechar arquivo de execução
			data.clear();
			carr_index++;
			data.push_back(word);
			tamanho_do_txt = word.size();
		}
	}
	if(data.size() > 0){
		sort(data.begin(), data.end());
		outFile.open(carrega_nomes[carr_index].c_str());/// criar arquivo de execução
		int tamanho_do_dado = data.size();
		for(int i = 0; i < (tamanho_do_dado-1); i++)
		{
			outFile << data[i];
			outFile << " ";
		}
		outFile << data[tamanho_do_dado - 1];
		outFile.close();/// fechar arquivo de execução
		data.clear();
		carr_index++;
		tamanho_do_txt = 0;
	}
	inFile.close();
	/// inicialize o número de passadas futuras necessárias para loop mais tarde
	vector<int> vetor_de_passos;
	/// calcula as execuções futuras necessárias e armazena-as com nomes que serão utilizados no futuro:
    /// neste ponto, conta_rodadas runs foram criados no Pass 0
	int runs_countdown = conta_rodadas;
	int future_runs_num = 0;
	while(runs_countdown > (bloco_memoria-1)){
		if(runs_countdown % (bloco_memoria-1) > 0)
			runs_countdown = (runs_countdown/(bloco_memoria - 1)) + 1;
		else
			runs_countdown = runs_countdown/(bloco_memoria-1);
		vetor_de_passos.push_back(runs_countdown);
		future_runs_num += runs_countdown;
	}
	if(runs_countdown>1){
		future_runs_num++;
		vetor_de_passos.push_back(1);
	}
	/// TESTANDO A VER SE O NÚMERO DE PASSES E O NÚMERO DE CORRIDAS EM CADA PASSE ESTIVER CORRETO
	if(future_runs_num == 0){
		string oldname = carrega_nomes[0];
		string newname = saida_file;
		int result = rename( oldname.c_str() , newname.c_str() );
	}
	else{
		for(int i = conta_rodadas; i < conta_rodadas + future_runs_num; i++)
		{
			std::stringstream ss;
			ss << "run_" << i << ".txt";
			carrega_nome = ss.str();
			carrega_nomes.push_back(carrega_nome);
		}
		/// Renomeie o arquivo de execução final com o nome do arquivo inserido pelo usuário:
		carrega_nomes.pop_back();
		std::stringstream ss;
		ss << saida_file;
		carrega_nome = ss.str();
		carrega_nomes.push_back(carrega_nome);
	}
    /// Cada passe, exceto o último, gera muitas execuções
    /// cada corrida para ser gerado mescla (bloco_memoria - 1) execuções existentes
    /// cada execução existente tem que ter seus dados carregados na matriz, e pointer_indexes deve ser configurado para permitir a fusão
	int carrega_index_leitura = 0;
	int carrega_index_escrita = conta_rodadas;
	std::vector <int> ponteiro_inicio_index;
	std::vector <int> ponteiro_fim_index;
	string min_str; int min_index;	/// para a menor string
	int mem_bloco_esq;
	int begin;  /// no PASSo-1: begin = índice da primeira execução a ser lida e mesclada em carrega_nomes
	int end;    ///	end = índice da última execução a ser lido e mesclado em carrega_nomes
	int start;	///	start = índice da primeira execução das séries que estão sendo fundidas
	int bloco;
	for(int p = 0; p < vetor_de_passos.size(); p++) {
		begin = carrega_index_leitura;
		start = begin;
		end = carrega_index_escrita - 1;
		cout << "PASS0-" << p+1 << " é processado..." << endl;

		/// enquanto a passagem k está acontecendo, e séries de execuções estão sendo fundidas para gerar mais
		while(start <= end)
		{/// maior que ou igual a bloco_memoria - 1 corrida é deixada para ser mesclada
			if(((end+1)-start)/(bloco_memoria-1) >= 1)
				bloco = bloco_memoria - 1;
			else										// less than bloco_memoria - 1 runs are left to be merged
				bloco = ((end + 1) - start)%(bloco_memoria-1);
			start += bloco; /// incrementa começar de acordo para configurá-lo para o índice apropriado para a próxima vez

            /// -------------- carregando dados ---------------------
			int conta_palavra = 0;
			for(int i = 0; i < bloco ; i++)
			{
				inFile.open(carrega_nomes[carrega_index_leitura].c_str());
				ponteiro_inicio_index.push_back(conta_palavra);
				/// dos dados no bloco de memória i
				while(!inFile.eof())
				{
					inFile >> word;
					data.push_back(word);
					conta_palavra++;
				}
				ponteiro_fim_index.push_back(conta_palavra-1);
				inFile.close();
				carrega_index_leitura++;
			}
			/// --------------término de carregar dados ---------------------

			/// -------------- merging ---------------------
			outFile.open(carrega_nomes[carrega_index_escrita].c_str());
			int sum_start = std::accumulate(ponteiro_inicio_index.begin(), ponteiro_inicio_index.end(),0);	// sum of elements in ponteiro_inicio_index
			int sum_end = std::accumulate(ponteiro_fim_index.begin(), ponteiro_fim_index.end(),0);			// sum of elements in ponteiro_fim_index
			int atual_ponteiro_index;
			while(sum_start != sum_end)
			{/// SE TODOS OS SEGMENTOS DE DADOS NÃO TENHAM SIDO INCORPORADOS
				atual_ponteiro_index = 0;
				/// Enquanto os vetores ponteiro_inicio_index e ponteiro_fim_index têm o mesmo valor para o atual_ponteiro_index, incremente-o
				while(ponteiro_inicio_index[atual_ponteiro_index] == ponteiro_fim_index[atual_ponteiro_index])
					atual_ponteiro_index++;
				/// ESTE SEGMENTO DE DADOS NÃO FOI ITERADO ATRAVÉS DELE
				min_str = data[ponteiro_inicio_index[atual_ponteiro_index]];
				min_index = atual_ponteiro_index;
				while(atual_ponteiro_index < ponteiro_inicio_index.size())
				{
					if(ponteiro_inicio_index[atual_ponteiro_index] == ponteiro_fim_index[atual_ponteiro_index])
						atual_ponteiro_index++;
					else if(min_str.compare(data[ponteiro_inicio_index[atual_ponteiro_index]]) > 0)
					{
						min_str = data[ponteiro_inicio_index[atual_ponteiro_index]];
						min_index = atual_ponteiro_index;
						atual_ponteiro_index++;
					}
					else
						atual_ponteiro_index++;
				}
				outFile << min_str;
				outFile << " ";
				ponteiro_inicio_index[min_index] = ponteiro_inicio_index[min_index] + 1;
				sum_start++;
			}
			outFile.close();
			carrega_index_escrita++;
			data.clear();
			ponteiro_inicio_index.clear();
			ponteiro_fim_index.clear();
            /// -------------- FIM merging---------------------

		}
		cout << "PASSO-" << p+1 << " agora está completo!" << endl << endl;
	}
	cout << endl;

	/// Fim do tempo
	cout << "Todo o processo levou um total de: " << float(clock() - begin_time) / CLOCKS_PER_SEC * 1000 << " msec." << endl;

    tamanho_arquivo_entrada();
    tamanho_arquivo_saida();

    cout << "\n\n\n\n\n----------FIM DO PROGRAMA FOI ALCANÇADO----------" << endl;
	return 0;
}

void gerador_de_arquivo_alet(){
    string ger_file_nome; int ger_file_tamanho;
    cout << "\n(1) Digite o nome do arquivo (incluindo a extensão): ";
    cin >> ger_file_nome;
    cout << "(2) Digite o tamanho do arquivo (em bytes) a ser gerado: ";
    cin >> ger_file_tamanho;
    Gerador_Random_Txt_File(ger_file_nome, ger_file_tamanho);
}

void tamanho_arquivo_entrada(){
    /// Tamanho do arquivo de entrada:
    ifstream inFile;
	inFile.open(entrada_file.c_str());
	inFile.seekg (0, inFile.end);
    int tamanho_file = inFile.tellg();
    inFile.seekg (0, inFile.beg);
	cout << "O tamanho do arquivo de entrada, " <<  entrada_file << ", é: " << tamanho_file << " bytes." << endl;
	inFile.close();
}

void tamanho_arquivo_saida(){
    /// Tamanho do arquivo de saída:
    ifstream inFile;
	inFile.open(saida_file.c_str());
	inFile.seekg (0, inFile.end);
    int tamanho_file = inFile.tellg();
    inFile.seekg (0, inFile.beg);
	cout << "O tamanho do arquivo de saída, " <<  saida_file << ", é: " << tamanho_file << " bytes." << endl;
	inFile.close();
}

void Gerador_Random_Txt_File (string ger_file_nome, int ger_file_tamanho){
	// abre arquivo
	ofstream meu_arquivo;
	meu_arquivo.open(ger_file_nome.c_str());
	int total_tamanho_maior = 0;
	int tamanho_palavra = 0;
	char letra;

	while(total_tamanho_maior < ger_file_tamanho)
	{
		tamanho_palavra = 1 + rand()%14; // random word length
		while(total_tamanho_maior + tamanho_palavra > ger_file_tamanho)
			tamanho_palavra = 1 + rand()%14;
		for(int j = 0; j < tamanho_palavra; j++)
		{
			letra = 'a' + rand()%26;
			meu_arquivo << letra;
		}
		total_tamanho_maior += tamanho_palavra;
		if(total_tamanho_maior + 1 < ger_file_tamanho)
		{
			meu_arquivo << ' ';
			total_tamanho_maior++;
		}
	}
	meu_arquivo.close();
	cout << "File " << ger_file_nome << " has been generated!" << endl;
}
