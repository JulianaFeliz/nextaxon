#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { CLASSIFICATION } from './workflows/classification'

workflow {
    CLASSIFICATION()
}