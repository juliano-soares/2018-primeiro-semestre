# -*- coding: utf-8 -*-
"""
Created on Fri Jul 13 15:01:32 2018

@author: juliano leonardo soares
"""
import csv
import math


"""
os dados para testes dados pelo professor são estes 
caso queira mudar o teste mude os valores respectivamente
ex1.csv Ttab = 1.985 Xt = 900
ex2.csv Ttab = 1.96  Xt = 350
"""
Ttab = 1.985
Xt = 900
arq = open('ex1.csv', 'r')

try: 
    leitor = csv.reader(arq)
       
    """
        SEPARA A TABELA EM DUAS COLUNAS A X E Y
    """
    X = []
    Y = []
    for linha in leitor:
        X.append(float(linha[0]))
        Y.append(float(linha[1]))

    """
        NUMERO DE ELEMENTOS
    """ 
    n_elementos = 0
    for linha in X:
        n_elementos = n_elementos + 1

    """
        SOMATORIO COLUNA X
    """
    soma_X = 0
    for i in X:
        soma_X = soma_X + i

    """
        SOMATORIO COLUNA Y
    """
    soma_Y = 0
    for i in Y:
        soma_Y = soma_Y + i

    """
        SOMATORIO COLUNA XY
    """
    aux1 = X
    aux2 = Y
    soma_XY = 0
    vet_XY = []
    for j in range(n_elementos):
        vet_XY.append(aux1[j] * aux2[j])
    
    for i in vet_XY:
        soma_XY = soma_XY + i
        
    """
        SOMATORIO COLUNA X^2
    """
    X_quad = []
    soma_X_quad = 0 
    for i in X:
        X_quad.append(i * i)
        
    for i in X_quad:
        soma_X_quad = soma_X_quad + i
        
    """
        SOMATORIO COLUNA Y^2
    """
    Y_quad = []
    soma_Y_quad = 0 
    for i in Y:
        Y_quad.append(i * i)
    for i in Y_quad:
        soma_Y_quad = soma_Y_quad + i
        
    """
        (SOMATORIO COLUNA X) ^2
    """
    soma_QUAD_X = soma_X * soma_X
    
    """
        (SOMATORIO COLUNA Y) ^2
    """
    soma_QUAD_Y = soma_Y * soma_Y
    
    """
        CORRELAÇÂO LINEAR
    """
    Sxy = (soma_XY - ((soma_X * soma_Y)/n_elementos))
    Sxx = (soma_X_quad - (soma_QUAD_X/n_elementos))
    Syy = (soma_Y_quad - (soma_QUAD_Y/n_elementos))
    
    correlacao_linear = Sxy / ( math.sqrt(Sxx) * math.sqrt(Syy)) 

    print("\nCOEFICIENTE DE CORRELAÇÂO LINEAR:")
    print(correlacao_linear)
    
    """
        MEDIA DE X E Y
    """
    media_X = soma_X/n_elementos
    media_Y = soma_Y/n_elementos
    
    """
        Σ (Xi - X')
    """
    soma_X_menos_media = 0
    X_menos_media = []
    for i in X:
        X_menos_media.append(i - media_X)
    for i in X_menos_media:
         soma_X_menos_media =  soma_X_menos_media + i 
         
    """
        Σ (Yi - Y')
    """
    
    soma_Y_menos_media = 0
    Y_menos_media = []
    for i in Y:
        Y_menos_media.append(i - media_Y)
    for i in Y_menos_media:
         soma_Y_menos_media =  soma_Y_menos_media + i 
    
    """
    questão b 
    
    -Ttab < t0 < Ttab    
    a = 0.05 e v = n-2
    """
    t0 = correlacao_linear * (math.sqrt( (n_elementos - 2) / (1 - (correlacao_linear * correlacao_linear))))
    print("\nTeste de hipóteses para o coeficiente de correlacão:")    
    if t0 < Ttab and -Ttab < t0 :
        print("ACEITA H0")
    else:
        print("REJEITA H0")

    """
    questão c 
    
    ˆb1
    """
    b1_MQO = (Sxy /Sxx)
    """
    ˆb0
    """
    b0_MQO = (media_Y - (b1_MQO * media_X))
    print("\nEstimadores de mínimos quadrados ordinários para regressão (ˆb0 e ˆb1):") 
    print('b0 = ', b0_MQO)
    print('b1 = ', b1_MQO)
    
    """
    questão e
    
    """
    S = (Syy - (correlacao_linear * Sxy)) / (n_elementos - 2)
    Tc = correlacao_linear * (math.sqrt(abs(Sxx/S)))
    print("\nTeste de hipóteses para significância da regressão (testar se b1 = 0):") 
    if Tc < Ttab and Tc > -Ttab:    
        print("ACEITA H0")
    else:
        print("REJEITA H0")
    
    """
    questão d
    
    """ 
    Yt = (b0_MQO + (b1_MQO*Xt))
    print("Variância estimada de Y considerando que a média de Y não é constante e depende deX:")
    print(Yt)
    
finally:
    arq.close()
    
 






