# 1. USANDO TU ORDENADOR PERSONAL

 * Descarga Miniconda segun tu version de Mac, linux (ubuntu) o windows si lo vas a hacer en tu ordenador personal.
 * luego hay que añadir los canales
  
   - conda config --add channels defaults
   - conda config --add channels bioconda
   - conda config --add channels conda-forge

 * Establecer prioridad estricta (¡Vital para evitar errores!)
   
   - conda config --set channel_priority strict

 * Opcional pero recomendado) Desactivar la activación automática del entorno base
   
   - conda config --set auto_activate_base false
   
 * Siempre es bueno opcion tener mamba instalado por si conda falla
  - conda install -n base -c conda-forge mamba


# 2. CREA TU PRIMER AMBIENTE

 * Usa por ejemplo:
 
   - conda create -n exploratorio
   - conda create --name exploratorio **python=3.9**
   - conda activate exploratorio
   - conda install conda-forge::ncbi-datasets-cli
   - conda install bioconda::entrez-direct
   - conda install bioconda::blast
   - conda install bioconda::trimal
   - conda install conda-forge::unzip
   - conda install bioconda::mafft
   - mamba install mafft
   - conda install bioconda::muscle
   - conda activate exploratorio
   - conda deactivate
   
# 3. PRIMEROS PASOS CON DATASET-CLIC NCBI

 - mkdir tuto-dataset-clic
 - cd tuto-dataset-clic
 - **exec:** datasets download gene symbol CYP8B1 --taxon human
 - **exec:** unzip ncbi_dataset.zip
 - **exec:** cd practica-dataset-clic/ncbi_dataset/data
 - **exec:** grep '>' rna.fna
 - **exec:** cd ../..
 - **exec:** rm ncbi_dataset.zip
 - **exec:** mv ncbi_dataset ncbi_dataset_1
 - **exec:** datasets download gene symbol CYP8B1 --ortholog all
 - **exec:** unzip ncbi_dataset.zip
 - **exec:** cd practica-dataset-clic/ncbi_dataset/data
 - **exec:** grep '>' rna.fna
 - **exec:** head -n 10 rna.fna
 - obtener una lista personalizada: **exec:** echo 'CYP8B1' > gene_list1.txt
 - anadir a la lista mas elementos: **exec:** echo "COA1" >> gene_list1.txt 
 - echo "PLGRKT" >> gene_list1.txt
 - ahora **exec:** datasets download gene symbol --inputfile gene_list1.txt --ortholog all --filename ortologos.zip
 - unzip ortologos.zip
 
 - **exec:**
 - tree ncbi_dataset/  
   ncbi_dataset/  
   └── data  
       ├── data_report.jsonl  
       ├── dataset_catalog.json  
       ├── protein.faa  
       └── rna.fna  

   2 directories, 4 files
  - vemos que la busqueda esta toda mezclada en los .faa y ,fna, esto no es muy productivo, necesitamos un filtro que separe todo de golpe
  - **exec:** cat gene_list1.txt | while read GENE; do datasets download gene symbol "${GENE}" --ortholog all --filename "${GENE}".zip; done
  - Nos genera: COA1.zip PLGRKT.zip CYP8B1.zip
  - luego **exec:** cat gene_list1.txt | while read GENE; do unzip "${GENE}".zip -d "${GENE}"_gene; done
  - nos descomprime por carpeta:
  
  Archive:  CYP8B1.zip
   inflating: CYP8B1_gene/README.md   
   inflating: CYP8B1_gene/ncbi_dataset/data/rna.fna  
   inflating: CYP8B1_gene/ncbi_dataset/data/protein.faa  
   inflating: CYP8B1_gene/ncbi_dataset/data/data_report.jsonl  
   inflating: CYP8B1_gene/ncbi_dataset/data/dataset_catalog.json  
   inflating: CYP8B1_gene/md5sum.txt  
 Archive:  COA1.zip
  inflating: COA1_gene/README.md     
  inflating: COA1_gene/ncbi_dataset/data/rna.fna  
  inflating: COA1_gene/ncbi_dataset/data/protein.faa  
  inflating: COA1_gene/ncbi_dataset/data/data_report.jsonl  
  inflating: COA1_gene/ncbi_dataset/data/dataset_catalog.json  
  inflating: COA1_gene/md5sum.txt    
 Archive:  PLGRKT.zip
  inflating: PLGRKT_gene/README.md   
  inflating: PLGRKT_gene/ncbi_dataset/data/rna.fna  
  inflating: PLGRKT_gene/ncbi_dataset/data/protein.faa  
  inflating: PLGRKT_gene/ncbi_dataset/data/data_report.jsonl  
  inflating: PLGRKT_gene/ncbi_dataset/data/dataset_catalog.json  
  inflating: PLGRKT_gene/md5sum.txt
  
  
 * **OTRAS MANERAS DE CREAR AMBIENTES Y DE MANERA AUTOMATIZADA ES A PARTIR DE UN ARCHIVO YAML**
 
  - lo primero es un archivo enviroment.yml con una esta estructura basica, aunque puede ser aun mas compleja si lo queremos y lo requerimos:
  
  **EJM1:**
  
  name: exploratorio1

  channels:
    - conda-forge
    - bioconda
    - defaults

  dependencies:
    - python=3.9
    - ncbi-datasets-cli
    - unzip
    - mafft
    - muscle
   
   **EJM2: Si necesitas versiones exactas (reproducibilidad):**
   
   name: exploratorio2

   channels:
    - conda-forge
    - bioconda
    - defaults

  dependencies:
    - python=3.9.18
    - ncbi-datasets-cli=16.10.0
    - unzip=6.0
    - mafft=7.520
    - muscle=5.1
    
  **EJM3: YAML con Dependencias Mixtas (Conda + pip)**
  
  name: exploratorio3

  channels:
    - conda-forge
    - bioconda
    - defaults

  dependencies:
    - python=3.9
    - ncbi-datasets-cli
    - unzip
    - mafft
    - muscle
  
  # Paquetes de Python vía pip
    - pip
    - pip:
      - biopython>=1.83
      - pandas>=2.0
      - numpy>=1.24
      - ete3
* si queremos ver caracteristicas en formato tsv usamos:
  - **exec:** datasets summary gene symbol cyp8b1 --ortholog all --as-json-lines | dataformat tsv gene --fields tax-name,gene-id,symbol,group-id > cyp8b1.tsv
  - **exec:** head cyp8b1.tsv
  
* **TIPS**
 * **exec:** conda env create -f environment.yml **O CON MAMBA:** mamba env create -f environment.yml
 
 * **exec: Crear con nombre diferente al del YAML** conda env create -f environment.yml -n exploratorio_v2
 
 * **exec:** conda activate exploratorio2
 
 * **exec:** conda deactivate
 
 * **exec: Actualizar entorno existente (si editaste el YAML)** conda env update -f environment.yml --prune
 
 * **LISTAR ENTORNOS:** conda env list O conda info --envs
 
 * **ELMINAR ENTORNOS:** conda env remove -n exploratorio
  
 * **ELMINAR libreria desde dentro del ambiente:** conda remove muscle
  
 * **ELMINAR libreria sin desactivar el entorno actual:** conda remove -n exploratorio muscle
  
 * **ELMINAR librerias multiples:** conda remove -n exploratorio muscle unzip


 
 
 
 
