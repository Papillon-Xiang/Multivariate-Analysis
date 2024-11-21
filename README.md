# Multivariate-Analysis
## Result of Bone vs Ocular 
| features              | IOP (left)      $\downarrow$            | Sup-Inf| Pigment Layer(left) $\downarrow$ | Density $\downarrow$ | sumEC $\uparrow$| PECAMtr $\uparrow$ |
|---------------------  |----------                   |----------------|--------------|--------------------|--------------------|--------------------|
|trabecular separation $\uparrow$  |-0.26 $\rightarrow$ 0.02 $\textcolor{red}{\uparrow}$ | -0.17 $\rightarrow$ -0.14  $\textcolor{red}{\uparrow}$      |-0.18 $\rightarrow$ 0.04  $\textcolor{red}{\uparrow}$    |0.43 $\rightarrow$ 0.26 $\textcolor{blue}{\downarrow}$  |0.54 $\rightarrow$ -0.04 $\textcolor{blue}{\downarrow}$| 0.53 $\rightarrow$ -0.09 $\textcolor{blue}{\downarrow}$|
| connective density  | -0.20 $\rightarrow$ -0.14  $\textcolor{red}{\uparrow}$  |-0.33 $\rightarrow$ 0.04  $\textcolor{red}{\uparrow}$      |-0.02 $\rightarrow$ -0.13 $\textcolor{blue}{\downarrow}$     |0.36 $\rightarrow$ 0.13    $\textcolor{blue}{\downarrow}$           |0.39 $\rightarrow$ 0.50 $\textcolor{red}{\uparrow}$|0.49 $\rightarrow$ 0.03 $\textcolor{blue}{\downarrow}$ |
| total perimeter    $\downarrow$    | 0.16 $\rightarrow$ 0.31 $\textcolor{red}{\uparrow}$ | 0.01 $\rightarrow$ 0.33 $\textcolor{red}{\uparrow}$ | -0.88 $\rightarrow$ 0.42 $\textcolor{red}{\uparrow}$     | 0.17 $\rightarrow$ -0.01 $\textcolor{blue}{\downarrow}$ |0.01 $\rightarrow$ -0.33 $\textcolor{blue}{\downarrow}$ |-0.61 $\rightarrow$ 0.03 $\textcolor{red}{\uparrow}$ |


## Result of Bone vs Muscle
| features              |endocortical perimeter  $\downarrow$     | medullary area $\downarrow$| eccentricity | serine9 phosphorylated GSK3 $\beta$ content $\downarrow$| 
|---------------------  |----------                   |----------------|--------------|--------------------|
|GSK3 $\beta$ content $\downarrow$|-0.04 $\rightarrow$ 0.18 $\textcolor{red}{\uparrow}$ |  0.11 $\rightarrow$ 0.22 $\textcolor{red}{\uparrow}$ | -0.10 $\rightarrow$ 0.12 $\textcolor{red}{\uparrow}$       |-0.44 $\rightarrow$ 0.41 $\textcolor{red}{\uparrow}$   |


## Marginal Change 
| features              |endocortical perimeter  $\downarrow$     | medullary area $\downarrow$| eccentricity | serine9 phosphorylated GSK3 $\beta$ content $\downarrow$| 
|---------------------  |----------                   |----------------|--------------|--------------------|
|GSK3 $\beta$ content $\downarrow$|-0.04 $\rightarrow$ 0.18 $\textcolor{red}{\uparrow}$ |  0.11 $\rightarrow$ 0.22 $\textcolor{red}{\uparrow}$ | -0.10 $\rightarrow$ 0.12 $\textcolor{red}{\uparrow}$       |-0.44 $\rightarrow$ 0.41 $\textcolor{red}{\uparrow}$   |


## Marginal Change of Bone data (ground control - space flight)
| features              |variance change     | mean change| 
|---------------------  |----------                   |----------------|
|trabecular_separation_millimeter| 0.00014 decrease |  -0.011  increase  | 
|connective_density|-5.8e-09 increase  |  -3.9 e-05 increase | 
|total_perimeter_millimeter|0.025 decrease  |  0.36 increase | 
|endocortical_perimeter_millimeter|0.031 decrease  |  0.12 decrease |
|medullary_area_millimeter_squared|0.0017 decrease  |  0.046 decrease |
|eccentricity|0.0021 decrease  |  -0.00071 increase |
|serine9_phosphorylated_GSK3_beta_content_LSDS-70|6.8 decrease  |  1.9 decrease |



## Marginal Change of Ocular data (ground control - space flight)
| features              |variance change     | mean change| 
|---------------------  |----------                   |----------------|
|Avg_Left| 4 decrease |  0.95  decrease  | 
|connective_density|-5.8e-09 increase  |  -3.9 e-05 increase | 
|Sup-Inf|0.00072 decrease  |  -0.0038 increase | 
|Pigment Layer-left|1.3e-07 decrease |  0.0029 decrease |
|density (PNA-positve)|14967 decrease  |  302 decrease |
|sumEC|-61 increase  |  -4.5 increase |
|LSDS-5_immunostaining_microscopy_PECAMtr_TRANSFORMED_Average|-166 increase  |  -10 increase |
|LSDS-5_immunostaining_microscopy_Zo-1tr_TRANSFORMED_Average|18 decrease  |  8.8 decrease |

## Marginal Change of Muscle data (ground control - space flight)
| features              |variance change     | mean change| 
|---------------------  |----------                   |----------------|
|GSK3_beta_content| 1.1 decrease |  0.33  decrease  | 
|ratio_of_phosphorylated_serine_9_to_total_GSK3_beta_content__LSDS-68|-0.041 increase  |  -0.0042 increase | 
|mhc_iix|-7.2 increase  |  -4 increase | 

