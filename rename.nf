#!/usr/bin/env nextflow


if (params.help) { exit 0, helpMSG() }

    if (!params.csv && !params.barcode_dir){
    exit 1, "input missing,use [--csv]"
    }

csv_ch = Channel  .fromPath( params.csv, checkIfExists: true)
                        .map { file -> tuple(file.baseName, file) }
                        .view()

where_are_the_barcodes_ch = Channel  .fromPath( params.barcode_dir, checkIfExists: true)
                                     .view()


process rename_folder {

    input:
    tuple val(name), file(csv) from csv_ch
    path(barcode_dir) from where_are_the_barcodes_ch

    script:
    """
    cd ${barcode_dir} && \

    while IFS=, read orig new; do mv "\$orig" "\$new"; done < ${csv} 

    """
}




/*************  
* --help
*************/
def helpMSG() {

    c_blue = "\033[0;36m";
    c_light_magenta = "\033[0;95m";
    c_reset = "\033[0m";

    log.info """
    .
    ${c_light_magenta}how to use this rename-of-the-barcode-folders-pipeline:${c_reset}
    nextflow run rename.nf --csv '*/*.csv' --'path/to/barcode_dir'

    how should your .csv look like

    ${c_blue} barcode01,your_sample_name ${c_reset} 
    ${c_blue} barcode02,your_sample_name ${c_reset} 
    ${c_blue} barcode03,your_sample_name ${c_reset} 
    ${c_blue} . ${c_reset} 
    ${c_blue} . ${c_reset} 
    ${c_blue} . ${c_reset} 
    
    """.stripIndent()
}