# -*- coding: utf-8 -*-
"""
Created on Wed Apr 25 13:16:21 2018

@author: juliano leonardo soares
algoritmo detectar cores nas imagens
objetivos:
detectar cores primarias: verde, vermelho, azul, amarelo, branco, preto


"""

import cv2
import numpy as np

# abrir imagem 
img = cv2.imread('image.png')
hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

# niveis das cores
# vermelho
lower_range = np.array([0, 0, 180])
upper_range = np.array([255, 255, 260])
# verde
lower_range1 = np.array([0, 100, 0])
upper_range1 = np.array([255, 170, 255])
# azul
lower_range2 = np.array([89, 0, 0])
upper_range2 = np.array([125, 255, 255])
# amarelo
lower_range3 = np.array([18, 0, 196])
upper_range3 = np.array([36, 255, 255])

# maskaras para separar cores da imagem original
mask = cv2.inRange(hsv, lower_range, upper_range)
mask1 = cv2.inRange(hsv, lower_range1, upper_range1)
mask2 = cv2.inRange(hsv, lower_range2, upper_range2)
mask3 = cv2.inRange(hsv, lower_range3, upper_range3)

# janelas para mostrar o que foi feito
cv2.imshow('image original', img)
cv2.imshow('apenas o vermelho', mask)
cv2.imshow('apenas o verde', mask1)
cv2.imshow('apenas o azul', mask2)
cv2.imshow('apenas o amarelo', mask3)

# para parar execução aperte " Esc "
while(True):
    k = cv2.waitKey(5) & 0xFF
    if k == 27:
        break
 
cv2.destroyAllWindows()