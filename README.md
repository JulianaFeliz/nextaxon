# Nextaxon
Nextaxon é um pipeline Nextflow para análise inicial de processamento das sequências, focado em comunidades de Fungos Micorrizicos Arbusculares. 
  Este pipeline integra ferramentas como Mothur para processamento de sequências e MAFFT para alinhamento.

# Características

- Processamento de sequências paired-end
- Filtragem e limpeza de sequências
- Classificação taxonômica
- Alinhamento de sequências
- Detecção de quimeras
- Agrupamento de OTUs
- Geração de tabelas de OTUs compartilhadas

# Pré-requisitos

- [Nextflow](https://www.nextflow.io/) (v20.04.0 ou superior)
- [Docker](https://www.docker.com/) ou [Conda](https://anaconda.org/anaconda/conda) 

# Uso

Modifique o arquivo `nextflow.config` para especificar os caminhos dos seus arquivos de entrada e referência.
- `params.reads`: Caminho para os arquivos de leitura paired-end (ex: "/path/to/data/*_{1,2}.fastq")
- `params.outputdir`: Diretório de saída para os resultados
- `params.ref_1806DB_fasta`: Caminho para o arquivo de referência FASTA
- `params.ref_1806DB_tax`: Caminho para o arquivo de taxonomia de referência
- `params.ref_629_aln_cut`: Caminho para o arquivo de alinhamento de referência
