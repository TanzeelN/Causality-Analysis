# Causality-Analysis

Masters Thesis Project 

Title: Applying Information Theoretic Models for fNIRS brain causality analysis

This project is based on a surgical neuroergonomics dataset[] to performed effective connectivity analysis.

The models utilised are:
- Transfer Entropy[]
- Mutual Information
- Grangers Causality[]


What is contained in this repository:
- Pipeline: A complete data pipeline to input raw fNIRS data, execute the models and output results with statistical analysis. (Documentation within folder is provided)
- Experiments and Raw Results: The datasets which were fed into the pipeline with all the raw results provided.
- Synthetic Data Generation: Synthetic fNIRS brain data was generated to test the validity of the models.
- Toolboxes: The brain analysis toolboxes necessary to utilise the pipeline.
- Demo: Examples on how to utilise the pipeline to perform causality analysis.


The master's thesis can be viewed here to get a better understanding on how to use the toolkit, the methodology employed and the results found. The Appendix X gives a more thorugh explanation on how to execute the demo files.



References (incluces the original research papers for the toolkits utilised):

[1 Felipe Orihuela Espina (2021). GCRF (https://github.com/forihuelaespina/GCRF) Retrieved September 12, 2022.
[1 Felipe Orihuela Espina (2020). SciMeth (https://github.com/forihuelaespina/SciMeth) Retrieved September 12, 2022.
[3 Chandler (2022). Granger Causality Test (https://www.mathworks.com/matlabcentral/fileexchange/25467-granger-causality-test), MATLAB Central File Exchange. Retrieved September 12, 2022.
[4 Stephen23 (2022). Natural-Order Filename Sort (https://www.mathworks.com/matlabcentral/fileexchange/47434-natural-order-filename-sort), MATLAB Central File Exchange. Retrieved September 12, 2022.
[5	M. Lindner, R. Vicente, V. Priesemann, and M. Wibral, ‘TRENTOOL: A Matlab open source toolbox to analyse information flow in time series data with transfer entropy’, BMC Neurosci., vol. 12, no. 1, p. 119, Dec. 2011, doi: 10.1186/1471-2202-12-119.
[6	R. Oostenveld, P. Fries, E. Maris, and J.-M. Schoffelen, ‘FieldTrip: Open Source Software for Advanced Analysis of MEG, EEG, and Invasive Electrophysiological Data’, Comput. Intell. Neurosci., vol. 2011, pp. 1–9, 2011, doi: 10.1155/2011/156869.
[7 Huppert, T. J., Diamond, S. G., Franceschini, M. A., & Boas, D. A. (2009). HomER: a review of time-series analysis methods for near-infrared spectroscopy of the brain . Appl Opt, 48(10), D280–D298. https://doi.org/10.1364/ao.48.00d280
[8]A. von Lühmann, X. Li, N. Gilmore, D. A. Boas, and M. A. Yücel, ‘Open Access Multimodal fNIRS Resting State Dataset With and Without Synthetic Hemodynamic Responses’, Front. Neurosci., vol. 14, p. 579353, Sep. 2020, doi: 10.3389/fnins.2020.579353.
