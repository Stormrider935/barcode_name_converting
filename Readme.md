# Rename your Barcode-folders with a csv-file

### what's happening?
* after bascalling with demultiplexing you get a folder-structure like this
 
```shell
barcode01
barcode02
barcode03
barcode04
.
.
.

```
* renaming them by yourself is time consuming but in the long run, it will save your time 
* prepare a .csv file like this

 
```shell
barcode01,your_sample_name
barcode02,your_sample_name
barcode03,your_sample_name
barcode04,your_sample_name
.
.
.

```
* execute the nextflow pipeline:
```shell
nextflow run rename.nf --csv '*/*.csv' --'path/to/barcode_dir'
```

#### Nextflow installation:
```shell
sudo apt-get update
sudo apt install -y default-jre
curl -s https://get.nextflow.io | bash 
sudo mv nextflow /bin/
```



