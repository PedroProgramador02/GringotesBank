programa
{
	inclua biblioteca Util --> U
	cadeia option = "", senhas[101], nomes[101], nome = ""
	real saldo[101]
	inteiro codVetor[101], cod, optionNum = 0
	inteiro i = 0, cont = 0
	funcao inicio()
	{
		escreva("Seja bem vindo ao Banco GRINGOTES\n")
		escreva("Temos ", cont , " bruxos cadastrados como nossos clientes!\n\n")
		//Menu
		escreva("1) Cadastrar Cliente\n")
		escreva("2) Ver saldo\n")
		escreva("3) Realizar Saque\n")
		escreva("4) Realizar Depósito\n")
		escreva("5) Listar Clientes\n")
		escreva("0) Sair\n")
		escreva("Escolha uma opção: ")
		leia(optionNum)
			escolha(optionNum){
			caso 1:cadastro()
			pare
			caso 2: verSaldo()
			pare
			caso 3: realizarSaque()
			pare
			caso 4: realizarDeposito()
			pare
			caso 5: listaClientes()
			pare
			caso 0: limpa()
			escreva("--------------------------------------------------------\n\t")
			escreva("OBRIGADO POR ACESSAR O SISTEMA!")
			escreva("\t\n--------------------------------------------------------\n\n")
			escreva("created for: @pedrobiel.png\n\n")
			pare
			caso contrario: limpa()
			escreva("O valor digitado é inválido!\n")
			escreva("--------------------------------------------------------\n\n")
			inicio()
			}
	}

	funcao cadastro(){
	//Cadastro de nome, senha, saldo inicial e código de acesso/posição
	cadeia senha = ""
	real saldo1
	limpa()
		se(i < 101){
			i = cont
			i = i++
			escreva("-------------------------- CADASTRO --------------------------\n")
			escreva("Informe nome do novo cliente: ")
			leia(nome)
			nomes[i] = nome
			escreva("\nInforme uma senha para o cliente ", nome, ": ")
			leia(senha)
			senhas[i] = senha
			escreva("\nInforme saldo inicial (valor mínimo de R$50,00) do cliente ", nome, ": ")
			leia(saldo1)

				//O saldo inicial deve ser de 50.00
				se(saldo1 >= 50.00){
					saldo[i] = saldo1
				}
				senao{
					enquanto(saldo1 < 50.00){
						limpa()
						escreva("Pegue seus R$", saldo1, " de volta!\n")
						escreva("O depósito inicial deve ser de no mínimo R$50,00.\n\n")
						escreva("Digite se você deseja\n")
						escreva("(1) Cancelar o cadastro\n")
						escreva("(2) Depositar uma quantia maior\n ")
						leia(optionNum)
							escolha(optionNum){
								caso 1:
									limpa()
									i = i--
									inicio()
								caso 2:
									escreva("\nInforme saldo inicial do cliente ", nome, ": ")
									leia(saldo1)
									saldo[i] = saldo1
							}
						}
					}

			//CONFIRMAÇÃO DO CADASTRO
			escreva("\nConfirmar cadastro do cliente ", nome, " com saldo inicial de R$", saldo1, "?\n")
			escreva("| s-sim | n-não |: ")
			leia(option)
				se(option == "s"){
					//Cadastro efetuado
					cod = U.sorteia(10000, 99999)
					codVetor[i] = cod //Código de acesso
					escreva("\nCadastro efetuado com sucesso!\n")
					escreva("Número da conta do cliente ", nome, " é ", cod, "\n\n--------------------------------\n")
					cont = i
					inteiro return = 0
						escreva("Digite\n(1) Voltar para o Menu Inicial: ")
						leia(return)
						se (return == 1){
							limpa()
							inicio()
						}
					//1° fim cadastro efetuado
				}
				senao se(option == "n"){
					//Reiniciar o cadastro
					escreva("\nDigite\n(1) Para reiniciar o cadastro")
					escreva("\n(2) Para voltar ao menu inicial\n ")
					leia(optionNum) //optionNum se trata das opções em inteiro
					escolha(optionNum){
						caso 1:
						i = i--
						cadastro()
						
						caso 2:
						i = i-- /*Retorna para o iniciar com dados preenchidos exceto o código
						          Isso é importante, pois, buscaremos a conta através
						          desse código, então o fato das outras variáveis estarem
						          preenchidas é irrelevante, uma vez que não poderam ser
						          acessadas sem código*/
						inicio()
					}
				}
			}
	}
	funcao verSaldo(){
		//Verifica o saldo disponível
		inteiro comp = 0
		limpa()
		escreva("---------------------- SALDO DISPONÍVEL ----------------------\n")
		escreva("Digite o código da conta: ")
		leia(comp)
		inteiro pos = buscaConta(comp)
		se(pos > 0 e pos < 101){
			escreva("O saldo disponível é de R$", saldo[pos])
			//Tomar alguma ação
			escreva("\nVocê deseja\n")
			escreva("(1) Realizar Saque\n")
			escreva("(2) Realizar Depósito\n")
			escreva("(3) Voltar ao Menu Inicial\n ")
			leia(optionNum)
				escolha(optionNum){
					caso 1:
					limpa()
					realizarSaque2(pos)
					pare
					
					caso 2:
					limpa()
					realizarDeposito2(pos)
					pare
					
					caso 3:
					limpa()
					inicio()
					pare
				}
		}senao se(pos == -1){
			escreva("\nConta não encontrada no sistema :(")
			//Reiniciar o cadastro da informação
			escreva("\nDigite\n(1) Para digitar o código novamente")
			escreva("\n(2) Para voltar ao menu inicial\n ")
			leia(optionNum) //optionNum se trata das opções em inteiro
				escolha(optionNum){
					caso 1:
					limpa()
					verSaldo()
					pare
						
					caso 2:
					limpa()
					inicio()
					pare
				}
		}
	}
	funcao realizarSaque(){
		inteiro comp = 0
		real saque = 0.0
		limpa()
		escreva("---------------------- REALIZAR SAQUE ----------------------\n")
		escreva("Digite o código da conta: ")
		leia(comp)
		inteiro pos = buscaConta(comp)
		se(pos > 0 e pos < 101){
			escreva("\nInforme o valor do saque a ser realizado: ")
			leia(saque)
				se(saque <= saldo[pos]){
					//CONFIRMAÇÃO DO SAQUE
					escreva("\nConfirmar saque de R$", saque, " sob o saldo de R$", saldo[pos], "?\n")
					escreva("| s-sim | n-não |: ")
					leia(option)
						se(option == "s"){
							//Saque Efetuado
							saldo[pos] = saldo[pos] - saque
							escreva("\nO saldo atual é de R$", saldo[pos], "\n")
							escreva("--------------------------------\n\n")
							inteiro return = 0
							escreva("Digite\n(1) Voltar para o Menu Inicial: ")
							leia(return)
							se (return == 1){
								limpa()
								inicio()
							}
						}
						senao se(option == "n"){
							//Reiniciar o cadastro
							escreva("\nDigite\n(1) Para reiniciar o saque")
							escreva("\n(2) Para voltar ao menu inicial\n ")
							leia(optionNum) //optionNum se trata das opções em inteiro
							escolha(optionNum){
								caso 1:
								realizarSaque()
								
								caso 2:
								limpa()
								inicio()
								}
						}
				}
				senao{
					escreva("\nO seu saldo atual de R$", saldo[pos], " não é suficiente para realizar o saque de R$", saque, "!\n")
					//Reiniciar o cadastro da informação
					escreva("\nDigite\n(1) Para sacar um valor menor")
					escreva("\n(2) Para voltar ao menu inicial\n ")
					leia(optionNum) //optionNum se trata das opções em inteiro
						escolha(optionNum){
							caso 1:
							limpa()
							realizarSaque2(pos)
							pare
								
							caso 2:
							limpa()
							inicio()
							pare
							}
					}
			}
			senao se(pos == -1){
			escreva("\nConta não encontrada no sistema :(")
			//Reiniciar o cadastro da informação
			escreva("\nDigite\n(1) Para digitar o código novamente")
			escreva("\n(2) Para voltar ao menu inicial\n ")
			leia(optionNum) //optionNum se trata das opções em inteiro
				escolha(optionNum){
					caso 1:
					realizarSaque()
					pare
						
					caso 2:
					inicio()
					pare
				}
			}
	}
	funcao realizarDeposito(){
		inteiro comp = 0
		real deposito = 0.0
		limpa()
		escreva("---------------------- REALIZAR DEPÓSITO ----------------------\n")
		escreva("Digite o código da conta: ")
		leia(comp)
		inteiro pos = buscaConta(comp)
		se(pos > 0 e pos < 101){
			escreva("\nInforme o valor do depósito a ser realizado: ")
			leia(deposito)
				//CONFIRMAÇÃO DO DEPÓSITO
				escreva("\nConfirmar depósito de R$", deposito, " sob o saldo de R$", saldo[pos], "?\n")
				escreva("| s-sim | n-não |: ")
				leia(option)
					se(option == "s"){
						//Saque Efetuado
						saldo[pos] = saldo[pos] + deposito
						escreva("\nO saldo atual é de R$", saldo[pos], "\n")
						escreva("--------------------------------\n\n")
						inteiro return = 0
						escreva("Digite\n(1) Voltar para o Menu Inicial: ")
						leia(return)
						se (return == 1){
							limpa()
							inicio()
						}
					}
					senao se(option == "n"){
						//Reiniciar o cadastro
						escreva("\nDigite\n(1) Para reiniciar o depósito")
						escreva("\n(2) Para voltar ao menu inicial\n ")
						leia(optionNum) //optionNum se trata das opções em inteiro
						escolha(optionNum){
							caso 1:
							realizarDeposito()
								
							caso 2:
							limpa()
							inicio()
							}
					}
			}
			senao se(pos == -1){
			escreva("\nConta não encontrada no sistema :(")
			//Reiniciar o cadastro da informação
			escreva("\nDigite\n(1) Para digitar o código novamente")
			escreva("\n(2) Para voltar ao menu inicial\n ")
			leia(optionNum) //optionNum se trata das opções em inteiro
				escolha(optionNum){
					caso 1:
					realizarDeposito()
					pare
						
					caso 2:
					inicio()
					pare
				}
			}
	}
	
	funcao inteiro buscaConta(inteiro comp){
		inteiro pos = -1
			para(i = 0; i < 101; i++){
				se(codVetor[i] == comp){
					 pos = i
					 	pare
				}
			}
		retorne pos
	}
	funcao realizarSaque2(inteiro pos){
		//Realiza o Saque sem pedir novamente o código de acesso
		real saque = 0.0
		escreva("---------------------- REALIZAR SAQUE ----------------------\n")
		escreva("\nInforme o valor do saque a ser realizado: ")
			leia(saque)
			se(saque <= saldo[pos]){
				//CONFIRMAÇÃO DO SAQUE
					escreva("\nConfirmar saque de R$", saque, " sob o saldo de R$", saldo[pos], "?\n")
					escreva("| s-sim | n-não |: ")
					leia(option)
						se(option == "s"){
							//Saque Efetuado
							saldo[pos] = saldo[pos] - saque
							escreva("\nO saldo atual é de R$", saldo[pos], "\n")
							escreva("--------------------------------\n\n")
							inteiro return = 0
							escreva("Digite\n(1) Voltar para o Menu Inicial: ")
							leia(return)
							se (return == 1){
								limpa()
								inicio()
							}
						}
						senao se(option == "n"){
							//Reiniciar o cadastro
							escreva("\nDigite\n(1) Para reiniciar o saque")
							escreva("\n(2) Para voltar ao menu inicial\n ")
							leia(optionNum) //optionNum se trata das opções em inteiro
							escolha(optionNum){
								caso 1:
								realizarSaque()
								
								caso 2:
								limpa()
								inicio()
								}
						}
			}
			senao{
				escreva("\nO seu saldo atual de R$", saldo[pos], " não é suficiente para realizar o saque de R$", saque, "!\n")
				//Reiniciar o cadastro da informação
				escreva("\nDigite\n(1) Para sacar um valor menor")
				escreva("\n(2) Para voltar ao menu inicial\n ")
				leia(optionNum) //optionNum se trata das opções em inteiro
					escolha(optionNum){
						caso 1:
						limpa()
						realizarSaque2(pos)
						pare
							
						caso 2:
						limpa()
						inicio()
						pare
						}
				}
	}
	funcao realizarDeposito2(inteiro pos){
		//Realiza o Saque sem pedir novamente o código de acesso
		real deposito = 0.0
		escreva("---------------------- REALIZAR DEPÓSITO ----------------------\n")
		escreva("\nInforme o valor do depósito a ser realizado: ")
		leia(deposito)
		//CONFIRMAÇÃO DO DEPÓSITO
		escreva("\nConfirmar saque depósito de ", deposito, " sob o saldo de R$", saldo[pos], "?\n")
		escreva("| s-sim | n-não |: ")
		leia(option)
			se(option == "s"){
				//Saque Efetuado
				saldo[pos] = saldo[pos] + deposito
				escreva("\nO saldo atual é de R$", saldo[pos], "\n")
				escreva("--------------------------------\n\n")
				inteiro return = 0
						escreva("Digite\n(1) Voltar para o Menu Inicial: ")
						leia(return)
						se (return == 1){
							limpa()
							inicio()
						}
			}
			senao se(option == "n"){
				//Reiniciar o cadastro
				escreva("\nDigite\n(1) Para reiniciar o depósito")
				escreva("\n(2) Para voltar ao menu inicial\n ")
				leia(optionNum) //optionNum se trata das opções em inteiro
					escolha(optionNum){
						caso 1:
						realizarDeposito2(pos)
								
						caso 2:
						limpa()
						inicio()
					}
			}
	}
	funcao listaClientes(){
		limpa()
		escreva("-----------------------------------------------\n")
		escreva("CÓDIGOS DE ACESSO\tNOMES\n\n")
		nomes[0] = ""
		para(i = 0; i < 101; i++){
			se(nomes[i] != ""){
				escreva(codVetor[i], "\t\t\t", nomes[i] , "\n")
			}
		}
		inteiro return = 0
		escreva("-----------------------------------------------\n")
		escreva("\nDigite\n(1) Voltar para o Menu Inicial: ")
		leia(return)
		se (return == 1){
			limpa()
			inicio()
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1198; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = {nomes, 4, 34, 5}-{saldo, 5, 6, 5}-{codVetor, 6, 9, 8};
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */