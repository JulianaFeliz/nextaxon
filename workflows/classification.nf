include { MOTHUR_ANALYSIS } from '../modules/local/mothur'
include { MAFFT_ALIGN } from '../modules/nf-core/mafft/align/main'

workflow CLASSIFICATION {
    // canais de entrada
    input_dir = Channel.fromFilePairs(params.inputdir, checkIfExists: true)
    output_dir = Channel.fromPath(params.outputdir)
    ref_1806DB_fasta = Channel.fromPath(params.ref_1806DB_fasta)
    ref_1806DB_tax = Channel.fromPath(params.ref_1806DB_tax)
    ref_629_aln_cut = Channel.fromPath(params.ref_629_aln_cut)

    input_dir.view()
    output_dir.view()

    // Executa análise Mothur
    MOTHUR_ANALYSIS(input_dir, output_dir, ref_1806DB_fasta, ref_1806DB_tax, ref_629_aln_cut)

    
    // Prepara inputs para MAFFT_ALIGN
    mafft_input = MOTHUR_ANALYSIS.out.rep_fasta.map { sample_id, fasta ->
        def meta = [id: sample_id]
        [ meta, fasta, [], [], [], [], [], false ]
    }


    // Executa alinhamento MAFFT nas sequências representativas
    MAFFT_ALIGN(MOTHUR_ANALYSIS.out.rep_fasta)
}