#!/usr/bin/env python
# coding: utf-8

# In[ ]:


# Código readaptado a partir del código de Víctor Gayoso Martínez (ITEFI-CSIC)
import sympy

def genera_q_omega(biN, biPrime, biLastPrime):
    biN = biN
    biPrime = biPrime
    biLastPrime = biLastPrime
    biUNO = 1
    biDOS = 2
    biOMEGA = None
    biPHI = None
    biTemp = None
    biTemp2 = None

#     print("DATOS:", biN, biPrime, biLastPrime)
    fin = False
    primer = True
    res = False

    while not fin:
        primer = True

        for i in range(2, biPrime + 1):
            biOMEGA = i
            biTemp = pow(biOMEGA, biN, biPrime)
            res = False

            if biTemp == biUNO:
                res = True

                for j in range(1, biN):
                    biTemp2 = j
                    biTemp = pow(biOMEGA, biTemp2, biPrime)
                    if biTemp == biUNO:
                        res = False
                        break

                if res:
                    res = False

                    for j in range(2, biPrime + 1):
                        biPHI = j
                        biTemp = pow(biPHI, biDOS, biPrime)

                        if biTemp == biOMEGA:
                            res = True
                            break

                    if res:
                        if primer:
#                             print("------------------------------------")
                            primer = False

#                         print("Q:", biPrime, "-> OMEGA:", biOMEGA, "PHI:", biPHI)
                        return (biPrime, biOMEGA, biPHI)

        biPrime = sympy.nextprime(biPrime)

        if biPrime > biLastPrime:
            fin = True

