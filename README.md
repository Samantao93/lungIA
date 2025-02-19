# lungIA

## Installed versions
- **Python:** 3.12.8
    - **Packages:** installed_versions.txt file
- **R:** 4.4.2
    -  **TCGAbiolinks:** 2.32.0
    -  **SummarizedExperiment:** 1.34.0
    -  **dplyr:** 1.1.4
## Data
Data download from The Cancer Genome Atlas Program (TCGA). Projects: LUAD and LUSC (tcga.R script)

## Steps
- Create necessary directories and arrays
- Read .svs images
- Convert to NumPy Arrays
- Resize images to Uniform Size (AdaptiveAvgPool2d)
- Calculate global chromatic average
- Normalized Colors and Images
- Save normalized images as PNG
- Display Original Images (format: SVS)
- Displat Normalized Images (format: PNG)
