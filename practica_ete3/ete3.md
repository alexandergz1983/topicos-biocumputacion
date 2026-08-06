# 1. ete3 full

## Probado y funcional mediante visual code y terminal bash. En positron no ha sido probado este flujo
## Primero revisamos:
  - conda env remove -n ete3

  - sudo apt install python3-pip

## Pasamos a crear el ambiente especificamente con estos comandos:

  - conda create -n ete3 python=3.6

  - conda activate ete3

  - pip install ete3

  - conda install -c etetoolkit ete3 ete_toolchain

  - ete3 build check

 - pip install nbconvert (para convertir un notebook a formato html)
